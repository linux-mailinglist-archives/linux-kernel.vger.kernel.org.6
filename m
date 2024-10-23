Return-Path: <linux-kernel+bounces-378806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B9A9AD5A4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 360411C22170
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FA61FB3E8;
	Wed, 23 Oct 2024 20:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hAFSTcir";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0DZ0wkn6"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096DD1F9432
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 20:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715962; cv=fail; b=qOP99vK7qTvwGvcrrJc0HBLM7Ufzw1j++sJspdwXtqX66vdWostscu5uWyC0lnNSgcrgfI+nTvGB7d4NWP/E7zPj8yCVdAPbZ8//lYA6v/6QqcXA4f5J88z95Sjz/NZqttTYH2sUh9jKa+x7W7x2yp8hyiljnQnRDT5ZLRdTcnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715962; c=relaxed/simple;
	bh=AxS50HEFoaGKIBrw8l/jhmM+v0+UIkXrTa1Olihoogc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fiKjTDdkfWB2Z85D3mjEMx2qc2ldZVfnhjH9sydTAUdOqbTh9OC9U0Dn6wub4/GYvaE/Zxkqk5PboGQPWL8wjg2aAXB3C97jpK6dRuMHAG94JGjk5rhEH/B37oDSXFncJ2GkmWBoSAn+OUWddN8cRA2edOUwLICgVCJyOMyHQBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hAFSTcir; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0DZ0wkn6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NKcTV1010295;
	Wed, 23 Oct 2024 20:39:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=WP57i7v+tW2ioFRTEIKKj1mu6dNHF0V1UcxvMSTIrXU=; b=
	hAFSTcir4XzhAtoaNGmWtT4iaKFWY5VrW4VhiHZ84g/5KhGDqOQUxBg1EK4Y/UeD
	551e/XoDioC6vlHfoQtGhVE41c1srMLwIdowU2Szhe0/f5YX3aNKScdQ3SHXJruN
	/ey33TbtHz2fEdg52vNUd2b3BuW5O/3H+ErH+kUd/+APP38ccEh9zIZIE0kps2tI
	aXKYkLA13dDGaqE0GSu0YLSMLSgsmP4OV0cTyFpYxY2aBz/kJ9K/GI5y1u2MEmT2
	SJ1YE9LF0pJixfsYDuBZcm8XPH9mBUQXi90P+szGDuYti6hXNe9OZ0BD+CNK2rXY
	erSDFhHKS1QIHmrf7uFlhA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42cqv3g8w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 20:39:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NJEEmp027438;
	Wed, 23 Oct 2024 20:39:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emh3bk7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 20:39:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=naBVmz/G/DX+Vz902PvbV1U+beSEKgfmGYxZs3mESRePJsVIBAV1nopw3Ncwc+NNav6I0H5CkZcu8FnUw3EiftMKkv4Wm1RTHtXDeSFFYAl/Eu4e4Sp/SqrPIQW6jQUEs7/XrGVBSMkPtOOWII5rlonS791Rp5TIGoU7Iv0X30czkCFZcv6bhT9TK7ZMLqJ1RVD/365Q1Mv5rgET3COR6EFA+arXEkbrOcvA2t294kQ8rk6ueEilgxjdYGsaJfBxjNTG6h96ZL+hFZcNPA7C3T5B8+U/xZmRfrFXk2yA1n5YrGBfKPcO1Wk16NnxHsj2a/BbCIjA+Azgj0hcMIa/Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WP57i7v+tW2ioFRTEIKKj1mu6dNHF0V1UcxvMSTIrXU=;
 b=cZnHEw/ZjEdN/5c8o98g3+K0LIRzZf4Z1T8UnBHePNEs9jxWgNwU4qIvYYerjswG00D6HJgPBt/TM4ibdArJTTgCTxc9iNPPP1csOYuOtQ+ICm4IBE0cho4b490nZQ5R3tMImecQiYdr26UbMWJMZ0QKYs4FI2YAGYpkKk4AdMJoGwolTngZBojJQRnTnP49P9U9e2zF18JHMyi93UVcyVH0mnYFX0TC62X0doL/G4W40D7QxlAKuz+OglOlJhJw4Cblcw8Qdj/a1oJvAax9xwMqNDIWMhWrxahtPRfqn/u22O+j72wDWf8NR7tQmJofvSRRn+w/3+MNcM0a4/5WxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WP57i7v+tW2ioFRTEIKKj1mu6dNHF0V1UcxvMSTIrXU=;
 b=0DZ0wkn6jxXqp0MDI9dIyUXvpnC8ssyevmYVAkJJOU5tW5x7fXYFW54X9RmiL6TCYmo0Ej9BaYJtbjpQUSFHLBU9T1UJbCr3oyVHn5r0wQfGlQ3FNa1UK2Op/jPOhHDVHJQ9Go9zoLkQC/e68Uw3IbgBS98SnS1RSpnZCE/THJk=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB5833.namprd10.prod.outlook.com (2603:10b6:a03:3ed::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 20:39:07 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 20:39:07 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 5/8] tools: testing: add additional vma_internal.h stubs
