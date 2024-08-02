Return-Path: <linux-kernel+bounces-272776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A61419460CA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62846282C59
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4821537C8;
	Fri,  2 Aug 2024 15:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mz9HpLTV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C667E13632B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 15:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722613580; cv=none; b=L+jxUOMCPATKswbp7pyR5+1U1j0BkIRdCPoME8/aqtEo1PGDidUEZmQrN3XMZ+UyiWh41AAExr+dE1BXFrilOXOSp8e5RpDHMS6FFnlHk/JTZj+4a6yHsdTR27mwrMUr5l54kVaAk7Tf19Nnh8HL4wX2UO2gvJcMs4r85tcYlDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722613580; c=relaxed/simple;
	bh=N+A1wc43BLC5mDm7eS+PYjhLx7Pij+P3OfOMl3FWjQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GUrgf1h4aKfevaluiGvv1TMdwoGFErf0xqCC73eO2yKnRNGu8If6jWDAHn5XMaYCDtrT3Nuaj5xsaZTb/6ivYGU22cIWg8QRRZshPvFaRnWQCaiNiFAeDVjhSRP/aeOyNs4LhntJW7IbmYM3On9nHBzQqrKldG7XgGjK/+wETJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mz9HpLTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73AC2C4AF13;
	Fri,  2 Aug 2024 15:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722613580;
	bh=N+A1wc43BLC5mDm7eS+PYjhLx7Pij+P3OfOMl3FWjQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mz9HpLTVShk6sFHe0ZX2W/Fd1CHIzsE/A7AIP/JSagRDQf1+WRiGXv6+lEUg5D1cn
	 QWtVDhpeWW8XWAgzF6FVUj0ZGWE2RE1RGxio+QBfgQX3Mdr8KSk1rg0gtzLzjNkZUD
	 nXcgQWuoWVDBXWkayBhBdI8M6Cj53Y/7GBmuvPyK0w6UqFSguS3hmxEHTM9GsHaxmx
	 BWGk4E9A0Ro/2JBpbmj5qCowy6E1YSEABgx4PoMF0MK8H3DFN+nVdEN6Naqyx7tBVy
	 LciIyvEujrhPTpYZG0LDuxKfcvZiuU6psUnG1kJbF20eU9BnXXiFM+ZgEE6p7lXZD7
	 DyU8JVo5sJw/A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0C9ACCE0FA2; Fri,  2 Aug 2024 08:46:20 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Feng Tang <feng.tang@intel.com>,
	Waiman Long <longman@redhat.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	x86@kernel.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Zhengxu Chen <zhxchen17@meta.com>,
	Danielle Costantino <dcostantino@meta.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 TSC and clocksource-watchdog updates for v6.12 5/5] tsc: Check for sockets instead of CPUs to make code match comment
Date: Fri,  2 Aug 2024 08:46:18 -0700
Message-Id: <20240802154618.4149953-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <dac058b2-68c7-4b9a-a428-afb2b4b03ea0@paulmck-laptop>
References: <dac058b2-68c7-4b9a-a428-afb2b4b03ea0@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The unsynchronized_tsc() eventually checks num_possible_cpus(), and
if the system is non-Intel and the number of possible CPUs is greater
than one, assumes that TSCs are unsynchronized.  This despite the
comment saying "assume multi socket systems are not synchronized",
that is, socket rather than CPU.  This behavior was preserved by
commit 8fbbc4b45ce3 ("x86: merge tsc_init and clocksource code") and
by the previous relevant commit 7e69f2b1ead2 ("clocksource: Remove the
update callback").

The clocksource drivers were added by commit 5d0cf410e94b ("Time: i386
Clocksource Drivers") back in 2006, and the comment still said "socket"
rather than "CPU".

Therefore, bravely (and perhaps foolishly) make the code match the
comment.

Note that it is possible to bypass both code and comment by booting
with tsc=reliable, but this also disables the clocksource watchdog,
which is undesirable when trust in the TSC is strictly limited.

[ paulmck: Switch from nr_online_nodes to topology_max_packages() per Feng Tang feedback. ]

Reported-by: Zhengxu Chen <zhxchen17@meta.com>
Reported-by: Danielle Costantino <dcostantino@meta.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Waiman Long <longman@redhat.com>
Cc: John Stultz <jstultz@google.com>
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: <x86@kernel.org>
---
 arch/x86/kernel/tsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index d4462fb262996..b7b050ca8baa1 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1290,7 +1290,7 @@ int unsynchronized_tsc(void)
 	 */
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
 		/* assume multi socket systems are not synchronized: */
-		if (num_possible_cpus() > 1)
+		if (topology_max_packages() > 1)
 			return 1;
 	}
 
-- 
2.40.1


