Return-Path: <linux-kernel+bounces-324304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC66974AE2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BEFB1F27314
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A6E13BC26;
	Wed, 11 Sep 2024 07:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="lCJ03m1w"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2131.outbound.protection.outlook.com [40.107.22.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A6713B5B7
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726038088; cv=fail; b=Bb+MYJwDCEhz/j2iUuYZnlpQTv0y7JIu1L7KQpyz/y1BORhYPZXuorOifdzqoDjOKGOhusBQCXc6RsY+hdXwWHFrlvvc3xUp1cBaagXP4NcKZ1HGenWQd+2irF6DZ2XncgiualIoOCAPeckMLvNm9AgKqgfVUCxi9E+qkd9luVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726038088; c=relaxed/simple;
	bh=UVuTHVOozly6EUg0BnhzAXVSGP1y/PgkkBGC+30E/kM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rd/o6eB/Y9za7aPWfbUJZ6sPS7r+YxN7tzem7NgjhuHA7D4l0r/58e+NIb9MSkrXWqYXSZps+PhGCtkM26R9RQCI1BPo8vJh7eVoA0Fw15Ibmu1hfjmNK+CyZsIwbeFmmTFMwPdheuDHO56TtFYyH4BI42lgS7bVVdxp3AMN848=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=lCJ03m1w; arc=fail smtp.client-ip=40.107.22.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zKQYpH/GyBwvogH9PYPx45eTGM0GGoCpfl2142L7dVKs+wvPnUfJD0YhjRgLbCsdFWZGRjcPDZWNXjyUZ+mrzxGGD8f6+Dqqq251fKKU5CscYeq/iIGIiVYR8QBG6/U9UvcrbnjXXzoT0WTpxFmBDD9KIDubJ0jQrrGlKUpaTSuGMfihc44dRLprEDtP8xZkbH9xes1+TGuJF5WzLuqkmg2RxxO7pKpHceeBLHG9lwpXc600QGuxIjOfeB/FAAclhQe2AIbL9+aeFYgKINXv/X1Ehb3KIdANIXNK0jpPsXchhxekUEDKgg0uxjWDE1QIt+mhYA7XOHnmf6GPX0ACpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AKq3LFXcydHWQzVBi/TqJI9X4ArJOPi0fZu7AjuPFQ=;
 b=ff82ZgvR+XQ9kOS/XYf7O+8+zuoF+jQmnyro9brVhsMyz5OIS2WoS5go6yR5ndW94mYsfNyqgqjIhkENDRkl6VIAWKzPpCT6yFSV4uyOmbwPGw//YPKfzVXv4O1HcvXnEf00hv54xE9yZCsOnMOxfsOUspalYE3OK4DbhDR92unhtBA51wPYuA7VWR51mk996tw+aFr5bfyZRQHriXW8KqviIpabRBOZ7QxcmcNwbsKJrF945cf7dXXdacu99c+IPflTykOmTUOZdgO4ZVwic45NkS6c7rxE67MZxf2yFhqiwbteV5C/mMPGlahQfCqX/2Trdcb/9h07FuKpoWkYKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AKq3LFXcydHWQzVBi/TqJI9X4ArJOPi0fZu7AjuPFQ=;
 b=lCJ03m1wx5UDCtzPU9ooHYt9baKtcWs6KuULUyGr0GNPFWpFopyu+DnluMOF/j/t7WeO+3NN9OGx3TvlsBHlcdgppSQ4FevNzzmmo9By7rdz+dk444DFoytlXo/21c/k0GcNhZ6FHiBMIaczAavhOmYmJ9iy7botpc/96emY3Mc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by GV2PR10MB6233.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:78::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Wed, 11 Sep
 2024 07:01:14 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 07:01:14 +0000
Message-ID: <bbf4ec7e-ef77-485b-b748-4bb3a6baba59@kontron.de>
Date: Wed, 11 Sep 2024 09:01:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 3/5] xphy: freescale: fsl-samsung-hdmi: Support dynamic
 integer
To: Adam Ford <aford173@gmail.com>, linux-phy@lists.infradead.org
Cc: dominique.martinet@atmark-techno.com, linux-imx@nxp.com,
 festevam@gmail.com, aford@beaconembedded.com, Sandor.yu@nxp.com,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Marco Felsch <m.felsch@pengutronix.de>, Lucas Stach
 <l.stach@pengutronix.de>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
