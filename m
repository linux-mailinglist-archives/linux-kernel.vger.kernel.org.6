Return-Path: <linux-kernel+bounces-514480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2307FA35788
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C6716E0DD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573DB20D51F;
	Fri, 14 Feb 2025 06:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="NwMkfZw2"
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F3E20D4E9;
	Fri, 14 Feb 2025 06:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739516391; cv=none; b=Ms0TsL8TGmyRahDKVwvolwxCIWa+jYkTrtqYLx0WWrEp/pM5xWTy/pw/hZuZFaulMnqZoPF4kfwt3FcDikGBNb7JNcZjh+nwKokeQUCWlR8lc0X8CqdjJciepej68DntibTthTq389U0Dy//gU3nSmgal441LtQpGt9C7B+MeWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739516391; c=relaxed/simple;
	bh=37W0LWJ6xU1QXpbIIHdeaVc5yKidQlb6ktBx1dKmIHY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=up9cQhu/uAo8hPqgSsxHJyJhALxkGFa0n7Z4+Ea5irGEZpbJGmZ+YzVj8pVLSi8E+rhM5S2CGfYx57nfUOE65+Oc1qhHtfRY7oJ9gxczuAVKhymRdKSNSmURUazcMyw7J/CMb9k9gHI9tvUG5pV20ik8yukjMuGYKm7OCUEU4M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=NwMkfZw2; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DLUq1Z017100;
	Thu, 13 Feb 2025 22:59:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=B
	eS3gll7WobDpQxiIVo540nEKzgfS81Y5Wnj4CMunZA=; b=NwMkfZw2UGignPQm/
	CHqEJl/4PwlruQvJF4rsinpmubZSzPRRkK5lATQqdtd0psJdJoemsxIe86XC+ENz
	LPSRv6NoWJfGyZY2b3gfB9Wk6yrcjV+0VhaN3wt5gQkYM+kTnaIAOfWpBg2pKA1R
	VsLki4zvpXv5N3CyMtXmgQmI7F1JDMLqWM+tM80UcC2w8eqaMB9mI6O7E7OahWyp
	q1cjyIZd6/Kv0heyF5RcOqL/NFJnKLFHTuAK966b2RszX7O1vh/uMmA+meZsIyH+
	e4jEAhOue0DtnQZlUFqUyYcybdcC29QtvaP6K545Xq0at6RmLdZ+bYHegGManHQ+
	PDZEg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44srqh8wuj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 22:59:40 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 13 Feb 2025 22:58:44 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 13 Feb 2025 22:58:44 -0800
Received: from wd-ubuntu-24-04.marvell.com (wd-ubuntu-24-04.marvell.com [10.111.132.113])
	by maili.marvell.com (Postfix) with ESMTP id 55B233F7090;
	Thu, 13 Feb 2025 22:58:44 -0800 (PST)
From: Wilson Ding <dingwei@marvell.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <andrew@lunn.ch>, <gregory.clement@bootlin.com>,
        <sebastian.hesselbarth@gmail.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <p.zabel@pengutronix.de>,
        <salee@marvell.com>, <gakula@marvell.com>,
        Wilson Ding <dingwei@marvell.com>
Subject: [PATCH 0/4] Add Armada8K reset controller support
Date: Thu, 13 Feb 2025 22:58:29 -0800
Message-ID: <20250214065833.530276-2-dingwei@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250214065833.530276-1-dingwei@marvell.com>
References: <20250214065833.530276-1-dingwei@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: CD0fM0idsucZRPKOBqVih3KDNtMKKatk
X-Proofpoint-ORIG-GUID: CD0fM0idsucZRPKOBqVih3KDNtMKKatk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_02,2025-02-13_01,2024-11-22_01

Armada8K has one simple register for unit soft reset, which is part of
the system controller register area. The simple reset code doesn't
support register access via regmap for the syscon devices. This patch
series added new ops for reset line operation to make the simple reset
code compatible for syscon device. And add Armada8K support then.

Wilson Ding (4):
  reset: simple: Add syscon device compatible
  reset: simple: Add support for Armada8K reset controller
  dt-bindings: cp110: Document the reset controller
  arm64: dts: marvell: cp11x: Add reset controller node

 .../arm/marvell/cp110-system-controller.txt   |  32 +++++
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi |   6 +
 drivers/reset/reset-simple.c                  | 126 +++++++++++++++---
 include/linux/reset/reset-simple.h            |  11 ++
 4 files changed, 154 insertions(+), 21 deletions(-)

-- 
2.43.0


