Return-Path: <linux-kernel+bounces-371869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FEC9A4192
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C740287DB5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2738200CB1;
	Fri, 18 Oct 2024 14:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YLNKtnf/"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA061200C81
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729262908; cv=fail; b=Tw3SLzjMTLLBDWOMBUZPeqlK+v5JO/ARj+sOSPMtP8XEzFQeZSLsPSjnUSgNj+pf5LG1zb8+2tTtC6i5lVXEkt70ZhLkOfqiHAwL5hQaPrMvMe5dl1NT6mfE9yCnQnWbHvePgcwz2hvC+IczWBtxXNTJabTRdqLaBJggHWfC3sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729262908; c=relaxed/simple;
	bh=mE+Cy0N4DtHgW9nWI9cvX9FsSCuSbituXJ1WEtY4sBQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pRnAIgxPUDqpzf5H5oPUYs04D8lez0SKRDCRQqq52V7sQDzw+hn5nYPJaesfvExM26B1F/CuvrhxjBNWsaFCFPfd64HA1cMa0Xhn1BfqMDSm/jjI1nb4hdS8wU3oRoI8CF7hnTdoHAEHadWEXfudbPVN7OhrN4Fg4kyMRLBgA9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YLNKtnf/; arc=fail smtp.client-ip=40.107.102.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VRFzv9zQgn/F51phEb/NPvLi3qvmvt/PAIC53vttu+zq/RNY6YckqJKEBxtwhiBnaAsdCBOcRcSl7iUDYZ5WY7F9AjvBifEZWxGrONpMmLM29/II0IXjhiCvOwXI5P/yelTqbHIrOsl6jorm0PpW2fknl1XUQGtzYxgkg+niBrk3OLRSZeIqnLy707ke61YQm6zhB9++PwLsRHzBLfgVc1qHbghCoJc6DTTSoUXQoJi8N+y5Nwfvrlds0d0SxhyFmoJS6Kssz1oYIdet9DfJfcXIdu9/X5uSoYnGbIPBggyk+sf+FlQgIac2ILxQq439Th1M56pE/ggOLSyMJ3rUsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GfhQt6o3tBYWjzNbXlfnUqlGaVF4TWHrsChZfCx908=;
 b=r4o4KSXRmCQGRMssnnwOOAdpnnKOONnKN+ef4QPG6ja9FNRJbxrxDt7/Gosh9wcJQJCnd68zmZyiDk6jkz+ZkfLQaHPPR/JKnolTNBs7EJ3DDwxAfWUn3VJvPSd67xCRGIndqhIw0XRHUrGplwU+zQI8I+M9Z5vudqmcYjUaP6/RK+r4+fmjafLCKi7Av2pftiakXhfSVKr7M9uh/jNIYP6L/D74JpT23la9WDoWchVIbqoetAJ4rseQYOjU2+IlR8VTLYnI48MKZvfR6wv/DCQKebSBxellieZy9ShGKMPYRIOcZ7fibZYQ9RO7RUkwtPFJPqlpytGRXiF2G06UwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GfhQt6o3tBYWjzNbXlfnUqlGaVF4TWHrsChZfCx908=;
 b=YLNKtnf/hZBCwIakIgyFkQJFtrwS6o+f8+JnXDsvfNt1wMurqq0HAUanOVGdp+72hglBchhKXCG/ge8yZ/lOeYvctmrHVy52t4yb5G8ZBPN8snX5eFqF8eJDIVZSKpZM0zqenlD2QWzBbOJXdCRHBRTC3mfLvmHH8UjFJrPoAa0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by SN7PR12MB7346.namprd12.prod.outlook.com (2603:10b6:806:299::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Fri, 18 Oct
 2024 14:48:22 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8069.024; Fri, 18 Oct 2024
 14:48:22 +0000
Message-ID: <af41d8ff-d5ff-5480-2730-af043014fcbd@amd.com>
Date: Fri, 18 Oct 2024 09:48:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 8/8] x86/sev/docs: Document the SNP Reverse Map Table
 (RMP)
