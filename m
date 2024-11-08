Return-Path: <linux-kernel+bounces-401574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BE79C1C70
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E0D1C22EDD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4AB1E3DEC;
	Fri,  8 Nov 2024 11:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="LWKk6VU7"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2092.outbound.protection.outlook.com [40.107.117.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF9B1946CD;
	Fri,  8 Nov 2024 11:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731066659; cv=fail; b=bunqe83x2IbpMcmnHJkUfQP5tUYS/6w4ObXf6WqiQXbPj1BMWAlsxu8Krzj8Rvt5XF7r0Q0WLr1HkAK1Uz15iykRI6tyCo8Nx0jbyatNArDFkEoupFPZpAzWAmyWm4As5YLdzdGnc+ejy86lZAUVVMXotqwp8omP2JU0f3QoHvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731066659; c=relaxed/simple;
	bh=BSmue2N4/hnMagVPhTyMWggjuR0/pyU44e/z4DImFGI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oFnIanDghFPMJbg56y0EMtnAKkSwngbiUWAsCHwQBT598E74RRK608YauLHoZS62+d/X195xocIpdXCDSax+evguSfyCfwrL3+F8hTtHVp7uCnACzBrKvKpwqwY4QspqAC9v5tBWzkuN7HESOHxAeIfOSPutXd5G6GRUmnKpmiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=LWKk6VU7; arc=fail smtp.client-ip=40.107.117.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YgE7HQTLml7Cw4bK3mF4HNwWG9d77JZ7jtrr3I7zjIUw3zaeMTd+xtZpjlyMmMt8Lk0SW1S3C9NuJwwqIgO+GsuLThuRCqxXY8ba8eSW0NR/e/t5PJpWqtex/G8TEukwV0zNJwmvEwuhvuNfu5Nov2bct+Mpx9MlUddtLL39tRV8OndjxEoXr1+SoAFWXD3swXoNY4NhXXoM5zAD+Rpvj7WBI5SvOsT8Azc1LDd4eeEpopcLCutj1xeVb15Kswc7i0QqKQyaBL6VgODfwOraJt9U+Jaublp22SrY/K74Cr4gniR5OK57mQRdGwwt6nPPin5eYa3gAW3LoclellPDnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kP2AsQrGN+eBlb6gZUjqVMcYfRmybTJaV3vton59lL4=;
 b=K6RCAyNiaY5cE2RTkeFwKIAxfbTPBmqlBGyh2Voex/wKhCVY38ewSnvhpRg7xOCOjMUrA4pxcZW3q/VkFMmShOWK/3ZEuJByPSMcFJkMOa0H/TnBSG1KE7DtCXXM6ADPKUL9s4XIuFVbbb9p+qKAyaMzCv2iIbX6WgopaNlPTE5vIm8kpl8x58zQQMXDLy8cHpNsKpJksQZwbutDE7mYDR3pHx8GwLaGi12eKnhLKf1UjMtgi1FbnIJAmbkoZOwrrlFKSYyc6+dS/GHmFaqA6Dkx0vZyFQQngTb3uXtw9lxe+Kzw9p2NvGbZ/cW+DE3YSWGQdmjZ1XDUu4oDKesVzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kP2AsQrGN+eBlb6gZUjqVMcYfRmybTJaV3vton59lL4=;
 b=LWKk6VU7Rn+8tBgDx7yog3oiIr8AT29jhPoRLNOMG6IjokU1V+Kyn0M53Dg8K1QSs/MzRd52P+SQKCNfVnn/UEkvMHcLrJ/nHWjk7y7xc9LgrpQ98zhEPuryYVSbzmWHxhYQHXdPtjh50cRUTasOSiePPGf5zChgnF8uD9W5Kp5kvwfkl9ayJn0xg9EUguKLeeDCD7oqKxMIu2tUBwWmGsaKv+piynmPjaFPBcHUwSB16B1jwdsf1in2hi+xM7waaak6vJsAzZcpf4AgJzvH0FZ8hyfWDfpZjXN95xJynzz36VtPXji7qfwjo3335xUDXzFbJ3F8jnb4R/zlbskaXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by SEZPR03MB7051.apcprd03.prod.outlook.com (2603:1096:101:e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Fri, 8 Nov
 2024 11:50:40 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca%7]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 11:50:39 +0000
Message-ID: <5eb12197-330c-4f55-82f7-d13ea458ba43@amlogic.com>
Date: Fri, 8 Nov 2024 19:49:59 +0800
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
 <85aae140-5c9b-4ff9-a522-549009f62601@amlogic.com>
 <1jcyj62gi7.fsf@starbuckisacylon.baylibre.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <1jcyj62gi7.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0107.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::23) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|SEZPR03MB7051:EE_
