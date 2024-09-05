Return-Path: <linux-kernel+bounces-316937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4B996D740
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 888A1281A4B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9B6199E80;
	Thu,  5 Sep 2024 11:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g8E4wM4e"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAF1199252
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 11:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725536073; cv=none; b=SLSaizTQQjoQl43pa2CvuMkSgSCAIabdh9/EedeSduJlR9ZM4xjcmVasWwVlJK+e3fVpE+NAHbtr5ACgkCQhJZR1ZJ+cNCMvJxe35lA4L/g9T5HJZdjLXYoCueLVfeeHUV/MocaB3zwSDR/eqMuIkc4WN+3k4eXLGlcFM7gLh4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725536073; c=relaxed/simple;
	bh=5ACc2wYNgnLNcX0Rbs5d+42G8UuKrSfryrlzJzSAIts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rxw5s/Dh6Umjr+qhfBlqx7GM72JhK4La0alXLdSU9GGoipjly5NYvSy/HyWHZOBtASLM69rsuEDJYLAYjoIyIjryUidL9M90U04AAXNsB8kAv1tSLwjl6rIMhJR3619Gu1eh6BcI/S5wxLtUxlTU4gVwQ7ImAEefsINCVkGCdMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g8E4wM4e; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5356aa9a0afso1060879e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 04:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725536070; x=1726140870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ACc2wYNgnLNcX0Rbs5d+42G8UuKrSfryrlzJzSAIts=;
        b=g8E4wM4eX0/rRaMAO0imPk7vl4RYmgF1GzJlzpOMef7Veq66F1PPsi4pxWzZaGFi8B
         2CxYBxUBeuc7k+Bc9KiE9eH3rRmsem04AiBObbyFYZy5BLY0BLOGYOGcsSt+PjyAlmka
         YfIySOA0NZrUISoSDpfxxPSBt3I24aFI5kZ/E8D4IhMDApn84DYrvl94o6LiXVfhghuf
         aczpPhz6kf/Ja99+UzGBh9M6VY1pYXMoNcyR5QXi3tg92WMS13MIuZfMBwSNbUM4gEBi
         6EOEgHcX6iZIB9P35w2JlNHwW95mQgPXjXhPosy1w5dMFZmUerk+URrKyX8cTptx3AnO
         LibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725536070; x=1726140870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ACc2wYNgnLNcX0Rbs5d+42G8UuKrSfryrlzJzSAIts=;
        b=QLbscq/4e0kchuRz2vonZKtsaMpZl/e6AjiHj9bUwgg3b1pGxJnoATERwpu6NPFUdc
         nxSSxDSaLW2aYFDoF4JZzLk8sbix8Q5nAgWn+BJStQcGNLYPGR/g0OzSR4mSQ/iOJQXP
         6h5/7Jbb45fFMQBr6KSuOu9RFjZKlZ5qOept6bsR1hYOWLgzUNP1EeWBtNfUt93Nr9u9
         IkBbNqdZ3LCzQKzIN+WLy8sk8g929ULxUjd5YFC9giXoJajFA/hl4XixKnmE0e8sMtok
         kfyjn5tXSOXltbVeILVLBudJ2aMAIXG2PED+ty/rHcy5HHaV61boqXpWXQqKmwT5eJRy
         vExw==
X-Forwarded-Encrypted: i=1; AJvYcCWX/sIb5vgW3zMyeg/kn78RzE882eqNBGEHzU2ssbFE6xpE9oLazdoqJS+xdYeb+4PogztUsaCorlOWQf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyntmaM4k9GoyG3ovU/dOdRn4Xc27siMXsqFQZLC/qfVyNY889K
	wOrLo/KYx2R4pLoho5RyLMduJpGF9fKCeVgu9X7vYFEEErQLHjATY7HAPicSRUDjnqwjbKwV4qw
	jvnkn1MrloQMCauvODNNkze0p1h3YLTOw0TfYYQ==
X-Google-Smtp-Source: AGHT+IGVpC5Qy1+xzqQNJjgo6dnKraFl3WJ0cAbDQLCTBkwJs4Trk5ZBWVFDjUFnDKTqTHXhQMXMA4pUSY2qB55hdUg=
X-Received: by 2002:ac2:4c4a:0:b0:536:2356:5dce with SMTP id
 2adb3069b0e04-53623565f0fmr1850962e87.58.1725536069277; Thu, 05 Sep 2024
 04:34:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902133148.2569486-1-andriy.shevchenko@linux.intel.com> <20240902133148.2569486-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240902133148.2569486-3-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 5 Sep 2024 13:34:18 +0200
Message-ID: <CACRpkdZ15jP429o2STJrjArsDRbr=sE27DnwFucpvz-ksEsReg@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] gpio: stmpe: Remove unused 'dev' member of struct stmpe_gpio
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 3:32=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> There is no evidence that the 'dev' member of struct stmpe_gpio
> is used, drop it.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

