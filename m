Return-Path: <linux-kernel+bounces-350800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB229909D5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 19:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7A77282D6A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676011DAC8A;
	Fri,  4 Oct 2024 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mylyawIG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K+zkuuOa"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8A21CACEB
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 17:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728061296; cv=fail; b=tb6eT12v173qBm0d4wgIYlqHeWlAFBv97qY7VPv+oNpqpANo38J/YMOp1b886aukAgV0ve4ChGu6VESRtnCVC5Z8XmIthdVmVw+xmwJQaVpbTV9LNQhBSRstxNMOQ6AyPl3vL+RLGf0j5RaKnArDasz32oK6qzsyaiCXIEgBG3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728061296; c=relaxed/simple;
	bh=RiO5Q5LkoU8RXgC48VMFpjn5vhEbFSPWCBzmtM7LUWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qr1GLDWISjJ8CVGmna+CdZ7Tu6SSo33rLUEITvIoMZ1sLKiTNx0eATheVX1ouhT8d6h7a/diG2UASlLHdfNH6EpP1UoBRcTx+gj2R165u8ae4RdTPlh5UQMNrgGYxMh7o65R1uKfZCHqmy49KCMahc+io3tKjvpzDpmXRQV1F5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mylyawIG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K+zkuuOa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494GfrHT001749;
	Fri, 4 Oct 2024 17:01:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=6wxaMIaH8JF8obq
	yw1Lzqzd2Qk/jpvwauOmtypwz6jA=; b=mylyawIGn4ZjpUWyXfArnXmRXMsWy72
	fUNO61RV4CY7dvvH0W3j0LGayMN5Y2YrP77f/mbCMheeWTRTnTeQFfK4Z//+QJp6
	8JBHEchTLlkMn0uPD0iTpVfZIawF/3jXkWjkwWjIiambPI1HNnA19TVd6+hmBcw5
	m4Y0vPLkX7XaOAZmepdaPXrrMjNfoHe7fsNEZhmySnqU0vwTDG1A0SUKeCk7QiK6
	O0P8f6U4UjNWqTc7M+BIX/no6M/QoYj1mVCwDg/5HsgNtRwhVlIOUXSI3lnw5n+M
	69b6mcm9urXFrFm5HXVaTkVtZzB+ACqUwWb/1E8O1Txy2YQ0r+ah+Jw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42204b22y8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 17:01:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 494H03BH013758;
	Fri, 4 Oct 2024 17:01:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422057u5ed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 17:01:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9DAN/yIW6+/zUCKxB5LmznwuuUtA6Ggdwi8z2Y9PAbJFg1UlQzeALUAziU8qKvZ4Y6KVRO0Ei5tZ9K/sygnap/Fyaj4Sa8b3k7cXiNhCThwX8V81ub6XP2cFq2jM0xQ6Gjry0JgQ4qWxWAvxn1oiz/YuuLe8cEq6iAKNpf440AfDQ4UzW/krPtDk9w5K3iWSfy7T9A8q02GKUeXJytGGFyy4Vo8wPByqDQmPsEEnvT+m8+jJS2/GsB5nYAOieXOzZi7bYu8NPfp4iR9jOduS+9G2jm0QP6XZIz+mgBIaZEWrZxRu0UiPWsDJNPci0JGrrgqXrR5ZOWRLkWVvps3hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wxaMIaH8JF8obqyw1Lzqzd2Qk/jpvwauOmtypwz6jA=;
 b=MMvFDh8tCGcV9Yf9oS+45EIuni6/uW1ZHcNlUmMoyEe4DWe1roNibQVOc/N2qM//9lqW2NMDJMFr48Jo5Y3XgLq1bN4W4Q/djBZM0fItOemkbCMbOqWCqjbhOy+ZLSX5gJkZePsxhu/7ipxuKwEouk5ScHKCT8sBHdiJT+ddyVgmgYCzdPcz4LX4PYQ0N2a4HjWSYrOgP2w32SnSHD327BfGTel3oQ9YPF8hmFW8jh7wsAuq6NVUd33asouRe5a1ZAq4BCs6n4nDZxxHpzhlOaKMwDbznygDHtlS33cgAnmorhSvIWwok1wm/E3zOPV3gseLpX0CfcwJawtV0hDtHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wxaMIaH8JF8obqyw1Lzqzd2Qk/jpvwauOmtypwz6jA=;
 b=K+zkuuOaGLKoHumi6OHMQVC2Xq7aPymSshKIl5p/Ey2I3NGBtllvViz03MfpfreVRTAc1qVocPC8J/l1mcT8NRz+UaF/hnOjfREqBQ97wXJJeUOCpaDRB9nkTW/WXyQ2TXOXPKLrSbuYEIy9hoQUgOxNSbdUzSotzrtV134GQwA=
