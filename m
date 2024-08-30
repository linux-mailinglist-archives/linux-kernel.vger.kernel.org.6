Return-Path: <linux-kernel+bounces-308006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C9B965616
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89897B21AF5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B63B14B949;
	Fri, 30 Aug 2024 04:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K7rRcVgl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U2mjjVbJ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D2913BC39
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 04:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724990490; cv=fail; b=Wz2/Sey5BDXY4DtcIqy+q7C8HbqakBSHa3aHxrrmc3qr7UJ/M7XiBJLPcxjeW2HkgzweI98ANqeaxSBvlgAID9cBFNTTzzcqQHrHLpZYOHbydByt3MXZ6kn1ucEnX3X8sPrsD9My1dFg5wCrt4igVSCU3keQs4jVJnkJ+8U0qKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724990490; c=relaxed/simple;
	bh=nsUPmsjg+N1xr/gikDYAoOgx/dxrW9lI4CS8101IUnc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DMSVdqJFnFjVM398/04tMXTwvLvIfa8BAEuzL8dX8D6BpjAUDxfZ8SLOtqqfuslU4KW/LKgetXxK6KhFmWHwWIhdhJWB0fefUO5zONWrtzxhu33IB86XPVuWmM/YDwYJG/UWje30ZZyulBeumnJYpT9zRgZTagkGN8QV84OE8Gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K7rRcVgl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U2mjjVbJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U2t2W6018749;
	Fri, 30 Aug 2024 04:01:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=8TaEHyVkYheU3Y
	BYOjCKigBaNc77WEZ3ittTdgRElQE=; b=K7rRcVgl1i47gnXGNGavAZ9scOhYoq
	r/Va8rpFTeoF7WnUsoG/OnDrDVdG92daZUuTZXRkF0nPwI+0hpFMxj3J6w0LJMJG
	H2qMZ8yfMNAwvYH4Q/UeSmpAFOfDkBGF3LdpHxufcIQSoJBB9ZQg4S2jWHBWyo5r
	HBOF6pnLJdQR8FkMd3iK42YuiJKTmz9IgoimHkQyACJWPXLjn+ILKdeRpzYtncEw
	OMaoGrawqCnM6BM8SsYr/7+GnyXIzc0aI18K3/INefDNgAiZVjwSTct+3JQltKJ8
	uiQ3REhDKxrawuuJsy2xoO+nnKXfmkmu8fHbjc7n8UeLaaqjVfvlHZww==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41b5q381h5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47U2Cu6U034855;
	Fri, 30 Aug 2024 04:01:09 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4189swukex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yz1WbMPH/0xC6Jafv4C47D0Tbp/8iWmYGhYUl46Ngxs74tiGqMHpRs4cwhpLG/k99BjH0VIPXQhYdeBAi+OR5MFOr4WPn4VNj9kJcLPnZCne2zZScUjtCE7IxpoylDSYAnnKNugpeOiyUj3AF/4RyTPG9QoadBODgi1njJXHa+vxoIIjBo1W1/m1yJv1fOoWFChIkC8bzd6obSzWRqWOOTLeUREhU5BEEbcwKvxDfsxMwOP/YiJQ1+aDzDKMvZb/VOTrhNSykMtcYVMAbj45t6m9Gv85TGpnqgaB+1y0aPyJjNxhaIfA6w+W6k5CHl7oIf7qYkZt4KU2ZkmfWuKF6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TaEHyVkYheU3YBYOjCKigBaNc77WEZ3ittTdgRElQE=;
 b=x71GlPgC+4evwmEN4a9gbvfkCuIBGfDsOKVstqsdJDRjQv8kZukepLvnTGFK4EC9qPCFVPl4fS85qf2h094b/4CSL3siixW6Fx7R5Rp+KF2uuP/8T1y9rqoZtkEqS4N+jf9Y6rMYwTn1FlAzSpudVTATFcc8F5DVbQu+PIsaVc0uK9aoODHJ9W1zFZQrS2u78CKQSTy5hJrS0eaVer995UhewTLkZAu4XprjpniPjdVfV7Sf+DA9nd8zJnvaGLhcslzm89owzqEsnrw1BzF2vZ0EMInoaFpLMRJpOZS6BaW8Y9gBjnMXmX9RkPPO8WKwnKBsbb46sGQBlApf1Xoreg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TaEHyVkYheU3YBYOjCKigBaNc77WEZ3ittTdgRElQE=;
 b=U2mjjVbJiMnjmXgOPdTCEMLtPMplKMzAmeKw36MPyrAWfr6bANF05Sq4SdSSaGHqw9EEsmpEpphkVQhAiinyGsRPJ8g013ix6eQalh+M+pppTuhTd2MH7pB/W/BoimKZrmN/9ga997DrBDFP6soQ7vXZZ3+Ww46iuHu4A+ujkHA=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CYXPR10MB7949.namprd10.prod.outlook.com (2603:10b6:930:e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 04:01:06 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 04:01:05 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v8 00/21] Avoid MAP_FIXED gap exposure
