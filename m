Return-Path: <linux-kernel+bounces-248163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B0892D90D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 985BC2874E1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9DA199221;
	Wed, 10 Jul 2024 19:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l+qDmCce";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sB9ZtkIw"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5754198843
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720639431; cv=fail; b=BDVP1jPPcMfNtfapysAtnBSKhzZ7m/jrpw6jiJTA6PG8FgmbYXIQy9yvtnk30G11X63epGI47+y+K4m5zzXEDpPmwWiitKDOuPZwOLmvfCJfR/LV2paehJ31oc51sIIVJGbB/E7QTOXe2uVrbqHuwiLc7WRzYDes9jDtnPzaxEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720639431; c=relaxed/simple;
	bh=bfpwbr5QVtVQzXXlUuvXekq5ixkmKrAvcxLzBsUpwgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YBfxkV0/b5+v/9w7ESEZ2i9z0pUjDqJiq4oPKjQRbIU+UOmrYIpqOPrWfZt0VNbwfYAF/icQmW8PA4d9CZ+/X75nm8bkVeEwAZYggFMRcYwmxVXcgVIZJciSO5BFl1A2IhxVYXKfWr+4mEJrQjvKBj2fMc25JN8VAcqLbI/je0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l+qDmCce; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sB9ZtkIw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46AFxAlS019275;
	Wed, 10 Jul 2024 19:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=oYE9TanO+Z1FGPVLMiWPHUAAimqauAH0W6HKo0s5T20=; b=
	l+qDmCceprSUi87Q9/Kh/pKEht2mMRgT5wsQKDIFOS1sDwyV3HLsJ3lgsAWOQtWc
	GmFxLpaNq8vFqxAMSSoiyy+sc4tZ1Sr3mIlh3D0u4S56mICpXPNwloKlX+0uacPM
	3lyV/7g27J2VVn9kzvTA7pgWwmEKrV4n7TJvIxfvqpE45nbeacu9O36nlYHzBXRC
	7AZM6U1ZJxNzq+Qcm0H6Wkkk/5wzowuGuovGRSaHBw7SCsKyTiMdXwVmYdT3EcEr
	TZ05Y/2q91rZvN7/F3pdhQl8nq2AlenPOJ0261KC76E8oEk1SO9fYr4AsjrCKo25
	u6kuN7IBr6hBzFHgkpOhtw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wky83qh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46AInZeq030164;
	Wed, 10 Jul 2024 19:23:33 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vva93av-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7sN2DYJnQh7VxCiggWgW4vzjHq2vmP8rODTaNed5M0R4ovJ7OpyU1igh51YBAKH/abHoEShZ+nocU2eusNgtkNBYba9M+Z7+ql6AIAKrTZjze/9PBKGs43A8Y2htNzqfZoFapJyDfrOmHeahEKmxWDhFmY9mR+rjzM2671NalggMhU2n6RrxZdTL7fF+yyeoh+WKliuYPqpsGiVTZt7wYvUIeE/+lN4uQ0pIor1rTojg6spxRSOkKVzCpS7geTxwIIJ2Kq+uhBM449rnwrdazq6IvnK5Jv86CBW9411FV9/4TJ65jcs7vjyKFRC3lWOn5ngn6tWkDvTAUM8pe3UcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYE9TanO+Z1FGPVLMiWPHUAAimqauAH0W6HKo0s5T20=;
 b=ZF6tzsenl9PqTk5tsmkzhaV9F11DlapfswD/otebgTa2T6qFBPa33cQGKvfdcnxazYyv0+pb2S8molj1/KJpvOFHYL8bchSKJPAtudbLUVDjPvB2clSHUvX1kOU5rWc/LbZLfj3KVN+LTtI1Gz18UfpeeYnEPVamUO/B7cFE1UbrDz2+vaK9VK6X/TG7VfP4OF1w9dl+hPKlW/TCzTJv2S2MC18lUMf1xdpDX/gXdJsCbnrOVsV7nO3MsI69sjGnkTRF/iKzVTCW/zKd9U8zS3/WiCKU8UtAxnFjG41j7rEDlsDj6DLwsI3fQKjGE4GcrWtcQvW3yol928rfpAjRTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYE9TanO+Z1FGPVLMiWPHUAAimqauAH0W6HKo0s5T20=;
 b=sB9ZtkIw9iVDi9FdJAep7oqUdd6Am4jTeJZ9Qpwj2gfw4EnDtjIhtE5PccXXs/J+bCrdJpcuXjRkftnBI7SfeU0kxtyU3wG8UMp16oEG/1h+6wnNvJO73LDytjDCrko8HNsGBlQusEz+uOrJKvN5n+96aqDPz/6+bzoERg701ng=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH7PR10MB6106.namprd10.prod.outlook.com (2603:10b6:510:1fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 19:23:29 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 19:23:29 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH v4 15/21] mm/mmap: Use PHYS_PFN in mmap_region()
