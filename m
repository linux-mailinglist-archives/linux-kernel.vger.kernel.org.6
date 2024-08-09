Return-Path: <linux-kernel+bounces-281061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CC294D28C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 841FEB222AD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A48195F0D;
	Fri,  9 Aug 2024 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VSpH4/Ws"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2077.outbound.protection.outlook.com [40.107.100.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4131957FC;
	Fri,  9 Aug 2024 14:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723215046; cv=fail; b=hu99DsXPxb++9WN+kuHUdXaxyxZmx65AKPYLgxAYior1Mfm3J0btK1RA1M8OqZYs4ks0RFE17gB/Z7zuEQvZFGZABukrToDsrSataQDg+uX/lhWJXhaa2h3Z5xj0py2jE1zHuORql9I6ezAIMB5fsneLmdcYwn3REArIBeYx9JI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723215046; c=relaxed/simple;
	bh=nwyMnUXlJCr44q6eiwivNce4yr5PN0lwreexK5Q6fvw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SYR7w8bJWcfgFKhKDMlorKHiZLsoh40MEeC3RvKMC9AuoQIoDNKjW6d7wbDW7k9ZpyhXOJTVlW+GUjH58+fFN9w3u8TTT13LEEs+CrD9iNTA5iThSkIwtdWN7sp8i2fai5WlUQKcJzskuqDI+CqMrYnq6JY9XW1GY39KHUIN53Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VSpH4/Ws; arc=fail smtp.client-ip=40.107.100.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L42AOGupZZjiRhyQKEQSGdJX0Zy4rkOY56+JatsiBHZ+JkNzaslDRskIThaLLvEzBZRT0YoOv8AvZ+rAb0UjmOJulh8OnilD8vdQjwOpB7HRidm8Ja2mpPJKoVTBHSOtnMxh5T27W4fu7wUuVmpWBO6ZX6ywbfhDvI0j3KtraMwojPS3pUPEyBu4Y6KIYSc7A6A77V0MD6TWdFBc9TzE/HUPw7iQxrz965djrtCOeHtDQMGP+8OH5a0BqclXhOMKMSv42Cxv+pfZw+5KDx7HH2+l0jaXUkxSfjdebhMA0aBFnnikKzkQDqHKZvPijd8A2Z/lfv2Gd8VOIdP4sLNBBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtwAXYJqzA9+JDDjvZbBowOiXYARay7vgeBku9eEgEE=;
 b=uOnsncMuaGBtC6UIuE26up5ggTc8qsDnw2opPPCrx4xsAjTw0jcaWPgKcxGe6GpBO7dZDW9T7vHF5jNemif8v3QZKW1vShwWorI4JBrXlp+k6NMqmQYVRct+hj3/Leq+QYJqOPrHRrTEMPTrIdGwJjg/nwfdAntpRygLF0VCFn7BZBR1hNw7xLF4rEu0rrcsTIWIr890uIlhA3vnDcgkuKh8ONSyO6JdqzY6KuxJVePsVfudaWewVSj2MHGWHnzJiF8ZDPYnMQoPWPnX8uIhjQh8IjMm4ONjTrvOxohup/9xNR3oNNepLnJ3k4Va9sZBrUvFENz52eHG0fPsErnTmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtwAXYJqzA9+JDDjvZbBowOiXYARay7vgeBku9eEgEE=;
 b=VSpH4/Ws2fxesBb+ARQ6ykhwJIyaKpgE5aGVDlxwuMcGnUZs+KXeowBDYBmki2tRuop+tMN960CLLpkN14LojIWl0Yzb5TV8B2OyUOskS1QnwZs51hcNtUuywemOVU3PaMjJEJtI3eKHGf9ryUwereasCINYQfmoRQj4AlUDOIg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SJ2PR12MB9212.namprd12.prod.outlook.com (2603:10b6:a03:563::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 9 Aug
 2024 14:50:40 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7828.021; Fri, 9 Aug 2024
 14:50:40 +0000
Message-ID: <f81325d0-2d26-4457-8115-fc5f2d662453@amd.com>
Date: Fri, 9 Aug 2024 16:50:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: nvmem: Use soc-nvmem node name instead of
 nvmem
To: Conor Dooley <conor@kernel.org>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com, robh@kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kalyani Akula <kalyani.akula@amd.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
References: <1184b2799ecdeef04128f4bab3db7460fd8edb10.1723114978.git.michal.simek@amd.com>
 <20240808-imply-backroom-b5a9aaf44db8@spud>
 <18da4d46-68f2-4419-ab60-8df09c0cc7f4@amd.com>
 <20240809-emporium-haziness-e98208c39990@spud>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240809-emporium-haziness-e98208c39990@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0032.eurprd03.prod.outlook.com
 (2603:10a6:803:118::21) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SJ2PR12MB9212:EE_
X-MS-Office365-Filtering-Correlation-Id: ed55b298-1848-4114-7f26-08dcb882a2d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXF0MzRGQ2xHd2pPRnIvcnRUR2EwSmpuZ0RWNWdScW5iVlBBeVhSb0loYnJ3?=
 =?utf-8?B?YTk2VEdpTHRLTHpSVi9mVTR1QVpabTVZN0FTTUI4TnVaak95ejl5Zmwvc0JH?=
 =?utf-8?B?THB4NVozbFRYUFBDTURuSzFsSHFreFVwYldiaXZIdFo1d0hUNVNFeXZ0bW41?=
 =?utf-8?B?OHlCUG9uU01MYzNVZUFCaWtIcXZKQ0xlWWFFZkcrMDZzUEdkR0NsQThaWFhO?=
 =?utf-8?B?WTEzL3hra3lDRlBYMUphajdhR2RicXdBdXNCM3Y5eWVnR1dMWmRQaW9JakU3?=
 =?utf-8?B?KzlFNzR5R3FVNHRkSERsMzQzMnBQUGRqSWNUN2U3U2hLb2VCZEYvVUQwbE9H?=
 =?utf-8?B?bHZpTkJ1WldvSGtnUlRkeitXZWkzMXpudk5pQVQxUUNxR0hXV1dBdmd5NjBI?=
 =?utf-8?B?bDY5T29qN1k2SzB4SXV0OFZJRUlwNEpNcWVrQm1udVJwV3I4K1pvUTVldVBz?=
 =?utf-8?B?SXQ4S2w5UEVJb2JIMzBWYkw3T3F6aUlZZGV4UXBXc01sUS96UGdoSHo2TFdM?=
 =?utf-8?B?eE9ic2YvM21keVFoL0V2NlA4Y0Fsd1k2ZEJiRG8wRGtyNmVJMWorQTRFUlVF?=
 =?utf-8?B?VE8zZXJnam4veUtVNkMrTUdqSkY0S0hPQlI2NUh1VVBzbVlmMUJxcDA5RE5m?=
 =?utf-8?B?ODVsOUlBUVRaRXRLK0Z3UWNWUVZoaWJQMllYejRRSm9pQWZPUFF2WnFBWklY?=
 =?utf-8?B?QVNkSzNES3RLS21nRWNhWWNRUEQyUHhsbWg0Um1JS1F0cmpvQnNkNUU4c0xs?=
 =?utf-8?B?b2swK1RTTWpYVjM3WTZ5YXdOQWVnSGFkRWsxOTlJOGRSOUxxd0JiRXdZaUI2?=
 =?utf-8?B?d05SOG0xN0FaYy9uQmRUMjVFQUVMY1krM3c2SlFqYkcwWE5hNFA3c2x0c2dM?=
 =?utf-8?B?U2I3VkpsUlY4ZjFKQ2xPZitxMHcxdEJTUVU0SFByckt5dFVPNXVqZmNRd3Zu?=
 =?utf-8?B?Mkd1a2lyd3dLU2xhV0paZEwrM1hxOGxVYXVMSm5MVDArcXMzNXplWUwxN1Fk?=
 =?utf-8?B?a3pEQ2RVa1BselNHeitNTmdtQkVDZlV6WlBtaHdEWVN4N3VqQWt1c210K1Fp?=
 =?utf-8?B?Tm1JWU9iOG51Y2NZbGpFYWplaFp4OGZXRzJPVkJObXUrQkl6bFNINEFNYTBZ?=
 =?utf-8?B?SHdqWjhwTTVUK3gvQTFZVktDMTNwRzVtcU5mS1R4ajFWMmVZNHo5VzVubFRM?=
 =?utf-8?B?aVN6cGlDMFp6Q2FGeDVKN2N1bmhGVHR1NEpzUGtkN1FBY2RQekx2czFZL0xE?=
 =?utf-8?B?UzFVaGw5ZXQyQmVWUmwzcnRIRHc5R2E1SUFUVFEwRnMrOGdWODhkczd2amds?=
 =?utf-8?B?UTc1akR3ZnpvOW5QNDRjempjckpDTTRPR2kvQW1uZkRhdkdyZ3Z6d3NuQzls?=
 =?utf-8?B?ZDlxekFFVFh0cGhPclkydzFmUEIyTjRxYWlNNVhnV25iK0Z6N2NyV1FGTmVy?=
 =?utf-8?B?MFFJa2dyb2h4WGFPOWZUem53Tlhzb0phak1tVVo4Zk1TRkpwZmpiUWNPdUlG?=
 =?utf-8?B?dWFxa1FKcDJYWDhvL3ZrUjNYOU5xLzRxeklKNGMvcEt3VzNhSHVZVlZkcE9r?=
 =?utf-8?B?aTdNTVBjemZPQVQ5ZS8vM2JrZHdKVkkvdVpHbytGR29oNmttTE9JdlhLd2Iy?=
 =?utf-8?B?cWlhQTZRY0JETXJIWGY4MGtjRnlleVhqK2RqZ2puNGlsZkZXUkQ5ZEJyVVRY?=
 =?utf-8?B?cEc4TjRPNThUNms5Y3l5SkFBSHg3Y1oxZDBEYmlRUU5vWWFFZ1VoUWwvZW8v?=
 =?utf-8?Q?ALCdhzNbcWqj4DV+zo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzIxSjhIdTJlUXY5bithNUZxcERDV213ZzJXSVJNNXhjamRqMnJjUk1NOVk3?=
 =?utf-8?B?N2JRUzh2TEEvdzNMSkZzUkRUMW5MQzZndWMzYk5ZYTV6Z2RFcU9lamhIN2x5?=
 =?utf-8?B?OENCMmhFMVd6eWNrZWxreVJDUENBbStNSnJoelQyTEFiaXcvN1pxQlk0MW1C?=
 =?utf-8?B?MDF0bjVScmR5Ti9vL2cyUXRyVkxFQkhka3l0NVZ3ck1lMDhwVkZWUExFK3BL?=
 =?utf-8?B?bDByTEkvYkMwSW9zMUdqOFVZMVV3clJmcnJCOGFMNlBjNW5iNFgxUW50YWI3?=
 =?utf-8?B?Qm9DNWQ2U0NCdWpDMHNkUlpZaktUNmI5RmsyYk00S0l3VDVnbmJ1b3M0Ky9k?=
 =?utf-8?B?NllEaHlhb0JSM1hCUnZSWjNDK0RrYUpQWXZpcC85dXh4aUVCODVVZXF4dHly?=
 =?utf-8?B?N0RWbFZ5Yml0emFCMTMxaU1aQklhdlMyLzdWYkpTeVN0U0lhb05WbUxxalRr?=
 =?utf-8?B?Wlo3RHk1bCtDOGR4d2xNTDFxNUhhZzdiUDVGUnd1R3N1dXRpMnVsRDcvVUw3?=
 =?utf-8?B?WUU4czdZNjlwWlpXb0lOcTRzdGxFVWo4MlRpdWlqenNCTEFzM0FvMmZpK0lk?=
 =?utf-8?B?a3ovOU5qNFhMN1BLdUZrY3VEODg2ZnppYjVwNnZERG5CS0llcjlGVjlHemVJ?=
 =?utf-8?B?blNmTXFaQUs4NjdQN2NzMjF2WEJYL2xUUndJdHQ0T0VYODRRZzhaN09Nc0NN?=
 =?utf-8?B?cS84QWdXV0dJWGxOVElHNThaZEc2TExLZFRSck1tWU9aY1NLQTZhYkM1OVZJ?=
 =?utf-8?B?UVRteDZQWkRhVCt4aFAzM1o5VXBSNGFaQmtwZTgzeVhmTWZXb21va1lZSXNQ?=
 =?utf-8?B?aFpUMUJwWmlycXNRZ0p3VUp0ZlhOVlR2aHhIQzdSN3pQa3huVXFNR1VuaURJ?=
 =?utf-8?B?NDZuTGJJVXRUeDVzdFhkTm5nTkM0TGlyd1pOcmZUMnV2ZFlmTGlydkpNRU02?=
 =?utf-8?B?bk81b3VhZzBDcWg3bThaamRTZXJySEFUVWU3WGtRWnhBNlBFNnk1RXhmNy9L?=
 =?utf-8?B?YVh4Z2FCc01YVnhpN2o4YWFjSGNsWW14L1kxTzZneFRISlNnNHdWVmFDM1pp?=
 =?utf-8?B?VEFNZmd5MExmZWtrbWRMWklCOGlXMGlmenhkZXVHU1lGQ29jR1hLWkhDVnlN?=
 =?utf-8?B?ZHR3VVI0NDJPVXROVUV0Q2NHUUVQVUFwK2lVMWhFS2thcWZuZE1ibERsVE1r?=
 =?utf-8?B?RGc4SXlCY2Qzamc4VXF6Q2VpOG9weko1OHJqMUZUZ0t5eW5IZDhiQ3VsWFl2?=
 =?utf-8?B?OUx1UXU5WExUSWxqaytsckFnUy9TMWkyUnVIVno2eTQ0b1BIYkZWUFAwZVho?=
 =?utf-8?B?cGROSlB4TzRYRWVDWUl0THowRmhZKzFpdGorSEN0UVBWLzB2bkFUanpYZU1z?=
 =?utf-8?B?djVvT3ZmUXZJWHhiTEtPd2E4aXRxczUxbEpuaUFyRGlLeU1VdkEzWEE0enlU?=
 =?utf-8?B?QWQrZCtuNGw3VDhvN21FL3NxdW9WaTdyR2dhMThYUEdNVU12Q0lRTjRIcDRa?=
 =?utf-8?B?WDN2Q0dMeVhSSXVINldLR0dXT3FpdFVTRldnOFdhcVdQNTJ3ZEZMT1hxNUx0?=
 =?utf-8?B?MWRpYXZPQkxiaUZpUjh4YU9YYTF3QTFzdGY0dEJuMTNrek5NMDNNRVBuMmJT?=
 =?utf-8?B?VkZhMFpNeEhPMlU3OXp2MDRER29HMjQ5UGNXMTg2L2JUQkF3enp6a3FxUkJU?=
 =?utf-8?B?TW1Hc21Pc21ic0c0REMrR3FNSVhWbmVFN3A1QnI4NGpWZmhsdFVmenZSM3Qz?=
 =?utf-8?B?U2VrY0NYa1AyOGpwbWZSZFlkUytwWmZzamZSdnYyRWx6ckhFOXhLZyttem1Q?=
 =?utf-8?B?VDBJWFZHTzh5aHFiM0ZQc05iWjRnOGNRRHdYSzAveVl4bnJRWGg2N2xxN3Bt?=
 =?utf-8?B?N1RqdjEvWVFveVc1cGE0czdOTCtyeXNrbDY4SEpTaVovblRqdFNBL0ppSmp2?=
 =?utf-8?B?QjhTUHZ1Sm9IdlllcjFhZTI0T2RoemVRa1hHVjZ2RVY3VWphaHVlSEY2K09B?=
 =?utf-8?B?VEFkUmxaSW8weFZpL2xHWUFPeXZpUUx1aVF0ZjQxQlFjbzR4TWMrdm1pRDRi?=
 =?utf-8?B?WGpNNHllWDE0U3I4WUEvUzBoeWJZRTl0OTFkekcrQkVyR0VjMHUrYU0vVC9l?=
 =?utf-8?Q?OEv5aP4I6C37C3+jJDHN7qhjG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed55b298-1848-4114-7f26-08dcb882a2d4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 14:50:39.9324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZoVMz0xigEHkHCYTV4kovpGbXmTMwZegL5/CSnibcYaIU6X/h4M0gIi45vRbse1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9212



On 8/9/24 16:28, Conor Dooley wrote:
> On Fri, Aug 09, 2024 at 08:38:46AM +0200, Michal Simek wrote:
>>
>>
>> On 8/8/24 17:51, Conor Dooley wrote:
>>> On Thu, Aug 08, 2024 at 01:02:59PM +0200, Michal Simek wrote:
>>>> Based on commit d8764d347bd7 ("dt-bindings: firmware: xilinx: Describe
>>>> soc-nvmem subnode") soc-nvmem should be used instead of simple nvmem that's
>>>> why also update example to have it described correctly everywhere.
>>>>
>>>> Fixes: c7f99cd8fb6b ("dt-bindings: nvmem: Convert xlnx,zynqmp-nvmem.txt to yaml")
>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>> Acked-by: Rob Herring (Arm) <robh@kernel.org>
>>>> ---
>>>>
>>>> Changes in v2:
>>>> - Fix sha1 in Fixes tag - reported by Stephen
>>>>
>>>> Adding comments from origin version
>>>> https://lore.kernel.org/r/42c21f3bcd75f821061d047730dbbcd40233e256.1716800023.git.michal.simek@amd.com
>>>>
>>>> Rob:
>>>>    This doesn't seem like an improvement. Is there another nvmem node at
>>>>    this level? I would fix the binding instead if not.
>>>>
>>>> Michal:
>>>> That name came from discussion with Conor.
>>>
>>> Did it? I don't recall that, only discussion about adding a "real"
>>> example to the binding and noting a typo in the commit message.
>>
>> Definitely you ack it and description was saying the reason for soc-nvmem name
>> https://lore.kernel.org/all/20240131-portal-glazing-16fa36efb3cb@spud/
> 
> Yeah, to be clear I wasn't complaining about being name-dropped, just
> was pointing out that it wasn't my idea, just something I didn't object
> to :)

Thanks and cheers,
Michal

