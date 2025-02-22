Return-Path: <linux-kernel+bounces-527248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4083A408D6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 14:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1626C19C3D8B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 13:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CB813AA20;
	Sat, 22 Feb 2025 13:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="WDQehC//"
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020117.outbound.protection.outlook.com [52.101.191.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAB55383
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740232616; cv=fail; b=BXUVg8N0qdwSSWwpSm5iTRIeciDaMFE4F26CwgVdb0jmWeO2jGwAIM4P0SGsk3xx+luecKAJiA/pqxvgfbUk4uQQdvk0ygnn0lWYDqeGiV5kzY44QlB/KqLeRM0xiLzqtDo0Vd7zd0LGSTbdkcyNoDhdFmGny2d7vkxYaQeA7wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740232616; c=relaxed/simple;
	bh=J6RDPEVA4d9h6UbK56o4+yAgLYcjnXsiI6rOhnu1VDc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tyhzbpGxv+KZN9SR9FJ0E7N8EYk+B9QmYITdf9luGMM+AhEMZkZYaVb5XOQo6qTyK7/55vMU2vR5gV3y8THDWlWZv8jWsM2ozM0nvJTFpRR14Li9IZ0BmpD6gX+ZJLIwOqOL3UrTcU/SssqF4/Aekc1dz7WmpRQe/ht0DA7VLBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=WDQehC//; arc=fail smtp.client-ip=52.101.191.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VizrKTZmR66xzCF3j5K7FWPSX+rNQN31v5l1RubeiKIQgQTvPoYsBIt74bw8+zj93AMYaTfpEr1FFsDR/H01awvp33+9ymcFeAjQrj7yaVmV5VYeSDPlvH83Fr7YSlfKDJWOKM+VFlCiDFx/G6ZcLlspCInHqYAhmA2ofCRjZMfqeTDlA/e9P2a3f0hhevRjIIPDYUaCrRjGB2U2yLHXsfCOybErtg/Rn9qLorhVqP048j/kaNi6S9GiR6jPN4nuokkgj2SAekddX7wVU2/yYK/cdWXmYepJbbmoG8C9So1Wux9oEyy0K0iNwB6nuhTK0goAI8lAOFaj3rDxqFvteg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BygBxtVr9/HRPiZbTmLLoAGvCggHlJZ2aKwQUNR+2Rk=;
 b=USyewCbRwVMQ7OTq2mS6edGzra4OmhaKjF6TkR8TzFbHAJb0nOmvVAJUtk7tVns+KhgYQkADwHyQRxLu9jPrw9bCrvKgXTuwO4wYjhTEm2sYxEl4dlx/a7FOhN/YebS7NeVpXflXAhtCaJ+JxK1TrPBs3JW1tFsGy0iGEvFuBtJCzrfGXkjOPW7t2/WpqdJF2q0T016XluxKSYb8kHWecx4ogC5jCflMc13MlgAGCDyxMGQPDrf8tEYew6mHH0VQeMacXzP9F+kvuCFz4x3vYkr6pxkvOO5pHtOqAPjCTUKerz/waX9rErAT/nuauscjn1pR6uDAY6WaJvx0r3EBPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BygBxtVr9/HRPiZbTmLLoAGvCggHlJZ2aKwQUNR+2Rk=;
 b=WDQehC//2O6t4cX8t3HYJ10150mP5T7tth1m6USJrNlMjfSBWQnbZBsnObfoKDlE2rrnbwg7oRkKInowRVdC1rquOLHJLEq7gs6xddAOyHyoEOFVtLkZG9fcwHuDR4C3ldxRiMtu2rTFSXNGVwShSA2cmKwh6i7onPF2x/PAoV1pFjLlDA9GzRBzplolRILUQUERTLgvX+b4dRqb+lFSTfrZMAi+TvT/FKkG73PGGqlVxxD34UP53aKp8W3eBRGi6nfQUM+LbMwd//OVMhV1SCxp1a+xphynWyqlzBIgMgl7Xbl5BXjWdhx306egirMknI0d5RS9GsuE/6BibuB+GQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB9562.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:92::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Sat, 22 Feb
 2025 13:56:52 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8466.016; Sat, 22 Feb 2025
 13:56:52 +0000
Message-ID: <974359d5-43f3-483a-89cf-79e9b4965785@efficios.com>
Date: Sat, 22 Feb 2025 08:56:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rseq: update kernel fields in lockstep with
 CONFIG_DEBUG_RSEQ
To: Ingo Molnar <mingo@kernel.org>, Michael Jeanson <mjeanson@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20250221191401.464648-1-mjeanson@efficios.com>
 <Z7nQzOQT_-9-Rbr5@gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <Z7nQzOQT_-9-Rbr5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0138.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::24) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB9562:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d75d782-a6d4-4ade-9340-08dd5348c242
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXloQXdtaHlCeVBzK3lvU0VZQ2VmQ2dPbFZBTHdyUVY4ajk5eCsxOXFNTXNs?=
 =?utf-8?B?NmRDZkJJWXNzSnVJTGJlY3Z6TU0yNmRFRnArdWtadlNSajd6OGZZbnhGUTFp?=
 =?utf-8?B?K2NaR3VlM2dCeXBaRk14UWdvbTEwZ1kzVWJGa00wRG5ZTWUyclE5QnY0MnRa?=
 =?utf-8?B?NVVtbUhaUnQ4WlM5dXo0eEI1Wmgyb2x1dzBkNy9mSjlIeHhqVk04blJoRzlw?=
 =?utf-8?B?SnMwdEdJVkNpUEo0aVhGcnl2Q0N6dVhlUzYwQ01rM0lKRkJQVTdoV0pBdlZM?=
 =?utf-8?B?VmdNNFE1VXZ2YlBvS01BNHhFVzdvVE1YbU9wdS9TSU9US1dTUVl2UUpKaFNh?=
 =?utf-8?B?bUwwMmJIcmx6V3M1MUVpSlBmY0dpd05aOXdxK2dhUU1GZUkzY0tQR2pUcUFE?=
 =?utf-8?B?NlZreFpzZFZzTmVXalZNaG4vY3ZsdkFSdUR1S1UxeEI1K21PVGdjZ3RtK2s2?=
 =?utf-8?B?clpWemFTYU9TeCt1Wk1sWFlSSSticjllR3I3R1dTeHRPYXZ3ZHpLYnVzVU95?=
 =?utf-8?B?ZW4vSkdJMU04ejVlZ3ZnamZOdjJVY0ZFa0ZLazVzUDZzbjBCYkRma1dLZ0FY?=
 =?utf-8?B?NXA1SkFUeDFGbkFwaUlBdE5ONUVFNHE2YW9jdTJ2R2ZNWnlROWY2S3dQY0gr?=
 =?utf-8?B?WFdGM2N6VU13QkN3MVpmbzdPTTBaYnVRQTRneGpRVFlnSi9YOEN4aDY5VTl2?=
 =?utf-8?B?U014bU92UUdHK2NNOGlrcFpqUm8wdElQRU1aczdHYVhvMThMUVBiOGRFQ20x?=
 =?utf-8?B?ZmRFelZ2ZUpBRjNCeXZER3RpYkd2TERrVm5KcUNBL0FqcytoeWRKSFhzS09R?=
 =?utf-8?B?TFpSRDE1TkZRcUh0djl6NUNGczZpaHRzd3N6ZTBtWGx4ZHY4eXY5bTA1SG05?=
 =?utf-8?B?SE5BUUVXWUZDbFE5RDBmWVA2K1plZ1gybmRpWDNWRDJrbVU0MjRoRVdPMC9i?=
 =?utf-8?B?VzFpdFl0V2FkdEgyU1Y2c3h3YW93aHh5dWswY2JhRUFMWncxa1dSV25GQnNN?=
 =?utf-8?B?cEp6ZGJ4Z1RvL1ZnOWJjaWlmalhjZkhiaFZqRHowVXIwOTBhempqVDFNM1lL?=
 =?utf-8?B?QmQ2MjZYS3dUTlhsbnd5TmNjVzVIbmdrMHc5WFQyakw3SXN3d1RvMzVqZjNF?=
 =?utf-8?B?Y21qbkNsK2JjM2taT1cvT2UzWXN1Wk5aUVd3UzV4cVF5ZXUxY1F0clRqQ2do?=
 =?utf-8?B?NSttNURsek1ieHRYaGMxUnF1REdndWorekxoVitEQzlTMFJGdlhIZXFUR3lT?=
 =?utf-8?B?UU5NdFczQlhZNG4zeXhBRlF5anRyZlFDNVZ6dkgzSEtzaGs0UnVmTTgvemNL?=
 =?utf-8?B?NE4wclc5UDRQTkJQUVk4bmg2Rk5CcUF0dlZmeW1iKzNIYXU1OGRSUWp1am9t?=
 =?utf-8?B?ZkNSUGhRaG5sNUpNY3J4ZjBYemg4blNJUzN2RU1XaExqN2ZUQVN3eW1kY2xH?=
 =?utf-8?B?UkhMS0RwRk5WVFJQWENIMURuWmpVazhCNDVpM2JTWHQ2R1ZDZE8xY3FvY252?=
 =?utf-8?B?bUxyMXE2TE9WME9Ra3lOakpFRk5uMlhPOVlvaEJwbzdXOWh5bXAySUs1RDJK?=
 =?utf-8?B?NUducU9ORGxVNXc2YjlpdmhLbTNuK09SeEcyNHRBcExERHdGREErcUVWVkc0?=
 =?utf-8?B?eWNoenhGMVlTTVRLVnVsaE0vZXpvOWltWFdrQW1jYzdEbHFiQU4xSFk4K1pi?=
 =?utf-8?B?RFZsbm9TekcrSXphRGVuMDJCMjQyMDU3dEg1elNFUHZoMU5lc2NpZEpsV2xl?=
 =?utf-8?Q?EudbuP4MMuXVcqpsNs9kP398GVuZoTAFRE6gQAv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVdib3cvdVFsVGE0S2NxQnNxQ1orVXBaQUNFeTJBN2RSK0FwNmhraFQ0NlZY?=
 =?utf-8?B?UG92VmxmZ25MOVFiK3hkQTJvSjRyQk9yN25sOWIxRlY5VlB2WnJ6Y1REditE?=
 =?utf-8?B?alBMd250clpMQ1RoMVh2UFJueVJqZmVyWW9vV2laQzN4TmhuL3E4cTJXR1Fp?=
 =?utf-8?B?VS9Qc2x6VU9OMytqbnlueEU0ajVzLytSenZLcEE4MWJHb1dwK0NodXFpMm9G?=
 =?utf-8?B?MWZnKzBUYnpreUhBcmtES2xOdlYyNWw5SkRKUWJ2bkRJWlU1KzhSK3dqU0Z4?=
 =?utf-8?B?Uy85V1hKQzRjWnZpMzR6YUF0Q1M0MHBpMW1DTHBYQXBrZk9Ua1ZpbEMxNGsy?=
 =?utf-8?B?OU9xb0p6Ym1qQ080ZWJlWXZVRmJNVjd3Vko5V0hiSXp4QWFDanNQMzRyeGZK?=
 =?utf-8?B?dXEyYU5zaUpLWk9mbjdiSmZKanFkVmthMGNGeGtGNk1BRDNFaWJFOUFtZlhi?=
 =?utf-8?B?QnYraW1rZy9zaUlVcGVBVURRS211REF4cWtnTzU2OUdkMitSUHZ0c2l3dmdr?=
 =?utf-8?B?RWQ2Mnk3TXdPMG1MVFVkOWo2cjUyKzZFRU9oUjB1M1pZL2VtUFk2cDRJVWxL?=
 =?utf-8?B?RmxXaEllU1ZmRjFvd3UzT1NpTjVsVHF3WVdCMXFkM2tja0tmZHpUVkFWS0ha?=
 =?utf-8?B?WDd6dW03UmhpT1lHdHJsUzVndGxGek01VkFjb3FXZmo0K0poMkxTNDE3MHJT?=
 =?utf-8?B?b2xIMnN5ZXJGdFgrNFBEbEN3RjJkVnBqT3F0V3NEbWtWd3hLSzBkTXc0S25k?=
 =?utf-8?B?YzlCdXd6UW16YlpVcTVRT0hoRDZwb2had1BYZVNHdTd4T2NpdjlCc0pQOWlQ?=
 =?utf-8?B?UG15SDVYOXNJR2dZUFJrL2Q5TnBuMzVZUGhSc3FPSnhxYzZWbjZpbjZLdkFh?=
 =?utf-8?B?aUtsTGpvNktJZ2U1cUcrOUNsNllYN3psQXlvWUFMSUVsMHZrZFNkN2NSQVFY?=
 =?utf-8?B?a2FIeEV6bVhRd1RickpDR2IwaFZremIwQU1YeEZmeHhUTUx2UkxQZXFRaVJv?=
 =?utf-8?B?bFhBWWRqb2V0NGtTLzF1NjhIaUE2NXAwL1NUNzRJK3MzYWxxYUZPOVpIbXpM?=
 =?utf-8?B?UHZJRDBMNldQaGhFT1BEL2hHb1NveGExOS9ZQ0M5L0hnaHVoWDFpT0t0cDlm?=
 =?utf-8?B?VDJtNzc5VTJXSVNOeVdMVndKUmg2SkYyc1oyWk9uTmZnR2xmZCt3QWZyMjVR?=
 =?utf-8?B?L0JMR3JhRzI0Rm1UQjY4ZXdHUU9sRzlQQjVsa1Z4NUxtVmNyNU9vQU9VbURB?=
 =?utf-8?B?REV6NHk4SlVRbFlpSEZtUDRYZ01qV1M5Mmg4UGk0cVNyOXJvV0tEUFd6dk1i?=
 =?utf-8?B?NnJpcmdqdi9lNURPdFM3dDRsWENoT3V4dFg1R0E5TVI3T09pa3drcGdJVzNK?=
 =?utf-8?B?SGJ5WDVkMVpRbXRIWGg2OEpTZzhiZUU4d1QvcWNXVGNtR1dlSDJVQW5ZRldJ?=
 =?utf-8?B?eFpCejZlSVpkOFFBUlhJN2FWbDdXeW5uYVN0ODJFODh6cjB2Zm12dUVLZjR4?=
 =?utf-8?B?eFNMdDhWT0RsVlpwWWV5OEhzbW5DS3dSNUk5RlpITjlTeC9sa2hTWjAyWlZ5?=
 =?utf-8?B?WXNyaG5WVTlxdkw2dzNtVGxNNnNJbEJlMFE1bUROWEt0QnlWRFlFVUtQaEc2?=
 =?utf-8?B?U2VvSkNtaklUT3k5VFE3eXBiUmNmQzZrT09BeDFRQ2xmODNLVkVrL1NOZ2Za?=
 =?utf-8?B?NFBBZDE4dU5tWkc1VTNpcUN4V2gvVU5zVWRYUlpVVk1tSW5ybWV3YUh1ZG1m?=
 =?utf-8?B?Znk0VWJSeWR0Umtnb05mZlpXRjNyN3FXTm1wSk9rOVNkRDhqZFVWWlAzU1F5?=
 =?utf-8?B?dXBPTzFMQktVOWJZUVZic1JWM09CRTRNY05INUJaSXhZUTZac1d2RVoxR0xa?=
 =?utf-8?B?UVhEWW9kTTJnYjEwc211UGJDV3hZNlAzY2JlZktCYXpaQ1FqK0JWNDNCanl5?=
 =?utf-8?B?bld0OFhYdDFic0h6OG9BOWl1TVVnckQ5cmN3cjVLQTJEU3dkdEc2Tm9xaG95?=
 =?utf-8?B?N0EwYTBmSVBZd2NpYlBSLzRWZlUvdmFzS1NSazE2RTI0aS9tQVdvcy9pZHQ3?=
 =?utf-8?B?aHdmT3VlS1NUa0hTN2F1S1FqRkE1dTBiamtoTkVQek9rcXNkSWhaTi9XT1M5?=
 =?utf-8?B?WXdtVlZXaWsxR3FCU2t0amFhaU94UUlTOEJPbEJ6cmZ3Y0x2bG90OUtwdVNZ?=
 =?utf-8?B?dU5UWDgyaVJXQWxHTzdnbEhtQzgrZG5wYy9hVkhpOVNrTkRIa3Arek80K1hj?=
 =?utf-8?Q?FNIHVonmvOJm+vuWnCfTYJWnjDczjnaxBfS3Dqey14=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d75d782-a6d4-4ade-9340-08dd5348c242
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 13:56:52.0285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BRsLpdATKQtsn0NCINbvHRbcV47s8RjZi1WOyJtcnAjWa+lxnc04sg1aLZXtify+kBdI9+LmaX5cPOmmqfa3NEKPK9BIzItCXv8eu5/F2wE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9562

