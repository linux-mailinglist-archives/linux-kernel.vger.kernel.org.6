Return-Path: <linux-kernel+bounces-401343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C729C1912
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB069282015
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4271E0E11;
	Fri,  8 Nov 2024 09:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="H0md+mJC"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2131.outbound.protection.outlook.com [40.107.117.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DA91DED55;
	Fri,  8 Nov 2024 09:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731057885; cv=fail; b=i4MwCP6Ldot/CSISRIhaE2TTW1i0KF+lI6qbKjaNZdyLymh2D2oBwiLuRsw3drGRKSVEtpcgUqXjzzU2+EyYvSL2u6BOdUX4R3ogYOJZlZ2bai7EFwd0uV3X2q1ESTAUzObXqVLqsoPNkSG+oYS6r4EqmrQM7dPw82HrKMoIBq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731057885; c=relaxed/simple;
	bh=CFM0eO6khsBJVdFVkmU15wcVoRXsi0Ct2k4/L0JvZQ4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jt8AWhY5W6EwTt3UombmqWRBOLo1AyqsbbLY3T2EaGRmvmyFGep30ySioW8F/5PAYtf6GPBBQrS2sC0uS04oSqkW/hVuoiACgwuaHBTA5U4W1Yfrsh5kuwduMzJ/JQue3YUrcbfOVsznIhSTgYj6CPkmJIUn99MNheQ4jobKc5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=H0md+mJC; arc=fail smtp.client-ip=40.107.117.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nltTnOEICS4Q60ulGYZdHZCzkmNcbtHyuAEiMEeWKvK2q0XB5IuTf6ZoHTcFym63ttbvGOrJYxvtqmKhj3dTGdr9HX02amAwZH/+HtHwWRrfWu6yddBURm9BFyWg3f1y4lF0pi3xrW0PUB6YcDFuguiNJnEzqOTeOqGnLDS68A0bi6X1syGIY3OtHUAsfu9AqRQx6LPqKD8JAdGlmhfTHXomJvLR9LI6IHtoan+eFUOPOYYGcR/AqA+jQdd+sG6hxPSvRknCPKAjdvmIU+kbcOstHgopf4/OqXQSwsS7K/AHGLxJUFrcIQKJcoeqPA/YphxUIlfbE3nnKfLdQmpR2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOrneh37RY5YF34IRYatVQBAURj2GjL0MOzafrgJ+1o=;
 b=HJ++9ZsGRN9Cq32aoSVl1o1Lb+sN3AX0vJatXehcqPlv0r9KyiKYHRl4DFzhzQuDAdAEGQ8RQ6dz6NEDZbWmPz1u4cLKhWOTFrAAlM6ZKSqmzHPcktX3A2o3yUgjz4V2GtR896acGnTCvM/blrjKOQHuRalppgM8KDKkv5kyvJTS9P0O3CTnZIeYdf++VMcDYSjsetgjZ1/znudkNmRNUnAcgsnV19+bP/zJMWD8rHAzsOGK88GNx13lMPCMW9FBA8wJgydtfv5oDdQF67g2lJ69YQddzolGY3wn1IybaOF0BMSnxe1B74rd8dtpV28KGs30ccVV2+7g4kDQz0tYxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOrneh37RY5YF34IRYatVQBAURj2GjL0MOzafrgJ+1o=;
 b=H0md+mJCpNFeUWSjw9L7Hy6E1mO/dhacTOlOF0A3Iia1OY68v4lhrpVXTamQXQ2diFcchFXM9EJcyJfTPse69nxYg+/7ZZQgwHJvDAAT9WbMrtdxjQQYqjKIfbBxIngauOTvWuAd8yb/d4Vs/s6PwI6vH2SQ1xKrsmdARTQwuKL2J/kVTVYzEZ4OM1YOTFXSE6RoV/UMdSRapBhOWvLOhzXAlrFxO2A7HC/clxvTDSDmvUgsrEDQPD62IFzb5cul7d/b9SOP/HIQNoT4+g5zYu0KXjtyJeSjoqFt3OlztnRKswnpUejkeUctW9vsD/BfGRh3g1VgPp7Qw2T32YjEPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by TYZPR03MB6790.apcprd03.prod.outlook.com (2603:1096:400:201::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.25; Fri, 8 Nov
 2024 09:24:40 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca%7]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 09:24:33 +0000
Message-ID: <85aae140-5c9b-4ff9-a522-549009f62601@amlogic.com>
Date: Fri, 8 Nov 2024 17:23:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] clk: core: refine disable unused clocks
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <1jcykltj7g.fsf@starbuckisacylon.baylibre.com>
 <20241004133953.494445-1-jbrunet@baylibre.com>
 <07594a59-c999-4592-84b8-4e163d3edba4@amlogic.com>
 <1jttci2k8k.fsf@starbuckisacylon.baylibre.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <1jttci2k8k.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0045.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::14)
 To KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|TYZPR03MB6790:EE_
