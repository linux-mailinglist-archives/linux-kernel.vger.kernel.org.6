Return-Path: <linux-kernel+bounces-215746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E54F5909694
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 09:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CB471F22C2E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 07:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C075417BCE;
	Sat, 15 Jun 2024 07:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="TB5mBbsi"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2077.outbound.protection.outlook.com [40.107.6.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6B917BA5;
	Sat, 15 Jun 2024 07:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718436934; cv=fail; b=thOq0xyZAjwtNbHr2WQ1eoHoVdy3Sc82e3e8hs7rUXrIjRxA991xF1qAJZxM7iZMJEKF4pCjl9vqFZmeaN38c7jBZqz/iw1EpbW6HmbuxKV6k1mwC6J8LVHldW2K2qYzthkhsVVvQes4NH3Yq7wQ4OeBgX5QC7xTdsBOgQvfGS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718436934; c=relaxed/simple;
	bh=snq/u+zgS1M+moXBbsi/lyZsS9ccxZoRwSB5c1qWMUM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M+xURjIprQtpG3d3IPAPkRV3YVCa6sRdpfNys3NWZ+HYmndxIr6+YD2kqxuqHsFgiw81WAf1HlVAA5WSvWO+0Ayic8t3NRSW35jRakfFfwdP5Q3webRh13ga1YgWzq3dpAMsdHu+TzHpm0HMPb4PRMcpkpIvaOwVQB1lAVFGqHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=TB5mBbsi; arc=fail smtp.client-ip=40.107.6.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koABKTWD3qQBYXi3gpEO0/0FlV3a6VUflTO5AsB972YtTlvxwdT8/FuUW3ix1/PBXQVnBrFM1CRGiF3RDFSzF8FuurJQ+XS5Nu7P0giAWqHBrDY8iSRlwXym5E1ovQmXLFMQQp8x6OjS9L3V8YI1fa4DLqz5pnf4yinqCov/+o9LrhIH+7HWWf1stK0IOK1cdCL68UG1KwLt/n2LTu7lrw7i9dDl+Y3C94G1x3/uB2LiEBzaOkAQETkTF56xGr3hyK6Xz2r1in01aAiqo0VfhxBswG0A8Jx4LDLKj5j8/sSJFpvStBmQMgNbFD5ACh2voQUUPIskTjhPB9gaWwf0zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kf0fM9UcPxfx9ZNGSvuZ00EY+pqZr/HuvybTEpbxDQ=;
 b=dsdY8K6qbj2agw+YIL6M9e/2AbTaJ+TvjAZ4W684FjvpJTVj4Utvg8Oj9CKwfcoO9yaIQuZ8sNkdeYMxntRe0eFfiB7GdAxV7F+nZpfcORvqC0k5Oo+jTjTp0xZKPllVEB1+ruoaP7y9g/RbrOHOoWCreRJndI1LCoAkNJb5rNCDO8yxTU7gw4k2TT9kNsgiD6tP1fMx5xgPbbDanDbrK0us5r0I0xM2fd0xlRftgA/J6g4cHovodVtwFaPoxAwvF56xeitVFT4kxhT/UuicZhwzxKsgvgdJalNNGnRg3QI0jhvX93k5nCRa+apfeoOfFDFLHLBLsVvSVV8LnCRStw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kf0fM9UcPxfx9ZNGSvuZ00EY+pqZr/HuvybTEpbxDQ=;
 b=TB5mBbsimSKDGeaMNjwutQ/7uE8hv/iGSSO/7aQDQrfJneCDZdq/Xf4cFEwpJocA/x5Qz8JsMtSvGFW+n+XySvxIdhHxNHgw67SK+OpcBeFp7qWj7HiJejRR/Llf4MvA/l1XvxeC55sqvLVZ4bQ3lvs1TvjlBh0hTg5kwzsBXeI4FDFYdP2ie6uQE8r0tDzCk366fO/zGPnU+Qh5rRF7YHgBNdfWEWJwuWmnGJzy1n2/3icE+NAMnWIi/dvrs8qDU4SIYUOLyYgo7Sjd6rPDPy0fUphjB3YUhJzvAr8Ucbg9qlIjZV7wJB8lLQU18yHUrN4lirnt83MrHtYmEtBhng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7662.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:635::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.27; Sat, 15 Jun
 2024 07:35:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7677.027; Sat, 15 Jun 2024
 07:35:27 +0000
Message-ID: <d942e4a2-dccf-448b-b151-4840fced345a@siemens.com>
Date: Sat, 15 Jun 2024 09:35:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am65: Move SerDes mux nodes under
 the control node
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
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <50327a4a-3653-43d7-88de-2182dc3eb4e7@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: 2efa3747-8100-45ef-0435-08dc8d0db9d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|7416011|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUxudldwMWE4YklmQTV6MERnUFIwNEg3VU9nQS8waUhqY3duRUZ0RVVlT0gz?=
 =?utf-8?B?bHhCTVU5T3pMWHMxNFJuTDdRTDU2UFpDUVZZN0NJaUxKOWpPb3NvTUlqOHlX?=
 =?utf-8?B?K1RhSUdKVFU1bXNEZjg2UVNWVllOM3ZQbVY0cFpTWDZmT2FKelI5UXFYT0tD?=
 =?utf-8?B?U2t5aGtqcCtGTU5IN1RXd3N0WHVYWERycE1vYWQxRUxYYzNqalBJK2dxQUV4?=
 =?utf-8?B?dE1ic05hbkxrd1p5dEpJUWhkNUVHVG9hRGxCVDRMaDU2YTNuaS9nV2c5cVc1?=
 =?utf-8?B?OUxYQzlIenBXMjJ4eDRyb3lObnZ3VjVMU2xXc0lLckhheDNMN3VoWlZHR3lj?=
 =?utf-8?B?REppdXFGTXVISitMWm1HeERQMzJ6WldxY0dpbmliK2ovNVBwR1RRckVLNHcr?=
 =?utf-8?B?cmtkWWUxWldWUnVldXBNaXdUZ1ZRdnpqOTl3NTFyQ2F2dnczZ0FzaHRBcFNC?=
 =?utf-8?B?bjB2aUt2TktrMFZ5TGhSN0RCeldLbWFieFRpZC83b1MyaFlmc2gvRTVTR0Nr?=
 =?utf-8?B?cy9hY1IvUVdWdkRLek1iT3VuK1pqOUdUQmF1WXplUmpoMUlVRWtGU0JrTUJQ?=
 =?utf-8?B?c041RmE0clM1SUtPUzRvbUZ6RE55Q0xkR3FESUFWRnZNZVRmMHBuMFFKc2dK?=
 =?utf-8?B?MXZWNlBhc2RERW1VbmE3M2JJQzdhcE9Uem9wNy92bWxxd2dROHNKZndsbFk5?=
 =?utf-8?B?N04vRzhQZm8vVjBGODFlSEQ2aWdSWUdMSzNJSHpHQWlmU2JoMXB6ZG52ZGtY?=
 =?utf-8?B?UEVDUVRRR1U5dDlUTVVQQjFpTTJuM2RQN2VCUHo3NUU2V1JGZGdTUXlESmNQ?=
 =?utf-8?B?Ti9XY0pFZVdVOEVtSytwTURiY1RNMkV3YXdtZEtrYzJ1ejZIOWQ0eWN1dHBw?=
 =?utf-8?B?NE1rT2Q5Q2dPaVlpaVBRVDhuSnFqZEpCNGw4cVhDeEltK2NPaTNOcXdmYk1W?=
 =?utf-8?B?Q3U1Rytoc05Tckc0czlMTzdkZ0E1ZWR1TlhZYXQwRGw3eVpLSGUvRXg5WlVL?=
 =?utf-8?B?R3ZseXhsV0VoTnZrNDdOVFV6OEZaemZQOUNMY0YyV3o4bVNlTjI5bFpBOS9V?=
 =?utf-8?B?SVl3cEtGb2ZqVDgvUldzdDM4Y0tZZDlNYzNkNG4rcWNQN25VRVBad2cxYXFO?=
 =?utf-8?B?RjNDeG5zNkduUXVtMzZQRmg1Y0wxbTZpdzNIZ2FLa1ZuaTJ1NnBKZ2dGQnFQ?=
 =?utf-8?B?cHdhaWE0Q2JaUkl1SVlhd3ova1VNb2ZWTzVDN0djZUtZZ0pwazZ6d20xTHRC?=
 =?utf-8?B?bVFXY0lzRnRHcFZmY0hWOXpNTzBYYWhrd2pUZHhPWDRaS0loMEdMdldQK3NF?=
 =?utf-8?B?cnRuWklXdXBDSXIybnRRT1hYTUZtbm5QR2NCSVRYTHBlTmExQW5POGt4cmtS?=
 =?utf-8?B?TjVDVHBsN1lEVEQ3bjRwMjNQeTlWdW02VTR1eGpIVUhqYXdZTFlna3MvRTcv?=
 =?utf-8?B?RE1oenNkczNIQUZhdkRNTkxnZ1BjQmJNSjRiRFozLzNQUFlFWFI0cVQzWVFl?=
 =?utf-8?B?VlRVc2x0KzdYN2lZUzdsZDRMVmRSdzhPVDlxOXNaS3NHTHo3M0Z3TUVzRUJr?=
 =?utf-8?B?Q0FhL1VsNzh4clVKcGVQd3Q2a1huVkprNlpyRHpJNURHR1hnSXdBNkRUTUFY?=
 =?utf-8?B?Q3I5MGs3UGp3OFU0MnM0eno0b1RScXJSY2FhbDdiUi85UHlNVTBxOTNXSmpN?=
 =?utf-8?B?eFU1a1JseUFrN3A2Zi9sUXgwY3c0M0FWSlpqeGNyNVdvdlA1WEYxazhvM2RE?=
 =?utf-8?Q?2YhxQ+Bfnz3Wg1EeA8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(7416011)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eCtjMDRpekw3clFUWVhwelB5N0pRcHhxYWlieUtMRjRWUUVwa05ldlVYSm9r?=
 =?utf-8?B?a2VIOVhpRklzaU0vdHR0NUNnMktla3FMM2VqcmNLSDh5dU9jMy85T1BiSWJt?=
 =?utf-8?B?NWF5SmR4d2FXeHAvTm9jbmZ4RlZhR2dDZENabFZIT2dHdE84Y1hlZVM3SFhD?=
 =?utf-8?B?ZHM3M1pFa0RjTzZWQnh4c0wwNHFMS2VqQUEyV20vVHp6MXN5bTAyY2tuN283?=
 =?utf-8?B?ajZOZEE2Y1JNQ2Y2azRHV2RpdEV4bVpsZlovYm9HOW41cmVPMW0xTG5XZ0Nn?=
 =?utf-8?B?UDFEUkFMMUh3SmVML0lhMHhNMEV1bnFDQ3hFdTBxcXJuOXhGUzNzdXl6eDlx?=
 =?utf-8?B?dldYaXlhaktDZEZNZ1J1MmdEQjFQaUpyMW9FMUVtQUJiRUdMZEMvWXZHT1pJ?=
 =?utf-8?B?bDZpdEs2UFNiSDFQMjI4QnB0WE1rQ2huMWc3OXpNVTRRYUtkS1NHS3hlZUNR?=
 =?utf-8?B?VmhJTUxWZndheG5PRUFuK3IyZzI4WFRndnA3SzdyczJJRnVmSU0vbm1lb3FM?=
 =?utf-8?B?QTlrNStyNndOOVhlaTJ0OGpCb1c3M3VES0w5UnlzUTZhckJBWGcyV3dYd0xv?=
 =?utf-8?B?dlRnbG43cGQrUHpESENBdzZTNXF0cmRuQ1pqMEZ1Ri84RFNIdG1oY0pyc0dm?=
 =?utf-8?B?anU5UFVyTFVNT00zWFBHaVRVVmRMb3UraE5HdmtnWlRBSWJhcndhcjhCT0pi?=
 =?utf-8?B?U0hNdjlUek8xU0JYUXBIcU1JTXpEZldJeWdkL2RzL2pSQTVBcXEvQzd3N1lk?=
 =?utf-8?B?OE5SUkprQW9rbFY1L2xZdEFyT01ZTDIvQWYyZU0rQUhydnFXQnl4ZE5Udkll?=
 =?utf-8?B?SStaOFZ0UWNuYnZSWThzS1FZbjc0WWpUVXFkUXl0SXY0K1NnNlRYSWtRYTJS?=
 =?utf-8?B?Uzc1NnhoanB1WHlvVGJpU0xwS2d5anJZZ2tUNTYxM29pcU5JQ2NkSzB3RVhr?=
 =?utf-8?B?cWV5YzZUYkRHbXdnT1lmRmxSUjdZSEZrZ3RkSGpRM2lMKytQd2NOQTBOb0dl?=
 =?utf-8?B?Zmh1NVYxVmlQUzRCdzBQWGdqM0k1bnUxMEVxMytoWkFaeGVIS0tUbGpXOG9K?=
 =?utf-8?B?Y0UybExCSkM1enlkeHMxTVVsQkl6ZU5DSTZXRTJ3WThlNWpmYnJCN09XY1Jo?=
 =?utf-8?B?OTY2SzkrQk55SGZGY3NSVjgvektsenRGMnQ4UGg2aWxidlNoRnk0RFNzK3ds?=
 =?utf-8?B?Zm9wRW9iY0tsNmtZdk1GNkxqNGpNNFkxMjlxVC93RHMyZEIwNFBncjJvWHJD?=
 =?utf-8?B?bWhXUmwwY0pOVjNWYytucGk2MjNFQytnblROYTgyQXlTTDgvcFJOT3RLRHlP?=
 =?utf-8?B?VFBFN1lRbDZGb3QybHNFclVRMGV1cVRqYk9hQjNCdTdxWlE1bGdvZWYwTkJV?=
 =?utf-8?B?eUZOT3dNRHhCZ3E4ZHpwQkhhNndQN3lJMisxTEpGU3JtbGFjMnRGUUdwMGZZ?=
 =?utf-8?B?SGVQWi9oVzNiTVAxWktaMHNkV0xBK28yaURBSGIyeUZKSnJwYWZxcDhWdDZP?=
 =?utf-8?B?cmpIMDNJVW1sMnRMNTVvTlJaUldLWUhEUUpHQnRQeS9GSzVZWDNjL0tqY3FO?=
 =?utf-8?B?WDQ0WFBuOUpLZWpjMGxwUm9hUWJsNGd5TWZkWkRxWU5JOHY1c2U1QnhWV2F3?=
 =?utf-8?B?WXNXU0ZxOWkzZFAzdkFnb3h5RjgxdlhVYWRtanFvWDRxdU1RUmxsMkNsSzh4?=
 =?utf-8?B?SWg1OUlUTFBpaXd2VFhpTW9CbFJndklNbTRIU3N3UURIam40WGs1RG9lV3g3?=
 =?utf-8?B?YUVLbG9TOWYvS1N2QVZLNm1mcHZZWWVhbUJFOVZXMWp0OGFYYVhQdUd0RHJZ?=
 =?utf-8?B?TWpkTUZoMEN3V291T21kVVc0VHQvbG8rc05aWHBaR2V0N1R3MGdkRzhJVFZp?=
 =?utf-8?B?WVI1eFVzQndCYzIvQW4xdEhZM2ZlSzdZUzdsT0xYMFp5a3RCQXhZWHI5aVN6?=
 =?utf-8?B?SXBUdW44RmFHbnZxdVZ4WUZmVXZEd05ESWh2SnVueDQ2YmNrQ0w2NHVyOXV5?=
 =?utf-8?B?YS9qUTgxUWlIZUJaUTIwSDR2cUxNa2RiejFzREI5Ly9TV2JrMVczaElMWXlW?=
 =?utf-8?B?eDFCNURyS2FqeUsxRk5pMmlzajRwSUhpaHVHalJjOHdkYzFGMEdpOXI3T0g3?=
 =?utf-8?Q?Vmqoyfp9++Kap15E8U2iOt8ZJ?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2efa3747-8100-45ef-0435-08dc8d0db9d8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2024 07:35:27.2909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bsvudGNZqxFaE+bDVx4nis/9seLEjZkbj155AM+6vMNiq4+Uox/d2WwLZ5pcvxhye9XvUQTNQULBraKYenci5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7662

On 14.06.24 18:19, Andrew Davis wrote:
> On 6/14/24 2:44 AM, Jan Kiszka wrote:
>> On 26.03.24 19:56, Andrew Davis wrote:
>>> These SerDes lane select muxes use bits from the same register as
>>> the SerDes clock select mux. Make the lane select mux a child
>>> of the SerDes control node.
>>>
>>> This removes one more requirement on scm-conf being a syscon node
>>> which will later be converted to fix a couple DTS check warnings.
>>>
>>> Signed-off-by: Andrew Davis <afd@ti.com>
>>> ---
>>>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 21 +++++++++++++--------
>>>   1 file changed, 13 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>>> b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>>> index 738c5c4acbcd2..5ce67e6a33600 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>>> @@ -66,7 +66,7 @@ serdes0: serdes@900000 {
>>>           assigned-clock-parents = <&k3_clks 153 8>, <&k3_clks 153 4>;
>>>           ti,serdes-clk = <&serdes0_clk>;
>>>           #clock-cells = <1>;
>>> -        mux-controls = <&serdes_mux 0>;
>>> +        mux-controls = <&serdes0_mux 0>;
>>>       };
>>>         serdes1: serdes@910000 {
>>> @@ -81,7 +81,7 @@ serdes1: serdes@910000 {
>>>           assigned-clock-parents = <&k3_clks 154 9>, <&k3_clks 154 5>;
>>>           ti,serdes-clk = <&serdes1_clk>;
>>>           #clock-cells = <1>;
>>> -        mux-controls = <&serdes_mux 1>;
>>> +        mux-controls = <&serdes1_mux 0>;
>>>       };
>>>         main_uart0: serial@2800000 {
>>> @@ -485,18 +485,23 @@ scm_conf: scm-conf@100000 {
>>>           serdes0_clk: clock@4080 {
>>>               compatible = "ti,am654-serdes-ctrl", "syscon";
>>>               reg = <0x4080 0x4>;
>>> +
>>> +            serdes0_mux: mux-controller {
>>> +                compatible = "mmio-mux";
>>> +                #mux-control-cells = <1>;
>>> +                mux-reg-masks = <0x0 0x3>; /* lane select */
>>> +            };
>>>           };
>>>             serdes1_clk: clock@4090 {
>>>               compatible = "ti,am654-serdes-ctrl", "syscon";
>>>               reg = <0x4090 0x4>;
>>> -        };
>>>   -        serdes_mux: mux-controller {
>>> -            compatible = "mmio-mux";
>>> -            #mux-control-cells = <1>;
>>> -            mux-reg-masks = <0x4080 0x3>, /* SERDES0 lane select */
>>> -                    <0x4090 0x3>; /* SERDES1 lane select */
>>> +            serdes1_mux: mux-controller {
>>> +                compatible = "mmio-mux";
>>> +                #mux-control-cells = <1>;
>>> +                mux-reg-masks = <0x0 0x3>; /* lane select */
>>> +            };
>>>           };
>>>             dss_oldi_io_ctrl: dss-oldi-io-ctrl@41e0 {
>>
>> This change breaks serdes setup on the IOT2050 SM (k3-am6548-iot2050-
>> advanced-sm.dts), possibly on more of our devices as well:
>>
>> platform 5500000.pcie: deferred probe pending: platform: supplier
>> 900000.serdes not ready
>> platform 900000.serdes: deferred probe pending: (reason unknown)
>>
>> And PCI remains unavailable. Digging a bit into it, it seems the change
>> is causing a circular consumer/provider dependency between serdes0 and
>> serdes1:
>>
>> root@iot2050-debian:~# ls -l /sys/bus/platform/devices/900000.serdes/
>> total 0
>> lrwxrwxrwx 1 root root    0 Jun 14 07:10
>> consumer:platform:5500000.pcie ->
>> ../../../virtual/devlink/platform:900000.serdes--platform:5500000.pcie
>> lrwxrwxrwx 1 root root    0 Jun 14 07:10
>> consumer:platform:910000.serdes ->
>> ../../../virtual/devlink/platform:900000.serdes--platform:910000.serdes
>> -rw-r--r-- 1 root root 4096 Jun 14 07:10 driver_override
>> -r--r--r-- 1 root root 4096 Jun 14 07:10 modalias
>> lrwxrwxrwx 1 root root    0 Jun 14 07:10 of_node ->
>> ../../../../firmware/devicetree/base/bus@100000/serdes@900000
>> drwxr-xr-x 2 root root    0 Jun 14 07:10 power
>> lrwxrwxrwx 1 root root    0 Jun 14 07:00 subsystem ->
>> ../../../../bus/platform
>> lrwxrwxrwx 1 root root    0 Jun 14 07:10
>> supplier:platform:44083000.system-controller:clock-controller ->
>> ../../../virtual/devlink/platform:44083000.system-controller:clock-controller--platform:900000.serdes
>> lrwxrwxrwx 1 root root    0 Jun 14 07:10
>> supplier:platform:44083000.system-controller:power-controller ->
>> ../../../virtual/devlink/platform:44083000.system-controller:power-controller--platform:900000.serdes
>> lrwxrwxrwx 1 root root    0 Jun 14 07:10
>> supplier:platform:910000.serdes ->
>> ../../../virtual/devlink/platform:910000.serdes--platform:900000.serdes
>> -rw-r--r-- 1 root root 4096 Jun 14 07:00 uevent
>> -r--r--r-- 1 root root 4096 Jun 14 07:10 waiting_for_supplier
>> root@iot2050-debian:~# ls -l /sys/bus/platform/devices/910000.serdes/
>> total 0
>> lrwxrwxrwx 1 root root    0 Jun 14 07:14
>> consumer:platform:900000.serdes ->
>> ../../../virtual/devlink/platform:910000.serdes--platform:900000.serdes
>> -rw-r--r-- 1 root root 4096 Jun 14 07:14 driver_override
>> -r--r--r-- 1 root root 4096 Jun 14 07:14 modalias
>> lrwxrwxrwx 1 root root    0 Jun 14 07:14 of_node ->
>> ../../../../firmware/devicetree/base/bus@100000/serdes@910000
>> drwxr-xr-x 2 root root    0 Jun 14 07:14 power
>> lrwxrwxrwx 1 root root    0 Jun 14 07:00 subsystem ->
>> ../../../../bus/platform
>> lrwxrwxrwx 1 root root    0 Jun 14 07:14
>> supplier:platform:44083000.system-controller:clock-controller ->
>> ../../../virtual/devlink/platform:44083000.system-controller:clock-controller--platform:910000.serdes
>> lrwxrwxrwx 1 root root    0 Jun 14 07:14
>> supplier:platform:44083000.system-controller:power-controller ->
>> ../../../virtual/devlink/platform:44083000.system-controller:power-controller--platform:910000.serdes
>> lrwxrwxrwx 1 root root    0 Jun 14 07:14
>> supplier:platform:900000.serdes ->
>> ../../../virtual/devlink/platform:900000.serdes--platform:910000.serdes
>> -rw-r--r-- 1 root root 4096 Jun 14 07:00 uevent
>> -r--r--r-- 1 root root 4096 Jun 14 07:14 waiting_for_supplier
>>
>> Note that we normally disable serdes1 on this device as it was not
>> required so far. Enabling the node does not solve the issue, though:
>>
>> platform 5500000.pcie: deferred probe pending: platform: supplier
>> 900000.serdes not ready
>> platform 900000.serdes: deferred probe pending: (reason unknown)
>> platform 910000.serdes: deferred probe pending: (reason unknown)
>>
> 
> Thanks for the report, I think I know the issue and can
> send the fix here in a bit. In the mean time, could you
> see if the following fixes the issue (this isn't fully
> correct and will cause a new DTB check warning, but will
> let me verify the issue):
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index 1af3dedde1f67..06ed74197f893 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -478,7 +478,7 @@ scm_conf: scm-conf@100000 {
>                 ranges = <0x0 0x0 0x00100000 0x1c000>;
>  
>                 serdes0_clk: clock@4080 {
> -                       compatible = "ti,am654-serdes-ctrl", "syscon";
> +                       compatible = "ti,am654-serdes-ctrl", "syscon",
> "simple-mfd";
>                         reg = <0x4080 0x4>;
>  
>                         serdes0_mux: mux-controller {
> @@ -489,7 +489,7 @@ serdes0_mux: mux-controller {
>                 };
>  
>                 serdes1_clk: clock@4090 {
> -                       compatible = "ti,am654-serdes-ctrl", "syscon";
> +                       compatible = "ti,am654-serdes-ctrl", "syscon",
> "simple-mfd";
>                         reg = <0x4090 0x4>;
>  
>                         serdes1_mux: mux-controller {
> 

Yes, this works.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


