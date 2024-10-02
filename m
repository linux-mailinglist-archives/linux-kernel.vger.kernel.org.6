Return-Path: <linux-kernel+bounces-347338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE9198D150
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39935B22DED
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602751E6DC6;
	Wed,  2 Oct 2024 10:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vlgdtC28"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29451E6DE9;
	Wed,  2 Oct 2024 10:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727865125; cv=fail; b=heguvGXuIJapw497CMH9D6mNLeEO/GtNeP/mM678OwjhG6G6cnEdzWRHY5UrVaEs63tx4fdyvuS9ycNhc9nDxwepgquTPBOnLJLlGwV28VfQ6F6C7QSeZ0mjsLbePMzm+1ykKfdzQMf3deT+b6mMbwaROHZGapAMBohIuN0ImBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727865125; c=relaxed/simple;
	bh=DJKBk9BIEZtcQa5bmXD9KJ15YbdHwRzIPgDwP6uSPQo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XPIsO6N8GF1pNRskz8CGeC3cxgN/I3+cXpW5sRhkCmP+ElSQw54wNOlqil79ls+JB5UjKby1KOHCXCUy18AfdR6B/HRlJGZMIWu+Q+sXHkSG+gV6ezhxvHQzL75+m2UeHSQFEWKuY13uVSBJnFNdsEY1HTScCLDYH/UAU84Us2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vlgdtC28; arc=fail smtp.client-ip=40.107.236.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PmsX3y6eIBSJByC1dAd7g2tY/sMo9BsW3qXfbI+vsp6TwYXrP978DFETsxp/+Cgid9edDC7XW7ALfzwX6aXv+qBfViNevQ7YP6xp3syJ8uowx0YUQWoRPjPGLxn6Fol5SFqZlXc1vBeqjHq6v+ssJRN3AWM1nmwaJlt3zkT+hg9600v3eZG210q+pttUeOMZyqQml80lA/CWBflb6CY3YGMjZGDqCU2JYyV9XBJgDE00qxJYdaKGgMM+OjiAQPIiuBmETgUeCpxnT4CqQQN88EIWIARSmt7MDvFssgW+64b0051mQMmjNf1FJkQ9CyrrM81/3gII0SU6JKrdUGTOog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1j/M/+9HyTQdlcFzrOdW8ux9WExGhncNcmwx9q2GvyQ=;
 b=qssQYZptf/UfH4o1axys2n0I3JymQQmvA8tuyruFBDzEyTXpXVU1qWzvJ3NcSc2Ck4ELp3SqRz8ED7ap2Ik4bQElwt6omZ8ArM7zgKHDKUBgwe1ViJYH+zQGvpwsqjgkAwery5TYIeSatp/TCXWL76D6c96AiaqTlLGBWKOlvsoCr+ayRnGBManb0Nyk/uCdVKaQfRw5brhdjHixfKuuS06OYmspmQPlCLNqCuaFxyc3y+8VRBXsr/U0zax+xx0aQk4gsRnN5aLDI33QsnBIKz45e4LBl7LzZkOS6fzwXClPPfx/SNCNpEc9qRuK9EvwIzgVzxO4fTjYHwJcekKx4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1j/M/+9HyTQdlcFzrOdW8ux9WExGhncNcmwx9q2GvyQ=;
 b=vlgdtC28Bhfte3WNSrlFXJ4EpbE5sRLX2x78XnKSVoYCWm9BpFFUVdukAzmQ1teqwhOA6TFbaHDT5/tagUoQoNAoD5ZvrRhMlO04oOni15xm+uveI46EOF2nHcN5CBcAicaosX1HOhHGBVVbcMUZZMJmoq8p9D1ZNcKc/+Dyf8c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS7PR12MB5861.namprd12.prod.outlook.com (2603:10b6:8:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Wed, 2 Oct
 2024 10:32:00 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 10:32:00 +0000
Message-ID: <7695cae2-33a3-4879-b8e5-d296d81ffece@amd.com>
Date: Wed, 2 Oct 2024 12:31:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: clock: si5351: Make compatible string
 required property
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
 monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
References: <b4b626c85ef3f75a0de936c818b2fff389e92c6d.1727855465.git.michal.simek@amd.com>
 <fa249ec7-409f-4dee-b853-736c5de464be@kernel.org>
 <74e07428-2ed4-47e2-a8ef-360df0252e17@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <74e07428-2ed4-47e2-a8ef-360df0252e17@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0070.eurprd03.prod.outlook.com
 (2603:10a6:803:50::41) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS7PR12MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: d797a022-3b55-467b-a203-08dce2cd72d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azVHa08zbnA2WXNLeXVZL3QwNE5OUVlEREZ4Ni9yWldOQWh1RittZkwycy9K?=
 =?utf-8?B?bFlJN01yOUFIMk1vRytheUlLRVBOMWxBOGk3WHJzVlUxUmJLVWY5MVFoL29E?=
 =?utf-8?B?YkpoZ21UUHJXd3NGek4vY1NRNnQ5WDcybXNYRW1vWldLV2lyS29kSkFhdW5w?=
 =?utf-8?B?d3JndmJOeHFXVkswdGtKcGxnbi9TM0hDR1ovcHJCbHhNdmpSalZON2lkbGJN?=
 =?utf-8?B?Mk9XTTdUa2Nqb1dCTFArN01uZWVLV1IvaEIwTFFMSVM3TGxydFFtRmw0NHlU?=
 =?utf-8?B?RUkwNTBCSjh1SjVQWUU1L3lKSkdwZXRvbXhUZ053bFZ0UmFjRVpWWkEvcjlH?=
 =?utf-8?B?U1NlanRndklRSDdQNlhMakhQYVAzZUpOSXFOaERHN0xtWDI2UDRTb1Jybjc5?=
 =?utf-8?B?WjVlZjNWQnZsWHpENSsyUXkxQnBuQm9scyszemJsaUZzeXhlN3MxQVEvby9X?=
 =?utf-8?B?UzBZNFRNTnVpcWRKWE1ERkhZemN2Vnk3NnZPSmdEaytBTDJXeXBoK3A2Qkk2?=
 =?utf-8?B?VkU3WTl6VUk3VmxlUndCMGR6ZEdRMGRIdmpJL2J4WmovZ094bGN1S3k5d3hS?=
 =?utf-8?B?K083TDVYUEhEVkxNQ3grQ2UycmZBNjMzUzIwYkV3RlNiVWNad1d3SUdTYWVJ?=
 =?utf-8?B?SmNPUk9HcFNSSXhxZ0F1WTcvaC9aZUF0MUpISS9GNjlSWE5mZjh4MEhRdC9S?=
 =?utf-8?B?WVBaTGpLbGJYaThnT3JJWG9MSHhzRzE2cHN6eDFhazdESDd2dGN4Q1pJUmdI?=
 =?utf-8?B?UXRUOEQrMTZFQlNRS3NkSnVXU204SjNYZkF5TFFxWTdyaElJVnZ6b09pNjg2?=
 =?utf-8?B?R005NURmeWtyYmRXV1hzdmJ0SFBQMW0rZ1hlaVhDSGduZU5BMTdwdDZ6K2gy?=
 =?utf-8?B?aWlFcWJaLzdRbkNseVJ3YjRLUlgwZmpBZzF6NHVETElWR0lSaUJnTTVYWGEr?=
 =?utf-8?B?QTZCZTJWeFJBRUM5dzZJcExYTUkvMmdHVVRNMFpPNHBocXZxMEdGVGxoZ1pi?=
 =?utf-8?B?U0NFWENtRWM1cWlMY2RwbVgrUnp3R29Ba3hrNkQ1VkozNDdtNzVlZFBPL1NM?=
 =?utf-8?B?VmRBZzJyYTNrNTg1cXRBOXlmdzd5UnQ0VHluck5SMkJlMGRlQm00VUs5Q0d4?=
 =?utf-8?B?N0srdVdtUGVwRkdJY1VaT084bFUvZkVPYlVETGQwelRBYnhFa250NnRwVVZm?=
 =?utf-8?B?ODIxaGtVbzFTLzFGT3V6MUI3c3BrTUYyWWdvMTlRSTduODNsUXZpakNKWFJk?=
 =?utf-8?B?KzJKN25YaCt0MlMxV1M3elRQSWx4NnM1V3BYUjlTM2RKSXVLNXpPcGU1WUN4?=
 =?utf-8?B?VHBDS3JtdDZVRHJoL1d0bHAwbnRnN2prY1BaUXl3aERXeHQyRVlLZG9FYm9V?=
 =?utf-8?B?VXpuVzJURVpMdlpCY1ZoZmljZ2dOV3ZMb2J5amhSYnFnVzd3blhoeVRpM0RP?=
 =?utf-8?B?Mk43K0pQdGtjZm1WRSs2c3diYVJSSkdHcXpWODNWMDZKT0NWVTI3TzlPNnk3?=
 =?utf-8?B?OFNQdUU3bGt6UzJRaTVrRm9lUUxTNit3ZitXdkl0R3BPRVpWT0FSTmxOVUdp?=
 =?utf-8?B?d20zdjA2c0FYekdqanpZY0Rmc3JUOVZTb00zNnJtSTJicVFjeFFhZU9CaU5u?=
 =?utf-8?B?VVJUUWV0b2pURTd0R1FGby9xMUs3MXduQi91VWNGWHFGdmRHTVd0YTd5SUdV?=
 =?utf-8?B?d0Q1bjBxMUFBK3hjTHpHL29VTXNnMVNrc01YbkQ0RHE4bXN3Ny9OdEpnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmQ5dm1oNmUwNUQvazNRMTVwbUVSM3Jlc3B0RThDYnAvenFpQWxMUG42SzlU?=
 =?utf-8?B?d0VEczBJS09NM0d5RElvZlU4STM5UDducC9QZ3k5UkFoWGpMSysxRkgxaVJT?=
 =?utf-8?B?bkZPbzRlRzRlRVdHUmZ5TmNycXJKOXlJSGVVVy9tZ2ZKUld6ODNPZEEraDNT?=
 =?utf-8?B?dldibGJkdFIxTVp5bHlma3dIUHF6WTRwTG9jcjhSZ1JUT0o4YnBsaktjdVVU?=
 =?utf-8?B?QWlZdSs2OExxU1d0YXNUeTBFMFRTQm9WNmMvQzB5elYraTk2dGlUdCtxZW5j?=
 =?utf-8?B?bUxiSTN0bFpKcHhkMG50Yjg1Z0dZdkgrTnU2eEY3TXRTcjBuUCtkcUVrSVdS?=
 =?utf-8?B?aURjK3l0aWIyM1RjaW92TmZYV0VCdFEvRFV4bWRoYktTZmozZmovdENSTlZP?=
 =?utf-8?B?RnJqSEovbnJhT3F6dm5YaTRjMEkxM3l2M2tOS3hoQnhkMXRGWDIzY0doVndP?=
 =?utf-8?B?TDhRUjFjS3lMS2JMOGpZVEFJME5UaU9BZldzSVNvQlcxNUJ5dWFUeWVFaHEr?=
 =?utf-8?B?L1VyTm5HZGVjcmJKbk8vU2crcWlwN2NjVnhYQW12cmhBVTg5S3BrZVZ1QzVh?=
 =?utf-8?B?TThGMUNSMFdzaWFXVm94WkNWeFlUeFRlc09WWjhSWU95RlBXVmg5ZGkzd3cy?=
 =?utf-8?B?Q0ZCUHFhbjBPbDY3STNzcnRhWGlZcmRoQ2w2TzJZWHIzQ2xtRjFQbHlVZG5z?=
 =?utf-8?B?SGJndVE4VTEwNDBjSzZVNWUyNm56WDR6RDJtUXVtVkxySksyMTRpOHV1aFov?=
 =?utf-8?B?R1MrSGhkNVduaGtuOUdPQWZJVk5wdUdmdEU0a1hUb0J4aGZqWUlISGo0VWZZ?=
 =?utf-8?B?MDFta0dvdVd0OURTUnNZcVpxaHpwcEtFanI0S3lreXgrWmxiZ2dGVWE1Sm1h?=
 =?utf-8?B?NTBYZEdWeUVST2pwSXBLazNpQjFTeDVXREt4NC9WS0U3T0NEb2t4SkNJQysr?=
 =?utf-8?B?eXV1OUtkam9tVTYvM1QyMWpkdUNvTTZiaUZHNDBlUXliMFJPTjN1bkQvMGtV?=
 =?utf-8?B?Nmk0TURPR081RXRYQ0k2UzhNV0JHMEhwek8xUC9GWlRPbWljRHM3ZHRWOEJQ?=
 =?utf-8?B?TURTSGtSanV5eTcvblRKdmxlQUd5Zy9sNVV4eURCZ1BON0tsMzh2OGRQTWJZ?=
 =?utf-8?B?LzEvdkJ6OElXR0RlWmFEejVoc2lzS0h1R2V0b211b1pJOEx4RjNEV1hNdUcx?=
 =?utf-8?B?bHZBWnJnbW1PYjlTT1d6cGlUbVlEQVM0Ty8wam9ydlcyQlA1b1hZR0o4dXpG?=
 =?utf-8?B?bEh2eTZNaGlISndvT0ZOa2E2cUxzRkMxenk4ZlgvcVkrYjlpTjgvTWw5OHh3?=
 =?utf-8?B?c1Y1MlRqYSt1NFVvUDZ4TVpDb0Nad3N4cTVGdjVoSjFYeEtaM2t3d0pDVmdw?=
 =?utf-8?B?UDNXRmpsVWNBWisyRmRPalhNUkF3Z3UxSzJLcC9EWGN3SURCWlhBRHJrSVM4?=
 =?utf-8?B?bjUyUkMzWjA1Y2NBQzBpdHdPTEE4TC83VnBzdTViQVNFNjNyQVJvTVNha2R5?=
 =?utf-8?B?OWd2M25JbUxDYW8rK2JNRXRoMVYvYXRTTlZKaVlIQmtQMTRDQ1loeFlOenhP?=
 =?utf-8?B?eEt1WDVac3JjN25Rd1laSGJpcEVWQzJjVFRYS3Z1NWpIU25HYTdGbkMrVTkz?=
 =?utf-8?B?VzhpejBNUFV2bndFUTRLM2dCa0VmM2tMYXVPejRUR2psMXVIOUpxNEs4UEY2?=
 =?utf-8?B?eXcwQzFQQnN6RWtLcXF5YllieE00TWloVFZxYmtiMHlQaXcrZ3FpdW1xekth?=
 =?utf-8?B?MXhpZjdIL2I4c2h0cVJqSmVRcXJDZjhhZ25QcnptRHBjZWttS2xMektpdG9L?=
 =?utf-8?B?aXh0YWdFSDZLTG0vdkJhcndLSWJEODVTNjBselpSRkhyWTZvenA1dEVMRmJM?=
 =?utf-8?B?NjZjRnc2RnVPdFVFTEJ2VVp0eUtDdE9BdmFuZW0rOSsvdDN4UHFYZngzQ3p6?=
 =?utf-8?B?NmNRYS9IS05jcTN2RW1JOEo2L2xxbFFhWUJnZkVCUHZWZFJSV2dtVDJ3OVV1?=
 =?utf-8?B?UnZuMG40VUVHbjZ6VzViemJrenJSVVpZeFBITEEzWTUvVm5obzlnbXFxclRV?=
 =?utf-8?B?eG9WNWh2UW4xamgwSFlydFdKTEpmelBWYTBoRUVrRWw1MXdNNUZoWWVzd2Fy?=
 =?utf-8?Q?02ss5HJw1g+ZJGIsYDDhAVfu0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d797a022-3b55-467b-a203-08dce2cd72d7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 10:32:00.4986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qWgOkC3UoczhdoIqyA1LopIgn9WDgFwH5ENvAFDjbbJ3ZuaplJr+9mcNnyOEtEPh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5861



On 10/2/24 10:24, Michal Simek wrote:
> 
> 
> On 10/2/24 10:19, Krzysztof Kozlowski wrote:
>> On 02/10/2024 09:51, Michal Simek wrote:
>>> Compatible property is likely also required property.
>>>
>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>> ---
>>
>> That's a convention but not necessary, a no-op.
> 
> But how do you identify device then?
> Or are you saying that device description is valid even if there is no 
> compatible string?

One more thing
commit 524dfbc4e9fc ("dt-bindings: clock: si5351: convert to yaml") is showing
that compatible property was required in txt file.

-Required properties:
-- compatible: shall be one of the following:
-       "silabs,si5351a" - Si5351a, QFN20 package
-       "silabs,si5351a-msop" - Si5351a, MSOP10 package

I can update commit message to describe it too.

M

