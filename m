Return-Path: <linux-kernel+bounces-446399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F8E9F23DE
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 13:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96F01885627
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 12:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A2C185B62;
	Sun, 15 Dec 2024 12:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="owp/tksF"
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021084.outbound.protection.outlook.com [40.107.192.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1843F1FDD
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 12:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734266563; cv=fail; b=O2DdDOZSWQGMT3ZaOrORqNu6PqF2en0oLXT46/C51wCpGi3sH3vQ8z5ZDoFL8NP5nIaz+ByfEzRMfWfmtGdgnyPUkWaTNn6W2GBXM7kKl3+G+RYKgDd7KjOEdn9B42qxlBThpu17cTIDPrTDPsNtE9m6C/T479cRapKx2TpV1HQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734266563; c=relaxed/simple;
	bh=HIzyIGZPoydyFoabhWgtjOg0+FnA5PzEgsUFD/Q+/Hg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JgIivbLxanj5f7VY+9V4h2RPXVRYETkZwcAbCTJ2Fg5c3Pa1G2s+U+HNsX2V/pyxfGWmKZVAjhPUho/J+F29ofrSb3lTP1W7IBo23FDriSxtOZj33a1FBfoneV01zejVwWIML01FIqU/2boOI4+XX/H+RVw5LZOVYIhhugCbMbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=owp/tksF; arc=fail smtp.client-ip=40.107.192.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r6qsVyefbctUJ+MP2hJtj/8WvbnMShSnPoY0nDD1o54UyRf9P51v33OnvN9v2B4Tm1CdcyY4js5zDYyv/Nn09XSTA+kbUuHZw24aldPdkDwIJdXARVdB62aiUFSQWrB6TXyNqZ6RgdVpmw3BJCH19FmYbToV7Spe4na1owDMI4c2fCpBMVbvY5jMXoPpMW4ziR1uHJg4BgPs1vulcD0GRSnVLYJzAD4eMyRCtIz1JuPzliZbgq7pRjf7VgfNeqnIklKnLEI1jGFqG7jM9E0lBboJNSPafp6CGPyTn8Sy+SYDoV6MRdfO9nuDbXnQTEd5oQN/x89IY25zrXs2LhFOqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwLYLr577OvNOUuvv4AC5/Ed3s27T0XXCdoZEMvaFPc=;
 b=aUCYE8zAsZ3SVt/hJXuxxBQVbX0nYCyU/yb9zOAcYT3b1yXBKOm8XXHuQaM/FMdCBT9sLff3DLDHX5Pf99LReUoNPYNmVz5nG8CjpGaXbSvU00Nmd19dR63GpATDafuO1BGTOkaycDjkGNkFaCwo6SLGdIbVpIEJVwCgg6jZoT4fvFo6mdlb22mx+pA4K4QnWiTr07rJinVweZ7sAI2aPBOf7roIF9pB6lSR4zPqZeboQpEuaZVfI344MAa3LJijzViyUAxWwOeHfk354XbaPzD6pdTE2FETMwqS5M7UP718tr82fg0Sh1eFy8t+eTCJl9DDA6R/NbAGPiqtzFsHag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwLYLr577OvNOUuvv4AC5/Ed3s27T0XXCdoZEMvaFPc=;
 b=owp/tksFRc3QaGZODbYIoUf4W6f463lGLrhpKTk17/EmCspr8ZCrTa6fH6tj/0s6kgmL6nvtQfScHgv4Q2MaIsAPHCHA6tYAM7gX0HjzAqRTxP3D0zotjV+Ca5e0De0PUGSMO+lvgLH4vUpV7a8thQCMSGhOqQfFeIL7aJI5P+R/AJfhTxJZ+ZOxH/MbRQ7Sbz0Hleq7udj+Ye0TUk5EpBbIo+BvZTvwjXG8Nq0LrlUoAXPtBiB4qQyLNsg5z5lvz1JmpB+hezFzzjgm0xmDcFQyFYM0f1BHDdysIvll4VtjebJCVSIbvCQJBwVGMFgFqe8UR8XenakMaG7rUBAUlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB10572.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Sun, 15 Dec
 2024 12:42:38 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%5]) with mapi id 15.20.8251.015; Sun, 15 Dec 2024
 12:42:38 +0000
