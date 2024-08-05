Return-Path: <linux-kernel+bounces-274343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0170F947701
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB2531F21B66
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1061F14D2B3;
	Mon,  5 Aug 2024 08:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j6h4JZBB"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB84B143738
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 08:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722845721; cv=none; b=pm4F7eFPrVFPVI3GQ1V7Tse1yu1bFi+UZnYnN6GeJ/G7Vsa4H0HO10VqniYrJDUl4y2aHejwbVWuEhQKm/CymZj+83qogMRzWAXs1Q9wpMO4ff48P5fjqa1y8AQkdfXWh2pX4vo1v7tPdXn1pMMhShToy6P4pKa+MiEGmA7ANC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722845721; c=relaxed/simple;
	bh=02dJS4qXgZ7UM0o8jJd4oCrkx+dEUwHVR2zreAtWCsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WX51RjfxFiZzqDBv38sldlUBXRXINGncU0bCqkh38eoLIY3FTxV4owK7y0WWX9Okb5y80NVbO7n+jaMuLSPYk1JM+xLReXIKz/ypNBDChUnmrp+zoUjs73ynOxXWKgWNn3hQxGcL2l3uV5+RawbHB5diQd51fIkGTlhZBvWiulQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j6h4JZBB; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f01e9f53e3so148454081fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 01:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722845718; x=1723450518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02dJS4qXgZ7UM0o8jJd4oCrkx+dEUwHVR2zreAtWCsE=;
        b=j6h4JZBBTZI791iFUHjyI6jaX2iJSgP8AMdbLh1J6Mmy9QUviRi2+x7jRemilicTMF
         5PUKJCiCL3D/ZDZYDqOVBgh7WMW6XT7yRAjvNkwf1yiZ1poLC8Mll8M8+IMsB9RshxzC
         6yREv5mdcJNsHTEnDN9So/iks56AKLoILJ+cGAq9lm/bD0fPkkx1BwHl1/DZ7uwXztx8
         pQcblzxVkApqPD0JwnUJAD9e2cWCpDNZEaNu4coBxFGavlhcTvx9XAdW5dO+4pZ+n98G
         YLQGQ9tUGHv4pSJ8cQZ9eP8qSo7kY+wc9r273z8Zv6x4VmKBAON+b+L4tROi1a9PoUZk
         +CmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722845718; x=1723450518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02dJS4qXgZ7UM0o8jJd4oCrkx+dEUwHVR2zreAtWCsE=;
        b=NUEm316EV65DVVDZ8nWvp5m/NGsNsh42Rmk/aZCyzpgfFYU/4/uk2OH3EZGFN/ZiLh
         D8hMdgBqNQLgg3D4Eh5fTwYef1b8V3WQxyfRcAl42wp1jSXU0R8LJAvjTA1pd3hfwlKd
         fiyvaZIGWummBP/VFGAlENX9XKfEaRIiK0hJXRalfq72EcCr/TT1OjKIN77McZdnnMMm
         oE1ahVzcQgGHEXx0Jl1uH4VI9y1+gCw5Yot7LLblNzBnmVMfRrA9D0hiFpFCUt1sEO+B
         vQdvRrvI/iaEIzHVlpF31zmUw9BfFjvhX7IDhQaFl0PiHA8XhRuPNr++H7BRa+5UcgP8
         NZAA==
X-Forwarded-Encrypted: i=1; AJvYcCWBe9J29gD/YQjOebqhbcv7KIfPyzyH3tOMeaFbQNZwvINTYDXBQSdS635p9lDvTI7dJpj1+A3/iMCefCGQC+J9vjCdsdTHmN3eB/US
X-Gm-Message-State: AOJu0YwVy1bJoJLbwq07QnWAsPJbKBeRM7j8C1dhdoLAR25WSxIA1qJe
	FHm1t6qCVzm/lfg1BUiT7nZ+1p7m5p4emi2DvreooLoSBdRATkEOyZ9iyJLH4uVuVJErVaMeng7
	xNYzUHXdAokGXFkobawpXkAw0CKH0Jkbh1zcC1g==
X-Google-Smtp-Source: AGHT+IHFE0asTojEFyFN1hGyYypB+vCuvfehldI0nMe6gLGypRXLEqVOtCDdu7pKwvSU2t+ghl8CRCYzleDZzngjytE=
X-Received: by 2002:a2e:320b:0:b0:2ef:28ed:1ff2 with SMTP id
 38308e7fff4ca-2f15aa88cb7mr87559091fa.9.1722845717523; Mon, 05 Aug 2024
 01:15:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZrAaHWNvaAfDlDfI@google.com>
In-Reply-To: <ZrAaHWNvaAfDlDfI@google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 5 Aug 2024 10:15:06 +0200
Message-ID: <CACRpkdbv63K=Lt2d27R0ar3pK854MUgd77NLR5Z5Z4AHoUrPSw@mail.gmail.com>
Subject: Re: [PATCH] Input: ilitek_ts_i2c - stop including gpio.h
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 2:17=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> The driver does not use legacy GPIO API, stop including this header.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

