Return-Path: <linux-kernel+bounces-220948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0FB90E988
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CEB81F23107
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9129824BB;
	Wed, 19 Jun 2024 11:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Mx8RzleJ"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2043.outbound.protection.outlook.com [40.107.255.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8EE137747
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 11:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718796934; cv=fail; b=tgzn7Vhce7Rw+HmDfu00rfVLV+11NF4XCv2UKtN1tn70xOnbG/8m+DIteperfcBVOEMbTctgzTUqaqPLWNYSXkyiFV3kJgznsLAj5IUmCQsCZC4m2GueuANkanUTY9wdjm5v6pS7c17Zv10IVl44Z90wq/pIVr/PTrJAnq1Yjqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718796934; c=relaxed/simple;
	bh=Xe+Ox50WlUE2Sa57FfxpCEbaCEiYHNYgtP3pT6+SJ44=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PGQJQrOsfSg6HGH0Drhqlp4adBoOyABN+oHEo4JtxvKHcfXfC4RBo0ecwND2Z/UsKgGJifohPGmxs1/mFA/8crOkuTUPmkUyI9nDsZXfa8jQXzdJhLLbyZcQ+wekR5WFc+5bZduszSq1WyVFfwdue+qrZ9rWQjxf6Z3pxpfYOv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Mx8RzleJ; arc=fail smtp.client-ip=40.107.255.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPDOmSaFv5HIEHmFWHBSsRSRsI04W10A6KdaYEJAnyVaAUNIDIeavF81FI3989c6n7sgbCDNP3gpIpl/GnjlX/0s5lap/2M0CJV1CuhsQcwGulkyHR2LeCG4kntl6Ag2kMbOW9fIZO0Foggld0vwHlkLGdFRGdjh3yTbFG7yu5Eqf2M9hQV3cuZ3rHOHkc13kDx/yQWOvO9Jvq8+lWookuKSqulwAoNH+3wp0HmMY8qXI0nSM2HP4bzeNmi5ZW0H8KoMSwJ5X/4XYSbRw3lpZxAGnbVqYvAJOkXp/2aONu2AySzgfRuuEiUi3jjiMipoAF0aA5a7wKtVdAjv0QNolg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkT/RWFelGrWavk8k5/0YMJ/jyN7arJ2JV4p3C1/L2c=;
 b=aXyfArtxeosFet1nT/Ap2uypgCO81bD88skviaVoqmxn5IsuxKA6H2vu9KiX8fQnggfGk1Lxdd5/dT6N6n+soRKNefsaLJAglHQCqhQ0m+X1o3IyYZ71xI01aW5xjUMSLH+bjL10MWy40ounb6IouoKD9n+b0i+sxX/vd9BOVtwybEKxPdGBIpsuIY1mlDKbKBS2dEw5RbWgfLnSks2RL3yV2axT/qIJ8WuHj/QOl23q8RuEX3h65vG/jYvwxSU0z0x6P2rzEPHFB48WfxjJ3O/oNoMLUSQxtvRU89d3h/O0O7LDVNBjKb9oLGk7vXRKBAcckdhTqQcbJJUGho4t9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkT/RWFelGrWavk8k5/0YMJ/jyN7arJ2JV4p3C1/L2c=;
 b=Mx8RzleJacUhjceQcEAzYJnEAuhfvDyciuVJX2qxAdwYR7QzzY9zr885Zn7Wh3kwr75n11Ch5Lnlf/qzh7EqWg9E6WSmckQx8g1AIYgD3hXliJ75UvX70Bq2JpIzUxUOrSkVhMkF1jMk1n+LlaY40yb2Hj1qE3cEmntVv77b9F3qkwjF76pcQifvk0jqKexLHg0QIoYAd452nZ8cTI1o7N0xY6JzrHgAqiP8QgZ1ZfGpLh6cpZPITOvwtkzIjSwyXl8Lvi89mX7AXuzLrKd18ToDs/kMkSakfiCIM0TCWt0Fp5zVY+1KO1UZaCKfh276TWiNY8HULc8eD3n6P6LlUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by KL1PR06MB7085.apcprd06.prod.outlook.com (2603:1096:820:120::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 11:35:26 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%5]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 11:35:26 +0000
