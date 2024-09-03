Return-Path: <linux-kernel+bounces-313007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BDC969EF1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E4428661C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CCE1A726A;
	Tue,  3 Sep 2024 13:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="TKos5iNv"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020143.outbound.protection.outlook.com [52.101.69.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0B61CA6AF
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 13:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725369779; cv=fail; b=Jyq6yBEGE1ml8NDJsHLtKF1SPtsqqLfPVpw6DUjHK6AfHrPUmDfqBwB62G+V8522GdASTBKgjY7OxjBLkllHArzjGJIoiwi/PuaxUHHTP3QhjA7QNTFV8VUL7BcZQffW/irC1vj8DvbJ0H2wFWTzwQ7QW/y7olh2KogzkskWObg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725369779; c=relaxed/simple;
	bh=kvSon9fJ/D0R/yrsPihe0ifQ/5J46WUVTo/vBHYOCqg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f8ioSGa9+VK2nnn/0DVo7IRwGb/30gdWL1rR4xRKToiKkp2IzFb8wFllEVb7Fws+QSTabZvVvry9PtbFdEh3BMTcGBZrugAPkAo/4eDs4U+KOw6WukZxD6xaxBYwvXdjez4QSJB9YNPytDb2+hM209BTOwlMZgdFK7NUyfUweJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se; spf=pass smtp.mailfrom=axentia.se; dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b=TKos5iNv; arc=fail smtp.client-ip=52.101.69.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axentia.se
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FAmCfrRZdNf+1vlOe319y6d7FYEVqJa7zAJYyxd8/4JJ/r4t6cQcNAnQ/hxxG4fg0XzH+rcgmN78Hmz7oyWBECfcPVN0BJbFhc1UVWttLFRCOZFQ4zWW+2eNY0N49TX7qTuyz6NioBaUtrf3B7flLvpASryK0D4BpTSY6jP2MCYgOC2YrN2l0mrT79D3Kbvhz/IaHJ8f/cu9xH/LSj5bKLfM+/3C1hYb3Koe3IZLANjpS3AxqBoXMcRJH/dxWoMkJEPlks2DX4t1jMO2FVwBXxPAuP4qIEVVSaOy0jKlhKubrU/45F4lej5mAEePyEagpCJBWkeyHIK1bzWSXBVJnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CjxQNRy+wA8k5XPpR5v9X4tFV11Cn+NQmyRfQUNFec=;
 b=s3Bo8bRnHCZiEf0KIng5e+hX5HsqRGv09TQ+4l/Rx0B1V+TKLQdimqO0lA4JlOmrEnAEDPooQILWa5BzQp23Rah30SeyqcYxLPP6J7t7u99Q2fJTbB+abZMQ9+N0OZH6Ki2/IcMoJt4iOgmMHDXO1Wb7XbQ5X7oiv3MX1wHuKVhWGs8pkbyeGoL5L9xxIaUxe7d4idmfY7qMnOYLIFSGw68F179GTyWJS/pWPKVJ10IclIOTpUa52LMmCBElNtGPAY9k3KA00dEMLv3ZgKDEBN7/xHvP8vj0DLCduQynkw5gXBZoPkJlkQEg2yrQNqQBvoGh1XvTE3D8PMvFylgsCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CjxQNRy+wA8k5XPpR5v9X4tFV11Cn+NQmyRfQUNFec=;
 b=TKos5iNvGyAYN0Mbses6DEb7kmvYV3+rz85OpiRCJMSLaHRs9Ny+PCPvhRFCbcxUp9yO/QQpIQlTPa54L2KjiDqwB3v/96G8xQESm40JDxzzub+o5LI/lLx7U4T5u3ioyS0Z7nuWj5PfSIw5t65laH/tf5F16R0Jrjhec6kNkZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DU0PR02MB8500.eurprd02.prod.outlook.com (2603:10a6:10:3e3::8)
 by AM7PR02MB6355.eurprd02.prod.outlook.com (2603:10a6:20b:1c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 13:22:54 +0000
Received: from DU0PR02MB8500.eurprd02.prod.outlook.com
 ([fe80::aff4:cbc7:ff18:b827]) by DU0PR02MB8500.eurprd02.prod.outlook.com
 ([fe80::aff4:cbc7:ff18:b827%3]) with mapi id 15.20.7918.019; Tue, 3 Sep 2024
 13:22:54 +0000
Message-ID: <94069d56-0981-2d69-65c2-901a05758806@axentia.se>
Date: Tue, 3 Sep 2024 15:22:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] mux: add mux_chip_resume() function
Content-Language: sv-SE
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: linux-kernel@vger.kernel.org, gregory.clement@bootlin.com,
 theo.lebrun@bootlin.com, thomas.petazzoni@bootlin.com, u-kumar1@ti.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240613-mux-mmio-resume-support-v1-0-4525bf56024a@bootlin.com>
 <20240613-mux-mmio-resume-support-v1-1-4525bf56024a@bootlin.com>
From: Peter Rosin <peda@axentia.se>
In-Reply-To: <20240613-mux-mmio-resume-support-v1-1-4525bf56024a@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR09CA0030.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::20) To DU0PR02MB8500.eurprd02.prod.outlook.com
 (2603:10a6:10:3e3::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB8500:EE_|AM7PR02MB6355:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db26286-c15d-462d-7b96-08dccc1b84a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1k4RTR1a0trOC9HVEl0WXh0QXlCWkRxWlJ4bkpVT1A2SE84eVRpUTVHTXFa?=
 =?utf-8?B?VkQrMTZTa1RMREV4NVNWeG4zblJoalJUK1pmblk0QnhYcU5sS1RvaENOZGlB?=
 =?utf-8?B?ZXcxYmozSDliZWlFczJLalJlMjg2NXNrSzJ1YVN1aGVLM3o5Z0VJYllrekYy?=
 =?utf-8?B?aTlBSXoyOHpjWFgvWmlDejg1aEpLaVdCd2FMU2I2dXRCOTFNQlQ3cHlZZlYz?=
 =?utf-8?B?eW1QaEhaQ2Myb1hxTkhLSldzank3TFc5cjJOZUl0RjNnT2Z6OVU0WHo3eUps?=
 =?utf-8?B?RCt5SEFFSmxjMUJ1RTFxcjhWTzNNd3QybURvSDRoaFBGMEZETzY5MDltMHhM?=
 =?utf-8?B?UTN5YzhhaTd5NmNYemVLck5DUkg2bkhSVW83ZG9JRjQ3MnhKNVdrTWZZVUd0?=
 =?utf-8?B?RDdmNkUvcHhrVzRjcGdxbCtJTEJXVDVFaE1XNTViRGJNYlA5ZzZLV1VHaHF4?=
 =?utf-8?B?RWM5OVpYSk0vbmpLTUN0QzZ0Skl2MUxFSGduWDl3WVJCaWttdjNNNWhkTzZM?=
 =?utf-8?B?SURYa1B6N0g3TDhiOWFHcDFxdUVrQThraUhNZm92a3NUcVdOS2UxbmlZa0pZ?=
 =?utf-8?B?NFdUMnI2N05nRUN0RDQvQzJpWFhCTmUrRXplRTJjQzNTOW50MjBhMjdIaUdy?=
 =?utf-8?B?VnlaYjhkdWZaSHNaR2piOFZZZ1pSd1ljTU95cFROTWVFdlRCTmVMeGExRnMv?=
 =?utf-8?B?ZktieStmSVJpeDNDUjExakp5NDYyVG5Sb2hpdjZ4cWxZRDU4eGNyTWI0NG51?=
 =?utf-8?B?VTd5aTE3M2kyeUZjQkpJN2xRZGxXZFhvSk5vcTU1QjN1bVY2RkVGOE05a2FE?=
 =?utf-8?B?NU5ONlVXYkR1eDhlMlpaUHZLUHhYcjd1NXNGbFZKTmtjbzRMRGdVd2xqUEJ4?=
 =?utf-8?B?V1FPVTlkcHlKdHJkRGVJZ0ZXMkFudE5ROHEyU2krb0I4NHpwd3JVRXJPV0Zy?=
 =?utf-8?B?bk1yLzlkOWlXbFNWUXAyL2NQK0dDSk91bjJlV05iTjgrZE9NeHNsTGRnRXE1?=
 =?utf-8?B?cHMxK3NHd2JoMTRmSnBKOHgyVUExb1FZZWFTOUdyQnZLYkZBWnMyRy9KbFRw?=
 =?utf-8?B?UG91dUhwOW1yMlJSK3lldFpMRHJHYmkyTXVQaU9saFNTUVBLTVdaaVlnNW55?=
 =?utf-8?B?YWVXZFV4aVNWUXE0MGR1ZXd5ZDAycHFHYWFjYlNScWEvMXFiK1lkbG5EdGV0?=
 =?utf-8?B?ZU5VVHlUUUNRQ2Z2b1pITlN5KzNJcjJrTFZCaXB4aVlHY2szeGl1QitFNzE5?=
 =?utf-8?B?dkx1dWIyNm1CS1Uxb3ZUZCtqdk1xbHR0eTBkSlMrTjdYVk8wQTcwSGk1Z1VX?=
 =?utf-8?B?Wm9rRFlaaDl5b1E3SUcvSXR4UUp2aGlSZmVZZXJPRWNoK3NWVEJsZ3RKN1Qr?=
 =?utf-8?B?ZVRIQk1RWVZyNFQzbnB1R2k4VHNUOGRueHJpZDZUZnBrMGp1dXdUL3FNUmww?=
 =?utf-8?B?a09iR0pWcHNVYUtEa1c3YU54MEVRWG93Yk11UmpaS20xak5QL2JRalNpandI?=
 =?utf-8?B?WDFIL1BZVUYvM1BzVWZENG5pL3RBVEZGeXFaaTdDS0V3R1RNM3ppTjRmRVdC?=
 =?utf-8?B?YmVISUMxQmxqaDhpWi8vZ3pnRHRyb2Y4Y09TTFhxRHdmcTJrODBYUWVlaGhK?=
 =?utf-8?B?WHVpcUlqcUdMSnN6MEwrTXBHcWlzcWQ5b0djR1F3VGt6OGtpR0t1VTBQRFNy?=
 =?utf-8?B?ZWlER2ErTXpwb1ZqeUFMOGhMWGFvNmo4RXM0UEhuRnR4NlczV0JHWnJlR0ZQ?=
 =?utf-8?B?NFJyTG90dTNaSGkwWTVCdTMyL29nZEFEZEpwRjVES0ZTVmJzZyt0VWVaeDdN?=
 =?utf-8?B?NWdwby9ZTS94M0RNRitOQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB8500.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXFPbk5QSXphYmd4T2JTaWRFSHA3RU4zUWJCanJ3Z2huS1pQdFVJV1pobkow?=
 =?utf-8?B?T0xOaWJqUzBhQnlnOG0vcURRTENnOTM4dHZReTFLdDlMT0p2dU9CU1JubkRl?=
 =?utf-8?B?M0l0ZE1pWVBMbXNobUZjcnN2NDN2MXZETmRYZFZ3SlR2N08zbTZ6RU5UYWM4?=
 =?utf-8?B?ZXd1RDA5dEpyelF1WTJPSG9QTkpLTVhBNG43cERHZVVScHhMVU1iaUFCOWQ2?=
 =?utf-8?B?WlN6M0IwakZWQmJoYndQdmhvTElOelUrMWFPeVNGZ3RpbTVVRFhzaWthSE9x?=
 =?utf-8?B?elU0aWRnbFZ0WkV5aFo4OGdFamQwZ1NpeFFobHovTmJ1S2x6SGxSV1lMdE51?=
 =?utf-8?B?OVBmelJkOUxSTGRpL29KTzFUeSt4SVFsTEpkemxZV2FqMDFWcjBmMHJvNW5U?=
 =?utf-8?B?U0tQZG82ZWhHaXdvVlJVYzlYSWQxM1BjaVJQNEkrK1Zqa1F1TGtCWTZ4QzRy?=
 =?utf-8?B?TVdWaHhaeDV3RWd1NnVxRUFGSWd1c2xmUmVlb0tOWjBWQVBvSGpjWm5IYUgx?=
 =?utf-8?B?QWEvMlV1dUZGdlphMFRDejlpcVNySlhQalo4SnNpZmtkVElVSGc2KzZBRVho?=
 =?utf-8?B?WTd3U2c5Y0NXcmFsZUtpeU9DR2ZDY0Y1WU5ldStGQmNMcjNuU1pMdXhxQW9z?=
 =?utf-8?B?L0U0WkszT3BJVlRtbGpEUnVJQ0pXM3ZubXVvTzBtZy9KdmNVcGdrc3BkUlMr?=
 =?utf-8?B?SjFnQW4yRTQrTnBtdjcxb2daRUo1K1JtQTJBVkFrZVg1VVcraEZOMWVmdmla?=
 =?utf-8?B?U0EwRXBOMTRwdEM0aFBBNWh1WlA4ZCtsZVEySFh1dVF4QnJ4QTg1WWdnZUpM?=
 =?utf-8?B?elNUeEFFVW1YMGF3VkI4WWw5cldZYjF2ME1qbUhKcWNUdXRMcGNESjJoa3hF?=
 =?utf-8?B?ZWlHR1Y0SCtuMjluR1VzdTFkejk1eUFCVWIvbWxKL0tFS1VZeERMNi9FQjZJ?=
 =?utf-8?B?QkU3TE5EOHoxSE5yamRqMEVZR01xamkyVkhYV2JpQmhTU1c5SXR2Z0VjMjZ4?=
 =?utf-8?B?MEpKQWJnRDVGNlE4NW5OVnZndU9uRnk2TWVBQ3EyRVAxaGdrVXh4NVRUR3dT?=
 =?utf-8?B?L1hXcUJFeE5GaW5iY2wxNUl6RlVZalEwbEROTFEzQXBwK0wyVXR1bEZacEd3?=
 =?utf-8?B?bnBoanpQQllONzlSdkFpTVBFdW4wWlNmQVNKS3ZLa2h3d1FrMGR6bkUxMXhn?=
 =?utf-8?B?SlkwZnFpb282TnFjVVVDYjZzYWpNV296cktCWWtvWnhuNkkrL3laWW9oVjR1?=
 =?utf-8?B?ditHZ1JGTFZsYWlpZ3NRbTVKTkdFUkkyT0VobXgwY3J1RUkwcDVzelloREpL?=
 =?utf-8?B?amZPZ3J0ZVJuVkxUMXk0U2xYaDBrdG42MzZ6ZDBqRFZRTlF1RWRHdzIzVk9J?=
 =?utf-8?B?M2Z3YU5aMDBPOHIybGYxQjBTai9Tb0pFcE8xejJaYU9Ic1JPc2pOZWhCRWdp?=
 =?utf-8?B?U083NXFFeW52a3V1aHNBMUhwSnJONm1oVFRKQkgxdXlMVzduY21NdEFRdFZE?=
 =?utf-8?B?L2t3OFlqRnRVOC9TWElHaGJVdy9DQ3VnNjRXU21scE9DK0RrdXpGMU5MN1Nh?=
 =?utf-8?B?a2x6VVk4anExZnNrTjFNLy9xME1vTmIwTWlIVlVKU2MybldGd1UxNjhxQ3dn?=
 =?utf-8?B?Ky8xYi9HMHcrcUFVcGdhNkpzOWl1MWt2UGtCTTJvMHJPeHZTVjVJQUxENHZo?=
 =?utf-8?B?Z0ZKQ1l1MG1tUWRidkRoTWszSHpzdWcxbDF2enVFckNldzJ6NXh6dG83Nks0?=
 =?utf-8?B?TnBVVEl1cXZvNHg0YWZIcGpSaFlLcWw4SjFVOHpTQTRya0NiMUNrK1lEWnc2?=
 =?utf-8?B?RlAyelN3YzFIKzM2L2Jjb1dHa1hzT2NTOVBSZ1ozSS9UOEdSSTA2a1RCa0Yv?=
 =?utf-8?B?SUExNE1QTG51Yk43ZTc4T1VOSVBQOXAxYVZ3QjNWcU1PVHJ5ckJJZEdzUXNN?=
 =?utf-8?B?SlpCN2RUZ2dxMFBFbWlMWXVWdUtRTXIzbEhlRUlHNTFCMlM1Wll2TmVhNlZ6?=
 =?utf-8?B?TVhwVnIwYnk1WTBHNFdBM1plb3JvS3Bwb3JpZ1B4U09RKzdOY0lVVVpsdlBh?=
 =?utf-8?B?c1FOMHpvNUdxWllTT3RZdFp2L0J1RVowK21HZ0ZZWnErbkRWK0VWNk9kWmpI?=
 =?utf-8?Q?g5TxnSE7svpJY/3++Y5mHPfRo?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db26286-c15d-462d-7b96-08dccc1b84a5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB8500.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 13:22:54.2651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDVTSyWY74y/KHWk8o9qSzv/KsiHtmjAXTi9l5EAPeQHfCPHiMzztRkv1qY7O5jR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6355

Hi!

Sorry for being unresponsive. And for first writing this in the older v4
thread instead of here.

2024-06-13 at 15:07, Thomas Richard wrote:
> The mux_chip_resume() function restores a mux_chip using the cached state
> of each mux.
> 
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---
>  drivers/mux/core.c         | 29 +++++++++++++++++++++++++++++
>  include/linux/mux/driver.h |  1 +
>  2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/mux/core.c b/drivers/mux/core.c
> index 78c0022697ec..0858cacae845 100644
> --- a/drivers/mux/core.c
> +++ b/drivers/mux/core.c
> @@ -215,6 +215,35 @@ void mux_chip_free(struct mux_chip *mux_chip)
>  }
>  EXPORT_SYMBOL_GPL(mux_chip_free);
>  
> +/**
> + * mux_chip_resume() - restores the mux-chip state
> + * @mux_chip: The mux-chip to resume.
> + *
> + * Restores the mux-chip state.
> + *
> + * Return: Zero on success or a negative errno on error.
> + */
> +int mux_chip_resume(struct mux_chip *mux_chip)
> +{
> +	int ret, i;
> +
> +	for (i = 0; i < mux_chip->controllers; ++i) {
> +		struct mux_control *mux = &mux_chip->mux[i];
> +
> +		if (mux->cached_state == MUX_CACHE_UNKNOWN)
> +			continue;
> +
> +		ret = mux_control_set(mux, mux->cached_state);

mux_control_set() is an internal helper. It is called from
__mux_control_select() and mux_control_deselect() (and on init...)

In all those cases, there is no race to reach the mux_control_set()
function, by means of the mux->lock semaphore (or the mux not being
"published" yet).

I fail to see how resume is safe when mux->lock is ignored?

Cheers,
Peter

> +		if (ret < 0) {
> +			dev_err(&mux_chip->dev, "unable to restore state\n");
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mux_chip_resume);
> +
>  static void devm_mux_chip_release(struct device *dev, void *res)
>  {
>  	struct mux_chip *mux_chip = *(struct mux_chip **)res;
> diff --git a/include/linux/mux/driver.h b/include/linux/mux/driver.h
> index 18824064f8c0..2a7e5ec5d540 100644
> --- a/include/linux/mux/driver.h
> +++ b/include/linux/mux/driver.h
> @@ -88,6 +88,7 @@ struct mux_chip *mux_chip_alloc(struct device *dev,
>  int mux_chip_register(struct mux_chip *mux_chip);
>  void mux_chip_unregister(struct mux_chip *mux_chip);
>  void mux_chip_free(struct mux_chip *mux_chip);
> +int mux_chip_resume(struct mux_chip *mux_chip);
>  
>  struct mux_chip *devm_mux_chip_alloc(struct device *dev,
>  				     unsigned int controllers,
> 

