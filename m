Return-Path: <linux-kernel+bounces-316500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E6D96D065
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 147B51F23380
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723F31925BE;
	Thu,  5 Sep 2024 07:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="bXIFBZ8+"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2101.outbound.protection.outlook.com [40.107.20.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A182A158D9C
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 07:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725521453; cv=fail; b=f5gpklgKH7wdTbbGaLgDyZ0Xs85CVaXHv58k5j5zFzXDR1vQRYmiFP1r9yRRcbXDkIlki9tkNjwbgqevfXJFsMMzm88joWZNOkleTGKybpSSmD451y7jv25HL/UzkVIVxCcrMdrvcEAS8FdQZVTMhqg+KZWEO2RvWeawmISIjsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725521453; c=relaxed/simple;
	bh=KDTlBvTwfJRwHVeyolyxLwMBroj8yOHu0xXXs4KJ/uQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IEd3aqfnF24p5duZH/HQtT378yOkd1iSbH1I8gKYUlaprkdeodXz9lb+x+B38l7H0A/WOQGcQgLZ1s1sPHnlHHeB1hjeSqC5HuXq+tnzewXAgJS7gM7DRPkFQjtAX2aJmLGRngehA+wH2SnFeFUeQ8ZEveabz9xXqIDjwk0toL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=bXIFBZ8+; arc=fail smtp.client-ip=40.107.20.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aByMcGP82ZuyZ4oto19an7xlxAPWx9pbTqTyObiFojqLa7h2egK0BbfnJxDsOaOB+7ciRHda5G8oLd4y0zMU43nVgzxCaYWCDbKYS2Z13bbH2AKJt0JSsS/EZRYUvyAPqQs5bEqthTPqN57umKRc/f007H/LPVwzwvLU6k7O4RaBaHqR8AUqAvHslEpFl47/BGf54X0GVzM/UN2dePE9rXoyMOTD3kGUIAR90jXnFTb1RbKIBn8kGFHUohQCOBC19W83miNztSDKKOPRJOvHg4Z3WnsLLpTFVjL2BJIWhpriE8BJQD7NG2FBrdJZec1NPm2eHup2m2JRUyEwQtAP7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOXmoK79o0rKFTm6Di3A445PTxd4v0mmpJSapXya+yQ=;
 b=w3UYv82P+CwKYCKYMQBn13w2oh1qiHgft2aUuWsx36s1StycVG54sN7qdGR/nZdzzdgP7T0JjtYQZKGTXHfh2fUCHBu4k3tNmaEqp6xYE+FN2B0GNJci2ZWL3gJ5F9Nox41XeTZRXp7UDbZCXg50sDWD/hfuxOgMpu2TIvEoq2Hkyyt56zOFpzYZHLENzZXhYu1u4sJ08BLBn2PKzfTm9Wak8p/G69F/hvNnHwzGLWF8w1dBVKNrvGEHa9/WLrBtIu9HFTzM5cbtV7ISAgu5WM01Z+DlLrRtqeMmn5ZhLZ3crYwvWkmR2UbfGpOj7UqDKqDjS5ppa9tN6yTpu6bDSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOXmoK79o0rKFTm6Di3A445PTxd4v0mmpJSapXya+yQ=;
 b=bXIFBZ8+mkO5KMar36T2SjaCnT6oTgDIo1wzP8yI0jgozVZe+VW0BokIlU0CGrmmZnpSvttn6S6SA5/Wdy1DAVY2sQPsU6goHGc6/IMCZCTkXNK9i1vz3hfr2MAwL0K8kqMgdnumSEbUalc4bZZ4QVGU6sInkBuAn4QE2LV8z7w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DU0PR10MB6679.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:401::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 07:30:46 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%7]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 07:30:46 +0000
Message-ID: <d99018f8-09a6-49eb-a054-e8605cb169ce@kontron.de>
Date: Thu, 5 Sep 2024 09:30:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 4/5] phy: freescale: fsl-samsung-hdmi: Use closest
 divider
To: Adam Ford <aford173@gmail.com>, linux-phy@lists.infradead.org
Cc: dominique.martinet@atmark-techno.com, linux-imx@nxp.com,
 festevam@gmail.com, aford@beaconembedded.com, Sandor.yu@nxp.com,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Marco Felsch <m.felsch@pengutronix.de>, Lucas Stach
 <l.stach@pengutronix.de>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
