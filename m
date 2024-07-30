Return-Path: <linux-kernel+bounces-267848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6262D941731
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9152876CF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B154E1A302D;
	Tue, 30 Jul 2024 16:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZAOx+USq"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DAB18B471;
	Tue, 30 Jul 2024 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355592; cv=none; b=Dlkui40ykeJ1ztNFv1yQgFzA/mE/xz8nQSoMVacDVPT+jUGlPkcl2ZutXr33ZS8m6I4pkS5v3YLT51cF0b9wt8mNRbreldOlLYkCEdVexpnQcolrbZkUUDSqP7K0K6GIwtpFU8kE6GpXiv3lpd72X78NdK2IIUWfCFc+36VVVXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355592; c=relaxed/simple;
	bh=3rbejkaedxT29XraRDTu4kmwtIuQe1JLN2aB8gV80O8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FQVehv8xUpnq1W00w/vMtW3gaN//ngi3tza7UY4435pTyfX3el/NDG2FlTVDGO5m+za6cHNWCQiADe8vdHKsks9CTnZhDxSgFoHd/FCWOxTt7j9akgl5qZuVLaV2iP6fDXu5gRKKzTSoY3K37bZU+NUiilkj1JRy/C00ooAH+88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZAOx+USq; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8640EC0002;
	Tue, 30 Jul 2024 16:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722355586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E7nyC9xIhY3z4m+xbftKrt+sa3nij1VWrsRiYkc5o3Q=;
	b=ZAOx+USq03FDrxYARzffArtzui1NOkDqbovHZY9F6bPz3E4ipI+YOPjKx/d+7JliWfPYcb
	xKjvbZwFqO8uWKXd0HCuPwJuTvw12sbhBHNHWkTwmh1APzgSwWKr8+WhQKeajrRxLGK0DS
	7kqACsNJL5q7k0Oj7Ntmcz6thdb7I1Bk8Mj+VjK8qEcDQaCd2l0XX8bT0QZHLvISxtxIr5
	VYfNkKlGan0e3ylof6X5/J0fHgGenU2BlV2PeAGnB/DIx1IVNr459um5RzlBsiRm1AZjjN
	qRNMbFw97r/fCzUNKXO6Y7lASLGglWjzpSG9PUsPgsvGiSVvrppb+MJbXLo8vg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH RESEND v2 0/2] Add Mobileye EyeQ reset support
Date: Tue, 30 Jul 2024 18:06:21 +0200
Message-Id: <20240730-mbly-reset-v2-0-00b870a6a2ff@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: theo.lebrun@bootlin.com

This is a new iteration on the Mobileye system-controller series. It
used to be sent as a single series [0], but has been split in the
previous revision (see [1], [2], [3], [4]) to faciliate merging.

This series adds a platform driver handling SoC controllers resets. It
is an auxiliary driver being instantiated by the platform clk driver.

We support EyeQ5, EyeQ6L and EyeQ6H SoCs. The last one is special in
that there are seven instances of this system-controller. Three of
those (west, east, acc) contain a reset section.

Related series are targeted at clk [5], pinctrl [6] and MIPS [4]. The
first two are receiving a second version. The last one has no change
and stays at its V1.

Have a nice day,
Théo

[0]: https://lore.kernel.org/lkml/20240620-mbly-olb-v3-0-5f29f8ca289c@bootlin.com/

[1]: https://lore.kernel.org/lkml/20240628-mbly-clk-v1-0-edb1e29ea4c1@bootlin.com/
[2]: https://lore.kernel.org/lkml/20240628-mbly-reset-v1-0-2a8294fd4392@bootlin.com/
[3]: https://lore.kernel.org/lkml/20240628-mbly-pinctrl-v1-0-c878192d6b0a@bootlin.com/
[4]: https://lore.kernel.org/lkml/20240628-mbly-mips-v1-0-f53f5e4c422b@bootlin.com/

[5]: https://lore.kernel.org/lkml/20240703-mbly-clk-v2-0-fe8c6199a579@bootlin.com/
[6]: https://lore.kernel.org/lkml/20240703-mbly-pinctrl-v2-0-eab5f69f1b01@bootlin.com/

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Changes in v2:
- Kconfig: replace "depends on AUXILIARY_BUS" by "select AUXILIARY_BUS".
- driver:
  - turn rcdev_to_priv() into a static function to avoid a gnarly
    container_of(rcdev, ..., rcdev) bug and use the typesystem.
  - eqr_busy_wait_locked():
    - assign values to base, sleep_us and timeout_us in the variable
      declaration block rather than later down the function.
    - fix indent of the conditional in the read_poll_timeout() call.
    - rename val0 to rst_status and val1 to clk_status.
  - eqr_status(): reorder variable declarations for offset and domain to
    be next to each other.
  - add comment expanding on usage of mutexes in the device private data.
  - add comments mentioning that both RST_REQUEST and CLK_REQUEST
    registers must be kept in sync, in both assert and deassert code.
- Link to v1: see [2]

Changes since OLB v3 [0]:
 - MAINTAINERS: Move changes into a separate commit to avoid merge
   conflicts. This commit is in the MIPS series [3].
 - dt-bindings: Take Reviewed-by: Rob Herring.
 - Kconfig: do not depend on COMMON_CLK_EYEQ. This symbol is not defined
   in this series, it is defined in the clk series [1].
 - Kconfig: do depend on AUXILIARY_BUS.
 - Kconfig: remove outdated "depends on MFD_SYSCON".
 - driver: remove "#include <linux/platform_device.h>".
 - driver: cast platdata to (void _iomem *) explicitely.

---
Théo Lebrun (2):
      Revert "dt-bindings: reset: mobileye,eyeq5-reset: add bindings"
      reset: eyeq: add platform driver

 .../bindings/reset/mobileye,eyeq5-reset.yaml       |  43 --
 drivers/reset/Kconfig                              |  13 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-eyeq.c                         | 570 +++++++++++++++++++++
 4 files changed, 584 insertions(+), 43 deletions(-)
---
base-commit: f2661062f16b2de5d7b6a5c42a9a5c96326b8454
change-id: 20240628-mbly-reset-ac6c66d3bf95

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


