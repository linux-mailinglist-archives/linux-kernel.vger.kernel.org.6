Return-Path: <linux-kernel+bounces-216389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DAE909EC0
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 19:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FCDF282266
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 17:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF0729428;
	Sun, 16 Jun 2024 17:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="reYC1Q4T"
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D78C12E7E;
	Sun, 16 Jun 2024 17:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718558774; cv=none; b=kPdKJbL9C6xwGRX6KNLYsJBYEd7dtpLJ6f7V24QESV/RblKkGniNzF1SWJh2FyXzc8nFAMbF3pPC7oPqu0d+k840s0D18XzLFMnzy0KPUaPEDuPs9uBvo0I2PbQu0zdMG8xZIkwyTnZtYxjmbTz2BysvTDOb49Ss020vJD24t+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718558774; c=relaxed/simple;
	bh=QQWOAUzwSp+mXhYiVnbjgocJ2Y66St3+fremKcbnsck=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=FFj4v+12xq2TmTXPLoH25q4USn6fMgPXuvCAoCrozmxrA+swAZK9blc+xMB6XOXzCaLL8EV31+xHqbaHdMBb8g9PJcZWvM8JKzMqiolgKSyhPh/opLRranoPQ3hwRUL+wq1rGVHpHI44jUWNdoCCTlUon4Il9eamNfCBnSkGMH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=reYC1Q4T; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718558468; bh=rHBnmN7B3Rsy6U0sdX6GONr0sHeg0xxsndGVLxSaSz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=reYC1Q4TxC+bMuVQwT2iJpnKQLRX15ozurPWqHGMXnXoZ5Jer6yf4fPe6wunhunhe
	 8fDvSlAxkJH/HxaM5AK/6IBilPC7YAn6tTTShBiJTBftfFbA/wtEPap/Fct+VVS3+3
	 12rcKDm67wUCLsbtVHAPvfa+QKv8v4hlGZqw7f1I=
Received: from cyy-pc.lan ([240e:379:2260:ed00:cd33:e8cf:d8f9:bed3])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 5452D659; Mon, 17 Jun 2024 01:21:05 +0800
X-QQ-mid: xmsmtpt1718558465thebog8nn
Message-ID: <tencent_24CA6BAF3BB2E3A6C490854834FAF2E1080A@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvTkApgb/ZmacDt+n2nnKZ5gONX++ZB/fMyIH4nOmO36lm9btTCFA
	 +AP1KeGstFEFJptBLGJCqOWDHeHuRKMVyK2PfACMfb4o5X0hY6w0JENfj0SBjf8+loGngpmsRTIz
	 X5lN3l/pxo4QsWsTW008mcyGhV4fNhRcCVRzNi22sKpceajR73nAEpR0kJJldJke+EtzVRvmbzAU
	 0a+S8yqeIruRemjB5ahJFyfkGqSHTmLq/5ZAVJ2drS9WDRJDoxAaWUPBxwjcA8++MbLPg6yOU4F9
	 oycOPMzsa0W0Yd/h47UlIw0NsdsNgi0t9ECZeH7NgVv/s1/VZadyZTbZbCaU4U96X6Js13AOgp0y
	 mfuuV+fY9SGDP30Fae+SQSBdYhJLTAWlhglPgGRV2wLaPXLjULgNo/KLbCThT3Z1mDRNglnGljsa
	 GcFkb9t7psh/4d/wjoeoRclrrlx4oqFpAsAs2XLB4tDdZM86BryxrkVEja/zWkMrS0bItg8kJEXg
	 r7Ip3Mwjz1dcNeVH7jAl0zb1OhUCPWoxpl6uryn3x/NtZKRFqc/0LkHpADJOEmE50xHONxvd8ypT
	 Z5+FvUuihJQCk5fLqt9HU4UmIVrKuGhDMEyq3oriKqaPk5g0jShbyPQ7JlnUgTu6U0GEurxCMzmf
	 fl1ePeiTtiAYsCEyb/rdbz6baPvU8Y7+h4C3XQUlQ5WJI6fvH1SGzV97vYEWNkOj8x/3PXDxyabi
	 bSfZQvwC9cNMl7rO5pZhvGDHHU9PzEXbX5dY99hXtXpANwY5I/i7srJv4GQDFRwdXEYTYpEwj0NL
	 SAlfYIj2kTt9xKMZh1mThW5CntyNzHJPEbiPgQGnDLMnCkp3DEGl/BMaejt3y1DmeLFQk5JyexaH
	 bXai4hocnVon6iwSgA7fq93ZBIJj+/DoWvn36W90PlEwnrV+T6knezK0Pnrl3JI+pZMHLaAfkphR
	 ZHT2RwKNKIBax3q+ARP+jOOUY3BicMw8MiV/2S6HKTDsedzrlE0QK3GVG1+2BzWoLbSM8UYRVk9z
	 rcBAO58Vp1HHE0Pci65CsqeEGtH6g=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup.patel@wdc.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH v1 1/9] dt-bindings: vendor-prefixes: add spacemit
Date: Mon, 17 Jun 2024 01:20:46 +0800
X-OQ-MSGID: <20240616172054.3074948-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com>
References: <tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new vendor strings to dt bindings for SpacemiT K1 SoC.

Link: https://www.spacemit.com/en/spacemit-key-stone-2/

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index fbf47f0bacf1..7ee6e4a89376 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1362,6 +1362,8 @@ patternProperties:
     description: Sophgo Technology Inc.
   "^sourceparts,.*":
     description: Source Parts Inc.
+  "^spacemit,.*":
+    description: SpacemiT (Hangzhou) Technology Co. Ltd
   "^spansion,.*":
     description: Spansion Inc.
   "^sparkfun,.*":
-- 
2.45.1


