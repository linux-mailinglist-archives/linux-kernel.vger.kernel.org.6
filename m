Return-Path: <linux-kernel+bounces-172592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FE28BF413
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 03:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C925B1F24806
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 01:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E179947A;
	Wed,  8 May 2024 01:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="oO3OfM6q"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CCB8F6A
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 01:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715131762; cv=none; b=Uu/J+rR6DaWfKmNftGQ8F0m3a1bPSF1+nsvkrZxaGo24broIL2xST9PDpcoun7cKMzddr2aiEJQ85FeDQevcaJujk24ZIKLKks1yq5k1Cwqex0vkSFebH4M3+bSuh+djUiCfOEnOftrRuPVJoInpcAHOhWkpo2LwlyRgi/F1blk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715131762; c=relaxed/simple;
	bh=S+KmA9dSLhjXnhJF873IqV/Gd9cnIAVOxz54318nTNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lij0P7W5O6fVY2tDzjQKrjnA90Hg/FrAT0KRs6clFV7xa0ar7qoEvfeOjW3N4PDTRKUVmyb+jrx6ugToBBETdCW72H+6J1+GwQjm7BCS0wCQQ75KxlLB6uwMjbu6f1FPgNQCJGpblWMHaY2jW0t8G3Hu4IzoJ3Q5KxZJNWLTEOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=oO3OfM6q; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f44a2d1e3dso3263827b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 18:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1715131760; x=1715736560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tzB4aecjphlPEDzQe5NK3FsOS2K2mixibavsvosnc7o=;
        b=oO3OfM6qLLjMz9aUHLhklQ0uPj2Y5ZRMWlLy9gma4k33HACixpV2Ake6Hpax5RliMZ
         2M4Tgj1YvJCseaP4E7iKLcqV6toXKblk9O+jIE+VuhqtbkTg2vt2ljEvPmJW+AqCqaos
         Vjau5N7VOUKC373kRYF41noOFbH2SmJN88qpAw5Wv4IFccy8k16lkWaHp64/x5yJePsx
         RcTE794ew9YpKBqG2LJZbvwjCC/IfBkQCT7t1JfRpxzbM1KBm2zDp08Qggoz+LmiPTXQ
         nlqNlYSa47jpXxlTsKRayZE5TPnHNbOiYEMYP+hDIVEHnCA++qGXxoOMY8zMPyBAAzWq
         pceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715131760; x=1715736560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzB4aecjphlPEDzQe5NK3FsOS2K2mixibavsvosnc7o=;
        b=t21RhdKEMpAz3enDFc96g0upQlPIXkmA5pDaUx+3KO7DofAXDejZ8ZX3+5KWo8btRe
         qUajXZZ8O0cAYeQi16k5ech54paAXYWtdnJY66h05nrc/pTY0mpR8h440r8YoYJavkpU
         IXTcAxvUE0dqNl0ILpgkU58oyGR1szRlEwSGkOqEzWu/fEss/1xTsbomXoztOD0Xf+5F
         PVfJ0Fr2pmKY74qk9wkKKze28+dafgFZeI1JAvdBaSgvShKUmZ+1bKsEevpnfb/38cs0
         95fXIKDT7HDVPALlA+LDe/EAoTQ3kAx2nblEUr4QiwXabplFsdDKIScmjTTEteGBy8vc
         5g+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPta1IVq22LpmHuPcaSAnJEeR587Kf0Wh83gz/NzHkOFAket1hyvr158ZoYhAGM008aB07ziyOO6cSuDHrDDhidHLyn8o1r84vhqpN
X-Gm-Message-State: AOJu0YyfXqJK3YbB0Mf7X4jF+bLbclV7HzDFyoFqZlCom1NGev9DhIsq
	7v+UeCRxpKEJaqo1GnunhGW6vpbnA6phYEe2ZaZA9XboHn13o2ZGBoOzJBTso8etHE+aY+AZBv/
	t
X-Google-Smtp-Source: AGHT+IFRCw8e0cW7ldgPKWllS3XVUq4LhbnIO0GsLRIB6i79BIUwHKsbT8AkP/LXEDjMS63xwL/0KA==
X-Received: by 2002:a05:6a00:1410:b0:6ea:b9a1:63d7 with SMTP id d2e1a72fcca58-6f49c20eba9mr1696829b3a.10.1715131759520;
        Tue, 07 May 2024 18:29:19 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id fi39-20020a056a0039a700b006f3f9e4dfd4sm10040409pfb.60.2024.05.07.18.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 18:29:19 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1s4W7P-007LB8-18;
	Wed, 08 May 2024 11:29:15 +1000
Date: Wed, 8 May 2024 11:29:15 +1000
From: Dave Chinner <david@fromorbit.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] xfs: check for negatives in xfs_exchange_range_checks()
Message-ID: <ZjrVaynGeygNaDtQ@dread.disaster.area>
References: <0e7def98-1479-4f3a-a69a-5f4d09e12fa8@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e7def98-1479-4f3a-a69a-5f4d09e12fa8@moroto.mountain>

On Sat, May 04, 2024 at 02:27:36PM +0300, Dan Carpenter wrote:
> The fxr->file1_offset and fxr->file2_offset variables come from the user
> in xfs_ioc_exchange_range().  They are size loff_t which is an s64.
> Check the they aren't negative.
> 
> Fixes: 9a64d9b3109d ("xfs: introduce new file range exchange ioctl")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> From static analysis.  Untested.  Sorry!
> 
>  fs/xfs/xfs_exchrange.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/xfs/xfs_exchrange.c b/fs/xfs/xfs_exchrange.c
> index c8a655c92c92..3465e152d928 100644
> --- a/fs/xfs/xfs_exchrange.c
> +++ b/fs/xfs/xfs_exchrange.c
> @@ -337,6 +337,9 @@ xfs_exchange_range_checks(
>  	if (IS_SWAPFILE(inode1) || IS_SWAPFILE(inode2))
>  		return -ETXTBSY;
>  
> +	if (fxr->file1_offset < 0 || fxr->file2_offset < 0)
> +		return -EINVAL;

Aren't the operational offset/lengths already checked for underflow
and overflow via xfs_exchange_range_verify_area()?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

