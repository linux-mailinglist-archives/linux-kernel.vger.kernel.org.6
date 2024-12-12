Return-Path: <linux-kernel+bounces-442423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 014979EDC98
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 01:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E9662835DC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 00:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBEFB660;
	Thu, 12 Dec 2024 00:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aW49R+2c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1FA2594B0;
	Thu, 12 Dec 2024 00:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733963728; cv=none; b=nYMihGCWO0rPsKNyLqSw9u1UIvqjgVK3pabRjIzFBkzoyRJ0XBK+WngfkXf2TiPo7D4TcV7LXo0PsctTQIb62ZcaAWB1jdQz08lViI8YeXxwId/XnaqUcnhC7D0LfQ4hoAjdesh/rdNisFv3g62WHWG1hj+X+xnSjM/6toJZcOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733963728; c=relaxed/simple;
	bh=s1es0jjI74kqbAeLumLfzmyB2egxrsCKFd212hwJSaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbYjGNzGZbDi0R9zEhYeGjlQnBbG4gEeYBlhaUU36zDRWI28PuHGI5ZavP/ofN43YqqgmmTUbwGGK+lLBZORq+8YwZmcxvNpHhif07qOX5qFP27Zm7ixYj9UH3KJ8EAVdSP/z1ZgNJGnGNqk8oq0Czpv/J0S9PKoKn5cHwt5UTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aW49R+2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DBEC4CED2;
	Thu, 12 Dec 2024 00:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733963727;
	bh=s1es0jjI74kqbAeLumLfzmyB2egxrsCKFd212hwJSaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aW49R+2cL2eGYXQQeAiyU4iaeigbtlzxHJGSLHnZzomZupH9aqgXx4VOuAteu0MkC
	 bdxdIg5MsMEkUDobD9zXLs8+ms8jucFP8YFAPfcKWkbVhNG6jC9xHqRzaAWpRsMJlG
	 ut7xdze3yxH6awVIZSbG2rTAN/G7vljp+j2fkF/+6LdIdUNSIdArf6ynm73xnKt2Xs
	 fDRVEUF8mLRpV1VMhtUGiRv92m5tlB+MLyr+stfDd7gsS7X3gtypU/wUXpJrWomJx0
	 w7RN15Sh+E+O5brKCh+IGac8c92bBmZPz3HkB9Mlus50UJ5uK8QxZczg4ZHsT2HV1f
	 BI3sc1NkqzJNA==
Date: Wed, 11 Dec 2024 16:35:26 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/10] objtool: Handle PC relative relocation type
Message-ID: <20241212003526.2kutif7m2svtbp6l@jpoimboe>
References: <20241207015915.1159-1-yangtiezhu@loongson.cn>
 <20241207015915.1159-4-yangtiezhu@loongson.cn>
 <20241209203544.axetpzva7vg3hsc5@jpoimboe>
 <9d14c8fa-d61d-bd12-efd7-5a17f4f8cb35@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9d14c8fa-d61d-bd12-efd7-5a17f4f8cb35@loongson.cn>

On Wed, Dec 11, 2024 at 11:16:33AM +0800, Tiezhu Yang wrote:
> When compiling on LoongArch, there are some PC relative relocation types
> for rodata, it needs to calculate the symbol offset with "S + A - PC" in
> this case according to the spec of "ELF for the LoongArch Architecture",
> the "PC" is the index of each jump table which is equal with the value
> of reloc_offset(reloc) - reloc_offset(table).
> 
> I will add the above description to the commit message to make it clear.

I understand how PC-relative addressing works.

The oddity here is that "PC" is the jump table's base address rather
than the entry address.  That has nothing to do with the ELF spec or
even how R_LARCH_32_PCREL is implemented.  Rather it seems to be a quirk
related to how loongarch jump table code expects the entries to be.

So the arch_adjust_offset() name seems wrong, as this is specific to
the jump table implementation, rather than relocs in general.

Instead call it arch_jump_table_sym_offset()?

-- 
Josh

