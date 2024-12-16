Return-Path: <linux-kernel+bounces-447972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D8D9F396D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7A09188809E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38658207DF2;
	Mon, 16 Dec 2024 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ry4SSsp/"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719B520767E
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 18:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734375506; cv=none; b=kzHEQDdHfXtP+9eRsup4GjD1FgodN+SM/uHk2QSz1ZYE6lGGt7gRHT9LKSu1VWlWjSXUWuWkuOwoHFBgVDnnDBgLXVPQvPKbLsHD3Ttq44RnBv9nSjjjQrXrCgixiAtkiJLeK28MWfqIAEAKCHI7bAyzeAAWhdv52bpUTg/WIhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734375506; c=relaxed/simple;
	bh=SV3LQEGL/hN47W8AIErH56BEHP30IF73FmJb8pNKbK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lXlFfSv5kOmvMh/xKyRdw6NGZrvoYc6rSr2Ay7VJXWGVO6hOki6xx8UYAcnnVf/YJP44Kz6qqSbwOMql9w0bLwx+fqioL17xaegQtPq14xEmsfCXYM34AMqUIjy52pVwQAoXlirBaoE9pnElzCh1it0f7Hm3rM/dKM6vhCyzs2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ry4SSsp/; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54020b0dcd2so6067833e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 10:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734375502; x=1734980302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzLRRgSYQAZ/LGhu2QHm86mP47vUyI0NVq1+fminqCk=;
        b=Ry4SSsp/7VBMUsRMouTGw/UurnFk8Lxo893/GXTbrbDY15AzlicWBWcTnSKw8yysb3
         vQmFJKuLzSZXGhfN5HRzl5FnkQKr5kqCuneX5FQPB4hHhlruDIkF2NDP4g007vj5QDr8
         qLkPrR/x8TXyExoSva4XyBJjeDHBtDWv3pHUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734375502; x=1734980302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzLRRgSYQAZ/LGhu2QHm86mP47vUyI0NVq1+fminqCk=;
        b=WpCmrsuK3PlGkCpG3y6uWtpUWZUii3MZtdAL7PsvOuQV3g+dV28cg22kn+JEc1U+1U
         HVQESj2tYguUzQmFWPVOmHx+YKba3wzqFGhI1zroBGIpzGuco8HtlMi4AyJ+vJfMC7mW
         Hw4ANne9pIfrS1jGU+LxrMp0mrtayNcCTFg9MjdeUHv3ofSnUrHtaGOj5H8BG78uJ5uc
         b1gf4XsVeN6D3x+1vIB9xog5kcqgwXEo2xTdHwMwWleM2EyCNsRuROjyvVKBex+cQrFI
         +vWBPtQ0EfzIh694YHUMJF9IyQIPjm7fh6t+p71WtY3VXfmujUs47s9BuJ2Jgg2cANrZ
         dLEg==
X-Forwarded-Encrypted: i=1; AJvYcCXPD4gC99KcluEkWDPHml35+wGvDjg0xw1CRkpDoDF7nttsd4UDVCBtlrgWlzW2Sh/HjFT7mKLQeifVh6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGGxFZeUtnHzeQw+2CHA0CIBSPGZdgHjAYsusO5jM3FWa/iceY
	ieH+LC1qiUYg+hfcSHIhDiuOx2KhWHxROeUbEpeyr1G8BDdG67bzgwdwqVyZM0utApYoP2cnKqw
	MHtPfZoNMhLQ/WazJ9lT5usBb930E470I96Uk
X-Gm-Gg: ASbGncs+Dxn3LsThgY7Woyml4PK3s1sUB1GuZfw+dv0ThaIxqdHowSvTsx0wv+CvR7+
	7fSP1yJIer/v3zGLFT8dQpwtowUGzw9gqNJaw+g==
X-Google-Smtp-Source: AGHT+IGMcETnavPEQXH8jvNLA+aG8u1ChCxl9+noimfdpLvWFaGfKMRKYUnalnnaiR2BYuqbdP6Hwsq/S3/avpzeJSk=
X-Received: by 2002:a05:6512:b11:b0:541:3175:1bc8 with SMTP id
 2adb3069b0e04-54131751e17mr71296e87.20.1734375501655; Mon, 16 Dec 2024
 10:58:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212224114.888373-1-dualli@chromium.org> <20241212224114.888373-3-dualli@chromium.org>
 <Z2BtgqkPUZxE8B83@google.com>
