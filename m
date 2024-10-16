Return-Path: <linux-kernel+bounces-367581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1F99A0416
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916941F21DE0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B021D1E70;
	Wed, 16 Oct 2024 08:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qZg5HqnP"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B1F4C8C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066875; cv=none; b=suJ2H0ir/QxypPM/i+mFBcdwaMqFEOMmIvCfomjgkT7C5tTBOVPMpNc92CqVexf6K4jz7Oa7lYi1Ma7DAtwH5Fsr2GOClF9ak8p+JxSvPSPWGIx96uL2w1zg77rXwxDBRM/uY9AvCotfTJ0jS8/lcO9dfHpOAyjLr3jbES9fxvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066875; c=relaxed/simple;
	bh=SC95/oMNDROZVmBRonnhTU9ZRdHz9LH0gFQlNhSE/pA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jZkn61GL0j0+pxhPQ1Urdf97CcI4VDZV8WSoXGE0x2vZg3ml24QN0jE4w3xawQFF7bbtqaNJWDuNz6pWD3xzWmF6SQnRYYYlvO60cWHe/kAs4gniz0lDgk+Uoz443AjI9NwzGTOKYQpWjJxQ+oQDJUCoixk0Uf5ySET1/WAfvtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qZg5HqnP; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539fe76e802so2077251e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 01:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729066872; x=1729671672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x73Ze4HiUN0gUgREJRAOH22XoZNP1Mx9uYJX7T5fCv0=;
        b=qZg5HqnPyTyQcUsIXBVGCQDSSB9mrYOQvl2YNASOxbd7lHi3D40q+488Bmcu5gOpdH
         769LVK/+OP1q8y9o4i37JgwyXDVujYfx/CQM5+8bAUK+MLWLRViMUWFMFbQ95jEvfohe
         BrF8PFrzw383emMuKfEBafXsf/3JkdQEfMBp1egTSiI3oh6Gai0dEdwFjH853iUc1j/4
         DiUCd2Hjy259cFAYR2Ppbdv6ktGQ3i2jhuXmdOL4HAyIntvvr3jwMQeCIsz7nX5SZm3F
         FlpyCpXuM3Wn9FnDzYWzy9SPW8If45/SpBA5oSUVEqbi888a4IY4EjfluwhHPYYoasOx
         qppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729066872; x=1729671672;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x73Ze4HiUN0gUgREJRAOH22XoZNP1Mx9uYJX7T5fCv0=;
        b=aTFX5f64IeRaCdv9HjdiiwGF4RlxWAmjTOGupsNlzX8pSCj0uYTpofCsJp6rbsr3WG
         /GmHZhjBFbtmtm4bLMbHc9Lu0u2pwJToQVkqAwmy8aKdOzRt735bHpau7Vbe/PZ+Q8Uu
         MB4rh7Nx1ufEzB55e1wC/xalTxweVL7hfwyZ/40y0ogWq1NaT0jjBuMNhMtoU2u5Rzj+
         dFcQCIo17GecYvCUC2BS/fh8vRdm6D8T3KnRK4GzTcVkCVAYwbm1MJ+GTR3JoSXzseWm
         Au4pzsmWTrWcRo1yO/VxYoVfMOox1nOZgFnHlbd3ZBg8xfBgs0TFEW2+BtqYETy2unmy
         RrmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxWwyADp+2L3oaBe7FyxZyQ8hVg/c4c0NUUWOANsA1IqMjQRcwsz3bJq9F7NrmciA0TsJ3ndLpKnEzsOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhCDkzN9aCufx0B5orTLherbhywea+BluiXf9io4j+YnFabhJB
	+Rwt3+RW3k915IYtzi0ZdSMIwouRX9diX8Kpa8lnLxhgq9fiU/05/ZZQLpmEOD4=
X-Google-Smtp-Source: AGHT+IE+1pDAfRFGzuvW8AfMVDl2pFuaNDqn2OJYjthRELduHSM7bCJKxjkRSCr+H2L4CgmQHx3AVA==
X-Received: by 2002:a05:6512:3083:b0:539:964c:16d4 with SMTP id 2adb3069b0e04-539e551ff2dmr7531719e87.36.1729066871248;
        Wed, 16 Oct 2024 01:21:11 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f569eacsm41658965e9.20.2024.10.16.01.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 01:21:10 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241015153442.3757061-1-arnd@kernel.org>
References: <20241015153442.3757061-1-arnd@kernel.org>
Subject: Re: [PATCH] [v2] drm/panel: s6e3ha8: select
 CONFIG_DRM_DISPLAY_DSC_HELPER
Message-Id: <172906687038.3993974.11773726523880025019.b4-ty@linaro.org>
Date: Wed, 16 Oct 2024 10:21:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

Hi,

On Tue, 15 Oct 2024 15:34:38 +0000, Arnd Bergmann wrote:
> The new driver needs the dsc helper code to be available:
> 
> x86_64-linux-ld: vmlinux.o: in function `s6e3ha8_amb577px01_wqhd_prepare':
> panel-samsung-s6e3ha8.c:(.text+0x16b1e65): undefined reference to `drm_dsc_pps_payload_pack'
> 
> Select it from Kconfig as we do for other similar drivers.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/panel: s6e3ha8: select CONFIG_DRM_DISPLAY_DSC_HELPER
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/fd3b2c5f40a1e028bc813284260d430257444334

-- 
Neil


