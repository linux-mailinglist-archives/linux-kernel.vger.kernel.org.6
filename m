Return-Path: <linux-kernel+bounces-387961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FB39B5874
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 01:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D53BD1C2298C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008FD10A1E;
	Wed, 30 Oct 2024 00:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="et+lIRlK"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BBB12E5D
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 00:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730247425; cv=none; b=blUFDuDpzkgJtVx7CgmbkbvWxFtdEh+DcS4il3dUA+AIOYhxc90wflGLeODvS6GsPN8WmaI70hnB08VotlXjj4umaE/+yJD8CNi/mn3dsJ3z2WIrjkwgGsX2uyTu3Aa6D08uVudeRCP/gRpepAVQSPG80zQWruwkFEwcvv0owU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730247425; c=relaxed/simple;
	bh=kL+nSJs/k5eiTKkckVjqUhseoyaNVTxIYCNgVKz9HcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OHezEeN7mvlyjbT+ldeOtJBX1GWo336SSX/4fF4DdePC4nTWldnw7ryMViI8GCEaHa6N+HdRKYBjlWu8r8ga84urfjwfWwXP6fL9F7wGq7MKCXvQh7xgjuascLaYgpbfz7wr3clvCsmfJmwQTOV/jlJ8IRXzgpbQ+WDOZhQ0Mko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=et+lIRlK; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4608dddaa35so81261cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 17:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730247422; x=1730852222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCmWu47sjTGX3jar/Dwdhp+9K5zVvqpEnsEiRnQbuZ4=;
        b=et+lIRlKegBfC2h9/n31J6d8TJkbDu440N5TWTD2sNhhoMXP6vXEOMh/inA93j6+F4
         3DKkwv73/9t3NJyDIhv7jzemF2eXJg52P1ihLT74+/JXi0mWUeMhWG6qc3u+23ST3ebS
         U3OHCEnqPzwjWtDThAAH611SkFBuqkumpinc/ISUBCuOZu5yUTrNox1dpJ+4h0SbzhOS
         +SX/RqoypTPdwbV49RETbQL/htObPWplcinnvwcrw8vwp4JP0FFTsS4veGJK59w8BCYr
         wT0rwWxwDaw0dQ/Udb1H+q/AGncW8O2b+boe9voF0/54KyXRoNJ5CEOQw/sDUCzwhMe3
         beGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730247422; x=1730852222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCmWu47sjTGX3jar/Dwdhp+9K5zVvqpEnsEiRnQbuZ4=;
        b=BgcCpytlIuAZXugxt18M3tVdYuMXwJZnz69BOgNdW/JXSgyblzqgp7v2Ru5ZhK5zqr
         iCxU3qx66157UfEjZ4LQNhnrDZVvr7aO7nJcffmfpOcOjBv7Xtul4kj1gSqnuReSL3uv
         JbLtlrICls8G430ypZJ4q+sM2FIL72JIYVFEa4f1MGKlq6LZCR+182nW43kzuB15Txdj
         QH8pbQhuONRQ/SGXOVyhPU+gy9oqpOb9q3xHsWY+UEMkwwRiAH80HZDsKGz/B1yq+76O
         XMdybzkN0my+Kuv0uYgZ8nI0eYWvraY6M2WDGt5zKfwplQIfwowUlVPdWN/EcV+dqHMs
         Z/kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQaTdHlRU3jotPGvUIKQri+01+AB6uERS3um3vMAPsTmfCbOxk3BwlBaD5yIT7W+DwPcOXaDPCmA+fwyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQFtywjGi30X5A56LAKnFO701vOYGDtQIkjSs3BsvCmLgEfE3w
	9R3UXmdABW7/XZ7qFteRctTbNtSU/7SkgzHaZK0P4dSMR1qtRtYxQ2Xx8Devu2IRst4m8WdENp4
	zvVyxuXaGjZgYp7o9NZkd62qfcap/++Up/jxs
X-Gm-Gg: ASbGnctXM5Rdtpv5A8DfiH7FHv+FW/2Y4IZYik6bGqtNw/ssAQo1+maNXNUKxTXpony
	0v0HuALZ4n3/SMMK76TP9XBfs4z8e+55iquETt04kMzoFoDeNBMCZJmoAqLCdMqPT
