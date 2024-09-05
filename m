Return-Path: <linux-kernel+bounces-316936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF8896D73E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 187D628152F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696A2199E80;
	Thu,  5 Sep 2024 11:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GKaf/VLm"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4573B199231
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 11:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725536053; cv=none; b=eYXD8YQvdWHqLgCrZiok6uXbMD7Vn+iKDzCMhoU8cg1rNMMrJxBLHHiu1xJJpQK0z4XKFGLbcYrL/x7wqTbLF2snuY4jLoJJPM9/h47KRBoClteYSZp5Ay0x5ZEaNGh3pmx5ceChEQutRoKIrnqkl01MA7Kbn+CKTB0pMMozcZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725536053; c=relaxed/simple;
	bh=bLDmb4u45gfKegGAaWlNWOEqcWS6avYoGfdiMI2tkYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NqZgBTUbkg8sjO7YWW17IY8Vdq7cOsYr9Qe8qVtlbo8H7EvVySRYceyAMiEo0FQK3HvpKoQZCsBxZtbg8Lw2ZGQv7hsB1aWI05HSpgQLAZkiFZ3vpgXlhDxQe1UPGx8gNx96/7auxvgKvS7+9C7/gNaLNIdr3t6LTGPkR1SyE7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GKaf/VLm; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5353d0b7463so991362e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 04:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725536050; x=1726140850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLDmb4u45gfKegGAaWlNWOEqcWS6avYoGfdiMI2tkYc=;
        b=GKaf/VLmLR9R5KyABurbdCPYMqKDiN5vpWjZg8r6IH3JeunxtgaPTuYAMAyPDVa/KK
         xYJOmLTyAajWX22STThoAV3fELT5CA3EttlgytVtIiM+9lqBEOAKn2hxS0M6cQIX8+Le
         XkGGdrOJtulQ6ExcnsK0F10zWys8DnnNag/1qGezcWyXsLqmacuPwCk/Kud9brUUtl9M
         MZX3y3qumVkphMx95cnrD94a9kspxFMlBrDuojZ9aQlk5pFkJBuvJvQVntqmbaVpsbY6
         vMWHlOXqDRyMJiv1anKxvHKLTlVM2sXR6HpRtyd1u25o+PpHhaBv4m3XSUS+nTSdiza5
         N4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725536050; x=1726140850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLDmb4u45gfKegGAaWlNWOEqcWS6avYoGfdiMI2tkYc=;
        b=NpXSWaim9sIpc3MIsqiZb3cdM3EAuMqJ59/sUvSdMnyM9HUgn6cx41pkxStUW8aHeW
         XOq6gFPST7krFuD8cgI9bQdVX0IBqrfZkspsUI5QOkicpyG2dOx/h19PSHd+XYsgWfSh
         A5rDrFn6FBCPhYIFkUUadncvWovERLvxpftIH0W4OTFp1Ql6jjClaGT0w9vQmSALuSsJ
         LdHTtm3keJ/TM73BUhaiWRetuwjVD8AIbZfFegaaUNTKJTXYKIEpjV1AldD2H7+bi3G+
         9RLoxUQtXrtRN7R3qJrAULwnbkkhpPijqDrHSrNBpCe1eWkJNwc5t/3092hlqzEiUFFZ
         2fTw==
X-Forwarded-Encrypted: i=1; AJvYcCWSGqOFZDQtn262s2HSpuOearVclST48RUDpK25GgAVEbZA8qXoFowaRlDwuxF/NMyztxCxAa9Lm8ViaXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCofIg0G3xaXp+S+XRu4GlWTzvxJAqbjSkoVT76ElDLMuo6xKp
	O9BGP5UvTEr2vdKL8RXGcGYncHo9rwPIObKp0yOoR39jnOzJbNrsAp99bJXo8yLiEK0nJWKWvFv
	JqLTXDAh0Hvr9Ip4y1tDqQZduuCI7lX3Q7nyX9w==
X-Google-Smtp-Source: AGHT+IGzsgH7C+tzPtSN8VBNWiDdDaXjEPSwwJUrmvuJsG+F6lPhfUKhjc6NKXyqkx2vA55fxHGPX68sblNZHKLWO6o=
X-Received: by 2002:a05:6512:3da4:b0:530:e0fd:4a97 with SMTP id
 2adb3069b0e04-53546a55137mr16340997e87.0.1725536049827; Thu, 05 Sep 2024
 04:34:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902133148.2569486-1-andriy.shevchenko@linux.intel.com> <20240902133148.2569486-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240902133148.2569486-2-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 5 Sep 2024 13:33:56 +0200
Message-ID: <CACRpkdbskty+v0V90MrP5nm=S-mqHQq1B5C07QciaYJr09-88g@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] gpio: stmpe: Fix IRQ related error messages
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 3:32=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> First of all, remove duplicate message that platform_get_irq()
> does already print. Second, correct the error message when unable
> to register a handler, which is broken in two ways:
> 1) the misleading 'get' vs. 'register';
> 2) missing '\n' at the end.
>
> (Yes, for the curious ones, the dev_*() cases do not require '\n'
> and issue it automatically, but it's better to have them explicit)
>
> Fix all this here.
>
> Fixes: 1882e769362b ("gpio: stmpe: Simplify with dev_err_probe()")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

