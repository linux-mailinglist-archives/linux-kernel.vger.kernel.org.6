Return-Path: <linux-kernel+bounces-372954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FF79A4FCB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 18:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33DE11C24C18
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 16:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F74E16F0E8;
	Sat, 19 Oct 2024 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="qKMiUYSu"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0282118C333
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729355245; cv=none; b=FMF2Nt63hyTK35Ypny5oAB0WY+LpG6ARhKG4yvi/DV0CVySZMjKPN5Q5wsQtXQ3KAB0xrzRWWVgFgvHudz2HvaCdnbS9DDuFk6W/txiqLvRYjkk5syAzV0bNQc8UYc4bVopAf59bsawRwS6t+eP8TI6lrNBYgDAtr/mKe8HZADc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729355245; c=relaxed/simple;
	bh=Xl9vdTyOqGPq3WHHBASIoOO4M9v0AMy2nVdhepmVFX8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pB4ZvgkqJBvXJbVut7fsYn5U2n4NCbbQM+E4FfHQD1O+2mFgKeAgsXXk9TuvXqhHZI82FDC9grMYiUQESyAOp7Yx0jB6Sgb1eaYu2Hx+G3bvGKBAK68PxNPZVYzmTZoaUP964QTB4NEOpOENJcfYN17nlakbQpK9ZX4ZUn7hZnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=qKMiUYSu; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c77459558so27734215ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 09:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1729355243; x=1729960043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayyCub6qQl7nB8NfvKhUdob3RBjft3xPo4E//xagIW0=;
        b=qKMiUYSulTI25J6gRyT/jqnqUzgQCrLaf4yhzClHIhExnOkfmAJ/+bYAx6JqMdsDen
         v7HGaO/YccvH8c/HLljnlM4+txlwBI36zg3bpCgGjEgbf8yOBWWi1teBIjhnWAhIDek1
         iHdbG44zIMjbqqOJI1+ftFv+p9AcOdo1vuC2Ne83+CvRfOQ5ExoCwhixwOSASpI8VVNM
         8MOlOyXer07CsIFi25RC5RoYeVeXTIVMHfu3SNK9MpkdN4TS1ReELUGSA9MfKkreFdJj
         +MBK9bUlloxJRkBl5HidCvQ0qd8o/oqXX7XVPmi4D2yOWvyhbMWWsw1sZi66ifflmXE0
         vheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729355243; x=1729960043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ayyCub6qQl7nB8NfvKhUdob3RBjft3xPo4E//xagIW0=;
        b=IYvSjEl6t2l144g6qMRsX3CYZfdQmkUKoLYukImRMx3leNV0l28wZcoieSdSVL4RHY
         LjbDeAVgfrhetL1WrR+Ji7g3PDzAProxk/bGJ6kjsG1ZHG8RjSN8hiRR4FuWSnSZ4HVB
         Hy9FudoJgwT06UBrdYfYSfggDQs0uih+BYVv2zZDiSFNmqCDDD+5+PuimkyrOYXl6p8t
         ps/B3VV0GN58NXIqZXzHpfgNMjBzf+0y2KJe/ri5saOycg/yx7w5L1baaX88v2dpHVCp
         cASwbNXaU8FqOhKrVQ0D35ZWgTIwXe0aS4AXSnkbUBhZn+/vFiRqSa+L0Q2QbKWfLKJm
         pckQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsqdxmdHMi17ZCu3Mt0YhxYhD7BYjqwifYMSwxSstH94Kyen4MH5jHM82DvifwpqgNtdNMK0FA11MHRi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC4UdjhD2pWLURDUxulNdGVUuv1ka6XDjDJl0YQ1td1pqsB4BF
	1uiKvS2U9zh/kkOvCZ6JXUQ1ce1Gs3Hh5bwzw3wXcBNcXb9xmM2M9SHeAIrFphI=
X-Google-Smtp-Source: AGHT+IGRiLKGL85dRLzDgmFfmI4bKce+qOy+rBWCEkJrRSeKD6oaU3345MPGRp8gkNXz5lOalMXPMQ==
X-Received: by 2002:a17:903:32cb:b0:20c:9da6:65af with SMTP id d9443c01a7336-20e5a9581d1mr88430965ad.57.1729355243177;
        Sat, 19 Oct 2024 09:27:23 -0700 (PDT)
Received: from localhost.localdomain ([2a11:3:200::30df])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a8de4bdsm29567625ad.180.2024.10.19.09.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 09:27:22 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	rafal@milecki.pl
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Michael Zhu <michael.zhu@starfivetech.com>,
	Drew Fustini <drew@beagleboard.org>,
	Alexandru Stan <ams@frame.work>,
	Daniel Schaefer <dhs@frame.work>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sandie Cao <sandie.cao@deepcomputing.io>,
	Yuning Liang <yuning.liang@deepcomputing.io>,
	Huiming Qiu <huiming.qiu@deepcomputing.io>,
	Alex Elder <elder@riscstar.com>,
	linux@frame.work,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Guodong Xu <guodong@riscstar.com>
Subject: [PATCH v4 1/3] dt-bindings: vendor: add deepcomputing
Date: Sun, 20 Oct 2024 00:26:03 +0800
Message-Id: <20241019162605.308475-2-guodong@riscstar.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241019162605.308475-1-guodong@riscstar.com>
References: <20241019162605.308475-1-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sandie Cao <sandie.cao@deepcomputing.io>

From: Sandie Cao <sandie.cao@deepcomputing.io>

Add "deepcomputing" to the Devicetree Vendor Prefix Registry.

Signed-off-by: Sandie Cao <sandie.cao@deepcomputing.io>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
[elder@riscstar.com: revised the description]
Signed-off-by: Alex Elder <elder@riscstar.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v4: Updated description
v3: Add Krzysztof's ack
v2: Add deepcomputing into Vendor Prefix Registery

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index b320a39de7fe..f8bb3df65797 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -356,6 +356,8 @@ patternProperties:
     description: DataImage, Inc.
   "^davicom,.*":
     description: DAVICOM Semiconductor, Inc.
+  "^deepcomputing,.*":
+    description: DeepComputing (HK) Limited
   "^dell,.*":
     description: Dell Inc.
   "^delta,.*":
-- 
2.34.1


