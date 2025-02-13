Return-Path: <linux-kernel+bounces-513576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C5CA34BF1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C86418857C7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0E044C7C;
	Thu, 13 Feb 2025 17:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="H6UpFJvm"
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020106.outbound.protection.outlook.com [52.101.189.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407F728A2B2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 17:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739467868; cv=fail; b=QJJxpEBp1WH93qulIK0BBC5liispFuVk9qWfYOecnHSlYygfDgg1hqjTlx+5KBdPqL90eKIwE1wHBihvnZNhtcsTV159zsbfYxWbh6mITPbzfyTtdSWJ5n6ORsL7SMkH0evdxmjKb3WhSdoZKKKB++PPfgMjdqgG4FRn2TFVYK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739467868; c=relaxed/simple;
	bh=CwMLkd+VVTAU89DGjLQh4AaNw1teBxA9pqvB8ULETHU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jQJbYUZLGGlughQIMB4wg0YuTXu91uVGM19HJ5qJFvOKMpg61CWqAW/3HinOqTGpk5PShSVEwvLsjALjBjiQq6SuVcpCP7uGueWPesUa8PJj3o4s5IBKlt7y3+OlPVauSMm52/SyaTM4xwszy6Z5Wp62LPKQstsiIbhIi1qQPOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=H6UpFJvm; arc=fail smtp.client-ip=52.101.189.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=remFzjXgxoARxFK7YRQOhr8V+EnlfvLHTBJLKlHlgFBY2C0SSReJU3uFtlY49bwqp8HSG/0QY9ywUTxJ67nGZ8LD71K4XvrjqdnRE45Q3Ic/PRyXkwam8XboafEE5bGEoRzC9B5Sfnd2fC03UKhOIAKnmenVcQv7kznpK1JMq5oayxwTb5X9Ms6V6RRzrQIo4M6iHHVH8UM79Lu5umAvPgXyUbSW4nosLN9aReU0+91EV88Ktz9ncWUyRXVrrPavO5hRpT6jD9o6ieBLryInKpcpxzyGYGaXVr+qWlOfU5Uy/IrS+p9XeO6dOFs1Z5poGLQtHtxjelta8t3/eQNpbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEdaDiqzjtilg4W1TxRAff1jsOzdPBiyjvke3z6s39o=;
 b=IC7Q/VJu12Uwte1zYeLcsMMTeTywF4ptWBm2TwkmVKat2bdz84j33F89m7Hd5gmlXcz9ZN4VddtpHp3imnmtoMtBsX70v2YKNtHH6ahjjWOczAQAb24Gly4TBXAlTuaqEZKLzGJgfJtcBarvZ6iqUgpuoRkq5HDdGbYD0WDGTjNgB/NDVIe4XK/T/evXWAw7HwyXf/7pDSJUNpSM7cRxFBMgKzE/kkDlaFcLs9oI80r5DleGPFe0a1mpk54IvgudhehVVzSCIUajY0XrZSx8UnddaVEsGSHJwEo+3l/YAgBLs0DroAPIIjCmrHanQ8vcgvgbI3866WioPMdCgVwMEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEdaDiqzjtilg4W1TxRAff1jsOzdPBiyjvke3z6s39o=;
 b=H6UpFJvmEbWuTU6qzQPwh29pBnlmdm0CW8WIfhOK/0WcRb9AIFTUg2ewE883LvGhxvfE9fN1zahxf2HM44yyknCSv/3BgoCqwUd/OhvoXpMadO7Imhx28IwJkLorSqMI2RQ9xXh5UMGA1QUHZ3c2QNyENZok0mMVG5ixBQcs12p0spxXFgoKiqNxPxgqLE3G3i536KlTxwyyFr8+cWX306ivo3Oe2x/Xe7ZlaoaDtQwekRoHC8XPS9UibSTF6oUG38HtRiRZZ8fTziEBuQSHFSM4Zvb4qy9FCMdAwYHg3Ch3UbsSfvMcjnqqlSgH1kBoRj2tv7gi4d7Xlo0Re86IKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB9297.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 13 Feb
 2025 17:31:03 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8445.016; Thu, 13 Feb 2025
 17:31:03 +0000
Message-ID: <0888d6a3-8dea-455b-893f-d8d929e827e2@efficios.com>
Date: Thu, 13 Feb 2025 12:31:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] sched: Move task_mm_cid_work to mm delayed work
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, aubrey.li@linux.intel.com, yu.c.chen@intel.com,
 Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Shuah Khan <shuah@kernel.org>
