Return-Path: <linux-kernel+bounces-549814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F049CA55786
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 270BB175D46
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9F9271284;
	Thu,  6 Mar 2025 20:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7bMicvA"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743CE2702CD
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 20:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741293441; cv=none; b=B+morLw2gg3JJwHBi+hAq/LxUGzPv6/4RFdUVx0Q/8ONyJK4xEIHNoii2liJDivL/Tlhw1PdPQbFMkDlcgWJV8I/ToyHTu5PZgyJEFryAEf4bhgFiUvJVuMhtnkBR4pkTQBGKsF/r79sGQ+KPqvdc4oKHFVurAvP+ui8hIfRBdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741293441; c=relaxed/simple;
	bh=nBU7JwWAewC7/7YbO2vFsSGAL0Zmh2bH72iSHitNGvY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=slkN2DQZKHOcPMTj1QGfl64EhrAO7R1tBd/105A45cJr7Bh8t35VQDZysFcPTLtk0vlMqGerAP7DyU05FQKocPcXzg9waGq2qprMRe/Ef0i19RXGUrbLlwG4WiK2ZUcdgWxZWjo62omBsTYLbi0L1bAWTHkqodQiHRVkQX0J6pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7bMicvA; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-391342fc1f6so48817f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 12:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741293438; x=1741898238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=weFAf1peaJvUAX0QpqPT4UR56LBo/B6sl1fhd1ciLZA=;
        b=V7bMicvApHHn8d+0RrDLNBlBhtDw9uYT3STQ8S4T3d90qA8blaKq9j7Eprj2B/9swB
         dyp02r4v0FB4NM3EMumIsWO3Yn8AIM4SZUhqPm9gghYsi9MZFpC6UdNxbrmEt37a6s3T
         0nLnBzEGI40Ap5Qv6T2KT6if98bFJNMHTIQyyhiingflYxVnsgkhwilLMihsDzh9htCY
         NdwOsRs97A9LWfRzIsLwn9HD10UuUrnPbQ4I7N9kI4CASKbLfhAOyJgeHn+ORZrY/7Ep
         jE2YN5QQteVdMmD43dltNrx5HD0X6AyfoHptJxdsqXfmQ2NIBErQPFL/D8BMiBvGQkI9
         YEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741293438; x=1741898238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=weFAf1peaJvUAX0QpqPT4UR56LBo/B6sl1fhd1ciLZA=;
        b=oaeNwL/ezzpZgOzerFcLL0SWIRy/82GIvcTslWsoKMDPLcqo8LnfZju+Y+pWf0tUJb
         ISnyfBmUTez5Kb2oYzHEccoyKESVSkEKO8wPX0OUQoxj72ZIXUzu+iJrMgaP+rrC2fk3
         dkdibnQ9dHfmFlgpRG+W2XJD8QlCqzgg/W6yN6/WEd72bj0O9NJsKqMiS/wsSHUllb8U
         HJARjqo1uwVO4iPZ3MyAXagWzGdmg4zsMPfLnM5GPgyLxiJ3ILEks3yAdm8COLGPj3EH
         fcMHBzeN7MffuJXPkHrnbvngVI/RaiupvUolG95lILjRWEpmywFM+gbSif/v3p7jJyxE
         Fq1A==
X-Forwarded-Encrypted: i=1; AJvYcCUjYCxq6pMAMzyTm1N8g1mjTB5timEserKArVZETVEvQRH2hhYMFNs6Jv6EGpRfm75Ed8ql83wKmsKeLE4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuf4yEFtRyWSNQALMsC81l4LMYQmtAVIcJES3pK+OeYpvzpf9t
	ZkRc4/dmzfVzHqkWgxbmqPNMBkDcVJL4JqhCDGWiqi12fKQH3lq5
X-Gm-Gg: ASbGncv+bq6aCsOp4X4xEX7zOtgpTuybHQwvSCI5qC64JGoY1a2j80MAybrR0plO+HH
	hWIj9M1K+9HprD2RrmM/16EuddGLG7OTpAyC/pguWDjHJ6IXQ2HEm8MeVRpmf36Ws8jHhd2rXL4
	jQTzB30l4+gZ4EEiMFvuGixTM3zcfd8QE6E9oWqovPD2Pcwd8oJkTAdlLBV5T3fcpZtghPTChI8
	DU4bRixkPkt1UUYdE7YtZZg+xZClkjVkVsuVe/5dhOuuTfueWKIRzwAZy88CBO5+SbIJJvatgox
	JZEKhf35NvqiB686Fej490FY1pz7uoUMIo+JURnoDww3M45YoBTHLDy1sZixmhB3hRuCEX2sDiO
	2UmyT+Vo=
