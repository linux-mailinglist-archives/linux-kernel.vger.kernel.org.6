Return-Path: <linux-kernel+bounces-347669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B29D298D9ED
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75662285E12
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BA81D0F65;
	Wed,  2 Oct 2024 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hr1p/5NM"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A3E1D0DE5
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878304; cv=none; b=Kp0S57kUNJkm4WNCaqgLAmxUyh7T8VVI6Fo36lT33R+Yeuk0rSYjzWjEQuZAgo0MAS7lQEw+9QzJQNmi1jWWvIaX/HZbzGOYXBMToIoqF/IyUgGluia4jifA5cKpnrvBQcfEtmcf3TFslQiVWOsnw+ZFM9djt0S7uc7MQOMfVe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878304; c=relaxed/simple;
	bh=HpoHbYd+LqDp6hDnrb0w96cXSjnRiJuI3NN5woCmLrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UCph3Gu/sZOvnCF0/2+E8LivHH4qzlcshT2s9oX0lfnvkCa4vEHX98IbUR0Z0JNVADhYy213cweIxrPzBTke7lwzxZyKI8etn2csoG6Zt4srcIIbpec2O9SbrrfYjOsrM7u5fC+8tVK4GX3K2VXHa+UEZfgbbWIAeobDZe97VUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hr1p/5NM; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6dbc5db8a31so7653587b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 07:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727878302; x=1728483102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpoHbYd+LqDp6hDnrb0w96cXSjnRiJuI3NN5woCmLrk=;
        b=Hr1p/5NMikhkjaKFXZB14N3EOAEMkQDNUselow/dlsYAaoGOuzwDXDX66NoZ+z+roS
         mGOVX8HzJ8v/rXcxD3kHSHrlPlxip5xqeB4Mg6vfejrhGjgASKZnw/Qs73FjYNYU+lRk
         jrO/K6jlDIX6K25XoUGjqsldLcnHxyBV7QTD50tx5ibcwH8KTPrA2dyQ97Y9TdXTPiVy
         zy1Sku1xlrAFLn30erbewL9oneRbMOfhWCqBbFZEYtFJKFhDaBkCb7VEjeucAT3sZv+q
         uxguUvfQnLCAUvvq0AyYvKJ8iMKZAdk9VXccFNcznmEv70JzzWKGEPdEH9bhpmhi1ftp
         2wvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727878302; x=1728483102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HpoHbYd+LqDp6hDnrb0w96cXSjnRiJuI3NN5woCmLrk=;
        b=OIbxZ9DQv+3oAtPFU7YSBBi+91CllH4dxnv6E4+z+C1UODhQRz57KbD/dYqaMuVXpt
         axstmeZNCN7Ee2YA6ZYw5AZeakyivtuMQ6w7yO1XRF6j08z9fB9hwA/uNXhXhhn8gyTx
         hsJYpFsey/w6tBircqFzcCGN89+JxM70OYc9uJs73nqwSo7odL2ia1EefTjiKtK41dKp
         BonV1CVzPZdCwmLenONfkm9ykxX67QmmNKneNiEip/qV6E67xSRkgT/cka9P7MIP3FQ0
         F5h44NuPkz/9dpl5gxWEQC5GiDbc94ulh9zVSAz+GOnI99b7JkpfSNZaqs7FBokvP7BG
         ImgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGe7/mjLmNa3PC+vd8tP/HWFCc/A3FaEo2lKAQW88pnmzS05uF522/ymrKHpViJwXggudrWs3H2HW6qzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuozFu645LixOQzeFLMs5qnNaYXa+Nz+FanLbZECGBwgEGhaF9
	hxh6L/jPPamzGIXXx+DFYz54HyyZPODLNrYq14iGjwAuiFnb67glp0gAVXNQUHAB72Fs9B6mjUG
	PzZIdnzIsOBbe1vUnLzc7ShM749YpucSp6cLcNg==
X-Google-Smtp-Source: AGHT+IFyT3mY7nqsxwBi8vvgPC7AZtwmzr26AhZnRnemS+haNm+hqWU236jZHlNpT8HykqZbFa9zqzQ4LidNo9cvJeQ=
X-Received: by 2002:a05:690c:2911:b0:6e2:1c94:41f8 with SMTP id
 00721157ae682-6e2a33b439dmr20006417b3.10.1727878302231; Wed, 02 Oct 2024
 07:11:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002-zinitix-no-keycodes-v1-1-e84029601491@trvn.ru>
In-Reply-To: <20241002-zinitix-no-keycodes-v1-1-e84029601491@trvn.ru>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 Oct 2024 16:11:20 +0200
Message-ID: <CACRpkdZj57_jGDJiXgeatntUMKLdUV-GWCN=crkDRD2sUgQ95w@mail.gmail.com>
Subject: Re: [PATCH] Input: zinitix - Don't fail if linux,keycodes prop is absent
To: Nikita Travkin <nikita@trvn.ru>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jakob Hauser <jahau@rocketmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 3:02=E2=80=AFPM Nikita Travkin <nikita@trvn.ru> wrot=
e:

> When initially adding the touchkey support, a mistake was made in the
> property parsing code. The possible negative errno from
> device_property_count_u32() was never checked, which was an oversight
> left from converting to it from the of_property as part of the review
> fixes.
>
> Re-add the correct handling of the absent property, in which case zero
> touchkeys should be assumed, which would disable the feature.
>
> Reported-by: Jakob Hauser <jahau@rocketmail.com>
> Tested-by: Jakob Hauser <jahau@rocketmail.com>
> Fixes: 075d9b22c8fe ("Input: zinitix - add touchkey support")
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

BTW: Nikita have you noticed and weird offsets in your Zinitix
touchscreens? Mine seem to be off and I need to put my
fingers a bit below the actual target on the screen, consistently.
I was thinking maybe calibration support is necessary.

Yours,
Linus Walleij

