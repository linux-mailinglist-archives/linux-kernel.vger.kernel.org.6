Return-Path: <linux-kernel+bounces-372894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4939A4EEC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 16:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 059B01C22697
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 14:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D35B187859;
	Sat, 19 Oct 2024 14:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vXY7Ymjj"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9583B2770E
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729349839; cv=none; b=aqd7ECsGtSeKiN5q7VdQvRWe/fk+SjkIbV4+6kIKr/Vky8ZCWjZKvhCT8Uyv91mDBqDD2duOcwasPMNF/kGyguJwVUW0FHtvGnkvRJt+2LX6r0juoAPfydY7pSSp3yY5hCmZ9nyHh9crTOAeVXhXc6N/gAozwdsF2Egl68wdItI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729349839; c=relaxed/simple;
	bh=oXXjzc8iihT1Vpiz4LOtf1vCAs2G/YlJy+caASmC59Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hIW3qYLu9NnGD69nVyJdGiDugbyCh5VmThZp/TnOHiFAnqvsvV2g3spH2iR+x1vTBRiUFvLikmPGW2yWhE6K7FFmR7J0/9dOsJRWK24Jna4P5PIEXzGOYWSTRXDe3J/PCmJiA8as05A5nvGWooxDQ/gJm/nabyu/nkB2yMeCtYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vXY7Ymjj; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb5be4381dso32791221fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 07:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729349836; x=1729954636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9j8gEdaXjCgYvssEU5IyYldyfPJ7EgCEc7AKiV0Wplo=;
        b=vXY7YmjjS3VZPbc9q2q344jLkVwE0fPOKs6jdArp8BgfuT8LoE6Wx97oOorlvEJjBm
         7JIzpRZChLJ9abbYsns+rOSEbSD6i0RHV3H+bJ8mEIEmHKxpjFRW9w3la9LUKhixjMMK
         uy/QnKppzX9Zi5ttAsfYC0PMaVWdNEXXb22gsWSOlxeDjt6GqAP7kkmLup5ku8yTyeJ0
         bfoaFlwOLJ1ZsTaJXP5HxGA72l9tPk6UBXeG4Pz0FTTVdPZ2SldIdL4HY4AsN/gewHe5
         4mnzJvv2u+/O7pUyZaYSPk2n/S5SCO7Z+8LHPSXSxQPdBiT51xsqrt4IlxtC3oG3Q69p
         JHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729349836; x=1729954636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9j8gEdaXjCgYvssEU5IyYldyfPJ7EgCEc7AKiV0Wplo=;
        b=eZ8Sz2cDrl3iUM68JjvNEw9iM2w2DHqwzS3kWfFCUDLohh5voz4j3AN7W095OBOyUs
         r1/kgBtOmOb3X9z3DeRCpbg7vZEg31SA2wPiFTouy9oNiAJlazWrrtFobQzjtQ6DbjzP
         av0AdGd/XCZ5CCnXu51FNUvYkrsrgDCtKJlyP1692JGU+wb7sP6vLCDpGQ85eWAJVWUz
         ty6GH3jODq0KK4dmIjjRBZDXoKL+xOijGj8P6TzDhlGnEzKdZre7nMuTzX8jbh/K71At
         5lwYonv0Vs6bWDQtYtBqAl158VxCTAh92E/EK7tMSqW+LHn0FirBMpiZHTp0MDP+Pq7j
         TwFA==
X-Forwarded-Encrypted: i=1; AJvYcCXAjZKrnHDUC9OT2058QnowivrwtIKi71hyDu+9SJ9lcz5pcFq2qWcg3YzetU8mva1ad+fZA9uhk1hi9Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTb/89nTg1lM3J/OiBUgeuoJ9McYZoaqgQmMAEstp5W+dI/j1E
	p2F6Qlhc5mkS6iDtXhUYD50HY8CUqyqZogkbgarTqpyOafW1sVISKU5dz5RLAv4=
X-Google-Smtp-Source: AGHT+IF6G/RBVCJ37Wkr6byblq1JGc4buk0lZZCEyfBOLwQBxZWy4M9lW7077J1jd9gHkbNS4kARzw==
X-Received: by 2002:a05:6512:3a82:b0:539:ed5e:e226 with SMTP id 2adb3069b0e04-53a1522a891mr3517985e87.26.1729349835560;
        Sat, 19 Oct 2024 07:57:15 -0700 (PDT)
Received: from eriador.lan (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a15214f1dsm551788e87.288.2024.10.19.07.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 07:57:15 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jagan Teki <jagan@amarulasolutions.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Stefan Agner <stefan@agner.ch>,
	Alison Wang <alison.wang@nxp.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 0/6] drm: constify read-only regmap structs
Date: Sat, 19 Oct 2024 17:57:07 +0300
Message-ID: <172934981948.2755496.13654719356285263322.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240925-drm-const-regmap-v1-0-e609d502401b@gmail.com>
References: <20240925-drm-const-regmap-v1-0-e609d502401b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 25 Sep 2024 17:42:39 +0200, Javier Carrasco wrote:
> This series adds the const modifier to the remaining regmap_bus and
> regmap_config structs under drm/ that are effectively used as const
> (i.e., only read after their declaration), but kept ad writtable data.
> 
> 

Applied to drm-misc-next, thanks!

[1/6] drm/bridge: dpc3433: Constify struct regmap_config
      commit: b895a1805e0b01d523afa71818cb97a5d2655fcf
[2/6] drm/fsl-dcu: Constify struct regmap_config
      commit: 9239d961ce9d95ec13e241407d0320228e664d68
[3/6] drm/mediatek: dp: Constify struct regmap_config
      commit: 02f686d17c4305a0b5e2a9de749664dfe9c0f63e
[4/6] drm/meson: Constify struct regmap_config
      commit: 0bcbddb7ef0edb8b4ca994033128e955bb8b1b74
[5/6] drm/panel: ili9322: Constify struct regmap_bus
      commit: 6a92271233fb4789f69a9ba9410b23e2e5ab30e2
[6/6] drm/sprd: Constify struct regmap_bus
      commit: 420fb223fe6049f5eecac0d28136df5bc5699ea2

Best regards,
-- 
With best wishes
Dmitry


