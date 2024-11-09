Return-Path: <linux-kernel+bounces-403018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D6E9C2F9F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 22:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA919B21BD6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 21:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8C91474C9;
	Sat,  9 Nov 2024 21:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHWDj1Y5"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B094C38DF9
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 21:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731187228; cv=none; b=rh0MKy7WLVLtXcYMJEDLtYMS+hRi5wV2CpJGzP6qB5RvN1Fl6FR0FuEi60J5vBTp2kPSJGeoIpuNATPZJAUTaMJ6AYfc0N8NEdUeEfwX+N5Ka/4qmv2od26vPOppkwlBbu4gPVjCm0rNwNPnKoyCA5Owph6WbRQ3Q5vl4AesTLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731187228; c=relaxed/simple;
	bh=zX6YE+/DDtNfVrgMGSZcRMfqOuc0nTcDRyL0ymhSzz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UKyOiuLsgOLAFehlqX7iFpTP/FHATLmOLTJLmRSW9Vg17PGSDdWaENCK7YEt/G3nCuqvqbzYUuFYGiJRkPC3zrdVNmd8fwz17zwmglf2TnwcrI/42AxgfWt3G2g7xA/WGB6QcuSwNjGs8JdMugBOsLN61Od8/VTQrhk1tatCrmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHWDj1Y5; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a2209bd7fso545382066b.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2024 13:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731187224; x=1731792024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AFZmkyoCv2kVb7ODlAwqK+9+SWXoO1Y9sGe1uejDVg4=;
        b=NHWDj1Y5MOPIHVnB7/XRSCNmBfH19nphrLvc/16zjG5MFqGpf2GW7QPBFwpEr9jdrD
         295v7cWjLwkw7YzIOD7PSTbXlVKLCsB4skY5fKipkmdbEQD1C3Ftv1ui9sRwRlMBBShe
         eCyPR0jLWQK1kAx8dVZ4cRBRvUf5wWAXzhW4tCIcDu3sr6DUwgDgWgzj7qiYcs/uBe6N
         JzT3vVF69ElBOQ/1TVyhEgG7WZ9er4tjImauRdQiows3cgZNmAPuPOGat96YGQZ7LcUr
         N4RrYZR1xM8DRzlOLFZXrzZjS7kBPi+HZpzBo4TED9AMNeaJheYqmf6kvTaV7WifXbKV
         almA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731187224; x=1731792024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AFZmkyoCv2kVb7ODlAwqK+9+SWXoO1Y9sGe1uejDVg4=;
        b=SgT7/mMgBgRPot6fShU7r/faVNfPk9xhrDg05oTdQoTcfoV5HAfdFMSk6B3krdF+Gv
         oYwn2FhjVtXazv4N9qxpRY+nArnH+4A3p2Dgwi7Du4ac+Lamr0WeVX9KyAwkgGnpoHlj
         syX0Van6X29usJgPE54NCl78WRuvI2PWdZA9+dBxzF1+OhgRY7cN1YzCc7xd2PzKJt6q
         uTtc1enK9UmfOfREEnnBX3lXDiHUZaqL3wPPiZ3YUWMHcTowfCLo6spxBywFl0xwOMVh
         uWpYTLTlRY5Nm+kq3m71/bxI5HiaGzPQGZl/wPVmqXexXv9AWTrxoDmAZ3FhvZnhlxaI
         KLbA==
X-Forwarded-Encrypted: i=1; AJvYcCWJHSSNNrDHmIMS1HvQ1ttStclfLoEutVxwdQsiFVU7MbNdsPISeRW+A8vY2GmBZDtj/d3chdtpayXiOjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBXlKBpFLI6PjpThq87fRG8D2t9PLSo231X0a5amgfClgWUsRg
	29oFtDpJd3DKFuxFTZ6Tv2zdVcYKC4ZavZuWK7L38B3K+U2Cg+du
X-Google-Smtp-Source: AGHT+IEX0KiXpqhnHtQQDp+D5+tK7VGAsz5Td/YIo4FS77MqvFvBxzCgmHMQtCMZOw+Ifb5t3zzFAA==
X-Received: by 2002:a17:907:608a:b0:a99:fb10:1269 with SMTP id a640c23a62f3a-a9eeff0eac2mr684321066b.17.1731187223612;
        Sat, 09 Nov 2024 13:20:23 -0800 (PST)
Received: from localhost (dh207-40-48.xnet.hr. [88.207.40.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a17624sm406441566b.24.2024.11.09.13.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 13:20:23 -0800 (PST)
From: Mirsad Todorovac <mtodorovac69@gmail.com>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Mirsad Todorovac <mtodorovac69@gmail.com>,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: [PATCH v1 1/1] net/9p/usbg: fix handling of the failed kzalloc() memory allocation
Date: Sat,  9 Nov 2024 22:18:41 +0100
Message-ID: <20241109211840.721226-2-mtodorovac69@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the linux-next, next-20241108 vanilla kernel, the coccinelle tool gave the
following error report:

./net/9p/trans_usbg.c:912:5-11: ERROR: allocation function on line 911 returns
NULL not ERR_PTR on failure

kzalloc() failure is fixed to handle the NULL return case on the memory exhaustion.

Fixes: a3be076dc174d ("net/9p/usbg: Add new usb gadget function transport")
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: Eric Van Hensbergen <ericvh@kernel.org>
Cc: Latchesar Ionkov <lucho@ionkov.net>
Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mirsad Todorovac <mtodorovac69@gmail.com>
---
 v1:
    initial version.

 net/9p/trans_usbg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
index 975b76839dca..6b694f117aef 100644
--- a/net/9p/trans_usbg.c
+++ b/net/9p/trans_usbg.c
@@ -909,9 +909,9 @@ static struct usb_function_instance *usb9pfs_alloc_instance(void)
 	usb9pfs_opts->buflen = DEFAULT_BUFLEN;
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (IS_ERR(dev)) {
+	if (!dev) {
 		kfree(usb9pfs_opts);
-		return ERR_CAST(dev);
+		return ERR_PTR(-ENOMEM);
 	}
 
 	usb9pfs_opts->dev = dev;
-- 
2.43.0


