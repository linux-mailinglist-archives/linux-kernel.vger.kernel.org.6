Return-Path: <linux-kernel+bounces-574195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACC7A6E1D0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53E6018866C5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B632226561B;
	Mon, 24 Mar 2025 17:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Y8lB0HyE"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E28264A99
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 17:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742838575; cv=none; b=cztWT2gnixuWbD06fPR4OnnHIhevZFPaWlN6KIkxIRFNop2b9KeyVvJUqwDibcTOpjgzAI4z0GaqW81cRGvWO/UbR2mbitT+3NOuHnFHnqkHRbd32tPm4Bw6CgaY4tEsSY1XWGonLzXlmvYWHmu5DA3tv5jq8YH7PDsuhT2UJLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742838575; c=relaxed/simple;
	bh=4j94bufT7HnwQcprsQZX1+HV8cxX6mI4SaZRbmV9p6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WiNyKpgujn8h6NVtqLY2uHYVrjrt8yvpg5NlxHBHFC1SkVQyQz2HZJDhqFZEcxtX5wl70cASYsWzmshbs3fwdw43ombrF0wIPgxV14WiEajNTTa83jAvW2QSMJSMCjLNBDjS4zvBEW1nm6G8nk0/KgWM3pulxMfOFjtLFiS8k1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Y8lB0HyE; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ff615a114bso8420181a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 10:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742838572; x=1743443372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1sv49oDN1xKsV2NUXgnCogWe3PpX1iIJir56ZLLLVGA=;
        b=Y8lB0HyEQRH2fiQvYjCCU6WO8OlmOeXdrPO2krkvrrYIvgWt6jS5AHFzks5+cTcruP
         H/GJ8CbIgVusbbzB/yzXVeC/kx2FV1jZ+WAg2JvrZt3He4ENKRfLui/1i9cU1SOhphTr
         p6AqiYSAiq2GuDGL5brj3we+ekK1jyfl7smjUh3pSazYDv1zL90R9yq+H2SDuPqDGkzm
         FeVMc4gEivtfKnXO+21Czhscor+jN/mZUJNEzL+zqdnyOcYuMKOXPB1i5YsWAlofrY1V
         XWlg6F9osZK7fesAvC/eIG2ZfBrGU93ZeRsa/d/k6UvEX9f/DiU87eCJ0pnYSYw6vYaI
         vCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742838572; x=1743443372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1sv49oDN1xKsV2NUXgnCogWe3PpX1iIJir56ZLLLVGA=;
        b=gZBw+ZmXZSCSpvThY6yMpbRAIcgsNaeGw7gYrOoQHePv/QszY6WuYGx3oY5g2Su+/c
         GqEW54VzY0ESTGL7Wou1wH1B2UvOjiGKFm59YEBqSMONRaCxgK+mSjQfXsP31h1/LTuW
         TEsLjMUAAQGdSqZlks39lyvqA4u/ebRuUBC+LCp1LE9pVKsD7GH3KCsaqhquYOMSsOGE
         3aKy0xpZOSul0H67IkX7vx/hbKGaeZq1w6GVQg4BnLPoZBlbVmtW1Qc4EsmaX+hn5UYk
         c6CEqmxfiXZFJJSyosFj4NqPqbVYDmRZp0LnHZFeucoylm3zwrSC6EXDf01TI8eXgZPB
         9QHg==
X-Forwarded-Encrypted: i=1; AJvYcCUcIIm1xp1C57rKVIwGIyEm8ttxr0pKDgXCi1ZTIvPw5fD923nUKFgeW9wm+aB5iQw4A4x3k+grpPbdjLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW+oC2603k/br7UCNiV+zzuf/XHQ7P4q2aGcWzT0QnbxeDvHhL
	aYpp5myzf4D+zZatQX40iGoOlmMhKgDQo++KYu0LYUlLbAJWZkP0s6XRWI6gJvo=
