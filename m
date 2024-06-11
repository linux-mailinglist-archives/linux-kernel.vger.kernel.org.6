Return-Path: <linux-kernel+bounces-209439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC279034B5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52255B25C53
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 08:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BA2173323;
	Tue, 11 Jun 2024 08:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HfPW/2f8"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0698F2AF11
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 08:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718092962; cv=none; b=fuAiYVCgYC9BhcvRT4vobfCYlACltIf0Rs3mfEyQOkF6PRXuEfwkOFuCvHppBxs5tZRp/GXVC7ku2Lmm+k9avJVPiJpN/3p/EE6Isch1VP7v3T4wO3KFRlP4mBnFYIOOeye2sQCuRGkEr1dSvMoOLDAyYiXfgWeRuxjaqztawq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718092962; c=relaxed/simple;
	bh=DAEccbuaKAHH6mMPYkOFYIrhVLVM3wTJ1cQBj8Iqxa8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WKwHIfdKHYUrHgd2SXqjlLq1WPAvGkwzgaBmAN1/bIrtfZwYHQ2aFGsqA92x4P2u1LUvaHa+shLw1bq2pv4x67ULOLSGRUhfg3oE7g9Do6sDq3fQopVY1q0BTLuL48hVyywSCtIqMm1LcWNK6iBdhfqMo4TKPwweettMU+0vZ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HfPW/2f8; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-421d32fda86so18007505e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 01:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718092959; x=1718697759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaQ5c2kG2ytdMjulncJeOQcMPePJzL39OYVmshUn2sU=;
        b=HfPW/2f8bVXGGJcmzDzdszQlKo7Z8ihBfyBLlSESwhnjs2GqYLwXOajao3KfGVZh+S
         8hVZ40IYqpq2O32nKG7qJdNqqV/sS1FSufusXi2lcAojjMdjRKF4w7gCoknFB5ZLDzsw
         +6bJI9DveTn5tLi2ASUgyXm+0dl6P5trcZM7oFVIXBcOjaSOMP6esLmA+wHJ25REjphI
         jcNBDIi5T5Rt3vfEPAkDCjgm1Rq7NbCKMfwIFoMCd1MpYTbgcLt0XzQAaNcYcVT2DThN
         X0MihFkXuVNqPN0SFJQcJlBQyCDP9aqChSMNpkyiaePhftVX0knB6eNqkrWaXhnnfJfr
         vbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718092959; x=1718697759;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xaQ5c2kG2ytdMjulncJeOQcMPePJzL39OYVmshUn2sU=;
        b=jxzlwoOLD0JQNLfJjUtCT00/6TC+WGgYbJ+Z/NxtVPB7mlyC8sNtTI++ZaL82F223/
         1rhVOpa6YBfJOdLLygwfpzwPFjOQwIlu1mlRRVk3zwJJmGHveuIpgPz7MgUavfyht+Dk
         PW1/hrDhoix00JUPfXBovaLvBfXgA790GJfPQnwvy96hiCObzbCdPXbpz+VdmI0eNnIV
         cwWmlWyvtiqjuRli122UlTwyqFwNClvqDTw1c6YqeGJt0X0cYtKK2Jvn73O5it9cyH1u
         isBfWLXbxgVUW2eQzSbZ9QCn+TSB8PyeKM5hwAo2/48T8tFo/gZdjhevzsil+nmIj9ia
         PfaA==
X-Forwarded-Encrypted: i=1; AJvYcCUvhjfkLHbtK8GtIH4O2viScc7Fty4B5rH6oZy1Z24kIqEgmeqZ3HePmBCy3Q78xzO/0YaT2C4fElt1b0yIuYbxQY84sYQTp0uQIZ00
X-Gm-Message-State: AOJu0YyCiu76fb7M+zjmccgkaqp0rtr9RQwweVgwMgR2qsxSUxIV9TmZ
	sNEmEKjPghT6cBTe0nvFU3VeGRF4CnG/JBiSai7ipymhnzfSRU93gBl9QFCtULs=
X-Google-Smtp-Source: AGHT+IGN24Aa+RfBIcyXuUKjwh6U0g7ybW6UT5cPP0P3069MO/9Je7HQzSudTLcIQu+deT23iTKWJA==
X-Received: by 2002:a05:600c:45c4:b0:421:29cd:5c95 with SMTP id 5b1f17b1804b1-421649fba60mr129661095e9.10.1718092958704;
        Tue, 11 Jun 2024 01:02:38 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421727aac08sm126706925e9.43.2024.06.11.01.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 01:02:38 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
 Chris Morgan <macromorgan@hotmail.com>, 
 Yuran Pereira <yuran.pereira@hotmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
 Jerry Han <hanxu5@huaqin.corp-partner.google.com>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Jonathan Corbet <corbet@lwn.net>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Robert Chiras <robert.chiras@nxp.com>, Stefan Mavrodiev <stefan@olimex.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20240605002401.2848541-1-dianders@chromium.org>