Message-ID: <69db591d-08b0-47e7-a8cc-bdaf3e9d4678@efficios.com>
Date: Sun, 15 Dec 2024 07:42:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] ftrace: Fixes for v6.13
To: Steven Rostedt <rostedt@goodmis.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Michal Simek <monstr@monstr.eu>
References: <20241214182138.4e7984a2@batman.local.home>
 <CAHk-=wgyWEbWa9k5=z4LxY1hx0Pxqf5TQQC_BKme_+DrzGufKw@mail.gmail.com>
 <20241214220403.03a8f5d0@gandalf.local.home>
 <20241214221212.38cc22c3@gandalf.local.home>
 <CAHk-=wiSdtNvq_wUtq7f3oO7S7BYCeXh7a707HKvK9nVkxR=jQ@mail.gmail.com>
 <CAHk-=wh3cUC2a=yJv42HTjDLCp6VM+GTky+q65vV_Q33BeoxAg@mail.gmail.com>
 <20241214233855.46ad80e0@gandalf.local.home>
 <CAHk-=wh3uOnqnZPpR0PeLZZtyWbZLboZ7cHLCKRWsocvs9Y7hQ@mail.gmail.com>
 <20241215050517.050e9d83@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241215050517.050e9d83@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0226.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::26) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB10572:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b1499db-fb5c-4f62-b3a9-08dd1d05f4f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1ZlRFFtVlBxNi80d3RFOHZzL2g1Vjc1MHU0aUE0bDU2QWI1NlZwVFplNG11?=
 =?utf-8?B?MWcwTzFHamhBTXI0RTlsdkJjWm85R2l5aWlVTWo0d0N3bmNHVE81T0lWWEJI?=
 =?utf-8?B?c1dyZUVmR0U5UVZEem1RcXVrMGZaTTkvenFmNjlDV2RROGJSMDFpSmZXUTFZ?=
 =?utf-8?B?Q0IwMWtPM1NJc0RmdDdOdWlQRzJ6N3dxamttc1U0OThabHJwOXVpQW5Hdlk1?=
 =?utf-8?B?a3lZbXNIR0NZSVJRaXNkamtHdElmNlg2SHBST0phcEVtaDNHclJnRk9GWjdO?=
 =?utf-8?B?UkdZOHhEcW9ZUm5hc0U0alZMZldTZDl0b3F4VUpqczROSnEyYTFoWDZBMVo2?=
 =?utf-8?B?SGlINjduNC9UTlBZUkZVT3V5U1FBbGE0ZGh3d2FkN3dMVzkwMEdDYktTQmVi?=
 =?utf-8?B?NFVUQjRnQTlzbzhOU1ZkanpxUnpVYkErTlVxa2xwUFloeVpuaVkwUHcydmc4?=
 =?utf-8?B?OG1FUTFQWU14RkZhMVM4ZVlvaS9vbG5rUXdHWGw0R29LNHArVldVaGZRRkxG?=
 =?utf-8?B?cGNIR1NqYlJDNWZ5M2ViUW80VG80dVRIMVQrUnZDaHNWQ3dDUFltVGk4TlVR?=
 =?utf-8?B?K2wzay9ReTdJc2x0Szd4azdDQVBxZHJOMkI5RmxrQ3RLZG03VjBzL3JUc3VF?=
 =?utf-8?B?ZmNxSWw1ZHpYUkg2Q3FwUXI3VVlNc2VxNDVwN0N1OEo3VmY4ZGo4QlgvWWp4?=
 =?utf-8?B?QjdzM2J0WkN5UUtBdDlKaFpQUTdCSzE2ZWswS2dPekhjUVFKcjBRWFBMbUlJ?=
 =?utf-8?B?NkVoYlUvSGVVamQxUlBPdXVnZHR3NzRDVVFvR1p2NjB4MjYwRG05OWk1NnZk?=
 =?utf-8?B?ckF5emFBRU9PT3JPc2hFcmx1ZkJ4ZmNxQzFJc2s4R1VKL2VGZEFndGpjendS?=
 =?utf-8?B?TTFhZXJHU3RvRkd6MHNhd2drSkRmWE5xVm1YWFd3VWQyWi9pbTZrV3JoVDdi?=
 =?utf-8?B?cUROSUd0NXo0ZkkweTc2ZzdtZnJaa2pRVDF1QXVTZjNqODhvMXZlc0QrN2Rt?=
 =?utf-8?B?TXJrQ0hZNzdvcENXU0lUak10RE5Xb0ZQZE5wcFhvR0ZuNnYxMFZUSi9nQVNy?=
 =?utf-8?B?SzhXY1FldXZhMU45bDhMdUxrNDl4VWtsNkZPZG5UUFFaLzZObWV1bGtZYXho?=
 =?utf-8?B?SEpuVExtYTUzekFia3F2alpTNDh0NXMrT1JMbnQzSHZLYnZ6VEo5SnlVOTNt?=
 =?utf-8?B?YTBtemx3VnpkMjZCMElKQUFFY3BPQU5INmllbnZHUzRsZTdoR25QYW1Wblpt?=
 =?utf-8?B?dE5DTzRhRWtQcVozQVRtdlpUMFJrZmh5V1J4Mnc2MnVKN1F1RkFTc0xBMGJS?=
 =?utf-8?B?U2NON1UzZ0x1a1hTM1BZK3BsNmN1aUdQMW5BL1BKeUEwanlwb0FiNWE3bW9M?=
 =?utf-8?B?WGhNOEFteDNhaDhUOEVWRmJFZ1JzVFFFWkFhOTJRY3JDNG8yNjB3a2lCREVv?=
 =?utf-8?B?ZmxMaFpjQ3cvL2dyRG9mbm5RdVMrTEttTEo4K3lrdEhsaDJ1U2MySWc3bVJF?=
 =?utf-8?B?MldDTFEyNzVJQ29zOE9zSEk4RlR4b214VURLZzJrQlJXeVJNOGxGcGV4eDhK?=
 =?utf-8?B?MWFFcndOa3d1Zng5aU5NSjJRWUV5UUpBcFNtQmNrZHd2TSszNXNmd25KQ1M4?=
 =?utf-8?B?ejVkSUo0alRvNmRHbjBZOXQwMDlFdCtmVHRuV1J6Q0dyQWttQTlYL0IxYnhu?=
 =?utf-8?B?OUZYNlZJbWpOdmRDZUJQajN3Qm9rUXltV0lIbG50QU9sSHNRZzU1dDNFalJT?=
 =?utf-8?Q?BgXJXPXVMiylXNmi63SISP+JDI7O4wg47T1hT2b?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zkh4dytRVC9KN2hIV3VQeGZMQTdtbG1kYmZZSWYrb0R2Y214aUg0dUhBcURR?=
 =?utf-8?B?ZWFwVFlyRG5pblhOalRxMkt3TUNKNTZYT3A3LzhuTG5IekJLQmNsMXJMZUhI?=
 =?utf-8?B?c21XVnVTeElIaklmVlUzbEp1aXVrQjh4eHFvMDhlQXVidUdYOHk5QktwRW1t?=
 =?utf-8?B?dkw3aVdPYnVmRUx6ZG0yM2RUakw0aE1CNXB0QW9QNjA0aGd4d2tCLzlMTW95?=
 =?utf-8?B?LzhGeEZFU3N3NURBeG9KUnkxSEZWZGNLWldiOUdIUE4rb1BxTWlKamVoelky?=
 =?utf-8?B?aGxkcVhKck1yaklmNXR4aTQ0YllRL0lmUDJSNUkvd09kN0JEdkVYVm1DeXdm?=
 =?utf-8?B?bzdPL1ZIYnRKeHJpc2x3eTdaMUlPd0hZanNVaXhPMlAwSmU0eTc4SnJNVlB4?=
 =?utf-8?B?VEQ0WVBsOFlscFZTV0NndERoZm5kS0RicXN2cEdIRWFWZmZxMlpURFVhRDJ1?=
 =?utf-8?B?ZzRzbWNPUWRUQ2JKY0tUY2FIVk9zNERUTUdSSS9RVmpMQWliMzlwbk9LTlNE?=
 =?utf-8?B?NitVeGprRGpYOEloY1dxZlRYSm9aeXRBS1RsMk1iSk5FSHd2L0JFaUlKMGhN?=
 =?utf-8?B?OVVUQ3Nid1l5N2ppNjJaZHhOV3pZR3Jrd1JUa2Z3b0tOb1BaRjhFMEZWWmhQ?=
 =?utf-8?B?S25iMjEzTE1hNk4zdkhQeDNJRC9nZ0NEclY3OWl2SFlodkxPNXlzRUM2cTZR?=
 =?utf-8?B?TDZDWnh0SDEyM3BDQjczckJ2LzM2blRWYUhvblpZYzFVVkExTlE5allTRTM0?=
 =?utf-8?B?MlVESXYwV0JnVnZ2cFRoQmd6NHl6cHlOTlozZ2ExUHR2NVQwcWNNYTBxZHZl?=
 =?utf-8?B?Umk5WjhKcW9TMm55QzltTGNYcy9EWWdkSVpCbWkyTWZTNjdveEJlTUJRdi9w?=
 =?utf-8?B?VWxPUnJPSG96akkveDdzVTN2WCs2Y28wK2pnYkRoVmdjMVJaNldzRGhvN010?=
 =?utf-8?B?WVNUaW1MYWtuMmNtblZHbFYzZ2duWUZpSjE4R1ZnZmNFZUhRM3M4ZlFLTkRv?=
 =?utf-8?B?eHUrR0RuemxiWWFrdHl1MFVheFM4d25nQlpsbmFMMDhoM1RJanFxNms0YWg2?=
 =?utf-8?B?Qks5YS9HVHVMMkhNTW1aUm5LWEhDc2FLaytaMjlyRlk2NmJtRmhYUm5LRnYv?=
 =?utf-8?B?b3YrVHZ1YllSUmpYTVZ0MEY0RCtVK0hUVkswRW8wYXpReXdlbDF3aVIyT1Ja?=
 =?utf-8?B?N0hidW8vQ1oya0hwb3VPbzdPb2wydGpsR00vTzZqc3hGYldBQWFzT1RwczVZ?=
 =?utf-8?B?THNmR3dlOCtzOC95bTNFdGdya3FCRENvdWpPWUNzUFI1aDJJb3ArSDhvMFBm?=
 =?utf-8?B?U3NCa2srQjFOeUtlRnhXWVNvZzA5QkpURVRrUG1KT01SN3NPNUV5c05PV3Rq?=
 =?utf-8?B?VllkMXAySis0VWN1bCtzbmdtRzRhLzcvekc1elFxNXFwLzlEZXkxOWpqNmU3?=
 =?utf-8?B?VzhTdkhXdlEycFRiOGRCT0FkNkd2N1gzWnpEZ3ppcVIrNDdIYWlGc1RTSzlO?=
 =?utf-8?B?cENTVE9jVlpCcjRXSng5TW4ySmpuak04SW1sdUY2N2lHRjA5ekZET0Q4TS91?=
 =?utf-8?B?cTg1U2ZQVm0yOHBMak1FaG9nc0F1aHh3ajlSUzVYQmNNckF6cjJxMngrTUZW?=
 =?utf-8?B?RjVJa2FHbisySTNZSmJvZU1lRzlkWXpJTHFzbDZGazg2YmJPWFZrcC92bld3?=
 =?utf-8?B?aDdGWHd1aHRmOHNKMHFKZ1grWlJjdW9tUFkxZmdkKzFoOE0wUFJ2RytMR3hM?=
 =?utf-8?B?WlhTb3ZSSitYVERROW5DdG8yZThSdkJPR1F5NEM0VXR1WlltYkp4N245YStD?=
 =?utf-8?B?WmhDSWNKZU1ISjhadi96TytXQjZiUTBQNGppbzI1ZmJUV3lWN3FkT1hieGRB?=
 =?utf-8?B?Vi9ldk5zUHA2OGtaUHVpWjIyaTZ5YVUyNVhXc2xhbVdsVE5XTWsxazJReW5F?=
 =?utf-8?B?K3lxWjdZTGZqaVZRTXNJZlNxQWZyZWZReThsVnRIUWhBa2ZLMlNTMThvVGtK?=
 =?utf-8?B?QW4vMzkzS2l1M1pxUHZ2VDFtMHIzaDJGM2UvQmtweUNDQ2tKREJTcVNNN3RW?=
 =?utf-8?B?WDZiT1RWbUYvei9kWEl6Q053cVFjMzV6VXZEcEZGZWZJSEdpWU02emZBek1p?=
 =?utf-8?B?Rnc5UFo0Nlg3eXJ0TW5taUJadkY1bDc3cEpPS3lCZCtKQ0ZhOEJIUytYT3V6?=
 =?utf-8?B?NWhicWNTUkhvZ210YWhxWUk2TStKM0lMWkxLSVhwUUlDbWJCbVcrL2ZzUVk0?=
 =?utf-8?Q?tzLDQ66pFtepBBYPZlsUV1eNUb3ipDNBjsr/TwhYi0=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1499db-fb5c-4f62-b3a9-08dd1d05f4f5
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2024 12:42:37.9946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xpU7/MqedIBiWmE0yVv/tm9BxUD3yet4mf8psYoSnr74whkRNDhvwvMGPNlr7Fq8ohmW6uFvrcnu77a7tUgYleRP64+0HKCDOMA+AE31CKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB10572

