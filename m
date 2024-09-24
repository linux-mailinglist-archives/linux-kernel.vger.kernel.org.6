Return-Path: <linux-kernel+bounces-337783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CA0984EE3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 01:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B02CA1F236C1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 23:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BB3185B7F;
	Tue, 24 Sep 2024 23:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bcuwTLJ1"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4979101DE
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 23:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727220056; cv=none; b=OIvoLLyxVXI8eXdfvyB6OFPJjAnfU/aEliBz3GsEYfsd7mLpAJHMXFEidyT++AXjZpmJ9w7mInzrwmnVEdGsBlv0LczPXHDQfsImkzBsONoiLqO969lhICddXYhd8mcAa7taGEN38Yc7ceK5oqynsSbpB18Nfk+OsyCVEds+rR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727220056; c=relaxed/simple;
	bh=edZ1v8VAiHC/I+a62X2SikAfYFjh+u8NM2NBwll5p7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5EpMxWGECV+GlRhcwC+AsX9iUjvvh3ZaqHAP0qaABBnnZwNqxG9iIFmYh2pXjg6+TXrzQueVfo52M+uJILVrmbZcP4QV2HbH2g5YXfeG4AUvjdMI80s3pWPjbKApi0Q/FwzKD+kaVSKCzay1DWbkWmSM8W66z8+M2CXeg4FS2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bcuwTLJ1; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f75aa08a96so63569401fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727220053; x=1727824853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BWzfcf6swf5UXV9ORSGTxQB8gm3cbeVNaurYZQU93RQ=;
        b=bcuwTLJ1hbWI8rEUruOr6iIvZc+UoPPOWhcaB2EAr2LEeSKojFHARLrn3R+Ab6juS6
         H9XVAz/j0bhpQ9OlQymTyDHftqQPdq1GOFD+CD//OjJ1ZgWBnancJ4534V0lP42O3Mqe
         HUbb91sBxD+iShd2w2aH0TI+YgY/6U+wcRZ/OrUxq/EXDMCh6t7y6S86axnrgR8km+MJ
         VTP5MaNz4fJm0kUgLpDPQXw/vnGIGOVXHxCF3Rw9zNzeDGberR3mQOxSaeOODEfys+OZ
         a6AD/dBDDOX9eVzZC4hLmz/5i89rNXKy+d3n2Zme19JdSK2S41gkiKMjbyw6FxkzL9vK
         kwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727220053; x=1727824853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWzfcf6swf5UXV9ORSGTxQB8gm3cbeVNaurYZQU93RQ=;
        b=w6bqAUQLgfOEL8dRZKLBLpI5ItUzx7+JoQZoVTJ5f2HZOx8rj8DRViYX+DN+5kvJCF
         kvvv8c+Bk5t/xE+Z4rW5a8ggkAFqPugUkuM6udAWrtBDA7QPUxiXPco6RY463GIh6oU2
         qD1ERk95dsFpTs5LGHdiOWu6eMfh56xS4iY+YoQ975uL/EXyyWnSKmoyW3QwljHkbzdE
         hFQn+6zjdqeNfoEMn3XwMWxqLEIayjm7Nhc4jz86qfWHizfhnCSkm++W+5AgQ3jyIacH
         9vgfxzux3+mdXi8n4fMwfVLiLSg6U8vF1NvBpHR3X2PuZv+jWf9M/cjyzmsN6sXufUCH
         RVeQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9T4qQS2MM0r89qLoLTWdLE3PqMh4WZO3EbNKkmYik6y6NML62o2qdMIRtv7450exM4+i/HaEf/aOjBw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU8RaVcYM8r6f34WxunjceBcTjR63zljsW2V6/fH2pP60TSRaO
	FN35FuxhByT+mGmfPtJTb1IZfZeEgjeuSyKVp4Kx8q7V1nu7YPQE7sB+C87OR/A=
X-Google-Smtp-Source: AGHT+IESGsMzP3PiA/3G8ZUYZ/H/NJt4oS6oNv8s7w5wDXiDCuL/i1Jv8EVQQsMqXIZrtQBGpouHtw==
X-Received: by 2002:a05:6512:158d:b0:535:6d34:5cd7 with SMTP id 2adb3069b0e04-5387048b99fmr414470e87.11.1727220052701;
        Tue, 24 Sep 2024 16:20:52 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a8648ba6sm351603e87.209.2024.09.24.16.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 16:20:52 -0700 (PDT)
Date: Wed, 25 Sep 2024 02:20:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, quic_abhinavk@quicinc.com, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, quic_ebharadw@quicinc.com, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Rob Clark <robdclark@chromium.org>, Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH v2 12/22] drm/msm/dpu: Add RM support for allocating CWB
Message-ID: <rfow6h3s4phb7hukdlpaivxd5ytb2dj2gh5otejwyqghlw5zmd@efediqayw7gp>
References: <20240924-concurrent-wb-v2-0-7849f900e863@quicinc.com>
 <20240924-concurrent-wb-v2-12-7849f900e863@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924-concurrent-wb-v2-12-7849f900e863@quicinc.com>

On Tue, Sep 24, 2024 at 03:59:28PM GMT, Jessica Zhang wrote:
> Add support for allocating the concurrent writeback mux as part of the
> WB allocation
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 17 +++++++++++++++--
>  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h |  2 ++
>  2 files changed, 17 insertions(+), 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

