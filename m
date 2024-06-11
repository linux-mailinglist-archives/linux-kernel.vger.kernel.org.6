Return-Path: <linux-kernel+bounces-209223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A919902F29
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 05:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D49981F22DD6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 03:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C076516F900;
	Tue, 11 Jun 2024 03:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="PPlyre+L"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2076.outbound.protection.outlook.com [40.107.117.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54B913DDCC
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 03:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718077000; cv=fail; b=OV7X5chfkSkpTjLK7oV39hMzvee0mXma/hY/tD5DbEi+wa0bgsdpVOi6Q2NSxiBtTLvnnrgwTAltML3h1bA8RBG9xypjBt9siVkt89H4UqHxYdZg2vR0k+tUlo3XZPk5WbXDZWZ8WWSEqd0c8MqRraKVx9TgPKUd4obz2h7+qCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718077000; c=relaxed/simple;
	bh=lpGC73spCwB+93668Mnb3o2awbF84xIbiOKJpAnrMBI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D7Qc+MKmmURBQ6Qy7Z9OTzJq0a2ttBgF6IWtm/B6yOYZwAxZkGP6hJPb6s1tnhMFpgfoQ47tgrWZTeqR5h+e/Tmu9wNEEUJ/xQb3/9l5Exfz0aAt8sebieFk42QE01x3e4Vfavks8F9hVHxT+Egk+J+lLNhRhv4GAsLENZmlUKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=PPlyre+L; arc=fail smtp.client-ip=40.107.117.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3ABcw/jjy7l5plYoIz731PNoll6EDY3kCXE2GRYYCA7FNBDbIHCYXCyDtjFPXks5nd2lB9a6Cfk0wz5b9pWmVUHJlTxoOzKz5++bJtVet8Di5tJpirkcNNZoJ/T68+1dkqv5CcqiGgOkwGG5bXOlWpkvMhY3ZhatR1fT+Hybx8AbQpKzRTF7yiLVWdT7JM0g/i0OtpA9aR6OHMVJoz/eSpJ88zwOOEy/cSOSbF35WcaXhYfqQTQ1Y2xMtSiiIa8WyXrAGLvBzWRG/olO/XyAM3tJEpIv34UzvsvJBr0qHC12ta4JKaLo43g5uDaMgXJ238edElm9D/fTXg6cUjEyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cm3oFGg6b5uoACMalCY4UqxfFBdPTxr7JsfJa2HJCwk=;
 b=JqU7p4T7ehDcVnAONJNzNC26UeIEjqdmKrEAidwC8BXbWnPgEdicrMh1eJ13dWvgVzQTcCUL6jBW38n1BiTOZfA4AfgW1eUoUPWJliliDnaAtKXTxan0PFi/KoUhVcZhCc1PCpfLAbmDOQG9bH2xy6kPzukod6Yi4vCpxgb79eArlFCuGXmUu4lVXtFH1cY9U275JSdJRYt7tc5BNbe4Vki2Qpf49oDAj5VebWzUgiqwrhE6y/QKfHUzFa5Xr6ZDQuoPs/tLvxHn4pUW3CoUKNG7p0S9RT3pgpPREi1uXI9d2eQgY8fHEweclVw4qjhAdlwHhL9ol47C1jtW3DmzEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cm3oFGg6b5uoACMalCY4UqxfFBdPTxr7JsfJa2HJCwk=;
 b=PPlyre+Lq6SwMvE/gWeeEuMBw/FhM7Mdjf8Xl/AWVjf/SJ9AL6BW7tdqEW3ic7kzlot13Ngt7ZSn//KGhVjRfmoS74jGUe79ic6+YULSXd+GPtwKQleCja32Tt1MrBg8qUcca6sZFga/6Pu01oBiUkDlPkMKiGKmfgm84fzOz1U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SEYPR02MB8152.apcprd02.prod.outlook.com (2603:1096:101:206::6)
 by SEYPR02MB6268.apcprd02.prod.outlook.com (2603:1096:101:d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 03:36:35 +0000
Received: from SEYPR02MB8152.apcprd02.prod.outlook.com
 ([fe80::6bae:c194:2032:70d7]) by SEYPR02MB8152.apcprd02.prod.outlook.com
 ([fe80::6bae:c194:2032:70d7%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 03:36:35 +0000
Message-ID: <f35822e5-48f3-4b47-bef9-ad17f5e61359@oppo.com>
Date: Tue, 11 Jun 2024 11:36:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH_V2] sched/fair: updates weight of cfs_rq before
 update_cfs_group() in enqueue_entity()
To: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org
References: <20240603091805.858-1-pugaowei@oppo.com>
From: Gaowei Pu <pugaowei@oppo.com>
In-Reply-To: <20240603091805.858-1-pugaowei@oppo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0213.apcprd04.prod.outlook.com
 (2603:1096:4:187::11) To SEYPR02MB8152.apcprd02.prod.outlook.com
 (2603:1096:101:206::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR02MB8152:EE_|SEYPR02MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e8a59a4-0ee8-473d-4845-08dc89c7b1f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|366007|7416005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2RweXk4Ukw1REFoREpmeUFuY09YakY5b2VLRUZGRHc2bG5rUEFCTWJLbU5n?=
 =?utf-8?B?cndJTlVROG15VUlEdUtWQzVnUHM4cEpZZFlMVmdtRGwzTGlUTzQ0TzRSZ1ZR?=
 =?utf-8?B?YVNieDBHV1dXZ3duZkY1T1JxREVicWY5OWVVMzhwUDFTRzZtRkFIZ25JWHNz?=
 =?utf-8?B?RC9FNGtFN2dnZktBdHg0V3ZmR1JTSngrNitMTEtFeUpsUGNiWDlPc3luZTZO?=
 =?utf-8?B?blVacS9Kd1NuSU1kTGd0UVZUUVFvVEwvQmdWODkzKzBJNWtTZDYrd21Vd0Fi?=
 =?utf-8?B?NjUyTENyT1E5QmxaUi9XTUIxSHJTYmZIQXRWTC9kVU9FVXZOU25iQmZtcjVW?=
 =?utf-8?B?anlka1NQbE1PUlBNclJURDlvU1U1d1l1S1JzSXMxUHFUeUNZMzk0ZFRIbGhZ?=
 =?utf-8?B?RCs2dHBkQmFKSjk1akNyRVFXM0ZNRGlqZ1BYYkkxMTcvTzdRamt3RlFGYVhm?=
 =?utf-8?B?cXM5dUFzaVR6VjJYSElYeE9EckUxcXpuTnlrRXQyUkdJUmxnbjRmNEM5Q1dN?=
 =?utf-8?B?YWdmYnRCemhKRUowd25iK0trR3hxV3NVaDYvdHV0Z3pNYmUzbUdsUlJnRXN1?=
 =?utf-8?B?ZURQUlNXd1dLc01BaEtwQnFncHhtRmRZTkF5SEtGU1k3WDl6aWM4M0xGaHhY?=
 =?utf-8?B?ekdWaFRFSTZ2QTZ1U2wwYmdSbEhzamZSdWNYdFJLcFNIUlkvUTRFZFdNWCtE?=
 =?utf-8?B?cXpaNmZvWnN5cDRuTDJpMEZ0WDUyelFwWTJaZE1MSVp2VWNDdWxqUk85V21N?=
 =?utf-8?B?NGYxSjJkN20rajI2cEVVNjZoWFBwOXhjV0k1azBZL0FDVVRWem1FeUU0dkhr?=
 =?utf-8?B?SkMwZDZzdlI2NExzd21OTW0zdkxhMHllMy9ub204bGJBK3U3TW94NDVHYVZO?=
 =?utf-8?B?ZHRNMDIvcStvMlhjWVdCSTRHbGdSTzE1QStCRUE1LzdsampHOE9PUldieXU5?=
 =?utf-8?B?R1V2RTU4bXB0bUJjWE02cm1Jc2FRWCtWZ1dhRmpyL09mRTZHVWQrRXhxUmVR?=
 =?utf-8?B?U2ViSjhaaDlRK2RxRzJGdUR5ZFkwQ1VTb3JpMmxvUWdKUUgvdG5UMUgrdEp6?=
 =?utf-8?B?dzUraFRxWWRVd0VXYzhPK1B2RWRsVW10TEYvQjY2K0t1QWJxZkg0T2sydjU0?=
 =?utf-8?B?QmNpMENLK21FcUE3T2V2clFnZmE2ZTkxTWtBVGdJR2dZUUprdm9VeWVnOXBi?=
 =?utf-8?B?Q0FlWi9oS1BhbTBIa05NWU5YVmc3UStxb0xNT2xuQnhLWEQrNHZNcUhvRG4v?=
 =?utf-8?B?TXpXNFdnRUs5aENiVzFXVE45Z0tQN205WXpKd3laamJIUmRFb050YzBoVi9C?=
 =?utf-8?B?WmRlV0NnQUFSQ1RrWTRRM3dIOWZ4bk1oN0s3SnhhdFR6bXQ0dnJiTklNNFBO?=
 =?utf-8?B?RWt3eFYzUzNEL25tMlVMNUFzMDcwUHB4M3dVaWJzNE1FNDZDL2pqM0lWTkUz?=
 =?utf-8?B?Q3BZY2JaT1JCc09SbmwxWXZuUHpRSnI4V0NraTAzZzN4WnJYRlZRNWdrWXlK?=
 =?utf-8?B?dUpTeDNydVNadW5LUjROTkgvU2s2dkVQeUhDR1V5bzg3ajdsVGF0QzJ1cXE2?=
 =?utf-8?B?UTYxN1Vta0p5d0QrNmc5WGNJZDAvVmxqUGRJcGpUcmcrLy9VR1lITVhwZkN0?=
 =?utf-8?B?ODhydzJtemJKeVJra3JrbFU3eXo0c1NNU2NDWDd6dk8xa0VBRFNSTm9Wb0Rj?=
 =?utf-8?B?TDA1d3FVaWdkSzl2Zjd1bVEzamdjVkF1Q3hPL3E0cDdGR0pvckZuN2N3SHUz?=
 =?utf-8?Q?qWrjER0uBN9VAnr2Nc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR02MB8152.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmM2RlJQNVB0anBrc24xaDVXK1ZRdGtMNjQvOE1nbVVQSHVKbEhGTlA1WFZi?=
 =?utf-8?B?dWdrNExaVEJ5YVprcGpkVDhvT2RtekQ1Nk56dlVjenVNbmxOaDMwc2FYbFpG?=
 =?utf-8?B?aW41UnR0WGlpSlprYVloa3c4cndRQVBxSDRKSTRCWVIwV2hUMTQ1SHhTMEhv?=
 =?utf-8?B?b3BRWDF3NVk3aERCUWxORGpuR1pCZDh2MnFvV2V1b0JCdk5QMklDRHNNN2ZI?=
 =?utf-8?B?S29FL2J1cmwybEg3ZzNraTZ4ZGJieGxWeXJiNGVhMDhOY3FNeDFBbzdXZjN3?=
 =?utf-8?B?T3RIUkNUczV6SlU0bkZBT3JHSGRXS2kwZEZ4U1dpUzRneDdzbC9ObnVORmtv?=
 =?utf-8?B?V3hMMTZqTnU1U3BHMmxmQjlOenB5VWZIU2hraThDSHpsZlREN1hYMnJyR3I0?=
 =?utf-8?B?VnQ0bStCSTkwdjFNU240QyttUnBQREZ4c2xadkdGU2ZFOGg0bEkrQ2ZubWNj?=
 =?utf-8?B?dHVyN1ZJakFKamRTTzJ5Nzl1eXlEZTRkQ3hKVFQzczRPbWt0MVdCT2RPWEox?=
 =?utf-8?B?dHprSVB1SkM0Nzdnek9yaDl6QUdoNGpwODZVazlMY2s2M2k4cDRNVHZ1a3N0?=
 =?utf-8?B?REE3YVc5TDlUcFdWNEtTMThURmdZbkNZUnQrTFFWUU1ZMlRwbThaNmp5Z1do?=
 =?utf-8?B?YXNDcWtIeWhBYUEzaHBZMVVkQkhTODB1cTVnQUVUUXlZck5PUTJLaVdwemFX?=
 =?utf-8?B?elhMaWNWVTJadnN6cG5tMEdpb0EyTGZ6dWM1cDhjVGVpdFJjTVkrREk2d3FS?=
 =?utf-8?B?YzZXUHZRcDZvaTJhOS9xdzRXcm0zZ0R6VmhwNXRaakc5VGcrWGNQcXp2Rk1Q?=
 =?utf-8?B?MUUzelRzQkFuSEZDQm13MHdtbTRhQVJWVDBnakpENHRlNnFobjhzeVI3UXZw?=
 =?utf-8?B?bC9QVElpM2R2ejVVLy9HaHVOaUcycWR0R24rLzZTRk5TaWsySVlJUU5zdVpO?=
 =?utf-8?B?d0NJc3BvalBiclhGZkNBVUtMaTlHL3VMU0czN3d3ekhWZWlTTkRqMXFBM2dZ?=
 =?utf-8?B?RUk5TDBNMDQwV2g3UXc4SWFtVmZLUVRnTXkrWXNDamhEUXN1NWRvL0xzZFRS?=
 =?utf-8?B?cUlqL3dKRVNkNERUT3VkQzBHZjROaFpwQm10c1VQNWUzUEg1eVNrWHZwMGl4?=
 =?utf-8?B?Mi8yWEgrNXRXWEROUGhhVmdWelNGRlNQZWJLUStaa1Y0UDRXZURzNDdVaTZi?=
 =?utf-8?B?blhJeHNydFlmNlNzZHc4VFZEM1NFNUgwMVR3RXgvUE03MFA0MW0zN2NmMEZ2?=
 =?utf-8?B?NC92SERyNldpbWVZYUdZNnNuZ0wrWCttdlE0R3pyMXZnc1Y0YmhLc3BuODdx?=
 =?utf-8?B?WlVNQitCTStrdGh6bVAzMGxFR3phVllSMWwxbWR6cFJZUGlEaUdkRDZRZzgx?=
 =?utf-8?B?Y1N6R3NtaUdFQjhsSUVTcVVTanBFMDhBalZNQzAvN1JDSHpIUmhvOEl2bE1V?=
 =?utf-8?B?VGNoS2s0UzhFMUZrWTcrUE1iOEZkc1ZDTk4vTEdrdEIvamdDazVCS3B6bEdM?=
 =?utf-8?B?OTBkeGttVHFwZW04K3JnUEN4cFhITlNlY2JJN3NlRjVFTGhnNDNwdm1CeThN?=
 =?utf-8?B?eE0zdGM4U3F5RlY0elpNbm4yK3lqNWp4OS9yVUVsNEIvVHBRNjR3MzlOS2tt?=
 =?utf-8?B?Vi9VTDRaanJYOGgwRnplM2RFUjdXTUxVbExzTUxxNi80OVB2Qy9jMk1TUXN2?=
 =?utf-8?B?dTNqZFJjNlgwdnNHSDdnYWkxUWJDNlc2V3ZTWTA4cVFTaElvYzZhN2dTTzli?=
 =?utf-8?B?WWZIeUtoMFZtS3hWZ3pueFZPV0phVzlzTFNyakJBMHpsVEh5SEY1cmxNcXd0?=
 =?utf-8?B?RldUcFNVeXNYVjU4WlcyQUJ2Y0RucUhSSG52TEhnaFNKUStZaGhlSGxXdjVi?=
 =?utf-8?B?eTlwNitKaE9CL0JWOVN4V3dTVDM3UlI1T05ibE5PTTVVUkk3YUhUV1hJcS9N?=
 =?utf-8?B?QmhhVkNtbkd1QnVrK0ZqY3MzYnJlUVBqQVppQmN5eURmMjZvQ1NLVWg2aEZq?=
 =?utf-8?B?NU5vempkSVJIeTRXMkRpb0dKVld6d2NaeDR3WC9EclVMM1EraHZmNzEzdVFV?=
 =?utf-8?B?dWRjMjh3UjZRRG5CMFZ3RHNPdVdTT0pnRDBidXVSQ3NEWGZoZkVieVo2UVNo?=
 =?utf-8?Q?W3VbRb+R3NhqIPeZm7kwcZpCZ?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8a59a4-0ee8-473d-4845-08dc89c7b1f2
X-MS-Exchange-CrossTenant-AuthSource: SEYPR02MB8152.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 03:36:35.8233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z/30ZPZGfOhPnQghghdbQhWb2wMrh55v5Wa7eq1tqp2EBJUaeknGWaZQUpOS/lPRGndh6f6JR1ksehv6lNvTlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB6268

ping...

On 2024/6/3 17:18, Gaowei.Pu wrote:
> From: pugaowei <pugaowei@oppo.com>
> 
> we should update the weight of cfs_rq before update_cfs_group().
> Ensure that we can get accurate shares of the cfs_rq when its
> weights changes. we can find this work was done correctly in
> dequeue_entity(). so fix it.
> 
> patch_V1 :
> https://lore.kernel.org/lkml/20240531030833.3375-1-pugaowei@oppo.com/T/#u
> trigger a warnning below because of the changing order of
> account_entity_enqueue().
> 
> [ 0.400603][ T0] ? __warn (kernel/panic.c:693)
> 
> [ 0.400603][ T0] ? place_entity (kernel/sched/fair.c:5256 (discriminator 1))
> 
> [ 0.400603][ T0] ? report_bug (lib/bug.c:180 lib/bug.c:219)
> 
> [ 0.400603][ T0] ? handle_bug (arch/x86/kernel/traps.c:239)
> 
> [ 0.400603][ T0] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1))
> 
> [ 0.400603][ T0] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621)
> 
> [ 0.400603][ T0] ? place_entity (kernel/sched/fair.c:5256 (discriminator 1))
> 
> [ 0.400603][ T0] ? place_entity (kernel/sched/fair.c:5182)
> 
> [ 0.400603][ T0] enqueue_entity (kernel/sched/fair.c:5328)
> 
> [ 0.400603][ T0] enqueue_task_fair (kernel/sched/fair.c:6785)
> 
> V2 fix the warnning and keep the lag without inflating it when it is
> the first sched_entity queued on the cfs_rq.
> 
> Signed-off-by: pugaowei <pugaowei@oppo.com>
> ---
>  kernel/sched/fair.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8a5b1ae0aa55..2fb1fbcfdda3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5190,12 +5190,12 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  	 *
>  	 * EEVDF: placement strategy #1 / #2
>  	 */
> -	if (sched_feat(PLACE_LAG) && cfs_rq->nr_running) {
> +	if (sched_feat(PLACE_LAG)) {
>  		struct sched_entity *curr = cfs_rq->curr;
> -		unsigned long load;
> +		unsigned long load, se_load;
>  
>  		lag = se->vlag;
> -
> +		se_load = scale_load_down(se->load.weight);
>  		/*
>  		 * If we want to place a task and preserve lag, we have to
>  		 * consider the effect of the new entity on the weighted
> @@ -5252,9 +5252,13 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  		if (curr && curr->on_rq)
>  			load += scale_load_down(curr->load.weight);
>  
> -		lag *= load + scale_load_down(se->load.weight);
> -		if (WARN_ON_ONCE(!load))
> -			load = 1;
> +		lag *= load + se_load;
> +		/*
> +		 * we just need to keep the lag whithout inflating it when the se is
> +		 * the first sched_entity queued on cfs_rq.
> +		 */
> +		if (!load)
> +			load = se_load;
>  		lag = div_s64(lag, load);
>  	}
>  
> @@ -5304,6 +5308,12 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  	 */
>  	update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH);
>  	se_update_runnable(se);
> +
> +	/*
> +	 * we should update the weight of cfs_rq before update_cfs_group.
> +	 * Ensure we can get accurate shares of the cfs_rq when its weights changes.
> +	 */
> +	account_entity_enqueue(cfs_rq, se);
>  	/*
>  	 * XXX update_load_avg() above will have attached us to the pelt sum;
>  	 * but update_cfs_group() here will re-adjust the weight and have to
> @@ -5318,8 +5328,6 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  	if (!curr)
>  		place_entity(cfs_rq, se, flags);
>  
> -	account_entity_enqueue(cfs_rq, se);
> -
>  	/* Entity has migrated, no longer consider this task hot */
>  	if (flags & ENQUEUE_MIGRATED)
>  		se->exec_start = 0;

