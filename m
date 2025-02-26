Return-Path: <linux-kernel+bounces-534609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 819D8A46907
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F2A3AFB91
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDD123373B;
	Wed, 26 Feb 2025 18:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Xshdv4op"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A79233714;
	Wed, 26 Feb 2025 18:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593374; cv=none; b=SXV/SMULdr0m93G2iy78uwRtMl/N6H24WejThjhreDwtLJJjgF1soIT+jI8xmC4a+dqk6me3PEjj3bn6p8IY8T68fvHih7rwkaCuA9f0mrhTabYVtvI79AO0/hkMW3oMh5PTa+tYk/GO9MefTDWPOpgVZv3bVHSzKAsFHqNtt10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593374; c=relaxed/simple;
	bh=8GrZ5l4yxwcjLJSxD+8WCPJaE0LXpzSMSqn6M6EAhaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RVSP1R1KV0TlmgpMgc99C61z68ToayaXVigtsWebiupaDA2qDle5CKAiQYttYJ3Wft93SKjJM+MwtuZXlXR2UxTXfKcIlPN45GbFEL2cUWDZxUZVxQAVEwp5PCaBR9jpNkZPyej4sUG/PGv3Vy/7teYLNudPJmApLdpHX0xDw9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Xshdv4op; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=bvwlO8qBtTZWwYdcbtIUwkxxLC3Jj2J1AZY/gLjVLog=; b=Xshdv4opuLFhjoqDgben7afOvO
	J94gm8MSrvgKX7r4E2DE2d2K06yOqe7nUuBb2e60ZIsBjdIRo2Fp9fW77Lo9p3PRCxq0agOcUgdDf
	DUiSD3giKkvHm3aVk72dM0kGMfs+XXSf96H7Ex6PQnYogwl0WJvWpKP+sjsn9BECfq8Sik/vif/uw
	qqNXndM7t+RhJS6r4L+y3VFH4dsE2cK2fsaT/buYtc73VyM4AbE7kncmdjK8S0JN/8zZTExS15rNK
	Khn9luw6+3TwvJB2dOQEUTiniEo0K4gZvjCyFb+ge47mOIgtiDDbeo8KAn2R4MhXJxQCdulkgvCPM
	dTmt2N5A==;
Received: from [179.125.94.240] (helo=[192.168.67.187])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tnLqR-0016Gc-Nm; Wed, 26 Feb 2025 19:09:25 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Wed, 26 Feb 2025 15:09:04 -0300
Subject: [PATCH] parisc: perf: use named initializers for struct miscdevice
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-parisc-perf-miscdev-v1-1-8d541ac2092d@igalia.com>
X-B4-Tracking: v=1; b=H4sIAL9Yv2cC/x2MsQqAMAwFf0UyG6ihOvgr4lDqq2ZQSwoiiP9uc
 bsb7h4qMEWhsXnIcGnR86jStQ3FLRwrWJfqJE56JzJwDqYlcoYl3istuNg7+MFL6ASRapkNSe/
 /Os3v+wE4oBONZQAAAA==
X-Change-ID: 20250226-parisc-perf-miscdev-40e4642a12ec
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-dev@igalia.com, Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
X-Mailer: b4 0.14.2

Though struct miscdevice has hardly changed over the years, this is good
practice and also makes the core more readable.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 arch/parisc/kernel/perf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/parisc/kernel/perf.c b/arch/parisc/kernel/perf.c
index 5e8e37a722ef0fb3a22a8e0e57cb0fd48886901d..5e10f98ce7b54f75ceac1e8e5cdd1d4f752ed28f 100644
--- a/arch/parisc/kernel/perf.c
+++ b/arch/parisc/kernel/perf.c
@@ -475,9 +475,9 @@ static const struct file_operations perf_fops = {
 };
 
 static struct miscdevice perf_dev = {
-	MISC_DYNAMIC_MINOR,
-	PA_PERF_DEV,
-	&perf_fops
+	.minor	= MISC_DYNAMIC_MINOR,
+	.name	= PA_PERF_DEV,
+	.fops	= &perf_fops,
 };
 
 /*

---
base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
change-id: 20250226-parisc-perf-miscdev-40e4642a12ec

Best regards,
-- 
Thadeu Lima de Souza Cascardo <cascardo@igalia.com>