Date: Fri, 30 Aug 2024 00:00:40 -0400
Message-ID: <20240830040101.822209-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0421.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::23) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CYXPR10MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: 88ea3e84-6fc7-49dc-a6bd-08dcc8a85f14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DOY21GBuhbhW+1okf1RLSk1UGfWqsN98D63FGXUC5EDgCEDu1ZQy5N9MRv/b?=
 =?us-ascii?Q?liBMBUAP1l4qJepdwfoPVQQTIxVpdq3QvEgx6Xw8cHtfDZ64CiOGKdMv8Ql3?=
 =?us-ascii?Q?loX2jD5iMgV3Ew8GowZDEodMlUpxGNIb8qgklS0B5jtY5Acl7v1DmJFkDOt4?=
 =?us-ascii?Q?FSh/ePmigu8ycazG6goMZNSvOVjyJLh7kInFu9GVsHZjVldQAb4lyPPLHOqD?=
 =?us-ascii?Q?xXTRJN5FxM2cUdIsCMrbek4rrsMYqBIV+QzZF+VLofkbVsXv1xowPI03EmGV?=
 =?us-ascii?Q?25y3sMHn0mdTFe00hHlb/EvTocdzHL8swbOclajWIbFNmH5zpI5K++qeJVqL?=
 =?us-ascii?Q?ZVNIQSxqfTrgpH5rCFs1pJa8QuW7fQVKgkgd88lzGMM8eVhTo8aw6kKVJcNd?=
 =?us-ascii?Q?t4mWytcH4ygAKYw1PnkTC4WJNeysZMr9/NUgsa1405swAXWSW+S9W9XXOliJ?=
 =?us-ascii?Q?XxL48gIEvHweZmo8r6tC2icbeAJpYkNua/sU6o6QS68J1u+0e4fKNzclQNp7?=
 =?us-ascii?Q?baBEl5VxTajCYTIHioQszBksbPwk7YK6iF5q1o2rczGNNIrp9fs+2bH0yP+x?=
 =?us-ascii?Q?AQBX1JOKuTEXrMYGxB9Iq2ESUBx1WzPzpjN791jGkAUp3OtcU5NczTSYNyFW?=
 =?us-ascii?Q?vJvJOj2oW8SiRZkBe1laK3iyJVG+A6dBBQvSp0hRhIpMs4Mxz+gtGpEuD0cE?=
 =?us-ascii?Q?0xrm6ObE77IkyBHG1P1N7LhJx2AEwRPf91pPteDvOxH8DbkyEBC5H4VvmZh3?=
 =?us-ascii?Q?mMSszLbcgCNjV22BjrUakS6PnYZaWm+4NjXjNJfgmMXFR98BnYrD8I4CNp4J?=
 =?us-ascii?Q?8nZGTSeiT4I/MhJWkthuD1X1g0vmccIGXwWvKPiaXtqqjo0rOM8OCaMbbkZw?=
 =?us-ascii?Q?2uSCEgoHyuWwdfUADGehDWgONB8OUX2k0r4bdu9RvoAeSUiALfEc1F8oxKGc?=
 =?us-ascii?Q?wKsG6c5iBBA1Mqp4arC4GIQlJXZCEWZyuylZLQFkUkKg2ZD99bCkzN5E1nZW?=
 =?us-ascii?Q?Ew3HGxdwgF0Q3H126IXIcke0XkI5hRgedj4of3DqXVpscvqun6o3XMj3johT?=
 =?us-ascii?Q?vrS2H2TMxlf5fYrp1GtVU2xJYl9I0HMV7zRj3cc7iy+cpfPUdyBFaxdfafCD?=
 =?us-ascii?Q?AVpAuQadj1CqzsyByJrCGrAnCIxx4K589Pf43MWrxBXTrt0HVFrKx5lxQTkB?=
 =?us-ascii?Q?Ytvrjbf5ZIH+oJx9olhwfXWl7nPYI0RG324cbQl7tmm7F3nXjmI/LqKvDsiK?=
 =?us-ascii?Q?7AV5CLrYt1bVY7kHxM/XNVG2zF2P/dHs9AADZgsIumJLBE7wOAfAtekGHNTa?=
 =?us-ascii?Q?c7I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wGych3WZCi/xX7yzBWk8C8NwtlW2AX1lRfwfvjY9gxhSD+RBaClUfmA7rHst?=
 =?us-ascii?Q?/RBBqX4TbJU6HO7CnxKYXkNjs8g/pvadKxhwxsBlKwvN66AOmnipq7nQHf4O?=
 =?us-ascii?Q?tCEV2ThnD2c1y2cohRlu5GH8Ur1GPVQAblQ/4pzKQg6kXprg0Cn5MNOfPoWk?=
 =?us-ascii?Q?oAGCv6JEWv+n/3BX55a7S8zQ44+OF8IZxCfsqCa+8FWtuox3Yt2rRx3eJFac?=
 =?us-ascii?Q?bzYEWEJyHIYG4aSD1YCPg5M9JPX6T/VJ1BuHaH+ov4cJVBfMN3pP2gLL/iXP?=
 =?us-ascii?Q?UYnX99DRXvW0vmnQ3ZGxd6/Prs64VFXNCIxDgJZeL6Ouzq4rzVEnPNZStNnH?=
 =?us-ascii?Q?C4QgdVKH2tY/tkQaxB6GwNkIyp5OLMtfZQLIX790nhC5cKa31UrVv+WWbKNP?=
 =?us-ascii?Q?j7WMYe+yYQzNdliqhCXjWL1p0j04JVcCz/7Dxu8rcPp63qC0ABSUlWB4kAzj?=
 =?us-ascii?Q?l1nr23J3wiVSJPD4c8qX9E0T9I+omegvjyt2crVXD+8wRufxFeV3ZTADQ6YG?=
 =?us-ascii?Q?IUkVLA8bay2/r2/IS0KAZU87yHpCRZVCv5yNNBjfNI7mVA0Fu3HIUAAlzlCv?=
 =?us-ascii?Q?0O2Yyni3r6VW0ILLBCyx/gzl7XR5hSvnY6HnxWoxGaOr2vyytbhoPngSyM27?=
 =?us-ascii?Q?by2ihmT1THsZkCK2w9OOi8dpNdUkVbsDZQ/f28PVrp0guRk94WJDU39ba2To?=
 =?us-ascii?Q?odBjmAzJE7wQ15+CNGvC297ecCenGjwCjiBopinp5FPtPpbpkOjWyw056SYz?=
 =?us-ascii?Q?T8EK+rzznE/sTO3KM8rbBvIUz3Y1N01Q8v4Fu1pFW39pHjQaXAYFFvCibjQl?=
 =?us-ascii?Q?b1X4ff0rOM1lS5iTEeFCchee4dhKTm2aJK0XiZTcgFmS00CAZiH0geKD6ws8?=
 =?us-ascii?Q?CdHZiuATG+JVR0qOhfS7jK44eELTxxJEjgZYYEyNx+ZacVy2PAPoKemMfmZG?=
 =?us-ascii?Q?rEIfoPOxdN78e/adc1uVU4bKyK1VozL9DLMRk1ANnqJtI5/j87waBEvygNvr?=
 =?us-ascii?Q?NyxgFu5wz44XPmG2J4RkfwIOXuC/AjBir1OK2lN+ukXFUJQshNi2DpezAPAR?=
 =?us-ascii?Q?4yLUPasgKm44QYfhMYaiEw/rjk1OvXuoEDAdgC+fE0As8uOuZ2Dbc3NTU/f5?=
 =?us-ascii?Q?uqqK28SP2njzeuuamuGZbWT2D5ttfvWnAY+LcYJCQujZpHooK8Imbs8JYgQS?=
 =?us-ascii?Q?feVJ6r+FKRNewRhF5FuEsLhg70GmRWV3oJZVfgWysD7yu4Qw+cfsFlGcO34c?=
 =?us-ascii?Q?1k/cAc2ipKPMxGNNUb5FSahg2+L8aHT87fdJDll1lBC5RpaBHcIAqy+/sY4a?=
 =?us-ascii?Q?LV9h3ndNtkhnjjME02g4c6KrxEdJNB2Rx5fs5SbO3w5IdRELjYGUs9vv5oyM?=
 =?us-ascii?Q?EzoWwhi09JNXlP0o/OW9xGOKf6pqB1A/+RWp2x+LOzgYvmnVHcDUYPHJYedQ?=
 =?us-ascii?Q?gscFdRmHAUxf33CaNA/XE8cMqXlylIIdzCt2OzopcJt0jrV93QPYwv/f1ts7?=
 =?us-ascii?Q?rbvvdPNconF22rGGQqqP0/LH+hNyEQ5liVmgDl9QKpHDZ0IboY0UIYRwITwI?=
 =?us-ascii?Q?oY5akceajJbGf/dpHhc5fu4nysvHZA7MN835fU99?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aCrKLPwHQ7XBQtV3+wtCcEgZk6XySXKprLsyuS50avWVhNlTWm+0juE3hhuhRwvBC3NnxEsL/mGqsiCks5D7P0Yi5Gg8MW97CKfjwGL0/RHQpOAU6bqJo2A8gEuyXx8iQo0vnjlHMtDUVAmPMjtN1IagkbEFaW8G3dqEV0OJy+UlfJqlPybSOiOTGX8KAQ0XVX3J8MG//OSQ5NWEvSfTmOKwFkkTCN7vJGI9E1v/Ciwt9AnHXS5xd3Dr9Q3uOT5vP8UVH8daho40z4GRHqSEHyhKNBP5uCbM8hdB1ztsQUXAU+EuXdnQ6j4vPjNHglZfVKIh3oLBXQpi4GpUdauKNGFiQETuhlFaERWnzmAySY6r7jK47LmzTHCotSsNuGY8E+x8EUZ7K7nhbOFyyB5iRAqidpYjPgsvjccLjhTzlzsNlKtIZwgjetCjlwrFptqAdCuEOXjKMgvtgmN7hw/cMu1dMBMXAg2H9rdsnnLl9otcYh9bvgSGccz6q4BUGQsImw9VK12JbVUoIbjq1F80aETSfNAAJs3Gmv5kTIPRCdRk+KFagbhE+9AwTqB+Yo886x29qSUdCdfagubdZeZmbL1AXyG+eDD01lHHJwNJZyw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ea3e84-6fc7-49dc-a6bd-08dcc8a85f14
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 04:01:05.6628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mQAXk1/PHl+Rsa5htqiJ/FwMp2ZGJVhjjIFkHGRfrZYKw+NNCbQDVg2JadD/fO/Yt3QKvFWXaerX/Rw2YNVFQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7949
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300028
X-Proofpoint-GUID: qcw__-AfEBcpGPNXlgcAYpJlU30m9sJg
X-Proofpoint-ORIG-GUID: qcw__-AfEBcpGPNXlgcAYpJlU30m9sJg

