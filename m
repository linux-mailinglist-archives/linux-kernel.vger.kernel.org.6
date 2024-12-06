Return-Path: <linux-kernel+bounces-435452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4D49E77DC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E97E188870B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D902206A5;
	Fri,  6 Dec 2024 18:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usask.ca header.i=@usask.ca header.b="Bypbz1la"
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020132.outbound.protection.outlook.com [52.101.189.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2141FFC65
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 18:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733508783; cv=fail; b=RT/zb/viB/usJk7yJSNstepRv0XQq2mKc06tFUoClzYiPu2Xs46DRLUGpC+qBrLmoPXwFmxW7/0bgyvaF4MgA85GYQuPK8DY0S8sCRh7Uid4ONncsUsMmjjbAtk6q94o1mvDWgFT9xlMcfs8eqvSR7Sp4cJKuEITobOBO5AWwKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733508783; c=relaxed/simple;
	bh=GjwbyPqgM5ZOUR63QyNBmY4LGxBNVJaT0cF/Bha5GD4=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=UKv+3ybvSbewIBmSjOMnSsTkkvt/DX+wlVhn0aDjkQoMsWQ1iQYLN2+VuLydupYIdRpMbd34K9n1d3WJc6Vxk/RMjBj6VU0QAQIM3/p6KYYafa2vpIZwdzyFfDvqKfqFKpXhRw2u1vi9AgX3H6oFnfyA4yPt+1vmuVgLtK6Bf6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=usask.ca; spf=pass smtp.mailfrom=mail.usask.ca; dkim=pass (2048-bit key) header.d=usask.ca header.i=@usask.ca header.b=Bypbz1la; arc=fail smtp.client-ip=52.101.189.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=usask.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.usask.ca
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=noJQlUo/+bKwFnL2k4p9tem5wq8DBgW6NrNSPGUt/0zEcN+ORVWuEahp+Koj0Ybt2nRG92blRqQP/17CGhi3nB8jyu3c5YRZdlhDaTlv0IDlVOcyUPNq3bMVR3dvPKXiKUR0Sux/q7c45pyy0SdU+J4bU7pDUrWPRBDnpzRi6z3gvP10BzAvf+mnax3I7/pW/niHJ+hdpt2EXTFatETlziZnA03MRB5E+/yi7heCpoRLH0zXyMDpAsMK7coF1+OaPikToKthqLaZW8c8eOepi0xTU/DFQXoxHSY1oqs+2ivIS/A3SsEnCwtgGjyAfT3CRm8TFo4r4yPxnXklBAS4Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/Bhzi0R7wQCcXOiRMW5vd1OiZ2fKP0b5SUoFSA30Gc=;
 b=Q+XSG2stjlPM8qV0zQB1o5jWjqoaPFfkCqypsmD6MPzqK5tWVAKDimzDvJz2nv35mmcFxI0oAOV9UZvhKAUedOLXqB6sxl+v2ceSIz82jA6jLEn9Hqj+Rn/w2ytQV/I/fMGeAcagN//Ywnx0lfIhLjTBlro6d7thU8141msJoXphV6pOzMV4EtZ+IeX9ndtm+ddrfkBXg/GsmECRxG+LonHYOCtxCc+5Yrtv2APU0P2hnWahFMIY4Llx8nCX7cgX2ycGos0BgenfEvkfKQfzL9GELu4EbI8Kb02pAFdVGeCJ6xzIA5tsWHvUCAdA2PMupkmhezWL8qnB2Mpax87dJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.usask.ca; dmarc=pass action=none header.from=usask.ca;
 dkim=pass header.d=usask.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=usask.ca; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/Bhzi0R7wQCcXOiRMW5vd1OiZ2fKP0b5SUoFSA30Gc=;
 b=Bypbz1la+Q5U2ru+GxqrOAxyiAeMii+ZqKQlvvsHKnx6FhShhdAAXeCChU6qLqbzcoNAtKJzLlHyly97sSKrnu6bMXsVAQ5Qmd8DnD0aSL3pr+l368O991nH1DZLgO0P03Ey5eHXMvcclBGoZBIH2NRIRAqoKJuK/gga1rHlNVi1AzjboknLm55pKSkj82l50RQDoAvclIcgLDN9Md4lqhoInSo2cNYK+Lw+RQ9Tl1oXSnh2UQHo/XepLyYmZ1zTcLT1oLpDbAnWKwscHM322q98lu/2ws4eO8vIEktID9/NH1acggZQqMzBzYt8xxLxJtxG0qM4tbhcWmYfgCEMOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=usask.ca;
Received: from YQBPR0101MB5382.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:45::11) by YT2PPF11AC0760A.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b08::410) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 18:12:58 +0000
Received: from YQBPR0101MB5382.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::7258:be3c:f7d2:11ed]) by YQBPR0101MB5382.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::7258:be3c:f7d2:11ed%7]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 18:12:58 +0000
Message-ID: <49a1c1eb-5e80-4eb2-b882-a2df3ec12012@usask.ca>
Date: Fri, 6 Dec 2024 12:12:57 -0600
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: LKML <linux-kernel@vger.kernel.org>
From: Chris Friesen <cbf123@usask.ca>
Subject: [SCHED] any modern replacement for RT_RUNTIME_GREED in the mainline
 kernel?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR10CA0002.namprd10.prod.outlook.com
 (2603:10b6:208:120::15) To YQBPR0101MB5382.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:45::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB5382:EE_|YT2PPF11AC0760A:EE_
