Return-Path: <linux-kernel+bounces-417201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A739D507F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 17:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36900B216DA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C54176AB9;
	Thu, 21 Nov 2024 16:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bU19DU5q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0EA82LHT"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E282D43ACB
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 16:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732205351; cv=fail; b=TxP7VKV8gM+6YG6MoWoPNPL3O4dHBJ29bnmvucSlkRHRZAEEjyw9mUXnC5nO4hokFvEEpgYTVufjpSzpKSC9+9qmLkX7xESKuhnnztU+R5cpdhE640zVRlONkLkGJUSV0KCHYAv+nqQm0S6rk6XhC0kB8r91ftDsGOCLDRZck/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732205351; c=relaxed/simple;
	bh=7FHUXWVN943CE6NTcL2E22YsHamOKtgwXSu29fKS4RI=;
	h=Message-ID:Date:To:Cc:Subject:From:Content-Type:MIME-Version; b=TkUu7MGTdIxquy3BcG9s012QDGmHu4aWKlH+BDcxlChkMur91QLscCag9keF5DQIVNsjNJsPWDwSoxRDp/5+UEO27LsavsB73kBq9wVAA57wqKMPMZnIEKD3KjClxQOaDQLrtF3uOAryqyPjBTyFb2b2Qs8V11IaIDJby3q0GXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bU19DU5q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0EA82LHT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALEtbX6001269;
	Thu, 21 Nov 2024 16:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=vIx1fXJkEqoqoFRk
	sXAjsOG7GavkmyP1pQLMhDxCh6E=; b=bU19DU5qKM0lFHx8ZBONjUtyVDQDhSBp
	DKANEerz0C7YSI61e99+IBOFtNl3I7JD4upzPRen7aPOB0vGMYdXqcf5Lyh/4ONN
	D8Vav8+/kNmH80bQPDM8NNDZBvJ0CTeaVO2vLwaP4/VphnAaNnOl8b6t65VRS6Iz
	O2ct+ld/ddfX7hRYFhDaJp50OxUsQghEsFgeXgx45sViof+RmoxeGmI0T6kqdDLM
	Uvd/Zr/nY1oFww0UDE5Sgs8shGB02rYNTEJ2A5nhf0oPbYpi9WxeEZkZFOveKQLt
	sJ7rWLQwGrrauWUO08Lge579HTexRKc7UyzsOea1nAb6t6Il4bSWzA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk98ssrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 16:09:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALF64Or038046;
	Thu, 21 Nov 2024 16:09:01 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhuc15h0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 16:09:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCN3FyoU3Ff1Wf1WiN3lg67iVeeQCE7Jub0M5DoRiK7PgbpQ9WnwUbbmHpINkqxrs+sF9o1vJLtMYDHz5FlNH24eiDWfa6kEhy1khBII24GhAQ71Gea4v86B5Yjl5OEVKHT2aSVPjc0gqo4Q9drZTWCSyYKNA/WXQNvxlDT0P1o48+tDskNe9fbraOycEW3G6okhjyfSkcj8KhXrCH/mBMEpK3ytG7ZN3z7Kpn7F3/neABAjMsHhrr4QTvKHVlkSdsuo3w5Sp1rTd8ygcaXT7Let659O9IC3MtTbfsVlZGaW429GdbSOMVMLEvNgTQtMDo/dX+AVOu7UYHsUNhEaIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIx1fXJkEqoqoFRksXAjsOG7GavkmyP1pQLMhDxCh6E=;
 b=h7JKCyikADITZXg5RYKbLGZl24ovkmfvc6WsWekHTcqhF4vks2JpRc2dwXMtt78sh8kdeIbv9wLYAYvr93zzHbO4f8r3SKDO6PlgSDOpelcGVw0klmLwAfsu5gidV6iO+An7FsUYynrqnplUOK547IPkWHn2VqCasg9Cy+20Sl/7wZQpYDjdPCzevYK2q/H0s+Z17kggDkrMSkC1/wKbBe7ODnGkpO2bM/H8ttmlmas14Aqb32Z5ArGrEEE4TpnvWOMCOuxuD4O99TvbNuNUkh/DURelY7eQSWREjNwD1beZYEMT19hIw83aEunsuiVSxW+yULpoASKb9OYQLsdbWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIx1fXJkEqoqoFRksXAjsOG7GavkmyP1pQLMhDxCh6E=;
 b=0EA82LHT+nVhG9hDneF38M3DZvVhDd739pd/9L5JfAg6bfJ0Yf20lV2Z9Uap5GyyC/OasfU0zF/rpFo3aYsKGDSx+7WHAT06OW+t2SgqgXQLm4bH9jxzFvfFWRMTVOo5Ag47vYqNtJBP4yZmdD8sG9FjZ/YxSb/3vILSSDNlSp4=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by DM4PR10MB6279.namprd10.prod.outlook.com (2603:10b6:8:ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Thu, 21 Nov
 2024 16:08:57 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb%6]) with mapi id 15.20.8158.024; Thu, 21 Nov 2024
 16:08:57 +0000
