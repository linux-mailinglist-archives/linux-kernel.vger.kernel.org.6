Return-Path: <linux-kernel+bounces-357840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1F49976D7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 22:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614911F24395
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB072F2F;
	Wed,  9 Oct 2024 20:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CA0DUhOA"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEC71E1305
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 20:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728506710; cv=none; b=cOjX7dJA+aooOm3fA/QZ2xVN+eluNty/DhEsF4uytYj4BrvNb2nxgImzfUHsSZnN09BHDOCQ+dZds9OZxwYfIKZZNbvi0wR/bEyaYdLhGb1I6VltJu7GCSKzc1Xbmr4ixLhs5CFHWonTrD9SA1MVo93Y3cHkhVsSnXIUWGm1teo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728506710; c=relaxed/simple;
	bh=nYfwcpUZdYjL0pSQsLCQsnTPhCrsZbtNDAclhh7uAlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R89wlngWZnLRRR68yTIV8e5GiF8urpxe48HgNzPJjPgqqp8MmG9g8eAAreNTmMwocrGX59oh2q8qxnBGhZGLHq9nLUhCS8/wHBzCo489b+SxS+YEwrs9+xypM1LO14dA+D7VNc7mtv6NjETaHllj95UhYapHzS34MoAI2374KrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CA0DUhOA; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5369f1c7cb8so258456e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 13:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728506706; x=1729111506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ta9iSL75PsN6aTymrbgB+q4HfOgRpGxi4PmyF2v6vbQ=;
        b=CA0DUhOAYPkYbyJBh7lNPOw3xA39W0oiOzUZP1IhVzBGm59TXIEWFZHjqdtetS/Gp6
         XdVuCyUXA6OLvLn3KLh8qkJ/Rs5dhHY4Lvpw88zBMTRIXj0GTCrSOAHB7kLIILyjH/TT
         Bc4v0RUKGMrXweGr2SiOEVPL9alVXHpitlzevHawX8UpDeEaXFv46pWNFmP+3flUXRuN
         bsUmmw7Nsw2iyyg7zcFBXrAVALZbYwCGcKUTvssnnUxk2yV0EfNPk1uLLrL0lSHaYgZf
         XNG/6q5bzqznm4wwxN4Pk3ymaTj6rbelImEYFz3NhBCl7cbFWa0kJTMhL8iesewOp6Y7
         ZMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728506706; x=1729111506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ta9iSL75PsN6aTymrbgB+q4HfOgRpGxi4PmyF2v6vbQ=;
        b=TtrgYTxoRFAu1V/Xd9xyQ77w5qxoIAT2Ht4qUrOn8bh5s1JK8+AUA8Z032WIZPdX7B
         TcnQ7UwGN/Vp2RHOq9QVmPkz57wdjio3oSd53AepH2O/mbyAC12KjQQLWwkeXrvJ+ItT
         1tfKsFePd+1eLYK4p9M9lA3tvoT8Mzu8YA3JjAYgqWp4ygmXJ06IspDHo/R/x0xl4A7H
         JO6uemhNhVYhEBLoTP8Qvo70rVU2oRAvZ4kaYDaH882UJtOg6KYIMZqYtYtwWa4moSJf
         0L3YJ77x81BDBQ7INnrtL2dZDYtG7WXMUxHqJdVA6PiLoJf/X9DotZcr69t7cTgVgwWy
         ejWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2aTqptSBepVPNDj85cc1RZCVDAnQGdbpPDVgEBNtOqLGX6QC10fhSauoKELvJpG6VoURVOI9rwATZ/2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YztuluDPT/8Ss5i9Hw+fF36cCkkkPWwq9d4DY8HtLcuIAohReAz
	nxiFcfwOVsKeSOT60CUVYYUnrjJWfZ2/R4eNUsK1UCJcpoo6u22xWQl3PQksgMI=
X-Google-Smtp-Source: AGHT+IHAOMpRwEYJiHDMI8w8bMB34NUeQt076rTlzeHhr88PtHM4vDWcgfzfmZ8rkVIsUWadQsA5Og==
X-Received: by 2002:a05:6512:ac4:b0:52c:dfa0:dca0 with SMTP id 2adb3069b0e04-539c495b90bmr2596983e87.43.1728506706141;
        Wed, 09 Oct 2024 13:45:06 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4894a647sm266411f8f.16.2024.10.09.13.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 13:45:05 -0700 (PDT)
Date: Wed, 9 Oct 2024 23:45:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Everest K.C." <everestkc@everestkc.com.np>,
	Jeff Layton <jlayton@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] fs: Fix uninitialized scalar variable now
Message-ID: <263ceb04-f909-45d8-b9b2-5de86617ea25@stanley.mountain>
References: <20241009200528.36343-1-everestkc@everestkc.com.np>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009200528.36343-1-everestkc@everestkc.com.np>

On Wed, Oct 09, 2024 at 02:05:25PM -0600, Everest K.C. wrote:
> Variable `now` is declared without initialization. The variable
> could be accessed inside the if-else statements following the
> variable declaration, before it has been initialized.
> 
> This patch initializes the variable to
> `inode_set_ctime_current(inode)` by default.
> 
> This issue was reported by Coverity Scan.
> 
> Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>

Fixes: d8d11298e8a1 ("fs: handle delegated timestamps in setattr_copy_mgtime")

Maybe the WARN_ON_ONCE() should be updated to check ATTR_ATIME as well?

regards,
dan carpenter

> ---
>  fs/attr.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/attr.c b/fs/attr.c
> index c614b954bda5..77523af2e62d 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -284,7 +284,7 @@ EXPORT_SYMBOL(inode_newsize_ok);
>  static void setattr_copy_mgtime(struct inode *inode, const struct iattr *attr)
>  {
>  	unsigned int ia_valid = attr->ia_valid;
> -	struct timespec64 now;
> +	struct timespec64 now = inode_set_ctime_current(inode);
>  
>  	if (ia_valid & ATTR_CTIME) {
>  		/*
> @@ -293,8 +293,6 @@ static void setattr_copy_mgtime(struct inode *inode, const struct iattr *attr)
>  		 */
>  		if (ia_valid & ATTR_DELEG)
>  			now = inode_set_ctime_deleg(inode, attr->ia_ctime);
> -		else
> -			now = inode_set_ctime_current(inode);
>  	} else {
>  		/* If ATTR_CTIME isn't set, then ATTR_MTIME shouldn't be either. */
>  		WARN_ON_ONCE(ia_valid & ATTR_MTIME);
> -- 
> 2.43.0
> 

