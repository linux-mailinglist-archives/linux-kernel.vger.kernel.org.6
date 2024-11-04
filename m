Return-Path: <linux-kernel+bounces-395227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390DC9BBA8D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F26C2282A1A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EE31C231D;
	Mon,  4 Nov 2024 16:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="RDk/JY69"
Received: from out187-15.us.a.mail.aliyun.com (out187-15.us.a.mail.aliyun.com [47.90.187.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7510942056
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 16:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730738883; cv=none; b=tkEybwGN2CHocXhDEs6SmNTs6KAAjcNLXlwLeFsl6XJNGJTjqSrUFD5J0N7z2N2CsCjim/cyWpKDXbvCOxy0Ks35r50RSRa8Fo3g4bGPQCKowtU5g5XJ0wmV5l7BMZDWkNZE8ptZTi99QBVo2ovzxcRZcLU2RB01HBNUjSqnrG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730738883; c=relaxed/simple;
	bh=RmSBpw5uahMOj0WS5R9dGAFxZa8zOMTNKmIMAbwVAfo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IdZD3rg1SjT6jwExQ09uzo3iKlJaWXQ15EMnNRjvP3QKy7xQxG52jPvY2UVaeU4is1PujQnZUyrNkB2KUM0JdkAAaYFBpwsVw7B7J5t8ZF65LzUbT3OLPWIG8hswqfXEhlixfU7tTcKdkB9zBOWM7CIdU3FzipQ7hDLxCHcIF7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=RDk/JY69; arc=none smtp.client-ip=47.90.187.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1730738868; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=tV2uoJkDQ17IEQRpui8959JZaVBs9bsNSX1xF4BZD9U=;
	b=RDk/JY6952oFewRanL6cTIF6fiuugXew51WOGme30eqV5OiGqJ1STdzJySJezcdG7qmClk+CRFJD6ts24MZBFgzdMetNxdSlhmXLE1ezm9drSacroWbA0Z7ot+KBOKrbE7EMWHlF0rC25RXQ/604cV/iA4q+DbjO6FCOEfoxidc=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.a0U4bDg_1730737932 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 05 Nov 2024 00:32:16 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 1/4] um: ubd: Initialize ubd's disk pointer in ubd_add
Date: Tue, 05 Nov 2024 00:32:00 +0800
Message-Id: <20241104163203.435515-2-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104163203.435515-1-tiwei.btw@antgroup.com>
References: <20241104163203.435515-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the initialization of the disk pointer in the ubd structure
is missing. It should be initialized with the allocated gendisk pointer
in ubd_add().

Fixes: 32621ad7a7ea ("ubd: remove the ubd_gendisk array")
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/drivers/ubd_kern.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 2b8d04e67600..f19173da64d8 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -898,6 +898,8 @@ static int ubd_add(int n, char **error_out)
 	if (err)
 		goto out_cleanup_disk;
 
+	ubd_dev->disk = disk;
+
 	return 0;
 
 out_cleanup_disk:
-- 
2.34.1


