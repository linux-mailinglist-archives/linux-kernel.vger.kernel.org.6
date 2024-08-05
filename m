Return-Path: <linux-kernel+bounces-275435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7169485B6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 00:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D52AA1F23B2F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 22:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0417016E877;
	Mon,  5 Aug 2024 22:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UT7z54bu"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E39140397;
	Mon,  5 Aug 2024 22:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722898745; cv=none; b=V6yYhE7WounKtNOhMdFUD9e47AvEXkPB8QNhcWEm+EwvatndW5TLbxRSmWG7gXMaVYkSr0cxnyC1+GWIe0JrUIIXzftHuJbH/0TpVZb91mmotcG5VwQQNUR0/b8cq5cAcwgCjBmeEl9mGyRKtOl2eYIJcRPH0SSY+V96qJBXJ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722898745; c=relaxed/simple;
	bh=bZe51ctSMyLqETSyvzJHmgTbhJ5SxwR0jBg4IuJMNHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eZFOAtOygL+Lqqi2xq4U9tw8X3oLAW4Y8EjBcmEjogbTbxOFOuXliat0vJ6RCVqHx2SpraEo0z3BBTQTk+yrfBI/prOF4j7tV8fD9/Qamc4zht5ie8q9Ndn+aQhhnHgAIowYdXEqf4ShcUQdGTnGJiVvIUOGukfvO79808XUAU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UT7z54bu; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6510c0c8e29so1388847b3.0;
        Mon, 05 Aug 2024 15:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722898742; x=1723503542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsX0vPn3VODiXEEmMvN5E790VYxq/T9uwkFRTYpicVI=;
        b=UT7z54buBdj2Zag5yGF8rQndFYRPa2/BYV/BHTE3O1s48eEDtFlTQThhyjDSCJPMbN
         gRCvMfxZKX3sBiykGy4hwnnlBK5/53S/TEkgPotvquHneXD35YMCXh/Y15OUg822W74e
         BOtNIpRzKv5BCe4iZ6atblTfcanKuZoN0J0wHReLLk9aea/PVFhl5SHJgoqmcCsllfHO
         PDLW1P/FI22Ychj7k9g7aewoNJGbAlVGv4TVvEMEO+hqAYNeRcN4ypUdmGw9N2DgReHa
         bN0E7Ngl5WxCivMoaJa0xACIHEAhcjGEWJXHkOHq8WNr7YQyrKJytu1twgWWamBqETMq
         HuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722898742; x=1723503542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZsX0vPn3VODiXEEmMvN5E790VYxq/T9uwkFRTYpicVI=;
        b=X+WkCIJZMycGXAiBlXk11DkcGj+3qOhBzzIX1mcA/tJ3XiYpfFhiZdxCoQ+O/0Vjbn
         UrndyNt5VK52BnU7/6XNunjD9XKoOpgv6EnC9yhyKkd7tS77vSLC6pgNnzwaRUhKtmNS
         N/rx0WWq25VNJBpZtA4I6TrH8VHFRSz/a1AZBbBq12u2yfoxWXN25UJncX6rcVEQNl3h
         cdvuQCQ3r4bOyYX4qNdR5kZ7rNwQQJ4HgyzqVMcByhRApb8z3+w/4cPLsLrjwUhERyso
         LqqzvkljJ5alceXwH9327XKhOrqL31+1J1yFVgmSmx+tXhp9zRI76X6dryyVu8S6jpl1
         qfYw==
X-Forwarded-Encrypted: i=1; AJvYcCXMPA5AzK8hiFRcQ/D0Nc87/e2DBRTvD1xjX9chuPRU5J2/X4k64vO/r/nMpROlBot4101UBQftD01lw5dk+K/s0FplCU7sq7e3zzduYV2h3Cqw6ytxhTQWvOpOp13iT9Yd7aUTOopxSQ==
X-Gm-Message-State: AOJu0Yx65jxXqO335QLVPvYrusYNFxcFko45uOy0NRE6WgthJcIU2k0B
	8SZJDK9im5EMS61YjpMXK/3JtJmHDOPT1qqTXBCgEdoiFGF0izRqZH65Dc0U
X-Google-Smtp-Source: AGHT+IGy/Om6ctOSzeiK84WCNRq/re9u8Dd9Ybzu5JIMD5CNiQ98Qwg8YKY2V+kt5KaTtEfnqq4gtw==
X-Received: by 2002:a81:b407:0:b0:649:b0ca:2c9b with SMTP id 00721157ae682-68964584b14mr154483367b3.40.1722898742435;
        Mon, 05 Aug 2024 15:59:02 -0700 (PDT)
Received: from localhost.localdomain (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c78ad54sm40028016d6.31.2024.08.05.15.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 15:59:01 -0700 (PDT)
From: Alex Lanzano <lanzano.alex@gmail.com>
To: christophe.jaillet@wanadoo.fr,
	Alex Lanzano <lanzano.alex@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mehdi Djait <mehdi.djait@bootlin.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] Add driver for Sharp Memory LCD
Date: Mon,  5 Aug 2024 18:57:49 -0400
Message-ID: <20240805225820.13798-2-lanzano.alex@gmail.com>
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
2.45.2