It is now possible to walk the vma tree using the rcu read locks and is
beneficial to do so to reduce lock contention.  Doing so while a
MAP_FIXED mapping is executing means that a reader may see a gap in the
vma tree that should never logically exist - and does not when using the
mmap lock in read mode.  The temporal gap exists because mmap_region()
calls munmap() prior to installing the new mapping.

This patch set stops rcu readers from seeing the temporal gap by
splitting up the munmap() function into two parts.  The first part
prepares the vma tree for modifications by doing the necessary splits
and tracks the vmas marked for removal in a side tree.  The second part
completes the munmapping of the vmas after the vma tree has been
overwritten (either by a MAP_FIXED replacement vma or by a NULL in the
munmap() case).

Please note that rcu walkers will still be able to see a temporary state
of split vmas that may be in the process of being removed, but the
temporal gap will not be exposed.  vma_start_write() are called on both
parts of the split vma, so this state is detectable.

If existing vmas have a vm_ops->close(), then they will be called prior
to mapping the new vmas (and ptes are cleared out).  Without calling
->close(), hugetlbfs tests fail (hugemmap06 specifically) due to
resources still being marked as 'busy'.  Unfortunately, calling the
corresponding ->open() may not restore the state of the vmas, so it is
safer to keep the existing failure scenario where a gap is inserted and
never replaced.  The failure scenario is in its own patch (0015) for
traceability.

