Return-Path: <linux-kernel+bounces-527867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 192D5A4109F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 19:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747A11896891
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 18:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D94276C61;
	Sun, 23 Feb 2025 18:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UHMr/ZnM"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD7C1A29A
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 18:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740333626; cv=none; b=VBJNUwNMEjj4RhcgZRRg4GLE3MlEnaIQXnJPWQmyWIfmuTn8u1iRkZ+ThRdOp18BO+hHFFj7GBW/CtsrbWL0QVpasyDJx85cTZp9a57KBBDfDflWeE9oWdThhZwE6HXJgyQywksbQ+t81V9lFbAKRE3qSZBeytYmb/9iSFh/ekk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740333626; c=relaxed/simple;
	bh=+Im9YRI6ErMSvFn5MHRlPyI+Z6fjw8UDU9XqeX8HDNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YcMzwwsMx/BG8IjmvA5sbCw74kw45xKlLeabdNVVdRbTnEwUenhD1LLJho3i17rPrVBXqqUVgwuD0E4cGOSQriwnEAAbEQNxy4lrudryKeRIE/cP56k8ktkJbwwSabLg0AZ3eBkrhY1AR0WXZ+/V8A41PJEP3j/UmeUg7DgHJZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UHMr/ZnM; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abbda4349e9so530210066b.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 10:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740333622; x=1740938422; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+NxydFcyecz+dL8dA6dKLJ6I5K7PWZLIULBL5ZZCIwI=;
        b=UHMr/ZnMed2uTUJ+Vc0F/6A5jzeH14xiXEsaRAcqzq/dBrZL63q7TAkN/J5igchaOr
         q3txk39zr0fD+jsGuxm46S5WywvYnX0/sQWKmSXVvbxsjOMz/PRtu3TR2m3B47y8S2Tc
         csgeWLmUDtFk8y4M95x3YvKAd1JV2wJ2RpOf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740333622; x=1740938422;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+NxydFcyecz+dL8dA6dKLJ6I5K7PWZLIULBL5ZZCIwI=;
        b=t9XjaARJCjtxPQBZgtzKBuLURJyw72kX98iF33IaPtsWuScVLFOC0x83Ithn6LXiWj
         UAR4qi5sGMqEtNu/qnbqqjab0+WCyO96lqgZjzJA6YfFSS4CpuapSTn/XlgIfMTD9E7Y
         vaHXb+nZk9TvgWSymlHGdyZXJLrcP4gHt2gPxTyJnGujd+oFFc4McnCiesV0SgmMH/U7
         9zgwm48bS04YM8u572UWncHlFhcug/qRQcxZqQNDLcgHqYAIfUt1fQxy3AOeeN/68Uce
         fZ2zW7Yy82XXzxAxAHeRXAFxr4gYEH/QFjbUas4IlxB8P/aDV1K9Y8HaLT6gWbnOybMC
         43lA==
X-Forwarded-Encrypted: i=1; AJvYcCVrbbtWeEqW37PYPjiaSe4PY5AqhuT3AaUgGB8jXvXVdekuJW2yd7rBIEgC10RxqVRhKIY0/Qgh/bvFwnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0To5iypl1Y1yrP9Zk4ZREU3t4Rn3emDbbMLtTej+mR32lfxDz
	ySogaW8OXh3gY2SyG+7LZ8K9yzVF0lKRGn0UcqIA27GZ8qeli3rhe/LHeCXd/bdFXn2bU3mHFEw
	Kjq4=
X-Gm-Gg: ASbGncvl7xp3zrfm2hwqd504g45lBwM5TWypQ04nrOwer3NtillKZBgBz7w/JQOafx2
	CebJOaPJFf6QsqPyqUBlutOICimkikGZO61sMdf6zGzfzTNyDUjhAF911zN+yWNZbnUKxsW9m3u
	qDklYLfqZWikbpqxaIPhe7ZlS+jGVgwKsMyDOtT7egK/D0xQ3zzEnbvTRIN9E4Lets6Vhkt1P2b
	heNRomJy/Cab0lExhzowKY91VnucHLX9Fc8zY4knsqehivx1riCJXA7aVTUo51zbSm6PAJWkPT/
	tgKLVyN4DQKS/BGAthTi08206WAmUi4igiWtmejVlJAYtJK3DPnFgmlIrxLlDTYjj0p8kZuJrcF
	W
X-Google-Smtp-Source: AGHT+IFBwF4m5G/GC676PSICx9J7l68mR7tUJV3C+7QD6RTHJ9/h67yQndwo4rKTbn7c4b1ou8Frkg==
X-Received: by 2002:a17:907:780e:b0:abb:e7b0:5442 with SMTP id a640c23a62f3a-abc0da2209fmr794544266b.26.1740333622531;
        Sun, 23 Feb 2025 10:00:22 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8190d15esm1608330866b.16.2025.02.23.10.00.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Feb 2025 10:00:21 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaeec07b705so587589366b.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 10:00:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV28v0nGy+L4HccQy1MXv+dLERKRgXLAOhNNugH07wLG0VIKS4Q8/eI3UNAzygxTaZNx2Lsxt7SLgc+f0U=@vger.kernel.org
X-Received: by 2002:a17:907:7855:b0:abb:b092:dade with SMTP id
 a640c23a62f3a-abc0de0de6dmr826265366b.38.1740333621436; Sun, 23 Feb 2025
 10:00:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222190623.262689-1-brgerst@gmail.com> <Z7rsOVaxhfCJdn2P@gmail.com>
In-Reply-To: <Z7rsOVaxhfCJdn2P@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 23 Feb 2025 10:00:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjSoFLsyU4Hz6BzoRGTWh_HqEo2fm2T8jvvEnAHB_i5Ag@mail.gmail.com>
X-Gm-Features: AWEUYZmkWtQN0emdD6fXYlBuFTpr99EzxM5WZ_clbHIOYHajIVT9p5DwRNI9oCA
Message-ID: <CAHk-=wjSoFLsyU4Hz6BzoRGTWh_HqEo2fm2T8jvvEnAHB_i5Ag@mail.gmail.com>
Subject: Re: [RFC PATCH 00/11] Add a percpu subsection for hot data
To: Ingo Molnar <mingo@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Ard Biesheuvel <ardb@kernel.org>, Uros Bizjak <ubizjak@gmail.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 23 Feb 2025 at 01:37, Ingo Molnar <mingo@kernel.org> wrote:
>
> This can also be a drawback if it's abused by random driver code - so I
> think it should at minimum be documented to be used by core & arch
> code. Maybe add a build #error too if it's defined in modular code?

Yes, please.

Everybody always thinks that *their* code is the most important code,
so making it easy for random filesystems or drivers to just say "this
is my hot piece of data" needs to be avoided.

That is also an argument for having the final size be asserted to be
smaller than one cacheline.

Because I do think that the patches look fine, but it's too much of an
invitation for random developers to go "Oh, *MY* code deserves a hot
marker".

           Linus

