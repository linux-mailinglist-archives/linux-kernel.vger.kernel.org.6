Return-Path: <linux-kernel+bounces-511039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFF0A324FC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E34C916A38D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DE520DD5C;
	Wed, 12 Feb 2025 11:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TYFUWEK1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD66C20B1F7;
	Wed, 12 Feb 2025 11:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359756; cv=none; b=iLghZCiLDrMxsYvt9/uF3cykaZgWp4lnsn7+9E3enK1bqrrOJieHmUT+bpp+rwMoWYRyWzy0cH16t8O0rneEjxbnRSHHwSxchCROT2bcq9eZtRWxwSzGDYUPzlu/PJ1W0EVhTuJWQYNfWZVsXanfkwUMNvL7696/RIR7LFOB6ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359756; c=relaxed/simple;
	bh=OGDeLMpT+fqb5J1J1pcI9yoVGmhCRmyuCU214VJYRsA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sGj6Gm9l58WHoV3UGDRmrQI7ILdvnSm/ecOpqZGc9s2lRA2rYDNU64cahEM1BIWunE0AYnleZ0w3wfYX8yIsPKu/aFkC4jS0fDHZepsoZSr5HwQiv2yZVl0vmu+N7S1sDT9bZpnxvyzUoISOI+VHBSnB7QaNJUMPdwvAEbbIsHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TYFUWEK1; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739359752; x=1770895752;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OGDeLMpT+fqb5J1J1pcI9yoVGmhCRmyuCU214VJYRsA=;
  b=TYFUWEK1nCy4c5ZltoEvpQytpRgUTExzs33eguwC9fiGXpmntqUDhkUO
   3C2XdUMiOP8uBKfHmdkMWvVlAgdWNwwnstctFZX7jXQ2wLgR8xPiL12Tg
   YnMrX2cIFgv8rQUlVmZ4Qek1hpJCyHv0wS1rXzVBUgvUgdp22ByiliEhx
   OhgjYRJj9NuX1Jx4CczB5NFKR6W6TcHo5f0lDqgymMvRZ6kQYsehMh9ql
   P333rrxbwhG9bW1/ggk+vktjO4AA7pIh+jLIprmdtiOnbFjDhu6OXntUX
   iH5FxtpeSF+MLu/v6cumhDKmdaEGKjxxzis0h0U8olbjJ2ETWUqYIaW2I
   g==;
X-CSE-ConnectionGUID: TevCEXZWQHG7Id17J0jpQA==
X-CSE-MsgGUID: QBg0jkuwRB6v1Rk9k0MBZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39895736"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="39895736"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 03:29:11 -0800
X-CSE-ConnectionGUID: pewzGhOxQimaQeUOAid23A==
X-CSE-MsgGUID: JEyRhtHDSmGwRptfnxDjWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112648499"
Received: from pg15swiplab1181.png.altera.com ([10.244.232.167])
  by orviesa010.jf.intel.com with ESMTP; 12 Feb 2025 03:29:08 -0800
From: niravkumar.l.rabara@intel.com
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
	nirav.rabara@altera.com,
	devicetree@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] add clock-names property to nand node 
Date: Wed, 12 Feb 2025 19:25:33 +0800
Message-Id: <20250212112535.2674256-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

1) Document the required clock-names property because the driver
   requests the clock by name and not the index.
2) Add required clock-names property to the nand node in device tree.

Changes in v3:
  * Include missing Fixes tag.

Changes in v2:
  * Document clock-names property for Cadence NAND controller.

link to v1:
- https://lore.kernel.org/all/20250107084955.2750154-1-niravkumar.l.rabara@intel.com/

Niravkumar L Rabara (2):
  dt-bindings: mtd: cadence: document required clock-names
  arm64: dts: socfpga: agilex5: add clock-names property to nand node

 Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml | 8 +++++++-
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi         | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.25.1


