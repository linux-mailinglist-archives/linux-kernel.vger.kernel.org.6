Return-Path: <linux-kernel+bounces-441413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E84529ECDFA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCE9516AC89
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A5223694B;
	Wed, 11 Dec 2024 14:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mZObXEFT"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C40236938;
	Wed, 11 Dec 2024 14:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733925887; cv=fail; b=St+lrjxVMyXYJTwVkw2m/TC/pRuvavVU916vJULiHTsrN+liE+EphyrDQVfk/bEzAFpcBz3dpuryhQ8Y9aHt1DeJqXH43WCaSd5FlX8hFnga/HiFZxBhSszsc6zlkQm6D5TN+zUxrOKZxmlbPdszJtdh2eUIa5szdnx4bAjbHuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733925887; c=relaxed/simple;
	bh=gdkQli2PIrhXO8cWuvVeXeELGGsmGoD4r+j7n3AxLkM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LywOZhnWGH2QEyRGnPVbUXiOuNZGDace8PoR+0BhHYJNGStCOj1MqdQ2pQuVviyOAQoZc7Gzo90toNMepoLYlVMqcrFsfMPpqol0XHr37YiRIZf6IB71qxSrNXGFrTo0pGwF8H/KplqoYUr09dfKhyhvk2DZa9uSfX/0ssX5n6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mZObXEFT; arc=fail smtp.client-ip=40.107.100.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wVV5a3BA75Gd5MI7oDgkj276Qk5e4hWOUSqNw1qqV8nHjMycHu+1P4AsXUZFp9beagW1MrcwVdBR+96GV1K69H0ojfKw4BnpTvEcauvjrrf+gloNbj2RJ+6bTsASAW4h6CXnyFpR3Fwl6vsE1rDiuIUXqAd1iIlRRisOJVTLbuOBcpOltkwtz0Z9czkFFw+pkHYDPUvkhyWkxuzRcijZ9aBfYT8g/UfebArXGbnv97+sWcD0uqVtBAqoeO1ZxaDIPrhUeonDl5F5HJQuzHP3DMeQxKPjaGE/sLbrPJBRYORS+S+kLTl/oMB2eP7Klu+OoKhNglbSvJ3/etbT0UztDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvwiMYvFWz94YGz1OTLJvAJ1VyxaiP2jEdIJA0x5qQ0=;
 b=IAWVPTFIuHmnNh1RQhy3xM2Zr7Mv2+DBy53cfvOlqYPsZQkifF+6HSgCnZHFbzzphcEqrB7ZmSynFPmEGJCfc3a+iS8yM1vRoEskIjcynbNgDARVFvFJqocIfbpznX1w8AHFC2fK+Y7BLH6hZM1btUZm2YpPni2kNtfe/9+9Ea+9IlKJAa4kE8TRILATrjnzKWSBGmm4tz/X3YkB62278/31n7tumN2XKPbdA7DdL2F6WDFIYfBxp1Ne4lSGpubYA1uegEFnoea/8ZLRUAUxW5JfVwLeq78cwwyXl5LQfXDZaNshkw6Gjaij3rw86izri/XWSisl6XLTCrWIiEcguw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvwiMYvFWz94YGz1OTLJvAJ1VyxaiP2jEdIJA0x5qQ0=;
 b=mZObXEFT3d0cm9zp6eARMvIPsbVeCT8WGQtvlmpUpaVxR+fRfCBaVbhikTMgteHG3zQC4ns/3hNma/j0zRC9uYu6yqAIWcfiT+CvOw3k+yx9xbQnhZl0SGPKuiq10WTIRZBh8pPwFlJDJx+y89bu66KqymUm+7BeGd3BNuXD7Zw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MW4PR12MB6976.namprd12.prod.outlook.com (2603:10b6:303:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Wed, 11 Dec
 2024 14:04:41 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 14:04:41 +0000
Message-ID: <344eb4b3-1073-4c65-a8ba-fee943776627@amd.com>
Date: Wed, 11 Dec 2024 15:04:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/15] ARM: zynq: Add ethernet phy reset information to
 DT(zc702)
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
References: <cover.1733920873.git.michal.simek@amd.com>
 <9e18d59ca339804320d2a5e3c7362aefa3bb7c99.1733920873.git.michal.simek@amd.com>
 <8395fb6b-d7a5-4e2c-9eb3-4984b8c775c4@lunn.ch>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <8395fb6b-d7a5-4e2c-9eb3-4984b8c775c4@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0245.eurprd07.prod.outlook.com
 (2603:10a6:802:58::48) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MW4PR12MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: 01586b78-3b23-470f-bd61-08dd19ecc1e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWdxeEg3SHVOTmtUN2VuMy9HK0JhZ2lvekhpaXlNbytZR2d1NjNRTW1SdmtT?=
 =?utf-8?B?dkpQRzBWc1d6RG5zempCL0hieTNORjRMNkdrNmJYdHdveXAyRnVtN1pRVjdT?=
 =?utf-8?B?VThUejlKWXg0OHpDbnBSMktXd1AyUmg2Z2k2ejJjNW0zREFCZTh3Ui96RDlu?=
 =?utf-8?B?KzBPY0p5Y2hSeFp1eWl2c0NJQk9Xc1lyVGpFZXBRaVVLbyszTnhMeXR5WFJi?=
 =?utf-8?B?V3RMQlhMTnFnajJZVUpGMHAzYjZvS053cU5vK0NoRk9XQURlbHpMbVJ1cVJK?=
 =?utf-8?B?MXJEZXpFZ1QwRnVBZzBaa3N5VWtFcUFLNXROanFMTUZpcGlpLysyb01FUzlE?=
 =?utf-8?B?ZXBFOEZWbDc4SkwrZmlvYUdZZEo4bUJmK2ZoVkJFWk1aSW1HMXFzZGRQNFZs?=
 =?utf-8?B?Z3JSMG04V2NXU0xkSHhlcUtQUTE5WEszS1FLcVlteU10Wm9idWVIU0JwTHU5?=
 =?utf-8?B?bnJYUjc0cUo0QWFWVGxianJoZnBsSXJPdFY3RDBGOVZGL01tSURRdEI3MlNp?=
 =?utf-8?B?dUtLOUpvVkNkcUxpR0dPNkNzS2Z3OGoyUTBKZGJBcUdtL2FQNUFUR3k1aFJm?=
 =?utf-8?B?SUlkeXFBMGsrQ25Pbm4wejQ1bVBtNmJiVWx3dS9xRkc2OGxHQlpsdVJwR2sw?=
 =?utf-8?B?ZFU4R1NicStsUG8zZExlMUNaeFdBNHJTQlVmcStLUlI2T3hXbmhSM29lU1Fz?=
 =?utf-8?B?cjFyaW1mdEt5OTF3SUliRjZHU2pYL3dmMDJhOW9BVjBTc3ZTTEJ0dVp4ZHVo?=
 =?utf-8?B?d1ZLbUVTUjZuNk1DT3RzSDJiQXpkL2VqK29yT1lmZStXNlNKRzNxdEwrQk1S?=
 =?utf-8?B?MmhnaEJlTGRKdTIxSHhyb2x3Si82VmgvRzJvQ1oyZDQ4UnF0ZWVkaWVGdGJx?=
 =?utf-8?B?dzhWS3RpVitqcThGbTJVTlZKckovQVFZQVBFdi80ZkdMNWEvclNEeEZkbzRz?=
 =?utf-8?B?RHhxazVSWkQ4NkdYRFU1eU5HeEtTczVwa05WL282eFplV2VyTnN1K0ZGWGpN?=
 =?utf-8?B?UjlZcGM0cVQ3RU1pSDRqd01FcjcrRU9pMDVKNkRwVGhnZm5NYkZ4T1VxYzRm?=
 =?utf-8?B?STdrUUxBYlZ4bjUxejdjWHlIbUdiclJycFc0ZURUbDlNOGhGM2J3WDVDeXo0?=
 =?utf-8?B?QU5TMVgweXR0c1hwVlJsd0xkcGdON25sM1gvSk1tNldUUTUvdmN1bHg3MWhq?=
 =?utf-8?B?WlBKQ3Vya04xMmZpZGJOcXN1a1UzelduSGczNkhBYzJOSzdQSEwrbVorOWw4?=
 =?utf-8?B?VWRTRjZVaTIvMGg4a05ZbDQ3WmVISU5JSWlzbkx3SU9TeDF3VXBJRVd3SEVK?=
 =?utf-8?B?TTlWSEMxRnB5YmZzV3paejIrSWFXTEszQlVvSWJWVDhnSTRiOEZOdTRwWVk0?=
 =?utf-8?B?eFVTbkcrYmZJTFlUd3VSM3k1ejI5dlVUaXNtcmFGL2FUbjVSc01sVEU5ZE5Y?=
 =?utf-8?B?eGhrdTFJNmFyeXRzTTFCQ3QweXdHZWRjakVSVUc3MGh0Z1N4alBrWEZTc0lo?=
 =?utf-8?B?K08xS1AzcTFwVUdBZmw5UHljWWlYT0NaV2Fqbm5YWkEyV1FET3JaWHBiMUV6?=
 =?utf-8?B?dGV4OWNlTEEvVDZUWEFBb2N0czE3VjJ0cDJzUDdPOUdkN3U3UGlxaG40Rjh6?=
 =?utf-8?B?b1FRWURqenVBMGpydGZlR1VwbjVnaWVJMm50ei9vRkxDbFA5U2s2UnZrdXU4?=
 =?utf-8?B?U2ZNS1BQeHpoQS9GZzBSY2w2NlB6MDBNN3NJNUllVVpSK0RqOERSbmFkb0oy?=
 =?utf-8?B?SDdGdDNlNUFHMFF3TFVSR0c0OTdUcGZFMTllaVRDY1VSMm1VZlpiaGJnYjNn?=
 =?utf-8?Q?rfDflSSTVyv+Mjql7S0KuwO/gphwlVEjw2vcw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzFBbXBpcWNJNWl6cVl1WmtpL1RQb09BWktqazc1c3JnRUQzeUNEb2h4VkNp?=
 =?utf-8?B?VldiSHlmZ0pvOEZTK1dPMWl0ZzNMbC9hZ0I1WkRxaXJoQmlQYjNKcWxUNGlL?=
 =?utf-8?B?T2JtVXNKQUFEanRlUFI5YVc3SlVLa0FqUEJtandNTThlRWF0QkJ4TmJFUmls?=
 =?utf-8?B?bWFMZ3pvRFhwVXYrSGRjKytEb3Z6dmlJYVMyd0JkUVdXMHVINDFYMzhRZFNa?=
 =?utf-8?B?aFVYWDhjWHl6aUJzMHEzbHRDdzc5aVVDYzhYNGNnMzVjLzdnNW5VMkU1VjNU?=
 =?utf-8?B?QlFGMFM5NFhwb2NMK0pFeFk0NzZYd3NLM2RPTVE2d21LSElCd2UzV3d6a1hQ?=
 =?utf-8?B?NVdyQk54UVhuajIzQ3JBTmNxejhNL3dsa0xoeGRZYWIwcXk5Vk10eStEV09I?=
 =?utf-8?B?Q2h3ODg4QWgvaVhmeUtxanB2U0FJMXVoYjF4akdCTTJ0OWRCRW5UY09Tanhw?=
 =?utf-8?B?MGhaQTkzdFhjV1d1eXB6a3dMck1DSEE4WFJjUFFEUmk3dXg4RVhQNDlZdEVU?=
 =?utf-8?B?SU8zMHU5aFdLREZ1QkJYZWxJOFoxbmZaSEpxeVZ5cS9tbWlUSnMrUGh2Z1A3?=
 =?utf-8?B?aDNrSXN3NzV3MXVIbEZzR01MajN6UW5GcGNhOHRDVld6aUhBd2NWRjZvUStK?=
 =?utf-8?B?MExma3owRVZYM0J1MjRXWEtsMjdrYzJOZ2lqRkZGZzNWSWlxdkVrdGxLdVR1?=
 =?utf-8?B?ZXhrcnJHZXhBVHdyOTZsMng4QkpvMDFyTDhSb3FMOVplZzJSYTZFSXdsTlVO?=
 =?utf-8?B?RzVaTXQzR3IxL1FXRTdneXBGTXNBN1lic1dIS2w5ZUQveWFtMUtxdjV3cUtR?=
 =?utf-8?B?S25pRTEvSHFNSXovZktWRGsrbUExRi9LVU5aUUMzcDNnOER2M3krS2VqT3hl?=
 =?utf-8?B?STVVb2hWdXdGUm9KcEhWWkZqRVlzMDZ3Z3dJS2F5NUtxL0VzdTlMS3VBQW9R?=
 =?utf-8?B?TTArQUwvTlVWUllkUFBwOHhqam5NZTk3YWdtQ2p5ZmhmRHN6QUc2a0RubENm?=
 =?utf-8?B?akdUZ1Q5Rm0rMDYrdTVXRWpBaG00TGRYeVR6UUE4MHFoZUxkZFJoWnBYMWlU?=
 =?utf-8?B?RFB4enJ1RDU3MWg5c0dxSEx5Qm9kM3VOTHhKMytXeXdqdVNOS0xMVkJ5eE5v?=
 =?utf-8?B?S29TazdxL3F2ZGFlRit5SlFOY0hmWnMyUjVucVRFUWU3RzVQRFRwQ0x2WC9G?=
 =?utf-8?B?dEZOQkN6SzVpeHlGSmdNRDJicFFmc3lDcVpXVU5LbHliUWxURnpMYTIyaC9E?=
 =?utf-8?B?NGtSTHNoWTBMRHBvTE5EQjhJQWRyYUs2aHVSQ09COURwdEJDT1dEZlRqWUhO?=
 =?utf-8?B?MnZnSjFBS01ZT1RTcWxSQXJLWkNtSi93cnB5OU50ZGhhWXMyNzNUN1Avc2Rk?=
 =?utf-8?B?TXIycERaUFdqVUxTeEJINlVZUkM2UmxWOXNJSUJVNmJHMzBPdUhLWC9zRnFN?=
 =?utf-8?B?NDV2b2ZDemE1MUk1azArVGorbUJMVnBIemZIeFBCelcrZVYyTmh4VW5mb3Ur?=
 =?utf-8?B?ekJJaHpyb1RRY3phMVJwN0JzZ0UyeGlKREZHVm5QWWRIUU1mSHRIaWRlN01X?=
 =?utf-8?B?Q2tzbmFReUlQY04yUnlha2NaZzY2Z2p6NWp3TTdKQ0d5bXdFVmp4bktqZnRh?=
 =?utf-8?B?WjA1YnY4T1lSd2laSTVCem8rajg4Z01yMm8wSlcyaGs1SVpDZmcweTZpa3V3?=
 =?utf-8?B?WTRHeTcyRTZLV0xVVDZNNlA3TGhhdTZCZ1NvQVI3KzFGdlBsVE5NYjh0MFdH?=
 =?utf-8?B?ak1QNlBlaE5wcmZmT3BQZ0JFMzZybmhDYXZwTlhZUWlSU1owNDVmdVBXSGMv?=
 =?utf-8?B?R0NNRGpDOWpvM3NUUXZaazhQZHQ5YTBMQ3d1RjdmcXFHSHhZWjcvU3B6U0NL?=
 =?utf-8?B?Z3dmWnF3bzNOVUJmTkhSSklxN20xT1BneWRTRTQzdEk0Yk1WZmNVeHExRE85?=
 =?utf-8?B?RWdOb1ZKenNvUVZVTUlOaHpzVGpBQWk1TTRSRVFIRW5TS3ViOTVKanF3RWc3?=
 =?utf-8?B?UHV5cXZHMCtzeVM5dGx6RDNicnFyRXRCa2J6M0tOZVEyQU9KaTJhV2xOU1N1?=
 =?utf-8?B?SWE4YXJiTHpkcXI2c3BCUVl1MkFkdnNQQ1V5NFRyQ0FBMGMwdk5TcGYvcmRi?=
 =?utf-8?Q?ZB+xvD1goMjkRxV7z0RjSuoyn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01586b78-3b23-470f-bd61-08dd19ecc1e7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 14:04:41.6086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLwEfL2Wujnv42uSjuwe03XSvaXqVjiHsys4Vgf506O+ElGn0K4udONtvWsaP3Ry
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6976

