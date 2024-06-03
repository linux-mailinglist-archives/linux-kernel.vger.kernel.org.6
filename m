Return-Path: <linux-kernel+bounces-199345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2768D85D4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D8201C21D0E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270561311A3;
	Mon,  3 Jun 2024 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1wcViDxv"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596181304BF;
	Mon,  3 Jun 2024 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717427563; cv=fail; b=U7RJTp8LN4y3QrxN6aoa03HSF6Q7ko1fgWDoSAoLw1KQXR5I9neUKsBsxSI6ZIPmM+VYJbvWuOKvMnx/vrbUaQG10w7qr/wpUqX8YbPe1khaYiPTnFHWaiW4hUJYr7irwQONCoZrdBkVFBEm3SKywh/WmJgmF3DtVOX3ae5uLXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717427563; c=relaxed/simple;
	bh=RlnqgDQ4T6mxRtpAq0s2pWBF39w8+qDFkYbe0x83zKI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qojONf+DQA0WBwmzX2PRv2oJbN/+DG52YDUvA1IXuM0btTbA5gFhY3E8xi9Hzp2fYJyXgGAR60On+BThGPiEtGwLhizCRN7ztR+AQy3Ked960LK+yAYaCqv2/EEnOOqU6G/DsdZiQ5PXTZIcsEe0UtpT7URPhIGgiqdxNtrkBGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1wcViDxv; arc=fail smtp.client-ip=40.107.94.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E64iuV3R2jBB7PHGLZZBNJMxe9moKGkfMyM1spjp8LwfsljSNsrl3u/+fLc9SIlfs/W9jAF/wbACTKY6J8ETD9dJUBIOFC2Ia1qfYO18kVKARd1SfGaRTF7xxX3yHgBtYrCRPdbEKsgWWL4yXTgit+4c1fcYn1WmGxjsiZfTB64HlN/IOdxepF/WOi5WD8Z1Ela0Ix4wkZsJTbr8ZuA7ImL+hVIN0At4lQ4GZmv2ezpwCNarQ73T36c7Ox32XCSwinEFpq2meu6jhNfN3tNKX1myTt8zcM1Fw9MW02wzkWZPphFhUmNSKlJQ3FHMSMcjFFV4v7Q0jlF48WnzViB5tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3P7Ah2YaMPKLu2kSnRVWViP1PtERzpzZTnmPVzaWbk=;
 b=h+emSho0xrCZCNjOQgMcMPywiZ0WEx81fMtrB1F37Z8JOSom3fk3haR93TLOehFy2CmT2jOU+tQiG7BvFmYGnwAJIApChcbFXzWXWo34ZW2fEBS6euVdCXX3c0AEa/4o61InFYLl3RN6E/r2DQpRanLvVzrsNk5PWP1HumWjiOhhlSZrEoEUHHozczFdRH6OBEvxGrIhvWzndLtLehUNLRjewuSeWRJufIl5/3p0TMlDW2LGY83qUapE9rL0QtoNXrd2FE2fQqeuW4nhIb8IXCqyW+xs3Bg5PL3MmnDIYpWccxgS4Fle2/kfo7oWH7n3CEcQi2d/Lzhr02uQqvwnjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3P7Ah2YaMPKLu2kSnRVWViP1PtERzpzZTnmPVzaWbk=;
 b=1wcViDxvt2RkgTKGOsMI1bwmdYCK7soRfTsoIHaf+MDXD8XrpIZ5uMoLDju9+yq1amzUUiksh2AEa6gBUpiFqRowh0Oof3haFXPMt6L2f6iJtWD8deOYMnWc5258Nf/kOcwX/G04g8s54+RNIlcgLrhmQXDkv0PzD7tUFJ+9JnA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH0PR12MB5605.namprd12.prod.outlook.com (2603:10b6:510:129::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Mon, 3 Jun
 2024 15:12:38 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.7611.016; Mon, 3 Jun 2024
 15:12:38 +0000
Message-ID: <b2c6a97d-6722-44d9-900b-a10e169bd16e@amd.com>
Date: Mon, 3 Jun 2024 17:12:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: nvmem: Use soc-nvmem node name instead of
 nvmem
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com, Conor Dooley <conor+dt@kernel.org>,
 Kalyani Akula <kalyani.akula@amd.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
References: <42c21f3bcd75f821061d047730dbbcd40233e256.1716800023.git.michal.simek@amd.com>
 <20240603145201.GA414800-robh@kernel.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240603145201.GA414800-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::26) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH0PR12MB5605:EE_
