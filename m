Return-Path: <linux-kernel+bounces-199481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FE18D8799
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD0321F229A7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A455B1369B8;
	Mon,  3 Jun 2024 17:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LUw3hORR"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091C3132134
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717434336; cv=none; b=e4ya5yHzyJi8xo63ZIa4S+/8wbkC1XVvO9ZSvjb3cXy9IrFHzxPfN2/HtRlym8z/FOk/SZLYbZ3yNNqkZeD+af1Xo4ac/wXq1EzmID7+A2TzwM6DKN/3Zzop5Sd3/RcWX8AWroAWFx14s2rk+LzvhoCFaR8Pq8SR5Uca21HC1RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717434336; c=relaxed/simple;
	bh=L2jo/5Hj73JoI305gqvHKPo2V8KcpcWJiOmKGbj7G5g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TtHZ7nVUNu904dS/lniZOiV4TJsqdhDn8dvLDOUVMYq0lL0Gqzh3tRP6F+EGk/09hBQi1h2AsEXdohKnXLO7u1miylOPrmAfDQb9njesymhIwySmsRenScCMf3eRF/VMSJoLMvrSm73sJr0i9k5v+9xrP974n3HBOoQ861zim1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LUw3hORR; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 453H5Sn2081766;
	Mon, 3 Jun 2024 12:05:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717434328;
	bh=vJhypu+/5g2uqYXVGn4r2eB43UaGLT/5OFxyxwauQA8=;
	h=From:To:CC:Subject:Date;
	b=LUw3hORR89aRjwxq6Z6i9Hlqn1MzZTVHWkweYxuBG0X9iq4PRvpTNK5tMyHF2q7vu
	 40fvLGVaAij1Tm2+fxGQSuWDG6VJu7oo2+V9qKrxL+Q2lXO+yXdYxmlJ6+qI4EH54X
	 ivsnUk5QaZLFumYdJseJ/X0gCiIn/xInLCjwBDMU=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 453H5SY4009382
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Jun 2024 12:05:28 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 3
 Jun 2024 12:05:28 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 3 Jun 2024 12:05:28 -0500
Received: from shree-udc0509427.dhcp.ti.com (shree-udc0509427.dhcp.ti.com [128.247.29.227])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 453H5Sno103813;
	Mon, 3 Jun 2024 12:05:28 -0500
From: Shree Ramamoorthy <s-ramamoorthy@ti.com>
To: <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>
CC: <m-leonard@ti.com>, <u-kumar1@ti.com>, <n-francis@ti.com>,
        <bhargav.r@ltts.com>, <m.nirmaladevi@ltts.com>, <vigneshr@ti.com>,
        Shree
 Ramamoorthy <s-ramamoorthy@ti.com>
Subject: [PATCH v1 0/1] regulator: tps6594-regulator: Correct nr_types assignment
Date: Mon, 3 Jun 2024 12:05:23 -0500
Message-ID: <20240603170524.643010-1-s-ramamoorthy@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Correct nr_types assignment for TPS6594/3 and TPS65224 in probe().
Fixes: 00c8265 (regulator: tps6594-regulator: Add TI TPS65224 PMIC regulators)

Shree Ramamoorthy (1):
  Fix nr_types assignment for TPS6594/3 and TPS65224

 drivers/regulator/tps6594-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
Signed-off-by: Shree Ramamoorthy <s-ramamoorthy@ti.com>


