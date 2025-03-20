Return-Path: <linux-kernel+bounces-569967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85067A6AA3A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE0D51892CE6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA5A1EB1A6;
	Thu, 20 Mar 2025 15:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TJK9MWdO"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4DE1E2602
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742485661; cv=none; b=mtFAkNvPQ22nZf8a4YjeGhEIWftEmdMe5GBrNUUbVV8u0XW9j9QI8Kuf9AAUlMYM4eDhbYsTh1ki3ClXT4ciXOhOwCa542E4LaNnKHzZk0lF9JZXg7Boipihiwd7RzM5AjmyZ62n27xUP0YpQRmwS8eoQbDt4bbAjwYTCVr1XUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742485661; c=relaxed/simple;
	bh=UR5vH+/4UOARCvF8t+iVMzoob+o1lWFKLeDHQRpWg7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IdMLvsuU1V6CiStKuComb5u5Ir4ys170tlzl4X8tt/lHQ9XVcopyn+kpsR72Qt978JSP9o9Dpn1LpjMlub0Tb/eCsN9pZM2Rx/ZiNH9gyCu/54+kYJTT8aIQxWZ9W5eehGN4p79SKMd9c+lKAmnF/PX0SSbLO4JClYDNq9yx08o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TJK9MWdO; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43938828d02so1263665e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742485658; x=1743090458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cjcpW34JDg1RGks2bE1+iEOtEigo9U4LvukjefoKP4g=;
        b=TJK9MWdOG+4NvbEa02zq8D6IkzNY8x1aVaycS3mXg2iMz0Xqupbhq6M+1p2kXGYZLh
         RZoMyxytYf0IIkHfzaxJK55qIwFs0pJ/0gGAiA8m42pp3ZdBu/Ge8yI8HGWBolNsam6b
         1w1CjlQaqR3500VdX0hdEZcngArbTZ0CQ4LwexvZNbbF/6Xz4vHNodZgu369yZBlFMUJ
         Sh15fy0CqDtoLy8lJBYhqnVQH/COXDiRk5mU/QGxDJV50eVaVMCQSq5QL09UXM4nkiFs
         evTSn0zOPo4CydsS7/5coWyop3gxcdr0Yuxu2C441B3fJrRBx4uaUbN9adJXDuKy4crL
         hf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742485658; x=1743090458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cjcpW34JDg1RGks2bE1+iEOtEigo9U4LvukjefoKP4g=;
        b=YZ9bYTGnBp4wGr3lpDnKbSHFTemhy4W8mO5hSOSYbqSc+kM2rCxqt93WbUEausVu83
         rr+5lDgjHSZK9XNPC4W0J23ddh0MgKK3RrabyT4/q9SgMS6WKu4hwr+IFrBdxmdjSU/X
         Ef3Mo4tKd+lmtsuQKWOBYJAG8HmO7j8zxUlHeCcboQ/AmL95mJSM5/Y6NHtI/75Qch7D
         96q8ehbXyknh5QmC/VgwhOkOAUzZAfH7s1TTjP+3j6WI6OTLwCKJBv9xOE9CPa5coNKl
         cFIAWWvBLO6LZMrX6CPxgvF9GrPAqt09pAIr0pRZWzS3sweMhHSEgsKPEgVQESLl4sSw
         I8jA==
X-Forwarded-Encrypted: i=1; AJvYcCUwSn7KYdmcyZk8ryZtt2DgiJgFgsumIHkgknNgXi3UxwYlXittID7Tj2D2aQwxKLbFl48qiLTsjRH3huk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW+/wrf3RFSdD0bclRzCYZT1rXYVI1FemJtKoWLXeAcRSTle+f
	f+2O0vhQzt+X/vG7fpKYBxOTjpINyKpqhMy14mtvHC7JPgg4zrjoCWW7ZMbNdGE=
X-Gm-Gg: ASbGncs7jsfieLRdGbiYPuylYo2iBMMyhx9CXZ5KJa8cGGkAupJu8rxOcB+RMrFw9Sh
	XPAxMeGGU88zMi8zG9IxetNm3ZU3TguhbbSclUKLPn+KGr5NLDzCTiUk3Cgw6NUzyPqh0Q7Ru4g
	z7N4bcbWxfNjpVk6YQOZvceVkfvpg6CzbxbZcqQzseYBTTM55ZahWIDBHtRwS054irqaRgUluJz
	AUqPWa50XZYG0T+zEhMYAFSY6ICKxq9H3OZEG1Z5vo3xR5DmmdPQCiQDIt3BV5YXfGH4sfahNMq
	LIOOoDkzmmO+zVvHUqCukli0e0xaU3TVztakopbqx5BdfBiaIUcO5/mifEFz+QIE2W8wuc1m9Uz
	/D8eABgV6w9Ot6QgtlVlvYDhEqKpleYlV/Ik=
X-Google-Smtp-Source: AGHT+IHrrb7AScFRtBfaNFLlZM+jiXsLwg/fzvdWwyFOnAz/lH4fGoCWUFYo0xq4xZSHu2tdTs/0MQ==
X-Received: by 2002:a05:600c:1383:b0:43b:c0fa:f9c4 with SMTP id 5b1f17b1804b1-43d44d6c6bamr24271375e9.4.1742485657551;
        Thu, 20 Mar 2025 08:47:37 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f43ed6sm52076145e9.13.2025.03.20.08.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 08:47:37 -0700 (PDT)
From: Petr Tesarik <ptesarik@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH] usb: core: do not allocate buffers from a DMA zone unnecessarily
Date: Thu, 20 Mar 2025 16:47:33 +0100
Message-ID: <20250320154733.392410-1-ptesarik@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no reason to keep GFP zone modifiers in hcd_buffer_alloc():
- PIO mode can use any kernel-addressable memory
- dma_alloc_coherent() ignores memory zone bits

The only place where GFP zone bits are used is when dma_pool_alloc() needs
to allocate a new struct dma_page, but that is an omission rather than
intention.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 drivers/usb/core/buffer.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/core/buffer.c b/drivers/usb/core/buffer.c
index 87230869e1fa..2be4c2a5b214 100644
--- a/drivers/usb/core/buffer.c
+++ b/drivers/usb/core/buffer.c
@@ -108,10 +108,6 @@ void hcd_buffer_destroy(struct usb_hcd *hcd)
 }
 
 
-/* sometimes alloc/free could use kmalloc with GFP_DMA, for
- * better sharing and to leverage mm/slab.c intelligence.
- */
-
 void *hcd_buffer_alloc(
 	struct usb_bus		*bus,
 	size_t			size,
@@ -128,6 +124,9 @@ void *hcd_buffer_alloc(
 	if (hcd->localmem_pool)
 		return gen_pool_dma_alloc(hcd->localmem_pool, size, dma);
 
+	/* DMA API ignores zone modifiers, and PIO should go with default */
+	mem_flags &= ~GFP_ZONEMASK;
+
 	/* some USB hosts just use PIO */
 	if (!hcd_uses_dma(hcd)) {
 		*dma = ~(dma_addr_t) 0;
-- 
2.48.1


