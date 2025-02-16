Return-Path: <linux-kernel+bounces-516857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D5BA37874
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 00:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C38881665CD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 23:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F2B1A3177;
	Sun, 16 Feb 2025 23:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KzVR2OqT"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180E017D346
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 23:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739747894; cv=none; b=aL9IvLeM+o9TzKnhvasUhZ43GJtiUwGfSCtpi8DJ6MUgQlola1VbHz6+VlvwwNp3zTxjgldzvQpEB+Fwzu+dZ5gvo1y0HO7hxiu8c0pXcC0/eBK58BNSclRJGIETKozHWtmMzPFDvKYv8iSdLwuqpK5ivfuCCIB78Umju1AyqUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739747894; c=relaxed/simple;
	bh=+bAqTBhrAThIXvpuQvboYe7dAvPcu2hd3DhUbwVIyS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LtdaNo8ZIGPHzn0ix25N7hPI+wCdHf312GKp/bez/0cGizya3KWy3o1F4LD4Az7qF/fCAr5SMPnOc7MKf6O0yJDrEWJRVW+IUb4avxX+3BOx9IvyOAb9ajNdeM64k3HAjlr/FC4TKJrtBTdEW6sJmXbo4sL5gEWfTV7wkM/rY1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KzVR2OqT; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-307325f2436so30501541fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 15:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739747891; x=1740352691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bAqTBhrAThIXvpuQvboYe7dAvPcu2hd3DhUbwVIyS4=;
        b=KzVR2OqT967+7vlMuxXlMZYmohEEp/kMrlg0E8UwCqo5ACPcCmOkZDdnzGNC3xaz0X
         c6ob/6gOLvcpSkbOaAzDF7e6Csz90jH6EqBbiSGCMhTZGJ0fnyOxGztKwrAe/BzTfReU
         Y19UDyecdvwlH/JfU91Zh1xVUFUwBpcu12jkn6CP5BJN4+aES+Zrd1Y57VoQ6Z0PrTa6
         USH2rIsEcCrGpP/GJA2pKMRBohPO5mjLkfHVW4D+2jv6a/u6XlVaWOW4EloA8nQOFxZD
         1hWD+8M3aA3ajTDHF+zVT4YWV5zrPnU3gaZrB8039Pb6Rejv7me/DsE2igc2uSzK7/c6
         g/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739747891; x=1740352691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+bAqTBhrAThIXvpuQvboYe7dAvPcu2hd3DhUbwVIyS4=;
        b=it8I0u+w+tHdW8zijCviGYYQ7TRnE+cn0W+l2awObzJfnC/Xuq3fzEeYsXwugMgv0b
         8AhneddMZ3ISxC1XZ4yqax0xtbxzDz6XGEejGmzBgD1ioqW6u71+uldAmhGVrAfJKJJI
         EeWOdvtdUl40mJA5o9s2D7thFeLQe6DArnWhKlKGvXv/9hXIWy32chT/A1t70e2lg9+Y
         DxozteypiMuG03omOM+H1UyPEqbyig5BOwWSfa3i7JF4/li3Pam1AFGOFHXMXrAwSprO
         zHQgNuumom1MGIqssV1rDgXIB7xRWaxbwT5TD+UmGGbuuIuGrzFKuT7lLVTD+6YKVAs+
         q7Gw==
X-Forwarded-Encrypted: i=1; AJvYcCXNQ7aGZ+gKEI9VPvGiw3dw+Hnpaw8negzCJs8YnYNRJh7O4xMen24rkaSczLf3mivrIsyODDZViQhqCko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+3D1jRiAdgsmoz/p8fFtaAhnNjNzvxZF2ZxUjcmVQLrg2Pfo+
	P/BSP3fAmh3F0LeEbATjyqrN+BnLM/Kaz9OeIx79YejZsuULbY2Tz398p600NyESZv8WZPjzrsu
	KDtKcPOz5k6WPq89pARJ5QTA/kg3QcCJm3JIlVA==
X-Gm-Gg: ASbGncvc1gTRRoDda3G4iia9/LMUPJC8Il1ZbvcHevZiEANh8FeFqOF9GExC7YHhU/B
	d/CDb7TQPOT0b9TILSemaAeCqK6eaiVWSJeDhBmcvHnrMH4wgRvXzICNXeJmO0/CY+SJj2qVT
X-Google-Smtp-Source: AGHT+IH/OWXvrol1+DdRrFrzWglz3AqCuNE43oqbEWm7V54q9GVCswPDnbSkJPvotsmoZT4v+6bsiaAYAPbgKv7XEdo=
X-Received: by 2002:a2e:80d8:0:b0:308:f827:f8e4 with SMTP id
 38308e7fff4ca-30927a59c85mr17193991fa.7.1739747891108; Sun, 16 Feb 2025
 15:18:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205095243.512292-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250205095243.512292-1-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 17 Feb 2025 00:18:00 +0100
X-Gm-Features: AWEUYZlC_cindjOgw85q9grQQ8yCUl2UyiaEPS3QjFkrs5er0YSYXY6AOy6niqA
Message-ID: <CACRpkdZAAszLedDTANa-v+s0-6XTJOqVSVnWvyRwu5Z-RiOoDw@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] pinctrl: cy8c95x0: Clean up series
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Patrick Rudolph <patrick.rudolph@9elements.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 10:52=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> This a set of the cleanups I have collected so far while testing
> the driver on Intel Galileo Gen 1 last year.

Patches applied now that -rc3 is out!

Yours,
Linus Walleij

