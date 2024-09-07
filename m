Return-Path: <linux-kernel+bounces-319782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71850970225
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 14:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C08E283D38
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 12:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DB715B54E;
	Sat,  7 Sep 2024 12:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="loIIogrp"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD5845979
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 12:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725711132; cv=none; b=tXNusd4SXdOpo7Eqes2aiTK1J8TUHc4HHAvqvnz2MrMSb/M393JtQFecCNe4Oz4X2krLZ5Qx/7bkBsrf2mDjpka+rmzegC16qVh+iLkecEAxabPn2uCUvz015EMtJ47ecgjUwFis9655js8Te9VrUP1bKM8yTHEZwegJu8jmhgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725711132; c=relaxed/simple;
	bh=KJ399UOI0Wdiv5eE0UhZrvxHLTIAQhQQPvmKq5Hu7JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtCp0RwwGujey9usc2udnNDB9PpX/HrFc3nIVwoB8+LL+Vm755/1vKtcnQhItdoErGfBHGFYWtHlcOqkz5frOPzG2TPTwH5TA/VrKf5i58YC9CG/1xMMGgMvSBvhPCXeZ+ZAhnoT7L3x+UTIuYmzyy2Qo4hl5f3LWs8Na8eAIgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=loIIogrp; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6c3551ce5c9so35660726d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2024 05:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1725711128; x=1726315928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qIk+dP3X9sflyyjWYrNOlRzvjymaxZ0BwT+e1OMyylk=;
        b=loIIogrpy7nrYBiPGBi2d1M3AHjtMrwoLxCfdxMaOWpKicehIbcLNWWsf0AckEHlJe
         3r1SX6lwwiIK7uMZSPui0TVdW7iruueu2dALah019x5I/lJcyFA3JsMyDY5s83MLMD7z
         wMY989iDl8daKTk3EGTxPzsfgwrvnxuILMZF6UebqpClfCEvx1zkhzzKC8F9m3vJr9dJ
         Nn3BDUO/tu+zfQrr1u7LAgXjRlFiOvzKvrNLffi/+LKYC22yj95LtwsW9DKZmq/vzh+M
         /JbzLzrEqbUvZMtAqjp4MOg7PdQbe61crgCs2K7zaVaWc7mp6k43ifTZvqQ7CpcWfFDp
         XgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725711128; x=1726315928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIk+dP3X9sflyyjWYrNOlRzvjymaxZ0BwT+e1OMyylk=;
        b=k1R3yPPOLsDe2Uf22ccB8kRrOC0ILLrtrOSe6pDcVKPtyQhGm6RGL3NeoKq36roYJw
         nbEh//vNjEVbc/EqZA19MFytmtpVTipnows6CJpRTOQcoCp1MLj/ZLtiilD8nQ4RTFip
         arojb1iBSzElnzvDaeBKQtPs/ZotISjrR7B1LcaN6ebmisDVzO8JOKcIRZmCy2CIFNs/
         Zp5Bbv9BFnBVHdGXzogy3Ub03St2/QjM9e7ZUrB9H61nDg/MXk6riKy6EtjbQJZk78Lg
         0+F4HWkVBv4kzVdEmF7ScnxFu7XI4WBcKgsdzbSi9iOnHmorTLTvye7nZqPkhEighGEk
         GQUw==
X-Forwarded-Encrypted: i=1; AJvYcCXHASqR4mdiY9oh4aw9r+KXeTdD+6goYRbPszhIRGsKa+1QDHM3DzzLtgzbiYgaDk1cwOGc7riL/yMrtq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXBg2A78pBRrh4syykVoTUoTtReZL7EhjPzPlDxm/YoyiHPn4f
	tMc5RNLkjSpDoLNTX5vv49I3pC+S3tFCX0awygG0XhbH55/cdzzq2T4pqbsewXw=
X-Google-Smtp-Source: AGHT+IGJu+1xkqqBw4YXIoVjgG9lBWSbDHS+BxHN/Rvx1jZzb2l1o7Z3TkAbgHq3jyO8sHe0U5NV4g==
X-Received: by 2002:a05:6214:438a:b0:6c3:5c75:d2b1 with SMTP id 6a1803df08f44-6c5282faac1mr103618346d6.5.1725711128495;
        Sat, 07 Sep 2024 05:12:08 -0700 (PDT)
Received: from ziepe.ca ([24.114.87.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53474d867sm4109576d6.83.2024.09.07.05.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 05:12:07 -0700 (PDT)
Received: from jgg by NV-9X0Z6D3. with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1smuIR-0001Nn-MJ;
	Sat, 07 Sep 2024 09:12:07 -0300
Date: Sat, 7 Sep 2024 09:12:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 for-next 1/2] RDMA/core: Provide
 rdma_user_mmap_disassociate() to disassociate mmap pages
Message-ID: <ZtxDF7EMY13tYny2@ziepe.ca>
References: <20240905131155.1441478-1-huangjunxian6@hisilicon.com>
 <20240905131155.1441478-2-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905131155.1441478-2-huangjunxian6@hisilicon.com>

On Thu, Sep 05, 2024 at 09:11:54PM +0800, Junxian Huang wrote:

> @@ -698,11 +700,20 @@ static int ib_uverbs_mmap(struct file *filp, struct vm_area_struct *vma)
>  	ucontext = ib_uverbs_get_ucontext_file(file);
>  	if (IS_ERR(ucontext)) {
>  		ret = PTR_ERR(ucontext);
> -		goto out;
> +		goto out_srcu;
>  	}
> +
> +	mutex_lock(&file->disassociation_lock);
> +	if (file->disassociated) {
> +		ret = -EPERM;
> +		goto out_mutex;
> +	}

What sets disassociated back to false once the driver reset is
completed?

I think you should probably drop this and instead add a lock and test
inside the driver within its mmap op. While reset is ongoing fail all
new mmaps.

>  	/*
>  	 * Disassociation already completed, the VMA should already be zapped.
>  	 */
> -	if (!ufile->ucontext)
> +	if (!ufile->ucontext || ufile->disassociated)
>  		goto out_unlock;

Is this needed? It protects agains fork, but since the driver is still
present I wonder if it is OK

> @@ -822,6 +837,8 @@ void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
>  	struct rdma_umap_priv *priv, *next_priv;
>  
>  	lockdep_assert_held(&ufile->hw_destroy_rwsem);
> +	mutex_lock(&ufile->disassociation_lock);
> +	ufile->disassociated = true;

I think this doesn't need the hw_destroy_rwsem anymore since you are
using this new disassociation_lock instead. It doesn't make alot of
sense to hold the hw_destroy_rwsem for read here, it was ment to be
held for write.

Jason

