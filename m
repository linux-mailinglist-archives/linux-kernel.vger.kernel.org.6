Return-Path: <linux-kernel+bounces-201455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB738FBEC7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD171C21336
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 22:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7A114830E;
	Tue,  4 Jun 2024 22:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrZPatv2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BDB13777A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 22:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539605; cv=none; b=is1gSnxW0dA2uc/cx+Z4UQk62XvZcQX1hQPW215w5b4zzL4tm2eN6qf3O4laffzGOU5VTJyok2oXvIOpd7shETmzhCPjy1q5kWmv77s/Uhi9O8ZZi33ZkXsrHHh91lbdCnFIWIxjZqKdxfHy2dIgW0X9FOCtb379SdYJPQxsuhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539605; c=relaxed/simple;
	bh=8TiUNaMaAWC+yYz8ZOZ+uSMGvJ3zugJcjEr8p3x049k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGc5I76IgwpbM/0vKyLvltQWYlcY51vmE0YuCIM91VaEnyJiTQvdhCbN8Bnx0Lq2+26e7ypR/kkhmDFVbcjs61GeviUHI59ItfwrHNiRq8rFlhcR/iLtrn/FRj2u2GDFqASQ4xW6wtfslaC3FAYOBkpFnxAu+z3c6LAomDeHxgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrZPatv2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B07BC2BBFC;
	Tue,  4 Jun 2024 22:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717539605;
	bh=8TiUNaMaAWC+yYz8ZOZ+uSMGvJ3zugJcjEr8p3x049k=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=RrZPatv2/4me2R2HIf4eY2RWuUH+HNEwQYbCVvVij+b2+dHQKxu+ycV6D+TjS1rFm
	 9yoyqE3CfEZPw2ipUf/bQ3NwRLJ1Ms7ZvkkgIxMLIRb9ePi3atyUFeSyb2T5m1tHNX
	 +XAUITBdeMXDWc6ELdZ774c6WRKJJ5c2ZMN6dYwNcpuSuKxPauEquzIDWgH4d93ZGa
	 HXrXFPsNYneke0Fbo0hjlQhgVfGZWwvddqGIFi4r/VVisICcsVBaxpuuln/iLaPp9r
	 w8UekpL+YL+9BfZUVJeSD2rpmYvRjAorQdNBazVdTmQ9jtPHkDaT3ZKxh9M7zd7cGT
	 mxI4qbN4BlB5A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B4B51CE3ED6; Tue,  4 Jun 2024 15:20:04 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:20:04 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Feng Tang <feng.tang@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Zhengxu Chen <zhxchen17@meta.com>,
	Danielle Costantino <dcostantino@meta.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, John Stultz <jstultz@google.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH RFC v4 tsc] Check for sockets instead of CPUs to make code
 match comment
Message-ID: <a4b93a09-26e8-4df1-91df-a3b833b5eb46@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <62a0a0cd-3103-4e8f-b4c8-a91f12121e92@paulmck-laptop>
 <Zg416EXHJa9CdI9L@feng-clx.sh.intel.com>
 <4b6724fb-2fb7-4081-ba1d-0797d746d9b8@paulmck-laptop>
 <b09884cc-4729-42bc-a3a1-10f38993627e@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b09884cc-4729-42bc-a3a1-10f38993627e@paulmck-laptop>

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

The only change since v3 is forward-porting to v6.10-rc1.

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 06b170759e5bf..3640bf119f127 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1289,7 +1289,7 @@ int unsynchronized_tsc(void)
 	 */
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
 		/* assume multi socket systems are not synchronized: */
-		if (num_possible_cpus() > 1)
+		if (topology_max_packages() > 1)
 			return 1;
 	}
 

