Return-Path: <linux-kernel+bounces-216750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A9390A607
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D848D1F239F1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 06:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E558518628D;
	Mon, 17 Jun 2024 06:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A3svYszc"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFA6184129;
	Mon, 17 Jun 2024 06:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718606228; cv=fail; b=Hl+VAGFMTEd165VzJexCQUMSRaorrhkTWm2YFWD10dIG+eBVB4tLp1NO+PQQrzcy1hGaJrUPz9sR9Te4YsNziMDJMhBCPlum6QGEhyk9G0HDdWaBgHbO1cXpovL6xw2/Wk3HvQtIHNdj+LYqt3UaTuG584gfITWd4HERKka027k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718606228; c=relaxed/simple;
	bh=d27T9WZUL/0fB/4wadkupZtadEzqg/xgWBqRfoeEY9I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GdUo1ggKTnLVx2/M8zdGH9xAn17+R+N6H5sz3Zy3tOKrWW2CYHNDzgKcxC5dp0g7Cn/A3WaMYoHXImlpk0pVeARGDG8rgZ+HoPJiqGrOxLlCYsHJvY/mqmtFPw4zJDXwplVOD4Lfn9iYrpgeREwGu9yjy9jEWH/kljDjqJZy7JY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A3svYszc; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nA2HIPGJYib4Dz0eRPumjIuW2oynd8WcJwav+hFSNj7nTpAabKID17S4XFF8SzPgXQCtO07AhKhUHhEi25tNeZ/gwyRhXSrqylAvQ+wN62VmZJhBA8Uvp3GduVqgE80GHs9S9IicumPXViRIVUmLvy5d+xfOsIKp/1TTQCbkZuKlaQL1JCY8NO7dFYeUshvMOZwUMsf7pyMOS8v70Hy/MHnTyz5DkOYkSSmxrCdMDD/DL2/LnBYLURrM9fobtEzUpVD70LXJ7E3dFPZto/p+TcKEs1EC37GF9XTLKqxv9Prnc91x/lO95xBA089GWxscJRfROFbsek9cbwebpg9NFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOVpq/iog4mbiarhMKl2pWtI5SS9jHaBZRs5rB4N6UM=;
 b=CUU1g0KnYgnsLmPUSUgSXkcvYKZPyLwdIYIVrv09WQ4Agg34UwCIg0C7w5j9Ov37WYjMlkIMHCBoIMoF4kiUA/6K20rRit81li2VZLw0RLOm8NHrI11dH50X8nzxc0eLynoNnCBjxRb0F5G0xuNpbctu6bT8TTh6Bfx82CXUAQi4k/Rw5n/0YlKmLIn2VxsP6qYrRGDIn0pY77akhBQWw4hGl6pwQ1eiLd/hCWnGf05koTLYsBHjZzwkVOMf7tU771VxhIDxNf9oMMpfory7YNIW1t1zU0AVz/xB28KuHOFWIYcVlbSIwC0UAVIJtkEql2o1zqm9iPjUc0pCyDPOCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOVpq/iog4mbiarhMKl2pWtI5SS9jHaBZRs5rB4N6UM=;
 b=A3svYszcd77hEyj3fgThpOxQnxKA5Q+w9vNnU+SESzOtnqBzy8wy7xIU//UgaRANW4yft9BWTDNsTjrl6AUR2suLwDaOn6oHuKkx4c4DdzY7qB1KUViyxzrBs7SebhNjzj3ayrE2mDym4iiqO7gl43bWDeQBtCRMpkvCmAn1K2Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SJ0PR12MB8091.namprd12.prod.outlook.com (2603:10b6:a03:4d5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 06:37:03 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 06:37:03 +0000
