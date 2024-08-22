Return-Path: <linux-kernel+bounces-297882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C576095BED4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6BC41C22D21
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54841D0DF8;
	Thu, 22 Aug 2024 19:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dupAzYIT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pXYo3iGS"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9151D04A8
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 19:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354792; cv=fail; b=sgGaruzf6InBZ4dI0XV1oJB6G4wfLRONOcKFlvaYbEEf+K+5SwsVFVT+y/vBeZfvh0yjqWcZ+ffeZCvq8cFkaUWoAnbiDk5ew33RqqvzYjsU7ss8yuIdFp8QkOADZT5l4qbIZ/D5hlp5nX7O2LGmiuBCq64KU96VDR2LKaCzKGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354792; c=relaxed/simple;
	bh=4BoDbH+8BYl2x5PGXsKrkv0NY/DVKc5EY8nphVnMq0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z4nr62igTxVb4Aegb7C8QjfBWhwi2OVfG2hxfL4zR57ZH6m6lqi5Yc3lBm75AhrgGCmqAFx4/8cMeazTPmXeI1KZrqhBifnxRQDe+wVYm8NP2FWIV/65V644CUUYQWIu6jwH1FHLmMHTNCpcOAtYGjHaNv0PSqwozdu3Lc9F7b0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dupAzYIT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pXYo3iGS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MIMVOt026316;
	Thu, 22 Aug 2024 19:26:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=INR2A1cBDUV4GAxtVOjXNUJPR3TPHjuX5sIyohpW8AI=; b=
	dupAzYITeS52BILtOjtV4BO9piYoydwjSEHsPPgom6f09JOJXK3tFGGtaRS17R4o
	r31+J72rZrMLmIx8gn9UEZJ+ILxAhRdDPatqmfuJVfHkQJ4m5GCJHHLD5qtqK8B5
	VFY2xME4OLYjjimR3T8AarTlk3El3ATYOQccT2ONhFbpWOc0kkyMhl9bMAzvLN8G
	rAe7oNzKMc0fncSGuzU4fAwNsgD7ZpMSTaOMCbhXkQ/7I0b/DSB7op4XB8kAZiGy
	Bax/Ry/kAAW9FhzGpKzGitXRR4D93sQ/NOxyg77lU8B/iFQKTHSvVJ2Wd21lHgJx
	5ReKH7JzGucOzF9iIa+GrQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m4v2w8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47MIqZYC019418;
	Thu, 22 Aug 2024 19:26:15 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 416b0b9cbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UI0cPL/90wKn3BMv+7Auv2sai2JAwl2UhLlN1j9dECQgO3ZapQW77QwJW7jXTgmJS0IJ+2IvJfnpVlIU6fJXbMOu5WLOWaCIGJeq41Ad7/hY0P9ppkzRJbUSbPPprwcs/eVz/qhYaTnX5KLAX9+AoL2RjLac5t1wrQknnoLgc7gQ7pDgCL23+LX6TPIzeR1G6rXUNXl7WKVs+NaqqEQU9fKPDvXB0t4Vj9PDQpfKSwl2HBCm6bzNw1wyYWoh1x6l4sx5jxQ3eEmP3B1KFTJL5zlh11KOLG8fSoIuXek5u9rwf+vxbl/4mX5xlv379q1WMOzpjsj4u2fEXdqht35Kcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INR2A1cBDUV4GAxtVOjXNUJPR3TPHjuX5sIyohpW8AI=;
 b=trK8UqMcK7Dw4eAcnX0ja772JlIZmWwIXPKNSryfiDo0m5TaIVP7yuliKwdo6tCQBTSUz/zxAVMt1IrYmVRmZW5GoXmQjvYHYlr5qWvf0nXyVKLEzTefrziQ0w2For9qfILROMgVWcH4BmYxIznGrRu+2esUXQ3PgDGXwzhtL9Siu4GmO014Qaq52LNEHCqQmpXLOkbeaWitvVPrQpNc4jBDJHbjMO4+ATByFj5WRqFRxsYcXzaP9qFwdwgq4UynplYV0RM+W0xGEhLcsjaLacQfBYNoOa/gqPsedFH8bdPCWNIxNhE4HCseY6yLSc+hFnwOxW6YdP5AYz4g4G/zBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INR2A1cBDUV4GAxtVOjXNUJPR3TPHjuX5sIyohpW8AI=;
 b=pXYo3iGS7Izz/mUZ8sgzK1712KblpdhequA2zvrdV/I9DmFxskoU6hKddLvWPVrj/Pm90zVqoJuWk2TTPidMQgVjtmk0lNDAAkDsjetVYwayTqMFCvUHCcmryfuCgy3Ldxvb4V46YahFbLccpilrdD793eyYm+tCuw8RlAcxm5g=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB5729.namprd10.prod.outlook.com (2603:10b6:510:146::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Thu, 22 Aug
 2024 19:26:11 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 19:26:11 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v7 03/21] mm/vma: Introduce vmi_complete_munmap_vmas()
