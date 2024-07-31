Return-Path: <linux-kernel+bounces-269944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 873B394391D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D3FB281A3A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3E916D9A7;
	Wed, 31 Jul 2024 22:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MJDu9oJN"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2073.outbound.protection.outlook.com [40.92.45.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0433C2744E;
	Wed, 31 Jul 2024 22:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.45.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722466152; cv=fail; b=tPOunwYkpMDifveUqOIkmQBsdQdCO8VAZjcyamWP6Wpd6io30I2aXklcMB+BVbh92pxjlEcWzUd8JNBNdV69Kq6cTkng2Qx3GZgAXrG6Tmz5l24WMqT2P3M+WXdmZ1TiZEYlXTGxx7IV3o7aOiVJPazk4U33B+R1ontZr2oStgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722466152; c=relaxed/simple;
	bh=TgzrZF2Y0ojPSPMYphVuGu0HrjT0hmyRzgY4FAdLyIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kq0NpGqQDTdzHOlvgUu3Jf4DzN8+ybn26oVWBOjEPzzUubFD/T5zXRlfrO9NBhh5fWO3u7HjSNkCLUjGvlYHmB9H1vOH3j3SwSlFT6G8VyPIBt5DL3nG1tUfsDLSrJhH5j2yOS9ZpILSRdGd4iSpQghxsr90IgTx524BY3ODQtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MJDu9oJN; arc=fail smtp.client-ip=40.92.45.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nz6f5UPzaXm7I7myeJnT1WrI9QnHFblD8YpBjG1S1FZVihmpIbEgkqlOM8SP2pxRWC+s+Ow6fH3mCjAXtmzkmEUNjqpd9lZjS20MQ4vPL50I7gt7k71OS9NthG+95ZWIqe3S3qj3zKo+iq8mCJtaEk3W1B5tsC2zgy4RJOhhYIeBr1bl0+bV8MHzyeCammX79Fy1l2cq6YHhLjbPAjIHJXc3lRPQx7wabQQiu5E6w3/3mPGDBzY06bPcSBBNgAkBYvFxFzWilEaqnFbGCf4ZJD15KmxZzp/dLQa+xiJis7l5kZsu3ebEN+OyS0VEtq7Y2Z6nbWm+/JHJUc/aEtQWSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQ9tNXQtc/tu+bixljgPBdbPuWSl8dx/zWKtVLEI4YQ=;
 b=JsEk+ZPXlb3tAnKhkSIUzbdmXL7hEZpV9crFAHz7y8RicFoFNat/jTpewRGKr0Ee4QTO6RM4D3W5vXOFoDOgBOzhuxvvpzO3O8e1h0pYeG486sOb3SnTBkr9c2+dl3++kmAXabH3Zq0++arin9/Iw9XwL2cfRS0KfWJcDtmNAKx2FbQX9pii9NY/0U0YbxYeR6tySj9vww6XiEWQqha3Ivq9bY8i1MQ5z/b3/b3HvweHZF7QROsXlUlqEHEv7vjuOcudrh0nt7dj13XIpjUSN6XIptPsTj/Irm03tayFcIlCg0ldsUW2PY+ontaRGYvEXpD57AxQ8Vbb+OAwA4LWcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQ9tNXQtc/tu+bixljgPBdbPuWSl8dx/zWKtVLEI4YQ=;
 b=MJDu9oJNAIxlVpvq9iGTcXWfoURZCsQwGY+N9+TdhSIocOkioDTjHaJhvHOdzBHNNFUDgWREug4dkHBWl7QsvcnOvRig/wvIGPlz5mU8dQt2pEZyZWPp1ITBijc++wLHKMYKt4dh2vJ9KeEZpAUl8/WG94IRFLPptcX3FRWyUXrgGkV/gSpYzR/vQkbz/Zog0/vLmlUaaBLYqcgPpwdQcCCLaReLioXzqV+JLCTNoBJ68nH9mloWtIMabdfrPQOAA32NdVedBd8CnmhstKTu/yzpk1zS8bKDBbxxBm4lg4osSCP6LTX5kP/KY0d8LXzbyrMbBDtL8AThX6Zt88hmGg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CY8PR20MB5714.namprd20.prod.outlook.com (2603:10b6:930:9d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 22:49:07 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 22:49:07 +0000
Date: Thu, 1 Aug 2024 06:48:34 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Guenter Roeck <linux@roeck-us.net>, 
	Inochi Amaoto <inochiama@outlook.com>
Cc: Chen Wang <unicorn_wang@outlook.com>, Jean Delvare <jdelvare@suse.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, Chao Wei <chao.wei@sophgo.com>, 
	Hal Feng <hal.feng@starfivetech.com>, Jinyu Tang <tangjinyu@tinylab.org>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, chunzhi.lin@sophgo.com, haijiao.liu@sophgo.com, 
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v8 2/4] drivers: hwmon: sophgo: Add SG2042 external
 hardware monitor support
