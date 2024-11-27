Return-Path: <linux-kernel+bounces-422937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B7C9DA029
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 01:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B09C4282E88
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 00:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCF38BE5;
	Wed, 27 Nov 2024 00:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e20Ktl8Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E9ED2FB;
	Wed, 27 Nov 2024 00:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732669034; cv=none; b=Lre6tfgXs6XD2O8OJ0k3sLlVJgnusre3gp234cFlON9ObnPrPqw4MCiFHbTF/XjIVOcf0INb68ohHyqPj+pYBwZoK4g121qyxf2b+MpivLPJEplcDbm8M4dklo57RZ4JQsJu25NLGWDC+EU45DWZdvUz9+pjv3ycY39LifE09l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732669034; c=relaxed/simple;
	bh=TRTubOiKgielvhbh/gBQ1cUAI9CIniGjNnx8L8jTGh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPkglPXgymlUK2iya8t4nkq8xgrKOlIGXXflvc+3FK/cagRkg5VDAdTcbl2n7KBQkTiaIVLvYLZsqJm61Rv6eEgUmjBljU1rcu210ppv7Du6qvZNqq567nxsTqu/XK/uxjMwi4+FTMLt2oWk8x0KS4xzVJAQo3wCEoX4OWbf79g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e20Ktl8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8237CC4CECF;
	Wed, 27 Nov 2024 00:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732669033;
	bh=TRTubOiKgielvhbh/gBQ1cUAI9CIniGjNnx8L8jTGh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e20Ktl8QkEqG+dYO/sHBXQ7b4h6slgOcdiqOohU5InArO4S8TLhXyiF1uTkyygVv0
	 Z3r2g2bZN6K1eFtQhg1jG1ecN/WN1+0CSTdOdNteSedJTR3HO72suNgOJCVlPkr28N
	 ttXz7awG+jLVTQbe4gBHiSjvnddxqgJe5pY104l/Ylc1CZYDT/K8g/9Q0hPa/UhZCa
	 hku9YjMpKK6eu61BH1iGcypfeCY5qLwsgXDNOhHpaC9vBpZqEIg9I+bbZeGdUOU8Ls
	 vu/x+NlJlhyhnj+y3ZrjiSSZowcJoJ6h5kgam1eKg/igIerwObiVz+17M0jCusp+BT
	 llMrdbrzEiG/w==
Date: Tue, 26 Nov 2024 16:57:11 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/10] objtool: Handle different entry size of rodata
Message-ID: <20241127005711.de2ml367dw32ncg3@jpoimboe>
References: <20241122045005.14617-1-yangtiezhu@loongson.cn>
 <20241122045005.14617-4-yangtiezhu@loongson.cn>
 <20241126070214.26gj5fnsjx5b5vp3@jpoimboe>
 <e56d48c6-172d-5b31-86de-98384fe58e98@loongson.cn>
 <4993a8d0-d08b-d9c1-f13f-934af75c3103@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4993a8d0-d08b-d9c1-f13f-934af75c3103@loongson.cn>

On Tue, Nov 26, 2024 at 09:22:22PM +0800, Tiezhu Yang wrote:
> > OK, if I understand your comment correctly, this should be an
> > arch-specific function defined in
> > tools/objtool/arch/*/include/arch/elf.h, otherwise it also needs to
> > check ehdr.e_machine
> > in tools/objtool/include/objtool/elf.h.
> 
> There are only macro definitions in
> tools/objtool/arch/*/include/arch/elf.h,
> so I think it is better to add reloc_size() in
> tools/objtool/include/objtool/elf.h,
> like this:
> 
> static inline unsigned int reloc_size(struct elf *elf, struct reloc *reloc)
> {
>         if (elf->ehdr.e_machine == EM_X86_64) {
>                 switch (reloc_type(reloc)) {
>                 case R_X86_64_32:
>                 case R_X86_64_PC32:
>                         return 4;
>                 case R_X86_64_64:
>                 case R_X86_64_PC64:
>                         return 8;
>                 default:
>                         ERROR("unknown X86_64 reloc type");
>                 }
>         } else if (elf->ehdr.e_machine == EM_LOONGARCH) {
>                 switch (reloc_type(reloc)) {
>                 case R_LARCH_32:
>                 case R_LARCH_32_PCREL:
>                         return 4;
>                 case R_LARCH_64:
>                 case R_LARCH_64_PCREL:
>                         return 8;
>                 default:
>                         ERROR("unknown LoongArch reloc type");
>                 }
>         } else {
>                 return 8;
>         }
> }

How about tools/objtool/arch/loongarch/decode.c?  Then we don't need to
check e_machine.

-- 
Josh

