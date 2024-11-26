Return-Path: <linux-kernel+bounces-422673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A569D9CC0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DDE4164704
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0E61DB37A;
	Tue, 26 Nov 2024 17:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="gPgD4uNK"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2128.outbound.protection.outlook.com [40.107.101.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5492780C02
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 17:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732642908; cv=fail; b=dlLBIOYIR6SBnHOvNiRVPrrrKDiEwH1jVaFAQQzIg3c8ku6pvxh3k/sWpjxdof+uVE9TUQe6EW4asOnFAmJ5ZKlOIlsE0GM0mFoXpSTP6SdPwNSKxw1rEzLuoIFHFtGehjmRClGLIWdPgKGIlvGe6CnfUmR2M4h3sbRQ5ZWiN3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732642908; c=relaxed/simple;
	bh=FhRpaxs9Uq4xmyA7jHe4ACBnU1UorO38kRU86WokrEc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ebuqZ2nngEe08DPP7IL4+qs+cIdNiue7Zelfx4H9P8b6254skqPRGvkE9mfxqsW9WGsoyZ7eqba0CXPTo1V7z6IVHUjgKEre8sNeZlrB4mdKdRXT0m5uEy99lOYEPGEJJofeGoRgqg6VZ9oCv8zHHkk1PXTi3a9yVj268tB3sOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=gPgD4uNK; arc=fail smtp.client-ip=40.107.101.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kOF4ynrN/peMKrVNsz9xKC1umUKt7o3RQ20rJCLrMK5ZETIblXZTeDpB4PEJE0mXNZw5lZ32bY1SaRzt5dj/b7+fqBGGsyBdqriKDkA4qHnpl1H2QipuAjiZu/VotqSHhQv6LPpV3e2ukvZ9bB8Vpadp/K9n/TsGp84mhvQcwGtxfzl18p9j0CyJtlrmfFPn0iSp0CO+HnB2k35vTWDUCyLzKF5BknAgJMdqv5J+fhyhQ5YT9jBlD/V4h3gmFrv2SzrRhuPAvJklCXYVWuPZTR1BnLG/lhum5MpzckDe/TmVX86iN3ktRu64u6Np/f/T3kb8WVVdMRG+UW/svBV4MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Goij2g9ivNAMS5lO7f8MeLp+a52pguRD4fcgPxXi4q0=;
 b=s629VENZrWE8eRZmouSgnkKVegvdoET473raWH2iZIvxAoJCYgQDiEopMFMfW7g2GKqXPnP94j5EYZnAx2iPaeD5QhGnlstdYgrj58DOm8Z8oSKNvaRvyphvnxx9i6TQSKB2knWGOa0v+QLlnQh0NGKCFo0gssgdTGgP/wNNdIprbu05YkRM2B/nWrVIyjaayegTxzxd8kl/dVEKYJFeGTFfnKr1Xiz9RZDUtzjqsEHuh/9ViQ7x7uwpLjms7X8O9gLiZqPCW+nP8O33KqsOy7gMNvMocj+VCRw/RvoV4fd/mDYyfc4Asq6a+of7izJDCPNxBo0kG05IqRH7NPuwvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Goij2g9ivNAMS5lO7f8MeLp+a52pguRD4fcgPxXi4q0=;
 b=gPgD4uNKEh/EnEUwob7WxUR0dvn8/88RhYr42aTov12zoudVt3fRmQeOfNTmWqqVoI9+F0IhLflU1BPW53U0JjBmOJXGXrREncpXLs4CkUHQrudnHr85Z7V3UUwrMwkEE+lA7mRyOYJZf1W5QSH/N2CgY5UJGN4fAsTXGhI06pM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SA3PR01MB7907.prod.exchangelabs.com (2603:10b6:806:319::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.11; Tue, 26 Nov 2024 17:41:43 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.8207.010; Tue, 26 Nov 2024
 17:41:43 +0000
Message-ID: <0c09425b-c8ba-4ed6-b429-0bce4e7d00e9@os.amperecomputing.com>
Date: Tue, 26 Nov 2024 09:41:39 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] arm64 updates for 6.13-rc1
To: Catalin Marinas <catalin.marinas@arm.com>, Sasha Levin <sashal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
References: <20241118100623.2674026-1-catalin.marinas@arm.com>
 <Z0STR6VLt2MCalnY@sashalap> <Z0TLhc3uxa5RnK64@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <Z0TLhc3uxa5RnK64@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::11) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SA3PR01MB7907:EE_
