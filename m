Return-Path: <linux-kernel+bounces-575456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3813CA702B0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28050881A80
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CB625A2C1;
	Tue, 25 Mar 2025 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ui1HN22k"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7DC258CFE
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742910012; cv=none; b=AtEDgvJeMQsQwtPYwVt6wEum47ZP667TD7voVavjnqYsLKzbbZOF+4mOnNFTbHpn2mxnkfsFm2nx4j9WjqdaGRXp7+OlAOXq3li3LzDUXIe4eefj0tE8YIWYP3K3/MSyJlUPFk/m/ht/9rLdqlcitPk5dXkx/xqBenY4PHGnTXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742910012; c=relaxed/simple;
	bh=gfN7cMZt0m00PoH2OI1tjaBb8cDZ7CVfoz0QzMwPGX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJMVQu3cDL0uvgVJyVlJ0hCFolE8FigpWdpugIeLTbDhuBakuvdcTkhCPYsBT+AOc2z9wYrhsloNMxM8PfsTuQQ0j2tnwbFNaqpwcqIhZDtcoDKPb8PVbfy8RmRnm0jCIlNGWRAEg2uiQmlgtllhqpczMtXd6m9KoJxCgPb/93Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ui1HN22k; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3913290f754so709655f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 06:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742910007; x=1743514807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7feDy+sWNSv66+UsfBQ6A5DM/YLrYmP4DUJwBvM+h4=;
        b=Ui1HN22kJpuZD90teILb9gy2OYpbPArAIOw3efszye3l5MJtDJxoKLkJYeC0B2zsve
         9py+xSB26tzwrU47gjgU0JPa+rh0ULmgN4oTTNRiQKpnsxW93WF+C2igIAGghnLbMeKN
         5bCEAaIuEpqFHCQR0aCzZOzljD/jKtEuWzyV8iZFg/U779yVkF2CoIiorZS4NGzbPPNW
         1lNy7BdrVp2xbZVAwUBmttQ0bJ/F/RIZRcDL4TRaD6LC14svkPTK3Ldl+VClSKEuO+/c
         TfMAaGeGJ/DrSdBayOmRkkBt2l8h//ytmq5XOOjlVMdRm7I+StIBN6fuyPDNEKe9vosB
         5LRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742910007; x=1743514807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7feDy+sWNSv66+UsfBQ6A5DM/YLrYmP4DUJwBvM+h4=;
        b=QQvGMkSF7anzm7zSttW10UZV9DWFz6PRJZLrDrcDOmyXhG8yh07KxfBPwm5l5dZ0UH
         J7l2U3Bkrws8XdoEuPoCXh6h4TiZXJIa35QsdMvJp/duSXeNDK7fUJ7cRTiZTHboux7z
         3yDHPK4uc0mhBmwzGj/tF1X3So03s+xrO2zm/BPjyhaLtN0hgW1Di+q1nIFmQBrTDGhX
         HXsE1debrW+Vj/Nn6YFNLDGYLC8WSBtqMQDS5/xU60kP8+Sd0khz1VcEUZ0XOphYq6SM
         G9o/RpXmwmG130b0hmP1gKRqewuaHxX3LAD1HHRbIIVHuUyiRX898ryR7m6y803//r8J
         WITw==
X-Gm-Message-State: AOJu0YwKotHodpyPwC0UN81+dyOndUUX69FwrYaqc88ZEY9/dWnn3oSx
	Ri25SGM9sdFit69HrLB+V12GPgjt60xV9De3S2/9//FL52p44UIWzAvI8Rq9beMrjdBXYyfU+Ge
	4
X-Gm-Gg: ASbGncvrLFpFWxc+V8CzS1HztQOWcISXidpO9dmT1ECUb+n8aPA7b/oMuj+H5SNlVTd
	uXo4js+vcbphTvcwBiLSdIJO4eP2SgkAPs/WaRQ7yZhXstHrEo9+ST+cHwTk3q1rfo2ufPyogB3
	30W1NDh1ac+qvH0aMXd5TuTV4xuMFJDvKmXWmqHZ/pa19m0xkj2ZMdDdTEgUtJkf3tMNuw2WL8d
	6eEtyCl7nKUElbYnfW2AIEwaK5CFLCBxqRy7A1g+PybFssmOdmGK8XugqaHLNjb3jqDUhQqi0N3
	7wS/HIePqk27nQJzIOKRf5gjiy/PmlZy5hxn
X-Google-Smtp-Source: AGHT+IED2TuBVJz/QsKt7tFUBFUnL7V28VtfeqSnvq7Lx3KDoQ/LLrNVxkuZwXYlKSIof6+LVtQOcQ==
X-Received: by 2002:a5d:5f8c:0:b0:38d:d69e:1316 with SMTP id ffacd0b85a97d-3997f8f4a93mr5708785f8f.1.1742910007335;
        Tue, 25 Mar 2025 06:40:07 -0700 (PDT)
Received: from localhost ([99.209.85.25])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef1f15fsm56604616d6.34.2025.03.25.06.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 06:40:06 -0700 (PDT)
From: Petr Tesarik <ptesarik@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH v2] usb: core: warn if a GFP zone flag is passed to hcd_buffer_alloc()
Date: Tue, 25 Mar 2025 14:40:00 +0100
Message-ID: <20250325134000.575794-1-ptesarik@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320154733.392410-1-ptesarik@suse.com>
References: <20250320154733.392410-1-ptesarik@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove a misleading comment and issue a warning if a zone modifier is
specified when allocating a hcd buffer.

There is no valid use case for a GFP zone modifier in hcd_buffer_alloc():
- PIO mode can use any kernel-addressable memory
- dma_alloc_coherent() ignores memory zone bits

This function is called by usb_alloc_coherent() and indirectly by
usb_submit_urb(). Despite the comment, no in-tree users currently pass
GFP_DMA.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 drivers/usb/core/buffer.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/core/buffer.c b/drivers/usb/core/buffer.c
index 87230869e1fa..10844cd42e66 100644
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
@@ -128,6 +124,12 @@ void *hcd_buffer_alloc(
 	if (hcd->localmem_pool)
 		return gen_pool_dma_alloc(hcd->localmem_pool, size, dma);
 
+	/*
+	 * Zone modifiers are ignored by DMA API, and PIO should always use
+	 * GFP_KERNEL.
+	 */
+	WARN_ON_ONCE(mem_flags & GFP_ZONEMASK);
+
 	/* some USB hosts just use PIO */
 	if (!hcd_uses_dma(hcd)) {
 		*dma = ~(dma_addr_t) 0;
-- 
2.48.1


