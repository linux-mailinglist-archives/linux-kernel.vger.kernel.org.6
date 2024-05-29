Return-Path: <linux-kernel+bounces-193500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 591028D2D16
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C42351F229AC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 06:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976A1163A9B;
	Wed, 29 May 2024 06:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="wvgLXS7p"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD1C15EFB9
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 06:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716963526; cv=none; b=GpbujSTsDiJi+5PGxq3RBq2QE8badGG3rXRCa4sm2VPx+qCvLggDQs3A5Sc6gY7VQYfaTculx5PoLYP6spwPC0KvWjwpJ8eb3ioAeRKNydH2YARpzWm1Ynt131nlHx6SC7Q0sTiQ2796hSHactdN6zCHVZg8cL3ETthUgMFsPQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716963526; c=relaxed/simple;
	bh=td+A5mMkrhdvg9ElSzQdaHWmnHQqfG3xEYFSntb3ivs=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=php6A9X+//RDHp6MKpmZYEONFyzxShgZqxD5fzULN2xTnAFEog3mUTRWHlI2xpiq5v1Bawft6thdzB6ByAL1NU4cisRcgKmhQStNvvrmiNLk68VFQCtDHlMEOjLnENA+MPJ92/WQidyrmsqG4RwI6ZC3SMXqevOvMcZc7T3zS1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=wvgLXS7p; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59cc765c29so84238966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 23:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1716963522; x=1717568322; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5o98irvL1PvcmMP2g/CoSXINiWvruSSImbYO4qwby8=;
        b=wvgLXS7pAUfty21u7wWUO6QH5bSCBphX1OAVLcg+LHw3oEYmkTRWUcvpTOKvv/6Ha5
         /Wdko+S9m3RL8dNKlZZdZc06Q6gaCoUr4YgRzvaNvMNQNUaXM6CxRqHJGKZe4H3Si9QK
         LZvoSYoMhFMXAWxS4p8N+rpzhkLJqTHwG98ZQ21YFlnkehyYrgl2uXbtahhtULWrDz8J
         msByiEUcM/14L1BN1zTyHvgNiPZgAvUY+TJfevs5rBLXPqIO/w8tyaGqNf5CK96kqfdH
         lZpVn7tcDIcCTLampjsiahaw+ctxVdKotrcCjKki5Qt6OiRjGAXlzxM7rmYgY5NG+S8C
         NayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716963522; x=1717568322;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b5o98irvL1PvcmMP2g/CoSXINiWvruSSImbYO4qwby8=;
        b=GJQvG+79lX6528lmXUpFe+yVaVRmdmlAxBTJT5R0asBdQL6n2rxU0ef+PCl4pr+yQN
         UOXmvmYuPn7LiD6n4+MgDe6oC+PKdBL4zALxsAbMS7/5vuJP/yIPdObuqbjBjKxHnd75
         7oUBnV2l9mOEJ75gH144cKS45Hxf3gypWqRXraRe4UtwXhdNyRsUNbDXBTTIsz/dvfBQ
         vNfK7xiQ5G9WKfJU3zPRr6wmMlzsi1LacpazvXNl3MY0T/33vt5IHisUJzdKNOKacnsY
         xxCGXcvXGMwFjI+ytaQSmSR384M4P1b17hw7UU7Xn4txOI/GvOE1vdw52DR9MWf/uK03
         UWyw==
X-Forwarded-Encrypted: i=1; AJvYcCVmdyJ4U4Hd3YiSZ07P449KQZEZatoWvosxqfuKURjL1Gzb1VaJFr+Si0vhS6BiR88iEy7p5CZgRDHDrsLNYhSJIuT8neAHfs/rUZ3V
X-Gm-Message-State: AOJu0Yzxj6JzFakgjP+pWcT3mWu8lVz2X/hKao4fLEuSna65PmNuPcg/
	20ptg1vw00Q+aQc+petsGS7TfLaME4XA1loRaThawzK29LqGyL0y0WQKWMYyE7I=
X-Google-Smtp-Source: AGHT+IG1oXccLJqlT99AbIl0tXdj+h1O8dL6G8y8/9eKbxzPQr8rGYbOgwG7VHPYBxA5kpGfbl/kHg==
X-Received: by 2002:a17:906:314e:b0:a59:c319:f1dc with SMTP id a640c23a62f3a-a62642daa92mr969475866b.4.1716963522482;
        Tue, 28 May 2024 23:18:42 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6555bc091asm7799266b.138.2024.05.28.23.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 23:18:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 May 2024 08:18:41 +0200
