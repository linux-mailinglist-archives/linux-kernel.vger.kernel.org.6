Return-Path: <linux-kernel+bounces-512202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 076E4A3358A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 03:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86315188AE74
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9372040B3;
	Thu, 13 Feb 2025 02:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXFzev+h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C0535949;
	Thu, 13 Feb 2025 02:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739414378; cv=none; b=SSI38js/Iu8RrBbepbcahymkkgkkT8QcpBGPUAPEcgDhdKE9E5bjxADqXJeRUDXQ9hQAeI6XG6QMuvUvcnjmyVrjygUbPcGI+GAB2K/dbcOjsaPFBg1nUwYzg7e3ZuigGoRX3E+3XTd/OMWIXegLrsPae1WnR53h/7X/3d1Bp0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739414378; c=relaxed/simple;
	bh=Ye5px58taMfZ3cjCNVKAcqFsalM8tE2xKoemSzw9HqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4HrDTg64C7m9rk+DLkIoyZ4umbNtnv7kqjjc5bp6w5i6UoZEbuLdjymrvn3/oQnVy6uDQNidF4KaadPXA4/JLH9SsU6No2UJ7dOdRruN0tvAXbfgrJ1h66VC0Qy+xp7d5vsbqD9ayXSPfRduqgJOJ1V7+cJbDxuArYMX8wsC1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXFzev+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2855C4CEDF;
	Thu, 13 Feb 2025 02:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739414378;
	bh=Ye5px58taMfZ3cjCNVKAcqFsalM8tE2xKoemSzw9HqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LXFzev+hp6c/FFwdVltgsE8gpU9o0g18Chy7UX9ehEUNXE/94q8KRz2HQop9ndVGu
	 Fc5uTGsKBMCqkAyMSfOP261M7O8mQZx7bo60XuZRShqIkULgaFyuYT9oJvlu/II4sC
	 D5boKBVj5Nwu5hE1Q7nsd5RKvZ6G0Ksu5jW+lSER2rHevLHMAFrfJfxi6TFNz+q+cw
	 oo+s5O/WiwKeQm/z44gdOEgGOJKq0eNvP7+ot00xcWzhf1kK2rhmbC58urj66OIL26
	 TBlXarHd1Rr55eeiG4jfxKoCdQp3pE89IVWI9VC2a4pboqGuiK0LPvR7IiOo1XR6pu
	 /XPHA6+Ce1dvg==
Date: Wed, 12 Feb 2025 18:39:36 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
	llvm@lists.linux.dev
Subject: Re: [PATCH] compiler.h: Specify correct attribute for
 .rodata..c_jump_table
Message-ID: <20250213023936.lzbpgou4eallaij3@jpoimboe>
References: <20240924062710.1243-1-yangtiezhu@loongson.cn>
 <20250212175023.rsxsw7pno57gsxps@jpoimboe>
 <b1e5e3ea-be4b-5dae-cc0d-34693429d060@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b1e5e3ea-be4b-5dae-cc0d-34693429d060@loongson.cn>

On Thu, Feb 13, 2025 at 10:20:40AM +0800, Tiezhu Yang wrote:
> On 02/13/2025 01:50 AM, Josh Poimboeuf wrote:
> > > @@ -133,7 +133,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
> > >  #define annotate_unreachable() __annotate_unreachable(__COUNTER__)
> > > 
> > >  /* Annotate a C jump table to allow objtool to follow the code flow */
> > > -#define __annotate_jump_table __section(".rodata..c_jump_table")
> > > +#define __annotate_jump_table __section(".rodata..c_jump_table,\"a\",@progbits #")
> > 
> > This caused a regression, this hack apparently doesn't work with Clang:
> > 
> >   $ readelf -WS kernel/bpf/core.o | grep c_jump_table
> >     [43] .rodata..c_jump_table,"a",@progbits # PROGBITS        0000000000000000 00d610 000800 00   A  0   0 16
> > 
> > Notice the section name is literally:
> > 
> >   .rodata..c_jump_table,"a",@progbits #
> 
> Yes, I noticed this section name which contains the original name
> ".rodata..c_jump_table" and the specified attribute compiled with
> Clang, it should not contain the specified attribute.
> 
> That is strange but seems no effect due to only compare the first
> few letters of the section name in objtool.

It actually does have an effect -- objtool doesn't recognize the BPF C
jump table (see the use of C_JUMP_TABLE_SECTION in
tools/objtool/arch/x86/special.c), resulting in a bogus warning and
missing ORC.

I do have a workaround to use strstarts() instead of strcmp(), I'll be
posting that soon.

> I will keep digging with the GNU and LLVM compiler developers.

Thanks!

-- 
Josh

