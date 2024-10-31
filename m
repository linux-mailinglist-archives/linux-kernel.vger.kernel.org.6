Return-Path: <linux-kernel+bounces-391408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8529B8643
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 23:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13A61B21FEE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13401D130B;
	Thu, 31 Oct 2024 22:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BIQkmEMx"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B159D1CF5E2
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 22:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730414890; cv=none; b=SkRtWM2zl4nLBatohOq23TAF5mx6i2pTZ7Hu7XecerXojxrAEa+H0LnxEcP+vLMCvdFMlDZXtJf0NPtMvUbMDXOGW0aCio7tgVbKr0DXKD0jgPdStWXuw4Orf5ds8kNjrCHlcLljE7ffuWLU7k69n1CunKN5zJsvSxv9mnKo26E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730414890; c=relaxed/simple;
	bh=dKICqskpU+lDAaVFQjimpvgZuImNCCQ5RSIvqwp71xE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=uPW2XjoJoCJgG7swHPBZ4HKw0b50wTWEyYQn/9AKaBx4h23dZS3W+dWICtSfZ6WCPtvpyaG1P6wxr/107XsIbnl5YyrEOFBuVm7Qv9y0H4eOThy52aXvCI6q6UyOqi55NlLJ9YW/W9l3jFG0pftSFTFF1gThUx9n9biqk3N4s80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BIQkmEMx; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43158625112so12029265e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730414881; x=1731019681; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTGe9PwYvoojfRJpUZgUhAxbJHxiXthHeHJW83hgHu8=;
        b=BIQkmEMxnpj+5iaC/CJK6UU8d4cJ8C2yB2NauBlOmp03k5MYdgr0yGjGgJ4m9NuWES
         GUT8TX45unHLjBQeFEYD/WamKwJd2vFET+aei9cV9AIr1HXEhTPjpREZg5bfC6HQXCg6
         MY6r1yA2I8lmH5qLl+FL22iPSe9e9O/wzCm3UrBm545gl/m//I39pVbxaGmEsE9f1xCl
         EQbE5dZ20ks+BeeMnDM6uUmCVUPCARw9OZVt6BnRlc8HaIsIUJZpC93MlhPEbV5mN/gg
         HBo3lFlQpn1cENHD2ssErDLurTFB3v/qqwOwOwNQWPSc9JIynweHYAEqadAms0CojruC
         KH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730414881; x=1731019681;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eTGe9PwYvoojfRJpUZgUhAxbJHxiXthHeHJW83hgHu8=;
        b=RMcIaW9vVizbfw6ypvEqQUt2Oua8pWre8OOIYMRoNFvHc0PunhCFU9xht/5oKCt8vA
         mkX2lCO+xWlVrLZD5IdcsL/ysFnfapIIMntbjmeaGc3gt0iuVe6UJk3u4oKtXMUug9Fq
         eLw8iGw5/MK5W7HfadV+qIrJbVio4bS8Rc1c84trpFA2aT2DcxOXt5gJ4JZQVf/083gs
         22NFUHY8fSn2toaQbBfZQ9bhC8rcCt0DtzfAEHC7oDUFtAaG5LShK4h9aXl9OVr4YqSl
         V3nG4/CAWhGFv9NXlc5Ynv09nZ8hWSKYpBwooZfAlkhOrkrjrGHOlyCUqBa6Ba6+fljq
         Qprw==
X-Forwarded-Encrypted: i=1; AJvYcCVaDgNnlI305eQolOMUbpYuScwib/vrv5Xf7NI4gaRSq6+2iVNX1tsHjhCJSj38OarDzdSvm2YG9gge9oc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp7nL2q+X1H4QNIPqEvA+7Rx+D4p7nEsji5jsan4inAFoUh/jN
	H4pavvtfmTK4opQl3hlbII36vHUb9VzEh5KZY5tLiEPZekhai3eLIcVzsXuMfuQ=