On 2025-02-22 08:27, Ingo Molnar wrote:
> 
> * Michael Jeanson <mjeanson@efficios.com> wrote:
> 
>> With CONFIG_DEBUG_RSEQ an in-kernel copy of the read-only fields is
>> kept synchronized with the user-space fields. Ensure the updates
>> are done in lockstep in case we error out on a write to user-space.
>>
>> Fixes: 7d5265ffcd8b ("rseq: Validate read-only fields under DEBUG_RSEQ config")
>> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
>> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> ---
>>   kernel/rseq.c | 85 +++++++++++++++++++++++++++------------------------
>>   1 file changed, 45 insertions(+), 40 deletions(-)
>>
>> diff --git a/kernel/rseq.c b/kernel/rseq.c
>> index 2cb16091ec0a..5bdb96944e1f 100644
>> --- a/kernel/rseq.c
>> +++ b/kernel/rseq.c
>> @@ -26,6 +26,11 @@
>>   				  RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL | \
>>   				  RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE)
>>   
>> +static struct rseq __user *rseq_user_fields(struct task_struct *t)
>> +{
>> +	return (struct rseq __user *) t->rseq;
>> +}
>> +
>>   #ifdef CONFIG_DEBUG_RSEQ
>>   static struct rseq *rseq_kernel_fields(struct task_struct *t)
>>   {
>> @@ -78,24 +83,24 @@ static int rseq_validate_ro_fields(struct task_struct *t)
>>   	return -EFAULT;
>>   }
>>   
>> -static void rseq_set_ro_fields(struct task_struct *t, u32 cpu_id_start, u32 cpu_id,
>> -			       u32 node_id, u32 mm_cid)
>> -{
>> -	rseq_kernel_fields(t)->cpu_id_start = cpu_id;
>> -	rseq_kernel_fields(t)->cpu_id = cpu_id;
>> -	rseq_kernel_fields(t)->node_id = node_id;
>> -	rseq_kernel_fields(t)->mm_cid = mm_cid;
>> -}
>> +/*
>> + * Update an rseq field and its in-kernel copy in lock-step to keep a coherent
>> + * state.
>> + */
>> +#define unsafe_rseq_set_field(t, field, value, error_label)		\
>> +	do {								\
>> +		unsafe_put_user(value, &rseq_user_fields(t)->field, error_label);	\
>> +		rseq_kernel_fields(t)->field = value;			\
>> +	} while (0)
>> +
>>   #else
>>   static int rseq_validate_ro_fields(struct task_struct *t)
>>   {
>>   	return 0;
>>   }
>>   
>> -static void rseq_set_ro_fields(struct task_struct *t, u32 cpu_id_start, u32 cpu_id,
>> -			       u32 node_id, u32 mm_cid)
>> -{
>> -}
>> +#define unsafe_rseq_set_field(t, field, value, error_label)		\
>> +	unsafe_put_user(value, &rseq_user_fields(t)->field, error_label)
>>   #endif
>>   
>>   /*
>> @@ -173,17 +178,18 @@ static int rseq_update_cpu_node_id(struct task_struct *t)
>>   	WARN_ON_ONCE((int) mm_cid < 0);
>>   	if (!user_write_access_begin(rseq, t->rseq_len))
>>   		goto efault;
>> -	unsafe_put_user(cpu_id, &rseq->cpu_id_start, efault_end);
>> -	unsafe_put_user(cpu_id, &rseq->cpu_id, efault_end);
>> -	unsafe_put_user(node_id, &rseq->node_id, efault_end);
>> -	unsafe_put_user(mm_cid, &rseq->mm_cid, efault_end);
>> +
>> +	unsafe_rseq_set_field(t, cpu_id_start, cpu_id, efault_end);
>> +	unsafe_rseq_set_field(t, cpu_id, cpu_id, efault_end);
>> +	unsafe_rseq_set_field(t, node_id, node_id, efault_end);
>> +	unsafe_rseq_set_field(t, mm_cid, mm_cid, efault_end);
> 
> Could we please name the new wrapper rseq_unsafe_put_user(), to make it
> clear it's a wrapper around unsafe_put_user()?

If we do this then need to make sure the order of arguments becomes
similar to unsafe_put_user for consistency. If we look at its macro:

#define unsafe_put_user(x,p,e) unsafe_op_wrap(__put_user(x,p),e),
we have the following argument order:

1) value (x),
2) pointer (p),
3) error label (e).

So far unsafe_rseq_set_field has:

1) task struct pointer,
2) rseq field name,
3) value,
4) error label.

I always find it odd that the "source" argument comes first and
the "destination" argument comes second in all put_user() APIs,
compared to memcpy, WRITE_ONCE() and all assignments (e.g.
operator "=" LHS vs RHS). Choosing a different argument order
therefore made sense with a naming different from "*put_user",
but not so much if we use a derived naming.

This argument order oddness was actually one motivation for using
a naming *different* from put_user.

We can consider "task" a context, "field" as destination
argument, and "value" a source argument. So if we use a
similar approach as put_user, we'd have "task" as first
argument (context), "value" as second argument, followed
by "field", then error label.

Thoughts ?

Thanks,

Mathieu

> 
> Thanks,
> 
> 	Ingo


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

