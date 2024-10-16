Return-Path: <linux-kernel+bounces-367776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7206E9A06B1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3F851C2169F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4B8206065;
	Wed, 16 Oct 2024 10:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SA9Axwvc"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D7729A0
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 10:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729073364; cv=none; b=S/TWo7JpmHRY0DGLBBUA2CxfKGTkNxpBJaOKODvVdIZWfY51y97EuDS+T7tjSrSxJzCfOp8UQw8sM1ypzXzrNzy/VNeRnPbz5gK8mIuFwPYgDy8reCjLJRn4jSsKvMX9qkOYFPfrdJtFcsJp/4ufdNWvDw6Oc/7QpdZKRvnD9Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729073364; c=relaxed/simple;
	bh=vW6bLjcy/pl0fAh7JW84G9l9ES/1yZCeylRd6BjSsNo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QwCnMO5NMfjnvEbQorhZFuYUIoWpzqWXeeS3Naje3zLp4CyFND7OH4mwKwyhs9rE5lYs+avxL1CNPC0Z/pYV7EQzbV9sgJpgTksjdKUh0pi95S/2/so6u6xDQYBG9l1AfHOjpf6PvVqlZAFTZwCaEinhZ0gCgdDcnlNCWFbeG6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SA9Axwvc; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20caea61132so42135975ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 03:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729073362; x=1729678162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WQpuP9fIuZ2xvwadQMd8xjOFC7uTJ2t0OgVhVU5345M=;
        b=SA9AxwvcdK8zq/0yX8s8R0Sbfcea38ho66NxvXIpmODikYiy9Up4dqgxYI7K+BiOQP
         XFzQhyHEP0salX71raSFkcAcAUzW3IA6vA58gtMarfNk31dCsMRDEmFHii+hO80kZlFo
         NF5QtGPvLGNaz5Aaq7f91L7wTJy+oQFYXAEPf/qNEeFc+VMNGtkEKwqnVnjaz9xMKnZn
         Y+tqDpUZF4Di26Bl6OSjlL9iP8hTunfTeDwT5FsK743pgjNHY1oCCR61wKIzBdKHCtyp
         ox7khUbhW56Pc64+WD0Z3RMIn4/Sz7C8l2//HUBguD4rkFYCf4PVf3uAsrCYnYtUDRiP
         12PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729073362; x=1729678162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WQpuP9fIuZ2xvwadQMd8xjOFC7uTJ2t0OgVhVU5345M=;
        b=gLF5RxIEkcQtmoQvEYcvQnoZjIiLiJ9lpCrMxPChzN8FAo77ZoLy1Dv9NeEJiBasOj
         jhaTWXR7mBuKCLolCJCS5WdbFdJR45gVxLnC8LWqm2y9fLZZU6h6u0mAiIG2xxm0JSks
         nrOgXdLK1PxOqzJvJUNgFMg1BcLkNfM8jnHDMwF9ZxpDMCxQVsVjtuPLw+2Et6gOg3La
         LUlXjMBN4/O0G7oaZShfS8zz86exqvwmxscn/CnqNvtr95X2RyAa5jvohgby06DL/SvA
         kzoX4m+qd/6C1rSUg3RvsPngzaeNDaGFQ4sIIFOalwMEiUqcdLU2+BW7+C4okQp7B/tY
         QKYw==
X-Forwarded-Encrypted: i=1; AJvYcCXLfeE65JoPFlnNeJT8r/VndlM+0uBnrMAnwCdySvFJh/zwavS9VdEmgpvjP6/UsHNzjLxE+APht6YmNf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YytO9E62B/cm31o42GJNf9WEesuJ/A1JGc/Vce1N7Ke7DnxDUGK
	sXYlofeXwQ+N1k1mzr5drEQUsc+BfZ53QSoZTt0+MN1TN5qc3YTt
X-Google-Smtp-Source: AGHT+IF4xzsvzpE2nMgoZxvSCdgyzQYghTx0/iF0GHrYaGhy8YZPVt+SYZiydNbibKmAzBA5RCJKmQ==
X-Received: by 2002:a17:902:e548:b0:20c:968e:4dcd with SMTP id d9443c01a7336-20cbb1a9879mr269031385ad.7.1729073362535;
        Wed, 16 Oct 2024 03:09:22 -0700 (PDT)
Received: from dev.. ([129.41.59.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1806c6a9sm25560355ad.302.2024.10.16.03.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 03:09:21 -0700 (PDT)
From: Rohit Chavan <roheetchavan@gmail.com>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Rohit Chavan <roheetchavan@gmail.com>
Subject: [PATCH v2] staging: gpib: Remove unneeded semicolon.
Date: Wed, 16 Oct 2024 15:39:14 +0530
Message-Id: <20241016100914.1617475-1-roheetchavan@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch cleans up the GPIB driver by removing unneeded semicolons.

Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
---
 drivers/staging/gpib/tms9914/tms9914.c | 4 ++--
 drivers/staging/gpib/tnt4882/mite.c    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/gpib/tms9914/tms9914.c b/drivers/staging/gpib/tms9914/tms9914.c
index aa2308cf5477..6d75294412d8 100644
--- a/drivers/staging/gpib/tms9914/tms9914.c
+++ b/drivers/staging/gpib/tms9914/tms9914.c
@@ -439,7 +439,7 @@ static int wait_for_read_byte(gpib_board_t *board, struct tms9914_priv *priv)
 				     test_bit(TIMO_NUM, &board->status))) {
 		pr_debug("gpib: pio read wait interrupted\n");
 		return -ERESTARTSYS;
-	};
+	}
 	if (test_bit(TIMO_NUM, &board->status))
 		return -ETIMEDOUT;
 
@@ -473,7 +473,7 @@ static inline uint8_t tms9914_read_data_in(gpib_board_t *board, struct tms9914_p
 	default:
 		pr_err("%s: bug! bad holdoff mode %i\n", __func__, priv->holdoff_mode);
 		break;
-	};
+	}
 	spin_unlock_irqrestore(&board->spinlock, flags);
 
 	return data;
diff --git a/drivers/staging/gpib/tnt4882/mite.c b/drivers/staging/gpib/tnt4882/mite.c
index adb656a5eb2c..882cc4bc122e 100644
--- a/drivers/staging/gpib/tnt4882/mite.c
+++ b/drivers/staging/gpib/tnt4882/mite.c
@@ -82,7 +82,7 @@ int mite_setup(struct mite_struct *mite)
 	if (pci_request_regions(mite->pcidev, "mite")) {
 		pr_err("mite: failed to request mite io regions.\n");
 		return -EIO;
-	};
+	}
 	addr = pci_resource_start(mite->pcidev, 0);
 	mite->mite_phys_addr = addr;
 	mite->mite_io_addr = ioremap(addr, pci_resource_len(mite->pcidev, 0));
-- 
2.34.1


