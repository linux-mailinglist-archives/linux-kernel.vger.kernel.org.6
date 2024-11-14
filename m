Return-Path: <linux-kernel+bounces-408832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3659C841A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0449B21D9E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17911F4719;
	Thu, 14 Nov 2024 07:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NjY/zmBp"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B43E1F12E2
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731570095; cv=none; b=ccv1r+POmMc7FUHSWjagNUxvLc0JpbyKmyGAdYvxBlHxUvqUU7nSYVlYaO4+vyU/XcSzfznma8VE/FiKxP525VPxrQmF9Ktz90jdZ5eZd5e9HU5KiTeyTmftyeJjmAxaMZAUxnTsaAleCKf2/gz1/qpfS3XpWvoW1+8rACYXt48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731570095; c=relaxed/simple;
	bh=Y3Vt0L1iV0aJH4loN6RbVzcWMTTl2eRa5QJsLVERKNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dEmlx4jzzfurPl/K23BrG/ILxNlvytASXOR6GL7F8EjwayUBh3oHKZicru7acW4NcdfGvQApl0B0pcJpYqNphCFoVX2falwtwkk2NCn1gt6BVC23YDYL7ryn6pxlM3xkoImvrx9fjLUPuYqfMViD6IM7Sz4C2oHFDOpg9SNZmQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NjY/zmBp; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb3110b964so2343931fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 23:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731570091; x=1732174891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3Vt0L1iV0aJH4loN6RbVzcWMTTl2eRa5QJsLVERKNE=;
        b=NjY/zmBp0FwPE5Fo1boVIrdQQHqNoSCw4my3TeCIst9qKHA3yHdVQ1c0VOaNw9cPfE
         PNbvAj9A7B3i7HmI/ZVNB2B1kiR7T6IC7FaHNLTQojRE/5QuihaJLrdYZbqsjubZAygy
         WXkOUb3vDWuwBVyl5lyAknojhES3OCCv3TW7AnnEuxCnXyoest7jgiDfZwQ3Ix+weyJ7
         g1QnK86qHh5MEVvENJeFkGgkPrwWSRi5fpwrPmrx3U11ryKdUg/4P1vj50xj7PX7091e
         on5/d/Ny6nDNJPDoI8BXWZfQjKbZq+Tm/sRllfRMSsj75VU070gdTDRt6abv+E/ijUQP
         DRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731570091; x=1732174891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3Vt0L1iV0aJH4loN6RbVzcWMTTl2eRa5QJsLVERKNE=;
        b=gcjVFJE1HygweZRIGKu099coO2JDsXsEJLJuSRjZYq5IQyMRJnLHGPQdtEGlRHEcA+
         FB/w56UY1y09qjx+wp0qr+x2e0gL2nBaktn4Xt9eJlvFFt9D6uetwqtGt/D4X8CTFKPf
         5Qi6RRVUiHrR0z7GibwyZQyOaz6uq6ebsJjcuI3U+j+V1Z+LeOJzYh9yo33mXvftBDna
         bt7F46HXehOjV1lVOeeqKo778dn7XZok9ZH7toSeqKu4Fhs6/GyTcxy7EtXSRsJEvD53
         0X3LE0aqCTyGILDav5eYoQlyotjqyiW0uSqX1YbwWoIx25ykZrHMiNXGxN0il6q5TexE
         LBSQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/UHe5K4FWOeZNHp/S9DLk8bMAbZkDD9md7Hz8avj22nUJNURdeBbm/l/DMFRKcUCYPm8p9zF7i6etXKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWCRksnPZIVehQ7VqXanTAAwg6RcuBSOp8fGGONB3lYJ+i69QF
	ZNCHbROSl3n7/3W/FBj+IgxGqC7bP/UUuti1ev9xGDkoyKCreOtMXnX2n0DPbuER8nQN1xZU8uh
	Mp+T548ZdDM0SauLiWsA0hyVjnF6ztZ2O3fyx/g==
X-Google-Smtp-Source: AGHT+IFZt2WkxUHWahBdKUp4llUJ2Ksv3srUJ12mxGXyVTlk6+10rJ31ZqQkVvw0e0LHrOhB0q1fj2ksHthyPGo87Es=
X-Received: by 2002:a2e:a58c:0:b0:2fa:d31a:1b77 with SMTP id
 38308e7fff4ca-2ff5901aaa0mr3885741fa.9.1731570090943; Wed, 13 Nov 2024
 23:41:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACRpkdb6T5dqgmcVi5m_52uQ4F_wESv4K95Fk1hsZcSaUsY8xA@mail.gmail.com>
 <20241114011939.296230-1-luoyifan@cmss.chinamobile.com>
In-Reply-To: <20241114011939.296230-1-luoyifan@cmss.chinamobile.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 14 Nov 2024 08:41:20 +0100
Message-ID: <CACRpkdauGxfiobFHRJfkRYASZ3GhosTuKNPjQc5sFMhWDCR8jA@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: vfp: Fix typographical errors in vfpmodule.c
To: Luo Yifan <luoyifan@cmss.chinamobile.com>
Cc: linux@armlinux.org.uk, ardb@kernel.org, arnd@arndb.de, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 2:20=E2=80=AFAM Luo Yifan <luoyifan@cmss.chinamobil=
e.com> wrote:

> Correct the misspellings of "noftify" (should be "notify") and "swtich"
> (should be "switch").
>
> Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please put this into Russell's patch tracker.

Yours,
Linus Walleij

