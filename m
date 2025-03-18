Return-Path: <linux-kernel+bounces-565773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05722A66EE8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E1BA188AA66
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7B4206F19;
	Tue, 18 Mar 2025 08:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MB5ZPwKY"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B382063EB;
	Tue, 18 Mar 2025 08:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742287674; cv=fail; b=DbzwtNUuw5tTTRRHQJZrhUkq+NhzhOjled46UTszXrcrRFjpriINeGnhPKt5rwEesv+gvI3QWPKSht9kjZd57UQc6eKfahJxrEOzBfQelzEgqIBcu18wzWgY9efejGJUWKKImQjpMx+fZz0bWH5vVrARqnc6eggV4+rI5F2eTts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742287674; c=relaxed/simple;
	bh=12ddnSGbIaWfg7E2TPLFxJakB6OxILOhRRm6gpEsGSs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=soxW2lARpZ4BWKQGcEYIUoEkYlE7IEAJ1IJmuIrSFPnNRFbJ17vE7/vPtQxxXwIpjRtEIJUuBSqaMoO8NxgLVu/fJFyHi9igwp9FljydaiLrV0sTeZ2svSwqNwtkJKkPfjG15uMNZt3Lii1CM1tAvTlmRJSKJXlsq45+Ts7pWLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=MB5ZPwKY; arc=fail smtp.client-ip=40.107.22.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qnuHq4TXX1biXUO3QIMSpZBDJ2jEboZGFjCMalYXz0H+/V7E8mgyMQAGcc+P4GDMKzcOs5bCYnFQ2RGM3mfDzDK9+c7vDUi26u29lEIdkkwS61PUfqwRDe6ZEcI17QXriuC54HULW8hlWiSoIkZO1A+/n0UPhmgag/ISSgkcj68HtbVwqCTjNrGOzLE5RGyBNttA3c4NvuydUwjhHxCKv1JqAgOAUogotk4f1NsxcLKfv/pNw3rZbRu4wSINRjoaE35s9NPuPWd7L4pdknQiD7A6IYwK0dNl3+dXCS5xTPBsLC3zSEqMusbfSBSz7NKEmftZMS3AmGrY5BShUg+mVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SAS32sWUqrMSSHqOwA3qiSpt4GRQEm8a3yJVSVKFmM=;
 b=S7lqOqh3aHDWKlUr2Tubxu0v8FXKi3QCAFXU6mv3KQbhPtTdwRDHS/d2tT3v7p0b1e7Y7JYWluLz7FT7MGfxcp9i7Nn257/hjs08wEa4mOR+91NfHqBw6ZA90p7hjUtxCLc2minwEQvYOCpYFFhcDR4OkTIsKGAcgicuWQMLzziwRhwNYSGE49Hf6dAKJjp3wj544Gnv+ix345dc5jfPSAEGXOxJTTtLPD3WWo1m33UDv4a1n19wYlXDc/A5Vu0euBcywsUUun7t4kHLNNxhl2OVvda2bHBFLh86kSzTYRNQqmEn/iB6bxmVhoKlEgNx6KsEaXdRKY+YbJgHiveYVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SAS32sWUqrMSSHqOwA3qiSpt4GRQEm8a3yJVSVKFmM=;
 b=MB5ZPwKYG1RRxaoze7850kyTCUu4uOFYyGbiBKO7lnripazTreX5ylBU8YeflBb8sTwCCSg4lHN1SKBU3SEmPfwLCc0egw+E0o4YjU9cMgQROadzf7sfBm5QV0laalEZI1klTnDcJUMAvVy0YENL/kEQB5q/T1T6mp1WfTCP6JJWC6zu4plbTNKlRYzN2z3L0yD9EOPyVaniC1OXftJvWdnx1PaDwvmfc51cAgredOUodazO1sfWP9tYCmpQfdpR1Xj7eeqClXFWLprnZ2edM3PzWhs5PtEZWsTzZK4X29kNrWHzemQehM11o1fcqCCujZ7h157gxhEzixvbL1k2yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com (2603:10a6:10:5b3::14)
 by PA4PR04MB7742.eurprd04.prod.outlook.com (2603:10a6:102:b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 08:47:42 +0000
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db]) by DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 08:47:42 +0000
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
	Florin Leotescu <florin.leotescu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v5 3/3] hwmon: emc2305: Use devm_thermal_of_cooling_device_register
