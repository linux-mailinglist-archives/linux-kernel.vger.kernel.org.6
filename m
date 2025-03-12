Return-Path: <linux-kernel+bounces-557516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64277A5DA4A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BC721779CF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481CA23C8DE;
	Wed, 12 Mar 2025 10:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="AF7icau2"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013062.outbound.protection.outlook.com [40.107.162.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3691E7C03;
	Wed, 12 Mar 2025 10:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741774550; cv=fail; b=JBCaJtDtYsvNjopHncHUbFMJeAWx9Vs6Xw/o5loBpb+E424eo0uoAsqKhHt1khhDpOo/+UMeWzwY9qNKVZOkSDUZ/kTsNXwe4LnL6z62HWOShOGfd7yGRKfLbdKu3UVD9ZBOU3l5E+JT/npWASZ6bGvFIrihEH2EwF98TB80X+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741774550; c=relaxed/simple;
	bh=+78eiByCekgHKKnVHSZqsOdnV6sajCZln3qrtCTVVuU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O+/Iw7npZVl/PqZ5ZaEWF6AxPQCGJqlNvop9c6pwhOS9stO2xAy82Z7xCRH3icWLaK3xPlIuVBCztG9kkPI0GuPJ7wZyzW8zTOk7vWyfaU2gVmjd7VRWVUmgNXPKK3kj6Bsw85bnkfXob8zFTVmY6+xxOqZ9TQhiTi97E7LK1U0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=AF7icau2; arc=fail smtp.client-ip=40.107.162.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HMuE3kXp052e+yon0eotBtXokFyywlUjoXQr5ChRR+8ylvbrkFz49YasKo3ORJs6yaYb8asYwhAwdJ954JKUqPYQk7LCU8V5BKeZL3+CqH86MhK6LEnN9bay1T9jKXnlenfqcA/jZgy/AEz0CGInyYqc6cST1ycCaf0Sy+IbZB0tuzuMqQ/4BZ6BV4YugeRXTzE8+GTApS4xFNtUXtHCGCMtu6EUlU3STxRUhdeRpgxbB2aazk4MSn8geoGqcnjBU635PUzLE0eRiuxir0VQ5HaS4hF2Vwgcsc0CcdN/weKneGuO4SxS6NWudrc4jKIl7+vhNJK6d+RwTPFv4vC2yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERf+ymyqRiU8mcDEb2pLA8db02g8C2m6b1cNm9H2Z98=;
 b=kPZUvbvNVVNBVn7xIgXjsR78Hp5QsUKdF1QjbOql3AntNHfKyIhtVehBcecZfRNspYl+j972ZboMIQygmMmcdcrZ+oQR3Oiq7TQNyH1jyEQ+W81jjBUIeEY29IpwrR0NMQ4rGaUWQOhMQ/a0qXM6YtswdiuTnU7p38G9xuH6/Xp0rNkZh1ojbYyva6BOcqiRjZ690G+Yft+1jk29bbIiU9z2kBNSqVbWiqk8ZnEGQJ+38f8i17CIbC6Ki7lVvXxAorAgdQ7OnJ34Anoej6GRGhvJYnV/K90mYBl2IauX9hdVSyvQvXqeMNeKHhBDIY5qXzw7AnZca5KJ59PzMeK4fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERf+ymyqRiU8mcDEb2pLA8db02g8C2m6b1cNm9H2Z98=;
 b=AF7icau2ypiDtTMOuRq/6cNPcaliDtM9llGltJPpbrHW7UjsIAu8sW8xr3xxhU/7YygNx+L7cX4oPU372JMSYKTTCHlBpUeXCXf9Z2w6LlL4abwgHAPOUwgF95LPE948X7/Fjhc6m/UIU7G8Rt/t1zrro3Ot1mAXL5gCNo8FpGE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 10:15:43 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 10:15:43 +0000
Message-ID: <e55125ed-64fb-455e-b1e4-cebe2cf006e4@cherry.de>
Date: Wed, 12 Mar 2025 11:15:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/8] arm64: dts: rockchip: Add OPP data for CPU cores
 on RK3588j
To: Alexey Charkov <alchark@gmail.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Dragan Simic
 <dsimic@manjaro.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Chen-Yu Tsai <wens@kernel.org>, Diederik de Haas <didi.debian@cknow.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Kever Yang <kever.yang@rock-chips.com>
