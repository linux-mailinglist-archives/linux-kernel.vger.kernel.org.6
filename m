Return-Path: <linux-kernel+bounces-206257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 985BE900668
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 16:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1922B281DF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49938198A24;
	Fri,  7 Jun 2024 14:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOJddF1b"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC411DFC5;
	Fri,  7 Jun 2024 14:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770269; cv=none; b=KDiRU3Kaz+/I76t1KdELIAu8p206UbrNBgXscle5JvyvHHHp97TyGMZZsGA++lBWJw0X/DKxS5/nR4pnoUDXer6JjwtexazxyAvUbCZlWICk9ExB6MSYQZZcvIyMlhP8C6UhCHwEHY/lxzMy0Tux311RpKH0SR72SoiiNgOiD/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770269; c=relaxed/simple;
	bh=hp/cGjF++wivVrBHhIAfNPrYCnmzaM2UH+s1Nk+FShQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E6bfi+AwYsHHwKFkrhVirFDbF0eHYLVdExsqFMwVgiHJz7mtsvf9JCR4HRZ2Nz6esT8cVVde9CC2E4ETe3pQ/B8V11403gdTDVJSa4gGO96tYmB+HkO3fPuPCaiZ+JTeW9tEZUkaKHioK1amHlrAD25MBPFjTaW+oE4R88C5Vts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOJddF1b; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57a677d3d79so6181522a12.1;
        Fri, 07 Jun 2024 07:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717770266; x=1718375066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9chcR0C/4WpGgrP/nkGNRsJs9D6tCay4d9wcTqhpek=;
        b=YOJddF1biIUXgSqMXfIunnX8sqk4JkrgW1lMK5JP4t6l9F+L/jc549tiB+1kPifsRr
         uhtc5gdBUNkrX+7lTPLfNWDti31Lwj1Zurcb6oZV0a3vviQaUx934R3kMd9XUFcgXiso
         DM4J01mN0HHgdik6Jut80GnPhcKsgs8YsD5C2EvI28qlzJc7d1TnUMVxCWyE4KG6XglM
         GgR+pQ0lFOLI1Z1zYCNtiETDNOkqDMBBOKWRV+taoAAxJdUXvImHdIGD71CRnleaxkZx
         mGvszocHif5kVDqhOjXpHTu5oTGCJw81nglezzo98iH+2TinpJefFHlU543K+3gBR1pK
         Wlzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717770266; x=1718375066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9chcR0C/4WpGgrP/nkGNRsJs9D6tCay4d9wcTqhpek=;
        b=F2fKFWCie2O7u5Yu3AZUfnCyABVoFGO3RgVLHYceVePZwcqP3BM7DruqgeTcvmIs94
         DFy+s/sTkBsSJeRITrfKTtMlqugDxhF3/ufej9nk5LcEER4rhJHEFjE7CnqerZGmF8bY
         tqh7MYpMcMaKP65+3EnkRgopWCwef3YBOZrV7hPa5Hw94nGVTH6jgNxP7d+Y3kO5AU4W
         2N6DOdcAI1sJEXGwE86x9Y6kCfGNDjFOzgEGz4PAlczree3OHZcE+umhip1BY9Xc01fU
         6jUCkp91Et3CcuYxF34OxiT6obJKLIQNz/Dtw+jMf8KwirCSkDhdOZ4Y6A9kRmYbDm44
         rgNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXE/HdtT9iOQq4bmRM3y+QwrAxnmBJWJFd1rF7UwaQm5gmXgp8/AfOpLKBRkdD4YXuCj9g1hlAiRvccM1qWHt3vaz9vbAoVskk8RWbmvXvE1deuEmqCbj93qAkwepKTO1vwrlMY4RqB60grW7Wpl5ImS1y8Nkl7E88mPe0g28lzMWHL1A==
X-Gm-Message-State: AOJu0YzT71h8r5EF4ZA9grQ1qzY6ECJd5J3J1VOHG7uqKoSwH0FJcZ8k
	xT4onaoBRdMLaLz23/vSuKFaKkMgrHlmuRab8N4OJYq+yC02EWdHxdO5wfcn6m10HhVmvUMWqcl
	pcu+G8LoTmYPcZw9i6/N0dzJupR5LuWdnVQGJ0Q==
X-Google-Smtp-Source: AGHT+IHazATLc9iZSxsS4MHtBMrdKO/1iTLsyl6W+quG/kmslgwVnMLCJ9ogH/flBgGREsYBB2+YNH3SWfN5Z+EjyRU=
X-Received: by 2002:a17:906:6889:b0:a59:a3ad:c3f6 with SMTP id
 a640c23a62f3a-a6cb9348584mr231427566b.3.1717770265952; Fri, 07 Jun 2024
 07:24:25 -0700 (PDT)
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
Date: Fri, 7 Jun 2024 22:24:15 +0800
Message-ID: <CAMtoTm1PMYr2jvo1iY6J34O3fPj=wJ5WHn-T8mrj+3TjcF5POg@mail.gmail.com>
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
>
> > the DWC31 2.00a and earlier versions where the controller
> > link power state transition from P3/P3CPM/P4 to P2 may take
> > longer than expected, ultimately resulting in the hibernation
> > D3 entering time exceeding the expected 10ms.
>
> Can you provide more context where the 10ms requirement is from?
>
> >
> > Synopsys workaround:
> > If the PHY supports direct P3 to P2 transition, program
> > GUSB3PIPECTL.P3P2Tran0K=3D1.
> >
>
> Which STAR issue is this?
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

Difference between V2 and V1: This patch has no changes, only the
"dt-bindings: usb: dwc3: Add snps,p2p3tranok quirk" patch is added.

Thanks
Jos Wang

