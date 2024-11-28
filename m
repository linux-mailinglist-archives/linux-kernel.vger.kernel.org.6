Return-Path: <linux-kernel+bounces-425006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAB79DBC67
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 20:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F950B21BA0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 19:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93F11C1F08;
	Thu, 28 Nov 2024 19:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WKSl/h7z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D6F41C94
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 19:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732821006; cv=none; b=fUAGRqJqO7dxnR7GvmjvzF7sgNwgRkSYVvEvoLR6FJvBoQ0ZULBQ+2Rs4b8dUIKL3Rgsvw6rEe/hXLYTcmGlR97iHkkfy9DISq+mcOFS65Yaocz5g1d5FpFKPpFmMNSLH0//7KNc5K2h71NeUSuG6qdHb4GOWugWy8jbj7pc5Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732821006; c=relaxed/simple;
	bh=/2lsMQduZXQXaSld1gB79yb7joGFpD9EHAeh12hu3iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUm4lDdY1VYrMOjLYIUxqLxdwD/xluX/vMjuCvqDwyKG3evjtY0RHkpMlpIsHiPTlIEjoePWMuoZkXTnpF89NWKzdOfqtNKWk5FEx/dNdcMkgnBidTW3mCxZfjyCk9EKl9/drDISN8BinJV3ZF+h4//Mr7NPFdBz2JYcVSgyJk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WKSl/h7z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732820999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VBloSo0D1c+vKDoDMLX0aiqLfpHBlQcdDr4A+YjMHj4=;
	b=WKSl/h7zaLbCzQ8+nrN26MYXlovZrwY3NIpLKhYudNx7Y4N1RpOmPES0vN7M8Pi9GuyTAI
	2m0Z7qM5cHpjiIT+ucq7Csf4R5uJwcUabXso/6+07ceyc18h+6j+G3wo8xnHySqR+HeWcl
	A8VDpP4RZJv6+QIg5mM/0FgtRjY5XlM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-IWkC47aTMZyfTKqEYf1pjA-1; Thu, 28 Nov 2024 14:09:55 -0500
X-MC-Unique: IWkC47aTMZyfTKqEYf1pjA-1
X-Mimecast-MFC-AGG-ID: IWkC47aTMZyfTKqEYf1pjA
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ffa81a2e9aso6711501fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 11:09:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732820994; x=1733425794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBloSo0D1c+vKDoDMLX0aiqLfpHBlQcdDr4A+YjMHj4=;
        b=iJasxAMdy2dRVXcY9f3BgU/pFvN1N/l99bR7h8G9+vhdaUoT+g4tWbykGI3+6UR8Cl
         GY2DJiopvSw+D91P1dqcAMLpsvbV/GQGaNLIks34zhrL1tWS7Te35JPlWTCCx5C3WI77
         MMPBYknQQ/YMZ4Xrza1PYZh6mN0iLZO5u48aulsG9Agszm2HVZ94bnPIj+0XsZRsuBd9
         CKgtRz7Fgc+xbUEf/DPshz6QOZki2LgrXakv9oEPTNB2KBiCxp9aDFHyunrkyf4tXTE5
         fxBSHN+H2OTiC7rZv0/prS3MFLaq2vgEYHW3TzJ5FJq5wyMFIunc8ww7geIfC5vbm9k8
         KBoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2CtKmt0fav4hYTeRbXHZ0lMkJLXI1hd7E8t+ScXxvcOBite+sUfhwmvcej+rrKRDLKd0OALm5tLNOcrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqYiltdFOA6HapQ1tuxPUANDVOMyiHILmDjoFl7hWqAnBu7LgW
	1ifwM6i6ZcRpWnA5Qzf8PAsN3EI9jHsNQBum/pNDAQBN3lgpIQ7HmvsNOOVduPiOICVHVSH1pRA
	BtRsXmLnsJDYSprU4dDGL1wiWfNJNxrrY6Wa9j6LUUn1EYywp2khMbjbq1auRNo96f6NKHiOYAC
	sbpKXeFQOGxQGzrz8KX/faLdr12AYDK+30wKRM
X-Gm-Gg: ASbGncsS/TjqlWDqdS7PcXcH0o8zolkouLlH6vDwhJolM+PyR7L4ZT+75In0Rgsvs0I
	J6NhJaOGWSemH08rF7/EbJH3e3jIa41E=
X-Received: by 2002:a05:651c:b24:b0:2ff:cfbb:c893 with SMTP id 38308e7fff4ca-2ffd5fcc60amr46532441fa.6.1732820994103;
        Thu, 28 Nov 2024 11:09:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIeEpMGF/H22zp414InHW1svpPHkxi1av3dzgBicfwNUfbIUyxq9BjE4qZjXR1rvkVs3HzMYhIcovoyEEM+WQ=
