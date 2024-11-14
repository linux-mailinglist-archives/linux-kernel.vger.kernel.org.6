Return-Path: <linux-kernel+bounces-409621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E81FC9C8FDE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF008B47C29
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9162166F25;
	Thu, 14 Nov 2024 16:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="YmsAOW4X";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="LmEJJ62R"
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3910515DBB3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731600714; cv=fail; b=qwvRDQawxup8/mUn/xoworAoy/2wBazgokjTu1r0RC1s5beoKoru2MCejpatcoRU9TD9oDQG0Y+sHBjI8zKm6GGwN7bJT+bUwb/dwHtmifF+X+LECJKjTl6WKeNApMRMb7s7vVWQguTKaNNgII+RyeGhvUkRV9Jez+g9briMqS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731600714; c=relaxed/simple;
	bh=opt0IhVv/UHy7aAYa22aoxdctLGnE7f4zQv81lkglcM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mB/k50Pi0TdHVlomIcC+Vhdk8By/jJ2JLCX4iPnoQOG9a/5rCYz86APDN6ybn9Ntsu2eiRV0BiZO0/IXh6ItmK8AeOws1DHWhu46631nwBgGTAz5oaH1vbxgJEYuPLhSftZj+4hhLhq5M02tKlhYz2S90Em1SqSUxZ+hA0wCnGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=YmsAOW4X; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=LmEJJ62R; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AE8gHiK004916;
	Thu, 14 Nov 2024 08:11:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=5fLLeG7qwywL+
	ApEaliHw4qSw0Z+NUDzLt/FLbP+rnU=; b=YmsAOW4XGuZO6HzdnHWKjNbfykIMu
	R/9/Fdn1THP7ALV10VSI/dyfLpGAy3Lmd5sUJ7HrGVCKIUjYuSoNzFKpjLPtwA0o
	EzmGZZeAOAhQ9MYdmnpleq/Xlg7wnaHMdpqpgHCQQsWJlvgNMAPp15y3YaOlA0qP
	cb8fRMkWQLrcH0tVcmpiMhh1ELXyLxtt8G+sCOm+lqznsgnT6IBqZb6PJ7GGu8fs
	iS4tdOTL3wC8k6cM4nwmacBRzzHjs+ludjS1QgwWVQv8dWjYqC9bqkLwSX8F7XcN
	mvFxLcJqIl7sdPcypnYGHtOyAaAbijPUaDsCEPZRG4tflXvrMdEOSQgzg==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazlp17012036.outbound.protection.outlook.com [40.93.6.36])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 42wdx6gv6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 08:11:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZoB9zTfvsmswxg80nlHLtC4a/WbnPKayBVV00ILUQgX66Ca8M4gfUoLVehiQQeXZ6bfoEaRy0tTkg3OfV7+OSjD8rCNwHrMJL92WL1Xvxy7CFPyGF+iEahRc6Pma1k7WKDmrvQbeKoPGbPaHd53toTNooXoeHZiwl+vo/hfT6c7WB/qTd7j8DpVO/CraUjZA5SYtWhUpfRly3ObPBMHqOXIq6oPklED/woPN/LLpd7o+NapdCTuFTngKCoZ8ja+1hm6OK0qhi9xApWe8OOHWC+5//xI6AOnlT77gbSC/3MOPbkuEl/JENC54OvCcNxrzxS7jaGZ7HrKQo13+thWSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fLLeG7qwywL+ApEaliHw4qSw0Z+NUDzLt/FLbP+rnU=;
 b=v3+y9GE92W/jMEMJTfOEkZAI60I7eonQHcuwfZqLAfb7nXCAHODwVXu2wISqUWnQWwt4uBP0uAUi7ZZF77ZeTKDxBL4vse9+zdteVehU8ptZxZKzB3/2ufQsmG4psUTW24JNB62DyVfZPzLP8Jcn+77SLyYQsfDtgwc+qJp7mueLNixxBMSAjELvLldEYkdobXP7fq9q+P30dCbjPQ5+D9XHYxHRCmUZgnjr3XpNw8pW8op8+kcBB9jj5UZVSJdH30VfBkMMANWdvz5L/xJZs2JIW6HQJt90zdR9XJk7mkFRQLNfMYBSX8XYxH4kcxbfyGDZCzIcioyCumQgeN5niA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fLLeG7qwywL+ApEaliHw4qSw0Z+NUDzLt/FLbP+rnU=;
 b=LmEJJ62R0R/RquycD4GGx+TBQ1jPzuMNrsMFAyoMGPdym91PgZOLPSNDOsm/NfTLtUvzgxmZYKyZQWsfjKKcO1x9l2olNSxsO1L2s3ZP2RTls9iKnEkGvQqaPpt5PmPCUwTHtxv0ZLZTpKuhszsvbjNctgqeNldUPM35QSV/jL6cE0ohArLvuyw+pYQ7QeuOfpkpx+Ui8c5b5UBk+hVu74A5D/ObZjkVycDbjZ4O5axODPq4EFjCvefLIRcCMkU5z8gugApy5gjXH/A5PJ/V0rWHudQmh8ra0nbGa+N4YNbr+4wVdXnjZ+XuXnidPk/Aej8I/u226bUmnxOEqbefYA==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by SA6PR02MB10432.namprd02.prod.outlook.com
 (2603:10b6:806:403::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 16:11:38 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%4]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 16:11:37 +0000
