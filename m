Return-Path: <linux-kernel+bounces-216623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAAC90A258
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 04:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB1431F220AE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 02:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8F317B4F0;
	Mon, 17 Jun 2024 02:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o4WMaMkL"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5994161310
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 02:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718590351; cv=none; b=kryNdgeKcEbiGdm/sIK6LFnBM4vU/m+pI4v323pX1NnKJE1EDkQsDIpzidiDH1ZK29RD3LBX95a1XGdibhQhugnEhp1jkbzCwfaQS4A+L/EH9nDfkGR20PaDxtkEF+zRRxh02s5Cj37grepQg8rxn86MXonNlUyCM/3hnzUjhtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718590351; c=relaxed/simple;
	bh=+usWI0nPBVcSZ+VJqjI6qxc97XtNV3HNm04/jAf8hVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o32DnnLp/L74W9nqSZozJZz+0M1VQRKsoXNf6S9LbVrdjaVuwU+X4U44giQ20x1Xc7mDlJtC3sHSnu56Y8k/ppMvXG2I67itCV5cR1/iMzqEeIYss3vWjFTktjUyO/q7LQZmykpyGKLscdCGJQX2m5iTmsG1pWjpQuPwXor1sEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o4WMaMkL; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: markus.elfring@web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718590344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M8Qv5NrmpUkXbkH01JqmIrt+CGtlE3ZyafHTyGTEsUw=;
	b=o4WMaMkL0QujctNqCm7RhryIdoRkf0PTp9GQGVMPAhXSCijgB7iL0Y7gYHo3Kms3AFAfDi
	eaw1Hp1SElrC4zXpNQPyvz6BshqW8odKK+UhcApS0mnUI4SFwsBb0CHWaIlsqf65Q80k2v
	SKGNGWCALfJESUs7QLj/dHLeFJSgyRQ=
X-Envelope-To: broonie@kernel.org
X-Envelope-To: perex@perex.cz
X-Envelope-To: tiwai@suse.com
X-Envelope-To: shenghao-ding@ti.com
X-Envelope-To: colin.i.king@gmail.com
X-Envelope-To: gehao618@163.com
X-Envelope-To: linux-sound@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: gehao@kylinos.cn
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
To: Markus.Elfring@web.de,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: shenghao-ding@ti.com,
	colin.i.king@gmail.com,
	gehao618@163.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH v2] ASoc: PCM6240: Return directly after a failed devm_kzalloc() in pcmdevice_i2c_probe()
Date: Mon, 17 Jun 2024 10:09:54 +0800
Message-Id: <20240617020954.17252-1-hao.ge@linux.dev>
In-Reply-To: <82283abf-10b1-4095-a93f-112ba8aca483@web.de>
References: <82283abf-10b1-4095-a93f-112ba8aca483@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

The value “-ENOMEM” was assigned to the local variable “ret”
in one if branch after a devm_kzalloc() call failed at the beginning.
This error code will trigger then a pcmdevice_remove() call with a passed
null pointer so that an undesirable dereference will be performed.
Thus return the appropriate error code directly.

Fixes: 1324eafd37aa ("ASoc: PCM6240: Create PCM6240 Family driver code")
Signed-off-by: Hao Ge <gehao@kylinos.cn>

---
v2:
- adjust title and commit message
- omit curly brackets
---
 sound/soc/codecs/pcm6240.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/pcm6240.c b/sound/soc/codecs/pcm6240.c
index 86e126783a1d..8f7057e689fb 100644
--- a/sound/soc/codecs/pcm6240.c
+++ b/sound/soc/codecs/pcm6240.c
@@ -2087,10 +2087,8 @@ static int pcmdevice_i2c_probe(struct i2c_client *i2c)
 #endif
 
 	pcm_dev = devm_kzalloc(&i2c->dev, sizeof(*pcm_dev), GFP_KERNEL);
-	if (!pcm_dev) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!pcm_dev)
+		return -ENOMEM;
 
 	pcm_dev->chip_id = (id != NULL) ? id->driver_data : 0;
 
-- 
2.25.1


