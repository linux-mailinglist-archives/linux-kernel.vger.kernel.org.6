Return-Path: <linux-kernel+bounces-172968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B371C8BF980
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46661C2204D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D737581A;
	Wed,  8 May 2024 09:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ei3BqE/P"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4317274C09
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 09:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715160029; cv=none; b=To5fLlCYrCoQzGFB5zKSDn9IIF4+iVgUMdFqyBOX7Y26CzHHpcYSPJw2eb9Byzoz/1EGHp6Tgxe4e01RyH6iuEUweuNBEtNnHSKrLPqOCHNAlT3wN4LYOQsOrtHxkfQpKS9iMzCGuhJZ/ji32IrHK4V5KgdnR9TwdYdVkT23CXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715160029; c=relaxed/simple;
	bh=yKfqWildDBpRn3j/aQLboejYqWIQhfdprrcdr7mLdr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jY4LkBk6KNYJVjSEcpNIm1XFZ0HhwtsztYwczpCL+gb/JH+LtHKMGf3LT4N9qCBt37VPRMTo6pa6THsTlSayIWI1CkcObiDyTp4EItjLNVeeH1mC8KHTu0ThOrfDeQY+HGnu6Gajtu50ODEE9UaW1s3ZrslXs5hHR4w6wJ0HkMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ei3BqE/P; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59a387fbc9so1035586166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 02:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715160026; x=1715764826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3XvuGnMD1Ah+tuwTUGBWHswEEMKL2KFH48xBYXc+VM8=;
        b=ei3BqE/PSo0Ze6nfudrXV+AGVhUpl5uCPNXWHQde5JTUkkhun9QoqF3bWU5z3tTOJA
         LkBvJ7cp3DS/IE+ptDRw00V1wujbtMlDBoifZGlN0Kspce3DqMMgn4oODS3YpEhNPEIR
         OdosdwD+D56YUhkWHovISFpkZoMikcDI3RcCGnt+SindLNWqqRROmZ2RBZ4QjbKwR09N
         Axx1R5TJhMV22cMsoDi2URq62P5r+VjduU14jFL3IBQImhJ9GCJTBRZVaeAMudogCoG8
         fTbQvqUp/E1wWJKBssDmDhb89/39CB0kr8dcl0HGD7pVPJM/vfQQjEV8Vesi0g+3yaVb
         W90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715160026; x=1715764826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XvuGnMD1Ah+tuwTUGBWHswEEMKL2KFH48xBYXc+VM8=;
        b=aXkwIl05Jh3XtxCTMAXjrN7YWq5mYwiMIC7/yY/+C2E67c11skbRmFltyihdajU8wv
         CPVD7Cwy3HFdHtghiha1hcfdDzm7YrJp5rnL24OiASxWEyz3fGL6wpCIF/2M1d9fgGdI
         W4dCf8Fir9H+yV/7M5IV/PST322r0DLqibq7RiY6t7NnyZ42+wU0Drx7qCwYBKEIaitf
         zatTiehQe2LAPZHOl+SqlRnuWvnZE1KRuc706cC5Tw+i5WnTJ9zYoces4kBmI0gAb8kt
         zdKAzmeJ3votkYObuvkZP9V4L2/oYETVp8TnbUPT3D+ThvRJfInpS4zCBXtdAPdK4HXc
         bd4w==
X-Forwarded-Encrypted: i=1; AJvYcCXxw9WOytl1LYMTvT3H1C6KXQgX2goBPRUqBzg0Yvd/YykdMXnwYItwpyVsFwBMQY58g/3B2eQ+CwZ7cH/JFnBxZGlFNn5+9IHQ8lkL
X-Gm-Message-State: AOJu0YwLw6GO7hPF7Dz86C+5MM9P5aUTbl2uv7TXZ5A8tCtSzOvrr7rh
	sgAMp7h/Qg4S55IulXsIpSSWlfVY391fG3+fdKRXgGm0FVLicuyXh4H48UgcmgIF+HolxFdM6Fi
	6
X-Google-Smtp-Source: AGHT+IHq2INOQdTZFtxvBQ4CNgUmxUKG/Y5YiCzni6VgE1Hb/kxqQiCsxPVeCX8iNNi6RQsuxFZCQw==
X-Received: by 2002:a17:906:c444:b0:a59:c28a:7ec2 with SMTP id a640c23a62f3a-a59fb95dc67mr115208566b.41.1715160026392;
        Wed, 08 May 2024 02:20:26 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id g3-20020a170906394300b00a599c1d46d5sm5967553eje.101.2024.05.08.02.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 02:20:25 -0700 (PDT)
Date: Wed, 8 May 2024 12:20:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dave Chinner <david@fromorbit.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] xfs: check for negatives in xfs_exchange_range_checks()
Message-ID: <20137ff5-76a7-4b3d-96d9-9c6c90cbb063@moroto.mountain>
References: <0e7def98-1479-4f3a-a69a-5f4d09e12fa8@moroto.mountain>
 <ZjrVaynGeygNaDtQ@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjrVaynGeygNaDtQ@dread.disaster.area>

On Wed, May 08, 2024 at 11:29:15AM +1000, Dave Chinner wrote:
> On Sat, May 04, 2024 at 02:27:36PM +0300, Dan Carpenter wrote:
> > The fxr->file1_offset and fxr->file2_offset variables come from the user
> > in xfs_ioc_exchange_range().  They are size loff_t which is an s64.
> > Check the they aren't negative.
> > 
> > Fixes: 9a64d9b3109d ("xfs: introduce new file range exchange ioctl")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > From static analysis.  Untested.  Sorry!
> > 
> >  fs/xfs/xfs_exchrange.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/fs/xfs/xfs_exchrange.c b/fs/xfs/xfs_exchrange.c
> > index c8a655c92c92..3465e152d928 100644
> > --- a/fs/xfs/xfs_exchrange.c
> > +++ b/fs/xfs/xfs_exchrange.c
> > @@ -337,6 +337,9 @@ xfs_exchange_range_checks(
> >  	if (IS_SWAPFILE(inode1) || IS_SWAPFILE(inode2))
> >  		return -ETXTBSY;
> >  
> > +	if (fxr->file1_offset < 0 || fxr->file2_offset < 0)
> > +		return -EINVAL;
> 
> Aren't the operational offset/lengths already checked for underflow
> and overflow via xfs_exchange_range_verify_area()?

Ah right.  Smatch complains in the middle of the two calls to
xfs_exchange_range_verify_area().  (It get's called in different places
depending on if the XFS_EXCHANGE_RANGE_TO_EOF flag is set).

regards,
dan carpenter