From: Lei Liu <liulei.rjpt@vivo.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Lei Liu <liulei.rjpt@vivo.com>
Subject: [PATCH v2] binder_alloc: Replace kcalloc with kvcalloc to mitigate OOM issues
Date: Wed, 19 Jun 2024 19:35:15 +0800
Message-Id: <20240619113516.3340-1-liulei.rjpt@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY2PR01CA0006.jpnprd01.prod.outlook.com
 (2603:1096:404:a::18) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|KL1PR06MB7085:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a68cffe-b46d-4680-6fc3-08dc9053ea0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|366013|376011|52116011|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nkt5b05heWhwUU5WckUyQlltUFFYcTNNNHVUSHlrTlpLOW14Yjcxemg0a1RG?=
 =?utf-8?B?emJjN1BPWHN0UGdjMGVqL3l1R09HQ3NUaTJiN1p5eGQ5cnBkVkd0c2xERUtM?=
 =?utf-8?B?c0ZMditJSnpjeUJ3cjVsRzZ1ZThtTC9jQ0w3cm5WaUhYWmN4UU9RZjlKMWY4?=
 =?utf-8?B?VVhLSmwvV3FPM0JMRHZTN2dTRkFrNE85TXg5NmJYeGwwRlZmVlVkWTJhZ1ZU?=
 =?utf-8?B?ejdEaUo2ZFZFYURzZXc1WnhTcS82SkV6M3o3UG5VZzlpUVZDb2ZaRFVrRzAz?=
 =?utf-8?B?dDE1akJQVVNYMlVqMS9lTkRKRE1rdnJVZ3U1dm1Td25xd3dYc284b0xRdnRz?=
 =?utf-8?B?bUFKSCswZks2UjlBTEZoc1Bta1YzR1ZIbWViSWMrNld4OEwwUzFDWkRicmI0?=
 =?utf-8?B?ZDNXRldVTDhacHNFY1EvMEhFNUl3SHQ3N1ZObDNIZGR6dDYwRllEWnRjeW9y?=
 =?utf-8?B?S0pnQVpCTm00dXVYRGFlaTJFSm9sMTJyOS9aSlA4bHhsY3k0Zno2RzF2Q2JY?=
 =?utf-8?B?a294ZlJ2QjhSb3dTQ3RYeG9JZTdBdDJGSWxpaERiejBUaFBBRWVXMHJSNTRS?=
 =?utf-8?B?VlpWYWN3Rm1JdS9lVHBMNWxvbnZmb2tQNG9QRTJ5Nk5qNWpuR2dMQTVXbjBF?=
 =?utf-8?B?RmdsM2NSRzFEWGF3dG9DZlFHVk5nN3MzYUNoN3VYT3pjN2FxVituVTFhL2Ev?=
 =?utf-8?B?MDNTNGRkaTY3cUNIWEV6VmFJeUJqS2tXK21DdUpXbEdRbUlLT1VHV0F5SS9P?=
 =?utf-8?B?YUlTQm5nVEhJdFVidTVuajJHMU9yV2pSZ25VcGJnbE9VWllTNFhibXY5aWpx?=
 =?utf-8?B?MisxcGdJVzZKbkVyY2dLWUg0eVBZcFhzdHhrT3ZKbG5ZMGRwT2NjY3BYcG81?=
 =?utf-8?B?d01DRGlNUVFVOEpkOS9pR3IvYStPU0ppUittbGp6RXR1T2xjT3ZxaW1NWGhD?=
 =?utf-8?B?VkxUaWZkeDlicjE3US9qMDg0VUdVNnJLc3kyQWROUDFqb2FsWWwwdVJpa0x0?=
 =?utf-8?B?bk9aT2JpazRPOFViMHlxcVpMbmptU1RvaUlPWlRiQmZZaDJ2YWJmcDdudTQ1?=
 =?utf-8?B?eGJTN1l2Tk9BYWRtY0RZcVBIbFZ5dDlkZTVGR0M2Q0lxak5xWVlKZThSRjBv?=
 =?utf-8?B?ZzJ2Zms2M2h6Mk5BU0RlNmUyM2RZVThWQlBWRng2UkFtcTZTek9GUUdMUkY2?=
 =?utf-8?B?U1l4dEZoU01PV1pTWWxmR0hQWDJKSDlBYWRlUEVHeFVGNFl1cTd3SFFUOTNB?=
 =?utf-8?B?SE5OYUxWbXRCditkeHpFRW5xMzNad0dDRXhJZTB5SXFNVFYzancyZGpMYTFE?=
 =?utf-8?B?UEZqeS9aM3JOd3pMSEwyR25xS3BlTzB3MHFGYnlrYXVSYVNZaFBoclNXOC9X?=
 =?utf-8?B?OThhYjNUc29iNDZIQ1U3V1owQXkrNW1HNWZVK2FneEhrY045MElZbG9heFc0?=
 =?utf-8?B?anJ4M2RPZGlONWpUaFdnZ0VrT0lkYndtSmlsVEJsaUg1MTlvdTFRNndqOFFU?=
 =?utf-8?B?aFBCZ3V1a3ZzSDdZbGVMNlBwWGJiMEZYazRXWjFqVHJ3NnV0V0cybVRreE9S?=
 =?utf-8?B?Z25zRDdjQnkyN3pBMGs4T1Nmc0NycEswR2ZDcHVkRFoyVVBLMUJUR1FyOTFR?=
 =?utf-8?B?RE5KLzBqY1hRSUZ3MkpwV0VXYkdzenFXd2lYeXhVODJZc21URytMa1RzQTJB?=
 =?utf-8?B?WitOWjU3bi9maTZra0V5RnNCWm9CdkZ5eDJuaG5zVm1jTW9jV1BCakdES1Qy?=
 =?utf-8?B?R21neHE0TVZzZWV0QllnK1JZU1IyQlQzdWVHdDBSRFJTRU1wVHIzZmhCcnZK?=
 =?utf-8?Q?yajUG3B/mg1EmjMirucjoRGVsOQLvddVZgVOQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(52116011)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWVQYmhXSUhmY1pyd2FEQW1Jd1F6azVYMThZVCtVRnp5VVpuREFlRklnK2N1?=
 =?utf-8?B?RHNVWVcwOVhUY0ZsL1BMcHJFNjBQLzdmckM0Q1E1d1NkcElTSEZxTzZ1aFFw?=
 =?utf-8?B?WFVWckRnTHQzblFLY0M0ZWNab3RldUtLQXh1NkI0QUNYNUsrN1BUdWJEMzdu?=
 =?utf-8?B?Q01OeE0wZmpsZVo3U3Q2RkRncHNLQVpoUlR3SEk5Tm45ZzR1SzNyWFo4UTJW?=
 =?utf-8?B?MmtJUXlkQlpocjFaTkIwcHZ1S0oxRFU0S0ZWUWQ0ZDY2VkhMN3NYV2EvOGlj?=
 =?utf-8?B?NXlPVk0vSEVPWmVNSUh5OU9DTEU3Sk84RzBidmdKUmltOGRGQWgwUVJiaEdD?=
 =?utf-8?B?UVByRGJvQXhINWd1YVpWb1pmcmhyK2YzS3hjS29mdFl2RkM3VTRBUzdxOFJy?=
 =?utf-8?B?SHA1NVZkbktpbmpKM0VvZVQ0SC9QbkhpS3ArZGt2dXVGeTFFdzM1a1ZtbDdw?=
 =?utf-8?B?cmpWTXl1NVA5bzUzTjZ0NjhGdEFMeXBBcWxKMlRPRTlCblhoaXljajFqcTJS?=
 =?utf-8?B?M2wzNVdXM3UxWTdpU2o0R2xkdFdWWTgvZlc3YnJJbGdMWCtLWjVPYjZvVW5o?=
 =?utf-8?B?Uzl5c3VneFhrYXdEay9mTWRyWGpKdWlXSlA3ekVsejkyZk9oM1VVVXFuTE5Z?=
 =?utf-8?B?NlRHTlhxNE9xcFRjYkRxa2NMZEszU21wYy9WeTZUSGpVcERybUtkTVRjN0Qy?=
 =?utf-8?B?YnZNWW81WCtMS0pLMzEzUWVXMnFoRHVBL2d5Z015VDNhUHovaGZTdHJ2V2V2?=
 =?utf-8?B?VUhBdkY2Um93Q1dKT0tUSHpQM1BRZWxnQ2tNa3RVcDIzbnA1b2xzM3ZFc1E1?=
 =?utf-8?B?OGkxY1JMMU9wMFkzL1Arak1qQTA0L3ZaZ1FOU1NZU1VlK3NnT0t6NjFpV0lx?=
 =?utf-8?B?anNVUlF2ZFI5Q0JOc3YyMXptZGRaTEpUdHFNekxIbGxzTlpJc2FSaU11aU1K?=
 =?utf-8?B?OUphUk01NUw3bE81SjVsRDBIMXBpRm9HYUJ5QUdKOVpDUkRxK3FGR0JYcmkx?=
 =?utf-8?B?Z1VaOWpIMXBuYTcvTzVuRkpKeXdLV0tDdUxEVVZDdm9LU3ltZHgrM1pvTlc1?=
 =?utf-8?B?ZG5ER0c2RUp2VkloZWJKNnB2MVBhakdRWHJSeGRSZ040V1BIQ2EwL1lITWV3?=
 =?utf-8?B?ODdOekwzTzhrZytEZlp0UEV5S25FSTFvUWFmUFpzSUJNWmdDN2NXRXQvVi8w?=
 =?utf-8?B?cUVMRGRLbFZhYyt2S3RLeE5DY2FXL2EwR09WRlVyNnZDRDRhR1hXdGx6NmpQ?=
 =?utf-8?B?dzBUNTVQNmxac05Hek90UnMrZEh3M09LR0VjdnRSa2lYUDFPZm9EOGg1Y3lQ?=
 =?utf-8?B?Y0V5NUw2RmFES210cWRweWVNcFNsWmM1b2dmOC94eGRJbDNEVkt3alpMQnNz?=
 =?utf-8?B?N0JLTHhTTkt2c2dOeW5BWGNpdFhrZ1ZYSUZuOVo3eVZKRnpLYVJCNGg0SFlj?=
 =?utf-8?B?OC9SMjROZGtCak9BVHZwSnZwRXpicUJlMzlCMnhYNkpQOTB2Vmk3cytzUVdG?=
 =?utf-8?B?dHU2L2c5WjIvSDY4L0FSRG1VS002SElUeDM3WVduSUlLTmhpQ2JRUy8xUCtt?=
 =?utf-8?B?b0RqQnBFQUNpU0FvV1lOYlFENWhpc0wrd2R5SXBya2tnSDZDTmxXWEx4eld3?=
 =?utf-8?B?RHRPQmhGamw4Z2dWd2VJYjFLNjAzK3NOVTk2b1hmdVQ2ZlduSFVmUGVlTGFa?=
 =?utf-8?B?OXZIVk1XZTB6Q1pUNG55N2I2Z3BvaitIeEdJVkcxUHZoYy8vR2xEZkI0WE56?=
 =?utf-8?B?MHl5bnZDR3RnNWVTWG4vZGU3RGozUjc4dFhwb3FXUHN0Y2dkSlFCbDVTOGxU?=
 =?utf-8?B?M21kKzdmOTZmeUxrYXc4dmVtd0x5WnplME5ZSmRHSWhLbHRmNHJJbkpiV2hz?=
 =?utf-8?B?dHNaalRMdGRtSFhyV0srRXNlRTN0bEFQeXlOQ0ZMRWozWHdiMk1GbHNBc0lR?=
 =?utf-8?B?V3Z2bVZlSlJsci9KUXkxSWlHcWV6Yk1iNm95SjJYanZJZkl4SjZFaGNJRTVW?=
 =?utf-8?B?UUNEa3A4aGxjTTMzeUh5UzZzMmV0aHhlMDcyTFd2NkV5aUt3eVN5MnVTSG4z?=
 =?utf-8?B?YkIwcmp2d3pBSkt5WDYzREZTNDljdWFEMTRhNjBBdUQ2RDNSSEJMRWJUTWxn?=
 =?utf-8?Q?2+mT8hE1OW36WFZtOSAnzDRFF?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a68cffe-b46d-4680-6fc3-08dc9053ea0a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 11:35:26.5060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W1Nizy+diTIKIf02UAaELmV2cp4yVWLDtZAc3utSihAMBQaX3f3yCHmmUM+X0S+HV1XimsfN5HUSR6rYskBdLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7085

