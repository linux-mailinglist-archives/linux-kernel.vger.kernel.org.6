Return-Path: <linux-kernel+bounces-277533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6545394A2A1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163BF28346B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C23C1B86E4;
	Wed,  7 Aug 2024 08:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="I6USqcf0"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020135.outbound.protection.outlook.com [52.101.128.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979861C8FD1;
	Wed,  7 Aug 2024 08:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723019022; cv=fail; b=LPufq6vkmLIa05uIlWsG2/jwY5HvSnwjmckDUmC2cI4/NNjatN1lKJ7lTF97NygCk4l13WemOtGdbqMqyQ18Lg0AyT3Vhf26x4S584DE07yjV2Zu3T9dzg9L/1WgkHDK3MJCub/zsXhLXXbzwTGvK+VmjNYlM9IZQNEOi0ut1ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723019022; c=relaxed/simple;
	bh=/Qko2VWCHqHQY3O69DqaxRUFpXmMw8ffknT2lh79YUk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r44fjQmb8XRCW4clSp7jxFGM+GBi8Y+/TD0eOeG0VTHPiD4oOqb7TJpUSl/6K9Z8kNPyzNpGaUWfTKakjIVEelvwvzgadOlF1xhObdo9pYA0TJwESLPX1WJZBBswvH/fzb/3ynJUFRRp4PazFS5nFLTG/MwvRnJlEAsn9rmcBgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=I6USqcf0; arc=fail smtp.client-ip=52.101.128.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZpDsis1GbAKWIqo9LH7VsYYWWAtiI5vF2Jedw2xZIspxqgn9UGPlO7XM1QRmXsYtELgO0kq4ICOGSe/+xkdOL7ZTOB9HcZGSS8FOIrfb97nzBW7Sw0gf5dUnMU09lhVy7y5YRq0q5jprNcPQozvSUr6+G7fSdJqbTy8DIHiX4s1ugYFO2/ligMN5LAVZfg5OMxG2BYYWY+fYTgmzO+lT6pEGnG7AlsAbBCQuJHqZPM6WhdDzrEJ3Wm+x3Gmb/o4k1HxFCXCkWNNfPPqlipf5kjZc37K10oIwjOesqK4O1gU8JCpzJJqj4CpTSWCuHekOQPMKvQv02F4lNfMTyJ/fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJTRkghuw9JxWMH1VtMsTiQwIGxaCuAONLXvs3yaEbA=;
 b=wwxvBxxJHN3QaFtXXzddQhQDzyB/NJq4CKo3cwHxY442bFIgZRnxZF2b51wguWgi+LTutopKCSwFOiv10HQBKMG9Lqrs/pCyeIhlfRme5AG+2WgxgM/CiCXZH8IKe3Y5oPqO99T+KmYHZceBcm/KWJ+jOYNYPwH+rufr50e7dngDUa0+cstOs76PrS0kwQpLSE2C3gVaUGXtrwfCxkc/L2HRnZuuSH5Xkes/2WAX5i5MmacJ2RPZVMJVp5tS5yEMbb+ouePX3uHEc8hGMYqEsFtMgnmjWVjbpmMWZiLfHkOhXpAZ4R7IzMB733J46uU1rcH48I5emSNed19wMCmWVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJTRkghuw9JxWMH1VtMsTiQwIGxaCuAONLXvs3yaEbA=;
 b=I6USqcf0BnfWwGf325HrgV8Z+rMB3uzMEIacewKM5VdgIwhxzY5D8ZMoCwwmkfLbQszIcHrRQcC5HF1lOlP759oeVJEo4yA+WPzIwO3pPmEyRvRXIPJ9OJeQuJ3AbjdWZkIykxjJazoC5Svy+pXogcZiZgEPkmnwqTKqtKXukcFq2Nne0/kQeDE/48bXRx5IeOUPReDeui43uqx48+q5ZhVLQzKn+6T0znfJ1wY0k3DU8OVFGwA+9LpqD6HWDsB+VTugzTV+yOZ/CLXijZ20YdQ/IKumSiULQbrS2yeoTxlVXulb+eRKDAO4ePTTk1ON2N9Tsr79q5lLWdJn+PJfNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by KL1PR03MB8142.apcprd03.prod.outlook.com (2603:1096:820:102::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 7 Aug
 2024 08:23:32 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%4]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 08:23:31 +0000
Message-ID: <9718cdaa-1a5a-4153-b19b-328127dedbee@amlogic.com>
Date: Wed, 7 Aug 2024 16:23:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: clock: fix C3 PLL input parameter
Content-Language: en-US
To: Jerome Brunet <jbrunet@baylibre.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chuan Liu <chuan.liu@amlogic.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240806-c3_add_node-v1-0-c0de41341632@amlogic.com>
 <20240806-c3_add_node-v1-1-c0de41341632@amlogic.com>
 <b63fe216-ee29-489e-a175-e1525ac12722@kernel.org>
 <86b01ecb-6ca8-496e-b3a8-0b21bb951a60@amlogic.com>
 <2da06dac-7a1a-461c-956d-13b74320723e@linaro.org>
 <1jikwczrys.fsf@starbuckisacylon.baylibre.com>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <1jikwczrys.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0091.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::13) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|KL1PR03MB8142:EE_
