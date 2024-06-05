Return-Path: <linux-kernel+bounces-201752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FA58FC2D0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 06:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C7F4284F58
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 04:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E4D137925;
	Wed,  5 Jun 2024 04:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pogx3Kd0"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9258C1F;
	Wed,  5 Jun 2024 04:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717562995; cv=none; b=eHmU1wS+9roLSyzB9Yg6n8PMZpSVjGG/PK4z1kVqgKPdzbz3zc4//LE/GoAz6YQwgvGXlETldHuhxCtmDR6Cvb9PkNLRHU4xWNMsJR1BuaK9DS0O/dtvzaVAZpaqzs1aIQutX8gYBqpVSTuTIkjRCUvUcU3ncuU7tURsaM+j8t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717562995; c=relaxed/simple;
	bh=ieVPw4m7/zM1hr7mE/clhk/7hqOX+SLjwd2xCpUmfO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nbbxB8ILC1irCpxVTKMGC9GZLd0YnW3uyq/v+m2KUZ2VKNtc3JTlPD1PzuvrEL3b7aUCqC3mQxhuHlNFzxijV3a1077PLL7U7d5tsniySUvCebU6r6dQY41rMvvYOI5mPkcH+GbVnC9n55azzJWH1ZFSyvYz8xndmfE7atmNpQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pogx3Kd0; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a68bf84d747so390921866b.3;
        Tue, 04 Jun 2024 21:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717562992; x=1718167792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8o6IgKdiBiQxTc8SqP8ZEmARl0hncQVwmG5FUnrzdM8=;
        b=Pogx3Kd0myIPtl8uu/Xe8+lFJ5h01dlhdkMEZBeskt0fw8TwzE0UPZVpJjSJuAHeum
         NQJ1zq3Bw85lEiTLjq6PrpBNEVihth9RLPcXKjcLqtiUURFJNBXoIfpGbgIyLyEqAFp4
         cM6jTZmvRB1JfaB6AqtYGXo2UPavwHseyWkHW6lsXIruCD16Xi/DtKTkdqlfaSroA0Be
         TRnzpVyIvJ4q3adqGf1IUu/dMYDlPc2LUyks9zjck+SjsJ1J85igfFMcoKBDqaG0xHNU
         5rib2sDx3g5Q1oSFDb4CZupoUuQHOc465pbIMcCEXM07qCVGkV0yKhBnmzKRKPXHj50U
         Ql0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717562992; x=1718167792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8o6IgKdiBiQxTc8SqP8ZEmARl0hncQVwmG5FUnrzdM8=;
        b=jofb0hVIN/oVxZ/Vonsa99LlXEhRC7OGDJoB2k8gqOMLQ879JOi6Cjhtaf7tbf8rhI
         /BhlC1f9Acc9QYAE7cO50NXvlXNm+c5mA7l6PlmgDnCXfOGPzyLclLkNz+KsaeGWRBnW
         +aZExwjVFcL5KenTfIVAXZ/lIYFMV2t9NfOBeHjiXW/LltDAVv2tjRwB5WPwncZhkZGA
         QRteXMGq+PmOXuvUgmNiDiiO0LEPRhy23aJ8s97E0XaH1O5Hq2eNCYzDWn9zteDud6ek
         dSSNOzQICrZf8YwvGbyqw7158MKtoaBKqRlqJPWDXZBKJqmEZF6uua/teS67iXIcB6bC
         H9TQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfPxgiy9LQHyJRPDJLzQZTrekPySvg5UStXN/PsrVkFn0HOJIgi7czsu8kwUH8gSWqvEoCgdrmBpVOt+XK7mOv7ihCc86PmzbgrUwzLlPTWtaNaXDPvbQkLIHuQtunaY7EpeW6rXEXqX5w69V9GnmruaHi6JULbMmJDOKpHS+p/qpQYQ==
X-Gm-Message-State: AOJu0YwBmsTcgQfc+hub5e+I4WqE6ELGUgqE/bzgK8FKkaU26nnSfOqI
	adIdlaT2u29q4mL9ZEjH2MZpT6lT9wiu1sJ7V+tRPY2NxPChf2oN7XYLmUOLCF4IN4bZwx+wFyt
	gmE/2wKTjS8ZJBTtlfqAF2X0zFuYE7eOM82PAvroO
X-Google-Smtp-Source: AGHT+IGZce1Y576zJ8DZ6RkHn1CIoSO2clJFvmOPwUDfwbyCtZVtRbQZPXGFmP5/dN/iOW9bBbVRnAVHJ/bxCcCMz60=
X-Received: by 2002:a17:906:6c89:b0:a68:cc34:87d8 with SMTP id
 a640c23a62f3a-a69a0266a60mr78231866b.67.1717562991826; Tue, 04 Jun 2024
 21:49:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601092646.52139-1-joswang1221@gmail.com> <20240603130126.25758-1-joswang1221@gmail.com>
 <20240604000147.2xxkkp7efjsbr3i5@synopsys.com>
