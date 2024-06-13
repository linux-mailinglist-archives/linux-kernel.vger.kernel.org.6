Return-Path: <linux-kernel+bounces-213529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FFC907674
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 536F51F21AED
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C70E1494D1;
	Thu, 13 Jun 2024 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d5sbq6c+"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4639713CF85
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718292156; cv=none; b=ZEr+w73iC6xE7VBtVfILVv5jKW2UglIeTR9dAxNFjWkNjOQLr/9+IPBxqH3P4nVXr7n4ip9eSWkMJumpDEq79vGzkOba8kVO0LEmhJufZ/XbpCWp2KstqhZj8MffLajsvVddEtorWys5vX5Lr33vR5Qv3JgJdlFc3CrRIUIFOxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718292156; c=relaxed/simple;
	bh=n4hXsXgUNly0dvZL2DEJYivRYjI1ORhlqA7s2/ruvis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oQiLQhVMLjmTg5Vx8vbQrMm9d+/bLmktefD+szVd0ty34LGJixE9rn7+GquKq+3fWVKS9952qKhYvIETpWvXfS2ViaPtMx6lO8+sz8F8ZItPyaM0ZbUlne0FqRRGx8KYGjxEwRmNEqOkpaPquJsvy10s32aXwNQUM4TWdELEU+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d5sbq6c+; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b06e63d288so6120936d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718292154; x=1718896954; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c1FwXGbPrFXal5e1NPPyrNFtuM5Jb5Wk1WnrPz9CJ3g=;
        b=d5sbq6c+Ln9ohEJetSbmbITgkXLfYXo3TH2XJiZv7uqd7Y48X+qrPgc5XVgeP4McGI
         wOi+I40pbwUij3Dx3JCuIKXF9LeDVhh+Qm0UN3wDucL343aTN8JNdn+58n2HgSgDEEVL
         d/hg1oppE/hIizHKJbA5+j8RBY+XHuhjF/gTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718292154; x=1718896954;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c1FwXGbPrFXal5e1NPPyrNFtuM5Jb5Wk1WnrPz9CJ3g=;
        b=MNalbOa8MIz1ZdazanTK2v0IFUmURp6oMWlAuvlBT3nQl6r1VqTkeA5UUaRnD2xS6T
         atNN5q6i9i8NA+Qxsa8+k7zFMkd5YW8+UryeR1WQhGKC5rVXzsFftd+YBMUlvTIOe3dL
         ryJcj+jrTyM+FTbQMLOMaxXy0DswXKi2PRMAhk5RE2fGzdyiW9+8ioioISu98iZzZlYs
         VpvJKXyFKIAr+YLla+uvNhYKTLCPh+JX1xFHUP/RW9afzWjmdGMMc9uP0mguPA99AZEE
         c6HE4aNqiXGp2sHwVEuq27io13ZlBzIMkUodBeoe6REeJiJEdOVzMEj4WJ5JuXVmqvDY
         SYtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFez8WzNv48oMLiuyUJvHyTunPTYF+JkF1ZvhAYnBR0iW1y5W6Q92fRS1Cph0tshr3g6n0bV+kFcZQApuoRPbRauYKQQTH9mJnUePA
X-Gm-Message-State: AOJu0YyvmoWrdXOXaVxQyCbtIRdQWxc9pwj72A8lOpf1TzO8brL2Jptj
	lRsxBwqimo6/Tl/iG0zu57bPelRCLO4mcuK23n5VuuCqjzkhUj6zjW8VPWi8rQC/++AWPwPIbqh
	Ne0s4loCMWe8es1swlMocE+jnepO3x3QLFM6u
X-Google-Smtp-Source: AGHT+IEa7ob5SUFmAeY7t+jsiZ0g0b24xhK3WVy8G0Zs4wQMtVzABwezXEypz7uuOagcfWUSmCPfVFLB/TFN5YhaLvI=
X-Received: by 2002:a05:6214:3a82:b0:6b0:74cf:676c with SMTP id
 6a1803df08f44-6b1a77f12e4mr68951216d6.63.1718292154251; Thu, 13 Jun 2024
 08:22:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613093433.131699-1-wenst@chromium.org>
In-Reply-To: <20240613093433.131699-1-wenst@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 13 Jun 2024 09:22:23 -0600
Message-ID: <CAFLszThZ0SKMVhK_DPxq7n+DavBbWLxit0P3R=o7HN7UcTrPvg@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/make_fit: Support decomposing DTBs
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 03:34, Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> The kernel tree builds some "composite" DTBs, where the final DTB is the
> result of applying one or more DTB overlays on top of a base DTB with
> fdtoverlay.
>
> The FIT image specification already supports configurations having one
> base DTB and overlays applied on top. It is then up to the bootloader to
> apply said overlays and either use or pass on the final result. This
> allows the FIT image builder to reuse the same FDT images for multiple
> configurations, if such cases exist.
>
> The decomposition function depends on the kernel build system, reading
> back the .cmd files for the to-be-packaged DTB files to check for the
> fdtoverlay command being called. This will not work outside the kernel
> tree. The function is off by default to keep compatibility with possible
> existing users.
>
> To facilitate the decomposition and keep the code clean, the model and
> compatitble string extraction have been moved out of the output_dtb
> function. The FDT image description is replaced with the base file name
> of the included image.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v1:
> - Replace OrderedDict with standard {} dict
> - Change short form command line argument to -D
> - Drop [] around "'fdt-{x}\x00' for x in files"
> - Add spaces around '+' in slice argument
> - Split out DTB parsing into separate function
>
> Simon's reviewed-by was dropped.
>
> This is a feature I alluded to in my replies to Simon's original
> submission of the make_fit.py script [1].
>
> This is again made a runtime argument as not all firmware out there
> that boot FIT images support applying overlays. Like my previous
> submission for disabling compression for included FDT images, the
> bootloader found in RK3399 and MT8173 Chromebooks do not support
> applying overlays. Another case of this is U-boot shipped by development
> board vendors in binary form (without upstream) in an image or in
> SPI flash on the board that were built with OF_LIBFDT_OVERLAY=n.
> These would fail to boot FIT images with DT overlays. One such
> example is my Hummingboard Pulse. In these cases the firmware is
> either not upgradable or very hard to upgrade.
>
> I believe there is value in supporting these cases. A common script
> shipped with the kernel source that can be shared by distros means
> the distro people don't have to reimplement this in their downstream
> repos or meta-packages. For ChromeOS this means reducing the amount
> of package code we have in shell script.
>
> [1] https://lore.kernel.org/linux-kbuild/20231207142723.GA3187877@google.com/
>
>  scripts/Makefile.lib |  1 +
>  scripts/make_fit.py  | 86 ++++++++++++++++++++++++++++++++------------
>  2 files changed, 65 insertions(+), 22 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

