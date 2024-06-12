Return-Path: <linux-kernel+bounces-211203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4CF904E6D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26EB0B27B70
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62200161937;
	Wed, 12 Jun 2024 08:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H22nylHd"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1444E16D4DF
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718182045; cv=none; b=i3kiXKfREchAujkOM9NgFa0BksekNWO7kns5U3WVM6GI3MgjzIu7wSP6hQlH2L4+wUQpm9DFgSP9NxYoblimiizBd/1iqJlPNmvG6A49To2W1Mp7jHwWYxF5fiO5p+Nqc3ddvjGn753tHnItyWj9NUfMZFr+5nvn1+GtAjFOM1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718182045; c=relaxed/simple;
	bh=thEY5o/ShqkcdWv9f38FwQGucHRsZQowS1ike3Px+EU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QvoyrbLgXd2Z1PnAWO1+wDxZvYvaN1nY845qgSxsqAIhEQBVWl3tJl/QZDywO4ZyQqz+DVnXut9rTjCa9gWuGnqyVEPmGHkqeGPOdttbDKVijvfanFVty8I8yTsaLEHUc4LTFMhIezZ5LGorCL/qidepNu0eXj4cbBjKk/wjxK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H22nylHd; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-421f4d1c057so23310285e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718182042; x=1718786842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpYxsqepRZpn/4oxNpupSBAJdfrKtBfgkfp6t0rsS5g=;
        b=H22nylHd2+1k7I9MAfh0w+tRHiz7xiNXxRCFJiVuORvYH5SFjAoHkjdngaH7B5yERn
         cQmgOoN31+7IV4df4Ef35rbNFy4aUOxZB7MZCWoLqHh9Pq1kAKfA0jHueSGzI9U36Sfi
         THpzPHn4Ns8B8d6jmpkKSzdPEWEuZTjDy+8cUmxEDodI0IJxXDW7nRuxjtINN35d/m6o
         +KDIklvLdjn5lg9YIhdtKcGSFKZZtQv1kJDUDKjJL5FN8jqfXvJuvJsLSiFJ4Si5duyf
         hHBX8nhmet8jJSYmGpZjgkZ6j6N3da83ghPbiKN2u3p67Fuh79C8r8g55ZXU2BkkyNFO
         ILKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718182042; x=1718786842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hpYxsqepRZpn/4oxNpupSBAJdfrKtBfgkfp6t0rsS5g=;
        b=WPCgkNTNOGe5g9H/wMXU9AhSn4yQcQfgcBY+czuxzZaZv2Ty6k2AMKhlVNkauU5AI8
         chHOFTodV1eR5DoGWKsqIy+T8rDa+4YzkdkeKdekf2fq795Oyyu5ay/NlBEgeGmzMp2u
         cHJljh5NmhkjxZxMoU1S3p/pG+Ssakr1HD3iAH4UvPQBA/jKeDyIepNAC0kzOzmjhPBT
         NQyMJjyFz7flTJZ1n+2zD/ScYPZ2D53sqyQz6CHo3+GEUVpX+nfG+qIwc6HKZI8oYvDB
         kpirBHqa+KYpp59dLMuQyHSDv1iWG1mmzNFsxADFqSBROZcxQrCWCI9RaqoaykpDFxXJ
         DTaA==
X-Forwarded-Encrypted: i=1; AJvYcCV4xy83lQrpbM9pOS4cN7KflPrwGmtLr5SmnK+eiTw8DHVsAse5Zb+OFrjgJ+aEY4gPZQWZTby5F7IM42c7n/AIeA1Ka2l4y/kb/99a
X-Gm-Message-State: AOJu0Yx3rV2Imp1enjkqoeJTt7zTuLDnInnA14SDkHHEqSjNKWYkSQPU
	Qg3SZJOCfQJXz+b1cuSN0gsKKbPzAsQdkfWZ7lSah1kP5c8g7Et1W0x3+iqEnof6n4Cs+ZF3xAY
	az9RBeyhcG/uUMAGeKtHoMshfJcw0hf8fWv3myYaWkivHqriaKts=
X-Google-Smtp-Source: AGHT+IGKboPzIxB9BeyAEWGYtdD8T8bNkpToXsBx4DoZghmZUY5/VvCBH45JS7ImHQeNexbYdraUIv+ahM0YJb35NXg=
X-Received: by 2002:a50:96cf:0:b0:57c:4867:6738 with SMTP id
 4fb4d7f45d1cf-57ca973f532mr916036a12.2.1718182021586; Wed, 12 Jun 2024
 01:47:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507-samsung-usb-phy-fixes-v1-0-4ccba5afa7cc@linaro.org> <20240507-samsung-usb-phy-fixes-v1-3-4ccba5afa7cc@linaro.org>
In-Reply-To: <20240507-samsung-usb-phy-fixes-v1-3-4ccba5afa7cc@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 12 Jun 2024 09:46:49 +0100
Message-ID: <CADrjBPqAEbbJ7PKgbUSWCP_AgLcz6uxvKsvc9VzOSD9jXK+scg@mail.gmail.com>
Subject: Re: [PATCH 3/5] phy: exynos5-usbdrd: make phy_isol() take a bool for clarity
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Sam Protsenko <semen.protsenko@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9,

On Tue, 7 May 2024 at 15:14, Andr=C3=A9 Draszik <andre.draszik@linaro.org> =
wrote:
>
> on / not on is just a boolean flag and is a bit misleading as currently
> on=3D=3D1 means to turn off the power, and on=3D=3D0 to turn power on.
>
> Rename the flag and make it a bool to avoid confusion of future readers
> of this code. No functional change.
>
> While at it, fix a whitespace issue in nearby comment.
>
> No functional change.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by:  Peter Griffin <peter.griffin@linaro.org>

regards,

Peter

[..]

