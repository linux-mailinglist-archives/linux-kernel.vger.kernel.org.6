Return-Path: <linux-kernel+bounces-555547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5161EA5B95F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 07:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3BC33AC316
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 06:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3E81EBA0C;
	Tue, 11 Mar 2025 06:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSj6L1vD"
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415D2156861
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 06:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741675702; cv=none; b=Ok0vDmZyfGHRi54TDhkHfgk7edE5NWaB/OzL4rwVjlXacLyFTkoONM4tn5XlHutO2Uu0K32wZl2GlGWpO7Uuc/D/L3tbU4q5Z5y5pxCcpBk/yxtbp7ITJbAFnm0PL57x7cDbtJRAFLzhF8qcO/vfp1Q2WWqBB+EQoR7dptjXoy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741675702; c=relaxed/simple;
	bh=kdW4lBDadmuM4Z/e6yPR8yUiON/o70lgDWYdaej70Wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kvRlfOp6kQu/0NWD9PdeeaXY32tPCrhoYjrFSx6C+JL4XNfMJeIjjajfEQ7na1//432QUS4X9tpuiVqrI0aG+TmLHDZO0lezY4Mkh9NufdREi1fP3PaqA8pmOn5zxjzVOyaUo8vF4WRef0XFXdJrfuCgPqC3p3219WEU0Nf3Pzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSj6L1vD; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-6fda22908d9so38135797b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 23:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741675700; x=1742280500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOnoY/5kztlCwhF/Bn+TEbdQ0a8Ic09Wnz9SPxYkbho=;
        b=dSj6L1vDnheutz0RdTICNQNpAWrA+Q5jCPGrp9fALM3wQE1zzrHZmjKVOAgvwO3qSo
         WnmdvCJxuwEafPOLhasOaEEDBbpGFCx3p2ZNpMvJ2RP9JwpB9YhaAUe00KLzA5K4zCBc
         tpZ/2pBlZxqLuldPhAWAGLysRUOeldQ2foRqW5RRWhafAmnTmLSs+6fNyjRDF1Guj40F
         UvZUJj94XqtE8jCnYalbBoqrDF1p7ME3uLAdNESe23xWfvAll3gL9Aq9V9ro7mUAQz3A
         DndZLW4AqVC0zjvykucfyeZS042DjQFWta6JVsaa90X6goDqN96dci5HWghllMVF6xQr
         yaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741675700; x=1742280500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOnoY/5kztlCwhF/Bn+TEbdQ0a8Ic09Wnz9SPxYkbho=;
        b=MNLuoRkPAzDuPJbrIW/ZBJ53FmXlbCM+9USmITq8V+6rucHS0EOQfDGc8YDOX1f8hl
         5ya/Nc/4NQIVImcKTqUR+wKnVvLV+O1ImMfKnsBiismZ0QwztvzXEGjmrOLzjbiwdMyx
         atsB1nPb4aAs/wQCsBjLK6TOUurGjF6Kb8OGzaPLlo7+WU2JE7NAVwTwJPbapW+vWEPT
         YaogzCEcZ03KPjmqx6YI4RkCcbDfsFX8cc3gZGZfBuQf9zOsJuMW83i0FZn+E5FCNt+7
         +ui5cOATzbU0+CJS8cx/TdsaKYlUfVIdjq4pDQ7psqgXQTQLgHIAALy8guiB9t6XL3iW
         63pg==
X-Gm-Message-State: AOJu0YylGBV33h6v7tIo8Ra/oAq+I9P5OS3tljSgHvgXJnXFeUIIagYY
	IhgTYR2EPvffzAwVusttLos/98tlGajcHWanKHlNJlP7AehwGJhVNFNye5tZnv4tefVbf9aRqjX
	WitXP0LlOmQFYiz8DKek7v5UoJmBObS7vJhvrhsBg
X-Gm-Gg: ASbGncuWWI4pPLTagBfL4zirCQyU6OGQJAcNJlOS75S2WkGh+6dUd1T3nzSifcBxWX3
	Rhuw3ydgRjbBfpeaRzCf3DhN35HQt4Yo5nA6BHfW4OTO3L/2V3EJ+RuNvgIFE9shMS8BUxKECE7
	jtDbfmGoXvQmLQiAYkGuebC+1o1LIDZkib3GnyuxY5sYn309Fkp7iiNOP08J8=
