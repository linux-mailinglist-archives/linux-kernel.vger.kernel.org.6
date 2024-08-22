Return-Path: <linux-kernel+bounces-296414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B638995AABC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 03:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29C00B21258
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 01:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648BA134A0;
	Thu, 22 Aug 2024 01:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Y8emiA/t"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2061.outbound.protection.outlook.com [40.107.215.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FB279F2
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 01:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724291697; cv=fail; b=sm5Fd+ZfTo2K09f+uHKzL/U3dq+czIR3l9PpW214fbhtmAeOIvsZgaTST06yrvnFA5+P1RPfo8/4ucvbt8mOcmlysnv5vM5gF5yv+U3p+lZ+8yUSkgCXZXGsZwRyW9B1wPbSai1rdcQCatWCVk/1u+bp9YTdVNxXLTd8WKbPbxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724291697; c=relaxed/simple;
	bh=wwf9Jx0pHtDDfAUih54M6dIneaLZ4QUkKrQod9BbYnc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DCcnqucWcCMZujaJh0S8Zi6fewD14WcEgJN167erz9VFAXnMtVxhTKeg7D6SCHPCGBSTmPnVpk2uGrC2VAFf91RZfR04eb/QReQ32Kk+U5sEffl+GWY7b6PMxj6a6g2FeZ7BiRchTtGQ5h08pF/hmLfV2jfd5/5wCPx84tqNl7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Y8emiA/t; arc=fail smtp.client-ip=40.107.215.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFEtT5p2HiZ02kEyslFSVAmE4yU27trvdaOZskaoHFB1kJCln5/UxjILn5t9KcfHy4XbfX3eaCnOaajXAI6FWzilTXNhKjfzlbOP+O7XcfVXykaML2BObDg5o2p6jAyOEZ7yM9g6Ikbo0xgji9AXehCir0Lhth/c3x5LzzOMIHGxkk95rWxfAymMCAIrXHPJHkJSeX7O4ii28MzQ9OAjDDl8I3XLx+acaghGo5Ho+lwaxwhs2yiUKEu8IJ2W9wmel9QYsfbIGgy5lMPjQMcR/Z6LnWxqveKzF8AMa7DLIRBCXt+RcR11T70Mb+rPJNE9Q2HEwMgcLVyhx2S1NXQtag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqUC7T6wJfStTFlaPXJjHhp2HnwcpZCvmOEm4xzgkJI=;
 b=hHGcC9Au1vVmgrVr2i2b+d5LMpHsJ5WoFIYvpMRSkTNVvxg6bfd2kyPVnXnS85hBsmB36l02fdPR2yXBo712JKfkVLnUNyhRU0UyR6BvUvjMtpSR9U1+AT0NuNrE4aKNkQvBKH0XwO2KUP/YD5IBzQ8IqOQADNes5cYmrECtn7UMg51Gd+fhYpWZipdLrJc2iXLAKvP0iMk+dqx1qBzefEJojQFpEbDTGIrcBP05VJ5BxabozP0O7Y8dgk0X8dwyg/fexH2j/89V6zWx9nVLXKUccWbeFhu6LShBFAHuOjPdmGM92Ha2/mvkaQSY4IyceFfenbwF8r1ELpSOCXsoRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqUC7T6wJfStTFlaPXJjHhp2HnwcpZCvmOEm4xzgkJI=;
 b=Y8emiA/tPcInLgNyePaSFhMMjhaCuvAHujeZTOAes8DySjTuzq3XbqOw6S+gyMpJPAtVrfz3oQPQ1faLf8z3WMwQKthjLBqpKZ309ZKys8Pxcj0XiTxVF268oV0AzDXtSZ4BBqFTL4Ok8jfwF/cXDK9eMpOWdZYQxY/ySgMs5JcYlNn02VxAcEX6ftD3FTb352mHKGO/+M9vvYJBGOh/ESRf2vTApRBbGJXlCnQbBiVB1jKWaRrTdGJRIGXtIkbSJhvnynQTEU5RO1Abgo2XjKA2NWPi8Z5AQIJKwy9ILreDmpgO4a38Rew1DgqbbciT5dDyb1RvfqDFEyGv0CLcmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TYZPR06MB6353.apcprd06.prod.outlook.com (2603:1096:400:429::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 01:54:50 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%5]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 01:54:49 +0000
