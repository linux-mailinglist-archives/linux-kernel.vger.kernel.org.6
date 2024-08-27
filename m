Return-Path: <linux-kernel+bounces-302739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3EC9602B7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B35F1C2207E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 07:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1D815359A;
	Tue, 27 Aug 2024 07:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="AsNub7R0"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7C777115
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 07:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724742861; cv=none; b=XdiOQ0aFKpqwlk6+nrohcjWfqnvN0oxyc2bshPHZgf5FakdHSKL/6MaR2Z+p/Do7cc1wvtP3ds779fJu70mzcMHVBPzKWW9xUTnVrfQGELCGVjl5FUpPHm3Z+U2KhLRWdphsbsdkuuu8n6/3VWor1utEco4mDp04Ruk+oEsT7zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724742861; c=relaxed/simple;
	bh=sCm2j2w04NQQj8ZyRNxyNh6BoMdgpyj1ZnhhJvxS1OY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uDUaU1+1v2qsODGVSbziaV6b3kvIYLfAJHs21GBFgRNbcQdOJN+FYrEs9xD4TwNn/aTQBYrweAzWb6/yhmDxxU+Z2h7wjQ1cyM2UM65wnyS28z/I2ePRkHq57MUGlxY2QdcgVlDgc/G4J4C0MCo5Tyx7ZYa8OqPnsppMgaws4to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=AsNub7R0; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1724742856;
	bh=4f8ZYn+PD/0Ua+DhzTGqi62/uCDj6DThJk05O8K3eP4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AsNub7R0L1gYIMMnFLUoxH9PTXLn/hwcO4WB/chjR4Irua8VZWKgU6/DXTwqtFaGh
	 sSVqnqNgBn5y2l51Zse8WaJw665Q39fCmyMJmnzAKFnO92IQtNuqOI52KuTrvGOh9K
	 Xq1SQT9HcUWDxfYs3x1FIWnLU0R1ql8rNEu/dZrWzwiaF+phhMvExXmer2QZEbAGtr
	 Cq8ND14nr1SvIRvh2S9LF5NahxvFKv0691yDhDprdIRq3VxZQT8fA7/iRtBYStLiHE
	 dfT9nhj7Ii28qFLjaqoq3FrxJBRRrAN60ikpp2gLgHVwnbhrksnWkGNDU4woplrMGP
	 lqSP8FPkJEy/Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WtJgr5bDDz4x3J;
	Tue, 27 Aug 2024 17:14:16 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <fd332b01c47bb9cb6c3af1696a2e109be655f5b5.1724222856.git.christophe.leroy@csgroup.eu>
References: <fd332b01c47bb9cb6c3af1696a2e109be655f5b5.1724222856.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Remove LHZX_BE macro
Message-Id: <172474280310.31690.9393479775812488774.b4-ty@ellerman.id.au>
Date: Tue, 27 Aug 2024 17:13:23 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, 21 Aug 2024 08:47:51 +0200, Christophe Leroy wrote:
> LHZX_BE has been unused since commit dbf44daf7c88 ("bpf, ppc64: remove
> ld_abs/ld_ind")
> 
> Remove it.
> 
> 

Applied to powerpc/next.

[1/1] powerpc: Remove LHZX_BE macro
      https://git.kernel.org/powerpc/c/a540ad3e386f8f84bc6d600b93792a50861a81ef

cheers

