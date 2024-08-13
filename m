Return-Path: <linux-kernel+bounces-284950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F824950741
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 931251C22A69
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA2119CD16;
	Tue, 13 Aug 2024 14:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kNyFhbN/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DVVafohb"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AAF3A8CE
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 14:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723558363; cv=fail; b=J8YTkmMOrIAN1C3kZS3tifsIJp0bOwK2KeHoKoPjVBFFUkg/MhKrLfgXF7ZS1EFOJNlouirLx3DC16UmtN0GQyxXInFfe3ZH2LQbs+cXPyXpTLDIL/sNiEHpXiQgPzbYkMXsryAAfKI04MclYGX4lNY8Gxm4h+2HhYnoFvzJYms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723558363; c=relaxed/simple;
	bh=hQcEcieoBReLH0MpSoV7i4uAFCwNEjsNw9QEbUPTmGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gzBbxIw3Kb/tCKZbZlpUxjMof18XFLISCZcGxr1Mi15Ln8et3Pye3Kopp+JUsPjaXFoOVEO6wv/r1wAMvSvJrLc12LX/pG3AFcfovElrm7gY7WGYl9H1UQxr0iFjkcjACxtkMbCifxNONeTKzRh0iMRHEIHcsOfeyDdXGKAXdis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kNyFhbN/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DVVafohb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47D93HgQ005338;
	Tue, 13 Aug 2024 14:12:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=NWQn1Pux4c/wqJZ
	wfeY5CQMDQWO0aThGXaxQPDe0zGU=; b=kNyFhbN/LlHugLOeuUnfYMtbPdPmRAh
	EfuSNyKO0wq4AeDVonEg6tUh0Tgb7/Fu404qAhiCkEwJH3hA6JwSFtWv9uXpbmYP
	lOik+R0UipWUWVYRB4FwAAJfCWDG/3Q+82Qi46xEGGo5dmKtehZHAWiRSkXTK4R7
	CDgyrV6kjn/1BLCMqKowqhYMhzLGJ5rC7Ri37fBHymm8+xzI3FgTClxhb4puPDb2
	qJeY1zu0Y4wWW18j9TCnMAPeUmNB3yv2LcIVoo5LwM6uV6Zi1VFIyoPFjvXtu8CG
	ESvlgbgSI04bHmosefheln4TNX7BYwkTM1/5WFU5IwiAMoTnqQIbl/w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4104gagjyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 14:12:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47DDlphg003378;
	Tue, 13 Aug 2024 14:12:24 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn8guff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 14:12:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWYo/wiuGFfn4BsEcxihpd4E5zT13i4y9IYo3KoPKYmlAkNHP0jLZXioXAWIHf+JMeK6prD+LgoP8BiPuqY1/PmJzMK2wM4wGuTTZs7wxCsU3hXdQ5I5HEAkM7Bfx0YJjS8wUyBBGfSLjSRhjPdgSdnyE08TAB9Qe/TXBdilM0CLqVykwGdobGrkWZcb70It1Wjjbg+LKGrRjqz9+yKt9zxGUCqK/DpcHeX7IPJOACrS+b7xQasvucle9UDdl8bT8BHU/u5JOy8NLdGn+DRYiBAMpaIPL+i7RUbSYuf0ac+y3WqTIfVvPKy6uU60nWRnBTEdwPhPMliMmq0DbWd4tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWQn1Pux4c/wqJZwfeY5CQMDQWO0aThGXaxQPDe0zGU=;
 b=oTc4T7NyEu1c+IU7w59ZO+ZkS+u4sJU0jEdnHQvhzLkeNBeUGuA2Ob/zsIbUR8kwD48D6SDDrXl4My4LDlhzkq62vyD0SqASEySu0HmACNYYGRbVWSjxw697OvCrm+7d6rBB5M8TnRVx+SV0y2SXPikrt/J5bMo/S/miJnFW8zFk5vRp4W9oVldzXrnwv22ozZKJJ+jqdOxARtl5QpDErWT1QTTcVidJd+x482J1iSpYf7xm7/TKmNwWerTGf+QaUp5UCKVhGNV7+lDocEu+VmxZp+25tR4rFJzJKgVaAvbOLZeZV7Y6g4/NkeIbB2VEKL77gzjZXB/KpDC3sGLosQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWQn1Pux4c/wqJZwfeY5CQMDQWO0aThGXaxQPDe0zGU=;
 b=DVVafohbKWbO50aUY5ksPQzAnMcfLoymafjTA8caqmgncZmw3nToTRlghkFdWlODUPWszPIGPAOCVN88CQ/r4MC+VwH8jA+grGM+MNXMGz9u5oKnGHdkvrSRmhpKo98g5etJ18DW4s9pGK1UznOjuc44CvsS4211TiiYzQyLjbs=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by LV8PR10MB7725.namprd10.prod.outlook.com (2603:10b6:408:1e6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.15; Tue, 13 Aug
 2024 14:12:21 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7875.016; Tue, 13 Aug 2024
 14:12:21 +0000
Date: Tue, 13 Aug 2024 10:12:19 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org
Subject: Re: [PATCH v2 2/2] maple_tree: add test to replicate low memory race
 conditions
Message-ID: <man2xr526g3dhxgcpyy6hsddndjqhu2wyunqquq52jrlrgragj@7jx73onbnqig>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org
References: <20240812190543.71967-1-sidhartha.kumar@oracle.com>
 <20240812190543.71967-2-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812190543.71967-2-sidhartha.kumar@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YTBP288CA0025.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::38) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|LV8PR10MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: ca41f8dc-c955-426b-7608-08dcbba1f278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2G+CbwaMjXUmiWBc5veNL6tuWiqhN/3ETle2eBmpkkZuwUQnbrC+xvXTWvyq?=
 =?us-ascii?Q?N871WXuFWrvk7w9P11lMM2lD/e7ZJ0x7bsQ/ia9+IcYBQj3PZp7a/lHBtIvU?=
 =?us-ascii?Q?jpVKXBwTliDmMP5OGYTF5R/Ihet938jVK23YCtctchmv0iFfLz+zb6rRiA2w?=
 =?us-ascii?Q?z3ncXV7yN9gs1zMeo4g4HftRsU8xANsY9NYwZ8bcwY/g59sCPIbrSI8PfnHq?=
 =?us-ascii?Q?PHh1J8mVub/stZVXJDJgHoWII8EHP0AZvyPqixyt1YdA3NsMlRQTvfPB52o4?=
 =?us-ascii?Q?2saFkji/NyHTlrRPgFXP7PcWJtyn2Q/XsXofuoSMZgOhgg59YO33E/RovIqQ?=
 =?us-ascii?Q?4T9wksf+Bs/G0WdOKy5gCu42YqKFLgIBYPa+0MaaXcaktA8zW8b3xlOhJ4mc?=
 =?us-ascii?Q?JV4QpRjG3Xt1t+Fa63sy4HiHnYi1jXT7glUw6M7U3Vy6UYOFUm/1FCM+Nkh1?=
 =?us-ascii?Q?nLngyU5Ak1TJEXnMfz6v18ZHCk6XGSXShkTYbBVNuSGXUjm8zxEGGMHQ1zh3?=
 =?us-ascii?Q?12LEHQhtvm8FSDy/7hulIlJYrLCTJFy66NFXxcUkinS/LMMLqFwQMOu9L2Ft?=
 =?us-ascii?Q?Vww0vkEjveZxBrd7SN4QyXrmBhTy+hIJiIl8cBqlSCz+2JAzTDy5nDglPMtA?=
 =?us-ascii?Q?EFd0FKgg0rb2KlkS2b4Eket6I0XRVnUuzzhK+4Y9pjKZJQs+vcWdMmVOL+NA?=
 =?us-ascii?Q?FXT+x8u3Z/KhCN6HmDhOq9kuaJ0NwUcWpyYrN89GtaUkI7pX5EUQ706C8VyQ?=
 =?us-ascii?Q?HaeYcH7+Ry9kzrEi6C/CQtC1dpMx+ciwrh3pNqwbyRRFfaFRgayfmL5v57vf?=
 =?us-ascii?Q?5fuO0kkN+R8C16Xg6jfwzkDUezjJRzy6qhJPEd99MqMFNNXSHw42iVK/AyS0?=
 =?us-ascii?Q?IVI7+FqHoUSs1HzhqESzity/eA7sPdweVB0W/hwKsev2ewxDRkfoEMmvVNhy?=
 =?us-ascii?Q?WuggdOspHv4YuAynLlyY1uHILnrzvW+P6Ru3rkKN/LVWP5VmykicCpgGh/Hn?=
 =?us-ascii?Q?fvUY87wINzzMbWQkhP0a8J+k9C97v7EBAx5EcH3Xpt9Qv+bQ9uyD8LKT+yAF?=
 =?us-ascii?Q?zooJnGZAxuvKcXGtM7uGMJasQ1eHZs2+TU9F7NON4eoPy9Nprqspjdy9ulA3?=
 =?us-ascii?Q?BQyZ7kk3HAl61DnGd2gVngvG94NTmTOtZ6qcCkTt9flOAUR7MTKzoPlaGobC?=
 =?us-ascii?Q?/yBsPR3CjpeXTMNrnBaZpUmiOBUNVg9EBWcFASTRACh/SXm3jxhoKE1LbPZR?=
 =?us-ascii?Q?dg5KMHVJ/5Qli9NhxAFE/vAxZK65WFijqMwVIU3E/2jvHSLQRyR18HnRn3w/?=
 =?us-ascii?Q?CPmvrKPkrjVJ8aITCSf0UKvRo/NG8caFF4NLcekYHwD/Qg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VtRqR7+VgEBleWPqJVHGmaCgJUEhQrnJlKd/M9iIFUP83jTCJQhll865B3bE?=
 =?us-ascii?Q?lyimp4iMYM6gWgz/QGNbbY8BfOiXAca4fvA80+46vqnHSz3oyNW3GnLu81dJ?=
 =?us-ascii?Q?o00t2E15a3d66T+vSh1rZeeBDkUrl7f9BR4/hqZp9CS86I/3F2XE//uTRH2r?=
 =?us-ascii?Q?EqeQJcZf8GnKRZ7/q63gHRNMlr9gw/Z150xNr4sm2ILMNS1sPMFAOVdYRW3r?=
 =?us-ascii?Q?uJF6REeSlkYd8WDkO0x18rGUQ+qrkAWJWotTF4h7UPlrRX/5VgEtKRXf3CTH?=
 =?us-ascii?Q?A5mdShNXVe8QkoSiRt9beawbTqrKg5cBSXvoeJGQuWTBmk9QOWC2gn9bwECW?=
 =?us-ascii?Q?bLlnox3EX7CqL77zfNqJVxmPbTOmfX26mL0ShtYI7REXVpSQut0kKTkvlZKD?=
 =?us-ascii?Q?edajsQju0zUPg+pUsD67Tay+WQ7Z03Vm+CGWlU3vQnbW2kb/fRq5N6vVVMgj?=
 =?us-ascii?Q?jt/z5nzAqLejQdxANXTynkhReyFBuFuPtnXrKsRevLnEGlQZ5DwlZxRC1LMQ?=
 =?us-ascii?Q?O3kvCREhQgZCLHWMnyKCFFEkdtXVaR1/H+R8ARoYNrnvpQ+8b8URxUzFEkbG?=
 =?us-ascii?Q?dxnPf5MqNC4YPOCA5uOeQwXCsy7Yn7x7KdwNDzF3aKlFIbbje71VRA7FBSDm?=
 =?us-ascii?Q?I+HWPFxo3IBnekddq2FtBgf4Lg5eH4zQiLRv/VZcY+3/1AL056iMEsAKf7cH?=
 =?us-ascii?Q?+AZIezIDDbaGiwp09D+VGcDkZS9aEsT6bp+lH2jnl1RD6UbnJ0fCeZxWJ2YJ?=
 =?us-ascii?Q?wc1o9Kl+VKhK33S8vVxDQNlJI9PqftCIgGbDMOyKltmrjZSO7iaBwC08EnG3?=
 =?us-ascii?Q?9106ZbcAkwcv4knZnz7IA6XIgXKV2r88AHP9Dpinzq5qLeYyxWTJK0Dlm+6r?=
 =?us-ascii?Q?JmmYSOq1wZ4ASI6CzjiCvaXqDIWZbjGnHWW03tdK3b+fWlCAi0tE4ZkNl4FK?=
 =?us-ascii?Q?IhQTQl7lySkqddIBDTlTPUCkCrEhf9J0/aV3aczcXXxtM0dtgKAt8Ysdx/ub?=
 =?us-ascii?Q?ar6R56algqzmSm/NEB8StyMdTzBtrl21H6+CiIEKO9yv0XOJeM4CvAf7xZDN?=
 =?us-ascii?Q?SOaksp22h0GGGmg3VKeTLBFW4RGxaqA7qvmYVyUR+8H2q/iauxCU16HdzODJ?=
 =?us-ascii?Q?6OBLxmcX4zJtK85VPsFF4+j8SV5M3iaiuCJT0SVxA8nE+kmtlFX/uDZB82Eg?=
 =?us-ascii?Q?5EWH576xSjbhea1yYJZlsi2Bt5ytbTaVRRLHLvcjdwwPrtbPe9c0YKFMT0aU?=
 =?us-ascii?Q?mBEB+4jM/7CmdjccMoixanCjEi4mio99Su6tINRAlx583PFn0hEsNcIRJIjZ?=
 =?us-ascii?Q?21gObX4qOUknfR4cKKQVbnN4hegkb/rA70+f0+pi4AXQF6QfyVEX67gT6sew?=
 =?us-ascii?Q?J2ITsqywYKs4yAERVfo2ZWhABdcdudnmyusTHbBjbnQkJMMyH/FaQ7wCPE7J?=
 =?us-ascii?Q?M5eHwIcyNS7g9T1YoO7gQp6s3nlmfo+DTp7W863LVtbxWG6P8UGh3GLZxzzx?=
 =?us-ascii?Q?Xo9T97w5+ndcuCN0SG3mhAmLJgikliLVtH7XXU/6G31ZFBtEevSAMmeLZ0YR?=
 =?us-ascii?Q?oSmlTpxlkkQ2HYqiVaQkGUMFHkTi5BHflfnx/hCq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	17B5nyfQ3Y0SR3r7Vy6nqBrsQ56YVDIPyGt9jZVZ6GOfOLfElmw1ypMhZlkJtCfwllD/FPHVpLckt3hlyiEQ6hGSVFo+LtiNtOCMU/jSlcssd2J7kF+Qe4DrBuGScgFF7It+VaEse8qwFbaB8lYKx0/baQGnsmPPddnT0ukLNHDzE7K1D/sKAmGRXSmREGCQS+W0eq9x6zTkcZBeFb7PY0b/l8ltqM+CXfHh/6JNp92umdb4uyYIv8LnrQAPZrthTBADJjTksyM0qVc55nfSAy2LFWP/jU7gGzxwnfvMte/WD7xvV8D5AIuxEN4CeL7MBO6l+KU6hsqt1t9eRYQYg0RVEgxCM+ugov3ueu/vB+fUb8/reWh/NiDPbuoVHRprzb/2zlQF5yRVM8DIFnfkBEzaaoBjYyXt6P59Ibaarh3GL/oUcv+tZq6a68E06JjN7L+J365Z8viqn9Arikd4KuwvGMb0yU7lPh+vL0uZJulg0IcJ6oEyLAGz841eJ3TRpkDVnmrLyNqyDn8xMX+oDN+RzjQZqS55/5d/+zqBCVQ3FEHboYdYqiMXx3XAO7paeRG/0Q/qfTNTxBXfVnCJho017XTmEcEnHJ6bxzGB78E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca41f8dc-c955-426b-7608-08dcbba1f278
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 14:12:21.3009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XljqWRzc6deW4QDxSwVuyOlfGYCP7qYo/eSG5W0gAeQdzHGbETRnaAUigr5EPIuOM4wMSq/S22xhdUPGnTZpfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7725
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_06,2024-08-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408130102
X-Proofpoint-GUID: r0MO0MV2yy7BSJ_Dg2Tu3ZsjxqGdBlZp
X-Proofpoint-ORIG-GUID: r0MO0MV2yy7BSJ_Dg2Tu3ZsjxqGdBlZp

