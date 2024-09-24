Return-Path: <linux-kernel+bounces-336978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5535C984397
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D603A1F23B49
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834DD17BB2A;
	Tue, 24 Sep 2024 10:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="zJUwy38N"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2133.outbound.protection.outlook.com [40.107.117.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A629154C0E;
	Tue, 24 Sep 2024 10:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727173665; cv=fail; b=QiSp196qmEnPCK4CdKeVCf+iTj3EGyVo1KjOV09OriJRmEtfBI9AAy/dKjTmdBac9TSsBG0VkjlHtK983U8f0c/45rId+Fe67Wj/h1KwLxqil8drxGt3oGECfM4k5GzA//Xhg5Zr2la22QCBRci0iPKqPShit+tXE+VXwUBT5Gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727173665; c=relaxed/simple;
	bh=OwKVlxeqUEXlGMD0yv7LGH9d9wsowE94X7j1pSxtg+k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bQl7FgWLmuxs0nND2Ck/n4fp5woXnLRGVXJJFpIzouvTH3x5fcbQga3GfFI60a4rIx4lQXm5gYiDYbvbDBLwDmP09D+GJW75aa21WomAhJa2d+8y+39LjbGeA0hQFMwjBcm2gMbRWKaWqa8+lapM6CUHD/RRftbiym9LY+fmEp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=zJUwy38N; arc=fail smtp.client-ip=40.107.117.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2vIKxxrQpD7wddLzejyKKR9gDHZptEfEtxYlNksMrW94R0OEFUc4vsP8r1mW9sjiMByHT+tKSp1Bl/WIYVLNitFXRTLq7RZGvAfHCcPmS0jILyMg8EOR2GLyVMpD23lNtyCxZIah8ytrBHEsJBzMCvzYVJx++JGgPOxJcb0hamD3+bvMcxp9An4K8j/eP3h54Xb9uXHZpGnNYzKxopBQpHmAk2xA1OZCN5LF/z719CbR4h/eq0JUJCUhuOnx+C1IqH7/PwnOdFenzBSARWqrNTIOzFDtDlAHDVJw6bDG4USm7LC4r0ZBqyKYZZmSGJEmhxCKCcQ/9CbRY7TSz7UaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TxI9CzGsekMh9uJyIWrl9SQcaB+CJ06ve7qnToojUQ=;
 b=HPEuksQk8Hb5DQOrVXqxSlgzY1a1cMQQkkoNwCg0iyozo5NIOesp3iyxt+B+h7ojJTd4adxwxlXvUJBbr4b2Rely2r3FjT8E885moLwAX+IXw6+46zagQEA7MC8JGP0SKoVIDT5IFYloR7uxo/SZIEoH+Cimx66UghB4nm1SkHgKWI3GvV+2UlvfpBnsrk6AxLcochXosoSSX5Tixe5kZSCBkc3GIM6Alsi9kZLIP6mZji/UdKPKWsd6l8lwG2KUdajS99eFbBAQoCuccaJ2nFiBygqyyzpzzQY5xkIsKIMav32e2mw7Iq0JTDTEAxS+JfDq7l6hNE0ubqpyQuBM7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TxI9CzGsekMh9uJyIWrl9SQcaB+CJ06ve7qnToojUQ=;
 b=zJUwy38N/gXJaTo4DTLmOUMrKfQsZIw4JzVXLROus+NrWP3r7ULrwn9Y07+eg1G1BZKOWy0oAfS2+ARO3tT4wReLk5i3mYgo3o3LNOB2u/p+oaNeYFaLYVfEbx9/P/apkV3YWVGERtV+6++e98hpFiyRS/nbPfE+yo9vjk611Nro8HCIJkPnF8CNN+kSzspXkTR4n10o9n5ucBIquwuK1OnQg/9+80atIqf+iDEUhO62wwOlQIBpi3E1/G0EMsJ0zoyPrjxIjNqYVBWVfJRhZQC+CINso9bzNGS2aZyFZZ5CbwrSY2NemSWCDlqsUnh/RzHylqV6CbgHzlU726qF1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by SEYPR03MB7461.apcprd03.prod.outlook.com (2603:1096:101:147::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Tue, 24 Sep
 2024 10:27:37 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca%7]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 10:27:37 +0000
Message-ID: <e458a1c6-5e85-4ecd-a21a-3407a6dd832b@amlogic.com>
Date: Tue, 24 Sep 2024 18:27:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: meson: pll: Update the meson_clk_pll_init execution
 judgment logic
To: Jerome Brunet <jbrunet@baylibre.com>,
 Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240920-optimize_pll_flag-v1-1-c90d84a80a51@amlogic.com>
 <1jy13hxwp2.fsf@starbuckisacylon.baylibre.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <1jy13hxwp2.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR01CA0123.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::15) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|SEYPR03MB7461:EE_
