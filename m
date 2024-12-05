Return-Path: <linux-kernel+bounces-434076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7FA9E6148
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AD3F16A32A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 23:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583D61CEE8D;
	Thu,  5 Dec 2024 23:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d/4JNjM+"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E8A19048D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 23:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733441268; cv=none; b=rmU/jp7718TRw8wrVygDL4e9BcqKFkkzW27eHXEd3YUkT1A4neabymeurRF9zmI+C73oDutgRNrUxjf+W+FV37rCuvPyhzXVXMvdp1GmH/lN8eIg/ERI15vqsbG/3+K16GaapZtHWIqAB4dIYGqL/y0OzpGQFXzfp2VYceoEUnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733441268; c=relaxed/simple;
	bh=8KHQphBI6YsDuv5Ifu3bgbA/6YLsqBVOP5nqKa8YhY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+r76j6YV22eF5ASv5ffJMe4hX3gxURAa63yjyjGYbod7x5vXAGwUEa+ILfRT3twguWqMYk8FChzFI55F8JhFVP8Z7JjDa49MxOUdPdLAIjg2fBZYUyxQghwWG18pfg/n5m5de91TxhU0FpoCunHwbWdKkmECq/ExBjvoX0IVmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d/4JNjM+; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53e1c3dfbb0so1405864e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 15:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733441265; x=1734046065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BB40swK62CufqVGtD6kuh4EIqNJrDcZbv9FnjJlSj6k=;
        b=d/4JNjM+ZnsxDkuHvxchfBHhiNmpqA3OYSNQSXI5jKRTIKkF/N8BaNuBM0isf5QIjT
         I6uu9pRGVpCAzRCmuC6kEG2bsni2Rmle669Ed2oO/xh3M9k6Jz7UnyNdwtJWFFy2aGfz
         Q892pMFH8tuO4eGsd+N13s5mBHI7j9KtroWhcDKNykUX0ZAl7aGIFzIt0cf7LGaC+Ru/
         HuFPh2bQ1HHoKGwD26SSZ5BeTiTdXijFAPM9k1usBKvRgR627Jb22W0d0f2rGUHzhHt8
         qHi9Fc5X/kPYcQffQVd/RSrWxKoAm5wRLq8vYDKn85E6Cu8DUMECnbelKb3l6TJohCWz
         rsLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733441265; x=1734046065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BB40swK62CufqVGtD6kuh4EIqNJrDcZbv9FnjJlSj6k=;
        b=dVlp523usRDvuzrk/KesbqjAhfqWv4Z2ToePlbfZwJkIWV49xb7xu1wQIoA7u08UEy
         0mu02Mv7gdTBI60T+Hk43mFH7KenLo1scrsb9V2O4iGd4bmtyibt1ylHWXl/RwjeC9kr
         YPTREPpuyl5DdNoJfe1j7bsHF1Yk+lgjQthauHA6QFvsNmKzIHD7kQYGHwfrcm4RKuY9
         ft6NL1WIstKVSOqOVtlYxFtIjKeW0oBw5C2OJf17Ik438jy4UPpaiI3vZKxBRXCQFnSO
         yL4OAINAM+eB62szZkzQp64YaGZyaRTJzJIBjzq2gLWioiq97DslBPUl2pp8G1wb/vT0
         flPg==
X-Forwarded-Encrypted: i=1; AJvYcCVxHGCsTN6vXPZyLMyTnla9D+rY3nrbhDjr2QuQdwUgq05OoyiuzLl+qnQ0eX4AeImr0/GgvgdgZOwkM1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTaYkaoCNulctx17WO1ydO5OWeR4bba325MvPWKD6SNQwlkUOw
	bgFkHVOJ82hdU1Q1/akP/XB+vySs6VEpkvipWmvP+qvStsQnD13+Ctj8RKUXJ78=
X-Gm-Gg: ASbGncv0gev5liDM4oeJlNK8PW3lOGG0i7Hq7jKMtAReNL5U/85zjYfVmowcTef6SU7
	KQalwKfG3UMNeommSZNNB01eId0ef7IPTUAHrNCQ0vFeg9tUprG7Cfk2w1hsjyfrJPh9lixuj+C
	Ep0Xs80OiYOGmYmWtvsipfTfgMV1xVVy356/XEeMWAX4t8xyITeDASSwNkeQ1KFkmn4zDb6WCzo
	AS20BrCfloSx0/Jg4MnKK3IlrYIs+BzdaCYHD0Plh0NV8ffgtuMiLZq8R5D7C33pqrvZAWpvZqD
	XrkIEFIOqaChvtjC6nPCIaW2IsutCA==
X-Google-Smtp-Source: AGHT+IFAkMN5+abvXFJHo1ABzJyEBgaRnlFsG9s1fYoDzInsqKcM6e/5ta8tAsDcvGsNHa/fRiC9JQ==
X-Received: by 2002:a05:6512:3caa:b0:53d:a292:92c with SMTP id 2adb3069b0e04-53e2c2eb628mr226698e87.43.1733441265066;
        Thu, 05 Dec 2024 15:27:45 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229ba6dbsm352874e87.160.2024.12.05.15.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 15:27:44 -0800 (PST)
Date: Fri, 6 Dec 2024 01:27:42 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 drm-dp 4/5] drm/hisilicon/hibmc: separate struct of
 vdac
Message-ID: <65vx23ucbno2kqlbcpul6pxlhyxui3qb3jvebhsya5i5afnfjd@s7irpf7d53d3>
References: <20241202131322.1847078-1-shiyongbang@huawei.com>
 <20241202131322.1847078-5-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202131322.1847078-5-shiyongbang@huawei.com>

On Mon, Dec 02, 2024 at 09:13:21PM +0800, Yongbang Shi wrote:
> From: baihan li <libaihan@huawei.com>
> 
> Refactored struct hibmc_drm_private to separate VGA module from
> generic struct.
> 
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> ChangeLog:
> v3 -> v4:
>   - separating hibmc_vdac and hibmc_dp changes into separate patche, suggested by Dmitry Baryshkov.
> v2 -> v3:
>   - fix build errors reported by kernel test robot <lkp@intel.com>
>     Closes: https://lore.kernel.org/oe-kbuild-all/202410251136.1m7BlR68-lkp@intel.com/
> v1 -> v2:
>   - deleting struct dp_mode and dp_mode_cfg function, suggested by Dmitry Baryshkov.
>   - modifying drm_simple_encoder_init function, suggested by Dmitry Baryshkov.
>   - refactoring struct hibmc_connector, suggested by Dmitry Baryshkov.
>   - withdrawing the modification in hibmc_kms_init, suggested by Dmitry Baryshkov.
>   v1:https://lore.kernel.org/all/20240930100610.782363-1-shiyongbang@huawei.com/
> ---
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   | 16 ++++----
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c   | 41 +++++++++----------
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c  | 20 ++++-----
>  3 files changed, 38 insertions(+), 39 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

