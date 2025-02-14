Return-Path: <linux-kernel+bounces-514913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B50A35D41
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C5B1648CC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9385B262815;
	Fri, 14 Feb 2025 12:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKOYmfd3"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CB2221541
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 12:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739534672; cv=none; b=HwbNlHg2kPerQ+npQ3av1M68KzzVrxTBUyY74rPKopsli26hJhm/BYm8cFl1je43Z42Uj1ZnZzxtfIyvoy5Ku5jAQzqzCNSLAMIegKT3e8vJYaBVfSQx0spXmkvXWRiHpelU4UhQr4dBEShkue/G7RZg/jJjdKz4+Jy+kDqJrng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739534672; c=relaxed/simple;
	bh=wFAGqe8fwXyyIsVzC6HVfv41qXizSC8Sy/9GVTM/gZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aL6OH864l+Iz3FFdJ0JG1tfrt8OPyoSOPlx4MWGbrS7G2cd3eX/TQe5Gz4Cb7f3k2t5mXXWuKw1k2oR35ryNLdO9IxPSfQx2Ozc6ZDGl8oiE1Cma3/avcwfoY0nkaA7z2km45VIwjyxOy/8NgiECQrXZXJzdTg26AZlFvROV49M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKOYmfd3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4395a06cf43so12617425e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 04:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739534669; x=1740139469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H2/EmkyG86XB4+zPcE4otxsWMOKAE2ROdD+dHLtdsjQ=;
        b=GKOYmfd3bI1gb58RUSyMTlksa5n2/V7Vgg/Z7SrjUHZeeI9dOjIANL3f98J/30CDa5
         4QqD4MQUpgcQNF+S20xf9gnizPU3nwdjV/5OjiWqjyV29SSB3ydfrff8EsHx8HQl/IjM
         +g+qW7Glmf7qPTSTQL7DyZx3Z0ro/PsLSizaYoHl3G8xeRVC4sQJHpO/DL4l7Z9DdKEv
         byB+wO3LAW/q1MNMq0kivRS51uYcDdUd6NlmjFh3t4H4pomFqOpnYf8c3xyUIBpJuA5G
         BktWv9PD/nz4VqBR3QAeE1HZ9RGDQG5OWDF1o1NyaCSZM67el8nJfKW/CG7JJk4kfMd/
         0hjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739534669; x=1740139469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2/EmkyG86XB4+zPcE4otxsWMOKAE2ROdD+dHLtdsjQ=;
        b=mwWjMLEAl1c7lWHtZBG50DHu8HnZ8U7da02RHL/hT0DrUTsjQ2E1A/VxAp2QB1WS5S
         UDF+7r8CI17xhfhxVuH9BcTUtej8q2vS+m2PXXWYUQJDSVsUhqSXRlUTYuHqS4/ZAkR+
         L3cdHgQ1UDz0SSTtlag4cV3DngorQlatr7iKtXDvIb2EOeV1TEyuqawh59bVXMOBbmdp
         DliUhD9MECnlScnzCxiOjIf91fq4hNLsSmTKHJMM8yFf1w3GTRzCJRw8R8zJUTnxoLQd
         HIFrrcOAR8V0QFz2JR6VfbtvLJ/TAOlT9CaNZgbQUg23CivAVM00OjzKp07YgnOkbHBQ
         /XVw==
X-Forwarded-Encrypted: i=1; AJvYcCWH+hV7YXxxM1qPQBqxBPquvMRsrPJTBAtY2JJZzsw5ynY8emfOGk259KYr8VXZPBmm0xXUgr5s/d1cJg0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4KfUwPHCST5ersriJUSYyw6tZ/nq8IbJ9Il3cwGRkV8Jf+wsy
	WoTaKUvh90dxQsELv8JoZBgkBuHvPMk5n2vjfQUBG889DfcGNRT3
X-Gm-Gg: ASbGncuo3K91wiUsyU8cpNbRCNV3xBBxHqGd2Q+xqCU44D61Aj+s3YfRHxRgD2pRLRB
	L9fc+fnEilCke3bfvQyjelJaAe+Vb4BqrTQNZoRHp/+3uJcPLukGJkVRm+VQX0CvSBpGXAujt9x
	7qrLL4XveY4u4vGx9jta4qPt1zGdkIhiE0YaSzH2K6gxt6IYHJ7xpZrOT0oYmKBN7cCsvuU77Tr
	KoyHgqJbp0+tN385Z1JHmILm+gAlgEBLCWD4OVd16pSiF5Pn6fln490O6QXq6G+LSOTkWEtZm2L
	n14i3DEwotw7WjrrdmMwqOI3hXGO2tI=
X-Google-Smtp-Source: AGHT+IHrlbR4VIv9nfE0+FPkbcscuBRo8nT4S+i0mXwVTsqlmVQjTcn0OZ3jXYuJt036YYwFj1nuSg==
X-Received: by 2002:a05:600c:1c15:b0:434:a525:7257 with SMTP id 5b1f17b1804b1-439601a116bmr79885005e9.21.1739534667950;
        Fri, 14 Feb 2025 04:04:27 -0800 (PST)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1aa7c7sm74879825e9.27.2025.02.14.04.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 04:04:27 -0800 (PST)
Date: Fri, 14 Feb 2025 13:04:25 +0100
From: Dave Penkler <dpenkler@gmail.com>
To: Ajith P V <ajithpv.linux@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gpib: Resolve prefixing 0x with decimal
Message-ID: <Z68xSay4rBSecuMO@egonzo>
References: <20250206092815.3267-1-ajithpv.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206092815.3267-1-ajithpv.linux@gmail.com>

On Thu, Feb 06, 2025 at 02:58:15PM +0530, Ajith P V wrote:
> - pr_err() of hp82335_attach() in hp82335 uses 0x%u which is defective.
> - The iobase is of u32 and correct prefix is 0x%x.
> - This error reported by checkpatch with below message:
>   ERROR: Prefixing 0x with decimal output is defective
> 
> Signed-off-by: Ajith P V <ajithpv.linux@gmail.com>
> ---
>  drivers/staging/gpib/hp_82335/hp82335.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/gpib/hp_82335/hp82335.c b/drivers/staging/gpib/hp_82335/hp82335.c
> index 451d5dc6d340..6ce79b17a419 100644
> --- a/drivers/staging/gpib/hp_82335/hp82335.c
> +++ b/drivers/staging/gpib/hp_82335/hp82335.c
> @@ -274,7 +274,7 @@ static int hp82335_attach(gpib_board_t *board, const gpib_board_config_t *config
>  	case 0xfc000:
>  		break;
>  	default:
> -		pr_err("hp82335: invalid base io address 0x%u\n", config->ibbase);
> +		pr_err("hp82335: invalid base io address 0x%x\n", config->ibbase);
>  		return -EINVAL;
>  	}
>  	if (!request_mem_region(upper_iomem_base, hp82335_upper_iomem_size, "hp82335")) {
> -- 
> 2.43.0
> 
Hi,
Thanks for your patch.
This patch is now superseded by
https://lore.kernel.org/linux-staging/20250214114708.28947-10-dpenkler@gmail.com/T/#u

which uses dev_err instead of pr_err and corrects the defective 
prefix problem also.
-dave

