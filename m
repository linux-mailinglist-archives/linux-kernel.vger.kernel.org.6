Return-Path: <linux-kernel+bounces-571027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C8EA6B812
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBA723B827C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390B31F2B83;
	Fri, 21 Mar 2025 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="g08ZqgaQ"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2131.outbound.protection.outlook.com [40.107.255.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CDF1F0E37;
	Fri, 21 Mar 2025 09:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742550593; cv=fail; b=gwvD6bbpBb8II8AerWEpfrmlB6f9huZvoo+7ZBzMUSFVrYC4hKT6EltvOtwMym+ZlXwTgXIH7Y4gBbHFFfHhDdBRH09HdFqbjeigL37UYxo0xqtc2MTsB7WwzgaiXSn0Iv542pS8C5AOgJzbx5wVMw6LIqwZDAIvpgSl9w255tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742550593; c=relaxed/simple;
	bh=fN/+vZJgIPQQJKsC4s1E57uUckrScZ9w6Dgg5/3AGfo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J+3FljH5kJU4JjkJ3MikoPpo13PEk6mouDWY0sNYeCA31JcldMCDBWR+ZdcpwEDsusp5knYUOBQhVUfgRdN+ymyxjzg9qjHbFhLvxzs2fyGaEIArSQLsml5Mj2RujZB3r7+MMOE4OnacfsuOqCMmqD2dtjyXhs/+dr5AQHIZGfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=g08ZqgaQ; arc=fail smtp.client-ip=40.107.255.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ef/hErNPKsPgT6/s1OB8QKooK95MFPHXc30xa+eIwHXZHQ1IaBsYdT9//xqG8C0g6aRm/c5wHcR+T/UBIoYGZk3YgCm5id8wMxlgah7Um2+sX/S+e+qg4Mcf9BhWs6iG8+OGwktL3LrmIdsNb3zIG1OxAl8++D3/jvyWCpQsiAgjy0nSs1O94t+cRxS/Q/MXrJwQSdJj6E0zKYOWiGytuKhNO38BLJVSTZ2IAS6y5uheEONUA7yjAMyXdRce+nHMPk2O3LN7nKpBFcuCIYQBFhVemdaRxpmGTLff85ONpVnL1n3YIrJDe/kX4QctSPna7Z4RIjFRsMopRYR/wX4kBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6nCyB75k18CMIZLaONWJ/thahDkgo32NUuSUC81FRs=;
 b=ME76epoYDu3AQSBH4nep3TDRLmk6a65X5SKbOOpL+D5pM3kkv8jVu8HYa7HyJB/6d3nhOHZWKASfCwOIAIMxyp/B4cp8JldB5NzHh64sQh14IgYXM8bN2cjZI5ZTy/80FU7H0RdEIXxVJfe2XMxIB7OLyWk/urhQMAuFoAbiRMlLtFxw9vUf5F5WrQ0a+dCwQ3WH0mV9Na3MX7+4OUEgJwpifCIOlWSPpx+UNsbdiWjyTgQqZdpF0IUppLiqC6PKclQWeELqScOKEt8jUb+b57wggABdgb86VUJrOCul69HxkNxByQJFEYODMh7yMU1HpdJG6y0MfSkTbT4+iwvoAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6nCyB75k18CMIZLaONWJ/thahDkgo32NUuSUC81FRs=;
 b=g08ZqgaQutq6xkDS/d/k+ibUqk0Ik5i2gvDMp6FyKDiagzKXpvbGEnPVKrvqRElEa3aEwN3RvUF1WSTSl5nrYl/eDe+Ne+lKg03gBlT/41wmSza8LgJWk2H+7czQ1Kgwwr6WfjoWaS0a96sBXh7hoIBR0vwVdKZ3XbIRnwU50KvdbWvpJyeixHn8kgiAA48DsZbdiS5BgsouvdxNUz4KU6oHmq/dXfHgl7Jm2KQrXEo6tdaul1YVyKakoP97rzLx3oik7O4SICRWhUCdGzs0ltxGMimgz8WKxQN1IYqCGQihG+ZmDsfuZygBVBHAdFvE1U16FZgFotbOxwToHQiarw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SEYPR03MB8327.apcprd03.prod.outlook.com (2603:1096:101:1a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 09:49:46 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%5]) with mapi id 15.20.8534.031; Fri, 21 Mar 2025
 09:49:46 +0000