X-MS-Office365-Filtering-Correlation-Id: b2e028ed-0913-42cc-b0bf-08dcdc8382b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nm1mc2xZSXJCNFZHVmJlSXdXNFNxbXA5WmhUZFVjakMvc2dVdXZQbnRQVXZv?=
 =?utf-8?B?Q1VjVG1rZStIbDllWWZMQVl4Yk9MRlpaUC9lbDc5Sm9abytVWXJKNlBoeXp2?=
 =?utf-8?B?R1FlN1VrVFVuUHEwMDRVUExpd1BqZlBaWWMzeHhEcWEySmVGSTgxS0s5ekpQ?=
 =?utf-8?B?ZW0yc012YlRnRGFjQnhJdUVNeCtIa2l4Ym42bGdpSUVxUUNvVWQ3aG5GRlJ5?=
 =?utf-8?B?NlIxNnBmdjZpZjRXNDcxVHYwNGdZRkhzWlNFcGQrNjEvSS9xNmhxaVNYMTlO?=
 =?utf-8?B?WHhSVnNTRTNxQ3JyS0h2Ky94YkdBakNPbHJJVlkweUlLZWJOdERzbk1QME56?=
 =?utf-8?B?Y1VpNExkTlNPbzlHT1Q1aXB6QytEQmVsbi9pNVZJQVlqNjVCVU9yYk1tZVZl?=
 =?utf-8?B?bTJsbzE1NzA1MS9GV0RBSmFvL2I3Z2NaWkxUbnVzRGNwM25Hc25WT1hwU0JI?=
 =?utf-8?B?dGRLVkFpM3NmdkRPYlN3TUlhQ0tJYjZValFtUlBLT3NISEozOGJtc3hTSXZt?=
 =?utf-8?B?UEh3UC9jWDFRcnF4Si9YN0JuYTkyeHRPVElwckRrbVZkZVROdTh4WkJyMFcr?=
 =?utf-8?B?ZkZWclV0ck5SYU0wWWZoVWVMLzBPbThFU1BXNHplUGtPekhmQ1psZkEwSW94?=
 =?utf-8?B?QUZSblVvemhNR0lnRW95ejNBbEVZNnhZU20yUU1ZSW1NVlJFTnV2dUM4ZWxv?=
 =?utf-8?B?NUJzTGxKS3FkK3FTVm41U1hhM2g1TmxMbzFDTGFwWXkxTEFTRnFod21PWWNY?=
 =?utf-8?B?dit6UkU1azZOaUIrb2x6aE96WjYrNkJvNm54L2JCTHplUlZFd2JVU09NZEMz?=
 =?utf-8?B?RWZGcVZieEFoZm5hZ242Q3lwaS9lbyt3YkJyWnB2Zm9tNFU1Ujd3NkRCRFJu?=
 =?utf-8?B?RUd0VUlzU1JCU0FTR3VOcnJld0FrZm5lREN3bDN3RkFEQ21wRGdQdHNHTnFP?=
 =?utf-8?B?YmJRQnZIVWJkTU9jS2k3QkhLeWJ5TzRhRzM0ckI1RFNrd1JvWis2dFk5TnFM?=
 =?utf-8?B?VGFKdUU4bk4ySFJNb0s5cUVxd05XS2FLYWNoNWRUeXJjditSMGl2YlNXZE9z?=
 =?utf-8?B?aTFqeGlaaGdaUG55QXU3dG4yS2wxMlg1ZU92Rjk2eFV4Y0tydnJtZ2IyeWhs?=
 =?utf-8?B?S1o2NVFybGREL0ZPZTlXcGhIbkJpclZRR1dIbTB5QkFsMGVyNlJuM3M4RkhF?=
 =?utf-8?B?VWFTSVFuZGhROVlsUjI5d0dUcEI1czJ3QS9rb2NQVmRGRnZXWUl5TG9wWWZ5?=
 =?utf-8?B?VzMyaU1jKzBtMHkwY1ZEcHltenRuS2oyYmpoeUU5TktFc3Y0aVVHUmU0cy94?=
 =?utf-8?B?VlptRjhuR0VEMHM1RlpSZ1JmanJKOWczclE3anNYc0Zza3YyZXk5RFVKK21m?=
 =?utf-8?B?cUQwZUpTa3hJQUxXcDAreHk1RmoxS2tpeUl2Uk9KaW1pTTJZRWtOVWtxNlI0?=
 =?utf-8?B?UTg3akE1b0M4Z0p4L2dWQldUYUVUQjhwcDNOa2FvNDgvd3NqTzdKeVVFeDB5?=
 =?utf-8?B?TlMxSVVScW1wOWVydGg2di9CaVI2UmdYdHpJMFFwRDE0R1RRQXhPQ3VMNW11?=
 =?utf-8?B?NTBkMmNTaTdhUFllT09uNFRGSFRrclJhbXJqNXBCQ3A2NWEzejAvNXkzWE5x?=
 =?utf-8?B?RkNQNHhWUTRUN0ZVaEQxNlkzUHVxSEV1MXo4N2JYcnBUaXBNbnFtaGZUNkV1?=
 =?utf-8?B?NjBKV0xMaHEvSXZUOEFCejVYYjA2aXp2dHFSZlJaU1ZBTVhxRVpVYmFRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3RmZjkwemtrU2tnU3pSYU50ZjVHSk0vNHRla2tqSjlJTGl6TXRnRU1rRlJN?=
 =?utf-8?B?TXR2WHBBMGk0d2FiWDRXOWZ2MG0yWXhKTUd0eWRqUWpPZDlsTURXZzJOdW9z?=
 =?utf-8?B?NjlzZGVKV0FrQVM5dkU1YmtMbzlNREtibWdVbXdiVEJUUWhPREpaZFhNd0t0?=
 =?utf-8?B?OTVNcnF3RE5oK1BIRGsxVzVSZ0tvd0tjTnZqR2xNZmJodXg4T2NsN0NjdHdI?=
 =?utf-8?B?SmhyWjY3MVlXTldRdjJlaHpzZGo3bmJTSFFqSmZJc1lKQnJqeVN6dVhEZmlU?=
 =?utf-8?B?OS9iaEtGOWVGdGtjUTJ5MDlDN1Z2Wlo3SGp4bUh5ZjJId2hpdVVDSDhEaFRs?=
 =?utf-8?B?RW41d3NNZGJRa3ZaREE0ZXcvS1I0cHFYbndyLzU5eDdsd2JUdWNGWEJvUWha?=
 =?utf-8?B?RE8zMDVIUXNyZm40a3M0Vi9lR1BDUUlkOGJKOTF6UkZ1MUdNcnFpT1JUcFNR?=
 =?utf-8?B?Ty8xVStXUmZWaU9BRVo5ejdXV2RvRXd1bWdDeE1jd2RzL2NEakM4d2cyV0F0?=
 =?utf-8?B?Zi9XT1JITlQwWkdqZm80MUxvMUxETGJKTDN2cFJEUWJtRjJZMTYvZ29LT0Np?=
 =?utf-8?B?L1c4OFpkV1YzalJCRWhWRDNzMlFMdFYwUXlZNTRMUzJHUGxyeTYvR2VocUpS?=
 =?utf-8?B?M2hqYlFjeEhaOW9hNEtaR1FEWlBkamdING5LaURsbkNtODdhNWxMS0NxQXhk?=
 =?utf-8?B?OERsQUhtMW0rL1IrRW1KVVora1gyd2o1K3ozWW1ydU5tUjBObU1lbmZBT0NY?=
 =?utf-8?B?TzZibmVIdTU2YmF5SjNmY1dtc2FMWmIzVGorZGN6SDJxb1dNQ3pQUnRJZlNS?=
 =?utf-8?B?QVMzWjQrbHBZOHpaanU0VzkyZHBJbHMzbnJVYVZIVWlIbmQ5OWlmMHlKUEhQ?=
 =?utf-8?B?NXU3L3hOUG14alBaU21MbDJQc202V2NUem5NNFBOejZMVXhQWXliYm1TQzdC?=
 =?utf-8?B?aDJiWXAvNzdBU3BBOXlySzFjRFYybTgzcElnY2xRWmgyM1E3UUc2S3grNGlq?=
 =?utf-8?B?U2lSckdtMmpXUzF6aDdQNzg1UHUzcllTaWR6dDhFejdxVzE3VGRjL1BtRnMz?=
 =?utf-8?B?MEJFWFdMejZkeUlOMGlXaThRelNXcEJKWjZkNFIrZC9NUUJUdFNiTDlVa000?=
 =?utf-8?B?N3RIQU9XaHhmaVAweGROMzBhSTl4MStPa21MZXlwcmErWU91ZlVRSExJQ0xx?=
 =?utf-8?B?MzMvYmRNODVhRlFMMS9iSldLU2FUYk9vL01pYlExbzRSRGtXdnlKbTB0ZkZM?=
 =?utf-8?B?NzU3MEtKbjB0WXBmT2tENmdiWEhoV1hVdldrcFlXZFNERWg2NW1WdDhmZ1hR?=
 =?utf-8?B?MzBYNndaaVpXbnN1Skl6STM0M0JrUW40YkJsRTFzS0hrZEM1aE9SNzRWTTNN?=
 =?utf-8?B?Z0REUzZiL29jUG82V0x0aHVkN0phdFlaUE9id0QrQnRDeTVBNG5uTW41b3VO?=
 =?utf-8?B?cWQzNC90UFN6SEZtc2xoYXZLQWl1Z1ZXU3ViN3ltVElJNnJYK3pTTHdoa3hy?=
 =?utf-8?B?RnlHT0wzNWJyc1QrNENYMGdTdUJRSGNaaWZlVkk5T1ZDaFhKK2F6WGpnbkFh?=
 =?utf-8?B?RmlqeUpLTFVKRnc4WHRxWHUxY2hEMmFheWVvQ0pIUWZjVmVwWk5mNGszakJ6?=
 =?utf-8?B?Vm1LZkpxRkdoWUZHSXNvL042RkRzcG0xL1doZDM1TnBxVVRvMGVRQ2NJbGl1?=
 =?utf-8?B?RGNtZFROSjY0RUdJQ24yMmF6KzhGbjFkQ1FiR1hYcjhzKy9BWnltQjBHQjBp?=
 =?utf-8?B?QU1ObUVzYW4vc3p3b0drRjhsVkhuLzRmUmJyRmd5L1BSb2QxaGs1TjhWOFVW?=
 =?utf-8?B?amFsTEdUUmVSOGo3eWdqK1o3K1A5WEl2OHdxanp6bnAvaHlQZFZIS2RZZHJ5?=
 =?utf-8?B?U2FJTEx0Q0M3MGhpRkhreFdaeVp1eVUvbE1McXNvQ2FrZ2xZdVArVDAvYUpM?=
 =?utf-8?B?bzVCOE9iQi8ySnFHS3ZoUzJKckd5cmpSckpSSUxSTWdudndTTUlFVDllZytU?=
 =?utf-8?B?Yk95T1VVdkMreFU4NUNPNThRclFSNnhJNWdMc1gyUlhwN1ZtUmtrOUhzbE5E?=
 =?utf-8?B?emg4ZE9qbzV2S3BpNzFrTDJFZGRhR2IrOTdRUlhpTXEydDkyc0RBR29GQXUz?=
 =?utf-8?Q?znnb/c5HE/oUiVbxT+awz7a0I?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e028ed-0913-42cc-b0bf-08dcdc8382b4
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 10:27:37.3221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4W+aOPykIDGUwC0lU6sZtP3uPoPRz4z8gcb4DSf52C2pLr+JF/oRaay1M8nS2mNFmcbh8VMnN/ayx7gyTclTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7461


