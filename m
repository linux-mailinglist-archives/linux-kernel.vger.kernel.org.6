Return-Path: <linux-kernel+bounces-422862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFE19D9F17
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 23:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE613B22B4F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 22:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3EB1DF736;
	Tue, 26 Nov 2024 22:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iG6Wm9pm"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92558831
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 22:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732658879; cv=none; b=o/px2XrFQHo16MEaY//L4QfLpNM3BuFkh2/0MazjxARXY4T9wY1tGYNhvbyhMyE2WayE8suTwah3NXVztpmEUq6uSfni98jp/QaAc65qQxkCR/y8jpB7J4Dqk5AX7L+SrgrMXUuA28UIVKHwiiJcGwuFXikJrWCYS+spr3AKu3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732658879; c=relaxed/simple;
	bh=IEVN4T2SR215oF5cys4HUFv38ni0R/Gk0dy1IEM6Qvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u1zn2uu0gYlhR1ZgN7VtRnIB2tMORpRKZ7zPuxotMlfx4GEveOogXHdYB7xKMmrru5Nu6ODbi0N9qoOtwhRIKGxED3hqWvSpKjSH6wh83Ekltr0Yx8/B0mN2RCNrjMiqZhvEFSWHzO2iQJCZWjUP2I/bX4ABsioSU5MJAb4KlmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=iG6Wm9pm; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb59652cb9so66155801fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 14:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732658875; x=1733263675; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=51WI1mXkoBmY6OBXkSDIn4mCvqR2Qj99m2Fc3Lfn00c=;
        b=iG6Wm9pmrlP9lJ8ALNF9Y3ZUvEEmmab23kom24QgDC6RkLKlm6fGMk9U/3JWCP+khz
         JK8W3sw2CcPYIM3TUnZRTuC3M6hocvsFVVkJ4Jq5/nsSsPNfkVZIXmoqCWNG3JmFiDZN
         U/0N67Wf+8aKydPL7PbFN2lpOYz9pVMEJLcdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732658875; x=1733263675;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=51WI1mXkoBmY6OBXkSDIn4mCvqR2Qj99m2Fc3Lfn00c=;
        b=ioPyDxuuJU5lBAjtDPQfyHAtacMiffLn2MMRvhEDneVpkNjoJ8A4fjZWJwI2LIsxO6
         iyaG08SRhRTefa+hqxugo7COwZTQ8j1AlVuyhE3j6PCjID7EdiDN4YkWPK6Tw7odg5KQ
         TuBk4VyaDqnMCj4GKmSAFWWsH/oWom4lLef8V3zRqL6Naq3EPLY7mKqN804Dd9knW8wd
         xZFIeu8ZAGG/yPFX0V4xG0N+wIc6l4dfiduUn2nZldxAybmeeWE8/mhvJdoeiZj6bAMx
         LVnQ3tpJnL6JbJnIh57ZaictwxRMcX0ylpW6RZkLPMgQG04fEm3KOS0C3/21Wwv+PICk
         saTA==
X-Forwarded-Encrypted: i=1; AJvYcCUQiRIHs1/V71qIkyBvxOGqKBc2yNGNRrS7GBzwWID54EH4U2/o6NNcZeRA3GzrnUHuvLYS2nriILsl6AM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNMNi6iNMMCu47NF3nG5ZL9PoIqC6fIHKMQnYpZldd3WEK915y
	R5IvO9K01MsK2dKxR5qI86zl6Zs6rvj0Er9uUIBXjjrxq5A135++G6RZLXMRjl5bjGc9wyN96N9
	pD5aarA==
X-Gm-Gg: ASbGncudD272Fue6S34uORM2X0EjTYufVus4TpTQzoUYf7/izJ+N7aLcfNRb55roDRn
	WaP3XD0vdXPG5ugHOIbm6ORQNqdJDagqf2yK6XR/ZZ8JzA+Gu8dPwAZ+VboWQbS7CJv2h/4yj17
	0ej+IQHTY5WdZeodS9CwfMPyCEDgXWmH1Eu9QZX+EryoNMa+r1YBWrxH7DFrVXVLY30FDwonW/8
	o4hpN4dXRQZGKatnuDaZiQEoHSkZXOQqyyWNXJIcLGnPniz7rGdhGSB6lvQhIayvpmvdYGlSb9B
	ua5BBucylylTOKEO658/iNgA
X-Google-Smtp-Source: AGHT+IELOiLX1t1TyUDAU9TWRGki0mUn2UeFuwwqzbZs1+OlCNSi/J365sIrFtKS0Efg/RoU5dkGLQ==
X-Received: by 2002:a05:651c:1b11:b0:2fb:5688:55c0 with SMTP id 38308e7fff4ca-2ffd60dc55bmr3325401fa.38.1732658875446;
        Tue, 26 Nov 2024 14:07:55 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52f9ecsm644020466b.124.2024.11.26.14.07.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 14:07:54 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa545dc7105so486935366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 14:07:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUWfdQVADBtaKPd1gTB/WvFwShC+KF5l8ByiXNDzfO55KTbT8dmXQZDVQEIWydRc7Ie1q9Bq/xur2kwY3U=@vger.kernel.org
X-Received: by 2002:a17:906:2181:b0:aa5:c20:654 with SMTP id
 a640c23a62f3a-aa581033187mr33996766b.42.1732658874466; Tue, 26 Nov 2024
 14:07:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126022500.718070-1-ojeda@kernel.org>
In-Reply-To: <20241126022500.718070-1-ojeda@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 26 Nov 2024 14:07:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgRSWz=5e39P3Xb8FmsD6Qa-_LFBTs1q2m53yrw-yCSzA@mail.gmail.com>
Message-ID: <CAHk-=wgRSWz=5e39P3Xb8FmsD6Qa-_LFBTs1q2m53yrw-yCSzA@mail.gmail.com>
Subject: Re: [GIT PULL] Rust for 6.13
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Nov 2024 at 18:25, Miguel Ojeda <ojeda@kernel.org> wrote:
>
> Conflicts expected with both the vfs ones, trace-rust and char-misc.
> The conflicts aren't too bad -- the resolutions in -next are fine.

Well, please humor me. My conflict resolution isn't identical to
linux-next, and my rust is still very much "monkey see, monkey do", so
you should most definitely check it out.

           Linus

