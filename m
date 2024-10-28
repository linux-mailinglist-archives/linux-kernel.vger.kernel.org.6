Return-Path: <linux-kernel+bounces-384367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 602E29B2955
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24B6028211A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A79204F7F;
	Mon, 28 Oct 2024 07:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lVNGM9EO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dyjJPUnN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA357202626
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100952; cv=none; b=oBzqSdjqLWJU2qSxs5aFlvGaDJRtN9p8uEETXty4Wm6Y457dsHFy2pjnZxFjQ6gWWmPECNKoV4Dwi0d7+qzeVyLTxRKh3pybji8g7onkBijK99rsczbmnnshST8yG60rqkhzdUkjOzq3tvuwIRGvgPCjNevj2G7KNdxNsw6zEtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100952; c=relaxed/simple;
	bh=iGuubNd75L4gJtaY4+cT6xHSUMdLacBg8Z6kJiSkeXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RmfZu2qDCI2gsjn8s9uNRpXafVRGelsKao9i5kBsU8DftWmV01iFBaAqGoppLRC/bA71NOrCwvWFAkW8ZHB1RjfPtKU+RccWN7f0r3x/2JyYQPndBBWdIhyeJeC5u8Ze0Urg1kveXq4Z7QXtDl9DjYjhhsF5+HG0ESHwxQG1q+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lVNGM9EO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dyjJPUnN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2yA05yfHMXuaBAIIxgU6jPpHHlnYMJ0AqN6uP9A4P8k=;
	b=lVNGM9EOQSam/Z5KkgX6o7dS2kKF4npic9k9PvN1KDoGqZrMPKVgDoV5Gt+dy2vDMLA1UM
	KhTtHzJOk7xGwK7FuSFz1/p1JRzIdZr1/iQJrXVSh5ARK+fkOd2lGYmW3217vr3nsV71se
	4YLKB5gt0lwRIcreRoKCJS4pX6QbdiogbeAjZvlRMSsNZrTXxyueG9RUDTcoBkXFrexsLG
	EXh6UWHDfHy5PYVK/cR0IN8KcWv4WnqdhoGcm7OC530AubkQXZn5RACUgh8HtEi6bSI4KZ
	ZivYGfqkONlsKJ3KiFYZFZ4Cpk3XzCsL9WhhQdWobcw6SUsTP3+poln5IG+SWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2yA05yfHMXuaBAIIxgU6jPpHHlnYMJ0AqN6uP9A4P8k=;
	b=dyjJPUnNBbMsuvDiXYLrRg+pt1svwus5KseYsExnbuqSLknmUgGito5uItni34Nq0Bk2m6
	BzXFbXUhaqCzn4Aw==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 40/44] virtio: mem: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:35:16 +0100
Message-Id: <2df859f20f7922bdb99a7368effb558bad372629.1729865485.git.namcao@linutronix.de>
In-Reply-To: <cover.1729865485.git.namcao@linutronix.de>
References: <cover.1729865485.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is a newly introduced hrtimer_setup() which will replace
hrtimer_init(). This new function is similar to the old one, except that it
also sanity-checks and initializes the timer's callback function.

Switch to use this new function.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: "Michael S. Tsirkin" <mst@redhat.com>
---
 drivers/virtio/virtio_mem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index b0b871441578..a74ff1418282 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2855,8 +2855,8 @@ static int virtio_mem_probe(struct virtio_device *vde=
v)
 	mutex_init(&vm->hotplug_mutex);
 	INIT_LIST_HEAD(&vm->next);
 	spin_lock_init(&vm->removal_lock);
-	hrtimer_init(&vm->retry_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	vm->retry_timer.function =3D virtio_mem_timer_expired;
+	hrtimer_setup(&vm->retry_timer, virtio_mem_timer_expired, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 	vm->retry_timer_ms =3D VIRTIO_MEM_RETRY_TIMER_MIN_MS;
 	vm->in_kdump =3D is_kdump_kernel();
=20
--=20
2.39.5


