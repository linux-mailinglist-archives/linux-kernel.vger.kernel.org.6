Return-Path: <linux-kernel+bounces-181271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2963E8C79C6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C989228586D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3748414D6FF;
	Thu, 16 May 2024 15:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6YTvHwF"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A1014F9E2
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 15:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715874587; cv=none; b=gbaVG0QTycs2CgJyBt906az0qISrx2kXChJGlLZu5Dn9vE6RDNLHEprDxdm7WVSVdexA6KjTwiIgyZOdykZMtfjdMiyyzZqyiBvolh3q2wykU9ymRWN7F456rfsnj68z7SLhKJBrTlmHBfotN3fM06bGsNI02WUGVf7JyJTHlcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715874587; c=relaxed/simple;
	bh=o93R5YZmPt9iBdQ5nObXxgaQGjXN5Y67BVG3ZtpNzQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ey6m53eJoCLs86bGkX7QnlAHdiMDsKK7N2Lc/GRwn25+3DV1Uru0xvmnD/tD2vJ7UZck7OGWjXqIS3/M5AE328qsd0tOGuvyqZUOmOFjc8SIHwVmWEq0SpavrSMxsxqSU4p+2trw+sjCF7bpye+mc177xlRbOhAKfFgwQx939QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6YTvHwF; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5b2a66dce8fso273130eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715874585; x=1716479385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1el02iUk0200SGhOLa3Aie872dT1lHaSMV4HS5bPfTE=;
        b=N6YTvHwFYODCBbgk1naSPQ1vrDQAHzN29ZqVDKTD9d5XufW2k+2U3nQFkqQYpGcQcG
         NFKuOBhpL+sSncr0XOYn3dC6viImxxdU/haxSNv60xM1F37eMOgidjQDUiY9A2h3XXGb
         0ZL3rUuuw3nN+pddqLol5CdWpVzbrP0rfH7yE2/bXmI7zTF500pQwvA6MhmpPcBvesYj
         1rADV+FDnhdJMJGLaDZBGWEdVTwrnU343L/plBgGtj2aKgqyio6dLmhyOtfxrjADnVba
         wAglhd2AdNTNgBkgxc0uXFkpNSQVSyTFfsHS11D2OE2QIBM3aced0DNHPFMOpI1UAFJh
         bycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715874585; x=1716479385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1el02iUk0200SGhOLa3Aie872dT1lHaSMV4HS5bPfTE=;
        b=S/CwfwZsWJQoZlJSjuLX5U2Mtxy0DTbJWC0zc11xq84geFDxzcNDo9S91k6zalWkoM
         0Vk8V/UAh18Y7cqjZtuMdkVgmYsha9JlzZXK2lSiD6qAVG8ZanQEjc0vJ7xTyOnwxPk9
         XeX+fe5BcpBSVL7pfZTmMr/QmA2OGyjolJm9i33E3SEIbpTjpJ2v13Wpq53egxCuppGT
         tzmCtzso2s7Kx8XVm2urxAyU54IDVUZ+YDZhmjKSwOnyOXowUgKmZd6QPnkNjZw16tN2
         nd1ox/VHqA1OITNUiHD7VBsVGAnVSUMZyiF5zJRsnwEwsXGWNnnDkiSqW+RZ4Wr3LmwA
         4nxQ==
X-Gm-Message-State: AOJu0YyYdTRotZBHyWz1LatqIT8v02YnnE2glLxQkb63dEejQA0Q4wvL
	CdY4xqKJs/Iu3NvRVkvvBb6p3HR8+MEo1HXBXGHeFuZTH4RGUXN3C8U13qg5
X-Google-Smtp-Source: AGHT+IFWbadnjHt9POkdmHGXGH0+QHLuxmZCux8kZhdMRGGI66+uLqte4Wr/PibsSmfHW7ga2az1Pw==
X-Received: by 2002:a05:6870:1715:b0:240:f3ee:6fd8 with SMTP id 586e51a60fabf-24172be01aamr22432820fac.43.1715874584773;
        Thu, 16 May 2024 08:49:44 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2412a3c82edsm3562563fac.12.2024.05.16.08.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 08:49:44 -0700 (PDT)
From: Stuart Hayes <stuart.w.hayes@gmail.com>
To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Tanjore Suresh <tansuresh@google.com>,
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
Subject: [PATCH v6 4/4] nvme-pci: Make driver prefer asynchronous shutdown
Date: Thu, 16 May 2024 10:49:20 -0500
Message-Id: <20240516154920.221445-5-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240516154920.221445-1-stuart.w.hayes@gmail.com>
References: <20240516154920.221445-1-stuart.w.hayes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set the driver default to prefer asynchronous shutdown.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Signed-off-by: David Jeffery <djeffery@redhat.com>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 710043086dff..df7bd88f50f2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3530,6 +3530,7 @@ static struct pci_driver nvme_driver = {
 	.shutdown	= nvme_shutdown,
 	.driver		= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
+		.shutdown_type	= SHUTDOWN_PREFER_ASYNCHRONOUS,
 #ifdef CONFIG_PM_SLEEP
 		.pm		= &nvme_dev_pm_ops,
 #endif
-- 
2.39.3


