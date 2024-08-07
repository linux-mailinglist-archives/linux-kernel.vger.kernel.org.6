Return-Path: <linux-kernel+bounces-278352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F17594AF08
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49DE91C2183A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7B813D258;
	Wed,  7 Aug 2024 17:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lQJO3Xq4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CLGXTOSi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5828D12A14C
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 17:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723052568; cv=none; b=Xb/WBA+Vm6AwqImGg2Ec/mkeEudORHClNaoLCq7syIYNosfEiJ1kq1ANiVo8wjuDI6WVOVa7EIC4flnQORf5KYsZCxVQI92LZDzOgD1W0u4NW3xPi98iiXolCrfDvJLHmVjSpE+HfFIRS8oEMZEacBFeh/OuKsX2tTHbWHy1UAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723052568; c=relaxed/simple;
	bh=O17//GHBjtdgWWLp7j6suJ5mr+yILELiVZI8I7jqXd8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qqr3QbrmE9BKtozGQe35B4ugovezqKflPXtiFOQfZnBgkkCvn2f7oR17cet0OvGAr1/3Vj+QCEyFuvpCAoCrU8MLMKoqNU9nRwAGk9qWxa0ZwXN4lsTYCYK6DeV3nk7OpzfdzRuahfjH+PBP/RIM3EUEc/+rHUl7D45oFt6A2CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lQJO3Xq4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CLGXTOSi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723052564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O17//GHBjtdgWWLp7j6suJ5mr+yILELiVZI8I7jqXd8=;
	b=lQJO3Xq4UzG2uiSj4Abwu/wFyet5Uz7Qj0u138+bL3RqJhRZAhGAbjXAeOQBJ9qOcv7xAt
	CyUQ42OQQ302hK4AWxOlGEEmvaplj8JfQsTLVxJ9KMqMd5Yame290NuTiNSePYCkuRVWni
	/VP6qG9s1KeH8TCoreyr/DA2oxUoM5VHL3VtSWbqQIVJm1hY5o1FjqBS9/s2f5R513WMMQ
	qZb0bwWn0ofkZXiO+N/up2+x2yMWBc9VbTKB7asiV5Jjnr9learLUct5EsFuTgQqrs+jFV
	uhVMNizbU6f8/vVmob+2IPJxMGMsLNUUptBCHvLzJ0q6r5qtgDyTa5jtTLHLew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723052564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O17//GHBjtdgWWLp7j6suJ5mr+yILELiVZI8I7jqXd8=;
	b=CLGXTOSiSAxkDphJKiLJfTYIUdZttAgQt+XNoOQn0nzVS737RlVkM48r1QdHFzf8gdG40q
	UePiSpTtl/4N5cBw==
To: Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org
Cc: linuxppc-dev@lists.ozlabs.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, christophe.leroy@csgroup.eu,
 jeffxu@chromium.org, jeffxu@google.com, Liam.Howlett@oracle.com,
 linux-kernel@vger.kernel.org, npiggin@gmail.com, oliver.sang@intel.com,
 pedro.falcato@gmail.com
Subject: Re: [PATCH 3/4] mm: Remove arch_unmap()
In-Reply-To: <20240807124103.85644-3-mpe@ellerman.id.au>
References: <20240807124103.85644-1-mpe@ellerman.id.au>
 <20240807124103.85644-3-mpe@ellerman.id.au>
Date: Wed, 07 Aug 2024 19:42:43 +0200
Message-ID: <877ccs2prg.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 07 2024 at 22:41, Michael Ellerman wrote:
> Now that powerpc no longer uses arch_unmap() to handle VDSO unmapping,
> there are no meaningful implementions left. Drop support for it
> entirely, and update comments which refer to it.
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

