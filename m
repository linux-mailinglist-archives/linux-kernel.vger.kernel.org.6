Return-Path: <linux-kernel+bounces-305771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A898963401
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 23:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E2B91C23382
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FAE1AD401;
	Wed, 28 Aug 2024 21:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjuRKgzH"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE82C15ADB3;
	Wed, 28 Aug 2024 21:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724881092; cv=none; b=IV0OrjYp3yk84BbAjsmx5FnwBKAxB5dXHcQVf+V7y9qydAAQYYBpSRbLE+rUSgOg++C0XugpKpwEkKQkylcmtxOROpgU6+VgYwf/FFRB7SKfev25KaW6MgYcNLufxEmm3SYgXtGTREMavfGDkbKo2pMGCRPr5ZWx4q4uZmSItNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724881092; c=relaxed/simple;
	bh=mXpwxscITuJmDBnHHHFo2Unzf4ty8r85TPNYp2/qzwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U+WTUvWSWQDNqZLSFL8knM1PMKxa/ywO80TlQKC90/7qWC3rhbaExr2D6QSaiqo7su8W4oF8eWhfJobpXOoEKvNy93yzqUtFgiR9VFC+QfDtiT21m7r4YyivAi0QJoCO2VSA8qVY52uTvxwTlHD9qWh8m4ZHhOW8grqukVTD6uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjuRKgzH; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-201fae21398so51570265ad.1;
        Wed, 28 Aug 2024 14:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724881090; x=1725485890; darn=vger.kernel.org;
        h=content-transfer-encoding:commitdate:commit:author:mime-version
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMk99BuXbDSj6pqZLfc1bsxguv/U5uK+knnZthXiKeo=;
        b=jjuRKgzHNiyfZQ7DTUNL9Bm5WnMDX5KhN1qv0+I9qjcU0zdTAnrN9lgzfUClNY2DIh
         TvvLSDnI+p9wc6zkoKf4gMpqG5fYYvoluADkbKUwXtum0YuZy2G8KEnGXoMsW9jxaS1T
         1frsXHiaX7dTVBcmI54AEQURr2V+6ZppBpEnfz6LyBbkzB+XXU8P4FwmzrQujeTdR2EF
         j8hA+eXJZaSjd4S1Abe0eIfVrtKaftIlUXOLeGCx12pteswuoH2NjdkvvBOD5n/FsY4B
         6xHM/OgoqmYUFuUT8dT5/R3oIIyf4MeJBQmr1iKVwlOq1qnuy0T/q6aeVGux4atsjfPY
         kqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724881090; x=1725485890;
        h=content-transfer-encoding:commitdate:commit:author:mime-version
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMk99BuXbDSj6pqZLfc1bsxguv/U5uK+knnZthXiKeo=;
        b=mC7DHWXZR8BkSc8J+jEdeCcBClTCrSdiWIHbwkaClbu8p5mcTYHhGqwI9ff1QHYGLY
         alVl9X8NC/6UZyEbod42x5bmw0Vs9Ur5mKKrDOxxE8MGZt6DMLmBroYoKEd6lIaKkzL4
         mOroUzF+W9ZQOwj7Gz9LZaK4HEvm6XgXrH/M6xfBS6UNPRYmVi+KHSb8zD8EtAULE+KT
         K32Scu9Hv5xHJ0GOrPz5I53dCPZFrNRqTJL/6q8QS2HOEV2+BCGmMwxM+7CzdlzYV40T
         6/icqR/KPVUi/gxcN8fYF2x1sGoWobG3E4x6iIYuddpmORZoeelA9RxMrYQvFOdQ4+Bh
         8EBg==
X-Gm-Message-State: AOJu0YzQynN5pklAcUPmYZEqYY52EBgJVWaFDW3XIkxCJpPti247bJ6R
	01Me7rGzXQJhtkxfxc+nfRcVcKHhIfcJL3yytUQ3ngznXK29SW467Zme4lNCMbs=
X-Google-Smtp-Source: AGHT+IFaT8OEEW0oabyNfRxvHJKgCkfSakODxyJlgwi2BKF24q8TjzgeSilZGLAJ/APAfWrYwd7Lyw==
X-Received: by 2002:a17:902:e886:b0:202:3bae:9718 with SMTP id d9443c01a7336-2050c23beecmr9354515ad.15.1724881089707;
        Wed, 28 Aug 2024 14:38:09 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:f022:f804:ca0a:f615:5d6e:f4e1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385566585sm104084125ad.4.2024.08.28.14.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 14:38:09 -0700 (PDT)
From: Siddharth Menon <simeddon@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	apw@canonical.com,
	joe@perches.com,
	Miguel Ojeda <ojeda@kernel.org>,
	Siddharth Menon <simeddon@gmail.com>
Subject: [PATCH V3] scripts/checkpatch.pl: check for non-permalinks to Zulip
Date: Thu, 29 Aug 2024 03:07:54 +0530
Message-Id: <20240828213754.25137-1-simeddon@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Author:     Siddharth Menon <simeddon@gmail.com>
Commit:     846988fa0b20c2eb1bac2ee341c973762df9a1f1
CommitDate: Thu Aug 29 02:49:40 2024 +0530
Content-Transfer-Encoding: 8bit

Zulip links to https://rust-for-linux.zulipchat.com can break in
case of renaming the topic or channel if they are not message
links (which are permanent links).

If a non-permanent Zulip link is referenced then emit a warning
and direct the user to the Zulip documentation.

Permanent links are of the format:
https://.../#narrow/stream/x/topic/x/near/<numerical_id>

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1104
Signed-off-by: Siddharth Menon <simeddon@gmail.com>
---
V1->V2:
Corrected the Github link to the right issue,
Fixed grammatical errors and Replaced the link to reference 
Documentation to one that is easier to understand.
V2->V3:
Updated the URL to link directly to the section in the documentation 
with instructions on how to create perma-links.

 scripts/checkpatch.pl | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 39032224d504..58a5e02c588f 100755
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
+			     "Use permanent Zulip links when possible - see https://zulip.com/help/link-to-a-message-or-conversation#get-a-link-to-a-specific-message\n" . $herecurr);
+		}
+
 # Check for added, moved or deleted files
 		if (!$reported_maintainer_file && !$in_commit_log &&
 		    ($line =~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||
-- 
2.39.2


