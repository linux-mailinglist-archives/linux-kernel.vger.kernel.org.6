Return-Path: <linux-kernel+bounces-302950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 380E5960572
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CEA11C21066
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54CB19CD04;
	Tue, 27 Aug 2024 09:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="iA6vBeY9"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2072.outbound.protection.outlook.com [40.107.103.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C81376056;
	Tue, 27 Aug 2024 09:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724750536; cv=fail; b=UP0B+hs998GmPqJ7iM1RQFmQO+gTG93jTXoe0n3AhoqESPNGiE/4lvzNZWZYY3JvFAmGlV1ESjVRnlBDmUsY/fI1MsLHxbdeGkIF0H722LVlpqJ7VfXLZ+sQXViBPFMH3UtPkMK9qBIjuBTjAyj505ynxuCG/49S8ZNq5Yx4Vf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724750536; c=relaxed/simple;
	bh=sgwiEJUbvcFX0PoV1u5lxPQmZpVNsmiynFa+iECnkUc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PMcC5xOhkLuh+gtXOx7ZPR7jMtdpg1d8tN2cXJAsG1eWswK8Fmya7sdXnvMfFIW0M2CU7dDyoQN95x4K9iouE1H3txcuwSIDU00kS4GrzRWSTMKTOt321avj3cEI2ljAAbIETZNpJZAVcvIQlR6vJqZ8IvvUEI7ClIW1q2TIwv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=iA6vBeY9; arc=fail smtp.client-ip=40.107.103.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IkMkThQ4qg2b3zyqKtN4ZR22eexhldduQE7X4QdQJYORj0TGEIi3aVruWNqTxb6GXQ2ATvyAmW2IIaWQ3LshoaijXV2PoRUo2QVbUuSnuHPf0nRcGlcHTC1wTQT3TxdrccTqKP3a6yMdRNjM2dRobKoM4PyFPsHE6VKm8aPSxAS9035535RpqH654SnZu+pM966malv2Ev5BWLSkEgKqbAAysSp6XmBQsVixrZSxnhddb+YTbHK4QDXdxiblBgH/DjC0RRnaOP5dA5lS0D26niatjtb0tt8Vid/pPN5tHKUD4gHWuH3sSTfjM/xh9cpnjna32Ou1AxunpYIQAKPNpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4rOWI/5HVfJpEk7KRzXzf/AF6ouJd9e6ynAaywM1UU=;
 b=bTsweCDF6o0SaTqjQs6TojZyNcY8Ms+QW8atoN0eQ1c1aS90VC9e7P4MKvySh4BX3r7C9rg6WO+ELSYEgOijkgbw7s00YbIfQFlGw2PJIQcngV6aSbZ80l9jB8AL+57mI6DwWbHM8mJUYHFmkVAUVXJ9I0PR357x/ubg3wr9R2UNkV6z4ILLUiBWdvwqckxYLsKrJIRg4tILOoTbXbK6wTsQjByjVhaXEDbaCQOC7GG91fg+3Vdm07VQ6EO/VlIoYr0BnDuvZYzEUVHUD6xc4EB+i2Xuvc7ihtQcUHuD3914lFMvR611+Ps/IHptOTEggpreuH3p+KrnH+d8nkq79w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4rOWI/5HVfJpEk7KRzXzf/AF6ouJd9e6ynAaywM1UU=;
 b=iA6vBeY9ze/bYs56hQXhHFi6z5rErEqhei7XyBrSznXb78gzp9IM+KSmjfD8GqRnjysQzLleOC60zNRvMd9sX+lrXh/ZJpIGb39xIEZIrNxHTzBJ/IT5c7ZTwF/I3ci1fn36SbfVh8UT5yGhTIgfwQekLSEWTvroDJlIk8NLzuWGFUui9YQmlHskzqA9z4m56x3dYO29t7mYiLZYiMNra1aowFYUP4htG2M0f1EWBw+ZVd+fQf7ZQPhc/KnWlcVs43BkeecZnBFMj4fh3L4Mw1tOMXyBusSKnD2yudNVxAgp2wuyIYxgrrSOE09ED7bFAq+NhFlGLWfJhSy02hXtrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3654.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:141::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 09:22:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 09:22:10 +0000
Message-ID: <6c28d580-9961-4bac-adcd-1724de68c9fb@siemens.com>
Date: Tue, 27 Aug 2024 11:22:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] dt-bindings: PCI: ti,am65: Extend for use with PVU
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Bao Cheng Su <baocheng.su@siemens.com>, Hua Qian Li
 <huaqian.li@siemens.com>, Diogo Ivo <diogo.ivo@siemens.com>
