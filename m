Return-Path: <linux-kernel+bounces-574199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CCBA6E1CE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4497317157B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE742266572;
	Mon, 24 Mar 2025 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="W3MrjqMJ"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90279265CC6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 17:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742838581; cv=none; b=hRub8hoEEPb68ZBR888nvoAS6o4BINVDXkigbaJ2xU1G05aDNksCe9h5VenmTYlC4y4xD0KJ8NUdhRR9XN2Htoih1dC5sCsqunpDRrwu+S+WayGzHO3a4+ambAl/CAV17+3ppY/h+AURWAOHYfWtlwOpEXUUgf4BPicFVCpWfWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742838581; c=relaxed/simple;
	bh=R7JqBxN8V9FjabLupUaJBqhvpFGaXMiTK39i2yzUq/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPyiLKH109QvAxDBTczGYJIWP9HUA2WnVwJSgmqKwEdZagvAiLwBPhro1MT5VaJOqB25Bgo7c72pFWO17HRyGuQ4W+C8SWKxpq45xJkDpTsLfrPpio/ha3QAl6m55pQPL4Gs0C4AAE8WvC4l3j8CV7aO+K7W9AFs/Fn36XC6bic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=W3MrjqMJ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3014ae35534so7276562a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 10:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742838579; x=1743443379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zI9pTE09SEnCUUwuhvk6jLvhp0JjIoGziaSbN4eddKE=;
        b=W3MrjqMJT+7wSwaa3+xRt9bI9aIWUA0nbpRTVL6ahdTvBJ+bq+2UO3Qa9rdI05c5+L
         lq9BV5Zr7qnmK/gWBe9Uu0OuYCqjYiGbz829GwE2jXRZQeTw86oY7SLXiz4VlozYPbXj
         +BAI2Nt4JQInEMT5YDGRpxDUtQ6fW/aiAteycMSJVD5hsNRd0l2NuVDoTd010iu4Cd8M
         iM3MzMc1svjUAI8KWkxHZGEBeIuf//mg732t9ZzEhI5gB0zQ/vk/JPMRA87AQv/09tem
         zfBvP1Y9k9J/MdSb0qeJRmiI4unJJTXVcV0+NX7TBp/pU4Y9ecteYBudBIgHvcSCySKC
         0Bow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742838579; x=1743443379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zI9pTE09SEnCUUwuhvk6jLvhp0JjIoGziaSbN4eddKE=;
        b=Oqr57GwKNJ+WbTjMQMzQ08nsr053sPGoFxTW5wbFtnhx5CIt8IcTrDjFpmYm7qlEdj
         kcItgz8I9f60SuMdMyS4/S9TGfhpJvsl3lNpgbkrQXXVl55fKIFJNUpDPJNKn9MaPLr0
         FWt2Kra2fNQCqIKQxq76tWXKuGKJBhenIPI1kAUXp3VRPFWJDmNowLMLu6vUZ/Z8tZlh
         /nzbG9+5eHibj8rjA/RJ0oLE3eP5lOlkVBz0KzPzi7h89px8HlD3qz8gPt0THJ8CxsVW
         Oiy7Jr/iaR1HIldbUwBZ6TJgmdKPM5HkvNw2m6oJDis2Yir/15swOrnPSzs6SHOQz5Nv
         A3/A==
X-Forwarded-Encrypted: i=1; AJvYcCX9Q9urfMKhhUVbwjTW14bSgw+HVgUcR2wuJUJ0knC/DlLQXvMN7O6Gc3WlbHqjgwUKlpBXwxKcTl7pWSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfVwsa1Q+tRSji+XbTXpbVrh84vEmXtiDwmka1/ozx+3KLdrWn
	Q/T3iapO8cn/L5VKm2TwuPFtrdkO9yKSbAscXICtIHnMrNkuYCByF4adf6+E7EpAOvAPiDcwCvI
	q
X-Gm-Gg: ASbGncvx7LZcGoabx8wt7N1Ysd1QG/0UeJdn0h3wgabTsP5eOMB1mWkhgZcgFFrMA5J
	HbTNhNp2FY7lo7WNbAp1Dne84csKmzNpIgO+ZyVm2u7WaP3vfBQr9Q55QUwwczH8e2ccfCiYiSc
	wBOCAEVVFprtuJjGWoLXRGk1AO/aANj6G7iANMoCZbN8pcWfhz1dd6yOZvtyga1cDb08ujhAauj
	UDvpk+iARIL8I/M3bYMfp+JNKB5wqH3LaMpEqfpScXPjdfC9HDN7p9boHdhESQ3CL8A0iQWw3uM
	0bDPPPUa1H7vWDNJf+v6kd5IXncuuGhCJ6SDik9BRiYE8pxjXvY=
X-Google-Smtp-Source: AGHT+IEizjkumELeU6R9jqpR3Ax4p0YRM++REqcaqTU4nNn7wsmzFTI5FqCg8QkO6jKcVZ9UpRwPhQ==
X-Received: by 2002:a17:90b:5408:b0:2ff:6fc3:79c4 with SMTP id 98e67ed59e1d1-3030ff10972mr18601100a91.27.1742838578680;
        Mon, 24 Mar 2025 10:49:38 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8900:32c0::e120])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-301bf576c7dsm12505821a91.3.2025.03.24.10.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 10:49:38 -0700 (PDT)
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
Subject: [RFC PATCH v1 5/7] nvme-tcp: Split nvme_tcp_teardown_io_queues() into two functions
Date: Mon, 24 Mar 2025 10:48:58 -0700
Message-ID: <20250324174909.3919131-6-mkhalfella@purestorage.com>
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

Move code that quiesces IO queues out of nvme_tcp_teardown_io_queues() in
a new function nvme_tcp_suspend_io_queues(). In a later change this
allows us to disable nvme controller without needing to tear down IO
queues and canceling inflight requests.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/tcp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 99533ff1ea20..327e37a25281 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2266,12 +2266,18 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl)
 	}
 }
 
-static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl)
+static void nvme_tcp_suspend_io_queues(struct nvme_ctrl *ctrl)
 {
 	if (ctrl->queue_count <= 1)
 		return;
 	nvme_quiesce_io_queues(ctrl);
 	nvme_sync_io_queues(ctrl);
+}
+
+static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl)
+{
+	if (ctrl->queue_count <= 1)
+		return;
 	nvme_tcp_stop_io_queues(ctrl);
 	nvme_cancel_tagset(ctrl);
 	nvme_tcp_free_io_queues(ctrl);
@@ -2411,6 +2417,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 
 	nvme_stop_keep_alive(ctrl);
 	flush_work(&ctrl->async_event_work);
+	nvme_tcp_suspend_io_queues(ctrl);
 	nvme_tcp_teardown_io_queues(ctrl);
 	/* unquiesce to fail fast pending requests */
 	nvme_unquiesce_io_queues(ctrl);
@@ -2432,6 +2439,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 
 static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 {
+	nvme_tcp_suspend_io_queues(ctrl);
 	nvme_tcp_teardown_io_queues(ctrl);
 	nvme_quiesce_admin_queue(ctrl);
 	nvme_disable_ctrl(ctrl, shutdown);
-- 
2.48.1


