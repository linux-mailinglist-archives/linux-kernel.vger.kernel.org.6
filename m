Return-Path: <linux-kernel+bounces-181875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D268C82AE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 10:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F366B1F216BE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 08:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBC4DF60;
	Fri, 17 May 2024 08:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Yl9cjNyW"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495BB4A11
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 08:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715935569; cv=none; b=HaNLJHFIfAQqxx2EfSk3VmxuS4Cw0rZ6sann0zx0DtMAvn7a9XYpr0WLozoZiVHr2ASqBWpIfrvVQ10B9ij2xOFsBhHJGU7QJyjgyzIrdZmXcX4x3n43O4/eyquHbvdJkbHuZzw3Ss0h7w3oylnGDlnX9RSBpZrCIQBkRuywU14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715935569; c=relaxed/simple;
	bh=OqXENiA/Adr0ggjYgv/yUYSTiVs5DsOWQRlJsyUnUkA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zy5vSA9nTA27BYc1oP7/OPjfiP3gb6UgCTYOWhwW7Na1t1hZw29EoAVLNqR28HH1b8UKy/btCdlu7DVQd9i9NJ9Efjbu6KpyS3kbw/CgqQS/YfFC3ddtgIRxqmtkQC0qJbmyE/0fKr8k6RxxBsiiZbp7xZIG9yQNH6lx3XYAr0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Yl9cjNyW; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715935555; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=3P9anBumC+Rvm6ijATiJZ/4Mu9BiCfZljkgjcA/DfVk=;
	b=Yl9cjNyWbR3VFDf2Q9C80xAKbX7rp49i7n9/LC9QZtsWM2gS4u6b/T/cf2p/z/EIL9Njkn8EIUEclcCR1kMb0aAnesgc4G/DbixCKpgHV+xe43vFAwjMS8hHIjFevcBcKK/iKDQ0tFizy0ja+iCbmhTYE7SAN46zpwPWS+3BvoM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W6eAhXf_1715935553;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W6eAhXf_1715935553)
          by smtp.aliyun-inc.com;
          Fri, 17 May 2024 16:45:54 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: alexander.shishkin@linux.intel.com,
	alexandre.torgue@foss.st.com,
	mcoquelin.stm32@gmail.com
Cc: linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] tracing: Update stm_ftrace_write doc to kernel-doc format
Date: Fri, 17 May 2024 16:45:52 +0800
Message-Id: <20240517084552.113403-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch updates the function documentation comment for
stm_ftrace_write to conform to the kernel-doc specification.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/hwtracing/stm/ftrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwtracing/stm/ftrace.c b/drivers/hwtracing/stm/ftrace.c
index a7cea7ea0163..0896379a011f 100644
--- a/drivers/hwtracing/stm/ftrace.c
+++ b/drivers/hwtracing/stm/ftrace.c
@@ -31,6 +31,7 @@ static struct stm_ftrace {
 
 /**
  * stm_ftrace_write() - write data to STM via 'stm_ftrace' source
+ * @export:	Pointer to trace export descriptor
  * @buf:	buffer containing the data packet
  * @len:	length of the data packet
  */
-- 
2.20.1.7.g153144c


