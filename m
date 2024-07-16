Return-Path: <linux-kernel+bounces-253783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EB59326F4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA1C9285AAD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89C119AA7D;
	Tue, 16 Jul 2024 12:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8o1cY6Q"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54576145345;
	Tue, 16 Jul 2024 12:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721134474; cv=none; b=Fnf8EpJB3VIEXt4EWRm1+EqINqcTemI7+u4M9fnONaZhExcKG6nu5xlkIqv4UrTfFQaOKi2GJ43Opz8ho0sdaLcwvbe5GSRX/M82JzPTQ3lZBG5VYhAW7HYq4gx1Q/yOiJ+ebPk+gGNu2IZ6fnot5+J4Rr/GL0uHNYxAJWljKhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721134474; c=relaxed/simple;
	bh=w443Y11DSvLdjuKg9qpLGp5NVOHIdcdYJsD2BsPm4BA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XF+bXVpW2QD7YZy2nZNQam7gdXlfDjGVTiap33Sw+S0a44QQZpyAHQLKJyavarh0s8iIko4xT0n35PRkwjWN4oDXvGYZFitqvHZHC3CkzbYKnVw2ID2Joqkz/hZEJWXfct8g+6WZARIhvXKMXriW6TETJG7PaKqCJ+9jQE2JjQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8o1cY6Q; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52e954d7bd5so502928e87.2;
        Tue, 16 Jul 2024 05:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721134470; x=1721739270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w443Y11DSvLdjuKg9qpLGp5NVOHIdcdYJsD2BsPm4BA=;
        b=l8o1cY6Q+kHHe12nGttEXjjCTnJZcFDqII+WTm7NbiUnZwbdwdZxqomMnRA9h99LAq
         om52ehAtDxPVBf2NaB+KSY+ZlEtGm1kyVFgKDz4KrL0/+Mq/XIpIHtr0khBs8DReGxhR
         N/+Yalm7pRAe3inx8Yna+pN7rCV/wIrH/lxugWp0mOBdqTBKD/44eXKVRkNGPIlf+f6Z
         V9zEigT4ECCvFDCQwI5fhaCxbOZP1YoBM15RFXbWvli2GoH4FQ2xcapfasO/gj2G501l
         diAUoFOiyItu+YGhxKjdEtvzrDe5wdTzomF66ITHm/hSD9XsaNIpCQc0e8UStdttTfqD
         L3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721134470; x=1721739270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w443Y11DSvLdjuKg9qpLGp5NVOHIdcdYJsD2BsPm4BA=;
        b=JexbJZ1evlEZGYlTaQRK8mZO5X2805Iyv1wJZn/16oasICZ2RU7gH2OnXolVKgaRz8
         FfZTC+G80wl5gKaflsIN84oLEb68HKXc+89s6eHWR0MW1xE+a8H3QpC4X6WQxYgNr7LA
         N/+Nwi/1J2j5n6otNOy5t77Z8zSkLRfm/r59i5LswCdUCpdCQBY6rT9AhRC8D3x7Ukmw
         EJ4NsvNZ0Usu8+lnNeu4YB7bRrN8p4NrbOQJH88zxHam0PzgaKwjpq5bMSr5RkuvGO9a
         O+J7/yrpzqZ1+0oHa6U3eMe7dYUNoDu77Jji6K2VgyRab3HRmRe4TU0IbOyCPlblVvlB
         Dnqw==
X-Forwarded-Encrypted: i=1; AJvYcCWB3uVuxOsjKMfw0QnGwR4FKKKZYG2PxwBxb1m4HSRf4FpCpYXxy47Shaq3bFCTC09OEkZeM1Fbri4HlAKSHvaiqn3sf9qaRhrZTTUgzGrMyXR9HMsGBg8j3z2CEu5r3gFzqqfwqhawJJXFluHkrrcdTXE3Q41qQN5WFjFpymDd6DO7MA==
X-Gm-Message-State: AOJu0YwvHaG27E01gLRZetj/yZTDhHNzRTzbPGkn0k7OeR7d9g3E63zH
	5YcqDUg7eCtrID/o4dOP++MOC4mnnO0FQNMbxNGRTcmYeGX0lWnLIwLTP0ayjv2tw5yt6sBaONF
	+OtDdl9PlVoZ5SOJF3/KA6n+N/rQ=
X-Google-Smtp-Source: AGHT+IG/vrVAKsY/0W0RBArGdtvKS4CIa8jX+XOvYmA8Zc1PfQP9HbEO8nW0OSq4gwRGiSV2PfZYdZTJA1TRv6MNPlg=
X-Received: by 2002:a05:6512:2381:b0:52e:7bb4:942d with SMTP id
 2adb3069b0e04-52ede18f4famr1143999e87.1.1721134470099; Tue, 16 Jul 2024
 05:54:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712-imx-se-if-v5-0-66a79903a872@nxp.com> <20240712-imx-se-if-v5-5-66a79903a872@nxp.com>
 <ZpGr6qKjJKz14J+y@lizhi-Precision-Tower-5810> <AM9PR04MB860496FEE467B7CC7C2DF50895A22@AM9PR04MB8604.eurprd04.prod.outlook.com>
In-Reply-To: <AM9PR04MB860496FEE467B7CC7C2DF50895A22@AM9PR04MB8604.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 16 Jul 2024 09:54:18 -0300
Message-ID: <CAOMZO5ChgVzfnh0COEbvDGKcmVPEjS83St0tRmKdhvKJDAt7xQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] firmware: imx: adds miscdev
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Frank Li <frank.li@nxp.com>, Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 1:50=E2=80=AFAM Pankaj Gupta <pankaj.gupta@nxp.com>=
 wrote:

> Thanks for the explanation, Frank.
> Will replace scope_guard with guard().

Please properly trim your replies to only the relevant context.

Keeping the full message makes it too hard to locate your reply within
such a big thread.

