Return-Path: <linux-kernel+bounces-558948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04507A5ED6F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47C7017AED7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A87D25FA31;
	Thu, 13 Mar 2025 07:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VnWbI+XS"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C1A4D8C8;
	Thu, 13 Mar 2025 07:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741852654; cv=none; b=VU2Pvway6T7HhZ6KyVWxqgDqI1NuJlOm7PQ9o/CryzjffMygOCKdfz6xjuL5YTQ5DFufVIhVa5XSJQah0ArWZUt/A46QdaQ1l7Qdl2NGSCSkk1w+FPryR3vu/pNFomaj0lHBlMcYLpJBXhjFEq7TfqVKQTBwzTu/FmkZNILBZg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741852654; c=relaxed/simple;
	bh=JR0e4Mkcrl8bOhfGYXfVynqu5N11irWI8rjmLJAwp38=;
	h=From:To:Cc:Subject:Date:Message-Id; b=natfgMs1UfOuy2z2PwPm9bQaUL4O4YPtW5M3xANbX6qFqr3GG3dovDoWtfmrwdkU3JL7oQPBywp6WCS8vK4/sMM4zPfdiGxt50TAXydP9ZPRmh9opL4N5ZRLHeF+YI0ShU2iRVV4zYVVTX/YtjIx21yktdR4hSSCnH6S8eDsCSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VnWbI+XS; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=CwJuzNXShT9dLFy7pm
	LGuVY8xzmytdLbrLVR90Z1Vrg=; b=VnWbI+XSupx3jffeEK6SdAFi6XvNF6694y
	Gu1z1PfKClKsy0Xh4aN5o92hCfET96G1EkQk5HTO7NSmCy+sahM3JnuB5GhWCNil
	/vb1AUlcgfiuIis0X7M2yn7ECs82rlYJB97e5fRgbkQbKYh5XSygcE3BiuVVRayy
	hEpsthN7k=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wA3ro3Ej9JnuFJhSQ--.1599S2;
	Thu, 13 Mar 2025 15:56:54 +0800 (CST)
From: Wenliang Yan <wenliang202407@163.com>
To: linux@roeck-us.net,
	jdelvare@suse.com,
	christophe.jaillet@wanadoo.fr
Cc: Wenliang Yan <wenliang202407@163.com>,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	corbet@lwn.net,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] hwmon:(ina238)Add support for SQ52206
Date: Thu, 13 Mar 2025 03:54:59 -0400
Message-Id: <20250313075501.5435-1-wenliang202407@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wA3ro3Ej9JnuFJhSQ--.1599S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr4fJrW8AFWxtr4xXFy5urg_yoW8tF4rpa
	93Crs8Wry5Cr17XrZIkF4I9r1ru3Z5JF18Ww1xJw1rZ3W5ZFy0v3y2kr4Fka1DtrZxZFZ0
	ya4IqF1SkF17ArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR_pn9UUUUU=
X-CM-SenderInfo: xzhqzxhdqjjiisuqlqqrwthudrp/1tbiMAcP02fShdLWxgAAsZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add support for Silergy i2c power monitor SQ52206 to the ina238
driver as those two are similar.

Signed-off-by: Wenliang Yan <wenliang202407@163.com>
---

Add new chip SQ52206, the datasheet depends on 
https://us1.silergy.com/cloud/index/uniqid/676b659b4a503
The password is fx6NEe.

Changes in v5:
- Add the description of change log in PATCH 0 and PATCH 2.
- Link to v4: https://lore.kernel.org/linux-hwmon/20250125030300.1230967-1-wenliang202407@163.com/

Changes in v4:
- Add 'Acked-by: Krzysztof Kozlowski' information to PATCH 1.

- Formatting adjustments have been made to ina2xx.c in PATCH 2.
Including:
1.Change 'sprintf()' in the 'energy1_input_show()' to 'sysfs_emit()'.
2.Move up the "enum ina238_ids chip" line in the 'ina238_probe()' to keep RCT style.
3.Remove the last comma when describing 'ina238_of_match[]' to keep the
format consistent with the 'i2c_device_id ina238_id[]' structure.
4.Change the '5bytes' in the description to '5 bytes'.

- Link to v3: https://lore.kernel.org/linux-hwmon/20250117082017.688212-1-wenliang202407@163.com/

Changes in v3:
- Add the description of the different features of SQ52206 in the ina2xx.yaml(PATCH 1).

- Change program logic errors in ina238.c(PATCH 2).
Including:
1.Change 'break' to 'return 0' after 'if (has_power_highest)'.
2.Add {} after 'if (chip == sq52206)' in 'ina238_probe(struct i2c_client *client)'.
3.Change 'data->config->has_energy ? NULL : ina238_groups' to 
'data->config->has_energy ? ina238_groups : NULL'

- Link to v2: https://lore.kernel.org/linux-hwmon/20250113035023.365697-1-wenliang202407@163.com/

Changes in v2:
- Explain why sq52206 compatibility has been added to ina2xx.yaml.

- addressed various review comments.

- Link to v1: https://lore.kernel.org/linux-hwmon/20241224063559.391061-1-wenliang202407@163.com/

Wenliang Yan (2):
  dt-bindings:Add SQ52206 to ina2xx devicetree bindings
  hwmon:(ina238)Add support for SQ52206

 .../devicetree/bindings/hwmon/ti,ina2xx.yaml  |   4 +
 Documentation/hwmon/ina238.rst                |  15 ++
 drivers/hwmon/ina238.c                        | 209 +++++++++++++++---
 3 files changed, 195 insertions(+), 33 deletions(-)

-- 
2.17.1


