Return-Path: <linux-kernel+bounces-421939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D70E9D9254
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 08:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0421A166B59
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 07:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A7F1922E1;
	Tue, 26 Nov 2024 07:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJX82s/I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB31539A;
	Tue, 26 Nov 2024 07:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732605578; cv=none; b=PtZ6yOVFA8iuS0Any+UpEBUOsDTxsP+d1aWQXqRGZQyrSCp444Eoy+fGU4Gct3RiW7+dh1beYFaLKKGmbcYMqVhzZt7JMmhYTAymZzryvqoml3E4Jsrl149NL8cPmxyMQuu9PgYclCcqxh+LyQHhIv/IySeCxdylM1rMpLaZjUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732605578; c=relaxed/simple;
	bh=HSomVyHl0gtcUf54AJ+XL9F74D3YV9PujHFyv/ZbvGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPPDvWLpmcjR2gil5xupjR7RMlftBvyOLKQqHOlpTd3m9C13At9TDp2kDJC2vVy56Sbt2Vp0IGdUe46CzORx/Eoh7IqkakzObty8zwDCwROJyRH3nlSRNvRya9M8GueoXszYwMxXskq+ImYUCE3UDS5q+63aHM5iaiZrJZ5b/sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJX82s/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41931C4CECF;
	Tue, 26 Nov 2024 07:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732605577;
	bh=HSomVyHl0gtcUf54AJ+XL9F74D3YV9PujHFyv/ZbvGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VJX82s/IWBG7H86Bj8DsrRXuTAeeAWOqExr3Wr55zI5snB4kKIONrKgb17d9fIqCG
	 iO0tECJMaGeeVzGINz72YzHnlUiLmmRYkii4lT1HEklTQi2o5InZUoRq51qT8KrxUO
	 Ma9Nj1fOsTVT6wDk8dMESsOpNs6xRWCT/X4/jTs1hS6jOIBTE3RjN6D3WdQyzBNIBD
	 lGzpU9pl3ZpQYbn4+Q/M45feAs2dW9S/NNEDDI4fd12rt/qMBuQv1PAzuHG6CWtIyR
	 5+tYjtJ3HuCortyAReG6KAT7Ia3MKDJVMrtOwfQ9SB+YGbHtk6SCYKKqhAgI7fX2EI
	 J8VimtJLVyP2w==
Date: Mon, 25 Nov 2024 23:19:35 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/10] objtool: Handle PC relative relocation type
Message-ID: <20241126071935.2vmsna54zsa5cdho@jpoimboe>
References: <20241122045005.14617-1-yangtiezhu@loongson.cn>
 <20241122045005.14617-5-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241122045005.14617-5-yangtiezhu@loongson.cn>

On Fri, Nov 22, 2024 at 12:49:59PM +0800, Tiezhu Yang wrote:
> When compling with Clang on LoongArch, there exists 32 bit PC relative
> relocation type, it needs to get the offset with "S + A - PC" according
> to the spec of "ELF for the LoongArch Architecture".
> 
> This is preparation for later patch on LoongArch, there is no effect for
> the other archs with this patch.
> 
> Link: https://github.com/loongson/la-abi-specs/blob/release/laelf.adoc
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  tools/objtool/check.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 19d1263e64e4..8733ca620cca 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -2126,6 +2126,11 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
>  		if (reloc->sym->type == STT_SECTION) {
>  			/* Addend field in the relocation entry associated with the symbol */
>  			offset = reloc_addend(reloc);
> +			/* Handle the special cases compiled with Clang on LoongArch */
> +			if (file->elf->ehdr.e_machine == EM_LOONGARCH &&
> +			    reloc_type(reloc) == R_LARCH_32_PCREL)
> +				offset = reloc->sym->offset + reloc_addend(reloc) -
> +					 (reloc_offset(reloc) - reloc_offset(table));

Please, no more "special cases".  It makes the common code unreadable.
We should avoid checking 'elf->ehdr.e_machine' in check.c.

Maybe there should be an arch-specific function arch_adjusted_addend().

-- 
Josh

