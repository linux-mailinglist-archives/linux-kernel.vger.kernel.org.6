Return-Path: <linux-kernel+bounces-381832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BFC9B0514
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96E17B24339
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25171D4604;
	Fri, 25 Oct 2024 14:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yO2UYc42"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850E870820
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 14:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729865226; cv=none; b=p3e0pI5zxNscbiZLWB2x8dAQCecIgzkei4nVyFyx/1v4vkvQsa3rV7XLzqSpEKmmnEr/zYamkv1UBtlpqsgn1qoYjjAWMcqpstK2sHGrEyg0WkLobppVy8S03HoWAx8VxPTwbv8RxW3GahI16Kr8sIGxMG/uS4cpd1fzqRxDykM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729865226; c=relaxed/simple;
	bh=R25u/LjXumh7VQ2NXXhe49BRHZfuAiM2pmfukxXsC1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UotVDiQ56jphNqnaSGDgRFFFkRbQphl11/H93bz7YXqdk7WCtqnkmOjLkyrcJ4BQ6RDLzvbnSZpjsmTJT+JYi+EX92mBeY7bG6DsW6M4yYzPQRs2lql9xHW8lGdF+jxC6vVnhRXRvxVYDFrrd9M1K9cU7/xZi5BYb+FdaqBQa7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yO2UYc42; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d3ecad390so2348877f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729865222; x=1730470022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=luQpIwsQ81BxpLvWcfVNOBQaOkbZgajGGn3YLiW8HX4=;
        b=yO2UYc42/la6R7Dm+KqeBIxUVhZxj/11aJCpR/bLy3hzY6Wvzgke+yRRCCQbbR6N8O
         LMAh752RWIaU8HpXlpcJDJu/uYW9YBNUkAhb6nHff4MMyTQRAIG/mNGcf1wi94JzO4fd
         yh2u/i76JaVR13m8KHFZKeZTWrwOqvHue8AvWTjIEqfZbF6AvwYpdtjYQ3QP1Ohavxwa
         FsF0V6XmjC+8DxWN6TqWNBK/vrIm/9EM7qpxA2b1jRyHA6dfoHtyU5WicoUzZQs13wUd
         ssEGlfL8dAd/3U6iZq/JX9PnFsyKzXBnfvlGIyR2bS+nfwPneoLlUGbgfgLZEj6mItz+
         VPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729865222; x=1730470022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=luQpIwsQ81BxpLvWcfVNOBQaOkbZgajGGn3YLiW8HX4=;
        b=WVA1xYSw24mKs8C+jMLkhTPdSR1od6VVqvT0Xm00ulDfT7DLzBcHH3m2uot3q78yq4
         g/Ndp6RbZWCx4KOm1o/KfWLauqwZUvnHJe8zUchlEIEnhSFVThum2U3p5vOIRWXZ66pz
         DCA0eiEJA6FPvHDtaGT9NJVdBBRnoG28vXy9++KT5BcB3PdD7R4Ht4P5L9tK+tDPxfCK
         mkMQPdMS7X9S7G6MZ15JAdUxF5Pws1634JUM9xqfGl6h2Afi+0v39q1VgNkYamsLUeAK
         JjTsixjsCoWoyVrAisCiI9hrlQyXO09Ty+5rxRB9GM8Iy/yIbIVT//yolD3HzyZ6JRTR
         eYRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuqz+BiyWKJl98kzh0FbnD7jqGMuxgt1uh0180mbgJXTk8TMJyaQ5Z/mKeAB8BtJL5MhrCdLvS8AJ1cEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTVCP14AwOTkSg7Fo8gUjkxYnSWDbvq7f7aGoncuzJ4xKCuQ/g
	s5z1R7HTN7TGpEINT9iZRsdW4kZBwqwMU+xvxN+ry3HvXLQ4Aci1pnsx8xOynkM=
X-Google-Smtp-Source: AGHT+IG794v//4CoU35jZ4JOp2qrHO0NPj4GP9c6zL37F3w1s4Wzz6eOSMuHZrhCt0fTdpXgvlBABQ==
X-Received: by 2002:a05:6000:1a54:b0:37c:f561:1130 with SMTP id ffacd0b85a97d-3803ac0c1cbmr4633067f8f.18.1729865221746;
        Fri, 25 Oct 2024 07:07:01 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058bb4348sm1583563f8f.111.2024.10.25.07.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 07:07:01 -0700 (PDT)
Date: Fri, 25 Oct 2024 17:06:57 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RAS/AMD/FMPM: Remove some dead code
Message-ID: <8412cc2d-7713-4a79-a7e8-5759e3320aa6@stanley.mountain>
References: <6b914abf-b3ce-4baa-b4d7-f8da9a840a3f@stanley.mountain>
 <20241025135616.GA407109@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025135616.GA407109@yaz-khff2.amd.com>

On Fri, Oct 25, 2024 at 09:56:16AM -0400, Yazen Ghannam wrote:
> On Fri, Oct 25, 2024 at 10:08:34AM +0300, Dan Carpenter wrote:
> > Debugfs functions don't return NULL, they return error pointers.  Debugfs
> > functions are slightly unusual because they're not supposed to be checked
> > for errors in the normal case.  Delete these checks.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  drivers/ras/amd/fmpm.c | 5 -----
> >  1 file changed, 5 deletions(-)
> > 
> > diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
> > index 90de737fbc90..3cde1fe17a7a 100644
> > --- a/drivers/ras/amd/fmpm.c
> > +++ b/drivers/ras/amd/fmpm.c
> > @@ -956,12 +956,7 @@ static void setup_debugfs(void)
> >  		return;
> >  
> >  	fmpm_dfs_dir = debugfs_create_dir("fmpm", dfs);
> > -	if (!fmpm_dfs_dir)
> > -		return;
> > -
> >  	fmpm_dfs_entries = debugfs_create_file("entries", 0400, fmpm_dfs_dir, NULL, &fmpm_fops);
> > -	if (!fmpm_dfs_entries)
> > -		debugfs_remove(fmpm_dfs_dir);
> >  }
> >  
> >  static const struct x86_cpu_id fmpm_cpuids[] = {
> > -- 
> 
> Seems like we had the same idea. :)
> 
> https://lore.kernel.org/r/20241024155503.GA965@yaz-khff2.amd.com
> 

Ah.  Good.  To me it's always encouraging when people end up writing basically
the exact same patch.

regards,
dan carpenter

