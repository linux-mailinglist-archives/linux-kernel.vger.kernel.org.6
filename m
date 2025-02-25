Return-Path: <linux-kernel+bounces-531057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B89A43BA2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08577441427
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3108A4414;
	Tue, 25 Feb 2025 10:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RI+dYilK"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8BB261399
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740479141; cv=none; b=YlX4Qk9Dng8upefYHSYdWRENmnUEYI+l/8LgFweG/O5E0HL2nV+oAupdloExRGaYjww/kmsnKl9f3UibHRl2xmT1ZJUEMCHVENotZJpRK+F4NW/d96TZuUkRicvWeM8/NuDkb0057o6xNQVvRmesBEuqE0/r4CIvj3gJbureFJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740479141; c=relaxed/simple;
	bh=lVx9GsbZg/PJKvZT/5kfAUjQoKKgydq0Aadd3S0x4mM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RnrAbkskS24a3I0do6FCIPMowG+9/OfX8ao0b6q6QxPEtmYHZtO8ubCf3TNAC9tg8qVK4duLf0frIZxXEeitpedDNkFhwuloe6cVuAbWYS7eSCfICwNcjB8wOMvbeRl/Ki5b+h7TZPF6wNNt3w918yrO7CdjMsyKr8hPduI4JNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RI+dYilK; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f488f3161so2935080f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 02:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740479138; x=1741083938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFoF7QyNRZ9r7+RHzos7assjg+PgG+3CLatxaRnVuRs=;
        b=RI+dYilKe70TAxJ7lv+0jkXs5FlrUBWtvGJFrUcxPXxB1Eapp/iSa86yd1FN12qPcS
         YqooWOeGBgGCKjTU0BL90YCRUo864EEmnL9glJjOt/e4WH2/cMoovvWcisRGud7Gr2RV
         qMOylFUxSpOKz4BoyrDguvQPpTYUr7Pa157Zum2Jk9SRTAhFoBpqENWs4nCKgvTfLoUm
         STGKPlgLAu48ElHQhntwc9JWOdMf2OfqX2rnyPjnZKeYRgemgXaNpkxw62wjAHbMo52c
         MVuFou+GvWvtl/v9MgjRTFxC5D059+YplXji/WcYN915tu6D9ogs/2tw0lKMpuFhIpjy
         lGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740479138; x=1741083938;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aFoF7QyNRZ9r7+RHzos7assjg+PgG+3CLatxaRnVuRs=;
        b=PDJf5iAGeHJglfXYtfkVHhsFC2Jb45y5VIHJrCKXY/rx8nvxr2iLSDGnJVVeh0DucZ
         ct4d4OkY/5zs5iG5gM8zQAZwlQobTa0S/k/xSIcQEMKmzSiRQATgBHW9D0qKKcNK1kza
         cMgKzRuy5lRMrZqWfEbIkqtSX1LPBwJx5ZYLaTTdssvhQuK2vnWYFhrY4Dv1ONWxaZJF
         ll7SpOaWUZ6qGW1VwSTBEttgdw9sx/PHdiz0gloqWMRVUcyLGto43MsGw55akqCkrdiL
         GDSWKjkPOucX1BHsY7Szv9DrsdKATFoP2iMlN92Zl0tdBrMxyZsUGKx21c8ntBR/x/0+
         cgkw==
X-Forwarded-Encrypted: i=1; AJvYcCX5zHBx2NF9gX2qFsRu+mgm9/QChe4C2sR+aAkLp1i8HWIqHGHWx+nqtv2JuYuyvBPJX1UMJdxlJtB5BnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE52z2MTd8YJgANfRIrLtQAZFlbpjF75gUCeZ1QCOWSFFyAyU+
	hYZQIKmW9IptlfWfAIZKHIXP8hbltuYXbHwPqtttNkttOB7N/UEGb+HgaEn8K1Q=
X-Gm-Gg: ASbGncupAQnL7w6pf9m3QmRB28jjWXIPf+O5e1b7AyY/WfJYxWwZs07AShdpMANzIUl
	HsqB/c221KRvGehXyAqc1F97DOWHQA+OaUlFCapm/dTgegY5QUGMFxgNZjnkil3OmveJ78r2aEH
	tC5YPrG30NBo1G6opfufLddbr7qu46UQRqx5VStahjwFeE0O0C1u0DvSsQnRfobCUoPF6VeftIt
	5tTFJVoVBL/jUyq15X906rFzo++IZcFhQNRYftmVfaNKg/d1LJ7YuWuJuPMaDRPigdtlJl6lQWC
	61fX4qjxX6izH4X2cYUQfSd0zPin+IuAQMtR1Di+AckZ/MM=
X-Google-Smtp-Source: AGHT+IF0UNTzcIoMzLzKcwrilDWc3geeDLz1AHdSa0/z4fJP99oSE9XrnUuGZC+x8acSBmNx8F633Q==
X-Received: by 2002:a5d:6dae:0:b0:38f:4b2c:2464 with SMTP id ffacd0b85a97d-38f708626c6mr12904963f8f.55.1740479138118;
        Tue, 25 Feb 2025 02:25:38 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86707asm1764378f8f.5.2025.02.25.02.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 02:25:37 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Liu Ying <victor.liu@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Maud Spierings <maudspierings@gocontroll.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20250224-initial_display-v1-0-5ccbbf613543@gocontroll.com>
References: <20250224-initial_display-v1-0-5ccbbf613543@gocontroll.com>
Subject: Re: (subset) [PATCH 00/14] arm64: dts: freescale: Add support for
 the GOcontroll Moduline Display
Message-Id: <174047913731.2131221.16812340325511859962.b4-ty@linaro.org>
Date: Tue, 25 Feb 2025 11:25:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

Hi,

On Mon, 24 Feb 2025 14:50:50 +0100, Maud Spierings wrote:
> Add inital support for 2 variants of the Moduline Display controller.
> This system is powered by the Ka-Ro Electronics tx8p-ml81 COM, which
> features an imx8mp SoC.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[01/14] dt-bindings: display: simple: add BOE AV101HDT-A10 panel
        https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/761992a4b4deacb519f4a6089936b7fd22b4aa0a
[02/14] dt-bindings: display: simple: Add BOE AV123Z7M-N17 panel
        https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/1a4d1d9f068506f4f334c03514d2e93e21830f19
[07/14] drm/panel: simple: add BOE AV101HDT-A10 panel
        https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/b554c009da1c3c6cb8c4b5da2ac2f37fb527e927
[08/14] drm/panel: simple: Add BOE AV123Z7M-N17 panel
        https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/d34bd3c7cb84425dd6146a8d07af597b93ad4c4d

-- 
Neil


