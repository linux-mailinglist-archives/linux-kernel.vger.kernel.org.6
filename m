Return-Path: <linux-kernel+bounces-299602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C87795D764
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 22:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE08CB22A96
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 20:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA15197A6C;
	Fri, 23 Aug 2024 20:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="laMt5Hp/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ROL22bGY"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4181F1953A2
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 20:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724443668; cv=fail; b=qjxGGNYOLRq867jYFqfQVaHhvUwCWCLa6/gJIpl8qu5hzQ6pyoXoDe9bwSkunNfbUZuTiNs+KHekjItSwQE2U/b/h1+N+MbyAkdBF0uP/U+vdHeCVobGOiG2tO/hfHrSSo0MKh3Eu8pu6KWe2/O+XM61cOcqFIlrJDOdIFYP9dQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724443668; c=relaxed/simple;
	bh=6sgKMZBE5peHIJeqnAb/JPBuHgepjfCQezehtruEcBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KS2Kpldu+5kwGwM71JNDZgjITTqGDhbfsuxEYaQGz7f2QWouaTfEEYCveK6W5T7quHbgkM8hEfUp63/gniS4AhI/DstxcN3cApiIXgCM9xXcYx8zltUlZUL/zSNYCX22DSt4D3cR+VXhiLMh35IkC9RLaQ79dnM82R55NTT/EgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=laMt5Hp/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ROL22bGY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47NH0VVj023941;
	Fri, 23 Aug 2024 20:07:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=goF2lUyd/6o9YQa0vbk2oC9TN0OOiZB8fM+8ZD/mB7c=; b=
	laMt5Hp/E59pch8Xrx4KbaUiIayFOql6QnsPA/BhR0CY/fReoBOn29dj5TLE/Qly
	nhWjQCHfQ6ZCfNiaicPb9FMJapeOfbqf6zSilMFNNY6eU7HcOvUWu1X5Sx5dNX7a
	sw2ZHLUOKCPjVSucjW1CzgFpXgflIkqfN35WS1GBfhyG6+MJKj3nx1XRIZ50hc9V
	VlwpFc950RDJcFPeiGkgrXBclXucm+0hcHr7g788S5DDjUiq7/+C/fl7voL4WSHH
	AFgJszs+uEaDNKfuyHAEq5IUsyvjpIq6klxxpeqSDFC8ePF6RfXMJWzYiKWNDjjO
	JDfwgBqGimqViu67P7Ik0A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m6gn7jd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 20:07:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47NJdCpW007466;
	Fri, 23 Aug 2024 20:07:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4170s5gxw2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 20:07:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajLW04s3SZ+X4mMd+KvB0dzbUtLX2ZtACDy5Js7zi+FLI7kT20Dw48rGEwtQTwz4fadMKen0w0gKWHB6luXdlKU57LeF1i26jMZdi0cUkkVBmSd0wOEx+Vn8qNQ/qe7u+M+Bj4qE1iyazyGctACHaFUWc9zMhkL0DC6jjHZUTtnklQpSxzvsKxGvHYxDVlLagnwKNcK+0Nrb/1ZN/WUfsZ5eLUjpR+xhQr/uDTtn+ZpIGZF1L+jWjWA4bhTQqNi0a9wubhp3UfGRqhdfrY/dunSkNDa99L+0hER9U/VfuFCv4xAJKN2MdKBDVEtT7F4onS63JTP++9TXiceHwsgNXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=goF2lUyd/6o9YQa0vbk2oC9TN0OOiZB8fM+8ZD/mB7c=;
 b=VZt4XGE9uDOvwvNrOvLa5a1InIb3hKH5jKIvkqJQg2m5zt5Q1hZkIXCfWMQeHV4Nr1N4l083rz1vsmgwA9QBz4QmxT6Ezz+1RJE0vvW743vIWHauy4dZypFTqibElWSlw9lUi8BRlBRLs98UxGHL8UrbL9zj3MIniKJRnJ1tecC5JadUvQBAYVIZFGSLM3Vm0ByJWlPhMPHzu+EeJ51TQCWbeEWKRLHM+10mZxn/iZ3826jmMK4ia3ZgCn6iDrA4z4cl2gKUVGmqIBivlfNJ89qL6ljtjwyht/UOKVQGOWjapCg+PP0UutqDluDQqS6721qFod2tqYKC94nS4jsITw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goF2lUyd/6o9YQa0vbk2oC9TN0OOiZB8fM+8ZD/mB7c=;
 b=ROL22bGYMOV98hRf3OENg/WsT+Fs+3jCLdKVMKMSF5HdFjupxE2ZMgwG2L6Xa13j8p8pgmroU0EkGxuivZJ8bRrOGBdtw4oVNIL/77GxvG6DX80Exq4q4GAytdkoWMOFOzvvr+Hab8YchLQ/cJ3Zdb4hWv3IDxFPM9yJmS/gp8k=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BL3PR10MB6187.namprd10.prod.outlook.com (2603:10b6:208:3be::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Fri, 23 Aug
 2024 20:07:25 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 20:07:25 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 06/10] mm: avoid using vma_merge() for new VMAs
