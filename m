Return-Path: <linux-kernel+bounces-355488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF33199530F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7B001C24952
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DD91E0082;
	Tue,  8 Oct 2024 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XKe4SP9T"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D6D1DFDAB
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 15:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728400488; cv=none; b=oOvFPMmQsABi7TxjjumTKifQqCMTc5pSDA9Jrr5einM5BIctXzdZkdoo8/d6/BgymECHkZIwNTXwLg1qlXnk/Q7isQVDxsBdxvIzmtGfl9Gg5onEKcKlYwwjNNn7Ou7IVoEwYv7vJ1i6ajp/tVzQ+7rRuTRYo09svbsn5bsD8zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728400488; c=relaxed/simple;
	bh=4CMzWwyBbEA/QGOzl5yCwg8tfyMMe4rT+UxbNkCq54E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PTiDEFkmQUcQqJD4DCuZFbw5kBMI0kwU0cEIALAjjjZCkVMMlIh/VDSaDsivop6nC59OcUf3/2Z4gQQmCdhjMSWGQDNMC+sxqMLdg9U29PeGVyTso9sxYJWAk8iUoicvfu0x4S+DYnx5oxozU2i2lstUTHLqDAphQAtYu1sEBdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XKe4SP9T; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728400484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gBl8or4Ji2nkkiH+xf10UJGYzYgFHK0HBHx4Lx5YdmE=;
	b=XKe4SP9TUVXTWw/pUtOsHX9ZQXpgCl/Q2Mv86E/e0VzhRpe5wXEDXYRLm7Ri2IE6D7q/Ol
	vB0V93lDp+3fFKfq2Y/JopIwxZpAprH9xR1M/7WMwQdqGkeHqp7HI1x3yyRfO57iurowAH
	yzbRxN28YwosyUI4JMI53EpCf9FkaYg=
From: Wen Yang <wen.yang@linux.dev>
To: Joel Granados <j.granados@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>
Cc: "Eric W . Biederman" <ebiederm@xmission.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [RESEND PATCH v4 0/5] sysctl: encode the min/max values directly in the table entry
Date: Tue,  8 Oct 2024 23:14:03 +0800
Message-Id: <cover.1726907948.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Many modules use these additional static/global variables (such as
two_five_five, n_65535, ue_int_max, etc.) in the boundary checking of
sysctl, and they are read-only and never changed.

Eric points out: "by turning .extra1 and .extra2 into longs instead of
keeping them as pointers and needing constants to be pointed at somewhere
.. The only people I can see who find a significant benefit by
consolidating all of the constants into one place are people who know how
to stomp kernel memory."

This patch series achieves direct encoding values in table entries and still
maintains compatibility with existing extra1/extra2 pointers.
Afterwards, we can remove these unnecessary static variables progressively and
also gradually kill the shared const array.

v3: https://lore.kernel.org/all/cover.1726365007.git.wen.yang@linux.dev/
v2: https://lore.kernel.org/all/tencent_143077FB953D8B549153BB07F54C5AA4870A@qq.com/
v1: https://lore.kernel.org/all/tencent_95D22FF919A42A99DA3C886B322CBD983905@qq.com/

Wen Yang (5):
  sysctl: add helper functions to extract table->extra1/extra2
  sysctl: support encoding values directly in the table entry
  sysctl: add kunit test code to check the min/max encoding of sysctl
    table entries
  sysctl: delete mmap_rnd_bits_{min/max} and
    mmap_rnd_compat_bits_{min/max} to save 16 bytes
  sysctl: delete six_hundred_forty_kb to save 4 bytes

 fs/proc/proc_sysctl.c  |  29 +-
 include/linux/mm.h     |   4 -
 include/linux/sysctl.h |  64 ++++-
 kernel/sysctl-test.c   | 581 +++++++++++++++++++++++++++++++++++++++++
 kernel/sysctl.c        |  45 ++--
 mm/mmap.c              |   4 -
 6 files changed, 677 insertions(+), 50 deletions(-)

-- 
2.25.1