X-MS-Office365-Filtering-Correlation-Id: e803a3f5-8bba-4551-6c03-08dcb6ba38d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTI4MG5NS05OL1ZyUlFzUUthTUNoejlLSU9FaUNhU1N5KzdQK3ROQzNtZmxi?=
 =?utf-8?B?NmFpSlpJYW9EcnQ4OG1BZGJVY25YajJTYlFXMmpLaVVrUnA3SE9yNUhYVTlD?=
 =?utf-8?B?N0FNa1I0NDQ3VW1abSt4UlpZdkdsOWNYQU9iRlV3MFdhOW4xUW5YVE5QWHpl?=
 =?utf-8?B?NldMZk9CUUtSaldTbERvRVlPWWJVWW5OUFNEV2U1Rm15U0ZzNFVUTm00UVpE?=
 =?utf-8?B?aG5LT2orQndYejhZK0Y3UDBJZHFoT2xFeEc2RXNCL2pJaFF0QkttQ3EzRFBj?=
 =?utf-8?B?R3VWWmJMTldCclVhZGo2eVQzdmduRmNCWUVWZDJ4K0lnOHdaWnMzWTNBMnFt?=
 =?utf-8?B?emsxZTVFbjFvY01pSUtuNXJhTE5DbXlEblNvNW1Uc1VoTFdrNHMyNXBOblYw?=
 =?utf-8?B?YmV1amNkNkJOYnZKQlU1UDkrTlRjVVZ3Nm1odkNYdzZxZkozMmRXQXFxSVAw?=
 =?utf-8?B?dldWNGUraWE3QVF4Qzd2ZXBNUy9wMDFmSjZQaXlqZm5DRjNveUYxZkZVajR6?=
 =?utf-8?B?YUFMK2VHbEF2aGRwdDRXZ2ZrZ0dQWEtRQjVOMFhUSXZ4MHdlNy9ocm92Szl1?=
 =?utf-8?B?SHNJK1NNeDRaRlJHQTBGOElKMFpaVUlVWnhuVEd2MDVRbmdXeXROeEFSK0Z5?=
 =?utf-8?B?UE9XNTg4YzVTRSsvWDViZUk4bXgzRTExS1VTOFVoYmVta3NOeDZSNlV1bmNa?=
 =?utf-8?B?WUNHYTVUVnlqdDhKWlFpbExUdTdLd2JwbU9PNXZpLzliUWVQK0N3cU84d1V3?=
 =?utf-8?B?OXB2bCsyS0tXRGtHYlZTZllZUUxMcGlPM0xaRS81Y3pvV090d0NJOEN2Q1Rs?=
 =?utf-8?B?QVhiZlFnWnB6T3N5TXFubHBrNTZJajBibFpDOFdqK1hXbXh1cTVQYi9OaitJ?=
 =?utf-8?B?U2x5RklqS2M5clV0QWVPTU5tMU5jZjZkNEZjVjMrM1RTdys3NmRaSURqcGpL?=
 =?utf-8?B?QXhzSnpySXBTQi93T2VSQkdBMVl2SGFUb3NrQjN3ZzkvZ1BUMFMxV3FZUlZp?=
 =?utf-8?B?RXJmNk9SbHVjTk8wSE9mRUlvNEYybGpFUytmWFFYZXlxcmh3RVF0aDM1VHRT?=
 =?utf-8?B?eTlDVlloYjlwUk04WFR2eXAwYWlvR3hiNUh2U3BGVllqRUl3ZndocVo0aDJI?=
 =?utf-8?B?b1RjM3BvYTYvQk5EbU9iUDlrSXpqNUJaOTJEUG1qRlMyVVVjeUEyN3Mxa2JE?=
 =?utf-8?B?cTQzU3hRMmxhVjJTaGM1bTgwNjdPak40blVaTFkwUThuMzEvais0QmxleVA5?=
 =?utf-8?B?QXdOMmxsRUlQSGhmWDFZT2ZZR1dWOGR3OHFlRVlpbTFGYkV6VnZLdDk1M1FV?=
 =?utf-8?B?NTNTeVVQWHgxNFJCL1lGMGZ2aktDSmF1OEVjVFJ3bnJJcFM5Vms2N0YvNE92?=
 =?utf-8?B?ejFkTkJsSTN5ZERqTXJOUXQ3eWlMM0swTTZmUWEvdmNPbVhrb25YU3dhWG5T?=
 =?utf-8?B?TjdHdlY1aEF0UlFkaU93MHdRNUE5VjU4Q3lBRFM4YnlzNmNWWHhEUms2UzJC?=
 =?utf-8?B?bTdKSjdXMFFDVDhWTzNtSHhqNFdOZmVHVllLei9xVFdhS1JKa21lT3ZqVkgv?=
 =?utf-8?B?dWxCSWtoQTdmZ2NXN2MrMHVFSi96SWVCeHFGYWxrNzdEWDFUais0MCt1cTA2?=
 =?utf-8?B?aHVueitjdmxtSlF5VVhQQkhKekZYUFJSeENoS0FFdldiYmxSd01JMkR1Mnp0?=
 =?utf-8?B?R3ByWWtwRmc4UTA0aDYvVEMxVGM4a08zZjA0WVRIaUFuWG9zOHhkYVpna1g5?=
 =?utf-8?B?SGliWVU2NmJHNFBzNExSbUtkU2QyUW1tSnV0K1czcnN1NHJFNnlMdk1oMEtO?=
 =?utf-8?B?OG9LUnpRTlZ0WllnTlc2dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFc2VFZIc25Yb3F1cmNobzRIKzRGdksvZ2tKeWxDTVJYV3NoellwbEtFcDBN?=
 =?utf-8?B?eFovcEp5ZXNUUldsZkdTbmZlTDZ1eEtOQm5ZUXZIb3RWeXF0OUYyeVV6OXZh?=
 =?utf-8?B?eXBoM1hLd2ljZEt0Q1BTZDNCRVdDMXdBRFp4K3h0NzVqRWtZaTJJblJ6RGh0?=
 =?utf-8?B?MGUwZzJLZHc5QmtTVEZHaS92Uk9xNWltQmppenlzZkkzRExyUXFJRDVkTEZK?=
 =?utf-8?B?elRIQ2c3UG5BSlZUS0ozSmpYVFVQaHllQ05aQUhYWXUxbXF3R09LbG1mQUtT?=
 =?utf-8?B?c254aE8rdWlNVlNSeXd1aER4ejducTF1SUwxMW1STTg1MXhpMDZjSjZFbmJt?=
 =?utf-8?B?TGFxaWoxTjBLQ1hmSEQvQWhTb0MzT3ZQS3N5Wi9LOVlDT2JkZjNRNW01UjV5?=
 =?utf-8?B?cmFqdzJIRmY4MGxJSHAyQ0VRaHJFeTFYeDBzUWZTZzR3bVM0QmF5eElQRHBF?=
 =?utf-8?B?UjJjcmhFNzBtWUpKSDhqTHNNUWdLVDFiTXdmRGs3cFBRUFZHYzVSWEJvU0ZJ?=
 =?utf-8?B?a0piMG94OC9hNXBJNXo0ZTVkYkdRYTlmUFREOFUvZzh0VEQ1ZE9Ub3ZldWdQ?=
 =?utf-8?B?LzhaRmtJdlJVeXZIblpvaWllc1BpMWhaV01LNUI5YUpweFgvR1QwMkphUVVP?=
 =?utf-8?B?UWRiLzc4TFlwMElaNGhXSTZJc3k5NzY5RmtIVDFuYU1MVVQ4dU9BS21NUGhS?=
 =?utf-8?B?QWlKZVFrbG5FZmNGU0F0TWFIOXlzMUlsVkJCZllDeUZrTHVpR3BiS2p3NHFo?=
 =?utf-8?B?TjNwZWpmNnZLYTIwdkR5RTBIWG42Wkc4UGc3aWZkUTRrZVFQN2dydmZSbzIr?=
 =?utf-8?B?eDcwd0l0VCtYN3dWTjNKemZWeC8zRlFGNms3QzhYZkE5NnZYK3kxYlBlTVNW?=
 =?utf-8?B?WjhvRFBHYXFrUFlmT1pkS0E4dnBBdnlEZmZFOHE1V0ZMNEt2eHlQSXJqUDNL?=
 =?utf-8?B?NGhkWGI5aVFzMDRGSW9XRW14K0d3dHhkYnVtTFBJK0ZpNmJnRUpVaUZEMStO?=
 =?utf-8?B?ZTREaWRtQWcwa3VjOVpsK2x5c0V3SFlRN3ZzcFp5MnZCTzVLQXZ4Y2Z4WXd4?=
 =?utf-8?B?MHFoM1ZRTXMzdTY3Z1RMY0ZCcnlSSjNCMDRKcXRScWR2d1o2cWc0K2l2aGlH?=
 =?utf-8?B?Yk1CZWhobjZhbFoybW44ajNCdXJlUTU2bWFES3FqZHc1RzdZNUs4ZDdBK1Ri?=
 =?utf-8?B?cTQ3S3lxbkhVaXZWcTRYczdLYmxaSGJPazBja3ZUTndNUTljV1pxUjlLaEVi?=
 =?utf-8?B?MWhLRGdkcHkvZWQ4dTBjd2I3OTRLRDhNWC9oYTJMcG83dEFWSlVYYThSS1JL?=
 =?utf-8?B?R05KdlpKUHZKS2FDWHZvZUMxczJtM3hBZkRybjg1R28vQ0xvczlENFcrTC9P?=
 =?utf-8?B?OW1HZEtQb01ETE5rMWVEV0t1OTloeC9aTlIzSzJJdGhJZzdVSGdMVjFpVHI2?=
 =?utf-8?B?Uk9nVHRUUWNzdjFMMVB6N2c2RlAxVjdBdWV5NG9JVVlXamMwdlhNY3pzekFW?=
 =?utf-8?B?Q29RSnppZkVRbVdBOUVRV3RYaVdJT3NDNE5NVEtCZEtQQWYwMGpEV2pLV01q?=
 =?utf-8?B?MmJMRlZMalhRQWNsaURwV2RCb2lvOFFkZDZ3R2hkcVhWcEpqVTlydG82NzNm?=
 =?utf-8?B?dk84bnJHeW1uRmRwUm85RkllVWo2Y2Jjb0FXcnJkR0kxMmtqMGxYNmlIVVhX?=
 =?utf-8?B?dERqSE1lWEdTU2RJN1dWdTVYZzYyV2RlcW5TNHJxbG9YblZjQWNpWWxUVTVL?=
 =?utf-8?B?S2kwbDZneGpRbUlxNzdXTnlTTFpoNXFVeXk2TjVGblZDMDhwOGVQV29mSG0v?=
 =?utf-8?B?MllHaU52bEg1MnhheDRHRnNUVXQyVDRzdFlQQlpKS2tkcUVWVXE1eW1LdnBk?=
 =?utf-8?B?Rkl4cXY1eVBBK1BhOEQ4WjZlYUJ4OVdNWmpUWU1Ta21Vb01yVWRBdzh6LzNm?=
 =?utf-8?B?eFNNNDdQeUg2S1JUNzRyS21qTCthb2l1ZStLSGRLL2N4OWhjby9YR05GOGtS?=
 =?utf-8?B?S1ZaNmhUak96NWpaRTFzTXFvWXhFc2Mwc2pNVDRScjJQa3pOUDhRaWVzekU5?=
 =?utf-8?B?a0Zac1ZLaWZGZlA4Q1lJOG5mQXdxSUF3SUpQMXc3T1dQTjRSTUkxR003cUxE?=
 =?utf-8?B?ZHFpeVRoby9YSzUydjgydjdFZzQwRFkza2o1VVFXbHNwcWt1cVRiMGZWK0Fi?=
 =?utf-8?B?WGc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e803a3f5-8bba-4551-6c03-08dcb6ba38d3
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 08:23:31.4675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 983D50aCgdmTFpvs+lNJQwxKssqk8JTEA692Sk8zZWnPmYX/AZG10GhJX2mT3bl7QaxkoXcuH172oyct9mnX9VdDw/YUq9hvbJ1MeZ+1rRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8142