Date: Fri, 23 Aug 2024 21:07:01 +0100
Message-ID: <57f55a1473586a88211e04b44c6b128332d4272c.1724441678.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724441678.git.lorenzo.stoakes@oracle.com>
References: <cover.1724441678.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0149.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::17) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BL3PR10MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a803a30-0a96-4079-31f9-08dcc3af34d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WRTfZFnvGThwfMBkAtCy7hPGRVj9DrlCHRdAPiGB1hSKTGUxvhDAFrb41ZMl?=
 =?us-ascii?Q?cEZAeE1iGLiXgqmtbGfHFGClHI3o+ydbHUtPOERFhZ0D+JMd2VFxT3uk+f4U?=
 =?us-ascii?Q?XnZ8lBjvmV84dkXCHZXVU86ZGtuhGq6RjieZBprm7kcYrkAcalFPiJBT27yY?=
 =?us-ascii?Q?DMSTmflVZj8e6+KdcwzNlpPvRTRcMl0iMhPupBLsiiIv4R14V+9Y/Ymb6AYQ?=
 =?us-ascii?Q?frpNTH91R+Xrws9bqAoH00HrZZ4iN/VlSVJxIJUb6S5812TWQFdPu80aCLpV?=
 =?us-ascii?Q?itm4dMwUeqbr+tpDZiwgHKp/2BBt6vBrVgotoySCpx2EA2x7jQGBfhm55tvz?=
 =?us-ascii?Q?nPzWinrYpnwiffoZEBAThGXHjKyUFWDTYBiz17NO6t1R7s19iyFD77p/SP3M?=
 =?us-ascii?Q?jm+5mk3yzrxvp4anqZuvZQvWt5CZlZB84URwj12vV6j3u6N0USEUYSXHvDv0?=
 =?us-ascii?Q?vfEuoeJfGZqy+u78St0NoDFJFKMWyRu8aGgaHR0rTGQ74/fjmeTPsYYCAQUE?=
 =?us-ascii?Q?c75HjiX8inBvRr0f3PEwS0qH6qPtn6mSLwSVjo0KRg8kbH+lr+NaMqvYC/92?=
 =?us-ascii?Q?vpcdp/OfjrY2SW+qOmjQsG38iR88Q3pC6uAsLuOnMAT6UgBfjV50AOVr3XW1?=
 =?us-ascii?Q?4es2MaQa/VlAGVuW5oZ272OSMF4fFaRlmrkA2tmzJc4NS8Sv5za8t+qs+c5M?=
 =?us-ascii?Q?nDdsjg/53Dfo7Y1hH3KH6OkB0o0OWCLgEw20LaitJqx5VFVuuZjouRa/U5U3?=
 =?us-ascii?Q?6myXiTXahoB5pjGyJTow1/EFuVs63gCCI31GMsZYXHqEuO0JgJ2s/v6IkWTK?=
 =?us-ascii?Q?GDh9lcyNVWPKHoQnZeWFZER7X+laPTBbylBLbBjU8UCkhgGArAkkbWs4IYem?=
 =?us-ascii?Q?1GYnRw5lOLuJ/cLFsQF2wHbf709AWlPcLchMoE2LSUy8nFaNObSBDjIYeq/m?=
 =?us-ascii?Q?3I8hNflqFc6B5pBfs2Cxo1W+7Y9oKf2+5/1DA3epKgDrA2F+3mNT2Sk+kk49?=
 =?us-ascii?Q?Fe79FjwIBsQAjSBCO64c8MPjw1LpLd/LkgegjHmdzUhT2uyEmHVIv5G2Fppm?=
 =?us-ascii?Q?SsgQW3BX7+Kc7bjbgFhA3QLuCOeDIaEYVOItAIgetK7G9fINW8ijRm9eQ8X5?=
 =?us-ascii?Q?gYdThP9eTbrSSzstNPDtZyfXNhrCD9RKrEMrJyMdMqoKdgOQFN12kEesKczU?=
 =?us-ascii?Q?aBHg5AElb74Zejd9LhlpC7TrlJ3fw9hSZ2DeOtOYKvaVZc+JHAKRcR8oR3kp?=
 =?us-ascii?Q?eqh+eC9PnxLt77O5EpLzDQe9aaiWRwFEfR2EJZmkYIc3V8zEWrizEW5igGPv?=
 =?us-ascii?Q?/cbtuVMKR4KWR6g79t6zclrVkOUY4FlhKpE8Tks1QFRq3g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YaZaup5SJQYf3DAqKq0VglKG1wQpvvqli1JsiZpRdY0UDs8JfX0RF4b7KKyj?=
 =?us-ascii?Q?1JQDZLJsTSbBEkxgCFphojQkFsUCuAZdug50pNH597GxMfhPR6rTKBncARyK?=
 =?us-ascii?Q?gkUmHTcYDKfd3i0c/hllOE/vPcNGoBT5FqR+Ydi3/XvgQNRPLvx2Inm2ezeK?=
 =?us-ascii?Q?/1dWrm/35zcQyYsQIqRt21rD2wQ+FR7GvRFGONABlvWY5F4efiIp4LsRZ1j/?=
 =?us-ascii?Q?YwYJKh4K7gEXRpWXPSiNh+GhnjxD/RymQIVYz47NcGDuTsnUXOU+9F9V45Yx?=
 =?us-ascii?Q?YtYRpt+DXWbikvnGwk7u5oRN+s1oxD5cAJrGn68iOJXJKlU/Ji8YvVxNYSe+?=
 =?us-ascii?Q?gYRLzwd8FO0Lz/do6wF1zLuiY8emPnfHxn9K8jT/Xeaaj8QBVKbQ3R+K7/ck?=
 =?us-ascii?Q?dYwHB1l00FG/LL3BRJrA1Wvh1MLEYC+sQroR9KiPKoXpBHXz9hI+tteaxurB?=
 =?us-ascii?Q?pSUkrdQSOHiOZ+4tyqYc+wsDcEjkvHd93u8W6FroZ/jVVHheXPYkMoVf34m7?=
 =?us-ascii?Q?5FQ4J3FR/iIkLzR9wqElh0KVqVQd872PCYmNkcVByDGnbFXCAumVqPfn9jK4?=
 =?us-ascii?Q?ykTVTO/x3hUs4FpHDFyEASof+4d+gAqG2aIT6k+NnvIgClmfqTixXOQxREqV?=
 =?us-ascii?Q?/IMuTLH9Xd1wo++asMsq50xS2Nbf90U7VI/DcbI22pe+WAqBqJ2VT7RB6Rq7?=
 =?us-ascii?Q?VaTSxKZGtEu3RhK5ZkdtIsds1eUCMHEu3gR6/I7XnAPnfGFE9hnsCCR1uKlj?=
 =?us-ascii?Q?/sGU0ORmychMLElKJu6POPq3kp6BJAUMTjoEWbXDNw3RuS1KXPAPVQvQqgCZ?=
 =?us-ascii?Q?AsdJIf/HTS+vVW5xk7XmqSIFjW39tlipE6/4WoDyaTT21/cXRoz886/19Ki9?=
 =?us-ascii?Q?jpsDZV2WqS1Hvw6Ij9Ek11UQxrjopDGUhd9UlLljB7XYv5t6EjepbdASzqCX?=
 =?us-ascii?Q?rgeAO/2/LpYjdXyimdfLtRGeAFh56jSKeQ4QyVYkjU3KH7y5gBPnZM/MBNQa?=
 =?us-ascii?Q?zENVwMSqQl2LTIu6lMhxred+zMlLtagKDKixXBwd544/NHkWEaKbmNrY8aKY?=
 =?us-ascii?Q?cP/A90El+jjaGOZMSF9A1G0xkfsRX4JPvMt0CYprt0e9/c1xm05THa6+5luP?=
 =?us-ascii?Q?7wug9Qzsv/U+LNkwojH6qVrhduVtumL4udLXGorSKDH2rHzxmmVzoquSTGHo?=
 =?us-ascii?Q?HbjekI1EjXODiYT4oGv2+GlfIUsjIRJ3uuQOALOxoannHTTE0or5jN+wXSP3?=
 =?us-ascii?Q?YrOdifsKc6ZMwb1aaJ2geK+MMV7K7xhFz0kEzlFqcb2U3wCVfU5yQCuNLi/2?=
 =?us-ascii?Q?rAonTFry6Ss49DSxKU6M8QdoA+qAnD6nWfa+F2oQRZBlIJJeAX0e4iX4aQIt?=
 =?us-ascii?Q?YEsvy+hkFYkQXmKacO3bSm8oHZ+7lS9r55Y44ZI3ELNHKxIg4sA1TLFL1iRW?=
 =?us-ascii?Q?1KtKpZdk71xSfjn3bdIYNEh1SELJsSoHNK6+LcPSM7D/PFMJ6nVHtRo91KxI?=
 =?us-ascii?Q?KFjj5mavKN7hcJeQ0agUs8j18+fUE9KIBPxB++O3yqHJOianxKEzl0YfgytP?=
 =?us-ascii?Q?U2EcvaMCfdr1ytz5/lub2/jYtPSSQd6jKV8d+brWoEeb5Wq4Uay9Qfs10TBD?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Y+y/NW/vsKk46fMfpB4IvHvLf+dMUaJfmrYQDYE2GyhO1WFdFsR2l0QlHX3o8V7V6t/mOgp6BZUEZCkEEagDpIXKL9xHshqQj6xJ6TFHQlZR0zFMTDPJs6990Grx6IDXaykrowhr71Q0d8uo6QJFaGzRSXknGTXlsU1y2YhIFYbDgudvRZqJS8tdcX3iRZgaLD55pn37i+73mtAv9eNLPj2gvKnNfJ2WtWQH6Vz1AQ+wifqwxF3NaktWOv/J6hQ+1fyD2+kG/G8HQx3h9abYlwF63OaEMxP5An+tG1Vf2RL8pOLQJI0XrOfS5N+gx0DJvXmXa5zlOanqfFnvEG3i2CbCIOyG/VDOMnV9oek/9HMnAK73bk8b3JkkFp4YYT0pqMDsM3GtFywucv0efDWNA4pro8/CBR5xLjv+HnouJ91dtj8SPObSITZG8GUdLouRWon4x+1ZPw5mZMpX/Axc+ZBfXIdzVcytcqIlzmOy5aErB5ULrz9Tgh1QiXoa1kzENwP6DKZAc+rdIeQ5do4KhYm1lmDtT7pprAmx7tCxM19u1mKlDiOW0AvXDGQjKEUJ0lG9zTTno8VlERpsxkvVkEdCokTsw3Qrv8DrspYlFCY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a803a30-0a96-4079-31f9-08dcc3af34d1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 20:07:25.4836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fXvgw5Q8P02+Fx5mtBBgnavgl3J16ODcZDpIc/qDCrdNAUje3XeuCH4kZX11VAiGMa/CUpRoSduBb0/E2Fw8OhrEhQakXZwr8tKCQiCIpnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6187
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_16,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408230148
X-Proofpoint-ORIG-GUID: V6v47r33P2OX54NTnyo_0sQsDkJMwt63
X-Proofpoint-GUID: V6v47r33P2OX54NTnyo_0sQsDkJMwt63

