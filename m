Return-Path: <linux-kernel+bounces-515776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1609A368CB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F02FB172BA2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D0B1FCCE8;
	Fri, 14 Feb 2025 22:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="feVOdXBI"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2095.outbound.protection.outlook.com [40.107.223.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEE11FC7E8
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 22:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739573993; cv=fail; b=e0BjJ/3Umw0jQVXPI8kSZx+zQS/MCbo2g9vCwTtwO8iqMe2kPF9VRcTp0MyNQe+55rwYbFsAinWanCA/vH5yHUd01snNI1XqYKZU7T0HCDUnguBFpgM83emrJprUgXuEmq1RuCI/RsAkYWTck/DbAzLDBy8oVrqItMZoVZJAXvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739573993; c=relaxed/simple;
	bh=ly+1qvDer1iHKOR1nrYr239udETT4IRJ2EkWJMyy2y4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d76+RKm4oo0yXJsvqkQQAheh4ZOP9j6W8f4Tk2P8wSvjB2dkvYQV77QpqtSg8DAiF2HO0lhBwtDxn42X/Rzbasa71zhzRxup+jHee4OW4VDZLafcbcuTxjtbvUzn8pA3Z5P325/hLu8wcTD0xq+QWH18pyXw3DhbUqWzHN8ZsUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=feVOdXBI; arc=fail smtp.client-ip=40.107.223.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yarfUVLJKNPVIP6EVicl+jnwwmSH4OqB2Q9LWhk744/OUM3WrQ+KNN8/D2T9z4Z/kzXBG2u407rUB8Koke81e2B4jzJNQCsScJPq8J5U3YBAdvYr9CFsJtbyklXvbK1qLa3HfcWIAHi0IObpIXVagB7uJfKyAVt9G6hTjHD3rHkZa6KWPvEzSe8JU0NlVkxCifvJByTL9iTWysF+nPrrDVgK7ZyUK9+hMrN83KHzXnb677wAFWY+tJHh7Wde5+zERtsdCAkWgKOrBpSJfxqXr6OIq4Wmqi+qZV7GPLjX+Giinha7TR44NUk9LERzyDQWMvea/IqlJ46LNUGv3F0ijw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnYRGbfXnOzfjZuP3bqY/+902uncxE/OoBVDXfvZnWI=;
 b=U4ZgfdzXrfIppN3yOitMZfNPooPiI3/JJ0QBVL1HMcETnQ5ZNoq9eaxTnG+Z7puId3f2cA88ZI5BFjyCE3gyWDCRxxHuibQUsi9l3BWSnVuudKGXZgSUSr1YUK2JjLSqXUdsW5HdLxzRtjU2rUlvHO/22dqeOffjzKvuqWH7E9N/3M+YHXrEDb5bazjVcqsV0y6mxO1t6W2cYSw0VZMOXXwMJ8ZYSg2ym0QBnFQnDsvwmkYTnzpGcBoG13tL5O/wE/4Kmu7DgXREyNIrd5vNsALWH+Lv/fvBOQR0p/fuKaI1IaklDZS/BTbcI/JGS5eIulIhEAq0QR+Sa+DHdNhVmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnYRGbfXnOzfjZuP3bqY/+902uncxE/OoBVDXfvZnWI=;
 b=feVOdXBIp2H4nfCpT+eZQvcBVYFiAXRwk9qdcF2Tlx4N1Z+LLJXcssmCRLDH6QSLUuL1bQJuvnBwp8FXnyLW2llGaafHxU3A06eIcwb6q63MwF/NuV2FcgVIF9i6wKs4dG1PDpmAIu2GuRmBQtP1x+K5exsfjb9qJQZfxjyavcA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8501.prod.exchangelabs.com (2603:10b6:806:39e::18) by
 PH0PR01MB7523.prod.exchangelabs.com (2603:10b6:510:f6::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.5; Fri, 14 Feb 2025 22:59:49 +0000
Received: from SA3PR01MB8501.prod.exchangelabs.com
 ([fe80::f7ae:9cc3:b435:c49d]) by SA3PR01MB8501.prod.exchangelabs.com
 ([fe80::f7ae:9cc3:b435:c49d%3]) with mapi id 15.20.8466.004; Fri, 14 Feb 2025
 22:59:48 +0000
Message-ID: <d2192fec-4edf-4943-8045-517d8bae390f@os.amperecomputing.com>
Date: Fri, 14 Feb 2025 17:59:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] firmware: smccc: Support optional Arm SMC SOC_ID name
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 linux-arm-kernel@lists.infradead.org
References: <20241114030452.10149-1-paul@os.amperecomputing.com>
 <20241218001338.6247-1-paul@os.amperecomputing.com> <Z6ntbLvjjtcW92_Z@bogus>
Content-Language: en-US
From: Paul Benoit <paul@os.amperecomputing.com>
In-Reply-To: <Z6ntbLvjjtcW92_Z@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0059.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::34) To SA3PR01MB8501.prod.exchangelabs.com
 (2603:10b6:806:39e::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8501:EE_|PH0PR01MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: bd788608-8842-4c61-6adb-08dd4d4b484b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVF0NXE3d0NXRGJwckswNGEyTDJJbitEblRvMlVnUG8wUWQ0czEwYVJNM2d3?=
 =?utf-8?B?NXZnbVRYNWJpTUhwcktJc0dQYjJpbENUcWFOQlpDeXVwd216TkU2cnRaWkxQ?=
 =?utf-8?B?VVZ0NlBxdVZ6djIxMm92MHlRT2s2MmpQak5ILzFNbWNHR3h3WVE2S0RVWUhw?=
 =?utf-8?B?djFhUGlHanRPVWtUMGJMckNzUUJoQ2Y2amNuS0tYTllrRk95WUpqakVxWkxX?=
 =?utf-8?B?Zi8zQlhmZTRYalVNdkcvWFJRbzd5VHRFeHZpSllkdVV5dW9uVllKNXNsbDd5?=
 =?utf-8?B?cFNuQis2UGFQZHZmVklsU2xoc0RQblJNZFM4dGFMaXVPUHk4Ri8yNkFWTFBs?=
 =?utf-8?B?eHZFNXp3Um53TTZ2U0c0ajMvUE45eFE4SC9TVnA5VCt3K25Oa0tHT0hIRi85?=
 =?utf-8?B?NDM4cDBYT29xd2FMaXlsS0NZcnM0bHNCNU0wMEx1M1paU08zMWJmbnpWeEN2?=
 =?utf-8?B?MnFaNEFOTTI0aGl4ZjM5bzRKRnNmbzBDNFFJaVdLemhNSWNZUlhabUw2Qng1?=
 =?utf-8?B?YURUR05kUzZNcXhOZXJldEt0WnR5N2h0S2dlN1ovT2lzMWYyY0J0a0J0MkpX?=
 =?utf-8?B?c0IwZERrQTk2a0NDTkdwRFM3WEtSUHdnKzlnQis1cTU1U0pTOHMwT0FjZUM5?=
 =?utf-8?B?Q0xIaUt3dFJNcWd0MXNjSGlzbkhHeWcvdmI3Q2hOSmg3WGZ5T3Ivam9JWlQ4?=
 =?utf-8?B?YUw3MWRLVlhNbGJPNHZmQVBnTEZiQXBHOFp5V2lOQ01oREVrSkxCcnJCenI2?=
 =?utf-8?B?ei9GY1VSM1ZyMlhqcUpQVlJEOU1TdGMxbWlRdXBBeEltNi9hWk1ydkVCSjhU?=
 =?utf-8?B?YmVzaS9JS1ZySjMwNHZVMzd6MmlOWXZBZzhJc2hLYm9lTEhoNVoweEFyWjZk?=
 =?utf-8?B?UElVSGcvMDBOVTdqWDFMUHJiSytTdWFMVHlxdEw3VG5JTllyV05VNnRwOEpH?=
 =?utf-8?B?V2dXQ3JEUVp0bG1hWjNIQStkRTEwbGQrZ1d1MHBrTUNjUWJUMUpTSDZJd2Zq?=
 =?utf-8?B?OE1vY0gyZlMwQnlpUTFueUp6TzAzSWJFTTZxSHpEZWYwZXE0VitZR1ZpNFli?=
 =?utf-8?B?K3k3VGduaWxWNlU0RklmZmhKWTlkVmczQUtCbDlFc1c1eXFjbXlCME1LaVF5?=
 =?utf-8?B?U1hFM2FSZlVBdjlYYmtLbTZOY21FSi9lOTY1a1oyMXBibDFYcUQ5NDd5TEdv?=
 =?utf-8?B?Mkx6TEovZWIzcjhVeEVnMmhWcFlLVnI1ZGk1NVpGUUZYSmhDNTRiaEtSYmFo?=
 =?utf-8?B?WkkzcnNDS0twTWlIdnYvaWZzNVJSK0RNcmxaZyt5OEpoVHRZRFNtRVBjV3Rq?=
 =?utf-8?B?cVB6Nmh3RjJmNGM4MVF0ZmhmWENjaFg2STBHZGtnRE1MVDNkTmtQWkRtclJx?=
 =?utf-8?B?ellSaGJwUGhXYmJURWt5RjhVRzEvSjhXaEp1N2VMYUZYQTArSUtOTlNyQ0Rp?=
 =?utf-8?B?dkhZTFRqUEcwSS8xWXAyR3VKcDRaMlhpSzd5d0ZNS3Q0Mk1FTU5rMnVpWElX?=
 =?utf-8?B?MlR2SDBWaENZWGh2dWYzQ0ovMmhvNm1rQkp3ajJKdlVxS3pWenRXTmRJZE43?=
 =?utf-8?B?YzdGM3RhelpMTWRiR1VhdUVPUFBXWXk4cEN0SUNIMHZxMG1uUzJWQjZjZDdV?=
 =?utf-8?B?NHR2b1FveTE5YUc5dFZEOE9kOHJGK2YrTEtjcXhYMXFMV09OYWFLSUJjYzE5?=
 =?utf-8?B?Uk5XL2NERndlNklsMytqdU9uVWp1MVhxbERteURDMjZObUwxc1NQeDdMK002?=
 =?utf-8?B?YnhIWDVpWUUrbXZrSTJ2SlpWQ2dUTXJpQ1U0V09lbjN5elBhTEtSRXZFdG5V?=
 =?utf-8?B?VVZXWmF1MGxYWW9kdTJRNkRUbUtxNE4zdTY2NkUzMUpPSWtyOWg4NEwxdFM4?=
 =?utf-8?B?K011SURmenNrd2NZY2lmTCtJeXV3c1FuU3hmWXVSMCtlYnQ5VDJRbXM1c2t0?=
 =?utf-8?Q?Hky6TlzvlrcQALRZKr3Dv2FDwt8hsvgH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8501.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGcvUGNFNEN6YjZiVWdudHBYcEZLbm9oTk1lYzRmdURVY1RWUzFhVDBhNnZ4?=
 =?utf-8?B?S0tRV2k2ZmJLWGoycUxVSUE4VStsQjNORVprcmp2OUdwYk52bmpXanlPODBk?=
 =?utf-8?B?cC9QQzd4WFFSOGhGc0Y0RXdhQURyTDQ1TkJXQ3V6SityckF6bjU4VzlpSG9v?=
 =?utf-8?B?N3grMmtSUktIRi9HYTVjcHNuVG41S0JSV1lOOE43R2hDRWRGRW9yTWUrR1R2?=
 =?utf-8?B?a2lpTEZjMVVCM2JTeEdFVEw4S3VCdVFGQjNVcW01dlBEYnlJUHprMFhYQnk5?=
 =?utf-8?B?WlBFTDJCK2ZyTHJuMS9PWUt1NmJDSEozVGU5YVJPYjl4Rkk5VkRHdVYzdmJh?=
 =?utf-8?B?Z25aNnFCdm5PTnNpSzh2WHZDRDM0Q2l6cGJrdWtrWEpTWmM5QktJaWZmeEdo?=
 =?utf-8?B?R25GSlZyaWVYblZOU2hUeTVhMkdsYUN3dk0ySFJiN1FtM3I2YXFBQklYYTV5?=
 =?utf-8?B?ZzN3RWt4bDhDTmJidWkzZWpTbGVGRnVLQURwQWx5MFh2dy9zNjArQ0RMWkNZ?=
 =?utf-8?B?bWM0eVlCL3JWNTFXOHVsSnR1Ky9MMFhqVjR5NXBwVGJHYW5XWHF1ZTdhMmNW?=
 =?utf-8?B?NkJibDh2a2pXMjJuNTdhMUpxQlVmQnZQWGtrMUNWd3RnQjlhOTFWOVVCTWwy?=
 =?utf-8?B?azRIMVVlMlBvcmlrTzdJMEkyNFlwakRHS3NLTGFwbmhlbENtVVNSQVdUSlMw?=
 =?utf-8?B?VWh3N0gydXgzb1VtQzJhN21FQnp5dElMZHA0Z09IMnBVWHNxVi82UnpqOEVo?=
 =?utf-8?B?cVFpNjBlZVZ6MVd3VW9tR0hHVnY2cy9IZUYrOHcvTG9ScG0zODR5MmtOMDd1?=
 =?utf-8?B?Tkh5bkM2My9aTjh2cnZZTVYyOFRHdnJvNnI4ZGJ5OXNDWUJXa0NoNiswMWpN?=
 =?utf-8?B?N3d5N2llbG1nR0czaW5yajJUWEhSV1IyRklDSkRVc0l6NUp5a3lYZG9GQVVi?=
 =?utf-8?B?eEZHWkZ0dnRlV1BLQXdyYnkxSnI1a3NaYThMenBwWGd6Vkp4V2d5WGNnQ2Zp?=
 =?utf-8?B?anJCQ0ljSU0xeDlBRVBnYjhoOFVxMU1TVDlMTnc0N0dQdTNBM1FHbU9NL1BR?=
 =?utf-8?B?SE8zNmlQWFBna0dDZmZTM0NyOEpUMVp6Slhud3Z1Y3lLc2lQclJzTk0ycWFX?=
 =?utf-8?B?b3hNZEVhT0ZTVFlGeVBvclV1UGZoM1krZ3RJNU1ZRm1ybTlFYUhSRU1KS1Vn?=
 =?utf-8?B?RTdnVHlad0VGL1YzTUlHK2ZoUVB5YVZlMUsyMXplY2tkanFkMGpMMDR2SXkv?=
 =?utf-8?B?VHd0WjZydENvK3N4cFFVSTd2cWo2NVVUdGZidFFVeHBoVVUxV3JYVjVSeXhY?=
 =?utf-8?B?ajk3cG16WFRNK0xlNXVjYW42QjNZcmcweDk2bmVOZ1pRcXNUZEVKS2xObEor?=
 =?utf-8?B?cGlkZ3NFcDRqN1oyamg5VldieWxOV3dDYjNjU0JNNitaZUFzandERVFqMXZM?=
 =?utf-8?B?NnRNVFBXa29aaitRZER2aFUxYnJ4V2lnV1lZOEp1Z1pzVmpXOUZMNlN6bkNO?=
 =?utf-8?B?TERRQXRSdGIva2U4TGd0aHpQMjZNSWVDd2NsaDAreGN2UUtYaVBDbzZUMDg4?=
 =?utf-8?B?TWxQZUlIMWNJTERONk5sU1Q1d1pRUTBVSzdjcm1HaUk2OXdiMEpmazlkejVn?=
 =?utf-8?B?aGN1UU81clZOVGZHUlNmRFhHVFdlMGc4MSt4MlBKRHdveXNNY1pMTGVZc1hm?=
 =?utf-8?B?NURHbVVvZldIVk5vckh1Q3ZsaXpvL3BlMWQxdUcxdUpNZzVTYXhMUlpNVERv?=
 =?utf-8?B?cmpUUFduNzg3MXZkclF2Qm9IYXEwT2U4N09OdHFaS3IzalFWbFJ6eHFOcHIr?=
 =?utf-8?B?VElSSDVucndUa3RlNUl3dDRJenVvOTdXYjAvbldBWmdYTUZiUE9iMkpDQWs5?=
 =?utf-8?B?RkpVWHhka1h3NG4rQSsyOWs0OEw0a1ArTVVBZW1CMk9oYWx5azA0ZWtPTlFl?=
 =?utf-8?B?d3V6T1A5Q1pFRGhDd1BwRzlBUllqRmlPZEdsVXMvMzlEQ05SaFFsdTVXNkM4?=
 =?utf-8?B?YmVNUll5UDVnVXptTVU0a1d4WEdET0wrTG9vQ2VHYVJvQVdOZ3krY1RWLzRl?=
 =?utf-8?B?NnpET3IwWU02Q2hPdHNKTXdvSXlUUW1qNGpWT0l3ckZoNXMyYWRDV05TWmFw?=
 =?utf-8?B?czZRTGtsaXNqc2M3MnM4Q1hGbWhnU01pYWZUMFptRHlybnFiV1hIZ0NDNThJ?=
 =?utf-8?Q?WN2WahseXOyeMg+pKaANZ8s=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd788608-8842-4c61-6adb-08dd4d4b484b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8501.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 22:59:48.9206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6zhrDI5VQ6wY0lBgZ/TYCzdyRCSV2XueMPLyJNjo/+aMb2n22kB0Dq0lCIhgfL21awyDEbZS6rVcCMSr7gVoXDBT0hcEsuwhkzoNRAo+5lw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7523

Hi Sudeep,

Thank you for your feedback.

I hope to submit the suggested changes as v4 of the patch early next week.

On 2/10/2025 7:13 AM, Sudeep Holla wrote:
> Mostly minor coding style comments from me, otherwise LGTM.
> 
> On Tue, Dec 17, 2024 at 04:13:38PM -0800, Paul Benoit wrote:
> 
> Split the commit into multiple paragraphs, it looks too crowded 😄 >
>> Issue Number 1.6 of the Arm SMC Calling Convention introduces an
>> optional SOC_ID name string.
> 
>> If available, point the 'machine' field of
> 
>        ^^^^ I prefer implemented instead of available.

I changed the wording to use "implemented" rather than "available".

> 
>> the SoC Device Attributes at this string so that it will appear under
>> /sys/bus/soc/devices/soc0/machine.
> 
> Break into new paragraph here.

I made the split, and adjusted the line lengths/breaks so as to not 
exceed 75 columns/characters.

> 
>> On Arm SMC compliant SoCs, this will
>> allow things like 'lscpu' to eventually get a SoC provider model name
>> from there rather than each tool/utility needing to get a possibly
>> inconsistent, obsolete, or incorrect model/machine name from its own
>> hardcoded model/machine name table.
>>
>> Signed-off-by: Paul Benoit <paul@os.amperecomputing.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> ---
>>
>> v2->v3: Add conditionalization to exclude SOC_ID Name from 32-bit builds.
>> v1->v2: Address code review identified issues.
>>
>>   drivers/firmware/smccc/soc_id.c | 79 +++++++++++++++++++++++++++++++++
>>   include/linux/arm-smccc.h       | 37 +++++++++++++++
>>   2 files changed, 116 insertions(+)
>>
>> diff --git a/drivers/firmware/smccc/soc_id.c b/drivers/firmware/smccc/soc_id.c
>> index 1990263fbba0..3b50ff5d2cbd 100644
>> --- a/drivers/firmware/smccc/soc_id.c
>> +++ b/drivers/firmware/smccc/soc_id.c
>> @@ -32,6 +32,12 @@
>>   static struct soc_device *soc_dev;
>>   static struct soc_device_attribute *soc_dev_attr;
>>   
>> +static char __init *smccc_soc_name_init(void);
>> +
> 
> Not really needed if you move you code before smccc_soc_init()
> 

It has been eliminated.

>> +#ifdef CONFIG_ARM64
>> +static char __ro_after_init smccc_soc_id_name[136] = "";
> 
> Move all in one block under #ifdef, details below.
> 

I have made that change.

>> +#endif
>> +
>>   static int __init smccc_soc_init(void)
>>   {
>>   	int soc_id_rev, soc_id_version;
>> @@ -72,6 +78,7 @@ static int __init smccc_soc_init(void)
>>   	soc_dev_attr->soc_id = soc_id_str;
>>   	soc_dev_attr->revision = soc_id_rev_str;
>>   	soc_dev_attr->family = soc_id_jep106_id_str;
>> +	soc_dev_attr->machine = smccc_soc_name_init();
>>   
>>   	soc_dev = soc_device_register(soc_dev_attr);
>>   	if (IS_ERR(soc_dev)) {
>> @@ -93,3 +100,75 @@ static void __exit smccc_soc_exit(void)
>>   	kfree(soc_dev_attr);
>>   }
>>   module_exit(smccc_soc_exit);
> 
> Generally it good to have module_{init,exit} at the end of the file.
> Move you additions above these.
> 

Agreed.  I have made that change as part of your suggestion to "Move all 
in one block under #ifdef".

>> +
>> +
>> +#ifdef CONFIG_ARM64
>> +static inline void str_fragment_from_reg(char *dst, unsigned long reg)
>> +{
>> +	dst[0] = (reg >> 0)  & 0xff;
>> +	dst[1] = (reg >> 8)  & 0xff;
>> +	dst[2] = (reg >> 16) & 0xff;
>> +	dst[3] = (reg >> 24) & 0xff;
>> +	dst[4] = (reg >> 32) & 0xff;
>> +	dst[5] = (reg >> 40) & 0xff;
>> +	dst[6] = (reg >> 48) & 0xff;
>> +	dst[7] = (reg >> 56) & 0xff;
>> +}
>> +#endif
>> +
>> +static char __init *smccc_soc_name_init(void)
>> +{
>> +#ifdef CONFIG_ARM64
>> +	struct arm_smccc_1_2_regs args;
>> +	struct arm_smccc_1_2_regs res;
>> +	size_t len;
>> +
>> +	/*
>> +	 * Issue Number 1.6 of the Arm SMC Calling Convention
>> +	 * specification introduces an optional "name" string
>> +	 * to the ARM_SMCCC_ARCH_SOC_ID function.  Fetch it if
>> +	 * available.
>> +	 */
>> +	args.a0 = ARM_SMCCC_ARCH_SOC_ID;
>> +	args.a1 = 2;    /* SOC_ID name */
>> +	arm_smccc_1_2_invoke(&args, &res);
>> +	if ((u32)res.a0 == 0) {
>> +		const unsigned int regsize = sizeof(res.a1);
>> +
>> +		/*
>> +		 * Copy res.a1..res.a17 to the smccc_soc_id_name string
>> +		 * 8 bytes at a time.  As per Issue 1.6 of the Arm SMC
>> +		 * Calling Convention, the string will be NUL terminated
>> +		 * and padded, from the end of the string to the end of the
>> +		 * 136 byte buffer, with NULs.
>> +		 */
>> +		str_fragment_from_reg(smccc_soc_id_name + 0*regsize, res.a1);
>> +		str_fragment_from_reg(smccc_soc_id_name + 1*regsize, res.a2);
>> +		str_fragment_from_reg(smccc_soc_id_name + 2*regsize, res.a3);
>> +		str_fragment_from_reg(smccc_soc_id_name + 3*regsize, res.a4);
>> +		str_fragment_from_reg(smccc_soc_id_name + 4*regsize, res.a5);
>> +		str_fragment_from_reg(smccc_soc_id_name + 5*regsize, res.a6);
>> +		str_fragment_from_reg(smccc_soc_id_name + 6*regsize, res.a7);
>> +		str_fragment_from_reg(smccc_soc_id_name + 7*regsize, res.a8);
>> +		str_fragment_from_reg(smccc_soc_id_name + 8*regsize, res.a9);
>> +		str_fragment_from_reg(smccc_soc_id_name + 9*regsize, res.a10);
>> +		str_fragment_from_reg(smccc_soc_id_name + 10*regsize, res.a11);
>> +		str_fragment_from_reg(smccc_soc_id_name + 11*regsize, res.a12);
>> +		str_fragment_from_reg(smccc_soc_id_name + 12*regsize, res.a13);
>> +		str_fragment_from_reg(smccc_soc_id_name + 13*regsize, res.a14);
>> +		str_fragment_from_reg(smccc_soc_id_name + 14*regsize, res.a15);
>> +		str_fragment_from_reg(smccc_soc_id_name + 15*regsize, res.a16);
>> +		str_fragment_from_reg(smccc_soc_id_name + 16*regsize, res.a17);
>> +
>> +		len = strnlen(smccc_soc_id_name, sizeof(smccc_soc_id_name));
>> +		if (len) {
>> +			if (len == sizeof(smccc_soc_id_name))
>> +				pr_warn(FW_BUG "Ignoring improperly formatted Name\n");
>> +			else
>> +				return smccc_soc_id_name;
>> +		}
>> +	}
>> +#endif
>> +
>> +	return NULL;
>> +}
> 
> Can we improve readability with
> 
> #ifdef CONFIG_ARM64
> 
> static char __ro_after_init smccc_soc_id_name[136] = "";
> 
> <both str_fragment_from_reg and smccc_soc_name_init here>
> 
> #else
> static char __init *smccc_soc_name_init(void)
> {
> 	return NULL;
> }
> 
> #endif
> 

I have made the change suggested above.

>> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
>> index 67f6fdf2e7cd..9d444e5862fe 100644
>> --- a/include/linux/arm-smccc.h
>> +++ b/include/linux/arm-smccc.h
>> @@ -607,6 +607,12 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
>>   			___res->a0 = SMCCC_RET_NOT_SUPPORTED;		\
>>   	} while (0)
>>   
>> +#define __fail_smccc_1_2(___res)					\
>> +	do {								\
>> +		if (___res)						\
>> +			___res->a0 = SMCCC_RET_NOT_SUPPORTED;		\
>> +	} while (0)
>> +
>>   /*
>>    * arm_smccc_1_1_invoke() - make an SMCCC v1.1 compliant call
>>    *
>> @@ -639,5 +645,36 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
>>   		method;							\
>>   	})
>>   
>> +/*
>> + * arm_smccc_1_2_invoke() - make an SMCCC v1.2 compliant call
>> + *
>> + * @args: SMC args are in the a0..a17 fields of the arm_smcc_1_2_regs structure
>> + * @res: result values from registers 0 to 17
>> + *
>> + * This macro will make either an HVC call or an SMC call depending on the
>> + * current SMCCC conduit. If no valid conduit is available then -1
>> + * (SMCCC_RET_NOT_SUPPORTED) is returned in @res.a0 (if supplied).
>> + *
>> + * The return value also provides the conduit that was used.
>> + */
>> +#define arm_smccc_1_2_invoke(args, res) ({				\
>> +		struct arm_smccc_1_2_regs *__args = args;		\
> 
> I think we can move this macro and the above under CONFIG_ARM64 as
> arm_smccc_1_2_regs is defined only for ARM64 for now. Otherwise one
> could use this macro and get undefined compiler errors for the structure.
>

I added another #ifdef CONFIG_ARM64 around arm_smccc_1_2_invoke.  It 
seemed cleaner to keep arm_smccc_1_2_invoke located right after 
arm_smccc_1_1_invoke rather than to move it amongst the other 
CONFIG_ARM64 conditionalization for struct definitions, prototypes, etc. 
  Though, I'm open to moving it if you think that is better than having 
it immediately follow arm_smccc_1_1_invoke.



