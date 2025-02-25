Return-Path: <linux-kernel+bounces-532164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E698EA44980
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91E36423665
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05441A2567;
	Tue, 25 Feb 2025 18:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="iN/giNmi"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734991A23A2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 18:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506510; cv=none; b=k0Xi+M5GDOaHLfQG8/VFoKDKxTuKsiGQKIlk/I+lC8raryqbnSPHiOlOFxjxHLnM5cPn3U/h7QJsj2lKFRPGSjRA9dOi7obG02l7ohzn1/CZByqHvdaHH6renNgO0oducd/F8UhOmTEyQ0NQ5hvwB9aFD6qo49WlyIVCA1cOsZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506510; c=relaxed/simple;
	bh=eN8WAEhM7Ge5/3WbLhZpM8XyIp/WPlfFziGBxV4U1hE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DjJn1YTTREIyoTLXKMJEmV6MpDEoAAldpxSRDZEGG3BeJ3Gs5Tst8l9hzPfDplsS9L5hxohQxE/7coij0in7Nn8xVFBrsN7uj4mIMfi7Hchpsr9nl09mz3DybLV1rneHbvr5v06hwH5jJfNXfwVMSArMwqvPr1C9drNpk4wPkDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=iN/giNmi; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7313141231
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 18:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1740506499;
	bh=Tv3umwpE5/GP9J0PpmtagU4j6m0CkEYII7EQbIkEyTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=iN/giNmikYSE24mqRJE7/0yAeQP00NKyyLtcorjv+p+Pq6bDsoIREfCk3TSD4yi+l
	 gMfabDH+Jse2FKr8Ny+DzO14x1WGpLAM18s+JLhAEkLwwj1MRO4FH482L8OTvZUhfZ
	 eytEioKOE2avEUu3Sa4VifOgkg+GbuQp5VVXzdqy1s9IDz2ArF2idrkfVAIRCarq6l
	 H4tGpMH7URyirvCtdt72TPi0kVN2/Qcv28wrCnc42mce07ZkQOb/I/CRA22M87T0qA
	 jRI6qGjziOqar4pCs2r7hnXTR/8fpFhiVdN/wF7+SgMYAaOoCImdzY4vA1DbfeDXLz
	 MnKNGlH4uP0uA==
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-520aa56a821so1173177e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:01:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740506497; x=1741111297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tv3umwpE5/GP9J0PpmtagU4j6m0CkEYII7EQbIkEyTg=;
        b=pQ5gMorRsVRvOTQrY0zqiE1bOS4vAeXfyJeuxhu4g23nKc9TbsSRYTSb9pfypUuvhw
         WGDFrCQ+6Qy//oysUqqUeuYcPL3FBSzoZFkC3v7jzRQuxOwmL0D8X6Ne9Ou3ynfNzHGu
         ahNcdQaPf8+wYvO8lSFz2iSCGLDh+rkv0wntxg4JiF543AmrvVX8iJMCkPAvytZMsZYv
         6jPkxoHA58ELVoIz1vtxLW1p54PnX+KhYUUC8tam6GH2aUBc05ulPhFSRsrPy9Ly1gpU
         g8CToxAEjjxy5OeXafRfCsUltGKWIawi06PbTi7xTZ+Zk5Dsf6t0hC0mKv+kA8UuDCBk
         i7VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVc7DWYbCayoRt4wNNJqSliDAzTNU/Fc8yP5Ago6qiyYdiNyaHmNeJDiltECwQzD5phwlfoCOCAQqQLFGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YylXDXujbHST11IKQdSXYR0xS3CF62J19Og9AM47GNhGC7lYvGx
	d9DP+1FN0w6/AZDmbimUhPBKVK/im4toCcOU2yMGEt7Vzh0fbvWaKO8mfd28X4iigxBbb3T1pz/
	C/Ejaie9WGmiqj5vdu46RNyLfLw5mliXhOWBwHwKN+3PZK9qm93sc6mfH1L9Fw6VWGyoqD4IDbL
	e5mJ2r+O2UngviyLp8UePbQo7ywVgyH5Wv5ThnPeB8jXueV6il6du0
X-Gm-Gg: ASbGncsyQqoZ1Ff3ZcAfc89qgOMbIMf5U6nMdsz6lwOPJ6l19tAxNBrzbaOId2UonIr
	fF6yOqN3XwxWkiEDiAhdFaASHZTgODZRYpb5hw9XOLwEWwp2sSA53nP0vaasvA5q/VsE+tnVMjw
	==
X-Received: by 2002:a05:6122:490b:b0:520:5a87:66eb with SMTP id 71dfb90a1353d-5224cbd91c0mr277730e0c.3.1740506495895;
        Tue, 25 Feb 2025 10:01:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqwFiH9s4gWTFOf3Se2b5HJeV9csUD3pvgqhNJd2pxJgulYnyk38u1/n+e2g+0wQbw8tg/qWt3hY14zYe+RFA=
