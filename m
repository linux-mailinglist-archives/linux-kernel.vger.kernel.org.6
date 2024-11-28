Return-Path: <linux-kernel+bounces-424838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B55959DBA0C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74CC2281B76
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E731B3F3D;
	Thu, 28 Nov 2024 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L8ERYzde";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KUnt5r36"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900F81AF0A5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 15:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732806419; cv=fail; b=kMl7TjqRwEK1qOnMdn3AxmO+QcMDDf0FmUOk0C/B13A0NAI4+ngLFFCWIb1EW+fkfbgojMZ9Kakor+kd3xiZg4wfFAR2DfZoxXmC/8WUv1Ox0ztQ2oCaNQXyu0/TSfVta+LK20jK8GWUp8VeU9iA32udMFfwPdo69wXBL5iWQfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732806419; c=relaxed/simple;
	bh=hR1hptpTA8nuW1qw0IF8MJdYBHI3XpZRNziHdxNUjbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iCsI5x9fOOkaqFCZqq8MgMmmE8yjgrklmOcskyilhbPWo2A9Xpsr1Lw7aMtA0A/Hl4Vl7Sw5GTDyhCIA+xRg08vIeoWXGH3dEFqYCYTUSbZheVYHPSgvDo18P+7JvLhsWPo4Nv8Qr/asyoVKIgNg6sD+0sDrwxx9MLoebo1Ueow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L8ERYzde; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KUnt5r36; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ASEM3dP006799;
	Thu, 28 Nov 2024 15:06:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=GqmS80LtTq4glj/r0JufhatLwW4dPy91kyJOpOlImGg=; b=
	L8ERYzdeEqLrsN0d9TA2K+9U1dqA7HeooXTfyGJQYWBtkUm2cSEmgMBpR2d4inA0
	PhA+S8fDRDOJwxkNpgrPgdgUY+BZd/4SpZm7bZLWQlTh/0W8fBQJAH9W1ca3busr
	x/4DIX2u4872CAORx2ts3fJvgvFX98MZmVTwLewP7cpDxtGC6Dov6uuwWuqu37LG
	THvyq2BVo7wYLqr0hwvnRZie+IA5UPsn2FsrfaAZYLl/DwjvM3ITIQ2YvEoLn67Y
	2v/bXGqXpTBjkqtgi/j/0K3VAr6p82duaJO7peMG+q6xStrBEtcTMzrG26cd1G3t
	iyl0pGiqmc+juaLP5ZZdbg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4366xya162-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Nov 2024 15:06:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ASCaKw1014352;
	Thu, 28 Nov 2024 15:06:34 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4366yyqb05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Nov 2024 15:06:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RgeL/zzze026byi7Ql2Jc81R93ODPZiQCM3XxrlMDG2JfO4r87vhfcZOj0d+VZ7MvWtC60V1Yp07JTUlKzX5xpYi+pK2jbw6JC4FN8kztXSh3+i5RxZ6dF3SluehZX38DKuc97DTk4fJYu4rfIaSuE8B8qe1pTR1HpEZrDJljowTZ3KlnYwCc4xC4y6B/e8HZG+mRaizJAQXyvm9SqWbegm3Ljmyy2L6k6nzkr5TGB1oit3HgGJZHAd5hxdu1SufV0st5c/bHC82uLesaQTYKCrNH0UQ1czfgU6tebly0lKPyOeqBSczkf/ccRnfQ1Ey7KHCnZWl0hldyAaDCfZ7ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqmS80LtTq4glj/r0JufhatLwW4dPy91kyJOpOlImGg=;
 b=kDko3InPnLasq0rPbfQfrIgnNLhwVCddBGom5YWXpd4ZXA1J5tD5d+TCqxkcu9UtM0kZFyfAek57lNCoC5EBq8XLeQutrrMWtvXBeC3JPV7a21HaOSpeW2g+q5yEn4wSuncfUih1z2ud0R3fp7ObUXsYewEhW6ekEV5+LrGjMTAR2VfBXhRcpCZeB6to1nvKmhk1dgcW8zD6baIHA1L6GEWxVshLMJZ9Zd235TtxxtzIVWLzdsxBU9fp7DUDY7L454CrOo22GPfbWnhyFVmNBwfuMDCIYpA7cPuesusrDWHQDdFZRCDlMI3refSrs9eCqJLG6o8MQr5i/Gv7IeYxzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqmS80LtTq4glj/r0JufhatLwW4dPy91kyJOpOlImGg=;
 b=KUnt5r36ULVkeZpPT4ELd+UVjBKOr+uzbEeTyJll25Tw0HNNpZfR9IuHSAWI0/hidX/xRXwOb5GTJgfzt1aDVfsFsGrd8M+mkTHoODsT4l1Geok18J7qHuRRQpZvS11mQCM6ZwoWmcfGsAcj59SJ53Ow+jupsa3EN/nUWoXxfB4=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH3PR10MB7958.namprd10.prod.outlook.com (2603:10b6:610:1c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Thu, 28 Nov
 2024 15:06:31 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 15:06:31 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Shuah Khan <shuah@kernel.org>, Julian Orth <ju.orth@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests/memfd: add test for mapping write-sealed memfd read-only
Date: Thu, 28 Nov 2024 15:06:18 +0000
Message-ID: <a6377ec470b14c0539b4600cf8fa24bf2e4858ae.1732804776.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1732804776.git.lorenzo.stoakes@oracle.com>
References: <cover.1732804776.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0455.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::10) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH3PR10MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bce3790-9d90-433c-405a-08dd0fbe3e13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iPxt8gzAGiobHLjsilAd0QyuzF4lGPHuRPEIZxBXUUv0xzVg3CLAW7lhnL2S?=
 =?us-ascii?Q?fV7bMHdigYcVpMBBIoQ0+2foNmHmLtX5y5RwJCC4kdghCjKFVkvje9O0no12?=
 =?us-ascii?Q?8dJHBxxJOfROTrKEzdxu8uwgtn//sXK4rNAkujsIbbGvAt0r/IepsyF6jH2F?=
 =?us-ascii?Q?xrWDe78WI+CblUASI4/ntgvB0kb74ESn+X89bOwRO4DKY6t5jEft4BSVFWqM?=
 =?us-ascii?Q?uvJclLvEjDT2ye4bl3QwtRR+6maZKCQgaP6bpII+m+xLSAdGma/wTh5GdgD8?=
 =?us-ascii?Q?NZGsT5gluL0f/62qccOYikNoytD7C9PhqQ3C6tDmDVa8y4ah8Ku0/Tv8ucMP?=
 =?us-ascii?Q?z7KZGpEMWl5jF5okXSlFEYYP97vcZFqzh6JqM1PywYqeaMg68RsZwSbY+b0y?=
 =?us-ascii?Q?MzNnqKEuF4J0QmL3XrwopXuebxsmmLs7ZVwXq7zoafdMj2zt4QmCXUbsVrxM?=
 =?us-ascii?Q?57fYCp3wKmFpiv7hRYi5YiKudFuf7S6mocBnAyPGSzdx/i4kj1khxgxXIfnz?=
 =?us-ascii?Q?js2kY0Bz1vNn0st91pC1IVtJ9mE4eb2mzm7zfVTKjxZHd7oHCHw/HDnkfylh?=
 =?us-ascii?Q?80vj5sxjr0c9jdbxLurxAi1BQsLRIglG0IBibuX4a4aflLiRciRe4J7djf0C?=
 =?us-ascii?Q?dUwGOtGUJiaNbZOkyGccRZ6g31tdJEW+WfAtZFyDe2SGPeqPgQ6K9x+z1Q+k?=
 =?us-ascii?Q?GHpzWNcXXoyEbe87cgroIvGwaPsBEBJUbWtdtS11gxey/XPTn9pHLloUR6iD?=
 =?us-ascii?Q?8wFmBezy/651mC96k43M47/kVQ1/gc0GkmDFf+Lp5+snKOzyG7EynOeLCaRX?=
 =?us-ascii?Q?hyvep1KZc9PX/u2rBQX7sIO/N9ABP1rcpPMu6MdExCdg8pBciqB6Ni7t/k3c?=
 =?us-ascii?Q?9S/Cizk6p8MhFOYL2AQLLEnLr0u00C1RW0tqmNtIcYUfIcJvNs/wcYJzS5mC?=
 =?us-ascii?Q?m9DlFmMiQNulfDXj7g4r5C9ZEHtQGtnDXm9NIL01RX9TrWJz6SR/+pUo6/dn?=
 =?us-ascii?Q?i5NIFtJyRjiBBhqeHo2pADopUaXfmWCYukQEw6sgcgSpAgcKjtd2Ccjq4c9R?=
 =?us-ascii?Q?VQA/bQKEX7NMUzBz34bhpxf7PM6PYUCGlSBLI8xJAGGitctbpsmzHPe5MV6J?=
 =?us-ascii?Q?2l3Dp/yZqhqHkJso1FhP45LQQdYEwdU3B0A2NdEXFqyeCtTXA9Hkk5mq2oC6?=
 =?us-ascii?Q?nDjdDAme3g9RqN7bc0WS+Sw9p2Q1GYK2RZpMeQIybVjiExkvl2viWgfcOQum?=
 =?us-ascii?Q?uxGco4NOEbKSp3cqmtUdpbl3Xm9ghK/FpQdwbsQJkJxVb9VIAfHlxfoRusvW?=
 =?us-ascii?Q?DqUA5FdH3ag14pyyICkZqC2GrMzau7LkhNqeHZrcanInHQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UNXxirz0u3XP2KKeQt30BptzcbGBeQ+6i9GYWi7opNsCns9lfihj3iQ8GGOU?=
 =?us-ascii?Q?lu2cEaZGz6MsjY5dp8/V3DsQieLtim2T8qyEM1hCH1ndbIfHLTO18g5zimlT?=
 =?us-ascii?Q?+eweIcRFIHTeJ814RJ11kiAL2uL+Gad1I08pVnfM8paOj1Ik03Oqaxsd+26Y?=
 =?us-ascii?Q?qNGK/5ptcDnv3PPshWl4xUmm1AUUdvAmekOAdxPDD6LFdO1Qk79jvMsUcJDq?=
 =?us-ascii?Q?yDLgUpmT3TFbywkhNReLdSP3DU6r+YK+2f6AjW8K/Gax05znd8YUc4gGjM9W?=
 =?us-ascii?Q?/0/+ayE+jsnqjJUfES4UEP+A9otEuGnv9u3cb76jQxWKdTNoobzebAB156WR?=
 =?us-ascii?Q?AwaAWmvKItgNM1F7cUv04AwZQFG5tOsS8czbHOZiMSnqbSUeZ3Cm/p58dWy+?=
 =?us-ascii?Q?kNUkbwAiRAPqezIyAMn3vq3MEZZ4Y9i9IzGxxIUrZjzRAjNuIk0tIVJvmBLH?=
 =?us-ascii?Q?QJHFVt3b0kzWrvtkZLN8QiZKGvtQ1u9P/CO0V7qg+F0Q/Vi1SG/FcvXSKaUb?=
 =?us-ascii?Q?0fXN3fwYOrAdIAcVKmCl6IolCQ2nG2EXNi1dnmUsyT6LkC2CtCHsOqzH8qFc?=
 =?us-ascii?Q?5eO6brGikGCWn4CkGU1oifK+je8MsJGtuMVqwvXTm165RHBpMqBAJwP/SAXx?=
 =?us-ascii?Q?6/Q2ONRdYFaWAN6UHmlVwF/Ak2o1UmZmETr72LZGvD/kmqzu5e5oo1bfjQRv?=
 =?us-ascii?Q?cpWPpV3mdLi57vGwnMBYrq8DELlLq81VhK11gKx5kT6bpmU8RCvQ8P17o4kA?=
 =?us-ascii?Q?kAecTH+lxzpJNhaHicSReQTHi//Kyd8O2snMySAzZLZyEdRSGb3gJi+HVs6f?=
 =?us-ascii?Q?uVzzO0zcTV4SwX0IHlUc4qv2EJHS9petl2JkoNV1QaXu78mycrxisEB8FKDS?=
 =?us-ascii?Q?8LzrPx6LwYiyg/GbEXYVRudkp6rVkAyT+PaAuaHJz9i1C0YqrdOrVMtP4QmL?=
 =?us-ascii?Q?XFaHxjffMZPFXD0sEG4eP7Ap45jHa2+fMWCGomDoh8WpfWnTuaWkTCgXTBRN?=
 =?us-ascii?Q?sksLoui4ngRs1adkldq/E1lBNtdlYLaqQVOCjCIJ9tMZMVfoiZtOv7MpxN9n?=
 =?us-ascii?Q?gq42kiVCkVcGjyI28vHnHS2QRwnjiko2PsZKjkmGMwZFJSybxep7s0f7W8kQ?=
 =?us-ascii?Q?Ol/od2NaLSCW2Lpj23+BrbdOWIboYLckIVo/IxCURDNCwsaq0kRWGXfzw3wf?=
 =?us-ascii?Q?hZL1FVwEbF4M78rE8ZuuRdwOvAx4ITVt/dTGC/niG6phf6ApQI1JZ6syEB2/?=
 =?us-ascii?Q?7lO5rw8MHpkJzuAWkZICKk9dZ0lHW2z15kr5HeeN2FW/v9UKe6EWVYlxnqhO?=
 =?us-ascii?Q?AGqaooE56dn2StS1Haz5ElMjEQ2kuAdQTPbCA1raZnQMKuQCj62NKVtgRWud?=
 =?us-ascii?Q?2+T9FpVNW/hw+KvMgPvd8Kk99MkNabOWfUDZURagaHShHSuNbVSPToyqioPu?=
 =?us-ascii?Q?l2Ca26A/0lAicIl2o12j5UxN62LQSfYZuqsvZdU5a1QB9aKqI8MzQyHmSPrz?=
 =?us-ascii?Q?vOOi35VP8AETmadA17I/cwplDGWsa7qoHdajBRZuvhmHckdAX7NtsUq6avhQ?=
 =?us-ascii?Q?v68duf63mtUugSmmXfeq5POAuPvcou+VCMUqVdfV9Ex/XFmxK/HhE/22Or4x?=
 =?us-ascii?Q?TA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cm1TJ4yaPlooZUDlEKU792ytBoKPvqNGLSahuINg4NWs6L0Tno9yfQ1ojkFO5qbl+/ut4Yx06ABCH9PkR5oNQQN9omj1NuQJHBMy5epeOOLZjXqvkK2GUk9jmvOWrOdC0N9ACO8SneXZfYXDpVQ31eB1j7SK2DdcQDbSEOBFr+rpbwwEelIXblTxv+czbIaHeLfPSBOAG/ouYi6a81WxYqjJFqRuNjHzTtxriArqJBL4pYKvKeu+lsblDHLlxDsn8Ygvz14YE2EmnUEFDtglm3lWmnqTm/miq09pxW53wv4WiXEUUxYpGKAPRs6Z8zSkMxHKlSqXDxkfd2b29ZeMj2h28cTiQwpy3KGORTi0U6537eh/+b5jkJueppzqCaAsiIOb7A7/pomwL5O3dffWGK/9cTMXjOQ72UP+sKD71xH2F4mqYnPeNShqH0Mp8bMWBBz9evsQqEOEBSOTVr1BTPybl/qTk7Lk97tGCBi1aF6CedyrRtWrGbxGRP1ITJVZsyQz88A75EO7Zu/bFMCCuzTPqEffK58mUTKiHuIhZGScuiUibyrg/WIvTmliA+LPAnJxbBO4CNoA5WTlEogQoLBX1JjanTra4DDJEkEmVKA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bce3790-9d90-433c-405a-08dd0fbe3e13
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 15:06:31.7141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X9pdsK+AU9zT4NeCTdxkLDpP1dPfNEFEAVyX2r0pPS2tL6It21iezs3pyPfdPrvTGck1hs13UR0vNWhLipqBkfU/90hD4aOVz8tKv62pooI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7958
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-28_13,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2411280118
X-Proofpoint-GUID: U7vXqVuU5gvZvMtBV-plRLKHIawJiz4S
X-Proofpoint-ORIG-GUID: U7vXqVuU5gvZvMtBV-plRLKHIawJiz4S

