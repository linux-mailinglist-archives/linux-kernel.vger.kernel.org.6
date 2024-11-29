Return-Path: <linux-kernel+bounces-425382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7F89DC15D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCAEAB20C36
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C004175D35;
	Fri, 29 Nov 2024 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ifAlznO0"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB5B156F28
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 09:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732872153; cv=none; b=prF7QYSYwIuAQBVNKgVJDaUz3tP3DmaAhDKMZ03o/XOuainoP7dMv2b4By+O2jXyhdHNZWJQrQLNRQ2o7c1nCFe/QUT670aW61uuQ1cJDRwLhMpBDEovvlwGIbFtHHyOQpYfck6wHwMUFpz/mSOty/ZMIvTEuKf3N+BLOv4VVYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732872153; c=relaxed/simple;
	bh=JiIfkNNTfG2wLwCrL8SHt4I5iayU11reYKOyFG1OMt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcLc9fjeoARwbJj9sW5JvUdaufYAjOxRfpEm/M7husBtfyCqCixYGeNLwCe9lcpNldL+UbA6asbfBpTS/Np2dXoBf64KA5Ck0X36zJC7qdkRWdV1rPjE6LmcLAPgf3CissvqXlMAevKI9YCWxe3HrOJzoFia9zrlf5Ou8m3GrKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ifAlznO0; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-29645a83b1bso981190fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 01:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732872151; x=1733476951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JiIfkNNTfG2wLwCrL8SHt4I5iayU11reYKOyFG1OMt8=;
        b=ifAlznO0BahjWOJe/7uZG4FdNjrvuq4ZUvuQKDhjAceh+MDt1cI3hkMNzlApRTkfot
         I2wtTjzvla0yf0oLpr5exaSFBbBjuL6ZVEc1QthglX1/JqJQ7cZ18CWK7a0swuO9DKDd
         Dd4yOcSA469hD+PPUzZit8NgDwjQnnBKonpYQMTRF/kAc3Gu3ykpSVAStfbUwtcDh3GL
         tnLPrNm4y+I0tK7oHKP/WsID3u9lbqYIHv1R4MoU2UEDl8iAdtNc36iliiMKDqvSXcuA
         Cw7ydtWGR1W886MYoYJQVv2ukIYEcxE6bMYxD9GdEjCaXhyQueE89r9BKp1ui4R4bnXM
         1kKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732872151; x=1733476951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JiIfkNNTfG2wLwCrL8SHt4I5iayU11reYKOyFG1OMt8=;
        b=YgsF08BbFQdpEncTz1+3CZbbY3gmhsoUtyLCZj23i5VYua80pVjYw+UNNnup1TpRW+
         6xBDLSZXzQri5niWoEKyJoJVWZ4SozY7O3DFnUvnS9y2CCu4By43uJh+T69+2lIXFnin
         lKnXjIGj7AG05X51rRDJyaPboOYz9H+cW1BTqTB9eFbaem4v3+jG4kjCagyiwkklSiZd
         OMraneKBzsO6SSCQ+2yB5pnPcSeL88ZPX3dik7MQCKDvEm3A6g7NdxClnKUQd1uebm7X
         p4j13fX0u/O9gRXlWrg6yE9mQ7G6l/DCETSDA4/SJPCkLNqW8I+eo9WdMMjVUmeiUUJV
         vIvw==
X-Forwarded-Encrypted: i=1; AJvYcCUyady2Z4m/0+1KBlDnf4m26zoOvPdVL3sOl0LhiA56iGW7QHpH3UjUQT2kOYq0OcLKFJiAu0ausOUj/ZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfNwIsvfT/AOxbsTKS/sqyCluezsjTq2XnkqesnQRdNjRIbiNn
	i3EO8ZYrPHNsvaeFWG6CDZRd1ADchKfTFrsivqaDesb01pqB0pTQvMekJFc17ZGLOESIGDrpy2R
	/r6sW2Cz+1RpEpenFO2vKzMC4OJJDKct6zm4QvA==
X-Gm-Gg: ASbGncv/JG25xmnFhBqa27A5+v6m6noNho+d30jJ5tepQg1mSt5CxsS806h9ZhpwpHh
	UJtD66iY+NXaj8W6nrSfvVFmqmBg19b25
X-Google-Smtp-Source: AGHT+IFjSIqaNaKVZ3/NuPe/UxWWplbF+FKubgmNFJXh3rXD7HgOiYLcq/AbS7MVH0EyqYNXM/cmA1yMxrA0FbnycFY=
X-Received: by 2002:a05:6870:7d13:b0:278:2c82:e056 with SMTP id
 586e51a60fabf-29dc4199014mr6752255fac.23.1732872151330; Fri, 29 Nov 2024
 01:22:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127-gs101-phy-lanes-orientation-phy-v1-0-1b7fce24960b@linaro.org>
 <20241127-gs101-phy-lanes-orientation-phy-v1-5-1b7fce24960b@linaro.org>
In-Reply-To: <20241127-gs101-phy-lanes-orientation-phy-v1-5-1b7fce24960b@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 29 Nov 2024 09:22:20 +0000
Message-ID: <CADrjBPqUUXxjKapaSdWQz2PL8MsYVr74HCP_OqZZSG4w58_U1Q@mail.gmail.com>
Subject: Re: [PATCH 5/9] phy: exynos5-usbdrd: fix EDS distribution tuning (gs101)
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Sam Protsenko <semen.protsenko@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	Roy Luo <royluo@google.com>, kernel-team@android.com, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9,

On Wed, 27 Nov 2024 at 10:58, Andr=C3=A9 Draszik <andre.draszik@linaro.org>=
 wrote:
>
> This code's intention is to configure lane0 and lane2 tunings, but for
> lane2 there is a typo and it ends up tuning something else.
>
> Fix the typo, as it doesn't appear to make sense to apply different
> tunings for lane0 vs lane2.
>
> The same typo appears to exist in the bootloader, hence we restore the
> original value in the typo'd registers as well. This can be removed
> once / if the bootloader is updated.
>
> Note that this is incorrect in the downstream driver as well - the
> values had been copied from there.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Tested-by: Peter Griffin <peter.griffin@linaro.org>

Validated that a super-speed USB link is established between Pixel 6
phone and my laptop with this patch applied and that adb works.

regards,

Peter

