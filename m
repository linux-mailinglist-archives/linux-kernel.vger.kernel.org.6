Return-Path: <linux-kernel+bounces-563772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE074A64821
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E72523B34CD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C832225A22;
	Mon, 17 Mar 2025 09:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="c+lY5+q+"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2092.outbound.protection.outlook.com [40.107.117.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1AA82D98;
	Mon, 17 Mar 2025 09:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742205116; cv=fail; b=Lq6n1Dg7yICbZjWboHe25LhDViP9onNw/N3R+QXcO9EvGhCTm8mtom1nmUPTUDE9bKpUhGycNkWwLAbpkwg22mnUfx6S8RIB4tld2hlAX/7bl/OQaZObsppQO6IjxoAYvtbMyf/by6/0XGGMqNYXu87gwdCJhHKDZjlOtNW6JHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742205116; c=relaxed/simple;
	bh=FFHYZltxng0THSrkTZTQjwGiSOSrPgSjoAPfTSNnerI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FfzL0EAP/zwuMWY3wONoXrGP2FGQ5nEyihotukAF8nzltPVlGu17qgReetqVIIITgmT1JLdAbUQStuawZFjh/cfxDvCb2PhOoih9OcVwsn8qxLEW1K6duVyN9HilT1lqCYZ7eZ6D2IvUeYS9uhH0wAqWCB0RMh6X3zl/c/3tQoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=c+lY5+q+; arc=fail smtp.client-ip=40.107.117.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8Gj9CELJYQqaLh11zsjPXI8bQclBT+Q4N5HbYh+dgVNjg9FypezlO5LN2JdIyYj8++Ul09p89PCsQ2Uo14ZWXkulCiZCkn8gNNQEIcUTcpItFg8PDKYKyKU14TUTaYc5tL8Gvslg3lQb8A03GAPL8wiMf1sV9xhGYBgpdN/HnZooLb0P0vFsenWYZ01iTcSX9sVsxWwVO9cAZDLsKlnLnR0cApxv0bEQgshoM6SPgU2Ez1GqPVGbaBiCbJrPvnMCmGllP9SKXyBIJIDLQxxuAK9LrXT68UP1A6T7sw2kx8RT0/UcK6W8RXNJ8H8eyCqup9BDZNKvgGh7LiGXs+1ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5j5aEDSSa1lYZ5Py3H66qEi5A+PSFb42viyfMlXLA0=;
 b=Q4CJyMtAmspZ+fI9Je2kOg8NZHN/I240VkrBItcvk8CzuLEM/Pq/jH5Y3NsvU1J2lR7SbyyX7dhbbtnzEMoq01jMp0E9miWLtN/vm0MPo6VjU8kDkZ2/2FEAxcAphCcQi2rmWmoX0C/GpcRY0NAeA5km3+RQMPFkc5t32PGajhsXNsQ8DaPSPZLutbv4VtNvaCuSFZFbfz2b1YBvvEJJrWIsKYOe225ErqS+TQcyDZNez1M/eR2Lx3u15xs5O091NrKsdueqsOACTlv8MP3OvySeXF/8B7mrzsLinOzdje/HvAF0VMAFwKogfZn4Y2Oig17m9GMGVJMOXWy7lW4xqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5j5aEDSSa1lYZ5Py3H66qEi5A+PSFb42viyfMlXLA0=;
 b=c+lY5+q+b7CyHRr7uv7JqubNp3x30DfwdLc2z0J+CP48R+QJcuMapG4K8U1zOsjKAZPYj+Fa5fWXKMKgkdwgOvAMEphp6pcQHnzvTr5Q2TXnALUfDIC4DQC24c2ARBY5GWkp1WCStelRJzvJrMAgAOMuQIpfYRfutxFBO0bwKGX6RhZq9QgXN5h9pQwhByHZb4uvVnqlsN+x5mF4pcdN953Wkd1ulSfO1MNcXudY6Itr2U70ux582Ga7OQcBryWKZTtQVMyBUlPGc/JldlyJjBLcQxvdmO7VyOuLWe2T/OyVUMoFsy5XZpyRPz9TSSdBNqjPAcPZSdyWQxAKs99ZAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TYSPR03MB7885.apcprd03.prod.outlook.com (2603:1096:400:482::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 09:51:51 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%4]) with mapi id 15.20.8511.026; Mon, 17 Mar 2025
 09:51:51 +0000
