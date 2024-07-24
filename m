Return-Path: <linux-kernel+bounces-261047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4D293B225
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E29C1C210BB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FB11591F1;
	Wed, 24 Jul 2024 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R39da0N5"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FF0158D83
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 13:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721829439; cv=none; b=MxdUZDrqOS07zaE1Xncx/3iUsa1Q3JVm/wZuoCPqzrPXv3FX7rtKqUtne/9RoNbdRndcJr8W2k/Gn7IHgQ5NYSZNKvPm1NkXj0h6Ri5s20j5N6nrvN4Q/odIv0o1VDEQfs5BFG03qMVnzmFeqHZw/gQFzvM5k4k9slRQjrl1LTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721829439; c=relaxed/simple;
	bh=oXGrTAaw01JCoGzeWvaK5cjKrKOWX2t0iGTCMPYSPZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eMioYT8SbW0AAyp3K3UH70kMJNRKuzIid3tqyCXAkD2M9kkUmF4f08b5fkGfb9sfqz9DkpbIWgzXiVOWD4b52XicAYKIv+gRcrc5DlKlU05fLkMbeLW3UwdHsRKlNqWOwNJDS0JqddIa3oz4VvLaPx2Xc6x9XQtO4DE8WGMoic8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R39da0N5; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BC1E220009;
	Wed, 24 Jul 2024 13:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721829430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pkOkY2RhTFXAyxMnE6Ar3wQDTX+RRjdEqBlLTafrI9A=;
	b=R39da0N5OMw0vaR0Fw8Qs2v8lssz28EoU4GL8PDDBgegLUDtdXrfci+hJT6PbkJvwWphjO
	usWWZSx2b0Gcjm5YtOQbe0FcmM/UpPDteWo6ArttFOv0bE17MkPHQ93lA8H6fIEJ47clsA
	gPSxlDWRs3CnPfXX5Ir/933kYr5r1TZ/rcJIGXJKqcPyvu2bJ9bAt1gAWbC7Jh0a8ElvpN
	3i/COQXZrmucNo/ye9pr++1rgF4jCCgSUfHttkIVEtQi+bdObT6/aqNyFJWBzQawdwgWqJ
	XaLH1kKMpgM9+BXOC74kI2iChEXZ9F+k37Mk7+1+ORNMhDi88Hc9l2ugXcYE6g==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 24 Jul 2024 15:57:08 +0200
Subject: [PATCH 1/3] nvmem: specify ->reg_read/reg_write() expected return
 values
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240724-nvmem-rmem-v1-1-d2e3a97349a0@bootlin.com>
References: <20240724-nvmem-rmem-v1-0-d2e3a97349a0@bootlin.com>
In-Reply-To: <20240724-nvmem-rmem-v1-0-d2e3a97349a0@bootlin.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.0
X-GND-Sasl: theo.lebrun@bootlin.com

Both ->reg_read() and ->reg_write() return values are not easy to
deduce. Such type of callbacks could return the number of bytes in the
success case, which would be translated to errors in the nvmem core.

Such mistake has been done in drivers/nvmem/rmem.c:
commit 28b008751aa2 ("nvmem: rmem: Fix return value of rmem_read()").

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 include/linux/nvmem-provider.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 3ebeaa0ded00..515676ebe598 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -92,8 +92,8 @@ struct nvmem_cell_info {
  * @read_only:	Device is read-only.
  * @root_only:	Device is accessibly to root only.
  * @of_node:	If given, this will be used instead of the parent's of_node.
- * @reg_read:	Callback to read data.
- * @reg_write:	Callback to write data.
+ * @reg_read:	Callback to read data; return zero if successful.
+ * @reg_write:	Callback to write data; return zero if successful.
  * @size:	Device size.
  * @word_size:	Minimum read/write access granularity.
  * @stride:	Minimum read/write access stride.

-- 
2.45.2


