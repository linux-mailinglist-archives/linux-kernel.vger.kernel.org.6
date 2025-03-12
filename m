Return-Path: <linux-kernel+bounces-557285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58684A5D67D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 07:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 674557A9911
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 06:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663EF1E5711;
	Wed, 12 Mar 2025 06:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="J9MCKL/O";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="J9MCKL/O"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9132BD04
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 06:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.54
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741761968; cv=fail; b=aHF7/6GkEvIGbzf4y0ioZHsiNB8sxncuBA4v2G83lUlsoafr7TNnI6w54mv9pSg0yV9JOihyEh8CzIAFAPmrAm7HBe284fR57oDGOGh3sd/X6JwmAMSlAfSwC2te5WJInqbTBAEBownARSn+aKmzScaAhjvOju10BI8dtKGkgRU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741761968; c=relaxed/simple;
	bh=s6ZjYFjmy1rAOFLlLSdZXRHpbCwOkv5d7bTAEySmCcM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BmGHXWJIPjs6xfkyyfpbr3OGTMvniPMU/zDxAe8sX4tIgYdAjSDV0IOcySyUjNqGK7KxOuHSJcjUS9BoMuqENRu9an0e7PwuuvBio1qdZYhN9Iv0jgfsVW2E2TT2aOI5CQlPmzcEtKcyRZAfmqwuoJaYl/898OYMDlPR59Bbxg8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=J9MCKL/O; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=J9MCKL/O; arc=fail smtp.client-ip=40.107.22.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ujDHMKQhzpfsjPt3DeBSigFdjL3HMDOaG32Edmg+UlxcYLI83AgXK+mCQbX/zUxACkqRyjl0sFesOilyxb7dCcwpJhJJ01gGFUL97JhCfgR+9MmQAGtFjIl+6E9uo27o8pCJTGPgMynaIA8U+IPEoP6A8BKG9zE+nh6xr1J+LpHwePUaP9TugTThqZLJrZb4DY2qjBE3c+skERYb9GnczJGg0mYQjMW+2XGBlqJvlD6PlSJFOEPezpCsNbyIpnSqnmPCTBhoNp0DVKyMlHbmbqUNBcA8Ih9GHs2TsV/azI0cxJ3vnXammliPQmuO91al+GBLpi4rOT6dIephY2CrTQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlRxJMTKewKd7Q7QQyvTscaTbHEinhKEX03/TAm3iKU=;
 b=ZwFx03Jhz/bwjL9gwrIo1ccMfsxw7RlBCmF8vjUIMxzeOXP+ExW9rN2AaoK2lzBysoX57Onj6ihoKx+lWKTXUOdbWC3CQyylw1l8jX4qenk1g9rsRMvr7Zu1cvzwki23UxKmOhHG6jhYLWbhVCej/qsHTm0JQX5+Vh2BwLpocZEwKKQ9Lm6zbhLHSlSyRoBTA7oPyN/R3bqwUKPW8YNo4jicLZScNLeD92s3UNAUr40WP45GAQMOTqYlAlmOuGcKT+stJyILxcTCq6vwWmrfMm2f3tTDSCac8Grl1b6hKYFQu/8ZrhDNme3n90tJ0Jilf6tP/fx4/JtlmZ41wVMe6w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlRxJMTKewKd7Q7QQyvTscaTbHEinhKEX03/TAm3iKU=;
 b=J9MCKL/Ow1IAPW/WNS6pu+zYyukbFd0wNEMEH8ZCrW4pNzsKRtp3ZXcht9J8hMPagM23dmtSRdt/SxMpUhcvvkGWiswcrrRHaYtQ2KEwMyv9SD6sJulFrhqoYEY/Gpw5cnAiEXx11L3AByjEJnX6ESDplKctSZnLESZg29OWPCk=
