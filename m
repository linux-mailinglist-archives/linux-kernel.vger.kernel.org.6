Return-Path: <linux-kernel+bounces-336733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2085D983FFC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0C7D1F23E60
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A88D14BF9B;
	Tue, 24 Sep 2024 08:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deepcomputing-io.20200927.dkim.feishu.cn header.i=@deepcomputing-io.20200927.dkim.feishu.cn header.b="uNmGaYTq"
Received: from lf-1-20.ptr.blmpb.com (lf-1-20.ptr.blmpb.com [103.149.242.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1F814883F
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 08:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.149.242.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727165338; cv=none; b=Xe0eYpR55KqPhWufkbliB11+1RYOeefopMKshXb25pPFbgqU/tb0n69NcHoE5UN7HLAl2CgppfjF7YK0QniZSneCTFN6Efl4Lpc8I2Mh1cbdxZzCjTQ0oGNmTfGuYb46SRj128E5oJcOkj6VHuWE81IldVTkxStih8ptd5t9sBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727165338; c=relaxed/simple;
	bh=Jwg/VxDBpz9Eh5EMmXdQ5ngAAoQm03jMY7e4YlUGtuc=;
	h=To:From:Date:Message-Id:Cc:Subject:Content-Type:Mime-Version; b=ZdN7QJ+Cd9mV+9gAQW2CPc/Jk3b4oYp5wAvFcxaoq7hNvo2LP70S/wXmpjNJIN81SMvITKzXvYboQeTU/ZgY8l4jDXN+RvRUKSxUb252rzsv8g8nuyinyn+XI5xbT2KHfdKGPAW0zBtSqidYTWC5zqGj8GdnEHSssIxrC3oD8lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepcomputing.io; spf=pass smtp.mailfrom=deepcomputing.io; dkim=pass (2048-bit key) header.d=deepcomputing-io.20200927.dkim.feishu.cn header.i=@deepcomputing-io.20200927.dkim.feishu.cn header.b=uNmGaYTq; arc=none smtp.client-ip=103.149.242.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepcomputing.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepcomputing.io
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=deepcomputing-io.20200927.dkim.feishu.cn; t=1727165242;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=n4FlAamSfqVt7limHNsws50tZuvmPfsWIXOGbBiq7G8=;
 b=uNmGaYTqp79rjXBU1Ek0/0V+x6R2P+forSk2/Uvf68Fs4fbqQ37H+bHYWZ4IVA0eMN1stU
 xhjllKkfWgFo4LCCGG8b+9O2lthmtJ7jgSmo9crUW9bdl+DyTXXdKEXZ4k+fMU2v5CYxed
 2PuGUdkhqlxV2XsL2gX2Gb8g2PlEJrIcIdsIN0wTfbqh8ubrHtfJDt1vhci1M3RnYBziHS
 93s0gHOY79GwLVgWQXUGl6qXHFHnXzE/5I6YB7jqxrz04tOtT5EUfN3YiUZxWDQpiK2AZU
 ap6d0Kh7M9PLhUiDHq2x7bj4QpXE7sOTjJyBdtwB4why7W9pXcfZbzpdHEYNRQ==
To: "Conor Dooley" <conor@kernel.org>
From: "Sandie Cao" <sandie.cao@deepcomputing.io>
Date: Tue, 24 Sep 2024 16:06:48 +0800
Message-Id: <20240924080650.1345485-2-sandie.cao@deepcomputing.io>
X-Mailer: git-send-email 2.34.1
Cc: "Emil Renner Berthing" <kernel@esmil.dk>, 
	"Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Paul Walmsley" <paul.walmsley@sifive.com>, 
	"Palmer Dabbelt" <palmer@dabbelt.com>, 
	"Albert Ou" <aou@eecs.berkeley.edu>, 
	"Heiko Stuebner" <heiko.stuebner@cherry.de>, 
	"Neil Armstrong" <neil.armstrong@linaro.org>, <rafal@milecki.pl>, 
	"Linus Walleij" <linus.walleij@linaro.org>, 
	"Michael Zhu" <michael.zhu@starfivetech.com>, 
	"Drew Fustini" <drew@beagleboard.org>, <linux-riscv@lists.infradead.org>, 
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<dhs@frame.work>, <ams@frame.work>, <gregkh@linuxfoundation.org>, 
	<yuning.liang@deepcomputing.io>, <huiming.qiu@deepcomputing.io>, 
	"Sandie Cao" <sandie.cao@deepcomputing.io>
X-Original-From: Sandie Cao <sandie.cao@deepcomputing.io>
Subject: [patch v2 1/3] dt-bindings: vendor: add deepcomputing
Received: from roma-MacBookPro.. ([61.141.249.39]) by smtp.feishu.cn with ESMTPS; Tue, 24 Sep 2024 16:07:21 +0800
X-Lms-Return-Path: <lba+266f2733a+730aeb+vger.kernel.org+sandie.cao@deepcomputing.io>
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

Add deepcomputing into vendor list.

Signed-off-by: Sandie Cao <sandie.cao@deepcomputing.io>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 56d180f9c1cc..7803b53e9a6a 100644
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

