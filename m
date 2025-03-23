Return-Path: <linux-kernel+bounces-572914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AEAA6D04A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 18:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AFD516E000
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 17:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF5613C689;
	Sun, 23 Mar 2025 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="NsoYyJGx"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1155078F34
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742751561; cv=none; b=tV2F5YANj88DVwt8uguK68rMYpfbHow8ShtGBVqtaTwYxUsWbkPrAR8Z0ZNCtDOLN7B57cwVNM/CVxS8wPiX2vCus/m2QK2sRYrofeAeKnyHlLxiVSdSp7K2SQxa7zRPW6U5j7pw4CkBT3Mz0E4MSR/FGnU4JquAcI/SPhiEVBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742751561; c=relaxed/simple;
	bh=jh0ycPLejM7mCuEk4f5uf8+CmgdQtw6gM1DDtTBIzBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y0mSUZVVdxKjwBk5ZIcxeCdnRe0PfcQQhavtuX61ZXufj7RBuuBBr1xuV5pVa1blB896sR2+YS9P/JgKIGvJk1G4A/zLOUtRDac53FCXhE9Es4Ygjk9/YiMc4PXKJtFsZfi1GvkohH2E59TsfySXD1yaqLJSxzY0QwMlQV2J/vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=NsoYyJGx; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ZEZDrPHRgPzjmBS5GwTANCoXyApuOgxh8hc878j+Apw=; b=NsoYyJGxeQXhN1mpYiI5udHvY9
	VNw/zqgd+ohqPii+3lo/vKOBFWOQrr+kCq/RyM4khZ6st9oyyV947bq3MzXot4EkvVzqVs/a86dZF
	tu/UUo4frDxnZ/gkvAOnpaZlkH6KeEhU+AtZihN7AUgh4ps2c8NrJ0GAXQfETWrPORM6JBBpdGIr3
	UvEWSCtiru+MVqvKuCe+DxMx6OBq1LWOsrlR0aNxpa1UsOxA2oXYm3qTMqEbsLHsUpduJU5Xvz59+
	hs8zxMnilD/1F40TD61X5AFEQjrrETsVke1kMlxkWua/LNRJSj1YtFA7/KeumdvlZjvoEZYQfr8o7
	pN5ng0RQ==;
Received: from [187.90.172.172] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1twPI0-005MNd-5S; Sun, 23 Mar 2025 18:39:12 +0100
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: linux-kernel@vger.kernel.org
Cc: jstultz@google.com,
	tglx@linutronix.de,
	sboyd@kernel.org,
	paulmck@kernel.org,
	feng.tang@intel.com,
	kernel@gpiccoli.net,
	kernel-dev@igalia.com,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH] clocksource: Fix the CPUs' choice in the watchdog percpu verification
Date: Sun, 23 Mar 2025 14:36:24 -0300
Message-ID: <20250323173857.372390-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Right now, if the clocksource watchdog detects a clocksource skew, it
might perform a percpu checking, for example in the TSC case on x86.
In other words: supposing TSC is detected as unstable by the
clocksource watchdog running at CPU1, as part of marking TSC as
unstable the kernel will also run a check of TSC readings in some CPUs
other than CPU1 to be sure it is synced between them all.

But that check might happen only in some CPUs, not all of them; this
choice is based on the parameter "verify_n_cpus" and in some random
cpumask calculation. So, the watchdog runs such percpu check in
up to "verify_n_cpus" random CPUs among all online CPUs, with the risk
of repeating CPUs (that aren't double checked) in the cpumask random
calculation.

But if "verify_n_cpus" > num_online_cpus(), we could skip the random
calculation and just go ahead and check the clocksource sync between
all online CPUs, without the risk of skipping some CPUs due to
duplicity in the random cpumask calculation. That approach is exactly
what is proposed here.

Tests in a 4 CPU laptop with TSC skew detected led to some cases of
the percpu verification skipping some CPU even with verify_n_cpus=8,
due to the duplicity on random cpumask generation. With this patch,
the issue is fixed.

Suggested-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

---


Hey folks, thanks in advance for reviews / suggestions!

Special thanks to Cascardo for the suggestion of checking
verify_n_cpus against the number of online CPUs - definitely
improved the idea!

I think this could be backported to stable if makes sense;
I can do it, please let me know your opinion.
Cheers,

Guilherme


 kernel/time/clocksource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 2a7802ec480c..a32732dab27e 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -310,7 +310,7 @@ static void clocksource_verify_choose_cpus(void)
 {
 	int cpu, i, n = verify_n_cpus;
 
-	if (n < 0) {
+	if ((n < 0) || (n >= num_online_cpus())) {
 		/* Check all of the CPUs. */
 		cpumask_copy(&cpus_chosen, cpu_online_mask);
 		cpumask_clear_cpu(smp_processor_id(), &cpus_chosen);
-- 
2.48.1


