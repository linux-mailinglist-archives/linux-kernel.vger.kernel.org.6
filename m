Return-Path: <linux-kernel+bounces-423538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BC99DA94D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 228C7B226F5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC4B1DFDE;
	Wed, 27 Nov 2024 13:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qidVPDIE"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48631FCF6B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 13:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732715520; cv=none; b=VKaIZ/MIY7JOosNA7MjmJ+jQm5OS6k4cRrxe/XWUh6L4x5NxVoi1n1LRbFMhBllGELi48o1JfshfmychImFhQviwu2XevdjM7u0pr2es050w+HBirTH7YX74HE8fQxlochwxpsgPbPLklraSdQlENzOBHJbQnwvK6+CKy/LUKMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732715520; c=relaxed/simple;
	bh=xBsYgLoC7NlLjvzJe9wyiz6rymUCb9R/llzvivHufJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OI9YudLs2Q0zRKkSha3EGpHtxmt7cHCpijmZt6EuHkYo5yMCTkMPgL4fc/YHqPUNVMsSBBpGwKMKO+ey7ud7aL93zvNfjNIMHP7iHVsjZTQhd4lkJBxW87Et889KU7CMF3sNs6/j/gQhXK0wUaZN0CfjgXVGaWUyUSMSxY5c/8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qidVPDIE; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53df19bf6a9so624076e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 05:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732715517; x=1733320317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4oRJCCe2Um5R31F+gAGqkSP9r7+5D01i3fvjJRVsk2g=;
        b=qidVPDIE4lKsyWaJaUZp71g9dxnrwn0hTaSdiKu8F7W+LyByembQ4FrsP4zC32GDat
         AJBPtFbW2ndZmrA7ht1Nl7VVr+HJu2k9TFmvMqVPox4Oh9E/tZv8WBu42a/2hC/YUNfF
         +UnHPqGnqi3/w1u4gSIfZyDyuYH3h8aYRbUdqksHvi9kkqX0//LARdXxKkHBm/yvvvyy
         uqhFn+ssSme/27uqG0FCV8xsoe20eAueTgLwT63hD+SomPleaCL1ufpkp/UH6eJvSb7w
         vMMi8BIL60hbJvdszFbSbb9F0D7eKuCif9mcgzDD7YaympQeC5LQQjRedFamSB90APnx
         rkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732715517; x=1733320317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oRJCCe2Um5R31F+gAGqkSP9r7+5D01i3fvjJRVsk2g=;
        b=A6IBGoNizcv7EXMRCfGl3MwwRHwaNHAC1K2/Zf3rqfjkl8gwLQejH56n2/EmZG4byh
         qBm27qU9Nlgxvg0aUbz2EhzeUeT9zLIqU7askUEXgaXae/VijSQV2cqHNGT7hNV4qv6R
         +sj8LGsSRfmw4E7MczNyvCqVq5npd70fWAII3XNY+xTqg3XB79mknblWMkwu6F7kEKYu
         5s8tQsmGqKIyWWWgbve67ua7WSOtE23xZHP9Wddvk6NzdFAzkOZ/A8gOFXyOqRbVzGRo
         s9UGAyz0NPoPakra3PSw1bPIDPCeyQsg+SmQWzkAB7Qbgc3ks81WNQntZ86BX7ukkWZS
         Lfdg==
X-Forwarded-Encrypted: i=1; AJvYcCXq4cpAyvKHdWk/TfXOfjCXvMqW3a73hlECk0akAZiV2X3AyJxsOxaLRB5oxEAslyzVpm9vCLg/NZER+t0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/yPdbISA4ESeGdSasbFEar1Ongv5LkZZL/5nCKVG5u5ysQ3Fc
	ZKUA0m9vAI2rbg6IsXeVl3LyG0ulxZhaMw1fmWFLCHyD1/LzCIUEwU82omaIX7M=
X-Gm-Gg: ASbGncvd+gU2IEwtRQWN65P/Z/h8GZ85dPKn/jjBURuMRNC0AUMXydMiL67JmlDUfgW
	/GDdXjax3lS7/tXm4nFF7ZdLlTm3LkD02r4uRPXlJI/yPPCE/E/dqgDMGH7YS5qORn+x+TpOAKG
	WUTqVyKT0UboM+OiS7pXGNyYNIqVaYWUCvSADGE6GDSa1cd0bKfimD0J0xg7tUjPvNzNk62oNvx
	1+8GVGWBHAHEYU/wJATvcKuIQzeXOwl9ZYA/cHGcAQCNdpJ5VJA6hC8wypibLM0eP2STn6cA3uK
	yUnB2fBgZGLddSKmnVoHDpHwtbLO8Q==
X-Google-Smtp-Source: AGHT+IHc+fYe+1gTHsCImj4rHorU0Xx7j65zTp85QvQyekS90THXiPR/B4iFgAfn3+Ms0AcxbnUmhA==
X-Received: by 2002:a05:6512:3e2a:b0:53d:d431:7f3a with SMTP id 2adb3069b0e04-53df0108f71mr1810535e87.44.1732715516740;
        Wed, 27 Nov 2024 05:51:56 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53de91f1e26sm558382e87.25.2024.11.27.05.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 05:51:56 -0800 (PST)
Date: Wed, 27 Nov 2024 15:51:53 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongxing Mou <quic_yongmou@quicinc.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Ritesh Kumar <quic_riteshk@quicinc.com>, Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Display enablement changes for Qualcomm QCS8300
 platform
Message-ID: <amhqdc6kv6vd66bwwyhozlqptqjzuefddiabgw5ndko3rj2gwv@5choqknbpeb2>
References: <20241127-mdss_qcs8300-v1-0-29b2c3ee95b8@quicinc.com>
 <675c41cb-afa8-4386-8dc9-026a36bc1152@kernel.org>
 <8982d065-9bc6-4036-8004-80b1681eaf3c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8982d065-9bc6-4036-8004-80b1681eaf3c@quicinc.com>

On Wed, Nov 27, 2024 at 06:54:10PM +0800, Yongxing Mou wrote:
> 
> 
> On 2024/11/27 15:13, Krzysztof Kozlowski wrote:
> > On 27/11/2024 08:05, Yongxing Mou wrote:
> > > This series introduces support to enable the Mobile Display Subsystem (MDSS)
> > > and Display Processing Unit (DPU) for the Qualcomm QCS8300 target. It
> > > includes the addition of the hardware catalog, compatible string,
> > > relevant device tree changes, and their YAML bindings.
> > > 
> > > Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
> > > ---
> > > This series depends on following series:
> > > https://lore.kernel.org/all/20241114-qcs8300-mm-cc-dt-patch-v1-1-7a974508c736@quicinc.com/
> > > https://lore.kernel.org/all/20240925-qcs8300_initial_dtsi-v2-0-494c40fa2a42@quicinc.com/
> > Above was not part of this merge window, so nothing from your patchset
> > can be merged for this v6.14.
> > 
> > If you want things to get merged, I suggest decoupling dependencies.
> > 
> Thanks for reviewing.Can we keep the dependency on above changes and merge
> our changes after the dependent changes are merged?

Just drop _all_dependencies from display/msm patches. Otherwise I won't
be able to pick them up until 6.15-rc. Use ephemeral DT nodes in the
examples.

-- 
With best wishes
Dmitry

