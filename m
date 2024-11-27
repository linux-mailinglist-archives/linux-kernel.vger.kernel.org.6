Return-Path: <linux-kernel+bounces-423729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB949DABF8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD19F166055
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CC7201038;
	Wed, 27 Nov 2024 16:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4NF3stEs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rO300cpY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733AD201014
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732725888; cv=none; b=djwnP//F17+bYkDMHBjUGSVUvbCrnKerUpiz91bW942xZb6Utnk7mv4By75/RrViasnwU2Hp7vdlPm8B33VDLMp7/aLOIdtKk1kRDoDLWoKKSgUcFlZAmADVUoLgbS6hcgWrkczojpMngw7KzxxUvmWUGf3a3x1xmEMSbfosreY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732725888; c=relaxed/simple;
	bh=pk5ctIX2qWikNT36hq6qyPfezaYMjjb2ZJMBLXpStDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpsWoRtrhyx37P/c7/1EL6hnu/HfANNMQ2hokXGDBr+NhLCgvUblAp/rqtnL2yLe5o5Rx/Y0Cz7ZO3+TmLWE/XJj+war08LzRPV9KVidOtHShIhOEjji31R8tfPaeZQCGIi/hfcRWy3IsvN+yWqjivBOnZK9+6SKwT8V18MwhdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4NF3stEs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rO300cpY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 27 Nov 2024 17:44:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732725884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c675eBn/bO4NrSflRKKSYCW+BqGb14xs/0rdhczcr94=;
	b=4NF3stEsrMN/+USSh1bF1ztGNnB8bqAiMspDr2RDBR91IFibYkQX8S1EZ7TvjGsn+nBQzb
	Wa5hJe0bHp2u3/PnfmCBQwVflGvfvMHgpCD/RJfmLl4kgmBInyKzLCafCuIuwacX4uPMSB
	+v9pEjMGZc27yT9LYoZubutgtDASUHa/N5SGVeBaiCRzQ6oeTclNMHX4CC7WZNlKLE9Ntx
	KiWdIzHD6E0ClDW5x0HflX1BFKROkkd5anSxsKnFSfbALYuhky53PkLzf3revaauoFmEDP
	L3X7giUO+6QviDaB+JnHruk3cSiHJlin/h6gvl8A9IYAfZNcSps3XeL2oiDuEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732725884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c675eBn/bO4NrSflRKKSYCW+BqGb14xs/0rdhczcr94=;
	b=rO300cpYbAsZr6dzYWNfoFWKo7QTcdMJCNuoA1hr4qy0XoTP+/+5OXQ7ktMmMW1h5KjhiA
	tC/WpcF1kC82cHBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will.deacon@arm.com>,
	Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] locking/lockdep: Enforce PROVE_RAW_LOCK_NESTING only if
 ARCH_SUPPORTS_RT
Message-ID: <20241127164442.catRG_Aw@linutronix.de>
References: <20241126231154.29151-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241126231154.29151-1-longman@redhat.com>

On 2024-11-26 18:11:54 [-0500], Waiman Long wrote:
> Relax the rule to set PROVE_RAW_LOCK_NESTING by default only for arches
> that supports PREEMPT_RT.  For arches that do not support PREEMPT_RT,
> they will not be forced to address irrelevant raw lock nesting issues
> when they want to enable PROVE_LOCKING.

I don't like the wording here. It is not "irrelevant raw lock nesting
issues". This is documented in Documentation/locking/locktypes.rst.
*IFF* we agree to ignore those because we don't want PREEMPT_RT on
certain architectures then okay. But please don't describe it as
irrelevant.

Sebastian

