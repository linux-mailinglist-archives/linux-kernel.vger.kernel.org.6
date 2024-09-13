Return-Path: <linux-kernel+bounces-328049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7291E977E54
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 13:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A647287224
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FC51D7E30;
	Fri, 13 Sep 2024 11:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nn+JiLY6"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C141C1AD7
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 11:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726226129; cv=none; b=l5MMiJFRUNHxxWlIR8o3/UIbZzqpmOz+Hi3YHYauUvxK0d1ADAXZ4cvS5zCUqgHyaEfbk9aWG3AyDOKPtFhc4b9ZzdG92joUZU8Iwfofb6meE7li2XMX8kWUEBaMf1/XSd8YIAhXNgnyW3UASn/QeaD/ZapwdNSCfqGkd5ZCLrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726226129; c=relaxed/simple;
	bh=QAKt0dqHIeTxbc4KJ5s1WHq4SqriQL6MS5+Nz7bawe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhrzmdzCaNCum3QM9WN/7uI3+AwG/uqY6O34dgNOxEE7se5v/9gctQOiF4BZClZjnMLkf6Twpr54g3SdKtDHxqDU8B1AbwCkh99eRM2erb0MWSJB+6nVG0H0N8sNlTK+NRLZiN+tcFqOUhe0PTyXnrLnl2H0Ihst2NIQnOKqr+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nn+JiLY6; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f78b28ddb6so16527581fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 04:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726226125; x=1726830925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAKt0dqHIeTxbc4KJ5s1WHq4SqriQL6MS5+Nz7bawe8=;
        b=nn+JiLY6ArW+Bzgi2mp793WiMtT7KSBCZr3VpMUeSbZk1M0OwoEG95zm2Y+L2gnk7b
         67/aAnLwm1H+gLs4Lt8HzAObSqe83P2WlHnfBOYboDMrFXsZ6clfRKnjH3J1afLmEjqX
         ALO5+pNyHEyulesNIbLAZUC/jevZq6VvhvQnJaoKUDtRSkCAbrBb35bKuRChUja2LAtZ
         BmzxVHNc5omUgI5hQHzE6t3iX7o84WpKcsTen5w73kg0ARiqaiygkgJpOZeh0Vh9YPO3
         u5N5Veyy8nN/7+amgfKvGxAQIzn7XNnGueEhksZJI35v3I72KTKaYOWsF7cPJLgveDZ9
         ndpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726226125; x=1726830925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAKt0dqHIeTxbc4KJ5s1WHq4SqriQL6MS5+Nz7bawe8=;
        b=NYSQe44xgI/bbgrAlbWGNTcn0JhRBn0bycbiOwyahn1NRa8wpz8yEDlpIgIwO3P4Bv
         8Vom6tW2fK4AR+Ewy+AapjNnlIbyuCKRvL44aUmXjmcnZithkuaY4VWAvG/cjSU9XMpg
         n1xDIEXrB4cm7lQGiDa5ZS7eT5zxPb72k3jvOF51gaf2kMkSOsY+QaQTLAQoGwHOVwde
         fDt/wg+oxZUIUCIPf3VZGNezT6UIi4ccpzxBUQ4CUk746Sf9Q96I7jjSO7KLJ8wQLhrV
         mphwuwrpLEFRBbPJ8mt+G8r0aXy0pFmxeVoSnYlvmCgHPIxPCxx8wAKRaJHy+I0yQ03j
         hqmA==
X-Forwarded-Encrypted: i=1; AJvYcCWM6EYrplK8K1cj6FZXsJlTfOGmuxzmkiLKK7/IdG/h9c77b4J9zMeGOaTBY6mWeNp+40BqgGQM+BYA3hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyG+6dMFnufVnwxgIuVjVRGtqSuqSddtqlcDnLNf/QWRJjGEwi
	El7x7pb5Url40ux1wCVii0BwBZ8hrBKUq1qvpq+ARqwFffvovPUSkrVXJyDTVkXT5DB/vyzsx3y
	pZnxytRBR5Qcmpbu7nsZLCGKWkyKwPtPVTjZR+Q==
X-Google-Smtp-Source: AGHT+IGUb8hJGZ5u9lB5WYN3D9/KS5kOXjEGy9eXRXcK8+CUNTp+w1nX/TssvKGFMvRQGNYn3GESRZrhY2iwZhGJuhM=
X-Received: by 2002:a2e:bc03:0:b0:2f0:1a8f:4cd2 with SMTP id
 38308e7fff4ca-2f787f303e5mr35050231fa.33.1726226124465; Fri, 13 Sep 2024
 04:15:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902072859.583490-1-patrick.rudolph@9elements.com>
In-Reply-To: <20240902072859.583490-1-patrick.rudolph@9elements.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 13 Sep 2024 13:15:13 +0200
Message-ID: <CACRpkdaRRFfB_HQaYQCKtdqhy7Cx-AjdtQnJVACRO13z++eLmQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: pinctrl-cy8c95x0: Fix regcache
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Andy Shevchenko <andy@kernel.org>, naresh.solanki@9elements.com, 
	andy.shevchenko@gmail.com, broonie@kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 9:30=E2=80=AFAM Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:

> The size of the mux stride was of by one, which could result in
> invalid pin configuration on the device side or invalid state
> readings on the software side.
>
> While on it also update the code and:
> - Increase the mux stride size to 16
> - Align the virtual muxed regmap range to 16
> - Start the regmap window at the selector
> - Mark reserved registers as not-readable
>
> Fixes: 8670de9fae49 ("pinctrl: cy8c95x0: Use regmap ranges")
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>

I was waiting for a follow-up fixing Andy's small remarks but now I just
applied this and fixed up the nits myself.

Yours,
Linus Walleij

