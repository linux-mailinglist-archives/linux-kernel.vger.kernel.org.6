Return-Path: <linux-kernel+bounces-195035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 965188D469E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 10:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F7CD284142
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 08:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D0D14535A;
	Thu, 30 May 2024 08:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="WF4zwLFu"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2084.outbound.protection.outlook.com [40.107.15.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4D2176AD2;
	Thu, 30 May 2024 08:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717056139; cv=fail; b=ehEWsDZfXUe9PasBWLY5psQDzvPb/jSZSs37cHfe2DhQnxKyk5lJszysuCsETK+fVbMxwCqVwns+RaPfbmD5z7i5UFySsxS5fDL/O5QC8OvugZuu9u5l3uYy8i8li5VcM9qylvI6nqvNDhLegSuR1T1q/yDQAevrezlPziDj40M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717056139; c=relaxed/simple;
	bh=+TdAqR6+lFciN4LeRy9Mc+uYU6XMEMWoTRYqApA7lxI=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DiBZ25fNFtmrNhBADch8D/gTQY/FR79Js+cSE9PJPQl3wEpas5wlIpyXeYt5oak1sxUGIQ8NOLc3SopZH6+kGzvxt4//Pju/6DuAROaX2l5UfCmY6OKfwQ6ebvnQoDY/6C9DnuL0cfOjvOu663/LnfZ6JNAFmeTsDyFP/SxErX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=WF4zwLFu; arc=fail smtp.client-ip=40.107.15.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwllLjwonOmvU+wLQqLyd20Ua1cVQZ+x+jxEZF3ROUotxPoFQMcO1tctQiyAQSb0kiVL0mF6PC18qcVd3T6sYYaP8++QOKYtxJ/Mzma+KInRtYLN3+8CbBRmL6pXpbxsbUeg6nWqPUHLNbCbnkUuoMZH/FaXKVeZF1i7SQ/PHpsI6u7SxaX6b0dbT6htdcSDqUcIe8q5AlxKgbrkEz49Dzr/F6yu/GAC4Or+ttBvvNi/L0QKdED5rYZ96Bxh4BHM+dZngnNzjnhR4pPFmQnkkTprHBTs0bOt/sMpc8XYRzQh8js5NJf7B6zSPdO6bRMdOnoSu0u/lLJjkkw2JF7xJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pSFlB2LRP3NaSkIhHiT7/OPCMmd2JZe64xv5sAdK9Y=;
 b=i+Tud+YbMwYCzBXY1UJGgwprsXGr8/Iqh6qUo5Hlmpm+Kn86zAIxVcbV2+itzCpNk550PVHkchRpEzMdmMCIA52bbaGdEqde8z84S3HTzjlodqsnqcE+h/w+nq8SmeMfnDQuXHTHEblnAb+Py2h0VweqPBKFzPEUsRCzdrzVVfsPmDw46LIyD7IeK34SSOICjbALLXhWNf/YsvXLOXg+iV5cFzvI/DktS5nRu+1a4lqjqgluEwZcfc1uXYlK9B8IsobDHOBjH/yA9BSzZljOljyPMwhdPlZ0lWeG2Yx/q3sVeJy3ftOaJAVEUtzy3irK+oYQvcjGc26cUpYpsp0l1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pSFlB2LRP3NaSkIhHiT7/OPCMmd2JZe64xv5sAdK9Y=;
 b=WF4zwLFu7VbqRbwgUTxeUDwbYKCIo92kJtRQmQkFVmRqckBSu5/0o2DqXIRUdstGtQBFYkLJvnsBA3VeIGCGw6zoJewwqAmWXJmewODowNP8wVNSxDBV4YVWzQ6iKqVU0GPONF0kB5GkRfPN2DJUj6FiiOB6MbAQ4eWTYv2kJLM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DB9PR02MB9994.eurprd02.prod.outlook.com (2603:10a6:10:462::8)
 by AS2PR02MB9715.eurprd02.prod.outlook.com (2603:10a6:20b:5e8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Thu, 30 May
 2024 08:02:11 +0000
Received: from DB9PR02MB9994.eurprd02.prod.outlook.com
 ([fe80::f9a2:77a1:a5aa:8f8b]) by DB9PR02MB9994.eurprd02.prod.outlook.com
 ([fe80::f9a2:77a1:a5aa:8f8b%4]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 08:02:11 +0000
Message-ID: <138a7fb9-fd69-4c41-8a55-629321a28521@axis.com>
Date: Thu, 30 May 2024 10:02:09 +0200
User-Agent: Mozilla Thunderbird
From: Amna Waseem <Amna.Waseem@axis.com>
Subject: Re: [PATCH v2 2/2] hwmon: (ina2xx) Add device tree support to pass
 alert polarity
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@axis.com
References: <20240529-apol-ina2xx-fix-v2-0-ee2d76142de2@axis.com>
 <20240529-apol-ina2xx-fix-v2-2-ee2d76142de2@axis.com>
 <6b87136a-01e7-4b4b-b36f-632cf59b4760@roeck-us.net>
Content-Language: en-US
In-Reply-To: <6b87136a-01e7-4b4b-b36f-632cf59b4760@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0014.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::23) To DB9PR02MB9994.eurprd02.prod.outlook.com
 (2603:10a6:10:462::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR02MB9994:EE_|AS2PR02MB9715:EE_
X-MS-Office365-Filtering-Correlation-Id: 22660e73-a293-4a94-1677-08dc807ecf3d
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjFLQ3cyK0JBZzZjUjNpKytTVi9WUFVmMUprNXhhSTJFcjVrbk9HQXNOeVZa?=
 =?utf-8?B?M2RUUU9mTVR4aHFyUW42RzVKSHhRcjkyVDJxNjR1Uzcwd1RnQmxYOG1ZTktp?=
 =?utf-8?B?TGNTSFE1bTlyYU80VTRwNjYxanl5cndBY1JHeWUzZ0tBaGpYVHRKNjRuRkxm?=
 =?utf-8?B?YXlmTVhVRmg0OVM2QnFYdEt1OWY5a2JMSGR1dXV4QzJQVjBUUFV2MWR2eWhP?=
 =?utf-8?B?b085T1lTZm5ZVTNPS05mMzc5dmFQYXJHYms4WVU3cmdnM3NkaGxDRVdFak1w?=
 =?utf-8?B?dVRmTTNCSGFNMDE3RmRUbnp1ekhqRjN2MjJjVjY1dFJEdjJtL3prRHFyNXB1?=
 =?utf-8?B?VFFjbzlvL0owS0t1bjRkNlFyZXkxZTQ5TlpUZ1J1c0dNbDNlaE4wdkFYUEda?=
 =?utf-8?B?K292ZE13STFXU3NRUFp0QzNtRUdvZ1RiVTA3ZnhuS0tRL2U0TDFsWWc3N3dn?=
 =?utf-8?B?Tkc1WVcyYkN5cHJEQ1lmVzZzKzA5aFlMVFlqb2gremkwaDQzVzdMYzdiSGpK?=
 =?utf-8?B?d3pVVUxQb0pwM3E0RjB4dU5jWFZPSGsraFVMUGxhMDhuWmR5QTFzNWYxRGN0?=
 =?utf-8?B?eTgzNUg5U0pFOXFMb1FUZ25UdW56RnZtcGFKZXVuQ2E4UXhBQk05cVJzOGl5?=
 =?utf-8?B?dVFHZ0dCL0RucENwTE10MytibWZYWDZkRy8rdXF0bjZxclU5SXk1cVN5UXFp?=
 =?utf-8?B?b0l3VjgyRXI2Vmp0Sm5JSHVveGszMVhiWUtROURqK3dPbnZOenVMTHlkT1hY?=
 =?utf-8?B?UmdlYkJvYzJTK2NCRTZ2eWVaSGFaWXJlS2s2a3BNWXZxWGxvclJtN2NDc2Zs?=
 =?utf-8?B?KzExZlJ5dDRudUVRekVtejkxQTc2YnVNWndWRFgrcE1IOFBmL2JBYXBOS29i?=
 =?utf-8?B?Qk4va1lXd1BsMkRYYlRIOU81amNXRzVlYUM0N1JqRGFieUl0KzZnTU1zdnZ1?=
 =?utf-8?B?eVlVc3ZLWXdJZWdBNkZjZk5DMk12WW1RM1VkL1J3YlRSU3RYWGFKQ0tIcExS?=
 =?utf-8?B?MzNaMUN5MWZXY2dTemlDL1ZhcWR3UHUvVFBlL3ZOSDVjVUptY01MWi9sb3JF?=
 =?utf-8?B?Rzd1SnBEaUQ5WS9BYnJ6aG5QZ2t1VmNwTTZGT0tacG43QUcyMkhuRC9hR0FK?=
 =?utf-8?B?emN5T0N0ZVRNZENseTQ2NUxKNWFCdEY2WVN2aW5USDFHODA2YWpET0cySHc3?=
 =?utf-8?B?Rjg4d2V0NFErR3BDRmFuWThTNnAwbFZmZ3p3S245amZ5cWJHTEhSb2F3OWUy?=
 =?utf-8?B?ZWxrZmZKaVR6MFJLMnh2NE0zKzBHK1Y3T0RyQkErMHg1QTlDbmJ4MVg4RSt5?=
 =?utf-8?B?SnlxcDZWdlBLb0Uvd3NWejRpYkw5MVNtTW9xWkRaV2NjNkR2RTJORWhRYjJt?=
 =?utf-8?B?aytiWUQzZWwrWmluQkpGL2NaMkdTVDZ3QWRGV3dWQ0RRZVk3a3dBTGpoMCtv?=
 =?utf-8?B?aDhydm1yQzl1emVOZFhiak5nL0ZnUHBTRzBxUlpVUHpzTnFhVXRVQlVBa0l5?=
 =?utf-8?B?RnpPcVphK1hPTHd0enFLMnFSSWVPc0s4NHd6MFoyVk8rNysvMHI1dWV2TVd0?=
 =?utf-8?B?Nng2TUk2cTc0VmJJN0ZmbTBOL3FSRENrdERWeG1zSU5VQlZDNlJTVUtNVmIy?=
 =?utf-8?B?OUdhMllObllsSWVjek1BYzF0QW5xbWdtYUFTajVUeW1QMmdCclJNVmRvUk5q?=
 =?utf-8?B?M3QzNExBbDhXbm1JbjNrUklFbC9TSW5OUWlobU0yRUk4dHVZL3FpMUlnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR02MB9994.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dk1hUE16MDE3WnZheWI4OGtmUFh5UjhOSjg4UjFCd1M3WS9FNHdwQVQ4bGlD?=
 =?utf-8?B?dkd2ZHJQcll6c1MxZ3U2VzhuMnlSc1dZUEllUXBUK2dDTU9SUTU3V1RrSFBl?=
 =?utf-8?B?Ly9VaThGWjNPZHdPUk9nc3p3NWRwSzdwalZkN24wTHZkVDB2T0xseWpnL1NK?=
 =?utf-8?B?aEZXN1c3dmVpSmxYZzB5TnM2c2RudE1SUGN1NjNNOEpsNU14VzZvNlJpbjkw?=
 =?utf-8?B?RHJtemhOT0dLRllaZUFCditjVllQbStQTVp1dC9wblV3aVZackhpVlJ0UGtL?=
 =?utf-8?B?MFJQL2RzK2w3UEhlUTNPdm9wVk45VnAwRmR0M1FvL3AvN3d5eTFWaFNIK3By?=
 =?utf-8?B?bVpFenVQZFpzR05ZQ3Fkb1R1WkMwZFNTbmU2U3VZeHVnVi94S2VabldremtX?=
 =?utf-8?B?RUJ4dVNLUWJVTTMrWjRDeWZ5TVdlNVYyNG12eWpnQ0ViRmZZOFIwMndPa0dS?=
 =?utf-8?B?dGM4SlFEa0ZocWFzVE1jYVZEVHQ4bk92M0VaU1d2V2ttSGZ3NGdOM0NiRUhU?=
 =?utf-8?B?ZlJ3cEJrY21xTStLTFJrZXRzZEtMOXc1VUllb2h5cTRhTTZiUFRYWE1MdXlG?=
 =?utf-8?B?UmxDb3c4TGxsN0ZLUGd3Z1czd2c2MWtWQVl0SjJyVUZzd0ZRemRuMS9FMFdP?=
 =?utf-8?B?cXYzSkoxUnhYdUlmTGU0UFN0RXdqQWMya0EvRk5hYUpBeUVMY1lndTRqQldk?=
 =?utf-8?B?OTVPbkxQMXczRVVXYzZDMnVIYkp0ektIdFBtQXRmM3BwZXpJNmFzK3VFVWEr?=
 =?utf-8?B?WGxURlJ0QVZJWjh6Y0Q1bHZmZGcrVGlLN3dKenpMcTZHODBLUlJZWkEraXA5?=
 =?utf-8?B?VjNCalIySnRNUnA5VFhXdGpFZXdMNk1adkxCWVVobDFjZDU0T29yZDhxZDlo?=
 =?utf-8?B?VlNmOFprSXNFUExQS1o3RktvTngzNUgyVXBLa2dzL3FUNCtYdnVtT2pqbmNG?=
 =?utf-8?B?UDNVV1dQRWlQUjR1UjhXUkRMUTNSTlE1T1RWcGdJMWRCSzZ4TWFzWXpxOFVC?=
 =?utf-8?B?eTJJYmZWZW1kcHZVMy9Wd0IxbXplckJ4MEFaL3h0RVdIODQvVFVENHM0LzVq?=
 =?utf-8?B?QnBYZmV1b0RIdmlMeDY0REVXaGhKWU9MaVBBTUxsbGx2R0lJNnJRVVllWThv?=
 =?utf-8?B?a2Ztbkk3ZHU1WTNnZ0JtU2J0S0VrVWF0b0tmTXNHRUVqNm1xNGQwbWFKUnAx?=
 =?utf-8?B?dnRHNjJLSllWUWdmZFR5N2RxUVRuakU3WEhOSXJncXdURWhWTHE3K1duYU52?=
 =?utf-8?B?VFFtRHFUS202ZlFYVSthNlk0ODhJclRveXRVcEZxbml4bytKeXIxeGRTVWFw?=
 =?utf-8?B?YXRKMXNqaFR1Ujc5ZmgzUXdYdmRkdCt1MnNOYjFWK3M5SHhjM0tKVDJhVjhw?=
 =?utf-8?B?TTQwVHJpTzltRGMzQ09qK1lQcTYxeDJiTTEyNUxYaHgyRHZwd0VpNkpOMWdO?=
 =?utf-8?B?eUtDODBwdnFNNWJmYnk5UEsyd0g2ZW5RZG9WTkNILzRGN3h4TmYrdlp6VERI?=
 =?utf-8?B?WE1WZGp6ZXpFSkZvTDd2eXdtT1MxemRJRHFuV1hyWjQ4OGcyRXF5Y1crTWR6?=
 =?utf-8?B?MVAyTUM4bmEwNk9IYkNDakVKREEyYnR5Q0IzZ0Nva1ljaE41V1ptVGRhdUFU?=
 =?utf-8?B?bS8zVnFaVmNHOTVqYUZZNlV3ZS83U0RIRHdGemNTTkgzVEM3ZGZvZmxzeHM2?=
 =?utf-8?B?WnBmd3lidHJYSGNpT1liYm82enQ3eXRUR1F3V3NCMU9hRjYrZ2hBZ0FwUFVL?=
 =?utf-8?B?RGsvWi9LVFpvdHFNS3hrcGdiM2ZlSEo3cnREWW9wQVlqb1o3Y1BIeHJKenlE?=
 =?utf-8?B?YjJXdlhQTE42TTA0SE9SQVRXMi8vV0ZMQlpVRWNuRWtQeVRaanV3ZFVPZHJI?=
 =?utf-8?B?Y3pjK0I3VmJQNVZScThSblpISjc1cDBHVys5ckVSRjdZT0ZVUlhSRFB3YW42?=
 =?utf-8?B?Q0U4MXlzb3VjbFYwVjA4L1RFd0pPOHhJWmJOYVdPbkdiOEpvUHZub1NHSmNk?=
 =?utf-8?B?R01nUGRqOTZhNkYvcXRyRU4rTkdSTXA5QmpMYkc2YTlBZW1wc1pMNGM0dFJZ?=
 =?utf-8?B?dU5takM0WkpDa0h6aFBzVXpCZ0IzK0pubVhwWmZnM050NnVNeWZLTm5jay9u?=
 =?utf-8?Q?PAkM=3D?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22660e73-a293-4a94-1677-08dc807ecf3d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR02MB9994.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 08:02:11.3265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3kD7G5FrFHlhSNuU4g8bq6+Omrrd9+uMMWoEFZw027sdKMyRBlIUxm2lEVwzadLf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9715

On 5/29/24 16:11, Guenter Roeck wrote:
> On 5/29/24 02:47, Amna Waseem wrote:
>> The INA230 has an Alert pin which is asserted when the alert
>> function selected in the Mask/Enable register exceeds the
>> value programmed into the Alert Limit register. Assertion is based
>> on the Alert Polarity Bit (APOL, bit 1 of the Mask/Enable register).
>> It is default set to value 0 i.e Normal (active-low open collector).
>> However, hardware can be designed in such a way that expects Alert pin
>> to become active high if a user-defined threshold in Alert limit
>> register has been exceeded. This patch adds a way to pass alert polarity
>> value to the driver via device tree.
>>
>> Signed-off-by: Amna Waseem <Amna.Waseem@axis.com>
>
> Please address my earlier comments, and in the future please wait a 
> few minutes
> before sending another version to give people time to provide feedback
> on the earlier version(s).
Ok.
>> ---
>>   drivers/hwmon/ina2xx.c | 27 +++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
>> index d8415d1f21fc..9afaabdc367d 100644
>> --- a/drivers/hwmon/ina2xx.c
>> +++ b/drivers/hwmon/ina2xx.c
>> @@ -73,6 +73,9 @@
>>   #define INA226_READ_AVG(reg)        (((reg) & INA226_AVG_RD_MASK) 
>> >> 9)
>>   #define INA226_SHIFT_AVG(val)        ((val) << 9)
>>   +#define INA226_ALERT_POLARITY_MASK        0x0002
>> +#define INA226_SHIFT_ALERT_POLARITY(val)    ((val) << 1)
>> +
>>   /* bit number of alert functions in Mask/Enable Register */
>>   #define INA226_SHUNT_OVER_VOLTAGE_BIT    15
>>   #define INA226_SHUNT_UNDER_VOLTAGE_BIT    14
>> @@ -178,6 +181,21 @@ static u16 ina226_interval_to_reg(int interval)
>>       return INA226_SHIFT_AVG(avg_bits);
>>   }
>>   +static int ina2xx_set_alert_polarity(struct ina2xx_data *data,
>> +                     unsigned long val)
>> +{
>> +    int ret;
>> +
>> +    if (val > INT_MAX || !(val == 0 || val == 1))
>> +        return -EINVAL;
>> +
>> +    ret = regmap_update_bits(data->regmap, INA226_MASK_ENABLE,
>> +                 INA226_ALERT_POLARITY_MASK,
>> +                 INA226_SHIFT_ALERT_POLARITY(val));
>> +
>> +    return ret;
>
> ret is an unnecessary variable.
>     return regmap_update_bits(...);
>
Agreed. Will do it in next patch
>
>> +}
>> +
>>   /*
>>    * Calibration register is set to the best value, which eliminates
>>    * truncation errors on calculating current register in hardware.
>> @@ -659,6 +677,15 @@ static int ina2xx_probe(struct i2c_client *client)
>>       if (ret)
>>           return dev_err_probe(dev, ret, "failed to enable vs 
>> regulator\n");
>>   +    if (!of_property_read_u32(dev->of_node, "ti,alert-polarity", 
>> &val)) {
>> +        ret = ina2xx_set_alert_polarity(data, val);
>> +        if (ret < 0) {
>> +            return dev_err_probe(
>> +               dev, ret,
>> +               "failed to set APOL bit of Enable/Mask register\n");
>
> Line split is still as bad as before.
>
> Guenter
>
I have tried to apply clang-format and it still shows the line split as 
follows:

     if (!of_property_read_u32(dev->of_node, "ti,alert-polarity", &val)) {
         ret = ina2xx_set_alert_polarity(data, val);
         if (ret < 0) {
             return dev_err_probe(
                 dev, ret,
                 "failed to set APOL bit of Enable/Mask register\n");
         }
     }

What format will you suggest for line split? Is there any reference you 
can provide for splitting up the lines in Linux kernel drivers' code?

Amna


