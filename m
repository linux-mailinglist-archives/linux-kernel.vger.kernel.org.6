Return-Path: <linux-kernel+bounces-548604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA209A546DB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8F387A8CE2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E77520B203;
	Thu,  6 Mar 2025 09:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RVKPPdTe"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A6C20AF72
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741254533; cv=none; b=MIP4ZdRbXrPxUWUmtD7picCXFpqDDeNgpgypVnzmyGZFgsztqty+YEBuON9zXPos40ogubCzO2j+OfhCggZq4sESHZ1bGCrXoBEE/GZUwkH6awiXAPwAr8qTT5cz378gNi2db3Q1FG9DVxkN+43ghLn61W7Op1kKPeYgI27oz+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741254533; c=relaxed/simple;
	bh=GQV4SLZl8Frp7cjX5HDJ6Yk9MZtTIVwea83AAO11NUo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZzKBq8M6ZYXcjRhKzQzsaEF8JsSW8u8KPoafI8PPDHa1zmH3AHcP6Q+gQxwYX8jc2Y0TofwRmplNm5gHXtvkj6WX0bBa0FIIKF51L7kmv6L74ARAGDfGrjQhlsojYr5dHgeGyNeeYJ2vA2SOaUGb0miNnHLaQOjlqtOz5KPP9vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RVKPPdTe; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43bc48ff815so3000895e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 01:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741254530; x=1741859330; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+lPMtdDnyS5p5XQ8x2O16sVZzRQVpy61Wi4CdXiyF5Y=;
        b=RVKPPdTeVJ//vZ+jgqsvVqscac7qoE5jpomx0DVMMTaXKAr8iBvrh3TeIvIZVPtpso
         uh1F26tI+nLQlGBVj5L1RNX+Q9FH4X/5gond4F4m5pe8KfoMB6zkAXwLfJTQPO11zB5h
         j+VSnmLpGQPvxDpFJ2blSqcBuuVDfcbbYJTlUb0THON6pPZWissmG/7tSisU8mqvOEwM
         Ir61KewCTjXCyUobq6IE8BreCLpkv3Wdoyho1uPTe01l0AjbuDmpluKtDomDIP7yd4K7
         tqasNIB+WadzSLZFTWlksyF+9n41FXYg2ZtZYRa0xhQGhzlOWaVUtLxkFCwz0sSmSv33
         EZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741254530; x=1741859330;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+lPMtdDnyS5p5XQ8x2O16sVZzRQVpy61Wi4CdXiyF5Y=;
        b=YCi3T72cRXeezTekTkBMlxZ2opp2WN2qHN5pgb3+YbJBLTz8pmk30duXImL2Hu4hqj
         z6yLi5bqYvxfTdPq1w1y9r1ixFEVh8PVXhclBUdnk32AbZ+xnm50ZmTB+Wpbvk/QxBkH
         cbQ9rnGrN5wih/kl4f2umT8/GQDBoklAC5vaH/1KH+h/mg2Gea2os4jwc5bs/sOJmKwm
         tyP2CmCIgzrI/CRTXeZmjlo6d9zdNw11lJP96zcq5DCMNvKqbQkWLvqhUqt3w5uQNNyL
         k5PLQge1gV+v78BG/egYM5uXKGxl3OhszrwKtavhdDRT4ocyxVkld4wvYcgKbP9tLLJt
         qjQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3kFK80JY2xwr4w3rlfAczDpqDyts5ffIUmLESBAWplEE5sCaaOKDG7+wbaolAAQLP1EoMPN//sb6E8wA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyokOi0ByBfJK0EQBn7F6sWs/w4wJXw1R+tVEjEptEoVDznIX65
	D5uliFX70OpkO4WjyG/wezyiMmqsath6/hzdKouO6pfucMXAgwWEYHIMZIcrp/eBBeXmQWyvmSN
	Y
X-Gm-Gg: ASbGncs0JTr1k3auBfzkmUd3oCV+2PMjDCq8kMvCfREnn3/XEOG71l94JMcX7Zb6Tb/
	9jPIIrH2kWstJ+h9rKt2/DPk3PBrdKDNXlwrKrdK014KCChRc6+ORvpM5nSB8Z272un677lJ9K+
	OIFWbnWy16W0ZR8e8RX9x5NVCTcci9iwFCRPkVLlbFukWXlvBNZHcvqX6jMz437mIY5yEiu7QF+
	BFzAh0rX0yquIIfc79rWcmYgyFGpbl2m38Baw9A3DAGC4g9GHSFE3MJPDM68NzVj9iByOF5obOZ
	WiTnVGeqUNC2IIF0g1FT5ZRZ5zCxEhOe8WEM8X7bit0OtBOJNg==
X-Google-Smtp-Source: AGHT+IGgc/VG1JdHkP0LmXTSR3rq/s9jvn1fCwWnouSLK08mf+fqpf+SWLB/GA3APvlWee4dX0nBzA==
X-Received: by 2002:a7b:c053:0:b0:43b:c592:7e16 with SMTP id 5b1f17b1804b1-43bdb368dafmr20653825e9.3.1741254529757;
        Thu, 06 Mar 2025 01:48:49 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bdd831719sm15497185e9.0.2025.03.06.01.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 01:48:49 -0800 (PST)
Date: Thu, 6 Mar 2025 12:48:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Disseldorp <ddiss@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] initramfs_test: Fix NULL vs IS_ERR() bug in
 initramfs_test_data()
Message-ID: <a4ed49c0-e92f-4fa6-b1b2-32749f551724@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The filp_open() function returns error pointers.  It never returns
NULL pointers.  Update the check to match.

Fixes: b6736cfccb58 ("initramfs_test: kunit tests for initramfs unpacking")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 init/initramfs_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/initramfs_test.c b/init/initramfs_test.c
index 6231fe012583..7d14f70beabc 100644
--- a/init/initramfs_test.c
+++ b/init/initramfs_test.c
@@ -222,7 +222,7 @@ static void __init initramfs_test_data(struct kunit *test)
 	KUNIT_EXPECT_NULL(test, err);
 
 	file = filp_open(c[0].fname, O_RDONLY, 0);
-	if (!file) {
+	if (IS_ERR(file)) {
 		KUNIT_FAIL(test, "open failed");
 		goto out;
 	}
-- 
2.47.2


