Return-Path: <linux-kernel+bounces-569860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D62D4A6A85D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD6EA7A60A9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542DF2253A9;
	Thu, 20 Mar 2025 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXprDUNo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACC621D5B0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742480544; cv=none; b=jtrVVmeba8r+5Du7dl3OXrIY3YxIpprmOxoTKnMk2SAsc+uCJl8Nc5DyQcZXudj0SeIaDyd1MgxXKOFxdMMxnZjDOLL/9ntD4buy9FVEmNGQzhFZQpZboFe8Z4hi9x+dx/YGb/HRgsK28FO1k53Wh5oJO/Pl/lw7bioZCdvQuGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742480544; c=relaxed/simple;
	bh=qRYn178LZa63jsyxU/NM9TNSeYF6/QYAocz94oV91RE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cm9dCuN2xvQ9eHp5CSiLalaBi6ThDyclDeDelPbkMuU5Rh5viMnuZP/gX6iwE9Ztz43sQYDYFTOn7MBOfFSqecgDXSNAkXMF5PQ05QeGbUGQ7I9AVob1W81ljtwkpTPq5djKtL2EAISIEvbCUcJLlmaTYIjDATLhAEhNqTsWeqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NXprDUNo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742480541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=noX84lgrT1u6OJb2lhilj4Gs3jnx5/1w7vs/JLufMug=;
	b=NXprDUNo1wVJajk+eMcVxEwnJUD0Rtj1ZUC1ebAwu0oqh8jOdNY6/3Oyq347K96JuZ3ueU
	glp7WCaI6QyWB0djVxNrY02GuEQaYW9q7wzEiBDE+Q2LjY4cibGabGEBxPh7xqUp2sRHhQ
	U0ibv+McIi61dEyJwXlMMI1Sr6Qlr1c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-ms6JkI8uO-u0YyOl3PFNoQ-1; Thu,
 20 Mar 2025 10:22:19 -0400
X-MC-Unique: ms6JkI8uO-u0YyOl3PFNoQ-1
X-Mimecast-MFC-AGG-ID: ms6JkI8uO-u0YyOl3PFNoQ_1742480538
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B35B81801A07;
	Thu, 20 Mar 2025 14:22:17 +0000 (UTC)
Received: from redhat.com (unknown [10.96.134.26])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5F28219560AF;
	Thu, 20 Mar 2025 14:22:15 +0000 (UTC)
From: "Herton R. Krzesinski" <herton@redhat.com>
To: x86@kernel.org
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	olichtne@redhat.com,
	atomasov@redhat.com,
	aokuliar@redhat.com,
	mjguzik@gmail.com
