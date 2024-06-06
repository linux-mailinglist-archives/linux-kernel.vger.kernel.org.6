Return-Path: <linux-kernel+bounces-204313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E9D8FE718
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A190B283C7E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D898D195B36;
	Thu,  6 Jun 2024 13:05:57 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256AC194C99
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679157; cv=none; b=gqJyVqXhuXg4IqsHQ3UPFbgP8WiAOAx2zl46DSs8ej9L33TW6F7tOnVqQg74muBbpabs8jzacDZJKILSMlQxt6dS23yVgqX/Tbv7+2keF0mTluP1auk54h3fmguwBYxKp1tOz4ZAQFKWuiDSRzc/RuVXi9HNBncAFs74iWZ7GLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679157; c=relaxed/simple;
	bh=u8L6dUucWZRm9VtkOK5vym0gJ+Ywx2a9eggu8RhlaOk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QmDu0Kdoh7mbIrwGBqTrIEFc7DnAWzPwSvBlmV1IVWzejupKEWCzqiqA2ofgN1Ny+IpMzqEt8QfVdCTxggrSZG1vpp+sqBEkrvMjyq5clR2rsrXLICg2TiKcbytw9BQOP/dXnyq4XHi0ovgWju1k+c5lOUx1xVjBQYN1Cjjh6Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e8e5d55441so91872439f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 06:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717679155; x=1718283955;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mds6YO+HTZDWBYnzuTDKxSNA9F8P/HeS82JmjodgFU8=;
        b=tbYB811AxXhY34ssucIasEySdsJCwebzPG4Xvh3ZFQ94JyWGrrH6h/ot5IZFHa3a62
         n6VkUFR5VYuOa498lKvDaR3QlYYH0FoyYRbKwfj2ze6dCp+rgUMUs8GBkLFOhW0Jpx0N
         VZ6GWdIRKIkEzfR6/P2LdQOCV1zO4SQs6l4ucx39eLnpHxDjKX36El4G9JvNouDRXLUA
         MGEaLgfI2rDKaa9L2ad/CL/h1GBJWnP0TQJ9MuW62IBnFEVWOxmveDWn2z4+xt4CPdoK
         1QCAZnQibdu5yTMOFoXFoDKvZyIRnE7PDftV/U/P2jc8eVvw3eqNVKjoFxCROaV0ytzg
         bTbA==
X-Gm-Message-State: AOJu0Yz4V0QKaaGZoYGJ4CV6vrLd6jyg8va4/w1rVR9YPLGufb52VTQ6
	Lv0a2OTCW7k5mzUKyMy/ufsbMZEIcAIGjqwpgrA0ZzrWI2irpBIwIHN44Swg0lNGEDMOa2uoNBN
	ZA9L2aPVb+2+98FyfFLWIGmy1fvb2tm11a5G7xq07uLZIsp7h2nmEBvc=
X-Google-Smtp-Source: AGHT+IHJNQqRrETHsbsE4xCLExeB+43y2rsxwo47WOoeITfOMRHErt0OhoiLQtMxbTfEWW887yiDNMPTDf2A7Wsq0gYIHnkJ7XWx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3787:b0:488:9fae:e95c with SMTP id
 8926c6da1cb9f-4b63a8f6dbfmr158845173.4.1717679155102; Thu, 06 Jun 2024
 06:05:55 -0700 (PDT)
Date: Thu, 06 Jun 2024 06:05:55 -0700
In-Reply-To: <000000000000adb08b061413919e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e0e0e8061a385789@google.com>
Subject: Re: [syzbot] Re: 000000000000fcfa6406141cc8ac@google.com
From: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: 000000000000fcfa6406141cc8ac@google.com
Author: wojciech.gladysz@infogain.com

#syz test: https://linux.googlesource.com/linux/kernel/git/torvalds/linux e=
377d803b65ee4130213b3c041fc25fdfec1bd90

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 2d29bc0f21cc..75fdb8e3abaa 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2393,12 +2393,21 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, =
u64 *args)
       cant_sleep();

       // return if instrumentation disabled, see: bpf_disable_instrumentat=
ion
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

--

The information in this email is confidential and may be legally privileged=
. It is intended solely for the addressee and access to it by anyone else i=
s unauthorized. If you are not the intended recipient, any disclosure, copy=
ing, distribution or any action taken or omitted to be taken based on it, i=
s strictly prohibited and may be unlawful.

