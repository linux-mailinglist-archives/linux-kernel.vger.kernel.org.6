Return-Path: <linux-kernel+bounces-566019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3156AA67234
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37ABB19A56DC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23DA20A5D5;
	Tue, 18 Mar 2025 11:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="0hkQupLN"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98AF1F4E37;
	Tue, 18 Mar 2025 11:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742295989; cv=none; b=NWwfHXcW6ZDS1JgO01kRmE/HyGHMLOVt62xG4QtAyq5NTqBv7vj0O3exDZlr0BIdprga93vlEBuX21dNfxf45HPTGIxRV23RvWkqCthZH3FAJnD3K4oJqux3l7DOQm9VYqCxNMm0MXqhdlV09I2A0hP0eP6DV3tBGsp1Ba7lu5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742295989; c=relaxed/simple;
	bh=2NMZetfY8vWQs9ixhV/e0oE98Uu0W2HkAtBlSw1Q4Vk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gK/tCf+Lokal0a4swEXkejV5ZalEX9peEQD9rlwN33ZS3YnVJlngVxjZcAOF8QMKj38RYZJPnwVYbR3JL9DZDRvRHx10lELahdCbS8nFb2v4MD7Hon1/92mgm95i/ssn340p8EmglwEKWdkEf72sjGCra+TMKkDQN1d7/lP0y20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=0hkQupLN; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1742295978;
	bh=f37X57Ygtgqdd8yKUdsVaQaLmb/UNUhziIon4nhIh30=; l=578;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=0hkQupLNOOOTKeraiISXpyLpsotdW1BF0Bc5wz9mC2d8WmP5XahZ5USJN/kplR7z+
	 LQg2xAvq8+DfqP14TKX3L9l33DRZLMsiRUQnuHR0s4QOfrtkOeB5mVKohPldcpkb1T
	 KBnkJrU7E7bPjdXUrWRCkBEAm9f/dlUGHRLIi8+ZXmAiy+S5AmOgRyePaq+bh2JCXW
	 bEssSQhaxJJ6tsrOyLYPmf6bq9gq+BfuwGPW3pRgAFxZdsuVJCC+tHBocGhwlFktQe
	 fGL2WQIH+0FCmRkOKey0pPX2bvxBftBe+DUOMK1S1zaK5tZagsqaOhBhtdvKjE0Pd7
	 1E4qs5nMQTKEg==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3810286:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Tue, 18 Mar 2025 19:06:00 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 18 Mar
 2025 19:06:00 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Tue, 18 Mar 2025 19:06:00 +0800
From: <cy_huang@richtek.com>
To: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
CC: ChiYuan Huang <cy_huang@richtek.com>, Rob Herring <robh@kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 0/2] regulator: rtq2208: Fix incorrect code section
Date: Tue, 18 Mar 2025 19:07:03 +0800
Message-ID: <cover.1742295647.git.cy_huang@richtek.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: ChiYuan Huang <cy_huang@richtek.com>

The old v1 series are here for the reference
https://lore.kernel.org/lkml/cover.1742204502.git.cy_huang@richtek.com/

Since the subset of v1 patch series are accepted, there's only one
document change are left and still need to be reviewed.

ChiYuan Huang (2):
  regulator: dt-bindings: rtq2208: Mark fixed LDO VOUT property as
    deprecated
  regulator: dt-bindings: rtq2208: Cleanup whitespace

 .../devicetree/bindings/regulator/richtek,rtq2208.yaml         | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.34.1