Content-Language: en-US
To: "Nikunj A. Dadhania" <nikunj@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1727709735.git.thomas.lendacky@amd.com>
 <de767f29c86b201fa0f778e2cb786f971c155f6e.1727709735.git.thomas.lendacky@amd.com>
 <fcb5b40e-cc5b-2782-dd03-8001f59f4409@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <fcb5b40e-cc5b-2782-dd03-8001f59f4409@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0042.namprd16.prod.outlook.com
 (2603:10b6:805:ca::19) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|SN7PR12MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: d4af9a4d-1174-46f9-8cd2-08dcef83ea09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3VnajlMN01nWm1NeFZmK3ppbWZjZ2JTQ2pzWDN4UWJUR250Sm5PZ0lhNElj?=
 =?utf-8?B?ZzNCSnp3Um9PdmpBcGdmQUJ2cW9rWEpCZkduUElpTTRLaUdicnZXMVhsYmxj?=
 =?utf-8?B?Q05LNHVYMjEzQVJpT0w0bzVEQ0QwU28zY0o2aThQb0lOZnlyWTEzS294SlNq?=
 =?utf-8?B?OEVzL29HdlA1WGtSamZaaUkrOW8yNW90Q3dHYUwxUVUvR3N3cENkSFhtQ0wr?=
 =?utf-8?B?aGJQc1ZCT0FnMmRremorc01OaGhjb3dxcWtpTFkyRU5QVGlPVzNSOGhFL3Jh?=
 =?utf-8?B?cjg3a0lPVDNMQjVyREFXOGFyTjdCd0s3N2ZVRk91NHN1cTV6bkNBcUQ0L2Fh?=
 =?utf-8?B?VWNDR1pKR0xBbmREYWJ3U1V5MlJZU2dPclhjK1JNKytiTVVJWnM3bmYyZk1T?=
 =?utf-8?B?bG1YQVFWRFFLRGJPSnNTQW1qN3lXOXdJNTMxekc1eGhJOW9OQVI5N1l3cWxP?=
 =?utf-8?B?R2FLZEhuZmVvckxMU3BSbHRzengxYktaYXZheVBHcXgrRVBwMEh4d1BCUllC?=
 =?utf-8?B?SWlEcFRES0ExSTR2d0Jpbm1IWjhScHJ0NHY4bkkwbDQ1N0ZyR3Q4aXRCU1R0?=
 =?utf-8?B?Ly9VbVZxam1yK3luWW9Ib2xFWFJXSk9nMzFwRTZla3NNMEpJeVZKRFRIWm43?=
 =?utf-8?B?UllNWlRGUjFGUTNCOWh5VlRsMWRXcnBlNFVkVUxoNFpRWVRrRWI2ckozZGth?=
 =?utf-8?B?VStrUXc3VTRkZXdzeTZwQzhYcTlHNWNUWFJCbXhYV2UwVG9tT0pqUnRlamxQ?=
 =?utf-8?B?UHkxN1pac2k1QXZBSWxZdzN5aVlOc1FTa2xOQmJRUUtMRTBMWm5qNk1VSit3?=
 =?utf-8?B?dnc3TGp6YjBsaENXbUpDOXpRcld0QnNmSWlPWGc0ODBBbFAxbEFsNlZPZTMv?=
 =?utf-8?B?WWtwRkJMSU9WazFUbjNTZVBBTWUzaG1QNitKNXRveFZaWTVWbllMT0tIcm1M?=
 =?utf-8?B?OTJpckFXTkJlMWNBeEMrQmdSMmoxL0F3dG9aZlgxV0ViVStteUNzVktOQ1JD?=
 =?utf-8?B?ZFRyODlNRVg2T3VNdFVtamF2UEtvWi9WbFRZTlhMR2wwTHNlVWF1SmUvZ3Iv?=
 =?utf-8?B?L0luUUpWVjZWTkRYVU8zTXMvaWxuQ04xL0xBelg4VHAyMnRNRFFITzllZ1Qx?=
 =?utf-8?B?MVVPVkg4dmlLR0pZcWdoamd2K1dOeWNxSEZ0WlV5THplYlhGT04wRVZRdGd5?=
 =?utf-8?B?QUlmT2ozUitjeGVaVk1pekpLcHFzNkpXRHBRQ20zUXV4STBZOHRDSU5EK2or?=
 =?utf-8?B?M3NlVXpFNWVIOW1KTGk3aDlIQTViZC9PQzdtdnJtSHBwREQ0UC9xckNQUlMv?=
 =?utf-8?B?dDZFQndPMXFKVVJya0tidUhNMkpkbC93ZGd1L3FSTHR0NmsyMWZ6QnFVbEFO?=
 =?utf-8?B?Tk5rNVZ6TzZtaUxoY3pUR01OdWdXaEg2T2cvNTdDV2lxUzRuMDVtUGhzN1JE?=
 =?utf-8?B?SVpPUU9OQThXUko4bzJYYy8zUGxvZG9kZGtqQnpJNks1VHFLdGJtZExCNGE1?=
 =?utf-8?B?VWxZZlU4UVQyN01ZRHN3ZlpIZlNXMjRTa0MrMUlia3paSjdKMFlkamRWRVlB?=
 =?utf-8?B?NE94OE5yV045SU1iRFF3aDQ1K1Erb1RpcWZNaTJnYk14cHBSb05xdXhGVTRN?=
 =?utf-8?B?YXlITU93eGtYNzlyMzRqeG95RDBmUlhtOW5QTm5ici8yUmt0SkpUTkZMTCtv?=
 =?utf-8?B?N0NaL2ZlZEY0RVVueEh3QnpNS2tMaHZXS3hJZkxIOGlhdmJTWHZUdWMwNmlv?=
 =?utf-8?Q?v2Q0OG5vpG7HKSP/hDmlAyG5IwBqPK5JS1L43rv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFRyUExWMnc1Q3JJSGNqTlpOeTVmSDZ1NUs3U2l6NTdiVGxwMDR2UkVBeVhQ?=
 =?utf-8?B?RnpWTmJjSnUrcDAxNEl4bjRXL1E0UnQrbDJYaFoyVE9LTERCYlloR3NmcEk1?=
 =?utf-8?B?L2JjQTlvOU5jSEJRT29mRml0cVhQekF5dzRBdEdFUXNRelpUcDVTVVdic3R3?=
 =?utf-8?B?RUV5TGNKeE9UZEZkc21nN1k2QVZCM3JTTS9wK25NZXAxT1dXQzlFQnJJcVhq?=
 =?utf-8?B?bWJkYVVOZkppU21WZFpTVzM2cXNTaUtJRVZxK0FiakVwb3V2UGF6NWcyR3dN?=
 =?utf-8?B?TldZTm41N0hBbmVOQXRiZ21zOWZ2QmczdFhKaXBBUXhSY1A1bXRjeVpIS0tK?=
 =?utf-8?B?RXEwc1VYM1paNEZyL0RJTytZdFI1NkpVWXZNK3JManJJMUdlM3NUMi9IemN2?=
 =?utf-8?B?YzZIbFBOaHd2aEtLVStwSnhVKzZPU3RzZk40dUk3blBNb3pEOE1zZlFrT3BL?=
 =?utf-8?B?Z0E1b3NGbTcrNXFOdStnT2xsOU5sV1pOS0c0dDl4TXRqRnl1Qno4QUU0Sk1r?=
 =?utf-8?B?RGNmRnFCcUdQOTZUWGt5bnNtaXorSjFxNmVhUWhhNTNlK0FseEFweWpibXlV?=
 =?utf-8?B?WEZNSFVsYkZxVGpDcGY3ZzlRaDJKekl0NWdyd3ovQWxhUEhoaitlTGxXRUNH?=
 =?utf-8?B?ZTBHOTFwK20rVGRjNEt6M2d1bWZmK2NFZllNL3JheTlZc1VGOHkyVXhTMmkr?=
 =?utf-8?B?QXRTdG9pSDlqRU1ZZWVVUFFZVFBYa2w1UW9CaVJ4czVtSk5QbkM5WkR6ekFx?=
 =?utf-8?B?VGNsb2hMeFpiN281d2tMZVlhd1dKOVNKd05rcmdFb1VNTnUvSCtjRHdnblpj?=
 =?utf-8?B?THlzSVZMeHhHYmlmZ25iZzdONGtJRGlteldUYXJvTmppTzBCaElmYlBHam9j?=
 =?utf-8?B?MHpJOFNXRmlWSWJldDZWanM2aFhtZE9lU084RWlSSGk0ME14M1UzNXhLNUhw?=
 =?utf-8?B?N3lYQTgzbVVvR29XakplNW03QW0yMXR5U2s5ZlBacDJweXkxTEh4ekx6R3RV?=
 =?utf-8?B?NW5JN3hJTVVwYytYWDZGSEJ4VDIvWDRaS1l3UnpsVlhQU2hIVUN0TW9qVERv?=
 =?utf-8?B?SHZMMzVVdzhORDFCa05meGhsYjAwUThhRGhLNTZQM01NOXJrS01KVlkwUmxU?=
 =?utf-8?B?K0cvQ0xjaDNZL3JJWjZuUXNuN1R1bjJ5TS8xY0V1YzBaaXN0OXh6ZVRMeklI?=
 =?utf-8?B?ak11ckthOXdKdTlTUHJXMFo4Z0IyYnNxVTBnZmY1eHI3QmdUT0RhNmxzWnhO?=
 =?utf-8?B?Wm1GUVhUSzBwWVFDeHpNVTZiRVFHSG5GazRKVW9yaWlEZjkva3g1bnl4d013?=
 =?utf-8?B?cUwzTUNjZWFmc3NoeERXTEIwb1pUNktDRXNkSWdrQ2MzWi9xUVhtWDV5Z1Fy?=
 =?utf-8?B?QzUzZjdLaXdFaTJpaTU0aGJBM0FuV211Y0VwcE9VelQzL21VRG9aSGRveE1W?=
 =?utf-8?B?SkZINXE3MFV4cnhic2dwNHYweDMzV1lKZStzaFlMek1QeEw4RHhidmZYV3BR?=
 =?utf-8?B?TXlQSXAwN2N2ZXNjVjBGMTIvM3Y3MVNobVRjMndEMTdDUDJVclplZDNWWUUz?=
 =?utf-8?B?ejgxWE5RajlPODBUNHhoUS9TWlp3QmtIVm14MmtlM3hsNkwyME1UMk5vNkV6?=
 =?utf-8?B?ZFpHSlIrbjhoV1poYllXKzJ5WG9YS2cyeFd1VGoxZ3NYckEwK1IxUDJJYkIz?=
 =?utf-8?B?L0dMdlpnUi8rK1A2NGVZTGY5bXNZWnlCeUc3MDdNQmQremhWVmcxRUdTWWYv?=
 =?utf-8?B?K3VOVjBUQzVPZDdZOVFJbE9YYzVkYm9KdDRua0FXSkpMRGVWMTYrNXpNQXpM?=
 =?utf-8?B?QTdCSkw1UDB3bklobjhoZjZIaUNEQjhUUnIwNkRSVkZ1cHlrYW5zVlUwRUYz?=
 =?utf-8?B?WXAyUHB0SXI0a2U0anVDT0xxOGtMbGY0a2NIQWJVb2VYUFhQcFN6UllseTlM?=
 =?utf-8?B?cno2VjRQcHdVWHJGdGMrcGRqUWRkcUphSkpMYThXQkNraU1wUWZGUkhXZUlF?=
 =?utf-8?B?Vks0QXNjVmlTNWZwNU9lRy9Ec1hYUWh4Z21DUVROM1JVTSt4N3kzMnovVHUy?=
 =?utf-8?B?RzN1MFZ5R3ZQeTNNTXVVc2xGYmphZ0Y5WVQ0YTBXZFNHajlpdVU2SGNqQ2h4?=
 =?utf-8?Q?HpXnKDhIE0WwG3WV60adIy5vH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4af9a4d-1174-46f9-8cd2-08dcef83ea09
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 14:48:22.7562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GibRZ63Ejrj7Th5L6Z5l8k8qk1ghlFAhs0nT8id4qJ6NYKRqoH2YnPSMRviaMnPoGfEKUv42SacwGQwR3rircA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7346

