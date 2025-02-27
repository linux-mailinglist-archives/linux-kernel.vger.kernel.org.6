Return-Path: <linux-kernel+bounces-535755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E077FA476C1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB4ED7A4425
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9E9223711;
	Thu, 27 Feb 2025 07:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="MqL0PS9N"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F8F2236FC
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740642134; cv=none; b=O8l47I4fVS6en9fWar2rm6wfp2WvwO5Vi3Qb3ge8qU4U0FcguWghjsCE6oKHqWy74RyFiLV+YvhG2N8hk2E3rHmBy8fNAVMqpJnRrYx/Wz3y39Vm/fga3N6rv1sFC/MTVkDR5xVgKHFj8Dro90V+vJ0EkBRBRWqMo9sU7FJRoQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740642134; c=relaxed/simple;
	bh=hOWdYrxNiuPN+XNM7jJtHqXLqHZiONyk2eJf35zleLQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GPDslEqXRhBcg87iPd0/yK6zn1m2Rp/aJXjClwT/uSVF4IoNQRx2kpXhm9M3XyB+US826b0U5vBwjuglRUf1JCCf2PkiGbQwWazLZsKPG8RIYJU3Zmh/NhXfes0OZraHynBGzBE7fG/M0o83jkpr9K99X0cfmLNDOni3YoM7itQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=MqL0PS9N; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso4045355e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 23:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1740642130; x=1741246930; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDstNabKa+U0RFMr+z3tANP7Vpq5gfUk2k27kasy3M0=;
        b=MqL0PS9NAInaTWnWSw7cHRNWcriR0cflcIq2/WF0wQrPby2EiMBOywObtHbpAuQfBx
         D8Wenx9alUaIUJ2vpZB/+mcuqA+o0UkrwxLcK6ImBng1qEuzymEgX0wJ5HCchYQbsqav
         DznWcnMWq2E7KuITZAStKu3mcCsJp47bjhYAqbD5OR75oIJswJoRxOBBYoeZJGB6zzXF
         Ksi4Vt97tMysPaGPnP++Lfi4vWz5VEwV7Gy9gi2fYaVyQuKyiCuM1Z+3hvDdm/I5hWAK
         b0Um9R0jl5vFdol5oav0NVHltb1AfxHhUY5jtbLHZiKHGAm9Xv0TuGNVa8u6q+iU6DtG
         ixwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740642130; x=1741246930;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vDstNabKa+U0RFMr+z3tANP7Vpq5gfUk2k27kasy3M0=;
        b=JPppZt9G/2+wWluRBkHfyX2FzJi7rWxruTnVt/7x8Vma9Md8sQu3q7CeBSvTeqDKMm
         /d3Vuk/yoW4ZtTiH8x+sEbw+eMznCCwV5vNjWTOMzaxOhXvaIRIZyDfFHw2pHngsqtPa
         QPt2y63hyOgvNdKF6CsCQblau7JEZd45OqyD+loOzEEa3AGiKXLu9ahJ6WueXLdH2o3L
         wffbJDjZWFTEnIkM5xtT1rmbWfQ05PIR/x7mDIfVOAykCXhuWnnDdrdvux4NmFCr9r4/
         BBJXDLtc/uOU02gXNDD8ET15L1CnS3Yho9HAGcdGFXmpx0+wCL7g3x7sOQylaZoooiHb
         xdxw==
X-Forwarded-Encrypted: i=1; AJvYcCUf04ip3vwrptDuvBXJtpkh8Vfo7l4XguqP+L8QKytU4Q3uyHU/Gsq3pV1FSDg3YZ11rq7L2yreGfcq+fI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE14mYPCsVofOQQYoANHTWAc5NIpSiDelDwZdjE4q/WYb7TiOk
	36zPkUKNz0EMMb6aGJjJg6dRBvQUVXiRXPY9Wd5+FjZY3burQjTzErEbkGnLoMI=
