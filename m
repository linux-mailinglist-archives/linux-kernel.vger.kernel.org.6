Return-Path: <linux-kernel+bounces-342118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA4A988AC6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 21:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17076B21D5F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 19:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AFE189F5C;
	Fri, 27 Sep 2024 19:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="EXJyxVaa"
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BF1136354
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 19:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727465676; cv=none; b=aCppGbHGQ+yf09HK4KFEA0hjpEqosBhuq/DqnpIyLrVXnryuOdOvIuguyTHEpBmQ8rFtTiwVnETEGbIIAUoVpz7GmQ9hptYVdnC8It/dWtUyD/7w24lEtIGVSc/NnR/uh58RD6nSvlFuYWklfV7ps9UoclTbbgoSfjVdEx+d3SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727465676; c=relaxed/simple;
	bh=69YOQWzSC2bqH1BrOBpaojGYM3HqDuEomSdv5BxvE4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=I4HpljTR9yZAMq/bk6upIiILlHeQPgqCb/cvbCzddJyntpfGEDJkZ/D8YvSV755szxKzJejQIqZVUj6VEwuNJY1JKOZ9RmXhQlLH3mP/8o5F3fXGyROVFz6YN1y+9LBuzdqvmC0h+k41pLZumwd2gb9ZnEjaE+62+qOwXApCr3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=EXJyxVaa; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id E06C61C2493
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 22:34:31 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:content-type:content-type:mime-version
	:x-mailer:message-id:date:date:subject:subject:to:from:from; s=
	dkim; t=1727465671; x=1728329672; bh=69YOQWzSC2bqH1BrOBpaojGYM3H
	qDuEomSdv5BxvE4Q=; b=EXJyxVaa8hT+LSevKsqFES6UR3Iul28RR9B58KsWRQe
	Y8V/+gx60+uPo991G9l+6CO+dofWm498GxEn4AhHqwnSclqlHn0HZ9P09Hj8vJ27
	LbXxlOvjimTxrNFmDxCzUzcZEVZjaFFfwIoe5RBEFMudFaTDJWaO+9F1t/UnzULo
	=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QPUlJViAIa3m for <linux-kernel@vger.kernel.org>;
	Fri, 27 Sep 2024 22:34:31 +0300 (MSK)
Received: from localhost.localdomain (mail.dev-ai-melanoma.ru [185.130.227.204])
	by mail.nppct.ru (Postfix) with ESMTPSA id EA7D81C0604;
	Fri, 27 Sep 2024 22:34:29 +0300 (MSK)
From: Andrey Shumilin <shum.sdl@nppct.ru>
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: Andrey Shumilin <shum.sdl@nppct.ru>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	khoroshilov@ispras.ru,
	ykarpov@ispras.ru,
	vmerzlyakov@ispras.ru,
	vefanov@ispras.ru
Subject: [PATCH 2/2] sis_main: Fix strbuf array overflow
Date: Fri, 27 Sep 2024 22:34:24 +0300
Message-Id: <20240927193424.3934247-1-shum.sdl@nppct.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The values of the variables xres and yres are placed in strbuf.
These variables are obtained from strbuf1.
The strbuf1 array contains digit characters
and a space if the array contains non-digit characters.
Then, when executing sprintf(strbuf, "%ux%ux8", xres, yres);
more than 16 bytes will be written to strbuf.
It is suggested to increase the size of the strbuf array to 24.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Andrey Shumilin <shum.sdl@nppct.ru>
---
 drivers/video/fbdev/sis/sis_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sis/sis_main.c b/drivers/video/fbdev/sis/sis_main.c
index 03c736f6f3d0..e907fde96ff4 100644
--- a/drivers/video/fbdev/sis/sis_main.c
+++ b/drivers/video/fbdev/sis/sis_main.c
@@ -183,7 +183,7 @@ static void sisfb_search_mode(char *name, bool quiet)
 {
 	unsigned int j = 0, xres = 0, yres = 0, depth = 0, rate = 0;
 	int i = 0;
-	char strbuf[16], strbuf1[20];
+	char strbuf[24], strbuf1[20];
 	char *nameptr = name;
 
 	/* We don't know the hardware specs yet and there is no ivideo */
-- 
2.30.2


