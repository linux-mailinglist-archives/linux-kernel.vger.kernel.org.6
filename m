Return-Path: <linux-kernel+bounces-562954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD23A63518
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 11:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F30793AB295
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 10:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2155E1A0BE1;
	Sun, 16 Mar 2025 10:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjim71t8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7976D19047A;
	Sun, 16 Mar 2025 10:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742121578; cv=none; b=RktCS9CPlJMFx2QT7GBdSlJXshuxA1aVNmfzaXt2efxyKzdHjB8a05qPlbxYCMPq5/pBGf3Ewk/oeb2Z9OSz8fippl+t64OhX5nn/0g8xq6Xdo8BcUuibt5PLCv8Ei+/h71aHJzrCZ8u+fYJ6+WbJ0YL4C5B3sdtSozx8C/baQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742121578; c=relaxed/simple;
	bh=WRJSfItq61nSL1uaK/VCriAnVMB4K0dxbrf6ZjynqHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rb+WhYUHR8rE9+n35FnOwJyN3aC3ODwmUMrXtsz8O/ULFh6SBPrjUQpXnyJH4LbWc9fXcbxmDQ3xWF9A9oeBEseT3zXjBquYWaQjV/0+HG+TxQWrFyrw9OEEzICqihlC9OmZWuSQFcBRHSqDcKWTkyXLXhdAnForf1XZCX8J0n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjim71t8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD4BC4CEEA;
	Sun, 16 Mar 2025 10:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742121578;
	bh=WRJSfItq61nSL1uaK/VCriAnVMB4K0dxbrf6ZjynqHo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fjim71t8HPk5uBOq6wbL6gdL2udv+om6C27EvlLbpKtP/SUm5YQ2AWNeQADbyUMhv
	 GIJogonxHqIg46c2LAUJqDQn9IrKaHALrqqrsreuEJOXmfAAg5gJigXloSN6KxOk+P
	 YW2ce78ZEFlZoRPSbhpfZsxp27ZGBWZOqbpwN8HmzxPeN5Qj7pt1XAPgbEurPpuLnr
	 ykMwIhQPJzgznblvQYNm1Wlz/XmzfZ+HGBaIQnfvroA47vamoVrD3GgPFokcLEBfKZ
	 gSaNMil8kPzwCh0ItLw1nWFFejSBmt+zChDNY0GYAWpcpEQidU268Bmrrf3oMHEmva
	 y5knBqbF8j1GA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-543e4bbcd86so3793834e87.1;
        Sun, 16 Mar 2025 03:39:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWyDhUWWZqfPDb5BHsXcUrfOOqLwnMAIGZYZWcSW+DzVip6JMN/42S0p+jmm72v4ilLp9KULTtAfubK@vger.kernel.org
X-Gm-Message-State: AOJu0YzgKJoOdNA2StVbgnKkz0yN0DeF17HG0CgcWQjXztqaMHNwd/UW
	Xtu5c+2m8tLLn2N8rKpcGmg/r23iS1x0t64fgryp/cVctgLfGxZpBuSEl2SHG5lakWTFRkkeQU5
	75iL9Uav7F0Uh6jpgmVro26fa/is=
X-Google-Smtp-Source: AGHT+IEB+4diSeexNNNIukQtrloxp6S2TfNrH44RL6u2FM4sGQUkisIda/46HY4MIJsZGhWgkraV5ZpVD2wA2xIY4yE=
X-Received: by 2002:a05:6512:3c9e:b0:545:22ec:8b6c with SMTP id
 2adb3069b0e04-549c3989e0bmr3087455e87.35.1742121576996; Sun, 16 Mar 2025
 03:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241222000836.2578171-1-masahiroy@kernel.org>
In-Reply-To: <20241222000836.2578171-1-masahiroy@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 16 Mar 2025 19:39:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQMo0R09OcVw77=dyVnUbMv7gxxejHbr=dy4S-SgPT4-g@mail.gmail.com>
X-Gm-Features: AQ5f1JofVnF26SX2Zmz99VV7kl0SZH5Y8b4vOY2llQA5xgYDjVFvk9kRqjew-ig
Message-ID: <CAK7LNAQMo0R09OcVw77=dyVnUbMv7gxxejHbr=dy4S-SgPT4-g@mail.gmail.com>
Subject: Re: [PATCH] riscv: migrate to the generic rule for built-in DTB
To: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 22, 2024 at 9:08=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> Commit 654102df2ac2 ("kbuild: add generic support for built-in boot
> DTBs") introduced generic support for built-in DTBs.
>
> Select GENERIC_BUILTIN_DTB when built-in DTB support is enabled.
>
> To keep consistency across architectures, this commit also renames
> CONFIG_BUILTIN_DTB_SOURCE to CONFIG_BUILTIN_DTB_NAME.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---

Ping?



--=20
Best Regards
Masahiro Yamada

