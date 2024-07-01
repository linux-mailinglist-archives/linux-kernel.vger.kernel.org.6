Return-Path: <linux-kernel+bounces-235991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC79491DC22
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 771C028217E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AD912C479;
	Mon,  1 Jul 2024 10:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="OjB4fFmy"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFCF127B62
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 10:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719828812; cv=none; b=ZcNNc6th1Dyx0ZWY6ReObM2N0rIVREG4Kmye6Bsq5cZoWNq167xev7HTPaGjG5LEpItmeTxBD4+lc2bKnWEyY+wlyGpCS6hgyU9iHPzcAa82SHh1KLA58F8A4TXpQCuoc4x/a3DDkOA63MXupAzi/oIcvVf+eX+00hlFnnLcI9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719828812; c=relaxed/simple;
	bh=wbQXOeAsXHy4G+RPUD1L4HvHY3UjpcFzd4LWh5TzHPk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=XhBGKDj/iZEsGNFtma4rNs6Bd2TSTj2G8Sy1IvBAAvNPwdeFh31r3jrzONMlCRXUyV+VSbBFYTEEpy9EbASyFBZEMcIMRrnUxhLW8xrxBZvoNbYi+zuN3ygGqkYBtrIghZ9BHlfYMMWRQz31hsmJe9OVNYAQAafhWxuRmcQlsAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=OjB4fFmy; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57d251b5fccso74938a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 03:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1719828809; x=1720433609; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27HxPtMT+Pe7iuNMl9/1XfWreBshEKC9NaTAcn2bpUE=;
        b=OjB4fFmyDjkRaDVzRkat9MstEfgZVDsLnCVzQASOpbiTMuaNuFg6CrwPsMJNIrR//Z
         lw29irsO8swaHOXwBhYOKsWl348MvZ+w4mN4s+zYitJU3bNjeO3bCWS2EoiHIK2uzMJu
         AYIcOMaIz3xOtojdvrpWKjZmShs2P/sROipsVeaHJz0f5zvafNktFbctxPA6DSECVvHO
         WHfrBFW/IYrceBT42LaDDkAGYZvti1p/as78ABTUzJhW++kLAvTrjdMr9lZbea+MQKG+
         K7i/PuXHoLN85weWB1NDsz3jSJ/BuyGXqcER8nRs8JKekAb3CbjAffUARUNIbqLN66UW
         U8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719828809; x=1720433609;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=27HxPtMT+Pe7iuNMl9/1XfWreBshEKC9NaTAcn2bpUE=;
        b=Do/7n66+zllX6kZOffg5LxM9vnkPlLmX0Oc/hku+OsFW+kSTZjILgCWGb13tE/7WOx
         LIS9A41Uwx+Nj5Qa6S5BCg2Q1+8hNv06PHLZmXjuaTbU9pjSlwa40e8sBIrBn5YHncf+
         liJSryBeRxL5soXke+57LzUak6J41+IWx+THKMdu81WsoqoKB2EVPT8+kxbH/muU4fQD
         TapbErlSrEuS3/PoG66tS8sr8GzM7PsEei37BmiQMgG2hyY7Wpy7+UGWq1nFDpOnOLnM
         OaJh8ogS2KDtVLHmQv0D0WD9GM/1m6+LrD3Lls7uFJknjJTQXtsFQTFlEb78wfc+ISSR
         V9Fw==
X-Forwarded-Encrypted: i=1; AJvYcCWiPEiZTZvRr8WXVF7qcxUlvfsUMXIXufyQqdVRvBl0yrVaw8PaiM4ejxo/D7+skKQhdIbdxBiNbgOkdxa7biPQs9EFSJu0Wcn7m/7t
X-Gm-Message-State: AOJu0Yx/xJ9zxCEZgmRFXgrZrPr+LpPJkUzHIiMM684eiWopAdo23UId
	GBqDcaD89hqG5chdqcvVeI1CUE0nHLAFyzsbwvFMj+OnxM4w+NoJxsmDDggrdQI=
X-Google-Smtp-Source: AGHT+IHj+BcVm87b41Z+G83EUAjJgrmIUWRa5gN38WLv/Sf6cUjrQOUekcEFjk4rw0lBU4DrEAitPg==
X-Received: by 2002:a05:6402:1941:b0:57d:456:e838 with SMTP id 4fb4d7f45d1cf-587a0b037ebmr3541191a12.31.1719828808730;
        Mon, 01 Jul 2024 03:13:28 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5861324feb7sm4244777a12.37.2024.07.01.03.13.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 03:13:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jul 2024 12:13:28 +0200
Message-Id: <D2E4FJAD0UZ7.ZDYOYNZ8QOJA@fairphone.com>
Cc: "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
 <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: qrb4210-rb2: Correct PMI632 VBUS
 voltage
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Dang Huynh" <danct12@riseup.net>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konrad.dybcio@linaro.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>
X-Mailer: aerc 0.17.0-0-g6ea74eb30457
References: <20240701-qrd4210rb2-vbus-volt-v1-1-5c06f8358436@riseup.net>
In-Reply-To: <20240701-qrd4210rb2-vbus-volt-v1-1-5c06f8358436@riseup.net>

On Mon Jul 1, 2024 at 12:09 PM CEST, Dang Huynh wrote:
> According to downstream sources, PMI632 maximum VBUS voltage is
> 1 volt.

Everywhere (also subject): s/volt/ampere/

Voltage for USB is 5V

Regards
Luca

>
> Taken from msm-4.19 (631561973a034e46ccacd0e53ef65d13a40d87a4)
> Line 685-687 in drivers/power/supply/qcom/qpnp-smb5.c
>
> Signed-off-by: Dang Huynh <danct12@riseup.net>
> ---
> In previous patch series, there's a suggestion to correct
> PMI632's VBUS voltage.
>
> Unfortunately it didn't make it and probably forgotten.
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


