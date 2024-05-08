Return-Path: <linux-kernel+bounces-172672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F028BF52A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 06:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EFF61F26225
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 04:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D85156CF;
	Wed,  8 May 2024 04:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uv80mz0C"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AEE1A2C23
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 04:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715141209; cv=none; b=GmKoF2+TBhpXxgrllNogkxijZXUpTWykoFNOD8tF/5xCdb4+Yh0r8C29L3YMMQmtYvAdVZwEl5PNaTOh1EJCByWxNjcu7z8d1QQkkKMaEfd5A3aTx83EpN8uC/wckYAleJB6qucWzY25FUnZB+mnaCNJR+GZbAnhEPOGf2ZgvpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715141209; c=relaxed/simple;
	bh=ThaP/iIA0FhQz+tdINXBQ2OCpL5MofYandZrXlsm2eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uNi/uwHRzElkfRnucVyzqV/1UgoFWIeECSDCWH4grHforjvOqe+z2W64evsCAd9pxZSpe1vJGHhPJLUauFze9ikr/uzKhvClT9kY0VGrOpsAh6t3EYyVTbW5Jx5cAhKiCgdN4gwIaJwMZMjWYCGyE7s1ntFnyyPYuCWQOFtk/rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Uv80mz0C; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6a0ffaa079dso3618886d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 21:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715141207; x=1715746007; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YE3OmvezbNJbmFg9AsFdXDjrSKNk464POBXlEe8hgAA=;
        b=Uv80mz0CRzDHrfAEUnb5jJ9aqr9u4aUts9Aa8TLiQPKg2OvlG+pCq7CTzV20Y91/8U
         HBq3XXcFmkH24dKqtqYCKxs3+4Cl21mKSVc1xsWsiLQeNehcqSVbUDbFb0rDMUH7haFM
         mtq/wnaYEwtex1s9mXQUjNvRbVJhEYwTmO5x931I842nC4/RiVjK194ZALvpKIxSFxEH
         amvEZcoLjHz/9M8WiEBSGbymWDw3JLILy+AFPZoEIfM7Hjl8h3zsEhqbs9sz9jOU1JzV
         gS/2uavjIHLr92VTSWwNFTZcOWT4V8QDIqHKPoTmXXAgxDNZFUJSmIQNMAmmEX+pj6Fp
         rTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715141207; x=1715746007;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YE3OmvezbNJbmFg9AsFdXDjrSKNk464POBXlEe8hgAA=;
        b=BjzIjrEySRfkhyYjRZkicF8JKVQlazXJpLglxMvYKUlP1T1clHBqcocmTs1wWgIOkQ
         PyECD/3yjGVVpfDX2SMFMYvV6eQ+rk4cpwueG6BB3aHo5ozP0w+RrwjASWS3VowhbXON
         Uxj39j5j4iKSTqqAIxutIF4Hg52YZ8xRC2COd394VSxrXWGHYg6H7DyZ3dnes/csGyW6
         MMXZT2mt0Co58+GcYhsIr1vk8DvKj9MHzEz7WrglP7AZZj7CdhvYLEkxzSK3wGODWX6Y
         NgjuxU4I4eZyK8PbP5S5kTplUvaF12Ir96QWu5HnU/UBAdO9nXjzuQFsa44Onp/NVl7t
         VSQw==
X-Forwarded-Encrypted: i=1; AJvYcCXiMwcjwVlhVurFvLS7wZIfVqu+Ez2iqrPR39d/idJrQffwUAf20+eYU2pmrGMsC7Y+BzzjHaGoHi8fRVwqB7hNVmWUZ6nAdL2aYS5+
X-Gm-Message-State: AOJu0YwOjWqXGIJmust7vI0cLeYuTO4o2dp0jIIl9OLhQY2U2xmE6k6T
	GXddoCdxPX6fGW12pguWDpCBFOS0afGU0PCl4K3BEvombDHEgpwEfCNgGowbm3F9gDgcuO6ZV4k
	gR8dU9RvD2KkuN87jOA5g9R2RuHL+MjQ/Y8xfDQ==
X-Google-Smtp-Source: AGHT+IHcUUK+FnWDxPpiMNuBsCYu9M7kpUkZ0Qngrv9ZJRMPE8I6eLkcdSuSNr7hBS3Of3DyHZLjyLmHSb/D/Scgt5M=
X-Received: by 2002:a05:6214:21cd:b0:6a0:e690:2f96 with SMTP id
 6a1803df08f44-6a1514bb4demr24911666d6.21.1715141206889; Tue, 07 May 2024
 21:06:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYuZd_ur56H8fwDSvUywopvn_b7ogprGkjEatQ7EPTLwYQ@mail.gmail.com>
 <11be44d3-0f32-49c6-b4ae-ba97a9f97763@app.fastmail.com> <820ddc2ec70780ae1ecd3af864dc8bd6.sboyd@kernel.org>
In-Reply-To: <820ddc2ec70780ae1ecd3af864dc8bd6.sboyd@kernel.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 8 May 2024 06:06:35 +0200
Message-ID: <CADYN=9LJCHK=TkU8y6jNFVFGNg4v4GtPEUUvvsvJ4it6X00D7A@mail.gmail.com>
Subject: Re: clkdev: report over-sized strings when creating clkdev entries
To: Stephen Boyd <sboyd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, linux-clk <linux-clk@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, open list <linux-kernel@vger.kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 May 2024 at 22:26, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Arnd Bergmann (2024-05-07 00:44:15)
> > On Tue, May 7, 2024, at 09:20, Naresh Kamboju wrote:
> > > The WinLink E850-96 board boot failed with Linux next-20240506 but there
> > > is no kernel crash log on the serial [1].
> > >
> > > Anders bisection results pointing to this commit,
> > > # first bad commit:
> > >   [4d11c62ca8d77cb1f79054844b598e0f4e92dabe]
> > >   clkdev: report over-sized strings when creating clkdev entrie
> > >
> > > After reverting the above patch the boot test passed [2].
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > >
>
> There are two fixes on the list: [1] and [2]. Perhaps one of those
> resolves this?

I applied patch [2] ontop of next-20240506 was helpful and the e850-96
board booted.

Cheers,
Anders

>
> [1] https://lore.kernel.org/r/20240507065317.3214186-1-m.szyprowski@samsung.com
> [2] https://lore.kernel.org/r/20240507064434.3213933-1-m.szyprowski@samsung.com

