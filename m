Return-Path: <linux-kernel+bounces-310403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85454967C46
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 23:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040961F21707
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 21:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3E213A41F;
	Sun,  1 Sep 2024 21:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="jQ20NElP"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C648520DF4;
	Sun,  1 Sep 2024 21:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725225097; cv=fail; b=ooz1i7LG/TMebZskKUzWxZ5Fu2Ru3cY1I43xxf4cRnEI+IcU7sUCTws+UEdHmEwBsxzrX97EZ1HV7Wxv3FcTur1cnv3ydIHBCxdowUpkGJrAOGXnvx63h7FUCFHZ3YuxjXcToJP2sXk2y8VVx2pTs1Ah2s2tkPEnWgxnU6TiaZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725225097; c=relaxed/simple;
	bh=ybIVUPe4m0TuctROc6eYqHxppmK+zIgTfaa8to/c0DU=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=kn4PXRZQ8pT+0lApM2vDbS7SQdsMJb5gD2QfOB9oKozLpY1O8gqjTB4W0hE+SGehX1RBoUevyXswT60cnjo5FZrDjQPUAo2qJ1TJeinfxCUAxgsl67oPvEihEskR6r0/jXUXAkrTwF9aovPcEg0h0YtGmvxtpPFNl77t5i48TJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=jQ20NElP; arc=fail smtp.client-ip=40.107.21.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dv338exeoNu1qBFND0ADWiU3CxYm0hxZTKMe69w4bBm8LkHSFbN0MkFZgVIUAJ6oeQUQ0MWyR9Ya5CisKcFj7+YECbfmtrXB6TjFczKyhpsSs7284Pyh80NyVLiJUMHBJC1jzB/8wDR+nEeByKTIn+PaB1hBb2OQheKTj/wrTLSD7kS3w/RxrmduzN2xXtI2oHUpcjVwujEWGkI8wMa5S06QuOpQbfubjUq0FLhFyovR7Dg7vViKCJRoX1nYvRMvGpkBBmsNVXJ8J/c9vtajnETpb02wn9C3J91CJcjUK/2sxNeUVkTyICaNOdFBMJNEhb06k+MCebgHlIfrEHTecA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZD9O8r8QT9doUuxKWhunpIlZLLB/E+hRg9v9jqSk7kM=;
 b=exRHv32/eXeKg41Bz/wcJWnhg1S3U80J7XQWuaznR7iLHX6t9MbK9JIE94aqbpNtjYJlEPYeDloiDe2qAarc0FAw8sRO9uGifCzRaAU672PxzgpzJzLqEswziMGe1iMfF9N9hopZrp+f6lB1s6lHl6Tdo3fObCnZrJ58AikOZFzLtxwZaMq5ckpB3n129HcYAcsWZfZudS5xRfRIaFgfFnp0appK5yg4Z7RUZrPOK1MHuDzgjV8y2N063Ckj6FjDk1UawlvzkkKGK9ORgiglD6i+w+5J3FInTF/JnguLkJxG/vUceUGMte1S7dVDImbVi6o3W8Hjmnc9XiMtMjC+sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZD9O8r8QT9doUuxKWhunpIlZLLB/E+hRg9v9jqSk7kM=;
 b=jQ20NElPpJfIS3NAbotSiGACQSh20vbWTih3sFlZPJ3HUABfG3PPLlTqDQwsvd8FihVznJb2ozSIodGqKXJFCFwG8/Z6isztkWyQjbscis6Gq7xl6KHtjmhx99fL6UnjpoIp1uk6G/iaBIbh9w52yFNNFR8b/O+bZaJaZlUvaXpTLmnbB9JWbJ6bJkNTP4wd3Uu0D0CquztIjj/TI5P+48ry1p/kF+/kVN1LW+K5h7yjrTBe+ThhGvpATgiay6vAxlDdsxdd+rmwDf05pHlLKTDWlHGsoQn7/bm1eY99c6TYx+j5FRY9V9Cu3BDDviDFKreUrRVoMskQmqaJziTiow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7118.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Sun, 1 Sep
 2024 21:11:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7918.020; Sun, 1 Sep 2024
 21:11:31 +0000
