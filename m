Return-Path: <linux-kernel+bounces-263681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C307E93D93C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 21:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6EF71C22B15
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C0F3BBC1;
	Fri, 26 Jul 2024 19:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blrnt3Dz"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DAD770E9;
	Fri, 26 Jul 2024 19:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722023105; cv=none; b=tZ44i8DweYhpK69V8pqe50shL6n5VfTts7KdVmMQGwenSZTCrX4F0Wu0sR5cJkyOn+9084BPXvR06eo+DA+Oca5JgIrvIvR7ZXhFDvpJpFanrhMFPB0Teen15d7ZJS0zyMFuknL9ZHtlxNtQBQAdPN3tCgGDHrcDH56LZuoXaFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722023105; c=relaxed/simple;
	bh=SL6Vjoh+Gyq68HbpZRjRCUqGr4K1V7d2yBHQ9sr6NEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8xMd6Dljw2CaqbrdZx/W3K7OS5C7pCMXwilq2qXkGZ605bIn6BYaMdzbmIK14ifLSaHutHZ8EHGKMmUrEPAN/lFpmHLxzvOsjYPuhzskWPOt5j40BUZIfSEyCOU+FXoxWIxJX6iC9oHLb0BQe0BtHHbxMyCtXJYFX9+bZ0pUbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blrnt3Dz; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b791cddfcbso5291666d6.0;
        Fri, 26 Jul 2024 12:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722023103; x=1722627903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ij7udA+D2YyUWRgHBnNSpIqZuzldiGFVb6iQhXMCGwo=;
        b=blrnt3DzbX4zDzkAMcARk/WYIJEeCm10XQTd9Ngxk6ak+7Yci7uhTe5061dzBY9nuf
         L6Jbunp6hPBMJmwCh1aPOweEI9AAHuYajPl48jklSFB2LgAU+LfO9Pa9ygyg7IWG0Pc4
         kjscSYTMCeQAglxpEu9fy1sF8XDaqhJE8UwKSKCPaeIgaei5damRirhLG88velBJioTL
         Ts8uz+nytr59R45r7Tk17VU0jLx7GFC8Xcx/Kp4OH6RrDXKJMyNQt8E1IEHkmgMCX3/Y
         2r6V3LMYEuBWw9tgu1wcn+IIPiq82d7t5m/B71vtFJ1e3o/caQ0VUzYaluPSrIhBvGKS
         2Kcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722023103; x=1722627903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ij7udA+D2YyUWRgHBnNSpIqZuzldiGFVb6iQhXMCGwo=;
        b=G8eSmJo4svPfsC3/nbsryvjoXUrBr4DGvnYcRYXBo20oy2e4+JA9eldVNySiUa3LbG
         kcjQQ2Bz1MUMQ9LMKZPIS4Ce8T5pNbNgYyElAejKcp9Dv3sIvUqxxG3QsGP6v+Pl43EU
         aEaYGRpQ/cD9aOsPSSIQK4RQh+TVZMU863nvmwbnud3Dy00UinYE9e1QCqrrDeLx0QkE
         SV7ZklwgmM1UaORegGr7iasC1rmOxATZsz2LQ/fsWZln8BkvQPxu7+Bians48ApFRonw
         s+RzhqpBCOLPepzlHaNxGknDNZU2Pk5+IkVZcoAE7VXRysE+563Y3qc24arW/NpbNYQe
         3Sfg==
X-Forwarded-Encrypted: i=1; AJvYcCWZjcwmMxn/VNcphlfsSyLibWoFdG+nL5fn/u3bd8jliE4CeyLq6JZZR9pGoj5WP5q3uXXHO86b0pmf8cmUIQUAcHb6VIhvl6yleNFcL+Pcf+eP+yaYWw4JUykl1mOS/Mpiq4WFep+oAA==
X-Gm-Message-State: AOJu0YxNE4ETnalVnhEkKaYcEqiclWOiQuk+rpyoTjyofpAGqy0uRUa8
	Ta6YK9QkzNccYwDnDpSo0fEVAPM3Ovt+0YPo//v30njOd003KzI+
X-Google-Smtp-Source: AGHT+IGt5dvyu4jj5Vq78r+w49BboaXBabmT4d7u334UZ2Zv8odJ9lpR08MB7TDHUbxTtGgFjBxY2A==
X-Received: by 2002:a05:6214:20c3:b0:6b4:fc6f:17ba with SMTP id 6a1803df08f44-6bb55a65896mr12048276d6.33.1722023102861;
        Fri, 26 Jul 2024 12:45:02 -0700 (PDT)
Received: from localhost.localdomain (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f8f83c9sm19409986d6.38.2024.07.26.12.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:45:02 -0700 (PDT)
From: Alex Lanzano <lanzano.alex@gmail.com>
To: mehdi.djait@bootlin.com,
	christophe.jaillet@wanadoo.fr,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alex Lanzano <lanzano.alex@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add driver for Sharp Memory LCD
Date: Fri, 26 Jul 2024 15:44:24 -0400
Message-ID: <20240726194456.1336484-1-lanzano.alex@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725004734.644986-1-lanzano.alex@gmail.com>
References: <20240725004734.644986-1-lanzano.alex@gmail.com>
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

Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>
Co-developed-by: Mehdi Djait <mehdi.djait@bootlin.com>
Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
---
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

 .../bindings/display/sharp,ls010b7dh04.yaml   |  93 +++
 MAINTAINERS                                   |   7 +
 drivers/gpu/drm/tiny/Kconfig                  |  20 +
 drivers/gpu/drm/tiny/Makefile                 |   1 +
 drivers/gpu/drm/tiny/sharp-memory.c           | 727 ++++++++++++++++++
 5 files changed, 848 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sharp,ls010b7dh04.yaml
 create mode 100644 drivers/gpu/drm/tiny/sharp-memory.c

-- 
2.45.2