Message-ID: <ed07b2cb-ed84-4f5b-bfff-e06b8f7ae967@vivo.com>
Date: Thu, 22 Aug 2024 09:54:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mailbox: sprd: Use devm_clk_get_enabled() helpers
To: Jassi Brar <jassisinghbrar@gmail.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com
References: <20240821013901.787555-1-link@vivo.com>
 <8f577565-69b7-4da0-a7fe-2e94bf37948c@wanadoo.fr>
 <b8e9e59c-6486-478a-bd25-ee13cbcc46cc@vivo.com>
 <75478278-1f18-4865-9dbf-c929417e1637@wanadoo.fr>
 <CABb+yY3drhueGsmBt_JF+ev0rw0J1xkb0xZ5jS3qynOYra_wVw@mail.gmail.com>
From: Huan Yang <link@vivo.com>
In-Reply-To: <CABb+yY3drhueGsmBt_JF+ev0rw0J1xkb0xZ5jS3qynOYra_wVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::11) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|TYZPR06MB6353:EE_
X-MS-Office365-Filtering-Correlation-Id: b22cd1fc-e74b-4001-52d2-08dcc24d6812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QncrM1lHRWlnMlpMdzRFT3BZaTJuTFY0R3dIUFQ5aDM1ODZ1WHpRV3YwL0t3?=
 =?utf-8?B?Q1B3bC8xSjBmOEhsdHFYdmNtUGxOQVBJYnZSQytmMTdiVkNTTGVoZnFLbXFo?=
 =?utf-8?B?RFdNbGdBQXVGNU9hd1FLZnRHMVN5NGN3YWxRTWEwWHZsVVJhVmllcENuSnNm?=
 =?utf-8?B?cXY5YVVsb3c3cS9SVUNJZzhaV1JqcWp4UC84bE44UDRlK0FNdHptbk0zRGM2?=
 =?utf-8?B?aDVydkhvdlBQQml3ZDZBUjIwd2k3amFCU0wzb3N5Z1JuVEVRVFVpaUYzWVNR?=
 =?utf-8?B?cCt2M1ZNa0krS0RCalUxZ3NqNG9QUXJNcFE2MGM4RUtCY290d29pVDlUVEQ3?=
 =?utf-8?B?Q2FhWmo5NTJhSVpKSjY5SnRtcmsvYnlnQmRCc3VQQkdZdUtlazA5MFdleEp1?=
 =?utf-8?B?ZS9OVjlvU20xNzJ2d3hMQ0dybndZd3dKZkFoUVFlb05oK2lRZmsxVDJyVU4w?=
 =?utf-8?B?SEU0bkxyVVNrTVBYa1I2dUl1U09PVEpQTFREbCtyc0R2c21pbmhaTjcrTzFy?=
 =?utf-8?B?VjhTRCt3elNxVnVzMkdyL3lXTUlkaGM5OEQ1K2lUTXpCTFpKNjJEMnU0SUdr?=
 =?utf-8?B?K3h3clBTZnZ4Ym9EZEo3dGZYTFJEa0pTclQ4MkFVY01GZFhLc0k0SkkySTJj?=
 =?utf-8?B?YWhkRjFNcjl3YUlQak5ERGxhMm5Ya21nK2J6WHg3cEtTVmZLZDN6b2x3Z0Nq?=
 =?utf-8?B?SDJRZTd0V0w5SkFCenRrNnNZWTYwNGRMWXpFcVpzWTJLMGErUkxkdTVEUTBY?=
 =?utf-8?B?NDcwbGVlV0hyb290T0VUVVQ2MGpod0FITTFyTEVaaSs4Yk9zc1gxYWNSOWlo?=
 =?utf-8?B?RCthZVFXeldXb25ZREFkR0YrdHBtQ0ZmeVBxK0JWUVNsL2dBVDQ4WDR2NkdT?=
 =?utf-8?B?a1V2NkxqQ3l6S2NyYXRBQzBsNnVISHM0UnlGOHFFN2JFZFFiWlJiNkllMUpU?=
 =?utf-8?B?aENXVXYvSTR6eE9CcXgySmZSRjJPVGt3azVickRUR21CRENnOU9RZk51L1Vt?=
 =?utf-8?B?REpnazNzcXNybE9TMEtySzREM2U2UkZ4NktHTVNNUldVYkJDRDlMVURGWlgz?=
 =?utf-8?B?QTM0YzNTZVZPMVprWUh2clAzMFNQcktoSllndHhoZlhYTnZrYVNkOURRVDZj?=
 =?utf-8?B?QU40RkFodkRHQmhya0l1di9HVmpWZWhLZXNEbUZLZXY0a2VraGIvc2t1dDVE?=
 =?utf-8?B?SjZ4TXhUSldCOUdCR0JheU92dGlkRkN0UWlOTzg4YzdZR1lVakliY1RpVEdG?=
 =?utf-8?B?QjNIZ0tRY0Q0cmN2aUFxSkgvTkEvQ0Y3K2xHNHppZWpZRllpY2cxa001eVgx?=
 =?utf-8?B?a0lkZ0tQVHdoRW5HSkdIV0RHUHA3QWx1bXBkZHpTTlZyK0dscHNiVnZQNUxs?=
 =?utf-8?B?VlFDbDJhZTB2M0pLUVRKY1VTQVMxSnp6bi9zU1VaRGFqYytaek1NbXk4eEFC?=
 =?utf-8?B?NW56Q05waG45S252ZEpsUGpBWjB3STdtVEtjQ0txNTVXeFpRVjdITzVMRmZl?=
 =?utf-8?B?WHdBWFo4QkZsUDZLMThDcEEvV2V2QXdPWjREUmtwWWp5Y091UHBpK203UFZG?=
 =?utf-8?B?ZGFsdmxhU3ZLYWRMQnViYUVJVGJ3R0tpc1czMUVHQ0c3MG5KS1h1SEpqc1RO?=
 =?utf-8?B?ekRudTdZNzdtcXNBUlNJaU9CSlVSQ3dNVDB2cWFJVXRQTU1icmdiSDluMUdo?=
 =?utf-8?B?cmFLZ0liU2lkbzNzV3RsalFCeGFEL1BmbnNzdC9KYWhBWm9DdXhCRHl0S2Zo?=
 =?utf-8?B?aTJ5UzVKTXU1dndBN0w2M1d1T1FRR2RNZjNCbHlwV0ZFZGNobEZTZWtyK0I1?=
 =?utf-8?B?MnU2ZnJFYUdHQ1NXUUJZSjIxYk5FSDlwTnNQL3R4N2lVOFBpcWh1Vk54bHRX?=
 =?utf-8?B?cWNSYzdnWlVndUsrejF2RVlxVG5iZ2VSc0s2WElOYW14M3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnJFN3BEc0ZMT1lqbThLeGNHKy9yOXJWdEoxbmhlZGdXMzd5OUc1UUtHaStP?=
 =?utf-8?B?T0ZsRXlVbEw4ZFduM1YwQi83NVUwV3F0QUZYYzFnajFKamVIYlhSV3UybHg4?=
 =?utf-8?B?a1dQVGRjRUZXdlFuNDRzcjlILzM3S3k1LytNRGxFK05jakFVZlAzZmtwNndo?=
 =?utf-8?B?UmdwSGFzTVExdzBRUkZlNkNNSmdxRGFENTcyZHNTaldLS0FCZkozVmROalJx?=
 =?utf-8?B?T1V6Y1F6aW8xWDJqRUhjaFU0NFNhcHhvRnNobjNiWTZmS2FVanp3R25ZTEc4?=
 =?utf-8?B?c1hKRm9sQ1BPSE5CeDVFUm80dGQ0SVMweHdGZGRKSHZMS2wrT2JacGlrYldJ?=
 =?utf-8?B?cGx6TVBESDFZRDFWdzhPNEFHVnVxbmVDTWwvTHUwQ3ZldnR0UUJIN1U0MUVM?=
 =?utf-8?B?N0tNa0VjckZXYkUrQ1lrRHZzMlhaVzJBaVY2cndjN1d6eFZLcmxLbUZ4NG1s?=
 =?utf-8?B?MU9EdXcvWCsrcG1VV0JXbXBJOGQzdGdsMksyZCt1RFhEN2ltR1Q2RWJOQzRZ?=
 =?utf-8?B?VEora3N2Q1ZKTDV5ZkRGczBIVWRuNEh3c3Z5TytDTTdXVGRpSW1UVnBDaDBQ?=
 =?utf-8?B?aDMrT2M4a3pSSmhLeFF5MWQweHpSTGsxRCtTelFyaXJvanRKN3BpNWdKVXM4?=
 =?utf-8?B?VjNIQ1N4Tnlnckx4TzE3RjVqS3J0cHFaeTU3bGZaaUVZbllaQzRWV1FpZjh2?=
 =?utf-8?B?TjEzRmM4TFh4TVB2MXFlYmlEWmw4RXpkQzNmR2NBSEtNNktzWTBHZ3lEVXdP?=
 =?utf-8?B?dUovbEIwQ2ZvOEpGYzBHT01wallmamkreHdha0RUNmZJZmdZdU04WVYwbTB1?=
 =?utf-8?B?eFIxMUl0QmZBaUdzcGt4QTlyQUJCVFJqQnQwWUtzWS9xdHRQdGlEaWxyUHVk?=
 =?utf-8?B?Si9Ebk1leW1UM0tncUVmdEdWK1h2aXlrNmVKUmhyMjlVNHU1TFpOUUw4VlRv?=
 =?utf-8?B?RmhWWEhtRnFHaUFEeFRWK1dJaTAvb3h4SDFRRTRONjV5ZFA3K3ZQazRXOFZ6?=
 =?utf-8?B?VHlZc29hRHlOT1FibFI5R044OGlKMjRsVjJXR3dUYlJjNVJQbUd2VkxsYnh5?=
 =?utf-8?B?YXNjSkJpNDZOMXVTT0pXT0tSQzJnQ0NjUDdydjduSHJ3YXRrTEVjbHp5aldT?=
 =?utf-8?B?QnNsblRDYlJTL2t5SkhuUW1DeThWdWdON1BTQ2ZYZnVHcFo5MVp0RjZ0TFYx?=
 =?utf-8?B?eHI4NjJNZVZJVUNFSXNoNVJMNElSMmNFTElNeGVwZlRadUpMMUMyUldoajRl?=
 =?utf-8?B?RWc0Sjk3MlNFeHdrVkg5S0swWDlhZTJFSGlITk1tMm1tSFVSelpTQVd0YWdy?=
 =?utf-8?B?eVhsRGcxYlVJTnNyV0RPSnc1YnNudzJhMFF5SWYrQ2hobzN4OUFvT1pkZS9P?=
 =?utf-8?B?UEpVeUZMWW5Yc29mVThyRFJoUG9tVldrRm13cTB4Qkpmd3NYS0VMMVNZVlhH?=
 =?utf-8?B?WUhKZUJyb3ZUL1E4OGJ5QXQ0di9DZzZCblBNSldXc255YVBKUEJtZTViVE5D?=
 =?utf-8?B?cDBPZ0pEUTFaaTlxR0JHOUZobjVCTWxabno2aVdmcU16QXVUQ0ZGL3VzNVIv?=
 =?utf-8?B?ZjVHNS9sMEZPeHZPejFzTURvaWhSM25IRm9zVm5YdTJCL2lNZmU2U1ovbkdo?=
 =?utf-8?B?UHU2NGc2N2ZBaHdCcFJzRjFoMURzL2NaQmdTS2FoS0QxL3orSFd3WU5LVzVp?=
 =?utf-8?B?bVNqa3NHaTBVd1dQTFFuRngyYTVVbHdNc2I4Q08yMitPcjBHYm8yS0M1azAz?=
 =?utf-8?B?eVgxNzduR2xWL08wZ2ZCS0VwVjdKMXFPL3I3MjVBSzhHMUx1VmZYc3pjQlZr?=
 =?utf-8?B?UERvaktobXNoNzNuVDVYTlo1azJPVzZqcU5RNHNPeERvT2p5Sk90U3o0a21p?=
 =?utf-8?B?SlluZ3RjYUVCdmxMcUFKY2JuakdvMU9hZnFpdEUxYkpQMnh6Z0ZjSVJjaGVT?=
 =?utf-8?B?bjVPc2UwQUhpR2JKaWJxZVoveXkvMWIwV2VvZmIwclBscEgvcnRsSkdMTzEy?=
 =?utf-8?B?SjN5VEs2Mm5FSmcwZFY2aGN6Vjl4TFRqWmFmdGtDN3d0bWJhd3lxamNKNmhy?=
 =?utf-8?B?cEQ0ZGxZcDdGOGFRUllaZldaYTg5OWNvRHdyNDJ2eWNzVW5YVHBub1g1RTNj?=
 =?utf-8?Q?Rb/farEDKy7zXGdme/JQuRLxB?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b22cd1fc-e74b-4001-52d2-08dcc24d6812
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 01:54:49.6918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0UrOAIHpOxuACIEWK0hFH3XhxYd6u54LX6UtQMa1kamw2G0S1nXsEYbrVzg/Wp/Il/zreuotQvyFzPsE7Dv+HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6353


