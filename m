Return-Path: <linux-kernel+bounces-360627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 211AA999D6D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DAD61C22D6B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1330B209686;
	Fri, 11 Oct 2024 07:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IwB5TRzj"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC29D1CEEBD
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728630366; cv=none; b=V7Hei0lF0Tf3kg3VicgQ2Yj4Xm2YWYv+z/EUDiWFExuTdl8CJoHB/8XM6g2VJsuvP5QMIebzN8oU+WFgCQSArFOTPhyxGozZRtqcJH8YF3NhyE8rZrhVbnLGuOLbnM/cbLr1J51ol5qVwq6z6DdSdUzpWscbxgE1iBXSst3IcyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728630366; c=relaxed/simple;
	bh=UYWmRPOJ9agPa54+7bFHUne6XJDZ4rsf7JqfyugsRJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRY1Tnl4DxIYx2aeDWTjaN7EOIU4zpaZqWTcKCqMYAtz7RKU2+VwE9ngk6+zNwTXqKa1qXBRjDpX63ALbYBYza0kHzVve65RI7tppXCkxHBldjb8uA651jgC1ibYU9pp8kffeTzoYKZxURsS8j0th/iHM75en4mYLMVZk9njkeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IwB5TRzj; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb2f4b282cso6107551fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 00:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728630363; x=1729235163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYWmRPOJ9agPa54+7bFHUne6XJDZ4rsf7JqfyugsRJg=;
        b=IwB5TRzjW1ZTRbx3yt+onCkz52zjrn1fi/CBJLTHDxusfJGYuME+szQzc9F7C6o3yu
         pr4qWqgDy8LVWWOrXPGIpwrH/hqfM/E1o1YZeK+gXl5niW3Kv89aar5DA9ltVchAN6aQ
         g/AWbJ1q6ODS1oDxKBd2jMlzrZ/1QARYqnrGE6JEwxvVJ6MSXOISXhqsoHEvsXVm+1bm
         rul0esGAIOIOj7/wZker9kibxA4Dcc1Yy/59WcoELOrAi8A2s4AFyUH3aDp8ZH8qAtXe
         w13soXnyHiM0ddI456sxI5LC1Ye59e3+16wSsu5Ujc+vYC6ewSlQ98d+ec2eTYIlxCQi
         XcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728630363; x=1729235163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYWmRPOJ9agPa54+7bFHUne6XJDZ4rsf7JqfyugsRJg=;
        b=VVW0Dgsd7KvXGL5lS0pjaLu/x8W5ExT/IjgHJOMH3+lzpk8JrM4ojzD2jNfj3QlFCn
         wAkhs8WSjNhMNkDRTCtvRl3SUhIuSaaGkDOW8lWQa+qB3ubFKrHQlKeCr9AGeRR7AyLa
         z++ag4rtq8mScEBGFtVhp4+0xE9MHg+dUYQDUGBV7YC6TeIDczFwbWIdz+4rR48bp9mr
         oddoIlwTx3v/LwjmeIfBSe9g19d8qNk25ppbA72TBIZ3DQPNm0at3vM74GKEBFoWDjwj
         M30To0dF9Wl1lTHW3YsK+ZiLXVSoomThuSzIFMmlkzc3eJJYa9X385GX0pCrNsAM5TLD
         3sDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpOb5CE7ONWJupp61Y9Q8Pvx9h3WeLmqlS1r8TxZP8GgqdkVxn6oaIiDavootc25TqOVOvwCtEwT8l/Nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTot339/0pbgje0Do9GNX9PglndxAQki+vxB5xmzcANP5FLBD/
	AvUmlAlQJcLHaVDu0YQyCqntmkoqehSKXd40krFjmPwzoeRsPVjl37j6PYMlrZ/2VuIlcLVIG26
	RJchub2V9JZ9NQ/p72OcU0PCmRvdZXpnMBu8/9vV0VzmRVlA1d5s=
X-Google-Smtp-Source: AGHT+IG8zV2+iAyrrbJ4WDMnZQFSISzC1s84X7Xtp+3otAX9bwU3ugO5M90Syf8AIdg5cszVYklkeEzk34c4PQQiivI=
X-Received: by 2002:a2e:bc10:0:b0:2f6:5f0a:9d00 with SMTP id
 38308e7fff4ca-2fb3270597emr6660451fa.1.1728630362991; Fri, 11 Oct 2024
 00:06:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009162910.33477-1-brgl@bgdev.pl> <20241009162910.33477-2-brgl@bgdev.pl>
In-Reply-To: <20241009162910.33477-2-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Oct 2024 09:05:52 +0200
Message-ID: <CACRpkdaMzN3pps=Fm9YC0i9HB2GYLa1C4vaO1QB27KpUBiR1vA@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: mpc8xxx: use generic device_is_compatible()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 6:29=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> This driver doesn't need to include of.h and use OF-specific interfaces.
> Use generic property helpers instead.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

