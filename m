Return-Path: <linux-kernel+bounces-436260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A39859E8381
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 05:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E8121884820
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 04:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE92F179A7;
	Sun,  8 Dec 2024 04:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=envs.net header.i=@envs.net header.b="FbwBSwHk"
Received: from mail.envs.net (mail.envs.net [5.199.136.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D037B4690
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 04:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.199.136.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733631288; cv=none; b=qtIdXmQt6GQPvgPaal6GsKaQTRV/zzyvp+R6cBXs7p1if3Xd4rFL6n+qpbXjo/f81528EtdwYk9I3hs9l6VomctfBZ9z7ntW1R99vaEHmd+yaBsLEbjNfl1CO6PU2a9k6Wgi+RibsEm4qniNdjT0K96qPbVKR0Le4actKA6ON/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733631288; c=relaxed/simple;
	bh=D7254COie+x3pc0oHylG73x9Wu67y8rHoN3OzuE5hKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jcqf26m3w7gnqoK73pkwU9aEnOGQzyZur5lLx0n6qc89D2+41wlEYv1Y9cxDuQWvKDX1OzNxPf3KEePM2mViVF0jlhJVsr0BryIMhZFHcl7dYuU5cHYilNicCaQS65Don0mBP0hUdPjJQM/E1mnTh95q0qv3ScC7nfpnHIXC+dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=envs.net; spf=pass smtp.mailfrom=envs.net; dkim=pass (4096-bit key) header.d=envs.net header.i=@envs.net header.b=FbwBSwHk; arc=none smtp.client-ip=5.199.136.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=envs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=envs.net
Received: from localhost (mail.envs.net [127.0.0.1])
	by mail.envs.net (Postfix) with ESMTP id 99ECA38A3DB5;
	Sun,  8 Dec 2024 04:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=envs.net; s=modoboa;
	t=1733631278; bh=7E9TZHLWCgTL5RvyRaKB2u9GkmzIM/1cHuQEZ0gXYME=;
	h=From:To:Cc:Subject:Date:From;
	b=FbwBSwHkq2597/VF0HBBZJnF4tRGWQAAZ1ripRydyDEICF1OH9AJqIfykrglY1/Ml
	 jwPQZqoXsE6srar5PvD97U1d+n9PHtHw2Ptz0cGTe9+TAzBaZwPuPopfJO8dm5+kpe
	 UyaUu/ORXSuEd5o6fert+wEarZ2YMvGC1eDA59XQsqZ1uZgWv64+/B0dme3pJ5egzb
	 kNQp3laaxlLB4TRz4s23D6qLEKIddM2h+yoNTSXM9IHVtwSoamLfj/mhw9D2IzYc8O
	 YqitbbcjKN7UkOnZBgztHTe8xms+o75amKa6fsHMHSctEKT9v1eLUVgfDJrb4FKian
	 Sihlt9cemMtCxWVK8HLArFrEzlDvu/GF2gNtJV02D7+FyRR7qSO846MBzX35KJTwU6
	 D+mNyfpEpanJv3uknUuz/Ba2BASTfWpmOoMRMJ6jKDCU+yXZGZ1tRaiTzx2+dvoASR
	 h4XvhsYZtlG/vXIEFzmLHJKqC5DYgYg+wXYwlAMeE82Y+SVSrqLaIeXeMszTtq5QIG
	 J/usUHGyBgHaTANaPO4SmQNDI4xb6HLAKdFb8B2mB9qYEKk/pliwbRpkEq6sao3fNV
	 F4vSt48PU1HsaUHNMslLmnoDvjPd2oWgeWyxNBUHEa1N0+800PeowU6/MVdgOGYe6U
	 LsKf7Omn5QZwdPFrE3msRXPE=
X-Virus-Scanned: Debian amavisd-new at mail.envs.net
Received: from mail.envs.net ([127.0.0.1])
	by localhost (mail.envs.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yOqQ7LgRtJiS; Sun,  8 Dec 2024 04:14:36 +0000 (UTC)
Received: from xtexx.eu.org (unknown [120.230.227.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.envs.net (Postfix) with ESMTPSA;
	Sun,  8 Dec 2024 04:14:35 +0000 (UTC)
From: Bingwu Zhang <xtex@envs.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Bingwu Zhang <xtex@aosc.io>,
	linux-kernel@vger.kernel.org,
	~xtex/staging@lists.sr.ht
Subject: [PATCH] mailmap: update Bingwu Zhang's email address
Date: Sun,  8 Dec 2024 12:13:52 +0800
Message-ID: <20241208041352.168131-2-xtex@envs.net>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1211; i=xtex@aosc.io; h=from:subject; bh=3OiPnNjJAz4b3Q8u9Kl67NLvp1ZJV3+PCOnGwJmz8No=; b=owGbwMvMwCW2U4Ij7wZL9ETG02pJDOmhsgxvDG238micUP4mtdvEKrfv3cHbZ3O5bgo6XTl7Y ZPNRqc1HaUsDGJcDLJiiixFhg3erDrp/KLLymVh5rAygQxh4OIUgInMVmVkWG8gN3PNYZPy3RdU 0/SY/KK+s6Yf316QrSG49WJXVPjxrQz/0yacfzT/0ISDDbJ5Nx/clfj55VNn2Pn7kt3f1FsfZli 9ZAMA
X-Developer-Key: i=xtex@aosc.io; a=openpgp; fpr=7231804B052C670F15A6771DB918086ED8045B91
Content-Transfer-Encoding: 8bit

From: Bingwu Zhang <xtex@aosc.io>

I used to contribute to the kernel as 'Bingwu Zhang
<xtexchooser@duck.com>' and 'Zhang Bingwu <xtexchooser@duck.com>'.

Signed-off-by: Bingwu Zhang <xtex@aosc.io>
---
As there are too many problems with the duck.com email address, for example,
they add a "spam-detection" banner in all incoming emails,
I decided to move to aosc.io.

Thank you for your review!
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index 5ff0e5d681e7..0fa6d27adec2 100644
--- a/.mailmap
+++ b/.mailmap
@@ -121,6 +121,8 @@ Ben Widawsky <bwidawsk@kernel.org> <benjamin.widawsky@intel.com>
 Benjamin Poirier <benjamin.poirier@gmail.com> <bpoirier@suse.de>
 Benjamin Tissoires <bentiss@kernel.org> <benjamin.tissoires@gmail.com>
 Benjamin Tissoires <bentiss@kernel.org> <benjamin.tissoires@redhat.com>
+Bingwu Zhang <xtex@aosc.io> <xtexchooser@duck.com>
+Bingwu Zhang <xtex@aosc.io> <xtex@xtexx.eu.org>
 Bjorn Andersson <andersson@kernel.org> <bjorn@kryo.se>
 Bjorn Andersson <andersson@kernel.org> <bjorn.andersson@linaro.org>
 Bjorn Andersson <andersson@kernel.org> <bjorn.andersson@sonymobile.com>

base-commit: 7503345ac5f5e82fd9a36d6e6b447c016376403a
-- 
2.47.1


