Return-Path: <linux-kernel+bounces-227902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6467A9157ED
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D67A2888AC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A3B1A0717;
	Mon, 24 Jun 2024 20:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bTCYTQKY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ED919F47E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 20:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719260688; cv=none; b=PZr+v2C6GhdRRDaW1qLKWAW91rbJ7ljLxrSSwFyrfKXo42KE3fumCQwUuPPWp75KkKFLYIlwjv1aR/8zVPfv8hSbLeDlj7xOoYVXE/FIUfwK54Y1I3p3JxnrRLWBEBxGBeK8tWVpl8XtzS5Uyxn4Fa8B4cD44WuHubBZMOjlhEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719260688; c=relaxed/simple;
	bh=QEVwK012UyH8fhgRNQMFRR5N4cfAoBllZ9BwYk7LFj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zwo3M9MJNmu5q8h3WNnRQwvTDejybItrqJ/mcbJfG3MSvUMtmda3DV+bXMnnJzFR+AX+aooZ4lgHoq477YJFjZ7isA6tfknmeVZyc7oHrVdog6OYH7IbcALIwbUWpR4jP/KUeh+4MCmMHCsJOf15Bd7e7XOAuCydJou2I6iMYhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bTCYTQKY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719260686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wl535sar9hHDgy6fU3ifNKQ946F0NQTLjDx1+oD2oEc=;
	b=bTCYTQKYPpLAKURAzpKw8ECar1+J8ltgNNJ5D7EzYiyep7d0CTwRAl1tzQ9T8rlgNmcoQM
	II+mqXwm2gRNH05VGDgFtACIhyCh8ziS6lK5jKZ4DBO84C2TBLgxxNk/4oMjBi42GsjfGW
	VuSn1uxIRNKywpdg98RCLvFWGlKB02g=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-OqpLpKDxNBuIPzVCRAApfw-1; Mon, 24 Jun 2024 16:24:44 -0400
X-MC-Unique: OqpLpKDxNBuIPzVCRAApfw-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-48f600f4acdso1236526137.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 13:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719260684; x=1719865484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wl535sar9hHDgy6fU3ifNKQ946F0NQTLjDx1+oD2oEc=;
        b=k3X3Fil18MO69C8X/xUp/9gcLIvRSWvyuvt1ZDgG62mGjOJoiQGIh1N1xxuFCzK2lA
         0SkRubkvGnZLkEPdI4ZdU4prSkBf4jTq8qtreLr9XIhaLRVw87K0kgkRkZ/c6IQkeTjK
         p6Er8jxic4SoqFFMcb76nq7sYm2xw6rKw0DB47mDHj/2ogy0F+epnW2eUPMU0kOSobrm
         C2pmUyH80VKiyrOaL4ck0e0rLUwiPZWiMBH2NYBn5zoHeqK5YorjU2w5/e/rekTRn3wr
         NBfcGSRGuGG4jr11Y0/P70SMXsAazzj5E9/HkGygOj+WpyLNAdlcinIqMNLjKxkm2HBz
         hPVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmkuWm7rUWbmMJUHUIeWbjqxHXLtXBUYC71mVzAVFkHw1gVb0izBIjNwBc1xD8pfIqPfEa9PsVwbV/jG2D3KH2jku8RJ+cC4IGgf0N
X-Gm-Message-State: AOJu0YwSs9/AIxsIeRIuEMeA4XeTf9DeCutlU7IzxrwZ0yYdBQ2v9Iet
	2sGlXyuPv4vHP6mlMpcsW6Av7RZ1yLNZo/LroCM3kDmeYlJDuxnWrjhyYaPbeTsvEMD+e1YVTik
	CJfVlkJJm9xG4UfP72YAIvhEHUcesClnDimUyDnUvM7O4Vmrt8y1x62SGemFH0w==
X-Received: by 2002:a05:6102:1263:b0:48f:36b1:6e48 with SMTP id ada2fe7eead31-48f4c089750mr5610966137.9.1719260684340;
        Mon, 24 Jun 2024 13:24:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiCxI1mhYH0HYwROkBfLvVdm9UBEvY4UoW5/YpwZWIV6y3kWG6HjWEa3RqkL+O3xo0hC25XQ==
X-Received: by 2002:a05:6102:1263:b0:48f:36b1:6e48 with SMTP id ada2fe7eead31-48f4c089750mr5610947137.9.1719260683970;
        Mon, 24 Jun 2024 13:24:43 -0700 (PDT)
Received: from x1gen2nano (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444c2c42242sm45698661cf.63.2024.06.24.13.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 13:24:43 -0700 (PDT)
Date: Mon, 24 Jun 2024 15:24:10 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Elliot Berman <quic_eberman@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] firmware: qcom: tzmem: export devm_qcom_tzmem_pool_new()
Message-ID: <fdo65fvkre5fwasyhmivcggjz45yux4edgdmrvxspefobvj7xl@aicvcs5dyz7q>
References: <20240624190615.36282-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624190615.36282-1-brgl@bgdev.pl>

On Mon, Jun 24, 2024 at 09:06:14PM GMT, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> EXPORT_SYMBOL_GPL() is missing for devm_qcom_tzmem_pool_new() which
> causes build failures with randconfig. Add it and fix the issue.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406250127.8Pl2kqFp-lkp@intel.com
> Fixes: 84f5a7b67b61 ("firmware: qcom: add a dedicated TrustZone buffer allocator")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
>  drivers/firmware/qcom/qcom_tzmem.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qcom/qcom_tzmem.c
> index aab6376cade5..5d526753183d 100644
> --- a/drivers/firmware/qcom/qcom_tzmem.c
> +++ b/drivers/firmware/qcom/qcom_tzmem.c
> @@ -324,6 +324,7 @@ devm_qcom_tzmem_pool_new(struct device *dev,
>  
>  	return pool;
>  }
> +EXPORT_SYMBOL_GPL(devm_qcom_tzmem_pool_new);
>  
>  static bool qcom_tzmem_try_grow_pool(struct qcom_tzmem_pool *pool,
>  				     size_t requested, gfp_t gfp)
> -- 
> 2.43.0
> 
> 


