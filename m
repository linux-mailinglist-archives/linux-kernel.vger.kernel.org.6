Return-Path: <linux-kernel+bounces-395318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0940A9BBC57
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C26032827EC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBD9176FD2;
	Mon,  4 Nov 2024 17:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejPkYLOC"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0667B1C9EDB
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 17:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742625; cv=none; b=ITwseUhVE1uq7eYdcWci78R5U1R7/b1ZbhJ3YDTq3g8/rHAjcvX6G2/8hIpNtpONTzxP6aImvHw3y+9vxs1cGw8oiXZp4/FJcxx/aBz5rE2VTH1TJwJ3eXNzBHnxCM2f+xHvh/I9gg+siOziMprWRvgxsvme2VAdND5CZiKEQio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742625; c=relaxed/simple;
	bh=Yuzlz/gAXGepN585boJbCqwkRBFgUVeNpMhTrcpSlGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUEr8Dg2nbZwncHhLHLybPRVkzOeJec6BDIlW3AngAGIsQ5IM72Gv0z4vfN2rLmmNxKTUHSOiVxxCwWbU32DWolHBsq50Qi6VGw3KNZQEXRo/a4GD5UpAt7K9vvOqkIF9KPvo54hW9BvgWAHh8lEokeiu+BESPon34O8tbZGW/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejPkYLOC; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d518f9abcso3087891f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 09:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730742622; x=1731347422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tM1Vc6LIKdr1UuGOL4gln8Hsis7ai+S2TMSH9A6g84A=;
        b=ejPkYLOCy6keMUJow1CmmHmVhJjz0gM5+lTKCjOAbt1MfUFg+EyiBu9AQ6UJl5fZ0j
         kkwoyzQjgogsj0B1ZXPWKpk7VVKXB5yaHLZuS7oa05LnxpqH2+KVTWx0nr6eimsD/32W
         fDeplAKSWKa7LiFQrirV3i4s/NuGqaVbInq8P2/PtyxPciFzIslylSTcsrV0lUr6dkVe
         vyo00pGuPdgp6dBsYdg4rqnfmsXjO5S70flODBYbcmBrivEtDTM1TMYSOdwfjkTxYATJ
         ef0ObgybXq/6CAJ3XdvMbeYcIHJjg9bMgWB4us8438KzuReHwDsBDqekl4qRPm8hhA0c
         +V8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730742622; x=1731347422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tM1Vc6LIKdr1UuGOL4gln8Hsis7ai+S2TMSH9A6g84A=;
        b=C0PIKO4/5NeBCNcbmPsEMAqv6fiLVIAJIpnGB+UfRc2t/qBp6k15gBOn+77iuqLBOg
         ZeQqRqTjyT6D9iyKydPh6p31cqo1Z3531AarLflB38tCB7XXlXObcQQBokozVAIG761h
         GaqradUp6t6MmhSdpeu1lK3M88uQkgrqijMxxvSNZ+IflgCZsSbGb63IACXN9IDpUnFn
         QAN/8vMtR3EjLqbKogspa2weqFntZyU9shmkEJQpVbXuHwRBy3D0hvSAS5xR3k58urVY
         OIMv9VdkfvFb2Pw8U9DQbjmExWQfGlevj+du2/X8beGMDo+HXOgYN6ZQEBSefhaqWNmx
         Xh3A==
X-Forwarded-Encrypted: i=1; AJvYcCUUPINF0OnApdkbXor/vs3KNSCRMjoP5XLd4+1r05vGDYaIVSy6Mek476YcUVAw7BTQhW26qTuo9a1NSNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvqbXkr/Rq1Nl4ktK3dytkFAUV9mfffe9dufFUyiw89AJEmNLf
	1RazgyxIRccQblBeHqxH1y1xMlBZl9njziBMPk08OCTpyBtBvbEA
X-Google-Smtp-Source: AGHT+IEQm+bKTmeh2Hd6jsEfemnIjw5OPfstig+UCjqrc3WI3GQug0ImO83tQxckObu0zIV5Cwcnfg==
X-Received: by 2002:adf:ea43:0:b0:37d:633a:b361 with SMTP id ffacd0b85a97d-38061206c0cmr23241855f8f.51.1730742622242;
        Mon, 04 Nov 2024 09:50:22 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7f80sm13839821f8f.20.2024.11.04.09.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 09:50:21 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	arnd@arndb.de,
	dan.carpenter@linaro.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH v3 01/12] staging: gpib: Fix buffer overflow in ni_usb_init
Date: Mon,  4 Nov 2024 18:50:02 +0100
Message-ID: <20241104175014.12317-2-dpenkler@gmail.com>
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

The writes buffer size was not taking into account the number of
entries in the array which was causing random oopses.

Fixes: 4e127de14fa7 ("staging: gpib: Add National Instruments USB GPIB driver")
Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/ni_usb/ni_usb_gpib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
index 571f07800c9a..b7550a937f15 100644
--- a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
+++ b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
@@ -1726,7 +1726,7 @@ static int ni_usb_init(gpib_board_t *board)
 	unsigned int ibsta;
 	int writes_len;
 
-	writes = kmalloc(sizeof(*writes), GFP_KERNEL);
+	writes = kmalloc_array(NUM_INIT_WRITES, sizeof(*writes), GFP_KERNEL);
 	if (!writes)
 		return -ENOMEM;
 
-- 
2.46.2