Now we have reinstated the ability to map F_SEAL_WRITE mappings read-only,
assert that we are able to do this in a test to ensure that we do not
regress this again.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/memfd/memfd_test.c | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 95af2d78fd31..46027c889e74 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -281,6 +281,24 @@ static void *mfd_assert_mmap_shared(int fd)
 	return p;
 }
 
+static void *mfd_assert_mmap_read_shared(int fd)
+{
+	void *p;
+
+	p = mmap(NULL,
+		 mfd_def_size,
+		 PROT_READ,
+		 MAP_SHARED,
+		 fd,
+		 0);
+	if (p == MAP_FAILED) {
+		printf("mmap() failed: %m\n");
+		abort();
+	}
+
+	return p;
+}
+
 static void *mfd_assert_mmap_private(int fd)
 {
 	void *p;
@@ -979,6 +997,30 @@ static void test_seal_future_write(void)
 	close(fd);
 }
 
+static void test_seal_write_map_read_shared(void)
+{
+	int fd;
+	void *p;
+
+	printf("%s SEAL-WRITE-MAP-READ\n", memfd_str);
+
+	fd = mfd_assert_new("kern_memfd_seal_write_map_read",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_ALLOW_SEALING);
+
+	mfd_assert_add_seals(fd, F_SEAL_WRITE);
+	mfd_assert_has_seals(fd, F_SEAL_WRITE);
+
+	p = mfd_assert_mmap_read_shared(fd);
+
+	mfd_assert_read(fd);
+	mfd_assert_read_shared(fd);
+	mfd_fail_write(fd);
+
+	munmap(p, mfd_def_size);
+	close(fd);
+}
+
 /*
  * Test SEAL_SHRINK
  * Test whether SEAL_SHRINK actually prevents shrinking
@@ -1587,6 +1629,7 @@ int main(int argc, char **argv)
 
 	test_seal_write();
 	test_seal_future_write();
+	test_seal_write_map_read_shared();
 	test_seal_shrink();
 	test_seal_grow();
 	test_seal_resize();
-- 
2.47.0


