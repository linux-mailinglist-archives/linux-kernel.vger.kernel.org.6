Return-Path: <linux-kernel+bounces-307429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E301C964D7E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60E4E1F2388A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE161B81B1;
	Thu, 29 Aug 2024 18:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="amHRDCRT"
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021096.outbound.protection.outlook.com [40.107.192.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703B714B086;
	Thu, 29 Aug 2024 18:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724955152; cv=fail; b=MRpcKy6CK8/vS2X+30CftaFIcIUMnwFO+FY3ag/7mlIyKh8rRd6KVnOrqkAZimb7IBE66HfKavbwVq/pzq8zmgsPjUmMzpGqLJRGRrECJfo2Ka/0hlYzMBbxKv5Iib89XGWvY9PluJ1Bn+kYCTdq2uIAFUD3JHmzd4tvCWW54yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724955152; c=relaxed/simple;
	bh=dWfYndByRiI7ysJqkCVX49+sij5RgNQwDzwkxhegtX4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C1p9errX5hYiVWuBZs/3Xua1HtOo2xExmI9a/CELtyexgoi00TmVluOkU3GhIAFY3FxrMvru3h95Fe+3QVE8+S1iYN+hGPG4NXYWsFQDuNbNFIVzS3LWhimKLrY/CoQXOyYKJuZs+PeKOmFIotJhUmRZeF2vFDzjezfw6Yyenl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=amHRDCRT; arc=fail smtp.client-ip=40.107.192.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VIKELYmAdFVYVFtlr3VmBi3uoA3QRd8ZCx7PQnRrFmjlanb9N15ilGzrUC5lFS1NYJ3gYpnagoS6bv/Q1e/Uc8q3qD50wwOTJAH08CKxoKmLhFFa4nygq6XnWVfpXLNnY8yqFkK3qsttcjsDdKmkHwJBqJhW2i587/cupZ5Fkw1Fj8hsG1jyGck56GrdOVpQCmCCEq/7d66X328N+OT0qLlny37YqjGVJpMzN5ld+YfAaL+3EkdV/+XzhY/ZHO2HWV+xBXACF3Iw073aISFae6pluji9omqu8jLc++lNOQLS9Qo67sXw6bLvJPLfkxxfCEvQDtlvaZ6di4jPDpLlew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIx+pe/kb1tellk/dnbZnqX6JCX2l4Kf+9EnAd4hf8Y=;
 b=TFEfrqOdpVLkyJH1xmJ5h9JsDAr5GvFjqCEBpWmoq3xnl42x2wKBgk2b0cAAHLXoXIfIs9Okhzt8eCz/4XnlP9r6zHmoU4udlDa9IraG2COfOld86xG+CEkuSeTx8+Z0ujduhsXQLuTV6/nv06zFuC/TjCpJWDVDR6Vyc+KH2WO1MVqPSj09dFTFq1Ye70F+rzf5IT+bhWzL8QqProBaNUKNzFmNLZumP5Vn+qZ8bSXamDefZzU/Ms3ffXu3U0TALwFfo37vcs289Rp60MGsRbVIQTXRlm3JT7KOjtGJk+JRl7BBvWxnz6OPcs7+6+RiB2UihwQ3qqRLnnpmwOMVsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIx+pe/kb1tellk/dnbZnqX6JCX2l4Kf+9EnAd4hf8Y=;
 b=amHRDCRTExwQlFv3DA0tp8lzYkbIvgMiZoYvVp3leg5YKEjlyH4BVdX2RleKchGWx5XP9nZpQjLI/vxUHiCrTzhBG0998/7jV7ydbjGLRBokgRjc5RhEDFBBSAi5/r/dAR+FDVI+dZALe7CFRjDTeV/MKqHpBVCPQl/U6Gdnf2ASayu9T8OFDCOt6Dpe0AG21lDxQwzC4pdvDAoTKdAC5fj9YWGo7x98gGUf78V4fvl7XtEKwSRPDwCpa79euyPbqhS3kk90oF/Put4WIucog1BEFLcqkN7UVp0RrH9ElksPOsVXhioqo8TWIJuLw8j0P5HuijUrumZJwxhg1T+K4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:24::5)
 by YT4PR01MB9942.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.33; Thu, 29 Aug
 2024 18:12:25 +0000
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::be09:e1b:b343:7f9]) by YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::be09:e1b:b343:7f9%4]) with mapi id 15.20.7918.019; Thu, 29 Aug 2024
 18:12:25 +0000