X-MS-Office365-Filtering-Correlation-Id: f6ab5cf6-0a82-4457-107b-08dcffeb9107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1NLcjhSc1FZdWoyZGJjd1gwNm15SmRiWU9jWXNOZ0ZLQTNZamp0cGtTS3BN?=
 =?utf-8?B?UW1IQXIxdkhuRlFOVkxZOUtacWI2OW5XY1VSUHFiRjNXaFA4YUxteEJNNFZX?=
 =?utf-8?B?YjhPZnR5Wk9Vd2ViWlBSZHhleXM4SVU5cllpdlJ1NHRzYmFRaDNPb1U5YWpq?=
 =?utf-8?B?bVZtc1hOV3ZVMHg4VzlDYk5kUWRoQkQzRy9XRXYveGNhZHJyblkzY2psKzlz?=
 =?utf-8?B?aURtS0JNN0ZNbmNSdE1pTU54cmwrRXFPSzEzbUFJRkVRa3NoLzZpdUFkdUtR?=
 =?utf-8?B?OWpOTTA4UTBjRWFUcStmTFRoSXA5SHBxbEMvZ1JFTDJPK1hpQzB2emhKL1Bw?=
 =?utf-8?B?OExLYUMwUVpsbXl6WWFodnZCcGcwdVZmN1VXVWQ5L2lGSDQ5ejl4Wk1YK3JM?=
 =?utf-8?B?aVpWMFhBVHZadnNGd3Z0OXZhUXdJOC84WWRUTHA1OWZmbjh5endLcXgxdUpu?=
 =?utf-8?B?N1Z3dWp2YTZwanVHazcrcUk2Q1hVMDRxeHZMRHRoUi9yaEkrTTVyVnloRXU1?=
 =?utf-8?B?ck0xMXVuWjdmZnFOYlQ3N1dONEZyem8xSTJMZk12cm5xSnRNTFhkQkx1eWtr?=
 =?utf-8?B?eEFkWHMrdVBKSXZsalRsRU5uMEFHbnJQc2dLc05yL0lqRW1ZQkl3TkJXenZu?=
 =?utf-8?B?NEtMQit4MC9HV3RYdVJ6NlhHR1ltV3hLWHNTOEJIUno3THczQU9RbWZGcHJm?=
 =?utf-8?B?cktDbWg3U3N2VTVkVm5WQ25aVVdnU3RpZzg1NFBWZnZrS1VNZkxMZTBabGRW?=
 =?utf-8?B?RHNRa3ZlNkJLYS9UN1BZWUFxK1JjUTVVdjRZTWVJVi9hZE5SanRoSmdkVXNn?=
 =?utf-8?B?SFJBaDhHaVRDRDJkMlZUL09OMkNGZDJtaVpqVDdPc2p2TUFsMm9QdWVVSVRL?=
 =?utf-8?B?MGR2UTdIa1ordnRDQitpd3UyaVUvUUVuQ3h1QWVpNEUrMjdFQmFiYitHTzA3?=
 =?utf-8?B?cjlXdTFpc0xkOXpWSUtVdVZ2VXdXMm9vYzh5YVNtU25lNzA5clNuVGczL0xN?=
 =?utf-8?B?ay8yZlE3UGxEY1B1UHhQVUZ2WW5vTmRhZ250NGtQcE5tb014K1lNZjd1c3Nx?=
 =?utf-8?B?TzlXNTRUSFVTUWVIV01ONVN4MUdnSnlIM0NLa2YyUDdoMW5EaVBaNGU2SGRO?=
 =?utf-8?B?WlhNemIwbmQrRlpIU1MrbkR4WTZIRjFQYXAxL2xnb3hXT3VlaXhoNGprRndG?=
 =?utf-8?B?d0N0S1VjSlR4MFd5cHVlYlVlVndzZkU4a2hnbHUvcmFvdittdFpxUVg5YXgw?=
 =?utf-8?B?OTYydWVzMkZHa0l4YnVjS2pNODlnNlplMEdiU1hNK05TWkdXT2lzZFBLbW9Y?=
 =?utf-8?B?MUxYOFE4MXBqblhhT3VRUXgrN29adzVPcWF0M0U0d3dOTTZsbVlXL1NKaXRG?=
 =?utf-8?B?TnZuOHVGWmcvU2UyWlRST25PWUt6aWtzTXlvVFBTdStWeUlLSVlzN1h5TVla?=
 =?utf-8?B?ZkIvQmo3Y0JNTXNBcnJPeG1CUFRZdFJqTzE5VDZKeWkzMHptdmxPeWFCY1RN?=
 =?utf-8?B?azFkemVvb0ZFNXpZcmFIc09qdjhHYWRsRGhQczdJU3BVS096cDJadGxiaHp2?=
 =?utf-8?B?OTNZSU5DcUlGZzVKQWlKempsQklHc3Q1NnF3TktXNU11ZC9DUFdZRnkzYXlt?=
 =?utf-8?B?SDZzUVN0WHdGSE1EVFZpVVU3Vzk4a3hJOUtTekFjWTNWdUo4VU9OR2NKc0E4?=
 =?utf-8?B?WXpGMnRSWXZyV3VXUCtwdG5OSi83dXNvVnFNWVN0dUZtcDB3VktBbFZ3eG15?=
 =?utf-8?Q?lsn1YangX6xE+W5uoL3ELbbeBLS9KhpNkgPdiDe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFBQSzh0SCt4a3NBLzQ4UmZhdk5PbnA0NnpyaU5aTVp3VEdYTDMxV3VObm9l?=
 =?utf-8?B?V29WQzc4K2tHVkJTTXZjN2Q3c1Y0ZjQzZmtyZnI3YWZFK0xNSE9qeGlZZTRZ?=
 =?utf-8?B?S2cvSVhFL2M2VUFTanRWS1ZKbjVpVVZwVTQ4UmU5ZlJ4MGFucTY5QXNoLzFi?=
 =?utf-8?B?emFYL1RINTlDb1RCOWFsZERMbk16dXlhOXIwc2x0d1R5aVAvN1ovUDZCeUJD?=
 =?utf-8?B?ZExzZkUwTHlNRzlkUHo0N2tmUEIxR1RQZVZTWkJtSVd5TFFGcHpGdU8wV2x0?=
 =?utf-8?B?OUpiY01TZXd1MzBOb0ZjcXh1OVFLTmtWVi9SVXVJZWcvS3hkelVPc2F1L1BZ?=
 =?utf-8?B?RDJkdjY0cE53MVFHeWVMVTlzOVRTZGJPRS8zQTNtZElpKzMxUUhCYzVXRFBa?=
 =?utf-8?B?UlorZmVQOHdVQWpwTzc0Zlo5S2VBbUZlOTFaUExjblBHOHpudHlZZG5DZkZ1?=
 =?utf-8?B?UWp4SGxvdWxkbHBEOWs0OEY3VlpnNUIvL1o5bFBMb25mc2xmazdQMVZhWnM5?=
 =?utf-8?B?cER3OW9YWC9Kd2FtNk9Pd1NHbVhXRmNUU1E1SVpvZWFoUVdrR2FDR2hUY1du?=
 =?utf-8?B?UHRnUW9rWWRMVGxZeW1MN3ZxT3huMHNlL1BqN0ozZjRFRFI4Q1BadW5ZT0da?=
 =?utf-8?B?MW1TdVl4MlpvdzAxbTdJZkJSd1cxUFJZVUF5bmwvTU9NcGNFdDZDZFFQWmxF?=
 =?utf-8?B?NTZreWMzdDFZOVZ6bWsvclhFeHp4RGlDYXBuS3FDVVlRMEp3eE1VUVV6enVH?=
 =?utf-8?B?c3c5MGFVeVVJRVFabldYVjlTWHczemxkcGJCS3lrc0VxRHg3S2x3aVNMZE04?=
 =?utf-8?B?NlhRWFdFQjJhNjRJSHZXYko3a2JKcWh1eHhaUDNuVTRRNHg0TWpId3d0ekNU?=
 =?utf-8?B?RXN5WEdhY3pUZmI3OGw0d2tIR2Y1YkZualVycnJYYTlQTWE1a0xPNzdNTjdk?=
 =?utf-8?B?eDhhLy9MUk1DV0kyTDVuT3VMei84TFhUTHRNMzVsVFJjaHdLWlQ5ZHJ6dFFL?=
 =?utf-8?B?eE1TeEZPc2pYWlUrcElQM0NRMHJXckczaGdzQ3hiVGdyMzRQSzI3Q0E5VHE3?=
 =?utf-8?B?dzVEaDRWRlE4YjVRa1NCcCt1c3QvMnFHWllycVJSSE83bVJEOGZheFZNTzNq?=
 =?utf-8?B?Z2VGRFprMkcvRXpsRGhIeWRGOVJOcjV0emlsYXdkNFNqaDNRTHZma2Mra3hQ?=
 =?utf-8?B?cS9vS3pjb3dqdUM5bUdramJYV0hsOHUyKzFNQ2hCaGc5UHUyM0FlNW1kYXNN?=
 =?utf-8?B?YUR1dmJrNGwvZkFRbWxpVkg4NmljdVNhaVhEUTQ4QVRTK253NTcyZTBackd0?=
 =?utf-8?B?TXh6NXUxVjBOUnhPWnhRcGpLaW43SllZV3N1bXlIOGJMQ2FKVlovQzJKZSs4?=
 =?utf-8?B?WFdoSXNnRlk1MEJiQWVTaUxLNFdGOVNTR3lHVFhXRCtCNXQ0ZkI5YTAzQ1lI?=
 =?utf-8?B?TS9sWGlobjBqQTlRWUIzcTFGM1FWMUd2cWEyZjA3LzgvSnpzNzlrcnZrbmpq?=
 =?utf-8?B?Qkk2WlpWMDR6OGR3aXIrVnhnZnhnS0pFZytxQ3RTVG80MldlSTJVdFhCRHF2?=
 =?utf-8?B?ZXIvQnJEQ01LZnJmcSsvM0dLLzR3UjFtWDBHMXFNNktZWEUyaEM4RXdRSkl6?=
 =?utf-8?B?SkhLZzVxeVlRWEtUeUt3YmxYQTF4WG5sVEllUTFiMm5jS3pROXVoVm9ORHFC?=
 =?utf-8?B?czFXcDArTjRycTJ1RzZHR0xPOGV6WnBjdlJBandEWGs1TDJaYVowSThhSXZ3?=
 =?utf-8?B?bGNsQjNMV1lvQnZIZUIyazZhMWFVaW9Nbm9ETXdaTjJicnliS3FVUlRWK1Zz?=
 =?utf-8?B?U21RUFJ0REtIR29jc3hBbGcvMVArMThrdUxTVnV4Syt5b3U2dkU2TzBrMFpJ?=
 =?utf-8?B?c3lUWG9uT1kvYTMrNDZzdmp5YWdmLzNzenFMVitDNVpEcEZtYTA4amh1cSt3?=
 =?utf-8?B?NXpvVkJiTTdaRHdGNG13VlFlLyt2bmVrTEZtcWE4clNDa2ZxMmRCMlhsSHZ1?=
 =?utf-8?B?RHBGUFYvdndzRVhvUHNzT1lQd0dOSVN0VzJKaEZLNk4wZkYrWkRPWHV5RThs?=
 =?utf-8?B?NDgvajROVG85Nll0dzdtUUlSL0hTbzFablpDRE1xMXIyQTRZdUViNnZ2K0RC?=
 =?utf-8?Q?rdqrbMfZzDGA6iVroDG6WX8NY?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ab5cf6-0a82-4457-107b-08dcffeb9107
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 11:50:39.8258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jy0bXr/jwcfKgge6dYIpMxJZjUxNUVQZZC6CieLBrDI7QLYOtXpOP8RyIXjtTKnWB+tdHlNVJ/iJypL/iCD9mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7051


