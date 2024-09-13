Return-Path: <linux-kernel+bounces-327761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D0C977AD6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 10:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09FA9287F1E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2461D67BA;
	Fri, 13 Sep 2024 08:17:48 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DC71BC088;
	Fri, 13 Sep 2024 08:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.237.72.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726215467; cv=none; b=AK5I+We2Ka/NzpTxwVVnYB9h8bDobbEdKOicf+NL3/5H7KwcMQpOARyX3NWBkNRBb2tRgwUgZfH3ogJw3rbTynmcEGQj9jN8zFyyl/FOzGf6zEEMyZtSAEjugjPHqalMKicx0sYhDEZw6gdP2X6B/osM43mN9htMHlv+AivYkJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726215467; c=relaxed/simple;
	bh=KW9w3UJaa0DnPt1DISJMSR74Qqx+KldRopbU7b759bY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LoYFF3/pAy72HPeeRhUkHKGMHa3tMVYpzy6RUrasI8MfF6ACTj4RDCv7t6AikByv7lp9J6o+2W8m0dl18WxpXcyNT/LIPZ4p3OqZnPknSnFDDeJDAIbG4q+GLGqWKarA8spXMGPjLfwXGrd/ES5/k7XpNIGpI3k6hVuJqCFLTUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=52.237.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app1 (Coremail) with SMTP id HgEQrABXXzvf9ONmgX4DBg--.33927S2;
	Fri, 13 Sep 2024 16:16:31 +0800 (CST)
Received: from Chengziqiu-Lab-Desktop.. (unknown [10.12.190.56])
	by gateway (Coremail) with SMTP id _____wDXKPDb9ONmb6IiAA--.287S2;
	Fri, 13 Sep 2024 16:16:30 +0800 (CST)
From: Cheng Ziqiu <chengziqiu@hust.edu.cn>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Dongliang Mu <dzm91@hust.edu.cn>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hust-os-kernel-patches@googlegroups.com,
	Cheng Ziqiu <chengziqiu@hust.edu.cn>
Subject: [PATCH] scripts: use ':Original:' tag to locate the origin file
Date: Fri, 13 Sep 2024 16:16:26 +0800
Message-Id: <20240913081626.4174631-1-chengziqiu@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HgEQrABXXzvf9ONmgX4DBg--.33927S2
Authentication-Results: app1; spf=neutral smtp.mail=chengziqiu@hust.ed
	u.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1rXF4Dtw47Cry8Gr1rWFg_yoW8GFy8pa
	yrCa18X3srG34UXwn3KFWrZrWfCF4rAF48KFW2qwn8AFn8twsYqFW29F1Fga18XFyfXFy2
	kF4FyasrGF17ZrJanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmFb7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8C
	rVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxVWxJVW8Jr1lYx0E74AGY7Cv6c
	x26r4fZr1UJr1lYx0Ec7CjxVAajcxG14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw2
	8IcVCjz48v1sIEY20_GFW3Jr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
	xVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1UUUUUUUUU==
X-CM-SenderInfo: bpsqjjaxrxkmo6kx23oohg3hdfq/

Simply substitute path may cause file finding failed
if we have a different dir map for translation. The
':Original:' tag could be used to locate the origin
file if both the tag and file exist.

Signed-off-by: Cheng Ziqiu <chengziqiu@hust.edu.cn>
---
 scripts/checktransupdate.py | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/scripts/checktransupdate.py b/scripts/checktransupdate.py
index 578c3fecfdfd..f28176691b03 100755
--- a/scripts/checktransupdate.py
+++ b/scripts/checktransupdate.py
@@ -25,6 +25,7 @@ commit 42fb9cfd5b18 ("Documentation: dev-tools: Add link to RV docs")
 
 import os
 import time
+import re
 import logging
 from argparse import ArgumentParser, ArgumentTypeError, BooleanOptionalAction
 from datetime import datetime
@@ -32,6 +33,18 @@ from datetime import datetime
 
 def get_origin_path(file_path):
     """Get the origin path from the translation path"""
+    with open(file_path, "r") as f:
+        content = f.read()
+    # find the origin path in the content
+    match = re.search(r":Original:\s*(?::ref:`|:doc:`)?([^\s`]+)", content)
+    if match:
+        f = match.group(1)
+        if os.path.exists(f):
+            logging.debug("Origin tag found: %s", f)
+            return f
+        else:
+            logging.warning("Origin tag found but file not exists: %s", f)
+
     paths = file_path.split("/")
     tidx = paths.index("translations")
     opaths = paths[:tidx]
-- 
2.34.1


