Return-Path: <linux-kernel+bounces-424987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA479DBC1C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 19:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C2E6B2102E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 18:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70251B4F0B;
	Thu, 28 Nov 2024 18:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LSS+9YRy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E4013B58E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 18:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732817987; cv=none; b=rAFcWzYMQa9IuXDCKH4GKrfgIx1t6NKJqGrOvabNTVwD5UDaayFfq1JEEBXZUeut65SNU3b6DzxuIW736p/mQ/+xWEmmlx+tDKiyPrV1LeJ9Cbu9Ur2y1UoXEzsaXEvAW+ktK9DWh2nFhND1K3DKGg8TSXAoTUG0TS/2CInMN+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732817987; c=relaxed/simple;
	bh=3wVaoWQl30Bqcl8Xk1npalljplWllN2Ye2/yGZMSlFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GFRuYIkxw+yAkQarautxQ71IWXAcaMOrBoMzMATE6FTRtx+D6/lklKl9nO6TOowJ9ZqFj9W1UWRUolkIDKbcB6igEXEhNctYl5GqiJn1ScfT4D+bBR8OjataZvFJkNEGP7G8SjP6oQGpjLd+8Qqu2s7gq/+JlQQSujN12V2hXuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LSS+9YRy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732817985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5eISIz/Oj12p2h73uef5HQuFnz3PuN01E35x9njK6SU=;
	b=LSS+9YRycY9SFunoKudqBKZdjLr05i/uGvjUW6V93Vw6wVLQuC67tRAG5hPOwFBC9livmW
	3UuX5Zm9M/lyTX9qYapHwlTCw8/Xtu6sYFqiKOSzUyMZ0c7D74EKsYocMM+SdWXoYKzO7Z
	E/MqzbURwYh4/qA8jj36FWD8/XdDIdM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-7CVGQ1BTPdmrGJg6Zc0v1Q-1; Thu, 28 Nov 2024 13:19:43 -0500
X-MC-Unique: 7CVGQ1BTPdmrGJg6Zc0v1Q-1
X-Mimecast-MFC-AGG-ID: 7CVGQ1BTPdmrGJg6Zc0v1Q
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa529e707f4so66215566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 10:19:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732817982; x=1733422782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eISIz/Oj12p2h73uef5HQuFnz3PuN01E35x9njK6SU=;
        b=IlB65SCukZjp5EaRUPbAyckKgxnkA4QFKHRThXF0wVfcUz+nXm2MNA6GaIlWXiVqaV
         iCuWBpAdV0qdNeFgoNWqHT20sH0eqkf/xpckGzBSFugyjB6mfhQOFvKnbOCrSsuL4OLG
         BbLFV+K7+5qqtnwLjjg+yqBCj6NjwMv9yRz2ZTQ6Pt98YzTsN2tVtFuNI6CuAvhgmJHO
         oANWG3u2JBZ2p7+egu1/LVLoi81ba49FhhROX+KGhOgTEWiFy/gZuBV1wC+ses5wQ1Y/
         7OQmlFT6IP317K7Yb+cBgUGBwLQGT/FSrMu3d/rQ7eK+CRSgPwN5iMxMGhRVUz3XUDUL
         k4aA==
X-Forwarded-Encrypted: i=1; AJvYcCWGDKZXyaNEOjnowaWpELNopYQTbAT/ZPib1TbLSs5JcwR4HuX0P2PKZFJNY43UiNhjT6Qh5ZZmJJUDqPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKe/dKfJOSnI780HQQNjjiZzq0ZtWx7kVc6wxjJzYZHnezyZ/0
	6EY7NC8SUkhUozsDfpa4OQrY8wQ1/P9u+ovPzyXdKNDhgkWBs6yAi7w6xEK4AG6WCZ3pTGx6fzF
	LXwtIIYL7XJS22aWQbUb7Fzu3dqKi9FGSApS7Kz4PEUYIiJJQpg6Tlr1jJAtmXIu4p9BsQOUD4k
	qX+j0JZPXK7641PmGV5sbED456BHsmYIF8HqsL
