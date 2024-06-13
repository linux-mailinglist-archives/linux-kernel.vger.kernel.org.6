Return-Path: <linux-kernel+bounces-213419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3078190751D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66E42825F1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B7D145B02;
	Thu, 13 Jun 2024 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CWaUNos3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K70wxvj/"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D9C144D18
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718288840; cv=fail; b=J115eO3enbrye9LkeZUofh5xYHbBcx2f4blvdTzCpwNA5iTDSvncsiJUYL99zT9XFAn6W9oqDH5MOopNxV/LU76CGSOSZsD5H3wYvU6PIs4u2ZhLbTu/SbKuZm8Bo88twg/VXzqEAVZhZ2nS11e5rClQA8b9e39vxkjovTjr3/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718288840; c=relaxed/simple;
	bh=y8uiszbAwFVaLW9e5OYtRdpkCfW/dQvuviQ0jsBDo5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q4UNaBBgluKzLFdYdUeC9+mYbZEi6BfDMupCHD4KaU1UMnOQGOov4FniTegi+OCFQtPE8Mz9b6I5pwm6xXpLPjMr1pXcDCCXy7MKXjkJGDKX3MK/5RUTp59+RWLpK/1LE6Pit8tibZgvnauRnx6iqRNK+0hlt1xwRb0C9yuA+o8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CWaUNos3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K70wxvj/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DBtRon011444;
	Thu, 13 Jun 2024 14:27:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=m9QxhsIUeWMnays
	XNVoa8ytZymnj6z9ruAoHCptuM54=; b=CWaUNos31GzV/BovDgvGdoHg1PvIx29
	xVUpg5cPqWGx2+VJ4Qzk3IzmZbqXNPmFB7FDhpNWbqD78iRiNwsxMmC6rP7MLT7n
	aWWxR7epWZQW2GR45wfYOPDof5+TXplJv6Ulrwx79nI9rhgFWEiyc+RRmccuqn3w
	OwnIhW8MG6ioo52zlkW9FKEEd0Lu5Rr00JTGqv5u0sGs4KRiL3fLKGkcPaVyIPVQ
	sAd7IjnDu9ZHB6/zGprX7gAgd5EM95Q04RJDh9/xgfKhnmkc6yyHd3ED8t/qQPDl
	Kw6E7D2L0+WRtlv5vbeuyH/YldNqkUymCXPfvcEIwQLCXDQZ+Cjf1HQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh1mhq29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 14:27:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45DE6JnG027051;
	Thu, 13 Jun 2024 14:27:05 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yncdwarrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 14:27:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRp0RjsY41aKD6gdGl67WkTjZ5c1I7/OJsv4GvG/y7PsEJo3Vu+uvoFmvsDF5oL/koFgGxzdKAUh2LvnND+oLgKcGwAu8EbYL1da6mcPEXqW4M+IRnQX/KZhfCb2L46tlwmnV6PsmJkoU5H+SyQCAmklfT1pD8DVGQP5SIepNmWaOrTUaynZxCyqn42c9+QjLJU9GaqQqC2S0pqIU1u78B5iKyFcW1va/aFaQwUrJlwUX7jiRGLELyMiACRiYTzWtazYwDS7eFmmEYhf0nHU/KJTl6qW5jPOO4SjRzUT5xmneZVVTy5kdEY721x1zOnHct8F2heiLqTtgEpNBICP4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9QxhsIUeWMnaysXNVoa8ytZymnj6z9ruAoHCptuM54=;
 b=Imt+Hr1LNQ/cvClWXc2hxGie7TmzfBNajXEa7d9jIXPgG5Hm93slZ9iKCo1pT3ig3lRQXPOcglpRc1VrKTB3IgjvYqTRpNkhOMeiG+3uNmm6di92dAL//iy8wLTWJBt6rmBLlBaENGhAHAxARrNXP0M4B/u1nh9Y9WGUgtzo42+CbIITFL7C/n1BoVD85rwFkBi9B/4+kW7SYt52iwytxual5jz4eVuX/LLRoX4mSIV5U/i4XBQWjiXDVcHfuln7sOyMbn6MHJZ5UsVFS/eepSKGq0RK9XkO7BMeAQHs7tlzH/NSMM6ZFfM3E+5NHaKgD23kttK2wGDpvyXJB+PtVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9QxhsIUeWMnaysXNVoa8ytZymnj6z9ruAoHCptuM54=;
 b=K70wxvj/mMGJiK11WtFVB6fLL/Mu8gcsDYeucmCp5YOwrVJvok3HfgrPvwrSe4LJMyWZU5eeJYK0VMq0pySXbIXqLxd1vEwlQJyj99yRNwe4hcQ3IX+Zv5mK0qBFXDzMlt9icDEpwGcsaSlqJdb5vSWrYQIEvR398I9s/3MevA8=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB6434.namprd10.prod.outlook.com (2603:10b6:510:21c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Thu, 13 Jun
 2024 14:27:03 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 14:27:03 +0000
Date: Thu, 13 Jun 2024 10:27:00 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org
Subject: Re: [PATCH v2 04/16] maple_tree: introduce mas_wr_store_type()
Message-ID: <sf7x5jprzaphl67s5qvw5wgpx3t5hpfmhx6wpvysswm66qwkjn@nit3os7x45xc>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org
References: <20240607185257.963768-1-sidhartha.kumar@oracle.com>
 <20240607185257.963768-5-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607185257.963768-5-sidhartha.kumar@oracle.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4P288CA0036.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::13) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB6434:EE_
