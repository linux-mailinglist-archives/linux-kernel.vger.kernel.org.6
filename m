Return-Path: <linux-kernel+bounces-303698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35ED69613DF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AD691C234AA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EF21CB14E;
	Tue, 27 Aug 2024 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="aOEF43h5"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E23D2E62C;
	Tue, 27 Aug 2024 16:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724775664; cv=fail; b=CV9bGZ/Q42eP/mhp+BK83EuXsCOV5GQOXbhtEmSI1q9CGaLEV9xthEwP/SbK4b/rKcR5PLY8rAD3mUuLqicUhL4bo1aOc8XrMRjhYaNDx92lJ85+g3gfHjlo3/LHZ6M1YhHaGgoS9eRyq27F+343LpVVk3pCsgns8AqXoMy0oqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724775664; c=relaxed/simple;
	bh=y4BNyDdSa0qQdQOG/GJENGGFxoxCQvlw+EqxVcL8v54=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LE4JwobF3uOEmrl/4zvnEFxMVyL/jpSpk5khs4pyocGykCuKkz52XizSMq6DunjoE9gFkup7CO9U7UENJuUhNlkknrMGk9pvj2PhekRD9jJgXMgscZtoLjejb4IjGmgEJioZfTfuCAEbeLlXMdLZvnOAT/ziGglKLN7dy65mAhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=aOEF43h5; arc=fail smtp.client-ip=40.107.22.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PuVL5stRfy3HQowBTXmBcRTQXb9xirgT956L0sjGSq6qvpj+2EiyzaBapzAEnG7Bx/CDOld6OZS+Vf3EO1XNcVbQYTcBLhR33ruTR/qyhy2obNFNy2X5pFEg2GAnG+GoOVNhByBTp0PHctn27kGrbHBH8zXGpbwTKbksJKa8GDIeORyu3OazmqrOE3bN6lLiHIWIA/ULCXsfrv3CU6T+D/HBpPvq7hex8hEfDJ0tTtYmKlaPb/onzE4EliLKmU7SP39MxvwSQxTK0FSMegQ4doqalPKF80mbuZZzM695QLjAz9ffLy/9n1XYxVumPERRSq4XRYlR4uGiepqSGS/iFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21Rytj0DADbkI3+kqoT361OoBiBD26PXBiZRnJLj7qw=;
 b=sZID4Ln1s4zVF473lRlSzojBXJNKz0Y2zybshqgKJ6WdRgyG9vLK6hLU5ioK8khUuH3UiQn0nMzwjfgCzj+A0Ejt7nwzEXePPz3BwHttatHebVeMGPEVKLN1VzIHc03BPpuNA4OGpuhyFfPMyvfB6erhVojzMYHCa9T/9sNbVofxU9qCUGaeJtlV7I5cBHNjht8VOA1/EcbP4B4mB+3uNyJQfnCNHklIndmZINsJeUggyz5Cj9z0jlArpcMRD1SSYKkAuVGg8mc8pC1he8AS0ZaiLcG5Zy92D2Ih687eZcqv+uKhZR7pODJKxT4TuGM7mJ+Oy5r35Afev+ezKJ8eqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21Rytj0DADbkI3+kqoT361OoBiBD26PXBiZRnJLj7qw=;
 b=aOEF43h5TFWkdaaCyky3ULxZt67R8sOmhW7ycl1gc++V3Bg3qW3q45aV3S3zTFR11DLP/Gm/8ObgsWIULhU/Xbt6DWCYomGvIq2bV83fAtv+Jy+1wyOVdKPXSTVm2PEaGmMMGssTwvvXWjg/8LA7okFRTfDwCZqDNKVlA8yv5pKbKzZMIQPaIoV1Twcy4FAgRaO3qKp2wnpSJqltOI9pdsjXRyonJaZruE7sQ4JgHbGsVxkdlVxYt595ynl5q6xJxeSVKxUe/UPqbWUJEzpvc2Av/m7sprQYi7SoHV69iWo27HR0zUaDj/xXZV69mrEKwcBGHLJvVxtFA/8/81BIdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DBAPR10MB4140.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 16:20:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 16:20:57 +0000
Message-ID: <22f22118-58f0-4974-8327-736181c71aa7@siemens.com>
Date: Tue, 27 Aug 2024 18:20:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: ti: iot2050: Add overlays for M.2 used by
 firmware
