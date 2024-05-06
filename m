Return-Path: <linux-kernel+bounces-169372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9678BC7C3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BE0D281589
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 06:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD704EB39;
	Mon,  6 May 2024 06:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qr16YN+f"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01AD46439
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 06:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714977843; cv=none; b=D8I9UlWQkgfcUZ0W1t1gZrhdxj+4bjUBXV04y44dSDD2YVK9Z1qHvqW/z3X3PjDq/KRX9R5vXqCP5Xwjaq4jPkYJDK0fZV/AqGelz7qW5BSYPMn7vYMwHC0JGLBhp8Ust8JH417BKjbqmDMRQyfFl2NkU4BYIomqnn1YCrSuAq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714977843; c=relaxed/simple;
	bh=+/vmtuwmmN0BkTcdqfeu0A3XLiBRElrfuAmQSvAzTkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FpHJ5OuiM4qLxJ7VzTPz4gyaPwwvrfllWVmebK4fVg4Z7DCHkrxyYAswVxj3tQnsQF4Zb+0lY94fwXLg4RdKJ/3cuZDDrcMyzsUhNkqwkpWiNSWccJdfvoRbEh1dhB0klFsDGKP4vtSDceoA9KZPyxZnelQmdEr4WsUnsehFJVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qr16YN+f; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-de60380c04aso1877616276.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 23:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714977841; x=1715582641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fWzqRWfAJc/NQrrpKZ9y7YY+4PerAXpQ7bOHb0K0kI=;
        b=qr16YN+fnK3puHG8iqW9rAL8PUUUe9rwvYcxwu4yGTcvgrsgCYXaoM+E3Eh7lgxZUp
         FS+QfGW3Mngik9zP7Uxv+WiPJl3MEQjsekJ5YqSP42mnJVYjinkCzODpTY7D6i4wT/Yd
         MxR3cAEN0rxS6aKNCcV8dLOspn+cFo8OWU6yZ0awUnUjLbw7ZoN8cUVEJBuU5AUgb7Fw
         2woJebFTqq5n+sUZZW2CCYcXxWsprDHs+jn5oFA7HuF38rLoQL1qL24wOZoPQEp5/tCP
         59v8KEFpnb/k4xi3cgsCNcZ6y4pBR+kwyF+nvGs1na+LLnD7oXc4hSemHHGD7Iehjlph
         HufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714977841; x=1715582641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6fWzqRWfAJc/NQrrpKZ9y7YY+4PerAXpQ7bOHb0K0kI=;
        b=NcI47hKggoL0npdfYFGI5tT7gDSzc53o9Mu+4hr+o0csgDjqaLxQev0s8wH0l23xTO
         qnU8JjJ/ncUDLeg8xm6/wDfrAsqHmQGGRY4NZwYoJ0lAr1vxoUe8qpWfLTLy3LDc2Aem
         rd0HHhKtqFGazmZGWFzGispR9oEKIeGbJSl/Bis0axGnQtgoqHm08+GJJSuRVblruTQT
         HZnoBRDhWM/wXyjq1ZhvlPEqtpmKWwGlsf+haEtEHWzTn7DoiqDkdxRz6WqWzMTs3JTW
         ODSjUkn5fxVWkYpdEqgX/Tv2nBt2B49luE2lfCSg3XIOLYHeXKLqv0Iy1GcqT6pqtsaV
         o10Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwsrZJe5x9WBnIwmrpQM8G5MncSVJUKM/p5DjmUMGyQrl2dIqReOW1THWEvztd4Te5Pyn9bwzIpz6u6XqWiqWHk97DOV9XQE6wDAUz
X-Gm-Message-State: AOJu0YybL0r55kFQeNu0FTGQn1g3GuhU2R9/nqC7HXhWMvw+MhFgp4Hz
	2NOaIBbs1D/xYsLABU7VCLpRn7dJ2un8ntNLdejxBQXDnrEdRB+motf7MsMPXR+yYzFvBuGnEyi
	U70K5cJg2GxDqCgt0aR/Ba6UPMDp240I7GZRwCQ==
X-Google-Smtp-Source: AGHT+IEb7mzDNe2H4Ku9FVS///8B7gL+gaG75b5yESoOBOFdJDYKLI2OvwzQGn9HZT9kt9FG6uW4bkEa0u8cVKAGzAw=
X-Received: by 2002:a5b:84c:0:b0:de8:8588:aada with SMTP id
 v12-20020a5b084c000000b00de88588aadamr9105336ybq.8.1714977840931; Sun, 05 May
 2024 23:44:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503162217.1999467-1-sean.anderson@linux.dev>
In-Reply-To: <20240503162217.1999467-1-sean.anderson@linux.dev>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 6 May 2024 08:43:49 +0200
Message-ID: <CACRpkdbOAoSDNFhXfz3djUZh1_MQ_T75CC+-LmojRXvyCbUusA@mail.gmail.com>
Subject: Re: [PATCH 0/2] pinctrl: zynqmp: Support muxing individual pins
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Michal Simek <michal.simek@amd.com>, linux-gpio@vger.kernel.org, 
	Krishna Potthuri <sai.krishna.potthuri@amd.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 6:22=E2=80=AFPM Sean Anderson <sean.anderson@linux.d=
ev> wrote:

> This series adds support for muxing individual pins, instead of
> requiring groups to be muxed together. See [1] for additional
> discussion.
>
> [1] https://lore.kernel.org/linux-arm-kernel/5bb0dc7e-4c89-4f3d-abc6-41ae=
9ded5ae9@linux.dev/

The way I usually would recommend to solve this would be to
define new subgroups, so e.g. for a UARTS:

uart0_grp =3D pin_rx, pin_tx, pin_cts, pin_dts, pin_dcd;

And today this would be used like that:

mux0:
    function =3D "uart0";
    groups =3D "uart0_grp";

Then we realize that not everyone need all the modem
control signals provided. What to do. Well this:

uart0_rxtx_grp =3D pin_rx, pin_tx:
uart0_modem_grp =3D pin_cts, pin_dts, pin_dcd;

mux0:
    function =3D "uart0";
    groups =3D "uart0_rxtx_grp";

Now the CTS, DTS, DCD pins can be reused for something
else such as GPIO.

I *know* that this breaks ABI: the driver group definitions change
and the device tree needs to be changed too.

This only matters if the users have a habit of distributing the
kernel and DTB separately so a new kernel needs to support
and old DTB. This varies in how much control we have but I
think for Xilinx systems the kernel and DTB are always updated
in lockstep, so it really does not matter?

Yours,
Linus Walleij