References: <20240911012838.944630-1-aford173@gmail.com>
 <20240911012838.944630-4-aford173@gmail.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20240911012838.944630-4-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::9) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|GV2PR10MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b382162-855b-44b4-3a97-08dcd22f86ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVlYcmtqSVdyNmx3cUpvOS96a1pEcE52M1h1bkExS1ZPaXJ6eldHY1pFZlpn?=
 =?utf-8?B?OFZmNFErRjEwcWJpTldTZnAwckRoUDdGVDRhV0ZtcWlBTHBYL2RpaXU2ODR6?=
 =?utf-8?B?TEkvdzBvUDNpOEZzVzF2d25iRlh4ZytGVXZHVjY5VG95VVd1eVQvSWpKVnhL?=
 =?utf-8?B?OEN6eXFVMkdCQ1ZKZ1NhQmpGNllCY0ZvOXZYWkRXZ1BSbmlmNTdLQ25tems5?=
 =?utf-8?B?bDVIeUhFWVZRMzdDUzFnUUlxRE1lTENPR1ZDLzNGY2FzeFVpUlhhWXNCSWdZ?=
 =?utf-8?B?UDNhU2Y3ODdHSTVmbVdRdTZ0cTFrcXhrVU1EM0hMNGpNK29vRDlmSExBdUtX?=
 =?utf-8?B?b2NYVlFHd3hpUHQ3MXM3VGQ3SWJHNVlSdnN5R0NndXFrMGNOQXBmVFlwdDFH?=
 =?utf-8?B?RDlseFhoRm5VYmpEakIwL0hJZkVnRE9JaGNESFdrQ2JrNHFKN3kvVERXd2dQ?=
 =?utf-8?B?ZzFIOWhYTFJzZ1QvRE5TT0w2by85cXNMSXFIUXNhbnVLb1J0T1dXdUI4dWVi?=
 =?utf-8?B?OWJTZk1VaHlkNC9XR2RpZGZnOWJTRm03a1dwdmN2TlJBSXZjQWYzY05aMk5O?=
 =?utf-8?B?alZvUi9PcU03R3RFeG9TTzZmL2tnWHVpOVVQOXV5V3dJckFFQm1nYnkvWFJV?=
 =?utf-8?B?aDkzcE5EcXM1ZE9FbkwrMjY0ZURuM0NLbXBqMWYydys3TThjMjA1L3l6Z25I?=
 =?utf-8?B?ZHB6R3BBOGFGWHlUSFhjMFVxVzZrdHhyTTN5VEI5bTMzeG5HSG9jQWJQU2pP?=
 =?utf-8?B?UGRpbXpFU3NRNjRTaG1TYmR1WW1xK3BIMU9ROUdyQ3J0ajBPc25JUTRja0s2?=
 =?utf-8?B?WkpDTUJMRFRvbFBzR1hEZzRDR0JPR3dESFBIOHh3cC9JaXJuN3BGZkhzK0U3?=
 =?utf-8?B?UnBscEg4SEh1NmdVSytjUjBNZmNGbVRzcUs0NXlQMWMvazFpZERTOUNaM0c0?=
 =?utf-8?B?cW9jcFo5OVhDUFRYOWtEZFVwZ2s2SCtKK0N6bXVjTExKK2hKYVNUeTkvVlF4?=
 =?utf-8?B?T3RsSnlCd1BmdjBqUUdURnBnb3haUEdseTlDSEZaQTdURkpoelJUSzA1ZGlV?=
 =?utf-8?B?ejVxSndkL0lTUDArOFZoWXRvTXd4NUdmVnFTTmk4ZjNGWHZpMzUvS2lFZHhR?=
 =?utf-8?B?YjhmMk5WbElrVnM4QWVxNHpnT2xGNW5BUFdyT1hWN1ljQ2xxcWxlQVh4VXkx?=
 =?utf-8?B?anVGRXVZSStoTU9qYmlrdXU4ejI5ajRKU1JhUFFkdDVvalhkN3VncS9GMGV0?=
 =?utf-8?B?bkRxazlKU1BGK2piNVRXN1BHcXp4Tk1Jb0x6K3l6d0V6NlB5d3NiN096c0xn?=
 =?utf-8?B?dU5OalptV0s5U0VXVHVmNTFWdGp4RlAyZndxUzA5R2U0ZVZQeEEvcW1nNytJ?=
 =?utf-8?B?RURKcGtWdHZjWU1SOXdoWk1VVjl1clF2NWhHK0NYZUdSRHJUSWcyTUFUc2Zr?=
 =?utf-8?B?K1J2Z0J4T2gwNEZmNGd6MnpyM3lZS201aGd2QzBwQm1TRnU1RjcvT2ZBV28z?=
 =?utf-8?B?UEtJSVhiQ0U2a0pnTnpzeTVjeUQ2T2FYRTVvYURFVlRvMFo3QW5WaU12a3dR?=
 =?utf-8?B?Nk44NzVhVjgxMVh6R1BieGMyRDJubnZtUjN3THVnRHNwOENySkFVRUhtZFNI?=
 =?utf-8?B?WVk3K1B5eG1LTVNMU3VpdllZcjhEMWt0dGZOWENTYXZGNnVscFcrK2xxbFVy?=
 =?utf-8?B?OUp0dFYreWdLbURUVjZaWE1ha3o1YVdmeXVxSThjMWtWWTlERXdHUENzeHBB?=
 =?utf-8?B?d21SYnZwMlIxeWswUGV4enRlTUVFamtKRVgvVWUwREszNWNsVWh3NzVhWFpn?=
 =?utf-8?B?b2JTMW1uL0hyZDhxTE1YUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vm9FRFZJOWhxWW03MVFtbVp4cWl6ZkQxM2FoZnVNK1dNaHRTcUV5c29kNzNM?=
 =?utf-8?B?QnRYNUp6SEwwTmhzL2c2Q1cwaFlRRm90TzE1cnZuZ2VGeVdPd0xqMi9QMHEy?=
 =?utf-8?B?cGU0UEFza3p4Tnp4MXFkanFzS3BtUE1CVW1XMzNjRlNqQ1hxTlIyNFNDT1Mr?=
 =?utf-8?B?R01xMTd5UzNJZkJtTWNkSlp1cFdpcUxrQ203emgvMzMzbkRxa2h6U2RkVU5v?=
 =?utf-8?B?ZnkwOXBRTGcrRGhxcEZyWGJIRDYrWTI0Y0c4aVk2VzNhRE93WVN4bThNNzJ1?=
 =?utf-8?B?MmNlZENYZFJjb3NkV0FYTi9ORWF2TTFSQ2J6aWs1NkZ2WjJkeWtTNWt1UmtR?=
 =?utf-8?B?c0RIOVQ4VXpPTmZrWHhoZHR6Qm13MVV3SVRBc3RhMEw1akxaT2Q4MUdLcjcv?=
 =?utf-8?B?SVE2OGJITnVXa3UwS0tObnFnSGYxeXVnQk8vZmhpRWdhUysybWdSUC9kYTFY?=
 =?utf-8?B?KzRETlhWVWFoZVh3VE9IMjZIbUllcUIrWmR1R0RrUVJWMEJ3MUVWODUzNU1T?=
 =?utf-8?B?Rmd5U0FMUythRUVwa3JXZTBSVi9qVzhhampMVDNUeDZxL0xrWG1PT041eGYz?=
 =?utf-8?B?bHNXdDlIYUFldzNhRHA5NzNpNnlwa1BqL3ppVXBOVy9FcFpXWnZxVkI2TW9i?=
 =?utf-8?B?VWgwZEltdHBZS3lKWUVJU1E0UlYyMUp4ZUVUSks4RG9ONmYrOVRZdnNKbnBD?=
 =?utf-8?B?RnRBNDFWdEJtdnVqQ09kbUFTb2NlM2ZROEhNTWxuekRTL3ZSN1dzdFdla1BT?=
 =?utf-8?B?M1IwY2pnM0hhWUdnMXZpNXpiZTQ4NWJ0dTBvVDRZdXZwdDdSdzJ5WEdGM2x3?=
 =?utf-8?B?eEZNZVdMaG5tdWx2R0RMRTdKdGh0cU1mVVlQYlcrQ2I1bEhKd01RQnU1eTNq?=
 =?utf-8?B?eXQydGpwU2VYSVh3Q1pCS3BwRzNKay9OSk10U3ROOUZJbG9PV0tVTnNRUThu?=
 =?utf-8?B?cVFWU3lGN2ZYdmthdFVZcXh4TTNWK3lFcit2YTE3M01LajZvQ0RhU0tiVzFt?=
 =?utf-8?B?bmZZTTg2NlBsR2ZKRFl5OUpwTXo5b0ZZeExvYk9HY2l4a2o4RzhOb3RBV0tH?=
 =?utf-8?B?NURTVWYwbTdJbHRnUHpyOVN3Vnc2cW9EU3dhYW9DMEFtaHJhZlhMWGc1NlNI?=
 =?utf-8?B?WTgyZEZNZ29zdzc0ZDh4RWtOdDhucHM2anVXWXBCMXdydFFiblBFYXhNODhs?=
 =?utf-8?B?dHhvVkNPS2VXMmJpQlk2YnZuYnBWdmF4TzhWb0JtNUdyWFFyZGFhQXFRclNP?=
 =?utf-8?B?MGliZE01NHVZalZEWGMwOFNDb1luL3lUa1dqR01BdWg0NmFWU0lmNGlsRW1n?=
 =?utf-8?B?WGE3bEdaS3NwTFNyem1YVHBEWWRwOVFEbWVmOHh1ek1FaXd6ckRhemsvYUxL?=
 =?utf-8?B?R0k3Yi9Bb3dUNmFNMDF1L2hEZXA0NHdheDFXVStlUEg0bERuWU9nbkkxK2lo?=
 =?utf-8?B?aGxwMkxCa1ZCNVY3a01iL1M3TzN5ZnpZUTRNK2lBQzFkQ25CY2c2RWt2b1lu?=
 =?utf-8?B?czRPbTNRdFdYcWN0THJCTVBLakRFTURYcnFmeTRTK2J3OTEzVzY4aGJ6MzhC?=
 =?utf-8?B?Y2x6ZUNhUVNnRmR1bzFlckVNdkYrV0phcU9IcC9oQkNkNGpNMS9FQStobU0w?=
 =?utf-8?B?Yy9DN3JXSDhtTmxtN1BYeExYQlM2aHpyQ0huWERtN1FFOWd1OWhQdWlqZU9T?=
 =?utf-8?B?T25tRmM3V285VE1ISlZxYlpIUk5Tcmc2VEkrd1RGbldna3RDTlI0OEswdE95?=
 =?utf-8?B?Z3o3UnVUL3hJcWw1cUJ3cGhNdjVhaWR2THFURk9ydWFQT0tUYmpQWUJBbzBh?=
 =?utf-8?B?cnE1em9qUXBMV2F1SGtxWDYyNi8vSjY2VzcreEgrV1BRU2tIRDc2UCtrL0pq?=
 =?utf-8?B?OWluMU9reUkzdDQrbmZsNlJ2Z3JlVnFSdVJDVm9FQmk5M09rOWNGQUo1bXJj?=
 =?utf-8?B?dUhWekJNRmRWQm1oVnM1Ni83SzBOVTNUUDlMUVVMZDRqMmp4TEUzUnRuQ09S?=
 =?utf-8?B?eGVPYjhMcWVRdlRUeG1uLzVOVFRSTTJpd21hcjU5blNOM2N0ZlNBLy9NY1gz?=
 =?utf-8?B?QnBqdUlaWDFJRnh2NTRHdytKdnlyajJMTEFJUUlIZ1NWbTFYbDk5RFlTdmF2?=
 =?utf-8?B?dm03WkVlNUFkRU5rNVAzRkFjMVpIRkhTSldyYWNFSE5QdnJtMWx6ZlFHMDNF?=
 =?utf-8?B?Unc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b382162-855b-44b4-3a97-08dcd22f86ac
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 07:01:14.6158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D1Y5k/2tw408755Vd8r66w3QLw7aDLgCIPrp06NrRgnJPCcY0s1fh+ZSJvlu+6HbRZjgBxv1TYIlxHwX/6XfObFTM8oBTkE00DgXJl8ja3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6233

