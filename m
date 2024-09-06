Return-Path: <linux-kernel+bounces-318871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E218096F467
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09F511C21D0B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6312F1CCB52;
	Fri,  6 Sep 2024 12:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QTMvNC2T"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF05F1A2C39
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 12:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725626282; cv=none; b=WC2lWyTWF7WuNsXhxkdzDiuuPPTkRRtni4SsYtTyrg8sGB8Qo43v2bySNe+n43tDQMgXfB8psXPwdA8+AuY4ekYcNlznlfOTvt+Sd2NjYubiF9RqhxQClI/lrwh/dm0klpu//mz3TZheieSKuYTxw+QoMPUr2FbgCaf1WD8MNR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725626282; c=relaxed/simple;
	bh=fcJp1ZOKvXdSnXlp8wx4an5hODi9GGbQyh3ieC1QApI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qe8doPrQyeEvS1w7xFQdtvoQk0/R5AwzTQPAnfXi/EMTu/IYZPRIy+K9wqDdrVj38Siuc94qj/3uBQKZ9O5Er0gGOTF9n2/VfRBv071xRdfJmGH69iio+eWtdSvebBvjStPMp0lVvXhTn0n1c74THIt9v073hXeaXHVMz2lBxdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QTMvNC2T; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5365aec6fc1so550680e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 05:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725626279; x=1726231079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBoCwhHh9x+t+iM9tHXE8bUqB+lSYS06eBNob9BYVJs=;
        b=QTMvNC2TuBsUY3B2rArzAevLFzxF+bNkCHy2z2Lcf80L3jNwl89KzSb3DhyAYzKJgL
         dCT879K8rP431gwEJF1upEGxPVu34cf24U61Mg7QjVQjEXEL/7NeEMqOVYSNw03pjycQ
         6apAxkxv7WVIj5yi/jJS3Sd6X0r6d/SDr74qzXOeioUT+90MXBFLgpTRzUxBS4q9QXKq
         b8oQnCJZiiS/PetOz88bqpH2KhZYUz3xRUf5adNQMDywCXwDzx/yTmkbu9tWh1qeMOB6
         qfqZh3qyV4QOYVYMlhaiObD8mPdSJXdpnXdmTU+OFqBkOH2BSMY8KKtSdwUxMF8Rxkgi
         X+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725626279; x=1726231079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBoCwhHh9x+t+iM9tHXE8bUqB+lSYS06eBNob9BYVJs=;
        b=b1omHPsSMPeRQ00nLVazvuJBwHFXZQhaRRGjAMbPHF7T2gLpT9DCdXAHYMaLVVngB1
         +1daYQYDj463zukcHSdFmc96FuecaLEjiiifus+Wn+Uik0foj3gAgLafBVM5M8okOmCo
         Kr4BqtjVlL8+MTmrJNB4bRth/TLE1+qBbF2bqwIn78NmivnKYNt+7zi6h/qtSDR9dNyN
         i3z5SWYM5TTlB9v54u7cxieIvJ/5tpuqBGMyXsTOGFIyUp/zsNyc+qGt93EIRTGlTYuK
         Ojwg6vqDfRz6okxeYHsnQujfmwdsvOzmE9WI0zOfULN+RA+7W1FtGwJQT8iTa1ZBKq3M
         oSMg==
X-Forwarded-Encrypted: i=1; AJvYcCUQcemf46r+z/i6ydOceS82Her6SwU05sifDtk1GsL0K6i8hH6fEoontFEfAExGYdfJNgc2NdLVqLbwVQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjxtcFkqyFTdpBZzCwWvU7SufnEhck7I3hbLTKA19qbkMZOyV+
	8t3yEEpLXnuDziqvBi9oFBY2Xn8dzPXTUP1MyU1V9NyzfAee5cW3TLj0YTGrKXy22B70OUnlvSL
	IyCdz7X0XsWaOQIy7Ap46XJcMnhGcNNx009Zv
X-Google-Smtp-Source: AGHT+IEqRU6xx51Wle+UnqzMApvSGlOkX0POMQLgoq/9XnkwqQe5L0z8+I5vFW8vVqYhZBE4x5LOvtmINeogQxoVzlo=
X-Received: by 2002:a05:6512:2395:b0:530:e323:b1ca with SMTP id
 2adb3069b0e04-536587b4093mr1895574e87.25.1725626277918; Fri, 06 Sep 2024
 05:37:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e500b808-d0a6-4517-a4ae-c5c31f466115@oracle.com>
 <20240905203525.26121-1-kuniyu@amazon.com> <19ce4e18-f1e0-44c4-b006-83001eb6ae24@oracle.com>
In-Reply-To: <19ce4e18-f1e0-44c4-b006-83001eb6ae24@oracle.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 6 Sep 2024 14:37:44 +0200
Message-ID: <CANn89iK0F6W2CGCAz5HWWSzpLzV_iMvJYz0=qp3ZyrpDhjws2Q@mail.gmail.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in
 unix_stream_read_actor (2)
