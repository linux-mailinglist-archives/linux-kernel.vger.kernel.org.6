Return-Path: <linux-kernel+bounces-412516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 989D49D09F9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 08:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB83CB22F35
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 07:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC35B13AA4C;
	Mon, 18 Nov 2024 07:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1u1KMC2"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F20322E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 07:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731913318; cv=none; b=BVnLAh6ahRehbE8P4q7r/3jq83JSNZqn9RxmY0z9gnO61plfhBVpaPL1WT3wp+Jiyc1zCvdS+q0NWynn4eZCjplGiYM1inZ24q6ox7YrdW104bkz26pa34P7Mgg08pIap7h1a204Cs1beBSRjH7I72DE4zCGFs2UmLCvYUW32Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731913318; c=relaxed/simple;
	bh=CDHo7WRsiRVOFjJ+JS30CSrWpCSbXG1wbDoFBEmSaPE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n2inmyALrVpCedqCDDOFy0P05HznYTVsXdb0lXFZnYhC8c1mJZErrV7JfljwK0FI5h5v/vqmDKFMemPa7/+lyurF29J3BtZB58i5TIwFee4K3dFYmUvuTMXTGwxpj4Y+BDJ7MYnlvO5z5ezi/2RyDV2/ntRmAP6fGIAnG9ocKOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1u1KMC2; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21200c749bfso9328305ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 23:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731913316; x=1732518116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7u/98G8hsl2ifba6DFoRS73a+4OiRX5NAXlfHv/bHgw=;
        b=S1u1KMC2m7tnNmuADWyr7CaJlQCUcoIuLlPpxnASn8q+3wKKrj70j/+bwgS8kAgZp0
         4gnhRQVdJWt7lA5hnTOqxdkUNc0NfvDGXs3gZ9RzHMIKznSVm03qksTX29T+egg0JKWc
         XWx1F08YnjTbwbYG48gMcDhBdOpr9Ubj9MjpevlGfKiFLUnm6D4eL3JzexBXJaEryiM2
         gwk8Hn9SNuHwOKv1u4UyE4xi07hdR29rDzP/N4W6BUn4gvupH9ViJl06BMAwufnFLw2D
         GKBLYU7xM4vvAwByUo7pkUvJ5bZw8D3f4siageWVja6U5N8O0pZLr5nYjrjO5JknuHw1
         d7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731913316; x=1732518116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7u/98G8hsl2ifba6DFoRS73a+4OiRX5NAXlfHv/bHgw=;
        b=oafa6dD2XbWg3SMyTGsd6+AUg0mmRg8eYHi4ggimycZx6QLpYGmPeCjb68GUUAkCK3
         HFI6SrlhJj7KSGu8PbMRPmdqYX7ADf42qU/Qp14IbQzvRdm+b6hZAM/jvYNFnI2qygs2
         guG8JJYEhu7wZ1+qANmiWW1rVqzT9lNa0Rm+ZBiTbFSSnhPYFbUOmT/d2b4fCXp6RiA+
         Je2YbYqXIDsHLr0YOl0dMm8zQq9Uhnvq6/RlA2uCyZ9kbKmskVaCllbrLrcuiihoXxMR
         KDUmMwCE2XtpnyfuvCxurDruND0jTwVf/xDCZoV1XJl0+h6OcNj50Hatg1ZL/8h+fsJm
         CBTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPja7+frHGPHWqVUJYkdyqDe+0XYrVk+1o4K+3UVTCJXIw9U3RmjswtE9UJh1cStQV00YPsa+zVI0MJNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVEdgzL2beyR571WI9VzNI7CQ6/yAZqSz77SiWXIoYDtnQAjSj
	3TwtZ8+G75MdpDUm+nQP4xUXsxOJYuykJuMVkG9KxLWvptrCyJcf
X-Google-Smtp-Source: AGHT+IHOzFq5IAlUhAPXw7V4fRi3HzisuRHHVX7RmWj5Ly0UNiASMUhs5G7pKIoWSSs6JEeE7/kLqQ==
X-Received: by 2002:a17:902:f541:b0:20c:9d9e:9049 with SMTP id d9443c01a7336-211d0d7269bmr176486995ad.22.1731913315993;
        Sun, 17 Nov 2024 23:01:55 -0800 (PST)
Received: from debian.resnet.ucla.edu (s-169-232-97-87.resnet.ucla.edu. [169.232.97.87])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-211d0f56e55sm50289175ad.274.2024.11.17.23.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 23:01:55 -0800 (PST)
From: Daniel Yang <danielyangkang@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net (open list:F2FS FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Daniel Yang <danielyangkang@gmail.com>
Subject: [PATCH v3] f2fs: replace deprecated strcpy with strscpy
Date: Sun, 17 Nov 2024 23:01:40 -0800
Message-Id: <20241118070141.3474-1-danielyangkang@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strcpy is deprecated. Kernel docs recommend replacing strcpy with
strscpy. The function strcpy() return value isn't used so there
shouldn't be an issue replacing with the safer alternative strscpy.

Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
---
v2 -> v3: store strscpy result in ret and return ret if error
v1 -> v2: handle strscpy errors, changed prefix to f2fs
 fs/f2fs/super.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 87ab5696b..3eb754547 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1158,7 +1158,11 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 				break;
 			}
 
-			strcpy(ext[ext_cnt], name);
+			ret = strscpy(ext[ext_cnt], name);
+			if (ret < 0) {
+				kfree(name);
+				return ret;
+			}
 			F2FS_OPTION(sbi).compress_ext_cnt++;
 			kfree(name);
 			break;
@@ -1187,7 +1191,11 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 				break;
 			}
 
-			strcpy(noext[noext_cnt], name);
+			ret = strscpy(noext[noext_cnt], name);
+			if (ret < 0) {
+				kfree(name);
+				return ret;
+			}
 			F2FS_OPTION(sbi).nocompress_ext_cnt++;
 			kfree(name);
 			break;
-- 
2.39.5


