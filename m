Return-Path: <linux-kernel+bounces-543402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4E9A4D519
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A2A47A966F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF541FDA8E;
	Tue,  4 Mar 2025 07:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="keokISX1"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141321FE449
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 07:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741074016; cv=none; b=hMkN2xWnjHzVwe0sZw2/rRGLu6DxOheTlwN0SYOB7AjFMsenH+Z4vZcZh+dzANm0PXAGTwb4WeRU7CTgqgrIFLnomPauBi/I3BdbNIjvYDANJ0Bx5TxPSw7ovhgyUgqGZXboXyDkNiZuUbrJfdsWmoG7uUgzk7U7eHYV4QHiwJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741074016; c=relaxed/simple;
	bh=3T+luX8w3tRQBHenZr4Mib8LyLSph+Ibdvl/8KKqw98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G4hlPXg7fPwJonnBHPXApN0GAw68jN8bk1k3t7XLFGVoVpq+3V6WOVFBbCp6C1qMxCiZt2niRKsWaibN/1fliYFEY9ttefY04D+GWhak3S8e0wI26NFbDk+ucRj+RUvEnbwc7NBk5ES8foryebGbhw0q10eW+lvp6TcOP+Fmb2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=keokISX1; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-307bc125e2eso59692041fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 23:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741074012; x=1741678812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYa7EfywJTw6o3MYMu3IjFEnE/ok1aP+gt2n/HM5KmA=;
        b=keokISX1Zuf4x8H8C2osLFVu7Dn/xGzX3xfWoRPvcN9QNkYmnLsiUHA3/HZ5aOwHTf
         MwgXiFzFwwp+qDAeRahjBUuqtQVkNd5/9UgT7ahlGZahd7+UvF2hT7kQk/zQRg19TX0v
         IgTEpNcMkwEUIH4BaJANb/lQGN5AtRDeUo+35dP2IP7WpMFBXpqWiD3C05LF4vMFDZgc
         ktPohCl3kl9sjbTO08V0p8CIrl3rUJLYmBs0DGuWpmMwqqIBZPAXlrkmUVvBqYB25nhN
         0AJAmDlD6g2/tYkrWMVs32zeMpXEMtjeDES8NwiH3tziDcQvMMnwCoYsbHiIBsjTxpLe
         9WDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741074012; x=1741678812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYa7EfywJTw6o3MYMu3IjFEnE/ok1aP+gt2n/HM5KmA=;
        b=C4xMUVZzUGRbWsnXf/BOxPcwGsyT8Hz5LqD9t6xzbFRvG3AUy9MMuzNAmYuXzd3N1H
         WtQYn2RhxidZAJj0iOfKYB8TnoqMhmwhHhWfWpaBXWl01xrRA+VqqWQCu1YPPiqsX/Rn
         c81YNsn7B3YTD2lrYBxj4RLjJTHwSLwQ0sVTHJn0wgdIa91mblYbuBZ61KYoB+YCwSRS
         lHPI1f8q18taYAkxx1M/ZzfJgMtQdWjJ/oNRYE0Aus5b2woD7RCtd2zJENV+laP8GbnP
         jHo9sgV8kAuUHGWlbeNdeS3qKnkQnOKIZnX110vQ3vLoQylzyCkpEP/FCjQoU6sXd9TU
         3gpg==
X-Forwarded-Encrypted: i=1; AJvYcCXo4fHlIxNaSjVhnovqQoFQNR+Ca35W8UobeiDfEYwCRr7J8llb63r5X4qsdZztlYnXsM3+EP97soDcvRY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/YCavMx6eQOEy66dsGwJSMj3MA0Ga8J0Si3GaNTiFNtKnTftL
	Rer+2HBbS7LWRy4Qztxy+g8+z3U5KPKA4TOHGGGR6HT+EmjGu5QOQSNPbzASEtzzGJH5u0DVB7E
	LsnZ6ZTtPSSM6d3BiM6VqvXuiGCUmC2z2RWDKng==
X-Gm-Gg: ASbGncsYoUZLzq//8+ffeNTMAig2h0wflwVMU2goFjevAoBQSpX6vIQIWjCQBXMA2op
	jgI8xf+pY1kDMIslS5Bqz2SYRDhQ0Hgjjc5Yxhi2N8JYWfQ3ZWa5Rmae8xtPyQQNQqfmMvguN5j
	sBM2VE9v8xCGIxs3wUE3VTPbYalg==
X-Google-Smtp-Source: AGHT+IHXJH8RsSh9MugAj23AQppoEi7+HBO8uvCiCpR+EoTX8kmz1M4QPFhcf3U1tuxSzojD8Ca99DcRZmVr3olmu1M=
X-Received: by 2002:a2e:a716:0:b0:309:2267:32d0 with SMTP id
 38308e7fff4ca-30b932443e5mr44153791fa.21.1741074012067; Mon, 03 Mar 2025
 23:40:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250302-04-gpio-irq-threecell-v2-0-34f13ad37ea4@gentoo.org> <20250302-04-gpio-irq-threecell-v2-2-34f13ad37ea4@gentoo.org>
In-Reply-To: <20250302-04-gpio-irq-threecell-v2-2-34f13ad37ea4@gentoo.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 4 Mar 2025 08:40:01 +0100
X-Gm-Features: AQ5f1JpaPsAGaJQpCY5h6TnkBJvDhbXUxtDbGepWe3FtwHACW1AT0pWNBP_lsZY
Message-ID: <CACRpkday=ZgxovKB03PCweh_rGzaJjSJ3ezC_UzPacQPPNJ6KA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpiolib: support parsing gpio three-cell
 interrupts scheme
To: Yixun Lan <dlan@gentoo.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Thomas Gleixner <tglx@linutronix.de>, Alex Elder <elder@riscstar.com>, 
	Inochi Amaoto <inochiama@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 2, 2025 at 12:16=E2=80=AFAM Yixun Lan <dlan@gentoo.org> wrote:

> gpio irq which using three-cell scheme should always call
> instance_match() function to find the correct irqdomain.
>
> The select() function will be called with !DOMAIN_BUS_ANY,
> so for specific gpio irq driver, it need to set bus token
> explicitly, something like:
>   irq_domain_update_bus_token(girq->domain, DOMAIN_BUS_WIRED);
>
> Signed-off-by: Yixun Lan <dlan@gentoo.org>

I read up on the bus token code and it seems to do the right thing!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