X-Gm-Gg: ASbGnctQ2NFq18wIlgM7Bq3YJzzxAQtez6RR6dnRkQyWEUXKEZzjYZcH2opEdpEQ4AG
	pYDWtx9910d0Z9RNj0pMlnLFe3ieYN/efWosXd+qjHtJC7fgbuUFeETTq7Fx18Q02jfuIQHj3QW
	n+bJXEfTlwRiBD+eijk/zT/z9uDKoXRUcx4i4ZPewjWCUWthoIE/WLM3nEIEPNzBIPhHrlvhbb1
	iPohhlI8UXhjJdU6eC7b/zh0fQmJb+m299TJDIv+d9vBTu3LdVtPbacF5tCM+VVtgPnVLeqz8lX
	DaRxYLwnvOWivahnar0i/pJhmpXIJykbwZDPZ6zDa8Qneri9kgHdO/rmZzcTGg==
X-Google-Smtp-Source: AGHT+IEe9Qsrj9Tx3gawv4u8ZXOCtS9RKc+Qk59288o/J5HEW/yh9fX1sI/yXy0vvkeFj8ITzHdkKA==
X-Received: by 2002:a17:90b:3844:b0:2ff:53d6:2b82 with SMTP id 98e67ed59e1d1-301d43a2db5mr29060034a91.11.1742838572358;
        Mon, 24 Mar 2025 10:49:32 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8900:32c0::e120])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-301bf576c7dsm12505821a91.3.2025.03.24.10.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 10:49:31 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <wagi@kernel.org>,
	John Meneghini <jmeneghi@redhat.com>,
	randyj@purestorage.com,
	adailey@purestorage.com,
	jrani@purestorage.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mkhalfella@purestorage.com
Subject: [RFC PATCH v1 1/7] nvme-core: Read CQT wait from identify controller response
Date: Mon, 24 Mar 2025 10:48:54 -0700
Message-ID: <20250324174909.3919131-2-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250324174909.3919131-1-mkhalfella@purestorage.com>
References: <20250324174909.3919131-1-mkhalfella@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jyoti Rani <jrani@purestorage.com>

CQT wait tells us how much time in milliseconds nvme controller needs to
quiesce pending nvme commands after learning loss of connectivity. Read
it from identify controller response and store it in struct nvme_ctrl in
cqt field. ctrl->cqt will be used later on to calculate the total time
inflight requests need to be held before they can be safely retried.

Signed-off-by: Jyoti Rani <jrani@purestorage.com>
---
 drivers/nvme/host/core.c | 1 +
 drivers/nvme/host/nvme.h | 1 +
 include/linux/nvme.h     | 4 +++-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8359d0aa0e44..f4b3c6a42e90 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3364,6 +3364,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->oaes = le32_to_cpu(id->oaes);
 	ctrl->wctemp = le16_to_cpu(id->wctemp);
 	ctrl->cctemp = le16_to_cpu(id->cctemp);
+	ctrl->cqt = le16_to_cpu(id->cqt);
 
 	atomic_set(&ctrl->abort_limit, id->acl + 1);
 	ctrl->vwc = id->vwc;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7be92d07430e..7563332b5b7b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -344,6 +344,7 @@ struct nvme_ctrl {
 	u32 oaes;
 	u32 aen_result;
 	u32 ctratt;
+	u16 cqt;
 	unsigned int shutdown_timeout;
 	unsigned int kato;
 	bool subsystem;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 2dc05b1c3283..7a94c01f0f06 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -361,7 +361,9 @@ struct nvme_id_ctrl {
 	__u8			anacap;
 	__le32			anagrpmax;
 	__le32			nanagrpid;
-	__u8			rsvd352[160];
+	__u8			rsvd352[34];
+	__le16			cqt;
+	__u8			rsvd388[124];
 	__u8			sqes;
 	__u8			cqes;
 	__le16			maxcmd;
-- 
2.48.1


