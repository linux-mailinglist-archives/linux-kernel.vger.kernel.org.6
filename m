Return-Path: <linux-kernel+bounces-249992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4361E92F2B5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 01:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A95A7B21BCE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 23:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6729315ADA1;
	Thu, 11 Jul 2024 23:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwBNkT6U"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1891E158A35
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 23:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720741450; cv=none; b=AhwNcnxumPbGvbCGgWy6E/1cWeG/ZMf8UxV4zQQXLUnuw0rd9ekgWNs4Hp321J4yk9TFr330dyYc6YjXF4bjsUp+wIwfv7FIgNCb7qg/BfJW1Cj76Z+watbpMCoFYzOAAWY+d9hON460KxNFfJGwKQ79XBoBS9YPfoEY5xpBt6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720741450; c=relaxed/simple;
	bh=wLBMawbVY4kj2Bt4EYlLhcU0EttvHEXOdNB5ECvZTL0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NECsEh7xjnVNJ7lS3te7sbWT20tNJczI4OWfZSFOfCrj1WHTAmVTv+gDkB/xV7mbIjYoH272AoCDYmPs1d9PFyO8bLytD6yXigmWdOuQM/JNa3fVXX6E4A0QvPUXzt/LeT64n2NkvA0QYyssemQ5MBJ5F5qV2YFnpDsw85Vnf1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwBNkT6U; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa6c4so1821151a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 16:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720741447; x=1721346247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/UTDOPl9I3vMY3m8thY7f41quo4HANERf0zsiZjsCw0=;
        b=UwBNkT6U5OcPbnLrXm/u7WkFuoARoBFwi+i+5sd2Nruuv9747O7qodf+ha0LSQ1pWJ
         Y5BDmBrNieis2QBXspzM9xi8AVNAg9vzLtGhDdQhY1ClFIBmNRHs5+mmdwulJlzYVj3g
         0x2JJGDvMLSiaZd9JfTK/Tc3qHW6yBUh+n9l2srnBjZkP87BCafp3dSDvLMnzwhOFj8Z
         rV3ajOyvuu4uTE3R5MQbTGbYQ2wOAGoFSygKMMbbRXcY8fzdhCMnjlW0H6CAnomii76O
         KBZb28w5/xZn8JXngkHMubDWiH58NZFSyrg0KU03P3hwKIMEmwX45iR/0cfq6wqRnM//
         NahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720741447; x=1721346247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/UTDOPl9I3vMY3m8thY7f41quo4HANERf0zsiZjsCw0=;
        b=KRQ9O4tqr6gO/KmhbkZ9vode96T0UTikcizP6L/ErjNHdYyPfnfIe638EeDYDbA8sH
         /tWJqU2jM/dw7wAUmrncYgACFW6kp/jsZkYbjywwjMgWGKViJiEbXpzY3hJx0J3W7gP1
         n18Pmehxip3wmu76/HZgbFEKc6xUEx+khGc78DyKNYiyi4dcwAfAVRsobaOjmAbVIrUY
         l5F2vcRUJw28GUOPrN73Ir+Ee1uI4xfAqIuWepBHgosduNnvCpe04REp3P/ZqWtvJYRx
         WCtpUUzH+BAIsFOQr5mc7Iv8XmOfDPhqUWuCetQSDv2+WdNMZJTecjhn/fgvsWoALAyW
         grnA==
X-Forwarded-Encrypted: i=1; AJvYcCVwo2zO3kgDcajGGptEIq/VppW4NLTyqhwBsRF2e7iYo8sI8NKJ5l8/Gpp+SXsf3ZYp7hXox4+x6JmP6rpEoCiJbq2PolARhjz8QIBr
X-Gm-Message-State: AOJu0Yy1tEMpQnTNxuCfLjMpyfY81cn8sCuFJUbeeOtWSzBfxD/32dtd
	skQXh/nAMABKfzxvZBDhpAQI2z8bSO44ztTChhP8QbDx0UKizGLP
X-Google-Smtp-Source: AGHT+IEJeM0LyVy2Bw99T+GuOi4v/uMCQDzpgBCjcbqcQI0pTZdD1glvHsJQ8cdC917J3/VfRpJQ5Q==
X-Received: by 2002:a50:9f0d:0:b0:586:f49:1762 with SMTP id 4fb4d7f45d1cf-594bc7c819cmr5494970a12.26.1720741447227;
        Thu, 11 Jul 2024 16:44:07 -0700 (PDT)
Received: from localhost (dh207-43-148.xnet.hr. [88.207.43.148])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bb96042fsm3950389a12.5.2024.07.11.16.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 16:44:06 -0700 (PDT)
From: Mirsad Todorovac <mtodorovac69@gmail.com>
To: Mirsad Todorovac <mtodorovac69@gmail.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v2 1/1] mtd: slram: insert break after errors in parsing the map
Date: Fri, 12 Jul 2024 01:43:20 +0200
Message-Id: <20240711234319.637824-1-mtodorovac69@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

GCC 12.3.0 compiler on linux-next next-20240709 tree found the execution
path in which, due to lazy evaluation, devlength isn't initialised with the
parsed string:

   289		while (map) {
   290			devname = devstart = devlength = NULL;
   291
   292			if (!(devname = strsep(&map, ","))) {
   293				E("slram: No devicename specified.\n");
   294				break;
   295			}
   296			T("slram: devname = %s\n", devname);
   297			if ((!map) || (!(devstart = strsep(&map, ",")))) {
   298				E("slram: No devicestart specified.\n");
   299			}
   300			T("slram: devstart = %s\n", devstart);
 → 301			if ((!map) || (!(devlength = strsep(&map, ",")))) {
   302				E("slram: No devicelength / -end specified.\n");
   303			}
 → 304			T("slram: devlength = %s\n", devlength);
   305			if (parse_cmdline(devname, devstart, devlength) != 0) {
   306				return(-EINVAL);
   307			}

Parsing should be finished after map == NULL, so a break is best inserted after
each E("slram: ... \n") error message.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Mirsad Todorovac <mtodorovac69@gmail.com>
---
v1:
 initial patch proposal.

v2:
 re-sent using git send-email + oauth2 (fixing T-Bird TAB problem).

 drivers/mtd/devices/slram.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/devices/slram.c b/drivers/mtd/devices/slram.c
index 28131a127d06..8297b366a066 100644
--- a/drivers/mtd/devices/slram.c
+++ b/drivers/mtd/devices/slram.c
@@ -296,10 +296,12 @@ static int __init init_slram(void)
 		T("slram: devname = %s\n", devname);
 		if ((!map) || (!(devstart = strsep(&map, ",")))) {
 			E("slram: No devicestart specified.\n");
+			break;
 		}
 		T("slram: devstart = %s\n", devstart);
 		if ((!map) || (!(devlength = strsep(&map, ",")))) {
 			E("slram: No devicelength / -end specified.\n");
+			break;
 		}
 		T("slram: devlength = %s\n", devlength);
 		if (parse_cmdline(devname, devstart, devlength) != 0) {
-- 
2.34.1


