Return-Path: <linux-kernel+bounces-408116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 753659C7B07
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75E50B3426F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182402040AD;
	Wed, 13 Nov 2024 18:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LkTpTYe9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FuK3XrQH"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9843F20403F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731521011; cv=fail; b=EFWEpVjdEHk23aT8NNpUjoq/JJAj5LQZ1fl9E7FGLmrWhKKipskvxyIIIooo1DrncuCxLQ0ou1LO6/cTlM50Np98xToAdreOPY43BniVbnm5kNnMrfNL+88fSqh5tZl8WbV5I2RU4wi83dQox+tldF+EY9pWpJvViwkpC+0kSDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731521011; c=relaxed/simple;
	bh=ysPhpvz9I+Vxu2xr9qrYZkCjq2FHAqkunogd5R9NWwM=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=g2P6ld8I3GELrW2vzNGpVaLieYLH+rl1U6AkUwROkArJYw9g565CULbiYQIGr9u+W7kOxmL3SavtFwPV5IukR3kc/4AGzvqEqrEkEK2EVp+PFMwBP+NRt4me4KpgacLz3CcIyUmr2SJ7WrOP4PrI64xRgbFnjjv8sFCpPcbxSOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LkTpTYe9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FuK3XrQH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADHvQYP018677;
	Wed, 13 Nov 2024 18:03:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=pLA3vGR70CzAUUyN
	SeZ4azmjmZVT73680bY5uupI2vI=; b=LkTpTYe9+BNyrtzXHrfKYexCnQDUafr7
	ozzzW8ir5kHksdeliTr0n9OnmrkUd337mVqEqn5T6Pzw2wyds8ZUi1pleS7imkoU
	wrxKeaQw2VzhxzfsHDLUqLNkATgN96VaVGEcgOhupbWDrkpyft2TXjRxCFbUfQSO
	SYK3QKpAGDAmZGWAy5K+BweRww77Uliq4s0q8sHfnM/d0JZCqFO3xdqnYYiAgaLU
	qK2ufsw7WaHhs9QOyORR7wEUHZSRWvNH0jf2UFjyNBtqmDmFUKD4mYrPhr4IFAn/
	d7XWYx9E7iDoBoCmM+z9x0PcXjBABjuj61l3bB0967D/26EcBqNJkA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k5fceb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 18:03:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADHOapU035906;
	Wed, 13 Nov 2024 18:03:09 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx69nrum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 18:03:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E2+nNMtPUh5a9s2I7a0+xgdYLCAQknWY94gJa2Gp0fGKSMhTf8KnyUbCL0L4V4w6Ru8ybwENa7E7ndT9gmAP0k7qUahvPs+Ov1E2FUzCJCfT7tFnkZPNugw3fLvOrni9zOtfuxPGzegp72CQC+C3bhgkLDc9zGEOCB0ijOtN2K5EiqfoY68dXrsNO2BzpOcHscOwlh8Hn5xrPJ/kIVXzRL7QH6+BAUhCM9aEEKd0UbLbxkWXtKfG2blr7i6lvp2LYtLrE8P3azfG3BiThxteLPfwiLsGIfJJgPk6ZBmcJKWLorEaGujHr3fjHnhYavfC6hVDOaCyi8CpuOmoYwdEhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLA3vGR70CzAUUyNSeZ4azmjmZVT73680bY5uupI2vI=;
 b=J1IxReWL8fxu45KiHyeJFRYmjhZayWkQ/9ysYc9MGUAZdq9FwXbz/LzFJKjstGz3lEkcqsQwo0iEiu2LQH8tIHlZOQW6h9vVDyC14ZO9pFTT4jQO7SCvBdrIaHL2VqhnPRC01ZpvNrPyNjNdssQDUhDTa61Q4a56D5Im1QcFiJO25e+eYLoEjvIdkbHUs+SqGkYSg6AUZS9tFWx3q9R+dyCS4+hqcPKOU+Ya4VlRC/Q7WaL8GA/jlxmLXwNNzqnhXZkvcwv144k2WKdjQywnty/eBcgi2mAUWecFUmuY1TlmOLdOMB6bttA0K1wIHXlbMzKxoGSc+4DQQYfIpbUgLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLA3vGR70CzAUUyNSeZ4azmjmZVT73680bY5uupI2vI=;
 b=FuK3XrQHrC3EcUNyEymEBi62kGw3kR8aDFePZjMx7JZbPT5NNwnJuLvLYuMVs9Ci2iilvoZCf30p0qf4rdciyMiM/MygDbbs+8rR8icxlTj0wfPfKTvIGuW+aPqDP/NrErVIpTWkg3a0kL3ePGdYeA5126ovxw0ZlumO+g+kF90=
