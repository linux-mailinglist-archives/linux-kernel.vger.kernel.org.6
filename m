Return-Path: <linux-kernel+bounces-546261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD27A4F880
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C40F1890335
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BC71DE8A5;
	Wed,  5 Mar 2025 08:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DHLnTq9U"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D973C1632E4
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 08:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741162595; cv=none; b=ktxE/LUf+uWLTUUETPbfoeQFUXEIz8IFRak+rHkJJwsgyPzb9UgngoWK80/hKpaWTYm1asnzX0LmgeKB2kjWdYiX9IK+uaHhlnByxUNsALSRPp5Kq0JDZjnjHlsIo8VxL8faaBQtj9iq8474xc2b6jv4RnMse6kQPC/Bnao8fNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741162595; c=relaxed/simple;
	bh=tcWSEMLkdnyh9aSLiaRBtq7lBNnDoTyyz9lHUiNPlc0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=r+3W5ht/XGVBI0gHr9PEM0oz1P/064rHz6V22Uhb/dA1t0dWgkf+1PLiccY9BrYRsZeAZFKpYmI6CDm2gaml+PVcnOAtGBew8aw6UrjZSKYrq43bTXXNB/qCvWDfXy69juOXCSmOqx76AaOXQJXN+CAxTRGW19ki4d6iTulLt3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inventec.corp-partner.google.com; spf=pass smtp.mailfrom=inventec.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DHLnTq9U; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inventec.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inventec.corp-partner.google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abf45d8db04so661289466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 00:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741162592; x=1741767392; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jBluRc4AqYa9mwEBFMC/KLTpnRIQOHur+1Rtne5kToE=;
        b=DHLnTq9UYlKJcPkKcfY2a/esuqZZZVZUAjghgISX89HAA7NgjqMeekAmZkOo3R7bX9
         +bO5X2dxKd7+F/DC5JXhh6D5MNYe1PT68daT8DwmIz6rVJX/8E1JURocMI/ouP6mnnfq
         loIhORYx9UxeX7nbmMax7g3NI/zI6A2qIx0gDk/vaiob5CHuPTRpOOqo+wA4gzSVUPoc
         AKJhojKDiw1xx4FS7c2VEMg9lZRVioMbEOorqPd2RsmMALm/TjFJPpyZPyakrV1BVSyk
         XuAzuUKMf1sheywpkOa466Pj0zAPV2woTiY9s8clolCdtkwvrHI1217GTDMsRp0CZU95
         IxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741162592; x=1741767392;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jBluRc4AqYa9mwEBFMC/KLTpnRIQOHur+1Rtne5kToE=;
        b=v/t+wYoKpwpvyqdUiysW8gyFO10hMokYmrCIZsY4Qwsh0yyJFDB9agNrq1M/Su5cuh
         /3V6rdEEt9ipmNVdf4I2bwTcsTa+2DsCEx3+u/NcGRvTdOrI343HK2ygCrgm+6Q/4df0
         pfPcLN6/hZVfGe7jGR2Du73leqQg/btA06sZJxhaUKcJ5RbKfWVIcBAGMzeRmShQkQBy
         emFgxKF7ievT5F9he3Wl1qZ/Cp6+0slphRIDya60aPmgpT+4C21fjrUwOUr1ric+jeE7
         2ubQ5n+PRTji2flsiCEKOpDETnRHMUUwmAdqBr26W13YWuk94WtzSIJZKLtyTGtuQKAw
         xDHw==
X-Forwarded-Encrypted: i=1; AJvYcCWILi5RN+rQy9wfZ1vrRhBkuw3VYaB9QWzuI8wAasV+STbSu+xBxj3fcJLRCQbpsVhTpXaBFttoTW8eC8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOVU1b1t1vF18IS9+wIy3rUO/1Kjgfj648EHGAZFzTrnRkgLz4
	/cMO0HDKSwzR28cpetsG/5J255ytPyhBSFXvm7Y7GcS53Gsg6+1qlxsfjInV1mPIxeLJME0CFRg
	8qu59Tkw6641H3//wSFOpQDKoGn/VFKjEV33hZ0a0nBBOv/f0msM=
X-Gm-Gg: ASbGncsX90egO6hd4sX6W9l9VxDX78+BZKskfljyssKk0q24ie+QVcXjHxoIaDJk4jT
	JT5uIiB/LMJ+dnH2YY4CVfl9ENmHqLfnVGQJUS4LV/UXWdGtA9Db434/VJVUx6gQLzY+0J9gefg
	ex9AorJw9cyYNzSMCog66c6/yJww==
X-Google-Smtp-Source: AGHT+IEIhI0imlmnmvEneoZB1CIsEriCFPuIQWHazM6Mp0DX2g8PZfAOrDM3QO+MompArNS2jl892RCCVscXRLKiSk0=
X-Received: by 2002:a17:907:94c8:b0:abf:44bd:8326 with SMTP id
 a640c23a62f3a-ac20d8bce29mr206694166b.17.1741162592052; Wed, 05 Mar 2025
 00:16:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kerry Kang <kang.kerry@inventec.corp-partner.google.com>
Date: Wed, 5 Mar 2025 16:16:20 +0800
X-Gm-Features: AQ5f1JrOJG-PHSW4n-sQZJypeRPbHykGGGirbiBu2VW4UdVYsGJR-MgJZ-byFWE
Message-ID: <CALNGHDC=cCjTpfm6WDN_rdo2A9KBvHPX=0u52s6gTVgPt2xj7w@mail.gmail.com>
Subject: [PATCH] mtd: spi-nor: Add Winbond w25q512jvdtr
To: llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Similar to the other ones, different size. The "JV-DTR" suffix is in
the datasheet, I haven't seen mentions of a different one.

The datasheet indicates DUAL and QUAD are supported.

https://www.winbond.com/resource-files/W25Q512JV%20DTR%20RevD%2006292020%20133.pdf

Signed-off-by: Kang.Kerry <kang.kerry@inventec.corp-partner.google.com>
---

This modification is add BIOS W25Q512JV-DTR chip to winbond list

---
 drivers/mtd/spi-nor/winbond.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 8d0a00d69e12..6ce5f70bc11a 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -146,6 +146,11 @@ static const struct flash_info winbond_nor_parts[] = {
  .name = "w25q512jvq",
  .size = SZ_64M,
  .no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+ }, {
+ .id = SNOR_ID(0xef, 0x70, 0x20),
+ .name = "w25q512jvdtr",
+ .szie = SZ_64M,
+ .no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
  }, {
  .id = SNOR_ID(0xef, 0x50, 0x12),
  .name = "w25q20bw",
--
2.43.0

