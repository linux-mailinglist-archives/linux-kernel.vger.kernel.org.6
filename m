Return-Path: <linux-kernel+bounces-339560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 840639866F0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 21:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EFC71F24621
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1933813CFA5;
	Wed, 25 Sep 2024 19:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lu9/7aa+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KnPXpzX8"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A38D1D5ABE
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 19:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727292823; cv=fail; b=a8rBnC7fzmRvmBQ+l8RDPdF7vZ2x2qlBQ+JASByhf/2Ierl5mRxBrBO2k98XrUEXyHry1LLwZx0H4vD1FdGp/DsnEQ/vCq+H4e6WUAjnYRatla4to7Vjc8mrNPoB0+CH4AZUsMmFjU61E8UoezvsTwuAEBQGe38vEhGSpWo3FbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727292823; c=relaxed/simple;
	bh=E3sBxnY4dUyn6nefYbgSjiPkI/7LWKCidPVrDmaQuZ4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HfYqSVCauBIjddaDSKhtpsPH/+QZo89+qDg27CT5+96kqJUdXxF55P8Z3NmVQ2yrSEGF5ekMHVnO1mp28pIGhN4J0Dz/SwVZtYlPlMV546tOgu1F+BYrLl/lnPSDq2Rs6/ONynIQwNIIfF8LV+0NqV1TtMMZJbVia5wH3DBrpcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Lu9/7aa+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KnPXpzX8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48PJBaPo015755;
	Wed, 25 Sep 2024 19:33:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=vyL1n2cAu0KaYKNO3FeQ2x6JrIya02lZ+95zB4Efvh0=; b=
	Lu9/7aa+/5179GtBWDFWKtpu2D/yDQyQOG0PFpwPPHjMMxdrlpoBy6knvJ2YIklr
	Y1NLaVTesSQ148R7gPYeFNgjeRHCwhBH07YTNTqJQNHdyASw5wSoVoB4K4Hxsu1Z
	vK/GtJwm/ifvL22noKtFzqZ4DHOrmX5b+8S/xD3rI0LuteqoSl/I4OdQIFUv2cEH
	NAAAS/mz7PZZF9k82bCKOh9vQ73ABNLOHD/lzquCjZ7spUHpg5V6MWetr55o/9hl
	r9AFx9KhTeEsfsFFoqRXTiQXy254PexUar9260qUt5hbFkjT3l9pPFxWS53YVF7v
	/gW199/AS56hkgXfcwA7KQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sn2cucw9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 19:33:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48PIUui5009839;
	Wed, 25 Sep 2024 19:33:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41smkaucd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 19:33:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCr5s89ZjCsIyjUohehpT8TqrxBzgPk4ln39GNZ90JBOImbqsBFwv2eETksYa6/CCMDvboD5rqXLDmccLLWZHB45AFRaKUP9V0+ESTPxkrr22WEWwhNdozKC4mYO/fLwW5+u0N+pFUZfIWwUjVbhgSOpZWOeZzd9SJ/dZ92g5Hci4rMkfbRU2GypbM59S417yLYvP6qEn9VX0OeLIPpOb31YV4IAIQWslexqlDLsV/4HcmqTisvC9ce2Q6WkcGYvUqiSZXOHtoE/IYJPcJkJU44mGYBeGODLlbxl/4rB8oaXoHIXEmIr/X/4ICQXvpb65GGAKGPhbQvtvnbJWrNVwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyL1n2cAu0KaYKNO3FeQ2x6JrIya02lZ+95zB4Efvh0=;
 b=sj05TV8HM6tKOUQegW996xm9gorq+W2T9X4xlonik6F6E3sdfMoHxEl/Ql1uWZCcYJ1SCWvJqKA0vGbWC6oCWq/H2KYq3YgghAxLMxePbNft9AxCfflOFpJlibbykTh9B1tK3IuiFTuSsGuUJ7r1NFrqgLik3rGmpQGMt17Ms5fOcXfz5Nb4LLMTnN77yt+SZfOhNxUTTh1rU5i9ysE1A2+Fi35FJoLsRkGIi8wN93Eeb09rWIoLaAqxYutegcS7XhNu6QL1jyoAR1EYnCdCs0Ys1V/4jl2oPW2vcGjWIcY0wV9vCpGhuQmdRgiVRywco5NbPcDpabuXoRAoyxuVAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyL1n2cAu0KaYKNO3FeQ2x6JrIya02lZ+95zB4Efvh0=;
 b=KnPXpzX8f3UYw9ByeH2X6lXXT2zqlhQjguU8a9brxQN4hufSZfV/8AiAbJsKIxDMQt2yQOmAHt73OO2ltGRnhWUyrQGdCDKh8ZLJngGH9DAgE44TnraumClrmPZYS0fPpPgapNPzVjrh/23gEPM3XpVbyyrrY93Qm3Vkl9JnC04=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by DM4PR10MB7474.namprd10.prod.outlook.com (2603:10b6:8:18b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Wed, 25 Sep
 2024 19:33:19 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::a2d3:a2e9:efcf:46e0]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::a2d3:a2e9:efcf:46e0%6]) with mapi id 15.20.8005.010; Wed, 25 Sep 2024
 19:33:19 +0000
