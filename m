Return-Path: <linux-kernel+bounces-226661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA72A9141D4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 07:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AD411F231EC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 05:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32D817BBE;
	Mon, 24 Jun 2024 05:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="UyZdeb7J"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF50A17548;
	Mon, 24 Jun 2024 05:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719206043; cv=fail; b=dntk3MH18SnctyvD4hHfTuMkgzegiQNQ3KCPoLAnkbH5RznfIm/syPirINtBLcL3vW+VJEq1UjKobU/tCjLAR8ouCerqv7XLpdEUAQR4zaPZRSqnGBUoZ8bYLQzF39Jf1lfMUjAkq8dQ1LCgy7rrABDuQ08yz+awZX4j6VrcAC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719206043; c=relaxed/simple;
	bh=ZWmRbcoCfr2B0dTkno2VYsC4Z0vkjnk2b+COqeCVxO4=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OJ+vltH583oAe6DBoeXUJxndLZNBzDKkfTg0k2rIzPMy58XEq73JYnFMzFKGHw8wbtcN46uiKH6pTcktWNRGgb9rlIXnuFcna71nzYWjOXVqi6xmtGl8OcSoVY1eJonooL4khT2DkYXFUB+dLf9avEa64LK74h9iN/RvO5ZjNfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=UyZdeb7J; arc=fail smtp.client-ip=40.107.22.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LB3V7fWsBIvYL4udETWJynw1PqmlB5ZcwsrpG7OhW2qSuM5UFNgyHP9ER+Sj4l7hUUzmzAhp2pflp7MHbtXJavp516LUQtcaJiMgKh6V1sGceHkq9UPrZ45giAakpO7dIxVvvHkrhYpKCj1tB9IEepzyiml2Rbe354ECTzYhgfIirAmW3JpaS7CoxbfjL4fDqoFtHrUYaQl8FV81o95pr1aB2mrInwdbVKPbDjtem6GX7VhPv8yhSjp4/ALRRGXK+4C19hTvD69oMv5ZV9WtlQfR54Kinu6OUnfHwXtyW4ZJyssCIIhKJFoeEgSSK0FG0PAB3v8QVm33r4J0CKma0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jh6208/6FYNsgOCO5MLWY42zXzE3OU7GiUZP1n56G5g=;
 b=ak9h6AAOZjIMfpgNXgkm1TJhsvdY3Xzz08ilM0PaTE3HkkxQhpBT+Cke7ct6FzR+YtP/AyDK4f1nC9zHPfmIZmDJc99sBfJTCbyec0u50Eq+qFLJ3dwb6jEIJ/ZeMm8NAo5u09nuLcLzuM7pp48iNlnQuCda8THiV9hI23JnEfbdB9No17kdEdJ4z5znaqpiwSuiPuWfJi6nZJQ81voUy7g5B/iEr+OWlrsEr9PYi02lTkwUPGMGavkwstJoa2o20cScWa11PyQRVc5/yvRuhaV/KH5S0DV8x/J1hJb7eYsxdbtZJEDJGp5AZlwQb0IC0xVK+mr8Sn+077PKCW1OLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jh6208/6FYNsgOCO5MLWY42zXzE3OU7GiUZP1n56G5g=;
 b=UyZdeb7JbPR4OrKoLymbN2mNe9CAddJMoFbIGSR5wOkj0JysXf4ZGbNqCnRGph5mmgmFdgurCTbewAhqN9J7a0b4dT1m/2LCb6lRiNi3eoZ114Z+z+6yWj6GYsF9uzZAeuneFRxYipe/B5/IasJZt2qpTlFouYlc2o8QdwDnAMQIsISjUniDsRYStfrAMJ8+FcKCHr4n4j+tWu3vh/YR5fS40a+ZcnPV2Sr0Zaa7C1HrFC+x4ZsZs8r8tST0utBOZbY+ODV5bPy5vntEjA/haYUn0eyzk7VSHV/3BbQR/RFnyZ3uNeY5ly5PigOsUFucfm/JhvwG6kr2bID+kfCdTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB4061.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 05:13:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 05:13:57 +0000
