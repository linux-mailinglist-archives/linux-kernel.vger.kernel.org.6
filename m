Return-Path: <linux-kernel+bounces-255630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC6B934300
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CEA5B220AE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DC019047E;
	Wed, 17 Jul 2024 20:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GLOGm+kS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="S/LT+9rU"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2CE191F92
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 20:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721246892; cv=fail; b=VtYxRS6nlc3Cwx/JqSVm4rrHmfx0JFw0/XUT3xTLU3cCz2HvR8Cwgwta8KpFQpEVPq2Hj2sULuswJs7kjJq0fuIHj0l8W1G5/ihiYh62Db+mI5LrZDCLWpSB/sF8bGpEgM5u0OI9LoyiVaM6xPng08I7kB6scyJEBnV6y5gFx/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721246892; c=relaxed/simple;
	bh=soi3+q14YkcEnpDaJGQdtoh+LS2uxS9UQ/SNG56UKTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LsEomizpaO5Qu22AeMqmGVTQ8tpO5iYlBuooqzEPUAeWokna07YpcU3FE9FpUBnynzDpOJd0L2JMp0mxheqJmMQ8vc3Ed+jPQYExXUJBDtgkSVjtOPj1xCKdpZhY/KC/h4vIrucoaOSTsV2QyoVyWHjNQX5CMS2Xl+E/97LEPOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GLOGm+kS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=S/LT+9rU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HK0l05029078;
	Wed, 17 Jul 2024 20:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=alInpUkHwx1KRSQLZZxXfT1SsoSWLZXvIxTDx6NvE60=; b=
	GLOGm+kSe5xHMd3+JFkSs+s9NYkB7jcSZraM9bl8vbkLTtZfZQN7fIaNgni8pOr0
	r/q0vHyk2DiDeqnup3zhhpQt7z3pTUvhGu43Lh9a/td3WPKCJb4P8QOA4+n37QXH
	UaKYwAqQPlruswgpH/t8FA9FTHyGesJZVTAMQNIqFOxfUW4F+21jF0hAJ8N7AhO6
	g5/VQzrSZf+6n0xmVShg0kP1tHVtAtv2zNTR7OzW7ry4lrRXNLOhbN5Vf2koo2NV
	2ZsilOM8QCNJrXgNQFnCfXhiBpWYoZ1NpjHEvMLEYgsratD/qr/6b8n+cSYZCt1n
	zXOky597WqyWCEU4878uHA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40emkyg1ab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:07:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46HJ4sqE003630;
	Wed, 17 Jul 2024 20:07:55 GMT
Received: from outbound.mail.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40dweyhkte-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:07:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GWSwpNNt8hYYkaPQPYySEA6Wx05kYZK1KHCvWH/cy1lEJ1fhEbQFPfrOoaqri7bABpZPk6FISCALK0572SAtagjPOrlP1LIs1++EM7lp2hHNUM5UtHA84F76Sc14yk6zoP8JILlzXBLkuaRzk7p7qyAwUYdpv175VWayWsbkRmD8RrmEy+SsIyQDPGwDu9CnrFQsGtK7wxL0CLqsfGjJSILXvuQNY9dbZaNRe+KeEmr33MhLTrTskU3MhR1E5wgnTAQdR3wctqPtcBMbWJd8FXhqr+95NePTFLRL938bu0qcyS/T1kaFVobbCoyPd3/aWMyJvs7TcEZ+bAA9T9JePA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alInpUkHwx1KRSQLZZxXfT1SsoSWLZXvIxTDx6NvE60=;
 b=eMsRC4yXab868fs5LVJdMHUYsjTONmHJjUHCiPpHzxzgMWBexMUFq013lKhC4CzGQgh0ReB71DZbjJ0pW6PQMrbmSatSR84jM6vuhy2J3i/0Mn0GWifHmwdRS1y7Yzjc3p21TuI6uuyNJ40+8hdl9o30VjpgIPYlN93iQeKkdSdMi0nfi5Ehl54FyU05zE0GMngkdkew+NfV6CiT6c+Bp1K/SfvbnYN7TkOvaMKoywNPZMymxD/Im7kUN3FtZGGS05+bQmore567AtToz1o7Rv7laTFrx6njCuOAf/Rkw9kYYMXOE9zSwd4gOzEtk+oxBfYHEtvBzRzNFIFNTX5H3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alInpUkHwx1KRSQLZZxXfT1SsoSWLZXvIxTDx6NvE60=;
 b=S/LT+9rU3+vdTLZ0xZ0dSkcl5ULbi/c1Gy1l0Bm1sbtZbLRzh42phEJbmnSMtln7PFnbPc03H18/MUtf+/OLZNfkusyjr9TnK/vKjb6S5kfW2qUYt1SqFenI0nLnqQIhsJXsws9FrrvnxS0RrnUs6tuqG9WWK10ytEWu70/g5Ik=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH7PR10MB7694.namprd10.prod.outlook.com (2603:10b6:510:2e5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15; Wed, 17 Jul
 2024 20:07:52 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 20:07:52 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v5 18/21] mm/mmap: Move can_modify_mm() check down the stack
