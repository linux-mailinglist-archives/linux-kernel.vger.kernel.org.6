Return-Path: <linux-kernel+bounces-372949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE639A4FBD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 18:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991F51F25C24
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 16:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A486518C333;
	Sat, 19 Oct 2024 16:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biYag8V6"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285C714D71E
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 16:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729355139; cv=none; b=OwipbKB7o9UtInh1n2yr1sy6eqJ1nYAQEhzA+MeuV7W7lzmuaTBfm6VndMDYHqp2a8pLr9FahrESfpuXvlHR1+lEMPFDvU1gao0tNwiLDWVq+FRXsLl+irFpL62Si0rmFsE1Q9TKcJJnezJ5ItIHQrNpYEwvjulW8ZB80vTpqC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729355139; c=relaxed/simple;
	bh=WFVJXGOzIlA+UAKGT/1uhhUCCEbVrPsnTLT32DDjddI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MSB4DP/PnGE/sAFiAjdvnOmNY9+oGUzIog5LU5vpsBMlZV3ULQ7J3ca3iYEOGM86DFjg1GGXkyki8f/xXIlFMb+Xt1WRfreB3p6IdQUTsg+QLFJkUdEUtvgTk0I1MyVVKTxZoPxghL079eL79RzRPK3xwtBjXEG/Kf3+W2UtZPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biYag8V6; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b1434b00a2so253928985a.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 09:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729355136; x=1729959936; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAYuuz8UyB/972vIhSKwabgRr+7o7vjOna67Xechz4I=;
        b=biYag8V6iMZdCVtxbJntZH0Tx98tvoaJKw+fKkZ0xDmYTXgvUhLzUaN5pITSqpchay
         KfGpG/KTeJ/kgortw/Uaw0T6XOYMzA8Mao0rjtzhYwwctVuXQxD5KtDzBRxwKS6qQSyI
         EGFgLh8JkkCP2NbzcUn8mj1DPuiRLwRE9TaGmD+KMEOMD+IiNRDIuBT4BKbK9EUUgRZv
         sNxd6nytz9MEadaloGoOFUfrb04t5FVDqjPV//2DTUk+MhSYbxuFR9+SOZrwW4q1pbQv
         UOJU6/e9yd3JorjEKKdLDtJXuQd1lSOxjcUCjEchoPuIJNxKlHyNXuD3Om7fB9+T1njA
         GdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729355136; x=1729959936;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZAYuuz8UyB/972vIhSKwabgRr+7o7vjOna67Xechz4I=;
        b=f2sagcDlcLAstYIYHBP+QalqKSQfL0vCy2UYGD+JtieYjqzjIv0R9ACHKiJ4XaK6mC
         mdMdbp5uYZvb02aCIatxoU51pdnOKwFGbftduCRljR5637hO28ykkHsqXHEssFoygmOu
         UcdLMQt3hhfr3Sdr2465s9B93IBjoSIvdIG5I0jVLAyvVmSdpJk79M/RQfd9q8ArN4zG
         /M7M9gSOcvMGQABLMoKKzR/iCKovelDBK41DikOWfJ27b+OK6jBjdM4Q5hB9Qkneo/yu
         EThllYIkGXwdM/gRiAb+28c5vujmeGYIeZJ0ft6OMPAAzuTcDZMSIlwix+5fFvJLCoOE
         jgkg==
X-Forwarded-Encrypted: i=1; AJvYcCXkKoBSWmhY32jmPyYBteUWixCQ9Q1J42im04ANfWY0mxDhcMzEK2HPuDZhen+z3q83uAjfDakJge/07lM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylm1wHMC4FGMBr0nXs2VjLHSWdpA2zNbE0JsGfkeIkhZyXxS2m
	J27p3gABtxnPi/JL6XA2KB2irrIKbEihTeGTM1UKcGyAMjQRJ99FWo0NsU7qyLYAEQ==
X-Google-Smtp-Source: AGHT+IEeRsHfu9S63tUkW2D1GA9dVjrATQOss2Mu/T3TSpQZfI+s76uJtjXamgcNY5LAPETwVVhLPw==
X-Received: by 2002:a05:620a:4407:b0:7b1:49d3:29c7 with SMTP id af79cd13be357-7b157b40f3cmr848398285a.2.1729355135867;
        Sat, 19 Oct 2024 09:25:35 -0700 (PDT)
Received: from 156.1.168.192.in-addr.arpa (pool-100-37-170-231.nycmny.fios.verizon.net. [100.37.170.231])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b156f8a942sm195692085a.18.2024.10.19.09.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 09:25:34 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 19 Oct 2024 12:25:29 -0400
Subject: [PATCH] checkpatch: always parse orig_commit in fixes tag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241019-checkpatch-fixes-commit-v1-1-0d0cde18ce69@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHjdE2cC/x3LQQqAIBBA0avErBvQkqCuEi1snHKINDQiiO6et
 Hx8/gOZk3CGoXog8SVZYijQdQXkbVgZxRVDoxqjle6RPNN22JM8LnJzRor7Lidaq7RZuHNqbqH
 cR+K/l3mc3vcDew7bOmkAAAA=
X-Change-ID: 20241019-checkpatch-fixes-commit-aa014fe6d0b3
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
 Dwaipayan Ray <dwaipayanray1@gmail.com>, 
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund@corigine.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Louis Peens <louis.peens@corigine.com>, linux-kernel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Do not require the presence of `$balanced_parens` to get the commit SHA;
this allows a `Fixes: deadbeef` tag to get a correct suggestion rather
than a suggestion containing a reference to HEAD.

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
base-commit: 3d5ad2d4eca337e80f38df77de89614aa5aaceb9
change-id: 20241019-checkpatch-fixes-commit-aa014fe6d0b3

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


