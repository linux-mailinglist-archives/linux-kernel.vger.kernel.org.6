Return-Path: <linux-kernel+bounces-279051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9719394B84A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9D731C245CF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2965188CC8;
	Thu,  8 Aug 2024 07:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="Ixx2QAgC"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE3D188CAD;
	Thu,  8 Aug 2024 07:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723103649; cv=fail; b=tTRcAzwu1iErywPpQivI5UXH+tBMoranG6FIcG6FuHN9TVar5jL12qqd/83cs8ZkAmeWw5k4A4sMvuHXaWbpW+8CZzBuAPTmGnUvMsvF5f4kpI4NNirgomfHhl7cvaF6KA7jGK2O6nauf1SYJ1kDZ01pLQRalbmxdAWwJToSLVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723103649; c=relaxed/simple;
	bh=gONd1ivQVx1JNYJndFu/88LrnVsq1VISTXPIuAtjok4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hom9dSy0CDWsK384dAEpLrZOYOw1lxVYgs6BkohA05fW3PkU2+pLgntkjG3KLuBRmm0dwGWqGoAmoyoBq1KXO7AqnZwCyRg/dTiOj+jurJy4z+ixAtnxx17Y0+bvE2KDUHtpLkuT3+Z5BL/S8wwoV65qFMrchh1SO7GO38S6lnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=Ixx2QAgC; arc=fail smtp.client-ip=40.107.20.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BssrXbVawP5jU8t4l+++KO7peB6dS9Vr3wMq82208XOLaPwkk9BR82nJ156rcEXdqN+IW2BOcQbysnirCdd+d8BFv9t4y8HXSpcgsGEMXnu8cY1iTTyfBL65NEbniXKfthYJj82NH4qUX6dXsDQwaJd69JKini7lHLhxL/k15a8vognfB2ifH7+ptLGQZkpBC6nvzJQv0Av4UV5l1mziWtiZy91gjZfUZDc3vbQsQHpkIu+VkBKQnlTrhN4ImHRSh6XXvXd4Ru3b3LVCKzxhoDjmTe0iZZ0t/34pMJHU5cZqS0me3zUtFl0oYjPvxhsZ2RiTHLgf6h35upIrxnk/Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ik2NuUr3A7TnK7ic2eMw4GtZzq3JkSlGRJIxIP7Qt7g=;
 b=cjxu1bkzNB30wV2oX+pfwbY6rz3iDNDnYd0cER+DCfMV6qLnJjdbkCArFR/5N+ZcOGMNm6EBNZIsM/a3DWowgBgeeDoY4IkhmYOgxyU8M9dwrafWM4DuDlx8Nkvpr2RVsiRyShjkvY/sPzkJsjSKiVNGGrLIJfGX/fBzFv8WKAymx09gGrahz0foYllvyDsXp1qlHWOFgnBXGaGAclabNTC+zNP3/BNQh+oFwjWfsUoaE5G6bkIQ2FPK8hXdDX2D1L5cS47w+sVKqYKOa+9+xIVcsdiXwzyYwpjmYZ9NK3vUz5Yh8/55foo38Ph8k3rpAihtb0gVwIKslZtHKsV+LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ik2NuUr3A7TnK7ic2eMw4GtZzq3JkSlGRJIxIP7Qt7g=;
 b=Ixx2QAgCHuRynVtMV50Xmm5AGbGjjTY+di8eK69n847tq/aKxbc1eRRyfCD+4j8A8WSx19HfiLP18SdaCAlVDkt1DLpLFaEpGEM296VZGb36S4KKwq/bST4Ti1zCCJQ+13aJMdXaKv187SdBAg9o9d3eqWEdc+ozP/7nchCHYvLZ/O3Q8P8JOuCwooYiOY84kHJHl0cXOcEo8kTNdWyyPxrahz8f3b5caS6QQmBEKQGgh6IKvObNa57HsrIKGaTdmDvS3SjtcwHfwm722f2KPFCMuYSs6xQIsTliR5XcOKwZmufemus2BtJ3ps0RAfXaujaN+GWX5FjMhJua3toOww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by AS2PR07MB9056.eurprd07.prod.outlook.com (2603:10a6:20b:547::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Thu, 8 Aug
 2024 07:54:03 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%5]) with mapi id 15.20.7849.008; Thu, 8 Aug 2024
 07:54:02 +0000
