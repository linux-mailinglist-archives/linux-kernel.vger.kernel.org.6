Return-Path: <linux-kernel+bounces-431370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D879E3C78
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CED2283356
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740781F7096;
	Wed,  4 Dec 2024 14:16:51 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53CC14A8B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321811; cv=none; b=q9x1gXIjCM9okGMR4f8Q1pBY6pA2+u4smOIjOW7HRqxunFiBkPIxQKEu2GXzYr7EhksMl35BMe3oQw6YwbcalAW5zTEOCM3dJm4iX5PApphmTTtsH4bRA78ckZFGnYB7k252TASIUZYSkJEE5NWk3pNxB+PChUR7RVT/1pe1HSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321811; c=relaxed/simple;
	bh=zjfTQ13HAS3fU4Rdw/ZS86Wh71qYaeqDmuQiS+jO2fU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bC+seUv2ekqC1GbeeJDAjGx3F9H49AziDiRXZUAqjc70iWQ+l8E74KDIUG3VkBVrmvoAhUUpmbDwk20rYRpuu4eAytDKFoeFFSVquEZZDytM7WCsPulL5HW+3u1KFw7PgPHc+AfZKBCRud/Bur4OpHGzq2+8yAPYFF5c0p/LO24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 4B4E9ZrU015093;
	Wed, 4 Dec 2024 08:09:35 -0600
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 4B4E9YNa015085;
	Wed, 4 Dec 2024 08:09:34 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Wed, 4 Dec 2024 08:09:33 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 2/4] objtool/powerpc: Add support for decoding all types of uncond branches
Message-ID: <20241204140933.GV29862@gate.crashing.org>
References: <cover.1733245362.git.christophe.leroy@csgroup.eu> <0ca71a4b0ac679ea52bd9fdd1f607195d72b499f.1733245362.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ca71a4b0ac679ea52bd9fdd1f607195d72b499f.1733245362.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.4.2.3i

On Tue, Dec 03, 2024 at 08:44:50PM +0100, Christophe Leroy wrote:
> Add support for 'bla' instruction.
> 
> This is done by 'flagging' the address as an absolute address so that
> arch_jump_destination() can calculate it as expected. Because code is
> _always_ 4 bytes aligned, use bit 30 as flag.

The AA field already is there, so why not, eh :-)

> Also add support for 'b' and 'ba' instructions. Objtool call them jumps.

> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Segher Boessenkool <segher@kewrnel.crashing.org>

> --- a/tools/objtool/arch/powerpc/decode.c
> +++ b/tools/objtool/arch/powerpc/decode.c
> @@ -55,12 +55,15 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
>  
>  	switch (opcode) {
>  	case 18: /* b[l][a] */
> -		if ((ins & 3) == 1) /* bl */
> +		if (ins & 1)	/* bl[a] */
>  			typ = INSN_CALL;
> +		else		/* b[a] */
> +			typ = INSN_JUMP_UNCONDITIONAL;
>  
>  		imm = ins & 0x3fffffc;
>  		if (imm & 0x2000000)
>  			imm -= 0x4000000;
> +		imm |= ins & 2;	/* AA flag */

You could of course put that together with the 3fffffc thing, but you
can leave that to the compiler as well :-)


Segher

