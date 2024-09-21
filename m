Return-Path: <linux-kernel+bounces-334803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61CB97DC60
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 11:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60BD9B218D5
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 09:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825D815442D;
	Sat, 21 Sep 2024 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oD4XUmWn"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC83A3307B
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 09:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726910988; cv=none; b=cr5RF4h2U6ztyoBvXYOHIx42ynv4UQzYBle1tDbGixxrytzgtaRL+DRY2xSZ05m8X3FZTv7joZcgOIUkRvKQ4DnIKWJYX7tec5SlkW53Cd/BT424pzcuRYa/q51fSCLzN717vvQiLXt6Wwh5782rX4LSkL9Ch2+Q9Wl4h9+psOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726910988; c=relaxed/simple;
	bh=4CMzWwyBbEA/QGOzl5yCwg8tfyMMe4rT+UxbNkCq54E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WyYLlckzfdf9tIT+Iwa3/xlLY033WrUS0zIJ2nsU+g77tkRDBT9ip914sB9l8kJUBX8oi+f8Gd50o2IDIiEoDOcVtpG9VfTY/kH9IH7ZrY4SW19npHjaYaxkZ6cbxwZjGkquWHLbnubLSM456EEJhk0bfifBVQo067oUYLEQprk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oD4XUmWn; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726910983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gBl8or4Ji2nkkiH+xf10UJGYzYgFHK0HBHx4Lx5YdmE=;
	b=oD4XUmWncu0MlYmm31SVFad4xTZxBA+//BPm98tguu++ZzKVQvFTqnJqwAB9dvdREpxK5m
	ayYOVMc9DT42DQakR43AUVIaZ8fXCUByr3UzXLWm4E8ddbnnvui4F/7+iMaUmI3UIXpFGn
	QkNBfn21TJEcOJZxiRFUz2J6rsPiJ2E=
From: Wen Yang <wen.yang@linux.dev>
To: "Eric W . Biederman" <ebiederm@xmission.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>
Cc: Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v4 0/5] sysctl: encode the min/max values directly in the table entry
Date: Sat, 21 Sep 2024 17:28:59 +0800
Message-Id: <cover.1726910671.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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


