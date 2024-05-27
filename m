Return-Path: <linux-kernel+bounces-190220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6A98CFB83
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6661B2819AA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534345FB9A;
	Mon, 27 May 2024 08:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="AMOkV0bP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="jzpEgjWp"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46585427E;
	Mon, 27 May 2024 08:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716798855; cv=none; b=ohuZB/1u2rDopIKt/YTwzRGVGTvVZdYnIKDQotnGOlohEFspQe97aW2a4yYhVWbC8+jLxhoylvsVV86I7A/BrM6xZD2Y7wSo5UjJyfB4H/UdGp6VpB9t6zUKcGDUkZ+FgKSxv1U5o3JF4UcazIqFo7K8OehQZ+XzU4RcBb3rAf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716798855; c=relaxed/simple;
	bh=BZ3V1qmHswOU+7K1skRlgy4yU7Xb9k2GHVKt1u0Raxs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rDQxhkehFvNoZ4S+rOGyn5ed9pWC0aa5Xy8AQzWUUCweEsLronz+hlGz6erhrz8K3qIY4G6WZguFeGdsqItWIvKh8vSOpAGCoKGfKaXwPc7QQ/hfYtVMwc5mzixsGxS1KQCRQU43MSwz2Jw1B6xIFQw1gIM9KN8VQqM/3PiBY3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=AMOkV0bP; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=jzpEgjWp reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1716798852; x=1748334852;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V92xDtgkUQ0pD6dkr9ukD+hKZ/qlVmSec90Zmqp7SAo=;
  b=AMOkV0bPOLyXI3rLWpLmnf0P3KQLUHzfKN2aSAPwL4A0dUfZnuh0IRVJ
   XdtMhVnjelKHUlNxzXzKiXRgdEG9xedxmn7wYtsmS8ZNtZ/seaay7VpjT
   NRD/6U1BcvT5MFfrz6SLzyFZQWO/j+lwk32IvXSPgPn08pJ6UrhKIKkfx
   xREASsD5X/HJ8+liU/PyMXSbeHBLGCBBlyVsESGwPf5M0cuDqsjBIbjIh
   CpqbQLtQgMADAzs0c+Gs3cc5QUh8PAGXu6hvyyUlKeyy2ErYolzDG9DqA
   cIGXumPt0pMLht484IatJSdZzg1cRyQ9MOVfj6LUkSV+d7t4e3chJ8V++
   A==;
X-CSE-ConnectionGUID: 0Jo1+GvfQB+VfcZM0thuVg==
X-CSE-MsgGUID: vhhDTaamTpGj4UlxIENEGw==
X-IronPort-AV: E=Sophos;i="6.08,192,1712613600"; 
   d="scan'208";a="37075680"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 27 May 2024 10:34:03 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BA1581637E4;
	Mon, 27 May 2024 10:33:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1716798839; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=V92xDtgkUQ0pD6dkr9ukD+hKZ/qlVmSec90Zmqp7SAo=;
	b=jzpEgjWpeL6VoSCuKEiULIFMC6sZSMJYocFXrANDMb+tXhHOjyrQtGmOYp1eHzonlSTv/X
	i4uaMu/L2rpfNS6yoHqNg3VZgDLcpHkohhgVjcf8ygJHXS+W3CIt0y3ArEtCW2rPK+Fvd6
	0mqi2LfOz5ssagi/mbf3xu0gSCaKyYcQ5zwklf3hzYFmtNAeGC0NFW2M+wPL3ji5t3inNY
	rGyGVfsCXSW7dCifNlW+9Az49Z4WP9fKCRi7id38s727qCt5S9wB3UvfUzX+ENarKGxMbo
	ZpopPr7A/3pwt82ult4h5s2UJzPhXqL9JmmBvEbJzAykpM6sBFbAm89lk0LIvg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/2] fsl,irqsteer: power-domain support
Date: Mon, 27 May 2024 10:34:00 +0200
Message-Id: <20240527083402.30895-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

this is a new spin on the irqsteer bindings adding power-dmain support.
Thanks for the previous feedback. This v4 adds imx8mp specific compatible
to support power-domain.

Best regards,
Alexander

Changes in v4:
* Added imx8mp-specific compatible
* Restrict power-domains on non-imx8mp or non-imx8qxp SoCs
* Added patch for imx8mp.dtsi adjusting compatible

Alexander Stein (2):
  dt-bindings: interrupt-controller: fsl,irqsteer: Add imx8mp/imx8qxp
    support
  arm64: dts: imx8mp: Add imx8mp-specific irqsteer compatible

 .../interrupt-controller/fsl,irqsteer.yaml    | 23 ++++++++++++++++++-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     |  2 +-
 2 files changed, 23 insertions(+), 2 deletions(-)

-- 
2.34.1


