Return-Path: <linux-kernel+bounces-570639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E080A6B2E6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 03:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14FA417935F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 02:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894DF1E51F5;
	Fri, 21 Mar 2025 02:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Okax1/hB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34C81A7264
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 02:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742523951; cv=none; b=UEidhmWCk9t+Mo10s+fAVrGHBpW9QsemN0Z68dHseFMAxF75OuCE1JsjXb4OTFlccyLQKVxIbAtkQ1kq8j4scCj4LcfoP8/Fb8FVscstNeV7BuqqFr+EmOxsw2kPpIEOTbZwxUp/M/K08EE69qptvjrHgF68oNZ6D6p5GzJODJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742523951; c=relaxed/simple;
	bh=ZR+QyL/mmcCLDfu8mW93EKGe2FGOifsZ2fxtH8umCA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kXwxvTgqRl+yejzmNJ4zgRc0HP68OiYqA1raPE45BYCS77I/0aTCSAzbTj+qfIp1Qxwm2rZydzq4jAk5OjXBBNjJt5Nd/g/Veeacvw8cS5lit47QJj+r1atEdhGSzAjmpjxd3j0J5jYN/zS16AAjF/IYzSjhvvGJESN1g+HMYxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Okax1/hB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE87C4CEEA;
	Fri, 21 Mar 2025 02:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742523950;
	bh=ZR+QyL/mmcCLDfu8mW93EKGe2FGOifsZ2fxtH8umCA0=;
	h=From:To:Cc:Subject:Date:From;
	b=Okax1/hB3QOVk1AsBLWEPQQtQ/cSRhtBbwSdZw/XHOJDa+fPTbeCpQD8LzLIYMuZ1
	 5SuzaRB36UI86YluRyXm4jFa+dycbm9djxEj+ZVFSzTv7bNCGbAZMU9FsLgHL8SvtW
	 TIfKkeMkK2vPU1xdR10nRRZjxyLT3IHoNOZlO8TEnPObbWgYJAgzy9sW2VwkN0gIeK
	 W18xLqNoJWoWXN9Aaw//Zc+ZyDNl8TAHYoPqFtd4BNQczgd7pLU/R9JdabS9bX5zfG
	 e73RZ/Rmgu+ODDf+w8hkRT5HT47vJRxlnBQzEly7k96AIBKfiZ03ywrTGe86sVKbNB
	 LL0K/OkgA/+Tg==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kstrtox: Add support for enabled and disabled in kstrtobool()
Date: Thu, 20 Mar 2025 21:25:01 -0500
Message-ID: <20250321022538.1532445-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

In some places in the kernel there is a design pattern for sysfs
attributes to use kstrtobool() in store() and str_enabled_disabled()
in show().

This is counterintuitive to interact with because kstrtobool() takes
on/off but str_enabled_disabled() shows enabled/disabled. Some of those
sysfs uses could switch to str_on_off() but for some attributes
enabled/disabled really makes more sense.

Add support for kstrtobool() to accept enabled/disabled.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 lib/kstrtox.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index d586e6af5e5a6..bdde40cd69d78 100644
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -351,6 +351,8 @@ int kstrtobool(const char *s, bool *res)
 		return -EINVAL;
 
 	switch (s[0]) {
+	case 'e':
+	case 'E':
 	case 'y':
 	case 'Y':
 	case 't':
@@ -358,6 +360,8 @@ int kstrtobool(const char *s, bool *res)
 	case '1':
 		*res = true;
 		return 0;
+	case 'd':
+	case 'D':
 	case 'n':
 	case 'N':
 	case 'f':
-- 
2.43.0