In-Reply-To: <Z2BtgqkPUZxE8B83@google.com>
From: Li Li <dualli@chromium.org>
Date: Mon, 16 Dec 2024 10:58:10 -0800
Message-ID: <CANBPYPhZ-_5=VMRoBxbfVb+AFb_qu49QH_hKOiSjX93E1GQA8A@mail.gmail.com>
Subject: Re: [PATCH net-next v10 2/2] binder: report txn errors via generic netlink
To: Carlos Llamas <cmllamas@google.com>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	donald.hunter@gmail.com, gregkh@linuxfoundation.org, arve@android.com, 
	tkjos@android.com, maco@android.com, joel@joelfernandes.org, 
	brauner@kernel.org, surenb@google.com, arnd@arndb.de, masahiroy@kernel.org, 
	bagasdotme@gmail.com, horms@kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, netdev@vger.kernel.org, hridya@google.com, 
	smoreland@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 10:12=E2=80=AFAM Carlos Llamas <cmllamas@google.com=
> wrote:
>
> On Thu, Dec 12, 2024 at 02:41:14PM -0800, Li Li wrote:
> > ---
> >  Documentation/admin-guide/binder_genl.rst     | 110 ++++++++
>
> Thanks for renaming to "Binder Netlink" this seems much better IMO.
> Also, I belive the documentation should also be binder_netlink.rst in
> such case?
>

Will also change it.

> > +++ b/Documentation/netlink/specs/binder_netlink.yaml
> > @@ -0,0 +1,108 @@
> > +# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3=
-Clause)
>
> I think you need a Copyright for this. I'm not sure if it would also be
> needed for the Documentation though.
>

Hmm, all other yaml files follow the same code style.

Netlink experts, can you please clarify this?

> > +/**
> > + * binder_find_proc() - set binder report flags
>
> the description of "binder report flags" is no longer accurate here.

Good catch! Will fix that.

>
> > + * @pid:     the target process
> > + */
> > +static struct binder_proc *binder_find_proc(int pid)
> > +{
> > +     struct binder_proc *proc;
> > +
> > +     mutex_lock(&binder_procs_lock);
> > +     hlist_for_each_entry(proc, &binder_procs, proc_node) {
> > +             if (proc->pid =3D=3D pid) {
> > +                     mutex_unlock(&binder_procs_lock);
> > +                     return proc;
>
> fwiw, the for_each stops when proc is NULL, so you can just break and
> return proc everytime. e.g.:
>
>         mutex_lock(&binder_procs_lock);
>         hlist_for_each_entry(proc, &binder_procs, proc_node) {
>                 if (proc->pid =3D=3D pid)
>                         break;
>         }
>         mutex_unlock(&binder_procs_lock);
>
>         return proc;
>

Got it. Thx

> >  /**
> >   * struct binder_device - information about a binder device node
> > - * @hlist:          list of binder devices (only used for devices requ=
ested via
> > - *                  CONFIG_ANDROID_BINDER_DEVICES)
> > + * @hlist:          list of binder devices
>
> This is the hunk that needs to go on the first 1/2 patch.

Sure.

> >  /**
> > diff --git a/drivers/android/binder_netlink.c b/drivers/android/binder_=
netlink.c
> > new file mode 100644
> > index 000000000000..2081b4319268
> > --- /dev/null
> > +++ b/drivers/android/binder_netlink.c
> > @@ -0,0 +1,39 @@
> > +// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-=
3-Clause)
> > +/* Do not edit directly, auto-generated from: */
> > +/*   Documentation/netlink/specs/binder_netlink.yaml */
> > +/* YNL-GEN kernel source */
> > +
> > +#include <net/netlink.h>
> > +#include <net/genetlink.h>
> > +
> > +#include "binder_netlink.h"
> > +
> > +#include <uapi/linux/android/binder_netlink.h>
> > +
> > +/* BINDER_NETLINK_CMD_REPORT_SETUP - do */
> > +static const struct nla_policy binder_netlink_report_setup_nl_policy[B=
INDER_NETLINK_A_CMD_FLAGS + 1] =3D {
> > +     [BINDER_NETLINK_A_CMD_CONTEXT] =3D { .type =3D NLA_NUL_STRING, },
> > +     [BINDER_NETLINK_A_CMD_PID] =3D { .type =3D NLA_U32, },
> > +     [BINDER_NETLINK_A_CMD_FLAGS] =3D NLA_POLICY_MASK(NLA_U32, 0xf),
> > +};
> > +
> > +/* Ops table for binder_netlink */
> > +static const struct genl_split_ops binder_netlink_nl_ops[] =3D {
>
> not: There are several places where you have "netlink_nl" which seems
> kind of redundant to me. wdyt? IMO you should drop the "nl" in all of
> these cases.
>

These are automatically generated from the yaml file. So let's just
keep them as is.
But it's a good suggestion to the owner of yaml parser.

