Return-Path: <linux-kernel+bounces-216944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDF590A8F0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18824286C63
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF78190679;
	Mon, 17 Jun 2024 09:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cfiY+/ix"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD19374D9
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 09:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718614949; cv=none; b=V/XQm/+54fh4CXa7IkpfKXsjKsOSTjNbGQNYY/5sNqNupfkyAF2u3cPy7+NvurwQb2n9Lu2PgIT9WiLiyz/jk5TfS9xSJB/OJxFXiGi6i5FqZc85iCiXYf/fo7sjsg/pDQtsoCIRMVRuV/WzCpbOap5HdACeWh857D7oL60jUh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718614949; c=relaxed/simple;
	bh=1qnOahOGBH471qmFiN5a9Hm4ejehkHAVCb/42SLIrHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oeWC3iZIz6rPEaeMA8on5Iyl9iny/Pd1+Ey/GsT/VWcBr7ylom9bcGPrzEC9JiHpybaDF7k9xXl7ud+qHdJ2wC1bLYPLqHf6P6gAlLs2bZdQg6eFUnWKtIkTiUobsnfxhrKZwgxD+9hG4FWRnLoE4qi37En/5wvFfHUDN3LLiTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cfiY+/ix; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52c85a7f834so5342232e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 02:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718614946; x=1719219746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZKVXz9zFkYiCdmxjX5crpO8a9wB/5gYIUl8nRld108=;
        b=cfiY+/ixGJ+iQAdvoVwfqYlZJQlI5kQoCced6EYqKJ5ASiVL60wsk4NsuDg0mAF4pn
         OINwZ+nqcpjbl/UMpEOareooi9AwSvXDSCO4dUVYXU5KlTieod7LuSXtUbXdFWgDftjx
         46G1WFCD0g3PgMc2tCCPNlsLJNOqqwnOuiwb1DHX0D2ITV9dTl0onnwe/G8M/QezAHYo
         Kr4EIgDK5BRadyChTYGSk/snTgEm/SwH/6cRtU4WmjAgNbMdxDz6jAKWprXMvzss7cSo
         5sHvdczUdDPyuRHqsnyl8JqGM3Uxmr7NKJSfaFJ9mxWD5xt5Vmj8ueUYwlngtXd/7ZZ7
         JLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718614946; x=1719219746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZKVXz9zFkYiCdmxjX5crpO8a9wB/5gYIUl8nRld108=;
        b=ksqiHI9q6nMhb7YnA53jPBjRZTO9VYbdO4oMLM2BFVnfqM2Rlhl+r9hms0XPVrqkiY
         GesSnA4eSd3ddYNiOxOZfqjh7eHxZPwvz8rwNeSgJ9Kij+ywjGQzxN46NpBogQ98Odvo
         kuyepRChnRkxRLLk2JwDnK3mBa9Xflb8DHbWJRwZF+1ekDQ9/88AV8IRYTkOKDqdFo2D
         i4lukEsH19f5fvH4vhVIpeqUP42Xzgrjddk0+HzeW3orbulV4dpM/hnHqIQeS2mC4Rjf
         sTxc/uaojAlN7Wj4W1My3K4YOcvArnZTFyi3OqphG56Og2TgQbbaoJaxdKyBocMx2Jyi
         1TPA==
X-Forwarded-Encrypted: i=1; AJvYcCWOpkCKOR+kMBrwfkWbxLsz4QKzCcMAznTz105y+fEb9FI09swl/iK7Ab/M42WnOCN44g2FYWhjkgTBs29H7tHUZHMEMq6bLw3IC3Zi
X-Gm-Message-State: AOJu0YyajXiTGR1ZZ2/7lwUXr+gO3CoFiMyukw/lEtdSQ0KPpLKDAr8F
	BRMoh+vLbWNqXCgGreYSdd/9uZjFTJ8hSvH3xDtIJ/RvliGhQDiZcNNSC07MF5G7ydI7yh5z00/
	H4SgeYIdZU2mqMy49u1EPEjesAcADcMrbYYR6Zg==
X-Google-Smtp-Source: AGHT+IEDbmeeJPP/Lzk+VO4Yf74aqIdgheOGoGFca2Xhj3pvQTusqNkXyG4ZYxSQcu+BAqajvjPvlTSvRaLNcm3T7P0=
X-Received: by 2002:a05:6512:4015:b0:52c:b11a:bfb3 with SMTP id
 2adb3069b0e04-52cb11ac093mr4656348e87.57.1718614945752; Mon, 17 Jun 2024
 02:02:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <840152f9-d3bb-410e-8164-4c5043e1983e@moroto.mountain>
In-Reply-To: <840152f9-d3bb-410e-8164-4c5043e1983e@moroto.mountain>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 17 Jun 2024 11:02:14 +0200
Message-ID: <CACRpkdakxbw=A+ri56t=-AF1mr6Y711ouFRfPgPj=qrSfRtZ8w@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: nuvoton: ma35d1: Fix an IS_ERR() vs NULL check
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 12:43=E2=80=AFPM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:

> The fwnode_iomap() function doesn't return error pointers, it returns
> NULL.  It's the same as of_iomap() in that way.  Update the check
> accordingly.
>
> Fixes: ecc5bf868673 ("pinctrl: nuvoton: Add ma35d1 pinctrl and GPIO drive=
r")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Patch applied, thanks Dan!

Yours,
Linus Walleij

