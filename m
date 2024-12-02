Return-Path: <linux-kernel+bounces-427184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB6D9DFDCE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36364B21C41
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59691F949;
	Mon,  2 Dec 2024 09:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="hjpmb72G"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA621FA84A;
	Mon,  2 Dec 2024 09:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733133135; cv=fail; b=PFHI3dO4BgWmSby0piW/8klMLTckW/Cq7pnBLuPZhx9psloW5gXtpWWaPT1C7e0j2as1m2JZly60xQu+jxTO1eEtDN/n8XEhnTTZs9ONlZnS/vQgxm9q664aW80YD+qX+AzNxHYDtF141EMPKKOL8Fo2INQp+u4Ivke87fLQ228=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733133135; c=relaxed/simple;
	bh=D+BHw0IDSXF5JgwguJUv9ax1ADYkVydGsEKJ7AcnxQ4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JBo4KM2OEzZKe+OTC4zDWec1SmJXvTRd1xFkrcSLvU2ziAw7EM+XLqKPk1NYcoxgKN0BkXZdGYRkJPC5af7YnNdokmeKA45Ea6Zcje5rPY8XlxD5VRT4iguLD9edfI0xOtmEVtJ3u5yAKXC4uMF273Jv6uPb8E8Gy2ks2RYOBAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=hjpmb72G; arc=fail smtp.client-ip=40.107.22.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FbD93iO6SxQ5zQQqaNKty4LbbGCWwxkL/b6t9Q0XOqp6lMR2MnoLLN3W1aq1VAf6B75uXJ/QTtmZazUKj85EEyadd96D2JLRskQGa0plCsbmyljZyuAGcytR7WFCsPDGzQ0cL3ZNQruv5SsEOPGrOMj15JWxKgftQQ6QGCDZzAclx+fSK4ZvcgOc6XgwOShx9o4Nh7b0uk8qx88LwLzXHtz+TNIYzp40wn81bmLi2TkWckvLqlkAknB9oShIbLFb3fuygIqReoBvwwd+oHOvzLh7Nbi2DOhEXLagxri6h2q4pL5+4vZZGkAWtY4+7FTfSRoC1TLOsxQubAM2jAjAKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXgz+7R7UFZOhCrpab9KPYwxBnwB9NGWrEa1XDoD6y8=;
 b=ThJaZsHXSMT+yYY1tB6pDPrMgCJndu4Zc3nlEHcJC6mdh4Bvj7FjMeG2htPlS7rcxiYaKub6/wTEw80j0kfymGi5RQ0LI+mkFbddj+tYfm4lG3/MNyv6OZS5id/hUU+/d/OVLxGJT0i4GMSTXjMImW4u9O0I6xLQmbv+vA7kxoHdkBaHuLe0DMbqeSiUqaVEXCSZzKgHBrdVUYfIiCEXAvwtFgPD0i3WvB1emTFKnFnB3XHI8SwQEPyi3dkLEl2T3KgfsOOorQELADv0YX3/zegMklbLluNIfWcIZtB2qKHZqu/ePaKjttnA6pC6LPtsHjBgvgu8g86v/v8LViDf0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXgz+7R7UFZOhCrpab9KPYwxBnwB9NGWrEa1XDoD6y8=;
 b=hjpmb72GKtbdBr8xsC7cdBh73uJRjoOWgrIUioN/cyjrDfvk43qGAd5GSbpVz58PNk9CWlkQdzpzz2DdYNYkcbeQNgvoWfUVmnGZRZFAkYwLf++J0EiBVpelsMnp8plkZrD4J8Gx83THTHLSGav/hCNxoFmsxsmheyGSzbDT7Go=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI2PR04MB10764.eurprd04.prod.outlook.com (2603:10a6:800:271::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 09:52:07 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 09:52:07 +0000
Message-ID: <63b3be80-cb6c-49e5-858f-70fd826140c5@cherry.de>
Date: Mon, 2 Dec 2024 10:52:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: increase gmac rx_delay to 0x11 on
 rk3399-puma
To: Jakob Unterwurzacher <jakobunt@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Sasha Levin <sashal@kernel.org>,
 Iskander Amara <iskander.amara@theobroma-systems.com>,
 Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>,
 Vahe Grigoryan <vahe.grigoryan@theobroma-systems.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241202090408.201662-1-jakob.unterwurzacher@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241202090408.201662-1-jakob.unterwurzacher@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::15) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI2PR04MB10764:EE_
