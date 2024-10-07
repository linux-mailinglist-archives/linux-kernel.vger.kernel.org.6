Return-Path: <linux-kernel+bounces-352909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD14A992602
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BF3D1F211B4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F9317DFFC;
	Mon,  7 Oct 2024 07:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="4PaxJ7qN"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE8613698F
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 07:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728285764; cv=none; b=Cle7OAtk32wENvYAEk4dHmDPTMAsLRvUnovj8mp8G+y9751ifFM6b0NE83GcGTanNF6HoYQTtK89jDJxfKxwgmsDVR8aVXZvRdQHNoF/lb51HX3O6mNZZo55gMVWmCgKY2JOioG5lwRkEcMJUq5917whIanflwq47x8bCzTy3gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728285764; c=relaxed/simple;
	bh=VRhCSxB82zRgJ5Jc9R6APsaMUcT5xYkusYPJb3Kj6Rw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=LqYryfd5sjlygI7SBGqoeZb6EWx5JuFcNR6TYcvfPzuKi/3EHMyPwFBhVeQMbOLQvTkrE6WFv737H5kjTDOukx4cweaolqGHoYc07dLBsShPGh+tTAGHZsFf3YrPdRUshbkvoypjC7uOD8YtwGmjjB77Ifbp5sUGOtbZ3t0BJzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=4PaxJ7qN; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53997328633so5022514e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 00:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1728285759; x=1728890559; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGDFou5w81V8vNIthRLYUbvVA2UvQAoXivmHVJDlqts=;
        b=4PaxJ7qNacuej9raqAA0S7PyFRfBaJ/xW61+H1s9lgDiBdtgq9EVirupFCjyFssR7f
         PYUP4YqsL3iP87ryq4Q/hqZfBAjm3sg7GhymT/J+AicWBHtzSSMur89GP48CtYJgweYu
         cMTYoPnd9EEBn3MiCoF4Sst1Vgj6D6O9ZcPduOH94dpFgCgNDsgEa4SWp9F7rVVfEaK8
         SqN1e7VdVJ2MYoDBwVVaz9nXShDXtIpxbx0agty+MUiVxYuuD+E+8/ALBlowkVq4dhgK
         t4sSACz+76HdR7S8TfgeVzGJWMHOqCLQqFg1G0k3XU3W2Rtvoc3e0PFzhHff7USiwCaJ
         mBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728285759; x=1728890559;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KGDFou5w81V8vNIthRLYUbvVA2UvQAoXivmHVJDlqts=;
        b=PErI/pFPGpguY3oFO69Od8Rs/Hlh/M3vvie2Y9/zExUY2hYjdm+7j1J/rrjCIObV5/
         +v6ID/eACfJz3w1WQ8iYBaGeBnNIXn0y2PD6HqYJpNo1XuXXZ3acMsvnfdFXsRnbwB2Q
         oGrSb9981xwbpIH9lX1WkKQ2ppiQAOYh30EWe4rDXKRhtfBKHdKGec547CaEW4DXRLd2
         s7jiSneqtwgM3TV5S5RRrcJ/M4pskdHcRmSNKO6rEeTCW1OY1BA0xCoqWqH32nEVE6AF
         bzGTppDygAId3TsfbmIN9u/yqYTndl69VGkn5/h5DzVDCwRI2X5Y7pGOKW442lCGtTKo
         cvPg==
X-Forwarded-Encrypted: i=1; AJvYcCVL10UTGp9anCOF+y8zWdEQO9bCgkyqWjvJcxIraI4enHes2hL/iEHFvCWXHrK0kabrfLHLnlJWdzaruko=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTPAYwtYOkZoFCJivcE2II7rwfAjEST4I11Afsc3s2Ey+v3oHN
	4Fjwei5AOY74jr5jS74zeaf9ha3JB1/w+O6p660+H3XMq82s6pB1f3Bk+fcsAJ0=
X-Google-Smtp-Source: AGHT+IETrWp2FMBMqSx4kT/r8D9xrjJKO5+QKNg0Ixl/LPKyO0lrb0nqZ9TfnKHQkNi8T+L+jiq05A==
X-Received: by 2002:a05:6512:1094:b0:539:9720:99dc with SMTP id 2adb3069b0e04-539ab9cf404mr6204001e87.46.1728285758987;
        Mon, 07 Oct 2024 00:22:38 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a994cea5a6fsm173493866b.224.2024.10.07.00.22.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 00:22:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Oct 2024 09:22:38 +0200
Message-Id: <D4PE64JTYDCL.3MC81CYK49TI0@fairphone.com>
Cc: "Bjorn Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: qcm6490-fairphone-fp5: Add thermistor
 for UFS/RAM
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20241002-fp5-ufs-therm-v1-1-1d2d8c1f08b5@fairphone.com>
 <fshhw6lknar4z36rc2sjjcgkiixpp7hak7gq3j373mjvbokax3@7s7kmzlmtjal>
In-Reply-To: <fshhw6lknar4z36rc2sjjcgkiixpp7hak7gq3j373mjvbokax3@7s7kmzlmtjal>

On Sun Oct 6, 2024 at 10:26 PM CEST, Dmitry Baryshkov wrote:
> On Wed, Oct 02, 2024 at 03:01:08PM GMT, Luca Weiss wrote:
> > Configure the ADC and thermal zone for the thermistor next to the
> > UFS+RAM chip which is connected to GPIO_12 of PM7250B. It is used to
> > measure the temperature of that area of the PCB.
> >=20
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > ---
> >  arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 40 ++++++++++++++=
++++++++
> >  1 file changed, 40 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/=
arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> > index 8ab30c01712e0b7c0cc1b403e0fe01650315b9e2..fdc62f1b1c5a398abaa7181=
8fdf2858fdc445d28 100644
> > --- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> > +++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> > @@ -207,6 +207,20 @@ active-config0 {
> >  			};
> >  		};
> > =20
> > +		mem-thermal {
> > +			polling-delay-passive =3D <0>;
> > +
> > +			thermal-sensors =3D <&pm7250b_adc_tm 2>;
> > +
> > +			trips {
> > +				active-config0 {
> > +					temperature =3D <125000>;
> > +					hysteresis =3D <1000>;
> > +					type =3D "passive";
>
> Is it really just "passive"? Especially with no cooling devices it
> sounds more like "critical". LGTM otherwise.

Hi Dmitry,

To be clear, I'm adding the thermal zones now as a first step so that
that they are declared and that they show up in /sys.

This is for sure not the complete thermal configuration. Most other
thermal zones in this dts also currently have 125 degC "passive" trip
point, which I'd hope the device would never ever reach.

Regards
Luca

>
> > +				};
> > +			};
> > +		};
> > +
> >  		pm8008-thermal {
> >  			polling-delay-passive =3D <100>;
> >  			thermal-sensors =3D <&pm8008>;


