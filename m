Return-Path: <linux-kernel+bounces-399538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF059C0051
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B1BC1C212A5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F791DF24B;
	Thu,  7 Nov 2024 08:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="kX4qxduv"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2701DE3B7
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 08:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730969110; cv=none; b=qdkWAfTdEg7F1nvTMpxh+8R76URZROjko3cDtwp4d6Zz1gIueYyGqUMsz1B5VHlbouJca4zqLfGslztdVx6N7Jwq9OQ5Wg5e1U5pParM6Tmh6RQTeGunfOwGrqPGXh6UVQ6K4VqK6M8VA0CMV1YpIxLdDZ/wCu33agqTpJuHrz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730969110; c=relaxed/simple;
	bh=go2Y9sLUoGP6MktCeaNU+KOuKZhmIfOTlSOSX1xdaTI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fCZLGMecmgOnjd/Vb61unEFeORLTajAQAt3kinIM6cWNwUIFut1/8mEqXrck3DpBRXbpDTzyxoladRhYuK+K0vAejmHgMlE/7LI8kVja5CM3H2RNB7AXPeCYUWos014C0QZxALCvbu9qUppkmK/ATlDaI1RNQii18lah6L0o5Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=kX4qxduv; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1730969104;
	bh=WMyBavOsB1vyHHQFOuRy967yIlTqEEkAgUL/cePEBWA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kX4qxduvkMx+ddJt2Hh/5SP/EPrFmi9O11yxW+tGM2U0l32mPnQIUVgE5ZdWyx1BD
	 H9FPDtLosWrxFPtO3zta5el1A0XMr/b2ln+T8yLLyogbF9KtbS5oS1V+eyupcA7/5U
	 DawML6hqLBnuYSMiRw3tJvxnDixLCdXRp2dKG1FqBsuOMbAvFfdJfNhb3Vu+F2LcsA
	 /6hOU75SqX0dN0g5J498wYmbHE9X2/xG1HoaRzbuF7vTu3AlCYPBO1afQU+qsHckjt
	 hYnVhuMjm3SZYxvg1yNQ8a28kggvgG7oqqK/qNEM4oBLQcHlXGi56+i0LFKxXC4KL2
	 mxdeqnH6RrLGA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XkbHN18gZz4xGC;
	Thu,  7 Nov 2024 19:45:04 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-mm@kvack.org, Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>, Sourabh Jain <sourabhjain@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Madhavan Srinivasan <maddy@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Donet Tom <donettom@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Sachin P Bappalige <sachinpb@linux.ibm.com>
In-Reply-To: <a2afc3d6481a87a305e89cfc4a3f3d2a0b8ceab3.1729146153.git.ritesh.list@gmail.com>
References: <a2afc3d6481a87a305e89cfc4a3f3d2a0b8ceab3.1729146153.git.ritesh.list@gmail.com>
Subject: Re: [PATCH v4 1/3] powerpc/fadump: Refactor and prepare fadump_cma_init for late init
Message-Id: <173096894636.18315.15962335864180582252.b4-ty@ellerman.id.au>
Date: Thu, 07 Nov 2024 19:42:26 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, 18 Oct 2024 21:47:55 +0530, Ritesh Harjani (IBM) wrote:
> We anyway don't use any return values from fadump_cma_init(). Since
> fadump_reserve_mem() from where fadump_cma_init() gets called today,
> already has the required checks.
> This patch makes this function return type as void. Let's also handle
> extra cases like return if fadump_supported is false or dump_active, so
> that in later patches we can call fadump_cma_init() separately from
> setup_arch().
> 
> [...]

Applied to powerpc/next.

[1/3] powerpc/fadump: Refactor and prepare fadump_cma_init for late init
      https://git.kernel.org/powerpc/c/adfaec30ffaceecd565e06adae367aa944acc3c9
[2/3] powerpc/fadump: Reserve page-aligned boot_memory_size during fadump_reserve_mem
      https://git.kernel.org/powerpc/c/6faeac507beb2935d9171a01c3877b0505689c58
[3/3] powerpc/fadump: Move fadump_cma_init to setup_arch() after initmem_init()
      https://git.kernel.org/powerpc/c/05b94cae1c47f94588c3e7096963c1007c4d9c1d

cheers

