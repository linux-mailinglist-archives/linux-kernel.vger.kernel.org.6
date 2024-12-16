Return-Path: <linux-kernel+bounces-447015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C69C9F2C0F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0CE166EE2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4307D1FFC41;
	Mon, 16 Dec 2024 08:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="1lIz0zXr"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55B21FF7DB
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734338278; cv=none; b=dsAnKEHsQzHjd2uVTY4L2BnD4HV/NsX62MJ6l+3MH0i9eIO2U1VNsCjIAg8RBR05HnfPXL82CENYot6pIyDvE69ppFX/iHY7WBgDeSMMZmUOUy7840sjeVwK5LRJj0cwN9fgTWjjhOkSsB04avHdwslluEoNBK5C1nqwi0ndh0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734338278; c=relaxed/simple;
	bh=dwL4oyCtuYrCZ6yF/bR5QHEDHgK3LUp6b+1GIr7tsfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t16h2/5yaRmoMMduQrk9+86YGQqHNCeJv5gufIYjm7KjkB13GMkV0QB+J/A5acgdj807foinG5iUOmGOk7yoFcYIvmJ+YW0PowVidSTQlayY7NdvT3Z/OzB8Y6WMVta1MqI3Q9fpjQ5GVXbUG0afyj5Ya9mDjIot8/3UpmUHvvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=1lIz0zXr; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-303548a9361so6455671fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 00:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1734338275; x=1734943075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhuQsaT5H6o7+J7ElfZP8hf7dLA1Xda/1J2z/GHfUlo=;
        b=1lIz0zXrxz2Bt+ACzNhoBTs3FLt82bLmCAH1FFEVb5mEbrHWyKrtzKOf3XMJMsxe7x
         Ssq/KcYTCWCVmG8ntLAbrZVxwSFeQpAmALvxJxOb4L7alPYPKr3COq6PacxIA4fSsLmt
         v0rm1ASu+hDoNnhX2z58UfH/t9xYraXG7eXc4oCTAQ1+8HecsSGBqo0TY74ypooJ92Pq
         caelUONH7mdLP7TQh6REAVkHM4OUo4/TpFyyUAoobM5no8Fd2XUcUXFXgLxONlwrdb1A
         yzwc1/J/qsag14rlb2xOKoEBfQQj3pm2OYqBVe4569zPAFFX+esaMmJELkYaMDPTJ/R0
         UPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734338275; x=1734943075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhuQsaT5H6o7+J7ElfZP8hf7dLA1Xda/1J2z/GHfUlo=;
        b=N51UxJcLUWPghTHLQ8XZ5Za8CUnLmeFKNKX8DAuLTo6Q7xGX1Il6KCVnU48LRfn+gt
         /105qdUx8BsjJEa4KRFxiHixc6W1ssScv+/3bDAj4WBOCWgdbFmRYF9a+gRDoUO410gI
         c4ENvlE43bsHZurQrU52oYsbkDUJ0qSgLe5i8vKMmPYiTFU73EwgQjjmfzG8i9Zz9zpA
         Bx4M3MQAQH/hRutExquKTU/++aS4hAy8Q37w4zF4yr3k/60MxkhgZdg1JbKwhKGFm5gz
         pMod9R5BegODZYGwOAoAzbTuT/zRFmqbXZ0/6wRfYf1kEHpOw8tSR7HunisSJvAs88it
         jV7g==
X-Forwarded-Encrypted: i=1; AJvYcCUp84S/m5eXIhyxwT7gtRKvkk8nOMjsFB2BZzLN/A+URTM7Ay8zTTzekkCiyDfS+M8W6tM19QW1iVaWmQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYlfz6fpL+LW9QJiIoB6QfhUs+/b3A4v9qE7sSRJ9cNcH3P3pR
	73QPrM1onj+VwbBv76v/PZac4zxCLL4JpY8dR6mFybMtmTvsb8xBjUaGQbCcODEYGAvM9FJTCrx
	fwoowwLLaHW1GO/3YS1vf+zF+SEX8ZzigoAv8oQ==
X-Gm-Gg: ASbGnct07CCCkkAYgKYUDd5/CHICXGvqaARoMVAUwRpRblrOBTzjYhH3Rl+ivZ9Br1g
	xsJ6pWb/u7AiBZLBCuaPmfc5pk2WRab1Zzn1Qj5d/Rghi+Ls0gh1wiPSb/LzE2ParMv2xNQ==
X-Google-Smtp-Source: AGHT+IHGoOBxZInoO9/bLGpfbpoKkckOqpofRNQ0i1v/Phpq4yTUAC0eZCfCprZDfuAMk0DaFCGKGOn7jaMLHHmiaik=
X-Received: by 2002:a2e:a7c1:0:b0:302:1861:6de7 with SMTP id
 38308e7fff4ca-3025448d109mr35383821fa.24.1734338274879; Mon, 16 Dec 2024
 00:37:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202165723.17292-1-brgl@bgdev.pl>
In-Reply-To: <20241202165723.17292-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 16 Dec 2024 09:37:44 +0100
Message-ID: <CAMRc=MeNCj0kY8OGxyHMa9pOEtSeEysOhrP5cVcwyTUdF95dkA@mail.gmail.com>
Subject: Re: [PATCH] interconnect: icc-clk: check return values of devm_kasprintf()
To: Georgi Djakov <djakov@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 5:57=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> devm_kasprintf() can fail and return NULL, add missing return value
> checks.
>
> Fixes: 0ac2a08f42ce ("interconnect: add clk-based icc provider support")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/interconnect/icc-clk.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Gentle ping.

Bart