Date: Wed, 10 Jul 2024 15:22:44 -0400
Message-ID: <20240710192250.4114783-16-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
References: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0269.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::25) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH7PR10MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: a51f58a8-47e0-4473-b088-08dca115c794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ZYZbgz03HUd0sHjA1zcXJymq1DhZlH6Ng2h0ZV0M/F85blNuNgJYYVzAVFoz?=
 =?us-ascii?Q?VvvofjK5xJS4Vp8Bpn2rKIs+aIItGd/oNifEDWbfVbsg1LsaeJ6TJos5kRvE?=
 =?us-ascii?Q?8cTjCZN5N3rFMUOqV/6cmwiZI85fhityirLZZS+KGkuDjIrd1znGTk73rwPt?=
 =?us-ascii?Q?pDUSfz9t7xFVgSzE93Dj8TXTg849jPombdpAUNKtPa/m+VPPPhbtB9Poa69o?=
 =?us-ascii?Q?hcwjG9f5OvZ6Q6zhidt11vGDTYJkOupjXU0VZt8/p4mIhXyovPACkItN9GnX?=
 =?us-ascii?Q?FuDrSQEGs9iU4JcycV+Wtne+A3ICOR99uY6UMrk5JRdvn3oGunPd/VnVKaXE?=
 =?us-ascii?Q?SvB/hPaz+Gcfy8T2nj6I2EuhpNwBPUAAbST6GLcWcP26DEkvnrDvSzhdBWDq?=
 =?us-ascii?Q?psYzoOLn1MtHE4cEYDbnNRJSsSNQMK28+DsHRFYDvcnfAda4kGWbVYFM3EPU?=
 =?us-ascii?Q?YNqAfXCbWr8sWDVDY806d0NVrZPTqpxu9Fid+rO3bHUDtx151p3mUR6oWVlB?=
 =?us-ascii?Q?etlB964QjJFYrzTz9cBQswOnGOy03Jk+88Phbd23Fxu5jr1i9ECv1PLOXp5o?=
 =?us-ascii?Q?LtLBzLsUpUmi/C/b5qsigsdlKCrNB2qSBEdUZxrsf1OKAVF+XiHdRK0VkDgn?=
 =?us-ascii?Q?26o8q4oHIOT2A/qQ1oFzMKcaPhMwpJAeWWsGwoyvIo1Qe97LU5M86meUlZMw?=
 =?us-ascii?Q?WdhWo9fHe5ukNv8UnBzDAM8yTVaobbiyTxsigHwNsw2trNvDasTXHNYWcTiC?=
 =?us-ascii?Q?i4SdTGavnPZv4CjnIRVR3FNrOLtvFYqg3Wbfvd7xCxPGDrgb03GzKEQPILDt?=
 =?us-ascii?Q?VRomw08WC2hJddDN8PE6o65ErQ9dJRoohjg8nDKgPI0Gn9EHeMAwlrQe3y1j?=
 =?us-ascii?Q?Ik/X6VQUE4YM0s0nVhT+8GVOrdZOTlyabQySKy9AJYkqhIsSYJV3D3gN2p2u?=
 =?us-ascii?Q?7j9WgvNUbdCJGljiHaN2UJ3pZATL5BYEa+Ako1aY8lVShvHAZvH8faWjFEsV?=
 =?us-ascii?Q?0t8520tbdfDppx4BfhzAaiBEKaRa+AS/4E/C4JeyZETWy7gAsNZ31EVRhhV3?=
 =?us-ascii?Q?3Kj34pPWWXFyRbCXwsRlCZ+H6IfAZXmyEutVi7Sr1DFXodd4m9ETFg4tVRwG?=
 =?us-ascii?Q?p1XvxfUT/Pudzhkapv+RaKJlqtDAMrKqD2u7uvOvfhjaWP063C4Mf9xDR+iv?=
 =?us-ascii?Q?eXqvmsuHYgDDfeO+FKpedFiurfqsZXprtFZf5vBmlUSZ2smksyWyEWVLBGBb?=
 =?us-ascii?Q?M3SRBzhRSDf91so9kHf96RzrlOZtuJLckejhfLgiSR7CBqTqslYUG98acLmC?=
 =?us-ascii?Q?UQIYJFBkgz4SH+wWxJvIqlYujAu/IcfU8JD1UZhjgIL48w=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wYt0GiCFsG1fDERsaICPUfd1WffZ5jnJRXachH8ENxBjlzaVDGOOyBsv+r81?=
 =?us-ascii?Q?qFAT+Oxbx4LzypgdefC3YgkEiBqbADW3AOlDDytTq1DuQ/dsq5kPeaWJnedR?=
 =?us-ascii?Q?/1WMopCBbBgdmpr/+/7VAUnRNZrRDNpH2XZjVz6jZrNtL/geKXfJLz+3QCTn?=
 =?us-ascii?Q?mBMK337tg6Z9FUNZvP2Ioh1wc/AR5EnnJW7Ga+A/Pwsnv02YQdq/zEct4lLt?=
 =?us-ascii?Q?o7sqrXoaAuyvfR4OjFBVuUft3jmlOXG2Jj2GJ8Gw3jICebP022E//7e9TgKi?=
 =?us-ascii?Q?SCNkw2uac/uzsoq6IGqMj4AXbRexK/Peir/O76oNVKLt4htYLB9KvdTBjOsw?=
 =?us-ascii?Q?/KHUANCN18SARozYJXy1aBf6siq/79hqL207ZFUchVSmiPsvOQsEHoXVM8F7?=
 =?us-ascii?Q?mKiET/IwRYtM/zVd3dTVvs5UAC/hvSgvcYfJc5pqDkyEUduhzrjwtHPc5SI7?=
 =?us-ascii?Q?q/jNK/FpJ7vD741XSE+9DjpF5/wsO4i/dsPjKFbWpD232VPH4Zww0CLMg3vL?=
 =?us-ascii?Q?ft7YKdkKGLSXKdQvvKDx23DJBadRnLXeoP1GfPS2UoXhciLg+rfKAVMsH4k7?=
 =?us-ascii?Q?dw9daIQgZu4IZaeIAY0DQ4Ky5ACzNvwjDXYT+CvtuCGrm60dT4RvRTNV3wmN?=
 =?us-ascii?Q?L3bG+xgjguAmuceUSL4zP9BWPTe8IwyBE2e4ajeZ3ihbhVUSLMX45WqvpZ0i?=
 =?us-ascii?Q?kHDmli7cs6tkleh9gox8nd91JzYpuqaB82do9xTyGEYC1gm63EtilfaiwVkI?=
 =?us-ascii?Q?rsVCtTGxEiT+OmP2ZwruNvwLH3kVfYAE4K6rTTv4cWNJ5ozyHSMuYkk94BR7?=
 =?us-ascii?Q?GXi5yAFJYEhU5VOq/AujPlUvB+u30pe1NrRykYi6snKVp8VRt8WLt/X5WToK?=
 =?us-ascii?Q?h+v1VDE+TegvMt6fZRe6KhEjYVo51pBB0rhix/oomzGODma8lDD8gV8fQSXI?=
 =?us-ascii?Q?xckHXApLuVbMaPuV1mQe6/8eQMTtaxzqpvr9U7lFzrRp/n4XCwqk/cOrzVR1?=
 =?us-ascii?Q?FmRpnl99kLwVgRCZ/5GiQGRa2CbZkgEBbACUr8lqJrXZ/yOReXF58hsOheJC?=
 =?us-ascii?Q?sRk9x6Ony9G/GOqol1Rr52PJfbmgZAl1RzU/5CMnCRT5qU0DMUdWlmCw9NnJ?=
 =?us-ascii?Q?+prrRJ7+9vTDFa0u8A14ZbqwysUE0JTSXAp81GHAbmydQRLrf8mfP0ZSMMGR?=
 =?us-ascii?Q?2oa6tIqetjAccql5cDfWarnnhBcnLJCHT2O20A6BPSVEw/78lvNP2AGciMi9?=
 =?us-ascii?Q?/rWGGMjOrzwlEOjpFliSPzqIRlNtWfVQ2nov7wqcnydd2Gv4BIQvu0nfdFzA?=
 =?us-ascii?Q?S0M81gDIwGMWS0Rme75e4wMmLnNXoXUQ73t3G8nJdi8oGh0pzsRwFnqiuWFt?=
 =?us-ascii?Q?yaL9+6wmXZJcr7sUKXxy4od1ETg5LD9rP9iA3CRKNrS9jt8TGV7dPbjODimd?=
 =?us-ascii?Q?pGMHCi2cOq7o7R+FeAOCTvW1x9Of2gGXO9GUp7ojbcXzQ5rmuo5SxlppU+qe?=
 =?us-ascii?Q?huBTlWk0TuO0FcUn4QMOPUB4dDu6AODV3X/dPNOJmGmgd5jK8BeT2YLBFGMx?=
 =?us-ascii?Q?vVPYkxBLQ/r56ZZG9sCpBhf7MjiJ978+4lJWPSwYV/0aafeD5kas8uF7vLeA?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rOq08Q0yyFzaIwG8r4Q2XnqRLB0el3gse2/loHOC2ZgDjAntFuYnCFH7tIDfqfTGAMLLJQ04fcoGO3O2WrcS4fNOPWW/Hny+ViJFXc7g/UvhAJ41Zp2u29QkWEGPLVHQ2wkehpEicd8zOwqGjxhRYbspCLrIhO5RZZCYETostgDSUsMBouo7qMs5Z/SHow6qDv+YRBm+5dfiW5kpj0GBogvYIkCLmzFWSenNzaTcuELvaIg2DS4ast9+TvvtcTHZOEjnWuzrGHCO7vp8gwqlabzK50iOODOY1UoIGbwWeK0yMcWrSfVzwu/8mdU2QhvYn2nnNLpySbByhKo8CHjk4cw+ueY7Ptc8z+48yWq7J9nN7UwuIGQ3c5Ht/3lNpEm3wrOaxZOtsg26Kw9SkCu9/24KrYNnQTIjOkbL6LMMvv/QyLLkeZQsnC9tFz/qE+gw/WsdFfKetpLPa7CdSvkYAqM30KuME9qJfZHCQgtnxEdrHrlmer1saigJtgCUmOk0c/1FPtZ1xZtEk/am/4ZNXjBzaclqL2t9/nsPj3YKEvYrT21Wmmjbo8J2T1wryIZ71j0jBYyt/99kXiKgfUnsZijyMV+jzHmSB0tyCXYqr3A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a51f58a8-47e0-4473-b088-08dca115c794
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:23:29.5336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2AF4g3L344/3c6xCUp8OyjAiLvu6ft7ex7M5L6BNgmGCV9QEz+Y08SHhQKFZmoJsZNt0pLe+ZOPqbq1f9g2dLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6106
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_14,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407100137
X-Proofpoint-ORIG-GUID: nUJcXoE4jcUrxdA1aSpuiFGVDgbGJoax
X-Proofpoint-GUID: nUJcXoE4jcUrxdA1aSpuiFGVDgbGJoax

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Instead of shifting the length by PAGE_SIZE, use PHYS_PFN.  Also use the
existing local variable everywhere instead of some of the time.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 58cf42e22bfe..e13f032fa69e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2943,7 +2943,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;
 	struct vm_area_struct *next, *prev, *merge;
