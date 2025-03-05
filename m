Return-Path: <linux-kernel+bounces-547476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C6FA509EE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93F4E3A3A27
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346E62528E2;
	Wed,  5 Mar 2025 18:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dqbAWYei"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EF91C863D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 18:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741199193; cv=none; b=QFnn5YH8e3Kn6A/UFkVsch7g5+uZK0LCGBbWfrJDJyWSqLXxJu4lctYbVVKLVuBnkPM6eYorvzHHYknYgeMHbsnY1FsEZJI3j6477UYdWeFp4kdE/qugBFDUbqBtyMUwnfXkHX+3nqeIodKf67dXg2yH1iR+cFUZMUpjm9MJNT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741199193; c=relaxed/simple;
	bh=VGwMgyKpCt9HHv8lSloTP5AZN+IECQ/wTTW3r2R9a4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bjJ2M6sSN1hZ79vwu/aDoZMpdUlgtvbe7SIzUVDuLw7RhTPUQsZ0/yzzVKaXiCOcc39VfCK3sL4cHC+aDFtGGcmtozIGHtx2gcjJqH/ZlqPDWYgqxrqm21a1y4JtyHyUq+Oeje/6H3+dIHC8mFMas05j4M5iopOo5qHj89EJ9Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dqbAWYei; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaeec07b705so1084065266b.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 10:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741199189; x=1741803989; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o+lWuYggNESirpcNjr2CXdSJcsNp4dxN7SSz7x3TDdE=;
        b=dqbAWYei32ON4aDBTAZ9XqrtMSlr2Am11oh/Wx0ptOUag71hAuKg//c6FEGTp98yC8
         4vWOMR+0JwYN8YLvlAmvGkfv9+ynlY1DGrHXAstOpHxn/Gk0dfHFOUzr4v9DIuJBH2q9
         PbRbW71H4wXz+aX8WL7gFdX3zvMjuFVtxqrLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741199189; x=1741803989;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o+lWuYggNESirpcNjr2CXdSJcsNp4dxN7SSz7x3TDdE=;
        b=JbcywtKPIWn3VJgR4MVhDpmAKr6r4jEyuRK5zEAAfknmiTnOBG6JR6++3XyAwyyzyb
         HdFOvp+tk8oE+yOUzYaL7idp7Hrwmyhk3C1M1TIdQm0rtr8IENlV7nYcNNCPCQWo5+In
         kYVr24Z1O+sxQvVMKheOfTXcrLXswEIV1D4J+7Mj9Abw+mg58lY5DEmadWfWX9xlGRDk
         MPLEfWjx3MKJvcZoJ6k8q1+dz4TuIaiDa+0z86hHmUwhjhtdSdZKokzyhYryN89ACp75
         NV6Bfxpu5CNM32ESEurQVsLnBBXx+BwR34rQom+5glM2uQBtlXkA2jnND4JtAOmvAee9
         M/tQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/zYs1S5xiNBObsHxvp2dqUk/2UzcNd4x1uJYFYuzWM0yNIgHTbgOu5RyyaiwHOtLWzlYymgpCrd4v7Kc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvK8a+XWwc9A6Nf+b1Y/TwyD3eZAL5i0I4eSl37FUmpq0JGmmk
	cnV/PYhBtCmowQJ5w6atwl9cNRXsWE9tzShzrYD5G+Y0kSwCG44bo/gABYs/13+Wipv05IgGFso
	U95yM5w==
X-Gm-Gg: ASbGncs+lRQzC/U5GG5HiDFsK3csnQKbR8E5xbnfmrp2ssrV39W/S9u1VT1fJssovD3
	q7B/Cdha2i5N1171omvMWihOQFog881dI/yGm7CkmPhfWiYwSnd3JOgSXHh7lm4/JsH3d3LAIxN
	il9MWvx/yAmYrltkHlzmm0G9KGv+fdts4cUQJrDKP4M+Xl/3cmngeLW8PNy4jMR7jCzXFsCMVTt
	FJwIyhRnhO8hBP3I0oVWrnlqMpEP6szIpR7pZPAC86+s4YdJfigKMaBmXz6P631aclACNGF5Mnm
	jwEYAN6iMPgH5AKf0DObGbj5tyXhyCQIz+pd8XrBSKWz3pCfVwoA9Tl6KnPNrS9K5bjWK1GDCUh
	1ocJdN5J5M/vUEFy6s4s=
X-Google-Smtp-Source: AGHT+IGwaJvjR3agqkz8r2uA78CVFbILzH3oACIzUU8lOk3v79XiGRFeMK1aevP8Hjeo2/GhiLUkAw==
X-Received: by 2002:a17:907:7e8a:b0:abf:67d7:7816 with SMTP id a640c23a62f3a-ac20d844744mr425504466b.3.1741199189116;
        Wed, 05 Mar 2025 10:26:29 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1fc1070b5sm277927466b.43.2025.03.05.10.26.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 10:26:28 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e4b410e48bso10707367a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 10:26:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW/ApuCffTXHeyWBT7em1/Ki3o81iXCji4+Wvr68rG9L5o9p8lZrgR0HBTv3davHGoBRW997mObAJJufGA=@vger.kernel.org
X-Received: by 2002:a17:907:3da2:b0:ac1:e1da:8744 with SMTP id
 a640c23a62f3a-ac20da862abmr386757466b.38.1741199187743; Wed, 05 Mar 2025
 10:26:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305204609.5e64768e@canb.auug.org.au> <20250305112301.2897-1-kprateek.nayak@amd.com>
 <CAHk-=whuh+f8C4u+gCkxRZyrt7Gw_FFw_pKn-2SnTovZOvEKmg@mail.gmail.com> <e6cb4e60-9525-4d42-8912-7ce3f7fa4abb@amd.com>
In-Reply-To: <e6cb4e60-9525-4d42-8912-7ce3f7fa4abb@amd.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 5 Mar 2025 08:26:10 -1000
X-Gmail-Original-Message-ID: <CAHk-=wivSEhRG3zJHd0WYz6rO9Gwzek6CMRMSmcHd2c6-01KuQ@mail.gmail.com>
X-Gm-Features: AQ5f1JqpKUUFPnHc3jSY-R0TPnXsPYIBThz6_u7E-ytiat3EmHPTia73VBP0gTI
Message-ID: <CAHk-=wivSEhRG3zJHd0WYz6rO9Gwzek6CMRMSmcHd2c6-01KuQ@mail.gmail.com>
Subject: Re: [PATCH] include/linux/pipe_fs_i: Add htmldoc annotation for
 "head_tail" member
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Swapnil Sapkal <swapnil.sapkal@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Mar 2025 at 08:08, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>
> > And it turns out my worry about pipe_discard_from() was unnecessary.
> > Yes, the code is buggy. But no, it doesn't matter. Why? There are no
> > callers of that function ;)
>
]> I don't see any in kernel user of this helper currently so can the
> wrap-around issue be addressed and the helper be removed later?

Yes. That's what I did. I still would love to see

 - more testing

 - explicit limit checking in pipe_resize_ring()

and then I think we could make CONFIG_64BIT use the 16-bit
pipe_index_t too (because not doing so clearly was a mistake: it meant
that people didn't test the 32-bit case, so the wrap-around bugs
weren't as obvious).

                 Linus

                    Linus

