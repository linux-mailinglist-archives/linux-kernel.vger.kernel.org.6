Return-Path: <linux-kernel+bounces-560464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50957A604A2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 23:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3745619C40A7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BB11F872D;
	Thu, 13 Mar 2025 22:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D07nQ1Lp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E0D1F5821
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 22:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741906079; cv=none; b=gTonusFqkPS5xUez5LQMWeM/yr1yn1KOgmGNophtgpW98pNzDrHKtZ57vC6NuKkjAoEQlpbphXqh7PwRF9A+uI5pNuTg+ecCXWClCoZfG2DoPgbuGfypGCL4vyM/3fM4VpfQUVuKFYrwmvHLiPIG1igEbCPozGaQuPQMOvQWytA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741906079; c=relaxed/simple;
	bh=1vuD3j168L/LkXuHpAQRHWAckhTjhOgcAOnJeSUpGFw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=imO34oiTRdA+gZX9V0NiMl+oQX0wuUIRAqGA6O83cd9yapLfVxheZQ8mR4WUESe8k5LP9oAIrmSSWSBbfswvszNcGCwBH0HaXrrHGxKB3l2S5yXtOY18g4JsTbZylxSX0mU4RV0X7ECJ+YJQySvbDf1lH1sxi+kQeNQdz8M2NkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=D07nQ1Lp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A29C4CEE5;
	Thu, 13 Mar 2025 22:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1741906078;
	bh=1vuD3j168L/LkXuHpAQRHWAckhTjhOgcAOnJeSUpGFw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D07nQ1LpbLt/bMF9YjXcH2ajIgpv+FXAmqxwUrPU4z2wNpnjcwJnLB4gSGcaqzJJp
	 9N2HwfmnWhFKhSPXWoZ57u+AZFJ8GMdd4Y7qOx1PGShKUGhHbJPTjEpkA+/oHpFOV8
	 LPI7ztHnZrekAlZwU1tYLP/cFn74Pwe2Qn4FtXZc=
Date: Thu, 13 Mar 2025 15:47:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Andrew Donnellan <ajd@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 pasha.tatashin@soleen.com, maddy@linux.ibm.com, x86@kernel.org,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, sweettea-kernel@dorminy.me
Subject: Re: [PATCH v13 00/11] Support page table check on PowerPC
Message-Id: <20250313154757.79dc20b347a0bee16f4fbd10@linux-foundation.org>
In-Reply-To: <006ac081cf0e130426bcf0ef777bed346f6df002.camel@linux.ibm.com>
References: <20250211161404.850215-1-ajd@linux.ibm.com>
	<006ac081cf0e130426bcf0ef777bed346f6df002.camel@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Mar 2025 13:54:39 +1100 Andrew Donnellan <ajd@linux.ibm.com> wrote:

> On Wed, 2025-02-12 at 03:13 +1100, Andrew Donnellan wrote:
> > Support page table check on all PowerPC platforms. This works by
> > serialising assignments, reassignments and clears of page table
> > entries at each level in order to ensure that anonymous mappings
> > have at most one writable consumer, and likewise that file-backed
> > mappings are not simultaneously also anonymous mappings.
> > 
> > In order to support this infrastructure, a number of stubs must be
> > defined for all powerpc platforms. Additionally, seperate
> > set_pte_at()
> > and set_pte_at_unchecked(), to allow for internal, uninstrumented
> > mappings.
> 
> Talking to Maddy about this off-list - given that this series touches
> on generic code and several architectures, would it be best to take it
> through the mm tree rather than powerpc?

Sure, I can do that.

Are the rest of the ppc team OK with these changes?  I'm not seeing
much acking from the usual suspects?

