Return-Path: <linux-kernel+bounces-423534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 353089DA8F7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E964C281083
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1281FCF6B;
	Wed, 27 Nov 2024 13:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jvu7+pHV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292DC1DFDE
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 13:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732715240; cv=none; b=LiGXYcVdSNFimhdapC7jh579/aCPanjF9gMG2uHXG0PdG4uGi0ZKF4PiftlXncyFMFGwzwR8Il80Zmt2UDRC0wH4MKDoqkmYoiG8kGyauwfex5vwzTkGUczg+QVjymKzjOOu2DlTLcvFn9kihUuCshpMdAAWklNLtN62l9/rqEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732715240; c=relaxed/simple;
	bh=evRWrrZELB0qlWCe8j/zCNFPGxjWliYk59aXtawzmDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Av5ZQU9BXrObmsKQinGDpMo6x4GP8XnKkNwCy8fgK0PvDWG1ay7brDPM4oxjBRY6KgyB1zccHHC5v6D13ZyqmCb0iZglAxfRw6ui1RbvyTJ2XJiIzBaLCU4Wod8NnDd93x4XjMW3qJsPq0ZwiSV0ZRvHAw/YQfVANSrOLo1oLAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jvu7+pHV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732715237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GAIX8sTJ7Mh+FtH4LePb8V1xaxZp+sNd9bSAUtmHdUE=;
	b=Jvu7+pHVGAq+I951ilsN6+zo1FJX2kD9sDV1hXckGgmVl5WIQIcUW0yfze1dsoRFTm5cDu
	fRomLDrg/MlfL4r0F+DF2mWiAWqhOEGbFfqCjBjDSnPTQZTPVQQOuXY/WOf7PG6zlQRJYS
	ydkn2KhehTY7CECKQG5cosM/NGGu9Ag=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-7uw9GOxiP3SA_sVJeIF7qw-1; Wed, 27 Nov 2024 08:47:15 -0500
X-MC-Unique: 7uw9GOxiP3SA_sVJeIF7qw-1
X-Mimecast-MFC-AGG-ID: 7uw9GOxiP3SA_sVJeIF7qw
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-53de479ec3cso2110941e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 05:47:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732715234; x=1733320034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GAIX8sTJ7Mh+FtH4LePb8V1xaxZp+sNd9bSAUtmHdUE=;
        b=Jns4MQ7QuX6wk+doFlFrK+wWZ8PJUMjrdf37Fr2yKnV5G/cZQUn77x4j6eER6vlONs
         o6AjRus+8qXzRvSVOXAxX0CXMKt0kXYxWNTWNsWkr+S/mc2ua9bVKKez6QcUkVNK/GgF
         Pq4fWIbenpc1kjlYgOA0UmXmQLxOAy7Pjl8zpZJfxzQC3vSgK8Qwikj757VU6tyH9MsJ
         AmFC2/nmUwZrFj2gHhpLc1I0THbs1fJeXUsvdR06wy9JqMpCJkfLXqFPeHq2GuW9qkFl
         +bzWKQZggk/BorYZJ8hspCCCwmoZ/1a3w+8jpghuQlJyTt+2zLXP8fdk2nrUs3Y9zBMk
         emVg==
X-Forwarded-Encrypted: i=1; AJvYcCVxqPXJ5yA47DP6q2LtVPhmXSiPie9gIUer2ITU+duMyEp+lsfOtfcWT+g05WbLlXFNCeTM6ZDNu6btQak=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtTTWGLCx7vgtnkMdeRxbc7S4cNpZsnxZ3U/5KPvSxYBEMbcnc
	na4sOx5pb8aC5MlmM0ks9oG05qtEPnWrkIRnu6T/R91qKuT1W4NDKsDK8nQWw1ZJoFRN1RAaXJj
	dMsOeyzErjlWB//Uyl6M1M1kPMldXVyUXSnC/2Fw+RMeUcUCKKVNO9S3S8d7DrlBUWLkfyf7qn4
	zNe1fRxftmO/jn6iAzgyBk0g41AtvLY50X2M6X
X-Gm-Gg: ASbGnctzDEonbAHz+ienfGe8t2WWO2dchcq2XtmEOFYQzL3FhvNXm7arix6AKqgGLbY
	0San5uql7NnjBhZ+2hekyLo558sK/4sg=
X-Received: by 2002:a05:6512:2820:b0:53d:e41a:c1a5 with SMTP id 2adb3069b0e04-53df0115095mr1707302e87.57.1732715234187;
        Wed, 27 Nov 2024 05:47:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNv/oQnIL8mFnuoqNZ3B4Z5IoJFV4Yu0S1tCE6kHskotRLoFZOJVwf8Uz8xjQlk55YaaSrR+hW/uHDlFKre2g=
X-Received: by 2002:a05:6512:2820:b0:53d:e41a:c1a5 with SMTP id
 2adb3069b0e04-53df0115095mr1707280e87.57.1732715233805; Wed, 27 Nov 2024
 05:47:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <yvmwdvnfzqz3efyoypejvkd4ihn5viagy4co7f4pquwrlvjli6@t7k6uihd2pp3> <87ldxvuwp9.fsf@linux.dev>