X-MS-Office365-Filtering-Correlation-Id: 930ebb99-24b3-44dd-b6d1-08dd12b6fb96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0xWWktmMFFKbDBkZUt6YXIrcGRtY1NkQStQbzZrSUpGdHc4S3B5K2xhQjZ3?=
 =?utf-8?B?NkRZeDJEdjBMUGtpZGdUOC9kNXUxQmxKdStiM2RXTlhCbVF6VHRTejIrZzA1?=
 =?utf-8?B?YlBiRlpubDArY3RUWFJGV29VZFJVbEtKQ3hUM1grNkRDZ1RtM1ZuWjZyNFV3?=
 =?utf-8?B?NFk1b1hCNjMxUE9mVVBEMXk4NXJETSsweFM3Zm9LMmNzODJ2aFkzVmkwYmZn?=
 =?utf-8?B?cVVPZ3dodEoxS09ZZTJWVDJHOTNzN3Ezdk5JYVBYU3dLRFo1WEFTUjBIYTdZ?=
 =?utf-8?B?R0dReHlxaVNXUWRjbzVZdzk5bHRHR3piaVAwWkZUTDNvbDVxVno4L0x2cVlD?=
 =?utf-8?B?Undla0IwOHIrOXZxdHlrMXE4dlArd2dlbmRYWFNSVGI1ZmJ5VnptQ2laaElk?=
 =?utf-8?B?Y3hKSzdZNUp5VkpCREhINlc3aHZoWHhFaERDRkdTZlM3L2tqUEJlS1lhaFJL?=
 =?utf-8?B?RWtKRzJNSktXblpZZm9teHE5U0cxSVdzQ1A5N2g3U2pPcW9Ld3ZpZ2VkOUx6?=
 =?utf-8?B?L05WZzBoNkFQbWxjRlB0Tk1yK3ZsQlhFdG50Nk5zK21vQWlHNlYramZSNEl2?=
 =?utf-8?B?TjltRWpOR0xBUGE3QUdWZnlmU2t0ZlV4WlVGSE1zYWg5cUgrQUd4K3FGMm5J?=
 =?utf-8?B?b2tYczVRZzNiR2F3Z0VHaURFQVFGY2J0aURYVGxHaFArR2syangyM3JCOHJj?=
 =?utf-8?B?eUVzSWxCWVNOTDFkMG03cHlyL1lpWEFDSHBaaUp0S2JFeHRRdllRM05yMENL?=
 =?utf-8?B?NVlqdmE2dWNNaG9VUzZlZDJIMDMzeENQMjZjYkRJaEltVnMwYVZxM2VmQUQ3?=
 =?utf-8?B?bjNjNTJUV09CRUNBNy9ERVlXRFg5NHdsVXgyRjhhbDVibjJhbGFYZmRvRW1J?=
 =?utf-8?B?WHgzTU1OMUtjb2ZadnpFa3lPK2VTL0U4MlI4eTloOEdZV2ZoN2o4WjZvdWFi?=
 =?utf-8?B?VzY2QjNWTDB5dG1EM3VNUDBzcERRdmM3YUdhSWxtaExPUkszWWRFSHUyclBa?=
 =?utf-8?B?RXRFT2RUOHdGYnpuanRIM3M1Yjl5S3ZtVFNaTDBFQlBzTTRhbjJmYURUOTlk?=
 =?utf-8?B?ZHdMdVYyeWZNL0tUV1l4SHI2WXk0VmlLM2U3K3JIbDlZNytuSHRXMXpRN1h0?=
 =?utf-8?B?dG1VMFovVC8xclUxVWFqeW9TZzVJQUtGR1g1WHVQbDBmZFBrdFptVzFEQzhp?=
 =?utf-8?B?OTBMY2FKWEc3THY2SEgzTkR2a0NHNjRXRDNHMFd3VjBscjlmenU1ZFF6bWYy?=
 =?utf-8?B?L3l2R3p6MEt5Zk5zeHg3TnNOU0dmeEcxaW0vQlZOd1hJcDBtNWNpd2xvdHVZ?=
 =?utf-8?B?RDN4NFVwWGxVYXVqTjArQW1KNGt5M3dIK1hjM1JQNTdrNFU4bFA0YkJMbmdv?=
 =?utf-8?B?NEJrMklpTU12VVBPYUNuTXBoWmdqUjN3U2V0VTFWZkNVVm16N2J6S0owcTQ2?=
 =?utf-8?B?UUswRWFlRWVRaTAzZURYcVIrYlBUUFJDOTBNYmlxTWNsdUFaY0ZCNk5Eak1Y?=
 =?utf-8?B?KzhBdU9URG5mOERiQnBrV2puc09ZSkNrTlpGQjBvYlQvTldqL3RiQTY2R3Y5?=
 =?utf-8?B?MXpkRzdkREFReHd6SGlGaWZycTU3aTFLOWh2YjJXOFpnUjRaRERYTHc4elF3?=
 =?utf-8?B?Y0M0bkloRWpFZmY4V0tkc3oxeU5LUTJseUo3NW9YNWVQVDdhanVaNmtCSzdP?=
 =?utf-8?B?WlN1a0VDblNIeW8xaEQ5b2pjWkVBZnhlVXB6RFJHSUZ2dUFIQnZ2ZXRFc293?=
 =?utf-8?B?NUVRai9oc0RGNklHODVWZkhxU1lXdnd3NGxLSTlMZ2hNY3phajFpWmtFOWpI?=
 =?utf-8?B?RjhReTVRdjBtdUlORGJiUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEl0cFJCT2VDcDZGYnhXNzFjMWFBVTBuRW5JTDFPZWo1WnJhNnE0TDQ2dC8x?=
 =?utf-8?B?VEJsUjdweUtIQzVjMHlGeW0wb0tLZlJqRUc1eStIZzBKeWJqNWYrTi94R1g4?=
 =?utf-8?B?eFd1UTU2enRrcTIxSWJqZXc4c211VjI0QTg1eUFrZC9lQmcwNEpib0c2L2dO?=
 =?utf-8?B?Z2cyZ01EV01LQUw4WkhSSENtTXZOcWpCajhHbkdQNS8rZWw2cmNrQlZDalZH?=
 =?utf-8?B?Ky9Ga3c3TlI0TlhDNkZzVnVQRGRBVGJSWlRIbUtrczY5SFNrL3ZnRGhWaEhN?=
 =?utf-8?B?L3ZKMXdPbnE5b3NsOVYyQzJ1alk2MEtsRDVaM2t1M2c5UWRSMHlTdmpvZVhJ?=
 =?utf-8?B?S01DN3BkWEN5M0RNQUpSS2dQWGNuMWw1VUhRTVVYM0tQUlhHRUdkWE5kT2pz?=
 =?utf-8?B?NFhGT00vRmozV3h3Y3ZvbmZ2SVJmMFNnZlFobzFVb1hyMGROSnF2Ni9JcW15?=
 =?utf-8?B?RXEzUjZMeWkwelEvRVpJckpiaENuNWFWN3Jvb2VYNUJGb0tIdG5HY0pPZ2t4?=
 =?utf-8?B?ZUQ0Rk9UUUFwalNyMlY4OXJOWDJtVEI4RS9qcDJrMlVsdXhtNUM1QlNtUnhx?=
 =?utf-8?B?NzVjSjNOVFlwWUlmRU1USHZOcWsxaEZURlVrOStQMnFIU01SYmtPckFnTFF6?=
 =?utf-8?B?K1E3RWRuQVdyK1BLRXdaVGhvSzAxakltZGwvWnVlSXY3YnZ1VWRlZk0vQ0NZ?=
 =?utf-8?B?ZWdVbnBVSVRKR3J6UjFHck5uL2ptN3VCVEQ5TW5DUGpQR2FFbExUTXFWbmRR?=
 =?utf-8?B?akFNcVdIY2hjRDZHeXV2TzhPV1VlNURqUFduampJWGdpc3NiNU1BL0tROENq?=
 =?utf-8?B?cDhIRis3N3NrYjluRjRjbTJibkZiRnZVempnZXdlUEtBemQ5MXgwbnB2Yk92?=
 =?utf-8?B?THV3RTlhL285RVNhUXd2WGQ0Y0RnUTNrZUxSamg2c3VDNnQvMll0cm04SXpF?=
 =?utf-8?B?M1NUWlVoQVV3bU1VaFRXc3RyN1U3czFpMlI3TzBuMndhNkFyZGdKdTQ4QnVn?=
 =?utf-8?B?Z1pUd0xkQ0w3WC9OanRKek16VVVwRk01VlNsZmpGZDVSS2trTWZqdUpsbmcx?=
 =?utf-8?B?OFlvNEs5L3pFRDFMTUNUSTlBeG5Rb1J0aHM0eDQzZkNtTkx3VXJ0YXJQSzV2?=
 =?utf-8?B?M2tzRHRxVyswNzJGaFRtK0tjU0hGMGFDTkN1eVNUeWJhd0FqanJZUlIxZkpn?=
 =?utf-8?B?M0U1WEF0MDBTcldaSm1DbDZQT0Z6N2t0ZHd3bWd0dWVYd3RhVzJZck9GWGc5?=
 =?utf-8?B?MUdJTy9Zc2w2a2w3cFZTSVlRcG5pMjhUeTVWNHpGK2tmWHRrTjlXUGU2SmJE?=
 =?utf-8?B?ZXpkZ1ZxejNOMkRRL3pjRzBxWkVZZVdZRzB4azRVSlZoOTJ5SVpQOC9vMjBz?=
 =?utf-8?B?K0tLNFZSS096bXRzNUdTV1NLUHBWUHRnQjVITFJZU0JOQlE5NFE0VXVNd2RS?=
 =?utf-8?B?RXZIV21lTVN2MzM1cUFPNy9MQ0JxRGlKTGN5cnVaZFpHZWNqM0VhenVKRVZD?=
 =?utf-8?B?bHQvWW50VGhxeVlhOVVaMUtSMXQ0M24vaGpHWlRWNnh4MklBcmV0Q3dRRlFQ?=
 =?utf-8?B?MnovcHRMR3lFTkovendMWEd3cm52azhacTVHYXRFbEtYTzFINlBnOHc2cEdE?=
 =?utf-8?B?S2dKS0s3SG5QM2VzWm9ic2hwaGRVb21nblBQeEpDVjlRSExUZUlobFc0QW11?=
 =?utf-8?B?cDBIRmltK3NEQ1JrZlc4Njl5L25BdEtHSS9IZnh6ZHJVeWxnVjhwUzhaeVBI?=
 =?utf-8?B?NHNJRTlXWFZLeDV0TXk0UHhRVU9nZTQ0MTZyMjROZE0vNWdubFdiSXBVNnF6?=
 =?utf-8?B?d2piL0c1TE1LTU5qZFNhTWcvQWlyZWczSVpHNXFCQUNuNFBKWThxWDhKcmJw?=
 =?utf-8?B?UEpxOXlleUh1ZGE1SkJ5R0k5YWhQRlQ5MTkrYUVoSm1lb2VzUjFxK3JXT3pZ?=
 =?utf-8?B?V0xjemNLdlNXL3ZaNnluUlh1ak82b2drdmlMOWN1YUFud0dxd0lOUTJKeXpE?=
 =?utf-8?B?cXlVaUdHV3ZBL0h2V0hXRFNhYmdHRkhaaC83UWVhN3F2ejdhL2VoSmU5R0lT?=
 =?utf-8?B?eWlRaHhqRjdhemZoaEU4SkZTK1hNWk5NTGlyK1U3WG9RTERZdnh4Q1QrSnRX?=
 =?utf-8?B?L2R0eFhObHR3cnB6Z1d1enFrRkNmaXoyTnpyVzRtT3lFQ082UlJZb3BHVm5F?=
 =?utf-8?B?Tmc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 930ebb99-24b3-44dd-b6d1-08dd12b6fb96
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 09:52:07.2182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agHZADi1Yqoes5pBEYUEOQxoB68VWfukLfDdgdqb5Er9ooCjfPHV2HzMuhPWBWq2bJgWTe9MASkKwCqig8k/AocwAJs5WIBP5FS3fPcyir8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10764

