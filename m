Return-Path: <linux-kernel+bounces-423831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1D19DAD5B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B00AB21427
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 18:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4915613B2A2;
	Wed, 27 Nov 2024 18:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oiKJsSbH"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31EF1448E6
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 18:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732733364; cv=none; b=kA1HfebJkymFXTWLXeDea0UWEg0/ZCNXflLyg17ARMRp7BfeG0qkV/H1R9VzAm2b6lvb1dp/pOZBn9O81zbz7SXAvANSQ4rMFqIAf22XJOC7OGag8wIr5hYgB/ldotE69GK30xu0Ss0uA/TT+2PpMN7MhlWAeQjKru3uuzxZVKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732733364; c=relaxed/simple;
	bh=sjoyiG2Hp2mqoPO+fxRY3EiUOYbL8A159VrQnsMQDMc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=e7sgcWyDn7DrWgjhZgHxjw8uc5X7EhAo968wHAU/nOSMIhB+61k8OK7AzrDCMRf+HQAqnDXXn/Q5x+RmWmkupiqYqh5kKdmJa+jNhLD5v5jrU9bl6TfEYGhYShfxRT+XE3g9rShD2unW65rzQziZIpaXg6W/BpOzbAoCnCoyFNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oiKJsSbH; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53de771c5ebso3838784e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 10:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732733361; x=1733338161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sjoyiG2Hp2mqoPO+fxRY3EiUOYbL8A159VrQnsMQDMc=;
        b=oiKJsSbHk8orAOWZJnxuZrGBtiebLC9PpNlRs6R9lvwQC12I3y6LKCYDDJpIt3gk8c
         pqVo++P4mYR4w5KUAi4FivHHRr4ZT6yqQ4sbcenrESSA5mEQamh/0kz7Xc2DOTQ8KKUv
         bDEj6e1MZ/MGowLqpLb+3zCFywrW3V5XDSYEniEhX0yQdUDstKIyhOSaxkV3vVqGFQWJ
         VuLbapmhmbGmZrSHw2Jzp3uXqUkjDfWjtiTxwAmDLKHqwA9io63X2GR9rtGuVAgqdQn7
         Sqn1DxAHJdPxNorHEJT6peMPk8hAKasb/pu/jTKjwhWTxU4rd8VXBN9ey1uro/FIDh6l
         9TAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732733361; x=1733338161;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sjoyiG2Hp2mqoPO+fxRY3EiUOYbL8A159VrQnsMQDMc=;
        b=pqiBTVH7PcnzzFzBLeXEQadKtt6LoZCkqmCOyS/bcDRqsuTpWkvMPMifYgsoiBYbcG
         Om27MIduPfqN8qB/h2yPDMc61Uv/kNI8TAXN/P4tQnpxZ96n6ZD8ARNJcrneGEUqkPbc
         9x/NyWMxP44TdG67+nuA6s4IMeRNG0GH+Ph0AQEcEF/uSTCyQveo2XkQ8Ri7rC5QmoZP
         9mphgJpKm7ocQ+8SxuVC9Heq9xdmi9Jqx1NWLhfkqBV2DXshkuNTT+RgNZAQgYH7pdDv
         2d86SoUOg7yxEIaByyiK/EC7T2o56dcFxd/MYLzuvjEa6AhgpqnSJMroHFQYUOPayA4o
         I/iQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdM3/VFp4VYcnST1ssPRCn35qxOzILX4sDFEtv+immy9g3iPjSQUMeU0AnjsRu8H9/8RPkux4SuPbQhng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2hrRpYFNA3vcys8HT6+tPowE0O70z8dfzDyPq/tmdaDkJhFoT
	NEtEt6K1lUO1XsWvJVpV4t68ibzdL74B0/kmcynC5z2cW4IVOH9edZ9MzdUKvRU=
