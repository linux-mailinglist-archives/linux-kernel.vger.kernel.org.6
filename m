Return-Path: <linux-kernel+bounces-304287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E6D961D35
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 05:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85E6FB223BA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 03:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D093B298;
	Wed, 28 Aug 2024 03:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="K/hp7qWV"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17CD7D3F1
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 03:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724817160; cv=none; b=AerMzUNgwhzzBQq4ivWICi8aSJFSQknQib54iTuJ8QfgTrpSAU7x8SYwjmP6CVlAWAHescPSP7tE6FoLcgxzQ7aQ11S+PL6HJXpSGJVwaym/R8Vt7M7jmbuH894bsLRoX2ho20M2auIjDHnxioOkoz0GYcFXhVT53iT3ZbHzkjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724817160; c=relaxed/simple;
	bh=JsgEEgVWbCBTCqIe0q/dIQDphbctIgCikCN6lE9Jil0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g7LJsq3Xjr/xWcAfOmsAUP2uWmspMiXLGlhPbDjmxla2WktwamGePnp1Bebj4yvSnxMrAi1E63xG7uIDIPwvgY2Ail0ItVToYPSBPUZakh82xXl9cx8qXqO8HIOMX7GgPIGqunpqaLh3jZpm0l4H4DVJ53GQ0ta62CzZfpd7ryA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=K/hp7qWV; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1724817155;
	bh=/coqd0kyu+RMCNpqcNa+zY0sEmKMxLb/nShBI2s8tWw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=K/hp7qWVj7zmla6BZonpnHCqTjnE2DuKbPZcKVCX3wgfCCeQiJvOQL80cfrSqO5+h
	 hx4pBnZ8BcOIPMz3Paz734Wmp4nzEYqc4qnEwfZB4r1mFnNy0XVG7FfTHp4VPTiepT
	 Av8Q0KPwp4raRpMrUGc55EYYj2+Dj98Qllp7DXgUcT8hUpG6v6WWd4AXdXy9WSjxiV
	 TCyBw/DcpS0d18qABDaFLCSEAYqAy/bsi2rS7BsJOlELHLIRCvmD849HF8AfkvWZhA
	 ZcLksUcuzlQyvucucCMe3uJ5eB3M31IiUgb4X9gvGCQDxicW7vRcS7cGQQZ5i7En4f
	 bXu2gCj/CdNuQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Wtr8f4hX6z4wd0;
	Wed, 28 Aug 2024 13:52:34 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Nysal Jan K.A." <nysal@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Cc: "Nysal Jan K.A." <nysal@linux.ibm.com>, Geetika Moolchandani
 <geetika@linux.ibm.com>, Vaishnavi Bhat <vaish123@in.ibm.com>, Jijo
 Varghese <vargjijo@in.ibm.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/qspinlock: Fix deadlock in MCS queue
In-Reply-To: <20240826081251.744325-1-nysal@linux.ibm.com>
References: <20240826081251.744325-1-nysal@linux.ibm.com>
Date: Wed, 28 Aug 2024 13:52:33 +1000
Message-ID: <871q29fgn2.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Nysal Jan K.A." <nysal@linux.ibm.com> writes:
> If an interrupt occurs in queued_spin_lock_slowpath() after we increment
> qnodesp->count and before node->lock is initialized, another CPU might
> see stale lock values in get_tail_qnode(). If the stale lock value happens
> to match the lock on that CPU, then we write to the "next" pointer of
> the wrong qnode. This causes a deadlock as the former CPU, once it becomes
> the head of the MCS queue, will spin indefinitely until it's "next" pointer
> is set by its successor in the queue. This results in lockups similar to
> the following.
...
>
> Thanks to Saket Kumar Bhaskar for help with recreating the issue
>
> Fixes: 84990b169557 ("powerpc/qspinlock: add mcs queueing for contended waiters")
> Cc: stable@vger.kernel.org # v6.2+
> Reported-by: Geetika Moolchandani <geetika@linux.ibm.com>
> Reported-by: Vaishnavi Bhat <vaish123@in.ibm.com>
> Reported-by: Jijo Varghese <vargjijo@in.ibm.com>
 
Do we have links for any of these reports?

cheers

