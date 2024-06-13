Return-Path: <linux-kernel+bounces-212826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C126A9066E2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6BA1F24231
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5844C13D898;
	Thu, 13 Jun 2024 08:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="luL7cXI2"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF83713D510
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267418; cv=none; b=LGv5SkYcWeG8cO69LQG98LdoEAvHKM62ygiTgod4QL801Iyy3qkeFXkkaBKHKpCX0zDhrzh4gya859dSoSC17M3Pd1mLl8lPcIeRthbQLRwrGTaEbSZmMdngZC8WxaIv9P4dbb9ciKrFQdWpFTadR6RXcDtJxraYMnQzv7CRCGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267418; c=relaxed/simple;
	bh=zam1WrTcB2a6hkMQ4oXaEjlytSYEYESNLp+E26hWmRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Y1JGqt6MTflO5FJr0IXDlh9J+K+PeegVh8j28MA1z06CW8t2aPGr1fpdcev8PY37XFhWOLMARdnqF1K6/H+IAoSx5XlIRys+hDx7xPnSGCasmnm6mEfYM+lkLMbvy6LAxbakuYFDlHVGzVinQhnSlb9nCANsCxHoBTk5P6B/oek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=luL7cXI2; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ebd95f136bso7614461fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 01:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718267415; x=1718872215; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zam1WrTcB2a6hkMQ4oXaEjlytSYEYESNLp+E26hWmRs=;
        b=luL7cXI2uXReVUpyONbENCMEi7I9yoLTix+iLnOkFpkrA/V4JUuAuSoDMGTWH1Wy8N
         PXxa3LAa/kbSSZny2qmZ0mOJ/365zW4j+kBDKYhrfKvYdnLOAquY1TeRvlck0TZIEEvd
         914TUsc+Yo+49WfyOo8o9uJDDa4P4ICEIPf6viBYg8XEJlqB9B7uz9b1IFEAuOw9NP8s
         XYbCuPk9LtLmsYJxr1Zptm5KYjUbdL7ygzSLDedtaYLEvozmj/tnui8sORAT/7oJDapz
         1Vp9IwKJkqnyKUzP9MT6v1sTZOfcukL9+XkROz6xIBXj0u96Ui3z/5LG4NLzuiMpZnI2
         ZFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718267415; x=1718872215;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zam1WrTcB2a6hkMQ4oXaEjlytSYEYESNLp+E26hWmRs=;
        b=Bv6Oq8O9CiZvA2s9otREfqx9UYp16bJRavhWQbN5p+9Mtjd07399RPweeljnvnev0e
         YBGBhEqskfEpDAH/tXAcKHaD/JLeb4pGIpPKtN6Odwyoy+PDUFG+ZDsrItBkOhxgJFrQ
         SAdLcjzePYjv/exoFMblm3mKRYMBE6k6kyJk9KWd9aPIaVGvSgFIVMyQ2Rx9iO0leOdp
         Vr9wBrSWCRsxqgzrukohcyCvrfrH8wwq9hximjUjuM/w5Do9eSXVa4Al6+Hu1aNEvu5n
         2GUx2kjpChncnV+gOpjD9lqgjEZAFFaZKmydJvVVXd21qRCfzh11fuEQ/pIaKO53W3EQ
         NAVA==
X-Forwarded-Encrypted: i=1; AJvYcCVQS1RHkARcp/hAo2CfyjtSbUOQbZmPhviksrkzsUAopMnZKRCwYir7WxNQlgV1djis0Vxebu7s7aBbXkRJt0NjxSAgwBNese6EYHXZ
X-Gm-Message-State: AOJu0YyCQuf2wUqVat1LN+MoFfMsyjOW8Obb6jBruARhxe7s22nqgfHX
	0skI4pBzz7veR5CQoqw2EH0M6Awngsqy2c1/I0G/q83YkM5Lj5M6d29FKUA1ox4rRWdi2xFkexX
	7mpZmuOO8QvonVxsNqPhH4rDRqC/il0uzqhGdk0LDpOFRuxlxUW8=
X-Google-Smtp-Source: AGHT+IF9f/c3s4Qe7ACe43UALugVI7gRig0w/mlgAWUWAzqd6KqBUe7rTJtYZn5+66dcrw87a/NrWnfZ6ZkrDnaAHOg=
X-Received: by 2002:a2e:9185:0:b0:2eb:e542:cab0 with SMTP id
 38308e7fff4ca-2ebfc9d020cmr22506241fa.14.1718267415106; Thu, 13 Jun 2024
 01:30:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610112700.80819-1-wsa+renesas@sang-engineering.com>
 <20240610112700.80819-2-wsa+renesas@sang-engineering.com> <CAMRc=MfZ11U+kAh1+K=DxtJ=QL+cY7Q_sBN4sQDF-RNgjpV0QA@mail.gmail.com>
 <jvnvx7a4pn6evrp5ehfrt4qsiuprq6ogvrue2a3uupwtydmgcm@2rvat7ibvgb4>
In-Reply-To: <jvnvx7a4pn6evrp5ehfrt4qsiuprq6ogvrue2a3uupwtydmgcm@2rvat7ibvgb4>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 13 Jun 2024 10:30:03 +0200
Message-ID: <CACRpkdYYy_0QnzO-qPusYPFK2qFs=NG-t-X=GRjLg5DHX_k82w@mail.gmail.com>
Subject: Re: [PATCH v9 1/1] gpio: add sloppy logic analyzer using polling
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	linux-renesas-soc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Linus Walleij <linus.walleij@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 6:03=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:

> [Bart]
> > I really dislike drivers being called in an ambiguous way like
> > "simple" or - in this case "sloppy". I understand why it is - in fact
> > - sloppy but can we call it anything else? Like
> > "gpio-logic-analyzer.c"?
>
> Sure, we can if you prefer. I named it like this to make the limitations
> super-clear. And even with that in place, I still got a private email
> where someone wanted to build a 400MHz-RPi-based logic analyzer device
> with it. Which would not only have the latency problems, but also
> likely have a max sampling speed of whopping 400kHz.

What about "gpio-low-fidelity-logic-analyzer.c"

(+/- Kconfig etc adjusted accordingly)

It says what it is, not really sloppy but really low-fi.

Yours,
Linus Walleij

