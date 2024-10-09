Return-Path: <linux-kernel+bounces-357433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE61B997129
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A5131F28373
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C131EBA1E;
	Wed,  9 Oct 2024 16:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NtpmUYXE"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9451EBA13
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490195; cv=none; b=Lnx7idrYF/GSJvqtOhFkvPhvuXg/A7ZCEhiWtWh9zskXGD+OGLjmFCGipnBog0O3woTtJKSvKnQ76ox4UXBHKncNYY37Pq0zsDTygYDCIhx5BtrQ5SpM3JLc58k6fnnwoORywTLP9JybgUotmrB+CR7St8fZPa1KjHrfvUkdWu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490195; c=relaxed/simple;
	bh=cPkXjlkrYtPkS1uNPAVXcBkXBjjIchWTyZV6fxFES0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qshuXQqzTPGTdYHPabRKSds35d0hQwPLqxGfQx6/OFOGDC7PI1NQp3ip40spz1UoRiCRoGDpxdd3CHe5Ta3n/Vd0F4JiAsGVcjNxqRCEImdRk7FT3VMrvIUbjDTXiqNIyfNBq2yuTlLf8DMwQJRlcEhaVNaPSSt8wqXKmntliBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NtpmUYXE; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e25d405f238so6107334276.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 09:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728490192; x=1729094992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPkXjlkrYtPkS1uNPAVXcBkXBjjIchWTyZV6fxFES0A=;
        b=NtpmUYXEbplBza7sLTVeIkYSOaQA2Y1Rmu+yyXU9prZ6ObZphlzQQFj431alKJUMCW
         OXuixK2dDsy1NzzuKbZO8LnB5rSNeApmofGHW1QaXeyfjCznXHgHyPWKha2bCF8ly+yI
         C0pjL6awcNynPMxd6qurRQ7oXfKreq4jcNe7CBNoGF+WP3GrEXh0ktkx1NKV1RZGbtrL
         gBqvUiG+BG5h6Ppb+Jk0Xx1vlGMeKOFyrEcclkly7yZC1YKkVJmtp2BUv9pyAAv7tI7/
         Ul01m6aN0tmZz9lJwoGjmdOxc0TgWvq5UUIYofZ/1SxI9n715FQSHjG8/q1yutVDHJBJ
         haCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728490192; x=1729094992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPkXjlkrYtPkS1uNPAVXcBkXBjjIchWTyZV6fxFES0A=;
        b=XRscPuhRpmdici4qDaBupDS1FHRswuA1ZaNYjwSJ5eN0et2DHskh7xtt/QLThsWMjV
         1FqewRQgAdIOthsPleJj0fU+3wVo5czWTsEwivFPz6fc+idxhmgP7QxE2L5QHqEqLsYW
         rFf05rP4pKj1mv54Vunc0+EBuc8ySNFqocoihrVYVUfXsgteI5udQCt47cIWI19R2p5m
         XpmEWzvnckdsANILHSZxQfdRWc+I8JSGJcbOxOWvbuyUjkRV2Y4Siagv1eKWFJ+XmbR9
         VVpD26S84QXX6d0i89SLAvVv7cwVSSw4lE8QFtOWh5JtRvt5MB2N1Iaq8C6ZUTo/itpy
         8kpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjQpght0lclAzn4iALwPE0gBza5biwmvAo0Ti9dyR6vMw+jWaNZYEa8DG7zn+VWOxIAqnJjF7MeDf5ZEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx27ZiAu9mwwKblv9lOsLTvAbZyRZ4TOJkmnWlSxGHBn8IQ9sLJ
	v9W7o77pHoz7vREQO2atyg3VUE/45+5bsf8j5UNFDRTe5Wp5xTVCyNn5LPKeqKtFfwUEuOJEUGW
	BJxNnm/1ljaXcbq5bvJvXC+vZVsJhJmtQBrsT5A==
X-Google-Smtp-Source: AGHT+IH31E71ejbn5Mvc5+Z+r6ftlx6TZdccjXCzROVUKamcnOKDr5jbF7avg3JbLBsQt7C8Km1tpdHhk+6+e+7bMkk=
X-Received: by 2002:a05:6902:843:b0:e16:1ebf:293d with SMTP id
 3f1490d57ef6-e28fe3e9bd5mr2208747276.20.1728490191807; Wed, 09 Oct 2024
 09:09:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004-gpio-notify-in-kernel-events-v1-0-8ac29e1df4fe@linaro.org>
 <20241004-gpio-notify-in-kernel-events-v1-2-8ac29e1df4fe@linaro.org>
In-Reply-To: <20241004-gpio-notify-in-kernel-events-v1-2-8ac29e1df4fe@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 9 Oct 2024 18:09:39 +0200
Message-ID: <CACRpkdZYOwsfMRp_96n83yNoCUYD0auZKne1PJdcOxE-=wn=UQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] gpiolib: unify two loops initializing GPIO descriptors
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 4:43=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> We currently iterate over the descriptors owned by the GPIO device we're
> adding twice with the first loop just setting the gdev pointer. It's not
> used anywhere between this and the second loop so just drop the first
> one and move the assignment to the second.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

