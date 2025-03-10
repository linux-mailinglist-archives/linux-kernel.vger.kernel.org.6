Return-Path: <linux-kernel+bounces-554600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A118DA59A58
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D7E516B11A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4945622DFEF;
	Mon, 10 Mar 2025 15:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="pAQabM1v"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022096.outbound.protection.outlook.com [40.107.193.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C606B1B3934
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741621752; cv=fail; b=fcc1WKjSl6lKCxQalN0EoCMZBrkjEfEU31CsY3N1ulytyXq2M45GK/PNmDHEx7T7tW+FBaKA5gxlXwjBJoEM3MsfOIKwOatzRdx6LBoJbw9Jb2BOL4NjslT/UB3+3UqAh4oWXxwYkkhMp4puw/OT1sqY7qUwoGCNkbDPIdHUuz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741621752; c=relaxed/simple;
	bh=/A3m3mvmKZ34XdbkMkCtjcUkDNu0XDUX179UtuR02Zo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bud2vfYSmxq6sSkzFlxa/5AGpneA8opvbHyL4LjakCKWRUVsh5FwMIF6/ECVNqNR8hg41VqA1j31q3kaMdDrGSciIlL9oyQzAVYXFUIII2PwT8tkdqYb+v3g8qkVSKEPae7JMtou3QnNZgguuLXjmTBCkkRHSFcRO+d0RwlsFRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=pAQabM1v; arc=fail smtp.client-ip=40.107.193.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7mcFCS0KKq4AmsZjJITPyOOnnV8mvP4OjLLmLDXNtE8DnRMvfGYMvMq1k6U7vm8xSuMUA3Y1IphNk9JoEMabTMtJdmFeE1IOgySORFTmpN+eg5HTin/Z+1pgn8SpS1SFKEPzu8G+8doyX0H95uEDZ0duzwyEttnTTvyBRZjGYb4tlT2TMVTQU7/kal4IBJhsWFm7dj+QhGnOeqY9mA99xhL9hvfMzIgccZIKfGd7sn2nZDS7v9kfW70rymdpt+5HHPO3pfxQ3PN+PwjJJ2ABUL/MpHbtsOnp96+atNqaBG+tF3+3TzllrBYSk0HsEQy2qAJ0FUYs6bbwTMbz7x37A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaZmlO4x5d3/bmJtcGECPJOgN2LtYtObOSLTY+1r08Q=;
 b=ew9pxLJj3XS4sDC1KV2RvJl/BPjidSkrln+L7DeulLroQhO22e74OdjT2eYp9JYZhKW7uBU7YO7d9VIL+k3laedSnMaEG+zPqLAzSe8D+cKRIVeaT2U1Gopv8Ui90WgUP55pFMyDPRWt0ELF2Tq1b/SJSORQrAb3CqHyWikvanuAN2xFvkBB4PePy+b7fY9Rg4raVFnAcKs5JWS2WRhKY9TpWjqca9oV59IyS9HCLbVVvQZWwJrZ7+4EOBUrrzgPkBKjffpRJkYu4oIVRnPXmWBbaU9RK7iWIqLby9tjbSYQQqareAtutR0V1qCpNt+dj0q9WqmGFwCfC9qzxHJORg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaZmlO4x5d3/bmJtcGECPJOgN2LtYtObOSLTY+1r08Q=;
 b=pAQabM1vZkwNI7mFJ+166U1rUYLJ99d1roQwtbBbZmZaEspbC/NkulWMHK3NEVp5gUD0/sMrn31noO0CsTH8r/noeZy3a0dLvPx0A3oUcXdErsKRNf3lmupWQrOveO8iElBNPNenIUOSLuZuTK5UzoUKBPIL6cCS+HCyEhWCknCUqratYRGUMXso/ZC+BltHv74/fpZm2N1ufsTNGMGqB+V7IrE676lmbKtuGbiu2Gd+4oKdVRDw9gUtCidx3FLt1x/XibkAb2uQfsoNGcpqUduBHZwqOkO0HNduBY6YoscVtowhplp/CgbPo18T8b+2/wyjv3oxB/jwXByvlfKVDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a0::18)
 by YT3PR01MB9978.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:8e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 15:49:07 +0000
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5393:fe91:357f:3ccf]) by YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5393:fe91:357f:3ccf%6]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 15:49:07 +0000
Message-ID: <c100ffbd-5b37-4c38-af45-e86b35854a84@efficios.com>
Date: Mon, 10 Mar 2025 11:49:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/3] sched: Move task_mm_cid_work to mm work_struct
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, linux-mm@kvack.org
Cc: Ingo Molnar <mingo@redhat.org>, Shuah Khan <shuah@kernel.org>
References: <20250227153329.672079-1-gmonaco@redhat.com>
 <20250227153329.672079-3-gmonaco@redhat.com>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20250227153329.672079-3-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0025.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::26) To YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:a0::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB9171:EE_|YT3PR01MB9978:EE_
X-MS-Office365-Filtering-Correlation-Id: 838a83c6-ccbf-4605-a052-08dd5feb173e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VS9rR0M1WGh4bDBnRzN3aUtKTjBuVDVXd25TS3V2SXBDMWp0WHU3OER3bmdH?=
 =?utf-8?B?QnkxZ1U0cDRjVHd4U3R0WkdNNE5qWkFzT0RtZHhGalZHdUJkK1dsaTJmSlRT?=
 =?utf-8?B?L0hta1dBNjhRUVF5by9yem1Cbmc3aG1lODhUdGpsclk4RENiOGFtRm9TMG5Z?=
 =?utf-8?B?LytOWXlzaDFPK2tVVjZYVW10dUwvVGhoZlRubml5OXdWMmJyTnhyVEpyaENi?=
 =?utf-8?B?RHRCdmpvY2poNXA3dXBnbndma3YyS29GdDdxVUtEWjZ3bGJTWFYxalhEVjlj?=
 =?utf-8?B?RFhhR25rUXVvR29CZE5YakRiSnpjU3Q1Nkpyc2duekJRcWl0YXlLRXBIdHVa?=
 =?utf-8?B?S3BWUWtYbjZJQWlYd1B5NHhlS0JEa0NOd29BQ0xhVGtPbUQ5enVTRVR3U0Yr?=
 =?utf-8?B?bzkxRmRVa3dvS0hkeWdMTUpFa1JUSUw0T29UWXpkVGNLMnpWMU5QSUlnNmFT?=
 =?utf-8?B?OFdHdGRYM3AvSzBZaEpxK1VlWk14ZVJoUFpHNnpwRDVsUGpJVGo0RlhnNmla?=
 =?utf-8?B?eENMMHFjc3hRZTNFc2NGdktSRVprUmQ2dTJDMEQ2bVJvQ3BabitGUWt5aktZ?=
 =?utf-8?B?ekttcm1QM2xHVmlzQkZMOGJUNFpTRlNkQUZlT3B1MmpzSlI4dSs1NFdjYnhK?=
 =?utf-8?B?N2xTelpKS2tETmtTL3BNNENLdFluS05ibmI2TC9aS3FUUW1GajF1MlJ5R0xp?=
 =?utf-8?B?a1d5ekxrQ3dHMEdYNFRKSWVtTlZlUFBISEsxeWcvNnVORUdNNGR6NmdoVW1k?=
 =?utf-8?B?OUwwMFc1UFAzSmtSdHIyODN3NGh0NXlsa2pqY1RycVYwS0I5YnhXT3R6aWhW?=
 =?utf-8?B?dUFuZmRiTVdRK3JpVVBUSVZkUUFRTm1iZUR1Z2E5RERvbHpha25TeTRpa0V3?=
 =?utf-8?B?V3pKYVBlRjNkTlRZMGtUbjJaY0hKRTd1cDhpOVNVM2djOVYvNVJ2R3RaZzJl?=
 =?utf-8?B?WldoRHNRcForK0U3Si95OUdmZHUzOTNyZEp2c25vdUhZeEYrV1dJZHgvdHFj?=
 =?utf-8?B?T0ZqZ1Yyb2hIUTdFQU1vbXF5RGJPNFloMlNNSlFTdWs4akJnYk03YytqbFM4?=
 =?utf-8?B?RWJ2bVd2ck1xZnZmR3BLNHdhVWs5bHM2a0ovNHFCaW9Dbi9RMUFuRjNPcHZ5?=
 =?utf-8?B?ZHRUZ2RkTW9kQ2hDdXNjS051TEU1TDVPYU9ISWttUnR3S28xdHRuV0xhRUp1?=
 =?utf-8?B?endSM3BkSitnRG8rdXZFSGgwRlpLdkpKRmRmZ25ONWhNNEEwZjZSUXJnVjMv?=
 =?utf-8?B?UkFUUEdZSVN1bnV5VFRNODZFenVCNGJ1bkFtVnVBV0R0aTEyN1VYSmd0QjNl?=
 =?utf-8?B?T0ZXTFZEZ0UwZ3ZCcmNFQ1p6YVA2OUphOFpITk1oMERJV3pvdUJTVFZoam5X?=
 =?utf-8?B?V0dWeHB0K3daeE15M2Z2YXlWTTQ0L1VYdWxZanBDdUUvOVNSdzhRbWFkZ0ZX?=
 =?utf-8?B?OGE3aURkdkpaMTJISk04WUw3a1VmZ05iMmNiTjdkUFJlamovS2UrRWwzaG0y?=
 =?utf-8?B?T016Qi9XWW0yN1ZkdlM2ODRJemRTL1ExZmtsNWUvaE10SFFhMlVPYm9EbVVl?=
 =?utf-8?B?L3R0REhqekhNbDBPbmJ1UTlNT2habVArV3Z4T29xOXZTdTZMaElqNENoWkJT?=
 =?utf-8?B?Zzc2ZGFpNk5SczhPZFJxMG03REtWU2xnMzVXa29RRmNHN2pFTnI4UW9iVmVn?=
 =?utf-8?B?U2tpS0owd2ZnTG1POWJ5TXY2VmZMK0x1d3ZWTFZpUmROc3RpQnF6NEhKZFh0?=
 =?utf-8?Q?q6hQ/bq14VZIAT0JpQfhh64ayL6RZb1SL4/GgVD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGcyak5JZGhJK1dzZm5ZUVhmL29WWlBuR0JvdXVuS0Y1UmFYTUg4dWE5THgr?=
 =?utf-8?B?NWhDT3BFZE1TWXNkaE0wdUtEN244RkhlMUtFT1pNMGE0OUhPalJkajNsQWQx?=
 =?utf-8?B?enBLQnB2TUNjenNTc3ZKbHRzOFh3Z2FyczlvdEZTTGh5VFVUTkx4enZhZzJZ?=
 =?utf-8?B?ZUx0eUcycGJ0N1BJREMrb3duMXAzci8xMzZnSXpmYUdEM0QzUWQ1WHdVb0RM?=
 =?utf-8?B?cGZvNHprSkFQRkx6dUZoRWY2dUJOamNUMFFQRXlYSGxZWm9oWDBKUi9mcy9M?=
 =?utf-8?B?V0VoNmdEUS9WMGRtRXYrdHMzVTdad280NGRVT1pQOTJRTlo1eHM1UFlSYlpv?=
 =?utf-8?B?OEw1OVRkb08vUFd2NjdLWldINmdwSWkzclZEbmg4WVhsQ3dKSmt0NHhHU3l3?=
 =?utf-8?B?UmFaT1cwdlNCZzV3S25LZWFYekw0NHpEVGVobjR2WFd4cjFIb29MRXdmVERU?=
 =?utf-8?B?Y0lYL2huenRoZTVPRDZWTzA4ZHllUXlSeExEemN1dW41VkYrRkF3K255R3Fo?=
 =?utf-8?B?YUxOdTRtVDZReGlWVEQ3V1dLMDZlZDlzQ2hqUVVlb0x4bjJkWjFyWE5NWnJO?=
 =?utf-8?B?L2E5NEhFMmZsaDdHMm5GdGlkYVIyUk5RenZEWXJiVTRIcS9IM3A5VURHelhH?=
 =?utf-8?B?WmFUY2NFdzQyazZiMDd6L2Z5cjgrdlEwM3BNenFpdU9VNWJUamY3VGNIQnBv?=
 =?utf-8?B?YjNFQUFsMHdIOFkydmludDZ2cU5CWFRwMk9sSmM0OWs2OVNHb25MTjg4RWoz?=
 =?utf-8?B?R2dWNWdkR2R5R1Iyc3A4S2FUM0xHMW9WZmdmSkVaSlV2ZU1TSm1DdzdUUnd4?=
 =?utf-8?B?SURvU21BRnk3cEM2YkxHdkFzR1RuRHFNQWorMnRSL1c4OGh0M3NzZXI4MTVO?=
 =?utf-8?B?QVdRUVUrUEh2T2d5Z3Vmc0lNUHlKWVNGbzZmNXR3ZlUvdkFwN0lHbnZmWloy?=
 =?utf-8?B?Qm1iUWk0N085THFhYzFya3BsekVlRnRVUmVNU2kvbk5DTXA2L2VjZkE3SjJ4?=
 =?utf-8?B?OTV1UXA0b2picU9URFJoR0hBZDJpZHVDY0IxeUhRNEJ4TC8wNlFUSjQySVFu?=
 =?utf-8?B?WmZFR0VGZXlEZGlVTmpMYVBWZE92ZkI4TTFmMHAzTXdRQTM3aUhGR1pvV3RJ?=
 =?utf-8?B?RnJVYVFMcDhrYzV2VldWa1Q4bTR6dzV6MXozajE1UEpkOWFjcXRSZysvYWUw?=
 =?utf-8?B?cTZpeDhiejVwcGsyYSt1YnUzU0tkZE5BZHBEOGRlaU9DUFdpVkpFZnBkTDRw?=
 =?utf-8?B?UFNZeTlCSWVCSlBoZU94ZXQxNVhkYlNzRU9iQzQ0aTZSeUV3UDYvSFMzMVpY?=
 =?utf-8?B?STNmNmFhTCtDVktoVDczVHQwTEFuRFNWV2lQanZKZXZ2eHV0TXN1MCtxdGRD?=
 =?utf-8?B?Y1RUd2dtaFU0b21la2VuUUE3UUd4RGtPSTRrQ3R2b2I1OVdrT05tNXpOYTAr?=
 =?utf-8?B?b2NFRkU5R08vTUtwSExiTjhpK2tjcFM2OVllQ0ZvMEJrNWN5T0dwS2VHc2k0?=
 =?utf-8?B?MlNjdGord2NVV0ZicW42NTJkYUVoOFhMM0RFSC8wV1NRQjBlT1ppR2NDSVRV?=
 =?utf-8?B?SDhFQ251OXVxODVySjUvQlpNUFNKL01CQW9aRGNKcHVTNWtFREhBZUxuK1hD?=
 =?utf-8?B?b3FGOFZlbkpKMnRNU0lXckNBVmIzTDV3TzNseWlsMlRCNys0aEJ2SDlWZWFD?=
 =?utf-8?B?Y1ZoYjNIc3loeXV4bDZZSzZwQ1RpeHJYTnpFaU5wbG9hYUdsaUxUZ1YxNndU?=
 =?utf-8?B?OWYyempNZnVnSHFHYXR6Nzk3TkZmSW5xZnUwdUpSSVhFOVpkOTIrdk54Z09I?=
 =?utf-8?B?dzFOMkpwS3pKWDAwYVVhZXFkRWdNM05zUzZLQmdlV2wwd0k5cU9QUG11N3NL?=
 =?utf-8?B?L09zNGVXcGFuRGMxcmtDSE8rU1JBVzkrMGVWbVUvemwyaG9FYzZhNStnTjdV?=
 =?utf-8?B?VTdValdVek8wcG9BZjJzYndXV3ZvQTBUMWNnZjgzM2lsdGdRdEdaUm04MElW?=
 =?utf-8?B?R2NpMU1LS2JQS1MxdDVpZlF5N1BQUXBxSjc4NGZtRzJmbUs4MURsTmJydEV3?=
 =?utf-8?B?Nk5xLzBYL01IU1NNQlp4NXd1UE9Ja3hvR0h1bmdBSFlXQitKa2wzdjUxMy9N?=
 =?utf-8?B?Uy93RlV0ZGJ4aU5mUm9HN25RQnBtaGJjZ3BKT3Y1dGxzblYweWk0WUhlSk8r?=
 =?utf-8?Q?V2xaukX2GvME5KsvSdMpiUI=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 838a83c6-ccbf-4605-a052-08dd5feb173e
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 15:49:07.0198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G5Fghnz8cT9dlRwHrPKsfOcVx4h2eQI5Z39eYnruBjaUeD/LihNed4YLjA5REkLXL+51gegT6kBjjvqVBt5iDSf+u8H8cMJDbkn8YSIGfsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9978

On 2025-02-27 10:33, Gabriele Monaco wrote:
> Currently, the task_mm_cid_work function is called in a task work
> triggered by a scheduler tick to frequently compact the mm_cids of each
> process. This can delay the execution of the corresponding thread for
> the entire duration of the function, negatively affecting the response
> in case of real time tasks. In practice, we observe task_mm_cid_work
> increasing the latency of 30-35us on a 128 cores system, this order of
> magnitude is meaningful under PREEMPT_RT.
> 
> Run the task_mm_cid_work in a new work_struct connected to the
> mm_struct rather than in the task context before returning to
> userspace.
> 
> This work_struct is initialised with the mm and disabled before freeing
> it. The queuing of the work happens while returning to userspace in
> __rseq_handle_notify_resume, maintaining the checks to avoid running
> more frequently than MM_CID_SCAN_DELAY.
> To make sure this happens predictably also on long running tasks, we
> trigger a call to __rseq_handle_notify_resume also from the scheduler
> tick if the runtime exceeded a 100ms threshold.
> 
> The main advantage of this change is that the function can be offloaded
> to a different CPU and even preempted by RT tasks.
> 
> Moreover, this new behaviour is more predictable with periodic tasks
> with short runtime, which may rarely run during a scheduler tick.
> Now, the work is always scheduled when the task returns to userspace.
> 
> The work is disabled during mmdrop, since the function cannot sleep in
> all kernel configurations, we cannot wait for possibly running work
> items to terminate. We make sure the mm is valid in case the task is
> terminating by reserving it with mmgrab/mmdrop, returning prematurely if
> we are really the last user while the work gets to run.
> This situation is unlikely since we don't schedule the work for exiting
> tasks, but we cannot rule it out.
> 
> Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid")
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
[...]
> +
> +static inline bool mm_cid_needs_scan(struct mm_struct *mm)
> +{
> +	unsigned long now = jiffies;
> +
> +	return mm && !time_before(now, READ_ONCE(mm->mm_cid_next_scan));

Small nit:

You can remove "now", and just use jiffies as argument to time_before.

Other than that:

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

