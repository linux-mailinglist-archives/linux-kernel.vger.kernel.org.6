Return-Path: <linux-kernel+bounces-322370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D8E9727EE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 06:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE85B1F2489D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 04:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E0B18306E;
	Tue, 10 Sep 2024 04:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHeCyqzN"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2DC770E2;
	Tue, 10 Sep 2024 04:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725941708; cv=none; b=F4KGSN/Hk9EVUE12/Y0R8MBhpjw18sAzrCAeYratFH1kfc+xz1wUsBypFRNnWRYs4r0fSGu5tQDakzDk+ECOrmsTMQVmU9YC8CGVbQjSowXrtz5dNvykwQv+eSRR+yNJcAQNhr2nw3yLzi4clcGt5MF38ex9R5/p8VtmlkcguMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725941708; c=relaxed/simple;
	bh=ONWChnD4WtjLaVWnzZPF0/WnUFQpyPeRsbfOM8cm0UU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C03RWI1z0d84rylfYtvze+AmOgTRMvx5aWqHYGN/xzEjNcktl0x1NtCyyMkPnu2U6zVx1kc0WNsmfAAAJb1dHg7rXXfPMQSm6lhDqqR0F0dnhllgvFq937mxvANJ+z39RdmCmqaOPnnx4x/esgyJi2z5wUlKs+Fku23ssolrfeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHeCyqzN; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-277e4327c99so2948992fac.0;
        Mon, 09 Sep 2024 21:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725941705; x=1726546505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+s+5c8Omf1wEXIDwyDQuFABOjgkZQaBttk6gT8y6VY=;
        b=QHeCyqzNJGWctw5wIFM5ndgGxCc8WxK/lVH/An9601Cvyu1/DS/t4MLLitAqWzdsM+
         ggxlvy55vPZxZuLxzKcqXARkZ9oYgmksJs8bwQ15OxFZzKg75Xu7a3PvLcdt0KMvNlNb
         nBBT06kCjszfYwwoHdr5JT1vah7ZbKSbTeATdmN5EzVL8XVZ0QvXuIo9mnt/x7zPmq81
         N78q5h2+SMqJkyDw9GfipWTQa/NVofvtT9xA1pRTz2pLrmZDCUZ/gDh1TLhfSGcWgR1u
         3mf5sihR/7ihsQ8gzVK5Of/6CguXIvswey7qnl94GdB9qBv9ksz5CUnEFcB0ggGRYxaK
         8Ygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725941705; x=1726546505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+s+5c8Omf1wEXIDwyDQuFABOjgkZQaBttk6gT8y6VY=;
        b=JEfaR1QgQsydVjzDm/BHQZ7ReetG4zRhwr6xPoH8kSWRXLewg9ECHEGsVd+j+c4fyj
         l90cfhhTSOjUAJ9JL7Y2kf2JiEresewkVyTB7Y9cRZneY4vzGcrVLeEoKquWRr8/BrLZ
         sC7zABX+TazcTZ9ntyOSpNdtTAiuC8OgNUy8nEHE0i1IygGAWfvj/9EEkonHmWDATuLm
         T66x/bd9+YjZEVWjGMfiu1bkJKRaFnW2FRX5bqGm7Y65QIrm61f2cE8OxtIYAUoTwGqz
         7T7BHPW8KskoXrXxAVGH42Ru4BmuYYh6rZ7e57g3u/fAOzRRGYjjJncnR+dEyWQb6sOU
         6WtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFU096AWinGDdDD6MWibgucxtgLo7JnvY5Jj52gCX77bBKsFoguVFIykBRLgB8CqkwM6C7Gs3XjblLRm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2MADHl+F9LcO+HdGz40jJOnvcu0jeQeSH0uUjVmnjPy6tVrd8
	eJZF3Fvm7H5+nVzYTsYlwOptF/f8Z+g4o1WSwro6hJXTTcYGYueouCrtLv/J80fwq2pTiD+bC1S
	/22PI7Rlv8QuKjvsWeEkoKjoEsB/Z1w==
X-Google-Smtp-Source: AGHT+IFXlsvZmB7pSC0OnIO5zV+J1X5s0KvZEumRTRhAnv5SlVHbn1KE/i0B6VE/5fy7TBX0hfbq75qdHi0DkIT9s7E=
X-Received: by 2002:a05:6870:610b:b0:25e:1610:9705 with SMTP id
 586e51a60fabf-27b82dccc41mr14673171fac.2.1725941705391; Mon, 09 Sep 2024
 21:15:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806142902.224164-1-sergio.paracuellos@gmail.com> <TYAP286MB07463A0C8ABD8837888C6853BC992@TYAP286MB0746.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TYAP286MB07463A0C8ABD8837888C6853BC992@TYAP286MB0746.JPNP286.PROD.OUTLOOK.COM>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Tue, 10 Sep 2024 06:14:54 +0200
Message-ID: <CAMhs-H9rJEO8Yje1qsWQ9rt19wLZLbbiVVa3aR_Uwh2QRO9a=Q@mail.gmail.com>
Subject: Re: [PATCH] clk: ralink: mtmips: fix clock plan for Ralink SoC RT3883
To: Shiji Yang <yangshiji66@outlook.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mturquette@baylibre.com, sboyd@kernel.org, tsbogend@alpha.franken.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shiji,

On Mon, Sep 9, 2024 at 1:20=E2=80=AFPM Shiji Yang <yangshiji66@outlook.com>=
 wrote:
>
> On Tue,  6 Aug 2024 16:29:02 +0200, Sergio Paracuellos wrote:
>
> >diff --git a/drivers/clk/ralink/clk-mtmips.c b/drivers/clk/ralink/clk-mt=
mips.c
> >index 50a443bf79ec..787ff3e66b34 100644
> >--- a/drivers/clk/ralink/clk-mtmips.c
> >+++ b/drivers/clk/ralink/clk-mtmips.c
> >@@ -267,6 +267,11 @@ static struct mtmips_clk_fixed rt305x_fixed_clocks[=
] =3D {
> >       CLK_FIXED("xtal", NULL, 40000000)
> > };
> >
> >+static struct mtmips_clk_fixed rt3383_fixed_clocks[] =3D {
>
> Hi! I found a small issue. The SoC name is rt3883 instead of rt3383.

Ouch :). True. Since I have some other pending patches of this driver
I will fix this and
send a new patchset including this fixed.

Thanks,
    Sergio Paracuellos
>
> >+      CLK_FIXED("xtal", NULL, 40000000),
> >+      CLK_FIXED("periph", "xtal", 40000000)
> >+};
> >+
> > static struct mtmips_clk_fixed rt3352_fixed_clocks[] =3D {
> >       CLK_FIXED("periph", "xtal", 40000000)
> > };
> >@@ -779,8 +784,8 @@ static const struct mtmips_clk_data rt3352_clk_data =
=3D {
> > static const struct mtmips_clk_data rt3883_clk_data =3D {
> >       .clk_base =3D rt3883_clks_base,
> >       .num_clk_base =3D ARRAY_SIZE(rt3883_clks_base),
> >-      .clk_fixed =3D rt305x_fixed_clocks,
> >-      .num_clk_fixed =3D ARRAY_SIZE(rt305x_fixed_clocks),
> >+      .clk_fixed =3D rt3383_fixed_clocks,
> >+      .num_clk_fixed =3D ARRAY_SIZE(rt3383_fixed_clocks),
> >       .clk_factor =3D NULL,
> >       .num_clk_factor =3D 0,
> >       .clk_periph =3D rt5350_pherip_clks,
>
> Regards,
> Shiji Yang

