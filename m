Return-Path: <linux-kernel+bounces-540026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653E5A4AC96
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 16:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B26BF3B8E70
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 15:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A221E25EF;
	Sat,  1 Mar 2025 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="S0qIdqJo"
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020137.outbound.protection.outlook.com [52.101.189.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7677A1DED79
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740843868; cv=fail; b=oRVW2JKZoBKpJTePqT/CuSKOhNQTZaoXeQVrWYCS7rlKml9GW8rM6EN2FMpjtsFut+5QndBb8DGc+k++tcQhnDQ6xCEW//Rbtn1Ptc2NLRcIlwNMnTYw02GUnGgkqngaUW0leqDDOJcIPlgnaKABMcb8NY7RZsJBBer0OsoRABc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740843868; c=relaxed/simple;
	bh=HJ1CsQN9P8JnbyefiJP7EbbbxFFVsUTfMQSkigkPvh0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q+CM8sWsxcv1Or65YyUyDZ8BqZ6ucjwH03STnYIsX18bY7Gj6tMSTgYsYr1rV1DmdnJhHHY6Ch4WXfnclY9XhqwdHscn2sCS6uKUMLerXMaNq0U9EaEOOHmMrdKorJFdqq/0jFghv4yOvV6m1iXMCwlRCvQfFPovbJxAsjtk/ZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=S0qIdqJo; arc=fail smtp.client-ip=52.101.189.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qc4AkxbjCbNWV5ekVVM6jbMiWQG+4jCPkbuh8WBXWmY600br7s4Xc8GX+hF2y5fp/ZSuryTMClfefs898vnbAFxyArsrhMnfTSeLqyqPsfNQtkb1VA6+XBYydWoRZgk8VlPWOYHZN3yWfuSQUGFdXU7V60GUa1q3xHJPDNT4CVjgiAUcvFUKXtBO+md7+aoXVQnbPEIBPFpjHxdcoi9Xp8JpiXD5fUh4bvdvXcQM/Wqk3EgZkFy5foI9kt3Ovx4kMg00t4r/BGcaQwvRoVA9u0nKxBBc7WOiS0Kbr3pies+xAOUGPCxna6hrqFiCni/QncoyFxJjSKdjuZrHCI2nEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdu04nOLzk3ZtJb9n3nFiry9OQrYbxbC24TlQjgWdyM=;
 b=hgk7F/VtcuGfwZFP2EuA3ggXdtM4gGx7N7f+VFiGc+AgWiRlLrxEl+aYD+n3SBtoF3FfytWJVxm/jsfmSJlUFmN2LR1zEeVaQtUZDePemyqFVPmztRPwErviQQtlBmXBIq/3TdbSCJz4l0ZNlY1lZtnPUEwuOGbmA2w0s9jj844ZwsAxL/sg2PDCwbUNKWL+lpb0yilXkpZFXP6KlWorS7w88xUmtu1/ByIP4Pi/DP6e2GiLlu8xn6kEqBu9zuckPzq5hK6vHUvwTrAIN1/VOG7zevzTHqWXpqZP1NavJRkMUf1zIy9xxLUL+SpBjNGuomMEdO0Pg+n6WK6p80tjLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdu04nOLzk3ZtJb9n3nFiry9OQrYbxbC24TlQjgWdyM=;
 b=S0qIdqJoorcgRGRUJ9Pqv1DO+WY6NdC0fk3hghNf98tZJMF8gO6LK+v4jXTf9/2N4pdjrfkMTYyGmOi81qFKbvspfJ/q3N8I4J3806z2uA0n2xjDt2woX0tcKTugc9LlTJ6OZ1AmQV/a++fgTYhNajp/fCCYuXSGDfs1npz8CX9bkGoauwuHK5mnYbgyoXXT0byzf+GG5D+4RxocfL1/QquNgzOk/kBPk6o1VTAp2jBkpVlNzX63QVJDsz72RyAtulzJi0JU7kxpZxQGO48KzXbctozq9j84KXxPAWldS4PS+EVFEBJCRvqG4Yl6NlRRijXEuEz4QYlLz4MeEfcm+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB8166.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Sat, 1 Mar
 2025 15:44:24 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8489.025; Sat, 1 Mar 2025
 15:44:24 +0000
Message-ID: <e14516c2-bd7c-4bf1-b2af-314d23d8f59a@efficios.com>
Date: Sat, 1 Mar 2025 10:44:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] SKSM: Synchronous Kernel Samepage Merging
To: Peter Xu <peterx@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, Olivier Dion <odion@efficios.com>,
 linux-mm@kvack.org
