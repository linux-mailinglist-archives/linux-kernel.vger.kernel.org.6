Return-Path: <linux-kernel+bounces-565420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC16A667D4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F1283AEDCC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 03:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE8C199384;
	Tue, 18 Mar 2025 03:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="VaZ3TPC1"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1F34C6D;
	Tue, 18 Mar 2025 03:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269980; cv=none; b=meA2H03/+adZhfxQymK7eVeQaDcImWwBAp6Fa2X4HY14pfGF1deDIpYB7YHAkx7nKPJyG6cahrawPI7Xu8Q0X5+jWiGnMAMZxZgk232DbBIexSEoP56++yeEw2NYk06KIEoyulaN5H0CkT+fe0TevJMvFLg+eJqORtPiolxhtY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269980; c=relaxed/simple;
	bh=bPEAqIxpKaobBUATW9iE3eEzgTdKlnZ0zjlNw1hBc1M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UitR5Njz9RwLbR8ICr3GmkIe9keyNZWqhk6qTNqjCf62azGWL7sXZOyNlhk4hiBnuv1qcO2kIqG+w2H8cfkqIqZM4vtfEvLjaUzPGtqoe8FnnCS7x8TAr+BJAu/cbFGEEp8BNXl4AArCYXxHyVYhgomzVCRQpYi4R/8iOAabZVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=VaZ3TPC1; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1742269975;
	bh=SvRJAaDgHbIHFA5oK4lJdy63x4y4uccxugO2Za8qYtw=; l=524;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=VaZ3TPC1ej/t71Xf5G/yVyVLaBT+cw2PE4j3IWN0bMIJJxm/di/YY3Pj4EYrz3dCN
	 bm5cuBGlus/HzuJ2VT8UOlVkWRk52mtg3QJmHgHPDgqSReX4svyOh+S8/Fm1Qm4nph
	 gSRxdnB3lslUnsE++wB68awsKt4ZJw0hdRL/2arhBoNcTK3hJq+sfVRfEciSzRGxSH
	 7RuUUVjhlwVpkGUshmcUoFjD1n0wSA5CkSxN68DSmFnRxWroKjOr6q13rW1ElEHdlo
	 BSC81NlmIj2AdmboLjChyVC/QfRhz8L9VFKzp2voXtOJsu6LozPpLjMWYCWSnGpJiP
	 l+T9VaMfablDg==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3810277:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Tue, 18 Mar 2025 11:52:50 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 18 Mar
 2025 11:52:49 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Tue, 18 Mar 2025 11:52:49 +0800
From: <cy_huang@richtek.com>
To: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
CC: Rob Herring <robh@kernel.org>, ChiYuan Huang <cy_huang@richtek.com>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 0/1] regulator: rtq2208: Fix incorrect code section
Date: Tue, 18 Mar 2025 11:53:53 +0800
Message-ID: <cover.1742269337.git.cy_huang@richtek.com>
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

ChiYuan Huang (1):
  regulator: dt-bindings: rtq2208: Mark fixed LDO VOUT property as
    deprecated

 .../devicetree/bindings/regulator/richtek,rtq2208.yaml         | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.34.1


