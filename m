Return-Path: <linux-kernel+bounces-559109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0914FA5EFA5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D84D617B4D3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10282641EA;
	Thu, 13 Mar 2025 09:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ukjHzlfd"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309C9263C77
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741858644; cv=fail; b=rKMMvLe2nZZwdJSTfsCHVCaFH6v2FldFLgBj+0DEOvihq4UnXDXfR5/h0fBnuRnfuy5K+7Cz/NJzQU5rwlKP8/igKLbIvJkG71VJdwRqYJ2ENEKHbOa7RI/ZjMnW3erXVafrFl2FuWjHis0iMfdehRHJ/f3TKapBbaGefdzopEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741858644; c=relaxed/simple;
	bh=uKZ9rGIvEmZR4vUDyudeoO+mcPbgPNYZt1A4AwIobXI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ns3dIO4ydXnmJgjF236oGZyQMwWUK13vTjTGDNiRzvH6sMIfW0gtNl18VwKk780e7ahC1GrK8JVn93L9YKVXtnE2zcVeJtaxt5aPVRz9wz6bSdIrK1GAGNU+9CN4CpV56Lh6otEURnxqrAcgN8l2Re9APpvXAwygRBxfox3Yxvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ukjHzlfd; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OcaiUmyzTCLj/TdUvRWSC6sxpk6dMHEwzRqqe3DDZ90iMI6+W4C3XwQbGoXvfgKq9nyoDc8jjTy/rSubDJN+26LUYYOjvjsJ6uY3qcbAVc13d6AEujO0IV7I9r/7TELFbxcb0AriDXCjzCqNZgV2spYOknhI1H2C7YY7ULXo9hSmU3/a5MvprhfxrABnmZntKtYCl+aRvPniJacNLPszMLajisx+jDDFS8gOtXQmUdQ2ULdUysL/C2hvU/WBZzVrdsH5hAjPfSoDUz/nNdI4TnTWGz4PhuoozSm1EO0STP017UcQUFF78C+4wBfQoqlZ97rHphLlYisG1+WmHHrc1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gasZey2P7QOyOi5AmvEwF8j32AebXWJul36rI45WPCI=;
 b=WWmcjQiwKo9p60iTGO2Gb99h7/jU19VI2vuyLGtpSr60Sd9G2JczvWvNbX6qLl5vKtnvT56PbWgewIgW63ZQk1TllEVr7p6OnONGUoXdW+oBYh94lkcNsBIHguBTT2asz7FK8Rwqj0uMJUxHzYMJCxoNsIKPby2H3k4BnFSOsWnveWtcze/O0clt0s5E7ppHAGR74VGb5jHcecAplAkwlKPOMEfcsb/tB7dk4Wg3idPJ00YiDcfgie232Mavim50gVwolaDCn6GTZw/OBddDl89kFp4ZyenK76qNlQRKU1LbaU4Gtl4IMLwKS+wnLIIcvwoVbQDaEq7EACicjy5P6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gasZey2P7QOyOi5AmvEwF8j32AebXWJul36rI45WPCI=;
 b=ukjHzlfd/QuMWwJ/tCy76kBICaXqlPxMJl5EzqyvBs2dQEVqU4b5JQsLv7vk7yVdgCtr3XG+j27bqgA6a9Fk0/kKz+GsQUCz0nSWM0K+zHtH4TGUm44oVlg0sRcpg1oD4a40h2cxMLn2MeQJFwmMWh5XoLlUtciSpXTRRqX7DSA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9193.namprd12.prod.outlook.com (2603:10b6:610:195::14)
 by CY8PR12MB7755.namprd12.prod.outlook.com (2603:10b6:930:87::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 09:37:20 +0000
Received: from CH3PR12MB9193.namprd12.prod.outlook.com
 ([fe80::7818:d337:2640:e6c7]) by CH3PR12MB9193.namprd12.prod.outlook.com
 ([fe80::7818:d337:2640:e6c7%6]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 09:37:19 +0000
Message-ID: <5e45bf5c-4035-08fe-ef6d-e030941e98e9@amd.com>
Date: Thu, 13 Mar 2025 15:07:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH 1/2] drivers/misc: add silex multipk driver
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 derek.kiernan@amd.com, dragan.cvetic@amd.com, arnd@arndb.de,
 gregkh@linuxfoundation.org
Cc: praveen.jain@amd.com, harpreet.anand@amd.com, nikhil.agarwal@amd.com,
 srivatsa@csail.mit.edu, code@tyhicks.com, ptsm@linux.microsoft.com
References: <20250312095421.1839220-1-nipun.gupta@amd.com>
 <51ed5660-10fe-4a6f-ad99-9741187341b1@kernel.org>
From: "Gupta, Nipun" <nipun.gupta@amd.com>
In-Reply-To: <51ed5660-10fe-4a6f-ad99-9741187341b1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXP287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::19) To CH3PR12MB9193.namprd12.prod.outlook.com
 (2603:10b6:610:195::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9193:EE_|CY8PR12MB7755:EE_
X-MS-Office365-Filtering-Correlation-Id: 839cf05d-9446-47d1-9fd5-08dd6212a641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUF2SmVIdnd3NmxkYU5OQ0lGTEVvTUlxclNaaXAybjNsKzQzQ0JwQVk4NVZT?=
 =?utf-8?B?dWo4S3lYSTB5ZzM4U2EwNUhCZlRadUlGLzZ0dmdoUE50K3JuUTNVS0puLzFB?=
 =?utf-8?B?OXJJUDEvTVBwWGF4Zzkwbis5MCtVY1BZZnozVjRXL3JJUmpwemlzSlNLc1JQ?=
 =?utf-8?B?d0E5bnhLbDhYMEd5Wkx5dXBIaUVtSzVEZHFpckRyZW9mRk93czJKRDkrLzky?=
 =?utf-8?B?bXJHTVRzZGI0VlZDT1ZaSTVvVUNiYmp1dHZnYTIrL0hOcnVWd0N1UDBNdkxV?=
 =?utf-8?B?RkprS216UFN1YU5jeGZPQyt6amJGS1RDZTArRWF6bkVUcmlhMXdZQmtOUDRZ?=
 =?utf-8?B?ajZwY1JmMjhCZ1dWVUJkWmRybk1vZlZyTkNmbjFFM1NsSWdoY2F3YjBuWnBY?=
 =?utf-8?B?VnAzRmJSbG5RKzFEd3RHKzNqS0pEZkJCZ3pMd2pLOW1NQ0FxcXN0bzBkL1ND?=
 =?utf-8?B?dFlLblY2MkM0SnF4M3pSSWFxY09WWTg1R05QV29ELzdBeVkrbk1rdVhvOXA4?=
 =?utf-8?B?V0dtRGtpKzFWY0pDUlRsSjVka285dE9NbVJPWjFYSlVYK1p5WWdIRkFsUVFn?=
 =?utf-8?B?SVlDK25FR2IrRVFVSW9RUFRkRDV4VUJsbGxjbGNXWVpQZm5TK0Y5VUNjaU13?=
 =?utf-8?B?ZUk3QzF4cUJnd0ZYVWZOaU9Ia2RBZ3c0WjFjMi9Dc2hCdkFWODY5cXkrY2NB?=
 =?utf-8?B?dkIwY2doNGsvTU92eXV0bTdWNittV0dtUTBpVE9iRVF6K3ZoRHllTGZnMFRt?=
 =?utf-8?B?Y0k4TDdrZDRkd1RoSm5YdlNPbzBkb0YzWFlKTytLMjRNRXJIVnRBUDhRSUZs?=
 =?utf-8?B?a1krNjM2VVlzb09rQklYV245KzB1OUlPOVdGUkNselVES1cweVpmQVNZSHEw?=
 =?utf-8?B?NkM0TjdHQmc4VE0xNW1BWk83cERITnN2ZEZWaDZhbnpYbkVWZGkzVGV0WGJ3?=
 =?utf-8?B?RmFMTUVESEJmWm00MTRtbzJEMmxvWkp6S1NPekhsUG5TS25Ibk41STBpTi9x?=
 =?utf-8?B?Lzg5U01zQ0MxL0VlK0dFK3FhU05GN2tlOXNyVjRuRW5SbTU2MWovWDAwRjZq?=
 =?utf-8?B?M0JYdjJiWGJZWWxuYUV0WUpQMWhCeHFKbk50UDR6bFdMQlFzeGc3c1JsKyt4?=
 =?utf-8?B?VVl6a1NsZ25tT3AwV01YMUY1MWdjZWNPNS9IRHM4WHlVWHBQdnJPbTdnQ3BL?=
 =?utf-8?B?UWlnekhPQmtvMEhlbHo3dHZTUFJZdmpCMU9nS0FvMHdXOTBPZ29QaGd0cmZ3?=
 =?utf-8?B?cEhSeTcydVJUMnZmUFZmcEQ5OXpjQ2VtY0NodGdvNnEvd3BnTEk5YmZLR2Fl?=
 =?utf-8?B?M1g5bjRNcWJzTURDcUZwcXFUZjFsbHBvbGt1QjRaR3RMdHFPbHd5MWh4QXR0?=
 =?utf-8?B?eTNKR2dZckppVkZqb0R2SzNGdzhZc1JWdmNsdXFROFNIWjVjZVpEeXdxTndE?=
 =?utf-8?B?Uzd5VE9ET2JOb3doUHM3VDQyckQxSTNYUXpOWTJBaGZQa1luWFlJbGR4cHJ0?=
 =?utf-8?B?bElXVjV3bWluVnR1R21kSWhhdjVNdjg3aHN2VzNXeEpJUW5WOXJ5TVNHc2ky?=
 =?utf-8?B?QlprZExkQXNXNTh2dXFON1QwLzJDazhOckxYT1NnV1F4VGhmdzUwUmowRG5M?=
 =?utf-8?B?anVpSFRXeHFDNll3Y3ZaWWNmYkdGek5adXpMYXE4TzdiV0FUYjlLRHNGdGZE?=
 =?utf-8?B?UFpnVXBuRHh2TEpoSEVULzluNHgvWWVnc05ML1ZWUTN3RDhiUlBlQWNPTXBv?=
 =?utf-8?B?MlprcU1weHptcjljazRPYzk1ZXVqMmt2c1lvdnJuM25jajVxY1ViaDg5azNa?=
 =?utf-8?B?SVB4R3VJVzZjOUVPV2hXZjlkaVpBZnlFbVFjUU1GamxoaDgzQUk3emFKZDVT?=
 =?utf-8?Q?xrR6npw9CUwJl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9193.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFhpOE5VL3hRUEQ1UkhGMG4rRk1xWnFkc21tNVoyVWhMRFkwY2t5V0FsMWQ3?=
 =?utf-8?B?aEM4OXgvamRxcFZlTFNFRFNFQ0VmV01waDNLaWY1K2djRkhlTEpHNTFjLzdu?=
 =?utf-8?B?R0xDMHVFKzlkUG5mczNjSjhWc1RJaExaeUo3QllsM1NBbFZ2NlZSdUVHUW9K?=
 =?utf-8?B?UExuWVAvWFVqbk9XK3VIc3VjUWJxYU1SSG5EeUoxUStwQnJCK0hQdVptZ2Fk?=
 =?utf-8?B?UjBJZDlobSs0azNqbHcrcHArSXNqTUhraFB4aG5PeWJaMlEwdDROUFNac01N?=
 =?utf-8?B?bnpYWWZubTljcEQvYUc1d1crenBPSmpGbDcrcXpBRGRIaVFEcm5zOUt1aTdW?=
 =?utf-8?B?NWtWNGJaQUd6NlZlc25VSjdSTElnRW55UUVGS044b1ErYjNRY2pNT3M5R1pU?=
 =?utf-8?B?VDRGKzZZU1g5aW0ySlVaL0Qyb2pyQjNoeTlnTnMySFZ2R2VPVGN5aXlDd09N?=
 =?utf-8?B?MVl0cWJwQ0pONFRZQ0VDUlZBUzVUTDR0K2RrSm81SHNRTllQZzU0dXR5dTBU?=
 =?utf-8?B?TnNzNC90NmhZRjBzNUYxdFpMc1JqcC9zcUdCL2FQZVdZQkF0VXhpcUtyVFp5?=
 =?utf-8?B?ZlAzTzVNaThpTkprTG9ueFQ0NXlWZjh3WG5lcG8xSnRnaC94L2FCMnY3dldt?=
 =?utf-8?B?Z3BRNGxLV1dpMnRtTmp4T1NwQ04yZ0phbG01eDhabEZ4OXltNE1aOHJ2ZUc2?=
 =?utf-8?B?MVhqVEFGNXlXKzBQam0zU0xaeXlyZ1RHM21ZMVNacFFibnNWU3ZNYVpmK3RE?=
 =?utf-8?B?TFhWYUZjWmdEaXhWVTNHV2hoNnlaVXF2MVBTbUduemJlMElZK3NSMTF0eVZq?=
 =?utf-8?B?SGtlMktSVURjc2ZQTDliR0tmd2NDakdrV3hWQmM0WERyQlFPU1lKTzNQZFVo?=
 =?utf-8?B?MEhtcVpUQlcvYWw1RWN4SmxSK1lTV0dvTlNYT0t4Z0pSaUZ5dEJvc3Z1ZEhV?=
 =?utf-8?B?TUxpaTQrQ3V2dFRxS2lZb3lwMkJrNkRjdjRVTk5xMnQ2L3JxL2o1dEZSZnRO?=
 =?utf-8?B?WE8xQ0NhRGF0bFNaRXdiaW5kREVkZm1rck1vYmdFd2JNVjVlUkpjcktQTTV0?=
 =?utf-8?B?bE91UUl5US9qL3Nhb2U1aHcyWG4yb05KWno4UzExZ000S1JrK1JoVGg5b2JO?=
 =?utf-8?B?M1UrTDVRSnl3TFpIWkI2UVJLYzN2TE03MUMyOG5obXoxdTBlRUxsMnEwQVVo?=
 =?utf-8?B?WG0yMjQ4U2RCekg5K1ptN05ob0xoWFhDMC9Fa1hxeGV6Z3N0SkhLNTNCa1lo?=
 =?utf-8?B?d3NMRzNjNkR3cUUyVVJ2VjVvMXpyMlhhaEdicUEva3BNRVMrKzJGOEdxSkVW?=
 =?utf-8?B?WDlLcEVCazJBTWlmdm1WcFd0MDJNUHNTSHVsdnZuZkpxUTdWbExQSFVIQzg0?=
 =?utf-8?B?WlBpZWRiV2FYaklUeHlsNjhFL2lTemIyWjd1cFFjN2NuakJVeGtTekVIUDFq?=
 =?utf-8?B?VEhtblJFMGVBNTAzZXIxSC8zdlRKWnJnZ0JWRDZON0ZINVp6SDlJV2FSNk95?=
 =?utf-8?B?VWhJTWRiTVNjSnZTVm9aSWszbTVMZll6Rkx1em1YMitUTmhaemZ6aHVvdHdk?=
 =?utf-8?B?YTdzK2xPbllXc1Bwb054OGUwS01hcVR4Q2FOaXNWbDZJd05Mbk1rUS9Hclp4?=
 =?utf-8?B?TmpXdDJMOHpiek1YMUVFRzFIWVd3bzJGZWFrTVE2VlBrRmtzR0xKR3o4SXhi?=
 =?utf-8?B?TmlqMnl3N2RlV3BYWWNqaGRqUFd1aDZxQlRoU0luMkVsOWptR2RxVFFoWjcx?=
 =?utf-8?B?ZGVuaFhoOVAxQVA4ZE96RDZBOWhLMXFmdWxUOWE1OE1NMklPdGpIdlp6K1VO?=
 =?utf-8?B?c2ZRSHRjelNNU3ZuTjlpVHRrQmRpYWpDZXRKdVo5aElFZEUzOGRZOTU4Z2RJ?=
 =?utf-8?B?QXJ5U2JjbHF1VXV2L2plS2NwdU9oQkIwMXVQaHo5RVlVWlZrYUtVcHI2eksv?=
 =?utf-8?B?TjZXb3BpWjRLT1JuZk5pYmpLVE5yWWtvbzBnV0dRTzE2aHorYnEzbW5iYktE?=
 =?utf-8?B?RnV3OXA1QlA0dC9vTFlaa1N0Nm04OEppSDFqV2txNjB5Z0lwZ2dwVDl1LzQ2?=
 =?utf-8?B?cFdaVWRSUlk4QVczODdCeXE3WUVQbmxEZzJYQnpMU0g0eHZJZ0dPNzJXaWlI?=
 =?utf-8?Q?RhFQtwENxN2d0nZNd6TxrEISF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 839cf05d-9446-47d1-9fd5-08dd6212a641
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 09:37:19.8608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/aYFebUdub5nMLKrkhoHM6pF4UzQYJM2acDYHG8b1XxI9kJ1dyDs06fAZEmmRbR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7755



On 12-03-2025 16:24, Krzysztof Kozlowski wrote:
> On 12/03/2025 10:54, Nipun Gupta wrote:
>> +
>>   SILICON LABS WIRELESS DRIVERS (for WFxxx series)
>>   M:	Jérôme Pouiller <jerome.pouiller@silabs.com>
>>   S:	Supported
>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>> index 56bc72c7ce4a..8c5c72c540a6 100644
>> --- a/drivers/misc/Kconfig
>> +++ b/drivers/misc/Kconfig
>> @@ -632,6 +632,12 @@ config MCHP_LAN966X_PCI
>>   	    - lan966x-miim (MDIO_MSCC_MIIM)
>>   	    - lan966x-switch (LAN966X_SWITCH)
>>
>> +config SILEX_MPK
>> +	tristate "Silex MultiPK driver"
>> +	depends on OF
> 
> Why can't this be compile tested?

yes will add the COMPILE_TEST

> 
> Which arch uses it? Which hardware?

It is supported on ARM. Will add ARM64 as dependent. It is supported on 
AMD versal series devices.

> 
>> +	help
>> +	  Enable Silex MultiPK support
>> +
>>   source "drivers/misc/c2port/Kconfig"
>>   source "drivers/misc/eeprom/Kconfig"
>>   source "drivers/misc/cb710/Kconfig"
>> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
>> index 545aad06d088..456758b29f71 100644
>> --- a/drivers/misc/Makefile
>> +++ b/drivers/misc/Makefile
>> @@ -75,3 +75,4 @@ lan966x-pci-objs		:= lan966x_pci.o
>>   lan966x-pci-objs		+= lan966x_pci.dtbo.o
>>   obj-$(CONFIG_MCHP_LAN966X_PCI)	+= lan966x-pci.o
>>   obj-y				+= keba/
>> +obj-$(CONFIG_SILEX_MPK)		+= silex_mpk.o
>> diff --git a/drivers/misc/silex_mpk.c b/drivers/misc/silex_mpk.c
>> new file mode 100644
>> index 000000000000..e03579780761
>> --- /dev/null
>> +++ b/drivers/misc/silex_mpk.c
>> @@ -0,0 +1,860 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2018-2021 Silex Insight sa
>> + * Copyright (c) 2018-2021 Beerten Engineering scs
>> + * Copyright (c) 2025 Advanced Micro Devices, Inc.
>> + */
>> +
>> +#include <linux/version.h>
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/device.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/slab.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/of.h>
> 
> Drop, won't be needed.
> 
>> +#include <linux/of_platform.h>
> 
> Where do you use it?
> 
> 
>> +#include <linux/of_address.h>
> 
> Where do you use it?

Sure will drop unused include files.

> 
>> +#include <linux/cdev.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/io.h>
>> +#include <linux/idr.h>
>> +#include <linux/atomic.h>
>> +#include <linux/delay.h>
>> +#include <linux/eventfd.h>
>> +#include <linux/kthread.h>
>> +#include <linux/sched/signal.h>
>> +#include <linux/bitops.h>
>> +#include <uapi/linux/eventpoll.h>
>> +#include <uapi/misc/silex_mpk.h>
>> +
>> +#include "silex_mpk_defs.h"
> 
> 
> ...
> 
>> +
>> +static int multipk_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct multipk_dev *mpkdev;
>> +	struct resource *memres;
>> +	int irq, ret;
>> +
>> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	mpkdev = devm_kzalloc(dev, sizeof(*mpkdev), GFP_KERNEL);
>> +	if (!mpkdev)
>> +		return -ENOMEM;
>> +	mpkdev->dev = dev;
>> +
>> +	memres = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	mpkdev->regs = devm_ioremap_resource(dev, memres);
> 
> Use wrapper for both.
> 
> 
>> +	if (IS_ERR(mpkdev->regs))
>> +		return PTR_ERR(mpkdev->regs);
>> +	mpkdev->regsphys = memres->start;
>> +	memres = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>> +	mpkdev->dbrg_regs = devm_ioremap_resource(dev, memres);
> 
> Use wrapper for both.

Will add a wrapper function.

> 
> 
>> +	if (IS_ERR(mpkdev->dbrg_regs))
>> +		return PTR_ERR(mpkdev->dbrg_regs);
>> +	mpkdev->dbrg_regsphys = memres->start;
>> +	platform_set_drvdata(pdev, mpkdev);
>> +
>> +	/* Only a single IRQ is supported */
>> +	if (platform_irq_count(pdev) != 1)
>> +		return -ENODEV;
>> +
>> +	irq = platform_get_irq(pdev, 0);
>> +	if (irq < 0)
>> +		return -ENODEV;
>> +
>> +	return multipk_create_device(mpkdev, dev, irq);
>> +}
>> +
>> +static void multipk_remove(struct platform_device *pdev)
>> +{
>> +	struct multipk_dev *mpkdev = platform_get_drvdata(pdev);
>> +
>> +	multipk_remove_device(mpkdev);
>> +}
>> +
>> +static const struct of_device_id multipk_match[] = {
>> +	{ .compatible = "multipk" },
> 
> NAK, you do not have such compatible.

I will update to use xlnx/multipk as per the device tree (and yaml)

> 
>> +	{ },
>> +};
>> +
>> +static struct platform_driver multipk_pdrv = {
>> +	.probe = multipk_probe,
>> +	.remove = multipk_remove,
>> +	.driver = {
>> +		.name = DRIVER_NAME,
>> +		.of_match_table = of_match_ptr(multipk_match),
> 
> Drop of_match_ptr, you have warnings here.

Sure will drop.

> 
>> +	},
>> +};
>> +
>> +static int __init multipk_init(void)
>> +{
>> +	dev_t devt;
>> +	int ret;
>> +
>> +	multipk_class = class_create("multipk");
>> +	if (IS_ERR(multipk_class)) {
>> +		ret = PTR_ERR(multipk_class);
>> +		pr_err("can't register class\n");
>> +		goto err;
>> +	}
>> +	ret = alloc_chrdev_region(&devt, 0, MULTIPK_MAX_DEVICES, "multipk");
>> +	if (ret) {
>> +		pr_err("can't register character device\n");
>> +		goto err_class;
>> +	}
>> +	multipk_major = MAJOR(devt);
>> +	multipk_minor = MINOR(devt);
>> +
>> +	ret = platform_driver_register(&multipk_pdrv);
>> +	if (ret) {
>> +		pr_err("can't register platform driver\n");
>> +		goto err_unchr;
>> +	}
>> +
>> +	return 0;
>> +err_unchr:
>> +	unregister_chrdev_region(devt, MULTIPK_MAX_DEVICES);
>> +err_class:
>> +	class_destroy(multipk_class);
>> +err:
>> +	return ret;
>> +}
>> +
>> +static void __exit multipk_exit(void)
>> +{
>> +	platform_driver_unregister(&multipk_pdrv);
>> +
>> +	unregister_chrdev_region(MKDEV(multipk_major, 0), MULTIPK_MAX_DEVICES);
>> +
>> +	class_destroy(multipk_class);
>> +}
>> +
>> +module_init(multipk_init);
>> +module_exit(multipk_exit);
> 
> I don't understand why loading a standard driver creates all this on my
> device.

Will move it to probe rather than driver init.

> 
>> +
>> +MODULE_DESCRIPTION("Driver for Silex Multipk Asymmetric crypto accelerator");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_ALIAS("platform:" DRIVER_NAME);
> Drop

Okay.

Thanks,
Nipun

> 
> Best regards,
> Krzysztof