References: <20250228023043.83726-1-mathieu.desnoyers@efficios.com>
 <CAHk-=wgedRzDqOLhbOnvziVHZm9jtGOrT4GJEqA9etJDwTQ5Mg@mail.gmail.com>
 <8524caa9-e1f6-4411-b86b-d9457ddb8007@efficios.com>
 <CAHk-=wi5-+P49c3NPeZB_qrNyOtAJS3YadHB0q7J3eZ3UUwrjw@mail.gmail.com>
 <cc1dec8c-8323-4c67-913f-5d8fb55ce715@efficios.com>
 <Z8HlL4FopVjeveaJ@x1.local>
 <60f148db-7586-4154-a909-d433bad39794@efficios.com>
 <Z8I5iU6y_nVmCZk6@x1.local>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <Z8I5iU6y_nVmCZk6@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXP288CA0027.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::35) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB8166:EE_
X-MS-Office365-Filtering-Correlation-Id: c7d84ccc-4b38-446d-c1ad-08dd58d7f0c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dE80cnZYZStEamNRakxFWkdSY2VoODl6Y2EvajE5QnZ4UXNYUjNqV2xUaHdX?=
 =?utf-8?B?Zk9udWpYOHNRWU5RVDB1SXZ4RldNVDJ0MDNFZUZLNkpHcENQYitBU245NXV2?=
 =?utf-8?B?Qm9jakg1UFlzUzVveHpQQ2tLV2kwTllZVFpJL1lmRHYvaUpKNGZHMGNZU3FC?=
 =?utf-8?B?akFldXVFWmlHUDI2VGl2U3NZVEp0Mi81ZTNnby9MNXliVCtYdnRJZDh4U2tx?=
 =?utf-8?B?V1VRS2drMFBTWTRkQThqRmVqeFJsVU5TbksxUVliZ3I4N2ZQRzExZEVRWW16?=
 =?utf-8?B?eElHYlJVcWQyaUZVUkYrek1semI1eDlKTzlzQkNsZG9SdHpLWWFEWjB3bHY0?=
 =?utf-8?B?d0p4dkpwaFE2NGs2eCt6Q28xR21Hek9JNGNaTi81SWFNbWxyUGppbVg5VEVj?=
 =?utf-8?B?NklyREpHM29DL2d0Qm1sZlZOazJYUDVWaGI2VVY3UG9LS0V4Mmc4MHFaWVpv?=
 =?utf-8?B?Y0VHMVM0b0tTaU9IeWFjdHFCMHRrNUVidDFiY3BJSVl3WDdoaHQ3ZUxpZG9T?=
 =?utf-8?B?MnZDT2xRZzY2V2NnemRYVGFSRm5lL2NNQytFeEV5WkNvamZ3ZXFxTFN2VGl1?=
 =?utf-8?B?M29FUWZkb0hJOElWQkF3aUZSWFlpNml4YVhnZGQ5TEtvSGtxWFJ0KzdDeUt5?=
 =?utf-8?B?TzdGbjA5TEoxWG9xeVZ3SG5jQ0pHQ2NDbFNVR1N4Z1RBcnlTN2pnSCtPQlkr?=
 =?utf-8?B?K0RZcTI2OUh0eXVqc2ZMSzk3RnBZdUszRXlBSFVOUzg1N3pNVDViL2VqY1dY?=
 =?utf-8?B?RGN3R1JKQSthdDZxZlpLVE11V0J0TURPMmpRa3lFM2IvZytEeER0bWZENG9W?=
 =?utf-8?B?UXJCcWpGWWQ2eTFzcmcyQU9mN2dQRWtlak9LbW9IQ05vbGM0eTVKdXdmL2kv?=
 =?utf-8?B?aVpweDRjWGllUmtzTEN2NXhkaHpEa2RPN0NTVnU2TDZpZitRa2F1Q3pEVU1s?=
 =?utf-8?B?ckhjQnJOeVYza1llUlc5QThocFozckgxMFkwczJXQ3IwV250WU1KUGdaV0Ji?=
 =?utf-8?B?bXZWSWJOOGJvUEoxVGJ4RDlCUC9hWTl2VnlQTVhWSHY1QzBZMVpPU25hVkRE?=
 =?utf-8?B?QTdRbFYyZGxPaG5CMzNMeHNFMXVGN0VzVUc1RnF4M3JLNXpSeExQQStlYXVx?=
 =?utf-8?B?aWxqM1pUVFJqaWdxcURLN2VrQi8vVW5YMmpNVjZHYlNheCtRUDFoR09LRXl5?=
 =?utf-8?B?bm96cGVkSThiTmdxY1hYdU9qdmVvWUF2NnZyRHdkMEdIeGw0Z0ZVTVdVVFV1?=
 =?utf-8?B?c1IrSGk5Q1ZKUnNxUjdHUjM4U25FeU1PMHVrdVpuZHdUL0J2OUdkZDZXS3dq?=
 =?utf-8?B?NkZiV0d3V1Rid3grSmdKWFNUUGlkaWZxTEJjckRnUnVXRys0Wk1UMmRtdHgx?=
 =?utf-8?B?OFpvWHFnOTFVYW1LVTRVd0JYZ0c4djhVOEFSRjFZMHQ4cUwycnZsRDdkOFJX?=
 =?utf-8?B?U1FOOSt6V3ZnSk1Zd1UxWjUwUisvR2oxbWl5bUY5bG9GcmZRS3RQQWlBWXJu?=
 =?utf-8?B?YXFxQnNqY1dreTVmN2Y3b3lQWWY5T1dnSEhGWVdZR3c3TXpkekRDM0NyZlZT?=
 =?utf-8?B?Uzd2TzBZL0VQM2NVS1o4SXZFdmJKcXM0KzI3dlZDVDA3a2pmZlorUnJ1SmEx?=
 =?utf-8?B?MEl6VHdkUForS0FpNkxrb3o1TTlOREg2aVJlZTQrZmtUOFJ6dWtrQVU3K253?=
 =?utf-8?B?UUEweXBMb0tMOTBiL1YzRE1xUWFqWXh6MnBHa1lPRkU4dUJVMWFwQXg1ZGRD?=
 =?utf-8?Q?eUGDjHa6EzRr/7ZqoZ1994Nqk2hjJ6YpmljbBs0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ay9hQTFOcHlnc05qZmxIZTB5K3dKRlc2d01pazRYU3BFTXRaQ0dvK1BvQU5j?=
 =?utf-8?B?RlpHQWU4dHNRN09zUVQyQUJOUUxxK05sTVNkRjl4alpzeVlhNnpOZy9xVnJI?=
 =?utf-8?B?K1pkMjNLMU02YW5NdVVvNi82ZitsYk9Pb21naFpvSlRDM1JvOWVmM3RoUGhs?=
 =?utf-8?B?U2lsWFZyRTFOMEFpbHUwUnlqanZBclZiLzlPZmJsVnJhVzh0azhENVMrRFUz?=
 =?utf-8?B?OUREV1V1SStHVXRQV2U5bUhjUk1YMjBwTGJOT2ZtTEs1cTlQQ1hkSG13NVF3?=
 =?utf-8?B?MlBrczJsUS9tNXdubmxwV3JNOW15U0w0NW1nYlJhV2lYR3hnb29mN2g5ZEhO?=
 =?utf-8?B?TVVkdGlucmp3Z01qSVJkVHpXSU4xNFMxLzk1L3c0aDFaZW5CN2JuS3kwWm5O?=
 =?utf-8?B?dWdFUVFNY3Zsd1NNVis0eGo0czZ2RlVTTlVNQmQ2YURXOWRLWVQzR2Z1TDlE?=
 =?utf-8?B?UisyQnNnRVNqazFXZCt0blptV091aWZ4SCs1N2RoYk8vRXNUbzY1KzI5enYv?=
 =?utf-8?B?eGlCc090ZEpsS3lpOG85MXp2UHRwT3IyMExZVjdtRlBJVDN0S0ZYZFhhYTRx?=
 =?utf-8?B?OXVsUDJYZ2JMVmlIWExjb0VNT3Q2ZGJQOHNRK3hhWFFWNUFFY3N6UDBRblZB?=
 =?utf-8?B?ME82Nyt0TSt0bXI5MjZYaGdBRk0vS2xkcWRscVdxTnJDWFRRTTlNM0ljQkh0?=
 =?utf-8?B?ZEJNN2x3ZGdCMjE0Y2pMRm9pRkgrNUdCazR6SkdtcEdtM2FlbmZFS2tWUjlW?=
 =?utf-8?B?bzE0Rm5OMEVhN2ovMXZGK3lWNzBGZG9GSDB6L0x6OTlTUkZ6MmF3NStZMGlx?=
 =?utf-8?B?em1rRERQWnBDWDFRR2NIcHI1WHJHL2ZXbXg5UWpHdlZneXQwMFp3NmRLaFRE?=
 =?utf-8?B?eW0vei9rZ1lFdGVZTlgyQ0R4a0JuV0M5TGkvR1RkZ3NqRUR5YXp0bDdiN1ZV?=
 =?utf-8?B?b0dzVER4eTVkczZtdEU5MkVHbnU0WmR2L2FqUG5Ba1RaZUh2NU4rTWpLNFBn?=
 =?utf-8?B?a2l3QTdZTkY5ekk3RE5RRmd3ZHljSG8vZks3TzVSdWIxWW5NdzZiMmFZdk1E?=
 =?utf-8?B?aGZ1VmMrdVBtRHpNSk0rNHNTeHdzVlRXVzU1NjAxcy9oejg4ejExb2t1MkhW?=
 =?utf-8?B?TExBNE5yam1xRVhiZGg5UXZXdS9jOTdVREdRcGg5Ky9hbU1reUtPV25udkZj?=
 =?utf-8?B?ZHVSS01ocUxSL2V1bFVRTFV5ZmJPME9hODIwdi9oN3VxZlpFbHVOU0JBeXBG?=
 =?utf-8?B?ZVZ0SmZrMjJsZG1TNG1kSWF4THV5Zmlxa0dTTFJ6TldCNkJZME9kd0RJQmE1?=
 =?utf-8?B?dEx6NlFtNjRFUHZSeDNCNEZudzJMNUVmQjZqSjZ0VUsrTG1zWlh6aGVJaG9M?=
 =?utf-8?B?N2t1UE8zaFJKbnFERnFDZEVCTE5TZyt4UFJFMkROWEY0YkVPSlIrcVlxdGpR?=
 =?utf-8?B?OGtMTUo0WW1sNFE4ckduTTdjLzdZaGVsR2VYWmFMeG5veGZrVy9oTW9QNUdw?=
 =?utf-8?B?RmsyR2hQTW5aWFZmQmlqNkdwUEVoYmp3dVUxMXRUbUIvYXFCc0QvYlhCYlI1?=
 =?utf-8?B?cHpCVUhTZTc3MDNHOGJ6aWV3d0wwSHVhRmRZcGdreDFoR2tmU3NlcHNSbWJP?=
 =?utf-8?B?SXRuMWtOWTlhVXVkRW8zK01sZ3p2aUUzTWMzUFNPdkpqRTZLSEtGeGEvai80?=
 =?utf-8?B?M2N0YVhKcEhoNDlSQ2dPWVl1eTFxbnhFNnVTV2lLUGwwNlBOTkwxd3lCaldn?=
 =?utf-8?B?Nk9FaDhrN01ZRjdBU01TYWkyNzRGZUpzSEdmMnhXZm5ucUhxTk5ES0hYRFZw?=
 =?utf-8?B?Zzg2U2dabExFeUhjQk9FQ3ZHSWErOXZiczdnRUdRZnF2OFF1ZXhIbk5sWjZU?=
 =?utf-8?B?Q000Y0ora2hvTnptbGU3b21xNGZpallhOFZMRVFQNmRCNUNzVkxobEE0bHlT?=
 =?utf-8?B?cWtrQzZDbitLeG9BUEx1S01sMG9uVFAvSGVEUHNyaEM0czluYU5ZVG00YjBp?=
 =?utf-8?B?TGlpNzZyTDY1aFlucHJyWEVMQlRIRVVCSE5qUU1pWi9zVWZEWW5odThrN1h6?=
 =?utf-8?B?Unpla1R1S0MxcG5pa1ZqVW11cjJxL3FFQXB4NjFyR2FtOGRJaExacXFsWGF4?=
 =?utf-8?B?L1ZUay9sV2NqMjBsM1BvTjBNS1EwZFZ2dVJ3QllhU1NkT3JQb0QyNlZ2UUZV?=
 =?utf-8?B?NjZLTTQyWVVCMmlJVHlYaTRPV1NjZnBrenlsYWNBamZvUnppRmI0TkhtdEtX?=
 =?utf-8?B?UXltd0tUcVpUTVczVWhYNk1Gd1hnPT0=?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d84ccc-4b38-446d-c1ad-08dd58d7f0c7
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2025 15:44:23.8786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kLq9rUqFAIgBsq+GEzU7mBaIkibZxVYKor86tsVrBbCXxwdEjCCtFcG8s+HUqXe7TzQ8M1jDMvEuB0RZ4roSDn2ffPodQxPWvZgRdcwATnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8166

