Return-Path: <linux-kernel+bounces-384901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 654199B2FFA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2986A283197
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720111D969C;
	Mon, 28 Oct 2024 12:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TuWeWEDR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sTJzQQt6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3031D958E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 12:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730117971; cv=none; b=Lx6ealENi4GSpxsNSC3cgGrDR/zOOxqalB8R3h/wpdjJKvInqkUz7TyHIOFdD2mXNNcGGd0nzbWorKQp4IoqgA0hYeXIqxsDrymFCCp28VqloGz6ZiDW8gsX1KXZZMayWb5F7HL75C6QpBpwee1O70DRkCxG+mozvyBpF4wCqeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730117971; c=relaxed/simple;
	bh=7tmspFyprMQgeYx5JAEkXZO/+WocUTONwY4g6IdxUcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dH835IwC0Xf6KaFVIEdme0e7a/4sDl10H38E83QP7qrLUpzJXgOgPhD5RGb6tZnnZb9zhgj+rGEgFSEdlh/505V/LHiEHSdsXe68rTacsB5YLux61eSUIS+JkV/IfOFxrJif8JTuTDU/B7gf4AuO6bXpnJpoibEg2JTjosSDHiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TuWeWEDR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sTJzQQt6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730117968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MhvbI515q3GdbBgLhbew9rcIhGO46d45gJLpr5fJrPI=;
	b=TuWeWEDRYce7TQh1eKRrbW1fmOnIqUnZqIgcl4kQaIVx4T4aUIEntsH2Qi9NdKeA7+rp+4
	uR9Zmy9/lsurNKxvd7BNd0hh7EyMLFNh0CFd3yzzjKJbQEoV5pkxRVmjyBJImyeYY+eXz1
	TCyt71u9aSuoxWvozUDtG0OJFgeVG6Q21EyPdxu+ld/2l1ENyUwuE7Gg0Xr/gE6WoTwaws
	Xc3v7GF2LSWknfUkm61fubwEADN3a4vKy8s06v5dlvDERvr2agxGWtQW2X+/o/q9jmfUU1
	JrU+usiYZQmMZawBJIugfwbvIgLggAW5lo8WUf301GQuv5v1ucUr22PNhgCf3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730117968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MhvbI515q3GdbBgLhbew9rcIhGO46d45gJLpr5fJrPI=;
	b=sTJzQQt6LtCSFvKxibIqSVLjUoX6KjMYGImFopU1+ivtw66gpN6ILdrvnbUlIL3YR4J0UA
	Ork5w3hhkLhbgJDw==
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [RFC v2 PATCH 0/4] futex: Add support task local hash maps.
Date: Mon, 28 Oct 2024 13:13:54 +0100
Message-ID: <20241028121921.1264150-1-bigeasy@linutronix.de>
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
prctl(). Last patch in the series enables it one the first thread is
created.

I've been how this auto-create behaves and so far dpkg creates threads
and uses the local-hashmap. systemd-journal on the hand forks a thread
from time to time and I haven't seen it using the hashmap. Need to do
more testing.

v1=E2=80=A6v2 https://lore.kernel.org/all/20241026224306.982896-1-bigeasy@l=
inutronix.de/:
  - Moved to struct signal_struct and is used process wide.
  - Automaticly allocated once the first thread is created.

Sebastian

