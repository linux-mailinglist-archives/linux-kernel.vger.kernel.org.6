Return-Path: <linux-kernel+bounces-204361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBC48FE7B8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B5CDB23B47
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6E4195FD8;
	Thu,  6 Jun 2024 13:27:41 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFE4193080
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717680461; cv=none; b=WXKA1pz1JtkBSQkClQoHNmQlCgv2mtTNMnd0iC9EygYnxqNROfYd+VaquxXs1OtuJTl3rd8lTlJm1CAsTwURJEuH0BhTi3ywL/6rmJdI0vIB4DbRuhl8jSgHvQm+dqp793J0Q6TPp4g9clJkGr/7a5lT4veS0fjDG4EPh94Z6HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717680461; c=relaxed/simple;
	bh=9Atm5uS1laj9xcXK2Ptt3GDwXG+HHMt76Ktgp88ag74=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SpINtvp1H3v9CG5V5zk/WalJ5q2Nn2H6WK45tQ6PBfIY19pkcsOEdLVOXDUlgVzW5Cm13WUAb/6Yx002q/nk7VqzAl/n5BgYfrCzRsjA+X8W3YMzAOcA7Dp+lmdGjww4mX1xtnsKv3Cyak86X6eNwktYkX/aoI08GV/cZzBVOLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-374b5078c77so6821855ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 06:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717680459; x=1718285259;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abfphsRMbGeQRG/fK5wFoK7weNKwSUdL9kX61t+nOSI=;
        b=Rsk6JgvgVvPd2AT8P0eRgUvrLXPcRPsTn6lT0koW2GUBozhWWsKyl8WuvPjcYVA+oG
         BVpqLJYM1FxWZzJuyadOxMabDYpK8WiowzmCW7zJd3xkzKYwCFZDH+Mgp/XXeCcRD/C5
         TNRzzZeb+ZVHJ2ub2xhI5BPyHG4z3PM1JhpZKEYmgTM94hgWsI9CeK5oVM3/JietfmDZ
         gmyyRBozluwd/g4WoEC9EcmAf2rORw+Bgb2hiEDPuN1F4Vg4RQI1XvNP7krYYoL0RKOT
         LCtGHhbqWR3LwA8Y7odRD95kCHTAmJmXlIUdBlVNpmJewpFjhpXFeS8AkDKLTiEofpJr
         YtGQ==
X-Gm-Message-State: AOJu0Yz2t2u5GvHOD1UYazVxeUu7qVvHWoxYAzZjKkqWusBdcnA6pWT8
	wSySluu9JQvPx9Z5oZUKMe9OSuuA4Xj8m2yC0UGWwRkLRk5RNGhRfB+OEVMGCjRJn/MprXcd4iQ
	RMBFTY6obgS/nPcvKUI/kU9jSmQQAtsZN34Ui0Q9XZYjsFc6wYQhnhp0=
X-Google-Smtp-Source: AGHT+IEBNTP0cxVElXYMV+aMooYdXtchxHDigEfuk23B8rbMm9jvUm1JYt2puHsNs6vgkXRHIHHr4fMTq9AWaUrlZlSRGFbo7Igp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1909:b0:374:b161:a090 with SMTP id
 e9e14a558f8ab-374b1ef350dmr3748455ab.2.1717680458857; Thu, 06 Jun 2024
 06:27:38 -0700 (PDT)
Date: Thu, 06 Jun 2024 06:27:38 -0700
In-Reply-To: <000000000000adb08b061413919e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009693d9061a38a541@google.com>
Subject: Re: [syzbot] possible deadlock in trie_delete_elem
From: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: possible deadlock in trie_delete_elem
Author: norbert.kaminski@infogain.com

#syz test https://linux.googlesource.com/linux/kernel/git/torvalds/linux e3=
77d803b65ee4130213b3c041fc25fdfec1bd90

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 2d29bc0f21cc..75fdb8e3abaa 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2393,12 +2393,21 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, =
u64 *args)
        cant_sleep();

        // return if instrumentation disabled, see: bpf_disable_instrumenta=
tion
-       if (unlikely(__this_cpu_read(bpf_prog_active))) {
+       int instrumentation =3D unlikely(__this_cpu_read(bpf_prog_active));
+       if (instrumentation) {
+               printk("SKIP FOR INSTRUMENTATION: %s > %s > %p /%i =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n",
+                               prog->aux->name,
+                               link->btp->tp->name, prog, instrumentation)=
;
                bpf_prog_inc_misses_counter(prog);
                return;
        }

-       if (unlikely(this_cpu_inc_return(*(prog->active)) !=3D 1)) {
+       int active =3D this_cpu_inc_return(*(prog->active));
+       // printk("%s > %s > %p /%i\n", prog->aux->name, link->btp->tp->nam=
e, prog, active);
+       if (active !=3D 1) {
+               printk("SKIP FOR ACTIVE: %s > %s > %p /%i =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n",
+                               prog->aux->name,
+                               link->btp->tp->name, prog, active);
                bpf_prog_inc_misses_counter(prog);
                goto out;
        }
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 8d1507dd0724..e756262d8df7 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -168,12 +169,21 @@ static inline void release_probes(struct tracepoint_f=
unc *old)
 static void debug_print_probes(struct tracepoint_func *funcs)
 {
        int i;
+       struct bpf_raw_tp_link *link;

        if (!tracepoint_debug || !funcs)
                return;

-       for (i =3D 0; funcs[i].func; i++)
-               printk(KERN_DEBUG "Probe %d : %p\n", i, funcs[i].func);
+       for (i =3D 0; funcs[i].func; i++) {
+               link =3D funcs[i].data;
+               int active =3D this_cpu_read(*(link->link.prog->active));
+               printk("Probe %d : %p / %p: %s/%d / %i\n", i,
+                               funcs[i].func,
+                               link,
+                               link->link.prog->aux->name,
+                               active,
+                               funcs[i].prio);
+       }
 }

 static struct tracepoint_func *
@@ -298,6 +308,8 @@ static enum tp_func_state nr_func_state(const struct tr=
acepoint_func *tp_funcs)
 {
        if (!tp_funcs)
                return TP_FUNC_0;
+       if (!tp_funcs[0].func)
+               return TP_FUNC_0;
        if (!tp_funcs[1].func)
                return TP_FUNC_1;
        if (!tp_funcs[2].func)
The information in this email is confidential and may be legally privileged=
. It is intended solely for the addressee and access to it by anyone else i=
s unauthorized. If you are not the intended recipient, any disclosure, copy=
ing, distribution or any action taken or omitted to be taken based on it, i=
s strictly prohibited and may be unlawful.

