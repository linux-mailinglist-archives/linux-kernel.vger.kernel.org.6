Return-Path: <linux-kernel+bounces-392653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC7B9B96BC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1C91F2250D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE931CDA35;
	Fri,  1 Nov 2024 17:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEF6wGc5"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D80E1CB321
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730483265; cv=none; b=f4IOItmkONTDk37H2EADyib1slVX2ocRWgpTmEfEm3zYKB6Y89c1LTno4iY9GNkc+6csY1d3TtlhRLvZ4LKERcUUn0Z7i2LTB1XU5rXrZb70Q6OGKallFa6zH7qUjEXbD61gNrhL09UeQpfAGxF5zVrnZJjCQ7PHqlYYLxk8xrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730483265; c=relaxed/simple;
	bh=KxFLCYeLJza2wbtJq3ncvPACnBNOfSsUAesffJ457fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E5CUubEMTCSnfw6zf4b/fZzuFkvAw+dB2xCIlCIn0idqpkH8sMnKMiDfDZJPSt5poUVWcQuvtG+KEaNLeSxbPudrgBEV15sRL4FTjwegJtcAEp5MLQ4axipx2kBtm5nK4m6MBYKs7+EYvprPhbxr/0yGCmykwLWEs7B4qgx0nAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEF6wGc5; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4319399a411so18881915e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 10:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730483262; x=1731088062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaiHnwo8DRW+cYed7a1HEMqLUzjFX++R0qMPfhF5vLM=;
        b=eEF6wGc5l/0SgdAylSGABCl+RW7bUy6jIvAcHdtLl42Q7/ECrgFKjLIxMW+fYcpBiN
         d0myHejhPXYWALkuserwsoNX4656hEDsmHsvOPbjs8FriJDY6dfHNU9RARrbDVzqYpc3
         fHPltWtfJ8A7aDWGI3F3j2NrbHDs5yTusH0Xr8jv3fiGwl1NQMnmcFVBPo9OpLq8gPkn
         k3g9HgbrOTYqnmjSk/DrJsIrpbmtvymvsEpQcJULMJa+xYEPd4YVQXtnvgBgyoFYAsAH
         FlHn2LtUsA66x12peskOIW3tstFFsaJ3aBEdP2wcKFVCcANcWly2wA+fMt4I3U8PW6ue
         tCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730483262; x=1731088062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaiHnwo8DRW+cYed7a1HEMqLUzjFX++R0qMPfhF5vLM=;
        b=w10F8B1K81ztUxM9g4gFQ5MKuv22a4Zk+SZfGEd8QkUIYyjxcTuNveNtcgvb9urXbY
         9THMpnIT5CPiAyfobF5SSsHXoJx1l4RhC96meoMXeteRjvpcNVC97PzQndmfFZNpzSXJ
         7Tn14xWnyXzBrVa965PM663eBzJqFKvMFcEzGrZyL/ISdYle5OBZ5JYgsLXD2LO0xT+m
         FKaz9H7JtzXJ3oS43fNUM1/p9zWoe1J1XiuAmtd3K4aCYCvBa0psx13BP8my7nVLst3a
         XCIrt36LJHQ2RDpGZ8p+1wLWnxPloxdZUEFC5VfXDSSP8tc/ppLSAfL/pQSvfhSlsus2
         C9tg==
X-Forwarded-Encrypted: i=1; AJvYcCWWRTZfR/8H9WuV/2oHkxkG7LekDVt+eLrok3teOZaxXOGIlN7cDq04yVWs7kc1S8wmYTfgd9FardnorD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXRUzmPhXCN/7ar6IRq+HfOboCjlp+UTSyO+eLpdGyFD1Nap5+
	BuywNFzERnWXhAcH6e3/wyXBXPlU2JhFqaCZcwiI8N5YsanxzdFb
X-Google-Smtp-Source: AGHT+IEoDC1+DdRyNwiGYE7qetGrHQUyrDq7g7gNsyLBOiO9dmY8iHh/vdMDVHQHSTCGd5Si/xC6wg==
X-Received: by 2002:a05:600c:548a:b0:42c:c003:edd1 with SMTP id 5b1f17b1804b1-4319ac9c555mr211530915e9.10.1730483261864;
        Fri, 01 Nov 2024 10:47:41 -0700 (PDT)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c1185b4bsm5732933f8f.112.2024.11.01.10.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 10:47:40 -0700 (PDT)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	arnd@arndb.de,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 1/9] Fix buffer overflow in ni_usb_init
Date: Fri,  1 Nov 2024 18:46:57 +0100
Message-ID: <20241101174705.12682-2-dpenkler@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241101174705.12682-1-dpenkler@gmail.com>
References: <20241101174705.12682-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

  The writes buffer size was taking into accont the number of
  entries causing random oopses.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/ni_usb/ni_usb_gpib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
index 571f07800c9a..9ff56b063681 100644
--- a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
+++ b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
@@ -1726,7 +1726,7 @@ static int ni_usb_init(gpib_board_t *board)
 	unsigned int ibsta;
 	int writes_len;
 
-	writes = kmalloc(sizeof(*writes), GFP_KERNEL);
+	writes = kmalloc(sizeof(*writes) * NUM_INIT_WRITES, GFP_KERNEL);
 	if (!writes)
 		return -ENOMEM;
 
-- 
2.46.2


