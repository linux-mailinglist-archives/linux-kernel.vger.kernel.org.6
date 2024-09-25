Return-Path: <linux-kernel+bounces-338090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF4A98533E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 08:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 639C0B2348F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 06:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A05D155CBA;
	Wed, 25 Sep 2024 06:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="X9ZwEjcH"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021132.outbound.protection.outlook.com [52.101.129.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F162F155333;
	Wed, 25 Sep 2024 06:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727247134; cv=fail; b=aUWnHCXaVWDl02IDuiqxxxqe+7YwMyLJdbqKM2TsWaamnyOYB8SxMXcBuKg0DAWajr/wDUU1SxO2CYSJztnJv8l5QvBHGc+WAy5dOk5AiAhR09/FRGHNin+XczS5XCVi4qVoeTumcNMS6vpkN5WokXSD6+s347NiFt9o5+euEts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727247134; c=relaxed/simple;
	bh=kDqNca3vi3xcNh9XLugGGv6TfDxJTWpYJ1cJmZBQq1M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MDnIeoZ8zsSe1Jb211/KdL89fQLLb25HGM3deGPNkd0/CpDs8isrpCmUQBWKiaO/+pmsngldrSogfPuMspxQRK/wZiVlaM3K2dBJuy2A0bQpPaUcflD+VEEz3dakSAw5V3x6O13zJbL27XORd99YAPrVcJRAwqRz4qB0mYgRJBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=X9ZwEjcH; arc=fail smtp.client-ip=52.101.129.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UhqcuamGLc+PEX2Tqo4QmLtAaQqhyYM3OpTSGLmPoF2laHcIDpEGiucbGQtyYxzYjwme2XnGm+byWUVY5bjuUzTRZ+x+iJ+jg1cs3ysBBIpyXbjn7Dxylb3u2FsMHJMfPuoDTmZ1mbjOYf2SjycHlEj3w7mc9mYIXyUnLJAuHThk771uV5Yqjpp9s4K5F09PGGXNo3fq6dte+hfDQVCcwrjWl9zaNbVibGkHK3BqotIEZXFzmVpQjETUfi4/5kUOEfUnx2P3hoVdI+19pHW8IuLsqTzRbXGb57Ux/+a23bsE05U0qu8aSAxyaZluimM5Rn9jjIGV1wJr6wzphiGibQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmW4UyX5wsDlY3/GHW7+2NnM3BoCreszHCm6zWxE6/A=;
 b=gCt8Vdl2YGDLdtynXopvhETmdDbTVP6h0qZyhis4859ONoW0+K8nCjsOi3KNiLsCFcvNXHrLbld/NwMAJik3IxQT0gE4VGWPOrkk9axrZNEBRBqROzyCnOqofs0hXU4ft6QmkWxw5beWHU9PhztB4uc7bDFR7Cx1k7fwDbZhnULhMbc9OsrcCttLqR1vzwW8XOL9WlU4hRY8q+T5LPkZepoDPHogBD4GYzDDEBSXlSaX9ETBRhP/PAknii9WWoAaBcPEZdju76Kwi7h/RRhaXnV+0uEShGozR1qNNFa89xosB0b2sLzl+neDk3QTBSJCyyeyHtSzkq+ZjhZm5jyIhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmW4UyX5wsDlY3/GHW7+2NnM3BoCreszHCm6zWxE6/A=;
 b=X9ZwEjcHvfqqpx3B/Z6/juv38HAewBTbCPz4pxn18d7bLJfIlsdCiPsdlUmPsNmeqUTcig6Eg6Oqx2+eTvxoVFOeloEJNb+a7y8GcrIqGSOjTcpSRzxQ6vlxUeozRt2+SdlJ7hzLlSpW01nTzWe2n8EY4JqqS33IQ0G8eumaZe1yBBNxvlPxfNQ0bqTBRJg6syFau1HZ5hHSxBz+wiMu/2WnhjMM2ewD558vKolJfQFQNOp+KMqpCFDzUHkTmJO7Qfoyf2zNsJEdmEoqaGllAL5pPgk7KROxiM4v3UWDiDrLYfeGOnbX9mtYV7heCU8Ud39EmIRx2IIrqBZDNDk0lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by TYZPR03MB7412.apcprd03.prod.outlook.com (2603:1096:400:41b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Wed, 25 Sep
 2024 06:52:07 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca%7]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 06:52:05 +0000
Message-ID: <8a673e43-4257-4a0c-a70c-f6ac80aa9fae@amlogic.com>
Date: Wed, 25 Sep 2024 14:51:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: meson: pll: Update the meson_clk_pll_init execution
 judgment logic
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240920-optimize_pll_flag-v1-1-c90d84a80a51@amlogic.com>
 <1jy13hxwp2.fsf@starbuckisacylon.baylibre.com>
 <e458a1c6-5e85-4ecd-a21a-3407a6dd832b@amlogic.com>
 <1jtte5xjgk.fsf@starbuckisacylon.baylibre.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <1jtte5xjgk.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0006.APCP153.PROD.OUTLOOK.COM (2603:1096::16) To
 KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|TYZPR03MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: 49c2f8da-aec4-43df-0e6e-08dcdd2e915c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M244amhIWWJ3a2prWU1IbTdZclczOUpza1dwVnZQZzBhNFoxTW9TMlhqT3NV?=
 =?utf-8?B?RGp2YVdOSy8wTkQ4bEhqQnE2S3NMaHJOM016S25pNzNPWnUzMWNMQ0V3cUZx?=
 =?utf-8?B?YTJGZitjeUJDKzIxTldNNEpRQkozV08rOFpxQ1QvbkJGM2VUVEZmUWpWZ1Vt?=
 =?utf-8?B?ZEJHdC9RenFaRUlseTZ5b1Y0a0FmZ20rRzJ0dkRQUWN1SWcxa1ZLRlFtRytn?=
 =?utf-8?B?V3pOVnhabVJLbE44WGpodDZuTGovSHk2U1hOREY3VkdmaGxHOVhwWURsWVJL?=
 =?utf-8?B?ZzR3cUp1MnBVSEM0ckxnS3dxZHRJU24yQVpIa243R1RPNUpSK3B2THA3dzNy?=
 =?utf-8?B?QmIvZmx4bjBlOG13K3FwSjIvSENGT01UUTFJRGFzclZTZUR4N01uR2M3WWNM?=
 =?utf-8?B?QVRoTWxnMHVtcDZJTExpayt2UHB0VlNmQ0N4eXdWOUJMNGNMMzVFODROcXBr?=
 =?utf-8?B?NFVuU3IwaHcreVZ1UlRUdG5HL29HL1NVa3NOcXlKWDM3M1FCM21MVE1TaUMy?=
 =?utf-8?B?Z2tkRS9NQmFEdUgxNkw2aWZhSzlSNGszWG04Y3Y3M1hEUk1henBRNVZlZkQv?=
 =?utf-8?B?K2hCbklMSndCd3JmQmZ2Mi92YWdPYTFmVWxiYUJhU0FwSFErUlI1L0hxUGtY?=
 =?utf-8?B?d0xKSUF4RFVpN2tpK0NYeE9NYWk5Lzg1cmcvYjN3czVDRVhRS0lGdktONE5i?=
 =?utf-8?B?NE1JNGhwUGwvSEppL0M5UGxDczRkRDJZbS9UWFZkbDRFdVp5SDJvbVpESEVU?=
 =?utf-8?B?cHJUbE5DQTR2amxBL1cxQUR2Y0dnK2UzU0d5TlQyVjJHems2eGkvcFovWVdS?=
 =?utf-8?B?MEc5S1Ewa3djWkZ4QzFKYnBmY3lzNnJoMDdGY0o4RGxrSFBja3VkNGxBNG9a?=
 =?utf-8?B?b3Z2SWF2MnNYNThZWFlpYmpYQ05POFE0R0tQT2FYR1J3eGs0Uk0rU0dqV0NS?=
 =?utf-8?B?VWNSS2tnS2duUkdySnRQTlV3MXBLNzhqOUhZaXRDNzljVUhsZUtYNEh2WUcw?=
 =?utf-8?B?STRZRDdCajE5bEZFRm5rcXNjSkhIS3JKZDlOdnhJdStxM0xrcUpCVUNaNm5j?=
 =?utf-8?B?dmtTb2lTTWx4UWs0bzBGWjB3SFYveWEyWXl1dmJKbHY0c2laQWJnS281OC9W?=
 =?utf-8?B?bGI3clhSMXJwOVUxN3V5VmU5KzBHMDVSQS9yeVoxSk9FYVhBa0JiN2lnSW45?=
 =?utf-8?B?bnlqelowNWdDZ1NmQ1hyWmhIL3Z0QTQ5MVdoeXVtRWk2R2VLdHBIbklIQVhR?=
 =?utf-8?B?RUVoOTFQNk91QjlIUlBLYUlxNUhkWVhzNWxjQ3draGNYMVBNeFhlZWRBWHIv?=
 =?utf-8?B?eGJvSFhKZFk5UEZQR2xLQ0V3Ym9scG5iaGRsRnVxcW1YMXdaZHJZcVFNWkZY?=
 =?utf-8?B?cUxwaThYa3FKbDFac2V2WGI3SWRJdHJzSUdRallicVY2RU1Yck1NcnhCN3FQ?=
 =?utf-8?B?Z1pxYStLSWFOdExQdWZ3NDFjOXJKVzJncGZMUWw1Nk1yNDEvajBTbXhtWVc2?=
 =?utf-8?B?V25WaVBOTVRJR0tSbDNPb1pKREdoeWNpQjcyUitTQW9pdjBVZnhSRXJLNmJI?=
 =?utf-8?B?Qm8vc3NXSGdYcmlqY01NYkZGT2N5SU5BemNtMHI4NHljN3dBM3gyZzBteGpR?=
 =?utf-8?B?V0thcnh5REl6OFg5SUx5eWxKSCtuVHl3QnhxYWdjSXJUbTNQMlU4c2ZMZXdJ?=
 =?utf-8?B?cDIwZS9MRjNUOXp4NkxUUTlpZFA5M1RPaUIyZVZ0NVBBc0NsVEE2ZG9RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3k4ZzhyTlQzQ0IxZ1hXWFVSNVdEMzV0VEdLd2szZjNuYUFpTVdWZzF4Z2JL?=
 =?utf-8?B?QnZDRDBKUm9RanhFK296OWdwdWFrZkVHMHdJcTk0eGp3TkVBWlJkRk9vbTQr?=
 =?utf-8?B?OFExZ1h0dlhJRXJ5aHhHUnVFMStBeXFmd25lazhIZnhncXQ0K3k4UythS3J2?=
 =?utf-8?B?UnhDYk8yZThWallQMnlmRi93QUFCVTVpNmh2QVB6d1VJTjlQLzRYYm1qa3ZR?=
 =?utf-8?B?SCsySFpDL2JBRlR4REc3YklTMG1LanY5eGFmOW4rTFlKSjFINlp6N21XV3hP?=
 =?utf-8?B?MkZXWDdXVXUzaU1KajJWY3I5Y3dIQkVlYlkzZjg4dGdSOHBlNklUL2R0RnZr?=
 =?utf-8?B?Mk52MEpJMStvZC9YQUtONVdiQmNJT2ZlUXc3ZXN2eCsyM21WZGVMS1RqcnlE?=
 =?utf-8?B?VmUrQUg3OG1BamZoSUorbDJTTHV5RWp2V3hQR0U4TWpreE5QZjJDZlk1blpJ?=
 =?utf-8?B?QUliQ2ZMdHNkdkpscnFsZWZ2aDVObUlPNk5BcnhBYUd2MEhzR3lNK3EvWSs5?=
 =?utf-8?B?dHB0RWhVUml5SHd6STJnNHEyNTMydmg3c09BZThNMkUxMnp0Tm5DRERsQlpN?=
 =?utf-8?B?QUI0c1ZaTlhROFM3QjdqVyt5eHNjRmlBNGpGcUtzQWNtQkVXU1NEeXdyVzNp?=
 =?utf-8?B?dVpWcW9zQWNqNm0xMDNLYW1ETExzMDR5Mkx0S1RWQURuMHJEODlML2czbVhn?=
 =?utf-8?B?K0hDSFlha3VsWFJ2ZVF0U3ZDWHZSdTdsMWk1eDZ5anhrdWhWODkzUlJYSnBh?=
 =?utf-8?B?NVBpYjdIRElwaUg4SWsrOVk3TkJjS3cvd2EvamJkdmxVMWZsVExPK3UrTURT?=
 =?utf-8?B?bWhySE9GYlJUQ091YWhRNElya3Q4eUZqZzhHZ0lDa2Z3ME40QUxxQVVCc24y?=
 =?utf-8?B?ZnVFejNPejFNTERUSXpuWTRVVTRFZEc1VGVTdVJ2aHZPSDRJU1RsbkZPcVp6?=
 =?utf-8?B?eGdSeFpjUUEwbFRWSTY0UWNYWDBVZ0RBaHhoS3piNTRMTUtLaFdYdFlUOXRn?=
 =?utf-8?B?Z1dnNXdzY0FBOVRqYWdjbEpaamI1Tjh4WS9MOE56M1Z3ajBKM0FvMFFUdkFW?=
 =?utf-8?B?NERUdVF6MjFMckdJZjZkL2NaMjB3WXlyR3Z3akpVYkM5OUFtdUhwd2JsN1BD?=
 =?utf-8?B?bzJocEhXOFpUQWRnMTdzU0lvYTdUQ0NLOGc1b2s5bmIxODVYS2tlaUxjVFE3?=
 =?utf-8?B?bDFJejJRMTVIaVVyYU1jdXZFeUVOTStaeFNyUmFDQm1IQTg1YXBtQkdLL0pT?=
 =?utf-8?B?QXBqNW1wa3EzL2tPZ0wwSm05dmk1NENhS2FzdTBkSHJDQXJpYVo3Tk0xRDNs?=
 =?utf-8?B?WXFHOWZGMW4rbDJQbXlzNWFzbHhGTVpCSll3QTlKcEthTEdRUkZ6dGpnVXZZ?=
 =?utf-8?B?OHZ1dmxRa1lEQWNqcXQ0ODhqMTNRU1FFVEpQYzk2eFRPR2poV0E0WDNvR0Zq?=
 =?utf-8?B?dkdMT1I1cmQ0QXZXTStSS0FFMmpOV1Q3Q1FjSGUwNElVSXFIaFJ1dy84b29H?=
 =?utf-8?B?VDRqWnN3WEc4VGp3R2d0ZVo0UTN3bmtIb0wrNW9QN0dKbndFaTBiMzE2THZ2?=
 =?utf-8?B?YndxR0lCTWhxTHZ5TmFFdXdVUzRvZXZhYUE1QUd6UHgwWEdhU2cwTHQrZjNQ?=
 =?utf-8?B?SzhYSVNZWUZYcXVoZXR2MUxHU3dRb21mbkxCK0dMMit4NjVMSFArV0I3RzJV?=
 =?utf-8?B?NnRkYitmcGlZQTY5d1FnQzRJa3U5alJJcDFnQVZWSTBscndlalFkSHlid0pa?=
 =?utf-8?B?Tzl4U09iay9TUDIzVFhxQlVYcDd4Ujh0aTNRUUw5bFpjSUJxNGhqNzF6WkNJ?=
 =?utf-8?B?S3piejZvbGhvNzRuTFFEdldTbzhpUzlobE5LeGUxTW5NV2FiOFZ6cGhyMlM3?=
 =?utf-8?B?aFRpdlQwZE4vN3V4ekZtZTBkaFNMRXBTekU2eFlRcG14U2pUdWZiMkZTN21i?=
 =?utf-8?B?NVFCUmZUSXMzWTVlZVdLbU9wWnlQUlFPWXVUaFFTK25tNjFyQWVNSmhqM0Zr?=
 =?utf-8?B?dEUrVEszdE1lU2xZTnFoNEplNTF0a2lGWXEvaEVOS3IrNDJuUnNCRkFVQ294?=
 =?utf-8?B?TXM4amRmNENLUTZ3eDZ4dElROG1uMFFGMFg2VEswWndtNGtFdnREa2pHdUVq?=
 =?utf-8?Q?5Dci4B0Bv9GfNwxlZERcSweVH?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c2f8da-aec4-43df-0e6e-08dcdd2e915c
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 06:52:05.8707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XmUBW/2421tkfRZcpGiUlbDiR2oHUqr9eoWeDx72WiU8KJvCSwPP3bjqOaEK2S0XiOvNlFonQ53mBKZM4DVurw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7412


On 2024/9/24 21:35, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
>
> On Tue 24 Sep 2024 at 18:27, Chuan Liu <chuan.liu@amlogic.com> wrote:
>
>> On 2024/9/24 16:50, Jerome Brunet wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>> On Fri 20 Sep 2024 at 16:13, Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org> wrote:
>>>
>>>> From: Chuan Liu <chuan.liu@amlogic.com>
>>>>
>>>> The hardware property of PLL determines that PLL can only be enabled
>>>> after PLL has been initialized. If PLL is not initialized, the
>>>> corresponding lock bit will not be set to 1, resulting in
>>>> meson_clk_pll_is_enabled() returning "false".
>>>>
>>>> Therefore, if PLL is already enabled, there is no need to repeat
>>>> initialization, and the judgment "CLK_MESON_PLL_NOINIT_ENABLED" in
>>>> meson_clk_pll_init() appears redundant.
>>> Apparently you messed something up with b4 ...
>>
>> emmmm... I'm not familiar with this tool😂
>>
>>
>>>> ---
>>>> The hardware property of PLL determines that PLL can only be enabled
>>>> after PLL has been initialized. If PLL is not initialized, the
>>>> corresponding lock bit will not be set to 1, resulting in
>>>> meson_clk_pll_is_enabled() returning "false".
>>>>
>>>> Therefore, if PLL is already enabled, there is no need to repeat
>>>> initialization, and the judgment "CLK_MESON_PLL_NOINIT_ENABLED" in
>>>> meson_clk_pll_init() appears redundant.
>>
>> You have a point, but we do get this kind of situation all the time:
>>
>> For example, hifi_pll provides a clock for audio, which needs to be
>> configured
>>
>> in the bootloader phase in order to play audio as soon as possible after
>> boot.
>>
>> After entering the kernel, the hifi_pll frequency may be dynamically
>> adjusted
> Whatever was feeding the audio fifo is gone by that stage and fifo, tdm
> and everything will be reset as soon the audio drivers are probed.
> I hardly see how keeping the PLL init through boot could apply to audio,
> especially with the use of assigned-rate in DT.


I asked a colleague of our audio driver, and he replied that there were
the following scenarios: During the bootloader phase, our audio stream
and video stream would be output together through HDMI, so hifi_pll also
needed to ensure continuity during the kernel. Of course, it doesn't matter,
our driver can meet this need.


>> (to match the audio bit rate/audio and video synchronization, etc.). The
>> gp_pll
>>
>> that provides the clock for eMMC and the hdmi_pll that provides the clock
>> for
>>
>> HDMI are all configured during the bootloader phase and cannot be configured
>>
>> as RO in the kernel.
> HDMI, you presumably want to avoid a glitch in video until you're ready
> to reconfigure the pipeline. That would be a valid use-case for
> CLK_MESON_PLL_NOINIT_ENABLED.
>
>>
>> My idea is to still describe the init_regs information in the kernel in the
>> driver:
>>
>> 1) If the bootloader is not enabled, the PLL will be judged as unused
>> during the
>>
>> bootloader phase, and then enter the kernel for initialization.
>>
>> 2) If the bootloader has enabled PLL, in order to ensure clock continuity
>> after
>>
>> entering the kernel, it will not repeat initialization (re-initialization
>> may cause the
>>
>> module that references PLL to work abnormally).
> I understood your idea the first time around. I still do not agree.
> Use CLK_MESON_PLL_NOINIT_ENABLED if you must keep an enabled PLL and
> justify the use with a proper comment. For eMMC I'm not convinced.


