Return-Path: <linux-kernel+bounces-428235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8F29E0BB1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CF09280C6C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E841DF265;
	Mon,  2 Dec 2024 19:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="tjMwBUH3"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0604A1DED54;
	Mon,  2 Dec 2024 19:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733166253; cv=none; b=g6Su/JO2WYZi1BVDLZ55WisD7hw8SgERnDpsSomlBmTRj8gtJDqy2IYn+zcGjxRNiKzczIAEsT3gjaK682c98CQt5PA+vE22VVrASewuFeAJnpwHSrNY6OVNTmIoXoeNZhhlmAh2IxztRIMLWNToLD4AJh80olfFSSZxdSV6VuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733166253; c=relaxed/simple;
	bh=idHnkK7FE+k9jSjzZJTwT9vCEnNXD5HcnIgvlgtivw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a2OBk9UvmPHqi1mmj1+I5z46pcZ+DEsCVK6lcDmQYkhRmaUl/kTwJwrJz/KT20yKMzVF/OGq1zJovDr1ge+XED76lU3NuwlbURps2bf/UlwW2M1R9yhV/s+0MhNHBUTinFch6UVj6FTASOXlHPCy94W3Fh5qSnbdfMEqGqp3YCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=tjMwBUH3; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733166250;
	bh=idHnkK7FE+k9jSjzZJTwT9vCEnNXD5HcnIgvlgtivw0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tjMwBUH3vsaq40LH5EutpiDvDOJzXADuw0V4FvP8bnl9gY/wCKHr1x934oN+sbS1y
	 lP3+DzkBRZZJXLWKRAAljtbFfqAvmHH/1AZM19n0SjPM1P8oA6dMsmqDVkkDiKHpPi
	 mnR85mUcMJ1GWnL0kHtwkdW8P9BFVEXTdfP9QpPs=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 02 Dec 2024 20:04:10 +0100
Subject: [PATCH 2/3] ACPI: BGRT: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241202-sysfs-const-bin_attr-acpi-v1-2-78f3b38d350d@weissschuh.net>
References: <20241202-sysfs-const-bin_attr-acpi-v1-0-78f3b38d350d@weissschuh.net>
In-Reply-To: <20241202-sysfs-const-bin_attr-acpi-v1-0-78f3b38d350d@weissschuh.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733166249; l=1037;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=idHnkK7FE+k9jSjzZJTwT9vCEnNXD5HcnIgvlgtivw0=;
 b=9PbT6StwmGEjLZCXb7lS1nBuP/j1AjHMbaEmPq5Ompous68ttVqUEcSqih4kTrMQRrd5+SOgK
 dfSAgJfwvucCSsxLRFZOQDv3LNbivjanG2tz41NcYzR+bEglQ6qiiPQ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/acpi/bgrt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/bgrt.c b/drivers/acpi/bgrt.c
index 88837c291a7630416f0ae3854d6d1a733a590961..35ece8e9f15d1d15c224fb6879d48730898fa3df 100644
--- a/drivers/acpi/bgrt.c
+++ b/drivers/acpi/bgrt.c
@@ -40,14 +40,14 @@ static struct attribute *bgrt_attributes[] = {
 	NULL,
 };
 
-static struct bin_attribute *bgrt_bin_attributes[] = {
+static const struct bin_attribute *const bgrt_bin_attributes[] = {
 	&bin_attr_image,
 	NULL,
 };
 
 static const struct attribute_group bgrt_attribute_group = {
 	.attrs = bgrt_attributes,
-	.bin_attrs = bgrt_bin_attributes,
+	.bin_attrs_new = bgrt_bin_attributes,
 };
 
 int __init acpi_parse_bgrt(struct acpi_table_header *table)

-- 
2.47.1


