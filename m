Return-Path: <linux-kernel+bounces-278000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BB394A935
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E192A1F295A7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DB2201254;
	Wed,  7 Aug 2024 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DeuTsum5"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B1320012B
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 13:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039109; cv=none; b=HAeu3MA/BRFoOsJmItV8bA9witvfpi5JUc2fS5/SFY/hVtH8UVMfqgfqPdALDgqG03YDlW8g/7oaOccakdx53kAT6g9WM83nXCyk0jFR2ucXeeWrHZfip3OkU+VUpfxZvO7jGwhHBhuJSWWyrUvBwqe+AZaSC9yQ94qPMogvh4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039109; c=relaxed/simple;
	bh=GLWJWoJDWDt0GGZarvdflK2+h7z2p92bed9kZi4O4Iw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XqU9hoCX4uf0jmesLTwMS+9mj4vq9FkH1ihRFNhxaFJgHHlgzEbzeiAlO5nLkB4FI7QC/sscQ65LkM542d+tDNgkxm852iHDIzLqTPaxVvkFp9QX5uySmBcvFplBGTedvz9w5jMBxZBmmPunjD0+pyqICqipNSaGanTkUvecZGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DeuTsum5; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so12541495e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 06:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723039105; x=1723643905; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GLWJWoJDWDt0GGZarvdflK2+h7z2p92bed9kZi4O4Iw=;
        b=DeuTsum56USKjSv8I5P3BXyKJ5xfb/Qn2sqOiq7UpW+Zk7cxQFvAqaknYwg//Dd9P5
         uKqgXk9C9hqg4jvEbFz77tM95qZFNZKmpn79tH5VHmVrRBWc0364WnEMyCitukMiBMJ2
         CalYfwdPFT/jEk5T1yc00ULwRKtCdSxL6Fe9nHjd6HqLh47XTOOCbawuA8BJUIW4DSuf
         ktQ2MKN2dY5+qBEIc+pSq4a4wQVyD1zVvFPzqeetx+0TQdyKmuorIuhfV/L1eKQxpaut
         uvWomdtW3hRBCHE3YF0iJOmnzXCAGj3uNzkR2C7r02X8ulAPzvmavIjSfLaOGauRbVjX
         AKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723039105; x=1723643905;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GLWJWoJDWDt0GGZarvdflK2+h7z2p92bed9kZi4O4Iw=;
        b=Fyka7fQncBxavMT1TTYLaMO7eYhb/ezmx+Dhl3PBurSewyWb0QyjjA/NpfkmFwHZH3
         xW7hhQ6mbLtBbRHA7S6WJ8qcTJEznitu5RPQg0yQ2xFgIN2KmNRuh6b2+HkRNKwLzdxj
         VvqtmSlAyz0lfawsG9MMMdxIkDDFqrVPRDqicbF1xTxUwn4nShz1VowlCni9Dxn2CsYe
         vAhHJVjGeFh6KxNF21yuLRo25JaDGQj09yETHo8sC4LWJ1YOWgftkUZWQpzcl2M+QIol
         6RyhDRjw2+a1ik8deV0hGD6AJ+UUVJgGB8yIDoZgEo5PdKGmLN8eZTkaPRaN57LAQsOC
         Xhtw==
X-Forwarded-Encrypted: i=1; AJvYcCWyEv8xtzaL7Ibq2XJTjgDD88ZO1Tulk8z0VhMUXOcVTdpgcw8xNTs2IW0rD6PkHf6sTUmhJOr5w8hNYCPZ9CWX2GhpQ647jAOyWJSS
X-Gm-Message-State: AOJu0YyYQUmi8OTiGCB+9emKQkexnZWSEmgdOXtuSKRZMJSWn6FHvWJr
	K8LIybwuE/O8fqlh8yzCdwZ+J2iY8u0WOa0QKL9dz8pVouBN8qNaJLksfPbofG4=
X-Google-Smtp-Source: AGHT+IHIy3NnDD4sdlQEd27JM4ubJnaDsLDt46yF51X+1USDElnWTiYyYnPMUQU+ZvzReQNa0h9tHg==
X-Received: by 2002:a05:600c:1c04:b0:428:abd:1df1 with SMTP id 5b1f17b1804b1-428e6b059fbmr121339145e9.9.1723039105282;
        Wed, 07 Aug 2024 06:58:25 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429058026b0sm30916915e9.35.2024.08.07.06.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 06:58:24 -0700 (PDT)
Message-ID: <62c027a1692c1b80652b58147d4ff215a0ada88b.camel@linaro.org>
Subject: Re: [PATCH 0/2] tty: serial: samsung_tty: simple cleanups
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>,  Jiri Slaby <jirislaby@kernel.org>, Peter
 Griffin <peter.griffin@linaro.org>, Will McVicker
 <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Date: Wed, 07 Aug 2024 14:58:23 +0100
In-Reply-To: <cef7b260-7f47-4acd-9d6c-d26b7f8cc7bf@linaro.org>
References: <20240806-samsung-tty-cleanup-v1-0-a68d3abf31fe@linaro.org>
	 <2024080714-spongy-wannabe-7a9e@gregkh>
	 <5e73f1b405e06f9ee796d3b7002933f75613728a.camel@linaro.org>
	 <cef7b260-7f47-4acd-9d6c-d26b7f8cc7bf@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1-4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-07 at 14:53 +0100, Tudor Ambarus wrote:
> Same on my side. Any idea why CONFIG_WERROR is not enabled by more
> archs? I see just the two:
> arch/x86/configs/i386_defconfig:CONFIG_WERROR=3Dy
> arch/x86/configs/x86_64_defconfig:CONFIG_WERROR=3Dy

I can't answer that, but it's an opt-in these days, see
b339ec9c229a ("kbuild: Only default to -Werror if COMPILE_TEST").
Surely if the concern at the time was runtime testing, then that
runtime testing CI infra could have disabled CONFIG_WERROR instead of
globally disabling it for everybody.

Anyway, I've updated our Pixel build env now.

Cheers,
Andre'


