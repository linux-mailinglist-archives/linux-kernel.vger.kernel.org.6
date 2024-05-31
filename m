Return-Path: <linux-kernel+bounces-196646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A958D5F41
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195A11F22B6E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FCC14532C;
	Fri, 31 May 2024 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="WyPGC4gK"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CB27FBB7
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 10:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717150066; cv=fail; b=Iba/NfMJFLfZ1qUb0v1mPFT1xX4H1WPII7uckIvLOpHDGJzK9/Lgr4zKMvo+hNgynTMYQ1KezxdI9Vgk4niOw6o4IluFKPSXNfeCeTwPPH704fPsMytCRzGfTx+SwlM09PoMs5tZwRntv/YHIrXHoEJ6NBtSAhb6TBdv1ot2rbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717150066; c=relaxed/simple;
	bh=GxU3gWF5eWBEbKzJPJ8YYkK92wSXDfq+jIoDd7nrELU=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=cgI2e78weP+Ylpy0QcppF7ChoJgYx6DOjaN110mUrNtUfuxkcn3rJFkeqrRuVQ5aXVusM4iVzyV4AHfubv2fHX3lyghJugOeGu5VKqG39mlmgEwmRUJrnuWIl14hZ945Q2I6AniwuAjS/jgDPRvHcD4pb8XHIealN4GikZ7eQis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=WyPGC4gK; arc=fail smtp.client-ip=40.107.22.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wrd0XDXNNi7d3JAoV5N2VWHTW6DohQDbvM29R0OcYK/mKJNDkaAOzzmXVLU86yuH/wbX6rdG6kvMY5CeVIlGAI+aW3vts+z9P2J0kyvE0CbaXpDXi521jDwTTR1h50tJFk/+zYvdBOFTMKoxEMkCiMM0baIQoWk6MXkE9M4jML8DgRhPpD3EgjzCrvDaJjdb1oNMAKZIfnXrNGKGWo01rautRu8bH5CkGBhnZgq5EqvGLgeAibKrD9fZdKTub+Al2AbVkrZsHOqGCVk13oFnlYOAEbd4DcT8XPMid2B0kCprS26KvzmMW8k5b+++RwghxwQLe/cCYHaAWDk9VsFYnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUScoT21n7UtpNJLHZXGOUa+cdlXDl7B9ONqTiO5iRo=;
 b=bspf9KlAox6PCcHg42SZyz5Lyg4VxgTdRH/YYhlUw214ShvGV1KiPq+JyHcTFIK4/ssUOKiovSLOGNl/mLlVtqcf32JKUZF4qN5iX6xs8NGTGwPaLn0TyHcUr8A+FHaULbpWoNmz1rrAxJboT+JTCDETP+xxUfqNvD0mpJbiTmDNttQmpBXOFx813mBgKFt0YcOa8CiifPofUXEHatCwXVz83ot1svb1vBq9BZkNNwSjC9fmZi7nutaZ4aqcNKitRhpWZiBmYdRv6wc9dYOOl7SfycC9K5AyJaP3kmc32l5Ax/ABItpgLl3bYCnBum7xXGYrw5bfmUKeZ0H3GmCdtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUScoT21n7UtpNJLHZXGOUa+cdlXDl7B9ONqTiO5iRo=;
 b=WyPGC4gKX6geC7vu4DM9z+He7iSXKZsqYk4ILr4pFEa0r02g5SeXFwQFYEv27CfpPedIjp0eQoXjlerDLevq/MB+uWNfIWY07gH7OE/iRJ88d0KNbEyYl2gEZJcpIGGZAJbiJ5+WjggufsyPqnXNoM/2HmNKecVm67qk9tc1mU0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DB4PR10MB7447.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 10:07:39 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 10:07:39 +0000
