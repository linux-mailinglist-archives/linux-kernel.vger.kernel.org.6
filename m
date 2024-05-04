Return-Path: <linux-kernel+bounces-168608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 494CE8BBACA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 13:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDF0328239F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 11:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386061CD23;
	Sat,  4 May 2024 11:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="qiA5vHoF"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2111.outbound.protection.outlook.com [40.107.247.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FF810A16;
	Sat,  4 May 2024 11:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714822568; cv=fail; b=uwbhVHnkkEXRJedrjshjxjbrTzJoDc/pPkBatHJTKskINpRkirl5MlOXZNlYtbtiS/RHsjgFEAykzPI2flPKp2Tx/EZ3wceD7kqirH8Gwt1r0DslyYCpjv4iXh4Ou7fe6MEF8FWiTQGqQ3S82rH8IkRWUjHXnSTObbThg5OCROw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714822568; c=relaxed/simple;
	bh=2BeK4J84LaTfSs/z15Fb+yXgF0aBnP2uEeiUOlGjlcA=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=UtblZLY30kXKlQzTJX6nETQI1+LmyfZnpsmU4fir2YZvxF+mNRVst9lQ2Oj8AGf39olVxLq4+wA2taNWvYBi+ByP8xFB6+IFD+PX4tW1bEddK+/LawYxBMtx9n5n7p1vEgsJNiyZYla4dHHwTWizCPMjgJbDMozvysWRZMbdHWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=qiA5vHoF; arc=fail smtp.client-ip=40.107.247.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONMLev21iigDGnvSkZo6cNqkOLF1IDdDpeyL7aEhqRim1irbzukW7LN9/AWd3WxbVhjJf9zXI2lk1lVLSYYYXy9oOmwA20lbp2VzjMq1tcoQfP6mkHbGq61x++6PPtvFsEZ26Mrk1cEKtdGVnZLTUeBlfoZeRmk/XQf6jpwA69/VaGeRJMdqEDPAzfwo86nLpf6fKR9qi7xf7WniH6gOY53XfNyjEItbmn3bc14dKkWPgu0lAaRHtcKVUTs0nPhDsflBK8GeYHWk27R43+1rJDj+Ct7CANy7W/wZfQe+SXnIWqHkIduFM2L+A2f8b5xmI/k9LOTOJp8Jst4wzKiCyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bLPzGnP8QBJV7TMTZXqRRzz2LKIyoTCp7IexpLnmlU=;
 b=mGVCVUzMi5hNNX+lH+VHx0kv/8Glqmv9ZFhFeT9OOVRDzps4m1iGQ8JNtUb+LMfKa5tKsV+N2werB9PnTNcEp/bsP+YGtSp5ArbBiO2HLs4Q//hhvkoC8k8B4uw5JbcwW3zfz7zbQhMtKWOfT1b3HcRfdHLi5QByRp+OGx1i9UcRtLp/HaZewqyMJS42sPfEDDEooaAf5jb9yR3diW11Lebi/hYQ8S22/vBxw6bPCSmtd2p7Y5pXobyIXkFa8IFoZXXGMympqdRERnaEdNDariY+SuwYmZ8ZkzfxtKOugyioSy8ne01fGLkH9A22mbaRlr1Bey7ZPYYeo+NoDyF2Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bLPzGnP8QBJV7TMTZXqRRzz2LKIyoTCp7IexpLnmlU=;
 b=qiA5vHoFgpC1uoiQE29CRvUUEmkPLjFqtqXOy2hYiTK1EPFHNxMc2bcIGJBoovHq8j+PsGecKogetPnTfnBQdVXjjCtNQirgHmsyfO6YwtdJpb3XQ/qHEOFQ1CMiv9GzLr3Ue2Seyq7SMDdkAeN/r4BacaeNd/L8uB4ZKFd5Bgo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS5PR04MB9924.eurprd04.prod.outlook.com (2603:10a6:20b:67e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.37; Sat, 4 May
 2024 11:35:59 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7544.036; Sat, 4 May 2024
 11:35:59 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sat, 04 May 2024 13:35:54 +0200
Subject: [PATCH] arm64: dts: ti: k3-am642-hummingboard-t: correct rs485 rts
 polarity
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240504-ti-rs485-rts-v1-1-e88ef1c96f34@solid-run.com>
X-B4-Tracking: v=1; b=H4sIAJkdNmYC/x3MMQqAMAxA0auUzAZaaaV4FXEoNWqWKomIULy7x
 fEN/1dQEiaF0VQQuln5KA2uM5D3VDZCXpqht723wXq8GEV9DCiXItmYhkgpR++gJafQys+/m+b
 3/QAbMO0FXgAAAA==
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::19) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|AS5PR04MB9924:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b7bbb37-4371-4cd6-2f27-08dc6c2e5edd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|366007|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnNQcCtFWWNZVXdrWWtnSHhjUjlXcVI0S3hKY3piaFRxR1ZOQnplcTlWcHJs?=
 =?utf-8?B?Q2M1WjNlSkx0bkZpM0JobEVBRTJFVit2aklzb2QvMW5nMkxVV2lMS0ljeVZu?=
 =?utf-8?B?UXZpc1dOSTZuSm9NZ055OWlMaTdjZ05BYU9LUUFXanFINmdMNVhvTXRoUit2?=
 =?utf-8?B?WUhwMjBDelROcWhzcGppRmFnTmlmNmN3S2loY0k0ODBQYnRDMW9jYzQ5TTM5?=
 =?utf-8?B?WGhhZmtQY0xjN1NWaWp6SEJjRzViUGliSktQM20zSko4OFBtdGdVeTNQYVJp?=
 =?utf-8?B?RHY4ZUNRTkcwNmkvcThkbHJFeExJanRSbVZxZXVoNjdoUWdSSzZiSlB3cEti?=
 =?utf-8?B?dUtRSnZrUHFDMUlBREJONTQrSTRLZlgwd2FTVFpBK0k3a3E1ZFBhanlINWg1?=
 =?utf-8?B?RmdUSjZpVXhLWEVVVjErdFNyRDJ4VHp5Mm1RRllmYjA0N0ZwcXp2RldvNGc5?=
 =?utf-8?B?Y1B1UnkwSmtkVGpPc2F6d1c5UlA4TDBWM3kzU1QyQjhPOFI3NmtpaTk5WTY5?=
 =?utf-8?B?OVVEY3ZSbnZlZEJIbGtvZDFnbFJzQXpSZ0g4bHVReHVFSll5dG9TeWUwb2NT?=
 =?utf-8?B?eVFrRlZyTEVIT1A4VVRyM1JtNFNGWGR4WHZ4Uyt3OG10VDkrM0ppaHBaRW1n?=
 =?utf-8?B?d1BUenlQWVBjQVZlTUtkVFQwTVFodG5HTkJ0K1dVS3NLQndwNmt1Yk1Fclla?=
 =?utf-8?B?NmUrQXBleGZKU0FkdUZRR0hSV2Z3L1BJLzRPV0NFZlhzMC9BOWQyMHFyQURR?=
 =?utf-8?B?Wnhaanh2QjVwTDB2MEhEZ1JEQ0tvbVF1STRoeThKNURPRnFvNHQrUFlhRFI0?=
 =?utf-8?B?S0JnTldiWlNmamp0TUNRbzNrUWtzYTVoNHQ0eHROR3dTM2krSmNNNFVKRjFX?=
 =?utf-8?B?UTRmWWExNTJGNDF4VzhqT1diRS8zaDI5T3YyamcvaFZwSk9CQ1BWRzVSdFdo?=
 =?utf-8?B?ZktXMGt5V2VIMXZrQlBjRU1pcGc5cUNYV2NlVDNEUDFoVVZoK0dDT3RBamdG?=
 =?utf-8?B?eExZZFpVNzVYejZCcW9CVExIa0dzM1Z6WXp6RElQNGlvSU8wV2I4VUxYS041?=
 =?utf-8?B?cmlvT0NKWVdzSkRGLy9XVDFkYXlQQTQzMmxhQzdDQS9kUTZnV1BBVFZiaU96?=
 =?utf-8?B?K2Y1YWtlZ3gyMEJ2VUprZ2Vveks1TzIyWkJzQVh0K2FNWThhbGRVeGM2QWNL?=
 =?utf-8?B?d21DenRoMWZZbm0vVnVOVW1iVmNrS1pES0Y3cXFkWTRaZWhHTjBQT1JiR0JV?=
 =?utf-8?B?dGYyTlcwNGZVVG5JZDNWQ0NIbTY2YW0vRHY1WHNTQisyYXY4cDB2czVSLzhD?=
 =?utf-8?B?NkZuTDZQWGZvUDFCZ0RpZnlKSWQwMUxrdGcxVkNhTlFRaC9UdXI3R0FvM2lO?=
 =?utf-8?B?eXN4cTMvUDN0aS85eDRNN2NtaWk0eFFpVXVVSmxMdEwvaUlZUkNGWVI2UjJJ?=
 =?utf-8?B?TGZTL3ppS0VRMHVudS90QnptaVRqY0dPYXBVNy9uQnJhaElscDJnWVVwZlBL?=
 =?utf-8?B?MUhXUmJpWTJtUVRleHAyREtmeldheldGVVBjbjlUN0pJc1dsc1VWNjFaL3k3?=
 =?utf-8?B?VGIzM0t6UVg3OTBuOFQ1VkdHVktKS1FEa0ZxTFhpVnlqVm05c2VGQUJjaTVk?=
 =?utf-8?B?THNIbkxld1V0c1g0ZDZmVmtOQjdLdXpLaThVc0lQR0JHSWl1d0VBd09NVWZ6?=
 =?utf-8?B?d0llaTUzS2xiMW1lbXRxOXBXcEpTODdpRWp1V1BXcTFVRlhkWVNCY2V6WEth?=
 =?utf-8?B?dU9YaFBEZUlWdmI3enB0RDNoMTN4VlZsYXMyNExablZ2SVg3aUpGc0lyZmhn?=
 =?utf-8?B?MWVmNitUSUFaWkR0SjJXdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(366007)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K25XOUpFSkxkbzRJcjIwRWM5ZjMvOElXQXFYajZVbVlnSklRL0hLM0cyZUw4?=
 =?utf-8?B?cC94cFVBSWo0WmpvNU5LREp1Rk14OWVBNGR5N01kOHI1R3BRZkpnd21lNDdQ?=
 =?utf-8?B?U2xubi9GSWtydUkvWHE3dW1ySk1ZQ2M5MUs1WHhiQ3VJeDJmajIwa2dhQ083?=
 =?utf-8?B?Z01aU1ArVXE4T3FqdFViNVV6Z1RlaDBwc1Fhcy9HV0RRaEtrWUNYZ3lEWGlO?=
 =?utf-8?B?RmtleXZ3akFkWTgySlgrYXRTM1NRYy9Zbm5nK3ZyVWVYQndaRFNVcHJvKzJE?=
 =?utf-8?B?ZWxNNGFIeEN4K0t5RXd5RlFMdHI0bVdIcXgwZFpuR2ZtTGk5OFc3akxndlZ5?=
 =?utf-8?B?OEsrcUVJMU4wcU9SajFvdlFJUlM3ZmU4bDJjZjdOU1JlekNVZWNoNHJDYWx1?=
 =?utf-8?B?Tng5WDJ0THp0eDRlaXBkakcrcEl5alpZQ0U1NjdnaFBvRkJreHFuYUliL3Bo?=
 =?utf-8?B?aTFSQmk2d3ZPaktMWjIrbGEzOEdNSCttM1VyRWFPU2pvRHlhZDE4dmppeFdj?=
 =?utf-8?B?VHcxTnU0bzlUNGlRUHJSSGhkb3ZJRUM5cTJVdHNqTVBIeWVHeVlvRXorVHEr?=
 =?utf-8?B?STlDQms4dTh6L3VGSndzZWpRbVNrSm92a1QvczlJc0NwU09PRTJqN0dDWTVG?=
 =?utf-8?B?bE9xZkR2OEwxdmRsYzN3czZFZUFkK2FGSCszZk9OWGhENkM4cDJqOVMrMys4?=
 =?utf-8?B?TW8yWFNwL2Fnb3BOcENTSDRFa3diNHZES2xsSXk3TGlWMWw2YXpuc056SzR1?=
 =?utf-8?B?Q0l4K21NWkZDN2NIdzVDbHJRalYrR2FuaDlsMGxhZnNpRURlSVdMb2dkOUhP?=
 =?utf-8?B?VFdXa1k5bWVZL3ZRL0x4WE5DR0JTaS9HR2VEUkh1dTNXam5Idlk0UFNaL0dv?=
 =?utf-8?B?blpSR3ZBVkdSUHY2QUZ1UTQ0bzhSUWFLK1Y0NXNkN01BbUtHbk5yemRlT2tu?=
 =?utf-8?B?VUN5NU83d1hwT1grWmVlQlRabE44Z2lNb0pZZ3cxb3JpQVdVOWdJRGdIa1Bt?=
 =?utf-8?B?amFYdzRDa2pBdnRZRmJZQ3lkUUpNWFVyL0crZHMzYWpqQkZGV1J6TEdZQXR4?=
 =?utf-8?B?a1F3elFHYm5YZHVlS0lMSzYzaXEzZEN1Tk51b2l0dGw2Rlh0VkZlK1dER2gr?=
 =?utf-8?B?QzUySkpIN3I1SEtZV1hvdEdUQzBTMHAwTzlSenczRXFaOVYvd0NNVkRUd1NX?=
 =?utf-8?B?YjlCTjQ1azFmcHZlZEhFdUQzK0JrSU5XRTZ4b2JvQWR3Um9rWm1HUWhpUlZ6?=
 =?utf-8?B?eDZldDB4RVhFVlltWkgxM1paeXc1cGpWRUJLR3BCSEQvMk5jVDl0VVcweDFG?=
 =?utf-8?B?dmdlYkM2Y1pEV1pQT0hQdzZTMW90dVF2Y3Q3bDBGRE5Od0dvQnZxNTB6cFRB?=
 =?utf-8?B?QjFaMFc1WlRJZ0xPTkM4ZWNrMWtKZU1mUjV6bk1WTXdDTVZJMjBSNkxYN2w0?=
 =?utf-8?B?cFdtbFFQRFZQeWJlTHNLZit6RXdKUDJlSzBoSzlWY0tkTldzU2d2Wll2TXhS?=
 =?utf-8?B?OUhSVXNYczBkWVhOUmRUNGFPUmpKZjNUdmwzdFJ5RkRnZUxEeURQczYveXZp?=
 =?utf-8?B?ZE5iNG5nbnZobXlWRDNuN2MvUi9ocWRwbENheXJ5clBxL1pRUjJqeGNxbnM3?=
 =?utf-8?B?Y1Z4YnNoK0R3blcwTFdVcUM5dFJ1cUkzc2pqRm80eU1RWi8vZkdpYmF3Kzlk?=
 =?utf-8?B?bVYxTlBKRFA1OVlrU0EyRStmSEg2dWNvT0lUMXN4Zm14R0ZUU3Awa3F0dVNJ?=
 =?utf-8?B?RTNuNml4dWE4NURKenV2cFhJMXBidEJoVkM0aUJMN3lueWFkS041a3A3cUlQ?=
 =?utf-8?B?MWhaNzlhRzRHMktkM2NQNk9YU2FnbWljMHlXWTcvelMzU3J4c05pZnRWMlU1?=
 =?utf-8?B?T1FIcUhZSHRJWGVPdCtlN1o5d1RUMTBHOXZld2hCdy96b1dseE1aUlVLbnhD?=
 =?utf-8?B?a0RFRUZvTDFiZ2E3VVBoSWZkeSt4TS9hTit2Wm1ZV0xxa1pxdVJOcFc2cXN2?=
 =?utf-8?B?RGdGdnBDekxKcXFweGNFTC90bGM1UWF5Mm9ycU8rbmI2NDhNdkVvQzJvcitB?=
 =?utf-8?B?anM1VDAwb2VyWFJQZVMrQ1Bka3c5YWpDbUtTcURwaUlwNFppcWE0eW5RWFdk?=
 =?utf-8?Q?VlSBX++LIpykIm4AYaVfhDgU7?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7bbb37-4371-4cd6-2f27-08dc6c2e5edd
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 11:35:59.7746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FjDlMMGGMY8ouOzXiD0WboeAkl0zaGLKpdD+udYwifbPjkyJJBDvMRAt3KUzXwSPx1qfJbftbRZbzA136mPjqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9924

The RS485 transceiver RE (Receiver enable) and DE (Driver enable) are
shorted and connected to both RTS/CTS of the SoC UART.
RE is active-low, DE is active-high.

Remove the "rs485-rts-active-low" flag to match RTS polarity with DE,
and fix communication in both transmit and receive directions.

Fixes: d60483faf914 ("arm64: dts: add description for solidrun am642 som and evaluation board")
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts
index 234d76e4e944..5b5e9eeec5ac 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts
@@ -282,7 +282,6 @@ &main_uart3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart3_default_pins>;
 	uart-has-rtscts;
-	rs485-rts-active-low;
 	linux,rs485-enabled-at-boot-time;
 	status = "okay";
 };

---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240504-ti-rs485-rts-e08a68eac841

Sincerely,
-- 
Josua Mayer <josua@solid-run.com>


