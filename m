Return-Path: <linux-kernel+bounces-258315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6636993861F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 22:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFDDDB20BD6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 20:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA5A168490;
	Sun, 21 Jul 2024 20:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4d0EXkh"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37C9C8D7
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 20:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721595535; cv=none; b=KJpLBk8JCqQm/G2khu1/pEOcsXb+FA5NMOgwPUQV7QUhb1dxG0Wx8d/ykB2rN0D40QBHbanqUmZOOR//fqhHzOenfCzdw4fL7CG3JBkiWA2qqjHtspf7OMsqBsAIIuwmhc1HC8ETBHb3YDZg2mrgMlHtOn6yZ3fUZ51pyWx/rbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721595535; c=relaxed/simple;
	bh=E1jZ9W6/6kp1Cvixmx0OmyOm6inCH/TLqBQECIWqGfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VN9En/+bp2xVslgYkibgCKZ1GCgEQ53HI8rV09tM2tUlT2exWJrEJlWnvxrAW9JEM7mjya9MRmsA93Om85OPk1vmfWSQuQOp6OImvW0qov1gR9HTHO/aHriu4YiIoj9/ezS4wqPSkbEoUAhfUY5K0RBkK9MJOkIaz2+oIQJpuFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4d0EXkh; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-79f178351d4so178054485a.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 13:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721595532; x=1722200332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iE03wv6ik7nohRyZP5io1gPththUo2MOiVODO9xxYv4=;
        b=P4d0EXkhsO6xaq/obQNDLdcFa86MU1sGqFG6KBF2JQa0MstEQsc0ocLGhkLoELy9tA
         VX9lxuqk5I1fMpOX5Z6o4aQF2FArr/zU8ykbQwfYF1DyVw9+Y5tRr3LlpR7cNkGzeeeV
         RdzsjICD9tM+u81qrIvbgBMfJfw2Wv6CWUynQMyIR7tPuyWIotPStZhKol8pPbunv6Wj
         rsqJbpBnoQ0mrwPAlK8/NNiUY8UQ+dZY+C65yQBgoxr3QWobakDDCI/PcCo2DgmQgdsV
         KCLbuHEgON0dj9gJez8zU/9f55Pq8pCXMYfN4OMIbBHpETBMBhwjLOZoqtE6FXng0qkI
         HIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721595532; x=1722200332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iE03wv6ik7nohRyZP5io1gPththUo2MOiVODO9xxYv4=;
        b=nWW2ERGUPOw9O8YaKe8Vr+nQQH8EmJdAyf/irUpnae52PW2kuZlvrZVYreKZBpqI55
         5XSnqq1a3DBcF1bVbfhpwvll0X5sPrgsiXcNfjUP4KJPG81RwRhF+SySX64fMDGUmEIA
         IOOML98qwawAEvlxMIeS9C6a2OA+dnB65ib5hEZvwhHdL/qpEfU5SRNDifzIg6qh5iVB
         H1ZoDhKkgHRYLY7H76UfwaBFpySeQXpB2aG3BgPYlyM7fJvM8VUo88uTda0wUyc1egxi
         KNj3dnx5vIKcOFCEwE/SVqr/4maKFlLaGWahBLYOLFUQyI3Jd677EUkoVbvp73StkrE/
         RsEw==
X-Gm-Message-State: AOJu0YxQ5c96MlCODFvi+YKsmX86c3OCMDRvu36UEDGJ/6SLWtIUGEEl
	gH1Rs74izHIXwv36A6O+WkkLld/xovDe11WJVnU2DoG8HP7nwqrK
X-Google-Smtp-Source: AGHT+IGMljqojWaiVAdrxJilL4DChPZhIbH0q6yJblEtj7Pjcir4Pcu9mVjcTKR7uhzJ6Sk6kRqaFA==
X-Received: by 2002:a05:6214:29e5:b0:6b5:8f79:7bc with SMTP id 6a1803df08f44-6b95a5b3f4amr83373846d6.1.1721595532476;
        Sun, 21 Jul 2024 13:58:52 -0700 (PDT)
Received: from localhost.localdomain (d24-150-189-55.home.cgocable.net. [24.150.189.55])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6b7acae4028sm29110976d6.112.2024.07.21.13.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 13:58:52 -0700 (PDT)
From: Dennis Lam <dennis.lamerice@gmail.com>
To: dennis.lamerice@gmail.com,
	akpm@linux-foundation.org,
	viro@zeniv.linux.org.uk
Cc: linux-kernel@vger.kernel.org,
	syzbot+f2a9c06bfaa027217ebb@syzkaller.appspotmail.com
Subject: [PATCH RESEND] btrfs: Change iov_iter_alignment_iovec to check iovec count before accesses an iovec
Date: Sun, 21 Jul 2024 16:52:53 -0400
Message-ID: <20240721205252.51913-2-dennis.lamerice@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240721201924.48781-2-dennis.lamerice@gmail.com>
References: <20240721201924.48781-2-dennis.lamerice@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When checking iov_iter_alignment_iovec for valid read and the iovec is empty,
the function still tries to iterate non-existant values. In this case, the iov
variable is empty and attempting to use iov->iov_len causes a kernel crash.

This patch fixes this by checking the size of the iovec before iterating.

Resent this patch in thread because one of the emails I pasted was wrong.

Signed-off-by: Dennis Lam <dennis.lamerice@gmail.com>
---
 lib/iov_iter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 4a6a9f419bd7..2d82ecf1b622 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -783,7 +783,7 @@ static unsigned long iov_iter_alignment_iovec(const struct iov_iter *i)
 	size_t size = i->count;
 	size_t skip = i->iov_offset;
 
-	do {
+	while(size) {
 		size_t len = iov->iov_len - skip;
 		if (len) {
 			res |= (unsigned long)iov->iov_base + skip;
@@ -794,7 +794,7 @@ static unsigned long iov_iter_alignment_iovec(const struct iov_iter *i)
 		}
 		iov++;
 		skip = 0;
-	} while (size);
+	} 
 	return res;
 }
 
-- 
2.45.2


