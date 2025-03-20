Return-Path: <linux-kernel+bounces-569078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 913D2A69E43
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 03:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 563B49836CF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE871C173C;
	Thu, 20 Mar 2025 02:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="YrRaen8l"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2107.outbound.protection.outlook.com [40.107.255.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4106F1C5F39;
	Thu, 20 Mar 2025 02:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742437603; cv=fail; b=NGkRcYhab9rBQkbRcqgOTCkqDoD8T38B+F/7bc1XgbB3rgqbj1Pv8GQOfC/G5JBoaxpmAlEMtNCT4oxxcYn+WaBNq/T6GeOuRLJT90puNL9VnviOmtd2QVWhNB/3IKULKMmlXNd/1oyyF8hMwb2O7v1Rnl2jgqE2MQCQlBgLgTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742437603; c=relaxed/simple;
	bh=hDo/+nvLYjkmj8ZUqLFxLz45XuhJveM3010OAhXQhP8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mLuIjDXQFF1yJ2iwFdN6OvxwT48QlaVZN5UK79zd+LRqwoj3gVK+AoVXT4DJXgL378b1MBU5UfynvaNlkQLxW7qQhXKLuZpbwlGhnRLBBzKxZeBBeKIWJTn0BBnQ56Lpama1sAxPcQLzRyiwUtY+FJgYRn+FhC2pC6wn7PYsgWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=YrRaen8l; arc=fail smtp.client-ip=40.107.255.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCBaLRMxx++otNvnHwqPYRNm7y5zuIEhyLekK7PkyrvqW6R7uA6z/WBv5hKa4io5+tX+9jMyKXdmx/MX0TGktI/7MYi1pVLj2MjNUs7P0uEA7xVZI5Ch3ac/hc21PFOF1Iwesw6DkwsG3pnzFwG9PDNaTauM7BUyxGTRJ6xoIA9RyYAwOfLXzXO2jKObshimMfWBayu0zf7yGoVaF5GWq4TdbG/ShkBPvF5XuSpB6iJ29EiO8a3P7eLVcr1ONPDhKOMC25q6G6oliBQd7FlXUOAnyCOWr2FsvFO7Ss7voTnsWoJ3LCwRAi6d/rLGLrejENOhVH+19P/zTLcZ2DSL9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAnkaj5atPsTpRiIYkv7uGsik4OTl7GHkdS1a9UOhpo=;
 b=FwjMjLzBM1hAALTM1bvVqFGJbSh4HJL3z5m9hZJh0gwo8u6Zv7yyAAjeAlbEkKwpseHCWPsJfutI55T/ynxByqnf9LvdyIC02nsvHzg+9dbdIbOMI/uxEajfYpUg9SUm8vmguKw1cwsShLprpB3lvJNCl6vXlYwwrzC2aHBvPMcMmpVNGupos6UUf3WdGOlg+kY/PrgYHtDnvyedYExoNlSuahd9gyvfVwuc/Ik303V7+eWwoJFIA7LVi5QM58nzaPPF28YREIbTa/nJsP9KQbiIGjKitQNf2yWSwHSWB6Kp80+AXN01+PgezGdBF7i6EW94AwvKWhgAkMZWPXLhKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAnkaj5atPsTpRiIYkv7uGsik4OTl7GHkdS1a9UOhpo=;
 b=YrRaen8lUGGgHAqpoeUOIF6aNNvZZxQUQ4X3ABppuxiOzi8FxjN6oPLSIMEbzR+TypnlWpFhPF/99qEpmtknYHbAwi4uhbCcMkO/fJgzTzE3Mc+BY/q65/6d6czpOl5b5X0V8qadTzHB5we8yY+9qG1PtFFm1U4AMl4QCUgT4z6Hbos5kSmIYUX9goBzzhvTJlCGGJ1XpGezqBV+7Ml9wWgFxmeFtwfO8PRjU56HyJ65AN7RfWtd/P+Ld7kvrTSERRC1txUECn0/i7187Az7uyVxnMYeapgW5xA+jQIPoam7Y4IdNbTvxr/fX+zU9/aRIX2JYyMzyEPqAWZEcKdgZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from PUZPR03MB7135.apcprd03.prod.outlook.com (2603:1096:301:113::15)
 by SEYPR03MB8479.apcprd03.prod.outlook.com (2603:1096:101:20b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 02:26:37 +0000
Received: from PUZPR03MB7135.apcprd03.prod.outlook.com
 ([fe80::ecac:a387:36d8:144d]) by PUZPR03MB7135.apcprd03.prod.outlook.com
 ([fe80::ecac:a387:36d8:144d%7]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 02:26:36 +0000
Message-ID: <e5d3741d-0f4e-4f92-9b1c-04b114892330@amlogic.com>
Date: Thu, 20 Mar 2025 10:26:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] dt-bindings: clock: axg-audio: Add mclk and sclk
 pad clock ids
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 jian.xu@amlogic.com, shuai.li@amlogic.com, zhe.wang@amlogic.com
References: <20250319-audio_drvier-v4-0-686867fad719@amlogic.com>
 <20250319-audio_drvier-v4-2-686867fad719@amlogic.com>
 <20250319-daffy-classy-kangaroo-023e1f@krzk-bin>
 <9ae73d75-9c59-4255-8924-b456c86cbc01@amlogic.com>
 <7084e271-8546-4a49-9eb8-ee3f647c529a@kernel.org>
From: Jiebing Chen <jiebing.chen@amlogic.com>
In-Reply-To: <7084e271-8546-4a49-9eb8-ee3f647c529a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096::15) To
 PUZPR03MB7135.apcprd03.prod.outlook.com (2603:1096:301:113::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR03MB7135:EE_|SEYPR03MB8479:EE_
X-MS-Office365-Filtering-Correlation-Id: d6ed80bd-4864-406c-049f-08dd6756a374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1FwSGtlaHdULzRCRDh6MFJpTHBxWDFXOTZib1NDczI4Y0dUUm5zVWxxYTNp?=
 =?utf-8?B?b0V1Z01Bdm9CdlBIR002YmJJOTdES0pVRnZGdVRDVi9DWkY2ZTd2ajM1amxB?=
 =?utf-8?B?YlBmNlJwczZGYTcrNXJkbklUdDVzNWhvZkhDQ09zN3c2bGJuVXRsNHFsOVBN?=
 =?utf-8?B?ZXRna25DdFJ1RGpyMjEwUktlN2JHREdDU0FJVmNNMWhhaGhDQmZLdWlCYWNq?=
 =?utf-8?B?emRxR3JobitCZzdHQ2Nma056R2JFNDBYSTJOVkFNNzRYUERPVmhRc05kS3Rv?=
 =?utf-8?B?alZzd2hwV0xyM2Fabjg5NU1yR2IwVTltQ3YycFUvNzYvVDB0dFlIcS9MVWZD?=
 =?utf-8?B?NGpzdldqc2xrZHcrakt1VGd3NnZZVUJSSzdDdTdZNm1uRU9uak82MEpkWWZB?=
 =?utf-8?B?SXdqSkpvRWVYM0svcDVUNWc1MTN1OHczRWhjSGNNM1B5MEZZcmUrbDZ4QVRC?=
 =?utf-8?B?YXBuRCtuMjJQdXNjb1B1WDVIVTZJeEVoZTRIdnU3ZCtEL1ovUVVKZlY5VUFW?=
 =?utf-8?B?c2FLamFvOE9LR1NDRWJ6ak5JOVVlTEZmYUNBY0FGM1lWTzVrRFV0OExDRUhS?=
 =?utf-8?B?SDVnNHhKdkpnQlpWcjFEMHl6MTcyOFJCTFJMbGpuNGFnVUQzcnRKZk1LR1FC?=
 =?utf-8?B?YkFGS0JKKzFnejQ5K0RncmNWMXZ0bnR1bnZSYmJTdWJsNnZFVEhMVmIyNG8y?=
 =?utf-8?B?VGZpRFYyd3cySy9TM1Qxb2I0N1ZWSEd6K2ZxTGsyaktEVmExWlgvWUZ5QW5C?=
 =?utf-8?B?Y2FrRS9HSmZSM0pxenlYZFhuTTNkT0ZNaGVpT1BMbWVXWWdib2c5Vk1NcWo2?=
 =?utf-8?B?VFIzZGdDTnk2c3pXbTVXUDNxRkQycG9yVEk3NDlXckIwZGNwcWlnWUZ2NDli?=
 =?utf-8?B?MGw2R3U1UDZpR2YrQnpKZlNBNmF5d1JsY0ZvUnFodjhtdVBPKzl0Mnc2TWZj?=
 =?utf-8?B?YVEyZ09jTlFmR0xkQUJuWjJBKzVaRUQ2YVVaQlczMlpvSEhYVUV5RzIrb2w0?=
 =?utf-8?B?Rld4ckNPWVV5SEQyNVY1Q0JSanN6MndnZ0JTdFFpbDdocm9lMnJNOXNYWXRJ?=
 =?utf-8?B?N0JwaHg5ZjdZVCt6TjRDMjZyVVp0U1BFOU9xRXhOaUNpQ1loM3RmTHRxZEE4?=
 =?utf-8?B?SDB2TE9wRVpVeWZuN2NXZlFONmk5ckxiaUV6WEVyQlppOFRiNEFZSSs4NGI0?=
 =?utf-8?B?clpNQkJveFBSbXJIbXZQTzlzdzlFSm50TmJCVEdKUXE0UHRhVnN0eFRDdHdV?=
 =?utf-8?B?SGNaVjZlUnhCWFpNTm5VbElZdEVwcUhranpmcThoREt4dmZuRGFyN0NRN2VZ?=
 =?utf-8?B?VkxTNXU2R3gvNXpVdStCdkxodnhkUnB2S2RsTiszQUNjc3RDTGhtY2V6QmZt?=
 =?utf-8?B?TERHNFF6dkdqSEdkbHpaT0FqS0pDY2grMEVVMEZSMEtuTUNDZDViSlQ0RURN?=
 =?utf-8?B?SGEyQXZJOHp3aEZmVFQyRlA2Q3dkclBlK2d5UHQ2RGltVkticWZKQy9ZZGpq?=
 =?utf-8?B?dzUvNzV5QWpVV0haOUg2UTlzaHUrcWlMOExTaGRmbWJpYkQzMUxtV2NrMFJ6?=
 =?utf-8?B?YnlJMEx3NE9abmR4bHpZcU01cml3Ri9yS1pGU0dKd0NtL01kMWoxUW1FbXFs?=
 =?utf-8?B?Qm1hTGpKR1QvZjJEZ2QzbzEzQTZxd1A3Rk1laWxEYnJHWFNEdmlZcWZ5Znpm?=
 =?utf-8?B?TUFvYjVURkNsbldkYi9Dc2tLVndldThyZ2tGYm9JRTZlWlZyOWZsclB1OG14?=
 =?utf-8?B?b2IvYkZzLzg0aDc4UU9nNk1lZ1dPWHBuNmVVQlVVeEJ3bEREUVdNc2szbEd5?=
 =?utf-8?B?ZlpOdUJrc0hZc1dQR0tFZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB7135.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WW44eVFiS1hsQ2RhalJKNC9ZcU5wdnBaTGpscUxTWUlhYkx2czY2ZjBnTWNE?=
 =?utf-8?B?MjVXOTRVRW5Cb2dGNmVSRSszTFhJVXlGZzBGcm1XaGJmLzBJT2dNdFRWckZS?=
 =?utf-8?B?Sis0VW5TT3FWTWEwekhGUkVCVm1qNi93U3RBMjkwZ0dBQlBUUHlLV3RhWWx3?=
 =?utf-8?B?MWpFQ3BpTm5qS1RVVUR0dW84UjhRNVBsVGVPMVN6R2FWaHJzSUhUNURHMWQ4?=
 =?utf-8?B?VzVHTU5tbnJMU2dMMjBmK0xUOHpJaDU4SVdiRFpjRDlGM0NqMlNDVlNGVTVV?=
 =?utf-8?B?SzZOQWorY3luWDhGTW1oOTk3Z3Z0RmpCS3oxa0FmQWgvUG5vMi9jTEhwZVp6?=
 =?utf-8?B?UWozLzNrUHhDT3U1N2tBdFdNbUtCTkdNMG1UMnNWME1GSEZDSVlQUE5WaDFV?=
 =?utf-8?B?Y1lhenVIT0NEOFZXRjNKejEyMGNFbWFKVGczNXVoZnFGSENSR0Y2bzhmUUhM?=
 =?utf-8?B?RkkvY0J0dzhuZWF3dzJXbXV2WlhVNDBGL0tQTnlHK3VGV0wrQ2J2RVIyamFD?=
 =?utf-8?B?TzB3K0pxTnJvRjlKRGVXcmdXczgyV013Wm1VRy92R1ErSHZhRHM1blpyTDRj?=
 =?utf-8?B?VG9NWXBpLzhJWXczZHRQRTJXK2EvTnJ5UmpGTzBxSUROZXdZYURvZEVDWkFZ?=
 =?utf-8?B?MDV0L1lRelRTVWJFV05OQnFKNDFkTDdEdCtCZHdocUdpOVpKdms2bVg4T1Jr?=
 =?utf-8?B?RnpqZjZWTW1QOXhucUdGV1ZpT1NaR3E1QjZpUmR0Nzk5UjNlMVFqWUpBa29J?=
 =?utf-8?B?S0RrZ0pkOE83ZFdLSzBGM0t3c2NEaHI0ZjJuaCthbURZNzRUVk4wRXg2eWU0?=
 =?utf-8?B?LzM0T3lOb05MK3RHN3BQMFpGY2FtVENCdVJmcG1aNDNGOFhqckQ1RUxZdDFl?=
 =?utf-8?B?L2hRNmUyT0tWY2F4dWNQVTJQRmtQbEhNWFlmRWoxcTI5OURzOGlCV0M2UEZY?=
 =?utf-8?B?NzVYaGl1SkZGRDlMOG12SlprM1NSWS9QYnQ5QUZ4dGlNQ0tiSkNZYW4zM3k4?=
 =?utf-8?B?ZGgzVHZuOGsvL3hqQk9mcW5VNE5Ccng0UHcwaEUxZ24za3VITVZ0VkE1UFRW?=
 =?utf-8?B?VFUyWS82NU5QK2hUblNpV3YxOTI4SHBpYUF6SXpocFdhT1NvRjRXa2NRYUkx?=
 =?utf-8?B?QXFnZmhxY3NoVkwrL2FJRkJheU5FSUhXN0RCcERTUzQ1eGVOcmIwTWphRURV?=
 =?utf-8?B?ZFkrcVJCVG4zQjFpUWRoZXdmQ0hNT2lMRWpyaWJ0NDZiOFlWR21hT1l2ZXZX?=
 =?utf-8?B?YlMyOXpyVUU1RHhpTW1sZ2d1YmJyU1U5amM2elZNUER5enF1c3BzQmc4NUZS?=
 =?utf-8?B?SkE2SngwLy96U1ZRUHFzQ3gvOEhCbU9JSSs3WDBJR2tudWh6MmkxWm5SY3Ba?=
 =?utf-8?B?T0hoQnJycXhVUzRIN3JmdllsOElHY2duMCtGNzU1aGphcHFHMlF5U3c0aGZs?=
 =?utf-8?B?czJBaE41eW4zVXNObzUvajZhZWQ2bDQ0Tkt0ZjB6SkM5RjhBUk1OVDZtN1lZ?=
 =?utf-8?B?bXE2TWxzMVA4RjFkUDhJMnIzc3FDRnVZRTRZZGNNRlg1MnJ1NEpTOVhEOGpI?=
 =?utf-8?B?eTk2QllFZFJMY3NXOU96OElWM3lXaCtMNmFaT3dwSmJjRVZEYUJZSisyd29a?=
 =?utf-8?B?WktkdEU5OUpxWkZZd0p5b0FMZU9VLytKREhKb2ZlNlVMVDdSaU12TkgvZDU1?=
 =?utf-8?B?V3VJdUVRMGtpdStzdzczUFhmbThnRitnQktBTm5ZYllxWVk3eFNiVVp5QnRF?=
 =?utf-8?B?bUUxanZXVzVGL0NGYkxYUmFwZXNnZG1WdnV1VDFEcFQwdGhVNmJ1RnVzY3M3?=
 =?utf-8?B?ZTlUeWtHS1hYcUppaFY0VGRyZXljM241aFhTQ0lwM1pPZHArOCtxRWlwN3lS?=
 =?utf-8?B?VVZ5elJCWnUzM3dFZ093bjloZUNMTmNpUzVzVTV6N0hmakowckd5YndiTytj?=
 =?utf-8?B?VUdEY0VZZlRZL3VlSEFSaC84QlpGdWs3ME5uQnloUit4SjhOdHJFRDhRS0Zm?=
 =?utf-8?B?L28wbGhYK1BmOHEwdVR3TytaZ3JnK1A5TFJoVGp5cmtyWThrcXF0Q0w4N3Jl?=
 =?utf-8?B?c3B1UzlmZDdNT2l2eWRQZFBwbTkrQXBmNUlXVExxaWx1b01ZNTBPSU1Hc1o4?=
 =?utf-8?B?UTl2cjF4THgwcG1pL3N6cnFqNmRvR3dDSm0vZjBvU2Y2K1lTSWVHM211UDBv?=
 =?utf-8?B?alE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ed80bd-4864-406c-049f-08dd6756a374
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB7135.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 02:26:36.6208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0KHBVz0gms/DhytItGSqOmAlT6MhBcmCTqiYPjBHz742gTaywtU9yg6/1g+Su/s5yA5IxSituhYP8wkAxSAv9wMh3sucKnQ8RHMzchZKO5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8479


在 2025/3/20 3:31, Krzysztof Kozlowski 写道:
> [ EXTERNAL EMAIL ]
>
> On 19/03/2025 11:09, Jiebing Chen wrote:
>> 在 2025/3/19 16:22, Krzysztof Kozlowski 写道:
>>> [You don't often get email from krzk@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> [ EXTERNAL EMAIL ]
>>>
>>> On Wed, Mar 19, 2025 at 03:04:45PM +0800, jiebing chen wrote:
>>>> Add clock IDs for the mclk pads found on s4 SoCs
>>>>
>>>> Signed-off-by: jiebing chen <jiebing.chen@amlogic.com>
>>>> ---
>>>>    include/dt-bindings/clock/axg-audio-clkc.h | 11 +++++++++++
>>> This belongs to the binding patch, usually.
>>>
>>> Anyway - do not ask us to do the work twice.
>>>
>>> <form letter>
>>> This is a friendly reminder during the review process.
>>>
>>> It looks like you received a tag and forgot to add it.
>>>
>>> If you do not know the process, here is a short explanation:
>>> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
>>> versions of patchset, under or above your Signed-off-by tag, unless
>>> patch changed significantly (e.g. new properties added to the DT
>>> bindings). Tag is "received", when provided in a message replied to you
>>> on the mailing list. Tools like b4 can help here. However, there's no
>>> need to repost patches *only* to add the tags. The upstream maintainer
>>> will do that for tags received on the version they apply.
>>>
>>> Please read:
>>> https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577
>>>
>>> If a tag was not added on purpose, please state why and what changed.
>>> </form letter>
>> thanks for your remind
> Are you going to do anything or you are going to ignore us?

sorry, i forget to use the b4 trailers -u to check the tag, you are 
great, we should check any message in https://lore.kernel.org/

some email might not received, fix it in another version, I will check 
all the missing comments, Thank you again

>
> Best regards,
> Krzysztof

