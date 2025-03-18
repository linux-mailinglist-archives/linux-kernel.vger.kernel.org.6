Return-Path: <linux-kernel+bounces-566657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDF2A67AC7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68FB87AB254
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97449212D62;
	Tue, 18 Mar 2025 17:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="qnLElu9E"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D0F212B02
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 17:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318680; cv=none; b=uTl5ygQ9tnuWl03bgzgwd/1oRRm5ZgnyN+6RhABtBYTzrV8G61MzXhwKFljEvESMZ17yZQcUtCAN++hLZuGawU2e313+n4WkU6ojcKoB9+8MW2o/+jBMxJtFMbmXj0wJuEbIK/q5SCvaE1wHQPBIp6IhX79f0n+JklOrm1pNZCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318680; c=relaxed/simple;
	bh=arLRdeAj2X4jGwyV1sS94yTtjMV3IKzaSI64aaRjsqs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mTODmUXIaEJQAb6xbB9A3YFQHcEkN229qeukIJkK7YgDFx0lHVJJN8aqd/b7F4GzNuwAmA9eF3GhHZWJFv2OAFjQSLOsu3ds0EPA3buEM4E7IFoA6oLO3CHlAt7S0iwgH6pda3FeCra8AUSXy/gsgx5fYbmE3EDET0CddELuLlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=qnLElu9E; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=mSEPHc8h/ptNs+ekQGU1f4L0UyHsehJeo7VUYZakk3s=; b=qnLElu9Emwdk5sltmdcV+Fd4I5
	wxBNHLyJiBpC7pY2UauzeV4kdW9aS4X3p71TWwJ5CWEEwehkgntMm4MgEXsJ1lslshD2RYgy3OfLx
	K+BNwQN9JUP+0BZafww0J8hCVx07A2lWbvQRhk5ANir5SvHjrrVXGH5lgxMt3vDhu17L2/g9m3Z5w
	iibxBmKODVGlnIjgEE/THyycjCXmTF99XcWwGJgQXGGiYUjql4CM2F3/0ceB44YtLQTvj3BmesPWF
	2/+4O1xaO4xwCM884RIE2wMqOPID83LYj6uGbWkg6/0r0UMeQqn8pPH1APysy7q5sfJ8htFACJDZw
	qbjhw14A==;
Received: from 179-125-64-250-dinamico.pombonet.net.br ([179.125.64.250] helo=[192.168.67.187])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tuaft-002qwX-Oz; Tue, 18 Mar 2025 18:24:22 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH v3 0/2] char: misc: improve test and dynamic allocation
Date: Tue, 18 Mar 2025 14:24:17 -0300
Message-Id: <20250318-misc-dynrange-v3-0-5c6507cbc2e2@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEGs2WcC/3WOwQ6CMBBEf4X0bLUUSgMn/8NwKGULmwhoC42E8
 O8WMHrytrOTeTMLcWARHCmihVjw6HDog0hOEdGt6hugWAdNOOOCJUzSDp2m9dzb3axFqnOuBCR
 xTkLmYcHga+fdyqBbdONg5x3v+fb9R/KcMpoZiHOWcDAyu2Kj7qjOeuhIuR5sC88pTByPgt/CI
 jqo8YeqW1uDpxXPKiG5SqXRhY+3gZVyQAOyw7GIQt7ugcv3onfsJxcK1zeAweHmGwEAAA==
X-Change-ID: 20250307-misc-dynrange-d54c92a5e319
To: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Dirk VanDerMerwe <dirk.vandermerwe@sophos.com>, 
 Vimal Agrawal <vimal.agrawal@sophos.com>, linux-kernel@vger.kernel.org, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, kernel-dev@igalia.com
X-Mailer: b4 0.14.2

This includes a change that prevents dynamic allocation from using a minor
number that belongs to the historically static reserved range, which is
still used by some drivers.

It also improves the test, including a lot of corner cases, specially ones
that would fail before past fixes.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
Changes in v3:
- remove code around DYNAMIC_MINORS and the backwards allocation
- try to open devices in tests by using init_mknod plus filp_open
- Link to v2: https://lore.kernel.org/r/20250307-misc-dynrange-v2-0-6fe19032ef76@igalia.com

---
Thadeu Lima de Souza Cascardo (2):
      char: misc: restrict the dynamic range to exclude reserved minors
      char: misc: add test cases

 drivers/char/misc.c             |  28 +-
 drivers/misc/misc_minor_kunit.c | 578 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 581 insertions(+), 25 deletions(-)
---
base-commit: 2dc25093218f5d42391549de6fe45e1aa9325676
change-id: 20250307-misc-dynrange-d54c92a5e319
prerequisite-change-id: 20250317-misc-chrdev-b26b572a47fc:v1
prerequisite-patch-id: d60dd6f7235bae2a8707c3169969b534be60de52

Best regards,
-- 
Thadeu Lima de Souza Cascardo <cascardo@igalia.com>


