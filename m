Return-Path: <linux-kernel+bounces-544906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7554A4E6AC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2235D461B33
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A8B2C2CC6;
	Tue,  4 Mar 2025 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Ec0yN36j"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2040.outbound.protection.outlook.com [40.107.241.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111122C2CAA;
	Tue,  4 Mar 2025 16:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104873; cv=fail; b=kx9axl43CR+zJR5yNki+WWX0gttG3E9C0HgMzEtZq6jsYqdSO9fHLGn82hF/2MMpgHx35wO9Iu72xWBCDWIa5SiaIPm1/ENK1TEomVCigNbt76pcM5a2GuiHeh9Gsh4R8Seeip0zpfDuU+gazvdOklbxjvIoILWUqmYLvIS/X+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104873; c=relaxed/simple;
	bh=bTnRvzA6T7HRFpDUmqXd1DdDRaDDpRQ08fUOmygjB9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eNQfKxDEM3z/fOr39swj8A0finEfEnKHIf2MuuPNoFo/b9GoP98Z1f/HCguPUwz2/6mMsgjZ3PKeXhzfUb8RRGvp2g2fFuweIZCd/VfVYxZG48KBEcqIWu+m/H1J5QEWxd+7lonE23L69pX/iZf/NmFGurN65Q6IK5FCdQmeIGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Ec0yN36j; arc=fail smtp.client-ip=40.107.241.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6ybHjbiI0Zr1RQZCzMCuTaANl0N3rZ0ZjQ/R4s/ztoFiQdMqEjVjjfi2gP84pKGGMIX2gMdTqax0C4lC1ubEecg8LSREV1Blg3pKyeBho22RDezDUdCAdu1avmnW3R0EHnIRdE7HQyiBNLCmxIQlC3Q21+sRrC9OsyQqHLS1imw2ErpDbCIG7HbW1DfcGJ1Y3SL7kXZVAncsO3qaCRnuqE3YdU0HoRRBAhhZNU9PaIdHbUIo6mPOHbgo/Jx633ChK0cAxupEg4haoZm5lGnf369dzlm/rpcEIUuGN0Lq2Ch/pyUIZ36Qewsy0p3tLCo9WaX1rvQb0CVK0y4dUjuuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZ9VSB9xT2b/qG8qHQbtvbJrR1seitoepvz5LJqLVZQ=;
 b=eG4QsW0O6MxGYEqfnpaU6cJzi6leFcgW0oB/9Nys+MvGjZ6nufPMcyP9a1H1MTFSemWpsrFEeAEQ74DDD3G4RE1x06/L0iQwDzvHLHr6HmIEjKkgJvbnDJnbYO/dTWdS9ufya17JkQacB2dodA6q6O8JumTFWMwIHdkLbV4jFbC5ECPTGVjxEX6jFe23gzhmOQnLsYTdTybj8xsZlrY2dX/SHznykUAZPTegO35ZDvXnnijnUg5K/0tHzGMxijktRt2plNLqsAEuhrw2nrQsBb4p12rFAdxUOx5Mxy36cQoCVeo/fHIYCKcfj8oeYi02vgjpATdAxBZiP8JfUrPZaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZ9VSB9xT2b/qG8qHQbtvbJrR1seitoepvz5LJqLVZQ=;
 b=Ec0yN36juzzPa0JNoywXcc0kXQzw9P4lk9Q/Vg8GqX/4255rN4zD/SgPcionxZaPUCgYg0yMmCyIFd2+DdWXqmANWYQ06cg84Bm3zJK3JKidfv6g4w4cG0A/wuvHPIcz1OaRj+08+f5EWYU0XSvzVhP9wWT+mdU8M/Rrm0ZUvItJ6l6B28Z3kB6KU9vOCHwpOa4V3S83UkRHJIvrlXlN++1plqPafS7xGxgzyQH10ZfiAvVJcTSwBZezhfQ7hyukkHYiXFy/eAISVk6U+hFYR2SPPFs3LtN/sLlM9htSVxSJqtkjfFaKjliXDCBQiKZ5PTN+w+Y2duUyhfaC8jH5JA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com (2603:10a6:10:5b3::14)
 by DU4PR04MB11080.eurprd04.prod.outlook.com (2603:10a6:10:587::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 16:14:29 +0000
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db]) by DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db%4]) with mapi id 15.20.8489.028; Tue, 4 Mar 2025
 16:14:29 +0000
From: florin.leotescu@oss.nxp.com
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Shych <michaelsh@nvidia.com>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: viorel.suman@nxp.com,
	carlos.song@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	festevam@gmail.com,
	Florin Leotescu <florin.leotescu@nxp.com>
