Return-Path: <linux-kernel+bounces-383405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B15DC9B1B58
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 00:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4C861C20DA8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 22:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC4D1D88D3;
	Sat, 26 Oct 2024 22:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PFqElC4I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vz/19rCr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7C51D79A3
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 22:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729982598; cv=none; b=Et6QCBaMVnlOhoBs4yoITvmHvbZ7NGU9iCemwDOTiPiNSsbaK5zfCu/qAYrLNXK0UtxkFKHbO7Z0Aph7i5zzCSi2K29GsyQWITLgBXsBBzyhf/BQg0yh1jSBK7sfCKs8jrXX3+FECkLB0NjEEMcWtQ8RXsKR6A9Xq6cVJWIB1Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729982598; c=relaxed/simple;
	bh=b2ha3zGVFsoZSHO9CVcI8hPSPMKqNLHHMhbX0g0UWqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hFyZ33LekWw8b7KnJwmZkNk1Jg5TWVRR7TdZIeKZ4cgoGw53Jhvi0bWnPl2PqfE7kWnqF+xhi00wLVmhS8oMlnvq/QvLopm/lqesvqHce5H6g216H8X2D6KyoDiROy1rRMkRSElB5Hp3NckM0oRH1WzHtu0gk21f0CE82p1iFrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PFqElC4I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vz/19rCr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729982594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=L8J+NxVwYBUIP3hYPmzAJjgko6r9Nehgf9sLksLOQb8=;
	b=PFqElC4IPqfm/YWcmdQo7Eviqa/FfeKyRmtE4ZFJwcTBV9gQh25r6/sb30BU9iiBj96SZA
	nk3gv7AQ0eTBhaHy1X/Vnt68faoZte+9qqzk+SNzLd9MdI+ZZ7kVOpYFBwlluvzMb4k5yF
	13Fnhm2QG/LoS66+or5WtC6OYfPRO/wHgHqHgTNVcX53O7RmeklNI28KjySQ9WONHTfG3Z
	U7/4wb+4D/siSUNberf/VhnmokJHFUaHXh59QJmLECDS6id6V26aSCLlEFnacykkASvdE9
	tlqxxlF7o8uDZ9KtDTGklEPRiyWgMK3fg5OTYe1Yj0aG91KareJb1ESVql98Iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729982594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=L8J+NxVwYBUIP3hYPmzAJjgko6r9Nehgf9sLksLOQb8=;
	b=Vz/19rCrcIL2a2uUZVX+Vj+zSm7ZRliBo5YPWo7L0lC9QJKAjHOP/lk+E+xh468ZRzGNrE
	jwfDjF6u97DkuXBg==
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [RFC PATCH 0/3] futex: Add support task local hash maps.
Date: Sun, 27 Oct 2024 00:34:49 +0200
Message-ID: <20241026224306.982896-1-bigeasy@linutronix.de>
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
prctl() and each thread has to enable it via another prctl() interface.

Individual threads may enable it but I guess this gets more complicated
because the libc internal locks (or another lib) maybe be shared by
multiple threads. So maybe it would be best to enable the local hash by
the group leader and automatically enable for each thread on fork().

Sebastian

