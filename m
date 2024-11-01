Return-Path: <linux-kernel+bounces-392107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E979B8FCA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 485C4284298
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 10:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5948E17BECA;
	Fri,  1 Nov 2024 10:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DIQx3o0U";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tkM4+h3e"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A9C194ACD
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 10:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730458507; cv=fail; b=uX9NWM3oQHNFRp+4B0yLvBvoX/ch8rUlAbD9G1yY4ZYzfhLV2XyOZKk0MLRa5qtBTGBd1xkODElpwqPdEH9rL21IVNucGBlRdy0u+wIJmgFZkGtvBMD4ZQ9iXnmbigwiyOua6bm/JoRDhLErzUTyOuwgS1IQXzXsSrq1z+Y8n7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730458507; c=relaxed/simple;
	bh=L3z+NLi3Lu7CmOVmzfSxRwQf64xTdTzeDjXRN0xVJBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pXxK1itQl/bwWiSeKTSbT12904rXZblOHXT0hnYm4HNReJfbwZlAv8dw3PFXiqRjYcHxbhtESjBZp2/m1T4Moz0WRK6l8GtS7KAoK2W8Jv/BEtV5b1bXd+DC8+x4dPNx9r8YqknGleRWcuV0Z+NcyBYkDEjojPOWWNTsM+2Qa+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DIQx3o0U; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tkM4+h3e; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A18fet2017198;
	Fri, 1 Nov 2024 10:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=JF5aFCHpqmabS8ahc7
	X6IY2uzwPUUectAtIfwmYEubY=; b=DIQx3o0U9YbvEWwyKsSOcuuc5J1xiwZ1aq
	liduEBe5Lz4ff7nHO7bcNoHnEKaM+7y2aXAYNyK21uzQ2LkvLOhGNMMxMq9wVRIH
	WsnBmy0aCq0bsUBn6ns5q9b/g/GWZTWgQ4RXpiJgJND5TXk4nzEu2MYaRr4YTsfk
	UVhEd8Xd2TG+0FI2MJ2hd+XUqAldGWV1tZCRaThHD9u5P+qD/YsWmADk/PRRHLld
	ujz5alYLH0XD2MQmWExBzNz0yGrdaxvIXYBrRVahRa5CaAnGMnM8xXv6GdpSxaGd
	M0FVfDs/uk55btFgQlYgUine3BmacVZ8imoW2XHqHzdG1JD4nXYA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grc941yy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Nov 2024 10:54:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A195vT7011982;
	Fri, 1 Nov 2024 10:54:52 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnage4em-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Nov 2024 10:54:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ql8o7T78vesHfnaTafW41tJVLYugZBvW3wHzaRdb29FF90RRDF5DhrWH8PxaucwUWu/RigqFjNCUVMzKWGHj5mGFt8NZyG21tgbZzAOBYU+OacJOKrnd/Yaq7V+1FYMJ35UWTG1NRrkeXv12u8xHMtRBmP0XmppSLzmvCCbSxC81q0Bg+e4g0GMV1Vo3ruBaTx4ZorHTwb1pZdh+aQFm636WVB32Kv4vywVbtWKYvwH/4pPU1I03ooTgRCKeOPas7Um89303+rV39rv9pF8l+THfS6p7TTpA5U8JSrP9VUDRQ8POSqwXkkR+nZ0Suvd+sSc7+RadcRqy0X9S0pxHzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JF5aFCHpqmabS8ahc7X6IY2uzwPUUectAtIfwmYEubY=;
 b=FRCTAg8Slqf2CgjTbIjNwwpJQzzpzYmelhxEtU6s0DFEYJMFGN9ow5/XoGyI1GOUpwztFoZTEXAahMZdUVCvTGE/x9MXbUjDgebQuf4E3xbxzC78TNQR6Y72VSBrErnzaA/z0ZNC1BK80LXBEOlkEXFlSWNKORHak0ei9HhuUDghRSJy0OaRIht/K01KlKaWpUSeR+5vo4KecIkNsydtibd1hk0xxdqW5jjc6STD+zD3wsivkoP6+1uT0TjT/L38CMETC8tJXnJcdPIqSy9BcrfKvi6CTNMu3559el16TsPfXL3dpwzVP/hFfCxAZjEHyNedUxiZwEEmyT8a+81Iug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JF5aFCHpqmabS8ahc7X6IY2uzwPUUectAtIfwmYEubY=;
 b=tkM4+h3epuem7Lj6yxe69fNwlsdh50jub1R2ky8HKDttaHRjMEFcv5060DLfK1YzR58uxg5WLoYQ7bbD1nfWmZkMx/wx5D+CHAVDAtIS45iDr6w/aXgF/8pZqehlaZy3EmCKjxzf99QFiDSffFlDl6MCTEEi1tM8J9WRoMAEmuo=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CO1PR10MB4401.namprd10.prod.outlook.com (2603:10b6:303:94::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.26; Fri, 1 Nov
 2024 10:54:50 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8114.020; Fri, 1 Nov 2024
 10:54:49 +0000
Date: Fri, 1 Nov 2024 10:54:45 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2] vma: Detect infinite loop in vma tree
Message-ID: <38362bee-a641-4815-9585-8cbcd8f60b81@lucifer.local>
References: <20241031193608.1965366-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031193608.1965366-1-Liam.Howlett@oracle.com>
X-ClientProxiedBy: LO4P265CA0298.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::8) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CO1PR10MB4401:EE_
X-MS-Office365-Filtering-Correlation-Id: 683d01a4-20e2-428a-dff7-08dcfa639b42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rUuUtOm6w1D/GwqMQRnmheldm9KYeTHrM6ozrInLF21peQtn3qtJqhQOpWbW?=
 =?us-ascii?Q?CrM6xdGpx0ik5qMcMyomWc5WcI1dSFzSkx1PXKeo6WaRK5+FJqqRYBlUxjEi?=
 =?us-ascii?Q?i68P+T70hoB6jHkrBReYZVMlAaEih8qbM+VEJ5A2NDSE2qtAteTfKwKDn+1j?=
 =?us-ascii?Q?Yfk98iLz8IiNeFeATtioAjKP1QRX9MsanqsbIZklPGoIte1Gw/46/QKCqcO1?=
 =?us-ascii?Q?PFVvucMeqDmzUjj2VmqgsnXpVgQHK3PKBUpGRwY1rS+e4fUnt1G28SKcrArF?=
 =?us-ascii?Q?1SIj5/tKkrlwNQNndWr/20rDZ80wrFNHxzfPSPjNa8seBtqcCfmYkidSqVW8?=
 =?us-ascii?Q?cmihHDD7sjrypISkA0cXsVV9qg6H+5RQeaEuy8BUcay1CrTTGMB78Lc3ZF+W?=
 =?us-ascii?Q?iyBhXOhoJzFIAQDo9j4IrWMer0QcWoRc/tT7/OTFUFuhDCzuuwIRQkZCYEel?=
 =?us-ascii?Q?1ZMp8/ma8Y/Hgk/1LxczOxpx5KmSIAsT8iEqoPI5kh9KiFeD8SZsgKR51RyL?=
 =?us-ascii?Q?g74ETB7Dri08uYrol1NZqwzG/0BiOUwpOiaY4vYCIymdB0L3OGWnVpl1eHi3?=
 =?us-ascii?Q?5QsQW6NCg2Jpdal2NiAXjrahTyS7IAdYUpmgT2E0oz2MK5Lp2UYWUmJWFl7q?=
 =?us-ascii?Q?bxhxqvBy5n9ZI7FeW9kEX/WiQ0Sl8OnIp13bN+gfAVJaIlpc34vm6s5MJYwY?=
 =?us-ascii?Q?D/+SmN1GO8m+WKViJUkMBz8wNxLORUpbja3xNvIR2mbLJ+3FWGkNgAzKIx4x?=
 =?us-ascii?Q?M+67L/ZzCDfFSiRxBkOBpBWDL+ixRvctFL3ABMONVnx9rYZMCqVmgPT7HUVX?=
 =?us-ascii?Q?FhZwtFqLhAVHuAyemtZyWGSnhlTuXwb9+TpaCiOC5N7dR8hbtHYGVypZbZ9X?=
 =?us-ascii?Q?wAzZsNBD2C/mwFkY/UI9GFGJoFggcR0gXET7Dn6MYNnNLCYnk65JzYTuOEIU?=
 =?us-ascii?Q?7OfXVylLmA/hRy6Azois6Wyb2ZR7p6Hw2bSOs2BGjpFEIBugfFhNrsB2HlGM?=
 =?us-ascii?Q?Iwk593B6MmQVjpf6AjrvHgE6hACxNpx5d+QBT0KWWQMfO7EeNLWKMmL2/tMn?=
 =?us-ascii?Q?c9YKEXQ290JPr75DGxj5VIemtPNa6PEdEq4pNuZaoY6+6XOo2bASfGFMFKJS?=
 =?us-ascii?Q?LqTKYnGHmxiuVHCoCCmHNaqewOdwBAd+1jFvifxTK8PqNx/da/s5JDvmnkRl?=
 =?us-ascii?Q?l3qeG3baJ0KMRcBKfFB5WGuF+EHruKg5v0yCQm9FK/Jio5UqFxOuA90oVdu1?=
 =?us-ascii?Q?3zfNHlpkd+U7H5poEI4UCa3LQGNABuI9ycnD/2wb0FoypZdMDlj8ztPuy1mJ?=
 =?us-ascii?Q?DYLy65AGwu2BGxzdAJw0uydR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cy4m2IQ66C/WC548SmmdazB/STnLE8nmLoPR0Bme9WWWGW5AKNT1l0vtEHoA?=
 =?us-ascii?Q?TnzQotXiOU4Pdw/ujfvZ2ohRq63tCsMjvnWoGjX/n7Vqaxgi3gGohQRnsep9?=
 =?us-ascii?Q?re1PRFw4wEcGWfMYQjbg6JRRyS0YghEcewJcRXZ1ZllXWVh15lk3cRAj7c39?=
 =?us-ascii?Q?GpO9DjQTgXuPcaOityz41EuGw9q3fLK29FbH01+5xi/tRTfPrme7XmsT5WOf?=
 =?us-ascii?Q?8N5GhcRhLjquQ8sR9QBzgozOKpFRbMXnqDKfSnWAvIo7WkJnIMX5/6n34bti?=
 =?us-ascii?Q?crgxKUTcmy9861hh58ofziTkf5XdO/ND0EUMae/pVtJdqLnR/1I7l6RmhRCh?=
 =?us-ascii?Q?g36ID14qUmW6WtHkqQFoBGV1hfYgnsroqr9ZngkEt6ErKoMwGs+qkx19fyuP?=
 =?us-ascii?Q?vpU8D1mf7rSywyU5PbRKDtB5Iw4Nt/GIN05VRo/elo7inFsRoNFdL8eMCB6F?=
 =?us-ascii?Q?J0XQOvhxNvCAodnWnLkYOy93DgAUVNXUSRs8bE1HEIodinKstAz0g+HRFYyk?=
 =?us-ascii?Q?RIeS41gkzIoCKXZt2ljY/cOH/YG6O6ZYALb0iVSuf7proNsxyHs6Y9g8HAqz?=
 =?us-ascii?Q?KeFieWr7hRipHUnFW1BggfeT9iayzRq6LgQhl2sJGFQoj6nq/jBhuMJblbPV?=
 =?us-ascii?Q?+cLZbX1Cb0L7flr4BLNT47UtdjN2Bxsf0LUzdO2xYbGJAflC4WAqlzAH3Q9X?=
 =?us-ascii?Q?A57pN3q5JZxWCnCPqvi9FLp4Q0QL1NSHTWglyPSUS2lBmfTgI39plENIVmT/?=
 =?us-ascii?Q?q4cShsiQ3nM8Id9kFdIT1rAqzrZjHQ9xs+9d9YURHyQBmXZQ6Zd9VGOCpZBt?=
 =?us-ascii?Q?Ab/SEKo4HLW6JGdIRnkZ1GwncMCbEjOcpew2TynMl4A3vmxrfokdznLwIoJf?=
 =?us-ascii?Q?iDJYa9DNgVR8TS1sQ7PGrVUj9AjI3jc3gdx91LrTI6rUVndDbBUPWRkRCmmD?=
 =?us-ascii?Q?Sbtig0wNbHEKzGQ6h1vFgMnIHdwg+qNCtiNAeixSUgEuM1/WsO/Tv+WfJ0jz?=
 =?us-ascii?Q?qEVAOod+NJ/SEDtjUQIOc0xwirg9SVstcN0bIyW5eoiYfVbw+9Xj8FLbzSi8?=
 =?us-ascii?Q?uf9VJmQ3aOgiR9mp6pmqpeP5vQ+KzuxlVsK9SsFjZvauvVz45FcNVY71osIS?=
 =?us-ascii?Q?PAUT7sK1E39EbsFbHU4a80vHY0EWzWLjn64I4/FfK6qYtvqM0Q1qE2a0/f2e?=
 =?us-ascii?Q?YtWkZYwDgkiXVo1pQ77uY9CWR3xNKbeOSK3OZnU8bzjbV0b0C0q8/ay385zi?=
 =?us-ascii?Q?L6d3hzpo6dzEBxQSNWFFMzB+is8EzEM8jttI9NavS6q+MfuQwVUrZSr4cidF?=
 =?us-ascii?Q?CYwGjI8hL3h9DX45eZpKjkwsgAwZY0ZXUYmIsnvo34xM9sh/UZrlyFnDBIn8?=
 =?us-ascii?Q?leN0H5CVRJL9Z+z/tftv/x//AhfXQSAQoxJh17ew1btogc+g6xijuoBZy/K4?=
 =?us-ascii?Q?KlR6C3PG1X+ilkif3ZQUzbhAubMSqci+6dFWH+UujxsLjC40JEfEKeWH0NvQ?=
 =?us-ascii?Q?YayAaaZGF1Re2ZMyXU390U1vuZHvafWlf1cY7z3IIlIFndlDdKS/a6i5JbGH?=
 =?us-ascii?Q?gLDA1+HqwSQMKXhGoCJPVJ5ifSEuVCgqsONIilY+5oymWvL6RXOgDn8MSMCg?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dSZV/xOUENPTzwjvnVQRhLgPMp7VuPhWff3ed39OfFYeg3HE0xnWB1PXOyA1Jz3QxfhGSKc4VVF237uQHkvtAA69s53IL9X8NuAz5pc3N/uL4uUAqRULEsZc18LKvX9ExdMfOKG+TzTZSoV5Vso7jR2JLHJWdd+Ukg5bR6x8v2fUxYB6rVaN8VTXrpOEcCaJg+Ro756OwtlLdUGxBKznjfJc4JifmyD4eG22+0sWVRasm0keiFUlKZCv0t4Ty/yiKDkf8A+RKyGROe+hqGNUS6XvAHg67LsdgyYAGGmkiuq6sd/uSz/2efVqFFrv8cSo7F1B6cpCBnPhnYqXpLdiIRVaOYgjj7Tw3hp9x3n9u50/Hht6BysU4dEIB+meFH3/bGdXHCuKC8bD/txovFuUAAnyPpDYWIlqUTowY008M85aPSABVHMq4qO3HFJS7w35y1bA/lNoFYhCNLDeTHaTkHGVH6GdB7Kmnm9njOFpq3CfPDAjGox/3MOFzbdSSZAMcM3QfpzMIP8vIeVuzkUath/rUUeEmS/7K94mIppE0WMLcJf61Scy9eduedG7+p30ay4mnqPdHLHxeCJmfGCgyqAZcSiVPJyba8Xl4OLoDHc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 683d01a4-20e2-428a-dff7-08dcfa639b42
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 10:54:49.5197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SvUhFra6EivO98ir1oZ6EqucI+chcr5oskdfhRSfh7s+WVIUHBHT5gTFZwNiApIAICD4FfwbQjBRIVqFpe+fgiI/jwnHjq9nPcmjaOdgor4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4401
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-01_06,2024-10-31_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=886 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411010078
X-Proofpoint-GUID: _2WKp3PVpZfLIfl7ruVmjmSccJFovH6j
X-Proofpoint-ORIG-GUID: _2WKp3PVpZfLIfl7ruVmjmSccJFovH6j