* Sidhartha Kumar <sidhartha.kumar@oracle.com> [240812 15:05]:
> Add new callback fields to the userspace implementation of struct
> kmem_cache. This allows for executing callback functions in order to
> further test low memory scenarios where node allocation is retried.
> 
> This callback can help test race conditions by calling a function when a
> low memory event is tested.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
> v1 -> v2:
>         - change test name to check_nomem_writer_race()
>         - move test down in farmer_tests()
>         - remove mas_destroy() from check_nomem_writer_race() as its not
>           needed
>         - remove using mas.index and mas.last directly through
>           mas_set_range() and MA_STATE macros.
>         - remove uneeded mas_reset() in check_nomem_writer_race().
> 
>  lib/maple_tree.c                 | 13 +++++++
>  tools/testing/radix-tree/maple.c | 63 ++++++++++++++++++++++++++++++++
>  tools/testing/shared/linux.c     | 26 ++++++++++++-
>  3 files changed, 101 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index b547ff211ac7..14d7864b8d53 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -7005,6 +7005,19 @@ void mt_set_non_kernel(unsigned int val)
>  	kmem_cache_set_non_kernel(maple_node_cache, val);
>  }
>  
> +extern void kmem_cache_set_callback(struct kmem_cache *cachep,
> +		void (*callback)(void *));
> +void mt_set_callback(void (*callback)(void *))
> +{
> +	kmem_cache_set_callback(maple_node_cache, callback);
> +}
> +
> +extern void kmem_cache_set_private(struct kmem_cache *cachep, void *private);
> +void mt_set_private(void *private)
> +{
> +	kmem_cache_set_private(maple_node_cache, private);
> +}
> +
>  extern unsigned long kmem_cache_get_alloc(struct kmem_cache *);
>  unsigned long mt_get_alloc_size(void)
>  {
> diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
> index cd1cf05503b4..ef5b83cf94ea 100644
> --- a/tools/testing/radix-tree/maple.c
> +++ b/tools/testing/radix-tree/maple.c
> @@ -36224,6 +36224,65 @@ static noinline void __init check_mtree_dup(struct maple_tree *mt)
>  
>  extern void test_kmem_cache_bulk(void);
>  
> +/* callback function used for check_nomem_writer_race() */
> +static void writer2(void *maple_tree)
> +{
> +	struct maple_tree *mt = (struct maple_tree *)maple_tree;
> +	MA_STATE(mas, mt, 6, 10);
> +
> +	mtree_lock(mas.tree);
> +	mas_store(&mas, xa_mk_value(0xC));
> +	mas_destroy(&mas);
> +	mtree_unlock(mas.tree);
> +}
> +
> +/*
> + * check_nomem_writer_race() - test a possible race in the mas_nomem() path
> + * @mt: The tree to build.
> + *
> + * There is a possible race condition in low memory conditions when mas_nomem()
> + * gives up its lock. A second writer can chagne the entry that the primary
> + * writer executing the mas_nomem() path is modifying. This test recreates this
> + * scenario to ensure we are handling it correctly.
> + */
> +static void check_nomem_writer_race(struct maple_tree *mt)
> +{
> +	MA_STATE(mas, mt, 0, 5);
> +
> +	mt_set_non_kernel(0);
> +	/* setup root with 2 values with NULL in between */
> +	mtree_store_range(mt, 0, 5, xa_mk_value(0xA), GFP_KERNEL);
> +	mtree_store_range(mt, 6, 10, NULL, GFP_KERNEL);
> +	mtree_store_range(mt, 11, 15, xa_mk_value(0xB), GFP_KERNEL);
> +
> +	/* setup writer 2 that will trigger the race condition */
> +	mt_set_private(mt);
> +	mt_set_callback(writer2);
> +
> +	mtree_lock(mt);
> +	/* erase 0-5 */
> +	mas_erase(&mas);
> +
> +	/* index 6-10 should retain the value from writer 2 */
> +	check_load(mt, 6, xa_mk_value(0xC));
> +	mtree_unlock(mt);
> +
> +	/* test for the same race but with mas_store_gfp() */
> +	mtree_store_range(mt, 0, 5, xa_mk_value(0xA), GFP_KERNEL);
> +	mtree_store_range(mt, 6, 10, NULL, GFP_KERNEL);
> +
> +	mas_set_range(&mas, 0, 5);
> +	mtree_lock(mt);
> +	mas_store_gfp(&mas, NULL, GFP_KERNEL);
> +
> +	/* ensure write made by writer 2 is retained */
> +	check_load(mt, 6, xa_mk_value(0xC));
> +
> +	mt_set_private(NULL);
> +	mt_set_callback(NULL);
> +	mtree_unlock(mt);
> +}
> +
>  void farmer_tests(void)
>  {
>  	struct maple_node *node;
> @@ -36257,6 +36316,10 @@ void farmer_tests(void)
>  	check_dfs_preorder(&tree);
>  	mtree_destroy(&tree);
>  
> +	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE | MT_FLAGS_USE_RCU);
> +	check_nomem_writer_race(&tree);
> +	mtree_destroy(&tree);
> +
>  	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
>  	check_prealloc(&tree);
>  	mtree_destroy(&tree);
> diff --git a/tools/testing/shared/linux.c b/tools/testing/shared/linux.c
> index 4eb442206d01..17263696b5d8 100644
> --- a/tools/testing/shared/linux.c
> +++ b/tools/testing/shared/linux.c
> @@ -26,8 +26,21 @@ struct kmem_cache {
>  	unsigned int non_kernel;
>  	unsigned long nr_allocated;
>  	unsigned long nr_tallocated;
> +	bool exec_callback;
> +	void (*callback)(void *);
> +	void *private;
>  };
>  
> +void kmem_cache_set_callback(struct kmem_cache *cachep, void (*callback)(void *))
> +{
> +	cachep->callback = callback;
> +}
> +
> +void kmem_cache_set_private(struct kmem_cache *cachep, void *private)
> +{
> +	cachep->private = private;
> +}
> +
>  void kmem_cache_set_non_kernel(struct kmem_cache *cachep, unsigned int val)
>  {
>  	cachep->non_kernel = val;
> @@ -58,9 +71,17 @@ void *kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru,
>  {
>  	void *p;
>  
> +	if (cachep->exec_callback) {
> +		if (cachep->callback)
> +			cachep->callback(cachep->private);
> +		cachep->exec_callback = false;
> +	}
> +
>  	if (!(gfp & __GFP_DIRECT_RECLAIM)) {
> -		if (!cachep->non_kernel)
> +		if (!cachep->non_kernel) {
> +			cachep->exec_callback = true;
>  			return NULL;
> +		}
>  
>  		cachep->non_kernel--;
>  	}
> @@ -223,6 +244,9 @@ kmem_cache_create(const char *name, unsigned int size, unsigned int align,
>  	ret->objs = NULL;
>  	ret->ctor = ctor;
>  	ret->non_kernel = 0;
> +	ret->exec_callback = false;
> +	ret->callback = NULL;
> +	ret->private = NULL;
>  	return ret;
>  }
>  
> -- 
> 2.46.0
> 

