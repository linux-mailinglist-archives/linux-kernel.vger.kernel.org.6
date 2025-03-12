Return-Path: <linux-kernel+bounces-558052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAC0A5E0FA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 484951881D2C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BF1254865;
	Wed, 12 Mar 2025 15:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jJH+aorG"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722B4156C62
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794553; cv=none; b=Jaz5fDf8l4s1Rjc9hp8go94t8yFvtqqiR2AeESMnJsQA7STelHKTbppb+IHjdbPnIMZPIlsFhjDBUa1ss5E3xYXdFfiLxp+NgiTrCCR5eaX7wWEYTpP76JVYecxnDpmaF0zMOkAFzgDNNdh8Ujr49nxJk47fWdNQ/zkvpX2HncU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794553; c=relaxed/simple;
	bh=lyu86/EH9by17rBAc9XiUsIwotdsGEea6rRN+fSn5Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WE7yI6Mw15xRdN7msZF3Kr3htghC1VTQTFrqEEh5xPu0iXZsmwy5RL9ZKC1bcY0n916EtWwRdgRk7bOjP80+AOS8tqjPtfSbIuKmHCLlDaIPVZ9OoVp2UdtmqzFWJrAJIBWh8DhwxXT1R70xuLrEKYOJLh8LZmkCUjmlI0z0vcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jJH+aorG; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e90b1b20c6so124546d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 08:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741794549; x=1742399349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ofjgk4zuzVS+cwXy38yJsSZN8fRmew2OrhBauRs/AxI=;
        b=jJH+aorGgEkiLX5+MWr3iM0TUBVkVY7PBu47LDABFRM/S08v61AGcX++2L9tpca5zv
         VFNLzzvOh1Dc9M3P37iBonIJI5XkQ7Et/HTplSk4arltOTD9bkbPn+KDSO2GvvdgS0AX
         hYsH4uPLAgeMGyxyTot3ifCogF6IBUkD+9QMl51dnf/pss6jhs5Z6YqiKGN/IElV8dNe
         gOQSq2Xhp2xzp58aewMeaRtfyMV+/aqCJlOUP4jMmo1oSsZ2zS7JTHKcxi5/E6XToHbl
         a3cGrWYF7by32q1dJpJkTDcMmdI2YNtQwZuv9eqVu9mufLy1mDj5HVSUkv/b/6IVMbmO
         b9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741794549; x=1742399349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ofjgk4zuzVS+cwXy38yJsSZN8fRmew2OrhBauRs/AxI=;
        b=FBiPJG9pIzSmTrc04SnMahFh2JzoSOzPuGqsG3ZpmfVvjag3E9fhrP59w7Ww+MQwGw
         EPkKTYhwWkyBAw+FNnoRWrgWWhS1bfBZu5zvCuhK5kLr7jRdHkf4uZ7Ird47NyMwQ7No
         2rFikoOqlybR1mPfsuDYXonApS04l6kx7LrFQyOsl4G+Au2zge5Qy/NFjcuk8EVyNkpU
         weTcRj8I+eF+Jibjmk1fPaDAxJvwmYO0zE2/lNKE+ESN+NKX97OHfPqoCDNPHUZTrFUX
         QvqP+hHk9nTOSJkJ4hhkmzYRjAWvYOWydjhUM1L5Nc8eiloejKdqlxekXNV3Hs6fRpq6
         Onhw==
X-Forwarded-Encrypted: i=1; AJvYcCXveo77wjLW0hFG5JKWC1qzdS+2kj0/KATs8UTIpGLyp7os9Bm2nvumibrjyEvvZYcx4r81I1afzm5O2ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrKLk+ecXcAjMPDpf7qVNFkKTsd9e2+evH8U1vKO1IbxO/jxIs
	mC186BHb5E0uuelVHIAy6JTVMPJMCzEg70zz7m062TR1KEpcBIGaOWZRFTYBwsw=
X-Gm-Gg: ASbGncvN4mN4ekiBQhxkQEv3rI/aj3o46cF7ldNXLqSwyHqPr+hvwDz6nSD2sxaDe90
	rcdC+RLoV+IF5A+z9UiSb6cfURNbivxuHzNCsFgZefLg64EzxT6qS3dxUWNjxzBrOZ1Tw4ZOs1E
	tm2kTq7fyjEeo8HK0DNDXtDwV3xw2UBN6r7nFNN/ym2fBDVj6zAUcAv+rW/+vnJbDKqanjLJ2BZ
	g58nBQtbSE5MJu2s7nMGs5ThEkqi5JQzWXOvnQuOujEIyZqbppdJ4onPPpvP/t6c8BK6haDOLuM
	e8WUR0MvLgz9lPJJUIRaS4BrWU4pPc81UqXlfeKhoXcroK7uVsOGapJZzWHL/B+wL97IO5fULwi
	4FUMujTLl7gswwCbHwf8qB4tt+6Q=