On 10/18/24 01:56, Nikunj A. Dadhania wrote:
> On 9/30/2024 8:52 PM, Tom Lendacky wrote:
>> Update the AMD memory encryption documentation to include information on
>> the Reverse Map Table (RMP) and the two table formats.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>  .../arch/x86/amd-memory-encryption.rst        | 118 ++++++++++++++++++
>>  1 file changed, 118 insertions(+)
>>
>> diff --git a/Documentation/arch/x86/amd-memory-encryption.rst b/Documentation/arch/x86/amd-memory-encryption.rst
>> index 6df3264f23b9..bd840df708ea 100644
>> --- a/Documentation/arch/x86/amd-memory-encryption.rst
>> +++ b/Documentation/arch/x86/amd-memory-encryption.rst
>> @@ -130,8 +130,126 @@ SNP feature support.
>>  
>>  More details in AMD64 APM[1] Vol 2: 15.34.10 SEV_STATUS MSR
>>  
>> +Reverse Map Table (RMP)
>> +=======================
>> +
>> +The RMP is a structure in system memory that is used to ensure a one-to-one
>> +mapping between system physical addresses and guest physical addresses. Each
>> +page of memory that is potentially assignable to guests has one entry within
>> +the RMP.
>> +
>> +The RMP table can be either contiguous in memory or a collection of segments
>> +in memory.
>> +
>> +Contiguous RMP
>> +--------------
>> +
>> +Support for this form of the RMP is present when support for SEV-SNP is
>> +present, which can be determined using the CPUID instruction::
>> +
>> +	0x8000001f[eax]:
>> +		Bit[4] indicates support for SEV-SNP
>> +
>> +The location of the RMP is identified to the hardware through two MSRs::
>> +
>> +        0xc0010132 (RMP_BASE):
>> +                System physical address of the first byte of the RMP
>> +
>> +        0xc0010133 (RMP_END):
>> +                System physical address of the last byte of the RMP
>> +
>> +Hardware requires that RMP_BASE and (RPM_END + 1) be 8KB aligned, but SEV
>> +firmware increases the alignment requirement to require a 1MB alignment.
>> +
>> +The RMP consists of a 16KB region used for processor bookkeeping followed
>> +by the RMP entries, which are 16 bytes in size. The size of the RMP
>> +determines the range of physical memory that the hypervisor can assign to
>> +SEV-SNP guests. The RMP covers the system physical address from::
>> +
>> +        0 to ((RMP_END + 1 - RMP_BASE - 16KB) / 16B) x 4KB.
>> +
>> +The current Linux support relies on BIOS to allocate/reserve the memory for
>> +the RMP and to set RMP_BASE and RMP_END appropriately. Linux uses the MSR
>> +values to locate the RMP and determine the size of the RMP. The RMP must
>> +cover all of system memory in order for Linux to enable SEV-SNP.
>> +
>> +Segmented RMP
>> +-------------
>> +
>> +Segmented RMP support is a new way of representing the layout of an RMP.
>> +Initial RMP support required the RMP table to be contiguous in memory.
>> +RMP accesses from a NUMA node on which the RMP doesn't reside
>> +can take longer than accesses from a NUMA node on which the RMP resides.
>> +Segmented RMP support allows the RMP entries to be located on the same
>> +node as the memory the RMP is covering, potentially reducing latency
>> +associated with accessing an RMP entry associated with the memory. Each
>> +RMP segment covers a specific range of system physical addresses.
>> +
>> +Support for this form of the RMP can be determined using the CPUID
>> +instruction::
>> +
>> +        0x8000001f[eax]:
>> +                Bit[23] indicates support for segmented RMP
>> +
>> +If supported, segmented RMP attributes can be found using the CPUID
>> +instruction::
>> +
>> +        0x80000025[eax]:
>> +                Bits[5:0]  minimum supported RMP segment size
>> +                Bits[11:6] maximum supported RMP segment size
>> +
>> +        0x80000025[ebx]:
>> +                Bits[9:0]  number of cacheable RMP segment definitions
>> +                Bit[10]    indicates if the number of cacheable RMP segments
>> +                           is a hard limit
>> +
>> +To enable a segmented RMP, a new MSR is available::
> 
> This may be more appropriate:
> 
> To discover segmented RMP support, a new MSR is available::

