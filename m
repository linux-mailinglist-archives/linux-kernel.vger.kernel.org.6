Return-Path: <linux-kernel+bounces-335396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9866F97E4FE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 05:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83BC9B20D51
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 03:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BFC8462;
	Mon, 23 Sep 2024 03:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yry4K98F"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE012139D
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 03:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727062552; cv=none; b=jexGolqnr2+5vCRp3rj1SHVbchQgvLNHpbKDOEE3lXKAkZIDsxpGoPv1+2Yo9i73VyACx9GlACbqOTlc9jNs67EEvsj8AcaQXt21bRlvQiog4kGtWKdt5LPADHrMChOxnr6fLsoveyLwFuQvluvaaiTwRS8/QUx0mwgWyF9wb24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727062552; c=relaxed/simple;
	bh=FpUZ+NHq2dcHVW6bWRq7UMSDbCK0IKHSy5HYVKdI7o8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EUzz6krZrX68iXz7W/kHEheo1aY8dmDXp1nEzj3EfCQePGfCx7Xg8X9QcjwD462TF2VTpr7sCTFuBP3JUUbzRnKIsGHZXP+MRUrZsmqqUOwA0TyQOGJAraBqob734bta1pLJcSS3a+eid14DiVDBWBRAYX2kSkgLmLzyUy5IN5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yry4K98F; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20551eeba95so32905545ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 20:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727062550; x=1727667350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//Q7GU5IrneEyxviJntAp1AonKejz1y+X80/DuCcShU=;
        b=Yry4K98FJkywdGaeW0AtI+gZUcKxLJ2+WdgFvfJNDzmJvsS+eMG915Nj3tKMPM5nAM
         eP8zgU/TC3u0JQS+lEtSEDQ6Z3ZNy39BdWS+5YmBF/m75NSrcxIcg2BEUQ0vgil+TVOg
         tCUpzei1QfFy2eSZuLV6OQ0+gaeNI1ZhlOusJ3NyFbmqS1gAd9mmWcxhoiaPP+lt7IAX
         9viFKqE4wFwptP7KLgNF/VqwPQQfF4CBnhDwyvRSFHO3nQ+aQ+yFK95yLrqqzVPNmAYC
         gxQu6WqaCF2Wy6/XisMwQWHCyBth3rDs7Fd1v+E7zX0QWr5ODJeC0UmhjqDgQ2JkeQ4Q
         TvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727062550; x=1727667350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=//Q7GU5IrneEyxviJntAp1AonKejz1y+X80/DuCcShU=;
        b=FmIALCY5eIH0Vwcg/Y400UTFBsiRmb4QPhRSisQkJFCK8cThNDZnZEFj2foD0KdlxR
         +UYr7/hXtLyXjCDlcaSDwar3BFawsippej2cHVBdcAtjWuNgD2jIUD2G1X5KeKazRPkN
         N8kWYEFeLAy2zJ+LbVua5nfG5D4a1Xx6leY7MAV6oTo1DSfwETz4/gXVD9PzZTtjw/h7
         qHzYSwsv47oQlAuuPakC87KCY6M9B0p1bqwVFFE4zhq+wga4X3uJq24lzKqQvhEpnIbU
         vMP99O7X5yTBKrcKatIZ9fkcQlzP10jCUktDtwQnREqf+Qc0ayOfdYAQZTydhZutBfMR
         Tc8w==
X-Forwarded-Encrypted: i=1; AJvYcCWsSM/b3Dz9S1RiMP37xzi7AHWQHKeBTNLftXclFnsvJdYtPls67QJLaLdsKpLXg18d+NhN1WfNwtEqa5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuPhF+oM1x9WQZHegesS3NX0uySYud06N3T99uLl98gMeueNoh
	mYSh3uE5IuimFiPi1udqXDCZZFrkQqBoAYgAuYg80GWjb2u9TcUwJDPnz7gXJ04yRrqqgMEOxbC
	Za73uuNuSVMqMc2Hra76ovA2+k0U=
X-Google-Smtp-Source: AGHT+IHsrzIz6wtS9qlSuGP1L/mTxxc1W6yP/zwzDwWmRy48P/cYkG5TEbm5Fp/SKjzlOwRg/SSPzy/xv6nusr3fWD8=
X-Received: by 2002:a17:902:e5ca:b0:206:cbf0:3089 with SMTP id
 d9443c01a7336-208d8566916mr138808665ad.54.1727062550091; Sun, 22 Sep 2024
 20:35:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922110000.128650-1-ghanshyam1898@gmail.com> <c9f80af9-4cf0-4b6e-8c61-4b7a6f287cd9@wanadoo.fr>
In-Reply-To: <c9f80af9-4cf0-4b6e-8c61-4b7a6f287cd9@wanadoo.fr>
From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Date: Mon, 23 Sep 2024 09:05:13 +0530
Message-ID: <CAG-BmocfstJNC-JDgtx93EJmg5kMANu4tVRbjqYtZ1CE+AEnEg@mail.gmail.com>
Subject: Re: [PATCH] jfs: fix array-index-out-of-bounds
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: shaggy@kernel.org, ghandatmanas@gmail.com, jlayton@kernel.org, 
	eadavis@qq.com, brauner@kernel.org, jfs-discussion@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, 
	syzbot+808f3f84407f08a93022@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 22, 2024 at 8:35=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 22/09/2024 =C3=A0 13:00, Ghanshyam Agrawal a =C3=A9crit :
> > In some cases, dn_numag may be greater than MAXAG which may
> > result in an array-index-out-of-bounds in dbNextAG. Added
> > a check to return an error code before we crash.
> >
> > Reported-by: syzbot+808f3f84407f08a93022@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D808f3f84407f08a93022
> > Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
> > ---
> >   fs/jfs/jfs_imap.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
> > index 2ec35889ad24..5088da13e8f1 100644
> > --- a/fs/jfs/jfs_imap.c
> > +++ b/fs/jfs/jfs_imap.c
> > @@ -1360,6 +1360,9 @@ int diAlloc(struct inode *pip, bool dir, struct i=
node *ip)
> >       if (agno < 0 || agno > dn_numag)
> >               return -EIO;
> >
> > +     if (unlikely(dn_numag > MAXAG))
>
> Hi,
>
> looking at other places with checks with MAXAG, I wonder if it should be =
>=3D?
>
> CJ
>
> > +             return -EIO;
> > +
> >       if (atomic_read(&JFS_SBI(pip->i_sb)->bmap->db_active[agno])) {
> >               /*
> >                * There is an open file actively growing.  We want to
>

Hello Christophe,

Thanks for reviewing my code. I believe the greater than symbol I have
set is correct in this case. Can you please check it thoroughly and let
me know wny it should be >=3D ?

Thanks & Regards,
Ghanshyam Agrawal

