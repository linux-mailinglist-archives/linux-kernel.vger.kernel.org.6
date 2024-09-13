Return-Path: <linux-kernel+bounces-328672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EF997872A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3F271C21CC0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91EE85283;
	Fri, 13 Sep 2024 17:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="miRKsFFp"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2118.outbound.protection.outlook.com [40.107.92.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEAE59155
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 17:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726249780; cv=fail; b=Cwx0frSl9f7yPJSZ0yk/io4R/UTBfR83q4LEF52Ka1AJ7I1dGjWfQRLLZeEFDh1H6IEuygaDWnuMXjb4Df/S5btxfNjaAcOAThciMEaQKRa+qofGNCKfLUu/ht+ZWL8bclyfRjrG2fFuJugl16tPw78ESuH6ywvEhrc6cHdyZw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726249780; c=relaxed/simple;
	bh=70sOjROi5RQvXzHXHmKP5yeV2/cgpVmqvppusSoLSQM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rrz6sXPyWhOxwqD7bdlvecoPLg+LqoWpEYefJCz++AQV+wcZJX/ptyev1BBegyYJj3NT/gMpuDzv2k25Up+xnYhJtILQdIvuVKPvh9bay9+6oPtqm5T2C3FxTRxfX919CyvuUfR+OBUlV3PE0CNoLI7o15MNtSzBcp1z2qOfgmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=miRKsFFp; arc=fail smtp.client-ip=40.107.92.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4qJZw+MG+WWAsLWe6WxJy1HpKTdoBKFSuYSy7zKS5IwwVfXy9xqlJLw0fU+e93rhWYAl2O4Fp2b0NsIUDFZbzsNBLpAs9Mo5PTm56YgizJWW+BoR6EicQlAH0uFQsQQC5nbTKe2+rfe6/wVu+CK3zUtuLhypA3aip7QmPg9l1m8LIMGD3cJuNz4tniZNhQ3zL52IMUSw323xBfQH7Zpjm/KuzKY/4pWSXet8X2UooGgzsbmq/VSV2sjDesAPHye6Y4C3RdlfzNg0zkKiAKBVfdHXGBsEVVd2RlDrZzWLLy5CND1MvHNqKZ1gey717p7yjQ7nxcjArsIeTS3PUmfww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0go/S/5NnL7UC4HX2KpBQVq/NyaJmIu1p7ZAnxfFqww=;
 b=uzYA2Fwgi8Rmvm08Pi7s0E7yltPNbOeAd1R2zH3IkjvCdeBe9TLl0CZIL0mUPduqv7aG4VsPNW606Yy1ew4/1bX4F5KLAsDqtuBmc3c+1Q1o+Du50bpzqzvqzMetL5QmlzDBRw2qqInOP/zRc+qWVism/dBi60NR8gZzc/qHBk/uIy13evFKXELkTHzqfBPCb/+gzQ9u07Wjsf73MLwf42W1LdTxj5Kf9VSlsyt7iGUeX/IS6n9ZgPcXNcqnxmBYoi4jFxU/OJJ4ZuVUQ7fU8SZy14nWGKvtMPxhOsLJ0spyKVwAUEjpGlvMeuRnR3+KO3o5XydO3G8LLuo7MY/57w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0go/S/5NnL7UC4HX2KpBQVq/NyaJmIu1p7ZAnxfFqww=;
 b=miRKsFFpgmNV2KfRyu97AdowPZ0Wb5TULpZFGmjYx6/LhVzNF8Ntcyss03iwp8p2Ae29mcvO6plR3gJKnWRTCLYWBuCLp50iSxs8qxHvXh4DHiMprMylNBD/J5Vbd7NxuUxARcV3YCbTNsd8ASL8Dhguks+coBgRvph6BsQFNT4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 MN0PR01MB7731.prod.exchangelabs.com (2603:10b6:208:37b::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.24; Fri, 13 Sep 2024 17:49:33 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.7962.016; Fri, 13 Sep 2024
 17:49:33 +0000
Message-ID: <4bb7f2c9-29b8-4fda-945f-8be19b44e249@os.amperecomputing.com>
Date: Fri, 13 Sep 2024 10:49:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v4 PATCH 1/2] hugetlb: arm64: add mte support
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: will@kernel.org, muchun.song@linux.dev, david@redhat.com,
 akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240912204129.1432995-1-yang@os.amperecomputing.com>
 <ZuRyv8Q4iRDabq1-@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <ZuRyv8Q4iRDabq1-@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0055.namprd04.prod.outlook.com
 (2603:10b6:806:120::30) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|MN0PR01MB7731:EE_
X-MS-Office365-Filtering-Correlation-Id: a57bdef8-063f-4e63-d730-08dcd41c6d0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ditJZCtYbkI0dkJZMDZtT1pmY01NaDRnZXdvRWFpM08zYktEN0ExWjF6Znlx?=
 =?utf-8?B?RlRTRE1mek95VXBTNzdUNnAyZUJ4V0pjdzEzbVpGamxBSENJVjZqaWc5dDNO?=
 =?utf-8?B?ODRJVEpFTzNBWklyTHVhUys0aDViamRLZ2RRL3orVm43bkZGTUdHQXU4M2Rl?=
 =?utf-8?B?cHhtdi9XcWVTN0dLc0lQWWV1djlzREVub1hWeklwSzgxdDFJQW41V2pXcHRv?=
 =?utf-8?B?UE1vcmsvNDkyT0hCYTJ2bmR5RW44cDhtc2FvaWpBYXJTNlRnWFhneGQwcDQ3?=
 =?utf-8?B?eGlSdExabHN1cG5tdmxtODEwR0xCOGlTcVlBOGF3WmlvTFF3V1ExUmZMUmRl?=
 =?utf-8?B?MFBtREo5VTZQZExDSWRSTWFBRy80RnkvNWxNNVhWYUxuVnFQZEVORjBTT0tI?=
 =?utf-8?B?cEVuNC9SOGJLTHQ5MC9ScWRFVXBpZEVJVkJGS3FMTFlSbHl4a0QwcUROeWEv?=
 =?utf-8?B?cVgzRTZVUG9TWjh6dTNPdG1mQXNJZ1pvMHhmODZwZ1hWZllJU2VjM3dBZkl3?=
 =?utf-8?B?cU5zWE8vNWVTMlhJYmZGTSt2TzEzZFRVZUl0RGVPTUFWZDBsQytGbWR4dFU1?=
 =?utf-8?B?RE9oQ0tEUmZvRjV4T2huOHZ3NXJQTU1sWHZlOEtSYlVhZTlwSS80cUZVVnlG?=
 =?utf-8?B?cWdHYTlhV3hhR2t5ZDRQS05KNVlZVlJqZi8zUFhRM2lGNmdKU2ZMOWlXMFpX?=
 =?utf-8?B?aXpYTlQwajJkRFU2VXZPOXoyQXIyNGtZSit4U2lsTVZWRi9tck1Uc1BVSlda?=
 =?utf-8?B?VkRCYk5ieHhqQVNkb05ZcjdPNkdocVNMWjN1OWRCMXh1ZEp5UGo2OEFRWU9j?=
 =?utf-8?B?RkUwbTExOTUwVWdSOTFCZlpzdDFqTlFQWW1tSitIRXRGUWhxOVNzb1EweHNo?=
 =?utf-8?B?S05CRnFwZFNjWDZPNllFS2RrMEZvQ0dTdnpkN3ZTWXdHalVkMjNqVTNWd2Q5?=
 =?utf-8?B?aFJLN2NBYkVkTEFFblUwN2lVNXpDT3pTdTd2enl3NDFhdGNWb2lRa0JJV1Vm?=
 =?utf-8?B?U1dUOEVUb0hlSGNOdExCS2pSUllVZ05mUC9FWUV1RHUyUzBMak9aVzVpdHFI?=
 =?utf-8?B?dG9vRksrM1lkZTJ2bUpYNVF0STJFdDdiU3grVlNwR1ZWb0orclZYWEwrVm9s?=
 =?utf-8?B?a3lUeFNPOGEvMWFyNEQzQnZUK2Vvckc0UlljR1JNNWh5eHpncDhmSFdZcTI1?=
 =?utf-8?B?SC9lamJrRjFRT2llNkx6OTBvL2l3NGJXVmJHK056aFdiRmtnd2Z2dGxrajh2?=
 =?utf-8?B?TnoxU1RFSlRjUTROazZadGtWRkhteDNZWXFWU2dWNXUyZ1N2SG4zYjFXaTJ5?=
 =?utf-8?B?SGNjTHhPUHBHOGJWNGFvOTlpc1UrMHNBZk5BbnhBMThzdmwxOW5YRDhQbnQx?=
 =?utf-8?B?SkR5blUralB5WGh2QjcwMmwxL1haeHJtZ2NjcVI0a1N6QlExa2h0azROQmxj?=
 =?utf-8?B?TXI2aFpIbENXTHRQSFM2cWxqMWFmV3JlUi82aE5TMWJsN3BrNHc0djlXeEJi?=
 =?utf-8?B?QTNScVdaUUNsdFdORUhZaWpHaDlzVnArNHlBWmZtTFVYNHo3S3ZuNnlKNnRq?=
 =?utf-8?B?WGJqbnAyaE1KcHhHUlBESzNWNlhpNjI1NHdJcmtQbVcraUZTTnZNTHdXTW9i?=
 =?utf-8?B?SUxyTHV0QU1uSDI1azBwaHphMHR2SGFDd3VUbTBhdVVLbm9VZU43SDlsS1kz?=
 =?utf-8?B?ZG5aT2F1dFJjSjBiYVdEMGxzd0VJU0VFNWxnNldCNXY4NGlvU01aRVI1YTR6?=
 =?utf-8?B?MmMwd09sTjFiVEtrdjBaelFwZGF3cWtzaXVWZmpTYlc0NFhNSDNmcER2MDVS?=
 =?utf-8?B?dkdQemFjK0tsU0kvRjRldz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHBUNXpxNG1Hb3VSS3V6R0g3ejI4aXJBd0xsMUw1SWc2TExsVHlvRC94elF0?=
 =?utf-8?B?WDhrUlB3djNISksvT24xNE91MXR6bUxTVmJsUUQyTmovRktWb1BRSzkwZllE?=
 =?utf-8?B?clF3YTlBZnhXSG5HbU1pOTJqa0R4KzlXYnpOa2RURmQyWGhNaW01bjFIemdI?=
 =?utf-8?B?N3pIS1B4bTc2cW9OTVBHUjQ5ck0yTHpHcE5GNEM4Wm1Zcm5oME5LcGZRMmpk?=
 =?utf-8?B?STZSSHR3ZEQ1S2dyMzl3V1oxRk9lRUs1V0lJdWVjUXVxeHJRd0NMd3JHekdz?=
 =?utf-8?B?MXAvVjhqemFjSmlndUhtcEhudlRmSlhFeGFUMnExMGVTd0xtb003Mkdzbjh4?=
 =?utf-8?B?T3dQbEVaeEEwTXVGcHNNSXdtSVhvRERDcnJVTmg2c0tmbEg4dDA4SHpGK3hW?=
 =?utf-8?B?Y2I0OGQ3SUdUWndLc0RVb0VtcHJadUdUZHNKMHphcGRNQlROTStmWkk1Q09u?=
 =?utf-8?B?QXhxZ0lFOVdRT0FrTGhDMmJlQ1BDNjBuWFU4Q2xoSXhWTWk2UlV0L0xNcGhp?=
 =?utf-8?B?SFZLTjNmRlBZOWVRM1hiWllFd2F4WDdJdlQ1Zzd2eUt0MDZEN1ZacnprMngv?=
 =?utf-8?B?UXMvK3hleEJ4bXdnZi9TUkZyU2NFVE1nZ0FyY2lvVHBORDhaSE9sUDdmV1VP?=
 =?utf-8?B?cktvVlExVTQrWXY2ZnpDSk1xWExiSjhJeUdMMnRRY0Q4YS9LRHhZUDVKbVdO?=
 =?utf-8?B?eHEydWdJc1JBbjJXb2tveDdHR0ZOQXpWaVkzUkk4QUwwQmJKVjlpeFZLQk5h?=
 =?utf-8?B?ajZhSnJZVXJnWS9iQjZwc1FXQm9jQVM4ZDAxOXVRNk05Qmo2TmdkdlMvS2Mv?=
 =?utf-8?B?cEhLblZraDVGNWNXMTU5YnkrVjhaNTY2Y3ZxdTQ5M1BRUStqRUs3c2VjTmpY?=
 =?utf-8?B?TXRTSTMyRUh6WUNQZjFSRmloK1ZFTWJ3cWZLbnl5UmNNRW82bFg3UWkrMWsx?=
 =?utf-8?B?U2FsZlIvTjBMMnIwUHlpNVFyeTdMbi9OZzgxaVpiZnozdE9MekxRaUo1Y2lC?=
 =?utf-8?B?Q0FFYlNLam9Za0ZwNVgrVHZxbUxPcXo0enR0QWd4ckdreUhrSnlOTUdYOVBC?=
 =?utf-8?B?N3dwS3oydDZzYXVpQS81d1gyaGJLdEN3NGJVcEpVTndmbGJ3WkdyOGhZQzJL?=
 =?utf-8?B?RmpqSFlUSmsxRXl2UzNZZ0NVUUp2VTgrb1NvZlRTNkoxb0RidS8rWFQrK0cw?=
 =?utf-8?B?NFRFRXdwUlBKNjYzckUwNjNsTlk1U0hlbXZ4YW5adWh3eEhPREIrL0p0SlVn?=
 =?utf-8?B?RUpDWWU0cGxQUjYrL1M3TE81TWhrSmNsaXlDZ3F3cUNOeTFLYloyejVyeEQr?=
 =?utf-8?B?V01EOWM5NncvaWpMYXdnR2pkTFovMDEvRFRDaExIZUZQVkFwRjE5Tkd6RDN2?=
 =?utf-8?B?RUJMMHF1MEllV1lqdGk3VS82RUhDVDZIZU9wL3A1azgvU0RUb1YzQkhIZUZH?=
 =?utf-8?B?SE1iY0piQlova3o3eFgzSE16aWVab2JaTjMyRHBuYmxPSzNWUHhHUlhTMW5x?=
 =?utf-8?B?dnFHYWh0cjVRSENhcHBHYW1hYUJMd1E2blRzbjVIb1FnMThZWDN2VnAvcUxG?=
 =?utf-8?B?dURWaHFiTHpQQTBZVW9vcG5TT0pYc2wydysvYXRtUkxzaEpHNUJFTGZUSXI1?=
 =?utf-8?B?VHprbnhEZVhnbU9IWU00NkxxclNpNy9ncFVibERmQ0lIQ0FaYXBaRjBwN0Zn?=
 =?utf-8?B?dklhY3FpQUF2UzZSL2kxT0pCWEplU0tGMlJmZ2ZXcjVCNUF6WWhHc25kQWJL?=
 =?utf-8?B?NkJhYnVGWTJSY291bndmbG5QNktZL1psOW9HYTUxaUU1R1VSL0h0NGlLajVK?=
 =?utf-8?B?SXE0eTZKbHNmUHpmMUdjdlEvNGRtMVRSZmZWSjQ4WlVsYU1VcVpUdEpJdWd0?=
 =?utf-8?B?UW5mNnRTbFlaR0lva01XNytuWVAyTEtucUZNREJ3cHU0TUpoMmRsUStqKzJr?=
 =?utf-8?B?UjJCWGw4eHZyODY1QXJlcFgzY2NCcVhib3F4T0ZBMmxUTVhTLzg3Vmh4K1hL?=
 =?utf-8?B?YXptSmxjTDdQVEZaZHNoaWRCeHh0bkR5THI3aWJWVjVJbkVjOVVya3hFb2NK?=
 =?utf-8?B?RW5jOUYrY3NOMFFwMnI0NFpINnV5dGpoNDBqSXFkUkN6WVBOcEFHN0RCVGNp?=
 =?utf-8?B?dUM3VlQ5dERNZ2VpNU1xcGFPOG9KeGFCR2hEUnRaUVZPYUV1bkVFWUZ0aUpY?=
 =?utf-8?Q?NlgYT4yzUtCQrWB8dGCUonw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a57bdef8-063f-4e63-d730-08dcd41c6d0d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 17:49:33.5244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yYcfZy9pYaOjxiUlwL072TKTITTOpPM674g7+ZKBj8LktXLssspayNlFnWwpWiJXIetsJplmgqxQ/s/N7PNKZ90Ry7/EWnEv0dQyMhnNKNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR01MB7731



On 9/13/24 10:13 AM, Catalin Marinas wrote:
> On Thu, Sep 12, 2024 at 01:41:28PM -0700, Yang Shi wrote:
>> diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
>> index a7bb20055ce0..c8687ccc2633 100644
>> --- a/arch/arm64/mm/copypage.c
>> +++ b/arch/arm64/mm/copypage.c
>> @@ -18,17 +18,41 @@ void copy_highpage(struct page *to, struct page *from)
>>   {
>>   	void *kto = page_address(to);
>>   	void *kfrom = page_address(from);
>> +	struct folio *src = page_folio(from);
>> +	struct folio *dst = page_folio(to);
>> +	unsigned int i, nr_pages;
>>   
>>   	copy_page(kto, kfrom);
>>   
>>   	if (kasan_hw_tags_enabled())
>>   		page_kasan_tag_reset(to);
>>   
>> -	if (system_supports_mte() && page_mte_tagged(from)) {
>> -		/* It's a new page, shouldn't have been tagged yet */
>> -		WARN_ON_ONCE(!try_page_mte_tagging(to));
>> -		mte_copy_page_tags(kto, kfrom);
>> -		set_page_mte_tagged(to);
>> +	if (system_supports_mte()) {
>> +		if (folio_test_hugetlb(src) &&
>> +		    folio_test_hugetlb_mte_tagged(src)) {
>> +			if (!try_folio_hugetlb_mte_tagging(dst))
>> +				return;
>> +
>> +			/*
>> +			 * Populate tags for all subpages.
>> +			 *
>> +			 * Don't assume the first page is head page since
>> +			 * huge page copy may start from any subpage.
>> +			 */
>> +			nr_pages = folio_nr_pages(src);
>> +			for (i = 0; i < nr_pages; i++) {
>> +				kfrom = page_address(folio_page(src, i));
>> +				kto = page_address(folio_page(dst, i));
>> +				mte_copy_page_tags(kto, kfrom);
>> +			}
>> +			folio_set_hugetlb_mte_tagged(dst);
>> +		} else if (page_mte_tagged(from)) {
>> +			/* It's a new page, shouldn't have been tagged yet */
>> +			WARN_ON_ONCE(!try_page_mte_tagging(to));
>> +
>> +			mte_copy_page_tags(kto, kfrom);
>> +			set_page_mte_tagged(to);
>> +		}
>>   	}
>>   }
> A nitpick here: I don't like that much indentation, so just do an early
> return if !system_supports_mte() in this function.

Sure.

>
> Otherwise the patch looks fine to me. I agree with David's point on an
> earlier version of this patch, the naming of these functions isn't
> great. So, as per David's suggestion (at least for the first two):
>
> folio_test_hugetlb_mte_tagged()
> folio_set_hugetlb_mte_tagged()
> folio_try_hugetlb_mte_tagging()

I already incorporated the first two in this version. But I kept 
try_folio_hugetlb_mte_tagging(). Will change to 
folio_try_hugetlb_mte_tagging().

I will spin a new version and send out soon since the change is trivial 
and I'm going to travel to LPC on Monday.

>
> As for "try" vs "test_and_set_.*_lock", the original name was picked to
> mimic spin_trylock() since this function is waiting/spinning. It's not
> great but the alternative naming is closer to test_and_set_bit_lock().
> This has different behaviour, it only sets a bit with acquire semantics,
> no waiting/spinning.
>