Date: Tue, 18 Mar 2025 10:54:44 +0200
Message-Id: <20250318085444.3459380-4-florin.leotescu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318085444.3459380-1-florin.leotescu@oss.nxp.com>
References: <20250318085444.3459380-1-florin.leotescu@oss.nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P190CA0017.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::22) To DU7PR04MB11163.eurprd04.prod.outlook.com
 (2603:10a6:10:5b3::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU7PR04MB11163:EE_|PA4PR04MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: d451d8b0-7df4-4508-5f1b-08dd65f98b8a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?lq793E1uqmYAZdXV7sAc5qZA1o8huQIXosicjcbQt3E7XQsG1TF3y3/I6Y?=
 =?iso-8859-1?Q?RinDG43SNT6SaYZpc+U30BZrLMLrdfxLKaRVMXzVm9YyBV59rQGjWsaCqL?=
 =?iso-8859-1?Q?0THWukEqa06e4ohQjLbu2Qj9092EUtE7Shnixs3f+fg5n/PcnzHE7g4gFp?=
 =?iso-8859-1?Q?L4qiEieOVIidIkAkCiiVIb0iRkQ/0/aSPz9KYpFPxGBrVzjLhE0F0Tlm5t?=
 =?iso-8859-1?Q?6Chx4w0GDvlOG9x7gXtNskJK2U9P3ZO/Fh1AXeEmT340N8C+kt5VMIBel8?=
 =?iso-8859-1?Q?gWo7kJON2vuz1fVQ3GNWVm18q47+543vm+8s3LgJvDpB0tHwv6hrpeiTpU?=
 =?iso-8859-1?Q?199G4sQaFhAQPQAvt2W12XmHWWIv8pLe7pNaRLisAOPNH9OqVWnd25YCT4?=
 =?iso-8859-1?Q?t6efIrCIv/c+/oslpVerYoqHF+5AX6HxrYt/imncYtQOgIFtj4JVvQVl/5?=
 =?iso-8859-1?Q?2xmwRflzUkXa8qvGz+mTm/U2N8OK9oxPnuvoB5g21IJl1HEtKa1JiJ4JTY?=
 =?iso-8859-1?Q?D71Lc8cSgU3J49fmrQjGmppVX6YR+0gGxPFApFNs+dZtbDSbilVJ0sdYXt?=
 =?iso-8859-1?Q?4VDPkGQAuEJKJRx8QsOGSAosVMrth8fRDCOVuNKLFB0vukKlHGrKKtanjP?=
 =?iso-8859-1?Q?T0s25ph1uTjzmTQHyxRz0/jUz9f7Yd6sg/SBUslIZ6AG8glHxs9gQJYA7x?=
 =?iso-8859-1?Q?FNweGFMOPETjURdLiJqJpNA4dX7mymxv7o9+cFTwbIseH8N5Q08D+U+P5M?=
 =?iso-8859-1?Q?hvboOhJNPSk+TFnx9mKMb4xBhNKY9DALy9p/59TIDwxF4YiF1o4Es822Vg?=
 =?iso-8859-1?Q?KE+9cloUFsM+UoUwDecS9A5hbLz6WtchU/+NFWkpVDAyIM/gJjkyCMOPI2?=
 =?iso-8859-1?Q?5W//e+hIf9ejkQe9SxMeKaIMtV0ZnQGLuqLtTPzphx4fjWCu0qaRELbsY8?=
 =?iso-8859-1?Q?wDVBgFrnKEf/1m+IngzValf42q6iCmH6mwCFv8mDebOQNKkH0FfuD/uulS?=
 =?iso-8859-1?Q?6S91JJ+MNKtzS2Uq4f26VUNPY8qnzAEwmon9wiEQI5vZRF5iT209hro3Ta?=
 =?iso-8859-1?Q?/49g74LViHYjZfigQYaUOKX5nbayJd9DCepYpWw5ty8KgabKXDt6JpV48Z?=
 =?iso-8859-1?Q?LXDl9B90Qqyggbwf8og9eiVnoEU/speSQxvWsA6A0o0i0zBhLqTwBdKtx0?=
 =?iso-8859-1?Q?wHRTs2bsEOgv/KM+KdYK6TKrozk9Omdbg1xMcHd9Kd7ZJghQZ/fZaOWk38?=
 =?iso-8859-1?Q?6oZv+s27nJ7116/G6taMIpv3SEAHi/qdyM7CIXDYWrPsUhvvaCOqxy7CiK?=
 =?iso-8859-1?Q?l9WTKOfgnOLccM8MOgjmpgzTWwZJM1/zBepc+XnhD31mECp62dpU7xVT+T?=
 =?iso-8859-1?Q?Pun2PToZIYLvOYaQm6VzLfaw+GClLgd5OOO7/wcou/XtEiVahyN4NLot5B?=
 =?iso-8859-1?Q?caUhKTBwK9DlxsgO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU7PR04MB11163.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?4DBC678i5nDPTN9HjyRub8mMz7rHs5rSgseP3aYnpomMMrQAkvho5BCcen?=
 =?iso-8859-1?Q?7HLyDir6sn+IVwfMRXCxb8yrWl4y5vlb0sz4JEyaI/zR2P7wxqKM/J+sAg?=
 =?iso-8859-1?Q?XP7DSqfMRIlx7+s1M7zjVpXCwl0+jKmTpKBTkWezVnG5DR9YlQyBWuwjxx?=
 =?iso-8859-1?Q?4Np1UMouR8nInowQ+eFMBjCFhwm7SwpV/tTSR8Plu+n8w2GlgrAgACliOr?=
 =?iso-8859-1?Q?VEGsK0ZATDY+wk6YEUUylc4OJ7RRlh72BObpT1/eUxGY8euZlGXLSqYwbh?=
 =?iso-8859-1?Q?w8gE+8TYfUt/+xpMboo2ziVYp+u38oJ4O5zk9q7G1xW071t6as5YQ9KImB?=
 =?iso-8859-1?Q?adgOgmPucBAQtIlsjL7RhHyS+zJTqHH2VBpxjaYyqjoWcBxVjTE/y28IsJ?=
 =?iso-8859-1?Q?7SBF8y/KJ5Vhx64oU4aIPde3jJpp7xT3Zp5jwuLqtSJzNriiSVmHXLcMTs?=
 =?iso-8859-1?Q?pLiBdSXDN26WEqaaCaZBJRsep2hJlG+RjtFgbT/pSPbNQH/ZdO8Mznhepl?=
 =?iso-8859-1?Q?jWjhgQ2/uRq9glyAOqwMzCyD76U3vo1WWRkjvFy6M9reJkYn4CNatloHi/?=
 =?iso-8859-1?Q?ZKSV7D1ea7+2p225BulEsWP3fZ7ThgfexK40cFw/pkJQXkHcH0o3FlXlSC?=
 =?iso-8859-1?Q?aiINdwbVf3QoIn23Ck8RW5N0fGMpyuBWFHXiogU6vxxVqI18NDiF50kfin?=
 =?iso-8859-1?Q?C5hERwJPYUfoNkkGyrxlFhdjwZQhXJ0C4+d5RQJxlyRmFIuOPW3DViLEN4?=
 =?iso-8859-1?Q?R7T8iup4LPPd0U7n4EefLW33WEjhhunKJ948+6iYXfdsFU4L3srktnCU0a?=
 =?iso-8859-1?Q?wBqPZvwN+vUmUbJ4HSDFEKqNvPoDams8ly6x0v98OpYAIWSCY0paJ6eAC+?=
 =?iso-8859-1?Q?ptGJ3fiX25KQWCoIvQUe/ZJCxmytH4q2vmg6KkwxXjGMKNnPCq5dZpobRP?=
 =?iso-8859-1?Q?hehlfCHyPbduk9Goci7DvLO0zeM+m7aCA+ZxBUJvG7P2pbMu7Efmm7Gc8w?=
 =?iso-8859-1?Q?IiGv7OZ/ifbHS960DhL4Mfh1Hxre5nas61uZpQ8FWEnwDjEB3Uj19r9goT?=
 =?iso-8859-1?Q?5JfvPvxA2QXEEzV/lwpsjvChrM/3gX8ZUL/C2ufaPAf455R+SosRmMqqe8?=
 =?iso-8859-1?Q?H6WBjf/gw6eCIXyXqLkx+zQWgkco1EG9VeDNxbGjHou4sLOqKPLVrjQR2B?=
 =?iso-8859-1?Q?KeY3sImUUbxQp8lS9MGooO/9Ygbrvub9S31CKfuEAJeN17qK5cZgQquN4b?=
 =?iso-8859-1?Q?XWGUbM5E0uybIX+FHhoGgsWUurhEuCJceS8R6bB7Goj92/+st+UdiPacRV?=
 =?iso-8859-1?Q?0Broi7hiyT4aUx9Urd7rrWCSNTUEDyanUBiYEBJTwSGMrPGkzdJ/oumbPj?=
 =?iso-8859-1?Q?WEAv6xo61BHEZvqjr0ouPRfMO50/hkfz4S8KcDIeSO1c3qML66OwZCNBqq?=
 =?iso-8859-1?Q?3vle+n5EGR0keGI9DiyMkwFrj5Iw9+3YImB1shxrEIUUAjEb9oT6zte43x?=
 =?iso-8859-1?Q?ieQU+FjmVkaV3JD99FkuFUfBywP09n8SImhwI7vh/MgWFyhqSkVV1ou4oH?=
 =?iso-8859-1?Q?gEGt0BRuIPY8GM81fzje3aq0+m4No7cqoh2nxAWPNzMqlImEUrgt0y0y11?=
 =?iso-8859-1?Q?JklTMgR9oeGlIPZ0dPkQStWr4vDQupNEje?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d451d8b0-7df4-4508-5f1b-08dd65f98b8a
X-MS-Exchange-CrossTenant-AuthSource: DU7PR04MB11163.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 08:47:42.0706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zeGH7fGP8OSNqfxjAL/UE4fuIEh59+8J+wOVO3ic/iGbsHxJlVbSNVKSCy3hxmBtvW7tSRhH9koyqh2A2SEAsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7742

From: Florin Leotescu <florin.leotescu@nxp.com>

Prepare the emc2305 driver to use configuration from Device Tree nodes.
Switch to devm_thermal_of_cooling_device_register to simplify the
cleanup procedure, allowing the removal of emc2305_unset_tz and
emc2305_remove, which are no longer needed.

Signed-off-by: Florin Leotescu <florin.leotescu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/hwmon/emc2305.c | 33 ++++-----------------------------
 1 file changed, 4 insertions(+), 29 deletions(-)

diff --git a/drivers/hwmon/emc2305.c b/drivers/hwmon/emc2305.c
index f8a4c76fcadd..234c54956a4b 100644
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
@@ -332,24 +331,9 @@ static int emc2305_set_tz(struct device *dev)
 	for (i = 0; i < data->pwm_num; i++) {
 		ret = emc2305_set_single_tz(dev, i + 1);
 		if (ret)
-			goto thermal_cooling_device_register_fail;
+			return ret;
 	}
 	return 0;
-
-thermal_cooling_device_register_fail:
-	emc2305_unset_tz(dev);
-	return ret;
-}
-
-static void emc2305_unset_tz(struct device *dev)
-{
-	struct emc2305_data *data = dev_get_drvdata(dev);
-	int i;
-
-	/* Unregister cooling device. */
-	for (i = 0; i < EMC2305_PWM_MAX; i++)
-		if (data->cdev_data[i].cdev)
-			thermal_cooling_device_unregister(data->cdev_data[i].cdev);
 }
 
 static umode_t
@@ -599,14 +583,6 @@ static int emc2305_probe(struct i2c_client *client)
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
 	{ .compatible = "microchip,emc2305", },
 	{},
@@ -619,7 +595,6 @@ static struct i2c_driver emc2305_driver = {
 		.of_match_table = of_emc2305_match_table,
 	},
 	.probe = emc2305_probe,
-	.remove	  = emc2305_remove,
 	.id_table = emc2305_ids,
 };
 
-- 
2.34.1


