Return-Path: <linux-kernel+bounces-243554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEA292979F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 13:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C95DF281739
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 11:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C7B1BF40;
	Sun,  7 Jul 2024 11:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ArYpnNnd"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F891BF3A
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720351729; cv=none; b=PxdcFR38l0apfLqb155Z575WufD+42XLLhbxfgQGJrtNlbPv1qhvT8Pgx+BC6ZUgGiZmKTgC7ByMyBLEWR9auhPQnCLtLgOwlq6sXHDCqliesWeVDHwx6jNGL19464AmKlgDlJpdyMBxS2L4Jp081XiGyA/EYKNM5KG2lAIqVhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720351729; c=relaxed/simple;
	bh=viuQQvnl/HEyojFbTu89HVjIV3n8YtrYoWR0Fl0RIa8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=jvV3Tt86+7Fvj/5Rdd0ktk/a7Fm6TmIjgcIjdHom2rryZMnPfn4B6MRts5wtrqxBru8z8y6JRIwPJknfzdzbEqBmwedPF9ljZKC6B6EgudjuPVvhfHH3u5RmK4uYWTaMXiFy+EePHwcY8dT+9KHK3nTuXAbyUQVbO8lA775l6mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ArYpnNnd; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=tmD7p373BjyCkvXoT5
	52zWEwEpPq5fuGGKFor+qCn8Y=; b=ArYpnNndommHx49dfJ8zSaLWrj15vs+ve8
	HJAqnDmkQutctLfaIv5mY4GvgB4/jICljfpsafYt6dJgxKrwHiPjrjUex5psP6vt
	HFCeilGOlAHCM3caPzTFzN8jp35HnaiM6EeOBjig21Sz889czo5shiirmdONwAJP
	EkTyIb7wM=
Received: from localhost.localdomain (unknown [114.92.56.131])
	by gzga-smtp-mta-g3-3 (Coremail) with SMTP id _____wD3n0C4e4pmtMjXBw--.31032S2;
	Sun, 07 Jul 2024 19:28:04 +0800 (CST)
From: Lizhe <sensor1010@163.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Lizhe <sensor1010@163.com>
Subject: [PATCH v1] driver:core: no need to invert the return value of the call_driver_probe()
Date: Sun,  7 Jul 2024 04:27:38 -0700
Message-Id: <20240707112738.3380-1-sensor1010@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3n0C4e4pmtMjXBw--.31032S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr13tw4DCF4DWF13AF45Awb_yoWfJFg_Ca
	17CFyxX34I9an7ua48ZwsxZrZ29FWxWr1kur4Fgwn3JFyUXa409F1DurnxJr45WrZ7uF4D
	Cry2gryxu3WakjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRKGQ67UUUUU==
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/1tbiSB8Vq2XAmJL2-wABsO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

If drv->probe() or drv->bus->probe() returns EPROBE_DEFER,
then there is no need to invert the sign. Similarly,
if it returns -EPROBE_DEFER, no sign inversion is needed either

In the probe function (either bus->probe() or drv->probe()),
there is no return value of EPROBE_DEFER.

Signed-off-by: Lizhe <sensor1010@163.com>
---
 drivers/base/dd.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 83d352394fdf..cbf7fe6aa8e0 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -664,11 +664,6 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 		if (link_ret == -EAGAIN)
 			ret = -EPROBE_DEFER;
 
-		/*
-		 * Return probe errors as positive values so that the callers
-		 * can distinguish them from other errors.
-		 */
-		ret = -ret;
 		goto probe_failed;
 	}
 
-- 
2.17.1


