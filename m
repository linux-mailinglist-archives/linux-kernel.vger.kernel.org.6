Return-Path: <linux-kernel+bounces-285235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EDD950B02
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E15D28484C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DB61A38EF;
	Tue, 13 Aug 2024 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="NGEm45uW"
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021115.outbound.protection.outlook.com [52.101.100.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EF91A2574;
	Tue, 13 Aug 2024 17:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568485; cv=fail; b=gJJUv40NgRFbkjWZ8P2eFnrzAp02oSeGc/UWs9Ck5eiobvrnVwQxvvNIzLCG/U/j63as7gJwhcIV3RXqKEWo8n8n4ey6C4UVJxUNNyKgQ95w1LRRECMGlprEWRYXXbyr5o/wriHEvtHjrccDH9eR4orvkkxrdQy781lUlAEGyBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568485; c=relaxed/simple;
	bh=KyKFdJ36ekbdWOC1Iehh3CzEQbV+P9J7PDlnvg//qss=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ajgN3MUhlXNZXX1rs2khhVjBcjGYLs+e2nrdlpwJpB+3w65MCYwVmcQeCK9cxhoJRTzW/OjAE4Xrvc42L+I87iHhY8ix+oZov6JnLtz8pHiWC3YT5QiiSv5fGeYgjLRlR1BYntjmDcEUQqrbrJRaBqsAjJvfzc6X5KrTlpdcQS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=NGEm45uW; arc=fail smtp.client-ip=52.101.100.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHRqW1QOC0tfbNvgMv2+T/xGG8ODOh9JTP/X+5R83yYvW+0oNxGAjN8JGyRMy6ga3mCEnIQLRk5ZLYYbrCtvfBqeqRG9FlYHQeWDQyVx6wkV5Yu6fjFiQI7xL49D76Tx4l35jGkzaqD9jFskqJoCMCdk8eA2pa7RspJAjL1NIs8BxySJ1MF3oCdYchRCW1ozyaXTmTYpp5R3Yw08J0jOcraLlWF5smMkfbEd0FFqYw50PJSwNJonObjYY07GW7rEa0luwoKDypYyN+qk+pLyIwqrE57UiT+MqSqCKZQB/ddL97g8DE03Vp/CAtP9fSwNC8SrrJzWLjp95q4hU4vfng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KyKFdJ36ekbdWOC1Iehh3CzEQbV+P9J7PDlnvg//qss=;
 b=xtxvWn26mto0+KkGGalPjEKKiN+/xYex5jbIXy5zkvbtJR0goT8kWTENDsmT+zTZRKrKBUK8XOqgyc20v61rVU8iGJEzhHbrZpIWEB/Bz1FFnMIwabc28X9cIjru0WXP+vg7eknrXtNLnoU/N00nGf1FuPGmujQMnwnL61i2aLkRaTdS3VUTb9AiMyX7SJr/rZWZDk9mkZt4uEhK5t2KN9z1HsBfgvSWwugO1KJjM6vlu5V+RDAqs48CY3fF4K8jKoySdZt77PUpTSyy5KQyAwgfF8HeC1AJViuPysC76oxnCDI4w9WKWT0Qosy9A/+fzmymoUf7nof5QoCskO3QQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KyKFdJ36ekbdWOC1Iehh3CzEQbV+P9J7PDlnvg//qss=;
 b=NGEm45uWJ/mni27Nr+Umck5eNeTM1FXX+Yvqv6OTmytzQoDzSXiANq6zCDfCmW+ZLKNJhd5uFBXpl/6AoB8TzUwcCkLMV0CXey14hh36kynQQDmFHjJn02Nc1L9stfj2sQkv0h1ckSZRT/gwqvnD5fyKlyXrSeBUYMyKScB3zqs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB6786.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1e8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 17:01:19 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%7]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 17:01:19 +0000
Date: Tue, 13 Aug 2024 18:01:17 +0100
From: Gary Guo <gary@garyguo.net>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Zehui Xu <zehuixu@whu.edu.cn>, ojeda@kernel.org, alex.gaynor@gmail.com,
 wedsonaf@gmail.com, boqun.feng@gmail.com, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rust: Kbuild: Skip -fmin-function-alignment in
 bindgen flags
