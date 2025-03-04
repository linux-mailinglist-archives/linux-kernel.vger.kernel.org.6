Return-Path: <linux-kernel+bounces-543535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A05A4D6DD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58920188692D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83B91FC7D4;
	Tue,  4 Mar 2025 08:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IpNCNxz5"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CA51FC0FE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077905; cv=none; b=h8Q0sLt7VnFk7zlZHhXSxF6oWLRsbuVkX9la3P5PtFtmZBnjX8GX2oHafIpcfJ5a3IP9KzroKcUZngro7+LiczLt7cgv+jNUoSkw2YW8+QGN350vC1NL/2f77XC3nbvQitaYlg/CHfLwbkfx9r09FUT/X7V0unQP5/F/BFFQUHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077905; c=relaxed/simple;
	bh=pR+bRfGQlzWx7gBjcdSucJAnN3K9ea1LhqswU3jkQrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AB8KSLHnMyEe35cTDQqxmPb9KKu18bIos8y5BwbKAgWJYetFVZfDkovtE/k8hs6u69FwkcDS/fuooVkGe9UoeWSDiPnRmtSgAqfCJzPgBzA0QQpaE7imrLQszdzN+QFy9i0TaKZs3gN3QUABGztKrBNfl5cU+bXUAD7KXiG3rU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IpNCNxz5; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30baa27b209so24336511fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 00:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741077902; x=1741682702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pR+bRfGQlzWx7gBjcdSucJAnN3K9ea1LhqswU3jkQrg=;
        b=IpNCNxz5DWjg1NDjK+v9sQWobdNY0C7VexzWIoUdOBkB1jFTE7ulKywoIiL2dOlQil
         uMI0qxKIqgLP6VrX8//TPapY41dzYjzkd9gQ4rMCjMVP85q2mH8z6877+AhpkEnJDDgb
         TZlA29t2oloimwJNjngCRPWYQXzpSBCNs7nlbDtLYPqa42OUYDi3t7SPidoVXG46KTch
         Qqk9WkXgv0WOh9R9yGcQd6J89IdvYMHd3SqZmj3owU8RFGRQku5/V5mn/KWdXWhFXTxo
         giRGuE60LvK5+rxuMlhjroZKiIF8/LIRvTbWY95ROtvhGZPRRoHIVE/397F23lFlAOwT
         6Fqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741077902; x=1741682702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pR+bRfGQlzWx7gBjcdSucJAnN3K9ea1LhqswU3jkQrg=;
        b=p7gtgBQQL9su+/+Rk8bFMgTwtt0oHzy5jrpkbUDwVv/t8bjk210qxA9iSpZ4F0nNeE
         mEzevZW3+3QMaVmMkANj1OjM+xUBjQI4xmSdvuh4R1seYbputzdqz5rt8TKOKt/5ENsi
         /uBSV1+1J/E4pKi/6In4niszhQWs6zMcyoPcr3O3h6dgw4BfYE9H4+nMbW4J/JwS1Mzb
         foqVCHDc/wBjcXfqerfeWRiYP8scjmbibRub5t83Igww6YgjPs4txjWhj+nlBIh8oEqs
         C4LIMCe0QkegxAHLQkrmNEjTfClJWTROD4s923XBtuLU1rgLoTwFIg/FUVVUXet8tqUh
         XqGw==
X-Forwarded-Encrypted: i=1; AJvYcCUjvKU/CLwpisZSu2PX8HgDHTjW22sHehPp6/x+uCjyeZLmNLcPsdgkD60iQ41klGb2dbagTzEg5OVBHhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5trHDfdQafVQefbtwWlJda5TOhyubI4HEEwVIyKIqiuSeFk0l
	wnR+fb6NIopc07d4iyNKMt7+pf+wZ9y1nntc9lBHCgky8yArRYEKWrO4lpijIZU05ZFc91pDP4Y
	r261twujkwUovOtxPJpbbWsQ6kr9+xOJ4gN2F3w==
X-Gm-Gg: ASbGncuT4NHdvMxF3I8wdiJL6ZQ1+9yg5sJweOWbW0EryKZX2OTJD1xX+ESF1v+gOpU
	2wkPtVIX1rejq9MrJdul9dzOFggmH5B2nlT3yrG9aE85n1SEWWii1YLlaIAyyLL23IJPRjuVJjH
	zDGPF4HlNOoDAeVZ3cHInlXDvzFg==
X-Google-Smtp-Source: AGHT+IGgRiH2oS22RGfJxg7aIwVmCJWTNc+/r77/fuTgsqtE4Ux8/GK0e63mEvBxg75vsi2ow2K3BDFTL4IZbFj8pc8=
X-Received: by 2002:a05:651c:1546:b0:30b:d35c:4754 with SMTP id
 38308e7fff4ca-30bd35c5025mr120331fa.10.1741077901727; Tue, 04 Mar 2025
 00:45:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303160341.1322640-1-andriy.shevchenko@linux.intel.com> <20250303160341.1322640-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250303160341.1322640-2-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 4 Mar 2025 09:44:50 +0100
X-Gm-Features: AQ5f1JpGA_-UhNoTPJmPBEBi7eNV4b_GKZenv7aPR3Dmi6S0SC42FWEfJP36qBc
Message-ID: <CACRpkdZ3E9J3+P3ANK-+NDidnsoZG-8UWP_G98Oai-dp6fk6Xw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] gpiolib: Align FLAG_* definitions in the struct gpio_desc
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mika Westerberg <westeri@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 5:03=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Align FLAG_* definitions in the struct gpio_desc for better readability.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

