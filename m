Return-Path: <linux-kernel+bounces-373260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5699A5465
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 15:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4609B282D26
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 13:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E365A192D84;
	Sun, 20 Oct 2024 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="3CTkdRWA"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B86192B9E
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729432275; cv=none; b=J5MWnknV+wXkiRsWXspMMo+JUKjwWTgKLypOK7975TVUkJMovBsOYofvU6/wxkmv11bNItf6GuIzhzFTWDyNVHkv6NBuHCR9M1jsoCK9wHL3DWL6vLRbTji2S7vG7zjRcGjDEbVpbLIL9nnzUkBHhGjAjjy8/Cc9IILJ3IBINW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729432275; c=relaxed/simple;
	bh=JoWkKFBeo7yvxDdD9XCOEG7N5AMm357CJbsqOD/SrzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vDoKaF8KOKeIKngEnJItXhaSft+m3Zr/KhFcR80SmYmbjM97HL7lXxGE59Gkf00OByRWLwHU+ZQTD/ykFfsTbXSJAW67JauVVagHEW/oN25Dt98I0Lh6kba05nmPtBLUbEU3KJgjrig5Tw/y4yCAnNpe1qpyHrfbk0wCvU+pevc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=3CTkdRWA; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20caccadbeeso40231755ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 06:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1729432272; x=1730037072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mSKaigzCZh6DD67qUNYuh/ETwBUWDczHGXUVVmnZHc=;
        b=3CTkdRWATbCSrAdHGUha0qJ4zAzjyj3foEf2zUSehKQUc4SHCfU5Qc1B6gZVfLHczG
         coW4nEp/5wBFXv6mr5aCZpE4nnbrrU6Do5FKinrRa7GqaTGfMQyvn4sTrsp5Es/CGCnn
         IEd+5llT1bbcNFxJ8VVA4TqRZOjA6Mz4J9+VOK3SSbXA5sWq7S6WwCrOWfUUF0Twpul1
         HrSuC18cum/Cjp60yhOWSUmEiP0kMHD9hT3VFT25PyANs+oZKWqSb44cG+6/95d2KMLn
         jEK3oruoiln5zD/CkWnlxPD94LxxmYGmSo945hkNC6XFBZWvgGyiBXytPI7o7jSwUtBE
         /r9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729432272; x=1730037072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3mSKaigzCZh6DD67qUNYuh/ETwBUWDczHGXUVVmnZHc=;
        b=ls0ycMDFxUAYa2IBVMFBJJDugGcm48NhGlh92ne1jhl4g3HpkW5WTmc8Kpj7JJvo0A
         XOyTR2mzrpvcY12oUKDqAxMSme7fuvBArl+6Lq53SeUOYEmDRILjekCZjBR6re2uMdad
         3LupQ5xHwMW0dlmj3noXkgj7D6ctDLgZgDLe0j1Z71JlWDBveJ26R8ELSBfATaRJx5fa
         9hkwl9Bj486rz/m9XLUEwludYTL8N1wPIgWIZQHhe5zcZKNc+OUIRMOc88rSJP4wN+KC
         cFeeXBR8bMK0BFV5sbPctFVUdpoKtwOTxnbOubD1gB4ICPPG1lAXKrNdymHA0cdO79AC
         s63g==
X-Forwarded-Encrypted: i=1; AJvYcCXZMjNP8lb0KgNdZVlsDZU3W+19Q9bRkZ4pWV48z3akZTB9yjtHViX7+0w/5b94QBHDSeICcB0RYpzjkxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw8mnogu0PKEtOIa7T4FpEbS8sBLe5oNiRJcGs+/Qim+/Krn8v
	v6NXWZHBKORuIjuWnLHLnlY/FLZPC3KZojA/IlXal5TzxSYFzqkqOT+6wrwpYwY=
X-Google-Smtp-Source: AGHT+IHwDpd5QJfP6/APfYz9jCZn27fX4Z5ntBmC4Na1PFB7aUjCldslVEpY68xkxkDoxwfvRQa+2Q==
X-Received: by 2002:a17:902:e54c:b0:20b:7ed8:3978 with SMTP id d9443c01a7336-20e5a8fe8d5mr104601955ad.26.1729432272577;
        Sun, 20 Oct 2024 06:51:12 -0700 (PDT)
Received: from localhost.localdomain ([2a11:3:200::40df])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee63f0sm10554935ad.3.2024.10.20.06.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 06:51:11 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	rafal@milecki.pl,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Michael Zhu <michael.zhu@starfivetech.com>,
	Drew Fustini <drew@beagleboard.org>,
	Alexandru Stan <ams@frame.work>,
	Daniel Schaefer <dhs@frame.work>,
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
Subject: [PATCH v5 1/3] dt-bindings: vendor: add deepcomputing
Date: Sun, 20 Oct 2024 21:49:57 +0800
Message-Id: <20241020134959.519462-2-guodong@riscstar.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241020134959.519462-1-guodong@riscstar.com>
References: <20241020134959.519462-1-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sandie Cao <sandie.cao@deepcomputing.io>

Add "deepcomputing" to the Devicetree Vendor Prefix Registry.

Signed-off-by: Sandie Cao <sandie.cao@deepcomputing.io>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
[elder@riscstar.com: revised the description]
Signed-off-by: Alex Elder <elder@riscstar.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v5: Removed extra "From:" line in the commit message
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


