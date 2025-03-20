Return-Path: <linux-kernel+bounces-569088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF06FA69E6B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 03:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DF3F884B95
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A883A1EB9FF;
	Thu, 20 Mar 2025 02:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="oQwHVYPf"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2114.outbound.protection.outlook.com [40.107.215.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614E52F5E;
	Thu, 20 Mar 2025 02:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742438623; cv=fail; b=HhK9I3uqM5MFSTaYxSzlfWXwC8ym+tpxVc4JY+G8EMTKNp0BLjbBe4/7ZfDoN3Nk1vb01ukh+UwJEAh+h7xlG/9SNgSNplrOvOheVv78nRoccC5JcKUJa9kvH0MRD/VMjGgRp1fosPLo1wUaaRuVOQOPp6hFgIG726baEl+goNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742438623; c=relaxed/simple;
	bh=JWQ+lTxit52X41WE6WnLe1zS66kQSZkve4gtBD4hAOk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=txHkz5wuFBG5fIfDzuHJ7zdK8l/a2AFhqyjW21oGovIUxLNwHzuTGx8TLdiwiy9k9AAlEdREloo7wzMLCZarc8bio44wDlvPBhZUYSntHglmA5yXCluRjLmXgtz/tBzcfHPTuPprmxPtr1+p8UZ3//esx/T+e4VUFQRlJN6hENw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=oQwHVYPf; arc=fail smtp.client-ip=40.107.215.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZ2jKK6kG8pdSF4wtTzmif/rsGgGKBeiarRijnJU2lAHrey57aK2W7kGiJXm+wEpSHL/dCVrEEqpO15f5Va88OaC341zniewwaNR9a+OcJUOeHS5rDwccA7A29EKxKybd96mhIsGE5sCg26ibqCS8Dzggb5ok4bmIYGRNV1XxcIbNRZxCR99Vy/sy7sA1n8NKGEarGcJ7dM8sllvfz/93AoUF0UXnmDVfGq4xLjKC5d/ZKrzemgJMTGSTcASWXjSyPOVFF3bnCNj5DmIAzp2GDrW7/QkSuSStADl2/f0N0pQ1B9WOhDSSzd7I7n0PSbqkk35HslrC/uS9WQF9l8aLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RcowaodG4m5sz8r4xTOUPgByaEuCqr6mDC1Dk0QBjmE=;
 b=tCWA+YP9ZYbohItiYkXlfecKO4m1FcWquUaU5IOEwUxD1D1219FRNC7rdsI5OIKrqFBInityvc2C9h9a2dkravWarAEtIBvyqTbRwQSWK+xgECNDkIWtuai3b57Ob6rImxQyBJVLBtN0pAtQY1N8jroWvp33SzwVIogmiRPr0qTTQWrzzBHhB3UvkGCSpbIvFXOLZmpMvwDYnxY/I/l0oqXUpSqILE3QOATAPTvROj9MJtSppBg1CfU7nj8J3/Cm9ZP/w5fsP/ym4tNUjeu1UUojSI3e603X/IMKjGYD/VLKlrr8hxBekcsd5Xeq+7gSCYualfminwqjLxTmlSN7BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcowaodG4m5sz8r4xTOUPgByaEuCqr6mDC1Dk0QBjmE=;
 b=oQwHVYPfjkvpiez14jzLcTZ9k7MPRH2ThW1ZlssnNA+SZNijgJIS8vinvf/KQhkK+UYMvv1VuhlTLqWUMwVMOEXH7wEMequ/qPUGKDDeqTANNt4V4oW71AD1Szvyp1Kd0QiKMkMZxGtnF/8CMNvUYp2AsCs2X3MMLhQMF2isEEfOvQfrifWfKYiYZlThy/9uYzQHuP0yA03M20fCT4ZshfzyI76v2F+bvlK4z8a9mO0UJXnL6eJT8lJGtjgsgxunTQF7xc9Ry+dE+9afqSXJRjDFpHvSmjQ+wEf+QYRJi/R725kp25RHljxpEi2equzmXFqSu0Rcs1nP462pJM0lSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from PUZPR03MB7135.apcprd03.prod.outlook.com (2603:1096:301:113::15)
 by TYUPR03MB7180.apcprd03.prod.outlook.com (2603:1096:400:355::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 02:43:36 +0000
Received: from PUZPR03MB7135.apcprd03.prod.outlook.com
 ([fe80::ecac:a387:36d8:144d]) by PUZPR03MB7135.apcprd03.prod.outlook.com
 ([fe80::ecac:a387:36d8:144d%7]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 02:43:34 +0000
Message-ID: <0096ba23-3433-4f98-92ee-321c3461dff0@amlogic.com>
Date: Thu, 20 Mar 2025 10:43:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] dt-bindings: clock: meson: Add audio power domain
 for s4 soc
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: shuai.li@amlogic.com, devicetree@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>,
 linux-amlogic@lists.infradead.org, Takashi Iwai <tiwai@suse.com>,
 linux-sound@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
 linux-kernel@vger.kernel.org, zhe.wang@amlogic.com,
 Jerome Brunet <jbrunet@baylibre.com>, Mark Brown <broonie@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, jian.xu@amlogic.com,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20250319-audio_drvier-v4-0-686867fad719@amlogic.com>
 <20250319-audio_drvier-v4-1-686867fad719@amlogic.com>
 <174237350819.971004.1098115771430334211.robh@kernel.org>
From: Jiebing Chen <jiebing.chen@amlogic.com>
In-Reply-To: <174237350819.971004.1098115771430334211.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0191.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::16) To PUZPR03MB7135.apcprd03.prod.outlook.com
 (2603:1096:301:113::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR03MB7135:EE_|TYUPR03MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: 694738ff-2d51-47e4-9cc1-08dd6759022f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1R6clZlYW9SMU5aNzJIRjY0bUlneG1PZkNHakxpQ1NJR0Y3blBPUUdlM2Mv?=
 =?utf-8?B?RDdPQ1JLcmR4QzgwOTJTQUs4VGhqdVAydSt2NEZ2UnNmU3Mya0x3YUh0TkZo?=
 =?utf-8?B?TjVTWDhQUHplZCtkZXdybnd6YmdrYTJpSUhyaWFhZ0YvNFVZbGVGcXF5azVX?=
 =?utf-8?B?RmJ1U0xxbUl0SWRHb0o5dnhlTEF6c1RncG5PWTZHUkhhVXNXWHcwbUk2Z29q?=
 =?utf-8?B?T3d3VWlyUDh1OFNtMWpwKzJKNUEyOUErV1FuWVRNNFBrdzh5SWNBZTFYTzNr?=
 =?utf-8?B?bnBWa1kwaDVEV1hyQ1FPVGZmRFV0M2JlVTNQVDZFc21ObFNIZWhMWWtPMXpw?=
 =?utf-8?B?NHd4eWJHVlhHM0tscUhXODdUWXhHczhXYkxxcHd4Q1FWdllDSnZhRlhDVXVm?=
 =?utf-8?B?ZXRnMGllRFVDT2JobmpuN3dEUXNHWUxic2Z1Q1hndmhGZ2gyQUlHMnoxVk5h?=
 =?utf-8?B?LzAvS1ZaTDVFVS9qVGVOWXkyeENtb0g1MVd2ZDQxN3Vuc0wwdDVLNjZmVytR?=
 =?utf-8?B?WWRPNzU4a0phckJEbW5HTmxyYm9hZEthM1E0TzFSU09hazZFK3luSjd6ampF?=
 =?utf-8?B?cnpMQzlmdVQ1djg0ZnJhNFlka0VtSHU1c0ZUZCtDdHVOOUlKUUZyNXRMbzlC?=
 =?utf-8?B?eU5PSW1TdkpOVlUyQnl5QkVxUy9GT2toZlJ6VHNzRENKNEtOTTBHTlF3WHJp?=
 =?utf-8?B?bjRKeFVIcm5LODl4V3JjeVJ6VnhPNEtXTkN0Z0hyREpqUG1HVWRDOUJoZk0w?=
 =?utf-8?B?bHczTGJQeWhmdlpUdGhtM2pHMThvOUsrTHc3dEd2YWZmWnZNNUl0ZGhjWk84?=
 =?utf-8?B?QTJndElWSEpxWjVpMEhFUklWdjBWbXprdXFiNC8xam41d2RWMUR1Vi95Y3J6?=
 =?utf-8?B?Y2JSb1VnMWMwNUJ3dEVmVWVTKzUzWUR4cXJCZGcrTUVsN211cFpiQmZvRGsz?=
 =?utf-8?B?VFMzek1zY0Z0YW5xa0FpYUZxZ3RjeURvbXRRNUNkRXpnTmh2aW1JcVdudkt2?=
 =?utf-8?B?MUUzaStpcmxSWFl6WVVyL3E1Z1V4dlpubmdZYkZsMW9hN2t5eGpUa0FmTndN?=
 =?utf-8?B?T1lnMXhrUldOU1BLWFc1NEhFaDBEc2FxV2VDQVc4UXU2blVkMTg0cWVHdEU2?=
 =?utf-8?B?Z2FMUm9BSXVQdHZ3TTRZbWV2eDJsa0I5ckU1VStYZTFOb08zam41R2RXeHZp?=
 =?utf-8?B?TmJEUm0ycXpaWG5xTEo5NGw5azNwZ0E1cENWd0pkWDc4MjBpcGhHVnVMeEdP?=
 =?utf-8?B?aklySkw5dC82NmFvaDNqbTFJblRPVVRpTXQ4b2xDMU9QdHBDemNwVEl3cVpo?=
 =?utf-8?B?TlFFWHNBR1Y5RDNSeUxWV1Z2dTE3VnhBR1RYRTJUdXpBOEVZOEhOajA5TTc5?=
 =?utf-8?B?ZXlZYlY1eVhJdmd6UTdrYjhDaEFpMlZmdXNEek1VcW1hOTRwL2ludHYycWR2?=
 =?utf-8?B?Yjl5aU5qK3dmNEQ5UHphaGxsamJOMWgvZ3FwSGQvVGVZcjB3ajBjdDBjcmVI?=
 =?utf-8?B?ZldEREtZbUs5QTZRdldnMHg5a2g3RlorUmcrcXhKUzNnNm1xdHN4Z1hGb1pL?=
 =?utf-8?B?WTJPUmZITWZZRHV1eUFQNU1FaXErOG5iR3BSZ1dtcE1kU1dURmp3empWbmlt?=
 =?utf-8?B?enBUZXNjaCtGWVpuY05EQ1FZMkd5b3VKeSs3aGF5MzEzNTVNL29mdStCWk1Q?=
 =?utf-8?B?eXIzWHQ0VXhjazhBd045RWZ0THp4b3J2amdZeEs0dk8wbmpmN1d2d3pyaFFC?=
 =?utf-8?B?bzArUFNucmFtUFdlMzdFenlmL1MzVGhlZXdTczh5RVlxUThkR2t2ZEVxbFpI?=
 =?utf-8?Q?fTECxQYwZr3vB0zBq5854K864ZwwB1cRMz9aA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB7135.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGt4US91T29hN0VDckJCTFllNkxJSVk1dHJmVjJ6dTRZa1gzOVZlN0YyYnRN?=
 =?utf-8?B?Si9lVWQ0bjh6V0llTTIyb212Ung0d3Y2b29yTURleG9xOGpHallSZENaaXBG?=
 =?utf-8?B?Znd0TnpkNTQvRjA0dTF6N1praTdvclhyZ2N0ZE1BYTg1ajcrNWJLamorcjlu?=
 =?utf-8?B?VG52K25WRkMxbkJObjBEMTNMQURCYTFpZzVIK2o4akNLUWk5cUtVbS85MFlR?=
 =?utf-8?B?NE9zRkE1djl6V1NLYURFMzBaZUR3MUNlWi9EcU85K21EcW10NFM1STgvU3B0?=
 =?utf-8?B?bVZOakphQkZ0aXd1RlFkSmNRMG16QzRKS1ZqY2lOdjY4eWFINExDYUFZQnpJ?=
 =?utf-8?B?UzRkandkdjEwaGhoZTV0SXZSMHdWcVRKQVozb0xxMnJHbmkxQmR1eGU1UUlP?=
 =?utf-8?B?aThKVXJIRDlyVTlZb3VNdGxqN0ttY3FPMFlKYVlZSUJ3dkdjRWZNYTFUcHhM?=
 =?utf-8?B?bk1HQ3NWSjNTR2lTRGtob3RwanNHQi90QWR2TU9SdU1ia243anZnZCt6TEFQ?=
 =?utf-8?B?SmZ0cEhHQnFEMUx1cTFleXgrWjB4THNDcHlzRzFZUGN3TGpFWTBGeTZjeHJ0?=
 =?utf-8?B?cGQ4SnQzcjZlS0lSRFBCcndWdWtpOWRHclIwemNTZGtud3I4UzRuR0lwWktW?=
 =?utf-8?B?NnRkYkF1ZDRMYUo4bjRtYlA4d0k4a0RaQ2dVVmpaM0E2NkpoVnFWeTJ6MzZO?=
 =?utf-8?B?UWp4a1RUV0tRdlcxVkZsRWV4cUM2bkNxQzV1ay9XeVpHMzdIaTJGZGJkS1NI?=
 =?utf-8?B?QXlFeEJ6VCtEbnlJQ3o4V3VwdzVZMWw1VHh1aEVXV2tDMVFtMS9ZY3JjT3RN?=
 =?utf-8?B?SEk2Wi91U0lKN3g3dzhKakE0WCtHb0JxU3dzVnoxRUE4NVVyRmN4T0hpazVl?=
 =?utf-8?B?TVdoa2dvUUJtTjRvRDVtYUQrVTdQa0VFaVJxMHR2MVZvL2FQcVFELzRaNUpo?=
 =?utf-8?B?ZkhNbXl0QzdVUDFUazZGZ3FQcEROblVjVmI4emtNaWVHSnRxMHYydm1SVVJv?=
 =?utf-8?B?dGdBUWhFNEk2SVpmaUNuOHFKWFlhRmluNWFOUUw2WWhMMVJoaDZ3d2ZkZkZT?=
 =?utf-8?B?M2w2UUttRTMwU2pkMkpXWHFqOU1tWUF4NFBHNWxzVG5rTWl6Z1Q1NEpZbGg5?=
 =?utf-8?B?RjdldXRtWFIrQVpXbzlzUWJCOW4yRW1zbVNHaDVER0p5dnNxenhDTW5taDRC?=
 =?utf-8?B?N0R0TGNFY3VTbGxUb2pKRWFvY2NkSDU4ZXRScDNpUmRXM29GVldwdW0vUXhJ?=
 =?utf-8?B?ajMxQ1FzaWU4T0JsTURCTEZjNTk3Nm5nK21xekJlSmpIMHp0dWYxSjZBWDRZ?=
 =?utf-8?B?UVNDRzN2M010Z2Nxc2JiRy96QmFFdmI3U0h6Z0gwRnB3WDI4MDVBN2Z0UXgv?=
 =?utf-8?B?MXp2aHBZZ1hPV1dqT1cvaHZyOVVlRkNUTXBJTmw3QkFwU0xMZk1nWDdJbllL?=
 =?utf-8?B?ejRjaFpoYkNITlErbDVWVlc3VkIydW9WNGZ2bWpFMUJ6bDlJb0RXS28rNXVQ?=
 =?utf-8?B?WTJEYzVuRmRCSEpMT21Lb3N1a3JXREFCT3VOaS9EbTRqWFFsNWxkbm9IWDNB?=
 =?utf-8?B?Umo2eVVTcGN4Ymp4akdTUHAxenNzcjlEY0llcGxiWEtoOXA3cnh6VU5Kc2NE?=
 =?utf-8?B?aGpKTnEyTkRZL1hUMWl4RTJUSXhoWFc4MW9hZzMyNnRmVk13c254U0s3U1Fk?=
 =?utf-8?B?aUx0cXBlOFQwR0R1Y29rQjF0SDVTUy9BcWNNODNWdlBDaTBJRFRCNTNncnF1?=
 =?utf-8?B?RHFRR093RWpKcXhIOFlXYnR5QTFjOHRzSVhRcnVwOXJDeml4WWYyUE5wM3RW?=
 =?utf-8?B?Ti9xK0ozVVR5ejVaV1dtRVVyNW1jOWh5ZWVrUUF6L3hxYTd0UXJyeEpWOGpT?=
 =?utf-8?B?dDMrUHk1eEo1d1VzeTdsbHMza3lNZ003a2tiZk9NSGdER0RIejF3N1NyMnU0?=
 =?utf-8?B?aXlqQVBtWS8vbFd0ZmlQbE9sVjIzVnVZZnYxWFRIc0E4SW4vUTY3b1BsVmJp?=
 =?utf-8?B?NFlRak5YemxEZ3cvbEwzS3l1a1JQOWhtOHQzK1orU09LUGoyNU0rQWZwZ2l0?=
 =?utf-8?B?bmdhOWVMaE8vNzJGTnY1dVZEd1FjZ3Q1ajYxYStTS1UxMmRreXkwNFE1cTlq?=
 =?utf-8?B?elJsUDBQb3k1Q0plYjZlL0hzRXdtSGt2VmpaNDg3MGYzdXlpeTYxaktlQ3o3?=
 =?utf-8?B?M2c9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 694738ff-2d51-47e4-9cc1-08dd6759022f
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB7135.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 02:43:34.4387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l3PlMVyLD5X/26ExFOECm55MEbCPBImMskQ3i2CNKaJU8ehiPB7JKQsz6gX8G/4wM4lV3T0DY2rmWrRva6dHPBwAkkbXWcNgxrL/sS5+qiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7180


在 2025/3/19 16:38, Rob Herring (Arm) 写道:
> [ EXTERNAL EMAIL ]
>
> On Wed, 19 Mar 2025 15:04:44 +0800, jiebing chen wrote:
>> Audio power domain found on S4 device.it need to enable before audio work.
>>
>> Signed-off-by: jiebing chen <jiebing.chen@amlogic.com>
>> ---
>>   .../bindings/clock/amlogic,axg-audio-clkc.yaml       | 20 +++++++++++++++++++-
>>   1 file changed, 19 insertions(+), 1 deletion(-)
>>
> My bot found errors running 'make dt_binding_check' on your patch:

thanks for review, sorry , I missed your previous email, the mail was 
accidentally intercepted

pip3 install yamllint

DT_SCHEMA_FILES=Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml 
DT_CHECKER_FLAGS=-m make W=1 dt_binding_check

we can see these warnings, and fix it in next verison, thanks again

>
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml:105:7: [warning] wrong indentation: expected 4 but found 6 (indentation)
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.example.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
>          from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250319-audio_drvier-v4-1-686867fad719@amlogic.com
>
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
>

