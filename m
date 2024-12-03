Return-Path: <linux-kernel+bounces-429926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 670649E290A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC3E167B31
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543591FC0E8;
	Tue,  3 Dec 2024 17:21:56 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F5B1F471B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 17:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733246515; cv=none; b=Erlts/kz8dZD59BzbUjw0M3Bilz5n9SCKvjtW85Bd+5SBX+Q6NgXUT4vfv67q+MxCzhGGfIFBWUBbp9C1w4MVyKIM6Egq2KNuami8PqnYkuegXKou86Vz4L4BEkmrULl8ClOaAiJ+PdefexnqWUeWVCxb1XOT29cnhcM6L0P/lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733246515; c=relaxed/simple;
	bh=Mph9ZWPb78z1yfeoiO9dyD32B0Gh6V1IWrfxxJOWoU0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=btv6B61rg+SwG/FYdqeM4UBtXQYb0ZkgLNQ9qZckPdSHM/ZeHwZBtZ70lYQkbxHbWhPgcDKW0Q77RZ21c7g5ebRaFqvwhAGPVbXIq/MHRrowS5ibauXqal03ESXp3SbwHtqpCEEzj+X9e0mHqaNKiXUhqglafLzREDZr80FX3IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tIWaf-000000008IC-31LT;
	Tue, 03 Dec 2024 12:21:37 -0500
Message-ID: <207d3b2abb0a9ead709de7b4710e256563b02f3b.camel@surriel.com>
Subject: Re: [RFC PATCH] smp: Evaluate local cond_func() before IPI
 side-effects
From: Rik van Riel <riel@surriel.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Linus
 Torvalds	 <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 x86@kernel.org
Date: Tue, 03 Dec 2024 12:21:37 -0500
In-Reply-To: <20241203163558.3455535-1-mathieu.desnoyers@efficios.com>
References: <20241203163558.3455535-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: riel@surriel.com

On Tue, 2024-12-03 at 11:35 -0500, Mathieu Desnoyers wrote:
> In smp_call_function_many_cond(), the local cond_func() is evaluated
> after triggering the remote CPU IPIs.
>=20
> If cond_func() depends on loading shared state updated by other CPU's
> IPI handlers func(), then triggering execution of remote CPUs IPI
> before
> evaluating cond_func() may have unexpected consequences.
>=20
> One example scenario is evaluating a jiffies delay in cond_func(),
> which
> is updated by func() in the IPI handlers. This situation can prevent
> execution of periodic cleanup code on the local CPU.
>=20
> Link: https://lore.kernel.org/lkml/20241202202213.26a79ed6@fangorn/
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>=20

Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