On 2024/9/24 16:50, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
>
> On Fri 20 Sep 2024 at 16:13, Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org> wrote:
>
>> From: Chuan Liu <chuan.liu@amlogic.com>
>>
>> The hardware property of PLL determines that PLL can only be enabled
>> after PLL has been initialized. If PLL is not initialized, the
>> corresponding lock bit will not be set to 1, resulting in
>> meson_clk_pll_is_enabled() returning "false".
>>
>> Therefore, if PLL is already enabled, there is no need to repeat
>> initialization, and the judgment "CLK_MESON_PLL_NOINIT_ENABLED" in
>> meson_clk_pll_init() appears redundant.
> Apparently you messed something up with b4 ...


emmmm... I'm not familiar with this tool😂


>> ---
>> The hardware property of PLL determines that PLL can only be enabled
>> after PLL has been initialized. If PLL is not initialized, the
>> corresponding lock bit will not be set to 1, resulting in
>> meson_clk_pll_is_enabled() returning "false".
>>
>> Therefore, if PLL is already enabled, there is no need to repeat
>> initialization, and the judgment "CLK_MESON_PLL_NOINIT_ENABLED" in
>> meson_clk_pll_init() appears redundant.


You have a point, but we do get this kind of situation all the time:

For example, hifi_pll provides a clock for audio, which needs to be 
configured

