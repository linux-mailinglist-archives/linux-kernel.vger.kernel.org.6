Return-Path: <linux-kernel+bounces-204397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABA38FE834
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74E9DB25CDB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D49E196441;
	Thu,  6 Jun 2024 13:51:53 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1E71940BE
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717681913; cv=none; b=sV3CPz+6HST/knyoJRsD5OD6OKgDXtDrrSLloJlNRLzKtSTHE9LWXzbD+Vm7+SSF+0xyTGBqlanJQyAd5CRjZjkibk+LDuoRDcZ73PQ4pa7fNVyxJ9Ljfie/rYMcwuhVGGqZCLn0hbFmExXKX6SspAFjsIPJnzvYWqpxbNgsjNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717681913; c=relaxed/simple;
	bh=IDL5SpyE6W7WVazaqU2DGPiFv2/6beF2WWfKG8n1szs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pXzUCdai89Fbx9CBpcxdQGz0pQy3l3SL9YQmsBV9b1qnISiN+tQxWLC8SJE9b+Lnbc3q/lVAWodJ28Eky97lGS4alfVwvsltnFjqKUxGBsJ9RH3hTq8tVJtBD4u/7Em9yZjtfYdzbvjFuWhN8pQeV/bunsStkX1MWf3axMm/01Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-374820a077cso6978735ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 06:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717681911; x=1718286711;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1aQ+Beukn7IdnK93tu8Ue6o5bCvmF41VO02ftLOaYhs=;
        b=Alvy8l8cRjDzNarlL4XDlQ0QvGU4+ZGWc69lIpAGW2zOGz4EnLuZeiTnJPHhtYCEpw
         c/27ScaCeMmdUoRr0MKsTQpGe2oRtf00QH2tXI05qJrpDSknap3eY+aCAAOVWDM7iVQA
         PBijrxt0PE2XiOoGkd8QENk6Dib3BIcweS1Q3+T4wXwU/zCrxLtA8Zd7DJ4XWfjweDsH
         h4hukoiCAfCK7osVsHNmACYxDtFsn7sOHm5widq0bl4CEV1yqid5DgsfMm24diZYYEvw
         QMV/7H0wO53G5NBVfKU8HgMKjHxkQyZPQnDaLts0xrygs4fiFg8HKvzZmPN+gpwGX/zA
         DeBA==
X-Gm-Message-State: AOJu0Yzw8R/+Jh9S29vyUA+ApghgRrQ3VhAuUCNOMNhvXN9LgLNzv021
	fiXQnFDXB9hJnPZvdEGKdR5JHPj1zAnCrPHU/ziC0pAaOxoa+oMHjeZEoJFFLNolIqeW+Me7db5
	cfkTgY7VfyWzKEbnLP2JFn81LGxdBXOp4/hNoZ35Ew3SL/MS7apc6CLE=
X-Google-Smtp-Source: AGHT+IHc7y4L+SXOnEIs/3IcL89VcNEB/3RGfvvU0lo4AMw8KD7d6AlD1M2xCCr1rccOApNyaJy5SDZGpDHp8sOfVjUmzYjeJnl8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:b70d:0:b0:374:b233:3433 with SMTP id
 e9e14a558f8ab-374b23335e8mr2094025ab.5.1717681911118; Thu, 06 Jun 2024
 06:51:51 -0700 (PDT)
Date: Thu, 06 Jun 2024 06:51:51 -0700
In-Reply-To: <000000000000adb08b061413919e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000265027061a38fce6@google.com>
Subject: Re: [syzbot] possible deadlock in trie_delete_elem
From: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: possible deadlock in trie_delete_elem
Author: norkam41@gmail.com

#syz test: https://linux.googlesource.com/linux/kernel/git/torvalds/linux e377d803b65ee4130213b3c041fc25fdfec1bd90

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 2d29bc0f21cc..75fdb8e3abaa 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2393,12 +2393,21 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
 	cant_sleep();

 	// return if instrumentation disabled, see: bpf_disable_instrumentation
-	if (unlikely(__this_cpu_read(bpf_prog_active))) {
+	int instrumentation = unlikely(__this_cpu_read(bpf_prog_active));
+	if (instrumentation) {
+		printk("SKIP FOR INSTRUMENTATION: %s > %s > %p /%i ==============\n",
+				prog->aux->name,
+				link->btp->tp->name, prog, instrumentation);
 		bpf_prog_inc_misses_counter(prog);
 		return;
 	}

-	if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
+	int active = this_cpu_inc_return(*(prog->active));
+	// printk("%s > %s > %p /%i\n", prog->aux->name, link->btp->tp->name, prog, active);
+	if (active != 1) {
+		printk("SKIP FOR ACTIVE: %s > %s > %p /%i =======================\n",
+				prog->aux->name,
+				link->btp->tp->name, prog, active);
 		bpf_prog_inc_misses_counter(prog);
 		goto out;
 	}
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 8d1507dd0724..e756262d8df7 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -168,12 +169,21 @@ static inline void release_probes(struct tracepoint_func *old)
 static void debug_print_probes(struct tracepoint_func *funcs)
 {
 	int i;
+	struct bpf_raw_tp_link *link;

 	if (!tracepoint_debug || !funcs)
 		return;

-	for (i = 0; funcs[i].func; i++)
-		printk(KERN_DEBUG "Probe %d : %p\n", i, funcs[i].func);
+	for (i = 0; funcs[i].func; i++) {
+		link = funcs[i].data;
+		int active = this_cpu_read(*(link->link.prog->active));
+		printk("Probe %d : %p / %p: %s/%d / %i\n", i,
+				funcs[i].func,
+				link,
+				link->link.prog->aux->name,
+				active,
+				funcs[i].prio);
+	}
 }

 static struct tracepoint_func *
@@ -298,6 +308,8 @@ static enum tp_func_state nr_func_state(const struct tracepoint_func *tp_funcs)
 {
 	if (!tp_funcs)
 		return TP_FUNC_0;
+	if (!tp_funcs[0].func)
+		return TP_FUNC_0;
 	if (!tp_funcs[1].func)
 		return TP_FUNC_1;
 	if (!tp_funcs[2].func)