Message-ID:
 <IA1PR20MB49535B0E8AB827FD5672580BBBB12@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49538C09E94D90F07B7B2562BBB02@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953DE89C56AB3F328954131BBB02@IA1PR20MB4953.namprd20.prod.outlook.com>
 <MA0P287MB2822D0C770667CFE484EBC95FEB12@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <IA1PR20MB49534944E268A0A71AA3D5D1BBB12@IA1PR20MB4953.namprd20.prod.outlook.com>
 <75f6f910-43ff-4d98-b39f-b4b0629a56a1@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75f6f910-43ff-4d98-b39f-b4b0629a56a1@roeck-us.net>
X-TMN: [eUgIcC8ZM1dTn+Kdhqp9Oyc8fWmuiFhd6z51yM5zVAI=]
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <rkkokpahtbojln4bd3pxmzqyi6hproyiwdfszb7a4vtustzbf3@ik3u2lxozmet>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CY8PR20MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: 2016eca2-b822-4f65-5d9d-08dcb1b2fbd7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|461199028|5072599009|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	Kl166dRwMhs1Xx8baaiiHOFwpM+FAU5/8BTTKztJXot26bVD8wJwlMG17Yb5N2ZHtNYq8LYSJarp0RIJnXgvK+8H1Thz4+HgZnj5hNkToO3xaL+JhWlw0pKRt6ZCmlDoLcMyZO0uBk8zlzzTVhYMs33M963cPbHU7qAPXCqOy+07nCUh6+mEoyRft5F8XgwBUtAK40J/DHdj6YUz9Wz4c2gq6v+0/m2k9h8HLoZ8xuh3vESyeQnjFFYmYMTZEjIGOi8+xuOy1lfZYcRUZwQ9T2WRjnt7WGFujmDoKvJX3aCko4GiuA7PcJrqjQmxz2Zcy6FNVxTx1N4qWZBaRCNxkETwiUYvB01UnpcrmWX9ZIwFMzgL8jcowYrM8Ka4qTUDfOSZlHLWka29VItZXyJXdwTk/H0PZJLTZ0eB7iq64tfS71E3zlyfpY3LxaYI3BZRd6M/1xjbBkfhL17d0rfsUikQGOhep2+eHs7nMr5LzCCNLAsZcAMNiYQB8UZzr5WRmmjhskhYvRyC+nNYn/C4cs5L8dlxnNa0mbBLqLANDeN++kYoupPP5qxIX6DFJyP0wnBOn2+fff4vuhDb18FDZSTICB7w2G7Qp4eZ5peqcYhRWAvdXIoDLgcq5OqcXoznh/l/6eWns9hcYiKck5yZY80L4S5/vUzDoFBoGU+sydUGZRINFVNZlaRvMO+im9h/wEdefroywJI0ypGB1uRtHQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3ZBNjJvZzJMc1hBbUIxL2ZUNGp2ZXZHMHhmUkc3UDh3MDdtaytIWm9ZZ0JG?=
 =?utf-8?B?aTFpYnNNRG1nSDhrbDllMUxFY1VyV25HeWs5a1ZkRjZlWXdmMmZGNlB4NFJt?=
 =?utf-8?B?c3Y5Qnk1STgwb2JuRnl2UysvRnEwTWhiSWtrT05SaEFRUE01R2NlQjk4R2ZJ?=
 =?utf-8?B?clhQUjBaVy9SNVZwMUFWSTBIbUJCUHdpWXU2S0hwTXVDcTNYcldleUhycGZD?=
 =?utf-8?B?KzdXRXRXMXdBWTBYanVhUGFBSXVFcU5VVEk1SE5ucWlJdDlmTmxyOEhkYlNC?=
 =?utf-8?B?SXdaQUd5cG1TYnk0VTdLVXVId01nRTgzL1M5U1RxcnlROVFHWDR0RDdUVkU4?=
 =?utf-8?B?alpGOTF5KzJneENpbFo2SGhvWXBwN0Mxb2swYitjOXRNcW5KSlFlL1JZVlg2?=
 =?utf-8?B?RGVSeTkxMStvNnBNM09QcWkwbTI0ZHdjUHBpWEg2d1NqZHRNTEdiNnZDZWZz?=
 =?utf-8?B?VmtBdERnSkljTlMrQ0lDVFo1ekZZdk4wcXN6WUxSVk56dlkzbGxpSkhyRnFm?=
 =?utf-8?B?czVYTGFZY2lhdzE1bmlOL0ljbWJUczVmMmIwaHFFcTNzdzRUN2tEMnM2UG5t?=
 =?utf-8?B?TW1Jck0vaXJnQmNwOFZjektLblNqM0dPaVRWYkIwZTludWE0MkFmbktrSFN5?=
 =?utf-8?B?a0xSWjhBK2FnZDltZVlrQk5xT2ZQSlVZVnpDMFF1YlExZG9YV3diWG4zZWhF?=
 =?utf-8?B?eEZUT0RRUGZ1QzdpcFAvSFdzOVlvRW4vM0tkV3VzMjZMd0lJR003Sno5dEpz?=
 =?utf-8?B?bFVLUkFSUHV2VVY3Zm1sUkNJaXVvM29zWStQeFZ5TE4wS21JcW1QSGpmWk1R?=
 =?utf-8?B?NUwwRXpvR21INTJsbkRZcnh3dGo1VGR2MXpDa3RPQzNnVk5Ec3piZWt2S2NQ?=
 =?utf-8?B?SmxSd0FCMnpZampqaWx1c2k1d2lWa21JMEVMTjVlOVkrNlpZdFlNSGF2eUxq?=
 =?utf-8?B?SzhMODZWVFdsOFZjS3ZpeGcxYmtVejdQTXVjZkRSSnIvOTNQMDNTSzd4Ris2?=
 =?utf-8?B?bVZGTjhkM0ZTVzYxY0F5NzUxMEd2WmlUb25nNWx2ZkNFN2VpUmpVUG5SWkxt?=
 =?utf-8?B?WnpnZ0w0bDNSaklMY2RRTEY0NlZkMG9UYlluUFFqcVd3NW1vUU9IQlczSFMw?=
 =?utf-8?B?TUNtaXQvWit4VnIwbGhRYm5vRVc2YWtubDdKMW83cXYxYTRoY2wya2h5ZFZ6?=
 =?utf-8?B?aHJ4elgzV0tlWFFvWC9MRFBLcnNEV21QMjFYNHdLVTJvQkFjUjNPZUNwSVVB?=
 =?utf-8?B?eW5VaUNCODFqVFFUZ1RFdG9oVHUzR0hQLzVKVitia052blYwTVFvVDZSS2Zw?=
 =?utf-8?B?SzhVYWpSd1RnRlRPUitiVGVxbzVpK1UwMlg1ckVsMDlQZHdtd09kQmtqRXZ0?=
 =?utf-8?B?SVkyVW92QmhxTDdGM3g1bHZvUUhzdjZxN0tyRzlSTVNsVG8ra3lPYkxVN1By?=
 =?utf-8?B?amdkTXhCM2U5S2xhZnJzbXZaVVRacjF3R1ExZkRaaE9PTWI1YmdKbjc3eExr?=
 =?utf-8?B?SC9hRmFhV2phcVZVN1orWVlpZ3VESExDUzlhWHpzcEVud2s1Wjk4T3YxZFVT?=
 =?utf-8?B?Y1pROEF3SkF2TWR1aTJadTBTb25EMGx4L1JUbkFqZUpIK2Qvd0FmNjNjNS9B?=
 =?utf-8?B?dm1xSzVvR3Mva2RZclVWLzNaUENKLzhsVHorWXl3T1luODZUMzZOZnFtMGk1?=
 =?utf-8?Q?c9QRT253DvC0D3BkJxk/?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2016eca2-b822-4f65-5d9d-08dcb1b2fbd7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 22:49:07.0218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR20MB5714

