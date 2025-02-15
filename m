Return-Path: <linux-kernel+bounces-516260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D18C9A36ED0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 15:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F5FE1894555
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 14:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CBF1B532F;
	Sat, 15 Feb 2025 14:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fIUUZ7XB"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F8414F98
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739629651; cv=none; b=o2V1HT+yGHRbMVQAZsqlhHei9Ma3Kz/mUXejmwj80IqTHVPYGlWRdSal0adK/22UpThp/MBptkq+3+WCOWMHR53uLcwIZpzApA9nSa28mt3IF3Yi3wOkY4+kLh65mNWGFHtxCOB+4H2Kb0Smac1X2d89crP6/JEczFQORVOcLKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739629651; c=relaxed/simple;
	bh=zmFD4L5onpsm+McWUJ+K1qmz7o1NjCqSo3v/svl054M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4U+dz3uuwEEe9hLPl9nXeETaN1PPtf0HTFmu9l/w5GyRUG9miUVp/HnjWnk3cBMg7zUdz+ssRK6A9goQ5Wvi2xDKvuuDUK5gpTphVHzC9u9P95WkRtVt2B9rDyMev6Hf/US6lDWk0xp4nOg06gt2SBYd+kBB8/qAZ3+K13BTO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fIUUZ7XB; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0AC3640E016A;
	Sat, 15 Feb 2025 14:27:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DdLv2nFAMkcG; Sat, 15 Feb 2025 14:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739629644; bh=c+n/bErykiv7phXieiCuZOkKU2DIVyyxzRRevlEH3xY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fIUUZ7XBWgD+MEAgXr7M6tw+1addxLauLJNs9ofNGA3deiR1XHdgFl4gEAPLYwnEu
	 pQEp4JRH9O37N/oU+KDppoj9ISiTaC4Jep/L0CP+IR2SS4R0EH3IOJmZxufkrNgxFt
	 lSUsmwJO3d7BbGkd1nqliNav+3Gw7W2pw6SHdKhDKx3tx4lBpAGleL5RT7z/vu6/rJ
	 UqVSdYpTXIWxqOzKhJcGfib4WTOcnXE3MJ/hJSpbxJQpKudUtAMzqfhv1lU3h2mLgq
	 hW8ApajijonTXtrU0MGnUTVDhblUUWj8AdZ/qrxgpygi6jCOeRQvfISq0RLTV/EzjK
	 WL0dUjp6HrbLtvC6+TM28AYlwZ8d043Ot8vTugdmLT6YmsmTkUQvLP2HB9pzOF6i7H
	 M5AFih783DGDJJA+OLqKaQ9ejeWgto6O22V268qh9mMkLjtQsB7Cn+x2zxyRLcdiwr
	 h8V16hZ3N8hOzzuGtSzJ/bUXIvyw8WAIHsNCs+bVB9Uokcp+T9xpjNMvJGD7WPgGVc
	 aSN5BqlsYKt6wGgq2Ad/xBy0wfvskcfm7aH9RLRzjr4MxpQmjaAyEdzkTzI7PAoQyJ
	 PbXRBKvEB0qhuKuvDzrQlbS8wbBytNI50S6m6PY6fyqKevF5q6qYG7mL5ez2vHFqHq
	 B77q6ibeLbE2SH9C8W6hGfu0=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D19F940E01A1;
	Sat, 15 Feb 2025 14:27:15 +0000 (UTC)
Date: Sat, 15 Feb 2025 15:27:14 +0100
From: Borislav Petkov <bp@alien8.de>
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ard Biesheuvel <ardb@kernel.org>, Uros Bizjak <ubizjak@gmail.com>
Subject: Re: [PATCH v5 08/16] x86/stackprotector/64: Convert to normal percpu
 variable
Message-ID: <20250215142714.GFZ7CkQtdXoUM-xKMo@fat_crate.local>
References: <20241105155801.1779119-1-brgerst@gmail.com>
 <20241105155801.1779119-9-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241105155801.1779119-9-brgerst@gmail.com>

On Tue, Nov 05, 2024 at 10:57:53AM -0500, Brian Gerst wrote:
> Older versions of GCC fixed the location of the stack protector canary
> at %gs:40.  This constraint forced the percpu section to be linked at
> absolute address 0 so that the canary could be the first data object in
> the percpu section.  Supporting the zero-based percpu section requires
> additional code to handle relocations for RIP-relative references to
> percpu data, extra complexity to kallsyms, and workarounds for linker
> bugs due to the use of absolute symbols.
> 
> GCC 8.1 supports redefining where the canary is located, allowng it to
> become a normal percpu variable instead of at a fixed location.  This
> removes the contraint that the percpu section must be zero-based.

Unknown word [contraint] in commit message.
Suggestions: ['constraint',...

Use a spellchecker for your commit messages please.

> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 5b773b34768d..88a1705366f9 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -140,14 +140,7 @@ ifeq ($(CONFIG_X86_32),y)
>          # temporary until string.h is fixed
>          KBUILD_CFLAGS += -ffreestanding
>  
> -    ifeq ($(CONFIG_STACKPROTECTOR),y)
> -        ifeq ($(CONFIG_SMP),y)
> -            KBUILD_CFLAGS += -mstack-protector-guard-reg=fs \
> -                             -mstack-protector-guard-symbol=__ref_stack_chk_guard
> -        else
> -            KBUILD_CFLAGS += -mstack-protector-guard=global
> -        endif
> -    endif
> +        percpu_seg := fs

Any particular reason this var is not in all caps like the rest of the vars in
this file?

	PERCPU_SEG := fs

...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

