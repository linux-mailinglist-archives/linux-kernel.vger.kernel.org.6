Return-Path: <linux-kernel+bounces-180828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2680D8C73A3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE4471F23CC3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 09:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4ADC14375A;
	Thu, 16 May 2024 09:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="L5HriedW"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EF714373F;
	Thu, 16 May 2024 09:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715851263; cv=none; b=FYWlmJhKacaG4uyV/jFZ38Vyf4PFNzEfolllVXEjjwt+rFgv3dkI2bpL0r6G9N5F73dDYZp1eJnjiU7yCoEPH+ANvvEokCZ49o5oBmGU0AwiYoJJ4zqGIRMMKDIPZzij1qvTXrri5nZgO078bC5Pjpn/MdOz3lPHtHM3VpBKEYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715851263; c=relaxed/simple;
	bh=XlwCeV8/V0+4P0jpTgkNrjezccuBetoxNZ5LgQ5g7vY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eoux9Pk/rTkNR67KsEYjOwdccTd2lItxGQ+dMH5tfWu5j1gHXOz/igmlCU0KYiIQrZiGFQniR+T68xZ5DtvTKp6opFDQvra0Znzs5bZOgXC0QhhqvzitpT6Mie8JjrEaGi8FT+XczwCDf7GCPhl55H3frewGIzUwyAMaCxDZcdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=L5HriedW; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1715851253;
	bh=H1nMYqhB1lXnaxd5mJbcR9sdlPakcIeLK2tDP0tt5XI=; l=697;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=L5HriedW/+BwRMf9TNLdcHx3C0Rp92yNFlf8Fmqu8onblcHZqCu6sCXapuHLtMtok
	 MfXFF8o1BqOMpem1FK0acYoOpnQoM/98w26Ec20WcxV1AvxW0ZVRLcS1jJVtjYfqje
	 kqyGyjwY9keC1krtaXtuibRkCzPi8QZ7Q+4kiMbM6KhU0B0znWbqHMBcGYDIp28vZg
	 F3XDX76vgnHJxGYziA5Nf2CMgyEjVq9mjX0Fiw8kqS83ukU0mJqDoONNEgusldMhQn
	 Y3tuKbZ6zqVyAT4uychlI7LkilXe6aHnIPq0rZlBiA01+wgSb6cr991ChQD5+Aw7TC
	 Bg9SATwcjY8sg==
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3213203:0:AUTH_RELAY)
	(envelope-from <alina_yu@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Thu, 16 May 2024 17:20:37 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 May
 2024 17:20:37 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 16 May 2024 17:20:37 +0800
From: Alina Yu <alina_yu@richtek.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<alina_yu@richtek.com>, <cy_huang@richtek.com>
Subject: [PATCH 0/2] Add specified fixed LDO VOUT propery
Date: Thu, 16 May 2024 17:20:32 +0800
Message-ID: <cover.1715846612.git.alina_yu@richtek.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

There are two types of LDO VOUT: fixed voltage mode and adjustable voltage mode.

As the fixed voltage for the LDO is outside the range of the adjustable voltage mode,
the constraints for this scenario are not suitable to represent both modes.
Therefore, A property is added to specify the fixed LDO VOUT.

Alina Yu (2):
  regulator: rtq2208: Add fixed LDO VOUT property and check that matches
    the constraints
  regulator: dt-bindings: rtq2208: Add specified fixed LDO VOUT property

 .../devicetree/bindings/regulator/richtek,rtq2208.yaml        | 11 ++++++++++-
 drivers/regulator/rtq2208-regulator.c                         | 11 +++++++++--
 2 files changed, 19 insertions(+), 3 deletions(-)

-- 
2.7.4