Received: from AS4PR09CA0025.eurprd09.prod.outlook.com (2603:10a6:20b:5d4::15)
 by AS8PR08MB10100.eurprd08.prod.outlook.com (2603:10a6:20b:63e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 06:45:58 +0000
Received: from AM3PEPF00009BA0.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d4:cafe::ed) by AS4PR09CA0025.outlook.office365.com
 (2603:10a6:20b:5d4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.25 via Frontend Transport; Wed,
 12 Mar 2025 06:45:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM3PEPF00009BA0.mail.protection.outlook.com (10.167.16.25) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Wed, 12 Mar 2025 06:45:56 +0000
Received: ("Tessian outbound a5818d08f071:v585"); Wed, 12 Mar 2025 06:45:56 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d046dbcee661a8fc
X-TessianGatewayMetadata: jhxmrTtoxLNLBJ8gPaS276qo14FEALr6rji4uAyBPnjMokWsw14YiHzql5f7BlrLRxTB56cseWLvdIr90r5HbxolYqFxgHf4bE8OZXWoYaz1U4PKghWAwZsbIBHs/ydoQvzeNnhWqk8zfApZJ0xU5aI1zGqiaPAVfck04Cx6OW8ZIVYh1YoI92vMy4THZLTcIMEpU7M+yWaGjq9MjM3wSw==
X-CR-MTA-TID: 64aa7808
Received: from Lcc4f958e5b3e.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 6A10D1C6-3861-49A6-80C1-5F3B64122CF3.1;
	Wed, 12 Mar 2025 06:45:45 +0000
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lcc4f958e5b3e.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Wed, 12 Mar 2025 06:45:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d10AsIZBKr0rJi+UbO8Oym/x06xo4gfwR72OmtfGo+q6sgMf4rIGEg8N6ZMDLb4+hYIuUszdP2reVAOMBcE8rBkr8KZAiYDlNEw2+F3oFDXa+NXOqAQ90X5HARtfTR2/56VK2Qonng+0dfEvQUHmXoID0Qr+NQChu3LySfMzzOwsQN1HPIZW4SXP5csEq+2dKlJPwGV5/nq22GroaU3J++6QImB3WI9D6d/081ucaxZ2QrsLM4KylF3Z3UueNu5LZvu/nNbLxC2aWbrBRMFznxOOaiIjvbCsqkRFRqpR76ZQR+fXuxnFQtpJvLTcuqwh91wdOF5PSR7CFLEZKyUt8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlRxJMTKewKd7Q7QQyvTscaTbHEinhKEX03/TAm3iKU=;
 b=FBcdOKntLSkZLX1OjpvA0ZYAfPTTIgWfEF3aSRzapjdHulmdogsq72JKOijSfVH/cwg2GBXDqkOjY4tI+8wKqfRK85H9aA4BpeY1SF2GVB2+khDMRr4XHGNcyOGXRtXnoXGEZuFef+Ox7EPyvK4QmbmiaC2V/hb1ZM0aQ3CdLhMX/mQKiZAYxgcVIOdtmBfTOapgPKa9oCWJPlfPwcFQdoPRczuFoC7VfEkysveTqaW99UhFKvfowSdQaIuP2hVOZBdTi3ZsKdE6ENwszn8fhir8ACNTQW4NNs+xyu0SIDGR7oW8UmJZEGbiwgs6//7GzBg1lusIKZduubJ5F2A9Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlRxJMTKewKd7Q7QQyvTscaTbHEinhKEX03/TAm3iKU=;
 b=J9MCKL/Ow1IAPW/WNS6pu+zYyukbFd0wNEMEH8ZCrW4pNzsKRtp3ZXcht9J8hMPagM23dmtSRdt/SxMpUhcvvkGWiswcrrRHaYtQ2KEwMyv9SD6sJulFrhqoYEY/Gpw5cnAiEXx11L3AByjEJnX6ESDplKctSZnLESZg29OWPCk=
Received: from PA6PR08MB10526.eurprd08.prod.outlook.com
 (2603:10a6:102:3d5::16) by AS2PR08MB8381.eurprd08.prod.outlook.com
 (2603:10a6:20b:558::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 06:45:41 +0000
Received: from PA6PR08MB10526.eurprd08.prod.outlook.com
 ([fe80::b3fc:bdd1:c52c:6d95]) by PA6PR08MB10526.eurprd08.prod.outlook.com
 ([fe80::b3fc:bdd1:c52c:6d95%2]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 06:45:41 +0000
From: Yeo Reum Yun <YeoReum.Yun@arm.com>
To: Suzuki Poulose <Suzuki.Poulose@arm.com>
CC: "mike.leach@linaro.org" <mike.leach@linaro.org>, "james.clark@linaro.org"
	<james.clark@linaro.org>, "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>, "coresight@lists.linaro.org"
	<coresight@lists.linaro.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] coresight/etm4x: disallow altering config via sysfs
 while enabled
Thread-Topic: [PATCH 1/4] coresight/etm4x: disallow altering config via sysfs
 while enabled
Thread-Index:
 AQHbU8m8TEnYl8CikUKII/YDjzuo1bMOcL2AgAAEFQCAAAWKgIAAWPOAgAABdI2AYLhYpg==
Date: Wed, 12 Mar 2025 06:45:41 +0000
Message-ID:
 <PA6PR08MB105264F47A8399568DA2D3344FBD02@PA6PR08MB10526.eurprd08.prod.outlook.com>
References: <20241221165934.1161856-1-yeoreum.yun@arm.com>
 <20241221165934.1161856-2-yeoreum.yun@arm.com>
 <6bbc9b64-3ecb-46c3-8c4e-55dba6301ef3@arm.com>
 <Z3+6kL7OGDX/pNul@e129823.arm.com>
 <4f9d2bed-7ce0-429e-83cc-ad6cbcc6085e@arm.com>
 <Z4AJ0kc0DxVwhLlu@e129823.arm.com>
 <GV1PR08MB105212E5552EB50968383C6D6FB132@GV1PR08MB10521.eurprd08.prod.outlook.com>
In-Reply-To:
 <GV1PR08MB105212E5552EB50968383C6D6FB132@GV1PR08MB10521.eurprd08.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	PA6PR08MB10526:EE_|AS2PR08MB8381:EE_|AM3PEPF00009BA0:EE_|AS8PR08MB10100:EE_
X-MS-Office365-Filtering-Correlation-Id: 8675ea68-ea43-4f29-ec87-08dd61318adf
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700018|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?KdDRPu7iiVhjHj7yKUvgu1qlIkNhFoRsbAAh01KjwPjq0ovr+l9St2kU2rS2?=
 =?us-ascii?Q?X31LDfCJLpmV6wnkKPbnh/C5cifvR85UumnTZGsyUw4QB+oWLatE0zyfEKqd?=
 =?us-ascii?Q?5iUi4z/yrXYS7HpMx2EJbEowc7OWJ+CmW6N0xFK/4VMePrvxSXsD52IJikpq?=
 =?us-ascii?Q?hKcpm8nirSW4mj5IOtVDU3+v77jN7ICb6rzd/YDLjrPOn8O9lrrahKp3Rjqu?=
 =?us-ascii?Q?V7IReB703ldLBiPvRkVPIfg5RcKSALPundP2AH01UoH2RfSqqcF4Gz31a3md?=
 =?us-ascii?Q?S5NQ9B7/Xoi8jJQnrl4fNwlOCJhFdjYz02/uUOF/iSwXwOQJzzovX4hSjonc?=
 =?us-ascii?Q?BfXbEzxmbj+MVnXu+aUu0KxsVKj9U3vCsG8L+TXFTGJ09qxgXN2BjyomOSbq?=
 =?us-ascii?Q?dS2Iyv+F6akWVfpA5zO1MZGtA0Zdiqa6s1ehNgGJf6w6ZHUUaJUgKy64UtsE?=
 =?us-ascii?Q?v60wDTJXTCd+xWd7KZZkt+1WXXdlPzjPbRHrJbnWsDKcv9hk93t7AW0EgtE7?=
 =?us-ascii?Q?B1DPT3jDfgoU3IHJR/U624vXTrtQe4/jF28S/lnsfNBDTpIRVZi3ALDlCbqv?=
 =?us-ascii?Q?rxVs1rOACu9RMv0Zk++XtDrMe5YalLec8bQy7JYzCUxJnOUPsCBjUw3qWjNi?=
 =?us-ascii?Q?3ZNxI/EOxoAvpYLwzN9ihwuBuJOy+oCoK9vCIBSPyud0Thqdf5R/nDDJ9ztr?=
 =?us-ascii?Q?cxayp86hZQYNhuwKQLPCAuWYbyeINVWyZgmXi0WEfMJdWy5lW9qqI6ofPXkn?=
 =?us-ascii?Q?BDJG+nU3ZBd5LyXYlTwLvFfOnO7YXzod10HKFFgaJP1B7fSCAYPW+e1o0qrU?=
 =?us-ascii?Q?v1MJn296Rk4XIo4YaMSNZ8jtYE8QHxyCEwGGj16Pur3QZlvRyPF6cRuizweM?=
 =?us-ascii?Q?ZAuHC0uAEMCHgTzFXkgRboRUZNJfW3vR9ovcrgYDoiot7wtz5rZkzoNi8YNS?=
 =?us-ascii?Q?1NKIertUM8ZokSTsP1APJrbYiRlpqd4eRvXNG3LxJ6baQ4IwUAuOmBTcfhYX?=
 =?us-ascii?Q?qo77F+nWKb+AmW/KfeMX2FLrFry+WMU8BqSQMNyAIiGQ4Vjn1Sr7g5uHTwx/?=
 =?us-ascii?Q?50NDpWVnt4kPdFXlOtWtJE/ttkRZ90Rw01NnGqBVsq+N4z3De/T28vt8u34+?=
 =?us-ascii?Q?ySzrhAiKUNKjf0NOSyWZKuZz+DvfQeGHIi4MqwMCj24RIqT2oIHzLrkDawI+?=
 =?us-ascii?Q?MDbkmysW3TvAm/0xSkJKU/g4A18RXmQR97Hikl9NAaZc5MciYTEgCZA0+Bx4?=
 =?us-ascii?Q?X1Q2wKo7GbFbKZSJ5Dxt0qhjt0gfxxCZBDM6k2UiVXf1hX0sDVgdLgQGeLWy?=
 =?us-ascii?Q?tac1W3ZF4hPjERd8sbZZll6cENJufFHVKtFhoxPzOrP5nEjryDPGX2gkRoqW?=
 =?us-ascii?Q?BS6W8HcyyEOTp3tBevEcQr3+WedCrWoXS2WLnpFc6Iqaf55n2BI7Nw4iOlTE?=
 =?us-ascii?Q?7ljWmM5HA5HVamn7Q9wz+eUcBLBe0CSq?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR08MB10526.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8381
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:102:3d5::16];domain=PA6PR08MB10526.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009BA0.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c1db43c4-484a-4a5f-d9d3-08dd613181f4
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|35042699022|14060799003|36860700013|82310400026|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uVQPxQIYR/xQAAUWq1RsOnA1Lz15CdtV2+Q8/+E2ioDt2nmR4OKPitQBEa6R?=
 =?us-ascii?Q?xYsJdWp3D9yriFcXO/iYj6Wb3PEloYayKUOODyx80IZWwWuheZaYbklWuYNG?=
 =?us-ascii?Q?9I6Ne7BeO62RdFJ4CAlMMH4TrDZiD+RD4GlP3FoI5va9+Glv0AgF4ZauB5xM?=
 =?us-ascii?Q?SKgQVRznET76Te1ycq/SJLUlZ3OlJglY2emwQbHG0iZrgnrZbGMLyI+qKcGi?=
 =?us-ascii?Q?37MjBeFCFJ8VaYHq2UFQNWWeVH6zTIEDEy32MVmMDwGTmoKGr7GPSG2MoZ5d?=
 =?us-ascii?Q?77QZFBTnJb8uAQFgbmW4oA3XHTtGYGZScEhuk5Lk8+BqKexy7h/ahl/3bqUd?=
 =?us-ascii?Q?R6mELhN6FpKQJp+01VWsrq3UzY0z73Pi8SMPPX6rps4bWA1B0j+izhiEAgFS?=
 =?us-ascii?Q?zcqqyajKSf3sA3ACBOghIgBodz5/6zlQFyhBX3n01CqAsL3aP9OQAGEyNQmB?=
 =?us-ascii?Q?7fuXDSvqcBcm5b+KWKKLCyqOJi93gL4QaJDT60V8tDVkd2XrUny2x0XgaG6q?=
 =?us-ascii?Q?p5FxXicNhDS5QpL6sOdANfe4h+37DYCAITPAT47SmY2uGEgWHTGA7e9zj8XD?=
 =?us-ascii?Q?UeFIfmE9B39GN+PZDi45nxOq+K4NuaxRlfduK5MFlXGVuVnLBqsEJ87w0I0J?=
 =?us-ascii?Q?+sxq9UzNN/gz2GORMrKVytPyI760tsSh0LAergagBZC7PuLU5K0mjPrItZtm?=
 =?us-ascii?Q?T+2jKpHGA+ixafTkW6pL8DnzuepAtAYpRHFSekho/H/Y7WEA74xIBMq6xk8e?=
 =?us-ascii?Q?z48K23YksKi5p6+0lyULm3Uk5uGSGa7NvYjHnK6LSHJ2k0nONIZh38TSZoKT?=
 =?us-ascii?Q?qyAscSg6GRT/Vtt7sies8DagdL17HOdheCgFZ2J8OI7TOQpJutHheaTpYwfC?=
 =?us-ascii?Q?WiYjCZlpvg/cOMjyEZJ+e4pHkBthq+gk5lrH9X4HMWdgYcoDSNSyJd7paFVe?=
 =?us-ascii?Q?HLBHgKDNgi1ppeugPpS5eYsJsQd0R2RkLkw6cVArfy1y0zCP3ghfWuPAUSHu?=
 =?us-ascii?Q?VbfxDa9NQ0EOv5Za6FcJFS65w4XCVGsKNeHqKxrzTiDmBpy6uXGzaiMk7OPm?=
 =?us-ascii?Q?+ZRrgHFJKqG8Rsudh9uvLyD4JRY/32jiazhqlYxR8Avby4pqzOvx+UBylL33?=
 =?us-ascii?Q?kqY2gtuYh22MkD/OVlsE/ERoMUaPs5RjMaTOnntEbZH3rRbRj4DWTuUrWBcb?=
 =?us-ascii?Q?VW3bR5jUJSvuiYSjOl+D2/Iom3I/xFKWDK0BBeE2O4G4YJfNkSlFf8UrlQ54?=
 =?us-ascii?Q?t9hCnO1+O02OIHxXJzsyynz8UzonTeuE1lesdp9GDpHVWtzSAJSmmyQlUABL?=
 =?us-ascii?Q?RgR/uVnkcOM+FRXoSi20dkgq6Ro+aBMReBdPQrwIUskylFd1KgPFigTNV8r6?=
 =?us-ascii?Q?/1rHwAppNnY3ZhrNlnQnVwWos8PuV5+K0Zs2D+3jCx2wF6CdfT2Lx87w2xNb?=
 =?us-ascii?Q?VGE6Y1nD+891qFLIeJ45e5Fm4g4ZAc3cbepqcemMMA8YL+nh5hIBInjkBOrU?=
 =?us-ascii?Q?LaAswmz+5s9UInk=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(1800799024)(35042699022)(14060799003)(36860700013)(82310400026)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 06:45:56.7232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8675ea68-ea43-4f29-ec87-08dd61318adf
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA0.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10100

Gentle ping in case of forgotten.

________________________________________
From: Yeo Reum Yun <YeoReum.Yun@arm.com>
Sent: 09 January 2025 17:48
To: Suzuki Poulose
Cc: mike.leach@linaro.org; james.clark@linaro.org; alexander.shishkin@linux=
.intel.com; coresight@lists.linaro.org; linux-arm-kernel@lists.infradead.or=
g; linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] coresight/etm4x: disallow altering config via sysf=
s while enabled

