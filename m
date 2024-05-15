Return-Path: <linux-kernel+bounces-180317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABE68C6CE1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 21:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B85F1C2172F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829C015AADA;
	Wed, 15 May 2024 19:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xuKus891"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EA83C466
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 19:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715801622; cv=none; b=rcQwQMYtDjjzCteW4Jb9kfuavkAwRVMyvd8Gw83vCtzl6aihLKhwsyz1dUP+vaDxA3T0BT1vgozpxKzDoCFCXkDxE6BAckjV179T99KsT9U4bh5EP7FyIX9E3jXjTetJBvaQfmUkBhlCrrAn5hrc77hfikk6AnJejj7CVOYB+V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715801622; c=relaxed/simple;
	bh=G9CWlj5Tr42EbOH2aiKT43kduODZ1s5xduEkYsBbEIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tyASrz2g5dgABYy1oCVhe2XViv63YahVvpC3Dl3kBYf22J/dcmyL4Zd8ivxqtvrPdAmE7Bd5lhvzOtWdv5XT2Ah2uEak0pln9xv0OhKtYUlVLEAEJ4P2S8D7VOijFAclC0mBND0CotL7OpU4TAwU7J3vHNv5HLUS9M2U6D5483g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xuKus891; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-62027fcf9b1so62136127b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 12:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715801620; x=1716406420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAG+GXxkb/D6Wyq71jplqiM6gJpPzZx9qHoI//hR8WQ=;
        b=xuKus891xhZeitoSjPjWsTT7vRP2flJdmm15oI5Vgqh3LoLIVpxZFbM5Xh9tp0RFdX
         sEegDJMNiTAD9/gtdFZtT3UAPZ4jIk1Hx3DHLY6Ejqas2fQVLcBCVToJb1qk8jb4mcyT
         MibAPYMqHdnTgL4euZh2Gpx+kKQHvG0EgiaFpxQhNmQmYqiZOH7lD+wpUewxY5TbE9cG
         GkneNt9pTS3zpTN4dXvMnjG3NqQ5ZFsCdaB3nlwY/XUBuoWJlffN0a0PJQzn/l3cQMwk
         tlEV8ovYHpedupzNoekgKQppB3r30NH4laS5e+O5xHxi1csuCEacb6aHMRItefgF90KP
         yYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715801620; x=1716406420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAG+GXxkb/D6Wyq71jplqiM6gJpPzZx9qHoI//hR8WQ=;
        b=uZfJGAR8ZtjdG26/WSFP6q2L6kZnYHGQUR0eNUXlSea+bSPUIGQfAMnuPd7MJ3x6Dl
         +bg6SRjRVdvWXyetggObGHym0e2HGVKczRSYplyWc3r80vZjMN0aQ015yMzqHArUo9mM
         Xzq6Qc578kMKQ6CMHD8LzpBnBgQ8DOXuNu0RD4dpMCq/4J+Cz3b/fzJ43f/RZau78h+3
         hBYmWGm0chm4L3diGurrPDjJY9ozHS0vFGkVLykbkvPPzJUwbcExOt8B9ZkSM/L/hp+g
         nu4T93bndUJBi35dG7PmBOBZHojPqdAnIqGUn2jUlu2tLkqWzhq4ZVY3cx4lnZL9gth7
         HogQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaNV43ycgHZk2fK3TppsXiy2vv7iGFCUrbkelc9JbDX6vm2X2fj7q6Q+P8GpgTMa8/QfzpMUSxlsh4YzhrPBrRBu9ddwDbVFT4i+BT
X-Gm-Message-State: AOJu0YwJbTZDKcK/qrRj7ciK2YQGsjUEd5WsiOMpeGVlqiAU3rFcGJvD
	OVeF6V0LCYRpoLBActwJnc5KQuOL88t7SU8cvHwpjlYjz3eq+QCLc42prsHyRQKz/lOJpaROlYO
	tZv52Rhn642GRuwo6MKw4UI3H0hTOuN7XeZRssQ==
X-Google-Smtp-Source: AGHT+IETcrsjYwCLM636Rawh4C1Edyk5mMpZTeygu+Uh4izc5MQ1jPqvKnxvey37IVepiy1yULwOr9OxmlrE9kTvVmw=
X-Received: by 2002:a0d:ea4d:0:b0:61b:138c:5357 with SMTP id
 00721157ae682-622af87e4fbmr109080817b3.19.1715801618714; Wed, 15 May 2024
 12:33:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <200d273a83906a68a1c4a9298c415980737be811.1715781469.git.geert+renesas@glider.be>
In-Reply-To: <200d273a83906a68a1c4a9298c415980737be811.1715781469.git.geert+renesas@glider.be>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 15 May 2024 21:33:27 +0200
Message-ID: <CACRpkdZhU=+ZaCw2rmuN2=tCDXWppRtNsfLjfjD505aFJ_Xo2A@mail.gmail.com>
Subject: Re: [PATCH] ARM: Fix userspace enter on LPAE with CC_OPTIMIZE_FOR_SIZE=y
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Kees Cook <keescook@chromium.org>, Russell King <rmk+kernel@armlinux.org.uk>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Stefan Wahren <wahrenst@gmx.net>, linux-arm-kernel@lists.infradead.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 4:02=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Booting an LPAE-enabled kernel built with CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
> fails when starting userspace:
>
>     Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x0000=
0004
>     CPU: 1 PID: 1 Comm: init Tainted: G        W        N 6.9.0-rc1-koels=
ch-00004-g7af5b901e847 #1930
>     Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
>     Call trace:
>      unwind_backtrace from show_stack+0x10/0x14
>      show_stack from dump_stack_lvl+0x78/0xa8
>      dump_stack_lvl from panic+0x118/0x398
>      panic from do_exit+0x1ec/0x938
>      do_exit from sys_exit_group+0x0/0x10
>     ---[ end Kernel panic - not syncing: Attempted to kill init!  exitcod=
e=3D0x00000004 ]---
>
> Add the missing memory clobber to cpu_set_ttbcr(), as suggested by
> Russell King.
>
> Force inlining of uaccess_save_and_enable(), as suggested by Ard
> Biesheuvel.
>
> The latter fixes booting on Koelsch.
>
> Fixes: 7af5b901e84743c6 ("ARM: 9358/2: Implement PAN for LPAE by TTBR0 pa=
ge table walks disablement")
> Closes: https://lore.kernel.org/r/CAMuHMdWTAJcZ9BReWNhpmsgkOzQxLNb5OhNYxz=
xv6D5TSh2fwQ@mail.gmail.com/
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for digging into this, both you and Ard! And we found the root
cause it seems.

Yours,
Linus Walleij

