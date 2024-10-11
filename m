Return-Path: <linux-kernel+bounces-360789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 244B1999FBE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF3411F228E5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BF220C48D;
	Fri, 11 Oct 2024 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CoYKwZvP"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4796120C46C
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 09:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728637526; cv=none; b=HSsH1p5EtAVsiU8hskH5s2W/lgJ3ShfdW5bzKMhiZDCdMYKpXA5Besb8vmmNtGEu/yRIbIGRUTKfx24VXLhGuza7EGObQ/ZL0HrqMVhAIAYyYDpkOKlApty4qCZv3S2RAfIVLjK0W5nrgWRkJDX2C9d0RpaigF3hDUKbfspGxkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728637526; c=relaxed/simple;
	bh=1zfenuAoYF4a7geMFxuHrscRCvybiU6YmE0xZA9vtLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3vjWwx9zaSvBkLio621ZQanTGqogsx1x8o7yWtM1sasXKbEO9SNmON4CitI0VguutupwBE7gP5z6FeHVL5SSXIkydfSuAhCqdDMUEcIXkCM5PZWW/1j4bmIS6q4zhEhfNUC6QIaElUlMBu+iJHXmlN/Yy42OqUj+Xn2+8VQNLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CoYKwZvP; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fac187eef2so19633621fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 02:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728637522; x=1729242322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zfenuAoYF4a7geMFxuHrscRCvybiU6YmE0xZA9vtLM=;
        b=CoYKwZvPML1MCGEx1EtnoBS2VjwEeNRqvvfRNAE85gKF7hFgJ7DQy64uBrOMxJA5tC
         JH5X57J4gUqoN+tpuFs00qrDKO5WxLZfj6YaF07pc9iNxI7Z3l2omtSYUsDqY6zyyya0
         Twi3Fg0cmyPvQKA3urgPyFnGjeeLcziKfCkr4Ous5dwD4b98+2qPeqlVGvI6bJAeEg6h
         F3EtA+PfepgoGs+nfeH4ZEA/VqmVa8CL54SgEifuRSz06Ny7BO6tgwqV5LomlH25gHk5
         UI0N5SDW9O1jD9jBIDZp7yeOZ7BjcspNP7+p3OX5nNkEI3y4diSJxq54EtVElUIhq4ji
         7B1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728637522; x=1729242322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1zfenuAoYF4a7geMFxuHrscRCvybiU6YmE0xZA9vtLM=;
        b=jlcdZgDves9CJWM0W1rDXT+G7zfARgU9XUZ7M9tr+H06fOFDrgo1Y+iTjqMMkKID8J
         iUe0RcamrtOM6Jz6pPiDm7CW4bmhAuM88FWcNibez/QkFvjh9AJSFTmsH5XkkFcpqrlF
         yvTq45N94PXYvkeRElSm9XXMLXjTloZHphOi923S/xuPoG2OcpqSyVlJAGqbn4H2WHlD
         /k6FoxVX+3kV3W4bcNXb29JdPJT72g1A7RhmM0LymZ1QiqxrFouFau55Srkl0O67ouHX
         n9nSlH7A9ctsevJFJqt0MAbx/XEnKZAFtWbMvZ98Pabm6MwZEYfBTkhY+gRnUkvsdswN
         ZBTg==
X-Forwarded-Encrypted: i=1; AJvYcCWlfWUXVBkLT9Jd/a8EFRH4E46nRy6Um4UtWYmU2/x/MMZhe3pj9LlGrheiOn1VeXc2xrQb8YVDFwT6lrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxziqV8V9PbvUhD0PtoHw/pxIPosA7lah71pnxIiQaCuMtttp26
	O+KApr8JhZIa8FZ5s+wnjDjCE71dQIboOkyCTqHX0N0mnAUSwZmgMNTeQSUPpwkD3wh3ZrJ3RUr
	2PmwWd6i4KGODCsZ29rmjih63G6TgTOk/Gg+TiuPl66X4ZfY2clw=
X-Google-Smtp-Source: AGHT+IGjIHOhmW+rkh7qdlHdrYT4/PDyvv8NnEBDaf5EvMG/zHb3OIc2wlEXGA3BRCW6RcKWaTjP3ttBjdyrkypf2sc=
X-Received: by 2002:a2e:742:0:b0:2fa:fc41:cf80 with SMTP id
 38308e7fff4ca-2fb329e8c25mr7837511fa.43.1728637522372; Fri, 11 Oct 2024
 02:05:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007104052.39374-1-brgl@bgdev.pl>
In-Reply-To: <20241007104052.39374-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Oct 2024 11:05:11 +0200
Message-ID: <CACRpkda+g9Wu6tGhWsC9tQN8qLXogr58JAiB+tPfyJEojHXzqw@mail.gmail.com>
Subject: Re: [PATCH] gpio: ts4900: use generic device properties
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 12:40=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> There's no reason to use OF-specific variants of property getters.
> Switch to using the preferred, generic device property helpers.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