On 2024-12-15 05:05, Steven Rostedt wrote:
> On Sat, 14 Dec 2024 21:19:01 -0800
> Linus Torvalds <torvalds@linux-foundation.org> wrote:

[...]

>>
>> Just disable it unconditionally.
>>
> 
> I can do that, but I'm not looking forward to seeing random crashes in the
> trace event code again :-(
> 
> Honestly, I did not like this code when I wrote it, but I have no idea how
> to stop the "%s" bug from happening before it gets out to production. This
> worked. Do you have any suggestions for alternatives?

IMHO, deferred execution of TP_printk() code in kernel context is
a fundamental mistake causing all those problems. This opens the
door to store pointers to strings (or anything else really)
that sit in kernel modules which can be unloaded between
tracing and TP_printk() execution, or as we are seeing here
pointers to data which can be mapped at different addresses
across kernel reboot, into the ring buffer.

If TP_printk() don't have access to load data from random kernel
memory in the first place, and can only read from the buffer, we
would not be having those misuses, and there would be nothing to
work-around as the strings/data would all be serialized into the
ring buffer.

In LTTng we've taken the approach to only read the trace data
at post-processing from user-space (we don't have the equivalent
of TP_printk(), and that's on purpose).

I wonder if we could keep the ftrace trace_pipe pretty-printing
behavior, while isolating the TP_printk() execution into a
userspace process which would only map the ring buffer ? This way,
users trying to misuse TP_printk() would get immediate feedback
about their mistake because they cannot print the trace. We could
print a dmesg warning about crash of a usermode helper program,
for instance.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


