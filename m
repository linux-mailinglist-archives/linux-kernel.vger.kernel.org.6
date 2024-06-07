Return-Path: <linux-kernel+bounces-206217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9C39005E5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 16:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE65E1C20D9D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B10196449;
	Fri,  7 Jun 2024 14:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5smkiGD"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3CA1DFEB;
	Fri,  7 Jun 2024 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717769259; cv=none; b=hNlriQUCbI2NcL5PG++woebQozCBRHei2IaC2+JCK/FKyhJ5e2p2YxUZiVaAplFVkZLtz1mvCNw+SbnMtXUGKugZNEq27zNYQJ4a6aoeGHq/0pPB2IYGhrJAqPTiv0Z4bq4Y4PrHBhkYyGZxzRwRdihc9loN8xME9JFF6fNgBpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717769259; c=relaxed/simple;
	bh=RTmoEXDN61rc/9JZjVN0F0j/56FrXKcrmh9lendfC9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hYDrgzIwBqfl4U4p5mpBU6aNDngB8Qt4d5OoZ/D2E4lmC8sQinfSI7ZuSGNi+f1Bo/q3kpu0q6jJ1+BcWGIUSFZ+Uxv8Eki7xDQNwEv0+vMo1I0+HRaFJiRTNFcVZ4Z/8bkP1oRMMgD08tUkiOMvdWVMJiybC7OD8vopfLHrSvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5smkiGD; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5751bcb3139so2427408a12.1;
        Fri, 07 Jun 2024 07:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717769256; x=1718374056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Me2iTbiGcSnepzGFoeP1Kv/Pyr0OL6SqP6KwSmLQKI=;
        b=M5smkiGDHos/F9o5hg880v2JXv7Fx91e/exONN3KcXcjYJbQC5MZZMFzJR305ehofS
         6mvfSlqbr7nSuE9AcuQPeXsJIY3h8UyxfEzW9I8Gi3UqyaE94ppYtLt6v5Xa7/BxkHw5
         94HNTvzVhRsS/JzS66g3FFxCTIR4w9xx7i4QY5kP07KPwcOfCT2kvuPgtkPUWx8fVp2Z
         BQ2aEhuMSE2Qqqw/4jfYVTZF4SUCPZSEDkp+wtldaqeEoBuuK0mB0GSzGmdPTEIxE4r9
         4NJaC/tvfiipLOSgEQWDRHx9TAHAMbQcrevDH1jsWWxJl1h6Lz9yWr6hj1K+XFBZ9Bkk
         xvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717769256; x=1718374056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Me2iTbiGcSnepzGFoeP1Kv/Pyr0OL6SqP6KwSmLQKI=;
        b=w3C6T7LxWzsax24j2gUZz2ObVRnvl3PCD1t8/takyTCiBFlrcRcZxc1Zm+Yn/CrBcu
         vAo0GZ1UrXNdc1VCF1RAXnhAlaM185OVb3L3elwzfLRWapscJhZgVmWzVrhMMWKtgSX6
         gPYUisnt89AqViLkIuzoJ2hLnOCMWJJEJ16OgUy4G+uhngeF8iR0JpsOTGCf26chFu+D
         EAtkCYGLBiNYKtNuvHVHDy6DKMRcf1yoe4ZRCQVjDx5qiNzWPDGiL5guP9PT58z52tkq
         NxDN2mTfmYYqbYTfT8Ox7x2tzQJK8IkaVwss+wyIIQFXkKB7XXGzGV3mMtNoP6cSdot4
         bmtw==
X-Forwarded-Encrypted: i=1; AJvYcCWlu/gvSA/atsfv3ZMS9a6Lvo2ll5Opm0HHQEOlNn07u4EDWgOKsvhwSaUpnFFrlqJyINZRQaHt+eeKSKTMWHrlpyoCnPjZywB+r+IBBs3A1kmiWWoERabFew9FOqFuGj6uqLeu6Mb8fFQe9sW9rVv2vW5gAyG8ArqAgey/x+yUcS0eMQ==
X-Gm-Message-State: AOJu0Yz0t3+ohKAuUAiHkCRsZIcNB+r1v2kEEmk9hjx1Bh8vHg0DsUgy
	EPVpfBZWtDpYBjgqU4snHbIos4Z92Q9GV4zyR4P3EHD5gehQ7fUtPNeqqQhxIbDGmLgI07gyYFt
	VJps3cH4mKsPpGt5TeORTs8W6nP0=
X-Google-Smtp-Source: AGHT+IGOj6cqmE+0vX1WwdfE9tuk3n3txL5O9YIAEo8rjdIp3JwO23Yvn8mZ2mG6/ge7dgPEgzIxsenbJpZKmm2bNUA=
X-Received: by 2002:a50:9e06:0:b0:57a:2a46:701 with SMTP id
 4fb4d7f45d1cf-57c50902d83mr1546865a12.19.1717769256110; Fri, 07 Jun 2024
 07:07:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601092646.52139-1-joswang1221@gmail.com> <20240603130219.25825-1-joswang1221@gmail.com>
 <20240604000715.3rlmzxriof6wwksm@synopsys.com> <CAMtoTm3XnPr8DY9qPW0X0+aayu_7CWrC1od8qKqU3S2wRjMi1Q@mail.gmail.com>
 <20240606012936.jdokepv73qrdorbp@synopsys.com>
