Return-Path: <linux-kernel+bounces-442334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 876919EDB0F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 00:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 442271889DF0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE69F1F239D;
	Wed, 11 Dec 2024 23:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evwN6Vh4"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3D21C1F22;
	Wed, 11 Dec 2024 23:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733959017; cv=none; b=dG5L22K6n7lODEYP88e8ucNeBysgySYnHA8XjprP2E3zBrwxIkcrkMj0Q/LrCpQK9X4yEurJfZQ1btVKR1KB3izLctsd825MLoCQCZ3CC/qCM9kIdIb19VDSM2N3ecSJuMBde2vkJECbYIQbk4sntzTS4VAVY1cHI8RKuFzgUeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733959017; c=relaxed/simple;
	bh=i6ZrtWtzAyOy8gdWcoPcDlt/eQnm2NOjmoi9dL7VXZg=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TryxdLnwcf6HdwpISRx5IFlI0p3VxszMaYzGzkuPvvD/OkIzE9X6HlM8LP8MMyCWBz+ddz0ShLfFjS0QLV22neCREotFrXgNktUcK+2RGg2r3XoBCev3HVcwgfbUKMvNsPMsWut+R/iyD/chIHO+1pC/w+ixdmzpIS8Pk6tyIXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evwN6Vh4; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-725ee6f56b4so6823b3a.3;
        Wed, 11 Dec 2024 15:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733959015; x=1734563815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ShXp0MbnAr4ggsRDnYhR5uR6lsM/ajKdCXbVIq5oTug=;
        b=evwN6Vh469dg39IHRL9DPDwqhccKWfnjIlcb2ISW4iq1WVX72nCZVYEPviq+Zim1AP
         vcQyU047XnfAcUZ/DOgeQeVnAtbj/dmn803f2aMcpqlA4Qu6e3KJp7RQRxep8LHzw0GA
         F1yblHUqU6iPv1tPORf+rk+wL92EVKOcuz7zwpMkAfIojQX4w1syVpitIjfxjDXzka2b
         Zagm3oZOBtTVfatmeKV1YHPc2PRwltsmT5ed/8u7bt/dO9wCFzuBcOtsqjeFu1g2geSr
         zfKlrC+9W9tjUdy3LAF2Eind1ni5rqGhTT0CVlg6ruMfwjuhQFHI/hhNazDZfwIXtuRR
         kIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733959015; x=1734563815;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ShXp0MbnAr4ggsRDnYhR5uR6lsM/ajKdCXbVIq5oTug=;
        b=KnQKfXY7GeoabsebjDy1R35976KBrGnASflhqDf2OwGCchvkCtzYEelhSiLz3XvdS2
         FI1spw0KAglqVbTvGG1XDu0dTsz9I3ndZBLiBXgElif0mvt0TjtONP2X13Dq8FsmJUS5
         WAeVhH3FA3R9h9Bh+UjPR52ldjsu3/uJrbSEcAlYG7qPDpkqC+Psq+3erlXeI+iH+H8H
         aeCJOCVBCNGY1YNyO5YYJQCLf9nJI7sujXTWYna5byQDnM6KWAIU9cEu2BBGCgO8XtNj
         1x53h0qh1wamv0M0zxgShSDq60V3alsyvMzU6RiLDFO7ozFXvtwFakroVHJEDgE3rCw3
         Kl0A==
X-Forwarded-Encrypted: i=1; AJvYcCU+nO3/hRJCWYvd2xrIOKekG8JpgPrrvAFUTnvBmM446hv0a2Jv8yyxJbU+6icgd8hsCbSehS77mdTNycU=@vger.kernel.org, AJvYcCXLtjE/KwOK8o+OIljvapR/Q2bfmUcWBG0EAvvSoID/lVkYd07ARKOXvG855Vy5dhD0JO4JXEg+JRtG5xKUKY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwshQ8E9WEHjRSoXBfOyvhtqwGE4Sddnw28tJFV8ld5pAZ3488Z
	rXCMq4q+yHmE5fqa5gqEq3271zKdp0NWO/kE8NZcHewzj5HezxsR
