Return-Path: <linux-kernel+bounces-530739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA36BA437B8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F3091890730
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 08:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E5F25E465;
	Tue, 25 Feb 2025 08:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDzwAiIM"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAE918DB1D;
	Tue, 25 Feb 2025 08:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740472453; cv=none; b=oypKi1FXiEzjd/fKQ0sktQb3zmvDe+66HiSCyybIDFZrph1Qi3Nj/ZYmOwHl6tkp6GNM/QveRu/YxzUP8CnZ/cxKxMcpMc4VZqTikxMhNe0t5aeOXyFz6pjtsrAvIcO6gPHcx5sh7fnI0+wzxa1jNCcsZYW60LqKrmA/sSqOCus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740472453; c=relaxed/simple;
	bh=QvrTqaLDyImGCadrKf+gt4FWLG66Tv/eNc2tekUYK+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WHvMCW02VCALao6MOQLREUe1G1stgW29Mg6FWD1q3IbWdtQYXk3emdnNgIMp2F8AMl1n/slMgsl1ERmDJi27MCZBPbAOZksUWBYxVPUfnihIAdXrtc0Kdv/Xk5WvRS0R/kE0u7l0ayHhmQZR1UZ6EAGmWd5LGSDSHNOjMCKSDg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDzwAiIM; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e0373c7f55so8180995a12.0;
        Tue, 25 Feb 2025 00:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740472449; x=1741077249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ncfMgMCnPRMr8FAyu3AxbC4kltJNrhu35yNsQQCCo+A=;
        b=PDzwAiIMN3zXK3lg7r6KJAN/HgLdQfXWhGG+r6LlK9UN+wFBPel1Mz5BqL3ehc9OIT
         QxbAsB7ZtDQBevzahPDGhW/oDejUlh/u33vUSkx+8mt/eHJ6InmcveVJRHQ8V7cookP/
         9NwnkKpJaBl3mVmP8x+gRo1vVZQvC5I+GzgtNRz/v7I5YfxxCF+6o0Xsw5N0ap+VvwXd
         FOQq/BWBcO9cx2aXckOIkY4iSqwAcAe1GMGDtKGonlxPctMY0AWhwUJIW34MIwWuJfuW
         CHtHaOzDYLhnouNj5GkHUjIaFVWr816NEebwOmmm/Dc9qH7Y/vZmUEslrGoSj4EoEdmQ
         gakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740472449; x=1741077249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ncfMgMCnPRMr8FAyu3AxbC4kltJNrhu35yNsQQCCo+A=;
        b=rP5EgwnWpHHXjGjFJ/R6aXT2LBvTiTkCvJPgn7aI7/ItshzxZDark45bPmLZAto7mR
         s9zyv7RoeraoAk8iXh8Zvito71Qh0ruqjl9zjcHUOP//B8tJ08OxF+NbUtN94SmhiHeP
         2/IRoZRGS6BUpq5uGR8BGRE+ctc138rMwshO2x9K2F7ZDBel3Wqa/Eji6ekVEjWzvEmx
         jxYtQ5b7o9sn7NvhvmPHuWOZn2T6n5h9jI8pk3zsW4ORQ/sSFJKFQXJdGWSu/HgZdqJK
         ACZ5th6yR4Wop8+w2jFX7ybSq6Ng8aUkI/tmNEDBy9IPZkdRgMIenL9MM4b0gsdxi23m
         TKww==
X-Forwarded-Encrypted: i=1; AJvYcCV9J13ennFStNZ+7us2uzbFLC9AtpqKgAwecthqZg7q1zqsXgLFYbrOUQsyzAGNImbfl+Hf1tUepGcyIqBk@vger.kernel.org, AJvYcCXDj2ZxR8/1eOYsih06sUtZ3hnXYpxkiCodMbbvryO65f5HnTV4ZxXRU0SzQk84iet4RroqbNNeCPcx@vger.kernel.org
X-Gm-Message-State: AOJu0YwFZy7bGW3TU7BrRR/LfpxEkkjX+esc5kGdSAZDf7XyjkdIzDxT
	MInhfiRLjYpHSs3n6JTW0ZQ9toacwc/qHwjiKWPLr+XXZWPM9/zj
X-Gm-Gg: ASbGncu27nEAGhxRIVCH3/+ZV7L3QeWMc1w5gZVQfOv5ztGg8WYaeuCAyhKUsLoWw6j
	zdBM9YfdSeSXHbjd2DEN9nPXg6X1xsX4nqMsZtBYfbwdC0NguexXYAaFGlWuuHiod/ed85q4sII
	PEYu7IsRzN53k1Ikg9CmAQPweO623pgbiphrPFXNrF7kuzJVtnf8pO0UBMIPdEOWowLwctAESJz
	VqjaHw1iF3ox83K57JPVRi3lhNxYN6qVkd6WsiHIIFnUPV7Di8LmNeCN4HivrbWFC6D9q5u1rfE
	a48MrBWDGQa3uzm52w==
X-Google-Smtp-Source: AGHT+IFsVJ+G4evgAq2r7H+GUziPoyhbg5V2ZB+XNwTzd0UZ8vWBpEbIR7juW9BOXlM/qfA+5BMgEQ==
X-Received: by 2002:a17:907:96a0:b0:aba:5f44:8822 with SMTP id a640c23a62f3a-abc099b838amr1684793066b.11.1740472448765;
        Tue, 25 Feb 2025 00:34:08 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1cdbe0asm102660766b.36.2025.02.25.00.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 00:34:08 -0800 (PST)
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
Subject: [PATCH v2 0/3] drm: bridge: add support for Triple 10-BIT
Date: Tue, 25 Feb 2025 10:33:41 +0200
Message-ID: <20250225083344.13195-1-clamor95@gmail.com>
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

---
Changes on switching from v1 to v2:
- sort compatible alphabetically in schema
---

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


