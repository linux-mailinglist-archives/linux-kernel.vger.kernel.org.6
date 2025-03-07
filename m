Return-Path: <linux-kernel+bounces-551175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1405DA568FF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70A68189019A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290C521A426;
	Fri,  7 Mar 2025 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ltLNyqRI"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C375E219E82
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 13:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741354203; cv=none; b=HWIiy/Xe8Qty4tp5cN8jdfj6OXANrL+0ncBFjgQ7tsoh+pIugiQQsyN8NDC/Og397OdGB9NP3qqW01txJtzUNOS/1ncMqHJ9eggldzAiUNzQx/59qUM24WfgrMZhw0cCiOnP/swuviojik7SUv6mdhvAZ0+hgpGvNMl9+xzD3Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741354203; c=relaxed/simple;
	bh=wZwZ4u+3MacWP7ZiA/RT20bOi492x2WChjuClM+KD/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmy5n9fIy6W7nnzdsGJe66dZKT3cTYDDcPcjGbGtwa/2jNATtKxpWEL68lMYn7q5MWsqxkIuAFfNnx8acKEJh+X1ktRhugeA1M36rLHRFIZHzZMkFZUYXDCnfCX6kbZx0R+2frUTMW3FWL48HXDsC82eKXa+CQUOwPtCJwQ6s7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=ltLNyqRI; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3910e101d0fso1018965f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 05:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1741354200; x=1741959000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ekE5xsi6ZfzsstIFHcXwKSB/c+BLxZ8NF8WHZmG2dto=;
        b=ltLNyqRIWqfjVh6pXpsfxrx8XRlc+M1AXDVMRP5muKyhiqvAdYlZ0xcUI9Enjsi9PY
         XcDtjXDwquuPlqJHUNaAIH6HtJwhPMt2zsLGt3AeNBy0YdemZTJGz00gUA19y4roKgdd
         n5pCuq06eyoaXtGVVdwj5YEJLefECvWEcRB9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741354200; x=1741959000;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ekE5xsi6ZfzsstIFHcXwKSB/c+BLxZ8NF8WHZmG2dto=;
        b=jCLo9Nu1cekGRmg7sXn1oHz82glIvGRJLrsDlq2T0KhQ/O/+OIHj1OrBAXGwz2J1jb
         tLGu3oet/P5uzAREqXUXPmxOC55kZUT8I3TO2KZrIrymawz8/GGTa3tmfoT09KbbJFva
         fE/a7jdyk55ZBmfl6OBeYJVRIh+QVO1LyXylvsz8723hIjY7B4OH3npcQWMXkgRHDAYa
         UDCrH09lJNjKWqCtFnI0QPCoyz/c+PGYcEAq4dSxc8dEoOZHgYIemv6UYMq16lS+SGvX
         4PPaPuDhpOJGKQyH4wXlB88PBPP0Sea/4qzE+xRzkTJwurJYc3sP6KXRCG/HZ7Avsmkr
         /kLw==
X-Forwarded-Encrypted: i=1; AJvYcCUCCi5MaBpAstZnViNtoAYT/J4pjmWRnbB4jOGZZvJurzjm3wrPyB8/jyZCMtMAIOpgMf3X7l+UL3eQ1G0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1r4Ji7ifK0B6vcFePjnzo+EmEr62e79gchd8qYXNP1yL0BBZw
	n1i4grB1cfSH+sDWHaFwq4qwwreYkLvLv5AfKVsJoXeDbUOiz0eqnsWyxnW6Fj8=
X-Gm-Gg: ASbGncvEggv+TOcaQAAcH7/DGgRWmNfM+2XcZrOuHaFCTWvdJa7Sf+d8POasVaYG/rO
	Fnw/7N5dn6ro3+3jHi+eKN2G38aEmg0uRoTPKT0S9qKq/e4NgQV1OiAUm27YMwA9UpMUzlTuMr9
	Dbm30obZmyJEV/92zysb3XFTESQ/+eisxvDDwrgJKYdsdUiZFz3Pdjpi2z3Atm1e+L7R0q5bY6m
	dzNpldNNX5pOIe4gg8mmVGoDNObIm5YzIRHNmRRLBo2mVpTQZ1b4RjcrGAzBK9YmECcRmce8nBf
	i7cCtipEH5mokJQP8xB8JXWcQoKfa83rhWWAGoApqbJmjwWeHv6Tqt55
X-Google-Smtp-Source: AGHT+IH/kkCP3WG8+wzNo7ysyBh/OLARokHFUAgPdG9FvCx5V4btdPhz7YMsZxr6IpgW9UUP3aP3IA==
X-Received: by 2002:a05:6000:144d:b0:38f:3a89:fdb5 with SMTP id ffacd0b85a97d-39132d244fdmr2005477f8f.11.1741354199959;
        Fri, 07 Mar 2025 05:29:59 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8b0425sm51891245e9.3.2025.03.07.05.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 05:29:59 -0800 (PST)
