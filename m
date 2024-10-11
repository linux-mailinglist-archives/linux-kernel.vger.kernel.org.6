Return-Path: <linux-kernel+bounces-360479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D31999B99
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D9C2B23204
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 04:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB021F4FC2;
	Fri, 11 Oct 2024 04:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="Mxw7QSxy"
Received: from out0-212.mail.aliyun.com (out0-212.mail.aliyun.com [140.205.0.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF821CB506
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 04:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728620435; cv=none; b=P3/aKDsnyPfqguefTiaOcLv02SWUCecPhUWgPmpPNzLL0oYZ1Rm540uT4g3+JBCUIytrkEfMkW6xDyz5EaNtnvHgOQLWER3hGMyclcOQa4h3qe6tR0bTCARpKndTP+d8Inq5iXlRHF7Q+eeZuAm7nH9vxNkMe375bVHUd2PKzVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728620435; c=relaxed/simple;
	bh=5OY7ba4GM2/2WjdXlxbfOLZAwD1fHx6NpTVCi4QXJkk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TlZOsQKjL326rxi2ZXrCnccnktt8X8fa71hv6XulBd+YPWQ46KMRgzUy9QXHfIh00j0Wlq97nXcQFXCgGXz7ze2O0+35L+YcLP6QZCGX9MV1wpZ6UI3PushcYI84VjPBxF9lXnSXGTAP6wSYFKZaiL6YlTcIASYp35RsED+S1Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=Mxw7QSxy; arc=none smtp.client-ip=140.205.0.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1728620429; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=JxRiuypZIeLXCZKlxLO86zep9YFX8spIesFp4LrNwoE=;
	b=Mxw7QSxy4LUIj01+i/48UVUUNgmVl6Nsyneejv1t71aoSYuyrI0bhxD+moyZk5o+w99DT2Hh/eOUU5bbpxkG7rM1AfJ4nuS+qmh7KlpsPnrlf1iym4+3AhHkp6b0nFj+s/ISiiCrO1tjmUs4spyu5gNMnMSDq7xjhQ6XPJwVkoE=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Ze33tzT_1728619496)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 12:04:56 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 7/9] um: hostaudio: Do not propagate dsp parameter to kernel
Date: Fri, 11 Oct 2024 12:04:39 +0800
Message-Id: <20241011040441.1586345-8-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011040441.1586345-1-tiwei.btw@antgroup.com>
References: <20241011040441.1586345-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This parameter is UML specific and is unknown to kernel. It should
not be propagated to kernel, otherwise it will trigger a warning and
be passed to user space as an environment option.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/drivers/hostaudio_kern.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/drivers/hostaudio_kern.c b/arch/um/drivers/hostaudio_kern.c
index 9d228878cea2..09af903b75ae 100644
--- a/arch/um/drivers/hostaudio_kern.c
+++ b/arch/um/drivers/hostaudio_kern.c
@@ -48,6 +48,7 @@ MODULE_PARM_DESC(mixer, MIXER_HELP);
 #ifndef MODULE
 static int set_dsp(char *name, int *add)
 {
+	*add = 0;
 	dsp = name;
 	return 0;
 }
-- 
2.34.1


