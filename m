Return-Path: <linux-kernel+bounces-431992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CC99E4391
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 340292811FD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D5F1A8F93;
	Wed,  4 Dec 2024 18:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABKjWSJe"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CCB1A8F7C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 18:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733337681; cv=none; b=FaeexPiA75lgKOI4UhHjum9486YOLJqPHefcAzHwGf7YzRTgcqYGIAWG0r3smOoLpoPF+QqCShPv0Z4O1USeJFWRU1Ln0/Co1CaZPlzbREcSco7hvg16trClkGNnUkTecH6dc5glU+gPwaGjhr3WSQ21/R0YiP1JTEkyYtNUgvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733337681; c=relaxed/simple;
	bh=aFvkf6CoLhhQD1bUAXfhKyLoVgb7mHgs8SfvSrpcRyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=k7A2Cj52+qz7it9MaGlc3TtKboCCcVTM25/ucBi3i2bS4EUaIRDJBpTb8mI1dhjmwIH8mR7VezqtfJLT7uJhjW1fAptu/iiLz7PEGCaVc1JKsSIWvvsPsGBbEQNK1X5WiAMC5++iC+IAaVHTo34/luSmUiu/kfg5gjR+4/Ke4QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABKjWSJe; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46695dd02e8so134211cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 10:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733337679; x=1733942479; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P1AAYwi8Z4SqDfUi5bpBNtYcExyup2ajr9ZSuxLD3q4=;
        b=ABKjWSJeFFCXrLLQuIVXueYynDDfVa+szJOloA+cFP2ZTY4Mc0KtlGUEe8gambI6QF
         LgOeoeoES72+JV377ZFaoIUuqRQHwwNX6m8eQyEWj92IcWLdneTfGWUHrEF2ONyop5WL
         OjrPcm2Fcd/yAKf7Eb4ZRN77l6mitvVh0+mhXtIyf02nbfV5e58ev/JatZs2WDvJHCSD
         BfAN7CxVMaoI+lF2pQtWqwxeoSIs3lGgCX3a/6/lTukOlanMMdDWYEk2lUJIrztJLOFm
         jpeQumX6H82qLgfzUglgSfzUZYzs/8O6cuoM0r3L96MhEIc+ZzEN81KFaNF+AYsP3BLv
         F6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733337679; x=1733942479;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P1AAYwi8Z4SqDfUi5bpBNtYcExyup2ajr9ZSuxLD3q4=;
        b=nnypMNtDC6LWiCfCDYaEf2hq8/Uy+0KwJbI8vKLbI6KCjUZFo6fdOEHKCWRqSk/y1N
         NW3Cq7zadrFJHm23/cLTog0Tp25UBl5WCh8RS7XLlrqrJK6J7OQ7s/LI7kgiddClh0Ik
         K3soTw4lYCxvekjDiC57FSWEiWdRNpaDckmjV64rsXaXCINzOS2L1al5keIcAg7FGWdv
         MHSLM9sLQQBiOvtE2yHNlzcWM/VmG/1HBfzF0DpeH5gYJVSxB0ZOt4k6cyvr8LI/E73H
         GWATdEgDVhBgVW2lA2GHyEzDaSK5mijMumBmVtthV1r8TZBs4r9Q9chA/uzydyLNa2HM
         MGAw==
X-Gm-Message-State: AOJu0Yy8ykAVF9qk1ykuMH0IH7FzPlFJB46odX0EiXRf2X4l4APmvQFd
	7EX1ytAzU5Lu7OfSRBb453HrR4SybFzm+0nWmSqBuC3UAHUAl4y+ZLE9vxwh
X-Gm-Gg: ASbGncsnS/wQFStXG75/LMbuVh5HI/9xzXTrSJhPJilFdbcQbJK2nMjakXgvmtxOWRo
	L1CgcCBJ7ZxSUD8Oevh85t/41SmfLSbUvByPG0aHWmtXOcZ5CJzCHevmZh4GRWZ6YwUwlusQiX1
	snklIvbhf2zpTwo4tlUDhaNVcdD13gUEBZO0EvZbM4YqWAardG+mJw7cNdbUtgNh0zUr9NPmZWg
	P1sNU5mp0lJLcWrm+08og6PBabWwUjuBbuTKjXD+5SQYPDTN/DlaTghIle0PKqLOdTP/ViMyQq5
	LEbF2TPnQCo=