X-Google-Smtp-Source: AGHT+IEaPibastFimQxIGHeancJlv6kb2dWI4ioRIOkCpZsX0edKkHwzu5czUo3lz8BTR5AsStAJ1WI8kMngUNb28NI=
X-Received: by 2002:ac8:5d91:0:b0:460:48f1:5a49 with SMTP id
 d75a77b69052e-46164f057c4mr6157321cf.14.1730247422165; Tue, 29 Oct 2024
 17:17:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028234533.942542-1-rananta@google.com> <868qu63mdo.wl-maz@kernel.org>
 <CAJHc60x3sGdi2_mg_9uxecPYwZMBR11m1oEKPEH4RTYaF8eHdQ@mail.gmail.com> <865xpa3fwe.wl-maz@kernel.org>
In-Reply-To: <865xpa3fwe.wl-maz@kernel.org>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Tue, 29 Oct 2024 17:16:48 -0700
Message-ID: <CAJHc60xQNeTwSBuPhrKO_JBuikqZ7R=BM5rkWht3YwieVXwkHg@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: arm64: Get rid of userspace_irqchip_in_use
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 11:47=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrot=
e:
>
> On Tue, 29 Oct 2024 17:06:09 +0000,
> Raghavendra Rao Ananta <rananta@google.com> wrote:
> >
> > On Tue, Oct 29, 2024 at 9:27=E2=80=AFAM Marc Zyngier <maz@kernel.org> w=
rote:
> > >
> > > On Mon, 28 Oct 2024 23:45:33 +0000,
> > > Raghavendra Rao Ananta <rananta@google.com> wrote:
> > > >
> > > Did you have a chance to check whether this had any negative impact o=
n
> > > actual workloads? Since the entry/exit code is a bit of a hot spot,
> > > I'd like to make sure we're not penalising the common case (I only
> > > wrote this patch while waiting in an airport, and didn't test it at
> > > all).
> > >
> > I ran the kvm selftests, kvm-unit-tests and booted a linux guest to
> > test the change and noticed no failures.
> > Any specific test you want to try out?
>
> My question is not about failures (I didn't expect any), but
> specifically about *performance*, and whether checking the flag
> without a static key can lead to any performance drop on the hot path.
>
> Can you please run an exit-heavy workload (such as hackbench, for
> example), and report any significant delta you could measure?

Oh, I see. I ran hackbench and micro-bench from kvm-unit-tests (which
also causes a lot of entry/exits), on Ampere Altra with kernel at
v6.12-rc1, and see no significant difference in perf.

hackbench:
=3D=3D=3D=3D=3D=3D=3D=3D=3D
Ran on a guest with 64 vCPUs and backed by 8G of memory. The results
are an average of 3 runs:

Task groups | Baseline | Patch | Approx. entry/exits
----------------|------------|--------- |------------------------
100              | 0.154     | 0.164  | 150k
250              | 0.456     | 0.458  | 500k
500              | 0.851     | 0.826  | 920k
(Total tasks for each row =3D=3D task groups * 40)

kvm-unit-tests micro-bench
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The test causes ~530k entry/exits.

Baseline:

name                                    total ns                         av=
g ns
---------------------------------------------------------------------------=
-----------------
hvc                                  20095360.0                          30=
6.0
mmio_read_user           110350040.0                         1683.0
mmio_read_vgic              29572840.0                          451.0
eoi                                        964080.0
        14.0
ipi                                   126236640.0                         1=
926.0
lpi                                   142848920.0                         2=
179.0
timer_10ms                          231040.0                          902.0


Patch:

name                                    total ns                         av=
g ns
---------------------------------------------------------------------------=
-----------------
hvc                                  20067680.0                            =
306.0
mmio_read_user           109513800.0                         1671.0
mmio_read_vgic              29190080.0                           445.0
eoi                                       963400.0
        14.0
ipi                                  116481640.0                          1=
777.0
lpi                                  136556000.0                          2=
083.0
timer_10ms                         234120.0                            914.=
0

Thank you.
Raghavendra