Date: Wed, 17 Jul 2024 16:07:06 -0400
Message-ID: <20240717200709.1552558-19-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
References: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0173.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::14) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH7PR10MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: c3c92b67-8c43-450d-5433-08dca69c23bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?KlTHHrTq4JCijQKufpxcTlZYryu7vlg8Q0TBMX0Pd/k/1q0/7pCgK7LNpmJG?=
 =?us-ascii?Q?hcpDgK7RRkQzrLtPFyW54e7+bP6ERZCROUZRU7ZrwQNRMr9p/uxCPnVP93Ii?=
 =?us-ascii?Q?Ja5CANrT5SQ93G53tw0+F510NGTPg4xJ3OwYSpE/d75fvOKZ6fUHwGd62DxZ?=
 =?us-ascii?Q?xlapY5W6QbqJYfD5QtS+4Sy1qTclV0FbvHtpv+U4ayd+5BNCssTwUz8KE5oB?=
 =?us-ascii?Q?Pq12jpnXA7x7HfPdjwp7s037OGmliT6bNT8wd+Jr5xGhrVNQ2Pe/MyqSkHqc?=
 =?us-ascii?Q?lm6IC7wbmxDm/Q6lzxR+FpjAqcGJ7JX6hKJZn6fw3H//m00nV2VdlsnrEBLH?=
 =?us-ascii?Q?E7yaGWZLVlpmMLZf0mgAr1ZOE5gPGElaBA+X0A89mvrXixkk18tkuvByJM9g?=
 =?us-ascii?Q?H5SD3FFiNUdhG1JaiIKo8kB86NRq9QtBe3ynocpUMjiqkrKGXnDpqiX01hEV?=
 =?us-ascii?Q?b3R402HOIl4j7CKDpxStbqvO6Lfdo8co6DnCR7Zcyldd3acXzZpA18HGCtvc?=
 =?us-ascii?Q?UuHF/Uj7dt8Q5T85nSFVQg0hlTNfFrUaDnSCNsre1mNtKYdmg3UHA2d+1iZH?=
 =?us-ascii?Q?ZGBSxX9MOfH7hnldcHbpKH3XTrSh9SlJhCdeai+8rwJuDxM0fZNNubHN40w1?=
 =?us-ascii?Q?/vo0KIouIKvx+aCP12QwVm51k8JuiWNpj59jtCesbrHgoD2iTTqNCdQwbElI?=
 =?us-ascii?Q?3CDbv/GfrVz5DCZue2PB9QfdcJ+qbOY91Aj0Y13zNGuA5yC2vbTpEUnOe7j8?=
 =?us-ascii?Q?BP5dAoKVeSuLblfklCI2b2Ps2yWwJxOtdRiVJ9zlx3lQs9SxhE4Eje9+qERB?=
 =?us-ascii?Q?jMOEuy0FUnd4+wZSCWJa4gNeE5d2lXLF3+FKKXJMsJ9Y7YSjfZPyQYbwXL8J?=
 =?us-ascii?Q?Cu/l6JK2VFtum/6fj4yHgHZf5nqL/uHxXPxIE81WhYrUI9XIGTuXSEFBBg1D?=
 =?us-ascii?Q?0t35GAaoVsfxmK84evTCcYgv+5EritSnmyRnqvzsrtdfeMW9FN2NHnEFLXM+?=
 =?us-ascii?Q?ZsBbaQNg5Ha3/eVCVLmch0AE4vploawEQFTee4ow1TFOw1pAqVMy6KhLo+Xo?=
 =?us-ascii?Q?ySSbM3vVvUpUIqjA0Jr7GMZzdIgR0rUc+5iHH0PVQEaC18P15kumJuDk2yY9?=
 =?us-ascii?Q?/zOMSqOFiBFl6tjik6tfHTEPvxcMXc2LGz3KqKji/gToGauih/cqwkHITc9i?=
 =?us-ascii?Q?88fDjDIg2pPVvzPovlo0KB/DqmbjAxdae8OrfSgHygL4XhqcOamkytlNkclU?=
 =?us-ascii?Q?Ekvm+hESxuGUbkf/ATzsv0AZ2Wgi+piJMXswdoqAhwGPYHnrQtrmD7HNwQ5s?=
 =?us-ascii?Q?kuMRDBYhUBN637rakxrRAII7znuvuqN9FLF0QLtXzMz+cg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Kf9hry9eqkKKPG/VEBvMHSurQK+d2qnpO343TBLKrsKaJAvoBc6UQPVPmBsi?=
 =?us-ascii?Q?FFHBnZCoAhdX+scXP93D9EKva1awFNwn9xBagwpPq6e3IgITw/5qhivP19KJ?=
 =?us-ascii?Q?YOrLJOBwXlggdVZrPbMi1jGmKSFA9ToB3asMhADaaVgVmbfzB3WK6LqegYQm?=
 =?us-ascii?Q?ftGtXrR8JHi2LmGlVXRkeKeFue3RIOboLJPpufdShk5Adl7RWQGKfdL0XCeB?=
 =?us-ascii?Q?mIaSxOXBmTj2q6WoVzWZtv47C3cJNM/zqTlsfXU54b4ra0NrrPGERNNcXtyG?=
 =?us-ascii?Q?bHH7mmJ12VKbyaVrfVK8Y5JGClee8pH7T8ppoWGHyUF/1T64KJ76Czv/5b/J?=
 =?us-ascii?Q?w6k/o1GklYYCqnCWbskd5drv8tIi+Fjv25Zp26zxAFj2UsY1lDuY5s6bVv/k?=
 =?us-ascii?Q?pQA0+pEoN0vHlCJIcetGzMDnyHI0eaAVDe6M5Xb/7cQ6gbRSU2i0vHbJ+9oy?=
 =?us-ascii?Q?8R6knUSa/Unq8WS8rW0pn98sIVBqsng8bKmGgmzBx/88ei7VW3Og4vXEmgFC?=
 =?us-ascii?Q?oKxEMGh73SHg8XTSWQQ/NPjaELigfS9pf53gmResCA/ZqJbK1RlaMURMzCQc?=
 =?us-ascii?Q?otxK+eXIuTtFELiYUQ+Ch0lGFYRuLre1AHtNt3vVGOpq7QiCUczn9xjPYxvh?=
 =?us-ascii?Q?6xetstcz797OCqEsZ8cGerivu+ovLwXuYOONmxFhrvSFYBzeWNUMXfhcCZFh?=
 =?us-ascii?Q?1+qHHXMdQTF3d89o7Ns8/92tnaS1D2uC8ja93+0P3jt9Bm11tsZL4dX2xPLg?=
 =?us-ascii?Q?pFDNDjEVOc6AEykoYuMt9PMvntnv66nRX74sFOZikX8Nw9+KL7MdJSrin+xS?=
 =?us-ascii?Q?X04scjezf/0wR5krYiEcdGIFmmiciapG6pZCIvY35JNSmgayD8wzJd4Hww3r?=
 =?us-ascii?Q?1ibbGfmeqeWkTWArZhhjY2g6q385qsWdrlU2akrQe5CEOImbYSCyuX5+eenD?=
 =?us-ascii?Q?HVuPQY8Z0KCOK8rEugMnpg9VzDUkE6EnJbn69ncellA7AQVFxvB86WDyCLhV?=
 =?us-ascii?Q?Ee+UBg3XiQvTQOKejZKZC7y1SMsga5fGMdKkGT4Rn798o/zNNcMmBsmh8nv0?=
 =?us-ascii?Q?m+Bn9Ln8ENBQ2rZaSlX+rVXxFNhOn1Rgz9vD3rEXp6zqbgeCHklpiO8AQCvZ?=
 =?us-ascii?Q?TTbaWvUbqmZ/7Mz4wBMq4sigR6mrxzg9udY3vSao6g1uLkzstG5GbUZAT/1V?=
 =?us-ascii?Q?A4sCslDUaTSpdnw6DwWVkehNKfEd0nYuAZB4JaEK3ZxfFu6nkeMfDchrTxr4?=
 =?us-ascii?Q?oJ859xLX9OTHV85O9uIp+M+c02/z104qglrh5n1rzFmkfK4ZUOp7aaQ9OeSg?=
 =?us-ascii?Q?vga6CQTLO7p/uCK1HtwyRVUIQ2vZiniPw6WCs3xGpLcuF64VxSLUh7btO1ta?=
 =?us-ascii?Q?VMPFRf+9m+7n3i9i0s46sY1EPj83ag40BnYyM4Ry2k8eFPDrKQKgP10Jthb/?=
 =?us-ascii?Q?Ep7N+mHNEZ90SHw7i2Qn3GVajuQCIJTgrzyyX9imVsj0q0e+8mSarUCNxcMC?=
 =?us-ascii?Q?3w1OHCx4dUNsxwCPYqY1IU9GXQnqZ0UCLYimM/snPQ2M3LARTVlrPY/Qtw5w?=
 =?us-ascii?Q?gh9LoVOoiiPjMNPgkwamspOzQ2ilUSCivRLSXCgw6o2Vhx4dvW1K6DLQRAX5?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qRXQXvt01rDLnh/7Ir+OD1oeb0SfNRC4YUaU25A0PHnuV9CO3R1x+FtNYL9+Bdge/rlCvmmLa720G+NbR46OVvGZEJ6vIeZJSb10rVD/zuzxrUsFvi9nnsNKmeMN/PDg8D0hsxDa7lL7QgpqeX8ol/ZqtM68BK09Qx8UFWcveGGIKonwphiLMeiqu72d+OiuSidtE9pSFzD6vlNsLmX0HAenCMHgwWTHQ3U9mbFSN5HWETyJ+lrOl1izXcD0Z3ypxxTX6tGWU+Iowb1XVRvbn1eYHQr3Y6fwCsPuU0kliCYtF606llyK8MNV6lkKD5X2ugRRXBFGoQFPw7tX88RClyS0OYGIgQbwQkNKEqDer31nnUrhvP2/IusDY93If97Po61RYEsaGyyPuHDzQx+n6zKNp2GRSCj8FnmeFCCB3qioIl9GXmV9jWR4txnkfYzD7zRzJTqkfj7Z4r76AEdk0tBeqiYeT+Qcjz9m/oSAl+vDRiezq5wr0yOrUxHhubddtP3H/sErNTLJEdg2oDY5Ba16JgOL2RCBfQfVgpj5Geks7iua1BcWBeyyOYc00qcMdDqGLxg3xBBAjjfJbWI1fEl/SVjHyGUe3SoLK/pUWps=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c92b67-8c43-450d-5433-08dca69c23bd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:07:52.5441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6l3ahmWUFFrl8jcHaQE4RWejIES3zvXD5HK8kgPQV5wDneGIbkASrFEwNQ8echd21+ZAqDoFnmAiRG1shZUZ1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7694
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_15,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407170152
X-Proofpoint-GUID: 5ES6hINEOpLpXYFxRKR1d7GPaRdROhHL
X-Proofpoint-ORIG-GUID: 5ES6hINEOpLpXYFxRKR1d7GPaRdROhHL

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Without an arch_unmap() call so high in the call stack, the check for
mseal'ed vmas can be moved lower as well.  This has the benefit of only
actually checking if things are msealed when there is anything to check.
That is, we know there is at least one vma that is in the way and needs
to be checked.

