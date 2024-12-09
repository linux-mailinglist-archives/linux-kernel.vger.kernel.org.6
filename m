Return-Path: <linux-kernel+bounces-438336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB61A9E9FDF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EBC716539E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 19:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3881991BE;
	Mon,  9 Dec 2024 19:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkTtXchX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221E01552E4;
	Mon,  9 Dec 2024 19:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733774056; cv=none; b=W/16Ldp541pVJ9fYVWdkzIKp8qBe9WFwqMikDVTfg1kPW2sF6Qup/s2W+l3ZGC7OjSUeHL/16Vi11crQkC7xxP/9n25+4vWg+ClecQaTwPYuU2/izIwwb1C9A9PZ+zjMeD72KmQDdh14mnM5wj230cCPNX9o763z9G1L7esiXj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733774056; c=relaxed/simple;
	bh=fgbbqawM4EJR/XyO57RHF4Fi4tx+D0F5MotyUS6QYCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U344uJZ/Uc5EmjRDUR9irUDJuka6o4T5YGW8yWKhrHxaDVlNeIUTQkwXXV2WXJB+LlSyBBrrvrF3033Is+YEnWoIVySYg2duzi+j96T56Wa+HLMxSsc6OwIxv36l9LV98NtVAz/XsLwIYZhcOZRVfWFt9HDm59wUbMiUrx/Tfts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkTtXchX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69848C4CED1;
	Mon,  9 Dec 2024 19:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733774055;
	bh=fgbbqawM4EJR/XyO57RHF4Fi4tx+D0F5MotyUS6QYCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fkTtXchXuCttCn6LljeeVCrx0+yihBD8/VPm1HaZYsrGFtT1VrXdKwbSQK9c88I/E
	 aKTCk46s/qIKfjiX1/Sura6sxJPLAYlJrmzVWs8ZdzwDGL5fHUw8kFVLe/A6yFHK4B
	 3ZVmndtzOHAY5PDMrzyp27anL7PbuTjOMZ9O3+3bkpPM6oGrMqziRdjtwXvhz5KV/z
	 DnYDG/07Ph+BUPntHd6i25+FgQ9lSB8V17RukS2YL8xgGzOrFNq1KZKNI+eKXP0liF
	 jeureKlfU4osZ6AdFXtaNEmDzbLWK6RQ0QbdnH3VU9/vFNgm+plVRRk3WtFOdCGLE/
	 JX4my71aElXfw==
Date: Mon, 9 Dec 2024 11:54:13 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/10] objtool: Handle different entry size of rodata
Message-ID: <20241209195413.gpq7t3nacsnx3xo3@jpoimboe>
References: <20241207015915.1159-1-yangtiezhu@loongson.cn>
 <20241207015915.1159-3-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241207015915.1159-3-yangtiezhu@loongson.cn>

On Sat, Dec 07, 2024 at 09:59:07AM +0800, Tiezhu Yang wrote:
> +__weak unsigned int arch_reloc_size(struct reloc *reloc)
> +{
> +	return 8;
> +}

Instead of making a weak function, each arch should have an explicit
definition of this function, as it's not always 8:

- x86 has R_X86_64_PC32 and R_X86_64_PLT32 which are 4 bytes.

- 32-bit powerpc

- 64-bit powerpc has R_PPC64_REL32

> @@ -1967,8 +1973,10 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
>  		if (reloc != table && reloc == next_table)
>  			break;
>  
> +		entry_size = arch_reloc_size(reloc);
> +
>  		/* Make sure the table entries are consecutive: */
> -		if (prev_offset && reloc_offset(reloc) != prev_offset + 8)
> +		if (prev_offset && reloc_offset(reloc) != prev_offset + entry_size)
>  			break;

No need to use a variable here, just call arch_reloc_size() directly.

-- 
Josh

