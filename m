Return-Path: <linux-kernel+bounces-259173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EE0939223
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 18:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69CB8B21BAD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 16:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC2216EB44;
	Mon, 22 Jul 2024 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Z83lOV5y"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7591598F4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721664013; cv=none; b=BuOjF8iUqFCd7jiCtt7IbChtL6p4y0biKzkvW1DPseMXgSxeactFT6r9pe/mPSzWS0RPIu0nT2VA5NsAHFft5USrzOdkVbjHAn6yz4TosAaQsXA7fw8CeqGMviEtYu2C0lw+XO5YpqoL2hd0He7GU0A/DN+CQEC5rXq9FMWOo3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721664013; c=relaxed/simple;
	bh=sgsAlmsE+9xzzxTOANZ5TIhAiR3frmSwNJU8OT/SLX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jEFCQ7DEks2VWkoaepzQmRmhnIGCbq5WDaCiTbWNM9eC4Xq6tShFlifw/YvVWV2j6r+IwaE7R1mI96pgKwpK09eBixtIoSQpc1b0zyJzwC28PIdXDsdNwzJvf0wAoC0qBSt+/OmKJ0ImwnD90Nm6Jov8vZtXqEDCvgEQrMgNt7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Z83lOV5y; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6E6EB3F298
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 16:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1721664008;
	bh=B79JRFTkNmY+YEKQFa2Y4q7yR0Ro15pwqlmiZVQ8ivY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=Z83lOV5yfprW056cUz/fXkkBZLkyGEK7aTUsQDIWpNJXw9vhqUBgaCwWLj6984+iB
	 /PIhxjyhWLKsT0vX/G9C0jWN2KZZ0nIxj6PDQMuGPxe84mR4QTWSfI/MVkpzAI6VgQ
	 wS9IAs+vy/8GKZmNWl0iem/XoqqcHx3WXsdUeub3WjnDhGGfkcQaduUBWotqFBAgxB
	 asfl8C/5PO0sXbg+7jxZC4FlqDRdRFH5En0uF3RrI3tKwZ7XHBl1oLJDWA+9jmgG5p
	 zYLTZV7bGsGgtXRfj1TmD+SLw1A1UC2tvtJNbjnirT8h3s/dgI0gTbT02rBwsI/GaJ
	 TvlGX9e1WKFmw==
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ef2907e21bso16614281fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721664008; x=1722268808;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B79JRFTkNmY+YEKQFa2Y4q7yR0Ro15pwqlmiZVQ8ivY=;
        b=CSmgc/6ReIiV6VI/mt0l0CwTPNlEIiTYrHs8+o9RN/rqAIyWlnBGsBEpkJDNaZBXiD
         EFzva+nQoxFwbE+unVnW3AgjstZWz1O2+dk/HJtqcHrd6PfSxUD1alKYuSJM6RO71Uwj
         HdaWpJOIgPk7PysX83aOxzbhWOiL7h/OZQkOnuSxMMQVHE26atG+Kgv0IrpRyppfcYIJ
         KhewYpGWuRM8r0alvSbCuuT7kPsiGXo+prVMz9M+XtEvR0XCtCI5j0MNIe7fYcqbjqKZ
         JQoSHd+VWZgcEw4e5AzGjAgsQxKj34vxoWRpKJIy0qqnx5sL8GTzVykuhsmFC74weg2/
         +plQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9wOjpGDZtC9HXT2Mpy1khNgomQVmhrLrOeMPDiK8ReDMGtIrSri7/WBcTwuxMKc6dvx1Zn301aHnw/bUbgOERo6YRgHFYvaGzypZf
X-Gm-Message-State: AOJu0YxNf4612RjQhsKtZ6ICkm5mm9gsxPs/oj8PoU+7Or9wMu1YHsxA
	mh/yQxtGzmam+t/Yv1YPylF/m61vvasC7mpINsB7KkrhkbdaiWbTmfKqZHPexZRsaxdvOWENfSO
	TQNpxosU2wUbV0dNJChu6zDAoXCH9CbzpChzdBqzb28E/on5+LMSElYhy1HkPHklWg7sUNArvP5
	bbLFIhG1Qd4TLgelU2veCNBSGDAGw2BChR0Ix9IdZpY7OYLNBMEnqH
X-Received: by 2002:a05:651c:2118:b0:2ef:2543:457c with SMTP id 38308e7fff4ca-2ef25435305mr50795261fa.24.1721664007850;
        Mon, 22 Jul 2024 09:00:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFllZU3ToUHoh64OSK80YFLE7hwplCpEjwEmAU20z5VUSS9Kpyn2EmhNj3OyhfEnOFDM+0ujHbolPhk5v8HvvQ=
X-Received: by 2002:a05:651c:2118:b0:2ef:2543:457c with SMTP id
 38308e7fff4ca-2ef25435305mr50795001fa.24.1721664007148; Mon, 22 Jul 2024
 09:00:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722154519.25375-2-palmer@rivosinc.com>
In-Reply-To: <20240722154519.25375-2-palmer@rivosinc.com>
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date: Mon, 22 Jul 2024 17:59:40 +0200
Message-ID: <CAJM55Z-hit+-M9qixV4FnOO-i2BsKN56QXK=LkC0FCWzSBptMw@mail.gmail.com>
Subject: Re: [PATCH v2] cache: StarFive: Require a 64-bit system
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jul 2024 at 17:47, Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> This has a bunch of {read,write}q() calls, so it won't work on 32-bit
> systems.  I don't think there's any 32-bit StarFive systems, so for now
> just require 64-bit.
>
> Fixes: cabff60ca77d ("cache: Add StarFive StarLink cache management")
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> ---
> Changes since v1 <20240719163841.19018-1-palmer@rivosinc.com>:
>
> * Drop the STARLINK_CACHE_ADDRESS_RANGE_MASK chunk, it's meaningless
>   without 32-bit support (as Emil pointed out on IRC).
> ---
>  drivers/cache/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cache/Kconfig b/drivers/cache/Kconfig
> index 94abd8f632a7..db51386c663a 100644
> --- a/drivers/cache/Kconfig
> +++ b/drivers/cache/Kconfig
> @@ -18,6 +18,7 @@ config STARFIVE_STARLINK_CACHE
>         bool "StarFive StarLink Cache controller"
>         depends on RISCV
>         depends on ARCH_STARFIVE
> +       depends on 64BIT
>         select RISCV_DMA_NONCOHERENT
>         select RISCV_NONSTANDARD_CACHE_OPS
>         help
> --
> 2.45.2
>

