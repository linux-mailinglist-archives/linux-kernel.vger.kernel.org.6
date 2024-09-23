Return-Path: <linux-kernel+bounces-336323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A22298392C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 23:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C5471C20340
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 21:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4F584E11;
	Mon, 23 Sep 2024 21:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHruMZ+b"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AAB83A09;
	Mon, 23 Sep 2024 21:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727127714; cv=none; b=k4nVwnQa7GR8Ox40E/5MLO+IGH4+iISxCLwRUB/B/M811DAiLABALnja7tvooEDx+WyKM2jZpnkx342xF5DmevlhN+GdfMz3niv/5Eu/qcCnl1KDCHu/ReStkL/EZFQoVWXJqE5V105gKc9unr/V2IZjli14Qr6qniCOAxiAp3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727127714; c=relaxed/simple;
	bh=dH3Fs4gaXyh4xAjXLfEOaJzNbuFwpKmfwG0m8DGGBNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RlWVRtkA2skowZ7tXr6YQVx6K27yRpNXKdib2YxNNQFx8rABFtA3prk4lgtW2W5S+s5AT227Wce8XHn5/IVh0pMsZ5aE0RlVno+B/CRmp3TPb4+LD08ULXJZnJObCmu4Z51NFTvw3be04rjWE9zvpPK4bzPBlde/DGieDZ8rHQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHruMZ+b; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c5c3a1f474so1641719a12.0;
        Mon, 23 Sep 2024 14:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727127711; x=1727732511; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vj4G2T1grHdIHSEPbY3FjSro+9TOwSMy/M9qtap3Q6g=;
        b=JHruMZ+bE00jcalqrB2KJg7pKYe7VxWpKycVOOfRaaX4Ht6KGOtI9B1sZG1mZj76lg
         BGw20buzSU6M9T9j7dvGyArTLm6mXuRvEwG+KmInCVFiaqc1aRiighXCyx9LyfPAY+jj
         /Tl64KPJsW7cGb75PWTC6zZ3DZBTVgRoJ38vlknE6bOtlRQ4wU9y4L3ob+RAmLcvFRZ7
         eXmXbtt5dbjjadQAfccQrAqhN8NoxZd1z9gVM/z1BUofyBonjIXeudWe4UU1fqA/A0Kj
         BX+fmvtR3aa2MXxpDB5XDeBSUtYHaPXykb8X7r1lLu1ZPYndv5VJSa9y2jBZX1sY75nj
         t2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727127711; x=1727732511;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vj4G2T1grHdIHSEPbY3FjSro+9TOwSMy/M9qtap3Q6g=;
        b=EO59nJju65+D1pUQEd3xNO0u/QPaXnqb+0ekq8Oa8bp82K5p5EGV+P+5GXIhMb2yKz
         aweI9lemGZfxugNrL7nYRixjbajNlC7y8tnJXGL6kal71HgIJbzB8hjoVm7v2JvJ2bo9
         Nkc1/rafSOOuIe5o8CDU7WdkVCKwA1hF+4XByjftcGp2ilJ2ng5Yv7t0wZfyF3WeqKyk
         XrAwRrLlj2uKrj8Tn91x7sGMXGOcHA+ofKlgGjHFwd733wmkifJmd1NCAU3KdhGUW72v
         e6vyG7bmZgSgEvgPE4PacrngX8J4QQISufnYDiQVNh29KcFNLfCRks7RDCgr6Ga/CWCZ
         jXBw==
X-Forwarded-Encrypted: i=1; AJvYcCULGUZJPSY0N55N4CRk7RbTose4Gw2PU6OQwYxBMW5dkwB2keqhGEeZPn4cXJP4nT0IqxD9yAj/8aX5@vger.kernel.org, AJvYcCWlqwgvFLpM3U66sfWs+5IZCEgWb1ECisMwr6j3oALkp8rFOe7ED+8XBdYNVvLa6K1doF7ngRlY8gAjbh5i@vger.kernel.org
X-Gm-Message-State: AOJu0YwmeOrh3AYyFcyGgPztfB5TLSpatKlUWIj85j7W9PeL+Pz6Tq+I
	Fqyj5WIgYUJ1GjuCHaNPlFiUM5OJ/oAbPuoNYcvAUqz1SNi1LstY72TBtLaYxU1egrjsr7qRIqQ
	g5JxyRa4rnnAyvmIqvANw7KjjAyG+C123VA==
