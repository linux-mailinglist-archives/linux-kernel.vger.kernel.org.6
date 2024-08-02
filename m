Return-Path: <linux-kernel+bounces-273164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DA6946522
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A59F91C21283
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607C1127E0D;
	Fri,  2 Aug 2024 21:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="5AGDxnId"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A1353389;
	Fri,  2 Aug 2024 21:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722634793; cv=none; b=gLpIZgrc2jQATguR6DC/XystgXuEslJnGVyJvoMq3ufHlsPctDmVHv1NgTFyuI/tIBDaJNOSq97rAGsoeSr82FKplBm6QPDo9NLNN60qiv4ekX3s+oThpPcvqMkLrNzjSsNf5WXuxWhI5Ev+ndSqTG3NG9UCvM8fsZYYCTfmx8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722634793; c=relaxed/simple;
	bh=3ZPQZra9eBgn9X+DOhPsgFW4rgc5sg704GwOCwXXYRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y+jzTF61aBRo7IblLTIA19eaE+R+gCB6nMz7VGeKZwNg5ej420ZSVnSOz1k+tmnEHf11o4Oza3cTFcz7BySIA1PkQtcM15/YdHXRAvJlQtO1EXjaDWV+DI3a7JUEANnRcD5ksyDUKt9PccQxYBcMmWTsUgGrfLKZDa4GGccCcfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=5AGDxnId; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722634790;
	bh=3ZPQZra9eBgn9X+DOhPsgFW4rgc5sg704GwOCwXXYRk=;
	h=From:To:Cc:Subject:Date:From;
	b=5AGDxnIdVhv9ZeigLksbEeUZysb+kQpZcf2GgCB9wQybwtRYRzwgnczeQ7a5EXn+z
	 89RJMgjFnlEwTACUQ0HFrm3XRNxKhWgxfY7OauJoy57a6qS3IfqjAn029VGumpFjHY
	 tN0ehYZLthxJ+RLmBkwkDAl0PINARx30RCHkO70Vw9/jVbSLI8uN8Z/Zu0m3IaxVml
	 AFKWPhSX/Q+UWOQ0zLJ7p/vyMVC8b0Q0DoT/XGiRtQxbVbh8I5U55/pclFBKo5i0kE
	 DN010XYZjNodBlikCT/JRlKl2rgDrVh3ECEdZRpQ+p/B7pVaIxm/sJs8kdWCqBVaTB
	 h34PBmSBVicuQ==
Received: from trenzalore.hitronhub.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id ED5913782215;
	Fri,  2 Aug 2024 21:39:47 +0000 (UTC)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v2 0/3] Add CRU support for rk3576 SoC
Date: Fri,  2 Aug 2024 17:35:38 -0400
Message-ID: <20240802214053.433493-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for clocks and resets on the rk3576.
Patches from downstream have been squashed and rebased.

The resets have been renumbered without gaps and their actual register/bit
information is set in rst-rk3576.c as it has been done for rk3588.

Changes since v1:
- Remove reset defines that are probably out of the main core
- Separate resets and clocks bindings
- Renumber the resets without gaps

Detlev.

Detlev Casanova (1):
  dt-bindings: clock: add rk3576 cru bindings

Elaine Zhang (2):
  clk: rockchip: Add dt-binding header for rk3576
  clk: rockchip: Add clock controller for the RK3576

 .../bindings/clock/rockchip,rk3576-cru.yaml   |   73 +
 drivers/clk/rockchip/Kconfig                  |    7 +
 drivers/clk/rockchip/Makefile                 |    1 +
 drivers/clk/rockchip/clk-rk3576.c             | 1819 +++++++++++++++++
 drivers/clk/rockchip/clk.h                    |   53 +
 drivers/clk/rockchip/rst-rk3576.c             |  555 +++++
 .../dt-bindings/clock/rockchip,rk3576-cru.h   |  589 ++++++
 .../dt-bindings/reset/rockchip,rk3576-cru.h   |  484 +++++
 8 files changed, 3581 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3576-cru.yaml
 create mode 100644 drivers/clk/rockchip/clk-rk3576.c
 create mode 100644 drivers/clk/rockchip/rst-rk3576.c
 create mode 100644 include/dt-bindings/clock/rockchip,rk3576-cru.h
 create mode 100644 include/dt-bindings/reset/rockchip,rk3576-cru.h

-- 
2.46.0


