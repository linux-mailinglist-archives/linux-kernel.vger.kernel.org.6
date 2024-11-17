Return-Path: <linux-kernel+bounces-412080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F44F9D0395
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 13:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC5B61F21FE0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 12:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0713192D95;
	Sun, 17 Nov 2024 12:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="ItOFpm/3"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF97E18C03E
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 12:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731846319; cv=none; b=oN3k0TKIVCDq1Fv1agikn3uPnJNgVdoQA5RxPvZrgdYCgswDcYYtcFExmY9LL/su9WnWMAyMBcIO21e1WkevKvdTWKPq5j+NECS0f3ux4tw2G/iWsOR9yIrc3fy/xy9XEJrg8L+mr6/ce4VdHzMeiwjjhTD+LkgmsmNaZyuu5n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731846319; c=relaxed/simple;
	bh=T187povMvccdGCV6irw2ZMRKOIjKmvedf/8a5Bw3lew=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AF9CstS02eln5NSm2In3iY4hRtlz2XwI2C/QEV8H9Xor4MbrfUVmNXm06+Tp5FHEhVzfkCQXszj/MXpZI7pq4MPIqpQU0VGMXoSCuvGe70U/J8YxIlG86XA+ft+5D6vhwsGOpbS9HN0IuflmAOttxCbB86ZjlmbcCKn8s4XbLoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=ItOFpm/3; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731846312;
	bh=TmUOvtaFFm8Lbs0BhgX9Y+/uxpOUMqksFC8Pa5BY3qc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ItOFpm/3/JldnYcAZfmLdfr71Cbw+i/dawDyU1w6cHL6LkTBmhHpJbx9CeJ2JsxBR
	 EWA/JllPiZRSVkIEm3cG2u1LnG5c7CDwyNu4uQQEEEaz/AyCKcrCT2mLIq+pBjgg6I
	 8TTtzT903nFRqtiuYYMZ/0drbtTiXdlEfjbjDZTV9XPZg8PrZu3y/VyzBroVz3KfS+
	 3lchmFQDLNrhXmf+GLYfrf3byMnSUnU6hOk3XViem2xDmB/741UtW82ZWPUFLNMTT7
	 Ql3JsRH/w4KGpdp4ZT/5qJ59nzO7uKaWJYMHgY8cjafU8N7M2hZAdbmigIjbU94JR1
	 fMcG5mCYZD3oQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xrqhl6ZF4z4xdx;
	Sun, 17 Nov 2024 23:25:11 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Geoff Levand <geoff@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <31fe9435056fcfbf82c3a01693be278d5ce4ad0f.1730899557.git.geert+renesas@glider.be>
References: <31fe9435056fcfbf82c3a01693be278d5ce4ad0f.1730899557.git.geert+renesas@glider.be>
Subject: Re: [PATCH] powerpc/ps3: Mark ps3_setup_uhc_device() __init
Message-Id: <173184539745.890800.2900457894457834398.b4-ty@ellerman.id.au>
Date: Sun, 17 Nov 2024 23:09:57 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, 06 Nov 2024 14:26:25 +0100, Geert Uytterhoeven wrote:
> ps3_setup_uhc_device() is only called from ps3_setup_ehci_device() and
> ps3_setup_ohci_device(), which are both marked __init.  Hence replace
> the former's __ref marker by __init.
> 
> Note that before commit bd721ea73e1f9655 ("treewide: replace obsolete
> _refok by __ref"), the function was marked __init_refok, which probably
> should have been __init in the first place.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/ps3: Mark ps3_setup_uhc_device() __init
      https://git.kernel.org/powerpc/c/da6ffe855b5a05f29222e3d4ffa4b549413e33a4

cheers

