Return-Path: <linux-kernel+bounces-566572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDAFA679E8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65BF6188F783
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784BA211485;
	Tue, 18 Mar 2025 16:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J+OF37c6"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2087.outbound.protection.outlook.com [40.107.95.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A62204C39;
	Tue, 18 Mar 2025 16:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742316149; cv=fail; b=R1qQD0ieG2hQ2aeimRLHEN29X7JlR+gliz033fdXYkzHYCJXTs5H+d9gThhuu2N4Vse11ECy54gM+eYrdtaOep93yoM7zfJL+MFOsYlfE4UgH1B0f9k8wyGfMDJxpMQU5qLvziUFVpMgj0eLXqd/FWVNH+RhODTZ9YH8xrYaPMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742316149; c=relaxed/simple;
	bh=sYZTIwQ1JzeNzCId6SVjvR0UiqNZCxkYDpoTIQQKRyk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VblfPqSihDn+dPaz7zaOdAdD3FAK5eW5Np8q5cY4c9Dl/cNio0VNOlfjnNyCeR38nYyVUzCPGq8Hvz7DqrvFzugcFMtRXrx3zQ6i7XiMRSnWHXdJnxvVU9ZUS/JsRFjX1b7cFRtoGEwN9NhAapcUnRmeOn4k1w+oW1tgEqdXhls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J+OF37c6; arc=fail smtp.client-ip=40.107.95.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QsLsOYAFd8IdGp8fY3u3ne44I0YujrodfIK0vyXyUH1VRunVk/ZHwyUXw4Ii8EtIlFT1Uj0EUlJUbnPdbGbr7nsi+KM0EUSd2cyduvUy3thQSA4y7KRtzLeipy89Ar5aEFPqoglsq+uPI4udjuztCvCO3pYvDJD4duL9xoZXaz8rZixlKaEt49Iz8oMNP7VI/N7tkCGmgTn/BfYCJtyu5IYU3cfUpWqm0OB8ZOBBoPwyBoDl79mo0w3B/nh6IomGPl1gBGLWyj0avxwv/uOLAblaoW4Gp/kExzJ8sihU5H6J0MBJ1ZXhMynVegj9fCHCK+5KsHHKi9WZt5O9k+qhDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tVXFg4XT8D58Q5q+fMRDShGpR4/5vBqONl6jNq0duw=;
 b=HDibPUIFmEub1TCwwhaX8yba2FHy83cHk2CAfXE0mlF19Liar0NW+9Gvnd6m/Rhve2c+qad1xmSRMOVgJy58BP9qagH6NFdMKI+5KHxV8AhL6osdS3VyJkAYV72Fj6iHlBc5Q86NiTquDiww65VG5zQ6iLGGvSZUQxLe5edgHPyTn3+SbiKmwNjksTj5ddrLDfQVXNNvUGzahQMijcORDf2hVIWREDoNzwu0VHiVfwsMNFNQ9kbk5UO79IRLmP3RrqWwWnx7qyXDCCp+UWN2kIBlLiak7hrbxzWZP2qiDbS6j7dSZO3ASHCj6Ciq6SiuHOldJgTJj4kZQ//RUnmUXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tVXFg4XT8D58Q5q+fMRDShGpR4/5vBqONl6jNq0duw=;
 b=J+OF37c6imMrCn0etMKG666Ofq9O91qtYM00bVGJQqu0iaY09PbZImTHPKSsnMlunuhRdChag3f4nN2+x15ssT00cHPCaVB4guW/uW67r+ztFq3QXMxPN2aKXRN0Gg6oVF7/2Luw0dS3I1T9jXX80HpNY6dIhhA4IFiep0i0SlI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6285.namprd12.prod.outlook.com (2603:10b6:8:96::8) by
 BL1PR12MB5756.namprd12.prod.outlook.com (2603:10b6:208:393::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.34; Tue, 18 Mar 2025 16:42:25 +0000
Received: from DS7PR12MB6285.namprd12.prod.outlook.com
 ([fe80::6acf:b37d:a152:409e]) by DS7PR12MB6285.namprd12.prod.outlook.com
 ([fe80::6acf:b37d:a152:409e%3]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 16:42:25 +0000
Message-ID: <bc27b658-5c62-4187-acdc-df8dc22161a8@amd.com>
Date: Tue, 18 Mar 2025 22:12:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: aspeed: Add AMD Onyx BMC
 compatible
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Rajaganesh Rathinasabapathi <Rajaganesh.Rathinasabapathi@amd.com>
Cc: devicetree@vger.kernel.org, openbmc@lists.ozlabs.org, joel@jms.id.au,
 andrew@codeconstruct.com.au, robh+dt@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, jothayot@amd.com
References: <20250318041224.1693323-1-Rajaganesh.Rathinasabapathi@amd.com>
 <20250318-rapid-coot-of-tact-d779ad@krzk-bin>
Content-Language: en-US
From: Rajaganesh Rathinasabapathi <rrathina@amd.com>
In-Reply-To: <20250318-rapid-coot-of-tact-d779ad@krzk-bin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::7) To DS7PR12MB6285.namprd12.prod.outlook.com
 (2603:10b6:8:96::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6285:EE_|BL1PR12MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c433781-7f34-4f3b-4f07-08dd663bdcfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3RkVE1MTnB5N3VNaWc0bDhqRlUyYW1FWEZmcGVBUldjL3NER1Z0YzY2TDJC?=
 =?utf-8?B?UHREd3FMYXhjdU1mUXdUOUF5V1FVa3N3NFNjZFAzMVdsYnVyU0wzTTNSb3gx?=
 =?utf-8?B?VU5Qc3Rtd1NlakhiR2pSSDZoODMvWCtSbysvM2lkOE5qdnBYbDhvVisyYXJX?=
 =?utf-8?B?SHdmRklXWFRsOENHenJERGpyZHhnK3JDV2s2ZW43ak5LdE1ZTXdLUUlOMHM0?=
 =?utf-8?B?bDJCbW1BOUJrK1kvMlVaUkVyS3A2UTIwZDRrQ2pmR0JlamJFNGx6RkMzNEtJ?=
 =?utf-8?B?blI0c0M1Smw0eEJTZHUrUm84RVVkT05lYitIK0lsMU5ZUjNRdjdERzg4WFZy?=
 =?utf-8?B?VGNRS1ZJNnZqRmV3Lzd5ZUNxN3ltTHhxdytCS3dHcmZacmtWMVc2ZlUvdFM5?=
 =?utf-8?B?NVZkYmxBYWlaZGsyOUlUUFMyQmhyc2g0SmRGeXphQWRNTkQ1YmhVbzR5aGQ0?=
 =?utf-8?B?c0NpN0tGK3JvZFBIU1Q5WVkrN2h2cUpXOVlvWFJaNTlTdEtDdWR5SEFkWGNu?=
 =?utf-8?B?ZDYxT2NxSHhLZjI0T1ZtR1pxK0ZhS01sc3BDQjN1MTJ0c0tHMC96QkJ4bFUv?=
 =?utf-8?B?K0UwVDdlTWdvTmFselF4MGFJeWZYbTR2OGJFdHhweDVvc1dFOU13eHNFMTkv?=
 =?utf-8?B?R05ocXoxRzJCaWJTZDBFVUI5VHdhKytjQ0VYeFNpUC9pS0RBK1gvemRCczRm?=
 =?utf-8?B?L1FnWlZBdlVIQWpFbXJxR1VkUDZYeVd6SUdsZVpGckJlRE9paVVrTHFkTWlE?=
 =?utf-8?B?aEhYQkVwMlZFNm9sRTRhTFU1aWk5d3duVllheVo2RUExYStndWlna1hOaXVr?=
 =?utf-8?B?U2VWSmVSdmh4b1haellxVnJhS2JiSjVNL0hnczQ5eVhVQXJKU0lOTnU4UnFw?=
 =?utf-8?B?RXZtaTlBNm1pVTJwbFZxYjUwVWxsRDFpR1NSdjVaM1MvZXFSMk9wVlVpV1Jq?=
 =?utf-8?B?dWoreUViREpROVBIcjBaMXVqQVlNT0YyeTlpc1YwcWZDUmVUcjBaN0xMbnpy?=
 =?utf-8?B?OUdYOGRXUGVxVE1CWUhiczAvUVVWK3ZQMmhGYmZzbjl6a0tjb3o5QVQ1SXdh?=
 =?utf-8?B?Wlk3cWdVN3hVNlR5Vnk4VDREVXF1V2krN1p1RTNWa0tiNi9RY3JKZXdaczJz?=
 =?utf-8?B?UTlxR1lCekxadXl2QnVUaXlBNEl5ZFVZSmUvS0lPWmM2eXBVcHgxa09oNlZT?=
 =?utf-8?B?eVlycVNiQklQMm80akN0TXF6YVovbjlEWHBlbGZrTjAva0tBS3MwLytsMG1E?=
 =?utf-8?B?dkpNbnl4cTcxSHA3SDNGUU5tUW5sWU12Q1BpK0FPZktiaExsck4yVFJwNWJ1?=
 =?utf-8?B?T2JKNTFYaU5DT2xZWWhMQ1ZyMjJsYmIrVlFseUtwNFh4TS8wbTYrbFFjREcv?=
 =?utf-8?B?YnVjbmVSd3QxaFVlTWdyYUtmQzIzNllWbXdhYzlkei9yMHBOeXE1czZTdGti?=
 =?utf-8?B?ekZtYlpmZGlpSDhMVlRJRkV2TktQRlYxakphcVpnOE1oeW1ZQm5FbDdhOU5a?=
 =?utf-8?B?c3J2S0VPL2l0S0lNZlcxQjR4QUlXTnJNRG0ydW0rWW1CQXRNMFUzRmYwekF1?=
 =?utf-8?B?aVBEQW5nNmRxdkRkZjJudFlwSnJ3TUhEeGFBc1plZlMyVUdsSDMzM2RHdVhX?=
 =?utf-8?B?OXlyS2poMUdoZ3FCUkxYUEI0dmxjS29SQndMVjJtNDcybzhMZjBUR1M1cDc5?=
 =?utf-8?B?bVlpekJyR0xtcTB4WW01NXE2MEQ4aGxVM2pRMHBUKy8xWGdTanFDL0VIUXlu?=
 =?utf-8?B?YlBkZ3liY1JsUzhRbGhBeGs2bVAvNGd0RHFXY01peEp6d0xGc1pYSThFeGdM?=
 =?utf-8?B?VzlMdjEwNERIWlUxN3B0RTl2Nks1K28vaXl3eSs5dGdWT0tKazVBOFRITDJo?=
 =?utf-8?Q?3pElYVCDK5XOd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6285.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUVnWWp6QTgwQlgwcXB4YWNRc2R2K0pQZWNrdFJUb2ZPU3ZLWjZGa1Z6Vzhl?=
 =?utf-8?B?UDUrTkk0VUZSK3hOQThNOHlLVC9VOFNQbFFzUDhkZE90d2tXUWh1YTJNbzBY?=
 =?utf-8?B?L3dnYldoYnNUak9DK1lOT2NoVHhzVGRadUVhaWF2MlRpbDhuQ3JtQ2tZS1lp?=
 =?utf-8?B?aWc3MGFKYTZWZm1IV0kwMHBwL0g5elAyRzZlWll2dVJkQ1lwQjRDTmlTb3RE?=
 =?utf-8?B?TkpyNkRvSUEvQWlrSXhRTmRxTTRrUExFbGc0MFJVMGJmNk8wcjd5NEVaV1J1?=
 =?utf-8?B?RmhZVVhWdnhzRGdwd1ZtSnNPSW5McjVQcnRGQmRzeE5VOFI3RmpiM25PVSta?=
 =?utf-8?B?NWpDSUtiRm8xQ3ZOOFdaYnVZRUdNYktHeFN1a3pkUWJFZm9rSlArN1lmVzdz?=
 =?utf-8?B?ZWNBTnVEczd2TnBUalZmL0FzSUp5Y0haQUdPeHFBR0tPZjdOSjFQTWtaSU5n?=
 =?utf-8?B?Zk9GRUEydHBEdnZBMUpMY3c1azU3NlplRnpnd3JGN01vZzhjdjZKamlOa3g0?=
 =?utf-8?B?eW9ZZGViY1FaOFlzVnZXM0h6UTlwbXpiL0RQRFIrenpTZUg1cUd3aE56MU5r?=
 =?utf-8?B?MTY1Yk1HWk9hcitjTHhHWkk4dzFlU2ZnVFhSdmp4cDFrcHZRcFlXUy82WUk0?=
 =?utf-8?B?cm51U2g0RUwwdHJzQVpoYkttaXZvWG5IZ2doWlIwWWVlbGE5ajJJUUlVU2pv?=
 =?utf-8?B?YzRnN3Bic1psNkdraEIzalFXa1IxcUQ2dzgyaEZJWEV6a3diZlFlZmVhZ1kv?=
 =?utf-8?B?dUpnT3VvOUNTNzNBejVUVjNFUm9nOVBCZHFCSEVHRCt5K1hsL3ZrYUZOS0xt?=
 =?utf-8?B?NHIzYm4wemxBUjFBOGdpdHY1UjRsSFZLUjRZaU1uWjFlQnZGeUlrSTdpWmtq?=
 =?utf-8?B?WGcwVVh5blozMWg0WlRCZWRLaS9HbGtud3JkcGpjS1piTkk2em9pY1RWc0FB?=
 =?utf-8?B?RE9qOGpHS1EzYVNXSndRdTNkeW9GeG1raUxzMWdBTFBpUVh0MW5pcG9TUVZD?=
 =?utf-8?B?RzE5RlVwSk5XM3M1VXFUYndUN1NoYkYzeXlPc2VZWS85TnI1a2pqQWtSVExK?=
 =?utf-8?B?RloxVDN5YmZaYVIxdmhXSjVvSGJFTW02ejVpYjVETXVPckx0dmdIU1NtWXNQ?=
 =?utf-8?B?cG9jdjZrM2JEQ3ByM2w1cDFEY1k1V2ZNRkQyUFQvTStiNlBOREdCcE5lU2JI?=
 =?utf-8?B?UjhoNitqRGRXUTRCUlJOU0NzTkx1ckVFWUwvSk1nN1JwWUlTZ1FLdHFXUTRr?=
 =?utf-8?B?N0gwMjhvc1IwQVJ2cjVZcWltbXQ4dDR0NG43WWVGV1N5cHlEZzdMVTJmcEpV?=
 =?utf-8?B?OTU5dWllWmgzR2NTTGdYK0d4a05pY0xOcVE3ME9rd2VpdGlaQzdKR2VRdllO?=
 =?utf-8?B?T05uVlBlQStGbTQ0Rjc1QjU0bGkwMGFqUkoweFdPbTZOUHFEUjVXMlgzLy9N?=
 =?utf-8?B?bHNRRDJCYVgzZ1pObUJQamNPc29YdXM5WkNTNTE3SUdyalZhblVVNldzanNw?=
 =?utf-8?B?M0hFb1FlVmVoUEowdGRaUGJUSFZsdkpYTzZzV1VLZlhnYVU3TnF4WXY1UWFk?=
 =?utf-8?B?bXBoeWpyNU93cWh6TWVmQk5weWJrZDAvMXBNaW1uZ1RpLzh0M283TlZnNVdZ?=
 =?utf-8?B?eWU1RkpWNWdhNzdyL2xjK0FBc2hXNGxkQXhCbERSYXlRVzhCb3VSa3ZDQ0Rx?=
 =?utf-8?B?ZkdXTGVTYU9oc1JuRTRWdEd2VlVUNy9lTmJweDh5SFkrOHZpbGdnN21jV0gx?=
 =?utf-8?B?T2JSTHM5SmxsK1hvUWNiT1lycXd0dWUrVXU2M0ZuenJucXBILytjbU1raTFq?=
 =?utf-8?B?dTBZRFNKK2R6M1R2eGx1a3JwTFgyaWV6MjduUDllcW8yQloxbUE1V2lMQ3k1?=
 =?utf-8?B?eDZiMHpKeDFjanBSS01mZWJLR294OXRENEJoeUxzNXpWSzYrQ3VzQmlJdzdy?=
 =?utf-8?B?UXoxZktCaUZBTW1WKzVoYVdZS2JXTGVjbllCNEpjS3ZPUlpwbDd1RTluaDVv?=
 =?utf-8?B?ck1FcmIxNFBRTE5GMEZBTjBTMHE5d2t3bFd2d3BMRW9iUW50WDVzcVNBVUpV?=
 =?utf-8?B?cDJjRTBMaklPRE96N2RPM1BjRFdBMXZCTXRaSFdna0tONGpySjJWSDRFcHpa?=
 =?utf-8?Q?qDIg8g7ppPpbM3V5ZiN2pjN4w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c433781-7f34-4f3b-4f07-08dd663bdcfe
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6285.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 16:42:25.7075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xx0/iI46pJ2yfGiVxR420hE6tCjSbb7eRG8oqatKbSL+0YiRoa+fZiWkSY8lIba6aUiLmbvtez73MGN0o6WTbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5756

On 3/18/25 14:14, Krzysztof Kozlowski wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Mon, Mar 17, 2025 at 11:12:23PM -0500, Rajaganesh Rathinasabapathi wrote:
>> Document new AMD Onyx BMC board compatibles
>>
>> Signed-off-by: Rajaganesh Rathinasabapathi <Rajaganesh.Rathinasabapathi@amd.com>
>> ---
> 
> Where is the changelog? What happened with this patch between v1 and v3?
> 
> Best regards,
> Krzysztof
> 
Earlier patches did not add dt-binding patch. Added compatibles now in v3.
It was a review comment on earlier dts submission.