Message-ID: <a07922bd-4550-41d8-a7cd-8943baf6f8fb@siemens.com>
Date: Sun, 1 Sep 2024 23:11:29 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] USB: serial: pl2303: account for deficits of clones
Content-Language: en-US
To: Johan Hovold <johan@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: d1840ae4-1b73-4e41-f7f9-08dccacaa6bf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzhBZ2tsZHA1Z3pCUS9KMU9YZXFOV2ZjNnFLQUVlLzRGanY5eit1eXpPVVJ1?=
 =?utf-8?B?NHFLUi9CRTl3dUlETXlxODFLNnprbU0wNGtPUGE5TFgzdmpabitmem4rUnF2?=
 =?utf-8?B?cWZvSVJoVDc3dkZEdG5qdjRUVFZWTyt5WVFSeVNDZVZvWnpMQ3JONCtTc2xC?=
 =?utf-8?B?dnZiRW4wR3lqZTk3L0ord0xTbTJkWW04dERaNjhhQ3NJdkF1bzlYelp1OVph?=
 =?utf-8?B?b2YzMnFjaEM5Z0g5c252MC9YdXpKZE14MEVEblZoMUdadjAzSElMQmRHRjFs?=
 =?utf-8?B?dURUNVhFZWpiUTh2d25vc3dZMlZnM0hRVnF1ODVqazVHa1EwUlhsSklLQ2dB?=
 =?utf-8?B?bkkxa0l0K0FqcDBmZ25TK1A2SFJUcG13SGk5TW5VZW1aSCtXak1LQm5GUFdS?=
 =?utf-8?B?azl2eGNFZ1l2bGY2UXBPTFVEZUxRQVZRTldHbW9ObFh2eE93UVRTVmU5THd1?=
 =?utf-8?B?enpqUVJUUjBOREppQ2hiMFVZVldXSVVMVUsxWW90M2ZsVVhjNDNtVVZXZDhq?=
 =?utf-8?B?SXpsTXdXRlpNMWo0MXNhemNrRmJGOWhGMm5YTkIxU2xOZnd4MnhGa1NXU0Zo?=
 =?utf-8?B?ZGI3cDBySlVPZkZRK2l2S1Z0L1Q0ZDhnN1ZQaGdzbFVNcVJwS20ydU83R2Zw?=
 =?utf-8?B?Vnl6cnNaM1VUSGQ2ek5PTmdmTyt6Y0h0bmJlU0N2NytyaE5uSkpqMUs0aE1N?=
 =?utf-8?B?U3UwSkRBUkJVUDg3SnFTSnA0UDZmQ2l1QmJ1YVdYbkV0alF4N0NnUjhHQkZZ?=
 =?utf-8?B?eHp6VDUyNzlhZ3NsVWFHN3BqNWI3OG91am9zZlU3QStQUHJFWXpwWm5nTDdo?=
 =?utf-8?B?UXFSUlBSTGFxUzlLZTgrSlhvSUFBbDFrSk1RS1hjRGhEanM5NFg3Uit0Wmpo?=
 =?utf-8?B?WjRGTXhkNCsxcndXM3Q3RlN2eDh5bzRMV2k2UzJPVkNoeDV2TFlValJUZGNN?=
 =?utf-8?B?d29wc2lkWGJic1duS3ZBdUdHNXNKc0hTbWJlWUdrTWViWDBhOVhIUGg5SWFx?=
 =?utf-8?B?QVcrWS9pTk9HcERKcDFaRSsyUFNxbDJORGVwUFpWakdPdnpiclhXWXBISHI0?=
 =?utf-8?B?TmRMb0w4R0N6SXpQeHovNHBsTEJpTXVwbEFIRFVuOVljR3laVDhMMWRYU2hr?=
 =?utf-8?B?OEw2d1dCNzRmbHFVU3I2MlVlL212eDlSTXB1OWRhSUh4eFg0Z1FvMmY0M3M1?=
 =?utf-8?B?V1pMbW1NZFJlbVBNOW9QcUZsek12VzY3RU5vbE9MZkZCc0I1RERqei91RlYy?=
 =?utf-8?B?ZFdSRUUrditJUFllSGVhQXhFdGlnTWJIb1lDV0RDdlJjK3h3RDJpVFIyTG5y?=
 =?utf-8?B?akxMVTZFdW1TMmVQVUhxdFQvcTdBMjBBY2VVYzdOZk1aNElIVHhzRUp3MUFH?=
 =?utf-8?B?SzlDbm5UbWdsU3ZQTjBZQnZjK00rTlRRSGs3dGI5VjVhR3ZZOGVhT1gweE56?=
 =?utf-8?B?Vnk3MDhXWncrQVR3T1ZMUDhzMk5xWUJDTGtoSS9lTnlwUnZEbUt4Y3hXbXJU?=
 =?utf-8?B?RDQ2dmI0TWtvVW43N1g2b1ZYa2V1ZVFoQnhlZm10WmhDRHI2dDJRbkxiNDRC?=
 =?utf-8?B?UjJEVzJjSmlMR1ErQnJ6aHk0ZG5qWTRMNGdJNCt1TnBaalBLanBYbHVDY2FR?=
 =?utf-8?B?eUVZclBpd2tVUlBBQ3lJYzV6QmtCTFJXcjdTWERiL0dNVkV0eXZvVy8yTWVO?=
 =?utf-8?B?VnlEakVjVEgwcEdHenhXdVc1MkY3bHpGbFdBT09ySER6SS9ldzBsK0psS05j?=
 =?utf-8?B?eEhlWmExYmZ2aDVPVHBHcnhERWdldFlZM1dIT3Q2NnBuQUxKSEMzK21yckEw?=
 =?utf-8?B?YjhlWkowZVNmOWlnMWdNZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TndPQ2ZraDFPWlV0Sy9XZ1JYUnJ3a01YYkloSEVScVhuRzEwTW5ON1RXUU1y?=
 =?utf-8?B?MWlvS1lTSlhiVkNsYjE4b3ZyTFo1OTlQbk1pb1NhQXdqcW9iWFRrdnhHVTN6?=
 =?utf-8?B?eWsyaFRWY1oyK05nK1pBR2NiMFFrWFp5NlIwTzBHSWdRSTE4eVFZL1VsZktC?=
 =?utf-8?B?dDU1ekhwV29uclFoTFg5dVZSSlJoajhSSnJjT0srclM1L0xLZUlCOE9CbFpV?=
 =?utf-8?B?c3lJK2YvVEkzNzB1dEFDTTZieFlUcGNJdW9YT1FiN0NjcWR4WXlEMHpSRnR6?=
 =?utf-8?B?NlE2S3BMTzE2Wnk5R1hvbUJISXBtbVpWMDJWTnFBc1cwQnk2d25GK2cvNVZX?=
 =?utf-8?B?cThKM0lIVGRycGhBWTN5Ukd0OHVzeTdGRzBKU3NTS2JVRTNEUkZRK29qeU04?=
 =?utf-8?B?SHA2azRRbG1kN2RBd0NaZjFRRjl3a0FYRS9UbUZVSElONXMrYzhIQ2h0a0hZ?=
 =?utf-8?B?dmpXbE5lMm9rem5pTjN5bGxLbGFJMzMxMXlsSXQwd0ZoV2NCWXpwQ3hNY3FP?=
 =?utf-8?B?Mk51NmlYcGpTN3N3UWdmTllDZjJLaTVWenhVNU9qUFpmMDZ5SjlQbHk1dGZN?=
 =?utf-8?B?OVhwYlJqWW5HNjFaUE9GKzJReE50WlJmd0pxVldtN2pLNUtqR3U5ZVIrOFh3?=
 =?utf-8?B?cytNMS9ZTDZZT1p3Q2FCWGdVZ3pEaWtaQmsvNjlnZmFKNDg3U0JjdjZXY2hI?=
 =?utf-8?B?bzVTV2UyTi83Rmd0c1BHcWtSTnpJaW16QkRLVmlETEdoTEhZNU1mREpMY3dK?=
 =?utf-8?B?YnVoZHpJZDRWd0k1ZCtpNHpqUHA4N2hiNTl2TDRwejMyeWxvNHhSeWNrekZ3?=
 =?utf-8?B?aWJuVHJXQU4reDlxR0pjVHhhV3Y2VWdzVjdNSHViUjhvSkxreU45a3lLQWZp?=
 =?utf-8?B?NnZmWXllUXlkd0dOZ0xFY3pHTzlLZ20wQ2Y1UmlFZjh5cm1Ra2NWUExPUkdY?=
 =?utf-8?B?QmN4M0RnUUcwVEZOTG5iblVHaXpxR2taUSttSGtnMktaWWFFeHRMLzVPTHFK?=
 =?utf-8?B?ZThZVU00L2VENHh2Q2F5Y0VnSWJJcTA4RVhOTE93OU1ML2UzYWh4THdTSUxh?=
 =?utf-8?B?QmZCVnZ2MUZOS3JjY1EzU2hUcm9BS05rQzk0MDBnR0hPQUtTVnNNYWVuenh6?=
 =?utf-8?B?NTRvUGx0dWZ6eWlHQlE0TVJnLzFiZzhEM1JkVW9kQzZaU1dXUXNCTDhQUDgr?=
 =?utf-8?B?YTNROElrbWtpZDUrbndadVNvWG0rMWkwb0ExS3AycTA4R2JpbVJmWmtEeGdQ?=
 =?utf-8?B?YUwzVzVYaFp3c3d1UXNrbFpVWXh0OHYya2hqQjVaOU5SYXJweFRHU3FpRU1U?=
 =?utf-8?B?cXlnODFzSnpuejZidFVOcEJaNjRZc1NTa1lTR3lwWkd4bGFtZ2J0by8wcC81?=
 =?utf-8?B?QThJM25iL1JEQTFkRGw4RnB0YWtmenZIdEVJZnhNOGttN1M2aVl6MEtsd2p5?=
 =?utf-8?B?a1N6Y21lMFZGZ0JTZUQxMXNrem02Vno3Y1ZKWlhWbVl3Y3RBUkhnZTM1c1lG?=
 =?utf-8?B?aUs0b041cjdZWGxxUG84dGhOb3dEei9SSTA0Sy8xS1RXdUtkUUk1a1RqSVBi?=
 =?utf-8?B?UXc0YzBCRkdVTnZSRG5QSVordVM0MDl2cllJZmtpWTdEeGRUalB1NUhZOFdp?=
 =?utf-8?B?aWRYZ0t4TTR4ZDNzT0EwOXkwNUVHTWh6R3E5SmM5OGpzRndOYW1TbkRLRTRq?=
 =?utf-8?B?czNpTk8wUksxTklrc3dMelFGMW9YYXlCYUZjc09NN053dENGSXB6Q3JCTTZG?=
 =?utf-8?B?d0RGUnJpdkNYeVA4UnM4RXJseG9pSUFXODR6bUVZZjd4TTVZbU9wZWtJOW5h?=
 =?utf-8?B?OGFLNXN4VldVVm1oeWlWTnk0clo4dk9ZN2J3NG5KMVFwaHVYeEFyL2Uwek9T?=
 =?utf-8?B?aDZRSTl4RnFYNkppMnpObmRsWFdSeTF0YXpVOXF4d01YSzJtb2RMOVNma1NS?=
 =?utf-8?B?cWo4MmhhVHNaaHIwUHFsKzlxeUlLcWVQM1FQYVEvYThYSnRqaG14VzQzb3Qx?=
 =?utf-8?B?QUFEUzk0MUkybS9TQUJxM3pkYzFVR3pzdERlWnVNdVlKd2IzQnpaZHdqanlZ?=
 =?utf-8?B?Q0pQbXJtdlVLR0o5MHJTbTlXSUpPRlJXajBqMnB2N0pjL2gycUd6RDNaWG1F?=
 =?utf-8?Q?QMd9Sixp1Ari2zXS35mnt+d/H?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1840ae4-1b73-4e41-f7f9-08dccacaa6bf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2024 21:11:31.0485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/RhqE2KDGYxN19S+bx0FQd6OjSw/3oxotEVUsnUvsghrKkkFv9av0Te+uesquSOSd3Q4pJ3+JoAAyHfcaCohg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7118

