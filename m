Return-Path: <linux-kernel+bounces-523080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9B8A3D1BF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7611718971BC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 07:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1455AA944;
	Thu, 20 Feb 2025 07:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="s1usp88o"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53306442C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740035186; cv=fail; b=DXPC0Sj8z3iGazDhWVSEoXrQz9gH1rgvEAPlJek3xpYScjVVFdLaK3IqnPQ/8ocINWfrKL6eIOrLOXobZhn/LP+QUDaFImh04ZStXve4OZBvVwY1cSuNtzE519UR+RSUJq90UF1T72WWYcACDX/1pdKWKqD3iK7HFX8g9RwuOjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740035186; c=relaxed/simple;
	bh=exCSor8GtuW8vRGTEiUGsK2DfurjdSiKGfEN5qIT7zo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ujq60XWcshe9JLq7w8ER2SvvBPFjRs2osPQybK3yfMIGVvuBgQq9Jh5Sv3h7hjVTQkfc0P2HL5N9wbLcNs6xTdrJSHv0Gk4U88zcpS2xS9yQxo0WdznRiJxGBUajJbcxIgXJ+U6+W4Kt3Yf047rgOOR+uzM7g+aZmatpcdwHfl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=s1usp88o; arc=fail smtp.client-ip=40.107.22.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxm/ZC6iQbYkUa85JhGvS+fX6mMACbeCxHLWW6z4VGmNQ6gKhRcoeQVGdebsUjncHTHsctiSG+KAi4vVdpq9pi5FVWSdqhU6wsulLE7oLshMQKZpxlc6xoz6Rhq0nPM/HXbWuNbecCe5Q1X3GviOsTJ238bt19XVQYN6aUTqdZdznSr+X00ekcFalrXolfvLuZt2NQ1FfZcBsQDN0bBLNljSjksLRpNkTddQafJeo2Shz2l7k8ukf6zWycTdyY8iqpvOIAhYOixttqkvwiz8jD+XJBfxTMyOxTSh+3E6b5AAL33qROjsltEIzRp643Wt0frKY7Y2LpNU4nnMijM2Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqKqKFEt2LRotGTzKQOSl85DvfafwgmibZVLai5QojA=;
 b=H0wru7u7RdKDEKRdIbhklLFopWgm67YZ9AK3xu1NbYPpsza/hHNGaI+eMeKwMkfXIFkubvhFjxuKz7iBISLoONAJfyMLam8H3LGm5pCDgAsBjz9gQlK9qyjrnGiiv8XZEKrCvELV3WZJZjwqNUmxsd3uXVrn+dlRBH1u9MNY/Fvk7T48HdgmosJeh1NPTGAsIAgoPCDMz7xPv2i5acGQZo5cCzhB7N7uWtPbWzuAV8izf17/5RLIvHHLavv//6d6o4pnfyp0UQxiM+WdwBUg8yhKDfzwsl8T++o2eObtmcDI4HO91ZRBurmQnHdERQ+tePVR+Danr+3U+PfQ+pd6PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqKqKFEt2LRotGTzKQOSl85DvfafwgmibZVLai5QojA=;
 b=s1usp88o1FNCFNFMhx6qpzbWkMLTsTo6baowyV+69uzNeADksEcAPt9526jikgyMiIzWhQQpoLlUEMYhd8mbCjSyhat3wTx9+AJiqP487hHLj0Vva0wBhsT37pjv3jRTSHzqcB5CH7osboP0MKSeVS9Hnw1+ST9hE2PuRVZetZ0UvitF0lW7C14gs+Wk05YlJyk6lz/ggr1sUE6b4FTDCde/mB6+NuJyHOAAGnnFw6ZJSTG+0TfKCQ4YUIy1DN+ZxtFVjb51vdyVkgf8tq+KdgSSUIyxPQHaV2tB2MxcC0l7x6Vz3e6gCEJc6DXAAh/NtNxnhNmaFbH7SgzqpL5ntw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7746.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:367::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 07:06:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 07:06:20 +0000
