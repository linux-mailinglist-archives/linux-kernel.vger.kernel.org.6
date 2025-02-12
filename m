Return-Path: <linux-kernel+bounces-510914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C89A3238C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C481188B52D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA07D20896E;
	Wed, 12 Feb 2025 10:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HiNPp2Vv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NLazJwO+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5794F2080EA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739356593; cv=none; b=JvACXgtJZI58++awpX0gGPu0qDaYiqhWWrCv8G3HrjdKu0rsP3qPg4a+0kTVfXsBlWNnobKkoINmLhB82h3iJY/gtsj9S1wG9/dGASkrVHOydb65mupqMSEQvw+SmU/EVweLfFvjBe3KjdLYDInaaigeuzJrqyLYjUzLFb/OeXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739356593; c=relaxed/simple;
	bh=0WR84p7YKZF2BFhyRyUTGT162ZAn/eAXDTpRJEXuTV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bA3LK2S36rXfhebqeyoYKtuqfbZ9ehcLqJc56er/fJ3yZpaGH3vObeP3cQONsLOTridE4DHN1faLkNGsqQfYZLyQopcnP1xGF3NZrqnoytmhWAooe2HZu3j0uwq+UeApV9VOtfC+WU/D3ea6haH2OXAwqXwGzrryOShqhI5ax2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HiNPp2Vv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NLazJwO+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739356584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o4ro3qoz6KkAoq2X6IKf6RkvdmN1FbVe9xHb8JQwNCo=;
	b=HiNPp2VvVxB3Xu34K2TVvPIidzEC3qRbSW4ce3+I4JUoOpcPJY9bUlVGUSd1PsSS7T8e/s
	hsx/4RPx6YD8Y/iR4JzgSQRKXMv4Zog7R9WCcLNnikWOtOu2Qb/ULCp7TMqpu2G72qdUGB
	eFZx8/EvDCPQl+EFRtSAwtMRWslaBQMo9GNz2mfnznJeHK18+AXrtdWvhIGMAjJQ7ZcT7z
	qPHqs6l3TvPWRkCemzrlEht8IUjZvc8pmAINXMwf4f0DEo8elNU6g4IvsVeyTSw6tNM7si
	90Df9egiW+hF/7znoU375d6YH/rsPBMKS+FTS1ZlDBocX7Rbidmj5pewvDTFOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739356584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o4ro3qoz6KkAoq2X6IKf6RkvdmN1FbVe9xHb8JQwNCo=;
	b=NLazJwO+S7ybtnv4SDpm2vAUYo8YwQlSfyyruNQYTUTYb+sIyfm3/J6xGQi4yvWGNxCKO2
	k59/ca16L3ECFlDQ==
To: linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 0/2] lockdep: disable_irq_nosync_lockdep.*() for PREEMPT_RT.
Date: Wed, 12 Feb 2025 11:36:17 +0100
Message-ID: <20250212103619.2560503-1-bigeasy@linutronix.de>
In-Reply-To: <760e34f9-6034-40e0-82a5-ee9becd24438@roeck-us.net>
References: <760e34f9-6034-40e0-82a5-ee9becd24438@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Guenter reported a sleeping-while-atomic warning on PREEMPT_RT with the
NE2K card. Turns out it is a questionable construct which requires
lockdep tweak to not get reported. It was added long time ago to deal
with the NE2K and has today two users.

The way I see, we could convert NE2K to NAPI and avoid the construct. It
would do the slow-part/ spin (in the reset case) with "just" BH disabled
which is what it is doing now since all callers disable BH before
calling. There are however many parts using the driver which have to be
touched (CS, PCI, =E2=80=A6) and I have just qemu here so I am not too
comfortable doing it. Also I haven't looked what is wrong forcedeth yet.

I have no idea why nobody converted NE2K to NAPI in the last 20 years.
The annotation was added in 2007 while NAPI was added in 2002 via
   abb85ec3ab0ba ("Integrate NAPI work done by Jamal Hadi Salim, Robert Ols=
son, and Alexey Kuznetsov.=E2=80=A6)

The easy part is to just avoid disabling interrupt on PREEMPT_RT since
there is no difference.

Sebastian Andrzej Siewior (2):
  lockdep: Don't disable interrupts on RT in
    disable_irq_nosync_lockdep.*()
  lockdep: Remove disable_irq_lockdep().

 include/linux/interrupt.h | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

--=20
2.47.2


