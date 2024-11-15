Return-Path: <linux-kernel+bounces-411081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 281EF9CF2B5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C551828CDAA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6E31D63D1;
	Fri, 15 Nov 2024 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TaLU6odD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z9tJZmq1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812B61D5AB7
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 17:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731691246; cv=none; b=B1w68iOTnLvF/QojXyS/DRggCk26Yu9E3f/wUpAgjkI1LdHtENLyLaPI7JgaJPzuuKm57RZunweRagY5UTF7bv4t4d1v4aCdVQ963Ak0JIuOu2FVkxLBHKZ7ZPmMyhkcnAfSbdIz7qB0zepy2TZw0ZF36fiWnLlt34eMOUDJZdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731691246; c=relaxed/simple;
	bh=2JVdpNPHEZgTIRy+qzZ/o8YacqVgM9Bj7QNTWExsVV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mz3rWrcVoGWxf/LbYqt7vMJf3Fq7PkP1b60eUA4v6Zdc2+bpbHynm4jBLreftM2im7KRWfQYlQcZJIRncUEVfIw/HtXuvTOLDNzxhmj9676asE9K2wNaKxzo9/dgR39macM2+3yBFAxKcK6Y/8oBtrxFHM8TPbWL/kTTNB96wMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TaLU6odD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z9tJZmq1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731691242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uqkUwBWXGnVOa/b8cYe5/Wp6f1hufzRh23OcvAObtiA=;
	b=TaLU6odDugorOd0a2Xw+qchTtKdBDDi4apdxtEjv0a3/aQTewG76tN9ZGOdCjW/cAJaIUc
	gW2OH1C1RxNLnrd5WKkm+Yqg1dINdK2hhaPwFQ2i1VbrmTfJ38CB47dMRfvBvMR7W+aIec
	hvOJMHd0te+RTGQrqdO3VSKq5Oz2qbAXXsh98jkPmblqDPHSLe7DlIBZW9FsxVCysNw/kR
	q0OZyY7jvYNHtmFp4+GNKveic7DGLgFrplxEkRW7aPZtcNpwhftid9Him3QL3q0wi5B+Zo
	fGDSr6O0CAha+sLKP0Tb4UlXqpWPOSmp6IK7FKYPbc3c9v/+LofA9iI97QoOvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731691242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uqkUwBWXGnVOa/b8cYe5/Wp6f1hufzRh23OcvAObtiA=;
	b=Z9tJZmq1bxHGs2VY5drSmC2dFzwyHDtTyynqvZ1BBSbmr9yzMZHn/PLXwxmSr2Lma7CIG5
	o+zFDMkPymgttHAw==
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
Subject: [RFC PATCH v3 0/9] futex: Add support task local hash maps.
Date: Fri, 15 Nov 2024 17:58:41 +0100
Message-ID: <20241115172035.795842-1-bigeasy@linutronix.de>
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

This version supports resize at runtime. This fun part is limited is to
FUTEX_LOCK_PI which means any other waiter will break.

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


