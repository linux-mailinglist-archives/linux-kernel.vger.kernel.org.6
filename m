Return-Path: <linux-kernel+bounces-510813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C848AA32267
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 261C43A6C51
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604A9207DF8;
	Wed, 12 Feb 2025 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Lfns9O5F"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18C42046BF;
	Wed, 12 Feb 2025 09:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739352985; cv=none; b=B/wNe1cMxH/to44NtnArDMOIKzFLswffjXkhTGnRXIlrJjzAfkVlKOMwjGr0wnNngk0g1QKtpS88W5on7GAVZ+8rk6gZzuS9t5QrFRQIP680u1BfZvmqcdg9bVZiH9fr5B4D0HHCeWmL9krBVWqEQpmm0rmF5yNK78wpF8QqSCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739352985; c=relaxed/simple;
	bh=E46FcXGyt6jr4xuC3NTngM/rIiOGZ8dpplEXZWHJbBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TLZQWbjGwlQxffUF4J9z8Jwj9sHsD4zDFuJS1JwsYv8HbfEtl1ppj4q4LVH7jxlNa8YSxvfLVtt12FOlrXXVI69C8+iyNL1TRhvO3o/BJTbG8ntFlBsOQQfaDy6RWCHOD+7NCHITc/B5gAXWkK/Ig76GYWnltCf2NfUL+kYD/7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Lfns9O5F; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=m1dn8
	61sdPu2eS3arIGhwMkywhJQMaUOQvKVQ0nUWMQ=; b=Lfns9O5F+OMC//3F7cFzK
	+5MIoi2h/DoxsvqpTCLXAulnbYBUlJSh0pG3Q8yQbAgDuvuvcTa/duwJo972VZjh
	Lho8pKc0LTml5HT2qTVFYEbzlJQIBFcY0ZrW+hzowL3c+GtHV/SzDH60R9FsewyJ
	SNbRg7Fl8DV3jjbV3oMvZA=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wBnG9Fja6xn14FuLQ--.33700S2;
	Wed, 12 Feb 2025 17:35:35 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: hjc@rock-chips.com,
	krzk+dt@kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	derek.foreman@collabora.com,
	detlev.casanova@collabora.com,
	daniel@fooishbar.org,
	robh@kernel.org,
	sebastian.reichel@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v14 00/13] VOP Support for rk3576
Date: Wed, 12 Feb 2025 17:34:55 +0800
Message-ID: <20250212093530.52961-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnG9Fja6xn14FuLQ--.33700S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw1DJry5WFy3Zw1UtrW7CFg_yoWrKFyUpa
	95C3s8XrWkGF1jqw4kJw1xCr1SqanxJFyfG34fK3W7Ga1qyF12krWS9F15Ar9xGr1IvFWj
	9F4Sya13KanFvF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UmdgZUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqQjxXmesZ5VJpgAAsY

From: Andy Yan <andy.yan@rock-chips.com>


PATCH 1~9 are preparations for rk3576 support
PATCH 10~13 are real support for rk376

I test it with a 1080P/4K HDMI output with modetest and weston
output.

If there are some one want to have a try, I have a tree based on
Linux 6.14-rc1 here[0]

[0]https://github.com/andyshrk/linux/tree/rk3576-vop2-upstream-v14


Changes in v14:
- Rebase on drm-misc-next
- Set maxItems constraint of clocks for rk3588 to 9 as a recently
  merged patch added two optional clocks[1]:
  [1]https://patchwork.freedesktop.org/patch/msgid/20250204-vop2-hdmi0-disp-modes-v3-1-d71c6a196e58@collabora.com
- Link to V13: https://lore.kernel.org/linux-rockchip/20250121103254.2528004-1-andyshrk@163.com/


Changes in v13:
- Add maxItems constraint for clocks
- Remove constraint for interrupts in allOf block, as the current
  maxItems is already 1.
- typo fix
- Explain the function of this property.
- Use maxItems constraint for clocks in allOf block

