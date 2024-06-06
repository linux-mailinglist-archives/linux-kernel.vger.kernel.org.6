Return-Path: <linux-kernel+bounces-204046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCD88FE356
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 345C91C25207
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A169178CC0;
	Thu,  6 Jun 2024 09:46:57 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F48C154424
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717667216; cv=fail; b=K+aOx0YaUfS35B/EqP9Ebnqe6D4qZjA+DpuL/NdHtcKbRQbqhO4TMI4s/yVBptJIAW+xE3jwUDFMKUz2SNsFw65/baqpta6RRJeg0mUY9InXnwEHyHRhqTbYXWYdHJfr/uZB4yOZ/UP53XZy87YG4MMqfoX5+9mZWUYpKRmHPIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717667216; c=relaxed/simple;
	bh=G4o6M0gDWKpKvqcTu0P9kQwwwwiLrDNCaoCsW4YkCnU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=anKk2rSXf1Cs6vGIHaMBD3dYC2RUstiXUpIFXkCUWs6jsdcfkmriNUjZEHzWP1jegzjI2UNuE1XkNgW+5NRjcwvYZe9sMgOqfxM4oTWYAt0pq5uZPMOdwwcCzVJIwJ276zZLjqUjw4oSpmenKtqUlhHZIs5huAFwzT5ZA/DsS3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4563rfjL012767;
	Thu, 6 Jun 2024 02:46:43 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3yfxwyvxx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 02:46:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQp9qrjSQGo1xEgE9JBwaoqZw1RIRRdUL4hqc65Scxs6nZDEmQE+bre++YI/XMqZKlP2ChvFjqoSrQy4ZlQtfeXiS9Btb1c4kw5aQvvVAkIE9mQpCmXe2RXqaifHqR7/jwhT1/rcrfsmi63TntEyvD3YTThKyrNPEKYeTjzE3m8qHSijUiZQJsDX6wtL9YrYqCzyJfTlg1D9nXlwbLoel4fpEsEW5VFqu7iJ7w4teFdjXJ3h/X+S8uHXrErA0vmv8cmHh8SAdWKSWGd0n1BLxcNKt/9on4182Om2YtFM1LKtvtGv/dwGcmA0u1/XIR6mBVxl6YZ0NjXSSLK//RaoEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ff5/c5n+BSyZyXjr9hmAfwZ+35i2iLMfaPVvUbq3/Cg=;
 b=oNwb4JX7DFCH1rmt5FHEwtxGBRc4SBoFFVuycvv6BJo/PAT8EBn060G2oq79eFgFBxIDopMp8r9Gg2hjLgOE1jaV81rXdpghf7WtUQidYQsVlLOkzelcsoZEvYETsDMciEmh7uxNMp2464704SODsL8AbQpeXqm4Rz+hiCMK6yu7e1rKeQNNvCwAfJ+vOQZk+VfidINiJUmPp6nVNHLgYBr9B9/NYgieVx+I9CnnBOIGKN7QSOzB1sOqqrSGZE+Hv+0Fi0ztV1fIdLAdUSa01rYMz+ptYjFe+fFaPE0fCKDZs4lECTVw16DEeJX5CkAtHodSTv8A53+zOS366XEYxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SA3PR11MB7527.namprd11.prod.outlook.com (2603:10b6:806:314::20)
 by MN2PR11MB4549.namprd11.prod.outlook.com (2603:10b6:208:26d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 09:46:39 +0000
Received: from SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538]) by SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538%7]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 09:46:38 +0000
From: He Zhe <zhe.he@windriver.com>
To: clemens@ladisch.de, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc: zhe.he@windriver.com
Subject: [PATCH v2] hpet: Support 32-bit userspace
Date: Thu,  6 Jun 2024 17:46:20 +0800
Message-Id: <20240606094620.3946453-1-zhe.he@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0010.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::13) To SA3PR11MB7527.namprd11.prod.outlook.com
 (2603:10b6:806:314::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB7527:EE_|MN2PR11MB4549:EE_
X-MS-Office365-Filtering-Correlation-Id: 7138e55e-7624-411b-94bd-08dc860d8f7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|52116005|376005|1800799015|366007|38350700005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?3IAz4+bwqDa5/w2Ml67oax2wUZOL/KSZuHoJ2/UbhDWn+cH4mtoMBizuVLH+?=
 =?us-ascii?Q?eJIWL0oqlQecZct08GPb7CAyyKuLIg6ilWM1kWQfzb2BlKVtGO8FeKnaGAh4?=
 =?us-ascii?Q?1zyfRfb6jfrzg+cpfEdk2XLsBsNLjKN0NiZzHx/C9vQKPhdX2uOMCmyfzoWz?=
 =?us-ascii?Q?kRVzN20W0De8qcZl7A1JW1B+aLvh666lIZbScI9vBqkO6seXMWsm3evxOllD?=
 =?us-ascii?Q?HsXscysfjAMYsYC1gBb4dWzUna1vZTCVe/pTqmN7eO/j/EPQwWDynXyWkUdQ?=
 =?us-ascii?Q?O1MYn4NYkD4et4mq0EO0uSbmWqNrzEh15JHsnLRD68iTqd4tYpV7a8EQnKcC?=
 =?us-ascii?Q?y21HmF46zU95TimApPnj1AZIAVCp139oWoATgRwhludaGaKUScRa+UzxRp4a?=
 =?us-ascii?Q?ifH5NhiWXMKPTRQ0jwYHnBzp/90OwkNGYbgenjXpPFn0Wg7JPGTR1Q47BLT9?=
 =?us-ascii?Q?S/1ERXtsSKNonodmd0+URYnsiAjhi+quyE3gcW1+/jsNQ+9CDwGF6JVgLzu/?=
 =?us-ascii?Q?alxVFsUiZtvW559Hby+DTx+XgLBoiunTdw+oggw4D5apz6B35rQIAC0TVDGI?=
 =?us-ascii?Q?VbQqVmXEB2gZJehl4PpL1BvhIP5+BmONuRBVNfiVQDEsOChxPgiO2Xl1JCCG?=
 =?us-ascii?Q?E8hKesr4nPuBfT06m/4y2TUM3/YSMBTbNlxnEn+C1Yu6+VTvgUBHqx0oHeW3?=
 =?us-ascii?Q?XbgYbKJOkxWTAgLoGdMrmqc1QM11/ajPnVIZbt4Q7cytcitAjBg1a/DvujNT?=
 =?us-ascii?Q?6lZJCiH9TUZ/QrDJI8ZvLef2vlincbRQT6VYd+dj+BnqszVdY97Wy2LDiWrh?=
 =?us-ascii?Q?4hoa7UTP7qu/METMJfCfi5LEbhPyUWhoSqV6wEF9hnmFDui8rjqwpWYEPB5g?=
 =?us-ascii?Q?n1+vMNclJBlQJNM58diKAwGYLjP8abgnT9cIok7mdSO2ukuDx+d5XnpHs6td?=
 =?us-ascii?Q?l5J2AWV6BwGE//lmdthQEah7fDVNJeEE62GrCczoJqjhij9d1dsRBr0DQyaN?=
 =?us-ascii?Q?MwqdhQ+2xWoWGQw+8WG6j5iBzJKIvAUvQ5kpIFEoV88HlZeQpBOTXvQXqlwI?=
 =?us-ascii?Q?xVYCZhjNnpCqdQNkzdxCfqxUsuIglQLqr2wqRN+6Mi9LelX19oqaOrNi8UbE?=
 =?us-ascii?Q?+vVQi5ULIvVYglyyGvYlF0MaHWU0IJ0z4IsVavzpCrCoxQZuwxwWtu6IWvhZ?=
 =?us-ascii?Q?TAfCJ5sU9DEAEJ9aoPaM7uuGeRA82MQJ2kEFW8E1hM0NB7YqItyQZje+nR4P?=
 =?us-ascii?Q?NTlJdaFhHi+seTdQBm+Rg1KUqSHroFBMIUaNWG/z4/3PSRN53qYHWv1ecZPl?=
 =?us-ascii?Q?wNXR0DjzN7Y450ii7PvXzPMSWJqkt84vdfrQvhX4LKmMu0p3mJ7cQ4ExNsIi?=
 =?us-ascii?Q?CR6aWWU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB7527.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fVXO39mSszHmTQtjKWbYEAZLeh71evcWG7XktXDZMA1ngJSndQ/H1YT4s8n1?=
 =?us-ascii?Q?U2HRMzhw6gHD3UFU6knN1HgebzRUo2TTGb2QkUXV4kJJ62ueDIUzBZfkjY20?=
 =?us-ascii?Q?RpVAn6SHGqQ6B4Wd9kZba2dSR0Z3VDqC2yYeMuZDNPkoT7VdpYOUghySK96s?=
 =?us-ascii?Q?PRd3J7oxEB+JtIOUMsqBdcrH1/4Ckx4kUVxENc06tswuTrP/2TKn3BKezCSi?=
 =?us-ascii?Q?WzuMHCaHPq8QVv5jewclo/ephEfQaLOL+OFBwD+dTku0JRnvQwV8wUaxlo7x?=
 =?us-ascii?Q?B/foKcjw5l8e9YqYhxsnj3CjLQaTuXsP1+WRU51YyyOOs9kAjGe68AYw4BI4?=
 =?us-ascii?Q?GO0yvaShJaLcniqVLWS/FXWz9BGA20aAHtfahP4qX6a53qaxQCeL9hKI6wmF?=
 =?us-ascii?Q?6ZEQ2WFd5oivqWgtX2ZtNHQYGG6H3qX5SBEBK+WoX3r7X4A5jLqbSjfgTkJf?=
 =?us-ascii?Q?18onr/FoB+n4LgzTb7HH8DVYkqk/rIIXq/V0/RiMvqpG8D2S2Iu9XMy7bHn9?=
 =?us-ascii?Q?oQs5+KeZHDCDtqIsEJMOw2CXMnYB3bU/PnXL3jHqrje7NfUXvlVJf6PlBNju?=
 =?us-ascii?Q?IOkcPLPFK9H2OeQlBX1rLg8NhFQZObNBBbd/3hNocKzWuz2iQlJQAUabpY3D?=
 =?us-ascii?Q?x6NmPLd+V9wtCeVto+XXu0sMSBxYAthQt8gCN4LjOd2fjpNLHDM1zzFkgNwq?=
 =?us-ascii?Q?0Gukplh0+G39yawK5EQQOOuU1JgW91E2wYn/gfF1kFSrA81P471YjeDNbH9H?=
 =?us-ascii?Q?UhwpzOu1YNXkkOC2/+IVVbIXhWNNOmrn4RebKmSPWVQ78XFtArZXs8knVZK6?=
 =?us-ascii?Q?FD2cvAs+mbim/ZQztva0ySo1GQ2/UfMS9kvvcoIUKKiFOWqtK43jhcqD6t7z?=
 =?us-ascii?Q?afV2GIDK6zuL3+XqjTGFOuITIVa6IYYyMswAO9pG7bdPJPPffM10dHnlOGSP?=
 =?us-ascii?Q?eNmqG6+2QUDKNnMh8C99Y4vTOH8vVCTvKf9QX05+ku9seulzPKB6ALiFWk+f?=
 =?us-ascii?Q?SFiTzXVgpgzkraBZ70yIZd397KKfd1l8hRgngAMf+y4N9QSTyf3A6GWw+eQb?=
 =?us-ascii?Q?My7ehXhguNgX0Skq0eda4kQmJeHG7/TRyKb0+nqdTZD18SNNy/d3Y99eAlPr?=
 =?us-ascii?Q?2qD08EIwTscmhrjivXSE+Q+OWJy7OVtyK/eba0xDIfzWChJEMJ5lG4YyU1LO?=
 =?us-ascii?Q?8RLL5uCW+dmYYMfdo03sqxhnEnHK8kn7cj1JDo3H0KqRBmvVww6jl8golqp2?=
 =?us-ascii?Q?rHJ/SHNuSLAuOur6kKMUqzIPnyPtbHRrt/vPiL28u3vVeCfS9u46a3k/cCIn?=
 =?us-ascii?Q?PWreQkeX1vy1b9pFK2xwwPPuF1vLy8Q/eYIBusCH9TXR4lAwJ2lvrWHBIGqR?=
 =?us-ascii?Q?SGqUBJamQY9ciYgJPZ0XsBHfs1rwex8oqXEtk4fTjFPU7inKZi9fQRJ0D2II?=
 =?us-ascii?Q?RsEVG7Fyo6v9ahdPlFomR5HOFbc9XkhBLJYyRVlqTpWsriW5hkMAlcuH0DzY?=
 =?us-ascii?Q?kmypzm27b8GhcUHu7Rt4CB7vg6mEiZTh8oSX6GShEpyNC8yKkGUo+cMVZiCJ?=
 =?us-ascii?Q?uvHZ5sE3IrWw/xKQRFLYtZ0Bz6yipg9TOccdmXaV?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7138e55e-7624-411b-94bd-08dc860d8f7b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 09:46:38.1546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNSm4vfNBkodQ/uawFxo7GJHMeXUi4rDEO/EITh+Ie/xfO07foPC1uWALDSVRLeq7wJOrLvhRg4j1cTmHbWd5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4549
X-Proofpoint-GUID: dMO-a9S5C_TfNgni6obT2uyOg2NZU5zg
X-Proofpoint-ORIG-GUID: dMO-a9S5C_TfNgni6obT2uyOg2NZU5zg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 clxscore=1015 adultscore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2405170001 definitions=main-2406060071

hpet_compat_ioctl and read file operations failed to handle parameters from
32-bit userspace and thus samples/timers/hpet_example.c fails as below.

root@intel-x86-64:~# ./hpet_example-32.out poll /dev/hpet 1 2
-hpet: executing poll
hpet_poll: HPET_IRQFREQ failed

This patch fixes cmd and arg handling in hpet_compat_ioctl and adds compat
handling for 32-bit userspace in hpet_read.

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
v2:
- Use in_compat_syscall to determine if we're handling 32-bit or 64-bit
- Drop unnecessary compat_ptr for hpet_ioctl_common
- Add comment for COMPAT_HPET_INFO and COMPAT_HPET_IRQFREQ

 drivers/char/hpet.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index d51fc8321d41..4eef4e926d4a 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -269,8 +269,18 @@ hpet_read(struct file *file, char __user *buf, size_t count, loff_t * ppos)
 	if (!devp->hd_ireqfreq)
 		return -EIO;
 
+#ifdef CONFIG_COMPAT
+	if (in_compat_syscall()) {
+		if (count < sizeof(compat_ulong_t))
+			return -EINVAL;
+	} else {
+		if (count < sizeof(unsigned long))
+			return -EINVAL;
+	}
+#else
 	if (count < sizeof(unsigned long))
 		return -EINVAL;
+#endif
 
 	add_wait_queue(&devp->hd_waitqueue, &wait);
 
@@ -294,9 +304,22 @@ hpet_read(struct file *file, char __user *buf, size_t count, loff_t * ppos)
 		schedule();
 	}
 
+#ifdef CONFIG_COMPAT
+	if (in_compat_syscall()) {
+		retval = put_user(data, (compat_ulong_t __user *)buf);
+		if (!retval)
+			retval = sizeof(compat_ulong_t);
+	} else {
+		retval = put_user(data, (unsigned long __user *)buf);
+		if (!retval)
+			retval = sizeof(unsigned long);
+	}
+#else
 	retval = put_user(data, (unsigned long __user *)buf);
 	if (!retval)
 		retval = sizeof(unsigned long);
+#endif
+
 out:
 	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(&devp->hd_waitqueue, &wait);
@@ -651,12 +674,24 @@ struct compat_hpet_info {
 	unsigned short hi_timer;
 };
 
+/* 32-bit types would lead to different command codes which should be
+ * translated into 64-bit ones before passed to hpet_ioctl_common
+ */
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
 	err = hpet_ioctl_common(file->private_data, cmd, arg, &info);
 	mutex_unlock(&hpet_mutex);
-- 
2.25.1


