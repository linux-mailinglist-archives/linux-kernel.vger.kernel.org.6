Return-Path: <linux-kernel+bounces-282978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB45894EB79
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605671F21E5F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF36170A2B;
	Mon, 12 Aug 2024 10:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1sZgXgRK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pc5koXXy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB02116E866
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 10:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723460013; cv=none; b=LICMoFrDePKhW/3cRQNUBI8cx106V7aEuMjJAHBQAF3A7J/BzIBW6kBwd/2tFwzQm9AJCpzBNIWPzn3PaztChsk2v+umrtDDHZV5Ehb7hvUHbKCbFIFIhP8cDFeo51aWSg3m+yyr6PJajWssMcQuThfXmjLIi/YzExiBzt16//g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723460013; c=relaxed/simple;
	bh=2dEtTCM/tAIittfPxkJowdGaepIQ2pbpbjLxPBJOL8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q6v4M2vqtpLn2evtCXFsUsVB7+teMKGK5NNHerceKw9Vif2DNvCaLuD8QK7hBnG674uzq5ZJhbGVHlB8G13jbu1G+LNNPVW+jCxz/i308EIJbXHqbFAxlUWATwOnuT/lNzaVxuDsUXMq/L+Kmd7nGNzNPvT3/+SVD0Rn5fHICrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1sZgXgRK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pc5koXXy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723460010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2dEtTCM/tAIittfPxkJowdGaepIQ2pbpbjLxPBJOL8E=;
	b=1sZgXgRKBpfTpRnrt5aReS/ziBSE9ZKTutYcWVBJ5ClZNEdEw1ds7L4PAWYsHaTvYtxnn3
	pAz9WCX2LR29gjcyPutlxsk2okJN2gGCerOyhXspkj734qw8h2BVZXCfjYr0kNrcWssFul
	NgUIp87fX143dF0igJzhemeOvRUepfE2DTF+WSARpgqoQWMoDroSBpDrUyX0l7YxZoPldv
	HUyB54LrKPuls7+2F0sJNZFXd4DYNDUzUvGqJuKBuKfhag7yLEZaR6PTJnRI7RPvwiEWrF
	KV780hEBy45J8pAFKwqW/zD+k3lfn8yDap6KHB23w25fBVyztXxZCqcApmyLqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723460010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2dEtTCM/tAIittfPxkJowdGaepIQ2pbpbjLxPBJOL8E=;
	b=pc5koXXy8KR9scV4gTRCNcZZbyr2S2zghHu19yhrjc7dPquI7rvmpi13GMFLjIZXfJgMT0
	GFBtZkeB8xEEsZAw==
To: linux-kernel@vger.kernel.org
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/2] timers: Add sparse annotation.
Date: Mon, 12 Aug 2024 12:51:03 +0200
Message-ID: <20240812105326.2240000-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Adds sparse annotation for the PREEMPT_RT part of the timer code.

Sebastian