X-MS-Office365-Filtering-Correlation-Id: 35f7266b-5bca-482a-a869-08dcffd72793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFZyL3NrM3U3aUJYK0Y2S1dEc0FKYW9wK1l5YUMrZXZ5eFRySlczV0JqYUYx?=
 =?utf-8?B?OGZkZ01uWGdyNTd2SWtZandjZTF0WnZzL3Nzb29VanNBVnExckZZUDRCUWM3?=
 =?utf-8?B?M2o2MHRkUmtGVGhMSWdiNi9xU2VnNnhKUWZlTjhRdmdEUU5ZcUJtbGJLdUdG?=
 =?utf-8?B?MmdBZS9WWEtiS1NaSWV1NXE1amg3OGVLRXBzSHhZQTBSME94VFgzSFBEaFNX?=
 =?utf-8?B?NmFGdVVmdDR6bktadkhkQTNmUFZMSnl5bGd2cklWanhhaW4vY2ErVnNoYjZu?=
 =?utf-8?B?Z2hHT3NseVpRNGJkNktVZnlhejRhVkMvU0J4SW0wbFRCbytmaG1HaTNZVFl3?=
 =?utf-8?B?Rk5EU3hHeDRFanJwQzBHWWhCTTJCUTdxQ0x1ZDZwU1N2UTFZL1NxREpmWUFk?=
 =?utf-8?B?dVh3MUtmUzYrUStEYkxuY1FDRC9QSWhBR2VEMjFaUFIrVGh3blpkTzVsMENX?=
 =?utf-8?B?WjZvYjFBWlBSM2Y3YVhaYitxWGZNY1VLL3NTdnE0Zk9lQTUydmE1Ky9waThs?=
 =?utf-8?B?UGRUQWsrVHNNMWVBdWNmVWtOQWR5dU9INEtkU3NFRmJRc0hzMUVvMW5VcGt4?=
 =?utf-8?B?M1NQOEZ0eXFweDZ0RGVRSmxtQTA3aHpKa0tVdVV1ZXN1VExiSTFia1NiUXkr?=
 =?utf-8?B?T293R2pOQWRVUnJ6YlRtTVRPZmR5TG5WV0JWVG5CaStzZTFjWDd4SVBBS3I3?=
 =?utf-8?B?TDVWTks3T3FreWdjSUdyeVJ2d1RiZU0yam9QTWRGcGVSSjNBR2VFQko5ZkU3?=
 =?utf-8?B?RFhHTUpyYUkvdGFXZmQzbjQwcEQ0TDdnYTBmbVFNaUl4RGxyZk5uSTZIcmJH?=
 =?utf-8?B?a3V2N05sc3paazFXMlJId09iQ1VicXVnRWE0dnVkR0tVR2tBZmZYZGdwWDV1?=
 =?utf-8?B?UFEwbTZHY25NdkNkSHZGVUxLMlpkR0VLeUp5WHg5Q2lRWFc0cUwyMDVBVW9l?=
 =?utf-8?B?Z01qNjNLTVdHdFBJcG03NG5GeTJ6eTBRUEtxald6SnRBTWFDZS9odHN5ZkJR?=
 =?utf-8?B?bE5EazJETjluSXVGYVFWVGhMMksrci9SSTF0QzIvak53ZGdGeFM2ZkdUaVAr?=
 =?utf-8?B?cllFM1ZMV21lYjVsTHRsYVBYZTJ3bmNPTFIxclQ2ZUJYVm5zVlFnV0lROVNG?=
 =?utf-8?B?UUhDVnpzV0dTSVVWOGdrTTBtMGRIWERNbUJXRzRiRXV2UE1ibElqWmJ2ZUFh?=
 =?utf-8?B?YThhY2hxcEsyVWlRbmdPTjdzcXg5cU0rS3pjRWo4TmM3eGRXNk9OZEo2Ly9G?=
 =?utf-8?B?d25wZ2lBQm83bU9KR092QUpMeXRzeE1qdG9lekY2Z0RLYlNPRXRJSTdXYjBR?=
 =?utf-8?B?emNSWUl1bHB6MU81dnVQY1Y0MEFqR2wrODhGMythQjVmdVUxY2IreEczQlBl?=
 =?utf-8?B?MkNnanZMQlFrUnc2Z0lOajh6L2t4Z3hkRFhnWE1mZ1V0cjN6UCtlTlR1OHc5?=
 =?utf-8?B?Y0NhK00zejVOcGUvU1JkbjJiV0M1Sks2ZVEzbzgvQzlVRFI0eGZtS0hYb1N6?=
 =?utf-8?B?a05iOVErU3dWSVN0VkJJUzNxeDhyQzIrclFvQmM3Z2MvZ21teHhXMXd2TU9T?=
 =?utf-8?B?MlZGSXNsWGd0RG9OajZmL3JvV25ZQ2dUMzFpNDkvMmZTZ0ZkZWtxNnZOVktr?=
 =?utf-8?B?MUgxUkN5Wmx5bHRlUVI1NkM0V0NxakRiYWRvcVNaTjlIWGtneWY0RzJMZFZX?=
 =?utf-8?B?VnZ0eGw1MlpTK2IwdG9vcWNScE02UkYwd3F5aUJrWnBJcEtpUFUzSmVURG5a?=
 =?utf-8?Q?9vym1fN8VYuBnPo5ZnWi0aTu9B8bIVbuF6znOX5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0NacmQxRHhreTJqSjZReGpqUEErNm9RbzJNMDkrdGVycGdoRnJmbllWZW5j?=
 =?utf-8?B?RnlQQy9pVndaaFlreVBqSllwT29TRnZzaFkvK0YrNTM3dmFhYzhRQ2U1NS9Z?=
 =?utf-8?B?UjBzNytQYlNPa21mSjh1dFl1bkhjclJFVGV6Z2FLa1pzenQrQ0laZGJUZ0Jy?=
 =?utf-8?B?N3dMMENhaFUyRzlWYnlFcFJuREpxUEJMUmR2OStjMDNTNmF1RW8xRGVxa1BP?=
 =?utf-8?B?OC9USDk3M2p0ZTUxVTBXVEo2aTMvVTFxUlNkaHRjNzh5OGRXOWlQVlZGWmJM?=
 =?utf-8?B?MHkwa2ozNnV1M2RUUDJ6WjhVbEpDcmVNWmNycUNiU05iLzYvY3RrU3YzS21F?=
 =?utf-8?B?cWEySkhNYldWdWR6OVFOQjl0Z05jSnVnR1Y5d2gxVnJBL2JxdVVkZUxWRTA0?=
 =?utf-8?B?Ri9jTU1lckpCOUptVEN3UE1ja2NyYUlFNlRGcUtrUi82NGlZMzB1djcrSFl1?=
 =?utf-8?B?clEyYzJDWDI2VDR5cDg3Uld5MnFXZUx5K2FySHNDZ0JKUWUyb0NNRitGMHhy?=
 =?utf-8?B?anB0Z2xHY25GanFNWjJEN09ZOW1uTnB0bGRmMzVzVDUwd3JJNGcxR1MydVlp?=
 =?utf-8?B?TDFZdDZCWDdOcnNIdnpHS0J2cEx4NHRjNVpnam1pQXBtNUR6aHlhZC9oMHpm?=
 =?utf-8?B?UGNjR3dIWFRLVjBZUWlWSUZzYUdrNkw1ek9qTGFNSXQ5NjJCTkdFem5KbmFH?=
 =?utf-8?B?WjIvQVdWNUVWMUhSN3F5dHNNTUsvRGg1YVZjd3krc0lCUmNEM3I2Y2NibW9l?=
 =?utf-8?B?MFVoZWhlQVdHWHhUTXJTTElNZDBvc2tIKzc2V0JFcE1LdS9rK1U1SEdYbEtw?=
 =?utf-8?B?TER4V0tyK0lQbHJXTVNDNWFuK2ZvWWw2bGN1eWU2QzJKMU9iVUlwcXlBdUZt?=
 =?utf-8?B?RTYzeFFEd2V2TC9LQ0ozSkkyT1k2d1V5R1k4TVJHa216SW1GandQU1VVbHMz?=
 =?utf-8?B?dHJIa0xhWmNkbzJhVWVkWU1PdURUclpJam1SQklWeEJyYW1YQ1VMc3lIeGVJ?=
 =?utf-8?B?d2tOS1U0UlgxWTJqNXAwdmFjcU5SNlhzV1Z3TmpKU3k5Y1VpanVZbWZ1Mlcv?=
 =?utf-8?B?VWJDTHRJTVN0bjNpam43dHlkTGYvbFlCbUNraHFkUWVCd2V5WFF2dUh4a0J1?=
 =?utf-8?B?OG5OdUx1cXQxaU9EdFhPVCt1T0RxMnFYTnpZbEhGZ3M5MGVTTzVtZkQ3TlFh?=
 =?utf-8?B?SUdyWXh2V2VOSk85K1JhTnFOTzhvN2p5STVkUVRzSmZaaFJlTkVLMEZQdjM0?=
 =?utf-8?B?YzVPb2ZFbUx6Y3JnZnJoQ1kyWEpyeXNCUlIxeEhVazUxZzVyOXFtVm5Ldlk2?=
 =?utf-8?B?MllTOWhiNi93bUttbUJtZWpKSjZWNXpWakhIR1NJZWNrMDVyaDFTUmJYbzdh?=
 =?utf-8?B?N0ZIWlM3MzAwd29GUUp4WDJFdGlEWUkxQy93RXVJemk5cHB6VjVwZ3EzTmJL?=
 =?utf-8?B?bVp3SEZ6ZWEyUW9aSEJ0bHNrdVBacjROTlA3NHltbUNBaTBaWGNrNVBQOTJH?=
 =?utf-8?B?c3ptL1ZzZkZWRnYrdnF0a3p5bTBTRVlDYnFNdDVBbjFaYlBaRmhvWUREMFJo?=
 =?utf-8?B?UFlHTFNpdUhMb2NLTFl5UERmR3BBc1JnejM1STg5K1VWUWxvcGRDbVh6MDND?=
 =?utf-8?B?RjdrYmRTNGVWaGNXVDROR1U3RFUwNVNxMkJCMmdxdm4vREdaaUpNRHBhVnZP?=
 =?utf-8?B?Q2FkMjhlZzE1U01oV1E3NUVDdkxxamJLQ0d1QU9BZGRHK2JYRnViUEc2SDZy?=
 =?utf-8?B?d2VnTXNtWXAvU2VWUGpSdk9Nak9sMnAvWTBxbzNZMEE2MnBQWUg3UUlRalN6?=
 =?utf-8?B?VElnU25XV1k5Y3dFTzZmOHIrM0w0VEhiS2hwSG9LMHBXNzJtSVo2QVA5bk1w?=
 =?utf-8?B?ZS8vTXB3cXlzZUViYk9YbmxrQy9RSzQ5dFRrN1g2VGp1QnRyRjk2bGNXczVV?=
 =?utf-8?B?NDBVL2t6WURTdk52ZVpnRFJvUmh0Z3I2SkZKOGlxOUs2R3RpM0xPbmppZzlU?=
 =?utf-8?B?WG9QZUd6SUhGZ3lDMGtmKzBGRkgrak1hWS9hSEhXK2orNmVkcERTY1o1bDJo?=
 =?utf-8?B?amFXeFUrT2tCL2dJZUlqZEZBMktuOHlNNWdOSndnNXQ3R2VmalUwWmtwbHc2?=
 =?utf-8?Q?1JbVT65FsPnkTBWmMhoNiRFYn?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f7266b-5bca-482a-a869-08dcffd72793
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 09:24:32.8078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NLIP6CcCSkYfFcwvW/MjcLGYqqv1AbCzR+QVVWlj8I1bAVYbVNYTnwGSAu1rdRvRsStE5MqETWWdXatTRE2zJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6790


