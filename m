Return-Path: <linux-kernel+bounces-526958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E486A405AC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 06:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF48D427990
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 05:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181D21F236B;
	Sat, 22 Feb 2025 05:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="acyaR94y"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FC0770E2
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 05:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740202927; cv=none; b=lKk0vRqL1zvG0ANNx2frMY077wlAnZ/SlCUc7YUueZQhAYoz37Or982G3vJ8ajzR/QIInQm8WP36JgfZkum82/S34wAU1rszcvPJjQWbyF7kI4UxHGi983v+aZbeud3FSd4vs8dXRigWMI+HPwZT/Dm/rEvF4RwhTcZFmiLhTqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740202927; c=relaxed/simple;
	bh=TaGr45ZFclvincgO0zONNx/QRaeaWR653etDcTdQiZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MU+dPqI47tdZV0yFRFuo625RoUCLsyud37I3EBc2Giotif5Ewj7DoCTMoImCY0U5hJm/Rre7Bjd4tio0FN3ssEu4jrdfAajFSQ2Ep+fKWVCR0J1Uj4MbRULeMaQ1hKH78lwHqMRF88Xm2Anm9eiy9LXfPLdbmVxTF6+B9GmDXKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=acyaR94y; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54605bfcc72so4400064e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 21:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740202924; x=1740807724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vO61PwMr9fG3YaV/tA/ZETRTgpImj80gIG6et6cmRFA=;
        b=acyaR94yB+afjgLP6hPa31FmY1MYjt0eUy1Uhdvwqgny8sYiLhmHUr90qz5CpAAeD+
         RNLW7BrfLcLBeZBtJNWHbz0qQs10E0LvsavmUFHoga9L+2KVDuEsMmOiFeG/A/wUOi9Q
         a2+elLw/VM4Yh/yOcLrSvxpuVKD17JaTypXIHNRn0aGCBLG7YhgjZMapN8kha6eUp7HO
         lHTzFqJviye4oBPNT7qEaZAmi2QFW84xppnAwL7wYNqn7sgxeORbZAI2gvO1kBvWu4hF
         xqT0iDyx2ynhrt5DXEMkp7x7+0lps/6XLeEzTemo/I+vGBIizLYtrRGOMJd0lTDFg51y
         e3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740202924; x=1740807724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vO61PwMr9fG3YaV/tA/ZETRTgpImj80gIG6et6cmRFA=;
        b=Gi7bjp3fLP7EjvzKXCmA73NC1UNXij9COpI32CneCL1h7XgwfQkF49w0IoPLzf3lrb
         WHnWJudYJsyvbBK11fJlEgCuVy2fs03u5x4fcTZDUvGceeaUSO5ELoV/ydynGUCG+4mR
         AjGmb83Ie/J3WfQByfp2pB3itmZW7qvHI/X/9ZAnPepoAbvYbTV2Hg9Jrqqc2RXy3U7x
         pdyvC/yrdWvrBYa0VCoNv1zmoZQZAKp4RRWJk9DoeBerfqoqpsQvPEJ0vZP/I+aNo8j3
         0voCQKtpDANfVMa6L5YATittCUdPTxAWBZnvb/WiWlsNBsvFadOR+jNOZzdl6+gf1mMr
         2T/A==
X-Forwarded-Encrypted: i=1; AJvYcCXv0yZYiOSJrIzLxiWDNZcr5mqvjPiKy9b2Ppte6YUxx9QD81vfxLHNOeoJljuyV+F2baXgAJCvq0a22Rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtPL7f9nBzwH+tqN6Ssj0yNMPRsquwGOzKGrkSyp16HQE7przz
	IR9TD60hV5+62Cq14kL4BugkG1Wbm12CLkRxIf81k7lYHZ5xBpSPXaai69cNQ0U=
X-Gm-Gg: ASbGncsFHk+lo/OS+fwyjmCjzYlWa4rJXgFeKV8wZKRDy2+rOGPjmYR+YFAZ3dSUBf/
	YlD04O9KQg7WPlC/Dkxb3bwxoGE2agdQmedLT8i6c2jIOBIi5RY5mHdYaNw2li831Cj6akmMkIA
	SbvLKIfJ05098k53smizVI3IlTqH2sigD6VNk5SR2giI7lUJSP823uz36krWZTsxH5Za2krNU/o
	fRIJUic7baz4s/w8hw+y9VdJqJ7y5kDmIjmo/eEPNgRYa7vGM/fsPa+y/PiybK7CCTCbxXyHu7e
	UFF1OhU8LAb2Lm4T8Q8kq/IccMtbuzzsq5otD8ozx4LZMIqgzpYzlmKBVqJKsBZzfgpNGiKxXh7
	hCisRaA==
X-Google-Smtp-Source: AGHT+IGiIeRReqCJe8XcAs+P8MFQu4S5iiJzOGajXPXAgfgMiOHfmVTqn9FGs7qnDVSijblMJUCdaA==
X-Received: by 2002:a05:6512:2387:b0:545:9e4:e823 with SMTP id 2adb3069b0e04-546e58bacd7mr3221825e87.16.1740202923578;
        Fri, 21 Feb 2025 21:42:03 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54527244fd7sm2580680e87.12.2025.02.21.21.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 21:42:02 -0800 (PST)
Date: Sat, 22 Feb 2025 07:41:59 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 drm-dp 5/8] drm/hisilicon/hibmc: Getting connector
 info and EDID by using AUX channel
Message-ID: <4dsv4ks7nfy2ywcv6rukm243rywt7ynaso6sckpfg4vyzluwez@nvxzkjpjckiy>
References: <20250222025102.1519798-1-shiyongbang@huawei.com>
 <20250222025102.1519798-6-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222025102.1519798-6-shiyongbang@huawei.com>

On Sat, Feb 22, 2025 at 10:50:58AM +0800, Yongbang Shi wrote:
> From: Baihan Li <libaihan@huawei.com>
> 
> Add registering drm_aux and use it to get connector edid with drm
> functions. Add ddc channel in connector initialization to put drm_aux
> in drm_connector. And also add detect callback to detect connector
> befored call connector_get_modes.
> 
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> ChangeLog:
> v2 -> v3:
>   - Capitalized EDID and AUX, suggested by Dmitry Baryshkov.
> v1 -> v2:
>   - deleting type conversion, suggested by Dmitry Baryshkov.
>   - deleting hibmc_dp_connector_get_modes() and using drm_connector_helper_get_modes(), suggested by Dmitry Baryshkov.
> ---
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c   |  3 +-
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 33 ++++++++++++++++---
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  5 +++
>  3 files changed, 35 insertions(+), 6 deletions(-)
> 
>  
>  static const struct drm_connector_helper_funcs hibmc_dp_conn_helper_funcs = {
>  	.get_modes = hibmc_dp_connector_get_modes,
> +	.detect_ctx = drm_connector_helper_detect_from_ddc,

I think a proper .detect callback should be reading sink_count. Most
likely it will work though.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


>  };
>  

-- 
With best wishes
Dmitry

