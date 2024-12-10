Return-Path: <linux-kernel+bounces-439822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAD29EB45E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20E8E286003
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964FF1B0F12;
	Tue, 10 Dec 2024 15:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WOpoz8Ut"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A521A072A
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733843492; cv=none; b=E0SCv+FqePMC4aaR7sP1tnhRDAS9KZvUzeDfbCcEpNjnyyTO3LyRMP0RKiqNh/vVsLI166kLir8yGGrKf3zBX3RJmlXh4I5cAwlrPYGvQvrOrArfBv/BCV6HBHFPkFRwVmbq7yyTLP3i5GyzyuPy4+HmusvXVQVZ/UNNgvgE0GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733843492; c=relaxed/simple;
	bh=lEm+3aopJoKQMql16KzGFjs3gJoP1xspnmUFB1eTvTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DqndgKoNrKV3MtcbeQJHu3DnVlFbv0Hf33CGiS/J/RDm4t1WEkJWaCZdfGsA5wpvDwdLqMQGUb9FIUv0HL5GTaoAEjqHoBiOaKfuN8wA5N3LTd5qcIIrEn+XRlyiahqMknu4fZHUdOUbPXbBD7DG/GFQNJFjQ7scElrnrha4V2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WOpoz8Ut; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53e399e3310so3658569e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 07:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733843488; x=1734448288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEN1d0OnLQcbT4xueqG7SoZg37x7ROyZS7rk8Ls8Os8=;
        b=WOpoz8UtUZghzvK7zPXitFC4t8yZ3TrHb3Xt+nhrcZEuqJ/l+zJ6OY9dU4/tQiSZdL
         q+2NfQ7y7VuGz85IFy8F49gz7zaiGtI6DofMBvNM3b1adm0TlXnRWgecoMvvSKCW7zq4
         MhflNK4NTF/0H0wyMSIwMYZmVSGwPCPKugUAUR6FCur1DwkuYj2jRVnukajDYWwYKFWW
         aiYM9sT3kDhMUMG7FIz6vCsJGV1moaqS5od2RGoPprCFzYQTz2o+LEX8EjXlx/UJXbAA
         F88R6aWiHtxHUAa1nL+eQvvRKdSu0OEtJ+xk6YwECLYj1IhUd6eXxyDPZvkdzIBWjFHK
         tXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733843488; x=1734448288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEN1d0OnLQcbT4xueqG7SoZg37x7ROyZS7rk8Ls8Os8=;
        b=kxL78k/cGVLU1LJlqnE6wLv3asRal0iQcYNfqNBTTNJb+Z+LRgQ3vEs7hr0nT3J83d
         SLRLK2R1FzncUpsmpHaSV5F2MTIaYJVtucpFFmUXTLVq8HmyixgaZFZE5KDF6rDfbBKs
         HRrf0uAJVVJ4EOvKhkUWUPzBlmec59mIMDAwh5UsjJtn3/cbeAcrI4tG+xRje0hRV4ox
         T2C5vL0RZ/q2WS6//Aww5ZLs0z1s8y/pHuqZlW3kbXy+4EnrNV32VGVswLhIusK2FVfc
         b+YEkaUF4lnuxtAirkqNPL6QZrQBi6okq3YjmELtSrCtKCuMA/l51EHX1lm2C9VuD9IX
         NQsA==
X-Gm-Message-State: AOJu0YxZOFx33cAVjkEQQOfOl84NLUDW0p3hvg4z0aq/oJpioaVeDse9
	lsuY6MgDToa7M6g/EGuRbJwskb2A4GOwn6ow1ycNiv97kjJwAU6GMItpYgNbKZSA2CSIuRGzkJL
	jlrVz+q8p4OYUJNIOZcaCSLcQ6PbmBaTDcugPEQ==
X-Gm-Gg: ASbGncs156JXVltpxD1UavakVog2uDgxI52SOTjgGU0kLCZ+x5ZTdx/UQOXIhc7hQuw
	Q4v99/QGYfyOX2GTmkfQTgp102LoVoydI9w==
X-Google-Smtp-Source: AGHT+IGJm0Y6WmhhOsiFiI6WYV9RIpRbGC3+UR923jjT1xBUygkszZymmfEJR2CbAWdHwlnFwSK/M1aoJCQV2MQUYPE=
X-Received: by 2002:a05:6512:68e:b0:540:1be6:f16a with SMTP id
 2adb3069b0e04-5401be6f4cbmr3387362e87.0.1733843488006; Tue, 10 Dec 2024
 07:11:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018214300.6df82178@rorschach>
In-Reply-To: <20241018214300.6df82178@rorschach>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 10 Dec 2024 16:11:16 +0100
Message-ID: <CACRpkdaTBrHwRbbrphVy-=SeDz6MSsXhTKypOtLrTQ+DgGAOcQ@mail.gmail.com>
Subject: Re: [PATCH] fgraph: Use CPU hotplug mechanism to initialize idle
 shadow stacks
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Sat, Oct 19, 2024 at 3:43=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:

> The function graph infrastructure allocates a shadow stack for every task
> when enabled. This includes the idle tasks. The first time the function
> graph is invoked, the shadow stacks are created and never freed until the
> task exits. This includes the idle tasks.
(...)
> Cc: stable@vger.kernel.org
> Fixes: 868baf07b1a25 ("ftrace: Fix memory leak with function graph and cp=
u hotplug")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

This patch regressed boot-time tracing for me.

How to reproduce:
- Enable CONFIG_FTRACE, CONFIG_FUNCTION_TRACER,
  CONFIG_BOOTTIME_TRACING
- Pass command line
  ftrace=3Dfunction_graph ftrace_graph_filter=3Ddo_idle
  to make ftrace trace this function all through the boot process.

Before this patch:

cd /sys/kernel/debug/tracing
cat trace

gives a nice trace of all invocations of do_idle() during boot.

After this patch:

cd /sys/kernel/debug/tracing
cat trace

Gives an empty trace :(

And:

cat current_tracer
function_graph
cat set_graph_function
do_idle
cat tracing_on
1

So all *is* set up, just not performing

I tried to figure out why this happens but I'm not good with tracing
internals. Any ideas?

Yours,
Linus Walleij

