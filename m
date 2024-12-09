Return-Path: <linux-kernel+bounces-437039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF749E8E48
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A08B7281EB3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CCB216394;
	Mon,  9 Dec 2024 09:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yC2aSGl3"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5973021638B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734885; cv=none; b=EukKYB2Ql53+WhA4yBU/ILfvOazo9Yxfnwg83br29Ql0qHJIPeTnz3SP6Vy9wPxCe2KqZkV0Z0o2sEw/y3dEgEb9wiTnzyhhsF5WzgZtlmfA0Wqq5r8ASGnVyccUkCE1T9BhCC7ofDCaMefzv6EKZjGDdCIyCOJRaz6WfmpzkEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734885; c=relaxed/simple;
	bh=WpDibjcHfnA3hlnUvjLGwyhWaTaamib5k/eDBpn4uPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WE0EUzoLgPx76LHRrKdevCjSknXDq9a3xrKkU+RAYKlKL9Hs2SluZLHItWUe/954ldQRAWF2/q5iqzB5WfK/LqlcJReiOk+p/oLwNIYyEzbF/el3L0GJFB1GOc8o7078C/bd6N2LXawvJcBNgFY8MvGAW+cdENa9SyeBsLut5CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yC2aSGl3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434a2f3bae4so45668325e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 01:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733734881; x=1734339681; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zfmkzNoJxgWiG5Z0g0jcQ4NV+0tXwsBrqoBTR0SIamg=;
        b=yC2aSGl3FCWAYmdwMFszZmWyV8j+Vmm5Tf6AeoolwMCgTywARxZZlOobdvynrsD8tA
         hdrnOAII9ukVgF0CnnRZxyz0ciY63w96loGG7Y1HzZRcT1ZAINOtoczEHpgwQkGmqQ7G
         xky8yhRvCa4JWRKbKRYhkWZGpy4Jn9k0+ClgRCR9iZeGhJkez7SjwNrRrMUFIaU8Dcbb
         d6IJz3GAMWhTNC1JoWSzvx2hUzKQxLIatgTWXLNc3wAQvF4Ga3P+LBsJ/CAJY1appRu2
         rPpqyeDMM4t5EGEO7fkL1KpNIHoMfFknXLvj1HKkAV3kFQxoDIXY40kF3s7MPw9Hcftd
         Hl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733734881; x=1734339681;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zfmkzNoJxgWiG5Z0g0jcQ4NV+0tXwsBrqoBTR0SIamg=;
        b=LwFR7FNLMvq2TENSwUY6QmnThOHSzHjGvEWSTGXhFXaAM/mKSFNxJ+9UnBq7H6+elz
         U8txWsbXwQF+4s6CXfOBtLSaPniAlt4fZ3MTJmQAn5EE7OA44e40SNbk8tqIh0uIlizN
         QPNF00PX/jRg5neH/iCkNf7PulNDkI/ILzDPEtqdtjhAaCsBZgnOVm+JUiuiWh6l+0dM
         JgveiKk9r87Kgy+9sz6tcHSMAG5WqEh1JgWhgw2Ssy0qiTgATwGTiyvoNojsBL8URkRz
         It3jg8eMkdcxpSA1v2oo9Mm5rfxECHHHgbonZtMUDi8vE/4Iuc0jxHazQNYfPixfW2DS
         iGzw==
X-Forwarded-Encrypted: i=1; AJvYcCVk8r295HGpbGQ5oRqP1wN67HW+K/0cAL2Tqnvzn8hjuocUMGZRH/B3dhwDg3TAoNAc7nw0YWDK8xmvwzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR0iJaFDDIP2KUVg1gSJUs06XU5MGQeTNdwRemJlLJMHCuL7dZ
	g6ZcuY+l5nQ43RY0mE0ATpwma8LNj1DB26FADDFP2vKpMEjpKRn/p1ts+wOR9PQ=
X-Gm-Gg: ASbGncu5+N+zEg9xhVSj638Le8PUoNi/WKGgsw4ozTw60fc+1bWi0uOS5eRmqg25/Xk
	Uvt4cUC7+QzwEXt1t7dD4OekZFaHPU8Uuucq8amTciwvCRGo7sdUGH4G2YTKmqgxIOImRdCD9FI
	Rk/oW7CkAGLg1Jxnu6bCgSc6dlqq1uiYOmQIaYmF7PapRWsOCzpwRRK02uyCjgffIPNM3luDZsk
	Hui5LhOlEADl4r4g4AXF+cFFhrmF5U6KUcfB3sq0jK30YBa7bgm4Dk=
X-Google-Smtp-Source: AGHT+IFmp+9Cbk91wy/S26/TnevCyDFcz+T27bFU4Ss//r84rMuo+tniIyTuEqKycjEZM1O5HWZh/A==
X-Received: by 2002:a05:600c:3144:b0:434:a202:7a0d with SMTP id 5b1f17b1804b1-434dded67cdmr83625685e9.22.1733734880111;
        Mon, 09 Dec 2024 01:01:20 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da119abbsm151793365e9.43.2024.12.09.01.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 01:01:19 -0800 (PST)
Date: Mon, 9 Dec 2024 12:01:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v2] mtdchar: fix integer overflow in read/write ioctls
Message-ID: <Z1ax3K3-zSJExPNV@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The "req.start" and "req.len" variables are u64 values that come from the
user at the start of the function.  We mask away the high 32 bits of
"req.len" so that's capped at U32_MAX but the "req.start" variable can go
up to U64_MAX.

Use check_add_overflow() to fix this bug.

Fixes: 095bb6e44eb1 ("mtdchar: add MEMREAD ioctl")
Fixes: 6420ac0af95d ("mtdchar: prevent unbounded allocation in MEMWRITE ioctl")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: fix the tags.

 drivers/mtd/mtdchar.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index 8dc4f5c493fc..335c702633ff 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -599,6 +599,7 @@ mtdchar_write_ioctl(struct mtd_info *mtd, struct mtd_write_req __user *argp)
 	uint8_t *datbuf = NULL, *oobbuf = NULL;
 	size_t datbuf_len, oobbuf_len;
 	int ret = 0;
+	u64 end;
 
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
@@ -618,7 +619,7 @@ mtdchar_write_ioctl(struct mtd_info *mtd, struct mtd_write_req __user *argp)
 	req.len &= 0xffffffff;
 	req.ooblen &= 0xffffffff;
 
-	if (req.start + req.len > mtd->size)
+	if (check_add_overflow(req.start, req.len, &end) || end > mtd->size)
 		return -EINVAL;
 
 	datbuf_len = min_t(size_t, req.len, mtd->erasesize);
@@ -698,6 +699,7 @@ mtdchar_read_ioctl(struct mtd_info *mtd, struct mtd_read_req __user *argp)
 	size_t datbuf_len, oobbuf_len;
 	size_t orig_len, orig_ooblen;
 	int ret = 0;
+	u64 end;
 
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
@@ -724,7 +726,7 @@ mtdchar_read_ioctl(struct mtd_info *mtd, struct mtd_read_req __user *argp)
 	req.len &= 0xffffffff;
 	req.ooblen &= 0xffffffff;
 
-	if (req.start + req.len > mtd->size) {
+	if (check_add_overflow(req.start, req.len, &end) || end > mtd->size) {
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.45.2


