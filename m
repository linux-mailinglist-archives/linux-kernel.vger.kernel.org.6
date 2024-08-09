Return-Path: <linux-kernel+bounces-280969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F0994D17D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88AB61F21B32
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E76195FF0;
	Fri,  9 Aug 2024 13:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="IMTgdyaI"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2088.outbound.protection.outlook.com [40.107.247.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307F11953BA
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 13:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723211044; cv=fail; b=b50znmsUV2x3u01dGVV6gcTEEi8mZ6HxCLewEn1WYgGVURdDuNMCOAXjghn174AFdexb9vafyWtKBfW9ABYn54hiJ2oZXooNymKsSGp9WCXVjbca26JHL6xMDvqOxHQe3dkIWbs1YIHIGtYKByjmALEmNc3AVgdyXUjVnKSQce0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723211044; c=relaxed/simple;
	bh=uQC2joQ4+F3V+2Bvm43S+2HgN7y9KxLxJDOFvzddqM8=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dOIUmOh5oW21dFGPEy8lxsCVhu1YWBaTqHc8EdRMNZKwyFosSsWtJPdrugvTK5X8biVj3qFuVGBEi96VPt0NCiRSbCbT08KoWpzcn/WK6HNistOmPmcJyj8fC2nYJPGuntceJlw9s0tcL1RO91PJHyLt+m8RncaJiKAAp9/LRa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=IMTgdyaI; arc=fail smtp.client-ip=40.107.247.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eA5bhxdcFZsNeSC02h4eQtKfNe8yTVho09SEPcRFPMTsyOqEj/WH5v/gLxRi/99FFAvbFHNljFePLscycI6ZkvVRipHoco0GsjH84FaWnRdJqs6kE1hif8yRzPFqZr6DKtkK8ZPCyEgvv7tTkAbb5sPVuDcZDX1oGibE+2Ea9443Q26FaBtKxLbJoU75LswBZmH+eKoxCTUc0vKetbKZ1LUQvZlh+vVcCiC9Zzid4gKdw6+4ucR2gq86xZYT8G2W0LqKzEq89fziHXHHYt9sRpXAZi67WEXQCcJXKFF27B9BBQVTGMPMFCdZxoSoVbD4RU147/aUK8T6UmUCmr7tng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJW35vTZET3ZDtymrU0mPKNUBWPt7I9hth3XI5I0d7Q=;
 b=H9O1iLW+ajWhMQjxDrQjrKaN8dbBuejnGMbj5J3DLZLk5bjHaekYeal5VLK5qpeSvq0reNfe9iiQZi72nxz7L32r/xy49+Ui0tono35rJSJMJYO20tlOrPvsr9qYyHIrihtQMMDyCphQi19wV1APVAVVqSMI3m7m9/WRwK9a7aJKBWF3i/fp8AID3cB7MdQ8ZMquCdsD5OVb6NKTi7nNYHZKaV3Bl1txnkLykav288UIYGEH+Zez28lgjAskNFCFTlmga4rjPnUbkNy5lLXRby1ucjJ5P7GD7wX5i6FiVgh+U7DvP7GbYpIqP9jOHg95jny7IYH2Lcik0sq0+wrwCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJW35vTZET3ZDtymrU0mPKNUBWPt7I9hth3XI5I0d7Q=;
 b=IMTgdyaIuChB+6Spse6lq1vC4PRW6ElrqAprqk82IklqHM93DoCsxInqAPM/P+lprE6GLiSYQ8LFTj1BJX4bCr7tq5WiK0C9HF5kdmuRsZPQVyyv3ijXrw2ftW/8KTupdWbUJob8muhI5usAC1GV2ay9pN4rXa4FU//OwspCYaiQhWs/AuoSYSAbjWS57BzpaCchiQ75C/8oh57PyM95zUc+JGTco3K5Bgr4AyBld8CcuSlNcTXqtnpPS5TuyUPyl/vdfU84nbIYC77JkWRizQFtExR2EfegOH/dIXoKq3uvRWN7oVJiEQUcsKq8y+zY1jRN/apBNQBPSYe/5Dv2hQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by PA4PR07MB8391.eurprd07.prod.outlook.com (2603:10a6:102:2a2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Fri, 9 Aug
 2024 13:43:58 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%5]) with mapi id 15.20.7849.008; Fri, 9 Aug 2024
 13:43:58 +0000
