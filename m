Return-Path: <linux-kernel+bounces-439825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DD99EB466
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 604A91887403
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F5B1B0F12;
	Tue, 10 Dec 2024 15:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vHRoQzvM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="56KjTZqt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DBC1A76AC
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 15:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733843612; cv=none; b=XV1BGnYOvVNCRI8uhrEJ7lGSj2j7XQvffko8TQ0qVw0nk0v7W8r3QKeZgHTBLJcwNYwHiweD5P4V01t9hxMh4R5mQPPnCfTRH4UQ+60pMNPFeoNHG9nM7W8SGxf1QbSJpDxQzVeBfm2LwIDVPZD8pTkgrBx3jaTo2Sk2iO40k3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733843612; c=relaxed/simple;
	bh=G+96lWdPb02ompNFWsd9gI1zhNHEJNMN7/s3n4BPScU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sBrOxp9O3pg521i/w1g7Irmgvlp8HNsnA4w6E+a9+LT83095PWVoh01om0Zz0IUaoonLl0LMWZ7VhursHoBySqc4Sr3aS6/I5sWMsBAjC/J8JA5rKLq+tNFNpH/6BqUYFRtcZQdchr9R7K3fAt78b13xGxJhV89CyioCefxAuKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vHRoQzvM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=56KjTZqt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733843608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gjEoA1mSYT7VKNLyccAfkXFT3TfSub8DUjeA7bOYOng=;
	b=vHRoQzvMEYtU6HbfLgzI5+0zy6F81FaplLvMMHj360IHEo/kA2aRkXrwVeXq9289zvN4e/
	+mJB9UAqKerRoZ6JqZoAkI6GSfNw+gi8xIMaonf6fmns4eA/6AqDdzdJV3Eb6VUGCoMtPW
	2c5aGOVPuwr4k/A+1B+8D+PmDoGWQDdO9NeaoATTtbZ1A1xZ+eWt0Ld023lifqB9ok/9Jl
	xTRQQ5NkgFejOzErp+W6QE9VEvbIhCi8PBfHkdQwQg8ocWJBKU1jKzbA2qBWQAye/6W2b/
	bP1nyCYowbV1VcTrMgv25Lm8nNtdr2Lgrh2PQvhBSKEPdefvoqJ2jitiLqlZ7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733843608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gjEoA1mSYT7VKNLyccAfkXFT3TfSub8DUjeA7bOYOng=;
	b=56KjTZqtUDER9fCwQFsHwgYCO+9J4e54CmNn7k092M6J6gamVeWT2+hRg4TANQqQ8xbCgG
	7i976I3jxefqZpCA==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>, Darren Hart
 <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar
 <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Valentin Schneider <vschneid@redhat.com>, Waiman
 Long <longman@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Subject: Re: [PATCH v4 01/11] futex: Create helper function to initialize a
 hash slot.
In-Reply-To: <20241203164335.1125381-2-bigeasy@linutronix.de>
References: <20241203164335.1125381-1-bigeasy@linutronix.de>
 <20241203164335.1125381-2-bigeasy@linutronix.de>
Date: Tue, 10 Dec 2024 16:13:27 +0100
Message-ID: <87ikrrd10o.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Dec 03 2024 at 17:42, Sebastian Andrzej Siewior wrote:
> Factor out the futex_hash_bucket initialisation into a helpr function.

helpr?

> The helper function will be used in a follow up patch.

used for implementing process private hash buckets. or such, hmm?

Thanks,

        tglx

