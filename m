Return-Path: <linux-kernel+bounces-554450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBE4A597E9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5AE3AE8C1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6CB22C352;
	Mon, 10 Mar 2025 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="L3dBSVvI"
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020101.outbound.protection.outlook.com [52.101.189.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CB522B8D0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741617531; cv=fail; b=gGExECV0LOAqaInPNF/6dbR8truYpH/cn0Brm6/mwNxcJTm+faPFwp/H0c1K6dElNkBjwZ8MsQSe+051F/nQyuBbcEoOm17pGpneX+8oQG4VJ/RA9BKRbqL4u/s8DwjuENlaIdx3FdedOGgRDc/XQlaMFQAr9AAxuzUSLEGK0yU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741617531; c=relaxed/simple;
	bh=WE9FkeNBiaWCKODOnenKEEE1YamJDHynsAntp9jTnoc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pmSJUV8NDR8EyflpmwvuO5LCSEZcVIXYybNClcj0Mf00+o6v6ziqiNwFIj43dVdhPQptNKhEsMQSFAR9TuxSZq+zSs9fAnnsByF7gIBOTgWxsJ/GG9/SpBDH4w6Uj6u+Vokdu9HJqrQ7YLJPlPb4GQ/gbHTl/s33+MlWhBY6oCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=L3dBSVvI; arc=fail smtp.client-ip=52.101.189.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z90etDZ0NwrbEI7eYKhQRG7BCnUBbPXb3cbdEAlV844cflhTV5mmk+6M976vC8m8JhT7DdQ6JswNtLkJW58fw28pKoQHjwGfWUCdgokQ/GGSe8P++lwjpi0u2db1zsqivdUlw3OlWEcCHaTyB2U08B3FavX4IsrwCr4UdT5FXM2+NenYMRw/8ZtiRU8ma0klXg/ukIG+ahCJBV10U1nBNzyJGTY10z4GOoZy+OnHCGLddWT3HwVK0JM0uBOOzWMIAWoez+Dp5VejdLSUaaOL8zIpTZHv+9Sb2ndvift2OEwiXRrBKFkdZUXVIxvIosmBAZ20ho6W93nlcg1vqyO+8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FoQ6QsfwpY4lAhkOPpnDq67aySaNkz/dL7C2Jht6DEM=;
 b=Q12BNT+P8sEs3U8irPkHc4ymLosaJ8VBfbhoZ3BqowxOzt8qmFB3ZrC9AUOuF6fWRZlSRW6yJftZfbpv1kMBy22oO+USp3OfQDl8TIYs6jVk1HzxsPFMJMpOkyxxfrXH4U5EFTlyBg7qFxZroCOzYtFYZFoz4q+c6+OhULlTYHr4H68A+3t/wak7Kf/q1mr/9i1eXa5moQ4D6K4TpTGoaQo/VwNTsDNQyNYwhj7J2CJBsS0o6LVjNlE63bze5vC3RHhn4GV55Un6MJS+LsTiZZ6ZAoeieIM7J2fs/jlPDMAoFsfkAO5hIToE7y+xKYY3Jk9QayMWvMfwBBCfm5kOLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FoQ6QsfwpY4lAhkOPpnDq67aySaNkz/dL7C2Jht6DEM=;
 b=L3dBSVvI2zmp72JjzAqQG+ZTQSvZTTcP3jkJmmpQ8hRKpPbZwB0ZGK4iN+aeGMcAmVVY1HOOvmt2uPMnD6bnsST6btLDTzRC+6wuh5Y4LRIAuQf1FZfdmh8L4pJyEoo82YEBT2IMtmd5w/FsC5WCUeku39d7YmZ3ykVLGOacyknYJTL9h1p31KalHUcu+0wbaWTkHV5rcG6ykPONQ8oJTP51GaJUYHXDQ+W6NPGteHR5ZMS+MmJCwU+O1g9tXlXNeN989hOrJ5FaZwQz7ZOKGAseLrJ7XFV+LtWivoZ7pjV06Twc0SpXpbgrBsu0NrV0WehtewAlVFojXZQazQ9lEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a0::18)
 by QB1PPFA62BABA4F.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c08::277) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 14:38:45 +0000
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5393:fe91:357f:3ccf]) by YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5393:fe91:357f:3ccf%6]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 14:38:45 +0000
Message-ID: <c3781655-b667-4477-9337-445d8250fb4e@efficios.com>
Date: Mon, 10 Mar 2025 10:38:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] selftests/rseq: Add test for rseq+pkeys
To: Dmitry Vyukov <dvyukov@google.com>
Cc: peterz@infradead.org, boqun.feng@gmail.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 aruna.ramakrishna@oracle.com, elver@google.com,
 "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1740664852.git.dvyukov@google.com>
 <9a98ed5d655e9a0d66027779c75c3ba67601e1bf.1740664852.git.dvyukov@google.com>
 <26b779d4-0478-4926-ba5c-e71449e92020@efficios.com>
 <CACT4Y+aT9z8qjY-66wiOR0Wiep2BoTN7QJYxj-QK_KRXLmgiLA@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CACT4Y+aT9z8qjY-66wiOR0Wiep2BoTN7QJYxj-QK_KRXLmgiLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::32) To YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:a0::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB9171:EE_|QB1PPFA62BABA4F:EE_
