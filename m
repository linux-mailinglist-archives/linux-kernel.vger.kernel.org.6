Return-Path: <linux-kernel+bounces-274692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F265947B7C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B8D1F226E2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222941591EA;
	Mon,  5 Aug 2024 13:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xOJSg+5E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="la7qoYXr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133B21E480
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 13:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862924; cv=none; b=aa8wZbr41kLtULIJgDALCF67emxz80QNUsTm/4vqfAHH0BuaZGm4aFGGC2JJ+7zgCuFz0KRay5EEsrgg5qeBbaBb+FKEeqNV0vJVwy7JFbLDByu/7zC/dqycYl+BHf1U5RuosQg1+925vfndFL2Pys6d848ywNfAKVdrq9HY8oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862924; c=relaxed/simple;
	bh=wrMaO7EaT68rauwbpS6gXpPtORsqEFufDRQyQn06ZSU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hg7Vdrqa8Dc3Kl6rVEUIekNiVvQVnJcZKT/dmocxarx5nQSNkp2UUqwHouDKInjbJUDwEVyeeF+O8s5zxbNEeom26abvlFK7fqn/1Tu/GaEsDWJE4wlV2qCLn4E/T3aSA8NYxKcTg3uVOGUrxhs9kKlNK5L1J4EuS6INbNPPaH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xOJSg+5E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=la7qoYXr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722862921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TLPjFq/FTgurSYDCrQICoeKAg7soh5MuirCqJ3DPSaM=;
	b=xOJSg+5EM6OohDR43WVwle2PicN53LC4BPQGkh4lRpYslHPJGM/G9FEMpL0Nuu/tfc2DaD
	p9u1KygQyljOXNa8KK0i5eQyqCsMfeATgWiWTcu0XcTSiCl9gxfg8hVzzlALbDP4AaflnD
	F4pYJKCaoXwtmLIZGCMlObKUtiz0tXq09YAAUiWCCvf1Jgkhdzic93KjfDPe6WMuo5m/hc
	RV/bhvrzZWCLl6+L6dpOSSCWSn2/qh0aADRNW9TYkuu3HkcPTffxKhcWU9P0deCkBJWoYa
	+NQlpocdV/ClKQdiZ/9tK4/65qnr4fRAtJ/kICJsFIyncHY/zLXvZUZ6IFrBXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722862921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TLPjFq/FTgurSYDCrQICoeKAg7soh5MuirCqJ3DPSaM=;
	b=la7qoYXrsHXgmMmi3n+23nhYtj+5p1u/8yLu7yAzcQ3RyLAUNDfJ0Qb4x00t3ucDrVhDU4
	rdHaBlsIaBoOY/AQ==
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 linux-kernel@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, jan.kiszka@siemens.com, Felix Moessbauer
 <felix.moessbauer@siemens.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/2] hrtimer: Document, that PI boosted tasks have no
 timer slack
In-Reply-To: <20240805124116.21394-2-felix.moessbauer@siemens.com>
References: <20240805124116.21394-1-felix.moessbauer@siemens.com>
 <20240805124116.21394-2-felix.moessbauer@siemens.com>
Date: Mon, 05 Aug 2024 15:02:00 +0200
Message-ID: <87cymn5div.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 05 2024 at 14:41, Felix Moessbauer wrote:
> The documentation of schedule_hrtimeout_range already states, that RT
> and DL tasks do not have a timer slack. However, no information about PI
> boosted tasks is given. The current implementation consistently ignores
> the timer slack also for PI boosted tasks (all tasks with a rt priority
> at time of programming the timer).

Which is wrong. This condition should not use rt_task() it should use
task_is_realtime() instead.

> This patch improves the documentation by stating that the timer slack
> is

git grep "This patch" Documentation/process/

Thanks,

        tglx

