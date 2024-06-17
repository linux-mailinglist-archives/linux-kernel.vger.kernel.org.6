Return-Path: <linux-kernel+bounces-216949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 924B590A8FC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EB37B285FA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24880190684;
	Mon, 17 Jun 2024 09:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vGoCGs47"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6651190675
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 09:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615078; cv=none; b=XhvjNthoumjFWJuwascNjhtxF2QiyPCgThdHlh2y/IBwe7QFbLWadNEQt3hqtjcZ7JPHGwFaUKIDyl+xl9Uh19qQ+GEbCqcv3NIQaVQR54gOj/dYpQ2ikxkoYPvJm0+gdgtU4BNPyyokCU76lqlBiEjYzDnuxu5Dx+OgyJwTNKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615078; c=relaxed/simple;
	bh=q+3Vz3i2TsdrpjkC9PcCy29rOh22Klo7SY6unJ5sDoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IdzOsg+npXLi4qmRb/xD9dSCiaJVgehWSyVS8O1+9rBoB6gpMFlopHqir9zWL48yQMpQPSfOWw7IR5jSv7v1bgLQmvtxf3xsnw+WFI6DQ38ALMggCpU/9aCNQaUplPfQ+7FQ3xpwnHqmGfsQO/aZXdp3v140zkrzV3gQRhhDW1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vGoCGs47; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52c84a21b8cso3800291e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 02:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718615075; x=1719219875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+3Vz3i2TsdrpjkC9PcCy29rOh22Klo7SY6unJ5sDoA=;
        b=vGoCGs47kxRptQjiGTVxeYjnhX0LWod79vxU5Bytx/liuaTpF0ZOm1JtFUZ+pC5ef0
         7IXXUGSVK3TpWElWLzU/ipEmt4dbdygNG3+1r4f3a2LyigprVxykD3vFxakpG9xJ2MbX
         zT4ckfaSd0ACyuq6fD9CH69IJJ4N/KVp6GSpy972dyQqZ4NEleSBmHWRT5UU9ZFfFXmV
         ZNIXilcIsZcV5+skW3moENeErWEaM8hwREcaRjDpgNQIly0ZE6xMDsUiEgfHIAp4GOVH
         6u+YutQ9brb1BFaoxiucn4RaUqQpvgXVaMvKTg9gLdeA81W/ehL7jhPPVMODz7iViD/B
         yxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718615075; x=1719219875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+3Vz3i2TsdrpjkC9PcCy29rOh22Klo7SY6unJ5sDoA=;
        b=slk0Yf3Io8D4XPWGXmzNColw6Smoy36rF+Wi8BMUFpLTUbWeYHZxWeGhrGyZ3ytr9f
         T/Qf+D5utbu+n/HGuJIvCjaQ7tMgaL3nBUi9swfqwdJCgy49rO8sYjiOgCyfx3oqtjvO
         Tm8gZV716YFmNKOtLIc0V8uSs4u/glY4eU0CHvjmkJzYhJbrxkk8VJb0Z8TrN7NKvvxS
         lMJk8iYf2fOCph6KzWe06ItGCYfB0Ifd6GG8OqI1Qv0bX6fDGgfjK+FAASVw4Zpyie+4
         U+dDOlazyZ4YldTOnS6Sfx4+4LskTRQO0OU+jWjUV1HtLfKhDKBUcxhchsz8uX0Dvm6+
         aaUw==
X-Forwarded-Encrypted: i=1; AJvYcCW/8843KgMI/K1/x7LUiFfFMyYvfXrHLvxr+AnARKeeBlXM/okfmpV4Us1Ln19AOXQhZ6QS1q0IbI/5BRmPcg7fPA9TXwViRKdlrdkn
X-Gm-Message-State: AOJu0YwpXzSpokoE/NYEipvewf3QNPJ6Ie21c6retnOocGfHaGXiTde4
	3QqTb1ZV5g4vGk3POjf2CusD+IkXv5NLx8kRYqKOZS8CW18R+thdDVQ2EhkiX/F0psWBIQPsZkG
	XWo42nDdoJMURi3a6J4aMxHjvcq8GFszf/rv9UA==
X-Google-Smtp-Source: AGHT+IF+HJZcRpUbZaoti30eFGkz57My4se7oV+eTI19fCyAo/6voMtDXYoZMTNQnN/HrQtJfz8h91nbF6hk4mFYQKI=
X-Received: by 2002:a05:6512:ba0:b0:52c:8dea:c56f with SMTP id
 2adb3069b0e04-52ca6cc6e6bmr3777612e87.25.1718615072794; Mon, 17 Jun 2024
 02:04:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611102744.v2.1.I2b014f90afc4729b6ecc7b5ddd1f6dedcea4625b@changeid>
In-Reply-To: <20240611102744.v2.1.I2b014f90afc4729b6ecc7b5ddd1f6dedcea4625b@changeid>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 17 Jun 2024 11:04:21 +0200
Message-ID: <CACRpkda4KbfWnMwFyJAFKeyvJ3A32D1WuEQd=VQpQcg02-+32Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mediatek: Call drm_atomic_helper_shutdown() at
 shutdown time
To: Douglas Anderson <dianders@chromium.org>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Fei Shao <fshao@chromium.org>, 
	Maxime Ripard <mripard@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 7:28=E2=80=AFPM Douglas Anderson <dianders@chromium=
.org> wrote:

> Based on grepping through the source code this driver appears to be
> missing a call to drm_atomic_helper_shutdown() at system shutdown
> time. Among other things, this means that if a panel is in use that it
> won't be cleanly powered off at system shutdown time.
>
> The fact that we should call drm_atomic_helper_shutdown() in the case
> of OS shutdown/restart comes straight out of the kernel doc "driver
> instance overview" in drm_drv.c.
>
> This driver users the component model and shutdown happens in the base
> driver. The "drvdata" for this driver will always be valid if
> shutdown() is called and as of commit 2a073968289d
> ("drm/atomic-helper: drm_atomic_helper_shutdown(NULL) should be a
> noop") we don't need to confirm that "drm" is non-NULL.
>
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Reviewed-by: Maxime Ripard <mripard@kernel.org>
> Reviewed-by: Fei Shao <fshao@chromium.org>
> Tested-by: Fei Shao <fshao@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

