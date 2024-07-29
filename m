Return-Path: <linux-kernel+bounces-264964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E5593EAA8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 03:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0D68B21023
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 01:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9140475808;
	Mon, 29 Jul 2024 01:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZ0PhhKV"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583D43C38;
	Mon, 29 Jul 2024 01:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722217446; cv=none; b=hsVvBKOU4vHjwi0+/WQuPan5NuxMLBDTpiJeT6scpWK9H6JY3XBAJ4i1H8QcWyXwK8kn90kKgI+ohp01JdgxFCvb1R7q2YxK0SRmVbDRxVe86rN9nOUxT5B3ehidNzIHNZW3goab5aOLSA46Vq8+8QIcn2Y/tenHassI67xNWsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722217446; c=relaxed/simple;
	bh=X+9xaNnH86UdGvXQC6WeBwTsc7Xj8IDPsyRILoH04b8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SmP4PZvCH21wWz6YqkMDZwYUGdIZvViRIGKA9Es66BzFHBKY/DxuvMKPJweCLCz1OC346C74OaEMjqC0CE7awxq/V/rK+GUGw7nij3/Gk7iK9/4oOimjfm+ilnpap1u3+aH46dgszifPbio7PjsbV3B0XcgUu3sTmAWKlsqrq2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZ0PhhKV; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-44fe11dedb3so12448601cf.1;
        Sun, 28 Jul 2024 18:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722217444; x=1722822244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wuth67ftmePdj07hmFU5SpHSfVn1GlIZOSwGwoav3KI=;
        b=BZ0PhhKV12tU3xfbmvjKMjgUsFMVpJqIJC/1N6eGbzXdarXF0ZW+KE8jVp5wFw55zZ
         376GKIPAblsBe3Qv+go6yR804YFc+S6G4QBKEFVplKIdl6QeaH4Wv2lGLNuKwH++v+Qp
         FFzsHIXcXchINGw91ehhgqEuoxpP8fYkY51DNIaBBVF2GmlaLeX2hmduk6KYZHaUERWM
         pbtDxlMlTrG4VhURi2zGlQrEQXobhpSGhmmTokuN/5H4C5EYXMkzlwt96MWZhehOs6Rv
         ft5eUNy2k1zMtMgX21ZkHjpAz5g4WXrjbD196Aeln+B/jwu5z31qUr/dk3Ofl95mjAFL
         gzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722217444; x=1722822244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wuth67ftmePdj07hmFU5SpHSfVn1GlIZOSwGwoav3KI=;
        b=tEpbDiSM7BLsk4lnws+1f8Osl1ykhW8+eeVvSokQ5de4cwOPs07B+RSDcVWtYPUanR
         yXrX+XhzxqbLBfbmPkZqnzSa02Z3SjXgPMxTYke+QutSczElMC8gKlvhsh6Q4skJUuKZ
         F8V2hwqIWTy+XGIGlqKjZydKLNoN5IKVoSz/6Boiz4HrP9d36wrwwlgOV5DPbNlb2TEV
         wQ18Iad6ibN15XRJCJYld/+3NclafxQPYIm9ph2r4IGcgP6Bqr862qs0o8aufXIQxmxt
         Sa7ML6vrA7MfPST4bpsTrea13ZGDmMbvf4gGwgkWQTEeswJIuDZlUHi+N5javvC9Wu0p
         uRlg==
X-Forwarded-Encrypted: i=1; AJvYcCWZG3JcATYfx/O0OjJiV5O/4CHiRuwiHr5HbOThN5IpD8ni5RMOaHlVurjS8Z2M0BFr4q/WtDlqATxY@vger.kernel.org, AJvYcCXdeqacVbWMzOqnOZ7IasNwJQkpN8hydQklYxwlHkUBi911U4X63RFea6iQH8x4kppKPvkEnF1/WYTOe20g@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo5wat699HfSndtpGXNcCgCqvK3w/wJHhRyzrQULARg7pypfsA
	CALn39vH1JLNe0dpecUTcQntiOO0vaP47MkISTErHjcRmqCBN3Dm
X-Google-Smtp-Source: AGHT+IFHl3+hOoC1WMdUWwOo9snFlWAX46otYQMaNmsyv3yiTJmX+D0F8IHpfFxZOjYQecFKUmincw==
X-Received: by 2002:ac8:7f14:0:b0:440:6345:257f with SMTP id d75a77b69052e-45004f5e77amr99749301cf.60.1722217444077;
        Sun, 28 Jul 2024 18:44:04 -0700 (PDT)
Received: from localhost.localdomain (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8199a6fsm37191171cf.58.2024.07.28.18.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 18:44:03 -0700 (PDT)
From: Alex Lanzano <lanzano.alex@gmail.com>
To: christophe.jaillet@wanadoo.fr,
	Alex Lanzano <lanzano.alex@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mehdi Djait <mehdi.djait@bootlin.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Add driver for Sharp Memory LCD
Date: Sun, 28 Jul 2024 21:42:40 -0400
Message-ID: <20240729014311.1746371-1-lanzano.alex@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series add support for the monochrome Sharp Memory LCD
panels. This series is based off of the work done by Mehdi Djait.

References:
https://lore.kernel.org/dri-devel/71a9dbf4609dbba46026a31f60261830163a0b99.1701267411.git.mehdi.djait@bootlin.com/
https://www.sharpsde.com/fileadmin/products/Displays/2016_SDE_App_Note_for_Memory_LCD_programming_V1.3.pdf

Co-developed-by: Mehdi Djait <mehdi.djait@bootlin.com>
Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>
---
Changes in v3:
- Fix file path in MAINTAINERS file
- Address review comments
- Simplify mode selection based on match data instead of model

Changes in v2:
- Credited Mehdi Djait in commit messages
- Renamed sharp,sharp-memory.yaml to sharp,ls010b7dh04.yaml
- Using strings instead of int for vcom-mode in dt-binding
- Fixed indentation of binding example
- Removed binding header
- Removed extra whitespace in sharp-memory.c
- Fixed error handling in sharp-memory.c
- Added match data to of_device_id table to be in-sync with spi_device_id table
- Replaced redundant function with spi_get_device_match_data
- Sorted header files in sharp-memory.c
---

Alex Lanzano (2):
  dt-bindings: display: Add Sharp Memory LCD bindings
  drm/tiny: Add driver for Sharp Memory LCD

 .../bindings/display/sharp,ls010b7dh04.yaml   |  92 +++
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/tiny/Kconfig                  |  20 +
 drivers/gpu/drm/tiny/Makefile                 |   1 +
 drivers/gpu/drm/tiny/sharp-memory.c           | 684 ++++++++++++++++++
 5 files changed, 803 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sharp,ls010b7dh04.yaml
 create mode 100644 drivers/gpu/drm/tiny/sharp-memory.c

-- 
2.45.2


