Return-Path: <linux-kernel+bounces-356812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D19996715
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B6121F263D8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671C518E764;
	Wed,  9 Oct 2024 10:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFP+ZcgX"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A56618E030
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 10:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728469398; cv=none; b=f71u0O+EQNiPRbI0CPZR2pBmlYS5rxNxZLFA+v511pXxB3KBx0kjomoMNVtunnH0Q1eCX6TT7eDKUX6QJYnHvh85oavDccwxBPr78RtCHdCDj0IH3+Yor89C+YfHwpu8mqq9HpIunepl07YSlUL/VyJOvFupLMYSaJbcr/JANLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728469398; c=relaxed/simple;
	bh=N2F0Z+pezwp5AWD+0LxHqGuCFdbPTJShRAaWJR/1MhM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J2t0FjHWGQn8Y4Zw8Cc36t+ghLPbelu+iaAZ7KKgLP23TKSISTCua3DtapLGfLQq3Pk8iO303psCdjcIkfaig0jJRh0J1vJfAKrMrwvaoHtt58xcwhN/B+Om1lWa77O+b4UIqclYVbu83iRJI9WxcB16oN7INVUIT7RJLnwpAw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFP+ZcgX; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71dfc1124cdso593037b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 03:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728469396; x=1729074196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dtdowl6ashFE99iWon9UNhidq4cexD1HxOX3fIyG2pg=;
        b=MFP+ZcgXj/3x6DsyCJm1uqoHQc67Rz20kgdMw/34oXZwXFBFzog+0hweMOGRZMCIC6
         AeoswFMNbgzuiWmls0e+08DnTTUgRL/Z9z8Z/e9laCAUqC6HmuTn93gEAe3yjZohQnhA
         KNzph4idwv18HUiVXUUnGALk7eV2BBEnHVOyQ87TQTSpZp2gnm60JibdCvp40xUvAM+a
         TcqmZoiBe7/11XtNOoTr+DF9tSpyiJ1AdQo19IUPL1CP/JiTGguwlU7TqXK6ojE16CR8
         zFUqPyLiKU74dtUjy4ffqqOUoy68cxC/GKqp/l78FjOzkyJJlcbX2KjBtPeROYpqDYrC
         YJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728469396; x=1729074196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dtdowl6ashFE99iWon9UNhidq4cexD1HxOX3fIyG2pg=;
        b=ZxYQ3SeIMx1UgZ1DL8vsCIFVh//E2lpbgzbhwt+3VDG1T+9GebQ6fw5UUePmpkrynx
         ePozb5MAb8gLqmtnrzLn2FvfjaxjC10iM5PSKpYPh/UTXebYmoBQVH+tnh9DS5zHccPx
         fw6zk6O2TrNYgw/0xLiR6Goj3QPNxlc1NlaLwUzwdcK9rwldfNIykCrYrUJFJEboDJgc
         x2pQB2a67opKDuJmL1JQbKJldA1u/wJjIUb2NkhiKCLvHKqO3a5ikw2ZsWahrchcD4FM
         BqxeCaPMLOOlsgc88fMvWEBV5RCLuwvz9ZhjxR1rT+Rt3CjtBnettUtvJmrfTu5affwV
         3nYA==
X-Gm-Message-State: AOJu0YwV6ZZQdA8l2wi9u6DBJjXOsgF3H8vVsc1QTp/kaY5TZMshuLVr
	q6BAWVQlOFeuQiVhvHBTN6+18Po5eqfOqVqYHoKSGJd/BXxlmra1
X-Google-Smtp-Source: AGHT+IEL75/TPn/Yo1Nyq+9pE8JItFWhGGqUQ8aPq9owYY751VmFqnsEg6OGcWC7sgc/jqyUULVtsw==
X-Received: by 2002:a05:6a00:c94:b0:71d:f2e1:f02b with SMTP id d2e1a72fcca58-71e1048dfadmr11623834b3a.2.1728469396269;
        Wed, 09 Oct 2024 03:23:16 -0700 (PDT)
Received: from advait-kdeneon.. ([2405:201:1e:f1d5:d612:678b:1ff0:d43a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d67cadsm7681274b3a.147.2024.10.09.03.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 03:23:15 -0700 (PDT)
From: Advait Dhamorikar <advaitdhamorikar@gmail.com>
To: Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com,
	Advait Dhamorikar <advaitdhamorikar@gmail.com>
Subject: [PATCH] scripts/checkpatch: Fix multiple Reported-by: false positive warning
Date: Wed,  9 Oct 2024 15:53:03 +0530
Message-Id: <20241009102303.49473-1-advaitdhamorikar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If multiple Reported-by: tags are used, the
checkpatch script throws a false positive warning
even when there is a Closes tag following the two
tags. This fix checks if the closes tag is present
after multiple Reported-by tags.

Here is an example of the same:
> WARNING: Reported-by: should be immediately followed by Closes: with a
> URL to the report
> #10:
> Reported-by: Kernel test bot <ppppqqqq@ymail.com>
> Reported-by: Some Person <xxxyyy@gmail.com>

> total: 0 errors, 1 warnings, 0 checks, 8 lines checked

Signed-off-by: Advait Dhamorikar <advaitdhamorikar@gmail.com>
---
 scripts/checkpatch.pl | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4427572b2477..c74519f02180 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3188,10 +3188,13 @@ sub process {
 			if ($sign_off =~ /^reported(?:|-and-tested)-by:$/i) {
 				if (!defined $lines[$linenr]) {
 					WARN("BAD_REPORTED_BY_LINK",
-					     "Reported-by: should be immediately followed by Closes: with a URL to the report\n" . $herecurr . "\n");
-				} elsif ($rawlines[$linenr] !~ /^closes:\s*/i) {
+						"Reported-by: should be immediately followed by Closes: with a URL to the report\n" . $herecurr . "\n");
+				} elsif ($lines[$linenr] =~ /^reported(?:|-and-tested)-by:/i && $lines[$linenr + 1] =~ /^reported(?:|-and-tested)-by:/i) {
+       				 # Do nothing if the next line is another Reported-by:
+                }
+				elsif ($lines[$linenr]  =~ /^reported(?:|-and-tested)-by:/i && $lines[$linenr + 1] !~ /^closes:\s*/i) {
 					WARN("BAD_REPORTED_BY_LINK",
-					     "Reported-by: should be immediately followed by Closes: with a URL to the report\n" . $herecurr . $rawlines[$linenr] . "\n");
+						"Reported-by: should be immediately followed by Closes: with a URL to the report\n" . "#" . ($linenr + 1) . ":" . "\n" . $rawlines[$linenr] . "\n");
 				}
 			}
 		}
-- 
2.34.1


