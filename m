Return-Path: <linux-kernel+bounces-536634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB630A48204
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1DF13A5AB3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF58B25D1F0;
	Thu, 27 Feb 2025 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b="kxuWw/FV"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E6F25CC99
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740667832; cv=none; b=BHv6WvK9R+Iozh+QB4AGJrWvDxG2x/dkDZnyVXzK7LMpspPw8C8PiJyq3uE9MOy5KxjIaTTE5aR/sl9Ceh0zLz+wGEHq56zczeN9+hqhBq7u2m/7+2vL/WjFvGQ5lIrNG0AjWx1R2F4Hny6Gzf/Pv4B6zjtszcF7wDUQOnzVve8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740667832; c=relaxed/simple;
	bh=xKewhvd61D34B7/4mI+vcI04M2ezWfrHW8vP8EGROvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JsiFwRfPkdMzgtj/LRGIEcGi22lQF212pJGN2Jcxc2r1NxAC0Nzrwi/ViZYcQ6LQUTYFFb4OiXWdp8ip6BYsP2LeP0mNOiBvrbOjkyR61WFFPgQGwoLLie4BYYCJisFYrg4MX1fT7AfO6YN1e4lFjepL5ia+2l8Nimf93lZrdbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b=kxuWw/FV; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5deb1266031so1634860a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 06:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.com; s=cloud; t=1740667828; x=1741272628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DL7GQVjUzjLg9lk8430dC5QosMySgAdQwlmn75yWWQY=;
        b=kxuWw/FVYEmROqj0tTxz/1a+8VKWaZsPX54cqhdTCArS21r2M2TNTQF9tQRRq88wQh
         GJPMY9ajQ8SnqJwo03yn+pXW3gGkorjfgGKOeX6WMDTs6mlP0FcGuXGm14QdhbSFSxW3
         AvwEnTDcc6mIktKGUGvi4qPH7TbxozgSaVTDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740667828; x=1741272628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DL7GQVjUzjLg9lk8430dC5QosMySgAdQwlmn75yWWQY=;
        b=qpqYteTfrwRE0FmHR7mzAKTf2/uIY7iWf2kmZ2RB9haFH+w9V8o0BdwGggtqFQooIU
         ApP2h/i9/8q6g6aGTtv4zOIDDXlFPOOHsz0nGC36ub/tN/3k6k8uNxbfRsaZ98wkNIIC
         NdRZpIQSheehGecRHRl00KgpMOLe6kxjOf/wLMCdueVajNx8lCaDArJyFXwz89Nu/GpJ
         gviuHxjDtoqET8KR7rBbesEegU5XqPQSSFmh/1bEwXE5d873azEN23L4pxFL9lDGGWFC
         LMkakZQmKkn7I3AsHOKZlkeQZmtb7tCoaEutY5K1l+SAkTKO4e33ipR5bRlevxrJnDLu
         H+ig==
X-Forwarded-Encrypted: i=1; AJvYcCU3NJobr1WNGLl0oPdYKq4lkXdWiJZCCUdTH7gZi7GkP34lrjNj5glVScEtpw2PRge6xpz9Gdt7WWE7uXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrmUvhGEM5yw/bwZRPFzoM6O1V/j6g7PC5TxgEQitnMnK01uLA
	ELHAw/2OpxfwKIfS6fDRJ6tK/fXky8JWBByH3SHJ3z2J73H+2yoxl1P+g0BoKn6ryTMiN5JVFfl
	E
X-Gm-Gg: ASbGncsy3fjVluT388AjHkLdmItvYiU8pwSieeDvh8nOKuCZlwlkL/zVlJgxQVu9TLF
	pyXw68X/9bdVphQ8f+v8r2w2SXcDfs2NMmTPg9TeGxhcLLfiHbNPmmCCNFQ6NjooGxpTEmsF3/m
	SJVYWaL71FetvK1XFsaHHKQgakBozdT8Lt6M6TOMoSsSJwc2Hh3ZF5n50T/r08NfQ/oD9KBnw8W
	GjXLVh2qnErDPcLZp0e9QuXkA1mR4mqdOx2xaw4y9QbKFIRMgmZWWKw077jfgwxYOuM34IBBMnU
	cIDt3QFplThEmqhR9FDYIitmTfW5WcLb9nFz5o9x74cGYNCz3ZmY6vCe9oWx7j/JYA==
