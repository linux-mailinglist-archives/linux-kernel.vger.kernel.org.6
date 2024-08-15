Return-Path: <linux-kernel+bounces-288086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 184EF9533CC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C09C5288118
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C58D1A2564;
	Thu, 15 Aug 2024 14:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="qMA7DePD"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2085.outbound.protection.outlook.com [40.107.104.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F639176AD7;
	Thu, 15 Aug 2024 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731551; cv=fail; b=ajORzIBlnLfGlQLiX2v2JY2G8G5hpkOZFfRH5RLf+alkV4Bn9UDnjv/H4g1/vaPk/AWAaJ3Y3lNWPfxsb9zmwfaIY3CmTt5lwYJsmLkb+dE2aIeaOuu/PioIwXpLOEZYTUcZeoYLgd3Rur/8Gw2/03dUi/cbU9Tika58QNrwdwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731551; c=relaxed/simple;
	bh=7IdP/rll/Xb0N7QrEJ/YuKAdMGOGt09t4/kXfeM6AOA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hCWWOa6YNkflkad1//2Av9SoAUyn3RbOlb0qm3KtU8shZ1ZlGutst3GANFkOdICln00goKzmolPYEdo0mwf4pwsV+lDKoxdHOYkaIHCeJ4V5bwwnQM/zWxOLU7A5AW6ggL4trBbEFOPywsoAp5Hszvc9KJb+9Y/dlY+5/Fr9D7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=qMA7DePD; arc=fail smtp.client-ip=40.107.104.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=viUTXhVwr4xRQBG8/St0V+KBug+m/duFr4A0EcxxstLRpSKUFGP3KdSp66ahoILb4hmiggASZuvpOpNQaVt3FS2T5A9MUc+LBltvgrqQJALGH48Y+3ldAB6OYITTNkLIEyRX1FUNGC1FkHVCvrxEHQ7mWCV4f2UDrC8sFzMYfbnCogCIM9Qpy3Qn/61a0bzbtkPHMlHXHn8su3FXbg+NKCichpfOwTkXx3qXiNAQlJu193tebiSYb3cXsL4tL4yVuGBlDX+4YtnIB7z8RUo35HO2F8uGAI36tC3msbk4te2b++WsmUAK6pFJqPJjra4XHj/bj2jl/4dibk/JjKG4QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MEU1FS8UBBVqXOwiRz7SFtZnrboVjmF8GF9or0XFGE=;
 b=JB/0+0ZEVUkxnwI/mV6Zn3PByHeOnnnI8GfxF1pDjXDhu2bXs3eYETY0gsdur5J4GtJsDMXnius0+eBS0b8Tgk3h1tH7vuEl8sTD04blaKwRj/R7diKpjB59MTVZCdihbtTtRQDpVYgCMhdxWsU9eRNqdVlr1SvxUcjLzHCws10sdSWi175hg2DGRF4D+ROVztWuf854fxRPcQNnAOOdDr8tt3siAx3CXGSO00zZ/WTLZ/X33Zi/Z30ujbkltnJaoJA5n2/tRGxg7xn9VxmFbB08OElumVNdZG3xwGLHhYu7SXXyFcMwE9Tcu/zopbZHL06IJasYlZFzteUsmvsG2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MEU1FS8UBBVqXOwiRz7SFtZnrboVjmF8GF9or0XFGE=;
 b=qMA7DePDUcWvnxdZNEs8wE7NZxsGzb63rZ5Rf/f/O3rhyZQWxY/+muD0wAYE5XczM/AS2n7ac8Afv1AAwd6bnqmdDzalIAi6OQXF5PlWwEiRjSlz0QHsqY8FwQPS3UR13eNcu/YRCXARFP5j8Y41ug16f2hcH1UzLZFmewNuiBJEDF3fNI/Bh7gC3JPaoZoTQWUiet6q61BzeWeMUiZqs33JTZ8eZznqHYu+jaeIFGlVLA4cCEBIKRkaxCCqsbA51+f/xwaLhKlwgKWK3GCapwnWqFJstpSnmM1j2aIuQnxnHerGPX5S6VkV5rfY481gsHzHlIn/SDlX+BtPpSzqkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3154.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:182::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Thu, 15 Aug
 2024 14:19:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 14:19:05 +0000
Message-ID: <bac9837c-6dea-4ca1-9bda-9a4985403ed2@siemens.com>
Date: Thu, 15 Aug 2024 16:19:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Add and fix ESM nodes
To: Nishanth Menon <nm@ti.com>, Judith Mendez <jm@ti.com>
Cc: devicetree@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
References: <20240813230312.3289428-1-jm@ti.com>
 <4295a15a-6285-4005-bc40-328e52addc2b@siemens.com>
 <6134b3c1-f7ea-4cca-8777-56e5705aadf6@ti.com>
 <20240815122928.4i2yob5aj5ssqhzw@reply>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240815122928.4i2yob5aj5ssqhzw@reply>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3154:EE_
X-MS-Office365-Filtering-Correlation-Id: 33f33e2b-7f8d-4c43-ef6b-08dcbd3537f5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDR2S3EvSXI0MFFxNHh5SHg0UzF4SjAxYlZ0eVludjdDMGZHb001ZldKWDFS?=
 =?utf-8?B?SUl5UGFGeVRvVDc0VnlDZE1yOXhTRFRVeEdKQ2JKek1ReUs1SFlyOGhITDEy?=
 =?utf-8?B?SGdTbnFmWFV0ZHlmS1R1RU5yVng2VnZ3MDZobDFpa2UxaWQ3VTZKZ242UkJZ?=
 =?utf-8?B?eTZvQkYzcXVOTUFtNGNUUmNBaDZBbVo5RHdxMHFmRDRpS3NxdVhJU2xiN0g2?=
 =?utf-8?B?ZEZYNno5ZjZOc1l0YjhNSEVReHFQV3MwcGxzTldzd2FObFN6T1FrdVYwVU9O?=
 =?utf-8?B?dFN3WnQ4TUJpRUd6OHNwbjlocDBRT3VPUkZrNXBlSlpSd1pCNUltaCs2OFVl?=
 =?utf-8?B?aEd1UUVjUGxEM1hxaUl2TFhKQm0wNVFDaHRZUjRiSlV5VmxqUk1DNStKTFNp?=
 =?utf-8?B?NU84aE8xQTdWR3l1TkhaUjV3aSt6eWp2YlY3anJCUmZWT1Y2MnVUZkVUaHQr?=
 =?utf-8?B?bU9RVU8vUnByeTRvUk0xY0tkOGQ4ZFYxNm9hVnoxR1hVazU5YWt2TDE2cW5G?=
 =?utf-8?B?dW92Wmt2dVhWYjZQNVBjcVJmQ0kvZXF5N1UxbnA2d0lPMk1yejhJNlNFdjdr?=
 =?utf-8?B?L2srcElWSk1yY2k5WjUzaUoxeWhBcmVYWTJYRy9MQ0tsYzVkZFlGdGo2QnUr?=
 =?utf-8?B?MkZlM3htV0NEOEhoV1RBQ2tyVjVmcjdxVkViK1hLYjE4dDF3YWhJSW84V2M5?=
 =?utf-8?B?QTVMQUJPVFh5UnVKdUpNN2xKN3p2eThEczREdGtncTdoM2RHUzMyRERFMzJs?=
 =?utf-8?B?NkRweU9jbmdKaGIzR0lJUXo4QmFPTmdUK0g4eFUvL3F3MGgrK1pvTXByNDEv?=
 =?utf-8?B?OWFvaGhHOG1Qd0dsUW5BczJkOVUxdExtWFZybVpxRVNpV01oM3FKRnk0RnNt?=
 =?utf-8?B?QzV6c29keFkrc0x3VTdwRGd3ekJ1Mks5djF4aEhodTFpUFhNeTlMUmtVU0pS?=
 =?utf-8?B?U3dFMUZ1NGJyaXU3bnZObGh3SVhJR0JMa0NpbTNYL1crZXRLYnRGbi82WXlP?=
 =?utf-8?B?SWlZMHUvaXhpVUlram5ZRStqekRTMDJtUUNvLzU5SStlN2J0RzZoNVluOWFy?=
 =?utf-8?B?RjRiMDFtczZ0V01FMEhpVzVpVG9MM24rUm5SU0UrTFhvZ0ViY3J0K215T3g4?=
 =?utf-8?B?MWhSeCtpclIwdHdSVElkeTBvUWNrNkZUZDRLRDVndGFBeW94Sit5U1lzUVFB?=
 =?utf-8?B?U3dsdWR1b0Frd2k0U29MVjRaMXBtWXhDU2VLWGU1Nzl0RkQvWGhEMFRneG9W?=
 =?utf-8?B?N0lOZUJONkEzOVd3ODVOaGJKbitGZGQ3eWFuZlUyUXpWVlM2TkdtV1lnR3Nh?=
 =?utf-8?B?YnVHdDJUTFE5andFYTZ4TGc5YjBQOVlQZTVRVDFRUmtYU2srZFdrbVpoaGto?=
 =?utf-8?B?MHYwVGtianV5MXJhR3Q5Ymg5aXpTcHR0Tm5GQ05ZVGY0eHh0YjV0eURnU21v?=
 =?utf-8?B?dFJNbXFhY1J3QklPVHo4RnZxWjFMQ1BzNTlta0d4a29MdzRTazJlYUJadjFz?=
 =?utf-8?B?T2V2YzZhVUtRTHdxdTVPYXJ3NU5QaEhNaWE0TDVleGtmRnZxM29ydy8zSGJn?=
 =?utf-8?B?Nk5tKzcyTkJpaExDS3BiNk9sMnk5bzZwWWJOdCtyaXQ2SU9MazRQWGdZTkVO?=
 =?utf-8?B?VmJ1ajBwRVU4akpkbHRwOFZJc29xVTkxSko1UFg1TmV3MkZKbkZMZUVnN3Y0?=
 =?utf-8?B?c1ZYZ0dZWXNIWWNqaFVHYnZKaUtWL2Q5emc4QmpGNFRjY214UDcydXJaMmx5?=
 =?utf-8?B?c2xDZUpRblZtQlFvMHRQeTJ6MDEwdjJVV0dTOGg4UkVxekVEVTR2V1pvajZw?=
 =?utf-8?Q?SVr/y+lyIgvL7eHmfJ2xyOmydUey0VDaSOeH8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHNVMllCUnFpYTg4MytmMDdxMHZEV1VWd0d0U2VPczFrV0sxdm10Tm1rUlZB?=
 =?utf-8?B?WWMzV0hyWE9NOHFrd0llWTZCVjNlNThDVHRUWFJrRUF5c0JnZ2tMT0Zid2RL?=
 =?utf-8?B?TFN0NWNHWUFQRjl2b05JQlowWHhTaGJQNU55aitnMTBDajM1NUl5UE5zWEFD?=
 =?utf-8?B?STNsa0ZhbFdNc1RMZWtpeU5Bc2dTc3FER1hpNmtmdkpmREtVeFhZdWRzRnR0?=
 =?utf-8?B?Zll6K3BSRGZHb3lLakxmd0R3TmxjcUI1dUZibVdVNjF4MlVwT092ekhpQmZO?=
 =?utf-8?B?VWc4ajV6bEZEN0xlUWh1cDVQaUF1ZU81dWJ2d0hBcW5Fa3RGQlJvUXZtd2lS?=
 =?utf-8?B?ZmVDSkpjZnVDSDdablFkUDZwUHJNZXFJWHlCSDg4bGRnMVdIVFJCeUoxeGRj?=
 =?utf-8?B?TnQzS0FvOXZRQ3RVbTYrUVhoamdOOGZ5Uk16T3l0MkRYOWkxSG9DbzBjR2FR?=
 =?utf-8?B?RlFsdUJZQXBMTFlnczFVc2ZCam9EMUlIRitya012UVpkZW5nOVYzZm9oZmE3?=
 =?utf-8?B?TUdIV2VUSkhENlFsWlV0aGNwMUNDU21FM1ZLQ2t6Z211YlpzcnNaR2RHN2Ew?=
 =?utf-8?B?UXNMU1dRZEJMNWVIdnhTSFpXOS9pTjRNQWplTkpJWlc0ZmRncUpHck0wRHcy?=
 =?utf-8?B?OHpGV3I1SjhCRU1JaEtqOTdZYVBLd2pNME5iOGgvWDl6WEszUXRMM0wwbTNL?=
 =?utf-8?B?RTdZT1dlRjM5RWUxTk50dFVRbmxHL01naVJqdlR3WDR2YXRGSXkwU2FpY0xt?=
 =?utf-8?B?S2pYamlVMEk4Q1RBNnBucjZna0JZQzdMTmRCcTQ3anllVmRDUjcwNStDZUlG?=
 =?utf-8?B?UWJqcHVPS3pxMHB5RGh2NGpiLzhlZis1Z0ZVQlZQekZoSlFMdUZyUVlmaWFZ?=
 =?utf-8?B?M1BtaEM2SkRhWGtCUURwTkFIS0RSbTY5WVlFV3VHakwwT0pTcFpjdlYzVFhH?=
 =?utf-8?B?VFdOMTkrTUJQSXZKbXpXbWlSd25qRE5hcmxoWWFtekdSeTB6VU9BTFZvcEw4?=
 =?utf-8?B?cmdpVVpoZkNxbytjM3JnR0VSQ3JDd2k0aFhWZlVuajJ2V1crMVFPS1lFcTZW?=
 =?utf-8?B?K1lyVE9OQTF6R1VySXVmaWFvaHF1ZkhPNUl5TVBzQjdabG5HWm1vSlZpRDJ1?=
 =?utf-8?B?cWRNQlh5TEd3WTB2aTUwNjdSOU9OODE1UHdQV3lUSk5Pdkk3Nng3NFE2WlUx?=
 =?utf-8?B?YUN6N1FCQjU5enVzeTVmb2RZM1MrMU5XOGNUTjJXb1dwMU1uLzRTcHpINnJJ?=
 =?utf-8?B?Ni95NGkyYitKT09ZcnliWDVnQmozaGdYQ0xlRGl3UmhHQVNwckZ1VjVXakRv?=
 =?utf-8?B?Tjg4R1dUK0Y1eXhTVVpEbDRzUUtHM0IyL3JYN0huZW1Hci9yMzdjRkFDaXl2?=
 =?utf-8?B?c2h4dWoyakFQZjk3cm1Kc25PMmlHaU9pMys2em00ajBzYnlORWx2OERzYmZa?=
 =?utf-8?B?eldmUms3d09wMHRZTGNvaVlHWUhmM3NrYVBWQ2ZmNjJVNGg5QXdkWjZZazBq?=
 =?utf-8?B?enRiZk9ZSHNlUHFvOVdHMm5DVTBncUZoZVlIbzlnd1JlMFRIbUlaU01weDM1?=
 =?utf-8?B?Ui8wbnNSR0RIeVZUSUVBMjljcm9XNUViT1grcjFMUzJ0VzVYNVNuL0RjT0tw?=
 =?utf-8?B?MVplREQvb0JYd09CMTl6dDZEczRRb291UkdmY0xQQkp2eTZRTmpQUHNNem1Y?=
 =?utf-8?B?clU4N0pLL0p3Z01UY2U5OUQzeG95RlhBb0RkVThISU9QeGdRc3RXZzQ2S0p6?=
 =?utf-8?B?R3Y1a3A5TDY3U0RBOWdWQVdqRFNPSTVuTmR0YUVKdEdqNU5YTHk4a0NmcDBB?=
 =?utf-8?B?MUdUd1VHVk02Y3g4VmlNN1l5UGxocjhjUEY5S1RSaGw3NmRtdk1oL1IxbEVk?=
 =?utf-8?B?aGE3d0w4cHY0L0M0bUo0bno1UEZHdHluZ0tjZS9SVmFhbElESnFhUlFHMnBL?=
 =?utf-8?B?S1MzYkpXU0RUSjNHV0xRUi9FcDFuTTgwRVdIT0o4Z3puUlpCZnZWZHVWSVZl?=
 =?utf-8?B?U01YM1JRbllGSkZCUjZNTWNJR243MFBOZHlJTHMrMDRrR3ZaWE8rR2VOUzJE?=
 =?utf-8?B?L3N2cTI5V2FWbkRkRGdFQytBRFloR3FtQnJpMWVnYzB0Y1R6cVM0emFMdDcv?=
 =?utf-8?Q?/7nrZjSqrV1Ui0Xx4d1Fm8t6S?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f33e2b-7f8d-4c43-ef6b-08dcbd3537f5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 14:19:05.0555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Um6ePDuEFZSsmI37IkZi5pInxoMw5WrcCTTmUQqzZdS7oEIcXZ1jewDWD46FHted2BKzrzxODTBqIeVH1m8Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3154

On 15.08.24 14:29, Nishanth Menon wrote:
> On 08:59-20240814, Judith Mendez wrote:
>> Hi Jan,
>>
>> On 8/13/24 11:04 PM, Jan Kiszka wrote:
>>> On 14.08.24 01:03, Judith Mendez wrote:
>>>> The following patch adds ESM nodes and fixes ESM source
>>>> interrupts for Sitara K3 platforms. Currently watchdog cannot
>>>> reset the CPU because of misconfiguration or missing ESM node
>>>> in DT.
>>>>
>>>> ESM node was added for am62ax and am65x. For am62px ESM source
>>>> interrupts are fixed. Comments were also added for clarity on what
>>>> source interrupts are routed to ESM based on device TRM.
>>>>
>>>> ESM nodes like MCU ESM for am65x are added for device completion,
>>>> currently, some ESM0 events are not routed to MCU ESM, so watchdog
>>>> cannot reset the CPU using the current implementation.
>>>
>>> Yes, that's why there is https://github.com/siemens/k3-rti-wdt and
>>> probably similar bits in other R5 firmware. I was always told that is
>>> the only way to reset the /system/ (CPU alone would not help). That
>>> information is still correct?
>>
>> If you look at 9.4.14 MCU_ESM0 Interrupt Map, ESM0_ESM_INT_CFG_LVL_0,
>> ESM0_ESM_INT_HI_LVL_0, and ESM0_ESM_INT_LOW_LVL_0 are not routed to
>> MCU_ESM0. So the current implementation to route events from ESM0 to
>> MCU_ESM0 to reset the CPU will not work for AM65x, this is the
>> implementation on other K3 Sitara platforms and how watchdog can reset
>> the cpu.
>>
>> I did find MAIN_ESM_ERROR_INT which should be SOC_SAFETY_ERRORn, look
>> at Figure 12-3690. Perhaps the ESMs could be configured to use
>> SOC_SAFETY_ERRORn instead, not sure.
>>
>> The above should apply to both SR1 and SR2 devices according to the TRM.
> 
> Thanks for clarifying - you should add that in the commit message.
> 

So the short answer to my question is "yes".

Jan

-- 
Siemens AG, Technology
Linux Expert Center


