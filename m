Return-Path: <linux-kernel+bounces-420288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7679D785D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 22:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFDEAB2277C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 21:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE681155A2F;
	Sun, 24 Nov 2024 21:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="csKzr/gh"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E266436C
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 21:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732484006; cv=none; b=eUOdKfvO4FpM9DZUD5xFgY9RoHoQG25STMFaX2Nrngy5a9jhZL9uIcQKZRHj09junSMIuFcFHpfOb38Mj6haOYOwSXuah/DC/1UTXIWU9hOZFiLhO7yQ86/ZCqAqWQKWhXlqzotx4KFSdagk1mtvJLN9lwi5Ffq151B9q53Qjg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732484006; c=relaxed/simple;
	bh=NBNlIUb1/xEDiVZlNjAsWVuJnQgM08xy6Z/QJhauPck=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=Nr2w9JLMj0Sm5+XK3qmIST/2D9rcbfFgrdsZGM0Qj3Yp51r2iQPYbF7eja7c7QNXClRhES2AHsascRRYeHcNiqlVCx5Aji7Fh2vvyaoCRpkbJSEdieGVAyllSB5jMdacihtAJVGjSX4oM3fnkY2r4GFj/+KGdSKMBLEQR7joCLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=csKzr/gh; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-212874cd62cso25385425ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 13:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1732484003; x=1733088803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sWL7LKTfHGlbjsel4TTqdC9/hVZ/qkO08+mdNJpXCIs=;
        b=csKzr/ghdS10Rb3jrqxxzUcgkefBVCEbHf4jo4sN7QO1g38SzDs0ii8gkBNLknrWSc
         8mh7peVwQiLAhGOX6HkXdwHOqpvaeAZUirKWXxhzDsly5J6EW6gVwZMZ9jk1+CB/sFmf
         Q5LHVMCFBOqoUL7eL1MXzpzFpysjmdiMTwezMW7eIrpeOcXUyB5Fu36owxoTmmu37XwT
         s5YJz53sjKnyI/OrP3LNqT/cpirfyZo83cI0lls5hiPBo9tSDlmfOFYVWtojtgzjSHht
         xr/Bc+TQ3fRSmxQWVjbSVaN253t/Q9TP2DPtx8J/KXz3Io168MxNBlGWkgpGVAfmqe+U
         +xxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732484003; x=1733088803;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWL7LKTfHGlbjsel4TTqdC9/hVZ/qkO08+mdNJpXCIs=;
        b=JrmqEaLteD/WBQ1MP0HCcpk+66kDhcD869ehT78cvvr6DZAO24oaUviyr5aSTgeA+p
         L2XUSUuTs/38K1tHcFbtX4MV94HjCGqo2rB2KpCnt1z+UX53vAXQVJ8RIXMI5E0F7j/V
         DDK0ollWMox/SuC03amAvAD0yVxLews/R8hC4IIeb2N+YUeENRQofOj3g1ltLUtuoLA2
         vwkGcM1GWMiIjVQtwiUQtyJp+7PInvwCVwjsvWaQ1jw1TeMDRfXCzkwNxqz2IWsx4ojh
         gfV+Yfv87jldotVyjvoIIIokPzHjrvujEVNRz3pLpLpPKtPvmRBHlV/mPJ69DxgmCRK+
         Ldzw==
X-Forwarded-Encrypted: i=1; AJvYcCXsmbCK1wcr/Aqqi4V8HRS8FrnzwHZMwe6yWM+R7ruoeCVNfjYH2sM3d961UMfnfac0tLmLXFX/7oFtI+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEIR6Ptcd73RozIFfA0SYEBEXw2eX7owgh4xWZUz5f/r5b0xwf
	XitwFdbtQNEgiISTmqxPJWUubISHBKilg/ak9gTJNo/WbW8ZWZQHT0bSK2s9eVI=
X-Gm-Gg: ASbGnctM9Co10H0Bxj5u6Xy+IB7CKbRZoUarMa2QxLFOGk8qoWcAkaQp4VIobbEqnzo
	E1bkZvilp5Y1VfrQsi9dsFYgCdhne9KRE6rN1nkrKI+xpRAO/0TnJRLFT+9W6rC9zrv+k6PVnkg
	2Pe+efMgBI/UKZRYJlrqLLRE+JjhJ4XO3cwFFhOAVlCSPCnJyyAP7u5PeNlBoYalNE85/ER7byn
	foI2prB6Z2yCN/M/NqEbl9WlOV1w5bFSbiDzLpyz6+7aps=
X-Google-Smtp-Source: AGHT+IFUUBdKrWzP1i9fz0BULjyS0mHzz7XRqx1KSz4AcMG/iXxhOIW+PnDOCdQsrHYOWjUIYqUQew==
X-Received: by 2002:a17:902:e94c:b0:212:5529:ef47 with SMTP id d9443c01a7336-2129f69f91dmr179913315ad.53.1732484003022;
        Sun, 24 Nov 2024 13:33:23 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc12f22sm51037425ad.186.2024.11.24.13.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 13:33:22 -0800 (PST)
Date: Sun, 24 Nov 2024 13:33:22 -0800 (PST)
X-Google-Original-Date: Sun, 24 Nov 2024 13:33:19 PST (-0800)
Subject:     Re: Unexpected lockdep selftest failures
In-Reply-To: <9025e912-7151-4a1e-b1ba-91eafde12179@acm.org>
CC: peterz@infradead.org, mingo@redhat.com, Will Deacon <will@kernel.org>,
  longman@redhat.com, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: bvanassche@acm.org
