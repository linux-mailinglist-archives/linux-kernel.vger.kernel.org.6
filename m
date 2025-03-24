Return-Path: <linux-kernel+bounces-574200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC27BA6E1E1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 997A21895EB1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84D2266592;
	Mon, 24 Mar 2025 17:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SfuW2aaZ"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E68266567
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742838583; cv=none; b=mL9eyl1zKXjjAN2zZFh8j9i6fdDa2GmQ66pDKFEudWZa3ztO8PI8SEOWgWdZPf2c/bIqjGyVhSAWWQxDfod9eXzKrHvKldXJk5Be7C9IKeKY+Jm37YbuZKVVp4Rfx2MVdZAwzVPuGFObbde3/Qjg/PBGwwI+HuKgzrqOWW33YH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742838583; c=relaxed/simple;
	bh=JnmDDcSLS273VKumaze2o0TCWurNnovdSvbi2PRkVqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qvuRqeuOzRlFuWhb4Rury2566iLCZysxU+wZ1uLnaxoDC283mua9krOpKiSJUDIubl6KVPN4Prtff/1Q7qQwb7CLlVuK5xAssO13paRVofDXKzDhMpQ6ytOcXTO6LngsDjvqYeQYo/vRqqa49FvfE8k0CW/NlEtheOMa1XgB1kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SfuW2aaZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-224100e9a5cso90670545ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 10:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742838580; x=1743443380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yz2osXWrElalCzIio0fRrS4N7V336cnORYficYcWn18=;
        b=SfuW2aaZCUznm3bg6s5j1BWhfRWZn1b66O56e3V1kEqP03MZYdXueR4hmiQmdTK3KW
         i9Hw9y5gIKGrgqQjEEoi2i1/IjK2pwVS+C4cdexX7SKmdSkp53Kj+taK7fR6UzNhsAME
         s5nnSOn4DeUDOjklG7fO32Pn1ze67gbq8cIsTfrxDNVUt1Y98Ke2cWt6Qi4X+OBc+Uyp
         FsorsUbnDWO2LhqEjKjjl0IFf1TmP5LUcQ79lX2AxMTCs2k14wor3O8DNIBKc0DU5Yg5
         Ar3o5D5OOI017dNL53rdSV3+J8xiskl19TWu9SGNn28FCvG0kijVLnF74GzNnzUdCJxt
         kwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742838580; x=1743443380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yz2osXWrElalCzIio0fRrS4N7V336cnORYficYcWn18=;
        b=I9Rs6+g96YU+LeLY9/m6nsSp+dL+dC0nmil2Tp6LsQIXGyESKT1qoW7pip6SiVjnIB
         8LEZexHWcO02stYgL/cTEHFuJkLLhtSkzjxKxM21ioXZXZOZkxqDFDnC/PwuNBUtB7sC
         L5s960lng76fdhMbLhEgGOxkYqKoXoQktDqqeC6blK05ne60JbAkp4iioYEvECSHmJrM
         59l7DDhR/N+SkQlXAFd81YGPfqoFlnt/bnbseTVOLw08Fstl/2XBjVcIeY8y4dTki8gN
         lk/eaE0RqjbfWEKBNldM6oME4BxIvv03mE/BU4tyi8oUPG2Ws4ECidGfvaH5rbs4hwPB
         hrUg==
X-Forwarded-Encrypted: i=1; AJvYcCX5JrVP8V7Ap52Cy1Ag8b/UjoUnW3qMyZ7YzjQVc27c1nF+XdYPGmA+gJTQ0aH7DSJpY4/kqmGCY/ufXdE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3J+1Z5YuWx8FXpYgqD++sHdJ7M9gmqkcKeQoNWfZvP0weGRe0
	in3IVimZn4TVnRBZzvJyeb4pUkW9v6atxmC78+x4Q6JNNaDoxxGYhBbiK6Kjd4I=
X-Gm-Gg: ASbGncunK4tZ53mX+PbDAG1P1Xw1i0prSqeEEuN7JarlBy3t7jRKiwNgAmzbLZyOknq
	GA4ZEsZiPv3ES/f0TwQvIP9NqzgjRYGTveG0KiSti24Tbkfw6lCyriPvp+gGkaoL0EZFXzI/qlt
	Cvn0DKgJcE5hai3sZgFyrbbi1oqMU2fjiFfCMtCuHRZbU+EXpLT5GzC4RwqllsF29k33xKpyrqT
	tk+nxjQAxr8X9ZItQK/AwzvNcMMmBt7fgDG+oMdMMt3X+tFzYFnZrijOx32rkfnQlgKEfBFzkGy
	g6+/cgOrCQRd6gcS+j/xQB4biQCkb/jzR+Qsrp1xdVzqfcGS1H0rq12lLlK+zw==
