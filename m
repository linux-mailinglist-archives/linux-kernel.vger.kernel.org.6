Return-Path: <linux-kernel+bounces-533072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1828A45566
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 796B117AA25
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3050A211A33;
	Wed, 26 Feb 2025 06:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J226bZhb"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF78A1922EF
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740550635; cv=none; b=Ocl/MSIO5Hd1XqHFQC2IFmZViZkBdTCy/rGSqIoKXtia7vW7PXKKDngSagG4HO/HIp7uhOaJLq7Mw/VHpvMhY6hkcYtxb77LmRPFblhWCbAMlnY5rzHwnDUcxC0avlbXbezeF48rsdr1HEj4FdCNwybsxlyrgXnJWOlf+nebV7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740550635; c=relaxed/simple;
	bh=4zHr+lKCZGLp+AVj3GLsr40g87x+7GH7RBtFf2xj2yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASkrSO/Z/O72slgk6CqiEpX7otQAm9SGhIMt7uiF1i9erk/iRLUV83cU6MpqOQaXJHkJhgzZOYRe8YAzxANdGTpiSskFfRy2SMQwgpF/JPOXrw8R22K6enH7YCQkgZEyiKyyAvt6v48XUnm5OuFzmlP6c5jPDOCVYfGlai64bHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J226bZhb; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5439a6179a7so614926e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740550632; x=1741155432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vdAWglkpNWkKlfVQY0b30qa+fHtrIyjn4IdPv+J5KmY=;
        b=J226bZhbZ5bOZz8dYWZ4cyo6aa2Pt46xcYpRo4+hQx4I+xZf9GkcbjbyqwQOcolwaP
         QYiyuy7LtL9jo7ByLMRR2MkQsZushQdFXF1Yz9NbIEd7H+29Y3p+RU/dawWH1pRFJq+G
         6sCqJs3jQupiaLl6NG6Z65VJFKeij/jlTtSa9fEpSK7YakX86j9yue63iqRhTZY7mIc8
         0VbnED7E0/vILC9f9aQ0CyhKArrNP8dJ4dHwiO168cDNfkenoeHnk42fj4efuaEuTsF3
         bn9R10RjgO0Cyr6yTm57BFHqzuCTxGBrdyrRApwNVnLU/HaNi8/fw4zrBV5wf3neeylB
         F+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740550632; x=1741155432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdAWglkpNWkKlfVQY0b30qa+fHtrIyjn4IdPv+J5KmY=;
        b=beqKzW2sLGOcewC0hPbfLp8sLdb3a4bJj74GAu7dD3DvAVRP8JPqDCDcM3h4L9iNN9
         Kp0GD1wfYG0Rsjb94FMSUjiYvorAVqhj0VppGnX6ktB2Ry88IYMK193eGKfTrneFiVN7
         u2qMdysg9v4wwVvBEIA7bFpAB4I7MsaNF6UzVdADfHqoR9ojOAKAuE/kYMpOnHV8gh9N
         5jDhZR2UJrx8NE5tGr16vXM9VZa9YwP2kNAGmsvE1Te7oNH1r4ilFCnMyULXG3u3xMLL
         XawjePKPnOJtrKQE/15W+QP5UUr2bOq11u9k0PFogUsW3oRx4b8S/Se1RpzoagEdBBA4
         JnUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSF5407pduiP2EFdjIrtEF2odtB9gHvkk81ws8FiR/ISkWS6a4Utpgotb75E8H1Ja4Q4G1rsLYHWLXyQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3KHzsUv73KBazMDxOc/VvO7AX4P0JuWn1UVAPqmvjq18kPT/J
	KtvPYtwm8HQ5DxIhuTZWTzCI3N2TJsHLm3WwioWN8f00mJ14nUcYORo8f+2rCPk=
X-Gm-Gg: ASbGncuHolSrp/emhkUGPzTLUt53kZtFeVGtlZQ6j+KOWkgkxmAvaxOFhvp0SzjabmT
	gWZ08fvJl1plgkAv/1U6B0aZs4I714mDsih36flifR6m3/t7Bu3Zhl5v5CIp0KqzMDlexT/gC58
	vJP0Qu30+32H1pX0d81PIkewSMGrnIK1KEbZfRDCr6W06QKJvocXYVBouxknQz3mFjBB4Dco1i7
	JXWL0ojBpsLPcktW+xlJsROKTp9D0tkqEwBJ962ma2Maj0lEbvaGoZX5x1xNX16r8IGsZulqeWp
	wnlmhupCGuhdxsRR7eE3pVN3eZVCslqApikZBgohMJ5Qzq2LTukNWLomPf0kcz95J2tGT9rwyrK
	tyw8nAw==
X-Google-Smtp-Source: AGHT+IEs1dUcvgsmZtfFrnbSncV3gTJJg9pAfhXogUOwliuGtG6jolEBnnLRWX36IkMjWaHHwSk3BQ==
X-Received: by 2002:a05:6512:3d8b:b0:545:81b:1516 with SMTP id 2adb3069b0e04-54838c73e38mr9564126e87.15.1740550631678;
        Tue, 25 Feb 2025 22:17:11 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514f4d3asm357995e87.186.2025.02.25.22.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 22:17:10 -0800 (PST)
Date: Wed, 26 Feb 2025 08:17:08 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	Herve Codina <herve.codina@bootlin.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Simona Vetter <simona.vetter@ffwll.ch>
Subject: Re: [PATCH v4 04/15] drm/atomic: Introduce helper to lookup
 connector by encoder
Message-ID: <foezi4xoq6zpzcn56z465epcxifkky6cctgvujkio5v4aswuqe@jx5wv437w3k4>
References: <20250225-bridge-connector-v4-0-7ecb07b09cad@kernel.org>
 <20250225-bridge-connector-v4-4-7ecb07b09cad@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225-bridge-connector-v4-4-7ecb07b09cad@kernel.org>

On Tue, Feb 25, 2025 at 05:43:52PM +0100, Maxime Ripard wrote:
> With the bridges switching over to drm_bridge_connector, the direct
> association between a bridge driver and its connector was lost.
> 
> This is mitigated for atomic bridge drivers by the fact you can access
> the encoder, and then call drm_atomic_get_old_connector_for_encoder() or
> drm_atomic_get_new_connector_for_encoder() with drm_atomic_state.
> 
> This was also made easier by providing drm_atomic_state directly to all
> atomic hooks bridges can implement.
> 
> However, bridge drivers don't have a way to access drm_atomic_state
> outside of the modeset path, like from the hotplug interrupt path or any
> interrupt handler.
> 
> Let's introduce a function to retrieve the connector currently assigned
> to an encoder, without using drm_atomic_state, to make these drivers'
> life easier.
> 
> Co-developed-by: Simona Vetter <simona.vetter@ffwll.ch>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_atomic.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
>  include/drm/drm_atomic.h     |  3 +++
>  2 files changed, 48 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

