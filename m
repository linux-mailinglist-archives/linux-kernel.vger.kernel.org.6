Return-Path: <linux-kernel+bounces-200716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABAC8FB3EC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EC27B25B98
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE313147C76;
	Tue,  4 Jun 2024 13:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLZuIIpb"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7504F1474A3;
	Tue,  4 Jun 2024 13:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717508211; cv=none; b=qPm+2wzRMKy/wlLa4OzEEW68hN3r1i6jcR9BQRIfrwvKpacRm3g0xkiExJ3Jru/wyGIbE3Ykk9fZ2Hdi7M/Pw+iIDDo+zz4ehpgL67h5YCl7g9nuLMUQR9Obf9m/ldPMUmL0UDJCxfAo2XIlC2ai+j7wj2CeQIWzE8yc6Ilo5n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717508211; c=relaxed/simple;
	bh=/Fh87YqGPOi0FpXtXOrU3AOW/w8+cf58XYTZMBpqHdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eQcFZqp8mFvGAx8T3bLAfhaVsQbhvL3f/LTmUSFAaiKP/tf788zKRWPXZU7gvTRpFICAaO667NusBeMc2m5iMpdWt5fvm9712MVJ16FW9s1r/BW7opQa0wqSbCl6AI9TkAdVlBAKgGhR3TZ7bXyXodx3YomSe+ESs6s0l2wC5DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLZuIIpb; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso106542666b.0;
        Tue, 04 Jun 2024 06:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717508208; x=1718113008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WzS6KTisShtv8Dg9YtzrFz5oWI6sO/s5tabpbAk8Ij8=;
        b=VLZuIIpblRr2EEa5WJOPy+kQzApv0vdYTVwouOh8eIvpduHeIvLe/l9yy9fvxPNQsT
         yTF2UsHCJt3WC9IPrCXu5VsdkXR7R3+CQOhWz2NwhYKgyoL7jdIrKyEqtru2NK3jYETT
         RFAiWQl3b1Q5JzVB63EuHqD8hRv0fNUmPt0nasBxY2eGbA/P2tTgy7ddkYts1rFp3nqo
         C0sL0KpnyXwIsTFFb8EmqjUuJDoJiotKY+jcjJcNu13a3cIwL+XrZ5JSrtMy8fmH6uI8
         sTRP5gNNSVC/R6rsXxG1COKaikN24/zgZU+8qeu80BpXAl+pmhAQhChDNpS14wBDoOdG
         5kNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717508208; x=1718113008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WzS6KTisShtv8Dg9YtzrFz5oWI6sO/s5tabpbAk8Ij8=;
        b=ZKIBqJkfdBTZRq2gr0n9CsncNHayesa2uiZLFW9NHf0C4wNNznI0/pEi7gHENtt1pQ
         1u0CjkH2cWvbHEhGYd48B5pKOEW3XynnsvOIAHe08hYunCv5Ez37T6krMqATL1vOa1fo
         kreBu66xCbQuPdwZ/O/n1d6aS21lO19rIl/axSTADZDMHMBd5Johx8gcibZB2OM+qLq7
         6HXXks8ZToek9JjCQsb76XjpZmP99yzAFEFgGfG3L5bpdHVzf4fBMi78f1iMJaJGCJCo
         9k3ICYbcvd5Mf4a7SUb+KovWttMG95bu3d8m6fVJyjdSYQy/9+gwrqhhB997bcA/kxXP
         MUiw==
X-Forwarded-Encrypted: i=1; AJvYcCW9d07Q/44OSvifWjx1eNMmwVIaBwHCrmwsB8swfxgk+HzHdihMUAwXXeMnAw9rXilV52qWXCQFlX95ozLcC0BCSWY4PkmVWzRzQfGRc2a1OeMo96r2+Je8cl322pdjYwxnupECUJSnb82j+89n/7je6qvCQYoTZx2SAqdmLqj0fLFtaA==
X-Gm-Message-State: AOJu0YxRy9s1ribJveWAcS0SkQt5Kn9pxB7/L4Agw94iHp3ap4cSHY+y
	tk1Aa0k8rbrlK9UdkyovYhRzC3yEegWIKT15hDQ/I4MEmNkYt2ThZdHPtcwrcNfoSn5NxDPSaUz
	A7HMqIs+HJnRszLMP+aZWtYGYbcU=
