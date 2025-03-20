Return-Path: <linux-kernel+bounces-570503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D96A6B17B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31B1D188AC46
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B98B224253;
	Thu, 20 Mar 2025 23:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pv+Mnv7k"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BE51EDA18
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742512490; cv=none; b=BQwGyi0h3NYw6h5yDSO7yL138qv6e1ax1dCZP9e/cPujWXYWW7DKLZMQTS1qMpCmLwIpduHyz4kNNtUqx+rhvJ39tbKXO+4CuBr7VEoczVIm+qGrRyI4Ztk4NWAxEMk6Ps6a495m18CdjjTeNqZarobDPwJSIEEkX3/LSbk9cw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742512490; c=relaxed/simple;
	bh=4PlhkYdLseww9ZX/G3OHdVboVTdytDrGkS0TVK/WFnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1zZxaOQnG9CEcc4pRJ5Tg0KvDpYtzLxq9Dz3n1CeLd4x8c6osHd6NGJzh9Mq5YqhFhYPtXym2rnChc3FeErnd23UcZ9WDZlRQ/3fREoEBfWw102EnW6iisCUq4iYadhH7UAjORZikd7kBvJv8hQT5NFatIV+UGWE5DAGFsNrrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pv+Mnv7k; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e50bae0f5bso4420a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 16:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742512487; x=1743117287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmf84vkRPoE//bILYcmasUI85PV7cpdbJep9KD0lNBs=;
        b=pv+Mnv7k9PBAMmUJP1FJpM3rl4CEfcuXF7ki1tFz3MYTz3Hbjalxr7hpS612gKdeUe
         UTWIK8QufvWSQMy8yt8zgT+B9o19BypaXhNZptOP/RdERAAmkoSLkIcIn3V2poHkXHd+
         BLst3NWmnYBSZNpSaeBETILJwbO7jpER8l/N2cTeVkJEAoz5zXIGYRARLVhBvm/cOkNE
         wB+iU8MalTwEx6Zzxq5DRTX/IGlUH9qJaiefNrWzWOmfbRmwJjXce5aumpac0gWtVHYU
         JYT35SgOwdpL7njGcLz/eVlDmNAZYPudO2ToCSmYYDRlZjNUWx3qh3NpvfN/DfUGTnDF
         BcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742512487; x=1743117287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xmf84vkRPoE//bILYcmasUI85PV7cpdbJep9KD0lNBs=;
        b=v0Ln6vXFPTWc7MvYGH5T13sRwQede+tLdU33accJqtgExsICmFqA7f2YFMMqIdIRhJ
         Zu/ioCgD1bu78/yRUNoQuntwU6X5jtD2E81LMZvoTOhKEVmSDpN0y3gQJg2or/0Ivift
         RbJWzWJ+dOrW7BXYkHmIf37c2f/vvNHxEEhUDZWwxtM1luX743lXvjo4KW2FoLh/210C
         HKCzdGltPaxMvr6kn6qjIFP3ewQyUQdPSMsMjOjN9sve3liERksTdmgYbDEQYcdkxLda
         QZMCCqhE4sCuzute24k3sHiDL05eFlnwxbdOYFmRS57zYt930wzqPcfpSB5Vz2dwO6YS
         fylQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbekFX/hmsEzfKuBcG6Zqw2ym5PsdtB58eP3FRWTCn8HRqqOLJK1DxxpRHPCuHy40U14RaV3JQe0HSP+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzonvjVROQjt7HSNyzPu0kBCh5Gy2I/RUfj4WOahH60w24kC+cZ
	+WeSRuwwPq4OptGjxZuqAzvfXmabZw9Dv7ITz0Vx+bvtrRwXGIBqo7gwI9eokZYLZLurcHMr+JE
	1KpDVfPdH/GE+sQnVWOEhpKZUfTg1NbDJsWDkDHOTGJboae/c5A==
X-Gm-Gg: ASbGnctZRxewEpgdEvLAYKZoB6FD5MXG4KA6xMovde3x+BKADEWa3hkWNPtvEy2u0Ea
	6cA5KKpUIQ31WMMw0bYCJhGwmKMalR/MFlDrmrUFwLsySdlN3dD5jb1b/Pi30qs7/TDTHSUA51p
	vaa0x43j9nb0wiHLv40Q/LbHw=
X-Google-Smtp-Source: AGHT+IFrPgayHJvLG7VnAIuFctIQGSmHRPIwXAcT0ApwtdbeeXX5e/pZW/MkBRwEOPrDImF4qAJvaAQXLXO0sDWfosc=
X-Received: by 2002:a50:ff05:0:b0:5e6:887f:6520 with SMTP id
 4fb4d7f45d1cf-5ebcfee0018mr19006a12.5.1742512487242; Thu, 20 Mar 2025
 16:14:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320213238.4451-2-ardb@kernel.org>
In-Reply-To: <20250320213238.4451-2-ardb@kernel.org>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 20 Mar 2025 16:14:09 -0700
X-Gm-Features: AQ5f1JrZbZJceR8TeOcc1hJHewucBRn2gFuRWP5ZORuTQkfdTE490l7YFWVVDz8
Message-ID: <CABCJKucB2L7tdr79cDaDahGhc8nS6vp5fiURxoMs7z4f7yQW3Q@mail.gmail.com>
Subject: Re: [PATCH] x86/asm: Make asm export of __ref_stack_chk_guard unconditional
To: Ard Biesheuvel <ardb@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, brgerst@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 2:33=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> Clang does not tolerate the use of non-TLS symbols for the per-CPU stack
> protector very well, and to work around this limitation, the symbol
> passed via the -mstack-protector-guard-symbol=3D option is never defined
> in C code, but only in the linker script, and it is exported from an
> assembly file. This is necessary because Clang will fail to generate the
> correct %GS based references in a compilation unit that includes a
> non-TLS definition of the guard symbol being used to store the stack
> cookie.
>
> This problem is only triggered by symbol definitions, not by
> declarations, but nonetheless, the declaration in <asm/asm-prototypes.h>
> is conditional on __GENKSYMS__ being #define'd, so that only genksyms
> will observe it, but for ordinary compilation, it will be invisible.
>
> This is causing problems with the genksyms alternative gendwarfksyms,
> which does not #define __GENKSYMS__, does not observe the symbol
> declaration, and therefore lacks the information it needs to version it.
> Adding the #define creates problems in other places, so that is not a
> straight-forward solution. So take the easy way out, and drop the
> conditional on __GENKSYMS__, as this is not really needed to begin with.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/include/asm/asm-prototypes.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm=
/asm-prototypes.h
> index 8d9e62725202..11c6fecc3ad7 100644
> --- a/arch/x86/include/asm/asm-prototypes.h
> +++ b/arch/x86/include/asm/asm-prototypes.h
> @@ -20,6 +20,6 @@
>  extern void cmpxchg8b_emu(void);
>  #endif
>
> -#if defined(__GENKSYMS__) && defined(CONFIG_STACKPROTECTOR)
> +#ifdef CONFIG_STACKPROTECTOR
>  extern unsigned long __ref_stack_chk_guard;
>  #endif

LGTM.

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami

