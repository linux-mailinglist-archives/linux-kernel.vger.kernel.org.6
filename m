Return-Path: <linux-kernel+bounces-422667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A35919D9CB1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A20E6B22508
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856901DB363;
	Tue, 26 Nov 2024 17:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="iTU+HnQB"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2091.outbound.protection.outlook.com [40.107.94.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6161CEE9B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 17:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732642715; cv=fail; b=AddRwTd40osZNh8W8EcX5jLJQwxac/EHN+oBA1yAT9FwU1kIsh7VibG9aXoZ/jfy4B6BueumCcgMDm+lbZjL5/5ouRpab0vIE0USCbbNSBGH6kXL2hcpTIWjn4fxvrKAz1G5SrX/6+D0caDw7uPmetBt0w95M0Jrkknp9YD3DRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732642715; c=relaxed/simple;
	bh=T8fCtsrvhn+nxnGtOD4WzZH+vQBV/EzWs2dABYQM5v8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=myjYhJQm6hcA2LM/dHuW4gRzS4sX4aIkA9jQJ3mLwAeuTEPx/8zxpiRMfZxxGXu9Q8I+4yB2v7dfzAO1HegwT4fB7NJ2GlyDY9QbVySqTdfRP3qZgqObAmoVFOAdx9lm/wFdA6MnEIA1gmnCSuJ46SmSbwjvIcfchQTrjf0LI68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=iTU+HnQB; arc=fail smtp.client-ip=40.107.94.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6Oih/MyvfUAtYGY56L9brR+PzPEFnQW9MAchKM9zx/v/hNj2niCMhvnb9HqKkPSRqvqP7biyXMEsfhFgFiVv6CzEx9blxmdRMFdzJj7f0iN9nb2nvUuKjlYoen6BqFlYUMVToEjEg/sh9RKz4kGfWRkY1rNKPfY96EprSEGHWNpBmiLNzkGwDhVSQIRKoskDuXWTtimYgfXDD8YLhbkvVNR8phww8YmIuD1CJ8IBm+x0p2eINLph4XeM8p6CK03mPORjTIQwlODyLp2joUvfUBdpDJRyeT2yuJJOiY00apHHRkzqcQ9sZTW37380diDbaqiwh4pOsuZXlg5YflWjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68OMM+4gfbJv2m8Pua0a3cV/a103vSPfTEaaUEW620Y=;
 b=DmoP8bBplccz5ClDms6c8Xf8+thUPWAHp7KicdRGfE3M9NSuOhIZeVraU+a4rDHalWNQBzKaWAmFWO2GAn3M3DL2CUWNsImt8mSvcRwQ6EX8/t+8T85stApPSCHd5a9hBYZapNGdJL+/XrCbcGD4pLdnABS+8FZmQXSZfnMUGBROgUFjCDPqkAZQpOEn7c0mLpaQYIqI88p65J4EkFBdxxE8MFHrcbPQS2WFX4VaNwqFiOydnex8rbDZKQHXcp8CmhDNr44ycULWbC7IHxqq7WCCmcVRB9y6Z4g/SgP9IU+dXKSxMY+6bApt9FrdDqH+yIsQAh6CaN1uTop3uQBi0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68OMM+4gfbJv2m8Pua0a3cV/a103vSPfTEaaUEW620Y=;
 b=iTU+HnQBkECWw0Pj6EoCVsAA1hbxU+eE3mDdDMik0MUDo0x4hb3CrAyCFzVDgNoh1iq+TwbvEmvKs1J235HxGW2V0zTHX1BjnVH0EENo4ooG0UqmB4OAw+ar/sNx0HGAsxyWttyeJYh6/zaqx/wbfPGHAemY4pwvoPXdWe5UbpE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SJ0PR01MB6480.prod.exchangelabs.com (2603:10b6:a03:295::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.12; Tue, 26 Nov 2024 17:38:27 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.8207.010; Tue, 26 Nov 2024
 17:38:27 +0000
Message-ID: <98583682-a95e-440e-bd89-03828998b48e@os.amperecomputing.com>
Date: Tue, 26 Nov 2024 09:38:22 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: mm: fix zone_dma_limit calculation
To: Baruch Siach <baruch@tkos.co.il>
Cc: catalin.marinas@arm.com, will@kernel.org, ptesarik@suse.com, hch@lst.de,
 jiangyutang@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241125171650.77424-1-yang@os.amperecomputing.com>
 <87ttbu8q7s.fsf@tarshish>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <87ttbu8q7s.fsf@tarshish>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0202.namprd05.prod.outlook.com
 (2603:10b6:a03:330::27) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SJ0PR01MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d0ae939-2c0c-4fc5-723a-08dd0e412276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1A1dzVXRm83Ni9PcGhaNFF2cCsyNzBLZVpab0orQkFTYkVCYnBWYlFOdHhk?=
 =?utf-8?B?VERMMnJtZVNkL2dsNFhPWkxUYzg1RUl0T0hpWndGdXVUQlVhSFRKVnY3MzVN?=
 =?utf-8?B?Z2tnUHlvWW5RNGZKNHU0cDVuNUtzQ251VzAxVlR4NmZVKy9uSmtUNU1MQ1FF?=
 =?utf-8?B?cWk3STdrRHVyM0g2TWtVZGkwNTZHNUxXNHR0bTlTZW9JVzRsNjRwd1VER2Zh?=
 =?utf-8?B?NE43cEk0dmFxaFBtSFBZSloyRVl4TEpyeDhnR3lKM1Z2MXRiSTVGdE0zajJD?=
 =?utf-8?B?eFNYeWxvelg2MlorVEh6RUVTdVVHKzkzZ08wOFU1WWxhVzVJME9uMlV4MDda?=
 =?utf-8?B?N1h5emhVenpnYi9oVGhUY0lRTkEyL2ZiVk5QdDhBdVdJdTN1VFM1ZldQckpH?=
 =?utf-8?B?UUxyZmFHOG16V3VtM09FV1VhTWlJc3dRMXc3VzUraXhNZ0ZRcHplYWVDL3hi?=
 =?utf-8?B?QjNReFFONU8xMFhBWUovMnBEbDkzdWE0RVl5azM4eFFhWktuMFNrK2FYRUNq?=
 =?utf-8?B?Mnc1ZG5wb0xndU1wY1NDSzVwTkYzYUpGUXMxNTJhUTRNeWd0Z2JIZDNUYjN3?=
 =?utf-8?B?dVNGVVFuRWQyMWZQWGlBUDB2ZitETHVFUThpbWVSNlE1K0lpYURpSEhjOGZC?=
 =?utf-8?B?NUMzYzNXUEMxVWw3T1lCbC9qRk02V2ljWW05dktQWWY0Y1JpdWxZUDdMaXlX?=
 =?utf-8?B?RkJ4WElLWU5VMFJNYyt5Q0s1SzJ3U1UybmRvRTdBeHdaUVZYTC9PakhDN1Fj?=
 =?utf-8?B?Y20wVU5BN0FTMGVMUDQ5dHl4S3JrSDgwQWxpNzVxcDRPVzdVeDE3dWJiVHlF?=
 =?utf-8?B?WjZsaUdnL3BiTDAxbmxKUXYyRG1IbCt0U0xmdXFlSHNjKzJXdDIrRC83UEYw?=
 =?utf-8?B?WEhUUUVpbjd4UkFGWFNxZVB3djlXMTJ3S0dySXJDQ2VaZzZjQzN4UHJFYW1B?=
 =?utf-8?B?NnVxZlBhcjlBbmx2d0NNN0NzYTlGUEFNbnQ1cCs1SWJERWVVR1Y2Zmp2ZzJD?=
 =?utf-8?B?QVZadG1HZGxBTW02dDJrZGxIaDJ4NlR4M2hiVnBhSVpqN3RKRFB0S2RPWlZV?=
 =?utf-8?B?QitUVittMjZEckRsb3dxaVE3TzM3SmxaazllMG1iZ3ZLUnRnSlRTYzdMS3dO?=
 =?utf-8?B?UVFQclRKaXRrOVRYUnlwMnZ5d2FvNlJ0SzFNU1UxeitkMVI5RDZLKzRYcW1m?=
 =?utf-8?B?MnFobmhyZWdiaW5jMHVrTUlXY1pFbjEvanRqaVY0Zkl5ckdLWDEzb3pwU3Vj?=
 =?utf-8?B?TWNxTG84NFRlNElYaVNuYlU0OUJnMmorVzZnYXlaRjZWdDk3RXR1ckttamxN?=
 =?utf-8?B?NllZZEt3c1ZKa0EwZ2hrQXR1SHlad09OeURmYzFHM2ZVRTkrdG1xSWF3OSs0?=
 =?utf-8?B?bVlmUjdwWGlwNk5uU0FCVHhFZmdLcHZINGh0RnkvaVBtTkNudVh1SUZvWnhR?=
 =?utf-8?B?QzZoL2thL0F0ZTlvSHBFMThCV2kxSmFVQndvNytiNzFhQmNrZi9RSXMzUjBP?=
 =?utf-8?B?azhMZitZMlpHS0Y1ZU9WdEkyUXQxZzZ1aEt3a3BoZVkyRm5aalQzSjByWFFv?=
 =?utf-8?B?Uk4xMjBmOVgvVkVMeHFJRmZ5YVR2NXNHdzBHUVVnYzFXbXRmekV3VCtsbjhQ?=
 =?utf-8?B?MThTMGhFZ2RVQ1NCeURncTFlRHFJV09sd25oOHM2S1JXQnlQS0hSd3BJUjg1?=
 =?utf-8?B?RjNjYTZWaTA3Ti9LaWdMQlV0Y0tiR2UzYVMvcERJZFdpSWtZMFNDU3hTWWR1?=
 =?utf-8?B?cXRRN2E0MTQwbjB6QW5rV2hlcm1oSWNBMEZ1U2VNcGcwMVBlS2hGUkhucytG?=
 =?utf-8?B?R1ExSEFkaDQ0bzdtOTN6Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bW1GdmJOL3JvSWgrdlhXczhzMVEwMTE0QlBMcERxQmhuQ3JTZVRwSmg0R1Jh?=
 =?utf-8?B?cTV1dHJ5bElabGtXYzJKd2hhSzNkOWR2bytuOEFTUENmNUE5QTlaOVpaTU9h?=
 =?utf-8?B?b1o0L0NMcDVHTXV0NmxWTHRuMS9KQ0lFZVJZb2ZPejZSdHhEZnZKbldYcFRV?=
 =?utf-8?B?eXVqNEhnbG9CTVVTUTh2REU0cW5RSjAxRjR4Yzd2R3Y4NWRFVC9FcXJUY09K?=
 =?utf-8?B?VXZ4VEJIdk1UanlMcEN2Q2hnVFg5NzdoL2swVUtKY0dQNWFKYkxDbENyR2tQ?=
 =?utf-8?B?eTZubFF4SXhmOFMrTTE1Y2FTQWdRNUJUdWROZUpBVi9PQXdsSUNjU2tKaVpI?=
 =?utf-8?B?STNlRDRNcHhZQnJrOVBMMmZDK29WVkYvbDkwelU3TzFTUGgvMVByZm5LS2hZ?=
 =?utf-8?B?R3lBbVlLcVdEMWk0TWtsZU5jZmVDcWdnSWNEb0NuTHR5RE14TVBRYzFVbFRm?=
 =?utf-8?B?bkp3WWdqSFhUWEJEcUFiV2haWjRQKzhFei9zYkFZS09XY3djMEx4TG8zZG1Y?=
 =?utf-8?B?c0t0MEljRmNpMitYcE1NN241aG1oNVk1T3FLYkwzOXJTajhNVE9DSVNZSkh1?=
 =?utf-8?B?UW5KMHlMaFpTZzBvcFpRajFuTmhRdmNlTmsvMGRZU0RSNDhpSkVxR3pYUWV1?=
 =?utf-8?B?TCtFcUhMZ3BWQzdyaDIxZVZFQjNXZHg4NDEvSkhLZWxGNWVVTDlySUtkS2xF?=
 =?utf-8?B?S21BcHZZYkpKbDEyZGFJMW5uR3c1dU1DNzFYN0lkTU9pVEV6Tk9hcFp4NVhs?=
 =?utf-8?B?bndnZkJpbXJlVmY4M29TUk1Xdm5GdnpFeDhYTXdjdlc0LytUeXBJNkNMVVgx?=
 =?utf-8?B?WFNZeCtnQU0wSjBkd1Z3LzF4WUFrcmdkU3BQYVliN2Q2TkdmR0hNWWt5Wkh4?=
 =?utf-8?B?eXBMVU5SOXdoNU5OZ2RsQXA1Z1JORGgwQXFzcEVub1BQVmFGZ1Q0NUY3UTEr?=
 =?utf-8?B?Nk9vZElCT3JmMEVvc3BXT2o4cTkvSk1IbTBtd2ZxcXJHbkFTMGtBNkM5QVNX?=
 =?utf-8?B?VXBZWURwcUdoaXBmeENpZE9mcE1McUtlRGYwUWh4UmJXTUs3TG9ScE9yZEQy?=
 =?utf-8?B?T1U0M0dpbnZFRGpGek80SlltY2dLVkF4MWp0RC9ORDdTMW90UDJKRXpJY012?=
 =?utf-8?B?OGxid0pNL0NPUDlHcklSQ1MxWmpHb1kwdFZ2dGRQRmJvY1RpK25jYnd0eWdF?=
 =?utf-8?B?Zy9VRVJqbE9VVVR3QXJuMnJLZ3Z1Mkp1cHpwZUtrTTNKYzBRdVZvZ3pYL1da?=
 =?utf-8?B?MmoydXFwRmFUamJoWkFncEJVTlRaVFE4bXcyY0ErOFE0VFBTOUcrYXFYT1A1?=
 =?utf-8?B?M3NEU0hIMkg3K042bTNhcXRpU09pSFlOZ1ZJTWRVYTBOZ1duUzlDM2kwaThx?=
 =?utf-8?B?cWZkZEYva3phRUN4Zyt0dnl0UjJpQXBZVUNZbDIyeS8vdWJ4cHFkM2twM0Fx?=
 =?utf-8?B?eE9JMUFXNXEyV0ZrZDhmMUpUMDcrdUZXOHg1dndiM1A1N2NSVVFER3lFVG8x?=
 =?utf-8?B?cHdOSndWRU5zVE91LzROKysvS3hUNXZ4cEpYRFh5aVMwSlZsRUgyZTNXMDRl?=
 =?utf-8?B?a0ljMklzYWkvTTJpSmkrR1ptNjFMZU55V1ZHZkV0UVZjalNDbzJHdDNIVjJ3?=
 =?utf-8?B?Z1JjRDZGeURwaVdxcVMxM1FGY0hLZ2J0TlFXN0VLMEJ2blJNZGZHRkRFYWRm?=
 =?utf-8?B?a3FPRUNLZzRWeGJlS1FRMmlwU1VOVnVKcnBmUnBaay9mVlRiWndoNmRxRjdR?=
 =?utf-8?B?eXZrVUY4aVVGa0d4NG5CTDVkSFUxdGVPRFVJY01Kc3BiZTliMHBWUWR2MEtq?=
 =?utf-8?B?UHkyT0lOSUxNdksvK09jUTFjNDdvTURRUll0TmhHZGNNRjJoVEd3SUdoNzkx?=
 =?utf-8?B?Umx5aCtmYmxUR1FyMXAxd1dYVzVjTFliR1oxMC9wVTI1UzJUVEd0VnJyT254?=
 =?utf-8?B?VnRBMlFqVzBHQjJjZFBTdEdTekFNSWc1alU5L1IrS3ZCUlJEbnZGWFlleitm?=
 =?utf-8?B?OWZoVFVuSG5CMXY0b3IrcWwyZnRvUEVkRjR2Y0dIS29KVndsZlJiTUxvcVBO?=
 =?utf-8?B?SytmdVR5bmFiMStxSVJNNVdBcGdrbkFwV1BONG9BY0xlL2NycEU5dGhsR3dm?=
 =?utf-8?B?ajFmdXZhK0RGQkQ4d0xGNU55NlJ0OE9DRVN5cVkvaDl1N2xKc0V1aW9XLzRZ?=
 =?utf-8?Q?98Y7BxZQZhUK0AtjO7TZ1hg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0ae939-2c0c-4fc5-723a-08dd0e412276
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 17:38:27.2318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W++pVRVUFOyuw4gOJmOPLdpUT1NDbmS8S8lSSLurGk0bUXDADpXM6InlTgbGb1pT0x5SLEdkvg3XlenZ2feLnMUWtBBtdK6k9KWms6ECpQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6480



On 11/25/24 10:27 PM, Baruch Siach wrote:
> Hi Yang,
>
> On Mon, Nov 25 2024, Yang Shi wrote:
>> The commit ba0fb44aed47 ("dma-mapping: replace zone_dma_bits by
>> zone_dma_limit") changed how zone_dma_limit was calculated.  Now it
>> returns the memsize limit in IORT or device tree instead of U32_MAX if
>> the memsize limit is greater than U32_MAX.
> Can you give a concrete example of memory layout and dma-ranges that
> demonstrates this issue?

Our 2 sockets system has physical memory starts at 0x0 on node 0 and 
0x200000000000 on node 1. The memory size limit defined in IORT is 0x30 
(48 bits).

The DMA zone is:

pages free     887722
         boost    0
         min      229
         low      1108
         high     1987
         promo    2866
         spanned  983040
         present  982034
         managed  903238
         cma      16384
         protection: (0, 0, 124824, 0, 0)
  start_pfn:           65536

When allocating DMA buffer, dma_direct_optimal_gfp_mask() is called to 
determine the proper zone constraints. If the phys_limit is less than 
zone_dma_limit, it will use GFP_DMA. But zone_dma_limit is 
0xffffffffffff on v6.12 instead of 4G prior v6.12, it means all DMA 
buffer allocation will go to DMA zone even though the devices don't 
require it.

DMA zone is on node 0, so we saw excessive remote access on 2 sockets 
system.

>
>> This resulted in DMA allocations may use GFP_DMA even though the devices
>> don't require it.  It caused regression on our two sockets systems due
>> to excessive remote memory access.
> That is, DMA zone used to cover all memory before commit ba0fb44aed47,
> but now DMA zone is limited to the smallest dma-ranges. Is that correct?

The physical addr range for DMA zone is correct, the problem is wrong 
zone_dma_limit. Before commit ba0fb44aed47 zone_dma_limit was 4G, after 
it it is the whole memory even though DMA zone just covers low 4G. 
Thanks, Yang
>
> Thanks,
> baruch
>
>> Fixes: ba0fb44aed47 ("dma-mapping: replace zone_dma_bits by zone_dma_limit")
>> Cc: <stable@vger.kernel.org>    [6.12+]
>> Reported-by: Yutang Jiang <jiangyutang@os.amperecomputing.com>
>> Tested-by: Yutang Jiang <jiangyutang@os.amperecomputing.com>
>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>> ---
>>   arch/arm64/mm/init.c | 17 ++++++++---------
>>   1 file changed, 8 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index d21f67d67cf5..ccdef53872a0 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -117,15 +117,6 @@ static void __init arch_reserve_crashkernel(void)
>>   
>>   static phys_addr_t __init max_zone_phys(phys_addr_t zone_limit)
>>   {
>> -	/**
>> -	 * Information we get from firmware (e.g. DT dma-ranges) describe DMA
>> -	 * bus constraints. Devices using DMA might have their own limitations.
>> -	 * Some of them rely on DMA zone in low 32-bit memory. Keep low RAM
>> -	 * DMA zone on platforms that have RAM there.
>> -	 */
>> -	if (memblock_start_of_DRAM() < U32_MAX)
>> -		zone_limit = min(zone_limit, U32_MAX);
>> -
>>   	return min(zone_limit, memblock_end_of_DRAM() - 1) + 1;
>>   }
>>   
>> @@ -141,6 +132,14 @@ static void __init zone_sizes_init(void)
>>   	acpi_zone_dma_limit = acpi_iort_dma_get_max_cpu_address();
>>   	dt_zone_dma_limit = of_dma_get_max_cpu_address(NULL);
>>   	zone_dma_limit = min(dt_zone_dma_limit, acpi_zone_dma_limit);
>> +	/*
>> +	 * Information we get from firmware (e.g. DT dma-ranges) describe DMA
>> +	 * bus constraints. Devices using DMA might have their own limitations.
>> +	 * Some of them rely on DMA zone in low 32-bit memory. Keep low RAM
>> +	 * DMA zone on platforms that have RAM there.
>> +	 */
>> +	if (memblock_start_of_DRAM() < U32_MAX)
>> +		zone_dma_limit = min(zone_dma_limit, U32_MAX);
>>   	arm64_dma_phys_limit = max_zone_phys(zone_dma_limit);
>>   	max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
>>   #endif


