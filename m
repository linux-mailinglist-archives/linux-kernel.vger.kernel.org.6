Return-Path: <linux-kernel+bounces-260620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9B193ABB4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 05:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 055EF1F23377
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 03:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598DE22067;
	Wed, 24 Jul 2024 03:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yNyu+4vg"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7FF1C687
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 03:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721793585; cv=none; b=ciEYeRx9W1EzRa1+U718NEkoOiGSHis62vCGYJvycvtiFQyPkecRJdyx/cQw8uleUHPdY6mtv1wmVkzPhPToZO5ANWulghaWujFG6qJLpTQGbw5yw8lO+lGDYSvaxZ4PrBmz569peefWIcVfvhD7uv/auCRmncmhjZQRSHBY0C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721793585; c=relaxed/simple;
	bh=xxF3BJrYXETz10Fa0A/YLPnOowlWRzEN9QfhTHhVFyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OrSg8JIx59xBCE5IhlPZ3a1Yzrs+PK11cKvjEd9SuTLDPl8eEd53hf3G7HdpdW4xAojkY0eWVewq3ngl148Bn5Yxjz7EpPeX29WWkHuw7kuFonWcsXnai0zdQMxNlYumLkFfamO+UmGCbyhl7YMNaqoUTz6U6YkBbhvlP82JfpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yNyu+4vg; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so7107a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 20:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721793582; x=1722398382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WT9z8M2iuMl54kp7uBvHCatMsJNaK2roQcf8LETvNo=;
        b=yNyu+4vgjzmQHrKRth9jJPu0P19GElqpjtIbCDX3sYrQ7lluQExQ0EXLXx3HhH1pBd
         qZBy6+cO9ICtA5HdZHlHNiLCZEWi2dUnW8MIswUaDAFc1pcLcpuyqJsagPG1hAdtuAkk
         FpFyfuo+W0EWbHvQOa9Qxqf3U1aCNF7xxX2zZJ/DCkcIqLpOsk3ikrvVc0kM/x0r13DQ
         B7AqESW+6hQvtbT3i0aznFJKjnYCi/FHvPbS1Pl4yanad9atRDqvOt0//AFGGTCiRU/5
         CYT3Cof1jAhtiVybp8BkvRn9Cu7+TdeSKw5E4pIakN6WREj2b6TMmXBWP4OqK0y3nIM7
         WU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721793582; x=1722398382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WT9z8M2iuMl54kp7uBvHCatMsJNaK2roQcf8LETvNo=;
        b=YfnmHMtOlGNrLltDrQ7ht0Kd48bLpvaRKec3aGN3wNwtgQ2uuNr7pX8IdJiTCiTpps
         EN4qNzNixyqovwyinbGiXgOLfTMcYSqOS6Jj4Vz2el0kx4mON/o7TTj9HEQU4wuFxI0S
         DqNVX29mB48LT0xzpu/ChxKSvfaMEvExgzAQRny32Nkw/HforO2vCaWiRBpcCTPOPLS5
         0QohXj9TYJrfd5w1RqF8g6Byz5Irbrvm/aCowIUtzR4hGlpv7xFZ/AyZZrZeDldrPbJt
         5KayuiJbsfhvJpBO10yZERrqaMB7rN7x/P3NdOouIR0MRlQk4RfkOD95hLIMy7tuj/75
         3bjA==
X-Forwarded-Encrypted: i=1; AJvYcCVqInjgoM7cie1Z8GYN2e+1ZStxCd8VcJGtbQa6N+Je3K3WYUHz1XCmwCBWDJURlqcpx1wHYYbluR4xpjvKAd4XljRAiWCeMjGNRnAB
X-Gm-Message-State: AOJu0YxMPRoiYaVdhn8R+7yQX+PJk+/DlyXXG7OCVxxMlTPhoGrEhibG
	bazx9MUNakaP09NMv/FK0GUFP2laS3l4fyymc53cDQCRG6qvG4K+LuihDoSwEL6Yl/X4yq7BpL+
	uVMYQ0RrtCB9Y6VuUJ3vsipfW4WzjVJ0yI0yI
