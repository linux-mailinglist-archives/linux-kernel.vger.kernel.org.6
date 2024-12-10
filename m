Return-Path: <linux-kernel+bounces-440293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F4A9EBB61
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACE331882447
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132B322FAC6;
	Tue, 10 Dec 2024 20:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="glNcMj6U"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55A222B5A2;
	Tue, 10 Dec 2024 20:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864393; cv=none; b=pERN34jMbTotkPiQuAlcSgRK1J6BMmFih3g4wWWQT9Um+P7EE/XOaPfSZyy8Xg404pvR7HLV+v3f4qlSogh5SUXdZp/pFDe8RhmaqPbsomK6xbnKb5C1aOn7uXUkJbK6fX5uANMSYvTkyoICAvtf3L4oEUnOLII7rVMIaAP5DtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864393; c=relaxed/simple;
	bh=EoUmufUTsV1oFLTehCr54a1tAbPnahD3EjcB8ZDVLXQ=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=CE9jHp2yUyw1DIbXK2rOt8+uudZ0Jqo3lYJG0O5Sl2ifd/+PhJ2Kg05K83kMH5wAz4jcUWc5fKtnbHmr7WfTABkFLV/gtISugrLiZA9YUe4K+9zhKKqUDm5/D2jelXTSYM9uGmU6F4anMOavOysTH1HegkuAw1njIiX4QCcAK2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=glNcMj6U; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BAKxWG52725724
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 14:59:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733864372;
	bh=hspGsLToU+Uxnl8VmeGRxJGohMt1dZP4uSVNRC8jvdo=;
	h=From:Subject:Date:To:CC;
	b=glNcMj6USt0Uvzd5esm+Q9ttuqOakcFhgUHZVyLi7orJACym7wQYBYzpZxzOoQe3m
	 cziUIH0wHuy8IhOs0tS37QOCy08MEL9f8D+zweBB+lT/7ynvC5ui+GYpHWDVXZHUQR
	 JVDozdDlKuAzuAfVI6lCapnOlTV8AK2YH4hslOyM=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BAKxWjB050702
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Dec 2024 14:59:32 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Dec 2024 14:59:31 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Dec 2024 14:59:31 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BAKxVA9042176;
	Tue, 10 Dec 2024 14:59:31 -0600
From: Bryan Brattlof <bb@ti.com>
Subject: [PATCH 0/2] arm64: dts: ti: remove extra GIC redistributor ranges
Date: Tue, 10 Dec 2024 14:59:23 -0600
Message-ID: <20241210-am62-gic-fixup-v1-0-758b4d5b4a0a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKurWGcC/x2MQQqAMAzAvjJ6tuCqDvQr4kFn1R6cY0MRxL9bP
 IaQPJA5CWfozAOJL8lyBAVbGPDbGFZGmZWBSqotlQ7H3RGu4nGR+4xY8cS2JXJEDWgUE6v4h/3
 wvh8qbRX9YAAAAA==
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bin Liu <b-liu@ti.com>,
        Bryan Brattlof
	<bb@ti.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=730; i=bb@ti.com;
 h=from:subject:message-id; bh=EoUmufUTsV1oFLTehCr54a1tAbPnahD3EjcB8ZDVLXQ=;
 b=owNCWmg5MUFZJlNZcz+9lQAAZP///nb75uU+/Q//Ddttc4d70/3/c/2tyfvffZrP//b5tv+wA
 RsbRD1PUAAANAaANDQMmjIaNAADIA0DQYI0AAYg0MQaA0MQD1HqaA09Qfqm2qHQGgMRoAxGgBia
 DQyMIBptEyABoAaNGmhk0HqGh6QA3pQ0BtTQaAZDQA0DoMjyRpkGgaDIxAyaaBoGmmQGCADCAA9
 QBoAGhpoMmgyYRoaMgA2o9INGgsXrg1YO7Bjr7vVgEJghigexkbKgFAmmiOD5Qo+KFGukUXpICU
 tItYCiKhXdiHm97xX2hRuY2r0ZOigSnCtMiHwmDgPVGZudyndKd/mS9ItKa0E7A3rCqcRo+jsG8
 SpCuK/9SxjyGbN2aReuZjxPQxE879It5RbVssR3ZNQIOLw3EqItHvjRqLL3JlwnP4RBHBw418uP
 9gAc7Nw6TKzAWMK7ACw220Ky+NOdb7xL6GNqnnuZeEmFE0ngMGxYXtG4dxjP1fA1WEbyMAbAaE1
 u+AY8hZn5+zRY1FX2TBwbiUZO2IZOyTF/Ddhy3hBJ47yX8Y020faB61kBFlRgapTZzP0PzezQkK
 9PPjZqiLv1CrIRCFIwCGxKfYPnF+u7Nrm4hPQpDdkr7ysDjwNImH6RYaCZBnOcmovk2rIiDw7bO
 CQj8gg/xdyRThQkHM/vZUA=
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello Everyone!

While debugging an unrelated issue Bin noticed we've accidentally 
defined the redistributor range for the GIC-500 two times on the AM62x 
and AM62Ax. 

This simple series removes the extra copy :)

Happy Hacking
~Bryan

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Bryan Brattlof (2):
      arm64: dts: ti: k3-am62: remove duplicate GICR reg
      arm64: dts: ti: k3-am62a: remove duplicate GICR reg

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi  | 1 -
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 1 -
 2 files changed, 2 deletions(-)
---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241206-am62-gic-fixup-3ebe19226225

Best regards,
-- 
Bryan Brattlof <bb@ti.com>