-	pgoff_t pglen = len >> PAGE_SHIFT;
+	pgoff_t pglen = PHYS_PFN(len);
 	unsigned long charged = 0;
 	struct vma_munmap_struct vms;
 	struct ma_state mas_detach;
@@ -2963,7 +2963,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 * MAP_FIXED may remove pages of mappings that intersects with requested
 	 * mapping. Account for the pages it would unmap.
 	 */
-	if (!may_expand_vm(mm, vm_flags, (len >> PAGE_SHIFT) - nr_pages))
+	if (!may_expand_vm(mm, vm_flags, pglen - nr_pages))
 		return -ENOMEM;
 
 	if (unlikely(!can_modify_mm(mm, addr, end)))
@@ -2998,7 +2998,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 * Private writable mapping: check memory availability
 	 */
 	if (accountable_mapping(file, vm_flags)) {
-		charged = len >> PAGE_SHIFT;
+		charged = pglen;
 		charged -= nr_accounted;
 		if (security_vm_enough_memory_mm(mm, charged))
 			goto abort_munmap;
@@ -3157,14 +3157,14 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	if (vms.nr_pages)
 		vms_complete_munmap_vmas(&vms, &mas_detach);
 
-	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
+	vm_stat_account(mm, vm_flags, pglen);
 	if (vm_flags & VM_LOCKED) {
 		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
 					is_vm_hugetlb_page(vma) ||
 					vma == get_gate_vma(current->mm))
 			vm_flags_clear(vma, VM_LOCKED_MASK);
 		else
-			mm->locked_vm += (len >> PAGE_SHIFT);
+			mm->locked_vm += pglen;
 	}
 
 	if (file)
-- 
2.43.0


