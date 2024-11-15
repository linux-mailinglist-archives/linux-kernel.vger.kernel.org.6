Return-Path: <linux-kernel+bounces-410338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F58D9CDA19
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 08:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CA76282626
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 07:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C25188A3A;
	Fri, 15 Nov 2024 07:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBXjALt8"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2574A288DA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 07:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731657269; cv=none; b=FTa/FOgzg1C75Ho45/Y2qyCff/1lXo0vr0fObJd/xIg10xDQMtiR3KfLa6hNtTbVgb4ZECJpZwof1+Au0f+ogve/yYIXD0SjHz8sje2BmOfNKrZXqScr6GW1AWHpegmWxODO3fOlSgxarOmUuT5C4BzKnN2l7ogjox+cpBvBwxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731657269; c=relaxed/simple;
	bh=gkq22GqUHbo4+rCf93eCZNaCT0EMkFnHj/INJLroDEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BUQptxco6NomJvLFsyEM3FMWlK/Q4xuC3ggUfJiH8o/5DjqDYuLqD2Ktqe2TTtR7c7CoO1GCvS+qxviJxwmFwZ8059wmEhfC/++10fkmBOpUzYvtSh0MkvWu9kntWbD9bum9V1bG/p9LNvBQvME0ytbym8brXSXDrgqcuwvNxd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBXjALt8; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e34339d41bso13900937b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 23:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731657265; x=1732262065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+niKqtPLFz4jhdE5k6gK8qLmYC/LgUzZi8oO4+OoWes=;
        b=hBXjALt8dhUR3P3Sy4qtoJ1gIaPz8U5QsAb9v1I3J7/S+40Sylr91WcD4QgIhYU9le
         FBNcL63R4rFAYZproewscbEWCHEV03yT/lXDTYQFCdYbufZyt+1F70wYao5IV9ziOEM2
         VLcdxAUd2NHsig6zAM6EOrq4DbO1nKqxQlMMY+XsWCDpawgINLcSaEr9gu5NCOCrQ+pz
         zk10PZ726n7Rycpfnudi58KM70cW/riOYGgZH3KfHz/NqCqU8NgqhxjhL2bPKVOalW2y
         YtuydEFaoD3JRnQeYoF+pvcq3JWGFaqRmKgI6GvWQyIQ/GRYa+RVeiN2x88Va1OIEHn7
         PBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731657265; x=1732262065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+niKqtPLFz4jhdE5k6gK8qLmYC/LgUzZi8oO4+OoWes=;
        b=v7AF0SbFZOPf8sNy8DD2+jjrxZAWiiRnCEajnSdTml8324/tWMM+Zn9PpjK/fUin94
         2cMa5Yn8eg1Gl2z9Hg4C575i25YpIo7q52RYp75/RSnTm+Uox9M9b7He9GMghECsf3V3
         UQMxq2yE4OZ0SOpTWI3wqH4Rt10JWGiA6sDEZWOrImrUYbDiX60ZhrEGIxREHUFQKIno
         CRV1rZ64tmM7bb5z88GLPbzvwF8ZG/Kv1fnDeo9oO6tbTKNcqw6Av5ADk8oZh4Cl/qtS
         y7BUeFzJRHI73YZW+FkdhrFHnDqkDt7Yt4mKuhbTkhx0cM8NVOhHX/EtIcC7uZxwBXrG
         fONQ==
X-Forwarded-Encrypted: i=1; AJvYcCVga1N+sv7qUbUEFAoiyI0J399Brc3QRDfacsj2xktdBf8glj2wDfoFVZ1LqSnOPQ8o+QxJNwqEDmk8A2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEVVY7bGs4ZO+eSRP44FSc4fdTdEStT6n3amf6UnXGKvcJCl4O
	l/E54SxkyZIaOYMq359D0s4Bb+5LnJAEYUZJg7N3oSLUoUWGQDMr02NGCd5LrgTY1/gd801e0pP
	6kAKPDLKQp8ujNmZTvF+0EM4HUHY=