In-Reply-To: <20240606012936.jdokepv73qrdorbp@synopsys.com>
From: joswang <joswang1221@gmail.com>
Date: Fri, 7 Jun 2024 22:07:26 +0800
Message-ID: <CAMtoTm3tSNKdv+LOCeQFtFpGq=6yNqTm8Jq=koFfAxT4UamOQg@mail.gmail.com>
Subject: Re: [PATCH v2, 3/3] usb: dwc3: core: Workaround for CSR read timeout
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "balbi@kernel.org" <balbi@kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, joswang <joswang@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 9:29=E2=80=AFAM Thinh Nguyen <Thinh.Nguyen@synopsys.=
com> wrote:
>
> On Tue, Jun 04, 2024, joswang wrote:
> > On Tue, Jun 4, 2024 at 8:07=E2=80=AFAM Thinh Nguyen <Thinh.Nguyen@synop=
sys.com> wrote:
> > >
> > > On Mon, Jun 03, 2024, joswang wrote:
> > > > From: joswang <joswang@lenovo.com>
> > > >
> > > > DWC31 version 2.00a have an issue that would cause
> > > > a CSR read timeout When CSR read coincides with RAM
> > > > Clock Gating Entry.
> > >
> > > Do you have the STAR issue number?
> > >
> > Thanks for reviewing the code.
> > The STAR number provided by Synopsys is 4846132.
> > Please help review further.
>
> I've confirmed internally. As you have noted, this applies to DWC_usb31
> v2.00a for host mode only and DRD mode operating as host.
>
> >
> > > >
> > > > This workaround solution disable Clock Gating, sacrificing
> > > > power consumption for normal operation.
> > > >
> > > > Signed-off-by: joswang <joswang@lenovo.com>
> > > > ---
> > > >  drivers/usb/dwc3/core.c | 23 +++++++++++++++++++++++
> > > >  1 file changed, 23 insertions(+)
> > > >
> > > > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > > > index 3a8fbc2d6b99..1df85c505c9e 100644
> > > > --- a/drivers/usb/dwc3/core.c
> > > > +++ b/drivers/usb/dwc3/core.c
> > > > @@ -978,11 +978,22 @@ static void dwc3_core_setup_global_control(st=
ruct dwc3 *dwc)
> > > >                *
> > > >                * STAR#9000588375: Clock Gating, SOF Issues when ref=
_clk-Based
> > > >                * SOF/ITP Mode Used
>
> Since there's another STAR, let's split the if-else case separately and
> provide the comments separately.
>
OK
> > > > +              *
> > > > +              * WORKAROUND: DWC31 version 2.00a have an issue that=
 would
>
> Can we use the full name DWC_usb31 instead of DWC31.
>
Subsequent V3 versions use DWC_usb31
> > > > +              * cause a CSR read timeout When CSR read coincides w=
ith RAM
> > > > +              * Clock Gating Entry.
> > > > +              *
> > > > +              * This workaround solution disable Clock Gating, sac=
rificing
> > > > +              * power consumption for normal operation.
> > > >                */
> > > >               if ((dwc->dr_mode =3D=3D USB_DR_MODE_HOST ||
> > > >                               dwc->dr_mode =3D=3D USB_DR_MODE_OTG) =
&&
> > > >                               DWC3_VER_IS_WITHIN(DWC3, 210A, 250A))
> > > >                       reg |=3D DWC3_GCTL_DSBLCLKGTNG | DWC3_GCTL_SO=
FITPSYNC;
> > > > +             else if ((dwc->dr_mode =3D=3D USB_DR_MODE_HOST ||
> > > > +                             dwc->dr_mode =3D=3D USB_DR_MODE_OTG) =
&&
>
> There's no OTG mode for DWC_usb31. Let's enable this workaround if the
> HW mode is not DWC_GHWPARAMS0_MODE_GADGET.
>
> > > > +                             DWC3_VER_IS(DWC31, 200A))
> > > > +                     reg |=3D DWC3_GCTL_DSBLCLKGTNG;
> > > >               else
> > > >                       reg &=3D ~DWC3_GCTL_DSBLCLKGTNG;
> > > >               break;
> > > > @@ -992,6 +1003,18 @@ static void dwc3_core_setup_global_control(st=
ruct dwc3 *dwc)
> > > >                * will work. Device-mode hibernation is not yet impl=
emented.
> > > >                */
> > > >               reg |=3D DWC3_GCTL_GBLHIBERNATIONEN;
> > > > +
> > > > +             /*
> > > > +              * WORKAROUND: DWC31 version 2.00a have an issue that=
 would
> > > > +              * cause a CSR read timeout When CSR read coincides w=
ith RAM
> > > > +              * Clock Gating Entry.
> > > > +              *
> > > > +              * This workaround solution disable Clock Gating, sac=
rificing
> > > > +              * power consumption for normal operation.
> > > > +              */
> > > > +             if ((dwc->dr_mode =3D=3D USB_DR_MODE_HOST ||
> > > > +                  dwc->dr_mode =3D=3D USB_DR_MODE_OTG) && DWC3_VER=
_IS(DWC31, 200A))
> > > > +                     reg |=3D DWC3_GCTL_DSBLCLKGTNG;
> > > >               break;
> > > >       default:
> > > >               /* nothing */
> > > > --
> > > > 2.17.1
> > > >
> > >
>
> We have the same checks and comments here. Can we refactor?
> Perhaps something this?
>
> power_opt =3D DWC3_GHWPARAMS1_EN_PWROPT(dwc->hwparams.hwparams1);
> switch (power_opt) {
>     ...
> }
>
> /*
>  * <comment>
>  */
> if (power_opt !=3D DWC3_GHWPARAMS1_EN_PWROPT_NO) {
> }
>
>
> Thanks,
> Thinh

Thank you for your valuable suggestions.I can refactor according to
your suggestion.
Do I need to submit a V3 version patch separately, or should I submit
a V3 version patch together with other cases?

Thanks,
Jos Wang