Message-ID: <639004a9-6514-4d70-91b7-440b542ffc6d@siemens.com>
Date: Mon, 24 Jun 2024 07:13:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am65: Move SerDes mux nodes under
 the control node
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240326185627.29852-1-afd@ti.com>
 <20240326185627.29852-2-afd@ti.com>
 <a15da17a-f196-4356-a744-5c8e1104e7c0@siemens.com>
 <50327a4a-3653-43d7-88de-2182dc3eb4e7@ti.com>
 <d942e4a2-dccf-448b-b151-4840fced345a@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <d942e4a2-dccf-448b-b151-4840fced345a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0205.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB4061:EE_
X-MS-Office365-Filtering-Correlation-Id: 96b852c7-3c4c-4730-0acf-08dc940c72f7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|7416011|366013|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXhHRlI2cW5RNlhIekRpWDhzdk1IU2VFUVlUN0dSb1BlWXM1T1NNK29Xb003?=
 =?utf-8?B?RDlMZXM0TjloVW1mMXdKaTRkZ01iTEZEZ2lzNjAxWENwVHFzckh2M2lQeEFG?=
 =?utf-8?B?U0JwTTdUY0hvN1ByQlB3Q2Q4eEtMSkNxVzk1bTM0RkdieGtGSUEvTVZiemk2?=
 =?utf-8?B?azZ2R2dwYnFEQzB3WGEvWE85ZHRwTEZnQkh6cHZFMnVCNUZMUElaRk5NeERH?=
 =?utf-8?B?cWVDTXRydVR4MGo5Vy93WHhTbGN4UGpwNkUvMFIwQnF0Y2lyek8wOVBleDJz?=
 =?utf-8?B?dnl1OUdxRDViL24rbEJNeUJ4TWJ5M0NvaHhOeXdNRGY2OGNsRFg4YjE1ZFEy?=
 =?utf-8?B?LzNyMXZ4aXZCQnZpZU42U2tMN0hwb09WbUlmNllybjB6OEFpR2pXZlkrMTNI?=
 =?utf-8?B?czk3MGo3OHJzTitaTy9uazE4Y1k3TEpMZmhYNGtCVGFaZ0UzNHhIZ3VNZDdO?=
 =?utf-8?B?d2t6eWVoazl6MFZ6clJCczYrN3duOWhkejRXZmhrZHM3dWRQZzhNTEhBZzRp?=
 =?utf-8?B?TUNQTEk2Vkd5Uy9Ec05SN3prUy9HS3U4cnEycTZqRmhoQS9mZFo1aWs0dXNR?=
 =?utf-8?B?Snk4OElDOUZCbExZZUYyNFNqTzRkL1lGcnNMNUNkVGVNOVRBSHJOMXd1ZVFl?=
 =?utf-8?B?Ync0dmFFdUZJaDBETDYrNEpnM1RuMFpPc3FWL3BKMjZKcGxNYkZqa251aVVq?=
 =?utf-8?B?c2kydFQ0Q3M4WVUyN2V6dDg5T29xV3lwUEc2NWRsVmV1TnVxSjNCTEZxYjda?=
 =?utf-8?B?bXNxSVk2TDJTbDE4VmpxaGVpYkJqaDcvejFQN1lzRUhjV2U5Y3dQMnN5U0lu?=
 =?utf-8?B?UjRzNjQzaFVEN2p6QTdnMWxsSlQzOHhaRTFxVlN1azFRbllDTjlMRDU2USt3?=
 =?utf-8?B?cThXSG5SdlA0NHF1RGxvT0R5ekhnK3hJbEkzZ1UvcmFtdmVSY1lKVm1tUmtY?=
 =?utf-8?B?ejRteVBVVDNhK1dFdW5JNnJSTWM4VkdyQUV5ak4yUTkwdlMyWjhWc3hWOENE?=
 =?utf-8?B?SU1KK0hja01WMUZReEhJajgvVGhtTDFvQ3RZcGRuc2UrNnlZTU9wN0U3YUJm?=
 =?utf-8?B?aEF0RFp5b0dOVWxkNVpqSm4vd1NkeEpiUTBESlVMS0J4c3JWSGRaVTgrUmVx?=
 =?utf-8?B?VlJ1cFpmMWNwQzBwY1BvM2tvTXVEanBMUEVDYWxCM3ZTbEl3NkpOcVBqT01O?=
 =?utf-8?B?NWQ0cEtmZldWTEdhajBENmZBMGlvd1JVVkNtMGViM2V3SHJFY0NtaXNiZXVh?=
 =?utf-8?B?cTdDZlBLeVhOaWtzcFEzNktVa25wUEJXOHVyTWdOS1hucmFGUjByeVRHRnpF?=
 =?utf-8?B?ekdZOEI4UjMrMjdjZUNQSVROcDJYRU9ja2phUXNUMHZsVnpjUXBtY050eVVY?=
 =?utf-8?B?dHVtUkd6RHRVcTI3ZXM5b3JHS0hvQ1JibVZTNmZ3MnR2R3g5dlh0N3FreGI3?=
 =?utf-8?B?elZjS2VObXhuRnYrTW9qNGo4NDUyaTFxQlEwMGZzK0YrcmJIU0ZRT0MrbVNM?=
 =?utf-8?B?SnVHY3F4czBKMGtMK3p4RkVOdTdtYktBaC9DeVpXdXJPMjFEaUxOcTRyb1g3?=
 =?utf-8?B?clpma3VSMzZvSDFGWmR2NFJ6WkxCRjU0MFVRdktmSjRia0pBVkluYng0aFVS?=
 =?utf-8?B?UFB2Q1N4TEdXdUc2ZkxrMmhUYTl6NTN1b2dWamlIbVlrbnJqaVV0RkFxK1RN?=
 =?utf-8?B?OGkrVUszS0hQOHVwY0VKMnZCcTRMbFNkZGJxalNYaUk0OVBMS2pDenVrZU9N?=
 =?utf-8?Q?CeGdpIOgQOtX2N9aP0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZERYMmc0Ymtjb2JJcDFCNzhqNVdoQVZKaUg3N2RrU1h0UEdMdU1VRnBsWXlC?=
 =?utf-8?B?U3F1OVBOc1ZrNUxKUkZXc2FuUy9jQ3J6N2hNZ25vdCtrSjFidTBaZjBLL085?=
 =?utf-8?B?WS80SGhSZlVpMXFEOWo0Y0R4WDJDR0Vvbm5wUEo3WTh1Z2JabjM3WVJGWXJW?=
 =?utf-8?B?RjRxZjBjOFQxdlovNWF2ZzVsK2w4Wk96bU9JRlZSbTk2TGREQllnQzdyc3Nq?=
 =?utf-8?B?Vm95SHZOdE53ekZOVFpOQy8weS84ODFTZXpmenpXWUViNFdXc2Y3NDNmOFkw?=
 =?utf-8?B?b0ZsUVo3T1orZnZzNXU1eVFtckhCSksxK3g0dlRqbk5GeUdUS3FjWW82bGN4?=
 =?utf-8?B?RHBNbHFhQXk3UnJhOGpvZ1h4TElZTkhRTmRIWjRFM1NOUjlQcE05ODZDS2Z2?=
 =?utf-8?B?TlUxRzRObFM2NjJUeERVWHozM2NET1pFYzFPUU9JWEhyb3NrRjV0bXlCaWdh?=
 =?utf-8?B?dmhTZ3RDaER0OFErQitRZG54aEJTcThLL0xBSnhibkpFR0s1Tzh4aXNQcWNz?=
 =?utf-8?B?K0lFSnRiQXhxYTVPTmNLdHUzMWEzbmJnR1k4Y3dhdG5tNmRXNllxZUVZTG9T?=
 =?utf-8?B?Ukp5U0xpUVhoUS9hd3E0MUZFeGFySjgvMXplR25NTjlCbGpTZTZweUIxdlRr?=
 =?utf-8?B?RDJ4QjVTZDI4RTlQS2FCSTNUMURwbDdVaDlnTFFxa0o3VzJlMXZvQkF5bmlv?=
 =?utf-8?B?K0pJZ2VQaGQrb2I0RE9iaXFuME1vWmV0clFJd0pmYXlLZTFZRmFjbnM3Mmlj?=
 =?utf-8?B?aWJpbktYZnhLbTVoSUJDMlBsZklFRlZpdDhIT1FpNE0zMkM3T0NKaE9BK294?=
 =?utf-8?B?TnphL3ZYd3NrSEJ0RHQxUlNybUZFWWpvL0ZDOUxIYlY0anZiMjJ0WmNSUzBm?=
 =?utf-8?B?K01HWjVUcHpKWjFRY0xFbmZtNTNwTmdTb29CaTd5MklUYkwvZFFSUnlDaDcw?=
 =?utf-8?B?Q1ZoT3FyYWJNMmtpRmdLUmZwazBKOFhvZHJuOXdwYkgwSlE2TVE3ZTVRSGc3?=
 =?utf-8?B?T241R2E2ZlpjekhJNVY4aURlSTF1Z0FDWElZRUp4U3R5MUFwL3RHNVlwSWFF?=
 =?utf-8?B?MFRuSUxIeXhRMm1qT3JiMHVTNEZ1dUh1azFGSkFQUUNwcGJqUFBWUU50OFFt?=
 =?utf-8?B?VTlxRWVyc3NnSWRuOGU1Mk9VOHR3K3QybVc4anoyQnZZeWlXRUJXVk9KcWpV?=
 =?utf-8?B?MTYveUxNck4zQTVsczdSNDFKcC83Rzl3ZXAxWFNqVVFaZG5jdHAwTUd4bzBo?=
 =?utf-8?B?cEhRWmtzRG9uSVFUNnA5L3RtQzBlb09ESkZZWm10T2cxZ3hoakRIVEtQekI1?=
 =?utf-8?B?K0Zmb2FOTFN0blhNZmRJNkcxRzNSQndXYi85VkxiUGZadXF4MWV2TmRJang0?=
 =?utf-8?B?SVlYRDNQbisrTVJkSnlDR2tyQVJsbjQxTSs5c1lmU2RURXdQaldIUzdzV0Zo?=
 =?utf-8?B?Q0VGQ3JFZjJEU013YWhMa3hHbXpuYjJoOEIxcXBKVVFkU1Y4dys1Y09ReSt2?=
 =?utf-8?B?QlBDTU5OSStCT2pLZVRYYWZMS25wcENsOWprNDkyMm9Qc2VRN2xGbU0vS1g1?=
 =?utf-8?B?SWM5ZHJyU2JjRGZtRk04VGV5cm43czVhR1JsWW8zd0FZS3JvOTZrblJJWmdn?=
 =?utf-8?B?TkkzRHdQaTYvcGRrRjFMd2l1ZUFqeUcrWVpLOVRQcWlZaHNsbi9DdWVUU1Qr?=
 =?utf-8?B?N2ROM2hkMHVUUUlaSlFaVjY0bjV1TnRPWThpUFBndDBYQWZLVXMxNWhXNzdz?=
 =?utf-8?B?RDAvR2FGN292eS9EOEhkTXNudDJ6VTY3Sm8wS1kzY2hxdk8xRzE4RVhyZmxG?=
 =?utf-8?B?bDFpL3dGdGsyYUJ3eEY4dEo1Z1pHRzFXNUZ3TkdlU2o2aWtFRzhNQ1U4WFFT?=
 =?utf-8?B?ek9KZ2Y1OHJlWlNMQXNUNnZCV0hyTndlUFVNbllHMVVpaFhRVFdSajYrK0ZP?=
 =?utf-8?B?YzJqUUNTZy9oSW40alJoaWFuNnMwNXYrU25zVk9FRXg4TndsTzNIVkhNV3Nr?=
 =?utf-8?B?MlhJbWtlWWhMNlM5Y1g5cjBWcE91QUY0cEVNWEh6RW1LalMxYmV5dWU0ZjFL?=
 =?utf-8?B?SHBNS1lBemJ0M09tQ2s4SlFwcFA5UVBIQlFHb0N2YUFuako2ZVNJa2x3OUxN?=
 =?utf-8?Q?t+wIEDcmxWdvMPv/duKmErWCh?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b852c7-3c4c-4730-0acf-08dc940c72f7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 05:13:57.0255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AzmgNEq6UXTjr+CrktUOXVFeJPxWyY8SYasvYSSHBMxt7y/YsUIMwY+C+l5Ah+dloR2rYqSB4M4rPl3ll6mvMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4061