X-Google-Smtp-Source: AGHT+IHYtsfenrdOoFGYEsxgKLqTPpPEKf4qOZSPWpIhwRzvpf1cjUW0a9+VRw3exOVz7yJGrVac9C2fZu0WtuRK4VY=
X-Received: by 2002:a05:690c:46c4:b0:6ea:95f5:25fb with SMTP id
 00721157ae682-6ee55bba137mr25813507b3.3.1731657264980; Thu, 14 Nov 2024
 23:54:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113084108.186506-1-danielyangkang@gmail.com> <50564a28-9c75-497f-a50c-22e08b1f794f@linux.alibaba.com>
In-Reply-To: <50564a28-9c75-497f-a50c-22e08b1f794f@linux.alibaba.com>
From: Daniel Yang <danielyangkang@gmail.com>
Date: Thu, 14 Nov 2024 23:53:49 -0800
Message-ID: <CAGiJo8RBBs-4ATOP-sJkE-TWiGxbXHaKQP+_qsGKTmWhuUwrBA@mail.gmail.com>
Subject: Re: [PATCH] ocfs2: heartbeat: replace simple_strtoul with kstrtoul
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	"open list:ORACLE CLUSTER FILESYSTEM 2 (OCFS2)" <ocfs2-devel@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 5:01=E2=80=AFPM Joseph Qi <joseph.qi@linux.alibaba.=
com> wrote:
>
>
>
> On 11/13/24 4:41 PM, Daniel Yang wrote:
> > The function simple_strtoul is deprecated due to ignoring overflows and
> > also requires clunkier error checking. Replacing with kstrtoul() leads
> > to safer code and cleaner error checking.
> >
> > Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> > ---
> >  fs/ocfs2/cluster/heartbeat.c | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.=
c
> > index dff18efbc..4fc1b23f1 100644
> > --- a/fs/ocfs2/cluster/heartbeat.c
> > +++ b/fs/ocfs2/cluster/heartbeat.c
> > @@ -1537,8 +1537,9 @@ static int o2hb_read_block_input(struct o2hb_regi=
on *reg,
> >       unsigned long bytes;
> >       char *p =3D (char *)page;
>
> Please define 'ret' here to make code style consistent.
> >
> > -     bytes =3D simple_strtoul(p, &p, 0);
> > -     if (!p || (*p && (*p !=3D '\n')))
> > +     int ret =3D kstrtoul(p, 0, &bytes);
> > +
>
> The above blane line can be eleminated.
>
> > +     if (ret)
> >               return -EINVAL;
> >
> >       /* Heartbeat and fs min / max block sizes are the same. */
> > @@ -1627,8 +1628,9 @@ static ssize_t o2hb_region_blocks_store(struct co=
nfig_item *item,
> >       if (reg->hr_bdev_file)
> >               return -EINVAL;
> >
> > -     tmp =3D simple_strtoul(p, &p, 0);
> > -     if (!p || (*p && (*p !=3D '\n')))
> > +     int ret =3D kstrtoul(p, 0, &tmp);
> > +
>
> Ditto.
>
> > +     if (ret)
> >               return -EINVAL;
> >
> >       if (tmp > O2NM_MAX_NODES || tmp =3D=3D 0)
> > @@ -2142,8 +2144,9 @@ static ssize_t o2hb_heartbeat_group_dead_threshol=
d_store(struct config_item *ite
> >       unsigned long tmp;
> >       char *p =3D (char *)page;
> >
> > -     tmp =3D simple_strtoul(p, &p, 10);
> > -     if (!p || (*p && (*p !=3D '\n')))
> > +     int ret =3D kstrtoul(p, 10, &tmp);
> > +
>
> Ditto.
>
> Thanks,
> Joseph
> > +     if (ret)
> >                  return -EINVAL;
> >
> >       /* this will validate ranges for us. */
>

Ok sounds good. I moved ret to the beginning of each function and
removed the empty line after each ret =3D kstrtoul() statement. I just
sent a v2 of this patch. Let me know if there's any other issues.

- Daniel

