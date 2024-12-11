Return-Path: <linux-kernel+bounces-441316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0AB9ECCB6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59C2B18881E0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE9C1F193D;
	Wed, 11 Dec 2024 13:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hZpcZd8Q"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7CF23FD23
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733922258; cv=none; b=Hx4L0FvSSSuj0/j8NvAV9k5B1qYwosksYkX3NqqDMDrz4jN07C2owTdWoHGnQHYbWAmHDX+bR1KuOVknDgL2kjmKM7EjNqetbEteet+iOPkWIvKe1Xh5lyVebRWR3OZqMah9i6DFbQvHlqM8kIVy+cu9UwN7ZvjbKcsAlIU0IBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733922258; c=relaxed/simple;
	bh=74wusGcBfuJxxiu3HaMI2SAkHBbLte2qbusEcT7vvRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jhf9cSzf/11RVg28FmSmLTkb7WOOM4JC91r3L5zsfNoXAnGB3ddksr+FpuyJ4F086qQ8a8Mmm/lF76upglF82P3aT/mYlU/Cni4fzbwGGep/LanAbvpH5a9f2Wfe0SUUlX96sYP6/FXaOV+WdCoaV9bNtpraMgGq4Y5ZbxVU404=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hZpcZd8Q; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53e3a227b82so4055032e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 05:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733922255; x=1734527055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74wusGcBfuJxxiu3HaMI2SAkHBbLte2qbusEcT7vvRw=;
        b=hZpcZd8QPT/EPkk+zoc0nb6GJe6F/nNPa8upl5CViu7TCNPqGg6b85yNTU2n6XHXq5
         U7ED6KRmFoKOPV8LDJ9loOgUwE3gPV7VV/LQh5KQ0uaLG5KbeUu/4k3yEybLfWHQ2I4D
         j5rDyPqOBj5Oqv1ZgQHJ8EJ47wm0hYg+VL588/BQWBl4NRFB5GY6foxcNUqcd4OWfgp0
         J98qcVIswSmvGfwwfAWewETem/g6dDrUdmsQqYIMo7eKzHC3xziVMpjG/l07jUHnaxb1
         ZUMu6NO5wg6OhLca90DfXSJqaVLVJ8D+79L3oBB2oagha4MHNaxvTcEBqlCdqD+tDxX2
         /Gwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733922255; x=1734527055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74wusGcBfuJxxiu3HaMI2SAkHBbLte2qbusEcT7vvRw=;
        b=gt/LlXo/WdYFVDI7bOBdGmbOS6vIP6+0CZTm1tNcLJhn7IDbiX2Js4FRxoNaHVPmiJ
         /3ysg93AF2rfEqHB094zTBwJVdsEmmgJZv1/NAnM1hTvoOzCdd+5jel/QXMEiRzPTbdR
         JanfBgpXpTVMGtvjrTtT/vUqWHfZ6+JVC4BPE95C2jUlwKoW4uJqpAecNXoYjVU/OZkd
         wIOpJHkc+6Q5qBB2om81M0WGwg/p8rrdhY9WxFXN6QFU31pKDhKQCmpiq172BfZoGyvN
         cDMniGPIUVz0t7y3OmOjy73uRiWfoC8CsKV0Lf8Hc/yT9Hj1gLshJ5yoxoIIVYrm0Q7f
         xjKw==
X-Forwarded-Encrypted: i=1; AJvYcCWyS7AaOggGTdhDn0+vPNLyYo6E2a4jZZY7QLTq+8tEd+agsEd6cOiAQKAt8Qml+q2cZYRpcYvipFKhRvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTSix8IZGKEYA4PGJ2btAIy3otqwHBTarNQUZNeoFbJUvzXPKg
	2pE6uTetU6oOt2PI0O3bd1dLO1p0HsFxfZYyKdwNyI0AUV7cAgNqqxaVQofCMGp+3aba4cHoAMO
	NBCxvh/4839YIBQOXM2FI6lmj9kbuQmzP+MTONw==
X-Gm-Gg: ASbGncupl8SrMReY5LIsUmF5BhTS3tvARNelc4ZbMS6nvfGVMxdsygVotP+rHGI3Ift
	FWappKl2OiIly0KA/csc/UAxRVppcW8lMOg==
X-Google-Smtp-Source: AGHT+IGB6//Aa/9qdBUs97OqLI01wh9FfTforqMFQJWtL6U0HM26bdGgt3fd2jPfYC1+ZrQOgriT60mCRL7KIvudlxQ=
X-Received: by 2002:a05:6512:3e01:b0:540:26f2:3e18 with SMTP id
 2adb3069b0e04-5402a60c377mr883807e87.49.1733922255058; Wed, 11 Dec 2024
 05:04:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210160556.2341497-1-arnd@kernel.org> <20241210160556.2341497-2-arnd@kernel.org>
In-Reply-To: <20241210160556.2341497-2-arnd@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 11 Dec 2024 14:04:03 +0100
Message-ID: <CACRpkdYP6yWHuWGwHZCe7SQLg-BFtLb-KKHxqrXbeM2hhrsgfA@mail.gmail.com>
Subject: Re: [PATCH 1/4] ARM: Disable jump-label on PREEMPT_RT
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, linux-rt-devel@lists.linux.dev, 
	Ard Biesheuvel <ardb@kernel.org>, Clark Williams <clrkwllms@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Matthew Wilcox <willy@infradead.org>, Peter Zijlstra <peterz@infradead.org>, 
	Russell King <linux@armlinux.org.uk>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 5:06=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Thomas Gleixner <tglx@linutronix.de>
>
> jump-labels are used to efficiently switch between two possible code
> paths. To achieve this, stop_machine() is used to keep the CPU in a
> known state while the opcode is modified. The usage of stop_machine()
> here leads to large latency spikes which can be observed on PREEMPT_RT.
>
> Jump labels may change the target during runtime and are not restricted
> to debug or "configuration/ setup" part of a PREEMPT_RT system where
> high latencies could be defined as acceptable.
>
> On 64-bit Arm, it is possible to use jump labels without the
> stop_machine() call, which architecturally provides a way to atomically
> change one 32-bit instruction word while keeping maintaining consistency,
> but this is not generally the case on 32-bit, in particular in thumb2
> mode.
>
> Disable jump-label support on a PREEMPT_RT system when SMP is enabled.
>
> [bigeasy: Patch description.]
> [arnd: add !SMP case, extend changelog]
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Link: https://lkml.kernel.org/r/20220613182447.112191-2-bigeasy@linutroni=
x.de
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Makes sense.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

