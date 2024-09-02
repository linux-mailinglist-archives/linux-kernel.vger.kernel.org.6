Return-Path: <linux-kernel+bounces-310679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC29F968001
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C0ECB2198B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A565F16EB4C;
	Mon,  2 Sep 2024 07:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wMXULs/t"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F9B155CAC
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725260842; cv=fail; b=KuQtguYU0nZEzZigw9/dQGXGSMvZxymSvnfyUMjuADirBIMYb/6+gWTBOZRRnVFJSiBPob8N+CwS3H+EHFcfblD1POanmncW+JdmPs+uN0ynwJEu8aFfJrbMF/Y4hY0qePtmB7O0U19e2M0mOuZqmbU/IwN4PCbNfRyIqS9AZ8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725260842; c=relaxed/simple;
	bh=2hS0fqokk4wYBg+azRg7BEGBHg+AWQ+vYUPRI4BoqMw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HrLPS43IJv3j//gIbHLjtai2TEM4scbmKrgtMAysFdlpOp/E6UWXxG8WAit3G3bDDz10LlVn1YtL6UiVl/wXtAp9BmJulxZxIV6pl2rQvst9LCZ8a+NyPq+zuv6RPQy1cbwdsOn2alEggUTgOXetk+1PxHml3qfFB20I4LPLgVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wMXULs/t; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHluEPx2PDsay1rl0sS2yLiy7I1F5RAptcgMAnlvuE/alOI4fNzVBb620yq8hHh8EqiU82YBd0/Ad5VeKtmwomvmft7yKn9BJay1eOkXmfciqZGicq5M5xamwzOnNCxj88cgQWpky4xbtoOZww+wwFewSir4WwxNBVG1CAk23AEBU0inulH+r5AECr0cxi/40ikw+I6pDBx4wP6VNs2/oRgFsBR+sdbakr8ALQS2wdgGTnM39F9FdtRraNz+cg07EpGsWpuacpWNftyWxMRp7X3KdPTqC5hWjuaAvxPrjIr8U+8hIdcj3sdu/QF2qqC8XygFYArpsF/I46/RNpxKjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/eeOCZKr35oU9iqJ5KTnaj1KbbD3+ibAYLJfKnm65g=;
 b=YHvWK6YzXQt4xnuHO/9bLIzUV6Ac/PaGueyWVawWpysFnQ23qAJvZ3dafGF1J9p7gJduMdEV+Gm9jnrr0P358mHIBd9z/VceilpUXed5sOThCcqXUEKiX5D2+0OX7JZJ0rQbsJW65YGBw/kEYbz68WcR61iFKtk95QgNk/R9VFykEHQryFCObvPuj3t15nB9Gh27YPSz/Wdz0eXiDYr4TyQ2QTDhvMcEXGfNYmcZ6MSwnFg3FgXSNxrY4+Jip+lLmv7y0/1muFuYUVuguKzzLxPX57Ab4jafwe78yyrNwnbEHgCoizLMmDl+s7B0bWgpLviFYvo32N+4PZixPkbdvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/eeOCZKr35oU9iqJ5KTnaj1KbbD3+ibAYLJfKnm65g=;
 b=wMXULs/tkLW6W64RrTKV7zqBuOcuy4JXsX1YXuNY7iCWY/s2mo6aT0jhKoenxn09i3Q2R9zl6pcMXxI3bsfi7/AcMeG9JHUv2HxDAYdwf/lmkcyEMDiRtKq+UF9W8LBvz0LoEq1uQTvh7qbKmb8CKY+/eN+0oTHYblpXSQ3Jm9A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS0PR12MB7993.namprd12.prod.outlook.com (2603:10b6:8:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 07:07:16 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 07:07:16 +0000
Message-ID: <41214edb-2011-4f96-84a3-d90f7970c4c8@amd.com>
Date: Mon, 2 Sep 2024 09:07:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] firmware: xilinx: Add missing debug firmware
 interfaces
