Return-Path: <linux-kernel+bounces-407646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCBD9C70CB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4DFBB28AAA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4905A1E7640;
	Wed, 13 Nov 2024 13:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZMSfxy1J"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8F91E048F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731504326; cv=none; b=DyOS68na6/6PbHFY3F1whYyyn2vAhLqUe3z+ZaG7Jzt4Z2Apcnjph/SlRRYs/bY6cELgmXUxDrHaU9n4sZroV80mGk46WOQysPoTaSkV7PSyBRQEa+kYY+wwjtAks7/2EJaRd6lt+20jKPK8sDM7zeSbPGP0GdO+2bqv55ZFmJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731504326; c=relaxed/simple;
	bh=tdm8/Adv+5ZGDymXWImoKTuoeLBiyC6kmUm06DeTBBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmVWQZiTrndEQOXL164nefqDAFa1En+kp0+em8plh3XMQZXtVfDkC6tMZXXNw6XeKedhkC8UsXfD37in969Qz/zK1kBb+9NwglOPxYdafx7Evf6Y01uEXiqgCWxn3UeLETNv6JqCWApeuxzYekol+/ZQhdaLQO8ZWESsWIpFw+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZMSfxy1J; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso64183291fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 05:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731504323; x=1732109123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdm8/Adv+5ZGDymXWImoKTuoeLBiyC6kmUm06DeTBBg=;
        b=ZMSfxy1JTsbmg4qE5PXwmnmHtp9WZnLl2sATgck7XMFp1elK++P0LEdIJXhh4HRmbV
         Ufg4bj6NXxGW+XUpQ1xkWGGFvQsnDm7MXqv+oUaPBAQg822JJ4U0844R3S5NXIE6HW90
         tC7f6Auh+3Lu9ZX/v+FHyla95yyj4Rd2xshrsXQHTjX0lOvvRq0bNMvFd5JIWd3DvrTu
         d8ipHONVSyvsqpXcdW1BnudjPBJWDvDoxWave+gSd4q3YDdvFPhOPdedm9Gy5USLVo9Y
         gjDtGSmyoE/333NxeYv3bPm3nnzTLJvkb0O/EuTLsNtN9HlgIcDQ8xPVHAxkA0Xrq8NE
         dhgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731504323; x=1732109123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tdm8/Adv+5ZGDymXWImoKTuoeLBiyC6kmUm06DeTBBg=;
        b=slcwscTiHfKBG34PT8YknzUCWHBQrdQiGLiikIKV7q2WcfA9P3MmhLKiyxkGJiU+Ka
         pClXJoMV6O+DhnRuoUgfRP2yFZsVZDGBP/BR4nFJtkYSB6m4efbe8KLF9n3a3mUKC3Ri
         kDPFmn2CxJ+FRAAb1rRRWlYLEi82SpmJEYxyiN8m71BJpL8VXmN0w2DGFwUllF1YxR7J
         YKPKEdmQVeu2EgywEFuQ8iRa0u5j2oOEt/CvWhwnHd91qSdAcB3R9qud/VvIdF4rkE4R
         52rZfEWYijjm9s8b0mVkOb0R7nmBYbKEfG7RYtsPUMsxc0NkwmkLiTvWfSPxQwXgQjU0
         co3w==
X-Forwarded-Encrypted: i=1; AJvYcCXOKbwhzwBetnSRu3W5UBjJp5sxdDfnTxoUpID/TeR+wnaobhK0xety5mNOIMv4GtsxdWq/iAreRQ4Qc/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyFldy87dBVyaCzS3bF7bpHKZUzndLyxDm83LPDRWFNaSSq2/7
	nSHfFn2c80sSGnPdsS83yL8SyPSwvq6ZOswcsnPk/QS/dgL2G+Qd04es0GPID6PW4z/7pXWKxOk
	6Wm+sQzpLNhNb+nuoHZBPe5qBYEWm3M+NgbKtSw==
X-Google-Smtp-Source: AGHT+IHX8+zHy2cRQuozOk3orjfKceKGL6x8ZLfWGh9apX7pumtVpc991puIgqUN2OLaLTkg6vBcgQb/2f4+fVGfe7I=
X-Received: by 2002:a2e:a90c:0:b0:2f3:f7cf:2f01 with SMTP id
 38308e7fff4ca-2ff4c674adamr15664021fa.41.1731504323148; Wed, 13 Nov 2024
 05:25:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111023412.3466161-1-ye.zhang@rock-chips.com> <20241111023412.3466161-5-ye.zhang@rock-chips.com>
In-Reply-To: <20241111023412.3466161-5-ye.zhang@rock-chips.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 13 Nov 2024 14:25:11 +0100
Message-ID: <CACRpkdYSBTvMdQtJrLza2=--dz49Xz667h7p15P+5zVm5nji5g@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] gpio: rockchip: Set input direction when request irq
To: Ye Zhang <ye.zhang@rock-chips.com>
Cc: brgl@bgdev.pl, heiko@sntech.de, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com, 
	andriy.shevchenko@linux.intel.com, tao.huang@rock-chips.com, 
	finley.xiao@rock-chips.com, tim.chen@rock-chips.com, 
	elaine.zhang@rock-chips.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 3:34=E2=80=AFAM Ye Zhang <ye.zhang@rock-chips.com> =
wrote:

> Since the GPIO can only generate interrupts when its direction is set to
> input, it is set to input before requesting the interrupt resources.
>
> Signed-off-by: Ye Zhang <ye.zhang@rock-chips.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

