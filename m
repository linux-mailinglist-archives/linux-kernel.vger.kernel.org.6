Return-Path: <linux-kernel+bounces-446621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CD39F274D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 00:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07EB1884600
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 23:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39901C460B;
	Sun, 15 Dec 2024 23:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IpZMThnx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OAeWfeCF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADC61DDD1
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 23:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734304015; cv=none; b=cRSEjliT6XvhCexXpVug+a+Iz2CFYxWzn4i8Qx+Na93g6RyVZyFbMeaS0x/FT4rKrX1Bgfzg3v7Xfvr/wwMXpjDbCYUVw8ypVHSLeIxX/hY7Po+8pp1UzEPSzXAICePGwZrzp9gNfZXvK41+HlrP+lMPVggsReunuZVnsyLJqUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734304015; c=relaxed/simple;
	bh=PxHDC7enQD0EjKpWJ9/sOw5VGW8Js/YJmXGt6jmveyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cvcoGu+G9iYN/SWLfM0uX+vGJOImnoRBv1/JLIhymltS8eJ3DWxnGWyiGVIkKYpqWH7mAuag9gwJ+9N3wFk0+O4hHME5KIDc66ZZbG4m1n7p1WlCZFO6MjzB6pi+kKZMleQKSSyMbtCmDgn20Vmpg+/6rjO3sJa5GmGCUFUddoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IpZMThnx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OAeWfeCF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734304006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=spHSQOvOLX1o25sLJHJoVkJkz/QT8WbIjQL0AT2TEHQ=;
	b=IpZMThnx54DS/3PoXlUagPWKQ4t/aqcJ3C5QPw+tKRIEKtEzcHB7NYEkb9bfs7V17Rz+0y
	SsYT5sPezvzTi6/WFb9lOjMChjTFdDbyUA09+Nw9Cccesrre1pzm/ontsUw+/prQMQ4urp
	6mZf1idcnSaTmWz9yBKd0Hi4LdZ+AcUc2EboUWx69Y0+Og0vdms2q5iVOszTT8EyKO5KUQ
	KWZgcIk8n9BVHaQ7XC7sAnfcaWufQ1ocQ2oU5Ki+tLGnadLJnDtA0GjwBBOCb0nfqoWWUU
	+2iUwV1V5wB2plt3odvokvXiFzFCLshzfsNaGS6Cqh4j6XV9NZ6QThPJN/t4BQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734304006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=spHSQOvOLX1o25sLJHJoVkJkz/QT8WbIjQL0AT2TEHQ=;
	b=OAeWfeCFl29qRNLc82rhNJTFHeVWelTKIDH8iKHRwSquIA00aEtVqh7MUiyx9xzX8z10ZB
	SAp8GgXq501dNyCA==
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
Subject: [PATCH v5 0/14] futex: Add support task local hash maps.
Date: Mon, 16 Dec 2024 00:00:04 +0100
Message-ID: <20241215230642.104118-1-bigeasy@linutronix.de>
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

I didn't do any new but the lkp bot reported an improvement
	https://lore.kernel.org/all/202412122315.1a745d81-lkp@intel.com/

While the performance of the 16 default bucket look worse than the 512
(after that the performance hardly changes while before that doubles) be
aware those are now task local (and not shared with others) and it seems
to be sufficient in general.
For the systems with 512CPUs and one db application we can have the
resize. So either the application needs to resize it or we offer auto
resize based on threads and CPUs. But be aware that workloads like
"xz huge_file.tar" will happily acquire all CPUs in the system and only
use a few locks in total and not very often. So it would probably
perform with two hash buckets as good as 512 in this scenario.

v4=E2=80=A6v5: https://lore.kernel.org/all/20241203164335.1125381-1-bigeasy=
@linutronix.de/
  - Changed the the reference-tracking scheme: The reference is now
    dropped once the lock is dropped. The resize operation also requeues
    all users on the hash bucket from the old one to the new one.

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