Hi Jakob,

On 12/2/24 10:04 AM, Jakob Unterwurzacher wrote:
> During mass manufacturing, we noticed the mmc_rx_crc_error counter,
> as reported by "ethtool -S eth0 | grep mmc_rx_crc_error" to increase
> above zero during nuttcp speedtests.
> 
> Cycling through the rx_delay range on two boards shows that is a large
> "good" region from 0x11 to 0x35 (see below for details).
> 

Is this missing a "there" after that? "that there is a large good region"?

> This commit increases rx_delay to 0x11, which is the smallest
> possible change that fixes the issue we are seeing on the KSZ9031 PHY.
> This also matches what most other rk3399 boards do.
> 
> Tests for Puma PCBA S/N TT0069903:
> 
> 	rx_delay mmc_rx_crc_error
> 	-------- ----------------
> 	0x09 (dhcp broken)
> 	0x10 897
> 	0x11 0
> 	0x20 0
> 	0x30 0
> 	0x35 0
> 	0x3a 745
> 	0x3b 11375
> 	0x3c 36680
> 	0x40 (dhcp broken)
> 	0x7f (dhcp broken)
> 
> Tests for Puma PCBA S/N TT0157733:
> 
> 	rx_delay mmc_rx_crc_error
> 	-------- ----------------
> 	0x10 59
> 	0x11 0
> 	0x35 0
> 
> Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>

