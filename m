Return-Path: <linux-kernel+bounces-232900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CBF91AFA7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 21:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F89B286D0F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 19:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AE719ADA4;
	Thu, 27 Jun 2024 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y//1T9J+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BFt8URDG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA5C19AA70
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 19:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719516550; cv=none; b=pa1cKT87Xgh3o+6IDu516tOtaBwd3vLur5XGz3ObzPSwMe3elcdZe06/Dj96a6cLaGQmIYxetlf5UoCtYm9nsjY254Tw7WQzvTXnnm+Ljoi2pdXw6KjTEtXrzsHwVXtbp7sRNz6sBYkvCFc+58mhAHRrZalG/+xRRNfofbGxwFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719516550; c=relaxed/simple;
	bh=kbOIt7x5B48k8UMnr9Hqdav/V7eMB28kujGMeoD33vE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qGxjbf294G4+9YiohXmC0EBSlBS+K07t/6gK6vEJ+6Cn0eLvk/Tii2Vu5G2QYDsU7w532aqbmysO/e2SR3k39E6UCTFYPnaX62d83ziL4mzqm9Azdb0VjaA059xpI3gcUbf0XbOhpKpePjLgCcv7h4ekQwNwZuTIbBMzHk4QmhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y//1T9J+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BFt8URDG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719516546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=CW4D3YwEZ8qRNj+FsFwIee7/X+H87oVZZiY4cCXMQ6E=;
	b=y//1T9J+0cLFxEoragJ+8eG5t+zmDDf634PGiw3gaCvF4/I86UcnwxlC9zleMl4GqtonKP
	eLZq3TMna2/JdRIW8neni/hryBAwB+gnLHDKV4j2g1pnVGwfiocDhIvf+QkpMOfwaUsS6k
	QEsw5wzoDx/GNnjToHIbPP0S178fz2xnmL6LexoyoyDvIGPnCi92yuRdafuCtqHEai4MGD
	mEG2hrzbbzXzaf2JqzykQL3JG1q3Vr5rDABzCCpzPtiFu4bTIlfQYIcAX4MS2beAWo51kw
	dI+ImsUdYHPafipArajNLqjnOr8CAPQzdPuH8h3wAIRdJzlY8Au/E1FiKklB+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719516546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=CW4D3YwEZ8qRNj+FsFwIee7/X+H87oVZZiY4cCXMQ6E=;
	b=BFt8URDGaFOD2lw8+6D1yFmMoX7MwSR09NppkJoxjEFL374inQo0mVLEF/5GEJVhQC1CQ5
	k/c157qoJWld9VAg==
To: LKML <linux-kernel@vger.kernel.org>
Subject: Mourning Daniel Bristot de Olivera
Date: Thu, 27 Jun 2024 21:29:06 +0200
Message-ID: <87r0ciyykd.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dear community!

Many of you will have already heard the sad news of Daniel passing away
on monday. The academic and the kernel scheduler communities have
published an obituary for Daniel on LWN:

        https://lwn.net/Articles/979912/

On behalf of the scheduler community, I want to ask everyone for the
time being to slow down the patches directed to all the people in the
scheduler and wider community who have lost a close friend, so they have
time and space to grieve.

Daniel's latest contribution, the deadline server has been put on hold
too and will be worked on when everyone has come to terms with this
heart breaking situation.

Urgent things will be dealt with, but might eventually need a nudge.

Thanks in advance for your understanding and respect!

       Thomas

