Return-Path: <linux-kernel+bounces-395891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123D09BC492
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC049282A21
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 05:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9201B4F02;
	Tue,  5 Nov 2024 05:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="u1kntvzQ"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4BB3D9E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 05:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730783515; cv=none; b=GDe+0w2JZ37iTPcMfGoltAXnf+DJPQ/r6AeCZ5YIfy+5aUUQBFme1tfGacXf7wa5Z+CK4qWCsf03R8cvVC3ZJfxc0xKVAOSm8w/aNJUD+3o8MWR1kFM48GpcZs9JRVAM5k+UL2AsUQZ+rCbRrjSLkPzTmw4mCryahTDpSJXerVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730783515; c=relaxed/simple;
	bh=g3X43PZZfzcStSl1Yx3BdP8/SjXgxrtAXnFZ6F/ppEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lc9i3R5BOaMfEbp6OFNobMqCkp2ftY3vfBvHIqdHWb8d6yl2qEUl5XTm6v5vE004ZRsF4LqcZ8gstz6dsBkMC1ir0Ycu211HWw28HjKWJhP2BiJX49uuWYc+cvCZGXN5yja3MpJ3JsetMV99qWRZwYoN4ePKNQIgVvZaoXOMuoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=u1kntvzQ; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a6bcbd23c9so10972765ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 21:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1730783512; x=1731388312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8l5esNem8PBBNIAd06UP9heND5ENpGUkBH0v3nolocY=;
        b=u1kntvzQwSkUi5h5nF0L5+UjpFBGP4A+wqJ7vEkBpr7uc8UU5tLkRL8oGv29VNdjC2
         apWdvF2FHWssiu/yS6/Jxab8BZNjhOWf4forxPjNcNg16Omx50p89D3PI6qiD4VaErBg
         TrQ+MaHegDobTkesK4JTlvvfqzV1yvMEL9nIGdGXibSr2bX8hDd1y+q6Bdo9F7UxznoM
         ARUuKChYNqzvU/pk3+/JF2ba/GE/lTQzWE/PbzmJOBaxw7CcN+DXObb6Cp2X2dbDS6Gb
         3FcCYSYvo4C1LM+b2Ivz4wjt0OxgY8NiGvyEaSEvIwZMRm6GEtmML8wmORx+OkKPuMVN
         MV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730783512; x=1731388312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8l5esNem8PBBNIAd06UP9heND5ENpGUkBH0v3nolocY=;
        b=fmbpAGp6lP+BB6smJ2dUY5bghp9zizFTwBH/2+9xcs7RMug7aMqubmMkzbtimZ6PUy
         2iZA0oLwd70IFYOwWZs8OdorQPB0dGnKbIIoaUz8tPEdW76zU1HWD65dxkowPl8Klwf7
         GDmJ9Rsk4R50e7Uck/8/s9dj04dJVv7XcyiB0K4wmXnmtIMUG+jhM+39GJy4Un4OG4NK
         fdi3MrjHf538tIwJV4S2BIBgikaPZc0/FfQjoqAdklETM4XpD//L5BU0r1Xmy0MbZLO3
         pxA8GSVp7Ulz/jmGySKCO5kMl89ZNTEWeRvbvBFymHfjnCbZg2i4z6w0ZRlnexlAPsBC
         ejbQ==
X-Gm-Message-State: AOJu0Yzl/ARGYTRyr29JXOnRcgt8L0zTCOZC5YmNOv02q+uKq+Zgv4A3
	Q9/GVmD3nU3r8JWYa7EV8pqMmhHdoa9JUTiQnmpkOudZGutO4BNjQhOboDcGGOGxsIyAQ0lamaJ
	KSyw0cnvzYTK3NY1UnbjGAU5sWU6UtW8d/JdJxA==
X-Google-Smtp-Source: AGHT+IGEudYnCi3xjKq3yQuyp0LPEhZYmxUddO6fuja49PgBoSWrtEJM9MPf9ivcp3qpb4s6OoJ/iT+dNNtaTMkeEdw=
X-Received: by 2002:a05:6e02:3f83:b0:3a6:c320:7ed with SMTP id
 e9e14a558f8ab-3a6c3200a55mr86555625ab.10.1730783512341; Mon, 04 Nov 2024
 21:11:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029085542.30541-1-yongxuan.wang@sifive.com>
In-Reply-To: <20241029085542.30541-1-yongxuan.wang@sifive.com>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 5 Nov 2024 10:41:41 +0530
Message-ID: <CAAhSdy022PTmMZ90OxRxSOiR9nKept+tKVj8XrqbekkM209eYQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] RISC-V: KVM: Fix APLIC in_clrip and clripnum write emulation
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, greentime.hu@sifive.com, 
	vincent.chen@sifive.com, Atish Patra <atishp@atishpatra.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 2:25=E2=80=AFPM Yong-Xuan Wang <yongxuan.wang@sifiv=
e.com> wrote:
>
> In the section "4.7 Precise effects on interrupt-pending bits"
> of the RISC-V AIA specification defines that:
>
> "If the source mode is Level1 or Level0 and the interrupt domain
> is configured in MSI delivery mode (domaincfg.DM =3D 1):
> The pending bit is cleared whenever the rectified input value is
> low, when the interrupt is forwarded by MSI, or by a relevant
> write to an in_clrip register or to clripnum."
>
> Update the aplic_write_pending() to match the spec.
>
> Fixes: d8dd9f113e16 ("RISC-V: KVM: Fix APLIC setipnum_le/be write emulati=
on")
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> Reviewed-by: Vincent Chen <vincent.chen@sifive.com>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-6.13.

Thanks,
Anup

> ---
> v2;
> - add fixes tag (Anup)
> - follow the suggestion from Anup
> ---
>  arch/riscv/kvm/aia_aplic.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/aia_aplic.c b/arch/riscv/kvm/aia_aplic.c
> index da6ff1bade0d..f59d1c0c8c43 100644
> --- a/arch/riscv/kvm/aia_aplic.c
> +++ b/arch/riscv/kvm/aia_aplic.c
> @@ -143,7 +143,7 @@ static void aplic_write_pending(struct aplic *aplic, =
u32 irq, bool pending)
>         if (sm =3D=3D APLIC_SOURCECFG_SM_LEVEL_HIGH ||
>             sm =3D=3D APLIC_SOURCECFG_SM_LEVEL_LOW) {
>                 if (!pending)
> -                       goto skip_write_pending;
> +                       goto noskip_write_pending;
>                 if ((irqd->state & APLIC_IRQ_STATE_INPUT) &&
>                     sm =3D=3D APLIC_SOURCECFG_SM_LEVEL_LOW)
>                         goto skip_write_pending;
> @@ -152,6 +152,7 @@ static void aplic_write_pending(struct aplic *aplic, =
u32 irq, bool pending)
>                         goto skip_write_pending;
>         }
>
> +noskip_write_pending:
>         if (pending)
>                 irqd->state |=3D APLIC_IRQ_STATE_PENDING;
>         else
> --
> 2.17.1
>

