Return-Path: <linux-kernel+bounces-421809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D55FF9D906F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 03:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B690BB22A25
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 02:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE3C1F5FA;
	Tue, 26 Nov 2024 02:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iMed3cNY"
Received: from mail-qt1-f226.google.com (mail-qt1-f226.google.com [209.85.160.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA13CA64
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 02:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732588771; cv=none; b=BlpCKq41k3fpFhlvyvd5Jw/9EdF3SnI6d3AIQWEd/621feq5k10py89pR1j0qmT1EvhLGJhf6FX0qK0ItoA8gaEHibK5S0VczUCtGyYHb8KtRkyYkglIEg7yh/PE1a2zmCiPBCqPwvCfxBjqL1K5B7H3F4NViJ3/a1GRupnfb20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732588771; c=relaxed/simple;
	bh=mk+7rqEhFbf9zcqMlRP4+8yZ8eOxCH+MXlLJWr2tX00=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Q1aMpbM3bhc2sDr86PF/Eq2mqa9VXa1r7MJZXOj2QYYMpoacAa7iBBFCDlYubqE4TTekJTOymgt2JIbjWgWasnfzetgPFsvkvME8J6xKFDv90bcJT0AZOLz9y0UEdxiZ3xmd4WDmH2UZxUFjNKBAdGUExZbbQsybh01Losq/AF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iMed3cNY; arc=none smtp.client-ip=209.85.160.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f226.google.com with SMTP id d75a77b69052e-466a799da4dso346971cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 18:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1732588769; x=1733193569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/kpLPflpD9e8Ydlco2Zh2a8FjV3s0t7Hy2jkS9iRg9c=;
        b=iMed3cNY5COmZTy473PP/6VVq55QE7YQoALxm2uqNjjOwD4EPx0Ypvaw2ow/3kr/Nn
         A8UPGQ7kKAk9WGmP6/NPXSA9oCNt3Yi1eWOMfzWJhz49qt5hBM2b9y164Du/yU46Q7ZS
         zr4nJo6OM4j+3r6O2rwMTTMizkCQRPesO4cCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732588769; x=1733193569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/kpLPflpD9e8Ydlco2Zh2a8FjV3s0t7Hy2jkS9iRg9c=;
        b=Utj3O9DlC1LyD8m2bAASaoyxwORcZN1hl+O3UARyJscYOTU5P+zobcjfPVUG4kFuaF
         mE+0YxlYcUebaAU7P0xF1JxopU2WcJMuqWOD1Efc7A8mMbklL7Fx15ACJJwMiHkqwdn1
         0cHfCLxyuxGuFH/TK1DuWu2sTXXW+sc3o8etsXXsE7Mvundhv2KbBsTblW31dBsu6OVA
         XdunCQ/Jc/SpGAY2IkcTCoZZQjkCRvQXjVKjO8yXwfKV27NHKi1nQR076jNOojCeH2Fc
         Jb36tiYVRIkIZRXoky0vMEHYa3UDE2YDk2ND9LJWFb27tOvw21XNagsLpxAyYokKKxjD
         q8oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfYB1+LHfhU62Ho1mvAinCTy7OHP35FBHdH4G4VC4rW1doRvp3mNqRP9AkMMbS+1btXKRjBx8uBbMs5f8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUtJ/dFGF20ZRF2m+yOT/e19IF5xCKtPGxP87GurN+HAVCmeUB
	bVeAEUBVqe5ZWPjJFKxAhKXbG8BsV3id5IlG9PgQ82SOXY8M+OHm7vzPyAxtMGVPvaTyNh5ONeV
	4eccMx+jzDrOKogMnK8avDxCrzkiarg==
X-Gm-Gg: ASbGnctb2rSCeqEXAjnT8kvwqCYqDUY+TZQjqjb7kPPJhto0UdGhAUOGWZfTgosrTM8
	eCSEJGMA4Unj775VLRqXWvECePSYGOy0XEjCShPrFhRZTzAnUy/qIQ65HmazU9scbIaPhENYJZz
	St2tmQgmYT88sctTE138T4f4rtWjSmrrgJgsSCetp7zrsQRU3wrIAQIoIkW0CsAauKMpjuOL07p
	nDvrGDukrrqZjb6rEZxQfVpPcnX9B+g51jIXuwFzSgGOpzWJFrw40rRW7/uzXBpnM0c4WiNiVj5
	Y5pmbvClfFbrt7u2k/YKEI01
X-Google-Smtp-Source: AGHT+IHFSuYCkpnxUV4L2YQoxI/iA9eRDt+t80mIucX4PwO3MTQQZGr/9+1eupbNSwgmITlQMMyi4zAtUu5q
X-Received: by 2002:a05:6214:29eb:b0:6cb:6006:c98b with SMTP id 6a1803df08f44-6d85579b536mr13944196d6.5.1732588768749;
        Mon, 25 Nov 2024 18:39:28 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6d451acf626sm4599396d6.42.2024.11.25.18.39.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2024 18:39:28 -0800 (PST)
X-Relaying-Domain: broadcom.com
From: david regan <dregan@broadcom.com>
To: Brian Norris <computersforpeace@gmail.com>,
	Kamal Dasu <kdasu.kdev@gmail.com>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	David Woodhouse <dwmw2@infradead.org>,
	Marek Vasut <marek.vasut@gmail.com>,
	linux-mtd@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Ruan Jinjie <ruanjinjie@huawei.com>,
	William Zhang <william.zhang@broadcom.com>,
	dregan@mail.com,
	dregan@broadcom.com
Subject: [PATCH] mtd: rawnand: brcmnand: fix status read of brcmnand_waitfunc
Date: Mon, 25 Nov 2024 18:39:16 -0800
Message-Id: <20241126023916.197635-1-dregan@broadcom.com>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change fixes an issue where an error return value may be mistakenly
used as NAND status.

Fixes: f504551b7f15 ("mtd: rawnand: Propagate error and simplify ternary operators for brcmstb_nand_wait_for_completion()")
Signed-off-by: david regan <dregan@broadcom.com>
Reviewed-by: William Zhang <william.zhang@broadcom.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 482c6f093f99..701aa19328ad 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -1893,6 +1893,11 @@ static int brcmnand_write(struct mtd_info *mtd, struct nand_chip *chip,
 		brcmnand_send_cmd(host, CMD_PROGRAM_PAGE);
 		status = brcmnand_waitfunc(chip);
 
+		if (status < 0) {
+			ret = status;
+			goto out;
+		}
+
 		if (status & NAND_STATUS_FAIL) {
 			dev_info(ctrl->dev, "program failed at %llx\n",
 				(unsigned long long)addr);
-- 
2.37.3