X-Google-Smtp-Source: AGHT+IGRvMe2rXEL5ocoy5Zl+QpTBISfmDkxZx112r9QomOkAyIB+XxUpSAYrFRY61XCOHlRKjn34w==
X-Received: by 2002:a05:6402:430f:b0:5e0:4710:5f47 with SMTP id 4fb4d7f45d1cf-5e0b7243e16mr27359409a12.23.1740667827673;
        Thu, 27 Feb 2025 06:50:27 -0800 (PST)
Received: from fziglio-xenia-fedora.eng.citrite.net ([185.25.67.249])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb5927sm1169710a12.53.2025.02.27.06.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 06:50:26 -0800 (PST)
From: Frediano Ziglio <frediano.ziglio@cloud.com>
To: xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: Frediano Ziglio <frediano.ziglio@cloud.com>,
	"Juergen Gross" <jgross@suse.com>,
	"Stefano Stabellini" <sstabellini@kernel.org>,
	"Oleksandr Tyshchenko" <oleksandr_tyshchenko@epam.com>,
	"Bjorn Helgaas" <bhelgaas@google.com>
Subject: [PATCH v2] xen: Add support for XenServer 6.1 platform device
Date: Thu, 27 Feb 2025 14:50:15 +0000
Message-ID: <20250227145016.25350-1-frediano.ziglio@cloud.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225140400.23992-1-frediano.ziglio@cloud.com>
References: <20250225140400.23992-1-frediano.ziglio@cloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On XenServer on Windows machine a platform device with ID 2 instead of
1 is used.

This device is mainly identical to device 1 but due to some Windows
update behaviour it was decided to use a device with a different ID.

This causes compatibility issues with Linux which expects, if Xen
is detected, to find a Xen platform device (5853:0001) otherwise code
will crash due to some missing initialization (specifically grant
tables). Specifically from dmesg

    RIP: 0010:gnttab_expand+0x29/0x210
    Code: 90 0f 1f 44 00 00 55 31 d2 48 89 e5 41 57 41 56 41 55 41 89 fd
          41 54 53 48 83 ec 10 48 8b 05 7e 9a 49 02 44 8b 35 a7 9a 49 02
          <8b> 48 04 8d 44 39 ff f7 f1 45 8d 24 06 89 c3 e8 43 fe ff ff
          44 39
    RSP: 0000:ffffba34c01fbc88 EFLAGS: 00010086
    ...

The device 2 is presented by Xapi adding device specification to
Qemu command line.

Signed-off-by: Frediano Ziglio <frediano.ziglio@cloud.com>
---
 drivers/xen/platform-pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/xen/platform-pci.c b/drivers/xen/platform-pci.c
index 544d3f9010b9..1db82da56db6 100644
--- a/drivers/xen/platform-pci.c
+++ b/drivers/xen/platform-pci.c
@@ -26,6 +26,8 @@
 
 #define DRV_NAME    "xen-platform-pci"
 
+#define PCI_DEVICE_ID_XEN_PLATFORM_XS61	0x0002
+
 static unsigned long platform_mmio;
 static unsigned long platform_mmio_alloc;
 static unsigned long platform_mmiolen;
@@ -174,6 +176,8 @@ static int platform_pci_probe(struct pci_dev *pdev,
 static const struct pci_device_id platform_pci_tbl[] = {
 	{PCI_VENDOR_ID_XEN, PCI_DEVICE_ID_XEN_PLATFORM,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{PCI_VENDOR_ID_XEN, PCI_DEVICE_ID_XEN_PLATFORM_XS61,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{0,}
 };
 
-- 
2.48.1

