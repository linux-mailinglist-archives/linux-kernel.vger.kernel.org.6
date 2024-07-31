Return-Path: <linux-kernel+bounces-269774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 553D99436C0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C02B28227B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBCC13BC1E;
	Wed, 31 Jul 2024 19:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f4M3CFfC"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1255B44C8C
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 19:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722455495; cv=none; b=lQKTiQptjUwqgMOsYBETV+cOp4MqPSKqMql7Nv5NXFd2MIHKCKhUExfTDxtZNcrgVEncN1GpBO3ZcGE5RBykmawO7oiU38HaJfqQpBFJ9rOykh1XJMPwwmuSp2rlpGy3gIrHIYZszWzLFiB3WgCbeLfJzEFOLQFl1vOPD7CbiAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722455495; c=relaxed/simple;
	bh=VMZGRIt9Bu914/UR0/IET/FSQPvWBZGwluvLZFH+orM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZiqhRBlQL0slHziVQiMKkXYeTgabSdggEDLKVkSCgJh9/ybt4DvUVJkxrxPsygbOeCySvj2n9bKj01bc005V3k1UyaUaeXhFaxxKIbl4K91rNRVaWjQOu8mxdmFi8pqGiJ45r3jfsDyd8BrpTEX+e+mnzgi7JeogHvBPzH8P21o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f4M3CFfC; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52efc89dbedso7901554e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 12:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722455492; x=1723060292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMZGRIt9Bu914/UR0/IET/FSQPvWBZGwluvLZFH+orM=;
        b=f4M3CFfCqExnc5fFAHSyALV7zureYWB5qfPFjRQKv7kcTCkgMgV1XwgFWwdh0ZxVoK
         KIEZS2NeKA+/fy/TNEr2iSvbScHho6zUx42H0/vUTKXM7jmFvtIh3AfZD+RjrBaadIFQ
         4Mm2NGjS2rl3Hkda+P0Z7xM/CuOMKe07ICEwA/4bWZkvHtROHKr2f51WNj9b3fqaGzKZ
         xnXBs+fwSDHjE2XcDYCTZ9HKkJkW6Qci/OESrCb7U1FngZj1VxyNuAJcqw9aXjlY65OI
         x6lCquuyN5hBX489ZGQF6qlO4QecDOklnGqBNvQxLdzETFYWrEdzgqUwxWs4sPKZzUfC
         ct4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722455492; x=1723060292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMZGRIt9Bu914/UR0/IET/FSQPvWBZGwluvLZFH+orM=;
        b=C8vZq08Y/ihfvA/kPHt3mfimoNnCyaM+z1bNOy9DBT3/dDLSwqtAlf2qNudI1TWxdB
         eT+w3Fu8xJyG4fmk7fm9ZrZ3oS07D8PkVZrg7CFKCD87QW8kur63MlthBsKTiUN2Cxcb
         rkpgwRd/gtLEi0jmZXrtvb0jqr4Es7gA/fwnpwaZA3CknnHFvXikNB8lUl5Ai7tfCxr6
         QHOjfMxPW9aQk4Ct4xxKDF06sfbAfV+hjVrBhkHwy4C4KBTFtr0edp5jYI23I470wP50
         ++K+O385Bzdj/Ff8Pv5kzw7HWUH3v3IsuGO8I3pT/FS/rOwRoQoeXPngtYdjYV1YlB6p
         rF6g==
X-Forwarded-Encrypted: i=1; AJvYcCUCkzBW9+//doHXuA6OzZvsRcjI6ObU8fPqdJo/NqT1cwgRBTkyB1MP7AsTj+xm0CSe3kHcoMKKnpW0xbOPmnJualnQBEMSkO2ztna8
X-Gm-Message-State: AOJu0Yx6xr/h/p4d0aJyq0prpdwHO2PWbaZgmSr4x4Vgi1ykyrycRpka
	fukTBf78mtKBcc4ERk7CXkSjQpK2n0IQoaWrsFBctAA/0UuMkpdm3gmvsIY2riLG+4ZQjpTtZ/8
	cFaAAzonj0jOWSzXtR3zPTu+pcVMUbytFIQyT/w==
X-Google-Smtp-Source: AGHT+IFo7dWMrZVk0qmzwRRLNQJvLLW7Oz1e417fjF9Kw312OQHEVuGlf44xqebNrqhX6w6HMPuGfO2OVeaJq0nSOW0=
X-Received: by 2002:a05:6512:1c9:b0:52c:d905:9645 with SMTP id
 2adb3069b0e04-530b61b1939mr53045e87.13.1722455491760; Wed, 31 Jul 2024
 12:51:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730152744.2813600-1-arnd@kernel.org>
In-Reply-To: <20240730152744.2813600-1-arnd@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jul 2024 21:51:19 +0200
Message-ID: <CACRpkdYaK6_2AY0D07wTc+BFKazaTxhB6qmuJeKir89FM1HL=w@mail.gmail.com>
Subject: Re: [PATCH] alpha: fix ioread64be()/iowrite64be() helpers
To: Arnd Bergmann <arnd@kernel.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Baoquan He <bhe@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Breno Leitao <leitao@debian.org>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 5:27=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> Compile-testing the crypto/caam driver on alpha showed a pre-existing
> problem on alpha with iowrite64be() missing:
>
> ERROR: modpost: "iowrite64be" [drivers/crypto/caam/caam_jr.ko] undefined!
>
> The prototypes were added a while ago when we started using asm-generic/i=
o.h,
> but the implementation was still missing. At some point the ioread64/iowr=
ite64
> helpers were added, but the big-endian versions are still missing, and
> the generic version (using readq/writeq) is would not work here.
>
> Change it to wrap ioread64()/iowrite64() instead.
>
> Fixes: beba3771d9e0 ("crypto: caam: Make CRYPTO_DEV_FSL_CAAM dependent of=
 COMPILE_TEST")
> Fixes: e19d4ebc536d ("alpha: add full ioread64/iowrite64 implementation")
> Fixes: 7e772dad9913 ("alpha: Use generic <asm-generic/io.h>")
> Closes: https://lore.kernel.org/all/CAHk-=3DwgEyzSxTs467NDOVfBSzWvUS6ztcw=
hiy=3DM3xog=3D=3DKBmTw@mail.gmail.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

So *that* was the problem, I was scratching my head over this one.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