X-Google-Smtp-Source: AGHT+IF2hEzFNib6Ma+PiwJlxiujxiSoOivETzyDigbmywVRpr/Lh7ZBMq7eDwaB/6PGZxo5nZYjzw==
X-Received: by 2002:a05:622a:188b:b0:466:92ff:dc48 with SMTP id d75a77b69052e-46717ce5b2cmr88419661cf.53.1733337678799;
        Wed, 04 Dec 2024 10:41:18 -0800 (PST)
Received: from 159.1.168.192.in-addr.arpa ([2600:4041:5be7:7c00:7154:df0a:6071:bff8])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466c4066934sm76718431cf.25.2024.12.04.10.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 10:41:17 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 04 Dec 2024 13:41:06 -0500
Subject: [PATCH] checkpatch: check return of `git_commit_info`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-checkpatch-missing-commit-v1-1-68b34c94944e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAEGiUGcC/x3MwQqDMAyA4VeRnBdog8Lmq8gOmmZtGK3SiAjiu
 6/s+B3+/wKTqmIwdhdUOdR0LQ3+0QGnuURBDc1AjnpPrkdOwt9t3jlhVjMtEXnNWXek5zK8/DJ
 QCB5av1X56Pl/T+/7/gEx1eGLawAAAA==
X-Change-ID: 20241204-checkpatch-missing-commit-28b591b52dd1
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
 Dwaipayan Ray <dwaipayanray1@gmail.com>, 
 Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-kernel@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Avoid string concatenation with an undefined variable when a reference
to a missing commit is contained in a `Fixes` tag.

Given this patch:

: From: Tamir Duberstein <tamird@gmail.com>
: Subject: Test patch
: Date: Fri, 25 Oct 2024 19:30:51 -0400
:
: This is a test patch.
:
: Fixes: deadbeef111
: Signed-off-by: Tamir Duberstein <tamird@gmail.com>
: --- /dev/null
: +++ b/new-file
: @@ -0,0 +1 @@
: +Test.

Before:

WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes:  ("commit title")'
WARNING: Unknown commit id 'deadbeef111', maybe rebased or not pulled?
Use of uninitialized value $cid in concatenation (.) or string at scripts/checkpatch.pl line 3242.

After:

WARNING: Unknown commit id 'deadbeef111', maybe rebased or not pulled?

This patch also reduce duplication slightly.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 scripts/checkpatch.pl | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9eed3683ad76caffbbb2418e5dbea7551d374406..14639f83be91643245bba3aea6a980d50c04b1cc 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3237,12 +3237,12 @@ sub process {
 			my ($cid, $ctitle) = git_commit_info($orig_commit, $id,
 							     $title);
 
-			if ($ctitle ne $title || $tag_case || $tag_space ||
-			    $id_length || $id_case || !$title_has_quotes) {
+			if (defined($cid) && ($ctitle ne $title || $tag_case || $tag_space || $id_length || $id_case || !$title_has_quotes)) {
+				my $fixed = "Fixes: $cid (\"$ctitle\")";
 				if (WARN("BAD_FIXES_TAG",
-				     "Please use correct Fixes: style 'Fixes: <12 chars of sha1> (\"<title line>\")' - ie: 'Fixes: $cid (\"$ctitle\")'\n" . $herecurr) &&
+				     "Please use correct Fixes: style 'Fixes: <12 chars of sha1> (\"<title line>\")' - ie: '$fixed'\n" . $herecurr) &&
 				    $fix) {
-					$fixed[$fixlinenr] = "Fixes: $cid (\"$ctitle\")";
+					$fixed[$fixlinenr] = $fixed;
 				}
 			}
 		}

---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241204-checkpatch-missing-commit-28b591b52dd1

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