Date: Thu, 22 Aug 2024 15:25:25 -0400
Message-ID: <20240822192543.3359552-4-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
References: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0200.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::29) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd4a611-180d-4139-31a7-08dcc2e04621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0v/0oO0pV+E0h9C5Q6lUV1j2ymmiizEkuXa4S8OkXigorklb5e1DfM2SDsyo?=
 =?us-ascii?Q?aphAYVefAV6P9GzsTD+v+OkZVRa4KGWE8WZnLHm7qbSoGnmBWgO4ZkGVMyIS?=
 =?us-ascii?Q?jKtczE/Zbj6m7hhpAwylM5gX5ZUyaMIHEKTVvlF6GykfRpJA3z6yCPqmp2CD?=
 =?us-ascii?Q?j01+JMYbBCxf7ve0Iz0OjZOQqoGkXcyns+y61EW9tuNq68INJSH55ZafPVAd?=
 =?us-ascii?Q?J/Bm1Z6D0ABrrRMcwx7DvvDNKo1fFlzi6qx02hXM9caOFQA9xySPluJ6WUB4?=
 =?us-ascii?Q?rhZbYKCQIufG1Dh+pOL+uIlSgymjCf3kbVRYlleGbeg/S1FX1NKAsHNSv+l6?=
 =?us-ascii?Q?jog3wz88AHvWiWPHlexKlCdDHProglwfx4WAEZsBs7DmChA5zZYXQkudPz3L?=
 =?us-ascii?Q?RPvYqNt/vlBTV//RLtLRWUBgZ9DXMqwIbmS5C77WdJJN3HYvo+W9APZFbtSK?=
 =?us-ascii?Q?Mo318wWhcpekOS/QhcF7mMb/vo/cV0T8luzdq5IyjJQdMCIFL6YEY2/aLbo5?=
 =?us-ascii?Q?zAqXdLQ9t9x/1WH/wSccpzj8PQpXOygcYGJem45JYAfm2RJ4LRZs7/x08fJN?=
 =?us-ascii?Q?hGK9eGJnndLvyBNvsh+mp5ImjnHZACbBm6HqWrodfXhLDsieWt3prFZMDBfi?=
 =?us-ascii?Q?6duiL3ydmjwtmL/wpaegFHAEq6bZWu5RLxQ5+9BusyUgRo6K+yzvQLds2pI9?=
 =?us-ascii?Q?WYId82r3Hgxf2y8VMCTL4l4hv5H3ksqtOYkYurp7StXS+bcqBteYYZ9fIyiX?=
 =?us-ascii?Q?SurM8XSRnSYhieHLO+0cHL9AqN9L/IIgwUAUMQa7iGST5DmH1JZebfcdGWfu?=
 =?us-ascii?Q?7+Eq4m7BdR56gMNo0xzxKKGj2xwcBbRKNgTG8DqpUr9lCJ6R49hml+/pnoyD?=
 =?us-ascii?Q?IxrMj/AwloALIvk8kbmY6WXaf9w2zb8H2iOkQeeQrIJvO74jVPkj23cBFxiy?=
 =?us-ascii?Q?NmGHfimC1FObj0dI12JxJt5TUPyoY431Asutx/nqEdbM7/DtHvV6yd5CPZ8x?=
 =?us-ascii?Q?/jviaas+Duy785MpwK9cGDCj1E/rcnbgS7+yAJamVpffAF4jZjOpq88UBTD3?=
 =?us-ascii?Q?UUkH+ZjOvDz3gm6KZKKFgTk8QU0oGhoSvmH4EfF/EmIU4LryjHkcdPyLq+2w?=
 =?us-ascii?Q?cGThlKZK1ryYZQx06GfqLPRSmQ1ViWesFwDjF+89Etn/aA9jOds2PkuJI/tF?=
 =?us-ascii?Q?6ZcjijQKYKt2bMxz2pWItg9yYHsHdgMYjRev/gS6vUU/fDCcpL1P+GX3R8XM?=
 =?us-ascii?Q?yDDKxvpoWU7efzWRRst4NcRp90HEi+46zcdIt9eLIIxS18gHazo3kT3AdAx/?=
 =?us-ascii?Q?rIUBZKmt78McWBbxITrb+JNFMAILxMmSjJyLbp4gNGuEcQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lQyvgzZkMurYZmLecR4tQeXUCg0ZAOyPcrjNvnB+WME5lQUduQLcbAIBVaMO?=
 =?us-ascii?Q?YVZ1edy8nrdB+IAjxbm0H1d0keKq031JoiyIDY5XyUC3UmuYdrXcOVOQ7LDT?=
 =?us-ascii?Q?w+wCgAFZILvfGit9pIJFd2uaGvKdfj0/e8RUCszHhV1s5lrAt1uqfTlvUgtW?=
 =?us-ascii?Q?RCGWmBcca9uqWtyvqiegXR9J1Z2rjwPfcZeuZAt4K6g1VHwAu4iRSbaZgGvv?=
 =?us-ascii?Q?9P45rvDrzuMj2pVT0sssYvuR9VTXITqCiv95fsFVcPcw6zsqCJEBKjMgJZkm?=
 =?us-ascii?Q?0BCSrBlY5xJFGQP4IgDzF28hXdETZoinNHHNUeItGJT7itSMPYEmOWQszuZD?=
 =?us-ascii?Q?rL9PkgT6yojPX3GvpwgKUpfCVSen3nLrSDmFA0Ad8TkLkfCj7kCwJZ+pRR4J?=
 =?us-ascii?Q?vDNogwORPhOH5LsrSUeZUaBxkXmGo+G+0/p60FQgXJw7D3EShHlD9S1SP/XT?=
 =?us-ascii?Q?9Ml2QJhgCof3/4wmmt0Y2reMsBCYuwE3l7/zXm7YH+lA8ar91xmCrZSHXWie?=
 =?us-ascii?Q?C1xsp1LHYNzeJWPkLsdzZBnt/7UB6u892OffNhz2EVoYxSXb3hB2b547/qmc?=
 =?us-ascii?Q?kInWCJjvt+YnZ1tJVaAB8Hym18PE3nvDxIWU7pCONQ3gtmjl5cVjZ9MDwvjR?=
 =?us-ascii?Q?Ol2cY9ZfWJoK8IMf8NJitw2LC3gxsTNdYHCbbxUBRlxuKqAufo31z+xKRTW2?=
 =?us-ascii?Q?anj3abCqNmPJexNEt0pRZT/Nz8CaHC8Egpk/YWVZYUNyRsNKFriCnvC7N8PL?=
 =?us-ascii?Q?NiE0jbEopzMPLg8TSbrfYx5qRsDP0OLb6csrRiFwsZ5ytNwrRzz7rAVAQOC9?=
 =?us-ascii?Q?KbFXcwAwmcW9drG67UYBHkERTojwvf4Dzrfiq1HyM6GQlT2M5y/a9zL0A9zD?=
 =?us-ascii?Q?34b1v5o7XvpmMlL2C6J9OiUQT2BTaFKSSNKhieYLX3Yihrq+56s3elgWkg2s?=
 =?us-ascii?Q?updNXBeNqFqt8hr0T4qDlj+f0LaN2KPpkwmOWU7X441ZfEvtz4E8Z9JXyjXr?=
 =?us-ascii?Q?OlMrbIBy9ziJ3Se/SC9ktdvCetcj5Z2UdQmSop6EMKKxkpUHV2XPaOe3/dz7?=
 =?us-ascii?Q?fAl1B6vdM0NcMk9S8KVDNPH0qvdsa1UhItA+9i979NK5Y8wg461hjVP71GIb?=
 =?us-ascii?Q?zZZDaAywpsE7tuRndUZH5kEc8pdPjVzy8d3N0GVby5FGKA4dqQ/QaeUImcxf?=
 =?us-ascii?Q?cmHL56t/tvMW+21Ct6Dw9TxvwKfy9qylmX+kzx6JtJBgTP10R8J/mHTgnVn7?=
 =?us-ascii?Q?x4ipzAwcmKlfxNQ+6Y9lKN+EweIjG/oeoGT6pfT1aeWdF0bmV+FIBF4y4dXd?=
 =?us-ascii?Q?tgDhBj02bE4QGUNIc4yu0ssqYf+TDM4V7gPQSFt0RsPaT7ZdA7xPwymwv024?=
 =?us-ascii?Q?jCoEYMCTPPToco1L4dLG0mpozC7ViK+DY/JADj006If7JvcjcKKg9+2W0PX2?=
 =?us-ascii?Q?OAHcOq/xYnxWreBaNFEc+e783bP3Q1urs9/30WQOACLvcANk2n1i1wjWz8Ea?=
 =?us-ascii?Q?zBJD1NT6RbInlUGvYsNZjhaNCYulLhTvDq88pB2lr7S8H96yI7EDFVZkYfba?=
 =?us-ascii?Q?UEbn0tk/O8SSk7JhXzASPWXVCGO8I9brseaxtGwl?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NUzN8sIqkCkZa6NLipnkLFpVhYfyFqDgxe3V7Ocrwa3NgBFFm9aan86WfYLXPbh3dgAPcgHweVAybaMqSFrtqfLKSiYpkelklx/At9eRLcb+K7P6LGf9WFecAjcxqvYnwROhPoSUNvALVZDI0go1iRJgB/4IzlO7d3TvRF+KbahA0OShwRi8C7zPL8Qbg1iGaxL8laVhA6Mr1DsLp6bjc3ocs6oLXD+mADf44yKQQhz2SkBAAK+CKqrzp2G3XCl5BWDO6Eg5Fljbso2Q6ekspBRKO8QLMRA3aWV/o32H/IHx+SqTN6KoU3ngb3M65zNwnJGzT49u0JUqsh9HX5LYgHn5ojoreiuPav18ShMfhEgAB2p5P+kd3HmjDZrv3HrWjFQ1+cime2I/Wm+KiThU0cVtSZlaupCo6dQSe/VS7J7nFYlazGvaYRk6nwg3/h7+gS5D/YcgV8Sv8kdMbXmYwojMx3ifhOXNeGQQMkoEu6iGLBolcfZ0YPVFgBT7dh3A9vpjg+AgT6HUMYXuy0WeJjC8VsyahBaXnu4pAFK42N0LaFSfrNeGRoNnbavStrkXYsQgO2VDTkDsvhzdaxA3fUqTsM2R6hRqBKL+/LKFYfE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd4a611-180d-4139-31a7-08dcc2e04621
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 19:26:10.5564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9YvamDWYvzPsBuxhnqXhGpa4FzO2HcJv9eIm6PYQKA1GkrSllnZY9Hy//gT/a0j8Pmh+WubLEtYXzmperjV0/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5729
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_12,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408220146
X-Proofpoint-ORIG-GUID: Ne-zxH17H-MO_gQM2zMkd-G-NKT_wia_
X-Proofpoint-GUID: Ne-zxH17H-MO_gQM2zMkd-G-NKT_wia_

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Extract all necessary operations that need to be completed after the vma
maple tree is updated from a munmap() operation.  Extracting this makes
the later patch in the series easier to understand.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/vma.c | 80 ++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 55 insertions(+), 25 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 58ecd447670d..3a2098464b8f 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -684,6 +684,58 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach)
 	__mt_destroy(mas_detach->tree);
 }
 