References: <20240617-rk-dts-additions-v5-0-c1f5f3267f1e@gmail.com>
 <d8ce8db2-1717-40f8-b53e-24cc71a758c9@cherry.de>
 <CABjd4Yw-r-ogfwcrph4K1wbkybS25gk6LFg8wpqLG27uWdybNA@mail.gmail.com>
 <2914631.KiezcSG77Q@diego>
 <CABjd4YxF4N1tAgGUZk-oKkMUO+Q9rWHZsas9gMQdJ+TF4A1=NA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CABjd4YxF4N1tAgGUZk-oKkMUO+Q9rWHZsas9gMQdJ+TF4A1=NA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::21) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU0PR04MB9251:EE_
X-MS-Office365-Filtering-Correlation-Id: de83757c-635e-4723-4c33-08dd614ed8d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wm1zUnVLM1lOclU2YTBNUXN3UTZZY1hkT1pjejUySGpvdUdkVzFiblFucnN5?=
 =?utf-8?B?VDE5alBKTTV2MjMrRmt2VW92cGhuYVpZQ1drUEJOMXNWN2haNlo5dXVRbmFW?=
 =?utf-8?B?VURtK3krQXlNdWxxZHc1NGMvanIzVWpBVGFWMk54dVhlVjg0ZStFd1ZTQnF1?=
 =?utf-8?B?Z1owcUF6QjMrMXdmVlFUYUhTZ1RtK2JhSFVSeW85QzRWT0w2TWUrOWpjM0JV?=
 =?utf-8?B?djJ2UGM4aWlPUXBjN1FYVWJsck8xczZHbzg4aXRYMFdqQ0lCVTNWT1J1R2dx?=
 =?utf-8?B?aVU2b1U4TkJ6MWdNYmMzZDFTU29FMEJlY0JXVUlOUVlRb0VTOVZlcVA3WFVr?=
 =?utf-8?B?SlBvTS9mTXdwRmpGbkdxUHJ4ZGNLdWk3dmNTVkY2MU50MUdWVDBHdVF3dGIr?=
 =?utf-8?B?RWtKTFZhM3F2TUlHTkVURWJlYTVLSWZzZENBWHAzWEVYVFNqcmloWTFNcjRT?=
 =?utf-8?B?dVd4SHJITDN2SGtYZUljYW5CQm4xcW9lcmEyZS83YkROS0NpWEFaVktZRUpG?=
 =?utf-8?B?WllPNjZDWTd3dks5Q1ZTYmRKek9keEZqZmlXNWUxUTNKd3BvVnVlODZSTzh0?=
 =?utf-8?B?cXlMdGVJcmlsYjBWZ21hUkdWTzN3Z1BpOXpYa095RlIzMWtzc0VZUmlTUFpv?=
 =?utf-8?B?QWtyNUl1RGs0RGllOWNLK3JYOFBBd293QVl3RXQvTjc2VXF0UkxHSzJTbkFP?=
 =?utf-8?B?SGdRRmxWbVVnREhlejhmaDJRNXI0eU1WOEtoYWUxRXl6N2lNbW1VT2lnQ3Ir?=
 =?utf-8?B?RERiek8wbzh2RGsyYUhFOFUydDBDSHJ1WWpReDdvZDQzOVI0bFcyeDhTRnV3?=
 =?utf-8?B?bHNEM2ZUQ2pWZHBPU20rR1ByaG9CcVZxOExMVHZiZ2RHOE5HM3BaWm9mdnow?=
 =?utf-8?B?Nm83RVg0R2h6TG41cFkxeTVYa2N3WHQyNVFOamFKSUpjUm1WRE41SFFUbTkr?=
 =?utf-8?B?dk5SU2NHaUt2VUFlTU1nQ09sd2cvTnpTWDNGd2xLWUxPdXo4dEd5QUJHakdH?=
 =?utf-8?B?Q3VvVmU3aTVTTTNhVjkrYTVxL2tZVEVWWWlzeEJGT2xYVWF2WWFYRmQ5WXpH?=
 =?utf-8?B?RXFDZnRycTlaUGsrZG1uWCs1V1Z6Q1g4VGQvQzBNODBablNMRnVwQ3FmOWI3?=
 =?utf-8?B?U05ENHFGaStpSXEwbW5QdWYwMkhLZTBIemJNaVFlam4wRk10bG1aQkEzeXFF?=
 =?utf-8?B?VmtldGYzQmdhOElDcXFhSXJIZHEvQkxkUjJ6K05NMUFhUEtDSWZpSGNFR0sy?=
 =?utf-8?B?ODUrQ3pyK1NEMTNmcFpzenhJOG1BNG0yR1RYTElhQ1ZYVUlmWDdzSXRzMHUr?=
 =?utf-8?B?U2hvNWExR3kzY1pwOTdWcERuUnJSeVp4MEZGQ2VqeitHaEtsd2F3MnJBOCto?=
 =?utf-8?B?NGEvVVZQQVJmVWlsckVDOFV2cEdKaHNZM01EWWI2RUVZMGZERHRPMWV3QUpR?=
 =?utf-8?B?SllsUlZQNnkxTFpJS3hnVi9oSkZQUGR3YjZURkZLR20vNUJpUUw1ODg3RDda?=
 =?utf-8?B?TzRBZnN5NklRT1ZINXlHMk1QNE51KytIcXhUYkRqU1g4YjVUSmJ0aG8vSTdp?=
 =?utf-8?B?dy9EbzVoY0hFUG55Wkpnd0Q1Y3RLRGdoZ0tRL1RlWGI4SnFUVE8waHUrb0RL?=
 =?utf-8?B?RERid3lRYjNoREQ2WnlUUkVxWVlGSDFIOTBIalpDSEJSL0NqK2NwTFFWTmVx?=
 =?utf-8?B?d3pISzYwUkJpWlhPYmIxLzdXakJ6N0NXelZ4RXBscFRkWVFMSlpUTE5QSTcw?=
 =?utf-8?B?aVNoT2lKNnczdHNpb3cycjk4WTRYUGFGSHpBMXF6ejdlNkI0ellNTllwaHha?=
 =?utf-8?B?Ynd0K3I3MTFJKzd2VjFvUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1NxYWw4R1EwejdNbHJxZ2R2Q0RjdnAzRWE5R2lSWFJqbUJaZWlpaHdZTUpP?=
 =?utf-8?B?bnVGT29UWmt1MHdaL0hObGVFM1hETkFoaWV0alZEdHJBQWMyLzQyb0V1b0Ra?=
 =?utf-8?B?OEk2cml4Y2orVEt3b2dXSDIwcVVQNUkwRmxYcFM3Y0FaMGIwN21DVVBXR29m?=
 =?utf-8?B?c0JnbDhDWUhGdkRMV1lJampwT0VhM3NMY0ZSdE9PamRaQnl5UWtlYktyS2F3?=
 =?utf-8?B?dFNGeHdOaHhuQTFsODVPaWNQR3VMRTVKaElsd2dKTGVVc3JQbFVTV05NdHI5?=
 =?utf-8?B?TlNtcDZVQXRLR2VZVTVZUEI1Ulpsd0EyMUNZakN1WEdNaWVTK2diQ0xZT2to?=
 =?utf-8?B?eTRTbHZlci9HazB5a3hyb2VLd3psamhUNDJ6OEhjQmlKME9yVHhpWlhJbDE2?=
 =?utf-8?B?RmptRjlkNDNDL3RMNXA0ZFRoWmtFRmRIbVV5Q2FiQzN5L3pHVVJ4Sk5TUWdp?=
 =?utf-8?B?QlRqcWVCZWRKK1Bwd1RDSVE4dDZyUEl6ZnpML0hXalNmMGVtVndNN2N6QkVJ?=
 =?utf-8?B?dFh4V2RaL0ZCL2xMbmwya09TRkNRRHg2L2t6b0VUbC9ITk9iZkEwSFNxM1pO?=
 =?utf-8?B?Wm02c1ZJcG9hRWp0MkEvS1NCbGg1VTV4ZldtZWhTcW9vUCtHUzJsYWRId095?=
 =?utf-8?B?ajFrc0FVQlkzSnlURVdWanNWbHE2bGgxU3Z5dGRqd29LZzgrUzNQQlRhMHFv?=
 =?utf-8?B?SHo2SGhJY1UydEY2eEh1S2NicGJWcVpaMy96OHBNNm5DNWRGQmhEOUY4M3JN?=
 =?utf-8?B?bmNDNE5HVVBxVVdSZWZCdlY4OVpDS2xZK0ZQNk5DdkkrM2U1dzRRNFR5WDI5?=
 =?utf-8?B?eFpPVy9mY2lWRDNMbllZYTVVcWxSY050TjRuS1Y4RlovNFo1MnpVTEEvRWpH?=
 =?utf-8?B?MHNsSkI3RXhBejJTTW13Y2o3L1I0TCs2NjcwOGhFVFB0QlBJNWtRM0RxS0h5?=
 =?utf-8?B?dGJwTElmdzFhekZOYUNONWZIVGZjZWZ3MmFHOCtLTXJIRUVsSTNRUnB2OVEw?=
 =?utf-8?B?REIvblRGMnRhVzQyWUVhTC96cWxDSktjQlVFTjVpZlRSWkJuRG9XdDc3VmI3?=
 =?utf-8?B?bkNEeXlsS09TTXNhQXJGS0dmSG9HTXcvWFJQYk1sMnNCNU82Uy84d1V4SXNj?=
 =?utf-8?B?M3oxODRoWkN0aVpuTG5DNTRNWjZsa3VXSi9Ra3BvL1p3UDJXOUR2ek1jWjBS?=
 =?utf-8?B?N1RObmY2RDN5VmQvWTlUQVFQc25NZnZVb3BKRGNoaUlsV0YzOVFQcTUxWTgv?=
 =?utf-8?B?a0NRcWRJNWkrdDJEblphaXBXekk1bHk1dGY4ajNhNVBoL1lUQlhva2tKajZM?=
 =?utf-8?B?cFpnVDlya2xEWG5HbUFienhqenBOaXU4d0k4bkg2QVZHUUhRdEwyUm9YRmhS?=
 =?utf-8?B?Q1hsUS85eWxMSnk3SEIrQTRMYTEyTk1ub1VremFiN241bVByZDhVY2VlV09z?=
 =?utf-8?B?Q3dFRVhkWVI3cjhKbTdzRmtUckRTd3ZPdHdJeGx4OElGL0lIRXpnUFN5UGRF?=
 =?utf-8?B?L3phQ25qSU54VmhFRkQvR0VNUHdjdllDbTJGWGpQbEhMKzhHY21tV0dBdXJk?=
 =?utf-8?B?NGQ3a1l3NXVjNXlCbk9nVUNUaUMya0hxbUdMbktOOVQ5a1JxbHhkelIydFVN?=
 =?utf-8?B?QUdyaEhlM3FaYUxiUHAyM05NcURpdHJEcCtnTHNFMXRjNFpORGZVUmdMU1k4?=
 =?utf-8?B?cDVocFZCWjR3TjNGdkZFek1Yd0JYUHVpZGVrYTBaMnFQVEhWQjI3eTdKcWVy?=
 =?utf-8?B?V2FsL2ovUUl3ZjNBTUZScDJwY2NWQ1pmbGh6WjZza1ZyL0FOZWZRbDU5VElo?=
 =?utf-8?B?ZTI0WG1XUSt3Njcwb3p2MVJNcWhnNUtaRlQ0aHgxT3ZBN1dCZXUwS1JuMGlQ?=
 =?utf-8?B?VHBJVThUdFdoOEorZURNL2g2K3RZcHdhYU9OeVdtaWlpNjU5YThlSkU5TEtC?=
 =?utf-8?B?L3Q4d3pVN01QUnJyWi9hWVB2QVl2OTdTcmhFOFJjdE04Ry9FU241ZWEybStT?=
 =?utf-8?B?c3ZUMGZXQlkyTFJadzBkNGZLWDk5aklSS053aUlJM2tRS1FkdXFCWEl0UW1k?=
 =?utf-8?B?QWZsbnpXajhwYUh0dThrZ0pNU3BRdVN1aDQwQzRqR3AxOGI4MklXM2p5WXZR?=
 =?utf-8?B?VWJLRHQ0YUoxRW5SbjhGa0p4SW56c0pjWG5nMXZ3V3JINEZlZXZablp1OUhM?=
 =?utf-8?B?emc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: de83757c-635e-4723-4c33-08dd614ed8d5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 10:15:43.1061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HRkxQcW70Lpna68MEN1+jiQrAKwsJzTmalwOVM1d0OiKQ5U0rrX8FuXXkWV/UrV58yhWaH/Eg8tzxzQ4tKuPLmYYe/Kkk1xY2BX86KyG8mw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9251

