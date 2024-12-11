Return-Path: <linux-kernel+bounces-441778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0129ED40C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15A4C1889010
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBF5201270;
	Wed, 11 Dec 2024 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="WcNevTqg"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6D11FF1DE
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939430; cv=none; b=urrmZv+49L9nUDbFOI8joq2o4/y8As5E03mmc3JKMQj3baaFs5UuzIs5PX+e2BEKKbhDXirwks6XWijLR9gRduS7mLHOTDlacudu9repLNtXyFNCxnu/6gvcsX4yne85MT+KjFHnwC6VqPYpnun1oUSGJLMBl9mJ48cbbVY2sWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939430; c=relaxed/simple;
	bh=hNHDMYdl/asRQqaa03vfbr39VEHOA8MutLP7yYvBd8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hkelLLQHJ5Uj2fC5YRDk7FirhQ1t7yypmoBRPmMllsoa7U5nXEgeWslcP0qC0LjASPekm0VT8xmBgbciolhiIaQnb1FylJ7ZsKI7pyqsZ5ZbCrnvKp2eaLslcOFLeZVa2aLlVNdiL+iVjXGcfjtXJTSkd3DMe3xulgSRmMxURAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=WcNevTqg; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733939418;
	bh=hNHDMYdl/asRQqaa03vfbr39VEHOA8MutLP7yYvBd8A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WcNevTqgfiMJvxCyqwoHugta35qvF4GP+AejVy927WDTLQhoKiV8Ao6GB6wztC6ya
	 qgKiRJdo/zzDRD3Ak9PtaJ2KWHFwqF/EE3mj+fPfjpWb1zVqvswIZxE1vKap2Y6n/m
	 LuUi6o3WpSkz54VnPrNz92yOEFoMUJryLCvsKvW8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 11 Dec 2024 18:50:19 +0100
Subject: [PATCH 04/12] w1: ds2413: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241211-sysfs-const-bin_attr-w1-v1-4-c4befd2aa7cc@weissschuh.net>
References: <20241211-sysfs-const-bin_attr-w1-v1-0-c4befd2aa7cc@weissschuh.net>
In-Reply-To: <20241211-sysfs-const-bin_attr-w1-v1-0-c4befd2aa7cc@weissschuh.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733939418; l=2094;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=hNHDMYdl/asRQqaa03vfbr39VEHOA8MutLP7yYvBd8A=;
 b=+ad/t2rZETTSaJhQQwaQMvF9R4dGdufmoIjV3KDym/QyHeh4YjQJJbhgVKHgzm+D0xjXhqkvK
 6Nfda8Z+FMtC+Qw4EId+p7/l0D1PvctXCi8Z3TMbiu0biK8HS/0+pje
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/w1/slaves/w1_ds2413.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2413.c b/drivers/w1/slaves/w1_ds2413.c
index 7390098064679e2f751814bd5bcd7fa3f362808d..5fa46017ca7cd8ae8ff657adaa9ed0e83f5d0e8b 100644
--- a/drivers/w1/slaves/w1_ds2413.c
+++ b/drivers/w1/slaves/w1_ds2413.c
@@ -25,8 +25,8 @@
 #define W1_F3A_INVALID_PIO_STATE           0xFF
 
 static ssize_t state_read(struct file *filp, struct kobject *kobj,
-			  struct bin_attribute *bin_attr, char *buf, loff_t off,
-			  size_t count)
+			  const struct bin_attribute *bin_attr, char *buf,
+			  loff_t off, size_t count)
 {
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
 	unsigned int retries = W1_F3A_RETRIES;
@@ -78,10 +78,10 @@ static ssize_t state_read(struct file *filp, struct kobject *kobj,
 	return bytes_read;
 }
 
-static BIN_ATTR_RO(state, 1);
+static const BIN_ATTR_RO(state, 1);
 
 static ssize_t output_write(struct file *filp, struct kobject *kobj,
-			    struct bin_attribute *bin_attr, char *buf,
+			    const struct bin_attribute *bin_attr, char *buf,
 			    loff_t off, size_t count)
 {
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
@@ -128,16 +128,16 @@ static ssize_t output_write(struct file *filp, struct kobject *kobj,
 	return bytes_written;
 }
 
-static BIN_ATTR(output, 0664, NULL, output_write, 1);
+static const BIN_ATTR(output, 0664, NULL, output_write, 1);
 
-static struct bin_attribute *w1_f3a_bin_attrs[] = {
+static const struct bin_attribute *const w1_f3a_bin_attrs[] = {
 	&bin_attr_state,
 	&bin_attr_output,
 	NULL,
 };
 
 static const struct attribute_group w1_f3a_group = {
-	.bin_attrs = w1_f3a_bin_attrs,
+	.bin_attrs_new = w1_f3a_bin_attrs,
 };
 
 static const struct attribute_group *w1_f3a_groups[] = {

-- 
2.47.1


