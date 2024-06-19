Return-Path: <linux-kernel+bounces-220582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3CD90E3FB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AF8AB235D2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 07:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8671C745FD;
	Wed, 19 Jun 2024 07:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nej6BCG1"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7818774049;
	Wed, 19 Jun 2024 07:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718780728; cv=none; b=DbBkrsKhUGIzxwHvafEpeQiB9STVT7YrPFI1rXrHUkuccR8QaGty8UdL+OeLEme8sw1DFRwUNMUBbsxoMRS302eu3HASVDBguNxGVZCp3JS0Am/O0sUpsMr9MmpBU7vc9sSqTDudnOLRNN8WG29fddDSxVsSMQP0owyDAuGVGDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718780728; c=relaxed/simple;
	bh=1etGkshU1O7/KCVNXu5R9J/vCH7r2G2zAHvGse6TYp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G0CVhSDjmSxqvD5S81K6comoTOxhoVWmXn9jp3oIdyMqs1S6jw4u/2KecWn2DZ8/ykWHLGV26YPpTupvbj3ecEaeLRoKWDYshUSmorF5pKrf+r31aviVmUlmrp/h10AD2XG6mxrs+ZQ13jaD0qriT77+UYvkE7N6WPFIUnTHBjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nej6BCG1; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70435f4c330so5219981b3a.1;
        Wed, 19 Jun 2024 00:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718780727; x=1719385527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sB8HfoLbcg+hW+2TwdjXWA6kGA91H5GmLxeUo6C+9MA=;
        b=nej6BCG18+DyaodiCUonKRDGdQh0NocIsZF+tkQL0tBnAEU2GoD4mndMyzGXz+ijFq
         wm0cb22Sf8xecVPSxl/b/WIc/6rUj6BdOHkm1QRv1Tg0VkHvmnV2qIfhZylEKJ8nYpdm
         sPIvK7wMyTYCDoYYQJM+lcGll4mIYC/t5aizvVQvRSo+PtwwxL8ETZkFKw72iDyqe8hd
         y0KtfiH+E9Brj1GeWwMuepIF9Tv+dYN0TUWfMtgq4nSANDK7n4lQ2lApyk8tREh5zf9V
         3p4Zpev2VOHy7rVGwEYfLU1twV7KpC4UZ+bOxbu7h1ARO9DzsrejuW6fxuP9BX2OGebL
         f8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718780727; x=1719385527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sB8HfoLbcg+hW+2TwdjXWA6kGA91H5GmLxeUo6C+9MA=;
        b=rGqY09V3nQ6G7hUZ1K2X1Epx9yHNXgNp2X/AiJvcREKICLUSdt4L0h6UPLdy61TJ1M
         /eOwttikv5YZomR6NW6RZv9GB9I0UchlFr+3lGCf+btllJSTTyPD8efPPUD99uWxiA8Y
         HvEAtlJArSMWN97waQeeYsSGQbt3pyfohqXyL7RN9FlSIE/FlEwaFy5JqpTq0aghCih8
         1hlqpSWgIGCVDFE/RUEy3lM8zBBYhOTb/VIrI7IXluAH4P4YQ6FoT7BgNdq+Mkxo7w/C
         dgf6StCMSuSEDNJhFQvSxG5bym/+G9Ha7E6Cqap+25kHQXsJaT/UjDhAy6LFRl85edMp
         c8CA==
X-Forwarded-Encrypted: i=1; AJvYcCVR5Dl5rrP72jcVryLqSIRAiXerTuXfD0FXAeQNKeLMhhPfkL1yVCAvE0TSFXN5DzCLUdRW1/N42MHsu9B2Es4vTiwL4/KLxlsq0/eQ9UhyO+mDpXrP1fA+zbG0stmavRfSLymK8lZH1U0n7dZE/n6tGfZetD7i3pGK6QCeXKzruw8SLlCH
X-Gm-Message-State: AOJu0YzKwMz7ps2mzrgXinvsfYlNM57VxygvgtKHOk5n5nOnV6jzAJpn
	Qel+zGvyx1iCFsUpO76HUj3dw0JDjRkHusmYHjqabJsxS7enLuTzkANYwHsdlXd6Hg==
X-Google-Smtp-Source: AGHT+IHPoyvXMcrxRtNi1sPgAPxtmm48b61E6rVWQ/0JpqZauJQXcaJ6a7BA93wBYNoVxjAiWQ2Olw==
X-Received: by 2002:a05:6a20:f02:b0:1b7:bdb3:7bc9 with SMTP id adf61e73a8af0-1bcbb59caeamr1548782637.30.1718780726551;
        Wed, 19 Jun 2024 00:05:26 -0700 (PDT)
Received: from fedora.one.one.one.one ([2405:201:6013:c0b2:ea4b:30e0:4e3a:ab56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc987738sm10036177b3a.89.2024.06.19.00.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 00:05:26 -0700 (PDT)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: animeshagarwal28@gmail.com,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: rename wm8750.yaml to wlf,wm8750.yaml
Date: Wed, 19 Jun 2024 12:33:54 +0530
Message-ID: <20240619070356.80759-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add vendor prefix to wlf,wm8750 dt-schema.

Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
---
 .../devicetree/bindings/sound/{wm8750.yaml => wlf,wm8750.yaml}  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/sound/{wm8750.yaml => wlf,wm8750.yaml} (92%)

diff --git a/Documentation/devicetree/bindings/sound/wm8750.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8750.yaml
similarity index 92%
rename from Documentation/devicetree/bindings/sound/wm8750.yaml
rename to Documentation/devicetree/bindings/sound/wlf,wm8750.yaml
index 24246ac7bbdf..96859e38315b 100644
--- a/Documentation/devicetree/bindings/sound/wm8750.yaml
+++ b/Documentation/devicetree/bindings/sound/wlf,wm8750.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/sound/wm8750.yaml#
+$id: http://devicetree.org/schemas/sound/wlf,wm8750.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: WM8750 and WM8987 audio CODECs
-- 
2.45.2


