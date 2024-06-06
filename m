Return-Path: <linux-kernel+bounces-204408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA848FE856
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 306792832E6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47DB19643E;
	Thu,  6 Jun 2024 14:04:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1038D2BAF1
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 14:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682647; cv=none; b=S/hUhpa29y5zdivsXwngdEcae1VqEig/b6/H/PQ++3XgqXQsKGCy1DKtQg1/YdWusaTLm/BYvkI79i7TRw67TlKO9+sEx//5xai8meEBLgqG2Kt4ng2aT7SFfj1x6GQ/7LjYd3wOGFfZaJzQT6JDCdmCrA2EkRSAUFZqxNh42NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682647; c=relaxed/simple;
	bh=Aa+yNawb/6vYuwyonTK2efnNyGoMyOrjMBz0/aNhX4E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cOTD0oBgYwfJvLDagSa0UBkHMyoiySifPGZHE/+GS1MVBL9NeIdoPCKjG7/IDp8K3ruHBgKWjdl1BK1w2mF41VfN/2M3BToNz2r5WvAxWPyKOilXZ/CbzAw96yH2Vlrw5jEuU4+3XjNafL2Q0k8dYpF7GuUyLIyRaDu6XLPqTGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7e8e7707356so113059139f.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 07:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717682645; x=1718287445;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1fTb+s859GtkLCRE6EYmEpE5ayYfzHKL23weMhhSCJw=;
        b=oFuxWhe9beOK5il5+OkJhj4cTDEed1li6USoN/Vd+UiSOEfbH2LOp3QpGg7aa6fmUd
         RQzT3qa/NxC+Ic9A1f+1nTHvFji/vv91DWwljnc4zVeR5MgTv5YBJLxD0wHD6SQ4Hmh/
         qrcGatk5IMLZJ3WqkuuHYbtDa7Jc/BQ3JdB/NBgGlGVpqCnbdOKYqteg9qjiGTfFR5uW
         n9aymN9eCj837xuZGFySFdWg829d/QEUyCGugsnDuuX6jdwmJgKpkK4QmDP4JydCo6te
         6TjLT5XfG44lHNcbAMrarLFfC5IJKVuhcCCKoFfp+ZwdKgmIps4AMsqP59yioXlpmTc9
         G1SQ==
X-Gm-Message-State: AOJu0YxFH4ghD2nHeUi31zEgz5iK0EWStp0QPZjal2NQXg77O1yKbjjB
	XMnoPL8yNijDqz942YnW9kT1uZPSSfTmMy2/5x2DQy9jTbUmFzKa/a0TVns/viQB/JMZPjsWlBg
	x+U6ikCTKovJ2k9pmmuTzEkS2pBqNSVWJ7nCaIux62WnuDT5gQLyB78o=
X-Google-Smtp-Source: AGHT+IGzdZgbkAjYV3xxcl7t4lOKILpj7Pjw+fbBoWdyx2dZil9BeMCC3g/yVgVkbWk7KhDj5eStbUF7nKktbyWfmFuBNv70O0vR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:841c:b0:4b3:292b:278e with SMTP id
 8926c6da1cb9f-4b63a76852emr338252173.1.1717682644967; Thu, 06 Jun 2024
 07:04:04 -0700 (PDT)
Date: Thu, 06 Jun 2024 07:04:04 -0700
In-Reply-To: <000000000000adb08b061413919e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e3f688061a392771@google.com>
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

---
 kernel/trace/bpf_trace.c | 13 +++++++++++--
 kernel/tracepoint.c      | 15 +++++++++++++--
 2 files changed, 24 insertions(+), 4 deletions(-)

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
index 8d1507dd0724..a0a0d8b16b41 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -168,12 +168,21 @@ static inline void release_probes(struct tracepoint_func *old)
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
@@ -298,6 +307,8 @@ static enum tp_func_state nr_func_state(const struct tracepoint_func *tp_funcs)
 {
 	if (!tp_funcs)
 		return TP_FUNC_0;
+	if (!tp_funcs[0].func)
+		return TP_FUNC_0;
 	if (!tp_funcs[1].func)
 		return TP_FUNC_1;
 	if (!tp_funcs[2].func)
--
2.34.1