Message-Id: <D1LWRSO8RFAI.1PQ450TISFN2D@fairphone.com>
To: "Bjorn Andersson" <andersson@kernel.org>
Cc: <cros-qcom-dts-watchers@chromium.org>, "Konrad Dybcio"
 <konrad.dybcio@linaro.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Srinivasa Rao Mandadapu" <quic_srivasam@quicinc.com>, "Mohammad Rafi
 Shaik" <quic_mohs@quicinc.com>, <~postmarketos/upstreaming@lists.sr.ht>,
 <phone-devel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH DNM 2/2] arm64: dts: qcom: qcm6490-fairphone-fp5: Add
 DisplayPort sound support
From: "Luca Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.17.0
References: <20240510-sc7280-apr-v1-0-e9eabda05f85@fairphone.com>
 <20240510-sc7280-apr-v1-2-e9eabda05f85@fairphone.com>
 <hqwrfe2tcb6vlxybmn52k3j2xrxbt3vw5rqwudindbhj3s3nez@obkr3ayos6gm>
In-Reply-To: <hqwrfe2tcb6vlxybmn52k3j2xrxbt3vw5rqwudindbhj3s3nez@obkr3ayos6gm>

On Tue May 28, 2024 at 11:35 PM CEST, Bjorn Andersson wrote:
> On Fri, May 10, 2024 at 02:27:09PM GMT, Luca Weiss wrote:
> > Add the required nodes for sound playback via a connected external
> > display (DisplayPort over USB-C).
> >=20
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > ---
> > Depends on a bunch of patches upstream doing bringup of Display (DSI),
> > DisplayPort, GPU, and then finally audio could land. But we're blocked
> > on DPU 1:1:1 topology for all of that unfortunately.
> >=20
> > And also machine driver for sound just exists a bit hackily.
>
> Thanks for sharing this, Luca. Can you please resubmit this once it's
> ready to be merged, so that I don't need to keep track of it?

Definitely, though I don't expect it to be soon unfortunately, maybe you
can ask your colleagues though to fix that DPU 1:1:1 topology ;)

>
> Regards,
> Bjorn
>
> > ---
> >  arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 36 ++++++++++++++=
++++++++
> >  1 file changed, 36 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/=
arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> > index 05bbf1da5cb8..2bbbcaeff95e 100644
> > --- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> > +++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> > @@ -14,6 +14,8 @@
> >  #include <dt-bindings/leds/common.h>
> >  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> >  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> > +#include <dt-bindings/sound/qcom,q6afe.h>
> > +#include <dt-bindings/sound/qcom,q6asm.h>
> >  #include "sc7280.dtsi"
> >  #include "pm7250b.dtsi"
> >  #include "pm7325.dtsi"
> > @@ -774,6 +776,12 @@ &pon_resin {
> >  	status =3D "okay";
> >  };
> > =20
> > +&q6afedai {
> > +	dai@104 {
> > +		reg =3D <DISPLAY_PORT_RX>;
> > +	};
> > +};
> > +
> >  &qup_spi13_cs {
> >  	drive-strength =3D <6>;
> >  	bias-disable;
> > @@ -847,6 +855,34 @@ &sdhc_2 {
> >  	status =3D "okay";
> >  };
> > =20
> > +&sound {
> > +	compatible =3D "fairphone,fp5-sndcard";
> > +	model =3D "Fairphone 5";
> > +
> > +	mm1-dai-link {
> > +		link-name =3D "MultiMedia1";
> > +		cpu {
> > +			sound-dai =3D <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA1>;
> > +		};
> > +	};
> > +
> > +	displayport-rx-dai-link {
> > +		link-name =3D "DisplayPort Playback";
> > +
> > +		cpu {
> > +			sound-dai =3D <&q6afedai DISPLAY_PORT_RX>;
> > +		};
> > +
> > +		platform {
> > +			sound-dai =3D <&q6routing>;
> > +		};
> > +
> > +		codec {
> > +			sound-dai =3D <&mdss_dp>;
> > +		};
> > +	};
> > +};
> > +
> >  &spi13 {
> >  	status =3D "okay";
> > =20
> >=20
> > --=20
> > 2.45.0
> >=20


