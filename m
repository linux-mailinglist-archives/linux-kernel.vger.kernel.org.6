Return-Path: <linux-kernel+bounces-227428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBAB915116
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99A62B24567
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DC519D088;
	Mon, 24 Jun 2024 14:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PADTDCfv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GUWUdew6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0AB19B5AA
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240861; cv=none; b=kO0IcTHj8xFqgdPg1cYNuoB7SiGoSQQP20QH8LpCBZfNiQw0xKvVQtconcu2N9mE50dBMCxcCOMhJfGC7cU9yml7xDLXiVGNrVPyocfQxrhnlJ1ZnRbE0briJFrapE+vKuYBfY2uzTlZ1Dq33MJ+jdEzILILQJ0N53CfCqJ8U3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240861; c=relaxed/simple;
	bh=trZM8R7DoarjI8SaOB187M7Us4yWWK6gaFKH49ypgWE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tEfHFKQ7rUZ2/Q1v66gqsreOnz7bwbd9//gL392TZyPYLK5kLEcBfJlquF5/OEPz+l5IlmSLhPewIgQxHiIBQD2zcHrd4GJg5JDzl35oc7iqbVzMsyekAFqw3WGGixv++F02Ia6KOTNvd+lCJgHVg/2xrEqcfORigcxP0eSohu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PADTDCfv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GUWUdew6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719240857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QdDkM9MMzZwt+lqTaUX2iXhM7rchJJ4GVD5AtbkakpU=;
	b=PADTDCfvQYGAXCtw8bQCjA/JfJ3z0qluiOxVdmYJl9Jc4FIZ6RPFuHy4GHOo71AwVs5r5G
	RJxz4OxQanaxxCB7ytixYc2aYc2rpqOVsyq0xyg3ckK9AKaKiUFDiF48P7PuXFfZVxJEQo
	h2hjl+Imzfmhu28Z1f19o3qu4PGVdOkJlo5bxTB6I0p0S4gDBKuN1SAiVZzDtHKd66ALGA
	CHomNjIlONM3I/2oDgUM4qypooHbB+azv78muxL/heg95RtTYSZM5+klZZnz7LmoI8Oe3/
	BSzJb/82/craIyG/TmZJmt/cifPQA20Kl2ufeLAnlzfcBVd51zexHyjsjolScw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719240857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QdDkM9MMzZwt+lqTaUX2iXhM7rchJJ4GVD5AtbkakpU=;
	b=GUWUdew6js/pef5V9uaQNhhj4qcKq7IxYUsebrYOs892UtOfk7xPt2HKtD5SbvjTbqIpGd
	CNcwSZXF9MZthZDQ==
Subject: [PATCH v2 0/5] timer_migration: Fix two possible races and an
 improvement
Date: Mon, 24 Jun 2024 16:53:52 +0200
Message-Id: <20240624-tmigr-fixes-v2-0-3eb4c0604790@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAICIeWYC/22MQQ7CIBBFr9LMWgxM0KIr72G6aGDaTqJgAElNw
 93Frl2+//PeBokiU4Jrt0GkwomDb4CHDuwy+pkEu8aAErU8oxL5yXMUE6+UhEN7UhNqddEWmvG
 KtB9NuA+NF045xM8eL+q3/u8UJaQw1ozoDBnX97cH+3eOwfN6dARDrfUL3WIXbKoAAAA=
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>

Borislav reported a warning in timer migration deactive path

  https://lore.kernel.org/r/20240612090347.GBZmlkc5PwlVpOG6vT@fat_crate.local

Sadly it doesn't reproduce directly. But with the change of timing (by
adding a trace prinkt before the warning), it is possible to trigger the
warning reliable at least in my test setup. The problem here is a racy
check agains group->parent pointer. This is also used in other places in
the code and fixing this racy usage is adressed by the first patch.

There was another race reported by Frederic in setup path:

  https://lore.kernel.org/r/ZnWOswTMML6ShzYO@localhost.localdomain

It is addressed patch 2-4. Patch 2 is an already existing patch of v1
(improve tracing) and makes the fix easier. Patch 3 is also a preparation
patch for the final fix and Patch 4 is then the real fix. (I labelled all
those three patches with Fixes tag to be easier selectable.)

While working with the code, I saw that the update of per cpu group wakeup
value could be improved. This improvement is adressed by the last patch.

Patches are available here:

  https://git.kernel.org/pub/scm/linux/kernel/git/anna-maria/linux-devel.git timers/misc

---
Changes in v2:

- Address another possible race in setup code (reported by Frederic) and
  recycle therefore one improvement patch
- Change order and move the already existing improvement patch to the end
  of the queue
- Existing patches didn't change
- Link to v1: https://lore.kernel.org/r/20240621-tmigr-fixes-v1-0-8c8a2d8e8d77@linutronix.de

Thanks,

        Anna-Maria

---
Anna-Maria Behnsen (5):
      timer_migration: Do not rely always on group->parent
      timer_migration: Improve tracing
      timer_migration: Split out state update of tmigr_active_up()
      timer_migration: Fix possible race in tmigr_active_up() in setup path
      timer_migration: Spare write when nothing changed

 kernel/time/timer_migration.c | 137 ++++++++++++++++++++++++------------------
 kernel/time/timer_migration.h |  12 +++-
 2 files changed, 90 insertions(+), 59 deletions(-)