To: Rob Herring <robh+dt@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Bao Cheng Su <baocheng.su@siemens.com>, Hua Qian Li <huaqian.li@siemens.com>
References: <cover.1724682539.git.jan.kiszka@siemens.com>
 <7062ec915ecd161f6c62952eb7c1cd5036785dba.1724682539.git.jan.kiszka@siemens.com>
 <CAL_JsqJ+czuiiBUEaPBn0E+=5intMsxr6D8c33BapAD2=n7jOg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAL_JsqJ+czuiiBUEaPBn0E+=5intMsxr6D8c33BapAD2=n7jOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DBAPR10MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a67dc2e-6887-4f7b-2b79-08dcc6b43bb4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2lyM3loYVIrZFpnSXpNSFdmUC81dTd0SW83OUhKYnc5S3NVcXhiVVNkd0Vj?=
 =?utf-8?B?VXhaQytaRmFKaTlYWkh4VEJwOWVrTVRQZlQ0MWtwYzZNWUxUbGNzMkt0VStl?=
 =?utf-8?B?b2ptM2M0ancxTjNubU4ydjBEYVc3OUlTY080MlRBUGhVZndwbXVBRmNYUGhr?=
 =?utf-8?B?bjI1WlErKzg0eHQzMUVXWU1vbEJvTDZrQ1VYTFllako3TCtoVkdrR3BNUG85?=
 =?utf-8?B?RitrM2JVcGlMajJ1QVo2WXdOaXZiYU9Uck5mb0ZLMXZ0TEJjQXI5N1RhaTdr?=
 =?utf-8?B?UVVEdWc4YXB0UzhRTlF3YUpaWGFKcEFXVzdUdTF0UTVoWWdlU0Nub3FvL285?=
 =?utf-8?B?T2lrdmVqNkk2NGljMGNBYzJvK3V0b1lpQkdWRDFBWjBjVlR2MDBVVXVLYi9q?=
 =?utf-8?B?SW1XTVllQzB3T0FlWFdJTUFKaldrTjB5VmFIRVpGOE1TenowVVBQRHZtcCtR?=
 =?utf-8?B?TklEUmhYSDB1UWgvL1hDTXR3WlRraWYzdHdYamlyc3RyTnNkSlhuczZ0SzZv?=
 =?utf-8?B?T2Rhczg4V0tySm94YVQrWnZSTjhzbFQxaWVJQ1hTeGFLTnRsTVltY2hxR0ow?=
 =?utf-8?B?M0tJVjA2NndTdFJQMXk4UEIzdUp4TDBTdStxbWN3eUxmM29BL2JOSTFGZFNK?=
 =?utf-8?B?SGRPdEVpK1dMMWt5SEtITFhrKzJ4c0F0OTBLL2JZVXVoV3hGL3g0OHc5am1L?=
 =?utf-8?B?MWd2SHg3eTVsOFlrcXhpTEFWVU8xalBvdGRMRkk4dmplTnJudmk4VlRSZG5H?=
 =?utf-8?B?VXExSGlhVWx6Vy8rQ1h3aHlzYTNoTkJPblFTU3pKWnJSVlhZanJsbWZiUDZj?=
 =?utf-8?B?dkFKMmN2VVlnV2xQa0tsN2NURG1qaGR0SFVQb0Qxem5RTWRHd0hlSnpPS2pY?=
 =?utf-8?B?SlFsd05hemVuMnRpdkxFT3JaMldWVnY5UCtweGxoUlBHM3ZWWkNoS0p2NFl6?=
 =?utf-8?B?YWpzS2FMQWNOejQ1ZEM5bmtlalFNOGpMaWpFTUVhcHo5U2gxNEttVmlxcXYx?=
 =?utf-8?B?ZWc2OTBjR1JFb1Z5S0tNZ2Fldi9nUGU2cVJyTTQ1SERibWo4Wk53K0FtKzQy?=
 =?utf-8?B?aWVVb2t2d1JITnZEQzJuT0h5bzZIL3J6TTAzTnhubWxqTGx2cWRQUGVWNmZO?=
 =?utf-8?B?QlJkVm8wb2REZCtEcmF3L2pKVDVjWDZwM1QxWVRxRGJOb3RKM1NZWFA5Qzc1?=
 =?utf-8?B?SUx5UGlUUlNnd0wrZU00bEZ4MlFIS0oyWEQ5SUtDQXhsTXp4QkNlZFZFK3ZX?=
 =?utf-8?B?WmkxaGNwQ09sMFA3ZUlETTUyWllZd1duUHhBaEx2c2xXNVNPTVR1T1lzS0tJ?=
 =?utf-8?B?d0ZjRitoVWZqVHR2UHp3WEVGT1dYM1FNU3l1WDRpRHdhSmo4N0ZmY2VhZTlr?=
 =?utf-8?B?TXFxc3NZcDlaUzI1TW1jc282RVhsS0Q5czB0K29wUkV0K004S0JIckVISnJP?=
 =?utf-8?B?TXltNlJ2cVlBd3d1QUdrT2RVSXBUNmR4ekxkcS84R0lDRWdteVNmU0htNVBz?=
 =?utf-8?B?K1N4R2dZZ2JZUUtDRWVock9TS0J2bHhyZTYwbW1rQ0MyVm50aWNCZDdqVjA5?=
 =?utf-8?B?a3pmMnYrUzVjZEw3SXEzY0VOVERjS3JheU80bEFKTjBIby9XbTN3aHVnNHZh?=
 =?utf-8?B?eW1rL2VhY3UwZVg3OHlxV2lPd095VXpSR1luMEJFejh3anErU25GdENKOUpM?=
 =?utf-8?B?OUlVVkNaeFJUemxNTUROajFFYU9XdFRwM0pGc2lZQjBGZk9FMlVRTGo4UlpW?=
 =?utf-8?B?NmJKQVh6dUtncEJlemxUZ2tIR21jakgvSnVGd2NBZ0NyeC9JVVFoaVF5Z3Vy?=
 =?utf-8?B?aFFXWENoQ2Y0elMrb1Jydz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bC93WjNqbHdCUUhZZ1VOd0labGRJVlp2UDlRWmt1RkVDSnl1d1Vuai9uNFh2?=
 =?utf-8?B?MUlQN1ZXMjdWQ1dPYVdpb1RLQ2lJVmR2RXlPT3FQRW44YjV2NDFXN2lGODNC?=
 =?utf-8?B?U3NNb0o5TXF5UVM4T1FRWEx5ek1zNXJLSFBsRkoxa2xqc3A1UDRINWxiL0ht?=
 =?utf-8?B?Y3BaL3BXZHZFRkk3WENsaHM3MlRIUGxwVVFuWCt1a2JyVzc3SUt0TjRGTEtI?=
 =?utf-8?B?WkcvMzRibkpsem91ZkZDTStCdnZQSHRtSmIrRnVJQ0Y2N21JakFSc0xHaC9O?=
 =?utf-8?B?ZExoeGVyaUtNNUJjMnhtV3RkK3FjMFI3UTFwS09wR3ZudkhTVnAyMHRqeWJ2?=
 =?utf-8?B?S0lrVnpSR2M2c0ZYV1NGck1HNW13cDB4aGE2VTdqWWRBY2U2K1J0REdBTGxS?=
 =?utf-8?B?WGhKak5OdUtHSzhjcmUxRWh6U09ZOGNhNzhrMUZhRkFxSFJSTndHbkYvb2Y0?=
 =?utf-8?B?TThndkxZRWdZRGF6My9RU1M0YytuRHhHYk1xTzBFMUhZU255dzkzbWVIdFJ2?=
 =?utf-8?B?Z3VpMnVxazltUlFjZjhoa1NiZGxjcTBTd2poN1QwazJMK1A0YmNabVE5M1JZ?=
 =?utf-8?B?Vk1DNW5aQUJ2bENCdnV0cTdRWTMwUlNBN3F6SlNxT2JUd2hKNHBwR0xFRzB4?=
 =?utf-8?B?Vm9KOUdlaEZzZWlkdFRKbGdCVWlHZWdPWFp4RzlXT1FNYUkxRmZGNDZwdWZ0?=
 =?utf-8?B?WENOWVBiNk1wMDYyd2FYMHUrQjZFZ2tjTWMrTHJLZk5NTDZkVTdVNm1uWFMw?=
 =?utf-8?B?eUk1Q3orSkFETGVmZnYzM2JIY0Q4VEV2NmRqOGpJU1hjQjYzMzhlOUd4R0wv?=
 =?utf-8?B?ZTh3TWhjRCt0YTcwYWdDOSszUUdBTmJFbmRpdFJKTmlYeWpNbUJNTmVEbnZq?=
 =?utf-8?B?NFY3dUkrS1BwV3J5enZmSElFb3lZV2pkMTlDT1VjMmRLZ3o0UzlIZ25vYmYv?=
 =?utf-8?B?VnZYSnBPcjZNY3I4dE9yancyTytIK0NQaVFuelZSYVMvSDdlT0lGS29VU1E1?=
 =?utf-8?B?QnQrZ1BtMnVxUGRWSEppTFEyc0lTeWswTDZYVWJmZmpXMVpuR3YrT01tUjZL?=
 =?utf-8?B?VDJoL1dDSHd4MXJ2TTNGRHNkc2tPNk0zdlV0QnJRUjRiNmhyd0ppWTZUV29O?=
 =?utf-8?B?SHpFN2ZoYlFZU0toSlVqaDdtQkhzNGdDaW0rT2RwaGxhYjZtUGJoQldKZ01K?=
 =?utf-8?B?T292MnRnQ3MvdG1rdFk4TnhhSGo3cmYvd1FnREpIaEJvWVJ3RGNZU0JWc05u?=
 =?utf-8?B?NjZZRTVZdmFRNy81U2wrZVpCOWRsRzIzSWNBRjVjc2dzUm5LQkNUalB1K3gy?=
 =?utf-8?B?WGJub29UTXdJWnBOOCs4ZkRndUNxOG1HMWxxTWM0Q0Z1U3VXMDF2UGViZ3d4?=
 =?utf-8?B?Vmg5ZnYxcng3UENLRHE2aTh6M3BZVlJsNk0wYVl5aTNKVU9Nb05TVEY3bWZ0?=
 =?utf-8?B?UWRyYXpBTUhzY21aaXlpUDRvaWR1SUZwSllpUFpadGxoVzJHeERGUGZJL21o?=
 =?utf-8?B?L2tXamJDVDlaOXhsVVREMWJxc0JCWWF4ai9teHo4SGRlV0I2aTl0VmcxRWgy?=
 =?utf-8?B?TjdsWTVsb0plWnlYVG51eXYzUzB0WE0weTBUN054WTJYdGJrMDk5bzRpWjNi?=
 =?utf-8?B?T1R0ZWpIamJlY09MM25NY3dUTXdqZ2V2OUFabEU5RzRsS2JUdFVUTGFpc0cv?=
 =?utf-8?B?UExJSVVLTENiUG5DRUtmSWY1ck1abXVzQy9UZk5JZWFHOU9VM3Q5VkpTMzkv?=
 =?utf-8?B?TTF6US9hbFl0SkZiT0V4Z05VZXFSdHRrS2UvTzJzZWZSVTVvTFVUMkR5ak9M?=
 =?utf-8?B?YktHdjJnSHlvL09JWVNNK0NvOWVTWVV1UGVoVXRPbFFsVUlIS1I3eTg1Z1Jl?=
 =?utf-8?B?QnBGYXhWQjZzUDYxMGhvdGlkZ3cvcGpmZ3RKT0NNdW5IRE1YZjhkNWJuakxX?=
 =?utf-8?B?b3VsSTgxMWVRbU1HM0tiL2RPZXVvNHFVbE5jY09PWlZCTlZKc3N4RTVzbnJ4?=
 =?utf-8?B?c2J3WlBEbVRyUnkzWFpKN2ltcVdTTTJwOWVyQ0llZkt0c256QzFUbzJ0RFV3?=
 =?utf-8?B?WHlqRUYwY2R0WktrYzRIOHhTb3B1MVRtdnhNSTZvYUNzQkRoK2V5em1XenV1?=
 =?utf-8?B?TExBUVA1YXd4aGlrYkZ2U1NHZUZja04yRzkvMmVmMVU3ejg3YmxCeVRDU0Zv?=
 =?utf-8?B?QUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a67dc2e-6887-4f7b-2b79-08dcc6b43bb4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 16:20:57.8643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKCTeS1atPBCtD3uX24tx7NOD3p6uqG0RXpIyYGakjycHf8fw3GbnE99TwuA1uNdkpomQRgW+yZCsdqNr9di5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4140

