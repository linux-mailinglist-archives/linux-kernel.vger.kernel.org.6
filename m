Return-Path: <linux-kernel+bounces-343355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46094989A01
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A301C20DEB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 05:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2F513C809;
	Mon, 30 Sep 2024 05:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9seFv5q"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D142383A5;
	Mon, 30 Sep 2024 05:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727673837; cv=none; b=bu1FcLcthyxN9gZRJy8MUMVHshJvmVFP12QB2vvcUcziosf0aF8XJsabddXYflmPDFKXZCOAEVeKG9DaQ9/vzy7DaSK7WcgVEb/WhdQM/6BiY6tR3e+PYfu42bHINYz+gk1T758Vd8X0fPpVpBmMogTI73cRkXphF9qvHFYbU5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727673837; c=relaxed/simple;
	bh=M4ZCjGkRBjzSnvuSeMBy+pnWIpmS/6uhe8COAeVTvUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=urv5Uj/Vqp0J7SuDZVQevBpAbhlGzHGZUyGGLcxkKLxN7rBVJPb6w6vPb9xdM7SdfNS15xLHH8gnOe5wUGHaBz3w//sGDtLdzAPRhkrkCPkoJ8fj5hYP47RNouQkldhnJLBvz/XyLbAFy5GPgPXmNydKQ4Z0FIgsdmMDPnl+B8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9seFv5q; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20b1335e4e4so36208365ad.0;
        Sun, 29 Sep 2024 22:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727673835; x=1728278635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nDMSBasZRyeXzQwNgg3u/Py5n3PKKxDqi4bVnacC/58=;
        b=L9seFv5q1EEJ2KwnScBQIBj50FTkdlGu2zN5gayx/7KhepJRP9BKs16ei1utX5+S5N
         63A1FRYbEdZzDADCiKV6fvqEahu18xJGCTulfNUg76QOLR1TwT8uIP0kyYRiphzddfWx
         72sGDT2FkBpzd0mYGDMAraeoMEfp1rs0lREg86OLimIRridJMwgrSnnJPMGfpd28OFwN
         iyOkZasAcYjDLhtyg3xODDI/TseWC+h1xu6oOdEk83rTnHL9QeXS/mdrYMEzO6nbpL5Z
         /5n+WTzRjfbcYX4Vf6b7JvXA140fq4o9s7b6ltmgp12d3vox5EBAYQnUyeAkAvD8ytlM
         mSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727673835; x=1728278635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nDMSBasZRyeXzQwNgg3u/Py5n3PKKxDqi4bVnacC/58=;
        b=i69v3B+OFCGALoTdxSJuPlecNgtBpxKqPh5Tb7z3lfHQH6CE5iljJeIs01x6rsmhUR
         pA4xnxB8i84S2Cfl1MIrU3pjo2lfcnvQn9aJ6TQNYNj02BG6hWFPP/TQaWJ3Ydqy3jcc
         Abo+o6D+37ozV/H0P4bNHE7syQvsgxj/wcUj/qkggO0qjPMUWa06DaqO5ZdwNUBS0Qyo
         4a3oe+nHtO3GKRBK0Yc75icN34Lq1/+Q/zejF5fcVEkQMnwt/9DIQ+JXN3PY3FO3jlHp
         +oReiAZKRdOruOHEI0arAUUrnEVxV9kagTbV13S5SDgyY+vyVNzL0rYQ7K++g1A0MnrE
         TJdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp21fWjNt7s8TglFAPn2AcZ0s4A0yLXqH3g2r6IbJDI7qEaw2KH3AXN70r5h/Ko/SgFsXCVPPiMAja@vger.kernel.org, AJvYcCW9gD7vnhNBZuxZ/pzFJo0/XxVAsSrXiUEh1sjKc4q44XfJB0pXeCUzJkDxzk9fnZRsq/fLy97PO2ZlBf4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylv6nCEnVHKoWvrxvsLg+m+6jtnyB4ZLy5mUiSiTP7PFFdf2pM
	GrnM+ONMPQzPfTiwjYk8C/svKAZsp1AAGeZ9URt3Zcm53PuejWgG
X-Google-Smtp-Source: AGHT+IGiTNPNtuF9uonj0GP2hnS5bIYxCIGHa8R0aBYILgWFZdgs4OU+RAPENuesSaZteyY6raQ1BQ==
X-Received: by 2002:a17:902:dac5:b0:20b:4ea4:dd0b with SMTP id d9443c01a7336-20b4ea4dfd1mr150714625ad.4.1727673835446;
        Sun, 29 Sep 2024 22:23:55 -0700 (PDT)
Received: from localhost.localdomain (oliv-cloud.duckdns.org. [78.196.47.215])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20b37e6d01esm47178485ad.308.2024.09.29.22.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 22:23:55 -0700 (PDT)
From: Olivier Dautricourt <olivierdautricourt@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Olivier Dautricourt <olivierdautricourt@gmail.com>
Subject: [PATCH] usb: xhci: xhci_setup_port_arrays: early -ENODEV if maxports is 0.
Date: Mon, 30 Sep 2024 07:23:29 +0200
Message-ID: <20240930052336.80589-1-olivierdautricourt@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the controller reports HCSPARAMS1.maxports==0 then we can skip the
whole function: it would fail later after doing a bunch of unnecessary
stuff. It can occur on a buggy hardware (the value is driven by external
signals).

Signed-off-by: Olivier Dautricourt <olivierdautricourt@gmail.com>
---
 drivers/usb/host/xhci-mem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index d2900197a49e..e8406db78782 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -2160,6 +2160,11 @@ static int xhci_setup_port_arrays(struct xhci_hcd *xhci, gfp_t flags)
 	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 
 	num_ports = HCS_MAX_PORTS(xhci->hcs_params1);
+	if (num_ports == 0) {
+		xhci_warn(xhci, "Host controller has no port enabled\n");
+		return -ENODEV;
+	}
+
 	xhci->hw_ports = kcalloc_node(num_ports, sizeof(*xhci->hw_ports),
 				flags, dev_to_node(dev));
 	if (!xhci->hw_ports)
-- 
2.43.0


