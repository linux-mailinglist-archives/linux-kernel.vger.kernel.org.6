Return-Path: <linux-kernel+bounces-365222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFEB99DF22
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9ADF1F24473
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462ED18BBAB;
	Tue, 15 Oct 2024 07:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="VAlRzo0O"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64D518B468
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728976304; cv=none; b=SqSG1riSvs8PmmnAdA4ecRHxjdWLHNzHtUCrihrvqPqk2+hTj058JWQHtjDOFmkXYP6rFepJhgyrkkShqXrtyot25epS1adrpRQEhDFUfCAha0T2AMqUCA6HEk7PPECkcJ0WpXP/cD5Zkz4NdrxaKNsWRkl20InixJ7gLnbRLyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728976304; c=relaxed/simple;
	bh=9gnFRkRZl3eJCFIdT8RckdbXdUU5egVXUbjAF21TeX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r0Thyk8Xo+wDCsGL7Nl0/UFuZmWyId/qxQj82FWyfBgJ5NNfKVmFkYKdLgMfcY3PBO/Pnic/GnZpqIx1ZJdHi5mrZAaguNZh5V88ZFjIEP1sEHI2FW4dLTwZ6Wm5cX9J36joeiBycS7KDfgEoY52s8lZeln832EVr59u8lj3Wec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=VAlRzo0O; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e290554afb4so4719405276.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 00:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1728976301; x=1729581101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9WDOsOyjBr40/DG942xFzJoGHyL5sVb4xHCb4VnkNc=;
        b=VAlRzo0OcW+oVaXYsFCWuj/iPcCmMq2M6kfPDBlsNi9MjozESaMOR7jbCCCaySWuJ5
         Dxio9jh3EDq67psPrvjEnP2z0hkkGf9ZTrrleQFnS6wB0XTYr2PwRLIkHsVBtzmsW+Fd
         5ZrvYFeLjlKpH26/9rKg+kXnLchkh836g3STwfJCrg1RmRZPYOl3x/hy/GBwpULleHKO
         zaXVXgAO8er5IsbupYPNTB9XUVsbVBJ1vLXhPB6awrchGVg39Nx7IardfU+hijHujBsX
         by7SuO/KpNa9sxVeTThl7s0OFh/oDiNNRhTUsHYZ1E/ubupq6cMSwmH2zPRIayFhKej2
         +pJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728976301; x=1729581101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9WDOsOyjBr40/DG942xFzJoGHyL5sVb4xHCb4VnkNc=;
        b=pWbJbXlMz4LIss7pPLzqysRQi26duf6RZTxHdkElIH4SrmWrkrntLhfvFDXQTjrpku
         HBc6iaVy++uYi6l3La7lJthMdWrZMgK2zUarcWBvsifby7IpKpbeEQm4ttl5jxrOSzC+
         D+rJjz6g6LK82qXzZSUWB0Uf8J8HzFrQFSLFo0eW0Z0LR11Jx6PYi1zdLRNijSs75e43
         SFclfaR5oBRzBzbyX+tfXXm4qYpfCqmOcRAmZyZriRbrqL8ljddAxzDy4GGHIgkbJjcu
         ODTXvdRf/eWhD3U0EkHDL2A1MC2ek7zW/OcYPWMq404LGyMoJRsau7JWKn+S9XpK5cuZ
         BoCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqjdFpHVfUiie6SpVTAqokl4q7LGU39BWfb0/26pHhSB6u2alqhE8a2/Tj8yzPM40rMfh9yWoPqMQrgvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUYlI3KMNZwxB6s5fPOtn3zdR+tGaTyke1753A4kgPQW/2ezUv
	H+sTG2Dz3G5v+wK4/eesm/+R/rvGLhgjd5IqfgDhImWLGLedYAYW8WbNGJW95ItC6eM4iYUZmqx
	8/aSNLYvLVZ+jggEcHH3B2MZkYXkvGC6qjepQ5g==