Message-ID: <f2a69024-8c6a-4be4-888f-e37403a51700@amlogic.com>
Date: Fri, 21 Mar 2025 17:49:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: amlogic: a4: fix dtb compilation warning
 issues
Content-Language: en-US
To: neil.armstrong@linaro.org, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250321-fix-a4-pinctrl-node-v1-1-5719f9f09932@amlogic.com>
 <5caa550a-ffdf-477d-92f4-a3222b7fba29@linaro.org>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <5caa550a-ffdf-477d-92f4-a3222b7fba29@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SEYPR03MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: 8668fe01-9587-4f60-cce7-08dd685db658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnVucWwwL21IRVJzdElYM2x0QVlWVUVQSTEyZk40WHJIVTY2L3gwa1I4RWk4?=
 =?utf-8?B?ZTBnd0pOdmtIbGNscHlITzNRT2dLYlpPTGQ4NXRDdStNbTIwTXpJK21RUVdY?=
 =?utf-8?B?KzZoZkgzQUYvTlVqdjVuVjltQWRNRGdIeTEzdmdGeHFIa3JaMTd6dFRZQkhK?=
 =?utf-8?B?a3BNNHo5MnNRZFk5R3BQM2RlZ0hBQzhIeWZsb1JvdjVhOHBZay82WWxJN3J3?=
 =?utf-8?B?SHV2cGFJNkE5SXptWDNYUTV0Vy8xa2UrQ2w3Zzh0MDRoVGMvNUpMd1BJUzhZ?=
 =?utf-8?B?ZnV0WElwWHJWNG54RjhKYWFRU2lmUk9nRU9YNWhvbnpaZ0hCalNGUTlQbDY0?=
 =?utf-8?B?UGJ3SHRIWGxMQlRGTWJNODFtMS9UVSs4OEgrNmh0cjBiaThOcm50MlNralNn?=
 =?utf-8?B?QXAwbUlpTGFPTVcwSStMYVc0R081b2FWM1ViRlcwcWJMMUpEU3hzS3B1S2hR?=
 =?utf-8?B?WERpL3lrV21UdHRhRXNQNm5YVm1lM04xRks1UFZ5QWhKbVhpNWNKcmZwd21W?=
 =?utf-8?B?Q2pJRXFCUnBtcHRvOEV6R2cxSklFbitod0wxTmRXaEFaWDlPVmtmdlRZeWNK?=
 =?utf-8?B?d21oc0VYOXdDL3JJSHJPL2Y0ckQyeEdYcGw3NmpwNWdHSnAvN1hEOUswRks4?=
 =?utf-8?B?aGJVUFczczBLVlhZSklnVStuZE1PRlhVcmlPb2w1OXJkRUhLbFFOZXg2WlVE?=
 =?utf-8?B?NjBPbDNYeUNTOW93YW1aR215QXBZWUQvOEdxQzAraDRndVY4RVNaOUViQXlm?=
 =?utf-8?B?U1YrY2VTR2tTdjFPTkF6Y1hXenoyeFprSnZNcTd6d2FpNjRTaEVsTG8vaG1n?=
 =?utf-8?B?cEhkYzQ4UHZOaGNGVE5PN25qRUJKL2M0ampBS3hDNG1YV3ZkWE9KUGZlRURI?=
 =?utf-8?B?UTlheFpJOGdrODZDLy9HbzhFQldwU3VGWStUMUszVjRvNWdvT09NQ3h3NGNv?=
 =?utf-8?B?eW92Z1loa3dZNHNZai9vVmQ1THl6bERDZjBDQkdOM0UveVEzK3dsa2tCSTM4?=
 =?utf-8?B?dXY4Y3BBNEZpRlNrZTRxWHV0YTZSTC8zUEJnYnI3ZlVNRVg0TytEVExYdk5Y?=
 =?utf-8?B?azBqRnJUeWRWM1puOVN1WEpGakVIRFRHR3lLREwvSzZzempRM21weElBTTE1?=
 =?utf-8?B?ODV5UDRzdXk5VTdiR3RtZzBLcWlCM2tndkladmZrM0VWc1J6ZC9XWWp0Y0Jy?=
 =?utf-8?B?OEdzdk1xeDB4RTMrWTN3L1B4VVBzSWd1U2dFRVAxZ2JWbXNPRWg2UHE3SktN?=
 =?utf-8?B?WmFiUGVzclB5b1hsendXY1MzOEdmNnFkTmRKS0tpN3VhekIwUW9RaXdlOFVR?=
 =?utf-8?B?cHNNL0VIN2JYQVJLUTFuUFlXS0p4Q0d4YmM4eVFDdDYrd3JXQnd4ckxOc2Jr?=
 =?utf-8?B?emJqWkNwUUVoOG1lMUUrM2t4S3p3NjhsQ3M2RS9CN3FYZGViQm9DU21vS0J1?=
 =?utf-8?B?UFcxcHJUdFM3OG1BaVlxNUZoQ24xWnVsdTlFSkYxYW1YVjRUQTB3bVZHNUJi?=
 =?utf-8?B?Yk1tVVJWZXZqS3RObTRkSXBhRkRKM2pkMi9ybEZsZFZzSk5ZVGxuc0tSUm9w?=
 =?utf-8?B?WWRWWW45ck1Fa3Bsc2pDQnl4cEsvUkpYWUtVanlrdXAvbzBVeTR6dlJOdVN4?=
 =?utf-8?B?V1AwRjRzQXRsSzc1VkRiYUh3UGN0MDFpS1dEcGVyNW4xOExyVVZqZGJmeFdP?=
 =?utf-8?B?OWFKSzdxZ1VkOVB6NGZQZk1GVDFxQm5BSXdtZ1hNVXorQWlUQUVkaTNpSW83?=
 =?utf-8?B?SzdiTFNNYkZKWkNRT3dxU3JLbEMySEhzR0k3Q3NtTW1zMmVkQnpPTWlQYWo1?=
 =?utf-8?Q?AJjqzRFcvekG97UVomaz0/5GFlwb1IEx0vOqg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2ZyNlVHcmUrbHJRS0JHcEVhQk9wd0oxZFVJSEJ4L05lS2I1V1VDaGFyT2NO?=
 =?utf-8?B?ZU85ZitGblcyMzI5S2o5RkgxVkZ6V3oxckttMVoxSEh4cStRK0JmOEh4SDBL?=
 =?utf-8?B?TFhKQWFNUzNUMjZCdDJMODRVd1pLeS80S1VDcjcvc3J4QVUwbHkxZVExTkp4?=
 =?utf-8?B?bGVycmIwTzhZUEdFSFNzejB5Tk8wUExGRFFndUlJcmdsWkozaDdqdzJaL3JF?=
 =?utf-8?B?dkdSVTd3TVhmVHRPL2xrWFhRZmU2V0lZbVpEL3FNRmhXSE5zSjlnd0Q4NEZh?=
 =?utf-8?B?aitzcGxISVptOUZoYmM0ak5Oa1RPR1Rod2JycHlWZ0F0dFYvdk80aG9jUExt?=
 =?utf-8?B?aXl5Ly8rOUpwZCswMGo3Z2dnckQ2SWxvY2lDaWFkcklhUjBMM2Q0YTdQTndi?=
 =?utf-8?B?eFBZUDd6a2tNWXlZQnBEdUlROG02YUV4SjRUQ0tzZXRyY0Z3YzljTlVYaWxT?=
 =?utf-8?B?S0pCeGRubkowT1gzWUd0Mmp3ckR1RlpCMzFvRmJPL1dpbVd5VEFlbEV0MmVo?=
 =?utf-8?B?RDZmQWhBZDRENWhtU0tvRnhSMVAyVWl2QXlPY1NSb0tyYlZMVm1KOEpGUkIr?=
 =?utf-8?B?c2VPdkdQTGd2d1owUDdkNnJGVzF4K2t3NDNac29tUExlOTlZNjRVeDczeEZ1?=
 =?utf-8?B?SU9QenFTUTdESDhwRkpZeis3S0lhbXZjaUdSV2U2WEJ6TWpWVnBZV2h3amdl?=
 =?utf-8?B?MTRuV2hVaWZtdk1taGF4a2lVR1V3cGxER3laNjVQL3czdnQycDZDVkdiU09t?=
 =?utf-8?B?ZDJrTzRHTHJabHhaUzhGanZEK0UyVkZEcGdTVkh6ak55Y3crRmNsYjQ3a2h6?=
 =?utf-8?B?UDQ5S3orWnVIVTE3Y293YWJpaW9VUzVkVjYvOXo4NmV4diswblFwMEV0Z3NU?=
 =?utf-8?B?OWFJNUxBMTIrNE51emN5R0l4eXpEUUMwSGxpbFczejBNWnlJUWozSytpbzJD?=
 =?utf-8?B?ellyNExTcTV0YUd0WUVRN1lLMjJmZzU3UDRYNUlJelhtR01GMVJ0UTZCUE93?=
 =?utf-8?B?UVZJbTZaZi9SY0c5R0R4dzA5eXZjdlhodWNGN0RhTHN5UFhXNFp1MDRSS2lq?=
 =?utf-8?B?clRjVnNZellhVDZiTzRYVWRBN0o2UmcrRFd3azBBR0NpMk5PeENkYlRpSFFq?=
 =?utf-8?B?ZFU3a252SVV1dFZiMG8wNmx2dzBxY1RFWDJxTU9ZRU9XUGU4c0dMWmpIeG1y?=
 =?utf-8?B?MWFHODhNZmtBdm15Z0pSZ1RBbVpjb1VtYXZMUjVmWjJnVFp4QlpEaGNZV21L?=
 =?utf-8?B?NExWSzFwY0Zwc2ZhaDhSSnRRdUpUZ21UZUtwVlROZlVTMUMvMVJMaXlITXhN?=
 =?utf-8?B?ekl2WVp6M1dZRVVKRFc5R3NwaFJHRERHdnpjUVJzcG93UFhHZ1JIUmZzdDN4?=
 =?utf-8?B?TFQzSDFxK0xLR0tuaFlmSTV6U2ZJR3hBcVowRzIrbkpFVGJxNE92S3Q5MVJX?=
 =?utf-8?B?cEM1OHRvMC9RNFg4ajZWWUFoQzBEb0NPK1FCdG5sVnZ0eVpkREhyNk9yMnVE?=
 =?utf-8?B?d0lPR21iYnRaV0o1K1BTSjZ1bU41RnppV2tUeWtTeE1TMXl0ZXpXcmYyUmtM?=
 =?utf-8?B?U0RBRHlCbEk4dlR6Zk4xV0s0dHd2bXp5SUZpby9xakJMaUVId0lVOFQ2Z1NU?=
 =?utf-8?B?RU5RendWTEgwUmJvbWlJYU9yUWJKUVlDcUFFQW5BTnczQklUSDZDQ0JOazJy?=
 =?utf-8?B?cWxNWkxLU1dOUnhLR05IUExMT3VuWEJWS0lBQ0FhOFlON0todnQ0Z3VmYTBW?=
 =?utf-8?B?b3hlZE8zUk9VS1RWR3d4blZEOTZSWGZIYUdoSjNMRDFHMUpZODEyYlIrbHJt?=
 =?utf-8?B?TUh1Wjg0alNQdk1wYlJUVFM1dktSeHNKQUc3MTBMd3VnV1RNUUlHTXZXc2hz?=
 =?utf-8?B?V1YxWlBCODJUdi9rNm9VaVBCVndacXlyV3IxZE1xbmY3QmdHaFU0dWdwSUpL?=
 =?utf-8?B?S0lOSWlSN3ZJejRhWUUwOUdjeVlJYk5yWjJEeEhKSEpTaHJxN0FLRUpQQVgz?=
 =?utf-8?B?MUdUWUpXYVF3WUYzR3BENjYxZ09KS1lqbzJxVDViellBdUxmUk5HdFgweTcr?=
 =?utf-8?B?ejB2SXV0RmNNZW5EU1dxZ1VHTWlabnpYSzNya1l3d3FkZ0NiZkxhQ2h3VlpZ?=
 =?utf-8?B?dTUrMCtJMk92OHJMZ1A5bWh0RDlaR3hPR1NGekVsODlOOGpUcWdKOGJJaU1a?=
 =?utf-8?B?RkE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8668fe01-9587-4f60-cce7-08dd685db658
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 09:49:45.9992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cd4m05AzjBSXon2sbaQsL3U1XKrQvVwQ2pKufunp3qKamcULnMM1iaSGqK4T8+Wdz4pHbEG8SVXycgjVj1BPwZuHwpsTCKKukwQscWwC6X0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8327

