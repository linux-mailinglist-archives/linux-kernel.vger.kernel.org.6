Return-Path: <linux-kernel+bounces-204356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4BE8FE7AC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2ED01F24157
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523C1195FCB;
	Thu,  6 Jun 2024 13:24:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86992195973
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717680244; cv=none; b=diHfFH2iGUxx+l7FyDuJXsMyCv3l0C5uthtMqc8eLBgMhlTf8kH6hhdGx6Mpt3nDoOD3yYTIfdExiAaMDhvBm/jY/ES8nzjqFROyBVHpy4Yh2fffbpYJInJ+01leOy/016LJsbNcnBcjHBRrKdDwJfqFVVpKQbLcK9l3shDs/ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717680244; c=relaxed/simple;
	bh=7f26wen0QFpSjQJgMpxsD7nI/sETwjE/NfJJVswG4z8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KwLWk+MIiUEAxTPLTe4yAcX0DwsKC0t1dhqO3ZP0V0CyDe3IPHOxqLiNTxSnd9UU2VEIi0ZASrFneR/uBofOxdvi+5MmVbLm78ICb8K5PXOEuJJ4wtcDZG/MENfD2TU0SSLYaZTGcRUMy38fQEDhxiK5fS4KvMGuyAn1dDKBSjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e92491e750so57675639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 06:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717680242; x=1718285042;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cN2gFw1REYRRysfYPSn2zWfWFPFbNqDCxuEWS+aG9A=;
        b=pFURoIVnQb4kn6JXJSACbv/DxDyEHuHn/mJgNXW4OYEgfo7iDhquYQko+1XxZioC5P
         fgR185j/tk9miL7Qwr5YPU5ymvJ1vpebdVcSnZWv1/DTnshokQU4TMe1pIuLri/6pIjJ
         aODTkg1cMKR+d6e61LJtO02/x4CCc6sHBCZnFdetrQd/yF2B9K7gdvxfJxeOfhZQP+5V
         /QKaeC5M26IXxCRAYBnG4ambd9DsysRySAClBm6ZHQ1LUr9KzeRzR9nmjw73k2VOsjFe
         sBE7uNRQxLTUx+7sTwYjVaIQlzk9/vw2iZPNTnNSvWa1aoI0zd0zfL9uP35WG0+2ZBA5
         M5wA==
X-Gm-Message-State: AOJu0Yw4Y6JkbO8EZZES7bUdEJ0bdR4zbvUEFv1AlPY1xqDL9+Xb1k4w
	77B22AEGlIreeBxND3c0AvHlri/6gGXIgJiajiF15ZzpaoPdGtWn53w9b7KF01M0ZLoZ+dSjews
	TL5xSOwsZi8RhGisq/NsXmb+bpmEd2/O5KPF8YINp+b3Ew6+G9bCbmwU=
X-Google-Smtp-Source: AGHT+IEh9SoZHVSqu7m658XfUNOb8q+kAgtseR+mpz1GID5F//1TLqt0O0ABudsvd4q7Md912N+SjMAecTdp58BNOTLxSPGs3RkC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6c10:b0:7e2:2f0e:5a65 with SMTP id
 ca18e2360f4ac-7eb49d96bd2mr13908339f.2.1717680242702; Thu, 06 Jun 2024
 06:24:02 -0700 (PDT)
Date: Thu, 06 Jun 2024 06:24:02 -0700
In-Reply-To: <000000000000adb08b061413919e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b447ac061a3898ea@google.com>
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
+       printk("%s > %s > %p /%i\n", prog->aux->name, link->btp->tp->name, =
prog, active);
+       if (active !=3D 1) {
+               printk("SKIP FOR ACTIVE: %s > %s > %p /%i =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n",
+                               prog->aux->name,
+                               link->btp->tp->name, prog, active);
                bpf_prog_inc_misses_counter(prog);
                goto out;
        }
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 8d1507dd0724..f852d7b86ff4 100644
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