X-MS-Office365-Filtering-Correlation-Id: 593894cd-d756-46a2-cc73-08dd16219d25
X-UofS-Origin: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T21vOXNvU3VxZklPTC9ydUhpb29ZMktjZkMwK1FLR3FDVjNFK2gvVHRnbldW?=
 =?utf-8?B?RHFYUVNBeGhvVDMxekoydW5rYXhhQ3Z5T2kxY1lXQUxsbWgyRHBsT1QxdGFx?=
 =?utf-8?B?dUYvazJCd3J1VGloUVp0WTcyNlRvQWVDVG5waHovQUp5NzVXNENhV1VFUldM?=
 =?utf-8?B?TlY4Ym9EVFpleUlLQno3RHdnWnRCSUR2L0J1Z3A3NzFBeUJPZ1M4a1l2WEY3?=
 =?utf-8?B?YXg0c004S05wT0hWdFFmNkI3YmdHY1JGbDdxTjJrY2RJNHBCOVJ5RTVhei9n?=
 =?utf-8?B?K3RpK1BFT2RrRFVrQ2NEK0ZVVmpGSExBMzludEtyUFpBR3VUM1hsYWFDVk53?=
 =?utf-8?B?K085M1Z1WnJoNTIzY1BXVHZOeXR0UEN6UHV3TnV4T0ZrV0pXeUs5Smpnd29t?=
 =?utf-8?B?czNlTGViTy94MEVPTVNjbVNMeUt2S0tBcHNKL0NVKytKUzlaOVZGL2E1Y0Q3?=
 =?utf-8?B?c1ZybGtHNytxQ3hPNzlIaU0xdkM1U2RNai95WnlLb3cyRm01VmVEbG5kbVJx?=
 =?utf-8?B?aS8weVN2VWVkVnJ6bnhWZTBQVTZKaTZRaDBZeGcxL3BFU0pvUWI4c3Bmb0hr?=
 =?utf-8?B?UFFKTHRRYUhtc3JVUmJjZW5LUjhjbW9pZ1ZFTXhNMmJwY25VT2JuM2tsVlUw?=
 =?utf-8?B?Z3pkNDh3Mkw3T1dxQlgrVU9kUHgrNHljV2Q5V0RFeFRpejlveEJpSXllMDJ6?=
 =?utf-8?B?R2IwcUtVdkpBS0wwOWdLeTNGNUttM0xITG5OVmVMbFk2c3pqSUhuSExmV0Q2?=
 =?utf-8?B?N2Z6RElWQ2RnUHZHLzhuR3hUcGY1WUpxVFltdms4cjZQR1Nlc25UTHZHU1hN?=
 =?utf-8?B?WTlSWGdvL1VqYXp1SmRBUnl4eGpPTHRVdFVLZndLVEJ5OUZiUDlwOTc5dmhq?=
 =?utf-8?B?YWM0QlNWbWFta1JVWHhZTzB5MDlKTngvVUxZKzNyOCtHM3pkRFg0L0J1YUNX?=
 =?utf-8?B?MlJyRFI2R1V2cm1UeU16VnVUYm1JaE5WMmV1Z05vSXZ0QWdzWlZHOE5QQ1hO?=
 =?utf-8?B?WXlTU3JkMDc3cDRITWhYWkhEM1E5aElPODBqRzVHZVQyemxYUktLWFNzRndV?=
 =?utf-8?B?Y0JEMlQ4T1VhRmUxZzBVekIwWjRXUzNwM3g2SmdPMDh3WFBGU3dIQm9LVWhk?=
 =?utf-8?B?WjhOTlF2VGEwcksrSlNJNFA5ajRXZWlKKzdTZ1dNTWFEQ1pmVWlIVUhWMmE4?=
 =?utf-8?B?djdlbXUxalJnNVpkWm54NW9RUG9PeE1zaURmd0dYVnNMNm5wWFJMeUdPNWdL?=
 =?utf-8?B?Y1MweXZvTm5oNzNJMU54OG41VmQyYWJRbEluTld6djQ4V0xGemo0Q1RNM0lo?=
 =?utf-8?B?WjliNWdHUFlyWVFyVHYxaEt3VlIzYTdLNkJ1a2ZLamNIak13RFFWK2dQNktK?=
 =?utf-8?B?dm55U0s2dEZtNmVaQ2Ezci9KbG9vcWFsbUlEaE1IQmMwT1lzVndMNFNBbXhF?=
 =?utf-8?B?cm9HK1U0TEFDcnUxZm1UbXQvL0txdUFDWDc0ZnFCemVOOHZnZ1NrMWlEMWd1?=
 =?utf-8?B?WHNPeGkwQ3Z6RUV2Z2JlN05YNnphWDBkSURvOHZTSC9CM0VyMnFyQnpPL1E2?=
 =?utf-8?B?Q2swYXZrejhYUWI5NFVBK29DQ0czemYxa3k4UmdaRGd4K2JmemtPRWYyYVlZ?=
 =?utf-8?B?WHhLdmR6eWlxRWRZeS9WeEZOcE1DYVo0M21TSmt6MEpuQ0J5WjR6RnNZZUtZ?=
 =?utf-8?B?ODNTdVBKYjdRUHpueWl3ajVjRlJKeVM3Z2Q5bVZiaHBEYnBFUnFCTFZCeUh3?=
 =?utf-8?B?NGVOWTJFNTVyN0xRY0JLNlBFbXRodjJwUE04ZXpjelhOTVVuUWZYMkhsQ2RL?=
 =?utf-8?Q?K4ByiHPkI7+PSmQgMcPULJwSpQNu/15k9xSDk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB5382.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z241d2tsektZNlUwTTR4M1QzRWxoS25ITURUN1kwb1lxT1AxblRHdXR0UHRU?=
 =?utf-8?B?dWlTU0dXeHB4MDNUU3J4RXQ2WXUreUhEbmw2WWt6YXZaN1B4aTUvUytja1hl?=
 =?utf-8?B?N1Izb0ZMc0tXQ0VJcEJkd2t2Z0NJZFltYVRXZnMyNE5qbmhneitYU0lBSFNa?=
 =?utf-8?B?RnRvYi9CaW9ubVc4YkxOTmUwTXhmZVpzQUZCaCsyMHRoUXZ2YU5vVmJhMkFl?=
 =?utf-8?B?UUt4UzY1bDJlOGZzdUJYWTdxWHVlbTYzQmN5V2pSMEd5WDRCTHU5NFdWZzJk?=
 =?utf-8?B?Yko4cXNVQ2E2V3RkRWI2dGpUdmdYSTIwcWhHcG03em9nWllXVDZzRENZblJX?=
 =?utf-8?B?MExpb2ExNlByZS81YTM5VHMvUTJFS3RwL0VKQUdXckFQTU9rUStONGVOTnk4?=
 =?utf-8?B?ZHdQNUtoSkRpMU0xMll4VlBaeDRzZU0wR2k4UTJHSjQ0bHoyRlhSdzZqd3BE?=
 =?utf-8?B?dUs0SmxyaDhHZTlJNTcweWVtazZrTUN5UmU5YUVGVmVzUjlhRUNTSzZjRC90?=
 =?utf-8?B?S2hmdzRQLytPdmZ3Rm5UYlI0UXlBcUFCQWw4d0lBQjFvQ3kwclZJcnQ2MHhN?=
 =?utf-8?B?b0ZUVU9FY1lPWDUyY3hnbU15STBTNUFlL1FOR1hxL2dGM3RyWlVuWXQrTFlv?=
 =?utf-8?B?ZGJiVTBpOE9EY1ZwRzBrSDlxeCtRMElZQmx2aFdHL0hKZ3pSVnNiRHFDMUs0?=
 =?utf-8?B?RlpMakh0N2dnWFFVVmFRVjVac0dvam9oVkpiS2pkRmFzaVB1eHZSL1Rrb1NK?=
 =?utf-8?B?SFFHb2RmOWl3bGs1bmM3WHlaYnExYmRiQ2tMaW5FeFl6ZmRKMEhzZC9TaXRu?=
 =?utf-8?B?VTJtUi9uYXZXUHdOanRlaml5UUFJNi9maE1Eam1Sbk1jdk5HSENSSW44S3pa?=
 =?utf-8?B?MGtUNmRscE1xNEpOblRFM1hTRnh4L1NDTmFFOGdPd2p4bk5WT0d5NXQzbjJl?=
 =?utf-8?B?VnZGWXQyOC9VYXNuZVJIOTdONk1KL1RPWVFoSFF1c1ZYaEIybVRvaW9XQmNG?=
 =?utf-8?B?Zlo2YTRlZTEzaVVic2Znd1d4SXBjTU9ZOUpSNFJKOWJLYk9RbjBFNjhDeTVv?=
 =?utf-8?B?VjB3T2FXT1Z0eEo1b3Bvc2x3MjRzeUVpanR1bFFKOWdtbzRadGxmd0hydUpr?=
 =?utf-8?B?UWlGWWhyUnZUTVR1ZEkzTFRRZzBYR0VOUzBzOHJrZ084dmJscW9tdWZyTkM4?=
 =?utf-8?B?emFqVHJUMmZZZzQrUklJZzJBekJNaTI3eWIzdHdHYjRQTSt3Rm5oU1hvY3JI?=
 =?utf-8?B?ZllsY2JNMVRHaUt5YWFDbkNyT2ZpV3pldkpGSURmK0orMm5BQjZBb0hKMHh1?=
 =?utf-8?B?aVNJc1FOcmFTRlgxdUNpelR1bUF4aVJSL2M4bHhDWHFhWUllNmJuYk94ZU1F?=
 =?utf-8?B?K09nZ3NqN1R3UkJhRTRqOWxwMlgrS3hqNEhKTVIrSFNsR0cvSExxSDFmTjZ5?=
 =?utf-8?B?Q2wwekp1NkRjK21lck9ZcTJTbjdmL05EQjVPVVRiVXlNYnVlVVpuUkNQSUk4?=
 =?utf-8?B?czlmcm8weU5pNjd3NHJDdVlmYW9IR3I0cHhDWXdwZ1kyUzlIMmhoVVJpVCsw?=
 =?utf-8?B?ZUlLVjM0UE13LzJMckEzem81ZGlncGdvSGhUSE9LeklsTVF0Z1l0eHRvSGV2?=
 =?utf-8?B?Z3NUTktyUmxIVWg4QUVNbXo4dGEyQUxjM2JFb0pIKzVkOEdHbkxjUG5ZZWMy?=
 =?utf-8?B?VW01Y1VuRkYrdlJwLzN4Q3g0aUZBMkpUUDZoemxvT0xOeWtHNlg4QzBvbFZQ?=
 =?utf-8?B?TzlTSmN2SERtdjlEenpVYlBoemxraUxvM2pLNW14aXhtUzg4ZGgxS2NqOCtn?=
 =?utf-8?B?SVU5Y0dHcWtpNnBCREkrc3A0Z2wwcHBGOEtrUHNIUEh2OFY1S2tpVnloZDRT?=
 =?utf-8?B?UTV6dDF1MlBpVjN0RUJpQUVqb0VNSUtYVXdQY1JYZFl4RExwSkZDWEtjY1Vu?=
 =?utf-8?B?c2c5OU1XTFNzMml2bUNxUkcxZlZRWlRORGRYQjdreXhBMG1HVXBlZTFvcUVD?=
 =?utf-8?B?RFd1a1pRc0hROWtSOU5iTTVwYXpLMlo3QU1PM2haMm9vZFBHOGd3WUI2MEJI?=
 =?utf-8?B?eFdIeUVCMmY3blZCQ2ZibW01dGtXQ09ZWHpUb0RUUUp3Sk9qNXFOaU5jbDJ5?=
 =?utf-8?Q?JrIkco8WEnNrkqqplEjBD4J2F?=
X-OriginatorOrg: usask.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 593894cd-d756-46a2-cc73-08dd16219d25
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB5382.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 18:12:58.4783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 24ab6cd0-487e-4722-9bc3-da9c4232776c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vnhxBroW3HfimD37d2Q32EDl8oFhVDLpaFIYe8vlEhSBdjuIE1uOkFAE6k8bkuCv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PPF11AC0760A

Hi all,

Some time back 
(https://lore.kernel.org/lkml/fa5b1b55d8934c6a0e02e04a7ad6afdf4012c2e0.1478506194.git.bristot@redhat.com/) 
a patch was proposed that would allow high-CPU usage RT tasks to use 
100% of the CPU as long as there were no non-RT tasks that wanted to 
run, but if a non-RT task did want to run the RT-throttling would kick 
in to prevent starvation and deadlocks.

It was rejected for philosophical reasons, with a mention of a 
hypothetical deadline server being the "proper" solution.

Has anything been done in this area in the years since then?

Thanks,
Chris

(please CC me on replies, I'm not subscribed to the list)

