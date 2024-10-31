Return-Path: <linux-kernel+bounces-391035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BC39B8183
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC78282D46
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34111C2333;
	Thu, 31 Oct 2024 17:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nPdNQhib";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WBeHgelZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A7212D1EA
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 17:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730396864; cv=none; b=opE8fg3NP0MhtyMGUwXlkYDQB/PKhGP5PydHl7X6OaRhWkWT9XwwTm60pib5MxeMv1YQCevD6xp8H8pCrTiaFcJqsHY58MuXW5s5KJXSzeUaeH0ILxeCouanOhPzWACczDHAN3ZPHjqS3wCzwQr7QpKOoknZi1sN8ZaK+I5kMUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730396864; c=relaxed/simple;
	bh=1qvyEbQD769gmRTPMK9uPkEqgbrEct+sTg9j1bZBOx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ty0gR8BZPzxEwlpwrArwqFKKchm78v5Ozfvbe+EfSFZkvMzo6d6kNYaY5F4DwMryDPZTz08EhLTBwkkJF0uAO5Td+QbBeTQHkXy6IQ33T9wCYgeSGKCXxRSfRNkR1ORTPmB9klrwfmItTMERS4r8WczUb/mXE4FtgsHusWj1t6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nPdNQhib; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WBeHgelZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 31 Oct 2024 18:47:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730396860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QkgSKfShph4pWoE9L3MXmhssHtVtwLvgwKyGCu7Gyaw=;
	b=nPdNQhibOJJLFWs04vqg92UGfollFVR+0HNbtc5KinU+nI61xfBcyXRiqMoW4hSUjujBkM
	QkNw/l1G8mjBc9D200GK3/Pwz9u/mzSD1d2K8r8/8YPngQWKErH0LpBhMQ+S6QPBBeY1dV
	h07+zGvpR4rfPkoIjEsRJeKoBEenozt1JYceoiYlvvbvfcZDUlthjvWG8+axugBoyJA9qZ
	MCpRfcyceCxlP50YduEIkIu5jTNRt64NkkMKG2MB3ctJXW9Fl3Kfh/zmIdzwBebdPLwvBG
	ELCSIWL9lcaUST1k4ZCR9AJM6T8cA8G98Q3JrVLqUoiN7JB2rwDbCmaEvrYk2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730396860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QkgSKfShph4pWoE9L3MXmhssHtVtwLvgwKyGCu7Gyaw=;
	b=WBeHgelZWB8tJE2wi15afyUV7rrLEXhGYoLGLNnChYd9Cesw3nwLIDKqLvk7bZoQxtRENx
	nwESeSSuyzOv95Dg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [RFC v2 PATCH 0/4] futex: Add support task local hash maps.
Message-ID: <20241031174736.apc_hFru@linutronix.de>
References: <20241028121921.1264150-1-bigeasy@linutronix.de>
 <20241031155640.Fhtm3uFD@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241031155640.Fhtm3uFD@linutronix.de>

On 2024-10-31 16:56:43 [+0100], To linux-kernel@vger.kernel.org wrote:
> Pinning the bench to individual CPUs belonging to a NUMA node and
> running the same test with 110 threads only (avg over 5 runs):
>           ops/sec global	ops/sec local
> node 0		2278572.2	2534827.4
> node 1		2229838.6	2437498.8
> node 0+1	2542602.4	2535749.8

Running on node 1, with variable slot size:
 hash slots	ops/sec
    2            43292.2
    4            81829.2
    8           156903.4
   16           297063.6
   32           554229.4
   64           962158.4
  128          1615859.6
  256          2106941.4
  512          2269494.8
 1024          2328782.6
 2048          2342981.6
 4096          2337705.2
 8192          2334141.4
16384          2334237.6
32768          2339262.2
65536          2438800.4

Sebastian

