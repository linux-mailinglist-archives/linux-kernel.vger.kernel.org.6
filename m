Return-Path: <linux-kernel+bounces-517333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCEFA37F81
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C1831893354
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04621216E1C;
	Mon, 17 Feb 2025 10:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEqoZqTC"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227A92260C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786744; cv=none; b=Fy4UL/xBMaVvR0wMErYhbiCJpaIv5qAjbg5YpSS+u8JATN/tyaEIO/kHCgiE98ROse7jdGgHJ1Dm9inZNic6nQ2LO47284DiYrqw6q++dJIVDStqRwtz3tTBB+JNPYVRP+EntGPr6DNrbXFrBkMrC0NTmkPS1a65ba3YWCAutOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786744; c=relaxed/simple;
	bh=Gazg7ITlPyeapShlUJWzCmzJ5JDneJIfQIfGTf7Y54c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GP2CuYTtCveC6UBcU4Nm6CqXbDNHvUZPRWDEA+BoZaknqZBC4dT3LanyZc4zUvIJ3ogIdDsjiXhazSJ7t9yvZzMSp34SFnydPWWlmPkO9eez3JjL52gLJfGaxFgdsOTKHDTKZmsg78SdoOxSfgrzI/XCuaH0y/9+KdS0+urhsSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEqoZqTC; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-220bff984a0so73527045ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739786742; x=1740391542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydQlzBFDch5dE0pXTfWbgAH++noP+kxMcP8vl7mV8uY=;
        b=ZEqoZqTCLYuC67uJZPNlwFiE6QGlEIfUQE+8JbY8kh8fOQ/x9miRvkMMzoh8LtLjvJ
         oviYSU9rurI64+T0I2UATEU/WqM6GYIwyEt1ZeBbuVoYo0y28EsnTY4+z5xfe3HWxMiY
         WsmkBNvNMJIzh89AujZTWIvKCVjWvUN/uw/YqcyBeNpVj6TMVfolUo0w/44gZ1adnBAn
         IN2Ect13un2TSx+ynZi4dz22drbap1T7Rja8Ek8IzbrQCCVfUUKpbl8Ck8MkSOnbM86w
         dzUGX3nRYbKiWcRHX5KkUIt3G7cbxALgN0Nfh4z4xnBgY0RbSYqqpwRfPITlP8FxFZDv
         e2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739786742; x=1740391542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydQlzBFDch5dE0pXTfWbgAH++noP+kxMcP8vl7mV8uY=;
        b=o6KQl8+cxJsSO01ELgfjNbQMegQ36fn62Y8JmCxlu6/cqzdxk0EULQ8O4kHvCR6lv0
         4RAnqONuXw6bP0V3vkpaLruNipHmfVxLNy9VKuG3fRkEZp0c1AC5XtdmoELNfLCFTPPL
         r4orCZ/fR0bTZ3ERYQZR5TCXi44d6C4qPqRCYQ7I7yA5uYB9NGPB3qpae4WFobmwRia6
         wcwfAmNMNg2y9X9RO/MMN0FBbPpUHZbCMkFh9ATDJ5qWVjrcI9rvGBkXI2fF925nItxy
         6f53DH9wgykFp+E+jhXN3GvLrZo0LP+4c1DUSeXQfysV3069hdxE6OMwsnnktg0BLQur
         mTnw==
X-Forwarded-Encrypted: i=1; AJvYcCX940V6GU68Km8VQHjIf80GVlQ8ZjrLjlk04xiZkzjqewtGr4GZQGU0qMKB7XEMSsrYCpg2h1eog/eaY5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwbgFp6daMZa1fXHghI0RmL4IRs5RYHaILmz/eENaDTFO/0zNY
	Xy2fW2l0rLX7iIcKMaRDjln42lgKOIA42sKgOciFkcXoqnoCsqiEkdT0iEaXmOI=
X-Gm-Gg: ASbGnct+cRa+QRyt0l9H3W5aS5UpmNjqwH3st0FrrzZSd3mtiwZcmpXMaU65BQ2pj7O
	nSQl0Usz6DwG2L4tXPLDQowH5ZMzz7lBEdejXWR0GRqnCTd+7BLDrUPWnvxqoN31SgTlh5FnKa6
	Hx/yIocA5yrUVkZrsW0Lm3s1fXAQLJWBJ9IhEc+m/tsdMD5YAy7efhmtZSmL0ROFaIVg2L+EyOF
	+hP5bgyc06u7e6IImqJ42+wyykkQtq1ZU8htGHc21CjRNgsfoyApAP1E+NCeYyIPfChtVPSlaXE
	24O0GmN0jbFOiKgnMPl1
X-Google-Smtp-Source: AGHT+IHXvUhl4bD+LjfkXgIcHMinochivPxFwXtuS7r0q/hR+NkJfRrikbDiGt4PUN6mvMgs0ORq8g==
X-Received: by 2002:a17:902:f54f:b0:216:4d1f:5c83 with SMTP id d9443c01a7336-221040bf8dfmr152839325ad.47.1739786742380;
        Mon, 17 Feb 2025 02:05:42 -0800 (PST)
Received: from localhost ([2409:4066:d04:319e:1d76:db25:b6bf:4f52])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d5584dfbsm67269345ad.213.2025.02.17.02.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:05:41 -0800 (PST)
From: Ravi Kumar kairi <kumarkairiravi@gmail.com>
To: dpenkler@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kuba@kernel.org,
	dan.carpenter@linaro.org,
	rmk+kernel@armlinux.org.uk,
	Ravi Kumar Kairi <kumarkairiravi@gmail.com>
Subject: [PATCH 1/4] [PATCH V2 1/4] staging:gpib:agilent_82350b: Fixed spelling error
Date: Mon, 17 Feb 2025 15:35:10 +0530
Message-ID: <20250217100526.49495-2-kumarkairiravi@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217100526.49495-1-kumarkairiravi@gmail.com>
References: <20250217100526.49495-1-kumarkairiravi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>

fixed havn't -> haven't

Signed-off-by: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
---
 drivers/staging/gpib/agilent_82350b/agilent_82350b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
index 5c62ec24fc..5a74a22015 100644
--- a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
+++ b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
@@ -121,7 +121,7 @@ static int agilent_82350b_accel_read(gpib_board_t *board, uint8_t *buffer, size_
 	writeb(DIRECTION_GPIB_TO_HOST, a_priv->gpib_base + SRAM_ACCESS_CONTROL_REG);
 	if (retval < 0)
 		return retval;
-	// read last bytes if we havn't received an END yet
+	// read last bytes if we haven't received an END yet
 	if (*end == 0) {
 		size_t num_bytes;
 		// try to make sure we holdoff after last byte read
-- 
2.48.1


