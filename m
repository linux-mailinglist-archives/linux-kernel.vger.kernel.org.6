Return-Path: <linux-kernel+bounces-191842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B212F8D1505
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A05C1F22F0A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 07:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AC47175B;
	Tue, 28 May 2024 07:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Ay76F94U";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="rPDldIlj"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475BC6F08E;
	Tue, 28 May 2024 07:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716880318; cv=none; b=uk8x1sRofBdFb8pYd8HYtaKDH+0eVs7ZC0MeSNseadvQ1tiG+PkvCG9ss8aVihhsI13Ha75qwsO+D9pHDpevQ+628z9jNoIMdqm1y7yohKrMhg3LNz+f6Uheo12a0Lo+PqgKwhsy1G1MXpEI6lwJiAHe8+oSuedot1rfrNzXVsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716880318; c=relaxed/simple;
	bh=66c8rZoEGRYWAGe4zBPQX3RpN2p7fGgtuP9pQV+d/dU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZiC+YmAzLqoOb6qzIehvOsBils2PYg5ur4romPRgaExKEZwMjk6ccnpyOs9Y1rX5rhnyzFCC6VZyuAX/1desgqMaS3pA569W5FjpcREd76VYXWmVaeXLn5AKZ3wkjZlOfCvOLnL2pkHp+uKNdqyKAwlLjOFFXOGVgSTLzUOCw9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Ay76F94U; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=rPDldIlj reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1716880313; x=1748416313;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z8RWxiCQUoZJkRZBSEWY0S1iwMUU202fnOahoQZPJ5o=;
  b=Ay76F94UToUSa6EdqQP8iSjT9WZOJAQ4ZVjc9oIpCKOhmXUVCIQOvSIl
   UJztd4c2RhdaXSMVLViVspFBSw3V2mdulEmWAvXB9fxvuyDl+T9WTPkSk
   xiX1Ugi2jU5/11pslXqaNWRsKGs3D7OGWXA+1flT02KV926JP4qOTEtlQ
   gvgXtGcfeTWKEj2QyXDl4Pwb5w23iXVhDMSXLznFLV2rOWyuDNZmndVbC
   swOob/7ukPbo0di8in8SDdsLiZ1W1lLmbCrAcXHHyBVGmEcAACBAOCL9w
   idep2WgUuNyZAluH8hC85dYR64Rv8LE6ljoLvW0jhQAT8oewiz1rW/34a
   g==;
X-CSE-ConnectionGUID: 2Ya9NS8sQRaFDAt508x5dw==
X-CSE-MsgGUID: eye2pCG/QBqvyT8F7MrSiw==
X-IronPort-AV: E=Sophos;i="6.08,194,1712613600"; 
   d="scan'208";a="37094731"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 28 May 2024 09:11:50 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 92FF11641FA;
	Tue, 28 May 2024 09:11:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1716880306; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=z8RWxiCQUoZJkRZBSEWY0S1iwMUU202fnOahoQZPJ5o=;
	b=rPDldIljSZd/E9tK6xmPuwkVx2zytaWcgTjQNlRkVQIdUJOfSqn48hYxvdWQCMXGzOyh4X
	JOtHQ8rkTmJ+/O6Q8MsTCTsNCaNn7jeKX1H+TWG5TpSb/LYI4+sDbvCz6aui4TTad7Qgix
	6lakCgAoCe6VsOCLSpJoqJxj/B+Elh6Ds8aUd2444z0QR44O142fl8qBFluwDUyUa7OgHf
	Lq0qsgn7tuI3jl7BfHwOMtNvK1a9+apC3mfBJ2NiHV7Wcbxoeex9jU9gOgE/omCAXSRduL
	a3s26GA+Qex89saDnpnAkqDWZYYuYW9knFGAZA653J7H2/kR8QZbTj/0sBG6NA==
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
Subject: [PATCH v5 0/2] fsl,irqsteer: power-domain support
Date: Tue, 28 May 2024 09:11:39 +0200
Message-Id: <20240528071141.92003-1-alexander.stein@ew.tq-group.com>
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
Thanks for the previous feedback.

Best regards,
Alexander

Changes in v5:
* Fixed indentation
* Added Conor's R-b

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