Received: from IA1PR10MB5994.namprd10.prod.outlook.com (2603:10b6:208:3ee::18)
 by PH8PR10MB6504.namprd10.prod.outlook.com (2603:10b6:510:228::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 18:03:05 +0000
Received: from IA1PR10MB5994.namprd10.prod.outlook.com
 ([fe80::f2ab:1ccf:7941:1757]) by IA1PR10MB5994.namprd10.prod.outlook.com
 ([fe80::f2ab:1ccf:7941:1757%5]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 18:03:05 +0000
Message-ID: <58289b1c-8a56-4607-8632-d36aef1fc5dd@oracle.com>
Date: Wed, 13 Nov 2024 13:03:00 -0500
User-Agent: Mozilla Thunderbird
From: Joseph Salisbury <joseph.salisbury@oracle.com>
Subject: [REGRESSION] sched/fair: Add lag based placement
To: peterz@infradead.org, mingo@kernel.org
Cc: juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Language: en-US, en-AG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0267.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::7) To IA1PR10MB5994.namprd10.prod.outlook.com
 (2603:10b6:208:3ee::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB5994:EE_|PH8PR10MB6504:EE_
X-MS-Office365-Filtering-Correlation-Id: 011eb581-0e2c-4e5b-6b2d-08dd040d6be3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGVqN0JtYldhbDBsblNMUVdTSGhMYlRJSFF5TDA3TVJsb0lnV243aVNEWitk?=
 =?utf-8?B?eUVYcXYweWZRRWg2R3lIZVh0MHBqampnd3VBSGd1NEp3aWFTelgxdiswSkpZ?=
 =?utf-8?B?eUVLS2ZOUmo2ai9hV2x5ZDNKZzdGcVdvWjY2eWxBTGJRSzFmby9HRm5ZQkF4?=
 =?utf-8?B?bUZpSDJUeHBZVnRBakhjaFZRbEZJUENQYmhiUUdqM1UxeUhmMnE1T1NhSTZZ?=
 =?utf-8?B?NGhDOXEwWVZTb2JERDUxdUpwY01kYWZYYzc4SzFBeXp2bXg5U0ZmNXVNL1RC?=
 =?utf-8?B?SzArMm04K3hqdW9QL05wcUxraE9SNElVTGNLWTRVMXR3NzV5Uzh5aDIxakpn?=
 =?utf-8?B?bGNsMkVCSEpYTFRIRHY3U2xwMG40R1hBbnh2akEvTnpYSDZXa2t3MUcraXpS?=
 =?utf-8?B?Ym0zTnRueHhEeC9COVk2dG01NUZ1WGQ0ZFM3a3hOYUN4SS9IN25wVDhJS244?=
 =?utf-8?B?U1hCTTdvZ3FVNHNTN0hqcXF5Z3JhSFBDdUNmRzdOL1dvVlVXNTQyVGJTRGxS?=
 =?utf-8?B?SHFHME94ZkVvR0llYzdYamQ3MDRVZzRGT2NlNWo1ajZmVFJPa0tITGkxaFRC?=
 =?utf-8?B?YzVsTTZLRVBYa2ZsWlR0cE5RVGcrOERoQ0wxU0l4TGI1VGhDZWZxUm92UXJo?=
 =?utf-8?B?Zko1NENFeXZQb0FrbzArMmZyVHBxbzZUM0RDOTZiamtEUlFxSkIxSzAzVHlR?=
 =?utf-8?B?R3VPalUyRmZQVDBIVDlPWDAvMmZCUCtzcmFjQ0tVOWEySWk3M0RBVVpiWngw?=
 =?utf-8?B?QWRUU1JYQ0xZbndkZWd3TkdWS2dMYUIwRGg1RitFOEhMNGdpVllmNnFaQkJv?=
 =?utf-8?B?Wkpxa0YwTWwreHRMeU4wdDZsWUFrQkwyTCt2M2diNWNVVjhNUVJzUDBFOUIz?=
 =?utf-8?B?Zmd3M0YvV21hdTZ2RDFtem5iYnc5MnUvNWVsWVdLL2ZoNk5oYmV1OEE0SDFr?=
 =?utf-8?B?dTZRSEw0ZnUwTGZQclZMRUsveExDQlEwZ2Zpb3pzOExsQUZwMjhvUXBsRlQr?=
 =?utf-8?B?cStmNWhUNUlWcDZLcFRIaFNXa0pGdkFYZ3BNRmFIRTUxZnAxL1NOZHliWDZC?=
 =?utf-8?B?Z0gvNzVQQ2F2bVMvRkZXQUcveGpWZlAyeXh0b05TU2RjZ0kxR2FBeThGY0NL?=
 =?utf-8?B?Z0lZUks0Q3d5MnJVTkNMaHVCYzlCV1Q3M0xVSzNkQTN1VzBoaE82TjR3SGVr?=
 =?utf-8?B?L1g1VWQzcS9tOVpDRklpaG4yL1oxYU5IVWNoOWVQUWs3S3FlSGUwNXREblFM?=
 =?utf-8?B?S0YxU0lBTEZiR1dDTVJYblJVS0E0MmhJc1JyQU5MN3kwVmtlOU14aEVCSjJh?=
 =?utf-8?B?MnZpc3ZOUFBFTWNFeVc3dmZyc3kzTld0ejJwUHJBbFZ2V3hFZVl4Y2Z1S2dE?=
 =?utf-8?B?T1Y1cnVka0xJZG91eHp1Mk1sUmhHSGtqajljdzZYZlFjMWVITjFjbzZZa2JH?=
 =?utf-8?B?dUt6YkN6TVRETHo1WTdWQXNCSVVFQXU0M0QzSDRWS3RTTkFqVXhRNXRuSjF6?=
 =?utf-8?B?ck9XbE52SWFCNmxuY2FMYURjRnlVaFZJZGZ5QmJYdzV1VHIyVkRaYjZJL2Fo?=
 =?utf-8?B?SmhEYms4NDZhcCtxdVlzbENxSUtLaHZiUVF1L3duYUt3eitIajIxNmk2VTY3?=
 =?utf-8?B?eDBRclRmZmpIY2VpYmhxZ2s0S2x1RS8rNXhDbHVHTkdDWm00eUd4amdhMnBw?=
 =?utf-8?B?TWxWSmNFWWFvK1A4anZxTkZSRDZBYmVEL3RCdGVGbno3MjFwcXpUUG1sL2RY?=
 =?utf-8?Q?s89POsAwVfps33FNcg6sS9RF3+L2dmjyrbivFtK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB5994.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjNMVHdYRWJ1VHVnM1MzWTNad3pnTWxIM2RPUVV1V053MXRsaXFEVUNRVEFO?=
 =?utf-8?B?Ykg2WE1MbXV6VlB0VG5RcFhVL3pHQ0UxWlNmaTYrdDlTejlsK040dURsL2Zk?=
 =?utf-8?B?SWxkT2lGVG1GUkRlSVhaTU5zUnZNQ0FFOThNNjB5SlphalZ0NjgxMjRDYkY1?=
 =?utf-8?B?Vmh2aENYOTVkYzc1R1NPMDExUkptRTU0UkZHUjE4MWpXM3pTY2JxaDhWT0tq?=
 =?utf-8?B?S1FidjA3MFJwN1R4ZlVkWkxUM1IzbUY4K3FIS3piTndKZFJHS1FzamgvMFpB?=
 =?utf-8?B?VUxtSzF0ZnkvSVVCemdWV3NWdEp5Tm4vWktsczFRQXRadHlIK084WXZ3Yjk4?=
 =?utf-8?B?Tmg5blBCbGxrMFNwSXYzbVltNEE0bzNHVlB6cEVkMGZTZTdjdG9ZRVljN0xl?=
 =?utf-8?B?b1ZGZ1ZIS2tkd2grak92TW1uSzhocHhYbzUxMkxTZjg5djBqL1JnYVRZZlJh?=
 =?utf-8?B?Y29xSjUxb1dRWkdBSnpKdXl0OHQwUXQyS3NWcHVhbUpqUXd1WVJLMnJsTDZv?=
 =?utf-8?B?aUhqZlBmV1FvU1ptbG1sekUwNUJMcFpoblhtYVUrV210a0RwNHNzZUo4aHE4?=
 =?utf-8?B?ZmYrMWM5SkpNeFF4aVlOUmV0ai85OGYwWldidm8wMUdiWWdWSzFEM3dKNHNO?=
 =?utf-8?B?VitzNklLR0xXeVpudTFZYnBtSTNTOW84YzZTQ0tXOW1EbW13TlRjS0x1TUhi?=
 =?utf-8?B?a2dHYWJSaFdMN0hYNGVFTWVUQUtoeDNWZGQ0NFVjcnA0Y25UZ1RXZXR5QStC?=
 =?utf-8?B?QjE3TWNPemRRMVliK01MV2RrY1FpZXd1ZjhHMm9iMkNtKy80OXNlSXZ6SmRt?=
 =?utf-8?B?OVpoOC9qdUZlUDRFZktXRG5IV3lZdkxRR1pXOTZnd1N3SEFHWXVMdWszM2kz?=
 =?utf-8?B?K3VHbHV3aVR1NmhicFdwMk1KYUNxVi92YVRCeVRDYmgvUDh6eGhGNTBPZE9Q?=
 =?utf-8?B?clZDcHpEUm5Rb2VDS3JFZm1nNXJwVjU0RFVBLzF6eHZ3dmlGeEczTVhRbCtI?=
 =?utf-8?B?ZDg0RnkwWTJKbElJdmNnUTZTK0VLM21tT1k1ZFlINWpORnhNWTlrZk9MQi9G?=
 =?utf-8?B?MnVZTE5aS0xRaGxmRU1nQVVBUVV2aXZIcHJhT3hKTzRNYnkzOGtYa3locUo1?=
 =?utf-8?B?SEZkNXpoN3BRZmxtRGVCK2ZQN0NJbm53YjZwTUc2SzV0M1p4OFN0aGVFcmNP?=
 =?utf-8?B?RUZacmJ2emRVTmt6VnR6V0FKL3pBc3krbThIN0tDTHR2QUxqMjZXZURFbURj?=
 =?utf-8?B?L1hTdEVNWWorU3BnTkQzclVDOEJZeDlxYlJoTXAvNWRiU3pFelhXUlBBS2Q3?=
 =?utf-8?B?SlpvL2RmMStoOWZMTTNiZGt1YnJralBLMUgwOFdZOVBZcW5zTEFHc2NvWVh2?=
 =?utf-8?B?WWlzZlRhOC9TNElMbktUUHZxcFVGRFRSeml1d2ZveVNwL1d2d082UUdYK0JZ?=
 =?utf-8?B?L1V6UGx4VUo4Zm9mRlZPSUtNS2JGMis3K1d1TXIrS3VqbEI3VEJSay9hSXJq?=
 =?utf-8?B?SEVTSUJjbWxTbjZGNzE0c0w1ano4eGNqRlIxaldPRXhpbnYxK3FHQmh5OE9n?=
 =?utf-8?B?OUFuME85TGhmMm5yL0lBRjcwQWlkckFKUk5lZmJtUHhsbEcxSTcrQ3orMzVW?=
 =?utf-8?B?aVZQZ3EwRGRqc0lPTnNRRXZPaTdIQVNCMU95THl0aEJ0UUxmZlhOblRkdkxH?=
 =?utf-8?B?ZEQ3VTBDVElFZVNIeU9RUTBDYXRpTjZHN3pJUzZ1bzlGaER6U0NEcE9iRnow?=
 =?utf-8?B?ak9RN1BVdjhUUk5tTmRGK3IwdFY2a1JiVUxIdkpxbE9KalFUS01LeFJXczNE?=
 =?utf-8?B?QzN2TDhtSjRGL0h1czc5OEtpTk5ZMG91dnY2bE9wY2lESmIzK25KSnZaMUha?=
 =?utf-8?B?V1FVeUdDLy9CU0VFUWRHMXpMYkRuWUM4eEFSK1NaOWdBTTBEcENiellpM29J?=
 =?utf-8?B?MWtFa0taZk9JQzNEM3Rrd1RGVzluOVFCbUxCSktOWElFUEEvcXRHZ3NWS1Nj?=
 =?utf-8?B?N2VVZWpGQ3h2UjZYYVZxRDRtU0ZmcDVkRTRqMzNnZC8xTXdPd1l1TjJhMHJm?=
 =?utf-8?B?RXpHVUZ3Ly9Bb1NhbGtZRFJ1cjlaOC9raDBNTmY1ek5pZmk2aU40eWlFaVlG?=
 =?utf-8?B?YkVDeUhvY2dCWVlhM3d0M1RlS3BMbDRTUWRwSG9waXhhV1FnM3NSWmo2aXZw?=
 =?utf-8?Q?mRBcDoBaSa03yPmR3iso2QA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	H9CTKx90ToKhuNXjjHnFOFkol3/Ee+8fh6+kORfgZX6d+1kEc4wAqRrk9O9RsGpJsVzUP0keB/uil0vsFsvnF6E5cg4BzV21BOfNxGIU9kyc2fInZDsVnYCKIc9DLKxKMw9+l9jpVMVM1tSHhXldMh/pdtGieDX1PEar7IzTntJcSj0/Lq67hJc1c3oG/J3BUfrqXpHeViqL5jya5Vh8SciAei/k/2/lnzzY09gfKpMqApi8WsQfm1OhBQkX+AYt8sLztP8WOAYun2glPRp5YSR0keiZm+TJs4kDX0dLQLJP6cQwLzCPqMxymoOa3L9CK2SB2Uq2ViOcwfqzxlQfxpaNwsc5U1aCEQyJECZOyHFyKsP8XJlniw/N40A0eEawkgHG9eqRmb6htFZ+HW7cpE6hj0eZoKVgH1G2jnXH4nhP8XsorwJKK81EkR1U6x40V4Mh1whJJXWMBo5+az1tncaO1b+G8xWtYJYrU2FYOBoskMDHsqnil2msPMkSQs2QnTe0VDrT7tEkiBRcHs26qBXNWuqZKjU6h3UN61QsUE3ftorImOg7stAxeTlhWIGsKIKtRJXY/+s6IG2nH9K/EpDYzYIdESHVIxtzCWEexQo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 011eb581-0e2c-4e5b-6b2d-08dd040d6be3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB5994.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 18:03:04.9971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c9GPzga5BYQV9XRCud3Hhrk2zbpp/xyv+BMLY74sfChkdZ2l1FYAfDgUEYoKgrHMK9nfqUyljUAb4Az1tt2P/ADHQZbKWZJV8MOtjHZ3s88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6504
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-13_10,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411130149
X-Proofpoint-ORIG-GUID: s0HE5zv1JigpWEx50Xr9vKtdZHwtKA49
X-Proofpoint-GUID: s0HE5zv1JigpWEx50Xr9vKtdZHwtKA49

Hello,

During performance testing, we found a regression of ~9% performance 
with the TPCC benchmark.   This performance regression was introduced in 
v6.6-rc1.  After a bisect, the following commit was identified as the 
cause of the regression:

86bfbb7ce4f6 ("sched/fair: Add lag based placement")

I was hoping to get some feedback from the scheduler folks.  Do you 
think gathering any additional data will help diagnose this issue?  Are 
there any tunable options that can changed to see how performance is 
affected?


Thanks,

Joe








