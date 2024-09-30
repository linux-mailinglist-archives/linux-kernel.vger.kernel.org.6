Return-Path: <linux-kernel+bounces-343870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 090CE98A084
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2A462885F3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60022199928;
	Mon, 30 Sep 2024 11:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="Xc96Y5lr"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B99198831;
	Mon, 30 Sep 2024 11:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695316; cv=none; b=svfa/L4eHiMNheK8mHwNEn8dxdwLMKrCWBGx5kAb5ad3sqkHQCjeLgo9cN8n7YGteIFb7mcQ7zkVVY0O7u3nKJGTDOlJydvVf7ivZeHE8jRu6RNmBYW94JjNbb0Fkr0p/ExFvV+m9Vq1DjkcQRnFcN7Os51NIMBfZERTzC1uck8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695316; c=relaxed/simple;
	bh=RKhXo7gwoSvm/h+GCE3zjWKAjxwR+4OpoUTuRzq5ogg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oB2ytLjCYc6M60VGHuUoXq2WK+MY9/uqpuyY8rF6BRORsw1ecWF0CGyx0A+I2/mfIJtNf0yspKEvmfl3rgB/ZcezcwWUAQEexy3t1EquHTv2xFwN41X3MCrLMHJOWkLXdmlz21+ASVSdGbyr6vCT+UPPEwIcW/MLdUecjrEGAZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=Xc96Y5lr; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a2euXW05XazmTU/NrAk/BHORkeFwAmWJXM2dW22jHcA=;
  b=Xc96Y5lreXvWElAgS3wkZQj8SZ1imKL43+1QmajbloaYwmRU24cQym5R
   zEfYyyQI2xm/xhqkdpsc1e9rehThl0yYSM5h8khhUF6BF2Zj5/+Z7VhPv
   SQyWOtRRFLQYS+Bx4yVnOYQM9iuZJrfu2Butz25a7hGFg9AAhgDdQf6o7
   s=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,165,1725314400"; 
   d="scan'208";a="185956904"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 13:21:28 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: kernel-janitors@vger.kernel.org,
	Russ Weight <russ.weight@linux.dev>,
	Danilo Krummrich <dakr@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 26/35] firmware_loader: Reorganize kerneldoc parameter names
Date: Mon, 30 Sep 2024 13:21:12 +0200
Message-Id: <20240930112121.95324-27-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240930112121.95324-1-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorganize kerneldoc parameter names to match the parameter
order in the function header.

Problems identified using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/base/firmware_loader/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 324a9a3c087a..bb368193d969 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -1075,8 +1075,8 @@ EXPORT_SYMBOL_GPL(firmware_request_platform);
 
 /**
  * firmware_request_cache() - cache firmware for suspend so resume can use it
- * @name: name of firmware file
  * @device: device for which firmware should be cached for
+ * @name: name of firmware file
  *
  * There are some devices with an optimization that enables the device to not
  * require loading firmware on system reboot. This optimization may still


