Return-Path: <linux-kernel+bounces-364062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E02E99CAB1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C61F283666
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549D01AA783;
	Mon, 14 Oct 2024 12:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RkHnOZTR"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384A316F900
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910208; cv=fail; b=c1IQLALUypBP1K2jUITE2tIHIGFeT4EBtG84n+/Vut6Lw9vx2nXX5ngrlnlkWtDw9d8P9ByI6YIyVctJyfNon9PKDLNo3vFK/ljzMQZdmPhXAlpCg0OY0Cebd8LPdfBUYl9H6Pt9CvPJyL6qLs/DmILwFOPznI65XZ0cz/g1z9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910208; c=relaxed/simple;
	bh=08ViFfFTiahnUyCTG7ni0F8Ue4M5/6mri8Uh5KSorZs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oHl9edrJ/6Anztxhnq1UFEyT/CUI6fZ9a9w0YYjf5VuEz2PrHZ/MSPl0cWNm0Wori6VoY0Fh5B28JxFM9MkJuso8q8pM17+rbVRH8g4lXhiAGWG0tcRIGbF4f2WWSzW5t93K8oYwfKzPGaPxzq9X9jxlq4jHSHDADCK8+S6T4d4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RkHnOZTR; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UiSEhHdkPofhPCIz7kl9G+/DNktJZXLH78vWb+I8l1VW7MftsZp4xEbJGnfcuLM6J8aqJe+0QnvkmeiEJ7kclXfwic47mcoHA1Kd0ola7WdArwRfG+Rf2APoYBJF8GO/s4bsc8KRe4vpbA6Eqzy6gCSOe8rwk5J4m2b5M7jrA71lA2yq44Y++ZtpvM/hntI2duTIRav4N3URfg7HxqZslQ6LD1jwUEh1lJDYsg6YdPhPKHr9+jbSwY5K3eR3kZ0p/fXNsPy5bPVrgmAA8iWuMSeHvW0QLFNAhhKhVNFrQmBAqEt0RVIuZIbmWbIXTazeR1vDJmJCCN0lWUNSk4j3mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kh+a6Qv8adRM6OTAXT5800dB5dBVFwSftoXk1nqdxtM=;
 b=jmzVU8AOQ1kni/azmMntqjqg3/4jifmygugi3pORAMabAhszMbjDrhW9NIGXlQnwcN8sLUDAIeIxErTb9XCqx9FqfBxf7YYeH0EmXYKhRqd1vAWt9xL9mKkeB2pvANEIk09C1SfA4xFY0IcoVofBzgyTe2pdRKzz0VJmhYEx+Yz0GWqQcAwNta5RmurMLUB2o17enbgYE8ZVGyCUVe6lfSYumVNJ3SWFpqXjd1G1jQCCS/2r6MLjL5BULt/zowPoKWatca7hpFhF3XBHT6DDLbrsShhl6bl2h2GNTrB6tNiQ9+Awku4iCTRsfvuNksF7C8BZbdZ+KZNieI+4rAP/mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kh+a6Qv8adRM6OTAXT5800dB5dBVFwSftoXk1nqdxtM=;
 b=RkHnOZTRTmEPCbAImmssukHg8KZuM27vFKMF7Dst4vG7YQgWOf3vhcMxdtck7HmRWzPNMYZESkdpKTU2FJg1CdEL1XMpk6AWDRaYSmQNfRJH2P266OhD24Ol5H2V/h+KkZTHmuwO2uChRlCesbHtUrUnTYzVfbqTyb7WAtJx7dfLftoHg8SOQgpvdE4MAbWH4CStPahkETeSiXE7IOgYDog/Wz8eeMJREV02y+q2zsfFXHpO3dc8KV2IHH+7bb64PUwQJop2QjqcTDkEoz8vqCk/8PmpeUG5YtJjsqhBOUYiO1+c0+gcdIFFfHYXxHoZ8paU7l1bUBioCDxcwTbJWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by MN2PR12MB4455.namprd12.prod.outlook.com (2603:10b6:208:265::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Mon, 14 Oct
 2024 12:50:02 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 12:50:01 +0000
Message-ID: <ce40a778-ea62-455b-9c05-aa4ff35b49b5@nvidia.com>
Date: Mon, 14 Oct 2024 13:49:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver core: Don't log intentional skip of device link
 creation as error
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Saravana Kannan <saravanak@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, kernel@collabora.com,
 linux-kernel@vger.kernel.org
References: <20240624-fwdevlink-probed-no-err-v1-1-d1213cd354e2@collabora.com>
 <CAGETcx-sAu-wMDKT9zCeCzLzZ=ZdvK+CSoX34YxMLd5z0YeVZQ@mail.gmail.com>
 <7b995947-4540-4b17-872e-e107adca4598@notapiano>
 <575b02aa-6496-492b-b37d-d0612165eda3@notapiano>
 <CAGETcx9e4mpcMY+pqMYXsVWGcjgkctCqgO665KgqUH4JvYbUAQ@mail.gmail.com>
 <c622df86-0372-450e-b3dd-ab93cd051d6f@notapiano>
 <da4e5807-712d-4d08-a780-f363cee823b9@notapiano>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <da4e5807-712d-4d08-a780-f363cee823b9@notapiano>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LNXP265CA0063.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::27) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|MN2PR12MB4455:EE_
