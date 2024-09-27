Return-Path: <linux-kernel+bounces-341948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BFB9888B9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 18:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D38C1F243AC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 16:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D7B17ADF0;
	Fri, 27 Sep 2024 16:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtyGGqJ+"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8AA189B91
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 16:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727453223; cv=none; b=fba/sH1f8Xjf2ZjZHgKr7WaDtOSdci1CCGvDQYnC8giK4CCwCEB+cjnpDSliHftwk4iAi+yrQX///7Ct4cXomUGC8JnPaCAdXSBe8YH1Y13ksUG6RV5X8qrLyk7St9ROZgVHxx8aCDps++MQx/TViaxu5xpbf5zLfVDHzZlEgg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727453223; c=relaxed/simple;
	bh=8R8VLfvJ2OUDls7JSbC9KTjMOxvjjnXa1rYXM0jdatg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t4kfzUeptiF7YGNzrUYfRkXncFGQbfUeCEqQWi/JzqZ70DUklVDP+fElVKv+lByinEf0PARvV6Jt1R+g9v7da9CmhaG4KQXa00kw/FOTvESi5JPJSz/RwczEpD4DByGk5t8l2w2SVpjRMvpSGa82M2mtrq+pMs2ZxZY6nbY7auw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtyGGqJ+; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so1850039a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 09:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727453221; x=1728058021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0e2OQQno5G2t7eZ3Z7x4q0N4c7RNB1RIrrucMjojTeU=;
        b=YtyGGqJ+YCbRr/uXCwIVoNjZy0/Db0qLJ7VlkDpGFFCEbVXBMn2bn1BIzVkL0n4/9v
         ctp+uSVfD9HCEluAE38v3OFH/IST3Us6vvKqa12aG1fKwm/weij7DQHFCusBKg6hohiI
         l6dGVC0FBJHr5s9TfMAPS3GKu9235q2qb6IWVFG1yMNOOkcT8AEJ5dShs0alHvf0zeTl
         kVLNMycDgWc/j1miMQ3EEjFv5uQdE0j9tFEYBSxmOQBZEQgf/RG1bUh0gnW2Pi9QZAnv
         5cPISNX7V2Ctgdj9iVp5XPeMqNeBTYfUF2QSoXk8zEcQasG2d1+utdxs+Qopafyyiaji
         BybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727453221; x=1728058021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0e2OQQno5G2t7eZ3Z7x4q0N4c7RNB1RIrrucMjojTeU=;
        b=r5wf+klKY3Parp+h3WPSl4E7td2vKl2QSJqImSfo5Ro1hdY4VbB74yDQAKio5ZiYhz
         qWeyJ1LtrlR7NZ59MvZyDPLbQTaEVmnqIuvQHPMub+PLKiTSu32LQF/+ykSMLIg9A4BW
         2E9JdZkE0nfSvoBdaL0BR0q3Fn4sHz+P4R3UiR0COBT17XGbCYfcZ1cnxs5lXo4n+laK
         4ykelONzG4ITbA3oRWfzPswQP7cCDLd3+ArA5OB3+6Y2DlVYyXWdH/zdiql4eWobbqXr
         bxlmHC9ztn+4xIeDKZuWovs8rKu7nmtpNkFgSR8fz5ZqfGfFM/CzHWxRECc8ugaTFNG7
         5MXw==
X-Gm-Message-State: AOJu0YyqsraxmIhDsEoJd7gMqDqDmtgRK5Icxm6ZoqzAryJhz14uY6Fe
	v77DdqHfRRTZ6BOhyTgR4uFiWmhGCnjxRxoQZyZ1FVPmiStm6dhL8RDPEg==
X-Google-Smtp-Source: AGHT+IHdtJuVx0zJqlZh5r+D43Yo+UQqo+2/vP9AXMexE6REGrD3V/syTYTFY60GaMLMSZKKNfJJHA==
X-Received: by 2002:a05:6a20:cf8f:b0:1d4:e4eb:73e2 with SMTP id adf61e73a8af0-1d4fa687debmr4966021637.13.1727453221177;
        Fri, 27 Sep 2024 09:07:01 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:a574:73a2:d5e7:da6e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26529d6csm1752546b3a.166.2024.09.27.09.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 09:07:00 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v3 1/2] mkfs.f2fs: change -c option description
Date: Fri, 27 Sep 2024 09:06:54 -0700
Message-ID: <20240927160655.3594366-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

Current description confuses users like they can add addtional devices
with one -c option using commas(,) at the same time.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>
---
 mkfs/f2fs_format_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index d9cdd61..b6785cd 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -50,7 +50,7 @@ static void mkfs_usage()
 	MSG(0, "\nUsage: mkfs.f2fs [options] device [sectors]\n");
 	MSG(0, "[options]:\n");
 	MSG(0, "  -b filesystem block size [default:4096]\n");
-	MSG(0, "  -c device1[,device2,...] up to 7 additional devices, except meta device\n");
+	MSG(0, "  -c [device_name] up to 7 additional devices, except meta device\n");
 	MSG(0, "  -d debug level [default:0]\n");
 	MSG(0, "  -e [cold file ext list] e.g. \"mp3,gif,mov\"\n");
 	MSG(0, "  -E [hot file ext list] e.g. \"db\"\n");
-- 
2.46.1.824.gd892dcdcdd-goog


