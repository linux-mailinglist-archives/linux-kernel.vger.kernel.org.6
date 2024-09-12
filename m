Return-Path: <linux-kernel+bounces-325935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDD0975FEE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 06:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A15221C20F40
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 04:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C2E188918;
	Thu, 12 Sep 2024 04:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ci2usA7U"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616FF18A6C1
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 04:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726113881; cv=none; b=mTLdQSzNqIbRXWZsLF/80knO/8mWlx7bKgeGw6xbPd7fDR4Y+lzNmnKeIlL6Xezgf92LXWO29QKdlPLDS0359zQqhZXjYbKraB15cbXb/gkSjOXeca+ycQQGzYH1u9ZV/+wQVh7u2FOkE75MKUsRsgRrAMkYttIaM5w0SDR/ZvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726113881; c=relaxed/simple;
	bh=zyyawO/uW7xUYBto29DhygmEN66WLE+uMJwCMx/YU9A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AGbDly7vVILrhuwPdNIq3pBheWbEQGQT5nYqmWal2F56YWEY9+833s+I2AtWVGtuQnIq2xb9m544FVIkfW94SR3BxlqDecMlWUWOG9mJZDScNQOBpFC5XEk/bOrNOgb4RTqS/IICEo0LG7z7pzP8QkoFlbLc+Szc1nc8dLE8gqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ci2usA7U; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7d7a9200947so381554a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 21:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726113880; x=1726718680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dc0/4aLhAOlQgNkq7UXPdLlR9BwhyToHh2UX75c0BdE=;
        b=Ci2usA7U4X0gTQyKyN3BAF0DH76TyWFmBYfyyPz9wkNCtWmCX1Eyn1+tWtoIihDtgO
         lx2fuvS89nGPPzQflZiNEmhfWyomrUJVNaFyAsBnmwfo9Z+68mO4jgqBV/zIRZfBqTbl
         tY4u6L7Y9x2oVZCFvVYF4gm3TbRbnusQh761sZ1h6ECfzZCJhzgPr99UpmAVsKZh94g/
         HTp2RBztybwAZ7FRS+KmIfOYLNLRKfQ+w2HMQbuEAzse66VyGLeWAlDDXxS/EZEuXtxs
         lDGIomzW7Qs8X/J+dHhehtPYt2APGH6JPbi93VOL4V43PJ4/RAYWHoTINVbQSU2xCazZ
         RupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726113880; x=1726718680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dc0/4aLhAOlQgNkq7UXPdLlR9BwhyToHh2UX75c0BdE=;
        b=c4FqTJeGCrZsvLdqfBoHkmpUZlVH9bU7rtkmsOAjYjJL1ZpRH5RhUIzaFq+ns/xAxb
         /QmXAmDrvXN2NIjMxpAFXe0CmMCXutgrEsJ4gu0LEZpCZIfQ82NSAQAJajW4Qu/T5DSm
         XTZPyuL73Oz+F0JtCEIQ7MkWSDLL9DXhOa58LjRTeIE+/Y6fxCWU+Z+yXUpcVy0ADN2B
         5lvsK1hew7wrUpf6AquHx65DDYgHGjn9ICoKxAoNQsFZpV7cp0n0MdSJvdBa1LJI/L7A
         kfm2aeHF/lmPJIKlySbYA8fGy5YRHRe/VrZfGgzpBLvFvh8OfqsbXPkj0qVP85ijEhzw
         u7BA==
X-Forwarded-Encrypted: i=1; AJvYcCUd0XCoWo9g2Iu8tggCs1EJL3QLZj9ARa6HI31dNGi+wdM/HQdiOnulX1L5yDHJXT4103fhbYKe6RLYlNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YweqTTLnUTumjJI/Xr7HdyI53h0c0aG+9yIaZEMmEjIJiIolERb
	4r1MdNvBkDsYZzunUuIhj/gBr9pOAGVrsn7dI0PTyKEheg79w4C1
X-Google-Smtp-Source: AGHT+IFIwqIPMdCXEORiJbR0FOWqpn9jQVC+F87+u3NtDpFEsSTH9/30FsN8vv5xzf9GpcTMHy2ZJQ==
X-Received: by 2002:a05:6a21:4a4b:b0:1cc:ea18:27d with SMTP id adf61e73a8af0-1cf764c1253mr1923547637.45.1726113879605;
        Wed, 11 Sep 2024 21:04:39 -0700 (PDT)
Received: from debian.tail629bbc.ts.net ([2409:40c2:12a7:616d:eca9:534f:4e49:7c41])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fba469fsm768359a12.11.2024.09.11.21.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 21:04:39 -0700 (PDT)
From: Sayyad Abid <sayyad.abid16@gmail.com>
To: linux-staging@lists.linux.dev
Cc: gregkh@linuxfoundation.org,
	guilherme@puida.xyz,
	philipp.g.hortmann@gmail.com,
	linux-kernel@vger.kernel.org,
	Sayyad Abid <sayyad.abid16@gmail.com>
Subject: [PATCH v2 6/8] staging: rtl8723bs: include: Fix indent for else block struct in rtw_security.h
Date: Thu, 12 Sep 2024 09:34:07 +0530
Message-Id: <20240912040409.3315067-7-sayyad.abid16@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240912040409.3315067-1-sayyad.abid16@gmail.com>
References: <20240912040409.3315067-1-sayyad.abid16@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change improves code readability and maintains consistency with the
kernel's coding guidelines.

Reported by `checkpatch.pl`:
WARNING: please, no spaces at the start of a line

Signed-off-by: Sayyad Abid <sayyad.abid16@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_security.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_security.h b/drivers/staging/rtl8723bs/include/rtw_security.h
index 7901cce76443..6124f2ea2431 100644
--- a/drivers/staging/rtl8723bs/include/rtw_security.h
+++ b/drivers/staging/rtl8723bs/include/rtw_security.h
@@ -61,14 +61,14 @@ struct {
 } _byte_;
 #else
 struct {
-  u8 TSC7;
-  u8 TSC6;
-  u8 TSC5;
-  u8 TSC4;
-  u8 TSC3;
-  u8 TSC2;
-  u8 TSC1;
-  u8 TSC0;
+	u8 TSC7;
+	u8 TSC6;
+	u8 TSC5;
+	u8 TSC4;
+	u8 TSC3;
+	u8 TSC2;
+	u8 TSC1;
+	u8 TSC0;
 } _byte_;
 #endif

--
2.39.2


