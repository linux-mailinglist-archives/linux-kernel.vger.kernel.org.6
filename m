Return-Path: <linux-kernel+bounces-315761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2439296C69C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84096B21BB1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455B91E2037;
	Wed,  4 Sep 2024 18:42:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4541E200F
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 18:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725475322; cv=none; b=McV4/hX9DEzcIMQp8j+r5VE4yUC1mBihnOdGordIDObYM6eBQ9Bbv5FDlf9TvuEk4jv3rvKTCBqXrxc6QfeTxggn46pjoAhXqZJ7qX9oIXY6XisL+VWDUM9G3fgT/TObJU1OiUPrZhznElxvN38t/addO3wLDXelU7+sEMsFqwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725475322; c=relaxed/simple;
	bh=xnhdZQnpzLuzEIJai/R+ss30q5xJyPeg2JOkpvjY0eM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mO6LZq6OpWVYOqnafa2Ig7dYvPfvXy6N/ESjYsrhwlonL7ei5KLEmHyiIYGU5Ae0IWqQktYBq18HBJBwbADFwqo1BE5DSdXbV8UvLG+oT7sExHCVIggGtxMFuPPN+g+t33NkUslbkCpNsJrcXTF9I0QbKn5+87g2wbFZoLlJ6Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C0001063;
	Wed,  4 Sep 2024 11:42:27 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 299F63F73F;
	Wed,  4 Sep 2024 11:42:00 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] perf/arm-cmn: Improve format attr printing
Date: Wed,  4 Sep 2024 19:41:55 +0100
Message-Id: <50459f2d48fc62310a566863dbf8a7c14361d363.1725474584.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <00634da33c21269a00844140afc7cc3a2ac1eb4d.1725474584.git.robin.murphy@arm.com>
References: <00634da33c21269a00844140afc7cc3a2ac1eb4d.1725474584.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Take full advantage of our formats being stored in bitfield form, and
make the printing even more robust and simple by letting printk do all
the hard work of formatting bitlists.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-cmn.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 62d4782da7e4..397a46410f7c 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -1280,15 +1280,11 @@ static ssize_t arm_cmn_format_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct arm_cmn_format_attr *fmt = container_of(attr, typeof(*fmt), attr);
-	int lo = __ffs(fmt->field), hi = __fls(fmt->field);
-
-	if (lo == hi)
-		return sysfs_emit(buf, "config:%d\n", lo);
 
 	if (!fmt->config)
-		return sysfs_emit(buf, "config:%d-%d\n", lo, hi);
+		return sysfs_emit(buf, "config:%*pbl\n", 64, &fmt->field);
 
-	return sysfs_emit(buf, "config%d:%d-%d\n", fmt->config, lo, hi);
+	return sysfs_emit(buf, "config%d:%*pbl\n", fmt->config, 64, &fmt->field);
 }
 
 #define _CMN_FORMAT_ATTR(_name, _cfg, _fld)				\
-- 
2.39.2.101.g768bb238c484.dirty