To: Ronak Jain <ronak.jain@amd.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240730084342.1683231-1-ronak.jain@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240730084342.1683231-1-ronak.jain@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0159.eurprd07.prod.outlook.com
 (2603:10a6:802:16::46) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS0PR12MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: 589839c5-9af4-482b-d3e9-08dccb1de0e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlhFTWc0Ukdmb0x0NThqbW00cEtCYXV3cFd5eldZSHpBckxtZ2s1Tk1nUWEr?=
 =?utf-8?B?dEN2YUdUU1NGU3c5NFp1Kzh6K3NXMW54cDREeUh5R1Roc0tpSGN1dk8wWlcz?=
 =?utf-8?B?Q1lxdk1CcUthd1IycFA1RER5M0xRL0FFdWl3UjhUMTFZTlVqc0FCcEYzYnl6?=
 =?utf-8?B?eVZZMmRCMFhIU3dVYU5oMS9YYjBSckdBNncyWXY0cWc3ZVBXc0xnT1Y2WHpv?=
 =?utf-8?B?MkJvT056cUcvWmFCRWtTUzFSeCtNRlNvVjlEYksxNDViTkVCdU1VTnJzL0dU?=
 =?utf-8?B?dHhuZGt3SmZPWVE3YTd6VmNsaklqSFljTDk4d3IxMkRVUU43RU50Zk9TTy9G?=
 =?utf-8?B?K0hlYXVESlR4VGNmcUpFZ2JoNGZwZjBkK3VQUy9xTVJSOENBajNpSkFTa0FH?=
 =?utf-8?B?aHFYbjI1UjZCRzhWTmRUbFdDSXBycGlMaU5jdHQ5U0Z1WGt2bkZ0SGV2eDY3?=
 =?utf-8?B?d24wWE9oNG1vQ1Q4S3k1YnYwOFpZY1hKN0FYb21qdVR1QkRxYlBzTU9BVDhk?=
 =?utf-8?B?RHhxcndDOUQ5QnFhbXJWcFd4a3d4NDFnYy9rREdKYkplZUZxZlhxaVhIUzJM?=
 =?utf-8?B?Ymx0Y3NmQU04eGtvdXNMTzJoR2l2SnoxL0lNa3MrUE9kcEVyeVdEOGxTdm5W?=
 =?utf-8?B?M0lNekFOZGpnMmdzcDlaWjNEczNPNEhVbXBJc1gwanJMb3RxOXZqWmhSRzZs?=
 =?utf-8?B?K1hvQ2pEQzQ1a0ZlWTR6OEswQklxTTg0TkhYR1NtbUJKOWNadEQ2a3FxcktJ?=
 =?utf-8?B?aGtQMW1xNTBuYjNNbUh5UjRLYUY0NWVVVmtWcUNSbElyZE1tQWhML294YmZI?=
 =?utf-8?B?VHpybm1RRjQ2NEpVVDBNQ3VHWXVvSkRTNWg1WEd0MlFlZGNDSjJLMFdrYTVQ?=
 =?utf-8?B?NnZXOS96eFdsV3BkTHk3Q3VyMGlEODlubThUV3VFVVg3dERIcXVRYVM1VFFB?=
 =?utf-8?B?V21RUTExODBpV0IyckhpM1Z0WEtveUVFR2NrNjZybW5pQm1MMDFMcnE0dyt0?=
 =?utf-8?B?V1ZQOGx6SnpldWNmbnd4YVZYVkNGSFFxalJpYXlXd3kySkg0OXNvaUtoYkp1?=
 =?utf-8?B?UkxxRHNHY01MdGh0V0gvcExqRUU5R2pmVEkrN3oyZUIwYWc4V1ZSTDltNWVq?=
 =?utf-8?B?NWZHNVdESGVFclp0VThlLzdQUW9uUGl1NUZNbzdtV0pFTkxwWW9VckFQeXBu?=
 =?utf-8?B?RGU3VEwxMkJyVnZ2TDJPY0lUVTlKMGp0c1pDa1VWN3BRejQ3NUtKdytFV2li?=
 =?utf-8?B?Ly9iZE1tRWxYVU9iRUxETllMU1k1RmVKVmVHanN1b0oyeTRDc1dMYXhkSDBy?=
 =?utf-8?B?NFJpS3VQTjZNNllvN29pN0lMRVQyQUVMem94emxrajFFcTJLUWxqazk5eDhk?=
 =?utf-8?B?UDhBUjBuNEdKc1Z0VUUydWswOWdXUEhwLzdvL0pVaDFKZzlPbGp5VHV5R0Y3?=
 =?utf-8?B?UHNkcklYaklCMUVrd2tNendsMEJiYkdCTzVBSjdjMzVGUjJPekpiT2JhWmFu?=
 =?utf-8?B?cExmQnV1aG9QVkxTVmhmQ00vRHRNdDNRMWtoM2JHOWpiOUlmamh3dzllZTM1?=
 =?utf-8?B?UFllaXhkRUQ2aEtGQzFyTFcyZmd2Ri9DQ2IwaGlVRmQ3R0FobkdPbklmVnkw?=
 =?utf-8?B?R25Pem04REtucWdPOG5HZ1U5aGFQU2dJYno5bm93YjdjWUVhTVI5NjZucS9X?=
 =?utf-8?B?RFB5Z1Z3WEJabkFVaVN4ODB2dWpWL0t2NmU4eThHaGkwN243UUJOb0hjQWln?=
 =?utf-8?Q?cLE9YLZjWYaLb4WN7F2DtuVm18s2uLjx99Koc0w?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXFsWVE2cGFGS3IwWkM3eW1KVFNMSmx4N0hxV1FWR1VKNXNoenVzSW01bE5Y?=
 =?utf-8?B?YkFBdVVwdHZHVU50c3g4REN1c24wdXNNdlZCNWFvdmNSa0RRWTFnVFZiMXVE?=
 =?utf-8?B?aWNGZ3FkM1NYcEZ3Uy9NUkVSbkNTbnlNTWY3RFU2eHpYWnVVL2s1N21iWDJM?=
 =?utf-8?B?L0p1dmM1UzZzdURaSDJwRjJSY1RMM0xlSThPVkdmQ0tDVG9DVmN0WWwyYWl4?=
 =?utf-8?B?WElrcWRia2lJalYydUI3KzdFYnNXZ2tPOXpLQUdTWG1FVDM0QitkdCs0Rkky?=
 =?utf-8?B?M2RwaVl4eTFxQWt5ZEtRV3N3a3UyUFlzQnI5Z2tndTN5NCtlRGNHeVd0QWVJ?=
 =?utf-8?B?UWwrejRsTWc0QUlMeEJhSFNIYWUzckxEYUREbzhWbXVCanA1dk5jSlVNcFlr?=
 =?utf-8?B?a1h4aFpmSW9JNUszOUFDZHBlYnVBVHM0SkZpOHlBa011S1l0NWtrV1p5NTRE?=
 =?utf-8?B?ajBWUjV6dWJJK3ZJVWRyVHRYRUpjK2ZPRUgxTmlFVXZXT1czMlVtbWVqUVl0?=
 =?utf-8?B?REFwSm4vQzhNMlB6SEdLWXErZnY2Z3ZQK1dXaG8vK0V6Q3Z4Q1VCTG8waE14?=
 =?utf-8?B?S3ZqOCtSU2RJcGtUUTJETFRzOVlXWCtJZWdxeEk5c1Q4bzI4V2drS0lhSHlJ?=
 =?utf-8?B?ZXp1bGlZUC90dW1OcitmdG02ME9nV0grcFdXUnhYMW5uT3NGa3AraXhQN3Jl?=
 =?utf-8?B?UlNLMlhJeXQ5bmg4VWdQQmQvOU5vSnNyYjV3TitaclYzN1pRNnNTQnlqa2ZV?=
 =?utf-8?B?dzVKdW1yaGtLMXc1cHR4YUcxMVpOS2JNTlpuNHliZUZISHg1UHBLbWxTRys3?=
 =?utf-8?B?L2pGd1VyTzJLSlhzcU9Rd3N0dlFUUzlVUzNzK1JTdWc2aTk1d2xSL3FhUXF6?=
 =?utf-8?B?V3J3cG5aR2ZvdUF5NEZOTldaYVFkWExKZnZFVkp6THU5UzVXU1UwSDVaYUZz?=
 =?utf-8?B?UUIvRGhpMDJEYVYzOTcxbEEzUklWRkh0M3lYTWoxTmZuUDExMnErQjJkcHVm?=
 =?utf-8?B?VDk0d00yazBObzFET2h5aXNlYVl6ZUd6WGVTN2xzN3FkK0hCTkY3cUM1bk5L?=
 =?utf-8?B?Y1pLc2VDSkgzcCtZVUo1NmxVMmlLa3VoNFRtRnB3UXQ0cmVTeVpZSHQ5N2N4?=
 =?utf-8?B?T1lsdFdlaTFzZ2R0Wk9FNnF4NmdNbElGNEx6emlrUWlIY2dLMlNrMlFxYzY1?=
 =?utf-8?B?MFZ6L0FNVEltUzR0RXl0Zi9Xa3BKSWxXbnUvbWI4TTdEZGNDeEZub0FWTllj?=
 =?utf-8?B?all1UlpkUCtXWjBJTEJFdVhtMlpXQkk3ckN5QUg5K21lV2txT0RCM2J2emFY?=
 =?utf-8?B?ckpRZUs3alVKb0dJUEZtdWtsOXM0UllJckplTXk5Z0VMVDBRYXovdXhEcUNQ?=
 =?utf-8?B?a2hiaTArbXpTc1dlMVdzTHdkQmM3eUlTbHVrcFRMZUFudkN4c0dLUU9GSnhv?=
 =?utf-8?B?SVh5S1lTTmVrY1c5TFREN2pHM3puckNzUFRNZnFLZkVEdVBBWUdYQmdhUjVU?=
 =?utf-8?B?clpKT3l3RWY4ampYbUk3UWRycXk1aXV5czA4K1pweGN5bjkrRzhYMjZseTVG?=
 =?utf-8?B?QURRbHZIUFJHYkFnbC9HTzEvblhFM2FYYk1SVzhHSTNLTnVKb21CbVBlQlBx?=
 =?utf-8?B?WlpGSXgyS0hDbGpNUFg1YU50VnhkMlRrQ0dWMEJ6Rys4WUZBTzR1czBycDZp?=
 =?utf-8?B?V2ZLR3djNlVnODBCTERYNGszZE1WWS95NFVXQ2RiTFR2MWV2NE4xNFU4a2pX?=
 =?utf-8?B?b2E1NThucHYwN1Y4aVBCNndEYmsvREphTFBVNUx1alZFTXUzaU5BdWQrUFBN?=
 =?utf-8?B?eHdWMW1FQ0xIYTN4ZGVkRjBGZFRVb3lBcXhDWTBWNncxTU5QNWRNWG4ycTU4?=
 =?utf-8?B?Mnl5bDVxUEVvUDhZbmV5ZnR4dzYvc2h5aUdmUVBROVdSTm8zaThPTlV0Zlcx?=
 =?utf-8?B?Yk5YMXVOdXRQV1AxL1VQajlJazVsSVhTa3R2M1Q1ZHplRWhsMG1xWnh6TVBP?=
 =?utf-8?B?VjVud2g5T3MzeDMxK3lCdHpZNG9BODM4eXlWWkNNUlNTNThWSmE0UVJJQkEw?=
 =?utf-8?B?ZDBpUWlHbUpqclZKUVJXYkV4VFlYdUpsZWNqNUxIVVJ5U01tK3NXcFQ5QjFn?=
 =?utf-8?Q?otnwuFsr6n7+/Cvr7/GeYMVby?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 589839c5-9af4-482b-d3e9-08dccb1de0e6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 07:07:16.8434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zSSjhZJD88IMQw2/f7NmydGhWO24QbMNDhzYUZ5LpSg39mb5U3EPJc/nGRRezUfI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7993