Date: Fri, 7 Mar 2025 14:29:57 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Dmitry Baryshkov <lumag@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Xinliang Liu <xinliang.liu@linaro.org>,
	Tian Tao <tiantao6@hisilicon.com>,
	Xinwei Kong <kong.kongxinwei@hisilicon.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Yongqin Liu <yongqin.liu@linaro.org>,
	John Stultz <jstultz@google.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH RFC v3 0/7] drm/display: dp: add new DPCD access functions
Message-ID: <Z8r01VDfSykLv5JX@phenom.ffwll.local>
Mail-Followup-To: Dmitry Baryshkov <lumag@kernel.org>,
	Lyude Paul <lyude@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Xinliang Liu <xinliang.liu@linaro.org>,
	Tian Tao <tiantao6@hisilicon.com>,
	Xinwei Kong <kong.kongxinwei@hisilicon.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Yongqin Liu <yongqin.liu@linaro.org>,
	John Stultz <jstultz@google.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
	Jani Nikula <jani.nikula@intel.com>
References: <20250307-drm-rework-dpcd-access-v3-0-9044a3a868ee@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307-drm-rework-dpcd-access-v3-0-9044a3a868ee@linaro.org>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Fri, Mar 07, 2025 at 06:34:42AM +0200, Dmitry Baryshkov wrote:
> Existing DPCD access functions return an error code or the number of
> bytes being read / write in case of partial access. However a lot of
> drivers either (incorrectly) ignore partial access or mishandle error
> codes. In other cases this results in a boilerplate code which compares
> returned value with the size.
> 
> As suggested by Jani implement new set of DPCD access helpers, which
> ignore partial access, always return 0 or an error code. Implement
> new helpers using existing functions to ensure backwards compatibility
> and to assess necessity to handle incomplete reads on a global scale.
> Currently only one possible place has been identified, dp-aux-dev, which
> needs to handle possible holes in DPCD.
> 
> This series targets only the DRM helpers code. If the approach is found
> to be acceptable, each of the drivers should be converted on its own.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Just wanted to drop my "I like this" on your series here. Short
read/writes come from unix pipes, and they're everywhere, and yes ime
everyone gets them wrong. So ack or whatever that means :-)
-Sima

> ---
> Changes in v3:
> - Fixed cover letter (Jani)
> - Added intel-gfx and intel-xe to get the series CI-tested (Jani)
> - Link to v2: https://lore.kernel.org/r/20250301-drm-rework-dpcd-access-v2-0-4d92602fc7cd@linaro.org
> 
> Changes in v2:
> - Reimplemented new helpers using old ones (Lyude)
> - Reworked the drm_dp_dpcd_read_link_status() patch (Lyude)
> - Dropped the dp-aux-dev patch (Jani)
> - Link to v1: https://lore.kernel.org/r/20250117-drm-rework-dpcd-access-v1-0-7fc020e04dbc@linaro.org
> 
> ---
> Dmitry Baryshkov (7):
>       drm/display: dp: implement new access helpers
>       drm/display: dp: change drm_dp_dpcd_read_link_status() return value
>       drm/display: dp: use new DCPD access helpers
>       drm/display: dp-aux-dev: use new DCPD access helpers
>       drm/display: dp-cec: use new DCPD access helpers
>       drm/display: dp-mst-topology: use new DCPD access helpers
>       drm/display: dp-tunnel: use new DCPD access helpers
> 
>  drivers/gpu/drm/amd/amdgpu/atombios_dp.c           |   8 +-
>  .../gpu/drm/bridge/cadence/cdns-mhdp8546-core.c    |   2 +-
>  drivers/gpu/drm/display/drm_dp_aux_dev.c           |  12 +-
>  drivers/gpu/drm/display/drm_dp_cec.c               |  37 ++-
>  drivers/gpu/drm/display/drm_dp_helper.c            | 307 +++++++++------------
>  drivers/gpu/drm/display/drm_dp_mst_topology.c      | 105 ++++---
>  drivers/gpu/drm/display/drm_dp_tunnel.c            |  20 +-
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c       |   4 +-
>  drivers/gpu/drm/msm/dp/dp_ctrl.c                   |  24 +-
>  drivers/gpu/drm/msm/dp/dp_link.c                   |  18 +-
>  drivers/gpu/drm/radeon/atombios_dp.c               |   8 +-
>  include/drm/display/drm_dp_helper.h                |  92 +++++-
>  12 files changed, 322 insertions(+), 315 deletions(-)
> ---
> base-commit: 565351ae7e0cee80e9b5ed84452a5b13644ffc4d
> change-id: 20241231-drm-rework-dpcd-access-b0fc2e47d613
> 
> Best regards,
> -- 
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

