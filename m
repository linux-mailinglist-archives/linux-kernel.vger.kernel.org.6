Return-Path: <linux-kernel+bounces-398911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DED29BF7DE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 21:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 061E91F22DF4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 20:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3852920C012;
	Wed,  6 Nov 2024 20:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CMs6oM9I";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ho4DjLfh"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E2320969F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 20:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730924334; cv=fail; b=fS0hUP8DWSja1eF9OYxSbrX+BOg2/JIxBJn0JLqf9g4K/CzjCSkcbbDw+RZCLFuezjcDiCF4UvpqWNCMSDETuFWaDA1a4PcHTMFQpue3nN2ss0sKHYQ5CcrpitveyVf3KXrI/UsXf0kVBcTDsQWnYcZa0CH9me1F5eKr7uIvOYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730924334; c=relaxed/simple;
	bh=zcjFs6TyjKz83BInauvuVDqLq7rg48NpQDCRojhjlkM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nuqAZ/s0heZrxCixYjGwkfnuSEB30qCRWW3H8Q6VE8e7KAAs3VlDmhaza8eNpWZY43lAjPhE/qusPwiGZRuTmePvkJLjjIxGZgWgnYEBJu+0lb/blFqo6A8RWjxr33m5wQjrInFgMzPytgA6GahyFEE9VxVQfY+76oJ6xDH0bjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CMs6oM9I; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ho4DjLfh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6JXZLa011045;
	Wed, 6 Nov 2024 20:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=UpJ9fkP++DjZrWSu
	DKs2OCxogNKHZ24JRIEPEM1IIYo=; b=CMs6oM9IB5vWC4TYchPHdh/SPE0c1eLP
	KfhofXgz3m52ouG2hyUMsHLSR80BCrZtYg5qk4s0MXpdWc3M4fR/iaxDSjtHD+se
	KIWzkwCvSObHLEMrW1tVJfGxCo2tMUTygWVeJrlmcnPT1wx6SS8kqngtLO083WrQ
	w9VhmDCGhbXVSu1gF3agNCVukl6CxVHTKeWdVynTHaNAyB5Bm6JKGkTwCO1n0zca
	OZe2dgPTbYOA7d6F7unZwRoLX35c/rEOTORvzbrIZayH5a9KZ9/w3ywC5BY0t9vc
	oIN7yVE03dy8w3rcpJfQ35a/tRMezbJITSfOofTMD0K9ZcuD/Y5HnQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nb0ch1vf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 20:18:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6ItHS2008469;
	Wed, 6 Nov 2024 20:18:28 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42nah91n0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 20:18:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1Sl81unTf2HPhkvgflUNaSabQZRrYa8Al2WJsrliHXzd1A93znAyXOeqO+ZFPu5gdR8eniziuIxljEvCKRgH1MQkGRVGcelJtzRpJzWHGbxmxhnUkYeWbRKWLAIQ8BrA9luJJj8wOgQcgI80jK3cUSxT8T4Ai7zQhAMSjNWWtqfi/LU5yu0C2l1tQswu1pry9pzOyWeBQTUxmykgPZDNJAGl+692X8ekO5lZ0ZG7Hx6lMUcy4Gf/ia9HW+2OrZijRhNhz0rK3ra8ViRL3N+2EW6gIqSQG72Z9MpClDP2Koak050YgkVjZ7AycRiyBCTqYSuf7Ch5sfdpY4UlrzQeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpJ9fkP++DjZrWSuDKs2OCxogNKHZ24JRIEPEM1IIYo=;
 b=zELVKXY9nc4przU0OJe4S6AJ6Q2NP+mB5snIoZO5c71l48YHx5/xo5/XJCmamInKks9ED1gVRtZDv97mxvJl2G9NwVjx0x5godabQIXPtsNP+61S/g57YxP0BZwUnvQ2/gUeYgmIHvdDXJ/Yf0t5efGzGoIBKJ21HprhUCHPk5nM0xpTYgVDH8J35dwZVwMGk4MA1rRz/4yMRwNI5gV/J+KIJkh4bNnbI3J/SM49cVyYUDP7yRsmAWCaS6V87ceBSVKmdlrxdCtOy/J/PJOlPqpUI5Q8laV8FFrIs5D0p5//XGFnB22dRAvAi25hSiMDXjtjDEW/krC3bNBgkaUmBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpJ9fkP++DjZrWSuDKs2OCxogNKHZ24JRIEPEM1IIYo=;
 b=ho4DjLfhFq5lQD0a4YYcRTAB0yovV7EEWlyK+4+J15obDM2+FEbdqccMDqdBGi1/k5v5x/PMpyDegiFy0BTR794pJdQEwn3ZXIcEX0MzfG1I5C8KTEB54DjEdE0Lr+5m4bokBLSA0ODQEKuNPXIBpSjh7ZF+ZAEbB1J2RmYySeQ=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by LV3PR10MB8107.namprd10.prod.outlook.com (2603:10b6:408:290::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Wed, 6 Nov
 2024 20:18:01 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%5]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 20:18:01 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, bigeasy@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, frederic@kernel.org, ankur.a.arora@oracle.com,
        efault@gmx.de, sshegde@linux.ibm.com, boris.ostrovsky@oracle.com