Message-ID: <f8924491-929b-4b10-b13f-0b6461d28eec@oracle.com>
Date: Wed, 25 Sep 2024 14:33:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/17] maple_tree: introduce mas_wr_store_type()
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, surenb@google.com
References: <20240814161944.55347-1-sidhartha.kumar@oracle.com>
 <20240814161944.55347-5-sidhartha.kumar@oracle.com>
 <20240925020431.joykmu4zzahoglcl@master>
Content-Language: en-US
From: Sid Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20240925020431.joykmu4zzahoglcl@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0017.namprd21.prod.outlook.com
 (2603:10b6:a03:114::27) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|DM4PR10MB7474:EE_
X-MS-Office365-Filtering-Correlation-Id: 779cad68-4b18-4874-6b2b-08dcdd98e8e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0xUK3hXNExvckFaMW9ncFpTWENFeDhJZ1YxYWR5YTk2MVd4WlYwblJxck9l?=
 =?utf-8?B?VTAydFhUdWFySXpXL0xQOU9YaDE5dWZmNnQ5a053V0hlWk1POENjdU9qQndB?=
 =?utf-8?B?Zm9lQzdwZ29NMEJEZVFRNXJrTWNjSFovWnZ4OU80TjBlQ0wzUmEvNm9HSHo4?=
 =?utf-8?B?WmFVT284S0lWcFJuSmgxd0xJakpBZDZkUC83ZTBCWStmc2hjY2hPa2t3bmtN?=
 =?utf-8?B?dGxxVWNxcXdGRVVVQTdjZkdmdUYxTzY3Zy84ZnlrK3J3WkZkWkVvMGZFUzBs?=
 =?utf-8?B?SnFVZkNzdTQ2dVVvZDZqRXV4N1BqQ3ZKai9ock1sUTJaVWJuaWRHb3E2cjJN?=
 =?utf-8?B?VkFlSytMRUo3aWVSR21VRE9YaWp4MTFCeUNyV0xkbHF4UVZTVXFVR1dkakho?=
 =?utf-8?B?MGZZb0t4TldOdkNsZzRxZDFtYlh5ZEphR0JIT09ZSytXbHBtenUxaXJOUHNP?=
 =?utf-8?B?a2hNeXhtZDJDVHAvWkFrTVdvbXRSRTF4dXRhLy9Cc1l6R1VOcGNIeHlqUk5X?=
 =?utf-8?B?dTUwdURUU3hsTk82ODZMcHJST3RKOGNXeFYwZ28rNnpmUzdZQUN3QWlNU0Nq?=
 =?utf-8?B?eHlncjBXY1VPSHRZQUg1dUNEZktnZ25LWCtVc3VlWXhjblhNUndKZGJqdzYw?=
 =?utf-8?B?NlRucHhTaVkyYTluWUVTTnBqWUsxa2NGOEVtNkZnM2ZMcE9LbUd6MjNlUVM2?=
 =?utf-8?B?WUpGMFNEcmZCQWY0Rmwya0gvSFArelIxayt5Z1JyOUZzQXVjUEdONlA5TVVv?=
 =?utf-8?B?Ynl6ZC9KLy9HTXRxeVFYV0Y5Ri9Vc1hQMXlnU3h3K1lqSUlOYzdBRGFmREpD?=
 =?utf-8?B?QlRhaDFCWkhVaXlhaGwvNlVzMTlYNUgxSnB1eU1PUWppS1dnYTVpOVhVMHhl?=
 =?utf-8?B?OG1OT0pta2NYSGF3RW5hRHVocitKYWZmVnZ4bUN4Yjh6SjIwNnE4YmpsbGtn?=
 =?utf-8?B?Qm5tZnFwaGZRSGpHWGt6dzVOSlYrNXNGWElhNko5N1FRN3dyZVlnZVVuY0Rs?=
 =?utf-8?B?SjdXTnlJQ3hDOG9wVU1ySVJ1R0xLM2tSVVdpdUlYN2grUkxhT1dGY0R5RzRJ?=
 =?utf-8?B?TkFiak1WYlhCVHFBd21WS0ZldzlUK2ZvV1BPMTBVUnJVTWFjWnQrU2ZwbGx4?=
 =?utf-8?B?NHFheU9LMG9weFFpRGZPNlhIaXczZFJtQ2luelg4NEI0ZzdWYUJaVmJVeW9L?=
 =?utf-8?B?dG5HYWYzVEpVYU5ncUszWFNZZ3k4YkRycERjL0FTaFBnOEx0OFNaaWhySVNp?=
 =?utf-8?B?VVN1ZWFDRWo4QmU0Q3MrV0xKZGpZanRyVnpRQlRoSXlQWVJ0QkhPWmRUdjIv?=
 =?utf-8?B?NlNOMUx6UXRrLzJVNmZGanFVWUhpUm0xN28wN1VkcUVUUXoxTWpXVGpOTzFK?=
 =?utf-8?B?V0plOHVxdUQ0cFRuM1pqemtNL2NvNGZDVG9oTkpKOVFQcHFOQUV4MERYY0Z2?=
 =?utf-8?B?N3ZmcGFxa1FOUlZ0a0hkTzVpaVVKeS9QVWVCTWpTQTJ5ZHdmdHJhN0ZncU5E?=
 =?utf-8?B?ZTN4ckluajRVR2YzeVhjOVZPckRHTHRPdWt0dkMwaWdkYkE4bStmdkJzUnVC?=
 =?utf-8?B?L05FY2svMm4xYUt4Q0paWUVKWHdNRDFBdG1kallLTTM0TndwTllDNGJnNDNK?=
 =?utf-8?B?cG52NGoxWUF2UW9nODgvV0RGUnRsMUlKQzZsVFVaa0szeW9KMXh1a0ZNVkkr?=
 =?utf-8?B?K3dsY29heUNtNWxHMzFhTnh0YTRFSTJldWVQRW9JMnZnYlNTVEExeDZ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVV2TUtIUlB5T2MvUGFNZGRJRmF2em5aOTNvbUYyUEdqaCt1VXRQMzl3R2FN?=
 =?utf-8?B?SFhVeWkrVkpUL2N0bDVqUm5MbWhPMFljNXkwOFhkUVFtVXhZeTI2U0JodGhs?=
 =?utf-8?B?MlFzM202S0FOS3VRUUtuR2xYUXZuSGJIOUVXUFhtcG9lZVptb3BVWHVTdVFy?=
 =?utf-8?B?MWVnMDJhQkdCVnNvajJUTHRaMkdRTlROeFJWaWlYaVN5aTJLVnM3NVR6UjFu?=
 =?utf-8?B?L05TbzBKenpadWtFTUQ4c01uVjR6SzlCcUtpZTZ3dCtpRTVnemRhRmNML2lk?=
 =?utf-8?B?TGloM1o4Q0tNdkdTTEZKc0ZRSW9ubFpLbjR1SXFMU2VQUWZlcFhmUGhWcjRJ?=
 =?utf-8?B?b093ZFU0VW9uSmp2Zy9XOW5iRDRIRncxMTVUREhtZjZhZlFySm1BUFZxVjZR?=
 =?utf-8?B?M0xEbit1eThYbWI1VGNOTmE4M2lqdFZpL2RteXNGSlZWRlZTdVJxUng3QjEz?=
 =?utf-8?B?Y1ArOURJZm9yVTFyNXB2YzhsM3NxWVcvNlY4VTIwaEZ6bTBYMUFFSC9DNVZq?=
 =?utf-8?B?MGV3VU9kY0VZYW1JNUg4aHFRa2cxbW5aeG41RnhOQXBpZUVGRlNyaEd1aVdE?=
 =?utf-8?B?cmczZzZmUk5WaytkLzl5d1pSczM0NDlUSlpzMm1taXRXUnVKeTBaenhNYUFS?=
 =?utf-8?B?ZnJBcndscUZOMnBhRkcyL05QcjA4aFB5Y0NCNzVlQy9wdVhaUkZPc2t3bnJy?=
 =?utf-8?B?STFOVTNXeU5Qc2Q2ci9UbW5COWdHbFdZY1hlNkVtQTJCK09SbjFkRHRCRktG?=
 =?utf-8?B?NGxzWk80OXhONVFSL3l5WXNkVGJEQ3N2TkRwTFNNa2VJQlBieERKdWg2Ynhr?=
 =?utf-8?B?WVFCcW9JNEk0NHprdTdjeStMRlF6cm0vQUU5MVloSkJ2ZjM2Y1ZqWWM3c3dq?=
 =?utf-8?B?K3dmcUJDRGRWaW81dHVXOG9MNllwVFI0L1h0SE9CVkszREkzMWxVMUpmWklu?=
 =?utf-8?B?SEh2Y0VMU3R2Q29YMlpROW5uYU5RQkMzVGZYRzRKYjNaVUg4OThaNTF2UjE4?=
 =?utf-8?B?QVA2cm5LU1djS2M5TW82K1lEQ2RZWGE3UjRlTHpjQUdicEZPSnVGZXZVdzRZ?=
 =?utf-8?B?UlRxcGlHbTd6T1laSEljYUtOcUovQWwyQmVBQjJ1QzBVeXJGWXZLZ0JOamJC?=
 =?utf-8?B?VXlEQ0g2WUh0aGZibHFFcnFSWjc0ZWlHdytESGpNWFNXT3FTYk5OSlFzUXY0?=
 =?utf-8?B?dTA2eDdjcGRueHg0TEtEdHBFalZjUGFYOG1EL1JIeDNLdWhNNjV2SlhreHU3?=
 =?utf-8?B?UFNwbkM4WkZjSWF6bXpnMmdmQ1prUEZJRUVWSi9yOE5jMSsrTnB3ajVzRDN0?=
 =?utf-8?B?R1BpaTNRS01HNVFxWG4vSnNJbXBHa2gxK0NSbUtSRTlidUZXb2xIcnV2ZHZS?=
 =?utf-8?B?TDZycnRBaEgwMFJrdm1UYTdXVGphQVRDYUkxZ3ZJNldRSmpLR2hveDNUUkEv?=
 =?utf-8?B?OUNhbXhVT0VDVHFLRitKNFBEV3Q4U3A2cGxRWjdGdStNUDBIUDZWSFltMkll?=
 =?utf-8?B?MGt3WEVGWW5vV0dBbmJMSmF4OFRFWGd3VHZ4cG1zcXVvRjk5S0kwaHlXWkcw?=
 =?utf-8?B?bWNvamppTVlrN3VGaUVJZ2lvVm9FenZkSG1QMjdyZER0VW50SFRUSm1ReXlu?=
 =?utf-8?B?SFpoRkdkaGdJRENJUmp5cmk4d3NyY1FZcVp4c0dndFNRNmhPVDROVmRQanBW?=
 =?utf-8?B?M0FkM3JNbnN6MDdWWlZ3d0MxaVRVOW9Ec0h6SG42MUw3K3NPU3M1OE9jbjZW?=
 =?utf-8?B?TFJraWFocEN1SFBSVFZreVZheWVMSUtzVHpUZU14ekFSYkZwc3k2QkE3Rmpu?=
 =?utf-8?B?ajRSdlZWUU9aRlZvYmlFazhjRHg0ZytkeGZrbU83Wk00SHBnVVdYTVREVlRZ?=
 =?utf-8?B?akZqR0JiVkVZTzNQR0owL1RvZU0xd0NvMzcybEJ3czg3REsrZ1ZzSmxndVBp?=
 =?utf-8?B?cHRRbHMwTG9CN3V2Z01JL1VjWW9YZXpiblNjcVN3OEREd3V6VERSREFyZ1RD?=
 =?utf-8?B?c3dFb25jblVENDBiclhWYnhtUHhYRDA1Zi9JckJDOWUvNHN0ckRITjlGUFF2?=
 =?utf-8?B?cVFjRjM2SmRCSUE5L0ZxT3M1R3lpRHFsV0Zjd29hVEdrVklkMWM5MGZnVFdI?=
 =?utf-8?B?UWd4UkJ2eUY4Q2trZ3dxQm0za1I2M2VSSHZkcXNpN2lEWWlFdjVPNm5Nd2k4?=
 =?utf-8?B?cFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9Z6x/RQNCzUo5uVAk8tl3dRZWe7Nasnnsxt6rfS3L3Z0MymZOUcuugi/N8cFjTrGajNDZDZT/uvSu2JtfrlaxEwRiRJA/mHludhbnS9At0ztJ8hCQqgdYa9LeyhR8HOA06PQFxu8hDaRdBDJoL4VsR1si9JGNKgBM+2Hgh62uNNeRzWsZIRY0e0Ni4RMwMrR6kLMEymjcGTXUJrZF0qqyOxa+/2I8OoYoanEYcPna0ZYAalKIa3hfJV8vt1qGaexLl8hpdfNKvsuRur7Qo3TSg4N5wNx64EGy/2vGL07c/TCa8R0EnSoEdiXRGpEddKWQHEnGHfw1HZwKGWiVrpea1cWGcnziQApDRxIykLVfZJspkytnqNWHKygKNT/T98Z+PgXkf9fVrRYAnef2tIXfsYvmSZCToPSfJ2dpp6fTuZbCgRZregRl2U6hRI0Apf3Yvmi2M92lRadIwJV1rOcfziuHk9jG0Wh+C6zVWbf8YTey7sfcI3fosGqr783mJgb9ZvNqOs6S0/67e+sWLSTXxV+PvqEMO4zLvEzaoW0+VGYzbqEUqg3QKlcYBzZSrdAONhbiMS5tpljJuaWbHUpdgKfTDkBUZvwRbzbnonrTs0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 779cad68-4b18-4874-6b2b-08dcdd98e8e9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 19:33:19.3850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4wztfk3cCERzj/oXkVCB0/NpQNhJxDlR1m3Iv53RR2VMkLhIZDa4urkjNBlH7OXNZw5B/3h6JgoqAWCPIfhQBY44ViIBG7s+foCiAh7Hbas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7474
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-25_12,2024-09-25_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409250138
X-Proofpoint-GUID: 5jWNuZDM5KNEX5XR4-7oOsrj0O6ZxcCe
X-Proofpoint-ORIG-GUID: 5jWNuZDM5KNEX5XR4-7oOsrj0O6ZxcCe


