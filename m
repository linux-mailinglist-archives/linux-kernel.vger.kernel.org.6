Return-Path: <linux-kernel+bounces-310377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB108967BFC
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 22:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76BE2281C98
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 20:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E2C79B84;
	Sun,  1 Sep 2024 20:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4nS18Sg"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB60E433CE;
	Sun,  1 Sep 2024 20:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725221506; cv=none; b=YlXRoIHObG7rXWwYAW4iFbeva4FtFTq0wbYctn8giCjWrs4lchAHNs6y+OQLpnT4YMmWp+oKMSnRcCUtZQiwof+Q811EPiApFZZoFzNpOAz9Rw8w9DL/9MnpnV8tNMoIx4cPV+2R928jDo/SGaWOKss2u0tIdaflcyQUYm9lY5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725221506; c=relaxed/simple;
	bh=IPt4BCDZW5M4E79DIMrnAlmP1CMnEXijoXCAgacNC9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dlKPfOzXPG+v2ODh8mFVV4ez/tiTZiYPtlf6hilbLU/u+/i/4ISm9XhZVJQ6H6tsxjnggS6ibuqaRUXA+anTxfQIjBh0pN6LcK03QM1NVIoFLo+RMuuH5yvsRKve486Ixp5X0IDz+LqBc9omUcS9j4MTC8WnMi3IlLobn8JK4jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4nS18Sg; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-70f657cc420so1539186a34.0;
        Sun, 01 Sep 2024 13:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725221503; x=1725826303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uBC2/uLA65a/EWpnVpljuN87NwCZzasGJhTxIeoibZk=;
        b=b4nS18Sg+X7kHe8quzgZ0f3uZpD1LxSmrr4ElEGwQG8NcAbUsrF2l7aIys64nVIlkE
         jOJqfkZcffAOyeix8YS6d1ak26fyl1Q6Lz/+oe2e45+INoi76Z8IA4d/3Pp7qC4a5SIP
         i7Vho0xwFt1mZnqoF7KjoxwkUTIOOnBPYbGvcR3LnH7uZLDiHN9C6u6TOvyg5ggpeYcv
         Tf+CCxzyJjmfcLpm8nC9mHALBFAJVZ+hLZ12p7JRdr7RU6TvWlItdI8jHkJXWFD7tPBs
         1lOrDC5oRM5kt72f6WLf0OwpkWdMMYrCGpDE1K7bDW/E0Yd+bF+KhU6k23jx/WJDIeEU
         7Mhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725221504; x=1725826304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uBC2/uLA65a/EWpnVpljuN87NwCZzasGJhTxIeoibZk=;
        b=vsEWT4dONGJbjQ6XRr53QFwXrNYR94EFnPqmUTSccceY/U5VYn7IIdv5tdpeFc/fHb
         sCha8RfOnqgJinH81ewzVaYA8tbFIcEc14ZiW0j/Q2iHAWLXC7+UOyRsNqsd5StYoWNi
         4gZKLJN+LoejNevmSWBIO+G88saEhGiF7oTcvUF5arNTsaRg0KdeayWlU2SdzwA5NseU
         IzJQ/6Pyn7odB6b+8yMWl7uySxGHLSQwmKjf2WOgww7E3bsAtfD3L+e7cE1Ubysbd2ip
         bmcg15q/ElbnDm4r/cQXrkpl9H8eeGU8Z20cVL2kfIeTPze0nuRBalPpzbQDdyVtPzPp
         J0jg==
X-Forwarded-Encrypted: i=1; AJvYcCUr0sUubvJHoTHdx3hyR1A+9VqTK9PAuHC5Ev5k+EizBQs6iqRhncdK7wXE5a3rn4ahDObGyLSil4bV@vger.kernel.org, AJvYcCWM1d1VDmGByuAZLOpETXh3SaWalBTpkZwWf8Uf274yUJFjFCA/da1ne6vTMZQYIITG47LnjcCdOEnh/bau@vger.kernel.org
X-Gm-Message-State: AOJu0YzC1Iev5sZGgyoX7igRg7gafw3b1z1kTga16q2qeGglmQMPA1p3
	AfSgvecVERQt0zM46fEObK0oiqTTCHhPI+WvG7ijF7a5O3QOVVIh
X-Google-Smtp-Source: AGHT+IFur+Spr/+YKSoyKdsfNG0q/ygJL/7E799LPj2janhXF3NGmK4P4j8JKZJ1JWgkdy+PGJK1cA==
X-Received: by 2002:a05:6830:34a9:b0:70f:3318:1c68 with SMTP id 46e09a7af769-70f5c4280e1mr13772234a34.29.1725221503641;
        Sun, 01 Sep 2024 13:11:43 -0700 (PDT)
Received: from localhost.localdomain (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340bfa823sm35926966d6.7.2024.09.01.13.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 13:11:43 -0700 (PDT)
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mehdi Djait <mehdi.djait@bootlin.com>
Cc: christophe.jaillet@wanadoo.fr,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] Add driver for Sharp Memory LCD
Date: Sun,  1 Sep 2024 16:10:48 -0400
Message-ID: <20240901201118.3179206-1-lanzano.alex@gmail.com>
X-Mailer: git-send-email 2.46.0
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
Changes in v5:
- Address minor style issues in sharp-memory.c

Changes in v4:
- Remove redundant dev_err

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
 drivers/gpu/drm/tiny/sharp-memory.c           | 682 ++++++++++++++++++
 5 files changed, 801 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sharp,ls010b7dh04.yaml
 create mode 100644 drivers/gpu/drm/tiny/sharp-memory.c

-- 
2.46.0