Message-ID: <73a0a192-0bd9-49e9-b9df-dcdcfbc1a9e2@amd.com>
Date: Mon, 17 Jun 2024 08:36:58 +0200
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
 <b2c6a97d-6722-44d9-900b-a10e169bd16e@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <b2c6a97d-6722-44d9-900b-a10e169bd16e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0332.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::7) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SJ0PR12MB8091:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b6c2388-4458-4db2-e6ef-08dc8e97e635
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|7416011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0RoWHhLZW51akxXYzE1cHp3dmZ0am9BbEg4ME5OS3VTYnBXZFN6MXc3b05M?=
 =?utf-8?B?U2lDaTNyZ0Q2RDgwNDRYVFNjTFNiSHhPbWc1Njl0VitLZE9pOExYU29vU25V?=
 =?utf-8?B?dElabC96ZllyL2RTQWluOEc1SXVmK2xXeUxYV3R1aG5jcU0xSEhDdEs1WlBY?=
 =?utf-8?B?bWp5bnhnblhjVFB4T3VKT2dzMFJTVHBlY1R3eGJFU1ljcnFZanNkVmxrWXg1?=
 =?utf-8?B?NXZFMEFzUU9Pb1NqVXJlNk0xYVFYM1RIaTBnNHNKS2dTN3E0Q3ZVVThsR0g0?=
 =?utf-8?B?K1lpdFkra0dSRzVaY3F1dFI2VXA3UFRiVFZoZXNSaHJYTDFKUlFFQ1R1U3hM?=
 =?utf-8?B?bHFrUGxxM1doTGoyR0ltQ2ExQ1JWUk9XUW9jOUk2am5XQWg3TElxVnk4TVRQ?=
 =?utf-8?B?OFFQeFJLbEJ0T1RnVEgxM1dhbkxWV1llbGVTenp4MFlpTnpMa3ZsTk5kdXlH?=
 =?utf-8?B?NFNCYk5kQW4vZ29YNHJmSHl0OXJyd0N5emRLVzdtcU1oK2g2SjBqZUhWOHJY?=
 =?utf-8?B?MmNzRHoreENUbU1UY2NNRXl0Ukc4VGIzTWhJTVErZVo0RWZZUFRIRHliYm83?=
 =?utf-8?B?TXVhVVcvMThJUWh5d3VFSDZtQUhSR1V0aGVXeklBaUdsNHRYZ0ZKSGRlMm5k?=
 =?utf-8?B?TWk2cDQzR0cyWE5KYS9lYVdpK3Z5dmRXVmZwcXRrS1B2UVlLU3R3cGhWTzV2?=
 =?utf-8?B?ck5pS2t3RlhaUnROWkx1ZzlTOWhheHVJWC95VVRsSitMTXM3TTkzVlVmbmo3?=
 =?utf-8?B?akpZc3E4MVIzdnZYMFIwem0rcUdqbHBqUGRNUTIyUlFkSGtaY2JQSGdoQjI1?=
 =?utf-8?B?azVXT3grSlFQc3kyWFpuQ2VtU25aem9wN3ZJRk92Wm1qVjlyVWxUTjVXcVZk?=
 =?utf-8?B?cmQwa21kN3Q2ZENudWl1bmVLZ0lWNXdMYTk0TWJ1bGhQSWo5N0EzK2lMdkNw?=
 =?utf-8?B?VmhLYzNRSCtaQ0M1K3dKclRNb3dmUEVTSHNxcnoxMVU4V1pPV2oxVkFYY0xG?=
 =?utf-8?B?alBycWNoMDZRZVlQS1JsRm1kc2tPNkNrNjNrdVNrRnlJWmliV3huYTZ0d0Rt?=
 =?utf-8?B?bVVnZkFJREtBUFpreHFYQUt1SHVVdVdRZ2k4aVJlb0hacE9pVCtoZXBScUho?=
 =?utf-8?B?NG90MitwdEVLaXEvRloyS216NGJyUFhwWkNHb3gxM0J1emM4S3N2SlQ5OUZW?=
 =?utf-8?B?amxWT3pJYm5LWkMrTnRMY2dYdTY4Y2ZKL2psNm9vYjlDd0w0a01TcG1DOFBr?=
 =?utf-8?B?MHQ4eURBWWNJVFpsa296bDNtSTVrdXZjMmlGYktuaEpkaVMwTEd0SURWeVZk?=
 =?utf-8?B?QS9QZ0VGMWhvZjZsMTlBM1loR1FNWFNldEJPdGJ6NjUzbDVqNHdzTjFqbXFL?=
 =?utf-8?B?dzQ2SlZZS2ZmMHVkSXptYlpoUDhkK0N1SDZ2KzdqZ3RNZGRuOXc4QTVzVXdD?=
 =?utf-8?B?b04rcGJjSzFnYnVSTU5mQmxscExlSzVZWTdpZTRrQk1JdEJhSGhOeGs0RjAx?=
 =?utf-8?B?bmJxY1BLbjBFY3JpQlJuRlhLdGRTcXlXSFN6ekduQkhxQWI0K214K0pFbVpi?=
 =?utf-8?B?cnhQVVE2bUlTeTJuWXRubEZLQWluc2NwQ0JpL1VMUjU5MWNvQS9zVkZBcUFv?=
 =?utf-8?B?VVAwZVpxb0p1eVdzN2hKbXJCTGFrUjB0YUR4OWRncWsrWXRmbXFONUgxNGNt?=
 =?utf-8?Q?tD5bBDaa37wpGgEfFQGT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGZ0MkV6NE5kZkhUUnJ2TUVGZ1k1UVQ0ZVRUaGhiWHN2R3ZETGZyVENqYXM4?=
 =?utf-8?B?bzlkd3lES0ZpMEZJMFRIMWU4Y3lXT3F1T0VUNmI5MWtsbWZDNWVSNkdZN3J2?=
 =?utf-8?B?R0RzTTZ2aFRrWW8zTUU4Y0ZxNFovMW94WVc3cGZ2R2dQL3JPTnI0SnlsSURK?=
 =?utf-8?B?QTFISmNhNVJqdlpidzYzdXJKTE5wMW10WndxNjBGem9HOFJ6YmJqKzQxV2Y1?=
 =?utf-8?B?emptdW1pVUFVZVR4Y0JKOVVyYUdjTnRYNEhybzFOVDBQcFByNFU4R0RQT2dV?=
 =?utf-8?B?ZVVOTEZjdk9IUG1xd0t0ZEpVTHh0TVdFK0dVRVJkQ0I3NWQ5TFRrbGtSRlM4?=
 =?utf-8?B?NHZlT3lnVWlnZHp0NmRhRzh1MkxNTVFiOHNraFhrVGtPYmpUQ1huV012TTQ1?=
 =?utf-8?B?L0hhVlZFTlNPaWZXdjljUVRGZE1JWnEyVmhPdXdtSjVmZmVmK3dCL2owWXhw?=
 =?utf-8?B?czV2cE5vOElkTitRNlRIbVBEU21zVkZRMUhkT1I3VzBmY0dFMFpPaFR1NlNj?=
 =?utf-8?B?eW5keXk0bUs5dDl5SjJ3Z0lJRzBKSnhHV01HZThQcG00MUwvdlNhQXYzK0tt?=
 =?utf-8?B?QTlZdEdvYUc2dnJ6QXU5K2pnZFZhYXNueDY0Njk0R2tjejRmQWFqd01yc2RX?=
 =?utf-8?B?cGljZ3lmMUVGVVVZWTNna0doOVUwMHUza3F0eEVDd1d1Z3VBM3oxREFDVW13?=
 =?utf-8?B?clpUUVNncis0aVRmUnhTQlU5YXRla1dIT1JQLzFrd2wvNXVrMmxpdWk5b052?=
 =?utf-8?B?cWZzV2hwa0hOeE1JMWlYY2Y5NWEwOEtpTFVuSkxjUUZwcUtFbkhqZWJPWkpH?=
 =?utf-8?B?bkVaQlo5SVNtbGY1NXpoZnRqL1RpZWdPdzBsMHNvbk1WcG5hTlZNME1vd0g5?=
 =?utf-8?B?V0c4WXBpK1ZrMmw0UVV5aTRSNk1aeDRtZzhrUWJLK005U1ZaUzB0UFBXNits?=
 =?utf-8?B?UXhnVFo0UzZvN1BxRnVPMFFLTndXSVIwblp3Wjc4TlFhUVRLelZNUFNERjF5?=
 =?utf-8?B?MVpTT1BEUXIrU1FyRjZlL043NHBldzgreWl4ZUU1anh2ZVJXc2c2TkVCblFU?=
 =?utf-8?B?UnlEWVQvZERtQXVKUjhxSG1HcWNMalUwOXowNTZNdGtKL0hTV1M3Vm1POTg4?=
 =?utf-8?B?YzZQVkZZYXUyRmNqSjlrcm5xQnNBTi91ZldPUlZkVGtxS2lWWXhSS1puUjJp?=
 =?utf-8?B?Q05seWZxR05yQ1dkYmtpS0wyOXJFVjk2NUJ5bUVsd0VVTkd6NWJmcXZFaXJV?=
 =?utf-8?B?eENyVmJpUlZldkU3ZWhVOWxBOGJqeXNPb1VhbFJZRVhSSHo3MG5wMlpMcGJN?=
 =?utf-8?B?eGJKY21Qdkp5TGFmVlVqWkJWM0xLNXhnZkdDNUluNmUyb284RUphNFM5NEV1?=
 =?utf-8?B?MytIM3RvSGJNeitKYkdZb3NoSDJIeTMzSDlhVThJR2JaYXgrUFY2bkQ0Sytj?=
 =?utf-8?B?WjBWWmZkSWx4cnRiUmpmVGZEanNjeE1keUoyN0NsdWFRMzh0SjVoaGVsb1Fv?=
 =?utf-8?B?TUJHczZrbHo1bnNTZnh4bFdJRWhxWWFLU2N3bmtrUkR0ZGVCcTlTSkp6QWlD?=
 =?utf-8?B?U2trcUhpclBISGpWQm1YUko1Ulg3dnFSMXpNVTJjaDMxdytMNDNyTkpwa1Z5?=
 =?utf-8?B?N3ZmK2RwQzlPeDNsM2x6WE5FVkFUWFJFeS9zdnZsS0xBUFV2YkFzZTFJKzd2?=
 =?utf-8?B?UEN3TDI4VG1TTmZJYncrM1lLRDg3cWd3TDZWc3Job01tdjU5elhTK2RVL2FF?=
 =?utf-8?B?T2c2N0x6UFlUd0M2TTExOW1NM01Xbk05OHptbXNwY3V0R21sNGRLMFJFNy9C?=
 =?utf-8?B?YVVlR1RITEQzVkpmaUVSWXlqTllKVGpmY3c5REZvczJ6Ykt5VHJwMzhRWklp?=
 =?utf-8?B?ZlZSdkZEZC82WHlGRGNvT1lHQTFuU2U1cUEySGNtOFNic3AzUG8zRzVUakEv?=
 =?utf-8?B?Slc5ZWtWaUhqWm1TMStyeTlYMisyZ013WFBXNUR4clVvM29HSWkvbXVRL1Zh?=
 =?utf-8?B?azkvTlM4V3NkSXNOeXdkSkhuRyt2ZUxlQkQ2UWV3UzBiMWZqa1A0NkdTSVh5?=
 =?utf-8?B?U3NmbHRQWEZJWFllV2lPSTJ0WVdFdzV3anhLTlA1RVJoY3g1T0RVUEs5ZHBE?=
 =?utf-8?Q?CMnAo5njdzevh8C9PH5UhPdm8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6c2388-4458-4db2-e6ef-08dc8e97e635
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 06:37:03.4138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vOPte/fU9lc6C6FzIMhNuC7POk9V9KY+nOWfvWke8EQxUIEtvUOy0Qe7herBLQtX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8091