On 11/8/2024 5:59 PM, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
>
> On Fri 08 Nov 2024 at 17:23, Chuan Liu <chuan.liu@amlogic.com> wrote:
>
>>>>> -       if (core->flags & CLK_IGNORE_UNUSED)
>>>>> +       /*
>>>>> +        * If the parent is disabled but the gate is open, we should sanitize
>>>>> +        * the situation. This will avoid an unexpected enable of the clock as
>>>>> +        * soon as the parent is enabled, without control of CCF.
>>>>> +        *
>>>>> +        * Doing so is not possible with a CLK_OPS_PARENT_ENABLE clock without
>>>>> +        * forcefully enabling a whole part of the subtree.  Just let the
>>>>> +        * situation resolve it self on the first enable of the clock
>>>>> +        */
>>>>> +       if (!parent_enabled && (core->flags & CLK_OPS_PARENT_ENABLE))
>> At first, I couldn't grasp the logic behind the 'return' here. Now it's
>> clear. This approach is equivalent to completely giving up on
>> handling clocks with CLK_OPS_PARENT_ENABLE feature in
>> clk_disable_unused_subtree().
>>
> No. It's handled correctly as long as the tree is in coherent state.
>
> What is not done anymore is fixing up an inconsistent tree, by this I
> mean: A clock with CLK_OPS_PARENT_ENABLE, which report enabled from its
> own registers but has its parent disabled.
>
> In that particular case, clk_disable_unused_subtree() won't be turning on
> everything to properly disable that one clock. That is the root cause of
> the problem you reported initially. The clock is disabled anyway.
>
> Every other case are properly handled (at least I think).

