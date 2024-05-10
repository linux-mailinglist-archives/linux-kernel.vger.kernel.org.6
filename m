Return-Path: <linux-kernel+bounces-175757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B3D8C2481
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52771C23BDA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F1316F90E;
	Fri, 10 May 2024 12:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="iYOAOiha"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2902616E87D;
	Fri, 10 May 2024 12:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715342815; cv=none; b=skysa6huLjwPIttjdGnkhaAHc3ou23XTRV6EtdbRZHBOuyPfvIGEM9uXoNo0b/AzLFZYfakX3VlBiGD6h2LhuLntsdv4PrfpyAcGqdSNarlneeHVYqWZ/oXc6tspenLZDxPZAxcZbY/X+o8KQCw2K6TOaOOrvnuGIpbi8aREfdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715342815; c=relaxed/simple;
	bh=6+mjEp9JC8DJZoFC2C430QAOpkPj8rkwIDseOCLsJlo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I56BLnOIuAfkxY7pwyLwNLbUTEbrW6WhS+2GEcV0QgQkl1g4G/JjYEIVV8427n3wvZ3wHGrcIpB33tpex1BVr+DmCjTnakDaplmMnFdExREuiaeATNNwcfysDvil57AAYhF+in8/R8QB9DcS3+8lFCbWrLVwYVljJcWFGwx1wTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=iYOAOiha; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1715342805;
	bh=kYe9ZI1AYvspxxfDG+XfuzgrrM/o/IJU8D7L1/2gLHw=; l=1571;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=iYOAOihaRt8jcYPDhhrv7tzeEsC2PGddfjDwC7Oi5t0bGSnDx5/H3s36/YfYJDvI2
	 Iegan8bibnAnpqpzh2kmtXa65FMxmmfcBPo/uBx/TzF0TlQALy3rXG5n5SNAQ3pduT
	 XfePqs3HGIVw3qoESh9zrxEieXQu2hxamZk63tAwT+qCdC6EZKz2B6sGeLwfevHkr/
	 VZXNJqMa8awD+p7y+NHVeURgMl0MGchNmAZz+e/M0KL4WQ3ZQKrzL2JMccrWERcRWX
	 tQSHMi/5ShSXu5GxCnBJeiaGaj4e6exNnzTvq0uFtlNuTROvfE4O0sVZd2FBL7vl2a
	 LvtavEO8phpYQ==
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3213220:0:AUTH_RELAY)
	(envelope-from <alina_yu@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Fri, 10 May 2024 20:06:28 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 May
 2024 20:06:28 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 10 May 2024 20:06:28 +0800
From: Alina Yu <alina_yu@richtek.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<alina_yu@richtek.com>, <johnny_lai@richtek.com>, <cy_huang@richtek.com>
Subject: [PATCH v3 0/6] Fix rtq2208 BUCK ramp_delay and LDO dvs setting
Date: Fri, 10 May 2024 20:06:19 +0800
Message-ID: <cover.1715340537.git.alina_yu@richtek.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

This series patches is for hardware modification of RTQ2208.
ramp_delay range of BUCK is changed.
The maximum ramp up and down range of BUCK are shorten
 from 64mVstep/us to 16mVstep/us.
The LDO's Vout is adjustable if the hardware setting allow it,
and it can be set either 1800mv or 3300mv.
Additionally, the discharge register has been moved to another position.
In this version, a software bug has been fixed.
rtq2208_ldo_match is no longer a local variable.

Thanks,
Alina yu
---
Change in v3:
- In Patch 1/2:
	- As discussing in v2 series, 
	  add 'richtek,fixed-microvolt' property to specify the fixed voltage
- In Patch 2/2:
	- Move Fixes to the start of the series
	- Seperate LDO vsel and discharge change to seperate patches
	- Add "richtek,fixed-microvolt" to specify LDO fixed voltage
	- Check specified desc->fixed_uV matches with constraints->min_uV and constraints->max_uV
---
Alina Yu (6):
  regulator: rtq2208: Fix invalid memory access when
    devm_of_regulator_put_matches is called
  regulator: rtq2208: Fix LDO vsel setting
  regulator: rtq2208: Fix LDO discharge register
  regulator: rtq2208: Fix the BUCK ramp_delay range to maximum of
    16mVstep/us
  regulator: rtq2208: Fix LDO to be compatible with both fixed and
    adjustable vout
  regulator: dt-bindings: rtq2208: Add property to get ldo of RTQ2208 is
    adjustable or not

 .../bindings/regulator/richtek,rtq2208.yaml        |   8 ++
 drivers/regulator/rtq2208-regulator.c              | 151 ++++++++++++++-------
 2 files changed, 110 insertions(+), 49 deletions(-)

-- 
2.7.4