On 11/8/2024 4:38 PM, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
>
> On Fri 08 Nov 2024 at 15:59, Chuan Liu <chuan.liu@amlogic.com> wrote:
>
>> hi Jerome:
>>
>>      Tranks for your REF. I looked at your patch and there are some parts
>> that I don't quite understand: The original intention of
>> CLK_OPS_PARENT_ENABLE was to solve the issue of "parents need enable
>> _during _gate/ungate, set rate and re-parent" when setting a clock. After
>> setting the clock, it can still be disabled. However, from what I see in
>> your patch, the handling logic seems more like "parents need _always _ gate
>> during clock gate period"?
> As explained in the description, the problem with CLK_IGNORE_UNUSED and
> CLK_OPS_PARENT_ENABLE is that you'll get cycle of enable/disable, which
> will disable any parent clock that may have a been enabled and expected
> to be ignored.
>
> IOW, the CCF changes the state of the tree while inspecting it.
> This change solves that.

Ok, I understand your idea now... I have gotten myself tangled up.

>> On 10/4/2024 9:39 PM, Jerome Brunet wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>> As it as been pointed out numerous times, flagging a clock with
>>> CLK_IGNORE_UNUSED does _not_ guarantee that clock left enabled will stay
>>> on. The clock will get disabled if any enable/disable cycle happens on it
>>> or its parent clocks.
>>>
>>> Because enable/disable cycles will disable unused clocks,
>>> clk_disable_unused() should not trigger such cycle. Doing so disregard
>>> the flag if set for any parent clocks. This is problematic with
>>> CLK_OPS_PARENT_ENABLE handling.
>>>
>>> To solve this, and a couple other issues, pass the parent status to the
>>> child while walking the subtree, and return whether child ignored disable,
>>> or not.
>>>
>>> * Knowing the parent status allows to safely disable clocks with
>>>     CLK_OPS_PARENT_ENABLE when the parent is enabled. Otherwise it means
>>>     that, while the clock is not gated it is effectively disabled. Turning on
>>>     the parents to sanitize the sitation would bring back our initial
>>>     problem, so just let it sanitize itself when the clock gets used.
>>>
>>> * If a clock is not actively used (enabled_count == 0), does not have
>>>     CLK_IGNORE_UNUSED but the hw enabled all the way to the root clock, and a
>>>     child ignored the disable, it should ignore the disable too. Doing so
>>>     avoids disabling what is feading the children. Let the flag trickle down
>>>     the tree. This has the added benefit to transfer the information to the
>>>     unprepare path, so we don't unprepare the parent of a clock that ignored
>>>     a disable.
>>>
>>> * An enabled clock must be prepared in CCF but we can't rely solely on
>>>     counts at clk_disable_unused() stage. Make sure an enabled clock is
>>>     considered prepared too, even if does not implement the related callback.
>>>     Also make sure only disabled clocks get unprepared.
>>>
>>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>>> ---
>>>
>>>    This is sent as an RFC to continue the discussion started by Chuan.
>>>    It is not meant to be applied as it is.
>>>
>>>
>>>    drivers/clk/clk.c | 92 ++++++++++++++++++++++++++++++-----------------
>>>    1 file changed, 60 insertions(+), 32 deletions(-)
>>>
>>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>>> index d02451f951cf..41c4504a41f1 100644
>>> --- a/drivers/clk/clk.c
>>> +++ b/drivers/clk/clk.c
>>> @@ -332,17 +332,6 @@ static bool clk_core_is_enabled(struct clk_core *core)
>>>                   }
>>>           }
>>>
>>> -       /*
>>> -        * This could be called with the enable lock held, or from atomic
>>> -        * context. If the parent isn't enabled already, we can't do
>>> -        * anything here. We can also assume this clock isn't enabled.
>>> -        */
>>> -       if ((core->flags & CLK_OPS_PARENT_ENABLE) && core->parent)
>> This judgment of CLK_OPS_PARENT_ENABLE seems redundant. According to
>> normal logic, if the parent is disabled, its children will also be
>> forced to disable. This seems unrelated to whether CLK_OPS_PARENT_ENABLE
>> is configured.😳
> It's removed.

