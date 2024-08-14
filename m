Return-Path: <linux-kernel+bounces-286263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2759518D4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2C0A1C21539
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4141AE858;
	Wed, 14 Aug 2024 10:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YalDkqGi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vO8MBuyx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D65F1AE869
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 10:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723631415; cv=none; b=vBrgPYuC/k4jyKT1IxHM5dYAXbUjI7QHRCWw/GX5DN4dgjbJKtNIHOUqc3j33W19tG7U7U6z3HW7Bs7i7MEZNqJGqV+fs+n0m2Vysp+D5ybpN5sO+sUoefoiSKa9HyGBAKZpbqCSKAqf5yzdlSGBihE71CuHJqBe8I5gWNQ8Mjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723631415; c=relaxed/simple;
	bh=Y0JXjDVhR7lLBt0G8ENRah64qK8CPdkzemr40Mwdo6A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ps49pA/gH2qQ5+dLg+gR6qgNXL5AX86D0ku+VZz+N1TKIdO303o+Mm3vGatiIpdjNQu9ib1rqSdn7oJXctqJulq9DzIvQJoXOAIOQ/xAt0c4lOh0h1+IYza/PrctMaO9sPg5xm4AzDyaSdhtj0kkMF07O8bm01NygfT52d2xlaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YalDkqGi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vO8MBuyx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723631410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kQJcLvdJXGirvTzHx/X5mQxJZfu1qd9LZj5pJq+trw4=;
	b=YalDkqGid5cIIu7BfMSWEd4UsIKjyU2dhPdda3VcpO78xsLv//xQPjJbd6YpSiw1HwpdHQ
	+gdykHM6Rz/Dq8bov+c1YanMm9Du8ptDadZJD4C46ZTKj8SuA1TSuW+jhYBN8jiOmeiU8r
	TQBXqiIAIQ37BTft6sjf/EBnakPZge/Lg7MipnkjUIxN2zJUs6j1pSS2wrMuduYBZnnPiG
	G3K4ESwelOH7a6NaUVp1cuitsAwq7Q1j0y1NX/ZIn+KQySDLL34mA8zO3X94puJwb53BjO
	MAk7c1qFU4+6YmfvcwONhOigaqtlOBsa85QB023wy6eVTJY724wQkMncoH5G/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723631410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kQJcLvdJXGirvTzHx/X5mQxJZfu1qd9LZj5pJq+trw4=;
	b=vO8MBuyx4LB7RymIQGNZ3fBiI0Svk1sljj0EXFjPr0CWwMObzBwqlWPKACIZSqxwk5xRT2
	bobpqyFt9tVZZWAQ==
To: Christoph Hellwig <hch@infradead.org>, Max Ramanouski <max8rr8@gmail.com>
Cc: x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
 peterz@infradead.org, linux-kernel@vger.kernel.org, jniethe@nvidia.com,
 jhubbard@nvidia.com, linux-mm@kvack.org
Subject: Re: [PATCH v2] x86/ioremap: Use is_ioremap_addr() in iounmap()
In-Reply-To: <Zrwyh9bKGVzkLzeA@infradead.org>
References: <20240812203538.82548-1-max8rr8@gmail.com>
 <Zrwyh9bKGVzkLzeA@infradead.org>
Date: Wed, 14 Aug 2024 12:30:09 +0200
Message-ID: <878qwzpfbi.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Aug 13 2024 at 21:28, Christoph Hellwig wrote:
> Modulo the fixes discussion (and any commit log adjustments related to
> that), is_ioremap_addr is the right interface to check for an
> ioremap address.  So for the actual code change:

I'm not opposed to use is_ioremap_addr() as it restricts the check to
the actual ioremp region.

That said, I'm wondering why iounmap() silently bails out when invoked
with an address which is outside of the ioremap region. I'd say, any
invocation with an address outside of it, is broken, but I might be
missing something as always.

Thanks,

        tglx



