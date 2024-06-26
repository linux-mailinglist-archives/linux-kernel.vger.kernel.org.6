Return-Path: <linux-kernel+bounces-231420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA357919882
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 21:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07B961C21AE0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC21119408E;
	Wed, 26 Jun 2024 19:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KY9dT8J2"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA74192B88
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 19:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719431239; cv=none; b=IMDM7a9KAD8d5oxvozoDAcOUbyEfwxkBK84hmPxXwXwB30MLVZmjsaf0ayOmajCYOr6QkWNW6fvDhsImXIGtSybhrj3rXnkxQWsXQ5A8V7yCG9Lv+bP/dh2simtUeGcMJMU2VneFOyfKQeKTjbnmJSuGc6eNZRDu8tQ1lbveQ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719431239; c=relaxed/simple;
	bh=sTdUENHSC3zhjJq53bao9mwxCnxqZvoZJKSCKbBoydc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IW7e0d9i68yBWV9jBMgxLcizFU47Cwt0YMYTvnndKbwSLFkfuQEmuENlMbLI+YOzuUd+LPsi0qEWVu0loYywymITWF0kIHyoAcW/HP443ZZ6O+LvY2QYnJuhERClLGaFqqJ24PuMByeBolBMZcTMMo3ED0CAL1lr/25qGvb1xS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KY9dT8J2; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6b5253ffd24so21213956d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 12:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719431236; x=1720036036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXDZTLeuWuzR4JFBbSliTdNmKT1J60juYffwmH3Ya+w=;
        b=KY9dT8J2QKvqCMCAM0hleNlb+uR+WuE9c4j7ekLe7S/gn0pnHT5K3mLg6sBg5VJzq3
         SNBvumMstKY7U62ujHldJWxLx5SyZS9WdTdp70BlzcpTHrsfwuaqTKRG16C3n8hyrZIt
         Lct6HGFiyr+9fX2cNjHh6HkvhsdXKc1xEECQL+AS084C6VnGBpxuP3z84TaVspSIYbjc
         pdP3qutsI+9cVUp9deT3q3GPf04lOOcmcM8SWRdzMXuzfq1Rj6yTPHxY5vBV4PQqICof
         ziRhu9XGub8y8Edk/RJnbObGY4FEOukf5vZR7F1hN+UwnRht2siVY4NLooppwDAecpiP
         7ZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719431236; x=1720036036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXDZTLeuWuzR4JFBbSliTdNmKT1J60juYffwmH3Ya+w=;
        b=SjDYGawi39SdciqNkeThsTj9uII0cBVjIG9V+YXzy1DmHiQ/YwNdwPSo9+QqVpWwI7
         BpIhnLCHcAuzC0kbJSOW6BWbkKGkkNFsNKH55k9QqhaH9CKDcJbj+3I5MLQ/onPYa9XP
         Zuxi4qjOWlB1P0Nx7/DmopqRGwdJyRHDS6TO9Sk4T6AvKQT0paowvMBM5JuIiAVTN1nF
         LaMlxdl7eMxmCgymYLjgUHdF+mUkNlF60JJMdIMty+5IMlKA7Ll6QZKD0H0q3ENmtTbe
         z4KYYovmGjgH+sD39MWyra32VP8Rd9ZOWW+jOO9jFZ1Us/vd2Xf5pw53AglZjrtAqJkN
         1gFQ==
X-Gm-Message-State: AOJu0YwoSQP+QAbX/HsLnx1snykln8TOlT399bnxtc8LbEZCJiYPVnjN
	r4No68ggWoGzNay0jt7pzBZSXHfwTVWqfDTl0uf6LMfSAO84psMM8Gy85ax0
X-Google-Smtp-Source: AGHT+IFEq2G29a9cZ3CtqTm8lu6M1ohFZCP2KJGvd+Bn8S2ZMURyxwzcnnFwPwWRhHdcNMdssoKpIA==
X-Received: by 2002:a0c:c384:0:b0:6b5:1f3d:c810 with SMTP id 6a1803df08f44-6b5364f79efmr134299206d6.52.1719431236284;
        Wed, 26 Jun 2024 12:47:16 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b52ac1028csm48489996d6.99.2024.06.26.12.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 12:47:15 -0700 (PDT)
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
Subject: [PATCH v7 4/4] nvme-pci: Make driver prefer asynchronous shutdown
Date: Wed, 26 Jun 2024 14:46:50 -0500
Message-Id: <20240626194650.3837-5-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240626194650.3837-1-stuart.w.hayes@gmail.com>
References: <20240626194650.3837-1-stuart.w.hayes@gmail.com>
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
index 102a9fb0c65f..8138e37547c9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3531,6 +3531,7 @@ static struct pci_driver nvme_driver = {
 	.shutdown	= nvme_shutdown,
 	.driver		= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
+		.async_shutdown_enable	= true,
 #ifdef CONFIG_PM_SLEEP
 		.pm		= &nvme_dev_pm_ops,
 #endif
-- 
2.39.3


