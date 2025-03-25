Return-Path: <linux-kernel+bounces-575608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C633AA704AA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58E957A26B0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDBD25D1E3;
	Tue, 25 Mar 2025 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=patcody.io header.i=@patcody.io header.b="bLSCSjvW"
Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E855725BADE
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742915566; cv=none; b=QctLb+O8ILHzoptR+5SUeJZRbH+dceaa7mBNGpQPNbcOheSs3NSvePWgsNk82uS7/Jh6mPwAi4TkCp5Pkf14kmsVwxEaIe8GXYETlfvGe2ofz1Sj3Na0dgtVvLgsCkWzvT8U9TL/iI8LdLtCfKU9Vr3N0pq03mmFQDG4w/aC0b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742915566; c=relaxed/simple;
	bh=1SMaNcgHDnVkPByJAs8xbaa1v3T/Chn2e5uxDku/NbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nacHQNxSScM2BibaOXz4wb+VzclcwH27Kk1BvzGKaKNHBJ+pBbUkxI5cFRrrkskmtMWNFcDKy5oC7gtbN4/WcEo0AjTPEGh0HOmd4Ol+gBuCcpcXSjhs0SNQNxsuQLc3kyLxpq+uGZo1cOuhrgULlcRKLoZMu3gPCn0oOODti84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=patcody.io; spf=pass smtp.mailfrom=patcody.io; dkim=pass (2048-bit key) header.d=patcody.io header.i=@patcody.io header.b=bLSCSjvW; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=patcody.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=patcody.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=patcody.io;
	s=protonmail; t=1742915553; x=1743174753;
	bh=DhNFLl2UgqhpiFGUc9+LyKLooe2GHvyl/+zO4fJQcMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=bLSCSjvWArxRNrI152xTD8OPQiNplvlNX+Ibg6H4TvMzi70ilPPIdl4/+IWSR/sjB
	 ymrmKO9oO7SwJM7yPYisaQpPqv3q6zeaQD+qDWlSTg2XRXsr4R/m8zvNlw5Q4ED+6f
	 F+yH6yRlxgV88GI1PdgCsu3oA+EYZaek52lNmiVuAZcV7Oks7MRmmUETLYVcVj2Ikk
	 mCMyKBICFb1Ab/wJ9aoszAhlKCnnz5yHkPvpn/hwkxwYz9Cylqrvyq6Wtf8Zn50+ea
	 k+FEC4PnMQlqTSRaviTVHFa/EQ8C6aEgPqqBDQiTo0v/qlb1KwGORfO83Lji3zgPmi
	 U1O82I3K1Admw==
X-Pm-Submission-Id: 4ZMYLl6FCWz3LT
Date: Tue, 25 Mar 2025 08:12:30 -0700
From: Pat Cody <pat@patcody.io>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	riel@surriel.com, patcody@meta.com, kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Add null pointer check to pick_next_entity()
Message-ID: <Z+LH3k2RyXOg9fn4@devvm1948.rva0.facebook.com>
References: <20250320205310.779888-1-pat@patcody.io>
 <20250324115613.GD14944@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324115613.GD14944@noisy.programming.kicks-ass.net>

On Mon, Mar 24, 2025 at 12:56:13PM +0100, Peter Zijlstra wrote:
> Does something like:
> 
>   https://lkml.kernel.org/r/20250128143949.GD7145@noisy.programming.kicks-ass.net
> 
> help?

To clarify- are you asking about if we've tried reverting 4423af84b297?
We have not tried that yet.

Or if we've included "sched/fair: Adhere to place_entity() constraints",
which we have already done- https://lore.kernel.org/all/20250207-tunneling-tested-koel-c59d33@leitao/

