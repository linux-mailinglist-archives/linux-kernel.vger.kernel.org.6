Return-Path: <linux-kernel+bounces-319671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DC597005B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 08:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2536C1F23321
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 06:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81B9146592;
	Sat,  7 Sep 2024 06:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWwweC9l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA8717753;
	Sat,  7 Sep 2024 06:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725691619; cv=none; b=sOIK3IQKYEfJQQmbBusixdJwgQ/cLOlNbaElYCskMDhmFBgIcT/oreN4Ix2Q3c7Ggdp7ySOmj5aAubJ6Miu7cd6hoVCGqYHz7pVhp+n5TT6Kg9cBFbVTlTgrLEQWJ/hi/cBK/Hr4jH7J92HZoOCotzikVpcEFzdp42p8vn+rbPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725691619; c=relaxed/simple;
	bh=Ddn3DwKEqRO8W6Y1jXS9ScIz9T6uLhx01JDFe4OrAgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrjFiijBwGfqnmkfCXnnRnzvw+5MP3PONlRdXjfIQ0sH1R+abDtHgiT1m3k6z+S5z7MKvGYBPb66vymI198r/q1uibCgE3mdnNW8LCTRKZPWG6NfVxFWMOVvpK23uRciX8l73LcXydPIdmvSPZWFn8EH6gjLW+MBacE362hbYjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWwweC9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E633C4CEC2;
	Sat,  7 Sep 2024 06:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725691618;
	bh=Ddn3DwKEqRO8W6Y1jXS9ScIz9T6uLhx01JDFe4OrAgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sWwweC9ladpNEdDXczNyF5Wf8y5ES2yvdi591vKHfxX270r0lYD8T3Oe5g5pQzs2g
	 zurK4/pEV2JUfVZbe7Bk6UoAWOXeElo6zOWL9H8mWFbc0ines05A8BLax2BFqJtlB2
	 O7yKRkJhkLwPBoNVmnK/T6l8piBE0mfl+IHK/bI8ISY7o1CAgJU8OURiKZHPMjk8g4
	 rZs5i01mLhlo5ZZ7FnCH8Ejuo+b/mAA7WE5eLhI8b58LNg/n6OsqeLGgTT2MxOIco5
	 B6eI6QNWZJJm3nFqValext0HB6YE/HuMgjal+1vLel03qPqj7wP2HXRYN6LhkBPxS9
	 uw43LtO+yVZtg==
Date: Fri, 6 Sep 2024 23:46:56 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Song Liu <song@kernel.org>
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Jiri Kosina <jikos@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [RFC 00/31] objtool, livepatch: Livepatch module generation
Message-ID: <20240907064656.bkefak6jqpwxffze@treble>
References: <cover.1725334260.git.jpoimboe@kernel.org>
 <CAPhsuW6V-Scxv0yqyxmGW7e5XHmkSsHuSCdQ2qfKVbHpqu92xg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPhsuW6V-Scxv0yqyxmGW7e5XHmkSsHuSCdQ2qfKVbHpqu92xg@mail.gmail.com>

On Tue, Sep 03, 2024 at 10:32:00AM -0700, Song Liu wrote:
> +++ w/tools/objtool/elf.c
> @@ -468,10 +468,8 @@ static void elf_add_symbol(struct elf *elf,
> struct symbol *sym)
>          *
>          * TODO: is this still true?
>          */
> -#if 0
> -       if (sym->type == STT_NOTYPE && !sym->len)
> +       if (sym->type == STT_NOTYPE && !sym->len && false)
>                 __sym_remove(sym, &sym->sec->symbol_tree);
> -#endif

Song, can you explain this change?  Was there a warning about
__sym_remove() not being used?  Not sure how that would be possible
since it should be static inline:

INTERVAL_TREE_DEFINE(struct symbol, node, unsigned long, __subtree_last,
		     __sym_start, __sym_last, static inline, __sym)
					      ^^^^^^^^^^^^^

-- 
Josh