X-Google-Smtp-Source: AGHT+IFQCg1K1NRXUHUZkHPAga69L2cGS8uouCiyHSDg/OMJb2jeC93rPn3TmYWI710dM2K4sm5LJz43eAYjlF4ychg=
X-Received: by 2002:a05:690c:6813:b0:6ef:4fba:8137 with SMTP id
 00721157ae682-6febf292796mr233690747b3.6.1741675699951; Mon, 10 Mar 2025
 23:48:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFf+5zj=KmBG0Avqy6cq9qtpGKR3HnYNc6rK6y8B_78Ajt4RhQ@mail.gmail.com>
 <20250311003554.GN2023217@ZenIV> <CAFf+5zjGKMSCYNZvOzaCNRFKHjWe2a6TKmmKqg7Fe-TLQW07yA@mail.gmail.com>
 <20250311044231.GO2023217@ZenIV>
In-Reply-To: <20250311044231.GO2023217@ZenIV>
From: Amit <amitchoudhary0523@gmail.com>
Date: Tue, 11 Mar 2025 12:18:08 +0530
X-Gm-Features: AQ5f1JqPXd4zm0WP4MffmU7O6IWPnEr7OyTZoQtf9n7cWIwuiGU5Z69MnD6-NZE
Message-ID: <CAFf+5ziTDC1RYyfwRMdYMxtdDmb1dk=PY4++2aM3e1M444zO8A@mail.gmail.com>
Subject: Re: Catching use-after-free easily in linux kernel.
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Mar 2025 at 10:12, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Mar 11, 2025 at 08:46:36AM +0530, Amit wrote:
> > On Tue, Mar 11, 2025, 6:05=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk>=
 wrote:
> >
> > > On Mon, Mar 10, 2025 at 01:24:54PM +0530, Amit wrote:
> > > > Hi,
> > > >
> > > > We can catch use-after-free easily if we do the following:
> > > >
> > > > kfree(x);
> > > > (x) =3D NULL;
> > > >
> > > > Now, if someone uses 'x' again then the kernel will crash and we wi=
ll
> > > know where
> > > > the use-after-free is happening and then we can fix it.
> > >
> > > That assumes that no pointer is ever stored in more than one place.
> > > Which is very clearly false.
> > >
> >
> >
> > I will do some experiments and then I will reply if I find something.
> >
> > I will introduce a global macro and then change all kfree() to this mac=
ro
> > name using cscope probably.
> >
> > Then I will compile the kernel and run the new kernel and see if some c=
rash
> > is happening or not.
>
> What would that test, exactly?  And why would that be any more useful tha=
n
> adding global variables named wank and magic and replacing every kfree(p)=
 with
> ((magic =3D wank++),kfree(p))?  That also would not introduce any crashes=
...

My test is quite evident from my first mail (kfree(x); x =3D NULL;).

Your example is nowhere related to my proposal.

So, either you didn't understand my issue properly or you thought that
I was a fool. That's ok.

You thought that I was a fool and I also think that you are a fool.

Tit for tat.

By the way, if you think that you are great because you are working in
the linux kernel then at least I don't think so.

I have also contributed a few patches to the linux kernel a long time
ago and they were mostly related to memory leaks.

Anyone who spends ""one year"" hacking the linux kernel will become a
great linux kernel programmer.

By the way, from my point of view, there's not much to do in the linux
kernel ""now"". The main part of the kernel is device drivers and
device drivers can only be written by people who have access to the
hardware and the data sheet of the hardware. And these guys are mostly
employed people in companies that release new hardware like Broadcom,
etc.

I had done a lot of hardware programming for ethernet switches at
Juniper Networks in the FreeBSD kernel.

I have worked on a few other kernels also - RT Linux, Nucleus OS,
HP-UX, and VxWorks.

If device drivers are taken out then there's not much work in the
kernel - the only things left will be filesystems and networking
subsystem and scheduling but probably there's not much to do there.

So, the real stuff in the kernel is done by people who work for
companies that develop new hardware and give the driver code to the
linux kernel.

Long time ago, I also worked on the linux kernel's wireless driver as
an employee of a company (my work was related to searching for new APs
if the signal quality falls below a certain threshold and then joining
an AP having the highest signal quality - this was not there in the
kernel at that time). However, the end client didn't give us the
permission to release the patches to the linux kernel.

I had also made modifications to the RT Linux kernel a long time ago,
basically related to scheduling and priority inversion.

Anyways, given all this, I actually don't think that people who work
in the linux kernel are great people EXCEPT LINUS TORVALDS.

Linus Torvalds is a great person and a great software engineer and he
doesn't have much ego and he doesn't throw around his ego over all
people.

----