X-Gm-Gg: ASbGncvBhuj17yaDlNigV5r6YedmGiWj7vajt8C/sCFJnprIGuiQwQlCmP81hJDK+oX
	+5/CrGHXXqo7SCtzo5blgwK5ogCjXCT0=
X-Received: by 2002:a05:6402:2353:b0:5cf:d198:2a54 with SMTP id 4fb4d7f45d1cf-5d080c56e0cmr6278039a12.19.1732817982353;
        Thu, 28 Nov 2024 10:19:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6Y17PccYhgLF3ikhUf60nm9eQEDIn7kEWr91epvYCd5hqXPZAosgQP3Qmz0y4mFeUf0xT1hA4zKUuRiht4ok=
X-Received: by 2002:a05:6402:2353:b0:5cf:d198:2a54 with SMTP id
 4fb4d7f45d1cf-5d080c56e0cmr6278023a12.19.1732817981971; Thu, 28 Nov 2024
 10:19:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <yvmwdvnfzqz3efyoypejvkd4ihn5viagy4co7f4pquwrlvjli6@t7k6uihd2pp3>
 <87ldxvuwp9.fsf@linux.dev> <CAO8a2SjWXbVxDy4kcKF6JSesB=_QEfb=ZfPbwXpiY_GUuwA8zQ@mail.gmail.com>
 <87mshj8dbg.fsf@orpheu.olymp>
In-Reply-To: <87mshj8dbg.fsf@orpheu.olymp>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 28 Nov 2024 20:19:31 +0200
Message-ID: <CAO8a2SjHq0hi22QdmaTH2E_c1vP2qHvy7JWE3E1+y3VhEWbDaw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] ceph: ceph: fix out-of-bound array access when
 doing a file read
To: Luis Henriques <luis.henriques@linux.dev>
Cc: Goldwyn Rodrigues <rgoldwyn@suse.de>, Xiubo Li <xiubli@redhat.com>, 
	Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I didn't discard it though :).
I folded it into the `if` statement. I find the if else construct
overly verbose and cumbersome.

+                       left =3D (ret > 0) ? ret : 0;

