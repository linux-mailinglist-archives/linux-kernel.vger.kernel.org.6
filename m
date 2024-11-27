Return-Path: <linux-kernel+bounces-423115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BF79DA30E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 08:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3F8E284160
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 07:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B2014D29D;
	Wed, 27 Nov 2024 07:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="TwOtOjqs"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2118.outbound.protection.outlook.com [40.107.220.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00605149C69
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 07:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732692393; cv=fail; b=idQftOEI4do2ZH+WmXmd3KVmzK7aYVPcE8jNxNssD4r/l8cd0C5beVAU5f1HtiUxtLzZSmC2DBHC3VXjdrG3JklKhnl2wUPnQPpNKhhPTwVcog0bO/ipdIN9Eul70EOmr3DhETwuyZ1uDAI4xAyVO5sxjkApFzAGV1T8CFqmMIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732692393; c=relaxed/simple;
	bh=uNz96WJ8p7yNdJxM5nj9NAkZmsCFHmdRwYrFc/mJATs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KY5PoTQniebo+MrWSOlW53LEKcuNqssTBV1uGDkm4eIbOdL0UIytEhzgTeKxw/fGJpg26W+g6bYXLRgB0UxwMx2xDgGNEJjsf2k36B3sI//bpA3s0YtxX0ZymEtYbfJkpJXn6tN2tADScx8vJkfv27XUMS6sBmr90Mc7oZAnFLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=TwOtOjqs; arc=fail smtp.client-ip=40.107.220.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/pbZ27CS71Th5lxDLaDolzu8Ey16qrdfrWI+XVX87xGk/oz+bhMKEK7Ezdh1A4E8hya4MgeeatTygKJk8Zw5WfLWGcZJUT5NMCYksoaUdr49eXA1cSTNNfBV6XcbdidqkwGVX9XZeaC/0lgyuPhLHxFnGzLDqUlI8vG1sajHP59XZeFuLYXysijmGDyCslJDvYq87VquW8TBVfyrOKpQA3qKxuZkDHWQbWUhKX77fcLLhSdutB3j+dM4EIe5C6HujiRpOiHJXWWgbGMvyVJEneHmx3XXWrcL0OMl9CQU8FaPHodmHfJjXevnG/w9FkMLF/EDjJLaVIHEyRD6rYzrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgLcsK9eFO8eEiK5wN0BwNOIu2oZF9j4TgRrPf7cavI=;
 b=pyFLVlauCPO5T2IQ8fwbmvWJNhYN2nSE+pyEqbC4fHkv0455cEuDfaZaIe5iQLxq+Vi1XuHpoLfkTEe2yRPuHemHXFI+OeQm8PwgWsQaX0HJM5aetGIHISCgx6j2l7jc+DC6o7BXRxxqU6iJE5MrNzDF/TVD0fnYVn+zFc2dt/6xmm/PokDGLcqjRYgFcnrd3Fn6cBOsPSd90bj9/MqR9j6sw/A3QmDC7dKazZ+DRsR//Gd7ezegjDIazYVtdoHkFNXNNbZxFSYduU88i4WjyE1qkUYkkUuJ1omlUzcIUF8+D0+Br2QPoBi1I7pgwnB8UsDfSHkh9sm3RCr+lJAfRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgLcsK9eFO8eEiK5wN0BwNOIu2oZF9j4TgRrPf7cavI=;
 b=TwOtOjqs2F6XnAqIDkxySDSZNXnr9dgQc3QdoNOOR1Bv5scBf/+t+g/qexPcTkNMtedJRnHwGgIApxBUdjO+iE+OBs1DIk/yOSeBULwbpsMA+MCdXgbDIykZY7nQSlal8qtVIDnklEO6d2Z8GgSR/ffy0OtP4r0G7nuvey63GNM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ0PR01MB6445.prod.exchangelabs.com (2603:10b6:a03:2a1::14) by
 BL3PR01MB6996.prod.exchangelabs.com (2603:10b6:208:35b::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.11; Wed, 27 Nov 2024 07:26:28 +0000
Received: from SJ0PR01MB6445.prod.exchangelabs.com
 ([fe80::223:9849:bfff:b119]) by SJ0PR01MB6445.prod.exchangelabs.com
 ([fe80::223:9849:bfff:b119%5]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 07:26:26 +0000
Message-ID: <a2b41bc9-72f5-40f1-ac44-d2c495fb3dd4@os.amperecomputing.com>
Date: Wed, 27 Nov 2024 15:26:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched/fair: Fix panic if NEXT_BUDDY enabled
To: 20241125021222.356881-2-adamli@os.amperecomputing.com,
 peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Cc: dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
 patches@amperecomputing.com, cl@linux.com,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20241125021222.356881-1-adamli@os.amperecomputing.com>
 <20241125021222.356881-2-adamli@os.amperecomputing.com>
 <70dfefef-aaa3-43be-9f8a-85adc07942fc@linux.ibm.com>
Content-Language: en-US
From: Adam Li <adamli@os.amperecomputing.com>
In-Reply-To: <70dfefef-aaa3-43be-9f8a-85adc07942fc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0249.apcprd06.prod.outlook.com
 (2603:1096:4:ac::33) To SJ0PR01MB6445.prod.exchangelabs.com
 (2603:10b6:a03:2a1::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6445:EE_|BL3PR01MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: e3d8bd87-cd24-4c70-1a42-08dd0eb4cd4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVhZQ0FJU1crSW43TFdpOHpqZnRuK0JlR3ZWbmFRYmliVjVPOHZoYndURHdn?=
 =?utf-8?B?UXhMeVlTRGdyYk1wN0pZdno1T3lzVU9BbFdDN0lkeWtDTmp2T3ozWkVVRnhy?=
 =?utf-8?B?MGhxVXFjOUxqUXU5WjZ3UGF1Nk9rYU5TOVlJUE52V3QzYk9WaE1UTHVMMllH?=
 =?utf-8?B?c2FpQVpEYW9UOVpKbXJaVm9Zc005a3VjZ1ZuVnNqU0xmR3JrcDBSQmhXN2tT?=
 =?utf-8?B?bUNEV3gvSi9lem82RHhxWC9veUNONmRjeDdvVTVybjZqMVZNQm5qTWMyNWRj?=
 =?utf-8?B?RS9WNUNrOUJBdVFpZzFwYm1BRjU3NHltakUwbm4wTlRZUnd6MEdLQnp4UGI1?=
 =?utf-8?B?aytUR0U2Y3FrVERoYmZsczBTOHF2em9ncUlTbytPd0RMakRJNUcyaXBBa3ps?=
 =?utf-8?B?cEM3VnNjaVdEaWJvdFIzbFBtNWxtNDd4TTRzakpzOGxuVGQrbDFyeG5QV0kr?=
 =?utf-8?B?ajBydkliSDl5WmhDNnRFTWZsdWEwbHJaUVBHSTlVS1BPYkhZL2psd1VXMzZB?=
 =?utf-8?B?Q2l2bTBtR0dUWjBnNVNLc3lyZ3hyWkxVODd3Y2lhb3UvVW5EdGdUcHVYWkVS?=
 =?utf-8?B?MnNVNVNPbmxQYUhvZE92WEZJRmFGa2JwMjZmVlJyd29LTjJQYWJIYjR6aUZX?=
 =?utf-8?B?Qkw5NVJGbThNNzQvc00vUDM3ZFhuYmdEa0E0UE1UTDRlN1ovRTZjRUVScUZJ?=
 =?utf-8?B?NFJOOHRldWZBOEx3aW82MlFaVXJMYnZFck5tb1FDaHVEM1d3TElqNFhVREov?=
 =?utf-8?B?QjNMNThjUmk5TGRSTi9meVZzOXRiL1NEak9ETndMTWs5c2lIaEk2L21LNmJx?=
 =?utf-8?B?UndVbzMwdGNOWWw1blMyL0RUMDdlM0FsZVFSa0hybmRxZGcxS1NIL1FsL2hh?=
 =?utf-8?B?VVBNK3VwV2ZaRTN6ZzNwcjN0d1NoQmJKbTN4RU40SU8rMVB2Z0dOMXZVWTVG?=
 =?utf-8?B?Y2JMNTJXNWNSaFJuc3hnenFJZW9hVTRMYmtyU1ZlcGE0b0MrUGhwNHF5RTN5?=
 =?utf-8?B?S1poYXdHUmZYL2FRRVVaam9iUEwzTVBReHhYeVk3TCtUQ0ZYc3dUNEo0bGxk?=
 =?utf-8?B?YlNwSHBJV2ZIa0ZSUmlVRCtiRG5lZkVCTjVJQWUzWUFVY1RseXZUU1V2dDRI?=
 =?utf-8?B?TG5uWG1jZDBJN3BnOG5DV3hqZmE4Vk94cit0VVRaSFA0ekRoNVdRaW04VUtO?=
 =?utf-8?B?RlFZb29qaDVzY0YrQlNCanpSV0k5N09WYi9YSUp2RDl1ckxtY3FhcGJiZTJy?=
 =?utf-8?B?N2huTHZKVW50R01qK0o1Qm0vZUdJZ2RGTE4vVHIwdXlwa0haRGZuZmxSczhp?=
 =?utf-8?B?aDRnZnI3SlJtZnZqQW9pQU5tVGpvc1FOWjlER0lZZEJiR1hoTDhwNTlONVNx?=
 =?utf-8?B?VXpmMGVBd3dDK0MyQ2k5OXNpcjJrTUN4L3J5WWxEK2hGUzZ2TitqeC9oRDZu?=
 =?utf-8?B?aHpCcU12VnY3cU0xT1BJekpJWFlpRXZHZ1lGbFlIZW1GWXNuMU9kemd4NVhm?=
 =?utf-8?B?R2x2RGNoS0F6QWhuUUxWMzl1TlB4ekdqVGg2UWl3Y3R3bDlBSkdURi9ZZ0FP?=
 =?utf-8?B?eTJNM2NWc3JFMEhuZmQ2SC9iRkNwN0licXlDaG1MYkRyNmVmMXR6TFoyK1dy?=
 =?utf-8?B?M3AxZlNkd2FjYmZPOGFhUXJsTTRSZUlnN0VuN1lZcXdHWFRxMFFFQ0E2NEJ0?=
 =?utf-8?B?Tnk2ZzdqYnB0ZktTbzdLNyt2eDVGb3FMaTlMdndBRU5JMlczTDNnVGhiVEJa?=
 =?utf-8?B?dFFLbTE0ZVU2K2lqZFFiUnhEYmtvSnNrd053ZU5icHFyNXBkYlZKUGJaRThZ?=
 =?utf-8?Q?3m3rEpWzJ386VveRUoxIsNx946vZZ/DIzHxY4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUVoS0NEWVFjVXIrVVp3S0Flb0xDdDdIMUdTZkh6bHBkbzVBcG5LU040SEdN?=
 =?utf-8?B?S05FbWFaSFNESFZSRWI0ZXJtRk55WFhVWFdReEYwd0wyZTV2TE9BWnRDUHNT?=
 =?utf-8?B?WG9zVlZVSkdRYkJHVzJZWGFyTWFGTlRrcDV1UmcxVGtaaHVBbldqSGp1S3pZ?=
 =?utf-8?B?RUdHMmxJeWcyakQydWt3Rm8yVnI2UlNlQ045OTlvUUMra1ZHN3k0OWJUWXJZ?=
 =?utf-8?B?WWFRRjFkenQ4dHJENGExckpuVkxNci9zb05ESnVPbHJ6L1JGQkxMd2NWV0tT?=
 =?utf-8?B?M3VGYldReFZ0TnlmWXZ2S1IzUDhlZml1a2tBVzZtN0tjKzJaRzNiSnlSUHJ3?=
 =?utf-8?B?S3dlL1FUKzZrMHRQWFhjSzZ0TktjMSsxVkRVMzhwL3JxTlpBRFlwN2dlRFV2?=
 =?utf-8?B?alVsSjVraHVpTXhGQlVrQllUS3A0WnhhbGl5OUpiZ000cEhYczVQSjN5Q1dZ?=
 =?utf-8?B?NlkvODNPc01lN1duNzJ4K2V1WldNZGh4N0FNczVTU0Jtcm9FUVh0Y3diSWpY?=
 =?utf-8?B?UnhDbGErNWFSdWlrTjZPcStGYno3bTBnTFhXK0xLNFdWSUN1TThpN2hUbFJn?=
 =?utf-8?B?ZDZPbDBRK0RaTGZnWW9tc05aZU5QZXJrT21QaFVjdjJ0K01WZTFidGIwOTFt?=
 =?utf-8?B?cmtjaUZ4Uk41MEhzMDhjNnVtM3JFWDhQK2lCZmFERjl2eGdmZEZOWTFjVWhN?=
 =?utf-8?B?ajljQndmc20wSmxaNFFrTlVPc1VlRjlPTTJsL3J6UGFqdmVqVUEvRHZpd1hn?=
 =?utf-8?B?WFMxUnZ2elJaU09hb3BZeld6SFJtVkd5S0VmR1Vnb00wRkd3U1VxNUhtcmtx?=
 =?utf-8?B?N0tubEN0aktiVU40VGs5dzV6Z3VvNEp5MXdWcHhIR2JGQVZ2ajdZcHVnUktJ?=
 =?utf-8?B?ZGdkMGZsV2krOXNwK2ZSK1ZoaHI3K1ZpTmtiZTNETXdtUkc2UkErSXZaYm9a?=
 =?utf-8?B?TEtBcFhyUVhUbGxOTU53a25mMVVmSk01MEtpL2ZuNU1UNi9BTGRnQlB1dmkz?=
 =?utf-8?B?bnBSeG4vdGc4amh6VjExb3A5bU1NNk5LUTlrZzJIVzBPOWowekZzcXdmdUhp?=
 =?utf-8?B?dEtwRnU0bjVzNkJLa1czWVQySzZ6QUE4dldERFF0a0RadDlRb0VrRVpxYTkz?=
 =?utf-8?B?Zmo4djFVZDV1cWp4MlBuYUFodEs3eEZJQ3lFdks4K3Y4UHZpZ1VqbUYxYzFI?=
 =?utf-8?B?anRMTm5Qdmk5c1k3UXpkUGs2Y054eHZ3RTJOM09iNVg5MnlGaEo5RGJHWHFi?=
 =?utf-8?B?NVBEWjhEbVRUam5EMWhPVzhTZHFrSG9aQTRQMkpDNEd4WUNBOWk3Ukg2YUpz?=
 =?utf-8?B?STJBcnY0c2VKZEMzdDFQdjR4cnR5NTV1RTNwUkRLRFl5bnptNlg4OXRIVys5?=
 =?utf-8?B?K2lCcGRiaFd0RjRXd1BYc2FOb0NDY05iNlpSVWRWUmpwanlDYUpFU3RGSTJ0?=
 =?utf-8?B?bUlBd0dsL2pBbHQxVXBjbXNWM1FZOVE0YmFFNlJNalh1eWZJRGZXb0gxKzlF?=
 =?utf-8?B?Z1g1WVA0OHRRMXFIUnZLeDUva2JMN1loWlZmVVFMTUNsRHRtY2hhOHhTT1p5?=
 =?utf-8?B?ekd5UEJoMGNXVkUwZk5HaUlQT2puRXlra05VN01OWGo0V29qK01LT0V2Uk5x?=
 =?utf-8?B?RWdSSU9yandaRml3emVhdUE3ZFI4T0JLd0Z3ek5sb0RXaWpzT08xT3RNM3oz?=
 =?utf-8?B?bXltbjlxUnFEQkhoRUc0dG1sK0RDaEJNRXhFYnM2NjgzZjZoQ21MMUgzemk0?=
 =?utf-8?B?RE5BTzdLUnF3RmJNa0RqV1hkU0VtV3cyTmNXR0RHS1dzazlSQWZJNFZHdm1x?=
 =?utf-8?B?QlJFbnJlZEIyRW9YUmh2Z0N0ZzRwelpFNzhsV3F0Zjh2SytXcmQvT1pvWkhZ?=
 =?utf-8?B?b1lsc01WSERrQkM4amFpREZ1ZUs4NEVvUHBkUDNEZGpnNEplYTN4NkZZb2Vr?=
 =?utf-8?B?OTcxNkZCbVFZU2NKVFliem1pYm44L1RtQmtvOEZGcWZMRGNWVGxjdDZ4aFkr?=
 =?utf-8?B?TTEyUlorY1VXQVBPQlNQOXF6amROKzBuem9BTG92WG1OL3hHQUxpYkJ4ZXlm?=
 =?utf-8?B?djc3RWUwQ21tbXU5czdLbDZjbjB0ZjM5UzJLRFVSYVZpckcrV1ZqZW1LSy96?=
 =?utf-8?B?T01Ib1pDLzZhS3ZXRlNZVmJCYW8zNFdzQThjNmZYaDRuSEpzSmNjdmsyQ1BN?=
 =?utf-8?Q?8BZkXLKAvvUlffXwQ0pAl7Y=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d8bd87-cd24-4c70-1a42-08dd0eb4cd4a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 07:26:26.1194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ykV7vZNNB7uRLywUyHWkgtiasYx0jR1iKv2NZauZISKbf7OjbnE4Ihkht7mrxEg0n2OBN9/yYNauLun9/FkD1fO1AlnT0kpCSb42k7OYel+wQUelJcHjeInsXBEIhfi1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB6996

On 11/25/2024 6:16 PM, Madadi Vineeth Reddy wrote:
> On 25/11/24 07:42, Adam Li wrote:
>> Enabling NEXT_BUDDY may trigger warning and kernel panic:
> 
> IIUC, this happens due to a race condition between choosing the next_buddy and
> dequeuing the task from the runqueue as soon as its lag becomes zero, thereby causing
> task_of(se) to result in a null dereference in pick_task_fair?
> 
> Correct me if I am wrong.
> 
pick_eevdf() may return NULL, which triggers this NULL pointer dereference
at pick_next_entity():
	struct sched_entity *se = pick_eevdf(cfs_rq);
	if (se->sched_delayed)

Enabling NEXT_BUDDY is more likely to trigger this panic.

I added another patch to check return value of pick_eevdf() in v2:
https://lore.kernel.org/all/20241127055610.7076-1-adamli@os.amperecomputing.com/

Thanks for review.
-adam

