Return-Path: <linux-kernel+bounces-412268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBD69D06A4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 22:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF8EA1F21FC2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 21:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45B31DDA3D;
	Sun, 17 Nov 2024 21:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4knygqh"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEBB49627
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 21:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731880435; cv=none; b=ggkn+EEoQz5U0OVT3BUtE2fyox/wTl6ljEkMfr6wQJRz9WTg81A3bG9ar43Qk1INEyiey9H7p9LeZTI6lhP8HBSCPumeoBs4cnvL3ni8UU/Kbr1OGr95CYO4k84s6CTlv4mMPs/CvwlOehyBe3qMq7lx+WHg9IoWIZJmGpdjenc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731880435; c=relaxed/simple;
	bh=tQFDHxJkmFPFr/ARzBU1zOmRTEgK+j0z8NscZUYKTXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q21CzUnLAaa/Anet6hcZMQTsuhYwFqcmOOvGGdLWOH0Mq5ifnuZjOydJ7Uv8fiGUBMMWToTBh2x423U2Dm69tYBinJBB1Msf/tGa6VlzJ8K8/m9S4UEGzqV/QUkD6trZEBqIw6RcdEtFO+sFuGsumQLwuXNcJVi9zR98ALSZHco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4knygqh; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6ee6a2ae6ecso15615657b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 13:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731880433; x=1732485233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xl6v2lcDSmPgGWlnJakrc1Lm5CUHk6H8asT7A+17yYg=;
        b=H4knygqhqw2gsVHNeIza8WnZEgk9pu5aWJ4bngddGoQ7vdI2p2Sxmzlz+xWo7rNeVB
         31qjkZkGzm39jPAf5sA6zgBd4PmKPsw9mi1J6WRdMGCf59ns4dtVBBEwCIf+ZLvC9ZzT
         56Q81U3CRYYkRnTS+q3bEloVLAlfIXlopDVKWeRZt5E3l5Nv/ixEkJv2GzPscZhvDUR5
         bO8shCi6ce8U0z345FutlStfAaX+r3WWRxrFS2V61TrJoQWntyWVSgXcFjKPjv5/yIPh
         vM5wqMouusWkOOsMkUSO3MP+Bh5trMpr3oqtq42kXWDLT7Aupg4XFnEMokoGeCWVaxQ+
         fQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731880433; x=1732485233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xl6v2lcDSmPgGWlnJakrc1Lm5CUHk6H8asT7A+17yYg=;
        b=Q8ITkUdnR/JDYFfkgePgFMcRSuENpduevwMHQb8SF0NzoGQOxtzk43fOYYTfC4p6Wr
         bGQv1cQMUcg1xyayX0s+n0b83HZ4NBC70F6iBPrNNrnL1XOD1C7OGZqmhrb+7qDg1D+K
         x3WqA1r1eAVqOBqGsrv3j6FjDTohOV3MSyptbUGAOCIHUkM+qyZtAeC337XB427fqUDN
         sNP5Wb76teTmXu0aEHyABSAswA+cf+vnBELr7MDssU5fd1Kh9+M5Dk52fA+4CFt2TjzV
         TlBrp+UmNYMctDppTxsChX6BYphOo8Vb2RF1zZnz4MsRY4UYoAtQgPWGsohCg4hC5Q8I
         IjsA==
X-Forwarded-Encrypted: i=1; AJvYcCXurs7ppQqQoCqgNKuLAYeBkwSpSUqHgjBe2WPX9EV7NlxiWbvYv/WPDZXEdEWNPsywAf0aJ1MAOU7+oOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZFAk4N16yZ/PN/0tGJmEycj9vjKllHI+umaVlF8dciwDAJUvO
	/qt7RnFcnh0AWEFyAIEj4A9WCA9hllTYloTxWhZofkC0Edj08divs1wNE8eUrkX6TaGtUfoTBDw
	Wl0MKjPaDZGEweTaOl421qFHZfZC0yl9x
