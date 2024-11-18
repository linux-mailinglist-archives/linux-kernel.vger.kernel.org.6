Return-Path: <linux-kernel+bounces-412394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C639D086A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 05:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43ACFB212B8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 04:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0173126BFA;
	Mon, 18 Nov 2024 04:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MFkn9OZd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W2ecK2U4"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438D4ECF
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 04:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731904327; cv=fail; b=tRN6+f5rwkwlA/j00y/MUqwgL7Nkmdpu46U4T6/dWtVSP4Gg/XbJn+f3/4BmK5vDVu5H3VU+ou3HJ7+f1GcHfMDPgAlOeZV6eXpqt9+JygN0S5KNFDbpKxuiPQCFlYQbp6jOoA2zL5sT7SBfB87K9WUG0/2j0v5VoxG5v7OYcoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731904327; c=relaxed/simple;
	bh=VO8XkQlfIRRT1DnYaGZO9yc5e1oPBou8NA/IuOb+9cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N/abQ7WR88JVRSI6XIpNfPG5mF4gVCt6rz88qo9qiI9QPOUMsG5zjGRudMxTQ0iTGIBEF/AJAJvKEcikniSlbojosubxrM5+QpcaBY8pc8UQQ0IEf3Lop+a1zn+9xYwF+UoskPBVw3w7ztcuUCjwuqXz4jzRwht418exgf1t16A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MFkn9OZd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=W2ecK2U4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI1D1k8020349;
	Mon, 18 Nov 2024 04:31:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=mrgCsNOQep04/sVAY+
	mXl7ylDaHsNS4Vk5fUdi/Q71g=; b=MFkn9OZd0H+b/P4vWVFHFUH2DYQENo2ARA
	Fv4PYePNZ011k1QG3ijnhBSS5ftUz402abla8i4LTGYbMELWrcxIiWIG0uGi+k7q
	jI2WCvvCLCK2JIgK3fbmA/DD4+rDVbBC5bnoWA9GW6qSU8r3h3NKXnLuJF4dmSkP
	sPNcJQcbD2XszhAuTj9MpqePHVFZq5KXpZlcJ7hLv0loe3BpGX9CAnD5gdH8xQ3K
	GKsJSvUVI3Yd2kC8g57eqf4OuF0vF+LPx7KhEoYML6aG3FamBh8ny+Zu+q6TYP0o
	C5JUUXF8qKfNJjEPEf6DoWor4VRPYCZ9LL/yb2FYXo9iHpj+PBmw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhyy9w2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 04:31:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI42PH1037971;
	Mon, 18 Nov 2024 04:31:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu6uv47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 04:31:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=etGilO+pOAsnNX4lekou+Gj5LxrrHaKTRZYN5dsml8BNWbpjOThdNcWYElYgdsOfbmJj5lsurYMUcBemd4u9VEx3SYYs0KcBN7zI/zZqWSui0g3atAUCWSc/jXxyLNQaZIeUNScAid8zTJyqIZEArBHN2v52bmwIdPJrqJwDurvqGAM9g9mVSrhOkVjmWlwBo/UY3+IhHf5Qs7C3mSYGu4pyC2Z8J2ov03vXedJdTSLM6yoI949rhc6ArIAnRn8VGgiTIJZVbnWYiq0CGAYxur44h0MSw/NaITaYeXX9s04P/F4lliFRrC5/5fPZSHh7X5c3fvFSiOH9kzVhu+gdJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrgCsNOQep04/sVAY+mXl7ylDaHsNS4Vk5fUdi/Q71g=;
 b=s8doQhLpVnBJUwRlmkNfIWRQ3OoAsoqQklUNvjnUJu+ovhFeyJ9Z10s8naAWSjViZy7nk6bnxqAW6kreOWH8vxCdzJ2WjjZhSFeQMZ3N0ohdBun50kOKT/WAhXAZjE8ytjio8EnRHhs6f9OFlYYF4FTVfrDkK+bIsrrF5nYta6IOs03pN5v0bbMJFamTRmRVH56gyasONDPIskfxQgr0xgkz6CzSmG5MqCB/IJdif4LtA5Y3s7TIuyn5TBXEDq236BuIWYionGpDZ7/hvcH3UfAUOW/ZDSIxeh+yczFeFsxaMwyRfdIr9VX7EzXoNGSfbVcGibjnGSzO2ESW77vKJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrgCsNOQep04/sVAY+mXl7ylDaHsNS4Vk5fUdi/Q71g=;
 b=W2ecK2U4l2Z/ArpNp9pEItUV9+m9a+iI0agc6s82GsZ6vKX3mLwih4xy9UychfjOccxRsFX/HPZ3D/Vi1yQfllcgFYd8iCVQDtcOMZQi2bNekUwDEcJ6cexqH88nI9zErPZ9cgtWXT/PgtxulJ6Bn9fUJc3xZexg7mkEaDGcdGw=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by BY5PR10MB4113.namprd10.prod.outlook.com (2603:10b6:a03:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 04:31:49 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 04:31:49 +0000
Date: Sun, 17 Nov 2024 23:31:46 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: syzbot <syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, jannh@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, lorenzo.stoakes@oracle.com,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] general protection fault in mas_store_prealloc
Message-ID: <maoud64nlrod22uir5u4los72fclf4fc7qqp6fry464gzwq6uy@5yntfhds7nj5>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	syzbot <syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com>, akpm@linux-foundation.org, jannh@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
References: <i2eu66jkrzkudfoa4dmxbxvvsb77pmneou52wg2con6nbdjuov@apux3q3iqjme>
 <673ac1da.050a0220.87769.001e.GAE@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <673ac1da.050a0220.87769.001e.GAE@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1PR01CA0085.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::24) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|BY5PR10MB4113:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a8e5ef4-d7ac-4d14-313a-08dd0789eb24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tus/mDhtbIZUN30buM/TF6w8Prii+yBMTLWukqF/RrvtIRycJTbSRe/GY1yK?=
 =?us-ascii?Q?KH9PqlllEHohSVXjMbjBfuxTf+FbeaiX1Yjl0aSfi6NhbmPNvaEWg2WoaNLB?=
 =?us-ascii?Q?PhE4Zgk7JRlKW8B5hq8j4ZOgPTClsmnTCqnyzOfXaMrZLGrTjIjQZUgDQsz7?=
 =?us-ascii?Q?SZwk8jboepDPN2ZH4LwhLP44AHwGPn0SawJnDCHrp1jADRHaaIcGRyR7GniZ?=
 =?us-ascii?Q?qgLu8LQCz6EZQvw6DBQgifLV7MQcX8cSoPTKK2X95wRxSxysiOPqQhj+TKK5?=
 =?us-ascii?Q?FhdwJQuDAuUZuICmswEh4AcJEUTqABvnASFMqZ0tNmURgDcJNOjG4fhHU8BK?=
 =?us-ascii?Q?pGg+hylm5ERVcGJ5VzoA5FK3LwVuRfgd6ATXj0EyOScpvxnFHlKY6omSfooV?=
 =?us-ascii?Q?m+Di0L7+O2TqX4U0JHsEil6QQmD0lrmEmwnb1A4Szt60bZVyVvaNOFG7Uwn6?=
 =?us-ascii?Q?79a4g5DNvovhUcsUOw2DQTuQ0ca3p05oniNCyoYDitaeziU5Ipzh00QqXpR8?=
 =?us-ascii?Q?BusuUInZo5LSm8x/4djd4kvLioMncbga0syo6yVQVRqC/S3kfByJzQaZ/onX?=
 =?us-ascii?Q?CurgE8rsOMGa9hRNQ9/f99gayqlkhb0eigrU4iihsUerypsutk102YohjNaQ?=
 =?us-ascii?Q?Y/fAhwKk7A3xkrjFWWMLKEFv1tH2H8dGlFZT2ZhzF1LbQJm+rSFFL676pc+9?=
 =?us-ascii?Q?HWeRmUAYKZJg0+ciprGWYrYxBawG0YH0yfim4FqYRSrsgUF5w3dCt5oywKHh?=
 =?us-ascii?Q?xIju2RzNk8Ohizy6DjLcKzFxyvzjwVaUUg+f4APYVKMAzpzOktCfuDM0hCMf?=
 =?us-ascii?Q?5FMvvZ8abRYxdlELRzS3b7prV4T4Cug/TTNEOTLs/vT6gh8LV6TZSgYl8sR4?=
 =?us-ascii?Q?7aQHwUX7i0Zfs/L9FqQoq6sIweEIo4Qur0WG/gTPauuyOITroQjeN6MAXejE?=
 =?us-ascii?Q?+yVCX81nOlYxBqrEAqSeq/m+pxhB0vJ+Hptqx8mkgon+TgeJ2wCmUJBkuJIV?=
 =?us-ascii?Q?4ZHX5JEbfQzXZ3m0vb6GEyDTF/j/pfawTS37w+zPc/aNUnvtsdqvT/G8M0CF?=
 =?us-ascii?Q?tuaUHbVQ/xQT4Muy7QCjvkbq4d0UnyIoxAUW0+LrCpfRzqcQ0O077ELCqSQ3?=
 =?us-ascii?Q?jzunqnkUczkAaQ2pQZoXaPIUKV4V/LU1xF3dDhWTGGM5cWv+12Qfoi9ETpUo?=
 =?us-ascii?Q?UrfTeA+GUOGimoXzOIbvbe6SHqWZgViLDLc/F+OXEWK1BMgEGI/NT71ohhCa?=
 =?us-ascii?Q?0yTvLkS7PLIl3GbiNwYL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FAuVXNq62jZzhw55lMLZZbfXhoeWdqO3PQRbVJ33cMSvZeVdwqUJwebo6yfc?=
 =?us-ascii?Q?g3hKEDxHyV1Ima/hVfCzmxoQMcJUuxetnTb3Ag74Zcu8xkl7hK2z4YzJzT5D?=
 =?us-ascii?Q?oixXlmob263qy8ro7lnBuUIzc5UQ30MwqDx6g2kkpRBECoa/8mS03oHWvUiU?=
 =?us-ascii?Q?8dLvlJiYd7U1L2e6kmBh+CAMO1090i0R7WW7MujTvSRJBGv3hayIZzpHZM4h?=
 =?us-ascii?Q?2ix38A5DDA39xIeEAgNvQ3QRGwfgicEjZTdbIeHiPOdKm75TBOE884smV/vM?=
 =?us-ascii?Q?jBddd4wgEO8IoXYH8T0c7clunaQsNhE0Zef9TYW6/PGzvdpOqE8aj5jja6qH?=
 =?us-ascii?Q?beWu2WDNDm9zvc6qcnlteLyDQXWgGWNCo6jDLyNdVgrALpKI0KavjQzBv7QQ?=
 =?us-ascii?Q?GXKV1jzjNkXRqyuQA8fmlUCIXcq1kqAM1LOEF3rrUSD5RoJ7Agw2lbF4odDG?=
 =?us-ascii?Q?eJw7tQMY51yqnpu6bw6WB1Zj6kPPEdQfJthRmymKhy8W3fap5McaDoD5e4b/?=
 =?us-ascii?Q?g8OSQ0UgHn0aoYOlDqImoL/1Mb1fz+JcLJ/aLIWZB3PM56e+blbY+WNZvM+3?=
 =?us-ascii?Q?rz6PjT97mHj/wGs0PbSWv6DLByjb4XYR7d7VPU0U+6R54FtTzSCMyibnLg+7?=
 =?us-ascii?Q?FZr+JOXd68FLeaKfyQZnp5c9E0PuDT2zTTBfRl7/p31IEvbH5dwSCYsno2pD?=
 =?us-ascii?Q?yxuqy5OmHhIJzkUqm6dEMUaFfA1cLHwtnDBS/RNbQVcDxjdxNsTCIjYU6qCd?=
 =?us-ascii?Q?9Ckze5grNdX0p6eV9aMTPLNiFL69Pm43Yi8yKgNOxaTnHuLDiGy7Hz2MKhnQ?=
 =?us-ascii?Q?AEejAM4lzbINGYLv+lPxvRLMHecm/s+JAJ6zsjcqfYGSO2PSsmZUJhjvGqxf?=
 =?us-ascii?Q?sm5btcPoywnNeAJkSoJhxwI1HWyjEfsa10ZQCKUtX0XnKFLn4kwHPk6Aw8yo?=
 =?us-ascii?Q?KomXscN+nZEoSClDvbATnGpWc8fsifvDd8CeMUxJmHVHnJtN/wJN1O28sguJ?=
 =?us-ascii?Q?xJxH3iXg+vBIKLeN4KCbJdcdGkD82KYqq1eHb/dgDPxqeNQH8a92hTaZ/hvQ?=
 =?us-ascii?Q?TCDfF3KRYsJvH4lNFi7AkTLcdVY74w6omPy4DXBeDXCDsPpZvXhdGOSs2RhU?=
 =?us-ascii?Q?ECpuzsVJ64+rzHJ5+di8M5pjbE0N44/vLddzei1yzFJa8gERzMaFuWeqinGl?=
 =?us-ascii?Q?f/uh6+c4nJq/TCvx1pLKxiHFdibQ5LcEKpE67d3BR6ax5C0NYq53JPpj9XGQ?=
 =?us-ascii?Q?GCVpVQk0JxiSR+gj5B+203Q+3HHuwtj2rTFxt0353os5AVLT3dsN2e+JsB5M?=
 =?us-ascii?Q?50pJ0P4+RKyGkCjOIhYI80NWtifsDK08/vkMlMI9nrwV/q7CdXOzVicxqDbE?=
 =?us-ascii?Q?yzow2byh7E0WIxuWxAXCBll4hiCb3Q/0bhlcCozrt6wlN9CyRtpZrYZlsS9+?=
 =?us-ascii?Q?YEu3soaCVk4ydLgu/y1J6M/2geVEOZwSmoPpYOuNV8mdPwCmiLn7x9WE4Ids?=
 =?us-ascii?Q?CY32Bq3pqV6pv/s2a/Yx/v6rDlFeQlTSGtf2yzJQ04uyZvCrcqoBVXoAEKil?=
 =?us-ascii?Q?Sat+UzPvVrYEMweVI9IISoEqCYwDt6ANa/dYPVSg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JuQ8VaOIu+k3ZjYqbK+NUQDt+TKLZ2oo3iIAoOQzP3vOD6x07LoRx/olrVpfR5e8G4wwy10h5nRzMi2PvuoP68TfW9K6pspOaB6Wg6fjlUgMdNZ9UUKDTU9EuYIiS+hzu1l/l+liA7lstkjEfj0hS3Grjfxa9qDeUPeu+Nr056dg+nOnRN5LMfXcNTXjuEEqJdBpEBveQBP9CbGV+Z9XT8b7x8BdoZmbiazzGDzpmK/e4sWWU+zOdiFiqUKeIfM4G6pHkgNGeBCpZqhP2eX2suZx502ntKjeLYtIsRC2nkMGuwjkA+JE+8GGvSshHmHWTqaJY8/XgoXhsScJSM/XlgLn3a53zLoZMJ2yL0eJPe5DFpyNsxuM+YxckW5a7Xv/OCi5dPXKO0xvBCAvm6eKXM2xLuHnrlius42HQtYYjrylgOKi3o7lMWzZLY6adMqVl8EVs57t+nH5g+9FFJSh5uDAK0BhPkOxoL1/BHABb1dMjMbB0bvao7OAWIUbkpKYuD0EJgIvlO/BK0wmj2D4XptNaPNVDDLmxhHuRqJqVFwBltI8hAB3+K0PGf8T2y9tY+TFlSHMUAwWF2eT0TcE0mJ3mM75b5qEWVEmPbfc0cI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8e5ef4-d7ac-4d14-313a-08dd0789eb24
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 04:31:49.4541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GlCJPbbKw5IJn/qpSXTPaC9YpTtRj10xvM8/lIiLOmWAUD9Q/bbDumFGAus5xVhBo2Vq7yypTF7R6iWYzQeTQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4113
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_01,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=930 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411180037
X-Proofpoint-ORIG-GUID: ZZvmJwSkfXao9OoVZ2IdWs0a49Jo3d9j
X-Proofpoint-GUID: ZZvmJwSkfXao9OoVZ2IdWs0a49Jo3d9j

* syzbot <syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com> [241117 23:26]:
> Hello,
> 
> syzbot tried to test the proposed patch but the build/boot failed:
> 
> failed to checkout kernel repo http://git.infradead.org/users/jedix/linux-maple.git/arm64_kernelci_20241117: failed to run ["git" "fetch" "--force" "9c3e06581107b2a32da6dcbdfdaa1a523995a2c7" "arm64_kernelci_20241117"]: exit status 128
> fatal: http://git.infradead.org/users/jedix/linux-maple.git/info/refs not valid: could not determine hash algorithm; is this a git repository?
> 

Try again..

#syz test: git://git.infradead.org/users/jedix/linux-maple.git arm64_kernelci_20241117

> 
> 
> Tested on:
> 
> commit:         [unknown 
> git tree:       http://git.infradead.org/users/jedix/linux-maple.git arm64_kernelci_20241117
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a1eb85a42cb8ccec
> dashboard link: https://syzkaller.appspot.com/bug?extid=bc6bfc25a68b7a020ee1
> compiler:       
> userspace arch: arm64
> 
> Note: no patches were applied.

