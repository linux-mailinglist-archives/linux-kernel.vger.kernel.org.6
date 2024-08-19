Return-Path: <linux-kernel+bounces-292950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3C09576D3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 23:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86850B22599
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB37166F25;
	Mon, 19 Aug 2024 21:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbG1Og8S"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09BF3F9CC;
	Mon, 19 Aug 2024 21:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724104219; cv=none; b=XpQ5fyz+drRmJXgQR9paOkLfpl2ADXkBcLD1m5LRc9mDhF5NncjErE72NeQ/HrkL9rDnilpMBR1XIN/xvjqgiaswAx65FHqdV6YFbzEz72vpkKy1qr9qGQCM7uLZ2cRBzAHLOs1ewo6jBbw7rfop9iyhc9VeyjUtfAgjL6+GO5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724104219; c=relaxed/simple;
	bh=bZe51ctSMyLqETSyvzJHmgTbhJ5SxwR0jBg4IuJMNHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oa5YKyEk4ePQx9oK7SfGb5If9HtfkvoMURCtbjk/0y0Rdtp1yt2T7eF3sKQMLwpUCYBZnTSFDqTi1AzFTdhtWHTAiYnjtvRjZFir8iVSJTO95M5zCw/EZApm/AdTo57YvgEMNsvg93iBJgSKj+VN535xZQszlVZ2A+j0qUWm9LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbG1Og8S; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7095bfd6346so2715462a34.0;
        Mon, 19 Aug 2024 14:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724104217; x=1724709017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsX0vPn3VODiXEEmMvN5E790VYxq/T9uwkFRTYpicVI=;
        b=mbG1Og8SxrV851AeaVkWwVgUBnPS+PHA4lAwvI9VlbJQ5O9er5C2wh8sWuy08N8+2Z
         QIFSUOFMFa29q2HT4kAsBR+7Oj1TYoYoNrcQGM9MwGV2JPFW+2EjchG+6G3EkDQcBOHo
         v5EKQL/Px1A6DxgqF+902IM3iQd2t357nK0nxIwdSxRU0MSWvm0sD6HFe8MmZM1hFEZ/
         6RJ1FMTnqrFZh4rWWzC7qTQ0ngZDD0FNzreEwSldzPnMUmSxeNERBvXCABh3iWiG/C79
         sLy1dn7lDuy/Ye94U4vak3KGmMEDejl/T7rsBpjUhYyXpCfouvbv9z+yFY6dEuETc7Eo
         zKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724104217; x=1724709017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZsX0vPn3VODiXEEmMvN5E790VYxq/T9uwkFRTYpicVI=;
        b=FiAeCU8AsQV2l8m6vlCMDi95DA6eX2F831XXA51gse2sKErdUcvOBx7Af1PA2Vhj3+
         odoo6VirMDSoVZl1TAQ2ee4Q8uPOOFGTi0j4gX5sDz3qMSzbxsUqpwxou8sZY7LYSJlB
         L+o0docd3a9gpYnOEItamlGTwVECck8H9BTSSur/6V0ZXnzEMwY6Z5hH+E6tvrb3GjCj
         zxZ0BZF6SU9w61mrWg5T7N1EpdkKCY1y4HOCUnggVNb8Hz0Ga4dP29iuNhRfkrh5Q5Gi
         wTSXbwSymqldq5hUBQP709Gf8qoiqoHrLNtA/BCZgObX8iPzJkYf7dZ62UXG5TuiU8in
         yscA==
X-Forwarded-Encrypted: i=1; AJvYcCUwp9DL3Fb4WRgyehCeRDoZhkREAZXKeW0Si1MVj/ph5CBuNi2JIfUE5p02zRVFAURQEh7kHpW5jpTfZTC9@vger.kernel.org, AJvYcCWZTr9gLneJouu0Dom+F7qXUkJetBeXU16RCfGREt/6w80tnwbt0Ec784XdCY1Vo7bY8liVd9ot+cZB@vger.kernel.org
X-Gm-Message-State: AOJu0YywlQghETW89zu7pCwm/GvpJqVkJOxtiJgd+jtnee7u6wkKSz0e
	rQoQ+Lp/8LFgA4u5kNMMKeqvvd9AqI05qOSuar/UKU9HzyoGw/KG
X-Google-Smtp-Source: AGHT+IF8lRfjvuUw72IwxAv1oLnDVPpLNWK7tjRn9lxxCoLd1VPxtPvwrsyGtsANNHGHJ39LlnYTOA==
X-Received: by 2002:a05:6830:43aa:b0:703:68d0:a267 with SMTP id 46e09a7af769-70cac82e9d6mr10568079a34.3.1724104216717;
        Mon, 19 Aug 2024 14:50:16 -0700 (PDT)
Received: from localhost.localdomain (23.sub-174-193-28.myvzw.com. [174.193.28.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454e5b2b0dfsm2432741cf.53.2024.08.19.14.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 14:50:16 -0700 (PDT)
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: christophe.jaillet@wanadoo.fr,
	Alex Lanzano <lanzano.alex@gmail.com>,
	Mehdi Djait <mehdi.djait@bootlin.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v4 0/2] Add driver for Sharp Memory LCD
Date: Mon, 19 Aug 2024 17:48:59 -0400
Message-ID: <20240819214943.1610691-1-lanzano.alex@gmail.com>
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