在 2024/8/21 22:45, Jassi Brar 写道:
> On Wed, Aug 21, 2024 at 5:09 AM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
>> Le 21/08/2024 à 09:08, Huan Yang a écrit :
>>> 在 2024/8/21 15:00, Christophe JAILLET 写道:
>>>> Le 21/08/2024 à 03:39, Huan Yang a écrit :
>>>>> The devm_clk_get_enabled() helpers:
>>>>>        - call devm_clk_get()
>>>>>        - call clk_prepare_enable() and register what is needed in
>>>>> order to
>>>>>         call clk_disable_unprepare() when needed, as a managed resource.
>>>>>
>>>>> This simplifies the code and avoids the calls to
>>>>> clk_disable_unprepare().
>>>>>
>>>>> Due to clk only used in probe, not in suspend\resume, this pointer can
>>>>> remove from sprd_mbox_priv to save a little memory.
>>>>>
>>>>> Signed-off-by: Huan Yang <link@vivo.com>
>>>>> Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>>>
>>>> Nitpick: no need to add this S-b. I just made a comment when looking
>>>> at your patch in order to improve it. I'm not the one that suggested
>>>> the initial change. All merit is yours.
>>> Your suggestion is helpfull, help this patch be better.
>>>> Also, I think that, if used, it should be above your Signed-off.
>>> Hmmm, it's neccessary? If so, I'd like to update it.
>> I don't think it is useful and personally I would remove it, but you can
>> keep it if it makes sense to you.
>>
> I think   Reviewed-by  is appropriate.
OK, I'll update it
>
> cheers!

