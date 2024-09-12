Return-Path: <linux-kernel+bounces-326053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1B49761D8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0DC2284D34
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 06:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC5018BBA6;
	Thu, 12 Sep 2024 06:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="FgP11yY4"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D9F10FF
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 06:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726123959; cv=none; b=AxHD71B9a05Zn2aWthOuZrxRdQdKSnNSyxOcIBFjs/6ofBn5YPTXSoKxVjIpfsgnFGbNHVKR42BTB2/UMVAKsby7OwRBlWdyho6dH4UQE+b7F3tJI4bAne6TXokRC2HAnqfD4i/SKe9T0HmHiU/i2Vdl+sQ/6nzLNltrz1Vo83k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726123959; c=relaxed/simple;
	bh=CwyoKE7vampna7WOf0LUd1/a31p8CQ2tXBG28GJyj44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y83xCF5L2GMyfARlnWppDriOK1eKmZTQl9gUZ12yvYGxiksJ/wG8P2SpjvtMaPtJ1lsE3SDqVDjF+OwrC/BTRsuvaZDCNCLxAXB8ZuLXDcIbA85h2JpmYQVqvI7sATlbvrAKvNyDz8XTT8Sric0klEJh9BdJst6EGemFWq6Ua4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=FgP11yY4; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e02b79c6f21so628550276.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 23:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1726123956; x=1726728756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLkaK81iYIb9QbaQN9iKtEvGU7CisYacIxRKhgfyrlY=;
        b=FgP11yY4wJnAzYE/mTxz82yUREbttwv7TfAtuPdsGq29t2NTqrKQrS+gPpwaeDeyPn
         qZFmfBn6zYb7dUTwXSRCGtBHDXd/2x+OGNYSkKt3/Rno8/8nMEmCWxB8K1gw9hPgknSk
         WesAGZkjRpOJiAQfNzRj4jbd0CeKA/YM2F0b4FoYOxmXkFeSRVrSR6fXIk3ZuXL8qChv
         i2RdJmR7QrXhT9te6oietR5ghdThf4GjAg9XhxoXikGvZqJJQzBsRBv1mOtZZ9pA75Eo
         myqDmwGQJtyV4BZwv6iaTziBM2NcnDn8CsNmDO7o9Aov6L3MyTBti9IV/dC5oMzVvHow
         vGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726123956; x=1726728756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLkaK81iYIb9QbaQN9iKtEvGU7CisYacIxRKhgfyrlY=;
        b=unvpKqK4a+DoCk5hi7aiNhIW/GDnuPCwI/3r/uDtfjWJXQHGsYSZ86SXw4FqO29Rmh
         mw8vSDNRQvRawbup4ofj6TW+uS4vOgJNuDNF7OXF7Xt7oWUR4kcWnGtIwJAIcbppUMBV
         p+V1RnnUCMZobx/mzLO0uQ5MafJRnf8HJQcqgqW9CnQtyiFQUAZ3/3A5VYVGk0msGupy
         EYdrRdOEojkS7o0JabbBfFTqgCrQKcMVHUmWwhhECxHTCxwVB+/qiB03lB7360qpzgqQ
         GEMty0ReGzcrpiFQTBkJXEy32ikRhDckF9C/Hv8ZVzl8Idf5QOFk6IqxX9/BQwCOwfRo
         QdSg==
X-Forwarded-Encrypted: i=1; AJvYcCWhLm6DrCodvQ8+V6QCM+knAalmSbYlks//K6MwIRkYuvLuuC3j8istTem5bBcqXWWhhSNea89qjmCL2yE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzThha3FT5hskXua1HyzWPi9rgCPE3ZH4vg90CdyxCu3hMNeGBD
	nkYn5vqzdRXyPYj8WKrM40tMwlQ88aSjwUuNKBt7rgt/4/nJlcOjhXWdA3I1NBbAFMmTvevlRZX
	EgmKAZ2mE3rILaDN1DfpDnRrp5fOA3jnHii9HAg==
