Return-Path: <linux-kernel+bounces-218844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B67A90C6F0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7CC61F222B0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62CD1A2C1A;
	Tue, 18 Jun 2024 08:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpA0CEjG"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B3E1A073C;
	Tue, 18 Jun 2024 08:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718698548; cv=none; b=XfDWVevnXQc9h5xmff3LrH8UFzgmPewTPqsI74uZHTwrRZqBFzxdA+ya88dkrGzhhaTJZCtru5mqIvWR0JhELlLp5rQOrScbbCbgZ5u9K8dXEWo93s+B3ynqZJ8iPFkpUluyX9HaHEqEWGGz9y+L0HAEqzUEpqk5Myy9kltYUCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718698548; c=relaxed/simple;
	bh=p5kmON1LmtHfiW730DWPc4HCzWX0wYgAIRMnGKZ0yk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cuceGLpJWRYVffrOBcbgaGjf6owLGz98B1Ce54+kDdfz7kUsu7LDRdJs7Ac28vviK51wQlOYla6doBTtN4HK0jlKSv9G7TuFWYF/fpHSigoc+WYHcC/KP78IKQXijyvj67LN9YGEcRsAtu69HYzWlPOydyf9XljlWC8J4+EAn44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpA0CEjG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f7028196f2so42166215ad.2;
        Tue, 18 Jun 2024 01:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718698546; x=1719303346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UUmVLEnpoTJ592gaH7I2FytN3HjeWdDhuLXYQB8jM6w=;
        b=RpA0CEjG1HBGf6blYD6MoI/SsE224y7ZKPLLxhc/1vOOtcvT09gpcNqyZEbF2cx/Jx
         GWcrcnSyXcI9cYaA8lp8UzpNux/BjFTtTQhfP4kLNodtkz7fEqvh558eCBIh2/qPMr4D
         4s4VVvthNjsNAFveinZKkz46QtNgVdRVr8UQjKuK3CAWdUeAQmNhyeoFcaBlyw+iNwA0
         fsA/7Mwp2eZKSgfXL1Z4hNksPvmDGGVQD3RblY9YnJBrGrqwkTWgHH/1Tqsbo2LBvC7R
         loqotnuI93s8laATIwerhu6bfQviKI5Z7RKZDDPUh0q0fPl2x8qa4ha1NP6yVXYCe0NW
         1HXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718698546; x=1719303346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UUmVLEnpoTJ592gaH7I2FytN3HjeWdDhuLXYQB8jM6w=;
        b=o1LDiQYZAvAL8pZ2lOjk1fDlYZIlSukVnAvVwf4fY/nwRlJXsgF/fkqq6kJODj6llj
         G2sjuJu+PKcNuvjtwdNCgnivq+iCyKTjm3RhzMDHCK/XWAbv1UsAWAYyDlmSzMdxsDsO
         SMfz6UGEqqJpiAlyOF98wwdo7l5rqL2EJwmyVz90VCEYvxTMaF7fkmhfJngIT69Ypdvd
         kYu8Fa3wmlb4JeyXnKimkqmPew7ZZ/RX7hmFPZB803YamkqW/wFPkR//pUEvaI/hTkId
         hJ1o/VuVMb5Z+gP/j0Hdqs4OEW8+rzJpML7PpqrGxgiIkyzrG7POqXywzfwXxnE57Mxe
         Nb+A==
X-Forwarded-Encrypted: i=1; AJvYcCXHaD08xd0ROnboDwm0H4A10L5a5W1bWKKLQOVP1/M9h30fTuQILDWpCTDdXTvhOFPtyIcjqOHq6dlkFp6Ls55VUECntMDSbrSOow==
X-Gm-Message-State: AOJu0YzRCdk4g9DvFBcRgH/UKoMG3BfjmCk7bw6YWLUgpJlrSNIJ1gKQ
	2/xADKZJl+k1He3qMlEPfRjwkwSqOfSKIUJdeemeIsGCXhoKA6FIasevfvY86Es=
X-Google-Smtp-Source: AGHT+IHU5BFzsTam1WGUVnBcn0r/eEWH4R0hCk6n1ZhlJxSfFD4FOM/OQyWU7LH2CuWdWgIaHT5xfQ==
X-Received: by 2002:a17:902:cec1:b0:1f6:8235:dba7 with SMTP id d9443c01a7336-1f862a0cdedmr127524065ad.69.1718698545805;
        Tue, 18 Jun 2024 01:15:45 -0700 (PDT)
Received: from noel.flets-west.jp ([2405:6586:4480:a10:167:9818:d778:5c14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f1a1ebsm91883575ad.238.2024.06.18.01.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 01:15:45 -0700 (PDT)
From: Hironori KIKUCHI <kikuchan98@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Hironori KIKUCHI <kikuchan98@gmail.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Subject: [PATCH v1 0/3] drm/panel: st7701: Add Anbernic RG28XX panel support
Date: Tue, 18 Jun 2024 17:15:11 +0900
Message-ID: <20240618081515.1215552-1-kikuchan98@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the Anbernic RG28XX display panel, as used in the RG28XX
handheld gaming device from Anbernic.

The panel is connected via an RGB parallel interface for image transmission
and an SPI interface for configuration.

Since the current panel driver for the ST7701 variants only supports MIPI
DSI as an interface for configuration, add support for SPI as well.

Hironori KIKUCHI (3):
  dt-bindings: display: st7701: Add Anbernic RG28XX panel
  drm/panel: st7701: Add support for SPI for configuration
  drm/panel: st7701: Add Anbernic RG28XX panel support

 .../display/panel/sitronix,st7701.yaml        |  36 +-
 drivers/gpu/drm/panel/Kconfig                 |   2 +
 drivers/gpu/drm/panel/panel-sitronix-st7701.c | 362 ++++++++++++++++--
 3 files changed, 357 insertions(+), 43 deletions(-)

-- 
2.45.2


