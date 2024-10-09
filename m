Return-Path: <linux-kernel+bounces-357435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0944D99712C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3EB1C223CA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D141EF08B;
	Wed,  9 Oct 2024 16:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qP/O0Jg7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7FlWn+C8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8691E3DCE
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 16:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490247; cv=none; b=URJPdSWz2CVV47aau1CuK+y0GtiAgLnbpvX369lX657r/NFoZ6tv452UsfoXXvhUAoYQl9obgSajkAhmRZ9OTGXxT6frOeBPpX8fQHDXZvpFHaHqL0Kub0e5HD2ylRK4WgbCilHqF8m/tat0NV4Ii7ZdAxCuQvMDjNux4lkKL0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490247; c=relaxed/simple;
	bh=RB6WLXvlaw0yd1HUtlcB9os9LS12nwZnsWNbOwYPQU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KeHNtdbjtZvuIcV/ZfsTWPuRB9JyuSebcm3zVWiRq/D+RisOZpp1Tex5epzW9eZ/gw3t5gx8tl54DBBR2EyrNfLvS0zY2fi7/OKWrpjwvnlLhazOGlZSB+rPYCv1I9Ok1xYniXiiepHw9gd6ynXB14D3BP2NLeaPgJQMLaW8sdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qP/O0Jg7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7FlWn+C8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728490244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RB6WLXvlaw0yd1HUtlcB9os9LS12nwZnsWNbOwYPQU0=;
	b=qP/O0Jg7z0yubL0SlIhRquAWqbsxWgw1h/PMIhB6bG5WQ9FoIx3cMohAzGOyZgsyE88sv3
	B7yBljvlHQ6KzBV9I0oCAXdVMIT266KUpXEnlK6+a0ptV/8sRwxmjOMfZK0uuokKmXCgn9
	hajt8bR0ks3aqg67T1G9ErYoYW9vuJwkfu6OfSN1TtiiJF6gbmB0B+EO06DkvxjPIZEGb/
	8fd2s9xlltNYKVNl4mWVvNZvu+5Sen6bHE46zqt+htR5wHcEl1ZoKuf1EUGoSfRzBVlPtH
	mBAZBHiWjlL14PBOVsqkRy6F9ypEsJ5xePgUxBPeOYF7Vs8M67LQAlaaHTMSKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728490244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RB6WLXvlaw0yd1HUtlcB9os9LS12nwZnsWNbOwYPQU0=;
	b=7FlWn+C8KesVQsxE4AcWH+GETCx7zn59uxzRwlcC9x30eeTAqnRXLpzgzJ6z8fbYytcuAe
	fBfvBL1MzNQ0agCg==
To: linux-kernel@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 0/1] lockdep: Enable PROVE_RAW_LOCK_NESTING with PROVE_LOCKING.
Date: Wed,  9 Oct 2024 17:45:02 +0200
Message-ID: <20241009161041.1018375-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

PeterZ poked me regarding the status of PROVE_RAW_LOCK_NESTING. To my
best knowledge printk was triggering this during boot. This is gone
since the rework that landed in v6.12.
Before that rework, people booting with `quiet' got reports for "other"
splats and handled them. I booted a few boxes with this option enabled,
and didn't run into any splats.

It might be time to enable it by default.

Sebastian