Message-ID: <9d19cec9-3e40-471c-8c76-8842a5d86973@nokia.com>
Date: Thu, 8 Aug 2024 09:53:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] of/irq: Consider device address size in interrupt map
 walk
To: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240807120153.1208858-2-stefan.wiehler@nokia.com>
 <CAL_JsqLciDTxfeKwuNNWEOZjrUDFp9g7ZAzTuY4nQ1GCwPmaow@mail.gmail.com>
Content-Language: en-US
From: Stefan Wiehler <stefan.wiehler@nokia.com>
Organization: Nokia
In-Reply-To: <CAL_JsqLciDTxfeKwuNNWEOZjrUDFp9g7ZAzTuY4nQ1GCwPmaow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0187.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::17) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|AS2PR07MB9056:EE_
X-MS-Office365-Filtering-Correlation-Id: f7c2b0bc-92d3-4837-828d-08dcb77f44fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGxHcFZkVSttWEhLYUp1bHlPMXo4bTY4Y0tsYUhocDJhdVBMTTlTcFE0SHZV?=
 =?utf-8?B?MmlRcHMwd2RlUCtzU29GblNGYVN3UDQzdi9NOStMcno5aVNXUkpnVW9Xak96?=
 =?utf-8?B?d2ticmNNVXhaZUhjMDRVNDVUTmwyZTRWdWFHM3YvUmFpcktyOG1qZnJHeHNL?=
 =?utf-8?B?N3Zpb2p4VkVyd2tjelRGNVBacVR2QUtJUXkvNHYxS2ZCZnQzaTdGYkdFblJJ?=
 =?utf-8?B?elZvei9DbDBXYXZhdHYweWNZM0piQXJMZ1k5bnBOazRnSHFsMThZRnlWVHRw?=
 =?utf-8?B?Y1hpTitXNS8yS3YwaFJyUERuRS81OVdteUdoNmtNL2ZmN1dJZnhzOGdjVkJq?=
 =?utf-8?B?aFU0Mm0yS1g5RGt2NlI2cTFZS2dKOVdOaktqbnNUcjdlSStNZnIzSGZ1LzlJ?=
 =?utf-8?B?MG5CTUczdmRsVDYwQUZwOUVCRGtDYWZ1YTAwMnZPellIb3BFemxvT1A1cStx?=
 =?utf-8?B?Z2JZSmd4ZHg0eWtCYkczWEtJd2ViZlkyVnVCTDZucWhWQyt3cWIrTVQwQUNF?=
 =?utf-8?B?dEJQaWJOeEN0ODJrNkhvTkpIVlhQN1MxdS9WTGZYaFBtUjNpemI1U0dWclZX?=
 =?utf-8?B?Mi8ySmozSFJ3VzU1OWg1emNoeVc4bnZrVXNNTnRJeGtLS0ROc1pHZFBGMDk5?=
 =?utf-8?B?U0tUaW1EOTRTTlJDT2c5ZEtXLzlEWm9KRXhYSXVRWjdJanhxd2VGV3pQcjhu?=
 =?utf-8?B?RHJJM2hhOGRQb0F3c0VTUnlaRUFrazR4dlRGOWFaN05xMytVUmdsTkIzUEN1?=
 =?utf-8?B?MkZqR1JydDZkWmZIMVZscks0ZlhOQ29qRFBXODVSeUsrVG9YWXl1OWdwS29L?=
 =?utf-8?B?cHpUb2J2a3pmK0tvcWk5VWlIdkZOdjZJaENOdmg5U1FIOWxBUGpmdmQ4WXY3?=
 =?utf-8?B?WFoyUDYreVFlLzJSR3FXaHVmbzJ5ZHQ1M0lOcWs0Y0NUYW5reEdha1lOVnph?=
 =?utf-8?B?d2FNbjRTYWlwWFhnL3Y0Y2lEemM0RTVWOEROYmVkWWNqSlcvL2QrQmdDY3lF?=
 =?utf-8?B?dTZISTBiTGZwOWt5VUdOUXVXTnplb3orSkttd2diVHhTeGpxNmdCblk2d0Zl?=
 =?utf-8?B?MjZHYzVsSFNUWnhnMHBkeDNEenB5QldoWi81dGZNZVgwcnY2K01QSGpNc1Br?=
 =?utf-8?B?VXByR3FjbnFQWmN2TFoxY1ZscHlZbWFlejhQZDhvTVJLRmloOWVhNnlOanV3?=
 =?utf-8?B?TjBGZTZKR2pzOUx0b3dkQ0lobUppTVV6TEM2U1RtdGxtdmN2SXJDNzFKTHdt?=
 =?utf-8?B?ZStMQmQvZWpNQnpGeFNQbWlNMlBicStZcFVMWUM2em9JcmZJWWdNS3h4RVZn?=
 =?utf-8?B?RDZ2YStMZms3YUtGYlRoUlNvVlE0RHJaV3NzWlUyRlBMM0dtMExzaHJoVGF2?=
 =?utf-8?B?KzYzVHdRM3RzM3FxUm93V0dMWXRMT1dnWnIzMklUcHBqbWVqOGdxb0h4c3lE?=
 =?utf-8?B?bDJVT3RDeW53OC9FSnhtNEhxWXZ3RElSU21lTDBpRFJpVGJIL2lBQmNxTHRV?=
 =?utf-8?B?QVd3MDl1WlhHbkVjU05XeGJySzRKRjl5emlHYWZEYTdzQkU0bmZpM0ZlSUpY?=
 =?utf-8?B?MlJrZDhmN05iQ1d2Q2RhUFdUMEtMaWMyLy92VjJlTWFGUVRPM0syaGNlTU55?=
 =?utf-8?B?OUF6b0lYNVR6WXRnbzdBOU1rblFwaG1ST0tjZFpXOWtOMVNOdWlFUzEwKy90?=
 =?utf-8?B?QnY3Z0pETGJvN2l4NXFscUhKQklmSTN6Vnd6T2lHa0Z2dldzK2J2VVowd1NC?=
 =?utf-8?B?amQvbWpjdzNZcUJvMXh1ME1nWDE3dEt3S3FhUEp2dkdSWDBQNHplYmNaMWVp?=
 =?utf-8?B?MURwVWJHcURJRzZFZ2hKdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGVERFJ3K080aVBaN0M4ZXR0YWJOUmV5aGRwZnlQcGNaekxycnUyb29oaklL?=
 =?utf-8?B?aWJ3UDcwOFFrT0xOWXgxaDhhU21IN2k3VnZ1MkNSa0FpY0NJekVyRjBmQWht?=
 =?utf-8?B?REZaOXdoY1BhQVA0MjFmV0J3T2FxSWJ4OVh0RlJSbUpiV2sxTU1zSEIzZ0hh?=
 =?utf-8?B?YWFINUFCdjNabFVWQ292LzdXTTR0ZExHanZQZXRVZlVoUG9mbm5iNi9taHpO?=
 =?utf-8?B?ZmFkZXVwSlFLcjE2RGdyZ00wL3REZGRhaFBseFhteTRmQ21MdHdSdnk2REdH?=
 =?utf-8?B?TXg3eThndHhJVERLRU4vcm10ck1TQ1NkRVpiQjVBQW5Pa1diellmTDNjMzdM?=
 =?utf-8?B?OTdER2Ivb2g2VDJxOFZZZlgxTXQvRDJFWGhuL0VuVE5ERTAxb3V1eVVLQ3dR?=
 =?utf-8?B?enNZQ1VnZXRLelZ5ekVnbVlaZUxBU0YvMXZKbE1JWHlkbm5Ud1FvUXJMR0V0?=
 =?utf-8?B?WTRISXFmVVF3Ty9neE5RVjJmdk5nWm5hc0J4VzI3RlpyT1hScStMV3IzeXBx?=
 =?utf-8?B?ek1TZFRRT0RjT0NwL0NsQUVDbUpFOGh3TzR6cERzTFpqZkxra056bHkyTnBI?=
 =?utf-8?B?REVMcXdhaHgzdEl3Ty8wREFrYjVuOGdmZEZBS2pXN1Fqd091VWFiV29XdHAr?=
 =?utf-8?B?dmFpb3VZZmZnWHB1dEpVRXhHWlcwYk9TbmZSaFdQajVXQkxVdlFnZTduZHhF?=
 =?utf-8?B?UjRscVhML1d1Sjc3ZUNGR0FSdzBEOXNDZ3RBZysxV2laZGZMRVlpRjN0RjRz?=
 =?utf-8?B?aDhYbDVLOWxqSVJCNjlPY0dkVXloZy9aR0J1dWlKTDRrQSt4VFNpT1dpb1pT?=
 =?utf-8?B?dlluYXZnOUxWR2VPNTNqRUd1S1dIODdYL1Y2K2swa0htVnpGU3FPUmFlbnds?=
 =?utf-8?B?Qk5oUElrMGhFTEVKRWlDZDk0UWxhY1FXYjBLdWo1aStjbExyZENKMCtVVit4?=
 =?utf-8?B?eXJiVjlzaTNrOXJjbzVXSUthZFFGUkx3V21OQkMwSTR4ektJLzhlem80bnFz?=
 =?utf-8?B?bXV4NEtlVzZmd09ZUTVkUWgzSmNZQm1GNm9NTForWnp0YkV3cnNFWTdiSHQ0?=
 =?utf-8?B?enlCUlRlV0tNZTJ6enBsNE43d3dxSU00SGdiY3AzRGduV3BibDVBeU5TQkZ1?=
 =?utf-8?B?QlVzZWMwUHZmTnd0RmxtRDY3RUNzWVJDYVE1VTZleTdFOXBGYndSb0txOTRH?=
 =?utf-8?B?VUh6Qm5CYnY1VXg1Qk10dUlEZEQ0RzBPTW1uNjVmNDlRaEZES2Y2NTB0bG0y?=
 =?utf-8?B?ckVDcms0cFRPRXl0a2tvMkJQNC9TWC81RWJuREtVcDBkL3FVMmorWDRTNFdy?=
 =?utf-8?B?ZUI3c2daSjB2TWk3ckhEcGNEdStmNlcyRjRxMmJZSHpDRVZnc1NvQXFlQXlC?=
 =?utf-8?B?TlBXcFFyVlhGc0diZFNHbFhYVi9WcTVRNktHM1lWYzBsc3BxQkZ3NmtTdzVX?=
 =?utf-8?B?ZlJqV3MvVUdhc3BlT2hnMU8rcmpnd2J1VkdqWW9HUlI0clUyMk1TOU1jN1l3?=
 =?utf-8?B?S09PdXlabTg5VDdvNG5GZGNuYXlJQjBSZy9BeEJCb0F1eG1wYjFpZ0pwazk5?=
 =?utf-8?B?WGtWblpYS1c0dnR6NzRURG5MZjRWWU9lVFEyWFhIajJRcVEwVXFlMFpyU0NU?=
 =?utf-8?B?VHdtM3BmdTQ3VXBsTlNuVVNsdTg4S1hRNTlaeHk4VTdaUFJRVDhNd2pIWWVn?=
 =?utf-8?B?T0V1MzV6V216a2NZeklIaUhIeHRBMDV2dmRoZkQ3Z3BUZXRsMmVXYUd0c3Zx?=
 =?utf-8?B?ZWV5SGwvZlZJaHdQUnBwWWhFVzJnejlFeTB4d1d5bWt4S1djTEJsbUxRQW9C?=
 =?utf-8?B?OThZOHpWZ2YxZ2xEZ2RibW53a0RrZVV4QlYydWk3Q01HaHRmMmxEZzN1bS9U?=
 =?utf-8?B?Tkp0WTdrUFdRT0JBNlJ6dHZZeDZQaWZkeTB6OFFXcnpvQXNBMndxTG5GVFRG?=
 =?utf-8?B?ZDdPRVhlaHE4czdqMXo2dDFXOWdseTRtNEh2SXdGY05zdDE0bHdxayttcXE2?=
 =?utf-8?B?VTFOUkt2S3NaZEhMWk54emJDcnB1NnhvRWdFb2djdUp4VWdWYW80NW0zMnBs?=
 =?utf-8?B?VGV4aURVVmgvbm14bWNPK0pocS8xbnhhWnFGM2hqNGc5bW5XUC9qWXNFUWl0?=
 =?utf-8?B?QmpLWVRwVWtIaFRMeUdKd3ZiYnF2anU2bEIrSUNMeCtJNnllWEVFUGIzNlAz?=
 =?utf-8?B?dDZrdzEwSUZYV1FIRXVZRE1jK1hVeEFCdnEza2VhdUd0SlRKbU5JeGs1RTNI?=
 =?utf-8?B?MEZhc0xpRlJyNzVmNENIdDZkanZBPT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c2b0bc-92d3-4837-828d-08dcb77f44fd
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 07:54:02.6891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C01eVOIZiAUI0kUplCQFi6mNxXhn/lUHHRrL6eDq6Bdphpu3u2U8JN4JEzYFeHTp1x4E4PIqSitiMYNvYIGhBny53NxmMI3bVCiU4+NFuZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR07MB9056

