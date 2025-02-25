Return-Path: <linux-kernel+bounces-530869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFE8A43982
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 471CE16DE78
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295832638BA;
	Tue, 25 Feb 2025 09:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qtzOxqD9"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5602638A8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740475876; cv=none; b=YLH4WhBy3+ggwpou5nUhqjjZ/TiPfX1p6yPmN4d2UkTFi5KttND6JO/Q7KdoJZ1JE02u25QqsjNs8wXgRIS9ObfMWmO+7tJarfvFZ4spNpLsxgjtDdCHIqzvUDiafEPuDImkwJ0TEG7aa8Aqiz0XseecmRGb0Th7ZIuxybei0IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740475876; c=relaxed/simple;
	bh=gwp2fuJXCL/bjNIarZEPkgmjBf8NLWIelOI9giPWV8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B3cCY2MmWrsrsK9LBcOh6Xka0TfcD6pUcaomlbvRQJmUL2AA0e4YRzPJGcPHeEzKkkRDsnjnK6vjPAp9cKjaZ2Zp9HZzkQTlagWAQWDbnwvrIGkpqJ9sgIatInfoEtKAzF0xoNoSQvfINndmtayP36oJLUEBO23ZjB1rl1qaEB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qtzOxqD9; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740475861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=isPQgwurSdwU4T9ma6rP9Qtz5aT2veuB9Ji0NyBAn4o=;
	b=qtzOxqD9Ri5jjb902pbFYhzZ6EzVrV12wtzG47jsrGdYj7Sg2QCW9dKlkagI5EIv5pRgIL
	0g/P6xRW1qyAchXbFS0h7FAm1hB6JpPmn0JKgQfczdufF5Wi8ps59ZhbGhrCUjhudYqvCe
	xpdRdnUOV+AyDBIb+ndHJknC6QocUWk=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-hardening@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: Replace deprecated strncpy() with strscpy_pad()
Date: Tue, 25 Feb 2025 10:29:49 +0100
Message-ID: <20250225092949.287300-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strncpy() is deprecated for NUL-terminated destination buffers. Use
strscpy_pad() instead and don't zero-initialize the param array.

Compile-tested only.

Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/btrfs/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 53b846d99ece..b941fb37776d 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1330,13 +1330,13 @@ MODULE_PARM_DESC(read_policy,
 
 int btrfs_read_policy_to_enum(const char *str, s64 *value_ret)
 {
-	char param[32] = { 0 };
+	char param[32];
 	char __maybe_unused *value_str;
 
 	if (!str || strlen(str) == 0)
 		return 0;
 
-	strncpy(param, str, sizeof(param) - 1);
+	strscpy_pad(param, str);
 
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
 	/* Separate value from input in policy:value format. */
-- 
2.48.1