X-Google-Smtp-Source: AGHT+IGEk7BhgyUMoeHj7my6G8CO7rielQnLNfIQpMjXQfziciMatLmqLTxdlRI4vbl8Wberg68sOw==
X-Received: by 2002:a05:6000:402a:b0:390:e535:8758 with SMTP id ffacd0b85a97d-39132d2afc2mr386104f8f.9.1741293437469;
        Thu, 06 Mar 2025 12:37:17 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e2f39sm3026761f8f.80.2025.03.06.12.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 12:37:15 -0800 (PST)
Date: Thu, 6 Mar 2025 20:37:14 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner
 <tglx@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linuxfoundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann
 <arnd@arndb.de>
Subject: Re: kernel: Current status of CONFIG_CC_OPTIMIZE_FOR_SIZE=y (was:
 Re: [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic locking
 insns)
Message-ID: <20250306203714.118ead69@pumpkin>
In-Reply-To: <Z8luPgXr9hcO7jDz@gmail.com>
References: <20250228123825.2729925-1-ubizjak@gmail.com>
	<20f1af22-71dc-4d62-9615-03030012222e@intel.com>
	<CAFULd4bpHGE83qc37sbh=rpGj+SFqQrsNDLzL_-NQpo6pQH3jw@mail.gmail.com>
	<c4aca08a-95c1-48ee-b4da-55a69b74101c@intel.com>
	<CAFULd4YVOEtT+bsp9H7ijaoJn2e2108tWhiFarRv=QxoUMZaiw@mail.gmail.com>
	<20250301123802.GCZ8L_qsv7-WwUwqt5@fat_crate.local>
	<CAFULd4b=4rHcVAVSg_3yMb8=3ReiSriw_rM4vJL9_HvheXE92w@mail.gmail.com>
	<20250305203633.GNZ8i10cVCCnhhULis@fat_crate.local>
	<20250305212638.GC35526@noisy.programming.kicks-ass.net>
	<CAFULd4ZsHKA4Yh9CsxPjdoW-fa7yD1-Ov7xDN4E3J3c8O8yQ7g@mail.gmail.com>
	<Z8luPgXr9hcO7jDz@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Mar 2025 10:43:26 +0100
Ingo Molnar <mingo@kernel.org> wrote:

> * Uros Bizjak <ubizjak@gmail.com> wrote:
...
> And this one by Linus, 14 years ago:
> 
>   =================>  
>   281dc5c5ec0f ("Give up on pushing CC_OPTIMIZE_FOR_SIZE")
>   =================>  
> 
>   From: Linus Torvalds <torvalds@linux-foundation.org>
>   Date: Sun, 22 May 2011 14:30:36 -0700
>   Subject: [PATCH] Give up on pushing CC_OPTIMIZE_FOR_SIZE
> 
>     I still happen to believe that I$ miss costs are a major thing, but
>     sadly, -Os doesn't seem to be the solution.  With or without it, gcc
>     will miss some obvious code size improvements, and with it enabled gcc
>     will sometimes make choices that aren't good even with high I$ miss
>     ratios.
> 
>     For example, with -Os, gcc on x86 will turn a 20-byte constant memcpy
>     into a "rep movsl".  While I sincerely hope that x86 CPU's will some day
>     do a good job at that, they certainly don't do it yet, and the cost is
>     higher than a L1 I$ miss would be.

Well 'rep movsb' is a lot better than it was then.
Even on Sandy bridge (IIRC) it is ~20 clocks for short transfers (of any length).
Unlike the P4 with a 140 clock overhead!
Still slower for short fixed sizes, but probably good for anything variable
because of the costs of the function call and the conditionals to select the
'best' algorithm.
OTOH if you know it is only a few bytes a code loop may be best - and gcc will
convert it to a memcpy() call for you!

The really silly one was 'push immd_byte; pop reg' to get a sign extended value.

But I do remember -O2 being smaller than -Oz !
Just changing the inlining thresholds and code replication on loops
(and never unrollong loops) would probably be a good start.

	David