Only call the can_modify_mm() in do_vmi_align_munmap() and the MAP_FIXED
case of mmap_region().

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Jeff Xu <jeffxu@chromium.org>
---
 mm/mmap.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 117e8240f697..a32f545d3987 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2877,6 +2877,10 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	struct vma_munmap_struct vms;
 	int error;
 
+	/* Prevent unmapping a sealed VMA. */
+	if (unlikely(!can_modify_mm(mm, start, end)))
+		return -EPERM;
+
 	init_vma_munmap(&vms, vmi, vma, start, end, uf, unlock);
 	error = vms_gather_munmap_vmas(&vms, &mas_detach);
 	if (error)
@@ -2927,13 +2931,6 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 	if (end == start)
 		return -EINVAL;
 
-	/*
-	 * Prevent unmapping a sealed VMA.
-	 * can_modify_mm assumes we have acquired the lock on MM.
-	 */
-	if (unlikely(!can_modify_mm(mm, start, end)))
-		return -EPERM;
-
 	/* Find the first overlapping VMA */
 	vma = vma_find(vmi, end);
 	if (!vma) {
@@ -2991,13 +2988,15 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	if (!may_expand_vm(mm, vm_flags, pglen - nr_pages))
 		return -ENOMEM;
 
-	if (unlikely(!can_modify_mm(mm, addr, end)))
-		return -EPERM;
 
 	/* Find the first overlapping VMA */
 	vma = vma_find(&vmi, end);
 	init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
 	if (vma) {
+		/* Prevent unmapping a sealed VMA. */
+		if (unlikely(!can_modify_mm(mm, addr, end)))
+			return -EPERM;
+
 		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
 		mt_on_stack(mt_detach);
 		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
@@ -3370,13 +3369,6 @@ int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 {
 	struct mm_struct *mm = vma->vm_mm;
 
-	/*
-	 * Prevent unmapping a sealed VMA.
-	 * can_modify_mm assumes we have acquired the lock on MM.
-	 */
-	if (unlikely(!can_modify_mm(mm, start, end)))
-		return -EPERM;
-
 	return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
 }
 
-- 
2.43.0


