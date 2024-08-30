Return-Path: <linux-kernel+bounces-308204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D0B96589E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E10942875C4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 07:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A1C165F04;
	Fri, 30 Aug 2024 07:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XhrmPKcj"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F070156668
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 07:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725003111; cv=none; b=QTJ+tbkUyUkKuLLkvRy+ewmNrXGhj2JgXNWsuRpxDu6E8L5zZdV1MK1x2Niyl84SKOnAv2R0n2fsjrbZ/NYzuCac1vfGtszLfY1n9dCrRpQmD32k/rWIsursObgYxD3LsiN+NhR24gvEG7bbhhNkEQbuvgfVwOf6hVXVhEVRVCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725003111; c=relaxed/simple;
	bh=/BF3Mtwg6srczrK0gXdSoxW7WjXjan/9I5SDH1dgtos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NlfsNoHUj3ReXK3G8K1I941PZwNib8y6yU+5ZV4Ymc8sj5Ol3vTUGWiaa+jxKhh4L85E6dFHu750glRf9+F8EIckvLZmv/xC37HICcv0nrytc8hXjChW2YiHu7lhxSF4fb16QhoI8u97Hb/av4JttevmDi1AuZ6Ul62T1RKXeWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XhrmPKcj; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53436e04447so1657763e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 00:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725003107; x=1725607907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnQ9t5Rq6Ye4qiPnOnfkP6uRSdsutN06WdOcZC3ZNb8=;
        b=XhrmPKcjXPLqQi7IKVU0ZxQn5GK1Q47KEw+7F2aYT1cUnyChkNqODsOvMcNRXdSaSq
         ZKUTSy+OgMhT311zo7UAwaw3IBXXH6zAcEyp2InvA14VWZPr5jyx2J6yT0tuYLIujOxK
         tWz0xLQbz5Xbres6Ce8Ft4k8UwDoHKiCgCatnovxblvop9kLGVjs5JicXjvHAqhbAR1I
         mypNKeXJPBwW4Ba3wOZ2uJFFh1wjoNsoJXFjOy63OEJIZFxlbrfgSigSmhC1p6cHwwcf
         lsTqGBurMwMTon5MUizKMs5o6d4j2hAJABJNbTKopUKpY69Z+FkK6W0I5UZ+t4gKS35E
         /bOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725003107; x=1725607907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnQ9t5Rq6Ye4qiPnOnfkP6uRSdsutN06WdOcZC3ZNb8=;
        b=AJS4imY11/IO/dFHMp+mTsraGp2C4uaEqZqc9SZHjiEJiPlANIX4QmYFJRCIKHHyHy
         eFL1LHuKpe1sUJH0+OfLLcIdaOe69e+0H/rzNOeEQ0QN6pjuBHriAMVfghq5ekwO/ItV
         mo7PfaxNOoL+2sVhZhiTr080SNwhsLAeyong09xGsqR/8BQWQVfYl1AWNY6/sVSo323e
         R8OIbjY3vTBRwmdnfz0CAQOx3YannxX9I2wmVHhwh1r0BqcFAynEO+MoZWOGGgL6AuS3
         7NX/Mpbp0R0lgYQhYTY2sWX8eFrWsEg51Svgay2nmMlfvez7WfI2bk5thmmNEduw6vfI
         g5LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOIj1dW+WaPnYKML0HlQkVv+T9ebVJFIu1zfU0ZUG4tFPYWG3/WesetG7QZ7xw1eP/NdGZF8dQVwWtSxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfAZnbyRM3aCNrUtBZbNg/tQDKM/np6JpUAQJGhhGW+0vIDwLS
	ENxCxOBvm84v4DOwG64gb3QH6UGxJw7eimRdS7wDuSIJJ1/KLQbB0lMikynFykgnfuMI8sFZgLc
	RWcKL9xsNmPAIJM3H4fnqq2i83cU6IZqdKuj4tQ==
X-Google-Smtp-Source: AGHT+IEy6GDdzZX832XifIDiNs5ko5Dg6wvMflkVB0YvEDS8bSkJzhZUdu4FTj8dRQ0wPTZdoBdg/6GpBHq0+WQefyE=
X-Received: by 2002:a05:6512:234e:b0:52f:c398:8780 with SMTP id
 2adb3069b0e04-535463273bbmr436517e87.18.1725003106843; Fri, 30 Aug 2024
 00:31:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827122011.30158-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240827122011.30158-1-krzysztof.kozlowski@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 30 Aug 2024 09:31:35 +0200
Message-ID: <CACRpkdbdATtCC_c+daHgzjX7ZsD=sS6gxztubkG28_7Fop+Xhg@mail.gmail.com>
Subject: Re: [GIT PULL] pinctrl: samsung: drivers for v6.12
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Sylwester Nawrocki <snawrocki@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Peter Griffin <peter.griffin@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 2:20=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f01=
7b:
>
>   Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git tag=
s/samsung-pinctrl-6.12
>
> for you to fetch changes up to 39dbbd4e6778ac5580313ba34409855250633c61:
>
>   pinctrl: samsung: Use kmemdup_array instead of kmemdup for multiple all=
ocation (2024-08-23 15:40:55 +0200)

Pulled into my devel branch for v6.12!

Thanks a lot Krzysztof, excellent work as always.

Yours,
Linus Walleij

