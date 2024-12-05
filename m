Return-Path: <linux-kernel+bounces-434074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 966DF9E6145
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CBF51681AF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 23:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B671CDA1A;
	Thu,  5 Dec 2024 23:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ul2hPRsi"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0771119048D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 23:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733441237; cv=none; b=EbCWM+raSCGfH7YHx+VpLSPKKxiLQHrKaiiEwLgdGXnmGaqQryGohmL2mG4wjTitgpiwyLQ4R9G0Nef7VaikCSBF6mtDFAvfI2q9aPYxaUYz3cpjGy0FQeOXIyXcIAaSxvjZR1TzD8wl4VZSqKFfua2VatlBMSyRE/zqHDIC/kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733441237; c=relaxed/simple;
	bh=eA1kmrXdC/vdKizMTfB4ZlUYmNdEoOoA/xdBxExAfDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XY+zOiJoY8kNUBA6xjGqYF+JDT3dIGgkPVKmgMWphX2+g6UW7Lo900jkPTy7ettu3KF4nfo+HKnjJ8Npd81tUzG1nYtoPAgj9floLV4eyoDEW4hEKfE55MMsxx9vvgcWq4tcPXFO3PLm9FOOvpTJTe+v6Jc5VOcWuRwj4wvIafA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ul2hPRsi; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ffa49f623cso15321211fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 15:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733441233; x=1734046033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j3DpjOofESGwFVvsCOsndBYuU+rJQeNWZk/BtIw+LZY=;
        b=ul2hPRsi32Acq/RWcjU8NuGn2P/p+BShWAp4KygEO4Dvs69K8GRNRRzCyoRctRskDm
         wbdUgdifA8Vx5Hu1MgUm6BSgrzsaYLMuiEs/ShbJxjQHVXHq8aud1ULaehh1xwMRw5r+
         AVf1AjPINp/qqBRdiaA4wJ+CgG771a0kQ5BhPVELNCbJTts8A1vWvRM6tUzQbV3lITsh
         NQmMiRB/E/tkcnQhOs2mlcO9Xzq9lQUqvkot9/DLybVdEPxFZaLcLJkwxZbyRB916zv3
         VWQbFWa3LZbDm+nlOvP/HhNzr4lnMTYWVjuigxKYTEse8cWO5Lq6JhypffCwmG3bZHQJ
         quRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733441233; x=1734046033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3DpjOofESGwFVvsCOsndBYuU+rJQeNWZk/BtIw+LZY=;
        b=XBlXEOf4ju3oTNRtjd3PXUgdN992OAUdlxtsctaAAozQ3NSM6m5Iz5jCw+mRF1SQ+O
         1Tj5f+rdyxg8rgetgIuZe0eHvZrr9dNngQ0tWSaL+3/ab5Sdo78srGhJNvWLx/GVIwz4
         yNdEdwCuqZcDG922HpDDmV/3BANQSInQNSEeGakF/x/2p4tO5v6MuKfXbL/c8vlciV/E
         /TLU6pPgqAiEohRChmjfEi9N/BEsh6YH+1a+bUub8E+GvR07bxSv3JZaIXjaXE3znDWS
         mI7RkX0VTZjYxy993iwWEa+F9olKGOjmALkVdEk6jJG4YlvF/uvFJP2wPO2aYDaTx+tz
         FLiA==
X-Forwarded-Encrypted: i=1; AJvYcCVw4FIvv8eEByWAybNBbB3ju782J14ce1l2lLHa2IUNm5bwjq8zjgJfWyvOmsuJa650gN8Cj/y/WcndiSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWwXRX/vkNnKBjvQFy0XMUUPmNfTpi/Lr+gVsGSEBLsXwU/n4S
	8fCHDPX/ugP3Nw09eQ3uNj6vXcuU4KjTTqsRYQcWjv/TgOdDSRYhT4Llw7GRtms=
