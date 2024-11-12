Return-Path: <linux-kernel+bounces-405419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BE29C5114
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ABE51F22104
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4148920DD6E;
	Tue, 12 Nov 2024 08:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnSudM2S"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052DE20B215;
	Tue, 12 Nov 2024 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731401111; cv=none; b=KKEZWR0dTUyy6QD/Rf5Vmpq0RIhJxY2KApkCWpLLzsl+XFST6M7xwj/H8VJK5AA7NOH6SnWP8LflqWfMe0d8wHbPizYfx2mAUWAsc4bZ8yqgCS0riUq2T62XTUxkdo24RX/uTXNEAZdxLu9eHZWPj9Bb0j9LALpzZnXvlYdFsTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731401111; c=relaxed/simple;
	bh=+BnEF8LUv/eqNV86xexN4WRo2U7oK8QyC02iBSGF8m8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=HlaxHTbWBtUUtY4XTtmqBtGauP8+nz2vtYUap5KzoJLUD5LPB3me12l3JS9eycb7URbEntnxj3YE0WLSKF+9U45c1cErI7q9/1j6Im7Tfx0pHzoGkaUgx0jI+lA/Jee31GoTMqJYzrW5Ok/8lKnlZ6VTQ5bA/JIqPwN81dExdKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnSudM2S; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43159c9f617so42299315e9.2;
        Tue, 12 Nov 2024 00:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731401108; x=1732005908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HtIWt92r3jJeIGhTfSwguSlgt6yJwVVrHzPz/W00DbM=;
        b=fnSudM2SgLkfJMfuIKHrvX9AtcD/uA+OLT3ivdz7EC4C2Uq7OiNvEjnOYY2Pttk8GJ
         +y1QiZ7m0pZEs1DIafNzTfp6iRHlIg9tD+F/l5dLLBFHvqUSvR9PtXSVxTU7r20g+eQ3
         eja8cqJ94aRbBUaD+vtfWappIKcxKOqkwg1im0RB/OpUaksSw/AqDZNLrGSwI/+mHuTm
         sPrQm+YPdUnCpKQJpESkiO3ByDfuLZCy9tqyLI0bQhVC8E8mFB03JxUQ5A4vHikECkbR
         s4DBCGSjbTd+/5yUrQd8nWlYJ0I7Cn+3GhKaAAnGS2Fw6QbFehIB1+tfJzgQYs7mMqHP
         +ACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731401108; x=1732005908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HtIWt92r3jJeIGhTfSwguSlgt6yJwVVrHzPz/W00DbM=;
        b=M0P6Vh7/RRzTLU1ExbsBjpvJ/qXxqqJXja5gwv2g1pOOuKuVBqQ7GSEDUYkPf2TPyj
         lit9373unpB4z3NS9X5WT3BphOiXlAAzio3nfu38Myh2ZqhiUu+w+dITV4a9Prc5hVzS
         p/AYY8ApPe5Ak0MkOR4U3Uso58US+VtS6vFAw7GH0PoI9PLxkDgLXGozNRTaUrK76CzO
         bzlFekIMn0fWpNsyzPeZJQwLzJx1K6qeTwYQ98KYWQiwjmWobf4laeb4ztq+XIjbJi1d
         ebCiP/ZYcI6Guv55BA3cUENU/Q9Vx6UA99v1AF76hWxMXC13E3NFEQUaPdrsxor5a+3c
         tHUA==
X-Forwarded-Encrypted: i=1; AJvYcCV/EELReIeh3dn6KBNjr7cY+v8F2+fH5SQZW9NdXmLJP12zKk+5/Of3UOZZ105h52BeOKboNE05y9kgj1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgaNh/RcwqS5qpc4Iw8wEc8qcFFywVMt+zOte/6LbjcQ56gaX6
	bV8LTm2mfwNM2yPWQoLn1s8EmXsTxUvM/dfb6xdpIXNsol5tKsLu
X-Google-Smtp-Source: AGHT+IHay0dm2ib+gJdXM+ynt2rX21Iht+AmEHc8l1PfRDsLi9ymes5sYG8R//0630JR2NVx5iq7dA==
X-Received: by 2002:a05:600c:1909:b0:431:9a68:ec84 with SMTP id 5b1f17b1804b1-432b751827amr125079705e9.23.1731401108010;
        Tue, 12 Nov 2024 00:45:08 -0800 (PST)
Received: from localhost ([194.120.133.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432bbebed39sm133703895e9.19.2024.11.12.00.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 00:45:07 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Alexander Usyskin <alexander.usyskin@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] mei: vsc: Fix typo "maintstepping" -> "mainstepping"
Date: Tue, 12 Nov 2024 08:45:07 +0000
Message-Id: <20241112084507.452776-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a typo in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/misc/mei/vsc-fw-loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/vsc-fw-loader.c b/drivers/misc/mei/vsc-fw-loader.c
index 0d7e17322869..308b090d81bb 100644
--- a/drivers/misc/mei/vsc-fw-loader.c
+++ b/drivers/misc/mei/vsc-fw-loader.c
@@ -334,7 +334,7 @@ static int vsc_identify_silicon(struct vsc_fw_loader *fw_loader)
 	sub_version = FIELD_GET(VSC_SUBSTEPPING_VERSION_MASK, ack->payload[0]);
 
 	if (version != VSC_MAINSTEPPING_VERSION_A) {
-		dev_err(fw_loader->dev, "maintstepping mismatch expected %d got %d\n",
+		dev_err(fw_loader->dev, "mainstepping mismatch expected %d got %d\n",
 			VSC_MAINSTEPPING_VERSION_A, version);
 		return -EINVAL;
 	}
-- 
2.39.5