X-Google-Smtp-Source: AGHT+IE35bmn18N00hx7rFjKW30hUoh0ihgQXRO90TFwIR1WEYAfXyzLCcRLwfMKmqJQgXBekgI4jFhRlOUljN09S8E=
X-Received: by 2002:a05:6902:cc1:b0:e1b:dc38:1a8c with SMTP id
 3f1490d57ef6-e1d9dc3cb25mr1371935276.43.1726123956429; Wed, 11 Sep 2024
 23:52:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-20-patrick.rudolph@9elements.com> <CAFLszTj90Xm50hNCC0S3wn7nJyXp4R2JoMMg1+sCUabjJGhJTQ@mail.gmail.com>
In-Reply-To: <CAFLszTj90Xm50hNCC0S3wn7nJyXp4R2JoMMg1+sCUabjJGhJTQ@mail.gmail.com>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Thu, 12 Sep 2024 08:52:25 +0200
Message-ID: <CALNFmy02rq76r6PJ6De1pavvAFOfUvB8XjY8Vydepcoi=G0Whw@mail.gmail.com>
Subject: Re: [PATCH v3 19/30] arm: gic-v3-its: Rename objects
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
	Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 2:59=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Patrick,
>
> On Wed, 11 Sept 2024 at 00:29, Patrick Rudolph
> <patrick.rudolph@9elements.com> wrote:
> >
> > The code accesses the gic-v3 node, but not the gic-v3-its node,
> > thus rename the objects to clarify which node it operates on.
> >
> > The following commit will make use of the gic-v3-its node for real.
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > ---
> >  arch/arm/lib/gic-v3-its.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> But how many interrupt controllers are there? Would
> uclass_first_device_err(UCLASS_IRQ) work?
On most GICv2 compatible SBCs there's just one.
With GICv3+ you can have an additional GIC ITS as well, which would
also use class UCLASS_IRQ.
But on servers there even more than two...

I'd prefer the current code as it would work with the follow up commit
that adds another
UCLASS_IRQ driver.

>
> >
> > diff --git a/arch/arm/lib/gic-v3-its.c b/arch/arm/lib/gic-v3-its.c
> > index 2cc0a32f9d..22fa46a341 100644
> > --- a/arch/arm/lib/gic-v3-its.c
> > +++ b/arch/arm/lib/gic-v3-its.c
> > @@ -35,10 +35,10 @@ static int gic_v3_its_get_gic_addr(struct gic_v3_it=
s_priv *priv)
> >         int ret;
> >
> >         ret =3D uclass_get_device_by_driver(UCLASS_IRQ,
> > -                                         DM_DRIVER_GET(arm_gic_v3_its)=
, &dev);
> > +                                         DM_DRIVER_GET(arm_gic_v3), &d=
ev);
> >         if (ret) {
> >                 pr_err("%s: failed to get %s irq device\n", __func__,
> > -                      DM_DRIVER_GET(arm_gic_v3_its)->name);
> > +                      DM_DRIVER_GET(arm_gic_v3)->name);
> >                 return ret;
> >         }
> >
> > @@ -158,13 +158,13 @@ int gic_lpi_tables_init(u64 base, u32 num_redist)
> >         return 0;
> >  }
> >
> > -static const struct udevice_id gic_v3_its_ids[] =3D {
> > +static const struct udevice_id gic_v3_ids[] =3D {
> >         { .compatible =3D "arm,gic-v3" },
> >         {}
> >  };
> >
> > -U_BOOT_DRIVER(arm_gic_v3_its) =3D {
> > +U_BOOT_DRIVER(arm_gic_v3) =3D {
> >         .name           =3D "gic-v3",
> >         .id             =3D UCLASS_IRQ,
> > -       .of_match       =3D gic_v3_its_ids,
> > +       .of_match       =3D gic_v3_ids,
> >  };
> > --
> > 2.46.0
> >
>
> Regards,
> Simon

