Return-Path: <linux-kernel+bounces-295366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC2B959A22
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3C36B26F6B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3A51B5EC2;
	Wed, 21 Aug 2024 10:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="DPAVs4OC"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9051B530C;
	Wed, 21 Aug 2024 10:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724237996; cv=none; b=fJ1yI4+OUY3qG0Off0f/5XW3e/Ril03JArmXcBD3fUcEyS9iY2sbSxkcJF14+gsb901CMcJv8Vu/sCVcPmYxmgVi17/qiCsfHJEpDaE4NG1akjDG1I8wvopJFdUPCTmpMvGFobkajiE5qbWYxmQeDP7E9mzJfGvqWRyZ7cVU+7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724237996; c=relaxed/simple;
	bh=sdR2FdzL3GEuwsSugw3gtJ3FEQzpbQ2pP0td5fvUOYk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M/iK//HUDqiBgnveQyq1xgDvsr45IQKnB55Zj6MuoR9bG8UEtW6gXxzZI4Cii/uRG7KKRxxrNRRp0Q/LLb4ShD9N6SwiWzSz0SegTv7wL/7VoY0u+i1IBRaHC7PcB5fVCYMKQzM7d2zq8Y9+aNl/Fkcgev1PriWpeKwJ8Vp47Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=DPAVs4OC; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9EDF81483DED;
	Wed, 21 Aug 2024 12:59:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1724237990; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=GQKlVPzitG3/Y0AW44WM1THcHTkHaH0mCBA5mVPTsDU=;
	b=DPAVs4OC32jMj2qSWcPms3XieM3u/BHRr4nRemoURWmwlke5t8FhB/f8Q7sQ52oDfuGZE7
	q29FwYAUQxWSQ7ntVFzevL4DWfZkh0ACw+OZ+PJkKTeRvSXdnevwH/badcjXX8njR+5EMe
	onppQDNL04Da5Wkqdx5qtHG9ig6AtHtpJo6UUrF55ObQl9GFP59eBJ/Vy0Q0za8+a/LKI6
	E+yMk8GdZgc60rKsw6NkBHkjbnUlNCpXdyCtzD1SCHK6Y53mmwhdmmTENjcGvlDmruy2Jd
	PZ9UPqKlVlMViVFjJKhaNfQIT3Eu50MF3Xh40z9nmtr6gkFZRWgbUELFccptIA==
From: Alexander Dahl <ada@thorsis.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Christian Melki <christian.melki@t2data.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v1 00/12] Microchip OTPC driver on SAM9X60 exposing UIDxR as additional nvmem device
Date: Wed, 21 Aug 2024 12:59:31 +0200
Message-Id: <20240821105943.230281-1-ada@thorsis.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hei hei,

on a custom sam9x60 based board we want to access a unique ID of the
SoC.  Microchip sam-ba has a command 'readuniqueid' which returns the
content of the OTPC Product UID x Register in that case.

(On different boards with a SAMA5D2 we use the Serial Number x Register
exposed through the atmel soc driver.  Those registers are not present
in the SAM9X60 series, but only for SAMA5D2/SAMA5D4 AFAIK.)

There is a driver for the OTPC of the SAMA7G5 and after comparing
register layouts it seems that one is almost identical to the one used
by SAM9X60.  Currently that driver has no support for the UIDx
registers, but I suppose it would be the right place to implement it,
because the registers are within the OTPC register address offsets.

The patch series starts with fixups for the current driver.  It then
adds the necessary pieces to DT and driver to work on SAM9X60 in
general.  Later support for enabling the main RC oscillator is added,
which is required on SAM9X60 for the OTPC to work.  The last patch adds
an additional nvmem device for the UIDx registers.

This v1 of the series was _not_ tested on SAMA7G5, because I don't have
such a board for testing.  Actually I don't know if the main_rc_osc
clock is required on SAMA7G5 too, and if yes how to handle that with
regard to the different clock ids.  If someone could test on SAMA7G5
and/or help me sorting out the core clock id things, that would be
highly appreciated.

Also I assume some more devicetree and/or sysfs documentation is
necessary.  If someone could point me what's exactly required, this
would be very helpful for me.  You see I expect at least another version
v2 of the series. ;-)

Maybe some files having that "sama7g5" should be renamed, because that
DT binding is used for more SoCs now and deserves a more generic name?
Thinking of these for example:

- Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
- include/dt-bindings/nvmem/microchip,sama7g5-otpc.h

Are there other SoCs than SAMA7G5 and SAM9X60 using the same OTPC?

Last question: Should the UID be added to the device entropy pool with
add_device_randomness() as done in the SAMA5D2 sfr driver?

I sent an RFC patch on this topic earlier this year, you'll find the
link below as a reference to the discussion.  The patch itself was
trivial and not meant for applying as is anyways, so I decided to not
write a full changelog from RFC to v1.

Last not least, special thanks to Christian Melki on IRC, who wrote and
tested parts of this, and was very kind and helpful in discussing the
topic several times in the past months.

Christian, if you feel there's credit missing, just point me where to
add Co-developed-by and I'll happily do that for v2.

Greets
Alex

(series based on v6.11-rc4)

Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Link: https://lore.kernel.org/all/20240412140802.1571935-2-ada@thorsis.com/

Alexander Dahl (12):
  nvmem: microchip-otpc: Avoid writing a write-only register
  nvmem: microchip-otpc: Fix swapped 'sleep' and 'timeout' parameters
  dt-bindings: nvmem: microchip-otpc: Add compatible for SAM9X60
  nvmem: microchip-otpc: Add SAM9X60 support
  ARM: dts: microchip: sam9x60: Add OTPC node
  ARM: dts: microchip: sam9x60_curiosity: Enable OTP Controller
  nvmem: microchip-otpc: Add missing register definitions
  nvmem: microchip-otpc: Add warnings for bad OTPC conditions on probe
  clk: at91: sam9x60: Allow enabling main_rc_osc through DT
  ARM: dts: microchip: sam9x60: Add clock properties to OTPC
  nvmem: microchip-otpc: Enable main RC oscillator clock
  nvmem: microchip-otpc: Expose UID registers as 2nd nvmem device

 .../nvmem/microchip,sama7g5-otpc.yaml         |  1 +
 .../dts/microchip/at91-sam9x60_curiosity.dts  |  4 +
 arch/arm/boot/dts/microchip/sam9x60.dtsi      | 10 +++
 drivers/clk/at91/sam9x60.c                    |  3 +-
 drivers/nvmem/microchip-otpc.c                | 86 ++++++++++++++++++-
 include/dt-bindings/clock/at91.h              |  1 +
 6 files changed, 100 insertions(+), 5 deletions(-)


base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
-- 
2.39.2


