Return-Path: <linux-kernel+bounces-263405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D47493D560
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294B41C21C56
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929641CD16;
	Fri, 26 Jul 2024 14:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H/lFdVTp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EwPBPkXi"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B114812E78
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 14:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722005573; cv=fail; b=Smg/Umt0yDiNoH83xDK8Px/Tk2kIBgf91dr4IROGsNVuGOgw0Jgs80cAl5oHWLBkXxvBcsRkN6GaFiXg4XHQSfQPDLiFoVPuWQWggyb2Jm/5R17koxQgmPg6564Dw0+UH4yp7V/OfHIvtQ2qSYN6nQgq+vy04BFzcQyQVpeRiFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722005573; c=relaxed/simple;
	bh=mn7KLkzbvS1MtTwHXVADTYKd3d8QH+xz2pXhyk+S+TQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bpxa102e0XHw+J3pNRKqIobn3uXYZolL3hFN9yADewSCUuyxggg8jqxemvDIyUK7YHnb7XkAeIPb2m9oUVZsFrgRAlhE4dQP5Ork8gA9fCa2yG/yCOT2ofi5vO+kYZw6OOSMqsuYTylYHURYeyI5BChqNz/4YFZJMy0fN+Dvzr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H/lFdVTp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EwPBPkXi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46Q8uI9O007856;
	Fri, 26 Jul 2024 14:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=907mB0qT5WGuka7rWGVvejMcoU2lZs+l77fWn9OwFiE=; b=
	H/lFdVTpg6c/If46PPKVNwqqMKL0cI1r75silektAT6YHgunUz3vyRoxQVsXsSqG
	fFLbqSNB9fnluMj+fPokZJSJqLS/3MxrwLmm2TiNNQqGMeX97VCC/jOc/XHBISQ1
	IIk00h258wU8kU7N2bEea2W6w5ELqhXl2bT37TTZurPNlAnFPNRx30XK58BCmOM7
	tSJ4VPvn1GK7KoSchh8UZnFz2pMfZEFK/OiQ5IPZySMVHABJ+BHnalaAugnaTc/t
	CK9vKEy1Dm5cyzL9GUis8r+NDAmiLkgQ6f9lcQbBQ86wEDCA80oVXdD3OheP5QuO
	OQv25NpXlqhL7dMpH+D/QQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hg115f4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jul 2024 14:52:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46QE0flG010683;
	Fri, 26 Jul 2024 14:52:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40h283wc4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jul 2024 14:52:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=blsJvwsu6E/8oKf2m86PbqmgTYncI+nnVxLhaIAVsq+0msiuZwaKqJbUnwzHOCEgR2fZoYVRb+a/GBJH4Jzik9Gw4hF+o5UrBFdmNPMeEgN2KTBehIC1Zady/tuLYSi8Ct3mWfZgITI/Br18G/IEofPa/Po/cWONbgQvFjVkyZQW2U8wl9h2kgt8V+mWOnXABVKOYlEeHwx+D5vEm8uFh4zpmKJ4DygGay+3KH0GnUbVW639EQhX6a3rbf1k9J2ysfxfXPbJzS4liDyLPyp0XPp4fkhz+sD4QBDNoZI5cBdytGFOcSwMEwAXNgl9z/6WPAExa2Vwm1r9ARTsNJU0Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=907mB0qT5WGuka7rWGVvejMcoU2lZs+l77fWn9OwFiE=;
 b=F3QuMDeYoiK3F67CyqxjHlfLkmTlO+73QPRy1aA9soeSHF3n+BnGxMhDW64jTlQWJgkEGIRkZcI7o7jnuy590wCrJqiRtUTUhpVWkFmMon4KwxhcRjxvwXco3YbqhLYXKGv1hF2fEP5lFSP0J+X+3wYZ0N+BHGJcdgoWVrDvT29gNhv1K4QB04J3sADlx5jNqAv7bKBdBBFwOmiVNQPjnLxm3mOGRg1UXkc65GgRuDAp9GZQwlPQtx7/TF0mUU9b/t6UY2cRSsI1qZqwK6r4U/QMfNGhhGR5mrJhce0tc8/FzNnSm5PvgdIfoFcOqwhpDURdotuvDS+kN+uJDRf2yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=907mB0qT5WGuka7rWGVvejMcoU2lZs+l77fWn9OwFiE=;
 b=EwPBPkXischtHWHp5BPEr03W72HZ5h7Mx91KOYbfXdnkuxvQVibsFqDBkEMdyAkCBsRQrJRT7iGBJZITQHdOMOrYbCCIlYj1+WBCC7fURLKy9Xwab7rFkOubBbfhBuud4XAGmZTbSS8K2JW+0c2rExZ/64ICGVjyL0u0dZp1Lag=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by CH2PR10MB4183.namprd10.prod.outlook.com (2603:10b6:610:7e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.31; Fri, 26 Jul
 2024 14:52:30 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb%4]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 14:52:30 +0000