RFC: https://lore.kernel.org/linux-mm/20240531163217.1584450-1-Liam.Howlett@oracle.com/
v1: https://lore.kernel.org/linux-mm/20240611180200.711239-1-Liam.Howlett@oracle.com/
v2: https://lore.kernel.org/all/20240625191145.3382793-1-Liam.Howlett@oracle.com/
v3: https://lore.kernel.org/linux-mm/20240704182718.2653918-1-Liam.Howlett@oracle.com/
v4: https://lore.kernel.org/linux-mm/20240710192250.4114783-1-Liam.Howlett@oracle.com/
v5: https://lore.kernel.org/linux-mm/20240717200709.1552558-1-Liam.Howlett@oracle.com/
v6: https://lore.kernel.org/all/20240820235730.2852400-1-Liam.Howlett@oracle.com/
v7: https://lore.kernel.org/all/20240822192543.3359552-1-Liam.Howlett@oracle.com/

Changes since v7:

This is all the patches I've sent for v7 fixups plus the return code for
mseal().  The incorrect return code was introduced in an earlier patch
and then modified (still incorrectly) later, so this version will
hopefully bisect cleanly.

- Fixed return type of vms_gather_munmap_vmas() to -ENOMEM or -EPERM
- Passed through error returned from vms_gather_munmap_vmas() in
  mmap_region() - Thanks Jeff