X-MS-Office365-Filtering-Correlation-Id: 7af3fe43-3e30-48a4-abdf-08dd0e419743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkMwM01KdXpFV0NSN3hEYng3S2J0aEVoS3huOVphbW40NFhWVllPUk9nSmsx?=
 =?utf-8?B?SVY2LzJKOHR3eHp1L0s1a0hyVmhoT2k3YUZRUzIvRjdqS1BsVEdIZzRad282?=
 =?utf-8?B?T2RmMDhDeVRLUDlnY094NHhDTkxsR3dYc3ZnVWFSaXlaTTdiV3pNOThramRJ?=
 =?utf-8?B?NjIxZURmdUZqTzY3dnFoUzdSTnpjOHZxWTdvZG1LRTJLalBtdS9NVnlCSGRr?=
 =?utf-8?B?ZGNLeTlxd0xIY2Zzb2JML2VUblFZVGNkdDhONDhESTUxcGR0RmVnQmgrcHEr?=
 =?utf-8?B?ZjB0bW1iTTR3N2JTeGNYdEZiY2d6Y29zT2t2bGhRQ1dGWDhrUWo4OUp6TUV4?=
 =?utf-8?B?Zi9GelVFSFVCNWxDK3QwYXVUSGdvRE1aZGt1Mjg1VnFMSVZRejIva0pWNkVG?=
 =?utf-8?B?TEw0VVhsaWQxeXo3TFBMTHBWV2hoWk1RMDYvNHk5RTJPZGc0WHZCdTgzR1BS?=
 =?utf-8?B?U0Z2dTBwUHBoYm1iRGZJZDBFZk9MaExhY0ErcWREVnBJczduUmxkWnVZN0dQ?=
 =?utf-8?B?U1BodUtLQmlaVVRZRHRkckZpdzEwSmE5emEvdXZ6N1V1RFp4MUphWTg3MWVn?=
 =?utf-8?B?aHQ4VE81a0FiY0U4ellNbWxTQS9GbHVaU25KaG1BMUZCM0pobjZ2N0t5QVNo?=
 =?utf-8?B?QUVndk96L0FkYXRRUCt4eGNOd1hzK1JWL2s4aDlqREt6emhjZ09hRGYvQUo2?=
 =?utf-8?B?UTU1bGEzZm9lSVphM2l4ditxSktLelUwbHFycHc3WXppRmE1VzlHMEtaZHVN?=
 =?utf-8?B?Z0tJc01ERGQ5Szg2Wmhlcjc0Q0h5dmN5ZXBFUXBDYm9OSndvdGVMVXN2RlRr?=
 =?utf-8?B?WG1LTldSeWl4OG9BY0pGZ0praml6SkI0c1FHcTVQUkVOTUZ0RzdDVjhHc3lj?=
 =?utf-8?B?STVRaTBnTnJHbmJYWm5PVGh5cmpGRnFuUWFaa3NPdzUrMlJLRDlIcGh6YkxX?=
 =?utf-8?B?L2N1NjkzcHd6Q0ZxaFZRdzJVOWdON2NjUW1yblZIT0YveE5iTVBQd0tGdlM1?=
 =?utf-8?B?YnJPVXZaR2ROWjJaZHBXL0dTNGhLRTRoMUMyTUNpWXhHQVppNnQ3UnVEOGUw?=
 =?utf-8?B?MitlVzlPZnpHNDhHZmhtcE5DVXc5SytsdzJZZ3VGaVFPekJqbFE2cHRZdVVj?=
 =?utf-8?B?ekd0RVdITzBHOUVmc1hYZjA2TDhBRHVCUHFKSHNQZWg4VG9LU3RqWDkxUHZi?=
 =?utf-8?B?aE8rT2FrWWlNMUJWWkJIQnlzS1gwU0lQYkhibG5KSzNuRi90d0tqRmNFVnpy?=
 =?utf-8?B?UHg4ejhPOUlnb0JhaXBhMkxQeXNFVC8wU2I5WkNLOVp6aWRSeGFMSVZpaERi?=
 =?utf-8?B?UUUvNGtvWVM5UUMvNElkOStUc0M4S1NVSU95cHQzcU84SUtXcnlETVUvazcw?=
 =?utf-8?B?V3BGREZGeTZVdE4rZmxhNUUyQTBxZGNOYWZIK1I3QzFoLzRoQXRFK1FxTzBI?=
 =?utf-8?B?U1BpRmtXcU0xbTZ1aEQxT29XUHQyZSsxbU01S2dVZDFnT3JrRmJlMUNrZStW?=
 =?utf-8?B?SCtGV2hHTnU3WmkrYzZ2U2xiZVN6ZFhkVVk3c214NVRLL2pyWFR5VlE4V0Ju?=
 =?utf-8?B?cm5pM1FoeUZiOWJ6WForZVd1Vno4WkdYQTU2Q040RGNzaTM2NVQ1NGdUTWlx?=
 =?utf-8?B?Y1hBYU9Ybi95VXR6MEJwZ0E3a2FkelcvWlFBbUFOVzFwMC8wODk4blNqM1VU?=
 =?utf-8?B?QVMxYkl2UVBwN0tpcDBZaHVVT2l5TGdYTG5uTkVyZllZMFZaT0tFcFNqQVdt?=
 =?utf-8?B?RTF1YjZsY0ZuNm95S1RscUppa0RXMnFjbk5vY1M2RWZNQ0RZSXpkS3MwQjdV?=
 =?utf-8?B?aHVYYlBnL3U4RGU2TzluUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUNTNDU5alBEZGw0SzBkd2M0OHpWcnNXNFVOcDVrQWVrM25udnVOa0YwWmpx?=
 =?utf-8?B?Q3QxVHMwd1laTjVHR08xbjN3MTRlakdRU1BmWVlJY1Q0TkpHWWRRWTE5UUJX?=
 =?utf-8?B?K2JhaEU3YjRyNU5BSXB1eTJJbDlJZktmemlQQytmcUJnVWxRMHp0ZzlGU3Nl?=
 =?utf-8?B?SWU2VUZEY2ZxeHVGekZWWWxBMFhRSGlPb0lHMitkUWFvSkZ2WTNZM2wvV0Q2?=
 =?utf-8?B?TW5hd2hvZVFjN1F4RE1xVUozdy9OdGJtc21MZ3BPYlFscEpnWjd6QlVvS3By?=
 =?utf-8?B?U3hmTmZGTU44WDBIME1JUk1YeDhKazZzZmdqWVY0YWc2WURoU0cxR3gvTWR0?=
 =?utf-8?B?ZEl2dGVjMCtLMGlmS09pK0FzTVViUTF4T0twbkE1ZXlwUWt3Q0ZZeHVDNmtr?=
 =?utf-8?B?SUhteXcwYzJUeStQSDR2Q002bGVTUVRqd1JCU093ZjVIdU84SGk3akM5WmVE?=
 =?utf-8?B?cTdvSlpSS1pORzd5WFpZL1I1RGZyNnp0SDU5RGxuKzllT0RQVHBwM3J3N2JQ?=
 =?utf-8?B?Vkh4RnhiZUYyWC9obTgrVmVCN1ZnVk1YOEVOY2kzR0wxTjI4eWptY1N5M21r?=
 =?utf-8?B?cklTTGlJWURVUmxkUVU4ODlaRE1FNjM4Y3FuQlNyYUNabTNoUmJPS1pzeFVL?=
 =?utf-8?B?UTN3UXYwY001S3dTaUU5TEFnM1VQM1IwTHRIRFBwaFczUWM4YjArOGFlVFFG?=
 =?utf-8?B?a1V4TFlGUlpXWWgvWTZSWXdzaTBTb3FPc0h2UFYzcnFuY1I2Q1hTUklCL1ZM?=
 =?utf-8?B?YTZDOC9wdG9yT0hycFN6aTMwcWcydHU4Z3BhcTdZREpCeEFObGoxbHRaRVY1?=
 =?utf-8?B?ZW5xdWdMaE5wM2ZDbk13WnVBMnd1TnF6eUZiV3VDc0syVXRvWG9EWkN5TmZJ?=
 =?utf-8?B?ei91WGhaNG9raTIxYzE3U3V5Y1ZDRWU0NEZvOENyd3VlRFh2M1RVc2RsRy9M?=
 =?utf-8?B?emx1eE1vQ2h0QWpUdFBSR0pxV3pxN1dHeE9XbmNQa0c1N2NNaWdDeHJ1Y2J6?=
 =?utf-8?B?VlNOZkVLRERpTFVpNS91RE82WWY1SmdrbExmd2w3UFNZa2gwcE1mcTk0STAr?=
 =?utf-8?B?aVlmTDFhM04rOGd3RmZzc09xWUs3Zm51blppMjFvSkk2RVFBYzZhSTBkcHZ1?=
 =?utf-8?B?NmUva09rUmJueVVIM1dtSGFoTUw0VnJSSFViTVlEaGR5SXgrSEZEcXh4WlNo?=
 =?utf-8?B?Qk9pSGNzZ2srcG9uTXkvL2xjbDJDMVhtQ1dlb0g1Y2JuUXFjZ1p2Z2ZveFJB?=
 =?utf-8?B?QUZoT1ZEMFlFM2lUcnZUcjZUVnBlTE9yQWt2YUU3ZzQzNHppem91TXc4NHlP?=
 =?utf-8?B?ZjBGZjdlSjFKUjRQcldCV0VwYnE1VzlaNzlDazVxUGhGejVoSU12d0JyNkta?=
 =?utf-8?B?eFFhTUdnY0JwUkxzTFNpV1IyMGVnaVdOanpBdERyNXpnZ0ZNOFJOeGhRbW4v?=
 =?utf-8?B?aTcxZTBHS1dUdENmMzdmZzA5dG00R0NyQ0hZeGJ2WXgvNFZ0MUtBMGNBQVVt?=
 =?utf-8?B?L3dOQ0VadTh4T3ZSSW5kRzk3eXJpQWx6SWFtdExZb1JRK3p1Wk9ad29YejBp?=
 =?utf-8?B?TE5MRXVod1IyT0xIekI1OHBTZm5FblhwQW4wL3FMYkVyTEt0NGc5Qkd2QXBz?=
 =?utf-8?B?QTFwNGt0d29lOVBwaFd1dis1M3dZUW1DS3J5WjZ0a2dyQkRJOWlTNlZxTHZD?=
 =?utf-8?B?Z1YzQ2tSSG1zUjhJZVUxSkl3YzdlMmR2cXo3akpLNU9XYzJ6RE1BYnVZcFZO?=
 =?utf-8?B?OHYwcTR3elY2WGdScEl2bldqRVh2ZCtPcXNRMmRWSytMbXErOVJkSWUxRzJP?=
 =?utf-8?B?ODhGU1JGd0dVNEk0Nm55K3ZBY0FnaWpObU5nTlBMS2JEOHVDM2o2R1BhU0o0?=
 =?utf-8?B?Z2ExQm9BcEZzcUp0eTlyOVFHa3hqTnVFMUIvZGJKVkVTdFV1dTZMbnRscFFZ?=
 =?utf-8?B?a3JSNEJ1QVRMN0l5Q3lQWGVGajVKSmR3N1Z3Ry80dkJiUmJYclJncEcybDdr?=
 =?utf-8?B?RFNZNDRaUHVTQWsxR1VHQkJUaU1iVkZZZHVTN1lxYkFDRnpiaUQ2S3pxWHZM?=
 =?utf-8?B?R0NlNUJPNmgyd3MwaG01L1cwOHZaVW0xWU9YMDBMVGM3VkttY1pnaTBzV1pX?=
 =?utf-8?B?aG1jOFgySFBMNCtkejhvdGRXaFZLUEdGMmg4dEpIMUZoWUFJOGZsVUVwbDFk?=
 =?utf-8?Q?G8g6oVqFPZwwEWnC36c5IYI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af3fe43-3e30-48a4-abdf-08dd0e419743
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 17:41:43.1499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y9M2hwyqlFpIsS8rQsZu0ntUeadfJ3aTZEx0IpVNDWdepRgXlQcOc5OKlD22MnYko9EN+YdcVyHMTc9T9812Qo6CGC2cdi/7zTUBMhdnSBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR01MB7907



