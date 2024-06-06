Return-Path: <linux-kernel+bounces-204429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4944F8FEB9D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC641F28D79
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F28E1AB8FA;
	Thu,  6 Jun 2024 14:14:33 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A6919A295
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 14:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683273; cv=none; b=cpzskNLyL2LDPN8ioAaWKXq15+a3BIvNWWjZHwx0sb7AMW1lZMzpjJsDHBhXUdfasyLp3IsB3SnTCVhPxTzKHANECl3OKLlHcejk+dS8Z0FQvMkgXZ1Ny8T2YSqWtGwjEES2rOV8JANotVg+jypgT68Jo1kP5DqQ7cegUtnnQTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683273; c=relaxed/simple;
	bh=Pwl+Ph8+3XYeth7wyt/AmydUz4nZL/6HcBeIPvZXsRE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bmWcvG/0igTzOH8FDQispcjar/K4pCQmk1oZ+iLQZhvBEC68Z1Sgli7XQhrY/py5OQQHKAmlV8uIrLMhxaXU/NI4mQMPurk99GGYeELYKq4OsDYP49MoFkofIWsdPALpM6cB/X+4/zic0ctipCuejI+hGPUfOXnIJZfNYcFvE8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-374ad7fa4bbso10089955ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 07:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717683270; x=1718288070;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpKPMPp72E39a98DYqNubx0t6d1WZdls3EbkjhEyXDg=;
        b=P20bFn4dV4et3KuzugVNoh9lvCXfYemVxQe82FvNwxQrlBda2NBKNHZ+lE8ICVE0EO
         7SK7F2cTyuiEsTXGwrOb+giXROnOR+2lPuNIbTJM8Q2GaTd1ZtX0PumuqAW4RtURKN8a
         sRv9vol/2agXUS6vHyg4AnTsVLRwt4AiVZltjQxYdEGXPn0OojBRz4MDk91AcuTjq/Km
         MkwnaYrZk8LhgZ+NGOU9uYk6/k/dsbbxftaNh+itBtlVEaFC+qBIaz/q7Ay39tZQIB4E
         jTUpJ8ahg8MYmzEUoONyJcP875RKT6GCaxdxecPe1dQvi+YElQZzVU3JSZsKhckA81Ba
         7F+w==
X-Gm-Message-State: AOJu0YxMeI12qX4cpfUUDD+8z21jqBCI4nmTF9mNdl8Drsw1J4laVl77
	Pj+ptgWFeDoMGX1qtFKBTWPTgGOX4XzN3JMDmOga5UkeYZgf8LbrVLLLA5He7jui+ID/mTPbYSr
	Dny7kuMFubvwx3Vkrg0hnofoT0PHkMbUvUvT4YMbJofgvRAspwU9b1io=
X-Google-Smtp-Source: AGHT+IHHmX5X1ULzOzng/upfRocUoEOv/1IM52Yfa9EKkY1SuGZ+colljbASDJtMnxfDAR5WIJvxl/ekp7Bzzfq2BJ7KNwUPT7IV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26b:0:b0:36c:5228:462 with SMTP id
 e9e14a558f8ab-374b1f56c81mr3614015ab.3.1717683270146; Thu, 06 Jun 2024
 07:14:30 -0700 (PDT)
Date: Thu, 06 Jun 2024 07:14:30 -0700
In-Reply-To: <000000000000adb08b061413919e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000277099061a394d13@google.com>
Subject: Re: [syzbot] possible deadlock in trie_delete_elem
From: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: possible deadlock in trie_delete_elem
Author: norkam41@gmail.com

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it c3f38fa61af77b49866b006939479069cd451173

Signed-off-by: Norbert Kami=C5=84ski <norkam41@gmail.com>
---
 kernel/trace/bpf_trace.c | 18 +++++++++++++++++-
 kernel/tracepoint.c      | 15 +++++++++++++--
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 6249dac61701..75fdb8e3abaa 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2391,7 +2391,23 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, u=
64 *args)
 	struct bpf_trace_run_ctx run_ctx;
=20
 	cant_sleep();
-	if (unlikely(this_cpu_inc_return(*(prog->active)) !=3D 1)) {
+
+	// return if instrumentation disabled, see: bpf_disable_instrumentation
+	int instrumentation =3D unlikely(__this_cpu_read(bpf_prog_active));
+	if (instrumentation) {
+		printk("SKIP FOR INSTRUMENTATION: %s > %s > %p /%i =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D\n",
+				prog->aux->name,
+				link->btp->tp->name, prog, instrumentation);
+		bpf_prog_inc_misses_counter(prog);
+		return;
+	}
+
+	int active =3D this_cpu_inc_return(*(prog->active));
+	// printk("%s > %s > %p /%i\n", prog->aux->name, link->btp->tp->name, pro=
g, active);
+	if (active !=3D 1) {
+		printk("SKIP FOR ACTIVE: %s > %s > %p /%i =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n",
+				prog->aux->name,
+				link->btp->tp->name, prog, active);
 		bpf_prog_inc_misses_counter(prog);
 		goto out;
 	}
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 8d1507dd0724..a0a0d8b16b41 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -168,12 +168,21 @@ static inline void release_probes(struct tracepoint_f=
unc *old)
 static void debug_print_probes(struct tracepoint_func *funcs)
 {
 	int i;
+	struct bpf_raw_tp_link *link;
=20
 	if (!tracepoint_debug || !funcs)
 		return;
=20
-	for (i =3D 0; funcs[i].func; i++)
-		printk(KERN_DEBUG "Probe %d : %p\n", i, funcs[i].func);
+	for (i =3D 0; funcs[i].func; i++) {
+		link =3D funcs[i].data;
+		int active =3D this_cpu_read(*(link->link.prog->active));
+		printk("Probe %d : %p / %p: %s/%d / %i\n", i,
+				funcs[i].func,
+				link,
+				link->link.prog->aux->name,
+				active,
+				funcs[i].prio);
+	}
 }
=20
 static struct tracepoint_func *
@@ -298,6 +307,8 @@ static enum tp_func_state nr_func_state(const struct tr=
acepoint_func *tp_funcs)
 {
 	if (!tp_funcs)
 		return TP_FUNC_0;
+	if (!tp_funcs[0].func)
+		return TP_FUNC_0;
 	if (!tp_funcs[1].func)
 		return TP_FUNC_1;
 	if (!tp_funcs[2].func)
--=20
2.34.1


