Return-Path: <linux-kernel+bounces-285429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1415950D61
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E503281818
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC501A3BD7;
	Tue, 13 Aug 2024 19:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="BBZbZ+Sz"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0C619A2AE
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 19:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723578540; cv=none; b=KRqm3OOCsLDGlamgjO766+4Ch9C3Go4ZjixBHGCz3wSvr1yR2krk+qExJRjlThA03agyFm+EJez75nVxip+hFIy2X31C8dc+m0oQjQFySuKc5EssSnVatNvsh0Rb8hbAx5rhkudUvjof5D0kE4+shfVu2HuvzNToe94IUW6QE9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723578540; c=relaxed/simple;
	bh=ujAzKhvz2m85q9OKAVeMysx4OHTHQ3MJssBelvEs0NY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SgrbdeewjnzPcSjQrqLtW1UMYDYIgG1hYOe9nH6D3cENW/vEfkyEur4QEwZI6lWBd7g0e6SUO3mvymF52qKzbxuDYAVN2ZoiFZ1S0Qjc1f3e2VmBLZRTocy5WB33Ubfi5mm+OE86CrphHfezniMIX0K4/gnAOMAnaMd/H6LbvCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=BBZbZ+Sz; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1723578071;
	bh=ujAzKhvz2m85q9OKAVeMysx4OHTHQ3MJssBelvEs0NY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=BBZbZ+SztijdgLY0TVQ4M0iRQlHQ6u/Nwv47FTIhHi+NOoipKuvuKsatk71urBcSe
	 wlzbeGoJLodwSmPqxRRmsq4vA/S9cf/zhRHMIQer3+HAuxE2We2FnUXCGm9zll7Cwb
	 rcw5wy29kaG9Va/LST1S0Ckm4qguoFdl2EQWk0e0=
Received: by gentwo.org (Postfix, from userid 1003)
	id 5B852400CA; Tue, 13 Aug 2024 12:41:11 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 5A5CD400C5;
	Tue, 13 Aug 2024 12:41:11 -0700 (PDT)
Date: Tue, 13 Aug 2024 12:41:11 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Waiman Long <longman@redhat.com>
cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
    Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Boqun Feng <boqun.feng@gmail.com>, 
    Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC] Avoid memory barrier in read_seqcount() through load
 acquire
In-Reply-To: <183ee6fa-1d42-4a01-8446-4f20942680d2@redhat.com>
Message-ID: <147572ea-c5ae-7992-6015-3181f10a785e@gentwo.org>
References: <20240813-seq_optimize-v1-1-84d57182e6a7@gentwo.org> <183ee6fa-1d42-4a01-8446-4f20942680d2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 13 Aug 2024, Waiman Long wrote:

> Do we need a new ARCH flag? I believe barrier APIs like smp_load_acquire() 
> will use the full barrier for those arch'es that don't define their own 
> smp_load_acquire().

Well this is a load acquire instruction. The fallback of smp_load_aquire 
is:

#define __smp_load_acquire(p)                                           \
({                                                                      \
         __unqual_scalar_typeof(*p) ___p1 = READ_ONCE(*p);               \
         compiletime_assert_atomic_type(*p);                             \
         __smp_mb();                                                     \
         (typeof(*p))___p1;                                              \
})

Looks like we have an acquire + barrier here.

> BTW, acquire/release can be considered memory barriers too. Maybe you are 
> talking about preferring acquire/release barriers over read/write barriers. 
> Right?

Load acquire is a single instruction load that does not require full 
barrier semantics for the critical section but ensures that the value is 
loaded before all following. Regular barriers do not have this singe load 
that isolates the critical section and sequence all loads around them.


