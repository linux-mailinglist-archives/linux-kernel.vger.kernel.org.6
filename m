Return-Path: <linux-kernel+bounces-565094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD63A660B8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F593B5E69
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 21:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC4F2036F5;
	Mon, 17 Mar 2025 21:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SP6yh5kk"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F601B9831
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 21:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742247594; cv=none; b=LLq+FYnXqohxrl8h7k+2UD4QZaNHks2jAybtqhfwZ94MoiVLQfbEWslMXwNa/tjaWgtiOk+sJy4Ozc+bGZKHcB1/2vesJqb/ClKqcfW6RTFoUx0O1IzqzKzwx5gC1U0R8jLVUFR128+zlC3MSxLdhLq8hgLb446cDYO/1MCXXQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742247594; c=relaxed/simple;
	bh=ztHFALnYLWvTtuU42KL1mH369p8HzKIWBTCkz6ZZnw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lnPU/RxyeLaslxNHz13UQbzQI87VAeD1KV9CbGjRMKEkGxWQOC8Wod5Qija0YGDrJUxJlj7ATHjKyXLd7vOCMhTJScebZSjgJowY02T3QStbK7qKq4aI0t7JR/eaL1kebKmFiZuV1LvVvUsvCDa0hGgS8h1vUzkhnyenozvVsdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SP6yh5kk; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e53ef7462b6so4799429276.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 14:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1742247590; x=1742852390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnlMK9F7bzeFJcaZWqZs5pyHM5Od3fOzYKEedrvkZcs=;
        b=SP6yh5kkHvokWghbUeCp7nEdJ2NP0fWBWJo+5Xi71kSeZKw63i54LLdMHgjIf4ug4E
         gGciv3ID6c5B/iEdiV/PPHFjXh92la5jJUbU8kbvfNtZHPHwW9sJBKgHstR/8a/HfRxi
         g0rtn2LGGPP+cr8iKWre98xfG/acCYqRBiuk9Hv2AwyG4al/b6NHOBd0iZKTCCFKqiCx
         4x5a5ScAOsNeFH18FuiVF1+OXNBczre8g9NbaGlz1eby+5w0LmjcLGyn0iV6SFeL4f4Q
         XSbrxBbLFrnfd8oyVXeI5aMskx42AFpp3BxdP8piLfQp5YmuJhywX+9WOFaAPOZmoxBu
         BxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742247590; x=1742852390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnlMK9F7bzeFJcaZWqZs5pyHM5Od3fOzYKEedrvkZcs=;
        b=JztKntQ4UESjeO+nNe1E3GXPIQ6ciDAozYTPSos7T+QAjEyL9nY/QDohNRQQCa1QA/
         31I3IyCOkvipLU9G/4dEwmbrl2pQ+j4+jg0v4Qh/RLpSIhqcGrGp3toHlpNLGO3Yp9QG
         +9+z+gVH6b/anHB3+2nzEA9SFG5z+U5mix/bcWQLGGJOdOshyI9yXelxVLYu45YdK6+5
         T6p4LPm0ILr14gZ6qXA3uSehLd8BXdXhcL0xbNCdb61TPtfFQ+ywbjXHPBaS1ZoyssSc
         hWKzBUb4T+rB77iRjKzAeL2cI/Eebh3A8Aqdp9oQc+AHDsoT5rIsCU2Aj5ZN6zcprWum
         zXWw==
X-Forwarded-Encrypted: i=1; AJvYcCW2mRpnArwJdydujmuVCC/FiDo1sI2Xl9pbDe5SUEOwTqnHqzzZU0ASHkMaWyXncN5g2tXup4INxemnAyc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+QvDK7/MyuZbn+ifbCOHGf3b7LLpWa6Tl/ctvh2fxF8drgIlV
	QgM4MN0vZEiOQ6zwwcdj2rt5yOa35g7e/8e79TIlgVYjjicf/30jrBFVU7mbNe4Cjy5kF4WnnyP
	++Okny+ghnqQSoRE+vhRrm/n25EPRua6nElp9
X-Gm-Gg: ASbGnctGpWuYV7EzSKggZXTKqMZORxk+YKgoqHSyEwOrwOpDWxqSyKAmkbymyVxSVpP
	ILPUos52u5SYEMr+tt1oLtKyl1py+5YdIoDqIcKVcj/1hfIvvzwsHzBIwMQ2eZ3K771f/+yABwJ
	ckp8bPdHg1RTQ7kRQrdDXFKtSyTw==