References: <202502131405.1ba0803f-lkp@intel.com>
 <17bda9071b6962414f61668698fa840501819172.camel@redhat.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <17bda9071b6962414f61668698fa840501819172.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0082.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::18) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB9297:EE_
X-MS-Office365-Filtering-Correlation-Id: 85554313-c041-4f94-c32b-08dd4c5430b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTlPRnkwZk96S05uZ0NabmlZMGZ3NlBKOHdYYmlwSTRDQWhZOGhvYkR0eE9D?=
 =?utf-8?B?V21jMnZ5VmN0VjlTUGtYeHA0ajUxOGN3dHN2YTUvK0RDdWczTHBxZTU2N2o5?=
 =?utf-8?B?MXpSSDkyK0hXa29qL250MzJhMmIvYkUrUWRLVFI0TEtjWHk0TXRMd2hSZE4x?=
 =?utf-8?B?dU1pcXZTT1M3SW1ORE02YURBMzFmVGNwWVU4dlBQOVhpT1dpTnhCU0pxWnRa?=
 =?utf-8?B?ek8ycUplQWJOTGZzQnJDRE95OXNQcmprT3lnT2lDWnVNTVRRWTJzRzY3d1dL?=
 =?utf-8?B?SWR6RS9uSUk0Y0hqbHlqaUxudU42dzZnUnI1STlIdU83SnFNbklKVHZOeTQ2?=
 =?utf-8?B?bWR5NUkrTU1EbG9UUVhvY1BDMisvUTFoQW56Nm1WdkljbSt3RmJ5VCtOL2tV?=
 =?utf-8?B?UXU2S1pCbXNseVkwMkxmQTNyYW9JTjNyMjBrNmxLWFF6UVdZWnVIMkk3emRZ?=
 =?utf-8?B?OGZtSFh2OGJZY0czcS8xZyt4UWxuSVJOTHhMZlVjSjljMkNTRkhLSEpIU0Yy?=
 =?utf-8?B?ZFNTcldsOUc2a3N3OUJaSWNKbHR4N09oaUpCNHFVa3ZiK2lsREJkb0N1MjBx?=
 =?utf-8?B?cjk0OVUwcjhTejBGdU9BZGNuUGZyQmprR0dLVjdDRk01c2ZjSmhtT09IN3JM?=
 =?utf-8?B?SG5PcmhIZ0RqOEQwa2EzTDVTWW5CUlFIcXQwVkhUNEJ0YXVoc2tIaWFCcHE5?=
 =?utf-8?B?ZlBJTFZOVm92NHZNeDFtVmhaeVo2VjVRM1dRN3d2M1FTZWZTRktJelo4Yjc1?=
 =?utf-8?B?OFlyWkw0VmRUNzM0QWFIYk9LRk9CY0xycTZLd3VaU1V0N1duejZnK21oYURH?=
 =?utf-8?B?RndONGFkbVFnekxrTExEemNaTGtNK1RmcmFDd1RJQkJ3dGhpdlFVWko0ZGlW?=
 =?utf-8?B?dklWc2k4bFBLbnFHby94UTJXRktiTmtsZHNpMmdiNm1LTGRDMnF0ZUduTTd5?=
 =?utf-8?B?dmZucGdYTWhMUzlxaUphZGNGb1BYc2dhc0NnUFhSMVo3VE1QNmlBajhXN2pS?=
 =?utf-8?B?cXVtRWdsZFJWK2NhTGM3WXdtVFhuQXR2TitNYS9aNnU1UkNMQ1pOcUMzTjMv?=
 =?utf-8?B?R0tGN0srdFI0WDVRN1lNU0haYWU4bVJPTFJOWUJuOTNGTktMSXZ2dGxDQjVS?=
 =?utf-8?B?WGlRWDRkNy9TK2RRZlc3bFZ0YXVMMXRhNjBlRmFDS3l6T2pOOTRlVE5FWEtn?=
 =?utf-8?B?NXQxdlJmczVwaWZwRXlDTzhCQkdhdlZoNTh6ZlNuQytzL0NWQTNrbkdEcG41?=
 =?utf-8?B?bENuK0FUSWlwQlpZVzJMOVZ2UlRYcGVIREo0ZFJiWVVkNHlaZ0dnQWJyNUg0?=
 =?utf-8?B?ZktlNEVZMnRHYUtpSlV0SitFcWhVZmVGb0tHMzJTTFN1bFVqMEhjcG9VWGdP?=
 =?utf-8?B?bnJHTjg1QThQM01RaVRWeW5UZmRycHlHenRxRUxqQjc4aUF4T2pMdmJUenNY?=
 =?utf-8?B?RDZmazBNSnJIb0lNeXlMWEQ0a3d1UERISkc0QTVWdmdscHFSQWQ1WDBLSTZx?=
 =?utf-8?B?TkRERlVyYlpUcmYyWDF2WkFheUcxSC9heWNkcTluQ3J3aEVWM0dhNmRnMkwv?=
 =?utf-8?B?bERNTHhMaUFndDNTVVBxR1E3NXRQWm5vZGxrVkJWYVRoeUtWajd3aGNYYVZN?=
 =?utf-8?B?d3VpcXYvYU4yMlRJMXZKSGU0OUcxM0tYRi80ZUFIN1d5MlZaQlJXaStZS2ZS?=
 =?utf-8?B?RCs1QXlYdEFRME5BQy9aRFZ5MU5YSG5Cb0wveGZ0cHN5SzhWb2VXa1krTmU0?=
 =?utf-8?Q?r2fXMTei7NivUS1srADvvIJKj8R0Kx9m+7qeqbs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFJCMGZWWWRxNWw1ZXJsMmxTaEZBQmwxTURLV1p3SUc1QVZ3VUNveEtCZzB1?=
 =?utf-8?B?aTNUQ1AvSUwrcWl3OVVoWmRpWHVrb05rb0dQVE95dzFXVjdZdkdVNUtrQjMr?=
 =?utf-8?B?WklaUk9HQ3RMTHdONXNtVzFuVFNQZHBYVWh4SklnZnovZjN0ZUdUNFBwQk4x?=
 =?utf-8?B?MnpDVTVPSlNZQ3hRZ216VWZLQWhHRHpOMHN4L3llOER6bm43cGttUjdyd1N0?=
 =?utf-8?B?YVFvOHV2aU1kTHgzbXNURFVhNDhJN29PNjZmMytKRGlrbUU2S1J4eEYzem5t?=
 =?utf-8?B?TVFtQ0IxUmtQVExRZkFpUSsrb3hkTGtMZ1hSNmpKdEoydmVDYXAyNTR5SENk?=
 =?utf-8?B?TzJGbDFPYVNlUDlWRVVrWGtqd1BGZlU0dUV1eDQvMFRoOVpSYU9NV2hMWkhO?=
 =?utf-8?B?ZnpPSEowMVRlNUFiVkZGWTR6Rm1Td0lMSENqMHJHR3p3SEFVOGlKZ2lBejBr?=
 =?utf-8?B?MVBSMnJncXQ5NW00NHdxQ2VQamJLdkpnQnNXZ1pKVFdjZmJNbUl0a05FYzU1?=
 =?utf-8?B?eGFtVXhLejZSWjBwQjBNTGZxaGFSdXhGNTFabm5iQWplS20vSHVFRHFQOWVX?=
 =?utf-8?B?cTRodGFZTmJ4aS9EMVoyVGRrZllZT0s4QU9PMmZKMjFyZkx4bUFzRlVRc2o4?=
 =?utf-8?B?RWkxNmxjUUVLZndmTXhLM1NJWVRZRFBKc0MxTTI2N0FPOHFLbUlRMGVsendi?=
 =?utf-8?B?UHBuN0JRQWY3aEJ4alUvNDJCc25zRVp0WmpteFgvek9ONk5lOTROOXBFY01l?=
 =?utf-8?B?SGNRNy94TWcvQ0VSb0tENlRqMzVocnkwVGs3MWU3MTlZbTBoMkdpRUs5VnVE?=
 =?utf-8?B?ZXJnQ1MzL0RVaU5aSXBtODl1a1A5VTRyL0lzL3IwM1hCRlZJbWpkREU2VkpS?=
 =?utf-8?B?RWJ1T0xPTnkvWjVOYkVDSlAwUkgzSUNLMTd0b1lMenEwN0NsWTFpT0l5UHdX?=
 =?utf-8?B?cERZQ2hsUUZ4a2dPQ09XbHVQaWJvV21lVVlFenA5ay9wNkFFdWhKTHd1Q0hI?=
 =?utf-8?B?aHU0UXFWeTJOUkg3UG9nVUlaL041ZTRtWHI0eWZRa1p5U1E3emw1MWtrcm5K?=
 =?utf-8?B?cHpWQmJZYmRGaERNak9MMGI2UWRrQWlweVYwcHFRZm1aRWU5bnJNL2FjQ0x2?=
 =?utf-8?B?NHlmcTA1V0dVVGkyQzQxNldiMHFLUi85eGNvRVk4WjY4a20zTnljck9UQ0lk?=
 =?utf-8?B?Tyt2UThJQkVMZThFejRtQkx6WjZpaVhqdVpsb3ZrQnh0aFJzWEZjTmZXNTR6?=
 =?utf-8?B?cVFoSlpPNUZHVW54aEN4RHNLNGdGQ1M1VEVwOFFQQUIzU3pnVEJiOHFySDdo?=
 =?utf-8?B?K1JVTUdFY1EzT1FTWVk3R1h3WngvZGxQWGZYYU1BWWlwc2dFelh1a2FsVEZK?=
 =?utf-8?B?b3M3TnNwWVlCUDNRYmx5cUFwUnRkWkh2V3k0MDB4bjUxbkRPUm1CWE52K1dF?=
 =?utf-8?B?bTdKSlNQUS9wY1VQQjQxekNybTJHUEd0MlppSFpsOU5VUXRpNVZ0TXpDWTNF?=
 =?utf-8?B?NkI2UTg1NVJBcXhQTVlpUERJZ2tack02amo4enJjV3BqV0JPdmFxNlFWVldS?=
 =?utf-8?B?OG12OVZPckNPcTNXbTkrVWJqMkUydStXMlpacURuV1ozN1RabWJ5WlVwY3Ev?=
 =?utf-8?B?SFcwTndva2dEaGs3SWVxWmtVZmY1VmlwazVIam9kcitFQ0FrNU9DZjIyV3BZ?=
 =?utf-8?B?N3h4TWdwVDJNUmxFb1JmYTFHZTVHbjg3OEhCVXpEREJJemlSbWQrNFNJYlNq?=
 =?utf-8?B?NmM3UStmRXVXaWVrZFdldzJGNzdBOWNFZnU1VmtJV2JrbU9OK093Uk5UZjFz?=
 =?utf-8?B?OWVOU2pBdWYxSk83VnUyTXdEb2M0RzZKVURaYWdLZFJwVzNzcWE4KzVSaXFJ?=
 =?utf-8?B?RzhvUEJpcnFpbFJxZHlzWlcweElzcVZHWFVKY2Y3RmwxOXNkU2Z1TWd2dVNk?=
 =?utf-8?B?aENHaDJmTFdaQ3BzcTEwdVpUSFlFbWdWeDc4cFJqY2RIcUxrT2Z6cHNVdWRl?=
 =?utf-8?B?V0hzeGswSHc2OHh2ZzFOYVhrZTl1eXVFSVIxMDhTNi9zcFN0NFN1NWtUd2pu?=
 =?utf-8?B?a0ZQNTY3WkFrSDh2VEw1VzVsWHhJV3NZN3JBaDUxREVPWHJOZ2U5NTZXMVU5?=
 =?utf-8?B?Y2daQ3VsWUJhZUxXTGxBclRRYUtqUWhPRDFPdytQZnE1Rmp4NWZhT1RycW5U?=
 =?utf-8?B?VFdiTVJKRXZtNW94dzZpUTRJZmpoTFFQWXJCdE9OSnVKMmpPYWxjUkJiV3hZ?=
 =?utf-8?Q?831fdo9S3+UP6yPwTNQ5KyM3TRP/JGfFbSVAfO4oXU=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85554313-c041-4f94-c32b-08dd4c5430b2
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 17:31:03.6608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sh4ezo9jSd8/L3w6040t0W0dKVVJfgIFa9CPalR+uVtGhI4QIdqvb8OjuLLihYbBJP/eF02K31WsH2BRQt8uwCQXVy4mHwbEEetAMV3WiTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9297

