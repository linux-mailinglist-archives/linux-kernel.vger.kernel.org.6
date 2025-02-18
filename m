Return-Path: <linux-kernel+bounces-518770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFA9A3942D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 738DA7A133B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 07:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0B61FF1AA;
	Tue, 18 Feb 2025 07:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PPsDCYXe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5g5XYrVZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PPsDCYXe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5g5XYrVZ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FA91DBB37
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 07:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739865248; cv=none; b=LkCGxOdBn9ZARpkUm7onU0qDUGb//bjY/uTDcyzR2wDqxebeGHGlls2Wt746d7GiiHrea9tzs4zgZm+1OIyZkoehYru707TqEGZgETRvRc/d4rgK1VzOICK5miTBzjGrG1oAbU6RGv0FKYXD5nOZzUo6rJg+9tPvAP+L37knVLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739865248; c=relaxed/simple;
	bh=Vkk6AGzyABeTN27FoNfk4tOS0rUlOcfUXzCFf34W0Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUDA87XIwNWuq28sYtpi2SJBqYLoMSjMInuptQ3HaOpvt28YcH5A1CtRgqNl0dc91GaODWoM9jU7OTUIsn3g/+YGFtjF6vt18aoVq9Wv9YJfL5uR2I3siMqk02JdvmQIYk7WKwbuZSRa6KJyC+jomxTd+iKvGlVSRVrCLjX+Cgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PPsDCYXe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5g5XYrVZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PPsDCYXe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5g5XYrVZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5E54F21160;
	Tue, 18 Feb 2025 07:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739865244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d7bHl0ooLxFSzjEUZAaPsWHsj5Dt6Ubf1dAYLGBp6pQ=;
	b=PPsDCYXeUSsNDKWv4y90uj2vZdDSQrsaIyIPThIXp1rg3V4Exd1i7qTev+o9zh2uDCSJ66
	OelCcm5ItOHQqW1IapYXvbtpfA46V0ZDoTMSnoGLrSrJZfR8SaMoUG/ibs7IQnZ6CybUWk
	+5YCI3Ma2ojogyPhh6CWq/tnJhIbmlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739865244;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d7bHl0ooLxFSzjEUZAaPsWHsj5Dt6Ubf1dAYLGBp6pQ=;
	b=5g5XYrVZagb7mg9gJiByPE5IU70wlyqEirYOjDaQqamW7rkm5QbeURmiHU+wfAG3eXecAJ
	CjcMdlC6zmGgL4BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739865244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d7bHl0ooLxFSzjEUZAaPsWHsj5Dt6Ubf1dAYLGBp6pQ=;
	b=PPsDCYXeUSsNDKWv4y90uj2vZdDSQrsaIyIPThIXp1rg3V4Exd1i7qTev+o9zh2uDCSJ66
	OelCcm5ItOHQqW1IapYXvbtpfA46V0ZDoTMSnoGLrSrJZfR8SaMoUG/ibs7IQnZ6CybUWk
	+5YCI3Ma2ojogyPhh6CWq/tnJhIbmlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739865244;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d7bHl0ooLxFSzjEUZAaPsWHsj5Dt6Ubf1dAYLGBp6pQ=;
	b=5g5XYrVZagb7mg9gJiByPE5IU70wlyqEirYOjDaQqamW7rkm5QbeURmiHU+wfAG3eXecAJ
	CjcMdlC6zmGgL4BQ==
Date: Tue, 18 Feb 2025 08:54:03 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Segher Boessenkool <segher@kernel.crashing.org>,
	Vitaly Chikunov <vt@altlinux.org>,
	Abhishek Dubey <dubeyabhishek777@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH 1/1] powerpc: use __clang__ instead of CONFIG_CC_IS_CLANG
Message-ID: <Z7Q8m4131_7K44qn@kitsune.suse.cz>
References: <20250218044802.17302-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218044802.17302-1-shung-hsi.yu@suse.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,vger.kernel.org,ellerman.id.au,linux.ibm.com,gmail.com,csgroup.eu,kernel.org,google.com,kernel.crashing.org,altlinux.org,linux.dev];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,kitsune.suse.cz:helo,kitsune.suse.cz:mid]
X-Spam-Score: -8.30
X-Spam-Flag: NO

Hello,

how does this happen?

On Tue, Feb 18, 2025 at 12:48:01PM +0800, Shung-Hsi Yu wrote:
> Due to include chain (below), powerpc's asm-compat.h is part of UAPI,
> thus it should use the __clang__ macro to directly detect whether Clang
> is used rather then relying on the kernel config setting. The later is
> unreliable because the userspace tools that uses UAPI may be compile
> with a different compiler than the one used for the kernel, leading to
> incorrect constrain selection (see link for an example of such).
> 
>   include/uapi/linux/ptrace.h
>   arch/powerpc/include/asm/ptrace.h

There is arch/powerpc/include/uapi/asm/ptrace.h

and if the installed header is used this is what should be included.

That does no include other asm headers.

Thanks

Michal

>   arch/powerpc/include/asm/paca.h
>   arch/powerpc/include/asm/atomic.h
>   arch/powerpc/include/asm/asm-compat.h
> 
> Link: https://github.com/iovisor/bcc/issues/5172
> Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> ---
>  arch/powerpc/include/asm/asm-compat.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/asm-compat.h b/arch/powerpc/include/asm/asm-compat.h
> index f48e644900a2..34f8740909a9 100644
> --- a/arch/powerpc/include/asm/asm-compat.h
> +++ b/arch/powerpc/include/asm/asm-compat.h
> @@ -37,7 +37,7 @@
>  #define STDX_BE	stringify_in_c(stdbrx)
>  #endif
>  
> -#ifdef CONFIG_CC_IS_CLANG
> +#ifdef __clang__
>  #define DS_FORM_CONSTRAINT "Z<>"
>  #else
>  #define DS_FORM_CONSTRAINT "YZ<>"
> -- 
> 2.48.1
> 

