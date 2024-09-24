Return-Path: <linux-kernel+bounces-337106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA94B98456F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 363E71F22715
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5AA1A4F27;
	Tue, 24 Sep 2024 12:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BKq/f+Hw"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246FD126C02
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179408; cv=none; b=WMauWp0qRPsfMAwk1+8cfRmPlt5FjSnUHyZCt77jo2NTc6XXIvYQf0tiG2RyyvlfEg6EzEwybjAuvE4sWbaqc6K6AIG4vE4eEfLJRE+Ekq3gzecE3rF5oT7xYC04E38/IjpN9aigu4kJS/eVSQoz1KNTdZTbMUWyYAE/ygy53qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179408; c=relaxed/simple;
	bh=BKuoLGhSemarSQqGyR3hGJxqIMBJJ+wv74GyrdjB4Qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f+3aiWl8EsjAX+r02dcgUK1zLOx7robhFT8T8OYyG+GVrnbxlIsptyiYW+0H10sMnYfBTBGuGW9+MVSdaYqA1hlBBKRSvnUXuEe+qxfaXZbk5UKlhPZ/oOHysGfRcX7hY2nn6iMauhdsXpHJxbRSGJxEgfnQOzEv1ISHb0IFkfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BKq/f+Hw; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6dbb24ee2ebso47903307b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 05:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727179405; x=1727784205; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1SexCe+KVJledInGZuUisJCoVV9rpz12HkhvcoEgjd4=;
        b=BKq/f+HwGvtFyY7EQjVFiTzaDzUCj6w3dx2ngo/P08D7j9IbGod42APaUaMMxBRlPf
         8gjCSwN1EHQHg+viHoZYlj9FMcmTVwwOw6kZ2GihMmc3VCEd9zGmJhpbZG4/iNwbl9sV
         Cl28QM+GfupCDCako29rQ9JbzUELq8DcwdCXPnElShHPUIUnvaR40QDoGpy4g3VKjU87
         UazFOppZyy5pPYPvKxcW51F1ReETOU6OR1LP/eeAlCCm18XaccM2hcdaidchuHT4NxE/
         6S+j8oaAd1uiEJM/oIEsL+Xg29LxP5YqFp046Lqx/5R0gTOR8eHlOjTDCXojvrYa6jbm
         Y+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727179405; x=1727784205;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1SexCe+KVJledInGZuUisJCoVV9rpz12HkhvcoEgjd4=;
        b=D4V/vrSfr3c8fd1hqKMaJeCWI7bTH/LomFnKSrarDJFB/8HWP5J0S0o9CSSi2YC6tg
         1LMiyTQE47MAJTQDFK4cM477WiWFty8EEk6AaEnlgsICaYAaYhY3z0IP80JtCRhadBJD
         OPnwVEI93owhxREn6fIYtv7zeF/ulvA77Y4Te+8WUOX+IHUDqf/min29JDE9pRUQ/Zy+
         LKlUizgnbJ7n/R3VmbyfZEU8UIr1FmHzjsqBLlEcjTRmVNJEjgg4rp18nhfmwVvqCyTL
         DcXQcZS+s/5rmMa28BgJlaWPHmNKl95x9q3RFQ/hOKqShvXM7JDi5opv0KxtGKUjrW7i
         wGmg==
X-Forwarded-Encrypted: i=1; AJvYcCWWYO/zMoqmomrChWsctizq5jJZSgDMcraHxL/nfCihYtLBdDdV/XEHzHpOR5xzVdbk3aiSfBJCWDSWIns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvd0Ic4LJ/Wr6xmOe+P40i0T0DFYYlkxcVPNJndMFER+S0vWbq
	M3ai8rAbo3DzVsedFcitv8JXXpfJPdeagq4rI1SO2jQyiKujUijUTFfF9s+P/rGWJr8O9hq5OSN
	LIE/fhyVkAJ91/WlDaOGauQsVmHb05K15e3scFQ==
X-Google-Smtp-Source: AGHT+IHD+QEFMSL2xtRxxA304IQqPTeFi2914vIHsfkaU8qMNFT9p8W8xdPZCGc+sB86DXrWl1vKLyrM0nKFsowI0Oc=
X-Received: by 2002:a05:690c:2507:b0:647:7782:421a with SMTP id
 00721157ae682-6dfef019bb1mr70848227b3.45.1727179405120; Tue, 24 Sep 2024
 05:03:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902-x1e80100-crd-dts-add-external-dp-support-v1-0-899c264c0eb7@linaro.org>
 <20240902-x1e80100-crd-dts-add-external-dp-support-v1-1-899c264c0eb7@linaro.org>
 <th2x3gtx56fr7zuhhleuj77eghfe7kgbfhok7ul5egez4iq5v2@qy5wy4hxpb5s> <ZvKdmhfxilFfOzmb@linaro.org>
