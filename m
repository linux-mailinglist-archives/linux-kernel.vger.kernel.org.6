Return-Path: <linux-kernel+bounces-400696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F839C1119
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75A01285951
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC2C217F3C;
	Thu,  7 Nov 2024 21:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXJbqV3x"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828B7FC08
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 21:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731015538; cv=none; b=QCP5jk7BL6AZDGdVWTta1I+x5KHKr2AuG3eyj0XaJHH3FbRbYx7GSW8qXRU9WSt5+hwLhsykI+J3gL9+SXRAUwNuG02/LZXM+8ePkSUHMU/U5LzKTwVm8lKUCCj2g5QLYg6FDe7MHknQr0jwucPrMdMQjPbDGpx6rtLwMZBoAf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731015538; c=relaxed/simple;
	bh=nvfpowuQR9GkDF62EOjFvmkjqhi+8SRsaAUYIJIYPUI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=pf6BoE/FRPmaAavFz7D3V/zqlZVWQbqijKmWYNMYMLTJzObqz6EcI2LIJHS7akIz2AJsE7JbD2MByM8alNGeq9jUn6K/ZjalDZnTHc3ZKTZrW9R+u85NdjOHI/KcTkxAJegX8mvcel0F4Qy+v1V0YAfxJLtcFDN7Cj6hKoWumsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXJbqV3x; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c941623a5aso4444216a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 13:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731015535; x=1731620335; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/PXz3VkkWyN+2D2oow1fRGOsXfzv5vjwk8qUZgMvfo=;
        b=EXJbqV3xlIPDBq2/mUVO7YUgXD7wUwqJl8JAgHwi7y6KRXX9BzdyE3+cCC6Wxj+V0U
         5I7OkSrmQxoxoGKMN4zEXwpFbS4WmF3lKpDYnpGB79T60R1oKkpmZNT5wEohK2yC+ghq
         q7KvLhtjS2qi0aRh/QPeHsRRiHIaf8pQ0bKSTBHUU1/b6qTB2hhHVmMLw7BDBkkaX3qm
         gQ2jW89ViTwmNrAGULH5wpFSK1Ydop5S8LbX6tGim7q9jsG3WtxjOUchDMA8NMOUwNPE
         KjcxRnkOZaoocmLEaVbMMMB1S1WPtLO74Wxd5QemKO6MTyqCX/P7a/UnkD7ZeS0wK8j5
         8qbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731015535; x=1731620335;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/PXz3VkkWyN+2D2oow1fRGOsXfzv5vjwk8qUZgMvfo=;
        b=Okpy+aeNYQ9GqZl6pxGjLU519w2oyTlnZi9n4NR/BNXCsS0A56Za0Ttw5y+gXximEp
         friK66u6ZR/KQm1P6ob4LvoJDbKu4gHb0W5iVA01DvyB3mi4VE77ACEb1VNAOYA3Bw7+
         yjqlThMBaLrIVr5XkkUwJI2pJF1RKYqdViozbi1XVD/w9YX2j1QCHnOs2TICjwhJDAXy
         Yx6i0GzyloxNQgA8YKtd+FQXtChMPjDNdZ83XhU966U/ydbHN+8rj3u07Gfwq1YvSj8y
         tRu3co5Ei2UYvwyxBa6HPmkt/TPO8rqctoFumWOxx4PDMs0etqq+LWnsN9muZgnTKGY6
         E5+A==
X-Forwarded-Encrypted: i=1; AJvYcCWmgDvquEfAwHc8yNAPIzkQ+8YHByIo/5+blgd929fs3xWuG8Brp1ttmecUqRfm1kRq7BUQgdh61hm4Wmo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7VDTZZlDL/58MONzVFJsNVDEO1d5RiPb5E6b0MAow8hnoeIbQ
	g5/tppDHsNnPe1A+tBCae0HYdurNu77yHuY3ev3xmgQWOjkY84vLbo71bsOh
X-Google-Smtp-Source: AGHT+IGrTcEMUOmBG45zZLNEkrmXgDUovpg3LtqbZ0hMpIXyz69P4bY+5b8Ffu15E8z2Ufn44L0JuQ==
X-Received: by 2002:a17:906:f598:b0:a9e:b174:9cf7 with SMTP id a640c23a62f3a-a9eefeb4df1mr31857966b.13.1731015534837;
        Thu, 07 Nov 2024 13:38:54 -0800 (PST)
Received: from localhost.localdomain ([2a02:e0:9868:f700:985c:6c07:e7e5:186a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0deebabsm144917366b.153.2024.11.07.13.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 13:38:54 -0800 (PST)
From: Omer Faruk BULUT <m.omerfarukbulut@gmail.com>
To: dpenkler@gmail.com,
	gregkh@linuxfoundation.org
Cc: arnd@arndb.de,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Omer Faruk BULUT <m.omerfarukbulut@gmail.com>
Subject: [PATCH v2] Staging: gpib: gpib_os.c - Remove unnecessary OOM message
Date: Fri,  8 Nov 2024 00:38:12 +0300
Message-Id: <20241107213813.19185-1-m.omerfarukbulut@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

It duplicate the MM subsystem generic OOM message. This patch fixes
the following checkpatch warning.

     WARNING: Possible unnecessary 'out of memory' message

Signed-off-by: Omer Faruk BULUT <m.omerfarukbulut@gmail.com>
---
v2:
	Changelog text  wrapped at 72 character
        Unrelated changelog text removed
        Trailing spaces removed
---
 drivers/staging/gpib/common/gpib_os.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gpib/common/gpib_os.c b/drivers/staging/gpib/common/gpib_os.c
index 27654b2180a5..7d5244113f1b 100644
--- a/drivers/staging/gpib/common/gpib_os.c
+++ b/drivers/staging/gpib/common/gpib_os.c
@@ -2093,7 +2093,7 @@ void gpib_register_driver(gpib_interface_t *interface, struct module *provider_m
 	struct gpib_interface_list_struct *entry;
 
 	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
-	if (!entry) 
+	if (!entry)
 		return;
 	
 	entry->interface = interface;
-- 
2.17.1