X-Received: by 2002:a05:6122:490b:b0:520:5a87:66eb with SMTP id
 71dfb90a1353d-5224cbd91c0mr277637e0c.3.1740506495519; Tue, 25 Feb 2025
 10:01:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122132459.135120-1-aleksandr.mikhalitsyn@canonical.com> <bnxhqrq7tip6jl2hu6jsvxxogdfii7ugmafbhgsogovrchxfyp@kagotkztqurt>
In-Reply-To: <bnxhqrq7tip6jl2hu6jsvxxogdfii7ugmafbhgsogovrchxfyp@kagotkztqurt>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Tue, 25 Feb 2025 19:01:21 +0100
X-Gm-Features: AQ5f1JrakItCiP5jkc5jrZpyt3_CnMKvt3XjzGW2ZxxfMjyX_PhMnhrsbskgp1w
Message-ID: <CAEivzxdPDC+sgRDYuv+RG57_RX0+RAdRDJTy8L4Bi=MffHmCuA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] pid_namespace: namespacify sysctl kernel.pid_max
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: brauner@kernel.org, stgraber@stgraber.org, tycho@tycho.pizza, 
	cyphar@cyphar.com, yun.zhou@windriver.com, joel.granados@kernel.org, 
	rostedt@goodmis.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 6:45=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> Hello.

Dear Michal,

(responding in this thread too, as a part of discussion around [1] revert)

[1] https://lore.kernel.org/all/20250221170249.890014-1-mkoutny@suse.com/

>
> On Fri, Nov 22, 2024 at 02:24:57PM +0100, Alexander Mikhalitsyn <aleksand=
r.mikhalitsyn@canonical.com> wrote:
> >
> (Sorry for responding only now as I missed this until I read v6.14 news.)
>
> > The pid_max sysctl is a global value. For a long time the default value
> > has been 65535 and during the pidfd dicussions Linus proposed to bump
> > pid_max by default (cf. [1]). Based on this discussion systemd started
> > bumping pid_max to 2^22. So all new systems now run with a very high
> > pid_max limit with some distros having also backported that change.
>
> Yes, multiple [1] people [2] proposed even lifting the legacy limit in
> kernel directly.
>
> > Of course, giving containers the ability to restrict the number of
> > processes in their respective pid namespace indepent of the global limi=
t
> > through pid_max is something desirable in itself and comes in handy in
> > general.
>
> Yes, this is what pids.max of a cgroup (already) does.

Not precisely, as it only limits the number of tasks in the cgroup,
while we talk
about pid *value* limit.

>
> (It is already difficult for users to troubleshoot which of multiple pid
> limits restricts their workload. I'm afraid making pid_max
> per-(hierarchical-)NS will contribute to confusion.)
> Also, the implementation copies the limit upon creation from
> parent, this pattern showed cumbersome with some attributes in legacy
> cgroup controllers e.g.  it's subject to race condition between parent's
> limit modification and children creation.

yeah, but it was intentional not to make this kernel change too big
and complex (and probably slow down things too).
Let's be honest that this pid_max setting is that kind of thing that
is rarely changed
and people use cgroups nowadays for that kind of stuff (and it is good!).

>
> > Independent of motivating use-cases the existence of pid namespaces
> > makes this also a good semantical extension and there have been prior
> > proposals pushing in a similar direction.
> > The trick here is to minimize the risk of regressions which I think is
> > doable. The fact that pid namespaces are hierarchical will help us here=
.
>
> I understand it is tempting to make pid_max part of a pid namespace but
> was the overlap with pids controller considered?

Of course, but as it was pointed out in the cover-letter, this patch
is not aimed to be
a replacement or suggested alternative to the pids controller.
Obviously, a cgroup way is the best
way to limit and control resources. This is about making an existing
pid_max limit to be namespace
aware to make user space happy. In the context of system containers
(LXC) it's a usual thing to do.
We see some kernel global limit or setting and consider if it's safe
to be namespaced in some way
and if it is safe and if it makes sense then we do it.

Second reason for having this is that we have a real use case scenario
with 32-bit Android Bionic libc
where we need to set a limit for PID *value*. And here, unfortunately,
pids controller does not help either.

>
> I'd consider the alternative of relying of virtualized PID numbers in
> pid namespaces with appropriate pids.max limit and numbers allocation
> strategy that would keep PID values below the limit (i.e. taking the
> first free pid number in given NS, actually I thought it is already the
> case but it doesn't work like that (when I try now [3])).
> WDYT?
>
> TL;DR instead of getting rid of the legacy limit, it was further
> extended to pid namespaces because of legacy workloads and it (almost)
> duplicates existing mechanism. Can this be rethought please?

I hope I explained above why I believe that this does not duplicate an
existing mechanism.

>
> Thanks,
> Michal

Kind regards,
Alex

>
> [1] https://lore.kernel.org/all/20240408145819.8787-1-mkoutny@suse.com/
> [2] https://lore.kernel.org/linux-api/CAHk-=3DwiZ40LVjnXSi9iHLE_-ZBsWFGCg=
dmNiYZUXn1-V5YBg2g@mail.gmail.com/