Subject: [PATCH v3 3/3] hwmon: emc2305: Use devm_thermal_of_cooling_device_register
Date: Tue,  4 Mar 2025 18:21:36 +0200
Message-Id: <20250304162136.1963384-4-florin.leotescu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250304162136.1963384-1-florin.leotescu@oss.nxp.com>
References: <20250304162136.1963384-1-florin.leotescu@oss.nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR05CA0096.eurprd05.prod.outlook.com
 (2603:10a6:208:136::36) To DU7PR04MB11163.eurprd04.prod.outlook.com
 (2603:10a6:10:5b3::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU7PR04MB11163:EE_|DU4PR04MB11080:EE_
X-MS-Office365-Filtering-Correlation-Id: 88f2c751-fea6-45e1-e482-08dd5b37a3f3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?TBIl8/nDFO928rWeRjFzo8EHeb3tYxHCok4V0/XuFW72fPPgfV/pedSGCg?=
 =?iso-8859-1?Q?dT6epkfA9NYRuYmPLdAaNkpUq+uSU1dmU8GqAJ+7gOaqVS58f0jSCXWM2O?=
 =?iso-8859-1?Q?rPkw3YAgG57L1FgABBYraUUUsdDepDVuZ3Sd8DVXfRC+beyHxa+fHrGyr3?=
 =?iso-8859-1?Q?B/quHR2Z3fuwgy8aUygcZjrx1zT6uX4YjINSHBv0JTGptK7hkyah2AMy6i?=
 =?iso-8859-1?Q?e9GhHrhjT7VxGKhzLPRAg1oPYzBLc9qNBhHHlN5U9VtDgVzYBvqxOQCVDG?=
 =?iso-8859-1?Q?edlN0TNviMCihSk160YRdcAKL7dVcobgM1i6Gtrwmc6o9t97GuBRQZsQDi?=
 =?iso-8859-1?Q?n26xlQBYXe1TyJClpL3N4vGvaAdhVfSJz1K19piKM9Zx659PT9b0Z4rFHl?=
 =?iso-8859-1?Q?OVfJO/FIMae81C2dlx8H34vsTXZK+q/bvTcuVSeeMhYjotx9XTZVBm0POR?=
 =?iso-8859-1?Q?x8wvgKn9t8BTMUNMhzpG0PxO2qudA9bZrSZm1GM/VsGtI81loealCZSb24?=
 =?iso-8859-1?Q?gvcxtG4FtWmPihXODtmQHFD72RWp+sVusocFB1Lj4akCy3/O+HdDtXTZwF?=
 =?iso-8859-1?Q?Bmw4ULUyVzKvu1dV64jJjdF6qCBmDjOrElvgVS18pqiSJYXkbA78H9dAEC?=
 =?iso-8859-1?Q?S9EWTD8P6ln4r4IiIgZZQPBfMfu/d/kPA6kdo4zhFw7ig/6l+5UyDSHx7M?=
 =?iso-8859-1?Q?ctC0x3mzETX1ODk51LjL4oLpVPQ0u76Ib5NyKbnIKohoHU6Ny97fwZlk3Z?=
 =?iso-8859-1?Q?tQFML0g4eCQ32T9L2+50cn/KQr8lWKGZOduJZ03hP33eqMvRTEGuVLDc6X?=
 =?iso-8859-1?Q?n79cgMNHEe3cajmbyIpb73gL9xdzIhqAJmKx9thtOIBD5ZdnYgYZe8U9Sf?=
 =?iso-8859-1?Q?LRfiM8NqUDys8zBxbA3u13sZulDQcwEfi7n+X9RuFMXiD9chxaTzuA94vi?=
 =?iso-8859-1?Q?YIU3zpnSSYUX2JcuSjaIVckWCxkSNK+iA2Z+wyHy88VOxT76dYgsqOcVqy?=
 =?iso-8859-1?Q?EawZrE2vBc4w1InMaPl7e0kAhd/n5H4UkMUyaxSRS2gojodOmXhMe57Oe1?=
 =?iso-8859-1?Q?c9zo1gQkqUO0z9AKmL1I6aEJVeFsgpA6bLe71IrKE9Cctob98Z7ZsGPcWI?=
 =?iso-8859-1?Q?GPgD7N6u5bc84rQdyAh/LLtHdO4WySfc72We3B/tvz+rgq8rdR8rtTXych?=
 =?iso-8859-1?Q?Fn8Cza6CRau8f3LK3ulHrtdgftNcCRwYxlJGCqKaP1c9fTWPGDWkbFvdAU?=
 =?iso-8859-1?Q?LTCXrNavgsX5Ib+lGDdX2mAs9WVzzkXh70DpdwU13J+ZHhOkIK6YhKFEu9?=
 =?iso-8859-1?Q?2F9Y+1aeIxMcsvHXnpog+IMl2hl1DEBHsODu6iuj9AiM7vhnC+UxetlskG?=
 =?iso-8859-1?Q?2tUGdvOr7M5mHBlomb0vB1hRWKoIwKrsZcLAZXsmnDuIGx1Q7p4nnUgM7/?=
 =?iso-8859-1?Q?RVHhoxBDybTWfUVI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU7PR04MB11163.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?6+1sL8lrFJ94eM8LF9o0GUalvfWKKk7MuAd26pxZFg0XvDPHV3fEAoIEUe?=
 =?iso-8859-1?Q?P7B57aO33sxZ3gjiLlKK2re9FkPs3Vcden9Tud+iY+Vzf7D+gVp7vtK4hz?=
 =?iso-8859-1?Q?QbO4akxeULXjR5EAhyn2RZorTbV72d590On0n+7LD6uiVQB/MhflWll2ZY?=
 =?iso-8859-1?Q?n4ODmut8w5yf/0sNwCesVpjuOaXcyHGRPlMnFmmc6nixEqtbHnC1TfPgEG?=
 =?iso-8859-1?Q?+lepZvRYjonRXbarSbityvMMh0/qB5jXnRj9QXwsHHpe73ZcIUhR7yg67S?=
 =?iso-8859-1?Q?/7VNu4vPuTEuKGEGegxxvEdiqpXwZGPwi1wKt5FbUHZhSfTxDUthfgncPC?=
 =?iso-8859-1?Q?bVYGRBAHjJz12rgheHQDLMhorqEwgqtkxHSlbOTUMppeshC1vIxwP8mdJx?=
 =?iso-8859-1?Q?GIYObFxvbQhHjLcXUGDPXOuDwDsOWqWvPu7Z7HSTMTabfcaD9N/CePR0O7?=
 =?iso-8859-1?Q?DspWgF33D3aVSmCkIoEnCkbrA/JwgB2pEiDM3cDVAXNRJxA5Kp7KYY10Y+?=
 =?iso-8859-1?Q?5nIKLqCQr69kR+M18qtTK2trmrEKmSCzJjR1lvgpwl9vLYAxZXP1jU/mWk?=
 =?iso-8859-1?Q?7xG2ITfFyL24rw4uvc3yBYV4VN3KRGwZjGzdN5Pbgj6jruzJEavY8VeZok?=
 =?iso-8859-1?Q?X/B57p4kLE/waBsTgMu7cHwNoQetmBT+HnemBIC3Booo0hLq+z2B5NHS0O?=
 =?iso-8859-1?Q?e2jouekJrYiv0K4LirvelmdSvD9Ct4ZUDIcsr40hV+YSsKdMN4xTaqyNwp?=
 =?iso-8859-1?Q?7kMmsXUUvi84n00V+13+BQJL7Hyxt5TUE9goFPi2I8Lc6YNb3OLPUTId59?=
 =?iso-8859-1?Q?4rYi/trfZ+oyjIse6MGhVDVgPRi1L/ujQIVB1WC8ybtqZui7vG/RateH1R?=
 =?iso-8859-1?Q?vUuHXbLQgYIZhhT35+cd0C4P/YQEZRrpO6qii9/NKxI2yiEeThcjDMrEPo?=
 =?iso-8859-1?Q?KhI4W5HlYFNAJWL8qJCELakDZmIAppGuRjyXSJf9JRsVja8q4CSXRF66/0?=
 =?iso-8859-1?Q?aYTdAtukFASGzyzWVNRehJBjlR3R6uTt3AiWQjMJhrO8sDBgTSc0j+vWaA?=
 =?iso-8859-1?Q?N6NqVZ6XROBcBq7jobcTVTqQQu4ML6GjsjE0iyxSfADzRPjSHgPY6JHWaW?=
 =?iso-8859-1?Q?TGD40AC8kJ3QdxKCUzrCAhSDLPLQlQpDBplxbXauxaYMEV/RgCTc3bzFtF?=
 =?iso-8859-1?Q?2Jpro2Y0y4MKMh1NsugX1ynojAj3EtaZobmzjLHDZoreNcFDouHIqgSvoi?=
 =?iso-8859-1?Q?SKIf8RV4TJCidMyGu59Mz1j8wBwF3esH9Fj+RTyiIjBgzoY+Gk65tBN9DY?=
 =?iso-8859-1?Q?+hK0OOTGg98uS+yxToDnpocET8nWAUMYrVURjMoYYoNr0IPKkhIpMPTbic?=
 =?iso-8859-1?Q?tFTcgDRSXmSTSBx74tDN/lVYOUNwhf3BKmce+eDOS5TARY+K/a4LZapfPC?=
 =?iso-8859-1?Q?PgUxI7tN//r8x9CjtHJROZZKBX4xFYUM/S5wsFJWfqJvK0Kml4zbm3Niog?=
 =?iso-8859-1?Q?/FTLzdi4UjE0HGlHnj4LIiWp3dSizGF647hp3oeYq1TcQmzS9Zr9yHQzHO?=
 =?iso-8859-1?Q?bc2enWaRljkyPrIxbppVh6F4yhcTN9NhpTwg1O5bAsXgTV4ndUvwzJKyR6?=
 =?iso-8859-1?Q?0S1vDY0DJL+Hq378oLlY7/eA66zW797IEO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f2c751-fea6-45e1-e482-08dd5b37a3f3
X-MS-Exchange-CrossTenant-AuthSource: DU7PR04MB11163.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 16:14:29.0281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQLTIdhybw0Qc3VkNoNJJtHlpNyyQmbz99eI7stOGktcStZP+QKY4tDkr5+TOdSW8gtW1aBW7zfGWAQ7V2kMbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11080

From: Florin Leotescu <florin.leotescu@nxp.com>

This prepares emc2305 driver to use configuration from Device Tree nodes.
Using devm_thermal_of_cooling_device_register also simplifies cleanup
procedure, so we are able to remove the emc2305_unset_tz and emc2305_remove
functions which are no longer used.

Signed-off-by: Florin Leotescu <florin.leotescu@nxp.com>
---
 drivers/hwmon/emc2305.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/drivers/hwmon/emc2305.c b/drivers/hwmon/emc2305.c
index a236f27c75bc..5f3f06308826 100644
--- a/drivers/hwmon/emc2305.c
+++ b/drivers/hwmon/emc2305.c
@@ -112,8 +112,6 @@ static char *emc2305_fan_name[] = {
 	"emc2305_fan5",
 };
 
-static void emc2305_unset_tz(struct device *dev);
-
 static int emc2305_get_max_channel(const struct emc2305_data *data)
 {
 	return data->pwm_num;
@@ -293,8 +291,9 @@ static int emc2305_set_single_tz(struct device *dev, int idx)
 	pwm = data->pwm_min[cdev_idx];
 
 	data->cdev_data[cdev_idx].cdev =
-		thermal_cooling_device_register(emc2305_fan_name[idx], data,
-						&emc2305_cooling_ops);
+		devm_thermal_of_cooling_device_register(dev, dev->of_node,
+							emc2305_fan_name[idx], data,
+							&emc2305_cooling_ops);
 
 	if (IS_ERR(data->cdev_data[cdev_idx].cdev)) {
 		dev_err(dev, "Failed to register cooling device %s\n", emc2305_fan_name[idx]);
@@ -337,21 +336,9 @@ static int emc2305_set_tz(struct device *dev)
 	return 0;
 
 thermal_cooling_device_register_fail:
-	emc2305_unset_tz(dev);
 	return ret;
 }
 
-static void emc2305_unset_tz(struct device *dev)
-{
-	struct emc2305_data *data = dev_get_drvdata(dev);
-	int i;
-
-	/* Unregister cooling device. */
-	for (i = 0; i < EMC2305_PWM_MAX; i++)
-		if (data->cdev_data[i].cdev)
-			thermal_cooling_device_unregister(data->cdev_data[i].cdev);
-}
-
 static umode_t
 emc2305_is_visible(const void *data, enum hwmon_sensor_types type, u32 attr, int channel)
 {
@@ -599,14 +586,6 @@ static int emc2305_probe(struct i2c_client *client)
 	return 0;
 }
 
-static void emc2305_remove(struct i2c_client *client)
-{
-	struct device *dev = &client->dev;
-
-	if (IS_REACHABLE(CONFIG_THERMAL))
-		emc2305_unset_tz(dev);
-}
-
 static const struct of_device_id of_emc2305_match_table[] = {
 	{ .compatible = "microchip,emc2301", },
 	{ .compatible = "microchip,emc2302", },
@@ -622,7 +601,6 @@ static struct i2c_driver emc2305_driver = {
 		.of_match_table = of_emc2305_match_table,
 	},
 	.probe = emc2305_probe,
-	.remove	  = emc2305_remove,
 	.id_table = emc2305_ids,
 };
 
-- 
2.34.1


