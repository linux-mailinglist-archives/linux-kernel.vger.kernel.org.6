Return-Path: <linux-kernel+bounces-421912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EE69D91E0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 07:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0283165157
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 06:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC0A183CCA;
	Tue, 26 Nov 2024 06:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lx15ylj7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE916653;
	Tue, 26 Nov 2024 06:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732603500; cv=none; b=LCZXJzxlwQ0mS4YOUWpTFhrJoVZdU+WqNtf+cHwQvLCl/RrL23eJ2iTycITM3iTCnBw8mcLKwjDcsiVbwLrSoHfDEHBH5RqAULTiwz9zHpED5e3e+Pv7zG2WPXF8kWXuv+451tUNLig2wP082lxxsMPEuhBzGWlaVa8YTL3cBE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732603500; c=relaxed/simple;
	bh=2DisQXb4NDMxUR1QYsipn2a3FuJxfxdcJ40z1OKpeBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZbfCmptv/4KhHzNSR3b5ULiSQBh1qUP9ZV7d/CehzrmBsBwh6K+D3OgmYMMRrrLnTjo558SNM6hETE8a0KPTd4CGMKH/zDBq/fwyo6gx3eKqTMAhWZlVtXl0Ap+iYd2iruuZBkky8PfsfIgMQOENX7l3qM2QHYncRhQ3f6fUJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lx15ylj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23567C4CECF;
	Tue, 26 Nov 2024 06:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732603500;
	bh=2DisQXb4NDMxUR1QYsipn2a3FuJxfxdcJ40z1OKpeBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lx15ylj7Xu49oGQTr3JJCDR7bNIaWj4pgXDPvwZWmDsdKVgI554r6Df5wm48SqeWg
	 tCHMpoAB7HHkCvzX/xbJ06QA42aYRDDXsHHWE04X4Hc0cz6DyICvotEhA5gSmDUSHS
	 M5gVu6Zu8cH0sQMffeAvWI9saXvtociyZpP50tX2Qu3rhJzaq/n9q2Bi1tapTJaka2
	 IoWkZ4rd4yd4j1tq9Z+ysOgG3IkEgKNhMa8AFx7j+7bA6ZbEz0cRxSnM1QY6y3s78Z
	 RFhdRvo5v5Z3+ExyVhdXaGkZdqTSL+Um3ZAUlSd4az/mTY1jQ+YLtqBTsdiuKWZ3Z0
	 Tn3IFeodrkubA==
Date: Mon, 25 Nov 2024 22:44:58 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/10] objtool: Handle various symbol types of rodata
Message-ID: <20241126064458.7ugwqfx5vhnwzvbi@jpoimboe>
References: <20241122045005.14617-1-yangtiezhu@loongson.cn>
 <20241122045005.14617-2-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241122045005.14617-2-yangtiezhu@loongson.cn>

On Fri, Nov 22, 2024 at 12:49:56PM +0800, Tiezhu Yang wrote:
> @@ -2094,12 +2095,19 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
>  		if (prev_offset && reloc_offset(reloc) != prev_offset + 8)
>  			break;
>  
> +		if (reloc->sym->type == STT_SECTION) {
> +			/* Addend field in the relocation entry associated with the symbol */
> +			offset = reloc_addend(reloc);
> +		} else {
> +			/* The address of the symbol in the relocation entry */
> +			offset = reloc->sym->offset;

The comments don't seem helpful.

In the case of STT_SECTION, sym->offset is always zero.  Therefore the
if-else can be converted to a simple unconditional statement:

	offset = reloc->sym->offset + reloc_addend(reloc);

'prev_offset' needs to be updated as well.

> @@ -2137,6 +2145,7 @@ static struct reloc *find_jump_table(struct objtool_file *file,
>  {
>  	struct reloc *table_reloc;
>  	struct instruction *dest_insn, *orig_insn = insn;
> +	unsigned long offset;
>  
>  	/*
>  	 * Backward search using the @first_jump_src links, these help avoid
> @@ -2160,7 +2169,16 @@ static struct reloc *find_jump_table(struct objtool_file *file,
>  		table_reloc = arch_find_switch_table(file, insn);
>  		if (!table_reloc)
>  			continue;
> -		dest_insn = find_insn(file, table_reloc->sym->sec, reloc_addend(table_reloc));
> +
> +		if (table_reloc->sym->type == STT_SECTION) {
> +			/* Addend field in the relocation entry associated with the symbol */
> +			offset = reloc_addend(table_reloc);
> +		} else {
> +			/* The address of the symbol in the relocation entry */
> +			offset = table_reloc->sym->offset;
> +		}

Same comment here.

-- 
Josh

