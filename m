Return-Path: <linux-kernel+bounces-380106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3426C9AE902
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF6171F22EE3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBF41E7C35;
	Thu, 24 Oct 2024 14:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="kyNKJM7o"
Received: from out0-196.mail.aliyun.com (out0-196.mail.aliyun.com [140.205.0.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD601D1745
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780442; cv=none; b=XvYgP09T3xrFrNK7zJF6tr6VCYm0W/fV8StcJ7scy0VzRL9VQercvOGKaXPyGRuOYNvhKta12JY9Bw8A7RjucCd1wgVf/IgHw/bZiPxEsK1J89oel/CPXygSh/Ef1ylCVN44jzxBn0BiZT6HMm0J/kAhp0e+WdoQPzU3hN2N3qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780442; c=relaxed/simple;
	bh=2KuxAKEg5UlIEaFA7fkjnIg4NOYGWc+teDk36qv6NiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K2vjtcpj6i8ngiBSZih5tzdmR5H/UWMWRqmXf9DFDSdb7idBLZ8B0vHc76U3nS77QsBuPV7lVh2uhV3/2oeC1uwV/Bl4/MgGQWI9VGejPUvcvLud+uPA2mx0sgK8lstJ+eB/4yKMPOkM/oXjHmTBWpTQwtHw/Mr4bu17xm1jC0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=kyNKJM7o; arc=none smtp.client-ip=140.205.0.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1729780435; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=9F+/gG2/NpWN+fSAPQ0vZiXCLF44MabL2VbrE4Rm4ys=;
	b=kyNKJM7oGJevt94n5kxYDH22ZlY1cZHU4ug/4OWCUSeGRJ1CmU7LVUqGNTOCkBsuikJ1POKZdwEPFdWrzlQDSvyYhkW/IMWEU/wSZ/WTvxNjWDTxlfWlVGfYefiX63tJ4M0P6CEYQK7qkuAAWLQjqIsxQDk5qTMR2RHyAcY3mWc=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZreBt-P_1729780117 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 24 Oct 2024 22:28:37 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 4/4] um: Use os_set_pdeathsig helper in winch thread/process
Date: Thu, 24 Oct 2024 22:28:28 +0800
Message-Id: <20241024142828.2612828-5-tiwei.btw@antgroup.com>
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

Since we have a helper now, let's switch to using it. It will make
the code slightly more consistent.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/drivers/chan_user.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/drivers/chan_user.c b/arch/um/drivers/chan_user.c
index 1434114b2f34..35f9beeb19b3 100644
--- a/arch/um/drivers/chan_user.c
+++ b/arch/um/drivers/chan_user.c
@@ -10,7 +10,6 @@
 #include <signal.h>
 #include <termios.h>
 #include <sys/ioctl.h>
-#include <sys/prctl.h>
 #include "chan_user.h"
 #include <os.h>
 #include <um_malloc.h>
@@ -162,7 +161,7 @@ static __noreturn int winch_thread(void *arg)
 	int count;
 	char c = 1;
 
-	prctl(PR_SET_PDEATHSIG, SIGKILL);
+	os_set_pdeathsig();
 
 	pty_fd = data->pty_fd;
 	pipe_fd = data->pipe_fd;
-- 
2.34.1


