Return-Path: <linux-kernel+bounces-219032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D64C490C909
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612B3282FB8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B94813C839;
	Tue, 18 Jun 2024 10:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CP9sJJbQ"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA6613BC31
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718705423; cv=none; b=EPZAzdvd3rjYTQs1N0W95xh+GJT/XOr6NMP/iNY5lfHmwo6uxY2e77emJQV0lUGxAx/L8vneZGAImN5PP0aioE5oY7djBRnmFBzr7xCtolKqS8rlS9h5YpzcMCY6NFvqB1cB2AL2P4VtTW+fCf89ps1weCUF09HP6nauUGlmFjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718705423; c=relaxed/simple;
	bh=rRdvEX8LeL4ZldtK1EB4UBDTGqjoriC0preu44uvUtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CXnSycsAftAj0tvPdE8DEfxYO6glrxdEcYjnaClY0oRjHt7kyLzSmqURPziOCHHcn09af2K1Iu2AzHq68jLjEHPdI3b3VdMHPOTjV2cY3LYWPCheaNLXwQA4+8h5RDalyqRvB9dOpOQkqg6h0sDqGzdoy8v2NzkDybRH/Ek0t+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CP9sJJbQ; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so92814871fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 03:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718705420; x=1719310220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rRdvEX8LeL4ZldtK1EB4UBDTGqjoriC0preu44uvUtI=;
        b=CP9sJJbQne0MhAmo8rOjgGTa5enpN80rBOj8n3vRjmNcJdpVbozJGzLV0xMWa/4xZP
         YtM2lFpE4C0WWRtju4kEOwznNnqCPeTTtkJtz7k9QyoznyG+1PUV6UQc0rzOAGusywvV
         AxmfI7vGlSsLx0zmxDq+kIb9Fd4BWM4CzV6ElJCX44z60/E4KNd98zmrPYELXheogE9y
         /GmXm0cJzGVRRv9bvBo/irnCcZTjrAtjMRS046a1qewokT5adVNYq+xlvMCBrSqexaiu
         we2cI00mLfzVuXXHgJgXlgFfZE8gG/j3H1sVlmFO7xEawxfywj4DDO32ngN11CrWwgzI
         P3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718705420; x=1719310220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rRdvEX8LeL4ZldtK1EB4UBDTGqjoriC0preu44uvUtI=;
        b=mt0Z9/asSL1i/oToUaxLLlksn9NoLkF/nxLjMfFkh5yMOukJDawVuFHAIPZWPAe0Df
         XazpFKZTrY49Fj+ukfYl4Ui4kklUWCDavYbDkNJGLgI7qLimVW/P7Hx2lZ+rCXPDQX3S
         EniwjfS8aRkgmx9/8H345oCH0pr8TmmkZmCit/RlH7cKAC18Ow2u1tEM/zb0rvkl5Vuo
         3Jby8g2oYlJJfhJwzSUgxtEPBN68JFxSIP5U5xIHYH4Mz8YGwoZIUVOLgd9eye0onwya
         i4zw3j2nBBpjtiRoGKU0n4FC9iOkf4+lQ+lHYdMUGaAHMs5P7T6XK1duOLE5yNdorZ1i
         IKvw==
X-Forwarded-Encrypted: i=1; AJvYcCXbeTToQi5hKwbaSJ7NLWa1tOg+DM8zBHRC3x3XMBqZig/T3rQLBR0WGN9X3fiIwxh1b9ImpGkDe11ZBBhC7SIeIrDHQlYGvC8xYVvl
X-Gm-Message-State: AOJu0Yxy9tUsOksULHCaDCoW6n0u4sYhymlGIE+bCwZxreQnfnxidI3A
	yetJ76abKdh/X3CaUzRX4uUReeyn/w7BBUhsq/nIz8Yk67NuI9H1GqmXlwY84nCIr++tz+pPvJ7
	ukbdqGYU+2ClJo+yiqK9pAsmPpRkKlgyriopu4A==
X-Google-Smtp-Source: AGHT+IF6Xt+V7qAkTNt3OUDshHfo309i5lYo8MHcybfwbujbr4eDujZIPADYU0a0RAObz82l0EeG0F+biFDYfMB+ZUk=
X-Received: by 2002:a05:6512:34d9:b0:52c:993d:b462 with SMTP id
 2adb3069b0e04-52ca6e6e25amr8100164e87.29.1718705418225; Tue, 18 Jun 2024
 03:10:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610074809.2180535-1-mwalle@kernel.org>
In-Reply-To: <20240610074809.2180535-1-mwalle@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 18 Jun 2024 12:10:07 +0200
Message-ID: <CACRpkdbXpcjUxbrMTmAmWgmMoCHR0dxvNzn4gSYfBjr83k4kAQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: winbond: fix w25q128 regression
To: Michael Walle <mwalle@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav <pratyush@kernel.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, e9hack <e9hack@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 9:48=E2=80=AFAM Michael Walle <mwalle@kernel.org> w=
rote:

> Commit 83e824a4a595 ("mtd: spi-nor: Correct flags for Winbond w25q128")
> removed the flags for non-SFDP devices. It was assumed that it wasn't in
> use anymore. This turned out to be wrong. Add the no_sfdp_flags as
> well as the size again.
>
> Reported-by: e9hack <e9hack@gmail.com>
> Fixes: 83e824a4a595 ("mtd: spi-nor: Correct flags for Winbond w25q128")
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
> Hartmut, Linus, could you please test it on your boards? Also, do
> you have a real name we should put in the Reported-by tag?

I'm unable to bring mainline Linux back up on this device, so sadly I can't
test it right now. But it sure looks fine to me:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