Message-ID: <bea10706-46db-4162-abc5-24e0051d4051@amlogic.com>
Date: Mon, 17 Mar 2025 17:51:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] arm64: dts: amlogic: Add A4 Reset Controller
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Kelvin Zhang <kelvin.zhang@amlogic.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 Zelong Dong <zelong.dong@amlogic.com>
References: <20250313-a4-a5-reset-v4-0-8076f684d6cf@amlogic.com>
 <20250313-a4-a5-reset-v4-2-8076f684d6cf@amlogic.com>
 <20250314-tested-husky-of-force-1ccdca@krzk-bin>
 <3dceafbf-49d4-4084-bfae-74384e187941@amlogic.com>
 <4cec908c-1412-4e18-959d-b71c9ec21eb4@kernel.org>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <4cec908c-1412-4e18-959d-b71c9ec21eb4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|TYSPR03MB7885:EE_
X-MS-Office365-Filtering-Correlation-Id: 40309c71-a31e-4b9b-9bbe-08dd6539573f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEtnTWIxR09hMWVpWFBhMmNGendNZCtZbTNvd054Ukg2S2pxMitOVmFocDQ1?=
 =?utf-8?B?UEJsSXVsZEd3Z2ZYWG4xNG5CQjRHTjVlU1N3RGhRWFlSN3JNUWV4V2FEZHpM?=
 =?utf-8?B?eTYrVTI2NWNEVDhpbTVzS0hXTTU4L2I5R1k4R3RwR2hKcE1hQWtSQ21Zam04?=
 =?utf-8?B?cVNLV0hEWi9IK1JPUCtnTUVqTXNuMUQxckZ2SWgwMEk4TTI2RXpEQVdOZm8v?=
 =?utf-8?B?UjBjeHhPeHdJd2RVdU5uMGVUcVZNWFlrYUZLNFpLc3J1KzExcFlYdWFuQkUx?=
 =?utf-8?B?S1gvZkc5Uk9wbUx6TS9ZNGNQN2lwVGp0UTJGVXp1TEREYy85Q1VkYjhHSVJD?=
 =?utf-8?B?R3EycVlGQlMvUSt3Uk9TTVZaMkU5eWtLQ05CTmYzMjg5S2k0WEUzMEdRd1BZ?=
 =?utf-8?B?bytpQkx5K25ySS93MVdQQ0Q1a0NyYzdYeHNmeFhzR0h3VW5HR0lTeERCdGN6?=
 =?utf-8?B?bmhVbUJFZjF1WFZDNTV5RHpWclQ5eEd1eFdiVXdmVTI3WkpYdkVyQkFPcEtm?=
 =?utf-8?B?d3Rpcm5WNGFUMkhVY0g5d0FrZm0xRU9XekVYUXNaeWNzQUZ6TDUrY2dBdUxM?=
 =?utf-8?B?Q3FWQUxtNVRJY3J0RG9SWHRKL0ViYURJZW1MV1FRR0VDWTRTeUFzcXZxSkxk?=
 =?utf-8?B?cHE0aVJueCtCbU1YaU9kNXNzZGlUSlVTQk5walg3S3hob1Z0UUNLSU43bmhO?=
 =?utf-8?B?VzVHeHBGY3JwbzhhQ0FqeXlhRkdGbE1yUkdUMXZML0Q0SENMdmQ2QkxXTG1r?=
 =?utf-8?B?dFhmQWpPeG5mZHREV3ZSRGFXK0pxYXhLU2JNcXppb3lkaE5ZNS9nVXZVL0pk?=
 =?utf-8?B?WmRYTVA5cWNaTEcrb3JPSzh5c2V3Zm9wdkJtRmE5Y1RNS3dSRCsvV0FsKzhP?=
 =?utf-8?B?MmZPUlZscDhKSXhFdmt5OVIxVEVGQXl3VWEydFpPMGdHb0lXanRCaURBWWxm?=
 =?utf-8?B?c0EzQ3ExVTFNMzZNblFDZXd0MjF5dW9wbTBmN3o0ZWJpa1ZFSk9mcjJmMEZQ?=
 =?utf-8?B?bWNHM2dNaXJOeE5rWmZYQ2lSZXlCSWdxV09WTU5LQmFiamFac3lGWEx4Q0Fu?=
 =?utf-8?B?STlwY3VUM1pZNFp6ZU9NMjJrL3lad0tkZ05lZi81N3BSKzhjKzlUSkl0eXRn?=
 =?utf-8?B?cEFXQlJXQVI5bEJYVG40SE8yeVFHUWhpdWcrcTZ6RXZScVNjR0x4WS9DMkZq?=
 =?utf-8?B?b1BNUzlVQ1ExUzdTT2dzUkc2ZUpvQ3hUVGhldGoyWnU5Qmxmc3dHMEUyWEhi?=
 =?utf-8?B?eDhOZkhZamN2WW0yMnpncjRmVU84b3lPRkRkenA3N2RjUlQzTTB5UDJtQU9w?=
 =?utf-8?B?S3BsbmhzOE5USWZxTmJzU0ZwT1Y4bGsvQ2thU2N3ajJ0Rlo4SDdkMVB5OHJx?=
 =?utf-8?B?UVRxbi9IblFud20zMHd4UGE0WlVuSFdCWXk2Qzg1NmVCZTAzZTZCd0JlYmdz?=
 =?utf-8?B?WTd5WFgya09rL09ZTTQ3aVhqQmo5LzltQnMyNS92Q1g2RTVoSnBCcmNpc3Nn?=
 =?utf-8?B?QXF2RTZYcmFYZXpLbmZ4RWxzLzhOeVdST3ZUc0xvdDFVblJ1c2Zha3BNYytO?=
 =?utf-8?B?VDFyd0hEZXBEWDhBeW0wWDNzZXNlTkdyZWpCcVBQT3ZhSW02OTVvMVFuYy9G?=
 =?utf-8?B?a29LYzdDZlRzdVZEa0xTYU5NUmJKS1R5VlRzZkZ2L1ZGZjFmRUVDVTJhWHU2?=
 =?utf-8?B?L0wwbGYvb1MyZHZGTGNaWDNjMWd3Q1p3b0d5TGg5NUdOMDhjWkp5K0locXRs?=
 =?utf-8?B?YyswNGtGY2thcHRxbklWTVRXa1lwU2Q4TUJrbkpnV1RWTHJGbTdyYmg4bkN1?=
 =?utf-8?B?ZGdnZytZL1ZmWUl6MVpDTFNxWTVJbE55WVd2RGNHQW1NVXF6MUYrbFVBQVBy?=
 =?utf-8?Q?ht3rvzb1hkWYK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWFLU3RVQTBwdlBUQzg5c1dsdE9QQ3hDWkdSM1ZxYU1XYk9UYU1xLzVIWGtv?=
 =?utf-8?B?UU5Obk4yL1hvRzgyQ09ub3lxaFNxaGpKSjBreFE3WURrc3hib2FuZ2wwQzlk?=
 =?utf-8?B?R3BwbENNM1FnSE14SHJUN1l3bGUwSDJNNTZLeW9zdlA5NVVSRjljK1UzcHAr?=
 =?utf-8?B?LzNrRkc1dWlxeURiZzg3OVhXQnRsSjNidFNHdFBzdTlOTXphbGhFWThZaTNz?=
 =?utf-8?B?b0VSUXpldnRSdllEWUxQOExxQlNTK0hWNWI2d0tnQVJFOG5aem4zL2hEL1Ey?=
 =?utf-8?B?TDJwTkl1R0JSb2hUMGwxZkllK0ttd3UyVXdPREptSXNUNkdsWkJWRVlhN3RL?=
 =?utf-8?B?M2ZORXJLMzRqSG53MVFqY242TUNiL0hmMEp5SllMM3J2L2hROEVGVFlmUzFH?=
 =?utf-8?B?OWxQMnZ6dFkrMnpibzFOZzdxOXVlakZxQzdKUElkY1I0eklBd2xyeFhZbTZF?=
 =?utf-8?B?T2tOalkydDQrek9UZ2s2NDZyVkZLTnRxeDhKMWpuM0ZkMkhackZkNSsxWlNq?=
 =?utf-8?B?elREY3Q3VjM0VGpqK05aT2ZoUVFLb1QrSTBNdFJrdks5VE1weGlyVUU5NnJH?=
 =?utf-8?B?YXQ1Zy9QWlFwWDVOWHkzNHR6V3Q3ZG5JdzIzUkhwWUdUWHpGMTVVUDZ3ZGIv?=
 =?utf-8?B?ZmJFRWY2WEV3TkYwa2VqcGhRWC9Ub0tPUG1tTjBZZGhYZWNsRUpIRE9nbHlk?=
 =?utf-8?B?Vm5Tck9xZDUrdU5HaXEvdytQbmlQVTBBK0VGSGpMWVE3WG1OOXNLR2xYK3Uy?=
 =?utf-8?B?TnV5VUkwczJVc1B5LzczWjkwUUZSYmdnRFFjdTJZdUdRQ1FBOGJ1ODJPeTdD?=
 =?utf-8?B?bnc1T21ZdzVGVWYrdkltS1ozWnM3YzdrWlpmNUgrcHVNd2Fhc00wbUFxOWVF?=
 =?utf-8?B?N2treHJiejZhVjBCSmllbzd4VEtMRlM5RXJYWHF6Um9FNHh4akhaZGphTmtG?=
 =?utf-8?B?RVlhaGlMTmQxYXEzdW9LRzdndHhOZ05wTlA0d25zSlNhZFpLMFBTZUVRcUUx?=
 =?utf-8?B?WXJNcW10eFoxc2xzWWhqbXY0bVNYbXRxbDlJcDU0RlJiekJQMS9VUkRmWDlY?=
 =?utf-8?B?cW1jY3VIaGV3T0x1QlN4QStUMnUvQjVRcldHejhzRStUNklxTTFISW5rMUZ2?=
 =?utf-8?B?ZWpFb1dHcVc3eUlUWlJjZDVYY3VCYWRlTys1NlpIMFE2OFdQbk9tQ3lHL3o2?=
 =?utf-8?B?ODZubDRyck5TaDRvZWdtR1JyM0ZxRFFtUHpYdnNobmhEbE5UMnE3ZFNRK25o?=
 =?utf-8?B?NWlmWVkzL1NsRmZ2ZDFITGVieFA5eFQzR1BSVWVQMWNKNUxUSUQwd1ZnMnFh?=
 =?utf-8?B?aUxNSk5HTVR2VjlnS3hWZVpVNC83emZIeFJLVEV0YnUzcTlHZVBzRWMvL1ZX?=
 =?utf-8?B?UUVUSytEOGdkc1FuUVplRXFNMHJaQ1dDcjNJcVd5NjZuR0dZeGsyTlBjZ1VJ?=
 =?utf-8?B?Z0hSQnpvV0piamo4OUh2WFVHSWRzbDFSbVNFNThJSGI2U1Z1ck5EOTJ5ekpx?=
 =?utf-8?B?bGhnU0RqWmFDTllreWlnWGZHeTRBMW5Ed1h0T2FmMVFCWUh5ZFNtWjhuL3p0?=
 =?utf-8?B?d3dhVHhlbE94WjVNVE92d0FwWGNNL281bTBjSzZWNW50WktSL2JwcHJUSnpN?=
 =?utf-8?B?NHIzQjRmMHpDbzFScjBtaGpVNUZBeTBZMWdhTTRUUUliMUlleVdONGFTcUsr?=
 =?utf-8?B?VldWQnJobjVyck9wWXErbUN6YWdoOHRUbzZsR0h4TitaNUZUc1hqVlNGOGcv?=
 =?utf-8?B?aWJLUkwwcWFjRENmQ2syRTM5djlYRXM3Ym1uWHFMR3lsNXhCY2ZQbVZxUllQ?=
 =?utf-8?B?UFJmeXpyVVVxMWova20relU1MUM2SU5QUjdHVDA4VkFiSjk5Qy85OUZIRjMy?=
 =?utf-8?B?WDJWcjF3RVk1cDlXVkhqdXM5NkR2bU9WaXptb1BTSm16TUZEZ2JhaElXNytP?=
 =?utf-8?B?T2cyT2NFZHVjWUQrSEFKdFlrakVjSmdpazFzRVoxYW0xNXUxcXdrczRYVFpj?=
 =?utf-8?B?WVB3dFhoKytIZUlXSTRJdTNXQk5UTFhiWE9abktEWTZYV1Vla051MlI4eFVT?=
 =?utf-8?B?NjlsU0t5c1d1TGN4ckVvMlphRG92RkdINVcrYnNoK01NeVlIWVczQy9XVWFB?=
 =?utf-8?B?N1pPYitKdFh2SlEwaUFnZ3lYVnJKY09GRk9KWSsyaHU1d29odms4NUQ1NUdq?=
 =?utf-8?B?Mnc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40309c71-a31e-4b9b-9bbe-08dd6539573f
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 09:51:50.9863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OcZat5WpvEEMZC42AMI9Q1TDjVCG+bdv4Zv9D+JadYJoECesfLsD0Ndvgu2Vgz/oMtuHQnN8F0S5p/QAx0pSCxPxMMfCYgtqSciJuzYzpP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7885

Hi Krzysztof,

On 2025/3/17 15:28, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 17/03/2025 03:49, Kelvin Zhang wrote:
>>>
>>> Why do you have on the bus devices with bus addressing and without it?
>>> What sort of bus is it?
>>
>> Are you referring to the 'apb'?
>> If so, the 'apb' bus is defined in
>> arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi.
>>
>> apb: bus@fe000000 {
>>           compatible = "simple-bus";
>>           reg = <0x0 0xfe000000 0x0 0x480000>;
>>           #address-cells = <2>;
>>           #size-cells = <2>;
>>           ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
>>
>>>
>>>>         periphs_pinctrl: pinctrl {
> 
> Then what the heck is this?
> 

I will fix it and add the unit address to the pinctrl node.

>>>>                 compatible = "amlogic,pinctrl-a4";
>>>>                 #address-cells = <2>;
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
> 
> 
> Best regards,
> Krzysztof
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