Hi all,

On 2/16/25 1:32 PM, Alexey Charkov wrote:
> Hi Heiko,
> 
> On Sat, Feb 15, 2025 at 11:30 PM Heiko Stübner <heiko@sntech.de> wrote:
>>
>> Am Samstag, 15. Februar 2025, 19:59:44 MEZ schrieb Alexey Charkov:
>>> On Tue, Feb 11, 2025 at 7:32 PM Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>>> On 6/17/24 8:28 PM, Alexey Charkov wrote:
[...]
>>>>> +     };
>>>>> +
>>>>> +     cluster2_opp_table: opp-table-cluster2 {
>>>>> +             compatible = "operating-points-v2";
>>>>> +             opp-shared;
>>>>> +
>>>>> +             opp-1416000000 {
>>>>> +                     opp-hz = /bits/ 64 <1416000000>;
>>>>> +                     opp-microvolt = <750000 750000 950000>;
>>>>> +                     clock-latency-ns = <40000>;
>>>>> +             };
>>>>> +             opp-1608000000 {
>>>>> +                     opp-hz = /bits/ 64 <1608000000>;
>>>>> +                     opp-microvolt = <787500 787500 950000>;
>>>>> +                     clock-latency-ns = <40000>;
>>>>> +             };
>>>>> +             opp-1800000000 {
>>>>> +                     opp-hz = /bits/ 64 <1800000000>;
>>>>> +                     opp-microvolt = <875000 875000 950000>;
>>>>> +                     clock-latency-ns = <40000>;
>>>>> +             };
>>>>> +             opp-2016000000 {
>>>>> +                     opp-hz = /bits/ 64 <2016000000>;
>>>>> +                     opp-microvolt = <950000 950000 950000>;
>>>>> +                     clock-latency-ns = <40000>;
>>>>> +             };
>>>>
>>>> opp-1800000000 and opp-2016000000 should be removed as well.
>>>>
>>>> Did I misunderstand what Rockchip did here? Adding Kever in Cc at least
>>>> for awareness on Rockchip side :)
>>>>
>>>> I guess another option could be to mark those above as
>>>>
>>>> turbo-mode;
>>>>
>>>> though no clue what this would entail. From a glance at cpufreq, it
>>>> seems that for Rockchip since we use the default cpufreq-dt, it would
>>>> mark those as unusable, so essentially a no-op, so better remove them
>>>> entirely?
>>>
>>> I believe the opp core just marks 'turbo-mode' opps as
>>> CPUFREQ_BOOST_FREQ, and cpufreq-dt only passes that flag along to the
>>> cpufreq core. But then to actually use those boost frequencies I would
>>> guess the governor needs to somehow know the power/thermal constraints
>>> of the chip?.. Don't know where that is defined.
>>
>> personally I don't believe in "boost" frequencies - except when they are
>> declared officially.
>>
>> Rockchip for the longest time maintains that running the chip outside
>> the declared power/rate envelope can reduce its overall lifetime.
>>
>> So for Rockchip in mainline a "it runs stable for me" has never been a
>> suitable reasoning ;-) .
> 
> My key concern here was perhaps that we are looking at a file inside
> the Rockchip source tree which looks relevant by the name of it, but
> doesn't actually get included anywhere for any of the boards. This may
> or may not constitute an endorsement by Rockchip of any OPPs listed
> there :-D
> 