Hi Rob,

On 6/3/24 17:12, Michal Simek wrote:
> 
> 
> On 6/3/24 16:52, Rob Herring wrote:
>> On Mon, May 27, 2024 at 10:53:50AM +0200, Michal Simek wrote:
>>> Based on commit d8764d347bd7 ("dt-bindings: firmware: xilinx: Describe
>>> soc-nvmem subnode") soc-nvmem should be used instead of simple nvmem that's
>>> why also update example to have it described correctly everywhere.
>>>
>>> Fixes: a0cfd5e99782 ("dt-bindings: nvmem: Convert xlnx,zynqmp-nvmem.txt to 
>>> yaml")
>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>> ---
>>>
>>>   Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml 
>>> b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
>>> index 917c40d5c382..1cbe44ab23b1 100644
>>> --- a/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
>>> +++ b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
>>> @@ -28,7 +28,7 @@ unevaluatedProperties: false
>>>   examples:
>>>     - |
>>> -    nvmem {
>>> +    soc-nvmem {
>>
>> This doesn't seem like an improvement. Is there another nvmem node at
>> this level? I would fix the binding instead if not.
> 
> That name came from discussion with Conor. None suggested to fix dt-schema 
> that's why soc-nvmem has been propagated to DT already and this patch is just 
> fixing last occurrence.
> 
> commit d8764d347bd737efec00fae81133ffad0ae084bb (tag: zynqmp-dt-for-6.9)
> Author:     Michal Simek <michal.simek@amd.com>
> AuthorDate: Wed Jan 31 10:17:28 2024 +0100
> 
>      dt-bindings: firmware: xilinx: Describe soc-nvmem subnode
> 
>      Describe soc-nvmem subnode as the part of firmware node. The name can't be
>      pure nvmem because dt-schema already defines it as array property that's
>      why different name should be used.
> 
>      Acked-by: Conor Dooley <conor.dooley@microchip.com>
>      Link: 
> https://lore.kernel.org/r/24fe6adbf2424360618e8f5ca541ebfd8bb0723e.1706692641.git.michal.simek@amd.com
>      Signed-off-by: Michal Simek <michal.simek@amd.com>

Any comment on this one?

Thanks,
Michal

