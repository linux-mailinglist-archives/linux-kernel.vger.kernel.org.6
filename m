Return-Path: <linux-kernel+bounces-347157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5917C98CEBB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9B161F20C92
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 08:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC94194C89;
	Wed,  2 Oct 2024 08:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f/ZDMWX8"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8295E81AD7;
	Wed,  2 Oct 2024 08:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727857498; cv=fail; b=tJ1Ek6Kdx+KmArwiEVrfGJagYGiEgZGnSeoJWenBmraAgxykuGe7DbCS4FhcLXQiik0iPPGiRnfZ9r4ELcBhWO6SBLTIPhNRSOtWX+GkNYP085qe1KhlG6UN3k8EXLWp18w1ziiNrfpPmwkRpTYAZY0ApwpbvgPTqrHeLvz5Uss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727857498; c=relaxed/simple;
	bh=h9ibT268yCFqZKuC54ed/I9n2eQxHLtWwOZIjSCTI4c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V7Dr1Tojjvf4o0X2toovaUe3YxEkqTJRy5jbAkoC7EEE6IfltpFR0utDMytP6caHM/Xy4rn8dWN0JXIVMq7Ov4LvrI72NdrA5AuTMtc2aQDZZAyQiNd3rb5fZ+VeDFUPD7PWIshYMqpSDhw2C3/68ATABQrdS7h8vjfKz8V/K6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f/ZDMWX8; arc=fail smtp.client-ip=40.107.100.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBX16J/uE7pMv5UXkMXFJjbV57YcoI7Y4ZaruCyHOIXN5pm1Ck0P0PU5N3DqwUWBU6L2fhLAW2lvxQnavVxtDh7E/C8dtYGkv4Kyp6looFCP+WT3B9KhMK8ouya/ia6yAwqwP0CzoAK3gItYE5sz7gHE4Lmj2CV3h/93bPRDdrPAr8OknjssgPViAs/nCwCFs2kmcJz0zTMqzrfBJ4g2lEF2dnheuMp5kNpzzoJrQFvZPfU92RJw2HCvoq2kxKoZbJQbdtnMj7SmqiB8w3VBAWiYGCNBcdMYQrVjB1GDWpBaPkmcXfkg8n5HNRzyufX4o5RNlnNe4Xql6WCt34i+CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpJpnsP4FihPo2QkFPXkgtaTFD7zVWHRjqyADZV1ngQ=;
 b=w1BNijct6mrd7LhgJRyeuT4oJYKT3jegzThCEjvQVVaYPj5BbU6kCCSOLO++5mSCIOOlQ+g1lW0euTW9/xAjOiTLtl1oLznsdZlZ8RyzrEh8RzrGtFKb+L1gi745eLYmZUTT8Azx0M6z+BzZTJhZjziWlrVUyUUV7So09LVQCeTmdA5b/1el9sP+6iXjk8tuFyjY5CpFms92KrAWudvdkk9XWOCpUv8B0bnJtMSVqb70G1ha0aEDvkY2CwmgVnMhumO0q1tFlokGJVTBvS0bzfEB5DHY4GzX9MNrTFz9ekojK6l1+DW/S5g1yb8HcwUopymB4yKFohpN6v2EunqICA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpJpnsP4FihPo2QkFPXkgtaTFD7zVWHRjqyADZV1ngQ=;
 b=f/ZDMWX8cJSK9pwFlCsLuehDFrrs/XRBjC8KXknM+csYJIiuSsFy69C/KYRV1xL86O6W0pNBQpxIlrUJ0Odj7CNKr9AL8VYudFOp1tvEGTpmQX4OVxN+Sa106zPNz1qZgNOcuSV7xG9tqFXKYJvnyhTAgR35gU0cnbBZpnkMMyk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM4PR12MB6590.namprd12.prod.outlook.com (2603:10b6:8:8f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Wed, 2 Oct
 2024 08:24:53 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 08:24:53 +0000
Message-ID: <74e07428-2ed4-47e2-a8ef-360df0252e17@amd.com>
Date: Wed, 2 Oct 2024 10:24:39 +0200
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
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <fa249ec7-409f-4dee-b853-736c5de464be@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0223.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::6) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM4PR12MB6590:EE_
X-MS-Office365-Filtering-Correlation-Id: 275667a3-c7fb-4f0a-4976-08dce2bbb0a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1JyWm1TNlczY0gyd2Q4TVE1V01Oc3lZU2dJcllnWmRudng4R3ZMTTlmYm1V?=
 =?utf-8?B?T014VzBnZ0RiaUFkbDRzdDlGczI3Sit0QzdNci9JdUNXMFI4QjZ4aVJrR3VD?=
 =?utf-8?B?Y1p3TkZwb1M0QXZhV1JRMXNIOWI2UitYYU5KMGJJZEV3bDcycTdUYklrUmhT?=
 =?utf-8?B?bnpwdVRmZVJCbEJhUUR6V2ZYMWZHOHNUTmRHT29wTkxKRDFnejM4RVExNFBC?=
 =?utf-8?B?SFZidk5VZCsrTzYzclh6NW1KM1ZieHZiQTJ6L3dnTTFCUUE5K0FUS0xvUHZ2?=
 =?utf-8?B?Tk5jMmlLY3ZuWVQxY2JqU0tSRlFNaFFaQkRPbjRUTngyYU9yZ0lKUnBKTSsr?=
 =?utf-8?B?TDRmZ1JOL2Q4MkU3UFU2M1djTUJ2L0hIRW5oakhobDhVQ2hiQk1GSkV0Sy9T?=
 =?utf-8?B?eExiYlpjYUlEbkY2THNvM3dJaE96UEJ2QmlYbGhtTGNFeXUvL0dVdGFIdlpS?=
 =?utf-8?B?ejRGR25UUm15bDJKdHJyWHlnRk9SYVB0RnFvK01pSlVlMW43MHY2SUJZUUYx?=
 =?utf-8?B?cnpXb29OZkE1WmE3TWVJaU4xWHRNczJpQkRrWVhra1EzSHovZldxUUpRWjVG?=
 =?utf-8?B?ck4wMkNtdXFBamQybEh6QUhFTW9HZHJYV09ZQWVhb0NTMXdQN3ZGb2YvcTBm?=
 =?utf-8?B?bzRDSVEzb1d3WEo1WEw0WkVsdXFLWXVWdTk5dkQ3UmFpbm9yQzVvYjVzWkZB?=
 =?utf-8?B?emlGc1ZWQ0RjSi9DSDNVd3BYaGtCa2lzaWUxMU9xWTJzUXJJaVJXUW5WU3Iw?=
 =?utf-8?B?RDFuTXo2Vm9pU010VGltTzdMT3Z6RUtyWnQzcHo5eFdzUE9Tc2tpaHBaOWht?=
 =?utf-8?B?emEwR3I2eEJtV1IwOGpEY1ZPZTRJZ0N4TzNET3g1S0lGVi93cDZJSElYZ0V4?=
 =?utf-8?B?UFVCdjFQY0RERnN3U0N0VG03UEpRR0YzRTZSWXlqUDZJVVJ3VWVYNXByaGIz?=
 =?utf-8?B?RlArRWhhcEZIandOVHhvbVdLQzlCamMvUUdlTjR0UEZiSEI5OE5raVRyVTVq?=
 =?utf-8?B?QXN4L3h0SG40VFVLYUYyaWJWa0xqa3hPbCtwekZxQk1vRkk4RGcvK0NKVGpH?=
 =?utf-8?B?RklsUVQyekdrQlNid1lzQy9XWWdKSUhxR1ZEUmVhZWQwRmxPNGFTd3NBZ0Fv?=
 =?utf-8?B?S2RLcFZmQUN1ajlidEM3ZGd1QzlacVJqR3UvMGZxRU1lRTJkV0JLVzIrbll4?=
 =?utf-8?B?YUROMDdJOWtuaEs0ZDhWVDVILzRDdnRvRVF3bGRNV29rVkp6ak96UzNEN2cx?=
 =?utf-8?B?VHdWMzZBSks4TE4rV2I0QkNTaVRlNmxrWmVxTUkyVHIyTUJLV2NiVUJSVXdv?=
 =?utf-8?B?aGxBQXJNZ0Z1Q1ZVc251QkIwYUo0Nnk3SkpNY29PcXluV0pxVzl2SnFVR1hU?=
 =?utf-8?B?RzRJTVl4MFZ2RXJSNy9jb091emIzZDg3NGFtNWlHR09TanRRVkZacmIwU2Q0?=
 =?utf-8?B?R2lTN0RzV0pQZXZMUDBrTjBUd25RTSswVE9KRFQ5cE5hWS95bCsxWjlXQURV?=
 =?utf-8?B?RTVpYkZBSjhPSFIvbzdHcGliTGJ3dXFDaXB3SWJMa1IzUjVtczdCWHhGcXZK?=
 =?utf-8?B?ZEYvb2pUU2Q3Z0VzSkFPaTlHb0xwYlN0OHp6c1hadmpWbjFMcWNlcDhOVEdm?=
 =?utf-8?B?WUZGejRrdm5JMXEzc0FlUmFrOFFwNXV6elBHeGJZcVBUMVdFRVBDOCttY2Zl?=
 =?utf-8?B?dE9jQThoK0RRTFhFZ0sxWXVyTXEzeE8xOG5QN1dPajY1Mm02Q1JsUEdRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OE1Nb3JCeTkzd2VuVmJ5SDVRV2Radk9TMnNDWnBRQXJBYlQ2SXFHdWcyVzhR?=
 =?utf-8?B?c2ZVaTJJN0wxbCtyQnlYS1ZIdWorSjZLZE11Ym1icXdRUWgxc2k5Um95czZV?=
 =?utf-8?B?NU9QTEFVZW5XbGtqektmVUFQTTRiRVd5VFpaNy95Q3lmMFJGcHlXaWN0bzc5?=
 =?utf-8?B?NjFON3VBUjZoNzBCUzBOTW5nL2w0WFBDU0hsQkgreERZM3F4SDd3V3NvaStM?=
 =?utf-8?B?dTdpejJlUzhob2RTWTI2c1hUUU1OeThaSkNoL0dKWlNRemRxZFJVNmJkaWVs?=
 =?utf-8?B?U3ExK21mbVBIMnJRK3pnMmRyS044QVcydW15dzNnRkQvQU5mc0RxaHRvTlhE?=
 =?utf-8?B?N0NNQ0FmMVh0TWpiei9wKzJoOGlZTFh6SjJtQmY0WjEwUVBzUjdzWm1JSkRy?=
 =?utf-8?B?ZkZWL0Zvd2tDRUJ6L2pOQWN3S21nbXZwdTMrRmw2OHNOa25YWDg5MmJGSGlJ?=
 =?utf-8?B?UlVnd2NwWDFKQlR2dGxsaTFSYTFZT3lkdlBKdFlsd1VOYU1xMVlNWVBjbXlZ?=
 =?utf-8?B?aFRuVlNNYWxJYTdSRWM2eVNSTUp4SGZ6UmRGM2huUmZZVmZ1S1lBNDFwMDc5?=
 =?utf-8?B?aTVlLzEvUEM4bStOd3o3TVJrWFJmekcwRkMvczZNejI3Q2dlSTlLU0xaRTZr?=
 =?utf-8?B?SDE4cW5IU3ZuZTMwOGZkdnFJN0pPczFhWmlnU2JBZmNHTUp5QXJwNEJYRWFs?=
 =?utf-8?B?cEQ3ZFkwcnB3U1drL1hVRmlLTUV2MERZMk1jT3hEU0NzNUs1emkrbzJlRm5C?=
 =?utf-8?B?dlVZVmtMVzB0R0JoaUxPVmVjSVR3ay9mTFVLbDFUM1BrR3pqWUwyUTBIbmhQ?=
 =?utf-8?B?WlZRZk9VT1RZMElmaHNudkNuZlcrazhKSGtUVSt5RWtacmVnUUwyOWdvSjh3?=
 =?utf-8?B?WHNjcVowYkt1MFhmNzJNcHBGODdpc0VwajdCK24ydGRCSkZPKzRLc0dJaEJJ?=
 =?utf-8?B?OGJzOUVNdzY4d2FnRzJWdFBoaG1tSWFTNTB2OWVGR3NoSmxRcGJmQ205Q2Rq?=
 =?utf-8?B?eTJVSzQ3ZEk2VjBzUmtQQUxOaXZ4b1RJVXJzaWVQbXROVWJyZExIdkU1WDE5?=
 =?utf-8?B?NUNCL09wSnFZZzh5cWFaUzNjTGlLQXJNZ1dDZXlhbWlrQ2xkMXFETUIwOEky?=
 =?utf-8?B?UlU1cGxhNHpXdHF6YmIrOGt0U0Q2QzdBeWFlQlFLV0hqTUZEaFJDUmhZODBE?=
 =?utf-8?B?eWhSUWh1RUU5NGthYk0zaWdPRklYdGZCR1V3RHVRU01QeTRmWGNVRzVSZDBW?=
 =?utf-8?B?eFg0ZTRnU1VvVzV2VXIxZGZuVDJjT0dzRnNJd1hJN1lBRTNjbHo3NGkxMS9X?=
 =?utf-8?B?RnhxNUJZM01sQWNGUVV1Q3laSm5wRFU3L0YxaE5kWXlFVHc3YTNUUnBjR1lz?=
 =?utf-8?B?aDJKQ0RDOTMxSm1zN2dOb2NJeHJjenBLSk9aVmlzY1V0dElSdGlFRFFDUHpo?=
 =?utf-8?B?L1p5QzFqdURuVVNSUmRJQnljMlNsVjBCNTBsNjJ3a1N0V2JNUjE4cE1yNHI4?=
 =?utf-8?B?L29QRnZqY2lRZnNLUGhoWW5pa0xOak1VWmN3QURvVWUvQXJVYXZEU1lVa21i?=
 =?utf-8?B?RVJoZWkreisyZ2tsTmp4VW1WMUkvU08wazl1SDVKc3RSaVNIUjdmT2V6NTFv?=
 =?utf-8?B?eWhMRXhLV3FmZ2lCNjVqZmpkWVNodnNlQjBSZWt4c0V3NmNCbk0yZ1RXbnQy?=
 =?utf-8?B?L3pSTjQvWFFHalVjV2Z4ZzFsRTB4UlpXOXZjTUduMjg2Q1ZXTW83UzZGUDFW?=
 =?utf-8?B?aVNtM0E1SnhTaGZmVVBVOXZXV1pjRHY1VFZ5UkRETVoxckhHRHMxd2p6aWYx?=
 =?utf-8?B?ejQ3bEYzR0VEL3YvN3dnbEdGdkQ0NUpBcmhYdlNHWEVKRmtaQ1hSdDN4akl6?=
 =?utf-8?B?MURyTFM0bmtRYXV1bGJPdGpCMTh6OXBWejRnbDd1Um5YM1EyaWFtclQyQTM2?=
 =?utf-8?B?QkxFSTZIdDhFcDJSWVBFVzV6b1VKWE1XN2FWOWFjSEZZcENMVEErYitNYmt1?=
 =?utf-8?B?ZWhXcnN6ektKRkJUMThKcEJ4Rnp4UllPRGJJOHRKMGUxTjgvUml3NmtMdFEr?=
 =?utf-8?B?cHV5V0R3SXA5NWpzVEdEZjh0dlI5aC94cS9uakdGK0tWMzIyL213WDR1dXI4?=
 =?utf-8?Q?6Caw9F3KAlDIpDh7kL821nIoE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 275667a3-c7fb-4f0a-4976-08dce2bbb0a1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 08:24:53.2092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /KxxzaH8OQ+2ooGPUEgwKZ2kkq8klH2/HJh36PmrPkRUrQLd7Trxe094rO8iEhKj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6590



On 10/2/24 10:19, Krzysztof Kozlowski wrote:
> On 02/10/2024 09:51, Michal Simek wrote:
>> Compatible property is likely also required property.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
> 
> That's a convention but not necessary, a no-op.

But how do you identify device then?
Or are you saying that device description is valid even if there is no 
compatible string?

M