This would be a candidate for backporting I believe.

Therefore, a

Cc: <stable@vger.kernel.org>

here would have been nice (in the commit log), c.f. 
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#select-the-recipients-for-your-patch

> ---
>   arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
> index 9efcdce0f593..13d0c511046b 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
> @@ -181,7 +181,7 @@ &gmac {
>   	snps,reset-active-low;
>   	snps,reset-delays-us = <0 10000 50000>;
>   	tx_delay = <0x10>;
> -	rx_delay = <0x10>;
> +	rx_delay = <0x11>;

While at it, we could reorder this alphabetically and move rx_delay 
between pinctrl-0 and snps,reset-gpio? c.f. 
https://www.kernel.org/doc/html/latest/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node 
rx_delay and tx_delay seem to be vendor-specific but without the vendor 
prefix, but so is snps,reset-gpio so that should be fine to reorder this 
way.

Considering we have an option for KSZ9031 on RK3588 Jaguar and RK3588 
Tiger and the "same" MAC IP is used and that we use the same TXD and RXD 
delay than on RK3399 Puma right now, I guess we would want to check 
those don't need a change as well? (funnily enough, all RK3588-based 
boards in 6.12 actually have 0x00 for rx_delay and 0x43/0x44 for 
tx_delay, except ours which are at 0x10). Not a blocker for this patch 
though, so:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

