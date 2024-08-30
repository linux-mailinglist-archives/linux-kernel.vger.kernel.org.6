Return-Path: <linux-kernel+bounces-308937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6289663FE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 16:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AAFF285BCB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27DC1B250A;
	Fri, 30 Aug 2024 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ez/ZxdhR"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431391B1D7D;
	Fri, 30 Aug 2024 14:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725027525; cv=none; b=qSlsF6UdlOUjDdEGiQF4JYtDdmzDBjt21SwFsugwC5pnKJMpogyU+s3jYcRGotzdQXMP+dDqIKY0Q4L/r0Jak4G3PvI6d204bqfchlLLxhpPNHKnPnyjyQKY2yohuwM23KTBhDBByCQB3OYgTe2mj0R5djPUjmhwyawF1RqksBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725027525; c=relaxed/simple;
	bh=iDGdFq4/Jb0vFXO2WYZ9ZAIBFTI2dHl2/uIU+aZ7QJw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AZTonywuCsHcpZJZOJmqCxaGobzzzJj2D3v+gDCkDhGtV1ltQsYmKEPEWsNih90FqCnnw+Ng14KtjFCS0DVDV+5uu4FRwcpkX4fG0EQufDDUIy5BnYqUyT+P9Gs35O/DKF3kp/NiCSrZtz/lUIsmEYQmq2FJFEqxtTXRSLER8ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ez/ZxdhR; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=v6/zyvof4qMqjJ+4xzc0g1Ye/jBKn1I/cVtXd5Huwfg=; b=ez/ZxdhRyaLTDXkcXt65kzdlXC
	2F44k9Z3lOfVzv7CwMwOroZhtPXAalN0AmKaIGuapFlajlqY1xlF/6PB5aRl5wk116Iao061OZ0mA
	akWE8kVPlF5imhW8ZGxMyxKcviQXCv2rKt/qZfsqSoA51I1n0N/NklNUkLUIdfLBj2fIL5M+lDtI6
	ka3De4ySH7ImuAqJ+F28rzMXkemWtdw862wGu4V8hcvcRNj7Em4oeUUu9I0/XjawFmvAZDVrwYQRX
	uBuQlkvGzuLeSY/wFa8o/crROA326Xbtg6lHoytkl4bh6lO2ccY/o9NMLPiH/RbsyhX5dH3D+gZZz
	YdxGJBgQ==;
Received: from [177.76.152.96] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sk2Rs-007B3a-Mf; Fri, 30 Aug 2024 16:18:00 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: kexec@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org
Cc: bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	naveen@kernel.org,
	hbathini@linux.ibm.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	ashish.kalra@amd.com,
	michael.roth@amd.com,
	brijesh.singh@amd.com,
	thomas.lendacky@amd.com,
	linux-kernel@vger.kernel.org,
	linux-debuggers@vger.kernel.org,
	stephen.s.brennan@oracle.com,
	kernel@gpiccoli.net,
	kernel-dev@igalia.com,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH] powerpc/fadump, x86/sev: Inform about unconditionally enabling crash_kexec_post_notifiers
Date: Fri, 30 Aug 2024 11:17:15 -0300
Message-ID: <20240830141752.460173-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inspired by commit d57d6fe5bf34 ("drivers: hv: log when enabling crash_kexec_post_notifiers"),
a good idea is to signal on dmesg about unconditionally enabling the kernel
parameter crash_kexec_post_notifiers, which affects how kdump works.

By checking the source code, found 2 more cases besides Hyper-V, so let's
print that on dmesg for them as well.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 arch/powerpc/kernel/fadump.c | 1 +
 arch/x86/virt/svm/sev.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index a612e7513a4f..37dee89a0bf2 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1819,6 +1819,7 @@ int __init setup_fadump(void)
 	 * notifiers are invoked.
 	 */
 	crash_kexec_post_notifiers = true;
+	pr_info("PPC/fadump: enabling crash_kexec_post_notifiers\n");
 
 	return 1;
 }
diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 0ce17766c0e5..ac445ad2fcc8 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -257,6 +257,7 @@ static int __init snp_rmptable_init(void)
 	 * notifier is invoked to do SNP IOMMU shutdown before kdump.
 	 */
 	crash_kexec_post_notifiers = true;
+	pr_info("AMD/SEV: enabling crash_kexec_post_notifiers\n");
 
 	return 0;
 
-- 
2.46.0


