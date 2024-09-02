Return-Path: <linux-kernel+bounces-311270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A699686F1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89508285606
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDCA1DAC51;
	Mon,  2 Sep 2024 12:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="JDkJHJrz"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0625E142651
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 12:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725278654; cv=none; b=rJHeNrBP188ko0GaAor+NjtqnJ29LBAVbjGHTLDy3dninUzdcJYnrf1EVkV1KslrjlZedDJQVLUB8X4BBZghP5R24SBPMla+x5UbfvqbDU8ZpXJFeOnYVahsb6+L3qM+5KGOA9tjBh/KW3NBjMu7A+APRioxgWv7QdeGHveWXEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725278654; c=relaxed/simple;
	bh=aJwqbTQI9DGIgXVMitmiF8X8rBG4gd6JRzjG03U7FHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lrw2uR2kDPllfqPsAGNJ/AdG2VvnwPWcbI+uVwiqJQcAgig8IweWSoqMsU5J9BlLaFOHNn+pIkDFLvj3YYfkXEjL+nXQCV7ko5TROF7xtYMdQPPbcKzN3fiM2ze3Xggx8fnANPfCldMKhopHHZIyUrw+hGFKt5/DRGMXZxY6pZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=JDkJHJrz; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-533496017f8so5524058e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 05:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725278651; x=1725883451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfeUtZ6B5pDlVbEaBzbzexWcTj0QriXatTBO8FS0nAo=;
        b=JDkJHJrzrkq1UzrEB3HQsWtgiWg8xFwm8kJ8FqjwOcHWZP9yD+cmTdF181qeCUZwmG
         fPNyvHfoe1hJnNc1sPN2vhAmPtKJD9nk932onKmSsDcx/5UR/L3HOuK27KHBD7bjcnUR
         G+UFPU135oEmrRS71ULCgYnd1xrXuXysu4eRgXbkN4KL8Q3r4qSoJOgrlJuhmTJm7FTv
         b7g7UyROMF+BDqqNEwAgNWpyRLRT8c6qw/Z48l14aZd3wF7kldx/tOFboS89GCXZq8/L
         zPIZvY02NwlbruOYtEtqkwk8f0/6XlugOzEyFSfRUCtluE+5vA1fCuN+tH8Wr6SIZFOx
         4hwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725278651; x=1725883451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RfeUtZ6B5pDlVbEaBzbzexWcTj0QriXatTBO8FS0nAo=;
        b=BIUdWXIL7gljWEVzDd5iDeR+Vfi52Ku9eQ5StUPZvXZ8WbbXKvBpn82xAu1AY5ASg4
         PeyBBijnkDIwVPwxnazU6piLRxLNS05+16zPx5D8VviOO+RO0nGncsWj7mBuDLvHiZnr
         KHO/u+wPHkLoxeU36NV67JsrFVkMdUOV3KNiBv2k7rzHLAEFHIyk5dbSFOaIuTQMxwCT
         T7yp0mVmuSyYIEd3JbNAa0G6lil9jVQ4DCLyIBKZJs4hXRrPzpVqli33S7Q6MI8oSqsd
         PlTxcZk7AmtfbOdcRgYTYgubaVHzdt9lrv/j5sfnL4lJU88AERYp9eihzlhC6H2eGvVR
         XKDA==
X-Forwarded-Encrypted: i=1; AJvYcCWygDSHqij/Mbdw1quyV/anMbjmJ/WAW+OXTvYxQdASDSjnl6tHspsc5TMjG/wDBxr3L+JITHsck2q6z6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoL+6GZFKlAMlgvjcw0OOGxzRJZDZtuogpbJQ/rlHA6PPT2XDx
	IRIz8XRPHj3RFBmQ9NHO1QrBqxqmzrRfugJcDXPBdQ9Z9Hl7f5P1P1bT91MVggE6UpXHrW4+qkY
	7uXnrb1jNQrYL9K4W2PAHFhHzI9iovdy1qYG5dw==
X-Google-Smtp-Source: AGHT+IGIZuTye8K4bzrJnnZAxLQdrPoKxySbuZgdViXBdZYXFrvBs/1ZBZ+OqX+qellnTsLL0xbkk/J6FCD02n0ANbM=
X-Received: by 2002:ac2:4c41:0:b0:533:4191:fa47 with SMTP id
 2adb3069b0e04-53546b69167mr5994649e87.47.1725278650402; Mon, 02 Sep 2024
 05:04:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826161850.74447-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240826161850.74447-1-krzysztof.kozlowski@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 2 Sep 2024 14:03:59 +0200
Message-ID: <CAMRc=McgbL5DCu2mr6oWERMQMFQU1Bm-1BkC+XR=-2fPXpOW4A@mail.gmail.com>
Subject: Re: [PATCH] gpio: kerneldoc fixes for excess members
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Andy Shevchenko <andy@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 6:18=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Drop kerneldoc descriptions of struct members which do not exist to fix
> W=3D1 warnings:
>
>   drivers/gpio/gpio-pch.c:101: warning: Excess struct member 'lock' descr=
iption in 'pch_gpio'
>   drivers/gpio/gpio-syscon.c:46: warning: Excess struct member 'compatibl=
e' description in 'syscon_gpio_data'
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

I have a different patch in my queue that addresses the syscon warning
already. Can you resend just the pch part?

Bart

