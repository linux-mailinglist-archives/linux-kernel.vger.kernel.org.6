Return-Path: <linux-kernel+bounces-527296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CC7A40950
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 16:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B1181890AE7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 15:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68181C84B8;
	Sat, 22 Feb 2025 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehoSSFaU"
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30CE1C84B9;
	Sat, 22 Feb 2025 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740236624; cv=none; b=WHG2MlkWdeGWDj4tEFWcTkQSVw17mIcxEaIBzaig9EGhkpQo68YIMKfKK6wwjWDUCNpczAmKhRwtEwe3533AFp9OjTrUGJ/A12HVIsrqt+QdZg0BsefOjCEY18MRmVqr+yu1Dn1BWGQQdBK+vCD9f4Z5Qm5Ig7qPT+2uqXeWUTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740236624; c=relaxed/simple;
	bh=jUXRRryCAkCVWDk2XF45KApdOzwiOOcrGOcuA6Zi1+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LlHuxdCCrDJdGYVXILpc+o0yDH/oFFqtExkxzP+9aRLxKXqcsQbzPGpISZ+scgthP+IdVgJy0bofD+bARfTW4akrOhz6jKi2pb2OyDEsV7xLjb2Jt1kYXQV0XfrQTsdOg2xuw1ok9MGDOeI6U8CGaVw4hS4YIkglbsECOPUq+C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehoSSFaU; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-7c0ba89dda9so344131085a.0;
        Sat, 22 Feb 2025 07:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740236621; x=1740841421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUXRRryCAkCVWDk2XF45KApdOzwiOOcrGOcuA6Zi1+s=;
        b=ehoSSFaUTrUZ1UKfHneFMdQokK2w7HTyWOTpCOo5E8bQTL6P4LqIpcBn2heUg0zfaT
         3w4+wX8KfSZ/t+aF7yJ4LVwrz1H1x5BJDX1R4iwdq2IWSdjz9+0nwk07Z2LjSneTpLjj
         +axJLmnf51Yt6Nc/kcjNHN4gd+fkQSELdtk+QbWqsnr2OV6fdt2lq+R1PyFZj+na3jZe
         pfTOCBRxWNrtPcwX3f129n1k9Ludi57w3pex59f9pLyin6p/RqyS6tay/dZ0rOOM/ZM1
         UJVHVJJKxRRVC5/8dSNRvx6VF2Qh7IfAUl0KNTc3fZy0v1+FrL5zCT2eIs2XwmPTi4Hu
         vwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740236621; x=1740841421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jUXRRryCAkCVWDk2XF45KApdOzwiOOcrGOcuA6Zi1+s=;
        b=dMz205I8ov4rsuR4DU/BXdeb/LTTLFJT4TYmWUoLa3iXfVx06ALYki1RnkD20ROwQx
         1QyAnA7gbUT3QQ5qV1dJFR9paro3wJxkR4AyZswCLjTLdoOJzCmocCrA+lCH0VVL+wLR
         ayJJ4umv1SHRhPI6Dnz+3OPrrvFV7fFCs6DWk43WXfWBHKStHqy7n1gbUi5D7f3KCfss
         Zk35mHDVuOOsjAxJX5TbArkKMUyeHktbbCwKiXErZjg7w/2b7E+grCbKaMrIsISlLQ4+
         ab9YJ9jOc46zctdvCFzWphqMtw5REaX5zshW8tHmmPrzXlxjx3nlAVH/38TkjnSxarne
         f2rg==
X-Forwarded-Encrypted: i=1; AJvYcCUYfTkcyLu9IrjV9cegLZjBiLpxLBGA72BAoYBlvk3IwAQ27f+quO+eGc3j0ZAfGO3pdRid5cS37Qo0y9A=@vger.kernel.org, AJvYcCV2AkDAHnvOMuwoDVGcbiULgnCdGu30PX8b2BGc8xZ04z7NrHteA3i/pR/5K5fHWquO/nHL4EadqpeKEtUozCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIUCrW+cL/OplV2Zi9aSoC8OkniKmpih0DgpnMuM8B1zhEb+gO
	oszsNFbVoeltYsWABht9+Q/JWsPfVVdo22H4b0YhlimNGgLXLrXvlDif5uCE6kevsbOmZRUsm/8
	7NyALxsd7Fy+7H6pniP06nZjoyjI=
X-Gm-Gg: ASbGncsXSgEL0luBkt6BwKmbv7TqjgHwpu/nH1a5w2x0mAg21bvRUvdqsS04vWwAdLA
	oMSYL+NYzND0KbIkKwb51JDyGA7nHcUMqQTo5iROX2TxSHAICxuBlIyNrUE02HTQQPugOwGXtr0
	bCDeFKM5t+
X-Google-Smtp-Source: AGHT+IF5/dRnick9sCywZfv2H3f5TyOgoxmRTWx6ApvJ88OgJSey1x5l6lnKGxOLgf3ZaMijgmeZk2SvQGN7eEKkszo=
X-Received: by 2002:a05:620a:1a0e:b0:7c0:c47e:e124 with SMTP id
 af79cd13be357-7c0ceefa1femr953262185a.16.1740236621541; Sat, 22 Feb 2025
 07:03:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo>
In-Reply-To: <20250222141521.1fe24871@eugeo>
From: Ventura Jack <venturajack85@gmail.com>
Date: Sat, 22 Feb 2025 08:03:29 -0700
X-Gm-Features: AWEUYZnyEHVM6QnSBJQpHdoTp1Y_e_SHNI-v7ysUE-mK4wj1z0Kk34j8sa-yT_g
Message-ID: <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Gary Guo <gary@garyguo.net>
Cc: torvalds@linux-foundation.org, airlied@gmail.com, boqun.feng@gmail.com, 
	david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org, 
	hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 7:15=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> On Sat, 22 Feb 2025 03:06:44 -0700
> Ventura Jack <venturajack85@gmail.com> wrote:
>
> > >Gcc used to initialize it all, but as of gcc-15 it apparently says
> > >"Oh, the standard allows this crazy behavior, so we'll do it by
> > default".
> > >
> > >Yeah. People love to talk about "safe C", but compiler people have
> > >actively tried to make C unsafer for decades. The C standards
> > >committee has been complicit. I've ranted about the crazy C alias
> > >rules before.
> >
> > Unsafe Rust actually has way stricter rules for aliasing than C. For
> > you and others who don't like C's aliasing, it may be best to avoid
> > unsafe Rust.
> >
>
> I think the frequently criticized C aliasing rules are *type-based
> aliasing*. Rust does not have type based aliasing restrictions.
>
> It does have mutability based aliasing rules, but that's easier to
> reason about, and we have mechanisms to disable them if needed at much
> finer granularity.
>
> Best,
> Gary

Are you sure that unsafe Rust has easier to reason about aliasing
rules? Last I checked, there are two different models related to
aliasing, tree borrows and stacked borrows, both at an experimental
research stage. And the rules for aliasing in unsafe Rust are not yet
fully defined. https://chadaustin.me/2024/10/intrusive-linked-list-in-rust/
has some commentary on the aliasing rules.

From the blog post:
>The aliasing rules in Rust are not fully defined.

Other blog posts and videos have likewise described unsafe Rust as
being harder than C to reason about and get correct, explicitly
mentioning the aliasing rules of unsafe Rust as being one reason
unsafe Rust is harder than C.

One trade-off then being that unsafe Rust is not all of Rust, unlike C
that currently has no such UB safe-unsafe split. And so you only need
to understand the unsafe Rust aliasing rules when working with unsafe
Rust. And can ignore them when working with safe Rust.

Best, VJ.

