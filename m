Return-Path: <linux-kernel+bounces-408739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 804479C82EC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4153B284D23
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 06:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14851ADFF5;
	Thu, 14 Nov 2024 06:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="uQ63Ryz8"
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2032.outbound.protection.outlook.com [40.92.62.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15D71E4B0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 06:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731564401; cv=fail; b=e/0RapKqTl4zL7Jp7RX8rm0UrblpkGORwzkF2O4JwbOCDztlolV9/EPSt+dV3a+boTpRx1iSZPPd8fb6U7vxg1axlYjI8jcITZwh4hyoYM9oOKEaaXb1i977Grpp8zLM7+1Ca4OLEQ/zVH0BbgBGNhOpfxHPUkztqxUVhNyfD5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731564401; c=relaxed/simple;
	bh=MvBwIFnIHC2EWcKbnyCEwbK0EAnrHLrvEOSqhgwro88=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oEr/PCKuTnhS8wKYxlgCticnVtc+O9/OYsoCX/pX3YrbA9g0bwIua7cPQLk+V8MYq0K7NCAncn8addwo2Ccapg9IuKqKuhtJmd44XoAetM3l9LyxU4fJvukM7rNM9CZ+KXeGUbkHaZbrMXJZ4HLArD+RWChmcWCBjTHuusraaN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=uQ63Ryz8; arc=fail smtp.client-ip=40.92.62.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YESbYFVPHI7qMNVh81E8ag1esMwEQRWDRwo2sABwMStQrTtQ+altS7cw9xoQHPNSRDVJ+1tT5MMof16eBSjrUYbmTC5c0NDpeRUvrHUZbAAOsrb9iLr8Vp2ryi5CqEYAbEqKXPBYS8ocmAottAAgtsB2NKeHdK85A790LSIEdOtKP7cyktiKXo0FlL2Jb557DFIZzprbRDwkJg8+cHbUCG45v5o+Z933eu+75hujv7pCw6AIjBlU6TAIsLIhVlIQ6bGBZSyKo1cld3cykGRDe5YFkNM8zVwlsnU5A+icYQI7XrR3MEczcD4ECT555Xw6jgh8SMM5ijFvWn7bTWIGRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvBwIFnIHC2EWcKbnyCEwbK0EAnrHLrvEOSqhgwro88=;
 b=gORm0QpiChz2AK5CE712xvON3ZJad2zfttxwYaqePxzuFRh/Ed0wJcE+GIIsI50pRExzVmxdUjVlLH6lDe1sUvRFg2xOfkfKhM0VdSQuei8p+l5oFv/N8mMMOoaGBfK4BoULuRZO56wv5ShcB7/p7fph6HKT6ZyIhT2UJGVVcBYxEa9JgnNmBxi+852itx3nmRx6ncQsg63WNfNpZzkcczUSYgVT+ZFUq8OZkYkifHdUyFZWmxHPN5syKux2Fem/8LKCZzH8lzr/z1iKgtSsqBuEIK5koXwm323rc1sJt6cBKe9YdIHottkTFCFSSOuSLN703cF1abVnlzGf2A7Fvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvBwIFnIHC2EWcKbnyCEwbK0EAnrHLrvEOSqhgwro88=;
 b=uQ63Ryz89xli3TLb93q/mUpzv6mThRGRyhUOm0apx7BqR/iJof6JGoBYOTouzpE5rFn/FV5hLsbZWbTvhUlPWD0f8sigDx97mHcZiW2qgRnSCqH1baCT5+aUSKYj64DPvV32qWWkJFXCjQN6/v+tRrLKWwajuSHP3wxC0Uh5RpUg6lcocxf10+HOaLN4Y9WEK8wcfSATAH2h76+OqADOPhICWfwH9mEnJgUXitmdHNbgzEyHAx7ukZxKaRwbr2W9jXkDRAVyyWgZgeO/BTRM4rb8+Oprblv8WPVY4ibqIqpWZPGuJg0ZfCf9rfSiXMw/9JFJuXP7z5aRRZg4unjwHg==
Received: from ME0P300MB0414.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22c::5)
 by MEUP300MB0144.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:215::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 06:06:34 +0000