Not really. You discover the ability to use segmented RMP (and the
availability of the MSR) through CPUID and then enable it through the MSR.
It's just that Linux relies on BIOS to set everything up and then we look
at the MSR to see if BIOS built a segmented RMP (I allude to that a few
paragraphs below).

Thanks,
Tom

> 
>> +
>> +        0xc0010136 (RMP_CFG):
>> +                Bit[0]     indicates if segmented RMP is enabled
>> +                Bits[13:8] contains the size of memory covered by an RMP
>> +                           segment (expressed as a power of 2)
>> +
>> +The RMP segment size defined in the RMP_CFG MSR applies to all segments
>> +of the RMP. Therefore each RMP segment covers a specific range of system
>> +physical addresses. For example, if the RMP_CFG MSR value is 0x2401, then
>> +the RMP segment coverage value is 0x24 => 36, meaning the size of memory
>> +covered by an RMP segment is 64GB (1 << 36). So the first RMP segment
>> +covers physical addresses from 0 to 0xF_FFFF_FFFF, the second RMP segment
>> +covers physical addresses from 0x10_0000_0000 to 0x1F_FFFF_FFFF, etc.
>> +
>> +When a segmented RMP is enabled, RMP_BASE points to the RMP bookkeeping
>> +area as it does today (16K in size). However, instead of RMP entries
>> +beginning immediately after the bookkeeping area, there is a 4K RMP
>> +segment table (RST). Each entry in the RST is 8-bytes in size and represents
>> +an RMP segment::
>> +
>> +        Bits[19:0]  mapped size (in GB)
>> +                    The mapped size can be less than the defined segment size.
>> +                    A value of zero, indicates that no RMP exists for the range
>> +                    of system physical addresses associated with this segment.
>> +        Bits[51:20] segment physical address
>> +                    This address is left shift 20-bits (or just masked when
>> +                    read) to form the physical address of the segment (1MB
>> +                    alignment).
>> +
>> +The RST can hold 512 segment entries but can be limited in size to the number
>> +of cacheable RMP segments (CPUID 0x80000025_EBX[9:0]) if the number of cacheable
>> +RMP segments is a hard limit (CPUID 0x80000025_EBX[10]).
>> +
>> +The current Linux support relies on BIOS to allocate/reserve the memory for
>> +the segmented RMP (the bookkeeping area, RST, and all segments), build the RST
>> +and to set RMP_BASE, RMP_END, and RMP_CFG appropriately. Linux uses the MSR
>> +values to locate the RMP and determine the size and location of the RMP
>> +segments. The RMP must cover all of system memory in order for Linux to enable
>> +SEV-SNP.
>> +
>> +More details in the AMD64 APM Vol 2, section "15.36.3 Reverse Map Table",
>> +docID: 24593.
>> +
>>  Secure VM Service Module (SVSM)
>>  ===============================
>> +
>>  SNP provides a feature called Virtual Machine Privilege Levels (VMPL) which
>>  defines four privilege levels at which guest software can run. The most
>>  privileged level is 0 and numerically higher numbers have lesser privileges.
> 

