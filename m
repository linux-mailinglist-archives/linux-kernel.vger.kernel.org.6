Return-Path: <linux-kernel+bounces-442424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D949EDC99
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 01:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C019167905
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 00:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04857C2E0;
	Thu, 12 Dec 2024 00:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWdu1+Sh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAFCB640;
	Thu, 12 Dec 2024 00:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733963959; cv=none; b=YRhwGvpIFB59aTt+YLTHmDXtqmdVnOztUMz0Wc3mNZWvuVBcn3SYmOQGRml8C73kV4/JMQ3wzeUk6rHnUJTDfZQy41uQs3nfiqH9/v+k6RyGY6QI+QM6yDKkwy9OZkYoyEwSAo+4ikzdG3qNYD7zVXMTmT3mM25MZoo9TGoT7DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733963959; c=relaxed/simple;
	bh=gnb2mh8CwraORjHmYYAChk8fuaom8IZd6azBAgkPDzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DITW2wmKLuw9/vVcMIWX9Pp1Xi3tWc15yWVJ7h+Hhi7WRPV5vJCsS+xP+yP7pjxvkv0KXviIDFRuJypE9ihwNXq1B5UqIbYDM86Asdi5JTbNIcMvvhbPEABW/kqyF8sTY/K6TeOn2+48vCHoIGg5W71M1z6cnWGiusiRd3QItDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWdu1+Sh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F86EC4CED2;
	Thu, 12 Dec 2024 00:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733963958;
	bh=gnb2mh8CwraORjHmYYAChk8fuaom8IZd6azBAgkPDzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RWdu1+ShHwcVyIFveYz+7tdi7P/7+lAJVS4FchUBvHDZx9YNuGU0GeHM4/08ZdkiS
	 67xIr52N52vKlE5sWwVc1rhjSU6CRNGCdoUt3nO344V7Ph6DW8BJa2U833QOrJVEWf
	 5828VLxI8Ecu1qQXaFlYZdumBWzbVCDiHkyU81wO1qMPkQMyL+mjqPmijfGXlmy1p0
	 tL8wR59zdi23RqkoRor1vNbmgwETQEL0IVGbyeYYxCSQONRyIkrG3EldkuJbT1+590
	 7Wsl3B90W//kUQLvPw6+kBMmwQT65lHtEBChnTF9af8trqveC4UoH3pcjuUVK9zyku
	 NRKV1bY8ulVTw==
Date: Wed, 11 Dec 2024 16:39:17 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/10] objtool: Handle PC relative relocation type
Message-ID: <20241212003917.vqnqmkrjgfl2cqd6@jpoimboe>
References: <20241207015915.1159-1-yangtiezhu@loongson.cn>
 <20241207015915.1159-4-yangtiezhu@loongson.cn>
 <20241209203544.axetpzva7vg3hsc5@jpoimboe>
 <9d14c8fa-d61d-bd12-efd7-5a17f4f8cb35@loongson.cn>
 <20241212003526.2kutif7m2svtbp6l@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241212003526.2kutif7m2svtbp6l@jpoimboe>

On Wed, Dec 11, 2024 at 04:35:27PM -0800, Josh Poimboeuf wrote:
> On Wed, Dec 11, 2024 at 11:16:33AM +0800, Tiezhu Yang wrote:
> > When compiling on LoongArch, there are some PC relative relocation types
> > for rodata, it needs to calculate the symbol offset with "S + A - PC" in
> > this case according to the spec of "ELF for the LoongArch Architecture",
> > the "PC" is the index of each jump table which is equal with the value
> > of reloc_offset(reloc) - reloc_offset(table).
> > 
> > I will add the above description to the commit message to make it clear.
> 
> I understand how PC-relative addressing works.
> 
> The oddity here is that "PC" is the jump table's base address rather
> than the entry address.  That has nothing to do with the ELF spec or
> even how R_LARCH_32_PCREL is implemented.  Rather it seems to be a quirk
> related to how loongarch jump table code expects the entries to be.
> 
> So the arch_adjust_offset() name seems wrong, as this is specific to
> the jump table implementation, rather than relocs in general.
> 
> Instead call it arch_jump_table_sym_offset()?

BTW, do both GCC and Clang have this same behavior for loongarch?

-- 
Josh

