Return-Path: <linux-kernel+bounces-232798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 108AE91AE68
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 19:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FD581F2992A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7425F19A299;
	Thu, 27 Jun 2024 17:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="Iz7KIqYJ"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9803013A276
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 17:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719510468; cv=none; b=qK0s9Wn8+Q/9PsaRflInY9vyPiCrq86UVdjS6c2MFFPFr0J5ds40SHjaqTAomUdg2hN1qgbEH+T7RV0s9DsrxE/xJUqXPk9EwPKC00JP5T208zY0wImn6HoVxvHM6gYhLVrj7a4o7V3OwPZDDPySPKql0kx/jpBlq0AlcHkDbxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719510468; c=relaxed/simple;
	bh=MTZ3hUQ+3T1i7gL9eB4g9KxQm4uPN/OOpaTqlyxxs5c=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=uPRfR/Xwikt8nMLfjX7d5O6fVvMAg886i3glWKruHy4U1EINq43Eaxc6eoOOii94SqjjrIkWfFWE2uoLBJRAsae4dY2nEEJz4i588dw1gZexgySTCFRCvK5LqdEuVjE8wladLsUy9xipruJs3Jh0JtjdksRKXcTLiWCJf3IQG8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=Iz7KIqYJ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-656d8b346d2so5801101a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 10:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1719510466; x=1720115266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pP/AqxoKCyoqEpFvmzCtu+OJjkK1mMvRQlVqjG6zlp0=;
        b=Iz7KIqYJxXPgtQS0KIYfhe88jwUXziTMTtGFzuB1xsjzFHaPI3aBmlCth6w/bLnc2U
         NhnPgRCjyQX4t+lwOsAfQE5Aye0Py/PtGdp1vRz/7qcl5bqNkamy+lNraauXoRoJ/Nyr
         LZCzlzX0o+Uizo3BKzhhNOCfxzqeh3YBfIB9zAe0L7ro7fNPaJh6prVg1o7D2qZiwLef
         Xxb0PZmCNkSXugG/CGwX9Hl6fD7HorUIY3T8VeAVf1vyK1eTfLzQR7f70kWGTlSoKLMp
         0bi4N9kxhvBkdlf+bAY+l2J9CEqfSMlJJW8H/x2IJI3HqB4VzK8W66PUSg6jJs2eZfJP
         Qavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719510466; x=1720115266;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pP/AqxoKCyoqEpFvmzCtu+OJjkK1mMvRQlVqjG6zlp0=;
        b=nzrZd6gvfH9Q4c69zxbthDle2qDPSbDmL6hPu/Bx56JAzJs0RztzN+hkJznd/Nl7cM
         Gf6PO3wzHtugf79yiYTszG/QcxSMXNGvFkVyDWDujAahTz9aAutOGcJNWF8en/XB7v44
         1L124unnRDVNEYWCkI2CGHsEVVvlkFcC9I8lE76G7tLIrh+qPXWrsC+zkGlqFxzibwLS
         6MExkgpja7RrpCPy9NRGKQOtLdxauW8ZfxOZ1bgSMXwisSoegmlvbbyXa1TZ+dzzwSyt
         ldhik8kYpP7NX18Vohf96NIuSavkznLrLZEhawOs7HajJPDSKka5HaBW8NZX3WxLbiU9
         LFGA==
X-Forwarded-Encrypted: i=1; AJvYcCVQhPJRutI0VyuPMy6HqhY/1VpzTTVFGNMAvy5ifDQkbXVs1Eje4WsIUT7andzrkm/ZNPZGTQq13ZZ/zKzShNzx1Wlh9fS2Xh+JJ0j3
X-Gm-Message-State: AOJu0Yy6owLCgG8N8oNEpHM1oVipF5Isqb2Lzb9d/MrxZpBZ7hUv+uVd
	NGTHp/vr8OTJhP0CbJ+Jj1EDMZP1XXkLXx2d1trMucHs7RTJ4NITbAMhPj++uio=
X-Google-Smtp-Source: AGHT+IGVJIolUw1wnEP6rXONdYGodPDrBpa15ZN0Oskw9/8CenqbKYTIAQinxff1hF7IO+HHWnbJgg==
X-Received: by 2002:a17:90a:780f:b0:2c2:f704:5278 with SMTP id 98e67ed59e1d1-2c8ab7379d4mr8580920a91.42.1719510465605;
        Thu, 27 Jun 2024 10:47:45 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce466f8sm61119a91.21.2024.06.27.10.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 10:47:43 -0700 (PDT)
Date: Thu, 27 Jun 2024 10:47:43 -0700 (PDT)
X-Google-Original-Date: Thu, 27 Jun 2024 10:47:41 PDT (-0700)
Subject:     Re: [PATCH -fixes] riscv: patch: Flush the icache right after patching to avoid illegal insns
In-Reply-To: <20240624082141.153871-1-alexghiti@rivosinc.com>
CC: rostedt@goodmis.org, mhiramat@kernel.org, Mark Rutland <mark.rutland@arm.com>,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, Bjorn Topel <bjorn@rivosinc.com>,
  alexghiti@rivosinc.com, andy.chiu@sifive.com, puranjay12@gmail.com, linux-kernel@vger.kernel.org,
  linux-trace-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Conor Dooley <conor.dooley@microchip.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: alexghiti@rivosinc.com
