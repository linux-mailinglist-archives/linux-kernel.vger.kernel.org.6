Return-Path: <linux-kernel+bounces-386450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8235E9B439D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB7FFB2195B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2610200BA5;
	Tue, 29 Oct 2024 08:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HmC8HqRO"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F026C198E90
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 08:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730188857; cv=none; b=mkVLnNYQw25erexY/5jNYLKFcoZNxY8TknUEl/4jcg2zuJebgwJCFaYB9Qq++L2O1q/1uRuu/86mnyuWSvX1PRFABU3RuJHkhvlfZ9wyqhNkRJ8AiaOGSENKPQsjtceZOGGR1P22PTJe0nwx13+6fq19lzuX+ZXi1feMQHll0Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730188857; c=relaxed/simple;
	bh=Bs5RKnlg0wosheoy7cIkhyyQ9FSLjDyya8fyL/0PWG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i7dt3jEAhHE1Tl9ANc5B+Rlr6y4yU24pvxJXj1me2iUoJjpwqvRQaBPINzmQXVNSocAF7hwBdWaIS2WMEGeywkL/t9viKYbGlD/8cJaocSkFNRA+9qbccGtaQ9r3wuDQU9TDOZ6HSNmu3ixuOMvc5cKoqvF1HSvwJK2V9xEwOjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HmC8HqRO; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539fe76e802so6102824e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 01:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730188853; x=1730793653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4n4x9GYxa/84hlNl/zX8+weX12yrLQSNbbEjP2vC+SU=;
        b=HmC8HqROddiAQduxPNsUATlWDIcGfGjr9FI4CeJrGlA6uQyC82ooZPZDlYnnYgl0ba
         VFV2ndO6RPbX5T78Rvpjy01wedn3Cy9V91ojbX/gWDLUFvg53u7e9TD9tVFmw0MMgD1F
         yuKysVmo80kwWFg7zZz7Gbgp14AxSTIZrzlGUjaS3LNBoo9C/jgdKhIfDJNt5coVjvnc
         +d2rYLZKXHs8KoF85fdOXLCeUjlFLjWIrm6GRzjP+3fYb/QdGiUFp7cSgH4DpuaziiUs
         BsbbE+yQhtF4Bw2dYblroUPQJXUq3CLExJccCYiE6gGQeCVZzY+t1A2HtUtrprNuowKX
         +Okg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730188853; x=1730793653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4n4x9GYxa/84hlNl/zX8+weX12yrLQSNbbEjP2vC+SU=;
        b=AK8tr5sL9Ofd3DcL1LKcYJ/SEvsyiRVMgxSxVC29zvWduf6oLUWFyTOkCH/53u5Qj2
         RwLEtWhF+h4AT0083OwjAqYKv+YmDRN2oVYrO9WZrDouDeyneNpEQ/+4Gr2aD+Jr1Ylu
         BtjaohalwAp1Jvy7B1K9IS0bfY1ps+XbdfnY2lEzgTHPUhW1/PechzdOP7l0FRF4zpz6
         /qLygKVfLU+4uHFYRhN+Y0Ywzr4ej0RItGUPDj5mwqdVYt4Sj/8ADBbZiP7U8sAOCeW9
         LOK8n3bGLHVJn+MPNCo/f2pKjDPHs9BRduPsIIX+dHEBXajMFzb4jakkDVWGvHFHQaYL
         4QNA==
X-Forwarded-Encrypted: i=1; AJvYcCUbAtjdsXaFYeUFtVkLCzXgDljKmesWrzwZON1lC3t+f0L8vs0pLUpG5oVcihmWPVunUzEQ5rtTJiBlOCI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Eof6RF32hXneNWtu433ZYUrl1zGBQFswklSZ9L9xu5x5YM5T
	Yrp4aIWWbPdHhksGP9AkUJYOOu7lgDdl3leGOVPCd4JbqE1T+TZvbmQvzsYELqI=
X-Google-Smtp-Source: AGHT+IFI0GQq8D7c2huksHpR4S4ZugunHxuqIU3GR4zlJi6+IR1gaYwVJZr1f3llj1rmrlrWDh05mg==
X-Received: by 2002:a05:6512:2243:b0:539:de0d:1e35 with SMTP id 2adb3069b0e04-53b348c1ddemr4380499e87.1.1730188852659;
        Tue, 29 Oct 2024 01:00:52 -0700 (PDT)
Received: from tudordana.roam.corp.google.com ([79.115.63.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431935a4b40sm135826265e9.24.2024.10.29.01.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 01:00:52 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: pratyush@kernel.org
Cc: mwalle@kernel.org,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH] mtd: spi-nor: winbond: add "w/ and w/o SFDP" comment
Date: Tue, 29 Oct 2024 08:00:49 +0000
Message-ID: <20241029080049.96679-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit d35df77707bf ("mtd: spi-nor: winbond: fix w25q128 regression")
upstream fixed a regression for flavors of 0xef4018 flash that don't
define SFDP tables. Add a comment on the flash definition highlighting
that there are flavors of flashes with and without SFDP support.
It spares developers searching the entire git log for when we'll better
handle these cases.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/winbond.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 9f7ce5763e71..8d0a00d69e12 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -129,6 +129,7 @@ static const struct flash_info winbond_nor_parts[] = {
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 	}, {
 		.id = SNOR_ID(0xef, 0x40, 0x18),
+		/* Flavors w/ and w/o SFDP. */
 		.name = "w25q128",
 		.size = SZ_16M,
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
-- 
2.47.0.163.g1226f6d8fa-goog


