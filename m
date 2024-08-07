Return-Path: <linux-kernel+bounces-277205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67726949DD6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 04:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 259A6283464
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 02:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892172119;
	Wed,  7 Aug 2024 02:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="OertJyA6"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2128.outbound.protection.outlook.com [40.107.255.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788162AD02;
	Wed,  7 Aug 2024 02:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722998242; cv=fail; b=ZWvtqx0beLGDEJ4iWJxKMkNoQfTn4QsXJNsj4dUf4Rnd5082BDlB9n1LEnMPTe+kHk0vzGmUI/wU/7VPNgzmMVd06FBeU0EdzKgBYbiZfWRVZD2gdqOsp4tHwtWN/EA4DuYvul1Y0++xSLaGeL07nulYhV8UqlTSQnh69UN86wI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722998242; c=relaxed/simple;
	bh=6wLaSlGQkclz9GAly8CKRpiSuVr2L6IjMfJxJYM3jiQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KjEj8/ZkadglJONf/rJXFP706A6grdvNXKyMHj3kCdpTDHF8H4Jrlgo3k+jU7uWgtAePper08XPJyYGozrfldxAoWXgMLuO9QmSv96D0esaPGWhHuAKWqw+jYlvb+smVaPpKLjqSFwKSvAJFbREgu1WoBw9ZaOOKnjM8fScD/EE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=OertJyA6; arc=fail smtp.client-ip=40.107.255.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9adGnfaQzDLLUugGbufoe7j1mnpaLpSc8j/lDAEi1mFrP0LcdIBWVGizp0rMjPCUAwYFgZ59iNDnraTxl4D6ozOWl5IPAOijQ7FzhbhM1KVIoBZvH9KIKUtA3T7Notxxm6U1LtFS9xa2iIIEDrGn1foTpgm4b3RmjuLuklQdT6jLlha6h/zOKqhKoQJ1A6Pd8G22gLdiLtdqvLhhvxBMnLE/Wtb1P5ptNOnIYikmmwp9qAHk+JTrETSvyshpqltPXSlVQJ91SnW3LC6qQ2onFAcHZSUjgttdBhIycgZBvIKBIptxJZt9VhizjnnkTsUZx2XDw79fnizRVY4vMzU+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwQYbVpqNT+clF56x6sYrJaBUonOtMNk+EMNgI814Vs=;
 b=AmyPXpscNXdqJmNY7k3FI4mddw7Utw7WVewjEcPttY3298jKE73KO2KFNfPBbCXYrUiI1NH8lNhzzm+YiIflPhLj58Fe5FQ9VzydHCZ80DmB4iqTcV35iQsGd9z/9HPGUf+G4GWKU5k3q/2uFBufLVWMGfP/bZonaqpjN7FMd5IMg0Q1ZefYn37FKJuSbCJz6ZSyKX7rrT7BRcYTT4OrmSQt5RFUxq8wfAWeoKTosT8t1I5W+8uhg0/zRtewZy27iIdEZwLui2WdctsBwNjV/gZJHeeZ4E17EKjAqHVUUROY9VMSS5hZdEDxYfeM6WM7FA0R4BiWnwltb63v+XTdow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwQYbVpqNT+clF56x6sYrJaBUonOtMNk+EMNgI814Vs=;
 b=OertJyA6NswvwroPSL1Y48igOJ0G0L0qn/TP85N17mTL3A3deI72QVn8ZuhYee0YyLmRqL6iUm5nLcYlSAHpHNTEKlKzbZMPUBvuGYR9JxennJV59WPM/I0SR1+z12PQWQxbkcNp8dsjzhk3vupF970A8xeVAkOuCIDouWKzgSD4IPpUkxTez+kRJLu8p04TthZu1q1fcs4xEpN6wxJsnT3C+W7z5xD9njIkONkzI07zn+GbVROhkcHsvPsMBtScJVvGmFAZAOorwAuFYQz7u3sCbLCLmwKSYCrSEkLLvAnYnXXxCx0e26fc4YZdqXLsCZo5RVnn07ShKtFuFcLf8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TY0PR03MB6630.apcprd03.prod.outlook.com (2603:1096:400:207::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 02:37:17 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%4]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 02:37:17 +0000
Message-ID: <59f37c77-d57b-4568-ad9e-6d50791ae5f7@amlogic.com>
Date: Wed, 7 Aug 2024 10:37:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: amlogic: add C3 AW419 board
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chuan Liu <chuan.liu@amlogic.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240806-c3_add_node-v1-0-c0de41341632@amlogic.com>
 <20240806-c3_add_node-v1-3-c0de41341632@amlogic.com>
 <c82b6e70-8f2f-4b37-9186-7c49aea019bd@kernel.org>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <c82b6e70-8f2f-4b37-9186-7c49aea019bd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:196::14) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|TY0PR03MB6630:EE_
