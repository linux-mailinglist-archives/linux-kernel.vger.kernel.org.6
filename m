Return-Path: <linux-kernel+bounces-302906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBCF9604D9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0B6D1C225E4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DF719DF48;
	Tue, 27 Aug 2024 08:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCrobTB1"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82A819925F
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 08:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748494; cv=none; b=JgDw+DYY3ei0eZT20GVDxRoXUKKrcslN0qZqpe/mrAU75aGoVTJkdyqWc/Wqnkj3BIvy0VmQ1CsjoaBjLDDg8mV7Nxa5wVPYFQyj7NzD55BBtjIAvUKENm2egQzaEXlylLioKLo1wS5mWXhoSJN7yVyCAD5xCJ6ndpMr0Zx+KyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748494; c=relaxed/simple;
	bh=lyUq6uzIFLGApAFk8uAkLlzZWO6fwqnEeSVsD5zPCLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+34FUQKaMDM7U+Dp/UGZ8qqRSQXaShH7c+UpgFLPxLRQmaGIiXePhIlWQHejRUXEbpeSZBW0CGjes2wRkLCANSSeqfwvNZBYwJRzgwRqjWjP9i15/O8aJvAzZfB97dqRGf+Pvqzyhn8uGlZ1Ea7219BeFMuCj5J5w5Zt64H02E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCrobTB1; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f3fea6a0a9so46145921fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 01:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724748491; x=1725353291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kDKIOwTEd6w8yb+ASnRf9bhshqBEl1pUBH6pCnSK/I=;
        b=iCrobTB13dkqj/f9stErm9mYjzqkf0OdzoLqfGbEB82b1BDSZFXOMRqAgGFC74gioY
         ydZ9bRerVQRqUNo60OO2ODSA46p+XUye2j8ckJxjbpc7QnCI23gg7n2+yGI8X37P0A1A
         beM89RrgzzR4wOkU01fYWm/GOlsjIR3OQwU4xl6K/6WBSJcr9z/2X/013V/kMw8Qxyw6
         PYFR6Yycx1GHGAaZre8nle5OzpISyUNKHqya0aeYKx7zyOm9Pu8MrhFponaQcP3bzxMx
         TqZVclTjaFBRCFGbZtmLeUOds/FYTU7tvUMwLeOC2QAxbKetPelyKT1r3XO8NTGoz/aQ
         Ja2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724748491; x=1725353291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8kDKIOwTEd6w8yb+ASnRf9bhshqBEl1pUBH6pCnSK/I=;
        b=naEsq3t5mpfNMGPqdlWctYF1bieU1T64cRnluyBSTgF/a2rOHvYTiGODwRzmMefwP2
         uARNubRCrI88+lGTo0vAB6nkYtSQ8KDDHQqw6jWETmbpU+I6CKv48GQ3hhuE5PhMhIb1
         GPjzDCmCBtqzk/i6R3PtzqQkx/rKBK5kVqpDS4ApcOBGzLK7UFmqgJhfwClb+JlATiCk
         OPQsY6XvEY9JrMIaQymUGusDzVkP7ZFCgtr8DgRtXXFj+0lXfwd8Zyh1CEe/XHqO2OVS
         qnLaUb4iURegr5rBJRxjzG20rQCR3bf1o5To9XRsjqquOO3y29aHscY72+zEEpkwRX9x
         tVag==
X-Forwarded-Encrypted: i=1; AJvYcCUlft7eC3JX0EhB1dElUWJwV8PLZGhgKww3D3/ScShjBWnI778/GyA/w01OkeNpjY+iPSdZWK/E/1EWj+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxxDTeI+K6Cc6Qoht3iMbJ3I/mrcmdQuh+yn4qLmJDVX1F5De4
	u1b0ZLHY3iy7V3kthu0MddYtCMGDEQOmNu5EcEL3xy5Zu8vN70rm4LNeCwca3gyEBsHYgaBy7ok
	r3frUbh+PPWpysqFY0V91rGK4t88=