Message-ID: <20240813180117.3c259c17@eugeo>
In-Reply-To: <CANiq72=UeYXi35PNTAtHd5UGt4rgyMjpfLbG3xYxpdcvY3mZYQ@mail.gmail.com>
References: <20240731134346.10630-1-zehuixu@whu.edu.cn>
	<20240807115708.394a8eb3@eugeo>
	<CANiq72=UeYXi35PNTAtHd5UGt4rgyMjpfLbG3xYxpdcvY3mZYQ@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P265CA0090.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::11) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB6786:EE_
X-MS-Office365-Filtering-Correlation-Id: 296a1178-4dd0-4adf-9772-08dcbbb98d0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N3NZVlJMK1FSRzhSNllwQVNrNnVQdUhnby96NmdualVyMVpjZGhOU01YUlVL?=
 =?utf-8?B?Vm1PcXpOMlFJb2orSVR6UXdPbDlkV2dIaGhaNyszNEtoYWRKY2tNNExqMnZo?=
 =?utf-8?B?MXJTRWhEdXI0RXdKRUpYMkJqd2FHTGdHSVJ4NDU2V3B4VEVzdi93QUkyTGN2?=
 =?utf-8?B?cERhYVdsWi90VGIxUVlVSSs1Zk1kV0tUUWZvRUdhNUxHckJMd3loSmNPM0dh?=
 =?utf-8?B?YVFRVXl2c3VUaEYvNk1uUFZVMUc3cjNUQlRSdURINDZHMXBsdW1XZEl5bXRi?=
 =?utf-8?B?UG9SQkJaVS9vOUJ2akY2cEJyeUJmL3BEbTNqY3Z4WGpWaCtRMFRpTTcvQXZS?=
 =?utf-8?B?dmJ2QWgxakRzY0hJcnFJZGhGSXNJQjkvZStXbDEyOGZRRCsrVFh0YlpoWjJ4?=
 =?utf-8?B?cFQzOVlHaW1rVDR5WlZidTF0TU0vNzRPRC9zd1piRUx0eVdDNFl1aS9Yd2dN?=
 =?utf-8?B?TC9zWFF6UFhObE5xRnMyVWNRZTRoN21abm1SYUwwVUZYRkRVbThwYnRFdmNO?=
 =?utf-8?B?cTFtK1J1ZVBMKzEzbXNwaW5qNW0rNGFnS0t5TkNHZW9qMmhOSWZUUXVjNnZo?=
 =?utf-8?B?ZlNDNmIzZVhQdlUvTDVkRGh6Q3V1MkJKSHBWVjJSYStaU2pQcmFvYVdIY2ND?=
 =?utf-8?B?NW12WEM2RUE3NVdCTVVobUNpSkU1M1BrUnliWW1PSGFPRWZGVlk5V3YzblNi?=
 =?utf-8?B?OEtwRlNweGQxQ092RWdlUFBpbFdFUjI2UlZ6SkpUSGZhc1FpQnVVVVlMbkJG?=
 =?utf-8?B?dWxYbzFaQS82RjZVbWkrUGRWS1BpN2k1bjNyZzdVNi9UNTJBMnBNcFlQQkpn?=
 =?utf-8?B?R0s2dWJMU09vVkFKNkZOQnFIaDVleHJYTTczNXVVMDU0NUp5bEdTSVQzaG1v?=
 =?utf-8?B?dmlIYkpCSFo1TVpZR0M4dGhhQWQzN0hpTzVsWGRiU0Rwazd1UkNCVitSazVX?=
 =?utf-8?B?aDgvckN2Z2lLeHladFhIUVlkeUY3T3Y3bGpKaDFsK1E4S0ZOOWFXVGFtOXV0?=
 =?utf-8?B?cHVzWEpnZVQ1bmN0Ukh4Q1ZnYXpkUkhGT3hIbE9oQ0UvSGt1dHQrWHh3SER2?=
 =?utf-8?B?Rk90WUdKbGZUV2ZmTWlTUnp2L0phdEJZWWxGT3I0a1lZS1RWZmI5VjhmSGQz?=
 =?utf-8?B?YkVtdkIvdEtycEZXeFRvYmt2dE1uWHpiMWIrV2ZmT0d0THFwbDZlVmlOK3Y3?=
 =?utf-8?B?ZDJUR1RYTkNsUFVvTTU1VVBnWi9qaDJsR2l2OHZ3RzZ2cjZOTFBWM3k4QUF6?=
 =?utf-8?B?RTJLREdTNFVIRHhxSmJ2b1dnYXE1cXc4RHVteWRtZlFGNmo5akZFVXNBV1V2?=
 =?utf-8?B?eWY0WDZ5MWlUdGtjdHhUTEJhUTZBWis3NDhkRmZkQU5DZHc1TU5xQWkxVEhO?=
 =?utf-8?B?WnFVWlZ0bHRmZS9iNEFFZTdtZmVmVnN6bGo4a0dOempZakpEY1BVY3NjYU5o?=
 =?utf-8?B?bjhPL3BXaTlHM1M2bDVQc0xrTnZ3SmhISG1YRDZRQlZZNVE2RVRmUzQ4VDhX?=
 =?utf-8?B?N09RSjhBaVI1emRNZkFDUmJRMW0zdUMrMnFkWHRqamh5Y0lTdmdXd0ludWxK?=
 =?utf-8?B?V1Fic25QYkFWNHVJUno0YzVjS0Y0Y1cxay91dkd6VzBmNEY3NjdKZUJaRG5l?=
 =?utf-8?B?QURENFBPRkhnald2L0Y3ZFRFYUswREdtcWdkUVV3OHJtWnNpdklpY1VITit2?=
 =?utf-8?B?Wi9nRS8yVWd1TWVyNVRDNFM3NFBjcms0SjlDVDhLNTJZaHpyeGFOVEo5cWxJ?=
 =?utf-8?Q?t8Fm4GgEA0xu7r/UIY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlREMlRxZnBqS1liYVVYcFNPL2w2bkhqeHRmSWVlUExaL1hPRXY2NGUveFRs?=
 =?utf-8?B?ckoycWRJRjRnM1Y2Z0VMcWhQbTlBaE9vcGRoclM2WXJJa2lJZ1FsMk9NVUo4?=
 =?utf-8?B?YkdDUDRXcTZhdjRCeUJFWXpTUS9aVEw2UGVhS0cvRmVnR0dRYW9mREFwL2RR?=
 =?utf-8?B?dlZiZUNNTW5XczR5T2YzajdJU0F6T0JJaHNjUjU5MFBxTFlxRW1WN3VtRlUw?=
 =?utf-8?B?dUJYMW1IZHhCOFc2cktXVHgvN0pUYVBGY1g2OVlTT2s2MjBQYWNMcFdtZE5w?=
 =?utf-8?B?UVhHc1BZWk9pTmRRakhrNjRCNnZIajM3MUlvLzJwd2hQU3p5bitMT2lINEpQ?=
 =?utf-8?B?UmdOdlFRQlZ4VFVsME8yY0ZDYjg2RXJ2WnUyQ2ZYTFRXN0lhdHpSM0RTdCsr?=
 =?utf-8?B?U2RZSmlHTmtkVG0yYXAyd3VobEhKU2lYWlNMT2JNelVmRkwrVDZFdS9vWlV6?=
 =?utf-8?B?Qkkra3RXOU9jaEpJUlFNU0ZqNFZTenVoOFVXaWZ2TnpNekRlOFkveVFpMlFX?=
 =?utf-8?B?anFaNmx0cnlnbGwyZHkzTEhER2lMdzBPZ1ZsZ1hhcTBKMUVKLzJ3OEVTNWxJ?=
 =?utf-8?B?bFpUVVFUcWtRZzdjOEp0aUZ1K2Nzcmk3bGgyR3ZiUWkwWC9URHJLZ0t1ZTd0?=
 =?utf-8?B?V3hjMXNMQ2dPL2VONUIxV0xLd1hhRTZaM0h2VWMzRlRISXVkTGhlRXdpTnpk?=
 =?utf-8?B?VlNoVkV4cDlZQWxqUnBQQzdVQ1Q3dHlwa1lhYTd5ajhzWk9sR1h5d3djOHZj?=
 =?utf-8?B?S1VrUGh6Y0QxYnIxNThCdmZWejNFMzZNamVTSWpPRG1SQkxLekt2Sy90VFVh?=
 =?utf-8?B?Q285SmdXdTcxWXZ5QU1MUmxHTUg5eFJETjRINDNLcFEzR3pPYTJiK1YrbGpM?=
 =?utf-8?B?V3hvcE5vZlUwVUNKMnNYNm5RRXVhMkJrRGl0TEJTU2JEb1Z1Nkg5bVZBV2dj?=
 =?utf-8?B?a1d6ZHVPNWloTDZzdUt3cmEvdkJ3L3NwZnRRaWZTam9STEpBUVlycnp1emRm?=
 =?utf-8?B?SlVjVCt4dFVZMHArRDE1WnQyMGs2OWFDNkdOTk5SZms1cmh0NVJ3NHQvaFhG?=
 =?utf-8?B?YVNJTEN1MEg0TEtVeWlzUmNVTWluK1N4Y2Z5d1VvT1ZRMWJqK0tqUlpWb2NS?=
 =?utf-8?B?djhQZUZIckViMGlmeWNQcDdUNkdQR2VZWnM4QmR5bWtkSjZUdCtPVTdVRVZq?=
 =?utf-8?B?NEM1eVpENThqREZKWDlDenFycEFBeGZWcUkyM3BjRWF1K0dqTmhoRGRiQWx1?=
 =?utf-8?B?YzNvek4vMVlMaDVaMUgxVWhORGt2OU9EWDlva2RiSmluUEtzYmt1MUNUOFU4?=
 =?utf-8?B?N2ZudlRUaGQ3R21oclpHV01lRWxURUs5dHVkUG9iT2xMSEZTRVdaYTI4QzY4?=
 =?utf-8?B?RmdON2pETTZ2dFA1YmxuZ016MFhLd1I3bjFCaktKZmp6dVpxc0wyMzBmWG9p?=
 =?utf-8?B?Szk4UWNDT2pRbFEraUhjYXhvWERsOHh6cGZUZUtoTEJ1YXJTMzJwNG5NL0VF?=
 =?utf-8?B?RXp4ZDVsY2VocjVIU0JUY3RpQi9WYkQ4cWdGSEhMdzlqYXNrVTZrakdoQ2lm?=
 =?utf-8?B?TTJhOFNoVkh2dFFqU3dsZ3owaWU3RVU2WXhsZm5iOUV0N0hydVJpZjA0cnV5?=
 =?utf-8?B?enF6VUF6Q2tpd2Nuc2kyak5hNVF1b2hJM2RQN1J4em9PMjZqT1JVSzBYV3Ew?=
 =?utf-8?B?WkY1bUVJd2hMR1FhR3lpVEhzVkd6THlmZDdQbFVjRlJWM1lGY2VEL2xabTNY?=
 =?utf-8?B?OWFIZTdhY0hmTFBUMWJIWGh2M1VxM1V5VmE1UVd4QXpxaG5kOXViOFlXQ2Fq?=
 =?utf-8?B?Uk4vd010V3BjUytLOVFUS3JlMjN4cGxWNHBKakFNVFZuZFJYMUZqTlY1bDdw?=
 =?utf-8?B?RUdOSVRlV2JVbTl6M1BkdzlhQTBQME4yLytRNXVPTkRXdG9oZ0ZsdTRiQnpM?=
 =?utf-8?B?QTZMSE13QXdDcnpTbVJ6ZVNGQXJvd3dsb3RRMGkrcDdYVDhFZWVzaWExeWFC?=
 =?utf-8?B?SGphREdyZUltSVc3TTFDTkxDRloycDdrUWw1a3E3SHNPc2lEOXU4NnhzcWlk?=
 =?utf-8?B?UWVPNkxhTExHTkZiMVBwMWQ5R1dBZ3Q1bWNjRFp1cGhBRnVvUkJhOHVpekZK?=
 =?utf-8?Q?rurj5EGFvpW7eFnH/Td6fpDyo?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 296a1178-4dd0-4adf-9772-08dcbbb98d0c
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 17:01:19.0798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pLtzxc33Zheqx4Y6SGHp+Z4jZZdoFQL8ozZzLa8DGi75bg3dnsmtm7c++FSUQjF4vRK6fByIv+Si3hHy4eBJ7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6786

On Thu, 8 Aug 2024 17:07:51 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> On Wed, Aug 7, 2024 at 12:57=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote=
:
> >
> > This patch itself looks fine to me, so
> >
> > Reviewed-by: Gary Guo <gary@garyguo.net>
> >
> > We use -fmin-function-alignment for GCC and use -falign-functions for
> > clang. These options affect codegen only so it's fine to ignore them
> > for bindgen. =20
>=20
> Thanks Gary.
>=20
> > Although it appears to me that we currently don't set function
> > alignments for Rust codegen. Maybe that's worth considering adding? =20
>=20
> Yeah, agreed. I think currently there is no way for that in `rustc`
> (apart from `fn_align`) -- I have created an issue about it and a few
> others and linked them all at
> https://github.com/Rust-for-Linux/linux/issues/355.


I think `-Cllvm-args=3D-align-all-functions=3Dfoo` should work?

Best,
Gary