On Wed, Jul 31, 2024 at 08:02:36AM GMT, Guenter Roeck wrote:
> On Wed, Jul 31, 2024 at 03:17:57PM +0800, Inochi Amaoto wrote:
> > On Wed, Jul 31, 2024 at 02:13:20PM GMT, Chen Wang wrote:
> > > 
> > > On 2024/7/30 15:50, Inochi Amaoto wrote:
> > > [......]
> > > > +#define REG_CRITICAL_ACTIONS			0x65
> > > The name "REG_CRITICAL_ACTIONS" is ambiguous. I have confirmed with sophgo
> > > engineers that the complete process is: when the measured temperature
> > > exceeds the temperature set by REG_CRITICAL_TEMP, the processor is powered
> > > off and shut down, and then after the temperature returns to the temperature
> > > set by REG_REPOWER_TEMP, it is decided whether to power on again or remain
> > > in the shutdown state based on the action set by REG_CRITICAL_ACTIONS,
> > > whether it is reboot or poweroff.
> > > 
> > > So based on the above description, I think it would be better to
> > > call "REG_CRITICAL_ACTIONS" as "REG_REPOWER_ACTIONS". "REG_CRITICAL_ACTIONS"
> > > gives people the first impression that it is used to set actions related to
> > > REG_CRITICAL_TEMP.
> > > 
> > > It is also recommended to add the above description of temperature control
> > > and action settings in the code. Currently, sophgo does not have a clear
> > > document description for this part, and adding it will help us understand
> > > its functions.
> > > 
> > > Adding sophgo engineers Chunzhi and Haijiao, FYI.
> > > 
> > > > +#define REG_CRITICAL_TEMP			0x66
> > > > +#define REG_REPOWER_TEMP			0x67
> > > > +
> > > > +#define CRITICAL_ACTION_REBOOT			1
> > > > +#define CRITICAL_ACTION_POWEROFF		2
> > > 
> > > As I said upon, actions are not related to critical, but is for restoring
> > > from critical, suggest to give a better name.
> > > 
> > > [......]
> > > 
> > > > +static ssize_t critical_action_show(struct device *dev,
> > > [......]
> > > > +static ssize_t critical_action_store(struct device *dev,
> > > 
> > > [......]
> > > 
> > > The same reason as upon, "critical_action_xxx" is misleading.
> > > 
> > > [......]
> > > 
> > 
> > Thanks for explanation, I just get the name from the driver of SG2042.
> > This is out of my knowledge.
> > 
> > > > +static int sg2042_mcu_read_temp(struct device *dev,
> > > > +				u32 attr, int channel,
> > > > +				long *val)
> > > > +{
> > > > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > > > +	int tmp;
> > > > +	u8 reg;
> > > > +
> > > > +	switch (attr) {
> > > > +	case hwmon_temp_input:
> > > > +		reg = channel ? REG_BOARD_TEMP : REG_SOC_TEMP;
> > > > +		break;
> > > > +	case hwmon_temp_crit:
> > > > +		reg = REG_CRITICAL_TEMP;
> > > > +		break;
> > > > +	case hwmon_temp_crit_hyst:
> > > > +		reg = REG_REPOWER_TEMP;
> > > > +		break;
> > > > +	default:
> > > > +		return -EOPNOTSUPP;
> > > > +	}
> > > > +
> > > > +	tmp = i2c_smbus_read_byte_data(mcu->client, reg);
> > > > +	if (tmp < 0)
> > > > +		return tmp;
> > > > +	*val = tmp * 1000;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int sg2042_mcu_read(struct device *dev,
> > > > +			   enum hwmon_sensor_types type,
> > > > +			   u32 attr, int channel, long *val)
> > > > +{
> > > > +	return sg2042_mcu_read_temp(dev, attr, channel, val);
> > > > +}
> > > Can we merge sg2042_mcu_read and sg2042_mcu_read_temp？
> > 
> > Yes, it can be merged. but I think using this nested function 
> > is more clear. And gcc can auto inline this function so we
> > got no performance penalty.
> > 
> 
> FWIW, I think that is pointless. Te only difference is unused
> parameters.
> 

OK, I will merge these function.

> > > > +
> > > > +static int sg2042_mcu_write(struct device *dev,
> > > > +			    enum hwmon_sensor_types type,
> > > > +			    u32 attr, int channel, long val)
> > > > +{
> > > > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > > > +	int temp = val / 1000;
> > > > +	int hyst_temp, crit_temp;
> > > > +	int ret;
> > > > +	u8 reg;
> > > > +
> > > > +	if (temp > MCU_POWER_MAX)
> > > > +		temp = MCU_POWER_MAX;
> 
> No lower limit ? -1000000 is ok ?
> 

My fault, it should always > 0.

> > > > +
> > > > +	mutex_lock(&mcu->mutex);
> > > > +
> > > > +	switch (attr) {
> > > > +	case hwmon_temp_crit:
> > > > +		hyst_temp = i2c_smbus_read_byte_data(mcu->client,
> > > > +						     REG_REPOWER_TEMP);
> > > > +		if (hyst_temp < 0) {
> > > > +			ret = -ENODEV;
> > > > +			goto failed;
> 
> Do not overwrite error codes.
> 
> > > > +		}
> > > > +
> > > > +		crit_temp = temp;
> > > > +		reg = REG_CRITICAL_TEMP;
> > > > +		break;
> > > > +	case hwmon_temp_crit_hyst:
> > > > +		crit_temp = i2c_smbus_read_byte_data(mcu->client,
> > > > +						     REG_CRITICAL_TEMP);
> > > > +		if (crit_temp < 0) {
> > > > +			ret = -ENODEV;
> > > > +			goto failed;
> 
> Do not overwrite error codes.
> 
> > > > +		}
> > > > +
> > > > +		hyst_temp = temp;
> > > > +		reg = REG_REPOWER_TEMP;
> > > > +		break;
> > > > +	default:
> > > > +		mutex_unlock(&mcu->mutex);
> > > > +		return -EOPNOTSUPP;
> 
> This is inconsistent.
> 

Thanks, I will handle the return properly.

> > > > +	}
> > > > +
> > > It is recommended to add some comments to explain why we need to ensure that
> > > crit_temp is greater than or equal to hyst_temp. This is entirely because
> > > the current MCU does not limit the input, which may cause user to set
> > > incorrect crit_temp and hyst_temp.
> > 
> > Yeah, this is good idea.
> > 
> > > > +	if (crit_temp < hyst_temp) {
> > > > +		ret = -EINVAL;
> > > > +		goto failed;
> > > > +	}
> > > > +
> > > > +	ret = i2c_smbus_write_byte_data(mcu->client, reg, temp);
> > > > +
> > > > +failed:
> > > > +	mutex_unlock(&mcu->mutex);
> > > > +	return ret;
> > > > +}
> > > > +
> > > [......]

