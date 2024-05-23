Return-Path: <linux-kernel+bounces-188061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 930158CDC6B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 23:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C012D1C23E53
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 21:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9E7127E36;
	Thu, 23 May 2024 21:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="qUmKP9dW"
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E8A23767
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 21:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716501348; cv=none; b=sAyJkShOl8bfS/jmSHZyKNl4Gep69el8e2rML/kudnJs2SKkC90XqFnpQvMs7cMJuCEQcB5c+GZ21nRCKcE6Hy0HPUKJVlQ/d7T0qAwlpGKER3NFlax1pfwFMG/LNX9KlkcE5uwXeMftZLL6TUiyYO9D7DBpJPEVU7xkeeaOvD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716501348; c=relaxed/simple;
	bh=HepCCdqpNeY88tgyPRPIsGR9QS/8cBw6fjssjikzE8k=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=mVx5gDAtqLt/kaNypKf3R+sH5Y58i+bHnPGv/nX2Pc5YqYhwMtx07ZcMxOlRCEDin3rZj9lbw0buV7FuZw8vhDh3FJhI/P9ATibVhvmp4f+nMvmlmdnx4NAuUFCjDoOsPGORxfbD1aN4emyamHwzk469g8iSqoxOP3T1IoaWEKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=qUmKP9dW; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1716501338; x=1716760538;
	bh=NlkCD1YeDey8XK4H0sKSuWFZIS4qqNXsdyugi3rH1OQ=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=qUmKP9dWeKWsQdfNRD7jVq37mIWJAzHdpA53M7WlYTc1dIaISRTMrUEOdMfWbz0ZE
	 SfUmdRu/Nmv5fvbz+9dKMi2fUqnKsnhdS9kfIVWVpE3lShjWCN7VFtfiXxprEslKmy
	 497tWnyeazf51RtHV4DPweKTRtK88jMffB+9GvotNIpQ9y3+gybPXJIELBxtRtOCxj
	 uQVPzR8+4E2p4gyTMn4EDu+HAofzJNu6JICf8wlH5Z3u5Fu3ye9oRwLlD4vBGiIm66
	 8u5lovuJdsh6u3aW3sZ+kWgPrJGZo1XzIF8ivJSMYpM0WazCfsPpreiVqp6TuS4qnr
	 KxKqEDdKOsaWw==
Date: Thu, 23 May 2024 21:55:37 +0000
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Michael Zhu <michael.zhu@starfivetech.com>, Drew Fustini <drew@beagleboard.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Henry Bell <dmoo_dv@protonmail.com>
Subject: [PATCH 1/2 v2] RISC-V: add Star64 board devicetree
Message-ID: <sQqtfYJc5p5nCV1CUpJC_eti56gLvmhqfMv4DY-aojB0sCARXzXRBveErmAN0spUDzvux3m5LdcmU-i4BfNDCCckVQfHLpH1QakaXdpnXuo=@protonmail.com>
Feedback-ID: 106097379:user:proton
X-Pm-Message-ID: 4b2fa140ab72f66ba1fea9950c1e30f177e2fdf2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add star64,pine64 to JH7110 compatability

Signed-off-by: Henry Bell <dmoo_dv@protonmail.com>
---

Changes since v1:

- New Commit
---
 Documentation/devicetree/bindings/riscv/starfive.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml b/Docume=
ntation/devicetree/bindings/riscv/starfive.yaml
index b672f8521949..4d5c857b3cac 100644
--- a/Documentation/devicetree/bindings/riscv/starfive.yaml
+++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
@@ -27,6 +27,7 @@ properties:
       - items:
           - enum:
               - milkv,mars
+              - pine64,star64
               - starfive,visionfive-2-v1.2a
               - starfive,visionfive-2-v1.3b
           - const: starfive,jh7110
--=20
2.44.0



