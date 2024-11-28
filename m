Return-Path: <linux-kernel+bounces-424066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 257899DB034
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96BAAB21BA3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 00:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6F2C13C;
	Thu, 28 Nov 2024 00:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkfSyI4u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CA49475;
	Thu, 28 Nov 2024 00:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732752989; cv=none; b=R2jNHZIXYeyFasqIT7asq0pQL8TwqsYvOKzXubcOz7NVp2xrRyP2Cre01+WZtxF4fAOPSYNzh1L1R4Hp1esfVLQC9b8aezrc9CIXYOaDodwLl8J0/Zwa0/02nPv+TW8eo97sJfb77h+WhE15+94pbrzfP1iRbqAhHslBBGFMBdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732752989; c=relaxed/simple;
	bh=bawSBLpL22eskU8LmfzATSzMFJ2BMm5qykCiZYBE11w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zs7Y71njMI49J97xT00TlnR7XDcG//08vX8YjTEaXcZihVANDE5DOqkBk4cKBaLfDq8a16EVsbKMF43VH03rAt+Zq3IDkTK79yfgyKNzLUQjFgQpdpzUoQFn0e0xJIHjR5iBpYSh3y+71lA+4OYLEF+PVHl5nfcOpMr5dgfN2UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkfSyI4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D739C4CECC;
	Thu, 28 Nov 2024 00:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732752989;
	bh=bawSBLpL22eskU8LmfzATSzMFJ2BMm5qykCiZYBE11w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tkfSyI4ucaGuBDfaXXWVPu/MMt7GSlJArFQKI/928jMpyNKvZiBr5a0t9hiIiDoxj
	 0hKGSGxepRNt3WXbB7gfa0YLSrOIrjf1gAx5ii/wq/wdyMzH+nbi4AVHFO+EPKtqUG
	 zDktk6TAgVJc2EgDQsMQmdc9ML4LNWN3HXM7upOQ9SmAHNHkYEJ9k7Q3sM5DBCsqaP
	 Ijr39OKTuwULMb+Z+kc57X1QyGQo6pxPDTv04TXSl8dlxc5xEdls59k9/4TqFqEYWm
	 9/p/WcNae6TVXw6hJtlMm+f2J1qEaJvXRnotO+x58oCNrdBPcQ9Vvp+9vpo344ugHe
	 URHD9YUwWXolA==
Date: Wed, 27 Nov 2024 16:16:27 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/10] objtool: Handle unsorted table offset of rodata
Message-ID: <20241128001627.5czdlst5rd76qwsd@jpoimboe>
References: <20241122045005.14617-1-yangtiezhu@loongson.cn>
 <20241122045005.14617-7-yangtiezhu@loongson.cn>
 <8cb35ab7-56d0-8e8d-5e18-1bc2b94aeeeb@loongson.cn>
 <20241127012042.by4g34m4twlfmove@jpoimboe>
 <53677c5f-2ea5-a227-66f7-b27c27665f6b@loongson.cn>
 <20241128001011.sjedpn2zhrhy6y6i@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241128001011.sjedpn2zhrhy6y6i@jpoimboe>

On Wed, Nov 27, 2024 at 04:10:18PM -0800, Josh Poimboeuf wrote:
> On Wed, Nov 27, 2024 at 03:01:33PM +0800, Tiezhu Yang wrote:
> > 
> > 
> > On 11/27/2024 09:20 AM, Josh Poimboeuf wrote:
> > > On Tue, Nov 26, 2024 at 09:28:19PM +0800, Tiezhu Yang wrote:
> > > > > +		/* Handle the special cases compiled with Clang on LoongArch */
> > > > > +		if (file->elf->ehdr.e_machine == EM_LOONGARCH &&
> > > > > +		    reloc->sym->type == STT_SECTION && reloc != table &&
> > > > > +		    reloc_offset(reloc) == reloc_offset(table) + rodata_table_size)
> > > > > +			break;
> > > > 
> > > > I think it can be generic, like this:
> > > > 
> > > >                 /* Check for the end of the table: */
> > > >                 if (reloc != table && reloc == next_table)
> > > >                         break;
> > > > 
> > > >                 if (reloc != table &&
> > > >                     reloc_offset(reloc) == reloc_offset(table) +
> > > > rodata_table_size)
> > > >                         break;
> > > > 
> > > > What do you think?
> > > 
> > > I'm not sure, this patch is hard to review because it uses
> > > insn->table_size which doesn't get set until the next patch.
> > > 
> > > Maybe this patch should come after patches 7 & 8, or maybe they should
> > > be squashed?
> > 
> > OK, I will squash the changes into patch #7.
> 
> I remembered Ard already solved a similar problem when he prototyped x86
> jump table annotation.  Can you pull this patch into your series:
> 
> https://lore.kernel.org/20241011170847.334429-12-ardb+git@google.com

Actually, I think I'm going to merge patches 2-5 from Ard's series as
they're a nice cleanup.  Let me do that and then you can base your next
version off tip/objtool/core once it gets updated with Ard's and Peter's
patches.

-- 
Josh

