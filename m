Return-Path: <linux-kernel+bounces-538028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0B9A493BC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 861E13A7162
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB246250C0F;
	Fri, 28 Feb 2025 08:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bDiWInTE"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F46C250C04
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740731985; cv=none; b=evLqBWsIrnhqfo5DLsNMmwws4DTJNutYrbGKES0p1CxZ5FTQj+3vDcmFhDCWCrJIyqKY1Av7aYFp1JXMgQQ8e6GKuZHUcpgOhfRIjJEj0UpdrXJ5ZfdUX5QCmMBezh6y9WgeYLyPnZv3yssHMf0MFmLF35VG4Z0nel3QwqMPKVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740731985; c=relaxed/simple;
	bh=vXjiyibKKxM77UcLdQZUdVPFpQkCll0rLi8rRYGxZ3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t62idpoQEW6wqeuEI6jLS1irKLUzBMaFX0kFMAIqGr6hq4WoNsJkFoS08mabpmy0xuxlCNbSKIyHvk/Vohr5M3eL0B5GkfekZYS7EZN6VUCj3gNyR77NYrUiv1Y7Eoot+dRxMp4jmJcw26DpyTtWC8B/Dr4l33JcYHI10MeIKis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bDiWInTE; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54838cd334cso2084469e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 00:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740731982; x=1741336782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXjiyibKKxM77UcLdQZUdVPFpQkCll0rLi8rRYGxZ3U=;
        b=bDiWInTE2wLp8b29GnXJ1bKo9HpRSBfQ7dHgECNDrmHltAONJKsnNxAJU7CpwCd8hZ
         hJTP0+ZZ2KMkWHrns30xZ4LZxqTCy4zr1W/RyvJaj3m+ACIpiHGcJxyb/AZM3OILfgPW
         fDsoqMWXMNAj8osLKNKF3J1jXTcvFVSrMHIVrQzf9kbojD1MIJnL7RIWJ9GmnJJDhg1k
         3RCpgm03MNmr2lwwCQMY1wFKtgNd7D55SmlrtwhftBFvXJsGFDWoHr4WG3jTuynkp2c8
         KDbG5v4FXWuEW0o2VKfl/0a9V/gtw3w9JxOhz5lGF6tuikWKkEa8m/zLApsbvtRkgcGw
         QPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740731982; x=1741336782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXjiyibKKxM77UcLdQZUdVPFpQkCll0rLi8rRYGxZ3U=;
        b=f81/z07DxF9Tj+pE5sGxsbjGruQBdEC8vN2U1MO/WT/Nz+d721DguyXuE7OtPJQwDw
         RmMh7CQOQvq0+vz0iQEjGNMtaqC2DAL4Q8KXuXtbgQxUfdZbjVN+ADeTYdEsCmgO+J0+
         HroPuccI+veQTcP4jn0kEMZyQ73SmAsYqyrLjVmJpXmbwGtkXamGMI0ougtC11j5VG2h
         pBDJmltNQ/6/bBOyx48uLaYumuPKvhHpN2zk8QwugKu9cyTIUUdIlNx3tMZPHffm14na
         plktO0KGkkPsfJEUZ7YX+qhovH6LbQRG1oC8Pz2byqEuMC5mOxmaCGx0qhl/cxf6Zvsj
         BT6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvKDng1xDObeJBJg07uw+meEMIuc2xEwb1e7ahybvmUW8c2/0E6YAIama801FLMGsmvJsy2J0cEwjAKzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIv0uYEKt/EtPi5/fz9TnWo6P9MqQvOedmIrFJDY8qE+Zz09HQ
	YP3l397psb/spUB9v+LpGUjRw59zptvc/qpQu5x9JyiYjbet4U3IMI7lHO4MxPHt8ozpX9hJ50/
	drcOkCQ3xSs25rS1lS3Abk2ZPdFe4sv+waLRE9A==
X-Gm-Gg: ASbGnctALjzHOv9oj34nzI/BcpNK750/Fu+Agaqqo04ZUykDOKDXlovNnWYky7/d5oC
	50LNUnSg9At10AKJOWx8ZVQ9KCHBhIMgAPJ5Mgj/87CcspuXafi3UokNhX4oz4Ayni8CVM1JQ+e
	7LdldBIm8=
X-Google-Smtp-Source: AGHT+IGP05gd+tKAmHNLIYx59fJGUcXOpFn5E7WUbHiqgXJgfnuoO/oZlX/2XdBRPuKvDCHUORWy0P2hwCXTV/HE470=
X-Received: by 2002:a05:6512:3a90:b0:549:4416:df02 with SMTP id
 2adb3069b0e04-5494c332da2mr977914e87.41.1740731981662; Fri, 28 Feb 2025
 00:39:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227175132.3734524-1-robh@kernel.org>
In-Reply-To: <20250227175132.3734524-1-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 28 Feb 2025 09:39:30 +0100
X-Gm-Features: AQ5f1JpcWRmXsix253vEwz0xl8LXX8T28Ut4ONXhb1Jer9IAi0xNCTvsBZEZyVY
Message-ID: <CACRpkdZ8twhOH1T3cStuLsD7a7HME-wA9YzotmrhgXmy-zvPoA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: gpio: mvebu: Add missing 'gpio-ranges'
 property and hog nodes
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, 
	linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 6:52=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:

> The Marvell mvebu binding users already use 'gpio-ranges' and have hog
> nodes, so add them to the binding.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

