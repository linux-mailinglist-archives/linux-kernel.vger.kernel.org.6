Return-Path: <linux-kernel+bounces-360481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C97C4999B9B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE6E28592C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 04:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AA01F9425;
	Fri, 11 Oct 2024 04:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="BR20f3zc"
Received: from out187-16.us.a.mail.aliyun.com (out187-16.us.a.mail.aliyun.com [47.90.187.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE531F4727
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 04:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728620444; cv=none; b=Umd6cLASMdJE88oNlFu/6DqMgN2eUMWCZ0XZjMbfelBaWhyVa92rE1SCt7m27E1W1mmYNNb5xgEXpQW4TBMILaC4VatbqpcqwOgIeLYFHFdetnPaDjFe8cCHlCl3WCE6HgRLoDVGrs7+XxbTp3FM0yj5bv88OCxmw2HPafCf3lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728620444; c=relaxed/simple;
	bh=q6oEOvXjndHKLCB747YvVogEwXAdlcOdo8EPjxEMY1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fi4wMkGn2LntG4QCTtTyfFcDWoI5ViadvLl5WoxHd7e4SI81O2eXFdSmOJhiYvTJ3bPnBq5tnuSKzo9/EsI0gm0XLNK5FuJd0YDxyFnxs0v/c5tUHF30mnhr/WS4kUqvmjXzghhvNRdC75b0BQGgQHL+ALStRY4pxa62wFM5HFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=BR20f3zc; arc=none smtp.client-ip=47.90.187.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1728620429; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=XWQ1ddR8ZcAwD91UZmRnhbCLLnJTKTAUdU8I9wrCZOA=;
	b=BR20f3zcHEKtuGO3mxDeGl/PsbMOWjl7oJKtuxxrhnrdm1IcjWOqqtdMnsx9PPeAQ0BWHHMdNSaiRNhvJU8VMr4iWKVRt8f5u6KHhkwXVLpqUE0WpnZy93vNOs4TNkch02mTk9pfdePk0lrUndZg3ji9aI627vPTdD5qnkfgpBg=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Ze33tz8_1728619495)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 12:04:56 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 6/9] hostfs: Do not propagate hostfs parameter to kernel
Date: Fri, 11 Oct 2024 12:04:38 +0800
Message-Id: <20241011040441.1586345-7-tiwei.btw@antgroup.com>
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

This parameter is UML specific and is unknown to kernel. It should not
be propagated to kernel, otherwise it will be passed to user space as
an environment option by kernel with a warning like:

Unknown kernel command line parameters "hostfs=/foo", will be passed to user space.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 fs/hostfs/hostfs_kern.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 6d1cf2436ead..8d47c6b70c9f 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -57,6 +57,7 @@ static int __init hostfs_args(char *options, int *add)
 {
 	char *ptr;
 
+	*add = 0;
 	ptr = strchr(options, ',');
 	if (ptr != NULL)
 		*ptr++ = '\0';
-- 
2.34.1


