Return-Path: <linux-kernel+bounces-558269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 249EFA5E3A4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DBB93AFED6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AF8257ACF;
	Wed, 12 Mar 2025 18:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ucb7ME/c"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A054A156C62
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 18:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741804131; cv=none; b=fyaEwzCkjh/X9VvD2Ej4iIr82T3LLiV5ZpKbptgZkApjgov7dHotKct4POc+2N04kdzEflit4PqqqQEyUa3Yo/a2g0ar4dG5TufEgLiXq2CPR3grNyL/26MdJFNepOaGjL9mBmQ9kJ/JII5Nu+83K4UdM4QI10KJ59D3ZQFFYEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741804131; c=relaxed/simple;
	bh=Ngpr1p1nbTglbSpAFKZZ5TvhJkrFCBN3/OXaMil2WNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ovowC+0JMa7rSCqGWBX9cQ/zxjGR7Te+ozfJlv3cTp2Lhj8ZWrMDgD9U9rS7IWLaa0xhOuMqaqQ0MEGq2QRbsyikPr1descvBWONBMd3kYMt7A1+Yp4XS4Q9inpmBe2MEHRfw1bIu7BU0CsR+XM8dt7JCRyiQuYPfJCDg9u3jY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ucb7ME/c; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-601c46a92d1so50670eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 11:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741804128; x=1742408928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHwHQMJua3klBUMulVATkOY1QanUZb02DTdOUUD5AYw=;
        b=Ucb7ME/coS8UnKdOMVLY1EAnoxCVr9xV9XtwJeuv9tNqs08zLXrDzdRhx5UNOhkw9X
         0FFAV04sccP3PQPQtMCOD7kP8i3fW2et34awZoXXGhgB62dE/6KCO/HjepKZtOlEEKVI
         TnYo0YZIFVCMzZTQWSu1Se4WrJoTHXwkr3cy4DMV4XLVSism0prm+Qlog9pxhCk+H1To
         5aXihZvSEr6cYe+wr+5dTpa10DU/8XzDJe6PdgA4+dowqb5iJZL4FjonAGqap/cewhny
         /emKVSK3+7p1DNtbOAlvnHIqTxiXCC39f5ZBVcLPUMB94gfPft4nn6d5D2dJlj+WnatJ
         suDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741804128; x=1742408928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CHwHQMJua3klBUMulVATkOY1QanUZb02DTdOUUD5AYw=;
        b=e6VnywZaMpqCH3X7ngH8F+wP05Jss4DRnk4Twh/QnwKvputx+9XK1eaud/hFOQffpe
         nFUSL5QqLOtuc25gXhxXyuDGLY/hCIOP0HPqxVJgFnOpUIYgXPHnJXgAyfuoeEX8109J
         v/87MBayLVoDoh3BJERXgVBn9QlUqDPJJc4cT5yb4fM1+yYmCyZWFgzkCfPlPERS/tb8
         p+bruq3Ruc7NbjphbT+lV9QkOprIPfnJiLYpbxndV3mMxhm3kdpJI1SsU2ANfKNUIG/a
         8KmgwMXYfq3J1OoQkrnF+F2hSvJ3gTgnkTE+HGWL+EoitsPVZuSBfFtCxn40I0u39gvF
         Iuag==
X-Forwarded-Encrypted: i=1; AJvYcCW/mtlLyo6wyWkZQUmgwpf9NrXqkEO1oJL+qf1DTIZc3S1ulX7tFjYGP7HeJYzHcmSUs/HO3SM5H90rNXs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6xOjtah0W0S+S2+r5RsavwrEqJnGDO7ztVdmyRFlgccfUGSDi
	Nt3Lu5Ses10xkncseROPogteYoEriYotUeFYwZy5wYtheH1K0bPShGTMmcuHxwpMeov3X1MC4/f
	tqo32PiHIiHwajceUTtqc2fqSWDg=
X-Gm-Gg: ASbGncvhPrslF/HkKfbFQZpCTsb9XvuM/HULegmuCZtBbpFGB0/mxJ20WH21WooASvO
	Ajzd7jte//QRQPoxpguC2pkqCCVNlf1/rsEqCkvvrP+1Sr2R2UZuYoLP/O7lSF1ZAON1FhNhv1k
	RwJV2QccFHxfdTCwIaN5JEdMVbOcSJWyN04tlHK7cjFvo=