Yes, I just want to express that judging CLK_OPS_PARENT_ENABLE seems unnecessary here.


>
>>> -               if (!clk_core_is_enabled(core->parent)) {
>>> -                       ret = false;
>>> -                       goto done;
>>> -               }
>>> -
>>>           ret = core->ops->is_enabled(core->hw);
>>>    done:
>>>           if (core->rpm_enabled)
>>> @@ -1454,22 +1443,39 @@ static void clk_core_disable_unprepare(struct clk_core *core)
>>>           clk_core_unprepare_lock(core);
>>>    }

[ . . . ]

>>> -       if (core->flags & CLK_IGNORE_UNUSED)
>>> +       /*
>>> +        * If the parent is disabled but the gate is open, we should sanitize
>>> +        * the situation. This will avoid an unexpected enable of the clock as
>>> +        * soon as the parent is enabled, without control of CCF.
>>> +        *
>>> +        * Doing so is not possible with a CLK_OPS_PARENT_ENABLE clock without
>>> +        * forcefully enabling a whole part of the subtree.  Just let the
>>> +        * situation resolve it self on the first enable of the clock
>>> +        */
>>> +       if (!parent_enabled && (core->flags & CLK_OPS_PARENT_ENABLE))

At first, I couldn't grasp the logic behind the 'return' here. Now it's
clear. This approach is equivalent to completely giving up on
handling clocks with CLK_OPS_PARENT_ENABLE feature in
clk_disable_unused_subtree().

