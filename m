Return-Path: <linux-kernel+bounces-513742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E391FA34E1B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 664803A7E7B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61F4245AF8;
	Thu, 13 Feb 2025 18:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xg+CZmr+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F64245AE5;
	Thu, 13 Feb 2025 18:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739472851; cv=none; b=dPdfwpDPGwxw2Zcp6lFDLTE/jJqq1U/bjn34Bh7qEgWuFfJp/5vrLHpD1mI3qIq+qmC0rEWYaVYQB2n+mOOj35VW/C5M0SSfIumzjz63M4cXiD9qwTpnybda/AY59d/YbxwxGMETTiTiXaXfck815qKekI2GS2LeXSnbthgENQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739472851; c=relaxed/simple;
	bh=sw1QM8YNVs4tKquw8ExNDS9lGNe7mqqrDLLegMYkS2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuDrXaSv/7By/d/lPkTZKkJtwQ2A+O56B1FWGtMj9sbocAcVh79KiuFain10ibO/3tr7Q2A5JTm9YV7SDzEXCAR7xQnHEDgLor8x1FHFNUKMw1NprfKfnqg789CQiMN2h1vNwm97ghKvckJ00jpH87eIL+6LzRCR3lUnvZcw25U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xg+CZmr+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6A0C4CED1;
	Thu, 13 Feb 2025 18:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739472850;
	bh=sw1QM8YNVs4tKquw8ExNDS9lGNe7mqqrDLLegMYkS2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xg+CZmr+kXKcUJnO2R5sjJI5xdtczkUza1MbIPMJHJ4CJqxpamFczCqjZHiyc3SKB
	 P2k2i6SefDTEmk9in2O7Lv+9owltMrZ1iBWsGSopk+uBCCYlz80Ctdhv9tqiTMdJsZ
	 lY70RAfCsC/nef0Lby33mb+z26G4KMhaipsobmHt0tMFgpBGgdxpkCTZUPTvLRR+FU
	 3hUTxkXYa0NnmHt8AElAGmBgBdLWDbN4H+84+8WcNY6wHleHgPIUIUwW+68mrUxPVo
	 C8Dj2Dz0VZvpR2sglVNtqxhwuCC6pFzTSAAMi8LG4dp3KubBwjXnOBisL/6JwwkO0S
	 iY2e9ApNK8ZoA==
Date: Thu, 13 Feb 2025 10:54:08 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
	llvm@lists.linux.dev
Subject: Re: [PATCH] compiler.h: Specify correct attribute for
 .rodata..c_jump_table
Message-ID: <20250213185408.m5aogf2trvhvi2td@jpoimboe>
References: <20240924062710.1243-1-yangtiezhu@loongson.cn>
 <20250212175023.rsxsw7pno57gsxps@jpoimboe>
 <b1e5e3ea-be4b-5dae-cc0d-34693429d060@loongson.cn>
 <20250213023936.lzbpgou4eallaij3@jpoimboe>
 <045d7e22-672c-b9da-38d6-8897e854f262@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <045d7e22-672c-b9da-38d6-8897e854f262@loongson.cn>

On Thu, Feb 13, 2025 at 08:38:22PM +0800, Tiezhu Yang wrote:
> Based on the above analysis, in order to avoid changing the behavior of
> GNU assembler and silence the GNU assembler warning, is it possible to
> rename ".rodata..c_jump_table" to ".c_jump_table"?

Yeah, though for the final vmlinux link we'd still need it to end up in
.rodata so it remains read-only at runtime.

So we'd basically just have to add it to the RO_DATA() macro in
include/asm-generic/vmlinux.lds.h.

Does it still work if we call it ..rodata.c_jump_table or so?  Then we
could just add "*(..rodata.*) to RO_DATA().  That would be somewhat less
surprising, and would also create a standard way for other code to do
the same thing by prefixing with "..rodata.".

-- 
Josh

