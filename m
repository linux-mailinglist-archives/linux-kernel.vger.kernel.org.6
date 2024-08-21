Return-Path: <linux-kernel+bounces-295213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CDD9598AF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD9128414F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5AD1E918F;
	Wed, 21 Aug 2024 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZvaYDio8"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B29D1E9184
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 09:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724232429; cv=none; b=OtfisbKbrYBtg+SqeNDTu/xJojJQs8kioqM7/7kDTuy+dy7PnmPljPHnlsVGih42L80nDNHWIvjkJej+2eLjtTO9gVUyHtFGK7u94xS+w7/Kn9wZ4EOmzFCd7p7RqIawCxK2axT6N7A3051tkKoe3qsUctUkEsEI4UwviB1Kax4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724232429; c=relaxed/simple;
	bh=6Z3mOwzdNJ8ZVlCh+Y4LUfp4zBkm7TqdB88HWv1/19c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qwb6ADMsIUj9t5t7/Byt0Rntp15fRMyFg99x/TYKbDzjBamr7uY9HsuUElNj0U3ij/qttpVyZDFIlgMGYhwCYyLWe2JmLR/mCcczS0DsbPfrJ4JEk4x6aIF0g4cbQT9+iUH2mY/2Pnnulg44i8+/28T2NC8wl5uttZXY9h2YkCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZvaYDio8; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2021a99af5eso35654225ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 02:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724232427; x=1724837227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5teIJEcm0AV/k2WnKwH/7mKliV2959WnLZFIN1xCsco=;
        b=ZvaYDio8iQuiQk5CS+UdazT4Gn+Cu4tbMUsqhIQ4/S5o6bpm2III5hpQeSAUydH0pf
         bQIQA4+tUT/xSrxCbot/HrecUS6Y69z8BJcP6QDB6XbBOcE3G8DhKP3yKSbQfZKH3zqB
         tbmyH7EaAPkTr+2fdP04pF0pmqq/q0NsbXpZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724232427; x=1724837227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5teIJEcm0AV/k2WnKwH/7mKliV2959WnLZFIN1xCsco=;
        b=DQO2Vg4nsexvggjwN9dFY4iZW2tVcdmwuMweZDZp1KlcfH4ErTOKoIcou7N6OxqVH8
         g+fb7BRNOUyMrO/EK2akDBQDH+U5IrJgmkGYTtk7ZyFMYOEn0NXBKlpgEnetPXC1WI4S
         Gi58R0GXnyih0RTyekt+lD/OAXKpyAxuloDm9dJYnecqpugB68zy/f53zDeWW/MYWnPu
         a/V7aNbCl3gO72xKe2EDoSybnKxbUvyy95nLdUKeof+g61QYEDV/NrSQoyKef+FDr+zL
         eSwG2NPA7EzL6RrsC2Hky90O9d37FQEAusa8puyeczB/fBjvPwjvu0KCusijLufUrdi5
         zNkw==
X-Forwarded-Encrypted: i=1; AJvYcCXQL5qyZcL3OBf7HTyDRzvPQIL+BQ6lDvLvIWy10+33B2vSeQyS2yEiWTt0WEq704kGO5VjwujBAKae98I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOg/Fp/uQsG/v6J3IqW3UHh+4mIjfmNLlE+KXpR+cdLGn2mGOM
	Ea/QezycxO/91Yg8eBLvw2NBDym4B0g0HXSWhFYFlkrGTD5nPcaNh6J6QoVS8w==
X-Google-Smtp-Source: AGHT+IEbt5Bs5xAE6EXU+ozOpdvalfD5bwlOmLZH40RAQn14UF8l3N604XimOQzcaf0Y9RYTSflQ8g==
X-Received: by 2002:a17:902:da8a:b0:202:1a49:d0c3 with SMTP id d9443c01a7336-203681c866dmr12445415ad.62.1724232426742;
        Wed, 21 Aug 2024 02:27:06 -0700 (PDT)
Received: from localhost (185.174.143.34.bc.googleusercontent.com. [34.143.174.185])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-20250470617sm37161595ad.268.2024.08.21.02.27.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 02:27:06 -0700 (PDT)
From: Rohit Agarwal <rohiagar@chromium.org>
To: chunkuang.hu@kernel.org,
	p.zabel@pengutronix.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	ck.hu@mediatek.com,
	jitao.shi@mediatek.com
Cc: dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Rohit Agarwal <rohiagar@chromium.org>
Subject: [PATCH v2 0/3] Devicetree updates for MT8186
Date: Wed, 21 Aug 2024 09:26:56 +0000
Message-ID: <20240821092659.1226250-1-rohiagar@chromium.org>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Changes in v2:
 - Update the binding to include power domain in only some
   specific variants.

This series updates the DPI node to add power domain and
adds the Mediatek SVS node as well to MT8186.

Thanks,
Rohit.

Rohit Agarwal (3):
  dt-bindings: display: mediatek: dpi: Add power domains
  arm64: dts: mediatek: mt8186: Add power domain for DPI
  arm64: dts: mediatek: mt8186: Add svs node

 .../display/mediatek/mediatek,dpi.yaml        | 19 +++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8186.dtsi      | 21 +++++++++++++++++++
 2 files changed, 40 insertions(+)

-- 
2.46.0.295.g3b9ea8a38a-goog


