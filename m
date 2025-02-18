Return-Path: <linux-kernel+bounces-519648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3534A3A045
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC9F3B6FB0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C6826D5CE;
	Tue, 18 Feb 2025 14:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RnJaTby1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rxfTjlbw"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A966726D5C2
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739889469; cv=fail; b=uLY+MAQw4ryPOZuDY7EfPRahStc0l+P8QNOI2Z7wbq1H7BMP30zs8bX80kv3tUBHVA66t5P7hDAjH/OIXwjt5o89JJFLaZpWLGZjzy0Z/n3LA8sV5YODBaxvQ79L8/a17cyO5/O7ArAXJV0M7R3pZRo9NoGf1VT8hNSHKCrFpfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739889469; c=relaxed/simple;
	bh=C75HtqMIGAThiaNWgyZjfSnL8WmJe9U5SIFoyFqMMnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DpJqJA4jtZWsEBWyrf2L/D/Jn1GUwBYRP0Tc0zTcJ71318D7kjWWPqT4Kz0x7aw2ylyKLBYUA/L4ZOiMiN05Y5etMDJF0cTYQou2qNzuJXcMMob0/3isubzT2ZJQ/9q7tdfppTCW4AgxguEh/vLbsBS6FfV9Ui5cjpcZTTAJwfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RnJaTby1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rxfTjlbw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IEHpMi009013;
	Tue, 18 Feb 2025 14:37:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=TQqYcSq9avzwfec9NGYCEBpnITmBq/NDQG89Dq8co78=; b=
	RnJaTby1Lq4RjGGVHAD3pW1H4vnF3ixJispJLlnX7tMzFUhIzQrvN+oc1xZQ+312
	LqJ5nXTNLSCEuwzgYPGrlqlmsJb40cBkse7f2MbLM2Jibt0L0xwAw8cM+AI45I6A
	XpmFAv8C60W/H0kJBU1aP0YrYU4za2w1Fdzx6xVbmCsW5a56V9ISPlMLYlc6tYWj
	klad3P0/pqyjsXXf5VBKWwDNK1JKmanI3scWzPYY+k0uW8G0+NSeQATvc3aYKhqc
	KBIbd0xU1cUVjw6cdJJJbneu6pIjgW3jM5H7Dl8BoN/WdUi+tiuFrgwwiPj0pugA
	svf9MOhSoqbpomoBQpzLfA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44thq2ptdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 14:37:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51IEPFjH038731;
	Tue, 18 Feb 2025 14:37:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44thcacxeh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 14:37:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LbTSXPkBwcGQu9X5/azk6D5TcDcrdP9EGMnxK0KGDQmUElmYI21uiZuu8iQkzwD3wo7oItcXuxcayIlnQQpfkpk1U2d1SzMUFybfVF9lyIA2nILCGdxKTF4dobbrc23n4WCodLGv8bRhktjmABevFVnFlxA7/EkISMtTRuNwuypvk44b7+qDBCFZghlYadG/tn60uZiKyo6kR+HOtoFN3HKMVTd1ef6WiCIA44n0L4WlSFYmxmo19rvz+ia/8y/2xVWvuJScc9AGeFGQcPVxzvVs6PpXq7bS3k8T932hRBQPnOIUKBL68poIlf9pKwG8tmYzPHeMGWIW13sPrJsdMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQqYcSq9avzwfec9NGYCEBpnITmBq/NDQG89Dq8co78=;
 b=yqeWVErEF7oO9sWR2mjWFGYvVpC5M7bbrurXtpNVHDxrvK72Uj/AWM/QsjgFrx64w2SonqunmgHs81rahuLu37pH7lfGf7iEpXi8HnOgi3gXrxTqE+vkKwGo9CFASLuRYjcZivAHDJdODkDCcr5wk9efkXpyT0NsY2Apl5s0zWruReDL7DfC+wbmlUsmDzEoPlnaGZrGQsp9vvWaMLxCNjBRRWKDrvXvj3MYzSIJbtTEuL0WjL8i7xBUixJ7SM4IrqDXsWdNr3ZuNfyX5dsSFVN/riwpomUR4zMz62UuQqwCJEbHt98nM/haJl54+lru56truqR7JvbFugwIabO2aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQqYcSq9avzwfec9NGYCEBpnITmBq/NDQG89Dq8co78=;
 b=rxfTjlbw+1rBz1vlsVjpQp+1vhhb83F8VknnOxnzz9EKhRFvkYTnhHuwSDsGBXruysh8LP8+Y23h34lPv0Oedt1AorYGAfrhTuqT/pZi5wYeackPBvdkxc8G3JtXh+CmztG90SmaLEi+Mc2TdhJtNOAcQp1FsDlhavgKLhGTZoM=