X-MS-Office365-Filtering-Correlation-Id: 62bb2b66-8de0-41ec-764d-08dc83df9b11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1Z1eTUvRWk2djRDVkQ0TGphMzl2MGhmbnBZMitLaWRvSlcySngzTVFpdmtm?=
 =?utf-8?B?bzhtamFUVnBrYmlKcUMxSFQ5WDJxYVhmemJGME5HZDRSMVFqQXhZTXpaOVVs?=
 =?utf-8?B?QnBRNFNmcjZCK0djdVJrRFg3Q0hvQVdpREdRMnlVUmExRmNwTk1rVTRjUE9m?=
 =?utf-8?B?Y1VOMTcxRE5yTGNxY09QbXV2VzJGSUxvMDR1eUo2Z0xnWUtmbE1wamxkTEZK?=
 =?utf-8?B?OWg4Zmp3ZjNOOUZuQk1IM0VnNlh4VmFPKytlaGx3MjRJSGVPMFdLbStRc3RP?=
 =?utf-8?B?dlFnSnlaclQwZDh5QmpobjU1VnhES1ZBR0hQdG5DbnBEM21ZWnRsU1l3SkVO?=
 =?utf-8?B?NTRrdVhhV0hDUW9BQlorbjFtL1djZUc1MHNBUE9NSXE2YXJzQ1ZBRWptREtW?=
 =?utf-8?B?V3hPeHhmeGJsSVBhcHhYelFJZHdIRDNPY2xyTUZ1QUxuN2lRaER0aytHbGpr?=
 =?utf-8?B?dkE5aVBndU9wMHY2WDNyUkFoZy9KQVN1VUxOSWhXMWthVnk3aGxqZGF2cDhk?=
 =?utf-8?B?cUp2ZnhTN2JnZjB1aXdralJqRWZ3ODBaZ3RMbytaQklhUzZKQUtsc3lzK3Q0?=
 =?utf-8?B?cnlFR0dTMG1JZlZuSmdZRzRGa3VtSkhVM2J2bzVlclBNdno3bXVlaXEzL3Vp?=
 =?utf-8?B?TTYyYytZNi8vTXJtNkxOcGJDWFBEU0F1OXlCL2d3RmtiWjJyVVZNblNCRXZF?=
 =?utf-8?B?MGlRRmg2aTJ0L3F1Q3JiRHQ1ekRJQ0hHWXdEU28vNW1DeEhqU0pqVGNxQ3Jw?=
 =?utf-8?B?N0wzZFl1MlBFTCtGeTJJcHpsNi9WUFJiajFkZnYyNzZwcm5oeWZVL1BkVjFF?=
 =?utf-8?B?Z0xDSnorRFhBdkFCcDJYeGh0VkUxcmZKNldYRVJmVG1CR1RtM05HWUI5UlhK?=
 =?utf-8?B?SldFakxFOHJaSVhwNVh2UENYODd5aWIxOFl0d0RNN0NyMTJJZEZHY3o4dTdq?=
 =?utf-8?B?UnZlOFFoM0JDRFBlRDRLK2JMdm4yaW1yeXh1U1ltSElwc09FUDJIV2x3bFBo?=
 =?utf-8?B?VWFmaTl6M3VjcVA0Q3pUZHQ0REwzRFdtZ1NmeC9USjZoN0daK3ozVm5DWm9E?=
 =?utf-8?B?d0dxVFBNdC8vT3NhdEJrNFFjQmN5MEJLVXlnS2Q1aStjQzJYQ1N1ZUttZTFm?=
 =?utf-8?B?YVJyUVh0T01wajNKdHNzVk1lNUk0Sm5yS2xPTXduMmdvZStlKzJKWitCdFBi?=
 =?utf-8?B?eDZvRUpSLy82Q2x4RnpKOTRpeU5aOURHSUR1OVNJUFVNa1RhMDNJb01obXZK?=
 =?utf-8?B?NnFrSFhtQ244RnhvY3NqbnFDaXJlRGZXVkltaElkNVRBZ3EzQ21rMXVwYm50?=
 =?utf-8?B?NHd5U0szMWZYaXdZTmoyUldrTmJCV1k3TnU0Sk9LV1BwR3BFczhJdUpMN214?=
 =?utf-8?B?UVcyeGdOQzBmQmIwWWNZNkZYdGlCbDV1Y1dVUVc4NW1FQ2FFRjVXaEhUYVpJ?=
 =?utf-8?B?aGF0OWsxa3hiQ0djSHNuRWRoVjFqellMTHZ0ZGxwUGZwZ3FmaE5UNmhhQkZq?=
 =?utf-8?B?WWVKcmE3WDNtUG00dERmKzNhS0o5eWdzRVNKUVBqQzhBLzFYSW9tU0NxaFFP?=
 =?utf-8?B?RzJ5dmtzT0tZcWZTa3VnOGVrNGJnY1dSNk04VkhxY0ZCKzFsQ3ppRDV0Y3pp?=
 =?utf-8?B?UVJ4TENRK2hzOVBKL2hycXUzR0RmS1l3YXNIcE9NK3cyckYrOFlxcTB1THBu?=
 =?utf-8?B?R0Q3dVhjZnVSRzJTa1BsYk80bzZ5YWpvY3FLbldPQlJoNVJhVHlxVUlnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzBLaWNKQlRwNmVZM05jSFZDMzc0RDZ2YjJnRHAxWjU5RFZOelN0eDBVM20x?=
 =?utf-8?B?bFEyVDBDRDdCemcxcU9KcGpGMjNtL0wzbmJ6Y2llUFNjZWE4OXpBcWd5NGxM?=
 =?utf-8?B?eUJxNThnZktmQVlLT0t4YjBRWnFKTzluMHJUaXRMNzRaVTVlaFZFVXQvOU5L?=
 =?utf-8?B?eUlyK3ZmZFUyT05KTi9hakJtbWNDOHJQeDlScm9KM2Y3MWJCbUo4WkZOTUI2?=
 =?utf-8?B?dml0VlNVNzJQQ3FFMW9uYTFMcGp2c2t4TXE2cVFGRmd5dnBCcWp4TUcxcERa?=
 =?utf-8?B?YkFLa2t3aE02NWQ0eFBZdUw3NTBPa1RNRThoa05CZSs1VnJ3MGFOM08rbndw?=
 =?utf-8?B?bEMyUVVsVFpWWVY5OUorOGN4M2RIdG80djVSQmNDUnAyekgwRVA2ZEFHZXl6?=
 =?utf-8?B?RDI2NEdUK0loNVVZU2JjTExnenFOeEN4SGN5UmdNZkRhMnVtSFM1Q3dmaXM5?=
 =?utf-8?B?VHNIMlJaekZoR1FTRy80dE5ocFNSMEoyRWkrT2xEYi9CLzVQTHp0UE9oWmJB?=
 =?utf-8?B?TmFha0dEZEk4L2VlaFlHMy9YSUt1OEcvRmozSHpLenhGdTUvT1BrT25ObmJP?=
 =?utf-8?B?YSt2RURmaDh6NzVnSkRaTm9jVi84cXhlM1BWc0dQaTZxSHA1bnBWei9nYytE?=
 =?utf-8?B?RElDM2hMZHhVL2VkQU9aQ3lvZEVXelJpQnYwcFAwL2dtSEJKcjJ1ZjhKb3RR?=
 =?utf-8?B?aE9yQVpkTDB3TmNWZDErTnJHS2lDOEh3dHZFcndCQVMxb0lBcXU1NzlFM0NH?=
 =?utf-8?B?citubitxNnhmRWFrc2pRNEZmMGtvWXRNczQxTmpvUHhiTmpjWWFRZ2JnSUgw?=
 =?utf-8?B?d1hoSm9UQzlUME8vOXhoUXJWUjArNVNpSlFEeUxjSTVtUm5FcGd2YnZWSm1u?=
 =?utf-8?B?ZnZNVGt3dTU4MWlvLzFSaGRucEJ2YU1LcmtJNFNqbzFxbEN6Q3RPZUJzUGdr?=
 =?utf-8?B?MUkyZ09PMDFJb3NMTFBKMDMwa0JLckZxSnRuWUttR09ycHJJU0ZPci96eFps?=
 =?utf-8?B?WjY4Y2pKVnNkTnN5VklIckFURitRYVE0dVc0ZHUvMnBlZ1JMMEw5OE9VKzRG?=
 =?utf-8?B?ZWlrWVphZDd6OHJXVjNnYS93cVRQcXczUEd3S2FBQTdmMVQwSndtSEQ1Y3RR?=
 =?utf-8?B?MmVFbFVZYTIwUzBKeUp3ZUNyYUdsbkxuL1ZqUVgwejVvY0E1TEUzSE5odWpG?=
 =?utf-8?B?YnNWdjVoSWtaNldtWHlEWHRCLzI4ZVZ5elhmSVYzT0dxQjV6SWtvZVFpMElt?=
 =?utf-8?B?MFVsMVhHSHRWQ3ZkTFlTL1hndVpnOE9MMDRNaFZKeXdsZkZnZnhxSGNyOHBX?=
 =?utf-8?B?dzYraTdEd1ZSQnFpcUhXaXlWUnZwQnIxTjZEeEh2cGEzYnFSV05jVWRGbm1y?=
 =?utf-8?B?VzlzYUZ6blRPZHo1cUNGd0hoMEI2VWh1NDAzdG9Cc1BieHBsM2ZsMnF6bVgr?=
 =?utf-8?B?RXNqVEt4Sjk4WWtER2VYZUFVVllVRGFyVCsrNFVQWlRmTVN1Q05aT0wwYVBG?=
 =?utf-8?B?cGtwbHNwK29XWi84TmkzcVRYSnpIWVBnOUFsYzhRY3BaNXJiY0QySEh5NnRo?=
 =?utf-8?B?ZnRtKzFTRmdPTEV6TEhiMlF3MjFqckVrbEFqM242MVl5QjFhNUpTV0pUVmYx?=
 =?utf-8?B?bk1NOGVLc3krR3hwWHA4aHpCVTNKQytjcmQ3MjM3ODg5RzRIc2ZJY24zdmNm?=
 =?utf-8?B?aDNFM3BDRm9tYmRNN2d4RWFIZUFiWUlTTEtEd2FhSHVtbExteCtuYmxFRWh5?=
 =?utf-8?B?bGlEaG1BVlNNaGd4WmxqSlptTkg5SFZPSldDY2RBOFhLSnFjNm5kQis3YUZ6?=
 =?utf-8?B?dHlqeVlxVnZEMzFpcmJkL0paUUw0clEyRXlGUkgxTTVwQ2EwVGI2Z2FOdFBV?=
 =?utf-8?B?N2s5VE0vSVNLSmk4cElHaW1KSkZvVlFkeGliOTNxZ3lLRmpoTS82L2t4Mmpk?=
 =?utf-8?B?aWlSOWFIYkwrdHlTdnF2WERkVktZa3NCSGw4YlRwZVFKWG9XMlpoeXZvM09n?=
 =?utf-8?B?WXkwTENsZ0MxU1B6Ym9meE1pQ3dCU2RvTldud2RmNEVCbVJNZHlINzlPKzZQ?=
 =?utf-8?B?azJYamg1ZUU4VmZ2b0cyd0RFSUlPb1JCVUNET0t0L0RrbUFMSFFqRzIvWWtu?=
 =?utf-8?Q?a0CPSA/I/WF7afAV6+gSBa0HP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bb2b66-8de0-41ec-764d-08dc83df9b11
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 15:12:38.3466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GyiGnYTQSEJ66QAr/QPsQrNCmTMh+LlwQUXQ1VfQxpSRukNPC83ZABnW8YKUWcJs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5605



