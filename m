Return-Path: <linux-kernel+bounces-560173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F103FA5FEF4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 165CB1685AA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B80D1EFFA9;
	Thu, 13 Mar 2025 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixWDCJeL"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAAF1EBA09
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 18:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741889534; cv=none; b=XUzAsjjHDXjb9B59+3fSYw0vadkEc2bCK2qWniUaPxauYCN34k4wnQeB6h0+ge6OAtYyIrPDfWjTp7DTiBBSGvRdRls+JGP9t1dqKR9DEcf/a2IkHOyFmiN/s0QH6//CrXcePOoXMr3TEUJgMZ9eL0pGUBMeHsuUdPT+4AOE4qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741889534; c=relaxed/simple;
	bh=bFGlRr27RUUO1iz269TvssoU0M3nZBVruXDO8/lNmoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ls6Nye6HpDX/sSPUZ8Rmx6eh04Yh2tGqYUf+WfrPk2XHlHqmy5xQAWFWER6OiDiQUjwLwcm6MQF12NY1R6WslCnQhIc1NQah+PKtrYB1kD+pfNTOM4q4fOtbo9sfOSpaBECtI/PperkJyVQtuC5Av7v2cHUCfbCPug9/nw1K9bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixWDCJeL; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ff694d2d4dso2345094a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741889532; x=1742494332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swndidqFROwOBEqG3wesdy7WmWrjyR83c+ssL3XTYOw=;
        b=ixWDCJeLOZRhrtmKk79Yidlt/6yrYz+oRd7SyBDwnythlB1uzns+XfJNhDYbOpJynk
         kws9SEnRCknH7CdyJrOJCelJbBr815HToZZCkCctNNkPXCOpdf29+gYHjeg6qs+KOLnK
         sDE0VG5xiX3kZE5QRPBjPgqeJUcw6jMPpFaMf5ChZBGLNZV/qaukIEzBFIrBzjooerq1
         Son6S2EhkLCEzjPNfcj1HxYSS+0fgXbYFHy/8OXFaAjbgADJJkUrQqqCJ4fvD6gZQEkD
         xZAFErzKF31SnCuGfjq9ooK5OTVRa7LOUaY0KobwX96/10yGhcU3WmSKtvLRtz+cJKvw
         SH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741889532; x=1742494332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=swndidqFROwOBEqG3wesdy7WmWrjyR83c+ssL3XTYOw=;
        b=v9JSrnMRQyGRCp8g82hcNfik18Dj1GR80znotIGldXnBrPId1DpWkpuuKZ+NB/l+oY
         OedO90437tc6X4f/q28905JG3jzG1StJjsGqzH962tnbBq419b+yNuidk5uhBWCiHg/2
         wbkPljiWjtM128hRIXJAusESuPkuoVWdny86G7I4t0MFSG+0e1TLXPmZ9apnRaO+jaq7
         V3NQ4cGQeFfJO/rJR6QG5W+FKZ1HBWeruMSBqJ0Ni5guTB1Ir79yWXhSWy67HkfNRODj
         i03PdKIGQAvVhx5ekwHsm7djX53Y4DNufOg4EWPS7Yn1j2imTe8fEdQ/2DdvMhZ0h1SM
         6Bhg==
X-Forwarded-Encrypted: i=1; AJvYcCXkOYFz8LR5NaSCmzAo8SrTI0BYk83fQ9Q4hZ2u5MPdb1n/urXJzeLLdK4MTT2OtUD1pz7cEv+sKysf7cQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3QajMOYaqAN5ya7T2KT4ZUOuRwrS+jBS5dEYDRgjoBySDQ5as
	PXQ4xGweAhS4r2BezzRlT2NxLkBTxs5D6crtES6JEWJnuCuMkfEASzWUQmBQj+phNn8nAWDsotc
	F5oLeV++TMIEizpT82XwPDaFGg20=