Message-ID: <07272a87-b409-464b-a2e6-283ffc903f11@nokia.com>
Date: Fri, 9 Aug 2024 15:43:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: Print provenance information for addresses in
 registers
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240201153811.1793120-1-stefan.wiehler@nokia.com>
 <ZcDa2RXC6z7XuwAD@FVFF77S0Q05N>
 <91c79fa5-ea6f-4fe1-8458-bfc0dc55a20e@nokia.com>
Content-Language: en-US
Organization: Nokia
In-Reply-To: <91c79fa5-ea6f-4fe1-8458-bfc0dc55a20e@nokia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::22) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|PA4PR07MB8391:EE_
X-MS-Office365-Filtering-Correlation-Id: 21b38e3a-c975-4051-5740-08dcb87951a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWJmMUV1YVZkVG5zODl6VzFhMHB2TzZjNGF4TXRSWWRKZWRpd1VKNmtrTWsx?=
 =?utf-8?B?bG9TdWZOMnZJa1NBT09EcVpTV28yYlFRZVNLOEdLbHJIU3c0bWtmOFZOclpE?=
 =?utf-8?B?SzgwZW5IN25vTWpHMGsxNkFXbytPN0hWUmROdFZmeTdOTm5LY3NQMHB6dkRZ?=
 =?utf-8?B?MFpVMFhnenI3TXFjUzFZSU4yc0xPVjZ4TWdVSVFiZk14T1lOMTE5eHlBalVy?=
 =?utf-8?B?NVo5TVpPWDE5d05HdUVFakRUaytKN3hpSUt2aGt1cUozSUdvS2UrODBja3dY?=
 =?utf-8?B?dHk4dHpPcnNZVWsraTdBUmNaVFhoOXRzTFhRSUVmbUZVMmpiWW43SmtPMHZ2?=
 =?utf-8?B?akc2dUUwUDlSV2FEVHR0NEVNRDdSdzZZZUhlUGxhVkxzdUpBKzJmUzNtbUVK?=
 =?utf-8?B?VU1TYnRvZnRRRWdsYlJBUDNPVmQzandxbFVzdWpKUnpYRjdEZ1ZlaFdGdE5G?=
 =?utf-8?B?eUJFcGIyTzhUT25EWmZFeDIxd2lFcHp5MWdBVGt4NkM2MTcvYnd2S2hBZU95?=
 =?utf-8?B?ZzBaenhzc1Q5bysvS1RwcTN3WWVFVEpTaTFieFhDTExtRXZWYmRLUG80dUdy?=
 =?utf-8?B?UHZ4WVRMVDRFekdOUy9KamVsWWFEUjBYN01samNmZXZUSlZoVGVraXpnNmlS?=
 =?utf-8?B?TXowKzRxWG1zZ09iMXJzVjE0bGp0TmZveFJtUFVmUzBvNmFoMVVtbGFscmFr?=
 =?utf-8?B?NzNzSXR0SXRWWlhMWFMzZjNaZnZmc2tET3VjcWVxTlI2a0pwdjFrMm9wanRZ?=
 =?utf-8?B?cjR3QThwTlhoZFhiMUttYW1MV3QrMWNLWnRSTWJURlFhN2k4b29DOHplRURB?=
 =?utf-8?B?dnBmWlp5N1BUdFZpY2FTS0xDYjhXN3JxTzJNWkJUVzNxVmM0VnJSOW5nK1dl?=
 =?utf-8?B?TE5hRlR3MnhwMzliV21ud1FxSmVVSDBkdUtDajlrVVAwTE5xUU9GMk8wcVEx?=
 =?utf-8?B?ZzlSN2xWR1AraHl1TmpSYU8zdUNQMGUzaUY0Z3NmWWJnY2k4K3NkWEhCOHFL?=
 =?utf-8?B?MklFdG1sSlY4RWNFUDMxSW5tUHBkdGlubjhZdEFpeHZMQ2RObWJ4TWkyazVx?=
 =?utf-8?B?N2JDQ1pwVEhjQU1GcHlhaEFTTWR3M1NDY1JacWJKZGFRM2JHampZMWlxd2xE?=
 =?utf-8?B?VHBHVFlEenhqdTlEQmdsOGNOVkRLaTMzbndIc1NSMGJqdmlPM0ZOSXJhZXlM?=
 =?utf-8?B?YWJmUys3Wk9UbTRXYWU5akJGWmxQMW95NkJmQ1JoZStQeTM5Mnl5bytOTmVW?=
 =?utf-8?B?UWRNWjlNcHFiZyt6TlpDV2pTSEdqbUprbXlRVU9LTjVBaVdnZVBiTGNHYVNq?=
 =?utf-8?B?MkNMcnluZDNYNytVd09BY3FSZDJQRldzUUxVUG42TGo1RUlPMzltV2FLR0Nh?=
 =?utf-8?B?a0toQk1abTdZR0Y2MFFzRForelJNUGNGaThRTmFuSWtrUEh1NUFVdjI1Y0xZ?=
 =?utf-8?B?cExiSlNDTWpVWmVMZHptMk1nTlBNSU5keWRaTytCQ3o1NVVnY3k3VndNdWVX?=
 =?utf-8?B?cnA1Q0sxbHduYk9HTmFJTjlSaXc3U25DdS9ucExpNG9CQ3g0RE5YMjhYOFBs?=
 =?utf-8?B?cU93Rmo4RlhFL2pwSzZIN3NEd1JNTHpYM2haa3BpWUxtWk9mV1ZxeFJWVlda?=
 =?utf-8?B?cHJRZ050VmFLcEVyYnBFRHhMYVpGZGNXeGRObWhVS3NBenEvbEpYMEZIN1RG?=
 =?utf-8?B?VUFpNWpMZkJiZ3cyei9tMWkydWVKK2VMZjN5aEMrUGxBLzdvb2EwQjJvYTB4?=
 =?utf-8?Q?3BbPQq72KEK366jMuxnt7eoSXExkgF7irJx8o6r?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TllNL1M2bTFrVThZRGVjUURpQkRHQlVoTEhJdEQrSFhZWnJ4UThyK1MzeDNt?=
 =?utf-8?B?VzZiK2JtWFdHNjRWdi9INW5aU2orQnVQOHdxaFB2bnp0SklpSjZMRmg1Rkk5?=
 =?utf-8?B?aGg3K1RPWmNDT2xVUTlzR1FIbjF4aWxodU83SUZRbk14R2V4aG1keDlkT3Zk?=
 =?utf-8?B?dmxKL0lwNzhkVm1sZ28zUVgrMnhkbUJoa244M1E0YlBoSXFKb096UGRoSUJP?=
 =?utf-8?B?NUppVGtGUmNabzloY2t3NUdmTVdscHJ0RzhTMERKc3BYeTVPZWZRS0tUOCtY?=
 =?utf-8?B?a1NVMW5vMDQ0SHBFQ0txdVdhNDFFbEpXRWREdy9XZURDRGNId2xqeVhabmE0?=
 =?utf-8?B?bTgwUDhpbEEyZ2J2djdGdWo4OHBKampsUnZ3SDZ5ZGdqTmc4NXpiZ0s5QTF2?=
 =?utf-8?B?dXJPcXU4MWdia29Zb3dRM1RFSDZFQk5zcWVPTTNEWW01cVJhT2hqeVhuYlZS?=
 =?utf-8?B?ek8yQng2UG5hVWNwRE9TYXgzalYya09neXh1WDBxd0ZUZjRVUjQyL3FZeEVz?=
 =?utf-8?B?NlM5RkphRlduMGRETkhsdjVxOElwM1hpMzNkaGJYYk5qK3JWZU8rOUNYYnVi?=
 =?utf-8?B?V3haRzdWUEtNK3QzMjlWWnpPNmIxTjJoendGVEVBRXVvVEJUQWtuYk4xY2Fj?=
 =?utf-8?B?RkZHM0IrV0lEekxUM0ZkT2FJUER5S20xVWp1cE45N29xYWx5K2t1UXI3MEts?=
 =?utf-8?B?UjNSVjJiOUJLenhVZk02c0dTdjJHTUxWYXUxQmpONWRHTVhNKzZxTWhvMmxV?=
 =?utf-8?B?OG5IbGl6anRuc1R4K0QrVTJVc215UkFRdnlaYUl5N2IvelQxZWkrVmlJZmRl?=
 =?utf-8?B?eWZuY29jVGhJK0ZYbm9jbDZDalMrdDY1ei9BUlRnYUJZS3ZHeDc2dzRXOUk5?=
 =?utf-8?B?THdnTVArVHVIRkJicVVRZ3ZGcDZQV3dZbVQyY0ZaNkYzeVFuOUJDeVllWVlp?=
 =?utf-8?B?cDQ3NUoyRUVyN1JmdlRlUmRPczAxbmNKR2ZHbU9ueERUUEpERmVXZ1F4RHV5?=
 =?utf-8?B?ci9IMHNzdlRtSWRYL3lMQXpOVVNJMlVjbURHOTNFZGlPWTNhTmNRWFErK0JC?=
 =?utf-8?B?YVRES2tiWXJpSHRHb2FpL2EyUDBETlhQbmtmOThjNDVKa2k1K3hQRGZucThy?=
 =?utf-8?B?WElHVHBsZTRVVisrY0RNbW1xbnNnRXdtcHVFNmhZSE9Wd3pjcjVNUTRrdG55?=
 =?utf-8?B?N0c0bUl2a0ErTklLN0RzNmxpVVh6SnRVN1VpS1VMZVdpaGlqQWdBUjJ5Wldt?=
 =?utf-8?B?ZmprQk9TS2VQZXpqZUVMaE1CcW1pMDgyQVBtakJPeW9LQk5mOEFVMmIvR2l4?=
 =?utf-8?B?ZXZ6dXd6NlMrZ1BHemNvTzAxV0tNM2ZMSm52bHAwRmpBZW9ZN0YyRlBIb0ow?=
 =?utf-8?B?U0o3NEQxTkhWQzg3WWk2OTc5WlVTOUU0cFVZWmRNOTlSdUUwWU1sK0NhbzAx?=
 =?utf-8?B?QVhHTFpubC9PdkNhOFE0bXVJSTFybWtGQjVaOWpqMnlJOE0xMS9vQjBDNlF4?=
 =?utf-8?B?YUg3aU5XNHpCakJkejNsOGNldWNHUkNBaDJBOFpsZ0lSK0hNTS9KM0xVZmRC?=
 =?utf-8?B?Vm1uWW9YNldFb0N1VEMwMDJ3Y0JwZG9YRXJuL2lYaE4vSHNDRm5QSTBQNHBa?=
 =?utf-8?B?N29nYTJZRm1QL21kWjlyUHhIYkthUDZPcktoZ1MvWWxWdnl1ZEs3NnBSMW9O?=
 =?utf-8?B?KzRtVmlWZlVjQ2dWVXlLYjQ4bEpxVVBBZkxNa0ZwVFNsZzcyTFdONm1OTUJ1?=
 =?utf-8?B?S0gvYWp0R3Uzc0tDRDRxVlU2TGtuUTEwWVVIQS9oTEhNOE9vQ0xKczFwTmRs?=
 =?utf-8?B?Zld4Q0dyczRlZVQ2em5MRGxUMWU0aFk4bG01SkM5T3k4djNORUprMzV6V0ZJ?=
 =?utf-8?B?OXBCeVc4eDEvc3pRd1l3RytBa3c3NUVySTJvcmVYaytpOW4waUFhUWxGYmIx?=
 =?utf-8?B?N29PTGxSc1JVbmNvSUZqQ241L0ljZUJVVHU3QythLzBYN08wYVZTak1PRWdm?=
 =?utf-8?B?ZlZKdTlGUHRYWDFiYjVmOGkvTjVDSEVHSVdacWZ2ZWJiVzMyLzltRjVvQ0I4?=
 =?utf-8?B?eGFDemgyV2ZYZjRvSXFRUmR5eXpFb0paYlFqSy9QWVdIVG16aHAydTVXUzVP?=
 =?utf-8?B?NFZyem8yWGxKdkZZT0h0ZFZsRm9hdWxvTENhbnlBVDVRSHRFOEsyK1NyUkJZ?=
 =?utf-8?B?dnhBQUYxODdkbm5ZTzlaZmpEN1dSTS9vRzRTazBUa29XZHlQaVZxc3FSd2hh?=
 =?utf-8?B?ckMwY3QrRGhJbDloZ3JZOU8yY2RnPT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b38e3a-c975-4051-5740-08dcb87951a3
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 13:43:58.1315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJQTTUtPlfXyCLPGYtsF9QAB7AZkrNAVVn+Ua38lMFC6vwmvyIZ+jkSdKZOcDu7zbAnQWfhlpmp+ZsdwSgB4NJZddQt9UJJ9XOwdrrKlwiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB8391

