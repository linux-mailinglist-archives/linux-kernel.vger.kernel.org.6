Return-Path: <linux-kernel+bounces-246200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EF192BF00
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 18:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A19841F22A5B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6EF19D076;
	Tue,  9 Jul 2024 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0n4jxK6z"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30533364AB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720540845; cv=none; b=cdJo2ZgYYvieyr/BXy6T3AjG0HntfPvFbVYbFJUjGKx1nQs5I2b6Mco764rzPEdvM3dqQHumqRPVupYWCSXy+vf6zrcLUalcIeydsci3fJozA/Gb8TzqufV8WG1GR1AToFe+G67fa6MtbrVlupA/CUX17V7VxPYSNo0hYp2Wk5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720540845; c=relaxed/simple;
	bh=EADrzDGkE5255NQqwAYoJHuh2ZZ74HUptIuyct3xezw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=J6hwWb8k+A4QJpCC8PRVXX9TLQ0C04cGu9xirb0hlMF0+q24IbsRPBQGTdDeNLS/sGXVt8nkqwqxiGJZxEbTtfgDpKQ9EzMlR7457w3mUwjNbAVDuJNV6pgjpm+SPgfkjmNCI4lZrGj/tRNbfo+wvCzsGfxc8N8QCya3sUR7ok0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tadamsjr.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0n4jxK6z; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tadamsjr.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-651e54bb41bso89866037b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 09:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720540842; x=1721145642; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ngDjlVaF8v7sv5bAjkzKl4Op2nALhKGKwrU4Pph8/BQ=;
        b=0n4jxK6zKihGW9VotsO8MW1S90BDsBVqCj737893wbkHaf19EESuiD5vRlePlsJa1S
         wW66exZiCS5qY1Tygk70l4M8/ckNWrHTuRDy/BQ/EmJl2Eo3bgxS7CWo8CCRbu2RBb0C
         yB2F0iEaD2ZFRQ/n6W9jkPedpb9NtNeuPZQ+N5y3zTzG3DO/BSAN+BxGr7J6Tu1FvdQ4
         Z6bhcPGGmQcF8UAucG38yAvMfrb8qP9stFakIelsgjmxAVrBI7OJuTfnsBXmIXVD8cri
         kAggcR1s2AJ3vmtZuxCDkn7cBY/DrxW94y4MyAP/Op/C3nsGDvOhzxFCgvuweWyznxF5
         Od8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720540842; x=1721145642;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ngDjlVaF8v7sv5bAjkzKl4Op2nALhKGKwrU4Pph8/BQ=;
        b=k3l2zbEvYmSdlq4U7qnCQQFf90fHC0Noy8qH8fXeHqA+rzhaItv3flYhFJNF5HME2C
         5maf2kfTEscXTNZo+SMEvjMTQsICYqz2MSJzYkHNKwLB/TF5WtaECCLLLAvkL6qdBWsN
         SUfcLySkxtLU28UuXM/JlgBP9CHAlr+vC0yDiSvY8H1GPbRLJtB8+WBNmTmzdDvb0mDG
         WZJfjZcHOkW/aNM0pJVcWEzg0MLLlXTIrWhEQY24KRYl+5cW+e0ukKttySl8Nz0WEwv2
         tQBCyrR7jWwckalez2e6c8iTBT33b8DpVAmtwO2SBJSlQkGJTEpWxWTRI88dXuir70Sc
         swzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMMLBYqLkTrAy6yy03bPghP+ef861kJfO44KffNH+mBWTuP+iPmRJkJXFm8wg1w1wYYtq0HixoSOU5wRrz6C/qhUpupJ3R+xVdulIf
X-Gm-Message-State: AOJu0YyHfpwsSXFek0r93bfAVgTQvgVmIpvBYderItnRhuMB7n/caU78
	Dy5IIgvoQ7toBf2yOVNiNnv9vyz9xSmf4MOxz5mdCfevYrducTiE46cfADwnJ+vdXwzamTCZ/rh
	TS0GohacpZQ==
X-Google-Smtp-Source: AGHT+IGZ1NCoisbeTLsLpo/X5VPW/CXhcfiq+eOQ0Xf/LzqyQD0jzaYrPITCYcro3gnXPMfrn/QMGHExioj8Hg==
X-Received: from tadamsjr.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:177c])
 (user=tadamsjr job=sendgmr) by 2002:a05:690c:60c8:b0:630:28e3:2568 with SMTP
 id 00721157ae682-658eeb6df10mr151767b3.3.1720540842268; Tue, 09 Jul 2024
 09:00:42 -0700 (PDT)
Date: Tue,  9 Jul 2024 09:00:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240709160013.634308-1-tadamsjr@google.com>
Subject: [PATCH] scsi: pm80xx: Remove msleep() loop from pm8001_dev_gone_notify()
From: TJ Adams <tadamsjr@google.com>
To: Jack Wang <jinpu.wang@cloud.ionos.com>, 
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>, TJ Adams <tadamsjr@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Igor Pylypiv <ipylypiv@google.com>

It's possible to end up in a state where pm8001_dev->running_req never
reaches zero. In that state we will be sleeping forever.

sas_execute_internal_abort_dev() can wait for a response for
up to 60 seconds (3 retries x 20 seconds). 60 seconds should be enough
for pm8001_dev->running_req to get to zero.

Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
Signed-off-by: TJ Adams <tadamsjr@google.com>
---
 drivers/scsi/pm8001/pm8001_sas.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index a5a31dfa4512..513e9a49838c 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -712,8 +712,11 @@ static void pm8001_dev_gone_notify(struct domain_device *dev)
 		if (atomic_read(&pm8001_dev->running_req)) {
 			spin_unlock_irqrestore(&pm8001_ha->lock, flags);
 			sas_execute_internal_abort_dev(dev, 0, NULL);
-			while (atomic_read(&pm8001_dev->running_req))
-				msleep(20);
+			if (atomic_read(&pm8001_dev->running_req)) {
+				pm8001_dbg(pm8001_ha, FAIL,
+					   "device_id: %u: Failed to abort %d requests!\n",
+					   device_id, atomic_read(&pm8001_dev->running_req));
+			}
 			spin_lock_irqsave(&pm8001_ha->lock, flags);
 		}
 		PM8001_CHIP_DISP->dereg_dev_req(pm8001_ha, device_id);
-- 
2.45.2.803.g4e1b14247a-goog


