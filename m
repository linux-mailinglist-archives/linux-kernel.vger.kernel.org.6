Return-Path: <linux-kernel+bounces-221465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E8D90F40A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D6C1C2128C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F55615356B;
	Wed, 19 Jun 2024 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="a15LrQ9z"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D83322EED
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718814615; cv=none; b=hMJPRGJZw9xrmICXn+nnhElihGUKyAGb9VXbn0J9+7SCEbE9ccsf68vZQfdo2rGGmWEP5767ZKpMYMPoIVhYYYkbqbuyCuAWPgzEX+t8gQHuACNVQwkIApoCuZTfEDQYRYKRY8ayMA7Z58ZYoJs0S7eEdr8YB5OeDTsZnmhHpuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718814615; c=relaxed/simple;
	bh=dp25EsiBd11NszkiIn9GNJkF0HAneQLbCddpeo/HboA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Idx55DzolLFKLF3TA+Cme23bEjZbge1Qr8t6H/ZIopbo5VIGMX/Z7OTXQoUTl+by0CHM9gWNXHyJ+EdRCVVTXtykq+Yix0TYHHk3xeax7EqTYUdkovHp70dpdA028mVXLYbY+Tl9J9N36phWbXZzOyO0HI0Eq2AVgrqMjcSqMss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=a15LrQ9z; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7041053c0fdso14330b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 09:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718814613; x=1719419413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LFnXBBCEP1zENhQqFr7hAM7gxfLMtKTQ/XL+1dQ5OE4=;
        b=a15LrQ9zUVhq+KE6uAlf2mXZUhFqQmucubCGMAfJzGOoY/+B/0mRoMqkEvyUUDtUzb
         qY57aINsmYMkwvDmB1KnRm4nshqVpEgh8nc+7gl3D9mwfy7Xdh6kVH2Fkg3/k83mD64/
         WT7Wq6csN39ORYpnCejRCykZUVaj7SYL3kok4K0vFw5qMG1n2ZfqdaF5VJBINIEuRbdj
         zHTc0xnOwnC0+gV+q178VGWQHCEtAQ7edemRwKY1oyrk/BztW+m2h6rLNfmLaqKxjrs8
         oWAyNTZIIE8bzk7Wa3u1zmu7cdcK9iElC25R/9fK3ohVO/j8yZJG2gX1HFHDdYIdV3SZ
         W0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718814613; x=1719419413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFnXBBCEP1zENhQqFr7hAM7gxfLMtKTQ/XL+1dQ5OE4=;
        b=HOfgmYqvk+ZSmjj3m/J1nPEQXydDx38xCKzodR85rg9jH6BuI8UVmFC/FELAJYUTvn
         4BLpQiJzMXUUf9Pqrhrpxr3YevMsfETTGNWVwblfDvN94lTzHU8pNKTELHk1YABWbHmd
         apoazkxG357r4wSFDuvrmq8hNpb6r70XVJZxYkfWcOwCuCjADcP+HewmglBN7tPJHeJA
         9qL+li8p3d4mpTAWNI/v+e2s4fUgh4lJyc+xXNslEu37ryvZHlkHlpSvmsGNkB5WpIM8
         9NdSs3/mP9Hj6hi3VqpRcgL5/pnUoy+G/ZViZTcPQH94GIjiMDVCQsinYD0Jk4t7cnBO
         upxg==
X-Forwarded-Encrypted: i=1; AJvYcCUVIaFKTddpdRh9TotJveqn8/FLfPu9uwDFhZPDY0UXsFxtrtGOvQyW3AYB5GwyTJw4pFJY38KHxJ0hMI6tFcbr0CyNnCwSNzquHV7o
X-Gm-Message-State: AOJu0YxLlu37+bgxsAzKazfjaOHuWL7WRsI6jGcYmPe13V5a0JM/KngS
	ySVRdQr911y0Nfh+2We8KBAG2eCVQgGOXc7bzbjmSooK/nRkqqCDWa79xqxhFWg=
X-Google-Smtp-Source: AGHT+IHXKN8DL34VymsPnaJwN/SMjnVjtOibIBszp5LGFbCG2Rghjc6BQa/Sa/zE4+NekK/vXzWdfw==
X-Received: by 2002:a05:6a00:2d89:b0:6f8:f020:af02 with SMTP id d2e1a72fcca58-70629d01686mr3766318b3a.34.1718814612752;
        Wed, 19 Jun 2024 09:30:12 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7062cb0a402sm1665445b3a.33.2024.06.19.09.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 09:30:12 -0700 (PDT)
Date: Wed, 19 Jun 2024 09:30:10 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] riscv: convert bottom half of exception handling to C
Message-ID: <ZnMHku8LSGmuHZQS@debug.ba.rivosinc.com>
References: <20240616170553.2832-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240616170553.2832-1-jszhang@kernel.org>

On Mon, Jun 17, 2024 at 01:05:47AM +0800, Jisheng Zhang wrote:
>For readability, maintainability and future scalability, convert the
>bottom half of the exception handling to C.
>
>During the conversion, I found Anton fixed a performance issue
>and my patches will touch the same exception asm code, so I include
>Anton's patch for completeness. I also cooked a similar patch to avoid
>corrupting the RAS in ret_from_fork() per the inspiration.

nit: Probably corruption is wrong word here giving the notion that software
got some capability to corrupt uarch structures. It's simply mismatched # of
call and # of rets. Imbalance (instead of calling it corruption) in return
address stack (RAS) leading to incorret predictions on return.

>
>Mostly the assembly code is converted to C in a relatively
>straightforward manner.
>
>However, there are two modifications I need to mention:
>
>1. the CSR_CAUSE reg reading and saving is moved to the C code
>because we need the cause to dispatch the exception handling,
>if we keep the cause reading and saving, we either pass it to
>do_traps() via. 2nd param or get it from pt_regs which an extra
>memory load is needed, I don't like any of the two solutions becase
>the exception handling sits in hot code path, every instruction
>matters.
>
>2.To cope with SIFIVE_CIP_453 errata, it looks like we don't need
>alternative mechanism any more after the asm->c convertion. Just
>replace the excp_vect_table two entries.
>
>
>
>Anton Blanchard (1):
>  riscv: Improve exception and system call latency
>
>Jisheng Zhang (5):
>  riscv: avoid corrupting the RAS
>  riscv: convert bottom half of exception handling to C
>  riscv: errata: remove ALT_INSN_FAULT and ALT_PAGE_FAULT
>  riscv: errata: sifive: remove NOMMU handling
>  riscv: remove asmlinkage from updated functions
>
> arch/riscv/errata/sifive/errata.c         | 25 +++++++---
> arch/riscv/errata/sifive/errata_cip_453.S |  4 --
> arch/riscv/include/asm/asm-prototypes.h   |  7 +--
> arch/riscv/include/asm/errata_list.h      | 21 ++------
> arch/riscv/kernel/entry.S                 | 61 ++---------------------
> arch/riscv/kernel/stacktrace.c            |  4 +-
> arch/riscv/kernel/traps.c                 | 57 ++++++++++++++++++---
> 7 files changed, 81 insertions(+), 98 deletions(-)
>
>-- 
>2.43.0
>
>