Abstract vma_merge_new_vma() to use vma_merge_struct and rename the
resultant function vma_merge_new_range() to be clear what the purpose of
this function is - a new VMA is desired in the specified range, and we wish
to see if it is possible to 'merge' surrounding VMAs into this range rather
than having to allocate a new VMA.

Note that this function uses vma_extend() exclusively, so adopts its
requirement that the iterator point at or before the gap. We add an assert
to this effect.

This is as opposed to vma_merge_existing_range(), which will be introduced
in a subsequent commit, and provide the same functionality for cases in
which we are modifying an existing VMA.

In mmap_region() and do_brk_flags() we open code scenarios where we prefer
to use vma_expand() rather than invoke a full vma_merge() operation.

Abstract this logic and eliminate all of the open-coding, and also use the
same logic for all cases where we add new VMAs to, rather than ultimately
use vma_merge(), rather use vma_expand().

Doing so removes duplication and simplifies VMA merging in all such cases,
laying the ground for us to eliminate the merging of new VMAs in
vma_merge() altogether.

Also add the ability for the vmg to track state, and able to report errors,
allowing for us to differentiate a failed merge from an inability to
allocate memory in callers.

This makes it far easier to understand what is happening in these cases
avoiding confusion, bugs and allowing for future optimisation.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c                        |  93 +++++-------------
 mm/vma.c                         | 162 ++++++++++++++++++++++++++-----
 mm/vma.h                         |  20 +++-
 tools/testing/vma/vma.c          |  33 ++++++-
 tools/testing/vma/vma_internal.h |   6 ++
 5 files changed, 216 insertions(+), 98 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 0d242c9b1f4c..80d70ed099cf 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1364,8 +1364,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;
