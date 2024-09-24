Return-Path: <linux-kernel+bounces-336728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E12983FF1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4C601C2271F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D5614BF85;
	Tue, 24 Sep 2024 08:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deepcomputing-io.20200927.dkim.feishu.cn header.i=@deepcomputing-io.20200927.dkim.feishu.cn header.b="CRG2h/L0"
Received: from va-2-40.ptr.blmpb.com (va-2-40.ptr.blmpb.com [209.127.231.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE6014A4DC
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 08:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727165265; cv=none; b=Z2oQfE6UFWI8cR8PtPXRw3xzj4YbJbqmO6SiaH10k6VAEhE62OBzCMN/MHpKAqNjfr5KhgvJJDpFzgL9aohwr6xOuzdBWpxwQ9cuTBG2qK+XxaBvuWQzdz3/c8O/RbM5OhfgKmhURY6fM/psGcYprhIxxyPigQFnACg+9DCM0E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727165265; c=relaxed/simple;
	bh=Jy4y33f822G6BldXT3sO4gcQyEV+/nl2+A3mQ/vQCiA=;
	h=Message-Id:Content-Type:To:Cc:From:Subject:Mime-Version:Date; b=s+nn4v4gNlN/+exW56Xe3pFB4Y9HKjBHszSvrjaagOIyGWVgIJXtClVJp9/D3u+Wzh/G/B+Zh4ri8/8E2pNOmv/sasHpcjQHYQm8TWrxRztOBZvC0mAq+dvuHLSIch3fb65HkyzCyST9iimLqTlAVR+lwLmMwsQrhvi6ts+9hHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepcomputing.io; spf=pass smtp.mailfrom=deepcomputing.io; dkim=pass (2048-bit key) header.d=deepcomputing-io.20200927.dkim.feishu.cn header.i=@deepcomputing-io.20200927.dkim.feishu.cn header.b=CRG2h/L0; arc=none smtp.client-ip=209.127.231.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepcomputing.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepcomputing.io
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=deepcomputing-io.20200927.dkim.feishu.cn; t=1727165246;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=oB/VU3FI/FnFWz9K+uig7hfrJEDRFlku8hT2eEzdBzo=;
 b=CRG2h/L0bBUN/UsrxJVVtSo/Xxa0sEFeDOtByr8dsb+ZK0TcO5qG3/7fLZWfCB9pjAL8sm
 qkEM2i2Hd/4uN2RfUZZ6s6kCRZjO80aZC8Ly59vRahQRR5+6hmC5e7md/B9Giy0R5Trver
 Mp2H9tlJwGX4CKNd+ZnVycirqJToOwQjib57yetnP8S3ns/LLpMA6Qhda1lsbYu0kNQkFP
 luE3yEoFlSS3oIIc4r0Hz/brctXK1G18U12jsRhd+6aX08rurG5RIO+Z+FXaE02QJXQ3gU
 vElY0XYyLyG+cfdsn6hAbitOhVwnfeCteFr15uKc2ALOF2QWbZmNjU6bD7CFKw==
Message-Id: <20240924080650.1345485-3-sandie.cao@deepcomputing.io>
X-Original-From: Sandie Cao <sandie.cao@deepcomputing.io>
Received: from roma-MacBookPro.. ([61.141.249.39]) by smtp.feishu.cn with ESMTPS; Tue, 24 Sep 2024 16:07:24 +0800
Content-Type: text/plain; charset=UTF-8
To: "Conor Dooley" <conor@kernel.org>
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
From: "Sandie Cao" <sandie.cao@deepcomputing.io>
Subject: [patch v2 2/3] dt-bindings: riscv: starfive: add deepcomputing,fm7110
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+266f2733d+691095+vger.kernel.org+sandie.cao@deepcomputing.io>
Date: Tue, 24 Sep 2024 16:06:49 +0800

Add deepcomputing,fm7110 into compatible list.

Signed-off-by: Sandie Cao <sandie.cao@deepcomputing.io>
---
 Documentation/devicetree/bindings/riscv/starfive.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml b/Documentation/devicetree/bindings/riscv/starfive.yaml
index 4d5c857b3cac..778617e1dc43 100644
--- a/Documentation/devicetree/bindings/riscv/starfive.yaml
+++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
@@ -26,6 +26,7 @@ properties:
 
       - items:
           - enum:
+              - deepcomputing,fm7110
               - milkv,mars
               - pine64,star64
               - starfive,visionfive-2-v1.2a
-- 
2.34.1

