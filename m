Return-Path: <linux-kernel+bounces-236045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A05D91DCCB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 053FB2829C5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28F31339B1;
	Mon,  1 Jul 2024 10:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="DqQdcwRq"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9F815D5CC
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 10:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829716; cv=none; b=RacjuNQcv8hEpU8b8UyXeHWeMu7w42PIwxEXar2mDTw/CYrU3RqxOMzqcCCr/8cuSBbAaEQLaWvYfKCd2AZhOmmvZNmxJ7JH6A+JzGcBi/SLe/kcdhEeIVAZLa+94lztDpsofwLWkOkzvhSBcRhJ6O5bc5rRMMelV1zHWZLrV6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829716; c=relaxed/simple;
	bh=whwSt1dw1W4v39hDUemEnAGBam55003cQAughFau/xs=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=IiCkYzeTilkWTjNUi3PkaiNtVGubRNVJqviPuRySS41H4ThPO6Hzdz4VLXG4OpAXoqK3fGQARuXWTjcH075sUb5u9t2heNp3efxt/7J1oRFbPLFo+mOpTebwkpz+/KS1owgo/XszElgP/fQjmYoZBligB3xf8VDPkxwRaPeFf54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=DqQdcwRq; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57d07673185so60332a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 03:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1719829713; x=1720434513; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0t9wDVAneCoqR1L6zC6P8I5fHbJSVdv4J4WVgEUPrA=;
        b=DqQdcwRqEP9VD+hO4HcDK8iiLA0klPdNOgOYdfB+Aex7QkVYLbr7/R5mCgVvy56UKi
         frVailCuTLdRPyFh7IjZd/dlaujvguOycJXL1uchQvuC49uV8SRxPtzBSJVofvOB/Czv
         +4m45+AYqjuO6o9nAIwibfmv+ye7HUWM/u0Rjbnjv8pgWrw+/QusnXXe9wdNgxTprWy5
         AdCAG1Hno7Exph5KCo/yfvyaXryipsvGQn6Yxofk8BY7R9Y2M2e+MgTBAo3Vp4I7HUGC
         DCQa9oOh6VZHgBz7nAb2CIE17M3AMe1FgevMGSQREV+XZoWAtkltVmWc65DfUAPZSLZt
         1TXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719829713; x=1720434513;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G0t9wDVAneCoqR1L6zC6P8I5fHbJSVdv4J4WVgEUPrA=;
        b=lVcwzZrF7cepf4qQy2k+ilJMYFy6Vfw8hKxmxPaBJXuAKtM6sS3cVr7Ne/We1qhJq7
         5n8jW5D7EzAtfVYacwSW5lwZvacpY4Jd0Yb2FGe/X0TIZvW4Tb9bLzyEnI2BF2z9zFRX
         JLMcRgXvsXcXmVQnZY8TTrhQA91U8gcEEIxJGtFNjghJ9cQDt06Vheg8BXpQfhqZzKee
         kMBDgdzbbxl1SPpACOPA03Atk38s0gRMi6ZkCEB+9/voCysLEJMEg105+iF1qwZo06Wi
         dicPWD4ep57hczYbNdumSKusTy27gFKjmCloZToM5V7uVbEcm+qp2GbH5pNdItpNkhhk
         pOoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVPPicVWVeS2QZ4HCb+8wBCAgD5nKWqUiDW0AbxwxMUUwsbczd+zQd9OMfAv6hJNpRQiY7UeqI3HXsXaNHkR3yU+cVj1cRHDpZQdVB
X-Gm-Message-State: AOJu0YzqY7udcu2Y30UK+esxvF9IeHAQXCM01utt+zsLwedUA2FSg8Bw
	Nrkdkz55U6AgrQMNkY0ygk1K30h/Xh8ngamIW/IbbeHNWdhOkbNLlm29go10D5k=
X-Google-Smtp-Source: AGHT+IEJKT3Q3jDkIA2zjsFxld8zqgyuod2jji5hNuOlEYmpBrVmAXGndjtNhh2RXHiW/4ytTo9uqw==
X-Received: by 2002:a05:6402:d05:b0:57a:858d:20ca with SMTP id 4fb4d7f45d1cf-587a0a0e925mr3247556a12.28.1719829712897;
        Mon, 01 Jul 2024 03:28:32 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58614f3d4c4sm4242861a12.87.2024.07.01.03.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 03:28:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jul 2024 12:28:32 +0200
Message-Id: <D2E4R2MLD3ZY.S3QF3GPPFQK0@fairphone.com>
To: "Dang Huynh" <danct12@riseup.net>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konrad.dybcio@linaro.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>
Cc: "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
 <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: qcom: qrb4210-rb2: Correct PMI632 VBUS
 ampere
From: "Luca Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.17.0-0-g6ea74eb30457
References: <20240701-qrd4210rb2-vbus-volt-v2-1-b7bcd2a78c8b@riseup.net>
In-Reply-To: <20240701-qrd4210rb2-vbus-volt-v2-1-b7bcd2a78c8b@riseup.net>

On Mon Jul 1, 2024 at 12:24 PM CEST, Dang Huynh wrote:
> According to downstream sources, PMI632 maximum VBUS ampere is
> 1A.
>
> Taken from msm-4.19 (631561973a034e46ccacd0e53ef65d13a40d87a4)
> Line 685-687 in drivers/power/supply/qcom/qpnp-smb5.c
>
> Signed-off-by: Dang Huynh <danct12@riseup.net>

Fixes: a06a2f12f9e2 ("arm64: dts: qcom: qrb4210-rb2: enable USB-C port hand=
ling")
Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>

> ---
> In previous patch series, there's a suggestion to correct
> PMI632's VBUS ampere.
>
> Unfortunately it didn't make it and probably forgotten.

Could've included a link for easier context:
https://lore.kernel.org/linux-arm-msm/CYMDEAJZ0TJK.K31XZB3E9QOG@fairphone.c=
om/

>
> ----
> Changes in v2:
> - Fixed typo (voltage -> ampere)
> - Link to v1: https://lore.kernel.org/r/20240701-qrd4210rb2-vbus-volt-v1-=
1-5c06f8358436@riseup.net
> ---
>  arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/d=
ts/qcom/qrb4210-rb2.dts
> index 1c7de7f2db79..1888d99d398b 100644
> --- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> +++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> @@ -305,7 +305,7 @@ pmi632_ss_in: endpoint {
> =20
>  &pmi632_vbus {
>  	regulator-min-microamp =3D <500000>;
> -	regulator-max-microamp =3D <3000000>;
> +	regulator-max-microamp =3D <1000000>;
>  	status =3D "okay";
>  };
> =20
>
> ---
> base-commit: 642a16ca7994a50d7de85715996a8ce171a5bdfb
> change-id: 20240701-qrd4210rb2-vbus-volt-822764c7cfca
>
> Best regards,


