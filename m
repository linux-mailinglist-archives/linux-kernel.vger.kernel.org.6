Return-Path: <linux-kernel+bounces-523336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 062F9A3D550
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4CBA3AB7AE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F2B1F03D7;
	Thu, 20 Feb 2025 09:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kj79DufO"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D75F1EDA36;
	Thu, 20 Feb 2025 09:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044722; cv=none; b=InRLUfcTnnmOlNAw+M3WyWUkfmPIa5gfPmRx5qqXOJK93hykh9iR2v1DKE9JrrnobmLTNQqSDPnhQXqQFFlwgjCdcbDNGiMlTjklN6xA/dHqZDwaozV+QUQBAPPMCJwvJzPWXdYm2HEiPQ6b0EDFxlee0dNeAt2VrF2QP6/KU14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044722; c=relaxed/simple;
	bh=ya5qMwjmclNr4enz3hByQfjnU925cHW/z3EnJLCX/1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QEX8Pk0rQpw9/Kt1HUK48EB6q/hCr5qJQ5VDFeg6758P2ugcTU9m9PYvb4a/FbUw5vTUZ2KljbIfk1qjyb3StVNhSeMGKQhXf10cVaDjOoHB54OZvuGuUZcciLpazxV5TJ4mZoThrYm/QwEaOWEkL9We79F551FOSg+aLfH/Knw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kj79DufO; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30613802a59so7379111fa.0;
        Thu, 20 Feb 2025 01:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740044718; x=1740649518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=blYcjFq51G/DEAKYPys0HB89RJktg5VIFc2I1DNAbtQ=;
        b=kj79DufO1DQvt/G0aDzFwwfCZCsrm9JDyxi+mBAimdmogwnVNSAvFcdJxptQ5Dzjtm
         iLIWJAQpt4Wz7P4dnO6UBQ4NsQi9IlXYH0x/ONXC6QI4JJKdB95JlQBkh5M7tR0N+fI/
         IGX/wczHa46j2IRY+7enA91/+R/f6V7SLUDV9AQpq2A3AgcLM5Rn8oKm2TsyKjvyP0HY
         Ed+WM/W5oSuRizeMzZ+7mJ1urUoGWaInU1MdjQi8f29ujUxGlJ1xwD5cQJrB5Bqkzp26
         aBrJaz7JsqwiJoEtD4FlXlKfRBaN0vmjcR3RW0j+tp5CRu+gANEbTJCMfCUoGADsYymS
         3Tvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740044718; x=1740649518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=blYcjFq51G/DEAKYPys0HB89RJktg5VIFc2I1DNAbtQ=;
        b=ONWdksVCkb86U2Zz3HFnvwS7DZfREcYnk0tL9CpM3XDPJkYZoUK2hH340+NSsgtoma
         LufUH16vIps/kNnmCNsY1V44Kt+bqeC1wUUES+4sLhm3tCUUz+WmuR+mqKm5gfLvsgNT
         YQCHqB6rLTgzoLvicaUMUVwsWPc7gvco995tKuEb9am3YzE5lel+yfMSLH6WGXeU8gh0
         wEqTtt9IyB4MvEu3JqGTp5LwcvYoYnFNNd+5TDf+JfBsxIIV0p+0+tDcIub5gU0fB665
         CqCmOcMPwPDRcOjcphnzZ6fjp1uYBGz5uvNiyjwmasiR4yXRJXRbFO+w747HVhN40+YF
         Trlw==
X-Forwarded-Encrypted: i=1; AJvYcCUf6M1Mi30F6yPyh0WKTLWipTAFPrMxxSMVOkPv2FsLFtWWzFoCG53MjAGtug7GNvfGMjWfo+hgIILs@vger.kernel.org, AJvYcCX5dAbCrwpXVfzPNDQT5LBHF68eBVFkHcvcbYUwCIQVtYeuZ++/6rvEiUaou7Tk4ZZa1AwuUNLkmoWtJ+S6@vger.kernel.org
X-Gm-Message-State: AOJu0YwuiH2OT1g7271+GoO+Ll4V0gZpTQRPnRQ+JWC0dPUR+FwON/aG
	eTxzPfA232ccJwA9t84egcKRaHfSw/CUB0d660Vk2QByveWMJYJW
X-Gm-Gg: ASbGnctgDTvxmzk/jjfe5bEhG46AHTAAr7KdWmocBV6+Q3fJrUcmbA9n1koWEF4OP84
	FgTyKYFbH1nhOXhNB7FQ7Mas1zKRhOK8A0MBiHxGdhm8lO4ajI5BvkJ3JY4ujbvKnMziQvM5OdZ
	kik6WhxhoThhBsucrjh7Z/xp20rZ0GKOiLSM8pvrvbARDketXHKvi+LF9f4wq2OM7Xr34OxoxLA
	wSWM2/oxft8Pbj+0/vPpTu2inFVeGEQF1UL7zS8+pZoyJ/AFQhQkhmqUU6Ef5Kqr1zHLnrsUKvM
	EXaeps8=
X-Google-Smtp-Source: AGHT+IGOCrIcTZo/Z0lOIkDRiiD2nCB5lUrezU00sbuHHzxGiGFKWgEHDlp9N95obv3h9+sUy6i88A==
X-Received: by 2002:a05:651c:8a:b0:301:12:1ef3 with SMTP id 38308e7fff4ca-30a44db994amr20609101fa.4.1740044718218;
        Thu, 20 Feb 2025 01:45:18 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a3a0d1c2bsm9574311fa.11.2025.02.20.01.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 01:45:17 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
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
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Maxim Schwalm <maxim.schwalm@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] drm: bridge: add support for Triple 10-BIT
Date: Thu, 20 Feb 2025 11:44:53 +0200
Message-ID: <20250220094456.32818-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Triple 10-BIT LVDS Transmitter is used in Microsoft Surface RT and
MStar TSUMU88ADT3-LF-1 HDMI bridge is used in ASUS Transformer AiO
P1801-T.

David Heidelberg (1):
  dt-bindigs: display: extend the LVDS codec with Triple 10-BIT LVDS
    Transmitter

Maxim Schwalm (1):
  drm/bridge: simple-bridge: Add support for MStar TSUMU88ADT3-LF-1

Svyatoslav Ryhel (1):
  dt-bindigs: display: extend the simple bridge with MStar
    TSUMU88ADT3-LF-1

 .../devicetree/bindings/display/bridge/lvds-codec.yaml       | 1 +
 .../devicetree/bindings/display/bridge/simple-bridge.yaml    | 1 +
 drivers/gpu/drm/bridge/simple-bridge.c                       | 5 +++++
 3 files changed, 7 insertions(+)

-- 
2.43.0