name              en_sts            flags
clk_a                1          CLK_IGNORE_UNUSED
     clk_b            0                0
         clk_c        1         CLK_OPS_PARENT_ENABLE

Based on the above case:
1. When 'clk_c' is configured with CLK_OPS_PARENT_ENABLE, disabling
'clk_c' requires enabling 'clk_b' first (disabling 'clk_c' before
disabling 'clk_b'). How can to ensure that during the period of
disabling 'clk_c', 'clk_b' remains enabled?

2. 'clk_c' is not configured with CLK_IGNORE_UNUSED, it should be
disabled later. However, here it goes to a 'goto' statement and then
return 'false', ultimately resulting in 'clk_c' not being disabled?

>>>>>                    goto unlock_out;
>>>>>
>>>>>            /*
>>>>> @@ -1516,8 +1545,7 @@ static void __init clk_disable_unused_subtree(struct clk_core *core)
>>>>>
>>>>>     unlock_out:
>>>>>            clk_enable_unlock(flags);
>>>>> -       if (core->flags & CLK_OPS_PARENT_ENABLE)
>>>>> -               clk_core_disable_unprepare(core->parent);
>>>>> +       return (core->flags & CLK_IGNORE_UNUSED) && enabled;
>>>>>     }
>>>>>
>>>>>     static bool clk_ignore_unused __initdata;
>>>>> @@ -1550,16 +1578,16 @@ static int __init clk_disable_unused(void)
>>>>>            clk_prepare_lock();
>>>>>
>>>>>            hlist_for_each_entry(core, &clk_root_list, child_node)
>>>>> -               clk_disable_unused_subtree(core);
>>>>> +               clk_disable_unused_subtree(core, true);
>>>>>
>>>>>            hlist_for_each_entry(core, &clk_orphan_list, child_node)
>>>>> -               clk_disable_unused_subtree(core);
>>>>> +               clk_disable_unused_subtree(core, true);
>>>>>
>>>>>            hlist_for_each_entry(core, &clk_root_list, child_node)
>>>>> -               clk_unprepare_unused_subtree(core);
>>>>> +               clk_unprepare_unused_subtree(core, true);
>>>>>
>>>>>            hlist_for_each_entry(core, &clk_orphan_list, child_node)
>>>>> -               clk_unprepare_unused_subtree(core);
>>>>> +               clk_unprepare_unused_subtree(core, true);
>>>>>
>>>>>            clk_prepare_unlock();
>>>>>
>>>>> --
>>>>> 2.45.2
>>>>>
>>> --
>>> Jerome
> --
> Jerome

