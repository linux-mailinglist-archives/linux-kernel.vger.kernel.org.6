Return-Path: <linux-kernel+bounces-347529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0A398D3EF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E901F2339A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3307D1CFEC2;
	Wed,  2 Oct 2024 13:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P2A08OY2"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EA11CDFA8
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 13:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727874137; cv=none; b=hHPqkL2lCV6MT87DxTZCQAaBs3cThoa7nVHuVzi2lA4oisznU8cUsgsKKJlldfDrEND5kfuZsdVJch8wYhCOBWlK3NFBhPvLDDJ7Mh/aR/X2qOyHivc+5heBcKSJUZgFh9wMiD5bXXkM4Grzt4Rfz19c59CxsU4p6GNzZqTGIGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727874137; c=relaxed/simple;
	bh=V6+ZpVKOYtob9yUnS+bSJltLOmlfDPMLjeiE2IeEK+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O7mVxyxDqu8OO9t1D4VG1M2iCJqhEssiqJ/luj13RyqoGHovHgiMy9KQRvWh1oZ5kFOx/FM3Vj3H/FBq600rknxsvla3jojstXrFlIep7O0kTveAOlzbYbSpCh0YKAOGvMXo1RdCMYDhMa8HcLk2vAIUlU4zwGM/P0O4dydF0pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P2A08OY2; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso78026771fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 06:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727874134; x=1728478934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6+ZpVKOYtob9yUnS+bSJltLOmlfDPMLjeiE2IeEK+E=;
        b=P2A08OY2rgft/g10dgu+hU7F62V8IGNH7U0FdXMh5OZaXWElQHrrwa8x+rp6j92VQU
         ZT0c0S5bUiL2VihLsjVy/DOt/0unKfwwyLsx0L3uwZ39E5Ul8KjcI01llsiPoAZs6xb+
         ei9cv+o5Po6JtT7J2heGiK9kpG23onz0dy+9O1T4i3isrO/uDj1AWDxCMc+19kMTU5Mw
         rpKEYLpUUDr8rIgdkoSZ+2ExJ313tdxTBkXpDhfMmK87+1UfGTCPiFFZbiZVV5Z4bV5y
         Agk/Wfp+I34MiFXax84h60Nq3IAXW8+Pvp6aq5/RUXs6gNhokqYnpyC2qT/CB2Y/V3Ui
         35aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727874134; x=1728478934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6+ZpVKOYtob9yUnS+bSJltLOmlfDPMLjeiE2IeEK+E=;
        b=tgkls+YkDfNx+ktfJ9YB1ur85mqjIaIoYxUbZoQD2OQlsXs3n+yg9hAgPoYs+bBcWe
         sWTMTE8dTn5Vo6CB9bD1NxM5AYdXfZPXusNXq0VVIBM+V83khINwI4h4K3kS8iXUv3pn
         q5+Je6t50dIqi3eNs3sIc60nC0vHJzYQsE7iDehn6if45LbIZhxu6cvvbCItqSu3Yhot
         ITJBvaOcf2tglKhob6q2K+IAlkryrhNQVBMOACwrNs8NbtoUqXzkTj4ZYt92QRK9NRUw
         Kx11G3arDf7x+a8yhYKQWoIC8+BPtpMDSDcXOPrFsD5nA/uBKiNR/UK6OKnG13beGGhI
         neLg==
X-Forwarded-Encrypted: i=1; AJvYcCW8Z0i1H/YZjDY7qWfb1vmIEh50Ro/RBoReK2VEjYuOkXkfiItkWZkQ6Gd4uezwETaX40XQ7S5cHZjf5CA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZIQqKfkOsLPdPSVZNb8T3LA2bF0V8YEAC4e7+61WIWKkRbklb
	zQK9/VCiWr+DSmC+5hIgSt+xaUYyFQMPFjVFFntYOl4NCTx6qUgSo5tqlOmkCJ3faeTd8lEHJD6
	o95+zn5EaMjGSF0MCwwy6IeopBh2eUfNYhR3d4Q==
X-Google-Smtp-Source: AGHT+IE17VRzgHlUxgYGy7U0/MRfvq2+ZgvbaqzRxZ67LxJlM2/ueQxV3YOwhvf1FBPYjEvmw9ciY4+lbofbyCL4t5Y=
X-Received: by 2002:a2e:d02:0:b0:2fa:e0c4:f08b with SMTP id
 38308e7fff4ca-2fae109c4b1mr15001981fa.36.1727874133833; Wed, 02 Oct 2024
 06:02:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925095635.30452-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240925095635.30452-1-krzysztof.kozlowski@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 Oct 2024 15:02:02 +0200
Message-ID: <CACRpkdYLvt-fz2zxEwTeahGkR_iLQzioQTGwUuMc52=E33HnQQ@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation/process: maintainer-soc: clarify
 submitting patches
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, soc@kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, linux-arm-kernel@lists.infradead.org, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Will Deacon <will@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Conor Dooley <conor@kernel.org>, 
	=?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 11:56=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Patches for SoCs are expected to be picked up by SoC submaintainers.
> The main SoC maintainers should be addressed only in few cases.
>
> Rewrite the section about maintainer handling to document above
> expectation.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Conor Dooley <conor@kernel.org>
> Cc: Heiko St=C3=BCbner <heiko@sntech.de>

Very nice and to the point document.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

