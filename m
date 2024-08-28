Return-Path: <linux-kernel+bounces-305766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D6C9633F4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 23:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 682661C21C0B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D4F1AD406;
	Wed, 28 Aug 2024 21:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEs17HGM"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC3F1AB528;
	Wed, 28 Aug 2024 21:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724880902; cv=none; b=bCikungzkf390KIfcxS0SrrGLbB0SG1aOyfzjJxbr6nDx3GBwHicuz2Z+mpnmLtUIF/l5cJf/UI4DKm+rA7NBZgoQDFAM1VqVdOSVQNlI+GK1HutSdRtmZTT+oKFHDqKO/2iTxaPcFJ5w/tQzm5RYEoYbekCQukUlcLRaLlh+us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724880902; c=relaxed/simple;
	bh=u6kW+6ArbewrNzZcKJ3cCim3nQ5/kCbS8zfS9851Gio=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dTHzT9qqeZzKagTJ+AJgduR6boDYAvwcgilmBDbvQSP1137L8dLivAhIq7Wf4b/DbPpzKdiTz0bFTXeHgLacHeVcikUVEPvlNtbUP9IPh4sbH5EQUXtEpX6Kjk6PTd3vheZOiEF7aT8c56nuS+1iFI8N2qVMJ58tbMEcdfWwE/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEs17HGM; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7142a93ea9cso5298418b3a.3;
        Wed, 28 Aug 2024 14:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724880900; x=1725485700; darn=vger.kernel.org;
        h=content-transfer-encoding:commitdate:commit:author:mime-version
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdyQszHmpMjA1lielnMCOCT+CVl9suwnpweUfFJE9W4=;
        b=dEs17HGMr7ms8RekeL+OBCEb9KuiHxw2vMZ2mEUk4QMoXph3+YR4qA1+E0YuvqdsQD
         WbVfjdtddngGQeEn9esSExGRn6moQ9XJ6j/cwS6SIGCM3pDHAsvFHmAfOA4JJVeTx9VA
         yPtWYLi46CJAu7lEHaS666hqoB6biWk4uCRf+xeoiZS/Kiopze2mRjKxvGzAKqthfKHO
         EyaiZNtwvFKJ6NGLQJwYfB5r6ecqFoVbRzIDGTEZxYvg/NlzK0G9mHX6vbN3Ox9y7fcT
         vYSbpmazU6hL8JuIGr8EdtvB4hU0hgGn0E74yeW0qkcX6OZrWKPXbT01Du//ZcJKasqz
         zoaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724880900; x=1725485700;
        h=content-transfer-encoding:commitdate:commit:author:mime-version
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XdyQszHmpMjA1lielnMCOCT+CVl9suwnpweUfFJE9W4=;
        b=f2sxKN2XNSx59XboGQN5PklP3gJATWT+vI/wf2/xiw1VxtpkOex6RFR4W4iKK8YCg9
         OJdYZeCnzN9S9stw2mtAbwQn3ztEu8fVn5jl5PalNgP1VkNzdgwHDu+mM9Pjat8pmgRQ
         hvKOjGMDZYnk3uqe7vu0+O8HiHMQMfitUY3htdbgF80i7v1AnQl4u8QeSiVKdRMw+Dkt
         3NAKAQUURxcZYW8zqiv0xf2zj99wvQEvQiMdJcJFpKjYufK1c/ONxg5GIBDnzheNdLut
         heh4uF1L1yR/fpmafl75WH25G9ySyYaMHh4aEd+91sbBZ1U72a958QyLUUOUT1u1IEQy
         94Ew==
X-Gm-Message-State: AOJu0YzNZO2Rg71ljjUX/EylbifS7RUmDDV+D8mTwOUfmSAQ/9AAynXl
	ekBWbQP92repRj+YZGd9w7L88JI4ePD56Fknxb/mOyMwdD8lCHw2kxrKcaP1KA0=
X-Google-Smtp-Source: AGHT+IH6YpYbGSLGbv/6QL0onHVlxfvlNcSz95VJnl66HChd64IDoO0wGi155UZej8DlZbj+DN8W0w==
X-Received: by 2002:a05:6a00:3d4c:b0:714:25ee:df68 with SMTP id d2e1a72fcca58-715dfaf2ed4mr1006275b3a.8.1724880899523;
        Wed, 28 Aug 2024 14:34:59 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:f022:f804:ca0a:f615:5d6e:f4e1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434af17ccsm10475739b3a.8.2024.08.28.14.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 14:34:59 -0700 (PDT)
From: Siddharth Menon <simeddon@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	apw@canonical.com,
	joe@perches.com,
	Miguel Ojeda <ojeda@kernel.org>,
	Siddharth Menon <simeddon@gmail.com>
Subject: [PATCH V2] scripts/checkpatch.pl: check for non-permalinks to Zulip
Date: Thu, 29 Aug 2024 03:03:57 +0530
Message-Id: <20240828213357.21241-1-simeddon@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Author:     Siddharth Menon <simeddon@gmail.com>
Commit:     9c32b4f2ad277b94a54955b0285ff7dcfb5087aa
CommitDate: Tue Aug 27 23:39:18 2024 +0530
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

 scripts/checkpatch.pl | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 39032224d504..41630532a056 100755
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
+			     "Use permanent Zulip links when possible - see https://zulip.com/help/link-to-a-message-or-conversation\n" . $herecurr);
+		}
+
 # Check for added, moved or deleted files
 		if (!$reported_maintainer_file && !$in_commit_log &&
 		    ($line =~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||
-- 
2.39.2


