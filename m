Return-Path: <linux-kernel+bounces-191793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC438D1426
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEBF61F22D58
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 06:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A93A6CDC8;
	Tue, 28 May 2024 06:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="WnFlSAYE"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F81179A8;
	Tue, 28 May 2024 06:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716876094; cv=none; b=ByaFhTCet55bTrii96FgJ8JJXMpSKBE1tH8KvTNWf7lOwuBbwq5nxwmoyxTIJahLyUf8yl99ildANzhHbrGLsTSSHCG90bYmbLSqiOcJ9OONVa82/zRkW5UYxCkCpuaoABrb9V55b9ShP1tJGaVIDSzAUoCcemieaIW6Ty2ZI8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716876094; c=relaxed/simple;
	bh=2Jy4I0qc1/mV35P5no+GwNmOoVNmY6+6egXRyNB8H+U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ahUrE2V9DBTHoNCF00EzMPrZEy0KpBa9tDE5FNyrN1vjOpFxLYRXgB1VxheAnSS2hOD0Mm0pZTOkFdUFhYh5/zvmv/t1wJM/1ktBuZcMzF4aHG9XKSyLWmK9P+OSHR8wlqGQMvY0IQg6bhDZ3qBkf7wtrqWmq67RQnCyzLGzZbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=WnFlSAYE; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1716876089;
	bh=oABMiJF31Cx251LndpDAfIFu9Pm06ga03M9I0h/drF8=; l=1053;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=WnFlSAYEy45QrjvcmjfdaalGDfYhFVh+brk4QeNOuCvbA7RJJeqfRXIAAUFjYfN4U
	 CGw/d2fnHKPQqI5oMyC6RbzO6gHjihCsPo3P9W8cSk+5vum+jzLORweXfjqo1ZyL1b
	 w2xzvwXxkS8i1eUbbA5wBmplC1t/gO/bQqSbekXPxZ1fmlwuifznL7sFJVCAkTGm8N
	 HLK8XDR+v1jAL39yRdt8q1ixKsIBWq6++YWkGmOYEUHPQrYBpn2FJZ9Wn4d+sqlJbx
	 JzI89aYOnYU0DFYYDs/PjzHWmPYWpXAKA8ZMy0UwEpBajtvLWGBFA1bAlZ6QLA63l8
	 BrA9wVJ1u5jcQ==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3213200:0:AUTH_RELAY)
	(envelope-from <alina_yu@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Tue, 28 May 2024 14:01:19 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 14:01:18 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 28 May 2024 14:01:18 +0800
From: Alina Yu <alina_yu@richtek.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<alina_yu@richtek.com>, <cy_huang@richtek.com>
Subject: [RESEND 0/4] Fix issue when using devm_of_regulator_put_matches and add compatiblity for both fixed and adjustable LDO VOUT
Date: Tue, 28 May 2024 14:01:12 +0800
Message-ID: <cover.1716870419.git.alina_yu@richtek.com>
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

In this version, a software bug has been fixed.
rtq2208_ldo_match is no longer a local variable.
It prevents invalid memory access when devm_of_regulator_put_matches is called.

Alina Yu (4):
  regulator: rtq2208: Fix invalid memory access when
    devm_of_regulator_put_matches is called
  regulator: rtq2208: Fix LDO to be compatible with both fixed and
    adjustable vout
  regulator: rtq2208: Add fixed LDO VOUT property and check that matches
    the constraints
  regulator: dt-bindings: rtq2208: Add specified fixed LDO VOUT property

 .../bindings/regulator/richtek,rtq2208.yaml        | 11 +++-
 drivers/regulator/rtq2208-regulator.c              | 66 ++++++++++++++++------
 2 files changed, 60 insertions(+), 17 deletions(-)

-- 
2.7.4


