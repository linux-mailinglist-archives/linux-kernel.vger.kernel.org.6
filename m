Return-Path: <linux-kernel+bounces-572750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 724DFA6CE1B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 07:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2B6E3B4E4A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 06:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB6F1FFC67;
	Sun, 23 Mar 2025 06:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SYABepXR"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C20F1B532F
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 06:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742712700; cv=fail; b=DH4YpKLJuEkPjlWa1Dzj/qMJBqhNmPNIfC45DuwIDYcYaGCe2t/LgtZXkk/A1eX+HntDRp6Gdr70TuVUXjqTLWS9Y0xggOofiAbWcVD8Ku0s3M53tDIHN81pfM8Lw6Rrx4SthWyHIW6ruU0yIKeymymurBUQPlg1DSTZ9hIK4X4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742712700; c=relaxed/simple;
	bh=k0nSgMh9FalQdHypv7CHDg1IfG1QehNhy0Vkt3yL0cw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qYnsQhj7eAyFxKLLj+lCElmde3DzuwaUlU1k5jGfoYMl7LLbpZcDAy/xldayNm1FxZWO+71yBpqfSGRmd/evb8keBD7GWMWwB71xB667l+GBge5C2BqVoaNe0FV7L29XBXv/TfBGgakPcDhrUkjHLvBdT+69kq1ThVHxwiEUDE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SYABepXR; arc=fail smtp.client-ip=40.107.100.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WENAu/j7DHeqOyZl4lEPwqbxRpKWu92Qrr89k0mCkJW8jsGwkuKoRK0AxR/WkS7TzvtSjzyzRxSo8QzYFUQKeN2wBwQhTZ3d4szSOESjoP7Dk39gVBALDAhlWEDLYqaNKHwHL/qZucqiEYC+zuZ/4T+j69ElEcNdCPw+XU/nhYUNMGyj6dEuUZHLxfl8S/7uOyhDhuMfUGK/qCsv31MIIB1ne4zskwejo/Me7kSs906Y4Zx5OeqruP3zrtKhybsPqWs6LeVR/fZK7oSjKV/wUqgzRZn+gRpDA4G91edExqOTkh9gBV03jBx0qrBAOZ9IKadHE/HzFIBwP9sWBJnWdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CbDm2xIQIJsxF5WIUu2LItUzsh//XBGx8qGCy1/i9g=;
 b=S7vPRWWnBaXcTkXDZLzJ7F5hJBRLwdtrhedwFR/WKzAwWRKWUK1A7JWhQr3dXSOova1q+MfDJPgp+qrqO4/b/tMdCgQqZIp9NmuVIAz/IW9ILvJ85xpLVPQrYB1q+qCPFu+htMA6H9Yab7yzQwEQcpVZtfcvNIPabgTiEUHeWwpYoLoFitgJOMv5FCc3ANlhMl6xB2ZgHnmNv+MhjAErT0NZU4X+bY1OiGPM5nDSpqGtN+nvfSHKGQ1x8zgQLQrF3t7jMkieZZLFy8RvHYf+gyqvZEl0za27rxOEp6kKVwPu71Z7koWor3yCAuU37VbMYTXP2a24JOgh7/b3qCiHHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CbDm2xIQIJsxF5WIUu2LItUzsh//XBGx8qGCy1/i9g=;
 b=SYABepXRumMheP5KQ1NiZVcWd2GWsfDnF/OgN5Iqkqho36iRaZgkUiVTA7jEkO30PWW0CxI2d2xSDA38TuvDeCiHYtQLtt3ZLHjgfGteCh8tkCkuEoi50wF45/i/lwVyLb6In8EQJfFCrVHJTv7o0nIN1o5Z2Z4c8i3jPb6p/kTdAe8TLWpZfv3R1bovAZH2sDKObGVLBjBNJQwLDM6zt0MlH8SssVBRx9n6kF2jg9nNghVsJW9FjzU+0CTMYTscsergSMaGudoSM0qpWPdCzUixk+JfNvZEp0QlakJetUSbsj16o8+5NxiJ0+X58MJMl+WqlIar7kGntSUDgXHIjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 by DS7PR12MB8250.namprd12.prod.outlook.com (2603:10b6:8:db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Sun, 23 Mar
 2025 06:51:35 +0000
Received: from SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868]) by SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868%6]) with mapi id 15.20.8534.031; Sun, 23 Mar 2025
 06:51:35 +0000