1.In binder_alloc, there is a frequent need for order3 memory
allocation, especially on small-memory mobile devices, which can lead
to OOM and cause foreground applications to be killed, resulting in
flashbacks.The kernel call stack after the issue occurred is as follows:
dumpsys invoked oom-killer:
gfp_mask=0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), order=3,
oom_score_adj=-950
CPU: 6 PID: 31329 Comm: dumpsys Tainted: G        WC O
5.10.168-android12-9-00003-gc873b6b86254-ab10823632 #1
Call trace:
 dump_backtrace.cfi_jt+0x0/0x8
 dump_stack_lvl+0xdc/0x138
 dump_header+0x5c/0x2ac
 oom_kill_process+0x124/0x304
 out_of_memory+0x25c/0x5e0
 __alloc_pages_slowpath+0x690/0xf6c
 __alloc_pages_nodemask+0x1f4/0x3dc
 kmalloc_order+0x54/0x338
 kmalloc_order_trace+0x34/0x1bc
 __kmalloc+0x5e8/0x9c0
 binder_alloc_mmap_handler+0x88/0x1f8
 binder_mmap+0x90/0x10c
 mmap_region+0x44c/0xc14
 do_mmap+0x518/0x680
 vm_mmap_pgoff+0x15c/0x378
 ksys_mmap_pgoff+0x80/0x108
 __arm64_sys_mmap+0x38/0x48
 el0_svc_common+0xd4/0x270
 el0_svc+0x28/0x98
 el0_sync_handler+0x8c/0xf0
 el0_sync+0x1b4/0x1c0