Date: Wed, 23 Oct 2024 21:38:30 +0100
Message-ID: <4eddd714a8d6dfb052032dfda5aa28d9f4bd134a.1729715266.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729715266.git.lorenzo.stoakes@oracle.com>
References: <cover.1729715266.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO0P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::19) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB5833:EE_
X-MS-Office365-Filtering-Correlation-Id: e7539a0c-afad-49dd-a908-08dcf3a2bd80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j5OZBnSH9TEJb/SI+ZMzI4ApzF/7cYxZWsbkqOh5Ey3MxSUiRZCf7HT5vab/?=
 =?us-ascii?Q?VrdhpcG7eH3X5xTLZQxK06D2AIyqm60V/jLgmAdoiZHdQoFnrB/gtMWZR0tQ?=
 =?us-ascii?Q?6SF88DJNNqzY5ZEQ8LJLTpLLVF0LkFdJLcy+Mw6cjCwsQqnEP9L3MsxilVuV?=
 =?us-ascii?Q?uDHrUQSmOEDyC7d2kE8SVt11cH8sA8EG/VLTMCuXECiAQov1sRyEY5zcsK50?=
 =?us-ascii?Q?Jb+n69CPybDgXQspCDzu6uaj7W+T9ryV/T0PaB9thZe/TaQ3bItA12hrpcK4?=
 =?us-ascii?Q?xYYGoDZwTqnS25LRsU+xQ/yVr7INAdC94RW1ACtzZESxDSq4EP9mUwVzM+kH?=
 =?us-ascii?Q?pYrILrNn+6G6yX273g2z2LRKyElQDgVqV32yojQB9W+aWRgAv6cniiaM98up?=
 =?us-ascii?Q?Lo+bYtAjnl38ip4rXCYznwnRVLUJCgkOntComVXH2gLSTZSBE8VEVp7v7UUa?=
 =?us-ascii?Q?xVYCum0ho6zQS7z3RQgpJvGtzmHf7bkdLeh2FxyONFlZ3wICkKhoIZVeKjrH?=
 =?us-ascii?Q?WEHQIXaApwQ7TROezZxfMN78xJBIJ/47cSutVtgkGB9gIX4inIL1l+YMWvql?=
 =?us-ascii?Q?EIW0ns+4rzD1ba61lDgrub2/kUpiDnmo8yEMxx0DWFT4WLrDIyFj8td5GHp7?=
 =?us-ascii?Q?PMtJb1pteByVPzb5AxogVkc+OkDse1uMkfuD3I3MovbJVOaSUImc0PkcP6kM?=
 =?us-ascii?Q?QkXx/bgtsS6fyeol4bVaLUW3BZgmeR9CGl9vg2GsdLqZyFtKAGWZU6w55EA5?=
 =?us-ascii?Q?YdsMqU3CJagzIxSZCFWImaRrBSXwN1WgZplwVa7y3gxuVHwJRa7dFPrZviES?=
 =?us-ascii?Q?GKZjWDSQUbMh5DU4w01bjg6UMIXBxMNsSLVTiBQw6C1A4sPeOdKKJUNB6qDQ?=
 =?us-ascii?Q?onS44Od/aMvXbCfQaOLVORmAfPwPmYqJ1pCViwAq+E7CYyeo+dAmR+Iz5uj3?=
 =?us-ascii?Q?v3THbys0TCD6/A2X0snhgyfIq98asgBixMZliVyZBa1tpgKd2LW9JIP1JgmT?=
 =?us-ascii?Q?fpevb4/NFhbxtJEZ9MCsBrqpweIoOG5hk9AWKEuWFxb9YcoVGAsiMtNRU7bu?=
 =?us-ascii?Q?AwsITgYZzqLDetVsmk/x3HjUKlSt4a0dHS93aCrRnNPSwqgVNo6yZJqFSoEW?=
 =?us-ascii?Q?29/ARHIbEGdi0YJizkOZDGxspLLAAJOEXnvpRO+g8b4E2/Aw13NXTZ5vLkWj?=
 =?us-ascii?Q?5VJZtwEKr2Ax9AiT1T9Dx4OPRsT5rncsr8OhqagPl8zPUWrFTPRfquAAZGns?=
 =?us-ascii?Q?6u8Qd83P+zNg4txVPEvmzBTpyS8YhaHrfrKLDS6KpGofync/OiDJDCnhybgp?=
 =?us-ascii?Q?0Q4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m9BI3ITDfDXmGd2Fk8MP08qk8v7pYbir3BFFH/BUMakbTwBv229isnJ3RgdI?=
 =?us-ascii?Q?GEcqZIM0Nf9BIocM1mlDt6gyGpcukkwGspuefGQD9reDeqCaz0Hk1s02NVYI?=
 =?us-ascii?Q?RfjEfmhQF7NE8Q+BemvSsjZZffeLfK6U7PlwiGeCaU0vCSfsDhArA81N2qlU?=
 =?us-ascii?Q?hHTEeOstbceild51mShInKrPD/FMr0RY5W9VGvol58ErpeZABzLfXg7R4F2S?=
 =?us-ascii?Q?OVV3nH2Lmqk4kufnUKjYj+IwAQi+RJcgoP6hrQ36inF4Bfxqgilu8QZkeH6p?=
 =?us-ascii?Q?bqA7rKUL1fgNHPiWTnpGIAI4gMrNk6KWShjywTDowC/+LQW+FHgke0h/t3E3?=
 =?us-ascii?Q?r9Eur26T+zFeZ3xnlLzB3l9JKrF/27Au+mGx5rrvolqxhS4mHiwou1mEl+kh?=
 =?us-ascii?Q?HlbCjy8XIiYh8IkKBHrw1dMbqJ1wKfz9t3I5o7s+sfj0MEro2KBzi8LUTwGO?=
 =?us-ascii?Q?Q3qQnqP3GBqYjzn/jjzJ6mjQAh5C63K1J7v6imG6PPWWdaP7CPnuaeB3EmjJ?=
 =?us-ascii?Q?PJpCln+bBLBtk/I7VS5ojFHTRIUaJmjuJoX+P8nJa9kZSSVMOiviRpkHFHzW?=
 =?us-ascii?Q?waoGi3i49LPXbBnmZxYbjE0mTjgoYplF1P9TOu0wd3EuMG7+BcrlRidxoqYJ?=
 =?us-ascii?Q?BKttjrctc6Vt6mBN4DpAHmHxjCTKkV1EEAjelFucrtjfFnIdUOjnSmluhPEi?=
 =?us-ascii?Q?k+rqqxfU8owhM68pFbTPkEr1pbC67oAdMQhTHuxrKe4R0q6Z09rgJnfv9kbC?=
 =?us-ascii?Q?Z2dYZLdDIBgO+b1RiujK/5dCI0sH1iCc5dFn0k6U7uti7QUeHa5AitpbRwWN?=
 =?us-ascii?Q?VrXuPrCfQj5TEvcyQQM53KYlXabZr48o0ydmcPRewTBP+2ybbPvqCcoioGSV?=
 =?us-ascii?Q?9kMflfXwQUb6mxehZLHkBA5waR6LPRfq5ArCYJoWqttFY+8gZ+RBxLU2F1Bh?=
 =?us-ascii?Q?mq490EVU1UjWoarNC+6Uocyk80shP1XMUwHbimRGsAIMfZuNLe2cyWMbCQAv?=
 =?us-ascii?Q?HW9v0WFzfHQumabkMM+tA3ykUBFXH7jY1AV+qz7mG6KynctstxHMdfQIlSgX?=
 =?us-ascii?Q?I+TsfGCaK06X+zRQkazkbviKR0ZA3hI+PB4WUIFe6pUtM28aJF6mpMxt56wb?=
 =?us-ascii?Q?6s6AP3hSEDwfIbvwjMeHia8V6PLlaK0sZ55tPw1pO1tGHd7zHsBNE+hjDWKY?=
 =?us-ascii?Q?yd06x5aMg6EbUjXy58fpv8ltUO+2ZFFapqy1KEOL18yqSZbrCwPOvUsF1uTk?=
 =?us-ascii?Q?lIpcI4w/RpU0Kgkx2vfdaSn6QicokBTr6QvIm2RtCcrEFEGJGg7mGheKursc?=
 =?us-ascii?Q?OwImcDLAto7GSk2ns+Zr5A9ucuI3YjsoS0PuIetdpc+j+sSm32n4KqTc1mj6?=
 =?us-ascii?Q?u/yogNTg+YUaE0q1tpdGao2o+QM0IZZYEi0Mvb+ZRF6IZo48XCZGMI9twPcl?=
 =?us-ascii?Q?IflXc7YxFfb14zgpo7R8Bj1ouNbnYgnX7lltedHxrG8yQ2hn+ncp8fXrxoFG?=
 =?us-ascii?Q?QNfqvTZqMk5oRPoPgIZUvTbdpUGrGRMAlW5vp7nRbWkRGTnPxlcE+u3wTALn?=
 =?us-ascii?Q?sNYtdycWuD70adtlDh0lB7kysA22glWXgb0ThdDQHNPmLOByTr6OTghrwe6j?=
 =?us-ascii?Q?mAdvVRXUpSKHkVTfHkFzMsbV+jCEq7kQp6JMGEZM1x2ZXG9jY4P/fCLIWbkO?=
 =?us-ascii?Q?rfWntA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9H9kWvGOKyr1Ok9lcTYt19AvDMwNGXtE3Swbq8c2NTt3cEyNiEJ/rzo7hWRfYeYJN6E0cMIhEWknVs4Tvkwr5IjAgKu5Ges0ZnNLtAIBx4Ca0iwb+8y6RpegtclOrv22ll5OttAFP0FwArruSC9z8v1SdfhQfrEaQ5RQLDsMT05cbGuPGp8Y61zwqaUvOzURIw1lJFaxaAWqOw7YfqKqsHOjgHnLw0F8MJJCGekvG/BRV3GH35FYDbNR2Uj+cuH7yL46wZURS0bvEwc7YBp0weZ4u892k95ULVI3kKdwaCdgRwWrdO2kextRO0QyqmB523D/yvY5f5uLTiOYaT4J7E4QpR685d2R2SAR97uTDJfjPlhOdxL93L+q6AwK6qRDgbjunHM2/24B00TdZTCZBrmn5y+eGGwCV3yxzUR01DM0CyFRiZsKR/HTvxa4TweyMqJbqOHW6sWoPpgc0xS+pvyzFF/aTarzYreCIdQmzXHKeTLmL/ibg1rMFbxNb9vJ3YFbuXqalMXN5iTKiPkUBcLUS6upgvmbWxEptwbd7l3poybhLh+TxV6ACdcM9E+MKL8uzrQKJzwzPUlOZ1/llkJDvmgg/hl7WHKxKBHKISY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7539a0c-afad-49dd-a908-08dcf3a2bd80
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 20:39:07.1473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ImhGGEXLaUoogCJwlHqfecr6wyRW0PbNhX+89ZQN69en0LH9bAqZTiDC6kOTFuGxgF5zhMM97NeipCraKRRkurD8rY+Los0VEoj3KWEUoHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_16,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230132
X-Proofpoint-ORIG-GUID: MrrK6r_56xooXujw_gIF9lXeizzJIn5J
X-Proofpoint-GUID: MrrK6r_56xooXujw_gIF9lXeizzJIn5J

