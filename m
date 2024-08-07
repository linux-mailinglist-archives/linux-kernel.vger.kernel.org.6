Return-Path: <linux-kernel+bounces-277381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C30949FE4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 393521C22F88
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 06:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5E11B86C2;
	Wed,  7 Aug 2024 06:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="S+EwSplO"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2096.outbound.protection.outlook.com [40.107.117.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15F11B5821;
	Wed,  7 Aug 2024 06:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723012831; cv=fail; b=BGtx1lCsGBeURtAFZuseTpabc7yjkKBUKVH+jCkO+HA1GOXjG7djXYO9bFZXyH99eL6XUOtdEYALqoI/EDwyYk7qr857v7E5GCaUBVNam8PuexuRAFAfAC62ChreNs/OHxpHRvwT4Z9fUHRDbeY/vZwonhj93j2KPb/MAIOSAvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723012831; c=relaxed/simple;
	bh=MK5vhO0k5zpLHcLxH4ZieNM++Kj53R+jyFLeeaqPFrY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u/ZC+aJmffIXAXsDuaI2OUW5uZoeWoJp28uv9Ijqs+9ugYOURgwV8++686YUyZwr+WozffxQ2lJHXnUNgOJX0ube/bL3/mBbtFc05apEOv+TFkPW/09Gn5HCIX6g4WR+TaGIMCkAs5U1kn8usYY5ZSe2rCvdXKbc2xaM5zNvrvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=S+EwSplO; arc=fail smtp.client-ip=40.107.117.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJE6Kzh3tOvB44bN8rg7Ag5MgAePZzEnKDeuiaKQwXV+DLlR+xeo2aSxzWKrQ6OnZ3buhRzqWuVKURLM6Z8S1aAbRVlvm2roCeY0hxXSamZ0wSq65LtwRLKk43HbMW0wnDkqsRdh3RVT4XUtu2ICjAfLgEda5DBrcgzcX92xIp09ZPgGIQy5XoOMSuiwArFCzSj2VLO3eRSpQMKGI+Z9BzC9jh5DhN1vutdwQBz+zBsxrYT58ZAaTPCghnQcB4kytR1oDLLHrOihIrl1M9bFNg//NiJ3JhjsJNCMuyoa0FrW7DR3hiI7YuIvgkqPShjXNLuwQdOFUtSwMtzuBj+3Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lML18Q0tJGcrI4euRUZ+IFfPsiarkApEkafW0wQDiB0=;
 b=YpvnXxTaefUZu4nAj1CEOiPPybtu5GVtvu0voDcYi4U+2FaqIIjuzobUiDzGZI27AMzZUJbEiOrkR700Hf79VsZrPR8+hghyIeek4ixS8qWTTTrruMcXko1VVUOt1eNaYHaAz+z7BrHT2UTB2voCMOPDAjsT3P8ZofrIT4WfK71Vxe3dErOdLLxAtgVdB9z0+POkeSL0XVHt4Y5ZnsZvnkU8UuhsrY4QOcKJS97aUXJzOa/uCveZAhOHpdr1vZ6xFCKucEViopqSgE2xJtMFEvDqLUoN0U1OPaB/inKdL92V8WgdkcAvFE+4g62L+FDpQ3p21o/VsewOONrMwLNt/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lML18Q0tJGcrI4euRUZ+IFfPsiarkApEkafW0wQDiB0=;
 b=S+EwSplOiGuc7SDasFj9tvc7teAuVrGjDiwqQmsIsnizL1sSkBG8phIx905vDTgie5imzvgqcQB+sSbFemiZFy4v4TFif+r78+Kim4MWW5D2eo5/cSV+Gzen71/oIcYVvFOHN0NiOFk8cvCC8kTBJrZSNxKyUyPS6H1II2VzO9uZWGght4uo5bLbv1FEABefUxo6BhPw19SFVbkRoSe+hAJCNlGs6Vii4U0yJEK5lQ2ahNXkaUE89QneTXCE1wHq50xpWtKoo+r8tk9yKvRGdWR6J2h0j3B5lwLny7RzbnqRiPzhQIDNkJDIPKtU/LDZPt90ES43uzJtLCZ9eaRc8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by KL1PR03MB7920.apcprd03.prod.outlook.com (2603:1096:820:f3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 06:40:25 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%4]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 06:40:23 +0000
Message-ID: <43a600fb-8094-414d-8a3c-0573286a11f7@amlogic.com>
Date: Wed, 7 Aug 2024 14:40:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: clock: fix C3 PLL input parameter
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chuan Liu <chuan.liu@amlogic.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240806-c3_add_node-v1-0-c0de41341632@amlogic.com>
 <20240806-c3_add_node-v1-1-c0de41341632@amlogic.com>
 <b63fe216-ee29-489e-a175-e1525ac12722@kernel.org>
 <86b01ecb-6ca8-496e-b3a8-0b21bb951a60@amlogic.com>
 <2da06dac-7a1a-461c-956d-13b74320723e@linaro.org>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <2da06dac-7a1a-461c-956d-13b74320723e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|KL1PR03MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: ba394248-2473-4d38-3a2a-08dcb6abd05e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUxxSWpSOEYvOS95SWI3Y3dMenhtb2JqZGxXTjJ1czNDb3pkNlRkSTJuUmxR?=
 =?utf-8?B?em1HQnljTmtqWWJ5TkVENVpqeWZ3MnFZdFM4aDFMV1QvcTdFK0psQnlHeDhB?=
 =?utf-8?B?KzVnRmhveWUyZGduOVhhc3pSVHM2M1VxK3d2eUdJdUcwVE5MMXlsVjROcHJ2?=
 =?utf-8?B?TUViWnE3Z0l5NGNWbWpRby8xeHVRTkhZN0dGY3lPNktaZG5INjN6d29Ic3Mv?=
 =?utf-8?B?WHF5N201Zk9RRXE0NDN0Nnk0RmxYUng0eXBaUVhqY0ZzaHVTK3Z6NzdXZitV?=
 =?utf-8?B?NDRBL3pmM2g5NUpHejFyTlhRdXF0Y0dBdjRLeDcvVDNYNmhFd0hsVEhJME9j?=
 =?utf-8?B?Um51RUxoOE5vOTBocEpCVVFlUjAyQmRsY2thRWlNUjMxT3BHOThiY1dnWDd1?=
 =?utf-8?B?Wnh6ZEYwSGp0QlRlTjdMdXYxNUduM3EyM2krNHFkTWZYWkxvNDdGV2hhaFNx?=
 =?utf-8?B?bkF4d0NIbEd6UytBOWpUTlFwOHZUV2M1WFpOelBYbnZvMElrUjVsK2tSelpI?=
 =?utf-8?B?WDRXaE1tUEV5NlVyR29PUy9FajFjUWNHNk1qZVVxTG5YeHdKdUJvaWtNV3Ra?=
 =?utf-8?B?akVObkd0N2l3YUJQaHFLeTNLUG5TMFFwSWVKSUM1N3BMQ1JRdk9tbWZWdG42?=
 =?utf-8?B?bkw2b0xvandBVzVablRjZDVldHVETTZBU1I5Mlp4WXJid0NEcEkxOTdML3pn?=
 =?utf-8?B?VkxaSjM3R2piY2dDdzJTZUNuODJWSnV1QllPQ1NNenAyZFlxZ1hxbk9WajRE?=
 =?utf-8?B?QTB5QlZKR0xDd3doM0VoRmdZQ28vb0RHK3V3Z1R2bS94U1MxNklCeXpaeFk4?=
 =?utf-8?B?U3RKbWJrTXdzc3ZpTlRuQ3ZxaVFQRm0rc1J4b25telNpRk9pTHJGVURwSENk?=
 =?utf-8?B?RzF3dDR3cFREV0JVYXZLbGo0ZWVKTWpIamE1Mk1CUTJDdnplRDNncndPTDNV?=
 =?utf-8?B?TEQxWTJYb0xhWWkwQzVweEUzdTlTWTBjZXkxZ3hPRlFpZEZIOWRBT2xnYW5n?=
 =?utf-8?B?N0dVRWVDc3BvU3p3UFF0MTExNmZjL1I2dDdEMUJuU1dGN3NqZVoyNFNuTGd6?=
 =?utf-8?B?TXFJTVo2aGovTEpzaDllV1NqRDhVclB3NmR3VVl5cytaKzJQaUo5TllHeEJw?=
 =?utf-8?B?QkZ5cVRId0NDWWlWLytEdE5LblJ2cDMxeUcxbjV0bTRVMEllQ0EzbUM4aHd2?=
 =?utf-8?B?Q1NkbzVnNkxDbjdJbVE4cTNqaVplTVhnV1B4dXV2OFpsVXNDbTdMRVc1MW9M?=
 =?utf-8?B?Nzk2a1VSbkZsOFZtelU5ditRQ3JQL1Z4anlGQzZqNVdROVRlMDNtaGZYaGpa?=
 =?utf-8?B?YjRYU1N5RS9IY0dmUElZdXlYWFlLbmoxbzVHY1hMZUJuSHZWUHZUT3RMR3pR?=
 =?utf-8?B?MjZtOGlzSThXZ0pBbkgxMjduMG52cFBHdzJSeExlVWdkSlRINXp1QXdoaEx4?=
 =?utf-8?B?SWxsdDZRa2dFL0s4Rk9TRnBGb01Zd0p4L1dzVXR1Y1BYazQ0U3Y2aElkQUJZ?=
 =?utf-8?B?YThwSFNka1Ftc2p6Z0tTbzRzMUsvQXZ4b1VKMzBWOUxpUWZOazJQbjV0THhZ?=
 =?utf-8?B?SkRpWFhabFBMRXdkSjlVdGZFcVNwNDRDcnJmeTVRSDJsdHRwVCtDbmJzYm9O?=
 =?utf-8?B?KzdsR2N6RkQvUmhBS1pETE9zQWJwSjMxYWRkYXh5U2ZZWVUveGJpcWd4ODNs?=
 =?utf-8?B?S3p3Mmw4TlBKZXJPajJhS2d4d1hLaGIwZGQ4WG53V0tHTjRsQzliU1A0Q2I2?=
 =?utf-8?B?UCtFN0U0eFRkM2hwZUl6aURqSWh6QTNBMGdHWE5rcjBNYXVIUGxhS2Z4bjRz?=
 =?utf-8?B?bkd0TGxBa1ZZemh5RHlnUmJzZ1RiVlBTdnFRNGlCZTVmZmVodjE4SE5aOUFn?=
 =?utf-8?Q?VzUhoFoXN3+85?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTloWEZFNDg5TzhwM1RNaEdTQ3BSOW03SkFsTk1pOGFtOUZGZ0hGa1ZYNVdJ?=
 =?utf-8?B?VnMxWk83MFlYcDdvRlkvbnBJOFlrWTAxamUrdm1peW5nOTJEU0RaYkR6Q1I0?=
 =?utf-8?B?TVNOTm9tRFMzaGd2eGo2Yi9uWlN3TG5nWGF6a3MzYnNXRmY2Y2lTWW4zUEx2?=
 =?utf-8?B?L3VVL3dHa2xRTnVWSkVKSEV5cGtsVDlldUhwdjk4SFFhQUluMHdrbnd6dXE1?=
 =?utf-8?B?MUNrOHZpVGU4K1NBa3BmTFlEYjQwQWVRWVpXWkZaNjI4b25KQnhTVEo0WWpy?=
 =?utf-8?B?Y1R2bG9iMC9mSVljRUVRVGE1cjJvZkJCTFFrUmhUMmNjdEpNUDE3RmpuMkVt?=
 =?utf-8?B?K2lBTjdPRkhkekZJWmVxOG1vblk1OTAwV2lmQVZFZThaeXE3Tm5TRHVzblhZ?=
 =?utf-8?B?YVRUdFV4aVNRSWQ4cmtUZzNKeCtTMzhaN1NqWGxJbGhUbjdBZVhxL1hHUUVn?=
 =?utf-8?B?SjZVYTVkRUFlWHFCN2h1dlg3Tjlhb1JZVnpDenZua0M3RFBjSTBBZUlzUjJp?=
 =?utf-8?B?QlpGMzBSOHUyQzdJa0tiWXYxR1crWlJlL0hFU2lMZU1JWXdEalZsKzNlWVkx?=
 =?utf-8?B?ditzRWVZMDNxZVlqME95clZ6bnpiZHFNRThOWUovQXcrbmlza3BwZWQyeThv?=
 =?utf-8?B?Ly9FaDljWm5VZ0VjWWhMYkMxSUExQmNYeXJVaml2N0hxendlUm5hc3R5RGxY?=
 =?utf-8?B?R1MrM2RzaHdnZEpRNXB0R291aWlNeTBtVDlCL0hkbi9laEJWaFNVVy82dFpx?=
 =?utf-8?B?NnF4Q3E0VXdmMlVwczdlV3JRR1hpRm1kcFNWR2NZY3FVNTQ4TmZnNUl1MzQ3?=
 =?utf-8?B?bU5ua1g0OWQvQXRKVXNiNS9GdEtmSkVGREM1aHFKZnJMRC9mUWxFMVZwdEIy?=
 =?utf-8?B?dm1tTHh3SXRYYktrZ3EvTXVDQWNZYzhZNExvRER4QnVBZGc3VVFkN0hBL2ts?=
 =?utf-8?B?dVE1SVRTU015bEt3dmZqT08rQWJhRFRDeW4xaWpDS2FnS0NSZXozbWczYlJN?=
 =?utf-8?B?MkN2ajA1b0pMdW9EWnZZTkhiSDdsZys1Z0x5QzFOL3lja3FXSldqYzFBNkZU?=
 =?utf-8?B?K1BwSzgzemJTTm9ma0hCZCsvejVHdkZlUjhDbU1NNHh0RmJpN0FoR05wTGtr?=
 =?utf-8?B?bWMxMURMN3JkTmQ1cXJkYmdqeDJ5ZXNzTUQxSys4RkI2VWw4c3hXeW1kbGth?=
 =?utf-8?B?TndndUtWaC9HanArMGpxOEQ0dzNiTXRuRHdOVTZsU2c2bFAwWFpOMnlkQUNs?=
 =?utf-8?B?bWloKzhPcjAyd3BWY3lSRWRCUkswVVZkczlrYWkvZWdiNFZJeDRhaHNoMVVP?=
 =?utf-8?B?Y3crekFUZk5QMkJraktIMElFNzZoYzI5aWtCRFdTeHFKVE9POUFKMVhWSzh0?=
 =?utf-8?B?a1FWcGNVaTY4bTFDazFjbFI0aGdFRnN6am8rcmlFVmd1THBQNFIxd09IOE9S?=
 =?utf-8?B?dExOV2taQ0pMMENocG1rek52Skl2WjR2bnY5T2V1WFZkMlV6aFFCUnlYM3FH?=
 =?utf-8?B?eWJzcy9NR1c5Qk0zejVtZG1jc0hRWGRhOFdHeHZaRHNzSWZ3TzhvSE5FV3BC?=
 =?utf-8?B?SFVBbEMrOHJaZ0NieWhzNUcraCt0Q044bmhacnNydVlzQVl1aGY2Um1vc1BC?=
 =?utf-8?B?YkJpcVMvaENIWkZmZXNuQ2VyWjVaSGwxYldhTlRtT0xXdFl3Y1YrZU56b3I0?=
 =?utf-8?B?N2NVdWEyeSsxWVNTUDgvMDF3b1c0TDU5MTAvNS92bTRuV3gwVmNuWEJWdmU1?=
 =?utf-8?B?bG94czhRMmVNU3AzQzdSdlFVOExUYmFWc3kvb1ZDeXdhQlE1c3ZRNThFTjFq?=
 =?utf-8?B?akRDNlVzTjI3amJBR3NZODh3Z3puZkZGL0plZVQ2RWxMbGlEVkE0R0pIeUZ0?=
 =?utf-8?B?cnNLMkVpUnAxRmdQc0tDa1lzY0lJa3EzTXRmZCt3UVRRNEEzSnRYUWZISm9V?=
 =?utf-8?B?SnJjRW9VWTRKVStaK1NCM3hKVWhkY24yTmxEWG9vQ0pQVDA3SDh4UkJuZGM5?=
 =?utf-8?B?d3FPc3phb2pQME1BU01ZbHRYRkNnL3RCS2t0WU5sZ1N4VEdOYWRyQTM5NWlW?=
 =?utf-8?B?NENqOGtONVZ0OEIxb1d2emFacEd1K0pNaGJLT2g0dWcxLzJyZmlZSUR1c3Zw?=
 =?utf-8?B?eWhLY0dVZWFhSldFU3ppRmFOZ3JLQmQvWlJaNDVXM2U3a2VqRjRCeUhZQ2U4?=
 =?utf-8?B?V3c9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba394248-2473-4d38-3a2a-08dcb6abd05e
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 06:40:23.2832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QCXjVFMSu22/U9yskphmn7JXvzg5MyUW+Hi6nkILmTV0XrQm55/VghkZPCKsC+hkbhpYj1BcXxbv/PbCnoAlt/kjdIcSGdkjeSV1Ixop8TA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7920

Hi Krzysztof,
    Thank you for your reply.

On 2024/8/7 13:44, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 07/08/2024 03:55, Xianwei Zhao wrote:
>> Hi Krzysztof,
>>       Thanks for your review.
>>
>> On 2024/8/6 21:10, Krzysztof Kozlowski wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>> On 06/08/2024 12:27, Xianwei Zhao via B4 Relay wrote:
>>>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>>>
>>>> Add C3 PLL controller input clock parameters "fix".
>>>
>>> What is "parameters" here? Why you are adding it? Is it missing?
>>> Something is not working?
>>>
>> Yes. The previous submission was lost.
> 
> What submission is lost?
> 
>>
>>>>
>>>> Fixes: 0e6be855a96d ("dt-bindings: clock: add Amlogic C3 PLL clock controller")
>>>
>>> Why? What bug are you fixing?
>>
>> The input clock of PLL clock controller need the clock whose fw_name is
>> called "fix".
> 
> Then explain this in commit msg.
> 
Will add this in commit msg.
>>>
>>>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml | 7 +++++--
>>>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml
>>>> index 43de3c6fc1cf..700865cc9792 100644
>>>> --- a/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml
>>>> +++ b/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml
>>>> @@ -24,11 +24,13 @@ properties:
>>>>        items:
>>>>          - description: input top pll
>>>>          - description: input mclk pll
>>>> +      - description: input fix pll
>>>>
>>>>      clock-names:
>>>>        items:
>>>>          - const: top
>>>>          - const: mclk
>>>> +      - const: fix
>>>
>>> and that's not an ABI break because?
>> This is "fixed" clock.
>> I will modify "fix" to "fixed",in next version.
> 
> With "fixed" it is still ABI break, right?
> No. The clock named "fixed" was initially implemented in the PLL clock 
controller driver, but some registers needed secure zone access,
so we put it in secure zone(BL31) implemented and access it through the 
SCMI. but the PLL clock driver need uses this clock, so the "fixed" 
clock is input as an input source,
We changed the driver and forgot to change the binding, so we added it here.
> Best regards,
> Krzysztof
> 

