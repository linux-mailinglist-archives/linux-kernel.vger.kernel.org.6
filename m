Return-Path: <linux-kernel+bounces-387859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E8B9B56F1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8721F20EFB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092E220B21B;
	Tue, 29 Oct 2024 23:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="ernYnpst"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BAB20B21A
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 23:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244567; cv=none; b=nAcHiMbNPABm5C/nhvK2UcWdnft6srTXPYtoM/6jeicFKRknC+cLwCwvLTavqFV4vEXaC1CEJDREFvSob0Ido5C1kTgVszO80jXArlFL0bFpkcLQklrzYMt3Q2LAX9TDimvV3Q1rhrBKc/Gp+OvL5Vl+5WNekRHyO6FmRWiJDbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244567; c=relaxed/simple;
	bh=l+CHx6Zt5Gtjhle42s10fH2cZjd4sQSWMIXNVifI/E4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aPrcR6EqNyGx4U9nXa3sjtW1PNGToLMl/Ss/LDW+myFGqZTtf/2VMGBo6W4Wz/QOiqlD3tU6vLP8QV9pxcWYGvofSEy9s+skvp09TYOMpr2KnIYBs7WzGJfS2UON4izEeIytQUz618imnwaLKhNjnkM7PsfphBx9Cuw6rrG3JH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=ernYnpst; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1730244554;
	bh=KNeYgmMAGPIyHDJl3QbZDwIGpEYDsMZZ+DjYHgkmPyo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ernYnpstgOY9FLJSuqniQzAK5V9UK8eyHKkWmNM4PA0t1dXeQPGjlTfwrDZyFezT6
	 iWLk7Uzn33TOfEKmxjdQLqISv24MCjpXIGy2CpU1pth39D9hnEAzGOR1gAdsl6rP/K
	 zfVpxz5QZOskQls+r7skNA9V5l4p2Gv5wBp0mvqWANGsMluS/LAP5XojKbgbXF4aOb
	 Q3amzWjyJMHnLbjz0bxLDWaNzBwtFXJifVzYyo8thrdKZoeWAumsu4z0RGhHObz615
	 M+KLPFUVKK99SbzPqtWEQ96785m4MMf33J465wGEiVwzPkpht0lGYnXXrop/PAJYlC
	 BlDqr1AK0lwvQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XdRKc4hCzz4wbR;
	Wed, 30 Oct 2024 10:29:08 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Nysal Jan K.A." <nysal@linux.ibm.com>, Andrew Morton
 <akpm@linux-foundation.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>, Stephen Rothwell
 <sfr@canb.auug.org.au>, Peter Zijlstra <peterz@infradead.org>,
 linuxppc-dev@lists.ozlabs.org, "Nysal Jan K.A." <nysal@linux.ibm.com>,
 Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
 <justinstitt@google.com>, Vlastimil Babka <vbabka@suse.cz>, "Liam R.
 Howlett" <Liam.Howlett@Oracle.com>, Mark Brown <broonie@kernel.org>,
 Michal Hocko <mhocko@suse.com>, Kent Overstreet
 <kent.overstreet@linux.dev>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2] sched/membarrier: Fix redundant load of
 membarrier_state
In-Reply-To: <20241029055133.121418-1-nysal@linux.ibm.com>
References: <20241007053936.833392-1-nysal@linux.ibm.com>
 <20241029055133.121418-1-nysal@linux.ibm.com>
Date: Wed, 30 Oct 2024 10:29:09 +1100
Message-ID: <87ed3yebei.fsf@mpe.ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Nysal Jan K.A." <nysal@linux.ibm.com> writes:
> On architectures where ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
> is not selected, sync_core_before_usermode() is a no-op.
> In membarrier_mm_sync_core_before_usermode() the compiler does not
> eliminate redundant branches and load of mm->membarrier_state
> for this case as the atomic_read() cannot be optimized away.
>
> Here's a snippet of the code generated for finish_task_switch() on powerpc
> prior to this change:
>
> 1b786c:   ld      r26,2624(r30)   # mm = rq->prev_mm;
> .......
> 1b78c8:   cmpdi   cr7,r26,0
> 1b78cc:   beq     cr7,1b78e4 <finish_task_switch+0xd0>
> 1b78d0:   ld      r9,2312(r13)    # current
> 1b78d4:   ld      r9,1888(r9)     # current->mm
> 1b78d8:   cmpd    cr7,r26,r9
> 1b78dc:   beq     cr7,1b7a70 <finish_task_switch+0x25c>
> 1b78e0:   hwsync
> 1b78e4:   cmplwi  cr7,r27,128
> .......
> 1b7a70:   lwz     r9,176(r26)     # atomic_read(&mm->membarrier_state)
> 1b7a74:   b       1b78e0 <finish_task_switch+0xcc>

Reviewed-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

