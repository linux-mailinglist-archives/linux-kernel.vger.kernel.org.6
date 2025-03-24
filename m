Return-Path: <linux-kernel+bounces-573355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8BFA6D62F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECE7C16D430
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5496D25D216;
	Mon, 24 Mar 2025 08:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iagzWhzN"
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E39F25D1F1
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 08:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742805057; cv=none; b=Azv5zqZ+NW3hEIBP9UnozZPIxowCW7OKn7cgv47VAgMAFC40boROFauvMLxUFEGMmd1PWkUecBLdy44wVsbtNa/XaTcSXqDtcl/XCWN2G10RABnPbbg+bHQsSloSdGHu3KH6jTfkfDJ6rh8RFbJl0qqyQjkRNQ0TsnT5lhu5sl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742805057; c=relaxed/simple;
	bh=vYmy5u25gzaHq7SmQy2KBnd7C2B7271Tlq2N7QyXtvU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tYMc7LEv8AikCr9fpJjYVrFZosIvo5ea4uKfbJhWHt1OZfyl3fiMceAFEeSeYVluWclrY6d8mu35d0eABT7D+nqv2q/4ALnDg0FK6TyVquKaRqgfirdnPGFwh3Uimzv3H/CNscOcctofmbr9LvaIf7Yuep4cXF2eOYU5HuPQNTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iagzWhzN; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7c3b53373faso604578385a.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 01:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742805055; x=1743409855; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LnZAqgTpfRqWA1973bFlPxs4rbPnm5bXXu4eePDCxrY=;
        b=iagzWhzNhG1JGJmOzZKUidav+kJDyPLEgK3qPLJmgbQ+VUsfTRoUuUpfYbzTYcJ34m
         /0wqrt/aZgOYe/XrPfYLCDlGrIiuTdKY+AJjI3ud5QwPYp0Jozy7i8MaWqdK29Nvy36o
         RCEtp8YonnL/wX/8OVCxgpUwuDUm8BovssygQ6MfICKspA098sOhQI82ojnv/dS6IDr/
         jKuELxwG1/vafal+UZGLJDe2jWkpPlD+0inYYqHvxF0LdkjdTo4P/jghW7z/VSztXJio
         w1f/c2Ohj2QVS1P9lVky53TOvH27ZLCcI1l5h6S8mWlvlh06ojwfS4hlylKKiZFTa7W/
         0r1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742805055; x=1743409855;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LnZAqgTpfRqWA1973bFlPxs4rbPnm5bXXu4eePDCxrY=;
        b=Y+48X2uPqZSoe/j7KIuPSxQVZuGpDxQLLD0dD4xBtVvOqLAmGZlh3bVjuqOJ1lxjFn
         dB1ZKXNh1IAmS7+0KUAeoK9SCpr8zYMRsXLTxclWQrsRMitByR0PxgODXJtgMNeyUtwA
         qklWlqnifojvDLh730qWxPo+8zUJC7pDP6z2kUtayX2+Yn0n+19XRVy/z6G0Ko1AKKg+
         DNhfAX3k7DP9jKk20Hdugp1r8v062zsIZYQC8FRKNnYDr4Moov4s5wzapM0QYXgfDZGm
         3KgB3veQJrQuc9MqFHSabx+Z0o6gsdmLMjGSm8boQ4cfroIUxktSxi2IOLzagxL5nDbA
         ayVw==
X-Gm-Message-State: AOJu0YyZknd/V2JUDm3oYodgBGZSklz44tVQJMTA4skWhxi201wQe+6o
	NUrxjIT8LIpC8MfPxSJCvGWu5NxT2TmEJ9jzGN/ndR3fJVgxg+RYtTrroRysvJYAcNDQlDyIzae
	en0cAcRS+eA==
