Return-Path: <linux-kernel+bounces-311675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8494968BFA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 18:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 545E2B21AF9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDD31AB6C2;
	Mon,  2 Sep 2024 16:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cT5gbWuK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MVPMwzFz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12611428E8
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725294154; cv=none; b=SRSmfcDNdO5v1UauFDDymIDbRwzQdAfzJxR0rkrDJjag6v+IJ3kzNMZlMP7+rtZHdhrseS0EHXj74UpWxJaOTudgH1xKBFlUXbo7z9cXcXlsB07VVqCFZRoTWuyzaHOo2Er9S2+TNHsTlNT/8b+35KH7tOCvIbxogrWXGsUsBqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725294154; c=relaxed/simple;
	bh=qa0xAXqatdjEkG+wCL2tRSR7q4nNNDWI+Z7rPWFet7A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G+nI3eFcsCvDJnwHLCvuBkm00414LU/Jcan4i49ixovosdkLfoYdteygNJyLxFq2UlvXKuJJvha8koDIqmSF/abfrLSSW6C4X287pbrWkmPdF3d7fY9ztK7ogCaPXbfn2UWadcX1kQEu2CAUsjZCuWTe6plZQXVRjW63NoKBiLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cT5gbWuK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MVPMwzFz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725294150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QjxZw2svNTqzIQXoyp3DL+pfkiBFjFHUSR15+evOj+0=;
	b=cT5gbWuK8iBWkMlr56VH2afbFI+cLenaIR3FjGyULzYmvSk6JbWES4rJS8z6sRzyyBhW76
	8/PWtk7ZdSuM3NnDEZE0/iV6Vc+V80vyX72hIRLQZqvFNvxTC/XGNA6FFh4CCBn+hDgtJ0
	DMF4oBWLru5PgW0/N4v+/oWD5pu7pqo4zWMvY1pM6nFyZc4STZQxXGQ0YX8jNlvuT7c39q
	sPRMNbdy73qvpAH6CMQtpA1RMJesEUgfMSSlHQniWNX8KcisGtZB38GPRmamy3T2c40Meh
	wKazZfg1ALk6r3UQzn6RNi1T6PzklvXFVwhnjfhldpmWC6C+t2bMU/R0fhKmKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725294150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QjxZw2svNTqzIQXoyp3DL+pfkiBFjFHUSR15+evOj+0=;
	b=MVPMwzFzmG0ArI6AS0a2vbBThgbexXPzwwre8YwvqeYFL53YCuH+JxrF0ijCrBU6auYhP5
	k8PE2euVjItAIBCg==
To: Zhen Lei <thunder.leizhen@huawei.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 1/5] debugobjects: Fix the misuse of global variables in
 fill_pool()
In-Reply-To: <20240902140532.2028-2-thunder.leizhen@huawei.com>
References: <20240902140532.2028-1-thunder.leizhen@huawei.com>
 <20240902140532.2028-2-thunder.leizhen@huawei.com>
Date: Mon, 02 Sep 2024 18:22:30 +0200
Message-ID: <87mskq58l5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 02 2024 at 22:05, Zhen Lei wrote:

> The global variable 'obj_pool_min_free' records the lowest historical
> value of the number of nodes in the global list 'obj_pool', instead of
> being used as the lowest threshold value. This may be a mistake and

Maybe? It's either a bug or not.

> should be replaced with variable 'debug_objects_pool_min_level'.

And if it's a bug then it has to be replaced.

This misses another minor issue:

static int			obj_pool_min_free = ODEBUG_POOL_SIZE;

static int  __data_racy		debug_objects_pool_min_level __read_mostly
				= ODEBUG_POOL_MIN_LEVEL;

As debug_objects_pool_min_level is the minimum level to keep around and
obj_pool_min_free is a statistics mechanism, __data_racy is misplaced
too. The variables should swap their position, because
debug_objects_pool_min_level is functional, but obj_pool_min_free is
pure stats.

Also debug_objects_pool_min_level and debug_objects_pool_size should
be __ro_after_init.

> Fixes: d26bf5056fc0 ("debugobjects: Reduce number of pool_lock acquisitions in fill_pool()")
> Fixes: 36c4ead6f6df ("debugobjects: Add global free list and the counter")

Nice detective work!

Thanks,

        tglx

