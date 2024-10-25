Return-Path: <linux-kernel+bounces-382780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F549B1363
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 01:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1986A1F22BB6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 23:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5909D20F3D3;
	Fri, 25 Oct 2024 23:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpyjumT3"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858C6217F31
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 23:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729899823; cv=none; b=GthpskX09Aw1tTAlwpiolujJ/7OXBD+ENF7hKUk+YMmpd8bRwAAcr/pNPcRb2D6oCfuAYz+fJ4SueP09dWpMwGNm+FESg0pUtfJgpnDKj7heKGCMBWAW1N0LiDkH+3s+ezaGwtdDaXh3K1kE2LolFv7a7TxNM2Zz7siZESNIK+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729899823; c=relaxed/simple;
	bh=8gJL14tqpSUx0J7z8TPjHMNCfTw5lNjiGotxtLEjlmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ubWjaa3TUnmxsmAyJLxpzB4qxSGBbmstcn1hfK34EnxQbvkFHnRbk7hsjzMnuX7j6lBIMp53cUxSnCUxLVBO/Ee3dp9n6S03bdjwacqv3MPeZDoHwR5FA6dPSQtDNtLX4e62fVF3Dds3xBRquhNyoSe+xGQ2NMgbPYB19qlBhJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpyjumT3; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6cbe9e8bbb1so15967846d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 16:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729899820; x=1730504620; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RxWL4OIhSTKFy8LC9OW379EQyPen2kJqnqwo8zzhsxA=;
        b=JpyjumT37wh/InA5jUhbPBVfM2/qQ7lqJD352bMnGhtODfeOUiNQxfkEhHMi18rTjy
         yRgoiA91AfsgamkL5eRsDSRVKTe46i4UY8X8jVm9hVBxuoswosM3sQy13cqQWQKYY+dZ
         RhJBjuWwm+HXrF5AXRBg6fJcqMPgfPoGNDFZS96lOg1uv35IENp5w7KQQDzYpS4VjJsd
         w11N1uSUzGu0IwG36gtdoO0GxG4+yUaUIus4H+AdbrGGQPK/o8LlIapcAkdLUOeMve+d
         Dvn2/iGZa9J6lfTyH71kx/2gROhXBLHW65iiTHv1TVySq7eP7fh6oymElJHle7tJ9/qp
         KE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729899820; x=1730504620;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RxWL4OIhSTKFy8LC9OW379EQyPen2kJqnqwo8zzhsxA=;
        b=gTPCxzEaPd5JF9opFX0OUCzeRkS7T6URZ8NJ1HBcwnkZtLZjQASI9F+wVFZG79ZgRW
         80uyZfuUwTYhXu6Ldph+D99SvAkMIfeFtLgAfEsr1IbNiJdGnMEbEpJtD5FZjkicj8Y7
         SObtYaP7WshtbAGwXmgGUP37rRm6R7oH5f7Vpf/TnPl/FnV82PFYsOS2gK/V8hwmVI4J
         sWWMQK32PRtkzYIZchFHsn/fbIdXf/8bmZZh4h/YI4ApHgRmXhcvQnC1b65ZOuzDfV6k
         8GSyexJXWBqFUBZY34mxasbS9DUTATrBNY+QkJT/gJkZppykyElrZ3CBJl60UNnybX5n
         p96Q==
X-Forwarded-Encrypted: i=1; AJvYcCVARwr5aPuaMaABKajNWTOpsQKQgs4hJAUAfYZbeL2bvrBlis4JXuFf9ixg3ebeVNKZxkiVXqKYUO6xtWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH47+JJ8gMB60BAq0nlkyjGavFumBirgmOheZ/cmjNGvm0XwgZ
	1MzS7q4NuzM85tnaO4+xQ+KETxkh82T4fNGX/dTLLsv+zDAQt6V8chOy2O5a
X-Google-Smtp-Source: AGHT+IEJcURQ3aUzIGlkNNTnaibhjCxFb6GgdpWladHMFimVYPl9ALP6pp1d7sGvyvOtBW8YZ6TxXw==
X-Received: by 2002:a05:6214:540c:b0:6cb:f039:85a0 with SMTP id 6a1803df08f44-6d18583d02bmr12743866d6.40.1729899820070;
        Fri, 25 Oct 2024 16:43:40 -0700 (PDT)
Received: from 156.1.168.192.in-addr.arpa (pool-100-37-170-231.nycmny.fios.verizon.net. [100.37.170.231])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d179a5927csm10219876d6.146.2024.10.25.16.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 16:43:38 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 25 Oct 2024 19:43:19 -0400
Subject: [PATCH v2] checkpatch: always parse orig_commit in fixes tag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-checkpatch-fixes-commit-v2-1-4bc4f06d37b3@gmail.com>
X-B4-Tracking: v=1; b=H4sIABYtHGcC/3WNzQ6CMBCEX4Xs2ZpuwR84+R6GQykL3SiUtIRoC
 O/uSryaOX0zmZkVEkWmBFW2QqSFE4dRwBwycN6OPSluhcFoU6DGUjlP7jHZ2XnV8YuScmEYeFb
 Waiw6Ore6yUHaU6Q9l/K9Fvac5hDf+9GCX/e3aU5/NxdUoibHrnSEl2tz6wfLz6PEUG/b9gFiO
 sfNvgAAAA==
