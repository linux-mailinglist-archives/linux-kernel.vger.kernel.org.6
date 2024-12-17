Return-Path: <linux-kernel+bounces-449325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5859F4D3C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD349165320
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66BA1F543C;
	Tue, 17 Dec 2024 14:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NheA4pr5"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FF41F4274
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 14:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734444521; cv=none; b=ChClSs0gl/vZ3mOQ7HzSvv5bFJmoM6I71t5OEE1+UML4g8gPUE3cMdz8OIoYYIF5j/Je5eWxlECvh53biS1AuGSGHUzhALOcKx59hpJRtBr554kJMAFZoe9Z+N18yPBs3MS64mYcoPXorK/O8b/fAke8v+rPH0+faKmLoFMpGd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734444521; c=relaxed/simple;
	bh=jGW0026BXd1vGApqNs0btmpVNZLakv19aMfi05Mi20M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e6gWuQ7Cjb4SiWoQ4cMWoP3CGt+dTXAq+cf0mhW82BDi/bu/TRUIaaVTwf3lpiNUDUXKaklWpkKLrC+OjRuk0CxSLU6IQnfwzFpWTVMYeex66ASlJDPRNy8FXet78lvRy9rpKwRoq9K9X1ahPdiG+6GmMYCdQsLqC/tnaPPI8hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NheA4pr5; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5401e6efffcso6131732e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 06:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734444516; x=1735049316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGW0026BXd1vGApqNs0btmpVNZLakv19aMfi05Mi20M=;
        b=NheA4pr58mOwLlDv/vwZFyo3Ke7+LnhGcin5OQ7zENaFrT4pMsenJ9pS22ReXgHkai
         FKsVtPYDI9X9ToPc4GWYRVEmJSiGHyRv9oNZrPGyfwFF7gZsMuZ4bB883GJajvh47WA2
         JUR68YcdaXTCEE/eNrkBy+BvCswRitzf2lJNFCz9+PSWWTaxiSGbgjLMJ7tIlIRTEE29
         FYnImos5ES4L/TUH3DU36hFwbpcx7jgXiKL+xOVNY9rP6d3AkXHY68FnuaDRmtSCMY7M
         /4MglcynYQoBQhpuuQV4vjZaMV2Li+OO/pkbP6A86jT7wOn7PK3mfLEb3LzG/8DguOp4
         L8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734444516; x=1735049316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jGW0026BXd1vGApqNs0btmpVNZLakv19aMfi05Mi20M=;
        b=KNbwib+goIFHCLUk/aU4iolnpX6HaDoQCI0Su2Y9XxKMad4Vrm77dgH+4farbpqxME
         DAKZhjJJs2RAIQdvUas280F6kjn0UqTdwdolDM2rhRbXwe1f3AIblZCPiWkY8c4LLrrc
         2pyrSa0ybcHKR3Jih/dE2+7pbRuTCsN84cawKyGnc+VBPlIIFA6TDaVKq8vCFTxztC8L
         cACUAJ6lcmEWu/sazNMfbltwac85CheuogCd9Tzcw8RWc8pib04pXpDqztyL0GAuhXrq
         y02Rl5ZBg0S9nJAIY0PxL9SfKAROzlLYLvpG2g34VuutQ7RKqUgLT1LOgjdOYzeY9guH
         K4XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXmAacYNFQ85M08QlnPVC0mm0+yLSpyEV8MxipLoedwh7RDFb+UcJSPD72v5bTIWLc1/HpYLcP7dnGhp4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx+ArKccM5KjpSFteMJIkUT9k0y5Qj5q7zQgBWBpxOM9DyZMLz
	Gzecsyfj68lf9hKnSgCEsFSENegi+xVBshe8kAUQZ2tjL10cTZfeMr0zfym6eNyjeAqmsYEtD/y
	rxiCI/cc4yV004X+88hx4B+eFtcmcxB/J+DL6Fw==
X-Gm-Gg: ASbGncuoJqAjCCYR+o4Jfh9IH0M82iuqMF8uRoq9mGOaV7oKzULUMZqMrB9Exrh7uji
	OsmM85khXNM8rs7Yx2jvWSGujd733YsWB+XYp+w==
X-Google-Smtp-Source: AGHT+IEDzg/1QaAryu5mZq9zNVQFdPIn9J7cRI1WtaDrnft45JXUSlTsAmYaTbg81Eind0y2KWBppD7S2SK1pxKF98I=
X-Received: by 2002:a05:6512:238b:b0:53e:350a:7294 with SMTP id
 2adb3069b0e04-54090595736mr6147916e87.37.1734444516125; Tue, 17 Dec 2024
 06:08:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241208-power-supply-dev_to_psy-v1-0-f95de9117558@weissschuh.net>
 <20241208-power-supply-dev_to_psy-v1-10-f95de9117558@weissschuh.net>
In-Reply-To: <20241208-power-supply-dev_to_psy-v1-10-f95de9117558@weissschuh.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 17 Dec 2024 15:08:24 +0100
Message-ID: <CACRpkdZczWm4Fu7sNbcCCz2Ef73zAuJTJe_=0U1hZuFsyXooyw@mail.gmail.com>
Subject: Re: [PATCH 10/14] power: supply: ab8500: use dev_to_psy()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Sebastian Reichel <sre@kernel.org>, Maximilian Luz <luzmaximilian@gmail.com>, 
	=?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 8, 2024 at 2:02=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisssc=
huh.net> wrote:

> Use the new, explicit accessor to go from a 'struct device' to its
> 'struct power_supply'.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

