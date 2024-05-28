Return-Path: <linux-kernel+bounces-192740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B4C8D217E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABA6BB2387E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E31F172BA9;
	Tue, 28 May 2024 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ESZpVPJI"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5100B172786
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 16:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716913205; cv=none; b=BygOm9yuXJlnE03ZkPmo+bhWp8A12EWOU5voCXCT85yHX0FcEF3IubNX675Wc9K3x3ebhwrP5bVUroNBAzH0qkJ1bztDYqhIm2hrXijYChBcQcDAU9i5tTkQAF9YMmBqChhQNGWZeK7Bjd9x4q/lXjypbsu3rqDb2X2pqljuDMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716913205; c=relaxed/simple;
	bh=GZZkUnJhXUGpV/ed9Q+LF0kd3gDFvBC1YUMWnIRdYzc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TCY+8VIEor0D1+TOjAPsfLUipAo+jeYgp1FPFYiy790Gf5LAzcEeNo0lSmCbPCns7GqglbqTYR9XZe3r3mZecGN4hK0G+yWil+ZDsxK3whM3QpuAMcbhl79zkOBx0sfHNf81eQ+29X258tj4HicouuiPuLpXNtsuAzd/bMi2P3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ESZpVPJI; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f8ec7e054dso675640b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 09:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716913203; x=1717518003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwozNjHzia8oslBT34REru3KdIh80yY+OvMr8Rvverc=;
        b=ESZpVPJI960G+6QEfG/7bhDpJQtQjY1TDfT7/XoWDJSPRVHx5/07KB0bptYH1LSzHa
         FdRsF3HF6PMugggwn18wueVXrpfNBu9TekvDHUp2qf5U/pJuACh+NXIGFDZx4PmClkKG
         7VS4S/U+mWCWH6KtKHLJP3L5B89OPGcwnz1Fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716913203; x=1717518003;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwozNjHzia8oslBT34REru3KdIh80yY+OvMr8Rvverc=;
        b=VKNap3YmB6FxzvS7z6f8jGUb1S5jv0rxeW+r1OWQAYLLYvVvwGwTa/A9i8136PcJmM
         SAmLtkwHqabB1WwQmyP7EPTFHjHEssTr1AapFi6+CTTPPMXt2MqMOBtQU3Br5PmH0ziG
         Um9vrlXMhVtlHN9iX1NUT4zvSh3emjPPUh2wtsOIBX5uWLRZCzzhLo4yZBU1tklJw6mc
         MiId9WOWCsYedQY1BW/Lx6uvHd+BYCuORWUn7BBDcXyBjXMgSusoDV7fFD6xSzsk77q6
         KKgb98hg73J14phk2cjnn+bSsvK5S0Aycnd/t9AZzpU6ny0gvLqqIzYQDfHb0jEB0R7O
         Ns6g==
X-Forwarded-Encrypted: i=1; AJvYcCUB5zwxiyx6ouOzY9VvBZjc3bO/zjG3V5blQL8MxfdZ3w/3PxdL16cEL3aI3yzQ75GVE97vLkmPmOHVK1hRlXKCJ7ZJ5X0WzZyVNS1t
X-Gm-Message-State: AOJu0YzWVeYgD9SD985MxBKgony116PxlvxNTcgmxI8MWlX/Lay91CpB
	n/rlyY2GeEzBHmYhPAJhIfBI2M1Kbovu7EEM3Lz4k0K7cysbaMVpSJl2rom1Xw==
X-Google-Smtp-Source: AGHT+IG8rDpNehph5P7FZF3+M+WL7sxADGSNYgbXmeSk+9wKTNEhBfeV+JPxzH7+f7NbZBvjBsjVHA==
X-Received: by 2002:a05:6a00:4405:b0:6f8:e998:3c5c with SMTP id d2e1a72fcca58-6f8f4192fd7mr19286701b3a.34.1716913203651;
        Tue, 28 May 2024 09:20:03 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:8d59:feec:9939:40d7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6822092a678sm6473780a12.11.2024.05.28.09.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 09:20:02 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Maxime Ripard <mripard@kernel.org>, 
 Ankit Nautiyal <ankit.k.nautiyal@intel.com>, 
 Imre Deak <imre.deak@intel.com>, Jani Nikula <jani.nikula@intel.com>, 
 Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 MarileneGarcia <marilene.agarcia@gmail.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240519031027.433751-1-marilene.agarcia@gmail.com>
References: <20240519031027.433751-1-marilene.agarcia@gmail.com>
Subject: Re: [PATCH] drm/dp: Fix documentation warning
Message-Id: <171691320208.2507294.7545188870163730565.b4-ty@chromium.org>
Date: Tue, 28 May 2024 09:20:02 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Sun, 19 May 2024 00:10:27 -0300, MarileneGarcia wrote:
> It fixes the following warnings when
> the kernel documentation is generated:
> 
> ./include/drm/display/drm_dp_helper.h:126:
> warning: Function parameter or struct member
> 'mode' not described in 'drm_dp_as_sdp'
> 
> [...]

Applied, thanks!

[1/1] drm/dp: Fix documentation warning
      commit: c7ce956bb6d0f32ab921b6ffba1a6a834df96f21

Best regards,
-- 
Douglas Anderson <dianders@chromium.org>