Received: from PH0PR10MB5563.namprd10.prod.outlook.com (2603:10b6:510:f2::13)
 by DS7PR10MB7251.namprd10.prod.outlook.com (2603:10b6:8:da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 14:37:43 +0000
Received: from PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240]) by PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240%5]) with mapi id 15.20.8445.016; Tue, 18 Feb 2025
 14:37:43 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] CVE-2024-56642: Fix mention of wrong function.
Date: Tue, 18 Feb 2025 20:07:32 +0530
Message-ID: <20250218143732.11095-2-siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <2025021831-sixfold-geography-c6e8@gregkh>
References: <2025021831-sixfold-geography-c6e8@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BM1PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::23) To PH0PR10MB5563.namprd10.prod.outlook.com
 (2603:10b6:510:f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5563:EE_|DS7PR10MB7251:EE_
X-MS-Office365-Filtering-Correlation-Id: 99ae7d2f-02e5-41f4-c3c6-08dd5029cdc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xGmQ8msllJ6SYE4QeSMYLniKRmzYjF+A4KP+5mUBJv4X4AtzmtsagwcfRTCi?=
 =?us-ascii?Q?ww+1h9S5zWf9UhZcgrHrfOYgrReWlPtTYaCcyfTvdDkIS1e+I1z4f6NCAaL9?=
 =?us-ascii?Q?VCBpmvcme6L5aBUPw9GhIJdSeDN3mno8pKTVb9TXnpaR4BycPLT6+64PtjtX?=
 =?us-ascii?Q?6iIJ+iBjOF7llJEOZlMyZxB4UiaoBTw1eXWF5D7A8EH7KQhkS8PwvvcI+/b2?=
 =?us-ascii?Q?jSgW7/mTjKATtIyVb9trx9K7mxQ6WLltzs8uXIit1idOVHMul1GR+mYDxBXn?=
 =?us-ascii?Q?FI5NRHyYxPUCqPuAzfxcQq1PKTDYFJ6S882p3lj/v7F7Xhgioz4tC3UAEkwB?=
 =?us-ascii?Q?lGw2pJYNFs+ZhkWkXoTVKEQwVIYKtZmSOoPC0z9H7dKAZF7mRcXH1P+ej4g1?=
 =?us-ascii?Q?SPpPfH5Y3z+G3YXbFwcM9N2TdsLJU5ho3AGfu89LZymtukGkjYBc7UF5rYe5?=
 =?us-ascii?Q?byC8cbfAstvmRS6lFFRXiyU0VGBedPK50F0xKxI4u6BDvlMiuoE4BsiOITH2?=
 =?us-ascii?Q?mDh4ZI1ucc1bcmb/ITCElno4rwapTkurvFlLAhmjGkO3Od69KKcgHJU2L5YL?=
 =?us-ascii?Q?CawMR2/NcOUMXLS/1BMk5cHl/XP/JW2CbxckdJMskHDg3kS0WEqRItiItFef?=
 =?us-ascii?Q?/iuqQxrsSH8iKfnuC3GqtpRyVpn8KHGBtv+d06jakL0jgMye/rSwfIBL7T5C?=
 =?us-ascii?Q?El0nlVpkgloYGTZmJ2AXN1zGgfmg96EcUtQy/cFs2jvm0MMsgMST2vq8HSVr?=
 =?us-ascii?Q?womGy1HV9cM+0cNLsAz3fjbyFXAwbzMhuB74YWJb7+PhrTk7j6Kr+fpKDldm?=
 =?us-ascii?Q?PU3j442dpl+rEdsVk0kMn80CPPG73O1gEUi7HHLBi+Lcfc8K1MS/o86alrPh?=
 =?us-ascii?Q?kZQyV2xMejN3lT6FqLc31/W6K9ECSZs6zPDCr15frfdof1GAkb69Z/Go0R+e?=
 =?us-ascii?Q?yl/yh58aGpy+wiMiZoaGt+fKS+CZwuWwHuKyQ4NQJMMEZ1xgB/8KHsFQQWty?=
 =?us-ascii?Q?0OMQ+ZSU/CLkPo61qFvvT1QPN/LYRSR5uEBfYdUrXTGf3I9n7Ql9Pa0NzTsL?=
 =?us-ascii?Q?p7zcLIO/5CMBNZ0EZ3MSsKpx4ta8lIaaVDS9sBzPMuP6kdHIBsDJnroErzYs?=
 =?us-ascii?Q?b1V+qOg2pXxpssWb0n6bqeLetdYWh8zsyJ1/DmVKvTuIOnYI7qfMrMLK0Nfx?=
 =?us-ascii?Q?HbAK2uDnG3xxLuoJ2WvNP5EhyLqWYnG0+s//OyiJt3hwBW2e29GPYLIB4dz7?=
 =?us-ascii?Q?3QT2lwk9rUWAF06/k0h6o7GxzePukAB0nDBrhqUefyeMl2CLgrhty5djZLbb?=
 =?us-ascii?Q?k4G4XKzis6ALAMRamq6o3+zY5yie2EZdEdWeZ9jaMmdsFJ8ZZy6pPA8ZF1NC?=
 =?us-ascii?Q?X/Ua9jf9avxxmR3GVtPJi3qcVRs0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5563.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LPKHz09TgkSAwyxZMSsD0kDQdIf0sIaUkcSQsvYZZNF8s+6G4HxIU/b4D5m4?=
 =?us-ascii?Q?VPW0+BviezYbqC+sHxGg1FD64pCaicUo5aog2xA3bbK9ivR1R7gTw1bbBXAl?=
 =?us-ascii?Q?XBjan/LI4A4hIioqbgQzHi9uOS/Lhi1eJdVJoXjWfKWviGFFtbPCabE+rGUY?=
 =?us-ascii?Q?FrPIJr/n+polo9urec6MFx0tcOqXCFzaqBiWO2R600lUl9Lb3M7ES4KwQm9g?=
 =?us-ascii?Q?2w3O/YHosvi81VwHqFOO5mhNSn0sYuggoguqqOyabYujpoBZRl+sWL6ZtELW?=
 =?us-ascii?Q?mCTkAWBWcGbCavTNtk5Q6FbA5V4ZOkvn9GnkF4IJzW5NZxc7dF44PLrUzLjI?=
 =?us-ascii?Q?/qVsFEoD6tXDBO2XzV9i8Na4nEnV1DbscT1TyiCogvAG+i9QQpX3Ii49Zo4a?=
 =?us-ascii?Q?4HxKO5Zu6TFeGCc6s6UmuRy8OLMvcXBpT2ChGdoaHQaOr2I1o5kEbxLBSONZ?=
 =?us-ascii?Q?eNpqaAnbMkUf0X7jiN9chpMn15nwr/0GvJ0ebeQgcwSA1qLfc1PT6iMHFJ1e?=
 =?us-ascii?Q?ywE+7SxTgzfnoH0X62BccFXJOnq5+QrCZmJnNcgB2orKFB9gvuBOm3d7Q4Y+?=
 =?us-ascii?Q?MaDt8ztMZTDFGWkRwj8YQdH7QUuRBnlciNGK0LUzsat9ftf9E6WSQWTrPVgT?=
 =?us-ascii?Q?FreeYD0KzJaPyKutg1zAJMRvL1P+o1qM5HXCnWAgcAB/jOHr/BbAfQG8kgUm?=
 =?us-ascii?Q?Y4P/Vk7/h6kOt7nYU9hHAIYezAUwzFVkYrwJv/OB/h9b3VQsVNmaGiXKAEps?=
 =?us-ascii?Q?dDOcbPz1rcJYLISoBAJT4yyQwfBZYkMiYHe5Uk8sUi5KhdY4+KUWuKbmwZ8B?=
 =?us-ascii?Q?zzpuAWvCRnRGyH1YTeHjpukF8mgN0YcYMBxiJzrCXPhRMAzkkRL4fq9vRtAk?=
 =?us-ascii?Q?buj61KCcjiUPmtw8AcYeF+jDlTAIm0ET6f7AQ9Qgrwx+IZwterPrCDA5xfoA?=
 =?us-ascii?Q?cv3FQZjbdddDDvCiK3M6H5pXZmRvFiH5pcb+nW+i9R+aGEFmdevLSoOelMAa?=
 =?us-ascii?Q?FEItkJHDTGaqAfmB7Esj7JmkBTi80PaQcVG7aR57ovj2k4+M3DAPMT96qtph?=
 =?us-ascii?Q?9n0YMUOviBSCxeRQmK5T5mWEqtG1jTTkdBMBenTLfBGX5gmtHvyeNUniWF51?=
 =?us-ascii?Q?2dzsyN4OWI7EzwNcise84Ch+rPbZr+aI7uz4xMUZazDRdJcAv2vhLRjAbh+H?=
 =?us-ascii?Q?178k2GbAzAMirYl6FmFmJiRNVTusVHcooex3m11ttdEJuXiq+3hD8ia/XoLu?=
 =?us-ascii?Q?OaOBCSXjcFjQH9U9sbozgrvwt5IYiESjZ3T2OjLJIqC15cQNH+yRl+gR/0eZ?=
 =?us-ascii?Q?iTYF6Xgs+zMoTnbGgIV2kbm/LxvQRVHG4L14pL8z9M8XinpcOSJjsM8LqC92?=
 =?us-ascii?Q?un1qaY9kHOU+0wg6RZy0IWvbdxrnnNkz4+xaQHfACTuga9jk9O/uHBJSEpvv?=
 =?us-ascii?Q?Z0ydFA3DgtrAc3fTk2uWAU5rNPfHEtmAV6exT9V+MdLdCokoGts6vdjVoo8W?=
 =?us-ascii?Q?bECIqxNG2ij/D7yJwWsP7ciqPJvwa6zLggHm2Hx77bbj7671QmUxSRW9JLs9?=
 =?us-ascii?Q?l5dKQoRgbRRlgwuFx68Tj8pnwYk1PognNKex+JFhNReHFhb2YqEjJJEA56Wv?=
 =?us-ascii?Q?4vfmNAJzzMVg2fc0Cjy44MSFHuIwXjh+ZRCdFHi5JaY4KmTqFaQE0yxHi0t6?=
 =?us-ascii?Q?KGmFww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lMkLZhwjzJTP0f6582fPevj31xeloTzIgzIo/lV8qXIrkSuRqEf/9NZJ8oE1/kpRY4zjYcgIfWPTk7VC6M5JFNHG7RCiNxDwFTYqnLNsJCqcyQKdBxprbrwasrAnP/FIkP3XreX6byqWStFvhJpx16YDTXpzpdqJGtU+7hdScCx9r+yjd1lAGaOVzAAC2/V1Ef1jDoV0blR0djLHUXrcYQBU6Rv0ae+3JSUWScCBuGAOHxFDHGx14L4XonisASoScnvMuQbspxE8YVJ9SjYqHCW6Z6AoNX4F0vbiMSkAoFtz5qML6pTIG80oy/anQjrEw6MJud14PDbM+KXUCZ7c5O0N5llKJ5JQt6df7BjHw9yFsE9+Gy9itdDfiXdmnh1YVbEjARb5afd+h8Jqr1GwT8M4NkHSni90rwGfb6iQmZfr2yrKU+ggj8n6xLrZCthL1vX333cX3xRSA6mRS7N/AP6I5ZiWOGmQ6qh0HZhpGSzrZPZkoHiXF3nzGAYbgsLyx99kJCReodDUNqwgDP9wEgWSnEJf9+e5dJfTvclFWJNE1Alu40gmhFCrelcc/117BkTvJ4wjWLs1SDIg2766TwaH5LARzJoR22zBinV973w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ae7d2f-02e5-41f4-c3c6-08dd5029cdc2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5563.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 14:37:43.3670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +0a+W86Q6+vSnxqH+rRSlygRWdttCHwAOerF2DSa5J6U/esA2K2feJ0M0ThDbTDANSSFy2pGMVKgXF1UGEbeA8xNTJNjIB2KLQPon9Uzn9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7251
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_07,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502180109
X-Proofpoint-ORIG-GUID: jLq9FpLvFpVZ-qCtzAhzB1rAnZ6d0s2-
X-Proofpoint-GUID: jLq9FpLvFpVZ-qCtzAhzB1rAnZ6d0s2-

The function which waits is tipc_exit_net(), which has the spinning
while loop at the end.

Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 cve/published/2024/CVE-2024-56642.diff | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 cve/published/2024/CVE-2024-56642.diff

diff --git a/cve/published/2024/CVE-2024-56642.diff b/cve/published/2024/CVE-2024-56642.diff
new file mode 100644
index 000000000000..b31d3694986c
--- /dev/null
+++ b/cve/published/2024/CVE-2024-56642.diff
@@ -0,0 +1,11 @@
+--- a/CVE-2024-56642.mbox
++++ b/CVE-2024-56642.mbox
+@@ -18,7 +18,7 @@ When bearer_disable() calls tipc_udp_disable(), cleanup
+ of the UDP kernel socket is deferred by work calling
+ cleanup_bearer().
+ 
+-tipc_net_stop() waits for such works to finish by checking
++tipc_exit_net() waits for such works to finish by checking
+ tipc_net(net)->wq_count.  However, the work decrements the
+ count too early before releasing the kernel socket,
+ unblocking cleanup_net() and resulting in use-after-free.
-- 
2.47.2


