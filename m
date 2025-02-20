Return-Path: <linux-kernel+bounces-524739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91892A3E680
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9678189F936
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB0C1EDA06;
	Thu, 20 Feb 2025 21:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeYWl0sE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791341E571F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 21:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740086717; cv=none; b=EnyijoCkMf9AwSzUppOUo+dki1HHsEi7+6CHFrLSlW1Prt7Ajx/++sAbaTsvW8p0/qAeWjuJdK6t2Wy55xt3/IZ48NCf3xQVhaCzGfV6opnNZAS0Gz0agwGvNaaKUlmf8gt1lIS2l5nnaYA/tYJjJqhJ75Tp8iiLMEJ0A/sDdmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740086717; c=relaxed/simple;
	bh=0/FNKRDo86BOQ7XOaZh7rZ1/4ZhYF5So1ZCsHiEQXnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEA0KBiXxmoyyPbuuwsji7UVfQhq/2x8qulwwUyzNafRApAkVIhttL8XpgYUUX59LFsF5/y6+3yf67HAdpBpVkCSYLxevPpsw7K4yhTKa39S65ov3LxZXLb8HCyKemGznPK/xj/IwG9LyXOiCx07ACcaCedyNTpkWRc796lJYJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FeYWl0sE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2511C4CED1;
	Thu, 20 Feb 2025 21:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740086717;
	bh=0/FNKRDo86BOQ7XOaZh7rZ1/4ZhYF5So1ZCsHiEQXnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FeYWl0sEmjt2gPUWPK3KVVuLsIPlMo8OKB7b0fGUxNR7qqyTAP1FOqPq30ba+PNwr
	 NofdLmktT0fdLvPcLlPfJVV0hDXQPrdyKsSIYKHnSfDsMAZH7nNgHGAs8MeZFgUjac
	 N0UgiC44SFDK94n7NlAp/2cbsGh+qNYNp0+ijFBUc0JsFLdUPxj7PYlg+CM/dAj1ua
	 hanSTIGdgagfGV6n+cueDcoVwM9kXtWb7Gyo2A/J6UVv03AaBudKed98pqJdKNzsr1
	 VYw3nuvcy6MH4pApIyzoniuStsDF5NtrpZEHKyEy8rl7EwkGqQ9Q8k9NhwqX20WcdG
	 Onk6VQ2NyB+qg==
Date: Thu, 20 Feb 2025 13:25:15 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v2 2/2] objtool: Use fPIE compatible ELF sections for C
 jump tables
Message-ID: <20250220212515.on6esv3rffkmdbkq@jpoimboe>
References: <20250219105542.2418786-4-ardb+git@google.com>
 <20250219105542.2418786-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250219105542.2418786-6-ardb+git@google.com>

On Wed, Feb 19, 2025 at 11:55:45AM +0100, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> A C jump table (such as the one used by the BPF interpreter) is a const
> global array of absolute code addresses, and this means that the actual
> values in the table may not be known until the kernel is booted (e.g.,
> when using KASLR or when the kernel VA space is sized dynamically).
> 
> When using -fPIE codegen, const global objects of this nature will
> generally be placed in .data.rel.ro rather than .rodata by the compiler,
> and forcing these C jump tables into .rodata like is done currently will
> trigger warnings from the linker about combining read-only and
> read-write input sections into the same output section.
>
> Avoid such warnings by unconditionally emitting C jump tables into
> .data.rel.ro, which will always be placed appropriately regardless of
> whether -fPIE is actually being used.

Just to clarify, currently there are no linker warnings.  The original
linker warnings (fixed by c5b1184decc8) were only with the GNU
toolchain, and only on LoongArch.  Clang/LLVM apparently didn't care.

The only problem being fixed here is that the hack in c5b1184decc8
doesn't work with Clang/LLVM, so the C jump tables get placed in
'.rodata..c_jump_table,"a",@progbits #'.  Which confuses objtool,
spitting out the following warning:

     kernel/bpf/core.o: warning: objtool: ___bpf_prog_run+0x20: sibling call from callable instruction with modified stack frame

> Note that, while possible in theory, compiler generated jump tables are
> unlikely to end up in .data.rel.ro, as the compiler will use relative
> references when using -fPIE, and these can be resolved at build time.
> 
> This supersedes commit
> 
>   c5b1184decc8 ("compiler.h: specify correct attribute for .rodata..c_jump_table")
> 
> which addressed the linker warnings by injecting section attributes into
> the __attribute__((section(""))) name string, but this turns out not to
> work reliably across toolchains, and may result in missing ORC data in
> some cases.

Missing ORC data was a side effect, it's really the warning which should
be called out in the description.

Also, since this is indeed a bug fix, that should be made clear in the
subject, something like:

  objtool: Fix C jump table annotations for Clang

> Fixes: c5b1184decc8 ("compiler.h: specify correct attribute for .rodata..c_jump_table")

Reported-by: https://lore.kernel.org/202501141306.GYbbghj5-lkp@intel.com

-- 
Josh