Message-ID: <8ae2c5bc-7751-4635-8b4b-07f7366ffed0@siemens.com>
Date: Thu, 20 Feb 2025 08:06:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/gdb: Add $lx_per_cpu_ptr()
To: Brendan Jackman <jackmanb@google.com>,
 Kieran Bingham <kbingham@kernel.org>
Cc: Florian Rommel <mail@florommel.de>, linux-kernel@vger.kernel.org
References: <20250219-lx-per-cpu-ptr-v1-1-b4492fc471e7@google.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250219-lx-per-cpu-ptr-v1-1-b4492fc471e7@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0316.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7746:EE_
X-MS-Office365-Filtering-Correlation-Id: 895113f1-0ab4-48f8-fe23-08dd517d13aa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3FnQmwzVzA2cVNtekhSSkFuTng0SkVkY0xkL3hTbmltanUvTEE5dmhVbnpD?=
 =?utf-8?B?Zkxycmg4OWhobDdRTWNaVEJxbEhtTVI4TlFXYVRYenJSRnZNMmpSRldRZmpX?=
 =?utf-8?B?eGZERTZtK2haY2Z6bGU4RTdiM3Q1TXlRRkxXOC9mVFpZTE9LQ2s5MFZwZ0Z0?=
 =?utf-8?B?QXVRblI5MDh2OStxcXI4RUhqOXd3V2t3WUlsREsyT0p6dk9NMjREWGN6aWxa?=
 =?utf-8?B?VTVuR1RzTkhZVVcvdVR3cDZtMDBpY2labDB2dURzMFBoTVdIcHZzYnh0MC8y?=
 =?utf-8?B?T0tKRnpQQ1JXZkhCajFVRFFjbnZyanVKMVI2TXQ4a2l6Y1BhVmpiU2x4UHZO?=
 =?utf-8?B?ODhNWnorRGtHY1JNWFM0eVhqMzZFNDBCQkowZU8wejdKMGp2RmhSclkrekVZ?=
 =?utf-8?B?aURsdmVkaTZwVUNnZmRwM0EwZEVYYnZUNzhPVVJ4RTJ5WWE2WE9YT2xxSDgw?=
 =?utf-8?B?T1BMYjhrRk93TlErRG9vaVl6OFlvQUdrcUlaUG85cEN4bzM3Wms0ZXI3UUxT?=
 =?utf-8?B?eXEzTTNVbTRhbjFkb1dBTVQxZGRqNTI4MitIb1JSb2xDYkdxOHpLL0ZYME8z?=
 =?utf-8?B?VXJROWxwd2dxNDYyWVpwTHFhMjFjUUdOVzY5bXpoSHpwRGl4MC9kOTB1VGg3?=
 =?utf-8?B?YjkxMDBBUllmcEU0UG4vZVUzY2dObzZ1SXZhNjBqdUZPbGt3M1dvRERNdXE2?=
 =?utf-8?B?VEpXZEc4VDNuR1ZPUWZMemF0ZDBXK2Zwc2pNU0Rva05jeExFVkloMHZtVG9F?=
 =?utf-8?B?dWVIOUp4d2ZRdXMyT2J5MDNuVFJteituenRTczNvK0tKODY1U2Y2NHZaalkx?=
 =?utf-8?B?dmVHMnZxOW9jMjJGMGJXNExiajJHL05MNkhOSFV4dGxNTzBmZ3JkcHJ6bEVh?=
 =?utf-8?B?bHJseDJaUHVyOGRVRVFmRDNsb2xWc1ZEOGdxeExGRXFhSUptSldRRjdRM3Np?=
 =?utf-8?B?bFVzWFR2RXNQK3NzNzVDMk1mNUh1WTJ5U0lJZWt5N3lVT3BGcjNLRkh4WW1y?=
 =?utf-8?B?UzBHR1hHTXBrRDE5eWJNY2dCMkljMDhyRks1TlprMlpNVml1OVlmd2lRWTdC?=
 =?utf-8?B?bG9pWkh4dmN5Y2pXTFJNcFIwZGFlZnJtN0t6cU15SXNwTmJsMHQ0NXpKamc2?=
 =?utf-8?B?ME5DRTFTYWpyZDlNOHpEMWF3bWg2UzFoczRlVksvS0NIUTJlVER6YjEzWVBh?=
 =?utf-8?B?bEVKNVQ5T3ZYSWUweHRZdmlKSmlpV0pGVFVUZXpRdDcyQ0E5NEFSZUJjRG9W?=
 =?utf-8?B?eFZoaGxMV3NKMzgzeUxIS2dheko1ZXM1bTBsRjFpNGVPTkRLQjRsdERDb3Yz?=
 =?utf-8?B?TVNqd2N6OVpGMTVEejVlMUpkTm51RVozLzZ3N2JNUHVFUFRML21nVE9peFFF?=
 =?utf-8?B?eW1KUmN3bzdIbTRhUGRRQXFqK2hJMzRsRkgvZkF5WGdVVDc4ekVtUXVmcTRq?=
 =?utf-8?B?aVIyRm5GMmNJNFBYc2FSaVljQkF3MDVkSVhScUU1dExmNkpTWVFUZVovVTZT?=
 =?utf-8?B?WWN5MHhwL2h6eHpBeUJScVE1UTZJRlRpRzBLUHFPSE0xWTQwQy9XY0d6Y1Rx?=
 =?utf-8?B?Y042Z2ZtWjRpYTl0Zm5yMm1paGVKQnBjV2VJZ2p4MG1Kc3J6RjdKUE5qM2I3?=
 =?utf-8?B?MkpLZ3hzb1pyM3QwVXR6Y25DQ2RJa3dFd2U5dm1GMFFSWHdFL3FOTW5YVWIx?=
 =?utf-8?B?QWszN3ZTaW1RRDlGTGErOEJrZzcvYTVnLzNRZ1pJMXkwQ0RlNnMrTThWMTZa?=
 =?utf-8?B?MlN4QnZBZGxJRjdmMHhtUWpVNDhIcmt3ZGM3bnNTY0ZxYjFJcmlvTzNRUXQ1?=
 =?utf-8?B?Y1BXMU9oTW1kMUFENWdRTWUyMFdCU0dvNXRleHF2REVpd0VTQTFod2Q5U2xi?=
 =?utf-8?Q?C+kFo2FFqkPOD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cExia2JTYnBYTVF6dU1ZY1l0cXk5MW1saHA1Sy9wa2NneG5rOEtSUmhKRFBW?=
 =?utf-8?B?RjZGRjFlTlFYVkhrQzgxMGhwb28vTC9nd3ZtUklKblpYUEVzL1Bkd0pVVkxX?=
 =?utf-8?B?cFRRYVkvR1NLbWVoWkNrZEh2T1UybVhQK1dFVk03Unc4UDQzZHozekhoUUwx?=
 =?utf-8?B?Y2l4MWZLWDlRcFlHYkZEVFV3V0xyaGhnUC90WDM2RUUvblZNYmZOSmhObVVV?=
 =?utf-8?B?blVpTHk3bUptTkp0WC9KVnhGbGJNMGlsVEd4T0k2dkxPaENWS2FLeEwyVmJ6?=
 =?utf-8?B?L2NWblV1cHE0T1JmaWtnbFJaUWdnZm9HaEhCTFFVTTU1ZHdwKys4SkN6UGt4?=
 =?utf-8?B?SWRNblFwTytxM0laLzBqVXRmZDRvZTBtT2IyL2o2OVVxZWZNdFBxdUFubis5?=
 =?utf-8?B?a1ROYUk3bnlFd2orMjhFaUI5UDkyQ2dkajdaQkkvWUs2ZDlEUUY1NEkrTmZi?=
 =?utf-8?B?OGVqZDU2QlFkTmdXOW5Jb3E1cVJRSEVsQnFGTWlkeklkd0RHR1VvZDd3dTcy?=
 =?utf-8?B?eUlDN1ZjSS8rL0t2STJvSEcxQ2lGaTJsY21aS3h6WkI3T09QWkZMYUh3TEtE?=
 =?utf-8?B?ZUc3TmUySis3SXZhYlVrakdZbm5yZHRDdW5jZVdtd0lTd1Y0TzFBcTkyYUwz?=
 =?utf-8?B?MU8vaG9mQUlvQ2R4MlU4eGc4RndTdlhhSjUyeG92OWVHNzgyMjNSMFNCN3RE?=
 =?utf-8?B?Q1NpSWYwNmVPVE83bHRKbkJvSHpoU3JBMVpQN3BGemcwWUhCSFVBM2ZUS2I5?=
 =?utf-8?B?YTVLK0dpK25kRkIydEkzOUFXNjRxRDJoWDJXTzJSRnRJTjZwbFQ1Rk5ReTA2?=
 =?utf-8?B?bEg4b3NDcnhwakhlSkVDM24vM0RYUXFFWVpKbHVKWVNtOUNnb28wSk1CMUZE?=
 =?utf-8?B?aXE0eGdZMzFhaHNjRlIvWE5vWDNRUG5jZk4yak1wbUE0WG1xTWh5Q0FQQy9v?=
 =?utf-8?B?YTRmRS93Zi9HKzZFWm5BLzJMeE1XdTMrbk9vbTVPZW5OT29qUjdObzN0aXJO?=
 =?utf-8?B?UEY1czhmdGgyQkRvc0JYWmtRcUdPZGFQRnBBbEpKck1YSWFiYXh0QU5xYS9T?=
 =?utf-8?B?NTNxY3BWQjkvOXVTR2lwWjlzQUxmYXlVWWtRakFhTEhXeVZicTIwRzAvallR?=
 =?utf-8?B?SVVkQmNSSnoxemE2cWI3L2tjTmxqZ3k3ZXc3YkU4MVZ2MEhXNW0wU2U3YzdU?=
 =?utf-8?B?dG4yN2piZnllMzdVVjVraGFydHk3OTNyQ0Q1SFMrOGd5Vi93L04rMkduVlh2?=
 =?utf-8?B?SnR0eGFTVzlxMDhVRXZIZllYeFBFUVZmRkxrV3N1VU11YVdaOTg1eC8zODFL?=
 =?utf-8?B?NVlRZG1XcEFEMm1tbEVCVnhoWDk0Y3dFK05yM2JaNmp3c21ZN3NoTVhCUnY2?=
 =?utf-8?B?T1RzTTFhVStaMmhrYU1xZ3ZJOW9sRE5TZ09rTTNIVWY0WFZaRW1VZmpyL1Ny?=
 =?utf-8?B?Q29jQWR6Z1l4ZUZPZk9LRFhwYjk1dTR3OURUcGZTd04yM2VEQ1RKWHVBdUdu?=
 =?utf-8?B?bWJabVc4QkxBV3lSQy9DUEtSYzhyY1FQR0tvamhHYWkwZHFtdS8rR3Q4S3N5?=
 =?utf-8?B?NDhQOVNmd05DeTJEa21xZEQxQVBOdEsvWW51M0hMaDA0MmdnaU1CeEFFTEVm?=
 =?utf-8?B?MGUveS9LT1lRV1llUDFIRlhSdmxlWk5zVk5yQm1SNi9ZZzZlanZEbDZQMkhx?=
 =?utf-8?B?b1BzbVdSclVaMEYyZlhQV0hHZW05Yi9Jell1aHJZMUZXbUN5cEgwc25EVkwz?=
 =?utf-8?B?ZjJvQ2s0ZXpxbFZoa1ROajYzWGg2eDkyc1BzSi9rWU4rcll4UFZOYUJlcFRs?=
 =?utf-8?B?T0lGa1BDNnJGRSswMkVnTUVCQmNObi9Dc2IxbjdDdU9QNlZLRjRrTklvbkIv?=
 =?utf-8?B?OE1YRVRhRklabFM4Y0U5Tk5BVGcxY25SczRleVdmTG5TcnNJLzhTNmNFMy9J?=
 =?utf-8?B?Y3ZPVFgyUlpEOUdBaWlwRk9MdEJoM3dHeEFjMHpuNk81NUhvbm1SL2hoSktV?=
 =?utf-8?B?R3F0K05BRDlWLzVtMElLTmF3em9Db0VJUWo2Q2VObmltWlBoK2pGUjB0dHMz?=
 =?utf-8?B?U1pNRTJXWUE4N1I0NmZmWjA1TnBmc3JDNldFN0VHdEJ5MWVJRjNXR2Z5T0J4?=
 =?utf-8?B?NmVaM1hlcmNzem9FTTRDcW1LUXRISGhBa2M5UXB6bXozdEthaDVWU0dGT0NP?=
 =?utf-8?B?UlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 895113f1-0ab4-48f8-fe23-08dd517d13aa
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 07:06:20.1240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: maJhd34KUVMEvJB/FjXD9LjUADnbsWf3ogENlar/1xPQEjKh2/d/AYrs7qCW2tB5tEpA9QzEJYbmyHzpLFcwug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7746