X-MS-Office365-Filtering-Correlation-Id: 92209d72-60a5-4894-6dfb-08dcb689da17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aldDRS83dm11YWFMLytGcnNLY2syWkpyMVRES3QzbklJT2gyTE1jRGdSU2pT?=
 =?utf-8?B?UDliVFZ4djNLU09IREp1djVmd2tYUVYvelM1aEphOUMwVFJlUmdQQ3o5Y2Fz?=
 =?utf-8?B?VklLeW1SMEdkLzR4Ri94czJVbnRRckxtMEI0cENkU0tDdThYUnNpc2QyaDNx?=
 =?utf-8?B?elpRYzdnS2NoUVBpTUdyckhrMnJNbXV6Mko2SHl4cmhEMTlXTVc1eG1hOTM1?=
 =?utf-8?B?OGcwNFlab1Q4OE0rZHBwWlNxUGNtdDZ1Z21nMmZXdk0wQkRKTlNmQUFNVnhR?=
 =?utf-8?B?UnRzdnZud1dza0h4bWVhOUV6ekZ2NnFOcTlvZitOSXgza1lQc3VRZEN5Wmtj?=
 =?utf-8?B?cGhON1RnT0R3K3k4VmpwcjJhUkxmOHc2REZOeEdCcGpFL0ZlaCtTT2lhRkxa?=
 =?utf-8?B?VFRTcXdzUld1WGNQTXo5dzNFUy9WNnluSVlrOXlKL1VrQnYzdC9HVjNSV05X?=
 =?utf-8?B?V0tiaWhZY05nMmgzZkNzdkh4bWlFd0V1MWVQME8waGhxRm1JZklyRkNoWlpi?=
 =?utf-8?B?dk1SZXg5V2IrMlZSZWlwTDVwc1ZEMVRaNEphbGJiNzVQZ001aVJZN3ZLeTlK?=
 =?utf-8?B?a3BKbTdDSHdRNVl2bXBXSXNWcm9qOHlQYXFvalh1bnFMMXZ0dWtTUlo0QUZl?=
 =?utf-8?B?Wld6a3N5RXlCRjB4WVZmWkRhUjhPRW5IZmh2U09LUEl6a3ZZdFE5ZzRjSU1S?=
 =?utf-8?B?U2N4djVrU0E3d3JUYTI3bmJGc1p4VXlYQm5NQW9OWjdYYVZvS01YcmpQbGJw?=
 =?utf-8?B?WXptVEJRQmtHUzdOb2V4TkdZTUJZMi9iOTROL0V1U0xWOUtyYmVMVnhVMXhk?=
 =?utf-8?B?aVdFYVUzSUlrOGZRZWJPbEk1d1dzdDZaNkw5VjdOeTRjeDRVV2g5OGI1UXNZ?=
 =?utf-8?B?OW1MdFdTRlRjQ0VtQk5IajY1Nm9OYVVEWU1XRDAzcStCWDZVMHdWcXFSQmNY?=
 =?utf-8?B?b29KODBVN1kxdGozd3A2ckNRMmIxWGh4VVpPdHRVdmplS2szWmFpUy9GVi9i?=
 =?utf-8?B?YWFRMU9kSEFjaFplaWNJVGNxNTkxbGozK1VUbEFvNDVPZkpoMHpUS1oxQ1Uz?=
 =?utf-8?B?QklUQnhTbFcwY1NRZm84aHNEMGRqa3BpRTg2SXdLY0ZuN0JPWFJLSEdFd3Y0?=
 =?utf-8?B?eG1ONFhoK0Mra0hLMEVOL2IwNUJxSW1PTDcrWi8rZ0F4bVNNMVh3M2xrZ29K?=
 =?utf-8?B?bFNFOXdUZDk4eUc3dHJySFlLdWJ0ZDJCNHdGVWVuL0ZqdGpYa0tJM0QxRDMz?=
 =?utf-8?B?Ulh2TmZrSnppL1BJZmI4cUdPTzNzN0lzRDlvY3pDK25hS0xtTVJzQ2JNc1NN?=
 =?utf-8?B?NUEwUGZSelloUi9UblI5V2krUXZzMHArbVJ5ZUc5bFRmbWl0dkpleUE2bmZl?=
 =?utf-8?B?TnJURHFLeDRzVTBwd0QvSHFKc2NmS3ZxUjRHWHJRU0ZrQXdyWnBuaGl1NnBZ?=
 =?utf-8?B?REM0RGJ5K1U2L0tJZ3p4UXl1Q1EwbnR6QTRBV1h0MkxXOW4xMVFMT1JocFhp?=
 =?utf-8?B?U09ONGJtaWRrVnF4NGsrNlBvaFVCMloydzJML3hZekQrY0dRUTJhb2tJODlJ?=
 =?utf-8?B?dG1rUE1OR29XUUtoSTF6cWdObllaV1Q5eUIzR1N1NE0rbkZycC9IaExhdlJO?=
 =?utf-8?B?cGpzalBaZysrdmlzUzM1M1FsZGRESVdtSm5DMnlaRzZLMC93Y2JtK3dHRGdQ?=
 =?utf-8?B?WU9qbUtTSE5uei9vQUovTzk0a01uVkpXeGxmcmU0ZTV3WU05SVhmbm5ES0NY?=
 =?utf-8?B?ajJ0SVBPTndESTRMcWNRZmhRN3MyY2dKeC9kc0E4ZC9GWWJuS0YrVG1SenlB?=
 =?utf-8?B?NmMxaDZCSXI3eGcxaTlrK1NtdmpLWVlZd25uZWx5eTBQcXV2TE83eWExd2I5?=
 =?utf-8?Q?VMJid0yHwlrYb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qld5UStFQVB0Ujc1aGd1cTl4dDNPOVRiQjFXRC9JKzVsQ3dYRjB0ZTcvTUt1?=
 =?utf-8?B?ZHFuTkpwdE1DRlpwZHRmcFVIWk13SXlOdzJxYWxDcE8ycUdRN3J2eVhMN1FM?=
 =?utf-8?B?dmVIa3ozL3dCbk53QkdaZ0I5M0xzZnNKWEg1d2wwa2FYWWJYVks2bUhmbWZw?=
 =?utf-8?B?MkhiUm8zamo3ZXlPY0pqVTlMZGI4L2laUU0zanhKcWFpVE03K2p0SzlKaGVY?=
 =?utf-8?B?VTZ5di9UQUhhYmRmOXZGcytpK29XN1FJb0pNSzloM21kK3pOeTlQVG1Lbzk0?=
 =?utf-8?B?M1FrU2dES1R3UnR0Z2kzMmttS090YnJncUZJbGVGTmhtUk1FRG9MbDlDVXZh?=
 =?utf-8?B?eHVqTWV0QnlNUE9sazZpWSszN2t6REQ0RWozSFNFQjVQUkdseHhsaE1JUnJZ?=
 =?utf-8?B?WEEveHZKMGxSUnJrZlBoWUdVZ2xQSnh0RzJQK1dXWk1EaXdJSGRVeHEybjVo?=
 =?utf-8?B?ZFNKT29tNktQdXBCazBiWFFldlBRbUNnRVRDQlJFMUNMdGFqZVlSbGJsUVBv?=
 =?utf-8?B?SU9oMkNwdFJWZnVEcnF2OWtKYVJIOGJRck40RXNtQjM0SXlVWGZjMHBibExa?=
 =?utf-8?B?bmtqTXJYRDNnQ0FRLy9QdFE3RDE4S1FRQmYyNnQwZnZZWnBGOXl3YUU4L05X?=
 =?utf-8?B?TFhBb3gwWG9PdjdBNlRoc2ZiYjNwdnRuQ3NPV09oYjZWQVVta2E3Z2JwNHlY?=
 =?utf-8?B?SS9sTWxnbnJXa0xPRERERVByb0EycVhNUEs0WWxoUTYrQUI4dXF1M2FkUW9J?=
 =?utf-8?B?K2ZoZmJOdituTVFsUnFUZG5FK2FwTWZueWZjd2tPdDhVQlByNmlUQXQ3MHMv?=
 =?utf-8?B?R1J1aHpBOU9kbzNaVy9wczVYNkJVcVpCOThReGdpTGVTTkVSUkcyWnRmYmE3?=
 =?utf-8?B?ejNtNDhzdTJRZUJGaXJzS2ZyT0xWUHlrQ3FqbVJBdXNUaFdTVVo2V2NXUzVt?=
 =?utf-8?B?dXlsNzZSbklPRHZrRGxZM3gzSGtZd3lJMHlLdGxNRlVqT0szcGdiTitxR1dx?=
 =?utf-8?B?R214OGcvU3RuM2NBS2R6OTRwYmI1UHJMOEJrdmdnbDFNcHdGSE9abGhFc0ll?=
 =?utf-8?B?N2pPZnd0OVVuVWpLUmtLSEtKV0ZDbTJKdHVoc1pjTitYTGpRK0RKT0ZNNnRr?=
 =?utf-8?B?ekRMWTNLQi85MXBCT3FsR1VLU29Cb2tNcEZsa2Y2dXRNOC9qcHNsVmVyR1hm?=
 =?utf-8?B?R1hWSm1CL2xTQ1htTnJ5aHJKMTFWeGZwSVpZeThWc1UxNWw5bmZrUGxWSkhp?=
 =?utf-8?B?MUJYNWRhVml2alUrdU9mMTJUQjhiaFNEOFlpcW5RQVhmREw1cW55QUh1NmJ2?=
 =?utf-8?B?eTNDQTVLQ2UvY29WRlI3TW1kV2gvMFkvQTN6SldCdGw0UWtzQjBJRFJtUnRN?=
 =?utf-8?B?aXhrNnF3dE44KzlVTlFRVmNWWkRTb3ZUOFlPSTY4d094bWNCTlptV041aHEx?=
 =?utf-8?B?dTdYNnI1VWFQdkx2WnlYZWI0ZkFkSTJaNGtGUWpPc1ZXS0hwSEZDY2JVclhq?=
 =?utf-8?B?Rngwa0RseFhBeFMrNGc4YTQxMEE1M3cxb3N2YVZlUlovWnphVms1bVZYamNF?=
 =?utf-8?B?clZHY2lwSWYxVks4czRsYUM3YTJVaEtOVGFLcVJKbEJ3VHJhMGRGZ3FoaG01?=
 =?utf-8?B?aUFBMkhNT0c0T09PN1NMQjM3dm8vU1dPS1hKSlNYckJZaDJBM1NQTHBYb3ho?=
 =?utf-8?B?WXF5YmNGVHhmSmhpUmhyZjViV0tZL1c2NXMzMHpNQ0RrVDJSb3c5dnh6bFEz?=
 =?utf-8?B?aHkwNlF3U1RaU3NBdWp5c1drb3ZJNUE0aEpEaERZVDZtd2F3ZmFxUkc2SFJm?=
 =?utf-8?B?TXRZa1V6RFFMcjdKQW9GSTFCTk1pci8vbEw0Rjh0VUpVRFgrMUl0dzhhYnl6?=
 =?utf-8?B?Qjl4aUYzWkpYZlk4cis0eTcvWC8xT21pMHhJZVVOUVhKYXJpRS9ObHMyQnJX?=
 =?utf-8?B?aHk5ZlVtNjljS1VDckpmRkVpTzE3ZGdYSWc3QlFSeExoeEZaeDg5RGN5enZC?=
 =?utf-8?B?YkVLVlMzaEFySXhmNVprbEtlVzA3NjgvT05zT1ZZL0o2aWM2MWFGWktIaFdU?=
 =?utf-8?B?MFYxRVBpQXFMNWFEUHVaUnJUYnY0d0JJQlpiSmlldWxmdVlrS1JLOW15TWpm?=
 =?utf-8?B?QW1BUmc5MUcwc3hMdHRXU0Y3RkNHclUxdHJRZFlWUXEyanpUcy9tZjAvMkJT?=
 =?utf-8?B?Rmc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92209d72-60a5-4894-6dfb-08dcb689da17
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 02:37:17.1012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dJO28n1tbecqzwLiLKOjspjXhhjIVOKgXX+dJqxYZar4ClqX11oGFFy6rdPE/8rTgH740qRdZC+7qpfJrkejznKjp4BMiqcgMVEmkmmlheY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6630