The original intention of this patch is to simplify the PLL init
execution logic, and the kernel is compatible with the bootloader
initializing PLL and not initializing PLL, and can increase the fault
tolerance of the driver. Although this treatment hides the coupling
relationship with the bootloader, balancing the risks and benefits,
I think the benefits are greater.


This is just an optimization patch of low importance, if you think this
patch is bad after weighing it, then ignore it.


>> Can the coupling between bootloader and kernel be avoided on the premise of
>>
>> ensuring functional integrity.
>>
>>
>>> If the PLL is enabled, it has been initiallized, to some extent
>>> yes. However we have no idea what the setting was. In general, I really
>>> don't like inheriting settings from bootloader. It brings all sorts of
>>> issues depending on the bootloader origin and version used by the
>>> specific platform.
>>>
>>> So in general a PLL should be re-initialized when possible. When it is
>>> not possible, in most case it means the PLL should be RO and linux
>>> should just use it.
>>>
>>> Someone brought a specific case in between, where they needed to keep
>>> the PLL on boot, but still be able to relock it later on. The flag
>>> properly identify those PLLs. Much like CLK_IS_CRITICAL or
>>> CLK_IGNORE_UNUSED, each usage shall be properly documented.
>>>
>>>> In actual application scenarios, PLL configuration is determined during
>>>> the bootloader phase. If PLL has been configured during the bootloader
>>>> phase, you need to add a flag to the kernel to avoid PLL
>>>> re-initialization, which will increase the coupling between the kernel
>>>> and the bootloader.
>>> The vast majority of those PLL should be RO then.
>>> If you can relock it, you should be able to re-init it as well.
>>
>> re-init may cause glitch in the PLL, which affects module work at later PLL
>> levels.
>>
>>
>>>> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>>>> ---
>>>>    drivers/clk/meson/clk-pll.c | 3 +--
>>>>    drivers/clk/meson/clk-pll.h | 1 -
>>>>    2 files changed, 1 insertion(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
>>>> index 89f0f04a16ab..8df2add40b57 100644
>>>> --- a/drivers/clk/meson/clk-pll.c
>>>> +++ b/drivers/clk/meson/clk-pll.c
>>>> @@ -316,8 +316,7 @@ static int meson_clk_pll_init(struct clk_hw *hw)
>>>>          * Keep the clock running, which was already initialized and enabled
>>>>          * from the bootloader stage, to avoid any glitches.
>>>>          */
>>>> -     if ((pll->flags & CLK_MESON_PLL_NOINIT_ENABLED) &&
>>>> -         meson_clk_pll_is_enabled(hw))
>>>> +     if (meson_clk_pll_is_enabled(hw))
>>>>                 return 0;
>>> I'm not OK with this.
>>>
>>>>         if (pll->init_count) {
>>>> diff --git a/drivers/clk/meson/clk-pll.h b/drivers/clk/meson/clk-pll.h
>>>> index 949157fb7bf5..cccbf52808b1 100644
>>>> --- a/drivers/clk/meson/clk-pll.h
>>>> +++ b/drivers/clk/meson/clk-pll.h
>>>> @@ -28,7 +28,6 @@ struct pll_mult_range {
>>>>         }
>>>>
>>>>    #define CLK_MESON_PLL_ROUND_CLOSEST  BIT(0)
>>>> -#define CLK_MESON_PLL_NOINIT_ENABLED BIT(1)
>>>>
>>>>    struct meson_clk_pll_data {
>>>>         struct parm en;
>>>>
>>>> ---
>>>> base-commit: 0ef513560b53d499c824b77220c537eafe1df90d
>>>> change-id: 20240918-optimize_pll_flag-678a88d23f82
>>>>
>>>> Best regards,
>>> --
>>> Jerome
> --
> Jerome

