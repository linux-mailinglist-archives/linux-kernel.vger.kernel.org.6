Return-Path: <linux-kernel+bounces-197284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFA18D68BC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 20:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 265011C21F51
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896B317C7B2;
	Fri, 31 May 2024 18:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZPvdsPem"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E895F7BB01
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 18:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717178961; cv=none; b=RP7fnCr788bXXFWV5CH9KKwhont4C3GUeGdrgPxDeDIp2vvtjYnnlADz4kqpur8q6ESO76+QWgLXXgXiIkxl1PNCMZMDptmcy9Ipb1Jo2KRb3+K4G/9mJqTtwgowbT8rsZrwgaZXZlSYU2mvcFJPaq5qBuocV0sSXYxR2C2ar1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717178961; c=relaxed/simple;
	bh=VHiIPCuoa5EL7gZuqB1esPlDNysxs2fgLHDuYQMVg/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgfYg7YQaO+tOORGWTMyuauBEiBYsZFyF/4F9sQSXyB1U+2hUjhclFVOazF20N1/qNRA6bmnduCYfbUuyG0V++XNRUOJgZvJn0yjlJsOSzPCceC/hZqymTJIADH592FCGZxkOXuFGfSfaSDzva8+l5Tb36Hw9OtYIV3X2pUSdvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZPvdsPem; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C844840E02B7;
	Fri, 31 May 2024 18:09:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aNypjB9DdzFc; Fri, 31 May 2024 18:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717178954; bh=J4DABAwt9coRNe7HDAtpj5tKME6dpO4QUrZcyz3DXg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZPvdsPempdOH0eAePPcF9ueKJllAYwHqEpQ8w9cEOAkDdbF/a8PPIRt4cFYNsUNxd
	 khQgxVYHc28S7J4XlE51Nmul9ogQKLN5ZbxnF4LgCaqcdVjdE9+1TmQk75e9ro6wUM
	 1P7lA4yLOFFq0ADzc/yFKZHoO+KChXXZsvuTforuZ890M7113cFGhm6FU6s/wIdgXx
	 8OQmc27Lki8POrwu8LVJko5UkdjORML3SFpr/oLP9lB6dIC6dH8nKTwGJW8kpiP4dT
	 4F9FQTvINzXHqSSTBbHHvfshWkqdjVRK4xjnHaLZXC7/DmSlMdB0DnJO09uU14bALp
	 J1S9XmuTMRB7qyigOU3Rc7iN/qD+MvKcuUvmtWgf6mExQunTnnXSad0NsmVihjHRgc
	 ia5JrFp75z7cF472Rsy0Uj70MWSI+pCV1+klMOFbJuy3jBu1VArQnOA96nwJXUV8gB
	 IjB8p+sCrOxBfRvOKRmjnDxI4+abkUXu85g2D3wKVzTLc8PBS1HYHj6FEVlrjNK+eP
	 Baq/IdPeh7ksd13VNRPjAIVN+zrEqdTh/8EqQDLKMCO3CnxPkAxPcD/N3dSsljVxOY
	 2ejifBJgEW3LAYKngZxRWB0fnYFLtFGQEUUuYY/BeUde8y/4k1OzZIVXODtgIMRwnp
	 Cy96aJrA5qiDCqAkXf2EvHkk=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 86C8740E02B2;
	Fri, 31 May 2024 18:09:09 +0000 (UTC)
Date: Fri, 31 May 2024 20:09:08 +0200
From: Borislav Petkov <bp@alien8.de>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Borislav Petkov <bp@kernel.org>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 02/14] x86/alternatives: Add nested alternatives macros
Message-ID: <20240531180908.GJZloSRENyzcJzW8bv@fat_crate.local>
References: <20240531123512.21427-1-bp@kernel.org>
 <20240531123512.21427-3-bp@kernel.org>
 <3a86f790-3194-4ea0-de8d-0af231ec7525@gmail.com>
 <20240531143625.GHZlngaQfx6CiJlujI@fat_crate.local>
 <d3969a10-7cd2-3dfb-2e49-37ebad2d6440@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d3969a10-7cd2-3dfb-2e49-37ebad2d6440@gmail.com>

On Fri, May 31, 2024 at 05:10:08PM +0200, Uros Bizjak wrote:
> The intention of '%P' operand modifier is primarily to be used with PIC,
> where ...

Ok, I'll fold in the following. I'd like to have this documented
somewhere in the tree too.

Thx.

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index f02867092a49..4973edbe9289 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -236,9 +236,18 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	asm_inline volatile(ALTERNATIVE(oldinstr, newinstr, ft_flags)	\
 		: output : "i" (0), ## input)
 
-/* Like alternative_io, but for replacing a direct call with another one. */
+/*
+ * Like alternative_io, but for replacing a direct call with another one.
+ *
+ * Use the %c operand modifier which is the generic way to print a bare
+ * constant expression with all syntax-specific punctuation omitted. %P
+ * is the x86-specific variant which can handle constants too, for
+ * historical reasons, but it should be used primarily for PIC
+ * references: i.e., if used for a function, it would add the PLT
+ * suffix.
+ */
 #define alternative_call(oldfunc, newfunc, ft_flags, output, input...)	\
-	asm_inline volatile(ALTERNATIVE("call %P[old]", "call %P[new]", ft_flags) \
+	asm_inline volatile(ALTERNATIVE("call %c[old]", "call %c[new]", ft_flags) \
 		: output : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
 
 /*
@@ -249,8 +258,8 @@ static inline int alternatives_text_reserved(void *start, void *end)
  */
 #define alternative_call_2(oldfunc, newfunc1, ft_flags1, newfunc2, ft_flags2,		\
 			   output, input...)						\
-	asm_inline volatile(ALTERNATIVE_2("call %P[old]", "call %P[new1]", ft_flags1,	\
-		"call %P[new2]", ft_flags2)						\
+	asm_inline volatile(ALTERNATIVE_2("call %c[old]", "call %c[new1]", ft_flags1,	\
+		"call %c[new2]", ft_flags2)						\
 		: output, ASM_CALL_CONSTRAINT						\
 		: [old] "i" (oldfunc), [new1] "i" (newfunc1),				\
 		  [new2] "i" (newfunc2), ## input)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