In-Reply-To: <87ldxvuwp9.fsf@linux.dev>
From: Alex Markuze <amarkuze@redhat.com>
Date: Wed, 27 Nov 2024 15:47:02 +0200
Message-ID: <CAO8a2SjWXbVxDy4kcKF6JSesB=_QEfb=ZfPbwXpiY_GUuwA8zQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] ceph: ceph: fix out-of-bound array access when
 doing a file read
To: Luis Henriques <luis.henriques@linux.dev>
Cc: Goldwyn Rodrigues <rgoldwyn@suse.de>, Xiubo Li <xiubli@redhat.com>, 
	Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Folks.
AFAIK there is no side effect that can affect MDS with this fix.
This crash happens following this patch
"1065da21e5df9d843d2c5165d5d576be000142a6" "ceph: stop copying to iter
at EOF on sync reads".

Per your fix Luis, it seems to address only the cases when i_size goes
to zero but can happen anytime the `i_size` goes below  `off`.
I propose fixing it this way:

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 4b8d59ebda00..19b084212fee 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1066,7 +1066,7 @@ ssize_t __ceph_sync_read(struct inode *inode,
loff_t *ki_pos,
        if (ceph_inode_is_shutdown(inode))
                return -EIO;

-       if (!len)
+       if (!len || !i_size)
                return 0;
        /*
         * flush any page cache pages in this range.  this
@@ -1200,12 +1200,11 @@ ssize_t __ceph_sync_read(struct inode *inode,
loff_t *ki_pos,
                }

                idx =3D 0;
-               if (ret <=3D 0)
-                       left =3D 0;
-               else if (off + ret > i_size)
-                       left =3D i_size - off;
+               if (off + ret > i_size)
+                       left =3D (i_size > off) ? i_size - off : 0;
                else
-                       left =3D ret;
+                       left =3D (ret > 0) ? ret : 0;
+
                while (left > 0) {
                        size_t plen, copied;


On Thu, Nov 7, 2024 at 1:09=E2=80=AFPM Luis Henriques <luis.henriques@linux=
.dev> wrote:
>
> (CC'ing Alex)
>
> On Wed, Nov 06 2024, Goldwyn Rodrigues wrote:
>
> > Hi Xiubo,
> >
> >> BTW, so in the following code:
> >>
> >> 1202                 idx =3D 0;
> >> 1203                 if (ret <=3D 0)
> >> 1204                         left =3D 0;
> >> 1205                 else if (off + ret > i_size)
> >> 1206                         left =3D i_size - off;
> >> 1207                 else
> >> 1208                         left =3D ret;
> >>
> >> The 'ret' should be larger than '0', right ?
> >>
> >> If so we do not check anf fix it in the 'else if' branch instead?
> >>
> >> Because currently the read path code won't exit directly and keep
> >> retrying to read if it found that the real content length is longer th=
an
> >> the local 'i_size'.
> >>
> >> Again I am afraid your current fix will break the MIX filelock semanti=
c ?
> >
> > Do you think changing left to ssize_t instead of size_t will
> > fix the problem?
> >
> > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > index 4b8d59ebda00..f8955773bdd7 100644
> > --- a/fs/ceph/file.c
> > +++ b/fs/ceph/file.c
> > @@ -1066,7 +1066,7 @@ ssize_t __ceph_sync_read(struct inode *inode, lof=
f_t *ki_pos,
> >       if (ceph_inode_is_shutdown(inode))
> >               return -EIO;
> >
> > -     if (!len)
> > +     if (!len || !i_size)
> >               return 0;
> >       /*
> >        * flush any page cache pages in this range.  this
> > @@ -1087,7 +1087,7 @@ ssize_t __ceph_sync_read(struct inode *inode, lof=
f_t *ki_pos,
> >               size_t page_off;
> >               bool more;
> >               int idx;
> > -             size_t left;
> > +             ssize_t left;
> >               struct ceph_osd_req_op *op;
> >               u64 read_off =3D off;
> >               u64 read_len =3D len;
> >
>
> I *think* (although I haven't tested it) that you're patch should work as
> well.  But I also think it's a bit more hacky: the overflow will still be
> there:
>
>                 if (ret <=3D 0)
>                         left =3D 0;
>                 else if (off + ret > i_size)
>                         left =3D i_size - off;
>                 else
>                         left =3D ret;
>                 while (left > 0) {
>                         // ...
>                 }
>
> If 'i_size' is '0', 'left' (which is now signed) will now have a negative
> value in the 'else if' branch and the loop that follows will not be
> executed.  My version will simply set 'ret' to '0' before this 'if'
> construct.
>
> So, in my opinion, what needs to be figured out is whether this will caus=
e
> problems on the MDS side or not.  Because on the kernel client, it should
> be safe to ignore reads to an inode that has size set to '0', even if
> there's already data available to be read.  Eventually, the inode metadat=
a
> will get updated and by then we can retry the read.
>
> Unfortunately, the MDS continues to be a huge black box for me and the
> locking code in particular is very tricky.  I'd rather defer this for
> anyone that is familiar with the code.
>
> Cheers,
> --
> Lu=C3=ADs
>