Mem-Info:
active_anon:47096 inactive_anon:57927 isolated_anon:100
active_file:43790 inactive_file:44434 isolated_file:0
unevictable:14693 dirty:171 writeback:0\x0a slab_reclaimable:21676
slab_unreclaimable:81771\x0a mapped:84485 shmem:4275 pagetables:33367
bounce:0\x0a free:3772 free_pcp:198 free_cma:11
Node 0 active_anon:188384kB inactive_anon:231708kB active_file:175160kB
inactive_file:177736kB unevictable:58772kB isolated(anon):400kB
isolated(file):0kB mapped:337940kB dirty:684kB writeback:0kB
shmem:17100kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB
writeback_tmp:0kB kernel_stack:84960kB shadow_call_stack:21340kB
Normal free:15088kB min:8192kB low:42616kB high:46164kB
reserved_highatomic:4096KB active_anon:187644kB inactive_anon:231608kB
active_file:174552kB inactive_file:178012kB unevictable:58772kB
writepending:684kB present:3701440kB managed:3550144kB mlocked:58508kB
pagetables:133468kB bounce:0kB free_pcp:1048kB local_pcp:12kB
free_cma:44kB
Normal: 3313*4kB (UMEH) 165*8kB (UMEH) 35*16kB (H) 15*32kB (H) 0*64kB
0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 15612kB
108356 total pagecache pages