+/*
+ * vmi_complete_munmap_vmas() - Finish the munmap() operation
+ * @vmi: The vma iterator
+ * @vma: The first vma to be munmapped
+ * @mm: The mm struct
+ * @start: The start address
+ * @end: The end address
+ * @unlock: Unlock the mm or not
+ * @mas_detach: them maple state of the detached vma maple tree
+ * @locked_vm: The locked_vm count in the detached vmas
+ *
+ * This function updates the mm_struct, unmaps the region, frees the resources
+ * used for the munmap() and may downgrade the lock - if requested.  Everything
+ * needed to be done once the vma maple tree is updated.
+ */
+static void
+vmi_complete_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		struct mm_struct *mm, unsigned long start, unsigned long end,
+		bool unlock, struct ma_state *mas_detach,
+		unsigned long locked_vm)
+{
+	struct vm_area_struct *prev, *next;
+	int count;
+
+	count = mas_detach->index + 1;
+	mm->map_count -= count;
+	mm->locked_vm -= locked_vm;
+	if (unlock)
+		mmap_write_downgrade(mm);
+
+	prev = vma_iter_prev_range(vmi);
+	next = vma_next(vmi);
+	if (next)
+		vma_iter_prev_range(vmi);
+
+	/*
+	 * We can free page tables without write-locking mmap_lock because VMAs
+	 * were isolated before we downgraded mmap_lock.
+	 */
+	mas_set(mas_detach, 1);
+	unmap_region(mm, mas_detach, vma, prev, next, start, end, count,
+		     !unlock);
+	/* Statistics and freeing VMAs */
+	mas_set(mas_detach, 0);
+	remove_mt(mm, mas_detach);
+	validate_mm(mm);
+	if (unlock)
+		mmap_read_unlock(mm);
+
+	__mt_destroy(mas_detach->tree);
+}
+
 /*
  * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
  * @vmi: The vma iterator
@@ -703,7 +755,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
 		    unsigned long end, struct list_head *uf, bool unlock)
 {
-	struct vm_area_struct *prev, *next = NULL;
+	struct vm_area_struct *next = NULL;
 	struct maple_tree mt_detach;
 	int count = 0;
 	int error = -ENOMEM;
@@ -818,31 +870,9 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		goto clear_tree_failed;
 
 	/* Point of no return */
-	mm->locked_vm -= locked_vm;
-	mm->map_count -= count;
-	if (unlock)
-		mmap_write_downgrade(mm);
-
-	prev = vma_iter_prev_range(vmi);
-	next = vma_next(vmi);
-	if (next)
-		vma_iter_prev_range(vmi);
-
-	/*
-	 * We can free page tables without write-locking mmap_lock because VMAs
-	 * were isolated before we downgraded mmap_lock.
-	 */
-	mas_set(&mas_detach, 1);
-	unmap_region(mm, &mas_detach, vma, prev, next, start, end, count,
-		     !unlock);
-	/* Statistics and freeing VMAs */
-	mas_set(&mas_detach, 0);
-	remove_mt(mm, &mas_detach);
-	validate_mm(mm);
-	if (unlock)
-		mmap_read_unlock(mm);
+	vmi_complete_munmap_vmas(vmi, vma, mm, start, end, unlock, &mas_detach,
+				 locked_vm);
 
-	__mt_destroy(&mt_detach);
 	return 0;
 
 modify_vma_failed:
-- 
2.43.0