X-MS-Office365-Filtering-Correlation-Id: d7f6d46a-0b1c-4dbe-7a8e-08dd5fe142c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWJmeXRmZXdCUWVRSTY3ZEhwWTlFYWt5blVZYUVXVXdiWGc0a2xnMUlBc1VR?=
 =?utf-8?B?NVFUOExVTkkxdGZSZGJzOWJ3RWZMVUVQZDZldDFPL1gyTEFLdGNid1Q1dVpy?=
 =?utf-8?B?UGV0RFNoU3prcUFpRTBDYVMzWjV0UHRpWFRFbzFpbTI2RWMzT1YrS3ZBUkZI?=
 =?utf-8?B?bC9Ja0FKaS95Q2ZRZ0V6U0d4T2wwbnhucVN5YTNyWG5BSTFrdG9iUWZjVVgv?=
 =?utf-8?B?RUNlaHdPMi9pWnFlK21vbkNWdUlzMzNlejY4bFkwdE5YSVdsdVN2QitpYkQ3?=
 =?utf-8?B?VUV5NnM1Q01vdzRxY2wxc2xnOFJhRWJBcFhJaFpDOEJPa1FWS2hKN3liVisr?=
 =?utf-8?B?T1IwKzMrWVQ5dFpNcVBCVWdKYVk0RUtGZ3RkSm5tRVZiSzdVNm9JWDBMOGlu?=
 =?utf-8?B?bkNYMXAxRWNhK2xRNmw3cmdkbmNoVG8rL0g5OWl1blVLTTRFNWs5ekRHZk1K?=
 =?utf-8?B?Q0JwTXBGSlJLQ2VjZDJISDl0dGczWjk2c3psYmV1SjhFMllOdjRSVWtnc084?=
 =?utf-8?B?YzhobTh0QklLdjNKVEEvc0YxeVU2L0tIWGc0aURqWmtaZG5WRC9TT0g3WVZG?=
 =?utf-8?B?QTdNZGpnYnNYN3JQNXJoRlhBM015SnlZZ0RUblhDQnhubzRUakF5SkxzaGVT?=
 =?utf-8?B?OEVyd21xdjd0dTNJSkFNV1A1eWtXazBzYUM1V2p5dXRrVDNBKzJXbXM5bGRN?=
 =?utf-8?B?UTVYZ3I2OXVnZitvYTk5aXRBa3IvaHlZbkpnOXFlcFdySE1EVHNSbVRIVVB5?=
 =?utf-8?B?alYrb2VoM25xalFGajFMQUZqcFJtZzNYMSs1LzVxOTREa0hydzF6dmIvNm43?=
 =?utf-8?B?SFdPbTI4MlY2VDZwVkhQeGFENnk5dkd5UDQ3Zko2YTBGMWxTRnhqODNEWjlO?=
 =?utf-8?B?WW5zaEtSZTdpWjRQY2RXQkMwWGRxSktMSG10S0krNWJUREF3WGRPY1dzMzMz?=
 =?utf-8?B?NWhGTjZVdnhhWXgyL1BoK0RZN1FreWJBc0lWNDBCekNYelhkSUdaR0JqYmNz?=
 =?utf-8?B?Q2JIcUxEWEJOYWhMdW95aFJ1NC82SmgwcHdhOFkyUjBlVkhqSStKK2hLZkFW?=
 =?utf-8?B?NzFuUnhhMHJKYU9OaVI5UzB6dkpFVi85ZnJiQ2NvMTRjNWVxWXNDbk5QTGRs?=
 =?utf-8?B?Sm5EVUMvd2FPMU1UU3pacjJSejZzTTlQcUhiQ212bG9YbVJzTWl0UnV6b0lG?=
 =?utf-8?B?Q0dZSGFYalpXUUhsazhoR0R1NXRSL2xsa05KeTlBankvdFk0YytyYmRHZ0wz?=
 =?utf-8?B?ZEpQUW44NW41bzRCZVJNTjhpZXcxdkdLazBGMG83Ni9PUGk5MTYzaDR4QnBK?=
 =?utf-8?B?WGxhZnMwL3NiZHJOd1BTb3d1dzlKdDNLUDRNSnZTNHNXWWZ5ZDEyYXRVYk13?=
 =?utf-8?B?R25CdzdGQjlLL3VNZGMvWU5GRUFhaWZPTnRSNzZsYk5RTDFNUG5rRU1iclgy?=
 =?utf-8?B?OXVtYjNnMGJ0czVZcmZFVitDT0N5RnpTT1JoR3JlTlNXN1prVlpoNFBOVFNz?=
 =?utf-8?B?eWpPY0xKSmdDaGVJajR3cUJjRDVHZHpEaWJPZkZaOEw1WVRISURXUDNSSk1m?=
 =?utf-8?B?QWgxM1lDeTdkQ0hRaUc3MlNuVkw4WHNGc3dGUWdReU4xaTI4dXo5ZnJQQy8y?=
 =?utf-8?B?YjMrWUxSbWpVbnFSSGw5ZmY1UXd4aElESE93M0trRU81R2dZVDdPbVZ1enJx?=
 =?utf-8?B?R3lzZTdxUmdvZ2lrYUEwUzl6eW5jWDJucFowVWdpdDIyYXdWMkVDT1J2VGtq?=
 =?utf-8?Q?n7yCh+Uakfeb5xAGFGe/66WLdAJhTI9BnAExqv0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(13003099007)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEtTdWZyTVJOZjJHbm9UT2MwVWNUOUVTYUZWbFA2UkV1TjZBZHdSdE02cUxQ?=
 =?utf-8?B?NUF4bTEzR3N3OFNFOS9tczNJTkw1RktLOFk0R0lzcjZvVmlBYWxJdUUzRWJE?=
 =?utf-8?B?YlpXckZoZWNpc2ZKSTBCZ2s1Ylk0MHdWYzhCMWQ1WWpnMDJ5T2xpLy9uQy9y?=
 =?utf-8?B?ZDBpS2JtWFpweTJpam96cHFJNkFVbVczQkhzUjB0aFZPeW1GTzQxL2NaL1g3?=
 =?utf-8?B?aDM1c1FRVkpzeUQvRnBBZktCbHNGSzk1aG1qQzcyK0h3T1RqSnVlZnNBSk1T?=
 =?utf-8?B?azdkazdqM0FXYzhXS3dPK3Jka3gvWVlwUzB0WUxzMGtEOXNLcDJTc3NJc0xn?=
 =?utf-8?B?b3JrSFpVTmU0b24vc2FqUWdDY09uS2R4OHhUVnZUL0hXenY4SHZpMTU5Ti8z?=
 =?utf-8?B?cmFOTVlOMVlIWUNTQ1VhWG1lM2RNRUFLYzVVZEdNVXBKVjBZQmhmZXZCVlZP?=
 =?utf-8?B?V2ppUzNlSEtlalNoMVhjTnVHK0VrYjVLVndFUG5XUFN6NzkvWjB0Q2hTWU5F?=
 =?utf-8?B?emwvOFZhNEVlRVFCalBXNUowMms5SStZNkdWOS9mYU52N1poUDRSelUwLzM0?=
 =?utf-8?B?SXBWSDFNb0w0eFBnZy92YXprZFZUMWJVUjk3Mksrb1JKTUQ4VEtqdDVFNmZk?=
 =?utf-8?B?RzVPZ3h6ZU9aSXAxcGV2MVNHRnR6ckNTNmZ6U3ZpUWJ6L3FzTHFUaSszRmdx?=
 =?utf-8?B?Y1FEMlJKNFdKNWxYZHlxelp1RjVNT3FiY2dIZ1NRcExpd2FzV2ltOXJJTmJh?=
 =?utf-8?B?QVRRSmVPZll1MDVGSHJudE9Qb3U5eFVwZ0JYNFZMd0JUNlRVVkxlOXJwdlhT?=
 =?utf-8?B?MlZ1QXVoZ21EYVVZVyszVCtHdlk4UFFnTmhwb0NTbzFqRHpiaUpYUllKM1dm?=
 =?utf-8?B?NmJXOVBKbG5hclJocWtGWVF3OWk3cXRGanJhZG5HaW1MeWlHSFpCRTdDSW9F?=
 =?utf-8?B?Ym4rbTlSZG1UaWVFMkROdlU3K3ZXOG1oSk9kNWtvL282cVBLUlB2ZCtnUXNp?=
 =?utf-8?B?ZFBsY2xhN3dpVVVjYmpMUkQrZGdXaWxValdMQUZ3c2txOXRiVjZSd3lITGJh?=
 =?utf-8?B?UHFENlg4TmxLdTJTa2t6a1ZvTklBMkMzSkRzSmMxTllSb1pGL3ZNOWc0QUpp?=
 =?utf-8?B?WFU2TmdvdTROZVA2Q1JwTjFzVHgzZk1rcXROeDMwWmRCaWZVYmI4WWE2WTNB?=
 =?utf-8?B?ZElSamlrSDVFNEpyODFGVUF6K1FrSGMxK0dsdlJoT1AzTzAwcTh0ZWdYMlRW?=
 =?utf-8?B?Q0pDSUs1dUZzSlJLWTFDcUdrVEp6dThqcy9vU1RpdHhGQ1lmdk1TZldLV3I5?=
 =?utf-8?B?dVlwRldpcjM1ZkhNemczRnpxUDg0dGZPUzVBdVFZcHYxalFDL0VYQkZnMzdw?=
 =?utf-8?B?eXpqSjJtdnhsMnhpaVBQd1hHV0VxQ3BwYnVYRURmSnphalU2NW1IZnE3Mmkx?=
 =?utf-8?B?TGprc2t2SERGM1pEVHFKT0xhTWExdUsxNVVuUEgvZjRieXI0c3JqSkdLa1p5?=
 =?utf-8?B?R2ZqcmlHSDJJUVZncm9ManErclZId1ppRGMzWUlhNU5Ycmt3clpzeHhYQ0ND?=
 =?utf-8?B?clJvNXVUazdaQlRLdHJwYUw0d2JyS3I2a3ovQzVJMEswQkZnblNPSThXNlZn?=
 =?utf-8?B?UUR1RVQ3ekRkYUFISHhFT1U2Zk9mL2ZoRVNtOC93S3JraW1oYXloektHYnBW?=
 =?utf-8?B?VEZkdGJQRUdRcWhCcXJKTDRLTExBUEZ1Y1Rld3hwZURnT0tYOW5tU0hiNlly?=
 =?utf-8?B?dHFXOHRJTHBHQ3VhWkVjUCtWZXF2WkxGeHRGRThyTG94TGtQWUp3OHhudU9L?=
 =?utf-8?B?Tlc5K1lsVlFYL1dKZWZKTDY1MVJmSWYyakNJR055bFczRWk1YWY4UFV2ei9a?=
 =?utf-8?B?SHNJYlk4QnNDNmFScXp2SURQMTF0Mmt4OGlrSFFFN3dUYVM3ZHg1WFoyaGVG?=
 =?utf-8?B?OGk1Y2xhcElCYzZxWHFwSGdUbVg4eUk1TkM1M1dVb0tBazdScDdDZmFwMmFr?=
 =?utf-8?B?czFYT3gxMXJqMlo1VGVHcUZ1WDNlRlB3ZzlHSFB3d2JkblhFbzVPWXhIc2dl?=
 =?utf-8?B?U3EwS2ZmZkI5Ym44SVFlY1BkNWRRaHNaVHlwMGphMU1uWXgzWFVEMUFhUUxo?=
 =?utf-8?B?UEhUK0tmanZ0VTh5VHBQbFh6Qnd6LzZ1MDhELzlZVHBpdUZhOGxDd1pZWnZQ?=
 =?utf-8?Q?pYpH4B+QkumPclsCU5Ek3b0=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f6d46a-0b1c-4dbe-7a8e-08dd5fe142c5
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 14:38:45.0724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2rEnCTjeZpRiL9Fy/+FgBoDJpuBbrCVeC+0fTZxfhuRv41pHSJ4XyyJRxSUxi+gKVq/EVF+DlEiX6KvVkhifYSgjlQGOTcNcN62ly3OuBGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PPFA62BABA4F

