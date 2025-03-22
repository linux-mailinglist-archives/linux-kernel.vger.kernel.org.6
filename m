Return-Path: <linux-kernel+bounces-572619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B56A6CC42
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 21:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36391889285
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 20:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E59234977;
	Sat, 22 Mar 2025 20:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tWEKMJvQ"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C661C8633
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 20:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742675443; cv=none; b=SdMq/5uf4J84lxKj5ofM9TDj4JWlkfysb8HUHURXEQ3ClQtxbzq/eK0l+CCRedmHA44tyaFLdsTBvGfDM57VfPK9VLhbIIWKtPKNT27PsvH3jenZ6vRsb/7Y86IIGlwXX9tKmDLDqpefuU7YqkLOzg1wdUt6P9WixS97I1TiQ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742675443; c=relaxed/simple;
	bh=xAH+X0TSigWj+DvmaHEG+ngrQBhPB54MrJD5OazRsak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJZjxScCIGVknmTt0ZOHwA7HSbAO8ODTRggDrSmKr92OPa2zdS6LZLV7efgugUPUX+rNjNMWYN4UV23fJAmOM8orIwgGfRizXShU/CvRsj3OdEDF/EqX6CZZBhySbmvbm8aoJKbxIJmBw2YbbZUHVmWGeIewd6nhaIWgE2L/z6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tWEKMJvQ; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-543e4bbcd86so3354549e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 13:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742675440; x=1743280240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xAH+X0TSigWj+DvmaHEG+ngrQBhPB54MrJD5OazRsak=;
        b=tWEKMJvQey509fLkv8vIOXHsDyC9nVKkIT6IJyBgg1YugK08t2O5RL93qc3mR5U3ch
         3q0Za4Uu0MO1NgtNlneLM91PXwFtlLgGxnwfQd2VY5Ab17fQVCTPunS4uUCWvey/pH3x
         w6tBi2VhZ2vOz7/SWSSrIyyBn1reI+c3JTRqS8+C7rvmPQ/T5AHOG0FZAfCQUBBV8Xzg
         LjalobkjPnnVvIBf6bhz4IO0fqP4he6dLlznxI6uYdl2b76JsULwsOCSiUW9XBalIjbU
         nncy/Q4lNRmSd5lK/+jDw++sPH3c55V3N4EOpBPLwHK+PK3q7pBR8do5soaqbpeRLjn4
         Zr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742675440; x=1743280240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xAH+X0TSigWj+DvmaHEG+ngrQBhPB54MrJD5OazRsak=;
        b=Uru2LooVQOaSwan3xK597oBg25YPCx4cAXhqg8mIKbGh25L4SIwLwBqueA8b7aNLhH
         2yjDPUKWLZg009Xt6H+ssiLSe5E47pQtHMrFjCtumLoD8NzCF80XW/mOzbV8Exrmm6Zh
         5JrqWI5XD33uCNHWEwsA5+95pSgqO4ejob9wvPdLrnuf13ZCOa7qRotMjkabl+GlfoiI
         EeUsJQIbjBxCYKqQ6351SLL1tdAq31xYFc9Q4DPLftPbYLgFXTQ9EY1guRfZwJOWmqig
         kCESVXUTn8HLIWyc9GYqibgRcPmycH0alVMzLbWEOyZvruoaXqG953Yiz43aFr5hyVp3
         ikaA==
X-Forwarded-Encrypted: i=1; AJvYcCWKGjw4JNCCVfDgTNKJoPX1HjuB5blDxMYf7E2Gtv1QPsafn7g5UFDYA259jhPzrcg83FO9lUKX/q1IYbc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx57BLQHszOzcYBpKOim0uuzcJrCGtHJOFktrE1tEwNe678D7j9
	sEyXClL/unxBPBO4o5/LudYJXAw6qo7yP0J7/6R9EDVffaO1+9plZYyRaZuBrkWDxPw2swE6AVn
	pwDhWwwHvw/mGWMlA+n/oZmMN1GrewmlWue/ztQ==
X-Gm-Gg: ASbGncs+LOpXDQbi9N+V3V5h/B3GwNxrhFP9LQFYjHWkzua+ksyFMOFxAFVtzJ7xJDc
	ChbKGKHdUoOa5AgFbHnL55zSpyNdLnrVl4g7y8pyH1I4/YdtPlEO2QF/KtCoP0f+HENAsk7R7si
	0Hq6qKY8QAAwGyXrdDzNx9WrE=
X-Google-Smtp-Source: AGHT+IF/GWmh8Ou5LJqhKHFAZOmgUY9hbM0XF89CWCW9NVNXwMa3CK8yFvaZl4QoPX9YQzDKGAz5z9etUT+hR1WK5VI=
X-Received: by 2002:a05:6512:3da8:b0:545:f69:1d10 with SMTP id
 2adb3069b0e04-54ad6470acamr2374738e87.8.1742675440022; Sat, 22 Mar 2025
 13:30:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321-gpio-todo-updates-v1-0-7b38f07110ee@linaro.org> <20250321-gpio-todo-updates-v1-5-7b38f07110ee@linaro.org>
In-Reply-To: <20250321-gpio-todo-updates-v1-5-7b38f07110ee@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 22 Mar 2025 21:30:29 +0100
X-Gm-Features: AQ5f1JpofkWM1B_yZUX2sRCI3yZe2efMMWyWAKdrqNWZ2K8pTgr-x2kchrW8xEY
Message-ID: <CACRpkdZD2nJ9Fg25MuezJ3iPn6Eb+Qdu9z3P7S5wg4LxJ7G09w@mail.gmail.com>
Subject: Re: [PATCH 5/6] gpio: TODO: add an item to track the conversion to
 the new value setters
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 4:49=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Add an item tracking the treewide conversion of GPIO drivers to using
> the new line value setter callbacks in struct gpio_chip instead of the
> old ones that don't allow drivers to signal failures to callers.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Actually I have memories of thinking "we should really fix this" ages
ago, but didn't want to put it on my TBD because there were so
overwhelmingly many things to fix already. Then I forgot to add it
here instead. So:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

