Return-Path: <linux-kernel+bounces-211142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E7B904DA0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1DA4B26ED2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7924E16C6B1;
	Wed, 12 Jun 2024 08:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LQ0Jr4zL"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4732C16D304
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179595; cv=none; b=tjB2GNjEhrfNsLgxa291eAevr0ZZMqU+f3gmtPZcEPqjDSyGiUU4iCibyuGeP7ph+h+ROOP32VFBq+KiymThxg0a9ee/U6hcIwYwQKEVNcpBuahUpCANJeSffH2vrpaF/maGiqNRZDAbcX9MROhidEjlxOkD8R2Ma+SoYBUiz4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179595; c=relaxed/simple;
	bh=Hp+wgixUjXcH+0cXMe0p+8KZqim/yUUJ2Z/8XZttkQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIRVKVKsZbB+sfY2YQrBtT1klUZ1yAl53W4a0EPyd0IV80Ka7bHPaJfWmNImhG4AJS1sK61s6erKB0+w/66TQ1p0pEep2hyH7kVf4lzE9fWQLypnTP4x/joxk5svCf5iE1KKt3v3fpEU3ku4ABzPyYEahwD2qWfcnWXZT78UJTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LQ0Jr4zL; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57c72d6d5f3so4908774a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718179592; x=1718784392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/NUPbIh6KH2M0kCYkMVAfLrTd49vfN01minAiZapEM=;
        b=LQ0Jr4zLx38ZT+upm+lHPYzWZZdxgqJ5gk3+Bx7G6VkZg2vzu7dN3EJ+1/BupHJnGy
         cIu6W3W+dqDLffH8VH3E3DO74tccPS3CVuI9stbeahAfxfSMZPtPgXdzDJ6aA0d5c4p5
         /6T2V0VVu2xzLPXe+vPvWNfKJ3ZZtj/wXyzSXUfrQ2bQl6Ry2o34ZkBFm54r/2SrcKNZ
         C856y/hINUeX2fJIAhYB8E6rZADpjInWPAOcRdT8QKc1Ll5g9wfVkzikbmZmZNPmRyEV
         dZNAkg3W0N/dt39zZahBfUUQehV87P6PO5qKXYRiH572V8Qo2pUTGaiKcBUN2VISftPB
         kqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718179593; x=1718784393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O/NUPbIh6KH2M0kCYkMVAfLrTd49vfN01minAiZapEM=;
        b=CPjUk5xHJSj9nE/tbjwh4ujEvyld5fVSTC0FXWI3UY78sYRpUnXly5EqTASMlrZSWK
         Or4bVrjLYTyeIxkXncEIROZZwzsU4hyg2LF28YGMfqBpLzojmlJtNth6tV9mOXJeJvmy
         kKwXxpF6bolvJLfKG9Le2M/sP+5IaOrtIeIlM75jyRYuATZXZynCdQF9X27yF+2/LbZm
         zJWwKWEkrrgnMyyvgW7lTquwGT49DW2XaOj3f1N0OVlP54nDT/SzRiC84Z1ASfJucVgf
         VXXRoO5a0FFvahJq0WPRt5k7jTmJjw0bDAN7TNs2w6Fx5/GqAgcTzctbhEcN9iu90Ko/
         Dj0w==
X-Forwarded-Encrypted: i=1; AJvYcCW+vlbxpV+L14OERpW4a4/+NMcbswlzvYO6ZlS73nDzR8xwd9CtfSngzyD3iwG1qv46xl6UXeJHaTcUqOg6mMt41wX7fWXS0Zv+LOOv
X-Gm-Message-State: AOJu0YxBxcm4gMXJHnjRJT2Z75DjqW+STSG8yzqawYt5KFvHwLNfn5vy
	0c5f3WYljMlzPh6NxAS+UK/cPfjeoTc70ip2YWF57M4APeFo3bYlDUhsbNLfoHNG/ZND9p3e5Y5
	AFJ2hz0UXikDv4DsUX/RQCvSzQs7ZdCQaQA5eIg==
X-Google-Smtp-Source: AGHT+IH6OoZV1gKE9M3AfTYykV/eXXOCa0e/szV5LwhuD7ADmm+ab2ExPKHa0SiqR2zEvoqdUE6xd6qSmfp4NPHk93k=
X-Received: by 2002:a50:a419:0:b0:57c:7dee:52e4 with SMTP id
 4fb4d7f45d1cf-57ca9764b69mr562078a12.25.1718179591338; Wed, 12 Jun 2024
 01:06:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507-samsung-usb-phy-fixes-v1-0-4ccba5afa7cc@linaro.org> <20240507-samsung-usb-phy-fixes-v1-2-4ccba5afa7cc@linaro.org>
In-Reply-To: <20240507-samsung-usb-phy-fixes-v1-2-4ccba5afa7cc@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 12 Jun 2024 09:06:19 +0100
Message-ID: <CADrjBPqRq_T-bz3SXvAzYobH8R9DaZyuikdD=TzDz7PZghJVQA@mail.gmail.com>
Subject: Re: [PATCH 2/5] phy: exynos5-usbdrd: convert udelay() to fsleep()
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
> The timers-howto recommends using usleep_range() and friends anytime
> waiting for >=3D ~10us is required. Doing so can help the timer subsystem
> a lot to coalesce wakeups.
>
> Additionally, fsleep() exists as a convenient wrapper so we do not have
> to think about which exact sleeping function is required in which case.
>
> Convert all udelay() calls in this driver to use fsleep() to follow the
> recommendataion.

Nit: typo in commit message  recommendataion -> recommendation

>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Aside from that:

Reviewed-by:  Peter Griffin <peter.griffin@linaro.org>

[..]

