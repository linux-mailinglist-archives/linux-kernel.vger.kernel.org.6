Return-Path: <linux-kernel+bounces-201192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C04028FBAC2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37F4F1F20FB4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC1314D44D;
	Tue,  4 Jun 2024 17:42:40 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EAF14B951
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 17:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522960; cv=fail; b=ufwoQ5afackvEZVOH3CqAvnMRfJf552Q6Dl8iU0YHmwTH/7j5ZFij9HioKiqRFzXu5FIOis88haTpJJp0hmn/FKF5wEKTT1XhSz2EGepKx+XVhznaKs0jixPcBZQQZrE43uI2gS+3UpFZwqvQbR0Tr6TJD74fvUr8IaOP8AbWZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522960; c=relaxed/simple;
	bh=mE+aMq8WDB2AaWK2fjbZsIZm33h21QBjUJCWEpRZiWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UGKaVfuSg6t0zDHhLiR8Fi8YTbF3Pt/RIQQsLUaYxt3on0YCjwDPM5OIeIX0prlrEr0SoJk0FEYM5dU9yX3TDJjnu8ifvfrc/6bOgo1589RKq3OdMlU9gqhJxx9r4QiuP2yyWvIBwlhMDV61b3mNLhWKl37ifZledTQw1U2UPvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454BnQgJ026488;
	Tue, 4 Jun 2024 17:42:19 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DBPtTPhTSFq5Lkbe5Z3QKORs76kLwd90+PV094KlROIg=3D;_b?=
 =?UTF-8?Q?=3DjFAvl/L+BFGX9WqCcq2irTTNP8oHSeWONISFlwqPB5zq5KsocF5glVTJJ4I+?=
 =?UTF-8?Q?tVZTslEQ_Z7N/uM+XffOB8WxIgaXHb4YGNbaYDXnWrt+ENiBoa3n0kkcTg0Z8yo?=
 =?UTF-8?Q?+sRO5XnH6s+bzj_yoHsFrtYcyJfCOh+8q0qAaEldjUdGY7W02bM9fqVZtGJ1G19?=
 =?UTF-8?Q?p6HSbCNe5M3+QzKO/XBi_Ci6PILK/dTuqDFaukYBDZe5nvfCIZAp6hK4eGNg8ko?=
 =?UTF-8?Q?lPC1e0ZWqhQPusWQZdNztPj9S0_8hp6HSIKVOaSlzSx/nch3J2RnVA6p12G0hOi?=
 =?UTF-8?Q?1XEIB3N0ouG7lhGkbxUyxsii4u6vNdim_Xg=3D=3D_?=
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv07wjy7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:42:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454HbJvI024002;
	Tue, 4 Jun 2024 17:42:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrqx69q2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:42:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nL9znb3RP820P0FOFmZTiqIT7lXIQ14qHoFDfd3VDi6+Mb5PA3T2O6PHOBRsXW/hze45LXSuGS4wWOtd4U/JkxnkM6w4Hz3/xI7psBMU5A93jSI5tnxj5PG+qR7cBRfFpvdl3ftndvMt0rTxFoigdpFCx2HDd9zFibS1nmqWJ3L+hhTOdn9gZ/hV0+4BTRJmHI1LRB+ZGLuISmLsBUEULBw0PtP28V71TX7CU3I7XBHnMmIdPAgteqXKKdd8HWiDR6/MGL20b5ePeFq+KdFNyeCsZnhcCz9DDM7fruyiyuN/e7NSySN0qwyJiXJnMGhYUJLCtDfR3KVVDMm8xee2wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPtTPhTSFq5Lkbe5Z3QKORs76kLwd90+PV094KlROIg=;
 b=OYeikNjNgvd+uXyYHhXqX73hiXQCLQGiFVbQ3x2YLT/eHnKxKMY/G79/bf2vLMdWjY6gu1oTBFl0SFmFNgXDLWGMVumwQlhguGlE9Swfz8CFBUikJ68j95mreya3v23ZMFHaxWzgytfrhoadIpYsHqhD0Bsms+y7Aopj2GnG8AdylssdEgR7TypcqCdA3xD9CQIW0fFra9s0UQrkE5y3sCtFDBR6XiwM+hWLCTsQxrLUJRBNWQFs7TFNVD647tJn78WMk/rHWQgS8ka4GgIlqTJYHJXg6EOebaeUishD1DNI6IACXn/rvcU1nOfK8VsXtQ0R1nRIHI6qze9Hcl9C7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPtTPhTSFq5Lkbe5Z3QKORs76kLwd90+PV094KlROIg=;
 b=dySYejhEU3JNsgAuw7nXbTfF0FxyTO9oNqrSWHHA2uWXfBzNO1yJylB8d4NbQnEq7253joOmWq2RA9nXBsbFLQnZFSfLlZZDWSiBsBXWyhi6eCMjLFn5ox9qZ5pjH4zLvZ2hwoh8NHwaJVD2kN/gvlFTDjhkwHI1heS9IAdso8U=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Tue, 4 Jun
 2024 17:42:15 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 17:42:15 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        zhangpeng.00@bytedance.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 11/18] maple_tree: use store type in mas_wr_store_entry()