On 11.09.24 3:28 AM, Adam Ford wrote:
> There is currently a look-up table for a variety of resolutions.
> Since the phy has the ability to dynamically calculate the values
> necessary to use the intger divider which should allow more

                       ^ integer

> resolutions without having to update the look-up-table.
> 
> If the lookup table cannot find an exact match, fall back to the
> dynamic calculator of the integer divider.
> 
> Previously, the value of P was hard-coded to 1, this required an
> update to the phy_pll_cfg table to add in the extra value into the
> table, so if the value of P is calculated to be something else
> by the PMS calculator, the calculated_phy_pll_cfg structure
> can be used instead without having to keep track of which method
> was used.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V7:  Refactored much of the code to create smaller helper functions
>      to eliminate redundant code and improve code flow and comment
>      readability.   Any t-b and s-o-b tags removed due to the
>      extent of the changes.
> 
> V6:  Fix comment typos and remove an unnecesary extra calculation
>      by using the cached value.
> V5:  No Change
> V4:  No Change
> V3:  Change size of pll_div_regs to include PHY_REG01 (P)
>      Create calculated_phy_pll_cfg to containe the values
>      Eliminate the PMS calculation from fsl_samsung_hdmi_phy_configure
>      Make the LUT primary and fall back to integer calculator in
>      phy_clk_round_rate.
>      Check the range right away to ensure it's reaonsable rather than
>      trying to find a clock only to learn it's outside the range.
>      Overall added notes and comments where stuff may not be intuitive.
> 
> V2:  Update phy_clk_round_rate and phy_clk_set_rate to both support
>      the integer clock PMS calculator.
> ---
>  drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 371 +++++++++++++------
>  1 file changed, 265 insertions(+), 106 deletions(-)
> 
> diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> index 4f6874226f9a..49317a96f767 100644
[...]
> +
> +	/* The ref manual states the values of 'P' range from 1 to 11 */
> +	for (_p = 1; _p <= 11; ++_p) {
> +		for (_s = 1; _s <= 16; ++_s) {
> +			u64 tmp;
> +			u32 delta;
> +
> +			/* s must be one or even */
> +			if (_s > 1 && (_s & 0x01) == 1)
> +				_s++;
> +
> +			/* _s cannot be 14 per the TRM */
> +			if (_s == 14)
> +				continue;
> +
> +			/*
> +			 * TODO: Ref Manual doesn't state the range of _m
> +			 * so this should be further refined if possible.
> +			 * This range was set based on the original values
> +			 * in the lookup table
> +			 */
> +			tmp = (u64)fout * (_p * _s);
> +			do_div(tmp, 24 * MHZ);
> +			_m = tmp;
> +			if (_m < 0x30 || _m > 0x7b)
> +				continue;
> +
> +			/*
> +			 * Rev 2 of the Ref Manual states the
> +			 * VCO can range between 750MHz and
> +			 * 3GHz.  The VCO is assumed to be

                                ^ whitespace

> +			 * is assumed to be (M * f_ref) / P,

                           ^ duplicate "is assumed to be"

> +			 * where f_ref is 24MHz.
> +			 */
> +			tmp = (u64)_m * 24 * MHZ;
> +			do_div(tmp, _p);
> +			if (tmp < 750 * MHZ ||
> +			    tmp > 3000 * MHZ)
> +				continue;
> +
> +			/* Final frequency after post-divider */
> +			do_div(tmp, _s);
> +
> +			delta = abs(fout - tmp);
> +			if (delta < min_delta) {
> +				best_p = _p;
> +				best_s = _s;
> +				best_m = _m;
> +				min_delta = delta;
> +				best_freq = tmp;
> +			}
> +		}
> +	}
> +
> +	if (best_freq) {
> +		*p = best_p;
> +		*m = best_m;
> +		*s = best_s;
> +	}
> +
> +	return best_freq / 5;
> +}
> +
[...]
>  
>  static int phy_clk_set_rate(struct clk_hw *hw,
>  			    unsigned long rate, unsigned long parent_rate)
>  {
>  	struct fsl_samsung_hdmi_phy *phy = to_fsl_samsung_hdmi_phy(hw);
> -	int i;
> +	const struct phy_config *fract_div_phy;
> +	u32 int_div_clk;
> +	u16 m;
> +	u8 p, s;
>  
> -	for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--)
> -		if (phy_pll_cfg[i].pixclk <= rate)
> -			break;
> +	/* Search the fractional divider lookup table */
> +	fract_div_phy = fsl_samsung_hdmi_phy_lookup_rate(rate);
>  
> -	if (i < 0)
> -		return -EINVAL;
> +	/* If the rate is an exact match, use that value */
> +	if (fract_div_phy->pixclk == rate)
> +		goto use_fract_div;