Changes in v12:
- Only change the description method for existing SoC.
- Split from patch 10/13
- Split from patch 10/13

Changes in v11:
- Remove redundant min/maxItems constraint
- Remove redundant min/maxItems constraint

Changes in v10:
- Move interrupt-names back to top level
- Add constraint of interrupts for all platform
- Add constraint for all grf phandles
- Reorder some properties
- Move interrupt-names back to top level
- Add constraint of interrupts for all platform
- Add constraint for all grf phandles
- Reorder some properties

Changes in v9:
- Drop 'vop-' prefix of interrupt-names.
- Add blank line between DT properties
- Remove list interrupt-names in top level
- Drop 'vop-' prefix of interrupt-names.
- Add blank line between DT properties
- Remove list interrupt-names in top level
- Drop 'vop-' prefix of interrupt-names.

Changes in v8:
- Remove redundant blank line before drm_bus_format_enum_list
- Add a blank line before DRM_ENUM_NAME_FN
- Fix dt_binding_check errors
- ordered by soc name
- Link to the previous version:
  https://lore.kernel.org/linux-rockchip/6pn3qjxotdtpzucpul24yro7ppddezwuizneovqvmgdwyv2j7p@ztg4mqyiqmjf/T/#u
- Fix dt_binding_check errors
- ordered by soc name
- Link to the previous version:
  https://lore.kernel.org/linux-rockchip/6pn3qjxotdtpzucpul24yro7ppddezwuizneovqvmgdwyv2j7p@ztg4mqyiqmjf/T/#u

Changes in v7:
- Fix rk3588 dp+dsi maxclk verification

Changes in v6:
- Add a blank line after hardware version check code
-  More specific explanation about the AXI_BUS_ID register bit of
   cluster window.

Changes in v5:
- Add axi id configuration
- Remove the non-existent CBCR scale register.

Changes in v4:
- Typo fix: selet->select
- describe constraint SOC by SOC, as interrupts of rk3576 is very
  different from others
- Drop Krzysztof's Reviewed-by, as this version changed a lot.
- describe constraint SOC by SOC, as interrupts of rk3576 is very
  different from others
- Drop Krzysztof's Reviewed-by, as this version changed a lot.

Changes in v3:
- Add comments for why we should treat rk3566 with special care.
- Add hardware version check
- Add comments for why we should treat rk3566 with special care.
- ordered by soc name
- Add description for newly added interrupt
- ordered by soc name
- Add description for newly added interrupt
- Share the alpha setup function with rk3568
- recoder the code block by soc

Changes in v2:
- Add platform specific callback
- Introduce vop hardware version
- Add dt bindings
- Add dt bindings
- Add platform specific callback

Andy Yan (12):
  drm/rockchip: vop2: Rename TRANSFORM_OFFSET to TRANSFORM_OFFS
  drm/rockchip: vop2: Add platform specific callback
  drm/rockchip: vop2: Merge vop2_cluster/esmart_init function
  drm/rockchip: vop2: Support for different layer select configuration
    between VPs
  drm/rockchip: vop2: Introduce vop hardware version
  drm/rockchip: vop2: Register the primary plane and overlay plane
    separately
  drm/rockchip: vop2: Set plane possible crtcs by possible vp mask
  drm/rockchip: vop2: Add uv swap for cluster window
  dt-bindings: display: vop2: describe constraint SoC by SoC
  dt-bindings: display: vop2: Add missing rockchip,grf property for
    rk3566/8
  dt-bindings: display: vop2: Add rk3576 support
  drm/rockchip: vop2: Add support for rk3576

Heiko Stuebner (1):
  drm/rockchip: vop2: use devm_regmap_field_alloc for cluster-regs

 .../display/rockchip/rockchip-vop2.yaml       |   99 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c  | 1475 +++-----------
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h  |  277 ++-
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c  | 1798 ++++++++++++++++-
 4 files changed, 2381 insertions(+), 1268 deletions(-)

-- 
2.34.1


