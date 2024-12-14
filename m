Return-Path: <linux-kernel+bounces-446159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D21239F207C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 19:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C334167F54
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 18:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449BD1A8F80;
	Sat, 14 Dec 2024 18:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FKbBQb8C"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5FC1A8F7B
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 18:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734202244; cv=none; b=GErlU+4k/r6mO0b1NZiXm5iTRXpfJ1NOov7rqNbiH3Hy7OUN63y32MCrPhyASJtWAe2eWygHCeOZf1SwjJgOC7SteH1so8/RnfSxPQf4T324czSp2hVFrBb4//yrltlcmok413I+Ve27LWiaMbpzaUw10TMWt1b7fNf+Q0oLnIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734202244; c=relaxed/simple;
	bh=Kvk5Q94p96xfuYmUnNc5YzH/hekcX23iQR5FmYpvj6A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ReksF3FAVxBBNKmnQWZcBL639F6n2DY5rLyE+RXJSC5hMYPRjZH8+lfNF+PBZVeUDWTz3pF/cOGvcbH5FM5mFev8KnATwAhsLlRgd9LPqdvIzNhhwqbbGA63qtAM4AnXuOKvL9q9WObJ0uO9dCe4T2mLsMG40nSoz6UVCSDBa5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=FKbBQb8C; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3f65844deso4497571a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 10:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1734202241; x=1734807041; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kvk5Q94p96xfuYmUnNc5YzH/hekcX23iQR5FmYpvj6A=;
        b=FKbBQb8C36lKBLr6MD+FZfCeXBTtFODG/p78eBZzNnisR3wZG6mUpJoyrQsIqfwb4f
         tL9a1NSVqTUHxsPnwbBzzQ+x/dB3JuTZXZZ8dMm3wozqunGWRdlJuDOBLvRF+CrjD+VF
         0A23SEeW9AYPsoVUyFLmPR8hCQtMS+hEMB+IRrojITpXh+bynBakWEVTWrRgWOiyTlVS
         SF+aUK9owFLqrNGLGXgDq6mapt6KfxYUU2upuHgZmGJ9EnENzb5xb22FE/c6hkAJSVi0
         ir7yBdEILot1NCwJuZDO+5bmXRC2kRpCMM7aFkm8P9fjNPnlVxJyBH219fvmm5LUaDqU
         UVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734202241; x=1734807041;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kvk5Q94p96xfuYmUnNc5YzH/hekcX23iQR5FmYpvj6A=;
        b=Vl44fWd09TMc+Dt9L/Tulsb8ynr9Na19JUjKaRjfblSf7ouL4t6J6N5cW4fQM+gbpg
         UcxefFmzkuEoFuoxYjugwpevYkitVI7LhdOQTVqOhefcvnp594PYjZdvbJFir5KVvIV6
         q0MyoFPz929hUGYljHLGeNUSHxEmoLwEcA18pmUvCXN+BIgLck1T3tyjrtljYCq2pJP0
         dmsBo3HA4VVr8Wu7WtdBFt04sgmVe8WFtSIedO8MHsXFM1qK96qwrH0uumnlOptgT3lU
         GDS7iadNui3Z9Y1DEPL4LRVFQn9n2n8tkjQSZJd2W0x1/mqw2XMI6TabKJBYaG7Q466I
         JHkw==
X-Forwarded-Encrypted: i=1; AJvYcCXGmBGVqkAiOPh3v13UMG8hrNopSfTpg+PUedezf4h62NOkItH11Sx5fOZ5/eA6JbBvAnCqt3leWqyiaxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0cxEQvp8e/JP3T9BWzk/4XIEWGF4qriWU5Xb/7QASyQ2NOVj3
	ePl2DuMS9RwxiedvkB5yqd1m6yHRXhsWMv8XcR+b4E0qwrvr0UftF/8HvcYimng=
X-Gm-Gg: ASbGnctMmk5yOVUluTgNk1sc2XI83FM3V0LxuSLCdgylAiG+CN6cZIidlEkH2nz2K3o
	OEaMXetIUddWoDSIWT2vdTzwOU8TU8MTUlnLrihLo9D8uBeC6wVLGq3hQF2F1py8+IgSCA8uJHJ
	K4yCZ0KMROPWBFBE96Xwr4XJsh4LMiyGPAiuIi7/csNWhjYC0KbUzAdfmq9sbA1LErHTUHbAkBV
	vSgnnAqn3COiwJgLJGKtTfoxI/yWjZzsS4wdpoLgtJmw62sCQ==
X-Google-Smtp-Source: AGHT+IEqGYPOXspfucxmv+0uIecQPi1XQ6r1BCa9px+J654dma9VJEFkGqxNM9RGcED79AZwSJ1W2A==
X-Received: by 2002:a17:906:c115:b0:aa6:7df0:b179 with SMTP id a640c23a62f3a-aab7790a053mr546722166b.22.1734202241218;
        Sat, 14 Dec 2024 10:50:41 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:506b:2387::38a:31])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96068933sm123010566b.79.2024.12.14.10.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 10:50:40 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <mrpre@163.com>
Cc: bpf@vger.kernel.org,  martin.lau@linux.dev,  ast@kernel.org,
  edumazet@google.com,  davem@davemloft.net,  dsahern@kernel.org,
  kuba@kernel.org,  pabeni@redhat.com,  linux-kernel@vger.kernel.org,
  song@kernel.org,  john.fastabend@gmail.com,  andrii@kernel.org,
  mhal@rbox.co,  yonghong.song@linux.dev,  daniel@iogearbox.net,
  xiyou.wangcong@gmail.com,  horms@kernel.org
Subject: Re: [PATCH bpf v2 0/2] bpf: fix wrong copied_seq calculation and
 add tests
In-Reply-To: <20241209152740.281125-1-mrpre@163.com> (Jiayuan Chen's message
	of "Mon, 9 Dec 2024 23:27:38 +0800")
References: <20241209152740.281125-1-mrpre@163.com>
Date: Sat, 14 Dec 2024 19:50:37 +0100
Message-ID: <87ttb6w136.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Dec 09, 2024 at 11:27 PM +08, Jiayuan Chen wrote:

[...]

> We added test cases for bpf + strparser and separated them from
> sockmap_basic. This is because we need to add more test cases for
> strparser in the future.
>
> Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
>
> ---

I have a question unrelated to the fix itself -

Are you an active strparser+verdict sockmap user?

I was wondering if we can deprecate strparser if/when KCM time comes
[1].

[1] https://lore.kernel.org/netdev/CANn89iK60jxsJCzq29WPSZJnYNHHpPS09_ZmSi1JHmbkZ2GznA@mail.gmail.com/

