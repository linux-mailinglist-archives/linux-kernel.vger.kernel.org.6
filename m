Return-Path: <linux-kernel+bounces-395325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D1E9BBC5E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08B042829F3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756DC1CCEE2;
	Mon,  4 Nov 2024 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViQK8Jc6"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B531CC159
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742636; cv=none; b=jhcpTjwGHmk8KBs+AI7lN+GttNjIUJ/EfWsE8yiT01DW5goxOyVZFgg5Tw7iqcb1cVF2Ys0YW6yt/ZdJHI4eDsSUImfi7apeoapLDqe0bk03PTaE30lfukD8/q6/GwOjfUxIVy/IZOF3rccs/ctWgb+SZ8NnH3cO+rW9BlMJnK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742636; c=relaxed/simple;
	bh=4pTAaxFfewlJw9PAEP+mahiy/IhKHj4085X8iVV2nQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZH/WhChNSMaBKOlskWcw/BXSGjjWiLCtP3O381H+W8/e+jLR0gIUJAYyP6avevj9+hDHGuk/JPyqxmnCxsmcdX+uwe6nPzqQ4VOAQ3OCI7ngfJfjtMIZQEJX6WMRILNFqCZ1k3SM+cyYaamO9i9iO9pAPTxrvi/stCpBHZEVic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViQK8Jc6; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d4ac91d97so3857634f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 09:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730742633; x=1731347433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGC8SOXxfXFQ5pvO+YRC7IJz4OGiSZL30CVR1jYAJkY=;
        b=ViQK8Jc6MP71Cx2sjsD8GuP0fqpuUrKsLTafwW3QaXODKxba7Ff/GAlBvk7iTwgYb2
         ySVx29bPGK9O85zSfspjtWk5v0aZLk43r97JPc6jFQKYhgpMv873gB92dDUdJSst5qEX
         5+3xfkvTo+bM3l1wvRMDKF+ZQOb6oaKMgD7OPgiW8OJ4XPA91taAajrV1CH4aJjfldpa
         2J7Xgro+1zQO1Yu8rTLkzh5JskLajzppADy1S0UN08Hycd3mJF0fc0pCnji4wC3w0zMr
         NCjqkkp870k4Oun5KwddpYS/7iT6SgGZm46P0zYoNwztkxVPsFfACJZ4q2Id0Isbu9YX
         jnsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730742633; x=1731347433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jGC8SOXxfXFQ5pvO+YRC7IJz4OGiSZL30CVR1jYAJkY=;
        b=aUssjkWbD5EiC6yQ/wfcFlbwtopgFycZWAXlFzKxuQVnAAakChvOo86AcPJh4fT5ZJ
         lTZKZt+8TcKCWmBZeJElPRPDPyNxgcQqBLlGIKr+mx6Sk3H/gZSATvv+bb/49H2DWhpk
         kmaybWY9fyXVnWycjZm/Ppbn4MTabWKNJmHF8Nn9ocIw9/cXG1CoAQjNYCHNfajHHEYR
         MWXjrI6UJWJA9wLsos+dpnfF3Gql//tsaBeAbREeMoOAh3F0gq1ZwBOWMR8SVK5iJFW6
         FIXruHBgR0SL9aZtLadKik19D9BIH+4sq5+svvrrrCqrjkUUoqYXbXimwnbRVBVALZOW
         fwKA==
X-Forwarded-Encrypted: i=1; AJvYcCXwFuwesC8DRBAYJI7lHttfzTA6HvELCWALcKBskuq1Dqs/FoQi0RqyEgi0MkyOmBR/qCM6cdstBdzD+AY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc2ikllu3n3m1tXDXvrL6LhkjyHEOFxKZ81ywn9nv+Gb69XCeh
	NaqliCK2w1/qpXNUSl3+4MohoEATG/ZC3tABSNMjqLz7DOYWiySQcQIPFfTr
X-Google-Smtp-Source: AGHT+IFuvK6Cz2AIyw5UeTFvXNS0T3fabV3pxzQGYnlHWEehdx4DPu/RKpZaKpKzuhz3vu01WMtk4A==
X-Received: by 2002:a5d:6da6:0:b0:374:c1c5:43ca with SMTP id ffacd0b85a97d-381c7a6c662mr13202421f8f.32.1730742633009;
        Mon, 04 Nov 2024 09:50:33 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7f80sm13839821f8f.20.2024.11.04.09.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 09:50:32 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	arnd@arndb.de,
	dan.carpenter@linaro.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH v3 08/12] staging: gpib: Fix Kconfig
Date: Mon,  4 Nov 2024 18:50:09 +0100
Message-ID: <20241104175014.12317-9-dpenkler@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241104175014.12317-1-dpenkler@gmail.com>
References: <20241104175014.12317-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NI_PCI_ISA driver also supports PCI and PCMCIA
Correct typo COMPIlE_TEST

Fixes: 2c9f5d8c6ece ("staging: gpib: add bus specific Kconfig dependencies")
Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/gpib/Kconfig b/drivers/staging/gpib/Kconfig
index 0ea9a276c389..95308d15a555 100644
--- a/drivers/staging/gpib/Kconfig
+++ b/drivers/staging/gpib/Kconfig
@@ -61,7 +61,7 @@ config GPIB_CEC_PCI
 
 config GPIB_NI_PCI_ISA
 	tristate "NI PCI/ISA compatible boards"
-	depends on ISA_BUS
+	depends on ISA_BUS || PCI || PCMCIA
 	select GPIB_COMMON
 	select GPIB_NEC7210
 	help
@@ -138,7 +138,7 @@ config GPIB_FMH
 
 config GPIB_GPIO
        tristate "RPi GPIO bitbang"
-	depends on ARCH_BCM2835 || COMPIlE_TEST
+	depends on ARCH_BCM2835 || COMPILE_TEST
        select GPIB_COMMON
        help
          GPIB bitbang driver Raspberry Pi GPIO adapters
-- 
2.46.2


