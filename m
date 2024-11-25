Return-Path: <linux-kernel+bounces-421594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 277129D8D5B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 21:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E10B828AFF6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 20:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6471BCA19;
	Mon, 25 Nov 2024 20:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gEsM4TYH"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9042F1991C1
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 20:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732566095; cv=none; b=pXEfQPMphVs0K0vFvRF0q5I24SEUlB4qTx/GxKtLw5CMg8GVdK1p3ed92OgIqfmKIhmacoJEHhGJw4G2hiqMQCgMTlGB7hT/3e5ht0BSIXHcBrhYORq9PRvdhSr6O1dW/utj76t0g5QF/q1nZlYKB6ebEQd+mCj2ON8uvOmA1rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732566095; c=relaxed/simple;
	bh=Kl3P2hKyx9C841ZaTy+FOUMj3y0BNQwlVyEbFQmyNi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jqymJrjossuXo18p666UPo4NQOzQNTqjumR9lPmaXYWsYNDpz8D6eY74HPA5705PvvCLqntNBvSjcabufmaGfOo6nSLNVZMOxD9joEgD96iYhNgouhs8XjUnZjUQ0hAGjunKZNyeFJPIVH+CQPchdiQMvpWoa5SR9xpVzT56HOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gEsM4TYH; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5cefa22e9d5so5856423a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 12:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732566092; x=1733170892; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3/PK3uu0jCDAIrTpVfHMSW+vsH43GKddhOFXh25jwuI=;
        b=gEsM4TYHGuEbILlLvM3HS4Mm3z68l11jWozB2NWHva+LvrDJVrayaH3cckL5C1UW3x
         I1rBCxXMClGDS2+GUsGbHh2UDcNjfSP8MrXvFOy22EG1bUsdDuBEPQKvll4yKxjII1qr
         AAg6AoHoGoJQYWTeASvtBdzWIK6LpAFaiHkWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732566092; x=1733170892;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3/PK3uu0jCDAIrTpVfHMSW+vsH43GKddhOFXh25jwuI=;
        b=mQ7XlNvagwpw/LpUd9hiRPcHZV+ypoPy5Of0AFXvWg13k1jPZjlFd++q6vvlBnAQip
         O7IHbBIqkkEBLvBokesqr9/mKgJw4XZ5tOQjke45vJpEteik1QH+Aa1E9E5LbKQiLD+o
         X6hJd8pc2v1Mr+81hN6uS3rcIOmgQoQcNBkqJqk4xeunFecCguSAQWl9sO2BJ90pClSC
         4XYAXFNTNVessnLL6fxMXntof/NhftjgORef+o/Imz4CMw5Zzy3OVZZB4CeoFzurzivH
         Qi8R5FYiIE3wifUAAxzUKmoim+sfJQEFTCq5iN3L4fDylMsJDcYjhlEqwjjmqQCoQD+q
         D3/g==
X-Forwarded-Encrypted: i=1; AJvYcCUZ3eYeyFZxO8qeJ9hwA8avlH2JLN6YvDjzxTHwDe7dpBM+s4UHN2VvGVpE++sp2tiIDbil3Zuj7A/sckw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTHD6ZiszR6B9fZOnKJMZVs4PL5BDQor4hpgSyQw+4nCRztnYs
	PRbFOm9lj6tFm+OW8liolVhm+P7JejU25aNp+TV9sPEmfedSioWLTSrS1A0g0RGrLTtFOegOW/Q
	2Ku9hKA==
X-Gm-Gg: ASbGncsPIKkvKUuRcwY6pjMZQ3i0BWlzn66U+m6ywoXBe2X4hqJjZhbo+wOYnG6GfME
	AiyPXDxynmAR7IKLpZak5gOtUIaXP3QgGojSDwmfUXJi1V3pRSvXX3yuxY7+lB2qDOPAGMyRj9w
	gKZmWgw2QozNwIR4DN8sbYDo08VUJngJCooKKhpCY+M0zTVKi36MJKrMkvL1HXIIrraf4PpHKBB
	kVVp7J7jrP0oVINptw0tynGAVYQG3xL8rraFYe+s3fL77O9Kmeri6L2GriGyjiPL/+oxHFgWHtk
	mdOsi9l/h/d5DWtfilUBUiiA
X-Google-Smtp-Source: AGHT+IHegNiGDiAsbUUFMQ5xD4dacqx8C6nAwx5nBoA3+5BQIDOyzRSQiesgowceplRpzaKlIdbFhw==
X-Received: by 2002:a05:6402:274e:b0:5cf:f453:4b97 with SMTP id 4fb4d7f45d1cf-5d020792da0mr11730851a12.24.1732566091691;
        Mon, 25 Nov 2024 12:21:31 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3b06b1sm4388161a12.22.2024.11.25.12.21.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 12:21:30 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso694309966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 12:21:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVac20LZtby7f9TjYQFq5Aik7u8D3Y/kH4hrhqOpzf8htFWeKwsE56nRCPgzQpH1Qdqfa5AL8DR2htK3uo=@vger.kernel.org
X-Received: by 2002:a17:906:bfea:b0:aa5:48ae:d850 with SMTP id
 a640c23a62f3a-aa548aee1c5mr563203966b.29.1732566088651; Mon, 25 Nov 2024
 12:21:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0edca3e5d2194cdf9812a8ccb42216e9@AcuMS.aculab.com>
 <CAHk-=wik4GHHXNXgzK-4S=yK=7BsNnrvEnSX3Funu6BFr=Pryw@mail.gmail.com>
 <b90410d3f213496ebfdd2f561281791b@AcuMS.aculab.com> <CAHk-=wgq1eEoUFK5mSUM6d53USDRaWY4G+ctTNEw9w_PsUqf1w@mail.gmail.com>
 <CAHk-=wh0oKkRHHqnft8mHaz5nuZNEspGQ5HW4oPJmGGwmccF1w@mail.gmail.com> <4e2ed7a9cbf54eeabe9be7764141f0d2@AcuMS.aculab.com>
In-Reply-To: <4e2ed7a9cbf54eeabe9be7764141f0d2@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 25 Nov 2024 12:21:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=whyVT--srUztQj-Q2XC4bhhr97rnSb600QTVkWPCMvtXg@mail.gmail.com>
Message-ID: <CAHk-=whyVT--srUztQj-Q2XC4bhhr97rnSb600QTVkWPCMvtXg@mail.gmail.com>
Subject: Re: [PATCH v2] x86: Allow user accesses to the base of the guard page
To: David Laight <David.Laight@aculab.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, "bp@alien8.de" <bp@alien8.de>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@kernel.org>, 
	Mikel Rychliski <mikel@mikelr.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Nov 2024 at 08:49, David Laight <David.Laight@aculab.com> wrote:
>
> > David, does that patch above work for you?
>
> You are the boss :-)

Bah. I decided that I'll just apply your patch anyway, simply because
the one-off the other way won't matter, and this way you get proper
credit and it's all minimal and simple to back-port.

Maybe I'll waffle some more in the future and decide to do things some
other way, but at least for now that simple patch is what is in my
tree.

Thanks,
               Linus

