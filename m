Return-Path: <linux-kernel+bounces-441780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E85769ED40D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4E9B2831E1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1A4202F68;
	Wed, 11 Dec 2024 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="EwLsDtE/"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6171FF1D0
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 17:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939430; cv=none; b=e/3ZxvaNN3/RtkBSAY6tL6OL3vzVuaHlx+SagY9QSEZMyjEu9xTF1dXLi8dZryY6f9b7tDs6Eae11ehRkb7bIkrz742eOeGoHFMFYveuJAyVmCc8c/344I63k0xhrlzhcmF47Mln7ulZbYqSs/8HT2UGtaVYGniahcJlCav6Wgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939430; c=relaxed/simple;
	bh=AZ+JyDm1s6BjQA0Ft/3tIw2C/SX35PYysRFWjGYUPjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ROB7fNtBjAW8/Yq77Ku0MkFMStRLbTYnYhdIjLjHuShiLQivPBsf6ym3lcWEixVo1eTtVJF4iF58iVt0HaShMSMYLIoGHyGgEa2/8cJiFYayaPYs+aCVSNHS/zNKL3y2YhzgnAdN5XA/I8tSrCp7SiFWuK+HI4Rfihs+dr3x2nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=EwLsDtE/; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733939418;
	bh=AZ+JyDm1s6BjQA0Ft/3tIw2C/SX35PYysRFWjGYUPjE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EwLsDtE/QHYr4T4bLQKNW92+7YwDReXtNmbSbgEC4MEHZ7OJN2DydMRg8aotw8lQM
	 pONVt2OL2g3cLDOItoKy0OrnGGTpOfIlSOmYplExs5mNXx6kHSM2oxsj4TobwRs9la
	 PcEsdElP9Vm0mk02zjHwEXgOZaxgJCZr/JfhVXY8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 11 Dec 2024 18:50:17 +0100
Subject: [PATCH 02/12] w1: ds2406: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241211-sysfs-const-bin_attr-w1-v1-2-c4befd2aa7cc@weissschuh.net>
References: <20241211-sysfs-const-bin_attr-w1-v1-0-c4befd2aa7cc@weissschuh.net>
In-Reply-To: <20241211-sysfs-const-bin_attr-w1-v1-0-c4befd2aa7cc@weissschuh.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733939417; l=1845;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=AZ+JyDm1s6BjQA0Ft/3tIw2C/SX35PYysRFWjGYUPjE=;
 b=FBBPLi0Ta1lh8DsAZXAfBELOyn9AVRKt3qqttbkDmz8oaiQkcBszi8VWLXL0b/XHWdPOEC7Me
 xmVv0iuNf03DcPcEU5ayv+VxVU/ZJdmIh23bjcgEz5jvleR9Ugno89c
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/w1/slaves/w1_ds2406.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2406.c b/drivers/w1/slaves/w1_ds2406.c
index 2f5926859b8b3300c31be3f1d59e570984036109..1cae9b243ff87f0013e55c7aa51cd1798741e9ca 100644
--- a/drivers/w1/slaves/w1_ds2406.c
+++ b/drivers/w1/slaves/w1_ds2406.c
@@ -24,7 +24,7 @@
 
 static ssize_t w1_f12_read_state(
 	struct file *filp, struct kobject *kobj,
-	struct bin_attribute *bin_attr,
+	const struct bin_attribute *bin_attr,
 	char *buf, loff_t off, size_t count)
 {
 	u8 w1_buf[6] = {W1_F12_FUNC_READ_STATUS, 7, 0, 0, 0, 0};
@@ -61,7 +61,7 @@ static ssize_t w1_f12_read_state(
 
 static ssize_t w1_f12_write_output(
 	struct file *filp, struct kobject *kobj,
-	struct bin_attribute *bin_attr,
+	const struct bin_attribute *bin_attr,
 	char *buf, loff_t off, size_t count)
 {
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
@@ -95,14 +95,14 @@ static ssize_t w1_f12_write_output(
 }
 
 #define NB_SYSFS_BIN_FILES 2
-static struct bin_attribute w1_f12_sysfs_bin_files[NB_SYSFS_BIN_FILES] = {
+static const struct bin_attribute w1_f12_sysfs_bin_files[NB_SYSFS_BIN_FILES] = {
 	{
 		.attr = {
 			.name = "state",
 			.mode = 0444,
 		},
 		.size = 1,
-		.read = w1_f12_read_state,
+		.read_new = w1_f12_read_state,
 	},
 	{
 		.attr = {
@@ -110,7 +110,7 @@ static struct bin_attribute w1_f12_sysfs_bin_files[NB_SYSFS_BIN_FILES] = {
 			.mode = 0664,
 		},
 		.size = 1,
-		.write = w1_f12_write_output,
+		.write_new = w1_f12_write_output,
 	}
 };
 

-- 
2.47.1