2.We use kvcalloc to allocate memory, which can reduce system OOM
occurrences, as well as decrease the time and probability of failure
for order3 memory allocations. Additionally, it can also improve the
throughput of binder (as verified by Google's binder_benchmark testing
tool).

3.We have conducted multiple tests on an 12GB memory phone, and the
performance of kvcalloc is better. Below is a partial excerpt of the
test data.
throughput = (size * Iterations)/Time
kvcalloc->kvmalloc:
Benchmark-kvcalloc	Time	CPU	Iterations	throughput(Gb/s)
----------------------------------------------------------------
BM_sendVec_binder-4096	30926 ns	20481 ns	34457	4563.66↑
BM_sendVec_binder-8192	42667 ns	30837 ns	22631	4345.11↑
BM_sendVec_binder-16384	67586 ns	52381 ns	13318	3228.51↑
BM_sendVec_binder-32768	116496 ns	94893 ns	7416	2085.97↑
BM_sendVec_binder-65536	265482 ns	209214 ns	3530	871.40↑

kcalloc->kmalloc
Benchmark-kcalloc	Time	CPU	Iterations	throughput(Gb/s)
----------------------------------------------------------------
BM_sendVec_binder-4096	39070 ns	24207 ns	31063	3256.56
BM_sendVec_binder-8192	49476 ns	35099 ns	18817	3115.62
BM_sendVec_binder-16384	76866 ns	58924 ns	11883	2532.86
BM_sendVec_binder-32768	134022 ns	102788 ns	6535	1597.78
BM_sendVec_binder-65536	281004 ns	220028 ns	3135	731.14

Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>
---
Changelog:
v1->v2:
1.The call stack for the OOM error during the stress test on a phone
with an additional 4GB of memory.
2.Corrected the error in the title of the test data table.
---
 drivers/android/binder_alloc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 2e1f261ec5c8..5dcab4a5e341 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -836,7 +836,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 
 	alloc->buffer = vma->vm_start;
 
-	alloc->pages = kcalloc(alloc->buffer_size / PAGE_SIZE,
+	alloc->pages = kvcalloc(alloc->buffer_size / PAGE_SIZE,
 			       sizeof(alloc->pages[0]),
 			       GFP_KERNEL);
 	if (alloc->pages == NULL) {
@@ -869,7 +869,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 	return 0;
 
 err_alloc_buf_struct_failed:
-	kfree(alloc->pages);
+	kvfree(alloc->pages);
 	alloc->pages = NULL;
 err_alloc_pages_failed:
 	alloc->buffer = 0;
@@ -939,7 +939,7 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 			__free_page(alloc->pages[i].page_ptr);
 			page_count++;
 		}
-		kfree(alloc->pages);
+		kvfree(alloc->pages);
 	}
 	spin_unlock(&alloc->lock);
 	if (alloc->mm)
-- 
2.34.1


