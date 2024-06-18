Return-Path: <linux-kernel+bounces-219059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ED890C96E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D66C1F214AF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB7413DDB6;
	Tue, 18 Jun 2024 10:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l8fZoSL/"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC6013A407
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 10:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718706462; cv=none; b=FL9fl4k2DG2ZGP0FZCYiG5BLtfXbj2mt35ecpH/AL+2Dqq8Jm5f3M6LENB31zMiLMV8x8ulfQCdiKrZLFvPAZvi00bgkwLt051/nudNhnxjCsqpbLzoWj+HOSDhwVTLmLnLAp4NJLk4wNz3eOvPUsqoWflsRFPoP3aovumPh2TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718706462; c=relaxed/simple;
	bh=gcmqJVyxQFZ9Dkmxwkmb5RhEc2M0bpgsq53KiHA3mes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WWmrqfXNGHCGAbTjhsHpGT2Ax5kk0AhyNQvdj3zvoZcmNBXqh33Jbmy4Gkqdy42bGChqporj8uBpJjrvvqnnI4hwJZDpLTjN4zU8FVDqBQ6ZEv1nhsD5+Gn2aNO/Swf2YYn4WPATpxmnzu7cHLA3l0A9fWFzI2WZmz0a1m9Y3Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l8fZoSL/; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52bc274f438so5617120e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 03:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718706459; x=1719311259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcmqJVyxQFZ9Dkmxwkmb5RhEc2M0bpgsq53KiHA3mes=;
        b=l8fZoSL/wKygKQbdcxR5oq1ib2hnbgULp6GHDolXn2OlK+uQ5d4cmQkR96ZRKaOUXl
         VbzofnvF6ahjnqb4FYWdSL/1ZPVv4gfwOCx+XwAoGoAkDVsfPeSMBGLVX8/DS/AC0SFj
         XycTdmCBX/WWKwRK8T8xD2Ap2p+LQsBMIA2xoJllAxuZaakLK7omV5K/10wFFu2r7hiP
         pXQIgV6So8mUa8lt2PaQ+fQ/RdpCK/Wpt7FT+p/qkFsh91Fgza86EVh7MgOGebsvUY/T
         TwJ3O0O8cYEKZDBfG/MYkmIH55e5nmFxriBSW8oPw2B/+hOeBWU8c5uE8MxEn8JB4t1J
         1aKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718706459; x=1719311259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gcmqJVyxQFZ9Dkmxwkmb5RhEc2M0bpgsq53KiHA3mes=;
        b=J2CU7u3NxEzC0ZPIgUnR7g8efz3lP/41yDdwXQ43AeAo3nsfG85Kj/Cjs0DUQMIw5Z
         WEFNsA1v7Nn7n2JCFcvOh/sltsB4dx2XnO1Cf47DiQ+OwyK7+89Gu7h0S3NWJDYvxKyS
         hMOSDj8BQe0elBCyAPDhLyr/4fxbNDS8Qes1esQQHHB+V6hBrYvocZYZnGEpv9zyaFzn
         9O6x1JdpaqxBZfJJ+Af+a8ifxDX6PYB0EKL1zaGGgzuIyVrpcjBZhKKHDOvyw0ZyNSgJ
         73PO82gH7LQ4oSbCyIqIHLtlyMzTh4gC8V/ZirM5KIGSlH7FfjGKUsoLI+vAN5wrTd6L
         jEoQ==
X-Gm-Message-State: AOJu0Yyb9kAju/RO7wT78BGq9sdUyiLuL+6xDrW8hsTpcvoSJ24Eoe7L
	OYEOg6P4tsDsPoYrvytkhhExBWcj+RzJMW/6M2B1typCckgabQ2T0Krm7WgyjGoXrlG21G+cZtj
	5hxmURSsvkBFC8ya3ChEJbTus6tXNEjlsB+FnWw==
X-Google-Smtp-Source: AGHT+IEOosxGF8h4Vi0Vlcp39HocNK1QEe55vxwXSy7GhxniBSbOhgo83470QwNwUe3lGYtYvOUDbWY3ewG09f/RbhY=
X-Received: by 2002:a05:6512:23a0:b0:52c:b45e:9232 with SMTP id
 2adb3069b0e04-52cb45e9398mr6742498e87.11.1718706456637; Tue, 18 Jun 2024
 03:27:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me> <20240617-ep93xx-v10-4-662e640ed811@maquefel.me>
In-Reply-To: <20240617-ep93xx-v10-4-662e640ed811@maquefel.me>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 18 Jun 2024 12:27:25 +0200
Message-ID: <CACRpkda_uMuk4AFOdQSPTWXuibH7nE3R_qSnrecboczddQw+uA@mail.gmail.com>
Subject: Re: [PATCH v10 04/38] pinctrl: add a Cirrus ep93xx SoC pin controller
To: nikita.shubin@maquefel.me
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 11:38=E2=80=AFAM Nikita Shubin via B4 Relay
<devnull+nikita.shubin.maquefel.me@kernel.org> wrote:

> From: Nikita Shubin <nikita.shubin@maquefel.me>
>
> Add a pin control (only multiplexing) driver for ep93xx SoC so
> we can fully convert ep93xx to device tree.
>
> This driver is capable of muxing ep9301/ep9302/ep9307/ep9312/ep9315
> variants, this is chosen based on "compatible" in device tree.
>
> Co-developed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Is this patch dependent on the other patches or something I can just apply?

Yours,
Linus Walleij