References: <20240605002401.2848541-1-dianders@chromium.org>
Subject: Re: (subset) [PATCH v3 00/24] drm/panel: Remove most
 store/double-check of prepared/enabled state
Message-Id: <171809295768.4173405.17800575669800599285.b4-ty@linaro.org>
Date: Tue, 11 Jun 2024 10:02:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

Hi,

On Tue, 04 Jun 2024 17:22:46 -0700, Douglas Anderson wrote:
> As talked about in commit d2aacaf07395 ("drm/panel: Check for already
> prepared/enabled in drm_panel"), we want to remove needless code from
> panel drivers that was storing and double-checking the
> prepared/enabled state. Even if someone was relying on the
> double-check before, that double-check is now in the core and not
> needed in individual drivers.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[01/24] drm/panel: boe-himax8279d: Stop tracking prepared/enabled
        https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/12866fdcfb9ebbe1b175804390195b99a234d5e7
[02/24] drm/panel: boe-himax8279d: Don't call unprepare+disable at shutdown/remove
        https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/2ccc698c68333256621abc1146de0d3fb0cc6ebd
[03/24] drm/panel: khadas-ts050: Stop tracking prepared/enabled
        https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/2469cb5c41b4774a6fb5ed799ae53ad16b407a9a
[04/24] drm/panel: khadas-ts050: Don't call unprepare+disable at shutdown/remove
        https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/6ac427c0cd21c7260d6b5133a70084aa35267a72
[05/24] drm/panel: olimex-lcd-olinuxino: Stop tracking prepared/enabled
        https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/db45a6991d9e33e852419f8bb0bb8d70b8d633ac
[06/24] drm/panel: olimex-lcd-olinuxino: Don't call unprepare+disable at remove
        https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/16661a0dd54168826edb2fe5a7b9a183cff0c69b
[07/24] drm/panel: osd-osd101t2587-53ts: Stop tracking prepared/enabled
        https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/9a3f7eb7811a4c5f36eee93b83bbd72bf6adeac8
[08/24] drm/panel: osd-osd101t2587-53ts: Don't call unprepare+disable at shutdown/remove
        https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/c99e387afed197c3f22d73d8649c54f7c8da30ec
[09/24] drm/panel: tdo-tl070wsh30: Stop tracking prepared
        https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/7c9526e58f74e9d725a9607b1ec24ba675f5b00b
[10/24] drm/panel: tdo-tl070wsh30: Don't call unprepare+disable at shutdown/remove
        https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/2098604605adf35c9a0936355252d676f4cbc38b
[11/24] drm/panel: jdi-lt070me05000: Stop tracking prepared/enabled
        https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/698acd40aee3ab2dfff4472ec3c16ce42e70e4f3
[12/24] drm/panel: jdi-lt070me05000: Don't call disable at shutdown/remove
        https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/c8f67cd1d931f2e61a3456d0122ffdeb90b699f7
[13/24] drm/panel: panasonic-vvx10f034n00: Stop tracking prepared/enabled
        https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/e9864996b44e8add09fd612cb7d00d9b54cd9ef1
[14/24] drm/panel: panasonic-vvx10f034n00: Don't call disable at shutdown/remove
        https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/f10b4577da3e8c8e457016c77ce2c2fb8d2d5023
[15/24] drm/panel: seiko-43wvf1g: Stop tracking prepared/enabled
        https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/155739579969d9653f9c2e69141129a824cbd6b8
[16/24] drm/panel: seiko-43wvf1g: Don't call disable at shutdown/remove
        https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/728290006afba80108b3ce9dd33018f05e454cf0
[17/24] drm/panel: sharp-lq101r1sx01: Stop tracking prepared/enabled
        https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/316bb1473c78f415a99a10d3c903ed70e0014ae3
[18/24] drm/panel: sharp-lq101r1sx01: Don't call disable at shutdown/remove
        https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/d7d473d8464e7b9931c0b19f68ea0df807e01b4c
[19/24] drm/panel: sharp-ls043t1le01: Stop tracking prepared
        https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/804c4d0a20437bca3f017aaf96416f3cec7951c9
[20/24] drm/panel: sharp-ls043t1le01: Don't call disable at shutdown/remove
        https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/b3494ccb04124ab3ae08fcd01f9571d209ce97f2
[21/24] drm/panel: raydium-rm67191: Stop tracking enabled
        https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/b7c906d68078f235c1d017a5a820fbeac5a53904
[22/24] drm/panel: raydium-rm67191: Don't call unprepare+disable at shutdown
        https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/78f15847bdb8fe04b1753b1fed4984c183661ef5
[23/24] drm/panel: Update TODO list item for cleaning up prepared/enabled tracking
        https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/8e11b23c96c694d4cb0fb6595b38d77ee5edb296

-- 
Neil


