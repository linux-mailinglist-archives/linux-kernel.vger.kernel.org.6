Return-Path: <linux-kernel+bounces-408505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044CE9C7F9A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 01:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B36882845D7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 00:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0407DA88;
	Thu, 14 Nov 2024 00:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="rP7AMQn+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h+0f4Q+0"
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC477DA79;
	Thu, 14 Nov 2024 00:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731545849; cv=none; b=oYVR/bT1/95tmXEMmSlhrJa630DQZ8vrPGSekIE6w4uUTKj6vNxY0yuzzfQHmQPTRTfUPjElIoSfGffVRXPgBazC0YLc9zIUzveeisFMfv3PQyXE6LQe7AG5SjMR7P6/zdFRqOmDv+MmuUGP+TzyJTeOpP9XKnmwvIxkte77WEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731545849; c=relaxed/simple;
	bh=3diFOj1WNc/IGD6l2UVGdqRdSALufTmvPUB1jtkB4SA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ga9sGlJD1n7jTegm5DNaWgRsmPwy+jXsPcE7I/WQj4Y/MjyzpVEw3XHlo5kDgEgREMtAUEeQzP3eeJtM63szlT9DoOT38mIZT+OU7yZCth8v2rFD4tiZxX8wVPAKYp5saf0KXIj7puWbYTzv0Z90ZLo6s5uy8nnYe3v8wYAkdnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=rP7AMQn+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h+0f4Q+0; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 08146254023D;
	Wed, 13 Nov 2024 19:57:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 13 Nov 2024 19:57:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1731545844; x=
	1731632244; bh=I82DNJzv7kfFPrLMZSPvOLFKl2qaIomC68nQGim2+iM=; b=r
	P7AMQn+EvIYuLgobWgafk+J9skoK7RKHq3mJhzMXAq89HBkP5qGkKjuTgU5F2bV2
	5HWQjqZSL3hCbTmzvK6md0suKEH3ZWgzc1KCOkDJnbTEblVMM2oUOSQLFWfB3eQ5
	tYefKl/r6mI8JTjvrEhg/ETWCuiSVYXk4nAoOei/1XBnS1ezqBqd8sr9MsufQecb
	+WLFwR2itogMhJF+peCXx4svL+Ehan5pOLhLV+jAMPWwjgma4icWcrQxLmb/xlf/
	13vopu6sPAr3QesUrG0PyvY0MSaW6i0d5tWI54rppRglYrBRmLuHmLVxrK3MTuB9
	vxM3aWiU821/oXp9fwVbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731545844; x=1731632244; bh=I
	82DNJzv7kfFPrLMZSPvOLFKl2qaIomC68nQGim2+iM=; b=h+0f4Q+02n3BD+GmN
	t2dLNn6duYJNirziFJVVZgwZXcIoOejgsIlvzLlChK39UjJBCP28GTV8YO7RRx3T
	SDUIEImpxBWAa66Mn2QdL9T/3MV4o7B0oQEP7gQNKUHoUU1JY8zEDHuvvd/HDETo
	Cr4BWe97pqqvvnYdz30Re+cuJLixEyJTiQ9zI+vxcbirqdfub18l2HyoR1oTKYPG
	2q5SI+hlvUYO+xh8aKqhx35EhB94q4yYfHsfSQvWczW6QIvnaPmRfDzUFB6N91X6
	vSTTDUcYLMfE25o5p3fzswTUsVo21YMCABxCHmpE/TcWGI5hPqva5GYQDY7ecZY1
	slt/A==
X-ME-Sender: <xms:9Eo1Z758pQf6InpYKnXwwEt7EMXjejloOSszENgi4ryi_pyS0duS_g>
    <xme:9Eo1Zw7tpvp8q1SPr93WwNy8c8ddO-BwfGhMBwSojDw6N1xT15Xigbr6nDFFyOYZG
    raeoHe1mvGiKqo-rMM>