X-Google-Smtp-Source: AGHT+IFut0Zk09cK6vm0MnorvtHXYibBHad055rpS9o3iUhWRsYEptWFMswj4MDeB58uTmXwuVz4UcQoWo32oy2j6kw=
X-Received: by 2002:a05:6820:8c6:b0:5fc:b7f4:c013 with SMTP id
 006d021491bc7-6004ab16543mr9411552eaf.5.1741804128391; Wed, 12 Mar 2025
 11:28:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250302191558.47180-1-suchitkarunakaran@gmail.com> <e495bf9c-9fba-44ce-99fe-04879f8dd0c2@oracle.com>
In-Reply-To: <e495bf9c-9fba-44ce-99fe-04879f8dd0c2@oracle.com>
From: Suchit K <suchitkarunakaran@gmail.com>
Date: Wed, 12 Mar 2025 23:58:37 +0530
X-Gm-Features: AQ5f1JoaH6gJd1xzn1mzi_Gxo7sc9H-m4gHwbkfSxFM4MV4CBQqsV2opbOYzVU8
Message-ID: <CAO9wTFgMCsS9L1PwpkDr48t9R4hO2UvFRwbPu2mMQMP0aqD+cQ@mail.gmail.com>
Subject: Re: [PATCH] jfs: jfs_xtree: replace XT_GETPAGE macro with
 xt_getpage() function
To: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dave,
Thanks for the comments. I=E2=80=99m still a beginner so I wanted to share =
my
thoughts and check with you. Almost all references to the xt_getpage
function directly return the rc value obtained from it. I feel that
changing its return type to (xtpage_t *) might not be ideal, as it
would require modifying the code in multiple places. That said, if you
think changing the return value is the better approach, I=E2=80=99ll try to
change it. Also, I=E2=80=99ll update struct inode** ip to struct inode* ip.
Thanks once again.