X-Google-Smtp-Source: AGHT+IGW7ApBphv8pfvu6Os5wijGV/DfnmM9DmA1w/qBjeYxUvvWJ8DSUL3XlaCeqaamw3eFgCe1h2l8CQjcpJ8SW34=
X-Received: by 2002:a17:907:7b93:b0:a8a:af0c:dba9 with SMTP id
 a640c23a62f3a-a90d56d9aabmr1255101266b.16.1727127710543; Mon, 23 Sep 2024
 14:41:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920181231.20542-1-erezgeva@nwtime.org> <20240920181231.20542-2-erezgeva@nwtime.org>
 <4e0cf43c-4843-451c-ac6f-86775dbccb2b@linaro.org> <CANeKEMOmhAPM1j1_ihzcC2wL6jKsWXPCGfZs+euS8mRvtqgE5A@mail.gmail.com>
 <2c87568d-3caa-4162-91de-094684f1b268@linaro.org> <CANeKEMO4ckeJZHKEOKHVeamPzR045jpwkXWfJS9S6rBiMTayuQ@mail.gmail.com>
 <688d3e68-c339-4a44-b6b5-366dd5f12965@linaro.org> <CANeKEMNKF5WtVgzxbMnLFsqRHNOz=+gD-if8aBqsWwjgDvz3GA@mail.gmail.com>
 <ca2c03f7-0769-4b2a-b743-3ebda9e29755@linaro.org> <CANeKEMNdGvteumpvLHhDoiVoZwPJ4iOs+Ej8KDoXR9-Vz0-rvQ@mail.gmail.com>
In-Reply-To: <CANeKEMNdGvteumpvLHhDoiVoZwPJ4iOs+Ej8KDoXR9-Vz0-rvQ@mail.gmail.com>
From: Erez <erezgeva2@gmail.com>
Date: Mon, 23 Sep 2024 23:41:13 +0200
Message-ID: <CANeKEMOH=CTC9GY5LFLj0mx2OoytR-9bOsFM7edDQ6-e=CaNgw@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] mtd: spi-nor: core: add manufacturer flags
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Erez Geva <erezgeva@nwtime.org>, linux-mtd@lists.infradead.org, 
	Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, linux-kernel@vger.kernel.org, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Esben Haabendal <esben@geanix.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Sept 2024 at 21:30, Erez <erezgeva2@gmail.com> wrote:
