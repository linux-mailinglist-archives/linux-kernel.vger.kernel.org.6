Return-Path: <linux-kernel+bounces-204334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603A08FE75C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75D631C2566D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E3A196442;
	Thu,  6 Jun 2024 13:13:38 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C1D195FF8
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679617; cv=none; b=BBQA0MhWmVFSCtN3wt5KjpSXKnkiQNp8i+REY45WJ9FMwuD1lz6dPf9MEaYChtr74DKS9x13sctflAUDyNIaMflcFk93/dmP01A2nbvomQ/+uozfUJPgQAB6qz5+fGVWhy3wOo3GbFFQifGJ37nJAwPAK/f3OYriawZB/O3Pvf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679617; c=relaxed/simple;
	bh=N2TKFtZ84LRcvYpdrCo10KPBU3suJ/SBKprpElXrfuU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EcWY9jseAQE45VjDFaUcCNxa76k0s4vilUMF/Y5hAIoUszZ6nzvuZKkxJJcNZaZ0u5rzNa4jw3PFmJjgAEVVJP7HexUmAUGBw5kV4K91I7CUjIFtb2FCmbUTb0KJeyOiW9mKcdenWbF8SPwC2GbX1qOYigdlkQj5FuIiBd8t0XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3737b6fc28fso15241575ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 06:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717679615; x=1718284415;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3Wnx1/I5BhG3rHbSdQNtijPyY7wX8WKT6tGxHvilw8=;
        b=YYQIXBAmmRtc47IUO9u+5DH2nqRqqjRZvSFSkIjMwTi4uhYotGlWlO7Lf/8Jhmv/Gc
         0oIJ8NhwvwuvXntM+4spEHVQyyIWL7zmSRLes3osuYQhsCBQ6n57P3NnUJhzFYJu2SZW
         wS/q4XvfwFphvevcbOcEG5Gu4B5vVklU5ijyWu8N2kFFP253/sm0VYB47ZwMKKxuKeQd
         rjzVB7JPSEyi6Zi23lmlF6Z1imxYoo8z0TTe23E7bgGBIU2v8NuvZdx0WHu/OerkLo6P
         JYC+gxh6yETICViCzuptSVz6S4P6OUAj21kHRzhZ4+ISFBknKwCszwFUI/zh+BCdNx3u
         4aVg==
X-Gm-Message-State: AOJu0Yx88bjQ0AJMtCSX0ULQ8UM5ur9pmFw5onUwNbCsgnTd+EwqodO3
	ZVVAyIrG9+uCwzWF0jGSOEZm7xsBAm44O5YrFcyhPEADAlSwt877OPy+9vllVePDO36cwW0C8/1
	hGx8OCHAMLIBfMls/Z+IOhC55B/IoitmHRp6IXFl9TfhKjpoNF2VSyaw=
X-Google-Smtp-Source: AGHT+IEyDhTOPqoCjBvkG99kv7W3qeZsXTBkh17jelXfYIm7qQbL2ufKrSno5DgT7t+8sOLsrSFWAtQHWO4fNQiZdE1jNmQ+5RXA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a08:b0:374:8cfc:4160 with SMTP id
 e9e14a558f8ab-374b980f6bamr1631925ab.3.1717679615593; Thu, 06 Jun 2024
 06:13:35 -0700 (PDT)
Date: Thu, 06 Jun 2024 06:13:35 -0700
In-Reply-To: <000000000000adb08b061413919e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000535de9061a38730a@google.com>
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

