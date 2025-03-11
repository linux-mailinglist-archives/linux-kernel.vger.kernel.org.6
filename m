Return-Path: <linux-kernel+bounces-556272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9369AA5C381
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44319177038
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833B825BAC6;
	Tue, 11 Mar 2025 14:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DonzDBUd"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7411125C714;
	Tue, 11 Mar 2025 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702409; cv=none; b=uMRgmrCjeh4rWACbxKjD5X8FsEymOgj3EomznhKcIcNDery0vP19KORlVeL+1lni4THRGUsC3rodTudOJHFq/fL8UCchcd2LMp6wnBud/hNPvBPdfXNe2IKtA94zKhJPos4mzxhUO5wBoHXiayxbP4BiTKLHb7nRJ3j37efxkN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702409; c=relaxed/simple;
	bh=llvOW0bBcJIDSKQQ5wQKAiogGziM8VntLYU7HA3+t+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8jy3oVaP0UwQBhDmM4Z6oVTebNZxCencDRkINN9dwNwONuHkVP3o/WcfAROIcHyoIbPtcsfSk1LGYbIOfxweT0tCR/Bp2JJnzooywHY0rdEGOS+hgNcAE7aakl8BW92THWlmlHe8YWiaZjJHBjQZyky1XNhIoVAi6xZZby4Li4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DonzDBUd; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fea8d8c322so10798760a91.2;
        Tue, 11 Mar 2025 07:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741702407; x=1742307207; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vMedfzunbXKnIyIbLa9JRvGembMzcmlTG+fcGqUIJ9s=;
        b=DonzDBUdz0So1Cg47zL7NPjjO8uWCLtW9yltpZqD7Xs4YDTZzpSBDHU1mWUV+xyPud
         +vFkhVGsVBUWSDjTF5uuLl46tDM7B6/KfXNsPnxHPCZOYiJMcHNO0CwpsS6gYXokasK3
         WO12PcmbCZRI/tkYp9KyEAwbSoZ2VbSl95D3dXNn2vG+BoBuLhZGk/+ajsVi6evMC84t
         HugZfpXE2/HnqI62pfAtXS611Jsdve7STjhWaN08mIJQ0b3J4sqafS7R0krb001gVGuw
         QJEFJe+tLyA7hYpqbdi4238ypsNOMs4hWJJ2g+e1Q4UQwWv2ylf8Vj0bS4QDtkEsupz4
         j2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741702407; x=1742307207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMedfzunbXKnIyIbLa9JRvGembMzcmlTG+fcGqUIJ9s=;
        b=AkFI+KybK4e47V9hzVWNg5DhLpBShsTh05NCDNZmVcwOlU364KeUE4iIgLWPiTzM5l
         1hqdaRaDGM3pJOMoaRARSJHSqMLddu5LD4sPYNiRetlGLiRrHC1NQwQQChYgjsbWZTs9
         C8GUI/IgkJ09Rk6P4D8zoA38ewUJSMDVKS6O2zQsLwGrlKA12Yeg2dE+8+3rogYVUenl
         aLh4Z7nYGYhq0T9QnKQy4we1KyMP9Z7ZgRXMT7DQJFWTQUMElBTb79q5YSdqiytxcL1q
         CUNE5IzxRrZFJfBfc4qRRKSwRyfvEL8Nrn/c4jpfyP3wSVGygtJ+AD7M3HmWpEFpYuiX
         a9tw==
X-Forwarded-Encrypted: i=1; AJvYcCVfiBuAYaB7EsBasUWHbPsKwwbMu18XgdnUExtM2sfSz4Fwp1hMrfqOlBsuhn9qwCpkOtL0n9dPA3g=@vger.kernel.org, AJvYcCWqn+ka8h+DveLhjepCRkg3CgO2zLrS6+vzfceBlEuGjuwLd2S7vqYEA+1JIOsN/EEsXCuZ5qVQxpN8aYbg@vger.kernel.org
X-Gm-Message-State: AOJu0YzqmnsJlCKQX6xWyYBASNIlYPROV5BnrmB85C2SgHdn9UcIozrH
	Uqj5WHwsoAaZk1KW2A1/Wq9AjM72Y4r3R+9LR33hK1J5JG3xPzUpLXgTTA==
X-Gm-Gg: ASbGnctr1KtUcHUCb5RZUbdOG7PcDvfY4X8eAHWB8GLKrc9Xskd552Li1A/03bVGxcY
	ppd87WVOVc+KIL/ivMFV7VNqmAmebw+whnvnFWt4NxXbstJgMj3gMA3R8Gm5X/fd0SKk/16tPOm
	bFeJIpMrwgoK7rpQLyG026uabzcl9cSRYHNjMIKxVJ0r6RLlYRjqMzZ3zg6lpFAz6j55/G6OgGN
	5TIwEpBZWc7tbFAe1XMtqPu47wTFQoSprO1SCCRZZIn7eEx9v7R1gSRAAceMBlh4hzjY0LNWF3K
	IX+AvpRTHHkTAMcIcsec3H6C2CsE8WVNtmqqOYKSMmed+9kErzIo+s+xtA==
X-Google-Smtp-Source: AGHT+IGS5r/KAbCAZgsoPkYZJ5EAM8UHb1LtA78SDi0KLHm5GnABYYgm4Mn8K7vxXVcSREApyW5asg==
X-Received: by 2002:a17:90b:164f:b0:2ee:45fd:34f2 with SMTP id 98e67ed59e1d1-2ff7ce596edmr25892400a91.6.1741702406784;
        Tue, 11 Mar 2025 07:13:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff69374942sm10039071a91.29.2025.03.11.07.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 07:13:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 11 Mar 2025 07:13:25 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Kurt Borja <kuurtb@gmail.com>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH v1 1/1] hwmon: (dell-smm) Increment the number of fans
Message-ID: <bfb70a81-2ac1-428c-a327-d5098a8d3ce8@roeck-us.net>
References: <20250304055249.51940-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304055249.51940-2-kuurtb@gmail.com>

On Tue, Mar 04, 2025 at 12:52:50AM -0500, Kurt Borja wrote:
> Some Alienware laptops that support the SMM interface, may have up to 4
> fans.
> 
> Tested on an Alienware x15 r1.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>

Oh, never mind, I'll apply this patch. If it causes trouble on older machines,
we may have to make it conditional, but that is not a reason to hold it up. 

Guenter

