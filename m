Return-Path: <linux-kernel+bounces-555086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9ADA5A54E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B1E9173613
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B53F1DF72C;
	Mon, 10 Mar 2025 20:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fdeGd4j9"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB191DEFE6
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639882; cv=none; b=VaShmm/vE0H0a5VU3Mp8JABKt2fc2GJq2Is7xnspMLObwjvKb1x+n5qeMayxkrQZchSeQKr0b/S3sMs/0mbVsOn73fYx/XJoas7jAsHdAXJgn51CkAiEJ8nnTVDATsHpyNL1OUCTPg+/y7PJyXfdC4123HfhQo67iPWVnTcMPjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639882; c=relaxed/simple;
	bh=muuR9vmT98iiYtwswpTs+MU5Qwfio13uvWoszKSnByU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFizM3WcCNd2R/Til1ZckwfOmPD/tZqp8yTsiH1uVZpEdd1UkiJYoFZc89ePV8HB8pGJT/Sto6llVscsb/Wi/7sN2kAIZkLOvoIQAvSqNQpnct7myYVUP1gZYidxPG6NwhKT2bNpG2Kd0Cgn2t0+0dLMlr8HR1nXTcF7Q3+4hkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fdeGd4j9; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-307325f2436so48184411fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741639877; x=1742244677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kxNF8e48hf51wGrFc06CsODYSc9fXYwI5IwZer2AB2U=;
        b=fdeGd4j97YJz+TWRtdsq8vPeb5oynvgpcfobCuOTBiprYLircq5JJhni196MUWp2jS
         qK8FcrDQFGSVsEgjxSKHK0TFEnlVbZMv7rH8BN4Ww9Pff9zNJLKSKYeuVHRK1zuuwR7r
         FXgTB8xDLLTuWEg1R+rLGlJ34dbaHv99bn+rjq+bTQ5ATCwJ9YmzXRmpTDBxv6pd3nGB
         /rMHokjkqF7RwWdddKf0epDOC72OUea/W4/e0AumdrfEuN8kEWEkYYN7dhKgRGT6XAmp
         kIZyKJqB5EvDSbzkJuyn9E1kIAiisYCY82NkvJeeLOy5c3UPMxMh+lqGk03UxWzyxjyF
         Snjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741639877; x=1742244677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxNF8e48hf51wGrFc06CsODYSc9fXYwI5IwZer2AB2U=;
        b=BeLuGdfct0U0t6cdgvTuBkr6RoWsqBKJSc8+LJSTOJ/H3nzD41FqeZwXtHD0Z4o5Qy
         yDJtOHvRWFvdhFQEspxLg5PNuvJgumDjB7nT/bRKrcx8JJ5NTKcQ/DDDcq2L0Y9Z52S9
         Kwr/AOIilTdQiKTH5l/A+PVHn89eKy11EaIgxt1u+ucx7hu495ju/hydiqJnjyv68T4R
         j0e99FX1haFhsdnwrkBo0Gx4vVofRF/+jEL54rHf8744loaU+8JM57+N+RupE71mfjL/
         eu3nlW7C7+ru+jsol0pFxqAHyWsenKR8fcG39nTmEfN/h29bh/OWoY+n96ri4AMT43EF
         98Pg==
X-Forwarded-Encrypted: i=1; AJvYcCUD8o01iumjgF/YMDRIALw7B8QkFhP2O+R42VCNWvhE+2/eLvDoo1I580WStycNnU9ttSHxjVawlLi9pZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIhRCo/f7o0RzD8pfqyt4fjLVskVW2S4Fq+DXpoQBerlfrsJ9L
	Hy0yarL7ZDX96HJB27x6rzsw7z6j53pqXk/YECQ6H81rFkFt4nTHO8iNxsiV7oY=
X-Gm-Gg: ASbGncse8/AVHdOQigbwggT5xFv/jzZFFT4OvlkCe2bEMLvOSYAGbXebXFmN2oEWBZH
	3OA+JQdEhMCuvdPq6LxMk1q6Di9fxggXeKFTLsWOlfgO95zz5GLKc4r/bL564ibWG0rfvYX45yx
	2NIaBE0de9xtaQ+sm+XD6I19q10DQIeNctUhsAe7GJTB9Hs6JrbW8i3uXecL7ADkT1Xx30y+qAt
	52qz21c+7VHtZbvF3oCAVSxGoSt1rYEn8p++Bz71LCoS/teHzeMLJ44lekMUV77Bneixvq/eS2o
	VW5/VhveakmoBRSeqt+/GRzWtgneyQEsZi6On9fKXXXhhW2iieh6un5JGVPgaHCymYonTLkVBKZ
	LUMJnJAUEAdoIBHmPK6NEj4v6
X-Google-Smtp-Source: AGHT+IFPbDF/2E9yu0QkgjYjNcSbSQMHb9SKSyVgCW0jWJzt0rN/zgSyXWNMQzVNMXXx8FaEgf2kjw==
X-Received: by 2002:a2e:81a:0:b0:30c:12b8:fb76 with SMTP id 38308e7fff4ca-30c12b90187mr13907201fa.15.1741639877485;
        Mon, 10 Mar 2025 13:51:17 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30be99e81cbsm17438501fa.93.2025.03.10.13.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 13:51:16 -0700 (PDT)
Date: Mon, 10 Mar 2025 22:51:13 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: heiko@sntech.de, andy.yan@rock-chips.com, hjc@rock-chips.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, dianders@chromium.org, 
	sebastian.reichel@collabora.com, cristian.ciocaltea@collabora.com, boris.brezillon@collabora.com, 
	l.stach@pengutronix.de, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 06/13] drm/bridge: analogix_dp: Add support to get
 panel from the DP AUX bus
Message-ID: <mz7qmjokw4b3zk4y2u45ykzgtgqpsu6f53pflhqodyjd6svvvk@7jzggqezbubl>
References: <20250310104114.2608063-1-damon.ding@rock-chips.com>
 <20250310104114.2608063-7-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310104114.2608063-7-damon.ding@rock-chips.com>

On Mon, Mar 10, 2025 at 06:41:07PM +0800, Damon Ding wrote:
> The main modification is moving the DP AUX initialization from function
> analogix_dp_bind() to analogix_dp_probe(). In order to get the EDID of
> eDP panel during probing, it is also needed to advance PM operations to
> ensure that eDP controller and phy are prepared for AUX transmission.
> 
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> 
> ---
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