X-Google-Smtp-Source: AGHT+IEvbZLBkadN8enrTpfI1MaG14FFBTGvRXIEJ2kVCjGfPPoMyljKBkm92M3bmOxmimTtPebNvA==
X-Received: by 2002:a17:90b:2647:b0:2ee:d7d3:3019 with SMTP id 98e67ed59e1d1-3030fe95343mr26865713a91.12.1742838580250;
        Mon, 24 Mar 2025 10:49:40 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8900:32c0::e120])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-301bf576c7dsm12505821a91.3.2025.03.24.10.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 10:49:39 -0700 (PDT)
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
Subject: [RFC PATCH v1 6/7] nvme-core: Add support for holding inflight requests
Date: Mon, 24 Mar 2025 10:48:59 -0700
Message-ID: <20250324174909.3919131-7-mkhalfella@purestorage.com>
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

TP4129 requires nvme controller to hold inflight requests in case of
connection loss for a certain duration of time until it is safe for
these requests to be retried. In case there are inflight requests
held_req_work is scheduled with the appropriate delay to cancel the
requests. Add the necessary logic to nvme-core so that all fabric
transports can use it.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/core.c | 61 ++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  4 +++
 2 files changed, 65 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f4b3c6a42e90..4170785ecf21 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -551,6 +551,65 @@ void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_cancel_admin_tagset);
 
+static void nvme_held_req_work(struct work_struct *work)
+{
+	struct nvme_ctrl *ctrl = container_of(to_delayed_work(work),
+			struct nvme_ctrl, held_req_work);
+	dev_info(ctrl->device, "releasing inflight requests\n");
+	nvme_cancel_tagset(ctrl);
+	nvme_cancel_admin_tagset(ctrl);
+	complete(&ctrl->held_req_completion);
+}
+
+static bool nvme_check_inflight_request(struct request *req, void *data)
+{
+	bool *inflight_reqs = data;
+
+	if (blk_mq_rq_state(req) == MQ_RQ_IN_FLIGHT) {
+		*inflight_reqs = true;
+		return false;
+	}
+	return true;
+}
+
+bool nvme_queue_held_requests_work(struct nvme_ctrl *ctrl)
+{
+	unsigned long timeout = nvmef_req_hold_timeout_ms(ctrl);
+	bool inflight_reqs = false;
+
+	if (ctrl->queue_count > 1 && ctrl->tagset)
+		blk_mq_tagset_busy_iter(ctrl->tagset,
+			nvme_check_inflight_request, &inflight_reqs);
+	if (inflight_reqs)
+		goto schedule_work;
+
+	if (ctrl->admin_tagset)
+		blk_mq_tagset_busy_iter(ctrl->admin_tagset,
+					nvme_check_inflight_request, &inflight_reqs);
+	if (!inflight_reqs)
+		return false;
+
+schedule_work:
+	dev_info(ctrl->device, "holding inflight requests for %lums\n", timeout);
+	reinit_completion(&ctrl->held_req_completion);
+	schedule_delayed_work(&ctrl->held_req_work, msecs_to_jiffies(timeout));
+	return true;
+}
+EXPORT_SYMBOL_GPL(nvme_queue_held_requests_work);
+
+void nvme_wait_for_held_requests(struct nvme_ctrl *ctrl)
+{
+	/*
+	 * Inflight requests can be held for a duration of time that is longer
+	 * than hung_task timeout. Avoid hitting hung_task timeout while waiting
+	 * for held requests to be completed.
+	 */
+	while (!wait_for_completion_timeout(&ctrl->held_req_completion,
+					    secs_to_jiffies(1)))
+		;
+}
+EXPORT_SYMBOL_GPL(nvme_wait_for_held_requests);
+
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state)
 {
@@ -4846,6 +4905,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
 	INIT_DELAYED_WORK(&ctrl->ka_work, nvme_keep_alive_work);
 	INIT_DELAYED_WORK(&ctrl->failfast_work, nvme_failfast_work);
+	INIT_DELAYED_WORK(&ctrl->held_req_work, nvme_held_req_work);
+	init_completion(&ctrl->held_req_completion);
 	memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
 	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
 	ctrl->ka_last_check_time = jiffies;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7563332b5b7b..ed8729f93ace 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -356,6 +356,8 @@ struct nvme_ctrl {
 	struct work_struct async_event_work;
 	struct delayed_work ka_work;
 	struct delayed_work failfast_work;
+	struct delayed_work held_req_work;
+	struct completion held_req_completion;
 	struct nvme_command ka_cmd;
 	unsigned long ka_last_check_time;
 	struct work_struct fw_act_work;
@@ -793,6 +795,8 @@ blk_status_t nvme_host_path_error(struct request *req);
 bool nvme_cancel_request(struct request *req, void *data);
 void nvme_cancel_tagset(struct nvme_ctrl *ctrl);
 void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl);
+bool nvme_queue_held_requests_work(struct nvme_ctrl *ctrl);
+void nvme_wait_for_held_requests(struct nvme_ctrl *ctrl);
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state);
 int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown);
-- 
2.48.1


