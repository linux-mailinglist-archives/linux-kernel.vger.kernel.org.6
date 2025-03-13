Return-Path: <linux-kernel+bounces-559017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1170BA5EE65
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10DEF17CFB0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C415F263C6B;
	Thu, 13 Mar 2025 08:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OW6BStxA"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93B72620EA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 08:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741855765; cv=none; b=tN1bfCy8+B2QCPZuc7FSGtnIBMR71XjNDJGaOkGG4U3HzTsNmFVJCJls3mKQyu3cEEtQF/Yy3a2vPieRa/5CdFBwRykLzqhv/zOpGJnDVLRg15WIHXC/i670QiK2akJT2DhWEKt17VAeol8AWRFoOQWKfNfZ+n8s06ii/HXFPDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741855765; c=relaxed/simple;
	bh=wDdfhJhBThiZUn+0LbZ9lmE9r4DbYfHvlI21cG6BxoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WCregkuOTJFcXwU6LpTIE8lmHKeTKW7yfQSZ4faPLecBq4zegO33J6KsoaD3FmQB0aCMcIuMlSP8HcQROMCV9begL5K/d93q1UBkmKOtnY7A2hT16DT1OlMYdTdHaHVV6X10EOXxXythVTon6xOBrsTwF+4K5RZQB09ocWbYM8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OW6BStxA; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5498d2a8b89so711330e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 01:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741855760; x=1742460560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cH0/G8dnIsLEQps0a+QRu5yJlelIyIdUnSqN98914W0=;
        b=OW6BStxADydn6/Me4yfuO+9rgVQfirts/pkGEyYF0ptTOMt07HdwFDTRQuO/qMZooS
         GPNVWOzl6Rgxixx1N+PYswTtC9M/1QGmrT7ByJdLA48Pd2om1+cEPZpHy7ZPoW9YNLDa
         KZPiyujMvbF93BcPEEvfo4HOCLp4Lv6obU2e4HqVsQNRRhQWBe6DaHbdTcfEt7pyDefR
         BxU+YKMuWP3o6Fq1Wcyi4IynV1wIf3lQ5FIQsQDnVUJvd2GtNxZxMeboQ/MHoA/bTchR
         dGQ09hgM/gDx0ZEo9SQR0HPofVyVzdi1CtPKsm2jh04dxURCVmMcKQqYEnKsXL0L8WCA
         K8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741855760; x=1742460560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cH0/G8dnIsLEQps0a+QRu5yJlelIyIdUnSqN98914W0=;
        b=ghuYakBPWtbnq+xEUrIxP8DUxYb7qmryUwwIlPjQKChYeG5RVxYtJw3N0cS1/gJqlm
         Tqf4nyUpfdZinw5dMaucaqrzBCBrv8t9nimNH/dIe2BExymSivpvK2hunRUX4zY6Cr2R
         cpfh0JnVaI/abzR+Be7so47+YwADF2cmpcoOKn2+hQkG8VGGlf9FRyjrIGm7LRZ3R7BS
         jScKYyWI8zkfBCmse5Sp79VMjfyFO7dsXMXcrXNFJ2ozd5du3CzJOxRx19Csl+gm9Z/8
         ZeCEtgW+L8uuzf5eS8vBhwSavINxYz4GW46uf4T7yLoKGoUeV5d7Ti4AM1vBSaE8mWNQ
         x6jw==
X-Forwarded-Encrypted: i=1; AJvYcCUO8PHZmDpbLkzXt0w77pF7Swlj6aCFBuqQ/xZNR7uD7ke3Nxy1QWDworMxwEjBiQUdvK6gKtCdh9XDqn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE5oVGzggIMyurZZUug2MQkoWJ6vn7erhS4e9A6Fg3RSSR/Lfg
	7WjaFQd4S0FACdul8Z33tGk2D9jdp2CSLD+O3A+NVe8q2sCUWxLoPU+Qs77FdRJvUih7z9Oecnz
	vRikCULQGDIEEYQGk6vA9XWWwORid+Q+KEgPIKg==
X-Gm-Gg: ASbGncv6QF1eABj9zB1P/8uz59jCVamACP/2sVaNwNdfQue4f6VrTlByp1MMz1ZeBio
	8zNV5oL7l8F13IDf//kNup2VltcE68J6XOZIF1j9LWyi/4IjHwZbNlhoqlkujI/2H8izS13r0mo
	fYIdGdfwFcYDwbIQcak2VcP4tFxQ==
X-Google-Smtp-Source: AGHT+IHZkAfEyI5h1xNp9EscwBtm7RYtlJrFqFkZLqQeebsL2P20q1EFV/vAiiJ7hbwVCtlIBk24ytpLzUux5mvsmjw=
X-Received: by 2002:a05:6512:ba6:b0:549:5b54:2c6c with SMTP id
 2adb3069b0e04-54990e673f2mr9060936e87.23.1741855759797; Thu, 13 Mar 2025
 01:49:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311-arm-fix-vectors-with-linker-dce-v1-0-ec4c382e3bfd@kernel.org>
 <20250311-arm-fix-vectors-with-linker-dce-v1-2-ec4c382e3bfd@kernel.org>
In-Reply-To: <20250311-arm-fix-vectors-with-linker-dce-v1-2-ec4c382e3bfd@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 13 Mar 2025 09:49:06 +0100
X-Gm-Features: AQ5f1Jr7N3AP_OP74JY7L1V0VadIJIbOxnWg4sgQC81ix5N9CYiTFnZob5PuCj4
Message-ID: <CACRpkdatTYZ9oxSBdjTbs-LjF3ONqcA-9vYojPc-KSGZmoEO=A@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: add KEEP() keyword to ARM_VECTORS
To: Nathan Chancellor <nathan@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Christian Eggers <ceggers@arri.de>, 
	Arnd Bergmann <arnd@arndb.de>, Yuntao Liu <liuyuntao12@huawei.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 8:44=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:

> From: Christian Eggers <ceggers@arri.de>
>
> Without this, the vectors are removed if LD_DEAD_CODE_DATA_ELIMINATION
> is enabled.  At startup, the CPU (silently) hangs in the undefined
> instruction exception as soon as the first timer interrupt arrives.
>
> On my setup, the system also boots fine without the 2nd and 3rd KEEP()
> statements, so I cannot tell whether these are actually required.
>
> Cc: stable@vger.kernel.org
> Fixes: ed0f94102251 ("ARM: 9404/1: arm32: enable HAVE_LD_DEAD_CODE_DATA_E=
LIMINATION")
> Signed-off-by: Christian Eggers <ceggers@arri.de>
> [nathan: Use OVERLAY_KEEP() to avoid breaking old ld.lld versions]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

