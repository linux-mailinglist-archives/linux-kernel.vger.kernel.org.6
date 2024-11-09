Return-Path: <linux-kernel+bounces-402921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6D49C2E76
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 17:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 728CC282309
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 16:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E0119D087;
	Sat,  9 Nov 2024 16:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="br9Ib7L2"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDFB13B58F;
	Sat,  9 Nov 2024 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731169204; cv=none; b=AVKUS5fViOWV1dO8l5tIcMAvFyfC7o/kxmkY2T/HrT5BjXzvloAJ8r/TQGCzEtujhQn7IoAH9fjEQA4G/yl+j5ilxxhByaORFaK3098qTWpqAUanZ9NBFMbc5AYy3u2AHbFMQ80TcGTBeZP7v31igpSIaB4FJ34LnAl6HwOhf6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731169204; c=relaxed/simple;
	bh=bYM/NzIvyRrfBsP8RmBIZKV4NZLOrYsf/moxsAkmvic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KU/DF5rG54NCmzfwLiOremFKwcpZYZBLZrGCqqiG8vIkEM52DbzBbILPOBMBakjcQUXvQ2Sb4hmYDD5KXn71hysI54BEj4TqKk9/XhgzHGedafWbjbaEEN4NUNs2Vbnvjb+JGW5ukH8DToU054V9Hh1p+CltUDT//X81xFuFrIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=br9Ib7L2; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c8b557f91so35210665ad.2;
        Sat, 09 Nov 2024 08:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731169202; x=1731774002; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uIdDqkNi3q3KSA3T4NLnanAmEvoPnAc5/iNz3QjbMxk=;
        b=br9Ib7L2EWa4KW/9STk64QM/YHFzwaeuO6kk3gapqWOqsxVFSLneNP7i9z/TIxAdRp
         g5GHKC+nsNaftGiU+z69e2sfI8sJ3vmW1JLufZ3kgpELGosi0Xw/89kXO1V+5TzMfkuy
         wrwpp/gRUptDO/fx1As9MWuqkmJXxaHiS7wHNKdF6VVlR70PIQP69W4YVEfM9dfU80BP
         DQltemBOf3NB91/+8csFgRXGhgbCxOoPgXcJ6F+lYa77p9Lok057vY0kyCVCu/keoyMD
         1keNrp5u0cICPFSjdy7w0wRqp1jwA/0Pe86GvD3HYChhqAR53HLjo+BZegbVVwkeQ3ey
         mEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731169202; x=1731774002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIdDqkNi3q3KSA3T4NLnanAmEvoPnAc5/iNz3QjbMxk=;
        b=LaGsfVFeFgl6qEaAOsU3gUJlU1i/Va29AZDMaWdR+DihPozbiiVvAS9y2R+nWkGNyj
         +VBPTJbnm7r293ZvnzFAQ4khXvmym/QR11BcsNkxCdphcrJxHFrmgi2tFISff0qXNRDo
         XQe8Qpnl2S3DW8q12O3M6xitKt+16TcZmFbPRvvDm7n7uyPdL1RNX2CAHGA7XUbuFw+j
         5NB2CbH80+Q8lkFBhqMO57Z/E9WRihC+NsJMkDDG+FBhKGgENNWOZsL1Gfe+Gwv8zAMN
         OB5PcW+7eF91XaPi8fD6cocRB4nRLVTKZAtr5vMjEqRw3+pR4UT51WYDlRrmG5h8s//5
         giyA==
X-Forwarded-Encrypted: i=1; AJvYcCVgavc0+wOB1c9F4uDqkOK2UouCh4sb6Nt8id9eTJP5g34mqMumZn0GsIgCILKeWzNOv3DC6FZX878=@vger.kernel.org, AJvYcCX0gS5yMAvrH3/jpmiQygdxtAuGLDnO/sMdSvENvPT5FzAw4wWqm3j3DbzAIHGMf1TzhwwhPOHedLivLPD8@vger.kernel.org, AJvYcCXKmjg6JfzsSfDPxs4xSijBRDi86qrhxFsuesZBBh8vXW4vVJY1fTa5jd2lVfkH4LTLnkOtG+Sp1I7jZMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX0pd0aUWT1pIoscz+WvR3U+Rn+J/sgAkRuXk9DlzVbqD3uFP5
	cGIRVNQn7d0wDUqvOnibWQEiwp4DKR/5HsxaPUzXWJg5wm5unHp5
X-Google-Smtp-Source: AGHT+IHchpijQZ/t4MIM3Z5ZvdChlTY7hqQFZY7Q8ZocwKd7CTk25AFO5k8cr+DqsbXwQBkkfgRHfA==
X-Received: by 2002:a17:902:e5d0:b0:20c:e4c3:27a1 with SMTP id d9443c01a7336-21183c41aa4mr86898525ad.3.1731169201856;
        Sat, 09 Nov 2024 08:20:01 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e45839sm48009165ad.143.2024.11.09.08.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 08:20:01 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 9 Nov 2024 08:19:59 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Abhinav Saxena <xandfury@gmail.com>
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] docs: hwmon: Fix typos in sch5627 and max31827
Message-ID: <a8ec5b3a-7adc-42d9-8c67-04f21f000eaf@roeck-us.net>
References: <20241108212201.144482-1-xandfury@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108212201.144482-1-xandfury@gmail.com>

On Fri, Nov 08, 2024 at 02:22:01PM -0700, Abhinav Saxena wrote:
> Fix some typos in hwmon/sch5627 and hwmon/max31827 reported by
> checkpatch.pl. These changes are purely documentation cleanup with no
> functional modifications.
> 
> Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

Applied.

Thanks,
Guenter