On 2025-03-10 10:36, Dmitry Vyukov wrote:
> On Mon, 10 Mar 2025 at 15:30, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> On 2025-02-27 09:03, Dmitry Vyukov wrote:
>>> Add a test that ensures that PKEY-protected struct rseq_cs
>>> works and does not lead to process kills.
>>>
>>> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
>>> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>>> Cc: Boqun Feng <boqun.feng@gmail.com>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: Borislav Petkov <bp@alien8.de>
>>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>>> Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
>>> Cc: x86@kernel.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
>>> Fixes: d7822b1e24f2 ("rseq: Introduce restartable sequences system call")
>>>
>>> ---
>>> Changes in v5:
>>>    - Use static for variables/functions
>>>    - Use RSEQ_READ/WRITE_ONCE instead of volatile
>>>
>>> Changes in v4:
>>>    - Added Fixes tag
>>>
>>> Changes in v3:
>>>    - added Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
>>>    - rework the test to work when only pkey 0 is supported for rseq
>>>
>>> Changes in v2:
>>>    - change test to install protected rseq_cs instead of rseq
>>> ---
>>>    tools/testing/selftests/rseq/Makefile    |  2 +-
>>>    tools/testing/selftests/rseq/pkey_test.c | 98 ++++++++++++++++++++++++
>>>    tools/testing/selftests/rseq/rseq.h      |  1 +
>>>    3 files changed, 100 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
>>> index 5a3432fceb586..9111d25fea3af 100644
>>> --- a/tools/testing/selftests/rseq/Makefile
>>> +++ b/tools/testing/selftests/rseq/Makefile
>>> @@ -16,7 +16,7 @@ OVERRIDE_TARGETS = 1
>>>
>>>    TEST_GEN_PROGS = basic_test basic_percpu_ops_test basic_percpu_ops_mm_cid_test param_test \
>>>                param_test_benchmark param_test_compare_twice param_test_mm_cid \
>>> -             param_test_mm_cid_benchmark param_test_mm_cid_compare_twice
>>> +             param_test_mm_cid_benchmark param_test_mm_cid_compare_twice pkey_test
>>>
>>>    TEST_GEN_PROGS_EXTENDED = librseq.so
>>>
>>> diff --git a/tools/testing/selftests/rseq/pkey_test.c b/tools/testing/selftests/rseq/pkey_test.c
>>> new file mode 100644
>>> index 0000000000000..cc4dd98190942
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/rseq/pkey_test.c
>>> @@ -0,0 +1,98 @@
>>> +// SPDX-License-Identifier: LGPL-2.1
>>> +/*
>>> + * Ensure that rseq works when rseq data is inaccessible due to PKEYs.
>>> + */
>>> +
>>> +#define _GNU_SOURCE
>>> +#include <err.h>
>>> +#include <errno.h>
>>> +#include <stdio.h>
>>> +#include <stdlib.h>
>>> +#include <string.h>
>>> +#include <sys/mman.h>
>>> +#include <sys/syscall.h>
>>> +#include <ucontext.h>
>>> +#include <unistd.h>
>>> +
>>> +#include "rseq.h"
>>> +#include "rseq-abi.h"
>>> +
>>> +static int pkey;
>>> +static ucontext_t ucp0, ucp1;
>>> +
>>> +static void coroutine(void)
>>> +{
>>> +     int i, orig_pk0, old_pk0, old_pk1, pk0, pk1;
>>> +     /*
>>> +      * When we disable access to pkey 0, globals and TLS become
>>> +      * inaccessible too, so we need to tread carefully.
>>> +      * Pkey is global so we need to copy it onto the stack.
>>> +      */
>>> +     int pk = RSEQ_READ_ONCE(pkey);
>>> +     struct timespec ts;
>>> +
>>> +     orig_pk0 = pkey_get(0);
>>> +     if (pkey_set(0, PKEY_DISABLE_ACCESS))
>>> +             err(1, "pkey_set failed");
>>> +     old_pk0 = pkey_get(0);
>>> +     old_pk1 = pkey_get(pk);
>>> +
>>> +     /*
>>> +      * Prevent compiler from initializing it by loading a 16-global.
>>> +      */
>>> +     RSEQ_WRITE_ONCE(ts.tv_sec, 0);
>>> +     RSEQ_WRITE_ONCE(ts.tv_nsec, 10 * 1000);
>>> +     /*
>>> +      * If the kernel misbehaves, context switches in the following loop
>>> +      * will terminate the process with SIGSEGV.
>>> +      * Trigger preemption w/o accessing TLS.
>>> +      * Note that glibc's usleep touches errno always.
>>> +      */
>>> +     for (i = 0; i < 10; i++)
>>> +             syscall(SYS_clock_nanosleep, CLOCK_MONOTONIC, 0, &ts, NULL);
>>> +
>>> +     pk0 = pkey_get(0);
>>> +     pk1 = pkey_get(pk);
>>> +     if (pkey_set(0, orig_pk0))
>>> +             err(1, "pkey_set failed");
>>> +
>>> +     /*
>>> +      * Ensure that the kernel has restored the previous value of pkeys
>>> +      * register after changing them.
>>> +      */
>>> +     if (old_pk0 != pk0)
>>> +             errx(1, "pkey 0 changed %d->%d", old_pk0, pk0);
>>> +     if (old_pk1 != pk1)
>>> +             errx(1, "pkey 1 changed %d->%d", old_pk1, pk1);
>>> +
>>> +     swapcontext(&ucp1, &ucp0);
>>> +     abort();
>>> +}
>>> +
>>> +int main(int argc, char **argv)
>>> +{
>>> +     pkey = pkey_alloc(0, 0);
>>> +     if (pkey == -1) {
>>> +             printf("[SKIP]\tKernel does not support PKEYs: %s\n",
>>> +                     strerror(errno));
>>> +             return 0;
>>> +     }
>>> +
>>> +     if (rseq_register_current_thread())
>>> +             err(1, "rseq_register_current_thread failed");
>>> +
>>> +     if (getcontext(&ucp1))
>>> +             err(1, "getcontext failed");
>>> +     ucp1.uc_stack.ss_size = getpagesize() * 4;
>>> +     ucp1.uc_stack.ss_sp = mmap(NULL, ucp1.uc_stack.ss_size,
>>> +             PROT_READ | PROT_WRITE, MAP_ANON | MAP_PRIVATE, -1, 0);
>>> +     if (ucp1.uc_stack.ss_sp == MAP_FAILED)
>>> +             err(1, "mmap failed");
>>> +     if (pkey_mprotect(ucp1.uc_stack.ss_sp, ucp1.uc_stack.ss_size,
>>> +                     PROT_READ | PROT_WRITE, pkey))
>>> +             err(1, "pkey_mprotect failed");
>>> +     makecontext(&ucp1, coroutine, 0);
>>> +     if (swapcontext(&ucp0, &ucp1))
>>> +             err(1, "swapcontext failed");
>>
>> Should the rseq register be paired with a rseq unregister here ?
> 
> I dunno. It's necessary for this test and in general. Tcmalloc won't
> unregister on thread exit. Even for a libc it may be a bad idea due to
> signals.

The rseq register/unregister is only for the case where libc does not
support rseq. But if you want to use rseq_register_current_thread(),
then you'll want to pair it with unregister.

Thanks,

Mathieu

> 
>> Thanks,
>>
>> Mathieu
>>
>>> +     return 0;
>>> +}
>>> diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
>>> index ba424ce80a719..65da4a727c550 100644
>>> --- a/tools/testing/selftests/rseq/rseq.h
>>> +++ b/tools/testing/selftests/rseq/rseq.h
>>> @@ -8,6 +8,7 @@
>>>    #ifndef RSEQ_H
>>>    #define RSEQ_H
>>>
>>> +#include <assert.h>
>>>    #include <stdint.h>
>>>    #include <stdbool.h>
>>>    #include <pthread.h>
>>
>>
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> https://www.efficios.com


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

