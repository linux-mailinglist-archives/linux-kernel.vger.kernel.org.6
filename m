Return-Path: <linux-kernel+bounces-339290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924A6986232
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFCA81C2735F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0065F381C2;
	Wed, 25 Sep 2024 15:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="omoHMJqQ"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FFC38FA6
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276512; cv=none; b=BaNYkTU6A2tuHDEo/NxQ5zCoQ9pkefbVePOuQqYTNDJtuoz4wENa6AuCkXde8yUCbwAkJv6JY17ufX8x3nTjvaKxKG5+E7zUNTJpcXTQa10tk4N6+jRrW5rHgyhZqgAxj9KfEbHgsLyIrONlvyevuPSOmGV9Krud/K3+8vIE8SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276512; c=relaxed/simple;
	bh=HyezUH8s4vB3bE8d9XKTG58UQRvZwYgHO4cj+l8WGCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5CeQERugO6M4nxfZFct2aDfvKYp1RyX460Y/DtLEF2oWwtQy9lWABcaW2HVCYTtOR7pRHH2c6Y/fAegvi6PGGEbhdjVr6TmUr+9CcJAjyGHRi9gGYFAhyap0E7CISJvxBwALq5RH8Lc+Be1GI0kHm25kx3aVh7kbM0qKUxYlR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=omoHMJqQ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37ccc600466so277507f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727276508; x=1727881308; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a+DIs+cjfT3JD55mRAd2TBTt3EC9HtAmYb81V/vRFFU=;
        b=omoHMJqQQquU9+SzmRf3jVcybk8bIgw6mPAn8HvsvvA5Uh/hC26ISRJ1EzH8ZNhUU5
         91NEqnK+pFsdMWz2Qs+PULlGV1LGlphOQUB9jsgD0o46p79hKbBgs0Be4vTETUD290cL
         Q5GD0UAzyuFgLOBSP8MbfYtJQ/PEW2Fw7mDdd5tWgsykY8m1FEDOHRy08xB5s+EQ6TOx
         0Xh/n5HMNGtApTpFY3g7ZhmpzGR76xOAg92ju3E7Vcx+ytQQibJQf//UyCUcZyUI0yKG
         KEqVLNmLBmHLcGZQ9n0vh+1oUntWgTDgT49wIY+970scMo+EhnmuKMoRYSFhWGqregbA
         5lDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727276508; x=1727881308;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a+DIs+cjfT3JD55mRAd2TBTt3EC9HtAmYb81V/vRFFU=;
        b=JKuKq5KU5iEnfRjxqqDZQo/RfSP2q6vgVbhCVrErGym2c9z7bAOU4V2QtU2v3V1ijF
         aa35S8460qAP5mWmN7q+Iu2lptmLJtd1031KPfFCmvT2N6Ymb5YJuJhL48YKNJfO/eg+
         9Gf0UM9iA8i5uonAsZpB4tuSm3MaedZ2KbzjKa542o2rkFwL2lxDgoQFXi6RBQgQpr1Z
         rjDfPrQV+TavWsogUY5oLPUFTkv1RPBz8CnK67eGrX+kAeUPrWWZYY3/q/iOLKGp3D5I
         PTeh2F9fj14o40v/hsl1QIL3ZjeU4RhLOBhYNiLHSh3xHydpAI3+3J2Ls6cbLLR2kCvW
         loOg==
X-Forwarded-Encrypted: i=1; AJvYcCXa1x/eX/akhzKdtkPbDwqTDu1DvnSCKRW1v63CENkeIjBom531FAsWxr1vMsn/8gUOy0KMamryIYdU/4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpSX3aKmNSdpcnWHK1OsQlC+wS2KiIJfEEupqnfJ1P1mFYriOV
	05vBzTKOjZFjEVnlUSRs3kJkY+HdZV3Q2AUa/AuSNf77glMBp2nxvhlGO+YDFgg=
X-Google-Smtp-Source: AGHT+IHfbzpphdy6WAUwhQp1pcPNJKsRYShLsVQDedS0f/0PBeU1GtCFcb/lDjITm8qpA3o3J6cTfg==
X-Received: by 2002:adf:f5d2:0:b0:374:c56e:1d44 with SMTP id ffacd0b85a97d-37cc24c9fd3mr2148358f8f.48.1727276508205;
        Wed, 25 Sep 2024 08:01:48 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d3:3500:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37cbc2c1eb8sm4233697f8f.42.2024.09.25.08.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 08:01:47 -0700 (PDT)
