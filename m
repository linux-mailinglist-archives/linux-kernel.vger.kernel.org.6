Return-Path: <linux-kernel+bounces-399746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB339C03B4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70051284AB9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916B61F583B;
	Thu,  7 Nov 2024 11:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RcCsSVC6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SyZa2FZ+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5E51F5827
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 11:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730978308; cv=none; b=SzYS5JB1XerWBzrLDd9HSBT+p48uqrNtxz/zE561GQRKwlPWg+UJLqhin2Lp/NX85UQbGYW6MDDhDEn0mOsNl/uYphDENxO9Ncbd2dG45z8uY50lrUAKSiEtBQzFmm5Uv4DeD/0SyzrbUZdepKd0cLgHjMWlm5wmDZfpCJrhG7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730978308; c=relaxed/simple;
	bh=M5suUTcp8Vk1iaxHS2FPBeQe7fcXrTNClsRmMegHZBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KFG/IEfi7iTgPUlV7Upwv6OhbZrXyDpQB/a2bHquH5+W4zc/1NuYaXiBPPW618vyUJbwnYjiX70QFawU0gR2SM4r3lmtbr7Ugk4Tb73KXBj1r7LC8BPKl/cFfeahUjnqc+tHB3Zxod7XFMqxqDqwouJRCfc2OyjsJEbslpAWyFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RcCsSVC6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SyZa2FZ+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730978303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NjLLP55ROdVW0XOMGkfmixpDUwgnQl08mDjZ5Jht+U0=;
	b=RcCsSVC6nNwFokH3h2eTKUiRQ/fq1s8Cn9QwSC/V8l/INU9WUG3IEXNxVa+TTnYrqtSreP
	smdyCf+iydEWNUK8eXmi7Xj4M6A4N+bu9Y/6Kgin3hAqFIxAhoFzIdFzXIlLZhkIjN4Sg9
	9d//DNoib7nNo2uTbY3Myo2mOUpSg5lvSWE2ahwkAYsFXtbofRaeVHBLSGXhlUW+RsGxZG
	DIUi9b8MsZ3QYSnymfnDJCjh8W5FewCIIdnBaXr3hDRLOnMfORpZ2ZgYIwBZRYFPbcC4cJ
	2oQP3iOi1EjKQsCKjFgVj2OXSJhka17yhAtRy/rLjt/yE5WXAUNwULeBr0M6uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730978303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NjLLP55ROdVW0XOMGkfmixpDUwgnQl08mDjZ5Jht+U0=;
	b=SyZa2FZ+gclMtdRfvg0vE1IDog3dHu7z1eeMlPxR5jjArJZLNsNho4d0smiLBfbfNQO2jT
	82z9vrV1y6eCvwCw==
To: kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Marco Elver <elver@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	akpm@linux-foundation.org,
	cl@linux.com,
	iamjoonsoo.kim@lge.com,
	longman@redhat.com,
	penberg@kernel.org,
	rientjes@google.com,
	sfr@canb.auug.org.au
Subject: [PATCH v2 0/3] scftorture: Avoid kfree from IRQ context.
Date: Thu,  7 Nov 2024 12:13:05 +0100
Message-ID: <20241107111821.3417762-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

Paul reported kfree from IRQ context in scftorture which is noticed by
lockdep since the recent PROVE_RAW_LOCK_NESTING switch.

The last patch in this series adresses the issues, the other things
happened on the way.

v1=E2=80=A6v2:
  - Remove kfree_bulk(). I get more invocations per report without it.
  - Pass `cpu' to scf_cleanup_free_list in scftorture_invoker() instead
    of scfp->cpu. The latter is the thread number which can be larger
    than the number CPUs leading to a crash in such a case. Reported by
    Boqun Feng.
  - Clean up the per-CPU lists on module exit. Reported by Boqun Feng.

Sebastian


