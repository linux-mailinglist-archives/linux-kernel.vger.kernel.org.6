Return-Path: <linux-kernel+bounces-443844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1ACF9EFC98
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAD7716820F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B8318FDA9;
	Thu, 12 Dec 2024 19:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="UT62Xaj0"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022097.outbound.protection.outlook.com [40.93.195.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D63A748D;
	Thu, 12 Dec 2024 19:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734032295; cv=fail; b=W1mDFGy99DWjdFc7IgrpBQ62yTB7/VJYGgoS6VhLtKTYzXbup0LASBZELpO1oPcEW2XD6mIcj9lGKIRDo4FFXGU5d/5HbQxm+RY2LKiAEyduknZldRQ5Nr7LN2jVYFkPEd6ooAR87iFmQJXw22Ff6NO2HbhXmLWPxgKKcM31IZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734032295; c=relaxed/simple;
	bh=ZPeH9g6FJg6EWUQGUHNR2uSD9AvYQj5HgQUeWZMkU7s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YYVsiyimSJf8kwx90iDbe+HetX3ejeWwIwYv2VJcRH8CBWBYDWkAL6z7Jklh0cpciPicDvA7c9ASDaP7f/1/aSphB1kQwfV8peSzd4mIoHcGslALIWghI2n4QVbhqmUik8klW2vK/YMNYRYdbLjk/ut72iHyQwpeOqy+j64zRzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=UT62Xaj0; arc=fail smtp.client-ip=40.93.195.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7xI9lDAAQU3frW2/8G5WWVten5UFMlC33QA899D3ogzAENxPLkv46MGUpcNnN5QkjnPNs0LC1SjPefMbDhFhEygI8eQtDgO0d/WlobPEDYwX1WPQ3K0gjQigFE1a0YMA5h3ur1INONzJghmoIBueoO0VwZZvUnLnW+qCdyJzBx7nZeYAgTubN3FyQuB7w0L54k21J2iu72+iO1+QHf+DYhiGw9GbJ0dQeQdH2yZYN8oSvFnq81C+JY5x34pNFm3O1DpNfGqorr3KvXSNB4QJBtO1uQYN/BFujQUaa1yiOJb3WVl+BJ5zESCxylB9zN+qQZRKGu0e4o7SI9vLWPHsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjypq3TqbrN2W9+UwVuka0NHO7ytM4iptOBZMFugZvM=;
 b=ThZZWAmsn6jsYoMxM19hgfDXDly6OEvtAUnmC8IRazXeGhonW5CNa147b5BlwK1rkoPLicvZkXePBsg7kbMkzsLjmnDlhR+gAlmnEhBDfVogdi/0uiQ5mVzjBFcsIaF2YDBp4NB5I5cBZBRxLGsJVLTzA441VEhE5572qFFioN/BGQvSNnZ90Nzu37AvP64a1QAmnhLdE50Z4YXedb6sjvByicC1VzC4DteZgGwaAluCmC9/T05+gPEs8XKLFtJcJmPjWGn2RerWK8zkqLRqqKGI+ufjw1P20OKJxe5GanqgT/7cwwbuEI1W3TFDDMDwgKPiWQlfWDnjNJKft1D/yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjypq3TqbrN2W9+UwVuka0NHO7ytM4iptOBZMFugZvM=;
 b=UT62Xaj04QmSFnRc3SRfGscNnnZg+Do4HDArDcqm22HOQb0KoVxu9GziO83uU0jAojZSv2s0oV2JonEhu8TH1Ot8SrZ3pcFoHXBq6d5tDBWM3W0b7zK1W4GnyTZoGLIO8TCMupYBLolxKQuijAaVTW8X798A+/NfIDR0vVCruxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8150.prod.exchangelabs.com (2603:10b6:a03:4ff::5) by
 MN0PR01MB7612.prod.exchangelabs.com (2603:10b6:208:377::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.6; Thu, 12 Dec 2024 19:38:09 +0000
Received: from SJ2PR01MB8150.prod.exchangelabs.com
 ([fe80::72ca:29db:7676:9fea]) by SJ2PR01MB8150.prod.exchangelabs.com
 ([fe80::72ca:29db:7676:9fea%4]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 19:38:08 +0000
Message-ID: <75ce4def-b0ca-428f-99a5-19ca98e876a0@os.amperecomputing.com>
Date: Thu, 12 Dec 2024 11:38:06 -0800
User-Agent: Mozilla Thunderbird
Reply-To: scclevenger@os.amperecomputing.com
Subject: Re: [PATCH] coresight: docs: Remove target sink from examples
To: James Clark <james.clark@linaro.org>, coresight@lists.linaro.org
Cc: yeoreum.yun@arm.com, Mike Leach <mike.leach@linaro.org>,
 Jonathan Corbet <corbet@lwn.net>, Leo Yan <leo.yan@linux.dev>,
 Namhyung Kim <namhyung@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241210144933.295798-1-james.clark@linaro.org>
 <9e53f5b9-d8a9-46b8-8ff1-7f018e2d9c06@os.amperecomputing.com>
 <24299600-277f-48f4-9be5-cbd65ab6ddb7@linaro.org>
Content-Language: en-US
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
Organization: Ampere Computing
In-Reply-To: <24299600-277f-48f4-9be5-cbd65ab6ddb7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR17CA0037.namprd17.prod.outlook.com
 (2603:10b6:a03:167::14) To SJ2PR01MB8150.prod.exchangelabs.com
 (2603:10b6:a03:4ff::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8150:EE_|MN0PR01MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: 154a55eb-c12c-4e20-205e-08dd1ae481b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGU5a3V1SzlTWGdqNTFPNVdwYkFqNjkvQ3Q1WGdYN25qOHhWOVZmRnFBckp1?=
 =?utf-8?B?UEJ4UlhkTmp3dGloNWtyYmJiRUZPa3U2bEVCMTZaTE5rMk5CMjBtUi9GQ3hX?=
 =?utf-8?B?Tm1RR0lNQXJSNVZIRXFad0E5ZEIrem0vTHJHTWtLMyt6aG4ybXNlNGtjVS9M?=
 =?utf-8?B?VXN1QVFKc2lOMGxubGZ4YjZrUlhEeEpSbGo0ZHlGWVFYdzg0TkVHQUxvTytl?=
 =?utf-8?B?NWt2RndCTFp1NDNVenBiU3pEeVp3S3FEUTFwbnhTSGhZYjY5RVhLRHRYL1JC?=
 =?utf-8?B?cjdLQkVNZlN1ckdWQ2lqVkU0NTQwTDdFSlFtaC94Ykw4aFFOS1lLZm5QUjlt?=
 =?utf-8?B?T3dNUk9FcDg2a2FBY2lENWdmK2Q4OTdxS1pnUGVkRFEvUEtqRVcyRGFVOGdG?=
 =?utf-8?B?Y2k0dXRvV20vQXpJM1JZUGdZLzZneW0ycGRCMmJFZ3N4S0QvcUpTSmMxRWtU?=
 =?utf-8?B?emR3L1BEQnRpeVhxalhQYnhpZTBsRUFJa0trVllRWjZvOVJWc1pxZDFxSHVV?=
 =?utf-8?B?akZqQWhRVUxWMGgvK1Y4SmNyZUtrbmZzRHhWL1VJOWNrakNHM2cvdFNvY3hx?=
 =?utf-8?B?TzdGZGNZNEx2R2FDNUFuaVN1ZkN2SG9iTk94cURvQnNIb05rSHRURVRNeUN1?=
 =?utf-8?B?cjk4d0szUVBhQmRIYk9GZEJHeVVQWFh5dlM5MmMzMTBkTTVhNjhtUG53UW0z?=
 =?utf-8?B?NXpLNHRzMHkxRkc5dUdZWnB6Z1RlQnRHOEoydDlTQmU4ai9ZeWFQTkNjVE0z?=
 =?utf-8?B?bGR5d2VIK0hab1J6Q2V1OHAxZzNFaTYvK1ByODBxbVRaRzdWZi9UWjBDZVB1?=
 =?utf-8?B?eEdmNURzNnBSSGx4OG5PSHZvcFZpb3ExeWxBbkhkU2RFMnIvOTFXaWVUYjcx?=
 =?utf-8?B?OGhuNEhqN3N6M3c2amR3N29IN0xzcllqenpGVXQrajRzNVZLZW9Ta2NxSElV?=
 =?utf-8?B?RkZ1ZFlRZXJ5eDlsU3crRVdQWFFEbVhPVTRMdThwMVM5SzBNRU5sc1ZlbUNz?=
 =?utf-8?B?dUhqOHUrYVlMTFpIN3VuOEx6dmtCc0ZrNXcwUERXVnVEVjZTbzNlcWhhK0RF?=
 =?utf-8?B?SjQwdGhZR3ZSVkNzTmZPQ0REQjA5UXM1dmxaNDd0Q3BmdkJxRVlXZEozV2pD?=
 =?utf-8?B?STFWZGY0Y2ZEOHNYL2ZYcnFBczk2NTBoVmxScmxNQWhTblhaQnA1Z2hkVldT?=
 =?utf-8?B?UTFLNnJDTXMxOGtqSU9pc20vNEJrMVR4Q3Y1S3hSV0JxdDRnR2ovNDcxbzVE?=
 =?utf-8?B?WUhnbGZVTlZja3hrSUVRbUVHM240TDRjV2ZobmNuUHI0eFJWcGtBamdCazU0?=
 =?utf-8?B?SkZDeGFKbThleDNDcWRDVXpmTnFiVWZsNmY3Y2dTeWtUN1RYZi9xK1NlNmxC?=
 =?utf-8?B?MHV2dExYZnZTamV3Mm9xcXZENXlTc0VjWE9mVlNKOFNqUzVOV1VnZC9jY0RN?=
 =?utf-8?B?eWF5WlZNZU1WNTdMUWxFV1pnNTljZFhZcEdTOVVsUzlqalhpWi94Tjc0eGpU?=
 =?utf-8?B?KzcyK0NwaXh4NWF2d1UrY2JNWHIySEE2ckRJdGg0MFRpeEdqS0MzcEFZZDdJ?=
 =?utf-8?B?Nmk2VzdrdVdZR0ZycTVRMWFNMDExa1llUzQvcnZWZjloQVAyZXZMbXVrWkRq?=
 =?utf-8?B?TzRpZ0VINXJLa01XYzBub2wxSkRpd040aUdNRTlWaWFIM3BqUHQxR1lpU0Fa?=
 =?utf-8?B?NmFOZlcwdUhPODBhV1hQTGFYVHgrQ2YwMXlOQWVuUGRhQ3NtN1h3bEhiRkRa?=
 =?utf-8?B?WWpVazcxSmdJd011V3M1Y2EveVN3V2djenpubnlTKzNidFp4VFZKZmZBamR4?=
 =?utf-8?B?VTFvTlAvYmo0L2lTaFdtUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8150.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qm96Wk5rcXMxNHh5ZHVTWDA4bU5od2xzdGFZRE9FZndiK1NGTlFGdnBWaXY1?=
 =?utf-8?B?dTZtbnB3cm1mQ2NteVFWQzc1Z3BueitqZUZSQU5KMWtxcXJsUE9TUHVvdG9B?=
 =?utf-8?B?cG9HZUt2L3JiTGlpcUFYajh5VE0xRDZoRXBCTmtxOWJUemdKU2JSR2wrYk1O?=
 =?utf-8?B?M3NRNktrbXBoWmRpZ29kdzNLTDQwc3ZSWHAvOEhJdE9CMDhGN2Mza2hVQ2Vs?=
 =?utf-8?B?NENwRTFZNTVKc1YvRFFKODVFeXUwK0pDWUE5S0p5VlE4WDhTUWpZVC8yVno0?=
 =?utf-8?B?MW10MEtiY1liQmpZMzJnWUM4RlVPeWhJVzdHdFJYclVleXd4NzdJM2RSVG82?=
 =?utf-8?B?RWRMdWY1Y05RQnBxM3YwNzhoR2gzNFNvWGFITWlWbW85ZFlXZ1VlSGpJWDU1?=
 =?utf-8?B?NjVkeE84VXUwWXErczVXZEFxN1ZXem5NM3V5ZWpHMklGUnVSSHducWFGTVlJ?=
 =?utf-8?B?djE1SUxydGRYbnFxc1JlY25yMmcrWmsxRU1XOHB3emlyQWhDRThyTUpCZHVj?=
 =?utf-8?B?YXJmOFl3WDB4Vmw1by94OXZpQ1g0K1JHbjNSNklURHRab2pZeTJLU09ZSW1C?=
 =?utf-8?B?Yk5zUi91Q01jOUkvVnAxbnR2eGFQZGxmRDg5elpUSTUvYmIzbEtKY0tSVWor?=
 =?utf-8?B?cFhRdDJxZTBjSGwzQzhCZ3RmNm5DMVBNbkNTcmZGRFgwS3RHbkhLSGNwM1ZV?=
 =?utf-8?B?UXRIYWM3WW92aENyc3hlUWpCeVM3S0pmTU5JRGVJbTExeDRYR0VkMHRib3hq?=
 =?utf-8?B?bk10TmJoQWVIYk9pRlNiWGk5TWhGRkJRdW9PNDA0UTJwOEZNSy9SSElBVHFq?=
 =?utf-8?B?L3VUY3NtUzNLVCtEemorUTZnREdWWGUxZHlRdVl5dzYzbW5LdHJ5azRtMUw0?=
 =?utf-8?B?QndIeGVPcG1UZ3p2NEJzMDQxaC91dm5GYUo0WXBESlBSalRjdG1WQ0tRUG5T?=
 =?utf-8?B?eHNoaGhrYU94WVBrNTB6NmpubC8vc0hKTnFlSmtYbTY3S2p6QkdzbmdHWmIx?=
 =?utf-8?B?V01MTWF3NkM3WXJJOVA4T0RIUS9kRTh0T2IxTUJzUGJaWjdLcXRaN3lFWGhY?=
 =?utf-8?B?emYrRGZFMDBzOXJ1Nk56Wk5lRlNyTDVDNzBiVnZUdG5XdFk2ZC9hQXNLUXda?=
 =?utf-8?B?aTRuRW5PalJtR1hqWiswdU1IWjdkMXgxN3pTM09lSlI4TTc1NmF1OUtQbGU0?=
 =?utf-8?B?WlFaSGdFaGJ3cG1wNmg5eDJuN1FjeXZnc3VnN2NGRlp3bmorcDkyeTA0dURG?=
 =?utf-8?B?YmtoNWlVaDdvVmF6M2h0UmRabmswNUFtSTJ0NWt3cGxPMWVCMUd5WlFCSUQ0?=
 =?utf-8?B?WU0zWXpsYjJFTTlJc01nRjF1VFA3YlFrZWlJeTZsa3JOWitrNGlSVGlFdElh?=
 =?utf-8?B?K3Fwb05OSXR2SWlaVVJpbEpmaGVub2NZaWtQQzZCdlNqTUZGVUlhNm1QeU5D?=
 =?utf-8?B?ODhlUHE2RnBLdjYyLzFObzF2VDA5dmdHVzVPNjdWdXVUUHVXNG4zOHFsL0VI?=
 =?utf-8?B?Z1hFNVg4aXZDTWxFaEdIS01tSEQzVlk5eUx5VGQ2anJTcGk1dGtuSmxXaWtL?=
 =?utf-8?B?REE5dm02cFB6NWd6dVRQSjJCWG9EMlNqWDdkYk5DYXJuNzBTdzloSHlqRWtX?=
 =?utf-8?B?V2hLdVhQN3U1dmVuN00rMDE2ZXlZVEh2dThydENhM3JyWjF0Y2lhTlhid1FF?=
 =?utf-8?B?a1FYNFBWNDh2WDlDZTB5MThzdVArK25KR0doOXlTQ0Z6QkZiWGVCZ3N4b1du?=
 =?utf-8?B?UjZMZ1FqbytmdFFyTENqVWt4ZW1Pc2xvMmI2QkhhbGlXWEV4UW1LY0dCRHAw?=
 =?utf-8?B?MFNaUnZvUThpUzJkQ2lmRUhSS3QrS0lzUk4vYmR0NkUycDEyOGJ5WGN6ZFI2?=
 =?utf-8?B?NTFnTnZIbTBjQ1dJMUYxUzhxdTlZMmRZRHFkRG5JWGc0Umphd0xDajRPYzAy?=
 =?utf-8?B?K2J3RjRyQWFXZkdUbWVJYTNSbEh4RXBkLzdKMXpYcTE1bzlDQjNFd0lOb2RJ?=
 =?utf-8?B?VE5ZNDV4SHJMb3YrcHFwSDYwcTZ2cGpYejVOdzhSbFB4UEVuK3poYndna0Jl?=
 =?utf-8?B?WElIUU9qcHVEaVVwOXB6MERpVlBlNWxneldZWGZ1YUhRbFFSL0pROXNTc2w0?=
 =?utf-8?B?eUpGYkVoVjVkUVdYU2VaNDFXS2VPaW12VUI0MFZIQkc5QmYwY2diMmxMcEhq?=
 =?utf-8?Q?5f4azc1cNXRfh+C0THIKRXR8TEvzQN9r+m9jL7JWoVM5?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 154a55eb-c12c-4e20-205e-08dd1ae481b5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8150.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 19:38:08.8674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WRdq6MBEv3YOy9ud4Lo17W9H7v2hT+iSkwG5LTTs+K32wOJEcDrZOUjjeiVVLXsdJ9RpqfiC8uHwH2ecwdIlKCQHoEvTyfxLplMPL62e0xAPCxQqDyyrhmiPW21/Ej/o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR01MB7612



On 12/12/2024 7:27 AM, James Clark wrote:
> 
> 
> On 11/12/2024 6:01 pm, Steve Clevenger wrote:
>>
>> Hi James,
>>
>> I thought I'd mention this issue with multicore self-hosted trace. The
>> perf command line syntax does not allow a sink "type" to be specified
>> (e.g. @tmc_etf or @tmc_etr). For multicore, it doesn't make sense to
>> specify a processor mapped sink as would be the case for single core
>> trace. A sink "type" should be allowed to avoid the auto select default.
>> In our case, the default is the ETF sink.
>>
>> Thanks,
>> Steve C.
>>
> 
> I'm sure it would be possible to add support for this, but I'm wondering
> if the real issue is that the default selection logic is wrong? Are you
> saying the default you get is ETF but you want ETR? And there is both
> for each ETM? The default selection logic isn't easy to summarize but it
> should prefer ETR (sysmem) over ETF (link sink), see coresight_find_sink().
> 
> It's probably better to fix that rather than add a new sink selection
> feature. Maybe if you shared a diagram of your coresight architecture it
> would help.
> 
> Thanks
> James

Hi James,

It appears the default sink selection is ETF for multicore trace. In any
case, for the Arm® CoreSight Base System Architecture STC Level
compliance, I need to be able to specify the sink type.

The Ampere CoreSight hierarchy is described to the ACPI as follows:


+-----------------+
|                 |
|       ETM       |
|                 |
+--------+--------+
         |
         |
+--------+--------+
|                 |
|       ETF       |
|                 |
+--------+--------+
         |
         |
+--------+--------+
|                 |
|       ETR       |
|                 |
+--------+--------+
         |
         |
+--------+--------+
|                 |
|      CATU       |
|                 |
+--------+--------+

Steve C.


