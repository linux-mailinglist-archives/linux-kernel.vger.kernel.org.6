Return-Path: <linux-kernel+bounces-375471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C31EF9A965A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 04:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A814282E2D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 02:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B8113D251;
	Tue, 22 Oct 2024 02:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="EpboXSxj"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D5433DF
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 02:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729564957; cv=none; b=oAuxIDCOybiNbVqK2RnUW9y5JyQefgxJ8OlAvz1zNFZtHsVTMffviYrKRIBBDZbg2TqPnBChcdjy4UzY54IRyOjpL/NtCJCs3g41dkZmK+6+EM5HDgOfvCCshPp/cW0NqhpCkxMYVdZFh9K9ena0fK0gIn2QZv+YPteg4+5bxng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729564957; c=relaxed/simple;
	bh=XnvXwd0uQZhskaA6WbS6kVvF6VIeP6CMeQ0ec+4CoKY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OOA+uuzrQU6l21oYjQFYAZ9K9xp5HwdgfLFMZZGlcyGsLieljDy6aPiKQzuNB7g+WmX3m9rheh0EnwYKaJPp13XOiVMYQSCsWg+L5dN8jlgvR+f8FKUhNRqXtPPAkXvct//T1oFNMEYYv1YE90wkNCySqFtvlgOxRtg1EYFcAtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=EpboXSxj; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1729564950;
	bh=iA44515hIjaaXQQmGhGyu/wNw6RcsnRKM1ujfj6qVyY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EpboXSxjqS/PjqizIjw89fM7FbMw9k9eMRGAda8Dh3h5WJaC00qYYH+Sc9xGOj3Xb
	 OQVnzGz4pC46jGjNSCSjcSb1noaXHArrpPBGc5EoWSgDuwKucdLVYx6okeea3ZHJdb
	 dEhuDDom6MUz0h5Nrl29ByZLKvCxTafcJJO12TA3b0tDbqCCB/ZuPyCHMsxI8UiQyY
	 47PqCzXPzDiZeovFYOaYrykASRq7TUntUEPiGvS4BEA/4wi8hU86K8ogLi9qgFyEOZ
	 n3pZhmUwVueq9AwQdfJ/YY9T4NhEqlR9PNjZBtPkJFH0E9VS0kfs3dI9VJy0tJyLZ/
	 fPMIE/uRz0srg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XXc0P57pKz4wnr;
	Tue, 22 Oct 2024 13:42:29 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: kasan-dev@googlegroups.com, linux-mm@kvack.org, Marco Elver
 <elver@google.com>, Alexander Potapenko <glider@google.com>, Heiko
 Carstens <hca@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Hari Bathini <hbathini@linux.ibm.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Donet Tom
 <donettom@linux.vnet.ibm.com>, Pavithra Prakash
 <pavrampu@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Disha Goel
 <disgoel@linux.ibm.com>
Subject: Re: [PATCH v3 01/12] powerpc: mm/fault: Fix kfence page fault
 reporting
In-Reply-To: <a411788081d50e3b136c6270471e35aba3dfafa3.1729271995.git.ritesh.list@gmail.com>
References: <cover.1729271995.git.ritesh.list@gmail.com>
 <a411788081d50e3b136c6270471e35aba3dfafa3.1729271995.git.ritesh.list@gmail.com>
Date: Tue, 22 Oct 2024 13:42:29 +1100
Message-ID: <87plnsoo2y.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Ritesh,

"Ritesh Harjani (IBM)" <ritesh.list@gmail.com> writes:
> copy_from_kernel_nofault() can be called when doing read of /proc/kcore.
> /proc/kcore can have some unmapped kfence objects which when read via
> copy_from_kernel_nofault() can cause page faults. Since *_nofault()
> functions define their own fixup table for handling fault, use that
> instead of asking kfence to handle such faults.
>
> Hence we search the exception tables for the nip which generated the
> fault. If there is an entry then we let the fixup table handler handle the
> page fault by returning an error from within ___do_page_fault().
>
> This can be easily triggered if someone tries to do dd from /proc/kcore.
> dd if=/proc/kcore of=/dev/null bs=1M
>
> <some example false negatives>
> ===============================
> BUG: KFENCE: invalid read in copy_from_kernel_nofault+0xb0/0x1c8
> Invalid read at 0x000000004f749d2e:
>  copy_from_kernel_nofault+0xb0/0x1c8
>  0xc0000000057f7950
>  read_kcore_iter+0x41c/0x9ac
>  proc_reg_read_iter+0xe4/0x16c
>  vfs_read+0x2e4/0x3b0
>  ksys_read+0x88/0x154
>  system_call_exception+0x124/0x340
>  system_call_common+0x160/0x2c4

I haven't been able to reproduce this. Can you give some more details on
the exact machine/kernel-config/setup where you saw this?

cheers

