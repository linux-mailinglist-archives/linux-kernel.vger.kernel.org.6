Return-Path: <linux-kernel+bounces-346111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F09698BFBB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0FBA1C24014
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F89A1C6F5F;
	Tue,  1 Oct 2024 14:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Ut8L1CSX"
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A291C6F73
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727792371; cv=none; b=qdT4neLON8dG8mwXrCZMt4lrtyziI5Y3zwgDTPBtGk9rBpiKEf2w74ur0zuBrE2vmilJxMqG5CYahxjuZ9JLrDyrzmqpxY3ORbcpT4UpJRM1Qh9UnLgq2zx3cAHwA0mlq56MyEvhy6a4/ICCXj2WaV0N4bl6NsNcdoIo1y1Y92s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727792371; c=relaxed/simple;
	bh=N3VsT/aRIrZo7RNF5L0dZF4glg3oLt0KJkLSq216upU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ktzkXUbP6ZxIa5KTeB0OWb9MJrAgAbP+tz3h/8JW/QcYaBbYkGMFW1W+QRWUkkCtD29x1PnDWqlgHY9xfjjTvBItTpZBTcegF3tCUFmlOlnXw8ZHzt8ESFKV2oYJMU9BqGd8w/Ss3cMZt5lIxz1ZCUaUeEEuiUqCpeYRoMfRNvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Ut8L1CSX; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XJ0JV4d0Kz2Td;
	Tue,  1 Oct 2024 16:12:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1727791962;
	bh=wdaQ4HNfZ3uEX8A3QKomp7kIV90mH4kYU36cEBiD3J4=;
	h=From:To:Cc:Subject:Date:From;
	b=Ut8L1CSXZhUpZ2f0Qb07SY8PtV++HvbIfFYgglxb9Xy4CzCq5QqkqOcJayM56UjrV
	 b3W1z8p/mcJqLrNnwNellTY1kJhzdcyI4fQHj2KCR2aQh3zFIMa+Fo0UXxx+XxGAom
	 ZZUu+GNDpST8tcFcv93rSEo74pbYMfDWwQheTBN0=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XJ0JT6PYDznvr;
	Tue,  1 Oct 2024 16:12:41 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Paul Moore <paul@paul-moore.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v1 0/3] Refactor Landlock access mask management
Date: Tue,  1 Oct 2024 16:12:31 +0200
Message-ID: <20241001141234.397649-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi,

To simplify code for new access types [1], add 2 new helpers:
- landlock_merge_access_masks()
- landlock_filter_access_masks()

The last patch uses these helpers to optimize Landlock scope management
like with filesystem and network access checks.

[1] https://lore.kernel.org/r/3433b163-2371-e679-cc8a-e540a0218bca@huawei-partners.com

Regards,

Mickaël Salaün (3):
  landlock: Refactor filesystem access mask management
  landlock: Refactor network access mask management
  landlock: Optimize scope enforcement

 security/landlock/fs.c       | 21 ++++-----------
 security/landlock/net.c      | 22 ++++------------
 security/landlock/ruleset.h  | 51 +++++++++++++++++++++++++++---------
 security/landlock/syscalls.c |  2 +-
 security/landlock/task.c     | 22 +++++++++++++---
 5 files changed, 68 insertions(+), 50 deletions(-)


base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
-- 
2.46.1