On Thu, Oct 31, 2024 at 03:36:08PM -0400, Liam R. Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> There have been no reported infinite loops in the tree, but checking the
> detection of an infinite loop during validation is simple enough.  Add
> the detection to the validate_mm() function so that error reports are
> clear and don't just report stalls.
>
> This does not protect against internal maple tree issues, but it does
> detect too many vmas being returned from the tree.
>
> The variance of +10 is to allow for the debugging output to be more useful for
> nearly correct counts.  In the event of more than 10 over the map_count, the
> count will be set to -1 for easier identification of a potential infinite loop.
>
> Note that the mmap lock is held to ensure a consistent tree state during the
> validation process.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Jann Horn <jannh@google.com>
> ---
>  mm/vma.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/mm/vma.c b/mm/vma.c
> index 68138e8c153e..283e6bc4884f 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -615,7 +615,10 @@ void validate_mm(struct mm_struct *mm)
>  			anon_vma_unlock_read(anon_vma);
>  		}
>  #endif
> -		i++;
> +		if (++i > mm->map_count + 10) {
> +			i = -1;
> +			break;
> +		}
>  	}
>  	if (i != mm->map_count) {
>  		pr_emerg("map_count %d vma iterator %d\n", mm->map_count, i);
> --
> 2.43.0
>

