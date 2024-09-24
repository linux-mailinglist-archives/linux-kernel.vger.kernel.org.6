Return-Path: <linux-kernel+bounces-336544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 455DB983C26
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FA44B223BB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 04:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B91F2E62C;
	Tue, 24 Sep 2024 04:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/dMSOuL"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1049C199B9
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 04:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727153601; cv=none; b=AZ5Ht9QVi3B9P9F81bcmTh8ai6aSWQUCdVNgPLWhLx7LeQ+0orGwXb6pxKmLz3mS/7CQHq42l26lhxjPjASOF+vZCyGO1ClZsxV74i48GXVAeUt7ERtR9KnqOtvLo32nUxOpeneoVy7a2EBqZ1yh+sxbrU/AvzlseVLIE6Jk3Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727153601; c=relaxed/simple;
	bh=oyH5kXZOrC47ppTSlaai8Vh9JQ5ytPhcRxX5MakXXAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G2XcOXnMTRwfjZeJ0azbFe0hT2N9njx69m+m2vnvNi9BV2ShxR85THDhtk9bEBg2zFdGREu44fuqGz/gQ9Eup8XsY2igAxJ8MwE2fvnT4tFqHtaKC5Zb0JQjENGCoGX2SUFCGHz9PcsTeeq5ZHXmG4rWutbZ34wNcYR8/5fX/J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/dMSOuL; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7c1324be8easo4437657a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 21:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727153599; x=1727758399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rpwkaa50VO3D/9Bt6JQ0W/3hztWR0tcDwqga2surH08=;
        b=i/dMSOuLuZ2o/eeZzhYGF18Qfxk7rUJAjFhOHFlFtoZtTyfGEZnGhm5b0W3usSIJqz
         2P/TNK35FlG3Riq7c5q8Rs6sSrCupZQJE3OEOMSkyKLjeTGAobeuqwQbLaole3knHiDS
         TzokFxEDWak5r4zD6robb/32Z29OydyjcG5dZViakNrUui4v0nGUQCL9tmlvXgRCkQBF
         ww0hznucs4fbo//8d05TqX19tDFc/sAU3/CdUx83DX74G52AJ+n2OOCp0Wtu8u4ahqU5
         kW1wgkCezBuzcHijw2RZbT0u7zdLuz1TIT0gtVtoDjrG0rnD+POm3ENm/eq3zawxhAVr
         Qz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727153599; x=1727758399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rpwkaa50VO3D/9Bt6JQ0W/3hztWR0tcDwqga2surH08=;
        b=PdQFb2pgJ/OgJgig2yp9wQGF2Z0DjouMgW2L2j0nd3mx3aYunm6EJ+mUxB/VGh1ZGi
         DmCK18hbQ59w23uxy3pnGWrBqx1UGvkEwJF93jMISBoyzZgQ1FQmOxXBadShiPNPm5gj
         qZFfGSFoJu9bbETA2mYr25z0aY+tHVwSMbUn8PtJeqHJZZCnAgdh9/DtogKlUHx4IlR9
         Tx/N2W1plMGPJnGtmLDeipoUvq9a0dNkxv/+WzDIAF3CvygCyrqheyPLfNlayQIM/pwM
         3WJHzKuWkLvSiOm3JG7QA6Wese3tpkNa4CvN3Nqs1VvsNk1tLsmaVWpUOWkqWkTacaas
         qfUg==
X-Forwarded-Encrypted: i=1; AJvYcCVWexW4EuuUkB1iwB/hF518xsqyHxX+2Dd000CzVqpiqcg+CtGvScC2umckKu5wG48ViaEHx8PBtOMpGRI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Tvwu0yylSrmumcKg4wQXq4k5BWHZoflXuAJ8tByC68A6PxnR
	DyqBNnIt4E4JliGZqG/Pn0buLg2TxNkvJBjSd4c3TEEs0rClSJaw/WhtMsYb3tytboni+3Uv0B2
	pX9poiUU2ZBNy99TBpH9D6WlP3pE=
X-Google-Smtp-Source: AGHT+IFB9cNAizzUuWCC8bM85CWmAJ0+OLtbnwCNyl4sSUEnXEB4U3y3Sj9RKTs0F7+BffSFxw6nbF1+vsb9Qmhf9UE=
X-Received: by 2002:a17:90a:ce08:b0:2c9:7343:71f1 with SMTP id
 98e67ed59e1d1-2e05686d07cmr2856272a91.14.1727153599110; Mon, 23 Sep 2024
 21:53:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922110000.128650-1-ghanshyam1898@gmail.com>
 <c9f80af9-4cf0-4b6e-8c61-4b7a6f287cd9@wanadoo.fr> <CAG-BmocfstJNC-JDgtx93EJmg5kMANu4tVRbjqYtZ1CE+AEnEg@mail.gmail.com>
 <470de7f0-3f2d-444b-a949-9db6040cf371@wanadoo.fr>