Message-ID: <c8b1c258-740a-412f-ae0b-4d68a53e698f@oracle.com>
Date: Fri, 26 Jul 2024 09:52:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [Jfs-discussion] [PATCH] jfs: check if dmt_leafidx is less than
 zero
To: Edward Adam Davis <eadavis@qq.com>,
        syzbot+dca05492eff41f604890@syzkaller.appspotmail.com
Cc: jfs-discussion@lists.sourceforge.net, syzkaller-bugs@googlegroups.com,
        linux-kernel@vger.kernel.org
References: <00000000000064c7a0061e2004d6@google.com>
 <tencent_8FB36BE36BC97A03AE44421765577706C905@qq.com>
Content-Language: en-US
From: Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <tencent_8FB36BE36BC97A03AE44421765577706C905@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR17CA0014.namprd17.prod.outlook.com
 (2603:10b6:610:53::24) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|CH2PR10MB4183:EE_
X-MS-Office365-Filtering-Correlation-Id: 69a7cea5-f6cd-4c07-4e41-08dcad8292c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wm1vRElPWlVkMjlsaExaTW5yN2piZDNsb1poVTN5TmRVYjN3VGZXOUpNMUpF?=
 =?utf-8?B?OUFzN3FSTkc1M3NldUNRWWRrL0FwOXhKeUh5R1B3dTZSK0tVdVlTWkxQY25E?=
 =?utf-8?B?NHlMUUE2Rkp4Z0piYWFTZ0ZhRUcrQmJyMDJJZUg5SGtlT3hFZmdwM09VSGs0?=
 =?utf-8?B?OUFTdkFXbjdNZkYvUWxwbUo1RHF0NXZrWjRrQ2xKQ3U0VzBzUC9VemZ4aUdQ?=
 =?utf-8?B?eTJWVUdiOUREbi9SUTUyNkIxTnR5K1pzcmRUL2p2M0JPV1Vtb1lTN2E4cTlX?=
 =?utf-8?B?SHZOVlFxaVlyOE9JM0w3d1RaZ0dvRzM1SzQrYU9MUFdFVENGVnJJZVQ4S1FN?=
 =?utf-8?B?Rm9ETXZLb2NscHBUQ1FudkpjY0M1MWdCMUpVcEFXaVoyTEs5ZUNYRTA5OFI5?=
 =?utf-8?B?bFVwWDA1VmhiRnJHR0xtb1RNSzVFMTU0OVRWeTlMekRsWnJWV1U4TFAvK2x3?=
 =?utf-8?B?eXZRSndsQVQyektjRVpaUWdJeDNyT1J2SUhud3RjRHFBUkk4UXd1dE90VVlk?=
 =?utf-8?B?Ulo0cVFDNlVFSUc5bTdZQTVPSVpUR1hiWWRBQjU3N2IwV2dyZDNKRzdxQjIx?=
 =?utf-8?B?dDByRlp0VHNxVUg2NUc2RHdaR3ZCY05ObkRPVFlHWFRScDhTVG5kQ1RHUFZz?=
 =?utf-8?B?R3Fqc1JtQVYrTjhyMzRXcUNSZU9SWUJXQkpyR1JubFJGeE1xTm1UMFZVU1F2?=
 =?utf-8?B?aEFaZ1RJaDM0Q3g4N0Q3VFI1ZElMajBXMEZxVFJkM1pYYldHckQ3MmlGQjcy?=
 =?utf-8?B?cVpzUkx0cFVSUGRoYzE1SnpJYXQwNHRwaFVDUnFxZ0Y4elNGRWxJWUZFUUlU?=
 =?utf-8?B?MTExQW1oWExDVU4wTTRvQjhKTHFYOElRd2pSZ0ZEL2daaHdnZFJ2YVEzMlJx?=
 =?utf-8?B?WmVqRUdIREFkNXZtbysvWGtSbi92Z2lqMVphanN1OG1qTUd0LzdaUHM1M1l0?=
 =?utf-8?B?Sm9IRVpTRFg3ME5jTFJseUtockNsUms4SXhxcFFkajQwQlpaUlBtY1RZVWhU?=
 =?utf-8?B?TEFRM0tyclg0bnVQeHdSTDBSM2E1RDRySzZlODhkL0d0MVFEZEZmMUY5L0dx?=
 =?utf-8?B?bnFCT3hzV0F0ay9jbFdZUWZKNU8rVlJreXNBejdHd2ZLSVNwZTRWUFJHSWxJ?=
 =?utf-8?B?OE9makJBZDZ4Z1lhSmp0Y2xub1NlVE5qRkVBUzRCNXdHMFFwcm1kNzJ6MjZv?=
 =?utf-8?B?MnQ5OXBXUlJhTHBZeURvMlh4ZHU0RU1WRlVyU1NKdjlqd2pEME53ODV0T0dN?=
 =?utf-8?B?Ung1eE5yTmVkRmhsSUYwUGxOVFZVZGw0aGtYNHpXSTlCd2VoVkdLbjZuQ2RL?=
 =?utf-8?B?NzBJekpSd2pyVGtBTXBaN1VicWlIVVI2SnJLU1F2cTQ4c2RJa1JnYWZhL2hB?=
 =?utf-8?B?TWxDYjVCTjdIcElDUGlpajBwVEd4TmpOdmZWUkZCTFAvMjE4QUVvVE0xUlZU?=
 =?utf-8?B?bEJOZnkveW43V1REWW5heDIxbS9aU04rZXNuSGh4a3RhbEpLcWp2UGRmZ20x?=
 =?utf-8?B?UDlXa1RRU0VRQmQ4UXczWS9zaWFGY1hDMnl6NHkxWVNHcFY0Qkg1SkM1RnU5?=
 =?utf-8?B?emxXQzVOUlQ2R25RZUtwWVUvN3FnaUNHbVdVOW5SelhFTUVxUTB0YW1GTExo?=
 =?utf-8?B?aGtKOXY5MGJWMUJJMStsenlHOGJSRWg1SXQybmMyalEwYWdlYjlVSWJhVnlG?=
 =?utf-8?B?RUtOWXRCUm83Q3lGRnl3dS92L0hJYXEreFJmd3I2TmpNcngxTzNMZmxzTTRJ?=
 =?utf-8?Q?QM6WGL5ZkrODo37O78=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUVWQllQY2NnbDBjNzdwV1VHa1YxVUhmQVhXMWtnVElZY1BESGhPZVVMLzRJ?=
 =?utf-8?B?Y2pTQzVzWkppb05xdURvWUhEQ3lnejMxQ2xmbys4NWFTR1FQU3poUjBQSGIw?=
 =?utf-8?B?TE1aNm1SNzRGaEZuaytROWkzWjg5ck43Z3k2cWE4elBhQXAya3BONVVRUHhW?=
 =?utf-8?B?LzR1QXVLSlRnTG9hNXV6T1BqeCtTYmlYNWhtQ2hSMGF6SUpyandpbFVHalEv?=
 =?utf-8?B?UFp0TUtTVklYbVpFdTZHNFE2ZlpxbVBreU9WOGlId1piNlBXNlJhTTFtV0Mx?=
 =?utf-8?B?RW5UZU9iM0xGUTA2MktFMjlmM1hIZHpPengrTzAySFB1VGQ2N1ZMeWFJTXZs?=
 =?utf-8?B?dFlTZy82WHpRUmNOSitBVVgrUGFTOVlXRG1nV3RxSlQxSUNVUXgzalBDdjh3?=
 =?utf-8?B?dlhqYzhkN2RNN3loZTQ0cTB5N2hXV1NpM05tUGNneExFRmZ6eW9vdUcxMzh5?=
 =?utf-8?B?SU84VVp3VytTakxtYUJsZXdKaGhtRU1YckNkVHdDYUY2eXNoaXV6Z1NzMFMy?=
 =?utf-8?B?VzkyVklVM3p2WXFTeTkyVEZidGUzcmZ1THlWQkg4WEhEeGhqUWVRendYYURj?=
 =?utf-8?B?NGZBM0dDSm9mcFNhblc1c2FwZ3pkcktvRHpyQS9DUlBXNUxNWFVoeFFIZUdp?=
 =?utf-8?B?ei9sc2p0R0tOSkQ4YnVtOXRWN0haaFpKUkNiY0M1OFZUaGtTRk5tcE5OZllK?=
 =?utf-8?B?dmkyWmIrRm1lbnJsaHRqQVdSSEF1NndKK2o3UWhaZ3l4eGpkVkVURjZKaWJw?=
 =?utf-8?B?a0xWMVVXVElBRHJtYTBCdnlaZnJmRTdxZWl6L1dCekVhbzRkb0JWWSt2cElG?=
 =?utf-8?B?ZlV6UmMrSlIxY1lhcldKOFJYdVYzRVUxR0pKYWd4WjVVU0FILzdiVEJiWjlU?=
 =?utf-8?B?QTlpWGR0QlhsL1BxR1ZXckxFR2sxbTI5cjJUQ0IzaU5GQVBobG9BdGljRnF0?=
 =?utf-8?B?aGhXZ1lGZ25tcHR0VktMWVdlL3RXWDJpRytnNitmZ0VPeU1rR3dEUjcvTXg4?=
 =?utf-8?B?V1BrY1JPaXQ1eFFkN0N3MGdWeFFreEc3Sy90NjdEYk9vVkkwbklreDRhWWhR?=
 =?utf-8?B?aHQ3L0NsT3R2K3pya01WbDVOc2VuaktuNlhvcXM4akxESDZKRHBsRVpHK2Zr?=
 =?utf-8?B?WmVBTms3aGJVUUZVMjYwRG0vZng0VjZQdTFHcGVMZzRWeStnUUdMZ3dlMmto?=
 =?utf-8?B?dWJDOSt1OGpqQ0JCcC81N01hRzJSYm5lT2NnNDlFT3BwbzdsYkd5U0NhT0Nu?=
 =?utf-8?B?bG40REZueUpDUitLTTkrVUZqNllJcGJZMTJkWVFYZTNmblJvTVhaYTJqM1g4?=
 =?utf-8?B?QWNUaGE4TXE1NG5ZTFpUUWJMQy9kMkxOOGV2VWlZR3R6SmVueUhpMHMvd3NW?=
 =?utf-8?B?TSsxYzlrdHF0aTNRTFZ2bFJRTXpBNXBjcXp4eUNkMDRQNnNUalN6Sko3TkJ4?=
 =?utf-8?B?b2U3WFdnYkw4NlBlOUs4SGp5RWFBYjVUMTZvQkhTNkVHL0pIWkpTdTl3T0Nl?=
 =?utf-8?B?anpiTXFNZVZxb24rdTh3UHRXclJpNkF6dUczNEwwQkJocHI2R2xGTlJLaXdt?=
 =?utf-8?B?VnRPZXkyc05xZVpLaGRkR2JNQXk3eUtZMDZpSUNNdHRQY3dxTFdiUGhJWmRD?=
 =?utf-8?B?R0ZnWmlFaHV3TTNEMVBvQzdxcmwvZFRyTGhiTnNueTJ0ZUFWWmo4NGlZOWVK?=
 =?utf-8?B?Tk9zSFg0eGZNWnY4eUdVR21jOTNQOTU5UzdrbFFMRCtJbS9EM3g3aGZlUmhm?=
 =?utf-8?B?NjVGcUtFTU1qakMrUkExYXdocGU2cXhuUjZGYXpPd09xUzNNTTEvRmxGdDk4?=
 =?utf-8?B?My9mVWUxc1NsWXB1UEo0emcvWXpicEpTMFM1bXJxM1JHekpzMjFZak5WM2lM?=
 =?utf-8?B?T09rcUFxT05maHlTQWlqNDJreXU4SDFBUWYzK3BnaDRaZnVsd2c1aldCSyt1?=
 =?utf-8?B?MWFicm41dlFIMmZ3RXgxaEZlSG85dE5GcVpad0Nzb0VlSnBZMytPS1pVKzk3?=
 =?utf-8?B?c0M1WHRhMzBFVytiT0pSY2lRblVjc3h1bGwvdVQydko2RTZ1Wkd2YnVrTFBQ?=
 =?utf-8?B?TTdFTDdpUmxMWlU5Q2NxUnVaNHdSUFZNYVZGTnVoQUFmb2FaY3RZMFQvT0oz?=
 =?utf-8?B?c29xd0VXT0pJa083aUQxZ0tQNlZwWWNpTUhpbitrK1Q5M1BDaHN4K0NBRkVH?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	V4A3SHXpN8CEsNPHU9DQzT+x8m6DQR9iLHxfoAUdBI+E625VwcGZBvFJdb6y3V4+nyj417CuQgkQv3pEpYuKd303zda4RjrR1o+6NurIlGqA7K5UerUx3tPKqC2CNpDlFLQbfuGxKGN5TBKMGIeZMfSy95gNDVlGRpbEGLgAxT0QsDvhZKVZe+S7hBqMszN0QTLoqNT8VE0tYPlPYeC3U0vG4rtSQOgM7rudkp3x8Xle+6GW4cWEi4u3CJQ1GFsMp5ie/qZFftudgfUwlj7bk0OVvsW/LHpGfLwXZhHxbIpN0NEj3gFOI550GP+NtZbMAodG1uSqMAdRYlGTG8PaTB4efEVUxMLIQ3HJJ8j4OuiuNYnXQWL0kRIT5MX7ss2e+MJwY0cFAnJDpYTJy86CvVZA/mj33PdM5FjIwOja+zGSioKuw594qyYE/o1Ozyc/w84y8P9fr+mKwi7e3fG00YL9lXxxvaeogmxNd5alkRJoon/FucHPQS2jIJswR4TUIXzvG88ejquwmHXUjGpBQIWFcONTdWk5OiW7+7Dl+zXiwtf9JolI64b4SSipdocdpx9IVwSanucosD2kHNlFLZeiPB8TuyE1t05SYNMBRcE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a7cea5-f6cd-4c07-4e41-08dcad8292c5
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 14:52:30.1046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLkiTXc1q0Aua6wC8LFSgFF9FUftOGyZBDa9LzMgiwOKiFNKqLit0jEMOH23nJfnV5uEYIQHWVIokG/rjY+hpFY3nPyXvW0/jk/sftxrbI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4183
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-26_12,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407260101
X-Proofpoint-ORIG-GUID: tC3jKlrz8W6_LRvzYYAVi4NTDc7mRum5
X-Proofpoint-GUID: tC3jKlrz8W6_LRvzYYAVi4NTDc7mRum5

