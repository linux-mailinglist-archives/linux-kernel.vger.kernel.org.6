Return-Path: <linux-kernel+bounces-570516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63122A6B1B1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A89611895816
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E642521C19E;
	Thu, 20 Mar 2025 23:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZlEwUZn"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43CA1E49F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742513512; cv=none; b=NUCW5+Rh8h0G3jEyS1iyUh7qRirmj34RbWAMpDWWwZAUZdfzWonhy0XIsJp73fmwUavlZo/ZY4YabsvIObiPTWKDLARKcrfFp5tP/YOxmVMeEEOngw1J8qRhl9p7h4y/Bq0wciDLoTjsGoxwfXDBKoN0xEEfte2Ym63Y3PTvv1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742513512; c=relaxed/simple;
	bh=vKXN5UOu4nWZzb32BFy60N2WeM5d3u++GK/V72jPFjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FF6Wcvpm0cBogpL90PY6CQ/MlSwEzGuhq7fWhyHnJHi6t+Dfh+TMA2KQYh/3lWF4IsIm7czG9MBeo26nADZUo3MMX8frkUX1QSyjYWBeJkIA15gWTZ4O5L/Y/8k1ALbZ/F8YnqTXt528CPrw6r51iu1Nmz6W1EpPWxI9VG8OCwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZlEwUZn; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4394a823036so13744515e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 16:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742513509; x=1743118309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WmZrqAL4xXFu8/5k2CHCeb0s0dZai7wR4qe/FXL6bLA=;
        b=VZlEwUZn7oGCCUaWvKa84naR5mLi++ocxF0zSpYW16kxMyL/loGiqeb5idn/XvKhzU
         lETrM+Bzo9jm8SAnza7RJiDo6L2jq7DUoowTaNe+AzsnBf19bBDI3ctKncKuN5mrNHSd
         mxNZPuL8Ygk1gPAi6HwUmF5ak8KPtTIbre5IRmlymfe4/bTg7wCSdiCkHydA1g/XMAc3
         ZfH2ndOIcHEeaG1IoyYAaE5OdS1Rtjnjoads3s1UHqCh8Oz8JhoWU5c5Etr1Rhf5tCH5
         BwDJB4LHm5LSB3PGOQgNh40eHvEzlJDj1xj8jbTfgpm25px4I1S1OO9s1tkm7W+oP8Gh
         8CUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742513509; x=1743118309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WmZrqAL4xXFu8/5k2CHCeb0s0dZai7wR4qe/FXL6bLA=;
        b=W9NLL4NtkrgSVTBg4siImdr8TEomVhFsLORT19g+tuBxCGdJyClnRd6V1nVNHXG6to
         FKj+g8LkWdWpZNteL8Nmg+php7X8N92wkU8r12xvOIQF9FWrtItjQ9GS1wyWo/8QK3Qn
         WyUgS2TEE4Bp9KqlJXYAe7h/TzITxjOfjcyIgWFovowtDaSmvdIGlLHXEaxt7vz9ejMb
         XBwXkYQYJsD346bHkhFiwPNNzcg5bcyEoTEGpK6yY13/MrRCTMdoToLi8lplqjhv+YLW
         +RQWIUE1ZlP2OBQJbUwC/Rd44OFnDkD22EWBQtYHalL7JmAbxljRA8s5xBQqCHOgUmmS
         vfZg==
X-Gm-Message-State: AOJu0YyYzCWRAqZY40uGX+XyqLp5bXAiK9o9F+bspTLS6M9tZYtV4YOM
	J5ZcyLgBE5MtJ3H6mEMuIEqPot7c76m6a2k+oOQiW3VywIYzrWq82Lf3sw==
X-Gm-Gg: ASbGncvBcPJaQI/727Lsm6PL1X9q3CiGo/IOMZFGKRPT0YMbBtgH4cab/kEL/RuJHEx
	FdwnF29cfmba3IL3i1v2Mez5gpCPklB4KzR0dz7WpFJOq67TSRjaRR5IFWMFU6DtG2RgD0SdshH
	F1jTWejpjIm3rkjbBAatLQADMFvGe9nkMgpHHvFRa63ObEsUl8vYrmskmz7HQYPobwMnePRmhzE
	4xK4po63h9CIbcHfLV9dCCiZtfO1t548/mHer1R2tODBWs/CrEXWrWg1XOfBcSOsKynp+NyExx8
	bW4nh1FVWe28jQkGRp8w6BJRZ0Irm+9zZxs1XcurMLs=
X-Google-Smtp-Source: AGHT+IHJrHem4FobSHcVfvs5f0EyAlA3E9QfDSbIpbfNOyenxfb0kRQ/tWcHDAuH7gOloKYmWmymiw==
X-Received: by 2002:a05:600c:1d92:b0:43c:fc04:6d35 with SMTP id 5b1f17b1804b1-43d509e3facmr8636545e9.4.1742513508625;
        Thu, 20 Mar 2025 16:31:48 -0700 (PDT)
Received: from qasdev.Home ([2a02:c7c:6696:8300:5ae8:21:3c41:b954])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4453227dsm63194995e9.40.2025.03.20.16.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 16:31:48 -0700 (PDT)
From: Qasim Ijaz <qasdev00@gmail.com>
To: jpoimboe@kernel.org,
	peterz@infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] objtool: fix resource leak in copy_file()
Date: Thu, 20 Mar 2025 23:31:31 +0000
Message-Id: <20250320233131.9555-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Close open file descriptors on error paths in copy_file() to prevent
resource leaks when open(), fstat(), fchmod(), or sendfile() fail.

Fixes: 5a406031d071 ("objtool: Add --output option")
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 tools/objtool/builtin-check.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 5f761f420b8c..3357049d840f 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -201,16 +201,21 @@ static int copy_file(const char *src, const char *dst)
 	dst_fd = open(dst, O_WRONLY | O_CREAT | O_TRUNC, 0400);
 	if (dst_fd == -1) {
 		ERROR("can't open '%s' for writing", dst);
+		close(src_fd);
 		return 1;
 	}
 
 	if (fstat(src_fd, &stat) == -1) {
 		perror("fstat");
+		close(src_fd);
+		close(dst_fd);
 		return 1;
 	}
 
 	if (fchmod(dst_fd, stat.st_mode) == -1) {
 		perror("fchmod");
+		close(src_fd);
+		close(dst_fd);
 		return 1;
 	}
 
@@ -218,6 +223,8 @@ static int copy_file(const char *src, const char *dst)
 		copied = sendfile(dst_fd, src_fd, &offset, to_copy);
 		if (copied == -1) {
 			perror("sendfile");
+			close(src_fd);
+			close(dst_fd);
 			return 1;
 		}
 	}
-- 
2.39.5


