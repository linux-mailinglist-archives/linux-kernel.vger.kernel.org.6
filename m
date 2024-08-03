Return-Path: <linux-kernel+bounces-273365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F30394686A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 08:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D42A7282392
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 06:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DE514E2C4;
	Sat,  3 Aug 2024 06:56:33 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2655923CB
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 06:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722668193; cv=none; b=JP8aKgsZCmj+5/oKWqfssT/3c01zOy7eomLVZCgMfDdv9UIEAGehoXz1vMWiZ3js/x/YpADHkFBZjzUmialFrU0Sz7nCGIJpbd+g+Jc8U0bxAu6BJbe11NLwb1rkM2JrSx+3twMvP9XYFUQ8uy+XuyMKCVJRabbQ7Gr4n7ZfTHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722668193; c=relaxed/simple;
	bh=UtQa+X+rXGzfsDoCKV4TJKsorx4VJ5x2VEs1F3IGRAA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c9MvOzJJG6etEICt3IZMw2axgGfQsawSShudul2zqs2VwTh+EfWbfV9aU+5lB7QFS5dguyncYRaXddo5m9XzpL0aTY4/5TfsPi29dGHLJLVMb39JY+Fl87vC6mZltYcjxOM8BJ9ifDbYVL6yoBEqTdDhBDoj5B798MPtkp4+8yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WbYQJ1HXxzcd5r;
	Sat,  3 Aug 2024 14:56:24 +0800 (CST)
Received: from kwepemd200011.china.huawei.com (unknown [7.221.188.251])
	by mail.maildlp.com (Postfix) with ESMTPS id D02191800A4;
	Sat,  3 Aug 2024 14:56:26 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemd200011.china.huawei.com (7.221.188.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sat, 3 Aug 2024 14:56:26 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <sboyd@kernel.org>, <cuigaosheng1@huawei.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] spmi: pmic-arb: Add check for return value of platform_get_resource_byname
Date: Sat, 3 Aug 2024 14:56:25 +0800
Message-ID: <20240803065625.347933-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200011.china.huawei.com (7.221.188.251)

Add check for the return value of platform_get_resource_byname() and
return the error if it fails to catch the error.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 drivers/spmi/spmi-pmic-arb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 9ba9495fcc4b..5f5f2f0a10b9 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -1808,6 +1808,9 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "core");
+	if (!res)
+		return -EINVAL;
+
 	core = devm_ioremap(dev, res->start, resource_size(res));
 	if (!core)
 		return -ENOMEM;
-- 
2.25.1