in the bootloader phase in order to play audio as soon as possible after 
boot.

After entering the kernel, the hifi_pll frequency may be dynamically 
adjusted

(to match the audio bit rate/audio and video synchronization, etc.). The 
gp_pll

that provides the clock for eMMC and the hdmi_pll that provides the 
clock for

HDMI are all configured during the bootloader phase and cannot be configured

as RO in the kernel.


My idea is to still describe the init_regs information in the kernel in 
the driver:

1) If the bootloader is not enabled, the PLL will be judged as unused 
during the

bootloader phase, and then enter the kernel for initialization.

2) If the bootloader has enabled PLL, in order to ensure clock 
continuity after

entering the kernel, it will not repeat initialization 
(re-initialization may cause the

module that references PLL to work abnormally).

Can the coupling between bootloader and kernel be avoided on the premise of

ensuring functional integrity.


> If the PLL is enabled, it has been initiallized, to some extent
> yes. However we have no idea what the setting was. In general, I really
> don't like inheriting settings from bootloader. It brings all sorts of
> issues depending on the bootloader origin and version used by the
> specific platform.
>
> So in general a PLL should be re-initialized when possible. When it is
> not possible, in most case it means the PLL should be RO and linux
> should just use it.
>
> Someone brought a specific case in between, where they needed to keep
> the PLL on boot, but still be able to relock it later on. The flag
> properly identify those PLLs. Much like CLK_IS_CRITICAL or
> CLK_IGNORE_UNUSED, each usage shall be properly documented.
>
>> In actual application scenarios, PLL configuration is determined during
>> the bootloader phase. If PLL has been configured during the bootloader
>> phase, you need to add a flag to the kernel to avoid PLL
>> re-initialization, which will increase the coupling between the kernel
>> and the bootloader.
> The vast majority of those PLL should be RO then.
> If you can relock it, you should be able to re-init it as well.


