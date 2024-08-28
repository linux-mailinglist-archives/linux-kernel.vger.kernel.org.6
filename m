Return-Path: <linux-kernel+bounces-304570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF839621F1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F9E01C23C86
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E5F15B10D;
	Wed, 28 Aug 2024 07:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ft8tB0vk"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A962515ADA6
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 07:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724831986; cv=none; b=NaY0GWxdAFugGOl5y15J0wWhj7YOHxZ/H2vpvkAARjWnJnJM03ivRaHQ1UiJV6ipawfHWq2CgnssCop0kW/Pr6hebsvvn6UBCzSMcDIlXe4Ajy2XxRwu8w+2iqo9Ukw5ZQ/d3cZzn4BcqUs9+SGgxGmdDbAjHyiXlfxvF5xZ4po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724831986; c=relaxed/simple;
	bh=JnlKxCdsimwP62tU4JbtAJk9KVn28iJLPP8O7ohrt9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zq9BqcONBoxzV8PwQvSo2BUWDfySVlI8YRcy0L14/7eNfUpPr6AAtZEF06Z6y9Mf1bcw5LFX2SQAP8fh6hsh/KffH0xQGqv6uQqyBG7fx1pvl2I/G/iwaqVFv/Ynf7emvCs5y1wKMsEU7uK55C+z9vW3CQPYxqH/pi4xp3HAQWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ft8tB0vk; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53349ee42a9so7637873e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 00:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724831983; x=1725436783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpbdCTKDG8BlkY8bq+95N74FpPnEcE9cjf0ykJ0s63w=;
        b=Ft8tB0vkHgGJykw7wMJ/3p/JFYt1Xfh1tgH6zbkTzlRzNBvOyIhJJK7u8FcQQuhBHm
         fSGIj0PEzjrJa61pXYiveEd1Fa2q0OicE6VjyEJDHbSw/mMDkedOffoIcdyjk/h9mA4C
         uyjloz8osvuN5EWiAbZAytASOhFFntrtBwjlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724831983; x=1725436783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vpbdCTKDG8BlkY8bq+95N74FpPnEcE9cjf0ykJ0s63w=;
        b=d1YGpLNgfhvyQY5hWyg2IjL35H8uq5KwIKyvRolUlF23xmJUYHFAWG0UVgtAi4xZAK
         Om3WQAW+TGfZ0Wb9QCb46d+x3qOTECyQhbOVZgD1jY/BKf7xgaLhIm3uKV28u4uoJ0Oa
         yHWbortfDHMbC8eIYrxEMLSybhYoBU/JG5yoh36jFctc6eMgIOioWxrUjDTf2YlAlm2y
         rLYZdLgBtg8txOIMoGFsmIMZiozgrJ8SBebOa/Gc1jtPJkUwa1m7xIWOAIg20iK+v4u6
         kGPtQVUumejCIN81IpY8qGQ74ssNMV4TyMsx1LrVcIAiU6i0TeJik5rNsqlverdk7TIC
         Zdrg==
X-Forwarded-Encrypted: i=1; AJvYcCVcfXrkszUF62oBS2qtzPeQbCYYmO/oOGtEkiGFtZBresya14jZyRkvNYAQhDyli2vElo8KVCcneZixWGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5DwOYzoGn73QmeOoDDlNoUptPS1PLxwvriVMXhJ8UvjwyXAUL
	jRRl8qNKowwzUyZJEzeakCooDdaHE9wSXjZwIAV2XGqPDqNH6uzCuKiK9GnAE8EtzQi0TI7OjVy
	t2E4tUuOyZOWcVLdjlni2Zw7JwQ091fYMW4yf
X-Google-Smtp-Source: AGHT+IEtQN2UPYArYHj3m9xXkKbP250WT7DpNjEJHdBt8d1OEprg7PRrbNSge3xwYWwIZH/ZN12tNTuf3d2deVk58QU=
X-Received: by 2002:a05:6512:694:b0:533:901:e441 with SMTP id
 2adb3069b0e04-5346c3f90afmr887636e87.10.1724831982552; Wed, 28 Aug 2024
 00:59:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827095550.675018-1-wenst@chromium.org> <20240827095550.675018-3-wenst@chromium.org>
 <Zs3kRrRW9rrfbSDP@smile.fi.intel.com>
In-Reply-To: <Zs3kRrRW9rrfbSDP@smile.fi.intel.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 28 Aug 2024 15:59:31 +0800
Message-ID: <CAGXv+5EM1B2w0Ukzx3HBMG1yT6Qq5RpOOmdSsVv9ib+H+9o2pQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] regulator: core: Fix regulator_is_supported_voltage()
 kerneldoc return value
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 10:35=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Aug 27, 2024 at 05:55:42PM +0800, Chen-Yu Tsai wrote:
> > The kerneldoc for regulator_is_supported_voltage() states that the
> > return value is a boolean. That is not correct, as it could return an
> > error number if the check failed.
>
> I don't know what error number means. Is it positive? Negative?
>
> s/error number/negative error code/g
> (Here and everywhere else)

Ack. I intended to unify them throughout the series. Looks like I missed
a couple spots.

> > Fix the description by expanding it to cover the true, false and error
>
> true and false are not what is returned, right?

What I meant to describe was true or false with regards to the function
name. I'll try to make it clear.

> > conditions. The description is also converted to a proper "Return"
> > section.
>
> ...
>
> > - * Returns a boolean.
> > + * Return: 1 if voltage range is support, 0 if not, or error number if
>
> supported

Ack.


Thanks
ChenYu

> > + *      voltage can't be changed and voltage readback failed.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