X-Google-Smtp-Source: AGHT+IG9DPXRqrFQamZ4Psx9uxyGkFtJoeIrMWdj8DzsusDYVXGtfbWVdQ5zXr2DwFV0YGmwC5M4Ly8d7KljiQ==
X-Received: from qkpb1.prod.google.com ([2002:a05:620a:2701:b0:7c3:d5be:189c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4106:b0:7c5:a5cc:bcb9 with SMTP id af79cd13be357-7c5ba2058c4mr1730106885a.56.1742805054842;
 Mon, 24 Mar 2025 01:30:54 -0700 (PDT)
Date: Mon, 24 Mar 2025 08:30:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324083051.3938815-1-edumazet@google.com>
Subject: [PATCH v2] x86/alternatives: remove false sharing in poke_int3_handler()
From: Eric Dumazet <edumazet@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org, 
	bpf@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>, 
	Greg Thelen <gthelen@google.com>, Stephane Eranian <eranian@google.com>, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

eBPF programs can be run 50,000,000 times per second on busy servers.

Whenever /proc/sys/kernel/bpf_stats_enabled is turned off,
hundreds of calls sites are patched from text_poke_bp_batch()
and we see a huge loss of performance due to false sharing
on bp_desc.refs lasting up to three seconds.

   51.30%  server_bin       [kernel.kallsyms]           [k] poke_int3_handler
            |
            |--46.45%--poke_int3_handler
            |          exc_int3
            |          asm_exc_int3
            |          |
            |          |--24.26%--cls_bpf_classify
            |          |          tcf_classify
            |          |          __dev_queue_xmit
            |          |          ip6_finish_output2
            |          |          ip6_output
            |          |          ip6_xmit
            |          |          inet6_csk_xmit
            |          |          __tcp_transmit_skb
            |          |          |
            |          |          |--9.00%--tcp_v6_do_rcv
            |          |          |          tcp_v6_rcv
            |          |          |          ip6_protocol_deliver_rcu
            |          |          |          ip6_rcv_finish
            |          |          |          ipv6_rcv
            |          |          |          __netif_receive_skb
            |          |          |          process_backlog
            |          |          |          __napi_poll
            |          |          |          net_rx_action
            |          |          |          __softirqentry_text_start
            |          |          |          asm_call_sysvec_on_stack
            |          |          |          do_softirq_own_stack

Fix this by replacing bp_desc.refs with a per-cpu bp_refs.

Before the patch, on a host with 240 cores (480 threads):

$ bpftool prog | grep run_time_ns
...
105: sched_cls  name hn_egress  tag 699fc5eea64144e3  gpl run_time_ns
3009063719 run_cnt 82757845

-> average cost is 36 nsec per call

echo 0 >/proc/sys/kernel/bpf_stats_enabled
text_poke_bp_batch(nr_entries=2)
        text_poke_bp_batch+1
        text_poke_finish+27
        arch_jump_label_transform_apply+22
        jump_label_update+98
        __static_key_slow_dec_cpuslocked+64
        static_key_slow_dec+31
        bpf_stats_handler+236
        proc_sys_call_handler+396
        vfs_write+761
        ksys_write+102
        do_syscall_64+107
        entry_SYSCALL_64_after_hwframe+103
Took 324 usec

text_poke_bp_batch(nr_entries=164)
        text_poke_bp_batch+1
        text_poke_finish+27
        arch_jump_label_transform_apply+22
        jump_label_update+98
        __static_key_slow_dec_cpuslocked+64
        static_key_slow_dec+31
        bpf_stats_handler+236
        proc_sys_call_handler+396
        vfs_write+761
        ksys_write+102
        do_syscall_64+107
        entry_SYSCALL_64_after_hwframe+103
Took 2655300 usec

After this patch:

$ bpftool prog | grep run_time_ns
...
105: sched_cls  name hn_egress  tag 699fc5eea64144e3  gpl run_time_ns
1928223019 run_cnt 67682728

 -> average cost is 28 nsec per call

echo 0 >/proc/sys/kernel/bpf_stats_enabled
text_poke_bp_batch(nr_entries=2)
        text_poke_bp_batch+1
        text_poke_finish+27
        arch_jump_label_transform_apply+22
        jump_label_update+98
        __static_key_slow_dec_cpuslocked+64
        static_key_slow_dec+31
        bpf_stats_handler+236
        proc_sys_call_handler+396
        vfs_write+761
        ksys_write+102
        do_syscall_64+107
        entry_SYSCALL_64_after_hwframe+103
Took 519 usec

text_poke_bp_batch(nr_entries=164)
        text_poke_bp_batch+1
        text_poke_finish+27
        arch_jump_label_transform_apply+22
        jump_label_update+98
        __static_key_slow_dec_cpuslocked+64
        static_key_slow_dec+31
        bpf_stats_handler+236
        proc_sys_call_handler+396
        vfs_write+761
        ksys_write+102
        do_syscall_64+107
        entry_SYSCALL_64_after_hwframe+103
Took 702 usec

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 arch/x86/kernel/alternative.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index c71b575bf229..5d364e990055 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2137,28 +2137,29 @@ struct text_poke_loc {
 struct bp_patching_desc {
 	struct text_poke_loc *vec;
 	int nr_entries;
-	atomic_t refs;
 };
 
+static DEFINE_PER_CPU(atomic_t, bp_refs);
+
 static struct bp_patching_desc bp_desc;
 
 static __always_inline
 struct bp_patching_desc *try_get_desc(void)
 {
-	struct bp_patching_desc *desc = &bp_desc;
+	atomic_t *refs = this_cpu_ptr(&bp_refs);
 
-	if (!raw_atomic_inc_not_zero(&desc->refs))
+	if (!raw_atomic_inc_not_zero(refs))
 		return NULL;
 
-	return desc;
+	return &bp_desc;
 }
 
 static __always_inline void put_desc(void)
 {
-	struct bp_patching_desc *desc = &bp_desc;
+	atomic_t *refs = this_cpu_ptr(&bp_refs);
 
 	smp_mb__before_atomic();
-	raw_atomic_dec(&desc->refs);
+	raw_atomic_dec(refs);
 }
 
 static __always_inline void *text_poke_addr(struct text_poke_loc *tp)
@@ -2191,9 +2192,9 @@ noinstr int poke_int3_handler(struct pt_regs *regs)
 	 * Having observed our INT3 instruction, we now must observe
 	 * bp_desc with non-zero refcount:
 	 *
-	 *	bp_desc.refs = 1		INT3
-	 *	WMB				RMB
-	 *	write INT3			if (bp_desc.refs != 0)
+	 *	bp_refs = 1		INT3
+	 *	WMB			RMB
+	 *	write INT3		if (bp_refs != 0)
 	 */
 	smp_rmb();
 
@@ -2299,7 +2300,8 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	 * Corresponds to the implicit memory barrier in try_get_desc() to
 	 * ensure reading a non-zero refcount provides up to date bp_desc data.
 	 */
-	atomic_set_release(&bp_desc.refs, 1);
+	for_each_possible_cpu(i)
+		atomic_set_release(per_cpu_ptr(&bp_refs, i), 1);
 
 	/*
 	 * Function tracing can enable thousands of places that need to be
@@ -2413,8 +2415,12 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	/*
 	 * Remove and wait for refs to be zero.
 	 */
-	if (!atomic_dec_and_test(&bp_desc.refs))
-		atomic_cond_read_acquire(&bp_desc.refs, !VAL);
+	for_each_possible_cpu(i) {
+		atomic_t *refs = per_cpu_ptr(&bp_refs, i);
+
+		if (unlikely(!atomic_dec_and_test(refs)))
+			atomic_cond_read_acquire(refs, !VAL);
+	}
 }
 
 static void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
-- 
2.49.0.395.g12beb8f557-goog