Message-ID: <mhng-65b6e1c4-82ac-4628-bc90-48dc917b193a@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Fri, 22 Nov 2024 12:18:40 PST (-0800), bvanassche@acm.org wrote:
> Hi,
>
> With the for-next branch of this tree: git://git.kernel.dk/linux-block
> (commit 12ab2c13ca77 ("Merge branch 'for-6.13/block' into for-next")) I
> see the following:
>
>
> [    0.887603][    T0]
> --------------------------------------------------------------------------
> [    0.888763][    T0]   | Wound/wait tests |
> [    0.889310][    T0]   ---------------------
> [    0.889867][    T0]                   ww api failures:  ok  |FAILED|
> ok  |
> [    0.892597][    T0]                ww contexts mixing:  ok  |  ok  |
> [    0.894638][    T0]              finishing ww context:  ok  |  ok  |
> ok  |  ok  |
> [    0.898020][    T0]                locking mismatches:  ok  |  ok  |
> ok  |
> [    0.900689][    T0]                  EDEADLK handling:  ok  |  ok  |
> ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
> [    0.908172][    T0]            spinlock nest unlocked:  ok  |
> [    0.909484][    T0]                spinlock nest test:  ok  |
> [    0.910902][    T0]
> -----------------------------------------------------
> [    0.911824][    T0]                                  |block | try
> |context|
> [    0.912970][    T0]
> -----------------------------------------------------
> [    0.913890][    T0]                           context:  ok  |  ok  |
> ok  |
> [    0.916613][    T0]                               try:  ok  |  ok  |
> ok  |
> [    0.919235][    T0]                             block:  ok  |  ok  |
> ok  |
> [    0.921852][    T0]                          spinlock:  ok  |  ok
> |FAILED|
> [    0.924666][    T0]
> --------------------------------------------------------------------------
> [    0.925852][    T0]   | queued read lock tests |
> [    0.926506][    T0]   ---------------------------
> [    0.927132][    T0]       hardirq read-lock/lock-read:  ok  |
> [    0.928496][    T0]       hardirq lock-read/read-lock:  ok  |
> [    0.929860][    T0]                 hardirq inversion:  ok  |
> [    0.931269][    T0]   --------------------
> [    0.931827][    T0]   | fs_reclaim tests |
> [    0.932383][    T0]   --------------------
> [    0.932932][    T0]                   correct nesting:  ok  |
> [    0.934252][    T0]                     wrong nesting:  ok  |
> [    0.935518][    T0]                 protected nesting:  ok  |
> [    0.936784][    T0]
> --------------------------------------------------------------------------
> [    0.937936][    T0]   | wait context tests |
> [    0.938516][    T0]
> --------------------------------------------------------------------------
> [    0.939661][    T0]                                  | rcu  | raw  |
> spin |mutex |
> [    0.940646][    T0]
> --------------------------------------------------------------------------
> [    0.941798][    T0]                in hardirq context:  ok  |  ok  |
> ok  |  ok  |
> [    0.944946][    T0] in hardirq context (not threaded):  ok  |  ok  |
> ok  |  ok  |
> [    0.948072][    T0]                in softirq context:  ok  |  ok  |
> ok  |  ok  |
> [    0.951206][    T0]                    in RCU context:  ok  |  ok  |
> ok  |  ok  |
> [    0.954345][    T0]                 in RCU-bh context:  ok  |  ok  |
> ok  |  ok  |
> [    0.957477][    T0]              in RCU-sched context:  ok  |  ok  |
> ok  |  ok  |
> [    0.960612][    T0]           in RAW_SPINLOCK context:  ok  |  ok  |
> ok  |  ok  |
> [    0.963927][    T0]               in SPINLOCK context:  ok  |  ok  |
> ok  |  ok  |
> [    0.967252][    T0]                  in MUTEX context:  ok  |  ok  |
> ok  |  ok  |
> [    0.970571][    T0]
> --------------------------------------------------------------------------
> [    0.971702][    T0]   | local_lock tests |
> [    0.972422][    T0]   ---------------------
> [    0.972965][    T0]           local_lock inversion  2:  ok  |
> [    0.974319][    T0]           local_lock inversion 3A:  ok  |
> [    0.975708][    T0]           local_lock inversion 3B:  ok  |
> [    0.977106][    T0]       hardirq_unsafe_softirq_safe:  ok  |
> [    0.978595][    T0]
> --------------------------------------------------------------------------
> [    0.979723][    T0]   | lockdep_set_subclass() name test|
> [    0.980424][    T0]   -----------------------------------
> [    0.981123][    T0]     compare name before and after:  ok  |
> [    0.982423][    T0]
> -----------------------------------------------------------------
> [    0.983434][    T0] BUG:   2 unexpected failures (out of 395) -
> debugging disabled! |
> [    0.984441][    T0]
> -----------------------------------------------------------------
>
>
> Is this a known issue?

I just ran into these as well.  Looks like there's some discussion over 
here <https://lore.kernel.org/all/Zw19sMtnKdyOVQoh@boqun-archlinux/>, 
I'm trying to proposed fixes locally...

>
> Thanks,
>
> Bart.

