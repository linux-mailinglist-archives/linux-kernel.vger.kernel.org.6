Return-Path: <linux-kernel+bounces-563950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B91A64B14
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2B223B10FF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940AF236A84;
	Mon, 17 Mar 2025 10:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JUBzfXes";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RsoP0sTd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JUBzfXes";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RsoP0sTd"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E52B23644D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208417; cv=none; b=uzhb/Rq82U0YXMCYIg0tEeYCA3Ez0wSbXa96NPYaHlFeRuoQXMfS6MFxH9+Nk/7FemLfR0O+DVinIwLOd2J6F08zjatdc8bclwJSrmFGoSt1Zg4/iy9iqyB0SMiRFQLgoWbGGtx+i9upx36Sk1SpnHWDus6a1HtMesSHplPCeWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208417; c=relaxed/simple;
	bh=/jrOmL/K83nlDGJfp0Db7FJSFJf1ozykVQfclRetGxc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WQocmAWiKr/pQdpSBIjIs9/4vUgqGRRUoLXLSwA8Ic2qfbrTpwrVXQ9jdDW2HIlOCmthRhIHl+ABw5zRD0pAWC5y8mqSHfFufT/ydxc1wd3pgGIIIZ1WCHa2p3x/EEFvbWeI2HYwfnSSAAASRB9vwIHliqrYFeYVviqtgUR0+ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JUBzfXes; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RsoP0sTd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JUBzfXes; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RsoP0sTd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from pobox.suse.cz (unknown [10.100.2.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A050321EE8;
	Mon, 17 Mar 2025 10:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742208413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aRNUV7K56esT5Ofb17Nf3SuYMTDDFHCFe2TbYCH/MuY=;
	b=JUBzfXesd3VM7xBkJlAtx2wkA/5Z6Hu0hNNxPwfW7gcdP1ubxgfDzbNvqX0wJL/ESdSVcN
	+12Et3fAvyMaHgGSeROB1XDJzfbYAMNfKYrZsBXXAIo5zpbyO0n1SVq1MMorblkehCho53
	skEV5FcLQfN7LG95qSXU3rBa4Zhhiz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742208413;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aRNUV7K56esT5Ofb17Nf3SuYMTDDFHCFe2TbYCH/MuY=;
	b=RsoP0sTdsZaR2xBN3Eeo3lzFMWh26IpRutnKw5DiGUBZQkYj74wSqyXOExmfeNu0WQYaW+
	HjIM2qLCA4WMJYBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742208413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aRNUV7K56esT5Ofb17Nf3SuYMTDDFHCFe2TbYCH/MuY=;
	b=JUBzfXesd3VM7xBkJlAtx2wkA/5Z6Hu0hNNxPwfW7gcdP1ubxgfDzbNvqX0wJL/ESdSVcN
	+12Et3fAvyMaHgGSeROB1XDJzfbYAMNfKYrZsBXXAIo5zpbyO0n1SVq1MMorblkehCho53
	skEV5FcLQfN7LG95qSXU3rBa4Zhhiz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742208413;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aRNUV7K56esT5Ofb17Nf3SuYMTDDFHCFe2TbYCH/MuY=;
	b=RsoP0sTdsZaR2xBN3Eeo3lzFMWh26IpRutnKw5DiGUBZQkYj74wSqyXOExmfeNu0WQYaW+
	HjIM2qLCA4WMJYBA==
Date: Mon, 17 Mar 2025 11:46:53 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@kernel.org>
cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
    Peter Zijlstra <peterz@infradead.org>, 
    Brendan Jackman <jackmanb@google.com>, 
    Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 04/13] objtool: Update documentation
In-Reply-To: <2552ee8b48631127bf269359647a7389edf5f002.1741975349.git.jpoimboe@kernel.org>
Message-ID: <alpine.LSU.2.21.2503171143290.4236@pobox.suse.cz>
References: <cover.1741975349.git.jpoimboe@kernel.org> <2552ee8b48631127bf269359647a7389edf5f002.1741975349.git.jpoimboe@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.978];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Flag: NO
X-Spam-Level: 

Hi,

>  1. Each callable function must be annotated as such with the ELF
>     function type.  In asm code, this is typically done using the
> -   ENTRY/ENDPROC macros.  If objtool finds a return instruction
> +   SYM_FUNC_{START,END} macros.  If objtool finds a return instruction
>     outside of a function, it flags an error since that usually indicates
>     callable code which should be annotated accordingly.

there is one more occurrence of ENDPROC/END under "1. file.o: warning: 
objtool: func()+0x128: call without frame pointer save/setup" section 
which might be nice to update as well.

> @@ -339,23 +351,21 @@ the objtool maintainers.
>  
>     This is a kernel entry/exit instruction like sysenter or iret.  Such
>     instructions aren't allowed in a callable function, and are most
> -   likely part of the kernel entry code.  They should usually not have
> -   the callable function annotation (ENDPROC) and should always be
> -   annotated with the unwind hint macros in asm/unwind_hints.h.
> +   likely part of the kernel entry code.  Such code should probably be
> +   placed in a SYM_FUNC_CODE block with unwind hints.

SYM_CODE_{START,END} block?

>  7. file: warning: objtool: func()+0x5c: stack state mismatch
> @@ -371,8 +381,8 @@ the objtool maintainers.
>  
>     Another possibility is that the code has some asm or inline asm which
>     does some unusual things to the stack or the frame pointer.  In such
> -   cases it's probably appropriate to use the unwind hint macros in
> -   asm/unwind_hints.h.
> +   cases it's probably appropriate to use SYM_FUNC_CODE with unwind
> +   hints.

dtto

Miroslav

