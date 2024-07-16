Return-Path: <linux-kernel+bounces-253440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0195093215D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24EDE1C2196D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 07:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7D0339A0;
	Tue, 16 Jul 2024 07:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="gCqIRv0R"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2103.outbound.protection.outlook.com [40.107.117.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175233D3BD;
	Tue, 16 Jul 2024 07:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721115608; cv=fail; b=ps1++RZ7eafNDHROPqyusbf3bcQ5EaCF4WkYHubmzeaV0zBpIuizdT9N5+asuNGY1AhHt/K6e6hFJQw0Ctm0gV1lzRy6L8gd4321qi3hF4eGyRvKXKIqcfdgDuOqTb5XGanD3tEVyZtIJGPZfqiVeNKebqZ0PQmBTA4NJG2y7w0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721115608; c=relaxed/simple;
	bh=U6P6A9IrJWcyvBjkmYBdGusZQMgNyiiClK5JyjNEZ2c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sh9GeqmqxEMTuo5DXZwyLjTgoRHQwDR7p+tEgzUo10hgfOxUaw9zcvkryvxrUMiyQYbwotn77lYcthzyMDPHVDL/jwXOPMI1d54TbSb7BrVfgG1fTNHpf0agQUEKGJDpEtxDPhoLUw/dD+rBO1GcS0tijloXLPwo/yYI/3QlvfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=gCqIRv0R; arc=fail smtp.client-ip=40.107.117.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3cTF+HSzq8fL1GX631fEdakHmPKUJ6SiNU/JDe65JoyRqNi5ID3VP3wSJvG/wbOgHQoih3fPidtwUSJcI1n7k7bAG4/ZwBrYwLbddUWjuqjjkGjF5srFsqhW22JFW3+8+EGGfqW9cPg4faabudh0sS6A6vq1Bkt4ztER8wUsJyJFodAIr3vz7Ji3kRbirqCFr6847BWQcSZTpR5Jq+cP7FcsnGTHR+ptpJCHL2S4+G59z1Y+r+A5G8rfqfMdbzzd4cIkVcSRZQ1edfyVSGb+Dj8hJznxx+0d5OoqSF967+z21k0a1wfbFf/B6WfSp8fdPgSQkxG59q6ukHjjHqOvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n03j51k5+yUc5nIhgvNP1V6edOEblXr3wSO9/A/z2eY=;
 b=SBsiAraydMP+w68jnME/huO7nBFfPJIczXKONGbIpHSH6LH+JZhvHT2eIWuL0RJOIp0mqsVrIjLptq0Y6m16xztfTirk7IwT+qNcie3osHBuUGq8lBX1EkzXPHzuz/I7rmRFrAwhxKySomdP3fRudvoo5TKoOMRAg3KxmJWAi06YOXRVYDMRlPgeCCZXpxkbO2ALw70rwoOlHtnBWrQLSikGU0/OQ6WWA1lXqfapZv85fwCrNg5JaeEAo7WTiaIw/GpjWXkwiGYyozzpaQol1XbFoDDLDDtVabq5jbAwt2aAHHvx7TFGy1jB8tN5SwYp0Mu4XrbnHWekLB+eEMcyLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n03j51k5+yUc5nIhgvNP1V6edOEblXr3wSO9/A/z2eY=;
 b=gCqIRv0RkzQGpwvYgJ01S0HpQ+erk0L1lNxvgXAfWKokOny1eAToNyzxucH7miaxAVIOFzHE4eoT6ECfT/mNppnXguJCp8TjJaW0zGNTSdJsAOc+pNQBTUbvvjmOM7szK5HtIRxUhaxMTrZ6EslywHahinpWghx7OB4srWs47sw/72LOdSNU28VcqpQzY+uB3WxVCcDpH8o31vPxBLKkWnTYQqvveidcoZ//kBb0WXA/o876eB3N5JO/gKIR5OKPtS7cfiatY3SkEd2DqsdZTaVJg7Uxgui56zgNrVsmDp82EmpcE2N1HEpSds17hQgSoyBKHiVBerVWM+43LePkZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TYSPR03MB8368.apcprd03.prod.outlook.com (2603:1096:405:5b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.27; Tue, 16 Jul
 2024 07:40:04 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%4]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 07:40:04 +0000