X-Gm-Gg: ASbGnct0XGY8QG2ce+OsHTPs75E2HsxB1blCa81yb/rr2oZFqUrH5CKV4d2XGV3ro5g
	XRQU5HBUwvtTR84gOsPJ53D6NAIN9MosBsGRWYjgfenIWBf+iWqrrGPUs8Fug195haDG0wWM6EY
	stYonGX79h3NU4dj4qPm+thyuUKu8K6CU/YDIEyBgeE7yMx44rvyGqewg64ueWG+6Y1lulOKk/j
	NBkN5Fjy1UTVcceh+3alGGaxBEHJ2kqXoOEM27v23iSXdcudNnSWG+KCyT41Z5N9MmWhmpNt8Z4
	6iIixvt3cbP8/uU=
X-Google-Smtp-Source: AGHT+IEmUi+ANH8PnjVcprPLiJ6h5cts7vEPzcxELANUAmqnDFEgXsap5gI2kW5PmEmhDomAWBibaw==
X-Received: by 2002:a05:6512:3b25:b0:53d:ed0d:1d14 with SMTP id 2adb3069b0e04-53df00d1ae2mr3023434e87.16.1732733360922;
        Wed, 27 Nov 2024 10:49:20 -0800 (PST)
Received: from [127.0.0.1] (85-76-116-93-nat.elisa-mobile.fi. [85.76.116.93])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd24812besm2308319e87.121.2024.11.27.10.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 10:49:19 -0800 (PST)
Date: Wed, 27 Nov 2024 20:49:16 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>
CC: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
 Georgi Djakov <djakov@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Odelu Kukatla <quic_okukatla@quicinc.com>,
 Mike Tipton <quic_mdtipton@quicinc.com>,
 Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_V6_3/4=5D_dt-bindings=3A_interconnec?=
 =?US-ASCII?Q?t=3A_Add_generic_compatible_qcom=2Cepss-l3-perf?=
User-Agent: Thunderbird for Android
In-Reply-To: <0ba0f4af-5075-4bb1-a7f6-815ef95bbda7@kernel.org>
References: <20241125174511.45-1-quic_rlaggysh@quicinc.com> <20241125174511.45-4-quic_rlaggysh@quicinc.com> <20241127142304.GA3443205-robh@kernel.org> <zchtx32wtii2mzy2pp4lp4gdaim7w56kih7jcqes4tyhu24r3n@dagazlsdgdcv> <0ba0f4af-5075-4bb1-a7f6-815ef95bbda7@kernel.org>
Message-ID: <538761B6-5C8D-4600-AB9E-687F91B855FF@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27 November 2024 20:27:27 EET, Krzysztof Kozlowski <krzk@kernel=2Eorg> w=
rote:
>On 27/11/2024 17:53, Dmitry Baryshkov wrote:
>> On Wed, Nov 27, 2024 at 08:23:04AM -0600, Rob Herring wrote:
>>> On Mon, Nov 25, 2024 at 05:45:10PM +0000, Raviteja Laggyshetty wrote:
>>>> EPSS instance on sc7280, sm8250 SoCs, use PERF_STATE register instead=
 of
>>>> REG_L3_VOTE to scale L3 clocks, hence adding a new generic compatible
>>>> "qcom,epss-l3-perf" for these targets=2E
>>>
>>> Is this a h/w difference from prior blocks or you just want to use B=
=20
>>> instead of A while the h/w has both A and B? The latter sounds like=20
>>> driver policy=2E
>>>
>>> It is also an ABI break for s/w that didn't understand=20
>>> qcom,epss-l3-perf=2E
>>=20
>> As the bindings keep old compatible strings in addition to the new
>> qcom,epss-l3-perf, where is the ABI break? Old SW will use old entries,
>> newer can use either of those=2E
>No, this change drops qcom,epss-l3 and adds new fallback=2E How old
>software can work in such case? It's broken=2E

Oh, I see=2E We had a platform-specific overrides for those two=2E Then I =
think we should completely drop the new qcom,epss-l3-perf idea and follow t=
he sm8250 / sc7280 example=2E This means compatible =3D "qcom,sa8775p-perf"=
, "qcom,epss-l3"=2E=20


>
>Best regards,
>Krzysztof