Hi Mark,

Did you have a chance to take a look at below reasoning for this change
and my proposal for a slightly less verbose version of this patch?

>> Regardless of what 32-bit ARM does, I don't think it makes sense to dump this
>> for all the GPRs. It's incredibly verbose and not all that helpful, e.g.
>> testing with the LKDTM WRITE_RO test I get:
>>
>> | # echo WRITE_RO > /sys/kernel/debug/provoke-crash/DIRECT
>> | lkdtm: Performing direct entry WRITE_RO
>> | lkdtm: attempting bad rodata write at ffffadee958c1bf0
>> | Unable to handle kernel write to read-only memory at virtual address ffffadee958c1bf0
>> | Mem abort info:
>> |   ESR = 0x000000009600004e
>> |   EC = 0x25: DABT (current EL), IL = 32 bits
>> |   SET = 0, FnV = 0
>> |   EA = 0, S1PTW = 0
>> |   FSC = 0x0e: level 2 permission fault
>> | Data abort info:
>> |   ISV = 0, ISS = 0x0000004e, ISS2 = 0x00000000
>> |   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
>> |   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>> | swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000041d6d000
>> | [ffffadee958c1bf0] pgd=100000043ffff803, p4d=100000043ffff803, pud=100000043fffe803, pmd=0060000041600f81
>> | Internal error: Oops: 000000009600004e [#1] PREEMPT SMP
>> | Modules linked in:
>> | CPU: 4 PID: 147 Comm: sh Not tainted 6.8.0-rc3-00001-gc66454d88811 #1
>> | Hardware name: linux,dummy-virt (DT)
>> | pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
>> | pc : lkdtm_WRITE_RO+0x3c/0x54
>> | lr : lkdtm_WRITE_RO+0x24/0x54
>> | sp : ffff800080913c80
>> | x29: ffff800080913c80 x28: ffff0000c09ca200 x27: 0000000000000000
>> | x26: 0000000000000000 x25: 0000000000000000 x24: 0000aaaaee418930
>> | x23: ffff0000c0645780 x22: ffff800080913df0 x21: ffffadee96c957a0
>> | x20: 0000000000000009 x19: ffffadee958c1000 x18: 0000000000000006
>> | x17: 0000000000000000 x16: 0000000000000000 x15: ffff800080913720
>> | x14: 0000000000000000 x13: ffffadee969310b0 x12: 0000000000000432
>> | x11: 0000000000000166 x10: ffffadee969890b0 x9 : ffffadee969310b0
>> | x8 : 00000000ffffefff x7 : ffffadee969890b0 x6 : 80000000fffff000
>> | x5 : ffff0003fdfb5cc8 x4 : 0000000000000000 x3 : 0000000000000000
>> | x2 : 00000000abcd1234 x1 : 000000000198b861 x0 : ffffadee95e334a0
>> | Call trace:
>> |  lkdtm_WRITE_RO+0x3c/0x54
>> |  lkdtm_do_action+0x1c/0x30
>> |  direct_entry+0xbc/0x144
>> |  full_proxy_write+0x60/0xb4
>> |  vfs_write+0xd0/0x35c
>> |  ksys_write+0x70/0x104
>> |  __arm64_sys_write+0x1c/0x28
>> |  invoke_syscall+0x48/0x110
>> |  el0_svc_common.constprop.0+0x40/0xe0
>> |  do_el0_svc+0x1c/0x28
>> |  el0_svc+0x34/0xb4
>> |  el0t_64_sync_handler+0x120/0x12c
>> |  el0t_64_sync+0x190/0x194
>> | Register x0 information: 0-page vmalloc region starting at 0xffffadee95470000 allocated at paging_init+0x148/0x6f4
>> | Register x1 information: non-paged memory
>> | Register x2 information: non-paged memory
>> | Register x3 information: NULL pointer
>> | Register x4 information: NULL pointer
>> | Register x5 information: non-slab/vmalloc memory
>> | Register x6 information: non-paged memory
>> | Register x7 information: 0-page vmalloc region starting at 0xffffadee96910000 allocated at paging_init+0x1d8/0x6f4
>> | Register x8 information: non-paged memory
>> | Register x9 information: 0-page vmalloc region starting at 0xffffadee96910000 allocated at paging_init+0x1d8/0x6f4
>> | Register x10 information: 0-page vmalloc region starting at 0xffffadee96910000 allocated at paging_init+0x1d8/0x6f4
>> | Register x11 information: non-paged memory
>> | Register x12 information: non-paged memory
>> | Register x13 information: 0-page vmalloc region starting at 0xffffadee96910000 allocated at paging_init+0x1d8/0x6f4
>> | Register x14 information: NULL pointer
>> | Register x15 information: 4-page vmalloc region starting at 0xffff800080910000 allocated at kernel_clone+0x64/0x360
>> | Register x16 information: NULL pointer
>> | Register x17 information: NULL pointer
>> | Register x18 information: non-paged memory
>> | Register x19 information: 0-page vmalloc region starting at 0xffffadee95470000 allocated at paging_init+0x148/0x6f4
>> | Register x20 information: non-paged memory
>> | Register x21 information: 0-page vmalloc region starting at 0xffffadee96910000 allocated at paging_init+0x1d8/0x6f4
>> | Register x22 information: 4-page vmalloc region starting at 0xffff800080910000 allocated at kernel_clone+0x64/0x360
>> | Register x23 information: slab dentry start ffff0000c0645780 pointer offset 0 size 192
>> | Register x24 information: non-paged memory
>> | Register x25 information: NULL pointer
>> | Register x26 information: NULL pointer
>> | Register x27 information: NULL pointer
>> | Register x28 information: slab task_struct start ffff0000c09ca200 pointer offset 0 size 4352
>> | Register x29 information: 4-page vmalloc region starting at 0xffff800080910000 allocated at kernel_clone+0x64/0x360
>> | Code: f2b579a2 900089c0 ca020021 91128000 (f905fa61)
>> | ---[ end trace 0000000000000000 ]---
>>
>> Looking at the dump, the vast majority of those "Register X?? information:"
>> lines are irrelevant, and it's difficult to see the wood for the trees.
>>
>> Why do we need this for (almost) all registers, rather than just the faulting
>> address?
> 
> We often get bug reports of rarely reproducing issues on customer sites
> where we would like to dump as much helpful information as possible.
> 
> Let me show you an example of an ARM32 oops where register provenance
> information proved to be quite useful (abbreviated):
> 
>   Unable to handle kernel NULL pointer dereference at virtual address 0000001c
>   pgd = ea66fa29
>   [0000001c] *pgd=8461ab003, *pmd=8f7d9c003
>   Internal error: Oops: 207 [#1] PREEMPT SMP ARM
>   ...
>   PC is at do_open_execat+0x180/0x228
>   LR is at 0x0
>   pc : [<c03f9640>]    lr : [<00000000>]    psr: 40070013
>   sp : c7c27ee8  ip : 00001020  fp : 0002fde4
>   r10: 0000000b  r9 : 00000001  r8 : 00000000
>   r7 : 00000100  r6 : c66aa0c0  r5 : c15f8000  r4 : 00000000
>   r3 : 000a801d  r2 : 00001020  r1 : 00020020  r0 : c417f990
>   Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
>   Control: 30c5387d  Table: 46572940  DAC: 55555555
>   Register r0 information: slab dentry start c417f990 pointer offset 0 size 36
>   Register r1 information: non-paged memory
>   Register r2 information: non-paged memory
>   Register r3 information: non-paged memory
>   Register r4 information: NULL pointer
>   Register r5 information: slab names_cache start c15f8000 pointer offset 0 size 4096
>   Register r6 information: slab filp start c66aa0c0 pointer offset 0
>   Register r7 information: non-paged memory
>   Register r8 information: NULL pointer
>   Register r9 information: non-paged memory
>   Register r10 information: non-paged memory
>   Register r11 information: non-paged memory
>   Register r12 information: non-paged memory
>   Process ddal (pid: 14765, stack limit = 0xdb737995)
>   Stack: (0xc7c27ee8 to 0xc7c28000)
>   ...
>   [<c03f9640>] (do_open_execat) from [<c03f987c>] (bprm_execve+0x150/0x6b4)
>   [<c03f987c>] (bprm_execve) from [<c03f9f8c>] (do_execveat_common+0x1ac/0x208)
>   [<c03f9f8c>] (do_execveat_common) from [<c03fae08>] (sys_execve+0x38/0x40)
>   [<c03fae08>] (sys_execve) from [<c0200140>] (ret_fast_syscall+0x0/0x40)
>   Exception stack(0xc7c27fa8 to 0xc7c27ff0)
>   ...
> 
> From the disassembly we can see that the null pointer comes from r6:
> 
>   (gdb) disassemble do_open_execat+0x180
>   ...
>      0xc03f9638 <+376>:   ldr     r0, [r6, #12]
>      0xc03f963c <+380>:   ldr     lr, [r0, #40]   ; 0x28
>      0xc03f9640 <+384>:   ldr     r3, [lr, #28]
>   ...
> 
> Thanks to register provenance information we know now that r6 points
> into the filp SLAB cache, and by following the offsets added we can find
> the null pointer entry.
> 
>> In die_kernel_fault() we already print some information regarding the psecific
>> faulting address:
>>
>> | static void die_kernel_fault(const char *msg, unsigned long addr,
>> |                              unsigned long esr, struct pt_regs *regs)
>> | {
>> |         bust_spinlocks(1);
>> |
>> |         pr_alert("Unable to handle kernel %s at virtual address %016lx\n", msg,
>> |                  addr);
>> |
>> |         kasan_non_canonical_hook(addr);
>> |
>> |         mem_abort_decode(esr);
>> |
>> |         show_pte(addr);
>> |         die("Oops", regs, esr);
>> |         bust_spinlocks(0);
>> |         make_task_dead(SIGKILL);
>> | }
>>
>> ... and IMO it'd make more sense to call mem_dump_obj() there, e.g.
>>
>> | static void die_kernel_fault(const char *msg, unsigned long addr,
>> |                              unsigned long esr, struct pt_regs *regs)
>> | {
>> |         bust_spinlocks(1);
>> |
>> |         pr_alert("Unable to handle kernel %s at virtual address %016lx\n", msg,
>> |                  addr);
>> |
>> |         pr_alert("Fauling address:");
>> |         mem_dump_obj((void *)addr);
>> |         kasan_non_canonical_hook(addr);
>> |
>> |         mem_abort_decode(esr);
>> |
>> |         show_pte(addr);
>> |         die("Oops", regs, esr);
>> |         bust_spinlocks(0);
>> |         make_task_dead(SIGKILL);
>> | }
>>
>> ... which produces significantly more legible output, e.g.
>>
>> | # echo WRITE_RO > /sys/kernel/debug/provoke-crash/DIRECT
>> | lkdtm: Performing direct entry WRITE_RO
>> | lkdtm: attempting bad rodata write at ffffa66f5e2c1bf0
>> | Unable to handle kernel write to read-only memory at virtual address ffffa66f5e2c1bf0
>> | Fauling address: 0-page vmalloc region starting at 0xffffa66f5de70000 allocated at paging_init+0x148/0x6f4
>> | Mem abort info:
>> |   ESR = 0x000000009600004e
>> |   EC = 0x25: DABT (current EL), IL = 32 bits
>> |   SET = 0, FnV = 0
>> |   EA = 0, S1PTW = 0
>> |   FSC = 0x0e: level 2 permission fault
>> | Data abort info:
>> |   ISV = 0, ISS = 0x0000004e, ISS2 = 0x00000000
>> |   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
>> |   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>> | swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000041d6d000
>> | [ffffa66f5e2c1bf0] pgd=100000043ffff803, p4d=100000043ffff803, pud=100000043fffe803, pmd=0060000041600f81
>> | Internal error: Oops: 000000009600004e [#1] PREEMPT SMP
>> | Modules linked in:
>> | CPU: 3 PID: 148 Comm: sh Not tainted 6.8.0-rc3-00002-gf95e3bd06270-dirty #2
>> | Hardware name: linux,dummy-virt (DT)
>> | pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
>> | pc : lkdtm_WRITE_RO+0x3c/0x54
>> | lr : lkdtm_WRITE_RO+0x24/0x54
>> | sp : ffff80008098bc80
>> | x29: ffff80008098bc80 x28: ffff0000c144a200 x27: 0000000000000000
>> | x26: 0000000000000000 x25: 0000000000000000 x24: 0000aaab235e21d0
>> | x23: ffff0000c06459c0 x22: ffff80008098bdf0 x21: ffffa66f5f6957a0
>> | x20: 0000000000000009 x19: ffffa66f5e2c1000 x18: 0000000000000006
>> | x17: 0000000000000000 x16: 0000000000000000 x15: ffff80008098b720
>> | x14: 0000000000000000 x13: ffffa66f5f3310b0 x12: 0000000000000432
>> | x11: 0000000000000166 x10: ffffa66f5f3890b0 x9 : ffffa66f5f3310b0
>> | x8 : 00000000ffffefff x7 : ffffa66f5f3890b0 x6 : 80000000fffff000
>> | x5 : ffff0003fdf9fcc8 x4 : 0000000000000000 x3 : 0000000000000000
>> | x2 : 00000000abcd1234 x1 : 000000000198b861 x0 : ffffa66f5e8334b0
>> | Call trace:
>> |  lkdtm_WRITE_RO+0x3c/0x54
>> |  lkdtm_do_action+0x1c/0x30
>> |  direct_entry+0xbc/0x144
>> |  full_proxy_write+0x60/0xb4
>> |  vfs_write+0xd0/0x35c
>> |  ksys_write+0x70/0x104
>> |  __arm64_sys_write+0x1c/0x28
>> |  invoke_syscall+0x48/0x110
>> |  el0_svc_common.constprop.0+0x40/0xe0
>> |  do_el0_svc+0x1c/0x28
>> |  el0_svc+0x34/0xb4
>> |  el0t_64_sync_handler+0x120/0x12c
>> |  el0t_64_sync+0x190/0x194
>> | Code: f2b579a2 900089c0 ca020021 9112c000 (f905fa61)
>> | ---[ end trace 0000000000000000 ]---
>>
>> ... and likewise even when we hit addresses without KASAN shadow:
>>
>> | # echo ACCESS_NULL > /sys/kernel/debug/provoke-crash/DIRECT
>> | lkdtm: Performing direct entry ACCESS_NULL
>> | lkdtm: attempting bad read at 0000000000000000
>> | Unable to handle kernel paging request at virtual address dfff800000000000
>> | Fauling address: non-paged memory
>> | KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>> | Mem abort info:
>> |   ESR = 0x0000000096000005
>> |   EC = 0x25: DABT (current EL), IL = 32 bits
>> |   SET = 0, FnV = 0
>> |   EA = 0, S1PTW = 0
>> |   FSC = 0x05: level 1 translation fault
>> | Data abort info:
>> |   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
>> |   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>> |   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>> | [dfff800000000000] address between user and kernel address ranges
>> | Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
>> | Modules linked in:
>> | CPU: 2 PID: 149 Comm: sh Not tainted 6.8.0-rc3-00002-gf95e3bd06270-dirty #3
>> | Hardware name: linux,dummy-virt (DT)
>> | pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
>> | pc : lkdtm_ACCESS_NULL+0x2c/0xa4
>> | lr : lkdtm_ACCESS_NULL+0x24/0xa4
>> | sp : ffff800080d87ab0
>> | x29: ffff800080d87ab0 x28: ffff0000c5296f14 x27: 1fffe00018a52df5
>> | x26: ffff0000c5296fa0 x25: 1fffe00018a52df4 x24: ffff0000c8fcda00
>> | x23: 0000aaaadb0a7040 x22: ffff800080d87d70 x21: ffffcb98b050dae0
>> | x20: 000000000000000c x19: ffffcb98acd53f40 x18: ffff0003fdff56c0
>> | x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>> | x14: 0000000000000000 x13: 3030303030303030 x12: ffff7000101b0ee1
>> | x11: 1ffff000101b0ee0 x10: ffff7000101b0ee0 x9 : dfff800000000000
>> | x8 : 00008fffefe4f120 x7 : ffff800080d87707 x6 : 0000000000000001
>> | x5 : ffff800080d87700 x4 : 1fffe000191f9b41 x3 : 0000000000000000
>> | x2 : 0000000000000000 x1 : ffff0000c8fcda00 x0 : dfff800000000000
>> | Call trace:
>> |  lkdtm_ACCESS_NULL+0x2c/0xa4
>> |  lkdtm_do_action+0x3c/0x68
>> |  direct_entry+0x130/0x228
>> |  full_proxy_write+0xd4/0x140
>> |  vfs_write+0x1e4/0x8ec
>> |  ksys_write+0xf4/0x1e0
>> |  __arm64_sys_write+0x6c/0x9c
>> |  invoke_syscall+0x6c/0x254
>> |  el0_svc_common.constprop.0+0xac/0x230
>> |  do_el0_svc+0x40/0x58
>> |  el0_svc+0x38/0x70
>> |  el0t_64_sync_handler+0x120/0x12c
>> |  el0t_64_sync+0x190/0x194
>> | Code: aa1303e0 97adbc11 d2d00000 f2fbffe0 (39c00000)
>> | ---[ end trace 0000000000000000 ]---
> 
> I understand that the proposal is currently too verbose, but printing
> provenance information only for the faulting address would not have
> helped in above example. What do you think about printing only registers
> that hold information useful for debugging, i.e. by excluding null
> pointers and non-paged areas?

Kind regards,

Stefan

