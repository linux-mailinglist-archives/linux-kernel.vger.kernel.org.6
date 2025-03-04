Return-Path: <linux-kernel+bounces-543534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F905A4D6DB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587761886889
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C701FC0FE;
	Tue,  4 Mar 2025 08:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="acHnUO3D"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F110F1F4CA6
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077880; cv=none; b=KDtdHWaHIwY8Ixp6vMEuVJBu3hjnzec84jdP1O6MGvqBov9i+PJl1KhI5L27nGomf77FK7pgnGhR5J/2+dRVflT8X+UPAqqP3jEqWfPDus9D7J+l2FoU/I8kH53jlAprX+kHE0UcKYDKUjwwVuJX2w710T7c+jAHV7HNmDDS+90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077880; c=relaxed/simple;
	bh=dPMt8sQKcYcDHq3trJrxd+nQzsHylruteqNco7rulhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZojfU+4u2gJwQveABsgf7ciIeL4O4P2bkwhTCHSuJpS6J7YNI19AE3wQWv9gTi1y03XcmTnLdGy1fpTzaNdRT5D4b9cNjDdPYO591nbJrPrQ20Zv3bwKP1vV2CjtkKNwZWiV2PbH+8usnK1vE8yqCYc4Vxm1jX0SOUF+e32OOy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=acHnUO3D; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5439a6179a7so5547524e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 00:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741077876; x=1741682676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPMt8sQKcYcDHq3trJrxd+nQzsHylruteqNco7rulhE=;
        b=acHnUO3DNAApJzGhWaPZ4f0L4KJ7lPmfBgD0Ea0KWTCOiZbQ+u56qyvQfuEslTbTuB
         ZuXzS+Uwe99ZVopMDPVc82at8m5z/LG1X8weK48CO4HIH++ueURRcnBMK9YLl494gXfB
         He5j4irJvTxWuOI4ISzwXWUqqtrWpZ9YfdVB7Y7ARx3ZU60BRdkaRfWbLsRrTdi4Zg4V
         sv1JZCEPXPOnH8lvejfET0G7yWx1cYG0N+iq8Sb5Q1dvsK3+AcMIKA1iV5Mkjx7Yzhka
         E5CfZtFOByM99K8vwZ2hOm6gBjszbrEnJ10GsTBoA0QGl6aMi2lfqJxepG7y+401y7WY
         TvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741077876; x=1741682676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dPMt8sQKcYcDHq3trJrxd+nQzsHylruteqNco7rulhE=;
        b=U52HeUmewp6HxKxni5u1KhAQILqoOc4GNeF1RrDUZM5fzjzOV6KTonf2bFq6+4lAsP
         jTRaQtPjSsmBprM1BKQ5hDzFBAjnsmyhgIMfWDr8AgkNz6+YCgixRcCEGzZZI0dMZGDr
         C8cLv0puQSh447ABWX2aJsa09Tj7WKYFx65wsEyTamRU3gwJWa6hXcGnIEkT2ROHtPfE
         ypGXe5u/xeh7AKIhUUuHeqq8nmy3B/2MaD1LQiaO/3r6Xes5hhxFWBHn4D6FNnkAHr7O
         6emqb6gcjPyhB94rRYtJUbP2X1+5GCLWhbX9VKYS6yHe8ttcsA3EKJPnZ4YwOm0seaf4
         FtJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKUgvlMSXtZARdQpHYxpyBGHAuNRgAtWDwlTiEXwmJKM9yzeXY1Ru6LVc/EGUnTQMhOymruFndKFxY0bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKOceEqwL8B6lrWdpDnWR/mENgjwbzOI3TSe5CfkxJDUpzYpq8
	Q/EtdO0IR8GIWzMt/oYQCwLs9vMhX7kAEeXvRwniJGOz9Q8qpEQ5inLGhND7A1S/2GHv8gVsAW+
	nc9Mm8GEaiqycSH67Zfb6Zc+xvdQEEb8KPViEfA==
X-Gm-Gg: ASbGncugZRRMtiuMTfEUqrYoVJHVDC82s8YtguXVolQnSJ2Uj4iqT7MDUXLvVa+apCF
	LpCuX8X0w0gWuFbvKFYGbhyNs1KMNWhbCETI+bBISI+ZPtIGoDd/lzOlqKjOJjt5xG+FhZuHh0c
	Rhk0MJOINrrW6zcvS834ZN+Zhqyg==
X-Google-Smtp-Source: AGHT+IEsTpQ2JgQq73PIIi2BUjZ59IPNByHRdWpUpLhoM2TgmVIamV70BK0YXd/2ubvynp/Jd8VQltUyoga2R+pTrfk=
X-Received: by 2002:a05:6512:b08:b0:549:7394:2ccc with SMTP id
 2adb3069b0e04-549756e3ba1mr734501e87.26.1741077876026; Tue, 04 Mar 2025
 00:44:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303160341.1322640-1-andriy.shevchenko@linux.intel.com> <20250303160341.1322640-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250303160341.1322640-3-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 4 Mar 2025 09:44:25 +0100
X-Gm-Features: AQ5f1JrUf4BLulGkluVvHzVvboNuHrbtC58uLx38uifniKVu4XCC8IXPLns3EFk
Message-ID: <CACRpkdbhhJ0+8BYpajdCSHHZZAYO3bOpFd-XCUxpdZyGCpj4cw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] gpiolib: Rename gpio_set_debounce_timeout() to gpiod_do_set_debounce()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mika Westerberg <westeri@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 5:03=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> In order to reduce the 'gpio' namespace when operate over GPIO descriptor
> rename gpio_set_debounce_timeout() to gpiod_do_set_debounce().
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Fair enough,
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