In-Reply-To: <470de7f0-3f2d-444b-a949-9db6040cf371@wanadoo.fr>
From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Date: Tue, 24 Sep 2024 10:22:42 +0530
Message-ID: <CAG-BmocmdoLv5AR0p69J6JMOwrrQAn32ProJWzH=x5AyeZCfeA@mail.gmail.com>
Subject: Re: [PATCH] jfs: fix array-index-out-of-bounds
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: shaggy@kernel.org, ghandatmanas@gmail.com, jlayton@kernel.org, 
	eadavis@qq.com, brauner@kernel.org, jfs-discussion@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, 
	syzbot+808f3f84407f08a93022@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 2:15=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 23/09/2024 =C3=A0 05:35, Ghanshyam Agrawal a =C3=A9crit :
> > On Sun, Sep 22, 2024 at 8:35=E2=80=AFPM Christophe JAILLET
> > <christophe.jaillet@wanadoo.fr> wrote:
> >>
> >> Le 22/09/2024 =C3=A0 13:00, Ghanshyam Agrawal a =C3=A9crit :
> >>> In some cases, dn_numag may be greater than MAXAG which may
> >>> result in an array-index-out-of-bounds in dbNextAG. Added
> >>> a check to return an error code before we crash.
> >>>
> >>> Reported-by: syzbot+808f3f84407f08a93022@syzkaller.appspotmail.com
> >>> Closes: https://syzkaller.appspot.com/bug?extid=3D808f3f84407f08a9302=
2
> >>> Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
> >>> ---
> >>>    fs/jfs/jfs_imap.c | 3 +++
> >>>    1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
> >>> index 2ec35889ad24..5088da13e8f1 100644
> >>> --- a/fs/jfs/jfs_imap.c
> >>> +++ b/fs/jfs/jfs_imap.c
> >>> @@ -1360,6 +1360,9 @@ int diAlloc(struct inode *pip, bool dir, struct=
 inode *ip)
> >>>        if (agno < 0 || agno > dn_numag)
> >>>                return -EIO;
> >>>
> >>> +     if (unlikely(dn_numag > MAXAG))
> >>
> >> Hi,
> >>
> >> looking at other places with checks with MAXAG, I wonder if it should =
be >=3D?
> >>
> >> CJ
> >>
> >>> +             return -EIO;
> >>> +
> >>>        if (atomic_read(&JFS_SBI(pip->i_sb)->bmap->db_active[agno])) {
> >>>                /*
> >>>                 * There is an open file actively growing.  We want to
> >>
> >
> > Hello Christophe,
> >
> > Thanks for reviewing my code. I believe the greater than symbol I have
> > set is correct in this case.
>
> I think it's not.
>
> If you have "if (unlikely(dn_numag > MAXAG))", then
>
>         - dn_numag can be =3D MAXAG
>         - [2] - so, agno can be =3D MAXAG as well
>         - [3] - and, accessing memory past the end of the array will happ=
en,
> because db_active is atomic_t db_active[MAXAG];
>         - BUG
>
> Or I miss something obvious?
>
> > Can you please check it thoroughly and letme know wny it should be >=3D=
 ?
>
> Well, usually things don't work that way.
>
> YOU propose to fix something, which is nice. So YOU should explain why
> it is correct.
>
> If I'm correct, the way to see that your fix is incomplete is just in
> the 3 or 4 lines just above and below your change.
>
> You've been told what could be wrong, you could have checked yourself.
> Or explained the reasoning that makes you think it is correct.
>
>
>
> Sorry if my answer looks rude, it is not my intend. I just read your
> answer as "can you do my home work for me", which is certainly not you
> intend either.
>
> So, no hard felling, but a bit disappointed by the lack of curiosity.
>
> CJ
>
> >
> > Thanks & Regards,
> > Ghanshyam Agrawal
> >
>
>
> [1]: https://elixir.bootlin.com/linux/v6.11/source/fs/jfs/jfs_imap.c#L136=
3
>
> [2]: https://elixir.bootlin.com/linux/v6.11/source/fs/jfs/jfs_imap.c#L136=
3
>
> [3]: https://elixir.bootlin.com/linux/v6.11/source/fs/jfs/jfs_imap.c#L136=
6
>

Hello Christophe,

Thanks for your detailed answer and comments. I had done my research
and couldn't find the reason to change the operator and then requested
for your clarification. I should have been able to do that. I will work on =
that.

Thank you for taking time to explain me your thoughts. You are right.
The operator should indeed be >=3D.

I also just found out that someone recently fixed this bug and their patch
has gotten accepted. I wonder how I could have found that out before
working on my patch. Since they neither sent the patch to syzkaller for
testing nor did they include the fixes tag with a syzkaller link, I couldn'=
t
find it out. Maybe they found this bug from some other channel and
not syzkaller. I will find a way to address this as well.

Thanks again for taking time to review my patch and discuss it
with me.

Best Regards,
Ghanshyam Agrawal