Message-ID: <9c4c2b58-be98-42c6-8ae6-582c60bc9f7b@oracle.com>
Date: Thu, 21 Nov 2024 10:08:53 -0600
User-Agent: Mozilla Thunderbird
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
        "jfs-discussion@lists.sourceforge.net" <jfs-discussion@lists.sourceforge.net>
Subject: [GIT PULL] jfs updates for v6.13
Content-Language: en-US
From: Dave Kleikamp <dave.kleikamp@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::10) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|DM4PR10MB6279:EE_
X-MS-Office365-Filtering-Correlation-Id: df3ac88a-c0ba-48e6-9779-08dd0a46cd78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWFCRUdSaFJJOXdUQ0ZkYW9QdUtxcFVITkZNVW5yYjlXT0trcjArdEhxQUR1?=
 =?utf-8?B?NGdhNi80c0lCRit1WHpzZFlMUVZPY2RVbHQ2K1YwNEgrS1hsUndkSUtLYWNH?=
 =?utf-8?B?UmhGNWVrYnZpc3dsRjRxVHJTOU1JQWdsK3JaMU5Ibk1OTTc1aUFud1pSQVFI?=
 =?utf-8?B?VzluQ0IrR2YrS2Z6aXJSNmcxSzhnWFBGTzNZZGRkdDdEaC8xTmtYTjA0dVBi?=
 =?utf-8?B?ekREY2Y4T00rZTFtbG14bHJHRW83bU04eHk0RWJOdUVBQ3hpdTJYbWVuZ2Na?=
 =?utf-8?B?blovQS9uNGhDQVZYZjhzbXQ3QktrZHRWVkNxb0p6TGdYaUpZUDJweGUxM0l6?=
 =?utf-8?B?dEpJSlZidmIwNURqbTd4d04wRklDUjBYMEd2UDNDSmpqRnRjNXIwZ3JOU2d4?=
 =?utf-8?B?ZGh2bFBBTVlsV2lLZ3dhdlVsaWZkQnBpa2tKZVJkYTY0aDVlQklnZk16eFpZ?=
 =?utf-8?B?alFCU1M2akpsaXZvUVkzb1VWZ0kzK3BlYlBtV0pSakRmVFIvNDdiY2VhbDMw?=
 =?utf-8?B?WGJaY01sc2tvU3MzTm0rZWpucmU4ZWdjbnZoRUVMQlVWb0FhMTl0OTkrQ0dR?=
 =?utf-8?B?WDRoYkdqVUtrMDZpMk9yS3VtelE3bXBLN1htNmlIU2tRYTF3VmIwemZFSStm?=
 =?utf-8?B?QlV4elVJZ0ZtbThNN1A2Y1pzZnZCclJoMTlDaytjTk1mbFNBTC83eitJUWJw?=
 =?utf-8?B?YVZsMVNxTTlvaWMxeG5pUnFpNmZUZzFXeEdiRlJxMytlem04dGVVZndmdmpC?=
 =?utf-8?B?aVJzaTJZYWJ1VHhxYjdLMGwrdEg0UWdCS0RmMlFncjlJSmVIRnJBZWZXUm5O?=
 =?utf-8?B?QUZTb2hjeXphRGNDNXVPMjNlaHJiM25WRk1tRFVHeW5wZkUvWG8xS3lqb0JV?=
 =?utf-8?B?WFM1Smkvdk5ncDV5NWhEbUlWNGtydG9YNHluNmpmb2dHc0dHOEFremtlcFhs?=
 =?utf-8?B?MzVZanQ1cVlxWVJUbWVkUldrQTBqRlA5N2UrcmN4ekJwZVV2UDQ4RVl1ajlO?=
 =?utf-8?B?cHVBakVyZVd0M3BSeXdtcVBoS2ZnK3hCc0pNdXNFOUdaNytsUjVSbmF2amJu?=
 =?utf-8?B?RS9mU0UvNTFQa1N4ZUVSem54QnZkaFMzU29YeXhCY3g5VkRVVEd4V0Q4NG1k?=
 =?utf-8?B?aDcvaTRHa3NCQ05oak5BOWlXWjZoSlJnVWxqbldIYXdqZVpiZS8yT29kTkFS?=
 =?utf-8?B?QkJPK1g0bEE5ZUVCUVlFVjRaeHk0OGFTY0lxZDJMalJZbVFOeXZTZUtkSUZ4?=
 =?utf-8?B?c29ZQ3k5aWd3VWExMHBpdnRRbHZUSFBhcjNZTXdDT3lKWGI4UU5aZHpYWjJn?=
 =?utf-8?B?ekhGOEVweUxvNHJqWEJsdWZzRmVCRnZ4c2F3blZ5Q05QdWZyWTB2TXRYK0dz?=
 =?utf-8?B?azFIL1l6L2JVaW00dGVxcDgrS0pWY1lMaW5VQ3BkOW1PL3FVaXRDcE8vSkxX?=
 =?utf-8?B?L1BNbjdCQnV1djFGL2YrcXJyRWgycnBNbzVNelN0T2pXTTNxOEZoMENxZHVt?=
 =?utf-8?B?NWdLeEROa3h5QjRCK09zOW8xRUNFTk92UERTRlB2NVIvYUhvNmxEelo3VGxK?=
 =?utf-8?B?NW9LRjJ2ckRycFJjNlZPZElIbm9SbHZGOGpuaVp2YnVBaysvd28vQVYzT0M5?=
 =?utf-8?B?dHRmZXQ5T2o2TTRRN095dzhZM2JJY0ljTm9Tdmgzb0tVNTBCWHJwaFQ3T0hS?=
 =?utf-8?B?Tm1IOC9HU3pCZVJURU5lQWdCVVJGVGpaT1pKcUpCaVJTSUxPSU5EUmMwUW42?=
 =?utf-8?Q?8wzloyxU1AvJb2Mutg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REtGMmozemkvUndpRlRxY1VYSFNwZkFQMlB5T2tnbTBvaW1DRWVXOFB2cXF6?=
 =?utf-8?B?MXZpU0c0OXBOZ2FHRHRIWlpHWTB3SHEzNysxRDloSmN2OXRodVU2dE1RWk5J?=
 =?utf-8?B?RjRwYmcvYVgybVAxakpyeS9kM2kwdXBzU1p2ZEdHSE5oWmV4aXI5Y0VPYTl1?=
 =?utf-8?B?R3l2bTMwZEFFbkUvd2hCVlBWN0drUUFDZU1LWVF6Ylovcnp3L0VhRDFKSmFp?=
 =?utf-8?B?cmdnampDMEY3TDFqTWlMbTl2Y3NoNmwyOXNTbXE3elU3Si9OaWI4VTNNL1or?=
 =?utf-8?B?L1R3RFRuaGpwZTVGV25mQ3dOMnAweG5xQVhHMXRPbEw2bDU1MFZPcFZKNzVh?=
 =?utf-8?B?R1U1SGZOU0tkd29CNlI2Z2FFeHZVZE5BN3VVOS9XSFVlcDNzeTliTEpFY05P?=
 =?utf-8?B?ZVNHZyt5Yk9LTUVueWNhQlhFZzFwMEJ3NzdlcVBwQXpiS1U1eTR5cXZkY2VS?=
 =?utf-8?B?NVZoa3NpOExDd0xCR0FCaDdpd1F1NGRMNXh2SmJUcXVTNUV0b2lpQmxGaHoz?=
 =?utf-8?B?SUtDS0FpVDNZMys3YzV6SnNrN1AzQ3VISnpVeGpxcWFPL2RHWDhTWUZtQ1k1?=
 =?utf-8?B?NUNLTDNLSE0xT2hmS1pJdW40d0RYQ3VPQkc5ckVVaUYrY2xhSVdmRXo3ME1q?=
 =?utf-8?B?K2gycmpUYW4rTU9PL3FmZUVXM1NPNytrQndvWGJEMHFxa3VGUG1pNVdSSWxq?=
 =?utf-8?B?NFhra1NLN2tLM1dLVEplMW5aOWdnM2tMZmdBaVdRS0M1MzI0c0tFVmNRT1JL?=
 =?utf-8?B?SjVTdTZXdVBNV0RaUE5NQjUvUHZWNmlRUGpVdGJ6TjNCK3JxME5nQ1RxeUlt?=
 =?utf-8?B?ZllmZXozN2JQRC9nL2xkaWxaeTFBb1dDbEo0c29kblIvRVltcjRJN0U4bHFh?=
 =?utf-8?B?bVd3Uk9EQk0wcVkwTTdJbTN0UUlJMGErUTZkSHUzWFdQT1g5SGoyTFpMdFZT?=
 =?utf-8?B?NTY0N29LZjNJMzEwTGR1OGVPQ2Nhc2MyVGZ1VHRYYVBaTjhPcDR4ZHhac3dB?=
 =?utf-8?B?RDhZOFJ4SUJTOTh1YmxPQmtjcS9ZVXZ3bnVPTHdkeWpzaUgyMVpZNGdTaGhp?=
 =?utf-8?B?c0NsaC9GRXVjb3hZS3VnMVphWG9vOTVUR2pTaEVaL1pJSDFCTlcySUZYdjJ4?=
 =?utf-8?B?WjlKWG5QdjBEVTBkSlcwT0tleEwwQVc2ZDUxenFGYmFMYXExNjZCRHdWSXZZ?=
 =?utf-8?B?UnV2RytLQkg4WHZ0bm1uWGZ2V3JaRTJqd0dlL3pRdjhycTQrQlF5dHlna3Ar?=
 =?utf-8?B?YURuVVZlRE54ai9TalBVTjcyUHR3a3Z0UFZwT1B4RW41NFpQWnVlQ1ZUaWRJ?=
 =?utf-8?B?L1czbURETjZjK0ZvYjdwQmpZT3VqU2hrMVFYYlh5MFdFeGF0c1VWaDdBbWlz?=
 =?utf-8?B?dWZHaTAwVVFCNlROUWxoWW5ZUE10L2plREx5SmRUemRUN0J4YlJtdDZMRXd4?=
 =?utf-8?B?dUh6S0pjeG90S0dpNVRYSGhQZUM0SDVENlFhNFBXSGt2akRqcUk2Vjl6NURz?=
 =?utf-8?B?clVPVUZ4TXQ1SFlwQUNKUzhTdlAzR0t4bnd1UHFyQmpKSXV3STh5Znh2ZkNY?=
 =?utf-8?B?Mjd4T0lKcCtod0EyUnFWQ0xBTGR3Z1BWVHF2U1MzeExtR1kxZ2l6WC9zNUdC?=
 =?utf-8?B?QTBZc2N3NDB5L2d0WUVNQno3V2lNUGkra0JFRUhrdTFmL0xmY1V4YjZpRGk3?=
 =?utf-8?B?Qkw5eStHdDRKK2xFVjR1MHJkdmkwb1JrNmJoNWNzaVE1UXhsMVcxV1VlaXRo?=
 =?utf-8?B?MzlBTmh1S3hDcDFKT0NySHRibmx4RWt3MWxTRHhxTFR6YitJWnk5N3lHZTdT?=
 =?utf-8?B?Q0toSEhlMlgrMnVydUZJRkNWZVZ5d3NST2svS0lmUXFJRlpSNGg5RWJ2S0Rv?=
 =?utf-8?B?N1p0YytENXVNOTlYMHByWk01WUozOE1LTHVXSWpTT3V5S2Q1R2JnV29EdnZB?=
 =?utf-8?B?OXJzSE1DV3VtcUZrT2hSWXJ0OWI3QUpHN0R3emNQNlpCNTN2VGp2cUM3QUU4?=
 =?utf-8?B?Y0xLTzdyOGRFdHhTeFRHL1NKSFpOdjlIeCtkempjb3FBcG5SV1VxbjJNL0NP?=
 =?utf-8?B?ek42Tmhld1RoNWV5eEEvV3lCOSsxOS8wTmJ6ZE0xR1d4SWczM1lGc250RUVR?=
 =?utf-8?B?SUY1TG9YZzdydGhUL3Vvak1ISnF6d05hT1NQSHlOVitFMS9NMGxDZDVYejB0?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wg6yptu5wE1p9KfjfoY9lh5Tzzd8rZpkJVVlzBWFp2XPP0b51/jeYBFMys6iTbeUmrsrLkJUtaZCZnoU8Rq1v2X9YejCe9SxQTe1CrC8IJi65INOtBMzLeIDnesPhKyfONRSErZ7AtWHJ9mcuIwGDcl7iNaDekxBA80k4tI4huJNo7BR48rl7K6iP9WgzAS/zQhVbytRnKFRYYfKuarBZbsvqf0qCAazW9Uf/6V2TOTW61sZlhtrIT74TSZPzth+uam/niTZ45lnHTQ1U9IDH/EoCeVuuyWed0qmVrrAh4ekOUC8f80zGtEyuwGREPG5trlQfh0J/xemTIqsHHWebjmcQOHzu2St/SXHbPVg+glNYy/4i/7mP4J72wzF/59Ya71ao8fWT9Qm1uZTaSdjZHsaiDhxl/TqTv7lGKO4287q7lFWndgc2d+eSXpR8NxliUpqFOKo6OYk/P8UTM9bZRPQTPjHAultqgtZBvodCE9Eo+/fhxjx3JlUuZu+pLoHU9x9rtffsSrTQW3eIlbCyRvFo5pNEScr52XPKfL4iSEXY05CuQ0cjbmfVTG6kpSrvmAj8zr9Gkc5/DygNe7QjYVYKUUHfCuu+Qh5wOV9+d8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df3ac88a-c0ba-48e6-9779-08dd0a46cd78
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 16:08:57.0210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0sucr+kTq3OFFgpdkR9yu81dBjyaYTjB9sBnVpG/vLXVfP7OnBWb7jCAuOBuVgIE7FPbdfd7Jzv5cWum6Ga7QBzPwJxGhzi0uDSzx+DxVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6279
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-21_11,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=933 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411210124
X-Proofpoint-ORIG-GUID: Y9PN9awgUZqvlm5nn0EXakvqqqCtq6VO
X-Proofpoint-GUID: Y9PN9awgUZqvlm5nn0EXakvqqqCtq6VO