On 2025-02-28 17:32, Peter Xu wrote:
> On Fri, Feb 28, 2025 at 12:53:02PM -0500, Mathieu Desnoyers wrote:
>> On 2025-02-28 11:32, Peter Xu wrote:
>>> On Fri, Feb 28, 2025 at 09:59:00AM -0500, Mathieu Desnoyers wrote:
>>>> For the VM use-case, I wonder if we could just add a userfaultfd
>>>> "COW" event that would notify userspace when a COW happens ?
>>>
>>> I don't know what's the best for KSM and how well this will work, but we
>>> have such event for years..  See UFFDIO_REGISTER_MODE_WP:
>>>
>>> https://man7.org/linux/man-pages/man2/userfaultfd.2.html
>>
>> userfaultfd UFFDIO_REGISTER only seems to work if I pass an address
>> resulting from a mmap mapping, but returns EINVAL if I pass a
>> page-aligned address which sits within a private file mapping
>> (e.g. executable data).
> 
> Yes, so far sync traps only supports RAM-based file systems, or anonymous.
> Generic private file mappings (that stores executables and libraries) are
> not yet supported.

OK, this confirms my observations.

> 
>>
>> Also, I notice that do_wp_page() only calls handle_userfault
>> VM_UFFD_WP when vm_fault flags does not have FAULT_FLAG_UNSHARE
>> set.
> 
> AFAICT that's expected, unshare should only be set on reads, never writes.
> So uffd-wp shouldn't trap any of those.

I'm confused by your comment. I thought unshare only applies to
*write* faults. What am I missing ?

> 
>>
>> AFAIU, as it stands now userfaultfd would not help tracking COW faults
>> caused by stores to private file mappings. Am I missing something ?
> 
> I think you're right.  So we have UFFD_FEATURE_WP_ASYNC that should work on
> most mappings.  That one is async, though, so more like soft-dirty.  It
> might be doable to try making it sync too without a lot of changes based on
> how async tracking works.

I'll try this out. It may not matter that it's async given a use-case
use-cases of tracking the age since the WP fault on the COW pages. We
don't need to react to the event in-place to alter its behavior, just
a notification should be fine AFAIU.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

