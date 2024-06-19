Return-Path: <linux-kernel+bounces-221520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D4B90F4E1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 19:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83AE7281BDB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 17:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE72155752;
	Wed, 19 Jun 2024 17:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usask.ca header.i=@usask.ca header.b="dOnVa3l0"
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2125.outbound.protection.outlook.com [40.107.115.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436EA1C3E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 17:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718817067; cv=fail; b=m9mNkLz5UcYdZwCTF3mZhaNtRFuhbM/KKkOKPkrK/YvmhthNDUuN72fekOuvKSwygkeFjBBssMnUX4WZwEYCrU2joZmZI9l0oKMvrZ4JDv9SsO8PBLWY/OFc6AuCSKoEYoj4CmBv9GEq4UZVzsVEYlbK13M9EK/MNYXdtOSXVVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718817067; c=relaxed/simple;
	bh=cuEXgYi3dMBfLGYN08nc0VumQeD/Bnq0RZJd6Y+wNWg=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=KAZpYPu6b6jMHH3RksWwiwjrn7XP4srN+cdWWm+uGxZtMAgCp1ZiZECZ/WvycFkgK+vxLodS0uBygf6CFSh5ZdRuU74o3jvY46bTDD3fMf9aPSeaUs9Lm1C08HUml5FrrItpprKCx9cbP8WwVJzx/GArd9htRaCaUgPeIlj6V9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=usask.ca; spf=pass smtp.mailfrom=mail.usask.ca; dkim=pass (2048-bit key) header.d=usask.ca header.i=@usask.ca header.b=dOnVa3l0; arc=fail smtp.client-ip=40.107.115.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=usask.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.usask.ca
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWqP1FiSojGQt+qovuaOnwHAEd3EqzIpdXDTHzkB33Po469ETsqR4n0Z0JHUG83sRfEETDaokVlujPv00ZklrDCaC4cdc8jhNlvMGMwQs8+/6rI9jpDUPlzzNbxbS/MpHA9O0wy0soIYgLmj4LFpoxoQONe6Pdj3Sg/jjHYB6HB561v2fepizybW9M9auGe93Gul2DbgoSCqcaAEQBP2brYq2kUetMAm8XTr72sF1NlspQWtgEfAlU1AjlhikFuuZgbJVvxLVkZtVBLOoFSO9dPhrwO0K7eZRvIglOWyxDMejTy8Dg6abMgGNtiFGF8o66fpwnU+PnSmYQoyu65iQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkymB5DFlGLf3zw30zVh9BvzVdW5FXQ36nqx/gI2JP0=;
 b=OupyCzolNzZCP72VwHhQiQ79fv20qmhUAKZ1W0wFqdBjHf5dBRVA/Qv522CHV4jchMbPkWbA8Tb/Hi6zk9ppv1uBcg56xh2petlS0JNIaqUzXF2ztjtFwkKhzLRXnmJERiJNu5xNyMJ4po1e+lTmmh3lrCbJ62fr8n9gewLZRSCUdcUDhqnai3xyf5f122LVW9ZaKNVvZGM4O5SjdWT6vP8voSr9bc5uVZroJ0vO5dw7cx4FiMmZQcH80X7r9n8FAhTJ2TBvTygTCJLjTCizvgKaGk4FL2LuVsO73XyVc8VEUPEdO7N9XLPEoRFkjEvOdWtnCKvp94z9W7qV85GZ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.usask.ca; dmarc=pass action=none header.from=usask.ca;
 dkim=pass header.d=usask.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=usask.ca; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkymB5DFlGLf3zw30zVh9BvzVdW5FXQ36nqx/gI2JP0=;
 b=dOnVa3l0Qk1hOzcEeMkzz9KDWOGYkczUIzLIJbTHZZsOhTmU9PqDwNP/xMbTUX5c86MTitD+fWasGILxRlK38+iYcez06hyhteepBhxnEv0fvF7D1t9F/5l0RiZJXLUiPB0ezPYlybsPOA2fGTcBofpGZ5QV9BVkBWI6/H3/wte6M18BcoiWcqO4Uchjp7MikLyr99V7yC6AhgQkfx2e/aI4fLjI+3n6BTYC6/wHvIIcDYKKhL64XuAlIHfuSw6pw2b6SF/fW7bgQkhBdWzKrfcEAI5gTrUc6T7ZS9m7weC/mg9RJLxLCAqv6VQ3kOlz4wWd53U/1UdoaxzBd1fUpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=usask.ca;
Received: from YQBPR0101MB6200.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:38::6)
 by YQBPR0101MB9422.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:61::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 17:11:03 +0000