From: Jan Kiszka <jan.kiszka@siemens.com>

There are apparently incomplete clones of the HXD type chip in use.
Those return -EPIPE on GET_LINE_REQUEST and BREAK_REQUEST. Avoid
flooding the kernel log with those errors. Rather use the
line_settings cache for GET_LINE_REQUEST and signal missing support by
returning -ENOTTY from pl2303_set_break.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/usb/serial/pl2303.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
index d93f5d584557..04cafa819390 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -731,12 +731,13 @@ static int pl2303_get_line_request(struct usb_serial_port *port,
 				GET_LINE_REQUEST, GET_LINE_REQUEST_TYPE,
 				0, 0, buf, 7, 100);
 	if (ret != 7) {
-		dev_err(&port->dev, "%s - failed: %d\n", __func__, ret);
+		struct pl2303_private *priv = usb_get_serial_port_data(port);
 
-		if (ret >= 0)
-			ret = -EIO;
+		dev_dbg(&port->dev, "%s - failed, falling back on cache: %d\n",
+			__func__, ret);
+		memcpy(buf, priv->line_settings, 7);
 
-		return ret;
+		return 0;
 	}
 
 	dev_dbg(&port->dev, "%s - %7ph\n", __func__, buf);
@@ -1078,8 +1079,8 @@ static int pl2303_set_break(struct usb_serial_port *port, bool enable)
 				 BREAK_REQUEST, BREAK_REQUEST_TYPE, state,
 				 0, NULL, 0, 100);
 	if (result) {
-		dev_err(&port->dev, "error sending break = %d\n", result);
-		return result;
+		dev_dbg(&port->dev, "error sending break = %d\n", result);
+		return -ENOTTY;
 	}
 
 	return 0;
-- 
2.43.0