X-Gm-Gg: ASbGnctdCrQcQC/SB/yk7A4N6W2tPTmg+S2HDN+v8s0CG81BLBXCZ309UbmUgqJHnFP
	D+x7Ii6afR+bcsDgBYsY49r1mIzyawl7eKH3gYaL9tbclMUZA69i/+cU09/lpj10GQLIwKh02n+
	exB7MnE6ejDmD84jAQHmbBUP7F
X-Google-Smtp-Source: AGHT+IFhWr0mQH/ORI3Oe/Ce66HJj5thevy7RQd2RtrRcph8GzEovPCbhC46lwWDqGllBV+kcJUT5GO0fdErRBMq8Cw=
X-Received: by 2002:a17:90b:1f86:b0:2fe:e0a9:49d4 with SMTP id
 98e67ed59e1d1-3014e80f07dmr677872a91.2.1741889532088; Thu, 13 Mar 2025
 11:12:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127172908.17149-1-andybnac@gmail.com> <20241127172908.17149-7-andybnac@gmail.com>
 <87ldtck8k0.fsf@all.your.base.are.belong.to.us> <Z9AwF5hwF0ES9Grl@andrea>
 <87ldtbwrdb.fsf@all.your.base.are.belong.to.us> <Z9B8vgdTq1M9r3_k@andrea>
In-Reply-To: <Z9B8vgdTq1M9r3_k@andrea>
From: Andy Chiu <andybnac@gmail.com>
Date: Fri, 14 Mar 2025 02:12:01 +0800
X-Gm-Features: AQ5f1Jpg2qNW6FMkkw1vv-lje3Lj7loei2DrMtm_6kL3ZJ_w2QCD05L9hNNFzUg
Message-ID: <CAFTtA3NawdhM3fF_xc9a0EogaejHGWSxhWGre+FpLeXH9J+q5A@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] riscv: add a data fence for CMODX in the kernel mode
To: Andrea Parri <parri.andrea@gmail.com>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, bjorn@rivosinc.com, puranjay12@gmail.com, 
	alexghiti@rivosinc.com, yongxuan.wang@sifive.com, greentime.hu@sifive.com, 
	nick.hu@sifive.com, nylon.chen@sifive.com, tommy.wu@sifive.com, 
	eric.lin@sifive.com, viccent.chen@sifive.com, zong.li@sifive.com, 
	samuel.holland@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andrea Parri <parri.andrea@gmail.com> =E6=96=BC 2025=E5=B9=B43=E6=9C=8812=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=882:11=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Tue, Mar 11, 2025 at 03:53:36PM +0100, Bj=C3=B6rn T=C3=B6pel wrote:
> > Andrea Parri <parri.andrea@gmail.com> writes:
> >
> > >> FWIW, the for S-IMSIC the write is already writel(), so we'll have t=
he
> > >> text patching and IPI ordered. Regardless, there's more than one fla=
vor
> > >> of IPI on RISC-V!
> > >
> > > AFAIU, this writel() is intended to order the insertion (and the init=
ialization)
> > > of the CSD object before the MMIO writes; so, the "right fix" seems t=
o turn the
> > > "other flavors" into using a writel() or providing a similar ordering=
 guarantee.

I found that Apple's aic irqchip uses writel_relaxed for sending IPIs.
I am not sure if it is a practice using relaxed mmio in the driver to
deal with IPIs. I am more convinced that driver should use the relaxed
version if there is no data/io dependency for the driver itself. But
it is true that a fence in the driver makes programming easier.

> >
> > Yes, that's probably the right approach, or maybe follow-up!
> >
> > > As a bonus, such change should address/fix all current and future occ=
urrences of
> > > the message-passing scenario in question (the patch addressed the occ=
urrence in
> > > flush_icache_all(), but there appears to be a similar one in flush_ic=
ache_mm()).
> >
> > Indeed. I wonder if the SBI remote fence.i needs it?
>
> Ah!  So I am not alone: AFAICT, that remains a matter of discussions with=
 your SEE
> team/developers.  :-|

As far as OpenSBI is concerned, there is a wmb(), which translated to
fence ow, ow, in the generic code path. Regardless, there may be more
than one flavor of SBIs, should we also consider that?

Thanks,
Andy

