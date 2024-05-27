Return-Path: <linux-kernel+bounces-190685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA848D015D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7C1E1F21C1B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DE615EFBF;
	Mon, 27 May 2024 13:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GX6aFElK"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065AB15EFB8
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816304; cv=none; b=qMIOTni2+Fm0XRsTuUzB3jJHqKjs0v89c/GQq5IeIUGTkGxEIodgvkAJzwt/yg58NnFhTBA2mz5c4RdwhcmCezw7jW98Er+YZJJGusGyyEHe4JC2GqYoKuPdv2hZIMsWNPltcZPoRH6cO9louXIIs0ZqGfsnYvh4rsSRyyM+Ve8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816304; c=relaxed/simple;
	bh=CQ6QFnP2deDpvp3Pj7oNizzTCPgYn5yROzn1dc6gUJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PffKzazYI1GB8bSjsk3hNmUPGCFbCxgYL2TewjiKXYmZcJDowZNZHBuCHNXmzbItIT699YAeOhCToO0QLV0lqbdoVRxJ3KrBn0isOnEeu3UNamaRWnycoemm7lAnYvPLNq1iy5jlk0XmiFplQSr9Bv6Ubykg+EtB5/iH1pGzVK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GX6aFElK; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-62a080a171dso31600407b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716816302; x=1717421102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQ6QFnP2deDpvp3Pj7oNizzTCPgYn5yROzn1dc6gUJE=;
        b=GX6aFElKK7u+h/K8jDC4n0pKU9+8DjxGsOjF+VvFBjQfjzbFnA+20Q35RpTlLxh3Jn
         CIsz+bwM2wRv1l7ibGCxqKIP8NB/Nlgyu0GDbIC9AS8xIfspE8NXwAWzFcSr7glIOooe
         4HxcLZzmfWkCaR96VbfHPm06oWwUUYrOaAnhW5yPqePK7fLFPBTcJEwQVQX/Dexdap6d
         UBc9796Tww7pJxe+mxAfK6O2OTEbg6v+STguCf4oRsnK69edMu13I9D9wYrEUo5azcuW
         U1MKarOp6VBLlti+MtXoyj92URNZeBzVjI0Q1qCj6NWYjo2wGV6+cpJ1qvidspDwlxTq
         REQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716816302; x=1717421102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQ6QFnP2deDpvp3Pj7oNizzTCPgYn5yROzn1dc6gUJE=;
        b=b0LOMagvouMybjikwGTfDi4w//ubwTyiayzq2duyCERU0lWiImwXizAde0li3Z9xQR
         cXmaLQXIJDpvkLG60eVGQx3qcgbaG7x8VRjSkijEuWLF33TeD7oDT07dHod7Fu0ca9L5
         4aXv4jvp+xq3JcPl8qkAId0JcBhfqtTzRWl7kzFDIm73f6E+xd3krHiz14wNvsbZN2bf
         fx9hXr1cGN7T1FcumSs2WJN4GHLZBaszmI31XMIQUhbI90BSgMS3RxxKI8G7Bj7l2xfC
         uNGVk2j1qD+GraL/9tRwfgrlpwvLn99O6s8eVTfMF8bYQhG0HVOTx8aikS+O2kULdvCt
         KtHg==
X-Gm-Message-State: AOJu0YwfeouGJPtLj34azIIO5OlF8JjwomO9/bidj+SgQGphrJpxEc7Q
	CS8SQ4C9l5szG3IYJ6YwWZgMvy3h9dgW1rGOgrlyU9W9U6AG4YzxI6sYZRtbeVg68QOq1H0SSH9
	wvgUXgq52SJXpJXOjfbBjdAoCOPKheaC2iMt9xA==
X-Google-Smtp-Source: AGHT+IFva1a/cQkBiyWvE7gUZAS0TVsAW0fRcqJHDA9tmjBCLMZvIEDmvw/hk2OUWJb0h0vbuBejxk7aTe8N+86gM/k=
X-Received: by 2002:a05:6902:1021:b0:de5:549b:dc9e with SMTP id
 3f1490d57ef6-df772385ecbmr10475413276.57.1716816301823; Mon, 27 May 2024
 06:25:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508184905.2102633-1-andriy.shevchenko@linux.intel.com> <20240508184905.2102633-5-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240508184905.2102633-5-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 May 2024 15:24:51 +0200
Message-ID: <CACRpkdaSU97+aA4fvVZT=ay2e9g8pjbX0dMO23gFF8+sn5S88A@mail.gmail.com>
Subject: Re: [PATCH v1 04/10] misc: eeprom_93xx46: Hide legacy platform data
 in the driver
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 8:49=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> First of all, there is no user for the platform data in the kernel.
> Second, it needs a lot of updates to follow the modern standards
> of the kernel, including proper Device Tree bindings and device
> property handling.
>
> For now, just hide the legacy platform data in the driver's code.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