X-Google-Smtp-Source: AGHT+IHfzEjvAa6juUPHsEOAGjLWPcwPUMqsodqfndjPZiVuX++xmoBVqhxYgl03omfSpxoIUvlKwJD7cx+EtDranMw=
X-Received: by 2002:a05:651c:b0a:b0:2ef:1c05:6907 with SMTP id
 38308e7fff4ca-2f514b7a52bmr8112801fa.5.1724748490547; Tue, 27 Aug 2024
 01:48:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYuFDon59=Nw6WCdgp0FanZ1oE3dCkoq71EK0Bxe6Jhe_g@mail.gmail.com>
 <CA+G9fYtd1Hw9YLpceUAwwC+UytVQVXOET4gmGT9jiCgHa+WexQ@mail.gmail.com>
 <CAMgjq7Bz0DY+rY0XgCoH7-Q=uHLdo3omi8kUr4ePDweNyofsbQ@mail.gmail.com>
 <20240819220548.d8f1ea5cf504cfd8feb5780e@linux-foundation.org> <CACePvbVJab1QNv35jepKYVdXV1Brnn=sTwBx7Vs5fr-93jDQvQ@mail.gmail.com>
In-Reply-To: <CACePvbVJab1QNv35jepKYVdXV1Brnn=sTwBx7Vs5fr-93jDQvQ@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 27 Aug 2024 16:47:54 +0800
Message-ID: <CAMgjq7A7k7FvZM=cGXiz9q9YuQD4iH5H_Og4wY0ENSgHiVdDYg@mail.gmail.com>
Subject: Re: gcc-8: mm/swapfile.c:863:40: error: array subscript 1 is above
 array bounds of 'struct list_head[1]' [-Werror=array-bounds]
To: Chris Li <chrisl@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, linux-mm <linux-mm@kvack.org>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, Barry Song <21cnbao@gmail.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Hugh Dickins <hughd@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 4:51=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> On Mon, Aug 19, 2024 at 10:05=E2=80=AFPM Andrew Morton
> <akpm@linux-foundation.org> wrote:
> >
> > On Mon, 19 Aug 2024 19:44:25 +0800 Kairui Song <ryncsn@gmail.com> wrote=
:
> >
> > > --- a/mm/swapfile.c
> > > +++ b/mm/swapfile.c
> > > @@ -836,7 +836,7 @@ static unsigned long cluster_alloc_swap_entry(str=
uct swap_info_struct *si, int o
> > >               goto done;
> > >
> > >       /* Order 0 stealing from higher order */
> > > -     for (int o =3D 1; o < PMD_ORDER; o++) {
> > > +     for (int o =3D 1; o < SWAP_NR_ORDERS; o++) {
> > >               /*
> > >                * Clusters here have at least one usable slots and can=
't fail order 0
> > >                * allocation, but reclaim may drop si->lock and race w=
ith another user.
> >
> > OK, I got that landed in the right place, but...
> >
> > The definition of `o' within the for statement isn't typical kernel
> > style - I'm surprised we didn't get a warning for this - maybe things
> > have changed when I wasn't looking.
>
> Noted.
>
> I did use the checkpatch.pl and fixed all the warnings before I sent
> the patch out.
> The checkpatch.pl script did not complain about this. Sure I can stay
> away from it.
> BTW, I did  a search on the kernel tree:
> $ rg 'for \(int' | wc -l
> 970
> $
> It seems pretty common in the kernel tree now.

Might be off topic from the issue...

I believe this issue it's not an upstream problem nowadays after
e8c07082a810 ("Kbuild: move to -std=3Dgnu11"), I did notice a GCC error
after backporting these commits to an older kernel which still used
c89, but for upstream this should be OK?

>
> >
> > Also, this code makes no attempt to honor our "The preferred limit on
> > the length of a single line is 80 columns" objective.  There's just no
> > reason for comment blocks to violate this.
>
> I was wondering why the checkpatch.pl did not catch this, is there any
> config for checkpatch.pl I should apply?
>
> I typically invoke:
>
> ./scripts/checkpatch.pl -g HEAD

I found checkpatch.pl stopped checking for 80 columns limit after
commit bdc48fa11e46 ("checkpatch/coding-style: deprecate 80-column
warning") 4 years ago. But the 80 column limit seems still preferred?