Message-ID: <b3511709-146e-45a8-84c4-cd7c5b0fba6b@efficios.com>
Date: Thu, 29 Aug 2024 14:12:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] clk: starfive: jh7110-sys: Add notifier for PLL0
 clock
To: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Hal Feng <hal.feng@starfivetech.com>, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org
References: <20240826080430.179788-1-xingyu.wu@starfivetech.com>
 <20240826080430.179788-2-xingyu.wu@starfivetech.com>
From: Michael Jeanson <mjeanson@efficios.com>
Content-Language: en-CA
In-Reply-To: <20240826080430.179788-2-xingyu.wu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::35) To YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:24::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB5080:EE_|YT4PR01MB9942:EE_
X-MS-Office365-Filtering-Correlation-Id: c3e39663-7eb3-484e-2ce9-08dcc856225e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlJ3d1lHT1ZiRGVBY1AxVmlkUlZJdUZMNnhBOU8wblhWQWhiVmhYaVZvNUZz?=
 =?utf-8?B?YnhKZUFFdU8zcHhOMjhGMWMyb0ZwL0o4YmQ0cCtmcDFpUDNkdXFLYlNtdmRI?=
 =?utf-8?B?SlZEcDJHSGdHWkZQMTR4NDgvSFkyMW9ERFFhTnlyeXBnbE11cCtiZWVMVUpG?=
 =?utf-8?B?bDBwOEQwd3UyTVQwVGRSb0JxRFhEUzR6bllhZUpFZDZ4MVVoUjRCNWVNeFNP?=
 =?utf-8?B?YXBZM2t2ckUxbDI3U21PS1BjcmtGRFNYdWwvTEtTQ3JjWFVmQW03a0tVUjhJ?=
 =?utf-8?B?NmhIb3c3MWQyMDBnMmFrZksrNDlLbXU4aTlMRUhmWkhWNU9GOCsvOTUyL3hN?=
 =?utf-8?B?czM3bnN3MjRpY3czRlJyaGpMNlNER0F0NWJDdTdJenRFdHRFWHZsRG1GTlkr?=
 =?utf-8?B?Z0x3bFk0WWwzWVFzLytzcGZ0UFBSM1JyazgrSUNQVmVtU0tHMnJUaGN3d1pT?=
 =?utf-8?B?Q1l4SVdPZ3hOWlBQOXhHRFlNMGs3SXRzUE9GZjNpNGhIWFJhZUFnYkRFS09R?=
 =?utf-8?B?eXpyb1hmaFZDeDVORjdzUGVwMnlzVXorMzBGV3FSbEdQQlI5V0ROV2FudldZ?=
 =?utf-8?B?T3d1eDNuVnlRaDdjdzZ2M0NxRzVtOWtSTWhYQnFGN1JPOGNxMGVVcks5TXlG?=
 =?utf-8?B?ZW4wc3NjUUZaT0F4UzE0NzBYdTVkOFdTRWp2ZmJzMDRqbUdJQ2F0aGdRSkpF?=
 =?utf-8?B?Q1A4ZkNJTmFMYUV4T0FqZ0hJa29sVjFkV04xaVMzYnhIZmRwZTF6MkZBWU13?=
 =?utf-8?B?N0dBL2JvVXRUUExoMGZ4KzBFL01JRkMxOStPRVFXdjVKYkdVVXpXS1J2UCsr?=
 =?utf-8?B?MlJINnNsL2VQSmJYcE16YWE3VFM4T05rdXNJZnJTTDlxQkk0cEhsQm5RTFdQ?=
 =?utf-8?B?VXVVS3AzQ1d2cEdnZGxmMUpwRVBueTI3QUt1VTMvZkJFUG5ScHRyVHoxV043?=
 =?utf-8?B?MWpHb05XemxnUlZqaTMwZHlabFpZNGtuU0pGT1JBc3F3U1o0VUdmT1RwSEx0?=
 =?utf-8?B?UzcrYWNBWGoxVFhreDZqQUdXMUFoOVY0Wi9hVzJBaEt2YlJLNTgrblcxcFdK?=
 =?utf-8?B?NG5aVUtVTmVId213bklHbUZIcmFDYlVCY0trNUR1QUtCR25qekpLczhkNVJt?=
 =?utf-8?B?U3NQNlQ0ODBJSi93aDN1ZTQzRytqMDB3aGpvUFo2a1lhL1JBbnZiM25zbzVC?=
 =?utf-8?B?TzdqUGw3SnJ2a3p2VHg1NmZQT2gzNC85Sm0ydzJ3eFQ5anoyZ25XVVFCS2pV?=
 =?utf-8?B?VCtZWk1TMEFndzJpN1pzVUpFM0ZReHVHNGkrN1pGclU5YzI2R1JWWStHTktJ?=
 =?utf-8?B?dnZMUDRzUnlWeUlTaWwycHRpL1pPRFJhaEJXcU9DSldid3VhUm5FOFZWNVF0?=
 =?utf-8?B?QnlMMVNYVnZtQXluUkU0UG5ucWJMdHpMU1o2ZU9iN2x0MkV0TDdUZ2dJcWxU?=
 =?utf-8?B?YXBlbU5rb0lUWjdlSVJmbDFsTWt2eTdmektHenFpRkRaSlEwWi9GQ3lBN281?=
 =?utf-8?B?Y2JlVGQyL0lmMG5FWWc3WDlYODF5V2YzWStiMGZCNndxRTg5azhQWkxTVjIw?=
 =?utf-8?B?VWcybDlVcjNzbjZrQm5xQ25pL2kvZGc2YmR3N1ZURnlFSWNFU0hhNjBEZkdi?=
 =?utf-8?B?bzJUV3FTRkdEK0dSb0RKR1hRVzhyRlZlVDZLT0ZlOW0wWGlrdXJtcmNXdjdQ?=
 =?utf-8?B?WEhtay90aU5ESjd4YVlGWTBQQzZzK3JDeWRQTDl6TkFWTjNQelE2WFdmNFRV?=
 =?utf-8?B?ajJJUEQxMjk5ejl1MlU1Qk5SVUhZb21YT1lld2ZNblVLK25NZFFYcEtsS3cz?=
 =?utf-8?B?WWRWTEpRL1o2Qjlna1drUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGZMR1prUGMzNFJ5WFRJQUNPc3NSR2ZQY0EwbEhhQkRxRis2dy9HNVplSGtJ?=
 =?utf-8?B?L25mbGgybE9ZbkhaQW40MkE3UHBrK1RsS3BZUWQzUlAyVHJzMGwxTDhkblZZ?=
 =?utf-8?B?WmtDSjRKUGVKWURnVlkveFFRcElZdTE0d0hnZldHQ09hbDR3bDZyQVRsMjJH?=
 =?utf-8?B?UnI4OGJCcFZoRkYrR2wvaDFQTVNMamZmQmE4SmNhUEFMMEJrWHRhcDBvZGlB?=
 =?utf-8?B?dFF1WXpack1XQTV1MWorcWVmR1BWNkpYREp6OU9BejEvamI4MkdnVHVXaXNL?=
 =?utf-8?B?WTl6TExxNFBvN3lnQUN5VmtlN2lQZDd0N2tZM1kxK0VzMjdxWnlucWhDSzRM?=
 =?utf-8?B?b25aVlpUUEt6V2xNeTlRRFZPY3ozK3ExZWVuYmpMYTg1SlNqTFp2dVZ1K1A0?=
 =?utf-8?B?QnI5UXJLRmJkRVFLR2RiNWRveEMzQTBGT2YwNGo4TytvYmFOV2kvNisrM2xB?=
 =?utf-8?B?K0lXSHExVW9sMC9rVS9OSCs1MzZxRFlFVkc4MUg1aFZzZDlaZ3o1dVRsRi9O?=
 =?utf-8?B?cFJjcjhhZnB3dzFyZDVsclpGZmpnVkZkVHBvR1VkYVpKZEI2TkFHeE1nY083?=
 =?utf-8?B?Yk9LVXVyWHZFV0phdjFwc3lpYTVwSFhWYkU3NFNsaVZSMkszMkJCdC9UMU4z?=
 =?utf-8?B?dTJkUkwvbTRkQ0hySEUycWVzanh4VDI1RTRsV0RqcTZQc2djd0M1UEpzUGln?=
 =?utf-8?B?Ni9zb0ozV28wNlp2NmlONE55STAwcDIyQzFGRVN1dldUem5kWmkzR2FzTUlw?=
 =?utf-8?B?QWpvL1JJd3htSFlvL1hXKzFTOU5LM3EvT3pqSmtFQUxSZUkxOXdQcSttZnpX?=
 =?utf-8?B?WGZCQjMySjJLTE1BeE5NMHU0WXl1cXE2Qzl5c0RXZUZoUUROL1A4ZVBxL0dH?=
 =?utf-8?B?Qk5oTVRNeGhTSStQbWxPS3JqSU9WMlFSazFyNnNXVkE5VmFNbzZmQzY0dzNL?=
 =?utf-8?B?NGFidEF3RlR6aEhPbndvYVgxa2x3cExtbHdsK09ZTFpRaWVuQmJlWEpoQStv?=
 =?utf-8?B?RGNpTmVVUkNSSVJCUExTRldSeDNYR2hnckRNb3RtWEpxTXYwMkdzZ2tqK09I?=
 =?utf-8?B?VGF3K0hWVVdQTVJpRHlweTNrOVRSLzlKU0NIUGNCNlV3bW0rbTFRNFFpNHhC?=
 =?utf-8?B?NzdHTk50ejE0NVU5WWRqWUNyenlJS0QvQWJwZmhPc2FLOVdjejMrMW41RVdh?=
 =?utf-8?B?cytWMWVhYmluMGZ1dFRwN1hVWDFjenpKSjRHemNwZzlFTVlONGcvamxJbGs5?=
 =?utf-8?B?TzlNTTJaM2E5Qm1oVEk4cGF2VEl0ZkxnUG81SkVuSTc5VURhMHFYYUxSTEtW?=
 =?utf-8?B?bTVYaUxvRXM1dEVGcnUyY3ZKRHgxWS81M0hkYUxxRWxLYW83V0tBQ2RNbExj?=
 =?utf-8?B?RXNOYmFRRDhEbmpqa0g2MzlFZkxMOTJ1ZDJjUmp2WkFhR0NjdEw5L0xLdHZG?=
 =?utf-8?B?MVg1QTJoNGdEWVMvVHNQRHNCYjBxTVRLOURTNVN4bm9jOUdZSDRoZTZ4L2hQ?=
 =?utf-8?B?aWVianJFNEtGaFZEYTBHYzgyY3oycnd6YmhUUDJoRXlKTi94N1RUWmVoM2N4?=
 =?utf-8?B?elhEQzZMV3ZVQWJhcTRvbVVoZ2lRNTc0N1FQbDVKVnVjdndyQXVvaU56bmto?=
 =?utf-8?B?VUQ1OEdVNVo5OGluQVpUbmJEd21jYlQ4cHBZdE9Jd1pxSlNZTlU4NEl2MlVq?=
 =?utf-8?B?b3FKNUtkVnY1RkRBcTFYQmtnZ1RLWjVhVTg4WEJ4aUFZV1lhTjhEMmFTZ2xu?=
 =?utf-8?B?b3lvRWNkU3BaVEU4UTZ1enhzTFYyY1BPOXNKeE9oSkpjbnJhQW1DV0pKOUFy?=
 =?utf-8?B?MmxOSzQ3NjJkeDRQdFJNOFpmdjdORGVWRFR0QWNDS2V1bUpDc0FSSW5YQVJX?=
 =?utf-8?B?bTc1czEwNmdkYURaVkxTbU4vLzYzZ3hrdTI1UGJnTEtSQkdmNU8xQ3hab1Fj?=
 =?utf-8?B?Y2tpdGwvOWZ1ZUFzV3ZiaWt3bWxvQmFXWkhHaXJlNHhMMkM5czRESWMrRGtl?=
 =?utf-8?B?eDZvTDdNeGNIbHZXY3RlSDVhMHptUENIL2VCdUVhVFN3OW56KzFqTlBFaHdD?=
 =?utf-8?B?YUVPcXFueFhLV0lVc1Y3N3VWNWY4QStmMjhuSUxRTm9mVHE5K01jNnRmeklU?=
 =?utf-8?Q?yHwhZvJkN2oQ/fA0f/2OcLjsB?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e39663-7eb3-484e-2ce9-08dcc856225e
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 18:12:25.0402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ysI3Q6+bNYkK6V1GWUcm0gnvuC6lmeDC4G76ewYF5yIj2fIlxdfLMTF9qByX1VO4SMJYinYyJtMhqCwT+jcSHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB9942

On 2024-08-26 04:04, Xingyu Wu wrote:
> Add notifier function for PLL0 clock. In the function, the cpu_root clock
> should be operated by saving its current parent and setting a new safe
> parent (osc clock) before setting the PLL0 clock rate. After setting PLL0
> rate, it should be switched back to the original parent clock.
> 
> Fixes: e2c510d6d630 ("riscv: dts: starfive: Add cpu scaling for JH7110 SoC")
> Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>

Tested on a Visionfive2, on v6.11-rc5 the CPU is stuck at 1Ghz. With these 2
patches applied, CPU defaults to 1.5Ghz and can be set to 375 MHz, 500 MHz,
750 MHz.

Tested-By: Michael Jeanson <mjeanson@efficios.com>

