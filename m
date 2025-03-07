Return-Path: <linux-kernel+bounces-551134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1301A56891
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15385166A4E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94069219A79;
	Fri,  7 Mar 2025 13:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xUhpko58"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AF2219A91
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 13:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741353206; cv=none; b=o2DkLciKVl84+uoXqXv/p+SS7onDfUetYcVLsny06VinUDGDcznKmQ6xPXROafgFwzg1x7C4lxvCoZzWBmZkriY2aQhRayVKUdajbtw4MIL/q4ukIx121Q2VRX7lNnw04M4dW7t7wiEjrEl8NPNprq014zsFfiN9ZxW95kjy43M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741353206; c=relaxed/simple;
	bh=nR0Zs3iPrLCRNBvfalsGPRqbk1kgxpF2G1aqF6elmPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDoJGqoCj+CmGwGs0fbDN6dRpai+bpm2MThZkGtb3w7q33qFQ0dOzbS99a785/cYOS8KYALvsYPRmMLV2XhU/2F2LcGOeSJL0aG3xDJtPY2Dy45XKB83qCVr1GJ/3pmtxBHX86KFC3TdjkACEZA9k6VamZbKW5TPQ730cVrJUuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xUhpko58; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5495c1e1b63so1932069e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 05:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741353202; x=1741958002; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7qBnbvBQpj2jwxMDYe1fKnlfY7YPbRd+OabRPrz9om0=;
        b=xUhpko58obq2KIsI53jXOhUHHE3cbE0HMBNAlsWks/G45D04DvpfZswR7ZR+OwX3qa
         DswjVUW0FIr3ClBu7AoMJ4LjBpdOGSZVlWYp2WDyW41jGXvfcytmcqSzvGB/W0jqKIA+
         1Q6rkThfa1iy2moChcoF9FyCvtwT57wnNLhjHMhvuYixx59dq9otRiC/v4OIvQT0/d+v
         CJ+2gYggWrZSO3ZXsErkGHGzZTkVvIZ5V/85kq+XxIBhN0twciR2zEsyEjFQQOrCeTjc
         aIECc45e5oKwN6pmI/EGMaJNFSYQLTpMoe6oJyX97CJ4UtLNz19BHxGWwXqc2hvo8dwT
         HF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741353202; x=1741958002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qBnbvBQpj2jwxMDYe1fKnlfY7YPbRd+OabRPrz9om0=;
        b=VIXztzWe5nKC0SfOmecoDvAfn0y4JnQZrabATIuZ998yadwMUoLMegeeKhAk2Y0VsC
         TQaRW/tl6HHPZhCjPF0IsoZN0MoPgBcg33y8nEl8ZZUF6rvySHzr4thJ9F6T4W997tf/
         Fc4q2TvKtPHboMXmtlVtXtgERj1Z7ecaltVugRa/3u4ImQJC2xl34tKV4pyRQkB19neO
         1cO2g0DUbm1b6UMwC+jaTpzaELTT7dRus79LqIFmu1OQlaAmkGmyjGHArDPyEdYwg5L1
         TbdLiUHOczSRE6PO/oxAPiVS8RKUxUFIwS3J+QlTc79v780TvX89d03koocW2KzU8Nin
         7aTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcaSg7wqBPT8L8tXVgk+No5DIaBu9DSKn+OmHeZLb2tNEn652VP0FT3GSMUBfxmlA1T0CZosN066Xtxig=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiiiltT+ncqatvo2Wo8GCdFr8oJjoLKsZhw6//jd0p3s97u7Mb
	YKBvNNvwBFoSZVt7BjlzPX8D+XVtk7MDnBawREqm9V2Qx0vI/zWqpJ0zInKWEo0=
X-Gm-Gg: ASbGncuedHRiT/eZHQ2rLGFGxFhaZgmcLuqm24yulZpGJRqAGIFF1RYwzzWwwqpRRWe
	ucy/6vvRTTyBQ72kQUM6Zd9opAg3zuGAXNYBcBc8rADac5e5PRIL2wXmHeqFK4oiuN8/xepml4D
	IlmV/AtXrrDvVej7DFg5Nnu0lShrZ8QRTSuzDenbwldo9VtjUCmZxnQGQfiolaChtyUqZ2q8I1j
	CnoMr1++u/1PCpJI+S7LYoj84mFYoF5J1RSNM9sKNVUNWp0Gdx/sOe8M6GINttcOnbX5Rgdbrhm
	rhZNqhBLOUiRm3+VRE2AUM3cVdz9T5CMdX8/4/IVKUtKL6O1X+ZoHqyOpOiPQVPzlA+ZzFNRDix
	KvCHy8msY27JfUR3RKG5PAY1P
X-Google-Smtp-Source: AGHT+IGhwZPATNvZErxDU+8X/e0vev5Hp0nAe0eNi62GDkHDz6sZ0wFGAKUkjgtC1ZWOmPx0zSf+jg==
X-Received: by 2002:a05:6512:1112:b0:545:1049:eb44 with SMTP id 2adb3069b0e04-54990eb8e4amr1139155e87.36.1741353202120;
        Fri, 07 Mar 2025 05:13:22 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b0bd0absm486634e87.157.2025.03.07.05.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 05:13:20 -0800 (PST)
Date: Fri, 7 Mar 2025 15:13:19 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 drm-dp 9/9] drm/hisilicon/hibmc: Add vga connector
 detect functions
Message-ID: <x6mx5b3qson2xqw2xcr3y3bvgee7oyq7rl4va6g5mxjfw7y5dz@dbakefz5g3wu>
References: <20250307101640.4003229-1-shiyongbang@huawei.com>
 <20250307101640.4003229-10-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307101640.4003229-10-shiyongbang@huawei.com>

On Fri, Mar 07, 2025 at 06:16:40PM +0800, Yongbang Shi wrote:
> From: Baihan Li <libaihan@huawei.com>
> 
> Because the connected VGA connector would make driver can't get the
> userspace call, adding detect_ctx in vga connector to make HPD active
> userspace.
> 
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