On 27.08.24 17:33, Rob Herring wrote:
> On Mon, Aug 26, 2024 at 9:29 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> To allow firmware to pick up all DTs from here, move the overlays that
>> are normally applied during DT fixup to the kernel source as well. Hook
>> then into the build nevertheless to ensure that regular checks are
>> performed.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  arch/arm64/boot/dts/ti/Makefile               |  2 +
>>  ...48-iot2050-advanced-m2-bkey-ekey-pcie.dtso | 27 +++++++++++
>>  ...-am6548-iot2050-advanced-m2-bkey-usb3.dtso | 47 +++++++++++++++++++
>>  3 files changed, 76 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie.dtso
>>  create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2-bkey-usb3.dtso
>>
>> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
>> index e20b27ddf901..f459af7fac0d 100644
>> --- a/arch/arm64/boot/dts/ti/Makefile
>> +++ b/arch/arm64/boot/dts/ti/Makefile
>> @@ -77,6 +77,8 @@ dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic.dtb
>>  dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic-pg2.dtb
>>  dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced.dtb
>>  dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-m2.dtb
>> +dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie.dtbo
>> +dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-m2-bkey-usb3.dtbo
> 
> You are missing applying these overlays to anything. That is a
> requirement for any overlay in the tree.

You mean apply for testing purposes? How, technically?

Or is that about actual usage by the kernel? I was sent here from a
U-Boot discussion where we would like to consume all DTS files from the
kernel [1]. In our case, the kernel will not use these overlays, the
firmware does, presenting the result to the kernel during runtime.

Jan

[1]
https://lore.kernel.org/u-boot/CAFA6WYNXgJkCX9-aoL5FGchAHGdV+ikTt4+pTJP-jZ_UJG8E6Q@mail.gmail.com/

-- 
Siemens AG, Technology
Linux Expert Center


