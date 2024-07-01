Return-Path: <linux-kernel+bounces-236954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 991BC91E908
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 500FC284CCE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A61171E48;
	Mon,  1 Jul 2024 19:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ksaHk4R2"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB5B171655
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 19:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863893; cv=none; b=teeRVIp1a77grAyjYagMc6ORKrmPszhGmdnU6dfZh/MVj2HnAlK1FeZntJuw9uE4IRmdo5rZJC+JwvlL4wilz9mdoSyGDe8rfQpw35A/gL1us1pdHfpoXxbME3u8SXpXzVqKaqlREoA4N7SmxN5mZ7AJHrlSI23f7ycgI129cCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863893; c=relaxed/simple;
	bh=eNn85Fcj7KCcSuMYSdoEr0B/RTvkczi9hHJCBqhaPCs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eBf50a1DyemIzRrVGFlVCMbt/1DQ2T4onXTCqCeZUIjkNZ4fq9u+48KdCOaPf6BD8aCCPc4sf9m7ekPmRBtppsPJr6C3mjZt+B1x8323LxnIXh/3sOz7p2ndbEX70s6/E/KGOXu3datr3askA4+zC+mH4na6Nr1bFrSwhmZZwgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ksaHk4R2; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e035307b08cso5793951276.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 12:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719863891; x=1720468691; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NBOTiXxGTl6GNLs3EaV9yCivuLqQXgDZHBD5L6v/nwg=;
        b=ksaHk4R2hDVkHs4kuLAngw7JwLvOM8v6LqbFd0ZYRRAoMC5CzjyyRjlgG5QgJSI8n/
         eIxfgSh4vs344QomzRyv0wgnRtyaIfL7ndVk2bpVf2qgKHmhe3CLvXtSvJFqhKBdFj/6
         ucbVPxUostz3i2YZdowxhRmwN0Zz8+RTChm+Z8yUa8TqOXZiXMx+FjAu9yoX8ngJnEp0
         oi/aLxypOTPq8ycetHkZqZ16/1f8rRmDDH6z+OB7mHLH/kAhi93tsAWVyA2EVOtgMI2M
         QUqMub9s4D0a6M6RQkvmPgjdBH/cb6CGbJ3ULTwyiyYNRBO3YNVd32kC6t4z+KEFxVYq
         NJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719863891; x=1720468691;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NBOTiXxGTl6GNLs3EaV9yCivuLqQXgDZHBD5L6v/nwg=;
        b=AIBVTMZHo4oLfX9ibCcPBJF50d5zEdzczaKeSCwm2BEiMrK1lXCodwLKNzz73JRl3V
         3/iIxJ4pyBQjj5mh9fLwJfauKGLLwlRYHLzG3x9fjLhWxqUYn22jXL3JWw4OEGDYDHOP
         cyc4gBdI0h5/bDczQHeXIaegH0rZfrGhNi7seaqze1c0cbq5cC1lSG+uCsgdBav034O7
         ZZDoj1NmrGFLwLVULU2QcUb9GxjxUWtph9dONgWPStaVKI4tTXKWf5ufPsuIusW/5Mr6
         C8UquSV3VjSjAIZHaVjdMlwnlf+78MCG6VjAUY5+JDg2gM8nI7grAVxRsrpiC3OrHOyU
         oDvA==
X-Forwarded-Encrypted: i=1; AJvYcCU2cN4V6vHq/hIt2tpqofcbEfhgozS9gewhKN7AEzrsmeqVib8c5BJRWu3aHs3qA/j1A4UY59RMx2pntePYk5BVuhfLz/h7YjptSE6w
X-Gm-Message-State: AOJu0Yyw45xOcT82OCvCcu/FlTS5p2EMp9c2E0bcO/GlK7V0vLjI0tWU
	MEf2V0sRhgSVej1a49LBT3YpGZBG965ZPLvzI0URCOlXWcH+e+q7Yshm0K/9OQA/ROvOtUhUQ7o
	sJDoAekYYKA==
X-Google-Smtp-Source: AGHT+IGGuHrEYXjyiMSFh+UBkKB6xRBF3G+mpXgTXcpxTLMS8PdCo5X5+gFF9R+5CNIc/yOizJi+4yBEmjtMng==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:1889:b0:e03:39fb:5729 with SMTP
 id 3f1490d57ef6-e036ec41ca6mr672429276.10.1719863890874; Mon, 01 Jul 2024
 12:58:10 -0700 (PDT)
Date: Mon,  1 Jul 2024 19:57:54 +0000
In-Reply-To: <20240701195758.1045917-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240701195758.1045917-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240701195758.1045917-5-ipylypiv@google.com>
Subject: [PATCH v4 4/8] ata: libata-scsi: Remove redundant sense_buffer memsets
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

SCSI layer clears sense_buffer in scsi_queue_rq() so there is no need for
libata to clear it again.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index ace6b009e7ff..c11ae77d3ca6 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -926,11 +926,8 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	struct ata_taskfile *tf = &qc->result_tf;
-	unsigned char *sb = cmd->sense_buffer;
 	u8 sense_key, asc, ascq;
 
-	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
-
 	/*
 	 * Use ata_to_sense_error() to map status register bits
 	 * onto sense key, asc & ascq.
@@ -965,8 +962,6 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 	u64 block;
 	u8 sense_key, asc, ascq;
 
-	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
-
 	if (ata_dev_disabled(dev)) {
 		/* Device disabled after error recovery */
 		/* LOGICAL UNIT NOT READY, HARD RESET REQUIRED */
-- 
2.45.2.803.g4e1b14247a-goog


