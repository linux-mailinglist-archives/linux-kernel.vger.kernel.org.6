Return-Path: <linux-kernel+bounces-522063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8CEA3C55B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FED61668B6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22195213257;
	Wed, 19 Feb 2025 16:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hO/fYNcL"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC06212D97
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739983513; cv=none; b=diZ6/ess8bbwTI7dq72Txv3dVxmoVbODLZBSFEK6yIZoNYpo5yi4mfcBCIyTUqx/UX5xVKwWrq8kLpzN2CY7c9v51F9eiwntGcQVWHXJIvUcZv5WFgMAdPaiItezVlmaLpRbnJVX9ZOCUzBgknSFyC/Dwh/LXG5VqJt1vYdJe8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739983513; c=relaxed/simple;
	bh=T37NbaAF7IzasJvoO5ORV0aa90xcmGruDuAuuKIy12I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bV961roGk5gBOxzieWpSSYFTeUmSnpWm8KAesHoBCMFIkUnBlO5yBsbk0X3jwGWXWjqBUfbbMtLcTSKFzMapr7xE/dQ8zHHhXpzbm8HGp4PL3Aw5ZSmKRVy1x4NRQ66xZPYn5zF3rfKP+oWzdc+62Xx9II1VYHF3o/HKcXgchx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hO/fYNcL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ODvcDH24fSam582PCghNPA+AWdAcTxMFrVLoe1fR2dA=; b=hO/fYNcLuFk0fwQTfDvnbNsVdO
	+KHuWjNK7tM+XcdbacBSV7+zxp8blK2XJSnLdojJj5rx4sjmITon+V/XUoQ2xjBy1udLHw2URsj9n
	mlfAP9nXrHn5fvyl2eRiuw9uvHFIupAZ42SGM9Lpw+fJeoLpveR4VInWeySi2OL3TPzY8nG7dzDUR
	8btvk51S+AUg+WK3cuN2G4AN8zmw40X30jjrVpwLhf6DCVlyWJy9q79fyRNgcCvxWtLDr4TuFDRk+
	/8vS+zqBQi7gjNdvTeb5QXkEJC0s1YDzlN6Aq8hyG9I5MgmpBPwcyHd7FsZsXYruaARDUQiuRb3wQ
	FZZjjN+g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tknC5-00000006Xy2-4C6p;
	Wed, 19 Feb 2025 16:45:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 93519300783; Wed, 19 Feb 2025 17:45:05 +0100 (CET)
Date: Wed, 19 Feb 2025 17:45:05 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, samitolvanen@google.com, nathan@kernel.org,
	ojeda@kernel.org, kees@kernel.org, alexei.starovoitov@gmail.com,
	mhiramat@kernel.org, jmill@asu.edu
Subject: Re: [PATCH v3 06/10] x86/traps: Decode LOCK Jcc.d8 #UD
Message-ID: <20250219164505.GG34567@noisy.programming.kicks-ass.net>
References: <20250219162107.880673196@infradead.org>
 <20250219163514.928125334@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219163514.928125334@infradead.org>

On Wed, Feb 19, 2025 at 05:21:13PM +0100, Peter Zijlstra wrote:
> @@ -315,7 +334,8 @@ static noinstr bool handle_bug(struct pt
>  
>  	switch (ud_type) {
>  	case BUG_EA:
> -		if (handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
> +	case BUG_LOCK:
> +		if (handle_cfi_failure(ud_type, regs) == BUG_TRAP_TYPE_WARN) {
>  			if (regs->ip == addr)
>  				regs->ip += ud_len;
>  			handled = true;
> @@ -324,7 +344,7 @@ static noinstr bool handle_bug(struct pt
>  
>  	case BUG_UD2:
>  		if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
> -		    handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
> +		    handle_cfi_failure(ud_type, regs) == BUG_TRAP_TYPE_WARN) {
>  			if (regs->ip == addr)
>  				regs->ip += ud_len;
>  			handled = true;
> 

Damn, that ud_type change belongs to the next patch. Consider it fixed.

