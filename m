Return-Path: <linux-kernel+bounces-397874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 556919BE1B6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B5EE284DE0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341781D278C;
	Wed,  6 Nov 2024 09:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="IGzUdAu1"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D0F18FC84;
	Wed,  6 Nov 2024 09:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883836; cv=none; b=dx4A4lgIngy6YkowqT5eRNc+I1pZogOl34QBqnObFCe51RAPpzMNNl2bWxT/q4d0CzJMBEmfgs5q6fKfMh5vfapv27t1mlzcfkYpfhuJsmb4fYTat+Gf5EfHO1R2Sn5nKHQKbKPqXG2oia4D95xpEZ1+mW7Ahg80+x5igiZ0DRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883836; c=relaxed/simple;
	bh=ztxE4NSbCmjiZt8i8woJAeA3it/1haWcd9DNATUvUhQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nWbVSu5gtXm4vcPNT/TmQW3DXHL1l2QzAovp422Fh8caxSx6qOhjAB4oYuTnmHFNhyYNHIPJH8l/K4+lzjef29NQfrN3g/FZlMJxJzAOhsArI7bXE95Yb2rFa95y5W66DglF7bZ3bKzoDQlS8I4wdhq8dsom1aSszSEhI7Vg3ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=IGzUdAu1; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A684EBr019802;
	Wed, 6 Nov 2024 04:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=ruKtDElrWyopR/DePhSmXmKFnFK
	XDIly+ZUFwrV2vnI=; b=IGzUdAu1o6x7MJI3Ohn7VEmkGesGjBY7agCRLgwIFud
	UuPzBQJRbVIxMEnl8t6ATyJftDs4GdTR1NXsLKHJkcqcq3qbMn24bOeSXTxLRbfo
	EkNCZAVyfcaWr7NnU0BLuXSKF4ZDw5P8eGWticmeCeC3Hj4p2EZ4o+gpWX/GbPAj
	5/14dM0lBT4Trk2zIKBzBCmXHmg6RIRUR8Koz942ePMpISK294/kTOD72jJnHOFq
	d5w+20ztanT3rUGtyvaFwwvP348LnWpScKussnuUsETQdwIUVaE2plIY/Wm7DprD
	g+vDD6SqPh4ENHn0nonFi0m77LWP+5wqttwgFnrJ7Mg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 42qbq36kdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 04:03:35 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4A693YAI025325
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 6 Nov 2024 04:03:34 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 6 Nov 2024
 04:03:34 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 6 Nov 2024 04:03:34 -0500
Received: from ATORRENO-L02.ad.analog.com (ATORRENO-L02.ad.analog.com [10.116.44.137])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4A693GTC006260;
	Wed, 6 Nov 2024 04:03:19 -0500
From: Alexis Cezar Torreno <alexisczezar.torreno@analog.com>
To: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
CC: Radu Sabau <radu.sabau@analog.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>,
        Alexis Cezar Torreno
	<alexisczezar.torreno@analog.com>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 0/2] Add support for ADP1051 and ADP1055
Date: Wed, 6 Nov 2024 17:03:09 +0800
Message-ID: <20241106090311.17536-1-alexisczezar.torreno@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: EGLB0SEITGQpCJZHxySUHyvThBDdcHqB
X-Proofpoint-GUID: EGLB0SEITGQpCJZHxySUHyvThBDdcHqB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1011
 mlxlogscore=999 impostorscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060073

The ADP1051, and ADP1055 have 6 PWM for individual monitoring. ADP1051
can monitor input/output voltages, input/output currents, and temperature.
ADP1055 is similar and can also monitor power.

Alexis Cezar Torreno (2):
  dt-bindings: hwmon: (pmbus/adp1050): Support adp1051 and adp1055: add
    bindings.
  hwmon: (pmbus/adp1050): Support adp1051 and adp1055

 .../bindings/hwmon/pmbus/adi,adp1050.yaml     | 12 ++++-
 Documentation/hwmon/adp1050.rst               | 52 +++++++++++++++++--
 drivers/hwmon/pmbus/adp1050.c                 | 44 ++++++++++++++--
 3 files changed, 98 insertions(+), 10 deletions(-)


base-commit: aa8cbc0898902070f1ad093a6e036cf57f0d47bc
-- 
2.34.1


