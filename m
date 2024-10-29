Return-Path: <linux-kernel+bounces-386464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5DB9B43C6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B3F828389B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CE9203708;
	Tue, 29 Oct 2024 08:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aOCFokzn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="czia+/GY"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C696920110A
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 08:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730189306; cv=fail; b=o4DbamqHCZfNpeDPFidFFdOjjiAF8KgCmK7dMOGXnUfCyEZyqeFmZlvjseeKEL65OOsDnJ89a9jgIWDFWsNIaHI/gk4iAdYqDBwetWMfRjFU2h1u++vt5lIqaoBhKGDtGTi29I1/XhdTKW0P8P/i85cvJI0gCmwKDZD131DKZ4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730189306; c=relaxed/simple;
	bh=t4LpiQSQaE0AcnfbStRh1EGLYE6LXp8pwq5CQWFvcno=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OfIXeHDXYy+RxLDDUfcg2KdaL+aYEGZ4vF5qCHCn0NDQ27Aj2WvWe869P8qGXceE/h0EzRLaa6CwVQ9T7AzMReqlyDW6FqHW29gVRg3E90zEVxsM/exIPDyCEON7n478a33bOVpIG5UHZ7iuH9iPn4//cOrWb6z3nj3m8y+VweU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aOCFokzn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=czia+/GY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49T7tcbn014848;
	Tue, 29 Oct 2024 08:08:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=3JWaDxxB/99ezk3bD26/LY+0Xyy7s/SHZCZKOVnHPgw=; b=
	aOCFokznN6mP3BFO4Yb6FtvtcnJt2kCrq5a44yPjEk1aSqElWexVSgGgQZqvy1w5
	r/s7uag11bP21W+B4SjDhqMQagc01rwQPFbHZK/SMkyGILviq8i6e1VFxW9Y6AN6
	I0ClQXqh7MoXyDUJyaFRPllwP2ziWA9UaEE4UPCAg6Ci9omWYNT5wQRKvpnEIdOM
	kPjeh74H5cWcaXNZyhXfxMVqLTGiMOeiz4vHf2Raq0Jn2Zfq+KECxxBzjeCKwr8L
	g+oV+fzIUHI+UW9VlqbCvmwpHVelheLe+TKc01o+9jO2sjksqiDOCToVfzgbwZPt
	iNEEOBLuoFmAI8a3qPBg1g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdqcpq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 08:08:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49T6al8Z034807;
	Tue, 29 Oct 2024 08:08:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnd7at7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 08:08:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SklGcBqIb/B4fR3c7cY1fKSKtQQXXHjfs0K/oh0duYTrpDGyjq9gQzsxVO2fJJnrHS8KstvidI7LgXrqxqzbXjtAZjaQuNPiGrVUa+dycuIuEOP4v9Qp61xhFeqaeHGVVvuHrjLlR/USySfqOnTcvFS6I2TAvU+IqpDnX3WJKYb1vCsA1bFoT/hPfJlPToZlyP7VXqT/lJDp8ydoBT/JHZW1u5pDde9gBDlrTT0jOvGZRYNUi0g9iWzaN74Q9v1PxGhMweYz9AE+nTvWdaSQCMmht/YWfaY5wYI6fOei4iuyWtsUlXMVKKg6wUFTTrFO7/IyutEmbeXJPwwcl+R6Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JWaDxxB/99ezk3bD26/LY+0Xyy7s/SHZCZKOVnHPgw=;
 b=dfGHP4knZRAWa2IG3yI248tKQ2qz7svgN+iqtH2mDCiVrZnG3fzv+bAAPNHw5pYYq55whqN7C7cUllvM6FKQ8matHUdJ+TkIalNMu6idpA36S0bnRw1YSQNTwcUB6TQ/R2a1VfFeZzRN38EfBtBYd7MetxL24ewdCP3dTCnEk6KQYCfpBnf/e8jzYQmvCDP1PN9Vd2YVWf8g7PKrnLlHLORUpV5izdohiXfGYey+lprt5UVkVrxqTNwCbcUQpW9tSs9qwunz0OuC9EZVV76wMNTvnt0PUj9a/CrluNyaVBHTWlcpl8QJFK0CfjP/ye7pb57b/gkinXkTduiX4MFHnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JWaDxxB/99ezk3bD26/LY+0Xyy7s/SHZCZKOVnHPgw=;
 b=czia+/GYPenl7CAFp3OOQmMOl4yARA95NfVxxvJ4596rgYd+GZkdrYHKhEkpAYa1ObsdhQlmFu7bsZ8CstM7MFd15OxGeJxox9u+ZvAhOR2yl0dXmrc+5CZVZv7yCHV+39WF73EfhO2K6keRH9gDfE2BYbQFI6/KGWVXBq/9LOU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB5184.namprd10.prod.outlook.com (2603:10b6:5:38e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Tue, 29 Oct
 2024 08:07:59 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8093.024; Tue, 29 Oct 2024
 08:07:59 +0000
Message-ID: <72dfc226-1a56-419b-bede-3be23ebffc35@oracle.com>
Date: Tue, 29 Oct 2024 08:07:55 +0000
User-Agent: Mozilla Thunderbird
From: John Garry <john.g.garry@oracle.com>
Subject: Re: workqueue lockup debug
To: Dave Chinner <david@fromorbit.com>
Cc: tj@kernel.org, jiangshanlai@gmail.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, jack@suse.cz,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
References: <70cb224f-a468-40a0-82c7-735c590bdb43@oracle.com>
 <ZyBgZr94Y9+xey4b@dread.disaster.area>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <ZyBgZr94Y9+xey4b@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P190CA0034.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB5184:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e0f6c02-6e89-4f73-7018-08dcf7f0cd3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODVCK00yU3RpUDh6UUMyZ25iWjV3VmpRNVBsYzNWSTRIc1ByVWliQkk4ZU9R?=
 =?utf-8?B?RWxHZThzcjV1WVU3VDkrbWc2dElLNk8xbHdLWEVNQzVRcUdXbi9LR3phVkto?=
 =?utf-8?B?NUxqNGtSTU11ZEZhdGV3UzFnQU0rOGZVWHduVzdSOWNNOG9yNU9OMG81eVUz?=
 =?utf-8?B?Vm91N09PUklUb2c5Y1YwbW9MeVR5WER3ZXV0MVJmd0I1bk1RUFR1WVN3Vng5?=
 =?utf-8?B?M0dGY3VUeitvWGNzTEFmQnZXbGt2c1hBc0I3RnZ5K2VNMVp2Y0RNWXBuNDNM?=
 =?utf-8?B?bTNyMjdRUVN2c0tqNjVHNUQ3V08waTJ2SzY0V1k0eXlRK3R5dUNuTHJiQ2ZQ?=
 =?utf-8?B?dFphQVJjNkNiOHA3M21LY0lBcnJINGg5RjUxanhSK3NPMDZtRVJ6ZElMSVlq?=
 =?utf-8?B?VU9ZYmV4eWxUWmNaVlUreUppZmFJS0UwWnM5YTNVQy91VGxRSHNRYnFjUlY0?=
 =?utf-8?B?dnBVU2Z3ZWZ1SXBic3RXd0t0a2h3L2VnNElPWTB0RFNJRVozZGhhSXpVVkx3?=
 =?utf-8?B?b2h1TURkTTZtMnByOHVIRkt6K0NNMWhUYXVqbExlMWZvVUZKUXA4STFTaUxF?=
 =?utf-8?B?V1ErQU9LRVlrSnpaTnBKbkVmRWZZRWVsMDJEYmlzdFhjenQyNzNvWG45Q2o4?=
 =?utf-8?B?SXlxYlNKMVNQSGgyamRhNTU2MHlrNkVrN2tEL3h1b1c3cVFza1AvMG5xamtZ?=
 =?utf-8?B?SjE2dGpaT1ZRNC9Xa09Yb0tQcHhEYjJoaG00VlVpbjNlbko0UnEzbHRXWkZT?=
 =?utf-8?B?a2c2VXg3Q293T2JiY2FIL0dBSDJJaGtlQWJIOGVaVnNKYXZuMUxwdkJXbzFV?=
 =?utf-8?B?eE9MMFhUbTlvL0dNWWVudENzQzcxWFFxTGp1bi9tKzAwUDVqVWZVdGc2WlFj?=
 =?utf-8?B?MkVvYjJXWlNoTitjelRoRGprUGl1ZUttRkpzNW4xNkIva3pmQ0Z2VFpIeWZu?=
 =?utf-8?B?dE12ZzlWaERxTnladEVWMStYTXVsbFQ5T3JpQktzbFdKZzRBSkx1MnVld0lw?=
 =?utf-8?B?cVpNLzZsVEo2K3ZvRjJ6L3llbGN6ZVM3Q201YmIrK2l1RWVDYzBGRDBlcHVU?=
 =?utf-8?B?WUdOUmVROGs2azg3MGlzanZLa0JvQUQ1OC9taWh6a2RFNFhFb1Q4YTgrNzVl?=
 =?utf-8?B?SnJWZkVDdHFUc3hPTjVadGV6WFU3bnkvcnlUQ0NqYjZERUlKY0VCT3JtN05M?=
 =?utf-8?B?Z2duNnROdkxUZlExZWJrK1RNcmRCTWplR0d6WXhHT0lHaFk5dWdYZU9Pa2xD?=
 =?utf-8?B?RjBVN1kwZzJOd1J1RjR0ckMxSURvSE9ZY2pIY2VWRzV5MXdtbEtmaHJuK3NY?=
 =?utf-8?B?NURuaGFaYjlHOVgycjVFZkc4RzR3bllGMXFWOGFUS2pkQ0prSE44U0dnYWds?=
 =?utf-8?B?V25BVlBtK0JKUGZFZXRNdm0rdDJNanMvclp3ZENlRkMvYkZlTE1zMll2Q3My?=
 =?utf-8?B?bkxHb0Y0eTkwZ3V3OWNsUlEvdnBvSVRrYzlkRlowaUlOczhIejJ3Rks3OGMr?=
 =?utf-8?B?SXJaOTErc1dTUXpmZ3NoWVA3OWgyVVVaR3dKVUxJV0hhK0RXaTFOMlR0ZEpp?=
 =?utf-8?B?ZGk2VU5lWGpCK2g3Q1Y5ZVIraXFkcXNMZktFSFpvMThRMmFYYTRhOHVSci9P?=
 =?utf-8?B?cGx5dm5mL3E5aXNuSHhBbzNBSWo3aTFkUml6Q0hhMXlQSzNJS0RSRjdPTjV2?=
 =?utf-8?B?WDM0ZGRyaFNoUnBVTDdWblhvVmM0bWZtTE9hQXFLVUZpTVkzd01wUEExY3ps?=
 =?utf-8?Q?/oWOdTtDkVz4yR7ImdgayrZlyMcK6/H/AiPqnJJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjZGVHNZaTM1OVYwWTVGRHpzcGhsL2NKN1FrUFJnODd5NWdTVkxHNjhCa3Ru?=
 =?utf-8?B?YVVTWkhRZGorTjNOSUs1TGxxTnR4dUJ0QWVqeVJncnVwTjBKam4vU0pNdFdq?=
 =?utf-8?B?R1Z0KzFxUlFyei8vZUM4K0d4UGw2aExnYVZtQ0dqREpMNndMcWJkNVhzTmhF?=
 =?utf-8?B?bkNpc1ZVaE54L3QrdnJ3MEZqQnc2THdTWGlyRVBoZW0yU0U2RnplRnJQUVZv?=
 =?utf-8?B?VHlDeVdqOHIzVnZuZWNOVStNcy9rSURjTkprSDA5UEE0SXpHQmE5MFlhRW9w?=
 =?utf-8?B?Ti9FaTVkc01wZjZUcGZQcGUrRnlNaGhwcXFFU0UranJ0K2p0SEwxSm1hSnpp?=
 =?utf-8?B?cW9WMG5sd0JCdFpaVmNrTWVOUElzZVJVZVhUZHJrQlNmYUkrUlVXTU5GOU9C?=
 =?utf-8?B?dTRZZjF3Y013Wjl6NTRsdTlCejBKbHdYeDBXRjd4SEdQd0Evd2JWbHl1R05N?=
 =?utf-8?B?Z0dIYUxBYW5ReWEzVy9WZ3BhaC9oN05QdS9pY1I4Z2ZlWlJyMXFpdXA5eUFL?=
 =?utf-8?B?bURMYzAwMXdKeUdCNmo5YkV4SEliQWZJSVF0SjFXaHF6WGlGUnErb0V4bmhC?=
 =?utf-8?B?eStDZU1UVURQejFKNUpFSmxRVk51RnNuV0dwYXo0V0oxSXNVVWZYWGJBVWVK?=
 =?utf-8?B?R3d3ai83eWVaalBRZnprRDhmUmp1cEd5dzFHWVQ2YWdtR3EydkJwdXVucXJr?=
 =?utf-8?B?RXpYMm9CbG92azVOTFFIZnVVWXZkM0s2VWVlWWxhMHNrdWZNblMvbWZhVkJT?=
 =?utf-8?B?MTNMR0NuM1dHaHhlVlBvMytFbFY1VitOSlBzaXlUN1A5OU5SUnkrUU00Q1lv?=
 =?utf-8?B?YStBdEpjbkdOaTAwNEFoVzdTWnZGMmVuQ1d0bUFiUHV3UW4rODE0dzZTSzNP?=
 =?utf-8?B?bjR5c25DZ09GMk5nN3FZNFpLZE9JVDE2QnJ5VUJQWFV6K1B5cDJiNEIzNFZp?=
 =?utf-8?B?SXUrUVhsZkJrRjUyaWtuc2hTMnYrdXNaTFRkaG1mRkJjZVZ5UkdxUlVIVXB0?=
 =?utf-8?B?NHd0WHFvdTJRaFVJY0hJZTJPNU9jVHFTSUxaK09YSktDdFB5bDRkUGV6T3JF?=
 =?utf-8?B?cERNZTBQMGh6MWJ2OFkyM1lOZUY2eUY3cFRyNWJQNUhBMURnL0ZIOEJZbkRT?=
 =?utf-8?B?SGg4OERHYjVyNVlrMFNiZUZsVTI2SDN1eCtYaWpkempDWG9XcUxkUCtKQXpz?=
 =?utf-8?B?aEtHYnFJT205a0kyRllIaXl5TFVEL1J4aFljTTNaN3dld0tYSGJSc1hHWHNy?=
 =?utf-8?B?OEdPOWg1UUxGVlVOM05VdUozcDIwQ1JXYTB6SWNWSEdzeitvYm5FVTIxcXRI?=
 =?utf-8?B?OXYwTGVQY05yVGVZTnM5VjVYWEczaXV0c3N3VWNKZ0htWllGUmMxOUN1TnhS?=
 =?utf-8?B?aDJDaU1xSlRaR2RSM0N5cmI0YXBpYzU2U21kU2F2WHg2dFhpU0oweUNlQUJr?=
 =?utf-8?B?enVINVpWcGVYbklBSjBDUDc5U2JwZGwxRXJGRTlaM01xbk5pbDlSNE1sMlpP?=
 =?utf-8?B?Ymc3N2ZRSjJWS1NLMjRxMHdWWUp3Tmt4cDVsVXV3MWZ0VjFFbkozd2VHNVRl?=
 =?utf-8?B?cEE2TGJTa29IS3lVVnF6bHM0UG9QVW1laXBrMGFGRUdvdTJsK2t1b3ZMQXM5?=
 =?utf-8?B?bGtQa1FTajhWUitIcjZ4c0lFcUM4S05qVUVSamxRT0lXN0ZlR1NjZVk4OUQv?=
 =?utf-8?B?RlJwOWhEa0hoUEp6Si91eG8zN3ZYRzFsZmNrWW5CVzRMbDBoS2JRTEY1cWtZ?=
 =?utf-8?B?L1l2TVBkS2VpVk9xQXljbkk2RlExSVMrK01FZmkyQlRJYUw4bVgvYlUyRzV6?=
 =?utf-8?B?cC9jZ1ZNWDZicFFzbTBUUXBjdDN6VlNMck1KTkFFQ0pNN0xkVC9OTTFGTXdz?=
 =?utf-8?B?UnREazJNY3lRVjJ5QTlzNjZFc0x3TldPd2dFY0RSbUNVV1cyUEJPSE1yMDR1?=
 =?utf-8?B?RDA4WThtU3oyenk0dEplYVdlejBvV3R2b25xWmJuUVh4SFozN1BWMmRhZmtN?=
 =?utf-8?B?OXNjWThHNWpSRmM3TEFhMXZ2czhrV25sVVZMREo5Y1ZhcUR4aVBMR3BDNjBX?=
 =?utf-8?B?S1FIYXM4bWgwOGV1OGxmeFFvMkU1UWpvRnJsbGluRGI3K0xsUTd5am81bXZh?=
 =?utf-8?B?WnBOaW4ySWF3L1pkTjhmb3JMMTI4NTBnaHphRUR4UEltUEM1SGNDRElEakNH?=
 =?utf-8?B?cmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hhbOXYnXLPsC1h1h91eslHKUpzHkbYz206oTWHf01iDdyBvcKy1bXeAnrelYQOvjw/mlzCF+5AC1QFOiDVwxvoYtFUwf8CBesTTnz207a82ZRfhXy+cQBg3yVwsuGwzq4Ki3jWr2iQhTZIkaZza/Ldv/6GcWcAztd5tTY7gQJSDoZT0jRw4ZFgDcm7UkdoSg/TuwfjXlMFEC3uMQy4XdRZZGocyr4MGVNzSINuUwpK8Hi+mkrmZqRhCmH6NvIhXVFLHeYUKl2w6wqgyUAofPwSIei+5vLr+iGtYhLCKO7ge9YTH9z9VCApHmwjs31OPbMpxpyF3YzbsvN+l2ZUBVODSedXFmBjBe3I++QdVQeU7P+sqbDRveEwb+j3TSmgjeEAOakrmsE8mL3354yKCfvG/sV86eWdAlhYnDJIpakCBvRayWrKHldB3eeI1XgVmuoKWH/d7fzhGPtBsz+N+5VY53vwmTcjI9b/UT7oCW+bDoAEz/+jTJFhJtFo223MKgW066LuKJy0Xm7Oux01FzWX66W8Aen1laOD/+xZJbymLDp2R4595pLddyZSdWgmFnWr54SvTjk10yoYBOjkLy97QxyaFc7LI1KN8NVoeMWDc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0f6c02-6e89-4f73-7018-08dcf7f0cd3d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 08:07:58.9604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUVSfQhP/SMLn+EHb8G6YoloBsinlUdMpHOt4Y4IbcwQR3ObP1Shkkpk/nTTlz1a79mfyx5fIJW9F+6Opwzw7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5184
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_04,2024-10-28_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290064
X-Proofpoint-GUID: ZLBCgUA2OnoFUjbVV10ZJns7l99r2HtZ
X-Proofpoint-ORIG-GUID: ZLBCgUA2OnoFUjbVV10ZJns7l99r2HtZ

On 29/10/2024 04:11, Dave Chinner wrote:
>> Can you advise on a robust method to get some debug from this system?
>>
>> Maybe this is a scheduler issue, as Dave mentioned in that same thread.
> I just got a new hit on the scheduler issue on 6.12-rc5:
> 
> [  172.477662] ------------[ cut here ]------------
> [  172.480660] se->on_rq
> [  172.480682] WARNING: CPU: 3 PID: 728318 at kernel/sched/fair.c:5629 pick_task_fair+0xb6/0x1b0
> [  172.487172] Modules linked in:
> [  172.488911] CPU: 3 UID: 0 PID: 728318 Comm: 291 Not tainted 6.12.0-rc5-dgc+ #273
> [  172.492022] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [  172.496029] RIP: 0010:pick_task_fair+0xb6/0x1b0
> [  172.497978] Code: 40 f3 f3 03 01 74 2a 41 80 7f 50 00 74 96 f6 05 31 f3 f3 03 01 75 8d c6 05 28 f3 f3 03 01 48 c7 c7 41 26 e4 82 e8 7a d7 fa ff <0f> 0b e9 73 ff ff ff c6 05 0d f3 f3 03 01 48 c7 c7 2f 26 e4 82 e8
> [  172.505868] RSP: 0018:ffffc9002ec83d60 EFLAGS: 00010046
> [  172.508111] RAX: bdcdd05ee831a400 RBX: 0000000000000000 RCX: 0000000000000027
> [  172.511139] RDX: 0000000000000000 RSI: 00000000ffdfffff RDI: ffff88881fadc9c8
> [  172.514326] RBP: ffffc9002ec83d88 R08: 00000000001fffff R09: ffff88a018a00000
> [  172.517804] R10: 00000000005ffffd R11: 0000000000000004 R12: ffff888122b58c00
> [  172.520788] R13: ffff88881faf0140 R14: ffff88881faf00c0 R15: ffff88819e8cd180
> [  172.523748] FS:  0000000000000000(0000) GS:ffff88881fac0000(0000) knlGS:0000000000000000
> [  172.527167] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  172.529571] CR2: 00007f378e8866fc CR3: 000000104daae000 CR4: 0000000000350ef0
> [  172.532601] Call Trace:
> [  172.533666]  <TASK>
> [  172.534557]  ? show_regs+0x5e/0x70
> [  172.535993]  ? __warn+0xd0/0x1d0
> [  172.537430]  ? pick_task_fair+0xb6/0x1b0
> [  172.539062]  ? report_bug+0x145/0x1f0
> [  172.540619]  ? handle_bug+0x67/0x90
> [  172.542060]  ? exc_invalid_op+0x1b/0x50
> [  172.543854]  ? asm_exc_invalid_op+0x1b/0x20
> [  172.545688]  ? pick_task_fair+0xb6/0x1b0
> [  172.547353]  pick_next_task_fair+0x27/0x330
> [  172.549090]  __schedule+0x2ad/0xb10
> [  172.550460]  do_task_dead+0x43/0x50
> [  172.551743]  do_exit+0x836/0xab0
> [  172.552950]  do_group_exit+0x8f/0x90
> [  172.554274]  __x64_sys_exit_group+0x17/0x20
> [  172.555808]  x64_sys_call+0x2ed3/0x2ee0
> [  172.557210]  do_syscall_64+0x68/0x130
> [  172.558531]  ? exc_page_fault+0x62/0xc0
> [  172.559907]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  172.561739] RIP: 0033:0x7f378e74b3c5
> [  172.563036] Code: Unable to access opcode bytes at 0x7f378e74b39b.
> [  172.565278] RSP: 002b:00007ffd21861488 EFLAGS: 00000206 ORIG_RAX: 00000000000000e7
> [  172.568001] RAX: ffffffffffffffda RBX: 00007f378e857fa8 RCX: 00007f378e74b3c5
> [  172.570589] RDX: 00000000000000e7 RSI: ffffffffffffff88 RDI: 0000000000000000
> [  172.573182] RBP: 0000000000000000 R08: 00007ffd21861428 R09: 00007ffd218613af
> [  172.575758] R10: 00007ffd21861320 R11: 0000000000000206 R12: 00007f378e856680
> [  172.578356] R13: 00007f378e8b9f40 R14: 0000000000000001 R15: 00007f378e857fc0
> [  172.580941]  </TASK>
> 
> There was nothing particularly obvious that caused it. It's a 64p
> VM, running a heavy concurrent fstests workload that takes about 20
> minutes to complete. There are a bit over 8000 tasks reported, most
> of them kernel threads. The load is consuming about 50 CPUs, 40GB of
> RAM, sustaining ~3GB/s of IO to/from disk across about 130 block
> devices and the scheduler is context switching around 800,000 times
> a second.
> 
> I have no idea how to reproduce this on demand - it randomly shows
> up in about 1 in every 10 test runs and all the tests running at
> that point in time report failure because they all detect this
> warning in dmesg.

I have not been able to test v6.12-rc5 yet.

Can you share your config? And/Or compare to mine at 
https://pastebin.com/Y7DXnMG2

Maybe we can see what was merged for the sched in 6.12, and I can try 
before and after. I don't like the prospect of a full bisect.

Thanks,
John

