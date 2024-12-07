Return-Path: <linux-kernel+bounces-436199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A89429E8268
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 23:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90B891884890
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 22:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBE4158534;
	Sat,  7 Dec 2024 22:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xyVACrfl"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8227222C6CD
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 22:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733609010; cv=none; b=AYioChgGaCt94x76uL0wvfqit6XNqaFr5Kip6k5XunPVnJ8S1801Wzl9lo4TU4jNpHbhzRHwUyKsRUd8WxiIb3hkGhD9xdWGWA0msd4iNKl1IfDK2MhDXEN1TM13rQ3UGXWrgxeCOvDHXsLnjrjMm3Uc79iPbBajeGmsBOWoh8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733609010; c=relaxed/simple;
	bh=8GXM0+BHtSGWHXqNnKhtHtPN9SdqgsAE77m643km+40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GljduuYmBGjT7pF51ixjr4RH8zDibZpyAIaFAoSC8R61sq2JJGQOZa5+eV40LkoqExXDWlNUo8PXGyD54rXAGvey3p2srl+rsQ8SfUChl+dpg58/tpYgz9UXEGJUbPunAp9yOsVwY4tCPQe2gVsCNpzAvyZ5ubDBmwasVBtA4xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xyVACrfl; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-29e49376462so2044467fac.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 14:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733609006; x=1734213806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GXM0+BHtSGWHXqNnKhtHtPN9SdqgsAE77m643km+40=;
        b=xyVACrflMo14f/QW3IV78NaUuIpm+irun7RHv0PrP2r0wQL/N9zfnYzmGlbP+zWhRL
         H7+WRfXekkeRWgKpyR8PNUteCWK02XEcwoNx/fsu52uZc8DuvUMAM++2k129ZY3/D916
         wFjhxCbEfbxWaoI+VE0WXqsbToYOhj6FzvagmxLhNexOf3PvRFYX13PxvifZUWm7fGgZ
         TuxkHIXccdVUyHsUgd9cnT4nd6cEyXWqSA4ufa3dgiIHutsl/vz+dbdQDOmTyq4xFKQA
         s9Qn+MoTaR2WHsFK+iqjxyQKTHL8WMD9J4WF2g4K5lB/Hh3ZMfqa1A3gkQdZl5ueMmun
         0uVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733609006; x=1734213806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GXM0+BHtSGWHXqNnKhtHtPN9SdqgsAE77m643km+40=;
        b=bfg9FqJlkrGZ24BML/9bCWrsISgYm1Fns6XHHF4Lkafrq2jD3vRVDe7oWLcPPY2znp
         9QA7MvjGiUsJYcC/GgJYB5VhnDs2NlY6vWC5GBzlT2qAFyxsSb5tiV3UnxxhDU1ledvy
         edSQrOdyvizb/nzGMIkKN886MIuvTiMm4Pu5LbVZKwCecz6RthdhXMh+EASasgyCfB3M
         scAuztv1KHy6/g/cU5hUVgdZUnJ1pgbQ1ShHWgnRGS1YhipQ3TbtUvgs6XLkA9FxmDOU
         oGaAfH+1AAGESLhlcfGaZqOpgh9l/MqlCZPgtVNDr1amAU3vFPR614LWbNKHAXr9bGyn
         CZdQ==
X-Forwarded-Encrypted: i=1; AJvYcCX12EupxhoCXanJkYYm59DatjiQ4eOIKXfKOE/0o/Fm4+lpWu/foUYDu11tCUFYrKDM9fnhIK0709ybOjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyTxRj4iDXr6rTpq64lRq1c2zqPG5/2KjqxEaFfDxix7cyqM2E
	AGGaLWpxIMTN0qZeL0os60uLmRvSSMgdzmayR+nC2hN3MEK5azXv81dQ1AWMuBCnRvImxc/kRic
	jITWRYkSVU/6LPR5gs+T2AlpqDOBhZ/ViY4zuQw==
X-Gm-Gg: ASbGncthQsP+vICgqdV/Bwxn/1Enw96+DdqmNbEoG6M+TQwNFYLdeL0Enwf31iqr9u1
	SLZ+0cLJCs5/zyVDbnHhxTUif1bXJOE4=
X-Google-Smtp-Source: AGHT+IFySGjzoy5FCW6UW8sdkAac1K6u7Brr2FiRkrW+1TN5iMSt/PqT8OWXDemRttmZeKYZRyGTsy/kAkU/2DL3BXc=
X-Received: by 2002:a05:6871:c709:b0:29e:392d:afc8 with SMTP id
 586e51a60fabf-29f7329ae2dmr7184218fac.15.1733609006594; Sat, 07 Dec 2024
 14:03:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206-gs101-phy-lanes-orientation-phy-v4-0-f5961268b149@linaro.org>
 <20241206-gs101-phy-lanes-orientation-phy-v4-7-f5961268b149@linaro.org>
In-Reply-To: <20241206-gs101-phy-lanes-orientation-phy-v4-7-f5961268b149@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Sat, 7 Dec 2024 22:03:15 +0000
Message-ID: <CADrjBPrz1qUxbEVFR8OT785xLPwWmu3_ZThSne+EtpS8_NHEEg@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] phy: exynos5-usbdrd: allow DWC3 runtime suspend
 with UDC bound (E850+)
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Sam Protsenko <semen.protsenko@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	Roy Luo <royluo@google.com>, kernel-team@android.com, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9,

On Fri, 6 Dec 2024 at 16:31, Andr=C3=A9 Draszik <andre.draszik@linaro.org> =
wrote:
>
> To make USB runtime suspend work when a UDC has been bound, the phy
> needs to inform the USBDRD controller (DWC3) that Vbus and bvalid are
> gone, so that it can in turn raise the respective gadget interrupt with
> event =3D=3D DWC3_DEVICE_EVENT_DISCONNECT, which will cause the USB stack
> to clean up, allowing DWC3 to enter runtime suspend.
>
> On e850 and gs101 this isn't working, as the respective signals are not
> directly connected, and instead this driver uses override bits in the
> PHY IP to set those signals. It currently forcefully sets them to 'on',
> so the above mentioned interrupt will not be raised, preventing runtime
> suspend.
>
> To detect that state, update this driver to act on the TCPC's
> orientation signal - when orientation =3D=3D NONE, Vbus is gone and we ca=
n
> clear the respective bits. Similarly, for other orientation values we
> re-enable them.
>
> This makes runtime suspend work on platforms with a TCPC (like Pixel6),
> while keeping compatibility with platforms without (e850-96).
>
> With runtime suspend working, USB-C cable orientation detection now
> also fully works on such platforms, and the link comes up as Superspeed
> as expected irrespective of the cable orientation and whether UDC /
> gadget are configured and active.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

As mentioned on the last patch, in my testing cable orientation
detection is working, but Pixel is detected as a superspeed device in
one orientation, and high speed device in the other orientation. So
you should either change the wording of the last paragraph in the
commit message (assuming you get the same results as me) or make it
detect as superspeed in both orientations.

Thanks,

Peter.

