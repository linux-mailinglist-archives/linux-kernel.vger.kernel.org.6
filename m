Return-Path: <linux-kernel+bounces-180418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4EA8C6E72
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 00:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD207B22058
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 22:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C5115B56A;
	Wed, 15 May 2024 22:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KFJ/5xzN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cdudK8QQ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8E925757
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 22:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715811049; cv=fail; b=WEnyuA24zrDasLBsBBsn2reNN2TPeAeGBE+znW7ayRNlayYYjVIT1VrEdXbg8hXjWokmvC/q7bNoVDbQ+PbJcOZdh+pTgJHRShvOoVO4MJo7f2zjKbxTOxpCeJNZbHW3SEOD7D4bgxn1fuOH/B2l0TuNuZM2nhkXNXpwtGOVX70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715811049; c=relaxed/simple;
	bh=TmUf6iAn496U7XjeIhrrny9HdJI8WjvxPG+Lk/mFtTk=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gXUCJ3xYhp3oiLj4h0s9J/FRu+NDEUrBxhfa1B05gOl5z0wWXLB959rIW+ZSpuhPwYMpHQ4zz8SEIzaW9JnRfGL1j/RbRCacXEoV3HImo2Y7UaBOAUq0yV/9qzhGTqSOly/VfwQhFwy2621YBMzg7Ckfclcqly7k0tA9RPZJYhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KFJ/5xzN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cdudK8QQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44FKwxW9019441;
	Wed, 15 May 2024 22:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=uhll3mcQQutr52JoblPJjH9skIQWDbuQU/PZ178OuZE=;
 b=KFJ/5xzNAoK2+qcFqoUItVSsAVu5H71NUom1hsMdRuLl6dsXPA//nFwIRi+JgSbZx0eN
 Z9v1Vz8fOeHaMzPH1+XAS8NNxruj/EZygD71Br6EBBsuFnJpYKmiE7UVQR3hpH3sDFZ5
 yhi3DrlwPCdMvkJndJOInh2NcnKxIuaylzIPmkcDsBeAfYhMr/kVnlqhF6DEbwovOddD
 2HQftRaDLjwpnhl3wbnC/VCrl143vjEMQaznJVIpnygfno7i2rAO80N+GKyUmSlJHhTV
 vyK9X0AQOUUqyx7aPPoSzEjdgVv48fOPV0WUMWxLbDjflUsdre1dYw0QHs8H8P4tkWjr 9g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3tx3600m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 22:10:23 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44FLwAEw018076;
	Wed, 15 May 2024 22:10:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y1y4fmtaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 22:10:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYeZ+Iwgw0w5PYioriuZIpep9VAyA0dVQ6R7kXa9wVoRGB+nfTT9J5Cp0GRiyIubfCZQvGIL9+qvuiHqpBykYeLNccHi5KNllIE2HuiiO3FCZ7Y/qTwytdHvzS5hnVhz0fyFgg0Z7otABCe7bi1W/8BUiIllOrC93hJMNA+27ylKO0ZHeUk8irRMFLH4Ic5DRH9zZ+5xj9R0K42GBHELSrjr5ICnTD6aRqzCjUrZ0dK/cQlYWJZFeCfephvjhR3d+F0iHu/ld/r6JvKlHaiKJUdF4qdO9/rpOoFc1RQCJi5yQNbWQ9z/UchSqxsOXbhlSD8pZk3S6oqfz7RLspN+UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhll3mcQQutr52JoblPJjH9skIQWDbuQU/PZ178OuZE=;
 b=MEtBTeM47sJkxznOEnBcQ33MF1brXjoMrIfg50z78QVSorcw9jO0CpSwWVOePpYAVDwbfp5qqSrgclVbIgY9VXYlw+U0FoY24YPNHL8kiAd50G7iB42nIE6yHX44kPDWWL6842+L6l2Fqt95G7wrN6GTGta/t+/dIJq7liCE+U0V2ENzmbz7Ui57UU/52qp2kijySxvDjwd5QNTc5RZTOkHHRSJeWPXu5kDPgDcH5SfO/IGZgP1nmYcSAIKrqqHQXXbuM9JBPNlnRULfuIA9vxCcK4vCJOe7Jvr8WmLgQh6vdOtsPyC4T2zBrU4pyvUdhvGZ/vZvIm+h5rAHdUCtyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhll3mcQQutr52JoblPJjH9skIQWDbuQU/PZ178OuZE=;
 b=cdudK8QQnkFIcUQ06UgC4I1asr7PO38r7amiEN68TUX0A0pa48EBXtnXw+/944/1Sm061VOCZ5g4AKWZ6wYOulJ0t9wn5dABg8u3B1XzJU2rj7AAkta100aXNqG6q28HqkirdEVqomefVy3aqME0MVyXG+0S0hplYOHWBpe+apU=