Date: Wed, 25 Sep 2024 17:01:42 +0200
From: Corentin LABBE <clabbe@baylibre.com>
To: Janpieter Sollie <janpieter.sollie@kabelmail.de>
Cc: linux.amoon@gmail.com, Jason@zx2c4.com, heiko@sntech.de,
	herbert@gondor.apana.org.au, hl@rock-chips.com,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org, mike.rudenko@gmail.com,
	robin.murphy@arm.com, shawn.lin@rock-chips.com,
	troy.lin@rock-chips.com, ty@wevs.org
Subject: Re: [PATCH] hw_random: rockchip: import driver from vendor tree
Message-ID: <ZvQl1i2TfA6JYUDH@Red>
References: <CANAwSgTTzZOwBaR9zjJ5VMpxm5BydtW6rB2S7jg+dnoX8hAoWg@mail.gmail.com>
 <ef2f6e41-bf9e-470e-a416-fda7ce5d8a51@kabelmail.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef2f6e41-bf9e-470e-a416-fda7ce5d8a51@kabelmail.de>

Le Mon, Sep 23, 2024 at 09:48:54AM +0200, Janpieter Sollie a écrit :
> 
> Hi everybody,
> 
> Is there any chance this random driver will be upstreamed?
> I'm using it instead of the built-in crypto driver (rk3328-crypto), as this crypto driver showed 
> the following:
> 
> > [     9.270549] rk3288-crypto ff060000.crypto: will run requests pump with realtime priority
> > [     9.270687] rk3288-crypto ff060000.crypto: Register ecb(aes) as ecb-aes-rk
> > [     9.270808] rk3288-crypto ff060000.crypto: Register cbc(aes) as cbc-aes-rk
> > [     9.270831] rk3288-crypto ff060000.crypto: Register ecb(des) as ecb-des-rk
> > [     9.270848] rk3288-crypto ff060000.crypto: Register cbc(des) as cbc-des-rk
> > [     9.270864] rk3288-crypto ff060000.crypto: Register ecb(des3_ede) as ecb-des3-ede-rk
> > [     9.270880] rk3288-crypto ff060000.crypto: Register cbc(des3_ede) as cbc-des3-ede-rk
> > [     9.270896] rk3288-crypto ff060000.crypto: Register sha1 as rk-sha1
> > [     9.270915] rk3288-crypto ff060000.crypto: Register sha256 as rk-sha256
> > [     9.270932] rk3288-crypto ff060000.crypto: Register md5 as rk-md5
> 
> so the options here are pretty useless:
> standard tls / ssh (ktls anyone?) almost never uses ecb or cbc ciphers, and about des ... yeah, 
> won't dig into that one.
> I think a rk3328 device will actually benefit more from a entropy source (even if it's not 
> high-quality) than from sha1/256 which are almost always covered by armv8 crypto extensions.
> I tried this patch (and disabled the crypto device in dts), it works.
> Off course there are FIPS failures, but the user employing a rk3328 board probably knows this is 
> not a high-security device.
> 
> Any chances here? applying the patch on 6.6.48 (even with clang thinLTO) works flawlessly.
> 
> kind regards,
> 
> Janpieter Sollie

Did you test if it really works by testing entropy output QUALITY ?

I asked how the serie was tested and the sender never answered raising a big red flag.
If you check the thread, someone tested and the quality bringed by the vendor driver is really BAD.
This is due to the fact that their sample value was really too short.
So as-is, this serie is a security issue to the randomness quality.

I need to regrab some time finishing, my patch adding support for it on intree crypto driver.
I found an old tree that I push here https://github.com/montjoie/linux/tree/rk3288-trng
This is not a final patch, but it could help finding a correct value of sample via the debugfs.
I dont remember which value of sample was necessary to obtain a minimal quality. (perhaps 500 since it seems the default in my patch).

Unfortunatly, I cannot test it immediatly, as my CI controller got some HW issue, and I need to fix them.

Regards