-	struct vm_area_struct *next, *prev, *merge;
 	pgoff_t pglen = PHYS_PFN(len);
+	struct vm_area_struct *merge;
 	unsigned long charged = 0;
 	struct vma_munmap_struct vms;
 	struct ma_state mas_detach;
@@ -1389,13 +1389,13 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		if (vms_gather_munmap_vmas(&vms, &mas_detach))
 			return -ENOMEM;
 
-		next = vmg.next = vms.next;
-		prev = vmg.prev = vms.prev;
+		vmg.next = vms.next;
+		vmg.prev = vms.prev;
 		vma = NULL;
 	} else {
-		next = vmg.next = vma_next(&vmi);
-		prev = vmg.prev = vma_prev(&vmi);
-		if (prev)
+		vmg.next = vma_next(&vmi);
+		vmg.prev = vma_prev(&vmi);
+		if (vmg.prev)
 			vma_iter_next_range(&vmi);
 	}
 
@@ -1417,45 +1417,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vmg.flags = vm_flags;
 	}
 
-	if (vm_flags & VM_SPECIAL)
-		goto cannot_expand;
-
-	/* Attempt to expand an old mapping */
-	/* Check next */
-	if (next && next->vm_start == end && can_vma_merge_before(&vmg)) {
-		vmg.end = next->vm_end;
-		vma = vmg.vma = next;
-		vmg.pgoff = next->vm_pgoff - pglen;
-		/*
-		 * We set this here so if we will merge with the previous VMA in
-		 * the code below, can_vma_merge_after() ensures anon_vma
-		 * compatibility between prev and next.
-		 */
-		vmg.anon_vma = vma->anon_vma;
-		vmg.uffd_ctx = vma->vm_userfaultfd_ctx;
-	}
-
-	/* Check prev */
-	if (prev && prev->vm_end == addr && can_vma_merge_after(&vmg)) {
-		vmg.start = prev->vm_start;
-		vma = vmg.vma = prev;
-		vmg.pgoff = prev->vm_pgoff;
-		vma_prev(&vmi); /* Equivalent to going to the previous range */
-	}
-
-	if (vma) {
-		/* Actually expand, if possible */
-		if (!vma_expand(&vmg)) {
-			khugepaged_enter_vma(vma, vm_flags);
-			goto expanded;
-		}
-
-		/* If the expand fails, then reposition the vma iterator */
-		if (unlikely(vma == prev))
-			vma_iter_set(&vmi, addr);
-	}
-
-cannot_expand:
+	vma = vma_merge_new_range(&vmg);
+	if (vma)
+		goto expanded;
 
 	/*
 	 * Determine the object being mapped and call the appropriate
@@ -1503,10 +1467,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		 * If vm_flags changed after call_mmap(), we should try merge
 		 * vma again as we may succeed this time.
 		 */
-		if (unlikely(vm_flags != vma->vm_flags && prev)) {
-			merge = vma_merge_new_vma(&vmi, prev, vma,
-						  vma->vm_start, vma->vm_end,
-						  vma->vm_pgoff);
+		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
+			vmg.flags = vma->vm_flags;
+			/* If this fails, state is reset ready for a reattempt. */
+			merge = vma_merge_new_range(&vmg);
+
 			if (merge) {
 				/*
 				 * ->mmap() can change vma->vm_file and fput
@@ -1521,6 +1486,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 				/* Update vm_flags to pick up the change. */
 				vm_flags = vma->vm_flags;
 				goto unmap_writable;
+			} else {
+				vma_iter_config(&vmi, addr, end);
 			}
 		}
 
@@ -1554,7 +1521,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	vma_link_file(vma);
 
 	/*
-	 * vma_merge() calls khugepaged_enter_vma() either, the below
+	 * vma_merge_new_range() calls khugepaged_enter_vma() too, the below
 	 * call covers the non-merge case.
 	 */
 	khugepaged_enter_vma(vma, vma->vm_flags);
@@ -1609,7 +1576,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 		vma_iter_set(&vmi, vma->vm_end);
 		/* Undo any partial mapping done by a device driver. */
-		unmap_region(&vmi.mas, vma, prev, next);
+		unmap_region(&vmi.mas, vma, vmg.prev, vmg.next);
 	}
 	if (writable_file_mapping)
 		mapping_unmap_writable(file->f_mapping);
@@ -1755,7 +1722,6 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		unsigned long addr, unsigned long len, unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
-	struct vma_prepare vp;
 
 	/*
 	 * Check against address space limits by the changed size
@@ -1779,25 +1745,12 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		VMG_STATE(vmg, mm, vmi, addr, addr + len, flags, PHYS_PFN(addr));
 
 		vmg.prev = vma;
-		if (can_vma_merge_after(&vmg)) {
-			vma_iter_config(vmi, vma->vm_start, addr + len);
-			if (vma_iter_prealloc(vmi, vma))
-				goto unacct_fail;
-
-			vma_start_write(vma);
-
-			init_vma_prep(&vp, vma);
-			vma_prepare(&vp);
-			vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
-			vma->vm_end = addr + len;
-			vm_flags_set(vma, VM_SOFTDIRTY);
-			vma_iter_store(vmi, vma);
-
-			vma_complete(&vp, vmi, mm);
-			validate_mm(mm);
-			khugepaged_enter_vma(vma, flags);
+		vma_iter_next_range(vmi);
+
+		if (vma_merge_new_range(&vmg))
 			goto out;
-		}
+		else if (vmg_nomem(&vmg))
+			goto unacct_fail;
 	}
 
 	if (vma)
diff --git a/mm/vma.c b/mm/vma.c
index 4867ae722a9a..8a5fa15f46a2 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -464,6 +464,116 @@ void validate_mm(struct mm_struct *mm)
 }
 #endif /* CONFIG_DEBUG_VM_MAPLE_TREE */
 
