Return-Path: <linux-kernel+bounces-566131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5350FA67391
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF02D19A411B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20C220B7FA;
	Tue, 18 Mar 2025 12:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="obC/2N60"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9016120AF88
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 12:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742300088; cv=none; b=jEVMxWr2VFWrcecCuDg+F4g07YEq5HWfNGm7ahwFqxxKO++QH7D/X6JRxooC8w+LJY6huyrNDgmG4wBZyytdu4bRV6yDHVO9WcRtWdKhU3rhd1j0siHrXpLWp0vfVUuU/ngu5jqQFWQ9JZiWEK9PsHuMjsfF7QtUU6oF0AGS68g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742300088; c=relaxed/simple;
	bh=QzpHIUUWZsgfvIC4faYOKDt71fk0EfqIb7VXSEqRo6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZ6kD7OepQA7fdcKP68vuDL7W81O+59FhbgpQkbRft1MfoCPNwCRRTEbBQxlZxTuBnrWeCvvMDkfFqu9Zvyme6mr8k6sxxROUXyZio1wm70fY3cnWwjvZSU6kuFNzspWG337mJlFHgdfU3ujRg9ed2FUdBmAIvGmxrA9ltz3F78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=obC/2N60; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6f6ca9a3425so60299137b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 05:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742300085; x=1742904885; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=35KJ6RIB9Q+9f4BqBNSv3RS21t3dvAJtK1z7mdn8STk=;
        b=obC/2N60oq53Pw+8ocfBjykxXbCSIxd46ks63qZtHbHtUJxGa3Q6Uo7Hc9y2Np9F7l
         B9lQvzZPwYuvXWYL85cq2rbXYcnrO9WuD9KUUij8cXRqdwlHwhqRPLIOvWyagxaE/YcS
         w50UUHs8MbG8hRUzn87KoLiV8qPJ+Iy2QDQBNGe/BAmY966KdtEifEb0qhax9VgNN3XR
         9olz019iO3I8vVEbg+g56MMWL13UJzsz+udTd7kl9/2AjKgJS3Io/TQvC68NYqmecs1V
         nCeIilHZAewDTrnla7MFWTuBi+0YnfgOq47mXgSQN4p79n5y1Cf5sP7UG7LnNKlFx1cE
         VErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742300085; x=1742904885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=35KJ6RIB9Q+9f4BqBNSv3RS21t3dvAJtK1z7mdn8STk=;
        b=qKLFYiQQ3/ZX3tC6l/Moetj3bAxXEW3m6LymdLf7joI1/gMsnOiV2dO4EdmCF5wgF+
         AVBqutBhj5/0wBdHSLFO9cWnpavDlLZ6u/Kfw0Us7y2bPMp2ohB4/bhKIDb9gp8HWvGO
         SAFM+rgBZWSB+Oos12tLI2q/m90MNkWEXnbJ7X1Lw6NrRJWSW2fGcCLB2Gj4+AXjWxj8
         QgmJ6vKXhvZihFL/jiELnmQxyP8mtMuYhZZTnrGkYR5CiHjw2bKtdT8uZa16InB2quDq
         54Tr0L7rZBI6EZr7QohUlUvPoDbLS18YoFDnPxQDNnBuC73WG/mMfsei7cM4vRM/nKb4
         v9Ew==
X-Forwarded-Encrypted: i=1; AJvYcCVJYhuknLjB1nYwSMEoPKmOXT67KpGMXqtya5kr81CDt+ZR2fdyahpoDR1XgMBn49BS5FyARjGJvkwWQLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuvjDv/SNHVq1402VGuAPZ1YC2RU/orDcVMNj2/cPEexsrosAZ
	9DgeuWti73ZZyZHdGLnBK8sNvq2zQF6UtH2XzYa82C1Z+M3rAt/bHssYhY44iIBEeP4lU+MmcNy
	y52tpp/o7x3sKbQ2PvEQajPTC+di5r8RTjzhW0w==
X-Gm-Gg: ASbGncs3Sv+rY/0jURQib0R6DGj2doMr+XuEDC82ewq6jR4SlyFGHVMApa/zDFPOicb
	JP0gHI05YAwgvGjXHYerklkeepewABrDueWAoRPpn22B22s6m9cevWaNYiYJ/G/sD01R2uPEztk
	3LQfqr+6ShKjmCmbnisHf54lIwvj4=
X-Google-Smtp-Source: AGHT+IE/CNDflepc4OfbCsaedEXllPxnhXufDYR86RliPg4dhjfOHa3oN95T+SophIAbFYiL33n4YcpsSHqyaYjwcHk=
X-Received: by 2002:a05:690c:4b84:b0:6fd:47aa:c6ba with SMTP id
 00721157ae682-6ffd74b0303mr49112557b3.19.1742300085223; Tue, 18 Mar 2025
 05:14:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314154816.4045334-1-arnd@kernel.org>
In-Reply-To: <20250314154816.4045334-1-arnd@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 18 Mar 2025 13:14:07 +0100
X-Gm-Features: AQ5f1JoWrlt3JD6KBj9OzCjFm59ssvNnuLHUfvLaHwEYXpOM_XhXyCV3DpbgJj4
Message-ID: <CAPDyKFpO0v1JLMa9S9RnkB3LCanF+c2toz+APXhO9-KR1OcrWw@mail.gmail.com>
Subject: Re: [PATCH] firmware: thead: add CONFIG_MAILBOX dependency
To: Arnd Bergmann <arnd@kernel.org>
Cc: Drew Fustini <drew@pdp7.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Arnd Bergmann <arnd@arndb.de>, Guillaume La Roque <glaroque@baylibre.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Prasad Pandit <pjp@fedoraproject.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Mar 2025 at 16:48, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Without this, the driver fails to build:
>
> ld: drivers/firmware/thead,th1520-aon.o: in function `th1520_aon_call_rpc':
> thead,th1520-aon.c:(.text+0x28): undefined reference to `mbox_send_message'
> ld: drivers/firmware/thead,th1520-aon.o: in function `th1520_aon_deinit':
> thead,th1520-aon.c:(.text+0x17e): undefined reference to `mbox_free_channel'
> ld: drivers/firmware/thead,th1520-aon.o: in function `th1520_aon_init':
> thead,th1520-aon.c:(.text+0x1d9): undefined reference to `mbox_request_channel_byname'
>
> Fixes: e4b3cbd840e5 ("firmware: thead: Add AON firmware protocol driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/firmware/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 42e3dd1c387a..6ab9f7ca7ff1 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -239,6 +239,7 @@ config SYSFB_SIMPLEFB
>  config TH1520_AON_PROTOCOL
>         tristate "Always-On firmware protocol"
>         depends on ARCH_THEAD || COMPILE_TEST
> +       depends on MAILBOX
>         help
>           Power, clock, and resource management capabilities on the TH1520 SoC are
>           managed by the E902 core. Firmware running on this core communicates with
> --
> 2.39.5
>

