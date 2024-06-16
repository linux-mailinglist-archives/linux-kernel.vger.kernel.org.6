Return-Path: <linux-kernel+bounces-216385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4471909EB6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 19:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D1D28181C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 17:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335B229410;
	Sun, 16 Jun 2024 17:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="hwCv2avq"
Received: from out203-205-251-72.mail.qq.com (out203-205-251-72.mail.qq.com [203.205.251.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BF412E7E;
	Sun, 16 Jun 2024 17:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718558475; cv=none; b=e/jj6N2xsknd/QVDAVoYKh8b+VRRkLOd360fYq+TYPaAxYOvsLkGkRvK0q8pQ1YOoZHWnE4sXErEQcoZgq2L3iC9orhJNGiKYYV3XbUUfsHx9J+modn3BkQ1VMpeyIjz+ge6H+QwH/I/8HGMZgvjbwH6vizEABXtdWqkLrR4bB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718558475; c=relaxed/simple;
	bh=R6/CWhgZQl3gq7chGwL60f99+22K2ciRlGUkuOSJu24=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=En2JTxHA+Lm6UsEZP6i4N7u9Ayi5+ofKcT0/mOoqy4zLI5SndYNwXa0HOnBJob82rlGmqdIyQaw9sX4DXm8dBNcfH0tjO8mabdkm5JGx9rrcNwKl0bH705VRDk5kL9LwiC4KyYDbdljxUnAMmESplI8n2pyFjDEkgjD+aTj/stE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=hwCv2avq; arc=none smtp.client-ip=203.205.251.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718558470; bh=ceOFvkqQuF3BJBqg7HHuf2dRny50kltfLRyQrgbV5Jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hwCv2avquEdaRvbANtDMgwr4yR/6LCfpP94zlfwxGBhohIy8yfpWgCClG8sqbcsZR
	 xG1mUEr9BY3AmF9EgAQ5Kz1Uq26T94x3nA8/uLYknX+guNk9ks0oVvjedN+FNaABax
	 OJEYPfaL4wn7b/wmTQOkV6KysRt2X2W+sQrNEQSY=
Received: from cyy-pc.lan ([240e:379:2260:ed00:cd33:e8cf:d8f9:bed3])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 5452D659; Mon, 17 Jun 2024 01:21:05 +0800
X-QQ-mid: xmsmtpt1718558468tjw4ij1kg
Message-ID: <tencent_947689E304AE5A4C7A48682311DF8920B106@qq.com>
X-QQ-XMAILINFO: OKkKo7I1HxIeYsRDFAmm8SNIGgiuA3hspYtdkw9KJ2qpXlFjjasdXsdLmm6jdw
	 7yZH96i2B+zl8HYU5ArYhmY9X8f5uqPhq8AvPl0ZhdVEoHRrW782bG1ktVuaLwhIVzxw5J6kWqf1
	 HwSVYGE8RkY37yYhCbu8f7Ts6Fi/xvQSZ6XcnuPtLZ479UpvZVdmnlPT8N+TOU1p1OMe6kiOMH9Q
	 nZQqOOVIXxtwxcieAbp1J5Codyp44S2o5q42SJKDE6MrtuKTjqslBzdeYsK+UHTk82vbpN63UlpP
	 SO7So5P1OtvNcjJRyzFr5quXszph9bKkbum3vErCJInC+QvmPMzjAHZNDGKp8IICrfJBVm4kOAfX
	 VzI/vvApkXmgmixDXEGaL5WlkKaVnV2ovu37sCxfoxclaRS2hMGlK7npKLJIF1p7Pw5MuogERWz5
	 104DfLQrjqwwyYcSs2oR7m3UQ/FJA5nWTmqSUwvcjANSdP8gg4HgLm4fpSftzFvAsbn3Q4U89tEu
	 Z4G/7hI3ExXZnQGBrOWzkgv/0ytot5QNkyWCc43k2WQHQvXdHsd07hEoE7SlJoLyw2AStsdvqWxC
	 VLTPgR7UpNVuhO742Y6TNjltqwpK7l0dISX0Hausxkz7tsLzBpk1Y5+qyyOBHeT1PUlLY6GkGOoe
	 NVCUaES04CO9x8fekVlPeqLBfcrtNMWxYc9ylmFwdbDMVEhvo33cbpe2M3E0PzRsf3J4PwK8cQYh
	 z9vP//zBYvoCMjeQqAAlePXKPgW0oINy21J3QOgE4cUJ5i/XHRMktnsKpg/8X8sem5ui9WaTQqrI
	 7EFZlUfgpL8OYI30VRU2Rud8apbsclePYfgQrTtJqXjyb7iObxwHHX8MPKHSD6B2B/720/tUiaHu
	 hhcYW8Rrz3clx9WJutVKgKRzYVFz2eVpOEdbCzoooxDL9k3Rq7TgJMQGTDD8+b9vFGvcyUqPp6UG
	 u5Rxe4SPv3aVw7N/ORRLksGgAAaV6zWjvw0LDHbeViwe08AhLU43gPPpB9qEuqiEi+rOYrrdmPEW
	 UcuJQjh5dxumLtJBpyKoswi1xna/GIaiaTWlr5qw==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
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
Subject: [PATCH v1 2/9] dt-bindings: riscv: Add SpacemiT X60 compatibles
Date: Mon, 17 Jun 2024 01:20:47 +0800
X-OQ-MSGID: <20240616172054.3074948-2-cyy@cyyself.name>
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

The X60 is RISC-V CPU cores from SpacemiT and currently used in their K1
SoC.

Link: https://www.spacemit.com/en/spacemit-x60-core/

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index d87dd50f1a4b..5ad9cb410335 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -46,6 +46,7 @@ properties:
               - sifive,u7
               - sifive,u74
               - sifive,u74-mc
+              - spacemit,x60
               - thead,c906
               - thead,c910
               - thead,c920
-- 
2.45.1


