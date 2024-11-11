Return-Path: <linux-kernel+bounces-404291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4B19C41FE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E141A1F22531
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40C219E83D;
	Mon, 11 Nov 2024 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3ei5kF+"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55925339A0
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731339377; cv=none; b=B4FXFGBy7W87XaCQteKnBGuUsVyx3L/PZECi6Uex6EdFpjyXlljtT34TBUc2aGCIlhidMw5NXkUF9sHJw5zWRc2LPRB2urUVCmzeFuMGnhvdni5qUFUzGcxj5s/r5Iy2J4s5m5RUK5hx3J/XopE6SSBBJWMTLgj37et1layQzv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731339377; c=relaxed/simple;
	bh=NRRKFI5CRLmFX/TFIsOeeIVmclbjK5DwanPrU3DqCJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYVUa0Dg8D2H8uHyGfH2YArC6+sWT/VwBQMKIESvTflh4xydXQQ7l8CHpl2Nh6nTMba2x+7BaacRaAa0sGFLxG4ISjS0DPUOcdqoRq3Zmu3XCoFydaPiobxFr5VqPRWbXB3g9HkQv3QMF/0pp/mRWWWidweFRuXuRXFf59AUPbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3ei5kF+; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a5f555cfbso393806266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 07:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731339373; x=1731944173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrQEGC9PRsm3JYQqZA9Dl5qL7FnUg8LFubc6nH6wGVg=;
        b=l3ei5kF+UHKOoWqiWqjhlLDEKhY9X6eWrbfzV4khKvJUM+ZDW2dNdfRluvFWANCSbR
         5wJ7gieOi8B5V/LGmBHfO7+1KiJVLaDz1aSzjR45xkiZF3zLroOKaCMhwxJoKmbSc6dW
         jm5s3aI/pel+ZS2nSg5fbY9JOynkYRP3bisbE/9gAMDydkboDLXnHKP0uyr4BQ6NchXy
         D4WGCRdr0+6ZgLX1MeqOosvHcbHDcty6pbkgcZNrzCv6WEY4KlYUk9D5ylVGMfP5FUZU
         9Z+3BgvFMcgfCZKohblnRWrwEFTwDmCZ6SAB8JkJ2QEVlYSNoppjam7e+3fwX6lW9G4R
         k4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731339373; x=1731944173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrQEGC9PRsm3JYQqZA9Dl5qL7FnUg8LFubc6nH6wGVg=;
        b=svfrK8/1sJg44clA5s73qSzfYBug4aD+DqyjWyo+sITkxaUMnxPVyvks6/hiJzWI+y
         7ixfm9zed1tpafyfiZbWXBf94zlWJ15IbBNq3UyF7R5aJoi9SsMF5I0Vtpjirgty4vQW
         qatIew2Ecn9A4u7y54Dgnh5Mjl39z1N7eMWwwQ6J0ea5HD3CtI+HQTWNK/rTMvSOj736
         8dP9k+QU9oIzdJ0zc7uPkijLysQlOwL+ynpG8HbbyzXWy8aIMeBi+CIrO3B5UJ0SWsSJ
         +Z/RtyY+o3Jpe94b2U+poeaxi0v4/pS5/Ha+XMcudQss/xwBlSioiWuYrLHIoZcKNzwR
         VpEg==
X-Gm-Message-State: AOJu0YwIxQLaGRhS/MDb0rT/HzMr9Gf2wZrYeC4KsOnBsWyubq2JX4Cd
	1KFztfY2mhcwoWOLZswbO7odb5ROC5HXdK3IUiark6Co0S/Oamn/JK2XheaiOxQosklkg8mlVx/
	DybxhI6WiGU5+VRN5y2UCjrXhMeA=
