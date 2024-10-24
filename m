Return-Path: <linux-kernel+bounces-380095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B24F29AE8DC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2CBF1C22976
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62071F76CE;
	Thu, 24 Oct 2024 14:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="o4Vnko3A"
Received: from out0-193.mail.aliyun.com (out0-193.mail.aliyun.com [140.205.0.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2D11C1758
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780125; cv=none; b=nBVl7UJrKFdHY1nrL9l1tY9DU05ClUm6BP23Bgn41tLXq+Dc10GbpM+b7dIzbOccf56iwnjBekbKz8GrUtGwzW28JMPSGs+L0tqWqkoQgnp4dWViRGBat/a8lje47Pz3DCadBy1M4LvzWILQbY3co0UWUZUpplTonFw4rLzqSyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780125; c=relaxed/simple;
	bh=oXy6rXpqqHRMqsCBsUClVbHN+aOv3TSBjb7kr7SgFEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NifbVn7alL34R+x/wgmjGuOP118RLZBZKBx6Fk0XlBuZziHjVLpTefMFNTqZwQ/d7kDzMYWRiCf1RVTponEaMoZUpfxtLHHSMDTYdZsBac1Ja+DaaUq5vyo28L0DEivO4aBtFN+WQOx6AwmCRAshvZ0Ib+0uZqALZXIoVuATp5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=o4Vnko3A; arc=none smtp.client-ip=140.205.0.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1729780118; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=o7nomrNF4UUPmRyX4jzl23OQWMT1pV1gEWGtKNbTeqs=;
	b=o4Vnko3AJULnvRhVZjHaiYWcOaoEAROuMn51S1xO5XJIiAjpkff8GeXXKnkhctQHO09yAyCK0ORw0Ho8zvAeI6UOVg1O/m9lJhE8DXg3b7fD3GNB6HSPEcpqFp6BHOUOEFfyt5Cyu0UNfIGRNr/6TMN5tfSlZZqv/CGbH9nBLpI=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZreBt-G_1729780117 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 24 Oct 2024 22:28:37 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 3/4] um: Set parent-death signal for write_sigio thread/process
Date: Thu, 24 Oct 2024 22:28:27 +0800
Message-Id: <20241024142828.2612828-4-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241024142828.2612828-1-tiwei.btw@antgroup.com>
References: <20241024142828.2612828-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The write_sigio thread is not really a traditional thread. Set
the parent-death signal for it to ensure that it will be killed
if the UML kernel dies unexpectedly without proper cleanup.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/os-Linux/sigio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/os-Linux/sigio.c b/arch/um/os-Linux/sigio.c
index 9e71794839e8..9aac8def4d63 100644
--- a/arch/um/os-Linux/sigio.c
+++ b/arch/um/os-Linux/sigio.c
@@ -55,6 +55,7 @@ static int write_sigio_thread(void *unused)
 	int i, n, respond_fd;
 	char c;
 
+	os_set_pdeathsig();
 	os_fix_helper_signals();
 	fds = &current_poll;
 	while (1) {
-- 
2.34.1


