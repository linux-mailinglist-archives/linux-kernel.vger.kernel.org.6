Return-Path: <linux-kernel+bounces-315598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D60C96C4A5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598EF1C21DE8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA3A8063C;
	Wed,  4 Sep 2024 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yjz9nw0f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAA7208B0
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 17:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725469347; cv=none; b=HMyYsjabCFEuxfQWB0OHfiRuK3ESqH3EXPY8qOvkU7+edwf9qkxSXQVtjc3GZwIC5R8uMfo4ZuXwy0mI7F+AkFN5j0WIgzMBAC/23RmIpT4QkOGHXgJOvUEMKlpDyVevRjKs5wsYQPyHJ/Ii+ktUhAoIP8BiZA4ExzLrrQSOEJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725469347; c=relaxed/simple;
	bh=lD6ko6vhDjXQHQJASMGyGJlcVOXJoXvkEsEotM/VLKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ln48YrPuWu9yrGX8sre9ytSdm8yPmMnnjwMeAKdJh9ekkYHQK0+TMzX8WvwU/aKDu3ZEyT9uAzyFsi4jy5luTAZMXWMoLtC9LapBxoYwjGy2LjYopf8xM8qbcSVr2XfBpP1mORH72ZaISPDuxgPjk9YugyBwAEtELFEPDckq89s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yjz9nw0f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5C2C4CEC2;
	Wed,  4 Sep 2024 17:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725469347;
	bh=lD6ko6vhDjXQHQJASMGyGJlcVOXJoXvkEsEotM/VLKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yjz9nw0fbGn9dKhSVEwYPdbmYjTXbdRmdVfMKUaaSx0Fe9cPhVH7k5MsoIMAsaMRx
	 avKI7+8iH5bVX33dcanPOnIopFvnOGqmAvaFWO89GmYegfxvjuW8OIsGVBBXU7hX8D
	 pknpKcR0xOKHeDJE8b3dvtglENkK7vgub3FWw2P7TzvWFCWOxL/dAymtBVXVUa2CYW
	 KKM/EE/Tng3nhT3eTE7bjQCVf+xRDv3ArqYy37sWRsVOd8eF0vy/i/o0qVosHMh3Gi
	 B3lKHj2LIszjUSOpu21KDFNncDTEajFumAfQ+PiCSjZYhMQwwXrEDuQL7JFtmTyuht
	 ibgTMvx7+lq0Q==
Date: Wed, 4 Sep 2024 10:02:25 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/bugs: Fix handling when srso mitigation is disabled
Message-ID: <20240904170225.hoccrhqhinr724au@treble>
References: <20240904150711.193022-1-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240904150711.193022-1-david.kaplan@amd.com>

On Wed, Sep 04, 2024 at 10:07:11AM -0500, David Kaplan wrote:
> When the srso mitigation is disabled, either via mitigations=off or
> spec_rstack_overflow=off, SBPB should be used instead of IBPB if
> possible.  Additionally, move the check earlier in the function so no
> warning is printed about the lack of IBPB-enhancing microcode since the
> user has turned off the mitigation.
> 
> Signed-off-by: David Kaplan <david.kaplan@amd.com>
> ---
>  arch/x86/kernel/cpu/bugs.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 189840db2f8d..10d0775e7aa5 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -2557,10 +2557,9 @@ static void __init srso_select_mitigation(void)
>  {
>  	bool has_microcode = boot_cpu_has(X86_FEATURE_IBPB_BRTYPE);
>  
> -	if (cpu_mitigations_off())
> -		return;
> -
> -	if (!boot_cpu_has_bug(X86_BUG_SRSO)) {
> +	if (!boot_cpu_has_bug(X86_BUG_SRSO) ||
> +	     cpu_mitigations_off() ||
> +	     srso_cmd == SRSO_CMD_OFF) {

These last two lines should be properly indented by shifting left one
space:

	if (!boot_cpu_has_bug(X86_BUG_SRSO) ||
	    cpu_mitigations_off() ||
	    srso_cmd == SRSO_CMD_OFF) {

Otherwise,

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh

