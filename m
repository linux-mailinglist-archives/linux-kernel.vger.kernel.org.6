Return-Path: <linux-kernel+bounces-422154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1655F9D9540
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 11:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9732284B76
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 10:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7671C8FBA;
	Tue, 26 Nov 2024 10:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TGZcbKd1"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C2D1C4A07
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 10:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732615998; cv=fail; b=aKhPkZvrnZPp0p3z4JXQgbXy96MwQFs6H1TZh7v9FwrNTtalzgszTqfDko5qDiSnquxdUasdGbn97zihSgGzFLuD86aYWPf1czMLVOXy7YH4mRQKwojq9boOFoA9YUzMahWt/pXKJbbbp5H29J9JvVc+E6Q2iwWakCg/tOHzy5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732615998; c=relaxed/simple;
	bh=ZBkMUEgvpIQl3XTcdQmdNweIWaRePPbbArcl/98HuVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VxddIp3I/47Q+j0ohGbYPPvzdCj8Ie09BdT5Og35UTGHrexD72c0xej762Via67K17Oz3FnW87c/RfYdcwiqNutztzUTr6r7o6Rff8X9tVC9H25aIyDvhnuSlGySxHli+g3w7cxRPZwp8+Z1Hf3r7oJWQx3N2cGlvLmgAIcsGR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TGZcbKd1; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVNgeyRg9QOKCLrKRTGJJiewpXbF0W8HGtXrhjaQPzFLk3wCgnuptSWLgBxd/F/WO05QD1V5p+JjtfOngvkfxfPQUnp6q2fai7LXMRSwaD0LkCMmuNR9ibCqPshLVeouyBig1zGgEn2BQBaDzXQRPci+aA+c5YziquwwCS8RgcMC/7BbLtxV4b5O80E98J6CdZEfTx3lmFIemr0ctveYZL+2Nt2fZ039GsuBGRY5RPaIfRTTEHDg9GgImxMmEoSngYl+uEim/rtTSjTr2qeTSHi8zJf710zTpxRDC691cc5KfVq3koUNgTmXJ2EWBijDi87HeSDSVVTz1eJw/MLNjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RgmzWLgUHFGIapELbwklw49THnKJm7XPkxetTMAJ6jo=;
 b=LnEc5gA2fiPijjh+7eDjCSEIxzscJGos5JWIQIuAr1cAqDmx27vgEh3/s+jS9ANHpdEagOpfxt5D8KBqeo2y5yq7crG2fZfj1RChyLUK6zfs9Y+GZCnFk5O9gaat2ICH/Rr5S9HvZWce+nn73xhSEpn9qTOylLo9oj/8lVYRNxRjOTDkzYVhXN0Q2DXL8J7n8GcMpUHHd515r0cNuH3rc/yuy67olX/1PZBkzBbPhFoHkx0YB5L3mHDwLHoPgRD4aZIN5MsawjAajeUdKeOlrJf3s4SkcLUpLCMPnCb1zAJ6mz7kNxswJO+QjyW1a5ybCfhYejpfeLeSXbH9xZRQAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgmzWLgUHFGIapELbwklw49THnKJm7XPkxetTMAJ6jo=;
 b=TGZcbKd1MKqSk57L9Sz8C0SknA1rRuyhhxJhrJV2QzMefocrTiPXX8b8BCzrHKE8GA02iA3WlztNysKduXFbALwblS6zuAIay8fz3UGjxaKZCof0rC5ugvLY0tmHkUUNWPI+/r+MLkycfjufHrEyTMvuSAMPjuVz7ptrJEJlZIDn5798fLKRgYUJo5LS2rmjiy4mLXMjV5Mnzd/X7GsrkhDBshSo+IAQOffXA3Ujlhp7tYSYQY/S53dMd3DtwqAPiK9i+t6qwHo5bMoL/T7IZ0Ji11wHS+TZSPhWyyMoBlPUA4umnSdwp2UUoVuskJ+RqxfDr3F+O2KwUZeFwIBIhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SN7PR12MB6888.namprd12.prod.outlook.com (2603:10b6:806:260::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 26 Nov
 2024 10:13:14 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 10:13:14 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] nodemask: Introduce for_each_node_mask_from/for_each_node_state_from()
Date: Tue, 26 Nov 2024 10:56:39 +0100
Message-ID: <20241126101259.52077-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241126101259.52077-1-arighi@nvidia.com>
References: <20241126101259.52077-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0318.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::18) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SN7PR12MB6888:EE_
X-MS-Office365-Filtering-Correlation-Id: ae5d721e-a613-4b62-ca83-08dd0e02f00d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6/tQwQOLbBa8xm+qjMt3XVaHU1Uq7OTKsCCPHPnDXn464SVVn0vjZ302frYL?=
 =?us-ascii?Q?CNbdIyqCZHn/fb4MYjixuiqgblt0HzRqymMOC4KBdLZoTGAQQOnkZYAvnmWs?=
 =?us-ascii?Q?8rwtjKhOWbhFdZvFoYHSzkxqI73a460BIMb0r3u7zPPjG2VusAIaWUcmscwE?=
 =?us-ascii?Q?M1kEranmgXzCd8Qf/0m/vH3Ekff1Ge7tl4just7sIqQV7/j4AwB1FXbujxWI?=
 =?us-ascii?Q?F2JgAGb3Qzt7LLl54jYhFcsn1v97PfxaYeCBtiuyMrcUmwfm834ulBvY60QL?=
 =?us-ascii?Q?S8c9BwQ08WnTVXl3DaelxOnUoAijMNhkfWaTEGUPCS2Qr1VXvDuADmNY8mRP?=
 =?us-ascii?Q?vxephzCrvlbGWDITcWeGBqfCC/JmUYZy9gSq0x6ZrCJk9nSv+pA1+Hi0yMZc?=
 =?us-ascii?Q?2OdYDh1sIsK7eF87/2XBb/uiPIkk5uEFacqcnxpJGPxgkm76D4NnkiIskVXb?=
 =?us-ascii?Q?xVevlsRxI64z8b8AgZ1I2Z/erS+Z6HV7DA/DRVZOVO1zAJ8l54Ow2J9kTtFo?=
 =?us-ascii?Q?f522rR5/2WVgr1f1bL3m2gBXaNa+8yGsnB51nbNzGnTSFrdg99rXZgxD4ROL?=
 =?us-ascii?Q?8OKCS8xH0yfa4Pv1kvQ1dLnEcYCRQySkWGW2UJWLM3kIx4PztqL3lvXt4SR2?=
 =?us-ascii?Q?oBp+RrIKaFMw1fXYyMfGaR1q7CeYkq9O4j30hIAVzjJfy+6pJU/CH4MSgAer?=
 =?us-ascii?Q?3eH7DYZS4/w/IQck2F69Rqa8oVSyJ+Dz4RvSEQYM0oiq0sqS+XfhCUT98M2Z?=
 =?us-ascii?Q?LcUfhQdTcnFRxrbma3T01QW+sUThM/z/i/NRtsaqNLV9IncP7JH8HIUOXAHK?=
 =?us-ascii?Q?Of1mk1/VqHfXIUQBR1UfSN2NA2iaCigylH9vwikpcCevXcEGGu2Afd8csQWG?=
 =?us-ascii?Q?ay18+Z1EZpm7Zrs0R/JES/kaf3Cksa9AdMtKkR/DcoTebADkRtVLNEZm0zRG?=
 =?us-ascii?Q?5RobBDcZjiX5Rdf3dSs6P9fNxvOrDbWpPhP9JPxGmOGfpPOHOMLBZ3d06rQH?=
 =?us-ascii?Q?E95FJ1TqW82Ez4VYoLybsqb12V1mdGww6kCVqM5visDgC1oh9C/uc+Uc969u?=
 =?us-ascii?Q?UhvkXRy/5BMLN456+Uk3/ZOhaujNkHV2O9imQ99ClHv1tm+SXCYLhBrvTj9g?=
 =?us-ascii?Q?ZVxznr1RZdnCw4VrpiuyOEka9SYGK3M6g468djhD5a8E16Jpc+VKEW2T64nL?=
 =?us-ascii?Q?XNjRbc/TndF/NgJaSzEQwoZ0836b5Q2U3hbO/ulcgq2L2Eh3h684b4oKEuUy?=
 =?us-ascii?Q?5cTIKmXYeKluzJyhF3PxyCM5i6DWPMDLzhoyrMC9yvQWWZ7sjX1TgD+vfxQm?=
 =?us-ascii?Q?QtblcuI2jsJlacFRt070vVsE0Fw55ujCaqMq5FReOlUpFA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AxWJnbmy42kwrc3w7WcvOKi/J8cDBwLTrG0xiKFUpltlzA4VEST8W6eoK+9/?=
 =?us-ascii?Q?ra+o2gNXyaiw+J9eT4QiA0UnWg0NaoCtOwSfWlV1W9JquyUrkS5C1CU06WKZ?=
 =?us-ascii?Q?6GiJT1QcyfX9HaVwJV8RJHRHxeFaw5EzA/BXHU0JD6GAq7mKKUCITA0Zk8Ix?=
 =?us-ascii?Q?F42cmuTdUN7WJ+xykxx61E0SfaZJICPqDkU2YpE9US1g7GZ/pdsy3+4sEYla?=
 =?us-ascii?Q?aYveX+vHbzYmnG5uIhTtbpI1K3qyn/yyDZlK+7t+T4kOW0S8I4Qvtg3B40fG?=
 =?us-ascii?Q?eYOGmRVmBccpC2E7ZcfaO74gl0pNBi8bOU3buaFpyKI5zHmQYf1Z7mO1KWXf?=
 =?us-ascii?Q?XhzonFk2jNl9SLMoNvyF1SOc1f1jZmTaTpCOVlk88vlZ6nctr5cnVQlOmy8+?=
 =?us-ascii?Q?w7O1jjhV5C5ZjkQIxU+wRL0+CMYue8S4lo493pujAMm6vqf3NXAlo3x+YwAy?=
 =?us-ascii?Q?9xjTjbEy2XAvkjpdidg4RB7RL0lBvAGEDfYjs82PwzZAiwNs8O/1RazfTxnx?=
 =?us-ascii?Q?pacOlX9j9211EDwZNxkBI4dcD90kJg5M7JUWB025lSjPPNNMLikxaw6I0GA+?=
 =?us-ascii?Q?2aykVRI4NHp6dDE+qn1Eu28VVt1YG06t1dMcz+hBMPll75WnkVW69P1883VQ?=
 =?us-ascii?Q?9PieCoTtf6iOXARhDMEGu14eLwxU4eIRGJtI67N98WPz+YDI+Nv8dimgaO5g?=
 =?us-ascii?Q?UDMQxKlT+QK7M9hXWU3P6cEZ2f7xtKxodjq2dZhOHZb8drHS3LPvC4ud8zO1?=
 =?us-ascii?Q?z5VNoBPBOR9BPrY/AiNn7+SVQ15flmKS+6xKTeIvCC51PCYGPDwjKZo238ex?=
 =?us-ascii?Q?iWx9VAO43wq9dKepakZyeh72LI4yQZca6Brvcp+QevhV6N8bg+0X6JtQg6hI?=
 =?us-ascii?Q?xivPMwUwwVJVGO/bSd8DhdOzK6z+zoQWyeNFl2uFmSl1qEPgz0ThEMC9v/QY?=
 =?us-ascii?Q?MTnFh6rmwhVohLmNoc4g4rBqltqpatHYDvviPTaj6ehv7UxspEkICASFFs6Z?=
 =?us-ascii?Q?sIQEnzdm2Gc+bRyHlsmnVsyJ8jTfL/JvizKWI8hacSI9fcI3sv8tlvACQpxO?=
 =?us-ascii?Q?9T/zeaLVMYsUj6NIqXnzsicQww7VZ0YIsH8N50c3538AN54UJYxb6tMeVd6w?=
 =?us-ascii?Q?SzPfw0bKAr8qXfhHZC4l6OQDM83UweelLtEY96XBKmKHhQr9qeKTe6+GiUKe?=
 =?us-ascii?Q?Tx5IT6l6xkqfCnbB8XnVc9WjVawqD79pwENZodlZlzdvw/mAMJcm+sBPWNFZ?=
 =?us-ascii?Q?NdDAxmiSEpwQPPsRoccen9dGo//C8ZJ+Ly4lSc/NDezMDQJUURxUbuzL7w1g?=
 =?us-ascii?Q?a0Dg8tyAKGSZwRc5lFKBCuw4/4SuaWBW2kqUQpzPqxA3WhxzoFFTwgiW0oJ7?=
 =?us-ascii?Q?IwWYXPtRMg6CLgAfI8+U9zFgOJHAKSQDV8gdCRjsG9vF92bWloI5h0x9oZAP?=
 =?us-ascii?Q?WKjwPnZkuu3PNM1xsgx/4JLguYmaSrG5Afpo06OzEXnHA0tP39WQKUpyDysP?=
 =?us-ascii?Q?oSNHoYN3oUeNJmjn8Rtw6FDvknErVRJyGv1mNZGVzoc/+2G1fqyOsKr/2HNh?=
 =?us-ascii?Q?KTs7eTLjLCghGs/8LqdNR/SWf46nltsPdzc7mjJY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5d721e-a613-4b62-ca83-08dd0e02f00d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 10:13:14.0009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VWFW0PK1JbegKElRlGOCGQ0gflP2dmbnUFeCJFtmO05k2xH/eX93+C+P3JVlPqQ+DQ9A66KyoJpIVjjRatiynA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6888

Introduce NUMA node iterators to support circular iteration, starting
from a specified node.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/nodemask.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index b61438313a73..35f1fcdd6a84 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -392,6 +392,21 @@ static inline void __nodes_fold(nodemask_t *dstp, const nodemask_t *origp,
 	for ((node) = 0; (node) < 1 && !nodes_empty(mask); (node)++)
 #endif /* MAX_NUMNODES */
 
+#if MAX_NUMNODES > 1
+#define for_each_node_mask_from(node, mask, start, cnt)			\
+	for ((node) = (start), (cnt) = 0;				\
+	     (cnt) == 0 || (node) != (start);				\
+	     (cnt)++, (node) =						\
+			next_node((node), (mask)) >= MAX_NUMNODES ?	\
+				first_node(mask) :			\
+				next_node((node), (mask)))
+#else /* MAX_NUMNODES == 1 */
+#define for_each_node_mask_from(node, mask, start, cnt)			\
+	for ((node) = 0;						\
+	     (node) < 1 && !nodes_empty(mask);				\
+	     (node)++, (void)(start), (void)(cnt))
+#endif /* MAX_NUMNODES */
+
 /*
  * Bitmasks that are kept for all the nodes.
  */
@@ -441,6 +456,9 @@ static inline int num_node_state(enum node_states state)
 #define for_each_node_state(__node, __state) \
 	for_each_node_mask((__node), node_states[__state])
 
+#define for_each_node_state_from(__node, __state, __start, __cnt) \
+	for_each_node_mask_from((__node), node_states[__state], __start, __cnt)
+
 #define first_online_node	first_node(node_states[N_ONLINE])
 #define first_memory_node	first_node(node_states[N_MEMORY])
 static inline unsigned int next_online_node(int nid)
-- 
2.47.0


