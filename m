Return-Path: <linux-kernel+bounces-230661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4CC918025
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCBCD287E4D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5210C1802A1;
	Wed, 26 Jun 2024 11:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yTr+ToUO"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E603F17FAAE
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 11:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719402552; cv=none; b=Q9YlR7Bs5CR6NFYs/Y458grdXMu5NGvdj+Xpiyd1jyZzaXOp4khW7VMrR10U2heN2WeFEki6yQ74eOlbz4N7a+vTYlKcJs6P6SY7XwxlCNyupceq852Cf7P6A6C532oRk2hjCcwNxc7Ump/66bu1uycbA7oL7p31DQKbZVDuHII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719402552; c=relaxed/simple;
	bh=YO1t6RF3glr3rCz97Et9FOGeJn8Z+b5W8m/w3Gj5amU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p4UH8cX7ICvySP1AX5lShFlMe38WtHHcEChjPi3gkYoINT2COxeQSv7lyEqKyNcbnarlUJq1KJrnbCTV2KuKn0gtfBHZDo4MH97Kad9lPkdh5apUzl7fTaPb9d1vmJQrvwDn4DzQ6BGbOg6OV8kabnaNRryDVv/Rmul1AoTSYyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yTr+ToUO; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ed5ac077f5so8201681fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 04:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719402549; x=1720007349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YO1t6RF3glr3rCz97Et9FOGeJn8Z+b5W8m/w3Gj5amU=;
        b=yTr+ToUO1KDd0Vj7fZiyEDEZSZO0u+f5S0/Zir6OnlvjaxCO6v8sjzAPow4Db6gMUg
         MeYdd30rY2XrgrpLvnIfekDckrRYuxzi1bP43InHQX4CZtVHWh4tY9uM98Z5xN0FJcaQ
         6tWRvmtMuvSvSBMGHJTrqgA4EMoulUeYNZiRi/WR9v7qzPU4lXnQPJPg6QYZ+H3mbny3
         WOANFeL9YPSgva0/Z8ofXxcRXv8SU+lgpxw2c+5QEFO+mreGqIEBJSbIuG7xhan2xD09
         y2dcSIQ4P37R6GsITiqF15NIOuxfwfxl0kSZGUBzvEyENTHDOhvyRxWp1TQXE/03PqVU
         hUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719402549; x=1720007349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YO1t6RF3glr3rCz97Et9FOGeJn8Z+b5W8m/w3Gj5amU=;
        b=qts1bL2WInHzE472rcXtH1hUJSzVQL6dzZFR5+V+pLhHREQiHAPzungp+CX4M1TeDc
         yHUEPPF1A4X93wEPprTVOzmjpdN6lIaUSMQp4Ca5yck7GE4LlXF3vgdattt+XSTCsqNe
         IM+cyfImMwP2is4qk04wTHqREqbO2ouhQuxQJlxBw4QRuFRoVoL+Y11VP+vGuxHAgu6m
         lqvdvn3X46RJdO38Y0ZY+Yvq8pM0KoHtw/8nLfR7Z5hf8jFQCs4c0k/8Y676heRH4gKo
         sIa2U19VkkjtNY8nZVeNZYJUJDlMVfZOMfUqlBMJfGchydRmOyUEwzyeV2W11YFc+0vm
         vM5g==
X-Forwarded-Encrypted: i=1; AJvYcCUPjCK4cYGd9z1JDhVqf6tirfuL6jqz4nv14APy6N0w5HsIckcA12PCGHQnZZP6uRfyzYxErjofsGJ6Toey85bOxyqjXKx2nsJMEHdA
X-Gm-Message-State: AOJu0YxDDUsQYh9FS3oq9w/W/S9dQ4kA74qeIk6R3ljChmexD7ltZ1uV
	Pjcqq1BieSGKdDVkLVuVKraHNX5TO1v7JJxQU3ySA6X8LU1DeKyg+6Y+E5+K2wN/1XA+a/UFaag
	WsgLRlsJR9scnmAppo1LDCFpMn0PykBs79V3GhA==
X-Google-Smtp-Source: AGHT+IHN7aInxDMIB6i3bGQDmb/JUI7qoajbt6wkmr4ZypVyLp9oVk4jd00YUfJaTtzkY/gO9rVTtu8oZUeLfxWlpgE=
X-Received: by 2002:ac2:4eca:0:b0:52c:cc38:592c with SMTP id
 2adb3069b0e04-52ce05f8bf9mr6292345e87.0.1719402549050; Wed, 26 Jun 2024
 04:49:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624093934.17089-1-brgl@bgdev.pl> <20240624093934.17089-2-brgl@bgdev.pl>
In-Reply-To: <20240624093934.17089-2-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 26 Jun 2024 13:48:58 +0200
Message-ID: <CACRpkdb7ouG6ocHd_YiAj0JjvzXcbgbGzY6JPSntzpHOr_rDPQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] genirq/irq_sim: add an extended irq_sim initializer
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 11:39=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Currently users of the interrupt simulator don't have any way of being
> notified about interrupts from the simulated domain being requested or
> released. This causes a problem for one of the users - the GPIO
> simulator - which is unable to lock the pins as interrupts.
>
> Define a structure containing callbacks to be executed on various
> irq_sim-related events (for now: irq request and release) and provide an
> extended function for creating simulated interrupt domains that takes it
> and a pointer to custom user data (to be passed to said callbacks) as
> arguments.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Fair enough, I see you agreed with tglx on this layout so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

