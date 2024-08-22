Return-Path: <linux-kernel+bounces-297951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FD095BF87
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 22:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68EB71C22957
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 20:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AEF1D1F50;
	Thu, 22 Aug 2024 20:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvyWhqho"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9715E1D173E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 20:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724358501; cv=none; b=VXgxlPGTh2I5dal7lgz4iqrryaCQZ+ZrusRST+Adje9wS5HOXvU0b9ExjjODwhrBVUeVxxe5kt+NKmHn/7XwSP3EA/akams8Pap2hs1RSRLIA2W/IsIOs3AGqZQmzR0fN/vDXA4WvXpNTcO3HzAAddKNW2VVXQOahg0yTGrpcy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724358501; c=relaxed/simple;
	bh=UOKVmw1hpJeUfeTwlRyjGxIeLeAGEcqAj99DGptPw0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IusludXrjlt/VBdj1IVjURDsxiPM0+aOwPXdyv6/gX3IPd2COS+DUBP7z4xg8CI4SU7rXMLe4ywZvvDdpbNSPrsK8bdKpUKOmHKBDgT6QhxPaHMhJtBLR0PHm1bLo6+8J5a4qJuejqpVl4L14uCNwL+YF2yR6jQd2MPj2I52Z30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvyWhqho; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-709428a9469so1057353a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 13:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724358498; x=1724963298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFs61gq37YkVZz7WirFZIsP//0+vKUsSxKZKnV0KhqU=;
        b=JvyWhqhoHuAXXbBiWn+kIee2wQ84/ClHRv1Az7pfNxIzkF/nn8r+ZsCccgmRjcGzkd
         V3loiWmkpRaIbAs+DZJfjhDNGtftBz/k3yNRNWOg6RF2FbtfLs4IR+1urmJwvU2wo66E
         lV1LiykACVYx/B9jphm9XXQd5mFS5BIzLQiqok4v59bAKr2/vrCjHdTByF8JAzdKmAiQ
         2M1Cbv/dNaATJ2LgMpsE8MtiUu5LX4IRuGWRKjWNS/jo7F6TA9Agpz0tz2/z8W/7nS65
         EnjLri1wHy0hMVOiMv9dZNB+DceMplb+kWfHf2JxTvDDyBy3raNaOfQnEGGhHgs3EggO
         5Idw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724358498; x=1724963298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SFs61gq37YkVZz7WirFZIsP//0+vKUsSxKZKnV0KhqU=;
        b=ceFIXcquRpyZc8lwNi6HxBB81FQtVF1MAd/6ydS6wxGJ3Fc4sMpDLZQmm1tEnu8LxU
         hM7RY6q0l0GoGjDSLpGu0FsUADzWR35Up2pNycNhr78bOHX16OufFpI/Bo3Kb6RXa5nL
         G8pjaf5ccavZxDEk+CWDjDo6diddxm9wiXDcLQdg15t9FZblpzEfmMLld2+Gt32pG5C9
         zQ3I1NISDyKqgEpdvGKM9id3CQK8UDgjMRbAR+fDmvzQEamTV2gasDnlqXL95Fv+l5jP
         e5zywAKBudNk/E4gnzZEKzi+fQaGpN/p4J6uTdu+gVYVcaiDlb2pRwl5peYrk4QsTRmH
         a/Ag==
X-Gm-Message-State: AOJu0YyXhktHZHScbkAsRW9D5PU1iQiEpumOaJz586l2H18tTIN0W3Oh
	u8AUhiWBRjg3YqKAPCSTQC3d3Z9bE5Bg5bz3iNtmyGb/Qq478UQmV1kwsYyD
X-Google-Smtp-Source: AGHT+IFrVRHrCiCi5cIp28BTyotzWR1lcgkXpE435Imqtgm8r2l4jvzH3zyAhCus82rF+WPtcyribA==
X-Received: by 2002:a05:6808:1b22:b0:3dd:3651:d2eb with SMTP id 5614622812f47-3de2a8932bamr10861b6e.22.1724358498688;
        Thu, 22 Aug 2024 13:28:18 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3de2252d5fbsm421265b6e.1.2024.08.22.13.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 13:28:18 -0700 (PDT)
From: Stuart Hayes <stuart.w.hayes@gmail.com>
To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v8 4/4] nvme-pci: Make driver prefer asynchronous shutdown
Date: Thu, 22 Aug 2024 15:28:05 -0500
Message-Id: <20240822202805.6379-5-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set the driver default to enable asynchronous shutdown.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Signed-off-by: David Jeffery <djeffery@redhat.com>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6cd9395ba9ec..58d0d517fead 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3580,6 +3580,7 @@ static struct pci_driver nvme_driver = {
 	.shutdown	= nvme_shutdown,
 	.driver		= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
+		.async_shutdown_enable	= true,
 #ifdef CONFIG_PM_SLEEP
 		.pm		= &nvme_dev_pm_ops,
 #endif
-- 
2.39.3


