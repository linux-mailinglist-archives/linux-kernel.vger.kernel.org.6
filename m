Return-Path: <linux-kernel+bounces-379231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1109ADBC5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E924C282343
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4320175D53;
	Thu, 24 Oct 2024 06:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jd7IRQiF"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAABF17BD3;
	Thu, 24 Oct 2024 06:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729750270; cv=none; b=ARTQBOjFksLLE8M0t60mHd3pUn7R0Ba7kaG0+sBq6HEkRy1pVBzcYpUVXLyNx7NStjs5WjQbZ9YBx882I9ux5/alUBnonbTs5GiyOr7GDtR1laHReSnrmoCgidzJRzn3sqiAee1vGw2VYj3iAqcxmGGRrtZooXwXeayHFd4lzfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729750270; c=relaxed/simple;
	bh=kA+SuUBycQvzJUDFFTWMy4FdkH9m/22mMr6N+agBzqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qpRyCbNdGRcaeO99hXbgik3PFDnV1Z3Ztwm5ijCDFdlPtPPEobei3KTOHBqwdofPq/pUfNTF/x6RAiRThlb8xQd/xhr9NvlL5rF/eV6wlkN3eW8Qg3fu7rY5PR+sPBUxPXqNCDyWMDoHUIQOp9wWOC5NHwfHi4hpti8rXb13Xqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jd7IRQiF; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e2b9a22f60cso94040276.2;
        Wed, 23 Oct 2024 23:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729750267; x=1730355067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QCC/fXyFCqGZc13Ieb+geQUzVW9qP/WxddXXdUzTuQ=;
        b=Jd7IRQiFjV2bnLnyd5aWhoXmzKFLism/CahsQoOF9T9jr1zjSkgof/3CdE8p43wx3U
         Zll6UMJUJZJDeYyQxekuH95l/rHCqtPeogmg19sFnxGsq51jO1r+CJQwLrlY/Hw3nlA4
         RF2r3zaKelrpPKGim2mWOo8SKXEC4TrLSmzLRyAlvwY0CxRjJxp3urgysgZsTzODB2Tu
         qATp2RAFTRa5KXVcQziXRyWuo5kmyH0SFtSEUrtmNYnYDrmyWezOqSHZ8vIZtHP8kj1I
         SA9spYNE94S8zL6B4zzT1gX31In+nJrbo4t61w3ipFeA74bYCA2FEvYFY4zYwSpNFgb9
         ielQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729750267; x=1730355067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8QCC/fXyFCqGZc13Ieb+geQUzVW9qP/WxddXXdUzTuQ=;
        b=vg5Tde4HDrRBcTqmLruoLWJpR4zJohsPJvKTYa6o/1C/e/o0lUNdmsEAsUJtMYYuRZ
         wM7JAlIHksUFW3o7osvPysKXvfSinjLFNNOTuD8jefzyf3h2hDd0fVKf9UT+N+mD/rBJ
         qntZUkvJSBQHJDcP+FLkObn1dGei3pBv1XTLJbJrYMZ5okPXcseLgHLk1TcNig1frSa/
         49Ji5AZRbl5AJeo4Myy5Z8dzxlDJM5Rn5ayC6SC//B97SlQbkhcoxjIWZx6oYGnwDm7Y
         4o7sH1VpVjMjFOhh3Wo/frUERykYZZ0pw7swLwswJqGFfAVpXSzgclykpq6wS+P7HoU8
         3Fww==
X-Forwarded-Encrypted: i=1; AJvYcCUzXi/F/bN3gzNCSOy3DSWVzziTPFAbFoXbKKaXgDMSYRVeiLOBt2ZakAHA7v9ztwO42+OgZNV4b7v9C8m8@vger.kernel.org, AJvYcCWjeEC8UiTLmOOclKQlntlAqhCqj6xwXGtDsa6FfFQcpoWGuq/toNagL2rcbHMiZ02QgmsYTveWwJy8@vger.kernel.org
X-Gm-Message-State: AOJu0YxLGsAJDdfsixNX/ShhPkK7carMaunLIxTyc/nXzzq4nlvTej78
	kwOaSVQCwrDTSGHO0G92L6tcZDKzFrDlt9HZslWlGU911k2tGIWzXW5WCvVEL8vkxeXFUOFokwh
	SnOAxDjWe30RgU//GHtg2IuLEKMs=
X-Google-Smtp-Source: AGHT+IEn0/HjwMWk9NgWX092uVWpMjcGBEsdrnbsMtt83CSZo7dgc+feaRdGA7AuubMAlJgrskAZhc6xZzTfrGNekBU=
X-Received: by 2002:a05:690c:b88:b0:695:e4b0:10ce with SMTP id
 00721157ae682-6e7f0f9893emr23812877b3.7.1729750266718; Wed, 23 Oct 2024
 23:11:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020194028.2272371-1-l.rubusch@gmail.com> <20241020194028.2272371-13-l.rubusch@gmail.com>
 <v4gqnsyhqjccdac3kgmo7y2aunigqquqc3f7n7wgt5hiv3rnip@jfmoq3is4rjh>