X-Google-Smtp-Source: AGHT+IEE2Ussky40sGg5Fy7CgZzwGrcTgatV3H+zKQuhbNH2LR6iEBrqSt3Pt4DE4GmZBBlBnLI6BKbrNuBwTrNqdrk=
X-Received: by 2002:a05:6902:cc9:b0:e29:d7d:5dff with SMTP id
 3f1490d57ef6-e2919d9e471mr12122854276.23.1728976301624; Tue, 15 Oct 2024
 00:11:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014131152.267405-1-patrick.rudolph@9elements.com>
 <20241014131152.267405-21-patrick.rudolph@9elements.com> <CAFyOScrFmRQ2LeCC3MRDE1M4cbAvbjoyE-b97gjYPdrWBNBtZQ@mail.gmail.com>
In-Reply-To: <CAFyOScrFmRQ2LeCC3MRDE1M4cbAvbjoyE-b97gjYPdrWBNBtZQ@mail.gmail.com>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Tue, 15 Oct 2024 09:11:30 +0200
Message-ID: <CALNFmy3Sbdk49hFAfabz-VYhdDMHHmyJHz8mmMdDr=wcSgCVUA@mail.gmail.com>
Subject: Re: [PATCH v8 20/37] arm: gic-v3-its: Implement of_xlate
To: Moritz Fischer <moritzf@google.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
	Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Moritz,
On Tue, Oct 15, 2024 at 3:30=E2=80=AFAM Moritz Fischer <moritzf@google.com>=
 wrote:
>
> Hi Patrick,
>
> On Mon, Oct 14, 2024 at 6:16=E2=80=AFAM Patrick Rudolph
> <patrick.rudolph@9elements.com> wrote:
> >
> > Translate IRQs by implementing of_xlate() as required by
> > irq_get_by_index() to parse interrupt properties.
> >
> > TEST: Booted on qemu sbsa-ref that has a GICV3.
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > ---
> > Changelog v6:
> > - Update header order
> >
> > ---
> >  arch/arm/lib/gic-v3-its.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/arch/arm/lib/gic-v3-its.c b/arch/arm/lib/gic-v3-its.c
> > index 22fa46a341..0d5545bfb2 100644
> > --- a/arch/arm/lib/gic-v3-its.c
> > +++ b/arch/arm/lib/gic-v3-its.c
> > @@ -4,6 +4,7 @@
> >   */
> >  #include <cpu_func.h>
> >  #include <dm.h>
> > +#include <irq.h>
> >  #include <asm/gic.h>
> >  #include <asm/gic-v3.h>
> >  #include <asm/io.h>
> > @@ -163,8 +164,28 @@ static const struct udevice_id gic_v3_ids[] =3D {
> >         {}
> >  };
> >
> > +static int arm_gic_v3_of_xlate(struct irq *irq, struct ofnode_phandle_=
args *args)
> > +{
> > +       if (args->args_count > 2) {
> > +               log_debug("Invalid args_count: %d\n", args->args_count)=
;
> > +               return -EINVAL;
> > +       }
> Aren't gicv3 at least #interrupt-cells =3D 3; to distinguish PPI / SPI?
Yes, you are right. I missed that since qemu SBSA uses #interrupt-cells=3D1=
.

> > +
> > +       if (args->args_count > 0)
> > +               irq->id =3D args->args[0];
> > +       if (args->args_count > 1)
> > +               irq->flags =3D args->args[1];
>
> Don't you have to distinguish PPI and SPIs here? You'll use
> args->args[0] as PPI vs SPI and args[1] is either 1:1 (PPI) or offset
> by 32 for SPIs or am I misunderstanding something?

Yes, that's correct. Will send an updated version.

> > +
> > +       return 0;
> > +}
> > +
> > +static const struct irq_ops arm_gic_v3_ops =3D {
> > +       .of_xlate               =3D  arm_gic_v3_of_xlate,
> > +};
> > +
> >  U_BOOT_DRIVER(arm_gic_v3) =3D {
> >         .name           =3D "gic-v3",
> >         .id             =3D UCLASS_IRQ,
> >         .of_match       =3D gic_v3_ids,
> > +       .ops            =3D &arm_gic_v3_ops,
> >  };
> > --
> > 2.46.2
> >
>
> Cheers,
> Moritz

