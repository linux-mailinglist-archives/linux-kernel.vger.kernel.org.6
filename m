Return-Path: <linux-kernel+bounces-573311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37450A6D588
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1E861888B13
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 07:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8919F25C6ED;
	Mon, 24 Mar 2025 07:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CzwaaEbj"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F27250BEB
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 07:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742803002; cv=none; b=JNMNQ36rE7NCzqZeWdTdkwxzj+TkzmONG46iHyEdz6QKCFNOAMB8LE3dIcLo9cIoGgs2uvNF1kVQHpV4vSqCDC7n2P21xvDMOM5nwGBQ3vChiBl4WSSZec7cqQDVSvdniA8lPCYoHwktebgGBkmGtPwl27x7Sg0UzIdP9x/D0U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742803002; c=relaxed/simple;
	bh=OV9DY0EXmW6EdAj7X4o/XtYHW234XQJ0zlzRbGxadyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/yJ/amaMUBH4D1YIxEI9klSx2eqYJWGL5CeQ3OsgLn5c66hNwOQHjhEeAvPzyKnO0Os50HePDlGXjo8sH42sbPQoE73jxEbQK23nv+KYnZJUqBHL2yKddo4bA1w/vFpI4ShnIKXgIit+uIWUhblOQUwzM1aYJ/H2KnSOZ/OEAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CzwaaEbj; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5499c8fa0f3so4846173e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 00:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742802998; x=1743407798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6j0OP1AKco8P+xjWS2Kr+J9Jp7K5JlZpKB0Y8PSLBoU=;
        b=CzwaaEbjTn76J2JHWpni6YdGDhRua4cFDti+uYaqIdvSnqO0wIVOnv6F84q5MHA3Gl
         wdN7BD8iZXU09atVFa+nJesYnYx224sH6LRpvT0P+5rVKSHbHhYxyMBMO0ml5fzKyfyZ
         TeRchu1teFReZPPtJ1kkY6fMhdPxGt8OeBWEYVrX/PEEu/1b/ycxeF41lLgwpvBFFFLA
         5PoDEBQ+nMdafhI5mqbiJPMZK5z5STVbNsYqulr/LSCv6ZcvleWDWpXm4Cov9ed2jgvA
         b12wCnrfT1vkOfSV7L9BoTSYpnylPwLPM+aTNDNaCDL0mAPisME2Qe0F+TNJ7MVMOva+
         V7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742802998; x=1743407798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6j0OP1AKco8P+xjWS2Kr+J9Jp7K5JlZpKB0Y8PSLBoU=;
        b=moMQ5ue8mABR4ikkqg57/8+h5/pi66OlXXgFUEwRFh07cXaxxdAPjjwot6y1txu7BI
         KjJaZrkd+vzlPfb9dv9EPa568RUCEG976qGweGFwO9+Wmw4eH69riYtoTmyFG0D0u86w
         ZHHqqR6XXcv59PNUAPhhjtP0rnXMM+HIzSFTlEiqMxEUOXJLMjHbkQzDuHIiP41GobVm
         VYGqejKd+im9ezLANLj6qF0ilheU1ecqyc0hmg6QwCUpTG/m/iw1qXshEgJgpGqrhvJ7
         PIz5chlxvgRvWVx1QhpUXwaGkBIiBJ483b1HWt71/MGEeztkKwRIEJ1J2VsCH811Iph8
         4x5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUizjCUhZ0m8wGJ00dRoAGHJBfGKdvdcRJx+N3FO4ShCU8uzip+GDzb49tp8FoKdNkaEnG9TFNHljbKnJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7XCraZ2EYviRiTGz73IHBlY3CmudyQkrD7aD0clLHiBlJOyM7
	IVzYlX1htwuQyORlnolMuLByEAb7w73I33VFXy/BstcvwvhK8Ku0uqLiAfsFJwUF5+MfQlK2zdi
	bXTWUA6kkNaqMgsg8zIdHBPTZdpFeUk9ss/7uffOO3wgky2Zq
X-Gm-Gg: ASbGncudRqnYNV62UIUkbMxaOflTpQ1zBfNEzCncWJI0zRofAn4roiFeKFrPiod4px1
	ZyWKE0XljAZApaM98ahxzWbLlOT0vvjiNufMlvVL60W0a3r14FyjkLJch4a4dRtc4HLA6ipvXGm
	Ig8lFy0nFJfzcYMWtQ1s4VXXs=
X-Google-Smtp-Source: AGHT+IFtr+BxDWvLi7B8XvujijuE/uusgz+e1CxANxOUbWAMxr/DRbOjGsjgANjwrNpVsOP4YonBUJzw5RqtjWsnyQA=
X-Received: by 2002:a05:6512:1107:b0:545:2efc:745d with SMTP id
 2adb3069b0e04-54ad650d03bmr3863290e87.46.1742802998153; Mon, 24 Mar 2025
 00:56:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324-wcd-gpiod-v1-0-27afa472e331@nxp.com> <20250324-wcd-gpiod-v1-2-27afa472e331@nxp.com>
 <CAKXuJqht5ZiFyt2uWXwPSEdszYQWKHm22+mAQCPQXn8b7AbL-w@mail.gmail.com>
 <PAXPR04MB8459D61091A8BF9ABD94DA7E88A42@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <CACRpkdZXG0JC7_-Mg6Dpq08Y=Kr3M+fRWQF_bPG8c-WH8pA9Mg@mail.gmail.com> <PAXPR04MB845940BF9775DE957FFC6A1388A42@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB845940BF9775DE957FFC6A1388A42@PAXPR04MB8459.eurprd04.prod.outlook.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 24 Mar 2025 08:56:27 +0100
X-Gm-Features: AQ5f1Jrr5fC1PCYSaOd3zNEeWMha7OQ85VJU6OPpL4AdSdkXmmU848HXGJYyJYw
Message-ID: <CACRpkdZ4eDeN_DepR31R9mgTVbQKgzJcmndss5x2iQfgOefNag@mail.gmail.com>
Subject: Re: [PATCH 2/3] ASoC: codec: wcd938x: Convert to GPIO descriptors
To: Peng Fan <peng.fan@nxp.com>
Cc: Steev Klimaszewski <steev@kali.org>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 8:53=E2=80=AFAM Peng Fan <peng.fan@nxp.com> wrote:

> > Maybe you can fold this into your patch if it helps. And if there are
> > more of the codecs with this problem, we need a similar patch in each
> > one of them.
>
> Thanks for your quick reply. I am thinking whether we need
> to force the polarity of remaining of_gpio users.
> Some old devices may not able to get tested,  and some
> may use firmware to publish DTS during runtime(such as Fedora,
> openSUSE using firmware based DT when doing System-Ready IR),
> so we are not sure whether using gpiod api break the platforms
> or not.

If we have an indication that this problem is common (let's wait
for Steev to confirm) we might have to add a small patch hunk like
my quirk to each patch to make sure we hammer down the
polarity of these codec reset lines any time they are used.

It's fairly straight forward, as you can see, and they are only compiled
in if strictly needed anyway.

Yours,
Linus Walleij