The following changes since commit e42b1a9a2557aa94fee47f078633677198386a52:

   Merge tag 'spi-fix-v6.12-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi (2024-10-28 11:16:33 -1000)

are available in the Git repository at:

   git@github.com:kleikamp/linux-shaggy.git tags/jfs-6.13

for you to fetch changes up to a174706ba4dad895c40b1d2277bade16dfacdcd9:

   jfs: add a check to prevent array-index-out-of-bounds in dbAdjTree (2024-10-29 17:43:41 -0500)

----------------------------------------------------------------
A few more patches to add sanity checks in jfs

----------------------------------------------------------------
Artem Sadovnikov (1):
       jfs: xattr: check invalid xattr size more strictly

Ghanshyam Agrawal (3):
       jfs: array-index-out-of-bounds fix in dtReadFirst
       jfs: fix shift-out-of-bounds in dbSplit
       jfs: fix array-index-out-of-bounds in jfs_readdir

Nihar Chaithanya (1):
       jfs: add a check to prevent array-index-out-of-bounds in dbAdjTree

  fs/jfs/jfs_dmap.c  |  6 ++++++
  fs/jfs/jfs_dtree.c | 15 +++++++++++++++
  fs/jfs/xattr.c     |  2 +-
  3 files changed, 22 insertions(+), 1 deletion(-)