Subject: [PATCH v2 0/6] RCU changes for PREEMPT_LAZY
Date: Wed,  6 Nov 2024 12:17:52 -0800
Message-Id: <20241106201758.428310-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P222CA0022.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::27) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|LV3PR10MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: 8166fe4a-6c1d-4fd7-e162-08dcfea01cca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LsfWLNHuScdfZvMqEZE7+nSAjTOWX+Inlo2F6oU+6IGJgj2hGaKvWhqcLmUa?=
 =?us-ascii?Q?7NADq0J/yfgixGO5m6q+rvCH129sqgooefxOPRsT94Rh2mbxNL+rGJQxiNUB?=
 =?us-ascii?Q?3/gx375yAHfjAo+ea4zc7XgUVMHODATqnK6OiZ2Qixlivi10YGWWMMnBDhVV?=
 =?us-ascii?Q?jJ0pQtoIT7dezFdGO4El/KSRsOyM+N8bnwfNeHVuXd/1x9AMnDNCxXQl5AAa?=
 =?us-ascii?Q?ydaNXydkePlCrCry/KWiVDrC3cOUvuAsxNDplY3MkhDM1y2dYs1o7TOVFCVo?=
 =?us-ascii?Q?T8sboiEVpENqeE9uSu8exNqjmGZURatDOF09H3WciLdjlsGO33vlTaw1BnvQ?=
 =?us-ascii?Q?M+gA0oAz8klUEQpnt8OVHZ/nOGXgb/k0j5fyYQR4qfG+UbUC3XPXdnqJvR6n?=
 =?us-ascii?Q?8ryLEruFCcrHEwgMm7e7tma8SjafalvA25dA8AeY+UsNy+nEV6zEG6rjxxnf?=
 =?us-ascii?Q?SnfhQ9fGGemY7KR77ExOOXEfeY0cS7rCOBk+ak7cfjdK+BXlAXmo+Zc2AFOf?=
 =?us-ascii?Q?0cT7Erfvk91jdwdpzaSnyMubCSrpx3eI3mxpXbkYKH5j7sIBHtf4CmiV5WAb?=
 =?us-ascii?Q?S6NLbkwQKNj7fMZIyQ9L8w/J95m5Y6fcvYLh0lW8GdEuXW9x3cny0kEEtYms?=
 =?us-ascii?Q?+yZ15M69ZVJghnwI9l/qVE0gKTOUV2t7rkSL7lkB8peJ46W00e3fIJqdVVcP?=
 =?us-ascii?Q?u5vyYQzzY6/i+ZWM4VCQfHDseio1eG8QQJMKCGS0HYP37hzyCszKMMfsgSA2?=
 =?us-ascii?Q?5XEsA5Kcqg0riD1eCK/MkCdLJiiVfecMjpwFKaJdumPgYxvgvau9EJ1kuBn6?=
 =?us-ascii?Q?nLBzC3eJYIgbkGDlFlVs50SgsvtJyw9xkz682MU6eCJMnE21LVmIKhJRfQaW?=
 =?us-ascii?Q?PHSqnVboYnApW2g/8sDAbWneVETaHNHvc9wJ+0AZWhSJSSeXzOzuQlxveABg?=
 =?us-ascii?Q?8ukpf8/apb4EYM6fAjiPPD75LkznLdF/ZUS7uU+UUrfonS8OzauFFhVzUzTq?=
 =?us-ascii?Q?mvjoRqTqAadSKsc6c8R7PVd8yroNyoFGssiz/nimLz+VnVGcGiQdDmqZk4IW?=
 =?us-ascii?Q?H/NX84TLn9nAENnvPgYgFupr3jpgLi0zRx8vjRjThJErqx8ddhsF6FhXKF5Z?=
 =?us-ascii?Q?TyteEB8vwhv+3puiW9sAW8lhK14HqpphT7zaMr2KxXibxxIntKqrXbsNrggJ?=
 =?us-ascii?Q?ih6L6yZORSgH7xNtBqUype+b59W2yImu9Ph3q9iS9kx14VMC2ex9x+ZSvRxR?=
 =?us-ascii?Q?cqFAoyegKs9LJIX2H0D1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?egyBrDmOxpN7Pnz5pEj2GLGFxwG7whJ8ctRlQQ/rr+IcD/+Afo69ZxT90EwK?=
 =?us-ascii?Q?k+blt0u+x5qi1vpsn/Cn4C5fRwBZUkcS8YaS+ESIWHwVQhofz1AhEl8esAvs?=
 =?us-ascii?Q?MHY/kLCQQjIhs92lDWSGPyFGddmIDpHpKN01opoLQ5zlJCEwqktNStFtEMrW?=
 =?us-ascii?Q?kg4Fm22tFq73HBWijFywNM9oLeboV0mfuAdRVtDDG8jU2rJ2WFdhuG299Gee?=
 =?us-ascii?Q?VOAvAp8OzeTrmKsubFK+iAltXeACh/lXljk5DTTmUF9yVVMVorLB/84BkqXY?=
 =?us-ascii?Q?ZJeX+e1Whz33EOdt4fV2GhmRO9Cknk3p43ncOFK9VboBvnU052iEnFyHH0hX?=
 =?us-ascii?Q?M5nmhQqn8HPplsCWSOicAR9ljpCcG53KUrRCxqS1Mz0oVYwsh+6n1gQvCD0u?=
 =?us-ascii?Q?ac/qHqx91adZIzToyvS1YsGgPFM2irdhfshlHE62d+Zbu6sm5C6DAU3FFETR?=
 =?us-ascii?Q?2dKQIg6F75iIk9Bnjo2Jiy7ht5itcf1d4650UwwnLrFs0iu5+xnMtpadq4lf?=
 =?us-ascii?Q?2McE8QfVkTw46IL3Ph+TnKDHPl78w2Kof0YwQuNXQwdn34485nnhL5xdq42Y?=
 =?us-ascii?Q?nM2by25gJOh8rXnGlrmsnfEKtwlhpC6BBZG2t7+vaY370LeO050kuHVpnOJH?=
 =?us-ascii?Q?7L9/BUyokTNwh/rzkEQUFKFb9d79xI9r7lV6/3RM5si8dzJDevmhArV4ZJUh?=
 =?us-ascii?Q?zmEkB56E4YzDu8RN0arcch2lNt2hJecpb3eHaWVB7y6pbhssz1RxelrDEgVb?=
 =?us-ascii?Q?imm3ovn33D/eKxIB3uKDVROM9Nq/V4ZYFewULmroFtIS0dFCieNcd4mJx+Qq?=
 =?us-ascii?Q?5l2Gqsqda8AmDxzk9/LcHhQj6IhHY9MvXo6hrA4m2ft/paD0wV/YEWI5j41s?=
 =?us-ascii?Q?CdQr0kQZUg9IRgqunDzxsTP12hGFYI4MycYh3b5EAolgO6uBWCfGrXBurgI4?=
 =?us-ascii?Q?dKOWEIqwxmcVEn27d2xNnhnvXzGGR9g4Xtppv5SQlvZ3iRvR7cAfXprJfGgA?=
 =?us-ascii?Q?LaeOEaGZxZ3fDp1GcMb8plwXoyOt0rfionJzd8QBxAb5lRHJdqcJv8otwW9H?=
 =?us-ascii?Q?0jgdXKa+rY25yOvWW7Mkz7Eddp+x6SDt0lQIAj5hE8OVLmM2LtK095TgkKoJ?=
 =?us-ascii?Q?cuZWrogHkPHqkg8dbHbogEGzHRjTCuLU+wIvOxr2TwhP7MYMz2w0+BpqPBn4?=
 =?us-ascii?Q?v8+egPHe2gqjanqwdWvRIJDZi7t0lcadi9qVQvC2sa54nI/fLzQWAX1BFoP7?=
 =?us-ascii?Q?T0VS8Vilw4WOY5WIkaS7VbeJRvltJ0n1CMZknOUwgbbfch7QQ3vb5wcIEQKX?=
 =?us-ascii?Q?i/++g+qjaACfcIi9ggkAfiYnsDx3A/3JYkO4JUTZwNEv9e2c1kirNIxKFlqb?=
 =?us-ascii?Q?Rb5ifFXrzX/UD8XNKyX8SMPvwwvlaUOOtOjaFLoPKUhJgDGDi9rIO4hwTNPz?=
 =?us-ascii?Q?3pq+4r9sdIrpXpfXiFC4Wr9cwAfsclcHUXFHNq2XbbpmV5NLiosI7fVZJozz?=
 =?us-ascii?Q?G33AKLwa4C7za8CMiNJEPV+gpULwGG9kptE2EAq8eqthJbOZkCMbKw4fIf8U?=
 =?us-ascii?Q?p8wxkm2a8n65UCSPDfK/vWqdYSXwHUrmCkaHlLKtbBm5OuGTwuK4vUs5fd/K?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zuRBGqW/8SdnUG5Jo1ZySO/jwgeHgW5CCDuenGO8e7dYjFP8eds8hFTDM1Mu94xXKD1CgiIghjMF6IQfU2cxVCsNQaJ/K46/OTG3ONzy80as6RX89TjOMoNQJUnmfz9c9X3aSWZMXDB0hHxYsDDWgF/zrwC/F6aJx9W+A90mmk5pYd5rW9EL+ZsbbP8GHcSnNmN/TXHkYGdvey0d+BXn1KN9+QQs/mwHH5OPpRn5d7MetJkCO5MqrB08+eEr1jFEM1vXTLr6TYC4zhRFf0gFN6ucjq8wc0qFR+/9IeOrhHLuCceHW4/quFuga3smxY2Qa6PwKA1WPFaNnZqJ6lTQdGsCBH+I/Ru+ftCLjUJQRrFNt+yy40eEwryYbynz33i5IjLPQQ99fsh5Pf0hAIchVIskImktJCDVm3+7/VgXM2FdYKrFas+BTBEWX6/GttLvJ8EZuJNke7cia/N9lVoPohHUHOQ7sCiY51vR+5YrJ8B1fgzJ9J/lyMYF1hJHT60yLvmYz4Q0noHypC/0S96RfRbzNVwpbDgT5jWWnbtR2kErL0l+OjKsqFqKabclcB/BPqpPqCqcmNd8/N07ds4cbsPYjQgZ2ykMwf7RM6SfO28=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8166fe4a-6c1d-4fd7-e162-08dcfea01cca
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 20:18:01.3357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3dXfkkfiu0GxIIubzk8/HJZfM5iogXVwAiS7uqL+lXDhG0hsdF+UqWqW5wE13V71gN0rGXca2J2nrtAxwlkzeJbnqBPS46HKXSyr36rwvro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8107
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_13,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=678 bulkscore=0 spamscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411060155
X-Proofpoint-ORIG-GUID: ZqD9OJb7sq6YGq3PxqixAkURZKcrWBsv
X-Proofpoint-GUID: ZqD9OJb7sq6YGq3PxqixAkURZKcrWBsv

