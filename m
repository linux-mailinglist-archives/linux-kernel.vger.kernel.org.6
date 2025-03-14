Return-Path: <linux-kernel+bounces-561172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3DCA60E48
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37BB1744F0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18111F4169;
	Fri, 14 Mar 2025 10:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vMvRlNSR"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601EA1F3BAE
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947002; cv=none; b=E4q2qbJ0/KuvtLo/lptJnHnpmxgP6TElBDwInlRvWlEPQPhYed04aiQcPkPE4HcoKQZiOMRTScMkS9PUPRKs0NKIIFc4skQe4SUDjfM6et/nZx4/UZ0qVwOCvzFzWgdyeGyb/0FWWEvgvKGnVKysFj+ssbcSa0ls1V1/d8VCt50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947002; c=relaxed/simple;
	bh=F3QwSaOPn4NwdpjOAOVwEiWSgBjE3j5kJgQ1IacYcXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CrS8n8uwmKr1YMEdW71YLwgaGzzMwkkErk/TZ/Kkq0COr+RHlh6jmHsMFBozhpz4HW87zWD0hIOS28mMFwFQjvGe+3UFMZNgXDzp63e3E+HD/otAvdroRJ0QTKZjDVNrgoXCdbWIs6fnyJeeZGzUkL3AsMV3vGOxZTUoVr9SQW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vMvRlNSR; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54954fa61c9so2350462e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741946998; x=1742551798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3QwSaOPn4NwdpjOAOVwEiWSgBjE3j5kJgQ1IacYcXQ=;
        b=vMvRlNSRybt06OEqO2onyHpbcReeoNwkoLuEKZpGLy4mjMscf5oSBND5xQBhBHbDNl
         vmheRhdmFSSG2teh3O5TV5pV8atwgWrT46KzM4YEx2X4SGrzPJ7qm+P4VDi3iTjbMPBU
         bV6hyIK+8DgNcvlokQWVlSd6xsi/AcEgh7AOpFB4mbO6IgkYRiJkXmXGG/b3OfpPn5EA
         HmL7JLcbKXOycwY9wPSEbKbanbHro10yE6WFRHTIN9eZsDr7AdcQMsskDkDJZXq1rguE
         HNgI3DYUp2dUzCwx9GpQNvfJGAxdBWdJz4jTUopQNjzJxK8Xez451dlvJ4fD+PZUJAFf
         ZUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741946998; x=1742551798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3QwSaOPn4NwdpjOAOVwEiWSgBjE3j5kJgQ1IacYcXQ=;
        b=V5d7CKL/kzY2t0ibYgNMvJbhLVy4mHE4YwiqSj8WFBvSmLBcH5jVKL0HPHGtGZeAgB
         TtEzjxzVSlOHI4dwcWo4DTKpqYeOjbJogDzB64b+mx2+BwlrFyzYLccAdFXPZRCKIi1W
         Bu/qGPnqODr+IPknhFmhe5Bki9S/aO00KHFOjJvAhLKrm8ToKgWgcne5Pz4JaKZDY2a2
         fBAjR/Ty1S3rR4DRPA6t78mZkbNiUvL+6pSH6xCqNhQQ6VnRazLjU0U50Z+weBGXuaIO
         98aiGU4+QXyO7LYOWWQpy4KmF1PitcFsSoV8biXiagGHWIxS1xMZ5ttQLEvRioet/Fzs
         XlDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwAaamYsXqFdj3sB2ZnWMFSuWtWD8meLfYyBzvWfINUILrXt2UsfBw6OGVCd2zOdizqVKECNgIh+ETSJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLikA4bdHplb5fnsl96Q7s1hgd4GfCTIOlV4Gv9NVd/712rysX
	OdU+pHdWV2Ml667dfNuk95KrXf6BfEJHeZWm/bwWGCmyTf/O1onM/AiGWQzprwAHqt2lB6j4H2N
	tTwtDLYnP5AGJQDrWzV3RjXK90W17MEiAq/sS/A==
X-Gm-Gg: ASbGncukuy+oIYIWsNpo2au7xiqyMWEsGTLg2Rb+MeYUXFJ8O/Ec63ftdTfP2ZkkOIC
	C0O5ot2SF2TbAqpYTrz7eToy0w8etLNGarlfPUKtf46j2zMd0ZOPJHTMaG7dG8rNwXv91/WbXMz
	GUjI+eD1sO6qDXOYRr6oNTFkQ=
X-Google-Smtp-Source: AGHT+IHWZgatLb9be58bX1kAFaSMI3XCjBwP8ffBHWAjyjPzK2hyikNCVCKRoFCJ+xUKiT8q/BOt0J1QEJRYD+AZIzo=
X-Received: by 2002:a05:6512:2253:b0:549:66d8:a1cf with SMTP id
 2adb3069b0e04-549c391579fmr692987e87.26.1741946998470; Fri, 14 Mar 2025
 03:09:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306-gpiochip-set-conversion-v2-0-a76e72e21425@linaro.org> <20250306-gpiochip-set-conversion-v2-2-a76e72e21425@linaro.org>
In-Reply-To: <20250306-gpiochip-set-conversion-v2-2-a76e72e21425@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Mar 2025 11:09:47 +0100
X-Gm-Features: AQ5f1JriqAfqOJFz5ou2RRXjd3t0u5tQymQhYlfYdiGbAICVLT-0grjJh4muUZo
Message-ID: <CACRpkdY5YopPADvf-s-7Ggh_pPbz-tKH+0w4-R-LQBt+h6Skjw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpio: adnp: use new line value setter callbacks
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 6:19=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> struct gpio_chip now has callbacks for setting line values that return
> an integer, allowing to indicate failures. Convert the driver to using
> them.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

