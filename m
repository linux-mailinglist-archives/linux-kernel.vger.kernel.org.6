Return-Path: <linux-kernel+bounces-238953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 914599253D7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 08:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB7851C22A9E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF9513247D;
	Wed,  3 Jul 2024 06:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfiX9YJ3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654F313210B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 06:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719989012; cv=none; b=medfwsBeeJ6/P1fhfzLi4qE6OqL6HH8VozJZasZzMt0UPihkquX2uXWU5sulGkNihdEooFboS6pq/oCBl8X6GqVM7azmcs6TN6eabn1zVYE6LJI9dytyR6aCOerhJTlqg9Mgw9lKdlt8cZM2n14OJsYRLTlOcXoPpWn52dWr+hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719989012; c=relaxed/simple;
	bh=3T3NL6Jw0xKDC3op4Bn/3VwCiSfDAljus4ZvG5+gv3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUSbmHqskjgvGjw3lYhof50Zmn1KfsGwRajvsyq4nEQ9oEwX4tfmAohapHM3k6Ge8GQF6WDdOnYkAX33rNSAfZ0m/N0irOQyJa0aJITuXBX4BZ0TvEFIXPdXMoEhc8NOUWLe2K4Cm8nlXJSvmFOjQZsAo2Z9Jb6aec4NzSJqkY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfiX9YJ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1852EC32781;
	Wed,  3 Jul 2024 06:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719989012;
	bh=3T3NL6Jw0xKDC3op4Bn/3VwCiSfDAljus4ZvG5+gv3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jfiX9YJ3lpzIIFbL/sPupsGYVine/8yYMOxE7NWuVcgQm3YEaBZccwZFHPntXrsmC
	 dio1GBo/JbPTX79le5l2Uz5DabDuQTXpJ0FxeB/UXB5vkiGA/bmusmWp9f6b7x1wTX
	 Eg9tUA9EEfNfCbbfxL78wJc1afhlQcnl1Hka7fn2E4Maof0xgWThU8MLbjYhYUTklO
	 Is7qGuhIblfx4RQDEIOIP7MNMoTBjWLqbikExnfqijeqB8PuoizAFkYIfMwOC0VzIe
	 tvfL9klLhqDOHLqwJ0PanQNXZWE2GZVPaELYuP1byO4y8fsBlMWMSIUeJvqajWdkfN
	 /cAhwVZcNaakQ==
Date: Tue, 2 Jul 2024 23:43:30 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: Re: [PATCH V2 RESEND] objtool/x86: objtool can confuse memory and
 stack access
Message-ID: <20240703064330.ry3r7nuvhpoyg2vt@treble>
References: <20240620144747.2524805-1-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240620144747.2524805-1-alexandre.chartre@oracle.com>

On Thu, Jun 20, 2024 at 04:47:47PM +0200, Alexandre Chartre wrote:
> The encoding of an x86 instruction can include a ModR/M and a SIB
> (Scale-Index-Base) byte to describe the addressing mode of the
> instruction.
> 
> objtool processes all addressing mode with a SIB base of 5 as having
> %rbp as the base register. However, a SIB base of 5 means that the
> effective address has either no base (if ModR/M mod is zero) or %rbp
> as the base (if ModR/M mod is 1 or 2). This can cause objtool to confuse
> an absolute address access with a stack operation.
> 
> For example, objtool will see the following instruction:
> 
>  4c 8b 24 25 e0 ff ff    mov    0xffffffffffffffe0,%r12
> 
> as a stack operation (i.e. similar to: mov -0x20(%rbp), %r12).
> 
> [Note that this kind of weird absolute address access is added by the
>  compiler when using KASAN.]
> 
> If this perceived stack operation happens to reference the location
> where %r12 was pushed on the stack then the objtool validation will
> think that %r12 is being restored and this can cause a stack state
> mismatch.
> 
> This kind behavior was seen on xfs code, after a minor change (convert
> kmem_alloc() to kmalloc()):
> 
> >> fs/xfs/xfs.o: warning: objtool: xfs_da_grow_inode_int+0x6c1: stack state mismatch: reg1[12]=-2-48 reg2[12]=-1+0
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202402220435.MGN0EV6l-lkp@intel.com/
> Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>

Thanks, queueing...

-- 
Josh

