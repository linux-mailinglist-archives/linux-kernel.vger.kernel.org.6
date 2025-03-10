Return-Path: <linux-kernel+bounces-555039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BB0A5A4C7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2501A171D2B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434DB1DEFD7;
	Mon, 10 Mar 2025 20:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IJ94421b"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF0D1DE885
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637925; cv=none; b=uu/ZC7OJ4tEn56gtO8nRQFGCXnqerhvlMB6HStUQZYc8ZNQgg2AfCJ6NMJ+FOj3hgY5CLMzQqO4N3G0LlFMvYndlwi+uVvWJJNuLecodt7yOVhgYRd4psYN4pqMS7uVZd7kUshraHH58/vkoQC8iO9k9aXzgFsfeRvZROcJq77g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637925; c=relaxed/simple;
	bh=dNBOcmXv4yLqTFrO3VIX+EpkBqdtncVM6nDPAi2ht5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HgeuhknhByKRcIoiys5grbUYnbtKYG6s3IbsiFT8CoHUVCRt/pnfVUKi+Sv7+eacZQnNWPe9pOvhBJm9GBr9Hec5jvuNmXZcfI9qv6vRQ2xl4yNWdNwSuemkkacSlYvsOhzHpe9YJ/GOasjgYYDZB1/4Q8lakMgPPLDngf24rDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IJ94421b; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6fd9d9ae47cso44220257b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741637923; x=1742242723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7j7VrDGfjSW+piSXBuBjf4TItNrtuBqNTazSyrjysg=;
        b=IJ94421bVHaW+fc2FdvnYD4cS8eH2da8ojEYPp6l40re5akQHO/7Mpgp4d0sQI6Qs8
         F0xn0RBx5kjlD9lgKtuBPUtmeYI9nklZ9oqhpduxDsGG6Nbz5MT1FO6d+OCBcE3Qmx6I
         8It6QDmO+YOYr+xRk6ifIG8z2+wdKbBCG9Xm5kfVOhhR6ixG8FCbubeinEdsRwt/g6Ui
         2M7GnjAy8Q2gHc/knaEg5PXdJuTk6QozcBOvI8gbuRgo5o6wi43fxZpR4yj4Ikh0Umhu
         koylMx6ekNUx6D8MEzCqRI5TZyhMkFjufaBix3ujUf7LX92c7w58FNJjX4Kt+BdZe0th
         VPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741637923; x=1742242723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7j7VrDGfjSW+piSXBuBjf4TItNrtuBqNTazSyrjysg=;
        b=VyjJgov8sJeUHcYA1jWCyjPHrgPJLFG24FvoOH4yRdcRrkEhLpOT+tyCf7FQVaVAW6
         o43Hb0JjprVSTJif5rQ9ybcXPZDC+kc4NIswdVfX6gDpRZNP8eBK5epQ3owYAbo7areT
         kA/JprIt6GtxfxZaEiWW9SMeO0I4QqRzI70jGMxH1NS3Bl2SqGytMZNA3cxV8EZ1QlIC
         bUhZ4bVoGLTmO5fF2zi3V6AEixd2laCJwUc980v21t8jkpYct8zZ4k0C67N06LVlxHzF
         w3Ppqw18lxPTp220ASp8vbf0qJl/r4r3jXpsDslyfomZ7ocRML5cq/nCkA6iVffPZmzV
         GUxg==
X-Forwarded-Encrypted: i=1; AJvYcCUtf35NyeQBbPpQOU3sJ+5TpQcczJGz0c6vvVND5kjKLd6iugCfewSmPOWfo4UZLe6IT348xYj4XjysaHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQIoGGFUaEuY4Y52Ik6V1mvZbI6qcphs+dHrmW3Pf36MMdeUha
	te/dPu9zodawvC6SoJ9Cikd0/r2MMCKkFCleJSXca57gsLMWkl2CC29MJdtyspNBMVBvQmH7U+g
	g+4sajnm1B+0yBQSLYqKR6WHvyoWWibYoxMrX
X-Gm-Gg: ASbGncsQhUQdjMyauhuKtFtKFiK0EYXc5dfMyQu5CSazzvKh6gstFCjlCJplwLDeRdS
	4IGfsmMJwI88G7torPu5FfSaWePYkSIdZLMfTFWvb43+HmVNkF1YijFkOiXiTviKqInf6QWcYM0
	/MriAGqS7FBYVNw29nZl+tc/s5SA==
X-Google-Smtp-Source: AGHT+IG9WDx8ZAkHJVZqGMzMAmI3gsi1s9h5U2lJHR3eqS/CG9KHmGF1qjpk9M1cSxiZapUdewq9ADQphs2Rtbpa/58=
X-Received: by 2002:a05:690c:28b:b0:6fd:346f:97ba with SMTP id
 00721157ae682-6ff091c6271mr23109947b3.11.1741637922902; Mon, 10 Mar 2025
 13:18:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67cb894d.050a0220.d8275.0232.GAE@google.com> <tencent_0BEE86CD3878D26D402DDD6F949484E96E0A@qq.com>
 <CAEjxPJ6qFSSBUmK_F-rDhvhh0xw3y1QMP6bVr0iQ+V0FZ3niDQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6qFSSBUmK_F-rDhvhh0xw3y1QMP6bVr0iQ+V0FZ3niDQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 10 Mar 2025 16:18:31 -0400
X-Gm-Features: AQ5f1Jozk9bjIdyK5_Z3F8NS9II3-cE3r81pwcpWVImE2ku4Egdr1-NKjbklYaA
Message-ID: <CAHC9VhT-VA74h90ScjwO11g7b0pmCjzhVYWKHmkKqD2LLio98g@mail.gmail.com>
Subject: Re: [PATCH] selinux: read and write sid under lock
To: Edward Adam Davis <eadavis@qq.com>, Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: syzbot+00c633585760c05507c3@syzkaller.appspotmail.com, 
	linux-kernel@vger.kernel.org, omosnace@redhat.com, selinux@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 3:53=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Sat, Mar 8, 2025 at 11:55=E2=80=AFPM Edward Adam Davis <eadavis@qq.com=
> wrote:
> >
> > syzbot reported a data-race in selinux_socket_post_create /
> > selinux_socket_sock_rcv_skb. [1]
> >
> > When creating the socket path and receiving the network data packet pat=
h,
> > effective data access protection is not performed when reading and writ=
ing
> > the sid, resulting in a race condition.
> >
> > Add a lock to synchronize the two.

...

> > Reported-by: syzbot+00c633585760c05507c3@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D00c633585760c05507c3
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> >  security/selinux/hooks.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 7b867dfec88b..ea5d0273f9d5 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -4677,8 +4677,10 @@ static int selinux_socket_post_create(struct soc=
ket *sock, int family,
> >
> >         if (sock->sk) {
> >                 sksec =3D selinux_sock(sock->sk);
> > +               spin_lock(&sksec->lock);
>
> You didn't include the diff that adds this lock field to
> sk_security_struct, but aside from that, I would suggest something
> lighter-weight like READ_ONCE/WRITE_ONCE if possible.

Yes, please don't add a spinlock to something that is potentially
going to be hit on every packet entering the system.

--=20
paul-moore.com