Received: from YQBPR0101MB6200.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::94df:38df:6872:f321]) by YQBPR0101MB6200.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::94df:38df:6872:f321%4]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 17:11:03 +0000
Message-ID: <a64d8d0f-e83d-41af-838e-7c41790453f4@usask.ca>
Date: Wed, 19 Jun 2024 11:11:01 -0600
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: LKML <linux-kernel@vger.kernel.org>
From: Chris Friesen <cbf123@usask.ca>
Subject: is there a known change in CPU affinity for new containerized tasks
 between 5.10 and 6.6?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0042.prod.exchangelabs.com (2603:10b6:208:23f::11)
 To YQBPR0101MB6200.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:38::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6200:EE_|YQBPR0101MB9422:EE_
X-MS-Office365-Filtering-Correlation-Id: d213e0c9-837a-4641-f40d-08dc9082cc6d
X-UofS-Origin: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFBoZUhoRVhxUXc2Z1FNSkpvalVuRmhWT3JTNGhyZDQzU2d2cXpOYndnemsy?=
 =?utf-8?B?UWRyazFkQytTaGtTQ2MvWkFmMk9IZHpyMS82RTQ3Mlo2aElTZzlVUWhzbXZh?=
 =?utf-8?B?MnY5ek9sSktNYmR6WERGZVBtLzdjVEVUUC80NHA5OUdxdTArdHlFSDltL055?=
 =?utf-8?B?ZDM0c2JadERzQXdPd2w1YVZSdVRobFJ1dk5ta1hndTdUbjkrZ3p4MDdDV1gz?=
 =?utf-8?B?MmpzZm5YSVh4M2pkREdqbkl6QS9tbUpCcmh2TVBFdFhJLzZCREM0ZHQ0WjJp?=
 =?utf-8?B?S2hHbTRNQldSL1ZUbjJGV1Z6YlYzRW9uQmdlOC9LZ0RwSnhJZXlnem1uT241?=
 =?utf-8?B?dC9MMjRtenF1NTFTRlY4QlZrNlRDVG1ZbHRSUmdUWFJoS3R1Z05FNzB6eWVS?=
 =?utf-8?B?aHpUVHdEVUFjdG1qbWVEMEEyQnRUN1VMOHN3TnN1QWJyWEd4MFhsUzg3TXYz?=
 =?utf-8?B?bm5UMEhuc2toTlNLYy8xUnZBOU9OUjZ3WDEySVFseVRocjd0blNFSDYyMytB?=
 =?utf-8?B?YmFhVmgwV3BkZ0prK1ZwdEJ0aWZITVpKVkhwMmw3YUMyQjVBdHh0RlNRb3Ry?=
 =?utf-8?B?ckRhS3NKbU9GNnh2OGw4Wm9MZXJjZUZBeGp2dVJxTDZFUzJMTTR6bEJaN0JV?=
 =?utf-8?B?T1N3K3Rndy9OV2ZqNTByb25CSHhRRFE2cFNqeGxCNm9nU2dtVVJqZHh6YW1B?=
 =?utf-8?B?aVZyN0F3NzM0TTA2NEV4SHRyWnhSYktyTzEyd0Y5VFdOSUs1dlpLOHpNMC9Q?=
 =?utf-8?B?T2FmajZRMkNiUFAwMllDM2JpQUNwV2N5QUZNRXN5WkoxQlBLWHRpV3ZHWmUw?=
 =?utf-8?B?VWNlS0kxYzh3eE5PMnhEc3RINzkrWEhrTDRLZ1poeXFyZ2YwRUFHVytjREZo?=
 =?utf-8?B?Z3BJOEdqL1doUVZHS2gwQmdOSEw4UVc0TTVMMGRJU1k1OFFNRVEzOG9lb1BW?=
 =?utf-8?B?TVR2TFlCUzRNNW1MbWliSEVxSTZvdk1wSUdQemg1MlBEckRIYm0xaGt1Smxs?=
 =?utf-8?B?d2JRL2prMUhOSTk2T01SKzQwZDdJcHFBYklwNXZwRkxRblNiZUpOMy9GWGNi?=
 =?utf-8?B?V2ZUZTBaRklMbE05cExkaEZmNEZBaVM3ZmMxYTlGV1JKSlQ5bTFvaFJvVGU0?=
 =?utf-8?B?blc2MTNHc3NwczVNRG9DSlNjY29OaFFla1NpWXdleWNHc3hZSXU5clNISUNG?=
 =?utf-8?B?b3I2V3pqTDVhbWQxNGVVWUYvcndPYzFCaHZId0xBR0d2dlpnVHZOT2xuWXFa?=
 =?utf-8?B?Q2ZvL0lycjNWTkNpcGt2V3BteUE1K21pb0c1V3BhVzdWR3dhWm1aakg1eFBu?=
 =?utf-8?B?NVgwVEMyZGk2QTVjdHdDQUN6S3RzQnNFQThhZEpPMFdrZFJ6eVJ5NCs4ampq?=
 =?utf-8?B?ak51VEZ5SElMbytpUC81YVdOb01EM3NzTlEzVXJsOEcvdmJFenJZeUNJNnE5?=
 =?utf-8?B?YWJuWmE4QVFiMEYrQVQxMk1mOU1IbUpwZmtERE9FdVlOU2dZbUxMRmZHNUFr?=
 =?utf-8?B?MlFnTkZUZWNtQm5PTG9RSGRXd2ZpeDExNUJzclV6MnEwYXdzNGNHYWFKdWpO?=
 =?utf-8?B?Z1VKdzhSQTAyZkJJWEdBVHZWUnA3R0RXeTZlelNxQnlyeGhtS3VqcTJBZ1Nt?=
 =?utf-8?B?TW5teDBwS3pvbVJzekRpeDczVTBKUGZSaDV2eXU3TFRzY1AyemVpeWlUV1ZO?=
 =?utf-8?B?V1NEOENlQjFJMjBZNGkzd3BKbXZqRk9XUGNsT01xK3Y0TjhiZzd3UFc5NkZj?=
 =?utf-8?Q?W2+a3W9erCIyQ4xEPfo8uL8WcnzDUpumIVGh2nF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6200.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1JhdUF2MHc3RkswWkFCV3QvR291NmQzL3dqVkd3QWdDQ2ZXeWhuTTNaclRW?=
 =?utf-8?B?cHpkNkJDalMybUdkK2Z4d1g4NGdnMEZxNGVZQXc5eU9xeVl4cHFZZU43TDFW?=
 =?utf-8?B?UTJaYkdudEpBbklzdTEyei94OUdTUGJRR0IvS21xTEh4bE5rdHpaaGZtb1B3?=
 =?utf-8?B?TS9sdXMxWUYvUEZrenNSRG52dStPSDg5U2krTFR6bmxmdnJBTnQ3bWNaczN3?=
 =?utf-8?B?YkZ4eUcxSHJIYnJTNmxEOEhBOTZwbFAzenVKUXE2MWVxTlZjd1BZc0dSSkJR?=
 =?utf-8?B?bXk3dnpnV2pGZXJ4ZC93akNuUi9wVWx4dVhrbWtwYWtmcGhBaUdCY3RXN0t4?=
 =?utf-8?B?azBvUklRTlpKQktmTjBEK3BQR3cvQkFhUGRLQ0ZMS250MmpCODlzRFRNR3ZK?=
 =?utf-8?B?R3N2Y3M1S0ZUU2lMZU9oWjhVZlo0V09iMFhCNHBabmRlTmZITHU2Uks3MmE1?=
 =?utf-8?B?RWxlbzNKUlVneWxRSnplNkFOOUxxTmZrdnVpMk5jbmJzYkdnN0EzWW1CR0lp?=
 =?utf-8?B?dE1qZFRBLzlpTk1NMnRiYUxDZUdKWWJPaEl6Vjc0KzhOSm9qcGovZHRTU3kz?=
 =?utf-8?B?UTZFaUQ1S3YyMkYzYnB5S3grejlPZEIza1gxYzkvMldjNVEvK2pLTFcyWTE3?=
 =?utf-8?B?RlB3bDcvUmtWTlgyUkthR3VxL3FzZkxsNDJVb05SMFQwT1VDcXcxM2dUUE9N?=
 =?utf-8?B?QmEzMHRXSlQ1WkxaY1dHYUFyVnd3czhIZi9RaVk3WnVYK0lyN284VEtXRDVZ?=
 =?utf-8?B?RExVSmRqMDVNUURRbDFNdmFHQ0RTT0pWL1FTVldKTnBXN2V4Qi9FU2ZYa3lV?=
 =?utf-8?B?TU5TelM4SW9OWE1DRmhyb1pyam5ObEZ2MERVaXFnay9rbWZkMllpMkZaNTRq?=
 =?utf-8?B?RmFueXpVUWJ5bEtCUTdFSGo0Z0oycUZHVk5VbU10S25IR3kxSzlzdnJ0Mnda?=
 =?utf-8?B?dG5nVFpTaWxnd25DNlhCaXNZL3VXSHU1ZDhKL0JLVFp0MGNOWGxmeU43R25p?=
 =?utf-8?B?cVBhSGh0N05oNWxVSUZBWmF0ZXpJcjRLeHphekdZSGhTOVVpRTAvRVlRTFRR?=
 =?utf-8?B?ZHdWd2FGRmU5TkJvU0NoTVF5WjNHc3RENmdyeC84M01HZGhhRFFGODdNbWN1?=
 =?utf-8?B?c3pWQS95WW5RYzVJcDBKNitiRE9pSXlTNXdMTnhUWEc2K25iZ3JlbkxVTmpz?=
 =?utf-8?B?bGx6YllrMXVDK3VlZFZPWXlvQTdnWmZnWkZMWkhEbGUyL3NLTmJOMC9zT1Va?=
 =?utf-8?B?aWpNZGZIbmlYckM2dUg2ZTFEVXNPK2dtalhSZ1VuYkZmUUNiQVhmeHkxLzBZ?=
 =?utf-8?B?K2Q2bFNTVU1nSnJoQTBGM0VtT2dxNVd2TXR3NkZwQisvR1NhTlRQUzdOMWNu?=
 =?utf-8?B?ejBEVmhRRmVSUDZjdlJaaFJVc1hZOTl6bXArMlFzVll2T2dQS3pRU2N3UXlt?=
 =?utf-8?B?Vm9yUklQOVpMRVJvVW1iRno3eXV5MVFkWWRUWGt3a0pKelQraUlUaHRLWHBl?=
 =?utf-8?B?NFZtSGFxTTJldTA1eEY4NVlSMXpXYU1xM2xGeVZnOHRkK1FYL0drdVdqRVgr?=
 =?utf-8?B?UFpkV3pZQWVJUk0vMkF5S0JmbEk0QjBoYU1rRS9UQlBIZ3JNU1pYRUttUEN4?=
 =?utf-8?B?UjBHQnNwd3NTUTVoQWltWmlML3FrOG53ZkxSNC9WWGV5U2JXSTduYWVRMDNj?=
 =?utf-8?B?WGZyUlA0MkpsMFhEUElyZFRkSlNMcmlla3BXTEhGTHExRjcvZGhKU2REMTM4?=
 =?utf-8?B?ZGZ6OWIzUGN1UkVTUEIrQURjZSs1UFo0TlFqcFpPS0pvTVpGdHZNR04rVkVx?=
 =?utf-8?B?MmNJVUNReGVlb1l5bmxVL1NSNURrcmM5K3JNNEN0Wm9Zb08wVks5aEZISzZh?=
 =?utf-8?B?cWpwNE95RHR4am1QV1BhZHE4cVBpZmhoUTJVQXRrcit4aGY0OHhtTEJRQkVR?=
 =?utf-8?B?WXZjclBmam9kdEVuR0NLSUxJYzh5TGdjK0dnVW54ZmxDK0FvRnBBUXBvNGVt?=
 =?utf-8?B?aGIwblVwY3FOWjBSelZvdWZnZjZ2cXV0bDdONFlOUlFveUFDS2d6TGJPNDJN?=
 =?utf-8?B?WUNBU0VEL25tUU13MEthY0JuN3kyd0JuOGZpQXlwZS8rNzM3M2h0OG5rTnN2?=
 =?utf-8?Q?FokVxn3kSsTRHq1E1njeqTH/s?=
