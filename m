Return-Path: <linux-kernel+bounces-401473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDEB9C1AE7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 340E1282D12
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD501E32A0;
	Fri,  8 Nov 2024 10:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qfBvYQ6k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p4NsNFlK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1AB1E25FE
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 10:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731062546; cv=none; b=LGB3pVyAk699p+RQgWnAqST42ce6UoRo8XkyX2h1GRuQL/xY0Gl4hS6cYQKaGOMIpzhwzuc88CNe3wTzH6+K3wFhD3jnEeUhHmcBoqqprR7pP7KtWmDEpGXGJOoNdCUU7jEL/sGWiucUCfcX/xIXmqOUouQMyDzYWON/rNL3i7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731062546; c=relaxed/simple;
	bh=reAl7O1aGpL0qDchJSwhkdXM3JECOod5dJlN/EI+Itc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OWC6+VVUozzasYMo2EB77NztB6fBbTY4UiSuezHEIYNudFsyNFwI5O15xw04bzbkU7mUiVx+m+EtUxuQ7D9eyFOXigBH9zxpOiQgIhw/lV17ojQke4L7Kzy312VA7VcxtmzL7WRbnm17WjUrmuLa+7USLLlekBrCoL/V5GgiqNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qfBvYQ6k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p4NsNFlK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731062543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Xc/LqlPAYILBsDwML9BEpmuv1miP0xN2teShbWenCQw=;
	b=qfBvYQ6kuh5BTSejxUB5x+s9ZknK7JdSMW4KKMetywGm6rkDw2vJas1wrHwKPpgbOH2qod
	ulWmbP9NqMpRcGZDSBS1L1BfypG14p5lmvIwbpc1HrhCG/XbCWpBqy9+O043glabywK4Mk
	zrEo6RUn9D4tTGb2KuQQn1xNK8hh1EnJguL2j4o3ZujsBJEoXv3oP8YcUBfqzHwXNIm3Qq
	0AhKLXcE4155JytoBY2GEFmKM2gk5OwqzZffpQz/DfWQsXthsclMjMbfjdO6LU1zUV4688
	CVCr1LEWzhDZ9eafog4Lr2QijceuMG54YyEluz61JpqSyrj/GE0BkTSkXmLl6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731062543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Xc/LqlPAYILBsDwML9BEpmuv1miP0xN2teShbWenCQw=;
	b=p4NsNFlKqy+U0Z5yvV+sKgK5yBBsTiE6xP+SZwRZ9wzm8O2Mkiqg5B2ybRHzNtaK2Ju3xW
	crXyW7HKlGogteDA==
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
Subject: [PATCH v3 0/4] scftorture: Avoid kfree from IRQ context.
Date: Fri,  8 Nov 2024 11:39:30 +0100
Message-ID: <20241108104217.3759904-1-bigeasy@linutronix.de>
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

v2=E2=80=A6v3:
  - The clean up on module exit must not be done with thread numbers.
    Reported by Boqun Feng.
  - Move the clean up on module exit prior to torture_cleanup_end().
    Reported by Paul.

v1=E2=80=A6v2:
  - Remove kfree_bulk(). I get more invocations per report without it.
  - Pass `cpu' to scf_cleanup_free_list in scftorture_invoker() instead
    of scfp->cpu. The latter is the thread number which can be larger
    than the number CPUs leading to a crash in such a case. Reported by
    Boqun Feng.
  - Clean up the per-CPU lists on module exit. Reported by Boqun Feng.

Sebastian


