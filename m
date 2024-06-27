Return-Path: <linux-kernel+bounces-232336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDB691A6FD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 420E2B281C7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5245F17837F;
	Thu, 27 Jun 2024 12:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O9ORE5cA"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304DD179965
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719492738; cv=none; b=AnTLsZa+uUBYBkNvQh8Dxn0VBM0W6PXSbhaTQDTwBwk84Fl4bPlh9bVH6tekv7zwi3RtBpIjA1K2FxrEgCR6TLD7Kmonqk+pzV62i+quHFu0WH9QGNta2GYNWFLQ3DplCkQZN+uBA7VvezwyKvfKlyKzuk++BGj+NvVmO6icr4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719492738; c=relaxed/simple;
	bh=8SEy60tLgqITD2TXVw/zdvXoPhDfJC5BYVCiFB77xfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VB37bxHAgb0WrNlx7WUJvvVoZ8wDMmfOCo7fbIUyYUERpeMwUrri5ImRLV2BTjK8iIQ+N2ZrypX75mOJVa37S0P1hDALiBPUJYXV82YT6J0FD4rrHJD0bhlgMhrecvVs5MVicObZLHr5jXUFSWleeOIByV3wjVYxseVL1P6xdT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O9ORE5cA; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-700cc97b220so1452225a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 05:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719492736; x=1720097536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ryvr8s3n24BsAODCzxgbGJ2w9hKSHLd//YXsMR2ZNo=;
        b=O9ORE5cAQicCbJmnT0Q1V3kyRN38QHbIzmsds28pgnu9mhdMOPY/qXxq7D/g+SrJaY
         IEg1yso+Z/KqUpNewpFPYhkXZDgrSEaQewmd8d3FtemX2Jem+uuT3VYGDWhvvuf3TAiw
         /Jyg7VWWME45gWrWnqyK9B3iAmHwDSYAHKV7xogkAXW3WizY11LQtailHXXBMh9xr5HU
         pZofgq9EC49GgthM17yen+KoMFP1tVdBmMlUhNP/R/F+GOKL6moSJA4BPu9HyOO4nsth
         MyJiytOi2s7Y1t09rKzOr7Uuo2zKV5crdu+f9I68Q9ajaJ88hTD0osxUytGPJ1ugtGs3
         +ROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719492736; x=1720097536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ryvr8s3n24BsAODCzxgbGJ2w9hKSHLd//YXsMR2ZNo=;
        b=w6SsRgXapSYO4cVgdLopUvPGqnY7ReYKv68iuCDLf6Gt5oox8MNmjxGCn+QAQClJw8
         fUQvi8+vI6Uz0DvIyA1Rm/ToUbLRddoTFW/uRn38ETT1uCMt4Hw9iS0vycSvOmYkqJPr
         4MY0aIb49DQYwASkoa9M39lYZ4OpW+QUED6Bx24eRgEfbqvwa1jjUiyqHZobmfI4PPpX
         64iWAe3hmc1sqOYtG1kqRJm5PVU/usq4RdB5BYPF6V6ui8JYO0wxPdj+TcstjW1DQyuR
         FLMKYPylUzuF9jgzb6ZUbNztARIJNFOfhCoOqVyHBl9en2GcHXDRJknbe69dkjcxvZy1
         tAEw==
X-Forwarded-Encrypted: i=1; AJvYcCUdyFKbP1MGMxbEI/6DGYO26HAzwo8sopiCexAZNwpJh+Tlh3Z0f+yz94ESqV+4i5TanX4qi0f37NZ56c+E8FDt39ZcZi5n+ob5Z4TI
X-Gm-Message-State: AOJu0Yz/bpF2xWrzIqmzEP79jtgKM1FkCdW/ueDvuCTqNcXI7UF2C5k5
	16WZSHVESXxpq4VJj4uqplbCRB3maLWXwPRi0adrXdepu7lvEXdBBGi96zpqVQIo8PbAqJHxy1G
	DgtcCqxUmSWhHqfo2UO23qIPc4jFOQ7wsJtmWiQ==
X-Google-Smtp-Source: AGHT+IElPGgAHLr98QdJ64fPCzoCXcPRTlPI4/hq2ibEtctDV0vse/UXE4eyXhOsEJFVtJIcPQHhEMKweS4CMOEnALI=
X-Received: by 2002:a9d:6499:0:b0:6f8:fb33:baac with SMTP id
 46e09a7af769-700b11b2c34mr14344557a34.13.1719492736273; Thu, 27 Jun 2024
 05:52:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627065911.4157-1-mark-pk.tsai@mediatek.com>
In-Reply-To: <20240627065911.4157-1-mark-pk.tsai@mediatek.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 27 Jun 2024 14:52:03 +0200
Message-ID: <CAHUa44GuctLUKPgGxLd3BU7GA1wTf2ir_BwJuWHbcQD_TOU5=w@mail.gmail.com>
Subject: Re: [PATCH v2] tee: optee: ffa: Fix missing-field-initializers warning
To: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, yj.chiang@mediatek.com, 
	"ming-jen . chang" <ming-jen.chang@mediatek.com>, op-tee@lists.trustedfirmware.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 8:59=E2=80=AFAM Mark-PK Tsai <mark-pk.tsai@mediatek=
.com> wrote:
>
> The 'missing-field-initializers' warning was reported
> when building with W=3D2.
> This patch use designated initializers for
> 'struct ffa_send_direct_data' to suppress the warning
> and clarify the initialization intent.
>
> Signed-off-by: ming-jen.chang <ming-jen.chang@mediatek.com>
> Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> ---
>  drivers/tee/optee/ffa_abi.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

I'm picking up this.

Thanks,
Jens

