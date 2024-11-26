Return-Path: <linux-kernel+bounces-421928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B699D920B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 08:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54337B23FE5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 07:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F0F188CDB;
	Tue, 26 Nov 2024 07:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNqttpYj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DED917BB6;
	Tue, 26 Nov 2024 07:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732604536; cv=none; b=BFDEyduH/dnW+Pv2VBIvj8VlPcXpKkP+wFVz/K1zg+Q4p4QtFOaMft8ycXhVPwA1eDH2JmN+bia+0ub6xFv2lfHlelEV4YsIjhWUzBiYObx8W5ru5jsChF4hmVX8MPvYY4gRiwIbCA0qJVLfHkWORAGB6APiILQXtzhJIXPNM3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732604536; c=relaxed/simple;
	bh=4byAIp/t1Ns1tcm8MyqaK13t9RKpeMFIDZQBB1y9nKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qW6OMv2tADttlnLNr8oeWadDotm9bJZLiRo+bDbqLZWTQC4rt9Zo/Fsap6KsZ2RpcVsXjm/nVyzj0BIEXRD3zdZIbgD89SmhqXIlmMB5itrY5eYSp4KbI3xQoGOicKpj4hZgxD3lU1axjQv5wGPGh+fTGWNRMADeMl9bmSapYhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNqttpYj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D30FDC4CECF;
	Tue, 26 Nov 2024 07:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732604536;
	bh=4byAIp/t1Ns1tcm8MyqaK13t9RKpeMFIDZQBB1y9nKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cNqttpYjh8Q2HokP0gHDFA7Rbu+FvbDecQuz6VFP2V4Qq4yejOq64bZjA4NSSSYIO
	 wtP8qaQdj3lrNETAMN00Q/ksqT2CEsOcQwjQ/jrcmb3VGBzw6zoHIC+vblo73FLXmG
	 aE+A7fSNVxcPUqOUPkpMSGl2VYhY1TK2UIrCHkqNHMMBN9uq653wSfAfy/LFEwZ5aS
	 WV/icpuINfPpvt8H4nowa4JKpYEJbuHH6s5OFy352i6cDrhmRk3hwPefa9UPwCMQCi
	 jkbFoeBQ4gttg4t5UFFjoTYenvEt+E27JQf4HNqL3pb4Lx46MxxuP/cZgba71W4qji
	 O1PZHY/+69xwQ==
Date: Mon, 25 Nov 2024 23:02:14 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/10] objtool: Handle different entry size of rodata
Message-ID: <20241126070214.26gj5fnsjx5b5vp3@jpoimboe>
References: <20241122045005.14617-1-yangtiezhu@loongson.cn>
 <20241122045005.14617-4-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241122045005.14617-4-yangtiezhu@loongson.cn>

On Fri, Nov 22, 2024 at 12:49:58PM +0800, Tiezhu Yang wrote:
> @@ -2107,8 +2112,15 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
>  		if (reloc != table && reloc == next_table)
>  			break;
>  
> +		/* Handle the special cases compiled with Clang on LoongArch */

This comment is not helpful at all.  A comment is only needed if the
code is not already obvious.  In that case it should describe what is
being done and why.

> +		if (file->elf->ehdr.e_machine == EM_LOONGARCH &&
> +		    reloc_type(reloc) == R_LARCH_32_PCREL)
> +			rodata_entry_size = 4;
> +		else
> +			rodata_entry_size = 8;

Is this really loongarch-specific or is it only related to the size of
the reloc?  Can this be abstracted out to a reloc_size() function like
so?

  https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/tree/tools/objtool/klp-diff.c?h=objtool-diff#n834

maybe it could live in elf.h.

-- 
Josh