X-ME-Received: <xmr:9Eo1ZyfbVVaAoquEZTKW_OfH-Gww4Vs1oa03BMqiqcYuPvhQtH6ABrb7p0zpAr3wkkH--10WF7qE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddugddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecu
    hfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepiedtfeekteelvdelveevueeu
    jeffuefguedvteekveejjeeutedufeethffgheehnecuvehluhhsthgvrhfuihiivgepud
    enucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhishhtrghirhdv
    fedrmhgvpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghpthhtohepsg
    hoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehklhhovghn
    khdruggvvhdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegrlhhitggvrhihhhhlse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopegrlhhishhtrghirhdrfhhrrghntghishes
    figutgdrtghomh
X-ME-Proxy: <xmx:9Eo1Z8LFSgT4plqM-AJ9yyfX7xRD-CE0RtbZsBpZmVmOWciD_Sr9uQ>
    <xmx:9Eo1Z_JDnsiw99F6WApZC4Pd1y49RQ5b0Q6mUWHLBM00t7mrb59aCQ>
    <xmx:9Eo1Z1z2bJyBEtpi_rbC6kmzd3XGGYnp0Zob8qRzWUWFShQYz3y1-A>
    <xmx:9Eo1Z7IeKdcDBZSy0r9jW2pTZ-kjmqj3M4ZEi_lJnbW7OWuDrnGZzA>
    <xmx:9Eo1Z46klC31nZhPmnxxg4taJlfuAAorOLZOCMRQqobX67V3DyebFGFV>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 19:57:20 -0500 (EST)
From: Alistair Francis <alistair@alistair23.me>
To: linux-kernel@vger.kernel.org,
	benno.lossin@proton.me,
	boqun.feng@gmail.com,
	me@kloenk.dev,
	alex.gaynor@gmail.com,
	a.hindborg@kernel.org,
	gary@garyguo.net,
	aliceryhl@google.com,
	alistair.francis@wdc.com,
	bjorn3_gh@protonmail.com,
	tmgross@umich.edu,
	rust-for-linux@vger.kernel.org,
	ojeda@kernel.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair@alistair23.me>,
	Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH v4 08/11] rust: helpers: Remove signal helper
Date: Thu, 14 Nov 2024 10:56:28 +1000
Message-ID: <20241114005631.818440-9-alistair@alistair23.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114005631.818440-1-alistair@alistair23.me>
References: <20241114005631.818440-1-alistair@alistair23.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we support wrap-static-fns we no longer need the custom helper.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
---
 rust/bindgen_static_functions   | 2 ++
 rust/bindings/bindings_helper.h | 1 +
 rust/helpers/helpers.c          | 1 -
 rust/helpers/signal.c           | 8 --------
 4 files changed, 3 insertions(+), 9 deletions(-)
 delete mode 100644 rust/helpers/signal.c

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index 9c40a867a64d..407dd091ddec 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -18,3 +18,5 @@
 
 --allowlist-function refcount_inc
 --allowlist-function refcount_dec_and_test
+
+--allowlist-function signal_pending
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index d7591b709407..e21a5f260e3c 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -21,6 +21,7 @@
 #include <linux/rbtree.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
+#include <linux/sched/signal.h>
 #include <linux/slab.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 39adea78a647..ebe3a85c7210 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -13,7 +13,6 @@
 #include "mutex.c"
 #include "page.c"
 #include "refcount.c"
-#include "signal.c"
 #include "slab.c"
 #include "spinlock.c"
 #include "task.c"
diff --git a/rust/helpers/signal.c b/rust/helpers/signal.c
deleted file mode 100644
index 1a6bbe9438e2..000000000000
--- a/rust/helpers/signal.c
+++ /dev/null
@@ -1,8 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/sched/signal.h>
-
-int rust_helper_signal_pending(struct task_struct *t)
-{
-	return signal_pending(t);
-}
-- 
2.47.0


