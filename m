Return-Path: <linux-kernel+bounces-173416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6BD8C002A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99E428C0EA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5866D86257;
	Wed,  8 May 2024 14:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tk+36egP"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0696D12FF99
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 14:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715178886; cv=none; b=uK+IqUDcSBPlQDxtFtGKHGXHndU9BtcylMk+kGficuNqQ56cerhwLUPAW3PH6TTyvUXdgsKCwrd/eNlgU/TwtGnYvlWHdwV8TuMs2+m7XW6feHsmV9wE+9prpqKTlINEEpgESf/nIhtu/0Hh1TQ0C5w6F47y+uZAYRxV6QapjVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715178886; c=relaxed/simple;
	bh=yDTHGWifoYnCGHAM/Y88fZXygAlEP5oTp5WSlDuAQIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IppcFwpcAw+Ap+CrNoQno9vgmBBsR0sePKYcy4mZS5mBoohNtoJoMPfxf8STYVIFRUifyrjlgohgZOPHhT3gZGAbrTIKLEyXbuAFRTWPeuvKGJJ0LZU2pBF7H1TlNSqNvYIZaKg6Atpx6bsR5CcJXP2LotqeTkO+U5FbZIV64Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tk+36egP; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c989d4e838so318992b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 07:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715178884; x=1715783684; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=siRVx/snUNjFKCrOeXvo0bmHNPIKe0N1mufovHth3gA=;
        b=Tk+36egPwrdCTfCWyCWZ2q38hd4CFboyCElCt8hTcaiwWCnrbhuVJAKcutD99x4bcS
         dSzPAYVoJO4z7W1YPIMmcoPw4+xxXXgj8GVM8RIu/bkyVKdLIX3btfwDrfreo4s44Ieq
         eeWYL+UTH9hS7kGDSiu4k+DyLk4dq08wKANf1lLxQa5MVwp4wXfc2eHWDOyTnM4KnMFa
         GO1H3NOpK13Ovaa82aEThPOZP8MTpLLF5IM7/XdMc1VhZYHiAzuwMOWCA/R4cWMmMu0p
         Qx18wJJn0i6F6/Y5fJuzwi46O0L0Zw5UdcLZKxI0ReZaexk94qSxmouigld4P7lUiuE7
         Z2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715178884; x=1715783684;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=siRVx/snUNjFKCrOeXvo0bmHNPIKe0N1mufovHth3gA=;
        b=P6WubIHucvPV99shvAJ13TgGgwepkQBo0HBEfQYk7rNFlOZZXrdi0mh+qcMJUxWsq9
         tUeSfNsC89EBkzhfJYqi5U/9Gl7t6x1QIlYjySbnBRygmn/vu/zP63caf1GACvpJyKqQ
         iv0fQhnQByJJG9SfUEwZYMNngCHsOOSYhnnUVGOKEjvNhOe4UebAOj6tRcq3fOfCtTYt
         vDhwdTnqEjJkGcMhNDMwew5DyPjRWH7i09mjPxia/CrTZqmFygzp+Y6QWtRqeVFn/Y98
         bdlk64f5mtExUjqDeLHCSeeWYzrras588FerdJ5tORVeET00vXDi/lWC1IgxFkSXKuSe
         vwBg==
X-Forwarded-Encrypted: i=1; AJvYcCUIqRFUU0NFF3UD77CWVxG3I/rTPA2rRYO1fd7wmU0Ldh4xhS3fsfX6rGvqaAjtJdEDeant/jk553xWl3A4UOsvv8ZGsBzxDtxqVBVS
X-Gm-Message-State: AOJu0YzG/yiWqxKijMV2LiLWP9BMHpclKrtUQv6/P5aSWpGzU6wgEH3u
	aiPXWr0cqW5AnlnDNpVKKtO92JiJgxnIk6wHk9g0LGZuHPRht7emClQOXjrnczbe8OwAFEeI7iL
	uVMttaQ2MrRAAHuFcScfWtHzpuSl/wvWXrA7AOA==
X-Google-Smtp-Source: AGHT+IGumxShjVByOQe/R35U/8zQPy0g7+iBzxrPPaEkNW4QM0ked4asufN+qzk9wWvStxQh+HGs93iE8sH2Y6Jxa2U=
X-Received: by 2002:a05:6808:124e:b0:3c9:73a2:6862 with SMTP id
 5614622812f47-3c9852c5e01mr3076178b6e.31.1715178884096; Wed, 08 May 2024
 07:34:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503075619.394467-1-mpe@ellerman.id.au>
In-Reply-To: <20240503075619.394467-1-mpe@ellerman.id.au>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 8 May 2024 20:04:31 +0530
Message-ID: <CA+G9fYvo4--rSTHC1Vxdbbe62O6FhL_P2XdcF2Q7ZRku8HjpGg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] powerpc/io: Avoid clang null pointer arithmetic warnings
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, arnd@arndb.de, linux-kernel@vger.kernel.org, 
	nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 May 2024 at 13:26, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> With -Wextra clang warns about pointer arithmetic using a null pointer.
> When building with CONFIG_PCI=n, that triggers a warning in the IO
> accessors, eg:
>
>   In file included from linux/arch/powerpc/include/asm/io.h:672:
>   linux/arch/powerpc/include/asm/io-defs.h:23:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      23 | DEF_PCI_AC_RET(inb, u8, (unsigned long port), (port), pio, port)
>         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   ...
>   linux/arch/powerpc/include/asm/io.h:591:53: note: expanded from macro '__do_inb'
>     591 | #define __do_inb(port)          readb((PCI_IO_ADDR)_IO_BASE + port);
>         |                                       ~~~~~~~~~~~~~~~~~~~~~ ^
>
> That is because when CONFIG_PCI=n, _IO_BASE is defined as 0.
>
> Although _IO_BASE is defined as plain 0, the cast (PCI_IO_ADDR) converts
> it to void * before the addition with port happens.
>
> Instead the addition can be done first, and then the cast. The resulting
> value will be the same, but avoids the warning, and also avoids void
> pointer arithmetic which is apparently non-standard.
>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Closes: https://lore.kernel.org/all/CA+G9fYtEh8zmq8k8wE-8RZwW-Qr927RLTn+KqGnq1F=ptaaNsA@mail.gmail.com
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org