X-Google-Smtp-Source: AGHT+IHgLZkEvIln4jLLyfDar99K/dWJ5BxlXAP1djqq5pBtYYfVdlZnJt+v1rDagFjkM9RWUey0ww==
X-Received: by 2002:a05:6214:500f:b0:6e6:6c7f:111a with SMTP id 6a1803df08f44-6e9007022f2mr241507726d6.40.1741794548627;
        Wed, 12 Mar 2025 08:49:08 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f70a44adsm85938316d6.64.2025.03.12.08.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 08:49:08 -0700 (PDT)
Date: Wed, 12 Mar 2025 11:49:06 -0400
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com, kernel_team@skhynix.com,
	honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH v2 1/4] mm/mempolicy: Fix memory leaks in
 mempolicy_sysfs_init()
Message-ID: <Z9Gs8i1FhJJ0eaiA@gourry-fedora-PF4VCD3F>
References: <20250312075628.648-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312075628.648-1-rakie.kim@sk.com>

On Wed, Mar 12, 2025 at 04:56:24PM +0900, Rakie Kim wrote:
> Improper cleanup of sysfs attributes caused kobject and memory leaks when
> initialization failed or nodes were removed.
> 
> This patch ensures proper deallocation of kobjects and memory, preventing
> resource leaks and improving stability.
>

This patch does multiple things, please split these changes into
multiple patches.

> Fixes: dce41f5ae253 ("mm/mempolicy: implement the sysfs-based weighted_interleave interface")
> Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> ---
>  mm/mempolicy.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index bbaadbeeb291..1691748badb2 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -3541,39 +3541,40 @@ static int __init mempolicy_sysfs_init(void)
>  	int err;
>  	static struct kobject *mempolicy_kobj;
>  
> -	mempolicy_kobj = kzalloc(sizeof(*mempolicy_kobj), GFP_KERNEL);
> -	if (!mempolicy_kobj) {
> +	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
> +			     GFP_KERNEL);
> +	if (!node_attrs) {
>  		err = -ENOMEM;
>  		goto err_out;
>  	}
>  
> -	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
> -			     GFP_KERNEL);
> -	if (!node_attrs) {
> +	mempolicy_kobj = kzalloc(sizeof(*mempolicy_kobj), GFP_KERNEL);
> +	if (!mempolicy_kobj) {
>  		err = -ENOMEM;
> -		goto mempol_out;
> +		goto node_out;
>  	}

It's not clear to me why you re-ordered these allocations, it seems
superfluous.

>  
>  	err = kobject_init_and_add(mempolicy_kobj, &mempolicy_ktype, mm_kobj,
>  				   "mempolicy");
> -	if (err)
> -		goto node_out;
> +	if (err) {
> +		kobject_put(mempolicy_kobj);

Is this correct? If kobject_init_and_add fails, from other examples we
need only free the mempolicy_kobj - because it failed to initialize and
therefore should not have any references.  I think this causes an
underflow.

> +		goto err_out;
> +	}
>  
>  	err = add_weighted_interleave_group(mempolicy_kobj);
>  	if (err) {
> -		pr_err("mempolicy sysfs structure failed to initialize\n");
>  		kobject_put(mempolicy_kobj);
> -		return err;
> +		goto err_out;
>  	}
>  
> -	return err;
> +	return 0;
> +

Please keep functional changes and refactors separate.  There's more
churn in this patch than is needed to accomplish what the changelog
states is the intent.

>  node_out:
>  	kfree(node_attrs);
> -mempol_out:
> -	kfree(mempolicy_kobj);
>  err_out:
> -	pr_err("failed to add mempolicy kobject to the system\n");
> +	pr_err("mempolicy sysfs structure failed to initialize\n");
>  	return err;
> +
>  }
>  
>  late_initcall(mempolicy_sysfs_init);
> 
> base-commit: 80e54e84911a923c40d7bee33a34c1b4be148d7a
> -- 
> 2.34.1
> 