X-MS-Office365-Filtering-Correlation-Id: 60d36dbc-ac1e-4475-3a2f-08dcec4eb7d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0grVncwdlV3TWxoY29KMjlmdXRDMWE4OFU2Q1B3YXlYYng0ZVpuZ21zT1VZ?=
 =?utf-8?B?WWNhYzQxTXBTNG0yaVdJZ2hEb3V2RkZvUTVTZjlzeUU4aXViSWw3MkEwbmlK?=
 =?utf-8?B?RWFsOVJzNm9rNUx5ejZiWkNybCtlWHZFKzNpSnIyVEtQMmtqeTJXUi8wdkww?=
 =?utf-8?B?S2pvZGJKay81L0RjRE8yTmtiS0ZQSVRLRWhnU21CSUtJdnBtQVA2MHdxdWJN?=
 =?utf-8?B?V25YeklFNWFtMWllbCt2OGdhTGhhTVJJU2dsd0tzQ3gvZWpIUy94WGJhMU1V?=
 =?utf-8?B?Q2NlVnp4bXBSZ0hnNnBGSGxYQjg0MVFJWkgyYi82aW1GdlNkR3RaWWVUYXpW?=
 =?utf-8?B?cHhOelFpZHlCbElDcXdMUDJyTmlTbmk2YWh3VThkWnVsQkpIcElXYlpQRUVL?=
 =?utf-8?B?WCtGTEx1WUxmd3c3ZDZnQnM0aVZyRTBsODl2QkFPTUpOb0JadzRuQ2l6SXc1?=
 =?utf-8?B?ZzNYRVo2MjROV051NTZXY2RKOUllTFJhWm9QOWw0dlJZSHkzbDV6ZUFnbzZp?=
 =?utf-8?B?SVBiQjlmajJzcmx0RjNpeXBBVm0yeGpOOE43cXJEeW0xMzR3M2pnSkowWUVL?=
 =?utf-8?B?d1JPRG0yeG5Va2tLRTRlZFBjNlA2QUJCYnQyajJ2NDBRaVhvWDNNR3FFWDd3?=
 =?utf-8?B?d2JWVmJLdWZPS1o3MnArZ3lGZjBQV1FzSzRIbW5ERmowUS9rWmJsUzlMYUZ1?=
 =?utf-8?B?cEhrNHNGSnBXWUxON0VSVnlNbkdwcityNmlmSkVNMWtwaUtaNEZmMDVBazFB?=
 =?utf-8?B?Ti96N2Z1QmtLbDlXMWtPbStDM21UOFM5dlM3SU5vRDBLbGorTWFrWFU2YjBv?=
 =?utf-8?B?NjVLTmtGL2VKYXd3TTBMWXlQVndPMEtzZjNiblIrT2MvckIzZ09QVnJBQTBT?=
 =?utf-8?B?anBhbTQ5YlByVzJuTTdaNDdYTld5eDJkVXNhU1hGL1p0Z1c0ZlhmWDJ3UzdY?=
 =?utf-8?B?Y2xUc1I2eUFQbU5hZlZxNS9yVE02Qk1STHhhSFhrcm1EN1BVQWhXL2dJeERU?=
 =?utf-8?B?blU3RzN5L1BjTEYwQnVKVU5DVXhhUWpVQUpUQlFJbUI0T2hUMDZzd3AyLzk5?=
 =?utf-8?B?NmdGTzErdWlqSW1hY29FSEZhZjRPbm1PdlREYWhvNEVMQ3BTcXpTNjl5ZW9n?=
 =?utf-8?B?b2ZoRkI4TG1UNmpjemxPamJxOHdrcmVMTk9hNklRbi9NV05nV2dRWTcvQjJv?=
 =?utf-8?B?VWRpWVF3aG0yU1F5NmFoV25CeE5NQkdsbzVWZEh0ZUdtb2JuVmtKcnkvdUxN?=
 =?utf-8?B?N09TMUhKei9wN2p6Mm40M2hyeXhiZlduK2ZPSjJQSWxjdmNlVjZDL0k0TXB0?=
 =?utf-8?B?eEZidkpjMDF6eGp3TDFVb25QSENLQ0pLVHpwU2E5aU94OCtVQnVJN2VXR2N0?=
 =?utf-8?B?K0N3RS9NekFJWEI1bWFkWjQvOVNxeHRaYUdVc2Fzek1DNHZOUUcxeUd2cHJq?=
 =?utf-8?B?UzNJaWlrY01hcGRuVXBEcG1sTTFmdnNrajJZUWhIYVBSL1dpQjFuSXArM3pi?=
 =?utf-8?B?Q3lhMFhXWE1QYXN2TjFEOW5hOXdrY2xlbFgwb3JvVzNtdEtCSkNQaXBqeTNk?=
 =?utf-8?B?bXVVaGtKVXBvS3NDSTA5RysxUklzaUxadEZDWDJEdVJVZFJOTEd3M0owa05B?=
 =?utf-8?B?M3lhMVlOWi8vaVNWTjV4c3FhUko4RmFRNEdjZVZ2djhOdGd1UEoydnJOOUtp?=
 =?utf-8?B?WFR1OThKaFFGcGN6djRJNjVWeHVCWHp3V3VPOUlFN2VDdDJZc1pZczdBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDlVSWpOckxndkxTMzM2Tm5WUGRNRFFWQ3JwaDhnblp5RUZkUlJjR0Zpb2Jp?=
 =?utf-8?B?UTF5dVQ4ZkZNdWYxTlgvUGZwTEVzejBtZFBPSGlFQldWVi9nUU10MExKVEJ5?=
 =?utf-8?B?bFcycGRQWGQyT1NzT205U24rY1lHYlVHTlZwQ0hQanp4bVFtZWcwSklFbThC?=
 =?utf-8?B?MlFzS01QeFBLbzhEeC9Lbm84WVh3L0JvN2tuU1pMbHhMZjBGVEg4bmZvWGxk?=
 =?utf-8?B?ajI0aTdrSzZOb09HZ0l3cHVjTjJmMzVvZklRVWZzdnlSYVBhd3c4NjZQTlpJ?=
 =?utf-8?B?WFIzeHNIY1FlNUt3akd5dHhRY0l4MjFVY0tmOU1PYlNrNWkvV1kyZTRMdURX?=
 =?utf-8?B?YnZGbXMxd1I1WFJjTzJqZnJBMVphaVR2Q2FtWk9tM1NOSXN1dHZHWnZ0YVov?=
 =?utf-8?B?MHBYajFiZGwvL1lVRjZhMnRId1VxaUdETVdodkRrT0h4SndYeDVSQTR6LzR3?=
 =?utf-8?B?d2ZVRGlFMUlvNEFXbFBSRVdRckFTVWk2Y2pMRnFaNWpNcFpIVjl1d3JPRk03?=
 =?utf-8?B?MWdQc0YyazFlS1BTcGc1bS9uU2NXUUlHY0hNY1dkWEdlcU1KSHBsOUl5WWh6?=
 =?utf-8?B?T09XSW5DRTA3eDJWaVl4UEkvY0VVNzlOSXJENWRlUmZSSE1RTnFyNXluWUFy?=
 =?utf-8?B?bVRHTjZRdDJwRnplbGRLeTZ5bGoxUmlNekFKSHViL29FY2JlMDdZd3NzT0Yy?=
 =?utf-8?B?c0hDMU5TSEJTZnU5bnFEUWNOTE1hYWYzOHpFSmFYdTNOUHczVFFXM2dQR2Er?=
 =?utf-8?B?SUJXeFZTOXlocmtxaHdKY2RoaFFnTHBUYzZueFdRL3Vqd2tNNWRYQ3Z6VGRh?=
 =?utf-8?B?NXovbFZZWXhDNm8vckJTRUY4R1hsaERGNDVncnFGbjluZmFWVEFRWkR6VGhO?=
 =?utf-8?B?MXlFTUxFK0FSNlUxaU5SWG1wVzhZbE5WbDlKYmQwdk12K2hTWUNMYkhSWE9l?=
 =?utf-8?B?ZldhZWcvcUdTblV6VWxTNUhmMUN1WkdQZHdBaUhpWHlham5reG40QkFZTHM1?=
 =?utf-8?B?emZoMUdoS0krUXlQbjkwK2YydU54VURvZjFLUUk2aGhxd2Z1aFlJYjdpMFVi?=
 =?utf-8?B?andqdU1ublEyRXRBRUk0QXBkMVM0c2VZWWY4a09FOWExdEhOblBOYnNOaENX?=
 =?utf-8?B?MnFsdW9wR2JuOGE4VGFWRUFyTmsycEV5MzR3MXFIVllRNUticGlubzg5OHRM?=
 =?utf-8?B?SDFkZEd0WnJnOHZ4Y05MeWxINHJ0bzVZREt5dFZBNjhvTjdiVUxLeVBBQmhU?=
 =?utf-8?B?RmorNEtsNndQYXNQdDVsWktZNnF5dGYxa3lYdUF3Z0crWFBQZGJmaldhVDZW?=
 =?utf-8?B?eUpqdk15Tk5Ea253emVKdC90VmE0c1MrQUJsai9XS0FlT3ZCeWlmSXN0ZWk1?=
 =?utf-8?B?c1pIdm0yTmhCZHcvUzlESi9EMmNSMFF2eUVVZGtVMGRMVmtkdDhFUXVJVllK?=
 =?utf-8?B?dkR5NTNvdHBkWTNjZm5MamJBcVJhMzJNUWU2dHQvSklaUzJXd2I2L0I0QkRM?=
 =?utf-8?B?VTRXb0FpY2JQbWQvOEpnelFpUi9RRFpKcGo5YlpMMjV6RGcrTDVjOHFyZUNJ?=
 =?utf-8?B?MjlERUxHelovdkxBME5xN21jOFN3SzdRTklxbUpjd2FBMkhIZ0owTG1WYzVQ?=
 =?utf-8?B?dndBWDc2cG1OWldPSHprc0ozNEY2RzlJNlNKYzhYTDYxeVQ1NFlRZXhNNHRj?=
 =?utf-8?B?MnJZUXFmSWc4QmdiNEQ3RG1DMTd5dm0vMExiYVhEWDhUbm91bFErRlV1c1J0?=
 =?utf-8?B?VzFjcVJ4RVZTUmJLcURNZVZYYkxPU25zZVB0WUN0TTBsck5mdlZ5clhjUWxS?=
 =?utf-8?B?VDhybGIyVlJtVGpkYktIQ3JpeFBjdlp5WEZyRWYxd0hCVHp1U3Nwbi91aEsw?=
 =?utf-8?B?VGlwSm1iYjU1Mk8rcXFwdXd4MHZVcjJjMDE4ZTV5c1I5akVXbkNrSllxcWR5?=
 =?utf-8?B?TldzZjRHZmt0WnVEOWJOMHVlZnFjdnJhMGR2K0dIRmt5RS9CampLaEFZaWF1?=
 =?utf-8?B?OEJQL0pXa3REUEFZa3NnS3NydGRGL2t3SjVkcXBhdE13SkcxY2RycEU1dEFo?=
 =?utf-8?B?TVZQL2RaZTJlaGJEOEZwQ3dEME9JSERwbTUzcWxIV1lzTVdKUm40SWM5NGQ0?=
 =?utf-8?Q?08pmsw4VCG0sH72/9y4G20LSP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d36dbc-ac1e-4475-3a2f-08dcec4eb7d2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 12:50:01.8126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/S5HOZ5pURpGByH17qCMjG0EISJ6NwYbgRCGnEXPPbBE6H4g+hBdrNTSEj/9q06tqM/ZNosszjlB3RUeM8bng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4455