From: Jon Kohler <jon@nutanix.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>
Subject: [PATCH] sched/rt: add lockdep annotations for rq_{off|on}line_rt
Date: Thu, 14 Nov 2024 09:32:08 -0700
Message-ID: <20241114163208.1821892-1-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::18) To LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR02MB10287:EE_|SA6PR02MB10432:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d1f8032-560f-4d99-58b7-08dd04c70475
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h/5jgjwVkiCajTixNegUQldta9PUbwJph5i0if63VjbtX7+EnzrLFXR2hG3a?=
 =?us-ascii?Q?TOEh78lJHm2LqpXGhD4XFoviKlFQVGgb4RxjqBQiIpzGOdulFIYhNVvgVfhq?=
 =?us-ascii?Q?8TuqA5AwUEIk0nkbX2nQzm7itti+mmYN5igLM7ye824knJAL1ULin8fKy9s5?=
 =?us-ascii?Q?WrptUMSvmr404Px57oRIG9dZgpTYtUG6tjRIlNU9DhjG0tyNzAR6W/mv2XRv?=
 =?us-ascii?Q?SfgZHUehR9YsmtFyIaxUHh7CC9m/mzkztEghlcKVN6W7dusJgY/WRXHiJOYE?=
 =?us-ascii?Q?lPi3Ex4HBs99RIN9A9nhtuJORVdnqkRz/SObNxpW+y6IXQAlj7H7dgPEJMij?=
 =?us-ascii?Q?bu6nrMsJC48J18OIkywQwf2jFjXzB2b0V3ZtkjEvcboFkC1XPIM5f8K6EnA/?=
 =?us-ascii?Q?kFodH1H8rA6adepjIVrNz4uG75CdddJO2RxK/59mLiz+jEzGJA0fxI7n7eSI?=
 =?us-ascii?Q?ZgfDrYv5v15+W9Y4FbwLq81GcVhTdoUpvRwNQVPJfFeUiV/jkfaPZkaCV4a0?=
 =?us-ascii?Q?Z3KqdnbDj69CGXEhEbgyXwjWjAWxYSKlrJDWqOquKnVE+q2hH1u3VuEWde/t?=
 =?us-ascii?Q?iC3HLpFEPWMPn/FDCXeaQhR3Nd0N96TJ6xIwFe23mqfDZ6mHmxWcXu3me6Q9?=
 =?us-ascii?Q?oJrpqHok2Lddba3/HSRe43aKTT7vuF2MOoSBKprIgzIPqSD0xiixuB2qr3Ym?=
 =?us-ascii?Q?3wx53bZbvhP/abN1POc539AAaEzetmPFj9rVqr2b48Clau/LkPLTT/4UDc+7?=
 =?us-ascii?Q?IEu8Yto/f1I43a7f5iQXVonhNFETEVjmKnBao/VpdqjoldX/K0SYM30gh3Gl?=
 =?us-ascii?Q?JFgWzTN8EHCOwRex8WYfJn3ICJp17rk2Rdw+yjK917KEfoj9ivbMQKpOfVJ3?=
 =?us-ascii?Q?oflWcjwobapZruG3bASwfLNaSYGPCCJQgOEnD/BFH8MHK0CTwomT/mwOpw8p?=
 =?us-ascii?Q?2KIXehL7mULh0sbbKbldVipjietUoc9iBBx7FtcZPQpUtSQrOvLvOsqFsZWV?=
 =?us-ascii?Q?Q/IeGR9y9s7/P0kBXojUrNJWiy5b2DgL8koirB7/yTSYAjcD+8Fu6XqBBZMF?=
 =?us-ascii?Q?newWG4Qmuj0YA4ZldwsVoLmsySbUdO9azHDLEBSyYFewI0uNZLtQz0QYEpJC?=
 =?us-ascii?Q?JN6gUKuQDVNkMU7mCQcm4ZEwH+Z8aJuJfdF/EA6PDrzVi/2vWwzPcZGzOGEs?=
 =?us-ascii?Q?4tHymr/eZpVfbBQhEp/WpfhFxh8dx20cfHpXvhT2KW2A+W6UJOWPPm7azotn?=
 =?us-ascii?Q?M960OZH18tKxi4M8KjS/ZZy5TUc1hYML0iJ43y/PikZHoihr8Y/FRU0PodtE?=
 =?us-ascii?Q?7iFXsmsQuKiNql0wLysj2ZCQDrk8FNVAhnjwVg6OTKx+IGG+AvsIeLn/kuoL?=
 =?us-ascii?Q?OpbUWc7pNk2qddhIaGV2VoWLMTw4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ji020l0B8jCY+1uTjQAjRYLwXx4G4AMmN0T3x8p3NH5ywiQ3iaFFkbW7GUnk?=
 =?us-ascii?Q?X8boraeP/gWentW1ewGafnv8r8mgZGdTNMSiIvIgPRILi+C41obD4M3SUacQ?=
 =?us-ascii?Q?gGV7xCCsCE9MQm6VKdCjrWXxmgxGOh9TyVsvFwDxyXOj0UVEP8u7p2rOhIVO?=
 =?us-ascii?Q?jiq+5eDKBVJ2IIruJ1fyb4SvHxfbjeDmKyfrEOcentmmukRk2+E0RtK8r4fP?=
 =?us-ascii?Q?PrIgk2153hcTkeVaTiPL0yS9ZbKoO2pCqc7r1j2qZxkLhN/1RguY8gMdwlY0?=
 =?us-ascii?Q?zuj87deVh6Fk09ycsiFJqW54GPC2qhiCu3Dl5CnaEI005KRtOWUl+GANL9LO?=
 =?us-ascii?Q?hOHtb6tZzSxAr8iFYsi344kTm9WKvUda+AYMdbVSvbtW77eMZzHEM4qGc3hI?=
 =?us-ascii?Q?cfkwV+ifhC+6KQRWFomv+37WEV1+6BzEEsNompGuv3wTkjEmBM3Otg9v3uMc?=
 =?us-ascii?Q?dd/uuRxTEs8uVhH1NAKocON6y7b48zFPWknm5RsyFqHe6DqHYe2sE5XM6UwO?=
 =?us-ascii?Q?zeIfr0rMKjD+0Y5jxBp5gz9tnPQxyjjmpTShRFcL2lReddEVq+SeyC83zWH6?=
 =?us-ascii?Q?FnAkS7VNJvqDFcUPsU9ocKCDXM0kDWXOfV1JjUf5J0gXyQBo8rBNEsY5DH4n?=
 =?us-ascii?Q?i/oxsxq+1FNjB5zC5PIC2CTPq4+UDzZAFP15LZMt8ZSb5Qi+v3OfBN9uiA2G?=
 =?us-ascii?Q?elxlIN2d9T/sHCOmlUeiK0dvEDACb1r0/Y1fu/F3h9rbJVXY8EdOB9fbim24?=
 =?us-ascii?Q?Ak7xTfbr82SdSGj1CCEcPgj32OQnm0RIKThAq044Aqocw2gQ6BI1WECE0OnY?=
 =?us-ascii?Q?G7TPUXTEGUTDHw2XH1F2RdD7M1eVrl42keaIuzpGnMFMzuHa1KJq0kVbQYKK?=
 =?us-ascii?Q?yyg5APdMG6MO5Aft38aMNr4YC1HFlgf36NsMKMh+yU5OHhe8ORFCy5eWPdVM?=
 =?us-ascii?Q?7SiW6+I1RN/ubrJvQLbsPpujshEmBI8GULy2kDChuyvjn7YHQPyjtOouLBAO?=
 =?us-ascii?Q?UQHyLyQtFTsLX9vifo3/pfsOj4gqWztPtrztFvN569DcBCs6gCm8GBbMh+Qm?=
 =?us-ascii?Q?3ozdmGuNuBCa93Oc/mIqGW1nG1CkmVNj02TSELClYZq7rauqnZLemO6Yng3Z?=
 =?us-ascii?Q?5GMyNc0sAUrRqVvrQmw5TcTPomlqq/jPq5jF9h7MINqN76bq5Geo5A/0QZj0?=
 =?us-ascii?Q?I6X2DZ0TbYTATlE4Y0hijHBfVc+lnENxZyC1bMuI1Z2lu3XNNRtmcEvn3kKQ?=
 =?us-ascii?Q?1Sdv7lSRF+iyYd7FI2p5+T5Ix02Ks9m4AIQ55p2pEEVDMb6v+JBufJFtH3Fr?=
 =?us-ascii?Q?hSsqhAsjEAW6GgtbIO2YD1MkYgzHdBTFR37dfN6zLV413z0eXnX7HR4sYy7I?=
 =?us-ascii?Q?dfzlywPBp8mQiYP2pYk5mxfZVFfk572JEtm/t7nZVbtpNE9+QlLa0yZEVNuc?=
 =?us-ascii?Q?NAJF5A2MkDBcKnoUUHisnNR+J2m2s8Ia0H62wMiVfwPzz6x/B4ykdEQkP3FX?=
 =?us-ascii?Q?Sa52MDKAHZJLShGAvSBfbakPv07gte5RDfFOEJlLZedljfssK+bNnVtuF2JP?=
 =?us-ascii?Q?0gw4DbkylhFFIM7G3Gfg8DIRWv/N+O3GGmgX+2bXJ7GGEwQr1gaxBPNkV3Oq?=
 =?us-ascii?Q?tA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1f8032-560f-4d99-58b7-08dd04c70475
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 16:11:37.8640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4gQzXsy/LvMcbmFS0lCydLOJVSgKOpLS3FRElD/Y7t/oM+lMF4t8UOcvhQMRjltqm+P4bbTiygGHljn7zMly+5/McAsh32DSCD7yVeZdpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR02MB10432
X-Authority-Analysis: v=2.4 cv=XIpiShhE c=1 sm=1 tr=0 ts=6736213c cx=c_pps a=dbnGGe82Z6Ok/5ez5STjcQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=h-VCItK4rsIAn99zM30A:9 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-GUID: 6ObBlQvIPXH7jgGQ0zF_FmoUWdOmQruT
X-Proofpoint-ORIG-GUID: 6ObBlQvIPXH7jgGQ0zF_FmoUWdOmQruT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Reason: safe

Remove code comment assumptions in favor of lockdep assertions.

Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 kernel/sched/rt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 172c588de542..2b10c930620e 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2407,9 +2407,10 @@ static void task_woken_rt(struct rq *rq, struct task_struct *p)
 		push_rt_tasks(rq);
 }
 
-/* Assumes rq->lock is held */
 static void rq_online_rt(struct rq *rq)
 {
+	lockdep_assert_rq_held(rq);
+
 	if (rq->rt.overloaded)
 		rt_set_overload(rq);
 
@@ -2418,9 +2419,10 @@ static void rq_online_rt(struct rq *rq)
 	cpupri_set(&rq->rd->cpupri, rq->cpu, rq->rt.highest_prio.curr);
 }
 
-/* Assumes rq->lock is held */
 static void rq_offline_rt(struct rq *rq)
 {
+	lockdep_assert_rq_held(rq);
+
 	if (rq->rt.overloaded)
 		rt_clear_overload(rq);
 
-- 
2.43.0