Received: from SA0PR10MB6425.namprd10.prod.outlook.com (2603:10b6:806:2c0::8)
 by MN2PR10MB4176.namprd10.prod.outlook.com (2603:10b6:208:1da::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 22:10:19 +0000
Received: from SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::447b:4d38:1f8b:28f1]) by SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::447b:4d38:1f8b:28f1%5]) with mapi id 15.20.7587.028; Wed, 15 May 2024
 22:10:19 +0000
Message-ID: <87a01991-3631-431c-8654-5b757b03e2e0@oracle.com>
Date: Wed, 15 May 2024 15:10:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf: arm_pmu: Only show online CPUs in device's
 "cpus" attribute
From: Dongli Zhang <dongli.zhang@oracle.com>
To: Yicong Yang <yangyicong@huawei.com>, Will Deacon <will@kernel.org>
Cc: yangyicong@hisilicon.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jonathan.cameron@huawei.com, prime.zeng@hisilicon.com,
        linuxarm@huawei.com
References: <20240410095833.63934-1-yangyicong@huawei.com>
 <20240410153419.GA25171@willie-the-truck>
 <d7c4da97-92ba-4cb7-ecd5-5edc4f52fd8a@huawei.com>
 <109dada9-3164-9a04-5b7e-1031ff399017@oracle.com>
