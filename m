Return-Path: <linux-kernel+bounces-561923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED6CA618A6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 147C8189375C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F14204873;
	Fri, 14 Mar 2025 17:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RGUdbxWt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101DA1FDE35
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741974802; cv=none; b=H0qVcNuEtYTuHr/sMkXxg5lDUTucWpXTJ55PjH1awt6kU/fRQT0FkSGNEtSu3UonizrWibCAM0A0BbptLPVxTTnbAN0ZkpKlHDLLzh9rQlXApn/+ktpugaa+rbGTaUCfNKBmAfiZIFr5lLqco/w4zAK8j+mY2JWNF0kRUwCU/+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741974802; c=relaxed/simple;
	bh=rH90RtHm9GBZCAo/uW7NtialMb/kHRjNORL1UTO+B5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPrgxCZ9mIrPNojPpWCAaSJlagLF9dGfaVs/DOeRtgUrCpdXdqZqndTUmiUMpliAVKLKl4GWAGC5hsKYw4mOYiidjR172JL6DUEGVwOKgHJ68FD3XvB41I3sjel6+FQS0OxsFHuJutvJHttWX9dnn2rx4Uc9+OfN/1NZtkwhYUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RGUdbxWt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741974798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EGMuvOS3xGfH5i++NfdyVsm5EREa0PzIM5hahSpJ1CQ=;
	b=RGUdbxWtV+NdtZBpHEy1o54b4KWKhxSK9QeZ5KF+XfDmpSYjIiSPEyiYfLv0alNFBuzx1R
	nMav6eC5lXtPz4WXvnxHmel3TwlFutegJiEvRwACiXjRNEulDzsRVKH/AlT2eMrnylbkzm
	n0C/ek67oFLTeqGsIYw0L4gfMaFgSVI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-Oshr9qKDMZ2mv4OTGiP9Ag-1; Fri,
 14 Mar 2025 13:53:17 -0400
X-MC-Unique: Oshr9qKDMZ2mv4OTGiP9Ag-1
X-Mimecast-MFC-AGG-ID: Oshr9qKDMZ2mv4OTGiP9Ag_1741974795
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3CAA419560B4;
	Fri, 14 Mar 2025 17:53:15 +0000 (UTC)
Received: from redhat.com (unknown [10.96.134.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 40B271828A93;
	Fri, 14 Mar 2025 17:53:14 +0000 (UTC)
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
	aokuliar@redhat.com
Subject: [PATCH] x86: add back the alignment of the destination to 8 bytes in copy_user_generic()
Date: Fri, 14 Mar 2025 14:53:09 -0300
Message-ID: <20250314175309.2263997-2-herton@redhat.com>
In-Reply-To: <20250314175309.2263997-1-herton@redhat.com>
References: <20250314175309.2263997-1-herton@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Since the upstream series with user copy updates were merged upstream
with commit a5624566431d ("Merge branch 'x86-rep-insns': x86 user copy
clarifications"), copy_user_generic() on x86_64 stopped doing alignment
of the writes to the destination to a 8 byte boundary for the non FSRM
case. Previously, this was done through the ALIGN_DESTINATION macro that
was used in the now removed copy_user_generic_unrolled function.

Turns out that may cause some loss of performance/throughput on some use
cases and specific CPU/platforms. Lately I got two reports of
performance/throughput issues after a RHEL 9 kernel pulled the same
upstream series with updates to user copy functions. Both reports
consisted of running specific networking/TCP related testing using
iperf3. The first report was related to a Linux Bridge testing using
VMs on an specific machine with an AMD CPU (EPYC 7402), and after a
brief investigation it turned out that the later change through
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
performance differences when changing the alignment of the destination
in copy_user_generic. I made tables below, an example of a set results I
got, summarizing the results:

* No alignment case:
             CPU      RATE          SYS          TIME     sender-receiver
Server bind   19: 13.0Gbits/sec 28.371851000 33.233499566 86.9%-70.8%
Server bind   21: 12.9Gbits/sec 28.283381000 33.586486621 85.8%-69.9%
Server bind   23: 11.1Gbits/sec 33.660190000 39.012243176 87.7%-64.5%
Server bind none: 18.9Gbits/sec 19.215339000 22.875117865 86.0%-80.5%

* With this patch (aligning write of destination address to 8 byte boundary):
             CPU      RATE          SYS          TIME     sender-receiver
Server bind   19: 20.6Gbits/sec 15.084684000 21.009879874 75.8%-89.3%
Server bind   21: 20.2Gbits/sec 15.322023000 21.427787353 75.5%-89.5%
Server bind   23: 18.5Gbits/sec 17.520225000 23.390048552 78.1%-88.8%
Server bind none: 26.0Gbits/sec 12.617328000 16.682558421 80.1%-89.6%

So I consistently got better results when aligning the write. The
results above were run on a 6.14.0-rc6 based kernel. The sys is sys
time and then the total time to run/transfer 50G of data. The last
field is the CPU usage of sender/receiver iperf3 process.

All the CPUs/platforms mentioned above did not have FRMS or ERMS
flag enabled/set. It's also worth to note that each pair of iperf3 runs
may get slightly different results on each run, but I always got consistent
higher results with the write alignment for this specific test of running
the processes on CPUs in different NUMA nodes.

Reported-by: Ondrej Lichtner <olichtne@redhat.com>
Signed-off-by: Herton R. Krzesinski <herton@redhat.com>
---
 arch/x86/include/asm/uaccess_64.h |  2 +-
 arch/x86/lib/copy_user_64.S       | 23 ++++++++++++++++++++---
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index c52f0133425b..96a0710cfacd 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -130,7 +130,7 @@ copy_user_generic(void *to, const void *from, unsigned long len)
 		"2:\n"
 		_ASM_EXTABLE_UA(1b, 2b)
 		:"+c" (len), "+D" (to), "+S" (from), ASM_CALL_CONSTRAINT
-		: : "memory", "rax");
+		: : "memory", "rax", "rdx", "r8");
 	clac();
 	return len;
 }
diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index fc9fb5d06174..4e95e9ffa37e 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -30,22 +30,39 @@
  * it simpler for us, we can clobber rsi/rdi and rax freely.
  */
 SYM_FUNC_START(rep_movs_alternative)
+	movl %edi,%eax
+	andl $7,%eax
+	je .Laligned
+	cmpq $8,%rcx
+	jb .Lcopy_user_short
+	movl %eax,%edx
+	sub $8,%edx
+	negl %edx
+	movq %rdx,%r8
+	jmp .Lcopy_bytes_loop
+
+.Laligned:
 	cmpq $64,%rcx
 	jae .Llarge
 
 	cmp $8,%ecx
 	jae .Lword
 
+.Lcopy_user_short:
 	testl %ecx,%ecx
 	je .Lexit
-
 .Lcopy_user_tail:
+	movq %rcx,%r8
+	movl %ecx,%edx
+.Lcopy_bytes_loop:
 0:	movb (%rsi),%al
 1:	movb %al,(%rdi)
 	inc %rdi
 	inc %rsi
-	dec %rcx
-	jne .Lcopy_user_tail
+	dec %edx
+	jne .Lcopy_bytes_loop
+	sub %r8,%rcx
+	jne .Laligned
 .Lexit:
 	RET
 
-- 
2.47.1