On 7/26/24 9:22AM, Edward Adam Davis via Jfs-discussion wrote:
> syzbot report a out of bounds in dbSplit, it because dmt_leafidx less
> than 0, add a checking for dmt_leafidx in dbAllocDmapLev.

This addresses the particular case, but I wonder if it would be a little 
more robust to move the check into dbFindLeaf(). It would also catch a 
similar issue when called from dbFindCtl().

> 
> Reported-by: syzbot+dca05492eff41f604890@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=dca05492eff41f604890
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>   fs/jfs/jfs_dmap.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
> index cb3cda1390ad..c5b8883599e3 100644
> --- a/fs/jfs/jfs_dmap.c
> +++ b/fs/jfs/jfs_dmap.c
> @@ -1956,6 +1956,7 @@ dbAllocDmapLev(struct bmap * bmp,
>   {
>   	s64 blkno;
>   	int leafidx, rc;
> +	dmtree_t *tp = (dmtree_t *) &dp->tree;
>   
>   	/* can't be more than a dmaps worth of blocks */
>   	assert(l2nb <= L2BPERDMAP);
> @@ -1964,10 +1965,10 @@ dbAllocDmapLev(struct bmap * bmp,
>   	 * free space.  if sufficient free space is found, dbFindLeaf()
>   	 * returns the index of the leaf at which free space was found.
>   	 */
> -	if (dbFindLeaf((dmtree_t *) &dp->tree, l2nb, &leafidx, false))
> +	if (dbFindLeaf(tp, l2nb, &leafidx, false))
>   		return -ENOSPC;
>   
> -	if (leafidx < 0)
> +	if (leafidx < 0 || le32_to_cpu(tp->dmt_leafidx) < 0)
>   		return -EIO;
>   
>   	/* determine the block number within the file system corresponding

