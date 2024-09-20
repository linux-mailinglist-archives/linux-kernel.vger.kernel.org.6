Return-Path: <linux-kernel+bounces-334700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C245997DACD
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 01:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 283FF2818E9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 23:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42ED18D647;
	Fri, 20 Sep 2024 23:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zB5T95Bz"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C5414BF89
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 23:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726875286; cv=fail; b=qNrA+OyVazeb6JePNIM7D3CIJucyb9bq2YgtM1qrqMwfrt1H+vZvbqIlbkFvztNs2P8CwzYYvnUJqIznE73bw0sgEELhdFplLKKqef7Z8Q2zqpQu9L9q6XeUwQC0xZSumhXPQfy/feUu+th1BNwxjL7ksliHQ5htehZm4cZUJD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726875286; c=relaxed/simple;
	bh=weOGceC249ws1pd7kVYFI/jI5w/Ey5eY4q0T1UM2iZ4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=St+HHTh+pOvYZ/CG/6OIV5Rsbwh8w66qBlIkpF4TnQuMQN5ad8l0H78Vm9A1METG2aT3kFUDUaMFhBOmwvlJJBJzX8cxUlEb+VOC3S76maLa/vGgY+NCdYnjhscTix+nlM5LPNt4bcMdaEc6Bw6z/4WgRIwMEtoy9lZJrCin74k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zB5T95Bz; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DEEwHvDqtSC0AE1xbss53txLscU/rNm53pg5IbF4oP+im7FXYnh/1LK8hNi92chwCRjN+FmDPbhTEvwdlrdFEYmnSuypdjHlwF2lCeyqUwNWPVd8KWIdDEmMJzhtC62SO+uL9QVn5hjIih0rbmT7VNTTIyK6qoIbLq86RChSGEegBIRmycNmfRZqkVh4XYonWTp+uT6yxvVNEH35HImSHiarsx1rLOeFUItxXXEab9SePSXqlc0re8C27mcHLtHbZSCQ/NgIgCAFT6JzUOIZrB+dOmAKpY7GwSf7dwcBZMzK788vkSnwYdQzy7qr9/kRJsqsLOBNQDYZg6JB5rpQxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDGEOCvgNtezRsLPj/1FOXT11S7wdmg4D0D56+41z48=;
 b=Qv3AGysMiI/IQKaJmvF74/JvagGOw7U6Zx/EleKdEyD7NXYHV/1Lmr1P41MphSV6/JuYwBh9UxoUUarRhS8+Bln3fz9O/nYahl8XJVDHJ0/3QKxv2lI3LPa0DnsI0n/q66Ti0zOWC5A/gQhWcZcXtm26VSLrZKXCBOifBFOgcrEyrZ00Cs0s54URS607ah4Y3kp0qK4n82QLWqgyFbVj4Y2XXdc4NQCR7KOCQPp+f3Zd+oHS0E8JeJ1pcPTH4ziReHKPFtr39ysoD4I2Pg9xowlKPdO5RcDhKIvSWChuCSi4nbjzrO7qZDz0wXqWqFd15nhQwlVduaBvHGh1sYnbsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDGEOCvgNtezRsLPj/1FOXT11S7wdmg4D0D56+41z48=;
 b=zB5T95BzyUhuaNoYtu2olqAViAsYc54spLljVzpfUUATEXQ3XTKEOVo3od1w1KpWRhmjHZfonffE4FbtXdW2C0lE5Y6jTsnCXyNMxpv+1XtjB0fH6NrqHbTN9DsEcOpOY4FYfy5CTXTfyRMfwpawC2eVt36RE3cYVxFi9DlVrTI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8495.namprd12.prod.outlook.com (2603:10b6:208:44d::9)
 by SJ0PR12MB5662.namprd12.prod.outlook.com (2603:10b6:a03:429::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Fri, 20 Sep
 2024 23:34:40 +0000
Received: from IA1PR12MB8495.namprd12.prod.outlook.com
 ([fe80::97d3:87e9:1c4c:c692]) by IA1PR12MB8495.namprd12.prod.outlook.com
 ([fe80::97d3:87e9:1c4c:c692%6]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 23:34:40 +0000
Message-ID: <1ab1991a-382f-4b59-9e07-76a696159631@amd.com>
Date: Fri, 20 Sep 2024 17:34:36 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Re: AMDGPU 6.11.0 crash, 6.10.0 git bisect log
To: "Dr. David Alan Gilbert" <linux@treblig.org>, Bob Gill
 <gillb5@telus.net>, alexander.deucher@amd.com
Cc: linux-kernel@vger.kernel.org, regressions@lists.linux.dev
References: <c21b734a-1d3d-4286-a3c5-a6ae9b69d847@telus.net>
 <Zu3-nJ7LpVzoN5Bj@gallifrey>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <Zu3-nJ7LpVzoN5Bj@gallifrey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0106.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::42) To IA1PR12MB8495.namprd12.prod.outlook.com
 (2603:10b6:208:44d::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8495:EE_|SJ0PR12MB5662:EE_
X-MS-Office365-Filtering-Correlation-Id: 136ceb51-885c-46fb-fd96-08dcd9cccc11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1haOC9wSld6QjFpTytFWHRTclU2bnFKUjY0YzBnbkpkcFZjZThtVHdiVzAr?=
 =?utf-8?B?TkZaMVhYVXFpRklaelByTnl5RFNqMzFpaGVtSTZqT21obWVidmNyNko4aFFx?=
 =?utf-8?B?a0R5RVFLRDNja1NUSnlGMEZ0anNRaXFJSDNTZWd3MlBROGkvaUdjKzloM2Vn?=
 =?utf-8?B?OGQrNUlvMTcvVFdDd0JRTEk0VkdEQytCcEhvREJCZy96ajluYjJJQWJqK2do?=
 =?utf-8?B?NnlkbUJJUVdLSmZ5aGpZY0p0N0NwTUFNaXFiY2JUdXdHWkd6dmhwblJ5RUdi?=
 =?utf-8?B?cEw2eFczdFdIUnpuM2R3WW8zd1F0UytNdDMzcHZzRFZaK250eHZXZGRlK2VJ?=
 =?utf-8?B?b1dYRGUySGc0T1hEKytSQUlaSGdtRUUrU1FEOUdTRnNSWVJ5NFNNcW5raGtL?=
 =?utf-8?B?VWp5MFNHUzFFWlVKQTdIQVRMWDdYQU9YZXNlV3NFVHRDVUhBSjdCTStjNU54?=
 =?utf-8?B?UkdGVDE1R1VHTlhlSUE3UnFlU0svU1RTaUhlRkxacXNWYnFXdGxQR3Btb05C?=
 =?utf-8?B?dWxuUkVBQlV3dVhLMWtlekdoNjVMRmVmZnluUnhZOEVMVnZ0SzU3MXg5VFBm?=
 =?utf-8?B?b1RJTFh3NTVjNGVZUllucFJBSzV6Sy9PbWZIeTNMOFFQd0JnWkZ1U1VSV2tY?=
 =?utf-8?B?K2pPMHFvR0VGMFhLMmRuNHRxM2lpc3AwVGtNNFYyRklIVTRqWDJXMU0zQ25I?=
 =?utf-8?B?OExaN1JDQUMwQ29iYlUrM25nTWZocU00WDNPc2lWRnpIejl5VDFIMWs3dGFO?=
 =?utf-8?B?dG1ndDBXcERmcWZrYVhicTVXWGkwU0JJN2VlaldqTTltUVJmTkVyeHBFbEhQ?=
 =?utf-8?B?Uy92dXB6TTRRWktnc3ZaOGR6c0w2VlZoZDA2My9xWlpMWlJGSTFPUWJxY1Zi?=
 =?utf-8?B?OStnVFltcVlySHNSMHVlck9WNWVqSkpqZXltdTVGWjB0emxjQXdZbDV6U2Fr?=
 =?utf-8?B?Rmx2QzhKendIa3QzejNlWndpb0gyc3N3VUJKNEJ3TUZMQ2Q2Rk56aFN1YVFH?=
 =?utf-8?B?VGRobXNDR1UwbENPVmV1ZEF3aXJ6cnFSQ1V5UzZKbUl1S3l1YWNkaU1ucy95?=
 =?utf-8?B?VW1UY2p0S1ZRaXhnUmRQK0RKRWpEOUk0TzZvTTFza3ZtaytUdGxDb3ZKODNZ?=
 =?utf-8?B?QWUrd1QyU1lQbkFhUlpsRTlBY0w0S0xiTTBnZHd4eVNMNjNZZEo2alUyVTlz?=
 =?utf-8?B?M2c0OE9UWmMxbjhrZysyQ0M4Q1ozL3N6S2dHUHY4UGxqNTVaMlh1a0cwMGll?=
 =?utf-8?B?S05nbHVqdFBYMEZhMVA4NGIwL1lCRG1FSEVZbkhPL3U4WnU2aXhweGUrNlNt?=
 =?utf-8?B?OWtlWjJqZzZmc1l0dldERVJuYTZTQ05TZmxNSUVRZjR6bFdod081NVMyQzJm?=
 =?utf-8?B?K1NibEh6VTdjWHNLQjE5WjZTOHF3U1VkM0JBY3YvK2NILzBMK0plby91cUlK?=
 =?utf-8?B?WThRS1A4aEt2WjZjMW5SSkVDL2o1K0ZnZ2lZQUZiZjVkUXY5QXphSlFseEVu?=
 =?utf-8?B?dlNBTkw1dFY3VDBxMHkvNFBDb0FmWmpuTFl1a0owR0NRSVZ0TUVaZElsUzdL?=
 =?utf-8?B?OXp5U0dMMW5yWEpBMEt2OGVpT2JVemtFK0FLbjV5cUwxbnpLcU12bTZkakVX?=
 =?utf-8?B?aHVuNlpiWWRGRkJ0RTVhRVFvS3MvbWp2bjFaVkVWV2ZEWE9QNWdyUnlzMTZ5?=
 =?utf-8?B?Y2F6VDRvNWY1Zi80Tk5CVWdnbHVLaWxaVVRqOExhNmVmWTEwd21JRVNuUUlI?=
 =?utf-8?Q?URAFWumzHB1LwmoSao=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB8495.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0dQUFhJMUpaTmZSbktHMVVzOFhaY2Nyd0VrQ2d5V1UwSXdiZjQxaW0xSHNC?=
 =?utf-8?B?b3Z0a0orTXJCb2VkTS9JalpnTmZIOXllcDgxQ3NQYUUwWEJvSEZSVzhwQWg2?=
 =?utf-8?B?NVAvSUkxL0xmbWdTZFR3NDZXVERuY20yREhyaTd5ZWxhY0txY1lWbzh1UFM3?=
 =?utf-8?B?UlkyZG9STFAyYW1LaDV5TEo4ZUVhby9ySWJTRlRtcStDRmZBaUZ4WEk2MUxk?=
 =?utf-8?B?a3BpV1VmNkl4K1pIaU5QOXdpazdZNTVWZjF3V21SU2VHTlhXRGxRQ21NNjVv?=
 =?utf-8?B?UEVLa3RkVDk2MllsVkJUS213aENnSlBMS0cwdGFoa0ZrWSszSzJPdGZsRTc3?=
 =?utf-8?B?ZWhnK2Jzc21vdktMQXlIMHpYUVkreWZwK25Jc2I5VS9KcFlqVG5lb1pxQy9h?=
 =?utf-8?B?SEFaSkNYa0Zna0EwTGZJMXIrVFZaSXoybjgvN3dWUmhpQ1VQd0RDQ0w0Y0t5?=
 =?utf-8?B?RzFPd2RkbW9QNXZqZU1ocERZUWpjYzRqKzBRR1RtdEFvRkFiLytCRCt0ODh0?=
 =?utf-8?B?dlN1dFY1YnBRUzcyKytBb01pK0tHSGQyNWN4S0lZam9Ia0NlS2dDdC81eCtQ?=
 =?utf-8?B?ZUpSalZzay9Sci94T0FUTnpQNUtJYnhDSE5CWUV6ZFhXaDFESHp2T0YrRk9Y?=
 =?utf-8?B?amYvNjhOVk5VeG40engwNWtheXlFbHdmWW1MQW95MlprR0NVTTIvZC9WN0FC?=
 =?utf-8?B?dWdIWkxiZWh3SS9LQTVpOWRlMVJVcXNYdHZDbGtJd2dkQVdpb0JNcWdqR2Fl?=
 =?utf-8?B?Q0dWbDczcElnTG1iL0RlSTVNSUkvQXQ4ZjFkN0cvdStEV1kvZzBsSjk2cXRN?=
 =?utf-8?B?VFNPUHJiT1N5KzhrL05sNU10ZkFERXFybFltZ1FWVm13Y2hXb1VoWGhKNURz?=
 =?utf-8?B?cnlGVkNDSE8yODZhNUpNd1NrZjBCMFhLalp4Z0RiQTBxL2dzOHJIN2I2cXBy?=
 =?utf-8?B?ZGZFTW1RaXplRlFjekhzOWlrdUx3WGtNMVp3NGhNU2VaaVlYNTRoa2VvSDZr?=
 =?utf-8?B?M3FCVGNLM0pLb0lCcS9YMGxJemlWUURlMnVpR09oT1JYQ2FLY003c0lkMEVs?=
 =?utf-8?B?TlNtQ1pDT29ReGNhWUhKL3JRQk9QNE9hNmpHVnlaaVZYNzZubEJWbWx6NEdN?=
 =?utf-8?B?S0M1RFUydGdibnAxVzUwaXYvZmV5UHlWQnZYd3haR0RzM1BMdThVTG5EV21X?=
 =?utf-8?B?MWVaS1J1V2hGbVZEc2R2M0tmV3VlcEZXeUo0L1dlWDBvb2NLOFNVcS81V3lv?=
 =?utf-8?B?cWN5NStxSFViL1QvR3UzTkxSR0FlRWpkUkhSWmNRL1o2K2ZGOVhtV0YzWm13?=
 =?utf-8?B?czZSUlJEb3FMbHgvNlV3UVBFSFF4bllHTWpudldPME1leWZTa1AzZnBHMGxt?=
 =?utf-8?B?WDVnaUVMVjFYeTYyYWZvcWEyVFdpQkovU3FGVi96Qkl2T1FFZDBabEI5WjFX?=
 =?utf-8?B?WURyVVpRRjFDVmtRVk1jTXpSZ2M3eDk5UXBVWHRkSHdtS3IwNS9GaDZubFJ5?=
 =?utf-8?B?d0xmeVFsMnk5OGFIUXVYMzgwekdIWm9weFIydlQ2ZVZkMVdpb0t2dmlSNGEr?=
 =?utf-8?B?ekEzeUsvMDd6cmc3UW1USUNSUy9ENitmNC9OWmhWdDJOUlBIeEZvaFl3dEZT?=
 =?utf-8?B?d3VkSGhMSnRHRHpHTmtnNlVxSjdra3hGTm1Zd01HNXZUQy8wdXRuR2x0WHNz?=
 =?utf-8?B?Y2JhSHlBclh6eHVXcE50TVREOHJ0bzJKbG1HNmNQNkFTbkFkdS9WZENtZkhy?=
 =?utf-8?B?c0VEMkRhSE1mdURNRkN2TGh3MW9rcFVFWFB4NkJHSXdLZk5DeDltU1BGUjg3?=
 =?utf-8?B?SURuM3VFKzNLYUtPUlFvcklRbjRqTjFaVEwzVllWekJyS2pUM1VsYXZpb0lw?=
 =?utf-8?B?WG9kYjNnd3hRTVRrdDdTTGYxVFNHTTlUQ3VUZjY4R0VYODIwckhPWnR3MEFN?=
 =?utf-8?B?OGswVzQ3V29tWERBUUtsU25URTh3cmVySzFmOHdBMG0yakxEeC9vNXB3clN0?=
 =?utf-8?B?SEl0U2gwUEdLQ1JITkE1cDB0d09WZTZJQVZTK3JML1hpd1EzaGdaaE5YNFlY?=
 =?utf-8?B?aVBvcUlOUTVpQjFIa05peCsvQXpRbHNxUHRYY1RKWHpQZVMxcmlYQlVZR05E?=
 =?utf-8?Q?Bi4Eyhv5JgThKj2yOHNO+9aoK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 136ceb51-885c-46fb-fd96-08dcd9cccc11
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8495.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 23:34:40.1260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8LavSOF617lEs81sOScAmzjJz6ARU5+ogVvk9ULlSaR/cTeFBr0t45kIxe5RlnFjaf2xyDQh5ynvVCJofy6bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5662



On 2024-09-20 17:00, Dr. David Alan Gilbert wrote:
> * Bob Gill (gillb5@telus.net) wrote:
>> Hello.  Kernel 6.11.0 crashes.  6.10.0 builds.  Al Viro and Dr. David Alan
>> Gilbert have been helpful, and asked that I
>>
>> post a git bisect log.  The last log step seems odd, but the second last
>> step "Remove useless function call" might be what broke.
> 
> Thank you for doing this!
> 
> My reading is that's fine, I think the next one:
> 
> tree: git bisect bad
> [a171cce57792b0a6206d532050179a381ad74f8f] drm/amd/display: Check and log for
> function error codes
> 
> or the one after it is the culprit?
> 
> Adding the two Alex's from AMD back onto the thread.
> (Also added the [REGRESSION] marker the notes tell us to add)

The commit triggers debugger in case of in case of errors.

Is the config CONFIG_DEBUG_KERNEL_DC (Enable kgdb break in DC) enabled 
in .config, i.e. can you check "grep CONFIG_DEBUG_KERNEL_DC .config"?

If so, can you also try to disable it and check whether you can see 
error messages "Failed to execute VBIOS command table" in kernel log?

> 
>> My hardware is old corei7 quad core/8 thread Tylersberg/Nehalem with an AMD
>> RX 6500XT.  That's the odd combination.
>>
>> Thanks in advance,
> 
> Thanks again for the bisect.
> 
> Dave
> 
>> Bob
>>
>> Config:  (.config)
>> /data/kernel/bobtest6.10-64
>>
>> Build line: (last command tells me the job is finished)
>> make menuconfig && make -j $(nproc) && make modules && make modules_install
>> && make install && /data/music/pl.sh
>>
>> Rule 1: Do not modify ANYTHING in the source tree
>>
>> git bisect start
>> git bisect bad
>> git bisect good v6.10
>>
>> Bisecting: 11273 revisions left to test after this (roughly 14 steps)
>> [2c9b3512402ed192d1f43f4531fb5da947e72bd0] Merge tag 'for-linus' of
>> git://git.kernel.org/pub/scm/virt/kvm/kvm
>>
>> latest kernel:
>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>> 6.10.0+
>>
>> RESULT:  boot 6.10.0+ fails
>>           screen black for more than 2 minutes,
>>           (caps lock key unresponsive, reset, power
>>           buttons on computer case do nothing).  Reset with power bar.
>>
>> tree: git bisect bad
>> Bisecting: 5677 revisions left to test after this (roughly 13 steps)
>> [280e36f0d5b997173d014c07484c03a7f7750668] nsfs: use cleanup guard
>>
>> latest kernel:
>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>> 6.10.0+
>>
>> RESULT: boot 6.10.0+ successful
>> tree: git bisect good
>> Bisecting: 2855 revisions left to test after this (roughly 12 steps)
>> [dde1a0e1625c08cf4f958348a83434b2ddecf449] Merge tag 'x86-percpu-2024-07-17'
>> of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>
>> latest kernel:
>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>> 6.10.0+
>>
>> RESULT: boot 6.10.0+ fails
>>          screen black for more than 2 minutes,
>>          (caps lock key unresponsive, reset, power
>>          buttons on computer case do nothing).  Reset with power bar.
>>
>> tree: git bisect bad
>> Bisecting: 1478 revisions left to test after this (roughly 11 steps)
>> [32a120f52a4c0121bca8f2328d4680d283693d60] drm/i915/mtl: Skip PLL state
>> verification in TBT mode
>>
>> latest kernel:
>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>> 6.10.0-rc3+
>>
>> RESULT: boot 6.10.0-rc3+ successful
>> tree: git bisect good
>> Bisecting: 739 revisions left to test after this (roughly 10 steps)
>> [b6a343df46d69070a7073405e470e6348180ea34] drm/amdgpu: initialize GC IP
>> v11.5.2
>>
>> latest kernel:
>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>> 6.10.0-rc3+
>>
>> RESULT: boot 6.10.0-rc3+ fails
>>          screen black for more than 2 minutes,
>>          (caps lock key unresponsive, reset, power
>>          buttons on computer case do nothing).  Reset with power bar.
>>
>> tree: git bisect bad
>> Bisecting: 369 revisions left to test after this (roughly 9 steps)
>> [cf1d06ac53a15b83c0a63225606cfe175e33a8a0] accel/ivpu: Increase autosuspend
>> delay to 100ms on 40xx
>>
>> latest kernel:
>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>> 6.10.0-rc1+
>>
>> RESULT: boot 6.10.0-rc1+ successful
>> tree: git bisect good
>> Bisecting: 184 revisions left to test after this (roughly 8 steps)
>> [0ca9f757a0e27a076395ec1b2002661bcf5c25e8] drm/amd/pm: powerplay: Add
>> `__counted_by` attribute for flexible arrays
>>
>> latest kernel:
>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>> 6.9.0-rc5+
>>
>> RESULT: boot 6.9.0-rc5+ successful
>> tree: git bisect good
>> Bisecting: 92 revisions left to test after this (roughly 7 steps)
>> [9862ef7bae47b9292a38a0a1b30bff7f56d7815b] drm/amd/display: Use periodic
>> detection for ipx/headless
>>
>> latest kernel:
>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>> 6.10.0-rc3+
>>
>> RESULT: boot 6.10.0-rc3+ fails
>>          screen black for more than 2 minutes,
>>          (caps lock key unresponsive, reset, power
>>          buttons on computer case do nothing).  Reset with power bar.
>>
>> tree: git bisect bad
>> Bisecting: 44 revisions left to test after this (roughly 6 steps)
>> [a78313bb206e0c456a989f380c4cbd8af8af7c76] Merge tag
>> 'drm-intel-gt-next-2024-06-12' of
>> https://gitlab.freedesktop.org/drm/i915/kernel into drm-next
>>
>> latest kernel:
>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>> 6.10.0-rc3+
>>
>> RESULT: boot 6.10.0-rc3+ successful
>> tree: git bisect good
>> Bisecting: 22 revisions left to test after this (roughly 5 steps)
>> [51dbe0239b1fc7c435867ce28e5eb4394b6641e1] drm/amd/display: Fix cursor size
>> issues
>>
>> latest kernel:
>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>> 6.10.0-rc3+
>>
>> RESULT: boot 6.10.0-rc3+ successful
>> tree: git bisect good
>> Bisecting: 11 revisions left to test after this (roughly 4 steps)
>> [871512e36f9c1c2cb4e62eb860ca0438800e4d63] drm/amd/display: Add workaround
>> to restrict max frac urgent for DPM0
>>
>> latest kernel:
>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>> 6.10.0-rc3+
>>
>> RESULT: boot 6.10.0-rc3+ fails
>>          screen black for more than 2 minutes,
>>          (caps lock key unresponsive, reset, power
>>          buttons on computer case do nothing).  Reset with power bar.
>>
>> tree: git bisect bad
>> Bisecting: 5 revisions left to test after this (roughly 3 steps)
>> [5d93060d430b359e16e7c555c8f151ead1ac614b] drm/amd/display: Check HDCP
>> returned status
>>
>> latest kernel:
>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>> 6.10.0-rc3+
>>
>> RESULT: boot 6.10.0-rc3+ fails
>>          screen black for more than 2 minutes,
>>          (caps lock key unresponsive, reset, power
>>          buttons on computer case do nothing).  Reset with power bar.
>>
>> tree: git bisect bad
>> Bisecting: 2 revisions left to test after this (roughly 1 step)
>> [e094992bd1caa1fbd42221c7c305fc3b54172b5c] drm/amd/display: Remove useless
>> function call
>>
>> latest kernel:
>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>> 6.10.0-rc3+
>>
>> RESULT: boot 6.10.0-rc3+ successful
>>
>> tree: git bisect good
>> [2c2ee1d1329881d8e6bb23c3b9f3b41df8a8055c] drm/amd/display: Check and log
>> for function error codes
>>
>> latest kernel:
>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>> 6.10.0-rc3+
>>
>> RESULT: boot 6.10.0-rc3+ fails
>>          screen black for more than 2 minutes,
>>          (caps lock key unresponsive, reset, power
>>          buttons on computer case do nothing).  Reset with power bar.
>>
>> tree: git bisect bad
>> [a171cce57792b0a6206d532050179a381ad74f8f] drm/amd/display: Check and log
>> for function error codes
>>
>>
>>
>>
>>
>>