X-Change-ID: 20241019-checkpatch-fixes-commit-aa014fe6d0b3
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
 Dwaipayan Ray <dwaipayanray1@gmail.com>, 
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Philippe Schenker <philippe.schenker@toradex.com>
Cc: Louis Peens <louis.peens@corigine.com>, linux-kernel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Do not require the presence of `$balanced_parens` to get the commit SHA;
this allows a `Fixes: deadbeef` tag to get a correct suggestion rather
than a suggestion containing a reference to HEAD.

Given this patch:
```
From c10a7d25e68ffd6222db2b63d86efa2fba04008b Mon Sep 17 00:00:00 2001
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 25 Oct 2024 19:30:51 -0400
Subject: [PATCH] Test patch

This is a test patch.

Fixes: bd17e036b495
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v2:
- Added sample input and before and after output to patch description.
- Link to v1: https://lore.kernel.org/r/20241019-checkpatch-fixes-commit-v1-1-0d0cde18ce69@gmail.com
---
 new-file | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 new-file

diff --git a/new-file b/new-file
new file mode 100644
index 000000000000..90b67dda6d59
--- /dev/null
+++ b/new-file
@@ -0,0 +1 @@
+Test.
--
2.47.0
```

Before:
```
WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes: c10a7d25e68f ("Test patch")'
Fixes: bd17e036b495

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
new file mode 100644

total: 0 errors, 2 warnings, 1 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] Test patch" has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.
```

After:
```
WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes: bd17e036b495 ("checkpatch: warn for non-standard fixes tag style")'
Fixes: bd17e036b495

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
new file mode 100644

total: 0 errors, 2 warnings, 1 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] Test patch" has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.
```

The diff between the outputs:
```
diff --git a/before b/after
index d0cfdb243a1f..6f97b4c53080 100644
--- a/before
+++ b/after
@@ -1,4 +1,4 @@
-WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes: c10a7d25e68f ("Test patch")'
+WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes: bd17e036b495 ("checkpatch: warn for non-standard fixes tag style")'
 #8:
 Fixes: bd17e036b495
```

The prior behavior incorrectly suggested the patch's own SHA and title
line rather than the referenced commit's. This fixes that.

Ironically this:

Fixes: bd17e036b495 ("checkpatch: warn for non-standard fixes tag style")
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 scripts/checkpatch.pl | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4427572b24771ddb1f2bf3de3176f9437f643951..b03d526e4c454af7a42624155175e109d499762f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3209,36 +3209,31 @@ sub process {
 
 # Check Fixes: styles is correct
 		if (!$in_header_lines &&
-		    $line =~ /^\s*fixes:?\s*(?:commit\s*)?[0-9a-f]{5,}\b/i) {
-			my $orig_commit = "";
-			my $id = "0123456789ab";
-			my $title = "commit title";
-			my $tag_case = 1;
-			my $tag_space = 1;
-			my $id_length = 1;
-			my $id_case = 1;
+		    $line =~ /^\s*(fixes:?)\s*(?:commit\s*)?([0-9a-f]{5,40})(?:\s*($balanced_parens))?/i) {
+			my $tag = $1;
+			my $orig_commit = $2;
+			my $title;
 			my $title_has_quotes = 0;
 			$fixes_tag = 1;
-
-			if ($line =~ /(\s*fixes:?)\s+([0-9a-f]{5,})\s+($balanced_parens)/i) {
-				my $tag = $1;
-				$orig_commit = $2;
-				$title = $3;
-
-				$tag_case = 0 if $tag eq "Fixes:";
-				$tag_space = 0 if ($line =~ /^fixes:? [0-9a-f]{5,} ($balanced_parens)/i);
-
-				$id_length = 0 if ($orig_commit =~ /^[0-9a-f]{12}$/i);
-				$id_case = 0 if ($orig_commit !~ /[A-F]/);
-
+			if (defined $3) {
 				# Always strip leading/trailing parens then double quotes if existing
-				$title = substr($title, 1, -1);
+				$title = substr($3, 1, -1);
 				if ($title =~ /^".*"$/) {
 					$title = substr($title, 1, -1);
 					$title_has_quotes = 1;
 				}
+			} else {
+				$title = "commit title"
 			}
 
+
+			my $tag_case = not ($tag eq "Fixes:");
+			my $tag_space = not ($line =~ /^fixes:? [0-9a-f]{5,40} ($balanced_parens)/i);
+
+			my $id_length = not ($orig_commit =~ /^[0-9a-f]{12}$/i);
+			my $id_case = not ($orig_commit !~ /[A-F]/);
+
+			my $id = "0123456789ab";
 			my ($cid, $ctitle) = git_commit_info($orig_commit, $id,
 							     $title);
 

---
base-commit: c71f8fb4dc911022748a378b16aad1cc9b43aad8
change-id: 20241019-checkpatch-fixes-commit-aa014fe6d0b3

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


