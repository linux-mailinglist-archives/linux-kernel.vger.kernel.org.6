Return-Path: <linux-kernel+bounces-268673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 555089427AC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C21321F225DD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E4916CD01;
	Wed, 31 Jul 2024 07:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="sNjb7HhW"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2076.outbound.protection.outlook.com [40.92.45.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9A016CD39;
	Wed, 31 Jul 2024 07:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.45.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722410313; cv=fail; b=J4xbuUfA24D5W6PadGJi0NOxt91Js+ZRF6r/jtpikFUQprJaAhbDdwniL4Q2OEpsMPFR3ReHux//EX8aXsyO4ztuF0JfbETkaTmI5/CX+foArR8+SqNVMrDaSxwGb5+/jxfNJPty35QABJcdQLjmaAKifXOBXBCZannVT/HKhvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722410313; c=relaxed/simple;
	bh=00SoMhYrfJwTjMbBcIzcyQUPlZvJlS5eH8pgMLHELRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eqpN1WQIh6JBL2DAOMtwwEkQBa2DBQPsli2jA9B4NifkxN39uodVUvSnEWYTR66GH4b7PLKusR5TUS6kQS+GCVdv0IUz7rc0o5XI681QdGK0lmDiEQ7IJOH8uJyYV5tPiMV+cCiCDfMU/FykD6syWoJihgDWHCRKvyb+xyjrXWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=sNjb7HhW; arc=fail smtp.client-ip=40.92.45.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a6J8Ta/yPZp0eVNtaO4+fkMzt8dPX/xP0PvicJ1P1cwdG2m8G74qyT3Sv/QfV6pyCP4Y4zUYrtsL/wCRDi4vgnVok/nl7BwZRIPS6UKI4WTKwu4vUW9IxrPtaqCyoE8El8HEOAxzAYSrhQTkoQYSyf4hwBfJgtkRB/5EgDx6epUJXNY78aH9Ywu+IP4YAnJEWy8Yr+aCvqjpYfRPLVGgXwuwzm0gqNcpUsn+GEf8U4/FxXdgU/CYrhtitlqPC7uQrQqF5vi8NDEtz1J7mDzK7lX9o7NZ+CAfX5VUdawx4MtEY+3gyB/eeL/5SPgQfgfmwP0OZYI5OY4oOuBxWfsixg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2OmqVlDaby94VWqTksiZmiMINjaMZzoQN6CNQMVC5c=;
 b=Yz0KdwyAvITtuZkT4YP3QHcRmLDjhdLrGAlRKXbotVvaCJb7A2hVRxWZ0YtE8857H42IovGnKc6D61kto/eOXLb13MU/RimyHSwVEpZ6b27eIqfgikS9+UFBN/s/h5k7AxnwAR3OFMGx8WymrrTtfdhu7KtwUSpQWFGtf7RAMcsXb4LomyKRlfyfeR3ywEgcVLzMZmApHfP89jmJPvUxtLonRkXcTBp7Y4B32xcUbasKP9qE9T5L2oSJYevrqS6SWbuiqcyY+l5fRgpobpXGjlbr1J8ZhMM9vdcwYXhngAInBXTf5CmnbV/9/IHjU+V0fUeFt+c9l5BHqZOoDuz/7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2OmqVlDaby94VWqTksiZmiMINjaMZzoQN6CNQMVC5c=;
 b=sNjb7HhWuDxCnYEhY1X5rbeCFSKVDGbVb9YlSXeZL2n6Nr9CkUSkim43Dn8MoUYLbXmqLnFja1Uy2pYnH6kgBBVgCGL2S1UVmB6qF1peesFb8p6Cw5KaZyEMDoxNPe9AunhVcdtopcOEsuRlAh3mdzqPFl0OEMZUYn0FUBzYzlmp3BjdhZG1et4U5W3WbXTlmmNlb/1JPV26uqb8+RVp2Iues3F2OT7zcnWjhvz/srtL93TdY1BBtWF1Ctb0j6n/9qMomIGfd9R0szJQz4GAG8dFXmCM1trurvea7282W/ofw34JyoQ8x0Il9eHTE1hrovmrJInrJqcBmeEG/NKSXw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CYYPR20MB6739.namprd20.prod.outlook.com (2603:10b6:930:ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.32; Wed, 31 Jul
 2024 07:18:28 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 07:18:28 +0000
Date: Wed, 31 Jul 2024 15:17:57 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Jean Delvare <jdelvare@suse.com>, 
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, 
	Chao Wei <chao.wei@sophgo.com>, Hal Feng <hal.feng@starfivetech.com>, 
	Jinyu Tang <tangjinyu@tinylab.org>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	chunzhi.lin@sophgo.com, haijiao.liu@sophgo.com
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v8 2/4] drivers: hwmon: sophgo: Add SG2042 external
 hardware monitor support
Message-ID:
 <IA1PR20MB49534944E268A0A71AA3D5D1BBB12@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49538C09E94D90F07B7B2562BBB02@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953DE89C56AB3F328954131BBB02@IA1PR20MB4953.namprd20.prod.outlook.com>
 <MA0P287MB2822D0C770667CFE484EBC95FEB12@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MA0P287MB2822D0C770667CFE484EBC95FEB12@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
X-TMN: [LBHahn1gvbhgKhADi91zwParm2/qzUnQa46O8kNVyqE=]
X-ClientProxiedBy: OS0P286CA0071.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:9f::22) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <uzxowagd4cg64kfs4xobj67yznxbsh4a4lgmuzabgst4tis5zq@pum5wyl3povv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CYYPR20MB6739:EE_
X-MS-Office365-Filtering-Correlation-Id: 72042ef9-a21d-4cae-8355-08dcb130f921
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|5072599009|19110799003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	5/T+x1v9MbJYQDmPPZIchG9jTOgqo9Xm01VY0R5s4VEEcT2Uza3odnEp08VlXk5nh4Lu9MQ8JtIMJbJhKME7ff/vOnj2jydPkck7eeX/PKcu7GwXMiTe3P/ZRzFwV/LwUq0S5A9VjOWXFczST8iJnhZYDEV0rjSvHpM7LBtgXvBEVwBJxpucgdnEpuvQqDG0t4zmm9g0rv1QENuu9yx+c0RcDhCQyKhGFIVkQLkCOFumEIlJcpiHnxJylYprwPlNsDBeJIuZctPLM7M/SiT/2nEwtdCWoVnwJ5ojUq7XydxBSioe3EZuxRKGvGfQiFTGX18PpM3dFDnz8s3/ivQJRvLVXBbCAqDDmAducD1b6y+0FT43y+I0MABq0GiUWw5zyfI9GdzHaTy8JsKHIjyPDLYaALGz5IyIEx4uZIBUM1B5ThpRx75PfJzMdR4yWknLn/5mbkQuA51X/AfLm6JV1M6Tell5AG4y+tHEPWrtssNTS4QaqbNBCoOh0WcQQsnc+bIkeG86FHsdsiitP1r4oAqjZJiaKB+SCm2irdJpxGTPmXQBQs3NT5JH5bp7NgV85NuhrHguLSTJ4ygPxD6Gh7SVmvpcqByrttLf/pLEYoKGFe9No/sEToz2TpVbFsiSBRxZ0iV2fihc+Wsi+EHPsu2xPTkeaQy7w8QFzK4aZRUcD2jPHG8xcHgWU6LwUjZFvX2kR3PdkfmAIbEPVqli6Q==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWF3NGdyTHcvaFZGU3QvWWRpZmVSOWFXSXNacUlpTUM3ZEk3YjZqY0tYKy9x?=
 =?utf-8?B?bm1zbFdOUk5OTS95R3BabjY0YXZ2SHFEU2VRa2d2a1VPaWlxYW5XMysxcHZC?=
 =?utf-8?B?bUt4MjRWd1ZVZC9DSFBHUzhUUTZRU3A4OFExUVNHSE9HWElUaHdET01sSW5F?=
 =?utf-8?B?OElFajFSRXN2SFd0OEEvNWwrcDEvZFBuQThRdWx2Q3FJRDJDM1ZEam1qeTV6?=
 =?utf-8?B?QXdqazdhSWdHWVJFR2xFTVRYdGlBU3JsUHhDM0NYd2c0Ui9VdTF3TWdWUWx6?=
 =?utf-8?B?eDNGTDBBdHlpVXBMeVg0WlJ6dXBOeHdTRW1rWTdSTWRBY2hxNXJmWDBYNFhX?=
 =?utf-8?B?ZjFwZjFzNi83Zk5VNDNHSHk0dERQckZJWmRJVCs0M1ZrcVBtQmZoWGF6UEdE?=
 =?utf-8?B?djJKSTZjd1BCMHR5YnVJRExBQ1BBNkcrZHNzL292RmN5T0ppMi9EN2ZSeVNV?=
 =?utf-8?B?YnMybDQraXdPR1VGRDV5cHhQL2p4Nk5KYStBVTBCWHpvNUZ5eE1iQmt1cWxE?=
 =?utf-8?B?cUp1V09CZ0E0dmtjVzVOdWhIRkpvVVREakNvQXRmSllwOExtRlJnMDJ3aWNI?=
 =?utf-8?B?Ym5pY1k2b1R1T296MDVESHJrZS9uNW9EMWFZK1pXWS8vZjI4dWlFdFRqRFo0?=
 =?utf-8?B?WUdhczErZVAyWDNWUVJZcDloTEZ2RjE4c3NGZDlhUHVOUzJ6RGdKOGZwZkpX?=
 =?utf-8?B?aittZVMzVms5WTN3UzVrOXZOK3BsQkN1Q0tQQU5YZ2FBSE9iK21ia1Vqd3Zq?=
 =?utf-8?B?bW9zNW85bk14R2N5QlRYUU9EakFWK0o4TW5uYVFHWlR6bGVNOTQ4RkFNUUho?=
 =?utf-8?B?amRVVjF4WWwzcU96dCtCbmIwQkNkb3QrS3J5TDB1SEY1UVM0VG5KRHRUWnBo?=
 =?utf-8?B?TzRvNkh6TE1Ta1lJanBncHBDbHJJTm5PdlBua01iOCt1bFM2OUFkYy9WUzZs?=
 =?utf-8?B?V1hNdjZtTTREa0xJMlowNUdWZ3BibExxSkoyZlNTWkhKYUpWRU5MSVY1ZXdV?=
 =?utf-8?B?dmdQd0RhSVl4d0h4Z2tJL3UzKzdlNjNPS3JpWHhVMkkzRSsyYUtwdENxR2Qx?=
 =?utf-8?B?M3UwVjkvOTVkQ0pZSmFLd296d0RURjdJNDhoUU9wQURIV1U3djUrOXZISzlv?=
 =?utf-8?B?UktRUUtBSW5zdFpma2pmQzZjbDlueFlBTlN5N28xOTFVZzVNR0M2aE5zU1Nh?=
 =?utf-8?B?M1BHN3JGb3RaOTRheXRPNU9YV2dIZlRkUjNReG5DK2VQUGdVWFhwcW96VjFU?=
 =?utf-8?B?Nmh1QXlTZy9iSzlrdWFsaUhXUHB0b3A3NllWeUh3TGdib2pvYit3UFdtd0hj?=
 =?utf-8?B?RklwM1pycENuRmRZYUtNZHVZTk12Tnp2RkxDWmxtWEw4SjJKVnhBdHpMMjM0?=
 =?utf-8?B?eGxJdkNTUGFuaGlkUElYT2QxS21WaHhoakZKYUNON0N1UjNxOEdOZjJ4UENR?=
 =?utf-8?B?NmxUNnRteWhuNnhJUVJsa0wrUFQ2bzl4NzJGWS9QMFErMWVRZFdoL1loRGNx?=
 =?utf-8?B?TExweDJLdTFwWGxNN214dGNhWDcrYWlOaGFIcFZZeVR4ZEJZRWJzUU9JazVm?=
 =?utf-8?B?NXdPTDRTWnRGbDJZL0FFQ0tobkdKMFpBK1cxSE9wQ2V1ZlgwK1NqSXV3dFVY?=
 =?utf-8?B?QVNCSHpweVYyMzFSWE4rS0UyMmkwUjczcmVlZWxDVkJrcFlkSlB2b0k4Smc0?=
 =?utf-8?Q?Plh3OVoegK2a3Mg8Y/pM?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72042ef9-a21d-4cae-8355-08dcb130f921
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 07:18:27.8250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR20MB6739

