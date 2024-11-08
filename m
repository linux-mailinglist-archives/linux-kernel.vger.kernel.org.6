Return-Path: <linux-kernel+bounces-401314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE1A9C18B3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AD2F282B5B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4991DFE0C;
	Fri,  8 Nov 2024 09:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SVT1cdzd"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864D91E0B86
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 09:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731056596; cv=none; b=QGmM2Mns7A5pc2bxS3ntjT8kRIuO1q56yVfdaLB+rhfUox1ZTin66v+96RPmJ8qR9YSbD1/UC5Hhwp75se1PI2jp/Mk5GFZrUrYDddIEP6qnbx17paPV/Z8pvL/MYWVM31oWXsx3S0f5PTYC5neebVawIg7PaNCsx52ADdNxzjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731056596; c=relaxed/simple;
	bh=mM1q+PpNsdlYYSy0+MS7uMGw3FOxO3A/2cgbrpd+lLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BIcuXRziNP2u0d0RW+Z7TLDoEQIXBikRb3yij3DAh3zztruAYM+/IaGGrFHycE/+6zMg4NE1aEnVkap0AZkklyaAtQr7QF4td0y8Sutxu+SFeIYvWHdFkLk68/aszfkgAsTXkWVhd1C4cYbLYiWhDVABOaqP4WmF0905wbwaMSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SVT1cdzd; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb4fa17044so21754251fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 01:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731056592; x=1731661392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mM1q+PpNsdlYYSy0+MS7uMGw3FOxO3A/2cgbrpd+lLQ=;
        b=SVT1cdzdHhk8J4vvzGfl0QSWqf9+mWHG3SdlfAcDe9PjrxutdF5yiF8H95Z1PFjvVR
         GTmsbsD0XnFwCGEKTzto5xvS2OxItki3d1o1cm8eUr+gZLdGA+sAFnuHWk3w8sbcNC+3
         b9wLr0OBz1fgjWSD53mNY6LbkFSyahQAcf4Z4qO63FdHY+L+7DHZMtDLrMbnQ+94DPGK
         CAQYHFb5eiloltk+gXe+2L3cxVcYB1LOHMX2k3f+acxunE1gpqKlW7is/68uX04CrIFU
         fWwYS5kjAFp6Ts3Q1F+ya1tUp4jTozE573WTZiPx1j/fvRj2+FnTUFy5htVNjJjBSVrq
         Y+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731056592; x=1731661392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mM1q+PpNsdlYYSy0+MS7uMGw3FOxO3A/2cgbrpd+lLQ=;
        b=e9HDkJxUBBn/LMTDmBBiEWRJaFc7gw4ReURRe+kKeURZ58Tw0uhNUlw9x5hBIxHk/i
         92e8lxKnlNPNIDgJA3Bqta6zLtysx34txBOaaNsKp1vu19HiJYsUB3GJGBR06GGlG1h+
         xIN0/jyOmTu8MUNqzdbcNbKkLjQRHrLnAylQWTdLh690VJ83MY3uF0MLtOu7qlMQdyNH
         JeF/VZLMKjeIwQaVsIWMHSwN9S8+O9NGW/ZwLLJAPONVzOPpzrZ/7JjIdNNPuKo77uhZ
         cxOxclyV5E+bYn+ASRc9iesTZdU5Zpzb08zNYJuiAE0tUw+d/KW1/eg+8uMtGhuWqFXd
         LkDg==
X-Forwarded-Encrypted: i=1; AJvYcCUl2IcGJQH3cNlcnTE2gBkLkKAV5p1FMMOap4Kb9fEy3u4sg+UFD9xGzcdqiRvzliNTBJETgOauQPmGJM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPMETELB0ANGvz07X7TPaFRN2PCii1+Nx51zbYGDbR64oLLuGW
	E0emB5thf3ZbbyDliVuyJGWg3M/ywLll6GYTznA+NHWXbKG2Dh/8lvS+WPMNV9dWuWL22dY365Y
	NGP+l1gPgd1UGUHOleU9O2c+zrhWiqUoQXwPYLg==
X-Google-Smtp-Source: AGHT+IE8znKU2mORtpqCkmsGs3P+cyt3qFPqf5rFKSs3v09PAE6qN06MrjzRnmT+Va62FCJoM1OHaIoEnk1727lsx7Y=
X-Received: by 2002:a05:651c:554:b0:2fb:4ca9:8f4 with SMTP id
 38308e7fff4ca-2ff20209f08mr9538661fa.23.1731056591608; Fri, 08 Nov 2024
 01:03:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107-msm8917-v3-0-6ddc5acd978b@mainlining.org>
In-Reply-To: <20241107-msm8917-v3-0-6ddc5acd978b@mainlining.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 8 Nov 2024 10:03:00 +0100
Message-ID: <CACRpkdamugexe6y24Tk2fDYPP_t7QLynibdGQrUMFMwF4y90cw@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] Add MSM8917/PM8937/Redmi 5A
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Lee Jones <lee@kernel.org>, 
	Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Dang Huynh <danct12@riseup.net>, 
	=?UTF-8?Q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 6:02=E2=80=AFPM Barnab=C3=A1s Cz=C3=A9m=C3=A1n
<barnabas.czeman@mainlining.org> wrote:

> This patch series add support for MSM8917 soc with PM8937 and
> Xiaomi Redmi 5A (riva).
>
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining=
.org>

I merged patch 1-4 from the v2 series, don't think the have any differences
in v3.

Yours,
Linus Walleij

