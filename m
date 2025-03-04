Return-Path: <linux-kernel+bounces-542936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA67A4CF9C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FF9D170C14
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B40879F5;
	Tue,  4 Mar 2025 00:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EqdAS/SX"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2FAEC4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 00:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741046636; cv=none; b=KVc4tWhOEyuEqp2S4wmcYpBvecxqmluaMWZxM3V+rxKZAWBVpLia9qi7a92eSdnGwkRa/PxSpWaDOolunPkA8383Ntiy+c9pYWNz94YUtkcJcKBUjG40eRFP8IMaFy1xhlx6dpUB+WLBi5wVIBy3TTKXxseVkN1xf99aIamBp+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741046636; c=relaxed/simple;
	bh=C/LfSpekGkcQBqzcVBoT+8ef+/NIGmgDTXMdDSp2KH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kZEybC0fujh8I1zmTJxOFi28aNp2DVrJrMJkY3L4OrEVYxmOrxvvws3oztYh8Zuj4wXoXHW5kHmHx6WawNIyDoqQuujMdfJL4k7a2d2qoIlLGyBJBmrTMBGqSRk/Vqy2A/EZe7wyyl72yWt7skEDSgDWDfHAccdbFGHx1bPfDgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EqdAS/SX; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30bb64a4060so14174001fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 16:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741046633; x=1741651433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/LfSpekGkcQBqzcVBoT+8ef+/NIGmgDTXMdDSp2KH0=;
        b=EqdAS/SX1cNZTPEopGRn/ftTbaYzlpkYYur946VDRWoj00RW3RDDO8j/ft3yZdOdth
         fwKkbezcExtBYnOFIGVBOnMpIdFg6pvId4WvJpni43+cy/ieXkBk7HZ7mUO/GKJzeacV
         3ilD14W0in27CViA/3KtXcrWyRxCa3IJ3CnWQ7z8Ln+HPa/UUxlXT4iU0ldPZ9gqdzE4
         kBdvGA5OkZcNmK77gZFYzyrSu8KDlMuX0Y0PZPdDG295qR4uS9LTPIUOjlO1jDVJO/4t
         2nHIv/3zuQjN1hLi/I6VDIte/+82buQbCgfGEofT4f6F8nOE1zw4pZOIAU4W9Or4i/kL
         Aw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741046633; x=1741651433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/LfSpekGkcQBqzcVBoT+8ef+/NIGmgDTXMdDSp2KH0=;
        b=cUTNNyZW2ITX7UnWr5ugPJC9W8/wwevUI6PLVM6sWUJsk69L+e+tIQYlmLd0Ji3Ejv
         sRb4mvdIikfY0W6vZbi7S30rIAlFk8xBphgTd+xjtP+v0NfhB3wtdF4Tb9OYyTVhPum7
         SiuixqERNufe7M+8GLOCEXAzmy4hjdp0FXhBiKzFeuBoe1usmeiY3OpKGpnWbj5EEVOC
         pO0w74MjeabVpNP+fpDIveBOK9hJAcGoXc8EzAKfk6EvX3vkocpTz77YpgxnYLfohmXK
         KYUqEAAp9e9eNivh00IaqJiorwTRIO6FgBE+LWKnNca9GAbf1th7UNMu36fhIHYx/fif
         a/hg==
X-Forwarded-Encrypted: i=1; AJvYcCWzsHmAgnupc2ouTblmvep/gGDg4rlP1SVXjqvlEycBRKKcmwjBsnvMKOY0zAhWN1orJhCTYJpeIVN3les=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT3NC1NJ7EKXRWDXcHSxprPqpMHK7B7ejV0ETTzHa0OUi8rm8a
	ki4N5TGcZELTdlrvbBlAp6KU6KA8J3wrWvVdH7fsR9m1k61DyQ1SCjqCO6ZskCmc0X59PFvOVgZ
	gv4mSygslj5k17IWUb7iVweYaQeq45slmQ5Rpdw==
X-Gm-Gg: ASbGncsqy9EcSxNmHxAmqCSa7WzTza7Cs94teZcxpphpxd9TkGEpZbOg34u5Wc+4BZI
	yR7Gxh0gmyHL5log7WHlJEI0H/Gi6+p1V4kdKRpNn57rVQQXpwG4z6AAeIMSByhlc1poCBwf857
	jP2L1NjpcEygAwLymsw4ZTBlcU7g==
X-Google-Smtp-Source: AGHT+IGrydCSg/lI1uzAKwGHugbQGvBBzjG9s3mdXfZC6EYIplaWRQ795GqrXmFtWsW5Su7ME7vIhfLoaVp40Qd8SR4=
X-Received: by 2002:a2e:be03:0:b0:309:1d7b:f027 with SMTP id
 38308e7fff4ca-30b9320f37bmr66066201fa.9.1741046632848; Mon, 03 Mar 2025
 16:03:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303164928.1466246-1-andriy.shevchenko@linux.intel.com>
 <20250303164928.1466246-4-andriy.shevchenko@linux.intel.com>
 <CACRpkdbCfhqRGOGrCgP-e3AnK_tmHX+eUpZKjitbfemzAXCcWg@mail.gmail.com> <Z8YThNku95-oPPNB@surfacebook.localdomain>
In-Reply-To: <Z8YThNku95-oPPNB@surfacebook.localdomain>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 4 Mar 2025 01:03:41 +0100
X-Gm-Features: AQ5f1Jpd0GEUB6MlVioV71j1v6rfMl3pu_k3_4FUFebcVwfwl0boXwZuTwUA1vQ
Message-ID: <CACRpkdbqYoY1vYGii1SyPL1mkULGXYX7vFwu+U9u2w9--EYAsQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] ieee802154: ca8210: Switch to using gpiod API
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, 
	Stefan Schmidt <stefan@datenfreihafen.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 9:39=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:

> > Maybe add a comment in the code that this is wrong and the
> > driver and DTS files should be fixed.
>
> Or maybe fix in the driver and schema and add a quirk to gpiolib-of.c?

Even better!

Yours,
Linus Walleij

