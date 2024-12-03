Return-Path: <linux-kernel+bounces-429345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0A89E1ACB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FEE1289034
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442BC1E3793;
	Tue,  3 Dec 2024 11:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1R2Jt7SF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xmV9CodI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D28E2E3EE
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 11:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733224970; cv=none; b=Rha2xMEEGczM5wZyPTD6WWIcVLAqg9xBuKgvvre5epFyN2sPGD7FYTMgwmFbq4KNYHT+gEWQ14wHZYk2CZqgTAK7jwn/BCuJ3fmj78TmFbEyokrRFGtvp1Gkd1/diY46seaVRDEMlBACvTNjDLC7KKW5z8tq3N+4PjhAgCWgrKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733224970; c=relaxed/simple;
	bh=m7+SsmWTMYhI96mxQv2S+Cnq7FNz1L3la58tx/wlJII=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SDHGOc6tjZ6+a69GvR2HyTB0N5DEFSYhxZpPZfG+Y8dMSeHVSzP9Wuq/yOgeQC2S40V01vtlIvmLTRRDNQBNHQb/wARvzzl3SRqzqaiK5MKXrCFo5sPI8sqdtRoMbLg/+fYNEhF7DPQ1gJwVZ7zRtyKBM9b2jVjV+JrZ1El446I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1R2Jt7SF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xmV9CodI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733224967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ddVrsvoXgezLdPPTSfhSS8cKJDYGxl8v9jN0fTWuItg=;
	b=1R2Jt7SFgNG67qWKnWCbCaeg81nQ8IFRJTbIBN1LFpht7gmH6mphSR/pG/L7yPoyPrsPam
	jU81pSRyPm45wfy5kGxWCVEwznv8z+N6VGL0pM0at//fMTy3sPfP7e/9sWr1hPiL8XJwYK
	qkAAGQHZ255ZsDlcZ2EDVHhuEAeudIye3vtA3JJfTOWuEkGZ9Tswa1s4fu+tV1fbEdou+H
	S+TXdRbqbkgqxROjPKk/dpQ3PiIDxJCtouyjXn64Won0p9oBA7GXFlt1TVosOkYJ+rHAmc
	6KMV2eBU8mnVr7bIrkcuAO93gs2n+QooF6vkZZd/DBdxfTJ71SlwuflOSHJwhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733224967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ddVrsvoXgezLdPPTSfhSS8cKJDYGxl8v9jN0fTWuItg=;
	b=xmV9CodI0GhKQzqa33+CopR6HDzOmeVsbrfGIzaSK0OY8/9MM38pD5QD7af8crsIU8e0Qi
	1nuDAT/KDPct/1DQ==
To: David Wang <00107082@163.com>
Cc: kees@kernel.org, linux-kernel@vger.kernel.org, geert@linux-m68k.org,
 David Wang <00107082@163.com>
Subject: Re: [PATCH 2/3] irqchip: Fix a potential abuse of seq_printf()
 format string
In-Reply-To: <762e88c3e940bd6087c35b599f2c88baff775c6b.1732093745.git.00107082@163.com>
References: <505e5950dd2d76e6c3a8af57bc0cd1e0fbf2b637.1732093745.git.00107082@163.com>
 <762e88c3e940bd6087c35b599f2c88baff775c6b.1732093745.git.00107082@163.com>
Date: Tue, 03 Dec 2024 12:22:46 +0100
Message-ID: <87ttblt3i1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 20 2024 at 17:17, David Wang wrote:
> Using device name as format string of seq_printf() is prone to
> "Format string attack", opens possibility for exploitation.
> Seq_puts() is safer and more efficient.

I agree that seq_puts() is more efficient, but this whole handwaving
about format string attacks is far fetched.

These strings originate from device tree or generated device/domain
names. If they contain format strings, then that's either a plain bug in
the kernel or the device tree, but far from a 'format string attack'.

Thanks,

        tglx

