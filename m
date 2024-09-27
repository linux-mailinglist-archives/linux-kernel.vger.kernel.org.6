Return-Path: <linux-kernel+bounces-342182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41ECF988B45
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 22:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3F3E1C22975
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 20:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317031C32F8;
	Fri, 27 Sep 2024 20:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QkiPvvsy"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9121C32EC
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 20:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727468996; cv=none; b=adjMjyEnk4C8uVfs81/EtJmnyyyg+yuNtt6hwMECvKsHuJmTPtTl5+cnU34QvvH7n46rX3fcTd5r2PiRFosIqVfm2TEDGdWZaEP9K/ktwGnKH79bXS1YghMQn4aE/oS2JjRU23aB1ox7d3Ponu/RG4oCuHyqJnbQ1XqPfdnURdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727468996; c=relaxed/simple;
	bh=O7C/oC6hL00js+Az1FfnrKsL3QI59qQE2P4XQFlXZWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RY1svWTY0Wow2DJ/aP9VZuYfs5Jrhm3Z5Ri7LPP0moNAZ24Pu8O7HejtDUYdACor4jlTKgkSEa8GX7JF4ztnrD5ime9f+DLGkiFpHbdL9HV2w3AHSh8UeSflPsfDRCOTFHhHqbph4CIgx4FHp6GYizI1NPIaT4FwUfCmpqNcovw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QkiPvvsy; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c874f6f119so2883163a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 13:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727468992; x=1728073792; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hZzWT+lUqwXDEeq/wUnCQKHMEfvy03o0d5mB9wZhCYg=;
        b=QkiPvvsyYkz0Oe6qTKfs+GQ9gICE+uPyEvNL36b3fOXDR5AVBgzVgzyMavUHnoa9jB
         AeDOr6FpPX+i95E4K1FK2eWoX8cKCQUEZidzRPqGVAKagnXhwr4vooSSUFJuzoMeSBIS
         amDzLoGnJcwc3KRYr5zOPuSL30iHO4cYt1p40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727468992; x=1728073792;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hZzWT+lUqwXDEeq/wUnCQKHMEfvy03o0d5mB9wZhCYg=;
        b=J3HkmM5cbujA1T2kmuzC9KS6yJ3zh3x2tptRMbGM0PB6oBGtLVZPNNXJgw5tty8SLI
         yzwi8NYvCK35j6XQ56gMtFEWhGzSMn1fLuVB5kjfjmlEbPeZFvJy1A9RdqT4bNXp8Dpp
         eFzuZOWFsL59bLgXRJsHizkKhmM76IM5XxIte7qEnOFsk4FtxF1O57yTH3fUkZXEilX/
         1Q1WNQtou9F8PbSyJdllnSIhRQWzXXYiWyjfHrR8tV+GJfiO/ayMZSKk9x+dA3O9e04X
         puxyDSdvV8xj+/XdxyPCg9TKxE278S7aW3z7/ia7r0+taraOO9gVLyJgPdUaJ6TKo1Bw
         y8XA==
X-Gm-Message-State: AOJu0YyimBCyIlAvEZAufAtltUybVF28oAIY53VJmpnpsYkLVUcp/ZIj
	buY8S718234VxSV6/IA2R6Dw0xtaTwBmSNJA1Z9G+N5f4O7zLag6ypHhWus7Huaxd+cPTKh9x6g
	BD9/2FA==
X-Google-Smtp-Source: AGHT+IHjoOrs23u8Kh7yoRFxV++FssLMqOfvb/cROm2IOz/UqPHwA5NujkjG0rqy94bhDuyjxznivQ==
X-Received: by 2002:a17:907:26ce:b0:a8d:6921:e17d with SMTP id a640c23a62f3a-a93c492d4ecmr432559666b.33.1727468991822;
        Fri, 27 Sep 2024 13:29:51 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2947fd4sm171494866b.138.2024.09.27.13.29.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 13:29:51 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a93c1cc74fdso256406766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 13:29:51 -0700 (PDT)
X-Received: by 2002:a17:907:7290:b0:a8b:6ee7:ba17 with SMTP id
 a640c23a62f3a-a93c4aae07cmr373039066b.55.1727468990910; Fri, 27 Sep 2024
 13:29:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZvbeGKQMC1vFq8ei@yury-ThinkPad> <CAHk-=wjS9O67Ue9fZWG4ptc-MyZchqJmQFsMJkOchqpnxc-Dvw@mail.gmail.com>
 <ZvcQyAw27hdRZw2B@yury-ThinkPad>
In-Reply-To: <ZvcQyAw27hdRZw2B@yury-ThinkPad>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 27 Sep 2024 13:29:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=whTUzTm9NjxBYvp0Bv3cT4YuFKAmOVQAX44f8JaaxoT5g@mail.gmail.com>
Message-ID: <CAHk-=whTUzTm9NjxBYvp0Bv3cT4YuFKAmOVQAX44f8JaaxoT5g@mail.gmail.com>
Subject: Re: [GIT PULL] bitmap changes for v6.12-rc1
To: Yury Norov <yury.norov@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Sept 2024 at 13:08, Yury Norov <yury.norov@gmail.com> wrote:
>
> I'll drop GENMASK_U128() part from the request and send v2 later today.

I took your pull request, because I _suspect_ the test for
CC_HAS_INT128 is historical.

I *think* all the gcc (and clang) versions we support has __int128
support on arm64.  It's not a new feature.

That said, I'm not *sure* about it. The fact that we have a test for
it in the arm64 Kconfig file may be because we actually have compilers
that don't support __int128. Or it might be due to entirely historical
reasons.

So my point was just that people who make use of this should really be
aware of this worry, and double-check.

GENMASK_U128() is not necessarily wrong. It's just that it's not
necessarily available everywhere (it most definitely isn't on most
32-bit targets, for example, but arm64 _may_ be always ok).

               Linus