>>>                   goto unlock_out;
>>>
>>>           /*
>>> @@ -1516,8 +1545,7 @@ static void __init clk_disable_unused_subtree(struct clk_core *core)
>>>
>>>    unlock_out:
>>>           clk_enable_unlock(flags);
>>> -       if (core->flags & CLK_OPS_PARENT_ENABLE)
>>> -               clk_core_disable_unprepare(core->parent);
>>> +       return (core->flags & CLK_IGNORE_UNUSED) && enabled;
>>>    }
>>>
>>>    static bool clk_ignore_unused __initdata;
>>> @@ -1550,16 +1578,16 @@ static int __init clk_disable_unused(void)
>>>           clk_prepare_lock();
>>>
>>>           hlist_for_each_entry(core, &clk_root_list, child_node)
>>> -               clk_disable_unused_subtree(core);
>>> +               clk_disable_unused_subtree(core, true);
>>>
>>>           hlist_for_each_entry(core, &clk_orphan_list, child_node)
>>> -               clk_disable_unused_subtree(core);
>>> +               clk_disable_unused_subtree(core, true);
>>>
>>>           hlist_for_each_entry(core, &clk_root_list, child_node)
>>> -               clk_unprepare_unused_subtree(core);
>>> +               clk_unprepare_unused_subtree(core, true);
>>>
>>>           hlist_for_each_entry(core, &clk_orphan_list, child_node)
>>> -               clk_unprepare_unused_subtree(core);
>>> +               clk_unprepare_unused_subtree(core, true);
>>>
>>>           clk_prepare_unlock();
>>>
>>> --
>>> 2.45.2
>>>
> --
> Jerome

