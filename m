Return-Path: <linux-kernel+bounces-258311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64869938615
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 22:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF4E2B20F96
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 20:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CBC168C26;
	Sun, 21 Jul 2024 20:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPitB1TV"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4C92FB2
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 20:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721593827; cv=none; b=VCkegQiul71F4iMdAyx1xmqbAHUycwfFLssjtcF379xhu7pIeMvG4PX5CjDmOat04KSoBvjlnE+ntPP2RmLy5DB0OCsBdVM8ocnXa3z84nu7VRwIJzHMk94n76T3L3JUaJGWgYM4FBHCMQ26lQN5Xpw0WB32BhMVKzHIjbYKC4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721593827; c=relaxed/simple;
	bh=GLrVHx4OHdfP9Ntm7l/dTRCK8M6L8FoBOT4SZsHz50s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ubnFmD7O29CUs5SiJFC9NrfDulLtnoWehjPl99EaYj7nB5uR1EPP571OKGiRsvDiS3+/2TYU2ss9/rhreVFblcA4/PMNNeM+eRHXqZMpaRldiwdM31oVN5Np4Ng/L3GmEOKWsvJgmYKqquG1Hwa3Z/1DSohWRy0XqDu9MgXOwxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPitB1TV; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-449f23df593so17852611cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 13:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721593824; x=1722198624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wavXSjGdq18Yt9mO8dwNN9l8YwPcQe7HYiwYYz0FItQ=;
        b=iPitB1TVv+jWLzq27OW67x6a/q0NQol3nJk7vR3qQMwydINiW9U5zyxmRZetIwwnD6
         jB6vsZ6gdoQxfZx56IEyQUXjMAAETNR8TJM59tQ02EeXo4u0zvUtRh2HJgzFs6j+4J7k
         JzNB0R+xoYEgfZDs2CAv4Flmo1QHgOgF2ylVhewqQIK45WmvYeLmqO28auPf0ohQ/y5t
         96kwUJrA6AjfCASuX7OvPnFtKkuH2/ZEZyCOXycSHdzvg53+7uJ4sWe3+shTV/UXschV
         YjkA+pELREPqalmyd+lPIAFEKCr6MdFGe3Q9t/ohmZGahkTFLsbbplThV0zuU4GItE3W
         /dCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721593824; x=1722198624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wavXSjGdq18Yt9mO8dwNN9l8YwPcQe7HYiwYYz0FItQ=;
        b=BFxQP8fpxQHoXNkT1Adpk0xdgfgfvmS7C8ihifu+s0/gjwMdrE5f63qIMmd/KP/DUI
         107l9EXYc+0sQ6C7qDn/oGzLd9nAu237I+Bu8vN/PobwI8BB5jVX9bAq81DiPAlgFO0W
         JiIGMxjxvPKqxM0AIiJqfFsks4OqOKb4sJz/4M7tJNK/MH5DTa/3a5ZRXnS4jmNOLDGg
         OLdE01oyjGk5Saz9ywTzSTzIsxZC6tXnEV+BXGKlNPEOQmfR2T+l/YeY4BxFHJirJRZo
         95tD/9OU+JA5JSE5Wwuc01QLqAeD6/Pd13bQVMJyLUUlSmUDJbcJtjkqzVPiqIuiq6/r
         /ETA==
X-Forwarded-Encrypted: i=1; AJvYcCUvrc1i6fxiT3JJ9Ed7OLi3ejJbS3dm5g+KNDq25mp2AudHfQxFFU/iNzwV9fClVkgPKE3C/DbDrcvbdobWbXCEwjPmI9Z6W0iHZCAf
X-Gm-Message-State: AOJu0YyfEDfbTE0nNhSr90moSEnN+AwpG8XbJROYKpju4rNRBy2rG1XI
	WaYO16hYiNsmjvon/a/XA9ZyOTQT7Xfs3JbeCEHoinVnxM2hHN0V
X-Google-Smtp-Source: AGHT+IEBBbUl9G7TsKVlhJY/+zllG8fNc6YP/gM2neV0WPJOic5OmzXVBuGi0984b5Q3ZETq0Qb8Bw==
X-Received: by 2002:a05:6214:240f:b0:6b5:e202:bd91 with SMTP id 6a1803df08f44-6b94f00e6e9mr117960546d6.1.1721593824518;
        Sun, 21 Jul 2024 13:30:24 -0700 (PDT)
Received: from localhost.localdomain (d24-150-189-55.home.cgocable.net. [24.150.189.55])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6b7ac9c3cedsm29137566d6.80.2024.07.21.13.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 13:30:24 -0700 (PDT)
From: Dennis Lam <dennis.lamerice@gmail.com>
To: iro@zeniv.linux.org.uk,
	viro@zeniv.linux.org.uk
Cc: Dennis Lam <dennis.lamerice@gmail.com>,
	linux-kernel@vger.kernel.org,
	syzbot+f2a9c06bfaa027217ebb@syzkaller.appspotmail.com
Subject: [PATCH] btrfs: Change iov_iter_alignment_iovec to check iovec count before accesses an iovec
Date: Sun, 21 Jul 2024 16:19:18 -0400
Message-ID: <20240721201924.48781-2-dennis.lamerice@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <dennis.lamerice@gmail.com>
References: <dennis.lamerice@gmail.com>
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


