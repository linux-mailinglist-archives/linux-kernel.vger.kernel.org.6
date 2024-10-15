Return-Path: <linux-kernel+bounces-365174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B7599DE92
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F774282819
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 06:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61723189F56;
	Tue, 15 Oct 2024 06:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="9GT9u1tD"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2102.outbound.protection.outlook.com [40.107.220.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74C117335E;
	Tue, 15 Oct 2024 06:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728974380; cv=fail; b=d70OUl9FT906RLVbVj5y7v+bTUK0gz7m4AlmxopTt3yf4xoH7CXigPFLetv2melvUbVotntIW3TrBbH7AB192nlDKcMW1ZWb195pysYz4GW/g9Yr3foqsF/Y3ZAHBMVI2TJLMQ0MP8FX82ArE0sadc1stI4kFCzd99swNeIvIHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728974380; c=relaxed/simple;
	bh=m/gqwy7wU3IftN0PJupXQ9P7Yy99J/8/wophO1GGgeU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BrUmEhqb8dgSq6z/6Plw1BdGvN2HRM6bJXcdcqzpoKiBQqKOJ1TVlgb31sc2GdwXmdQrJ8BY+p0H3r0EdHtKvoIZeKfX82r+LQdRDBlRH+1UEtZs4TX61j2cdRPyl6ySzqtvzNQ74zF8ltmZA632tQIfwg5n7+7fl/Xf6+6wDI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=9GT9u1tD reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.220.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDnUfwvWCa1WlmYZmG5nrzuyxOdJ/1GHO6o048fl1uUNeDLSdLkAiwRX7ym8JLmJhGmWZ7DILJ44KAk4GqhEq/pOAECqgLTj3LyEcQu5bI0oAbPldCDRqRwq8TkF3FBdr9o0sGazEWUBNybAL9tcXbqHcEigXHWluXzx7eJRh0GtlgCkMNBlH3pOCYACNoy2vFvg64N8htni8/rkAM05mT5frSAnYnQly6SK2oC+6gk9EUqFdgk9BkqX882eeJy2X4pvxeCTvq+M6ukT8Q3o/zUePW8e9vIUxQ2iMPT1AIcQZZ70VvTjPcAOrfI4ei4OHtIR2LxGqq0wNzd8PbN+1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rTFlNEtgI76ExkkBHWq0bouL70KkEFKVqrchbxvZJk=;
 b=u+EHytmbbzhjyNK+U/uUzVDEZlh/WmI3I2GVt5rXN2nHdUGMSoirnLWcNvbu0eRNbp7rjCFBsbKfjcGBZ/Nq1s7S5sVkepK0B2niFdIaF1OCPIBXXsG1ZujC/Wl01IyRer3XMW31e+PyEPKimYN5EtJr0W83eZ2/DgL/WzmFdxYeC6w9mwNATFi5iAlHsmOv5UB7+oVAm0D6Of3RuQo7SjaxdTueKVcuRImJ4ERn29ZjaxfmsDS/KsL7lfg3idqQHrvvJ1AWGRfwKEB0yMraI6dyp4WN/OuPUl+dKXVlqVEByRCCjtKDyjcpMq1Unb+Q+cVso25tdn7UoQKoP/cQnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rTFlNEtgI76ExkkBHWq0bouL70KkEFKVqrchbxvZJk=;
 b=9GT9u1tDGtv9kYmxdLsSJ+DRBNg+rfw9pPsCIRyYbKpoQiggCF59rTb6uVfj8Oq7UG+Yczqessoup/I8KDpIWdPKsdZuNVan2y1+z3IUy1EvKfDlq/ixXE+6yW12fr1F0MAG8dpBBYdq6J6pNN/aLXoQh+J2CYL6Y74Khsj2GXw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BL3PR01MB7057.prod.exchangelabs.com (2603:10b6:208:35c::16) by
 SA6PR01MB8732.prod.exchangelabs.com (2603:10b6:806:40a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.21; Tue, 15 Oct 2024 06:39:35 +0000
Received: from BL3PR01MB7057.prod.exchangelabs.com
 ([fe80::b69e:5684:ed7c:4d09]) by BL3PR01MB7057.prod.exchangelabs.com
 ([fe80::b69e:5684:ed7c:4d09%4]) with mapi id 15.20.7982.033; Tue, 15 Oct 2024
 06:39:34 +0000
Message-ID: <e8e31fb4-4a9f-4ea9-be4d-9ba29d824cc5@amperemail.onmicrosoft.com>
Date: Tue, 15 Oct 2024 13:39:23 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: aspeed: Add device tree for Ampere's Mt.
 Jefferson BMC
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
 Chanh Nguyen <chanh@os.amperecomputing.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, Joel Stanley <joel@jms.id.au>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Khanh Pham <khpham@amperecomputing.com>,
 linux-arm-kernel@lists.infradead.org,
 Thang Nguyen <thang@os.amperecomputing.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Phong Vo <phong@os.amperecomputing.com>, Conor Dooley <conor+dt@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, OpenBMC Maillist
 <openbmc@lists.ozlabs.org>,
 Open Source Submission <patches@amperecomputing.com>,
 Quan Nguyen <quan@os.amperecomputing.com>, linux-aspeed@lists.ozlabs.org
References: <20241014105031.1963079-1-chanh@os.amperecomputing.com>
 <172891445289.1127319.4114892374425336022.robh@kernel.org>
 <b5919d904c9f06a618a54d49bc895c3081a511e4.camel@codeconstruct.com.au>
Content-Language: en-US
From: Chanh Nguyen <chanh@amperemail.onmicrosoft.com>
In-Reply-To: <b5919d904c9f06a618a54d49bc895c3081a511e4.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CYXP220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:930:ee::7) To BL3PR01MB7057.prod.exchangelabs.com
 (2603:10b6:208:35c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR01MB7057:EE_|SA6PR01MB8732:EE_
X-MS-Office365-Filtering-Correlation-Id: f335bdfd-c4a6-4a49-3dd2-08dcece421f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXRRT0lGRDB6ZDdjK3BJeUtqa2hTZnZsNTMxK040QmIzb29uYmdHNTFHNTN2?=
 =?utf-8?B?eW5LYnpSQXBNMFBMWUsxRlplcllqMi8yU1RIcWJNd05RWVIyejYzemhqNFd4?=
 =?utf-8?B?Nk5iZFQ4dkVGN2dlYjR1dGJNdWFlK2tlWGlOalA3WXVnR00ydXBFeGRHWlNP?=
 =?utf-8?B?NVhQanExa1Y5dXBsdWJ1cGpQZVVkWC9iWDhGVlhrbGJHUDgxdDJCS3dqWFRt?=
 =?utf-8?B?d3J4WU5KWmFnQjE1RXl1OEpUczJ1YXlWTXp4eGZ2cXBOc3NpUTFuaFhSR1F1?=
 =?utf-8?B?bEJ4N0tzU2ZuTFZmVUZ5UFRKUHdDUThIb1dCMGFGcmM2bDVmbHFKTyt1L0FM?=
 =?utf-8?B?d2dwNUtqQkRSR2tyakdNOXQyRUtKd0xFSnNZdFVtOUZ3ZWxEZHk5SFBmdUow?=
 =?utf-8?B?Wk1BNS80ZlVyUmdwZzhENmc1R3g2c053eXFhTDdWRWxEWG9XZVVOV1lSakJG?=
 =?utf-8?B?cEdWMGU0OU5EemZ4cnYrR25RcFdzRUs1bWVHQWJXQ1JFQmlQOXgwSldoL3kz?=
 =?utf-8?B?MFdYYzBMTVJxcHF0Nkpabzc2RTBac0VwcXlFUTZDZ05OLzAzRUtIZU5MNHhR?=
 =?utf-8?B?Q05udzZYNEZJTDFYS3YrRGJDNHJrcHNaKzkyRWY5M0p4NzJScFZCYnptSnVY?=
 =?utf-8?B?aVh2dWZCbzNTT1ZmNjUwaXVhcmtYOG9QM1JsQ3BuUDBOUXBsOEZXdTREQXlw?=
 =?utf-8?B?MnhITXBndnE3ZmNmbHcyTnloSk00Y1M5NlB2dXRwaWhuRE9KcEQwelJkdWR4?=
 =?utf-8?B?MkZQK0NLMTFmY3NWOVlHOGtSQlJhcm5RSFNFWE43V08xWVhlM1hxdndsUnQ3?=
 =?utf-8?B?ZEliSWk0U3VmanNUaHcxR3F3MEFhZDJERGRaN095WHEvd2U3akR0ZC9ySkR3?=
 =?utf-8?B?VVVPaXdEUkFjaE1DTXN2eUdsb0wzd2Zic3JTamUwblJ0bkVNYlhpOVc1dlhk?=
 =?utf-8?B?R3NhZ2dENkxHVmNoRk5nNFdqdVk4dFZyK0RMVTQ5MDIxQmRnbXVvZE9hc1J4?=
 =?utf-8?B?MkVKWmErODN0aE9Uc2JuUzdSd0g5WlpuaVVpMDBUMTkxT0lzVWNDTzFaT1JH?=
 =?utf-8?B?NWtseU5IZkM2bzFNQjVGRmY1ck5rVGkvYkxHRTVrMldrYTgrWEU0ZzRtdHRB?=
 =?utf-8?B?U05BZVNreGU4VFV4TjB0eTVyYnk0Z1B4NkI2dDRPa08zNEdZaS91T3dGd2tR?=
 =?utf-8?B?T0g2SVViVkZrWWUwSkJWVXlxdEFmMFNzSTl6L01GNTBzWS9zcFJLL1Z6Umxx?=
 =?utf-8?B?eTdrMEQ2TzdzRytjOERibzFCeFVQZ3Y0SFVoc2ZmTmJweU1kcGRETlRRSC9Y?=
 =?utf-8?B?TW9XMnRSR0pxUFVucE5XdThGK1ZZRzBCYWg3SHRIZCtnZjFtN0lYODlJZmQy?=
 =?utf-8?B?U2NFdWx0eG1ObWN5ZXU2QjBTRXRHbGs1Vy9ORjhJVjNCcnlHN2hwVnlWK3Rq?=
 =?utf-8?B?emhITkdSVFhNbnhlS2VKT1Nxa29mbi9GTEppOVhKK3BodXhSR3Q3bzBXK0pl?=
 =?utf-8?B?cUtnMGRTajZBOVdwMWF2cHNuUG5aeWFkVU1oelhHajFHZ05zT1FYbVVYaGhS?=
 =?utf-8?B?WTNKN1ZRUjNTOVVCWXY3ZFhjekUrVWZtMkdkU1ArVlFDc1pZZE8zSUJLRzJ1?=
 =?utf-8?Q?lyR8cM2AnIuvJnXjJWLja56wxWoeM+qXcsH3pxY3bWmY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR01MB7057.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHJGNkVDaCtEUnNRQ0o5WHdCd0ZGY3lVdlp3UDNySklqSndWRmNhZFZ0cXBI?=
 =?utf-8?B?NjJ2QmNoeTQxbzQ5bUZxcE9PNjZON2VjRlJCakdNR2ZrSE4wM3VqMDZ5bVh3?=
 =?utf-8?B?eDJQOEZjZDBLUHV2UXFGN3BrN3RYQXpUdkx5R1NvU3FVVDBKalV1ME1lZklM?=
 =?utf-8?B?L3E5cStNWHNCb2JxUFNURGwzWHozNm1kYzE1b1pKdGYwY2VLdktTT1BZSGZP?=
 =?utf-8?B?bEtvMGFkSDBKUDF0cnJyLzM1TkFIVklvWExpOW41SmRCUXFlcUNJVE9HZ3pE?=
 =?utf-8?B?eHFFSnlhemlWTDZzMHdVS2V0Sk11cWdGeUZoWm51M1RiM2RiS0R0QmZrNGJQ?=
 =?utf-8?B?S1ZJUDdBWFZuUG9JMEZpMkI1UDVlTHZpUERYQVhqcmxpQWNTcmpwc0Z4SEQz?=
 =?utf-8?B?Nk9uZldjUEw4NUFSV3dJVndtZ2dLcDRmbFlyRyt4Z2xUTGZYdWxJam9MYm4w?=
 =?utf-8?B?M3hrNDREZlBMdE01ZlIzZ09BYktUZXR0N28vWkpUcTcraHlScjBCT1NJODM2?=
 =?utf-8?B?bWFjRHhJV0NOUHpsTld5Rk1DWGdobFZPeTk4a2pLU2V2Zm1SbDl5WXp4TmVB?=
 =?utf-8?B?elZGMXRKVERRVklKaFp1TDV5Mm9yQVdTVDg5TVArbHZBbjJKaU96YUwxd1Bh?=
 =?utf-8?B?aEdxcTBvSDlBQkUzOFBRL1BUeCtkTFZzc2g1THdrR3hvNExrODhUMlhUOHF3?=
 =?utf-8?B?Mmo5UzJZN1NYQ1JQOFlMNnJmMGpOZlFKcFBVQ0JhL05NbERLU2hPVTlmT0FT?=
 =?utf-8?B?aHZwelk5MmlUWjh5WElzMXlEQSt2R3YvUmJzcEg4bWw3U21FMUR5aW5sSzhU?=
 =?utf-8?B?UGNCY2pRUVMvUzBzTzFhZXBzS0FwZGRjRmw2aE1hZ2c0aExZQlFOYkxvbHdk?=
 =?utf-8?B?ekVNV1plWWh1SEdRQ1lWcXdsUnd2cDJLdUZ0OWNMM2FSbnFHNjR1VnVLbFNR?=
 =?utf-8?B?aWZJT1kycmN5SnlBMWl4ck8wNTNlbnBCeHJYUTJuSU8vRXNVNEFmdEtiS1Zz?=
 =?utf-8?B?bThvRU5WangwdkE4SnBiZXlQdGJTQW5XS3BzV1F5OFhiODJIYXM0bE85OVNx?=
 =?utf-8?B?OHlONmlKTXJPZk5uSHdXVFg4aDF5YUU4dDh3QnJRNWZRVDBtd1VndFByM0V2?=
 =?utf-8?B?MnpsdXJRcEFVbUVFUTV1SHQxQzhrUE9wUnFMTWpjRzZ0V3lsb29RaElwb3hp?=
 =?utf-8?B?dVpmOHhmNGhQdlhEamg1NUgzNlRRQURRU2NnaDg0akk3QnpUeitXdmVnNjMw?=
 =?utf-8?B?NEF3V1c0ak51LzZ5WXhramxSNFJRaGp5aDlBeU5WSUg4Y2hEdW9ReXh3Uk1I?=
 =?utf-8?B?VkxOUG1FNmFXVVZuMUlpQWEzcXRBcWRQSFIyZDNheTJqei9XeGFqVmFLZzQ3?=
 =?utf-8?B?cGg3UllEMFBMZklyZHJXSzJEMGRmVFNzTkJXcVNTSHRGS3dpdis0cFdpNWJi?=
 =?utf-8?B?ck9nbEZ5ZFVQa0ZSU1h0UURoc3lQUlQycXZTTitaTnFmN3FsaXJuSWtwUEx4?=
 =?utf-8?B?bXNQS29saDJwRWxDYVBNcm1US2xDV3JZQm5iS1o4eHlyTzBUUjI1bHF0UXJj?=
 =?utf-8?B?V0xJT2M1blFpT2Z2eEJPNkF0ajkxd1hBNkhoWFhTUU1sRE52VE9xdW5HTXZZ?=
 =?utf-8?B?Q0dRam15TVo0QUNqcmNiaWpsRndqYngwU3FSS3BIaFhYUU5iS2N6b21oTDRr?=
 =?utf-8?B?clRHcjdIaFRMQytlU0Q4MVc5MXJoZU9LRHZqOGdzcUJQNEdqbWdhRkwxTmI4?=
 =?utf-8?B?MWZucUpLK3dxZFlhYkk0TXROWXFSZ2YzaEMzdjAzTmRadml6dS9pOTFIWCsz?=
 =?utf-8?B?R0ErVHNaVHE2WGpxUWtJSi9sSTdPeWlhakJ0bG12YjhZZWk3YXUxdDJKenVO?=
 =?utf-8?B?WFR3THR4bStjYkxKeHFVdFBJeGJIZE1tbnJUYWZPVEVTcyt5aVZBN09IRTR6?=
 =?utf-8?B?QnpqQlZtcFdUdS9sdUUybzBnbWtVZmM2UTNzTEdiT0tUQUhMcGcvbDNyQkFJ?=
 =?utf-8?B?WWRkcThMYzM3SWNLVXFmd1hRbWNGNENmZWJkZnc2WEwvL1ovRDVtMWFacEV0?=
 =?utf-8?B?RnAxdDNjZ2NEOHJIa0RMeHpzODJhNXp0ckh4aGM3TVVvbklXaDZGK0I2K0R4?=
 =?utf-8?B?dGVoYm1vMlpNd0txNyt1bWlqVHhkRDErRit3MmJzODZvc0Q1YlBESjhaaElz?=
 =?utf-8?Q?yUuAOzUOZNfvNji7cfDz5kQ=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f335bdfd-c4a6-4a49-3dd2-08dcece421f5
X-MS-Exchange-CrossTenant-AuthSource: BL3PR01MB7057.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 06:39:34.8351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HD/4TNfpqp/xQYKkMJ/jNR3vGFKVSK9K1gAd/AN6UV/GEtah3dBbnQa0CWM4MP2r3MlJ+ThFWLwuDIRizMmaoPaimPlTnPqw6PEfjgYFs8opiDeG1KEM+smTzIApa6YP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR01MB8732



On 15/10/2024 07:44, Andrew Jeffery wrote:
> Hi Chanh,
> 
> On Mon, 2024-10-14 at 09:05 -0500, Rob Herring (Arm) wrote:
>> On Mon, 14 Oct 2024 10:50:31 +0000, Chanh Nguyen wrote:
>>> The Mt. Jefferson BMC is an ASPEED AST2600-based BMC for the Mt. Jefferson
>>> hardware reference platform with AmpereOne(TM)M processor.
>>>
>>> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
>>> ---
>>>   arch/arm/boot/dts/aspeed/Makefile             |   1 +
>>>   .../aspeed/aspeed-bmc-ampere-mtjefferson.dts  | 646 ++++++++++++++++++
>>>   2 files changed, 647 insertions(+)
>>>   create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dts
>>>
>>
>>
>> My bot found new DTB warnings on the .dts files added or changed in this
>> series.
>>
>> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
>> are fixed by another series. Ultimately, it is up to the platform
>> maintainer whether these warnings are acceptable or not. No need to reply
>> unless the platform maintainer has comments.
>>
>> If you already ran DT checks and didn't see these error(s), then
>> make sure dt-schema is up to date:
>>
>>    pip3 install dtschema --upgrade
>>
>>
>> New warnings running 'make CHECK_DTBS=y aspeed/aspeed-bmc-ampere-mtjefferson.dtb' for 20241014105031.1963079-1-chanh@os.amperecomputing.com:
>>
>> arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: /: compatible: 'oneOf' conditional failed, one must be fixed:
>> 	'ampere,mtjefferson-bmc' is not one of ['delta,ahe50dc-bmc', 'facebook,galaxy100-bmc', 'facebook,wedge100-bmc', 'facebook,wedge40-bmc', 'microsoft,olympus-bmc', 'quanta,q71l-bmc', 'tyan,palmetto-bmc', 'yadro,vesnin-bmc']
>> 	'ampere,mtjefferson-bmc' is not one of ['amd,daytonax-bmc', 'amd,ethanolx-bmc', 'ampere,mtjade-bmc', 'aspeed,ast2500-evb', 'asrock,e3c246d4i-bmc', 'asrock,e3c256d4i-bmc', 'asrock,romed8hm3-bmc', 'asrock,spc621d8hm3-bmc', 'asrock,x570d4u-bmc', 'bytedance,g220a-bmc', 'facebook,cmm-bmc', 'facebook,minipack-bmc', 'facebook,tiogapass-bmc', 'facebook,yamp-bmc', 'facebook,yosemitev2-bmc', 'facebook,wedge400-bmc', 'hxt,stardragon4800-rep2-bmc', 'ibm,mihawk-bmc', 'ibm,mowgli-bmc', 'ibm,romulus-bmc', 'ibm,swift-bmc', 'ibm,witherspoon-bmc', 'ingrasys,zaius-bmc', 'inspur,fp5280g2-bmc', 'inspur,nf5280m6-bmc', 'inspur,on5263m5-bmc', 'intel,s2600wf-bmc', 'inventec,lanyang-bmc', 'lenovo,hr630-bmc', 'lenovo,hr855xg2-bmc', 'portwell,neptune-bmc', 'qcom,centriq2400-rep-bmc', 'supermicro,x11spi-bmc', 'tyan,s7106-bmc', 'tyan,s8036-bmc', 'yadro,nicole-bmc', 'yadro,vegman-n110-bmc', 'yadro,vegman-rx20-bmc', 'yadro,vegman-sx20-bmc']
>> 	'ampere,mtjefferson-bmc' is not one of ['ampere,mtmitchell-bmc', 'aspeed,ast2600-evb', 'aspeed,ast2600-evb-a1', 'asus,x4tf-bmc', 'facebook,bletchley-bmc', 'facebook,catalina-bmc', 'facebook,cloudripper-bmc', 'facebook,elbert-bmc', 'facebook,fuji-bmc', 'facebook,greatlakes-bmc', 'facebook,harma-bmc', 'facebook,minerva-cmc', 'facebook,yosemite4-bmc', 'ibm,blueridge-bmc', 'ibm,everest-bmc', 'ibm,fuji-bmc', 'ibm,rainier-bmc', 'ibm,system1-bmc', 'ibm,tacoma-bmc', 'inventec,starscream-bmc', 'inventec,transformer-bmc', 'jabil,rbp-bmc', 'qcom,dc-scm-v1-bmc', 'quanta,s6q-bmc', 'ufispace,ncplite-bmc']
>> 	'aspeed,ast2400' was expected
>> 	'aspeed,ast2500' was expected
>> 	from schema $id: http://devicetree.org/schemas/arm/aspeed/aspeed.yaml#
>>
> 
> This needs to be fixed as pointed out by Krzysztof.
> 

Thank Andrew, I'll update that in patch v2

> *snip*
> 
>> arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: /ahb/apb/bus@1e78a000/i2c@180/i2c-mux@70/i2c@0/psu@58: failed to match any schema with compatible: ['pmbus']
>> arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: /ahb/apb/bus@1e78a000/i2c@180/i2c-mux@70/i2c@0/psu@59: failed to match any schema with compatible: ['pmbus']
> 
> These two should also be fixed. The compatible must describe the
> physical device, not the communication/application protocol. It may be
> necessary to add a binding if there's not one already for the device.
> 

Hi Andrew, My device is following the pmbus specification. So I'm using 
the generic pmbus driver 
(https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/hwmon/pmbus/pmbus.c#n237) 
to probe my device. In arch/arm/boot/dts/aspeed/ directory, many boards 
are also using this compatible to probe our devices.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr855xg2.dts#n219
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-transformers.dts#n263
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm/boot/dts/aspeed/aspeed-bmc-tyan-s8036.dts#n260

Andrew, Recently I saw the ASPEED platform's maintainer accept the 
"pmbus" compatible with a warning log. You can see in the below list 
that patches were merged recently.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=bb3776e564d2190db0ef45609e66f13c60ce5b48
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=28cfb03afcb20a841e96e821ba20870a7c437034
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=36d96827f480e90037d162098061333e279ea35f

Regards,
Chanh Ng


> Andrew
> 