On 11/25/24 11:09 AM, Catalin Marinas wrote:
> Thanks Sasha.
>
> Adding Yang Shi (he contributed the support) and David H.
>
> On Mon, Nov 25, 2024 at 10:09:59AM -0500, Sasha Levin wrote:
>> On Mon, Nov 18, 2024 at 10:06:23AM +0000, Catalin Marinas wrote:
>>>   - MTE: hugetlbfs support and the corresponding kselftests
>> Hi Catalin,
>>
>> It looks like with the new feature above, LTP manages to trigger the
>> following warning on linus-next:
>>
>> [  100.133691] hugefork01 (362): drop_caches: 3
>> tst_hugepage.c:84: TINFO: 2 hugepage(s) reserved
>> tst_tmpdir.c:316: TINFO: Using /scratch/ltp-CckaqgMrC1/LTP_hug5PSMw8 as tmpdir (ext2/ext3/ext4 filesystem)
>> tst_test.c:1085: TINFO: Mounting none to /scratch/ltp-CckaqgMrC1/LTP_hug5PSMw8/hugetlbfs fstyp=hugetlbfs flags=0
>> tst_test.c:1860: TINFO: LTP version: 20240930
>> tst_test.c:1864: TINFO: Tested kernel: 6.12.0 #1 SMP PREEMPT @1732504538 aarch64
>> tst_test.c:1703: TINFO: Timeout per run is 0h 02m 30s
>> <4>[  100.355230] ------------[ cut here ]------------
>> <4>[  100.356888] WARNING: CPU: 0 PID: 363 at arch/arm64/include/asm/mte.h:58 copy_highpage+0x1d4/0x2d8
>> <4>[  100.359160] Modules linked in: crct10dif_ce sm3_ce sm3 sha3_ce sha512_ce sha512_arm64 fuse drm backlight ip_tables x_tables
>> <4>[  100.363578] CPU: 0 UID: 0 PID: 363 Comm: hugefork01 Not tainted 6.12.0 #1
>> <4>[  100.365113] Hardware name: linux,dummy-virt (DT)
>> <4>[  100.365966] pstate: 63402009 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
>> <4>[  100.366468] pc : copy_highpage+0x1d4/0x2d8
>> <4>[  100.366780] lr : copy_highpage+0x78/0x2d8
>> <4>[  100.367090] sp : ffff80008066bb30
>> <4>[  100.368094] x29: ffff80008066bb30 x28: ffffc1ffc3118000 x27: 0000000000000000
>> <4>[  100.369341] x26: 0000000000000000 x25: 0000ffff9ce00000 x24: ffffc1ffc3118000
>> <4>[  100.370223] x23: fff00000c47ff000 x22: fff00000c4fff000 x21: ffffc1ffc3138000
>> <4>[  100.370739] x20: ffffc1ffc3138000 x19: ffffc1ffc311ffc0 x18: ffffffffffffffff
>> <4>[  100.371285] x17: 0000000000000000 x16: ffffa302fd05bcb0 x15: 0000ffff9d2fdfff
>> <4>[  100.372778] x14: 0000000000000000 x13: 1ffe00001859f161 x12: fff00000c2cf8b0c
>> <4>[  100.374124] x11: ffff80008066bd70 x10: ffffa302fe2a20d0 x9 : ffffa302fb438578
>> <4>[  100.374877] x8 : ffff80008066ba48 x7 : 0000000000000000 x6 : ffffa302fdbdf000
>> <4>[  100.376152] x5 : 0000000000000000 x4 : fff00000c2f239c0 x3 : fff00000c33e43f0
>> <4>[  100.376962] x2 : ffffc1ffc3138000 x1 : 00000000000000f4 x0 : 0000000000000000
>> <4>[  100.377964] Call trace:
>> <4>[  100.378736]  copy_highpage+0x1d4/0x2d8 (P)
>> <4>[  100.379422]  copy_highpage+0x78/0x2d8 (L)
>> <4>[  100.380272]  copy_user_highpage+0x20/0x48
>> <4>[  100.380805]  copy_user_large_folio+0x1bc/0x268
>> <4>[  100.381601]  hugetlb_wp+0x190/0x860
>> <4>[  100.382031]  hugetlb_fault+0xa28/0xc10
>> <4>[  100.382911]  handle_mm_fault+0x2a0/0x2c0
>> <4>[  100.383511]  do_page_fault+0x12c/0x578
>> <4>[  100.384913]  do_mem_abort+0x4c/0xa8
>> <4>[  100.385397]  el0_da+0x44/0xb0
>> <4>[  100.385775]  el0t_64_sync_handler+0xc4/0x138
>> <4>[  100.386243]  el0t_64_sync+0x198/0x1a0
>> <4>[  100.388759] ---[ end trace 0000000000000000 ]---
> It looks like this can trigger even if the system does not use MTE. The
> warning was introduced in commit 25c17c4b55de ("hugetlb: arm64: add mte
> support") and it's supposed to check whether page_mte_tagged() is called
> on a large folio inadvertently. But in copy_highpage(), if the source is
> a huge page and untagged, it takes the else path with the
> page_mte_tagged() check. I think something like below would do but I
> haven't tried it yet:

Hi Catalin,

Thanks for investigating this. Yes, it is. The fix looks correct to me.

>
> diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
> index 87b3f1a25535..ef303a2262c5 100644
> --- a/arch/arm64/mm/copypage.c
> +++ b/arch/arm64/mm/copypage.c
> @@ -30,9 +30,9 @@ void copy_highpage(struct page *to, struct page *from)
>   	if (!system_supports_mte())
>   		return;
>   
> -	if (folio_test_hugetlb(src) &&
> -	    folio_test_hugetlb_mte_tagged(src)) {
> -		if (!folio_try_hugetlb_mte_tagging(dst))
> +	if (folio_test_hugetlb(src)) {
> +		if (!folio_test_hugetlb_mte_tagged(src) ||
> +		    !folio_try_hugetlb_mte_tagging(dst))
>   			return;
>   
>   		/*
>


