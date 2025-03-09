Return-Path: <linux-kernel+bounces-553309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E54AA5873C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 19:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D98BF7A3F7E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 18:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0351DF732;
	Sun,  9 Mar 2025 18:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PyBuHCCF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gGC0CTT6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2901E515
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 18:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741545202; cv=none; b=mAghouCcX6OqhM/3ncOhw0iFQ1cPIw8f4RYZVYEtF8ioIUYqdvp4MFEstJeL9pOdJFm7Bbd0RvSeOlUhzGcjckOXHhAJbZZOZ4myJTNZYPEEFSlnbL7r09ejrAMS3HSC1LU4CjL3fs+zdeMC7cPEmQapsLfAFYasRsbgEJCmPiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741545202; c=relaxed/simple;
	bh=clmGu9iShXghHKC3obCSK3P7RDLfVEWfEhjNGteELJE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TW6YCeKJKekFbGI9JHvGqnmxykL6TyfKgKVxmtU45+XxG4dtEp7smGjYyLkJo24yBk54yYNmV7q35wfpuQdTMHn7y556BBUWNCliutLL93/W9KKYdGyFegsHw4IvRgvT1d03s0eYKGtrCpDa0D+30qRCfTSavXU2fhTii/NVg6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PyBuHCCF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gGC0CTT6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741545195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2fIxa4ESKQV03uv4dphBXs2utzwmZnVGOl+aW1Dgt1s=;
	b=PyBuHCCF0e+xEg0flN3JagRfDGOZZlh9/65yIpRCr6j417K8EliUidhbO64ANDl0+EPQ7S
	9bhl3+LH8+OjQClB6HXrhRyBfgLK8AoLKWyM45gIEq0YKJv2Uy4o7OygCKXvz9VqBECc9g
	pt9lKZ4NOHzO/Aerxaq6PkJ+wo58WaMoSBZYLn1sIlF+zwQbDNnbBz9FiSLYwmbA1UhJ5w
	ouJ8z3BBa9nn6AE43JY5YoGzHq7dvGkXKmjbaiUkGEU5yMW1GEFUs/2Z9P0TObgLFjVMbb
	vA3gor3Ykgiz1lmPbBscgNHzTBt4FqBVJ+eBjgpyDUIVHWZv8PYqDC2s427+lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741545195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2fIxa4ESKQV03uv4dphBXs2utzwmZnVGOl+aW1Dgt1s=;
	b=gGC0CTT6IkeHQTQZp6MS0iTKRStXFk1hpF2OUYsnOakLUbx1gFYDl1XWo/RZ7/5lZ4nxa2
	+ufUAs5RaU+IorAA==
To: Qiuer Zhu <chaozyhaha@gmail.com>, peterz@infradead.org, frederic@kernel.org
Cc: chaozyhaha@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] time: Add macros to prevent duplicate inclusion of headers
In-Reply-To: <20250309150524.760-1-chaozyhaha@gmail.com>
References: <20250309150524.760-1-chaozyhaha@gmail.com>
Date: Sun, 09 Mar 2025 19:33:15 +0100
Message-ID: <87bjua2gwk.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Mar 09 2025 at 23:05, Qiuer Zhu wrote:
> Add macros to prevent duplicate inclusion of tick-internal.h
> and posix-timers.h.

That's a problem for public headers, but not for directory local
headers. They don't suffer the problem of accidental recursion.

Thanks,

        tglx