On Thu, Nov 28, 2024 at 7:43=E2=80=AFPM Luis Henriques <luis.henriques@linu=
x.dev> wrote:
>
> Hi Alex,
>
> [ Thank you for looking into this. ]
>
> On Wed, Nov 27 2024, Alex Markuze wrote:
>
> > Hi, Folks.
> > AFAIK there is no side effect that can affect MDS with this fix.
> > This crash happens following this patch
> > "1065da21e5df9d843d2c5165d5d576be000142a6" "ceph: stop copying to iter
> > at EOF on sync reads".
> >
> > Per your fix Luis, it seems to address only the cases when i_size goes
> > to zero but can happen anytime the `i_size` goes below  `off`.
> > I propose fixing it this way:
>
> Hmm... you're probably right.  I didn't see this happening, but I guess i=
t
> could indeed happen.
>
> > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > index 4b8d59ebda00..19b084212fee 100644
> > --- a/fs/ceph/file.c
> > +++ b/fs/ceph/file.c
> > @@ -1066,7 +1066,7 @@ ssize_t __ceph_sync_read(struct inode *inode,
> > loff_t *ki_pos,
> >         if (ceph_inode_is_shutdown(inode))
> >                 return -EIO;
> >
> > -       if (!len)
> > +       if (!len || !i_size)
> >                 return 0;
> >         /*
> >          * flush any page cache pages in this range.  this
> > @@ -1200,12 +1200,11 @@ ssize_t __ceph_sync_read(struct inode *inode,
> > loff_t *ki_pos,
> >                 }
> >
> >                 idx =3D 0;
> > -               if (ret <=3D 0)
> > -                       left =3D 0;
>
> Right now I don't have any means for testing this patch.  However, I don'=
t
> think this is completely correct.  By removing the above condition you're
> discarding cases where an error has occurred (i.e. where ret is negative)=
.
>
> Why not simply modify my patch and do:
>
>                 if (i_size < off)
>                         ret =3D 0;
>
> instead of:
>                 if (i_size =3D=3D 0)
>                         ret =3D 0;
>
> ?
>
> (Again, totally untested!)
>
> Cheers,
> --
> Lu=C3=ADs
>
> > -               else if (off + ret > i_size)
> > -                       left =3D i_size - off;
> > +               if (off + ret > i_size)
> > +                       left =3D (i_size > off) ? i_size - off : 0;
> >                 else
> > -                       left =3D ret;
> > +                       left =3D (ret > 0) ? ret : 0;
> > +
> >                 while (left > 0) {
> >                         size_t plen, copied;
> >
> >
> > On Thu, Nov 7, 2024 at 1:09=E2=80=AFPM Luis Henriques <luis.henriques@l=
inux.dev> wrote:
> >>
> >> (CC'ing Alex)
> >>
> >> On Wed, Nov 06 2024, Goldwyn Rodrigues wrote:
> >>
> >> > Hi Xiubo,
> >> >
> >> >> BTW, so in the following code:
> >> >>
> >> >> 1202                 idx =3D 0;
> >> >> 1203                 if (ret <=3D 0)
> >> >> 1204                         left =3D 0;
> >> >> 1205                 else if (off + ret > i_size)
> >> >> 1206                         left =3D i_size - off;
> >> >> 1207                 else
> >> >> 1208                         left =3D ret;
> >> >>
> >> >> The 'ret' should be larger than '0', right ?
> >> >>
> >> >> If so we do not check anf fix it in the 'else if' branch instead?
> >> >>
> >> >> Because currently the read path code won't exit directly and keep
> >> >> retrying to read if it found that the real content length is longer=
 than
> >> >> the local 'i_size'.
> >> >>
> >> >> Again I am afraid your current fix will break the MIX filelock sema=
ntic ?
> >> >
> >> > Do you think changing left to ssize_t instead of size_t will
> >> > fix the problem?
> >> >
> >> > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> >> > index 4b8d59ebda00..f8955773bdd7 100644
> >> > --- a/fs/ceph/file.c
> >> > +++ b/fs/ceph/file.c
> >> > @@ -1066,7 +1066,7 @@ ssize_t __ceph_sync_read(struct inode *inode, =
loff_t *ki_pos,
> >> >       if (ceph_inode_is_shutdown(inode))
> >> >               return -EIO;
> >> >
> >> > -     if (!len)
> >> > +     if (!len || !i_size)
> >> >               return 0;
> >> >       /*
> >> >        * flush any page cache pages in this range.  this
> >> > @@ -1087,7 +1087,7 @@ ssize_t __ceph_sync_read(struct inode *inode, =
loff_t *ki_pos,
> >> >               size_t page_off;
> >> >               bool more;
> >> >               int idx;
> >> > -             size_t left;
> >> > +             ssize_t left;
> >> >               struct ceph_osd_req_op *op;
> >> >               u64 read_off =3D off;
> >> >               u64 read_len =3D len;
> >> >
> >>
> >> I *think* (although I haven't tested it) that you're patch should work=
 as
> >> well.  But I also think it's a bit more hacky: the overflow will still=
 be
> >> there:
> >>
> >>                 if (ret <=3D 0)
> >>                         left =3D 0;
> >>                 else if (off + ret > i_size)
> >>                         left =3D i_size - off;
> >>                 else
> >>                         left =3D ret;
> >>                 while (left > 0) {
> >>                         // ...
> >>                 }
> >>
> >> If 'i_size' is '0', 'left' (which is now signed) will now have a negat=
ive
> >> value in the 'else if' branch and the loop that follows will not be
> >> executed.  My version will simply set 'ret' to '0' before this 'if'
> >> construct.
> >>
> >> So, in my opinion, what needs to be figured out is whether this will c=
ause
> >> problems on the MDS side or not.  Because on the kernel client, it sho=
uld
> >> be safe to ignore reads to an inode that has size set to '0', even if
> >> there's already data available to be read.  Eventually, the inode meta=
data
> >> will get updated and by then we can retry the read.
> >>
> >> Unfortunately, the MDS continues to be a huge black box for me and the
> >> locking code in particular is very tricky.  I'd rather defer this for
> >> anyone that is familiar with the code.
> >>
> >> Cheers,
> >> --
> >> Lu=C3=ADs
> >>
>


