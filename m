Return-Path: <linux-kernel+bounces-190710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E09BC8D0190
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 983FB28C8EB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A320316079B;
	Mon, 27 May 2024 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g9Hq1eFq"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F588160781
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816659; cv=none; b=JBfBNnygjH9g3W3N53MIIa6VqI3W+YyI8u4E3aMsz8ZsOfRrjYuMTPNzsKvrg0jBv5SAHisxYdfGZeifDUsh7jOnFKanI06E/mH9xXMdUU+ginY+Z4Dl9eWKdXRSsOozbiUIKX4tKkbOnh54DRLLf5wV7iMpYf5Up8Fhk/fd0C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816659; c=relaxed/simple;
	bh=rUiKhIQlcwiEQXJHZVELzN8Q/DITRA97u9VF6lMX/0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cRXcd1NZOZpyB4ZICfujZ97N9LIAWtMcu86YS+VSy4m5h/GxWZkmnUjliScGYLRqwlP29cplBbHjaD2cXaqpjzoPhghfxityXe+VfYz756hk9kuq2FAgAMyN5iBfbLBDHFx2BkoWAUhCUIoVZwep3qU8NTveeVK6FDHLMRHNeDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g9Hq1eFq; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-df4e0d8fa10so5253927276.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716816657; x=1717421457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUiKhIQlcwiEQXJHZVELzN8Q/DITRA97u9VF6lMX/0E=;
        b=g9Hq1eFqk1P+0xUOpwUBgGaVGLBE6+wVlilOpBRgge9xAfUVZGaS84jjKNT3+alKIO
         o2iPzVbKz6YPBC1umoxh8MLw5nUjUBt6nzr9kvgsD8KWDldIiwAFvJMwkyue9Zb1dD/+
         2rj6p97Qr3zR2y4Q9Vjp/gM0blcWvANEXlIiGRY9e/ACgZiiOgy4X3S2waKVaA082ewi
         YBuKB9XKwTa25wNO2f4DCPusQqME68XY0+tRqCelDUZIVpXLQEQBO9ZkKsCz7u26o0+P
         osK21vwqXzAzW/FQJrR8ltzo46edZdbq8iRSTYxopVaTFNlmqVd2uYgc+hLXIuooU3Nl
         yrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716816657; x=1717421457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUiKhIQlcwiEQXJHZVELzN8Q/DITRA97u9VF6lMX/0E=;
        b=Tg2JcIMLKKkLTZPXpuESUzs/8YzPnB0WNWgJZnMF1lEUDGNBNjdc3j6dDdxN3gTkoB
         daiGcvjLDwo55Av5dLAlQkt+NISv6SNTcWokDXDHZ3u4cfn+DBb7FgL+J5rgVmPuFOFG
         JvtQH7xF4fBwWz3L2nKN/P9EbuhF51ukpMv6TZj3IY5fwcszYsBvsBu/yY6oPTOHXJax
         AMZc+syIvWrTJZHw7DyyKGs97NS30AEywAMN348lyfwQ3IrMpUG7aoje5XYrXqekIpKf
         EjfynwSyCyCFFVUwxj2FXLdkw+UPfrhnLYiaKWCNFhXj6ldcOmtTj2dTqA9lNomD23M2
         Y16A==
X-Gm-Message-State: AOJu0YysGe7ladMRiM4JdT1IcmIKFBQoFdnLvBsP3S+WJ1XlR6SRcxy2
	g8yhk4wOHJq5XMtHkeIc5NSYlH8Qsh1BgicGrtT7U+8L9C5CoYjXIuuBQHObaskQhuPLgzp9Aw0
	KVobeD8ZaYZ+VBjK/IW3nPqFuSYgmrbDGHKm8iQ==
X-Google-Smtp-Source: AGHT+IHdRuKmCVmemQ0j0xgNhmtw0RYFSZB+3BIUaEd1PHa8PiK/C7Xl0eiC1i4bVQmey2JhvwqoCATjCF1e8t5KgBM=
X-Received: by 2002:a25:a545:0:b0:deb:42d2:c299 with SMTP id
 3f1490d57ef6-df7721ff9dbmr8887699276.55.1716816657463; Mon, 27 May 2024
 06:30:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508184905.2102633-1-andriy.shevchenko@linux.intel.com> <20240508184905.2102633-10-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240508184905.2102633-10-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 May 2024 15:30:46 +0200
Message-ID: <CACRpkdb3Bsv=49vJ3HYC9wndjB7Fg_5+8Es6y_q0tFpZ47ozoQ@mail.gmail.com>
Subject: Re: [PATCH v1 09/10] misc: eeprom_93xx46: Use string_choices API
 instead of ternary operator
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 8:49=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Use modern string_choices API instead of manually determining the
> output using ternary operator.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Hm. Neat actually. Starting to like the string_chioces.h more.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

