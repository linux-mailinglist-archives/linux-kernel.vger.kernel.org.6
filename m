Return-Path: <linux-kernel+bounces-553744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B59A58E5D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0025116603C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563C1224220;
	Mon, 10 Mar 2025 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CEsT3FM0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FJTg7RCm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CEsT3FM0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FJTg7RCm"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3733D22422D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741596047; cv=none; b=T1k36zwkECE+WE0cBmEZY180XTeDvlhWAyvdL07Ptjl55L3YbuxQL+NSXg6F+ak0GdL16G+7cMF6uv+juxaiLM9qzdWLjiATMVjsyk3BT89cIu95rrmzD88+DH0XvL28cXFf+4+1hYmp2t5MLwqkfco9db1pcggTvjyyGQyKdkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741596047; c=relaxed/simple;
	bh=7/4dvJM4xNGOtXUfjg/A92n29Hnc7theTI/+weQ2Ytc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqLIvKYcf/UreOAyAvQonPpoukGKvYRifVtdHdtL57ch7jKOaCtVdmelSeKHReYHUd63s9afmST6qLxPOM8cwtYRw6LrmtBZ8o6fLr/JH62Q0ZcHdg0E588fMd4V3ZkLYWWm/LEsXSHMDA9FG1Lih09n4MQHMfiwjwv3FF/V6ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CEsT3FM0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FJTg7RCm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CEsT3FM0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FJTg7RCm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 32B02210F3;
	Mon, 10 Mar 2025 08:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741596044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mTErlNHYltRpOX8C1wmUnBsAoRxLsP2r7CcqnO1N75E=;
	b=CEsT3FM0Za7//x1kKU0c5sW3deok+Be9FaWxLRqFBtEugUe3w/b9dMr1Yby6lvy0tjr+q9
	iGnJKEVdfalcF0uxLP/QpxDShGD+MTW1VArmWtZCp66XfhcCiPMo0jwplCIhfZabXCFxHR
	EskGy2I2Cnpb0g4vE+bQc5OqaNVSLPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741596044;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mTErlNHYltRpOX8C1wmUnBsAoRxLsP2r7CcqnO1N75E=;
	b=FJTg7RCm0Sd0oTuAHmR4U53BvFU59JBvHUi9N/EmilDwODzDuIZIZeV18DenRzbB9WVf5n
	6emD59HI9/9rRyAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741596044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mTErlNHYltRpOX8C1wmUnBsAoRxLsP2r7CcqnO1N75E=;
	b=CEsT3FM0Za7//x1kKU0c5sW3deok+Be9FaWxLRqFBtEugUe3w/b9dMr1Yby6lvy0tjr+q9
	iGnJKEVdfalcF0uxLP/QpxDShGD+MTW1VArmWtZCp66XfhcCiPMo0jwplCIhfZabXCFxHR
	EskGy2I2Cnpb0g4vE+bQc5OqaNVSLPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741596044;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mTErlNHYltRpOX8C1wmUnBsAoRxLsP2r7CcqnO1N75E=;
	b=FJTg7RCm0Sd0oTuAHmR4U53BvFU59JBvHUi9N/EmilDwODzDuIZIZeV18DenRzbB9WVf5n
	6emD59HI9/9rRyAg==
Date: Mon, 10 Mar 2025 09:40:43 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/boot: Fix build with gcc 15
Message-ID: <Z86liwlwP5WvrEkw@kitsune.suse.cz>
References: <20250307092055.21986-1-msuchanek@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307092055.21986-1-msuchanek@suse.de>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,ellerman.id.au,gmail.com,csgroup.eu,kernel.org,fjasle.eu,google.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Mar 07, 2025 at 10:20:52AM +0100, Michal Suchanek wrote:
> Similar to x86 the ppc boot code does not build with GCC 15.
> 
> Copy the fix from
> commit ee2ab467bddf ("x86/boot: Use '-std=gnu11' to fix build with GCC 15")
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  arch/powerpc/boot/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index 1ff6ad4f6cd2..e6b35699c049 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -33,6 +33,7 @@ else
>  endif
>  
>  ifdef CONFIG_PPC64_BOOT_WRAPPER
> +BOOTTARGETFLAGS	+= -std=gnu11

I suppose this should be above the ifdef, not below. I build only 64S
but I expect any other platforms that build boot code will be equally
affected.

Thanks

Michal

>  BOOTTARGETFLAGS	+= -m64
>  BOOTTARGETFLAGS	+= -mabi=elfv2
>  ifdef CONFIG_PPC64_ELF_ABI_V2
> -- 
> 2.47.1
> 

