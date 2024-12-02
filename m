Return-Path: <linux-kernel+bounces-427971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 643F39E085C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2994AB3BD1F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A3017D896;
	Mon,  2 Dec 2024 16:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="adiNGlBC"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B4E172BB9
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 16:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733156070; cv=none; b=LQqnh6mm5hrq4be6Ce169a5R7nSJgJjLTXgnZyHaaIgewN0bQHirR2V95Vw8kyVAMJvr9Qqyyqq2EM3ZvEkKRp8DYtqOTk8uRrEBAO+7KNQxqEZDes2IZtcSxVZkLTFOCOQmtdgvl+zQsXeCfcVShhW60tR3yR3kU+oNbvBqPdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733156070; c=relaxed/simple;
	bh=U3sOB44bYAOnN3+ClQhKm7SVxe7PbDw+ZhV1KxGkl58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFUu2p1lggWzzjQerA8JfrJFklcJTa5VBvc/Wjhcp6ZO/INWfJJkMBO0+xukKgJA29AV9pSj5CR4w6lHc+zAwCLprwZUvE+isk130ZJyI1E4FnJvDwzLk/IUTK9l0qOhe3DLCXw5HSup5gyIg2yH+cv9QGgNH/ep52peXsoSoM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=adiNGlBC; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53de84e4005so5039702e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 08:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733156066; x=1733760866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F8VHlod5uJC4/6n5wVNLJGfi6u4uDM+LMK7JP0/rK8c=;
        b=adiNGlBCRS8GLebZGscrLqlsdmxZ0xgwzdSWfZKcKqDY803xOhoUtyYBC81wy5l4FT
         ONkscoQeehEGh+du4jAiVHGuzG9h+zxDCGBoFdvSBRIHpCqxKXQtZdfoaArcRoWRjqs8
         JSdDeI/kUOxMhJftqIYZNIj705ZEwXvZYa9lpDcUSaSeUXsm+78uYZmbyWiRuGuDnevD
         tu7ZfOdt6+jH7mSojb3WY0o1kUOCXcWIvg/abQrAR/+R3/CM5WYLBpVU6E1hdH4o5nF+
         BRJjqiqa9sfTQjprRIwo09OhV8MKNiIfDCTPN1AmFpLZvUWp/waoCQ+l871YjR8Ps7U9
         qmwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733156066; x=1733760866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8VHlod5uJC4/6n5wVNLJGfi6u4uDM+LMK7JP0/rK8c=;
        b=oEMGbXOq54DEblNRL2T+NgBevH8WwXrngGcnYyepWCpxp9yK6rc/Cax07U1J7H/uBE
         UdRyDrK7Izy1lBPBGb2hUqf5nYkiVhAdutJntctVo/+MKrpQgnrQBWsuxFOyWdS8TYr2
         Hc1in5Nbmk6wUeqFgGHwfX5x/nehttKqO2FXdkPwHrFvRd/ZhxbG6kB854V27vAOlYOG
         ikQ9quM+kgfw9Ov/tRHuVYqGjAhdDeStSSPMogNAvBiExcxcGSM9/H+a5X04+xHP7++h
         AkIP6o1tiqiCsfZocojjBmVQLvzuW5113F2rIDWdgPJmjqbL7KrxZFoc13pQrUHiuJ0b
         AmlQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9gMVYTvaBA18vbVMdlu8nq00wfTnGhjKUMynrEuo0jSAC/r2UGnJAw3VigvdtO6FwhwQLOxWHuhd4JQY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoo4GXx3yh2HPduLG6eJE/RzjTxyxmXcWUmt3dXVJT9KytwwYh
	y2O1ckSGfGMlfxu9wfBHFl38f6tv9HErzyxGO2dylFWC7PIkqv0VV08tkZrHRR4=
