Return-Path: <linux-kernel+bounces-392061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B1C9B8F47
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58B4F28282E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 10:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D5717C7BD;
	Fri,  1 Nov 2024 10:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mkuld+cf"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8337B175D2D
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 10:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730457312; cv=none; b=iNVhwbW6Kbqn8EuPUdDZt26ANuN0pHiieEPgFxsrD8WtmjDAbTY90od52YvGG60H0M6tcokRHQqVWSssUYbKaDU5vXYZYyxqUe+ebf2OWxOAvTZ35lhE4dwgqIaux70YE8P3kmHy35c4sFG1p3OJ8R0eRPZYb56abiI70NWW2Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730457312; c=relaxed/simple;
	bh=gUED0qC7Xj9Ccy7zGDMa9GopgP03+U78n6y1lYaHtWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uuzVE5szWA0WKOXDr5UMTkldDEW01QnfMg6tyjuhB+1rRRsAh76P7q9jyQg61ByyL9e+hbqmLoVJDQl4E666ksKN+jAeZR4/6HWRI8gtKjSckMzOrywkIdX6YgujluNnwptwKp0c+OpG7IZpSqz+kvlkvNFp8s4cBudBwEgtrfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mkuld+cf; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fc968b3545so18478941fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 03:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730457309; x=1731062109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUED0qC7Xj9Ccy7zGDMa9GopgP03+U78n6y1lYaHtWA=;
        b=Mkuld+cfx76etPlCWeKIeVypufqaOwbKv9SlFHznt9G1mImiKLPWeGWZM1tiXpqn1U
         o0IZG7ghwZ7MxLvDhEnKAOXEIrx6/Rr40tAF5EKNbfZiZEHCimj+S7fhEpj7fbVuTHoE
         6w+X8+7NTamUu++pZCq9ixU2qGPw11p6qad+Py4fBt+brh9wgMsb9GygevIgq0REZABD
         9Eddfyrir0t81eQx9oUMecMmoIhHlCgC9m+oh77KSmGfCZZT+cPpvQZRpiNXW6xNaN/i
         5Pjgg6LbcNdK3dolBt7+3M/7Xc5gK7JP++XrEvFsNkBDo+xX4eUd2EfLN3ivoFhKJY3j
         zN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730457309; x=1731062109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUED0qC7Xj9Ccy7zGDMa9GopgP03+U78n6y1lYaHtWA=;
        b=FWDxeN6yxvVvC10DhDEbCSkZAg2VUfUuIiRuqzBdNd33Vfvv9gGxCIaef+F12Yh408
         sI3a0tUxrM7qB3JhfqGBU8GQgmU8q8/Sno+onx6FmiQqpFRIkSlGicAfgHuZw1R1bDsu
         4JjSJDic659h1PBboIdggpDQrFehHXmVMzxbRhy83i4IgvUwZ5vrIoTjfY+ez6FZ1F6F
         8d5TrKjGJ3VMljvfwlsQ+ZK/iG1/vwiMluNgGmylN8/AACDNEXhHgMzWwsM7pwdAWcj0
         NGLNaXFkl5W4xj4BfZKbhNvS+Q/PPhayg1/6uoLgJKs3GjBG9gmjSV6c2OawZ6SgceNc
         NPew==
X-Forwarded-Encrypted: i=1; AJvYcCUqd8h3A2ch81/eqFU5EdGQUoJh356WQeIZbSsFqxwaBOpHzHwh1sYPhucPyssuWgb8CayxorxlafGOivY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw93dFcqJUdTBbo/52RqsNiHhSeIjOF0R8IGkM59+I8jLnkIUzP
	yHwbaPYhpdsUmh058bKVHKa5zE0DOHxfqr+QH42qXQZT4nm1Kk8ydg7rAFzxV9B4WnQEunQ4n5e
	ZNOlsIer5b4uPLBeV/C6VtOZASc0e4L2ocDWQrA==
X-Google-Smtp-Source: AGHT+IHbg4e8vqd/Rt1x4u1P8xcePOvYSBmvkosXej4R5FzumYLF4sBYkWQAy5nsAEsijuo6ls6uMX8SKiqbocvwAIg=
X-Received: by 2002:a2e:751:0:b0:2fa:beb5:11cc with SMTP id
 38308e7fff4ca-2fdecc2c529mr27176451fa.40.1730457308592; Fri, 01 Nov 2024
 03:35:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031200842.22712-1-brgl@bgdev.pl>
In-Reply-To: <20241031200842.22712-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 1 Nov 2024 11:34:57 +0100
Message-ID: <CACRpkdYTLOBtrhmRHjEu4b6tX8ROc6OHd=f1JAROVA9Rz1ngrA@mail.gmail.com>
Subject: Re: [PATCH] gpio: cdev: don't report GPIOs requested as interrupts as used
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 9:08=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> GPIOs used as shared irqs can still be requested by user-space (or
> kernel drivers for that matter) yet we report them as used over the
> chardev ABI. Drop the test for FLAG_USED_AS_IRQ from
> gpio_desc_to_lineinfo().
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

I think at the time this was added to not let userspace meddle with
such GPIO lines since they were used for "something" in the kernel.
(Userspace as second-class citizen.)

But I guess this is fine:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

