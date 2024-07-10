Return-Path: <linux-kernel+bounces-247728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C0192D3B7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C35D287958
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE14D194A42;
	Wed, 10 Jul 2024 14:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ohmtt9ks"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2311F1946C8
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 14:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720620106; cv=none; b=dVoP84/9hjA6MThbg4flcmNgYNiEzA2Pwf2Ni/QT6rqUVMQGG/ugyYTxhw1Bw0q25RtE/IAVK8eOF0t6oh1r5HmN/T2NBO7RSVS4iyPmWiB/87WfRo1oxSMsSIKQET8EQE+7HWDzfS2vvb5x5QEuIN0mxNJn6hT0/ZMs3Ecifa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720620106; c=relaxed/simple;
	bh=6YBxGUqzUkosXEuudIAjOYOpZ3JddHdhfEKCBfxlj18=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=K3M1Vz8NhNNHIx9fzQpYnqn/QnyHNsvM3EcV4VQiy8IBWjeBEVFmhyCtJXUnn3H91G3pV7sYe5a7A/Z/v/CLJ+ghZFZBOKwB3Go512TfQoG3roN6b1/1kEJQJ/4BLgK36YMtu0kA8Om65cJG9bFQHOC/lrtJEtBp37u89iP7vss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ohmtt9ks; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=7isddE9S7WZLEiUgbZ1fKxvJB1ZBtoJq/q76qOrytWc=;
	b=Ohmtt9ksGPq8I0yEmf/4Ee9Al5Eu8O/7NvG/0Hl6QHICC129FNrTQWrmYUEclR
	iQD09Z5T7OdvDf3/8vdzSEuaRhchN3hCx02JEZRwlpjqjyUZnpzwewsVP9cEmrl7
	XatlH1cOqaLVixAPhMH34Ha02CWZ0Jve5fQ/OR6Koi/tY=
Received: from localhost.localdomain (unknown [114.92.56.131])
	by gzga-smtp-mta-g2-2 (Coremail) with SMTP id _____wDX3_EXlI5mEf7XAw--.49360S2;
	Wed, 10 Jul 2024 22:01:06 +0800 (CST)
From: =?UTF-8?q?=E6=9D=8E=E5=93=B2?= <sensor1010@163.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?=E6=9D=8E=E5=93=B2?= <sensor1010@163.com>
Subject: [PATCH v4] driver:core: no need to invert the return value of the call_driver_probe()
Date: Wed, 10 Jul 2024 07:00:41 -0700
Message-Id: <20240710140041.4066-1-sensor1010@163.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX3_EXlI5mEf7XAw--.49360S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFWxtw18Kw1rGFy8CrWDCFg_yoW8XrykpF
	s8AFWYvFn8u3yv9FWUGry0yFyFy3WxCrW09r18G34S9w17Ary5G3y7KrWYqr18ZrWv9Fyr
	tF43ZrWrCFW7AF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piaFAdUUUUU=
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/1tbiSAcYq2XAmMpaiAAAsZ

In the probe function (either drv->bus->probe() or drv->probe()),
there is no return value of EPROBE_DEFER. the error return from probe
should be -EPROBE_DEFER, hence no negation of call_driver_probe()'s
return is needed, nor should there be an EPROBE_DEFER check in
driver_probe_device()

Signed-off-by: 李哲 <sensor1010@163.com>

---
v4:
	Change the pinyin "Lizhe" to the Chinese name 李哲
v3:
	Modify commit message and versions go below the ---
v2:
	Delete the judgment with the return value of EPROBEDEFER
	from the _driver_probe.device()
v1:
	Add the judgment with the return value of EPROBEDEFER
	from the _driver_probe.device()
---
 drivers/base/dd.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 83d352394fdf..d047919d1f5e 100644
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
 
@@ -826,7 +821,7 @@ static int driver_probe_device(struct device_driver *drv, struct device *dev)
 
 	atomic_inc(&probe_count);
 	ret = __driver_probe_device(drv, dev);
-	if (ret == -EPROBE_DEFER || ret == EPROBE_DEFER) {
+	if (ret == -EPROBE_DEFER) {
 		driver_deferred_probe_add(dev);
 
 		/*
-- 
2.17.1


