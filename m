Return-Path: <linux-kernel+bounces-263574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0E793D7DB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11EA51F21C1A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA3A17BB10;
	Fri, 26 Jul 2024 17:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hmk4H21h"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AEE17623E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 17:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722016587; cv=none; b=Pni18MK4NXL7mea/TcoBYf9PWnJcpaR1JfKsxczOt4IPx5LoG/FHVWmQyLeBLNiAWKFoiW0ko30rVONSguqL1lc6jVVSdem8UgL2WU0HCB2jjVU69cBCUmX5ICJe5DKYjUriDXlTymK6xrDOPNIkOYuAHj3zDg9E/PW0vHz65ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722016587; c=relaxed/simple;
	bh=D0JVdJPhPCLp5esR4XLwLE5OGpidKIvLh93BHT5WLxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0V5rYCdL344GrLtk7aUTYqw6919pPqd+m1n8Pd4MM3doJXgJCIe8PhnGinAQeMH3XEfLg1FItwP3Ic49aV/5iG2v9AxdZ1gmZjU69beESkBwNiKO0TPNkmPhG224HsZxUfnxyzX7gYDyAkooA1OPUbmofIrE7+VSRZeRTGTYdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hmk4H21h; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e087264e297so2197751276.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 10:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722016584; x=1722621384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhUrBslr8NYAo9/MyQYN73x0EDRASpHspmRycm+GNrI=;
        b=hmk4H21hNCE2HaZfJCJd67DSwkAcmdhWfb2i4z4d+VkBenwhonIVE79nB6yOfXcQlQ
         FOnK66DRu7tJBylr2GhuX7qW2eT+XseSkpdden2AAHg5qRnBlguILlrXDLMPWVp5E5bb
         0tNvcXbDlO0WEeBEAHc6NoG0mI1sTA7O3rht2kQ4C6m7UCRjLlUqtZ+ywmvNcKSTLTkV
         XR8hOnXiTJZ/W3JZCH76znHlk5mQ8kfeIRFH2ZV8hVH/a6fA256Ft4wzvLwGMaej6KpQ
         qMJqKKVgTEkNHaNnoDGslZlbSIdoxmwHOXp53w4qE0hK/OvYRrHPYbGMgm9SGrpMzub8
         R1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722016584; x=1722621384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhUrBslr8NYAo9/MyQYN73x0EDRASpHspmRycm+GNrI=;
        b=fQ0derew8H27AlmtBeVLJCZCiXhLsgFxdwI3mhu/VroC5LXsRSA9yS5z+9VjB6NhgH
         qJZ97nB6m368Zcn7bkUPA1aPqUlJKH/JGkbCZ0Vb6LKpWvJG7l4vbayrRp596aGMtXPx
         o91P6TZCqkQua/dOb4TJkwiQehjdL4e466FIc/Fak3j8oiHIvb8tJRa3H/KKJUF157tF
         lKMGqZ7dQSE0W2Y/8Yxl6VSaIi4/H871+b1DGLy7/mQbLR+wpAAeU/rSsrGT3Kc/URfR
         CYhHUA//stUu8uqbY6XZoqC+UGLZRBavHQIJdbXZd+wPv5Nn0adAkZYV1UFSv2NyxKPL
         64IA==
X-Forwarded-Encrypted: i=1; AJvYcCWnFXAEBHBrdI1fF2prRBuUUObL0XT69nJhOqnyJY9HqUVqr5EPA0MQiXmA5X6f5XEYZaJREQ7qsmRolp5rY7Xdo7tQdtZVEhAgX1wd
X-Gm-Message-State: AOJu0YweCMh4EXBlRGW0a58DGccJcNE3YoPt7cdaZGFuQ9lWtJzASN1h
	Za8KEvKUbgyqzTxY/T3H2kbcM7IoapfDdnIGmGh0KfI+UNSCpJbMHxiE012Ee45gJkFOuNNWQsg
	rlPykIvyMKPtaOUyghM7yidS8Rbx23/G5w+vxIw==
X-Google-Smtp-Source: AGHT+IFRD79UEjDaEHKHCsvV9s7KnHcAuekNi2ZVuvc9B/6COZfuwaKlCuHkfaA1N/a3WtELB0IlOea81E3BIThlJOo=
X-Received: by 2002:a25:ab11:0:b0:e0b:1407:e322 with SMTP id
 3f1490d57ef6-e0b544485afmr656498276.1.1722016583941; Fri, 26 Jul 2024
 10:56:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710-phy-field-prep-v1-1-2fa3f7dc4fc7@linaro.org> <ace0b95ad77fe044881068a4cf1944e10b306730.camel@linaro.org>
In-Reply-To: <ace0b95ad77fe044881068a4cf1944e10b306730.camel@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 26 Jul 2024 12:56:12 -0500
Message-ID: <CAPLW+4nrxXOz_gaKR6dLZxiNW5AEMUZRMcmAyzpnd_GKzdVdnw@mail.gmail.com>
Subject: Re: [PATCH] phy: exynos5-usbdrd: convert some FIELD_PREP_CONST() to FIELD_PREP()
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 1:02=E2=80=AFAM Andr=C3=A9 Draszik <andre.draszik@l=
inaro.org> wrote:
>
> Hi,
>
> On Wed, 2024-07-10 at 07:45 +0100, Andr=C3=A9 Draszik wrote:
> > Use of FIELD_PREP_CONST() was a thinko - it's meant to be used for
> > (constant) initialisers, not constant values.
> >
> > Use FIELD_PREP() where possible. It has better error checking and is
> > therefore the preferred macro to use in those cases.
> >
> > Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> > ---
> >  drivers/phy/samsung/phy-exynos5-usbdrd.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
>
> Any comments on this patch?
>

Looks good to me:

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

> Cheers,
> Andre'
>
>