This series adds RCU and some leftover scheduler bits for lazy
preemption.

The main problem addressed in the RCU related patches is that before
PREEMPT_LAZY, PREEMPTION=y implied PREEMPT_RCU=y. With PREEMPT_LAZY,
that's no longer true. 

That's because PREEMPT_RCU makes some trade-offs to optimize for
latency as opposed to throughput, and configurations with limited
preemption might prefer the stronger forward-progress guarantees of
PREEMPT_RCU=n.

Accordingly, with standalone PREEMPT_LAZY (much like PREEMPT_NONE,
PREEMPT_VOLUNTARY) we want to use PREEMPT_RCU=n. And, when used in
conjunction with PREEMPT_DYNAMIC, we continue to use PREEMPT_RCU=y.

Patches 1 and 2 are cleanup patches:
  "rcu: fix header guard for rcu_all_qs()"
  "rcu: rename PREEMPT_AUTO to PREEMPT_LAZY"

Patch 3, "rcu: limit PREEMPT_RCU configurations", explicitly limits
PREEMPT_RCU=y to the PREEMPT_DYNAMIC or the latency oriented models.

Patches 4 and 5,
  "rcu: handle quiescent states for PREEMPT_RCU=n, PREEMPT_COUNT=y"
  "osnoise: handle quiescent states for PREEMPT_RCU=n, PREEMPTION=y"