In-Reply-To: <v4gqnsyhqjccdac3kgmo7y2aunigqquqc3f7n7wgt5hiv3rnip@jfmoq3is4rjh>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Thu, 24 Oct 2024 08:10:30 +0200
Message-ID: <CAFXKEHZOPioES4guqjco+BE7i=Eqe2DdHiUxAksBCZm7nx1Rog@mail.gmail.com>
Subject: Re: [PATCHv2 12/23] ARM: socfpga: dts: add a10 clock binding yaml
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	dinguyen@kernel.org, marex@denx.de, s.trumtrar@pengutronix.de, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 9:05=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Sun, Oct 20, 2024 at 07:40:17PM +0000, Lothar Rubusch wrote:
> > Convert content of the altera socfpga.txt to match clock bindings for
> > the Arria10 SoC devicetrees. Currently all altr,* bindings appear as
> > error at dtbs_check, since these bindings are only written in .txt
> > format.
> >
>
> Please use subject prefixes matching the subsystem. You can get them for
> example with 'git log --oneline -- DIRECTORY_OR_FILE' on the directory
> your patch is touching. For bindings, the preferred subjects are
> explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-pat=
ches.html#i-for-patch-submitters
>
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > ---
> >  .../bindings/clock/altr,socfpga-a10.yaml      | 107 ++++++++++++++++++
> >  1 file changed, 107 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/altr,socfpg=
a-a10.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/clock/altr,socfpga-a10.y=
aml b/Documentation/devicetree/bindings/clock/altr,socfpga-a10.yaml
> > new file mode 100644
> > index 000000000..795826f53
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/altr,socfpga-a10.yaml
> > @@ -0,0 +1,107 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/altr,socfpga-a10.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Device Tree Clock bindings for Altera's SoCFPGA platform
>
> This wasn't tested or you have some very, very old dtschema.
>
>
> > +
> > +maintainers:
> > +  - TODO
>
> We should not be taking unmaintained stuff.
>

This is just a trigger here. Basically, I have no probelm in placing
my own name here. AFAIR Mr. Dinh Nguyen has his name on the other
intel/altera related files, so I'm not sure who decides that. Please
let me know.

Basically this particular patch is related to my initial questions
(cover letter):
1.) Documentation/devicetree/bindings:
Executing the following find...
$ find ./Documentation/devicetree/bindings -name socfpga-\*.txt
...shows 4 text files describing "altr," bindings. I sketch-implemented
the clock binding and could reduce some of my dtbs_check warnings. So, my
questions is, if this is the right way? Shall I try to write .yaml files
for all 4 of them, too? Related to that, who will be maintainer?

2.) Some bindings, e.g. the Silabs clock generator seem to have no
driver, thus show up as warning:
    compatible =3D "silabs,si5338";
IMHO it is most likely rather to be probed/loaded in the SPL of the
bootloader. Is it problematic to keep those declarations (showing up as
warning in dtbs_check) or how to deal with them?

3.) Please, give me some feedback if the DT and binding adjustments are
going into total wrong direction, or where I may do better. If it is ok,
and acceptable, or what is still missing. I tried to split them, to
allow for better single integration / discussion let me know if this is
ok, too.


> > +
> > +description:
> > +  This binding uses the common clock binding[1].
> > +
> > +  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
>
> Drop description or describe the hardware.

Ok (the description was taken as content from the corresponding .txt file)

> > +
> > +properties:
> > +  compatible:
> > +    description: |
> > +      shall be one of the following
> > +        - "altr,socfpga-a10-pll-clock" - for a PLL clock
> > +        - "altr,socfpga-a10-perip-clk" - The peripheral clock divided =
from the
> > +            PLL clock.
> > +        - "altr,socfpga-a10-gate-clk" - Clocks that directly feed peri=
pherals
> > +            and can get gated.
>
> Drop description.

OK (dito)

> > +    enum:
> > +      - altr,socfpga-a10-pll-clock
> > +      - altr,socfpga-a10-perip-clk
> > +      - altr,socfpga-a10-gate-clk
>
> Why are you adding bindings per clock? Usually that's a no-go, you
> should be describing here clock controller unit.

as above, taken from .txt - So, I see there seems to be some interest
to convert the .txt files into .yaml files. I will have a look at the
other altr, ....txt -> .yaml cases, but will need to do more readings
first. This may become a different patch set, then.

