Return-Path: <linux-kernel+bounces-311218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A8D968635
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 245A81C2238D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36BB185949;
	Mon,  2 Sep 2024 11:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="keo4F3F7"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2139.outbound.protection.outlook.com [40.107.215.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC351428E0;
	Mon,  2 Sep 2024 11:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725276517; cv=fail; b=LlNRFIuuobu1XG+2FcPHRoUzU0vThJEO79jHNK+emuDsoNLsWA6UtzWMl6UQUj5H/dF4y2cA31kZk03Jq4ZZdM7TCBf9ucA+zIR4BSV7vFHh6SnK7Etgps0orrn/15Qa/2opqg4kgfb9P22SHyx1LJI8mw3v4EMejUmjAZvIWAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725276517; c=relaxed/simple;
	bh=eojUSbmc5PAUm9v9Q0i6KU3NyCsbfgo1GTYg1xYKqU4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g7ceG4mqIR4S1ATrCD5L5/grIglKgcWNEJCeKpUFe3WMFJvjWvdR90+/w881fHqiFgFfxUyyPF69j6fdxfrhFrFXoYkqspq4K3O2nbUrjb5IMBscO9M26o8e01muMgnMf7qsO+W3FOczYW8B6EccsOcFbTJGURuXd6hUcBzBN1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=keo4F3F7; arc=fail smtp.client-ip=40.107.215.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GeeFgTpFcLZziG5NcJaq2IVP6Mu/LY1x6ToC7S5Rf9J1V9O1bcgnzMXZgupQ526El7ayQKxo0GWJEV8c5KEtopjz0Tpj+6o21dZrtRyZM2MvaTsxnfgZbgn4DEHAIvfQy+xhOZnROySxK+AblcqIb9Mw73zXhcoxROBpKZr5L1zMG6roviAy4KTNpcwMRShx6Ffrlj4BLdRr20KdDM+xY2Xh8MmN8lj55CamYJqbWr02335/ys34QTA+bL+fu7OnyiweGX7TrHL7Vo7A7gb+Rrp66ZpjtfLJiIJ87N16r1DFp1NiarKz+ztrwDxVBxR4ErSnSErLb6pn7swTuAOO+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKHd9WN5OY25AuIWqpxoTQAnUKNfmFBCgAyGx5hw0x0=;
 b=NAJvJR5hhTgntQ5Njst2xBkCMArvdf+Q9NMhUXf/0uErSIwtn+mNnrG5vaXuZWpxLAQ23Lr75a0Qsz17pOus1ZLYW/9etTNgXXOnjgl3Vkw350pLPbFBOg4toOXNQcHAkdPYbX8hqhKnifIw81WJmUL7QHqSwnaGYksKNXTmucFg9/sR+fZFN2aK2LhvYRYsW67AYOTl0j4MPfI/QPACKIRgJfIBEXb8Jle/JCovei/T1wmyaKVKfxw1QfrGe5kjUoilGwUlbUjGjK1YJJ1/bShPmjVZooNr+YSEDj+f8YaHb85W5oa3pbqZKC5/jVmzWvcQXCMMXSFuHMhHyZem7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKHd9WN5OY25AuIWqpxoTQAnUKNfmFBCgAyGx5hw0x0=;
 b=keo4F3F7fshv1dnhghwygTMoeLwd/rqE4Gwim5crpkvgm6td0ofj2X4HwIO6QydSJ6X1LijsKAGgC+au7H2/8w4PnkEtq1aMuxlilZ7lT9Qa/NumJNfJ/SvHpPB2QN0Ppwva40pPEKqmRF9lYo5fmu9/1asvZUwP3NguBdSVH5vJCfCbTStA18cGKM1HUn2IvfHNSRHx6x+8t+Pv67TR//B9tCzhHYba6TZwdBk2YGHXOkADWbVYgV9MM5pO71mhnNPds8jf9Ad9JrR/lZlH2kbGF46M5NHTcGsIzQcbNivM63UmN5k0PTkDeY8BMsOLhsVnHnBUghi0v+Df5naI5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TY0PR03MB7240.apcprd03.prod.outlook.com (2603:1096:400:276::8)
 by SEYPR03MB6877.apcprd03.prod.outlook.com (2603:1096:101:b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 11:28:29 +0000
Received: from TY0PR03MB7240.apcprd03.prod.outlook.com
 ([fe80::a51:b6f1:1090:757a]) by TY0PR03MB7240.apcprd03.prod.outlook.com
 ([fe80::a51:b6f1:1090:757a%2]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 11:28:29 +0000
Message-ID: <d77a0100-7ca2-d32e-a27a-67c0a9b4f709@amlogic.com>
Date: Mon, 2 Sep 2024 19:28:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 0/3] reset: amlogic-a4/a5: add reset driver
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Kevin Hilman <khilman@baylibre.com>,
 Rob Herring <robh@kernel.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 kelvin.zhang@amlogic.com
References: <20240715051217.5286-1-zelong.dong@amlogic.com>
From: Zelong Dong <Zelong.Dong@amlogic.com>
In-Reply-To: <20240715051217.5286-1-zelong.dong@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::22)
 To TY0PR03MB7240.apcprd03.prod.outlook.com (2603:1096:400:276::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR03MB7240:EE_|SEYPR03MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: 77958763-763a-43b9-b28a-08dccb425e2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnZBZDA4RGtiY1lTUm5BeGI4eVdIc3RhcVZUeWk5VnVrZkpKaFNFQzBDL2tB?=
 =?utf-8?B?RnhyK1dGbzVmS2dDVk5VcTNGOWg2a2s2K05ldEVHcm9Yb2c5clplRklnYnkr?=
 =?utf-8?B?SkduTzQyTUYwOUdoYW8zajdyenc5RUhaTGwyR2hoUEhaYkU3QksyTktTcDNR?=
 =?utf-8?B?UEtZWmR3SUlNK0pIWVZRUFRtb0hFUlI5d1ZzSEFGeGI0WUs0L2JmZzk3V3gv?=
 =?utf-8?B?d0YrVEVwVktJSU9IM2dxMGNPVWxDcFAvYlpkOHQ0L3FwQzFUM1ZrV0hza3ZU?=
 =?utf-8?B?OFRBbm5XMXhhV05WUWZCSWNNVjQyNG12RmxlWkNXVFI5WWdxMzZpa1Rpckdm?=
 =?utf-8?B?U3lDV3ptc21WYmthNE1ZUm1kRHdRczRheXlLeGRpcnJCQVBPL05vdlVEWkZq?=
 =?utf-8?B?QlFEelc2aUtpaWJySmlmZjUyOHRNY2tWVk9iQXJwZUllMEh6YmxiTnRtemhK?=
 =?utf-8?B?RkdNQXVjU3FSajhuR0xWVk8vdzhvZ0NuWllqOHhGU0pSTWoyalNVdEJ2TXU3?=
 =?utf-8?B?aTByb0FPcFc4MFNNQ1lLcXYvK0lyUVJpZDVSVFF1blg1WlhCUHYzZE9Sd1Qz?=
 =?utf-8?B?MnZ0MldaVTJ3cXVEYXhvb3BSNUJpK29lVFEycXFWZzM2cWxiWkdaL2dWTjRF?=
 =?utf-8?B?RHBidVpXdm83bUh0dTVBNEtEcFMyMEtSLzhJb1B6Ly9Mc0hYaXlsemhBdXdx?=
 =?utf-8?B?dFJ3MU4zSXpoRXg4dEhKY25yQzNFVjRieS9oS0lDRmYwR1BzRHR4OEdCcFFU?=
 =?utf-8?B?dnhrb3JKNDhtT2I3d2QxbmtHL2FpN0VoR0ZJRkQ4UmpXZGlHNElYdUFLSmpa?=
 =?utf-8?B?NWlLWVE0OGljMVhZOU9HVnk1T0N6Rm43TkR4U2RxSHFiZWZMY3NUYXFkbXk2?=
 =?utf-8?B?S3dHM3ppN0puR3ZCTWVLYllldXc5MUJXR3hxT3MyTDNZLzZ1QWZHQ1ZrYUN3?=
 =?utf-8?B?bmdiZUdYdG9PcDBWZnJtbzdvbzNEMWhMUVk4N2l5NzdmbUZDZkl6Rk5HL0Uv?=
 =?utf-8?B?aTRDcEFIRmFuTmRIU25VQUptTlpoK3BHdzFaamQ3YjJudnZmV2RIc1E4d2p6?=
 =?utf-8?B?djVOOXRwSFpzM0tmZmFuTVQ4b1JnYVNKUG1YZnQ3SkFJbno2UE1hejczaXJ1?=
 =?utf-8?B?eVlQd01XdDlJc3RyQWR1WnVLSDNFc3U0Z3VneFZ0bzhTb214TXdGRGR4SWJh?=
 =?utf-8?B?eUdTNitoZFYwL1d2cHhzak9vZVJuWnd4NHE5NXVubEI5QWFJbjQzUGh3bFho?=
 =?utf-8?B?QXpYQXUvSUlVOER4WVVDWW9FYzV0K05PaVA1ZU9iSVVLNHNUL21nWTRubDNa?=
 =?utf-8?B?NnVoZ1FpbDQwb1pQQzdyZFpNdTZseVpOQWpmd0dva29sZ0I2MFdzWnFjYm1J?=
 =?utf-8?B?ZXBsUFA0VmJJeUNoMEI5Tk5VWFVTUU03VW1sQW5hMnNIdytxZjdxWkJoL212?=
 =?utf-8?B?dlBENEJEVEQzK0VPeWFlYkNRWVltUTQ4bmtzVVpGRFF1Ly8rMW1yWW9XWDIy?=
 =?utf-8?B?ZlUvdkRodHR3WHZ0b3ZDa05TbUlZM3ZsWUNmUUtBQ0FxY3l0c3ZZM3p6RzBJ?=
 =?utf-8?B?cWZDSFNsVnl6TWx4dk80c0k0dlFjR3Y3SXhvWTd5K2pvS1pkZ2dFZFJGVUwx?=
 =?utf-8?B?eHNrS3RjQnFEZTYyWDhQcGxHVTZFZHIwY3Z3QXRQdzhzb1lTS1lRUDc2dkda?=
 =?utf-8?B?YXdZeE5uS2NQWGR3Q1N6SXE0a1VTcXQ1cmNlaUZwdkxnS2RjLzFPRFJ5WU8z?=
 =?utf-8?Q?t1ilSWIB2MGidVt1ZA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB7240.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0JUTUVSOXJzSVM4bkc1VU1COWRpYjBzTk9oczB3YkJFUk1nMTFQMmFNSjNY?=
 =?utf-8?B?c3NZakZPN016c3dHb2ZETkI4dmlkZFgvQjdwem1jbE9ZTnZEL3MxRG00Zm5p?=
 =?utf-8?B?b0FPeVN2VXo0ZGk4YTFyRWFndGd1SE91dCt4ZlYzQ0Rld0VaaXFlTWJ5cjk4?=
 =?utf-8?B?SmNoTVg5UXRiMTJETVhacHVBZitNNVhWKy9WZHdYdTRLZmtwSnlaMFo2dEdL?=
 =?utf-8?B?K1krWXZxRHVMY2lHa0IvN1VDRVo0ZDlXalQwek1jblJlZGt6NGp4NXlWaTNk?=
 =?utf-8?B?VTVwT09URE5zSXJEYW5RSjNCakZ6RGgwUkdoUFhnaUdMT01xTHJwRERlQXJN?=
 =?utf-8?B?QmoxZE5Nai9KTFF2Q1FDOEx1SVRZZGsyYk5yNy8yUzhOYkhFcStDRk03M1Rh?=
 =?utf-8?B?eFFTQWZ3NzBQUGhxbmN5aFRjbGZQOWxDckxESUxGOWZ2c2pUekE0K2hYeS9l?=
 =?utf-8?B?OWRtbFhUT0ZkaERCR1VodDlkYzBqME5GT3lxWHQ1UUxwQy9ORVc3VUdDaS9l?=
 =?utf-8?B?SncyZDM4SlViRG45aVRkK1RvTE01OXBUVmVCUjFwRkFnVDdJc0xBSWNZdTk0?=
 =?utf-8?B?MGZuck5SSk9HMStnSDZvbVpTNmZhZFprWll5NTBlOVBnV0tFSXpEcUJQTlZ5?=
 =?utf-8?B?SUovZmFNMUVVeURLempIaEE3RmxiYzR5ekduM0dnaW93UHNMTkFxZmRKOVQw?=
 =?utf-8?B?RTNlbktPZmZxWEliUkx4YzAyNXZCc243U2VQVC9mKzZLS0ViMDJJRDljaFdz?=
 =?utf-8?B?SytPdExpR2xvcEpWNGUzWnhsak5MUzQyUVVFMS9HVUdMMVZvNWpRNHlKYlpC?=
 =?utf-8?B?Z05pVDdNUWFYOSs1WVBhSnRTaU9HdTljVGxGcU9FNzBaOWx2anE3VG1Ddmxs?=
 =?utf-8?B?Y2tEbzhrbHBlWTE2bUVNUDNlelRvZ01ld2EyVldVRzM1REZrQ081bFl2NEFH?=
 =?utf-8?B?bnVqRXhQQWtyYURnVEUvNDZQaENKWUk1NlJza2M4Lyt5ZU4rWU83VVVoUWtv?=
 =?utf-8?B?cDUyYkQ4ajZqa3RPS0JWSlplK2wzOExteEN0THMwYnYxY2tCVVduaFJ1V2pa?=
 =?utf-8?B?dHdPQkJCN2xTM3ZpMmluT0RyVmdiZ3BOYmdmbS9RMW9yM0JNbk5obC9wOUtm?=
 =?utf-8?B?dXZSeG1jNTFPbVpJbjYzai9sdkpwYW5iZWx4b3NVK2tEc1ZnNUtJMjJHZlVB?=
 =?utf-8?B?WVd0WXBYZExvcm9ueXpzcTFuK3ExcnErZFFxaCtiaCsxZUk1cGxmV2dMRyt2?=
 =?utf-8?B?c3cyMkdlTDJuS1hjUzlBblM3dW1aOGJ6MUU1V1ZNTVJocHlmaDZKNkhQRmdC?=
 =?utf-8?B?Q0VnVE04TjlUR2tRUWZXMURzb0ZBcXpaVk9kbmRxaG0xNEhaaHVtM3hjQnNy?=
 =?utf-8?B?Zit0bmNGWlBwditPdkIrYTFWcTdkSmg5a1k4Vkd5aWJ5bVpsUkZCMHAwei9L?=
 =?utf-8?B?NnJoTkFtMGRlcjAzRTVOMW51ZVNubWxsanF0eURHL1kwcEJnZ2hGbjdGN1VL?=
 =?utf-8?B?RngyTzJHY3pGU0N6RHNEVjl4TTBtVjY0U2hyWUNOVjdFcWlEUWp6OWpKZU9i?=
 =?utf-8?B?YU13RzB6UVgveUhuOGNwbEkyTDl1YVQ1bzY3c0ZVSjF5UXFIN0NKWTczNmxm?=
 =?utf-8?B?RGV2WHNXTGV3Y1pzbUtBRnY3Q2xXb2FsUkM2VG5GZFFwQm9jZGJOVjVsMkVs?=
 =?utf-8?B?UHQ3VElxUkVSYnBGTWp6Tlk1Z3BmQWN3L2hkQ0tzYUY0Y1dUclYrZTJyZ3FG?=
 =?utf-8?B?MEZ4cmhEdnBBMm1jbGRXWWxEanRmN1dpWTE4N0NpR3hpc2xwL0VPeHZCblJ6?=
 =?utf-8?B?cWJLUXpNNFdVQ0E0RkU2YWNIOC9XV0pJdjU1cUJ5aEttK1pWR0FNVGxZSVFB?=
 =?utf-8?B?N2NvV1NSYUhBNStUVVR4Wi9PSmZtL1VqRXJrL1lEOGY2NGlQV0kwWDBBNXV2?=
 =?utf-8?B?Rm1lSVlyRUxCZmVRKzN1MDM5UXpUQlB0dlFka1NVemM1MXhCMGxzYW1DOCtD?=
 =?utf-8?B?L3BMZ3NxdDR1VURwZW5BcE9NRXdmSEQ1ZllrcmhPV21UWW51M05CQ0x5YjFm?=
 =?utf-8?B?U3MwRjYxcjdZbGRZeFoxV3F4UHh3YlhZNHEzbUtScHo4S1JCNXpPdHFMM1ps?=
 =?utf-8?B?Z3psN2VLYm9wc3VyV2VGUW55OWlyWHBGVUtGVWFXN1BMUVBuMk9yU2p0U3pz?=
 =?utf-8?B?V2c9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77958763-763a-43b9-b28a-08dccb425e2a
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB7240.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 11:28:28.9519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 530kn7Ti9kUalZB9K6J0BUgFj6EV1omF2fBQTA/rOu510Sm9wTPUmg6By1NLOMTkaqmmwqWsbtgnuwJexniadA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6877

Hi Philipp,

Sorry, I've mixed up the emails.
How about this patchset Amlogic A4/A5 Reset driver?

在 2024/7/15 13:12, zelong dong 写道:
> From: Zelong Dong <zelong.dong@amlogic.com>
> 
> This patchset adds Reset controller driver support for
> Amlogic A4/A5 SoC. The RESET registers count and offset
> for A4/A5 Soc are same as S4 Soc.
> 
> Changes since v1:
> - remove 'amlogic,t7-reset'
> - move 'amlogic,c3-reset' to the other enum list
> - move reset node from amlogic-a4-common.dtsi to
>    amlogic-a4.dtsi/amlogic-a5.dtsi
> 
> ---
> v1:https://lore.kernel.org/all/20240703061610.37217-1-zelong.dong@amlogic.com/
> 
> Zelong Dong (3):
>    dt-bindings: reset: Add compatible and DT bindings for Amlogic A4/A5
>      Reset Controller
>    arm64: dts: amlogic: Add Amlogic A4 reset controller
>    arm64: dts: amlogic: Add Amlogic A5 reset controller
> 
>   .../bindings/reset/amlogic,meson-reset.yaml   | 21 ++--
>   .../arm64/boot/dts/amlogic/amlogic-a4-reset.h | 93 ++++++++++++++++++
>   arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi   | 10 ++
>   .../arm64/boot/dts/amlogic/amlogic-a5-reset.h | 95 +++++++++++++++++++
>   arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi   | 10 ++
>   5 files changed, 222 insertions(+), 7 deletions(-)
>   create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-a4-reset.h
>   create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-a5-reset.h
> 

