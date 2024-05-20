Return-Path: <linux-kernel+bounces-183641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C218C9BDC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 13:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D44381C21DA3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1FA5339A;
	Mon, 20 May 2024 11:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aCJqIUWi"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241AC182DF
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 11:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716203036; cv=none; b=Fn9EH9GsLsDCXpEPxIouETVSGvshIXSW3bKcnwO/bZnN+OTbm0yeZLGmGd675BwtQPB3YNmB3OlIUMsYlwVCV6ixJeIy+wx47EeRVuNY4+zTOXt3ltJWZFkUOlWbkgA6xPtvKeCXnqh94K6PXzLi7i80gINEsc+iQJ4SmrbpUKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716203036; c=relaxed/simple;
	bh=f2GOS3i38CUol91F/tTOAP4Cj+v7450c+gpjTS0SyZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvTC/9409y5HgjKCecTAQ5+Jq1n50Jv5zYpTTj6EQ1zpLHjV2dYtiH8vLEBXxNzXDdagLMcTBgfQQm365juykal4WulzGg7KL52H7F0tozwaPoI7zlDByGvvRHfJybyt15IY+PMc4ZG8qos8QM7H5yxX3U7SZinwrJx9eLswfl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aCJqIUWi; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51f0602bc58so2340412e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 04:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716203031; x=1716807831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TrnpWE7dPEJmYiT/RDr1bXYldnFvFFfi6hz3R8sA0hI=;
        b=aCJqIUWi5e6c2b1NFY6t2Q6uYqJ3ET461rIg213VoJzRFsTA4088wyU1TRtUa/nXsr
         6j2NprnaEEAumSGWTCAaoKJvzUHjxJRGFB8K3XtHw6l/sR07GDBzJuyMA05+R9qytprC
         msfSsUXDrl1fFqRTnhyLDXkQRuEsUDLM3BkCQMaABKolpFB2tz4GbUKkzfvdblOGPnRJ
         VCFC2U03G2+NVf1CbVC6cpQiQxcte7gnTd3ZgvDpOgKd5a1/NVrOItJjiu+I6F8M3KWE
         hgwl8QRZW9HkkxjPdhhb2AI7cq0cvXduiKRiKLEOoEY5SVfcSt+pdZ2Z+TxdyP06KOZd
         qqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716203031; x=1716807831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrnpWE7dPEJmYiT/RDr1bXYldnFvFFfi6hz3R8sA0hI=;
        b=xEv4hM7LwkT88K++7VojfEGAev9VlimczcnmqglQktnJNR85PmgH8lWFgIhIMrINaG
         yhGUV0Hvb1MH14vcGTanvrqE2HVHE29Cvs28rJ7pxXgQZM43DPl6IUQuMbHxMHSVALtT
         W10CGWVJcxnzeCbBggT81RvPPCX5HQJcyvr/OuHXRPkBXJK//gnoyNYFOhN3zF+qB/ha
         3nDSdwyrv1pJ8XaiCa6vxQMX4D1jW1FKIin3on96RdoPpG2oFkeq9dlZctUrGXvNZhIJ
         Kd+m4KMwPJaM3W9EjYNyyESEGPufgN6uLVyT/xcitC91ZNdF8EBxE1QH1PW5qZYBYxaE
         UGpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL3JqaMYTNc1nt+gUGAR2xOqT05Qs/nAjvnZ/BPzlZk11AobK3DtuVL71L8z+oywxun40/XgFua4Zn6tZvletDqUn6cHtSmqmerB/R
X-Gm-Message-State: AOJu0YwSKjsKcYTtp6Bpy7eks4WDe7frELqj2/htdHHyiWelLu2JnQXW
	vqdT6ece8PI4W9vk+4IHU+7BCE/C4Q+ryq69BM9GhpCdy0QJgNkBiusERdjYzaU=
X-Google-Smtp-Source: AGHT+IHrPX1EE5HJbqIWKfZcM1kS0oKboB5I8XtzpfJrKSrhX0xiWZVBV8AXw8xry+E6Y03ekdH7bw==
X-Received: by 2002:a2e:9d8a:0:b0:2d8:611c:228a with SMTP id 38308e7fff4ca-2e71714cb85mr17078161fa.8.1716203031220;
        Mon, 20 May 2024 04:03:51 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e4d0ce30e1sm34354131fa.38.2024.05.20.04.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 04:03:50 -0700 (PDT)
Date: Mon, 20 May 2024 14:03:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, robdclark@gmail.com, 
	david.heidelberg@collabora.com, guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
	mcanal@igalia.com, linux-mediatek@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] drm/ci: skip driver specific tests
Message-ID: <mxolwwmi5rjaevuwi7qy6rm5n62rhnpbi7hz4n7xbshmi2hoqq@5uzamkipouek>
References: <20240517092502.647420-1-vignesh.raman@collabora.com>
 <20240517092502.647420-6-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517092502.647420-6-vignesh.raman@collabora.com>

On Fri, May 17, 2024 at 02:55:01PM +0530, Vignesh Raman wrote:
> Skip driver specific tests and skip kms tests for
> panfrost driver since it is not a kms driver.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---

I didn't perform a through check, but generally looks good.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