X-Google-Smtp-Source: AGHT+IEmzHNzE7hvDqBmKYm1F0qTKl7W/SJiQtEF8C1xj5fDoK069HdbTE+fuTkxJTbnplMq+3q1PA==
X-Received: by 2002:a05:600c:1d21:b0:431:518a:683b with SMTP id 5b1f17b1804b1-43283255a45mr13080605e9.18.1730414880954;
        Thu, 31 Oct 2024 15:48:00 -0700 (PDT)
Received: from localhost ([2.222.231.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d439esm3327963f8f.44.2024.10.31.15.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 15:47:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 31 Oct 2024 22:47:58 +0000
Message-Id: <D5ACVOXF0KJK.1ZUDOAK4X9EP8@linaro.org>
Cc: <lgirdwood@gmail.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
 <perex@perex.cz>, <tiwai@suse.com>, <linux-arm-msm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <dmitry.baryshkov@linaro.org>,
 <krzysztof.kozlowski@linaro.org>, <caleb.connolly@linaro.org>,
 <linux-kernel@vger.kernel.org>, <a39.skl@gmail.com>
Subject: Re: [PATCH v3 5/5] arm64: dts: qcom: qrb4210-rb2: add HDMI audio
 playback support
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>,
 <linux-sound@vger.kernel.org>, <srinivas.kandagatla@linaro.org>,
 <broonie@kernel.org>
X-Mailer: aerc 0.18.2
References: <20241018025452.1362293-1-alexey.klimov@linaro.org>
 <20241018025452.1362293-6-alexey.klimov@linaro.org>
 <33736e2e-7ac2-4ec1-9d83-eb8360942bbb@oss.qualcomm.com>
In-Reply-To: <33736e2e-7ac2-4ec1-9d83-eb8360942bbb@oss.qualcomm.com>

On Fri Oct 25, 2024 at 8:09 PM BST, Konrad Dybcio wrote:
> On 18.10.2024 4:54 AM, Alexey Klimov wrote:
> > Add sound node and dsp-related piece to enable HDMI audio
> > playback support on Qualcomm QRB4210 RB2 board. That is the
> > only sound output supported for now.
> >=20
> > The audio playback is verified using the following commands:
> >=20
> > amixer -c0 cset iface=3DMIXER,name=3D'SEC_MI2S_RX Audio Mixer MultiMedi=
a1' 1
> > aplay -D hw:0,0 /usr/share/sounds/alsa/Front_Center.wav
> >=20
> > Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 55 ++++++++++++++++++++++++
> >  1 file changed, 55 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot=
/dts/qcom/qrb4210-rb2.dts
> > index 1888d99d398b..5f671b9c8fb9 100644
> > --- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> > +++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> > @@ -6,6 +6,8 @@
> >  /dts-v1/;
> > =20
> >  #include <dt-bindings/leds/common.h>
> > +#include <dt-bindings/sound/qcom,q6afe.h>
> > +#include <dt-bindings/sound/qcom,q6asm.h>
> >  #include <dt-bindings/usb/pd.h>
> >  #include "sm4250.dtsi"
> >  #include "pm6125.dtsi"
> > @@ -103,6 +105,51 @@ led-wlan {
> >  		};
> >  	};
> > =20
> > +	sound {
> > +		compatible =3D "qcom,qrb4210-rb2-sndcard";
> > +		pinctrl-0 =3D <&lpi_i2s2_active>;
> > +		pinctrl-names =3D "default";
> > +		model =3D "Qualcomm-RB2-WSA8815-Speakers-DMIC0";
> > +		audio-routing =3D "MM_DL1",  "MultiMedia1 Playback",
> > +				"MM_DL2",  "MultiMedia2 Playback";
>
> I'm seeing a lot of double spaces in this patch
>
> > +
> > +		mm1-dai-link {
> > +			link-name =3D "MultiMedia1";
> > +			cpu {
>
> Please add a newline between the subnode
>
> Looks nice otherwise

Thanks for noticing this! I'll update it and resend.
I put one space between audio-routing widgets, not sure if even one
is needed though, maybe there should be no space at all.

Best regards,
Alexey

