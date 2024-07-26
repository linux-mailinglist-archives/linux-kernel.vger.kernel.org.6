Return-Path: <linux-kernel+bounces-262857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF00993CDEA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 08:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 398EBB21E25
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 06:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B010173326;
	Fri, 26 Jul 2024 06:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vxUF+L7r"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C57A25624
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 06:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721973735; cv=none; b=di7Iml1YQIbanKiUllIfl1Fnmdlu+mjNAH6e9qrcGwi0UwPAIKSHxFCDqXJwDttmdj4f+j/GCIPWET1CgBhcgcmNgIuB8wsHUfViirwaoZ75SnseSz9P8MdV1LMMvAq1SBUbT2z/JOf1O67iAe8iIHe0gZ0o3M3dNm4V9yE9eBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721973735; c=relaxed/simple;
	bh=rNgR2JbRnvuvQ8FNSWDeS5hOPWs2py2ht5Ejpugq7pM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bT/NX79lQxNFunZz55QSEKBh5KzrF0HJO/qA5f32bad1DX4dTpGaWVpaFiFZn4SxEal2LFsmi0pkgzlzYVQVFtOIoNDVIESl+ht5mrbUxMtUmy1E4m+047JAOUQOyg1MsMgHzH8nH1/xbFXKhpSF7z5w4p6sLvdKSKkr20lRLWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vxUF+L7r; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4280812ca01so9063305e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 23:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721973732; x=1722578532; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rNgR2JbRnvuvQ8FNSWDeS5hOPWs2py2ht5Ejpugq7pM=;
        b=vxUF+L7rAkHgm9J9fjcF6VpJiPMH75rp1GxCnx8wp/H1FgarCuuUCVNlC/Odcy1a6e
         JF8Ww50Fvw/e6rjKRFDoGkD2zRw7XLwWcI/stTzMqwXWR26c/LslmCkRclR7BPMDYAnp
         cICoiG8oK84TrC5hKv+GuvP5vPUvfEhY/v5MG7vYhgnA9LIJMbGBEwXFVr8FsDnf56Fj
         NY84bw5pVwxMeVA0+E8pIHuJp4igubRJeJFlsbgvBBfVELI6/7yHKQCZe2eDmIwoeTQx
         QnbGwjcz3CovhjhPLCljVUSjiA4LNTnddDnbNZVoo5R6HvSOsPOHqL9bH5G7qX/Inlvu
         QPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721973732; x=1722578532;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rNgR2JbRnvuvQ8FNSWDeS5hOPWs2py2ht5Ejpugq7pM=;
        b=Juu2vDJItCIiXPf0XpxVh+udub0TQ2+CH0PfJwUOYtVkRf6SygIyEjhNg/IjoaQkgE
         bBFlilRhIhIfnvNwYxkTfIOnKNdpORBYskb722c21+HHd2kNcsiW0sNFmUXUlJ4ANuJ9
         /kYj002cVJMFcnYSuyzGUgI1ReXfocYjTXcf+OeR6XNAlHFGzVdJVw6xAwJgoYTtCQMB
         qsrBpj5EB/qh57ePqanntUbdPl9xejUmaUjHMLEXJQF0B0RMFReSNRnTeJUl3nn6o1r6
         dqiQGiZ9SBrYlKy2BWtt2++uQfhXTfXYDCyLqUEpiAYoBLqx6zDGTZeyhP6HeMdnbvMU
         AJNw==
X-Forwarded-Encrypted: i=1; AJvYcCUfEB0z4CgtzP/ZkxV8/Ub0xf7cOirZBwso+EMh6koH3uKAgwKee13IYe9u4YUeAjpXjoHtD7s0SnkcWbJOgKqH8YKEMMudeQlo9cYM
X-Gm-Message-State: AOJu0YyrYkHFhFVro3/eTsG/UMMxOmo7NHFjTUGy9tQJVMiMtU4e+6iu
	73cy3/txkhRdpEkRb61WdwAL2RwCtD7aokVo9gi5tU6xCPuWC7qAYP3EcNlyf/I=
X-Google-Smtp-Source: AGHT+IGZITgAy64Un/8wyyMq4vbFh/xNWJjrD62oeqgqKxJlyGVdbqIZ92b5GkG6r6jaxg78Jk2SnA==
X-Received: by 2002:a05:600c:3551:b0:426:67f0:b4fa with SMTP id 5b1f17b1804b1-4280546dec3mr29466515e9.1.1721973732563;
        Thu, 25 Jul 2024 23:02:12 -0700 (PDT)
Received: from [10.1.1.109] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280574b2c2sm60659955e9.28.2024.07.25.23.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 23:02:12 -0700 (PDT)
Message-ID: <ace0b95ad77fe044881068a4cf1944e10b306730.camel@linaro.org>
Subject: Re: [PATCH] phy: exynos5-usbdrd: convert some FIELD_PREP_CONST() to
 FIELD_PREP()
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>,  Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus
	 <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, linux-phy@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 26 Jul 2024 07:02:11 +0100
In-Reply-To: <20240710-phy-field-prep-v1-1-2fa3f7dc4fc7@linaro.org>
References: <20240710-phy-field-prep-v1-1-2fa3f7dc4fc7@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1-4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Wed, 2024-07-10 at 07:45 +0100, Andr=C3=A9 Draszik wrote:
> Use of FIELD_PREP_CONST() was a thinko - it's meant to be used for
> (constant) initialisers, not constant values.
>=20
> Use FIELD_PREP() where possible. It has better error checking and is
> therefore the preferred macro to use in those cases.
>=20
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---
> =C2=A0drivers/phy/samsung/phy-exynos5-usbdrd.c | 12 ++++++------
> =C2=A01 file changed, 6 insertions(+), 6 deletions(-)

Any comments on this patch?

Cheers,
Andre'