X-OriginatorOrg: usask.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: d213e0c9-837a-4641-f40d-08dc9082cc6d
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6200.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 17:11:03.1536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 24ab6cd0-487e-4722-9bc3-da9c4232776c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gxU9lQLj2/Vo5j6focIAZfNI6zD+45YsGb6ScTngYM5rzOZfELImybbgecwDusJv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB9422

Hi all,

I'm not subscribed to the list so please CC me on replies.

I'm seeing some changes in CPU affinity for tasks in new Kubernetes 
containers when going from the 5.10 kernel to the 6.6 kernel, and was 
wondering if the new behaviour is expected or would be considered a 
regression.

I'm running Kubernetes 1.28.4, with containerd and runc.   Kubelet is 
running with "--reserved-cpus=0,64 --cpu-manager-policy=none", and the 
containerd daemon is affined to CPUs 0 and 64.

When using the 5.10 kernel when I start up a new pod the tasks within 
the new pod/container are affined to all online CPUs.

When using the 6.6.7 kernel, when I start up a new pod the tasks within 
the pod/container are affined to just CPUs 0 and 64, even though the 
cgroup for the container specifies "cpuset.cpus" and 
"cpuset.effective_cpus" values corresponding to all the online CPUs.

In the example below, pid 220350 is running within the new container.


