Return-Path: <linux-kernel+bounces-271856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6029453F6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 23:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA54BB2335E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 21:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377C414C5A7;
	Thu,  1 Aug 2024 21:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eFtbsrQ0"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50DC14A4E5;
	Thu,  1 Aug 2024 21:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722546333; cv=none; b=HPLeBP8dspR2TDRrzdsXWBJimzDesvo0D8yJS7UnyObWXz/lTYLNVyVz5/WBPVDO4QEerC0zGMwOLYtlcNon+VUY2M+5UEkKVH++Kg45ssjXp9xBlYKd9FQcXSbZROgLU3xVRRzdovA/D4bx7nRPFFfxIF3hrki13u4cc7G0UZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722546333; c=relaxed/simple;
	bh=kWwbfCM6lTZ5CbyPJbIO6TEkPojXYJ7GmBNuSj3CGA8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i8YDVflmGZAAKynBlkAHfs04Sanl1Le0ZlyDl0DcLlDG1cq8d5EMdfaTOCFkcVAeLIhnPUeMQAQ7cCLZduTfaYE5qtin7zCjaOrPu/bE4rPjuVlJTA6QHPeUnLBH/UmEaP/wW1nXX4+R9ae+ztkTV0Y4ut4YRIhQEqTL1FjD64M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eFtbsrQ0; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 471L5MPx103287;
	Thu, 1 Aug 2024 16:05:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722546322;
	bh=saERnUU7fl/HCuGa33oXQDn5l/T7h/ENHqwLGSncQY8=;
	h=From:To:CC:Subject:Date;
	b=eFtbsrQ0iKjGxjcMHT9pFv0eONTAIPt+7tzTzMzVepwZTAbpfgVw7rt5MhzVLUZbH
	 9iYtKYk6oTDSdJPWObhCvSthcUaUcJVQrxzbQDAVJGaf+qdcHDL7jgtp5ryxQlPHQl
	 k11joOkcTzleL+PTpsDRtyB4NWG059iJU4Q6lmC8=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 471L5M3d104990
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Aug 2024 16:05:22 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Aug 2024 16:05:21 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Aug 2024 16:05:21 -0500
Received: from localhost (uda0499903.dhcp.ti.com [128.247.81.191])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 471L5Law059850;
	Thu, 1 Aug 2024 16:05:21 -0500
From: Jared McArthur <j-mcarthur@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Jared
 McArthur <j-mcarthur@ti.com>
Subject: [PATCH v2 0/3] arm64: dts: ti: k3-am62p/j722s: Fix gpio-ranges
Date: Thu, 1 Aug 2024 16:04:11 -0500
Message-ID: <20240801210414.715306-1-j-mcarthur@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

Fixes issues within the am62p and j722s gpio-ranges. Adds the missing
holes within the ranges as well as the the missing gpio-ranges
property within the mcu_gpio0 node of the am62p.

v2 changes: Removes the duplicate ti,ngpio property from the mcu_gpio0
node of the k3-am62p-j722s-common-mcu.dtsi.

Tested with kernel_patch_verify
(https://github.com/nmenon/kernel_patch_verify.git) off of the
next-20240730 tag. Original series reported the following:

 0001-arm64-dts-ti-k3-am62p-Add-gpio-ranges-for-mcu_gpio0.patch
 Tests: Failed
	Fail tests:  btest_kbuild dtest_build_dtb 
	dtest_build_dtb_to_dts dtest_dtbs_check
	Pass tests:  defconfig ftest_check_kdoc ftest_check_includes
	ftest_check_headerdeps btest_basic btest_sparse btest_cocci
	btest_smatch ptest_am ptest_check ytest_dt_binding_check
	ytest_dtbs_check

 0002-arm64-dts-ti-k3-am62p-Fix-gpio-range-for-main_pmx0.patch
 Tests: Failed
	Fail tests:  btest_kbuild
	Pass tests:  defconfig ftest_check_kdoc ftest_check_includes
	ftest_check_headerdeps btest_basic btest_sparse btest_cocci
	btest_smatch ptest_am ptest_check ytest_dt_binding_check
	ytest_dtbs_check dtest_build_dtb dtest_build_dtb_to_dts
	dtest_dtbs_check

 0003-arm64-dts-ti-k3-j722s-Fix-gpio-range-for-main_pmx0.patch
 Tests: Failed
	Fail tests:  dtest_dtbs_check
	Pass tests:  defconfig btest_kbuild ftest_check_kdoc
	ftest_check_includes ftest_check_headerdeps btest_basic
	btest_sparse btest_cocci btest_smatch ptest_am ptest_check
	ytest_dt_binding_check ytest_dtbs_check dtest_build_dtb
	dtest_build_dtb_to_dts

The important log was:

arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi:
/bus@f0000/bus@4000000/gpio@4201000:ti,ngpio: Duplicate property name

With the v2 change (removing the duplicate ti,ngpio node), all of the
tests pass.

0001-arm64-dts-ti-k3-am62p-Add-gpio-ranges-for-mcu_gpio0.patch
Tests: Passed(ALL): defconfig btest_kbuild ftest_check_kdoc
ftest_check_includes ftest_check_headerdeps btest_basic btest_sparse
btest_cocci btest_smatch ptest_am ptest_check ytest_dt_binding_check
ytest_dtbs_check dtest_build_dtb dtest_build_dtb_to_dts
dtest_dtbs_check

0002-arm64-dts-ti-k3-am62p-Fix-gpio-range-for-main_pmx0.patch
Tests: Passed(ALL): defconfig btest_kbuild ftest_check_kdoc
ftest_check_includes ftest_check_headerdeps btest_basic btest_sparse
btest_cocci btest_smatch ptest_am ptest_check ytest_dt_binding_check
ytest_dtbs_check dtest_build_dtb dtest_build_dtb_to_dts
dtest_dtbs_check

0003-arm64-dts-ti-k3-j722s-Fix-gpio-range-for-main_pmx0.patch
Tests: Passed(ALL): defconfig btest_kbuild ftest_check_kdoc
ftest_check_includes ftest_check_headerdeps btest_basic btest_sparse
btest_cocci btest_smatch ptest_am ptest_check ytest_dt_binding_check
ytest_dtbs_check dtest_build_dtb dtest_build_dtb_to_dts
dtest_dtbs_check

Jared McArthur (3):
  arm64: dts: ti: k3-am62p: Add gpio-ranges for mcu_gpio0
  arm64: dts: ti: k3-am62p: Fix gpio-range for main_pmx0
  arm64: dts: ti: k3-j722s: Fix gpio-range for main_pmx0

 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi | 2 ++
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi             | 3 ++-
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi             | 3 ++-
 3 files changed, 6 insertions(+), 2 deletions(-)

Best,
Jared McArthur

-- 
2.34.1


