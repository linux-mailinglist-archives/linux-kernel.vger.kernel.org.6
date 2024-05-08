Return-Path: <linux-kernel+bounces-173811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E93C8C05DA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 22:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2411BB236CE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF56013174E;
	Wed,  8 May 2024 20:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dfi+CvcQ"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2F412BEA4
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 20:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715201544; cv=none; b=SObvjJQ2THNIsxCN0aL9XnCRBP6vh75WiAULai5yF+I4WyvmZvtjYGBrRYfhw7CA2DBcucoOmzfwbx3Xvb+PxZM6skwW4/4DBbmSRWAVC/527BBxXRik4f/N1avm/v332wEy/Rv8rUFRookxS0FV6baD69qoIEz9bTZwS4/jDcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715201544; c=relaxed/simple;
	bh=p+hc+OA2iCLCTepSnlLlQPjrNwZJrh8G7ChR6vwC3vY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZW/P0QQm2XEYTJbMMaXnHR+ekdXj+XteOmEn4j7wcm85TfDxclsi4Xp7PKoP8L/fUBkAphvNVCbKulfOg8iaGmQDS54xcT4LyXtC69uoJXLcZsZT7AxezLkyJJe8qyxpxE4q7lJVZWjVsUNTx2shVPzsNH10Z+FFChtygIhBKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dfi+CvcQ; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-de45dba157cso183425276.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 13:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715201541; x=1715806341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+hc+OA2iCLCTepSnlLlQPjrNwZJrh8G7ChR6vwC3vY=;
        b=Dfi+CvcQ1tnVNA/9QYJx1Oe5Mu5DQU6hWMsqkFgCa5jhHR/mJS3weI40FMH9vXCOsm
         oibX0aNWzOfzGiDrxRHuGIrFFPIQZcfEv2qhhKm1Sfl0g0ENSLzSVuktIp1KiqGfBRX/
         rPMy/6vaSj1kVK7LY1181+2RWVc6czChGWyOQ02s2noe+yrjVBcTfTBE6Y+Ukuto97gd
         frQAyCMvVEkAcf6kLr7ioDoBYBtyDKP2e8sRl3QRbjtTAx0uk2dy16iQkC42Qrim2CTs
         fvlWYNIuct9DjIzeZZhaacvmwPJyvgOZIXpr7gyKphj6SKCZ+WcCKW0A0xaCQEEFIWXF
         CoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715201541; x=1715806341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+hc+OA2iCLCTepSnlLlQPjrNwZJrh8G7ChR6vwC3vY=;
        b=H4BdaAV0oXM8flCfbPGWTTfS9oAOU0GKCSrywBxxZz1j6VIz7t+Clvj9CtJb7NnCEW
         JYaOVX7C5Dd6mAv9uCDkdqcaahRAeMWSl+PUZithltcwe2egUUnFwYNloZ811Qi8Wave
         5Tr5YRUNaEv9zzigQGn4Gag/T/+Mf4J1AMMqUnWuj8XLVdw7Axjw+EOEZV1BtDohC75E
         nAGQYr7ffzwYSpMwpbDzLG9K9Nwej6Z7zqH2bSl3r7ai2M/IRcCuEJMXIL4Eh101r0ai
         cKy1e5ymwzbMpvSBREBeVgf916rEz2vnbso8DHsZ+63Tkl+AyEefqQsp4NmFYbBS6mK3
         OAFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOGVEIIhLJJLOtmZMw+d0Lps449d685aYFpeOuM+bUE9Ch46kPnXS0IYAAUuiMOYrsZfAuFYgUNCAs+S8ZJwtHBSc0uTMbBpo3yYqI
X-Gm-Message-State: AOJu0YxRwophgEaBdXcRgGYq0DIqgIvLYy409qZbHU8TIq+vfn5eAEAA
	QVWpS8b6PF4nuHG/ey975U4ql4vdFHyj09P2V585ghz+JRo3vjQTf5/Yca1/hZTYutRKqcIUyox
	/vtq529qK+afDhlwoTIu/TiMElFHtDz7d6e4N7A==
X-Google-Smtp-Source: AGHT+IF4xwRhzJxSLcmGAjfMW/Ca8OBmnmyryFGPuWCqEjcaYNQiCPcJ9EBFy8Xy7r/a++IRKIMbf67vWhWe0XdfywY=
X-Received: by 2002:a05:6902:4f4:b0:de6:b58:fe72 with SMTP id
 3f1490d57ef6-debb9dc3424mr4139892276.58.1715201539541; Wed, 08 May 2024
 13:52:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240507064445eucas1p1bfc17da4f824ef46567774634482f12f@eucas1p1.samsung.com>
 <20240507064434.3213933-1-m.szyprowski@samsung.com>
In-Reply-To: <20240507064434.3213933-1-m.szyprowski@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 8 May 2024 15:52:08 -0500
Message-ID: <CAPLW+4=0_ErruqVsSUkKfzw0+m3i8J=jn8A_SEnwLKWZX1Oyuw@mail.gmail.com>
Subject: Re: [PATCH] clkdev: fix potential NULL pointer dereference
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 1:45=E2=80=AFAM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> dev_fmt argument is optional, so avoid dereferencing it unconditionally.
>
> Fixes: 4d11c62ca8d7 ("clkdev: report over-sized strings when creating clk=
dev entries")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>

Thanks for fixing this, Marek! I tested it on the E850-96 board, and
it fixes the boot on current kernel-next for me (next-20240508). Feel
free to add:

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Tested-by: Sam Protsenko <semen.protsenko@linaro.org>

[snip]

