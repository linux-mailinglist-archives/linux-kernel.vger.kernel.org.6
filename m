Return-Path: <linux-kernel+bounces-435243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE909E74F6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8835018874A0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D9E20C499;
	Fri,  6 Dec 2024 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="42fbc/5q"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E2C206F05
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733500576; cv=none; b=e40bBcvHLi0mlcnPdQsNZiJCmT3DAtx8ZvcXXaaAZLchU38tAK2mCue/rReGm8HU/kci0Fr+DHqM/xcwA2D+tBq/V89hE30TwwJiGWijwu14YMEkR5SA3HofqmWenqZwoT373G7FwQyt5uoMaw1H1Y3fNYfXjJV8p+OGRfc6VbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733500576; c=relaxed/simple;
	bh=HiRM9JCXoPNEMuQmDgPmwpM+IFO+Ml8AHljm1CLjQw0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TGy0wQvjktjg3xoonFETUa1WNHqyg6QAa2WTcqocUle7yHvY+V7bi2jr4TLEAC+04+lk5B2dmdvM5MKqOXFnnY7uiq9LDE/98TkHqGSCwVz8BVGD2BoLwJNsKFk+C2BHSvDPwTbBMKhG0WKa+yPu1czq77Vv0xR4GHDAPrGbaXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=42fbc/5q; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d0d4a2da4dso3617399a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 07:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1733500572; x=1734105372; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhXG7usYN1Ndp7KrExGMRuLhz9e4x8sMn6Z7NQ1u10E=;
        b=42fbc/5qlLGJUg79O+blBo/u341Y48NLRBrg2VHTutSGPbhN4OcFx8W18R1Mfj8wJg
         AM1BhGMwgqeeM4Ft3XMC0mqmeIq+2WkhgZjyjZkPSI+b8/RRzijjpoQs5DbwI9nc9j1p
         n0e3dzV/QXFY/YcziU15pnrUVMJcf3kM8h9zYuG/R/VYLoCGYL4MLtgby+NhIoQEVKQG
         KoknmcC7OljJsRTuZqPf0nPmTnQq9kxlnVKaTRI68TdFUTm4sUfuCvEVVzUTB5E1NFZ+
         6TfqnI5x1MJiN1IZE4SruVr69HcoTwzw9531cvd/nh65ay75f1HJ5THPhWR8xzfhzoJL
         e3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733500572; x=1734105372;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fhXG7usYN1Ndp7KrExGMRuLhz9e4x8sMn6Z7NQ1u10E=;
        b=cmRymEtJISldJmbrOh3F2PMxGnSFWu7rESObcyMLyIT7InsUB4y3f3LWSaWiP0v5pD
         +f00HIyEzPCTp2YW8L4NAs0lnKWbOMJp7iqbm1vRTLfj7cADycnHNZTi4azW3kdpFBac
         dwE1u9FebNPra/znp7XFxET3nfr9CEr/DdLVO5e/9NrTXJDHY0rv0dEcRze9e3fVRYJM
         U/UZmEzRULlV5Mn1W4uBkqfBkQ9CApwOMBYivE8EmdPG0s9bA2Dbe/6IU5EMdyNjAAPi
         QlpAYd+2R/QRLhKMFh5Mvwf10pt9i3dBd/n2/PxaDNOcUoFGW7/P4GAUtZtUuqA08zEu
         9D2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWlqn9VJFucf/v/C7megnNeEiF9VEXBWXoWOqqdIgphrumQww7kSwgcZvnyqUp5yZh/55dJk9VZmsS1FcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxktY3NMHM4wQgB5oEmV4sL6PvjtDOEUIZNgyx5gDMkvQyPXscY
	omX6GFvvA4P7+yEaBPNZubLSP96QF5lPAL65JSMPgYFb4jmPRVrQ3f3HBin70Rs=