re-init may cause glitch in the PLL, which affects module work at later 
PLL levels.


>> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>> ---
>>   drivers/clk/meson/clk-pll.c | 3 +--
>>   drivers/clk/meson/clk-pll.h | 1 -
>>   2 files changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
>> index 89f0f04a16ab..8df2add40b57 100644
>> --- a/drivers/clk/meson/clk-pll.c
>> +++ b/drivers/clk/meson/clk-pll.c
>> @@ -316,8 +316,7 @@ static int meson_clk_pll_init(struct clk_hw *hw)
>>         * Keep the clock running, which was already initialized and enabled
>>         * from the bootloader stage, to avoid any glitches.
>>         */
>> -     if ((pll->flags & CLK_MESON_PLL_NOINIT_ENABLED) &&
>> -         meson_clk_pll_is_enabled(hw))
>> +     if (meson_clk_pll_is_enabled(hw))
>>                return 0;
> I'm not OK with this.
>
>>        if (pll->init_count) {
>> diff --git a/drivers/clk/meson/clk-pll.h b/drivers/clk/meson/clk-pll.h
>> index 949157fb7bf5..cccbf52808b1 100644
>> --- a/drivers/clk/meson/clk-pll.h
>> +++ b/drivers/clk/meson/clk-pll.h
>> @@ -28,7 +28,6 @@ struct pll_mult_range {
>>        }
>>
>>   #define CLK_MESON_PLL_ROUND_CLOSEST  BIT(0)
>> -#define CLK_MESON_PLL_NOINIT_ENABLED BIT(1)
>>
>>   struct meson_clk_pll_data {
>>        struct parm en;
>>
>> ---
>> base-commit: 0ef513560b53d499c824b77220c537eafe1df90d
>> change-id: 20240918-optimize_pll_flag-678a88d23f82
>>
>> Best regards,
> --
> Jerome

