Return-Path: <linux-kernel+bounces-324654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2EB974F5F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E2F91C21253
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3F01714C0;
	Wed, 11 Sep 2024 10:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lahY+rCF"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424F41822F8
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726049335; cv=none; b=dF39H+yKexvApnvK61SyVftY5OfVOGZcqc3pkGZOPzOfzql5MX+/N3XZGC3+Ucgg1LK/OgHdIFOkrL52IcFG5Hkwnhjy7g5HMGMGcDeC7vkOvfzQwDSRLI8rDe6E78aw4TqiSRasEp5OfiZVuKCO75Df0kbla3vda8v2qOd7tWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726049335; c=relaxed/simple;
	bh=9p4+hZQjh71lVxuvzfXMO5h2mg2JsxoLOa6VRFSlmYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oaLeXnVeZONPajeCpZjMrCqLIJ2ytEjCTfZG52NlAbDFD/KavBkni8I2aRvMZdSyO7SK+t9sXnXUC9ov3UOwnsI7rR6N9Gi7l2kx8mO/o+lTztzeiWABzUXoGTKhD0s6Ydut9FS34Jl7aR4zqNsyEdKgGoj2RtqxLiY3yB7YxgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lahY+rCF; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c25f01879fso1995345a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726049331; x=1726654131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9hdLYUUwjUF1hpY600kXGnyLYC/hudZ8vg3i7Z84wI=;
        b=lahY+rCFdc/x5Z1c4MUKDG+FGYDkd8Xuf4qKowNyZJgaLwDs2Ij0l+836HiKYVTrbi
         8PQ1TlVs/kJ3ZPd1N7ZeQvVJ+b25CyeSZqsY5r21xit5OjAP8UhN7lCgk39Ju0mXWSLM
         xn/Wi6IMvDjaNtqMQzFySFyAMOQt8pt8dkYHNkzimz7wUxeWEjMFLVepohFqf9rx0diB
         +z++oS8ZZpDtvMkaM7oC0N7M23ZMwaMX++F/nD18i5ilxGL1yE6IjYMegXFJ7jc7vFkw
         vgXYIgWYUFk6wA8b0ePzSqvZMixeIusKiE7OzHynJnmjCmP9UXWRMzcI6RxYVNZwY77Y
         jGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726049331; x=1726654131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9hdLYUUwjUF1hpY600kXGnyLYC/hudZ8vg3i7Z84wI=;
        b=etJEkt9peszkK9m5sNpl//ApGbGTkNDwDRVxrzaPNRRKSPKzsGzjUaJ7m5nrv00iv2
         ZmR3/JWxOh5+i0IFXCBxdsXIovTBOX8/Y7WRmcvBv4/OqG+W9TuFgBxqgLFvDPx/wKu0
         SpSY1O++1lHx28fI6RmvO3EWGrJej9YM6+d91E212IlDJM5HVNz/iUC8GgKvaBA0zC+t
         5DYkU6DOhulEIvUUF2WJZMLBMdzYgoL/BktJ54joUDuTJMevXsHEjqJYwpsvFgJRiGG5
         P3qmkVcwqY0tWNuxNVqiN4roiCIwineD+WfAdJEPQe43ZP6/KEJO4K8/CY6QBfwsFK0i
         J98A==
X-Forwarded-Encrypted: i=1; AJvYcCX9ESWsgTXOFpwQjPj6Qc3VynB1BPKlhXozaKorgB1ZyePa5HkviWNn2oPhD1n3KBYOy0fqFzF8sbYTN6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjGs4JOi4u+ra28mU6vyfxmR089mGl4VKrtXA2isrglzkTqDuq
	/ABwdfjDy2alnU+bo+TMaR43wWJVpotXL730Tu9y+m4VmqD/rBqbOu4yH6/a/JGgvBD71UIGBiW
	Ar7UUM/2rWyjRIVLQRUSjwQUK7PDziQinPFdc
X-Google-Smtp-Source: AGHT+IFkRabYBVWE7beqKCTPtmzMJTAcAA4DOyN0ipywboc72PB58+sFy/RcmZ1ciMDzBl90IvVFngE+dsyhyzBF+LQ=
X-Received: by 2002:a05:6402:5ca:b0:5be:eaf1:807d with SMTP id
 4fb4d7f45d1cf-5c40bc5ba38mr1201960a12.29.1726049330681; Wed, 11 Sep 2024
 03:08:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000d3bf150621d361a7@google.com> <20240911120406.123aa4d4@fedora.home>
In-Reply-To: <20240911120406.123aa4d4@fedora.home>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 11 Sep 2024 12:08:36 +0200
Message-ID: <CANn89iJBFiHzMPCXyDB4=MAvE0OY5izFUzHxb3cnRzTRr=M3yA@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING: refcount bug in ethnl_phy_done
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: syzbot <syzbot+e9ed4e4368d450c8f9db@syzkaller.appspotmail.com>, 
	christophe.leroy@csgroup.eu, davem@davemloft.net, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 12:04=E2=80=AFPM Maxime Chevallier
<maxime.chevallier@bootlin.com> wrote:
>
> Hi,
>
> On Wed, 11 Sep 2024 01:00:23 -0700
> syzbot <syzbot+e9ed4e4368d450c8f9db@syzkaller.appspotmail.com> wrote:
>
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    a9b1fab3b69f Merge branch 'ionic-convert-rx-queue-buffe=
rs-..
> > git tree:       net-next
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D1193c49f980=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D37742f4fda0=
d1b09
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3De9ed4e4368d45=
0c8f9db
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D14bb7bc79=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D17b0a100580=
000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/0459f959b12d/d=
isk-a9b1fab3.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/337f1be5353b/vmli=
nux-a9b1fab3.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/0e3701969c4a=
/bzImage-a9b1fab3.xz
> >
> > The issue was bisected to:
> >
> > commit 17194be4c8e1e82d8b484e58cdcb495c0714d1fd
> > Author: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > Date:   Wed Aug 21 15:10:01 2024 +0000
> >
> >     net: ethtool: Introduce a command to list PHYs on an interface
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1034a49f=
980000
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D1234a49f=
980000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1434a49f980=
000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+e9ed4e4368d450c8f9db@syzkaller.appspotmail.com
> > Fixes: 17194be4c8e1 ("net: ethtool: Introduce a command to list PHYs on=
 an interface")
>
> I'm currently investigating this. I couldn't reproduce it though, even
> with the C reproducer, although this was on an arm64 box. I'll give it
> a try on x86_64 with the provided .config, see if I can figure out
> what's going on, as it looks like the ethnl_phy_start() doesn't get
> called.

Make sure to have in your .config

CONFIG_REF_TRACKER=3Dy
CONFIG_NET_DEV_REFCNT_TRACKER=3Dy
CONFIG_NET_NS_REFCNT_TRACKER=3Dy