X-Gm-Gg: ASbGncvJwtA7DxfSY9oS+EWdq9PGXXNSw5+NE4zIodtboniXKZvPbBjOStqmYgShqLa
	0s1Tp+SWAZPtNUqgXL4Der+E9wMggfEsvcU4aCZ1oDc3HspIDE5OW7GFG0Z7gjKiixs2umZv4FE
	7HkR6b2tOzhx213Oxwg7ZEcUxeuqVwHjC/0k9MTWe/9tky/Rilefo8Y+i0jwIJaFtC0ACC8Z0l8
	GuII0OrCzmyQw/vZfIysEbQy5Nkj1AjLWDcd+Vd3UReaC/cO7nJzE9o9rmqyk7pcU3J8hhV/NuR
	F26v3q6nWKqttfI5/B52ytqy6yvRA0CQO+7GBIPCxZEVWhohdVvnR/E6neVj4g==
X-Google-Smtp-Source: AGHT+IH3JbFPMFTV/3kFiyKdRIaHb2mLz54BeVoJjzVAmHboemNCWABvF8tJd2pSZsnQF9LYk/+aug==
X-Received: by 2002:a05:6402:51cb:b0:5d0:8359:7a49 with SMTP id 4fb4d7f45d1cf-5d3be46563amr4160654a12.0.1733500572121;
        Fri, 06 Dec 2024 07:56:12 -0800 (PST)
Received: from localhost (2a02-8388-6584-6400-d322-7350-96d2-429d.cable.dynamic.v6.surfer.at. [2a02:8388:6584:6400:d322:7350:96d2:429d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa62601b5d2sm260347966b.93.2024.12.06.07.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 07:56:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Dec 2024 16:56:11 +0100
Message-Id: <D64QO0GGTG1H.1XNALA48Y0LX4@fairphone.com>
Cc: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH PATCH RFT 16/19] arm64: dts: qcom: sm6350: Fix MPSS
 memory length
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Bjorn
 Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Vinod Koul" <vkoul@kernel.org>, "Dmitry Baryshkov"
 <dmitry.baryshkov@linaro.org>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Abel Vesa" <abel.vesa@linaro.org>, "Sibi
 Sankar" <quic_sibis@quicinc.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20241206-dts-qcom-cdsp-mpss-base-address-v1-0-2f349e4d5a63@linaro.org> <20241206-dts-qcom-cdsp-mpss-base-address-v1-16-2f349e4d5a63@linaro.org>
In-Reply-To: <20241206-dts-qcom-cdsp-mpss-base-address-v1-16-2f349e4d5a63@linaro.org>

On Fri Dec 6, 2024 at 4:32 PM CET, Krzysztof Kozlowski wrote:
> The address space in MPSS/Modem PAS (Peripheral Authentication Service)
> remoteproc node should point to the QDSP PUB address space
> (QDSP6...SS_PUB) which has a length of 0x10000.  Value of 0x4040 was
> copied from older DTS, but it grew since then.
>
> This should have no functional impact on Linux users, because PAS loader
> does not use this address space at all.

Like with adsp, I can't verify this information, but with this change
modem is still starting up as expected:

Tested-by: Luca Weiss <luca.weiss@fairphone.com>

>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/q=
com/sm6350.dtsi
> index 3df506c2745ea27f956ef7d7a4b5fbaf6285c428..64b9602c912c970b49f57e7f2=
b3d557c44717d38 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> @@ -1503,7 +1503,7 @@ gpucc: clock-controller@3d90000 {
> =20
>  		mpss: remoteproc@4080000 {
>  			compatible =3D "qcom,sm6350-mpss-pas";
> -			reg =3D <0x0 0x04080000 0x0 0x4040>;
> +			reg =3D <0x0 0x04080000 0x0 0x10000>;
> =20
>  			interrupts-extended =3D <&intc GIC_SPI 136 IRQ_TYPE_EDGE_RISING>,
>  					      <&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,