Add some additional vma_internal.h stubs in preparation for __mmap_region()
being moved to mm/vma.c. Without these the move would result in the tests
no longer compiling.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/vma/vma_internal.h | 115 ++++++++++++++++++++++++++++++-
 1 file changed, 114 insertions(+), 1 deletion(-)

diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index c5b9da034511..77eba27365a2 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -44,7 +44,9 @@
 #define VM_LOCKED	0x00002000
 #define VM_IO           0x00004000
 #define VM_DONTEXPAND	0x00040000
+#define VM_LOCKONFAULT	0x00080000
 #define VM_ACCOUNT	0x00100000
+#define VM_NORESERVE	0x00200000
 #define VM_MIXEDMAP	0x10000000
 #define VM_STACK	VM_GROWSDOWN
 #define VM_SHADOW_STACK	VM_NONE
@@ -53,6 +55,14 @@
 #define VM_ACCESS_FLAGS (VM_READ | VM_WRITE | VM_EXEC)
 #define VM_SPECIAL (VM_IO | VM_DONTEXPAND | VM_PFNMAP | VM_MIXEDMAP)

+/* This mask represents all the VMA flag bits used by mlock */
+#define VM_LOCKED_MASK	(VM_LOCKED | VM_LOCKONFAULT)
+
+#ifdef CONFIG_64BIT
+/* VM is sealed, in vm_flags */
+#define VM_SEALED	_BITUL(63)
+#endif
+
 #define FIRST_USER_ADDRESS	0UL
 #define USER_PGTABLES_CEILING	0UL

