Return-Path: <linux-kernel+bounces-176784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F548C34D8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 03:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64A2CB210B4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 01:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F6E6AA1;
	Sun, 12 May 2024 01:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="goe3iAcP"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EA033C5;
	Sun, 12 May 2024 01:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715478230; cv=fail; b=GBk41C7wnVrZMtQgrbs97p/HWdBFZgjhaHD/ytBdqpR58R8rgK0m01pXdTU+nSqgKFPmQKYf12EJztMPtc7evJG0F6HOz9SPoMZ++6AXVh+ZYHSEBcrIj/YIcXqpyHl1zU6AKthH5d4uW9Cxz/JL/zZRQwJv4Nn5TSdyhL3kbO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715478230; c=relaxed/simple;
	bh=huUecDX/MzE7W6xu9KK6s6amCIYgvd4lR2XoYmPXXW0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t8/agOamS10CIMAnCNN5GSYq2fbHgx8TfceCZRO70RCdLAAcXwzjFOm/2AqUbPT0peRM3oSVl7l/u5Ow+32qJAPoXpzsLdoXc/aLZnxZW/S4JdXzrjNL0eO5kJxcstTo62sSw8X3jh1Na//uiKZTwza2ovRzP+GOawvprAai2bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=goe3iAcP; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7NRARyg048Ke0lq4fvOlrV7VUeQjS/ZYAVT2WdJNhyPahSUTO4nRwmdNDb2c7TVD4WkvQ0VarkdPs690K65FfNntgk5NxcCugD+Xv3eEOvpQ1TGXMBKbwpW0iwIjtY6kzh1mjaUNGRccpZ8/Cz4pgFFbi3/MeDAP/kQrPHLawR9Zad7glClyYydXYIxbJG4dz362WldM8b/L43uQPKC95aTcEpbHrZCbtvVu9PK6MNgafqsGfLEF0k+eS0oXhd9OZJdvoiSZiRwod4wm6bfh1De33aLO1MohtwTCNLK/6e6I4P2MHcwNUhWtgG+ev3JoWZx67MeahCVVtrNN9G1Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FH8fl6lllFN9J7iF4crxCJ73tV/m2Jn9tcCFWsHTzGA=;
 b=QkWKn9LHMnyfCuu2CuEHynhvFSheqJs6yrXqMaUO4IzhihM9vExZFJnND4wwT3MT+Yf0X6XOcaZLAiCF+hek6kZYtpqsIj0uY0+HeBDUm2ROpfhWFbHTgcnvVyZ7deFL8wDPvCzrpoG2GQRy5ERfuRpkTMmn87bkx+MP2RgGtxUBvW86+hBdF6vnGPQ29b2wiEv3LjvwCpLfM8UeWMpA20x/v1UMGHIiSJ4dT+RSr4PcPm7wCCGFQg4DN/02Zwcu2ihK6fQ2EBM0txSuAfje+vhysQejoR8OzJ4evnzF+BulEGEo3QP7EgJSq+udyI8DVVhs8XhVZvE+SPyDr8zLMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FH8fl6lllFN9J7iF4crxCJ73tV/m2Jn9tcCFWsHTzGA=;
 b=goe3iAcP3GtRHrydcGtowsdSW5spKnyWG2DzNFNQkHNOTPbEKwg7qfSl93WuFaUOma36PT1dZQAOhHs6G8He0wF+np3Ta7Rt7lelfL+bM0yjOag9/zQMDwHs+s77EZgkTKw8wd19x+e+GenvEIbRBrcyyA6Lpooz8Fmr7TYkTN8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6623.namprd12.prod.outlook.com (2603:10b6:930:41::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Sun, 12 May
 2024 01:43:44 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7544.052; Sun, 12 May 2024
 01:43:43 +0000
Message-ID: <9b652a48-4107-4b68-9aea-6cfdf1e0e4fa@amd.com>
Date: Sat, 11 May 2024 20:43:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] platform/x86: dell-laptop: Implement
 platform_profile
