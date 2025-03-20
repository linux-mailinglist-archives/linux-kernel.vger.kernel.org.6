Return-Path: <linux-kernel+bounces-569081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 470DAA69E4A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 03:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D9788A397C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052F77DA9C;
	Thu, 20 Mar 2025 02:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="BectWms6"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2099.outbound.protection.outlook.com [40.107.255.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C2E1684AC;
	Thu, 20 Mar 2025 02:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742437760; cv=fail; b=gHy384000fj3w9Kiw5dFF6xr+zB9JXRNuzA6gb/f4kZy9b5dzPCckRP+nMmc5Odzy6pxmSWA7cOWTnqWzzDMQXEr6mrMoXbQa2i/7lJFDxXj+24JpU/5ZXgZg5v5YleLJrH+RFbRp/PY4Oi9SoJeLlT0pL5PShKFF0/mTKXT+OY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742437760; c=relaxed/simple;
	bh=kejW582rDKKq7flGy9j2hCdVUbbcfyIt6p27YRCkfik=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DcojUxJ8mlzCAh9DJM+YoJVwx02nFZwsyDguyUPq05BDn4Wll6LvzLNq18KtJh56zTa+iJHgFx1SKPRVM1nBMBpNcAQIN4SxgpRJMs9xEoOn5mTNeJLH+rHYavIcZ2z24AJVUphOioVzk8Q2leZTqN1ckufgQjLmc9+ZEe50bLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=BectWms6; arc=fail smtp.client-ip=40.107.255.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bmFZ6pfb+6FCXxPi4KH6xrN3+tHD4a0eVZzkfia0HuDWQckn9jGa0ZBEXeI0UOHnowkiM89n1hm5XAhzYnuXOYa45kmfYdYgQRNuDlV1MDXVroTm4tkXC6KJTkHmhiKuJVBSHZF2EDDLDVjybtpmM1nQ/LDDG4FaGFEde9e+UQjd5IsTHoQDmsg8TQcdxXbxb6BcGwjzMCueAHIfnLRUO1g3OzBzJd4hIFuDRE3BqYVwXe4NyflQXj6ZDTc/66b03fvBk3veV86JrVsHT6unkzn/KvzVFKyfSgVWfggntaEey6TgpY59kUOKgHCE5v2X8WO7Xibe/S6OZDA/ySPqew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpjy1IZYSrJhI5Gcp+CzlK5Z2X3XiZyOlcEiYFRuKT0=;
 b=Bf7uq+AtGCE3+DcSFWeBLHjD6cRZ8qeO5sk2id4m6CML69i5hgdbhyo+RXysBWx/+znjtwI8c3TkBRAhLtqVj3Rw3p2pHkurfydGCMV4PNUrZky4HGUlG2R+FvayS1KcB/elwIOEY07/2An/3sMumuK8dkKlVznF+iBNucF7Pdp0ksJogjOQVG3q37kR2v8CMvMQti4hoNujeICefyIZNBq26pRAmE3qwlm/ke5jzJGgeSA7uQudy529WiNrr5R4qNxn1e+kKV8TqoAV1iOZs94Epvq5bvXspFy87jCVQfWDvJinJ6rtInrQaejXuBnpK/vgi89PNFbyKfM6fB7G6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpjy1IZYSrJhI5Gcp+CzlK5Z2X3XiZyOlcEiYFRuKT0=;
 b=BectWms62VHcK64hOSNzSWZG3UZsp2O6K699AE3jdgpIn+ePyAQl3Y8YSTV+FN4Fd+9bW6sSOQDtAyIIAcfpZDCXJEFIdcb/Hrz83yNirw55NunhYRMIZWTKLhbL9kRYJkdpHoOGry2nKnQKDh4Xj43kizOludf2Z/ieRM7lprozLYfbGG6VL9gSm6EMZE/W+t4diB6rTTc+3czQgJ72n0T7eBmySJDT8Rl/+t1qFufMOQzsDt3NmWPASVIqd3F/oTQTQ6EHKx3M97oTB87wMHasdB3ucAMCc5xQUpsTz9qyYOXK7WGvkf0L5Biu0AElq2zpZLmfdRuTEH/jv5hmgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from PUZPR03MB7135.apcprd03.prod.outlook.com (2603:1096:301:113::15)
 by KL1PR03MB8821.apcprd03.prod.outlook.com (2603:1096:820:145::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 02:29:13 +0000
Received: from PUZPR03MB7135.apcprd03.prod.outlook.com
 ([fe80::ecac:a387:36d8:144d]) by PUZPR03MB7135.apcprd03.prod.outlook.com
 ([fe80::ecac:a387:36d8:144d%7]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 02:29:13 +0000
Message-ID: <8253157a-bc8e-4c6e-8697-2fdaf7193bc8@amlogic.com>
Date: Thu, 20 Mar 2025 10:29:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] dt-bindings: clock: axg-audio: Add mclk and sclk
 pad clock ids
From: Jiebing Chen <jiebing.chen@amlogic.com>
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
 <e5d3741d-0f4e-4f92-9b1c-04b114892330@amlogic.com>
In-Reply-To: <e5d3741d-0f4e-4f92-9b1c-04b114892330@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096::12) To
 PUZPR03MB7135.apcprd03.prod.outlook.com (2603:1096:301:113::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR03MB7135:EE_|KL1PR03MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: 26a86e7d-81f4-4c1c-c6b9-08dd675700d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUZHTHNSTjkrRXowTUFLWUhuNStTZ1AxQXJwengyYkZJd29vNXF5SmMrTUtZ?=
 =?utf-8?B?bE5JcHgreVhQZlllUk1sR09XWklja3pnQndWelFYdmpMQ2Zzci93TGhzUEdQ?=
 =?utf-8?B?eEV2TEJjTHpnOXc3MXA2QkZBK3pJa0NLWnloTzBoa3h1ZGRuK2JzbVpwRWhM?=
 =?utf-8?B?YkJYRTlVYjNsdHFFMCtVK2RvcW9ub3hmSnNDVVB4NlU1bFdaYUZuQXlNSlNF?=
 =?utf-8?B?SmFWVzdJUE9OdGpVeFVVRGRvS3VCRkhxU2ZPSGwvemt0WGw5Z2t4WHY4dW96?=
 =?utf-8?B?akhBK3JvMWVGV1BHR09oTU1jRHZnek5rTGlkOGJLK2Z2dVZObHFkMnovaUp2?=
 =?utf-8?B?Tzd3SmFUWmZDSUMxQjJqaG1uRFNBK2ZYbVdONzl1WWFaRGhOdlkzeHdlaWxl?=
 =?utf-8?B?dGhZZnE0ZHhxVkJsRDNtZFQ1bXlrYXloWHpBbFNGek90QUZyczJTU0E5d0pJ?=
 =?utf-8?B?MSsraWJISWlZaGRnaUVrbm92TE9ZZW0xZ0ErMnE1Ry9IaHZ1VjAxQUdZWmIw?=
 =?utf-8?B?MlFTMGZhSC9LV0J4WnhsQnNQVVJtVkY2Q01qUFpSaytHR3VqUmVvQ1FKaGdV?=
 =?utf-8?B?TmNMZHRLWEVDWjVYcFVWbkcrQXhZVVlHVE5yc2Raa2RDQ2JrcG9DbFZmTTBJ?=
 =?utf-8?B?TTEvK1NCZWhiRnRtSVVpT3pyMXVkK2VFVkk5UXR2R3VmUW52NUIzSHQ1R3h3?=
 =?utf-8?B?dzhndDhua3ZMczJqMDkveFp4TDhCQjNQVkk2UkdFekNDQURybWxadkZNYUdC?=
 =?utf-8?B?Q25teEk3STJkTzFxOGRhM3VLbERqazNVVWp6K1hQQ3ZETTVtRm1NbnRrR2l3?=
 =?utf-8?B?eXpYRWdVdHRMS3JWbENNdEZvOEI4c0o1TWYzdTJkckU0TDlkcnBpMlIyMnJE?=
 =?utf-8?B?SUNVL2VHYjZmdXZVd3JIdGxva2RKaWJZTTB4YXZESHJZYkFtWGtTZ1ZKRUt6?=
 =?utf-8?B?VWZDZU00aWlwL1RuSkJvVmFJZ1JwSHVSc2ZXMTE4ZHMycUxudEtIcUZESTA3?=
 =?utf-8?B?aEtSL2hxcUZOL1ZSbFBkakNsOWRvT0pRZ1JHZ3hXQ09qK3JKMnRhMC9FT3Br?=
 =?utf-8?B?aFRqTzJpc3ZrOVRSQzFCMW1acC9FN204bVNkZk5KVm9RSStGaWlMK1ZCUk5a?=
 =?utf-8?B?aDI3bjlBYnFUOFhvdHp2MmhKbkZrTDdOWVBVVUROWDUvaEZ6Rk1ZanJFdk9J?=
 =?utf-8?B?aVJwK3VvQ2cvbWRkcGdWSWFGOFJxWWQzRzQ4S2JRZTdTenpBZ2xxQTNxQjlR?=
 =?utf-8?B?WWxUY0N6YWFYY0pqS3lHZ0xadGVpWFZ0ZXFuVyt0RlhPbkpIV1pOckdMZFJL?=
 =?utf-8?B?dWk5L2lUeG1sMkFqZFFTaWk4MUZPOEkrdXJYMHVIcHd0bW4ySmJvaU8xVkdP?=
 =?utf-8?B?M0drUHk5V3JhT1hLQnlDT1NxOVZlczRWSWFXYW9ad2tNamZLaXpNQTd2ZENZ?=
 =?utf-8?B?Z1J3VklhMWpXMGRSNkR5bVdJVUMvT2ZzSUpsNS9ITk9XVVViSXlESDFoS0ZF?=
 =?utf-8?B?MzkwM3dYZnlvekJ3czRIakl1OFZDWWIvcjlKVE1vbmlGa3JGdi9HMncrQU9L?=
 =?utf-8?B?a0l4RDdRNXUxLzVDekN3RGlmR2lWTWNqdDczeS9yZUxldGhPdCtqUWdIQlpt?=
 =?utf-8?B?MnRoQlptTVducm82RGNjREJqeURCcVc0cmJXNW9JRWJkcmRlblZWWmdiQkxI?=
 =?utf-8?B?U0JCaWgxaVZoUkRQTVYydmVldmt2bUwrcUQrMUhYWU5EbTd3VTlOR0ltVmk0?=
 =?utf-8?B?TG1EVXBlTCtscGxadXM4Y2ZMTk5sWTk0YnJkMFFzZDZzZjk4Uk9lUlQxZnVJ?=
 =?utf-8?Q?ZPLTDsptGA6X70GY8NgLlNqIb0z3KF8xAv9CQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB7135.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TS8xYzJkcFJFd05wNXRmNFFhc0U4RCtuYWpMTkhUem01bEEvbzhYQ2w4Z1lo?=
 =?utf-8?B?VXZMTWMvbXZKQTE2NTNRNGJuQnk5dW42UVVxMU5ZSHEyQmgrTFZMdisvZXFr?=
 =?utf-8?B?dGtFSUNKc0lyTEZMNmxVQ1ZSZEhWWTJpbi9QdXRBNEdXWExVbTRnR1ZZZEtn?=
 =?utf-8?B?elQzMUdnZ084YlM5VzFoaW5xdlRTbEhHaWxEYUpFU3huMHZFajNlZHZkSlVT?=
 =?utf-8?B?aWJudDU2Z1phYjl3V3ZrTUNOSDg2TFBpbTJpQnE3b1V1YmJpMHRDTnVieTJr?=
 =?utf-8?B?TjhySTl1RWorVE9sT2dXbzZDeVBQd3FQWk5tNkhsdzZOSWN2dGVhaW9JTm1Q?=
 =?utf-8?B?engwNklYSStjanlXa0NycEY5dzR6TVRoaHFhU3NGNVBqTTZPeHJrWlZVc3A0?=
 =?utf-8?B?aEUvRDhRN3JMa3Vrcm1venArWGYyN3dIR0gzRGR0T2R1bkR4WHRvWUJncG9K?=
 =?utf-8?B?ODhNMkdLMGhORGFmMlNieGJSMzV4dEFQMHh4WmkwT2FoZUxPNzlQS0FuRWdK?=
 =?utf-8?B?Yzk1OStNQ2JzYlorVkFjcFJrZnlKNjZ2SlJHM085NHVGSUtjQ1NId3JIdXBF?=
 =?utf-8?B?NzFtcndBZkh1ODRLTzFvcEZQQWNpZHlraHlXWHZvbnJmbHRFOFVCa0VOaWZz?=
 =?utf-8?B?RTZlUmg1SDhqSTlVODdMZ0JISncxekVGRHJtcTJONFowWDlFTnFoaWNualB3?=
 =?utf-8?B?SXFwMUlCSjlxUWRJNk55UzIzemRtNUlZWkdTRlNwQ0I1QTZDU2ZjekF2eUNE?=
 =?utf-8?B?aWNpNE9jM3lGSU9IRGZtZk5Mclh0TjRzUlQycVRIWnhnTys1Skd5ZHZpZm15?=
 =?utf-8?B?bmFXaXZqd3FlYXF1M3N1U0wzMDVoZmRJdVFOY0tyTUQ0MThidENlaDhOSVVk?=
 =?utf-8?B?cVgrYVR4UVpTOWpHbHFucUI1ZUJXVS9DMEd4c2VPVGhQQmFicjBudG12cDAv?=
 =?utf-8?B?amVSWHZlQ3BTRTJnZkZJV21jNG4vdmJWVUhrTm92UVhJRVpLaTVDVUtsNDZy?=
 =?utf-8?B?V2VLUHNvN3BJZ0NWcGV6aS85UnNxZVpCbldsVXMwc0U1empuRitNYitQaktG?=
 =?utf-8?B?eVhJalJ2YW9nWFdzaEpZWFJkNzdwZlZTNG9wRUVuUi9rQzE0VngxQkZaUXBI?=
 =?utf-8?B?eUR3bVJuaFFHQTB2LzVGd1ZFam9LZGwxcnVYaEhzd2hnUUFEeDlmMS9iM0Zq?=
 =?utf-8?B?OFA5OGZ4UktXV210NkkwSzJCdmpVRkFhMFJ0cHRXejVuZXJQK1hIdzl1aXQw?=
 =?utf-8?B?bFlDVVVxVkVSZHROZ0ZRRXZKSkM2UDVLQ1dNa0RyMktTa3k2SmRJaEhzZ2s0?=
 =?utf-8?B?bGl0dWZSQXoxdTl5QTAwOVBvV1JSa1Qvb1lKQ2V6NDM4M0JGQ0pRaUlveVQ2?=
 =?utf-8?B?RWY1UlV0YXZMVVJqSnJISFBqcytleDh5ZnJDZ3FlM2JjRzAyY3BqSEZiSUhr?=
 =?utf-8?B?VVNBNEhFWldXZWU5RDVpSitRck15TWxpbld5cGRGT2xFYVNwTDVHbTBRVUx1?=
 =?utf-8?B?eWduMkh5YTd5Mk9URVlKS1RISlo2TW9NNG1pdk9lQ3UyeWRQOWg4dVFBcXhG?=
 =?utf-8?B?T0xvUEwzQ01ld3R5WjFoWWpQY3dFMGh1ZDNIOW5uZ2U5U3R4MUR0ZmRUdjBY?=
 =?utf-8?B?UCtRYVl6Y3NhbWhzanJJdlM1OWxhNG5BME41YjhpWk9TN0xiRU9naVJVbWNp?=
 =?utf-8?B?dGZKMmFyV1JkMVpLMExXb1RQWm8ydXVXaEs4ZkVMRlV6SlB2MjRCUFprMUNW?=
 =?utf-8?B?c0YyaVNFLzVxbTlneWdZcm9vbmxtdmdrRElMTUpDcW81WFV1QWlZNXRoSmUv?=
 =?utf-8?B?SC9NWVBXQmFZb296SzVJdTAraXpocjdGVkdqd2VYL3QrdVJrL0lhRDJlZWJZ?=
 =?utf-8?B?Tmw0ZVIwTXdxODNrRE52b2lxYnNXcUNzVU5hU3FFZ3Vma1ZtU3BaV0NQMDZK?=
 =?utf-8?B?cG0yYWN4VDVQZ1NKV0MxaEZEcGg5WktMMnNUOURTeTFyTEMyZ0I5MHFrSzBH?=
 =?utf-8?B?Vm9semw1RFk0NitEeDdRZG1kSU8veXgxbGV0NjR0ZFJCUzZjdm1POUZ1eE5B?=
 =?utf-8?B?cDNuaUZCZlZpVlhYNjh0TCtSaGpZdmEyMjhranVxOCt1TGlwcGJHNmloVmts?=
 =?utf-8?B?UllvYXhzNDlmMzFiWVZ3RGRIOHp1MTlTdmNhREtmREd6cmZWeGcrV29XQWFO?=
 =?utf-8?B?SHc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a86e7d-81f4-4c1c-c6b9-08dd675700d6
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB7135.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 02:29:13.2758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SqKaSYMSyLJoxLd8y5ObfcgqDTyVSfTq7Jf4uULqFX6jNGSu9yKhIcAOpuopPXV9UNsWe6/elLIh3tvu6yLjsBVq312TkG9d6ZIzIC9Lw1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8821


在 2025/3/20 10:26, Jiebing Chen 写道:
>
> 在 2025/3/20 3:31, Krzysztof Kozlowski 写道:
>> [ EXTERNAL EMAIL ]
>>
>> On 19/03/2025 11:09, Jiebing Chen wrote:
>>> 在 2025/3/19 16:22, Krzysztof Kozlowski 写道:
>>>> [You don't often get email from krzk@kernel.org. Learn why this is 
>>>> important at https://aka.ms/LearnAboutSenderIdentification ]
>>>>
>>>> [ EXTERNAL EMAIL ]
>>>>
>>>> On Wed, Mar 19, 2025 at 03:04:45PM +0800, jiebing chen wrote:
>>>>> Add clock IDs for the mclk pads found on s4 SoCs
>>>>>
>>>>> Signed-off-by: jiebing chen <jiebing.chen@amlogic.com>
>>>>> ---
>>>>>    include/dt-bindings/clock/axg-audio-clkc.h | 11 +++++++++++
>>>> This belongs to the binding patch, usually.
>>>>
>>>> Anyway - do not ask us to do the work twice.
>>>>
>>>> <form letter>
>>>> This is a friendly reminder during the review process.
>>>>
>>>> It looks like you received a tag and forgot to add it.
>>>>
>>>> If you do not know the process, here is a short explanation:
>>>> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
>>>> versions of patchset, under or above your Signed-off-by tag, unless
>>>> patch changed significantly (e.g. new properties added to the DT
>>>> bindings). Tag is "received", when provided in a message replied to 
>>>> you
>>>> on the mailing list. Tools like b4 can help here. However, there's no
>>>> need to repost patches *only* to add the tags. The upstream maintainer
>>>> will do that for tags received on the version they apply.
>>>>
>>>> Please read:
>>>> https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577 
>>>>
>>>>
>>>> If a tag was not added on purpose, please state why and what changed.
>>>> </form letter>
>>> thanks for your remind
>> Are you going to do anything or you are going to ignore us?
>
> Sorry, I forget retrieving the tags and will check all comments 
> carefully again. Thanks you!
>
>>
>> Best regards,
>> Krzysztof