Content-Language: en-US
In-Reply-To: <109dada9-3164-9a04-5b7e-1031ff399017@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0287.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::22) To SA0PR10MB6425.namprd10.prod.outlook.com
 (2603:10b6:806:2c0::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR10MB6425:EE_|MN2PR10MB4176:EE_
X-MS-Office365-Filtering-Correlation-Id: 59048ce7-e7ce-4925-8161-08dc752bcf07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cWdIbEVadS93S1RCTlViSUFDTm5UdnZmUXloV1JEczV2dUp6YlVDR1R2K2Ja?=
 =?utf-8?B?M3ZuL3lHSm0zbnJ6bERaaVlSOGtLVXVQR2hvMklEdXE2WGFzenRwdlhiRnMz?=
 =?utf-8?B?cHNKeHlXdy9kSGRsak5qcUg1Y3FadzZDREFFNnFFMHJVb0pOMks2R2pqTEl6?=
 =?utf-8?B?b2t0MUxldWtIbWdqdGQybTU5RU5wT3lET1R0OTU3UDZTem96UEdXaWVSWDJt?=
 =?utf-8?B?VTFvRWc3RHMyTmJjZzlkWEpzTGFsbUwxaTQ0MGhSTG43bWQzWUNhSFR2K2Vv?=
 =?utf-8?B?R0F1SUZWelJDTG94YmtNdlkwcmRQbjdsdWsxMUovTWV4VE9XeDdiS0g1SEZM?=
 =?utf-8?B?MkF4OTlRL2orR2FOYmNsWW9OZGFjSGtia1JIL2FVNDFiVW1SVGEwbjc0Z01q?=
 =?utf-8?B?NkZsUUFsYUYvaUVLenB3dTFjQkpvSGk3VHNjTmxzeUJtOEJGdTM3NTBUMERS?=
 =?utf-8?B?TjB6NDNUU0pDTy9zR1FJemIybWlXbVZaVytOUi9YOHNzMG55cXU3Qkp4OEli?=
 =?utf-8?B?SFhxeEN5ZlFFeVFPMnU1bkpkUVVEaHY0c0ExYUNhVHRtQ3REWWZDYUM2RFdR?=
 =?utf-8?B?ZVJaVnltcG5QYjRwL1VMWndKM3NySVo5RlY4ckNtdHNpckhBcVVSdzNxUDVl?=
 =?utf-8?B?MGw0dENyUkRCd3lGd0xSMjhJWWRHZzdxUU5FQURlQ3hwOGg1WFJOaHhyeWVJ?=
 =?utf-8?B?Q01CUTFQNnFhU0xDalA0Qk9ZMS9OS0tPaEtSYTlaWWNMOEhNSEViZXZuNkRn?=
 =?utf-8?B?NVJrbEJXcGpVMTdiU1RnSER1UDc0UlJwY1A2ekd5WnRYN01mV0lHOVJteGJr?=
 =?utf-8?B?KzlmVEFZMFhSRE9nb3BiNHByMjAvTHJvNlZzOHBmR2NZSndBMHM0WXZjY2sr?=
 =?utf-8?B?blRraUNTS3lxU0U5dFZBcm84enQ5aHBXUk45eTNwNlhuTExITytiZDR0dDhu?=
 =?utf-8?B?ZllLWjd4WEo4b0RWQzNUQXpyTXZkN0FWeGZRYjBqSUNNajRrN3NuTURySU8z?=
 =?utf-8?B?QjZYaU9TSGNySkhEYm5FTENRMkRIZzhHNUhFMWFzdkVjRUhzYUVMZ2lNNS94?=
 =?utf-8?B?Tm1langyNzI4T2dWNVRpaXBwWGpackxzTFAzNGZIamQxQVlraENzUVdXTmlC?=
 =?utf-8?B?T3NqNkpEVVJwOVFUUCtNSmRubEJvcFB2MmNFQ0JFVE0yS1BzZE45MG5Od2JD?=
 =?utf-8?B?V2dlRDQ2WjVpUitjLzMzemtYeU45dWlqWFFWNjhRV0ltUGVlWUNSUGpCVndD?=
 =?utf-8?B?dytxNWJYLzdvc0ZyQ05wWENxdUVodDQ4L1F5VzZkRnZkQzMyWjFHWjQ2aWZD?=
 =?utf-8?B?K1JWR2E1cDg0OGRSUFo2OCs5WUI4YzZ6Z2xSYnVGR3dBbnd2d3V3Z3VqdGpl?=
 =?utf-8?B?SmFIbFRObHNIc044b0E4RE9WVllQQzZZMjNpYklpZjdCRFkxeXhNYXBTcVVQ?=
 =?utf-8?B?YmdpbU8zQlhObERwY2dubWs2czhGOHVIOHk2OXh1dlA1ZHRqY3RPcWs0clVE?=
 =?utf-8?B?M2FSSFZIRTFwZ2Y2UTM1NWtTZEFEWUtzSUViSFo4ODZaLzNSL0V3ZWxGT2M4?=
 =?utf-8?B?R3Y4Q0sxbUhGeGlMZFJWbHlMa0ZpY0tLalpKU0ZsTHZyT24vRmtzbStvTVJr?=
 =?utf-8?Q?PmTshyfnbbF15Cm5iMBRn9asT/Jc6wBJkWjGx+APr2BI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR10MB6425.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RVZFNGdVblFwR2hRZFpzYWxoYVJqN1lERlhFd2F5MVNrSXlDcGE2TkNRc1Rm?=
 =?utf-8?B?NCtOZFI3Q1BZWERsMklpTkY5TzVUdkQ2cHhwTXRoeXNHM1ZkYWZqcGJyYi93?=
 =?utf-8?B?bFdXV1hUQ1YxTFhCZmRSQVlpVEVJcVhvL2phLzFKYkFFNUxtL3NMbEJGZ00z?=
 =?utf-8?B?ZFZWVTRrS3o5TlY0aVp2KzZ3UnVLdUNsczVHR1kza29jeHdYODlmSi9naCtB?=
 =?utf-8?B?ZVArQzZhakZsYlp2ek5OaStjME12SGJkSnovNHgrYk50TnlSa1ltQ0tXR2w4?=
 =?utf-8?B?TUpaZVZZaDZFNU9rVUUrRVFOOFJBNmJtaWlkeDlhUlRWQldqV1p4L29DRlJS?=
 =?utf-8?B?Q3dtRzdDVDB3T3NjR3BGK25qMVlPWGYxMDhFV0ZudEJiYkZHSW5WWTk2cFRI?=
 =?utf-8?B?OEdwOWpIM1hkaVZPdy9MakQ0N2dQelJOdEtQem96ai9HL09RMjVDVllaNDJG?=
 =?utf-8?B?djVrL1llYVNjUkFJL2toSEFLZXIzUnFZM1RBYmJIZDRZcDB3dDJtMFhBSTRy?=
 =?utf-8?B?Q3VOWE1EQ2xiNEkxd3FqbDlsMGVvSlNTMVorR0NBNkI1R2c3bHdaSkk2Z3JU?=
 =?utf-8?B?Mjl4NldKSE56YnNvOE56WGhoL0JqSlJ5Wm1CSVZQY2h1Q1hDc2FMeW5oM2Zt?=
 =?utf-8?B?Ym1MUHJOWmxyWHgySGFtQ0d5RDVJWmpQME0yY2R5RloyRWV4VWVwNDlLd1Bm?=
 =?utf-8?B?ZVVTSGZaQXM0RVo4RTU0U05zeGgxQk5aUDRBdkNwSXQxNWZzNVNtTDV5dm9Z?=
 =?utf-8?B?MXdSVGFHZGhZbmdLVXUwQXRyQlFEeFlXZUd5bjlyRTk1bU0wZDZNNG9JM1Ba?=
 =?utf-8?B?UWJDYWt1cTlGR0ZXazlPSHpDdFVTUUZyME5rRWJhQWhGbCtVUDRsWVpzVHJr?=
 =?utf-8?B?a0x5blpUK2NpYkRnaVFyL3F1VUMrMFYrUkN5eWJjWUduaTdGU3BEL09vN0Yx?=
 =?utf-8?B?UUlwcXlHU2plQWlLd0VtSTZZdDczVWpHNHVYNktDaTJzbWFyRXZDU3NqZzdy?=
 =?utf-8?B?NU5FWGdxbmp5OGoxOXc3RVNRcnQyYmRlQkdlOGtwVXpCbUZUVVR1Rk42Z1hJ?=
 =?utf-8?B?MHZwZWhJeFV5WVIvL0x3T005ZUNRdlo2U1kwZ25nalc2bUY5OW9DQjRLK0d5?=
 =?utf-8?B?WnJid3JxbUIrSmsxbGdtTWRFaW0vZlZINituUm8yM3huL1dRZnVibXRnRC9q?=
 =?utf-8?B?aC9tUmtHUFp5TGNQdUg1RW1DdHlha3lHazlGb0UyWnd3QXRMYXA3NCtxWUZm?=
 =?utf-8?B?Z0FrblRWUTE0YVZLWlN1SjE2bW5jUXhNZDN0UW1yUXNxeFFrdGM4Q0lYUG1R?=
 =?utf-8?B?UUtoTEdlUTJ3ZU4ydHN2UFE3azcwM2prcXhBUDlFUW5Kc0VDSTM1VmdoUlhy?=
 =?utf-8?B?SDJsR1VjMWFIQm5hTUpSNWtoSXFnd1p1RWZqYXFlUnJPOUk3MnNHQ1g3OUxa?=
 =?utf-8?B?Q1ZvUHBKY1dRaFJ4RVFLSjBaOFMzRkdPbkNzL2N5YWc5M1RpZHRDNkRZR25P?=
 =?utf-8?B?cWI3M1c5NkFiTHNQa3R0U2RHOFBoSm5sSC80YWcrNHk1NG9ZOW5HdTdUSU0x?=
 =?utf-8?B?c2NseEM5b1ozanBoYmdmT2JsaS9LZGloendLMEMraEdxNVhYSnF3Wi9QY1lp?=
 =?utf-8?B?L2FyWERzYm01T1dHQzdtNEM5RlhvNzVQcWJNd2QzL2cwbHRoSXdlSGFCRVJI?=
 =?utf-8?B?TmZsVFJuN0ExdXd3MmZsbUN6eXhTKzlGZmY0Y1lFdVBibnZVVjBoTEtrMCth?=
 =?utf-8?B?VWxZajBrMkdaZjZjT1RQbUlKd2dkTzVKMUhjcnpmWnZxVitXczJNcHFHcVhx?=
 =?utf-8?B?MFlBUnNFQ2ZCT296ejh5VU1yanJPOW1xZ1g1eGthcXphUmMxdkJvZjRkUjRZ?=
 =?utf-8?B?RHUreDF2NU5SdjNub3Iyc2x3NnlUcGZyVnNxTlJBVWU0OGxwWlJ1MkRLQ0R3?=
 =?utf-8?B?bjNjZ2VYOFpGektzVXp2UENnMENDY0ppdUVteWF0bVJneVFOS3ZDMzcrVG5h?=
 =?utf-8?B?VkZKeUlsOTVBY1RWWWZQcVZ0dmNtQ0tIVkFXNjVETy95UVBRMXVUWFk3RkZu?=
 =?utf-8?B?YU42S0NNUThUWSsvVTFwWVloQUpwUmpsMkZma0NtSW91dmF4REtnbHovd3BM?=
 =?utf-8?Q?rdOgrhA4qQ5scakfPkwihMfdB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	K3ru7P2zSHjU0QuqvVDxSsE2jwetQTeNOb7i5oYLsrp+o/2eNNkCZpivJwE/ZmXvA+DHYyY8KyCLz8E02b+Zj1gASY3+h88neXeHz6/QrdwGX37LrxumrxrWWvQ5kREFoEONkTwaNFcgI34Qc1aD9iBS4FTX3ardu0GU2jEalkCBFcNMMXU5OAJKqscvLNr+xcxTlxFs/RPESDcRWMBd5N6AezDYiCg26r3Y1MdLfIHxx2tMUsSixLvPmQNml4ijpXixU3OMF5dUcEdn4R1qpB981zAzNG4fs0iKR19EeHH9qcJIkz2ObJNcDYwxFIPlTyRxtjDAOWGQ25jJClQCepkbwordyM98AQrte8d3xlThWZZj8FcgRbtXTqzsIJfnHQrQCr0FunM/ZjprDS+qvJ9SEqWyeBseHdws3xjSh7k4FPzxPFft+pMHXjihIET1ZGntoZnRf3APX9FKWlBiNAM2t+U8Q7fuClou0uzrfO2FNGY0RA1LlC3j+vx5rWUiV5A6kDB15nNpqbHGqaXIcF+5RqDhuZnUGduZ9+ZSI7AqoJRzw5RITjypoM25ZGMIMD8yXKc7K4EskgnrSf+xTwKyEAr/idxSX8nBOW0+oow=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59048ce7-e7ce-4925-8161-08dc752bcf07
X-MS-Exchange-CrossTenant-AuthSource: SA0PR10MB6425.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 22:10:19.8504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WIOIkv8eMmG6Da9DXuAI2iOQwe0HoogOhPEniMEbm2Vja1l28PcWsbsuIRUYP1bG5Itj6HOwnlr5c3TLWcNP5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4176
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_14,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405150159
X-Proofpoint-GUID: p8NIwO3CsDAhxOHX7EeDVqHYP0VwD9E1
X-Proofpoint-ORIG-GUID: p8NIwO3CsDAhxOHX7EeDVqHYP0VwD9E1

Ping? Is there any plan to move forward with the patch from Yicong?

Thank you very much!

Dongli Zhang

On 4/18/24 9:32 AM, Dongli Zhang wrote:
> 
> 
> On 4/11/24 01:55, Yicong Yang wrote:
>> On 2024/4/10 23:34, Will Deacon wrote:
>>> On Wed, Apr 10, 2024 at 05:58:32PM +0800, Yicong Yang wrote:
>>>> From: Yicong Yang <yangyicong@hisilicon.com>
>>>>
>>>> When there're CPUs offline after system booting, perf will failed:
>>>> [root@localhost ~]# /home/yang/perf stat -a -e armv8_pmuv3_0/cycles/
>>>> Error:
>>>> The sys_perf_event_open() syscall returned with 19 (No such device) for event (cpu-clock).
>>>> /bin/dmesg | grep -i perf may provide additional information.
>>>>
>>>> This is due to PMU's "cpus" is not updated and still contains offline
>>>> CPUs and perf will try to open perf event on the offlined CPUs.
>>>>
>>>> Make "cpus" attribute only shows online CPUs and introduced a new
>>>> "supported_cpus" where users can get the range of the CPUs this
>>>> PMU supported monitoring.
>>>>
>>>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>>>> ---
>>>>  drivers/perf/arm_pmu.c | 24 +++++++++++++++++++++++-
>>>>  1 file changed, 23 insertions(+), 1 deletion(-)
>>>
>>> Hmm. Is the complexity in the driver really worth it here? CPUs can be
>>> onlined and offlined after the perf_event_open() syscall has been
>>> executed, 
>>
>> Yes. So we have cpuhp callbacks to handle the cpu online/offline
>> and migrate the perf context.
>>
>>> so this feels like something userspace should be aware of and
>>> handle on a best-effort basis anyway.
>>>
>>
>> Looks like it's a convention for a PMU device to provide a "cpus" attribute (for core
>> PMUs) or "cpumask" attribute (for uncore PMUs) to indicates the CPUs on which the
>> events can be opened. If no such attributes provided, all online CPUs indicated. Perf
>> will check this and if user doesn't specify a certian range of CPUs the events will
>> be opened on all the CPUs PMU indicated.
>>
>>> Does x86 get away with this because CPU0 is never offlined?
>>>
>>
>> Checked on my x86 server there's no "cpus" or "cpumask" provided so perf will try
>> to open the events on all the online CPUs if no CPU range specified. But for their
>> hybrid platform there do have a "cpus" attribute[1] and it'll be updated when CPU
>> offline[2].
>>
>> The arm-cspmu also provides a "cpumask" to indicate supported online CPUs and an
>> "associated_cpus" to indicated the CPUs related to the PMU.
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/events/intel/core.c?h=v6.9-rc1#n5931
>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/events/intel/core.c?h=v6.9-rc1#n4949
>>
>> Thanks.
>>
>>
> 
> 
> The arm_dsu has the concepts of 'cpumask' as well. It also has 'associated_cpus'.
> 
> When the current cpumask offline, the cpuhp handler will migrate the cpumask to
> other associated_cpus.
> 
> # cat /sys/devices/arm_dsu_26/associated_cpus
> 4-5
> [root@lse-aarch64-bm-ol8 opc]# cat /sys/devices/arm_dsu_26/cpumask
> 4
> 
> 812 static int dsu_pmu_cpu_online(unsigned int cpu, struct hlist_node *node)
> 813 {
> 814         struct dsu_pmu *dsu_pmu = hlist_entry_safe(node, struct dsu_pmu,
> 815                                                    cpuhp_node);
> 816
> 817         if (!cpumask_test_cpu(cpu, &dsu_pmu->associated_cpus))
> 818                 return 0;
> 819
> 820         /* If the PMU is already managed, there is nothing to do */
> 821         if (!cpumask_empty(&dsu_pmu->active_cpu))
> 822                 return 0;
> 823
> 824         dsu_pmu_init_pmu(dsu_pmu);
> 825         dsu_pmu_set_active_cpu(cpu, dsu_pmu);
> 826
> 827         return 0;
> 828 }
> 829
> 830 static int dsu_pmu_cpu_teardown(unsigned int cpu, struct hlist_node *node)
> 831 {
> 832         int dst;
> 833         struct dsu_pmu *dsu_pmu = hlist_entry_safe(node, struct dsu_pmu,
> 834                                                    cpuhp_node);
> 835
> 836         if (!cpumask_test_and_clear_cpu(cpu, &dsu_pmu->active_cpu))
> 837                 return 0;
> 838
> 839         dst = dsu_pmu_get_online_cpu_any_but(dsu_pmu, cpu);
> 840         /* If there are no active CPUs in the DSU, leave IRQ disabled */
> 841         if (dst >= nr_cpu_ids)
> 842                 return 0;
> 843
> 844         perf_pmu_migrate_context(&dsu_pmu->pmu, cpu, dst);
> 845         dsu_pmu_set_active_cpu(dst, dsu_pmu);
> 846
> 847         return 0;
> 848 }
> 
> 
> However, I think the userspace perf tool looks more friendly (just return <not
> supported>) in this case when I offline all CPUs from cpumask of a DSU. Perhaps
> because it is NULL now.
> 
> # perf stat -e arm_dsu_26/l3d_cache_wb/
> ^C
>  Performance counter stats for 'system wide':
> 
>    <not supported>      arm_dsu_26/l3d_cache_wb/
> 
>        0.553294766 seconds time elapsed
> 
> 
> # cat /sys/devices/arm_dsu_26/associated_cpus
> 4-5
> # cat /sys/devices/arm_dsu_26/cpumask
> 4
> # echo 0 > /sys/devices/system/cpu/cpu4/online
> # cat /sys/devices/arm_dsu_26/cpumask
> 5
> # echo 0 > /sys/devices/system/cpu/cpu5/online
> # cat /sys/devices/arm_dsu_26/cpumask
> 
> #
> 
> Dongli Zhang

