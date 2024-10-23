Return-Path: <linux-kernel+bounces-377941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 802309AC8D7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5EBFB22254
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C084A1AB50B;
	Wed, 23 Oct 2024 11:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="S/zg/5E9"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7D71AA79A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 11:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729682564; cv=none; b=fnG9RlwY28oCex5d/vCXDhoVTDBJsW6H9mzsJvztUD/VlAePqctR2mLchQbhDvpnTks3SbsWP9G8lv0+V8nDsHY8QE276mWhLUWfnWZ6/R1vzESzdb8nZ8w9SlyCMPF4JDNskYQvOaClF4moz6ALh9BCW1v8Pkh0SBJpJ7AUwHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729682564; c=relaxed/simple;
	bh=ZlXZrgpmPonMTZxjqpW/HzrGrXG/3TBTwRjVBLaCIUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwBVnUpgp1p1EVQG8BAS7BAn3tc+jtR0MbjMgKHYkwoyQMzZHJpgodI3FTjmz3BBz/A7nd4rKGveE/XYMDO7TKYFwjbxgtakeeqakBkbztggj+ldjQKf0n4ABfXR2GoHiPVuBlJ1BeN5P8zixmRoRzINPLyuEGne+iN9mXTSBlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=S/zg/5E9; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CAAD940E0284;
	Wed, 23 Oct 2024 11:22:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UjHIN2wLaUUN; Wed, 23 Oct 2024 11:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729682549; bh=Qpz0ZecBYlpZoY3QF6SyOPCR8sU1yVuNvPJLUhcE9Gc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S/zg/5E9aHA0aSIV9ojCLgW30Rro7v4Wd3MyU2jUNMPYk2fpbalXM77ppNO+LmZuJ
	 v3mv422VrrqKAfAMQ3WUIxCagaW6HB6NTKjkajJDpD82YOWgRE5VCWHgCyuBpgkAzb
	 KxAWYLZafnbaEZ2u28l85rwmQaE06NUmZBWc6JT7KZm3HFxQw/qL0TO7tN5Le3tcLP
	 xd9fgo/LgYbAhZPcmMKpbD546FIWf5pboVdbbZQiIk9SkBcdYqdHnmUd6dC1R0wzRp
	 fEiwEFCp1ChsoGAnfHq/BkgtrCvzh9MoKnj8y5q57eSILG2QOkDChANO1+9AYWQoZ4
	 SJWh9SwzQAdAfDzVPC9HpK9H2XWlvUTL/i17GFUKwqrRa3CWp2VbScIRUVwBie4Nvx
	 qL0umBUBgkKH0VrN7apvvs18bFHT0acVdQKo1W/L3e4mvmxMkFTcAz9JfSwJxyoVKQ
	 1lMlOXEf2MLGrK58DgYGMtKz2qGyaQVWvCkv/0VgPNXpa7sS+1EQQ1XaMurvm38vWH
	 q544r6e1qjUu4WjJ4tBxzva1Dv999imFv11huJwudPlKkwaJ7DRvJa3NF2nL1VhqK8
	 rIri3tBk4D5IgtopMarev3Ybe/my8pfX1ljIW0zgdyPP1gDcePzy1jqyYB6xy4bvps
	 b83+dKxi0t/7ii/74HuiByhA=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9189440E015F;
	Wed, 23 Oct 2024 11:22:24 +0000 (UTC)
Date: Wed, 23 Oct 2024 13:22:17 +0200
From: Borislav Petkov <bp@alien8.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: david.kaplan@amd.com, jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [RFC][PATCH 1/2] x86: Provide assembly __bug_table helpers
Message-ID: <20241023112217.GJZxjcaV8rBmuPGJnE@fat_crate.local>
References: <20241007083210.043925135@infradead.org>
 <20241007083844.013379820@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241007083844.013379820@infradead.org>

On Mon, Oct 07, 2024 at 10:32:11AM +0200, Peter Zijlstra wrote:
> +#define ASM_BUGTABLE_FLAGS(at, file, line, flags)			\
> +	.pushsection __bug_table, "aw" ;				\
> +	123:	ASM_BUG_REL(at) ;					\
> +	ASM_BUGTABLE_VERBOSE(file, line) ;				\
> +	.word	flags ;							\
> +	.org 123b + 6 + ASM_BUGTABLE_VERBOSE_SIZE ;			\

I'm guessing this second 6 is the sizeof(long + word) of the second two?

I.e., in here:

asm __inline volatile("1:\t" ".byte 0x0f, 0x0b" "\n"
		      ".pushsection __bug_table, \"aw\" ;
		       123:
		       		.long 1b - . ;
				.long %c0 - . ;
				^^^^^^^^^^^^^
				.word %c1 ;
				.word %c2 ;
				^^^^^^^^^^


				.org 123b + 6 + 6 ;
			.popsection" "\n" ""

Can we add a define for it too instead of a naked 6?

> +	.popsection
>  
>  #define _BUG_FLAGS(ins, flags, extra)					\
>  do {									\
>  	asm_inline volatile("1:\t" ins "\n"				\

s/ins/insn/ while at it.

The usual abbreviation for an "instruction".

> -		     ".pushsection __bug_table,\"aw\"\n"		\
> -		     "2:\t" __BUG_REL(1b) "\t# bug_entry::bug_addr\n"	\
> -		     "\t.word %c0"        "\t# bug_entry::flags\n"	\
> -		     "\t.org 2b+%c1\n"					\
> -		     ".popsection\n"					\
> -		     extra						\
> -		     : : "i" (flags),					\
> -			 "i" (sizeof(struct bug_entry)));		\
> +	    __stringify(ASM_BUGTABLE_FLAGS(1b, %c0, %c1, %c2)) "\n"	\
> +			    extra					\
> +		     : : "i" (__FILE__), "i" (__LINE__),		\
> +			 "i" (flags));					\
>  } while (0)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