+/*
+ * vma_merge_new_range - Attempt to merge a new VMA into address space
+ *
+ * @vmg: Describes the VMA we are adding, in the range @vmg->start to @vmg->end
+ *       (exclusive), which we try to merge with any adjacent VMAs if possible.
+ *
+ * We are about to add a VMA to the address space starting at @vmg->start and
+ * ending at @vmg->end. There are three different possible scenarios:
+ *
+ * 1. There is a VMA with identical properties immediately adjacent to the
+ *    proposed new VMA [@vmg->start, @vmg->end) either before or after it -
+ *    EXPAND that VMA:
+ *
+ * Proposed:       |-----|  or  |-----|
+ * Existing:  |----|                  |----|
+ *
+ * 2. There are VMAs with identical properties immediately adjacent to the
+ *    proposed new VMA [@vmg->start, @vmg->end) both before AND after it -
+ *    EXPAND the former and REMOVE the latter:
+ *
+ * Proposed:       |-----|
+ * Existing:  |----|     |----|
+ *
+ * 3. There are no VMAs immediately adjacent to the proposed new VMA or those
+ *    VMAs do not have identical attributes - NO MERGE POSSIBLE.
+ *
+ * In instances where we can merge, this function returns the expanded VMA which
+ * will have its range adjusted accordingly and the underlying maple tree also
+ * adjusted.
+ *
+ * Returns: In instances where no merge was possible, NULL. Otherwise, a pointer
+ *          to the VMA we expanded.
+ *
+ * This function adjusts @vmg to provide @vmg->next if not already specified,
+ * and adjusts [@vmg->start, @vmg->end) to span the expanded range.
+ *
+ * ASSUMPTIONS:
+ * - The caller must hold a WRITE lock on the mm_struct->mmap_lock.
+ * - The caller must have determined that [@vmg->start, @vmg->end) is empty,
+     other than VMAs that will be unmapped should the operation succeed.
+ * - The caller must have specified the previous vma in @vmg->prev.
+ * - The caller must have specified the next vma in @vmg->next.
+ * - The caller must have positioned the vmi at or before the gap.
+ */
+struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
+{
+	struct vm_area_struct *prev = vmg->prev;
+	struct vm_area_struct *next = vmg->next;
+	unsigned long start = vmg->start;
+	unsigned long end = vmg->end;
+	pgoff_t pgoff = vmg->pgoff;
+	pgoff_t pglen = PHYS_PFN(end - start);
+	bool can_merge_before, can_merge_after;
+
+	mmap_assert_write_locked(vmg->mm);
+	VM_WARN_ON(vmg->vma);
+	/* vmi must point at or before the gap. */
+	VM_WARN_ON(vma_iter_addr(vmg->vmi) > end);
+
+	vmg->state = VMA_MERGE_NOMERGE;
+
+	/* Special VMAs are unmergeable, also if no prev/next. */
+	if ((vmg->flags & VM_SPECIAL) || (!prev && !next))
+		return NULL;
+
+	can_merge_before = next && next->vm_start == end &&
+		can_vma_merge_before(vmg);
+	can_merge_after = prev && prev->vm_end == start &&
+		can_vma_merge_after(vmg);
+
+	/* If we can merge with the next VMA, adjust vmg accordingly. */
+	if (can_merge_before &&
+	    (!can_merge_after || is_mergeable_anon_vma(prev->anon_vma,
+						       next->anon_vma, NULL))) {
+		vmg->end = next->vm_end;
+		vmg->vma = next;
+		vmg->pgoff = next->vm_pgoff - pglen;
+	}
+
+	/* If we can merge with the previous VMA, adjust vmg accordingly. */
+	if (can_merge_after) {
+		vmg->start = prev->vm_start;
+		vmg->vma = prev;
+		vmg->pgoff = prev->vm_pgoff;
+
+		vma_prev(vmg->vmi); /* Equivalent to going to the previous range */
+	}
+
+	/*
+	 * Now try to expand adjacent VMA(s). This takes care of removing the
+	 * following VMA if we have VMAs on both sides.
+	 */
+	if (vmg->vma && !vma_expand(vmg)) {
+		khugepaged_enter_vma(vmg->vma, vmg->flags);
+
+		vmg->state = VMA_MERGE_SUCCESS;
+		return vmg->vma;
+	}
+
+	/* If expansion failed, reset state. Allows us to retry merge later. */
+	vmg->vma = NULL;
+	vmg->start = start;
+	vmg->end = end;
+	vmg->pgoff = pgoff;
+	if (vmg->vma == prev)
+		vma_iter_set(vmg->vmi, start);
+
+	return NULL;
+}
+
 /*
  * vma_expand - Expand an existing VMA
  *
@@ -474,7 +584,11 @@ void validate_mm(struct mm_struct *mm)
  * vmg->next->vm_end.  Checking if the vmg->vma can expand and merge with
  * vmg->next needs to be handled by the caller.
  *
- * Returns: 0 on success
+ * Returns: 0 on success.
+ *
+ * ASSUMPTIONS:
+ * - The caller must hold a WRITE lock on vmg->vma->mm->mmap_lock.
+ * - The caller must have set @vmg->vma and @vmg->next.
  */
 int vma_expand(struct vma_merge_struct *vmg)
 {
@@ -484,6 +598,8 @@ int vma_expand(struct vma_merge_struct *vmg)
 	struct vm_area_struct *next = vmg->next;
 	struct vma_prepare vp;
 
+	mmap_assert_write_locked(vmg->mm);
+
 	vma_start_write(vma);
 	if (next && (vma != next) && (vmg->end == next->vm_end)) {
 		int ret;
@@ -516,6 +632,7 @@ int vma_expand(struct vma_merge_struct *vmg)
 	return 0;
 
 nomem:
+	vmg->state = VMA_MERGE_ERROR_NOMEM;
 	if (anon_dup)
 		unlink_anon_vmas(anon_dup);
 	return -ENOMEM;
@@ -1034,6 +1151,8 @@ static struct vm_area_struct *vma_merge(struct vma_merge_struct *vmg)
 	pgoff_t pglen = PHYS_PFN(end - addr);
 	long adj_start = 0;
 
+	vmg->state = VMA_MERGE_NOMERGE;
+
 	/*
 	 * We later require that vma->vm_flags == vm_flags,
 	 * so this tests vma->vm_flags & VM_SPECIAL, too.
@@ -1185,13 +1304,19 @@ static struct vm_area_struct *vma_merge(struct vma_merge_struct *vmg)
 	vma_complete(&vp, vmg->vmi, mm);
 	validate_mm(mm);
 	khugepaged_enter_vma(res, vmg->flags);
+
+	vmg->state = VMA_MERGE_SUCCESS;
 	return res;
 
 prealloc_fail:
+	vmg->state = VMA_MERGE_ERROR_NOMEM;
 	if (anon_dup)
 		unlink_anon_vmas(anon_dup);
 
 anon_vma_fail:
+	if (err == -ENOMEM)
+		vmg->state = VMA_MERGE_ERROR_NOMEM;
+
 	vma_iter_set(vmg->vmi, addr);
 	vma_iter_load(vmg->vmi);
 	return NULL;
@@ -1298,22 +1423,6 @@ struct vm_area_struct
 	return vma_modify(&vmg);
 }
 
-/*
- * Attempt to merge a newly mapped VMA with those adjacent to it. The caller
- * must ensure that [start, end) does not overlap any existing VMA.
- */
-struct vm_area_struct
-*vma_merge_new_vma(struct vma_iterator *vmi, struct vm_area_struct *prev,
-		   struct vm_area_struct *vma, unsigned long start,
-		   unsigned long end, pgoff_t pgoff)
-{
-	VMG_VMA_STATE(vmg, vmi, prev, vma, start, end);
-
-	vmg.pgoff = pgoff;
-
-	return vma_merge(&vmg);
-}
-
 /*
  * Expand vma by delta bytes, potentially merging with an immediately adjacent
  * VMA with identical properties.
@@ -1324,8 +1433,9 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
 {
 	VMG_VMA_STATE(vmg, vmi, vma, vma, vma->vm_end, vma->vm_end + delta);
 
-	/* vma is specified as prev, so case 1 or 2 will apply. */
-	return vma_merge(&vmg);
+	/* We use the VMA to populate VMG fields only. */
+	vmg.vma = NULL;
+	return vma_merge_new_range(&vmg);
 }
 
 void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb)