X-Gm-Gg: ASbGncuuKc4PF9n+GoG++smz6RoPKNy8zVikwPMef/PwnYYgmG94Hqv2ZrqQKAsgcCt
	5EDE7C/TR1x/nFhttBFgiIOx1OBht7o2bOSfRmKYNMKWrMKIIsSCf9WMlXpAOod3mfk++NKAMwo
	JXxSQK+2ldDv/j/2B0teNtddv6Nqof6xGARH3C3s1N8peq+DSr+Zvu7ceCXTqXrv+OnaWrNiNwg
	A9TOoEamVrLlg/QHPwqVrIszUW3NdGeHsiTELcMVsy5BuyBBHov01kmIq5wClxNE6My8XWp+4Na
	u2ukquQmJn2Nc0XrR+WOvRBvzhA0eeNz3R2yrJykPg9DAO0Xupe9ArFp6arUTfoSmgCEWOU=
X-Google-Smtp-Source: AGHT+IEjgF0COFVrxkgx63jJMahBS/fzpXpuAZ0WbHEMTNr8DH0vZgYR2D9bi1jTvh7DSZQR0NvF4A==
X-Received: by 2002:a05:600c:468e:b0:439:9828:c44b with SMTP id 5b1f17b1804b1-43ab0f3ccddmr106690235e9.14.1740642130144;
        Wed, 26 Feb 2025 23:42:10 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba52b947sm45759585e9.2.2025.02.26.23.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 23:42:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Feb 2025 08:42:06 +0100
Message-Id: <D8324XX78W5E.273JA9U5U4NV8@fairphone.com>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] Fairphone 5 DisplayPort over USB-C support
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, <cros-qcom-dts-watchers@chromium.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250226-fp5-pmic-glink-dp-v1-0-e6661d38652c@fairphone.com>
 <e5290e59-0022-4eba-abce-a11928d76d3a@oss.qualcomm.com>
In-Reply-To: <e5290e59-0022-4eba-abce-a11928d76d3a@oss.qualcomm.com>

On Wed Feb 26, 2025 at 6:44 PM CET, Konrad Dybcio wrote:
> On 26.02.2025 3:10 PM, Luca Weiss wrote:
>> This series adds all the necessary bits to enable DisplayPort-out over
>> USB-C on Fairphone 5.
>>=20
>> There's currently a dt validation error with this, not quite sure how to
>> resolve this:
>>=20
>>   arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dtb: typec-mux@42: port=
:endpoint: Unevaluated properties are not allowed ('data-lanes' was unexpec=
ted)
>>           from schema $id: http://devicetree.org/schemas/usb/fcs,fsa4480=
.yaml#
>>=20
>> See also this mail plus replies:
>> * https://lore.kernel.org/linux-arm-msm/D0H3VE6RLM2I.MK2NT1P9N02O@fairph=
one.com/
>>=20
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>> Luca Weiss (3):
>>       arm64: dts: qcom: qcm6490-fairphone-fp5: Add PTN36502 redriver
>>       arm64: dts: qcom: qcm6490-fairphone-fp5: Add OCP96011 audio switch
>>       arm64: dts: qcom: qcm6490-fairphone-fp5: Hook up DisplayPort over =
USB-C
>>=20
>>  arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 110 ++++++++++++++=
++++++-
>>  arch/arm64/boot/dts/qcom/sc7280.dtsi               |   2 +
>>  2 files changed, 108 insertions(+), 4 deletions(-)
>> ---
>> base-commit: 417c2d4ed67b729abea7dc73d7fb2153b7154d31
>
> I don't see this commit in -next, master, or qcom/, this series fails
> to apply atop next-20250225

Maybe I was a bit fast in sending this series, the 2 patches this
depends on have been merged into qcom tree yesterday, I've sent this
series based on latest linux-next + arm64-for-6.15 merged in.

https://web.git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/log/?h=
=3Darm64-for-6.15

Regards
Luca


>
> Konrad