On 9/24/24 9:04 PM, Wei Yang wrote:
> On Wed, Aug 14, 2024 at 12:19:31PM -0400, Sidhartha Kumar wrote:
>
> Sorry for a late reply, I just see this change.
>
>> +
>> +/*
>> + * mas_wr_store_type() - Set the store type for a given
>> + * store operation.
>> + * @wr_mas: The maple write state
>> + */
>> +static inline void mas_wr_store_type(struct ma_wr_state *wr_mas)
>> +{
>> +	struct ma_state *mas = wr_mas->mas;
>> +	unsigned char new_end;
>> +
>> +	if (unlikely(mas_is_none(mas) || mas_is_ptr(mas))) {
>> +		mas->store_type = wr_store_root;
>> +		return;
>> +	}
>> +
>> +	if (unlikely(!mas_wr_walk(wr_mas))) {
>> +		mas->store_type = wr_spanning_store;
>> +		return;
>> +	}
>> +
>> +	/* At this point, we are at the leaf node that needs to be altered. */
>> +	mas_wr_end_piv(wr_mas);
>> +	if (!wr_mas->entry)
>> +		mas_wr_extend_null(wr_mas);
>> +
>> +	new_end = mas_wr_new_end(wr_mas);
>> +	if ((wr_mas->r_min == mas->index) && (wr_mas->r_max == mas->last)) {
>> +		mas->store_type = wr_exact_fit;
>> +		return;
>> +	}
>> +
>> +	if (unlikely(!mas->index && mas->last == ULONG_MAX)) {
>> +		mas->store_type = wr_new_root;
>> +		return;
>> +	}
>> +
>> +	/* Potential spanning rebalance collapsing a node */
>> +	if (new_end < mt_min_slots[wr_mas->type]) {
>> +		if (!mte_is_root(mas->node)) {
>> +			mas->store_type = wr_rebalance;
>> +			return;
>> +		}
>> +		mas->store_type = wr_node_store;
>> +		return;
>> +	}
> After this check, we are sure new_end >= mt_min_slots[wr_mas->type].
>
>> +
>> +	if (new_end >= mt_slots[wr_mas->type]) {
>> +		mas->store_type = wr_split_store;
>> +		return;
>> +	}
>> +
>> +	if (!mt_in_rcu(mas->tree) && (mas->offset == mas->end)) {
>> +		mas->store_type = wr_append;
>> +		return;
>> +	}
>> +
>> +	if ((new_end == mas->end) && (!mt_in_rcu(mas->tree) ||
>> +		(wr_mas->offset_end - mas->offset == 1))) {
>> +		mas->store_type = wr_slot_store;
>> +		return;
>> +	}
>> +
>> +	if (mte_is_root(mas->node) || (new_end >= mt_min_slots[wr_mas->type]) ||
>> +		(mas->mas_flags & MA_STATE_BULK)) {
> The check (new_end >= mt_min_slots[wr_mas->type]) here seems always be true.
>
> So the if here seems not necessary. Do I miss something?

It is true that at this point new_end >= mt_min_slots[wr_mas->type] must 
be true but if we remove that check we won't catch this wr_node_store 
case if !mte_is_root() and !(mas->mas_flags & MA_STATE_BULK).

We could change the default store type to be wr_node_store and get rid 
of that whole if statement entirely.

This diff passes the tests:

diff --git a/lib/maple_tree.c b/lib/maple_tree.c index 
4f34e50c92b5..2ae0c4da9d74 100644 --- a/lib/maple_tree.c +++ 
b/lib/maple_tree.c @@ -4242,14 +4242,7 @@ static inline void 
mas_wr_store_type(struct ma_wr_state *wr_mas) return; } - if 
(mte_is_root(mas->node) || (new_end >= mt_min_slots[wr_mas->type]) || - 
(mas->mas_flags & MA_STATE_BULK)) { - mas->store_type = wr_node_store; - 
return; - } - - mas->store_type = wr_invalid; - MAS_WARN_ON(mas, 1); + 
mas->store_type = wr_node_store; }

do you think this makes sense?

Thanks,

Sid

>> +		mas->store_type = wr_node_store;
>> +		return;
>> +	}
>> +
>> +	mas->store_type = wr_invalid;
>> +	MAS_WARN_ON(mas, 1);
>> +}
>> +

