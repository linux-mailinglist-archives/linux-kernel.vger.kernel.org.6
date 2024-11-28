Return-Path: <linux-kernel+bounces-424098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F9A9DB094
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24B301678E5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4293B125D5;
	Thu, 28 Nov 2024 01:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxBb9Fru"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D4017BA3;
	Thu, 28 Nov 2024 01:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732755636; cv=none; b=EZyF1PqbMcODSKy9ENnVvmnX9vXlyI5BFMggXmpk/MWK7llg73omPOs8IGqha6vIQRcIeolYvbZHYZ87xUPKuYH4pFG4HyG7u58ef8fO1MlgMQu+m24AYljYiStNXurcEIv6L17+b4ZeZWWoa9yizeXkcr9LZg+c+ZSUyceeKC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732755636; c=relaxed/simple;
	bh=Z4UNfWg3zs+XouI51oSz59rP5PZwpgvoJs2Lh3iBN1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJkNunpBv4UxJaKQm2kF8JQ+sA5BZKBB3H30M5N9llWN8ikT2VK8neXKAuGXlWxcs87rNn4HeborL+RoODrExSmWhQ2ak53QyALy7017tBphDgarBNyB7T/bzvQea3xVgIO7OBws0xALL1qQ0DJZ7eAeZ2Kr911HqaGfd4hHVUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxBb9Fru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E021EC4CECC;
	Thu, 28 Nov 2024 01:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732755636;
	bh=Z4UNfWg3zs+XouI51oSz59rP5PZwpgvoJs2Lh3iBN1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kxBb9Fruj+TXYYv7dQFepie0vWCe1bmjuK1SSI/shMe7eXwOLB5OHH6TNYC2syydg
	 OFnfEhjSrMXMzos6U5shcZjDZ3o20xxMrLGbnM+j8ZSajH+hJA2W2gZJ9k8K7UxJOX
	 fIqV1OJa1dWan6fRziCJnqxldYh0WFZVmHOfsEQ4onRuQN+TZpw/ZmVLD/0o9aD9M6
	 tdllv1mB0/str7k5TqvDyHhYdBCC31MpGgL3HdJ8lZMlCy1OAU5dBjAEIQQU34axTb
	 RrSCqdYsuY6VPT2mE4Jf7DwiRMqmtnDskFb/AnujurllqlCWxUx0p5osltfS3+mpnX
	 4DcJO/08jg5DA==
Date: Wed, 27 Nov 2024 17:00:34 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/10] objtool: Handle unsorted table offset of rodata
Message-ID: <20241128010034.u3b7gkh4wqgb7d2s@jpoimboe>
References: <20241122045005.14617-1-yangtiezhu@loongson.cn>
 <20241122045005.14617-7-yangtiezhu@loongson.cn>
 <8cb35ab7-56d0-8e8d-5e18-1bc2b94aeeeb@loongson.cn>
 <20241127012042.by4g34m4twlfmove@jpoimboe>
 <53677c5f-2ea5-a227-66f7-b27c27665f6b@loongson.cn>
 <20241128001011.sjedpn2zhrhy6y6i@jpoimboe>
 <20241128001627.5czdlst5rd76qwsd@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241128001627.5czdlst5rd76qwsd@jpoimboe>

On Wed, Nov 27, 2024 at 04:16:29PM -0800, Josh Poimboeuf wrote:
> On Wed, Nov 27, 2024 at 04:10:18PM -0800, Josh Poimboeuf wrote:
> > On Wed, Nov 27, 2024 at 03:01:33PM +0800, Tiezhu Yang wrote:
> > > 
> > > 
> > > On 11/27/2024 09:20 AM, Josh Poimboeuf wrote:
> > > > On Tue, Nov 26, 2024 at 09:28:19PM +0800, Tiezhu Yang wrote:
> > > > > > +		/* Handle the special cases compiled with Clang on LoongArch */
> > > > > > +		if (file->elf->ehdr.e_machine == EM_LOONGARCH &&
> > > > > > +		    reloc->sym->type == STT_SECTION && reloc != table &&
> > > > > > +		    reloc_offset(reloc) == reloc_offset(table) + rodata_table_size)
> > > > > > +			break;
> > > > > 
> > > > > I think it can be generic, like this:
> > > > > 
> > > > >                 /* Check for the end of the table: */
> > > > >                 if (reloc != table && reloc == next_table)
> > > > >                         break;
> > > > > 
> > > > >                 if (reloc != table &&
> > > > >                     reloc_offset(reloc) == reloc_offset(table) +
> > > > > rodata_table_size)
> > > > >                         break;
> > > > > 
> > > > > What do you think?
> > > > 
> > > > I'm not sure, this patch is hard to review because it uses
> > > > insn->table_size which doesn't get set until the next patch.
> > > > 
> > > > Maybe this patch should come after patches 7 & 8, or maybe they should
> > > > be squashed?
> > > 
> > > OK, I will squash the changes into patch #7.
> > 
> > I remembered Ard already solved a similar problem when he prototyped x86
> > jump table annotation.  Can you pull this patch into your series:
> > 
> > https://lore.kernel.org/20241011170847.334429-12-ardb+git@google.com
> 
> Actually, I think I'm going to merge patches 2-5 from Ard's series as
> they're a nice cleanup.  Let me do that and then you can base your next
> version off tip/objtool/core once it gets updated with Ard's and Peter's
> patches.

Still talking to myself here, I think we'll only merge the above patch,
since we don't know what the generic annotations are going to look like
yet.

-- 
Josh

