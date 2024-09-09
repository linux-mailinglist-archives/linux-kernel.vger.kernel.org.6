Return-Path: <linux-kernel+bounces-321608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53020971CC2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70CA41C232D4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0581BAEDC;
	Mon,  9 Sep 2024 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="mdhOA4Vm"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5AB1BA29B;
	Mon,  9 Sep 2024 14:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725892650; cv=fail; b=rgq1eol9wRwUjhKeU49GnSagxhjqhmOlk5qfcjlBxXexMpSnN80RV7M/MIalqAUb22x2IcMp7oXGDoBY8Az3A7r+XEzMBrlfDgsp83Zt73e4KIR8tmhqpfKbtwCqZmAsVzOK/9uaWIRtmWNs7mPglo5n/Ag3W+TgvZhOCf6Yn0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725892650; c=relaxed/simple;
	bh=IikorwzJiaCbmyU0NkYyslM5CgPEvQiNscVgozpZeLI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QOWhDwfCAwjft4c93t1wDyAv4bt9yBSIf1ubKkKptafpLHiOtB6TD21P8CEmZhsYo868DijBknT93YKlo97PFTYT2nKZ4NwondYHkVhFHpOJJxULLp9/4w22exsPjGHaHUXRCe7a1y1TBAx0wStNWxxq7EkVUgvZUfw6aEaNOM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=mdhOA4Vm; arc=fail smtp.client-ip=40.107.21.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3RrhrwVI4Dyxvy6oh3y95JDo2EIA4zV0YafM2T2pUGzcyVqEAg9V56ZL7cLQGR0PBYeTSWyI2DWd7wrC5e5P8WagOGrMlOpHcu+MaseUi9A6WsXGZmVbeZJgFjyGs2Lazd8nMulU+bO0gz2ecopM87GDgp9AHt8RHIUYvq1ot+oDfdkOmfjXcHTcb1KPlkdHHqGoQvr0p01lDbXNs2p3DAAzo71eTuWf4BhhZdvcVLTV8Rae7eO0N21UQaR4DyZ8gMurVgg14IRLovO9I7jEEOdrdoz12a77YHSAl9ngHQaKnjdxmtjMDhq56hgG4mFCLvO7HFfbKTeZW5cEtSePw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKvjOluFb7Zgumnb1GcuDLG036d5wTbFs7A4o9vPQyw=;
 b=EiF/wOH6BZ9BI6++bOnVwGMOgmwKVdUENwLqqxgRQxUKxyt3FzKLVr/4cjT1lN56NzUH6GChoaoOBfhgrgAMimnhBoJoEOvT8a3HW0xrWWPVIyWOiO+m3gitDZ1TQWZycWpUKccF9cHoE/yg167zwAsREcEYyvuZUsnLEiZYpjUusbLaxSp5P3XSQcJpFm/r9v66d/+ABwhm/cJ3EniWq0bw2ZGofWCgLZq49hYcrMmPIfJsFd58Rv0w94WqfhysjHq8nWnvnFh3FF/xJz5xeMIsRZVdD0gVunO2qvhbDJ1Gk6gE+qWS27dNqaY9vzEVhdv8sagDgIzSu0QsR8DqNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKvjOluFb7Zgumnb1GcuDLG036d5wTbFs7A4o9vPQyw=;
 b=mdhOA4Vml5QgYWDE3tD6Op8TefbYs5WMBJnWEQzp1V9/5gzCqsz4RBUR5t9212SD50tgZjYETkRuSRBFgXsm7AW9CAcUa5rC756WMpaMnpWQhC6cc4/h55IbZXKPWFxBpzF/In4IcYb/frAtNDzBn86zi0eA9ePxdHkjmKnp9YexuQpjuydqsUgGSMHqCrZtx+R8/Kvo86bLm9T6pB/+4otBgBd7qVsfpZMGFZHJQBGloKkwvBmI+rNPUf7ZHvrVeev5gYJLS95gRHuJAO7/U6oKdYNpUjmCsp/WIhckp6Aki23SnWj8D506hz+pBQ/Oz/8XPW6YbI4ehViNjIoOvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7036.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 14:37:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 14:37:24 +0000