X-Google-Smtp-Source: AGHT+IExUXrqdSlE5HTOk6j/unrKo6Fg5rpbnNdNj6fNfr59qApoM/0mHodslbAgVELV4os++R664lFqIJyd9rO/2RY=
X-Received: by 2002:a05:6402:40d0:b0:5a0:d4ce:59a6 with SMTP id
 4fb4d7f45d1cf-5aac9bd0c1amr191041a12.2.1721793581769; Tue, 23 Jul 2024
 20:59:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANP3RGceNzwdb7w=vPf5=7BCid5HVQDmz1K5kC9JG42+HVAh_g@mail.gmail.com>
 <CAHk-=wijWMpPk7feEZ8DzdLi7WLp_BhRpm+qgs6Tew1Bb2CmyQ@mail.gmail.com>
 <b84a6ef8-7c3b-4c04-81d3-859692d91137@huawei.com> <CAHk-=wjH5uKPB6xrWoB8WkBMuLEJO2UsidKE1wV8XSXjAUFO8Q@mail.gmail.com>
 <CANP3RGdgnXOXjnAFe6irf2JwrPsStTLvihKkowpY2ggSgNw7KA@mail.gmail.com>
In-Reply-To: <CANP3RGdgnXOXjnAFe6irf2JwrPsStTLvihKkowpY2ggSgNw7KA@mail.gmail.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Tue, 23 Jul 2024 20:59:30 -0700
Message-ID: <CANP3RGd7AQXPYQVrhjbgEN608Jo7hDUh7nc8VQ62gGQqW0iXMg@mail.gmail.com>
Subject: Re: UML/hostfs - mount failure at tip of tree
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Hongbo Li <lihongbo22@huawei.com>, Matthew Wilcox <willy@infradead.org>, 
	Kernel hackers <linux-kernel@vger.kernel.org>, Patrick Rohr <prohr@google.com>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 7:55=E2=80=AFPM Maciej =C5=BBenczykowski <maze@goog=
le.com> wrote:
>
> On Tue, Jul 23, 2024 at 7:22=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Tue, 23 Jul 2024 at 18:35, Hongbo Li <lihongbo22@huawei.com> wrote:
> > >
> > > I apologize for causing this issue. I am currently tracking it down. =
 If
> > > reverting this can solve the problem, you can revert it first.
> >
> > I don't get the feeling that this is _so_ urgent that it needs to be
> > reverted immediately - let's give it at least a few days and see if
> > you (or somebody else) figures out the bug.
> >
> > Maciej - if you can verify that folio conversion fix suggestion of
> > mine (or alternatively report that it doesn't help and I was barking
> > up the wrong tree), that would be great.
>
> That appears to fix the folio patch indeed (ie. I no longer need to rever=
t it).
>
> The tests are still super unhappy, but I've yet to fix our tests very
> broken netlink parser for changes that released in 6.10, so that may
> be unrelated ;-)

+++ fs/hostfs/hostfs_kern.c:
 static int hostfs_fill_super(struct super_block *sb, struct fs_context *fc=
)
 {
        struct hostfs_fs_info *fsi =3D sb->s_fs_info;
-       const char *host_root =3D fc->source;
+       const char *host_root =3D "/";

appears to fix the problem (when combined with Linus' folio fix).

I think fc->source is just the 'block device' passed to mount, and
thus for a virtual filesystem like hostfs, it is just garbage...

(and with the appropriate netlink fixes all the tests now pass at tip-of-tr=
ee:
87f3073c2871 (HEAD) hostfs_fill_super(): host_root :=3D "/" (not fc->source=
)
2743a4aabac6 fs/hostfs/hostfs_kern.c:445 buffer =3D
folio_zero_tail(folio, bytes_read, buffer + bytes_read);
a2caf678d7e1 neighbour: add RTNL_FLAG_DUMP_SPLIT_NLM_DONE to RTM_GETNEIGH
3bb0c5772acf net: add RTNL_FLAG_DUMP_SPLIT_NLM_DONE to RTM_GET(RULE|ROUTE)
786c8248dbd3 (linux/master) Merge tag
'perf-tools-fixes-for-v6.11-2024-07-23' of
git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools
)

> > And perhaps remind me about this mount API thing too if it doesn't
> > seem to be resolved by the end of the week when I'm starting to get
> > ready to do the rc1?
> >
> >              Linus
>
> --
> Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google

--
Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google

