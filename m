Return-Path: <linux-kernel+bounces-442335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E389EDB12
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 00:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D393168A1E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAD31F239A;
	Wed, 11 Dec 2024 23:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MWbAuH7t"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A5C17838C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 23:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733959122; cv=none; b=MznM4V0nzi8ct9lOoB2vu3rz4lccV9Emcvck4kIZgx63gmcAv3S6ul5wWWrXN6sBcRiJbqPqFqvQBVWG/9FbbVO72z4YWX7byUWo8H5cJ6uXlvW3HVosr8zEN/iaPIUL0hjnqcJjurzmfiBncEyacQ4hE4QPGQkairGooR5GcHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733959122; c=relaxed/simple;
	bh=Vw0Rd6A8CkPce9mRpc49aoMHEVtyn7wqJ1+SvBkbGsU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=heb48NNgRwyooeikEGVkTpRx5pfGJoFuZ9/azlJSrC8sOv6Vd6EVLvFsOZ+joWif42n9NDw/ziXFov4ZH7ishLHMSFd3Tseu9dNl5z2QwpTzaL0f/6ck7h8bqLlG8ap81f4u1z4n+ClzECuCRSgLlgptQUfK5kgaJBYQ9RZLyHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MWbAuH7t; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4361e89b6daso7868215e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733959119; x=1734563919; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rRHUZTWrw/enXmUg5HJUc+kp5QUA2QAYg8TadYFylJU=;
        b=MWbAuH7ta3ztE4lKmo1WnN7lPC2b8xNu5vZtA4i+UH0PjfVviZz3NA4W4JifwCVm6F
         /2XLeSkAc4cj7+Gal2NjL0Qu8Vi+mdTgoSSM3DSPOe8hsl6g2xFrQ06yBxj/U6DXtjc+
         3AHGvrsoSKQpRlwqWgPmmKOUAi3cpeEj4QAzPcM2/dYYgl2j061tfDsMXVVDLG/E4L1H
         JvuMpf0p7xz7Y6wbi/8q6nJuapyPvaFKxYoM/wUG9PvZ7FxlifEBkPE86g7SzczeOUUA
         SvaaAWUxG9D/1+DhRggYpiIzY53s28VkGsZgbTpAHottubI055oPD7pWiHv9Q8rLfyRm
         sDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733959119; x=1734563919;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rRHUZTWrw/enXmUg5HJUc+kp5QUA2QAYg8TadYFylJU=;
        b=lmu4WkxgprfrdDtDzNcY4sLX3zuYxRhqNNxKGMfvaJCnVwKguS7WIkcfaIFr1Htbsm
         TwqkAYJqpYJENn2ZQyenNeGbhCjNgA70jnLw+202zsi2CRFag4dYOqNhDUSTeSVEoaoL
         EzlM+wFqCQiuxKh7dwS3+yF8QLYXQu7N0MsuGnT2QAe1JLfZOxekQCn+GNhJKkUjJOqG
         A7y8BF6nnyAnbfZbI3SkSTfoNr0wCfuNIrtYWmLMzfs0MUUP6UVJdDw6BWyDEBD+uZT2
         UxArtcdHoov3qE6ZEGVHM/WtHQxgGRYNPuKJiqozEh7iYs/QBRJraMn1bKRuirTjxHpP
         AurQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFtCjVT/I47K0qEFEeUtmnCFxhs+DaAIg5zBVbjoUWeLGWJ/Jgi1XCCn1bCauv9aKbOCPUHREJpq+vhGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0jK/Xiz3xqNWGILv20D1wIbg2EK41rNJwe5Lx0mlSGxrLgao+
	rrZJQb+YBSJudqEjGdilPisS7+OK7FP+w5K4JKA1YSxcLmYKI7BoBX0yefCCAzY=
X-Gm-Gg: ASbGncuIEJBpB0nYzfR0dNIDPqhBbxRZLuZh3OxuTfIk3OQeUZB+L5Kayfxa0IfhaWS
	NtEHgOS+EoH80vci6shO/0I4+gkOAd2j3GhKF8kBvALHjR1pHAEpeaY5Mz9vbaI21D+M718udIY
	u7qfQh+WZi7q2CwUT3CYsQh4ptKaj9VcjNrG9ISZCLaQVv6yE7apKsY8SDW7Aab3gFvSeGZRpvf
	EFeLIoxwf2iDQQM866q8KMTuW16J1m5zmDQ0UikFL7EiNWO+gYVKvHa
X-Google-Smtp-Source: AGHT+IHm4dUrixa2oAB3OPqhfx0NrTgK9S/ClAQ/+/CAsZLq77t7Elt6vMKKQ3p5VLAN/iyTfeDFTg==
X-Received: by 2002:a05:600c:3acf:b0:434:a802:e99a with SMTP id 5b1f17b1804b1-4361c346253mr39230375e9.4.1733959118933;
        Wed, 11 Dec 2024 15:18:38 -0800 (PST)
Received: from localhost ([2.222.231.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52c0be4sm273741395e9.28.2024.12.11.15.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 15:18:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Dec 2024 23:18:37 +0000
Message-Id: <D6997HYLIQ6L.3FN664SYBLTXM@linaro.org>
Cc: <tiwai@suse.com>, <lgirdwood@gmail.com>, <perex@perex.cz>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <dmitry.baryshkov@linaro.org>, <linux-sound@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 08/10] arm64: dts: qcom: qrb4210-rb2: enable wsa881x
 amplifier
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, <broonie@kernel.org>,
 <konradybcio@kernel.org>, <andersson@kernel.org>,
 <srinivas.kandagatla@linaro.org>
X-Mailer: aerc 0.18.2
References: <20241101053154.497550-1-alexey.klimov@linaro.org>
 <20241101053154.497550-9-alexey.klimov@linaro.org>
 <8078589d-d724-422e-a5f0-f5b6c67deafe@oss.qualcomm.com>
In-Reply-To: <8078589d-d724-422e-a5f0-f5b6c67deafe@oss.qualcomm.com>

On Sat Nov 2, 2024 at 9:30 AM GMT, Konrad Dybcio wrote:
> On 1.11.2024 6:31 AM, Alexey Klimov wrote:
> > One WSA881X amplifier is connected on QRB4210 RB2 board
> > hence only mono speaker is supported. This amplifier is set
> > to work in analog mode only. Also add required powerdown
> > pins/gpios.
> >=20
> > Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 45 ++++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot=
/dts/qcom/qrb4210-rb2.dts
> > index fc71f5930688..76b9ae1b0ebc 100644
> > --- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> > +++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> > @@ -63,6 +63,16 @@ hdmi_con: endpoint {
> >  		};
> >  	};
> > =20
> > +	i2c0_gpio: i2c0 {
> > +		compatible =3D "i2c-gpio";
> > +
> > +		sda-gpios =3D <&tlmm 4 GPIO_ACTIVE_HIGH>;
> > +		scl-gpios =3D <&tlmm 5 GPIO_ACTIVE_HIGH>;
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> > +		status =3D "disabled";
>
> Does it not work with &i2c1?

Actually it does work with i2c1 (non-gpio version).
I am going to use that and will see how it behaves.

Thanks!

Best regards,
Alexey


