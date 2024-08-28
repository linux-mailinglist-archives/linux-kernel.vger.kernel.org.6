Return-Path: <linux-kernel+bounces-304534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D2E962170
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF5B71F21B7E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DBF15AD9C;
	Wed, 28 Aug 2024 07:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="LKyQuBJt"
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91925158DA3
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 07:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724830752; cv=none; b=W1pJJ/Ja+SQtJb1FVqTHT4wbuGJt1lNtBYxlnDTorM0PbKf2S5f/FxJMnpcWli6cK12fMxI0Pmk0ZKIUUCD1bCN6bihxjxukX87oU4P4tHYmUuQW0O7tDOrdrNqp6gBMA4xj/TaCyU37fxH/YBXgUt7utT0pA6QyJ4TKaIojzCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724830752; c=relaxed/simple;
	bh=y+owdwVbXlTzggyxcgYNP16hy5wrAnjp/WCCwwr8ec4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YelgAZpMx+MvIuQe+w8k78cK7tWaF5dcHMRD5W+T8mUDkm0g/Jo/WPffwcOXwb4tTR+FoWq18Rq7VUradPRdS0yP5kQqRqDbBlNvSCFSCEm0ip1EbBjA1ZGgsA+5ApnonVlPt3xzdOEi2yAMLTFkOfQxFKAEMYSBBBnRn0Wja5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=LKyQuBJt; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202408280739020736faa5ecae6fc86c
        for <linux-kernel@vger.kernel.org>;
        Wed, 28 Aug 2024 09:39:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=XT7lCQkCpLT8Y4iHhvJLx1vsvXwakJgWSOggfCbi0Qg=;
 b=LKyQuBJtarYLeXP716zeLcsTB1PAcvd9C+JQBcxQrRkdtH8ttzzg9KkxhuNm1oL/f4QB9l
 GVEDEV7JuoL5AQLu3Cmj5Nl3iDsB4Y9WkEDSWYccsvtvcpxnRAHwIijjRHw2uZf0LdczSiKv
 j58n6rzv6ETo22tslhojghSfolXXDWLMs5izXhOWvQK8KTKLNIOcE6Hcq872+eVO13MqtElW
 lZ+hfhNJXTE7p31tmjcYPGlJkjwPzDQDaQxGvuAqsFtzBqydqPUwt1RmyaV4pnQoX0l6cW39
 KaFNj7uaTPlcwnpwvwBz8esA/G0CFv9D9JJJ3tskqzvav4c27uNUUTfQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bao Cheng Su <baocheng.su@siemens.com>,
	Hua Qian Li <huaqian.li@siemens.com>
Subject: [PATCH v2 0/2] arm64: dts: iot2050: Fix R5 lock-step settings, add overlays
Date: Wed, 28 Aug 2024 09:38:59 +0200
Message-ID: <cover.1724830741.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

Changes in v2:
 - build dtb with applied overlays

Trying to get our backlog closer to zero. See patches for details.

Jan

Jan Kiszka (1):
  arm64: dts: ti: iot2050: Add overlays for M.2 used by firmware

Li Hua Qian (1):
  arm64: dts: ti: iot2050: Disable lock-step for all iot2050 boards

 arch/arm64/boot/dts/ti/Makefile               |  6 +++
 .../dts/ti/k3-am65-iot2050-common-pg2.dtsi    |  5 --
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   |  5 ++
 .../boot/dts/ti/k3-am6528-iot2050-basic.dts   |  5 --
 ...48-iot2050-advanced-m2-bkey-ekey-pcie.dtso | 27 +++++++++++
 ...-am6548-iot2050-advanced-m2-bkey-usb3.dtso | 47 +++++++++++++++++++
 6 files changed, 85 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2-bkey-usb3.dtso

-- 
2.43.0