@@ -1426,9 +1536,10 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	struct vm_area_struct *vma = *vmap;
 	unsigned long vma_start = vma->vm_start;
 	struct mm_struct *mm = vma->vm_mm;
-	struct vm_area_struct *new_vma, *prev;
+	struct vm_area_struct *new_vma;
 	bool faulted_in_anon_vma = true;
 	VMA_ITERATOR(vmi, mm, addr);
+	VMG_VMA_STATE(vmg, &vmi, NULL, vma, addr, addr + len);
 
 	/*
 	 * If anonymous vma has not yet been faulted, update new pgoff
@@ -1439,11 +1550,18 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 		faulted_in_anon_vma = false;
 	}
 
-	new_vma = find_vma_prev(mm, addr, &prev);
+	new_vma = find_vma_prev(mm, addr, &vmg.prev);
 	if (new_vma && new_vma->vm_start < addr + len)
 		return NULL;	/* should never get here */
 
-	new_vma = vma_merge_new_vma(&vmi, prev, vma, addr, addr + len, pgoff);
+	vmg.vma = NULL; /* New VMA range. */
+	vmg.pgoff = pgoff;
+	vmg.next = vma_next(&vmi);
+	vma_prev(&vmi);
+	vma_iter_next_range(&vmi);
+
+	new_vma = vma_merge_new_range(&vmg);
+
 	if (new_vma) {
 		/*
 		 * Source vma may have been merged into new_vma
diff --git a/mm/vma.h b/mm/vma.h
index 8f01fbc20fe7..dbcdf1431014 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -52,6 +52,13 @@ struct vma_munmap_struct {
 	unsigned long data_vm;
 };
 
+enum vma_merge_state {
+	VMA_MERGE_START,
+	VMA_MERGE_ERROR_NOMEM,
+	VMA_MERGE_NOMERGE,
+	VMA_MERGE_SUCCESS,
+};
+
 /* Represents a VMA merge operation. */
 struct vma_merge_struct {
 	struct mm_struct *mm;
@@ -68,8 +75,14 @@ struct vma_merge_struct {
 	struct mempolicy *policy;
 	struct vm_userfaultfd_ctx uffd_ctx;
 	struct anon_vma_name *anon_name;
+	enum vma_merge_state state;
 };
 
+static inline bool vmg_nomem(struct vma_merge_struct *vmg)
+{
+	return vmg->state == VMA_MERGE_ERROR_NOMEM;
+}
+
 /* Assumes addr >= vma->vm_start. */
 static inline pgoff_t vma_pgoff_offset(struct vm_area_struct *vma,
 				       unsigned long addr)
@@ -85,6 +98,7 @@ static inline pgoff_t vma_pgoff_offset(struct vm_area_struct *vma,
 		.end = end_,						\
 		.flags = flags_,					\
 		.pgoff = pgoff_,					\
+		.state = VMA_MERGE_START,				\
 	}
 
 #define VMG_VMA_STATE(name, vmi_, prev_, vma_, start_, end_)	\
@@ -103,6 +117,7 @@ static inline pgoff_t vma_pgoff_offset(struct vm_area_struct *vma,
 		.policy = vma_policy(vma_),			\
 		.uffd_ctx = vma_->vm_userfaultfd_ctx,		\
 		.anon_name = anon_vma_name(vma_),		\
+		.state = VMA_MERGE_START,			\
 	}
 
 #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
@@ -306,10 +321,7 @@ struct vm_area_struct
 		       unsigned long new_flags,
 		       struct vm_userfaultfd_ctx new_ctx);
 
-struct vm_area_struct
-*vma_merge_new_vma(struct vma_iterator *vmi, struct vm_area_struct *prev,
-		   struct vm_area_struct *vma, unsigned long start,
-		   unsigned long end, pgoff_t pgoff);
+struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg);
 
 struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
 					struct vm_area_struct *vma,
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index cce1ba78c57f..3a3a850d951c 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -101,9 +101,9 @@ static struct vm_area_struct *merge_new(struct vma_merge_struct *vmg)
 	 */
 	vmg->next = vma_next(vmg->vmi);
 	vmg->prev = vma_prev(vmg->vmi);