On 2025-02-13 08:25, Gabriele Monaco wrote:
> On Thu, 2025-02-13 at 14:52 +0800, kernel test robot wrote:
>> kernel test robot noticed
>> "WARNING:at_kernel/workqueue.c:#__queue_delayed_work" on:
>>
>> [    2.640924][    T0] ------------[ cut here ]------------
>> [ 2.641646][ T0] WARNING: CPU: 0 PID: 0 at kernel/workqueue.c:2495
>> __queue_delayed_work (kernel/workqueue.c:2495 (discriminator 9))
>> [    2.642874][    T0] Modules linked in:
>> [    2.643381][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted
>> 6.14.0-rc2-00002-g287adf9e9c1f #1
>> [    2.644582][    T0] Hardware name: QEMU Standard PC (i440FX +
>> PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
>> [ 2.645943][ T0] RIP: 0010:__queue_delayed_work
>> (kernel/workqueue.c:2495 (discriminator 9))
> 
> There seem to be major problems with this configuration, I'm trying to
> understand what's wrong but, for the time being, this patchset is not
> ready for inclusion.

I'm staring at this now, and I'm thinking we could do a simpler change
that would solve your RT issues without having to introduce a dependency
on workqueue.c.

So if the culprit is that task_mm_cid_work() runs for too long on large
many-cpus systems, why not break it up into smaller iterations ?

So rather than iterating on "for_each_possible_cpu", we could simply
break this down into iteration on at most N cpus, so:

tick #1: iteration on CPUs 0 ..   N - 1
tick #2: iteration on CPUs N .. 2*N - 1
...
circling back to 0 when it reaches the number of possible cpus.

This N value could be configurable, e.g. CONFIG_RSEQ_CID_SCAN_BATCH,
with a sane default. An RT system could decide to make that value lower.

Then all we need to do is remember which was that last observed cpu
number in the mm struct, so the next tick picks up from there.

The main downside of this approach compared to scheduling delayed
work in a workqueue is that it depends on having the mm be current when
the scheduler tick happens. But perhaps this is something we could fix
in a different way that does not add a dependency on workqueue. I'm not
sure how though.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

