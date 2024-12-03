Return-Path: <linux-kernel+bounces-430180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 228589E2D5C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07E71670D8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A7A207A07;
	Tue,  3 Dec 2024 20:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="WEJrD98M"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBA4189F56
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 20:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733258401; cv=none; b=Wgh3QVoAiCO6G1djV3kQI3Jkxcp12JxnsEheGXNneLMPrDlIjgiW/sSevyeL+Uf/kt5LIwnSyUWPuJr/CB8ulULNKgLImoDuwBDyH59wtpHnQYskfal5UA71kdZjXL4GMBrOKRGRgf4vCUa/fNhm2WZxuZVC2s4XM3/lDoupK9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733258401; c=relaxed/simple;
	bh=oGoSypF6Nb9qJ7rrwxSTT3DF21fkJ5FrknVtmVX7pUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SvnEXw340zsLWnrnZCzGvFVXFiah/lK5gdnPwIzpI0ESdmcH4AVpZxwxeqmzk1X+zYlm8+wFv7vQKHM6lvqRR7JG+UJ0rKrMNroDHk/X7aLWRLgetxQynJ9KepXBHxqLlbQuptxJI93bc7ycrHv7A1UBph3xIPfkwrFnFUkwPN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=WEJrD98M; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53de035ea13so6168980e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 12:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733258398; x=1733863198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGoSypF6Nb9qJ7rrwxSTT3DF21fkJ5FrknVtmVX7pUg=;
        b=WEJrD98MrzvxFAI0/0QJ4+9fmwYrgmGJSzu8lc0EtlmhbsfOQNC8Z/jivFQSPgJuZa
         fP7tyRiCnBDxzIPhQNs+f+SLsss22qIDAWhXnNHWdI/JXFhNiP7AMywEqn5veU5IZy7K
         j6VEiAwfpAGczd+jRTxkLimg4CLn0iAkVIkuTxAdm3T8OFxD8yP54jq5kovLDz8Fiw4G
         3k/rivSEDqqNeAzqouKJLvnTYVoqOz3xIgQeuYeTIEzqVHGbMfObmVbWAAOrZOQtXo7u
         ldvff4jv/YPiHihNTHGXnTKvPjwIV8FWy3obqC9+tXwGMKrDxt2i1NXbcpzEh8J4bYW3
         GCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733258398; x=1733863198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGoSypF6Nb9qJ7rrwxSTT3DF21fkJ5FrknVtmVX7pUg=;
        b=p70GEJfSHs5i57Z+w36mgrWkAxPvM3W2UZsVU5/tIQbwqDfqR1nWlCd4YkEZKCG7kW
         FMemziqiukDdw9FPctH9FLwoScuwUJZI8T3HjA1rq4RfcDJMUD+ufBTsyULhrmXtNHR3
         POz0OiWwDOFgWDR8lEMacRyvd6gvSUWMJZw46orRXv0SSd8RFOSJvmRYNaEj8zquEMfD
         iLaGz48lXkzppb9hi1ffDrkP1wFftBsk/Mo3MdOU2uDoZwqbeTJsHA7D+iA+sxGo7m2I
         J0oHy+O19aflK3QN0p7L7jv4tJLt5LOPE/DCrn8aKA7Goh24paPFW0frFrvj+OnXL4j3
         sLag==
X-Forwarded-Encrypted: i=1; AJvYcCX9G9RmZvpg86huci0OrbZgVI2P8RZIO90CoJQEvIzipx7kteHcQzJQNWiQ0Y6ThfALfaTJCuzXjlfbWl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH2VLcLb7aQK5mWa9Z2ml7WjISDRr5JM+B5BEchvB1M4QU4MY+
	kQArnDm+njDku7Bhv5MXNtdlB3Ir/FGx/N0YRHjx3QRgvniK7iUL3NDsAsANImS1FZ3uWkOAbLL
	AUz4fhMdfjeWzAjHQbO3N4Eak2rvsQVPHMRwKCQ==
X-Gm-Gg: ASbGncveYpvq1cLG/5g2ANv8iHVK/AoAjAv97zJwG20EyC5XKLBqSuBRItCqBSq4qFQ
	yLISVugtRgVZtzjPYS7su8C70XWDsV6g=
X-Google-Smtp-Source: AGHT+IHs2kOoD67qnZoGYzGcGvII8H8UKDPSFKPhN1JA8u+CpxL+jZyLKT7Qu/Y07T3Md+eJ+XvBG6AUCbksUWPiZUI=
X-Received: by 2002:ac2:5ed1:0:b0:53e:12a6:af08 with SMTP id
 2adb3069b0e04-53e12a6af7amr1577595e87.12.1733258398039; Tue, 03 Dec 2024
 12:39:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-crypto-qce-refactor-v1-0-c5901d2dd45c@linaro.org>
 <20241203-crypto-qce-refactor-v1-4-c5901d2dd45c@linaro.org> <Z09OX3vnMC8bB6LG@linaro.org>
In-Reply-To: <Z09OX3vnMC8bB6LG@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 3 Dec 2024 21:39:47 +0100
Message-ID: <CAMRc=MeMK-=-qk+tmKpJXk7v-wCA4ZG1rMPH2NThp0stveSBjg@mail.gmail.com>
Subject: Re: [PATCH 4/9] crypto: qce - shrink code with devres clk helpers
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Thara Gopinath <thara.gopinath@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Stanimir Varbanov <svarbanov@mm-sol.com>, linux-crypto@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 7:32=E2=80=AFPM Stephan Gerhold
<stephan.gerhold@linaro.org> wrote:
>
> On Tue, Dec 03, 2024 at 10:19:32AM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Use devm_clk_get_optional_enabled() to avoid having to enable the clock=
s
> > separately as well as putting the clocks in error path and the remove()
> > callback.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> FWIW: Ideally, the driver shouldn't keep on the clock all the time in
> the first place, since this will prevent reaching deeper low power
> states. So while this cleanup is nice, I think it will have to be
> reverted again once someone fixes that.
>
> If you're working on refactoring this rarely cared for driver, is there
> any chance you could add some form of runtime PM while you're at it? :-)
>

Sure, I will most likely be doing more work on this in the future, I
can think about it. This patch was about code shrink, not functional
changes so I prefer to keep it as is.

Bart