> > On 09/01/2025 12:01, Yeoreum Yun wrote:
> > > Hi Suzuki,
> > >
> > > > Is it not better to have separate "configs" for perf and sysfs ?
> > > > And etmX driver can populate the "running" config, based on the
> > > > mode specific config. That way, the configs can be updated
> > > > independently without affecting the running config or the perf one.
> > > >
> > >
> > > That was i've tried but I've accepted Mike's opinion that
> > > it's enough to check whether CS_MODE_DISABLED via coresight_get_mode(=
)
> > > in *_store().
> > >
> > > "the .._store functions in sysfs should use coresight_get_mode() to e=
nsure
> > > this is set to CS_MODE_DISABLED before altering the config,
> > > which ensures that the trace system is inactive.
> > > We don't' really care about reading the config if trace is running."
> >
> > There are two issues with that :
> >
> > 1. Sprinkling the get_mode call in each sysfs stor function doesn't loo=
k
> > good to me.
> >
> > 2. Someone preparing for a sysfs session must not be prevented from doi=
ng so
> > just because there is a perf session running.
> >
> >
> > Suzuki
> >
>
> But, when separate the config, it doesn't show anymore the current
> configuration set by perf.
> I'm not sure this is okay.
> IMHO, If perf is enabled, since the configuration show the "perf",
> I think prohabit to modify config via sysfs while PERF_ENABLE seems valid=
.
>
> and about lossing session, I think this is up to user.
> That means to use sysfs, user shouldn't use perf to prevent loss
> its configuration.
>
> Am I missing something?
>
> Thanks

And one more question.
When CS_SYSFS_ENABLE,  Is it valid to allow modification of "config"?
I think It seems valid to show the "current working configration".
If It allows to modificaiton the config value showed via sysfs and current =
applied be different.

So, IMHO, It seems to valid to modify "config" only in CS_DISABLED.

Am I missing something?

Thanks.