Received: from ME0P300MB0414.AUSP300.PROD.OUTLOOK.COM
 ([fe80::b8f3:cb85:3e65:5cde]) by ME0P300MB0414.AUSP300.PROD.OUTLOOK.COM
 ([fe80::b8f3:cb85:3e65:5cde%4]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 06:06:34 +0000
From: =?utf-8?B?6KejIOWSj+aihQ==?= <xieym_ict@hotmail.com>
To: Tianchen Ding <dtcccc@linux.alibaba.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSCB2Ml0gc2NoZWQvZWV2ZGY6IEZvcmNl?=
 =?utf-8?B?IHByb3BhZ2F0aW5nIG1pbl9zbGljZSBvZiBjZnNfcnEgd2hlbiBhIHRhc2sg?=
 =?utf-8?Q?changing_slice?=
Thread-Topic:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjJdIHNjaGVkL2VldmRmOiBGb3JjZSBwcm9wYWdh?=
 =?utf-8?B?dGluZyBtaW5fc2xpY2Ugb2YgY2ZzX3JxIHdoZW4gYSB0YXNrIGNoYW5naW5n?=
 =?utf-8?Q?_slice?=
Thread-Index: AQHbK3ollxrR3gaeJkqsh/oWYQlEi7KzDfQAgAIchaGAAP06AIAAJwbV
Date: Thu, 14 Nov 2024 06:06:34 +0000
Message-ID:
 <ME0P300MB04142599FB1D9BBF8AFECE7F8E5B2@ME0P300MB0414.AUSP300.PROD.OUTLOOK.COM>
References: <20241028063313.8039-2-dtcccc@linux.alibaba.com>
 <20241031094822.30531-1-dtcccc@linux.alibaba.com>
 <2c4654d1-f212-43ac-abf9-de6d08c85387@linux.alibaba.com>
 <ME0P300MB04148C8F736D90AC822CE3678E5A2@ME0P300MB0414.AUSP300.PROD.OUTLOOK.COM>
 <d83e1631-237e-4743-b067-6cc54771eee7@linux.alibaba.com>
In-Reply-To: <d83e1631-237e-4743-b067-6cc54771eee7@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P300MB0414:EE_|MEUP300MB0144:EE_
x-ms-office365-filtering-correlation-id: d9bed0fb-0368-4bfe-8ee8-08dd04727e10
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|461199028|19110799003|15030799003|15080799006|7092599003|8062599003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?WVhuOGx0aGQ5YUNubEJDSzNLdGdSK29LTzJpQUpwcWRydFR4MitkWlBPeEw5?=
 =?utf-8?B?S2ZPS29wd2UvRE1BRW16b3F0K1JlNjJvNjNBUERodFJlRGt2TzBSTEpTVC95?=
 =?utf-8?B?RWxPMGM0QTNJUisrU0U2enh6SGZ2Y0tVTEhmeWVmT0R3Wm5CK01MZ0tJdTVj?=
 =?utf-8?B?MVdSYUQvOXlLMHJ3bDRFT1duWlpMVVJwbVlMY0Z0bnBkclhoRzVkK0ROMkdu?=
 =?utf-8?B?KzQwSnVaSEh4S1hzcjdEVjBhOGRJMW9tV2g2K3hhN0dwRFp5RWxoeTJLRkhC?=
 =?utf-8?B?RlZnT040OElKNzNrNGk5ZktiNDcvb3EyZ0xBcUZFc1pwekNRYVY4TW1vaEQx?=
 =?utf-8?B?bmpSTVo3emlLY2E2TmpuU3k2aHh4Z0pQUTNIa0k0bllqWnNPejZuS2g3S0ZW?=
 =?utf-8?B?NDVBdDFWWXhJM09KaGVqdzlJQ0hITG1uYjE1cHNSZEdnWkJQZUc4OFZDUDFN?=
 =?utf-8?B?OUo1aUd0SmorMlNjcmE5RDl6b05HMUpUS3BEZzdXY2hoekk3T1JYakMxQ0FN?=
 =?utf-8?B?ZGZYWm1VT0czSm9aMmZGVUVWMWl6ejZscXl1NGdKMm1JenRQTGFlZ2NvSVc0?=
 =?utf-8?B?WW4rL1k1QkpFQzRzaGlpU0VyZ1pRaG1QbUx0SVJPdy9uOEVwcUJtNTMrYmxN?=
 =?utf-8?B?a3VkMlYwSDZ2bHZVSld4TmM4c3VCcWRrVHpRR0djM1lwbEovT0hqNEtSWlV2?=
 =?utf-8?B?ZmR6ejU4MWJZR2h6N0pqR29mMlBMbHdhN0VkSGY0S2VXKzdTYkc3ZG5iMmtV?=
 =?utf-8?B?YlppQnF2ZTd6bTcvanN6a0x4UWtQeng3N21HVGEzUUIrZ1NPbU9KM2JIREZ0?=
 =?utf-8?B?bnFxOVBuZ3puU3V1MCtQYURCalJ1bGdUZFo5K245VzMyYW1JUS9NWkhaRHZH?=
 =?utf-8?B?QzNFQWNNSUhsdFM0QUYrTGdmQ1gzWFI1ekNLZEZUTTdQV3doUFlvNzFaVUdh?=
 =?utf-8?B?Y0txVnFqd3FrVEY1QkxzdVVJRzVVWnU3azd4SGJrV2VyZW5KR1l5RlhiMFMr?=
 =?utf-8?B?ZHF4cWErUDVNMVhKVG4wdmE2WXVDaWxUWkVEV1JISXpndFpCV0tpcm9Tam9q?=
 =?utf-8?B?cTNNRGNhemY5anBxcXVRSGpRWFpyQkZhdEJFTlk0NG5FZExvNENwZnM3SS9v?=
 =?utf-8?B?YWd4ZVpHVzAyVTVCaFBrdWJPeFZsNm9UelRSWkpFMi9HTzM4ZUZHSzBoeDg4?=
 =?utf-8?B?UzUveUtLaXk1T0g0Y2JudVlRSmNPSURZVmo4NW9RSkpPYXloNVpnU28zRGZt?=
 =?utf-8?B?UDZYbkJTOXk4V0NEdVIzU2c5bVUvU2RnNitEYlUzb3FpK29VSFRkYSsyeXc3?=
 =?utf-8?B?aEwxWExHTkMvSDNqbEJpOVNzVGVtWExMaThBKzFmNURPbWtFajczblhHTmt3?=
 =?utf-8?B?RG5OSk4wTDU2eHMwKzNPczRMRW5qcnpGNVgyeG1Dc3hOYUlOSHE5eW1odGYv?=
 =?utf-8?Q?zKKJnJUt?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NUQxMWlJbTA4QTZQdVVUU3FsRG9Iakp0WTZlTmZGbWxiU2NicVRWSkgzMWk5?=
 =?utf-8?B?RndXODA3TGxiek03OHc1OHlNdUxHNklCMjRlOFlybm00TEVTVXpWaHdjdkdK?=
 =?utf-8?B?SEI3UllqM2plR2JmRzBFQ0R1OUJCZDBkWUJBMlZLZUhibkVSb1JzbjlUMWJV?=
 =?utf-8?B?VEx3ODR2emhQbTFMZXVza1RpZkpBRTdYU2V6emhKOFFXWVV1Qk45ajFwcEVX?=
 =?utf-8?B?K2g2L0pxejQxaVg1aXhEN1VzUmxlaFR3YXNlSmNDNmxZSkNkNDdQR2VQZUgy?=
 =?utf-8?B?NFlheVg5N1VnZnRIcENWdHNOV0ZXQnlJT2VmcEJ1MFBuU0lBL2lzdVJIcVhh?=
 =?utf-8?B?K3VleDdwQmNRZEgyTjdXcUZKeUswYkY4dVhObWsvZ0RsSUQvSzFlcWN4RDJB?=
 =?utf-8?B?VHgwWVNOQlFwUXBsOGxKQVpiSzFkRjZnWjRZalF6RmtWSjl3VkF5TWxGQTV3?=
 =?utf-8?B?a3I2M2MxU0hCc3F4S2ZnVkZQbWZvTWpMenhoL2JhN2swenF1QVJpSDlJOGZO?=
 =?utf-8?B?TWJET3p1MVFnTlNvNm1pQUVjZWZxZE9QMWR1YjYwV20vZFZKa1UyQ3Y3c25w?=
 =?utf-8?B?VnRMYzlwdXB4TFhjWDNxNmkyamE2QnlibWdWOTRsZU0xSndWUEZ0VHpvMG9w?=
 =?utf-8?B?b0RjQStETFVpVUNkV003WjdjTjc0L1pxdGcrU20wbWJLWXdzUFBCdjZyakRw?=
 =?utf-8?B?NlFLWUtQRXFMbmxCSVNLQkZvNGhEalZCQUFIczg4a2hORlRzRWYyemp6a0tI?=
 =?utf-8?B?THptUXZwek9IVG5mbDA4eFRZNFZiUUR5aUNjL0JBTW1DdDZHcjhJUkZmbGNJ?=
 =?utf-8?B?TjNGM0g2c0FIaU0wdElQbzN6a29OQ1NNZmtvVzdQcjBOUlVrdUM0cU1HOTBO?=
 =?utf-8?B?S2RVQ0pYeXA3b0JZV2dTN05UMDhqL1RsK1NtZFhpRTVhRDdXQlNKeEh2Tkth?=
 =?utf-8?B?bWZRbkdtQ3R5bnpGdWg0UTZlTDJOYXVGQTROZUtDaFBjR2FtUGYvS28yQ0ZU?=
 =?utf-8?B?NXVZakh1aXQyZ1dORkkrVUV3TDU1MnpIUGJ6c2pzajBSOEVVUHgwa1loay9k?=
 =?utf-8?B?SXFlcVB2OVpqYTNUZUJQZFFlOCtlUHI3Z3g1UGY4RWs4RC91WWx3Vk04a05G?=
 =?utf-8?B?S0g3STAxNnRBcTlvS0IrODdBZnkwWm1GSE12QzJ3WktNV3R1bzl1cTFuUXYr?=
 =?utf-8?B?SGRPT0dDUTVlTDBLQmtmeXFWY3RyUGRIOGRuQXhZcTFMNEVjbkdrS0VzWWpa?=
 =?utf-8?B?NUNpbUNYM2JaUHNBamg0TFRVdXBubzhJY1k1eEtnU2xTQnltZ2hvK0dPRFJy?=
 =?utf-8?B?WHBaZUNLUk8zTlR5Zm5FWlVNZDRYamo3MWcweGFVWEh1Uy9GQU5kZnZzOHoz?=
 =?utf-8?B?dzA1QStWOHhoYUNYQWMreStPV1ZKNFRPalJTbWZMb1FXdkpleXVBbFlscHRK?=
 =?utf-8?B?OTU3RW9MWXZnMHlGNzlmdEc4Zno5T3dyRk0zRGJMYUFXdi9qV1FDWFllWG44?=
 =?utf-8?B?SmNxS1RCTGdlUWt5Y0JlVjNKaFMxU0J2anQ1Q0NIZXRILzlka1kvc2RlRWZZ?=
 =?utf-8?B?L3dheDRJZzRKejkrNG4vK3pHY29JZnkwWFhZbTR5WlBZdzhkYSticjFhTkJp?=
 =?utf-8?Q?MYlMpkqRVuYE+5O3qePG+Q+ijNy1Mwn9x7LWcVyd0+dk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB0414.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d9bed0fb-0368-4bfe-8ee8-08dd04727e10
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 06:06:34.3694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEUP300MB0144

TGV0IGFuYWx5emUgaXQgY2FzZSBieSBjYXNlOlAKCnNheSBjZ3JvdXAgQSBoYXMgMyB0YXNrczog
dGFzayBBLCB0YXNrIEIsIHRhc2sgQwoKMSkgYXNzaWduIHRhc2tBJ3Mgc2xpY2UgdG8gMC4xIG1z
LCB0YXNrIEIsIHRhY2sgQywgdGFzayBDIGFsbCBoYXZlIHRoZSBkZWZhdWx0IHNsaWNlICgwLjc1
bXMpCgoyKSB0YXNrIEEgaXMgcGlja2VkIGJ5IF9fc2NoZWR1bGUgYXMgbmV4dCB0YXNrLCBiZWNh
dXNlIHRhc2sgQSBpcyBzdGlsbCBvbiBycSwgCnNvIHRoZSBjZnNfcnEgaGllcmFyY2hpY2FsIGRv
ZXNuJ3QgaGF2ZSB0byBjaGFuZ2UgY2ZzX3JxJ3MgbWluX3NsaWNlLCBpdCB3aWxsIHJlcG9ydCBp
dCB0byB0aGUgcm9vdCBjZ3JvdXAKCjMpICB0YXNrIEEgaXMgcHJlZW1wdGVkIGJ5IG90aGVyIHRh
c2ssIGl0J3Mgc3RpbGwgcnVubmFibGUuIGl0IHdpbGwgYmUgcmVxdWV1ZWQgY2dyb3VwIEEncyBj
ZnNfcnEuIHNpbWlsYXIgYXMgY2FzZSAyCgo0KSB0YXNrIEEgaXMgcHJlZW1wdGVkIHNpbmNlIGl0
J3MgYmxvY2tlZCwgdGFzayBBJ3Mgc2Ugd2lsbCBiZSByZXRhaW5lZCBpbiBjZ3JvdXAgQSdzIGNm
c19ycSB1bnRpbCBpdCByZWFjaCAwLWxhZyBzdGF0ZS4KNC4xIGJlZm9yZSAwLWxhZywgSSBndWVz
cyBpdCdzIHNpbWlsYXIgYXMgY2FzZSAyCiAgICAgdGhlIGxvZ2ljIGlzIGJhc2VkIG9uIGNmc19y
cSdzIGF2Z19ydW50aW1lLCBpdCBzdXBwb3NlZCB0YXNrIEEgd29uJ3QgYmUgcGljayBhcyBuZXh0
IHRhc2sgYmVmb3JlIGl0IHJlYWNoIDAtbGFnIHN0YXRlLgogICAgIElmIG15IHVuZGVyc3RhbmRp
bmcgaXMgd3JvbmcsIHBscyBjb3JyZWN0IG1lLiBUaGFua3MuCjQuMiBBZnRlciBpdCByZWFjaGVk
IDAtbGFnIHN0YXRlLCBJZiBpdCdzIHBpY2tlZCBieSBwaWNrX3Rhc2tfZmFpciwgaXQgd2lsbCBi
ZSByZW1vdmVkIGZyb20gY2dyb3VwIEEgY2ZzX3JxIHVsdGltYXRlbHkuCiAgICAgcGlja19uZXh0
X2VudGl0eS0+ZGVxdWV1ZV9lbnRpdGllcyhERVFVRVVFX1NMRUVQIHwgREVRVUVVRV9ERUxBWUVE
KS0+X19kZXF1ZXVlX2VudGl0eSAodGFza0EpCiAgICBzbywgY2dyb3VwIEEncyBjZnNfcnEgbWlu
X3NsaWNlIHdpbGwgYmUgcmUtY2FsY3VsYXRlZC4gU28gdGhlIGNmc19ycSBoaWVyYXJjaGljYWwg
IHdpbGwgbW9kaWZ5IHRoZWlyIG93biBtaW5fc2xpY2UgYm90dG9tIHVwLgo0LjMgQWZ0ZXIgaXQg
cmVhY2hlZCAwLWxhZyBzdGF0ZSwgaXQgd2lsbCB3YWtlZCB1cC4gQmVjYXVzZSwgdGhlIGN1cnJl
bnQgX19zY2hlZHVsZSgpIHNwbGl0IHRoZSBwYXRoIGZvciBibG9jay9zbGVlcCBmcm9tIG1pZ3Jh
dGlvbiBwYXRoLiBvbmx5IG1pZ3JhdGlvbiBwYXRoIHdpbGwgY2FsbCBkZWFjdGl2YXRlLiBzbyBw
LT5vbl9ycSBpcyBzdGlsbCAxLCB0dHd1X3J1bm5hYmxlIHdpbGwgd29yayBmb3IgaXQgdG8ganVz
dCBjYWxsIHJlcXVldWVfZGVsYXllZF9lbnRpdHkuIHNpbWlsYXIgYXMgY2FzZSAyCgpJIHRoaW5r
IG9ubHkgY2FzZSAxIGhhcyBzdWNoIHByb2JsZW0uCgpSZWdhcmRzLApZb25nbWVpLgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwrlj5Hku7bkuro6wqBUaWFuY2hlbiBE
aW5nIDxkdGNjY2NAbGludXguYWxpYmFiYS5jb20+CuWPkemAgeaXtumXtDrCoDIwMjTlubQxMeac
iDE05pelIDEwOjQ1CuaUtuS7tuS6ujrCoOinoyDlko/mooUgPHhpZXltX2ljdEBob3RtYWlsLmNv
bT4K5oqE6YCBOsKgSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+OyBQZXRlciBaaWpsc3Ry
YSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+OyBKdXJpIExlbGxpIDxqdXJpLmxlbGxpQHJlZGhhdC5j
b20+OyBWaW5jZW50IEd1aXR0b3QgPHZpbmNlbnQuZ3VpdHRvdEBsaW5hcm8ub3JnPjsgRGlldG1h
ciBFZ2dlbWFubiA8ZGlldG1hci5lZ2dlbWFubkBhcm0uY29tPjsgU3RldmVuIFJvc3RlZHQgPHJv
c3RlZHRAZ29vZG1pcy5vcmc+OyBCZW4gU2VnYWxsIDxic2VnYWxsQGdvb2dsZS5jb20+OyBNZWwg
R29ybWFuIDxtZ29ybWFuQHN1c2UuZGU+OyBWYWxlbnRpbiBTY2huZWlkZXIgPHZzY2huZWlkQHJl
ZGhhdC5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIDxsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnPgrkuLvpopg6wqBSZTog5Zue5aSNOiBbUEFUQ0ggdjJdIHNjaGVkL2VldmRm
OiBGb3JjZSBwcm9wYWdhdGluZyBtaW5fc2xpY2Ugb2YgY2ZzX3JxIHdoZW4gYSB0YXNrIGNoYW5n
aW5nIHNsaWNlCsKgCk9uIDIwMjQvMTEvMTMgMTk6NTAsIOinoyDlko/mooUgd3JvdGU6Cj4gU2lt
aWxhciBwcm9ibGVtIGFzIGNvbW1pdCBkMjkyOTc2MiAmIDhkYWZhOWQwLCBidXQgdGhpcyB0aW1l
IGhlYXAgaW50ZWdyaXR5IGlzIGNvcnJ1cHRlZCBieSBtaW5fc2xpY2UgYXR0ci4KPiBjb21taXQg
ZWFiMDNjMjNjIGZpeGVkIGl0IGJ5IGV4cGxpY2l0bHkgY2FsbGluZyBfX2RlcXVldWVfZW50aXR5
IGFuZCBfX2VucXVldWVfZW50aXR5IGluIHJld2VpZ2h0X2VudGl0eS4KPgo+IEJ1dCwgaXQncyBy
YXJlIGNhc2UsIGl0IG9ubHkgaGFwcGVucyB3aGVuIGFkanVzdCB0YXNrJ3Mgc2VsZWN0IGJ5IHNl
dHRpbmcgdXAgc2NoZWR1bGVyIGF0dHJpYnV0ZS4KPgoKSXQncyBub3QgcmFyZS4gU2luY2UgaXQn
cyBpbiBlbnF1ZXVlL2RlcXVldWUgY29tbW9uIHBhdGgsIHdha2V1cC9zbGVlcCBtYXkgYWxzbwp0
cmlnZ2VyIHRoaXMgaXNzdWUuCgo+Cj4gUmVnYXJkcywKPiBZb25nbWVpLgo=

