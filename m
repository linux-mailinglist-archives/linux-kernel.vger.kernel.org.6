Return-Path: <linux-kernel+bounces-176783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6705A8C34D6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 03:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDFC21F212C7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 01:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF4F63C7;
	Sun, 12 May 2024 01:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUEYYiRA"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E0E2F41
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 01:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715478039; cv=none; b=eaPIqAXHB5roLzSh9aWybaq5wC8ETVOPHqj3jje/JCIQoS1L3OWw+ckauWELqhYW4/2VfbWH5rKT1gYJpxVBOu65aPz5P7pY7pycDIWohoqOhAhXgbMxIA44oxyYHxRXcBPcCs55zhle8Gqh2T3Vh9iDn02WaY0N3TgPfJb0S+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715478039; c=relaxed/simple;
	bh=5sMHG0JcscwjTcoGWdmOOYLNkF3DEBYMdX0qDG8OcrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ThIB5xw4DXDlFxfNDehopThQGWUUJg/Aq7+hdPbRl5yISW1X/W4d0E/zyBvt9dsDU4Bzll0VmSPVIlhpVq0/Swi0soFPBh5IHEEC+0u8r0wyEztTwfo2cBUSinYIz/C8i9A/kJtyknHmO2aEILXSu+dEgCVSEg8EOturlkq+cyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUEYYiRA; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ee13f19e7eso2933710b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 18:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715478038; x=1716082838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sMHG0JcscwjTcoGWdmOOYLNkF3DEBYMdX0qDG8OcrI=;
        b=hUEYYiRASpkF/k933ZfyMgOcfj05ra7imqoAjPaHNLBHGoKeZlHsRdsOPt2cZmCYS6
         ATsaPfpZhztixIl9CAN5XjADFJU+3Q127Ypl5Z88Vjz678H81bgo/Wf0r/JxtnAfGtYp
         bqSpCE2sGkxTKnwBtLlPUJ+kkrKS47BMYU9qjLx2oCVylm9+OBYN7f8+R0rlX4C5lDVR
         HFT5TRx49TCTj9gczJAIvfDRUD4FVY7l3AYZzpFUgrdYtMLXJeI1yrHMG+UoikR6wsK3
         /1yoQXuk4L6fGxNx55FZmhw+3naqBI8PUZjGQjrSFsdJ0v4L8Af3EDFIWEeJTVlR24wg
         4Z1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715478038; x=1716082838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5sMHG0JcscwjTcoGWdmOOYLNkF3DEBYMdX0qDG8OcrI=;
        b=EnOGA+OLFPyYXX0DVh64j0R5jQOW5t0+1RP5EaFgefzhCzt6QqRNIJqMmjiNCuC1vi
         LcvW+AFCZFxIlr1mfXJfSZriUIOYFJs4Jb1xmhA1awk8NgyNNRsmnqYch2qpHl8E9/wm
         IsbnVGJHIV51TZlbyADmjCF/0DsQERYeLIb6KWcCzLI6729/OlrhhkIRWflkKmtShhJc
         GRe/AFIIlz7hJuawE7XSBfRVqcRTg14MslaOtrqSys4xdBrX+0aarkmt4QPMfKBeDPPD
         lkvgKND8PMYBtzUhIYMjHhT/T4/lYb8q2a0WC/xgDJEhBpLH67TUb1GCQMXcecd6hrM2
         o/yA==
X-Forwarded-Encrypted: i=1; AJvYcCWwsnNc9HyC/7+1Dm6REnsY4kNkYY8KHAlmLdG1Fhqtt+Po73t2UpWz3KtwYGOCDq+igDVYy83jFvWmt/c1vI97hoYxXI0TMuIlcv0U
X-Gm-Message-State: AOJu0YxXiLXVlVqzKRezIRGbX6e7Cmx7YNoNQ6z3sZBNMNTdu0VrwshO
	Ws0IpeVOMM/F8NmYFeJ6VJYnzj4U8H4rCzZtHO/XiIkcx7mAFjs15LI8siMJYLT07f1nSAV0WRI
	SmH+SYqYbdaSAc2m4dqPVbNkABOs=
X-Google-Smtp-Source: AGHT+IEmTb6SlGvJjwlF4u7khuUy7kOUh3WBQ0ZHisS5F2p+YsagA7B+I3vrMbMVZlVXw88T6USjM8QeP01VJSVjD5k=
X-Received: by 2002:a05:6a20:565b:b0:1a7:919f:2b60 with SMTP id
 adf61e73a8af0-1afde0f3a28mr5999599637.37.1715478037580; Sat, 11 May 2024
 18:40:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABOYnLy5WHJBjk33pzr12w5e7CDGb43LhQ5zQow0on4pCYusjw@mail.gmail.com>
 <20240511233404.2764-1-hdanton@sina.com>
In-Reply-To: <20240511233404.2764-1-hdanton@sina.com>
From: lee bruce <xrivendell7@gmail.com>
Date: Sun, 12 May 2024 09:40:26 +0800
Message-ID: <CABOYnLzuu=i42tX-VSbTKJBfU=orsXa3Q5kCELOCsOFZCSdAaQ@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] KASAN: slab-use-after-free Read in
 kill_orphaned_pgrp (2)
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot+68619f9e9e69accd8e0a@syzkaller.appspotmail.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	Edward Adam Davis <eadavis@qq.com>, clf700383@gmail.com, michael.christie@oracle.com, 
	mst@redhat.com, luto@kernel.org, peterz@infradead.org, 
	Thomas Gleixner <tglx@linutronix.de>, ebiederm@xmission.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi.

Hillf Danton <hdanton@sina.com> =E4=BA=8E2024=E5=B9=B45=E6=9C=8812=E6=97=A5=
=E5=91=A8=E6=97=A5 07:34=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, 11 May 2024 22:45:06 +0800 lee bruce <xrivendell7@gmail.com>
> > Hello, I found a reproducer for this bug.
> >
> Thanks for your report.
>
> > If you fix this issue, please add the following tag to the commit:
> > Reported-by: xingwei lee <xrivendell7@gmail.com>
> > Reported-by: lingfei cheng <clf700383@gmail.com>
> >
> > I use the same kernel as syzbot instance
> > Kernel Commit: upstream dccb07f2914cdab2ac3a5b6c98406f765acab803
> > Kernel Config: https://syzkaller.appspot.com/text?tag=3D3DKernelConfig&=
x=3D3D6d14c12b661fb43
> > with KASAN enabled
> >
> > Since the same title bug is triggered in
> > https://syzkaller.appspot.com/bug?id=3D3D70492b96ff47ff70cfc433be100586=
119310670b.
> > I make a simple RCA.
> > In the old-syzbot instance the bug still trigger the title "KASAN:
> > slab-use-after-free Read in kill_orphaned_pgrp=3DE2=3D80=3D9D and in th=
e lastest
> > syzbot the bug report as
> >
> > TITLE: WARNING in signal_wake_up_state
> > ------------[ cut here ]------------
> > WARNING: CPU: 3 PID: 8591 at kernel/signal.c:762
> > signal_wake_up_state+0xf8/0x130 kernel/signal.c:762
> > Modules linked in:
> > CPU: 3 PID: 8591 Comm: file0 Not tainted 6.9.0-rc7-00012-gdccb07f2914c =
#6
>
> Could you reproduce it in the next tree, because of d558664602d3 ("vhost_=
task:
> Handle SIGKILL by flushing work and exiting") adding reaction to signal?
Ok, I'll try.

Best Regards,
xingwei lee

