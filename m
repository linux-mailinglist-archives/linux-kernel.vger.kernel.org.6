Return-Path: <linux-kernel+bounces-203644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018358FDE8C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B621B24527
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 06:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D99944C8C;
	Thu,  6 Jun 2024 06:14:18 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F333EA71
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 06:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717654457; cv=fail; b=T/eyrq+9LLMFrLEze/KZWbUvb0cP6dvcnUS+zmrVZCPWgl60oMFMntg5lRtEd6ik0cvKxfO43/vSB6/Ns7MEm7AD5bOqivD64Al072fODU9xUSP6Bdq39T0FLp4w9hCNwxXfVfX3wWDZe3B88GOu+AKe38Ngyivxn6KaxScgwMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717654457; c=relaxed/simple;
	bh=7HQGHCMBcbDvMwMv92A8koEkJvfLVFMYeGbv+2hDTjo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nFHdQrRUyUb9SkyG1+96zwUQ1wwGdG7VFu1lHKV2fwclB81HDc7hGe1ZxMPY4fhlS755RNy2qTL++YSDxHTY6kEJpgXJiwk3rFZTzQd0NHynAu4EFSN+SSq675Og3HNVot5vCsQkgD3mPMMOprwmH39BTMgyF9kLOtHdBtGFqOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4564fxbS013866;
	Wed, 5 Jun 2024 23:14:01 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3yfxwyvqj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 23:14:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEFGEN9mKKnWztPKZ/twmPakOK9pPhqjqfmMrUwqMvu3So4CPhxB56/Tgz/Dx7BCpa9MhxJdqAgTDsCYxrw27M0x6UJGVaC+qwheZkdsHJ/BeRW7RDmKkrJQY7bKslBjvD87kgq9dS4kWn7hitxOjtfBqZOoIwEmFk4Hg2xLlYWr8eENTqkoBePfXs4dsPN4fUJGaL0uqZ+S7zMHQTQii9lbZdT552+YSnp4TUtwc4kZOW0BRCb9rApT8rSiohjuxnvBblEF7B89DlsQkNLrPgH9j7hgo3YA0uhSEfo0vb8nfkroiBXlckGwjxcwMejcN+Mchf3S4OWJ1yrq9iWxGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1clKmEoB4bI++AbJ4SIsvzNgpToycRqYO0TdoPwCNZI=;
 b=eCak7u7hwK8wXz8UzrY1R6XH1GbRnikojm6S5nDjW70hMGKRSbEXxenGPpfulsUNsrK/9MOZ6Jsy0yonHxgxvxf4GyZGw7i/4ZUnYxD/MOD/MuxoiT+v6jfBiqKDaQqmOrSEAEvsNpidSNkZX/rfSZMPeHDgxhCqNl1bmp9pYefsfhzCzY0v9nTFbA25b1ZIf66jYZ2iXJVqo7sEUFlP+NdEAoKdhZMhjsPzm9mvKSvvB75dgUNCO2HtIhHt2D681uxwe1jx0XkZexzdquHC3WQDDcbTspD+t0yglruTVZvw1rFucMaO+sBRfCkAKV1yr5i2KGiDIxKoJXi5Mum+SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SA3PR11MB7527.namprd11.prod.outlook.com (2603:10b6:806:314::20)
 by SJ1PR11MB6300.namprd11.prod.outlook.com (2603:10b6:a03:455::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 06:13:58 +0000
Received: from SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538]) by SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538%7]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 06:13:58 +0000
From: He Zhe <zhe.he@windriver.com>
To: clemens@ladisch.de, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc: zhe.he@windriver.com
Subject: [PATCH] hpet: Support 32-bit userspace
Date: Thu,  6 Jun 2024 14:13:42 +0800
Message-Id: <20240606061342.2142527-1-zhe.he@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0024.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::36) To SA3PR11MB7527.namprd11.prod.outlook.com
 (2603:10b6:806:314::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB7527:EE_|SJ1PR11MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: 95f4fddc-4e82-4504-cacb-08dc85efda14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|52116005|376005|1800799015|366007|38350700005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?hJ9lz4VvY1otbWKGGJ76KTND6jUHuTkCSv1LzvlzX+oo40HXzvvvjeAvJloi?=
 =?us-ascii?Q?FIFlLn0y9DiPgSl+AeYQFNFcwhUUTdFakeI36eumB5IO7YeHxogv1BnxTN/q?=
 =?us-ascii?Q?e51PAjAlO9+BJOFs/vpLNsCi3+kUssDpdUCbW2EQEuvHQPIx1OaKNuncb0Og?=
 =?us-ascii?Q?dn2Ja06tH1LnflOGfKZcONmz4Umi08oezWAzPFVwT9SCkhGoxCJpb1uM6IqT?=
 =?us-ascii?Q?hktpv1Ya2zII0yHKUoC5lzUevTdurZrVQFH16tgPC9aEO/tZEtWVS/E4EFbc?=
 =?us-ascii?Q?WfqmudN5qeDg2wsBc0ifDVbnMeVwBDfTT7mGDxspKOqEuLBHQYSBU/amH7Gd?=
 =?us-ascii?Q?zSO+YJPJi+jz+WoXf6Tq2UR/+ZA23TPINxdwGmT5ymLCtlz4fEzXkmI5axY3?=
 =?us-ascii?Q?ocCgZdi8ETklXA0X0Q92/cUX5/9F9MmCtP864N1zbMQPhNBaPsjpDUcsRMOa?=
 =?us-ascii?Q?Iu2JGxYndS7hznx/SseeiLvnMHK54OHGQiehIkBTSi/S6pw+0jX3mfAwNdv/?=
 =?us-ascii?Q?235XqxgDJZ5wdkREoroeFJfRWtRpbYI8L9mAhgev9duUWfLFPvYp5DEDQNbf?=
 =?us-ascii?Q?UyKCaklv7VDTnwgZ6qXKQldVPvvg/4hWKcuMjcF+bEywYDawuBBxsvqdz6DQ?=
 =?us-ascii?Q?WvHRtui+pkt6OG5lRSq2iuwOTb+bxMy0pXfgEcgum6pt1D9yWTRYhdFyx1RJ?=
 =?us-ascii?Q?GooIaeS8sFl3Ap6+agikYDPLFJcIntyugcV1zKOqvQmqhvS7CtowXyPDIlGq?=
 =?us-ascii?Q?DixMIM9MaXfK9PwAhVadj1RAWLQH9KLks6d8UEFN/osmT66CxIh6GADAad2B?=
 =?us-ascii?Q?LHxcgoel9wWhtq2j6Oz1cwhXuUiHex8Xp+8hD4A1wNH+eEDHVqtf0S30HeKy?=
 =?us-ascii?Q?p4IbFRq2UDyr3/gjAODt7M2yNO1rKVW4ZPNHWHwCmB9VfEFq+wh3k/Xz+MI3?=
 =?us-ascii?Q?Q37J7AEHQE9PU7L+4S5SsJVBCBB1Zuk8F7jPkssViYtkJ6dcoVl0UcBVDH5c?=
 =?us-ascii?Q?s+1VdR7l/Okja7AqNuI8Hyav8/oLXZCeJaG8AphpeizkLFCm0OAWCBIbRYsc?=
 =?us-ascii?Q?LCrGN4+W+TunEW/MNhg7rGZG8LhqBkrufyl+1isl13OQJr852NF8MVKPwJtN?=
 =?us-ascii?Q?tiHOzBv5Ugg1LeKNNvyYLugV6AGgjHp5qY4V5d3GodO1DyJVycHex9Zpw2lW?=
 =?us-ascii?Q?ZQq3CPes2Xvg6sw+4XMX8uHiR+/d0475W64zoBztExChlsyAEVWlz/S2DEcS?=
 =?us-ascii?Q?zgylASznow8EUPHtkXelZ9WWbmkYOYfuFfDz/24FYfr8kZbYS5aZDdNfO2if?=
 =?us-ascii?Q?5Z3/rPqx950uJkqV9/QLs+LIj7XNnhoLclk2JZjKNOcS2mHrKQzWRNtKA5ph?=
 =?us-ascii?Q?jaOtJpM=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB7527.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?oKyvxW3TUKFVSX6HooESjLFy60/Y38i2rAn2frpxMzM8nGFT7R4a96Wt8cuc?=
 =?us-ascii?Q?9JhLBF6YLnZadaEAFFJz3Stnbb1juDBxg1r6kDIzVZw1VTdxeVGa17f8yiOo?=
 =?us-ascii?Q?xO59++PRNFYJkCTSDtjkRXHpMntpEF45QEQ87ymOuHXMQKBxwDPClZtBm5xF?=
 =?us-ascii?Q?KsmQngpjxGM7YP7Tcw5J8+ujVxcgLQmKsYWBfK/w6RA2xisdtByo6RHmZ3xe?=
 =?us-ascii?Q?WewwcrrkKQUtfmjAiMrCHx0yJr/WHHWIxqxs4MUHCkKmLOSV536YTKgd67T0?=
 =?us-ascii?Q?10l78IY8GEfZQ/Lp6Qh5//DmyXTubfbkreiXWCVsz0KDhohs1CeiszhdIh9E?=
 =?us-ascii?Q?jXTF+0CvPkwZjoCg8fNMgU2sKGNbj80Urf9fzUOuDZV+XMiEq/9Wkai5nTqb?=
 =?us-ascii?Q?2Tw6UIZ6m3XI74Qx6F50OlvwxeOOWGo4nPxtJWe+HNvjzJZg812LxI+EeMYe?=
 =?us-ascii?Q?OcCO/7L0rWe6ID3E36auzi2+iQJIz8caOw4ngtV7mZEKgNqobw8y6Hw+mhRv?=
 =?us-ascii?Q?r8GfuXbgX4ToXApSoJ7Tx9Lr/nKmCyZwWkBZuEWmgLk/drQl2GV5FOHbkfMJ?=
 =?us-ascii?Q?B5XqKxmBILCzc94VvzKQoEFsIeSl+xBnmCOFT2TxAZNMAb4TjfTTjSqV/wov?=
 =?us-ascii?Q?YT1xyp/5Xr9ho22ReMKfaspaqilj2Q9ks6hJB4kIcMuRkvg1dz8hgATDBE7L?=
 =?us-ascii?Q?5hhDf5+II0o8rNVKDo9Z5oTmRiJ359tKuVP/8pKTTMBG+SkTeEAd9t20lnZe?=
 =?us-ascii?Q?c1ahazn/JkZgkIVvCm/nZ0XPylqjWJpxttgJVK7m118LVsPUlRVTJeYHsLfy?=
 =?us-ascii?Q?mxYVxBSX9A8hSslMVHTB9zJBUkAvRe5ppVGswEDkjoe6/f7dOQ9s7zF68skw?=
 =?us-ascii?Q?hlZm7RdSERKnBUknaEvvAP4o/UFxuhFiAusrbvAQJRzp5nJ/kDaOfscChtWR?=
 =?us-ascii?Q?tS2F66WPVZ9cSi3g/c7yK1bklzkiHnARersbJ15DOQL52s9CyP080EfCiSI2?=
 =?us-ascii?Q?BMjLBZ0qUTj++CPA9mGcSyzQyjbffONLy1xcS0+50R4VhQPauaiaYFmRMBHS?=
 =?us-ascii?Q?VO/uDv2PyDdtiiiKSYEopPJ3no/gTwiQAqNljQXpjzr69p7+KpqZbD7bCVoG?=
 =?us-ascii?Q?x/yun68EjJ/L2XkGsPRWDh6w5lTErilG/M5LFDNH1PVW2TjF5Jg/64fhjgYq?=
 =?us-ascii?Q?aBkP1rOH3scNFJgfwfraRa0wiHV5DSK97xff2hVzDmG2hHLS7tqDtDNmZMi3?=
 =?us-ascii?Q?YKxHcQlsipndkZn31yP6T4oJHrZfp0ZVXzNy6CSV3ynOKiHzIWe3gzH3m8v5?=
 =?us-ascii?Q?qEiT+N76NWip2BQZAmBsWfMdnAoqZ9KfKi2S6C+s7hV9IWTti3rCIiQ9arSL?=
 =?us-ascii?Q?pTxDiT3eEC6vlm8m2akZkrmtb8iyEOXxgVAHNUfxqCgi29oRVHgxcPDYTowP?=
 =?us-ascii?Q?/joDi+rAS7+KKITMaePHxkLHKD3nH9aBABlaPkUFzJjvlvP3Jz0wjeM+9lst?=
 =?us-ascii?Q?uGYS1USiZOA6iOHKMovTghJ873uNYwk5A2M3drQ1ByWTDvpiR5biXN8ItSTC?=
 =?us-ascii?Q?EnYvLa+ZIz4UWmWyVKUMXT5wd0eybDFCf5xeJxno?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f4fddc-4e82-4504-cacb-08dc85efda14
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 06:13:58.4112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yDkdzHQLo4fN9Ohremj+a1RAmHvmFnF/lmlMYs+JKdZtPRKDMmPhJVxKJnJXO26Cdd58/mS3sFYu6fvajRC8hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6300
X-Proofpoint-GUID: RPFibVslMDzdkF8itu9IJ2SXLwcW8aUK
X-Proofpoint-ORIG-GUID: RPFibVslMDzdkF8itu9IJ2SXLwcW8aUK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=958 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 clxscore=1011 adultscore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2405170001 definitions=main-2406060044

hpet_compat_ioctl and read file operations failed to handle parameters from
32-bit userspace and thus samples/timers/hpet_example.c fails as below.

root@intel-x86-64:~# ./hpet_example-32.out poll /dev/hpet 1 2
-hpet: executing poll
hpet_poll: HPET_IRQFREQ failed

This patch fixes cmd and arg handling in hpet_compat_ioctl.
And adds compat handling for 32-bit userspace in hpet_read, based on the
method in commit 3418ff76119d
("[PATCH] RTC: rtc-dev tweak for 64-bit kernel").

hpet_example now shows that it works for both 64-bit and 32-bit.

root@intel-x86-64:~# ./hpet_example-32.out poll /dev/hpet 1 2
-hpet: executing poll
hpet_poll: info.hi_flags 0x0
hpet_poll: expired time = 0xf4298
hpet_poll: revents = 0x1
hpet_poll: data 0x1
hpet_poll: expired time = 0xf4235
hpet_poll: revents = 0x1
hpet_poll: data 0x1
root@intel-x86-64:~# ./hpet_example-64.out poll /dev/hpet 1 2
-hpet: executing poll
hpet_poll: info.hi_flags 0x0
hpet_poll: expired time = 0xf42a1
hpet_poll: revents = 0x1
hpet_poll: data 0x1
hpet_poll: expired time = 0xf4232
hpet_poll: revents = 0x1
hpet_poll: data 0x1

Cc: stable@vger.kernel.org
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 drivers/char/hpet.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index d51fc8321d41..025a5905a370 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -269,7 +269,8 @@ hpet_read(struct file *file, char __user *buf, size_t count, loff_t * ppos)
 	if (!devp->hd_ireqfreq)
 		return -EIO;
 
-	if (count < sizeof(unsigned long))
+	if ((sizeof(int) != sizeof(long) && count < sizeof(compat_ulong_t)) ||
+	    (sizeof(int) == sizeof(long) && count < sizeof(unsigned long)))
 		return -EINVAL;
 
 	add_wait_queue(&devp->hd_waitqueue, &wait);
@@ -294,9 +295,15 @@ hpet_read(struct file *file, char __user *buf, size_t count, loff_t * ppos)
 		schedule();
 	}
 