X-Gm-Gg: ASbGncsLYTzb0LHeDb2Qlu5rXoVAMtUf2HQQ8iYyWsA0qSQcTO/nGPLGfKsEaKq/14c
	E7StIx3jEXEfY+kyNkMcok5DFSMh5k+Y/dpBREckgC66voBSAzh/vTr64TttjCXsNzsODrmnUH6
	DLRJNzPULeUT9aDNRukHhp0cKP80jFnFHkHcxtNKIsEQ6gffvgSUMGAP0S5MUQbZtUQBTDWI3nb
	LewWilTD0ndylXUTXnh3miomFijGMmbpZAVbQTNyi0N38RI/Cj2ShKogoj2GYvvNT/JpV2Fp2yN
	nYFhhY/8IXT0XpTiRy3+iPkaICuBYw==
X-Google-Smtp-Source: AGHT+IGljYe4BdTzBDXyCqgaBRdYgKurtEw8NIhKOjqu0TbXgCFVoYTwi8WuQ2J0dQRrYvQOHVQyLA==
X-Received: by 2002:a05:6512:2356:b0:53d:a58c:c5a4 with SMTP id 2adb3069b0e04-53df0108fe6mr11691188e87.40.1733156063012;
        Mon, 02 Dec 2024 08:14:23 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df649633asm1510854e87.176.2024.12.02.08.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 08:14:21 -0800 (PST)
Date: Mon, 2 Dec 2024 18:14:19 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 drm-dp 1/5] drm/hisilicon/hibmc: add dp aux in hibmc
Message-ID: <anxttocvrziwstm3h2q4lles2zyeld4uuv2hwrs3vthldekz6w@bjn262y4efcc>
References: <20241202131322.1847078-1-shiyongbang@huawei.com>
 <20241202131322.1847078-2-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202131322.1847078-2-shiyongbang@huawei.com>

On Mon, Dec 02, 2024 at 09:13:18PM +0800, Yongbang Shi wrote:
> From: baihan li <libaihan@huawei.com>
> 
> Add dp aux read/write functions. They are basic functions
> and will be used later.
> 
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> ChangeLog:
> v5 -> v6:
>   - adding do{} while(0) in macro defination function, suggested by Dmitry Baryshkov.
> v4 -> v5:
>   - fixing build errors reported by kernel test robot <lkp@intel.com>
>     Closes: https://lore.kernel.org/oe-kbuild-all/202411131438.RZWYrWTE-lkp@intel.com/
> v3 -> v4:
>   - retun error codes in  result incorrect branch, suggested by Dmitry Baryshkov.
>   - replacing all ret= with returns, suggested by Dmitry Baryshkov.
>   - moving the comment below the judgment statement, suggested by Dmitry Baryshkov.
>   - moving definations to the source file and clearing headers, suggested by Dmitry Baryshkov.
>   - reanaming dp_prefix to hibmc_dp_prefix, suggested by Dmitry Baryshkov.
>   - changing hibmc_dp_reg_write_field to static inline and lock, suggested by Dmitry Baryshkov.
>   - moving some structs to later patch, suggested by Dmitry Baryshkov.
> v2 -> v3:
>   - put the macro definations in latter patch where they are actually used, suggested by Dmitry Baryshkov.
>   - rename some macro definations to make them sensible, suggested by Dmitry Baryshkov.
>   - using FIELD_PREP and FIELD_GET, suggested by Dmitry Baryshkov.
>   - using DP_DPCD_REV_foo, suggested by Dmitry Baryshkov.
>   - fix build errors reported by kernel test robot <lkp@intel.com>
>     Closes: https://lore.kernel.org/oe-kbuild-all/202410250305.UHKDhtxy-lkp@intel.com/
> v1 -> v2:
>   - using drm_dp_aux frame implement dp aux read and write functions, suggested by Jani Nikula.
>   - using drm dp header files' dp macros instead, suggested by Andy Yan.
>   v1:https://lore.kernel.org/all/20240930100610.782363-1-shiyongbang@huawei.com/
> ---
>  drivers/gpu/drm/hisilicon/hibmc/Makefile     |   3 +-
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c  | 164 +++++++++++++++++++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h |  42 +++++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h  |  27 +++
>  4 files changed, 235 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c
>  create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
>  create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

