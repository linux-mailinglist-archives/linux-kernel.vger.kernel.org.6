Return-Path: <linux-kernel+bounces-189534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F108CF15D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 22:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C2881C20947
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 20:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BD7128807;
	Sat, 25 May 2024 20:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="AcIOfu3D"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D455D2119
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 20:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716668747; cv=none; b=Bfplp8mnP984MbWM4qDYIA36IkT65aFC0rCSrTwZi9hQq5g2E4kjX+H8dghIYs+76qYkAe832mmRMDeZTHMEeGI3xuNsrqDdh0Z247siRY2ftdQkk0VZvWdyA+t6vDjgNYzDGadWnJ/FY3IOwhdMkdcm4fMixOUH1d7mPVNK5Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716668747; c=relaxed/simple;
	bh=kk70rCY4qeBJ4QSd/JqZcmiRIitXj3ehlAtPbG1aw+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MsN1Frv5khdnJBGCVe2hqOpM7JeU72vXd6Ixd7KjY2BEQKt2MvhCI1lP2rHRiNQR9rk0C3LhY8YPYP8Qqq0HhNWMSBKXf4mjWO73i/UJ5RvOBI09BmDfNy7pUw1+SAREmE9lraOaFXuJpJPXVHt6f7YsJbqADt3pF1utbC0Z400=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=AcIOfu3D; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=L8yXfVyv7RnwhIiGInf9JF68oMRoKkvKLcNTX0uZDoM=; b=AcIOfu3DYYRzy5OR
	a3WVMzVoT4zUlhp9Q2CEzrOJZT/gZj86VfBPy0m39BUt8luaxqmJsFLONbSSFVkR47+JRHtcUZdL7
	rzmQnOjm5j/DxzmQNW2GzxCm3WuSV/5/SSFF3uwOFLAm4DU9v8Fl8hgtqgeMo9QUaeSnS6FZA6dJa
	fcqENOKFiSxqi3tipg7zX3p5qiFwZzTi76DYYgskBfcP76s2uJC8ki3U7GZyLa7ZZfApXoO9TezUS
	SCg+7PuRz6xjbDZ6JNrZPDZZwaPwtmw3JWYThJMFCBbokrZnkdirfqJmaGCMrNogySgNJFPp2GWUQ
	hlIezcxhzzK/AqBASw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sAxxM-002XDI-1Y;
	Sat, 25 May 2024 20:25:33 +0000
From: linux@treblig.org
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] mtd: rawnand: cadence: remove unused struct 'ecc_info'
Date: Sat, 25 May 2024 21:25:29 +0100
Message-ID: <20240525202529.120792-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'ecc_info' has been unused since the original
commit ec4ba01e894d ("mtd: rawnand: Add new Cadence NAND driver to MTD
subsystem").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/mtd/nand/raw/cadence-nand-controller.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/cadence-nand-controller.c b/drivers/mtd/nand/raw/cadence-nand-controller.c
index 04f84d87c657..ff92c17def83 100644
--- a/drivers/mtd/nand/raw/cadence-nand-controller.c
+++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
@@ -531,11 +531,6 @@ struct cdns_nand_chip {
 	u8 cs[] __counted_by(nsels);
 };
 
-struct ecc_info {
-	int (*calc_ecc_bytes)(int step_size, int strength);
-	int max_step_size;
-};
-
 static inline struct
 cdns_nand_chip *to_cdns_nand_chip(struct nand_chip *chip)
 {
-- 
2.45.1