X-Google-Smtp-Source: AGHT+IHORVknOcq9cpTU5mUcjTWVU/pzqQwGyucs70qlPMLVrG0hS1VH8K/0UV22LjJ4NfsVEkZ9gx0TfVouPyYISHs=
X-Received: by 2002:a05:6902:1ac9:b0:e60:9d12:c1e5 with SMTP id
 3f1490d57ef6-e63f65b2714mr14955843276.36.1742247590648; Mon, 17 Mar 2025
 14:39:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ7eFbsn7h7o90tOE6ymp4+g-bwYL_Rwy6t0EcxpaBAxAA@mail.gmail.com>
 <tencent_E8AA2ECB6ED7CC88A7F746FED2C4065B0906@qq.com> <CAEjxPJ6QZwprWRXme4S2pAD9X-DmWSfMpoHL8NR+YufMdicZ2g@mail.gmail.com>
In-Reply-To: <CAEjxPJ6QZwprWRXme4S2pAD9X-DmWSfMpoHL8NR+YufMdicZ2g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 17 Mar 2025 17:39:39 -0400
X-Gm-Features: AQ5f1JqHZk-uvCHNK9RrvMV46LVNlKY0WcHirfMoyeiw7s5eiQzCNPf_0iH7vPo
Message-ID: <CAHC9VhQAf_e-w50mW4wm8DBEpu0KixWGwcozTayq_g0pugCp+g@mail.gmail.com>
Subject: Re: [PATCH V2] selinux: access sid under READ/WRITE_ONCE
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Edward Adam Davis <eadavis@qq.com>, linux-kernel@vger.kernel.org, omosnace@redhat.com, 
	selinux@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 9:23=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Mar 11, 2025 at 9:05=E2=80=AFPM Edward Adam Davis <eadavis@qq.com=
> wrote:
> >
> > On Tue, 11 Mar 2025 11:19:49 -0400, Stephen Smalley wrote:
> > > > Reported-by: syzbot+00c633585760c05507c3@syzkaller.appspotmail.com
> > > > Closes: https://syzkaller.appspot.com/bug?extid=3D00c633585760c0550=
7c3
> > > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > > > ---
> > > > V1 -> V2: replace with READ_ONCE/WRITE_ONCE
> > >
> > > Thanks for the patch. Did you audit all other users of sksec->sid to
> > > see if they too should be wrapped with READ_ONCE()/WRITE_ONCE() or ar=
e
> > > already safe?
> > This fix is only for the issues reported by syzbot+00c633585760c05507c3=
.
> > I have confirmed that there are many contexts related to "sksec->sid" (=
at
> > least 29). I am not familiar with selinux, and it is unnecessary to do
> > excessive fixes before syzbot reports other issues.
> >
> > Maybe the subject of my patch is not appropriate, and it may be more
> > appropriate to adjust it to "selinux: fix data race in socket create an=
d
> > receive skb".
>
> We don't want to just silence warnings but rather identify and fix
> root causes, and do so comprehensively.
> Looking more closely at the syzbot report, it appears that a sock that
> initially has SID 3 (aka SECINITSID_UNLABELED) is being assigned a
> specific SID via socket_post_create at a point where it might already
> be receiving packets.
> That seems like it requires a more general fix to ensure that the sock
> is correctly labeled before it can start receiving packets.

There is a window in __sock_create() where the socket is created and
"alive" in the network stack, but before security_socket_post_create()
is called to fully initialize/label the socket (look between
pf->create() and the LSM call in __sock_create()).

Looking quickly, I *think* it may be as simple as doing the
read/write_once() accessors for the sksec->sid, but I didn't dig into
the NetLabel and XFRM aspects of the code paths.  I suspect they are
okay due to how they work, but I'm not going to be surprised if there
is an issue lurking there.

We could possibly solve this generically by introducing a
sksec->initialized field, similar to inodes, although we would have no
way to properly initialize the sksec in selinux_socket_sock_rcv_skb()
if we hit the uninitialized case so we would need to decide how to
handle that.  I worry that dropping packets in that case could
negatively impact stream connections that need to go through a
multi-step handshake process.  Maybe we could capture the creator's
label in selinux_sk_alloc_security(), at least in some cases (?), but
this would need a lot of investigation to see if that works properly
in all the cases (I worry it doesn't).

--=20
paul-moore.com

