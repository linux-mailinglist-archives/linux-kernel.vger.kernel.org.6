Return-Path: <linux-kernel+bounces-178083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EFD8C4868
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 22:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AC701F2273A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 20:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769C680C04;
	Mon, 13 May 2024 20:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G7txJ1tW"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458FD1C69E
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 20:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715633264; cv=none; b=NQZEXddghhS6ukvpmMqxHfCBTLewr9z3BXmyXJSOTERy8bZSuPaXCoV1MRlvbZDIcZcq/Hoi0PQpViAcH7BrzWK6XH2EX3PJPpl8qSLHRB9n3qovd1rNDVhDdYsDpXSfyEsn3VwMlLdAbUEkEkt6aY8CtT/PYsQ7VwfYEs+aaus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715633264; c=relaxed/simple;
	bh=GZm3fkcMwLz/ZnV8chMXzznqP9rPpkmjWataUnyNo8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fsiDgd8nKWaAKvys55LWmuuPxDps/PR0CFYEqUVZD4g4f4DBrC+ivSC2ugtiHs230aVmdi/FN4O3gLuvpstbZsXBsKt+0AP0GSzZpkECq3iMSLZLN5eZ4YPNOYUnOp7gkTfrZvjtpLjaM66xdEU6RdkRtZhi2iTYnnvhXWcZ5g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G7txJ1tW; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-61bb219737dso53467157b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 13:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715633262; x=1716238062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZm3fkcMwLz/ZnV8chMXzznqP9rPpkmjWataUnyNo8k=;
        b=G7txJ1tWK82lbl81YLst5ln/oc7FFwLBuw+T5cyzFzcaVeH/HkTTyuhAzIQZA/Q6Bn
         CyVAQdSVSjwIbdRDWFFUTrOO2zJLh86gsaWTWKGkSsriNKm+/Yf+emYNz6slvRhy3d9U
         b1Q7Fz7zNuKDZe2Z060X/pIWpgsr8iHrLtthH0o9PtQDUKULyMLD1INqOP9VXSDhJNX0
         qNTyEk4/ILzWgF4ZW8CuO4DkqkoBjJSofOMul5FFLzhiq6q7M4lFlCQAUpyKo27Y1Wnn
         uxybMr37gypglsrh3H6qQwzG3xGTWDMFsK/zWPRPP0nSGQjYi+46xwzyOMiZM+byZzd4
         FemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715633262; x=1716238062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZm3fkcMwLz/ZnV8chMXzznqP9rPpkmjWataUnyNo8k=;
        b=mlGVLyoAklNiQknUbty4v1aom9f3LtaO9NNguIXIqd1kLkymJLrpfTzj9Ri2p4LZ8i
         0jGfiwiwxfyB3AQmHAnKQoImO1TW7ZN2vBLFo8TKBKGkYyUfEgSGd8hTQG+PL/K9iL65
         tP/IbZgG3My5phhjdeUB8jrhZYpnQAEwrbz1lUbEypBfwMt6UGDHATRg23vQSKa0ss3g
         aGk885p3noU8w7Jxtl19swE+7gQAi19F5dMqbc3CUK2ZSwF+jcUm55Cp7IYuW2eG659k
         hIik0IjBnXVIYzDNXelCc7CpfXgf68+J8VpBzxoKKTrOf9InaxTtVdV1+LH5DvnODMTq
         V7pA==
X-Forwarded-Encrypted: i=1; AJvYcCXuncpPWrD8Ek/wxi6GLew0hY/lNklOIIjkQyztsgIuPzFG+p1ABdmbkHtM+0nevvFfJ/cDbXKC++HaRBlMrgXH91X3RRi3F0A21LFZ
X-Gm-Message-State: AOJu0Yzy/YT7gmeh3N0xyglSkF2Hilmc05ana9ivwJCvZHaC3qgnpnhk
	ZpphuTTO0QTilywlcOK79XkMb0ZMABelgkA3O5iyxfyUu5oUOaBX9K0xOBtKRrkSq0arFRxm59g
	WbllnW0WTJTiJ3gqFHxZJwWWL/7JqdTWUh+ZJFQ==
X-Google-Smtp-Source: AGHT+IHiJK4UXMbjpkNNhNJofaQ8/QLH8T7GL3z9FkLVTsr59KRPwSUrWDBHmTJkSuIIAQLr58jw0z0C6ZaJpE71X0I=
X-Received: by 2002:a05:690c:386:b0:618:8900:8105 with SMTP id
 00721157ae682-622afd20f8emr131053067b3.0.1715633260299; Mon, 13 May 2024
 13:47:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510160534.2424281-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240510160534.2424281-1-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 May 2024 22:47:29 +0200
Message-ID: <CACRpkdb4g0UP5E_3sNPeOSJfVqSq5n_0NgmM=idKiz3G5j0yaQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: Show more info for interrupt only lines
 in debugfs
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 6:05=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Show more info for interrupt only lines in debugfs. It's useful
> to monitor the lines that have been never requested as GPIOs,
> but IRQs.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Excellent patch.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