Date: Tue,  4 Jun 2024 10:41:38 -0700
Message-ID: <20240604174145.563900-12-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
References: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0184.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::9) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|PH0PR10MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e16849e-7ca6-4ec5-7775-08dc84bdac38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?HRlGNCVrKsgh34T2EFsu6c18mFI4/z/ihT1zCogoSYehSlDALID7bdcjvfhb?=
 =?us-ascii?Q?j4jHYwVCGxSWKnxsT5GOdK/IBA7uCNv/eXjmiX0JOqaLl4Rt4A623/E39vvl?=
 =?us-ascii?Q?2Ah9pMZkogE+LxGtlrygjtZjSDgNZaFRZLg3a8A3zqthGcE76+uiUNeoKjm+?=
 =?us-ascii?Q?zkfnxAS35GsFWSemNbpSpxLnJhq+RI+dazwG/6sCvoFdeu+TzFuti8/bVuu0?=
 =?us-ascii?Q?eg0tP5scnUDfh6/ELnieoo7UhOtgd2Gw0Xg7umRLkNhz0orzHTjjUf/llrWm?=
 =?us-ascii?Q?/oUvOj38He6NqFRgnrxP22h3gZc47eAyqCMlNZPFj17vpbxdy/G4HOCH0oa0?=
 =?us-ascii?Q?cDwNZ8W1y9uEvwAoEblz8bmRSrRAq9N3wV+z8Azc2bazxX21PT4UiXRjYvDN?=
 =?us-ascii?Q?SIgvoWOPnakm8Trz4DkKq03u00ttngEyMaHTV9dLjXURxsp9wvugOAGJGJMt?=
 =?us-ascii?Q?YMcWK2galBAIKJzORZSMb4WtWVQAfNABhAuYvhgVkviqTbRwVz5kOQ0vEn8m?=
 =?us-ascii?Q?ywIiXgHdxN2dL9qAJ/fn1AO9IPeYnKEStFo6MhkS0G/Vg2ZIdtDWaf3+BIys?=
 =?us-ascii?Q?SeVS2q1v3r+84DmSxFM3oeM0UQ6Vpwmv39+XFrVmbvPJVOBhrIb0CyCuLLtn?=
 =?us-ascii?Q?MJH6MCHDDx98TQC1Qgti2b5WWZ/yYoH25XFgSxvMB8RaDVR2mflQBbAafOSE?=
 =?us-ascii?Q?NhUYMa6BSGtDLogfa1rYubD3E1ZcVJaOwNjfIyJHAwxJrGo7d8MG26ZB4Hjx?=
 =?us-ascii?Q?Mff4ZoEQSCrr//7zrTzSpl4y9UkIIOgdQbyNkvfNLj8iYY8fcGORa73gvPpS?=
 =?us-ascii?Q?zxmxi2R4AVRwGRUrkL1e+s5drQ2NoZHRWOXlkhCZll+WNLLz3Nb5CfcSrbMj?=
 =?us-ascii?Q?WfoTz/ftKU/55WVEBw962qmP16nxdYq4A0Q2eVFxbTyEUMW0Yi4a8eL2GmPF?=
 =?us-ascii?Q?X2wCuGeZLIeAYtsIs5exlWytLZveKq0zYzOYRamuluUM1m+HJlzAT/E1UQhI?=
 =?us-ascii?Q?GPNI4diLFkQyYd/HN3OEvqEDeTrLUkdCVEWlZV2rIrKo22l226LFZbC0OomM?=
 =?us-ascii?Q?GwF++iigpKFIfoFeD5I1RtokmDVE90AngiZ7ugnxoNOHv+9GxdYKpUIicwJf?=
 =?us-ascii?Q?RaG81XojzhHpaWGLJMAfAWqWvh0D+pAPc/QAsID1skTaWdAZgyaSF773i2u8?=
 =?us-ascii?Q?SEffvQcIfdAQsRvNxp5iHDD/rRuqysRANGukfWzBgCvFfPgu6hDTvheDsndp?=
 =?us-ascii?Q?PYogx4z473tKCOackTaaO22zdlRPtRzBnypP0Aor2Q1lllUv75Be+D0SS/aB?=
 =?us-ascii?Q?MxQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fciB/gNATGR8qHrIL62bOlHfsPtkZjjJVmDyuGju7M9fi1BaroZ1Ozi6Oeoy?=
 =?us-ascii?Q?raCkXsW4VPFsa2zupm4S916+1/Kv05wHslXeRmZvJmutAOnsTNvUKT0rd8kH?=
 =?us-ascii?Q?7g0OigRiGKLfUveCywdX7lNr3ha0gXQHCfP+m5Thnyo2orALHpdSbYES34FM?=
 =?us-ascii?Q?V4jeTVptTVXEXmOj7gjdlCtVbcJJP11TCYkWkYCdivHqjDJe+m0m6NGVM801?=
 =?us-ascii?Q?15l6nDlXDc8Us7RIhTqTdqA8Gmt21mOy5P7nWKkYvYbs4KVUE9UHlNHizh6H?=
 =?us-ascii?Q?kAwnDLbEDMwMvkocQWaFhU2Ga2FeijFfUXfP2NAh6hqY2Gvdgrkrwk/t1wMa?=
 =?us-ascii?Q?3AARvoD6HhC9Okcud7z68wtBriSzMhJzMf64GD1qlX0yGitWCo+7/iPvdywT?=
 =?us-ascii?Q?zkDV+a/NUjB1C01M0g98DcB12zxjF/p05T7wCa07oYF7kXUcDrhKoYjXbhUU?=
 =?us-ascii?Q?MQ0aMPeqMhNMe4p3zrf7HfcPBYbGAjmTwfSKWMGsQmQmrnE4wQDwRZZENtxj?=
 =?us-ascii?Q?m5itSYBro1rax1Mzr6yIuXmOJv56V0BbL7E+zfMTHmAFyTMokR2Sjji920yZ?=
 =?us-ascii?Q?KYnDsDKggwZzYLvJoYzKmcIgVcTttXnZHZbEHSLZJbwec0EbiYe189m9xbBI?=
 =?us-ascii?Q?TRdoACvc8fGQJagr1Dmq1cEJiV1ahngpfeQ8seSGud0p0prpESTn7z/pJYF8?=
 =?us-ascii?Q?RNIIYCtsxKFRaRWS1wc5pjfSr95tbEB2xZD/qcKggrrH3SDClf1t7QwqevWW?=
 =?us-ascii?Q?ke1FuHpGWsy+Mzd0dOrHyqK1cBVINyQ+pCv7YGzA21Az5vML2gK6ioJqamAM?=
 =?us-ascii?Q?L3NqCsNysu+KTT5D3ZRzjZnYxX1D/jjLfVlcS5fi8kxVekbSjjBfIE+42ubQ?=
 =?us-ascii?Q?tphqLemE7VeyxX9BVYPAI6MEqsD5xn2aO16qFmUuFZgUw3M4XVcyjsFUobmz?=
 =?us-ascii?Q?oPXId/QFwArME0PfrwqfjGyYLpJdaSOxkoFRyH+jrq8zRxcE9RWKo0gDmgim?=
 =?us-ascii?Q?uDjOV6r5bbOrsNDu1N1zFEEUku+/XOAhUW8NlZBHOLzBi6nppbPnwS7K6LGq?=
 =?us-ascii?Q?ErZ4u3VR0VP/q32qJV4xhDp327TcFZGXPBl+3MC0XgfwdMdhEIleLj5VZcEg?=
 =?us-ascii?Q?F01wmcKL0zLuHVpG6U93Cma68IoUCseR2nzzPohEgEug2bQnQvwipwmdt54T?=
 =?us-ascii?Q?j92GW6zxNyY4Rwr2Pl7kbYvsMc7p1sY96hTF6yW32hWd0bi7xuvkJRpQkYqb?=
 =?us-ascii?Q?vsfs9Ng8dEdAbZ+aHQQTUEJoRPj8JEmClE9OTKj+C+GEh3C661iONAkzKOuK?=
 =?us-ascii?Q?pCalvmhaz2pm1pTMmiLSWn/wVnjQMX73P0G9ZlC146OupC7+9r6vqv8mqws+?=
 =?us-ascii?Q?yASdFad91xDlvXH9B0h5yL2z0rKmzgqBkuPb1faSXRpFmRLqEeq0QU+yDSPM?=
 =?us-ascii?Q?t8OSE8NLKZVmgvChoHADFmE0+0Fr6xx8mtpCYUbcLcp+zJTW1bb+6Iwm7fGo?=
 =?us-ascii?Q?9T8uiiCtAHpOgk3Hdvu0QdKA7o0Tn7Um65jazNV5QkrClCfByZUP7sSnlpzQ?=
 =?us-ascii?Q?IpaCT5IRkKuFVtV4cO8lUDXZJMLz7zXeVMpZAHk71mb0Y8tg0LcdS1jVZc2A?=
 =?us-ascii?Q?kRYZqfP0nov343Qic1CSnWI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GhywvZYYAFFMkY5colRjYWv9aMGDUWNoQqTqzXiVUKxcuzb0XY7keexKdTbVkPdHq3J9nYEx6E9E8koGTT4GDxAK3cw0TnjgmLAo6D3dNcrtfEL33GRHfAzd9f5F0n4ShZjiKJwJ9YD1eMk4TM49A85XnM+S2qPITUWoeMJCP0aG5LiY0oNlwHpDKuE7eKTXUpTDFe2O8aNDJ3iSbbtc//LvzaciJSr1KqUr72McoEM9Yk+v++L24c0qLi/9a4Dg05LQk7M5dcpcmkpy+hG1V2Wl51ftYRbjc2aGdLVsz4iPaLc37FmXfU32A8tn47GIkAeV7rpB9wj3uJQpn+0Dw2NSYa/dvBm8hmRapHule6eS6PJLpSJtWrefAUESaBbdX8fefHoRwz8GvoDx/W/VnBzPjEWgl/d96LhFx9jOMrhVURFh7zuOErNx0wsHZtI3kJtjCaoQhqQV4OV5AHv8fMCh4mYVng1zzoTVnbo9Vt30p8oG++EdBKTBUjcSggirttXymeAQf9UZZK1fSQgi76B0fZb35dkpDylfmZpYa8E+7eOBylknj0l0yJeZKqTHN8M+noT5WsVAvSbNr6facFLMApa6paOkJkvFYk0UCts=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e16849e-7ca6-4ec5-7775-08dc84bdac38
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 17:42:15.3905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3j1JllUW84s9B0dS+xfwsLSw6oxuW0HJvR8mCpd+Ib0vwRIMKKdqNnRdqpVI2bSfr7lKKu8A5vUqsdf5O5+T/1Y8dcI513uU7P0IK4xD4eA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5893
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040142
X-Proofpoint-GUID: sPgAtGPgjca7tCyYUEaocuu-5rsppJpx
X-Proofpoint-ORIG-GUID: sPgAtGPgjca7tCyYUEaocuu-5rsppJpx