+	vma_iter_next_range(vmg->vmi);
 
-	vma_iter_set(vmg->vmi, vmg->start);
-	return vma_merge(vmg);
+	return vma_merge_new_range(vmg);
 }
 
 /*
@@ -162,10 +162,14 @@ static struct vm_area_struct *try_merge_new_vma(struct mm_struct *mm,
 	merged = merge_new(vmg);
 	if (merged) {
 		*was_merged = true;
+		ASSERT_EQ(vmg->state, VMA_MERGE_SUCCESS);
 		return merged;
 	}
 
 	*was_merged = false;
+
+	ASSERT_EQ(vmg->state, VMA_MERGE_NOMERGE);
+
 	return alloc_and_link_vma(mm, start, end, pgoff, flags);
 }
 
@@ -595,6 +599,7 @@ static bool test_vma_merge_special_flags(void)
 		vmg.flags = flags | special_flag;
 		vma = merge_new(&vmg);
 		ASSERT_EQ(vma, NULL);
+		ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
 	}
 
 	/* 2. Modify VMA with special flag that would otherwise merge. */
@@ -616,6 +621,7 @@ static bool test_vma_merge_special_flags(void)
 		vmg.flags = flags | special_flag;
 		vma = merge_existing(&vmg);
 		ASSERT_EQ(vma, NULL);
+		ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
 	}
 
 	cleanup_mm(&mm, &vmi);
@@ -708,6 +714,7 @@ static bool test_vma_merge_with_close(void)
 
 	/* The next VMA having a close() operator should cause the merge to fail.*/
 	ASSERT_EQ(merge_new(&vmg), NULL);
+	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
 
 	/* Now create the VMA so we can merge via modified flags */
 	vmg_set_range(&vmg, 0x1000, 0x2000, 1, flags);
@@ -719,6 +726,7 @@ static bool test_vma_merge_with_close(void)
 	 * also fail.
 	 */
 	ASSERT_EQ(merge_existing(&vmg), NULL);
+	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
 
 	/* SCENARIO B
 	 *
@@ -744,6 +752,7 @@ static bool test_vma_merge_with_close(void)
 	vmg.vma = vma;
 	/* Make sure merge does not occur. */
 	ASSERT_EQ(merge_existing(&vmg), NULL);
+	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
 
 	cleanup_mm(&mm, &vmi);
 	return true;
@@ -792,6 +801,7 @@ static bool test_vma_merge_new_with_close(void)
 	vmg_set_range(&vmg, 0x2000, 0x5000, 2, flags);
 	vma = merge_new(&vmg);
 	ASSERT_NE(vma, NULL);
+	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 	ASSERT_EQ(vma->vm_start, 0);
 	ASSERT_EQ(vma->vm_end, 0x5000);
 	ASSERT_EQ(vma->vm_pgoff, 0);
@@ -831,6 +841,7 @@ static bool test_merge_existing(void)
 	vmg.prev = vma;
 	vma->anon_vma = &dummy_anon_vma;
 	ASSERT_EQ(merge_existing(&vmg), vma_next);
+	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 	ASSERT_EQ(vma_next->vm_start, 0x3000);
 	ASSERT_EQ(vma_next->vm_end, 0x9000);
 	ASSERT_EQ(vma_next->vm_pgoff, 3);
@@ -861,6 +872,7 @@ static bool test_merge_existing(void)
 	vmg.vma = vma;
 	vma->anon_vma = &dummy_anon_vma;
 	ASSERT_EQ(merge_existing(&vmg), vma_next);
+	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 	ASSERT_EQ(vma_next->vm_start, 0x2000);
 	ASSERT_EQ(vma_next->vm_end, 0x9000);
 	ASSERT_EQ(vma_next->vm_pgoff, 2);
@@ -889,6 +901,7 @@ static bool test_merge_existing(void)
 	vma->anon_vma = &dummy_anon_vma;
 
 	ASSERT_EQ(merge_existing(&vmg), vma_prev);
+	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 	ASSERT_EQ(vma_prev->vm_start, 0);
 	ASSERT_EQ(vma_prev->vm_end, 0x6000);
 	ASSERT_EQ(vma_prev->vm_pgoff, 0);
@@ -920,6 +933,7 @@ static bool test_merge_existing(void)
 	vmg.vma = vma;
 	vma->anon_vma = &dummy_anon_vma;
 	ASSERT_EQ(merge_existing(&vmg), vma_prev);