Message-ID: <688f2757-e364-45db-ad54-daa6ff1c4f3c@nvidia.com>
Date: Sun, 23 Mar 2025 17:51:29 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: commit 7ffb791423c7 breaks steam game
To: Bert Karwatzki <spasswolf@web.de>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org
References: <20250322122351.3268-1-spasswolf@web.de>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <20250322122351.3268-1-spasswolf@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0095.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::36) To SA1PR12MB7272.namprd12.prod.outlook.com
 (2603:10b6:806:2b6::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB7272:EE_|DS7PR12MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: 13be2490-cc1f-403c-9815-08dd69d726df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHdiUGNyWTBpYVVQOXFmamlJblRTa1J6M2pmTFhnVWhRdmNnZTlBMW1LTHJ1?=
 =?utf-8?B?ZTdNb0htdkdqQU9MV0dUOWI3RFdSYXNVMTNYejNPbEVqSXllb21meGhxWlJI?=
 =?utf-8?B?NElQaHhpdVVXcWdyV1dNc0RFOWFBcXFjOWYyeWpnWUJ3TWdWb1M2aUdndXZo?=
 =?utf-8?B?dHZSbm8xbFBCMVBETTN3djNwRE9xS3puR0U4eVFMK1AxRGhrZ05WRDJ0S2c1?=
 =?utf-8?B?SFM4OSt2Z21Qc2hBcDJ4aVVWcU9XKzdQZzZ4aThJZEpqZnI2d0hlbFZvMWQ3?=
 =?utf-8?B?a3N0cFo1bmFFN2lqcUtmQXVXOGVrVHRNK21XczRvZGtmNFpob0doekxFaG1V?=
 =?utf-8?B?MFVyd2wwVWZVSEY4M3Y1NTFQcUttN01wMThEcEJrTkJvSHVuZk0wblRRSVow?=
 =?utf-8?B?eWsyeGRLc0l2NnkraXhlRXBCRW9aK1BZSUMxOTFYRHM5TkRjK1RHR1V5aFpN?=
 =?utf-8?B?aGwwdzhnd1VzNFFDaGpiMkM5TlZWL2U0L0J5QUduUVVyRGNKZEVWaWlJYWc3?=
 =?utf-8?B?VTdjZURFZVZJeG9KdklNQmhWZXJjTVBJNHJLalF0M0VnREVmdXA2YytpSnR3?=
 =?utf-8?B?cU9jVW5pN0lLZkRoSEg5aDlXRVV3Mi94TDlpNEVzNXJmeCt3cTRkajd0ZzB1?=
 =?utf-8?B?RnlkR29HQkJwSmxMVUh2bUFWRDc1K290MlhoaFdTdVBIa3EyTVg2dGgzY1h0?=
 =?utf-8?B?dEFEbTEvNkZYcDU0emdUU1Vqa1dCc1ZUYm1qVllLY2ZaQk9ZUVpoeENoMk5p?=
 =?utf-8?B?Y0RET054VzBkSm9qSWE3c1hlVUJGdWRkNlNHS21HUm9acldCa0xFaFNqRUFN?=
 =?utf-8?B?OGk2dlhjQ09YYnV6RGNyVmtCaG5vTExhUjIvRHNLU1pEYktEVFJ6aVlqRXpZ?=
 =?utf-8?B?dWV2Qkk1eG96aFAxenAzbG94d0tDRERkcU1HNUJTZ1ZXTGd6R0I0K0t4SG9s?=
 =?utf-8?B?RzJHKzZ5YlRzTGFhUlJaSUFQWFdjeERnRkkvcXBzNnc2cDB5RmxpNG9Rd1Ru?=
 =?utf-8?B?SGpyYlZ1T1pwQlF5dFJ5TnVGaWhHWWdvdTJVUDBqQzhyVTd6amRWYXhxd0Yz?=
 =?utf-8?B?TWt5Ym1BaytOSVhaaWEyL1RqclBLWHo4ZWxBZksyaHZWZDFjc3lQQjFtS2R3?=
 =?utf-8?B?Y3RWcU1SY3dlWDNML281ZUprRHdsdlJtejlpcm12aFI1aC96dVU0YXZwNnJV?=
 =?utf-8?B?RmdWNEpwYVp5UjFEWXZxMUhGM2phVmFYWVJGMVF1NTVhbXBHWncrVmFrQXJZ?=
 =?utf-8?B?ajVDY09pZ0tTbzR4Q25xcE5uMjl6SS96eVdTRjJMM0U1ekxmL3Z5OUhMalMy?=
 =?utf-8?B?TEU4bHhEOVV4VTFqTHNPQkx6K1ZoemNHTnBtRkRVT1UvMGtQYndIelV5Z1Qz?=
 =?utf-8?B?Y0hvdHhMdnQ3M2lXaWo4bWVIUmZncCtQdm40cHN2YnB4dklhMnVKYlNyOHdX?=
 =?utf-8?B?RThhdjc0VWFGbnRIdlcrL0k4eGFTOU5GS1U1QnRkekhHL2FweHNmenhMaVhY?=
 =?utf-8?B?SXZPYThFeDYxRFdyU2o0RU5uTy9JcmJLRlJaTTJQM1Q1bXNJSEw0c290c0lO?=
 =?utf-8?B?cHA4ZHdMTitvY3QvYXJEbTZ2MlE0VmlmNmw5RGQraHl3VDZQazNiTzl6bWtT?=
 =?utf-8?B?ZENOanE2eDhnYXprREJOY2tWdnFUK0pNdUlaVElwUFhSUnRjSEFnUG9FQnYw?=
 =?utf-8?B?R0MxL2ZkeTJOZGZqUUVZNnIwWkJocWIwU3liZytaRjN6emVnUUo3MUQ0cGtT?=
 =?utf-8?B?Sy9MRkNRcjNRZHNGYlliL1NYaTJYTkQ2Wm5aZFNQRXIrcFpLdFRQbWk4V3A4?=
 =?utf-8?B?N3hjZ1BXQy9XNG4wMHFVSnVuNW14NDFzZ2NxYUUwdkpVS3dtUytLaVJHR0pn?=
 =?utf-8?Q?KLSbap0qlhk9y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7272.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2xteGRtb2tjZjdXTkxTeGlIdzBOc0FrY3hEb0ZpVkdCTlZPeE9hY1VFNjRX?=
 =?utf-8?B?c3RhckZxTUwvZHIxL1k3bFRHY3hCN2V2S2lLWFpDcmxGT1JWSFpOMGVQUHVl?=
 =?utf-8?B?cGk0NGt2azg1emVHTDRmTnIrWFhkaVRmSk1TeTcwRHlMTTNKMVRKT0N3YjhO?=
 =?utf-8?B?R0YwQU94dkQwd1E2K3J1OVljeWR5ek51dTV1UzEwRWtHMFJRZTNoRnFWU09X?=
 =?utf-8?B?R05LVHUreURUcnpCTXR3TVY3cUhWMkFQWVIyUWFEbTIzb20xeVdCYUw4d2Zp?=
 =?utf-8?B?VUZqSVh0aDRtVW5HQ2pIcGswWWowRXRFaE5FL2g2Ym5TeE1CSGl0a3l3NlFm?=
 =?utf-8?B?bkFRcHV1YThyMmI4ekozSCtWa1l2Q1Bia2JINCsxOElsTCtVL25Xd3NqSlhy?=
 =?utf-8?B?V3BaMnAwd3BEd0xXNEdsZFFlS1c5MjRnUVpqUnpNYjI3c1A4STd5QzZHQmRl?=
 =?utf-8?B?Q29SNXBCcDB2eHhpTmQwYlpTSXM2Q05QZTNSZXhZTWlWSG9zU0d5K0ZjWkFx?=
 =?utf-8?B?NWRzbjRvRkV0VTl6QUk0VU5GN0tIZy9iaFg2ZXpZWnJ4YUxQMGpwM0szejBt?=
 =?utf-8?B?cit6UVY3SXVCc0RlV0YraG5yWGtsVHBwTXJac3B3RjRDYmUrclJnN21mQno3?=
 =?utf-8?B?SnRzV2tzdjBrOWI2V0VRMS9hM0VEMmVrZmJwT3l6NHRmNVE2OERrWnB2T0xo?=
 =?utf-8?B?c1diNytmdnJPeElFd2NFUnJVSWVyMnMrV0E4RExYYnl0Q1E0clVaWEsrYWRs?=
 =?utf-8?B?WFNEZEhnY2ZGUFp6VWl2VGpsRzBCNEE5UWZZc2FFUzlJZzVESDlOL2J4amVh?=
 =?utf-8?B?b3RRU3BYdkJuaEVqYlE3cUVva2ZuSHNDa3o0VmJ0cnlKQmZPYkxuZFo3L3hZ?=
 =?utf-8?B?QjhFTUlySFpnc3lZNzVDYWFHd0QxMjFxblg1RzkzU1hkMDhrZERkb2hYVVZR?=
 =?utf-8?B?Y0g1eXo0U2QyNElrVllxREdMMWhjTjBBZlRaQXJGdHgrSlBJNGdxbEF6RjBH?=
 =?utf-8?B?SUloNXRaaUdyMGRrMk1sNzFLU1N6Sk93b3JtK1RnYUNlWm1vRmU4QlNRZERl?=
 =?utf-8?B?QmVOV0Y0OS93Qk4wc1l6blEyc3ZXaG9tZDg1WDlCNDB2cFpWYlFVMjBkQVV2?=
 =?utf-8?B?cmMvaEs2aVQyRGxaZG5QSFJobkVSVmw4Q21IMXVEeUcvaGFIc0l6MFRxbnNv?=
 =?utf-8?B?cHhmWTgwRCtqUFdjL0VIMzJPV1I4bkpUdGd2YlVOazhlTHBDSVdwcy8rN0Vs?=
 =?utf-8?B?ck1yZnlnRENyMXJjZWJOUE5qWTdwQU5DdVorOVRWQmNDWEN1QlFjQXJXUlBh?=
 =?utf-8?B?Y0krdGUwclNPcG5TOGg4SnA4c0UxSTBuSnBvZlVPK3pGYUM2QjFVNEwrd1lj?=
 =?utf-8?B?dk9TeGt6WGFCdDRxaUFUUFI3clJYeWNsY0VmZkhQWURIYjR5VTc5N3pmcHpY?=
 =?utf-8?B?VFQzNDVOQ1V4S3hLR2RIdG1zVzhBRDVKM3gvbXFIN1lFQVhRQWk3QnZpdnln?=
 =?utf-8?B?d2ppdW4rRk8xaUozVUR1MlZKMy96dnpmYkxYM3FLZWJoQU9UbVJ5R2FKUUM4?=
 =?utf-8?B?WjBYVzRnaWpraUxwZjZENnpMYXJ3QjYzdktqclR6UHhpemJhQ1ljOFF0aUVX?=
 =?utf-8?B?TlpiLzFXYy9DVGlvcjVRbEpVSzZRbHNUNUJpVW5IK3pMNEVYMFQrVUhpb2NK?=
 =?utf-8?B?dHJVeWlmeHo3dW4vVSsvNGtnM1lndzYwRDhuajgzZUxCOWRzZzVuZXVJZ1Az?=
 =?utf-8?B?SklxRHVXVVN1QmNNRnMvWXlTNE44czNlYTJ0YlVDbmZYZGdYV0R0S3QwSCtD?=
 =?utf-8?B?N3MyZzFqRS91ckZyRC90YnBneGFKNkwydnoxcWFFRjRMOS9YQVpSVTJoMEh1?=
 =?utf-8?B?WUI0b2dEY2M3dE04WWRYUTIwMXhQK2R0OFJvMjNzemNkTkh2QjU5VGl4c2JY?=
 =?utf-8?B?RmtxcFE5bG1mVVM4QS9pSnhEb0Zyb1UzYXZFbzlHWW9vQ1R1Y3h4KzZkbnRO?=
 =?utf-8?B?dVVRVnFVZnBtZ1htYzQ0c2V5Y0dsSWRaUitFTkxoWEYrR0NrNGlTalZqYnBJ?=
 =?utf-8?B?VGRsbXAxNFpiQjlDaXN0dTlkWXN4QkZvM1NwU3lWeHpSSnRLbUh4T3R2SmJq?=
 =?utf-8?Q?yFw0xF9mJqboECTyOjMjj6qcT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13be2490-cc1f-403c-9815-08dd69d726df
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2025 06:51:34.9327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8fYNJkDXanljdGN4FHuNiNz5jnqrC5LR3cRxX97XO9cCkQDIgiE7gM5dZfWg/p1fkXDafYU5tVgUpeA8/nNO+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8250

On 3/22/25 23:23, Bert Karwatzki wrote:
> The problem occurs in this part of ttm_tt_populate(), in the nokaslr case
> the loop is entered and repeatedly run because ttm_dma32_pages allocated exceeds
> the ttm_dma32_pages_limit which leads to lots of calls to ttm_global_swapout().
> 
> if (!strcmp(get_current()->comm, "stellaris"))
> 	printk(KERN_INFO "%s: ttm_pages_allocated=0x%llx ttm_pages_limit=0x%lx ttm_dma32_pages_allocated=0x%llx ttm_dma32_pages_limit=0x%lx\n",
> 			__func__, ttm_pages_allocated.counter, ttm_pages_limit, ttm_dma32_pages_allocated.counter, ttm_dma32_pages_limit);
> while (atomic_long_read(&ttm_pages_allocated) > ttm_pages_limit ||
>        atomic_long_read(&ttm_dma32_pages_allocated) >
>        ttm_dma32_pages_limit) {
> 
> 	if (!strcmp(get_current()->comm, "stellaris"))
> 	printk(KERN_INFO "%s: count=%d ttm_pages_allocated=0x%llx ttm_pages_limit=0x%lx ttm_dma32_pages_allocated=0x%llx ttm_dma32_pages_limit=0x%lx\n",
> 			__func__, count++, ttm_pages_allocated.counter, ttm_pages_limit, ttm_dma32_pages_allocated.counter, ttm_dma32_pages_limit);
> 	ret = ttm_global_swapout(ctx, GFP_KERNEL);
> 	if (ret == 0)
> 		break;
> 	if (ret < 0)
> 		goto error;
> }
> 
> In the case without nokaslr on the number of ttm_dma32_pages_allocated is 0 because
> use_dma32 == false in this case.
> 
> So why is use_dma32 enabled with nokaslr? Some more printk()s give this result:
> 
> The GPUs:
> built-in:
> 08:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Cezanne [Radeon Vega Series / Radeon Vega Mobile Series] (rev c5)
> discrete:
> 03:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi 23 [Radeon RX 6600/6600 XT/6600M] (rev c3)
> 
> With nokaslr:
> [    1.266517] [    T328] dma_addressing_limited: mask = 0xfffffffffff bus_dma_limit = 0x0 required_mask = 0xfffffffff
> [    1.266519] [    T328] dma_addressing_limited: ops = 0000000000000000 use_dma_iommu(dev) = 0
> [    1.266520] [    T328] dma_direct_all_ram_mapped: returning true
> [    1.266521] [    T328] dma_addressing_limited: returning ret = 0
> [    1.266521] [    T328] amdgpu 0000:03:00.0: amdgpu: amdgpu_ttm_init: calling ttm_device_init() with use_dma32 = 0
> [    1.266525] [    T328] entering ttm_device_init, use_dma32 = 0
> [    1.267115] [    T328] entering ttm_pool_init, use_dma32 = 0
> 
> [    3.965669] [    T328] dma_addressing_limited: mask = 0xfffffffffff bus_dma_limit = 0x0 required_mask = 0x3fffffffffff
> [    3.965671] [    T328] dma_addressing_limited: returning true
> [    3.965672] [    T328] amdgpu 0000:08:00.0: amdgpu: amdgpu_ttm_init: calling ttm_device_init() with use_dma32 = 1
> [    3.965674] [    T328] entering ttm_device_init, use_dma32 = 1
> [    3.965747] [    T328] entering ttm_pool_init, use_dma32 = 1
> 
> Without nokaslr:
> [    1.300907] [    T351] dma_addressing_limited: mask = 0xfffffffffff bus_dma_limit = 0x0 required_mask = 0xfffffffff
> [    1.300909] [    T351] dma_addressing_limited: ops = 0000000000000000 use_dma_iommu(dev) = 0
> [    1.300910] [    T351] dma_direct_all_ram_mapped: returning true
> [    1.300910] [    T351] dma_addressing_limited: returning ret = 0
> [    1.300911] [    T351] amdgpu 0000:03:00.0: amdgpu: amdgpu_ttm_init: calling ttm_device_init() with use_dma32 = 0
> [    1.300915] [    T351] entering ttm_device_init, use_dma32 = 0
> [    1.301210] [    T351] entering ttm_pool_init, use_dma32 = 0
> 
> [    4.000602] [    T351] dma_addressing_limited: mask = 0xfffffffffff bus_dma_limit = 0x0 required_mask = 0xfffffffffff
> [    4.000603] [    T351] dma_addressing_limited: ops = 0000000000000000 use_dma_iommu(dev) = 0
> [    4.000604] [    T351] dma_direct_all_ram_mapped: returning true
> [    4.000605] [    T351] dma_addressing_limited: returning ret = 0
> [    4.000606] [    T351] amdgpu 0000:08:00.0: amdgpu: amdgpu_ttm_init: calling ttm_device_init() with use_dma32 = 0
> [    4.000610] [    T351] entering ttm_device_init, use_dma32 = 0
> [    4.000687] [    T351] entering ttm_pool_init, use_dma32 = 0
> 
> So with nokaslr the reuqired mask for the built-in GPU changes from 0xfffffffffff
> to 0x3fffffffffff which causes dma_addressing_limited to return true which causes
> the ttm_device init to be called with use_dma32 = true.

Thanks, this is really the root cause, from what I understand.

>  It also show that for the discreate GPU nothing changes so the bug does not occur
> there.
> 
> I also was able to work around the bug by calling ttm_device_init() with use_dma32=false
> from amdgpu_ttm_init()  (drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c) but I'm not sure if this
> has unwanted side effects.
> 
> int amdgpu_ttm_init(struct amdgpu_device *adev)
> {
> 	uint64_t gtt_size;
> 	int r;
> 
> 	mutex_init(&adev->mman.gtt_window_lock);
> 
> 	dma_set_max_seg_size(adev->dev, UINT_MAX);
> 	/* No others user of address space so set it to 0 */
> 	dev_info(adev->dev, "%s: calling ttm_device_init() with use_dma32 = 0 ignoring %d\n", __func__, dma_addressing_limited(adev->dev));
> 	r = ttm_device_init(&adev->mman.bdev, &amdgpu_bo_driver, adev->dev,
> 			       adev_to_drm(adev)->anon_inode->i_mapping,
> 			       adev_to_drm(adev)->vma_offset_manager,
> 			       adev->need_swiotlb,
> 			       false /* use_dma32 */);
> 	if (r) {
> 		DRM_ERROR("failed initializing buffer object driver(%d).\n", r);
> 		return r;
> 	}
> 

I think this brings us really close, instead of forcing use_dma32 to false, I wonder if we need something like

uin64_t dma_bits = fls64(dma_get_mask(adev->dev));

to ttm_device_init, pass the last argument (use_dma32) as dma_bits < 32?


Thanks,
Balbir Singh