Message-ID: <mhng-d9e4078a-6e3f-4890-b507-93005c5a91df@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Mon, 24 Jun 2024 01:21:41 PDT (-0700), alexghiti@rivosinc.com wrote:
> We cannot delay the icache flush after patching some functions as we may
> have patched a function that will get called before the icache flush.
>
> The only way to completely avoid such scenario is by flushing the icache
> as soon as we patch a function. This will probably be costly as we don't
> batch the icache maintenance anymore.

Ya, it's going to be pretty miserable for performance.  We'd talked 
about using objtool for the static rewriting a few weeks ago in the 
patchwork meeting, but with the dynamic rewriting suffering from similar 
issues it seems best to just pick this one up.   We can always sort out 
the performance isuses later, at least this is correct.

> Fixes: 6ca445d8af0e ("riscv: Fix early ftrace nop patching")
> Reported-by: Conor Dooley <conor.dooley@microchip.com>
> Closes: https://lore.kernel.org/linux-riscv/20240613-lubricant-breath-061192a9489a@wendy/
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/kernel/ftrace.c |  7 ++-----
>  arch/riscv/kernel/patch.c  | 26 ++++++++++++++++++--------
>  2 files changed, 20 insertions(+), 13 deletions(-)
>
> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> index 87cbd86576b2..4b95c574fd04 100644
> --- a/arch/riscv/kernel/ftrace.c
> +++ b/arch/riscv/kernel/ftrace.c
> @@ -120,9 +120,6 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
>  	out = ftrace_make_nop(mod, rec, MCOUNT_ADDR);
>  	mutex_unlock(&text_mutex);
>
> -	if (!mod)
> -		local_flush_icache_range(rec->ip, rec->ip + MCOUNT_INSN_SIZE);
> -
>  	return out;
>  }
>
> @@ -156,9 +153,9 @@ static int __ftrace_modify_code(void *data)
>  	} else {
>  		while (atomic_read(&param->cpu_count) <= num_online_cpus())
>  			cpu_relax();
> -	}
>
> -	local_flush_icache_all();
> +		local_flush_icache_all();
> +	}
>
>  	return 0;
>  }
> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> index 4007563fb607..ab03732d06c4 100644
> --- a/arch/riscv/kernel/patch.c
> +++ b/arch/riscv/kernel/patch.c
> @@ -89,6 +89,14 @@ static int __patch_insn_set(void *addr, u8 c, size_t len)
>
>  	memset(waddr, c, len);
>
> +	/*
> +	 * We could have just patched a function that is about to be
> +	 * called so make sure we don't execute partially patched
> +	 * instructions by flushing the icache as soon as possible.
> +	 */
> +	local_flush_icache_range((unsigned long)waddr,
> +				 (unsigned long)waddr + len);
> +
>  	patch_unmap(FIX_TEXT_POKE0);
>
>  	if (across_pages)
> @@ -135,6 +143,14 @@ static int __patch_insn_write(void *addr, const void *insn, size_t len)
>
>  	ret = copy_to_kernel_nofault(waddr, insn, len);
>
> +	/*
> +	 * We could have just patched a function that is about to be
> +	 * called so make sure we don't execute partially patched
> +	 * instructions by flushing the icache as soon as possible.
> +	 */
> +	local_flush_icache_range((unsigned long)waddr,
> +				 (unsigned long)waddr + len);
> +
>  	patch_unmap(FIX_TEXT_POKE0);
>
>  	if (across_pages)
> @@ -189,9 +205,6 @@ int patch_text_set_nosync(void *addr, u8 c, size_t len)
>
>  	ret = patch_insn_set(tp, c, len);
>
> -	if (!ret)
> -		flush_icache_range((uintptr_t)tp, (uintptr_t)tp + len);
> -
>  	return ret;
>  }
>  NOKPROBE_SYMBOL(patch_text_set_nosync);
> @@ -224,9 +237,6 @@ int patch_text_nosync(void *addr, const void *insns, size_t len)
>
>  	ret = patch_insn_write(tp, insns, len);
>
> -	if (!ret)
> -		flush_icache_range((uintptr_t) tp, (uintptr_t) tp + len);
> -
>  	return ret;
>  }
>  NOKPROBE_SYMBOL(patch_text_nosync);
> @@ -253,9 +263,9 @@ static int patch_text_cb(void *data)
>  	} else {
>  		while (atomic_read(&patch->cpu_count) <= num_online_cpus())
>  			cpu_relax();
> -	}
>
> -	local_flush_icache_all();
> +		local_flush_icache_all();
> +	}
>
>  	return ret;
>  }

