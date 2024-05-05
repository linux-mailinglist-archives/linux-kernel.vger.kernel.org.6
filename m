Return-Path: <linux-kernel+bounces-169191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3FF8BC49C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 00:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 700721F21BA5
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 22:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B339413FD8C;
	Sun,  5 May 2024 22:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvADrHwT"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770FC26AC5
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 22:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714949167; cv=none; b=BOUNdvgLYwf+G7UymYCk8S9zyO+a0V6WKmCNZMfwK7slipihlODpnMAHpp1jQvsk5fWMYDo2mFjUhhgKCrm/ue2+h5NQRrl6jw35GZIknlm0XAzCSnYAUQhTK/NPIh5ls3oJeQXl5hYjsa/D6P3DYzJ2MiPmLySeSA0SfSz5wxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714949167; c=relaxed/simple;
	bh=zhlB7Fq0o6YOVJ07sy+Af1SHLPehmXkTm9uPn2j7VSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVzrE52dnpQ6t9iJsYjSgnPexCvAmyw9GIYagv3ZgbP/qbTB8ERFssocQIPPCtzk8HFTNvfQT3a81SLDNAEnHPaGRFZhI26+H71ICFfgRba0RwYAcMLkrizcaxIr4bQbjiANtTImuXKTVW0vpeK6MPNovBmPzZ9MIDbM9V6qjHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvADrHwT; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59cc765c29so89830266b.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 15:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714949164; x=1715553964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=er8OR4CkvYPSBm1vxvC1YRmn3HecSea62NIpaFm00EE=;
        b=hvADrHwTRimcIzPCf5DSLKPwasf7lyK9iA8G15r9kyTHhOlZgrHAhFz66x1CGuTROC
         vs3jPXTSnHQKkGZ7BtIYILHQoB/fErs2sShzCpGtO7SbPch5GX35RvyfwvNwR3Vy33xg
         OHlOy3F+meAe6wx2/JVZBetc3bnJE6aVye8mYY+wdmMXpacwtjPLbVjerNTrRYzfqfpi
         KAbCl5NZRO5th1PJpRmNLjHQiI9mITrPDxsn/BZE5DqYGnixAG/nEOEP5fy/JWE578Wo
         fif6yBxWxPlzbTI0UqSbWK5vRbw3yPbtzxnF9Csvg8Xb0oQtLJxeTBrRTGHSoQVo/rbZ
         mUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714949164; x=1715553964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=er8OR4CkvYPSBm1vxvC1YRmn3HecSea62NIpaFm00EE=;
        b=EZeDPNTiF0mKB5W8T0G7e6f8nEDQRo18pX5pJcT2nXjuvc+J8FDwUoEgYe46NFBR7M
         0dJs5OZgDLL0ra7KEtQ3sMUzB5/vSzpeI+Sv6ficqfaEpNBetBNZLDKXJMObz5ncNPUm
         DM4DOwPjUGYh9r50N3kZqRv1bfCNqIyeogpIG+m/XBP1MsYQ0xbmrzeCBEmAZuFRAKYb
         VKUxQZlew/gn66EFMge/ltVVAPm5okj3NsnThOderk7DdjA4wWt9/n55bwfzzNbveOVY
         peiJTdva64/FWZAoao9eAWzf9oqY2lZmAJn01xzea/A/oVD0HUFyI5fCNEcFk0mplU4S
         K0YA==
X-Forwarded-Encrypted: i=1; AJvYcCV6I0IoibX4sT6MlcUO/1xy4bxvwJ6RTIgzM944BHdruENbKNF/vnGPpIZBO9KFnnY/4t6z8tP80Mjs84JoVX/2oZ+MEP7UgjJ8yEha
X-Gm-Message-State: AOJu0YyRt4R26+SFMwGKXdhvUXc0vbrajaEdr1VWjoaN9XrmFMOoNbGb
	rdYDaprfys9sCVOR4BgMfYWTH96Y8dGhbZZ3wpzqGX+4h9AGmCYJ
X-Google-Smtp-Source: AGHT+IE1/6e5myoOflXf6PssbMgp2B8PrKhMe36vaBg4y3AUfAz4FRqToTD83Ld+f7kcxPFP/Aalpg==
X-Received: by 2002:a17:906:b806:b0:a59:ba18:2fb2 with SMTP id dv6-20020a170906b80600b00a59ba182fb2mr2137235ejb.35.1714949163495;
        Sun, 05 May 2024 15:46:03 -0700 (PDT)
Received: from andrea ([31.189.114.81])
        by smtp.gmail.com with ESMTPSA id a25-20020a1709064a5900b00a59a9949ec9sm2188379ejv.118.2024.05.05.15.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 15:46:02 -0700 (PDT)
Date: Mon, 6 May 2024 00:45:58 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, puranjay12@gmail.com
Subject: Re: [PATCH] riscv/atomic.h: optimize ops with acquire/release
 ordering
Message-ID: <ZjgLAKlWC2HQzWfU@andrea>
References: <20240505123340.38495-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240505123340.38495-1-puranjay@kernel.org>

Hi Puranjay,

On Sun, May 05, 2024 at 12:33:40PM +0000, Puranjay Mohan wrote:
> Currently, atomic ops with acquire or release ordering are implemented
> as atomic ops with relaxed ordering followed by or preceded by an
> acquire fence or a release fence.
> 
> Section 8.1 of the "The RISC-V Instruction Set Manual Volume I:
> Unprivileged ISA", titled, "Specifying Ordering of Atomic Instructions"
> says:
> 
> | To provide more efficient support for release consistency [5], each
> | atomic instruction has two bits, aq and rl, used to specify additional
> | memory ordering constraints as viewed by other RISC-V harts.
> 
> and
> 
> | If only the aq bit is set, the atomic memory operation is treated as
> | an acquire access.
> | If only the rl bit is set, the atomic memory operation is treated as a
> | release access.
> 
> So, rather than using two instructions (relaxed atomic op + fence), use
> a single atomic op instruction with acquire/release ordering.
> 
> Example program:
> 
>   atomic_t cnt = ATOMIC_INIT(0);
>   atomic_fetch_add_acquire(1, &cnt);
>   atomic_fetch_add_release(1, &cnt);
> 
> Before:
> 
>   amoadd.w        a4,a5,(a4)  // Atomic add with relaxed ordering
>   fence   r,rw                // Fence to force Acquire ordering
> 
>   fence   rw,w                // Fence to force Release ordering
>   amoadd.w        a4,a5,(a4)  // Atomic add with relaxed ordering
> 
> After:
> 
>   amoadd.w.aq     a4,a5,(a4)  // Atomic add with Acquire ordering
> 
>   amoadd.w.rl     a4,a5,(a4)  // Atomic add with Release ordering
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Your changes are effectively partially reverting:

  5ce6c1f3535fa ("riscv/atomic: Strengthen implementations with fences")

Can you please provide (and possibly include in the changelog of v2) a more
thoughtful explanation for the correctness of such revert?

(Anticipating a somewhat non-trivial analysis...)

Have you tried your changes on some actual hardware?  How did they perform?
Anything worth mentioning (besides the mere instruction count)?

  Andrea