@@ -698,8 +708,9 @@ static inline void tlb_finish_mmu(struct mmu_gather *)
 {
 }

-static inline void get_file(struct file *)
+static inline struct file *get_file(struct file *f)
 {
+	return f;
 }

 static inline int vma_dup_policy(struct vm_area_struct *, struct vm_area_struct *)
@@ -920,4 +931,106 @@ static inline bool signal_pending(void *)
 	return false;
 }

+static inline bool is_file_hugepages(struct file *)
+{
+	return false;
+}
+
+static inline int security_vm_enough_memory_mm(struct mm_struct *, long)
+{
+	return true;
+}
+
+static inline bool may_expand_vm(struct mm_struct *, vm_flags_t, unsigned long)
+{
+	return true;
+}
+
+static inline void vm_flags_init(struct vm_area_struct *vma,
+				 vm_flags_t flags)
+{
+	vma->__vm_flags = flags;
+}
+
+static inline void vm_flags_set(struct vm_area_struct *vma,
+				vm_flags_t flags)
+{
+	vma_start_write(vma);
+	vma->__vm_flags |= flags;
+}
+
+static inline void vm_flags_clear(struct vm_area_struct *vma,
+				  vm_flags_t flags)
+{
+	vma_start_write(vma);
+	vma->__vm_flags &= ~flags;
+}
+
+static inline int call_mmap(struct file *, struct vm_area_struct *)
+{
+	return 0;
+}
+
+static inline int shmem_zero_setup(struct vm_area_struct *)
+{
+	return 0;
+}
+
+static inline void vma_set_anonymous(struct vm_area_struct *vma)
+{
+	vma->vm_ops = NULL;
+}
+
+static inline void ksm_add_vma(struct vm_area_struct *)
+{
+}
+
+static inline void perf_event_mmap(struct vm_area_struct *)
+{
+}
+
+static inline bool vma_is_dax(struct vm_area_struct *)
+{
+	return false;
+}
+
+static inline struct vm_area_struct *get_gate_vma(struct mm_struct *)
+{
+	return NULL;
+}
+
+bool vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot);
+
+/* Update vma->vm_page_prot to reflect vma->vm_flags. */
+static inline void vma_set_page_prot(struct vm_area_struct *vma)
+{
+	unsigned long vm_flags = vma->vm_flags;
+	pgprot_t vm_page_prot;
+
+	/* testing: we inline vm_pgprot_modify() to avoid clash with vma.h. */
+	vm_page_prot = pgprot_modify(vma->vm_page_prot, vm_get_page_prot(vm_flags));
+
+	if (vma_wants_writenotify(vma, vm_page_prot)) {
+		vm_flags &= ~VM_SHARED;
+		/* testing: we inline vm_pgprot_modify() to avoid clash with vma.h. */
+		vm_page_prot = pgprot_modify(vm_page_prot, vm_get_page_prot(vm_flags));
+	}
+	/* remove_protection_ptes reads vma->vm_page_prot without mmap_lock */
+	WRITE_ONCE(vma->vm_page_prot, vm_page_prot);
+}
+
+static inline bool arch_validate_flags(unsigned long)
+{
+	return true;
+}
+
+static inline void vma_close(struct vm_area_struct *)
+{
+}
+
+static inline int mmap_file(struct file *, struct vm_area_struct *)
+{
+	return 0;
+}
+
 #endif	/* __MM_VMA_INTERNAL_H */
--
2.47.0