Message-ID: <1abeef45-df5f-4779-86e1-b89f179ccd0c@prevas.dk>
Date: Fri, 31 May 2024 12:07:36 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US, da
To: NXP Linux Team <linux-imx@nxp.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Adam Ford <aford173@gmail.com>, Shengjiu Wang <shengjiu.wang@freescale.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: effect of multiple spba bus nodes
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0047.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::28) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DB4PR10MB7447:EE_
X-MS-Office365-Filtering-Correlation-Id: 938cfcee-5640-42d0-6ca8-08dc81598095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjFKTitTYVZBQVNtVDVkVWNmY1NLanFlakVKaE5NMWJITmxua0cyZS9RcDB4?=
 =?utf-8?B?MUNwRGNCSEJqTVhoeWFkM0RVbFBFQXNrL1VRdE5DcTdoV2JGRVp3TTlUMk41?=
 =?utf-8?B?SDBlcGNxQmlKd2lra09VNmo5bjhrMEtxYlhYT0U4bFNJajVJNVorYzV4RERJ?=
 =?utf-8?B?b1FoUTVncmVGeHFTc203M2krTVRSb29VUGNMSURweGtodmJUcTJYK3ZLdlFC?=
 =?utf-8?B?R3EwYXRwSG1QcFV4LzRPdmZiSXRCTmNEZWFQRGg4cWl3NlBWUTJjYVhTVklz?=
 =?utf-8?B?OU1pWldPN1JWUlhzclh5eE92Z3F2U29CdXB2VSt4S0w3U2J1WlM5djE3Q2py?=
 =?utf-8?B?QjM3R2s5SFR3RGJYaXVIK24rNFVxS1ZKZTlKSnBERmM4MDJ5dDZwQ2k4dllI?=
 =?utf-8?B?b1FMMnpPaE9CQUVxNFhHTk1na0JCQ1lvWEZVd2ZtbkRrUlhkbDBJNmJQNjVs?=
 =?utf-8?B?L3BhQzU0aDVXb3o2blhVNjlYNjFUeXVWNEZTRW1qcFVMbXlQY2VQd3NMQWEr?=
 =?utf-8?B?T09aZldhMWZlRFMxT0xyRk0vVmxUMTJxTVowRVZLMkJobUdkN3BaOHM5L0Uv?=
 =?utf-8?B?bEVEN1Fwbk05ZTEwVjdWV3BFRDdlZWdOUGlaV3VxOURKZUZaNXdhUGNNTEQ1?=
 =?utf-8?B?akFWYXF2ZHAvM2JXNjhOYVBPSkl5VnNrVkZMMkZPc1c5WWszZGRBa05VajZ0?=
 =?utf-8?B?dWVraDc0UVZ5Z2lQUWNoSlpPRWVmdUZGbkg2ajNTWmJNVktrelhiMU9qYkxz?=
 =?utf-8?B?QjlKSkJwR1NCajlvQVRLTmdwVk1uK3V6Wko0L29iZ3Fxd0RLcmhFRDdSN0Zj?=
 =?utf-8?B?a2xwSGhKT1VpNFhqWnkxS0VpajBieFBmaTlLY2src0tOb1Z3dXBQeUNjd1Yr?=
 =?utf-8?B?amJSUFF3WkcwOUM5U3RxKzM4MFptNlFDZGRJcEp4dkliZEg1RGkyNkRjTjlF?=
 =?utf-8?B?WEVtSUdrMWFFZHFhWDNTYytFTnZyaVBMdStUc2k2QUhieittaTY0K1lMWnhG?=
 =?utf-8?B?dktkcWJkZVZ1MmV3TjA2Z25LM1BMYzZUWWdIc2EydnhaTWg3bHlQQ1ljY3FL?=
 =?utf-8?B?QTRKSE0vK3JYU3Q5SDBtWU5KU1BlTDR0c1pNVUJMd1Qva3FlMy9NNFhyUFRE?=
 =?utf-8?B?KzBaOVJhbnVKQzNDanBVdzQ0TVpqcFFNVWVFSk1rb3AvNER0dkhmQzZnczZR?=
 =?utf-8?B?dm9NWWkranlwbHJVaTBHTXJRelFCTExQY3lwS3BEaERGTzAyaFE1YnFhTjZt?=
 =?utf-8?B?RlMzUWR3cVdTaVQ3alhQNG5DLytnTU51dHVyTkFoK21yckV3UnVpTy92ZHpa?=
 =?utf-8?B?Y1VkVEFnN1dBOWM4aEVxcTNjTFZXU21yRlZBTEd2aVBxamUvQ0xSWlhRNERC?=
 =?utf-8?B?ZUFlZFA5M0lSTkdIRjNrOTR5b0Y0OVNicjUwNnZYQ0kxQXJEWWRoalpmUFdG?=
 =?utf-8?B?clVkZzRXRE9uNTJmM2Nxa3JDNFgvRDVOUGRybzhCNndWbnJCUGJLeVlnYkdS?=
 =?utf-8?B?YXI2d2FQRUExMUUwMHNFQkxuR2NWUk1CVEcxTUpKM3BhK0taWm9PUEE3QkxO?=
 =?utf-8?B?dzJYRHlrRCtzaklRQS9hbDUwNmJFQmxrMFlXaFc5Wm1yZWFERjUzMUg0QVpR?=
 =?utf-8?B?RjRROXl4cEFQMndNZHhoZE9lYy9RRnV5cVFXTzRBSTloU1RoeW9jZXJMUzJF?=
 =?utf-8?B?K2Y1Q3JoR2oxc1lUWlZOZ0lSenNMaVJSVzhXTHVKNy9HNWJnOTlrSTFBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1F4RzE0aGhQQStJZ0JBTkthd25qaVhSOXZwMWwzdTNqNW10M2QyekZTNkdl?=
 =?utf-8?B?cGZNWitCUjlsM3hvMC9UQWdtTWlOOUZGN2JrN250bk94b29JUWwxN1RyRkNk?=
 =?utf-8?B?eTV6US9GMlg5cVl4Vm96UzJtbmpXNkk3RVo1N2dJU2Y4cnRCSXhYWWZ1T0cz?=
 =?utf-8?B?M0JHUnc2TGRoVGxYN0E1amo5R3NQZFVYcnhEY1VGTW52bEp3QmZJMXUvNGQ0?=
 =?utf-8?B?bHl4Q3VnQ2ZVMy9zSUZGWUtwNTNwMzJpZUhIOHlyMHRSenhWRVRtRFpzRElL?=
 =?utf-8?B?ZWhQNWVkbENtMFBLenM4MjhOdmlXQzZQYzlJdU1IRm1LMUNrVWlWY29VVTRy?=
 =?utf-8?B?RjVKYmJhR1ovSkNENGRBeFkxeXB6TEQvUHFycWtsUXg1ZXdmNVVYMUtlcmpj?=
 =?utf-8?B?cDJRRzJXd2Izc09uN0xvQ2ZWYjJ4RnU3MGlxVjZISHJaUFEzSWlxRlJxQ1lj?=
 =?utf-8?B?REQreDhKSWZhVVFFUE9NRU1vckhRZDl4N1dCUld6NnF4Wjd4UkQ1eDJDYlZE?=
 =?utf-8?B?WW1iYkZnVWJIUFAxRXlqZ2xuK1oyams4UE1yRUhzYUpVb01FU3JmVTN0NmVT?=
 =?utf-8?B?bk41ZHl0eUQ2RzFHWDZ3OE9ySGdnU1VNSW0xQWZKcEJYVWdWL2FqMy9aUGlC?=
 =?utf-8?B?VE5aUjNwbWM0aHhJWEJlUkVMZlFRSlZIUEdiSnEzQjV5QkJpbGp5bHpWY0R5?=
 =?utf-8?B?dlVUbUE5TEZVNzJvZU85TzdHM29mbjRhRjlybTNQYzdFQzZsWHoraWtSTWEv?=
 =?utf-8?B?WlZXeUJhMjdmdHdmYW9Pdll4cEhheGluSjMxb1NvcG0rSjg2NGU3d2VYTTdp?=
 =?utf-8?B?cWdpbGRZdUdRVTlHekVXbGRQWU9ZMjJEcC9PZGJqTFdwL0VJalpZaHNxeFdQ?=
 =?utf-8?B?bUhteGt4TDh5SUtJZThvNkRKQmtxcGhJbFNUUnVoM2MwbFB4TDJRekladVRw?=
 =?utf-8?B?aUNuUFNHUmViY2FLZEtMdzhRWm8zblU3UFBTWFRPdGFwNWhxaFhKR2tJSGdi?=
 =?utf-8?B?SjR4NmJPT09pNHhpZmFIOEFlM1R5aFR6MkJpQkFrcXRUNUhsR3lHbytxbkd5?=
 =?utf-8?B?VFJDb1NkS3lKOEx6bDBQdEFKcUpLZ2R2K0VYbElZRVhHbEsrYkQvdnMzbnUv?=
 =?utf-8?B?Uk5JazFsTTFjMURYSHdJOGRkWjg3d2hiV3ZwQmFqdGM3QTJWVzFvcisxc2Nu?=
 =?utf-8?B?dWp0bmpvVWkvNE4rRjRvbnNCeHBYSUxVM1dJL1pJcnY4RmRqL0UvYlA2b2tR?=
 =?utf-8?B?dTA3eW1DL0VDTjdxSFMvSzFVUzk4VVVFU3ZDZUpxWUM1cDJVQ2duSFBna1Bt?=
 =?utf-8?B?MTd0RFluWlIyNktOSDlyNzNDdGlQUlR1eDJWUEhiZDA1ck5keXo3NnV6Nyt0?=
 =?utf-8?B?VE5hc0xSWWtoWUV3dGdyRXZnb3E4eHZaVjJMUW1JMitqUEFobDlmOXpKVklT?=
 =?utf-8?B?TWJqM29Ray91VDdOOTM5L3M2MnlEZGFhK2E0OGNmZkZvYTc2ZHdjNkpJUExE?=
 =?utf-8?B?WmExQ3FCL2p3dDhpU3M5K2JHRyt5VzlncENFZ3BKM1FwK0xUVG1udmd5ZVFQ?=
 =?utf-8?B?S0xBWWNoLzhGd0djSXpaVndrUHFVaEk3UGYxbGxCdHRFMzFnRkJOOEppbENC?=
 =?utf-8?B?NUhjSU1IdkFEK0Fab3M3TlJDV2ZmZUVWQVJwdUlrS0FLbnBTWW9POWlITlFo?=
 =?utf-8?B?TEs0THJOcmVMWnMvUXlmYVVpRTdjaUNUb1oxZ1lUcUtoM0l2ajFUeHdnRWRl?=
 =?utf-8?B?dE9UQmdXcGZoN2l0eTFTSDdJb2s0eFlQVHM3Yzk1NGtSZDd4eVBkR2NTWXZw?=
 =?utf-8?B?bzhEaWIwRDVDN29taTVVNFVBUXB5aXVtaFNQYkphSW9rUmxaQlJ4NzdwU0Fk?=
 =?utf-8?B?WSt6LzJPa2F4SEtUWkw0cVRVaUxBZTVJQXdLdmtpSzd4S09rN1ZlT2NCQXgw?=
 =?utf-8?B?RXRhVDc0bWF4Ym9OL1pCV041WFl6Z3F1SnVrQXpMdC8yZXBibUdxTUQ1eGFJ?=
 =?utf-8?B?Wjg5RC9qOVhRV05rc1pnS0trbk9NRWJKaFYzTkRGQnNlTnpuUUFXYlNBdW03?=
 =?utf-8?B?Z0dDMWM1VGVkMFgzVUdPeFVjenlGd3NsREgza0FDbEpKKzdsWHlFTHQ2eWdz?=
 =?utf-8?B?cjZpRk00bkR1Skd1Um5HaEdpQTZpMGhuZFMvbytwZC84UGlVbFNnQjJ6UFFK?=
 =?utf-8?B?bGc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 938cfcee-5640-42d0-6ca8-08dc81598095
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 10:07:39.0008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5hnXAK5W8rTY4kSZZzKSnv+xp41+2THBwd5AgLjwErHrPxzSZ1MFLue2vTCefo0UBC1c5F9qRxGFOOfujOHv3uagCrCRFBgMe9VsQ45u/HQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7447

[resending because I never got a reply]

So commit 9424e7f064055 (arm64: dts: imx8mp: Enable spba-bus on AIPS3)
caused us a little trouble [*], but I got curious and tried figuring out
what effect wrapping those nodes in an spba-bus node actually had.
Grepping for the compatible string, one finds
Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml which says

  It is an extension of
  "simple-bus" because the SDMA controller uses this compatible flag to
  determine which peripherals are available to it and the range over
  which the SDMA can access.

OK. The one and only place in .c files where that compatible is
mentioned is in drivers/dma/imx-sdma.c, which does

  of_find_compatible_node(NULL, NULL, "fsl,spba-bus");

which I suppose just returns some random (well, not random, just the
first in DT) node. Many .dtsi files, e.g. the imx8mp.dtsi as case in
point, have more than one spba-bus, so how does that work?

Rasmus

[*] We assign stable netdev names based on the full path to the device's
DT node, but that logic broke when the CAN devices got new DT paths. I'm
not disputing the correctness of 9424e7f064055, we've adapted on our end.


