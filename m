Return-Path: <linux-kernel+bounces-443924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCC49EFDA6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47054188B52B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF7E1ABECF;
	Thu, 12 Dec 2024 20:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xSalNk7D"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E21174EF0
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 20:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734036593; cv=none; b=TVUBn7OrBtNM3oq7Z6LYGYle7RYOMfFNWKF2M8PJFdcNWaVF2I19anbaJDwI/7TDLpeSKmKDE9f7ZOeqmkitGnWiAUjeT7LKV3g3qmFzDhpKSn06UcQCWAcQqXjnGHfkOKANBKdEbzrkRZJsAUH3+u5CJ9PNOgNVjjbKCEuK0YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734036593; c=relaxed/simple;
	bh=jhb7Oa14Zb1laQhFgw/C+qh1MljqAcSMkUcNxzQt6M0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOI8tD+lfjkZDn/cjVAo9Jj9B7YtnOdXxcGMVaI4njDyDevec6gEXsyqBM739bWCsAJrtgL+1gvOZXOCiYBYzLpzPJS9uBYwGBzlB/IZblTwFr8bvRM4uj9VPkkZ2jnfyXKJd/luPNU1XkQjFB7I6N4cs4nH6SomxHRX1UH7Bu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xSalNk7D; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ffd6af012eso10391391fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 12:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734036590; x=1734641390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhb7Oa14Zb1laQhFgw/C+qh1MljqAcSMkUcNxzQt6M0=;
        b=xSalNk7DwG4LZW4iSH96NW3YuLczACUM6IRHqto6FEM0SWSg0+OgLeIMV9eH8z0nhw
         RXecHiwpu1MbTyexJ2TYK05fIbGmWjoYFxqL98s3PN/yg5JFwjFKi3b39BtZvPIc/e/p
         GbTigCHFXUGqNWY0hNEjZYQ0FDWcFoRKZQOige7ytdgXYfEjp1NMXSAlTammah0mtaVQ
         V4XzmvBMcB1kRLj0DB6HX65ezxacTo3BWPV2fI6jR7eOTzU0Gmt3t1IA97Ao1gRwAdY9
         Ttw8EbyFo77iRkImUs9Tgnxnf2XuOt+ayXwDpzJGqfWKtXawOb8OxLaXQEvvOZ/JLpld
         BKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734036590; x=1734641390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhb7Oa14Zb1laQhFgw/C+qh1MljqAcSMkUcNxzQt6M0=;
        b=jSocWAXKKYRnD+zdoneA9PzOSKMUslfFE4dA0JVRW3xgfzWZjdnbzZDjz9FgjPWc4o
         zEgTc9xfxmOixqD9tygascImjwrp97x4X6mcjnENws4/ZzD+N1pOoJtRnf/ggJHmroJZ
         ZXm4/xp9E3zIH3bC1oEY+auvtWJlp0uRgO5FFxODtUgWXVbHrpFEw6lZjW7TUmPwVziY
         PxIeOT8i6/JOKHYBvOgYJuUGlNsNzkq+50ej3TVMgU1nMIrCCeG7kaOSCNhai8gTRM3+
         6cH96zaTxGefLBOYE+8DUer6XqgZ/NwQ00pUBjf+UbF+Oeqanpvn9UJVH/OLC7eomxyA
         aTWg==
X-Gm-Message-State: AOJu0YxEgJzxcSiadwGpgvzwQlQWrrQyM/V+Rx2g7f5TZbAlmVJF9cp2
	pC7LecTxMeO3gZ2MqR/R6PxWNJyIEA6Fcn4j8CNg2p+3DlUceI6hHpsWTvBLGadlfZpW60tsIj5
	2L0AVfmytjOElIQnz2lPftLEaAo7bWOUQH/D/cA==
X-Gm-Gg: ASbGncuHe/r9pqWPKQBalsr7a7+ODiO5/r/S5zt+oehkqEcCcNOvmbLMR38QmRBfBtK
	VOMmaEZ0JyprLpMdpeW8i68SM3xIVDeZkylSn
X-Google-Smtp-Source: AGHT+IGNX5RK7MGEBvDKboipL69ANJo/iscsTrFTzt8I8Ex7/HcqjhgnfX9X6hkBPTYVYM+wmL1CpKpZIq72Pu4bhIo=
X-Received: by 2002:a05:6512:230c:b0:540:2549:b5ad with SMTP id
 2adb3069b0e04-54034107c9amr671405e87.22.1734036589615; Thu, 12 Dec 2024
 12:49:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211135335.094ba282@batman.local.home>
In-Reply-To: <20241211135335.094ba282@batman.local.home>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 12 Dec 2024 21:49:37 +0100
Message-ID: <CACRpkdbrJ6ERLeMxBPXykCk+mgUkiYGVYqVSnTCKzu=9DBgy6w@mail.gmail.com>
Subject: Re: [PATCH] fgraph: Still initialize idle shadow stacks when starting
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 7:53=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
>
> A bug was discovered where the idle shadow stacks were not initialized
> for offline CPUs when starting function graph tracer, and when they came
> online they were not traced due to the missing shadow stack. To fix
> this, the idle task shadow stack initialization was moved to using the
> CPU hotplug callbacks. But it removed the initialization when the
> function graph was enabled. The problem here is that the hotplug
> callbacks are called when the CPUs come online, but the idle shadow
> stack initialization only happens if function graph is currently
> active. This caused the online CPUs to not get their shadow stack
> initialized.
>
> The idle shadow stack initialization still needs to be done when the
> function graph is registered, as they will not be allocated if function
> graph is not registered.
>
> Cc: stable@vger.kernel.org
> Fixes: 2c02f7375e65 ("fgraph: Use CPU hotplug mechanism to initialize idl=
e shadow stacks")
> Reported-by: Linus Walleij <linus.walleij@linaro.org>
> Closes: https://lore.kernel.org/all/CACRpkdaTBrHwRbbrphVy-=3DSeDz6MSsXhTK=
ypOtLrTQ+DgGAOcQ@mail.gmail.com/
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Yep that solves my issue and I can go on debugging my boot!
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for patching this up so quickly Stephen, you're the best.

Yours,
Linus Walleij