-	retval = put_user(data, (unsigned long __user *)buf);
-	if (!retval)
-		retval = sizeof(unsigned long);
+	if (sizeof(int) != sizeof(long) && count == sizeof(compat_ulong_t)) {
+		retval = put_user(data, (compat_ulong_t __user *)buf);
+		if (!retval)
+			retval = sizeof(compat_ulong_t);
+	} else {
+		retval = put_user(data, (unsigned long __user *)buf);
+		if (!retval)
+			retval = sizeof(unsigned long);
+	}
 out:
 	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(&devp->hd_waitqueue, &wait);
@@ -651,14 +658,23 @@ struct compat_hpet_info {
 	unsigned short hi_timer;
 };
 
+#define COMPAT_HPET_INFO       _IOR('h', 0x03, struct compat_hpet_info)
+#define COMPAT_HPET_IRQFREQ    _IOW('h', 0x6, compat_ulong_t)
+
 static long
 hpet_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct hpet_info info;
 	int err;
 
+	if (cmd == COMPAT_HPET_INFO)
+		cmd = HPET_INFO;
+
+	if (cmd == COMPAT_HPET_IRQFREQ)
+		cmd = HPET_IRQFREQ;
+
 	mutex_lock(&hpet_mutex);
-	err = hpet_ioctl_common(file->private_data, cmd, arg, &info);
+	err = hpet_ioctl_common(file->private_data, cmd, (unsigned long)compat_ptr(arg), &info);
 	mutex_unlock(&hpet_mutex);
 
 	if ((cmd == HPET_INFO) && !err) {
-- 
2.25.1


