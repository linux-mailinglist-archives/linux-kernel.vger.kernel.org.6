Return-Path: <linux-kernel+bounces-268565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA828942648
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106521C23F66
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 06:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4318D1684AB;
	Wed, 31 Jul 2024 06:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lzgPcmg4"
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2045.outbound.protection.outlook.com [40.92.102.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B431662E4;
	Wed, 31 Jul 2024 06:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722406422; cv=fail; b=Y3UbTTh1i0oOsGKJpAtHBD5VgVNHVef1XNPxPZod27wKg2BMnLMlsJ1MAfRn0EcQaBNzUgLLmt0FMNBOS3JZEAP+U/HFWeU8dr7kU0gDxV5OX8yI4pjovZZyt6uvptkmwU7PZoddUXr5vhUK0ZU7dxuPlGIBiXZ7Oxtinfa6LFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722406422; c=relaxed/simple;
	bh=YsKpYxndXdLbmEstd0SRT+Lpz8fRUFGZOR+qhe6nzMs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HionQWa7vEX0o5UAu2MguWFov/p9jWOBjtZx/VK7Ny/ibkvsXrE6f0faq4R+3elrBZRm8eLjjc9ysDI+ZjXcNSFMviwfvnJvaBW2B1kcekUls4YtoWB/lWuTpLrsOh7w4VEqFOPnqcPd+6Kwu7uZfiPmtFapR0k+Y+kbdivvvo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lzgPcmg4; arc=fail smtp.client-ip=40.92.102.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P4Ve/n60bnVcoKwAroeJNeyjry/YvU2ALvAiWsdOvrHqU6BViZU48YGYzHe8TigHRTI+oQ1247nMB5cD3x+J/dg5Ay03swSN9jE7dsUprNK6bam6oHf3Lwccf+CPhqcR2Yot/MWFUjFCm6IBEM4ZzvKlxoHmTvoWcAA05CAlmVhysjCv4xaW8xpXcueYpJrC43nO/e3dXNzXwEeFEXe4lxVfuwC3wqXN3k7BoPJv42/OHwqRllDhYbxMIqg4Thw/xrI9L4cGclrQ7Pi3V/7AcPQv2QFTNSbxx2/iyO3By9eJXYeVVy7OCVAxlmlsqWfelRvi+/A4h7jy7xKsRBotjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kygkSvs6m/sZslXaJuT5HOBMHHCKaOo1XT4KYtC2+4Q=;
 b=kxiWEfEarORnA7x0bohI8xUm6Ht5gPsc0U5j5dD18DV6UFuqStqxY/w6f0nkqKPd0cxRN6c9BZIWzaFpfOcw6h/Pjmttm8RI2ouhCahaFKR7QX1hIncYOCAJ+88jcCuZmxADibbaGIcPsmeR1WfEHXRV1kb2ZuiNTPCd+1VO3/fvi9xwXz6Pa6uxHLV5AIVr7I9z1p73q/y1jaYkJMbW3STRte7k8MRPZMIjnl9qskwksQOHv1yUBmDBm54fy4KHy5Bpw1L/7t09+NeSbPBynZJvOtxpYNSWE5qHYhfcf84saD7eGCqytpkbmKQ42fRr6kdLtAyD4/JyHMWU2jcE5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kygkSvs6m/sZslXaJuT5HOBMHHCKaOo1XT4KYtC2+4Q=;
 b=lzgPcmg4mQQQQsXVPSVeHwIAqPMnY3nOTbNcILwGbkjHW8KKewLSiDMwe6XJge/hVHvxr+dcmNsZAVtZnOaYY2UTJd95qykWk+NexrdgxzKO0iX/CIwW3+U9VGLC8GVG7yS0/8CtOOs77oPYj08lVnaQfpHD2DvxYMbiipH3ESYozaLJCvvMsKJtKTS++sy8aEX6xOO1U/5+rQaQ0bOEg9S0sdT35B0ubRyX2/8EMQDwqX8tbpFcEC92+xgwU6eKWweBZaDFt5EwSaPVGpvPy4HhdGKSdxScwsUC+sSHzJ7zdAAipdFxz9AH/uCWG6Nr8AUwAxpZGze4i/gMD0Z0sw==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by MA0P287MB1790.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:f5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 06:13:29 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%6]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 06:13:29 +0000
