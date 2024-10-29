Return-Path: <linux-kernel+bounces-387310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3D99B4F4E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB6831F26B07
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EF719A298;
	Tue, 29 Oct 2024 16:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIplHYOQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58A7199EA8
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730219356; cv=none; b=JWE7yVp42GUUd/V9ylBp6dbaNK6dnhsdUJ9dmJXk/v78g5vazKKVW3UsOXjo77fzD/r2VK1GyL65lr1VlTd7zBSijUiV+rtM5HsuGQfhiNLvPvh6tPt/XnN0HEtxWTGZbG3+jNCZ1AvQAtj8/dWnmK+LiQ2RT5udjqY4IyAtSCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730219356; c=relaxed/simple;
	bh=s3sO2Zxy0t1iDBHB99As38HWM4NBGwZC1c1/as/NPYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqBl04ERweuqQGBG3dx/0/bQ1V7Xg/LoT2z+Y93vQfT2hguQXsVK0ecIS0apG00TCPNFHfjXVJvMdkoZkAufyXuEJnaFMQyBu8CVFwCf+IS6hHquj0Yp9FIDBkMvLr3N0aRmmFSfHHbAb2phN7dW0yZu/2fG7dEL9hRQVLn70bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIplHYOQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8AB4C4CEEA;
	Tue, 29 Oct 2024 16:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730219356;
	bh=s3sO2Zxy0t1iDBHB99As38HWM4NBGwZC1c1/as/NPYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UIplHYOQ9TKqGLUkNqEkwiMivQ+qwF2aaI+FQPCFqhYuJja3UerPu7dKXkZMZEuNR
	 a99ccfAQopnzUDP9aFZzEJ//aA55CO+gnOr8lVOKoPFrs1Q1qWJstvbwHQ0yDi6oM6
	 LperOgxIPCIPUurdH2cyq8eOIds5TSOhWUSRog16wpx8ZuS1MSMsoHijk5vH14wafz
	 gm84zHm/rUgkbohAcic52QWFmknGcSNYoZqdDdI7itP6cph6tTwl/NxIFotVt2eqPr
	 abuQJ07NYW8S01KuqNHQALqPtgNXjEPzMwDxfz2gchbQ6xDLMYQIviI1/zAjodDNDJ
	 WKYAOIEW/Y6Ig==
Date: Tue, 29 Oct 2024 17:29:13 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V5 17/26] posix-timers: Embed sigqueue in struct k_itimer
Message-ID: <ZyENWTJcgf0j8J4N@localhost.localdomain>
References: <20241001083138.922192481@linutronix.de>
 <20241001083836.279523831@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241001083836.279523831@linutronix.de>

Le Tue, Oct 01, 2024 at 10:42:23AM +0200, Thomas Gleixner a écrit :
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> To cure the SIG_IGN handling for posix interval timers, the preallocated
> sigqueue needs to be embedded into struct k_itimer to prevent life time
> races of all sorts.
> 
> Now that the prerequisites are in place, embed the sigqueue into struct
> k_itimer and fixup the relevant usage sites.
> 
> Aside of preparing for proper SIG_IGN handling, this spares an extra
> allocation.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

