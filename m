Return-Path: <linux-kernel+bounces-254093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD601932EC6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826251F23418
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 16:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E45119FA7E;
	Tue, 16 Jul 2024 16:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxWJirFa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51F417CA0E;
	Tue, 16 Jul 2024 16:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721149103; cv=none; b=EMBC1mZg1S7XMWdx5oq/jNKfDrT6U4inaw/4rG1EU/nd+bGgm3Hy1l9NG5CSlDgubuWTGCA0UNnfIlE8S18qy+MoKYTPXgv4lKme63wZ8TzsecLi+iypjQYwkkG73BccyRRXLdrwJIZIcHXFdTs2RSTkFOtxGrKmW765XW1EGhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721149103; c=relaxed/simple;
	bh=93hyIkgIDDXYRKPYLb1eE1CU46ivjzLvtL28cInJllk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XiYwevGEGoOh61mp8aEqv4IbagyMngHZ1tiFTGDBGyX8g1brTdM9j//fsMVEDvXPXz+BhGcMSb0NxFGbweUCoCE5rHrtU/U/gPunN8MeTdQNzQH6Z9Wk7fakNiQWLXXT1gKp6C1ofkCF8hQHlVrQyyTTbe9x9ArSvHW2+2/6k8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxWJirFa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D34EC116B1;
	Tue, 16 Jul 2024 16:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721149103;
	bh=93hyIkgIDDXYRKPYLb1eE1CU46ivjzLvtL28cInJllk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=lxWJirFav0Eq40RtsN9hzLBQCZZrIOBKPcVV5Y5uahVnYboZRkkrhUxiaYqtd9XGC
	 pKGYL6sVzEQ/+Qc2Bx6gbFKSsftSmBiW19wAztQBm4kXJHw0BrIxrxYdY1elhaC5tf
	 ZfFPYATsKRhziK64l3x7Bup7Se2timhMjcs3u3uD4Rs/T+5HuTRsP5XMYEuhRGsKL1
	 aUaW27RWN9MOscuo+JjLg7+dYVacMrWrzWl/N7KWF+lZqVEBCr0A6yhoD7S34rGO1e
	 WWGjZhedcfhG3KzYgfKQ126pf/JI4MyZteznKIhuDRRqhwZRvG4tS4Py6GyAl3tnwn
	 8oJ+O7O0LVGRg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35587C3DA59;
	Tue, 16 Jul 2024 16:58:23 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+Cryolitia.gmail.com@kernel.org>
Subject: [PATCH v2 0/2] hwmon: add GPD devices sensor driver
Date: Wed, 17 Jul 2024 00:58:06 +0800
Message-Id: <20240717-gpd_fan-v2-0-f7b7e6b9f21b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJ6mlmYC/2XMSwrCMBSF4a2UOzaSV5vqyH1IkZBXL9imJBKUk
 r0bO3X4Hw7fDtkldBmu3Q7JFcwY1xb81IGZ9RocQdsaOOWSKjaQsNmH1yvplRf0woUZRwntvSX
 n8X1I96n1jPkV0+eAC/ut/0ZhhBIhac+sVUzT4RYWjc+ziQtMtdYvbXdH2p4AAAA=
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Cryolitia PukNgae <Cryolitia@gmail.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>, 
 =?utf-8?q?Marcin_Str=C4=85gowski?= <marcin@stragowski.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1150;
 i=Cryolitia@gmail.com; h=from:subject:message-id;
 bh=93hyIkgIDDXYRKPYLb1eE1CU46ivjzLvtL28cInJllk=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0did012TXdNRm9GeXRlOUtlcjd5N2phY
 lVraHJScHkxWmZlTU9hdlVoTWc3TjNBZWVudTlON2lrNnFTT3hiClkyWndiaVhqckl6TFAxU2tP
 aG1OV1JnWU9SaGt4UlJaU2t4ek5VOTlML0FRck9GUWd4bkV5Z1F5aFlHTFV3QW0KY2p1T2c2SHJ
 wUGdOaTNWclEvelNFdFpaZW5PV3NiREpQZE9zbjZhZVhhSmJFcmNrNC9Udi9SbGErNExVdnJ5Yw
 prS3NlYzBYK0UvL3JMbmNHeG4rSDh2OTV5THlUbUo3L3JmL0dua0JkUFYrSHF3SVQyeVFDS2lZM
 nN4cDFmRnZwCjc4cTY0RTdoMzlmclBrKzQ2dEh3MDlOMmM1ZFoyNnhjc3hNYk93MFNxN3ozcHdU
 dmZGTVpvM3RHU1REMTQrTkgKdFp5aWRzTHErU0tIMmU5SjdWN1Z5QlVhc0c5WDc5dDBxZC9UMjl
 OQzVTWkdCS3haZGVwWjJWbVJHck5QOWZyNgpsV2V5dXFwMENsMkM5cGZ5emRuOXlQZkZSOE91M3
 NOMy94OW01ZG44Ym83bjFjUGJOTmZPUzdmOWZZdXpUcGJKCnZjN3BucnpkdnZNNzZ0cDlhNmI4O
 HVvSnlmajV4dUt5bWh5L2wzcDhVcFk0QUE9PQo9cDZFSAotLS0tLUVORCBQR1AgTUVTU0FHRS0t
 LS0tCg==
X-Developer-Key: i=Cryolitia@gmail.com; a=openpgp;
 fpr=1C3C6547538D7152310C0EEA84DD0C0130A54DF7
X-Endpoint-Received: by B4 Relay for Cryolitia@gmail.com/default with
 auth_id=186
X-Original-From: Cryolitia PukNgae <Cryolitia@gmail.com>
Reply-To: Cryolitia@gmail.com

Sensors driver for GPD Handhelds that expose fan reading and control via
hwmon sysfs.

Shenzhen GPD Technology Co., Ltd. manufactures a series of handheld
devices. This driver implements these functions through x86 port-mapped IO.
I have tested it on my device.

Tested-by: Marcin Strągowski <marcin@stragowski.com>
Signed-off-by: Cryolitia PukNgae <Cryolitia@gmail.com>

---
Changes in v2:
- Improved documentation, thanks to Randy Dunlap!
- Link to v1: https://lore.kernel.org/r/20240716-gpd_fan-v1-0-34051dd71a06@gmail.com

---
Cryolitia PukNgae (2):
      hwmon: add GPD devices sensor driver
      hwmon: document: add gpd-fan

 Documentation/hwmon/gpd-fan.rst |  69 ++++
 Documentation/hwmon/index.rst   |   1 +
 MAINTAINERS                     |   7 +
 drivers/hwmon/Kconfig           |  10 +
 drivers/hwmon/Makefile          |   1 +
 drivers/hwmon/gpd-fan.c         | 759 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 847 insertions(+)
---
base-commit: d67978318827d06f1c0fa4c31343a279e9df6fde
change-id: 20240716-gpd_fan-57f30923c884

Best regards,
-- 
Cryolitia PukNgae <Cryolitia@gmail.com>