Hi Krzysztof,
     Thanks for your reply.

On 2024/8/6 21:14, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 06/08/2024 12:27, Xianwei Zhao via B4 Relay wrote:
>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>
>> Add Amlogic C3 C308L AW419 board.
>>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>>   arch/arm64/boot/dts/amlogic/Makefile               |   1 +
>>   .../boot/dts/amlogic/amlogic-c3-c308l-aw419.dts    | 278 +++++++++++++++++++++
>>   2 files changed, 279 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
>> index 29417f04f886..2fbda8419c65 100644
>> --- a/arch/arm64/boot/dts/amlogic/Makefile
>> +++ b/arch/arm64/boot/dts/amlogic/Makefile
>> @@ -2,6 +2,7 @@
>>   dtb-$(CONFIG_ARCH_MESON) += amlogic-a4-a113l2-ba400.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += amlogic-a5-a113x2-av400.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += amlogic-c3-c302x-aw409.dtb
>> +dtb-$(CONFIG_ARCH_MESON) += amlogic-c3-c308l-aw419.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += amlogic-t7-a311d2-an400.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += amlogic-t7-a311d2-khadas-vim4.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-a1-ad401.dtb
>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3-c308l-aw419.dts b/arch/arm64/boot/dts/amlogic/amlogic-c3-c308l-aw419.dts
>> new file mode 100644
>> index 000000000000..d28fd2a1acf0
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-c3-c308l-aw419.dts
>> @@ -0,0 +1,278 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2024 Amlogic, Inc. All rights reserved.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "amlogic-c3.dtsi"
>> +
>> +/ {
>> +     model = "Amlogic C308l aw419 Development Board";
>> +     compatible = "amlogic,aw419", "amlogic,c3";
> 
> Where are the bindings? Why do you add bindings without boards? Or
> boards without bindings?
> 
The bindings of board aw419 was submitted with board aw409.
The commit number is cb3f4e8cacfa7b32ed8b9dff1282c0d4aaf42e88.
> Best regards,
> Krzysztof
> 