To: Shoaib Rao <rao.shoaib@oracle.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, davem@davemloft.net, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 10:48=E2=80=AFPM Shoaib Rao <rao.shoaib@oracle.com> =
wrote:
>
>
> On 9/5/2024 1:35 PM, Kuniyuki Iwashima wrote:
> > From: Shoaib Rao <rao.shoaib@oracle.com>
> > Date: Thu, 5 Sep 2024 13:15:18 -0700
> >> On 9/5/2024 12:46 PM, Kuniyuki Iwashima wrote:
> >>> From: Shoaib Rao <rao.shoaib@oracle.com>
> >>> Date: Thu, 5 Sep 2024 00:35:35 -0700
> >>>> Hi All,
> >>>>
> >>>> I am not able to reproduce the issue. I have run the C program at le=
ast
> >>>> 100 times in a loop. In the I do get an EFAULT, not sure if that is
> >>>> intentional or not but no panic. Should I be doing something
> >>>> differently? The kernel version I am using is
> >>>> v6.11-rc6-70-gc763c4339688. Later I can try with the exact version.
> >>> The -EFAULT is the bug meaning that we were trying to read an consume=
d skb.
> >>>
> >>> But the first bug is in recvfrom() that shouldn't be able to read OOB=
 skb
> >>> without MSG_OOB, which doesn't clear unix_sk(sk)->oob_skb, and later
> >>> something bad happens.
> >>>
> >>>     socketpair(AF_UNIX, SOCK_STREAM, 0, [3, 4]) =3D 0
> >>>     sendmsg(4, {msg_name=3DNULL, msg_namelen=3D0, msg_iov=3D[{iov_bas=
e=3D"\333", iov_len=3D1}], msg_iovlen=3D1, msg_controllen=3D0, msg_flags=3D=
0}, MSG_OOB|MSG_DONTWAIT) =3D 1
> >>>     recvmsg(3, {msg_name=3DNULL, msg_namelen=3D0, msg_iov=3DNULL, msg=
_iovlen=3D0, msg_controllen=3D0, msg_flags=3DMSG_OOB}, MSG_OOB|MSG_WAITFORO=
NE) =3D 1
> >>>     sendmsg(4, {msg_name=3DNULL, msg_namelen=3D0, msg_iov=3D[{iov_bas=
e=3D"\21", iov_len=3D1}], msg_iovlen=3D1, msg_controllen=3D0, msg_flags=3D0=
}, MSG_OOB|MSG_NOSIGNAL|MSG_MORE) =3D 1
> >>>> recvfrom(3, "\21", 125, MSG_DONTROUTE|MSG_TRUNC|MSG_DONTWAIT, NULL, =
NULL) =3D 1
> >>>     recvmsg(3, {msg_namelen=3D0}, MSG_OOB|MSG_ERRQUEUE) =3D -1 EFAULT=
 (Bad address)
> >>>
> >>> I posted a fix officially:
> >>> https://urldefense.com/v3/__https://lore.kernel.org/netdev/2024090519=
3240.17565-5-kuniyu@amazon.com/__;!!ACWV5N9M2RV99hQ!IJeFvLdaXIRN2ABsMFVaKOE=
jI3oZb2kUr6ld6ZRJCPAVum4vuyyYwUP6_5ZH9mGZiJDn6vrbxBAOqYI$
> >> Thanks that is great. Isn't EFAULT,  normally indicative of an issue
> >> with the user provided address of the buffer, not the kernel buffer.
> > Normally, it's used when copy_to_user() or copy_from_user() or
> > something similar failed.
> >
> > But this time, if you turn KASAN off, you'll see the last recvmsg()
> > returns 1-byte garbage instead of -EFAULT, so actually KASAN worked
> > on your host, I guess.
>
> No it did not work. As soon as KASAN detected read after free it should
> have paniced as it did in the report and I have been running the
> syzbot's C program in a continuous loop. I would like to reproduce the
> issue before we can accept the fix -- If that is alright with you. I
> will try your new test case later and report back. Thanks for the patch
> though.

KASAN does not panic unless you request it.

Documentation/dev-tools/kasan.rst

KASAN is affected by the generic ``panic_on_warn`` command line parameter.
When it is enabled, KASAN panics the kernel after printing a bug report.

By default, KASAN prints a bug report only for the first invalid memory acc=
ess.
With ``kasan_multi_shot``, KASAN prints a report on every invalid access. T=
his
effectively disables ``panic_on_warn`` for KASAN reports.

Alternatively, independent of ``panic_on_warn``, the ``kasan.fault=3D`` boo=
t
parameter can be used to control panic and reporting behaviour:

- ``kasan.fault=3Dreport``, ``=3Dpanic``, or ``=3Dpanic_on_write`` controls=
 whether
  to only print a KASAN report, panic the kernel, or panic the kernel on
  invalid writes only (default: ``report``). The panic happens even if
  ``kasan_multi_shot`` is enabled. Note that when using asynchronous mode o=
f
  Hardware Tag-Based KASAN, ``kasan.fault=3Dpanic_on_write`` always panics =
on
  asynchronously checked accesses (including reads).

