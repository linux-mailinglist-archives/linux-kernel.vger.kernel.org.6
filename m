Return-Path: <linux-kernel+bounces-538628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE36DA49B25
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8BE172A0D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8171326D5D3;
	Fri, 28 Feb 2025 13:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="grI+STAK"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B53F26D5D1
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740751171; cv=none; b=LGf/OfCQFaqhdWBPCr3qjwr/5dXhygEd1FR94rgUi00Ja/jjcRPzLVpAn+lqXuK3SoBUyaf6eoeCAB8smWOQ/jO6I2JMP/ancUtuS8CaLoYWXySxontg6yNJROQ5T2zkUnY71s5EB7+yxXZ1F9UMiKyWp8ZIJk0nusyrSr4hWLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740751171; c=relaxed/simple;
	bh=px+x86aKSLPgbV52+S2WFBDfxcJqop/aXnFFgDBY9tU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kcWXqQ/A8m3Ux3W2H+Q9u3uFksl55k2HcJ/67tZYrcvgd9Cym09H+QF4I5UzS5yqJZkMYuUI+KSSMmJehTBRbVAb1NwaOubKQCTY2C64bWU0VKG5TlUMGIsQuDY4noNLDvusmtgSgHEzUmHM+wbdaTpMQK7Ae6HIoaPsmT5/CuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=grI+STAK; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-390dd3654aeso1241813f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 05:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740751168; x=1741355968; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=px+x86aKSLPgbV52+S2WFBDfxcJqop/aXnFFgDBY9tU=;
        b=grI+STAKOAnH08bihdrVdSxnngP7J2jW3cKPR/2Y5MaVL0evvPR0W3GzgzXLLYwR02
         u5AvChKCZpyDKfHvyh6wqJNJ3iR3PeAdDruTVVJLAsMt3fk8zc8rQQ183v+hwwhk7HLz
         /Pmr+qtoqG8NlpXVL9dbiPdgqVu2iVcmT39SkEJd8TraGr5jgVoj0+3fXwT/jXVnCU+3
         ly9xKRuwG397WPW8o5uX63mYDvTpS/1gVgWd7Km2ciUy2hZi8pvmTKOlz11IHDhehorp
         gdfLMBHpQw1JttRu1/RG0yCHKsf52m5VoUPXXWa+OtM1GgDDu/ArHT2ioYrFvwyK/QJl
         iWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740751168; x=1741355968;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=px+x86aKSLPgbV52+S2WFBDfxcJqop/aXnFFgDBY9tU=;
        b=oUOvorQesC+eo06g6XujxxDXlhWUloX+td+CvmcZlJ+SMfoD+pBTDtohizEAOGIR72
         P6m9wGClcvOUcQYRMiCZJDAoCoxWaUNqye0M/eK4Sn1+SLXLsajf7FHnBNEuZEARUp9R
         G1vOcJ5kLQds1t6cq1ummpAKndPyYIziwkeM2O/pwINv4r09lvHXA/xMBYC8H0DmAPq1
         XQ5FjusLd4ync0Np87nTBp4GiLVGLI8K819wg/5xfYrk0I0H8nokxlq9vnJcWQpu46Tx
         xZYsv9GeA82PkBB6e5T7icicBPZiHCI/PTOHkFEXDRlZM9zI1zkW9dtre8tIB6RSQGwF
         PUzA==
X-Forwarded-Encrypted: i=1; AJvYcCWHaodBkOb5bd/fr85zEpSDlhwPndyigy+BvLkifRj01LT0+qOeTupSqd37MsQ3YFOfffseWUb2n8gDm14=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbFUzmxm84tAk2+aI0MKf2pS6TKJcHtDxlMjeT0EtvPSiOINfJ
	UimZYcxHTeNoCbB0ObURRBCKCFv6yiBfe+nY+h8ejZpNwrYaJZeEBdtZwgqnX3c=
X-Gm-Gg: ASbGncuM6z4mBEZAUItJumziLqR26iWeg5HJALbz6SvbT0Yt5bvqJjHRtntR47gdT+c
	V8QgGtuJs9M89lLpkOGhcI0SPnj9eW6LofvG6Cx90fnEzV+e1JKDbyklNpPhQvkDKqi5jULMEEZ
	1y6+8IYH2fDdgo0qP9/9aU3LOPkl8ZBp1yhU+lDSh7kSksHXqkIK/XTTeEQZN6d1oRycRY+nWXR
	ltWqdcNC/Mc3nO1eX+tQd09qC0rWkap5n1js6bqBRORyoHzZdgAaTtvSNZ/lJ7tePNBkLn8dF1e
	QGIfzb02xoXuDb18Z+U+bo3ieL6Lgw==
X-Google-Smtp-Source: AGHT+IECpo32ALWrFa1cNaiDX3uH6CqXkFCNWGuhJmwvZ0p1RSpM7dQPjKfV2CnvU0hTwmPQDg65lg==
X-Received: by 2002:a05:6000:2a4:b0:38f:2990:c074 with SMTP id ffacd0b85a97d-390ec7cfe62mr4082089f8f.16.1740751168393;
        Fri, 28 Feb 2025 05:59:28 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485df22sm5389786f8f.97.2025.02.28.05.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 05:59:28 -0800 (PST)
Message-ID: <e355ce38815760e69f40ec6d9d27fb6cab8f9894.camel@linaro.org>
Subject: Re: [PATCH v2 3/6] dt-bindings: mfd: add max77759 binding
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski	 <brgl@bgdev.pl>, Srinivas
 Kandagatla <srinivas.kandagatla@linaro.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Peter Griffin	
 <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, Will
 McVicker <willmcvicker@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org, 	linux-hardening@vger.kernel.org
Date: Fri, 28 Feb 2025 13:59:26 +0000
In-Reply-To: <CAL_JsqK-_rPZqt_vRv75dSWDLUAyZ-LB=qz5J=Kse=7bO4q8sA@mail.gmail.com>
References: <20250226-max77759-mfd-v2-0-a65ebe2bc0a9@linaro.org>
	 <20250226-max77759-mfd-v2-3-a65ebe2bc0a9@linaro.org>
	 <20250227130451.GA1783593-robh@kernel.org>
	 <503e105b71fa4271f40a2d3ca18ba13ed7d45a65.camel@linaro.org>
	 <CAL_JsqK-_rPZqt_vRv75dSWDLUAyZ-LB=qz5J=Kse=7bO4q8sA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-02-28 at 07:01 -0600, Rob Herring wrote:
> On Thu, Feb 27, 2025 at 7:14=E2=80=AFAM Andr=C3=A9 Draszik <andre.draszik=
@linaro.org> wrote:
> >=20
> > On Thu, 2025-02-27 at 07:04 -0600, Rob Herring wrote:
> > >
> > >=20
> > > Why do you have GPIO properties here and in the child node? Either wo=
uld
> > > be valid, but both probably not. Putting them here is actually
> > > preferred.
> >=20
> > That's an oversight, I meant to put them into the child only, not here,
> > since the child is the one providing the gpio functionality.
> >=20
> > What's the reason to have it preferred inside this parent node?
>=20
> It really depends whether the GPIO block is a separate sub-block which
> is going to get reused or has its own resources or not. It's the same
> thing in system controllers which are often just a collection of
> leftover control bits.
>=20
> We just don't want child nodes created just for the ease of
> instantiating drivers in Linux. While it's nice if drivers and nodes
> are 1 to 1, but that's specific to an OS.
>=20
> You already need other child nodes here, so I don't care too much in this=
 case.

Thanks Rob for taking the time and for the explanation! I'll keep
that in mind for the future.

Cheers,
Andre'