To: Lyndon Sanche <lsanche@lyndeno.ca>
Cc: pali@kernel.org, W_Armin@gmx.de, srinivas.pandruvada@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, lkp@intel.com, hdegoede@redhat.com,
 Yijun.Shen@dell.com, Matthew Garrett <mjg59@srcf.ucam.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Randy Dunlap
 <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
 Vegard Nossum <vegard.nossum@oracle.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dell.Client.Kernel@dell.com
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
 <20240511023726.7408-4-lsanche@lyndeno.ca>
 <9ba4a500-9d88-4630-bd94-99f07dd51abe@amd.com>
 <B3AA4333-03DC-47D6-9519-7FA9496220E5@lyndeno.ca>
 <48JCDS.E4RT1F9DTKFU1@lyndeno.ca>
Content-Language: en-US
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <48JCDS.E4RT1F9DTKFU1@lyndeno.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0322.namprd03.prod.outlook.com
 (2603:10b6:610:118::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY5PR12MB6623:EE_
X-MS-Office365-Filtering-Correlation-Id: f638fb0b-0281-455f-a54d-08dc7224f4dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFFyc2sxUGIrZ2tpTE5ST2tac3h2RSt0MlZEanJzaE96L1NycDU1T1FBS1Yw?=
 =?utf-8?B?aW55dkppODZ3S2pMVlVQUG1yWlhnRnhuQm1JdGt0MEs2K0tEOTdPWnp1SDJh?=
 =?utf-8?B?akRaakg1RWlDU0trOFJJZUNQV0xESzVGYjBsU0NOQ2lsS0xHTDAwQkxna29H?=
 =?utf-8?B?eWl0ZjQ3ckRkaHJXaUZualJiSyt2aFQyazdjZ1IvbjZDWjc5eGFkTmpncWoy?=
 =?utf-8?B?SlRvTzZXN0haUHJEMDM5Wms1WDV2ZGk2NnJ0QTNTdDZtbmVyZlJlS3NNZ29Z?=
 =?utf-8?B?a3paVE10RS8zYmlaZTJva0ZPUis0WHUxTFM5aXI3SStZRldlWFpsWTJWMnll?=
 =?utf-8?B?OVNoUzc5akRUSGpxZ25udGkrSElDOUtNUXdkVFpoZ0U2YzI4ZVZ1dXIwUEFr?=
 =?utf-8?B?Y1VVV1JMWVkxb0dlTGcrM2xFdmUrWkdmaXBIVzJ3QmxPNE14RXp2TVFoNkYw?=
 =?utf-8?B?azFpN3lsY0dtc2d5eU5COHkrL2NCeFJCMm9yTUZRVmsrdGUwSmxVb3VsdHpw?=
 =?utf-8?B?U2hsN216d0k2amc4bG9vQ2Q4ajkvc1dSZzB3eGkvYnJKSDlFZDBpQmthY2kx?=
 =?utf-8?B?QXIvMEFXdHJLT3lxZnVHUmlseUszSUJNdkVndnU5cG55dnUrWVN2ZHRiVngr?=
 =?utf-8?B?TWR5Vy85dHh6eHB5eG5CVFZUbkVVN21BdDZCN1BvRXRZTTluM2F1YUY5RE8y?=
 =?utf-8?B?YmdKcnVMSjdTK0hsQ1JpTXRKR1BSYkVXcWdtUEorTVFBTHgwMTFneWpaQ0FH?=
 =?utf-8?B?NjNiWkZJQVcxR3lNMlhFU2FydkliQWwrWGx4THBWLytTV1l5SjlTWmNTUktx?=
 =?utf-8?B?dksraHZKYjBTUERuSzE4TjBpVU1pNkZ0SkZpQzdHbXZENzdOaEtGd0ZjRXlN?=
 =?utf-8?B?Z1pzeThOaXRTSXFjR09KS3ptM2pqY0ZQZkh2QmxrTFZCVlBseXpoZTdsTTUv?=
 =?utf-8?B?c1ZZdjJ2V2IxSWJVRUE4UTBoamVwSVNQcVlaSVI2NFNIcm53WDMrdnR6NUVZ?=
 =?utf-8?B?Q1JvME5RNzFHT0tGb0tCWkxERlJRK0lNSzVpd29RcTVhRWhadHAzOHJiSEJI?=
 =?utf-8?B?WGN1a2o1d0pwdTBWaE9oZnNMMUxYTWxPTkVRN3hZc21XVjRsZ2k1RjBLayti?=
 =?utf-8?B?RzYzR3FXUmtQcmZob29wUzdPdmpzN2l5QjlERUVDY0x2ZDdpSVZrYnJwWTl2?=
 =?utf-8?B?UHJMbnZYTG5FTnlsUUhKUnNYaHp6SFc0ZVRrcVN1QUY2WDM4NHJHVzFWUHJm?=
 =?utf-8?B?YUlsd0g2MkJuRWNNZFJ0ejRyQW15MGxwZkVKeTIwTlFVTHVDeUlqdTliS2Yw?=
 =?utf-8?B?dUxCRmF5UHNIOEFVL01SaFUwOU12blRucEEzOTRBSVRWNjB5S2UzbTg1ZmNF?=
 =?utf-8?B?NmhYWFQwSEJhTyt3MDJaeEZOYWw0S2tTZlRDaHZ3YkMzYWpVdTNKVEV0VW5a?=
 =?utf-8?B?eUk4SWFrRytTWUc4d1l2ME01ejIyVVF3dUczYkxyUWRsdGswbGFNT25xSXJD?=
 =?utf-8?B?Uk80a2I1UDIxSTF4VTdhY1E0bFNtWUxLRmNTMjBYckYwcFg1TDVjamh1aGVp?=
 =?utf-8?B?VXhaa0JJa2oyQU9LMFlwQlgxQm51SnFqOFA5NWVvR1VyWVZwUXBteDg3OEcy?=
 =?utf-8?B?MEZxQWVVVEovRkVUbTdxK3dmemZzSFB3eGwyNUU1aGZqcGMwRkw5WEh1K3dk?=
 =?utf-8?B?QzJxN1BjRlRmZGEzaXNJUVpmUjdXeFN6cHFMczB4UDMwbHNHVW1BMGJ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmE2dXJUSGw1S0szeXV4OUd5OEhGRlRKTWFjVlJlWlNBd0pCeE54U2xsRFlp?=
 =?utf-8?B?c1QzWGhudDN4ZHlHWVl2NlIxV25xTjdycXk2OG0xL0lPZWFjNnh4L1kxRys1?=
 =?utf-8?B?Vi9nTExhQzVjOVJGY3pGdG1PSFhIbERKN3M3Yjk4c0h6N2dTck9MYkkrbGpB?=
 =?utf-8?B?YU0yVEpTeFhYcmpOVDVKTWtMKzQ2N3AwUmFPYjI0QXFFaWhRWGt3THR4QTBN?=
 =?utf-8?B?N0xGdFM4bGkwWlBpc1hTRXBCTXhZUzZJTFB0TVU1TExXT21XSW0ydkNadVdn?=
 =?utf-8?B?R2hYS01tRFNscEo2ZUthOFZ1YXYzYkNsTnR6Um5yemVUL05DeTRYYTZJc1Vk?=
 =?utf-8?B?Um91dWgrUDBoZjdVdUlhcks4WWc1dlI1d0tYTXFkeWZTWHNlYmdiamgvYUN3?=
 =?utf-8?B?UXA1YXVzRGhuOUpEZUM5WC9SeUZYaXBCRnF1Zlcxd2d5ei9jZTZ1Z0pOTGpY?=
 =?utf-8?B?WEVOaTQyL3l2Z1FOUlFYak5FOHpvcTZxYVFLUTJiTWE5OUFZNmZOVUhQbUpz?=
 =?utf-8?B?VTZpVVhSL2cvd2tpT2lJS3RmbGRyVjJKdDJta0dwSGY0NnBrOWNzT25YREpL?=
 =?utf-8?B?bENLQzhqRG4zdGdZek52VDc4VmJXbFJJVkdMQXJ0Q2c3b3JCN2tVQTRQU2gz?=
 =?utf-8?B?WVJoSzdzdklNMmtOek5ma0FwcmErYUpKU0V1UHJXSkdRYXdlb1prSFJJWWNp?=
 =?utf-8?B?MlJIcHZuTWZaZXFRSkZKUHhYQjltRFA0Y2lQNUJnUTkvT2diVjVQckx5bFhO?=
 =?utf-8?B?WjB2Tzdva05Sa3ZtVnEwL0FJdjFicWZYWnYyOXJ2eFB3WVFLN3UvVVhmYzQ5?=
 =?utf-8?B?bFRVaTlYd04zaWovQ1QvNE9CQ1k5NGZRRlRLQnNCU2FCNDY3ZmdKNjhadVp3?=
 =?utf-8?B?L2VjM0Z4aDJxYk9QbXNUdmw1THd0dnFUQWxudW9lMlZoak93NFBib2o2bW9E?=
 =?utf-8?B?SSt2b21TZzBlcWJmaDJIRHM3RnUySC9YVVM2SUYzVzlVZVVGdjNrT2xGOEJ4?=
 =?utf-8?B?RnNNNTROWWgxMzFtNEhwUkd1VW5rOUUzaXU5NmIyYStTTk94QlF1djRyaUtv?=
 =?utf-8?B?SCtnSWJXOXBIYytFV0VvQkZOcTV1VEhqMXBiZzB6cXRKdGNFeGozYnZlTmZr?=
 =?utf-8?B?VjYydkk5R3RGd2FFL2FUelRRVTd1VG4yRGZMK3BRYmhkQmNpQXhpbzNLV2ZW?=
 =?utf-8?B?dHR6ZE1xNVQvNGNsMStTQmx2cEJQSFZ2Q2JvcVVMLzFic0xoYXcvbFVORlZO?=
 =?utf-8?B?eW1oOVJETStFcnRXY1dobkJwTzREdjRPNzF3V0ZXREJSa2wvTjRRTDFLSUND?=
 =?utf-8?B?bExmSXROclErbXY1dUx4ZTJhak8vL3l3eGVLa3VyeXozNXdwL3BjSVBoYzhX?=
 =?utf-8?B?ZkszNnhWMnpkMDhaUHhZa2QvV3VTQ2hvamFtOFpqNHYzUG03WFFnZHFkbDdj?=
 =?utf-8?B?WlA3Z3RMNmdLUFhtQUppcEZLYllFSDB6UHcwamp6KzUxck5yTTRZTXBqZVVr?=
 =?utf-8?B?N1FDd25vQlNoNTByNURyRnd2eEJrS20ydHo0ZUNjWFBjcS9WYVo4NVJtTy90?=
 =?utf-8?B?ekhoaktsSUhtWU02eWpaaGlDWUYrc2xqbGtnb0NsWVJTL0FIekZtMXJFczI1?=
 =?utf-8?B?OEx5U0FHeER4YzNxOGlIZXlyN3JiemlRS3I1STJqK3V6RkFGd2laRldvaXFR?=
 =?utf-8?B?bXhLb1NJNUdxYWdKYklialA0WS9xVWowcDZKQjlTWHpkelhxOXpJYVozYS95?=
 =?utf-8?B?TUpldzdtRldISHlTVmtHbzlqdGxkb1hPdFNzRFVaVlhZU1BJajEybExoLytV?=
 =?utf-8?B?c0pWeE9EM1pkZXo2bjM5NENhM1VLenJKRXp6bDlLRWVTb0cvOWZZbzgyNEpH?=
 =?utf-8?B?K0gyTENjcWV6OGwrUE9Qa2JvSlFoa2YyRXNTK2REZnV1QmwvcWI3c25jV2E4?=
 =?utf-8?B?aFVOWTZHcG5kc2hSeUFjcnREa1Z5L28xVHp4NkhmbW9TMnk4SE93QXoxUWlO?=
 =?utf-8?B?dW1LT2ZIZjMwQ1h5QzdiNEFmWDFYSjJxUEtSUlRVWEw0N1gzVE9xRGdsb3ho?=
 =?utf-8?B?dUlBWmx0UVRqT1NSOVRYRmUzd3p1T25nU2pjL212NHE3aEJMYkhRV2o3WHlj?=
 =?utf-8?Q?wlash2I2Q/ecEWwYHIuFg+Xui?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f638fb0b-0281-455f-a54d-08dc7224f4dc
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2024 01:43:43.3429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +UaFffBU1jjNLwHh8yzRLrkptCEOPidR7OFo7+6gkC4BcsMrgC/vNX8ksMNjQAb8XI3Hw1/2oROvVmIblHX1OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6623



On 5/11/2024 7:12 PM, Lyndon Sanche wrote:
> 
> 
> On Sat, May 11 2024 at 09:59:17 AM -06:00:00, Lyndon Sanche 
> <lsanche@lyndeno.ca> wrote:
>> On May 11, 2024 9:16:56 a.m. MDT, "Limonciello, Mario" 
>> <mario.limonciello@amd.com <mailto:mario.limonciello@amd.com>> wrote:
>>
>>     On 5/10/2024 9:36 PM, Lyndon Sanche wrote:
>>
>>         index 6ae09d7f76fb..387fa5618f7a 100644 ---
>>         a/drivers/platform/x86/dell/dell-smbios-base.c +++
>>         b/drivers/platform/x86/dell/dell-smbios-base.c @@ -71,6 +71,7
>>         @@ static struct smbios_call call_blacklist[] = { /* handled
>>         by kernel: dell-laptop */ {0x0000, CLASS_INFO, SELECT_RFKILL},
>>         {0x0000, CLASS_KBD_BACKLIGHT, SELECT_KBD_BACKLIGHT}, +
>>         {0x0000, CLASS_INFO, SELECT_THERMAL_MANAGEMENT}, }; 
>>
>>     So when Alex checked on v5 that this doesn't load on workstations,
>>     it has made me realize that doing this will block the interface
>>     totally even on workstations. So I think there are a few ways to
>>     go to handle this: 1) Rename dell-laptop to dell-client or dell-pc
>>     and let dell-laptop load on more form factors. This would require
>>     some internal handling in the module for which features make sense
>>     for different form factors. 2) Add a new module just for the
>>     thermal handling and put all this code into it instead. I don't
>>     have a strong opinion, but I do think one of them should be done
>>     to ensure there aren't problems on workstations losing access to
>>     thermal control. 
>>
>> A dell-client/laptop separation makes more sense IMO. I don't think 
>> keyboard control would belong in a the dell-client module either. 
>> Separating just thermal control would be easier, but not as clean I 
>> think. Thanks, Lyndon
> 
> Thinking about it more, we can leave dell-laptop as-is and create a 
> common dell-pc module that does not check for specific form-factors, 
> assuming that is possible. Thermal management can be the first function 
> to go in there.
> 
> We will still block the calls from userspace regardless of which modules 
> are loaded. If dell-pc fails because thermal management is not 
> supported, we aren't losing anything by blocking that call anyway.
> 
> Thoughts?

Sounds good by me.  So basically laptops will load both dell-pc and 
dell-laptop and workstations would load dell-pc.