- Added review tag on last patch - Thanks Lorenzo
- Added #ifdef CONFIG_MMU to vma.h where necessary - Thanks Lorenzo,
  Bert, and Geert
- Fix null pointer dereference in vms_abort_munmap_vmas() - Thanks Dan

Liam R. Howlett (21):
  mm/vma: Correctly position vma_iterator in __split_vma()
  mm/vma: Introduce abort_munmap_vmas()
  mm/vma: Introduce vmi_complete_munmap_vmas()
  mm/vma: Extract the gathering of vmas from do_vmi_align_munmap()
  mm/vma: Introduce vma_munmap_struct for use in munmap operations
  mm/vma: Change munmap to use vma_munmap_struct() for accounting and
    surrounding vmas
  mm/vma: Extract validate_mm() from vma_complete()
  mm/vma: Inline munmap operation in mmap_region()
  mm/vma: Expand mmap_region() munmap call
  mm/vma: Support vma == NULL in init_vma_munmap()
  mm/mmap: Reposition vma iterator in mmap_region()
  mm/vma: Track start and end for munmap in vma_munmap_struct
  mm: Clean up unmap_region() argument list
  mm/mmap: Avoid zeroing vma tree in mmap_region()
  mm: Change failure of MAP_FIXED to restoring the gap on failure
  mm/mmap: Use PHYS_PFN in mmap_region()
  mm/mmap: Use vms accounted pages in mmap_region()
  ipc/shm, mm: Drop do_vma_munmap()
  mm: Move may_expand_vm() check in mmap_region()
  mm/vma: Drop incorrect comment from vms_gather_munmap_vmas()
  mm/vma.h: Optimise vma_munmap_struct

 include/linux/mm.h |   6 +-
 ipc/shm.c          |   8 +-
 mm/mmap.c          | 140 +++++++++---------
 mm/vma.c           | 362 +++++++++++++++++++++++++++------------------
 mm/vma.h           | 168 ++++++++++++++++++---
 5 files changed, 434 insertions(+), 250 deletions(-)

-- 
2.43.0


