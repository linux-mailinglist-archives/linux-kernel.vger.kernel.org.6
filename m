Return-Path: <linux-kernel+bounces-436201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8F69E826C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 23:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10AB9281F6F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 22:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B3016A956;
	Sat,  7 Dec 2024 22:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VxQUEnyV"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B0F22C6CD
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 22:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733609273; cv=none; b=e1yXB1TvNM7iLNqSFs39qZyTfeQLC/1A3+j0172AFD0+8Q2j6dy9vlW84NPzujJNTCRBb3CC/dFWLef1OUvHfci8d/ePMTXhb6SIT2cZgcjEGstVQL73QqDAzuGIp9SSAK43s+GH7YjxcyVjWEoRkLqsDPdl+/cNWVc7IobbzDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733609273; c=relaxed/simple;
	bh=+bQHiNZ2m2WhrSw8sdxwTUuPMItd18DX+vXFIh54PpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jrndbxj0fuqm2JUo25oIw7Zeysk4sda9gOSw6r8TaSUyJdgFB5id/dFiSHLHR2qrpdcN3w0nsfWkUc7dPY1Lk7XBat/4fI//E4cEqVTpuTBUVnekX5R0m2sXdFm6zXMmoHHl6pS5nRV3GOVCoMOO/3wAndCwMW57RQgeMLAos2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VxQUEnyV; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-29e2a50586dso1956762fac.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 14:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733609271; x=1734214071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bQHiNZ2m2WhrSw8sdxwTUuPMItd18DX+vXFIh54PpI=;
        b=VxQUEnyVhStEzRe3BP2uro/RgtxpNqBGlNsTZDc6x4FQHtRZXiCkt1oKHGNPoO9SV7
         tP7vyVZSYdpdul3cKecu4J8wKSsFCcOfvgh8QCAI8+wTZBXzHwHGom0OZKzL5MYRJu28
         Inv6q37C2b70yFK0cVpsIPvLfcWRM8yP6eEOnzkN262XfknerypnzDAAUUrqPxtIg/KT
         VV7m90ZxAIAK/YLlr6OnPPp91xhU8CkTFoq8fUxPRC2MlGSn01+2RpujSM4d7l3J2bYJ
         NETMik+xlTscTBeAapWuuMmoTZ9f1uJMShjP5cx/Lzfl5i7M1vVZewJpmEq3E4/FEeF9
         8uJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733609271; x=1734214071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+bQHiNZ2m2WhrSw8sdxwTUuPMItd18DX+vXFIh54PpI=;
        b=jj9d5jET0YR+/gAON60yWs8TVeEwauk9uKzIZEJOls+Y29WjVigfhwjb4w+ZQoCQjv
         3Knel1Oimdye/yX04qXIjNS4iBbsxcBH1kEtFLGGTf77XQbRnKJuULjVVlG68KJh1Ou3
         p2buOLi/Shd/AVAjiEhcEuIDWEPMoFaE9sCtWigKafXhE4QDFX4yPR9YkDWpP68Oc3gc
         GGUKx0sLn92WcmteiASlGi0IMLS37DzxWMYUKnB4VxbEdLhTUhhdcGylwwt8qBbigJGn
         s3Vt7GipEqk0ud8GRD9IfeKSoX3OWGFlTUErmLepCiCC/JGIfsG648vkJhd2jR33/6aJ
         5LMg==
X-Forwarded-Encrypted: i=1; AJvYcCVDPwu/8XN4mBKldINmiM4yVfOpHx8FI7iSDzf+yxs0d5KrojuxcSzMmqxNQg3EIqAjLHiZKra1CBbPWjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz//anVlEwT5E9NrSpx+HK/AeMAFaeJe6YRYU7UBhm//qhfCCo
	/a/ifl6BLnCcFcuIsSZJ1ouXui1WiuDLr52t0VAlA0pC0HXE1SyO9STrIaJti/HtOPi+91K++58
	Ly67fdOyqAxVIc4pGtsEXzXmx7sGEBUh1iWBVcw==
X-Gm-Gg: ASbGncsI1kycRpOnyMhi2miY6Hc9Y44h0kaJIKYuo4fd/iQu7Q8kgRGHKoZAuMW5Nok
	b6iYaNd/Ln5dg1s1DguEG8Rq6MjO5eVo=
X-Google-Smtp-Source: AGHT+IEDdkAGz2pPoVWiLs3MzVT2xuohkvNwg2NzDEclu/+M3ZXg3PNHTWshr/hQKka4Uc30sPUpjOwYgYxK7wfFjvo=
X-Received: by 2002:a05:6870:a546:b0:29e:3c90:148b with SMTP id
 586e51a60fabf-29f734e7640mr7389656fac.26.1733609271371; Sat, 07 Dec 2024
 14:07:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-gs101-phy-lanes-orientation-dts-v2-0-1412783a6b01@linaro.org>
 <20241203-gs101-phy-lanes-orientation-dts-v2-2-1412783a6b01@linaro.org>
In-Reply-To: <20241203-gs101-phy-lanes-orientation-dts-v2-2-1412783a6b01@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Sat, 7 Dec 2024 22:07:40 +0000
Message-ID: <CADrjBPrzB6H5GCN_NWcqcGhB0D31xF07bRMmoKyeZji4M2CXqA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] arm64: dts: exynos: gs101: phy region for
 exynos5-usbdrd is larger
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Sam Protsenko <semen.protsenko@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	Roy Luo <royluo@google.com>, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Dec 2024 at 12:40, Andr=C3=A9 Draszik <andre.draszik@linaro.org> =
wrote:
>
> Turns out there are some additional registers in the phy region, update
> the DT accordingly.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Tested-by: Peter Griffin <peter.griffin@linaro.org>