Actually I don't really like the jump here and the even more extensive
jumping in the next patch.

Why not simply create another function and do "return use_fract_div()"
here and below at the end of phy_clk_set_rate().

>  
> -	phy->cur_cfg = &phy_pll_cfg[i];
> +	/*
> +	 * If the rate from the fractional divder is not exact, check the integer divider,
> +	 * and use it if that value is an exact match.
> +	 */
> +	int_div_clk = fsl_samsung_hdmi_phy_find_pms(rate, &p, &m, &s);
> +	if (int_div_clk == rate) {
> +		dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: integer divider rate = %u\n",
> +				   int_div_clk);
> +
> +		fsl_samsung_hdmi_calculate_phy(&calculated_phy_pll_cfg, int_div_clk, p, m, s);
> +		phy->cur_cfg  = &calculated_phy_pll_cfg;
> +		return fsl_samsung_hdmi_phy_configure(phy, phy->cur_cfg);
> +	}
>  
> +	/*
> +	 * If neither the fractional divder nor the integer divder can find an exact value

                                     ^ divider              ^ divider

> +	 * fall back to using the fractional divider
> +	 */
> +use_fract_div:
> +	phy->cur_cfg = fract_div_phy;
> +	dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: using fractional divider rate = %u\n",
> +			   phy->cur_cfg->pixclk);
>  	return fsl_samsung_hdmi_phy_configure(phy, phy->cur_cfg);
>  }
>  