X-Google-Smtp-Source: AGHT+IFxaKpcSudgr7poq3Yca77MR1aHGU7ulfTSAs7BWro+39Z+DQGE1sNy+3RtK0tC416EJD0E1gq4UK10HWgb81U=
X-Received: by 2002:a05:6402:35d4:b0:5ce:af08:a2cd with SMTP id
 4fb4d7f45d1cf-5cf0a446916mr19079038a12.33.1731339373336; Mon, 11 Nov 2024
 07:36:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACzwLxjdRmD02Uu+3umNEvP-b9fXuT6WWS+a9gYhOeQEayK_ww@mail.gmail.com>
 <2024111124-hardly-jaundice-08c4@gregkh> <2024111129-hence-resigned-b2e7@gregkh>
In-Reply-To: <2024111129-hence-resigned-b2e7@gregkh>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Mon, 11 Nov 2024 20:36:01 +0500
Message-ID: <CACzwLxgUJ_kqPwXEZspfG5UXn+MwD5iD8f7vJWo7VTv4KbfRmA@mail.gmail.com>
Subject: Re: [RFC] syzkaller/docs: reporting kernel security bugs guide
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alexander Potapenko <glider@google.com>, 
	Aleksandr Nogikh <nogikh@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 7:42=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Nov 11, 2024 at 03:37:27PM +0100, Greg KH wrote:
> > On Mon, Nov 11, 2024 at 06:24:36PM +0500, Sabyrzhan Tasbolatov wrote:
> > > Hello,
> > >
> > > Greg,
> > > Could you please confirm that the updated version of
> > > reporting Linux kernel security bugs guide is correct
> > > since kernel.org is CNA as of February 13, 2024 and
> > > with linux-cve-announce reference?
> > >
> > > The updated doc and drawn diagram is available
> > > in this PR of syzkaller project:
> > > https://github.com/google/syzkaller/pull/5461
> >
> > I can't read this mess:
> >       https://github.com/google/syzkaller/pull/5461/commits/35b45ef3c46=
00fd62f5d05a17fc6855fc0b5e402
> >
> > So I have no idea, sorry.
>
> Ah, the graph is at the bottom of the page, kind of messy...
>
> Anyway, as I have stated numerous times, I DO NOT RECOMMEND EVER
> CONTACTING the linux-distros mailing list for lots of various reasons.
> You do so at your own risk and liability (i.e. doing so imparts a number
> of requirements on you!)

Thanks for the feedback! Sorry for the messy diagram :(
I don't have the real experience with kernel CVEs or contacting linux-distr=
os,
so this updated syzkaller documentation reflects only my understanding
based on reading guides from kernel.org and oss-security,
and also watching your recent OS Summit talk in Japan.

So I've wanted to update this guide for myself in the first place :)

> So be VERY VERY VERY careful to ever tell
> anyone to do so as the side affects can be very bad in some cases (i.e.
> they "blackmail" you to release information even if you don't have a
> fix.)
>
> good luck!
>
> greg k-h

From oss-security documentation [1] it's said:
[1] https://oss-security.openwall.org/wiki/mailing-lists/distros

> For Linux kernel issues, you must notify the kernel security team first, =
wait for the fix,
> and only then notify linux-distros or oss-security (depending on whether =
the information
> is still private or already public, as well as on issue severity).

I understand that their policy follows with security@kernel.org
interests to release the fix,
but it may be postponed if the reporter asks for an embargo period to
let linux-distros
prepare the update rollout during this embargo period and prior to the
bug disclosure,
the fix should be merged into the Linux kernel stable tree first.

If the reporter chooses not to request for an embargo period for
linux-distros sake,
then the fix is merged ASAP, CVE is assigned "after-the-fact" and the
reporter may
optionally report to oss-security, and linux-distros can pick the
merged fix post factum.
Personally, I prefer this option without the embargo period complexity.

But this is according to my non-experienced understanding, so there
are definitely pitfalls
I am not aware of.

So I'm still confused how the syzkaller doc should be updated,
perhaps it should just refer to existing kernel.org and oss-security guidel=
ines,
so the reporter should consider which option is preferable.

Andrey, please suggest as well or let me know
how to proceed with the syzkaller doc update.

Thanks