References: <20240904233100.114611-1-aford173@gmail.com>
 <20240904233100.114611-5-aford173@gmail.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20240904233100.114611-5-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0305.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::14) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DU0PR10MB6679:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ba92e6b-fe37-4e0b-41ad-08dccd7ca84a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1Q5dU9xVlg0cFlQTVJuT0ViZ0hIb2s3K3NCVGdnWVJseisxV09OZklFWVB5?=
 =?utf-8?B?RnNVaFpVVkhGU3ozVFNyUjg4UzlSTjdrUEJhdWNPbUVaSllGL2xNUmQvaXRF?=
 =?utf-8?B?cytLVHZPZ2krOG1XbnN6OHQrZ3k1MHljS0VwQ0MzOUVOSWt5TThFbnFBQzhB?=
 =?utf-8?B?czNkSHMxMStYbldnakpUYUtpM1JCQ0ZtQy9yOTVMSjBYVjdqcjkzOXVlbmlZ?=
 =?utf-8?B?RkRFTjFnd29zSUIvRDY3MXlKTmpxWE9TRHFRd3lzazdnZkZFSThOV3VaanlG?=
 =?utf-8?B?VEZES3k1NjhCcU81VXE0aTlIcUl4U0JlZzhFWUFIakExTUIrdmROSURpc1VJ?=
 =?utf-8?B?elo1TEgyV3kvZVNidXVGTkt1em95SVNsNFR6cFBqd3RRODRDVWJ0ZUpMSGVG?=
 =?utf-8?B?ZzJMWnhXeXZBQ2JTeU9ISHByWk5KQ2ovTDVwUjVOdk4rdEpkcFZtL01xRXkx?=
 =?utf-8?B?UGlRSDlkL1h5NXNxRndTdlRwOW9iZ3NlQ2pFQm1rYmJNVTkyRGFOVzFRRTgy?=
 =?utf-8?B?SmgvTHVVL202Ty9zWmZ0TjQyMTdoQkRSMjZmZ2FESS9lN3hYQUc1SUdtVk9N?=
 =?utf-8?B?S0ZyUy9hV0hiMm1mWnJMN2hyOTB0V1owK0hGcE50Ymx1Z3hiWDBTMFE3WHNn?=
 =?utf-8?B?ZjE1MXl4NFg0Rm42QnlmK3ZXYld6bitqYi9VTnMxNmpCQnVqN1FsUmlIcFF4?=
 =?utf-8?B?dlRUdStIRjJXS0RieXJtek9iYkc3TW5iUWpjZHkwem8vdlYrSXJpTWlZSWU0?=
 =?utf-8?B?R1hKejNNaFE5YXU4OTJKaXN0amVrR095Y1l6MG5lSzdhUW40Uyt3NC9SYmxv?=
 =?utf-8?B?a1hXcDc4Uk50WHdmNWFGdVBDMy9yNmZpaWx4L1puajc3TlN0OVFETmsvNEt3?=
 =?utf-8?B?UVlqb3JVL2hMckxDQUFBQzRtTk1WRFZCTmc2TERaaVFoTU8xaFB0YVl1S3px?=
 =?utf-8?B?OFNlcUZ3Ti9hdE05MUhhOEcxc2xRMWZ2blRZUUhMc0tsYU5lZmJkWVN2WXlt?=
 =?utf-8?B?Zm1RYkNTT1RCV0luN3VhKzZRTjkrNmRNN28rdkdNc1RvbCt6NjIwR0puMW1o?=
 =?utf-8?B?czRnOHlDWkFVTUVzUnpSMlhwTG9MNnJDanhMcGRhb3pkUElZbERHeEVVMlF3?=
 =?utf-8?B?WWdBUFBDeUs5dXpzdTNjVEZqRDY0R2tyNThyK2NPMi9mbTZ5bWtOZHVPZHBt?=
 =?utf-8?B?bDhEWThHOHdhTmpPeFRXUWtjMnN0bkZobk1YRGE3L1hZcGRuV1RwQm9lM1Q5?=
 =?utf-8?B?cDIwWnlkRlB1OWJ4Wjl0Nm9YNU5LT1FURlVkMWpWU0lka0lKNlVzTWFQdDVU?=
 =?utf-8?B?cjdTSXJPSlpFcTMrd0s4QUFMMVcwZGVsVGVPMFdKUHZNMWpQOHJ3RStic25G?=
 =?utf-8?B?RXUxK2NiZVYzTmtSOXVaNWg5UWM5Q1l2bllWRHhxc3J1eTNyV016Y2tjQkpR?=
 =?utf-8?B?UGx6NFVHWTdiSUxxNXdqa2F1U01hNWhPaGFXWjFQYkpqTVFWS2pkSmFCM2Ur?=
 =?utf-8?B?Rjh5Q3dPbm9YOTNoVXR3Wk01dHpWVzNOeGxYczNPaGcrZUd1T3ZqMVpwTTNz?=
 =?utf-8?B?ZGJHcjFGNklIMjVaKzQ1MFB3MVVyWEUrWVlrMFJXbGpUakxuS2dJYVQ1K1dG?=
 =?utf-8?B?WEMvMVJRdmZnUHpHcWpQL1A3TGNsL1J5emhiOEtNM0dHY0ltUFFzVnU3aUs1?=
 =?utf-8?B?MEJxTTczVE9hOVNYU0lLYnJ6QjhTTW5mZFRYNEdSRTNKakgrVWJDMmpOUU1C?=
 =?utf-8?B?OXlYK2VDMzlRTy9CZ2lhMFdVeE9XNzArL09uQTR1RFJLL3dpZWxXSVYvQy9K?=
 =?utf-8?B?UHphUkdIdTZvZWdGWElOZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y21VUW96cGxRNlord1JaRDNTYVJualJWK0orbDAxWWJidlg1TEtYT2RBa05V?=
 =?utf-8?B?cVAzdHpxckZiWCtHWHFCa1RPYnBtTFplL3FKeXlIYmNnVGpsSld1c0E1WjYw?=
 =?utf-8?B?azBiVlNkK2NFQnZsZjRzZStGUHE5YjJQemtWdHp4QWcxTjdwVUZuMmthTDZK?=
 =?utf-8?B?WUhCTjBNdjZkc0NEcWRycFNOTGhiejA3T2h6SCtXM3Z4ekNua1JEMWRlRTdj?=
 =?utf-8?B?V0FXWEJ5MUtWdU9lSDdTblpZdDJzenoyMTQ1U3hQdXBvTURqZkRpSE44VStE?=
 =?utf-8?B?RnBMY3F5aTA3QTl6WDlXaWVtL2c4ZnBnRUlyWWR4cVBidlV0N0xkdkRGSDFC?=
 =?utf-8?B?aXY2SU1SNUhlOVBZNGdGOVpPT1NPV1F1U3pXaVhra041SnVNRHkvY3hic0xh?=
 =?utf-8?B?RXQ5aWZpdEt2eE1yWFJTT3pZQlZlcmR2bXhnRHN0L2llWDYzbFo5S1J5UVln?=
 =?utf-8?B?aWxtVmllWmpqNEFxTzZHdHM4M00yd0FaUDMvYXB6azIrdHNrRkNPajZzSmpn?=
 =?utf-8?B?WTZoTmR3MVJRaXhTTDh3Q1NRdFN1QnN0WXdnbEpyNXFFRVMwTlhpMWJWNzBX?=
 =?utf-8?B?Unpha2xhNFk0SVRiZUZ6cjNzVlpqRE9ydTN5V1JUMlVKZ2swa1dqOExEc2F4?=
 =?utf-8?B?SVhGSWw3ZmtkZENzdWZBYUtGelppTlJBMkZmTVJyRjBZWjNmeU9RRzY5L2o5?=
 =?utf-8?B?WG95Vk03ay9zaWl0NmV5aXpLdlloakhBTlVra21CMGpTUmcvWTNjdDJ0ZmJY?=
 =?utf-8?B?S0daZ2RJUStzMWg2YWNvZW1wYXoxaE5RZGVYVFl0Wmt3SUNjMkVGZVpaWWVH?=
 =?utf-8?B?aEpEbC92NkhtYWxiOXRjTUpyUVpFaVV5RzFPc2c4dDlqRHNzbE9JK0hreXRi?=
 =?utf-8?B?dUlYZ0M2RUlLUTdYVXBmZnFEdHUrQlloM2wyZGdwRlF2bkFEcFFEdC9iekxl?=
 =?utf-8?B?TXBUcDJZWlVNMWNuZmd0TWdiYzRKOHlQWkl6UW5iMmhGRlBxVmNIQUFiQU8x?=
 =?utf-8?B?NzRWZU1ka1V2SCtBbzQ5L0s2YkpWdVhZNFRsQnNSYWRnUGhvbC82Ym11MUVj?=
 =?utf-8?B?WEZTRnJIb3RNdFpEQ3lJVmt6UDlDK0V3emZaMWtEYnVSd3NMSDNTeEJsM0x2?=
 =?utf-8?B?WmJlN3F3UTZ0ZVhCMzVMRStYcUUxOGhTQzRmVFQ1bkxTMVNOenRCbmp2aWx4?=
 =?utf-8?B?YXE5VmRQcU5kUTYzYmx3OGJyZEUzZzAyQk0yTFN5VkwrZHFGcVg3ekprUFYx?=
 =?utf-8?B?NHFYaE5HOXI2SmJiZFpSeGdoc2JpbGFOdk1QdkZTcFpzNkZPRmRnTEt4ZThZ?=
 =?utf-8?B?NVlQeHh3U3JsbWtBK2tZZ0FxVVluQU9ud2RjVGRzTkxNendIbHJNTHh5V2dw?=
 =?utf-8?B?TU1LQ0xDRXh2LzBSZFNvb2k2Rklna2ZqQW1GYngxeTN5VDZHVEwyTkRTTjFp?=
 =?utf-8?B?S0hVdHVhbWdVR3pXUzJBeWhhc1ErejU2djdza0VtMnRqTEtCd080T0EzcEY2?=
 =?utf-8?B?aDBWSy8zQVBHTFZ6elVHQjhCMTJqUDFMTnJsVjRZdUljZXdhQ0VONEFCWDBY?=
 =?utf-8?B?ZFMxcEkyRVFveStKUU5yeC84QzBIaXBJYTZVekxKanJXZkxQbHZIaC8yWG4w?=
 =?utf-8?B?YzEzaWl0MlBXMlhjeFNwcXcvaEFGWk5CYlRqNXIzNFlGSWZwU3ZjL255QlRU?=
 =?utf-8?B?bDNES3RRbVpmL3Z2bDl3ZFRMN0swMG5LRFRzbnZReVllUTFwZ3I1OUhYQlFG?=
 =?utf-8?B?bU9EVWlJckFwNmJuTXNXNEdLTnFseVRoS1hRWkYyTjJjU0hlNE8yeTBqeitI?=
 =?utf-8?B?cDUxMGRYTS9icmZPdVJYUEZZaXp0M3lpbm82d1NnQXQ5aXhMbGdIR0NLUXhF?=
 =?utf-8?B?V0JQVml5ZFNZVlBJV2dOOGtNSnFyczZHT3RSYXQ3V21JMlp6QmdNSFdQNGhS?=
 =?utf-8?B?cUpLOEpsTW5qb250NGl0N2JDSWsxQ1Z3RnovV2kxOGh6U2pZaVFDMnlyOWVM?=
 =?utf-8?B?ZCs0aDFTZUVpLzhVbVBsdGxuUGY0QzdObklvL0dHNi9xMW9pYUVidUlyUWc0?=
 =?utf-8?B?bGFuVGFzU1BpSXZpRU04VVZ2VHNJdm1hUWdUcmc1Z0VERkVQZGQxNGI2dU8r?=
 =?utf-8?B?QmZGT0N5QmV5aEYrUHU3anB6ZGNveTQvTFZIRXhWT1hjdFd0Q0RvOW1ra1hr?=
 =?utf-8?B?cnc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba92e6b-fe37-4e0b-41ad-08dccd7ca84a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 07:30:46.4248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iqbmFxy2kIh9Vz9kv2nO9bOXmXWNeoHZlQZUUIaGlXCaqZknmXXB9PswCMi+zGuzwnZW2Hh8tFY1teWY6nz9p/2wxvPN2DZ2SNpS2Kv1Qdo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6679

On 05.09.24 1:30 AM, Adam Ford wrote:
> Currently, if the clock values cannot be set to the exact rate,
> the round_rate and set_rate functions use the closest value found in
> the look-up-table.  In preparation of removing values from the LUT
> that can be calculated evenly with the integer calculator, it's
> necessary to ensure to check both the look-up-table and the integer
> divider clock values to get the closest values to the requested
> value.  It does this by measuring the difference between the
> requested clock value and the closest value in both integer divider
> calucator and the fractional clock look-up-table.
> 
> Which ever has the smallest difference between them is returned as
> the cloesest rate.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>

