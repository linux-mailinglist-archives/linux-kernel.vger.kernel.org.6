Return-Path: <linux-kernel+bounces-297676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E65595BC51
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9086A1C21900
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312F61CDFBF;
	Thu, 22 Aug 2024 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzNfSg0f"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24583BBC5;
	Thu, 22 Aug 2024 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724345198; cv=none; b=Koccn/sWv1KQR65ZX0OG+BsxSP10UalPl++jfJXszXXsPbLgdY2VG1cYMV11DFMywf4T8PSO29XTQb4TPIoz4LSg243EAMwaofD9AUO+v4ZTpxt8gTEQFhuZ8Gn0iwV+ZvkBwCPH/6qsV9Ab9+gELkat9QWeEgQGiLshLbS+Huk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724345198; c=relaxed/simple;
	bh=0jS0aXk+V+RT0OK2eNz0b5a/mNafWFdE4+OvVCPcZfs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=YZmDo/WVPUbQt+emV1IrgH01/JHnjw6biUotHsGW0krmbn1Di/hB5BNS9OFU2pmJyBJD7fE8JMootXWxhJWzHRkbWKbZKGy04Y3JcewGp96o/G4m9kFKNuY/0ta+G7k0SPVUHa65qV7TDjgE447FAtMkgSvIJmAEjxnQWM4D7/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XzNfSg0f; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f3f163e379so16655851fa.3;
        Thu, 22 Aug 2024 09:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724345194; x=1724949994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XfmAhjWG2sOwGq6j8+6XVe0OoaQ5ib14uvk/YZBFpuY=;
        b=XzNfSg0fR8Few7sYRohOeViB3jbrQ+fbdk036sXDLe8DZ1qpt3hw/3hQm6p7Nk1FnG
         FegE9O10rztOL2jIRJzGlHyLPSyldUzQVPYd6coBl9bL8Jn42km9nO9pnQmWaEgU8m5h
         UZRgr48i08mV97ZAhMv6T+kJw9/EEGKMiK3NXsM5UcJRyRC6yi6WdPcYA3aw04pCjoqW
         7KEgQRlQC4p47ov2rPxZtTx0y4fzOYcNo4Ut2fOWtbErM/WMa7lB2mlNpy7WlwDcUULX
         LC2UgQoCO1bG8HDrrhQDOp/ovrjNpsQA57/FsYHNLJT7n6Kc3EWuOl7Yfg+buzfFlYGH
         5CCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724345194; x=1724949994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XfmAhjWG2sOwGq6j8+6XVe0OoaQ5ib14uvk/YZBFpuY=;
        b=ge+05VR1kNzEpoPxBQK0YBi3vNx+6eye1z77ae9Uon8bF10zxmyXVtfsbvzXHKUwEl
         NHtVphwXFvurRe6Yfh4Armd/H8Af8hW60IpcRizRD7W3EAbYEuqT7x8zhGT9TgCh/Yzq
         Bym1UuPWZkheAQbNtcm90dP9NH1w2CNLFJ747DVH4wBb7aiJpfu/6iozOZ5oQ6y7Rg2l
         fNBeT6cOi7GYPirWVX8hnXGBMvYzZkS/4qxyFZhQnd4p2uYwcxRxSsdRXI42p71X2T3+
         OT/XAE8js0uuEZFWLz1auDTt+fQifnuY8GdZkxN5nUfTbxVCv6mI4VNHgGWd46rb32FT
         9pLA==
X-Forwarded-Encrypted: i=1; AJvYcCWRF/ko8zJfPNGzvfYsTKHjczmyYxyfJdOhfBx9u2G6oVZ0LueO7LNEQJ0ROpSFF6vRSvfz/k/pLN1nIlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIjMmQnFaD5+GPukEUNVIW6aiKvoGMlLRZOWoe3hnXqZ/bm89c
	MJoygf0v1uW9vTM04OA57noLmhQAbeKb9FRIcb9SdG3jB6Rln+Vd
X-Google-Smtp-Source: AGHT+IF6GUoQW921ObHker7LldBOgNZ9yNjYnuSAy6U38EnS2MbSKP4J9uiayEbJDgQhtps2Tnm92Q==
X-Received: by 2002:a2e:5152:0:b0:2ef:29cd:3191 with SMTP id 38308e7fff4ca-2f405ef037cmr20766221fa.35.1724345193572;
        Thu, 22 Aug 2024 09:46:33 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0515a6342sm1110560a12.79.2024.08.22.09.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 09:46:33 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] mtd: parsers: bcm47xxpart: make read-only array possible_nvram_sizes static const
Date: Thu, 22 Aug 2024 17:46:32 +0100
Message-Id: <20240822164632.638171-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Don't populate the read-only array possible_nvram_sizes on the stack at
run time, instead make it static const.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/mtd/parsers/bcm47xxpart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/parsers/bcm47xxpart.c b/drivers/mtd/parsers/bcm47xxpart.c
index 13daf9bffd08..49c8e7f27f21 100644
--- a/drivers/mtd/parsers/bcm47xxpart.c
+++ b/drivers/mtd/parsers/bcm47xxpart.c
@@ -95,7 +95,7 @@ static int bcm47xxpart_parse(struct mtd_info *master,
 	uint32_t blocksize = master->erasesize;
 	int trx_parts[2]; /* Array with indexes of TRX partitions */
 	int trx_num = 0; /* Number of found TRX partitions */
-	int possible_nvram_sizes[] = { 0x8000, 0xF000, 0x10000, };
+	static const int possible_nvram_sizes[] = { 0x8000, 0xF000, 0x10000, };
 	int err;
 
 	/*
-- 
2.39.2