Subject: [PATCH] x86: write aligned to 8 bytes in copy_user_generic (when without FSRM/ERMS)
Date: Thu, 20 Mar 2025 11:22:13 -0300
Message-ID: <20250320142213.2623518-1-herton@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Since the upstream series with user copy updates were merged upstream
with commit a5624566431d ("Merge branch 'x86-rep-insns': x86 user copy
clarifications"), copy_user_generic() on x86_64 stopped doing alignment
of the writes to the destination to a 8 byte boundary for the non FSRM
case. Previously, this was done through the ALIGN_DESTINATION macro that
was used in the now removed copy_user_generic_unrolled function.

Turns out that may cause some loss of performance/throughput on some use
cases and specific CPU/platforms without FSRM and ERMS. Lately I got two
reports of performance/throughput issues after a RHEL 9 kernel pulled
the same upstream series with updates to user copy functions. Both
reports consisted of running specific networking/TCP related testing
using iperf3. The first report was related to a Linux Bridge testing
using VMs on an specific machine with an AMD CPU (EPYC 7402), and after
a brief investigation it turned out that the later change through
commit ca96b162bfd2 ("x86: bring back rep movsq for user access on CPUs
without ERMS") helped/fixed the performance issue.

However, after the later commit/fix was applied, then I got another
regression reported in a multistream TCP test on a 100Gbit mlx5 nic, also
running on an AMD based platform (AMD EPYC 7302 CPU), again that was using
iperf3 to run the test. That regression was after applying the later
fix/commit, but only this didn't help in telling the whole history.

So I narrowed down the second regression use case, but running it
without traffic through a nic, on localhost, in trying to narrow down
CPU usage and not being limited by other factor like network bandwidth.
I used another system also with an AMD CPU (AMD EPYC 7742). Basically,
I run iperf3 in server and client mode in the same system, for example:

- Start the server binding it to CPU core/thread 19:
$ taskset -c 19 iperf3 -D -s -B 127.0.0.1 -p 12000

- Start the client always binding/running on CPU core/thread 17, using
perf to get statistics:
$ perf stat -o stat.txt taskset -c 17 iperf3 -c 127.0.0.1 -b 0/1000 -V \
    -n 50G --repeating-payload -l 16384 -p 12000 --cport 12001 2>&1 \
    > stat-19.txt

For the client, always running/pinned to CPU 17. But for the iperf3 in
server mode, I did test runs using CPUs 19, 21, 23 or not pinned to any
specific CPU. So it basically consisted with four runs of the same
commands, just changing the CPU which the server is pinned, or without
pinning by removing the taskset call before the server command. The CPUs
were chosen based on NUMA node they were on, this is the relevant output
of lscpu on the system:

$ lscpu
...
  Model name:             AMD EPYC 7742 64-Core Processor
...
Caches (sum of all):
  L1d:                    2 MiB (64 instances)
  L1i:                    2 MiB (64 instances)
  L2:                     32 MiB (64 instances)
  L3:                     256 MiB (16 instances)
NUMA:
  NUMA node(s):           4
  NUMA node0 CPU(s):      0,1,8,9,16,17,24,25,32,33,40,41,48,49,56,57,64,65,72,73,80,81,88,89,96,97,104,105,112,113,120,121
  NUMA node1 CPU(s):      2,3,10,11,18,19,26,27,34,35,42,43,50,51,58,59,66,67,74,75,82,83,90,91,98,99,106,107,114,115,122,123
  NUMA node2 CPU(s):      4,5,12,13,20,21,28,29,36,37,44,45,52,53,60,61,68,69,76,77,84,85,92,93,100,101,108,109,116,117,124,125
  NUMA node3 CPU(s):      6,7,14,15,22,23,30,31,38,39,46,47,54,55,62,63,70,71,78,79,86,87,94,95,102,103,110,111,118,119,126,127
...

So for the server run, when picking a CPU, I chose CPUs to be not on the same
node. The reason is with that I was able to get/measure relevant
performance differences when changing the alignment of the writes to the
destination in copy_user_generic. I made tables below, an example of a set
results I got, summarizing the results:

* No alignment case:
             CPU      RATE          SYS          TIME     sender-receiver
Server bind   19: 13.0Gbits/sec 28.371851000 33.233499566 86.9%-70.8%
Server bind   21: 12.9Gbits/sec 28.283381000 33.586486621 85.8%-69.9%
Server bind   23: 11.1Gbits/sec 33.660190000 39.012243176 87.7%-64.5%
Server bind none: 18.9Gbits/sec 19.215339000 22.875117865 86.0%-80.5%

* With this patch (aligning write in non ERMS/FSRM case):
             CPU      RATE          SYS          TIME     sender-receiver
Server bind   19: 20.8Gbits/sec 14.897284000 20.811101382 75.7%-89.0%
Server bind   21: 20.4Gbits/sec 15.205055000 21.263165909 75.4%-89.7%
Server bind   23: 20.2Gbits/sec 15.433801000 21.456175000 75.5%-89.8%
Server bind none: 26.1Gbits/sec 12.534022000 16.632447315 79.8%-89.6%

So I consistently got better results when aligning the write. The
results above were run on 6.14.0-rc6/rc7 based kernels. The sys is sys
time and then the total time to run/transfer 50G of data. The last
field is the CPU usage of sender/receiver iperf3 process. It's also
worth to note that each pair of iperf3 runs may get slightly different
results on each run, but I always got consistent higher results with
the write alignment for this specific test of running the processes
on CPUs in different NUMA nodes.

Linus Torvalds helped/provided this version of the patch. Initially I
proposed a version which aligned writes for all cases in
rep_movs_alternative, however it used two extra registers and thus
Linus provided an enhanced version that only aligns the write on the
large_movsq case, which is sufficient since the problem happens only
on those AMD CPUs like ones mentioned above without ERMS/FSRM, and
also doesn't require using extra registers. Also, I validated that
aligning only on large_movsq case is really enough for getting the
performance back. I tested this patch also on an old Intel based system
without ERMS/FRMS (with Xeon E5-2667 - Sandy Bridge based) and didn't
get any problems (no performance enhancement but also no regression
too, using the same iperf3 based benchmark). Also newer Intel processors
after Sandy Bridge usually have ERMS and should not be affected by this
change.

Fixes: ca96b162bfd2 ("x86: bring back rep movsq for user access on CPUs without ERMS")
Fixes: 034ff37d3407 ("x86: rewrite '__copy_user_nocache' function")
Reported-by: Ondrej Lichtner <olichtne@redhat.com>
Co-developed-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Herton R. Krzesinski <herton@redhat.com>
---
 arch/x86/lib/copy_user_64.S | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index fc9fb5d06174..b8f74d80f35c 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -74,6 +74,24 @@ SYM_FUNC_START(rep_movs_alternative)
 	_ASM_EXTABLE_UA( 0b, 1b)
 
 .Llarge_movsq:
+	/* Do the first possibly unaligned word */
+0:	movq (%rsi),%rax
+1:	movq %rax,(%rdi)
+
+	_ASM_EXTABLE_UA( 0b, .Lcopy_user_tail)
+	_ASM_EXTABLE_UA( 1b, .Lcopy_user_tail)
+
+	/* What would be the offset to the aligned destination? */
+	leaq 8(%rdi),%rax
+	andq $-8,%rax
+	subq %rdi,%rax
+
+	/* .. and update pointers and count to match */
+	addq %rax,%rdi
+	addq %rax,%rsi
+	subq %rax,%rcx
+
+	/* make %rcx contain the number of words, %rax the remainder */
 	movq %rcx,%rax
 	shrq $3,%rcx
 	andl $7,%eax
-- 
2.47.1