On Tue, 11 Mar 2025 at 22:19, Dave Kleikamp <dave.kleikamp@oracle.com> wrot=
e:
>
> On 3/2/25 1:15PM, Suchit Karunakaran wrote:
> > Replace legacy XT_GETPAGE macro with an inline function and update all
> > instances of XT_GETPAGE in jfs_xtree.c file to use the new function.
>
> I like the idea, but as long as we are changing this to a function, I'd
> like to simplify it to return the xtpage (xtpage_t *). A NULL return
> would indicate a failure.
>
> Also, the first argument should just be "struct inode *ip". That should
> eliminate your second patch.
>   >
> > Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> > ---
> >   fs/jfs/jfs_xtree.c | 86 ++++++++++++++++++++++++++++-----------------=
-
> >   1 file changed, 52 insertions(+), 34 deletions(-)
> >
> > diff --git a/fs/jfs/jfs_xtree.c b/fs/jfs/jfs_xtree.c
> > index 5ee618d17e77..fb736a06ea58 100644
> > --- a/fs/jfs/jfs_xtree.c
> > +++ b/fs/jfs/jfs_xtree.c
> > @@ -49,26 +49,6 @@
> >
> >   #define XT_PAGE(IP, MP) BT_PAGE(IP, MP, xtpage_t, i_xtroot)
> >
> > -/* get page buffer for specified block address */
> > -/* ToDo: Replace this ugly macro with a function */
> > -#define XT_GETPAGE(IP, BN, MP, SIZE, P, RC)                          \
> > -do {                                                                 \
> > -     BT_GETPAGE(IP, BN, MP, xtpage_t, SIZE, P, RC, i_xtroot);        \
> > -     if (!(RC)) {                                                    \
> > -             if ((le16_to_cpu((P)->header.nextindex) < XTENTRYSTART) |=
| \
> > -                 (le16_to_cpu((P)->header.nextindex) >               \
> > -                  le16_to_cpu((P)->header.maxentry)) ||              \
> > -                 (le16_to_cpu((P)->header.maxentry) >                \
> > -                  (((BN) =3D=3D 0) ? XTROOTMAXSLOT : PSIZE >> L2XTSLOT=
SIZE))) { \
> > -                     jfs_error((IP)->i_sb,                           \
> > -                               "XT_GETPAGE: xtree page corrupt\n");  \
> > -                     BT_PUTPAGE(MP);                                 \
> > -                     MP =3D NULL;                                     =
 \
> > -                     RC =3D -EIO;                                     =
 \
> > -             }                                                       \
> > -     }                                                               \
> > -} while (0)
> > -
> >   /* for consistency */
> >   #define XT_PUTPAGE(MP) BT_PUTPAGE(MP)
> >
> > @@ -114,6 +94,44 @@ static int xtSplitPage(tid_t tid, struct inode *ip,=
 struct xtsplit * split,
> >   static int xtSplitRoot(tid_t tid, struct inode *ip,
> >                      struct xtsplit * split, struct metapage ** rmpp);
> >
> > +/*
> > + *   xt_getpage()
> > + *
> > + * function: get the page buffer for a specified block address.
> > + *
> > + * parameters:
> > + *   ip      - pointer to the inode
> > + *   bn      - block number (s64) of the xtree page to be retrieved;
> > + *   mp      - pointer to a metapage pointer where the page buffer is =
returned;
> > + *   size    - size parameter to pass to BT_GETPAGE;
> > + *   p       - pointer to an xtpage_t pointer mapping the page's data.
> > + *
> > + * returns:
> > + *   0 on success, or -EIO if the page is corrupt or an error occurs.
> > + */
> > +
> > +static inline int xt_getpage(struct inode **ip, s64 bn, struct metapag=
e **mp,
> > +                     unsigned int size, xtpage_t **p)
> > +{
> > +     int rc;
> > +
> > +     BT_GETPAGE(ip, bn, *mp, xtpage_t, size, *p, rc, i_xtroot);
> > +
> > +     if (!rc) {
> > +             if ((le16_to_cpu((*p)->header.nextindex) < XTENTRYSTART) =
||
> > +                     (le16_to_cpu((*p)->header.nextindex) >
> > +                             le16_to_cpu((*p)->header.maxentry)) ||
> > +                     (le16_to_cpu((*p)->header.maxentry) >
> > +                             ((bn =3D=3D 0) ? XTROOTMAXSLOT : PSIZE >>=
 L2XTSLOTSIZE))) {
> > +                     jfs_error(ip->i_sb, "xt_getpage: xtree page corru=
pt\n");
> > +                     BT_PUTPAGE(*mp);
> > +                     *mp =3D NULL;
> > +                     rc =3D -EIO;
> > +             }
> > +     }
> > +     return rc;
> > +}
> > +
> >   /*
> >    *  xtLookup()
> >    *
> > @@ -252,7 +270,7 @@ static int xtSearch(struct inode *ip, s64 xoff,   s=
64 *nextp,
> >        */
> >       for (bn =3D 0;;) {
> >               /* get/pin the page to search */
> > -             XT_GETPAGE(ip, bn, mp, PSIZE, p, rc);
> > +             rc =3D xt_getpage(ip, bn, &mp, PSIZE, &p);
> >               if (rc)
> >                       return rc;
> >
> > @@ -807,7 +825,7 @@ xtSplitUp(tid_t tid,
> >                * insert router entry in parent for new right child page=
 <rp>
> >                */
> >               /* get/pin the parent page <sp> */
> > -             XT_GETPAGE(ip, parent->bn, smp, PSIZE, sp, rc);
> > +             rc =3D xt_getpage(ip, parent->bn, &smp, PSIZE, &sp);
> >               if (rc) {
> >                       XT_PUTPAGE(rcmp);
> >                       return rc;
> > @@ -1062,7 +1080,7 @@ xtSplitPage(tid_t tid, struct inode *ip,
> >        * update previous pointer of old next/right page of <sp>
> >        */
> >       if (nextbn !=3D 0) {
> > -             XT_GETPAGE(ip, nextbn, mp, PSIZE, p, rc);
> > +             rc =3D xt_getpage(ip, nextbn, &mp, PSIZE, &p);
> >               if (rc) {
> >                       XT_PUTPAGE(rmp);
> >                       goto clean_up;
> > @@ -1417,7 +1435,7 @@ int xtExtend(tid_t tid,         /* transaction id=
 */
> >                       return rc;
> >
> >               /* get back old page */
> > -             XT_GETPAGE(ip, bn, mp, PSIZE, p, rc);
> > +             rc =3D xt_getpage(ip, bn, &mp, PSIZE, &p);
> >               if (rc)
> >                       return rc;
> >               /*
> > @@ -1433,7 +1451,7 @@ int xtExtend(tid_t tid,         /* transaction id=
 */
> >                       XT_PUTPAGE(mp);
> >
> >                       /* get new child page */
> > -                     XT_GETPAGE(ip, bn, mp, PSIZE, p, rc);
> > +                     rc =3D xt_getpage(ip, bn, &mp, PSIZE, &p);
> >                       if (rc)
> >                               return rc;
> >
> > @@ -1711,7 +1729,7 @@ int xtUpdate(tid_t tid, struct inode *ip, xad_t *=
 nxad)
> >                       return rc;
> >
> >               /* get back old page */
> > -             XT_GETPAGE(ip, bn, mp, PSIZE, p, rc);
> > +             rc =3D xt_getpage(ip, bn, &mp, PSIZE, &p);
> >               if (rc)
> >                       return rc;
> >               /*
> > @@ -1727,7 +1745,7 @@ int xtUpdate(tid_t tid, struct inode *ip, xad_t *=
 nxad)
> >                       XT_PUTPAGE(mp);
> >
> >                       /* get new child page */
> > -                     XT_GETPAGE(ip, bn, mp, PSIZE, p, rc);
> > +                     rc =3D xt_getpage(ip, bn, &mp, PSIZE, &p);
> >                       if (rc)
> >                               return rc;
> >
> > @@ -1788,7 +1806,7 @@ int xtUpdate(tid_t tid, struct inode *ip, xad_t *=
 nxad)
> >               XT_PUTPAGE(mp);
> >
> >               /* get new right page */
> > -             XT_GETPAGE(ip, bn, mp, PSIZE, p, rc);
> > +             rc =3D xt_getpage(ip, bn, &mp, PSIZE, &p);
> >               if (rc)
> >                       return rc;
> >
> > @@ -1864,7 +1882,7 @@ printf("xtUpdate.updateLeft.split p:0x%p\n", p);
> >                       return rc;
> >
> >               /* get back old page */
> > -             XT_GETPAGE(ip, bn, mp, PSIZE, p, rc);
> > +             rc =3D xt_getpage(ip, bn, &mp, PSIZE, &p);
> >               if (rc)
> >                       return rc;
> >
> > @@ -1881,7 +1899,7 @@ printf("xtUpdate.updateLeft.split p:0x%p\n", p);
> >                       XT_PUTPAGE(mp);
> >
> >                       /* get new child page */
> > -                     XT_GETPAGE(ip, bn, mp, PSIZE, p, rc);
> > +                     rc =3D xt_getpage(ip, bn, &mp, PSIZE, &p);
> >                       if (rc)
> >                               return rc;
> >
> > @@ -2268,7 +2286,7 @@ s64 xtTruncate(tid_t tid, struct inode *ip, s64 n=
ewsize, int flag)
> >        * first access of each page:
> >        */
> >         getPage:
> > -     XT_GETPAGE(ip, bn, mp, PSIZE, p, rc);
> > +     rc =3D xt_getpage(ip, bn, &mp, PSIZE, &p);
> >       if (rc)
> >               return rc;
> >
> > @@ -2506,7 +2524,7 @@ s64 xtTruncate(tid_t tid, struct inode *ip, s64 n=
ewsize, int flag)
> >
> >       /* get back the parent page */
> >       bn =3D parent->bn;
> > -     XT_GETPAGE(ip, bn, mp, PSIZE, p, rc);
> > +     rc =3D xt_getpage(ip, bn, &mp, PSIZE, &p);
> >       if (rc)
> >               return rc;
> >
> > @@ -2791,7 +2809,7 @@ s64 xtTruncate_pmap(tid_t tid, struct inode *ip, =
s64 committed_size)
> >                * first access of each page:
> >                */
> >         getPage:
> > -             XT_GETPAGE(ip, bn, mp, PSIZE, p, rc);
> > +             rc =3D xt_getpage(ip, bn, &mp, PSIZE, &p);
> >               if (rc)
> >                       return rc;
> >
> > @@ -2836,7 +2854,7 @@ s64 xtTruncate_pmap(tid_t tid, struct inode *ip, =
s64 committed_size)
> >
> >       /* get back the parent page */
> >       bn =3D parent->bn;
> > -     XT_GETPAGE(ip, bn, mp, PSIZE, p, rc);
> > +     rc =3D xt_getpage(ip, bn, &mp, PSIZE, &p);
> >       if (rc)
> >               return rc;
> >
>