Received: from PH0PR10MB5611.namprd10.prod.outlook.com (2603:10b6:510:f9::16)
 by CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 17:01:10 +0000
Received: from PH0PR10MB5611.namprd10.prod.outlook.com
 ([fe80::d513:a871:bbf9:fce2]) by PH0PR10MB5611.namprd10.prod.outlook.com
 ([fe80::d513:a871:bbf9:fce2%7]) with mapi id 15.20.8026.019; Fri, 4 Oct 2024
 17:01:10 +0000
Date: Fri, 4 Oct 2024 18:01:07 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com,
        "open list:VMA" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: Remove misleading 'unlikely' hint in
 vms_gather_munmap_vmas()
Message-ID: <71b7cbeb-1301-491c-9637-e6d48938ddaf@lucifer.local>
References: <20241004164832.218681-1-leitao@debian.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004164832.218681-1-leitao@debian.org>
X-ClientProxiedBy: LO6P265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::9) To PH0PR10MB5611.namprd10.prod.outlook.com
 (2603:10b6:510:f9::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5611:EE_|CO1PR10MB4531:EE_
X-MS-Office365-Filtering-Correlation-Id: 45faa138-2132-444e-96b2-08dce4962573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RW/2SHVDILsiIegbgXZXLeLF7U6nDRKkxl/6evcv66KzLegy6fauDe6C9D9m?=
 =?us-ascii?Q?3Vuw6Aen/46LGzVDmXstNh3NhFjgAnkGDUt8SjpAR0uUe79HDV7fkecAo/Ah?=
 =?us-ascii?Q?p9B4nsVTZbagufCYCV2WcMCyq1AGfbfJTJ00LmHnCsH4phe+VjXp9Js74WMK?=
 =?us-ascii?Q?JwKdUYpONWS7XyPajhkzmGErAr1NBdPyZvMcgQ4OwSrnX5GlqyQ15tEd8YV3?=
 =?us-ascii?Q?NB0HAFBjFqeYiAVr0lgy1meGel3rgLK/rfN449oiKx8TS8S3M9V7fq5ojAy2?=
 =?us-ascii?Q?2ZHzx0EOlYQmHWBC5dBtvLpgneEMkKwfkBY137y29Zw0ij78vMZKS6WT2az3?=
 =?us-ascii?Q?D+0Ovp42x8Zi3F0ova52V8Z+HtJt0zCLOBBRoRJ0Xaf/nS/G8w0sreaJnIdq?=
 =?us-ascii?Q?mW2NCS8jY1uU1fKmKR/VqLEdA9jMX0+c29TbZwbhYehNi2CW7jrowKltixxH?=
 =?us-ascii?Q?CAEBaTkEQmCB6X57lgV44TE5Tg14i8w8+DpV7pmS2RDJBTg3lPRn9OM0nDJR?=
 =?us-ascii?Q?gJQ8kcbpmGCMFYACwQZ0nUFYmnoZzspjF3T5EquSCH7HIxor0ng3X5fdZS+Z?=
 =?us-ascii?Q?s5AwUqptrhhF4b/UC3sZSJLwzNgPuz1iuHSQnicQ21rUaNdt2UmrRi1SsVjN?=
 =?us-ascii?Q?yhpMgVTj4piKA2M2ntIXbi7sdnKV9vRgdQKrGqypm5ZaOB/zc9fvabqy0Rm5?=
 =?us-ascii?Q?DnxjuQNBSz/bGO/mc1LK7+lE9VrB/SNfU8mNjqJd/vdf/W06kYqvFzkh5uCa?=
 =?us-ascii?Q?pfwi9TklA7VtDEsJmV2ovx6tMwjLrppjcDLAHeNPpOJg03vb/LwU+nZUwS/w?=
 =?us-ascii?Q?NCCWSBg4NtsjA7uBGlWu+k77Zm+5OrQSzuyp/rBRFhnLSNgOZno6ESPmkMIh?=
 =?us-ascii?Q?EZtPisj4svSuivDt6+vXRR01KDFDoBwpuRMcA+m0Mk4QxXQ9Pd2T+GeNk19q?=
 =?us-ascii?Q?9JZk1GDRo4J93aGIMNUjnNKditKBP4EDV7jBj5FiHwygynrcSphQeZYSYUzH?=
 =?us-ascii?Q?y7YAT3fBJJuv5i3qf4YEhKrzJGcts8A/LYyZFbIZAJyy+ZtO7LGa2oc8QxpS?=
 =?us-ascii?Q?ceBVgCkkSz2gteWuLjUbUjo5yu3t9XfM6uXdlQfeDJVZhab8IeNaq9qc5L/7?=
 =?us-ascii?Q?e5a0BIMxXJF8i7ASSk6rmSlzsWSTH/MbR+rxy1BMOjwPgXknxK4CDeby89W+?=
 =?us-ascii?Q?jyKaWWswy5YtnlFa7N3/2tYHgHPfxCVuEvtPDumrTxkNQiRQUO1kaIwg4rjq?=
 =?us-ascii?Q?2Eg33L5OhswBFgylHwFzAINsX9hDS3nVpPe1/REglw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5611.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HHIG4YFuYceVO1/lfJUjkAAw0SRKjkinl34hckIyIMKTFBDirEOavBFLcYmF?=
 =?us-ascii?Q?ffHUuUBxqKvJAFopeza9b4pLRv5pHNKUNXqmtookVBJAJlfNDxBfaDza5owD?=
 =?us-ascii?Q?xv4iWyUskE3LtBiWIIxKVDBLIxqHw7x2yp/see34VFFFSRxVuhF49ZxuI6wt?=
 =?us-ascii?Q?GBRK39ppbglqMb0r/G9/o/gmBOv1dF8vFpGgyLd9P4taNuvo6oL2LhGcUvK8?=
 =?us-ascii?Q?ROPcy/VBDg5wzuPBnglJAf4bdEcQA3IsmVHFV+dEhiPY7KXMtWUAdX3OtuuW?=
 =?us-ascii?Q?1qCbkctAvIsoi7bukA9c5eKNEA0yjqleYY8XGknhV9mK5HoAxXNRTMs2GP5X?=
 =?us-ascii?Q?v1Iik0gNtgwpmHAycJXC2uvz/CLq7nOb4dgKCvmNb/8i22xgahPXkI/DzOwg?=
 =?us-ascii?Q?ttguZLd6lM5xrAF8ZDIQiBB+1kQbPE8mLLV6rGBQAXre7nRF95TZOOrDjMxW?=
 =?us-ascii?Q?/+t3P/ZX2PquyL2wCuJRuq4pwg215vPGMyJ0fUQzlMdcFbpfokS3JixJP9rP?=
 =?us-ascii?Q?MbBpG38uNGxN2s2UIzNsdNhNtXJmDcyBAypwUVncdn1/mBDAMUgI/XPHi7Rp?=
 =?us-ascii?Q?Rkras54ZdWGYJi3NOwKEPxrRtyWGBXX8xspK9mmR3ON6FGfPamCcxMhCuRCz?=
 =?us-ascii?Q?agWUKYL/5/Y7VJJAVYLEMVSjE7hbhu2GhvF0mxBe2Ryqxt+ELJ+Jm8/p1o29?=
 =?us-ascii?Q?doO9gdUDRT1rdmGY/vFub1FYBbs7drxsUQsniRPRz912u9lfSfQ4bz9fbBVJ?=
 =?us-ascii?Q?4aqF9njONNaYFkcvrwxehbvqbpfGBnRFDwpEo8T2oNyrz+5HxL1HME7py4Bv?=
 =?us-ascii?Q?xqyaKXUFS9rX9bEcZUWTAkIaHllG5VVs1y7Hku95VRo7/CY/aNqmSoClJEfR?=
 =?us-ascii?Q?bUsY2iwV0w7r8JIpzmlejBwZ3M6r9VWycfaO+dTTYUcquVCqFr5QRmKJ9zkE?=
 =?us-ascii?Q?CYZcspS09mxBSBtmAjZ6V5vdIwyuuC6MgUNhlushKKLSPSSOisBhWEd5xLDu?=
 =?us-ascii?Q?/Kj06zw1wn6N4f7Bqfrrq8Mnoqmps2TWIxxpFNrc2K500D7YQg61EKW07sRt?=
 =?us-ascii?Q?P2xuRvVtebR/5R6xjPcJ2W4ohgvW2VVVYDbPbE2u+G4gCMyHLawpCitW9aNU?=
 =?us-ascii?Q?8gdBqnTMJprpNcUZn9Bz2dnBI5lN6ZrZrfqBdcDI7Z767ylAiVR2k0RG1ziE?=
 =?us-ascii?Q?wbABH1TKD9PYkPiTK5Qqr+OhoAYX3vYldrkBW+4/PdHCSEuiPcTVLgQQDBa4?=
 =?us-ascii?Q?HeOl496syup21vOG2d8LYLISqO1Wm6tna/I7tXdKpONLUU+mbdU0WBik+FSX?=
 =?us-ascii?Q?GynXSPfommju37Prq6Wi94tMxlYlsCw/BNiRSdjylERi9Ayyuf7vXcr0q536?=
 =?us-ascii?Q?ZqnMrPJKulBxPTsCAhKDMZaAvmO6xmyvYOiuGYmXKYSVyXcXFA9vSlPQ27d9?=
 =?us-ascii?Q?XMU1VnQ0gblQ+kEdW/7TA8H0cJrU3IyuLxvV6rpojcEuAZoitThgXw9n2+uH?=
 =?us-ascii?Q?OLswZManzycY8OQ7edbSY+o0kGULKf+PGW2c0IW9hbWf9LK9qu6SJ6bP2a0d?=
 =?us-ascii?Q?N/3Lr0cQvzvtex/RvE1hfw98cScYJtZcrXGMxK7FfV350dhZbrX/DqFLFq67?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0udmJbZGbJmJO75LromgTI39QtBLbNXzMv9N0Wkyi4ccEV8XJQ4YaaEw22eRQ5NKsDZuFvlE9fXo0RZ0FQD3bbhPmE7KQ9e/gH1XsRe3kdPVzZc692anEbsdV/64i8WqZR0eY8ZfDH5CRn1MCR2gmwYYmV5mLOR4a5WNz+LFe+F/Ciji08TFuAtZCBRgWjWVYxzI+rzzemhdlUPjtfFZehWZJm97JobbCDOoW4i/ZTxMbQbC9dj2c61+99HIY00LjSRjp7NnIjuXbS40YzqJJDSEPJkgBsiAXOMw5ve8KoUkdE4ejabsIZd/TqTf6c7T3Yp8FlHqLpsyfJS4Z2Vfl/tP24gtpboLuKdIMRM75FKje+sb9egkLavmsDBW6tGBbtY4t0BiLgHRSRRyvlmT9n+DOB5Roe/cuZtfWv4iRVmAIGeY4zozYg/TbRuoryBBhMhFQ87F1yR83z8g9qRSocczKZFnPAusM9Vo12hQrY4sKnoWqATVUzgCmL6vHoF9qMS1QmfXYsK7QcwdEMYVL2wuG/N7rmM2UW/OmgvrZBc+WTZYvTurwp1i5Iu8SYFkfsxrOyELP/bmUPVUCq9QSmv8XoC+lfXIxVcFR1KNB7Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45faa138-2132-444e-96b2-08dce4962573
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5611.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 17:01:10.5609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7bl9xziA21X+O5q+zgmqrcqtl8UGBcmMooiXft1daj1hGPATGwC0zWxbmOzkFXnd8X7qqOrTAWgJ4gg7mWMhI51aG1gihlEAk9G8S/dW4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4531
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_14,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410040118
X-Proofpoint-ORIG-GUID: huYKNRxXVqnruoApeRhPn695O2xwyV8k
X-Proofpoint-GUID: huYKNRxXVqnruoApeRhPn695O2xwyV8k

On Fri, Oct 04, 2024 at 09:48:31AM -0700, Breno Leitao wrote:
> Performance analysis using branch annotation on a fleet of 200 hosts
> running web servers revealed that the 'likely' hint in

To be pedantic: *unlikely

> vms_gather_munmap_vmas() was 100% consistently incorrect. In all
> observed cases, the branch behavior contradicted the hint.

OK so this is probably because vm_mmap_pgoff() declares the userfaultfd
list head on the stack then passes it into do_mmap() and threads all the
way to this code... and yeah, so that would be 100%.

There are other code paths that aren't 100%, but the system call one is.

Nice spot!

>
> Remove the 'unlikely' qualifier from the condition checking 'vms->uf'.
> By doing so, we allow the compiler to make optimization decisions based
> on its own heuristics and profiling data, rather than relying on a
> static hint that has proven to be inaccurate in real-world scenarios.

Yeah I'm generally not in favour of 'vibes' based likely()/unlikely(), I
think it should always be based on profiling.

It's understandable that there would be this expectation, and it may have
migrated from other code that already had this check in where perhaps it
wasn't always referencing a stack object, but yeah this is just wrong.

>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Liam will want a look too when he's back next week.

Looks good to me though!

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/vma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/vma.c b/mm/vma.c
> index 4737afcb064c..9d4fe794dd07 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -1250,7 +1250,7 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>  		else if (is_data_mapping(next->vm_flags))
>  			vms->data_vm += nrpages;
>
> -		if (unlikely(vms->uf)) {
> +		if (vms->uf) {
>  			/*
>  			 * If userfaultfd_unmap_prep returns an error the vmas
>  			 * will remain split, but userland will get a
> --
> 2.43.5
>

