Return-Path: <linux-kernel+bounces-417806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA529D5949
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 07:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABD2AB20E40
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 06:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FEA15E5CA;
	Fri, 22 Nov 2024 06:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="frqlprzA"
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64907230982;
	Fri, 22 Nov 2024 06:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732256357; cv=none; b=KimKwQ3jB0J2XEcqpOtwJV3GslqpSXzw6aVkGPlfobl4PQKMqjq78U5hoLRBGwHpxjXt2cqWPyUYM0iCcvp+2Lg5UgrHrKULxu4l2byt4rD9XGz+MqFny2v9T0jUB4A7jXQFq40cSfl7EopqXM5XCJFrw8qjGynurevH9MV5c/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732256357; c=relaxed/simple;
	bh=OjbRzPjMQf/A1XqDZL65j6jaq+tqAam7giUnBrT0mVs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=ZyLjw7JXCq7ah1vxTe2vh41CwGIdAOjCfWtAyrc6PgSSSNh7I8r4c1/z5PRZIeOzUn+0/7uziI4Wc+S/jqQ5iwaijiJTDtC/bBJ70WjAmQ7zKvJvV9AYOvfvs74yDvKUZSVh4HxkVNdYhOk4SIfcI1bDv4NZUioiM3zswkS3n74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=frqlprzA; arc=none smtp.client-ip=139.138.36.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1732256355; x=1763792355;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OjbRzPjMQf/A1XqDZL65j6jaq+tqAam7giUnBrT0mVs=;
  b=frqlprzAIT/2JQbNrO34GnROgysa+LVlq8p1VKbPKfvHBKLvhWseUs20
   VnAWglFgk0iMcKNdf/2a+bPyFyqn+dMbxtAVhRxQo1oAs+d2v/WVdJxQi
   gyuulR/XdpkSP7w0nJ5TJn5NQuylPvGIoLgPxX2KTS+BDE1CTsOCov25r
   yL9c+MxQR8Kj9Z/4ETzFjlpbwooBBRGvLDMDG7BdQApH7giNJK81+Pd0M
   Cjw3XAOpvwax1jim4yaXJBDwWrvp9RaFTojqo9YWOCd4XDYc4W4/s+WMo
   uTFc8GynUQtLH0GlkL/66ah8d+DKfqxRtglCzoQcv9zQv/or8I71mWq4j
   Q==;
X-CSE-ConnectionGUID: khNAvbrlSp6OAs0Ggha7uQ==
X-CSE-MsgGUID: 8GS6gyqqSlyjo1BJsJdB/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="168638894"
X-IronPort-AV: E=Sophos;i="6.12,174,1728918000"; 
   d="scan'208";a="168638894"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 15:18:03 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id AF3FDD5013;
	Fri, 22 Nov 2024 15:18:00 +0900 (JST)
Received: from oym-om1.fujitsu.com (oym-om1.o.css.fujitsu.com [10.85.58.161])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 482FA28EC1;
	Fri, 22 Nov 2024 15:18:00 +0900 (JST)
Received: from sm-x86-mem01.ssoft.mng.com (sm-x86-stp01.soft.fujitsu.com [10.124.178.20])
	by oym-om1.fujitsu.com (Postfix) with ESMTP id DF8124005C83A;
	Fri, 22 Nov 2024 15:17:59 +0900 (JST)
From: Yoshihiro Furudera <fj5100bi@fujitsu.com>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yoshihiro Furudera <fj5100bi@fujitsu.com>
Subject: [PATCH v2 0/2] perf: Fujitsu: Add Uncore MAC/PCI PMU driver
Date: Fri, 22 Nov 2024 06:17:51 +0000
Message-Id: <20241122061753.2598688-1-fj5100bi@fujitsu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds two new dynamic PMUs to the Perf Events framework to program
and control the Uncore MAC/PCI PMUs in Fujitsu chips.

These drivers were created with reference to drivers/perf/qcom_l3_pmu.c.

These drivers export formatting and event information to sysfs so they can
be used by the perf user space tools with the syntaxes:

perf stat -e mac_iod0_mac0_ch0/ea-mac/ ls
perf stat -e mac_iod0_mac0_ch0/event=0x80/ ls

perf stat -e pci_iod0_pci0/ea-pci/ ls
perf stat -e pci_iod0_pci0/event=0x80/ ls

FUJITSU-MONAKA Specification URL:
https://github.com/fujitsu/FUJITSU-MONAKA

Changes in v2:
- Remove changes to arch/arm64/configs/defconfig
  (will post patch separately) (Krzysztof Kozlowski)
- Add document file name to Documentation/admin-guide/perf/index.rst
  (Jonathan Cameron)
- Modify files according to the suggestions (Jonathan Cameron)
- Link to v1: https://lore.kernel.org/all/20241108054006.2550856-1-fj5100bi@fujitsu.com/

Yoshihiro Furudera (2):
  perf: Fujitsu: Add the Uncore MAC PMU driver
  perf: Fujitsu: Add the Uncore PCI PMU driver

 .../admin-guide/perf/fujitsu_mac_pmu.rst      |  75 +++
 .../admin-guide/perf/fujitsu_pci_pmu.rst      |  50 ++
 Documentation/admin-guide/perf/index.rst      |   2 +
 drivers/perf/Kconfig                          |  18 +
 drivers/perf/Makefile                         |   2 +
 drivers/perf/fujitsu_mac_pmu.c                | 570 ++++++++++++++++++
 drivers/perf/fujitsu_pci_pmu.c                | 550 +++++++++++++++++
 include/linux/cpuhotplug.h                    |   2 +
 8 files changed, 1269 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/fujitsu_mac_pmu.rst
 create mode 100644 Documentation/admin-guide/perf/fujitsu_pci_pmu.rst
 create mode 100644 drivers/perf/fujitsu_mac_pmu.c
 create mode 100644 drivers/perf/fujitsu_pci_pmu.c

-- 
2.34.1


