Return-Path: <linux-kernel+bounces-199442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9D08D8740
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B27251C21A04
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B6713698E;
	Mon,  3 Jun 2024 16:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="O8Dlr/7K"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF8813BC18;
	Mon,  3 Jun 2024 16:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717431807; cv=fail; b=N+MolYJluO6V2VApMmXT96XV42xhmxpZ8Zt0zdvAvSHmjgHFQF7SGz0cqRSP3c0oXOR+65T2KsJ8md01jeSmqF76k3KQbdChS+bM/qj1qFU7TTuTEkmpYoV8QTHfcl38/gkGYVK5OP8afndPttGLQNPPiynVTtOiga/UTl6IN+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717431807; c=relaxed/simple;
	bh=vbOcRa+oUnkATwnQUB3VdjMpAcCbAgIxXpqg8Y/iNy8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hlhJ3bjNskF96NHIrETmtuubga+9TNJ5iDMibkGlDYK27UEZNC9E1ilUsJ2N1WZniw/VH83ohKBjeEdEin/qSvcywgMbv7V2R4xechcp1NibBN+l0Dp7f7cFiXpWDRC1ver6J+p2FaAACI5uN9ZCLisTYPcPgpHkKAsU9LY1MaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=O8Dlr/7K; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 453G5AGB007257;
	Mon, 3 Jun 2024 09:22:58 -0700
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yg35hdphk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 09:22:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hr/iAPZmEtea1LQE6wMjg4p3giDDirrefeU5/qlNHx6s1cVhRWGWjBdGiE4TzMKugwl+ft3BBnNklbNV5HjSXgOnQFHby+yRG4w5L/T658KW6cbt7/SANlhQozd8KW+7WOi8WSj7vQ4IkyhnQZt/tK98J6mSE+AJ6WbftBadoIxrJ7XyKOTCeIfaCjxSAL4GT/YyYlmgKhCExo+MnPtQfR+TGnmEZcsfi3zPkZZSBZnTTcqShDq2F/5A7qW/1UjcOSWRME3muTtX3XNPOLLhfumDyB7531u9sbymnpoBKlx8fTVtz/VhC1VCDjMQT5nCx/ln53q1SrkEJ7N8HB58FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qF8YzPnrMYo/uWJbmrQskVIJ7w2/hndor0zEij1g3kg=;
 b=WUBlC1tDavv3+NNXB3kSol97h0lWFjsD5mMyTgSTg++j1+oy53qz5buwFnf+Kv8ZYmn9fiMXeX6gYUQ/af/vSdnGxWXHuv8J4FLnYGojmI7pUd8D0zi8sKGsaP/2n9nv38aGsIn0Oat5mK6S+E+kwfMT20xxRP803HZTcm5RjnBref2NX8tRjaNNU/t188y0Cx00yq6qznpvTmxDpQ274Dmmh4fvTX2LZa2MCnlC+R7XrofsNbhbvvoJLl35RvCq/f6ufgqL3Ggwpm7tusgvMII4OGkueoydR4tPhzKptUlhLS8Exy8uec8SWA9inWmuIdMbYWLdTmUae1obm935Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qF8YzPnrMYo/uWJbmrQskVIJ7w2/hndor0zEij1g3kg=;
 b=O8Dlr/7K658cT+fT2mFWuH0s0NYrHpE2TX4sNtiZfQV9fsvqrMQC2Eiw67klnV9hYcHGLZ20kp5kCJjbs/tYR21/Sdh4vllrYTYyWUpn5QL5l4J+DUEyXI0t7BefS3rRbmACIo9V5lYlrwJML7bZKZql+m7CFoQa7xp0Z6w2/8A=
Received: from MW4PR18MB5084.namprd18.prod.outlook.com (2603:10b6:303:1a7::8)
 by DM8PR18MB4486.namprd18.prod.outlook.com (2603:10b6:8:26::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Mon, 3 Jun
 2024 16:22:54 +0000
Received: from MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905]) by MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905%5]) with mapi id 15.20.7633.018; Mon, 3 Jun 2024
 16:22:54 +0000
Message-ID: <2a9693e3-cd13-4161-9671-0f5175aedf38@marvell.com>
Date: Mon, 3 Jun 2024 21:52:44 +0530
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 5/5] firmware: imx: adds miscdev
To: Pankaj Gupta <pankaj.gupta@nxp.com>, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org
References: <20240523-imx-se-if-v2-0-5a6fd189a539@nxp.com>
 <20240523-imx-se-if-v2-5-5a6fd189a539@nxp.com>