Hi Andrew,

On 12/11/24 14:45, Andrew Lunn wrote:
> On Wed, Dec 11, 2024 at 01:41:26PM +0100, Michal Simek wrote:
>> Added phy reset gpio information for gem0.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   arch/arm/boot/dts/xilinx/zynq-zc702.dts | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/xilinx/zynq-zc702.dts b/arch/arm/boot/dts/xilinx/zynq-zc702.dts
>> index 424e78f6c148..975385f4ac01 100644
>> --- a/arch/arm/boot/dts/xilinx/zynq-zc702.dts
>> +++ b/arch/arm/boot/dts/xilinx/zynq-zc702.dts
>> @@ -79,6 +79,8 @@ &gem0 {
>>   	phy-handle = <&ethernet_phy>;
>>   	pinctrl-names = "default";
>>   	pinctrl-0 = <&pinctrl_gem0_default>;
>> +	phy-reset-gpio = <&gpio0 11 0>;
>> +	phy-reset-active-low;
> 
> Hi Michal
> 
> Could you point me at code which actually implements these two
> properties.

I have tracked it down and it was only used from 2016 to 2018 in Xilinx 
downstream Linux repository. After that it was removed.

If you are interested
https://gitenterprise.xilinx.com/Linux/linux-xlnx/commit/6f43a25c416e532530eaed897acff6f5249907e4

> 
> What is more normal is a reset-gpios property in the PHY node, or a
> reset-gpios in the MDIO node.

Thanks for review. This patch should be dropped from this series.

Thanks,
Michal

