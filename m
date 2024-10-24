Return-Path: <linux-kernel+bounces-380097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F55F9AE8DE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD39A1C22C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EB81E3DF1;
	Thu, 24 Oct 2024 14:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="xFifBZFG"
Received: from out187-24.us.a.mail.aliyun.com (out187-24.us.a.mail.aliyun.com [47.90.187.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8611E8833
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780133; cv=none; b=XhHg1J0JzcJeEAxY7ywJHC+lqfKtwbwkpOCnOB7J83DawjNNC2jfqmAlVTC4KoXM7HH/jF64AcGQ8QjR8bkCIcwxN/858ICB6pNVlSfYm31Yitofmfgyt9ye1k3bUKDsb1I5RlhAAwFnaxQ5UVVKgwgSWdBWzn1wQgSfe800sK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780133; c=relaxed/simple;
	bh=93aQHlKMBq3mxQqH3WygGtWzqoD93//12SPcyrkof9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sNZ+ADhcWvUNrQrjNVhmXDOiiwIUkH7XEpb5eAWUn6qF6qnRuW/Fo4dcHCIfZtwzTC93DidjO/Wlo5EKPUu8PQ22v/UBdMl4p1Xl04/4ObJSKixXTQWSn9+zN9Pp/VP4TqSZiHEvHfLXJZXnS795EP1XyLauwEBgTqwzEaqcDJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=xFifBZFG; arc=none smtp.client-ip=47.90.187.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1729780117; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=DW2X6x5nYJj0dxAEofhIKyQStzlJYeyPAOconukYPcI=;
	b=xFifBZFGfevXW1X/9XqfwjvzJirpgISM/W0cLGJUbiPKp88cLb8H1JbXbPqUORtEq4U6ZtU/XjKM7YLP2fYoJRXizHJXVmSPXfbZV2v64qo8wbwHmLMGeOH1MZOQKUjTwVnPybXJvHVDxoKwR0Ug3jV2p1cIY+wVsuMHJcffXXE=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZreBt-9_1729780116 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 24 Oct 2024 22:28:36 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 2/4] um: Set parent-death signal for ubd io thread/process
Date: Thu, 24 Oct 2024 22:28:26 +0800
Message-Id: <20241024142828.2612828-3-tiwei.btw@antgroup.com>
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

The ubd io thread is not really a traditional thread. Set the
parent-death signal for it to ensure that it will be killed if
the UML kernel dies unexpectedly without proper cleanup.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/drivers/ubd_kern.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 7f28ec1929dc..2b8d04e67600 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1499,6 +1499,7 @@ int io_thread(void *arg)
 {
 	int n, count, written, res;
 
+	os_set_pdeathsig();
 	os_fix_helper_signals();
 
 	while(1){
-- 
2.34.1


