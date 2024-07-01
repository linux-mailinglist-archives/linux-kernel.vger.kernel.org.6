Return-Path: <linux-kernel+bounces-236123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBA191DDC4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 319911C220F6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA81713D625;
	Mon,  1 Jul 2024 11:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="LkMDfJeW"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2100.outbound.protection.outlook.com [40.107.22.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3AF376E7;
	Mon,  1 Jul 2024 11:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719833043; cv=fail; b=qDFHG+o0CUx5BBxi/KelhoUm68fQZn7mP9XFaBWeZwDdaUuu+Jcto3SjkqxpCsNEt2sFX/PQq6PzLgqbwNCaQA0EjkvT41Q8u0J0siWnP6HyEAfRb5OJzZHiMGWdFMQudkYDxjQGxn545228S7rUpVyG9RyO7rpfHT8xPDg/qYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719833043; c=relaxed/simple;
	bh=92e9s33p0cUqIzbc8M6A8n3ZIabVFiKODYXwsDkcQ0g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eUnlVTRmGvUiEc26x7KDi0jPNVS0Wx//iTog0xpusq9lWkHMW+Z02F8uZSsuI01DnLWnPHIfozuuoGJzHVreBO+bz4V5xrVjselE3NS8wz0TdQf2h2taXYt7a9vzFeYtjnIlfjFljRErZQHIVnjqYWlVGlubnPcy5kNzpNhzZbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=LkMDfJeW; arc=fail smtp.client-ip=40.107.22.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9zOL8BYRbJOFDjKr3BmeS2X3M+1+Fi9Luuay+MF6wqCTwSGQjtrNSILpzLcOaYuR2+e4rJ8inMIUXFhctVBLUtkS8S7OhTsz3AwiQn8I3m6VWbb/2uSiAb/OpDi+2ygVzQu02DrNhXiqx//8r04j2SU+jK/CTkIKvZCel4GFaJlrGxmq1X6lfRLGytHRdBjbmEu3x2PeUWmZ1AjI9dnsJKOpf8eTP7ozpDHDbeWbEyxv5QILPSYNtf1XDiu2M/yV3TNjCeHpHfcmagpQOrrAoSnYsjxeVRyacIRJViCdyK5ChaMbDZcGacXQk93vnsgwPvc+uBCe0E2fXygqPUnoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/9adfULqZ95uBYfhBB4BpshR0xlQ4MjiKdg5wEWbBI=;
 b=n0GKCmSNQcKlmZKOPryk7LizYHZdeU+ou6vfTyT7WUJBTBe5yPgQn3piTbU8yTo/qkiY/+6D6y1RA36XvZV8Tv5YJTHEVLD/qZVpe1CLApug4AQ8H3XfK2PWwB0eqjz8GPg9NYG+v9GCmFZ3t5RBpX6QFeCqSO5VudbHhVGMLBDVJizMEtJ6UyXAW+ssuZUHyAMsm/kJTHpHLNV5Qno3ikLF2+q1nRpZjVWrPOXB7xqbUSVJbMUnPfy10goF9UvlnxGKCPXJLZek8GCwpewRj/Tnxw4tlLZpBQW+v5raqT3qWqT8rRraRcCLQSAkohNhLtDfTg01P1y/jIHVdQOqfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/9adfULqZ95uBYfhBB4BpshR0xlQ4MjiKdg5wEWbBI=;
 b=LkMDfJeWb7OcsW/aiTQGH+HNT5kVf5R5vQKzpiQEY38N1oEg5nkL5k9yAIFv2uJOVCisYIFhwGZnvnvOw3+gYm7l0YTPIu6mDsfbeIP7jeVrMDWawCGhPMYvzssK8WZto34jSy3xpHxDR8ZQw+Z3AF7Rw7pFfBgXDAA2J4RWTEE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by DB9PR04MB8266.eurprd04.prod.outlook.com (2603:10a6:10:248::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 11:23:57 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 11:23:57 +0000
Message-ID: <e1933ae1-af38-4c17-b36e-33d43e90f057@cherry.de>
Date: Mon, 1 Jul 2024 13:23:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] hwmon: (amc6821) Add support for fan1_target and
 pwm1_enable mode 4
To: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240628151346.1152838-1-linux@roeck-us.net>
 <20240628151346.1152838-5-linux@roeck-us.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240628151346.1152838-5-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0026.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::22) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|DB9PR04MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: 09ecb08d-b04c-46ee-92a5-08dc99c04c88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXZ6dmxLR0wrT0o1bEJ0L0dGbG5JbGl4SUlrSE0zY3c4SUtQYmxHOXYxMDJu?=
 =?utf-8?B?VnVNemZZclUyVmoxRVp4WVg1b3gvaE5RQjdNSUlJVTd0RlZOSGduQ2ZZV29a?=
 =?utf-8?B?SW1UbFVJUitpRFpQeEtrYVlab0NQUW5hSXRTSmhWVTc1WElUUmIzQmZiMnd5?=
 =?utf-8?B?TVRyTVZsZVZWZkhFS2tlUms0bVp6bkhQdlBPeVB3OG9FK0RGajV5dG4xa0pl?=
 =?utf-8?B?SElvMmRNSXlMdXdicFZlS1FlUUxpUmVNaGc1TWw1SzJzaG5CanBLS2lJQ1p0?=
 =?utf-8?B?K3lBMDUvc0RiY25lam1OcndBUmJFeWpIRGYybGhtYlBCTHpEWERRUVFGWGxl?=
 =?utf-8?B?TFZkQkVWSkFIaEtld2pwcnB4em5WblVaNEx5SUJhS0VFSkhscUgxR0dOMEZC?=
 =?utf-8?B?L2JiZ01xTFBISVhoZ2lxVVBSVUJuOXhSTmdVaXg0VUoyKzdibFFBSnlTOVY5?=
 =?utf-8?B?WmhNNVc0c2poWVdKUHFkaVBIM1pWbk1iOG9zNU1iWW9JWmNKMHl2Uk1INWFC?=
 =?utf-8?B?Y3k1M1k2b0JYTXF1amU1ZU1CMkVmQzdTRUZwTzdtYWRkdjA1NXh5Q1dNRCtv?=
 =?utf-8?B?M3RHSmdlWHBIYkFGbVg5bWlyTmJ2UjVKcmFkVGxFNE9Yamg5NXIyM1lXN2ZS?=
 =?utf-8?B?TlZhUm5mM1cyM2JPMjZnVVo0YzRwY2NsVkNSMEpwZ3Avd0lqeEVZaHNLMmlP?=
 =?utf-8?B?ZVpFQkZQbnduMHJ5dWp4QXBZR3RjTTRLQWEyZ3kycm5peFZFSXZYbWI0M1By?=
 =?utf-8?B?c1Zjc0lWVUcvenJjcVR1ZGhET3p3QzJYYVZHWmI4VlVNUng1N0Nydm5JTWxz?=
 =?utf-8?B?c010czBrek96SjhMdDNWWmtRdkF1TkYveWk4VnhaMk9Xa3ZxOTFwck1ES2hn?=
 =?utf-8?B?a0p1dEh1UjBkYUlnclNwVmFuUlpJeFdoRGdZUnkrOVA1NEJPeXdmdkk4U2FV?=
 =?utf-8?B?MHZpWnRzL2dnem5vZ3diUWcxNUtiSG02Z2ZZVnAxUm9DSVJKRXhYSGVwRlJ3?=
 =?utf-8?B?S3R6RzFEcHJWWmtCeXpCc2dJRmdTZDFMZEdkWFN6YzVoTkt5SXpRNUhkdDg0?=
 =?utf-8?B?R1Z0ajBRQXg2Y240Q2lrY2xuNmpKK2U4Y1kxM1Z3d1ZRWUNsUUFDWHUvaUNw?=
 =?utf-8?B?aTdGT09uM214YVFzeDE1dWdHS3NlbTJTa1RyeWU5b0hKR2ZxRGN0cmZ4TDZa?=
 =?utf-8?B?TC8zUlh4Y0VwVTdRZ1Zwa1ZucFp1VWxTaEJyV0l0eXpyc1ZZZ2xGQXd6WXRT?=
 =?utf-8?B?SjNJRldRT3pMeC8xOFlaSlhwckJzeXBVSjVWaVM4MGJpMTltbElOK05hQWVl?=
 =?utf-8?B?cEp3OHIzdjlWdTdLQWNqWmlJNzZ3bWlOVENiaEZ6VFczNXRQbXpFOEhvZWhW?=
 =?utf-8?B?SkpwUVhCWXNZeGdNbUhkTE12R21JQzZWR3A2WVBmOWpvRkFFeUhUczAwaDAv?=
 =?utf-8?B?ZjBIcENqWVRYcnRUQTIrSGF4Wjh3T1FoZ1EyeTg1UWxGS3dlcEtTYWxhbFpu?=
 =?utf-8?B?MzV6ZWdqTy9hUDRKalBXN24wTThhSkFEYUFudll6K1RBUXNFYVpJMzJtbEFB?=
 =?utf-8?B?VktJWTFEV1FFVE84TmVQQ2tnNlYvbnZ4MGloWmdEc1pRaGhrZk4yNVZyQTl1?=
 =?utf-8?B?aWtoYVJ5VTlWRGhWRjcrcDFSRWN4SHBGQWlzU1Q3cmtYRVV6Um5QazU2SEYw?=
 =?utf-8?B?a0FqMVBMeWwvcDJzK3luK1Fpck0wbXFVZytxc0xIMkFmaDUyaXd0dXh1U05k?=
 =?utf-8?B?ODBsczdWZzVpRHRJbmZMR1VWaHdEc292bVFpenV5MFQ5d3RMOVI1ajB0VUE3?=
 =?utf-8?B?K0lKYnE0V1dqdmpwZEIydz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDRUZzFLMVRhZjJrYjdYempBa2c1em9PNUNZRWt4bG8vdjlydkpWczA0blAw?=
 =?utf-8?B?djVMa0I2RWU3Y0JwRmQwVEZXWGJwTzFGSXRpZ1ljR1hJUUlDTUEwWlovd2pS?=
 =?utf-8?B?WGdkOEJOeC9qQm5hZ0MydkR1ZWJaQzdYNnBjbTlsSkVKbHFlQVN1dWQ2Njhh?=
 =?utf-8?B?L2ZqdnBHdFcyajYxaTZCOW1tdlRlQ2RuWmxTbjhGZkN6MS90T1ZlVFhxVTR5?=
 =?utf-8?B?bWVXazFFcDFzYlhHV3dZYnFCWHFwdVVpTzV3RFhXNmh6SjRVTzdMS1NtYTBn?=
 =?utf-8?B?QnkySmVINzJ1RElzeExqMUxHd0RNa3pWSFY2bksvRGxSUnZGdlpzQ3FXWVJZ?=
 =?utf-8?B?NStGdVMrQys3ZHNHM2lYRDlrN2FIWng5M2lzN2NBWHh0T0xzVUxEMklQRjFY?=
 =?utf-8?B?clFNRE13R01neDVaYmc5b0I4TUJsVDJBQTVhTkJwVlhkbVZZZUZrS2s0Qkhl?=
 =?utf-8?B?SllVWi94M0U1emxVeVNVL3NQRW56b3psWitRZE5QTlZiWGJjbi9FSlRlcmR3?=
 =?utf-8?B?QTl0a0I5czFRQ3V1MElERzJ2aEV6RXh6ODE5V0QvVC9HWmZVdkQ5SllMQUhW?=
 =?utf-8?B?eXFocHRadGNZTTI3M3BpRHVhQjVlc2VVOUZTSjFOTCtiVU9RWFpBOFFmMHpO?=
 =?utf-8?B?TkNvbjE0WDB0a1pRZFZoUldESGlUQ1JwalJ6L1B4Q01nbGZ1QTV4VWQzckNv?=
 =?utf-8?B?TnhlRzlWdVBFck92ZVVpVTRXUEZUN0NhTlJSRXMwL2tQTlFuTEdkSTMrRVJi?=
 =?utf-8?B?eGdHQlBwa2RhSjE5bm5FSDd2NnVuajhSOGFxZ2RHTURwK2pucVM2RkVYZnNr?=
 =?utf-8?B?U0dHT09VZy9ua2Rlb28zL1FBV2tiS1Vja1Y4MnB5cVZaRXJGOUJoYVhjTU9p?=
 =?utf-8?B?SjBZdVdCQ1M3TENMNkV4emxHQzBpTmI0dTR0dWZnN0h4OUdBU094L25aMG81?=
 =?utf-8?B?WU5uUW1QcHZmam5va25Rc0pFZDRjSDgzcHRTSnJhU0xJYWl6S3NvZE5RcW9o?=
 =?utf-8?B?alZxWU45VzBHRFlMdktzbmhiZ0FvUlNuei9zY21iRW9vWWhpdXJjME0xNlVi?=
 =?utf-8?B?cWljYkpNU3BRUHdmYzhjb1Rabi9jOTloOTZHWTRJWThiV29zbHFMVlIxMDFv?=
 =?utf-8?B?NXdMYjh2aGZzRlZNeFppS0MrWTNwZXBZckJTSm40ZElaRkNOTDNYUnQxb1BF?=
 =?utf-8?B?OXYwcFpOL1hUU2ZNN2ZEaXhOTnNDdXBzczRFU2ZGMitOaXZNdFFqWkMyOTY0?=
 =?utf-8?B?OW5WcEYwZmxqbFZ0Um0rTlh6YUtwY2pOV3VieGcxdnJVTXB4aXhlU01RWm9E?=
 =?utf-8?B?VFZkbml5eWZjQk5xL2VxbHBSeDVwWDNyeEJwb1VFc0JsSWx6MFAyQjc4TmJ4?=
 =?utf-8?B?VWRJMUhJaGZRaWpsZDByZHBIVDI1RFVURDNCckF0V1NNeDJPUTJ5VGZoclZJ?=
 =?utf-8?B?YnFCbDhlZk1tTFgxZUFWUjFKTmxkdGY5Uy9yMEVuTUI4Zm9MRnFjL0hnNWN6?=
 =?utf-8?B?Vm9ZZ1lqWGE4dm1XMHh0RnpaM0hNSkEzVDZJWGhTY2h4RVdrRmNUUkRGK1Ev?=
 =?utf-8?B?Q2J2Rzg3cVBxQWdFWjFBQ1UrZ1puL0ZIQlduODVZU0lnWU02QS8rTmJEME55?=
 =?utf-8?B?L0tTWVlES0EvMndadW03N1ZJd3FqZHFjekNySUxWUld6Z1ZIKzJvWGYyM0hu?=
 =?utf-8?B?Z3ZrY2FOQmNWRnNJeDZpMW53RW5tZEdzN0xRTWVaNVViaTBhcXBVeHkzUmVC?=
 =?utf-8?B?azRMM1ZnVUtkTWlFdCtLa2VrcW8reUxyT0VEdlk5SlhidHVmZk1KTUthVW8z?=
 =?utf-8?B?bzZMS01Ia1p0cm9wSXZrNTJMWEF1eDI4cDEzT3cyT3NNK2l2YytiZ1gvMWYx?=
 =?utf-8?B?UlJUdnhRdFM4YzdjVmdXTWF3L0F0R3dzMGJQeVF4MFNjZHNXenNxdzRhN3I1?=
 =?utf-8?B?NUVKdFdBZnZtOVRuV28vZ1ZvMVZBaGk1TTI5bDNUbTJDQXRMQXVsZFpTWFg5?=
 =?utf-8?B?VDBGdjNoRzc3RFEvM3c3b09BMENxZTVvbEtTRnFFbmlsNVljTjhva09CSjd5?=
 =?utf-8?B?dlp6TGRKMzh1QjIzaU1GTS9CaEVJckNJcFREMmd0K0pONHgvVlc3NUo2cHJU?=
 =?utf-8?B?bUFmMjNlNStNNU1hZW5QWkhnMXRqYSt3VDVyeGI0c1VadTl3blhhTHd0aGpT?=
 =?utf-8?B?SUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ecb08d-b04c-46ee-92a5-08dc99c04c88
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 11:23:57.8304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Do5D1aRDQFtDPtteO1sMztEiy9Sm7vMsN9KQ/o04vPCWAp4MnXyZTE829IiY7u/NyRpxFLP1c48Wcyoocm7MiPTLbzN7loaTKH1T4kvOUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8266

Hi Guenter,

On 6/28/24 5:13 PM, Guenter Roeck wrote:
> After setting fan1_target and setting pwm1_enable to 4,
> the fan controller tries to achieve the requested fan speed.
> 

There's something in the docs (section `Software-RPM Control Mode (Fan 
Speed Regulator`) that rubs me the wrong way though.

"""
When the TACH-MODE bit (bit 1 of
0x02) is cleared ('0'), the duty cycle of PWM-Out is forced to 30% when 
the calculated desired value of duty
cycle is less than 30%. Therefore, the TACH setting must be not greater 
than the value corresponding to the
RPM for 30% duty cycle.
"""

TACH-MODE is never modified in the driver, so its default value prevails: 0.

I'm wondering if there isn't something we need to do to make sure we're 
not under those 30% for TACH-Low-Limit/TACH-High-Limit/TACH-SETTING? 
Forbid the user to write (or clamp instead) <30% duty cycle. Forbid the 
user to select mode 4 if current values are <30% duty cycle, or update 
them to be >=30%?

Otherwise, looking good to me,
Cheers,
Quentin