X-Gm-Gg: ASbGncuGZmg+e3XZeVz9cCUOV/akWaHuPE4kSQotg0/Td4b7Ry8zBwTvIRu9B4r32tL
	v1nLFPSbJq7NCC3pytRQHio25Y2q+89ZcUkeon07TrAnG+DhNaWiSlYOfo3UZAXNHCYNE2+NOKP
	G1ygJadsJKKpZvvCm68DrxLN2Zq9nChVLUSpA4VcMfu5Kp16L0hB5oLFW/a2dqcxNwQEl+M4xbG
	yk8ejoQPJCPuaFeqZOQdVEhpR20Q6ahksGQuCCce/cAAkvz6YxPqdi9AUXP4sKoqFbTBm4IhHSD
	cLZ7jrzOx0/O+b/zWRFH2PYpZ/p+Zw==
X-Google-Smtp-Source: AGHT+IF04IJWw+FTd0GCRaXztZvGyXSX3rN72FVRGU3oryP/PZu7ykMonxAr8uVUa1aM3F9tC81oKQ==
X-Received: by 2002:a2e:bd13:0:b0:300:1f12:bbc9 with SMTP id 38308e7fff4ca-3002fd956abmr2485661fa.34.1733441233109;
        Thu, 05 Dec 2024 15:27:13 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020db4074sm2960271fa.61.2024.12.05.15.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 15:27:11 -0800 (PST)
Date: Fri, 6 Dec 2024 01:27:09 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 drm-dp 3/5] drm/hisilicon/hibmc: add dp hw moduel in
 hibmc
Message-ID: <q25y46kqfizmwu6os24zvd7r32cwjxrcojbous67hj5vfu7aby@dpf5gp37qeq2>
References: <20241202131322.1847078-1-shiyongbang@huawei.com>
 <20241202131322.1847078-4-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202131322.1847078-4-shiyongbang@huawei.com>

On Mon, Dec 02, 2024 at 09:13:20PM +0800, Yongbang Shi wrote:
> From: baihan li <libaihan@huawei.com>
> 
> Build a dp level that hibmc driver can enable dp by
> calling their functions.
> 
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> ChangeLog:
> v5 -> v6:
>   - using drm_dbg_dp() to print debug info instead of drm_info(), suggested by Dmitry Baryshkov.
>   - adding code comments in hibmc_dp_set_sst(), suggested by Dmitry Baryshkov.
> v3 -> v4:
>   - changed the type of train_set to array, suggested by Dmitry Baryshkov.
>   - using actual link rate instead of magic num, suggested by Dmitry Baryshkov.
>   - deleting hibmc_dp_hw_uninit(), suggested by Dmitry Baryshkov.
> v2 -> v3:
>   - fix build errors reported by kernel test robot <lkp@intel.com>
>     Closes: https://lore.kernel.org/oe-kbuild-all/202410250931.UDQ9s66H-lkp@intel.com/
> v1 -> v2:
>   - changed some defines and functions to former patch, suggested by Dmitry Baryshkov.
>   - sorting the headers including in dp_hw.h and hibmc_drm_drv.c files, suggested by Dmitry Baryshkov.
>   - deleting struct dp_mode and dp_mode_cfg function, suggested by Dmitry Baryshkov.
>   - fix build errors reported by kernel test robot <lkp@intel.com>
>     Closes: https://lore.kernel.org/oe-kbuild-all/202410040328.VeVxM9yB-lkp@intel.com/
>   v1:https://lore.kernel.org/all/20240930100610.782363-1-shiyongbang@huawei.com/
> ---
>  drivers/gpu/drm/hisilicon/hibmc/Makefile      |   2 +-
>  .../gpu/drm/hisilicon/hibmc/dp/dp_config.h    |  19 ++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    | 220 ++++++++++++++++++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  28 +++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h   |  41 ++++
>  5 files changed, 309 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h
>  create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
>  create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h


I'm still not happy about the 0.9947 math, but hopefully that matches
the TRM.


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

