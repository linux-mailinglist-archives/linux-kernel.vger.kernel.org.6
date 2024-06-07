Return-Path: <linux-kernel+bounces-205176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6405D8FF889
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 02:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A19871F23C08
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 00:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC63A48;
	Fri,  7 Jun 2024 00:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OcE5nr4S";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ehfuoDnd"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67108366;
	Fri,  7 Jun 2024 00:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717718816; cv=fail; b=rooRHJMt3lNKHs0YpjWWs0IgvWxqyRIHOmQvOI6FJ483DrjHvjfI7JZWJTs11P2FRH0Mhon2A+tD1PtRTvN5FNfuLKz+3b6Ja36oENNy9djXBwbiJGcdwfFmKCuGEYV+hP51zLVAL9Xnh+BU733O+TTKpRdGnqFTB8xbjrfiFYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717718816; c=relaxed/simple;
	bh=LfTh+h82x6EGMoKBaOfkJqQyjTkt+BArLa+zH/XyyJY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=krjg/aCIKxrpE+2wG8kcIQmO6HcO9nBgO5jRBwcrGu29m9w9YTcoQjebklrURpM9M/nbep6WYP1Y89r4UB41Rn0Sax837C6ETg5Lkhzxzy9u5HK5xWkf/ycVceP+Tl3HNFGLfmbtprlZzvC2vqgSfkBIDUyzW24tThKyR+ANZgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OcE5nr4S; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ehfuoDnd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 456HxV8f011790;
	Fri, 7 Jun 2024 00:06:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc : content-type :
 date : from : in-reply-to : message-id : mime-version : references :
 subject : to; s=corp-2023-11-20;
 bh=ZQVj0JNB3rGT99xxD97p7BboFdfAhoL3yvKwiMrPxSs=;
 b=OcE5nr4SZP3EBw1Y5Wjlqd85ysiNb9BphcDleP1C9j+6ga4vXvxR9p5dzpL291hJ/ueV
 rKpKyt3I/c98EGt3AXRKyBo24d8t75PpPU8vd/k77fnhdqFz4PdN9hoYXJFqgM8BuUoI
 jtTTadzzS6uLAK+qRUuDKTO5l5wzbtqnf7JfB1HDR44L6lNnG0iQpQ5q8+iAJLaCFu9u
 rFDTGpEdtgYvhYJwzjCs+s1wSN9KaByu3yM4/X+d/Iejgc7AjVou/9TElgGmRKdNL2Gy
 KEzMe/MoLwPVr/mCVdm8JM9+R3PS8UIiirYiWD0Feopv/DK0Nhlw8mUDzzzZTaKz3Ijm /w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbrhcmub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 00:06:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 456LQwgn016140;
	Fri, 7 Jun 2024 00:06:33 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrsdt7m2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 00:06:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ogo7dT99sis3nsfMEoaaauYQ9QVlNJ5Y1HlTyxuFKbBSbiF/E/MEFnYjZ4QQ/xhhqrKeffmB+C26cLg3fDspktWCADnKAImD9zmEiQZ0WWjBTHm97yx3X2OdTJcd8wd8YhbUqlAYpK5HwIgJGBW5Rayqz/Ds0Ps8tr+ApDPQfR7sAtF9awYMLcl6vsNBebz+cp/2uK+EbWKMYSjOy1xeAE9X+1YElIeY0lL7c8lEmgC550JmuePoSwd9f7u4Rv8FcJpwcO/Zv+HA8mWEj3q4gCURv4khqw0eev75bb/Dlci+fiBSGgWsw4kg3ypS00hZozxnqi+GpK4ykHOCwYBbuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQVj0JNB3rGT99xxD97p7BboFdfAhoL3yvKwiMrPxSs=;
 b=E5yUmm87lWCcVIIy5Uq0taiVGRddYdgwt9Fo81uYHQdRTvaz8mkr5EvwzA15QYFbEdoMRb7cuP6OH9tlWQ6M6RaStQYn4hi5vy9NPEWtRJFxHszq+HEBa6L7SqBqh6RtZxdFcF9yJx9tqBXyWfdviYddBkDxC1rQiqLlZbh7OJqGMs0omXz6QADO3OFzVg13A7p4rZhjZggtMngodYpOW1ccSrFjuickVB6+Fn90c6PHAMqq9LB7zJ1iHna15CBGYGx0WEpSzhcamr+krbDVZJCy8PNUUeXT1unLhMquIYaubrdFXWrqNeIuIc0ou2d/D9d5sLVFEXR73j2wUUkKRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQVj0JNB3rGT99xxD97p7BboFdfAhoL3yvKwiMrPxSs=;
 b=ehfuoDndEEw0Kfrz7220O3YFtEsuzPkW4UKsehu3Pc1Y+rd/9sh98FSaofnTibnSXn23LC1+9zTMn26OV1YAfcJHgN65F/NipnpzTfks+IeHeOmmTdl167fDMzZU+XL3l4ivNsa9dZwSTwUensmHFeIgwafOugsjgAo6iO5nyM0=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by CY5PR10MB6261.namprd10.prod.outlook.com (2603:10b6:930:43::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Fri, 7 Jun
 2024 00:06:29 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.7611.030; Fri, 7 Jun 2024
 00:06:29 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: David Hildenbrand <david@redhat.com>,
        Andrew Morton
 <akpm@linux-foundation.org>
Cc: Omar Sandoval <osandov@osandov.com>, Hao Ge <gehao@kylinos.cn>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        "Vishal
 Moola (Oracle)" <vishal.moola@gmail.com>, linux-mm@kvack.org,
        linux-debuggers@vger.kernel.org,
        "Matthew Wilcox (Oracle)"
 <willy@infradead.org>
Subject: Re: [PATCH v2] mm: convert page type macros to enum
In-Reply-To: <b96b3d41-cf6d-4c5e-bf42-01fa168510a5@redhat.com>
References: <20240606182630.851750-1-stephen.s.brennan@oracle.com>
 <b96b3d41-cf6d-4c5e-bf42-01fa168510a5@redhat.com>
Date: Thu, 06 Jun 2024 17:06:27 -0700
Message-ID: <87r0d9obuk.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::19) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|CY5PR10MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: e6b1a356-c9e6-4548-ad93-08dc8685ae4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|7416005|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?voX7JU6YkF4XWP3z5WSE103HdYXTE5bFZtaQha2nau56HksBu4j1qrcxe4YO?=
 =?us-ascii?Q?gqrhupdOqSN1BfAm8Y0bUQb5HpgMZI4K8kbe+T4j0HmxKJUMEK8xSTnbrV5w?=
 =?us-ascii?Q?xHKZbrD1iygAb02OTSDvymNDFLsejdwVXNzeWBGx1apKxOaaEKJiQqtxHBXR?=
 =?us-ascii?Q?6NARFyoj+T9SPuMm5dlLMxHPovOSBeJLrnS6yBsMNrBtpFEkOaOIvGAOd2pn?=
 =?us-ascii?Q?6wgMMniT/L/fPugsn0xF+4lTawklh8vtBZXFvgHXG54wo/9RwszMnnHFDle2?=
 =?us-ascii?Q?sd04mGrDf6GKwhhBtpBAih3i9SpqvkfEHQAPdB/BmCAmA4Wrt7i4oyvTvHOz?=
 =?us-ascii?Q?LAor8Dbl3l0OVkz1rDg2yNmjhGVA6+VcnuQEzPcxqonlRSE5dArb2K8zlZrR?=
 =?us-ascii?Q?VX+CiASBMP7Z/XdynOTobzvtnOkN5OSlCtBFZSfkGevUotjAfCgsJZuQ1eDx?=
 =?us-ascii?Q?LeFnSYKkCjI8ewJqG9tnKKxr5nnkYY3FCH41kth+HCxGTOYtvFUwBLY1PNNp?=
 =?us-ascii?Q?zcWPtwhvrnXTXnOcnANmLozUR5jd6iL4J180OMCUstoAQqSCt073vpEZ494g?=
 =?us-ascii?Q?di062B8nE+bqGcO/WGmcXLg7PFRakh7JB1HZzlKJZOoVRXvWvHrYih7iGgUr?=
 =?us-ascii?Q?ZYNw92DEY5M+8xrsvrePr97ucLEF/3/fCVRU5jX1QLIh1fV6i8FnKvnPnfk7?=
 =?us-ascii?Q?M6B+76UgnLCQ94nJQIAAzl2mF3BE3d6Vysq2mfgiD8FzjzEgFtcGkWebljLb?=
 =?us-ascii?Q?jXsxnfV4H8NR06PKOnVVjHYqaDmpt/k4KO+wKpwxZvOuzk1mjPHbQETsWY6T?=
 =?us-ascii?Q?WFV5l8Shj30vvW6SHXQUsNB65URxSkw6kXtsKlEWN9AWpUORvS5G6o8/qdpj?=
 =?us-ascii?Q?at98O1HabiFdbZ31dgKHHC77qT75r/0I3Rrk1YkSpkKtTYlVMBbVWGbOYfm2?=
 =?us-ascii?Q?1hHRomSBZc9gy6LLn5oTYbYK4W9uDRjX2JgcqlVz4VbKgMZfW5jxtw03lC7f?=
 =?us-ascii?Q?Z3vfy4DQuUemqOdPpFHmoCXnxsAkyPSMrS3yvmpZdz/15vU1Cbhyh8H3rCDQ?=
 =?us-ascii?Q?nWdi2pxgdiEvy1cnKm4U3wARrOSm/IGwsEYRZ+SEVNnjr4zXoGkdKUkof7ZD?=
 =?us-ascii?Q?gQJUqW1WLNraSId5/gXMRYidM27SoS40Jyfy7a3GA3lZFA/tVNmctjuS5JTG?=
 =?us-ascii?Q?UbdY37lrWV015VAHYgS76HbaGWAGuEiweCouBd0g7NP1aP+NC4Pht4u1iIvG?=
 =?us-ascii?Q?4Ns/lVIV1dEqShrqCssGXpkla8uD7KZcovx7yIeXti8xtM721MhwSjPekHvA?=
 =?us-ascii?Q?9t5Dmwu3F2IJHocAbDSNjNeA?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?v7HmK6YdNNZxmoPCsev6rlUquZisALgSEzRdMouwVO8PG/WIo3LFCLC4YM7f?=
 =?us-ascii?Q?QKpKPFujzGqzWoI7Wu/cf9gEguSDYXlp3ScmmAHSHJKISV4eFHydaJtb42sF?=
 =?us-ascii?Q?nnjmOFeoSATrsdKFVN7agUKDk6J+Olf5T8CM8JahU73KtyRnwogCPyK4uAwi?=
 =?us-ascii?Q?Ba3pLqLKbemBbjZXI6Oq6GBiJXntDBWQUsvTrjRjUlax6qZ1ylfy62+6nREb?=
 =?us-ascii?Q?F3oYdey6i5tNdfs7tPOzGpNl3LvaFheeqpkmL1ogaW3lcsUrXZfqnfNB2r2F?=
 =?us-ascii?Q?FdwlFhNLk7RA4wztjvUnxq0iqyZD7mVuUg5/CuXrTZIH58NlXgNEAPsYXNTh?=
 =?us-ascii?Q?ws4JErb3Igto5+MvROsvedjw9TTylX+O3ORjLb/PJ3DBf8qMGmPu1ogBA33c?=
 =?us-ascii?Q?yBc8s8XHcn1xp/H9rEMlSlbS+lQekJTVczgRsCJT6zg5mA8nW7DJ57J5RCl3?=
 =?us-ascii?Q?TiE+bPRRetHsBsizzDYnGuulNDcA/HVjgleoegCoF4dOwlTkU8ysrT3BW7AB?=
 =?us-ascii?Q?FOj9ANQ5dDPlVlPe0wLX6R18dmZoJAK5mVZu9+76G7b20soNo2FDGWf3Sey+?=
 =?us-ascii?Q?1OabFdMS3g6BhOWTpTAfdfgQTAgJ/vuS243ixOBq89tnCUVeYVNdR7W0g1SG?=
 =?us-ascii?Q?1DP5YkNuk28L9cUR8PUlbutlPc737Y4CzwgUX0mp37yDNx5JzMx74N0tTrjF?=
 =?us-ascii?Q?5adywek8xV+MIRgyEA/XH642LhRD/stzBv3UdKCuYDXh/xBp9ZkI1Zeuqw3c?=
 =?us-ascii?Q?vpMexT3HhTNOBel1bRoONAYSrdbMi/UW6R0w7GpTx4w/gbcqqHiX8/BkPOI2?=
 =?us-ascii?Q?RYI5CYf4cfIWGykIa7YqUu87VX41s/HqKZT7CajXE4Hd7tGg/DTBMpj2Iw9P?=
 =?us-ascii?Q?ieXmdaCOcQCsM0H6rdrxomVS0kIGN6aOE/wurRyTV2L0TCe2IHyMhpNGo3TN?=
 =?us-ascii?Q?p0i5dra8aXVbthVQ9tQCCgV5qKtUf1yaMCWzgGPpPMYF3lCgm2wxmlghAyjV?=
 =?us-ascii?Q?6xBIa1Y95JQQIoUkenPaG8cl5O7jYp15za6cerdzU2VC6aSkzjeAoXjELO2I?=
 =?us-ascii?Q?x+yBMgVpHXxT4QOqO8pWJVP7Ql17aL01Hk2du2H8SMAwHw00q5EhQm7TDL9M?=
 =?us-ascii?Q?dLQ6anG8zfkZPI5D5ynhJD8y4kpx+/Zl6tTM9WwXQ2gFhOGSfyMNVbHAiBTT?=
 =?us-ascii?Q?cu3Xrl0qMX+8SAdrm/hIiMJ3RNXMcmvA+OqFPeCVuxO8S6Frslv/WFbhdrpO?=
 =?us-ascii?Q?9mxw42JMjSgtqLffcKHfIWvYIdwsghayaYijYTYW7HQQ4Ri3NmAGO2np3qZ7?=
 =?us-ascii?Q?jzGZcI16pIwT6UtPHdg1R+eTkSCnCF53OoqMlMUcsKEyOTADFQIeKyIoFVMt?=
 =?us-ascii?Q?q9tnPt0EL9RI6tv0VVPQnlaaXUrk4nRKRd8CKf0mMYjAdjVC1+EySCO9sKFP?=
 =?us-ascii?Q?Guv0N6KTJHC+IfhBEqP6evO54/hnEAKNI6qcFv1Ri6dUkKFM6/+OKeQxAsvW?=
 =?us-ascii?Q?XN0BRN+J2/kTH/i2KvykMx4W94gqLLLMIulNPzW0jeEQwkhx8mXfDOvksrh9?=
 =?us-ascii?Q?9Fv5yGfpI2sD7C9E8khGrBDje6HDiVpa9P/4fnvhBe+9q1cyoIKoAnNOH21p?=
 =?us-ascii?Q?FGRI3CQyDEzMRX82DIv6u4kaql2TOagGVvWIww8hN4I8RnZ4xnrC3vJ6XoNz?=
 =?us-ascii?Q?omCfCw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	doHrGQkx0WdsPQBg9PHzGinQwLIw3ddlPw0ZANmyibwyh7ZPkfeTAEsGbvdhC94oEMljew4mHzZFGS1BOroYch4wWutG4qzcUpYLgvGDLq/YhWxmHG+B4507PVVyHMlrnU1XOx9aj8+Ct0Z3n+YWaE+lfLr24pc6agwzjZRx8lIn9dZpzUnCMN/6UOLgwDlps+X9l5dz4P1qFKgAk54m0x3OGuZg4HBFf5grOA7dpdlhKF8QDJ1naNnDLAbQUsVSOi42qwhEh54kRZx/2QFL3y2Gf1ddO32OnwKnbrqRgfWgrg6bMrzcQNmsdENu/SOOOp4vWVeU0QyAPYS7sVvgSB035i+HNON3bKrEiOX98C6KvgfRvxihDnm7hfN3pHM+DtKMRC3znPpC1HTZqkhVAgT27YV13Vh5KxoAouC6eoGWvAXNW/I8utKWhofzbyQLwNgWjECPSjW62viunIRqD9JgLoC6enP150kahbIae5CdcZYEt6Kbd5m19up6be6asx0PDfSYjq+M9R8w7M0pW3C/nKYaEtm39NbyQGyAzxOpLJ0dpGUuD7wbr7xELmiifMxyF6GTY7revoQ8vFwdHkF0c/dSIVb0R/2GJCiYcbs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b1a356-c9e6-4548-ad93-08dc8685ae4c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 00:06:29.4485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDx3qwhn1/6aogmc+ESBnj7EW3s/dojAD3ppBc7PTmnyaPmQA1SRLEb+U71lERX8RKQxARpK4anXsTVbuukA+TeqX5VrL/mvLsgGD6Bfrp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_19,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406060168
X-Proofpoint-GUID: H0yWCf1VdQtMdxE3mKb7NTHBp2rV61nt
X-Proofpoint-ORIG-GUID: H0yWCf1VdQtMdxE3mKb7NTHBp2rV61nt

David Hildenbrand <david@redhat.com> writes:
> On 06.06.24 20:26, Stephen Brennan wrote:
>> Changing PG_slab from a page flag to a page type in commit 46df8e73a4a3
>> ("mm: free up PG_slab") in has the unintended consequence of removing
>> the PG_slab constant from kernel debuginfo. The commit does add the
>> value to the vmcoreinfo note, which allows debuggers to find the value
>> without hardcoding it. However it's most flexible to continue
>> representing the constant with an enum. To that end, convert the page
>> type fields into an enum. Debuggers will now be able to detect that
>> PG_slab's type has changed from enum pageflags to enum page_type.
>> 
>> Fixes: 46df8e73a4a3 ("mm: free up PG_slab")
>> 
>> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>> ---
>> v1 -> v2: include PAGE_TYPE_BASE and PAGE_MAPCOUNT_RESERVE
>
> This has a conflict with mm/mm-unstable.

Thank you, that's what I get for developing on master. I'll send v3
based on mm-unstable once it finishes compiling.

-Stephen

