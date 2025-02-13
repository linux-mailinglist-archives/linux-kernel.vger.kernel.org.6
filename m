Return-Path: <linux-kernel+bounces-513042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E47A340ED
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE5B416AB35
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A782222AE;
	Thu, 13 Feb 2025 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFP4li96"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC34221723;
	Thu, 13 Feb 2025 13:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455001; cv=none; b=qR8ji2Tuet4YyYSAX7XMcbMKph3AOeC8F0JF1wQHt7gZRkHIitAITY7xECinj8LMDcLlBR5L3R9XVZ4zr3Pp5THLLtGtd80dnrbRsiR0byKyRqiupSBdjLFJ5KxTe4wMOMEI7i11wG+L9ZvP0h+dRQSiWlLywFxuLU7H4jbDKOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455001; c=relaxed/simple;
	bh=0bzOZU9DNoHMGXdrgTJbmYVPmVDfalK27b70a0bjpZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dB12/SG3ZYqhGIpQIt+27JiXJUk/qkqrJl1G73BXr3IeIEIERBDaCWeTCfkrdMzcNaxN2LbBOzr7wkE1oBPIiA7ILJFZ0WpTMRlKGRCzlhYorYV+XO69SmBNJEEbQTa+ZsAaZZgjFYQUomWwDtLAjRs4dqjYujhjQ4KOl09YLFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFP4li96; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-545054d78edso869486e87.1;
        Thu, 13 Feb 2025 05:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739454998; x=1740059798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F1KTfs4zph4boLY7TuCFGSOcu6RxZyj8ziUa/3XCpMM=;
        b=AFP4li96xU4gEK3K7rk05qVgJ+NAa0YJkU+LYXQXGCP1LYf7ioIrRu5cyGZr5Of73d
         X/+9GP8lWY2PV2Goptj5Y2at8tyQOkr/1E0pV+TfwrmrTDkQNU5ebRgNAbMH78WoaXJ9
         gfXTxj3G9SO4xvbMEKx2YpBi8sImtjytn5B73a9wfVdYBZjLa/3I6Y6VbP90uXiHpL9L
         wI1LbHWt0XlJyano63MxI/kyIezo99fJ8ZQxb4k6FXlfaoQqTWt6351EiprbbFTx1Bnr
         8k8DHQ+e2EM3OZpgDtUmodRpXammd6mCjxiCLebVfiodwd2J4/vHMwC4MT5IPNnBYm+d
         25Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739454998; x=1740059798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F1KTfs4zph4boLY7TuCFGSOcu6RxZyj8ziUa/3XCpMM=;
        b=XIGLqZxozi087SxQlG9EtSyKnBVuv0lrK2RwKLzk37XssZVtojNuH1GNnpXrgwmfzq
         BjzRimI1dpxBpdQI+oH12Cfse5N4jWx5KXNkQK28rdGsog3O5NVgdpBlJotddgeUqO91
         D7HxoXVX9NkTaZOXAxuXJsEZGz7ib0V5A34tjzTG8L02XQ7PUDNhW9ennIIT1ipOahy9
         l3zCiklD9gU3s/lUu7aVbVZva8CCm7ljFoR6IpM07AmdeOCDckInrYk2rFi0x8t90p1Q
         WQQsWNVLqVOEhSbId9bGDQt5+1ZWobrOVPW9BCDS//8tSxQUFtoWJtroO03TzZvVogfJ
         EY9w==
X-Forwarded-Encrypted: i=1; AJvYcCUtxdeDPPMGI2ZboTuvSOA5imyW0/SIxaG6YIk0CjBcAgLX8eBTqM0q2T/vvBdOzswM7shfpTilKuoR@vger.kernel.org, AJvYcCVKDnaBX7FJ98c8dPEzqhK/x7ORdsX91wa3l2g809lpUkoOk5isesYqBsX0P0sJbaa3OmtxGMFJHWDgJc2R@vger.kernel.org
X-Gm-Message-State: AOJu0YzQB0tRLcEPDNOqM1fqg++4tBZh5CI9n/a7ZcUUyUSLIkrSrIZo
	UchoAfbZLde/HfoUcgMOnJEBjwck46MJEJPAQtSQtSqZfpbb9gaU
X-Gm-Gg: ASbGncuzafZteblTnX4LKy8juQlFXNxni+NkShvnqEe3j0e5SfYtV0Yplp7a93tPg02
	jLcjJVla3luDfRxEGE9kn2oden8v2nVXEGuc1i3ijkQ74BZYViXlQz+BWmjtBwHc5aOTVi1KqFO
	PyVBTSaCzvaDNRt43i8SyyTd4NX3a9CC+qRBmVNJ7518+q77v3ZG6cmg9vjXi0orPhRMaYGuBPv
	Janw8wLPKl8TBV9Xh2Hw7sXszIZclY9TvX4xhpJCoT7spfUGg6+VBQt236cVFyFhGR3NkrtGwn0
	I8Of5Q==
X-Google-Smtp-Source: AGHT+IFzn93+hkoIo0080/fkr4FMQnCQ6x8hN8CmqeZ02jdczjAd+3TQlbCPIkNbBfAC00Fw+FGzJQ==
X-Received: by 2002:a05:6512:b97:b0:545:2300:9256 with SMTP id 2adb3069b0e04-54523009450mr123450e87.12.1739454997305;
        Thu, 13 Feb 2025 05:56:37 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f105cdcsm177789e87.116.2025.02.13.05.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 05:56:36 -0800 (PST)
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
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] drm: bridge: add ssd2825 RGB/DSI bridge support
Date: Thu, 13 Feb 2025 15:56:03 +0200
Message-ID: <20250213135605.157650-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Solomon SSD2825 is a RGB to MIPI DSI bridge used in LG Optimus 4D P880
and LG Optimus Vu P895

Svyatoslav Ryhel (2):
  dt-bindings: display: bridge: Document Solomon SSD2825
  drm: bridge: Add support for Solomon SSD2825 RGB/DSI bridge

 .../display/bridge/solomon,ssd2825.yaml       | 140 ++++
 drivers/gpu/drm/bridge/Kconfig                |  13 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/ssd2825.c              | 741 ++++++++++++++++++
 4 files changed, 895 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/solomon,ssd2825.yaml
 create mode 100644 drivers/gpu/drm/bridge/ssd2825.c

-- 
2.43.0


