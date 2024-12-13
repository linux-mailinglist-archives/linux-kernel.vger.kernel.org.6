Return-Path: <linux-kernel+bounces-444456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 211619F0725
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C99B16A25E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DB31A01BE;
	Fri, 13 Dec 2024 09:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+pw5LVi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35701187849
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 09:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734080585; cv=none; b=qM1pHWwtcsMqaOXWYTH6Bp0VWkoUBvYUCm87RpOo055lvhnlsM6hf43ZNhHb4aozrGaMRE4JvXKyngWjXkmpDcrZ0YRp1d4ADaBZM3rtx0/jVJQqDra0anu1EQgdkUqw9PY6PEV58WUFsECVSH3te7ZqYjgIvb7hFB/M7Axtn5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734080585; c=relaxed/simple;
	bh=6M2BE/YkDncPuZAYofQG/dj3wcltiY44hkQ3DVP8cO4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ijVOcZp/1eQQZ1QKnQrgphzmqZO+pz/7iqP6Trx62+ahxZfJvYOsFnopk82ntbd3J+eOASHC3YGNMuG4OD9stXcVBSwERrp37Svx0tNj/dZFCsrjK7Z3caY/NbTk4tky93yS6QT6uGyQ7lQnLE2ygHXTJq1zTsrUxMk7Tb002YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+pw5LVi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4BDBC4CED0;
	Fri, 13 Dec 2024 09:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734080584;
	bh=6M2BE/YkDncPuZAYofQG/dj3wcltiY44hkQ3DVP8cO4=;
	h=From:To:Cc:Subject:Date:From;
	b=c+pw5LVioue94aMM7KXv6oRGsk2Knm+Ag1MIpSZkmOu+1jQ0Zz92gEMdYkAJGmhse
	 Zm5BTKiT9Q6qNeUcPFkv84NXignDv5NzzSe7aQpbtyiZHq1M6fSvQ//DOGusZL/gpa
	 qG3m4djUjYFMRmY7Q8TeIPGJ7EabpfAZ+LF1Vx+XiU34GXIg6EysJVJGvfz/eoxJ9z
	 HjA6j7kk4c1AIUDI/UuKe2hqK5LdobSatMwjfJmze12LoKtNT6nI3tZNFc2z1H0U8c
	 uQiKSvhYEEkR9aOKL4AA9WX6K4dYDaK3dvN/54bZmI32HYxQKiPHb88b5OYOA3J3Zb
	 nbG8O52CgWQbg==
From: Arnd Bergmann <arnd@kernel.org>
To: Min Ma <min.ma@amd.com>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Narendra Gutta <VenkataNarendraKumar.Gutta@amd.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] accel/amdxdna: use modern PM helpers
Date: Fri, 13 Dec 2024 10:02:54 +0100
Message-Id: <20241213090259.68492-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The old SET_SYSTEM_SLEEP_PM_OPS and SET_RUNTIME_PM_OPS macros cause a build
warning when CONFIG_PM is disabled:

drivers/accel/amdxdna/amdxdna_pci_drv.c:343:12: error: 'amdxdna_pmops_resume' defined but not used [-Werror=unused-function]
  343 | static int amdxdna_pmops_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~
drivers/accel/amdxdna/amdxdna_pci_drv.c:328:12: error: 'amdxdna_pmops_suspend' defined but not used [-Werror=unused-function]
  328 | static int amdxdna_pmops_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~

Change these to the modern replacements.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/accel/amdxdna/amdxdna_pci_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
index 02533732d4ca..b2342abdddc6 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
@@ -390,8 +390,8 @@ static int amdxdna_rpmops_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops amdxdna_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(amdxdna_pmops_suspend, amdxdna_pmops_resume)
-	SET_RUNTIME_PM_OPS(amdxdna_rpmops_suspend, amdxdna_rpmops_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(amdxdna_pmops_suspend, amdxdna_pmops_resume)
+	RUNTIME_PM_OPS(amdxdna_rpmops_suspend, amdxdna_rpmops_resume, NULL)
 };
 
 static struct pci_driver amdxdna_pci_driver = {
-- 
2.39.5