Message-ID: <2902ad2c-7da6-4bef-9586-d795ad9b0728@siemens.com>
Date: Mon, 9 Sep 2024 16:37:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: serial: pl2303: account for deficits of clones
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <a07922bd-4550-41d8-a7cd-8943baf6f8fb@siemens.com>
 <Zt7q-5kk5SPgE7P4@hovoldconsulting.com>
 <5ed9df75-c45b-44fd-8eb1-3cc9c6b0001e@siemens.com>
 <Zt77a-LpTSgyVx57@hovoldconsulting.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <Zt77a-LpTSgyVx57@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0011.namprd12.prod.outlook.com
 (2603:10b6:610:57::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ddc0bc8-e059-4d5f-deee-08dcd0dceb98
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3pITGhaYTBSQUNiVUpuak5rZzRabm9UaDBiczNnZkJsam1MU2xTazRjaXhC?=
 =?utf-8?B?T1NNa29uSlVka3lWWDhLMFhIaHZqV1V1ODNoRlEyb3FYUWM2ZVNSMjdUZVRT?=
 =?utf-8?B?VG1TUDZjZTVqYUtheC9OVHdIL2VTeWhpUUF6d0RSSGg1TWVIS3JNaUZmanJN?=
 =?utf-8?B?ZFJVMlNrbTBhdzZMUi90M2xQTUhmRFkzNnVlZ1Z0dVNUcTVrQk96TlhWaFRM?=
 =?utf-8?B?RUVSNmJFQWJVNndRczRIL3BHVU9xUDA2SkhGRGxaaHYrSVRVbE1WZ2ZPb0cv?=
 =?utf-8?B?S0hIVnV6ZFRreTdpbHI0dHhrUlBJWEcvRWU5WWhoVXp4UkVQVEplaFNPdk5L?=
 =?utf-8?B?b1VJbVhnTzBiMlFjNEJ1YmZHZ0lzTlJZcWh6YWRmblRiQlp6clFaZHBsSE1P?=
 =?utf-8?B?NmxqbHJNdGhBV20yOEsxalVyK2x1bWt1VkllcXVYT240UmxGMi9QNlZpTTFu?=
 =?utf-8?B?c2VHZUdmby9ES0lvckZpZjNDZ2pBYkIvcVBaSDFKTHFQSkRjVVFCc3JDemh0?=
 =?utf-8?B?UHM3OVJxYzdIY2lrV3d1MmpQN2NNVHBqQkd0S28wN1I5UXZYSVgrQ29rRUtJ?=
 =?utf-8?B?QWlJZUhJV1BZeEZGNFFic0czSXNHM0owczVoRlB6K3dHcXZ5UmpTbHAwM3dI?=
 =?utf-8?B?MCt3cTlyWHRIdGVoVmtTUGU2MjFTcEFCK0s0OUFHaEN5VC9ZbzVYTEVOQVZJ?=
 =?utf-8?B?M2tud0RlT044K1VpbjNDbkNBcldqU3NkdXk2NzRqWGYvUFBjcmZYU2hSaFFZ?=
 =?utf-8?B?dlJzRk1BdzVhTjU3aHA3L01wckhFdmVSMnhsd1lKY2ROb25IVytHK3dnckZO?=
 =?utf-8?B?TlRnZlppalpBVGFVbnpLcnZ2THV0TkJKaDVzNXRHN2N3TWEvMG1PMWZnaWpu?=
 =?utf-8?B?Z3hBV25tZSsxVXdXM3hoNmN2TVVNQk5RblBVU1hBSHhXbnBZYXF4WWhwMStp?=
 =?utf-8?B?elJUNVdXZi9vSStxRmJCWmVteGQ3NGYxSDhYWVhtaDMrVWZzb1M4U2dxTXUz?=
 =?utf-8?B?a21BSW9tYzVtQ1YwcElnTit4cEtOMGpGdG00bHpzZWN4UThzYUZGeHhyN2ZE?=
 =?utf-8?B?T3NyVlB0ektNUS9BRjFlbW5HZDBLaElMdEhMbllLNjRleENTMzBkN2hrRTZo?=
 =?utf-8?B?Rnl4NlFCeklmdndOS0pPZEJibGZueEJVVDZtN0t0VFlEVFJuUGRPaFFJNk1Y?=
 =?utf-8?B?SmlBNHU4SFVuU1N5SFh5SERXZHZDcUh3YjRkdnFWdkFDTWp1ZzJNNkh1enBV?=
 =?utf-8?B?OFJqRzgwWlQ0MTMxWUM3Ym1ORXdEVHlmN004ZktpSWg2aSsxWDdSSFc5aDIv?=
 =?utf-8?B?cUphazRES3JCLzl0dFNHVmpkTEJmYkNXMG5qSHYyWWx5VndxQ1ZVWmpTdldN?=
 =?utf-8?B?VDQyUEtoT3hKUmNNU0UrQlk3S1NTYmJEeFJVZnpvYkFvT0RGTUJocG05U2p5?=
 =?utf-8?B?dElzdzE3ZWJUYXY1ME85dEdheWFlTHdkQzdEVXVWaG0wTDZuenY0NFpreXFR?=
 =?utf-8?B?ajlYZzN2dkIrUGJ0ZE5Wc2ZWVlNXOUtueXFjZURPcHZpV2RxUjIvMUp5Q3Z2?=
 =?utf-8?B?aEZWSUd0RURUUlVWdzY1TDZXbHBibUFyUkdKNFpYMVB5N1FDN3hDb1g3RzE0?=
 =?utf-8?B?c0lxSDdUclVtWXlYVHhQN2VkdmRxYnBTRE1sb2dZeGkrTGhNUXlyS3lLWk5J?=
 =?utf-8?B?K1lGTVVUdm5wU1RUSUF3Q0Vxbk5JdDNXR2JiMFJpS2VwSVptNUFIR3g5WjV3?=
 =?utf-8?B?K0xjLzdzUGJSaENvU2V5SUMxSFIrR0IvQllZL0F2ZEtUWWtUZDVWZUlYWkxj?=
 =?utf-8?B?eHJuTk1NMzcyc0FDSGZ3UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2ZIeFFKTlNhZEd6SWRzakdXM0ZHdUdZSi91Y1d5cTVmMnBNM2tPdVM4T1cr?=
 =?utf-8?B?Q3RyRnBBMGZ2TnAzZGJLQVBIQklJZER3cGNDcGhIVzFIZW5XZVcyWVR5Q1VR?=
 =?utf-8?B?d0VsOFJVNmM1STdqNGQ5b0R1M2cvME5QbG9NeURmWXRoekFhUHRWcE9XM3Vh?=
 =?utf-8?B?enlwTjlZemxqSTJFYm5wWEYybmpaRkdrWWJKTDZvcW9KeWVOM1M3WHZzek04?=
 =?utf-8?B?ZDZ1ZEtRbkpVczNqQ3I1YVlselZWa1FIZ3RQZ3FVMkh1SjFBQ0xSSDV1Umxw?=
 =?utf-8?B?NDJGKzAwTmZvN3EwbGZIOHZDWnJFTmZBTTc5WnRTZStPOFZsVGJBdTdmMUQ3?=
 =?utf-8?B?Z1psS01yWkpmZVBjYWFIaWlnM2dKT0V1VTlnL0NRaDlxOGlTdG1rZWxybFpw?=
 =?utf-8?B?NEdYVEFEL2RkZmFOVk1US0dIZ25DS3BCZGYvTzVHRkk1SHhmVTVJR0lrZUFj?=
 =?utf-8?B?ODhSaHJzMTRzQVJFT0lrU1ZWa2gwOUF0TGFMUHhHemtROE9xVURMNlZiT0N6?=
 =?utf-8?B?MXVpeTlodk9QazB5aXkwdVNuL0czUFpQZUJ4UEtMSExjZDFYZ2lqV1drWGMw?=
 =?utf-8?B?L1Z3SkQxYVdyTjgwRVYxbGJlcGdsWmZlQkNEM0xjOCtxeE1JaEZRVk1NOUx3?=
 =?utf-8?B?b2J3U2RTVlk2RlBlZnU4Y3ZCTlB6eWUrd3lCajY5cTFxK1hmRHhzN2FVZjJy?=
 =?utf-8?B?ZStkMEtiUjROekhDWW93WmZuZ0IzSW9oV0Y2OFNNNWYyUUp3YlFpYzljV05H?=
 =?utf-8?B?bm1KNU9FSEV3WDIwRnk5VEp2STJPdXFyZmpsNjBMWmFSQ0JUUlJPVVVBNm1w?=
 =?utf-8?B?ZVVjN3U2U21laW9lR2RmOFpUNFJaUnJsd1I1QmVLRHU4eGlUQ3UrdzRUb0lM?=
 =?utf-8?B?SzhtZExpV1A5Z2lTR1I0c0xoMFZTQlVPNmNSSjNDZ1hmQWR4L1QzM251a0Nt?=
 =?utf-8?B?ZkZpUENYaEUyTjh0NnpjdGVTWWZLTDFkdCsvb1c4L3FvT3lZcXpzVjNJSmhz?=
 =?utf-8?B?ckhDSjhzbUMzUUVHYUlqMm9qNE82VjdYS0VQUFVVYzdVdDhUK21IUDgzWW10?=
 =?utf-8?B?TFo2Qm4zTHNnZGdqbTR0VXVGdmlWdlVwR3ZvY2pTMyt4c0QwVXV5WXYyWjB2?=
 =?utf-8?B?MWp4OVlMTCtDYVRDRjJLN1U0b3Y4VG95dmJybngwbVF1OFJtS1I2RE1lekc3?=
 =?utf-8?B?K2svd2xsc3BxRk4zYjR0RkJ6QWJtUmpuenUyWi9vMjM2dzIvQlRtclFGZlFV?=
 =?utf-8?B?a0NFK0poUWlQRm9yN2lJQ2J0ZEZNVXNCM1RDYnA4QVlpaUt0RW1GbytPemFq?=
 =?utf-8?B?aE5XaHMyS0lhRkkycTR6b09aRXZaM1BQQkxPQ3dRblRTdk1NQTVJQks0N3h0?=
 =?utf-8?B?dVZMUTBwQTErZHVubmdiNjNzZ3E0c3pMQ3B0TmY0SmpydzVmTmM4THh6TDBY?=
 =?utf-8?B?V2xDTDZ2UnlrLzFUbXk5Z3lqUTZQQUdKU05Pd0dsTENWSzhGWXM2aFh4Q1NJ?=
 =?utf-8?B?ZkFIb3V2NUJUNWNhNDdGM1NNNTBVQ08zL25lWnJoRkl1REhENU9qN082LzFk?=
 =?utf-8?B?RlpQV0dMV0l1V2h2eHJ3L1FPQVR5b0ZrV3RYdWF4d1hoZlJsbE9oWDBadDZB?=
 =?utf-8?B?NkROYzVxMCtKUm1vN3RxamNWcnlaMVJGaEhOandTR2hVOVRBUEFiM05pODNm?=
 =?utf-8?B?QnF0aXd1SktFdkFZc3ZNd2JiNkRmbmF2VG1YUEFURnVzYjdsVk4wRUVnMTNW?=
 =?utf-8?B?U0w3bHVnaVc4VDRsaVNkSTVQU1UvUWlvVjBHWmJkTlBHSytlMTJnUGlPZWxF?=
 =?utf-8?B?SGt0bjRmcVV3em45bE5PUVZpSzllOE15WUNWMHFrZ2JpOFprbHNrYnVTM0lB?=
 =?utf-8?B?VjN4SEpmSWRwQjJ4WWszV0FCNjl1RE50QTJSQWdqaGppMks0RjlkSmYvMDkz?=
 =?utf-8?B?R0RTcW5MN3ZWd3Z6QUhWQUU4ZnJ4aEl0VkdmVi9zbE9VNnFMUFZLcGN5Sm5a?=
 =?utf-8?B?RmVCZHpuR04yNjRHQUdLalVUK3N2eTdJcFVGWU5sNzRrUEdmV1BhK1pTSFp1?=
 =?utf-8?B?UmZxL1NSQUxhYWp4czd0a1prdlBLaGVJZUZBSk1nRWphdW5Jb0gyaDkzbWdL?=
 =?utf-8?B?bVBLQlJJVEJDWm9teTM4MTE4NkNySzF0Q2RvaWJNaHpDdDFuMnpoeVQzL3JN?=
 =?utf-8?B?ZUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ddc0bc8-e059-4d5f-deee-08dcd0dceb98
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 14:37:24.5669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qhtTAnHD4WbnAiuzE4Xu08ISnfQ7v9DTRGPHU1JWjXCObTnd+3hE6AFI3qlcbvEQFZF2I1p/oHmTiAbjndZGhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7036

On 09.09.24 15:43, Johan Hovold wrote:
> On Mon, Sep 09, 2024 at 02:52:25PM +0200, Jan Kiszka wrote:
>> On 09.09.24 14:32, Johan Hovold wrote:
>>> On Sun, Sep 01, 2024 at 11:11:29PM +0200, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> There are apparently incomplete clones of the HXD type chip in use.
>>>> Those return -EPIPE on GET_LINE_REQUEST and BREAK_REQUEST. Avoid
>>>> flooding the kernel log with those errors. Rather use the
>>>> line_settings cache for GET_LINE_REQUEST and signal missing support by
>>>> returning -ENOTTY from pl2303_set_break.
>>>
>>> This looks mostly fine to me, but could you please try to make these
>>> changes only apply to the clones or, since those probably cannot be
>>> detected reliably, HXD?
>>>
>>
>> OK. Is there a way to switch between dev_err and dev_dbg without
>> duplicating the line?
> 
> Perhaps, did you check? But I think we should go with adding a flag and
> suppressing the known broken calls completely post probe.
>  
>>> What is the 'lsusb -v' for these devices?
>>
>> Bus 001 Device 019: ID 067b:2303 Prolific Technology, Inc. PL2303 Serial
>> Port / Mobile Action MA-8910P
>> Couldn't open device, some information will be missing
>> Device Descriptor:
>>   bLength                18
>>   bDescriptorType         1
>>   bcdUSB               1.10
>>   bDeviceClass            0
>>   bDeviceSubClass         0
>>   bDeviceProtocol         0
>>   bMaxPacketSize0        64
>>   idVendor           0x067b Prolific Technology, Inc.
>>   idProduct          0x2303 PL2303 Serial Port / Mobile Action MA-8910P
>>   bcdDevice            4.00
> 
> So this would be detected as an HXD by the current driver. Not sure what
> else could be used except possibly the product string and the fact that
> these requests fail to determine if it's a legit HXD.
> 
>>>> @@ -731,12 +731,13 @@ static int pl2303_get_line_request(struct usb_serial_port *port,
>>>>  				GET_LINE_REQUEST, GET_LINE_REQUEST_TYPE,
>>>>  				0, 0, buf, 7, 100);
>>>>  	if (ret != 7) {
>>>> -		dev_err(&port->dev, "%s - failed: %d\n", __func__, ret);
>>>> +		struct pl2303_private *priv = usb_get_serial_port_data(port);
>>>>  
>>>> -		if (ret >= 0)
>>>> -			ret = -EIO;
>>>> +		dev_dbg(&port->dev, "%s - failed, falling back on cache: %d\n",
>>>> +			__func__, ret);
>>>> +		memcpy(buf, priv->line_settings, 7);
>>>>  
>>>> -		return ret;
>>>> +		return 0;
>>>>  	}
>>>
>>> Looking at the driver, it seems like we could move the only call to this
>>> function to probe, and perhaps then an error message for cloned devices
>>
>> Nope, this is called on every pl2303_set_termios, thus is even under
>> user control.
> 
> What do you mean by "nope"? I'm saying that it looks like it may be
> possible to move this call to probe() given how it is used currently.
> 
> Or you can just add an additional call to probe() without the dev_err()
> and use that for clone detection.
> 
>>> is not such a big deal. But even that could be suppressed based on the
>>> type.
>>>
>>> Or we could use this call failing to flag the device as a likely clone
>>> and use that flag to also skip break signalling completely.
>>
>> Oh, you meant the function below? But that is also in user hands (as well).
>>
>> Flagging after the first call is theoretically possible - but is it
>> worth the related effort? I doubt that a bit.
> 
> I'm saying that we can issue the get_line_settings request during
> probe() (for HXD) and if it fails, we treat the device as a clone and
> skip the requests that are not supported completely.

OK, now I get the plan. Let me see...

Jan

-- 
Siemens AG, Technology
Linux Expert Center