On 15.06.24 09:35, Jan Kiszka wrote:
> On 14.06.24 18:19, Andrew Davis wrote:
>> On 6/14/24 2:44 AM, Jan Kiszka wrote:
>>> On 26.03.24 19:56, Andrew Davis wrote:
>>>> These SerDes lane select muxes use bits from the same register as
>>>> the SerDes clock select mux. Make the lane select mux a child
>>>> of the SerDes control node.
>>>>
>>>> This removes one more requirement on scm-conf being a syscon node
>>>> which will later be converted to fix a couple DTS check warnings.
>>>>
>>>> Signed-off-by: Andrew Davis <afd@ti.com>
>>>> ---
>>>>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 21 +++++++++++++--------
>>>>   1 file changed, 13 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>>>> b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>>>> index 738c5c4acbcd2..5ce67e6a33600 100644
>>>> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>>>> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>>>> @@ -66,7 +66,7 @@ serdes0: serdes@900000 {
>>>>           assigned-clock-parents = <&k3_clks 153 8>, <&k3_clks 153 4>;
>>>>           ti,serdes-clk = <&serdes0_clk>;
>>>>           #clock-cells = <1>;
>>>> -        mux-controls = <&serdes_mux 0>;
>>>> +        mux-controls = <&serdes0_mux 0>;
>>>>       };
>>>>         serdes1: serdes@910000 {
>>>> @@ -81,7 +81,7 @@ serdes1: serdes@910000 {
>>>>           assigned-clock-parents = <&k3_clks 154 9>, <&k3_clks 154 5>;
>>>>           ti,serdes-clk = <&serdes1_clk>;
>>>>           #clock-cells = <1>;
>>>> -        mux-controls = <&serdes_mux 1>;
>>>> +        mux-controls = <&serdes1_mux 0>;
>>>>       };
>>>>         main_uart0: serial@2800000 {
>>>> @@ -485,18 +485,23 @@ scm_conf: scm-conf@100000 {
>>>>           serdes0_clk: clock@4080 {
>>>>               compatible = "ti,am654-serdes-ctrl", "syscon";
>>>>               reg = <0x4080 0x4>;
>>>> +
>>>> +            serdes0_mux: mux-controller {
>>>> +                compatible = "mmio-mux";
>>>> +                #mux-control-cells = <1>;
>>>> +                mux-reg-masks = <0x0 0x3>; /* lane select */
>>>> +            };
>>>>           };
>>>>             serdes1_clk: clock@4090 {
>>>>               compatible = "ti,am654-serdes-ctrl", "syscon";
>>>>               reg = <0x4090 0x4>;
>>>> -        };
>>>>   -        serdes_mux: mux-controller {
>>>> -            compatible = "mmio-mux";
>>>> -            #mux-control-cells = <1>;
>>>> -            mux-reg-masks = <0x4080 0x3>, /* SERDES0 lane select */
>>>> -                    <0x4090 0x3>; /* SERDES1 lane select */
>>>> +            serdes1_mux: mux-controller {
>>>> +                compatible = "mmio-mux";
>>>> +                #mux-control-cells = <1>;
>>>> +                mux-reg-masks = <0x0 0x3>; /* lane select */
>>>> +            };
>>>>           };
>>>>             dss_oldi_io_ctrl: dss-oldi-io-ctrl@41e0 {
>>>
>>> This change breaks serdes setup on the IOT2050 SM (k3-am6548-iot2050-
>>> advanced-sm.dts), possibly on more of our devices as well:
>>>
>>> platform 5500000.pcie: deferred probe pending: platform: supplier
>>> 900000.serdes not ready
>>> platform 900000.serdes: deferred probe pending: (reason unknown)
>>>
>>> And PCI remains unavailable. Digging a bit into it, it seems the change
>>> is causing a circular consumer/provider dependency between serdes0 and
>>> serdes1:
>>>
>>> root@iot2050-debian:~# ls -l /sys/bus/platform/devices/900000.serdes/
>>> total 0
>>> lrwxrwxrwx 1 root root    0 Jun 14 07:10
>>> consumer:platform:5500000.pcie ->
>>> ../../../virtual/devlink/platform:900000.serdes--platform:5500000.pcie
>>> lrwxrwxrwx 1 root root    0 Jun 14 07:10
>>> consumer:platform:910000.serdes ->
>>> ../../../virtual/devlink/platform:900000.serdes--platform:910000.serdes
>>> -rw-r--r-- 1 root root 4096 Jun 14 07:10 driver_override
>>> -r--r--r-- 1 root root 4096 Jun 14 07:10 modalias
>>> lrwxrwxrwx 1 root root    0 Jun 14 07:10 of_node ->
>>> ../../../../firmware/devicetree/base/bus@100000/serdes@900000
>>> drwxr-xr-x 2 root root    0 Jun 14 07:10 power
>>> lrwxrwxrwx 1 root root    0 Jun 14 07:00 subsystem ->
>>> ../../../../bus/platform
>>> lrwxrwxrwx 1 root root    0 Jun 14 07:10
>>> supplier:platform:44083000.system-controller:clock-controller ->
>>> ../../../virtual/devlink/platform:44083000.system-controller:clock-controller--platform:900000.serdes
>>> lrwxrwxrwx 1 root root    0 Jun 14 07:10
>>> supplier:platform:44083000.system-controller:power-controller ->
>>> ../../../virtual/devlink/platform:44083000.system-controller:power-controller--platform:900000.serdes
>>> lrwxrwxrwx 1 root root    0 Jun 14 07:10
>>> supplier:platform:910000.serdes ->
>>> ../../../virtual/devlink/platform:910000.serdes--platform:900000.serdes
>>> -rw-r--r-- 1 root root 4096 Jun 14 07:00 uevent
>>> -r--r--r-- 1 root root 4096 Jun 14 07:10 waiting_for_supplier
>>> root@iot2050-debian:~# ls -l /sys/bus/platform/devices/910000.serdes/
>>> total 0
>>> lrwxrwxrwx 1 root root    0 Jun 14 07:14
>>> consumer:platform:900000.serdes ->
>>> ../../../virtual/devlink/platform:910000.serdes--platform:900000.serdes
>>> -rw-r--r-- 1 root root 4096 Jun 14 07:14 driver_override
>>> -r--r--r-- 1 root root 4096 Jun 14 07:14 modalias
>>> lrwxrwxrwx 1 root root    0 Jun 14 07:14 of_node ->
>>> ../../../../firmware/devicetree/base/bus@100000/serdes@910000
>>> drwxr-xr-x 2 root root    0 Jun 14 07:14 power
>>> lrwxrwxrwx 1 root root    0 Jun 14 07:00 subsystem ->
>>> ../../../../bus/platform
>>> lrwxrwxrwx 1 root root    0 Jun 14 07:14
>>> supplier:platform:44083000.system-controller:clock-controller ->
>>> ../../../virtual/devlink/platform:44083000.system-controller:clock-controller--platform:910000.serdes
>>> lrwxrwxrwx 1 root root    0 Jun 14 07:14
>>> supplier:platform:44083000.system-controller:power-controller ->
>>> ../../../virtual/devlink/platform:44083000.system-controller:power-controller--platform:910000.serdes
>>> lrwxrwxrwx 1 root root    0 Jun 14 07:14
>>> supplier:platform:900000.serdes ->
>>> ../../../virtual/devlink/platform:900000.serdes--platform:910000.serdes
>>> -rw-r--r-- 1 root root 4096 Jun 14 07:00 uevent
>>> -r--r--r-- 1 root root 4096 Jun 14 07:14 waiting_for_supplier
>>>
>>> Note that we normally disable serdes1 on this device as it was not
>>> required so far. Enabling the node does not solve the issue, though:
>>>
>>> platform 5500000.pcie: deferred probe pending: platform: supplier
>>> 900000.serdes not ready
>>> platform 900000.serdes: deferred probe pending: (reason unknown)
>>> platform 910000.serdes: deferred probe pending: (reason unknown)
>>>
>>
>> Thanks for the report, I think I know the issue and can
>> send the fix here in a bit. In the mean time, could you
>> see if the following fixes the issue (this isn't fully
>> correct and will cause a new DTB check warning, but will
>> let me verify the issue):
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> index 1af3dedde1f67..06ed74197f893 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> @@ -478,7 +478,7 @@ scm_conf: scm-conf@100000 {
>>                 ranges = <0x0 0x0 0x00100000 0x1c000>;
>>  
>>                 serdes0_clk: clock@4080 {
>> -                       compatible = "ti,am654-serdes-ctrl", "syscon";
>> +                       compatible = "ti,am654-serdes-ctrl", "syscon",
>> "simple-mfd";
>>                         reg = <0x4080 0x4>;
>>  
>>                         serdes0_mux: mux-controller {
>> @@ -489,7 +489,7 @@ serdes0_mux: mux-controller {
>>                 };
>>  
>>                 serdes1_clk: clock@4090 {
>> -                       compatible = "ti,am654-serdes-ctrl", "syscon";
>> +                       compatible = "ti,am654-serdes-ctrl", "syscon",
>> "simple-mfd";
>>                         reg = <0x4090 0x4>;
>>  
>>                         serdes1_mux: mux-controller {
>>
> 
> Yes, this works.
> 

Did I miss the real fix, or is it still under development?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


