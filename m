Return-Path: <linux-kernel+bounces-422938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9D79DA02A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 01:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EFE9B22924
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 00:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFF48BFF;
	Wed, 27 Nov 2024 00:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOLBPEQb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C701DFD1;
	Wed, 27 Nov 2024 00:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732669088; cv=none; b=FGLJOakTZNrAO0ZXqawwZgB/OXmNWAC8eLy+vN64NSbtM43cZzuxmfx34zuYcj4wNNjB8IstahnU27TUmBOIFxlOPvT8n0LgVsAPu7V8Y8yEmOOZhicNPlPVnm20eV6Qm0UlPPKVqNg1N+ELdIRSWGlfTBStzTQtXULOiLdA2gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732669088; c=relaxed/simple;
	bh=InBBV75D/YwDqCptswsRPEFmpyaFIuoRFEpa+kq77dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwlfBj6VTlbHXBN4tv/LURvsd01d/uFsndU+GZK1W5Sk2DEBmuuX11dE4FqlZJacidUK+nHQ+IGgCiJBuqEK0oZa4MSBTAqXfygjhIxZHPXrSIaw2WSgbgtZo1qsHMJV9+RMWCgeQHcpYvwJXPnMVWXAvhoosN6y+7hbPKa0CoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOLBPEQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07828C4CECF;
	Wed, 27 Nov 2024 00:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732669088;
	bh=InBBV75D/YwDqCptswsRPEFmpyaFIuoRFEpa+kq77dE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qOLBPEQb+yes07RSb18Z870ZI9ZVfCxaGnstS4XvUJSFWwtAQeJlq+rAjyeWGs16E
	 Kcl49IvQxQNFF1gOTqbnyHOpwEUenVvJ89LHbni6KnRNW3kRuBlUmHG4zBIojlR/e6
	 pmLAB/YxoThZ4h/ge0jBJIAsZEhXfOuetRJ/NxxfbOE1Wkzf7n05svpxEqo59MCkUP
	 2bB+ekKLa+lrCjlWTCIJFnmPKXjMnNwUvFaSSQCYmZKvi1mXMWCqRBunBOadawhamo
	 hs4tmZpdnxdsKdh8I3+kdBgXY2ftS1wodbEPRFjNuZtwx01eKNPlg/ByPU5dwuT0Zl
	 /ygacKUf/Bm8g==
Date: Tue, 26 Nov 2024 16:58:06 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/10] objtool: Handle PC relative relocation type
Message-ID: <20241127005806.3w7se42s5nqx4ss3@jpoimboe>
References: <20241122045005.14617-1-yangtiezhu@loongson.cn>
 <20241122045005.14617-5-yangtiezhu@loongson.cn>
 <20241126071935.2vmsna54zsa5cdho@jpoimboe>
 <aebad82f-3979-f7e4-a17b-5f943cd0f18b@loongson.cn>
 <76f43f37-1d5b-c80d-480d-52708652acf2@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <76f43f37-1d5b-c80d-480d-52708652acf2@loongson.cn>

On Tue, Nov 26, 2024 at 09:24:59PM +0800, Tiezhu Yang wrote:
> On 11/26/2024 07:00 PM, Tiezhu Yang wrote:
> > > Maybe there should be an arch-specific function arch_adjusted_addend().
> 
> Add adjust_offset() in
> tools/objtool/include/objtool/elf.h,
> like this:
> 
> static inline unsigned long adjust_offset(struct elf *elf, struct reloc
> *reloc,
>                                           unsigned long offset)
> {
>         if (elf->ehdr.e_machine == EM_LOONGARCH && reloc_type(reloc) ==
> R_LARCH_32_PCREL)
>                 offset = reloc->sym->offset + reloc_addend(reloc) -
>                          (reloc_offset(reloc) - reloc_offset(table));
> 
>         return offset;
> }
> 
> then call it in check.c, like this:
> 
> offset = reloc->sym->offset + reloc_addend(reloc);
> offset = adjust_offset(file->elf, reloc, offset);
> 
> What do you think?

Similar to reloc_size() I'm thinking this should also be in
arch-specific decode.c.

-- 
Josh

