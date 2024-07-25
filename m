Return-Path: <linux-kernel+bounces-261788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB22593BC1D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 07:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 223631C23B14
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 05:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1942263A;
	Thu, 25 Jul 2024 05:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="ivowZLRw"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2107.outbound.protection.outlook.com [40.107.20.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8463A1C694;
	Thu, 25 Jul 2024 05:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721886332; cv=fail; b=pxlKV7nZWd9LHJDkp2fuHvtKoXe1O8lH/h1M6DZWX0nTDbefQw26FewR6y/CK6e4YINyf30vzeQ9221z0l8VpG1DyFJPx8F5HCjVy5cmUuqzclm+82G4B5vgccFtcpnIINF4ZiRog+7ZhZqBSao1J0Cyb4sTP1kouIfIPI7zT14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721886332; c=relaxed/simple;
	bh=R2wZb4DrJeGgnLmbFW02GlpWSUsCYY8KRXcC4k7ExCk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j6VT/xzbLGOTDZfPn3n0k8gt5m76nvbZ/YR698zRtb2JPRKuL+VCpFDCg4oWu+zEa7hjFX/HdVGGCLLNrnPP/RYbBGFT1VtNlsCdL5Bn1KRVcOazfgmJCc6W2lZXrI9d7lB6RgAQ3hPlFDTgLXQMUpPzybw1RFJppcBSDnbTtlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=ivowZLRw; arc=fail smtp.client-ip=40.107.20.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTsC/6xefKiSr4FF4qphriRtEUHWBeSu3U8ZKwYb1sHsW7zpp+9+AyH3KqqX+yrQjFO4DS9GToGIMF349jVQsdjm9rOscreznFNMVbx4hSg8vRq5gqMirIjmNZMsea3YdRJKtQ8ILBCU5Q9bvqMON20Oc4KVvho64ioFb7flH+edtXM8EYjk34+BTG5LZbg90LepxihNSRWFcPagByDCKaHm0jpA9buNK1hZ1qIJUKdDJQNnCm/20YgJmHkSlm1lCRuzlrKR6nGLoxDkwHgiIi+xBrubM7B9wFTgkDRZwwXGU+0G9c2wsKNIPLMq7SHNIO69b/E38yXhOtgVOHmOkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cShjRca33+9N7iAxzDOb8sZNWrMT5fXcmFwRuVKcF4=;
 b=SjZoL04SH/qov4wI1vfhp2JK4FgCluEWNeCrVnRvHf6afQf48jjIJ7X/YVG5QUikmnPre4JtqfK9yswN8R1lei61xoE/pERV81Rin1jiIwxhRbOogyY0m7WEONHRhA2/aZCZXqRAO8fOzjORD5WFdIZVfCr4dMpp2FaT8M6UNUlqh/cWbRCqjqWsIEPXS9GMgpDbjYy5r2r2IAOJNT33ndyjxQjW7yie1B7gyxTNWVHffkPMICFxAILMQhHwY1kghVxTPhdaB94btHiKRPAAP/EksvnDVEf0HDxFCwv5n2+BBhjwe06doPZQGzJDciZu4YLhqQQQ0xUhWxliTFr3Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cShjRca33+9N7iAxzDOb8sZNWrMT5fXcmFwRuVKcF4=;
 b=ivowZLRwCpHDRekB1nvi3mHpISTIv6dEu8bYaLnveKlUOoMxgJ86fLWGLwAdmKzHUMRHU5Y+puIhFvuEYBRcfwto9Puseq4CDpUnojibb6Q+FiZxkw8hpk4lwfAB19o9bUdZ3vMIO1ubyoJg3B72Tp0BDOVJpMsOKLok6L+j6TI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DB4PR08MB9190.eurprd08.prod.outlook.com (2603:10a6:10:3fd::21)
 by PA4PR08MB6110.eurprd08.prod.outlook.com (2603:10a6:102:e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 25 Jul
 2024 05:45:27 +0000
Received: from DB4PR08MB9190.eurprd08.prod.outlook.com
 ([fe80::c7a:6978:9afa:19a4]) by DB4PR08MB9190.eurprd08.prod.outlook.com
 ([fe80::c7a:6978:9afa:19a4%6]) with mapi id 15.20.7784.013; Thu, 25 Jul 2024
 05:45:26 +0000
Message-ID: <e2120e58-3a81-4252-9844-49dbecda50c9@wolfvision.net>
Date: Thu, 25 Jul 2024 07:45:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: typec: tipd: Delete extra semi-colon
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abdel Alkuor <abdelalkuor@geotab.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
 error27@gmail.com
References: <20240724162356.992763-1-harshit.m.mogalapalli@oracle.com>
 <20240724162356.992763-2-harshit.m.mogalapalli@oracle.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <20240724162356.992763-2-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0216.eurprd08.prod.outlook.com
 (2603:10a6:802:15::25) To DB4PR08MB9190.eurprd08.prod.outlook.com
 (2603:10a6:10:3fd::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR08MB9190:EE_|PA4PR08MB6110:EE_
X-MS-Office365-Filtering-Correlation-Id: 7458d6e5-03c5-4ae4-6c92-08dcac6cfc19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Yzl0SEZZbEVpZWlSaTYwWlNadTdzdnBDNUE3dGwrNHR6elVHNzZjaGpaY2FB?=
 =?utf-8?B?YXdDTnU2UDMyVk02U0d1QVhrL1l6aDZ1dXBEQzcvR1lCVldvWkdBblUxT2Y5?=
 =?utf-8?B?bThkamxNbFpIZG9pTDZZRnJyaFhUUGk3Rm5tQndyN2gweGtoNWU1RXJzNGJm?=
 =?utf-8?B?M3ZDUE5rWFF1OTJqbHp4b0FTU3hZaElrampVdkl6a3FXMkxPdGJKSHNINWtP?=
 =?utf-8?B?YmI3VFViajBRZVlXSzZVdUdicFBXZ1dYNkFUeno1NnVWV3VXL3JqVTk3L0lS?=
 =?utf-8?B?Tm80cE0yR1FMOUIrNVJ6alhkU0hybDdmSVFnZ2RiQlJsVk5Xbkd6TXpUVkU2?=
 =?utf-8?B?aEFjR0xpYjBxbEdWT0tVZWVYVFN6bU9PWElUVUEvVitEajMrR0JKOUpQZmJE?=
 =?utf-8?B?am0xdjNCaTBxMXhLdEZWRmFMOFRVd1hBeEp1bTJ2TkdCRHFlRk5sdUQxZHh5?=
 =?utf-8?B?V3AwS0FWZk5ESFVSNUZyckVQbllWQXV5ZWN6N0xMT2h5YWV2dUlrRmFKVytv?=
 =?utf-8?B?UHU4aXFJS1dNVm5ZTVA4THJZQUNJS3FES3NkWEx2R0VvU3ArdUhDbWQxL0Zz?=
 =?utf-8?B?Sm04RkdYL2p5aDVmYUpKKzRGQzRjd3l5ZmxnYWswRTNmeHE2alVTU2l6aC9n?=
 =?utf-8?B?c0ZETXVHOGdobkdGaHhxbWd5cXdDTnBhdHNTRGhjVzMrUkgzTGNBMXhhOHJG?=
 =?utf-8?B?bm9CeWJDa2xrTFNER2Z6VFY4VWVJL3hveVAxck1BRXVyRFpXdzNQV0JWUzlR?=
 =?utf-8?B?UE1TNlZoSWRrYU1qaTlKV2lQRk5oc1pTZUUrNldiNTJPV0ZMRytKcllsQllt?=
 =?utf-8?B?d29zQWEyV3NablhWSmdLQVFJS0Z2K3l6ZlRtTHI2aSsvZ0VmbnE1dEdlNm9E?=
 =?utf-8?B?THV3UGl1NEY1NjhoOEY0OWQrRWpEbGQ5NmdYK2g2Y2Z2OUgxUGY5cGcwRzU1?=
 =?utf-8?B?RnlqRHg5TFhZaS9JdjJNang4UDJBcHlvOVM1L05mOUxaMndpM1piS0dCaUhN?=
 =?utf-8?B?ZWVnc3d5TG1WZVRCZjBMeEhwTlVoY2FCc0QyRDd4Y3M5emdsOXdleHBOWGZx?=
 =?utf-8?B?Sm5manE0M2szS3hRK0dJVWlLYjU2bHYvWGk0dGFwQ2ROVjZlanFrcDY2WjNl?=
 =?utf-8?B?QzVORzFGd0twK3IrUFVRcTFKaFJkTU1ETmtpd3NuVnVWUEVyNms2QWNMWUNr?=
 =?utf-8?B?a2VRb0t2Z05OZE5xNGlVUHI5UWRTUmhJY0p3MVE0T2NFaDQvVzI0V3JnbWNV?=
 =?utf-8?B?UE9yNjVneEFNSHZwemg0VWthQndxL0JjMjhndXJ6MUNMTmJnQTNmM0NWM0hU?=
 =?utf-8?B?bDV6WnJXSDVoV0FqcjZWNkpMSjlVdkxrcVJWelZpUHZRZ0N4dFRZN1o3Y0Rt?=
 =?utf-8?B?OWltRFNZb1BZb0RTSmwvdVNoSW50VytZak9FeXpNY3FqMXdWSmJJWE9uSDIx?=
 =?utf-8?B?Q3RsMmlUTEh4YjVxbnp2T01TcGJObWRDbTlNSG15YjJFZ25kV1c0VEVmNHRq?=
 =?utf-8?B?SFcyMDBMTzJlcnM4K0VWdnJnTFZFTlY3Q09kYllqQTE2NFhVVTlIaXZ4Nlo5?=
 =?utf-8?B?eUFqSTdtUm9rNU1aVndOQ0tEUUFNblI4RGx2UUN0dnZJMS9jVEhpeHVzVitC?=
 =?utf-8?B?UDJaVDBJWCtVb0RGNlcyeC9HWjJqWW12YVR4OExMc1dwVjN5Rnk4OFVRMFRt?=
 =?utf-8?B?SG5BRkxnRXc5a0RVUnN2OEV3aXF1ZXJVQWJNLzdJK01PYUZtTmt3bDU4SFM0?=
 =?utf-8?B?WmdPNmFRaTJiZnhHNUZOdzk3Zy9QYXBWVXRuMEFLMlRpSzNhTmFFUG95WVZj?=
 =?utf-8?B?eHZKbGpvditlYnBDeWpRQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB4PR08MB9190.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlV5cjBabGVXZGRnWDVxUHNMcFdlc3FneVhHaEhaMzFGMDRiYTlPcGY1a012?=
 =?utf-8?B?QXRzcnVweXE1c1ZhcmRxNXc0NElLRE12VGlGcml4UmRZOGtHYzNSNHhBWEEr?=
 =?utf-8?B?YndSTzA4U2tOOVVHaEdmdy9HQ0p2aHRaN1dER1kvN1EvVkkvaFpuR1NxVGpi?=
 =?utf-8?B?MXVPa1lWUzBjenMwenBWQ0dja2R1TVZSci81TStWbk02ZFp6UVBQbEFNMWl4?=
 =?utf-8?B?VFhjRVVUaFRaQTJTbmttMTc0KzBQOEpDK21EMUREeHQramVOb0syaUtlZkRi?=
 =?utf-8?B?R2tVRUVIay9LeHowTFdJWDUzRm5pYmxZZ3dQZHlyTTkyeXBMQXJBd2JsQlFv?=
 =?utf-8?B?cHBqZzQvY1EvUGNqYzhlYy9YSnBKRFRhbDgvMkdJTWhFOG9OR2NTVnorOERK?=
 =?utf-8?B?bmRsekc4NzR6Mm5WZERzbmFGQ3ZxU2ttTzdndE1SSGZCdGZlVDU3NmhLNVBv?=
 =?utf-8?B?d0lHMHRrRlpnVzBNN0h4eU1NVHFaTVVMZkxpLzJIUUVuVnhDUXo3L3VZbFlM?=
 =?utf-8?B?bmV3ekQzRHlNWkg3N25pd3VLWEtmeVVTMDA0WFNLK1pNTFA4cVRnT2pCTy9v?=
 =?utf-8?B?aEU2VldvVDBERGFjUnNVZUJjOGlQZTFicUo3MEtJY0djdjZPMm4xN0RUalQ0?=
 =?utf-8?B?T1pnTTJYVG1iZGVCN0pGTnhvRitXelZhRitXU3V3MXFCTFB6NTQ4Vm82MFN0?=
 =?utf-8?B?aG5mRjlTeCtZckRBNGpUOTdtWFlEV0QvZTg1VWhYcmorT3JZeGJGeGV3czBM?=
 =?utf-8?B?SGZrc1hSZVg3UHg0OUVPVldVWmt5QTNYNVoycXFrcE15UFlBR3ZGNzV2cVV2?=
 =?utf-8?B?RGdoSmYrZ0RxZHFWTDBnYk9QYjhUeFVsa1dNbFRpUUhPVVo2V3RuWDRpMVor?=
 =?utf-8?B?aHBJQTd6U1FXQnFRbUFvRWwzU3VGSDZYZjdicXlnRVg3ck5QMmJCTHY1bVJN?=
 =?utf-8?B?TjFYWE94WU01eVB4eWpwanNEblBwT0xpRU53ZUhyQUk0dVh2ZUZWWWhSV2pK?=
 =?utf-8?B?QzA1d0ZwTVRXNFdCd3hWaG9vcXB4aVdrc2pmTE9vZElITWJ5MjZjQXd2cEJt?=
 =?utf-8?B?WHBqbmlKRzJtQlcxZm9WWm5ETnVhbEgvU1hIbXVzTkZrMjc0VGZ6RkFleWxQ?=
 =?utf-8?B?ZFFGbW83L09PcXBSbllEMnNtTVZZN21rbTJEeEFIRjBVUUkxTFNVeHJlc3lv?=
 =?utf-8?B?Si85M0p5YktDQ2V0ZE1EWTJSTksrOFdKQlVsV1g2Zk9XOWx4WGYyODEzZlVi?=
 =?utf-8?B?VWdZQUpjMFY1NHB0WlBlamw4dGNCMmdiby9nTkVUKzhaS0VqZWZWVDZiTTR5?=
 =?utf-8?B?eWlTWWo5enBaejBNT0xoSEthZ2w3bUtocUVQc3lVVHlRd0l0QUlLaUZ2aytl?=
 =?utf-8?B?Z1I0eFVsckFnOEsrNzkyZEZMV2hZV2NQandQMTJpV3BMZWdoVk4zUkhid3pr?=
 =?utf-8?B?ZWJodU1kU1hOeDF2QVA5UDRrNE50RzBTZ3hLS1FTVkNHVHpVWlhiNGRMaGtD?=
 =?utf-8?B?cGFlaHBjVmRNUk5iMy90MUtPTWhFOWFJNU14VmNjeWZQekFwZWJlNDVEUzg3?=
 =?utf-8?B?bUxKMWY2MUJFTXpNTytwVE1uSXRjQnZuZzhNK0Z6ZUlNTWxSbnIwMC9MWW9K?=
 =?utf-8?B?NGhmOGZseE1XdXRiTklqaDRPU3ZiN1BXNy9mK2MyV1pvSUdwRk45V01laTl6?=
 =?utf-8?B?ZXJZZnVCck0vamJhSDFEOHlPQzV0UTFaakd3WHhOdmNyQ2RxTXd2bG00OEZD?=
 =?utf-8?B?NldvZWZwNkkvWlFudGxFcUE0U0E2a1FEU0M0MmxHajRjSWRXV1BuTTEyeUNv?=
 =?utf-8?B?VnJmZ0V1cktMSXh0WTR4NDJNeFFhLzUrblA2MUVxT3MxdjlBUS9oeGJuclZY?=
 =?utf-8?B?Z3VXckxXaU1IbWcxZUtOYlcxUzNQcGxJMWI4aE5sTG4rVjdoN2FtOCtxYStN?=
 =?utf-8?B?SjU2YTU5ekhzdllFY2VYSUorZDAxMHRsZElqOUdqdExkZ0sxalQ2cGI0Mm40?=
 =?utf-8?B?V1VPTENhZ2cxang5V044WEhSTy9Wd0o0TVdVSVdBNmhuY2VmU1lpQ3I3ODBy?=
 =?utf-8?B?bXVCL0lVRjN0WHZkbzZLUlAzWnhoTlR3c21VQ2hFcHF5dDZlakpHQUJhZG54?=
 =?utf-8?B?Q3I2T2VScmNWUW1Ua0NvTkVia2NDaWhISnRWNUdvb21iTTJPTDZVTUZHMG5s?=
 =?utf-8?B?SlE9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7458d6e5-03c5-4ae4-6c92-08dcac6cfc19
X-MS-Exchange-CrossTenant-AuthSource: DB4PR08MB9190.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 05:45:26.6960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QBuQdzpxaN8Z37qFWYAdsXsKzo7bTMhKi/zU6EpY81hgOsyil13JDPyObtZuy+WTHbosYDFx1Az+2o+egjJbKTiYw80VlOMH9FnD4hpjCd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6110

On 24/07/2024 18:23, Harshit Mogalapalli wrote:
> There shouldn't be a ; at the end of the function, delete it.
> 
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
>  drivers/usb/typec/tipd/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index eb5596e3406a..dd51a25480bf 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -1198,7 +1198,7 @@ static int tps6598x_apply_patch(struct tps6598x *tps)
>  	release_firmware(fw);
>  
>  	return ret;
> -};
> +}
>  
>  static int cd321x_init(struct tps6598x *tps)
>  {

Reviewed-by: Javier Carrasco <javier.carrasco@wolfvision.net>