In-Reply-To: <20240604000147.2xxkkp7efjsbr3i5@synopsys.com>
From: joswang <joswang1221@gmail.com>
Date: Wed, 5 Jun 2024 12:49:41 +0800
Message-ID: <CAMtoTm2=RAgyaLB9rhUJiS_7S6+X+uKWFKNHi5zK3wmRr+cqzg@mail.gmail.com>
Subject: Re: [PATCH v2, 2/3] usb: dwc3: core: add p3p2tranok quirk
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "balbi@kernel.org" <balbi@kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, joswang <joswang@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 8:02=E2=80=AFAM Thinh Nguyen <Thinh.Nguyen@synopsys.=
com> wrote:
>
> On Mon, Jun 03, 2024, joswang wrote:
> > From: joswang <joswang@lenovo.com>
> >
> > In the case of enable hibernation, there is an issue with
>
> I assume this is for host mode since we currently don't handle
> hibernation in device mode (please confirm).
Yes, your consideration is correct, hibernation is only handled in host mod=
e
>
> > the DWC31 2.00a and earlier versions where the controller
> > link power state transition from P3/P3CPM/P4 to P2 may take
> > longer than expected, ultimately resulting in the hibernation
> > D3 entering time exceeding the expected 10ms.
>
> Can you provide more context where the 10ms requirement is from?
>
The P3/P3CPM/P4 to P2 power state change might take longer (maximum 10 ms).
If there is an impending D3 entry request, the controller does not
respond as long as the power state change is completed causing
unnecessary delays in D3 entry.
The above information is provided by your company.
STAR number 4236358
> >
> > Synopsys workaround:
> > If the PHY supports direct P3 to P2 transition, program
> > GUSB3PIPECTL.P3P2Tran0K=3D1.
> >
>
> Which STAR issue is this?
This is the solution provided by your company
STAR issue:  the DWC31 2.00a and earlier versions where the controller
link power state transition from P3/P3CPM/P4 to P2 may take longer
than expected.
>
> > Therefore, adding p3p2tranok quirk for workaround hibernation
> > D3 exceeded the expected entry time.
> >
> > Signed-off-by: joswang <joswang@lenovo.com>
> > ---
>
> Please provide change note for v1->v2 here (and the rest of the other
> patches).
>
> >  drivers/usb/dwc3/core.c | 5 +++++
> >  drivers/usb/dwc3/core.h | 4 ++++
> >  2 files changed, 9 insertions(+)
> >
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 7ee61a89520b..3a8fbc2d6b99 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -666,6 +666,9 @@ static int dwc3_ss_phy_setup(struct dwc3 *dwc, int =
index)
> >       if (dwc->dis_del_phy_power_chg_quirk)
> >               reg &=3D ~DWC3_GUSB3PIPECTL_DEPOCHANGE;
> >
> > +     if (dwc->p2p3tranok_quirk)
> > +             reg |=3D DWC3_GUSB3PIPECTL_P3P2TRANOK;
> > +
> >       dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(index), reg);
> >
> >       return 0;
> > @@ -1715,6 +1718,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
> >
> >       dwc->dis_split_quirk =3D device_property_read_bool(dev,
> >                               "snps,dis-split-quirk");
> > +     dwc->p2p3tranok_quirk =3D device_property_read_bool(dev,
> > +                             "snps,p2p3tranok-quirk");
> >
> >       dwc->lpm_nyet_threshold =3D lpm_nyet_threshold;
> >       dwc->tx_de_emphasis =3D tx_de_emphasis;
> > diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> > index 3781c736c1a1..2810dce8b42e 100644
> > --- a/drivers/usb/dwc3/core.h
> > +++ b/drivers/usb/dwc3/core.h
> > @@ -327,6 +327,7 @@
> >  #define DWC3_GUSB3PIPECTL_DEP1P2P3_EN        DWC3_GUSB3PIPECTL_DEP1P2P=
3(1)
> >  #define DWC3_GUSB3PIPECTL_DEPOCHANGE BIT(18)
> >  #define DWC3_GUSB3PIPECTL_SUSPHY     BIT(17)
> > +#define DWC3_GUSB3PIPECTL_P3P2TRANOK BIT(11)
> >  #define DWC3_GUSB3PIPECTL_LFPSFILT   BIT(9)
> >  #define DWC3_GUSB3PIPECTL_RX_DETOPOLL        BIT(8)
> >  #define DWC3_GUSB3PIPECTL_TX_DEEPH_MASK      DWC3_GUSB3PIPECTL_TX_DEEP=
H(3)
> > @@ -1132,6 +1133,8 @@ struct dwc3_scratchpad_array {
> >   *                   instances in park mode.
> >   * @parkmode_disable_hs_quirk: set if we need to disable all HishSpeed
> >   *                   instances in park mode.
> > + * @p2p3tranok_quirk: set if Controller transitions directly from phy
> > + *                   power state P2 to P3 or from state P3 to P2.
> >   * @gfladj_refclk_lpm_sel: set if we need to enable SOF/ITP counter
> >   *                          running based on ref_clk
> >   * @tx_de_emphasis_quirk: set if we enable Tx de-emphasis quirk
> > @@ -1361,6 +1364,7 @@ struct dwc3 {
> >       unsigned                ulpi_ext_vbus_drv:1;
> >       unsigned                parkmode_disable_ss_quirk:1;
> >       unsigned                parkmode_disable_hs_quirk:1;
> > +     unsigned                p2p3tranok_quirk:1;
> >       unsigned                gfladj_refclk_lpm_sel:1;
> >
> >       unsigned                tx_de_emphasis_quirk:1;
> > --
> > 2.17.1
> >
>
> Thanks,
> Thinh