>
> On Mon, 23 Sept 2024 at 19:53, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
> >
> >
> >
> > On 9/23/24 3:51 PM, Erez wrote:
> > > On Mon, 23 Sept 2024 at 16:18, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
> >
> > cut
> >
> > >>> After reading a lot of Mactronix datasheets, I suggest also reading
> > >>> all SFDP to all  Mactronix chips.
> > >>
> > >> Why? It seems too invasive. Generally it is not recommended to issue
> > >> unsupported commands to flashes. Change just the flash that you use and
> > >> can test.
> > >
> > > It is not, All Mactronix chips in the last 15 years have SFDP.
> >
> > This is false. I worked with an octal macronix flash that didn't define
> > SFDP tables, mx66something.
>
> I did not use the mx66XXX. Is it an SPI-NOR?
> I would guess that mx66something you use is already obsolete.
> Or marked by Mactronix as 'not recommended for new HW'.
> It might be used by a big customer using the HW for a long time.
>
>
> >
> > > The chips in the manufacturer compatibility table are all obsolete.
> > > Mactronix reuse the JEDEC IDs. There is no point pretending these are
> > > the same chips.
> > >
> >
> > If macronix doesn't care about backward compatibility, we/I do, and we
> > can't break it.
>
> As I said, I do not ask you to do that.
>
> I do not represent Macronix, so I can not speak in their name.
> My conclusions are based on examining their datasheet.
> I did ask their technical representor.
> The only straight answer I got from the technical support is
> that you can not derive OTP configuration based on JEDEC ID/SFDP,
> and you must know what chip you use.
>
> >
> > >> cut
> > >>
> > >>>> Which flash do you have at hand, both, none, just one of them?
> > >>>
> > >>> When I started working on the OTP code, I used MX25L12833F.
> > >>> But later I left the company.
> > >>> So I use my beaglebone black and connect it to a MX25L3233F.
> > >>
> > >> I understand mx25l12805d and mx25l12833f share the same ID. How is
> > >> mx25l3233f related, does it share the same ID as the previous two?
> > >
> > > They are not. I just replaced the company hardware with a different one.
> > > You ask me to report the hardware I use for testing.
> >
> > So MX25L3233F does not share the same ID as MX25L12833F and mx25l12805d?
> > Then why do we talk about ID reuse?
>
> I replaced the hardware I use.
> Most of the reused IDs are of old chips, usually obsolete, not selled
> or not recommended for new HW.
> So the chance to use 2 new chips with the same ID is limited.
>
> I respect the fact you want to keep backward compatibility.
> I just extend the approach to OTP parameters.
> If an old chip with the same JEDEC ID uses different OTP parameters.
> We will break backward compatibility with this old chip.
>
> > >
> > > The patch covers the one I use with beaglebone black.
> > > I just mentioned the OTP callbacks are per manufacturer.
> > > But if a new chip in the future would require different callbacks,
> > > then just add them.
> > > My patch is using a single chip, the one I send the testing with.
> > > beaglebone black + MX25L3233F.
> >
> > Sounds good.
>
> +
>
> >
> > cut
> >
> > >> I said new compatibility will be introduced as a last resort only if we
> > >> can't differentiate the flashes at run-time. You haven't proved me yet
> > >> that this is the case.
> > >
> > > Then you do not read my explanation.
> >
> > What explanation? I've read your cover letter, commit message and I
> > didn't understood what you're trying to achieve.
>
> This is on me.
> I'll try harder with the cover letter.
> I apologize.
>
> >
> > > Do you wish me to send the Macronix datasheet of the 4 chips?
> >
> > No, I need just a paragraph where you explain what are the challenges
> > and how you want to address them.
>
> +
>
> I try to explain that we can not based on JEDEC ID + SFDP to figure
> out the correct OTP parameters.
> This is also the only straight answer from Maxtronix I got.
>
>
>
> > >
> > >>
> > >>> You ask if it is possible to deduce it from JEDEC ID and SFDP,
> > >>> I answer that this is not possible, at least in some cases..
> > >>
> > >> I'm interested just about your case, not all the possible cases.
> > >
> > > Actually it is the MX25L3233F and its previous chips.
> >
> > Which previous chips? Do you have any such chip at hand? If not, why are
> > we talking about collisions?
>
> JEDEC ID 0xc22016
> MX25L3205D - No SFDP, 2 OTP  regions of 128-bit, 384-bit, Status:End of Life,
> Recommended Product MX25L3206E
> MX25L3206E - support SFDP, 2 OTP  regions of 128-bit, 384-bit, Status:
> Not recommend for new design Recommended Product MX25L3233F
> MX25L3233F - support SFDP, 1 OTP region of 4096-bit, Status Production
>
> JEDEC ID 0xc22017
> MX25L6405D - No SFDP,  2 OTP  regions of 128-bit, 384-bit, Status: End
> of Life, recommend Product MX25L6406E.
> MX25L6406E - support SFDP, 2 OTP  regions of 128-bit, 384-bit,
> Status:Not recommended for new design,
> Recommended Product MX25L6433F.
> MX25L6433F - support SFDP, 2 OTP regions of 4096-bit, 4096-bit, Status
> Production.
>
> JEDEC ID 0xc22015
> MX25L1606E - support SFDP, 2 OTP  regions of 128-bit, 384-bit,Status:
> Not recommend for new design,
> Recommended Product MX25V16066
> MX25V16066 - support SFDP, No OTP. Status Production.
>
> The older chips with the same JEDEC IDs are at end of life or not
> commended for new design.
> But if we talk about backward compatibility, we can have them on old Hardware.
>
> I think that I miss a chip in the list, I remember finding 4 chips
> with the same JEDEC ID.
>
> >
> > > Anyway, I will not submit a broken solution.
> > > Whether you like the idea or not.
> > >
> >
> > Fine by me.
>
> +
>
> >
> > cut
> >
> > >>>>> I told you we can not "guess" OTP settings based on JEDEC ID and SFDP existence.
> > >>>>
> > >>>> When? And more importantly, why?
> > >>>
> > >>> I send you example of 3/4 chips that using JEDEC ID and SFDP existence
> > >>> is not enough.
> > >>
> > >> Why? Do they have the exact SFDP tables? Prove me, drop them all.
> > >> Any bit that differs in the SFDP tables is enough to differentiate the
> > >> flavors of flashes. Vendor tables included ;)
> > >
> > > Because the SFDP is not related to OTP in any way.
> > > You are planning to decide OTP parameters on non relevant information.
> > > If you wish to implement such a broken feature, you are welcomed.
> > > I'll pass.
> >
> > Ideally we have a single jedec,spi-nor compatible. If there are flash ID
> > collisions we try very hard to differentiate the flashes at run-time.
> > New compatibles are introduced only if we can't differentiate the flavor
> > at runtime (be it by parsing SFDP or some other way).
> >
>
> All I say is that it is a dangerous approach to deduce in this way.
> Macronix does not care about breaking, they might introduce new chips
> with different SFDP.
> They usually do not sell new chips with the same JEDEC IDs. but apart
> from that, we can not rely on any assumption.
>
> I can understand if you say that you do not wish to go into this mess.
> But indirect probing based on JEDEC ID + SFDP is a risk, I don't think
> we should take with Macronix.
>
>
> > cut
> >
> > >>>> And I think I already said that you can differentiate between the two
> > >>>> based on SFDP presence. mx25l12833f has SFDP, thus when SFDP present use
> > >>>> the mx25l12833f-OTP configuration. When SFDP is not presence one may add
> > >>>> support for the mx25l12805d-OTP configuration.
> > >>>
> > >>> No, we have 3 chips.
> > >>> 2 are using the same JEDEC ID and both using SFDP, yet they use a different OTP.
> > >>
> > >> Which ones are these?
> > >>
> > >> I guess mx25l12805d is non-SFDP. Then mx25l12833f and mx25l3233f define
> > >> some SFDP tables. Do mx25l12833f and mx25l3233f have the same OTP
> > >> organization?
> > >
> > > No, that is the point.
> > >
> > ? Do you care to explain?
>
> The point is that you can not predict OTP based on JEDEC ID + SFDP.
> It seems as if Macronix does the OTP in parallel.
> See the list above.
>
> >
> > cut
> >
> > >
> > >>>
> > >>>>
> > >>>> Is there any case that I miss?
> > >>>
> > >>> According to your reply, I would say pretty much most.
> > >>
> > >> This is again inappropriate ... I will read your next email as well, but
> > >> I'm not going to tolerate such replies anymore.
> > >
> > > I agree on this one.
> > > Seems you are looking for something I do not agree on.
> >
> > Michael disagrees with OTP being specified in DT too. We both already
> > suggested how to deal with flash ID collisions but you keep ignoring us ...
>
> I apologize, but I do not insist on DT.
> Any solution that configures OTP regardless of JEDEC ID + SFDP is OK by me,
> I am open to testing and submit a patch accordingly.

Just a thought.
What if we put a JEDEC ID + SFDP Macronix OTP probing code under a
kernel configuration with a poorer warning?

Erez

>
>
> >
> > > This is not because I oppose probing,
> > >  this is because you ask for indirect probing, against Macronix own
> > > recommendation.
> >
> > What did macronix exactly recommend? Did they say that we shouldn't
> > interrogate the SFDP data in order to differentiate the flashes at
> > run-time? If yes, why is that?
>
>
> I forward the reply from Holger Schulze, Field Application Engineer,
> Macronix Europe N.V. I received on the 3 Jul.
>
> I ask:
> "But the OTP setting is not in the SFDP.
> How can we know which OTP size and number of regions to set?"
>
> And the reply:
> "You are correct, the OTP setting is not defined in the JEDEC spec for
> the SFDP table. The only way is to refer to the data sheet."
>
> Thanks for your feedback
> Erez Geva