+	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 	ASSERT_EQ(vma_prev->vm_start, 0);
 	ASSERT_EQ(vma_prev->vm_end, 0x7000);
 	ASSERT_EQ(vma_prev->vm_pgoff, 0);
@@ -948,6 +962,7 @@ static bool test_merge_existing(void)
 	vmg.vma = vma;
 	vma->anon_vma = &dummy_anon_vma;
 	ASSERT_EQ(merge_existing(&vmg), vma_prev);
+	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 	ASSERT_EQ(vma_prev->vm_start, 0);
 	ASSERT_EQ(vma_prev->vm_end, 0x9000);
 	ASSERT_EQ(vma_prev->vm_pgoff, 0);
@@ -981,31 +996,37 @@ static bool test_merge_existing(void)
 	vmg.prev = vma;
 	vmg.vma = vma;
 	ASSERT_EQ(merge_existing(&vmg), NULL);
+	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
 
 	vmg_set_range(&vmg, 0x5000, 0x6000, 5, flags);
 	vmg.prev = vma;
 	vmg.vma = vma;
 	ASSERT_EQ(merge_existing(&vmg), NULL);
+	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
 
 	vmg_set_range(&vmg, 0x6000, 0x7000, 6, flags);
 	vmg.prev = vma;
 	vmg.vma = vma;
 	ASSERT_EQ(merge_existing(&vmg), NULL);
+	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
 
 	vmg_set_range(&vmg, 0x4000, 0x7000, 4, flags);
 	vmg.prev = vma;
 	vmg.vma = vma;
 	ASSERT_EQ(merge_existing(&vmg), NULL);
+	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
 
 	vmg_set_range(&vmg, 0x4000, 0x6000, 4, flags);
 	vmg.prev = vma;
 	vmg.vma = vma;
 	ASSERT_EQ(merge_existing(&vmg), NULL);
+	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
 
 	vmg_set_range(&vmg, 0x5000, 0x6000, 5, flags);
 	vmg.prev = vma;
 	vmg.vma = vma;
 	ASSERT_EQ(merge_existing(&vmg), NULL);
+	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
 
 	ASSERT_EQ(cleanup_mm(&mm, &vmi), 3);
 
@@ -1071,6 +1092,7 @@ static bool test_anon_vma_non_mergeable(void)
 	vmg.vma = vma;
 
 	ASSERT_EQ(merge_existing(&vmg), vma_prev);
+	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 	ASSERT_EQ(vma_prev->vm_start, 0);
 	ASSERT_EQ(vma_prev->vm_end, 0x7000);
 	ASSERT_EQ(vma_prev->vm_pgoff, 0);
@@ -1106,6 +1128,7 @@ static bool test_anon_vma_non_mergeable(void)
 	vmg.prev = vma_prev;
 
 	ASSERT_EQ(merge_new(&vmg), vma_prev);
+	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 	ASSERT_EQ(vma_prev->vm_start, 0);
 	ASSERT_EQ(vma_prev->vm_end, 0x7000);
 	ASSERT_EQ(vma_prev->vm_pgoff, 0);
@@ -1181,6 +1204,7 @@ static bool test_dup_anon_vma(void)
 	vmg.vma = vma;
 
 	ASSERT_EQ(merge_existing(&vmg), vma_prev);
+	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 
 	ASSERT_EQ(vma_prev->vm_start, 0);
 	ASSERT_EQ(vma_prev->vm_end, 0x8000);
@@ -1209,6 +1233,7 @@ static bool test_dup_anon_vma(void)
 	vmg.vma = vma;
 
 	ASSERT_EQ(merge_existing(&vmg), vma_prev);
+	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 
 	ASSERT_EQ(vma_prev->vm_start, 0);
 	ASSERT_EQ(vma_prev->vm_end, 0x8000);
@@ -1236,6 +1261,7 @@ static bool test_dup_anon_vma(void)
 	vmg.vma = vma;
 
 	ASSERT_EQ(merge_existing(&vmg), vma_prev);
+	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 
 	ASSERT_EQ(vma_prev->vm_start, 0);
 	ASSERT_EQ(vma_prev->vm_end, 0x5000);
@@ -1263,6 +1289,7 @@ static bool test_dup_anon_vma(void)
 	vmg.vma = vma;
 
 	ASSERT_EQ(merge_existing(&vmg), vma_next);
+	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 
 	ASSERT_EQ(vma_next->vm_start, 0x3000);
 	ASSERT_EQ(vma_next->vm_end, 0x8000);
@@ -1303,6 +1330,7 @@ static bool test_vmi_prealloc_fail(void)
 
 	/* This will cause the merge to fail. */
 	ASSERT_EQ(merge_existing(&vmg), NULL);
+	ASSERT_EQ(vmg.state, VMA_MERGE_ERROR_NOMEM);
 	/* We will already have assigned the anon_vma. */
 	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
 	/* And it was both cloned and unlinked. */
@@ -1327,6 +1355,7 @@ static bool test_vmi_prealloc_fail(void)
 
 	fail_prealloc = true;
 	ASSERT_EQ(expand_existing(&vmg), -ENOMEM);
+	ASSERT_EQ(vmg.state, VMA_MERGE_ERROR_NOMEM);
 
 	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(dummy_anon_vma.was_cloned);
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index a3c262c6eb73..c5b9da034511 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -740,6 +740,12 @@ static inline void vma_iter_free(struct vma_iterator *vmi)
 	mas_destroy(&vmi->mas);
 }
 
+static inline
+struct vm_area_struct *vma_iter_next_range(struct vma_iterator *vmi)
+{
+	return mas_next_range(&vmi->mas, ULONG_MAX);
+}
+
 static inline void vm_acct_memory(long pages)
 {
 }
-- 
2.46.0


