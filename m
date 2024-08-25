Return-Path: <linux-kernel+bounces-300587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1835895E58A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 00:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBDF1B2103A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 22:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E02768FD;
	Sun, 25 Aug 2024 22:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIS2iJ4B"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89666A59;
	Sun, 25 Aug 2024 22:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724624302; cv=none; b=j3VcJqr3ZJbhoLZdZdNodK//2l5nLsZnayu/UrSoQZnKR8Tub/YB5vlNC5r/SWvEX7MK04VZj5SK1FIjLLXToHT+AQLEl9bhRJUl07g/W/YBTNgY4yVsvuJOz//5JGkpnxn2bPkf+yHPszF6fnw9BHAZ40B250SCUFsH+U+4SVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724624302; c=relaxed/simple;
	bh=5ekFjRBtJKPOG5J1wWuaNXzK4ftoiazTVmxjMa/yAx4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gtEEJsqQRY9mFVFodqfKuhrUcmr3NAoI4WoPMrKEFoYeRz6KcP7Tw8/RR2pb2fyEWFZnCzOn5YFholSFF7D5D6JsLO5PgkIFBlWYvXY0aTO/7UFuX+Izvflp3g8WF0qf7Cbtk5+NIx2CjtcfC7EOesmovxmtXj09JsT9D9fPpy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIS2iJ4B; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d5f5d8cc01so2479156a91.0;
        Sun, 25 Aug 2024 15:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724624300; x=1725229100; darn=vger.kernel.org;
        h=content-transfer-encoding:commitdate:commit:author:mime-version
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxSO7Y7sQcoVtzlhv2475A8WaZBGnuNjsf3DbVh8XIk=;
        b=OIS2iJ4B5DutqtXfk38JH7qoF0bnPh7C1OA027D/HmnSZG8uh9iDVvEaxVydA6v6o0
         Z9e8oFkD8rplIs+BOKQB3vzp+PBLVwH+KhiSohW8PWXZsgvIc5qdF2QKqaWXjLdMyWPQ
         yMbtWgMXMg24R6OokFE7rWRGrKLAXyBR9AXhm27UyaHsqiVXIFq7DOI3dIGOGwzkO6RR
         R4MO7Aa1ZfGtTi7nbOgvHN5vN7QVe8Zxn+6fQVZWQOJeNIy8Oa5CzYctk1PYTiKi/F1O
         GVxy9ib4Xl0ILCZi8hKf6kSac9GUuQ3b6ha1gPGNPcqedrT0XHzVkb6VLhhcR/jg2bTj
         /XQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724624300; x=1725229100;
        h=content-transfer-encoding:commitdate:commit:author:mime-version
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JxSO7Y7sQcoVtzlhv2475A8WaZBGnuNjsf3DbVh8XIk=;
        b=JWt7Sc77rG63W9rCXSKhdvR9wUk7aQM7rSoFa6BiQXJa7IRtaWbRIH5d2VEuSnue9n
         +/g0PR0LnG194D6Lpyv/CzDY6CVcvbSjP0PeVxrJBfznAm8g/RXXUq+U4YUe2z5b4WSU
         D+iqakWubDxO+if8Yrxp/jWFOkJnmc8R3M9d1Z0xJAHJkcCB/LOD5g7dZuiuo6Ll95D8
         iHaTwV07bUrH2ErOTeFpH25wf0cU0d7Ncj10fnt7ZaaO8nCA1Gt0ltJtFtC/xbJg4VZd
         klrFEbjagjQk2i2vbHyz4SJ0791aIGBu4Oz6CfYZ3qIDl1hquy5vaa5c9Pusz4i6gbhD
         JD4g==
X-Gm-Message-State: AOJu0YyywJEvs+4WbbwksCkJ/Dyy+ajH6nLb2E867fRUX0lV1fT7OK8L
	7wlfZoDeQmxRmZ3lXv8vXKaM2f8rd4gv5I6OeZTioHIIWC9W72SbWHxIZ1gljLw=
X-Google-Smtp-Source: AGHT+IG3Fr3DAUBPj8GLPNAm4ks3rzwBvIKqJb+swgsVGZLMVVTVWNSSmWBmlhUSK6XYv/MmSYZ9JA==
X-Received: by 2002:a17:90a:eb0c:b0:2c8:4250:66a1 with SMTP id 98e67ed59e1d1-2d60a8cb57fmr20610762a91.3.1724624300395;
        Sun, 25 Aug 2024 15:18:20 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:f022:f804:2fa2:fde0:4987:3a52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eb8d235esm10740916a91.6.2024.08.25.15.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 15:18:20 -0700 (PDT)
From: Siddharth Menon <simeddon@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	apw@canonical.com,
	joe@perches.com,
	ojeda@kernel.org,
	Siddharth Menon <simeddon@gmail.com>
Subject: [PATCH] scripts/checkpatch.pl: check for non-permalinks to Zulip
Date: Mon, 26 Aug 2024 03:48:06 +0530
Message-Id: <20240825221806.253575-1-simeddon@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Author:     Siddharth Menon <simeddon@gmail.com>
Commit:     6bf3f9e0aa813d96a096961c3e317d08654f6126
CommitDate: Mon Aug 26 03:34:23 2024 +0530
Content-Transfer-Encoding: 8bit

Zulip links to https://rust-for-linux.zulipchat.com can break in
case of renaming the topic or channel if they are not a message
links (which are permalinks).

If a non-permanent zulip link is referenced emit a warning and
directs to the zulip documentation.

permanent links are of the format:
https://.../#narrow/stream/x/topic/x/near/<numerical_id>

Reported-by: ojeda@kernel.org
Closes: https://github.com/Rust-for-Linux/linux/issues/110
Signed-off-by: Siddharth Menon <simeddon@gmail.com>
---
 scripts/checkpatch.pl | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 39032224d504..a4fb4e724f75 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -735,6 +735,10 @@ our $obsolete_archives = qr{(?xi:
 	\Qspinics.net\E
 )};
 
+our $zulip_forums = qr{(?xi:
+	\Qrust-for-linux.zulipchat.com\E
+)};
+
 our @typeListMisordered = (
 	qr{char\s+(?:un)?signed},
 	qr{int\s+(?:(?:un)?signed\s+)?short\s},
@@ -3415,6 +3419,12 @@ sub process {
 			     "Use lore.kernel.org archive links when possible - see https://lore.kernel.org/lists.html\n" . $herecurr);
 		}
 
+# Check for permanent Zulip URL
+		if ($rawline =~ m{http.*\b$zulip_forums(?!(?:/#narrow/stream/.+/topic/.+/(?:near|with)/\d+)?($|\s+.*))}) {
+			WARN("PREFER_PERMANENT_URL",
+			     "Use permanent Zulip links when possible - see https://chat.zulip.org/api/construct-narrow#narrows-that-use-ids\n" . $herecurr);
+		}
+
 # Check for added, moved or deleted files
 		if (!$reported_maintainer_file && !$in_commit_log &&
 		    ($line =~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||
-- 
2.39.2