Message-ID:
 <MA0P287MB2822D0C770667CFE484EBC95FEB12@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Wed, 31 Jul 2024 14:13:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/4] drivers: hwmon: sophgo: Add SG2042 external
 hardware monitor support
To: Inochi Amaoto <inochiama@outlook.com>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@kernel.org>, Chao Wei <chao.wei@sophgo.com>,
 Hal Feng <hal.feng@starfivetech.com>, Jinyu Tang <tangjinyu@tinylab.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 chunzhi.lin@sophgo.com, haijiao.liu@sophgo.com
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <IA1PR20MB49538C09E94D90F07B7B2562BBB02@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953DE89C56AB3F328954131BBB02@IA1PR20MB4953.namprd20.prod.outlook.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <IA1PR20MB4953DE89C56AB3F328954131BBB02@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [eXLlfhgaDTS9O329B2nx2E9V9PleYzF/]
X-ClientProxiedBy: SG2PR06CA0240.apcprd06.prod.outlook.com
 (2603:1096:4:ac::24) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <0de3f417-8127-489b-b31f-2d7cd450387f@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|MA0P287MB1790:EE_
X-MS-Office365-Filtering-Correlation-Id: a8326ab5-fb41-4106-3d86-08dcb127e4cf
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|8060799006|5072599009|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	/H4AG1Y91CJcaAAf6+RWRcDt9i0b3/4VhTYAqfq30UeXfbsOFNjNwpOzf1tDWI8szslmTcQaoOScZxMYEAoQbbqxf/Pw5xuRdXBffgvLKQK/6uJi/+8i7PutAUvoLOdtY4Ge5fA13UPCfBJ5Ulqfpw5NXU37RhzOB08LtJBToSwu7smnjvBH4fCmYah85ZL6O9su44EAQ6TIW43leNYCQ37Iorvp+3SrJmPIt2j3hCA3WZHbFRTu/xgmCt6P90268+AH+yK9hZyjeVcNQ9IO6u/lcUMiBlcJjeIJ5AMZHa7o3vYtcms9ad0ToiNqPv1bJtvL+D7oqNzXaPbByQAf0wNmlTbm/0Ij598LM+tA1ECxyEN/9qjUHbdwFsN1u4K258aQPUWeOHpze5hF935ipU286LTRCDpqxJ5L328lFw9Q9ae+uSrdfWkO3swjqkiM9/sMn6jJf+4WzVTaLL97XQMcCCF945B1dYqmsDW65bRS/5XafeeYkGUaOJUEoh6Q8/mAx1c/rjOv/ZQPZ/lhJeLzE4nwLJA8jLSLqt9+Fd2W+XJEZSKiHOYX2xA1cX6JQLWCqmxrrW1I5e0WzrFoyKi0c1LhpHUtC0o+Raao/9KV2Ju8OqySKqKOt2+rJBcWc7LemI9c5nC5iaYpLpF3CzLryJXsqhpeald+EiTxK6vMh9n0IuQZP0TLWt5yyi64
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHlmMUFXeFN5V2RyTnM4SzhDS0ZLQTZqQzMzSzdBeXZEdUdqdGtGNDBKVlpP?=
 =?utf-8?B?eGNNUzZwV25xeWRiREt2WUNtVzFNS2xLaEh2dFRNWFFqN2hqT0xoMXNQNHQx?=
 =?utf-8?B?K2dSSjlPMjJ5UXJOZTZOWVBEeWw1VzY3TU1rUUNEK0kwYUgyM0pvYlR0YnA2?=
 =?utf-8?B?OGFGZTF3NSs5TzhnVXd3eXVBMzJWdTA0bVpCR1FINGZncVdlbDV5QlNBYWNr?=
 =?utf-8?B?aGpjZ3hrSlVxVlRndzBiQWZZVGdhaFB2MEYwRUVNTENJMnlpWFJBYklJaUVI?=
 =?utf-8?B?ZFJ3UHAvSU5vdEVmZnZVYnNBSjlsSEpSVk1qT1gzRWNYOUk0VVA3RWdsRGJ6?=
 =?utf-8?B?TVI5TVh2STJXYldOSW5CNm50cmRkQmxEakZFVnR0OXZXMk9PLzJtZkh0SUNo?=
 =?utf-8?B?ZjJvdWp3QS9UOUhoUzBHdHh6QWc4YkZEd0kzVDJBb08yUXdRR2JVSjcrd29j?=
 =?utf-8?B?VmlDWXlDYzhJc05hN051TUowTG9hM1NaRGpmenNMaHBLL1hPSzd1SmRVVkpz?=
 =?utf-8?B?V2VVMmlkTGx6c25xNnFOMjFTeGwwUTRNM1Y2djlKTGhvUHptWEkvdzV5bmdR?=
 =?utf-8?B?VjI1UHFqMlNyUjMrZDZuK1Z1TkFXcERKMldwMVJJNmdWc1M3cVpMRDVtdnh4?=
 =?utf-8?B?d3pIdHF1NWhIbERzZnRGOWF2QUFVL2I0ZHFkVFNpeWFQVElsTDVjSHhJa0JM?=
 =?utf-8?B?KzFtYjg1QTFsb3B6eGdzeURoRmFWWDFTZ3JoM0tiTUxZRHNVY3Z1Z0NpYUhP?=
 =?utf-8?B?SWpWTXFQREJpQk9ZYSs1N1NKYzV6WVRZekxNa3kzUCtjNEtFZXdrTFhobzVu?=
 =?utf-8?B?clJ5cm1QNWRXNmZyVnRXemROMU56ek4wdGRsTzQ1L3VpQktsRTJLVWV0a1FZ?=
 =?utf-8?B?OUxuZVdiRFdtMnZwU2FqYXZmbXEzemZQKzh1N2l4RkNNazlDRzFycTZHQkt3?=
 =?utf-8?B?ZkdJb01IZ0s3V0xvc1NKTldtQ245WnFrVUxyaURhdU9XLzJteHl2SHJLWXlQ?=
 =?utf-8?B?VDJBaDJpWmhVSy9RRWZYaXdqYVZUSEZ3NWgrL1VVUEQyQ3JMM2ZyQzdGNlpw?=
 =?utf-8?B?bm82M2c5VXlhek9OQ2oyVXpiU1JNYXBuR3dCempBMHNoZ1NuNzMyZFRUdUMw?=
 =?utf-8?B?U2k4dDdJc3ZFcDlTME5QTDhtLzdSbExZWHBpUU5ycGhKaUUycUltZE54SFRp?=
 =?utf-8?B?MEl2Qm0rd3Z5NlVsN1dWQ1RYcVNBaFdEaHlYek4xL2tGSnViQlFxLzdwUmlQ?=
 =?utf-8?B?ZGRNM2tyZkN5U01WWkU2OUpHYUY2Y1NtZTRpSkNGaUcrNjZFc0VTMWsxYng4?=
 =?utf-8?B?TTlGMlI1L2VYb2RqdzlwR3FjeE5VNmg3Zmpqc1Qrazl1TWM1NmZRNi9zSjVn?=
 =?utf-8?B?R2c2WmdmVzQrMDhjenk5VzhKcXc3T25kSlN3THc4enYvTC84UFdKYVhoTzNU?=
 =?utf-8?B?K2pIVTBzd2tEeHllWHJOd0NYUDhxbzVFd3ZiTk9pRUplQ2RmU0R2bkF6WDBo?=
 =?utf-8?B?ZlRzUXhSdSsvL3pKWkI0dmowT3B2Q0x1dnByaFBLOHpRYkFjenVqNktzYnhY?=
 =?utf-8?B?aVZlMDFNR2NvbWlXeXBkM2JoVjlKYmNGSUJyREpXNS95MnVLYURqNktPeHE2?=
 =?utf-8?B?YzFEbVZvbzRwa3pveFRhNFlVSFlkbndvdmpaYWFnVlpzQ0Q2UFplZktlSDBR?=
 =?utf-8?Q?rW2P0dUuXrI66mVxeJGa?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8326ab5-fb41-4106-3d86-08dcb127e4cf
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 06:13:29.4340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1790


