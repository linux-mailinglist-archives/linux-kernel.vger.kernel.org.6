Return-Path: <linux-kernel+bounces-385002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D86B9B3143
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E062B2199C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4031DA309;
	Mon, 28 Oct 2024 13:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EgDsCNGp"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA22D1E48A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730120585; cv=none; b=g5oby5F/WlPS4OF+0a24J5lntynQRttP1E5SrQP0PAJGW7lvhagA7/AlDbCvpqKq7349K6FGGdcLQbDh8noI0IEfTWvOZtcbShOmaopwMD02EtrLQnPTEN80AEPOVoCu1hUIu/zAkKiIgw9eZlLWqqV03ihLLzoPA3Uh8KY9Qnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730120585; c=relaxed/simple;
	bh=ES/3wWXe3XmsnopHzfvpLs3+vjaLgh8prmQvw49/8v0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j0d2RAA6zXwWjUp6x8LdkZchuVHtASXEYUkVeUmJOW86vFYOA+NGQr627qxMWRv8OKcU9LMa/v2ZUcMArXUY+iyi0vuBPlH3U8uwdSBwdPEnQmpFeDVjlcKnstdX5eBDoFBk5kObDP1C1uwRgRv2VM2dKbmkKtYU7AR8SrpRCWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EgDsCNGp; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb498a92f6so40525091fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 06:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730120581; x=1730725381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ES/3wWXe3XmsnopHzfvpLs3+vjaLgh8prmQvw49/8v0=;
        b=EgDsCNGpBjySucdhf6url5lcqY2VvsJ1tjrlcuF3ZHgV7J9DvH07ylSxxO7rt75I4x
         9u4WYPNT+DpIO2IEyieH1mfwH5zksYXtXuepLqr7/246enqv/DlsfZWl+2rU3zOSmtGZ
         ANppRYoyuJcvMM6AoDxNHOGLbJeH+9SMfTsQ1qCV6DJ9HQ6lFWrPI7pQ2DTZ8KoKrMVu
         KjaHteNmF5hB5KihUbMPegFB0vnOvnIyOMw87kVLFFLIJZzAPr2ci16I1W5cITZ+RDDk
         e4XZEbvr3HsjQTI80n9dBxNvC4Rj7WpSHkeeeBaKjniWJzutouvv0JY5upE/6vHQH5QF
         i3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730120581; x=1730725381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ES/3wWXe3XmsnopHzfvpLs3+vjaLgh8prmQvw49/8v0=;
        b=iZKxtjEjZswSidOKQha0kiDbmoegqArt1vmGZ+zSuygzaRHPgXYfVEGpbuyaAwuQA/
         RHlPS7a/+aUzz3BckEV/gfevSIzi3EIsQOgK79CtaNbVjJcy8k81X5ZCnStnxNHSm6qK
         FAuuieQBisZ0+zTn25cAIQL1IeoxbOetGs/K+pvx7QCRQgPJe5YbHpHBWwY8xX6VbQDx
         myd+N8RM6QPqoZglR235R5hvtoIPKgVxbGl3mwGSPWL8229NvJN1tuQKv+8SLHIpjKlR
         XwxZhq5M4buxJBJYbRouiOL4iPRbN0ZekN7b8f8zp8K2HW7Z0jk6o80feQxkhwQJd+bX
         ay0w==
X-Forwarded-Encrypted: i=1; AJvYcCWo0/TmDakpbq0ifAUORcoc5cWUSae2dIca6yw+MquBjpEPG7xXAbAEtK29KDToBBedGFGR4Cs49tFzrJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw07WW5JkNugblRBjPM8hKqJ/Hbw9aHxbOwoL11SzxLymxgtlkJ
	uC6u0/Z0ltoGXXz/wo36zj4UpqxbDwqAu3siYjvCGlTYZPTwVwARztiBzWScTuU0UP1YRmraSXJ
	W+yAlPcnI8L0djEilZfyJNQYMoT8ee/hZkw7e3w==
X-Google-Smtp-Source: AGHT+IFQ2jWEabuLAHBA+snc2ktNpVjAxzzLMDX3og/hhpyaDNPJZ85//6hlPCUzYqpOHfjsDrUMI74wo85pww9rYsA=
X-Received: by 2002:a2e:381a:0:b0:2fb:3c16:a44a with SMTP id
 38308e7fff4ca-2fcbdfd85b8mr27232701fa.19.1730120580778; Mon, 28 Oct 2024
 06:03:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024064356.865055-1-inochiama@gmail.com> <20241024064356.865055-3-inochiama@gmail.com>
In-Reply-To: <20241024064356.865055-3-inochiama@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 28 Oct 2024 14:02:49 +0100
Message-ID: <CACRpkdbUs1eWgZCvxNYqpnUox2=4nwewBi5YPqSBO8UDhikyLA@mail.gmail.com>
Subject: Re: [PATCH 2/3] pinctrl: sophgo: add support for SG2042 SoC
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Chen Wang <unicorn_wang@outlook.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Inochi Amaoto <inochiama@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Yixun Lan <dlan@gentoo.org>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 8:44=E2=80=AFAM Inochi Amaoto <inochiama@gmail.com>=
 wrote:

> Add base driver for SG2042 SoC and pin definition.
>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

This driver is clearly duplicating a ton of code from pinctrl-cv18xx.c.

We have no interest in having to fix bugs in two places.

Please factor out the common code and use the same code
in the new driver if you can't make the new driver a simple
subdriver och pinctrl-cv18xx.c.

Yours,
Linus Walleij

