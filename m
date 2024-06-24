Return-Path: <linux-kernel+bounces-228007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFAF9159A6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76EAE282D4C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832B91A2C1B;
	Mon, 24 Jun 2024 22:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dj8rYbhh"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638311A2573
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 22:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719267157; cv=none; b=gysHaN9Ns/cfkDE0NHhf1gOYpWfu8PxiaM8Iou6cHTEfPALsNV/QbicD7hSGZXhzO/+Xe/8RoVANx6Mhw5gRa2ynw0PBpCZpNoWMIMII76vxIxz6U3y/kklY5xLDiIXUVfUfkasTZuhWB2SJ5E64jGAKnxhdlfROeC14Wr3acKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719267157; c=relaxed/simple;
	bh=Up6V+DxPHud41/ok240Yxqnh88BYXSB4LT1/yseuVM4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MYIfayrxlS25PErJisITLfCP24ZdUR/klfAt9TFEKE/KmsV71RVStvjWFY9Y7YzCm3KlZdo4ZXoVmmy91weX5sShBoHhQGzYmnpn6banlny+sDQZU9E1J0G02H1fKA0RJBhWGel0vt6BCaTcBK8TZ08SEEV1B3r1x+r4t/ClUQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dj8rYbhh; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02ba91b9f4so6449733276.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719267155; x=1719871955; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tUtfz3bhoNl6XZdgw0Jyrha+rGGjCaq3OYUhxmJGLk4=;
        b=Dj8rYbhhg1U61NnC+WnlENUSx8Z+mvtXpEIK3qKgugdZNvOQOmHspwnF+lr9U0KBZU
         Uz1QWa/8ubDpfKa+zAw10x1UjFo1MZO5/1+SI92iNoGxJRACdVY9pRsOdj5sRe1FbZfP
         Ef5s+9lBSP1e4ibSBHrMpTJJVhXzly14XEn3+aB5qWy9N77TwchrIaBWfp6LszhSBDIo
         aWQAc2YFWe3ZQcA23zu58vT1Y0DZ8BVkgv3nPEb19/g18eYPnW5wxRbzjzFF2tHzAbu2
         GtDnPQ4CxHaIWTkSlkb025FmjkWO1ZIELveob2QCWY/gTXWe16I03TQeBhg7Rwt180pz
         cwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719267155; x=1719871955;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tUtfz3bhoNl6XZdgw0Jyrha+rGGjCaq3OYUhxmJGLk4=;
        b=SgibcI4Lt+JWOHChrynmlLehRPNFhmOeGncEyWLlYusPzc7y4nl0Hcza0Bobbyif8q
         ICQ0HhBNLTa9xUfHLzksvW0XPBcp0QZS5ze/D82ANkYNCjHZwO+RYRvt4Tlw8rBR7zWt
         +AUesbXDPHdkAjWWsV3SWdmz8XBLLCM1Arn4zh6+HT+DWbmBc+4f6cE6s4KwVxfPLTD1
         b6aE6GtQt42vo+E7edxGVqXcM5m7k6dlG1JYnPvUxB5Q1k1r++dIJUOG1699C6bI5Ncx
         SNAPwEoA1YvDFgAvwSmB8RzzQEprGV/DTrtzuUxvNV5EzddHbmGr5qnglNz8YlikFI3/
         4JVA==
X-Forwarded-Encrypted: i=1; AJvYcCXKzf6rZZvXyVQiotyKogNweNRwrFKTXcQZiYL2JezwaScS4OT719eYjDHirRScL+JniGQup/4J4gGY+ITUjLTKPpeyeCf401yylZuw
X-Gm-Message-State: AOJu0Yza8KursuemjAbyfuWAH4S7sS75jajlJLgI/3jRRWqTtB+tOi1J
	t//OGk8Ugdr13IMp2kEuynpspXEy5bvGQEq4tyy/pon7SetPt07zwLGj8tRCRRVP09gL/q5fuod
	FQe/AyE1b3A==
X-Google-Smtp-Source: AGHT+IFOerdlJvZ2UgYsr6VZcIvadTxqhWj051FHAGqyrWnnWeZQEP6tOT2f0SoGARXgYQA2WDQyb34wRFw//Q==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:1208:b0:e02:bde8:1057 with SMTP
 id 3f1490d57ef6-e02fa3242e1mr303000276.1.1719267155506; Mon, 24 Jun 2024
 15:12:35 -0700 (PDT)
Date: Mon, 24 Jun 2024 22:12:07 +0000
In-Reply-To: <20240624221211.2593736-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240624221211.2593736-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624221211.2593736-4-ipylypiv@google.com>
Subject: [PATCH v2 3/6] ata: libata-scsi: Remove redundant sense_buffer memsets
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Jason Yan <yanaijie@huawei.com>, 
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

SCSI layer clears sense_buffer in scsi_queue_rq() so there is no need for
libata to clear it again.

Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 26b1263f5c7c..1aeab6e1c8b3 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -929,8 +929,6 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 	unsigned char *sb = cmd->sense_buffer;
 	u8 sense_key, asc, ascq;
 
-	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
-
 	/*
 	 * Use ata_to_sense_error() to map status register bits
 	 * onto sense key, asc & ascq.
@@ -968,8 +966,6 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 	u64 block;
 	u8 sense_key, asc, ascq;
 
-	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
-
 	if (ata_dev_disabled(dev)) {
 		/* Device disabled after error recovery */
 		/* LOGICAL UNIT NOT READY, HARD RESET REQUIRED */
-- 
2.45.2.741.gdbec12cfda-goog


