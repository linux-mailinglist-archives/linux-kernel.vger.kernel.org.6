Return-Path: <linux-kernel+bounces-213134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A5B906CD7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA5B2B24E6D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48461482ED;
	Thu, 13 Jun 2024 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+oNyFNl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A12D1459E5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279453; cv=none; b=QHFFsHq4E9ac5sDfEuxFmo4Cnsoad3FMNWn07qARisXSrkrYO3AQWyTItsNcEp7UMxxDa1S018fvtFehOsx08won4HaiqPP40SsIeqQZyyZ8S94TmBf+MS6eIbmreJtRO4/2lvnHEzP/jEOqAGfTctzrsZzd6gudIp8xTFzcyr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279453; c=relaxed/simple;
	bh=CKmb7V8YQKy60Y3zYZ5nF36qcetaUUfvS68MhKTVZyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CTtw4gXabzczZhKuCvkUa47aamX+pJ+YMwWfiSRvBtSxbpdHS6d+Nnj9TcJL+YLnjJ+S2g85HhLKro0AcBGhnDqHD3wqMEoASgyBQekK3hhtpOyWhBcX1Ryp/GqmDiaH0f4PCTInBNe2ezKkO0hQO9A6NDnMEv4xUpLbnm5y1qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T+oNyFNl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718279451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CL+kLbe+Y26ksl0hcQ0e5foEJJ8TqrY6DSq54p9TklM=;
	b=T+oNyFNl0mII1OBF/8KP+MAxCc/IzMe4TWH5Obv5qpsVY5pM34NJs/namCkBfbLPgVWDFj
	VX46WNsJgav3xBDFg+Q2l1KcIuYOs/p+LPQX7A82bJqHFd9ESUSKHVjs9WcTvWks7s5Nxk
	C3bKBwupmDYArK9Z/6RnrfSRqPriKm8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-0oy7-F2nMNq21rbiDqVesw-1; Thu, 13 Jun 2024 07:50:49 -0400
X-MC-Unique: 0oy7-F2nMNq21rbiDqVesw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-421920de031so1547365e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 04:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279449; x=1718884249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CL+kLbe+Y26ksl0hcQ0e5foEJJ8TqrY6DSq54p9TklM=;
        b=jYQpmAqGy9p/rR/avKViIZC8+SjGfTBqpda1ncw7RWv3D7nEGTxIYHlAUhXGX18UVy
         JK0m9xodhFM5OgnK46mGryE4yw0cq2zXscyuDfTXMkiDklwBXdYIANEmRlvskBcQKt+D
         r33JeBCfKgnZck3ky6isrqK/bvcVUcmXctlRiM0RMBl3L0hPYl8XCHzAOMZ8qm2OttGI
         fP9gT04oAn3hZ5Y7xY5Wjqp7miCToWRJOK7Dst6eyu59MYHoXnDbc41OT1Qttp3bJbZ3
         yGT3NGtfY2x9sV2Bxd2uBorDP5Ikwk7StMRNrWexWKuMQpyimA24UKGmwhIWXW1fdRbz
         QHsw==
X-Forwarded-Encrypted: i=1; AJvYcCVBK9P9zfjTXuhYpwOFUU57tcyKodGHCq6eGiBITPhqX/K/ihFAbVcnA/qyqDCz0AItFC2IoSLM9iBH2ljtjX4nLSVbR71YxWmNmtbb
X-Gm-Message-State: AOJu0Yw0atDkAZCy8S4y5iyOrlD4gsOjAgBUbS8N7hGGyW99gxynfj+E
	b9da8jfQY6ecryB1H5HaHFHeLXMGobmjcNp00eGgmms4mk5lXRqX/v1DTa8VRXcBFqz3PxwZiJU
	TahkvOOUdAQ8YmvHKo2h/qZpeuFb92Ifj+gkFvqFvW0qiOL8+lsa5kHI2ubXoyA==
X-Received: by 2002:a5d:5f93:0:b0:35f:306f:1587 with SMTP id ffacd0b85a97d-36079a50f05mr208534f8f.5.1718279448838;
        Thu, 13 Jun 2024 04:50:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEPTiocjmZpdSuZITHvA9vbQ/P9nyYz57aqk+QbvsZnFOIEMIsJGsexzqpTKeFCx6yJ+Ucbw==
X-Received: by 2002:a5d:5f93:0:b0:35f:306f:1587 with SMTP id ffacd0b85a97d-36079a50f05mr208519f8f.5.1718279448583;
        Thu, 13 Jun 2024 04:50:48 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c883sm1510620f8f.29.2024.06.13.04.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:50:48 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	dakr@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH v9 04/13] PCI: Deprecate two surplus devres functions
Date: Thu, 13 Jun 2024 13:50:17 +0200
Message-ID: <20240613115032.29098-5-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240613115032.29098-1-pstanner@redhat.com>
References: <20240613115032.29098-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_table() should not be used anymore because it contributed to the
PCI devres API being designed contrary to devres's design goals.

pcim_iomap_regions_request_all() is a surplus, complicated function that
can easily be replaced by using a pcim_* request function in combination
with a pcim_* mapping function.

Mark pcim_iomap_table() and pcim_iomap_regions_request_all() as deprecated
in the function documentation.

Link: https://lore.kernel.org/r/20240605081605.18769-6-pstanner@redhat.com
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/devres.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index cf2c11b54ca6..5ecffc7424ed 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -507,7 +507,7 @@ static void pcim_iomap_release(struct device *gendev, void *res)
 }
 
 /**
- * pcim_iomap_table - access iomap allocation table
+ * pcim_iomap_table - access iomap allocation table (DEPRECATED)
  * @pdev: PCI device to access iomap table for
  *
  * Returns:
@@ -521,6 +521,11 @@ static void pcim_iomap_release(struct device *gendev, void *res)
  * This function might sleep when the table is first allocated but can
  * be safely called without context and guaranteed to succeed once
  * allocated.
+ *
+ * This function is DEPRECATED. Do not use it in new code. Instead, obtain a
+ * mapping's address directly from one of the pcim_* mapping functions. For
+ * example:
+ * void __iomem *mappy = pcim_iomap(pdev, bar, length);
  */
 void __iomem * const *pcim_iomap_table(struct pci_dev *pdev)
 {
@@ -894,6 +899,7 @@ static int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
 
 /**
  * pcim_iomap_regions_request_all - Request all BARs and iomap specified ones
+ *			(DEPRECATED)
  * @pdev: PCI device to map IO resources for
  * @mask: Mask of BARs to iomap
  * @name: Name associated with the requests
@@ -904,6 +910,10 @@ static int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
  *
  * To release these resources manually, call pcim_release_region() for the
  * regions and pcim_iounmap() for the mappings.
+ *
+ * This function is DEPRECATED. Don't use it in new code. Instead, use one
+ * of the pcim_* region request functions in combination with a pcim_*
+ * mapping function.
  */
 int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
 				   const char *name)
-- 
2.45.0


