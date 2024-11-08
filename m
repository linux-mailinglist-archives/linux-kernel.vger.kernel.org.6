Return-Path: <linux-kernel+bounces-401106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBF29C1601
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 06:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91055284A92
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 05:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526A01CEEA3;
	Fri,  8 Nov 2024 05:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="hbHQeot6"
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FFD7489;
	Fri,  8 Nov 2024 05:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731044488; cv=none; b=NccEnsUZib9gEifnkIKoik38L9E+8cEBQMKreriqqcMaP3UUR9wqlY5JJZ7h3/1rZHlj1LDfka2g0ip7EJ3wjLBkW+1Zk4lh8YVC7PvuuqmvVhJEFHRL8BG+n/GcfhcqOIjefRORG+Hkb/Lxb2f/p/HO6mgzVQAfU7/eRfbfHn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731044488; c=relaxed/simple;
	bh=E8e/eAhDzfvSDC0eQVVCO5m+vLCVCSOtwnchdpJ7awk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=QkJwgjJw7mRVea6iSUaa1w2gon2SzH00smg/p+mryuvERQpz5PZo60+/bbRu8BTu7usOHCg3HBDSDFErOAz55HLvfrIAL0unkZPidc09X1xcdfXlgs6BzAZKKAVN2Pk01XwYLb79Ve/GSdFkRvwetAUgB636C4jxGgjU5uY8GkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=hbHQeot6; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1731044488; x=1762580488;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E8e/eAhDzfvSDC0eQVVCO5m+vLCVCSOtwnchdpJ7awk=;
  b=hbHQeot6HiCNfNGeXN4z4gSZ1cVyawhxDywIB5bz4eyHtd71VQcXvyuB
   g3vkvEc33GZbE7/qZcDHweU4qCSD7DGxP8UaHSGmsPxExc8eANpclNx2Z
   gyMSLnWWypwvrEVo8je3dASYHH/jUbAC9i2+9SxTWxRxTT9345jz5l1Qh
   WiS0tR7MTYB9ZG1sCCpxZd+KKik1w0rtUM76xUG2Rmtr8bD4SnoSj5RxR
   oSOe1cHneGYLNtam1SllKnq8M9SUYRpeJmw+AVwZJwfMNerclrd4R+Mzl
   c8gEGHk+tpK4LMxebswO5fJthCDFWGwxqE/q7NtiiZRj7pusMNNeVeZJo
   g==;
X-CSE-ConnectionGUID: Feas3FRDQh6LOzAFBwexJQ==
X-CSE-MsgGUID: /xJyIBPATcORyxgW3MMzXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="179585835"
X-IronPort-AV: E=Sophos;i="6.12,137,1728918000"; 
   d="scan'208";a="179585835"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 14:40:17 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 9875FC3F94;
	Fri,  8 Nov 2024 14:40:14 +0900 (JST)
Received: from oym-om2.fujitsu.com (oym-om2.o.css.fujitsu.com [10.85.58.162])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id CF8DCD5614;
	Fri,  8 Nov 2024 14:40:13 +0900 (JST)
Received: from sm-x86-mem01.ssoft.mng.com (sm-x86-stp01.soft.fujitsu.com [10.124.178.20])
	by oym-om2.fujitsu.com (Postfix) with ESMTP id 8341240045CA1;
	Fri,  8 Nov 2024 14:40:13 +0900 (JST)
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
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yoshihiro Furudera <fj5100bi@fujitsu.com>
Subject: [PATCH 0/2] perf: Fujitsu: Add Uncore MAC/PCI PMU driver
Date: Fri,  8 Nov 2024 05:40:03 +0000
Message-Id: <20241108054006.2550856-1-fj5100bi@fujitsu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00

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

I have a question.
When I run scripts/checkpatch.pl, the following WARNING appears.
> WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> #56: FILE: Documentation/admin-guide/perf/fujitsu_mac_pmu.rst:1:
> +===========================================================================

Some of the files under Documentation/admin-guide/perf have an
SPDX-License-Identifier tag and some don't. Is it necessary to
include it in fujitsu_mac_pmu.rst and fujitsu_pci_pmu.rst and?

Best regards.
Yoshihiro Furudera

Yoshihiro Furudera (2):
  perf: Fujitsu: Add the Uncore MAC PMU driver
  perf: Fujitsu: Add the Uncore PCI PMU driver

 .../admin-guide/perf/fujitsu_mac_pmu.rst      |  20 +
 .../admin-guide/perf/fujitsu_pci_pmu.rst      |  20 +
 arch/arm64/configs/defconfig                  |   2 +
 drivers/perf/Kconfig                          |  18 +
 drivers/perf/Makefile                         |   2 +
 drivers/perf/fujitsu_mac_pmu.c                | 633 ++++++++++++++++++
 drivers/perf/fujitsu_pci_pmu.c                | 613 +++++++++++++++++
 include/linux/cpuhotplug.h                    |   2 +
 8 files changed, 1310 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/fujitsu_mac_pmu.rst
 create mode 100644 Documentation/admin-guide/perf/fujitsu_pci_pmu.rst
 create mode 100644 drivers/perf/fujitsu_mac_pmu.c
 create mode 100644 drivers/perf/fujitsu_pci_pmu.c

-- 
2.34.1


