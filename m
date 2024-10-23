Return-Path: <linux-kernel+bounces-377717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 851079AC2DB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FC62B26FF4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F9515C15F;
	Wed, 23 Oct 2024 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bf8WlTYY"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872FE18C32D
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729674326; cv=none; b=lB/uiYqHLuIDyvGS66M4IJbSf6loVYDCtmdfM06J26p+wLGOSEqHuFq6W07z7x1eQsWfyIRLRKJy/gq4B9CRhgh0wROA3n5RUjeErAULHuMQKY8+g4sixvuF+1RzyCSoLuOQ24sa/oD8foXlRa5qDJnTENbCsUUx2FqGtdvX0kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729674326; c=relaxed/simple;
	bh=X36zWetOyTJAz93vBOWJ+rocrYfNGhJ7Z73gXa68vyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=di6qqPZ8tNdr4uJ6LVJviaQz0AMAX4jnCJxld5qbiBdH6RzRe4DQANc6m8Yt0qhWGsyP/Vlry/UIUiJZfwrhwHBa8RrMtTDpA0yP0mMHBQp2ey6KTIlXstcgvSIWAkcHQrfu859Q/mBx/zayzqGMqw+awNLBHedxe/PWT8ej8pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bf8WlTYY; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539fbe22ac0so7387132e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 02:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729674323; x=1730279123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X36zWetOyTJAz93vBOWJ+rocrYfNGhJ7Z73gXa68vyg=;
        b=Bf8WlTYYkazelvOtD4+8fKPxplJyMy/MFUXpwj/wtxRdiA/9k4ANP89QOrXqvKte/r
         VKeoW/ZKUh1Aak3JYBP+PyFsT8nBxeIPCjO8cIiZi8LXjHeu05bDq89k08EMQoSfTzXn
         Gq3cwjaGVuZ7qTp5o3/UWU4vMcm/hSCQupbCQwzYM+nN03VWU+tNNkoNu3xNVg1agQP+
         FoTMO3Pk3xEjhyfJRSsEiEvlQ9FOjPGPF1YhRrpTCHZykO5Qj+By1MwLPds4R5790n/L
         hehWQQTPCFi6YqPR9Hww4hiDuUreSsv4d+kNbmyNWPaSYLdXggrcb46HLZBVCGGUtaeC
         sjUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729674323; x=1730279123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X36zWetOyTJAz93vBOWJ+rocrYfNGhJ7Z73gXa68vyg=;
        b=I39DzRQ7zOnwE6rJdUW7DIf9nTd36KDiFAW8y6ryZB861J+WGIOKpFcsZtqNYylT5U
         NIi9tM26gjZ7WcNqXK4mfN1o3/IXbTb8HYtu/vlpbk+rnyLgjUCNbg9e1xRdKspEdwc/
         zg/Q2pnfSwKVr6yvIp3XXqRvXQl8qvx+hBbFRMgAYrFrxOehCXgrnPnEza2GysUYcsOJ
         Rd2XsVfEV8apzu6Vx5vWGRHyXRHxv/TF0XGa2eLCEIalRcmSQtus/m7c0OsaMA7CnoNa
         bMxhvpD8SfwiTTX/nW3t00LZOCklX+9j9CbNCGeComSt8Zb9abIJF1CXhoVUghEDBJ/2
         INMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFM19FHuB3I/NioM3mYoaF+GGigDPhBAahFH36TnfkmoiSUd/weYqFscRr1DnQCGGJZ19IKQ6lOJuPqxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFYa+ody8c4D+H9w28zR55/1BxNx7r/l5pNsy0CZ9yLzq/rsAm
	TuqRbxB+fWXwvR1kHURBsBgcwDOsSrbeGoNjQHcOmGL4u/BViLKmOeJDy0PkRw8UeD8t3Nd44cl
	x+tKvkNEgzADJv7mgQ9QFyWSUhMUbUc8CT3PJ1A==
X-Google-Smtp-Source: AGHT+IH1+v9bDoKekaMKgbzEkbrdYTS5dXGjA0/CBdqgcdFe8CjG21FHGf37DjwlkgqMpl892dYOQgZjGQaLo7ZGFiE=
X-Received: by 2002:a05:6512:3e0a:b0:539:f37f:bed9 with SMTP id
 2adb3069b0e04-53b1a2f42ffmr857364e87.8.1729674322600; Wed, 23 Oct 2024
 02:05:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023044423.18294-1-towinchenmi@gmail.com>
In-Reply-To: <20241023044423.18294-1-towinchenmi@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 23 Oct 2024 11:05:10 +0200
Message-ID: <CACRpkdZP9oDd+fRKKagFtGbfLx=Rk5LJ7bvaKimw5-t25XZAfQ@mail.gmail.com>
Subject: Re: [PATCH v6 RESEND 00/20] Initial device trees for A7-A11 based
 Apple devices
To: Nick Chan <towinchenmi@gmail.com>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Mark Kettenis <kettenis@openbsd.org>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 6:44=E2=80=AFAM Nick Chan <towinchenmi@gmail.com> w=
rote:

> This series adds device trees for all A7-A11 SoC based iPhones, iPads,
> iPod touches and Apple TVs.

This is a good and important series. FWIW:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Are patches not getting applied since you resend them?

Yours,
Linus Walleij