On 2024/7/30 15:50, Inochi Amaoto wrote:
[......]
> +#define REG_CRITICAL_ACTIONS			0x65
The name "REG_CRITICAL_ACTIONS" is ambiguous. I have confirmed with 
sophgo engineers that the complete process is: when the measured 
temperature exceeds the temperature set by REG_CRITICAL_TEMP, the 
processor is powered off and shut down, and then after the temperature 
returns to the temperature set by REG_REPOWER_TEMP, it is decided 
whether to power on again or remain in the shutdown state based on the 
action set by REG_CRITICAL_ACTIONS, whether it is reboot or poweroff.

So based on the above description, I think it would be better to 
call "REG_CRITICAL_ACTIONS" as "REG_REPOWER_ACTIONS". 
"REG_CRITICAL_ACTIONS" gives people the first impression that it is used 
to set actions related to REG_CRITICAL_TEMP.

It is also recommended to add the above description of temperature 
control and action settings in the code. Currently, sophgo does not have 
a clear document description for this part, and adding it will help us 
understand its functions.

Adding sophgo engineers Chunzhi and Haijiao, FYI.

> +#define REG_CRITICAL_TEMP			0x66
> +#define REG_REPOWER_TEMP			0x67
> +
> +#define CRITICAL_ACTION_REBOOT			1
> +#define CRITICAL_ACTION_POWEROFF		2