X-MS-Office365-Filtering-Correlation-Id: a371db60-9574-467f-8744-08dc8bb4e4d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|376009;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?fUW0nTc8JpUQ72yFoEZ405bhZjttAdrBn7qwtEon2KHkw9PrPxKAL4Ik73VP?=
 =?us-ascii?Q?N9iDacs4h6Y6Okoxo6pRS+1nnP9R8ObjPxMARTwZYagl2SgiD1ztkHmbtqPW?=
 =?us-ascii?Q?8HRD3qvd89RexHa7zXio8qNkfKb5ScncGoJBblG15wLJ9ic3+GWEqaiax41C?=
 =?us-ascii?Q?QkqZNCFRX07DZQhtfI1UChZuQcX/8s4itrluwkGt1YL3/S5gaWMSQUThuOam?=
 =?us-ascii?Q?znrkIl6bMVZ+uetAZyMgj+GNMotgCjdSbIo4fVw4QWLp/wKcj/VOVVwGS+Dj?=
 =?us-ascii?Q?d9tw29L3udLs09/n5UXXNQwK7hWg8AiEa4a9hWQG5Nvspo3iYaBar5gZHN45?=
 =?us-ascii?Q?fLwI3uwvWg3EPuKT5b4WJieHbQTVougXIkELzqO8Vgjq02rtgoibvX7AsNrF?=
 =?us-ascii?Q?2Oap3FPJTWZxL//kqrgPQ6Kt6OGu1G8Y5lp7khMqyxQU/olR22Pa+0fYMomz?=
 =?us-ascii?Q?eB49vVlFE78kWQBCV3GyG3mI8mOWF5RBGC63bV/Xp+3T87E08eF8XKmjn+dR?=
 =?us-ascii?Q?cRK9iO+DQqv2LTcD4IGE3ZpgwYnFKKlLDxfFYU0QClHuwZRi7WqlxY2xjIvp?=
 =?us-ascii?Q?BV9FcF6cVZ70p0cRHioJrGxLkVKiPniB0EejLRqwW59gGzjBdxEQjHTGTWTJ?=
 =?us-ascii?Q?FbDPbhdwPyK35wzcQ82I45s1OGITr9uyIioHSuUh2AsVYLYn9daFw3UXpAQ7?=
 =?us-ascii?Q?blL3+qGXFFY/D4jBfsct3EnZcP7xWJM2Q7f6pa5ioww0h8jHDil7AIyYE94n?=
 =?us-ascii?Q?9/r0dqZgiHB73NlBQVCGPEi/YrZtvuBPses/4amNL99ciEUAF5XQWw93vUPZ?=
 =?us-ascii?Q?o56bXb/sARaZXkic+mXjdfnbWSeqYRZ5DkE7NkvOfoKer6gJcLctQ29+NA5T?=
 =?us-ascii?Q?R0Y1GpMUT6fSKs3GY0TINqliha3B2GbODpPfBcOnHzCwOWAtfyQIjofU56Rq?=
 =?us-ascii?Q?9U7LFhFKZuQCbjcZj6ZxOtGPoAKYY65INMv0uyCElsiagyz7Qcph12pr7+Db?=
 =?us-ascii?Q?UOZZiVGCXRDtKI0W6iKSBouUwpM7WOP3AA8YT3ksOBcFf+IS6Kiz0RoEn6mP?=
 =?us-ascii?Q?wfJQ4AcTGQJYwDP0fUErsxrwg2q99SXdFiEM7LuwDHjzJoYXxO6oSo/uhNS4?=
 =?us-ascii?Q?1TYOiuwbioC82sR9K8vvDnGcieFmBbl3GKwClRgylfK+vVVyzXjFIP4+39cq?=
 =?us-ascii?Q?rzSqIWT5Md8AydgYg0kTLg0SaMdiZ8H3T2CVZCjNwdRy6gYoiSKb8Uj9nMRK?=
 =?us-ascii?Q?7q42rbOUA600hteZpGYFtHzJFZbpt3gD0sHHRtM+a7+9ih2pn0BSYBFurc/U?=
 =?us-ascii?Q?RUQQIVbqvqT4tv20NqIHFIwE?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zgMyCk7Peaa8o2UwjvhtLFwQTz2S3dwIcjrAh8Pi4hrMx4oRXsqb+GZMxFtO?=
 =?us-ascii?Q?2fSpRJkxLFqHGFDI6p+hVeCDQP3MuI9se+qItuSnIcK8+/QbysTy3wuBerb9?=
 =?us-ascii?Q?NvofHVeNQirMjFkHwT0qLF/zt7lwlB03QCxgCIcFJWnG7X3Z3hvOvXNvlvcJ?=
 =?us-ascii?Q?Bz58WxTjqIV8Ep3Uxn75nHcCqajM3bZ4uz62pK8sY9H5NuylFwMSboyEYoif?=
 =?us-ascii?Q?eDGn4g6ETuRS7/XvpMPWZhLXceqRsmCqj59UxynfPkQPqj2QfXzLR0BfnNoE?=
 =?us-ascii?Q?e+NvD2oBIdzFuISU9NXyIXB9/U251lRYA2sVnqcvIL2XGsIkv1myL8lIN70n?=
 =?us-ascii?Q?vXV7eGzevQuQmG7AqcSgUj3+txGVq79xlKDj9zSrdz2rusGIGLYxHc+OHiTk?=
 =?us-ascii?Q?okdjiqZCeRXWECpQIwr+/kn/gCHCgFpN53Ql7iVx8fi6KVP+OXPusmlPkb0U?=
 =?us-ascii?Q?LJ2IOleykZzazQZHocBASyKZceEw5iXNiN4/GR220wwoqAcBriwhaax7c+7s?=
 =?us-ascii?Q?Ff5hX13qd5qTFjXqB1dHCl/wRu+uV2zpMbIhY7VJDuAVHRCJ2J4dSdRGDFsk?=
 =?us-ascii?Q?I/373gWHMZieVXKQlxjdSkzzQ9l1TwD2KJsEo4uCqjRJulOAM5TwqlCgNXpC?=
 =?us-ascii?Q?tHkhghJUNSSe0nckQM+WA0uKeuxH7Ne4tT9+FSLs2FQhyr4cPg/pTYVKqqQ2?=
 =?us-ascii?Q?ltRnzmf2/U+TCydwvloPHTuyOpNIki0PtRK7Tx79eztpsLQYpUNsRrl77LOc?=
 =?us-ascii?Q?vDpWqz7yoZqlX4yEICqZ7ISvbEi+Rnqoz4HJQgE8J9hhAwF66X3LfgPKN7zD?=
 =?us-ascii?Q?gfwbDrYg2M1HO2GxqSHMjf4AewOoubuDYnphg0826yyV4lgot9fbYjz4D198?=
 =?us-ascii?Q?mNi3oWTu3/g7DhWoJayoKXY/GMxL7yftxx9H5ibDBmhgPV3BhHISkkwvvGSA?=
 =?us-ascii?Q?impu35MysHNzba+8I8EUk+paybLVWTMy+163EOYIb+12yvpd0YKmlzViwRQF?=
 =?us-ascii?Q?oKYqfnLF7naN6CG3QSYRtSnbumeS1zWfRg07WA5rrf+ZSXFZDH1aRzxcvNYg?=
 =?us-ascii?Q?CjGg2RB0CE0oczYY8PDB47wKjycZ3CklykzC18j93gWI1FFJ3zGBi31+b9K3?=
 =?us-ascii?Q?LT3GHLmbxYD2BmOXWeQ39iJb7HJ5ngmRf0kCgkDfPHieILq1O4ODc1Wj3XFL?=
 =?us-ascii?Q?OkuAn59pJIpjTP2ULiX6ItbkJI6AAwULpFl/gN7nBr+X3AJD0Tlik/D3v5GH?=
 =?us-ascii?Q?mYzyMFP2SOY9CC+dScpl3BgquXsEy9Ch8u8Ka711WvvKSExve6f2PjZonrB6?=
 =?us-ascii?Q?YTKjgSGa+2B2Iiez6tEhpdvyh1RO7BEjuPMWSkJ3AwvUN6pRMcU9yDAq6lZx?=
 =?us-ascii?Q?Plt4hCTr8tX5iOlGDEgu2AnymRvbcuKUTFjSE4I4r8HRwTTJdmpRRoX54yk0?=
 =?us-ascii?Q?mHXa2Y7Ht4TMsghUrHCDWObmdrPyxbJFSUDJk9Q5RfkoCsGoil/SbJPpWg4K?=
 =?us-ascii?Q?kCSHC5L2A4Tl56aQ0BtqSWbiLeDLLXBFSfwp35EBfUckuhWF7f0CA+zu7naO?=
 =?us-ascii?Q?o99ITVIlz1nmG58S3Wl42oFAIinYLByBf3awo3EhUQf6qZnOJxPphhBOJJwy?=
 =?us-ascii?Q?wQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	95/1y3pAFStu00oDtLBqZCocomT0kYv5GVXONFaOOv8ldvQ1CS/9v5kKAFmLnrnzeA6qMetMTBE9lXjS/fXvzfEjRoISq0fgG5gljnMtVJgZ4iMMwIjXeL+5UnFT1yCQngnnezzToYZvbQSujryaCgpEfMfCKn2pe4/Ka2cT6s2s90QEpLKcmizlkyvtGRNRXrrAJL5mU0iNQ/+RKUqL7A/jMPdl6nNJLa6e3pRftkoQ0kTRdrT8iSXwfMI7tp5o2Bu39ZSvJfLxGtSqSRIwtXAMBfI5QpNqrJMckNQvEiFxqhwoq4uyqTY58347XiwIGrsqw7gVw9//GAEMBMx7NT54Z57tfXDmv+LEgHXZTtmOoGFgLC9ARPF7tcSx1yu5/BpuW1i3KQ6PvoOmZLzNwI3zI04RC9FQQw2lwjzsmgaJbu1qsMy8n2UV/tfDyiFbhmzO7TebvkALzFEcDiM2z6Kuc44X4J3/hXp0RtHzQQLUrE9tL1mViEi9I5QkwziLaH5IyTUeRoduLOsJfVGOENkBjlJntjICmBXpHEnEvuA1bdkEeuFGiWB/3nEQOKR9yfNr625sEqgOW6ASCvWJ+ETcuzAECEBCmEoHfA8v84g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a371db60-9574-467f-8744-08dc8bb4e4d6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 14:27:03.1397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vz4Hz+iafFOeH0+OJqRImt0rIAzaQKddPj1o3BVMJbCPFLcQ8njRKWmRq1fAZ8X4X5aqmDGvTT0L39UZ42gnNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6434
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_07,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406130105
X-Proofpoint-ORIG-GUID: nTVvLZ070bL9-PJdxLXfqC-EvqeBdlAd
X-Proofpoint-GUID: nTVvLZ070bL9-PJdxLXfqC-EvqeBdlAd

