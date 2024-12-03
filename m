Return-Path: <linux-kernel+bounces-429861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C129E27E0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B71E9288542
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB811F8EE3;
	Tue,  3 Dec 2024 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="08116Ytj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eqmv5wuA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268662BD1D
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733244220; cv=none; b=UrI3pFn5zDIbnGkw7P3ja7nkgelg7FezjALPwhxets82FeELxRiCPc95Nx63kaVWQUKEZa4cEyo5XKcC34oPsEeu4awDj9dFx4C2EgbkjFSooThRzyWyBkAfu7VXYVci7i/X/VpxhOkDRtEHhVswtWt39FhBOaZ05gzcdZeuZDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733244220; c=relaxed/simple;
	bh=euKfgJyWaKRtmQsDMbEZd6VxLNrCF/Mqnx6HU0i/kh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yd6K00L2JIaFgWDqxgseC1ibdBmnuQuJB64X6MG2JrTlfhnYa7oagvgtbnGVQG5YVYHbKCClqWAeUbZ6/v3JUM2q2rXx0h7UeXB5Us6H7+6xLZOIqMLaNm67hADPmWbt7zdDsdzqOYfCSgtxufsLUp5iTq8m6I4cxmmtPPY+hkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=08116Ytj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eqmv5wuA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733244217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=S2IlBIUxI+lZx3oMHfvJB74D0iMHIHy27xGvRAj7wH4=;
	b=08116YtjU7M2asroXE1ayZlQ6jhlcx/e8T/acAll8dWuuTQ2KLGoMGQj2gYSUJMHDvajTZ
	3aR3ZYY6vpzmeU8XglXRkwOuWnLxN0RTAouYsSUlIJTpgL6N6eNqeS3hVGa8Hi4LaNX+0+
	vrol0kjasJ+Eh4oQjWNmjaaVxQv79F+COoWSNSnB+CB40cLgzgjOuHusl6O9BeHFVbPEfM
	lCEhdc+f3lZwLpQQGIcLQxVTM1OGlHL6nOzj7ihbwGS1kwgdtc3+mxbxkVyR7tqJaza74X
	5g2DfcdB3lkv9NM8rEWQIpMJN12poeZynlEfvy8r5rWI1219cicm2cMP8BMK6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733244217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=S2IlBIUxI+lZx3oMHfvJB74D0iMHIHy27xGvRAj7wH4=;
	b=eqmv5wuABDVZN+R2GzeYgUAQt1cAVuuOc0fCWNlo3Ap/KNeNjT4JCow2V+F3di22DfNVA7
	2JO6DPonWVq4+KBQ==
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v4 0/11] futex: Add support task local hash maps.
Date: Tue,  3 Dec 2024 17:42:08 +0100
Message-ID: <20241203164335.1125381-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

this is a follow up on
	https://lore.kernel.org/ZwVOMgBMxrw7BU9A@jlelli-thinkpadt14gen4.remote.csb

and adds support for task local futex_hash_bucket. It can be created via
prctl().

This version supports resize at runtime, auto resize while creating
threads. The upper limit is at 256 * num_possible_cpus() but I guess we
can lower that.

I posted performance numbers of "perf bench futex hash"
	https://lore.kernel.org/all/20241101110810.R3AnEqdu@linutronix.de/

I didn't do any new. While the performance of the 16 default bucket look
worse than the 512 (after that the performance hardly changes while
before that doubles) be aware those are now task local (and not shared
with others) and it seems to be sufficient in general.
For the systems with 512CPUs and one db application we can have the
resize. So either the application needs to resize it or we offer auto
resize based on threads and CPUs. But be aware that workloads like
"xz huge_file.tar" will happily acquire all CPUs in the system and only
use a few locks in total and not very often. So it would probably
perform with two hash buckets as good as 512 in this scenario.

v3=E2=80=A6v4: https://lore.kernel.org/all/20241115172035.795842-1-bigeasy@=
linutronix.de/
  - Completed resize. Tested with wait/wake, lock_pi, requeue and
    requeue_pi.
  - Added auto resize during thread creation.
  - Fixed bucket initialisation of the global hash bucket resilting in a
    crash sometimes.

v2=E2=80=A6v3 https://lore.kernel.org/all/20241028121921.1264150-1-bigeasy@=
linutronix.de/
  - The default auto size for auto creation is 16.
  - For the private hash jhash2 is used and only for the address.
  - My "perf bench futex hash" hacks have been added.
  - The structure moved from signal's struct to mm.
  - It is possible resize it at runtime.

v1=E2=80=A6v2 https://lore.kernel.org/all/20241026224306.982896-1-bigeasy@l=
inutronix.de/:
  - Moved to struct signal_struct and is used process wide.
  - Automaticly allocated once the first thread is created.

Sebastian


