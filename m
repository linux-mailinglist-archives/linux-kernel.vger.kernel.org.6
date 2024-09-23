Return-Path: <linux-kernel+bounces-335508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB65C97E6BA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D9EE281007
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 07:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD577350E;
	Mon, 23 Sep 2024 07:37:33 +0000 (UTC)
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A5D61674
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 07:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727077052; cv=none; b=naOwLnkhT4/egAkYYc8Tq48VwZR6q/A7kE0J4QalZZ8R7JXul88F3FwkgUnIW4OsFt/LvfbbzAasDvUGe7wfOJ+2YNcg/5T2q5mUoRfOT+3lgS5u0RvDXDnX8eoCiPx4QHTo8vYOke0z9UP0/HNWce2A3/bslRPIStEilzd3f7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727077052; c=relaxed/simple;
	bh=2oeV+afBSOOqynCQM1WBP3//mRNM7gvN+utn4b6xGMQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pzT+W/YzdHtphkgCSEZF3hQwrIKduu65reao8UmTUORPWzxV0Xp9ZQnprNH7gmmkof1kgCRu4l0ZhWvK/uRkTE4bY2rk2JDybH+T29mmcyCHdzyQBGzK+eOVNsriUGimRpzPPkSRKNB7iokTKO0aJ2/ZSKqmgyS43p4Xc1WL4CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1727077035-1eb14e31a71164e0001-xx1T2L
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx2.zhaoxin.com with ESMTP id FYaIoiMM5E9mZSYS (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 23 Sep 2024 15:37:15 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXSHMBX2.zhaoxin.com (10.28.252.164) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 23 Sep
 2024 15:37:14 +0800
Received: from ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d]) by
 ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d%4]) with mapi id
 15.01.2507.039; Mon, 23 Sep 2024 15:37:14 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from localhost.localdomain (10.32.65.165) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Sep
 2024 15:33:09 +0800
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <LeoLiu-oc@zhaoxin.com>,
	Lyle Li <LyleLi@zhaoxin.com>
Subject: [PATCH v4 1/4] x86/mce: Add centaur vendor to support Zhaoxin MCA
Date: Mon, 23 Sep 2024 15:33:08 +0800
X-ASG-Orig-Subj: [PATCH v4 1/4] x86/mce: Add centaur vendor to support Zhaoxin MCA
Message-ID: <20240923073311.4290-2-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240923073311.4290-1-TonyWWang-oc@zhaoxin.com>
References: <20240918055436.15551-1-TonyWWang-oc@zhaoxin.com>
 <20240923073311.4290-1-TonyWWang-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 9/23/2024 3:37:13 PM
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1727077035
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2594
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.130842
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

From: Lyle Li <LyleLi@zhaoxin.com>

Zhaoxin consists of two vendors, X86_VENDOR_ZHAOXIN and
X86_VENDOR_CENTAUR, so add the centaur vendor to support
Zhaoxin MCA in mce/core.c and mce/intel.c.

Signed-off-by: Lyle Li <LyleLi@zhaoxin.com>
Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 arch/x86/kernel/cpu/mce/core.c  | 9 +++++++--
 arch/x86/kernel/cpu/mce/intel.c | 3 ++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.=
c
index ad0623b65..4ad6b5083 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -496,6 +496,7 @@ bool mce_usable_address(struct mce *m)
=20
 	case X86_VENDOR_INTEL:
 	case X86_VENDOR_ZHAOXIN:
+	case X86_VENDOR_CENTAUR:
 		return intel_mce_usable_address(m);
=20
 	default:
@@ -513,6 +514,7 @@ bool mce_is_memory_error(struct mce *m)
=20
 	case X86_VENDOR_INTEL:
 	case X86_VENDOR_ZHAOXIN:
+	case X86_VENDOR_CENTAUR:
 		/*
 		 * Intel SDM Volume 3B - 15.9.2 Compound Error Codes
 		 *
@@ -1247,7 +1249,8 @@ static noinstr bool mce_check_crashing_cpu(void)
=20
 		mcgstatus =3D __rdmsr(MSR_IA32_MCG_STATUS);
=20
-		if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_ZHAOXIN) {
+		if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_ZHAOXIN ||
+		    boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_CENTAUR) {
 			if (mcgstatus & MCG_STATUS_LMCES)
 				return false;
 		}
@@ -1521,7 +1524,8 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	 * on Intel, Zhaoxin only.
 	 */
 	if (m.cpuvendor =3D=3D X86_VENDOR_INTEL ||
-	    m.cpuvendor =3D=3D X86_VENDOR_ZHAOXIN)
+	    m.cpuvendor =3D=3D X86_VENDOR_ZHAOXIN ||
+	    m.cpuvendor =3D=3D X86_VENDOR_CENTAUR)
 		lmce =3D m.mcgstatus & MCG_STATUS_LMCES;
=20
 	/*
@@ -2092,6 +2096,7 @@ static void __mcheck_cpu_clear_vendor(struct cpuinfo_=
x86 *c)
 		break;
=20
 	case X86_VENDOR_ZHAOXIN:
+	case X86_VENDOR_CENTAUR:
 		mce_zhaoxin_feature_clear(c);
 		break;
=20
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/inte=
l.c
index f6103e6bf..b7e67f4f7 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -88,7 +88,8 @@ static int cmci_supported(int *banks)
 	 * makes sure none of the backdoors are entered otherwise.
 	 */
 	if (boot_cpu_data.x86_vendor !=3D X86_VENDOR_INTEL &&
-	    boot_cpu_data.x86_vendor !=3D X86_VENDOR_ZHAOXIN)
+	    boot_cpu_data.x86_vendor !=3D X86_VENDOR_ZHAOXIN &&
+	    boot_cpu_data.x86_vendor !=3D X86_VENDOR_CENTAUR)
 		return 0;
=20
 	if (!boot_cpu_has(X86_FEATURE_APIC) || lapic_get_maxlvt() < 6)
--=20
2.34.1


