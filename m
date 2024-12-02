Return-Path: <linux-kernel+bounces-427107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 538109DFCBF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19449281CA7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A77A1FA141;
	Mon,  2 Dec 2024 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lony.xyz header.i=@lony.xyz header.b="MWYA0Tiv"
Received: from mail.lony.xyz (lony.xyz [172.105.251.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BA01F9ECD
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 09:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.251.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733130347; cv=none; b=LyYilklFyfwKmY0mn4l1ErteoEtoCvMeWLVtC8dE3prVqbkw2dsP95ZpvMlh5qJ5ciHP0/iNDdFFdcfz83FykIWdBysHUPqacZqvq4FcaP16mMlL5H02SIA97X/Vd4riv+Dxqhfit0pUNgdcFIXPy2AyTDbenEfgQb1id/DZAf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733130347; c=relaxed/simple;
	bh=kIELQPf0ilImOOICBrG5igCu85Wt8+2BqJaPkbUMfgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ukfV++ceE1qDjxEQccUbgDMoRd9voWDdZOTXCyCZajMj/E9GNruKIrAsbA8BCH/tcO7tfjjceFpHVoxfRyMyYiNOchruVmIAN8IfAFOaoI6SwC9VIBW80ApQtkWTwVMXgrX3UQYNgMyWQRLh4BvCyXTAfys0pn5B+tBdHOmBI9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lony.xyz; spf=pass smtp.mailfrom=lony.xyz; dkim=fail (2048-bit key) header.d=lony.xyz header.i=@lony.xyz header.b=MWYA0Tiv reason="signature verification failed"; arc=none smtp.client-ip=172.105.251.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lony.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lony.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lony.xyz; s=mail;
	t=1733129959; bh=kIELQPf0ilImOOICBrG5igCu85Wt8+2BqJaPkbUMfgU=;
	h=From:To:Cc:Subject:Date:From;
	b=MWYA0TivS7lrWrXGSYlFyLtvwX6tD1PVUiv+AbTNWo3WlN4cXp47guGwYuXmS7NBd
	 sU7cMXkE1nAZyZWNnd1RztXEh5cJtxVkgUOcT0Msj5mNpiaBieYZOkBcVe69jL9B5n
	 TNmAnuDbpzdEvnULC0c1exTe0GOqAobKD2Wa1Na9b/3qov7lpHb5Q8FjqX9W5mr/F+
	 NS4vrYDiHp4DlsChKAVaX6mh+TkY6P3P4AEGFrpygT8MOmfPr7d/CooJp4CXLpnF4M
	 KCpF7G9EEWMRqrM7qAJ+a4yaia5bvfUzRGOO/IsVAVljypkfJwHQUt0Y2xP4Oi04Lb
	 QRm70mTHrVuwg==
From: =?UTF-8?q?Sergio=20Migu=C3=A9ns=20Iglesias?= <sergio@lony.xyz>
To: archjgross@suse.com
Cc: sstabellini@kernel.org,
	oleksandr_tyshchenko@epam.com,
	xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Sergio=20Migu=C3=A9ns=20Iglesias?= <sergio@lony.xyz>,
	Juergen Gross <jgross@suse.com>
Subject: [PATCH] xen: pcpu: remove unnecessary __ref annotation
Date: Mon,  2 Dec 2024 09:59:05 +0100
Message-ID: <20241202085910.5539-1-sergio@lony.xyz>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The __ref annotation has been there since the beginning of time, but no
calls to __init functions exist inside it, and the compilation of the
Xen driver does not output any warnings when removed.

Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: xen-devel@lists.xenproject.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sergio Miguéns Iglesias <sergio@lony.xyz>

---
 drivers/xen/pcpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/pcpu.c b/drivers/xen/pcpu.c
index c63f317e3df3..093ad4a08672 100644
--- a/drivers/xen/pcpu.c
+++ b/drivers/xen/pcpu.c
@@ -105,7 +105,7 @@ static ssize_t online_show(struct device *dev,
 	return sprintf(buf, "%u\n", !!(cpu->flags & XEN_PCPU_FLAGS_ONLINE));
 }
 
-static ssize_t __ref online_store(struct device *dev,
+static ssize_t online_store(struct device *dev,
 				  struct device_attribute *attr,
 				  const char *buf, size_t count)
 {
-- 
2.47.0


