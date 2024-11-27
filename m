Return-Path: <linux-kernel+bounces-422943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 652E89DA03A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 02:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14190168904
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 01:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EB08BE5;
	Wed, 27 Nov 2024 01:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a66vyA8z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC33EC2;
	Wed, 27 Nov 2024 01:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732670444; cv=none; b=uTeChDscb9oA2Qr/AFbYctVCcAqlh+N/Fn98Awo6wj7C2bgjhy77i0wQ4JWQ4PkjP7V5NQUt3AP+pUFPYkln7URE15wOVO0R5n9D6pW9FNKW5Q1GX7TNvgNPntRbRNoO1xjpnziFY0bYsD21ke8aCXVxaaR9IBtvXeydgD7QCq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732670444; c=relaxed/simple;
	bh=ywXOQxkZrBlPQA8pwQ8ey3pcos4kYiNXmqg4FYhTzUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5ZvsowGPlDG2qrau/N53j/3tfIno5gpqsFVJyQZLL9YzinKMtZDWe80+5Q1c36nvBbJRPmGwg7DDflz8/2PvkL5LHvMpeiB8uGy/qF7bDejElf2j+SMhy95Pr8pXC6JH3PCT4oCdBWeu4k9RXo00CIyD+tQ4VfP0EHJuJyW3DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a66vyA8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D934FC4CECF;
	Wed, 27 Nov 2024 01:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732670444;
	bh=ywXOQxkZrBlPQA8pwQ8ey3pcos4kYiNXmqg4FYhTzUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a66vyA8zC4ClC2LbOvHCxabGuvTxWYcJf6u9eQTzzLe9tslx4eEfIkKaUy1jpHXAp
	 wlv8BXkqtHKx+ZZQW+s+20FyFrbaKtEPt0fV7wZlbwk4T2jWEB512w9DB9IoWYN6WE
	 1STm/t+lEXSSAHJ1PuHpRxdTb+2PqpAY41DyuDi4sDetUhm6jRfxdguFTqHzbia5OT
	 WI6Vth92NA73LtbrAtOMhsEtiDl0feeaEXA1Ijp1SEClFv8GaRxPe3yKLSR2T+pd7O
	 1ag5N2LV037r71s2QY51QWJS7iudRor0xd/7WG2/hUv/sfEFVnNBCkh90rOWjt3dld
	 1JXZ71yLEuvkw==
Date: Tue, 26 Nov 2024 17:20:42 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/10] objtool: Handle unsorted table offset of rodata
Message-ID: <20241127012042.by4g34m4twlfmove@jpoimboe>
References: <20241122045005.14617-1-yangtiezhu@loongson.cn>
 <20241122045005.14617-7-yangtiezhu@loongson.cn>
 <8cb35ab7-56d0-8e8d-5e18-1bc2b94aeeeb@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8cb35ab7-56d0-8e8d-5e18-1bc2b94aeeeb@loongson.cn>

On Tue, Nov 26, 2024 at 09:28:19PM +0800, Tiezhu Yang wrote:
> > +		/* Handle the special cases compiled with Clang on LoongArch */
> > +		if (file->elf->ehdr.e_machine == EM_LOONGARCH &&
> > +		    reloc->sym->type == STT_SECTION && reloc != table &&
> > +		    reloc_offset(reloc) == reloc_offset(table) + rodata_table_size)
> > +			break;
> 
> I think it can be generic, like this:
> 
>                 /* Check for the end of the table: */
>                 if (reloc != table && reloc == next_table)
>                         break;
> 
>                 if (reloc != table &&
>                     reloc_offset(reloc) == reloc_offset(table) +
> rodata_table_size)
>                         break;
> 
> What do you think?

I'm not sure, this patch is hard to review because it uses
insn->table_size which doesn't get set until the next patch.

Maybe this patch should come after patches 7 & 8, or maybe they should
be squashed?

-- 
Josh