X-Google-Smtp-Source: AGHT+IHa76j5YhM9RxdWQaMVukhqK+psmVRWOmA+uRHrwkvuJ3NkIafdOEjdlLw6WNcTAFge8oDqdEuf4/+yT+SHJ8g=
X-Received: by 2002:a17:906:12cc:b0:a66:87d7:39a7 with SMTP id
 a640c23a62f3a-a6821d6480emr767123066b.57.1717508207779; Tue, 04 Jun 2024
 06:36:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601092646.52139-1-joswang1221@gmail.com> <20240603130219.25825-1-joswang1221@gmail.com>
 <20240604000715.3rlmzxriof6wwksm@synopsys.com>
In-Reply-To: <20240604000715.3rlmzxriof6wwksm@synopsys.com>
From: joswang <joswang1221@gmail.com>
Date: Tue, 4 Jun 2024 21:36:37 +0800
Message-ID: <CAMtoTm3XnPr8DY9qPW0X0+aayu_7CWrC1od8qKqU3S2wRjMi1Q@mail.gmail.com>
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

On Tue, Jun 4, 2024 at 8:07=E2=80=AFAM Thinh Nguyen <Thinh.Nguyen@synopsys.=
com> wrote:
>
> On Mon, Jun 03, 2024, joswang wrote:
> > From: joswang <joswang@lenovo.com>
> >
> > DWC31 version 2.00a have an issue that would cause
> > a CSR read timeout When CSR read coincides with RAM
> > Clock Gating Entry.
>
> Do you have the STAR issue number?
>
Thanks for reviewing the code.
The STAR number provided by Synopsys is 4846132.
Please help review further.

> >
> > This workaround solution disable Clock Gating, sacrificing
> > power consumption for normal operation.
> >
> > Signed-off-by: joswang <joswang@lenovo.com>
> > ---
> >  drivers/usb/dwc3/core.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 3a8fbc2d6b99..1df85c505c9e 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -978,11 +978,22 @@ static void dwc3_core_setup_global_control(struct=
 dwc3 *dwc)
> >                *
> >                * STAR#9000588375: Clock Gating, SOF Issues when ref_clk=
-Based
> >                * SOF/ITP Mode Used
> > +              *
> > +              * WORKAROUND: DWC31 version 2.00a have an issue that wou=
ld
> > +              * cause a CSR read timeout When CSR read coincides with =
RAM
> > +              * Clock Gating Entry.
> > +              *
> > +              * This workaround solution disable Clock Gating, sacrifi=
cing
> > +              * power consumption for normal operation.
> >                */
> >               if ((dwc->dr_mode =3D=3D USB_DR_MODE_HOST ||
> >                               dwc->dr_mode =3D=3D USB_DR_MODE_OTG) &&
> >                               DWC3_VER_IS_WITHIN(DWC3, 210A, 250A))
> >                       reg |=3D DWC3_GCTL_DSBLCLKGTNG | DWC3_GCTL_SOFITP=
SYNC;
> > +             else if ((dwc->dr_mode =3D=3D USB_DR_MODE_HOST ||
> > +                             dwc->dr_mode =3D=3D USB_DR_MODE_OTG) &&
> > +                             DWC3_VER_IS(DWC31, 200A))
> > +                     reg |=3D DWC3_GCTL_DSBLCLKGTNG;
> >               else
> >                       reg &=3D ~DWC3_GCTL_DSBLCLKGTNG;
> >               break;
> > @@ -992,6 +1003,18 @@ static void dwc3_core_setup_global_control(struct=
 dwc3 *dwc)
> >                * will work. Device-mode hibernation is not yet implemen=
ted.
> >                */
> >               reg |=3D DWC3_GCTL_GBLHIBERNATIONEN;
> > +
> > +             /*
> > +              * WORKAROUND: DWC31 version 2.00a have an issue that wou=
ld
> > +              * cause a CSR read timeout When CSR read coincides with =
RAM
> > +              * Clock Gating Entry.
> > +              *
> > +              * This workaround solution disable Clock Gating, sacrifi=
cing
> > +              * power consumption for normal operation.
> > +              */
> > +             if ((dwc->dr_mode =3D=3D USB_DR_MODE_HOST ||
> > +                  dwc->dr_mode =3D=3D USB_DR_MODE_OTG) && DWC3_VER_IS(=
DWC31, 200A))
> > +                     reg |=3D DWC3_GCTL_DSBLCLKGTNG;
> >               break;
> >       default:
> >               /* nothing */
> > --
> > 2.17.1
> >
>
> This doesn't seem like it should be applied globally. Please provide the
> STAR number if you can so I can review further. If possible I'd prefer
> to only target your platform.
>
Best Regards,
Jos Wang
> Thanks,
> Thinh