> You've missed a bunch of people/lists. Use get_maintainers.pl.

Sorry, indeed, did not think about about PCI...

> Can you provide some details on what these nodes look like. The
> interrupt provider to an SoC device is a PCI device? That's weird...

The DTO looks like this:

watchdog {
	...
	reg = <0x00002064 0x00000028>;
	...
	interrupt-parent = <&gpio_17_0>;
	interrupts = <4 0x8>; // 8 -> IRQ_TYPE_LEVEL_LOW
	...
};

And the base DT:

ecam0: pci@878000000000 {
	...
	#size-cells = <2>;
	#address-cells = <3>;
	...
	gpio_17_0: gpio0@17,0 {
		...
		reg = <0x8800 0 0 0 0>; /*  DEVFN = 0x88 (17:0) */
		...
	};
	...
};

I completely agree it's a bit sketchy, but it's not me who came up with
this ;-) Nevertheless I think other people might run into this issue of
mismatching address sizes as well when no interrupt mapping was intended.

> Note that of_irq_parse_raw() was refactored in 6.10, so your patch is
> not going to apply.

I'm aware of that and have adapted the patch accordingly.

> That's not the right information to parse the address correctly. You
> would need the device's #address-cells. However, in most cases we
> don't really need to parse the address. The address is not really used
> except in cases where interrupt routing matches the bus and so there
> is only one size. That's effectively only PCI devices today. In that
> case, the address size would always be equal, and the code implicitly
> assumes that. It would be better if we could just detect when to use
> the address or not. I think we'd have to look at 'interrupt-map-mask'
> first to see whether or not to read the address cells. Or maybe we
> could detect when the interrupt parent is the device's parent node.
> Either way, this code is tricky and hard to change without breaking
> something.

Thanks for confirming that it's PCI only and no address size mismatch
should occur. I also was thinking in the direction of checking first if
interrupt mapping is intended and return early otherwise, but was
worried to break something along the way...

> A simpler way to fix this is just always pass in an address buffer of
> 3 cells to of_irq_parse_raw. You would just need to copy the cells in
> of_irq_parse_one() to a temporary buffer.

That indeed sounds like the easiest solution to me; I'll send a new patch
shortly. However I don't understand how you came up with an address
buffer size of 3 - shouldn't it be MAX_PHANDLE_ARGS
(addrsize = MAX_PHANDLE_ARGS and intsize = 0 in the worst case)?

> Please don't send new versions right after the prior version. Give
> people a chance to review.

Sorry about that, I wanted to fix checkpatch because I thought
patch-applied failed due to that, but that seems to be another
issue...

Kind regards,

Stefan

