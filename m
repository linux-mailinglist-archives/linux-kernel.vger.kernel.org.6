Return-Path: <linux-kernel+bounces-282968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EED9B94EB63
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66ABCB21DB9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F61171092;
	Mon, 12 Aug 2024 10:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4EH8gHBq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5GyCFvaE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CC916F271
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 10:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723459330; cv=none; b=ALwo3MUqhnw7MmlxekLp9J2qnEAnnd5CDfliPQyIEskhKsUr76a5k9XcIdik4cXRaOxL/C6koGqia0K0VOFxTSqArqx52zWtFjWJ4gdGrdcGorHcnPjDwdZYc44fMGTtQrenVpsAUHncQFKAOFmRci+OzEoUy83cfdbZMzfyCzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723459330; c=relaxed/simple;
	bh=r3xcYBncwli2Ed8eDaXSnPMpWyt2xGCwawvgvs2fCTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vvw5gEJ9KokTypaAOzBGK6+QeeSoPbWa8A3R5Rc4tagVDX1KqFlxjO5SR19MDVSmjG9ghdswNlUyxclybdv4Ma+oHHKhYFkNlSOO0l7ph318VW+N7JanAhacat5MWOEUjdZIy15ChK+4CAg/7m/z2/F4xVHhSMlIA7aE5QG2JWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4EH8gHBq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5GyCFvaE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723459327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r3xcYBncwli2Ed8eDaXSnPMpWyt2xGCwawvgvs2fCTI=;
	b=4EH8gHBqDtvTuE9kRKMbzlPZ3ohVKIJ1/FiBzoGmupl5FGo4OVSTTujC5tLbt0HXIu0ONY
	pVtZsAQ3N+kll+tl/MrKtMZOBQTX8JbZvUojBaz4Emh2/014IP0Aa1Qvu2PuQOqT+TIwhD
	Hb2f2mkXjncEs2TOYJFWEQgL1VGylYrDa7siEkGbVg1cebY6haqC6aGqybDh210vRnMwME
	5OEjdCAo3WXjsO9wkbvRrcfCwImPoM8XJiDZHSaSDowT5gIrctxaHEJunDc81R2hQiQsHT
	TBEJ4ocPpRNfjrHQQT/2mIUrIuHvxjJ3OenfQHIa7Wa3KXvrq/FAGs5EqE0Krg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723459327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r3xcYBncwli2Ed8eDaXSnPMpWyt2xGCwawvgvs2fCTI=;
	b=5GyCFvaEiAaGphIjbOCIHU457HXyzu2WJtvWVPuys20Gp+lg+spcyGJDbBqYcYvbVbZFoH
	V+V9XXjBH26HUsDg==
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 0/4] locking/rt: Add sparse annotation PREEMPT_RT's locking.
Date: Mon, 12 Aug 2024 12:39:01 +0200
Message-ID: <20240812104200.2239232-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

the series adds sparse annotation to PREEMPT_RT's locking which
substitutes spinlock_t and rwlock_t.
The way local_lock_t is implemented, sparse annotation works for
PREEMPT_RT due its spinlock_t usage but not for !PREEMPT_RT because it
is just preempt_disable().

Sebastian