References: <cover.1724709007.git.jan.kiszka@siemens.com>
 <82ac9e266f6aca42699ec4a3c8f10887789ee6bf.1724709007.git.jan.kiszka@siemens.com>
 <afyz3i4xihir4fnt4djo45saytz5ubu3wel6munq7cinwcb55m@ohdelne4xf34>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <afyz3i4xihir4fnt4djo45saytz5ubu3wel6munq7cinwcb55m@ohdelne4xf34>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3654:EE_
X-MS-Office365-Filtering-Correlation-Id: d8ba73a8-c6c2-4863-12a0-08dcc679bab7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjdXZzBmR3hRSXFUUzlWclQ1R2pJeGY4b20rVElrNTE2Rm9jSnd6Y1Q0NzZh?=
 =?utf-8?B?QXZmTGNIYklYby9zUkgwb09SaGtyazVMUFVMbFRVcktTRE5oZWp5RU9GVExO?=
 =?utf-8?B?Y2VtTk93Tmc2bmFMdkVLY3hQQk9DTHNjNy9mM0NPNkYwUWFXQmh5eXZoSHdX?=
 =?utf-8?B?alRLZDd2dkRvRGdFREt5TWhEMDZqVnFtUTR3V3Q1ejJNRFFQSzFkdCtuVVlM?=
 =?utf-8?B?S2R2cEhMMURvWGZRL3g1QVBUTzBTU0RJZVBHSSt2WFdrNUU2MDZyTXp3YnV1?=
 =?utf-8?B?aDlHTFBYSUJiWC9VVGFVblByMmsyckJoYzdLM3hPMUdPbGU4STBucmJnRDMw?=
 =?utf-8?B?QW1rVEFTbmNiMmlqelBqd1VERUZ4bkJ2R2k0WEJJODdwUXN2MllqaHJmOXhQ?=
 =?utf-8?B?a2MrbENKOGcxQ1pGNmZ2M1oyaDZuSkk4WVhqcDlDeWdmQjlyMUdiZzM3Mkhr?=
 =?utf-8?B?d2lqdUtFNXcySXBPeVljZDRjcHJaQmR5djYzdnlJbFU4Ri9HOHluYmVwSkdh?=
 =?utf-8?B?ZmxiOEhEZGdVODZnYVVWRUE4NGFUOEJiSUJid0t1NDJVNCsxY1E1LzZ4eU4x?=
 =?utf-8?B?bmJTaWxXbFVOWDZvbHVLY3A5S0hxRW5kQllLV1ovdEw3VFRoZWpNS2w0bGFa?=
 =?utf-8?B?MllQTGlWcnd2U2hWaU5SRlNpVnJqTVp2ZlVZUTkxeEcwZkJualhXYWJwNEMz?=
 =?utf-8?B?TEQrT28xMUdMUzdCR0hKQzZMRy8rUndwRDlWTkowZzVIMlhjKzZWSE9jMWI2?=
 =?utf-8?B?c0twRjdUZk8wRm90UFY1T2dremdBUVYxd2lzYmMxTXdXWXQwdFV0aUJXL042?=
 =?utf-8?B?YkttOGt6eTdVQVBkaXRtdVJMQ2x3Z2ZSYkhrbnRjRWRwUSs3V01RS0JHYS9X?=
 =?utf-8?B?NkZVWjF1dEZVRFFOZzNjclBOOURyWmpLbEFsNmdtejJWQzJIMG4rc21TTWdX?=
 =?utf-8?B?c1JLVkFYQ2NyMlI1NG0rbmxTQlZoalBCaXlvWC8rS24wL3VxZ0F2aTVVOG5u?=
 =?utf-8?B?T2pPNmRVcjMxQWxSM0IxbHI1ck4raE11OWFpZlMwMUVUVnJjNHIrbUZLcExZ?=
 =?utf-8?B?TUVuOGRXQ3RDa00zNGRzRmRsbXdUUmNSVTBZRjNCZmxFSzd6RDhhTzA2Yk41?=
 =?utf-8?B?dDZoMDc3S0l0aG1ZSGdMVHd2SDNNcjkzLzlVKzErRXpkMlB1aHRvQUQzenRD?=
 =?utf-8?B?NXA2OGw3VGJvN1YyanR5ZGY2cTY5VWlzM3FDSWplbFJLa0RyM1V1dXVkUU5W?=
 =?utf-8?B?bVhOeWROQm9lTm1SNi9ybkFKb3M3T1kweUVhaGg2VUg1N3lMUHlEdXR2TXlW?=
 =?utf-8?B?eVNUcUxvbkdqQm56R0ZCMHVZSkkrTnQ2SDNQUUhRQ09VZFUyclpwWm5LRWJ5?=
 =?utf-8?B?SWNrdG1wL3l6TmJhRFVDeC9Fb0hqV1NwMUNKazJVTVV4VWJTbXQ4RmtyVHRG?=
 =?utf-8?B?ZmRrbno4bG5XUlEySGRSTmdwaXhKcWxJdFliajM2SFpRZjdoSEFRNFgrTGk1?=
 =?utf-8?B?Yys2bUkzdDdROWY5bGxvT20yTDRaV3BDcGZRTldKcXRWanBLNXFWeUtscG95?=
 =?utf-8?B?V1pkN21QSXVjTXBBRW5id2kvSUY2dGdJWDVpbnRtTHRlTXZpUXBZdTNSYkFw?=
 =?utf-8?B?dFVzRlJYOVhXanU0amJkTkJ0NHllWmtwdW02N0JYSHYwUEVyZVZDcFhYUyty?=
 =?utf-8?B?VnFJbnh6THRIcCtjVEhtYjNkMjlVeDJoQkw1YlVNSVZWamlGZmgwUGZTWHk1?=
 =?utf-8?B?MnluNzIvNGsxa1dPR3U3VEhJMWxrTUQ1MVhQK3NwaWJDai9pN0ZTWUlpZXdw?=
 =?utf-8?B?ODZ2emhSVi9ESmNzVzlQQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjJpNFowWUlDR2YvNUhkbk8veUdrVm1UY3FFdlR5V1RqUEhFQWR1eC9PL0Zy?=
 =?utf-8?B?b29nSE5PWmZwR1ZSR2lCSXo4bWZYaWN1Tm8rVW15dUtCaEU0TUg4dWxBVEMy?=
 =?utf-8?B?UU1KZzRxOCs3NUZoN3lUcTBtUGE0TXU4SnBRZ2c5ZllmMjEwS2hqU0FUVER6?=
 =?utf-8?B?RzJvQ3FyS1JqL2FhbldOTFJmcmUvbDVjeS9hazVMNFlRZk9PWDN4elZFK21D?=
 =?utf-8?B?WTFhZk9WN3ZsRldINUkreDBhZVZnYllBRzAyWG9ua3QvYWd6SGdiRjJobmlW?=
 =?utf-8?B?KzZML1IzQm14aEhuWDMvYjhJNjcvYm1xR3ViL1NJZytCZ25VNTBubUwwZUU2?=
 =?utf-8?B?Rmo0TGpkRW5XV0pnb0I5bkNrS3NUTm00OG5VQnVYOEVJZkIvV2RPL2pQbTVR?=
 =?utf-8?B?Q3VzQU9LNTdmSnU3bkhlRzB1b3BOejZ0RmlzaGpaTkxHTUY2Y2ZrOU52Mlcw?=
 =?utf-8?B?M21taWRyZzN1UVoxSXpOU1NGamloRnU1MllvVmpHU2ZPZERtY1UwZjZ5WEtM?=
 =?utf-8?B?M3lvUThhMnhjcHFoaFRuR1BGY0lWTzNoYXNtMmI5eS9tcUxwMmtVZWhBSFN2?=
 =?utf-8?B?V05xNnJHWEYrdHdlYmNWMFJGRE9SVHpPdDRaZ2tJYVRmRlcwazY4d3ZJYmY4?=
 =?utf-8?B?eUVVSmV5QjRzYlVBQTlOUHhKYitTRWtqTllSUCtIV0tUNFA2cG54Umw4NHNG?=
 =?utf-8?B?dUxpR1N0NjhrZS9qSWl0L1cybkpjUFFZRnVaNWJ5TjZYc3NnUGhnSWE0M2Fz?=
 =?utf-8?B?MHB2djF6Z2V6NWZYK29TYXN3QVdlc0RzeDFVM2RqQzVpNWpmSklCeDhNUThS?=
 =?utf-8?B?WTY1RG9DSjAzM3V1YU1tZkdFekVHSjY3ZnV1TVhJdVB3SmU4N0NEbisvbVJJ?=
 =?utf-8?B?OXpKb3lFdGVVVGFIZER6ZHp0bGNvRjVnWXhSNXBJTWo4YnNMZDdKTVA1UlBR?=
 =?utf-8?B?Ni8vRWRzY083ZDV4U0VsVVd2VFhmMDQwUUlWM1dXNGVtNzVmbnJORG1mQm5F?=
 =?utf-8?B?NkdkZDBNNmhIZHlQR0xxcWlUdDZNanBsWFdtU1lhMFRGejVad1pFd3lKSjdL?=
 =?utf-8?B?cTNJL2tOS0lxYllOM1hjNWlzRGxkOFlNZ3J5eDZlVDJtYXVESEh4ZVA1NXps?=
 =?utf-8?B?dzQ0LzZOSmUvcHV5UW9odGNmRTBQdjlpVUhhMFVranBtWEpkYXYzV0hCSnZa?=
 =?utf-8?B?RGtabWw4TkR6cEZDZ015QU44M0JEZlE4SDBiajdRMXkrMjhxRUFMdzEwRWhm?=
 =?utf-8?B?UXdSZlY2d0hJemNINW1BYXh0WEVYdHI3cy9TNmZhbkZRMU03RUVUWktKWTMx?=
 =?utf-8?B?NzdIR1R2OW9naFRLK3pBaGM3ZmV6WEZOZGN2a3Z4TUUyRWZuOXFzYWgvaDBp?=
 =?utf-8?B?UGxiSzFheWRBeXU3Sk1HU2p6Zm9FbkFJaVd3dDNzS3FmKzUrZEdCYVo3Ymxt?=
 =?utf-8?B?eTlsVzBVQnpVZXVuUGN1VDhmZEJMZUlTOUNadDFldFA1ajZvUmRpR1dMNjQ3?=
 =?utf-8?B?cHVMSm1OSFRUUFYvV0Y5ZGxNZ2hyYnNLWWphUXZRL3VjOFZ4aGRHYTB4ZXJ1?=
 =?utf-8?B?MnFrMUlGcW00aXdIRDZpaHdNVGorU052Nmw1enlZUWdoRExqbjJrWUFCVlJK?=
 =?utf-8?B?OUcxSXdZMFc4OWxBOEtmMXNWNUdFQ3k0UGgwWlZ6K0hKb3dFNXFPSzdJTzdw?=
 =?utf-8?B?ODNOenkvaWJIdDFSSkVUUjBiOTk0a2JHcXlRR0gxWTA2ejVPL212c3I3RCtx?=
 =?utf-8?B?NTgrTUdOdjRqdnd6VjEzWWN5R29ZZjYxQmtQY1dWaUluUHBiVUFGQnVuc0Iv?=
 =?utf-8?B?Q3JYcjIzc3NCeU4xbXdyaVo2WWFabHVUOTM5U2JDdkNXNStTL2wwdmNRRHJ2?=
 =?utf-8?B?bTRiOGF6aExURkYrTklmVWNJTkk3NUYzbitYZ0JNSUYxOFBGQXNWT3EyQXox?=
 =?utf-8?B?MjhXaDMzc3ZCV3BPQXNJZk95TWcyZmpmSml6SlVySkFvSTVZUzRNNDU4VFdV?=
 =?utf-8?B?MHdCL0x2biswQ3hIS1NRdmU1bFJTZDBTWEM0SVNjZjQvVkZDVEZoWjlabXRj?=
 =?utf-8?B?bHlDbjRhUUxJS0dJS1d4cStrVGJoWDBNbXEwRXBlUTBlM1VoclR4ZzhnK1hx?=
 =?utf-8?B?OHBUSXJYZURYbmRYOU1HYkR3aHJJVkczQ25ZaHNKcy82eWRUMVBqK3J6amNU?=
 =?utf-8?B?NVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ba73a8-c6c2-4863-12a0-08dcc679bab7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 09:22:10.8073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fUm2lqgIWCD76HkpB3RIFSQX3k4wEVOF7EULMNxhdDYmK3N1JB6RRku74te0mSWgc8rTBR+eBWsXl7J1Ps0h7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3654