Hi,

On 7/30/24 10:43, Ronak Jain wrote:
> Add missing PM EEMI APIs interface in debug firmware driver.
> 
> The debugfs firmware driver interface is intended for testing and
> debugging the EEMI APIs only. This interface does not contain any
> checking regarding improper usage, and the number, type and valid
> ranges of the arguments. This interface must be used with a lot of
> care. In fact, accessing this interface during normal PM operation
> will very likely cause unexpected problems.
> 
> The debugfs interface shouldn't be used in the production system and
> hence it is disabled by default in defconfig.
> 
> Signed-off-by: Ronak Jain <ronak.jain@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---
> Changes in v2:
> - Address the compilation error
> 
> References to the public documents who talks about the debugfs
> interface.
> https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18842232/Zynq+UltraScale+MPSoC+Power+Management+-+Linux+Kernel#ZynqUltraScale%EF%BC%8BMPSoCPowerManagement-LinuxKernel-Debugfs
> 
> https://docs.amd.com/r/en-US/ug1137-zynq-ultrascale-mpsoc-swdev/Debug-Interface
> ---
>   drivers/firmware/xilinx/zynqmp-debug.c | 162 ++++++++++++++++++++++++-
>   include/linux/firmware/xlnx-zynqmp.h   |   4 +
>   2 files changed, 165 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
> index 8528850af889..22853ae0efdf 100644
> --- a/drivers/firmware/xilinx/zynqmp-debug.c
> +++ b/drivers/firmware/xilinx/zynqmp-debug.c
> @@ -31,12 +31,50 @@ static char debugfs_buf[PAGE_SIZE];
>   
>   #define PM_API(id)		 {id, #id, strlen(#id)}
>   static struct pm_api_info pm_api_list[] = {
> +	PM_API(PM_FORCE_POWERDOWN),
> +	PM_API(PM_REQUEST_WAKEUP),
> +	PM_API(PM_SYSTEM_SHUTDOWN),
> +	PM_API(PM_REQUEST_NODE),
> +	PM_API(PM_RELEASE_NODE),
> +	PM_API(PM_SET_REQUIREMENT),
>   	PM_API(PM_GET_API_VERSION),
> +	PM_API(PM_REGISTER_NOTIFIER),
> +	PM_API(PM_RESET_ASSERT),
> +	PM_API(PM_RESET_GET_STATUS),
> +	PM_API(PM_GET_CHIPID),
> +	PM_API(PM_PINCTRL_SET_FUNCTION),
> +	PM_API(PM_PINCTRL_CONFIG_PARAM_GET),
> +	PM_API(PM_PINCTRL_CONFIG_PARAM_SET),
> +	PM_API(PM_IOCTL),
> +	PM_API(PM_CLOCK_ENABLE),
> +	PM_API(PM_CLOCK_DISABLE),
> +	PM_API(PM_CLOCK_GETSTATE),
> +	PM_API(PM_CLOCK_SETDIVIDER),
> +	PM_API(PM_CLOCK_GETDIVIDER),
> +	PM_API(PM_CLOCK_SETPARENT),
> +	PM_API(PM_CLOCK_GETPARENT),
>   	PM_API(PM_QUERY_DATA),
>   };
>   
>   static struct dentry *firmware_debugfs_root;
>   
> +/**
> + * zynqmp_pm_ioctl - PM IOCTL for device control and configs
> + * @node:	Node ID of the device
> + * @ioctl:	ID of the requested IOCTL
> + * @arg1:	Argument 1 of requested IOCTL call
> + * @arg2:	Argument 2 of requested IOCTL call
> + * @arg3:	Argument 3 of requested IOCTL call
> + * @out:	Returned output value
> + *
> + * Return:	Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_ioctl(const u32 node, const u32 ioctl, const u32 arg1,
> +			   const u32 arg2, const u32 arg3, u32 *out)
> +{
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, out, 5, node, ioctl, arg1, arg2, arg3);
> +}
> +
>   /**
>    * zynqmp_pm_argument_value() - Extract argument value from a PM-API request
>    * @arg:	Entered PM-API argument in string format
> @@ -95,6 +133,128 @@ static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
>   		sprintf(debugfs_buf, "PM-API Version = %d.%d\n",
>   			pm_api_version >> 16, pm_api_version & 0xffff);
>   		break;
> +	case PM_FORCE_POWERDOWN:
> +		ret = zynqmp_pm_force_pwrdwn(pm_api_arg[0],
> +					     pm_api_arg[1] ? pm_api_arg[1] :
> +					     ZYNQMP_PM_REQUEST_ACK_NO);
> +		break;
> +	case PM_REQUEST_WAKEUP:
> +		ret = zynqmp_pm_request_wake(pm_api_arg[0],
> +					     pm_api_arg[1], pm_api_arg[2],
> +					     pm_api_arg[3] ? pm_api_arg[3] :
> +					     ZYNQMP_PM_REQUEST_ACK_NO);
> +		break;
> +	case PM_SYSTEM_SHUTDOWN:
> +		ret = zynqmp_pm_system_shutdown(pm_api_arg[0], pm_api_arg[1]);
> +		break;
> +	case PM_REQUEST_NODE:
> +		ret = zynqmp_pm_request_node(pm_api_arg[0],
> +					     pm_api_arg[1] ? pm_api_arg[1] :
> +					     ZYNQMP_PM_CAPABILITY_ACCESS,
> +					     pm_api_arg[2] ? pm_api_arg[2] : 0,
> +					     pm_api_arg[3] ? pm_api_arg[3] :
> +					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> +		break;
> +	case PM_RELEASE_NODE:
> +		ret = zynqmp_pm_release_node(pm_api_arg[0]);
> +		break;
> +	case PM_SET_REQUIREMENT:
> +		ret = zynqmp_pm_set_requirement(pm_api_arg[0],
> +						pm_api_arg[1] ? pm_api_arg[1] :
> +						ZYNQMP_PM_CAPABILITY_CONTEXT,
> +						pm_api_arg[2] ?
> +						pm_api_arg[2] : 0,
> +						pm_api_arg[3] ? pm_api_arg[3] :
> +						ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> +		break;
> +	case PM_REGISTER_NOTIFIER:
> +		ret = zynqmp_pm_register_notifier(pm_api_arg[0],
> +						  pm_api_arg[1] ?
> +						  pm_api_arg[1] : 0,
> +						  pm_api_arg[2] ?
> +						  pm_api_arg[2] : 0,
> +						  pm_api_arg[3] ?
> +						  pm_api_arg[3] : 0);
> +		break;
> +	case PM_RESET_ASSERT:
> +		ret = zynqmp_pm_reset_assert(pm_api_arg[0], pm_api_arg[1]);
> +		break;
> +	case PM_RESET_GET_STATUS:
> +		ret = zynqmp_pm_reset_get_status(pm_api_arg[0], &pm_api_ret[0]);
> +		if (!ret)
> +			sprintf(debugfs_buf, "Reset status: %u\n",
> +				pm_api_ret[0]);
> +		break;
> +	case PM_GET_CHIPID:
> +		ret = zynqmp_pm_get_chipid(&pm_api_ret[0], &pm_api_ret[1]);
> +		if (!ret)
> +			sprintf(debugfs_buf, "Idcode: %#x, Version:%#x\n",
> +				pm_api_ret[0], pm_api_ret[1]);
> +		break;
> +	case PM_PINCTRL_SET_FUNCTION:
> +		ret = zynqmp_pm_pinctrl_set_function(pm_api_arg[0],
> +						     pm_api_arg[1]);
> +		break;
> +	case PM_PINCTRL_CONFIG_PARAM_GET:
> +		ret = zynqmp_pm_pinctrl_get_config(pm_api_arg[0], pm_api_arg[1],
> +						   &pm_api_ret[0]);
> +		if (!ret)
> +			sprintf(debugfs_buf,
> +				"Pin: %llu, Param: %llu, Value: %u\n",
> +				pm_api_arg[0], pm_api_arg[1],
> +				pm_api_ret[0]);
> +		break;
> +	case PM_PINCTRL_CONFIG_PARAM_SET:
> +		ret = zynqmp_pm_pinctrl_set_config(pm_api_arg[0],
> +						   pm_api_arg[1],
> +						   pm_api_arg[2]);
> +		break;
> +	case PM_IOCTL:
> +		ret = zynqmp_pm_ioctl(pm_api_arg[0], pm_api_arg[1],
> +				      pm_api_arg[2], pm_api_arg[3],
> +				      pm_api_arg[4], &pm_api_ret[0]);
> +		if (!ret && (pm_api_arg[1] == IOCTL_GET_RPU_OPER_MODE ||
> +			     pm_api_arg[1] == IOCTL_GET_PLL_FRAC_MODE ||
> +			     pm_api_arg[1] == IOCTL_GET_PLL_FRAC_DATA ||
> +			     pm_api_arg[1] == IOCTL_READ_GGS ||
> +			     pm_api_arg[1] == IOCTL_READ_PGGS ||
> +			     pm_api_arg[1] == IOCTL_READ_REG))
> +			sprintf(debugfs_buf, "IOCTL return value: %u\n",
> +				pm_api_ret[1]);
> +		if (!ret && pm_api_arg[1] == IOCTL_GET_QOS)
> +			sprintf(debugfs_buf, "Default QoS: %u\nCurrent QoS: %u\n",
> +				pm_api_ret[1], pm_api_ret[2]);
> +		break;
> +	case PM_CLOCK_ENABLE:
> +		ret = zynqmp_pm_clock_enable(pm_api_arg[0]);
> +		break;
> +	case PM_CLOCK_DISABLE:
> +		ret = zynqmp_pm_clock_disable(pm_api_arg[0]);
> +		break;
> +	case PM_CLOCK_GETSTATE:
> +		ret = zynqmp_pm_clock_getstate(pm_api_arg[0], &pm_api_ret[0]);
> +		if (!ret)
> +			sprintf(debugfs_buf, "Clock state: %u\n",
> +				pm_api_ret[0]);
> +		break;
> +	case PM_CLOCK_SETDIVIDER:
> +		ret = zynqmp_pm_clock_setdivider(pm_api_arg[0], pm_api_arg[1]);
> +		break;
> +	case PM_CLOCK_GETDIVIDER:
> +		ret = zynqmp_pm_clock_getdivider(pm_api_arg[0], &pm_api_ret[0]);
> +		if (!ret)
> +			sprintf(debugfs_buf, "Divider Value: %d\n",
> +				pm_api_ret[0]);
> +		break;
> +	case PM_CLOCK_SETPARENT:
> +		ret = zynqmp_pm_clock_setparent(pm_api_arg[0], pm_api_arg[1]);
> +		break;
> +	case PM_CLOCK_GETPARENT:
> +		ret = zynqmp_pm_clock_getparent(pm_api_arg[0], &pm_api_ret[0]);
> +		if (!ret)
> +			sprintf(debugfs_buf,
> +				"Clock parent Index: %u\n", pm_api_ret[0]);
> +		break;
>   	case PM_QUERY_DATA:
>   		qdata.qid = pm_api_arg[0];
>   		qdata.arg1 = pm_api_arg[1];
> @@ -150,7 +310,7 @@ static ssize_t zynqmp_pm_debugfs_api_write(struct file *file,
>   	char *kern_buff, *tmp_buff;
>   	char *pm_api_req;
>   	u32 pm_id = 0;
> -	u64 pm_api_arg[4] = {0, 0, 0, 0};
> +	u64 pm_api_arg[5] = {0, 0, 0, 0, 0};
>   	/* Return values from PM APIs calls */
>   	u32 pm_api_ret[4] = {0, 0, 0, 0};
>   
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index d7d07afc0532..563382cf16f2 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -218,9 +218,13 @@ enum pm_ioctl_id {
>   	/* Runtime feature configuration */
>   	IOCTL_SET_FEATURE_CONFIG = 26,
>   	IOCTL_GET_FEATURE_CONFIG = 27,
> +	/* IOCTL for Secure Read/Write Interface */
> +	IOCTL_READ_REG = 28,
>   	/* Dynamic SD/GEM configuration */
>   	IOCTL_SET_SD_CONFIG = 30,
>   	IOCTL_SET_GEM_CONFIG = 31,
> +	/* IOCTL to get default/current QoS */
> +	IOCTL_GET_QOS = 34,
>   };
>   
>   enum pm_query_id {

Applied.
M