X-Gm-Gg: ASbGncsQ2Kr39zgteRJk0v3yYGg6ox7fnRaUmxpkjee7ANS+GuWjtMe2Od/oWz0uB1h
	M0cL6wJI6cVZsCesdBr6O+kGaeHkPoKCt6hrOTVCIu5ntZtVr+p4Rt8zLoyfSPKU9BwdZUX4Wkq
	PbcdBbAOQivkEnGrZ6dglonYcrEYl6GbTe6H2dMbOehFLWJojPoh/Xl3nXKgQ0hfRWaRFn/j++n
	b8VCLOzQfs6UQnj2B91p4Fpee9oGXbSqfata2TOjwzOfkctEuYdJZkYzcRuwjzzba45K6DCpFDI
	ZW5OcrtJN+UWCNfmzzrGVwuuxzt0unOAzALM
X-Google-Smtp-Source: AGHT+IHiOZwkIkfA6zUyxiG0lm10+eI/mHdViFN+Pz4GPmJYmGkPLqez5E4FZA5uA6Zaeh8N3oG8TQ==
X-Received: by 2002:a05:6a00:92a6:b0:725:f18a:da42 with SMTP id d2e1a72fcca58-728fa9bf4abmr1705891b3a.2.1733959015026;
        Wed, 11 Dec 2024 15:16:55 -0800 (PST)
Received: from localhost (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725cf238777sm8304590b3a.47.2024.12.11.15.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 15:16:54 -0800 (PST)
Date: Thu, 12 Dec 2024 08:16:39 +0900 (JST)
Message-Id: <20241212.081639.1353664129364117890.fujita.tomonori@gmail.com>
To: chenhuacai@kernel.org
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, x86@kernel.org,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, peterz@infradead.org,
 hpa@zytor.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, catalin.marinas@arm.com, will@kernel.org,
 kernel@xen0n.name, tangyouling@loongson.cn, hejinyang@loongson.cn,
 yangtiezhu@loongson.cn, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu
Subject: Re: [PATCH v1 4/5] loongarch/bug: Add ARCH_WARN_ASM macro for
 BUG/WARN asm code sharing with Rust
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CAAhV-H7BxE7xeA982Pr4PFxgfNpgXs6H4OZ2LydmYAtYjvYNaw@mail.gmail.com>
References: <20241210001802.228725-1-fujita.tomonori@gmail.com>
	<20241210001802.228725-5-fujita.tomonori@gmail.com>
	<CAAhV-H7BxE7xeA982Pr4PFxgfNpgXs6H4OZ2LydmYAtYjvYNaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 11 Dec 2024 16:41:42 +0800
Huacai Chen <chenhuacai@kernel.org> wrote:

>> +#ifdef CONFIG_DEBUG_BUGVERBOSE
>> +#define __BUG_LOCATION_STRING(file, line)              \
>> +               ".long " file "- .;"                    \
>> +               ".short " line ";"
>> +#else
>> +#define __BUG_LOCATION_STRING(_file, _line)
>> +#endif
> Can we use file and line instead of _file and _line, which is the same
> as the CONFIG_DEBUG_BUGVERBOSE case?

Of course, I'll fix in v2. I should have done that.

>> +
>> +#define __BUG_ENTRY_STRING(file, line, flags)          \
>> +               __stringify(__BUG_ENTRY_START)          \
>> +               __BUG_LOCATION_STRING(file, line)       \
>> +               ".short " flags ";"                     \
>> +               __stringify(__BUG_ENTRY_END)
>> +
>> +#define ARCH_WARN_ASM(file, line, flags, size)         \
>> +       __BUG_ENTRY_STRING(file, line, flags)           \
>> +       __stringify(break BRK_BUG) ";"
>> +
> Can we use the same indentation in this file?

Oops, I'll fix in v2.

Thanks!