On 27.08.24 08:37, Krzysztof Kozlowski wrote:
> On Mon, Aug 26, 2024 at 11:50:04PM +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Describe also the VMAP registers which are needed in order to make use
>> of the PVU with this PCI host. Furthermore, permit to specify a
>> restricted DMA pool by phandle.
> 
> That's an ABI break without explanation why it is necessary.
> 

It is needed in order to support the PVU, as written above.

Previous versions of this binding likely didn't consider this use case
and therefore didn't describe all registers associated with the hardware.

BTW, if you see a way to add the required registers without breaking
more than needed, I'm all ears. At least the kernel driver will continue
to work with older DTs when you disable PVU support or do not add a DMA
pool to the DT.

Jan

>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  .../devicetree/bindings/pci/ti,am65-pci-host.yaml   | 13 ++++++++++---
>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
>> index 0a9d10532cc8..72f78f21e1e8 100644
>> --- a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
>> +++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
>> @@ -20,7 +20,7 @@ properties:
>>        - ti,keystone-pcie
>>  
>>    reg:
>> -    maxItems: 4
>> +    maxItems: 6
>>  
>>    reg-names:
>>      items:
>> @@ -28,6 +28,8 @@ properties:
>>        - const: dbics
>>        - const: config
>>        - const: atu
>> +      - const: vmap_lp
>> +      - const: vmap_hp
>>  
>>    interrupts:
>>      maxItems: 1
>> @@ -69,6 +71,9 @@ properties:
>>      items:
>>        pattern: '^pcie-phy[0-1]$'
>>  
>> +  memory-region:
>> +    description: phandle to restricted DMA pool to be used for all devices behind this controller
> 
> missing constraints, maxItems
> 
> Best regards,
> Krzysztof
> 

-- 
Siemens AG, Technology
Linux Expert Center


