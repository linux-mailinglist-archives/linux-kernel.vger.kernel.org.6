Return-Path: <linux-kernel+bounces-251711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1881E93088B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 07:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B4EB1C20B1D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 05:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EFEFBFC;
	Sun, 14 Jul 2024 05:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="b2SPFDFL"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03F0DDC9
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 05:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720933568; cv=none; b=uNYRTTHD1IbbnfzDSnG7WI5TMIa7X4fw18h7wjP/haaMc9PK/+myGrjD2F+K9d1ypm/NpySvM6MWqVbZlZ83oXG5kP+QwjGmgzTOWAZui4nK1tXf7x5OZWnChiPRR0M9WqXlvSI2xVP2+N3hsJIFbLTVEbuF/udQDg/kityYEQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720933568; c=relaxed/simple;
	bh=0tga5q/Ajix6V/Fe2NcEAHaE90bgyW4KctueeDpmFFM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GqYAYhkZG0aeOZzh/48UZVgc+k49DXpPX5YRQwFLMrV/I5DWIQPIECqDBTZD4v6YWQRTpKG6DY7DjIUlH8Q2ry61fEEYtDPUDDV54F6pnxh6h+fK0EQ3IPu8f+Tqd3ecIJMP736XRp0HEfVicwOotBUXOpmpzUPF+R6ATtijkII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=b2SPFDFL; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=nRiZSdk0sCkxQR9s9KDjVxr0G7YZIc4+CPU/H0Yzxes=;
	b=b2SPFDFLmeu4l7EzJbFsctFqZj05Z950yAXBiWTw6d3fn1FCw2fTPAkN8N93yE
	o0ESZlCYWhalHT0RdATDQGe8PDhJPFsFW5VKfKzsbyGu+e7I733FqHFKGVa1YWO5
	vVup09knFcsVmRdL+YeTn4a+VESv/LlmmV4gM4LkaGbN4=
Received: from localhost.localdomain (unknown [114.93.107.99])
	by gzga-smtp-mta-g2-3 (Coremail) with SMTP id _____wDXP3+PXJNm8ea_Cg--.38349S2;
	Sun, 14 Jul 2024 13:05:37 +0800 (CST)
From: =?UTF-8?q?=E6=9D=8E=E5=93=B2?= <sensor1010@163.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?=E6=9D=8E=E5=93=B2?= <sensor1010@163.com>
Subject: [PATCH] driver:core:  NO need to determine whether the driver is asynchronous
Date: Sat, 13 Jul 2024 22:05:07 -0700
Message-Id: <20240714050507.2505-1-sensor1010@163.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXP3+PXJNm8ea_Cg--.38349S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GrW7Kry7Ww4xuFyfKw17ZFb_yoWktFX_Cr
	yUWr97ur1rGa1rGFW7K343ZrZY9F4aqFWkXrZ8trWfWryUX3Z5Kwn8AF4qywn5WrW29Fnx
	W34DGrWxZ34I9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRKcTm7UUUUU==
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/1tbiEBUcq2XAl60UJwABsf

When rescanning the device, there is no need to determine
whether the driver is asynchronous.

Signed-off-by: 李哲 <sensor1010@163.com>
---
 drivers/base/dd.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 47351d98f6e1..41fd4b1b4779 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -915,7 +915,7 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
 {
 	struct device_attach_data *data = _data;
 	struct device *dev = data->dev;
-	bool async_allowed;
+	bool async_allowed = false;
 	int ret;
 
 	ret = driver_match_device(drv, dev);
@@ -936,12 +936,14 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
 		return ret;
 	} /* ret > 0 means positive match */
 
-	async_allowed = driver_allows_async_probing(drv);
+	if (data->check_async) {
+		async_allowed = driver_allows_async_probing(drv);
 
-	if (async_allowed)
-		data->have_async = true;
+		if (async_allowed)
+			data->have_async = true;
+	}
 
-	if (data->check_async && async_allowed != data->want_async)
+	if (async_allowed != data->want_async)
 		return 0;
 
 	/*
-- 
2.17.1