On 6/3/24 16:52, Rob Herring wrote:
> On Mon, May 27, 2024 at 10:53:50AM +0200, Michal Simek wrote:
>> Based on commit d8764d347bd7 ("dt-bindings: firmware: xilinx: Describe
>> soc-nvmem subnode") soc-nvmem should be used instead of simple nvmem that's
>> why also update example to have it described correctly everywhere.
>>
>> Fixes: a0cfd5e99782 ("dt-bindings: nvmem: Convert xlnx,zynqmp-nvmem.txt to yaml")
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
>> index 917c40d5c382..1cbe44ab23b1 100644
>> --- a/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
>> +++ b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
>> @@ -28,7 +28,7 @@ unevaluatedProperties: false
>>   
>>   examples:
>>     - |
>> -    nvmem {
>> +    soc-nvmem {
> 
> This doesn't seem like an improvement. Is there another nvmem node at
> this level? I would fix the binding instead if not.

That name came from discussion with Conor. None suggested to fix dt-schema 
that's why soc-nvmem has been propagated to DT already and this patch is just 
fixing last occurrence.

commit d8764d347bd737efec00fae81133ffad0ae084bb (tag: zynqmp-dt-for-6.9)
Author:     Michal Simek <michal.simek@amd.com>
AuthorDate: Wed Jan 31 10:17:28 2024 +0100

     dt-bindings: firmware: xilinx: Describe soc-nvmem subnode

     Describe soc-nvmem subnode as the part of firmware node. The name can't be
     pure nvmem because dt-schema already defines it as array property that's
     why different name should be used.

     Acked-by: Conor Dooley <conor.dooley@microchip.com>
     Link: 
https://lore.kernel.org/r/24fe6adbf2424360618e8f5ca541ebfd8bb0723e.1706692641.git.michal.simek@amd.com
     Signed-off-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

