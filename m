Return-Path: <linux-kernel+bounces-310289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D099677CB
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 18:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C332810DD
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 16:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A08183CD2;
	Sun,  1 Sep 2024 16:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvJeG1yJ"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2364533987;
	Sun,  1 Sep 2024 16:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725207842; cv=none; b=cyoVxjtjDlrdz0JkLEKlhedAlHMNOpnp2hd3r6gCxLd6dtSxLiHGh9F+7E5nFclKY5SLcrQu3ZFul85ICFXpsz+W/r/riwkYbkYHRuOjGakbALB1Tv0XXceBWBl5H9HYbw0ibpZ3W0bUPDlrf+H+jDNhetckyscf5Q9esT7cdro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725207842; c=relaxed/simple;
	bh=BNoiP49H2z8AE1VQ81ykFPgUatiEllMk/05bWH3VtII=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=XiVfA/mdhHdQwPp7N8eGze3SyDVEux8+DOoVoL0jmEAifUnIrSTPUC6U7y6S9lw62CwJXzMswi/Xo4FtKc44DaXoIuRYSHb4WvlH+wBGoYId9eoB1X/yxMFA90SLPP1UphcbXlep/4ukUCTNqrLTihCt78y0v50BsuT/iRKbpWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvJeG1yJ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a86cc0d10aaso371336666b.2;
        Sun, 01 Sep 2024 09:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725207839; x=1725812639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KUuL6QBjyNPCBEmjXxaQIzhNE/f9uMT8997Jwx/E9YQ=;
        b=PvJeG1yJBz8N2+iXsN1lP2wDluPHg+h4z2OKcaTk1L3k1PKWS7McRVQ6Pp1qDsGXLR
         +TwzAbrZ3hwLaTs6h/dTiKKFiEbumQVBz3r7/M5yuX18hp2E82UiGtkcRFAK7tQrzyMi
         0mFoedw7H1DwslMwAAYVOe8J66hf+EUzJBGFvgc1LwSf77eE+gpoOTG8WYOdhRzxiq4F
         0APkpF76GeB3oJKwVLy0z8JZdXNuVOJPhmRr3eadwCq9Rqj0065N6zhOH2RLkLXPAG5I
         xiFTxO61O6qBfiicKin79hDR0wrsOi+4Blo+SVHwyvhu5GK0kFFBkl04NGSaq5ZqR0Wa
         NEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725207839; x=1725812639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUuL6QBjyNPCBEmjXxaQIzhNE/f9uMT8997Jwx/E9YQ=;
        b=EF1wq1aju85/N/4fSVE1pnApGYjLm/jWzJYffejF2n4tsGEwAAqGpPQxVHdalhPtK6
         p8hqb1x0BzfIOz91uEqW0rt6d4Yx/NGpLXA+YCu9G6exFa5B0Xkx1GSdbPcSKN9jJ0dG
         OQyZhCnZDINRdQNHNK7ru1slkOKOd50Oan1r4d44BL8o2Iyq+7B5xrW8Ua79Trqo27ao
         HHL8u8Z3wB4CjXKq5KKenWHXjZefGIwGBugAUYRI3QGfc91oaKbW245+GSfmTkrU5DZX
         ReTGlMC6xhbE+xtmk/oKuVFt5Jtz0CFEdBpWIBMeu482PaZhvxE/zDhikb3ZUSG7megF
         ADdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT8NVe2l+Lb1gCEh25hicbEIYYIK2xOf/I0UMJQoLPP4pvBsQqAPbANUmrGZyqZzrI2lVJzKFb3oG9LGw=@vger.kernel.org, AJvYcCXld8d/j8wrMe3DNspArbdlLlee3L1Lcd3MMKXZ13etXVmKl5IG/R6jgGHvjgYj+xkB3GYN+HR5lma+@vger.kernel.org
X-Gm-Message-State: AOJu0YxFcx16KWSNdwo+P9LU+WfITzXrhS4KI+4Grx5t7vAFjiJ22eHB
	2H+IypdNiy6MsHvXzGWFCit3XrVsouOZA5FECQguDhFlRt3zxf33
X-Google-Smtp-Source: AGHT+IGUggvoc407nwCWVSL3MosOBwDkAAp63jf1RZDnvSHH+WPbx7ttpqzJt9D183+hQXnbmCGsyQ==
X-Received: by 2002:a17:907:3f08:b0:a77:cb7d:f361 with SMTP id a640c23a62f3a-a897fa6a90emr928025566b.43.1725207839124;
        Sun, 01 Sep 2024 09:23:59 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891dbd2csm451332666b.187.2024.09.01.09.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 09:23:58 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] usb: gadget: udc-xilinx: Remove trailing space after \n newline
Date: Sun,  1 Sep 2024 17:23:57 +0100
Message-Id: <20240901162357.144222-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a extraneous space after a newline in a dev_dbg message.
Remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/usb/gadget/udc/udc-xilinx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc/udc-xilinx.c
index 74590f93ea61..ebc45565c33e 100644
--- a/drivers/usb/gadget/udc/udc-xilinx.c
+++ b/drivers/usb/gadget/udc/udc-xilinx.c
@@ -947,7 +947,7 @@ static int xudc_ep_disable(struct usb_ep *_ep)
 	ep->desc = NULL;
 	ep->ep_usb.desc = NULL;
 
-	dev_dbg(udc->dev, "USB Ep %d disable\n ", ep->epnumber);
+	dev_dbg(udc->dev, "USB Ep %d disable\n", ep->epnumber);
 	/* Disable the endpoint.*/
 	epcfg = udc->read_fn(udc->addr + ep->offset);
 	epcfg &= ~XUSB_EP_CFG_VALID_MASK;
-- 
2.39.2


