Return-Path: <linux-kernel+bounces-441357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C69089ECD3F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA8CC1887E4E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0948422B5B5;
	Wed, 11 Dec 2024 13:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q0cNJEGQ"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED0C225A36
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733923986; cv=none; b=QGPlaByS3m3vPeynHDGBV4eE27U2OZ+1TUxJTi1Mef9uT/8SSy1xUyYTyA/22DA2vaa283uAoTMQIbBdoxkSxyZ2Q91xpo2akEXaXFFyfqp4gC708cliNV3yAeF/KF9hvdU4KJVtvl60gIap8MLSMPJuOyeFUdxsOBz9V00qoIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733923986; c=relaxed/simple;
	bh=kOQcwnwJSdFL36S0cYmgulVJqIFn4KDwKugZv4rxk6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GX9p7ZX+kpOzwSpuRV4n1a4CYPjiw1F/3mTRyivfGsN89JbA/RryseLkfzg8r+nipp8AQJnqRrqvUko1yYUiZO7yoGpI4tx/8/7PXC3JVBIWbbqwkqQJLGJskVSB3o8N/1ylHO1f3frKHrMKXQXqQiDSv1VXKS4Z22VX804joyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q0cNJEGQ; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54024ecc33dso2211373e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 05:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733923983; x=1734528783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOQcwnwJSdFL36S0cYmgulVJqIFn4KDwKugZv4rxk6w=;
        b=q0cNJEGQ70R/AAGAtWp4VIcegb0tcIUI0DuPk3D2f9c1K9xXl4HlKPWfJn5uyLNISE
         PwddCBstkOcc5HW7Z52d2DtJUdy5ykYclRAbHgF3RPyCwNWDDgierUCj4A+Lc6mL/KxI
         MlkvFsuU25dfwUIkbEDa/Ixsq/GEeGC9vq3vf4fOSbqG79p8ByYMw10rmy1hGIUVF684
         xvDPKXmgjSCbQWnAm0KzZUPxiiK7Iudu5r3V11Z8B9DbFlU4UBdD8YXoCN2Dd+bkabua
         1B7eoC6xYqUaacC5+XDzzj1UuLLaTfV1Q1uiVjn/FANSHlaqP3E4ydreOqSeQxQGqUcB
         ccAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733923983; x=1734528783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kOQcwnwJSdFL36S0cYmgulVJqIFn4KDwKugZv4rxk6w=;
        b=nA3uaxchtSKKqE3/+cE9WV3UpgSxIwTIgvPYR59YkSNCfWaNx+Dfc35U1pwUonIVQx
         e2ObfoEtco89uhtCh/7eNZHc+jjx2AtmXFCL72gfOjVCwplsdKxN7h4oy/B6Jx2rxh8k
         GrhtV1WjfIuRpgfHfT1Du3S8bTFXU6h4jcDjMtEfyMTF0ZAgGzzOLwLVrJyzGMaJjPvy
         J2c0k09RKkKmBzHKUsMlY1Hj8QmMKkv94AWbVqRBvH/3kYRwqnS39bqg5ywuU3iDnkxM
         ZdgHym2bzbsr14LJw/U4BbXWyv7xH45r/6+bhF6imHOofK48cn+ftK+oBs7OXZSj9xrH
         Z51A==
X-Forwarded-Encrypted: i=1; AJvYcCVPPTuxg07W0YUbMnq0wbO97aTovFm4IR20klsPXhXcMg3Dfyi3QnkDS3mCzTv7ll7fROFaB+dilRuLH4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa1Gsv1arN4q/aVPFhu5v5tF/xkcwYUIHBeuONbly20z+3CcrV
	StR161jStru4j4n3xWTUSYv3iBqEDCALKAbODfk2wI6xWdXFLKujqnF1dx4sBzHnH0cTNygJJBp
	3888r76LrB7DO+ocEwDGXZBlKDyhwYhkZFYL1OQ==
X-Gm-Gg: ASbGncu3BLg/DPG6JpBfw5SDGJKVvis38Xzt+jIirAfmozV1+//Xv6QOiwOZVYrSTvA
	BldorPmm9MHw2YDijNstFri6jPdT/vH2uFA==
X-Google-Smtp-Source: AGHT+IFSR1UjhXcHcy5k6a2CNcZJuWgxkaipEQM/YpWhqPeqodiJy0P57HJau7brIqv2XFjLP5RpxZwdcMO+4TzEqjo=
X-Received: by 2002:a05:6512:10d5:b0:540:2223:9b20 with SMTP id
 2adb3069b0e04-5402a609ac9mr779864e87.53.1733923982633; Wed, 11 Dec 2024
 05:33:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210160556.2341497-1-arnd@kernel.org> <20241210160556.2341497-4-arnd@kernel.org>
In-Reply-To: <20241210160556.2341497-4-arnd@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 11 Dec 2024 14:32:51 +0100
Message-ID: <CACRpkdZoRbJ4DwRpZQMKbEAvzg4AAdp4B+94SFLm1ssiQmjUwQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] ARM: drop CONFIG_HIGHPTE support
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, linux-rt-devel@lists.linux.dev, 
	Ard Biesheuvel <ardb@kernel.org>, Clark Williams <clrkwllms@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Matthew Wilcox <willy@infradead.org>, Peter Zijlstra <peterz@infradead.org>, 
	Russell King <linux@armlinux.org.uk>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 5:06=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> CONFIG_HIGHPTE was added in linux-2.6.32, a few years before 64-bit
> support. At the time it made sense, as the CONFIG_ARM_LPAE option allowed
> systems with 16GB of memory that made lowmem a particularly scarce
> resource, and the HIGHPTE implementation gave feature parity with 32-bit
> x86 and frv machines.
>
> Since Arm is the last architecture remaining that uses this, and almost
> no 32-bit machines support more than 4GB of RAM, the cost of continuing
> to maintain HIGHPTE seems unjustified, so remove it here to allow
> simplifying the generic page table handling.
>
> Link: https://lore.kernel.org/lkml/20241204103042.1904639-8-arnd@kernel.o=
rg/T/#u
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I'm in favor of this if the x86 patch goes in. We need to get rid
of highmem anyway and this will need to happen sooner or later
either way.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