On 19.02.25 16:40, Brendan Jackman wrote:
> We currently have $lx_per_cpu() which works fine for stuff that kernel
> code would access via per_cpu(). But this doesn't work for stuff that
> kernel code accesses via per_cpu_ptr():
> 
> (gdb) p $lx_per_cpu(node_data[1].node_zones[2]->per_cpu_pageset)
> Cannot access memory at address 0xffff11105fbd6c28
> 
> This is because we take the address of the pointer and use that as the
> offset, instead of using the stored value.
> 
> Add a GDB version that mirrors the kernel API, which uses the pointer
> value.
> 
> To be consistent with per_cpu_ptr(), we need to return the pointer value
> instead of dereferencing it for the user. Therefore, move the existing
> dereference out of the per_cpu() Python helper and do that only in the
> $lx_per_cpu() implementation.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  scripts/gdb/linux/cpus.py | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
> index 13eb8b3901b8fc5e2500138c7d204ac5f7c9858c..1f7e62efb38bf4ddee0058fea8634fd377317669 100644
> --- a/scripts/gdb/linux/cpus.py
> +++ b/scripts/gdb/linux/cpus.py
> @@ -46,7 +46,7 @@ def per_cpu(var_ptr, cpu):
>              # !CONFIG_SMP case
>              offset = 0
>      pointer = var_ptr.cast(utils.get_long_type()) + offset
> -    return pointer.cast(var_ptr.type).dereference()
> +    return pointer.cast(var_ptr.type)
>  
>  
>  cpu_mask = {}
> @@ -149,11 +149,28 @@ Note that VAR has to be quoted as string."""
>          super(PerCpu, self).__init__("lx_per_cpu")
>  
>      def invoke(self, var, cpu=-1):
> -        return per_cpu(var.address, cpu)
> +        return per_cpu(var.address, cpu).dereference()
>  
>  
>  PerCpu()
>  

Style nit: additional blank line here

> +class PerCpuPtr(gdb.Function):
> +    """Return per-cpu pointer.
> +
> +$lx_per_cpu_ptr("VAR"[, CPU]): Return the per-cpu pointer called VAR for the
> +given CPU number. If CPU is omitted, the CPU of the current context is used.
> +Note that VAR has to be quoted as string."""
> +
> +    def __init__(self):
> +        super(PerCpuPtr, self).__init__("lx_per_cpu_ptr")
> +
> +    def invoke(self, var, cpu=-1):
> +        return per_cpu(var, cpu)
> +
> +
> +PerCpuPtr()
> +
> +
>  def get_current_task(cpu):
>      task_ptr_type = task_type.get_type().pointer()
>  
> 
> ---
> base-commit: f527c5c2abb60ddfd6b929d479b985071500419d
> change-id: 20250219-lx-per-cpu-ptr-c9dfd3098721
> 
> Best regards,

Makes sense!

Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

