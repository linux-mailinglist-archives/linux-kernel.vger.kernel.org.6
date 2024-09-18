Return-Path: <linux-kernel+bounces-332383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C7397B911
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA6441C224D8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 08:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC41E18CC10;
	Wed, 18 Sep 2024 08:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKJxxqlR"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB0618CC08
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 08:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726647122; cv=none; b=K0FJ5gukUUhyDl6e543SiRTE1d7ZtRZrQ3JLeFY9ngcTiiIRHiKwnCcQCOM2Bbwi0LTAthJDKxv4uMUAzXcuqgDfUemmTMiTHFmYR+TvAJJchQHouNm8T5w8SyzOFQ1eSf5b14U5nEwG3ZzRNhFkx38EtowQgBy0j/ilDfbRw6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726647122; c=relaxed/simple;
	bh=HqLgz5W8L3Z2ToDYujWMwqQ7NVOvBNWUaY5XOmPswog=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mc+2DBAwldlzVVt0pS3/F7r4lSxEsagA4I3K5+K9KGV0meCoiYNLh+sxKx75Hy1OmZV72ZSHgzgrylquLhClCw/53pr7POe3PT5lW/DGUo8k4rMigL5WUNFcPWRE/U+u4svTbgVZCc7+OPE/lEPF1fON1MSvr+OE38FoHmQh9iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKJxxqlR; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d8abac30ddso5375961a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 01:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726647120; x=1727251920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b2cqOX2dSMOJQpwfNpcENwnMnrm9vyfSvRfrGoQ5NYI=;
        b=eKJxxqlRjEU9v2qzmi3OflgI65YovhalWNcwBuk7t/eP8TbZv4X2PV8PNSAuwlLX7B
         OJdpeODc3E9y09Y8WLWOKhfzLbbbe7rBSqvjKL48exKQb7f2znOzO4ls9nbaO0XrHWsj
         tgqMWtjPiWZtPg1pnp6kmjaE6mIMxpvRwkmPEihlbhTQ1nbmULqq9+4NbezL6kMF+Pba
         t5j+DE6Ww1g5WSx1gzHBv7aUog85grzEGbQzneaS8cVYS3QWlMuvSNctpD9e7nOzZKOT
         UNNAVLPgGJeksDb2LgWVQYhCdOzRkqqlFOoyxZHDeRpUuUX9WTi33n+kVXGOy1cn/+xm
         TD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726647120; x=1727251920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b2cqOX2dSMOJQpwfNpcENwnMnrm9vyfSvRfrGoQ5NYI=;
        b=W+FumjoeTjIYViRXYHN5dXVSrxPZQN2xGYEybvhlk+E9AbwqyjMbNFM54Mifct8ZES
         Q2Thq5zgmOwQSOfh5/bsrIaidWPpe6XWz/79Grq9QHSkjbY+YH+WzvvZbc/QghjM+52a
         MVGKjl9+jkuHPOGpaUwSWDCOss6lOfAHMjgrZ/4Cydm02Fe3mptz0hjoDh+WJSHRztFu
         YPhIhsiKH3TAG8acuxLqzPsRRqdm7RPZFle186MyUCGkzceqmYBYdnSy1ei6HxVzpfmu
         LvzFf5nC8pA09krsMcwCZF60wBuam0rMUwWWllCj7WWe3UyfuRUIdsZ5xzGSVuiYtyw3
         NLUg==
X-Forwarded-Encrypted: i=1; AJvYcCU8GFsESrY3YLSgR2z4EXlcofIYole5OGeB4IKbnPRbjIBVnDxPK81l13fRPgndZZJvxmaZ/U3jKH47LaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBvNsJSy057E99Tym/uvDNh8c1Q6a7Dhu19s7A75fo2xMibg0C
	A2mw5FGonGbDJs1nFiKfPMhipZPwcivNLwjZYItNalnWmoOWXne/
X-Google-Smtp-Source: AGHT+IF3TbuagLRJ5khlQ0Ro6XlrWxJIZHhyFFdaMnXUyxVG9aYDTi47WYS9w9Id5VWpekDFXOryDQ==
X-Received: by 2002:a17:90a:d791:b0:2cb:5112:740 with SMTP id 98e67ed59e1d1-2dba0062abemr22277547a91.26.1726647120029;
        Wed, 18 Sep 2024 01:12:00 -0700 (PDT)
Received: from dev.. ([129.41.59.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd608d1939sm904648a91.33.2024.09.18.01.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 01:11:59 -0700 (PDT)
From: Rohit Chavan <roheetchavan@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Rohit Chavan <roheetchavan@gmail.com>
Subject: [PATCH] nvmet: Fix warnings given by checkpatch
Date: Wed, 18 Sep 2024 13:41:34 +0530
Message-Id: <20240918081134.908075-1-roheetchavan@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch addresses below issues produced by checkpatch script.

ERROR: space required before the open brace '{'
drivers/nvme/target/debugfs.h:25

WARNING: please, no spaces at the start of a line
drivers/nvme/target/debugfs.h:35

Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
---
 drivers/nvme/target/debugfs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/debugfs.h b/drivers/nvme/target/debugfs.h
index cfb8bbf6a297..166de8c7fc49 100644
--- a/drivers/nvme/target/debugfs.h
+++ b/drivers/nvme/target/debugfs.h
@@ -22,7 +22,7 @@ static inline int nvmet_debugfs_subsys_setup(struct nvmet_subsys *subsys)
 {
 	return 0;
 }
-static inline void nvmet_debugfs_subsys_free(struct nvmet_subsys *subsys){}
+static inline void nvmet_debugfs_subsys_free(struct nvmet_subsys *subsys) {}
 
 static inline int nvmet_debugfs_ctrl_setup(struct nvmet_ctrl *ctrl)
 {
@@ -32,7 +32,7 @@ static inline void nvmet_debugfs_ctrl_free(struct nvmet_ctrl *ctrl) {}
 
 static inline int __init nvmet_init_debugfs(void)
 {
-    return 0;
+        return 0;
 }
 
 static inline void nvmet_exit_debugfs(void) {}
-- 
2.34.1


