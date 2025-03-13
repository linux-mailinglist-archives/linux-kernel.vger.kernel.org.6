Return-Path: <linux-kernel+bounces-559210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6A1A5F0EE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E6F19C1544
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C0F2641D4;
	Thu, 13 Mar 2025 10:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="UXwylS6m"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011025.outbound.protection.outlook.com [52.101.65.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40BC265CC5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741861883; cv=fail; b=X4BHUXhxRAbA57GQkfKNDuQlAcO7wMhA1UAEJECdYP+siz9w3LhtbQ+GU2vPDNLznzA4N1rgUXUb1I5JqLQAxsLq3qEsWnCTIejgoN/lGkzFhIn011bSeZ4g4xdmpKahH5ZME11PqrDm8Eix+nUnUbtC/A8jzXL0s8P6gQFA/aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741861883; c=relaxed/simple;
	bh=/NO0lWaEDpXhfor+vg6q67y1X644iA7OYQTfNeoTbjI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E9XVTfZaqM89wPyk1tcWjnQ3qSfwE1QzhZZId2+f6ofISe4WLbk3IJ01orQecyBrDCW9g5i2dkALZMUHRT45AFDnSJUdaFpWrK7ZR4ZcfAQxhnwhAuSHxZvICRD7mRuBhatwKXsTsnR7Q7gw45P4u8/GxWBYE6wIcgca5V0qvw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=UXwylS6m; arc=fail smtp.client-ip=52.101.65.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cBDcbJGxs+cJT7jZp9a4YFO9LBiI3JSFGU9Q6sGYp5kzKRjnomagxQQhjtaHXP+wD/L36+nlsymPaZdHFI5O2aiw+ia1FpsfYAxUsQwP0NhMP7pFF9wVmN8/GB4QTx8ZiB/UH/HWtsD1Lm8kwi2fHnOpdOSlf6uwJotzJekNjtfYu+lw8RkwrdDmI3LI0jQ/PTRfckejtRwD91syvD7YDxsR0/gmJRgrETw1s4CYzzb/yHZGvBjIc+tywNmEruDxh0JO2FJhit7JB8cT4DWhvs0aJE4shxYwQ5hquqsSZ3y/DBIDP6J8QfcrKHF4EkmHmsjM7iq00evV31LhW9Ft5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NO0lWaEDpXhfor+vg6q67y1X644iA7OYQTfNeoTbjI=;
 b=rXBm0WHJbrhYxrFaKPIsTrawawAI9OlTmSAl1tDvjWWAF3Ph/fWxA6lrsJ6b/Oa/q75Vz+eDrhCMVRpp/yAoP8CASE8yQFBvyL3lQMJ74Uhn4PPwx43NHKABtIGclfZUhGblQqqZroj6PYFZzovptq46A+cCuwPqHjZYAyGFHc5B6CpyDOK1vZdU/K67AKbkCuIUUm3pry87gg/+Rs9s2ZqXh+4TnVrGkEraR2YHRigq/9ehIfKo//P/nJd/zrrMnZN5iT5XxDjLd2Is64Zf8P3e/30lFgzr29NAABbZiH8w7RZgQbPYnKeGt5Qf3Xy1TPu1RPB7ExCFk67Mn0iUQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NO0lWaEDpXhfor+vg6q67y1X644iA7OYQTfNeoTbjI=;
 b=UXwylS6m4dCa3jUobFNs7g/aqbea8Z8aCIIqi2nFr4g4oOkLWqYv6DgbYqHNxYFhQLiZIvHXPY0WzGzMqhHGIPspMUJ9QVDRRch3wvF6Z/ILcKcTorxOdXD6EVa89s/Hs0+nRERn6YeoWy1SxKMmO9OswzCcWgFhAIZ2VJouxew=
Received: from AM0PR02CA0182.eurprd02.prod.outlook.com (2603:10a6:20b:28e::19)
 by PAXPR03MB8226.eurprd03.prod.outlook.com (2603:10a6:102:24d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 10:31:11 +0000
Received: from AM1PEPF000252E0.eurprd07.prod.outlook.com
 (2603:10a6:20b:28e:cafe::89) by AM0PR02CA0182.outlook.office365.com
 (2603:10a6:20b:28e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.27 via Frontend Transport; Thu,
 13 Mar 2025 10:31:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM1PEPF000252E0.mail.protection.outlook.com (10.167.16.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 10:31:10 +0000
Received: from N9W6SW14.arri.de (10.30.5.19) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Thu, 13 Mar
 2025 11:31:09 +0100
From: Christian Eggers <ceggers@arri.de>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Douglas Anderson <dianders@chromium.org>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/2] regulator: fix race with probing of dummy regulator
Date: Thu, 13 Mar 2025 11:27:37 +0100
Message-ID: <20250313103051.32430-1-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252E0:EE_|PAXPR03MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: 47dcc2a1-ff79-4705-da20-08dd621a2c69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?45Cn7+P/1QhamlQtKEOSThhb7LKXkwGBxrW5NjRD+ksl+bmZ/h1brKsEQ32D?=
 =?us-ascii?Q?JEB3pBWq+DtWydRUaDhZmJ8aaekwtc5Tbr+m/hbLmPU63JoGAvcmnDVmq4a6?=
 =?us-ascii?Q?t9P9cyDyeTqPr8T2TpCsccpKApnH5vD2bGUr561W0I8vKjqzz3ssEUwYj49O?=
 =?us-ascii?Q?8aACeTaTGMMiequevTvnWzY9hIaC4PYRGFvijcDtPcU71kyqUEUaoyQLyI/p?=
 =?us-ascii?Q?HPHYTZ+GW23sdow84LRYOLoPl9m04oB3WaoAlN3fz78qWiePPXVqp4JbWbn7?=
 =?us-ascii?Q?c8eZHbWLLQvaWQjQnUe+MRdx0FlVtbfGUPCPO+1UJPOA5V15rFTUbST+uWLN?=
 =?us-ascii?Q?vdzCRyuC/68EJL6BjeNr3/qu/IEf+x2b3rTu3nJ9OZHG+KR7pImQMr0nq1dh?=
 =?us-ascii?Q?aXXNchKyg9jEJq9tjngUZiLJTVZZlI5zFKx1TSqtEkmniz6pnk+/8SXLcFzF?=
 =?us-ascii?Q?qfonUJb7YDN0v2wJndfd0m/xWLl4KnMlOGn4mmqaTcLifBnsbekImftUIOAd?=
 =?us-ascii?Q?YtrEVdL98N2CugfW59JAbaQyYr58+A7w2tYm9dx260EHJxfpe9cUBO3ZoteK?=
 =?us-ascii?Q?260jYMloOzKSMKvKbgkb8/gNNy5g3jbjULWEa3RpiPswZDuQZPFaYJVPM6Hk?=
 =?us-ascii?Q?zZHUBEksTBu9b47Ezd48l4eDUb/Hd/cJ+n22ORDme5TUp0biLmBfG4AIfjH+?=
 =?us-ascii?Q?md3+kq7LGzY/qCYra85y/tNvpsTDBKsF8zRG2yqCjIaFTfgnEnU3ugvFP5aU?=
 =?us-ascii?Q?S92UWizX7QStHD6hH6iBxNcvs6LvPBFRE/da9tuhf0bC17zKT/Cj3voG+2yR?=
 =?us-ascii?Q?gpoKALy681/UHMWF+I36e0C0HGWsJEtfTwidEAGdgNQEgLRYNwJD1Rpx/qxK?=
 =?us-ascii?Q?kamtBzZFyB49IME6eT0hpyaHxLsFMHMlC1mwGs6/VmbNfUWjrDFo38QlEAFA?=
 =?us-ascii?Q?otTpL8LsornIz3ys5xdYBpE2Oh4P0rE65uPR4h1VzHXtwdmqcQXYImUH32HK?=
 =?us-ascii?Q?K930OQQACCYq5rWArQjhnAzkutwYwYzPFFl/EYruWUPs1bEE2o8BzIkKLjRT?=
 =?us-ascii?Q?aeGcUgeQwDkwG06Wq1t2VsYiL/G1SBBdQXS3NJTcUQgANzsG6gA8Kv4L5HOp?=
 =?us-ascii?Q?mTAqb4dNf0MhBQJ4JYB3g6nz9kSuaHE5tF550EIAI/bS8VF7Y45VsePhlHO6?=
 =?us-ascii?Q?CxGlPF/uUbSQPyjlnsd0Paerr97cPQXB7xi+kSQvI40bv45UVDk7Fr5PC/8J?=
 =?us-ascii?Q?t/AVZIsQq9w034ewK8Cc2Qtx6SiBLblrdpGnmnV1vbovRsVcSLkaIelfCwD4?=
 =?us-ascii?Q?q6obKnqWGPypXIc1V527cEUtnQI1TXXLxt3DkWMAhuZccMjT/UlMrmyA3oOi?=
 =?us-ascii?Q?oU7MOg59niU9PVxacxo9rtTVP/0Y5P0dPBRPdLVvHUVkjmuG82KTQuodUpMM?=
 =?us-ascii?Q?SIvMqkCFO5a0CrExZmrimk+xk8xZPHpy+5SMNLQp7bW0LVOyXwGExw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 10:31:10.9347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47dcc2a1-ff79-4705-da20-08dd621a2c69
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252E0.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB8226

These two patches are already in linux-next. I made a minor adjustment
proposed by Doug. Can they still be updated?