* Sidhartha Kumar <sidhartha.kumar@oracle.com> [240607 14:53]:
> Introduce mas_wr_store_type() which will set the correct store type
> based on a walk of the tree.
> 
> mas_prealloc_calc() is also introduced to abstract the calculation used
> to determine the number of nodes needed for a store operation.
> 
> In this change a call to mas_reset() is removed in the error case of
> mas_prealloc(). This is only needed in the MA_STATE_REBALANCE case of
> mas_destroy(). We can move the call to mas_reset() directly to
> mas_destroy().
> 
> Also, add a test case to validate the order that we check the store type
> in is correct. This test models a vma expanding and then shrinking which
> is part of the boot process.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  lib/maple_tree.c                 | 214 ++++++++++++++++++++++---------
>  tools/testing/radix-tree/maple.c |  38 ++++++
>  2 files changed, 192 insertions(+), 60 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 2558d15bb748..a7f585ed488c 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4278,6 +4278,151 @@ static inline void mas_wr_prealloc_setup(struct ma_wr_state *wr_mas)
>  	wr_mas->content = mas_start(mas);
>  }
>  
> +/**
> + * mas_prealloc_calc() - Calculate number of nodes needed for a
> + * given store oepration
> + * @mas: The maple state
> + * @entry: The entry to store into the tree
> + *
> + * Return: Number of nodes required for preallocation.
> + */
> +static inline int mas_prealloc_calc(struct ma_state *mas, void *entry)
> +{
> +	int ret = mas_mt_height(mas) * 3 + 1;
> +
> +	switch (mas->store_type) {
> +	case wr_invalid:
> +		WARN_ON_ONCE(1);
> +		break;
> +	case wr_new_root:
> +		ret = 1;
> +		break;
> +	case wr_store_root:
> +		if (likely((mas->last != 0) || (mas->index != 0)))
> +			ret = 1;
> +		else if (((unsigned long) (entry) & 3) == 2)
> +			ret = 1;
> +		else
> +			ret = 0;
> +		break;
> +	case wr_spanning_store:
> +		ret =  mas_mt_height(mas) * 3 + 1;
> +		break;
> +	case wr_split_store:
> +		ret =  mas_mt_height(mas) * 2 + 1;
> +		break;
> +	case wr_rebalance:
> +		ret =  mas_mt_height(mas) * 2 - 1;
> +		break;
> +	case wr_node_store:
> +	case wr_bnode:
> +		ret = mt_in_rcu(mas->tree) ? 1 : 0;
> +		break;
> +	case wr_append:
> +	case wr_exact_fit:
> +	case wr_slot_store:
> +		ret = 0;
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * mas_wr_store_type() - Set the store type for a given
> + * store operation.
> + * @wr_mas: The maple write state
> + */
> +static inline void mas_wr_store_type(struct ma_wr_state *wr_mas)
> +{
> +	struct ma_state *mas = wr_mas->mas;
> +	unsigned char new_end;
> +
> +	if (unlikely(mas_is_none(mas) || mas_is_ptr(mas))) {
> +		mas->store_type = wr_store_root;
> +		return;
> +	}
> +
> +	if (unlikely(!mas_wr_walk(wr_mas))) {
> +		mas->store_type = wr_spanning_store;
> +		return;
> +	}
> +
> +	/* At this point, we are at the leaf node that needs to be altered. */
> +	mas_wr_end_piv(wr_mas);
> +	if (!wr_mas->entry)
> +		mas_wr_extend_null(wr_mas);
> +
> +	new_end = mas_wr_new_end(wr_mas);
> +	if ((wr_mas->r_min == mas->index) && (wr_mas->r_max == mas->last)) {
> +		mas->store_type = wr_exact_fit;
> +		return;
> +	}
> +
> +	if (unlikely(!mas->index && mas->last == ULONG_MAX)) {
> +		mas->store_type = wr_new_root;
> +		return;
> +	}
> +
> +	/* Potential spanning rebalance collapsing a node */
> +	if (new_end < mt_min_slots[wr_mas->type]) {
> +		if (!mte_is_root(mas->node)) {
> +			mas->store_type = wr_rebalance;
> +			return;
> +		}
> +		mas->store_type = wr_node_store;
> +		return;
> +	}
> +
> +	if (new_end >= mt_slots[wr_mas->type]) {
> +		mas->store_type = wr_split_store;
> +		return;
> +	}
> +
> +	if (!mt_in_rcu(mas->tree) && (mas->offset == mas->end)) {
> +		mas->store_type = wr_append;
> +		return;
> +	}
> +
> +	if ((new_end == mas->end) && (!mt_in_rcu(mas->tree) ||
> +		(wr_mas->offset_end - mas->offset == 1))) {
> +		mas->store_type = wr_slot_store;
> +		return;
> +	}
> +
> +	if (mte_is_root(mas->node) || !(new_end <= mt_min_slots[wr_mas->type]) ||
> +		(mas->mas_flags & MA_STATE_BULK)) {
> +		mas->store_type = wr_node_store;
> +		return;
> +	}
> +
> +	mas->store_type = wr_bnode;
> +}
> +
> +/**
> + * mas_wr_preallocate() - Preallocate enough nodes for a store operation
> + * @wr_mas: The maple write state
> + * @entry: The entry that will be stored
> + * @gfp: The GFP_FLAGS to use for allocations.
> + *
> + */
> +static inline void mas_wr_preallocate(struct ma_wr_state *wr_mas, void *entry, gfp_t gfp)
> +{
> +	struct ma_state *mas = wr_mas->mas;
> +	int request;
> +
> +	mas_wr_prealloc_setup(wr_mas);
> +	mas_wr_store_type(wr_mas);
> +	request = mas_prealloc_calc(mas, entry);
> +	if (!request)
> +		return;
> +
> +	mas_node_count_gfp(mas, request, gfp);
> +	if (likely(!mas_is_err(mas)))
> +		return;
> +
> +	mas_set_alloc_req(mas, 0);
> +}
> +
>  /**
>   * mas_insert() - Internal call to insert a value
>   * @mas: The maple state
> @@ -5506,69 +5651,17 @@ EXPORT_SYMBOL_GPL(mas_store_prealloc);
>  int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
>  {
>  	MA_WR_STATE(wr_mas, mas, entry);
> -	unsigned char node_size;
> -	int request = 1;
> -	int ret;
> -
> -
> -	if (unlikely(!mas->index && mas->last == ULONG_MAX))
> -		goto ask_now;
> -
> -	mas_wr_prealloc_setup(&wr_mas);
> -	/* Root expand */
> -	if (unlikely(mas_is_none(mas) || mas_is_ptr(mas)))
> -		goto ask_now;
> -
> -	if (unlikely(!mas_wr_walk(&wr_mas))) {
> -		/* Spanning store, use worst case for now */
> -		request = 1 + mas_mt_height(mas) * 3;
> -		goto ask_now;
> -	}
> -
> -	/* At this point, we are at the leaf node that needs to be altered. */
> -	/* Exact fit, no nodes needed. */
> -	if (wr_mas.r_min == mas->index && wr_mas.r_max == mas->last)
> -		return 0;
> -
> -	mas_wr_end_piv(&wr_mas);
> -	node_size = mas_wr_new_end(&wr_mas);
> -
> -	/* Slot store, does not require additional nodes */
> -	if (node_size == mas->end) {
> -		/* reuse node */
> -		if (!mt_in_rcu(mas->tree))
> -			return 0;
> -		/* shifting boundary */
> -		if (wr_mas.offset_end - mas->offset == 1)
> -			return 0;
> -	}
> +	int ret = 0;
>  
> -	if (node_size >= mt_slots[wr_mas.type]) {
> -		/* Split, worst case for now. */
> -		request = 1 + mas_mt_height(mas) * 2;
> -		goto ask_now;
> +	mas_wr_preallocate(&wr_mas, entry, gfp);
> +	if (mas_is_err(mas)) {
> +		ret = xa_err(mas->node);
> +		mas_destroy(mas);
> +		mas_reset(mas);
> +		return ret;
>  	}
>  
> -	/* New root needs a single node */
> -	if (unlikely(mte_is_root(mas->node)))
> -		goto ask_now;
> -
> -	/* Potential spanning rebalance collapsing a node, use worst-case */
> -	if (node_size  - 1 <= mt_min_slots[wr_mas.type])
> -		request = mas_mt_height(mas) * 2 - 1;
> -
> -	/* node store, slot store needs one node */
> -ask_now:
> -	mas_node_count_gfp(mas, request, gfp);
>  	mas->mas_flags |= MA_STATE_PREALLOC;
> -	if (likely(!mas_is_err(mas)))
> -		return 0;
> -
> -	mas_set_alloc_req(mas, 0);
> -	ret = xa_err(mas->node);
> -	mas_reset(mas);
> -	mas_destroy(mas);
> -	mas_reset(mas);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(mas_preallocate);
> @@ -5594,7 +5687,8 @@ void mas_destroy(struct ma_state *mas)
>  	 */
>  	if (mas->mas_flags & MA_STATE_REBALANCE) {
>  		unsigned char end;
> -

nit: This new line should remain.

> +		if (mas_is_err(mas))
> +			mas_reset(mas);
>  		mas_start(mas);
>  		mtree_range_walk(mas);
>  		end = mas->end + 1;
> diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
> index f1caf4bcf937..1c68ccc1b475 100644
> --- a/tools/testing/radix-tree/maple.c
> +++ b/tools/testing/radix-tree/maple.c
> @@ -36223,6 +36223,40 @@ static noinline void __init check_mtree_dup(struct maple_tree *mt)
>  
>  extern void test_kmem_cache_bulk(void);
>  
> +

nit: This new line should not be added.

> + /* test to simulate expanding a vma from [0x7fffffffe000, 0x7ffffffff000)
> +  * to [0x7ffde4ca1000, 0x7ffffffff000) and then shrinking the vma to
> +  * [0x7ffde4ca1000, 0x7ffde4ca2000)
> +  */
> +static inline int check_vma_modification(struct maple_tree *mt)
> +{
> +	MA_STATE(mas, mt, 0, 0);
> +
> +	mtree_lock(mt);
> +	/* vma with old start and old end */
> +	__mas_set_range(&mas, 0x7fffffffe000, 0x7ffffffff000 - 1);
> +	mas_preallocate(&mas, xa_mk_value(1), GFP_KERNEL);
> +	mas_store_prealloc(&mas, xa_mk_value(1));
> +
> +	/* next write occurs partly in previous range [0, 0x7fffffffe000)*/
> +	mas_prev_range(&mas, 0);
> +	/* expand vma to {0x7ffde4ca1000, 0x7ffffffff000) */
> +	__mas_set_range(&mas, 0x7ffde4ca1000, 0x7ffffffff000 - 1);
> +	mas_preallocate(&mas, xa_mk_value(1), GFP_KERNEL);
> +	mas_store_prealloc(&mas, xa_mk_value(1));
> +
> +	/* shrink vma to [0x7ffde4ca1000, 7ffde4ca2000) */
> +	__mas_set_range(&mas, 0x7ffde4ca2000, 0x7ffffffff000 - 1);
> +	mas_preallocate(&mas, NULL, GFP_KERNEL);
> +	mas_store_prealloc(&mas, NULL);
> +	mt_dump(mt, mt_dump_hex);
> +
> +	mas_destroy(&mas);
> +	mtree_unlock(mt);
> +	return 0;
> +}
> +
> +

nit: This new line should not be added.

>  void farmer_tests(void)
>  {
>  	struct maple_node *node;
> @@ -36230,6 +36264,10 @@ void farmer_tests(void)
>  
>  	mt_dump(&tree, mt_dump_dec);
>  
> +	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN | MT_FLAGS_USE_RCU);
> +	check_vma_modification(&tree);
> +	mtree_destroy(&tree);
> +
>  	tree.ma_root = xa_mk_value(0);
>  	mt_dump(&tree, mt_dump_dec);
>  
> -- 
> 2.45.2
> 