Hi Nicolas, Saravanna,

On 02/10/2024 21:57, Nícolas F. R. A. Prado wrote:
> On Fri, Aug 09, 2024 at 12:13:25PM -0400, Nícolas F. R. A. Prado wrote:
>> On Mon, Jul 29, 2024 at 05:08:48PM -0700, Saravana Kannan wrote:
>>> On Mon, Jul 29, 2024 at 2:25 PM Nícolas F. R. A. Prado
>>> <nfraprado@collabora.com> wrote:
>>>>
>>>> On Tue, Jun 25, 2024 at 09:56:07AM -0400, Nícolas F. R. A. Prado wrote:
>>>>> On Mon, Jun 24, 2024 at 04:53:30PM -0700, Saravana Kannan wrote:
>>>>>> On Mon, Jun 24, 2024 at 8:21 AM Nícolas F. R. A. Prado
>>>>>> <nfraprado@collabora.com> wrote:
>>>>>>>
>>>>>>> Commit ac66c5bbb437 ("driver core: Allow only unprobed consumers for
>>>>>>> SYNC_STATE_ONLY device links") introduced an early return in
>>>>>>> device_link_add() to prevent useless links from being created. However
>>>>>>> the calling function fw_devlink_create_devlink() unconditionally prints
>>>>>>> an error if device_link_add() didn't create a link, even in this case
>>>>>>> where it is intentionally skipping the link creation.
>>>>>>>
>>>>>>> Add a check to detect if the link wasn't created intentionally and in
>>>>>>> that case don't log an error.
>>>>>>
>>>>>> Your point is somewhat valid, and I might Ack this. But this really
>>>>>> shouldn't be happening a lot. Can you give more context on how you are
>>>>>> hitting this?
>>>>>
>>>>> Of course. I'm seeing this on the mt8195-cherry-tomato-r2 platform.
>>>>>
>>>>> The following error is printed during boot:
>>>>>
>>>>>    mediatek-drm-dp 1c500000.edp-tx: Failed to create device link (0x180) with backlight-lcd0
>>>>>
>>>>> It doesn't happen with the upstream defconfig, but with the following config
>>>>> change it does:
>>>>>
>>>>>    -CONFIG_PWM_MTK_DISP=m
>>>>>    +CONFIG_PWM_MTK_DISP=y
>>>>>
>>>>> That probably changes the order in which the MTK DP and the backlight drivers
>>>>> probe, resulting in the error.
>>>>>
>>>>> One peculiarity that comes to mind is that the DP driver calls
>>>>> devm_of_dp_aux_populate_bus() to run a callback once the panel has finished
>>>>> probing. I'm not sure if this could have something to do with the error.
>>>>>
>>>>> Full log at https://lava.collabora.dev/scheduler/job/14573149
>>>>
>>>> Hi Saravana,
>>>>
>>>> With the given context for where this issue is happening, what do you think
>>>> about this patch?
>>>
>>> Ah sorry, missed your earlier email.
>>>
>>> Couple of points:
>>> 1. It looks like the link in question is "SYNC_STATE_ONLY" because
>>> it's part of a cycle. Correct me if I'm wrong. You might want to use
>>> the new "post-init-providers" property to help fw_devlink break the
>>> cycle and enforce the right dependency between the edp-tx and your
>>> backlight. And then this error should go away and your device ordering
>>> is enforced a bit better.
>>
>> I don't see any cycle there. edp-tx points to backlight, but backlight doesn't
>> point back (from mt8195-cherry.dtsi):
>>
>>    &edp_tx {
>>    	...
>>    	aux-bus {
>>    		panel {
>>    			compatible = "edp-panel";
>>    			power-supply = <&pp3300_disp_x>;
>>    			backlight = <&backlight_lcd0>;
>>
>>    
>>    backlight_lcd0: backlight-lcd0 {
>>    	compatible = "pwm-backlight";
>>    	brightness-levels = <0 1023>;
>>    	default-brightness-level = <576>;
>>    	enable-gpios = <&pio 82 GPIO_ACTIVE_HIGH>;
>>    	num-interpolated-steps = <1023>;
>>    	pwms = <&disp_pwm0 0 500000>;
>>    	power-supply = <&ppvar_sys>;
>>    };
>>
>> And DL_FLAG_CYCLE is not set in the flags in the error log: 0x180. (Let me know
>> if there's something else that I should be looking at to detect a cycle)
> 
> Hi Saravana,
> 
> Here are some debug logs to help contextualize the issue:
> 
>    [    0.198518] device: 'backlight-lcd0': device_add
>    [    0.198655] platform 1c500000.edp-tx: Linked as a sync state only consumer to backlight-lcd0
>    
>    [   34.971653] platform backlight-lcd0: error -EPROBE_DEFER: supplier 1100e000.pwm not ready
>    
>    [   35.115480] mediatek-drm-dp 1c500000.edp-tx: driver: 'mediatek-drm-dp': driver_bound: bound to device
>    [   35.160115] mediatek-drm-dp 1c500000.edp-tx: Dropping the link to backlight-lcd0
>    
>    [   53.910433] pwm-backlight backlight-lcd0: driver: 'pwm-backlight': driver_bound: bound to device
>    [   53.919213] mediatek-drm-dp 1c500000.edp-tx: Failed to create device link (0x180) with backlight-lcd0
> 
> So a SYNC_STATE_ONLY device link is created from backlight-lcd0 to edp-tx. When
> the edp-tx probes, the link is dropped, since it is SYNC_STATE_ONLY. When the
> backlight-lcd0 probes a new devlink is attempted to the consumer edp-tx and
> fails, since it is useless, printing the warning.
> 
> You mentioned a cycle before. The only cycle I see is between the edp-tx and the
> panel, but doesn't involve the backlight:
> 
>    [    0.198104] ----- cycle: start -----
>    [    0.198105] /soc/edp-tx@1c500000/aux-bus/panel: cycle: depends on /soc/edp-tx@1c500000
>    [    0.198112] ----- cycle: start -----
>    [    0.198113] /soc/edp-tx@1c500000/aux-bus/panel: cycle: child of /soc/edp-tx@1c500000
>    [    0.198119] /soc/edp-tx@1c500000: cycle: depends on /soc/edp-tx@1c500000/aux-bus/panel
>    [    0.198125] ----- cycle: end -----
>    [    0.198126] platform 1c500000.edp-tx: Fixed dependency cycle(s) with /soc/edp-tx@1c500000/aux-bus/panel
> 
> Just in case I tried using post-init-providers:
> 
>    diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
>    index 75d56b2d5a3d..19df138ef043 100644
>    --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
>    +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
>    @@ -322,6 +322,7 @@ &edp_tx {
>    
>            pinctrl-names = "default";
>            pinctrl-0 = <&edptx_pins_default>;
>    +       post-init-providers = <&panel>;
>    
>            ports {
>                    #address-cells = <1>;
>    @@ -344,7 +345,7 @@ edp_out: endpoint {
>            };
>    
>            aux-bus {
>    -               panel {
>    +               panel: panel {
>                            compatible = "edp-panel";
>                            power-supply = <&pp3300_disp_x>;
>                            backlight = <&backlight_lcd0>;
> 
> It broke the cycle, as I no longer see it in the logs, but the failed device
> link warning is still there as expected.
> 
> It seems to me that the issue comes form the device link being SYNC_STATE_ONLY
> in the first place. I see that comes from the 'else' path in
> 
> 	if (con->fwnode == link->consumer)
> 		flags = fw_devlink_get_flags(link->flags);
> 	else
> 		flags = FW_DEVLINK_FLAGS_PERMISSIVE;
> 
> and the value on each side of the comparison is:
> 
> con->fwnode: /soc/edp-tx@1c500000
> link->consumer: /soc/edp-tx@1c500000/aux-bus/panel
> 
> Could you help me understand what (if anything) is wrong here?
> 
> (I also noticed that as per the DT the consumer for backlight-lcd0 should be the
> panel, but the devlink has it instead as the edp-tx, I'm guessing that's another
> symptom of the same issue)


I did not seen any update on this. It would be great to get this fixed.

Thanks
Jon

-- 
nvpublic