As I said upon, actions are not related to critical, but is for 
restoring from critical, suggest to give a better name.

[......]

> +static ssize_t critical_action_show(struct device *dev,
[......]
> +static ssize_t critical_action_store(struct device *dev,

[......]

The same reason as upon, "critical_action_xxx" is misleading.

[......]

> +static int sg2042_mcu_read_temp(struct device *dev,
> +				u32 attr, int channel,
> +				long *val)
> +{
> +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> +	int tmp;
> +	u8 reg;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		reg = channel ? REG_BOARD_TEMP : REG_SOC_TEMP;
> +		break;
> +	case hwmon_temp_crit:
> +		reg = REG_CRITICAL_TEMP;
> +		break;
> +	case hwmon_temp_crit_hyst:
> +		reg = REG_REPOWER_TEMP;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	tmp = i2c_smbus_read_byte_data(mcu->client, reg);
> +	if (tmp < 0)
> +		return tmp;
> +	*val = tmp * 1000;
> +
> +	return 0;
> +}
> +
> +static int sg2042_mcu_read(struct device *dev,
> +			   enum hwmon_sensor_types type,
> +			   u32 attr, int channel, long *val)
> +{
> +	return sg2042_mcu_read_temp(dev, attr, channel, val);
> +}
Can we merge sg2042_mcu_read and sg2042_mcu_read_temp？
> +
> +static int sg2042_mcu_write(struct device *dev,
> +			    enum hwmon_sensor_types type,
> +			    u32 attr, int channel, long val)
> +{
> +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> +	int temp = val / 1000;
> +	int hyst_temp, crit_temp;
> +	int ret;
> +	u8 reg;
> +
> +	if (temp > MCU_POWER_MAX)
> +		temp = MCU_POWER_MAX;
> +
> +	mutex_lock(&mcu->mutex);
> +
> +	switch (attr) {
> +	case hwmon_temp_crit:
> +		hyst_temp = i2c_smbus_read_byte_data(mcu->client,
> +						     REG_REPOWER_TEMP);
> +		if (hyst_temp < 0) {
> +			ret = -ENODEV;
> +			goto failed;
> +		}
> +
> +		crit_temp = temp;
> +		reg = REG_CRITICAL_TEMP;
> +		break;
> +	case hwmon_temp_crit_hyst:
> +		crit_temp = i2c_smbus_read_byte_data(mcu->client,
> +						     REG_CRITICAL_TEMP);
> +		if (crit_temp < 0) {
> +			ret = -ENODEV;
> +			goto failed;
> +		}
> +
> +		hyst_temp = temp;
> +		reg = REG_REPOWER_TEMP;
> +		break;
> +	default:
> +		mutex_unlock(&mcu->mutex);
> +		return -EOPNOTSUPP;
> +	}
> +
It is recommended to add some comments to explain why we need to ensure 
that crit_temp is greater than or equal to hyst_temp. This is entirely 
because the current MCU does not limit the input, which may cause user 
to set incorrect crit_temp and hyst_temp.
> +	if (crit_temp < hyst_temp) {
> +		ret = -EINVAL;
> +		goto failed;
> +	}
> +
> +	ret = i2c_smbus_write_byte_data(mcu->client, reg, temp);
> +
> +failed:
> +	mutex_unlock(&mcu->mutex);
> +	return ret;
> +}
> +
[......]

