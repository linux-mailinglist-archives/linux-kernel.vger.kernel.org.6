Return-Path: <linux-kernel+bounces-569379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C91A6A211
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3F833A215A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B111020FA98;
	Thu, 20 Mar 2025 09:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="If9Q4JJk"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6801A238C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742461359; cv=none; b=CI4fjVXRv20NXfZIaSQe0Tn9GX+CFFNY+bJo+1fKKGfuSGLVOwYv7ZqXU8d1woq22zQceKrDOA4tpG5qMLkPyXCPuNOETlsb1ZcrQHE+AxwGO32uDSPhdNHVNuQ9WaLt0isqqjHA8FXR2+FKVP84HgDlwKzufCOs0p7sUGI/LVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742461359; c=relaxed/simple;
	bh=pGrzZsD7jQD4q+HpXNfMs+ajcvDEH8ArFztx4QnT5O4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pK9KcFc01NXcTSXjrULjY1yJrPTWXTycAHJcJs1z2QDROgzapYNETELsBp3o9PA9WHmVJ5oG0b0aiOTwPjf13ehOrvuS/Cc+V3dqWmvHJ4EcaJMWhYXCwvF0L1SCf5XbtmGIw13pHWUqcU0WNBz0oeol5YlVwu+3YDV9I54B5GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=If9Q4JJk; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39129fc51f8so406394f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 02:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1742461356; x=1743066156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=72uAcvX5/rJRkialBraZlcCWh3cO7qq403Dc9iTXm5o=;
        b=If9Q4JJkjEBVVzG0hxA/8zqxT9dhbAx2BRcb1XkAOFsU3ReicbKkGFVENv4A0S2TXH
         x8WyT34JHFfUtINwfWNgZZvuKcNRC/poA/bG6ic66qtu9Xmp0ycGJRs19M9gbtFbDZ86
         dXQ/Z6UECNg2a95YzwMq7a1twsp9BFIeJLCwdjO6cnmCDd/nGsiSZBqO+ipWu50AlQwV
         4GIyMd8HqWPxqGadMVZicadBvkiAKu3srh6xXkk3sBSYXpBYqvJor+0ibHzOySECrDCk
         uyu9V5GkVSoy2JBHH2oV/RIIYaK50yIS1pU+Cuz72idYNVZFN4sepxnRoLdiGQuVXJtr
         F3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742461356; x=1743066156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72uAcvX5/rJRkialBraZlcCWh3cO7qq403Dc9iTXm5o=;
        b=UsfrG25FfRfcdIi88XmFDbklVf3gxpewkS74SHkZ+iUHLVuFYhG1LN/vw4t85X6daB
         UH21+0k763ENWJGHFELxiVd+EnsF2/WC55Iad09P4qg7PsQNaPQclIMVmOKkdMEosTtU
         tBLcTlbvcHMa9ha+eD7uvOivSEOpWfJchBajldNIHlD0CR7d/LEUbxErLEcOoS6222gg
         eSwuO4wHGOFwHjoGtglMDVTI1IHiT/C+M82mxoBraJZwmNXjiOuobqm/kzvMNWgUui7C
         3vgb3yf0aQLZFsbmCf94htz29YTw5ejONce7xnGFVVRVyd1ni8PUUyQ9+C+ch2R/j19T
         XycQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxHiMjgSN91+gMvGw0UMXE8j1SqoH+7Q4943ak+TzWGU1FD3FElKVTRpa5uefIBFIQDY5EIKxxopvTOHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG0qU7RREStAYmputSqopRfi/YNU5MOV1NrFQGrd2BTaZFoFXB
	neL7qJpzsYgCjHO3iXgXyF8A6r83RZmUkjYiyw/AXRLfHmxXLARqsHLziTAiayI=
X-Gm-Gg: ASbGnctGsH5y8u8euatlhWOU4tuUb+wtErbX3AgrdVEktcR7QHS8YLLzoHapSqEln4p
	Sp1D1Y0epKsdFnujKXS7yBuaBZCb4itKqHx7S1OvKuP4XmxjPUMeqJj+qUCUE6suu8BIF9PL2le
	nC1Qrs+BcDfZzIXtpxtdT3ScGwyHFF80z/bfB3MvO1+wRYNh0dTAPH1JYwnxCvs5SzUAfnzLBPj
	b30lCbdp7PhuvN4l+Bi5bMPo3bnl+fWt0AU2j/Cwj3I2xuAa9yEVfSGyTSC0Vmd+GWpN+U0j0mt
	bmnPEFf11GIJ+4pUhGl0zyjIidYUI2n5
X-Google-Smtp-Source: AGHT+IGEgBOjhueRBJQDOOD+YjPfNJuNtGPXMADUyLrPBgDpdIBjVWb7iZ7LsyjAfh/7UNsZ+oLmUA==
X-Received: by 2002:a05:6000:1565:b0:391:122c:8b2 with SMTP id ffacd0b85a97d-399795ae3a9mr2247824f8f.31.1742461355604;
        Thu, 20 Mar 2025 02:02:35 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::59a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df413esm22708633f8f.20.2025.03.20.02.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 02:02:34 -0700 (PDT)
Date: Thu, 20 Mar 2025 10:02:33 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Ben Dooks <ben.dooks@codethink.co.uk>, Pasha Bouzarjomehri <pasha@rivosinc.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jason Baron <jbaron@akamai.com>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v10 1/2] riscv: Move nop definition to insn-def.h
Message-ID: <20250320-25d2b6edb008a666151b786f@orel>
References: <20250319-runtime_const_riscv-v10-0-745b31a11d65@rivosinc.com>
 <20250319-runtime_const_riscv-v10-1-745b31a11d65@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319-runtime_const_riscv-v10-1-745b31a11d65@rivosinc.com>

On Wed, Mar 19, 2025 at 11:35:19AM -0700, Charlie Jenkins wrote:
> We have duplicated the definition of the nop instruction in ftrace.h and
> in jump_label.c. Move this definition into the generic file insn-def.h
> so that they can share the definition with each other and with future
> files.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/ftrace.h   | 1 -
>  arch/riscv/include/asm/insn-def.h | 3 +++
>  arch/riscv/kernel/ftrace.c        | 6 +++---
>  arch/riscv/kernel/jump_label.c    | 4 ++--
>  4 files changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