Content-Language: en-US
From: Amit Singh Tomar <amitsinght@marvell.com>
In-Reply-To: <20240523-imx-se-if-v2-5-5a6fd189a539@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0168.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::23) To MW4PR18MB5084.namprd18.prod.outlook.com
 (2603:10b6:303:1a7::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR18MB5084:EE_|DM8PR18MB4486:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df3d9af-efdf-42f9-f0ea-08dc83e96beb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|7416005|366007|1800799015|376005|921011;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eUMxeEZNbzA2Z3U0NGJTdVBKZFV5ckNLeCtiNEZkTkgrWUo1ak85ZmtjSHAx?=
 =?utf-8?B?SVYyUmR6QzdQMUFDT1dOMzh3ODIvOG1LaE9tZTZpbjR5SHVPMGRMT0RkVURQ?=
 =?utf-8?B?K2w3VUxXSlZncnR6eS95dGxaQ1ZoYlBkM3hHbVU1OWdxUUQ5UVZuUXV6UllC?=
 =?utf-8?B?TGczaDhaTjRsSGtLTnB5eXkzaVgvd2xKa2hvU0J2Q1FWMW5TZkZyTy9DS0pC?=
 =?utf-8?B?WjlEcjF1UzFPbVZRQnhMUXZ5dUdzc0h6bWJjbHV0TFVRTHh2U3pkQ0psbVh6?=
 =?utf-8?B?ck5wTFFJV3VHQlBsdytVMW5tYkJjTzgrTkY4NGpaR1drRitpZXJleEhrYTRF?=
 =?utf-8?B?OC9vUWhpMTIxY3FWZnlkcTBUQjBZcjJ0cjRqSXB2TjRBNjVrTmxhNHJXVzk3?=
 =?utf-8?B?Z1NtajhrZThRQyszWnJsWlNURXd0UWVXeGhDa2FFNjZZSDUrcS9CNzdPSjE2?=
 =?utf-8?B?VVIzb0ljV0tjTmszV0dVQzFsa212ZW0xZVFOZzBiN2YzcW4yNndlemJRYXlM?=
 =?utf-8?B?c09XVHZ3N3hDZURNNGJobjFET0x5ZVgxRkdPM0dhc0pZcHdzTFZuV0k1aFYv?=
 =?utf-8?B?enFLNlFDQ1ZuUjVKOFNySWVsOVJCSmFGc3RMb2R6VWFtbWF1WFhBcTYxT1ha?=
 =?utf-8?B?VFNkT21VTTFXa2ZRL1JyQ0NWZVI1aWYvV0JzMENaRnhqUlQyTFBON2diYkZR?=
 =?utf-8?B?L3B2MllSVHhtK0R6U2pmbFdWZE5YZ1BYb3F3RVV4OVltSGI0MDBMSFR5YUVl?=
 =?utf-8?B?ZHhueGg0enp3RFlvS3lWcXE1QVhTclBldnMxZ1A1MnVjYkoxaFRxV0ptQU1E?=
 =?utf-8?B?VkNLRjlrUGhYbDNQei9uNmRvajBsa2VhcEh6dVdZZUFwRnBsSjFNQWUxeVBh?=
 =?utf-8?B?OGxsN1JoVVZKQXNFcVpCaDE3ck5VbTJrNU9GYnJTdFVtemJzc0lPbzlzdk55?=
 =?utf-8?B?M3ZvcjZLVGY3ZmNEaUdYb0JZeldjeHRCYkdiNXFoTFg1dFBzRmJVdjlYVmFN?=
 =?utf-8?B?SHdpUEdzZms4WE5hakVOMTJHUFk2OWNRU2Z0bUlrOE1odjlkdnRzcklqVTUv?=
 =?utf-8?B?YkJraHg5ZnlaeTFtNmNYb1RYUGczTXRQOUQ0Y0lWejFUaCtRdEFTMmxES0Nj?=
 =?utf-8?B?NjVsbXhqM1lON2YyeitQd3FoMk5PaDN0YW5XYXBWYTBnS1dhT3hMZlV0ZlNo?=
 =?utf-8?B?WkpCMlJyOTVVQkhGOElLc2UvQ2Ezd1VQczdpbmtmTUFaem1YYmU2U3gxMEIz?=
 =?utf-8?B?amE5Nnpxa29HTEVpYTZpU0t6NVlZWWpsT0srQU9pcDBVVGZXYTdnSVJYOFRs?=
 =?utf-8?B?RGs5cmFRTDRHT25KV3JHWG9FMjY4UXBqZUdLUkFsQTBwY0NjaldiOGt0R2pI?=
 =?utf-8?B?bDB2UnlTRlNuTWhRYS96Y3hWWjFXTlRDb1Q0UElIUGpKdDNEVUhMblFNVXR4?=
 =?utf-8?B?RWI2MWtERXBZZE9Cb0ZVWGZXQ2ZGb2Urc0xobGkyNkVYcUEyMFBwV1gvUm8z?=
 =?utf-8?B?bjFxbDdGZ3pQaGJ6dTYyM0o2d0dlUGFKOE5ZQjJ3My9TNkVqc3ZYWlVPOW1O?=
 =?utf-8?B?d1RtcnRVcHNiaWlqNkFnb09JbXdXV2VWSlpjblBtejFYNDJoL3BjUUhIQWxs?=
 =?utf-8?B?djZydVVOM2I2SXY1QlhCQjUvN0gwZStnRUxVNXBTdzJCc2V1UTU1RGJIelhV?=
 =?utf-8?B?cGFib3BDY3dUU0ZiOEd6WFF4bFcxV0g1aWdEczB5VVBHaFBiYXZySS95TG1o?=
 =?utf-8?B?NlRNTmxxeTlkZHZwM3hreW1UZVI5MUx3WDhiWXFJcnpGTnFFMlY3eFdMQ3Rv?=
 =?utf-8?B?c0xLYzlyVXFoamswcEh6Zz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5084.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WXhmMUZrR05Ucy8wUWppYVZteXJJaWFzcmRFeVhaeHRadktxVHhZemszbFNm?=
 =?utf-8?B?RU50VUlmOCtZRjBydTlRKzN5TEU0ZXFvNEN1WTgrUmdnc2JtUDhtTmJ5Q25j?=
 =?utf-8?B?NnJQbUZuNUNEVU9NT1ZWb0RCSXhwWElpd0JFVElWd0FhcEdRWHp0WTBZVWZs?=
 =?utf-8?B?ZUdmWjBRdlNiaDVRWEh4ZGxCZ1lqc2RGaVVFNjNJVzMxdEFJdzNxSCtVdUt5?=
 =?utf-8?B?c2RKcEhrVzUya2VQL2E0eklxUjFWTFRmVTlqUmNCaFMvN3Y1TkNvT2kvam53?=
 =?utf-8?B?YjFVb2RjMTg3TS9YMnNNdUllYmI4cVhrWEovcU8yajJMVm5PdkJDY0lQTUs1?=
 =?utf-8?B?TWlHMUdIeWNOaU5aa3JDcmdqMW8vRGk5Q1M4ZTBDT3F1SHFWMEJDeTJxQzkr?=
 =?utf-8?B?M0tLSEVRWnJpc01TQS9EaHk2cko4eHhhR1RTcUpnQlY2RWNldUFzNEFWdE9o?=
 =?utf-8?B?SW1FUnd6UW0vS2x3VEFGNUVYUDBZekk5UVlPTTR5cno4S0xKdmk4TURsWi9h?=
 =?utf-8?B?SVZEeGZPM0Z2aTNPNWlSOUNHd1YzMG95MmRzclJBRnlSYUFyMkV2SFR6RHJy?=
 =?utf-8?B?TmxjZFpQbkRnVGVGdEZlMGliR3psdVBScTVubGJtWmFQNDV2ZXRZdUVWc2x3?=
 =?utf-8?B?bHhVVFBMTkswcUdtc2dYcWVsTTNISVU4RVo2M1RTalBOL2cyWXRtVCtLREQ1?=
 =?utf-8?B?Ty9IcG4zSlExVExGR0Irc2V4RmowMVU0Vi9JQnJOeTZiaG84bVJzaDYyaGpY?=
 =?utf-8?B?UjdoSjYwM1ZVWG1OYWUvSVBFTFRUdlZwMzJIWWVsb2JlRWdodUNvNmQ0SkNj?=
 =?utf-8?B?Q1o5YndSRi80SmdJY2luS29sL0RSWUZMVTlYaHBQa0ZEbFNFQktSSTRveWVp?=
 =?utf-8?B?QTlORlZ1SW1PdHlmN1pVWFhSVmJTUUpIYmdJcnU4T2ZsSG5sTlc3M25vS3BE?=
 =?utf-8?B?TXlJWGlqdEZwYVZVYzFzNFpMenVxSXQzUVJrVnJNQW83VFVCOFluR3VpVUxL?=
 =?utf-8?B?WHllWVRTcDduWSs0NjZKVHhIdEJwSENmcGUwY0djZmZXWDIrSDhyVDE3bDBG?=
 =?utf-8?B?VXl4bHY4bmUyMkRGY0szUEgrdHZmTjUycHlGSE1hSll0Q2Q4UEFCRWlhLzNU?=
 =?utf-8?B?MjZ0Kyt0Ymc0VzdwOGNJb0FSNDVhSXJscXBzSXIrQlI5T0xSOFRkRGhMNTRn?=
 =?utf-8?B?RDV3SFQrTEdCM3AzeTV2NysrWkd0Y3BBOWFaaFI2MlVGSElMWHJ0ZVdqSE1o?=
 =?utf-8?B?SG5kYytVVkJHY2RLRVllQW1qN2hpTTgwRXdmR3U2MElWVjdNcloxeXN6YVpZ?=
 =?utf-8?B?MmNzcENNdDlORWFkYm8rMTliT3p3WVJvY2ZGNE1mK3dKRUdPbWY3UjUvaHFV?=
 =?utf-8?B?V0RDdmczc1JZRlZtcHBNT0RkMWc1QVNBMS9FanJqVUxISFIzSG4zMGRMUjRM?=
 =?utf-8?B?Z3ZjTWxRQTBMM1VOYUg1NUpSaWJ5MHhRalU0VmxCc2lKOHAzMnBva1A3bDh3?=
 =?utf-8?B?aE96RmdNZlE3ZExyZ3ZkckNvSm5VOG1TVlcvSThoVmFtenBlc1Q0OEJsUEZ3?=
 =?utf-8?B?eHhWSFJYZ29HSDZLMDM1L2lmTyt4ak9nYkJzUFU1Zlc3NEY5QjAzdmNUNUpj?=
 =?utf-8?B?QzU3YVpWd2I1a2x4bEZjMjMrV3VZdWUraVJTdW1HaGpaY3h2M214eXpBUEtu?=
 =?utf-8?B?WWkxZjdMUWh0ZGsyVmd3V3RpN2dRYW5DQ2NrLzNtVTN0M2lLOE52bFU0UVA2?=
 =?utf-8?B?MmNkcnVjM2FmR2lzcjdXRSsxaFZ5c3hEMzNjZkNGRnJVUllPcitMYUNqL0lO?=
 =?utf-8?B?SHJocnRjWG82Y1hIdHVTSE85QU9EL3h4bkZkckxjZ0ZrK2lnb0hIcXY2aXVH?=
 =?utf-8?B?ZExoMEFlN2tqeDdvblhLZk02Ly9oM3o2UVg1OGdrU0g0eCswaWhhVjQ5c1NT?=
 =?utf-8?B?Tmo5amlvK2x3bmtJRjRwbHJkR1ZPeWU3eGRROTB4aUZKbnlrN25ZNDVwSGZm?=
 =?utf-8?B?cGxBVTZ0cjJzWjhsWHcvK3VUSXMxRFkxMWlSQkN5UjlMbmxoczZxeDFOeWFY?=
 =?utf-8?B?c3duZnpOME5JVEU5bGRJa2JIL0xHT1UvRnlqMklVSEI3RENnci8wSitXTEc3?=
 =?utf-8?Q?uhnRhiE0/lzrnT1+FQ4YssW50?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df3d9af-efdf-42f9-f0ea-08dc83e96beb
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5084.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 16:22:54.5239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRSRHdshoePemMg3WRrZC8ARydUythXGc5oPq19Q3hhiGnbp25yfKM55N7xyEUiQacAHm2dqizHLB0vX06Sxcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR18MB4486
X-Proofpoint-GUID: nfPfwiVaMIUQ6lvez6kp7ZT7TyzkbSWy
X-Proofpoint-ORIG-GUID: nfPfwiVaMIUQ6lvez6kp7ZT7TyzkbSWy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_13,2024-05-30_01,2024-05-17_01

Hi,

> 
> ----------------------------------------------------------------------
> Adds the driver for communication interface to secure-enclave,
> for exchanging messages with NXP secure enclave HW IP(s) like
> EdgeLock Enclave from:
> - User-Space Applications via character driver.
> 
> ABI documentation for the NXP secure-enclave driver.
> 
> User-space library using this driver:
> - i.MX Secure Enclave library:
>    -- URL: https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_nxp-2Dimx_imx-2Dsecure-2Denclave.git&d=DwICAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=V_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=8xuiz3OEyshbkzLQ6-G2afLkh7sVv9b_HkFaPJVBu4wjmgAowHGi90q5RTroZ2oy&s=xi3fO_c9z_t-zdk3LdTGgqJ6M-5OjRD6oj-ECiVQ40Q&e= ,
> - i.MX Secure Middle-Ware:
>    -- URL: https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_nxp-2Dimx_imx-2Dsmw.git&d=DwICAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=V_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=8xuiz3OEyshbkzLQ6-G2afLkh7sVv9b_HkFaPJVBu4wjmgAowHGi90q5RTroZ2oy&s=jPOlKXqt_GIZGMvMboOdjkwu3UTpZ7fwEFm8Ki5z0LE&e=
> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>   Documentation/ABI/testing/se-cdev |  42 +++
>   drivers/firmware/imx/ele_common.c | 108 +++++-
>   drivers/firmware/imx/ele_common.h |   3 +
>   drivers/firmware/imx/se_ctrl.c    | 689 ++++++++++++++++++++++++++++++++++++++
>   drivers/firmware/imx/se_ctrl.h    |  46 +++
>   include/uapi/linux/se_ioctl.h     |  88 +++++
>   6 files changed, 974 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/se-cdev b/Documentation/ABI/testing/se-cdev
> new file mode 100644
> index 000000000000..699525af6b86
> --- /dev/null
> +++ b/Documentation/ABI/testing/se-cdev
> @@ -0,0 +1,42 @@
> +What:		/dev/<se>_mu[0-9]+_ch[0-9]+
> +Date:		May 2024
> +KernelVersion:	6.8
> +Contact:	linux-imx@nxp.com, pankaj.gupta@nxp.com
> +Description:
> +		NXP offers multiple hardware IP(s) for  secure-enclaves like EdgeLock-
> +		Enclave(ELE), SECO. The character device file-descriptors
> +		/dev/<se>_mu*_ch* are the interface between user-space NXP's secure-
> +		enclave shared-library and the kernel driver.
> +
> +		The ioctl(2)-based ABI is defined and documented in
> +		[include]<linux/firmware/imx/ele_mu_ioctl.h>
> +		 ioctl(s) are used primarily for:
> +			- shared memory management
> +			- allocation of I/O buffers
> +			- get mu info
> +			- setting a dev-ctx as receiver that is slave to fw
> +			- get SoC info
> +
> +		The following file operations are supported:
> +
> +		open(2)
> +		  Currently the only useful flags are O_RDWR.
> +
> +		read(2)
> +		  Every read() from the opened character device context is waiting on
> +		  wakeup_intruptible, that gets set by the registered mailbox callback
> +		  function; indicating a message received from the firmware on message-
> +		  unit.
> +
> +		write(2)
> +		  Every write() to the opened character device context needs to acquire
> +		  mailbox_lock, before sending message on to the message unit.
> +
> +		close(2)
> +		  Stops and free up the I/O contexts that was associated
> +		  with the file descriptor.
> +
> +Users:		https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_nxp-2Dimx_imx-2Dsecure-2Denclave.git&d=DwICAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=V_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=8xuiz3OEyshbkzLQ6-G2afLkh7sVv9b_HkFaPJVBu4wjmgAowHGi90q5RTroZ2oy&s=xi3fO_c9z_t-zdk3LdTGgqJ6M-5OjRD6oj-ECiVQ40Q&e= ,
> +		https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_nxp-2Dimx_imx-2Dsmw.git&d=DwICAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=V_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=8xuiz3OEyshbkzLQ6-G2afLkh7sVv9b_HkFaPJVBu4wjmgAowHGi90q5RTroZ2oy&s=jPOlKXqt_GIZGMvMboOdjkwu3UTpZ7fwEFm8Ki5z0LE&e=
> +		crypto/skcipher,
> +		drivers/nvmem/imx-ocotp-ele.c
> diff --git a/drivers/firmware/imx/ele_common.c b/drivers/firmware/imx/ele_common.c
> index c286c3d84d82..15fabc369b21 100644
> --- a/drivers/firmware/imx/ele_common.c
> +++ b/drivers/firmware/imx/ele_common.c
> @@ -78,12 +78,98 @@ int imx_ele_msg_send_rcv(struct se_if_priv *priv, void *tx_msg, void *rx_msg)
>   	return err;
>   }
>   
> +int imx_ele_miscdev_msg_rcv(struct se_if_device_ctx *dev_ctx)
> +{
> +	struct se_msg_hdr *header = {0};
> +	int err;
> +
> +	if (dev_ctx->priv->waiting_rsp_dev == dev_ctx)
> +		lockdep_assert_held(&dev_ctx->priv->se_if_cmd_lock);
> +
> +	err = wait_event_interruptible(dev_ctx->wq, dev_ctx->pending_hdr != 0);
> +	if (err)
> +		dev_err(dev_ctx->dev,
> +			"%s: Err[0x%x]:Interrupted by signal.\n",
> +			dev_ctx->miscdev.name, err);
> +
> +	header = (struct se_msg_hdr *) dev_ctx->temp_resp;
> +
> +	if (header->tag == dev_ctx->priv->rsp_tag) {
> +		if (dev_ctx->priv->waiting_rsp_dev != dev_ctx)
> +			dev_warn(dev_ctx->dev,
> +			"%s: Device context waiting for response mismatch.\n",
> +			dev_ctx->miscdev.name);
> +		else
> +			dev_ctx->priv->waiting_rsp_dev = NULL;
> +
> +		mutex_unlock(&dev_ctx->priv->se_if_cmd_lock);
> +	}
> +
> +	return err;
> +}
> +
> +int imx_ele_miscdev_msg_send(struct se_if_device_ctx *dev_ctx,
> +			     void *tx_msg, int tx_msg_sz)
> +{
> +	struct se_if_priv *priv = dev_ctx->priv;
> +	struct se_msg_hdr *header;
> +	int err;
> +
> +	header = (struct se_msg_hdr *) tx_msg;
> +
> +	/*
> +	 * Check that the size passed as argument matches the size
> +	 * carried in the message.
> +	 */
> +	err = header->size << 2;
> +
> +	if (err != tx_msg_sz) {
> +		err = -EINVAL;
> +		dev_err(priv->dev,
> +			"%s: User buffer too small\n",
> +				dev_ctx->miscdev.name);
> +		goto exit;
> +	}
> +	/* Check the message is valid according to tags */
> +	if (header->tag == priv->cmd_tag) {
> +		mutex_lock(&priv->se_if_cmd_lock);

In the previous patch (4/5), you used 'guard' locks. Wouldn't it be 
better to use them here as well, considering the lock handling seems a 
bit dodgy (I mean, the way lock is released only under certain condition)?

> +		priv->waiting_rsp_dev = dev_ctx;
> +	} else if (header->tag == priv->rsp_tag) {
> +		/* Check the device context can send the command */
> +		if (dev_ctx != priv->cmd_receiver_dev) {
> +			dev_err(priv->dev,
> +				"%s: Channel not configured to send resp to FW.",
> +				dev_ctx->miscdev.name);
> +			err = -EPERM;
> +			goto exit;
> +		}
> +	} else {
> +		dev_err(priv->dev,
> +			"%s: The message does not have a valid TAG\n",
> +				dev_ctx->miscdev.name);
> +		err = -EINVAL;
> +		goto exit;
> +	}
> +	err = imx_ele_msg_send(priv, tx_msg);
> +	if (err < 0) {
> +		if (header->tag == priv->cmd_tag) {
> +			priv->waiting_rsp_dev = NULL;
> +			mutex_unlock(&dev_ctx->priv->se_if_cmd_lock);
> +		}
> +	} else
> +		err = header->size << 2;
> +exit:
> +	return err;
> +}
> +
>   /*
>    * Callback called by mailbox FW, when data is received.
>    */
>   void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
>   {
>   	struct device *dev = mbox_cl->dev;
> +	struct se_if_device_ctx *dev_ctx;
> +	struct se_api_msg *rx_msg;
>   	struct se_if_priv *priv;
>   	struct se_msg_hdr *header;
>   
> @@ -97,8 +183,15 @@ void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
>   
>   	header = (struct se_msg_hdr *) msg;
>   
> -	if (header->tag == priv->rsp_tag) {
> -		if (!priv->waiting_rsp_dev) {
> +	/* Incoming command: wake up the receiver if any. */
> +	if (header->tag == priv->cmd_tag) {
> +		dev_dbg(dev, "Selecting cmd receiver\n");
> +		dev_ctx = priv->cmd_receiver_dev;
> +	} else if (header->tag == priv->rsp_tag) {
> +		if (priv->waiting_rsp_dev) {
> +			dev_dbg(dev, "Selecting rsp waiter\n");
> +			dev_ctx = priv->waiting_rsp_dev;
> +		} else {
>   			/*
>   			 * Reading the EdgeLock Enclave response
>   			 * to the command, sent by other
> @@ -116,6 +209,17 @@ void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
>   				*((u32 *) header));
>   		return;
>   	}
> +	/* Init reception */
> +	rx_msg = kzalloc(header->size << 2, GFP_KERNEL);
> +	if (rx_msg)
> +		memcpy(rx_msg, msg, header->size << 2);
> +
> +	dev_ctx->temp_resp = (u32 *)rx_msg;
> +	dev_ctx->temp_resp_size = header->size;
> +
> +	/* Allow user to read */
> +	dev_ctx->pending_hdr = 1;
> +	wake_up_interruptible(&dev_ctx->wq);
>   }
>   
>   int validate_rsp_hdr(struct se_if_priv *priv,
> diff --git a/drivers/firmware/imx/ele_common.h b/drivers/firmware/imx/ele_common.h
> index 76777ac629d6..11b9b36d4fda 100644
> --- a/drivers/firmware/imx/ele_common.h
> +++ b/drivers/firmware/imx/ele_common.h
> @@ -12,6 +12,9 @@
>   #define IMX_ELE_FW_DIR                 "imx/ele/"
>   
>   uint32_t plat_add_msg_crc(uint32_t *msg, uint32_t msg_len);
> +int imx_ele_miscdev_msg_rcv(struct se_if_device_ctx *priv);
> +int imx_ele_miscdev_msg_send(struct se_if_device_ctx *dev_ctx,
> +			     void *tx_msg, int tx_msg_sz);
>   int imx_ele_msg_rcv(struct se_if_priv *priv);
>   int imx_ele_msg_send(struct se_if_priv *priv, void *tx_msg);
>   int imx_ele_msg_send_rcv(struct se_if_priv *priv, void *tx_msg, void *rx_msg);
> diff --git a/drivers/firmware/imx/se_ctrl.c b/drivers/firmware/imx/se_ctrl.c
> index 0642d349b3d3..3acaecd8f3bc 100644
> --- a/drivers/firmware/imx/se_ctrl.c
> +++ b/drivers/firmware/imx/se_ctrl.c
> @@ -23,6 +23,7 @@
>   #include <linux/slab.h>
>   #include <linux/string.h>
>   #include <linux/sys_soc.h>
> +#include <uapi/linux/se_ioctl.h>
>   
>   #include "ele_base_msg.h"
>   #include "ele_common.h"
> @@ -232,6 +233,590 @@ static int imx_fetch_se_soc_info(struct device *dev)
>   	return 0;
>   }
>   
> +/*
> + * File operations for user-space
> + */
> +
> +/* Write a message to the MU. */
> +static ssize_t se_if_fops_write(struct file *fp, const char __user *buf,
> +				size_t size, loff_t *ppos)
> +{
> +	struct se_api_msg *tx_msg __free(kfree);
> +	struct se_if_device_ctx *dev_ctx;
> +	struct se_if_priv *priv;
> +	int err;
> +
> +	dev_ctx = container_of(fp->private_data,
> +			       struct se_if_device_ctx,
> +			       miscdev);
> +	priv = dev_ctx->priv;
> +	dev_dbg(priv->dev,
> +		"%s: write from buf (%p)%zu, ppos=%lld\n",
> +			dev_ctx->miscdev.name,
> +			buf, size, ((ppos) ? *ppos : 0));
> +
> +	if (down_interruptible(&dev_ctx->fops_lock))
> +		return -EBUSY;
> +
> +	if (dev_ctx->status != SE_IF_CTX_OPENED) {
> +		err = -EINVAL;
> +		goto exit;
> +	}
> +
> +	if (size < SE_MU_HDR_SZ) {
> +		dev_err(priv->dev,
> +			"%s: User buffer too small(%zu < %d)\n",
> +				dev_ctx->miscdev.name,
> +				size, SE_MU_HDR_SZ);
> +		err = -ENOSPC;
> +		goto exit;
> +	}
> +	tx_msg = memdup_user(buf, size);
> +	if (!tx_msg) {
> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	print_hex_dump_debug("from user ", DUMP_PREFIX_OFFSET, 4, 4,
> +			     tx_msg, size, false);
> +
> +	err = imx_ele_miscdev_msg_send(dev_ctx, tx_msg, size);
> +
> +exit:
> +	up(&dev_ctx->fops_lock);
> +	return err;
> +}
> +
> +/*
> + * Read a message from the MU.
> + * Blocking until a message is available.
> + */
> +static ssize_t se_if_fops_read(struct file *fp, char __user *buf,
> +			       size_t size, loff_t *ppos)
> +{
> +	struct se_if_device_ctx *dev_ctx;
> +	struct se_buf_desc *b_desc;
> +	struct se_if_priv *priv;
> +	u32 size_to_copy;
> +	int err;
> +
> +	dev_ctx = container_of(fp->private_data,
> +			       struct se_if_device_ctx,
> +			       miscdev);
> +	priv = dev_ctx->priv;
> +	dev_dbg(priv->dev,
> +		"%s: read to buf %p(%zu), ppos=%lld\n",
> +			dev_ctx->miscdev.name,
> +			buf, size, ((ppos) ? *ppos : 0));
> +
> +	if (down_interruptible(&dev_ctx->fops_lock))
> +		return -EBUSY;
> +
> +	if (dev_ctx->status != SE_IF_CTX_OPENED) {
> +		err = -EINVAL;
> +		goto exit;
> +	}
> +
> +	err = imx_ele_miscdev_msg_rcv(dev_ctx);
> +	if (err)
> +		goto exit;
> +
> +	/* Buffer containing the message from FW, is
> +	 * allocated in callback function.
> +	 * Check if buffer allocation failed.
> +	 */
> +	if (!dev_ctx->temp_resp) {
> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	dev_dbg(priv->dev,
> +			"%s: %s %s\n",
> +			dev_ctx->miscdev.name,
> +			__func__,
> +			"message received, start transmit to user");
> +
> +	/*
> +	 * Check that the size passed as argument is larger than
> +	 * the one carried in the message.
> +	 */
> +	size_to_copy = dev_ctx->temp_resp_size << 2;
> +	if (size_to_copy > size) {
> +		dev_dbg(priv->dev,
> +			"%s: User buffer too small (%zu < %d)\n",
> +				dev_ctx->miscdev.name,
> +				size, size_to_copy);
> +		size_to_copy = size;
> +	}
> +
> +	/*
> +	 * We may need to copy the output data to user before
> +	 * delivering the completion message.
> +	 */
> +	while (!list_empty(&dev_ctx->pending_out)) {
> +		b_desc = list_first_entry_or_null(&dev_ctx->pending_out,
> +						  struct se_buf_desc,
> +						  link);
> +		if (!b_desc)
> +			continue;
> +
> +		if (b_desc->usr_buf_ptr && b_desc->shared_buf_ptr) {
> +
> +			dev_dbg(priv->dev,
> +				"%s: Copy output data to user\n",
> +				dev_ctx->miscdev.name);
> +			if (copy_to_user(b_desc->usr_buf_ptr,
> +					 b_desc->shared_buf_ptr,
> +					 b_desc->size)) {
> +				dev_err(priv->dev,
> +					"%s: Failure copying output data to user.",
> +					dev_ctx->miscdev.name);
> +				err = -EFAULT;
> +				goto exit;
> +			}
> +		}
> +
> +		if (b_desc->shared_buf_ptr)
> +			memset(b_desc->shared_buf_ptr, 0, b_desc->size);
> +
> +		__list_del_entry(&b_desc->link);
> +		kfree(b_desc);
> +	}
> +
> +	/* Copy data from the buffer */
> +	print_hex_dump_debug("to user ", DUMP_PREFIX_OFFSET, 4, 4,
> +			     dev_ctx->temp_resp, size_to_copy, false);
> +	if (copy_to_user(buf, dev_ctx->temp_resp, size_to_copy)) {
> +		dev_err(priv->dev,
> +			"%s: Failed to copy to user\n",
> +				dev_ctx->miscdev.name);
> +		err = -EFAULT;
> +		goto exit;
> +	}
> +
> +	err = size_to_copy;
> +	kfree(dev_ctx->temp_resp);
> +
> +	/* free memory allocated on the shared buffers. */
> +	dev_ctx->secure_mem.pos = 0;
> +	dev_ctx->non_secure_mem.pos = 0;
> +
> +	dev_ctx->pending_hdr = 0;
> +
> +exit:
> +	/*
> +	 * Clean the used Shared Memory space,
> +	 * whether its Input Data copied from user buffers, or
> +	 * Data received from FW.
> +	 */
> +	while (!list_empty(&dev_ctx->pending_in) ||
> +	       !list_empty(&dev_ctx->pending_out)) {
> +		if (!list_empty(&dev_ctx->pending_in))
> +			b_desc = list_first_entry_or_null(&dev_ctx->pending_in,
> +							  struct se_buf_desc,
> +							  link);
> +		else
> +			b_desc = list_first_entry_or_null(&dev_ctx->pending_out,
> +							  struct se_buf_desc,
> +							  link);
> +
> +		if (!b_desc)
> +			continue;
> +
> +		if (b_desc->shared_buf_ptr)
> +			memset(b_desc->shared_buf_ptr, 0, b_desc->size);
> +
> +		__list_del_entry(&b_desc->link);
> +		kfree(b_desc);
> +	}
> +
> +	up(&dev_ctx->fops_lock);
> +	return err;
> +}
> +
> +static int se_ioctl_get_mu_info(struct se_if_device_ctx *dev_ctx,
> +				u64 arg)
> +{
> +	struct se_if_priv *priv = dev_get_drvdata(dev_ctx->dev);
> +	struct imx_se_node_info *if_node_info;
> +	struct se_ioctl_get_if_info info;
> +	int err = 0;
> +
> +	if_node_info = (struct imx_se_node_info *)priv->info;
> +
> +	info.se_if_id = if_node_info->se_if_id;
> +	info.interrupt_idx = 0;
> +	info.tz = 0;
> +	info.did = if_node_info->se_if_did;
> +	info.cmd_tag = if_node_info->cmd_tag;
> +	info.rsp_tag = if_node_info->rsp_tag;
> +	info.success_tag = if_node_info->success_tag;
> +	info.base_api_ver = if_node_info->base_api_ver;
> +	info.fw_api_ver = if_node_info->fw_api_ver;
> +
> +	dev_dbg(priv->dev,
> +		"%s: info [se_if_id: %d, irq_idx: %d, tz: 0x%x, did: 0x%x]\n",
> +			dev_ctx->miscdev.name,
> +			info.se_if_id, info.interrupt_idx, info.tz, info.did);
> +
> +	if (copy_to_user((u8 *)arg, &info, sizeof(info))) {
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Failed to copy mu info to user\n",
> +				dev_ctx->miscdev.name);
> +		err = -EFAULT;
> +		goto exit;
> +	}
> +
> +exit:
> +	return err;
> +}
> +
> +/*
> + * Copy a buffer of data to/from the user and return the address to use in
> + * messages
> + */
> +static int se_ioctl_setup_iobuf_handler(struct se_if_device_ctx *dev_ctx,
> +					    u64 arg)
> +{
> +	struct se_shared_mem *shared_mem = NULL;
> +	struct se_ioctl_setup_iobuf io = {0};
> +	struct se_buf_desc *b_desc = NULL;
> +	int err = 0;
> +	u32 pos;
> +
> +	if (copy_from_user(&io, (u8 *)arg, sizeof(io))) {
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Failed copy iobuf config from user\n",
> +				dev_ctx->miscdev.name);
> +		err = -EFAULT;
> +		goto exit;
> +	}
> +
> +	dev_dbg(dev_ctx->priv->dev,
> +			"%s: io [buf: %p(%d) flag: %x]\n",
> +			dev_ctx->miscdev.name,
> +			io.user_buf, io.length, io.flags);
> +
> +	if (io.length == 0 || !io.user_buf) {
> +		/*
> +		 * Accept NULL pointers since some buffers are optional
> +		 * in FW commands. In this case we should return 0 as
> +		 * pointer to be embedded into the message.
> +		 * Skip all data copy part of code below.
> +		 */
> +		io.ele_addr = 0;
> +		goto copy;
> +	}
> +
> +	/* Select the shared memory to be used for this buffer. */
> +	if (io.flags & SE_MU_IO_FLAGS_USE_SEC_MEM) {
> +		/* App requires to use secure memory for this buffer.*/
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Failed allocate SEC MEM memory\n",
> +				dev_ctx->miscdev.name);
> +		err = -EFAULT;
> +		goto exit;
> +	} else {
> +		/* No specific requirement for this buffer. */
> +		shared_mem = &dev_ctx->non_secure_mem;
> +	}
> +
> +	/* Check there is enough space in the shared memory. */
> +	if (shared_mem->size < shared_mem->pos
> +			|| io.length >= shared_mem->size - shared_mem->pos) {
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Not enough space in shared memory\n",
> +				dev_ctx->miscdev.name);
> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	/* Allocate space in shared memory. 8 bytes aligned. */
> +	pos = shared_mem->pos;
> +	shared_mem->pos += round_up(io.length, 8u);
> +	io.ele_addr = (u64)shared_mem->dma_addr + pos;
> +
> +	if ((io.flags & SE_MU_IO_FLAGS_USE_SEC_MEM) &&
> +	    !(io.flags & SE_MU_IO_FLAGS_USE_SHORT_ADDR)) {
> +		/*Add base address to get full address.*/
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Failed allocate SEC MEM memory\n",
> +				dev_ctx->miscdev.name);
> +		err = -EFAULT;
> +		goto exit;
> +	}
> +
> +	memset(shared_mem->ptr + pos, 0, io.length);
> +	if ((io.flags & SE_IO_BUF_FLAGS_IS_INPUT) ||
> +	    (io.flags & SE_IO_BUF_FLAGS_IS_IN_OUT)) {
> +		/*
> +		 * buffer is input:
> +		 * copy data from user space to this allocated buffer.
> +		 */
> +		if (copy_from_user(shared_mem->ptr + pos, io.user_buf,
> +				   io.length)) {
> +			dev_err(dev_ctx->priv->dev,
> +				"%s: Failed copy data to shared memory\n",
> +				dev_ctx->miscdev.name);
> +			err = -EFAULT;
> +			goto exit;
> +		}
> +	}
> +
> +	b_desc = kzalloc(sizeof(*b_desc), GFP_KERNEL);
> +	if (!b_desc) {
> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +
> +copy:
> +	/* Provide the EdgeLock Enclave address to user space only if success.*/
> +	if (copy_to_user((u8 *)arg, &io, sizeof(io))) {
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Failed to copy iobuff setup to user\n",
> +				dev_ctx->miscdev.name);
> +		kfree(b_desc);
> +		err = -EFAULT;
> +		goto exit;
> +	}
> +
> +	if (b_desc) {
> +		b_desc->shared_buf_ptr = shared_mem->ptr + pos;
> +		b_desc->usr_buf_ptr = io.user_buf;
> +		b_desc->size = io.length;
> +
> +		if (io.flags & SE_IO_BUF_FLAGS_IS_INPUT) {
> +			/*
> +			 * buffer is input:
> +			 * add an entry in the "pending input buffers" list so
> +			 * that copied data can be cleaned from shared memory
> +			 * later.
> +			 */
> +			list_add_tail(&b_desc->link, &dev_ctx->pending_in);
> +		} else {
> +			/*
> +			 * buffer is output:
> +			 * add an entry in the "pending out buffers" list so data
> +			 * can be copied to user space when receiving Secure-Enclave
> +			 * response.
> +			 */
> +			list_add_tail(&b_desc->link, &dev_ctx->pending_out);
> +		}
> +	}
> +
> +exit:
> +	return err;
> +}
> +
> +/* IOCTL to provide SoC information */
> +static int se_ioctl_get_se_soc_info_handler(struct se_if_device_ctx *dev_ctx,
> +					     u64 arg)
> +{
> +	struct imx_se_node_info_list *info_list;
> +	struct se_ioctl_get_soc_info soc_info;
> +	int err = -EINVAL;
> +
> +	info_list = (struct imx_se_node_info_list *)
> +			device_get_match_data(dev_ctx->priv->dev);
> +	if (!info_list)
> +		goto exit;
> +
> +	soc_info.soc_id = info_list->soc_id;
> +	soc_info.soc_rev = dev_ctx->priv->soc_rev;
> +
> +	err = (int)copy_to_user((u8 *)arg, (u8 *)(&soc_info), sizeof(soc_info));
> +	if (err) {
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Failed to copy soc info to user\n",
> +			dev_ctx->miscdev.name);
> +		err = -EFAULT;
> +		goto exit;
> +	}
> +
> +exit:
> +	return err;
> +}
> +
> +/* Open a character device. */
> +static int se_if_fops_open(struct inode *nd, struct file *fp)
> +{
> +	struct se_if_device_ctx *dev_ctx = container_of(fp->private_data,
> +							struct se_if_device_ctx,
> +							miscdev);
> +	int err = 0;
> +
> +	/* Avoid race if opened at the same time */
> +	if (down_trylock(&dev_ctx->fops_lock))
> +		return -EBUSY;
> +
> +	/* Authorize only 1 instance. */
> +	if (dev_ctx->status != SE_IF_CTX_FREE) {
> +		err = -EBUSY;
> +		goto exit;
> +	}
> +
> +	/*
> +	 * Allocate some memory for data exchanges with S40x.
> +	 * This will be used for data not requiring secure memory.
> +	 */
> +	dev_ctx->non_secure_mem.ptr = dmam_alloc_coherent(dev_ctx->dev,
> +					MAX_DATA_SIZE_PER_USER,
> +					&dev_ctx->non_secure_mem.dma_addr,
> +					GFP_KERNEL);
> +	if (!dev_ctx->non_secure_mem.ptr) {
> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	dev_ctx->non_secure_mem.size = MAX_DATA_SIZE_PER_USER;
> +	dev_ctx->non_secure_mem.pos = 0;
> +	dev_ctx->status = SE_IF_CTX_OPENED;
> +
> +	dev_ctx->pending_hdr = 0;
> +
> +	goto exit;
> +
> +	dmam_free_coherent(dev_ctx->priv->dev, MAX_DATA_SIZE_PER_USER,
> +			   dev_ctx->non_secure_mem.ptr,
> +			   dev_ctx->non_secure_mem.dma_addr);
> +
> +exit:
> +	up(&dev_ctx->fops_lock);
> +	return err;
> +}
> +
> +/* Close a character device. */
> +static int se_if_fops_close(struct inode *nd, struct file *fp)
> +{
> +	struct se_if_device_ctx *dev_ctx = container_of(fp->private_data,
> +							struct se_if_device_ctx,
> +							miscdev);
> +	struct se_if_priv *priv = dev_ctx->priv;
> +	struct se_buf_desc *b_desc;
> +
> +	/* Avoid race if closed at the same time */
> +	if (down_trylock(&dev_ctx->fops_lock))
> +		return -EBUSY;
> +
> +	/* The device context has not been opened */
> +	if (dev_ctx->status != SE_IF_CTX_OPENED)
> +		goto exit;
> +
> +	/* check if this device was registered as command receiver. */
> +	if (priv->cmd_receiver_dev == dev_ctx)
> +		priv->cmd_receiver_dev = NULL;
> +
> +	/* check if this device was registered as waiting response. */
> +	if (priv->waiting_rsp_dev == dev_ctx) {
> +		priv->waiting_rsp_dev = NULL;
> +		mutex_unlock(&priv->se_if_cmd_lock);
> +	}
> +
> +	/* Unmap secure memory shared buffer. */
> +	if (dev_ctx->secure_mem.ptr)
> +		devm_iounmap(dev_ctx->dev, dev_ctx->secure_mem.ptr);
> +
> +	dev_ctx->secure_mem.ptr = NULL;
> +	dev_ctx->secure_mem.dma_addr = 0;
> +	dev_ctx->secure_mem.size = 0;
> +	dev_ctx->secure_mem.pos = 0;
> +
> +	/* Free non-secure shared buffer. */
> +	dmam_free_coherent(dev_ctx->priv->dev, MAX_DATA_SIZE_PER_USER,
> +			   dev_ctx->non_secure_mem.ptr,
> +			   dev_ctx->non_secure_mem.dma_addr);
> +
> +	dev_ctx->non_secure_mem.ptr = NULL;
> +	dev_ctx->non_secure_mem.dma_addr = 0;
> +	dev_ctx->non_secure_mem.size = 0;
> +	dev_ctx->non_secure_mem.pos = 0;
> +
> +	while (!list_empty(&dev_ctx->pending_in) ||
> +	       !list_empty(&dev_ctx->pending_out)) {
> +		if (!list_empty(&dev_ctx->pending_in))
> +			b_desc = list_first_entry_or_null(&dev_ctx->pending_in,
> +							  struct se_buf_desc,
> +							  link);
> +		else
> +			b_desc = list_first_entry_or_null(&dev_ctx->pending_out,
> +							  struct se_buf_desc,
> +							  link);
> +
> +		if (!b_desc)
> +			continue;
> +
> +		if (b_desc->shared_buf_ptr)
> +			memset(b_desc->shared_buf_ptr, 0, b_desc->size);
> +
> +		__list_del_entry(&b_desc->link);
> +		kfree(b_desc);
> +	}
> +
> +	dev_ctx->status = SE_IF_CTX_FREE;
> +
> +exit:
> +	up(&dev_ctx->fops_lock);
> +	return 0;
> +}
> +
> +/* IOCTL entry point of a character device */
> +static long se_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
> +{
> +	struct se_if_device_ctx *dev_ctx = container_of(fp->private_data,
> +							struct se_if_device_ctx,
> +							miscdev);
> +	struct se_if_priv *se_if_priv = dev_ctx->priv;
> +	int err = -EINVAL;
> +
> +	/* Prevent race during change of device context */
> +	if (down_interruptible(&dev_ctx->fops_lock))
> +		return -EBUSY;
> +
> +	switch (cmd) {
> +	case SE_IOCTL_ENABLE_CMD_RCV:
> +		if (!se_if_priv->cmd_receiver_dev) {
> +			se_if_priv->cmd_receiver_dev = dev_ctx;
> +			err = 0;
> +		}
> +		break;
> +	case SE_IOCTL_GET_MU_INFO:
> +		err = se_ioctl_get_mu_info(dev_ctx, arg);
> +		break;
> +	case SE_IOCTL_SETUP_IOBUF:
> +		err = se_ioctl_setup_iobuf_handler(dev_ctx, arg);
> +		break;
> +	case SE_IOCTL_GET_SOC_INFO:
> +		err = se_ioctl_get_se_soc_info_handler(dev_ctx, arg);
> +		break;
> +
> +	default:
> +		err = -EINVAL;
> +		dev_dbg(se_if_priv->dev,
> +			"%s: IOCTL %.8x not supported\n",
> +				dev_ctx->miscdev.name,
> +				cmd);
> +	}
> +
> +	up(&dev_ctx->fops_lock);
> +	return (long)err;
> +}
> +
> +/* Char driver setup */
> +static const struct file_operations se_if_fops = {
> +	.open		= se_if_fops_open,
> +	.owner		= THIS_MODULE,
> +	.release	= se_if_fops_close,
> +	.unlocked_ioctl = se_ioctl,
> +	.read		= se_if_fops_read,
> +	.write		= se_if_fops_write,
> +};
> +
> +/* interface for managed res to unregister a character device */
> +static void if_misc_deregister(void *miscdevice)
> +{
> +	misc_deregister(miscdevice);
> +}
> +
>   /* interface for managed res to free a mailbox channel */
>   static void if_mbox_free_channel(void *mbox_chan)
>   {
> @@ -270,6 +855,7 @@ static int se_probe_if_cleanup(struct platform_device *pdev)
>   	struct device *dev = &pdev->dev;
>   	struct se_if_priv *priv;
>   	int ret = 0;
> +	int i;
>   
>   	priv = dev_get_drvdata(dev);
>   	if (!priv) {
> @@ -294,6 +880,17 @@ static int se_probe_if_cleanup(struct platform_device *pdev)
>   		priv->imem.buf = NULL;
>   	}
>   
> +	if (priv->ctxs) {
> +		for (i = 0; i < priv->max_dev_ctx; i++) {
> +			if (priv->ctxs[i]) {
> +				devm_remove_action(dev,
> +						   if_misc_deregister,
> +						   &priv->ctxs[i]->miscdev);
> +				misc_deregister(&priv->ctxs[i]->miscdev);
> +			}
> +		}
> +	}
> +
>   	if (priv->flags & RESERVED_DMA_POOL) {
>   		of_reserved_mem_device_release(dev);
>   		priv->flags &= (~RESERVED_DMA_POOL);
> @@ -302,6 +899,84 @@ static int se_probe_if_cleanup(struct platform_device *pdev)
>   	return ret;
>   }
>   
> +static int init_device_context(struct device *dev)
> +{
> +	const struct imx_se_node_info *info;
> +	struct se_if_device_ctx *dev_ctx;
> +	struct se_if_priv *priv;
> +	u8 *devname;
> +	int ret = 0;
> +	int i;
> +
> +	priv = dev_get_drvdata(dev);
> +
> +	if (!priv) {
> +		ret = -EINVAL;
> +		dev_err(dev, "Invalid SE-MU Priv data");
> +		return ret;
> +	}
> +	info = priv->info;
> +
> +	priv->ctxs = devm_kzalloc(dev, sizeof(dev_ctx) * priv->max_dev_ctx,
> +				  GFP_KERNEL);
> +
> +	if (!priv->ctxs) {
> +		ret = -ENOMEM;
> +		return ret;
> +	}
> +
> +	/* Create users */
> +	for (i = 0; i < priv->max_dev_ctx; i++) {
> +		dev_ctx = devm_kzalloc(dev, sizeof(*dev_ctx), GFP_KERNEL);
> +		if (!dev_ctx) {
> +			ret = -ENOMEM;
> +			return ret;
> +		}
> +
> +		dev_ctx->dev = dev;
> +		dev_ctx->status = SE_IF_CTX_FREE;
> +		dev_ctx->priv = priv;
> +
> +		priv->ctxs[i] = dev_ctx;
> +
> +		/* Default value invalid for an header. */
> +		init_waitqueue_head(&dev_ctx->wq);
> +
> +		INIT_LIST_HEAD(&dev_ctx->pending_out);
> +		INIT_LIST_HEAD(&dev_ctx->pending_in);
> +		sema_init(&dev_ctx->fops_lock, 1);
> +
> +		devname = devm_kasprintf(dev, GFP_KERNEL, "%s_ch%d",
> +					 info->se_name, i);
> +		if (!devname) {
> +			ret = -ENOMEM;
> +			return ret;
> +		}
> +
> +		dev_ctx->miscdev.name = devname;
> +		dev_ctx->miscdev.minor = MISC_DYNAMIC_MINOR;
> +		dev_ctx->miscdev.fops = &se_if_fops;
> +		dev_ctx->miscdev.parent = dev;
> +		ret = misc_register(&dev_ctx->miscdev);
> +		if (ret) {
> +			dev_err(dev, "failed to register misc device %d\n",
> +				ret);
> +			return ret;
> +		}
> +
> +		ret = devm_add_action(dev, if_misc_deregister,
> +				      &dev_ctx->miscdev);
> +		if (ret) {
> +			dev_err(dev,
> +				"failed[%d] to add action to the misc-dev\n",
> +				ret);
> +			return ret;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
>   static void se_load_firmware(const struct firmware *fw, void *context)
>   {
>   	struct se_if_priv *priv = (struct se_if_priv *) context;
> @@ -461,6 +1136,16 @@ static int se_if_probe(struct platform_device *pdev)
>   		}
>   	}
>   
> +	if (info->max_dev_ctx) {
> +		ret = init_device_context(dev);
> +		if (ret) {
> +			dev_err(dev,
> +				"Failed[0x%x] to create device contexts.\n",
> +				ret);
> +			goto exit;
> +		}
> +	}
> +
>   	dev_info(dev, "i.MX secure-enclave: %s interface to firmware, configured.\n",
>   		 info->se_name);
>   	return devm_of_platform_populate(dev);
> @@ -502,6 +1187,10 @@ static int se_resume(struct device *dev)
>   	struct se_if_priv *priv = dev_get_drvdata(dev);
>   	const struct imx_se_node_info *info
>   					= priv->info;
> +	int i;
> +
> +	for (i = 0; i < priv->max_dev_ctx; i++)
> +		wake_up_interruptible(&priv->ctxs[i]->wq);
>   
>   	if (info && info->imem_mgmt)
>   		se_restore_imem_state(dev);
> diff --git a/drivers/firmware/imx/se_ctrl.h b/drivers/firmware/imx/se_ctrl.h
> index 7d4f439a6158..41d9cedb05d7 100644
> --- a/drivers/firmware/imx/se_ctrl.h
> +++ b/drivers/firmware/imx/se_ctrl.h
> @@ -13,15 +13,61 @@
>   #define MAX_FW_LOAD_RETRIES		50
>   
>   #define RES_STATUS(x)			FIELD_GET(0x000000ff, x)
> +#define MAX_DATA_SIZE_PER_USER		(65 * 1024)
>   #define MESSAGING_VERSION_6		0x6
>   #define MESSAGING_VERSION_7		0x7
>   
> +#define SE_MU_IO_FLAGS_USE_SEC_MEM	(0x02u)
> +#define SE_MU_IO_FLAGS_USE_SHORT_ADDR	(0x04u)
> +
>   struct se_imem_buf {
>   	u8 *buf;
>   	phys_addr_t phyaddr;
>   	u32 size;
>   };
>   
> +struct se_buf_desc {
> +	u8 *shared_buf_ptr;
> +	u8 *usr_buf_ptr;
> +	u32 size;
> +	struct list_head link;
> +};
> +
> +/* Status of a char device */
> +enum se_if_dev_ctx_status_t {
> +	SE_IF_CTX_FREE,
> +	SE_IF_CTX_OPENED
> +};
> +
> +struct se_shared_mem {
> +	dma_addr_t dma_addr;
> +	u32 size;
> +	u32 pos;
> +	u8 *ptr;
> +};
> +
> +/* Private struct for each char device instance. */
> +struct se_if_device_ctx {
> +	struct device *dev;
> +	struct se_if_priv *priv;
> +	struct miscdevice miscdev;
> +
> +	enum se_if_dev_ctx_status_t status;
> +	wait_queue_head_t wq;
> +	struct semaphore fops_lock;
> +
> +	u32 pending_hdr;
> +	struct list_head pending_in;
> +	struct list_head pending_out;
> +
> +	struct se_shared_mem secure_mem;
> +	struct se_shared_mem non_secure_mem;
> +
> +	u32 *temp_resp;
> +	u32 temp_resp_size;
> +	struct notifier_block se_notify;
> +};
> +
>   /* Header of the messages exchange with the EdgeLock Enclave */
>   struct se_msg_hdr {
>   	u8 ver;
> diff --git a/include/uapi/linux/se_ioctl.h b/include/uapi/linux/se_ioctl.h
> new file mode 100644
> index 000000000000..f68a36e9da2c
> --- /dev/null
> +++ b/include/uapi/linux/se_ioctl.h
> @@ -0,0 +1,88 @@
> +/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause*/
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#ifndef SE_IOCTL_H
> +#define SE_IOCTL_H
> +
> +/* IOCTL definitions. */
> +
> +struct se_ioctl_setup_iobuf {
> +	u8 *user_buf;
> +	u32 length;
> +	u32 flags;
> +	u64 ele_addr;
> +};
> +
> +struct se_ioctl_shared_mem_cfg {
> +	u32 base_offset;
> +	u32 size;
> +};
> +
> +struct se_ioctl_get_if_info {
> +	u8 se_if_id;
> +	u8 interrupt_idx;
> +	u8 tz;
> +	u8 did;
> +	u8 cmd_tag;
> +	u8 rsp_tag;
> +	u8 success_tag;
> +	u8 base_api_ver;
> +	u8 fw_api_ver;
> +};
> +
> +struct se_ioctl_signed_message {
> +	u8 *message;
> +	u32 msg_size;
> +	u32 error_code;
> +};
> +
> +struct se_ioctl_get_soc_info {
> +	u16 soc_id;
> +	u16 soc_rev;
> +};
> +
> +/* IO Buffer Flags */
> +#define SE_IO_BUF_FLAGS_IS_OUTPUT	(0x00u)
> +#define SE_IO_BUF_FLAGS_IS_INPUT	(0x01u)
> +#define SE_IO_BUF_FLAGS_USE_SEC_MEM	(0x02u)
> +#define SE_IO_BUF_FLAGS_USE_SHORT_ADDR	(0x04u)
> +#define SE_IO_BUF_FLAGS_IS_IN_OUT	(0x10u)
> +
> +/* IOCTLS */
> +#define SE_IOCTL			0x0A /* like MISC_MAJOR. */
> +
> +/*
> + * ioctl to designated the current fd as logical-reciever.
> + * This is ioctl is send when the nvm-daemon, a slave to the
> + * firmware is started by the user.
> + */
> +#define SE_IOCTL_ENABLE_CMD_RCV	_IO(SE_IOCTL, 0x01)
> +
> +/*
> + * ioctl to get the buffer allocated from the memory, which is shared
> + * between kernel and FW.
> + * Post allocation, the kernel tagged the allocated memory with:
> + *  Output
> + *  Input
> + *  Input-Output
> + *  Short address
> + *  Secure-memory
> + */
> +#define SE_IOCTL_SETUP_IOBUF	_IOWR(SE_IOCTL, 0x03, \
> +					struct se_ioctl_setup_iobuf)
> +
> +/*
> + * ioctl to get the mu information, that is used to exchange message
> + * with FW, from user-spaced.
> + */
> +#define SE_IOCTL_GET_MU_INFO	_IOR(SE_IOCTL, 0x04, \
> +					struct se_ioctl_get_if_info)
> +/*
> + * ioctl to get SoC Info from user-space.
> + */
> +#define SE_IOCTL_GET_SOC_INFO      _IOR(SE_IOCTL, 0x06, \
> +					struct se_ioctl_get_soc_info)
> +
> +#endif
> 


