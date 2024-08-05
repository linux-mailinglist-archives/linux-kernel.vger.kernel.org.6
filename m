Return-Path: <linux-kernel+bounces-274774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FE1947C8A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBD071F21BEA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7820139CE3;
	Mon,  5 Aug 2024 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b="JljZaVHb"
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44B978685
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 14:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866992; cv=none; b=b/PsTqvuV3r+7AsQRIv3oiPPE54yydiCRXpnYqfDSsNWCMU+43cMwh0znwtwTOSMqw1jPvuA6PvqTcp/w7vbSEYNZw1wOXN94Kvza4GPR5L+TsSSaSoMwUYoucxRdZal5MkNlpo44yJ6T5jXDqwvNQNAkU3Bm7Tg1zzTE1neOzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866992; c=relaxed/simple;
	bh=YGi0PBi3b+75DsB4jTrMWW8lhBwiPanD1pd9nOKoEZs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YA8XgXUuwTVT0MaapwhKuzdNRWPYO8pPNsEsi215QfBvt/IOGjiL3GlTiOT/Z8svSLfLe3jpeltAxVk7Bljk+BzhI2btBh8HJBofLwrSPxMSqbzMn1Sc8plQrD9GdJW/UgoHNcQvk1AkPV/nz6T+M76LbZ/15KxWqNx6T+33OEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b=JljZaVHb; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2024080514094085043606dcac68436e
        for <linux-kernel@vger.kernel.org>;
        Mon, 05 Aug 2024 16:09:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=pTVgjQJ/WpC70xZIlMPIDO5jcR9Ox9kRcrJblGJ+xzY=;
 b=JljZaVHbf5/7UFCjWfnox3kgtH8GkzsInM+4kFplZY5KjSHYHeU/ararFQEbH54YoYjytg
 mKHnjNGsPyqY8tuCwCiSXlSVYwvuBFOW9psI1p/JNBwNw/K+AK4iHJN1pisKpaVjn3cFyQtS
 3UV9Jo3MnhyGEJ5GeZ7j+TCFgk4Z2vCRSJz9sYA06XrVLXmEdIIimpc91asybOTvwW4LK75x
 f8bABJ3Jmpj7JRySkrJXTT/KANlZKVLadpZzghWaGukMUh96bQ/SqI3ilhOLmTkommKv02JV
 xe0tlDmpUbtXsA0qZbOhzYXlguuTQNei1Zt5HYplVHhXDc1ke9+o4vig==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	jan.kiszka@siemens.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	qyousef@layalina.io,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH v2 0/1] hrtimer: More fixes for handling of timer slack of rt tasks
Date: Mon,  5 Aug 2024 16:09:29 +0200
Message-Id: <20240805140930.29462-1-felix.moessbauer@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer

This series fixes the (hopefully) last location of an incorrectly
handled timer slack on rt tasks in hrtimer_start_range_ns(), which was
uncovered by a userland change in glibc 2.33.

Changes since v1:

- drop patch "hrtimer: Document, that PI boosted tasks have no timer slack", as
  this behavior is incorrect and is already adressed in 20240610192018.1567075-1-qyousef@layalina.io
- use task_is_realtime() instead of rt_task()
- fix style of commit message

v1 discussion: https://lore.kernel.org/lkml/20240805124116.21394-1-felix.moessbauer@siemens.com

Best regards,
Felix Moessbauer
Siemens AG

Felix Moessbauer (1):
  hrtimer: Ignore slack time for RT tasks in hrtimer_start_range_ns()

 kernel/time/hrtimer.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.39.2


