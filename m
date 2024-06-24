Return-Path: <linux-kernel+bounces-226784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 254049143B6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 915B6B2237D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 07:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A0433F7;
	Mon, 24 Jun 2024 07:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x0SNrOUF"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAC879DE
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 07:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719214215; cv=none; b=EczZx/D0I2rQgdjR5WDdTvDGF04B5V9HSbD2LjSBjTPPMG2ZueqeSnIeJFHCFh4KUr70iA9akpZDmceSmqAPVXmXZTAn2+i2vXNRBvaBEfVCzPcpWhhUggPJjfhokDSZNJH8FuV13StdF3WiAnAHqy1H0FAAhuwPIyTbvqZKMrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719214215; c=relaxed/simple;
	bh=M8cE6CbrRSk+zbBBYOvmEABXXWGImsiVjoJ15IPiQ9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YUSR/D0qZFB58bZw2/u0Ybx2YwDNNX01FGS9E44RqbGoCFxFPuJ2E996twAVkm8mLYMkpR49YdEovBvy44RuyRpX77BpOyKaBRiFKF22T29rUbotIFPC8XMroEZwImjTSFB8/2kOcHEFxdz6wfFjJoY/TvAHuO5BvnUm8019Uic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x0SNrOUF; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52cdf9f934fso1477158e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 00:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719214212; x=1719819012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2wEfoJfSxKz/sP5VFQXU0+BbBfrArIiP6A90WvdI4U=;
        b=x0SNrOUFIhOeee7pnT4+LMKAWKS2XFGoqMp0/gIMBFzHuj7oslGlfZyLt4/vKSMqag
         ig2d9Uxvja/nlq0MlgmejjV5t2/3gFBS9CiMBfCPoZEAX4JUVehKsknZyW7mNpSkO03P
         6sc+jCMs/51y7bw4kWpHsXdIQPGn7mQNZd4zdh58V0U2kQiGuq3HYGCKFH4FE6MLnxHy
         8hDG0a18VzCan5rKW3qGkKzy5Z7JJFdYFfCNpWZwbLjfSBaQSWY6MkvC7o3CiLnJzHOK
         2b0T34famoVkHZ6Q8NBWnPSBdaCNQ/k4SLRzbCSgduZsyq8ZY9LAgrzz5Br6ql4BabYw
         g5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719214212; x=1719819012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2wEfoJfSxKz/sP5VFQXU0+BbBfrArIiP6A90WvdI4U=;
        b=YaBPFXU8dbXyFt2p34ge62f3PmNdNPcXDk68Wc8pSV7ahgqEBDWoYFFXWefsNyxajS
         VqgUTxtm0rGWVfoLQFYTkjgpJbo2nS5iKHYkfmBZmcisJvWmgotqzeDCMl1hcQeH0ijJ
         9uLgqVAuCX02M/t/Y6UF2ppslheFG1Mj/OL8p430sT53kzthenEPqXHac7fzWdv/4Oba
         2Zl+8YqKiS71+8qDGqRIA7pZ5j+TVEVDJiqAOcMInC3SLnceCR3s4TvpmGrHgIAf8B5V
         vf09AAQoXXK6JBUGIt11hRqQ/8eBOxOqX0mBHfx08M2JjBJPib5LPejRIrh0z804cmKe
         7miw==
X-Forwarded-Encrypted: i=1; AJvYcCU0FAw8PQrbuk+okoy2J9vQ2bWMs6JO7oEr2IjE01OVIuL5xHRrcYpAuqa1sICwbL0D8q6yOPdSohnEMbzJ9hbsXUiSreSLrtP4z2M7
X-Gm-Message-State: AOJu0Yzvb8+uNnGY3TZfzdC7XkVfnoWhJi8idO4XPun4cnaLgzVTBWsH
	R5qhJ8a9WKNuxIXBD0LaMx/sZzJp89wY1p8kIab9hwviGJ292YRyYKCzPx0gAkKHJTqtY6PeTAU
	nMLwV281Nh2/3Ub79aqydejdsoIs+YtRKJ+6U7Q==
X-Google-Smtp-Source: AGHT+IF3tAjzNOGGkT0tQNH/0umUeC6Wa2jKs0yWwYAUPb4y9n4wxhkW/20v+RSive8xdIdFYTIgYUauHnzqgbb41co=
X-Received: by 2002:a05:6512:715:b0:52c:b008:3db8 with SMTP id
 2adb3069b0e04-52ce064f483mr1977415e87.38.1719214212126; Mon, 24 Jun 2024
 00:30:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624023612.2134144-1-ruanjinjie@huawei.com>
In-Reply-To: <20240624023612.2134144-1-ruanjinjie@huawei.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 24 Jun 2024 09:30:00 +0200
Message-ID: <CACRpkda-FZmyEyMJrKTdic4t8Zq_VSW8AVrvw6t=B25fiUZNKw@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: Add support for STACKLEAK gcc plugin
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: linux@armlinux.org.uk, ardb@kernel.org, arnd@arndb.de, afd@ti.com, 
	akpm@linux-foundation.org, rmk+kernel@armlinux.org.uk, 
	eric.devolder@oracle.com, robh@kernel.org, kees@kernel.org, 
	masahiroy@kernel.org, palmer@rivosinc.com, samitolvanen@google.com, 
	xiao.w.wang@intel.com, alexghiti@rivosinc.com, nathan@kernel.org, 
	jan.kiszka@siemens.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 4:33=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:

> Add the STACKLEAK gcc plugin to arm32 by adding the helper used by
> stackleak common code: on_thread_stack(). It initialize the stack with th=
e
> poison value before returning from system calls which improves the kernel
> security. Additionally, this disables the plugin in EFI stub code and
> decompress code, which are out of scope for the protection.
>
> Before the test on Qemu versatilepb board:
>         # echo STACKLEAK_ERASING  > /sys/kernel/debug/provoke-crash/DIREC=
T
>         lkdtm: Performing direct entry STACKLEAK_ERASING
>         lkdtm: XFAIL: stackleak is not supported on this arch (HAVE_ARCH_=
STACKLEAK=3Dn)
>
> After:
>         # echo STACKLEAK_ERASING  > /sys/kernel/debug/provoke-crash/DIREC=
T
>         lkdtm: Performing direct entry STACKLEAK_ERASING
>         lkdtm: stackleak stack usage:
>           high offset: 80 bytes
>           current:     280 bytes
>           lowest:      696 bytes
>           tracked:     696 bytes
>           untracked:   192 bytes
>           poisoned:    7220 bytes
>           low offset:  4 bytes
>         lkdtm: OK: the rest of the thread stack is properly erased
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I was digging around to see if this would interfere with BPF
trampolines, but the
BPF code seems so generic that I assume it already takes stackleak into acc=
ount.

Yours,
Linus Walleij