In-Reply-To: <ZvKdmhfxilFfOzmb@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 24 Sep 2024 14:03:13 +0200
Message-ID: <CAA8EJpq1WwmJfZdW7e3EWEucHpnEYZJkFOek65YcadYwgXWyCg@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: qcom: x1e80100-crd: Enable external DP support
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johan Hovold <johan@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Trilok Soni <quic_tsoni@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Sept 2024 at 13:08, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> On 24-09-02 21:54:58, Dmitry Baryshkov wrote:
> > On Mon, Sep 02, 2024 at 06:01:35PM GMT, Abel Vesa wrote:
> > > The Qualcomm Snapdragon X Elite CRD board has 3 USB Type-C ports,
> > > all of them supporting external DP altmode. Between each QMP
> > > combo PHY and the corresponding Type-C port, sits one Parade PS8830
> > > retimer which handles both orientation and SBU muxing. Add nodes for
> > > each retimer, fix the graphs between connectors and the PHYs accordingly,
> > > add the voltage regulators needed by each retimer and then enable all
> > > 3 remaining DPUs.
> > >
> > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 414 +++++++++++++++++++++++++++++-
> > >  1 file changed, 408 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
> > > index 10b28d870f08..6dfc85eda354 100644
> > > --- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
> > > +++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
> >
> > [skipped]
> >
> >
> > > @@ -709,6 +861,163 @@ keyboard@3a {
> > >     };
> > >  };
> > >
> > > +&i2c1 {
> > > +   clock-frequency = <400000>;
> > > +
> > > +   status = "okay";
> > > +
> > > +   typec-mux@8 {
> > > +           compatible = "parade,ps8830";
> > > +           reg = <0x08>;
> > > +
> > > +           clocks = <&rpmhcc RPMH_RF_CLK5>;
> > > +           clock-names = "xo";
> > > +
> > > +           vdd15-supply = <&vreg_rtmr2_1p15>;
> > > +           vdd18-supply = <&vreg_rtmr2_1p8>;
> > > +           vdd33-supply = <&vreg_rtmr2_3p3>;
> > > +
> > > +           reset-gpios = <&tlmm 185 GPIO_ACTIVE_HIGH>;
> > > +
> > > +           orientation-switch;
> > > +           retimer-switch;
> >
> > Doesn't it need to listen to mode switching events? 4-lane DP vs
> > 2/2-lane DP + USB3 requires propagating of the altmode events to the QMP
> > PHY, see the original 4-lane series.
>
> The mode is passed through the retimer state as well, isn't it?

ack.

>
> >
> > > +
> > > +           ports {
> > > +                   #address-cells = <1>;
> > > +                   #size-cells = <0>;
> > > +
> > > +                   port@0 {
> > > +                           reg = <0>;
> > > +
> > > +                           retimer_ss2_ss_out: endpoint {
> > > +                                   remote-endpoint = <&pmic_glink_ss2_ss_in>;
> > > +                           };
> > > +                   };
> > > +
> > > +                   port@1 {
> > > +                           reg = <1>;
> > > +
> > > +                           retimer_ss2_ss_in: endpoint {
> > > +                                   remote-endpoint = <&usb_1_ss2_qmpphy_out>;
> > > +                           };
> > > +                   };
> > > +
> > > +                   port@2 {
> > > +                           reg = <2>;
> > > +
> > > +                           retimer_ss2_con_sbu_out: endpoint {
> > > +                                   remote-endpoint = <&pmic_glink_ss2_con_sbu_in>;
> > > +                           };
> > > +                   };
> > > +           };
> > > +   };
> > > +};
> > > +
> >
> >
> > > @@ -1164,7 +1566,7 @@ &usb_1_ss0_dwc3_hs {
> > >  };
> > >
> > >  &usb_1_ss0_qmpphy_out {
> > > -   remote-endpoint = <&pmic_glink_ss0_ss_in>;
> > > +   remote-endpoint = <&retimer_ss0_ss_in>;
> > >  };
> >
> > orientation-switch and mode-switch for the QMP PHY?
>
> orientation-switch is already in the SoC dtsi nodes.
>
> But the qmp phy doesn't currently support mode switching. Right?

Yeah, we didn't land that patchset :-(

>
> >
> > >
> > >  &usb_1_ss1_hsphy {
> > > @@ -1196,7 +1598,7 @@ &usb_1_ss1_dwc3_hs {
> > >  };
> > >
> > >  &usb_1_ss1_qmpphy_out {
> > > -   remote-endpoint = <&pmic_glink_ss1_ss_in>;
> > > +   remote-endpoint = <&retimer_ss1_ss_in>;
> > >  };
> > >
> > >  &usb_1_ss2_hsphy {
> > > @@ -1228,5 +1630,5 @@ &usb_1_ss2_dwc3_hs {
> > >  };
> > >
> > >  &usb_1_ss2_qmpphy_out {
> > > -   remote-endpoint = <&pmic_glink_ss2_ss_in>;
> > > +   remote-endpoint = <&retimer_ss2_ss_in>;
> > >  };
> > >
> > > --
> > > 2.34.1
> > >
> >
> > --
> > With best wishes
> > Dmitry
>
> Thanks for reviewing.
>
> Abel



-- 
With best wishes
Dmitry