Hi Jerome,
     Thanks for your reply.

On 2024/8/7 15:56, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> On Wed 07 Aug 2024 at 07:44, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 07/08/2024 03:55, Xianwei Zhao wrote:
>>> Hi Krzysztof,
>>>       Thanks for your review.
>>>
>>> On 2024/8/6 21:10, Krzysztof Kozlowski wrote:
>>>> [ EXTERNAL EMAIL ]
>>>>
>>>> On 06/08/2024 12:27, Xianwei Zhao via B4 Relay wrote:
>>>>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>>>>
>>>>> Add C3 PLL controller input clock parameters "fix".
>>>>
>>>> What is "parameters" here? Why you are adding it? Is it missing?
>>>> Something is not working?
>>>>
>>> Yes. The previous submission was lost.
>>
>> What submission is lost?
>>
> 
> He means it was just forgotten in the submission and noboby picked up on
> it at the time. He is not not trying to sneak anything new. That input
> is used everywhere in the driver and nothing would work without it.
> 
> It is just an honest mistake that he is trying to correct
> 
> Indeed the description could certainly detail this a bit more
> 
>>>
>>>>>
>>>>> Fixes: 0e6be855a96d ("dt-bindings: clock: add Amlogic C3 PLL clock controller")
>>>>
>>>> Why? What bug are you fixing?
>>>
>>> The input clock of PLL clock controller need the clock whose fw_name is
>>> called "fix".
>>
>> Then explain this in commit msg.
>>
>>>>
>>>>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>>>> ---
>>>>>    Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml | 7 +++++--
>>>>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml
>>>>> index 43de3c6fc1cf..700865cc9792 100644
>>>>> --- a/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml
>>>>> +++ b/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml
>>>>> @@ -24,11 +24,13 @@ properties:
>>>>>        items:
>>>>>          - description: input top pll
>>>>>          - description: input mclk pll
>>>>> +      - description: input fix pll
>>>>>
>>>>>      clock-names:
>>>>>        items:
>>>>>          - const: top
>>>>>          - const: mclk
>>>>> +      - const: fix
>>>>
>>>> and that's not an ABI break because?
>>> This is "fixed" clock.
>>> I will modify "fix" to "fixed",in next version.
> 
> No keep the original name. No reason to change it and make more of a mess.
> 

OK. Will keep original name.

>>
>> With "fixed" it is still ABI break, right?
> 
> It is an ABI break but on a new and immature platform.
> Noboby could really use that platform at this stage, so nothing is going
> to break on anyone really.
> 
>>
>> Best regards,
>> Krzysztof
> 
> --
> Jerome

