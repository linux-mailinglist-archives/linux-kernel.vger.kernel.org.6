Return-Path: <linux-kernel+bounces-208455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B448902558
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA7B0288207
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5140814F9F2;
	Mon, 10 Jun 2024 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j4y9v3/N"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CCC142E91
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718032609; cv=none; b=ZGM63Z5qvZ0lSNp0prIDjyZQob0ju1LcJbn7zfdrhbmfx9/dopFZCNJSqh0J3WbCM0UHwJtwwuIeUPbIlwetnP8SpIJycjAieShKxWoKDeslHRaLM7iUQxd4LiFT30SZwn4JGpikD5KNVN77dMs6kd1n4gAk4+PlUFfyGA35WrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718032609; c=relaxed/simple;
	bh=+yw+G1cK7msJnEFsszzGBfU6Rf3R11uCYw2YDyUvmeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f8wmtJUGZyjwNOIMyfDGIcWRgzf8CgWfFFj6M24LfXdJEyqKRIjqC9Gs4aiHeo4ZF4gWATUufUjF4mU0DzZMT1VrllHU2Jf5hHtbgxz6UhpfQdMfQw4yZZLFi6+e9NtQ85mgiqUIC1B7QZZjz5/+96iTCl5JsPy4Iru7dzylU1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j4y9v3/N; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-704313fa830so1128255b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 08:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718032607; x=1718637407; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dik3EIAdL8x8Xf94kk8jsTPxO3oLRvZX6r2IYoPGz1Y=;
        b=j4y9v3/NbE7jqrOlYVMMbQFLljUB8pbITvDV8nWTr3odI+H4558hu7FT+FWHDGX0Hq
         kOg5dKqFwVS6+lGCcBBYMmOLjSyeSY969ibayyetg+oXh4BC8A8KuUjP82ho+jL+sLmL
         BL4zrcH0b2TeOb/+RHYxbms6/aG3wgBSyc4jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718032607; x=1718637407;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dik3EIAdL8x8Xf94kk8jsTPxO3oLRvZX6r2IYoPGz1Y=;
        b=gYFRbH4XuBuKH62DHecNgz+WKdXRH3X3Zn5rJ534dQN9B56gEfKmqYOS5X/qIeCJE6
         u1vChm2sOENsF7cPpFPfP2mb2bzhyEX4v5HwIO2HtzYsT34xks0XY/XZey4INkNHSLkq
         IfcWXH0wUrgMbjpkSxZBjNemSvJnJzLVNcy2yEZBtngnd6lWk5TNt5B3FwonfGbCB0dS
         VgrUBbD0oHpTe0AwWY4BYRP+N2wuhnXammOe5eksFOUIeebE9jtqUK99dwbVBXFGFWAK
         PdApGkw4LBOTC/9SC9pPJk3HIKYlDue9omBXYS4Vk237gb9W4Ek3Wg93Ao2ucchHdNRu
         lxyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlcRJt7FYtZ//uT7Ko/NLnQ3d0tZGOFfh+ZGWjhmJnBNSR3tri5D5HSTxPa9+OaX0z8n6w9pH88EacsQA+4guR4HqwejSLXogOQfC7
X-Gm-Message-State: AOJu0YxZpKPn1C8TfcRl2yjh6sI4EdjYTMxLxwCvhg6MEQ8HFDXEwPpm
	t7CbzfReeAI4N29/Qju1e8fnFqYwpIWGfYbuifoQk5bKyGAUOBgDZL+w6MzUNgEk4db9AoJYRuu
	cBPoQj/RberdqAycFFfEKzYi1mRAvWOpJOUhF
X-Google-Smtp-Source: AGHT+IGEqz2uPEUm9ZazQWGHr75wT8JeslBVWFP0h+6GsPtIVGespsgLdRo07/SkXqM14x2ZwkuYUCMo24PKwfJ7rkY=
X-Received: by 2002:a17:90a:b383:b0:2bd:f3dc:62d0 with SMTP id
 98e67ed59e1d1-2c2bcc6336amr8441829a91.37.1718032607324; Mon, 10 Jun 2024
 08:16:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605094843.4141730-1-wenst@chromium.org>
In-Reply-To: <20240605094843.4141730-1-wenst@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 10 Jun 2024 09:16:36 -0600
Message-ID: <CAFLszTjX=ixC3pRRGJeaP=ie_yc+KcCRyQ06MBFeSZnBepaXaw@mail.gmail.com>
Subject: Re: [PATCH] scripts/make_fit: Support decomposing DTBs
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Chen-Yu,

On Wed, 5 Jun 2024 at 03:48, Chen-Yu Tsai <wenst@chromium.org> wrote:
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
> [2]
>
>  scripts/Makefile.lib |  1 +
>  scripts/make_fit.py  | 70 ++++++++++++++++++++++++++++++--------------
>  2 files changed, 49 insertions(+), 22 deletions(-)

This is a clever way to discover the included files. Does it need to
rely on the Linux build information, or could this information somehow
be in the .dtb files? I had expected some sort of overlay scheme in
the source, but perhaps people have given up on that?

Regards,
Simon