When storing an entry, we can read the store type that was set from a
previous partial walk of the tree. Now that the type of store is known,
select the correct write helper function to use to complete the store.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 47 +++++++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index abd2f396bb1e..20e9d13c2980 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4206,27 +4206,42 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
 static inline void *mas_wr_store_entry(struct ma_wr_state *wr_mas)
 {
 	struct ma_state *mas = wr_mas->mas;
+	unsigned char new_end = mas_wr_new_end(wr_mas);
 
-	wr_mas->content = mas_start(mas);
-	if (mas_is_none(mas) || mas_is_ptr(mas)) {
+	switch (mas->store_type) {
+	case wr_invalid:
+		MT_BUG_ON(mas->tree, 1);
+		return NULL;
+	case wr_new_root:
+		mas_new_root(mas, wr_mas->entry);
+		break;
+	case wr_store_root:
 		mas_store_root(mas, wr_mas->entry);
-		return wr_mas->content;
-	}
-
-	if (unlikely(!mas_wr_walk(wr_mas))) {
+		break;
+	case wr_exact_fit:
+		rcu_assign_pointer(wr_mas->slots[mas->offset], wr_mas->entry);
+		if (!!wr_mas->entry ^ !!wr_mas->content)
+			mas_update_gap(mas);
+		break;
+	case wr_append:
+		mas_wr_append(wr_mas, new_end);
+		break;
+	case wr_slot_store:
+		mas_wr_slot_store(wr_mas);
+		break;
+	case wr_node_store:
+		mas_wr_node_store(wr_mas, new_end);
+		break;
+	case wr_spanning_store:
 		mas_wr_spanning_store(wr_mas);
-		return wr_mas->content;
-	}
-
-	/* At this point, we are at the leaf node that needs to be altered. */
-	mas_wr_end_piv(wr_mas);
-	/* New root for a single pointer */
-	if (unlikely(!mas->index && mas->last == ULONG_MAX)) {
-		mas_new_root(mas, wr_mas->entry);
-		return wr_mas->content;
+		break;
+	case wr_split_store:
+	case wr_rebalance:
+	case wr_bnode:
+		mas_wr_bnode(wr_mas);
+		break;
 	}
 
-	mas_wr_modify(wr_mas);
 	return wr_mas->content;
 }
 
-- 
2.45.1


