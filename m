Return-Path: <linux-kernel+bounces-542473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E9CA4CA5F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 844013BFDFD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF89D241CA5;
	Mon,  3 Mar 2025 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LC4GYNeC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C49923ED72
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022821; cv=none; b=jv4KTjopA2dvTKJG52OVjvcr+YPfzEMxXrMPKTwPFg9sOZP9dlvmSNfYHqFYKOPwDueaCkTucRljC858743QIL/qi+E7WRS2bdw53LCpn0AiwYAYWIgQZoN2KZkwV3cGkTHpE0SVSCumTn9jorO3x9HhRRF0I8Q0R2cWxwOYBU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022821; c=relaxed/simple;
	bh=PLpSOnjtrzgbcY+j7L3x4mfyzrRTPbrWAvjqUAmHMAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CaF69zIrjBry7ez80fqhRcH5HPEIWMB9WKAXpITQksLvYzI/28bSIMxp/OK/jMvKIRUGhwXyWCMDQ0l5fGLVaPEJuBXewUIm5icgUmhSMooAdpU9bGbuGiqT7W9l9YatybgPX1/ajrTNxZb1LkDMuwttkVJUjwqI14xEegnzgxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LC4GYNeC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1936C4CED6;
	Mon,  3 Mar 2025 17:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741022820;
	bh=PLpSOnjtrzgbcY+j7L3x4mfyzrRTPbrWAvjqUAmHMAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LC4GYNeCU9FmtbwBxkTqb5MsBCSArLwV5zVdQFq+Z49e/+EpfX0JABujyq4tyyQyg
	 KDc3yDC4TJT+GylqcfNpkJJwBv5dqQrgpHKUwsFtD9IxVsd2CkkYRMrmyDgtJ5+41G
	 bxzVReMG6M7zdmE7igGLBKwmn9MPLcmsvMcqdvQmiD64gnd4RuYYzXqIYUin8glWIz
	 CceJ65vNvOLL/Cd6LezDNKTpMrgTclFE4vTnTZOf7iyB7LdbGNXeV47sfU7edFDkFa
	 is82cMsezk+ia0g/6em6pu3/WKLwXVsObmK4BPjtXdGuinN8ms4bGuCVqiw+vQm7SC
	 ZYv+e2TcuTmJw==
Date: Mon, 3 Mar 2025 09:26:57 -0800
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: lkdtm: Annotate do_nothing()
Message-ID: <202503030921.2CD851B31D@keescook>
References: <20250303093817.GJ5880@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303093817.GJ5880@noisy.programming.kicks-ass.net>

On Mon, Mar 03, 2025 at 10:38:17AM +0100, Peter Zijlstra wrote:
> Hi Kees,
> 
> During my FineIBT testing the other week I stumbled upon the following
> complaint:
> 
>   vmlinux.o: warning: objtool: execute_location+0x4f: relocation to !ENDBR: .text+0x1032008
> 
> I finally got around to looking at it and realized we have means of
> annotating that since 93f16a1ab78c ("x86/boot: Mark start_secondary() with __noendbr")
> (which might still be in tip only).

Er, doesn't that mean do_nothing() will lack an ENDBR? Wait, no, that's
__noendbr. What does this annotation mean if the function _does_ have
ENDBR?

Note that these tests are explicitly using __nocfi (via the
execute_location() function) since they're testing the Execute bit in
different memory regions. But I would expect BTI to still work (and not
block execution).

-Kees

> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
> diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
> index 5b861dbff27e..9600af4494d8 100644
> --- a/drivers/misc/lkdtm/perms.c
> +++ b/drivers/misc/lkdtm/perms.c
> @@ -36,6 +36,7 @@ static noinline void do_nothing(void)
>  {
>  	return;
>  }
> +ANNOTATE_NOENDBR_SYM(do_nothing);
>  
>  /* Must immediately follow do_nothing for size calculuations to work out. */
>  static noinline void do_overwritten(void)

-- 
Kees Cook