Rockchip support stated:

"""
If you run overdrive mode, you do not need to include rk3588j.dtsi, and 
you can change it to #incldue rk3588.dtsi to ensure that the maximum 
frequency can reach 2GHz

below picture from datasheet.
"""

The picture is the table 3-2 Recommended operating conditions, page 30 
from the RK3588J datasheet, e.g. 
https://www.lcsc.com/datasheet/lcsc_datasheet_2403201054_Rockchip-RK3588J_C22364189.pdf

What is overdrive?

"""
Overdrive mode brings higher frequency, and the voltage will increase 
accordingly. Under
the overdrive mode for a long time, the chipset may shorten the 
lifetime, especially in
high temperature condition
"""

according to the same datasheet, end of the same table, page 31.

so this seems like a turbo-mode frequency to me.

Additionally, the note for the "normal mode" (the one with the lower 
freqs) states:

"""
Normal mode means the chipset works under safety voltage and frequency. 
For the
industrial environment, highly recommend to keep in normal mode, the 
lifetime is
reasonably guaranteed.
"""

I believe "industrial environment" means RK3588J used in the 
temperatures that aren't OK for the standard RK3588 variant?

> I haven't seen a TRM for the J variant, nor do I have a board with
> RK3588J to run tests, so it would be great if Kever could chime in
> with how these OPPs are different from the others (or not).
> 
>> So while the situation might be strange for the rk3588j, I really only want
>> correct frequencies here please - not any pseudo "turbo freqs".
>>
>> I don't care that much what people do on their own device{s/trees}, but
>> the devicetrees we supply centrally (and to u-boot, etc) should only
>> contain frequencies vetted by the manufacturer.
> 
> Fair enough. Let's just try and get another data point on whether
> these frequencies are vetted or not.
> 

So the higher freqs seems to be vetted (and used by default on 
Rockchip's BSP kernel), it just feels like you aren't really supposed to 
run those higher frequencies all the time? And especially not in 
"industrial environment"?

I would assume we want to stay on the safer side and remove those higher 
frequencies? Heiko?

Cheers,
Quentin

