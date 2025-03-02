Return-Path: <linux-kernel+bounces-540669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A57C2A4B38C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 17:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB4D61891B33
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 16:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6101EB18B;
	Sun,  2 Mar 2025 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exxMjTxP"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856331E9B37;
	Sun,  2 Mar 2025 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740934374; cv=none; b=NBeXZ0On0PSGWPzs+Nf+jE4LWcMJzec9fP/fBxICNBxJiqpwHzkwOCjpWSajdjTq2TtF2eQSJkFnGBIqTrhqFA9UJ78tp3jXzKbYDqtu6wA9iB34JKE/2GWcc/1E0pRr464ribl3cgmQ89/OhpV5VMK3gEKmAPHlfSYvNkc38TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740934374; c=relaxed/simple;
	bh=ddhHuPWddXFULLyKDqcRVtdIW78qfKh4LTdI/RvKq2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyzuLOwTnHZ6a+Ji3MZL/zMQsB4uppls1XKYJv/IRkaiSkZUJ+uqU4+rutgbZvrxWweaaxOT/IjY48XccZ3f413T1E5sf0GQQjAW/1Y87S7Ov9lIkqAa2ouw+QokqRAJWVrd8xnm2579/Z/lkf6UUVMPl5WvewJd+nOgIhy3S/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exxMjTxP; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22355618fd9so59793765ad.3;
        Sun, 02 Mar 2025 08:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740934372; x=1741539172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pHjyd2+8BBNc6EytceePp1WtXNhD5jRQFNuplVOpLOg=;
        b=exxMjTxPqlwR3Pou815UzzmjywHDQ9d2Z9i/Zj/UXdqhpBhcJJWkDltoa7fIELSwgo
         Wy12FF93WPeKw+lF6ck4B9TOFFydt3TN3umFrTzfFeGj+FhefhZSghrFqH9OaNQZPuzP
         T8MHtmtAnTper1yWnU9qSzfQSgB8c3844L9szo2E4NXohxEkYV/anxEISAspHUHxNgvB
         zTmkgYkVX8LoqYEyXbCvd6MmWZpTeaqusDe7hrd71FDGNfmKnmwhH62mVfzTnffXxIRl
         QN+jjmnBSmPHHAuvIFFtCGuV++Z0kW0nh3199vCXOAZGLR2q2mFNNM5xEoZLngxOH5QO
         O6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740934372; x=1741539172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHjyd2+8BBNc6EytceePp1WtXNhD5jRQFNuplVOpLOg=;
        b=VLUPkU9wKaiQHlwHfW76bTEhmahgW1e/DyWA8WakSYAzu/moQZPXyCkgK6MJ2fNKSn
         k4D3CxRrw+vdzBFLs3i2VDj4cOXQB5EAJXA1bXKSMCCw2TigGXtkuzR9fvOKGGq9QeB4
         Dq2+c2w8lKRbeHBjachr8HUSiuRIZz5PhJTsPpKQ4xNbzhWiCaz6FhNXP1iDMO18npuF
         loRsd6pOwrWAb1grW2dIp4bOEYEYhA23LfpeE9t2w/LPRaT2pIyCPjYOhxvXaWooSzZj
         eq0bViCQQxE6v6FL28wCT3kDBaLV01nSAsbKxKtfMg9yDvIcjvOzUw/iqzakyj13T/m5
         xCEA==
X-Forwarded-Encrypted: i=1; AJvYcCW2CKg4UI8+1udCFmYT74cjdHr6L3gtfFI/ZQa0Q2t375jGhJCRm9Eq9XwXTrtDh8+xIO4/3EVhHmdzaZMn@vger.kernel.org, AJvYcCW6HiKAlqAGniyh5PasxeSQ5RIED+3gVj3JPy0iG8N+j2D1e8TXQ9/2aJiIzRWwFk0pyKXTWhQNbxMWeCk=@vger.kernel.org, AJvYcCXxzFuHFSXYMG8ltna0WEtPg4CCdyo7evLX0wO/96pwfNGVZmiakEiHCBfQmNeSJgR/ZuKeZi4Gwxxh@vger.kernel.org
X-Gm-Message-State: AOJu0YwkgMyPF1tKlWnuWkMwO6h5NUcqgifyf7t8obuuooYdFDxNZG0K
	u2/CQS3kuZ+uNpSxJ0kutGvHHrOm0FNxYccPxvWfL+W99rypvHSM
X-Gm-Gg: ASbGnctLmFE1m8A1d8mrXkqb5hBO0sKyne+7dzapWyJG+xtdyuX/Rd3Z8IB+JWIqX44
	zH4JCgRU+XuX2rWRWAievhKxu6bRbk9j/6XtfmuCAfPsqjPuG1ItpoYcxK95aHrN0zfFTKWzLoA
	u6v12Et6TbZ7rt59KdH2XTZfsRUxQB+hxRIotE6nAleOblYxKKMrVO/eUQYm6zbXAmxUYs24NmT
	2jQTaTyOOGQEFBSkJkyvK3kj3Dt9Q5Xz9p4ZvbdOZwsQ+tS6LXbsELYs/tdvDCvwHgx7pClhC0+
	aNjDuGGqrC7OjRx5Gds7Opeca2w5juvIguC6o6bCkVFqmM4P7fj1E4zbSw==
X-Google-Smtp-Source: AGHT+IEdQfY2xYloBoJlSiFpa8U6C4SDFC7Q1AD4CcxoQ4hf+lt4XFoERlFofGrffjglqSIFSx1u1w==
X-Received: by 2002:a05:6a00:3e25:b0:734:b53:5826 with SMTP id d2e1a72fcca58-734ac379b63mr14236026b3a.14.1740934371781;
        Sun, 02 Mar 2025 08:52:51 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a0040208sm7157176b3a.154.2025.03.02.08.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 08:52:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 2 Mar 2025 08:52:50 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] hwmon: (gpio-fan) Add missing mutex locks
Message-ID: <d6648655-1f99-48ca-9c8b-4ebc489fac50@roeck-us.net>
References: <20250210145934.761280-1-alexander.stein@ew.tq-group.com>
 <20250210145934.761280-3-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210145934.761280-3-alexander.stein@ew.tq-group.com>

On Mon, Feb 10, 2025 at 03:59:30PM +0100, Alexander Stein wrote:
> set_fan_speed() is expected to be called with fan_data->lock being locked.
> Add locking for proper synchronization.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Applied.

Thanks,
Guenter