Hi, Neil
    Thanks for your advice.

On 2025/3/21 17:37, Neil Armstrong wrote:
> [ EXTERNAL EMAIL ]
> 
> Hi,
> 
> On 21/03/2025 03:23, Xianwei Zhao via B4 Relay wrote:
>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>
>> When use command 'make ARCH=arm64 dtbs_check W=1' to compile dtb,
>> a warning message appears.
>> "Warning (simple_bus_reg): /soc/bus@fe000000/pinctrl:
>> missing or empty reg/ranges property"
>>
>> Add the unit address to the pinctrl node to fix it.
> 
> I've delayed the pinctrl to next release so plase rebase
> the commit on top of 
> https://web.git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/log/?h=for-next
> and fix the warnings here, and make sure DTBS_CHECK still passes.
> 

Will do.

> Neil
> 
>>
>> Fixes: ce78f679e08c ("arm64: dts: amlogic: a4: add pinctrl node")
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>>   arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi | 102 
>> +++++++++++++++-------------
>>   1 file changed, 55 insertions(+), 47 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi 
>> b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
>> index fa80fa365f13..582e0043024b 100644
>> --- a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
>> @@ -51,87 +51,52 @@ pwrc: power-controller {
>>   };
>>
>>   &apb {
>> -     gpio_intc: interrupt-controller@4080 {
>> -             compatible = "amlogic,a4-gpio-intc",
>> -                          "amlogic,meson-gpio-intc";
>> -             reg = <0x0 0x4080 0x0 0x20>;
>> -             interrupt-controller;
>> -             #interrupt-cells = <2>;
>> -             amlogic,channel-interrupts =
>> -                     <10 11 12 13 14 15 16 17 18 19 20 21>;
>> -     };
>> -
>> -     gpio_ao_intc: interrupt-controller@8e72c {
>> -             compatible = "amlogic,a4-gpio-ao-intc",
>> -                          "amlogic,meson-gpio-intc";
>> -             reg = <0x0 0x8e72c 0x0 0x0c>;
>> -             interrupt-controller;
>> -             #interrupt-cells = <2>;
>> -             amlogic,channel-interrupts = <140 141>;
>> -     };
>> -
>> -     periphs_pinctrl: pinctrl {
>> +     periphs_pinctrl: pinctrl@4000 {
>>               compatible = "amlogic,pinctrl-a4";
>>               #address-cells = <2>;
>>               #size-cells = <2>;
>> -             ranges;
>> +             ranges = <0x0 0x0 0x0 0x4000 0x0 0x280>;
>>
>> -             gpiox: gpio@4100 {
>> -                     reg = <0 0x4100 0 0x40>, <0 0x400c 0 0xc>;
>> +             gpiox: gpio@100 {
>> +                     reg = <0 0x100 0 0x40>, <0 0xc 0 0xc>;
>>                       reg-names = "gpio", "mux";
>>                       gpio-controller;
>>                       #gpio-cells = <2>;
>>                       gpio-ranges = <&periphs_pinctrl 0 
>> (AMLOGIC_GPIO_X<<8) 18>;
>>               };
>>
>> -             gpiot: gpio@4140 {
>> -                     reg = <0 0x4140 0 0x40>, <0 0x402c 0 0xc>;
>> +             gpiot: gpio@140 {
>> +                     reg = <0 0x140 0 0x40>, <0 0x2c 0 0xc>;
>>                       reg-names = "gpio", "mux";
>>                       gpio-controller;
>>                       #gpio-cells = <2>;
>>                       gpio-ranges = <&periphs_pinctrl 0 
>> (AMLOGIC_GPIO_T<<8) 23>;
>>               };
>>
>> -             gpiod: gpio@4180 {
>> -                     reg = <0 0x4180 0 0x40>, <0 0x4040 0 0x8>;
>> +             gpiod: gpio@180 {
>> +                     reg = <0 0x180 0 0x40>, <0 0x40 0 0x8>;
>>                       reg-names = "gpio", "mux";
>>                       gpio-controller;
>>                       #gpio-cells = <2>;
>>                       gpio-ranges = <&periphs_pinctrl 0 
>> (AMLOGIC_GPIO_D<<8) 16>;
>>               };
>>
>> -             gpioe: gpio@41c0 {
>> -                     reg = <0 0x41c0 0 0x40>, <0 0x4048 0 0x4>;
>> +             gpioe: gpio@1c0 {
>> +                     reg = <0 0x1c0 0 0x40>, <0 0x48 0 0x4>;
>>                       reg-names = "gpio", "mux";
>>                       gpio-controller;
>>                       #gpio-cells = <2>;
>>                       gpio-ranges = <&periphs_pinctrl 0 
>> (AMLOGIC_GPIO_E<<8) 2>;
>>               };
>>
>> -             gpiob: gpio@4240 {
>> -                     reg = <0 0x4240 0 0x40>, <0 0x4000 0 0x8>;
>> +             gpiob: gpio@240 {
>> +                     reg = <0 0x240 0 0x40>, <0 0 0 0x8>;
>>                       reg-names = "gpio", "mux";
>>                       gpio-controller;
>>                       #gpio-cells = <2>;
>>                       gpio-ranges = <&periphs_pinctrl 0 
>> (AMLOGIC_GPIO_B<<8) 14>;
>>               };
>>
>> -             gpioao: gpio@8e704 {
>> -                     reg = <0 0x8e704 0 0x16>, <0 0x8e700 0 0x4>;
>> -                     reg-names = "gpio", "mux";
>> -                     gpio-controller;
>> -                     #gpio-cells = <2>;
>> -                     gpio-ranges = <&periphs_pinctrl 0 
>> (AMLOGIC_GPIO_AO<<8) 7>;
>> -             };
>> -
>> -             test_n: gpio@8e744 {
>> -                     reg = <0 0x8e744 0 0x20>;
>> -                     reg-names = "gpio";
>> -                     gpio-controller;
>> -                     #gpio-cells = <2>;
>> -                     gpio-ranges = <&periphs_pinctrl 0 
>> (AMLOGIC_GPIO_TEST_N<<8) 1>;
>> -             };
>> -
>>               func-uart-a {
>>                       uart_a_default: group-uart-a-pins1 {
>>                               pinmux = <AML_PINMUX(AMLOGIC_GPIO_X, 11, 
>> 1)>,
>> @@ -186,4 +151,47 @@ uart_e_default: group-uart-e-pins {
>>                       };
>>               };
>>       };
>> +
>> +     gpio_intc: interrupt-controller@4080 {
>> +             compatible = "amlogic,a4-gpio-intc",
>> +                          "amlogic,meson-gpio-intc";
>> +             reg = <0x0 0x4080 0x0 0x20>;
>> +             interrupt-controller;
>> +             #interrupt-cells = <2>;
>> +             amlogic,channel-interrupts =
>> +                     <10 11 12 13 14 15 16 17 18 19 20 21>;
>> +     };
>> +
>> +     ao_pinctrl: pinctrl@8e700 {
>> +             compatible = "amlogic,pinctrl-a4";
>> +             #address-cells = <2>;
>> +             #size-cells = <2>;
>> +             ranges = <0x0 0x0 0x0 0x8e700 0x0 0x80>;
>> +
>> +             gpioao: gpio@4 {
>> +                     reg = <0 0x4 0 0x16>, <0 0 0 0x4>;
>> +                     reg-names = "gpio", "mux";
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = <&periphs_pinctrl 0 
>> (AMLOGIC_GPIO_AO<<8) 7>;
>> +             };
>> +
>> +             test_n: gpio@44 {
>> +                     reg = <0 0x44 0 0x20>;
>> +                     reg-names = "gpio";
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = <&periphs_pinctrl 0 
>> (AMLOGIC_GPIO_TEST_N<<8) 1>;
>> +             };
>> +     };
>> +
>> +     gpio_ao_intc: interrupt-controller@8e72c {
>> +             compatible = "amlogic,a4-gpio-ao-intc",
>> +                          "amlogic,meson-gpio-intc";
>> +             reg = <0x0 0x8e72c 0x0 0x0c>;
>> +             interrupt-controller;
>> +             #interrupt-cells = <2>;
>> +             amlogic,channel-interrupts = <140 141>;
>> +     };
>> +
>>   };
>>
>> ---
>> base-commit: 73a143e436311183186ab4b365a84c662f2c9651
>> change-id: 20250317-fix-a4-pinctrl-node-9babfd44e085
>>
>> Best regards,
> 