Message-ID: <fcb921ad-9f2c-44df-aff4-ea02bf0ef8dc@amlogic.com>
Date: Tue, 16 Jul 2024 15:40:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] dt-bindings: arm: amlogic: meson-gx-ao-secure:
 support more SoCs.
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240715-soc_info-v2-0-3836c8cc27a5@amlogic.com>
 <20240715-soc_info-v2-1-3836c8cc27a5@amlogic.com>
 <dea46ec5-5540-4cd7-8f96-387463413b3f@kernel.org>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <dea46ec5-5540-4cd7-8f96-387463413b3f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP301CA0044.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::6) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|TYSPR03MB8368:EE_
X-MS-Office365-Filtering-Correlation-Id: 379c3db2-9013-4c68-2a58-08dca56a81b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bU53cTZhSDRhMElTT1ErNnhKNVVYMTNDd21WUS9wYm44TEhGWkpERXFLdXgy?=
 =?utf-8?B?RG9DRmkvWE44T2s0SDcvWmQ3U0psTno0RWM5MXdPRkVIUXdrcm5DSUEyZElR?=
 =?utf-8?B?bTV2bVpRSGxkR01EVEZsejBnbk8rLzNhUjVDR2hWOU5FQWhOTWZnMyt6YXdE?=
 =?utf-8?B?NnpDc1lBUzhjN3BQWDc1MU5IeU92akEzMUVIUk1CWkNOT0I5bUhEc3kwQklr?=
 =?utf-8?B?aTZqYkFCcWNtbjU4NWhCSm9LUmYwRVpwZGpPTGpxRmJveEVDNXQvdUFpa1Az?=
 =?utf-8?B?ckNoM1c0SlF4cUJySVpLdWJjSnJvQzhXZWM1OFZQMjRnVzlEbS9LK3U4emJz?=
 =?utf-8?B?anJZK2ZIMFQwbGVXekRWaGxkTDZjT0Y1M1krN1F0RUdZVTFybks1K2orRlha?=
 =?utf-8?B?SStrZHA2QXpTUE9mN0dpdHVMNXovck51SFdlYUtydVRXb2gyRit0aTVJREZS?=
 =?utf-8?B?bUpLT3EvT1JWSklRMHh5UFFFT0NLMi9MVVhjZ0tXVUsxYWFNa1gwTk1sRFhq?=
 =?utf-8?B?WUpxeHdhSG1qUk9SV0lNaWVuVGkrSGtUUjlZRkl4ZENkSVFoMkNpWm5DUWU2?=
 =?utf-8?B?MG5lYkpQWDRETzFMMUNLOStTbis5V1BVaGdSWm9wQlNEM2dyVGlpVGJaQVFn?=
 =?utf-8?B?bTBBV2p0VHlYbVRaYjkwVXY1MUhPZ3g0QkJqS2JQQ3hZK2hZaWNidUtaODc4?=
 =?utf-8?B?WUx2bk0xUmlsUkdwMVIzSHVFN0ZRNVFmcXUvdEdwOWZuckNFamV2OWE2Qmwz?=
 =?utf-8?B?NXdNWHpsa0cwT2N3Z3ZWa1JXa2lIRHBvUElUd0VGcE1Ockg1U3dGRFJUcFR3?=
 =?utf-8?B?WjU2SmFOZjFuREpJZTQ3bmU2K2pXM3ZRcnVUWTdjYlJMWGJST3VYMm02akJ6?=
 =?utf-8?B?SGRnWVZqeWZqZmFVQXNEMERyck5QdE1kSXRmWm5CeGhuRXVZMkpkM2R2RVlY?=
 =?utf-8?B?dWdHd0xKTThlRXFFUkN4Slk2aFVmMGhxM2ZkUnExZ2JDRFd6WHZiOW9XWjg0?=
 =?utf-8?B?eHR6UXpBSGduUjdrZm94MFBJTmpRODBqUkJ2U1VqVEc3MGxGYmVIcC91RTY0?=
 =?utf-8?B?US95R3NVR1pnUTFGYVFEbUZ4NSt2Y2lrdktLTTNsN0w0aFh4TE5DQWgvcCtH?=
 =?utf-8?B?TjJIeGVFSnFzTFo0WlgvMXlONlVOZk5WMUlLY1JoUGJTQ3hieTZLMVBJNzRv?=
 =?utf-8?B?VUFLejJOSEhxMmNCSFVOenpCQnRZTFhDRlB4dUl6bDBMancxMHhFSzVLcXZK?=
 =?utf-8?B?WDl4bDJjdCs4cFV2L21UaUlNY2U1V0dpOFZhdW5VVytUaW5OS0RvWlltMEQ2?=
 =?utf-8?B?NXY2VXBOL0ZrZmhCZjdyb3AyOVRiSmxJb0JtMERFN014RUpiTVpMbHRFRjBq?=
 =?utf-8?B?aDF6YlFrM0V3NzJ6YkY0bklaRHl2MDU2bHdvMnlJUjZrdGFHQ1VHTGIzVHVo?=
 =?utf-8?B?cnBNZVExRk9XTjZNYkEyWHlaVFBUNU9zQ2l4VW9nQ2FmbEl2eUk5T05TM2xi?=
 =?utf-8?B?dlBkNzNZWmJUOWpWTVNtU0ZKRjYzMkhIL2NCQkdQSjRobTM0QXh1WTB2MUtu?=
 =?utf-8?B?RHJQbFZnTjM5d1B1aitCUmRMOUtHZzgzejZEUVRwc0JGN0NPc3I4Y3Mxb2hL?=
 =?utf-8?B?b081V3pKR09SazlqSi9wcjJLeU8xeGZpZVcrQnhLTmlmUVErZ3lqQWhsaGhy?=
 =?utf-8?B?SGthT2VxdTNNMUU4c2NVQmJ1Z1QyRWI4aUFGVldOVDcvUC9mT0J3NjBFSVJp?=
 =?utf-8?B?M3o1bzltS0RhRzM3RHdjdzNUOW52M3M5SE53RjRtL2liSmppZEZHM1ZieE1t?=
 =?utf-8?B?Mzd5S29NSjlWYjk1NGZ5Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlFtNGRQc0lYeWQvMG9ZNFNrQmpVU2FBRmZ4N0VVZUpJR3RoZ0ZicytvalNW?=
 =?utf-8?B?YUluZ1E3UHBKVithZGlDWlA2L0hjbDFKdW9uN1hUMHpsVm01V1BVMnpDTnJl?=
 =?utf-8?B?dTRSZ2dnTU50eHBZaTFJQjFZMEU3bXpidDRxK29YOWYwN2xoK250ZDg5UDlu?=
 =?utf-8?B?aGRQeW85NmhydG0rbVNkOTlYcHBYVmxqcFpVUlJQSG5XSTBkWmdGTXhrWS9x?=
 =?utf-8?B?SWFaeERmR0xYWjFjeDhtUzdNUjhubHpVay9WdHk2eTQreDZSWnB6ZlNXSjBn?=
 =?utf-8?B?WnNQNmF5Um90NUVRWmN3ZHBUWGRZbGJjY1pscm1TN1c2NVFwdWNmUHIvUkJp?=
 =?utf-8?B?ZE9yTHlmeExQMDBHMlFobzV1VEtrMjdhMlE1ZkJ6K25rSms1TFQwVnhkeG4z?=
 =?utf-8?B?eVlXV0tiRXN1ellWbzRFVzJ6YlduNm14NWJ2YWhkNG5kZ2Jya3JtajcrWHNS?=
 =?utf-8?B?Wnl0TitPTmlnK2VOdC9LbTVQbUVrVnYzbmhnSWNIZVlEUTBwaGpBSkZvaEgy?=
 =?utf-8?B?Mmp3dHVQRmRBVG81ZXNOUURXVjNrU2hQeG1WY0IxSkZmOTUrclk4Q0pDUll0?=
 =?utf-8?B?Y09WUXA1NWx5MVBVZG1VdDBkanU3TTN0YmVFOHlsSWIzT2RqN01xVFB1bjNt?=
 =?utf-8?B?VEFvV2x6RlRFd1dXa0R0a1FpbDZGZlF4dHRNNWpQb01ZNkkycWRVU1R1SWli?=
 =?utf-8?B?RzFwWi9XL3VRSHppQk42TUdGZUhCeng1ZmJzRFluMGpZekJlem5hc29QeURY?=
 =?utf-8?B?RWIzZTRidGYrUEtUSWFpTlpCUzU2c3BGSGlsaFlXZk9oUmFYNWZLb2VOZnp3?=
 =?utf-8?B?TkRqd3VCbmwxS0cxOWZyY2t0bk92bnVXT1VUalNWdkRIcXpDMHIwWC9teVYr?=
 =?utf-8?B?bTdoVG8wVG5XbSs2U3Q0dFRWajBtamc2WnlJV0tuUHlTeGRmcExaZGR6UCtF?=
 =?utf-8?B?eGwrdWlhTDUvajlpNGRCdy80TlVZdmw1OUZCQ0pHU29tSFFqVDZZblU3OXV5?=
 =?utf-8?B?MDJYZzRBT1hPYmpsdDh0Y1dIOEtMMjVvK3J1MTRkZ1BPeXo4TGVQbXVrajlT?=
 =?utf-8?B?TnVtcFozK29waFR5cHhLRnFHQXc4NVBUeG1iRlMvQnFZL2R0bTQzclJUYkJX?=
 =?utf-8?B?SVY0UzkwMFU0Znk5TG03TkZWOEJKcXBWR1NtbDRWZ2ZyNVhRTStpQmV1dmVB?=
 =?utf-8?B?c3hkMzVOdUJWVXlERVZuKzJacy9VK2F5MDNpYnFIVW9SOVZ4ZSszNjgzOFlt?=
 =?utf-8?B?Qk14TDlWT3I0LzVpbVl0NkN3dVpVRDZUQ0VGeHRJUGpjZmFUQnVtbmxsL3BD?=
 =?utf-8?B?dnVDYmQ2bUExVG5zMnhPaktTQVM0VGk3eTE3WFJSU2w3RjlBekk0UERxYml4?=
 =?utf-8?B?UDRjTWRPQmx2WnN6R2psOTdsMlp2U3hCdUFhdkJKMnRFd0RuTnV1M1crTVlZ?=
 =?utf-8?B?WkkvSXJmOEF4NjIrd0Fyb285N1F2ZHh2VThwd2x2VGRQRjFwWGtpblFaRXFL?=
 =?utf-8?B?OVh3bFFlU2w3WjRwNTRuK0N1TCsvMXg2dVBTVlp4MlQza2pGRDZ6ZDg3MW51?=
 =?utf-8?B?eElaYnplQUI0VXBYUHhVZm9SblFHSUZOV1Z1c3loQTVCdVl3RUo5cEZheVRo?=
 =?utf-8?B?NFhQUFUxdEZGdFMyUDl0dzVDdHc4WnVEQU0rZVdCNjRSOHRSZ29JNXY0dC9u?=
 =?utf-8?B?Tit1M3Q4N0pyNS9SNWNDNzhkcW5VSU9KUnRBTXRKanNaRk9rS0RGMWhvcitS?=
 =?utf-8?B?dzYwWWcxNEVJSzNob2dXa2dOYS9ldEgvWm93a2dlRjROU09Rd3FFY1k1cW5W?=
 =?utf-8?B?cUNCM1lLYzZaN3BqeW9VQ0JJNnM2Yk5lclJsSXdNVG1nbkROb3FlYmJGVmc2?=
 =?utf-8?B?akZmSVNFMXYwOWZuY25GV1lCUGhKL0pXUWMvenQzUE0zWkg4QWhnVi8wL2NS?=
 =?utf-8?B?dytXV3QxR1J3cE5UQ3duMFU1QkUxUE1yYlRYUUNISXZXQWNZZGUxMFliTjA1?=
 =?utf-8?B?YWl3N3BFeFh2d3hOREVZa0F3aElvMnpzVTdFTFBMdE5aelp1Z1RuK0VCRVZH?=
 =?utf-8?B?R3IzbytxUjBrZ0dGOG9pb2xMVGxucm1PTjlpdWtoMTlNUkpPcU1ZQVI0eWtX?=
 =?utf-8?B?VStzWXUyTElpdmQ5MUdlLzU0RTFZOFNONWFIbzlqa1pYS1NaV2VyNStLUFRu?=
 =?utf-8?B?YlE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 379c3db2-9013-4c68-2a58-08dca56a81b2
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 07:40:04.1611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PqsPYgeB9whNnK2sojmJ7cecK7PJ7hNFisjQwPpP/ocGw5MfaUcMCL/jpCZCW0Gew9tpvIIWAHBwYrwt+uqsctYZXn10KMwXPkAHZ8cvpJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8368

Hi Krzysztof,
      Thanks for your review.

On 2024/7/16 15:36, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 15/07/2024 10:59, Xianwei Zhao via B4 Relay wrote:
>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>
>> Add dt-binding document for ao-secure of Amlogic SoCs(S4,C3,T7,A4).
> 
> Subjects do not end with full stop.
> 
Will fix it.
> Best regards,
> Krzysztof
> 