X-Received: by 2002:a05:651c:b24:b0:2ff:cfbb:c893 with SMTP id
 38308e7fff4ca-2ffd5fcc60amr46532311fa.6.1732820993734; Thu, 28 Nov 2024
 11:09:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <yvmwdvnfzqz3efyoypejvkd4ihn5viagy4co7f4pquwrlvjli6@t7k6uihd2pp3>
 <87ldxvuwp9.fsf@linux.dev> <CAO8a2SjWXbVxDy4kcKF6JSesB=_QEfb=ZfPbwXpiY_GUuwA8zQ@mail.gmail.com>
 <87mshj8dbg.fsf@orpheu.olymp> <CAO8a2SjHq0hi22QdmaTH2E_c1vP2qHvy7JWE3E1+y3VhEWbDaw@mail.gmail.com>
 <87zflj6via.fsf@orpheu.olymp>
In-Reply-To: <87zflj6via.fsf@orpheu.olymp>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 28 Nov 2024 21:09:42 +0200
Message-ID: <CAO8a2SgMLurHP=o_ENbvOFMci8bcX0TP_18rbjrYJSbmV9CrMA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] ceph: ceph: fix out-of-bound array access when
 doing a file read
To: Luis Henriques <luis.henriques@linux.dev>
Cc: Goldwyn Rodrigues <rgoldwyn@suse.de>, Xiubo Li <xiubli@redhat.com>, 
	Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Good catch, I'm reworking the ergonomics of this function, this ret
error code is checked and carried through the loop and checked every
other line.

On Thu, Nov 28, 2024 at 8:53=E2=80=AFPM Luis Henriques <luis.henriques@linu=
x.dev> wrote:
>
> Hi!
>
> On Thu, Nov 28 2024, Alex Markuze wrote:
> > On Thu, Nov 28, 2024 at 7:43=E2=80=AFPM Luis Henriques <luis.henriques@=
linux.dev> wrote:
> >>
> >> Hi Alex,
> >>
> >> [ Thank you for looking into this. ]
> >>
> >> On Wed, Nov 27 2024, Alex Markuze wrote:
> >>
> >> > Hi, Folks.
> >> > AFAIK there is no side effect that can affect MDS with this fix.
> >> > This crash happens following this patch
> >> > "1065da21e5df9d843d2c5165d5d576be000142a6" "ceph: stop copying to it=
er
> >> > at EOF on sync reads".
> >> >
> >> > Per your fix Luis, it seems to address only the cases when i_size go=
es
> >> > to zero but can happen anytime the `i_size` goes below  `off`.
> >> > I propose fixing it this way:
> >>
> >> Hmm... you're probably right.  I didn't see this happening, but I gues=
s it
> >> could indeed happen.
> >>
> >> > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> >> > index 4b8d59ebda00..19b084212fee 100644
> >> > --- a/fs/ceph/file.c
> >> > +++ b/fs/ceph/file.c
> >> > @@ -1066,7 +1066,7 @@ ssize_t __ceph_sync_read(struct inode *inode,
> >> > loff_t *ki_pos,
> >> >         if (ceph_inode_is_shutdown(inode))
> >> >                 return -EIO;
> >> >
> >> > -       if (!len)
> >> > +       if (!len || !i_size)
> >> >                 return 0;
> >> >         /*
> >> >          * flush any page cache pages in this range.  this
> >> > @@ -1200,12 +1200,11 @@ ssize_t __ceph_sync_read(struct inode *inode=
,
> >> > loff_t *ki_pos,
> >> >                 }
> >> >
> >> >                 idx =3D 0;
> >> > -               if (ret <=3D 0)
> >> > -                       left =3D 0;
> >>
> >> Right now I don't have any means for testing this patch.  However, I d=
on't
> >> think this is completely correct.  By removing the above condition you=
're
> >> discarding cases where an error has occurred (i.e. where ret is negati=
ve).
> >
> > I didn't discard it though :).
> > I folded it into the `if` statement. I find the if else construct
> > overly verbose and cumbersome.
> >
> > +                       left =3D (ret > 0) ? ret : 0;
> >
>
> Right, but with your patch, if 'ret < 0', we could still hit the first
> branch instead of that one:
>
>                 if (off + ret > i_size)
>                         left =3D (i_size > off) ? i_size - off : 0;
>                 else
>                         left =3D (ret > 0) ? ret : 0;
>
> Cheers,
> --
> Lu=C3=ADs
>