X-Google-Smtp-Source: AGHT+IGvRlSN7yj2pEImEoAlALeMN3fP9oCuhHEeEy/Kmyoa4qxcXAVF07R6JGNBqNkuh1vJzIamy7RbSQxqmGFGaG4=
X-Received: by 2002:a05:690c:c96:b0:6ec:b74d:a0ec with SMTP id
 00721157ae682-6ee55a83a69mr90116067b3.20.1731880432783; Sun, 17 Nov 2024
 13:53:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115075131.4457-1-danielyangkang@gmail.com> <ce0227ac-0262-46b7-8f77-6f6953b549ae@linux.alibaba.com>
In-Reply-To: <ce0227ac-0262-46b7-8f77-6f6953b549ae@linux.alibaba.com>
From: Daniel Yang <danielyangkang@gmail.com>
Date: Sun, 17 Nov 2024 13:53:16 -0800
Message-ID: <CAGiJo8QB4bwkZ6=FcXk+k+3VxH=XPmOX4DzNq7sXcQ=T3v8K6Q@mail.gmail.com>
Subject: Re: [PATCH v2] ocfs2: heartbeat: replace simple_strtoul with kstrtoul
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: "open list:ORACLE CLUSTER FILESYSTEM 2 (OCFS2)" <ocfs2-devel@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, 
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 17, 2024 at 4:37=E2=80=AFAM Joseph Qi <joseph.qi@linux.alibaba.=
com> wrote:
>
>
>
> On 11/15/24 3:51 PM, Daniel Yang wrote:
> > The function simple_strtoul is deprecated due to ignoring overflows and
> > also requires clunkier error checking. Replacing with kstrtoul() leads
> > to safer code and cleaner error checking.
> >
> > Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> > ---
> > v1->v2: moved ret definition and removed blank lines
> >
> >  fs/ocfs2/cluster/heartbeat.c | 15 +++++++--------
> >  1 file changed, 7 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.=
c
> > index dff18efbc..84ee5e340 100644
> > --- a/fs/ocfs2/cluster/heartbeat.c
> > +++ b/fs/ocfs2/cluster/heartbeat.c
> > @@ -1536,9 +1536,8 @@ static int o2hb_read_block_input(struct o2hb_regi=
on *reg,
> >  {
> >       unsigned long bytes;
> >       char *p =3D (char *)page;
> > -
> > -     bytes =3D simple_strtoul(p, &p, 0);
> > -     if (!p || (*p && (*p !=3D '\n')))
> > +     int ret =3D kstrtoul(p, 0, &bytes);
> > +     if (ret)
>
> The preferred code style is:
>
> ...
> int ret;
>
> ret =3D kstrtoul(p, 0, &bytes);
> if (ret < 0)
>         return ret;
>
> >               return -EINVAL;
> >
> >       /* Heartbeat and fs min / max block sizes are the same. */
> > @@ -1623,12 +1622,13 @@ static ssize_t o2hb_region_blocks_store(struct =
config_item *item,
> >       struct o2hb_region *reg =3D to_o2hb_region(item);
> >       unsigned long tmp;
> >       char *p =3D (char *)page;
> > +     int ret;
> >
> >       if (reg->hr_bdev_file)
> >               return -EINVAL;
> >
> > -     tmp =3D simple_strtoul(p, &p, 0);
> > -     if (!p || (*p && (*p !=3D '\n')))
> > +     ret =3D kstrtoul(p, 0, &tmp);
> > +     if (ret)
> >               return -EINVAL;
>
> Better to return 'ret' directly since it may be -ERANGE.
>
> >
> >       if (tmp > O2NM_MAX_NODES || tmp =3D=3D 0)
> > @@ -2141,9 +2141,8 @@ static ssize_t o2hb_heartbeat_group_dead_threshol=
d_store(struct config_item *ite
> >  {
> >       unsigned long tmp;
> >       char *p =3D (char *)page;
> > -
> > -     tmp =3D simple_strtoul(p, &p, 10);
> > -     if (!p || (*p && (*p !=3D '\n')))
> > +     int ret =3D kstrtoul(p, 10, &tmp);
> > +     if (ret)
> >                  return -EINVAL;
>
> Prefer to:
>
> ...
> int ret;
>
> ret =3D kstrtoul(p, 10, &tmp);
> if (ret < 0)
>         return ret;
>
> Thanks,
> Joseph
> >
> >       /* this will validate ranges for us. */
>

Thanks for the clarification. I applied the changes and sent a v3 of the pa=
tch.

- Daniel

