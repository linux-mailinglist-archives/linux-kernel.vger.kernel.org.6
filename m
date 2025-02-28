Return-Path: <linux-kernel+bounces-538563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99501A49A45
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 394EB169079
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F1326B2B5;
	Fri, 28 Feb 2025 13:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFpiAiDB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3433A1C726D
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740748315; cv=none; b=Plod7cVMg3u7xoGItq6A9ISSi2IVyNOJfBLS5h9rLFArpMOdx7Fzjs39ZKp/ZyIaB1Atq8lu/rMfqe7en2DsnD3Wj1t+TjDgGw51lTzjrefhs8hu5QHTT7w5FR+oYXNt2sfOYbvqpNjTTe4jRZkGlpbYle2fQ7DBCYfnZtNCgbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740748315; c=relaxed/simple;
	bh=ge/ab62pYsGDLvPGgps1hKvOP8NBv8kv6NxDVGP8b2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ve16j/HVtjKJ6BSBz+cveNyBdWM5R3eLC4VWA6HUHgc57eFhhzHWnGx9Sqve7vasxo0vXfGN7mobYU8q5w9TJFZZBz6nyLjxk86psQ7ckD2fnZinNk61zfZCz+xYXC8igazbNybkXVSFYFU0FySvvst7+vG5Gq0ZRwIhKJd7DVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFpiAiDB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6177C4CED6
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740748314;
	bh=ge/ab62pYsGDLvPGgps1hKvOP8NBv8kv6NxDVGP8b2g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gFpiAiDB2Ym4OjoyJpI/Tq77xMHJyziAGBVlEkWG14A5XcgLz87oNcicSk+I81C6r
	 vgGEDYt3YRPOlfG7N2FNnVTH+xxvqMTdJkKpRdz1Gauw5+fBoHudY+JStsEM5CEjoc
	 So7+A7VjhBLpTPdvqu3aRD/u1pi3b+yE8SmR9tpmo99/pSowfQgkLySGk1rmaKgnGG
	 thkb6u4BcBbh3Dud2M5nztBBVgbTIT1foNCQEJ+CWRWnF3sy5ZYB4Ei8v3yyBtFZBu
	 ZYSthpDGDnsfA2uOhvEgV8Pf1XSRGLThPYxR6RXdBaV8fcoCDbN0LxdUY4z7MqV4bj
	 IxTfj+NTyyO8A==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-543e4bbcd86so2267154e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 05:11:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVxsIFnCs8mG1Yxjv6cOrK3ZD4n2589Voaf6NyU48tuGVzRB1na5lpNC5c9A8F3RjW8fXfgxezgdkfIv3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPM2cq3UCrP6pzlCNJeDXOlbevlvtG5hdmwO4O6Vx2RjvepMQN
	2kyhQjp+Cat/SObBqcLROw/kNaAoZUTGuSY9eBe0Lb+wRdySEFFJ51ZfEGN0N5sJcdWojgdsuYq
	TabI3L7+AOECycS2XWMv8xPQwcWI=
X-Google-Smtp-Source: AGHT+IEdP/huYmVd7fCqMgbE+DZUs3JfHQr17sTH27XVC4AIB4+C6ohl8aTsAIH4uv1KQS+Dzr0Lv2Drtl4FyJ41zVY=
X-Received: by 2002:a05:6512:3405:b0:548:526c:fb99 with SMTP id
 2adb3069b0e04-5494c323592mr1338653e87.18.1740748313140; Fri, 28 Feb 2025
 05:11:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224062111.66528-1-kpark3469@gmail.com> <CA+KhAHYujgeC2kAd-vs0N0zwprpeqtD8G-8DpJ0w2RSxzZ5SQw@mail.gmail.com>
 <CAMj1kXH-QmuXGi-5MSEzz7zSpPYWvM2eBPN-NbWF+R=49P2_2g@mail.gmail.com> <CA+KhAHYDui3VkebjxZLnN_ijMUzJf2BRMqtPqqos+rCbf8J7Ww@mail.gmail.com>
In-Reply-To: <CA+KhAHYDui3VkebjxZLnN_ijMUzJf2BRMqtPqqos+rCbf8J7Ww@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 28 Feb 2025 14:11:41 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHyZ5_+ZrcRtdx4X8LA+mzCNcXUZM_3QcEudYGbuGBq0w@mail.gmail.com>
X-Gm-Features: AQ5f1JohuAj06yXvicF9Z_FVzZ_LrO0KkK0BS-faeO6tsEXacAnqjZ-WwcujNKc
Message-ID: <CAMj1kXHyZ5_+ZrcRtdx4X8LA+mzCNcXUZM_3QcEudYGbuGBq0w@mail.gmail.com>
Subject: Re: [PATCH] arm64: kaslr: consider parange is bigger than linear_region_size
To: Keun-O Park <kpark3469@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	catalin.marinas@arm.com, will@kernel.org, Keuno Park <keun-o.park@katim.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Feb 2025 at 06:55, Keun-O Park <kpark3469@gmail.com> wrote:
>
> How about adding a warning message in case of linear region
> randomization failure?
> And, there might be two options in my mind by now to consider hotplug memory.
> Either giving an option for users to override "parange" as kernel
> param or providing the legacy way((memblock_end_of_DRAM() -
> memblock_start_of_DRAM()) when CONFIG_MEMORY_HOTPLUG is off.
> Users believe KASLR will work fine by enabling CONFIG_RANDOMIZE_BASE.
> In case of linear region randomization failure, I think at least users
> need to know about this failure.
> Can you share your thoughts on this please?
>

Randomization of the linear map has always been a best effort thing,
so I don't think this is a big deal.

I wouldn't object to the new behavior being conditional on
CONFIG_MEMORY_HOTPLUG, and fallback to the old behavior otherwise. But
ultimately, it will be up to the maintainers.