[sysadmin@controller-0 ~(keystone_admin)]$ taskset -c -p 220350
pid 220350's current affinity list: 0,64

root@controller-0:/var/home/sysadmin# cat /proc/220350/cpuset
/k8s-infra/kubepods/besteffort/pod1c4b3a1b-5c63-4f38-b568-57ce87c9c3a0/c2b5de13e14d13ae3f6f8fb39bd287579261f00a1a2a0fdca3e764fbfbef28a7

root@controller-0:/var/home/sysadmin# cat 
/sys/fs/cgroup/cpuset/k8s-infra/kubepods/besteffort/pod1c4b3a1b-5c63-4f38-b568-57ce87c9c3a0/c2b5de13e14d13ae3f6f8fb39bd287579261f00a1a2a0fdca3e764fbfbef28a7/cpuset.cpus
0-127


I can explicitly re-affine pid 220350 to CPUs 0-127 and the kernel 
allows it.

If I affine the containerd daemon to all online CPUs and start up a new 
pod, the tasks within the new container are affined to all online CPUs.

It seems like with the newer kernel something has changed to cause the 
tasks within the container to inherit the CPU affinity of the parent 
containerd daemon rather than being affined to the CPU affinity 
specified for the container.  Anyone have any ideas what might be 
causing this?

Thanks,
Chris