handle quiescent states for the (PREEMPT_LAZY=y, PREEMPT_RCU=n)
configuration.

And, finally patch-6
  "sched: warn for high latency with TIF_NEED_RESCHED_LAZY"
adds high latency warning for TIF_NEED_RESCHED_LAZY.

Goes on top of PeterZ's tree:

 git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/core

Changelog:
  - fixup incorrect usage of tif_need_resched_lazy() (comment from
    from Sebastian Andrzej Siewior)
  - massaged the commit messages a bit
  - drops the powerpc support for PREEMPT_LAZY as that was orthogonal
    to this series (Shrikanth will send that out separately.)

Please review.

Ankur Arora (6):
  rcu: fix header guard for rcu_all_qs()
  rcu: rename PREEMPT_AUTO to PREEMPT_LAZY
  rcu: limit PREEMPT_RCU configurations
  rcu: handle quiescent states for PREEMPT_RCU=n, PREEMPT_COUNT=y
  osnoise: handle quiescent states for PREEMPT_RCU=n, PREEMPTION=y
  sched: warn for high latency with TIF_NEED_RESCHED_LAZY

 include/linux/rcutree.h      |  2 +-
 include/linux/srcutiny.h     |  2 +-
 kernel/rcu/Kconfig           |  4 ++--
 kernel/rcu/srcutiny.c        | 14 +++++++-------
 kernel/rcu/tree_plugin.h     | 11 +++++++----
 kernel/sched/core.c          |  3 ++-
 kernel/sched/debug.c         |  7 +++++--
 kernel/trace/trace_osnoise.c | 22 ++++++++++++----------
 8 files changed, 37 insertions(+), 28 deletions(-)

-- 
2.43.5


