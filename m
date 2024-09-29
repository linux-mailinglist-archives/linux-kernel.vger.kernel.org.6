Return-Path: <linux-kernel+bounces-343098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE44A9896C7
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 20:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BFFC284880
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 18:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDB242ABE;
	Sun, 29 Sep 2024 18:28:05 +0000 (UTC)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5374C62B
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 18:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.101.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727634485; cv=none; b=g2OxuvL7HtLhc3tSodgFM1UEO1m2IjuFzgUzzlbrPyirf6kmxHHtrRWEzYmClLnhy+e+GP3XV1lzqVOVTYPlSQSq007NPfkeVdPdDG63BJj8WmkrpBVsJTc39mxxcAvUkXer5E26gpIkIwy3wLC1QmYkCtgHrnlYcGFghLxrhXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727634485; c=relaxed/simple;
	bh=Akja96EBvkfwk+Mny9hOpt9hllyh2xFazkaZpVC22TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qhC96iCPrDeQ9Mjp887KgupiFPBMN0SxWR9rk6bDoNctmkwDnqEJArKozhryurA+pgT6HDLVcb8YSuDvuGXYMmBzHA7B2jj8kP7IVQU+bgFegglgBDBFxKcB+lxBSzKc1xJgRJrlQhHiXE3ThrpgfJjZjsNzMburJCPBjXIBjBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io; spf=pass smtp.mailfrom=sys-base.io; arc=none smtp.client-ip=185.233.101.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
	by leonov.paulk.fr (Postfix) with ESMTPS id E4CFA1F0004B
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 18:19:50 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
	id 33F95A60899; Sun, 29 Sep 2024 18:19:50 +0000 (UTC)
X-Spam-Level: *
Received: from localhost.localdomain (unknown [192.168.1.64])
	by laika.paulk.fr (Postfix) with ESMTP id E147EA60899;
	Sun, 29 Sep 2024 18:19:46 +0000 (UTC)
From: Paul Kocialkowski <paulk@sys-base.io>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
	Ingo Molnar <mingo@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Maxime Ripard <mripard@kernel.org>,
	Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH] ARM: topology: Allow missing CPU clock-frequency device-tree property
Date: Sun, 29 Sep 2024 20:19:36 +0200
Message-ID: <20240929181936.644910-1-paulk@sys-base.io>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Kocialkowski <contact@paulk.fr>

When no capacity-dmips-mhz property is provided, the ARM topology code
implements a fallback mechanism that uses the clock-frequency
device-tree property as an indication of the maximum frequency
achievable by the CPU.

When the property is missing, the fallback mechanism gives up and
prints out a nasty error message that has been haunting generations
of ARMv7 Linux users. This is uncalled for since the property is
optional (and now deprecated too).

Allow the fallback mechanism to continue by assuming the same nominal
frequency for all CPU cores, while still benefiting from the static
coefficient provided by the compatible-driven table entries.
This is similar to what is done in the common arch topology code when
it fails to find a clock to get the frequency from.

The ranging mechanism (using the middle capacity) is unaffected by
the use of a unit frequency and still returns values in the requested
range.

Also add a comment to clarify what is going on.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/kernel/topology.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 2336ee2aa44a..0eb743c65166 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -119,13 +119,23 @@ static void __init parse_dt_topology(void)
 		if (cpu_eff->compatible == NULL)
 			continue;
 
+		/*
+		 * Use the legacy clock-frequency property (representing the
+		 * maximum achievable clock frequency) as an efficiency
+		 * coefficient (divided by 2^20, roughly 1 MHz) to the table
+		 * value. If no such property is available, use the table value
+		 * directly and assume all CPUs are running at the same
+		 * nominal frequency.
+		 *
+		 * It is assumed that clock-frequency is either provided for all
+		 * CPUs or for none of them.
+		 */
 		rate = of_get_property(cn, "clock-frequency", &len);
-		if (!rate || len != 4) {
-			pr_err("%pOF missing clock-frequency property\n", cn);
-			continue;
-		}
-
-		capacity = ((be32_to_cpup(rate)) >> 20) * cpu_eff->efficiency;
+		if (rate && len == 4)
+			capacity = ((be32_to_cpup(rate)) >> 20) *
+				   cpu_eff->efficiency;
+		else
+			capacity = cpu_eff->efficiency;
 
 		/* Save min capacity of the system */
 		if (capacity < min_capacity)
-- 
2.46.2


