Return-Path: <linux-kernel+bounces-230560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C97917E9B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 12:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA631F26933
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D28F17C22E;
	Wed, 26 Jun 2024 10:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rqz2DK9w"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DC017C20F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719398620; cv=none; b=C6pUnpSN4aotDGcphdMZHP+Efl016UQ7asuYruvfmFdvCO1woXliYmwUZgC+QiUA5UwURB2dGyGlZYwr/9ZtsKWPsCms2SuoVk96vnS2gjhUAVCRERGLL499FFWKHVZcAPusaMtfCVP0M4Puxr8E9WdnEyQ6kgJoUwpg6OM/upA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719398620; c=relaxed/simple;
	bh=zfKJYYROJVk0RD7o7oXX/YtpHfug35jIrMT+PjI/g78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQ4i50dbiQqYYkoerVm55kQJ6U7Ya4s5xD9lmssKqLBgaYeZV6f3s8elPedc6CR6/2BQABWvMbso+FxnTO2eqCwUmkciM0Fjcr80jjT1Zluexn/sK0XL8ZHUmOVoo76Abty5WTJsBiFxH/48ORKV4JdWwKgTByRtEX2zqC1G5bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rqz2DK9w; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dfdff9771f8so6082508276.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 03:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719398618; x=1720003418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfKJYYROJVk0RD7o7oXX/YtpHfug35jIrMT+PjI/g78=;
        b=Rqz2DK9wPWbf1S1oLHOhLyGRJiYFNp7CCOjtGakcQeUZSblTUmd+Xj83fRLuyO9Fub
         qxn68J7rKAbp/KgDHIdb2eS1snIuLgnlopfxEMNNdl5wf+PXHkVIrbWyN8YQ3a4LjDjp
         UMNvUaF0NjyDrOIfyelR/uRrC0SnQc7t2l19czO7kcpn93eoMRYsmHQ7EUo7n1Y7dbKs
         GtV0/fGGrJFzuL/OsV6Bay2NRBW9AitI7del326JimBjALQeBHyLprD9Q1avqMvhgTQ5
         Yg6Bed9v9irIUSklolLog1+L29dKPJvhXrxKzMSNhgDaEDRSlxEUzpARCVN6FLdsmu1B
         EGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719398618; x=1720003418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zfKJYYROJVk0RD7o7oXX/YtpHfug35jIrMT+PjI/g78=;
        b=RR29fraMJMQOxA8rKW2OqsU5TxDnwEpfxVPSg7SpxaxyPtNOzRyYN2xeFC+s8S6vj8
         4ZnzYNAWw5HFvF7VZsl/nT6pR1BHXfh+QS8L6J2IHWyhzZACjlEDSyk51Pb2CVCSPdof
         0PxTEJQo2adREXviNJ7uLVe4YyObalD/rdhSikIeiQxigRJzpGrkMKzS1GptbZYOhLP2
         /Wh/Css3JF1byCjYAx7NCthzEv0yQWWgKldo+gCf1Qc12ed9hDjqxbc6x6aD0T1f7e/5
         L7pcEa0fRfOskqmuKdI0GWWKEj1oWuMvcjLSIfpBfDB1NRd/riJE07zH64XSY1/TXuP5
         loGg==
X-Forwarded-Encrypted: i=1; AJvYcCX2wzF87jeZPQ9Ydy3Fq7Xh5wlhzIXqrrvNOGMqVHR/Hu+cN7JOWNIwq7SK/i/ucTjuUM7lmDuuEksXNMjUuFcVP0k0eaaexPJTuvHy
X-Gm-Message-State: AOJu0YzxsWWmbXHAFHZDZ3AJuP3QCzjuJM/sfhrc2U9aupns756kzb93
	7HeoNOo599TEVhULO/1zJrZZVY5/Ocs6scMZnZv0t5Y/zkDzkPm2Y+YSRoPUnG3RcDCbYU3a3yZ
	OQwypmG2hx6AWKjcYbiPfEqKdvuDPucdaayQj3A==
X-Google-Smtp-Source: AGHT+IEVbTJEGpVxzE84hTCUXU5VaqurLl6zpCI+/BlfHHI8n2eoWxpJYzRl//T6mMWb1PBoQtdxwWGbYAqjp2ph14g=
X-Received: by 2002:a25:a464:0:b0:e03:3407:c0d with SMTP id
 3f1490d57ef6-e0334070ebfmr1539563276.30.1719398617893; Wed, 26 Jun 2024
 03:43:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Znc3JMEgF22xDVvB@google.com>
In-Reply-To: <Znc3JMEgF22xDVvB@google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 26 Jun 2024 12:43:26 +0200
Message-ID: <CACRpkdae-xqw+M-Z39NgdEQ-KUrh1uBNi5XjHZoKxJTjw-xRCw@mail.gmail.com>
Subject: Re: [PATCH] ARM: spitz: fix GPIO assignment for backlight
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Russell King <linux@armlinux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 22, 2024 at 10:42=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> GPIOs controlling backlight on Spitz and Akita are coming from GPIO
> expanders, not the pxa27xx-gpio block, correct it.
>
> Additionally GPIO lookup tables operate with pin numbers rather than
> legacy GPIO numbers, fix that as well. Use raw numbers instead of legacy
> GPIO names to avoid confusion.
>
> Fixes: ee0c8e494cc3 ("backlight: corgi: Convert to use GPIO descriptors")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>
> Linus, I am not sure if this is actually an issue, but I strongly
> suspect that it is. I have no hardware, so no means to test it, sorry.

Looks right to me,
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Maybe you can send it directly to soc@kernel.org so it can be applied?

Yours,
Linus Walleij