On Wed, Jul 31, 2024 at 02:13:20PM GMT, Chen Wang wrote:
> 
> On 2024/7/30 15:50, Inochi Amaoto wrote:
> [......]
> > +#define REG_CRITICAL_ACTIONS			0x65
> The name "REG_CRITICAL_ACTIONS" is ambiguous. I have confirmed with sophgo
> engineers that the complete process is: when the measured temperature
> exceeds the temperature set by REG_CRITICAL_TEMP, the processor is powered
> off and shut down, and then after the temperature returns to the temperature
> set by REG_REPOWER_TEMP, it is decided whether to power on again or remain
> in the shutdown state based on the action set by REG_CRITICAL_ACTIONS,
> whether it is reboot or poweroff.
> 
> So based on the above description, I think it would be better to
> call "REG_CRITICAL_ACTIONS" as "REG_REPOWER_ACTIONS". "REG_CRITICAL_ACTIONS"
> gives people the first impression that it is used to set actions related to
> REG_CRITICAL_TEMP.
> 
> It is also recommended to add the above description of temperature control
> and action settings in the code. Currently, sophgo does not have a clear
> document description for this part, and adding it will help us understand
> its functions.
> 
> Adding sophgo engineers Chunzhi and Haijiao, FYI.
> 
> > +#define REG_CRITICAL_TEMP			0x66
> > +#define REG_REPOWER_TEMP			0x67
> > +
> > +#define CRITICAL_ACTION_REBOOT			1
> > +#define CRITICAL_ACTION_POWEROFF		2
> 
> As I said upon, actions are not related to critical, but is for restoring
> from critical, suggest to give a better name.
> 
> [......]
> 
> > +static ssize_t critical_action_show(struct device *dev,
> [......]
> > +static ssize_t critical_action_store(struct device *dev,
> 
> [......]
> 
> The same reason as upon, "critical_action_xxx" is misleading.
> 
> [......]
> 

Thanks for explanation, I just get the name from the driver of SG2042.
This is out of my knowledge.

> > +static int sg2042_mcu_read_temp(struct device *dev,
> > +				u32 attr, int channel,
> > +				long *val)
> > +{
> > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > +	int tmp;
> > +	u8 reg;
> > +
> > +	switch (attr) {
> > +	case hwmon_temp_input:
> > +		reg = channel ? REG_BOARD_TEMP : REG_SOC_TEMP;
> > +		break;
> > +	case hwmon_temp_crit:
> > +		reg = REG_CRITICAL_TEMP;
> > +		break;
> > +	case hwmon_temp_crit_hyst:
> > +		reg = REG_REPOWER_TEMP;
> > +		break;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	tmp = i2c_smbus_read_byte_data(mcu->client, reg);
> > +	if (tmp < 0)
> > +		return tmp;
> > +	*val = tmp * 1000;
> > +
> > +	return 0;
> > +}
> > +
> > +static int sg2042_mcu_read(struct device *dev,
> > +			   enum hwmon_sensor_types type,
> > +			   u32 attr, int channel, long *val)
> > +{
> > +	return sg2042_mcu_read_temp(dev, attr, channel, val);
> > +}
> Can we merge sg2042_mcu_read and sg2042_mcu_read_temp？

Yes, it can be merged. but I think using this nested function 
is more clear. And gcc can auto inline this function so we
got no performance penalty.

> > +
> > +static int sg2042_mcu_write(struct device *dev,
> > +			    enum hwmon_sensor_types type,
> > +			    u32 attr, int channel, long val)
> > +{
> > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > +	int temp = val / 1000;
> > +	int hyst_temp, crit_temp;
> > +	int ret;
> > +	u8 reg;
> > +
> > +	if (temp > MCU_POWER_MAX)
> > +		temp = MCU_POWER_MAX;
> > +
> > +	mutex_lock(&mcu->mutex);
> > +
> > +	switch (attr) {
> > +	case hwmon_temp_crit:
> > +		hyst_temp = i2c_smbus_read_byte_data(mcu->client,
> > +						     REG_REPOWER_TEMP);
> > +		if (hyst_temp < 0) {
> > +			ret = -ENODEV;
> > +			goto failed;
> > +		}
> > +
> > +		crit_temp = temp;
> > +		reg = REG_CRITICAL_TEMP;
> > +		break;
> > +	case hwmon_temp_crit_hyst:
> > +		crit_temp = i2c_smbus_read_byte_data(mcu->client,
> > +						     REG_CRITICAL_TEMP);
> > +		if (crit_temp < 0) {
> > +			ret = -ENODEV;
> > +			goto failed;
> > +		}
> > +
> > +		hyst_temp = temp;
> > +		reg = REG_REPOWER_TEMP;
> > +		break;
> > +	default:
> > +		mutex_unlock(&mcu->mutex);
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> It is recommended to add some comments to explain why we need to ensure that
> crit_temp is greater than or equal to hyst_temp. This is entirely because
> the current MCU does not limit the input, which may cause user to set
> incorrect crit_temp and hyst_temp.

Yeah, this is good idea.

> > +	if (crit_temp < hyst_temp) {
> > +		ret = -EINVAL;
> > +		goto failed;
> > +	}
> > +
> > +	ret = i2c_smbus_write_byte_data(mcu->client, reg, temp);
> > +
> > +failed:
> > +	mutex_unlock(&mcu->mutex);
> > +	return ret;
> > +}
> > +
> [......]

