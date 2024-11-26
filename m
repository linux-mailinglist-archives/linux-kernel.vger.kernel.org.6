Return-Path: <linux-kernel+bounces-421745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 996F49D8F77
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 01:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2654B25451
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 00:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60073629;
	Tue, 26 Nov 2024 00:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="s5hWQN1C"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9FB23AD
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 00:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732579710; cv=none; b=XAuCo5c1oMh0YGmZG/lcYp0Dl1iyFPDX70lNfgMU+s32NwpAdFgMBDkT3jAjCFLAMLQzaDJNhevvFocmfXB84cr8+7dwaGNQZx65v8kMmrukZ6gJMbfr/YQc6b2eksQZCzZQgUbzii9BJ3YM4tsbOwUzq1oKTvEofReK5Cu7RdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732579710; c=relaxed/simple;
	bh=qxiao+6zoiDV8RkRFMAA1vyoB1cdx1Fa0U25P9GW6CA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5J4RGp4NiYczWWiVE8n2kD/EDRRGlsbRkzRedgY5WliLxnlYiODWpAYN2+4XbSxMBKk19XUzeo+XdyAPd/GG9rN6LZasIHDaTWNmoPEGScYzfR7eIghrOorRi8Oidd/J634ZnGv6DZ4fpzjFl8ugflU3H0HuylEHTq6B5bQUlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=s5hWQN1C; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2124ccf03edso49222085ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 16:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1732579706; x=1733184506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zh1TgMvheeVr/BG655bBpDMUthEZKkR99De/4VnyTA4=;
        b=s5hWQN1CH5wMNtYQHpvRy8ZHl1OITK8Aby60WIo8ggaE4n8ognXI13dMzBr2j74fqw
         y8aHb4K21feI5cR/ry/e02dGMcuP9Ut4ooR5W6BPUue5jqC1Ep8Pd/SdxD0H8h2moYuG
         1HMcaERDEV4e9ikfJfD86QhYFdPnm9VwxtN77V5dM/aMRY9WaUlW8P/h7HvXXShIGmLg
         4mvW5NDOndTQ15d4aPHpIy9B0usVFXkZ4Vkr8Fe5dPR49pJsw4gQQZrC2MK9H1nrBuOu
         ktAJPMPwyElOL2Q2iD+TP+CnK/FqOD9kyirhwPkuzi0O0Dr21rkMZKGgXRUtyBj+qF2b
         3+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732579706; x=1733184506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zh1TgMvheeVr/BG655bBpDMUthEZKkR99De/4VnyTA4=;
        b=ptAxLbsAzkUW/aRwmRyGb/b3+8Kx51EvrdLbc93r01ouPpifQrw45fWDHz4RUoccOV
         l+oe1yAeSJHotVUDrVwslxwUlIe4lngr2vpNJChnOC/dN0lvndiqzGq3xNxnIQ7HkMZP
         S+yn9T6AL322jVw+P5JWc4ZLBSVkD7VIqIG8/QMZ0GH+in5TcfvbI4BRsUmBsKO0WgYN
         9QqQwZGx9kqZh/7DiTfXBEqm8QVbJXC1Mo3/rst3TLUDqM7nc1iYnfZ6jEc/tW70VpDu
         jUAXSN0CVBGkvT5Ey4PZ0c616Ks3zzDW5hKTN3CO9U87YwkRM0exr4Axc7yZdBdYT2pK
         tm0A==
X-Forwarded-Encrypted: i=1; AJvYcCUtXFnAGqYedV2ZOC4MLnXrPZ1FCKCTwdNZbPYqE21bFBOu86tDSxGZ2kp3TzaBqkbnQg56lpz7pZ/nhng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyepezy/vKFYgAvejTrDbv9OpJhVIBi0dVpWvVeAk4ZKrg/Opj6
	3YWlmvUDWPeZX7eUjn543j2Fe9huc8GT2eyijIJE484NYwYqWDu5ZCk9oDVY8Gk=
X-Gm-Gg: ASbGncsW+E6j8WarXc8RaDSI2p9ZfELRRth4O9fNLpYTf7hl9LoTHD36/MvCpSob2wz
	hP/F+q+MARvfe9/kw/e/wZm/cCXCHnFcmXrGP8CnHrTAqpUERhjy00sb0QLYKYWKIotzEhTMhBB
	9lID84N3o7W+hWrN2HfRCtLSEONA4XZ9uC84M8lCDzCNOAKB7ReT4Kqn/aqYrNUwtU/2XI7Z3ai
	+JaFAZa8cbmQflaI1ZHNFlu/eMEgZ0aAE3RPcjNHJ1msgofv7sd5XDoTvvV
X-Google-Smtp-Source: AGHT+IG8ozr347scOy5JQuieWGflhyN5051oqzpPFJ8B9W47XT0S3F43TqSpqc/XUJ1CnmDY/mroig==
X-Received: by 2002:a17:902:e5c3:b0:20d:cb6:11e with SMTP id d9443c01a7336-2129f797c7amr185807305ad.26.1732579706280;
        Mon, 25 Nov 2024 16:08:26 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc12917sm71433345ad.185.2024.11.25.16.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 16:08:25 -0800 (PST)
Date: Mon, 25 Nov 2024 16:08:23 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Clement Leger <cleger@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] riscv: convert bottom half of exception handling
 to C
Message-ID: <Z0URd1oF6FnJGXa8@debug.ba.rivosinc.com>
References: <20240720171232.1753-1-jszhang@kernel.org>
 <20240720171232.1753-4-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240720171232.1753-4-jszhang@kernel.org>

On Sun, Jul 21, 2024 at 01:12:28AM +0800, Jisheng Zhang wrote:
>For readability, maintainability and future scalability, convert the
>bottom half of the exception handling to C.
>
>Mostly the assembly code is converted to C in a relatively
>straightforward manner.
>
>However, there are two modifications I need to mention:
>
>1. the cause I.E the CSR_CAUSE value is passed to do_traps() via. 2nd
>param, do_traps() doesn't get it from pt_regs because this way an extra
>memory load is needed, the exception handling sits in hot code path,
>every instruction matters.
>
>2.To cope with SIFIVE_CIP_453 errata, it looks like we don't need
>alternative mechanism any more after the asm->c conversion. Just
>replace the excp_vect_table two entries.
>
>Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>---
> arch/riscv/errata/sifive/errata.c       | 25 ++++++++---
> arch/riscv/include/asm/asm-prototypes.h |  1 +
> arch/riscv/include/asm/errata_list.h    |  5 +--
> arch/riscv/kernel/entry.S               | 57 +------------------------
> arch/riscv/kernel/traps.c               | 37 ++++++++++++++++
> 5 files changed, 61 insertions(+), 64 deletions(-)
>
Sorry for noticing it so late. And thanks to Bjorn for pointing it out.
lgtm.

Reviewed-by: Deepak Gupta <debug@rivosinc.com>


