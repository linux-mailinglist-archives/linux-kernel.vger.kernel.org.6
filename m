Return-Path: <linux-kernel+bounces-203632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F3C8FDE6A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 07:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 453981F2595C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 05:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C803F9FC;
	Thu,  6 Jun 2024 05:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rlo0tyJZ"
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2034.outbound.protection.outlook.com [40.92.102.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44D93A1A8;
	Thu,  6 Jun 2024 05:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717653448; cv=fail; b=eW94EC3m2U1/klOOc5PlMDrcIHu7qKYeWIAFXfvi69De9F54hrqgCYA0sfEkQXESjOB0s/PnuQIHRLD3gGekbb2ygQFmD8LoARFlPAo96pSxKSGU4JFONj08hALHDipzjaRDIwmODw7YS2LFwnxidODJ+lyXGEajGKmaf++RsCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717653448; c=relaxed/simple;
	bh=56flA6HjJnMMBvpOvXyr7RfplJcIz+LiTQh/FEwWEiw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IS1vhnvyBMVKOFdc3mC3NsGLiur+re+aItY93BxjKH+O9z3486/LpSgeTbWCp4BOzDZ6IpoqWkMH/irp1IhSS393+I5LBirtFzWl6uLf5SFH+xlo8u5SwMWJOIPUc2/k8IHPyGg3wQR6t6bufLllUDVg7N3s6Tv6zJlAc1zQ1wQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rlo0tyJZ; arc=fail smtp.client-ip=40.92.102.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrMRMa87sKqrdHZdYS9WgLGG3iKtpFAgnE3dkeIl/IVy80Jy22fum5ZkQjfjE5R+wjjRYho8Dt8IepXuZH8WNzjI/XaGoHC2yQm29+3LDTGgVFQWZ074HZtqSsLDb51H0HcA2a6nX129p2SBQ8S+fdi69LyjGcPiJMWwAUH5L48LjN4VGaH1HI2iga6pZDtXNGeMI8hCmdkYq2ap8NINQr9XN/cHtS+yGA9noKI+e5JhB6/tF3LIZ4n2lPn6sdM5sO+Eu3kBCrrIGy+qa+1y+AjreCLkowIJqAJX3bdkiE0dqrKrIvjl6q63cRMvqB1Psf9b3lOZzeSBGTQnqlP6ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGXlFrdNFciE1DjMtz7dMbxrUs07a8wmj28kmw9UJhs=;
 b=bDHeEBw9xUbi9c1aHWJptoqn7/esvDZCZ2jG/hmhLiYnUKnfXJCXRS7OHdyeppN0sFVkshcHDwHShdMlGO3YNRb3Er8nWLFoG6brgWUYkvnkzndn3De/SrW/hvOR8q6xlL0F9HEtIyTMT2mxhjV8biIi+zaB6NNy3MeZ4hHUpG5nny2bOSu6QslXuWzcyOuEEO1ivi2t/Fe6anyfcVbLBiwUGwBVyV8hPwFcjKHa8QlMysh0BOXFdt6eXD5/P566/NBNSDr0aOQs3LYqRZomxv4Eg4Ub9+o+2StYI/PdFtR2AwU2o09/tiNXZZfN50SLkhwLhfQRvl3ZxVvgHkFVNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGXlFrdNFciE1DjMtz7dMbxrUs07a8wmj28kmw9UJhs=;
 b=rlo0tyJZU/juVe24zh1x2Y8PliyW3mf6xjGbyxXOZDfzv6CMyBQc/92c8FoWP7kiAlX+gkkma8BAVK1YI9eGhEo/KNLZBXtvEdwWEPBJ0NuxXt/qN3GWN9dXljmUdlwX7irCzGHNY2qb4WR+Cieafg9JrYNkTog/zZj9jigwao+XOYfEzMwbrPxJLVWNi9TyKHXX+rixpmYmUKmGELdVOKNQVar9+XgLgqj/OFDXT2NYB7k2BMvjTExpbtUEAm0Hk8UiqA+RLP6Cm43PN0lI4Z+wWV85Qj8+crxpcfPcyGZ18qBZZVKhKp8Mg6bBXHwF0sIOGhzVEdBS4XVGrEriTA==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN2P287MB1232.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1b0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 05:57:17 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%3]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 05:57:17 +0000
Message-ID:
 <MA0P287MB28222ACCE844092F11B6008AFEFA2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Thu, 6 Jun 2024 13:57:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 4/5] clk: sophgo: Add SG2042 clock driver
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu, chao.wei@sophgo.com,
 conor@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 mturquette@baylibre.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
 richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, guoren@kernel.org,
 jszhang@kernel.org, inochiama@outlook.com, samuel.holland@sifive.com
References: <cover.1714101547.git.unicorn_wang@outlook.com>
 <f9d8ee034528720f24f5ef130f2e0bdb3cdcaf0a.1714101547.git.unicorn_wang@outlook.com>
 <CAJM55Z8HWHApzaDc4atLB62moDugddu3DLkP7Rx+A+UqYNLjyg@mail.gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <CAJM55Z8HWHApzaDc4atLB62moDugddu3DLkP7Rx+A+UqYNLjyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [GGjnQrA30q7vfdK2OTMLC4qM9DQZL3oq]
X-ClientProxiedBy: TYAPR01CA0122.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::14) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <b864ca49-de56-40fa-b91f-91798b8fa2bf@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN2P287MB1232:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a6584fe-e8d5-429c-c6bf-08dc85ed850d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1602099003;
X-Microsoft-Antispam-Message-Info:
	2BanVTfWsv0qT7MhW2ni8z3UNGTZI5S8KopnWDgj1DxxukkM2j+ewqzX71mpq/z3c2C0LTK2jHboo+sCEgGbUOvfYUhojRiL5yc1kIRmNUC0jwGNBD+FAhVKe7kuLO+Bd3CGMsTVT1cHB1ohFN0EWqYNLMiS2WNxCbNPj9G/BcxBBRFnOV3pxzEzZqHNCVbJvw/sp9D+RD/hLTnTlqYPR4E9OJxEWf5pb7fbAXIcnSiGVN4Sard1h7/x6np72TUPmNkTSXs01SZCjGnCkQw9+0yuzJdiNy8ErwqYKGGwpgyMZ0WPYtIgr+o9HCPHoZ6f4aT72/f7TxmEwaZD7Aw2E6HoiuMVuZwhC9kFO3Din8cePTztOxvPLnUy3kHkpHSFpi9mzcdZ1eiSQbdkdd9tTKlJsee3qFEgFnTUjZpEPd4a5LdpwRTpIOh9VNZjSFD0Gc1Oji2aH/yjZOeR6jEbZmp4fEWxWDhbBeFOPHDVJeayzEa0b7ti0O4r+B2GiL7VIFjojcjCASpd2+aTpCzh8F25MYA3MxLvTcbTBvblYyQoOiPYDofUpEsJbVFAOPziyqdImLyqgtxsIyYQ7a14D9U1ESc9bWapcKzYvCNEKZMvX3elarPaSTTpTE9Egoc9sG9i+xWmD5GGUotwSGzP7t10pv4Qznz/eKAEJwxl02oAHthLS9EpS2x6cZ95QGIlawluDC7vtYYd+pVUpKXvZw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eS9Ba1BSZkh4aUd5U1dHNFA1RS9WQlRZM1FCZ0hJMDZHd3gvWnRaOVVSOUxH?=
 =?utf-8?B?eENQVDN1OWtOUlhOZEpTSU5PZnZrNUFOSEVydlVVZndqQmRjelpPNGZsV0Q3?=
 =?utf-8?B?dTBzeFZIZGl5RFY5RFI5cExyNXJqMWFPN0NmM3A0R3dBclkwdGZ2dEFEeHRs?=
 =?utf-8?B?emh6cldoc2xFSUI5NFBjMkJPY0pvMk9vNmMxeDZia0M3cU1CRHRBcStFbjVP?=
 =?utf-8?B?ODh1NGhKTXFZODFBTFUvcnpSWjFpc2pFa1ZGOE5CTTc0WFFuTUFEOTFsVlln?=
 =?utf-8?B?OG1uaFhvVWJlcm9WcDVwamlhRGdZK1Jmam1YRTFMVk5aMDdMZzJKYWtrNzRw?=
 =?utf-8?B?Zm8yWnltNVlzSklJdmo2bmdVMit2VkJldjhWR1N6RUdFdE5iZVU1UmxVV1Ba?=
 =?utf-8?B?Uit2MEwxNjhhL0JDQzFGYlErSEIyNHlYUmR4eW1EZm5Yb2ZWMEZkQXRRYnRv?=
 =?utf-8?B?R1NvSmlyMWxqYThkUXNGSWo1RTAxZEF6L1E5WnNyTVJTMGQyK3JnZUREVU5m?=
 =?utf-8?B?bWd6YmRpY2QrckV6SUNmeTlhMFpKdXNFY2FTMmFNaUtWN0kwbTZYdXBqbCsy?=
 =?utf-8?B?cENBOWRqNG5Sd2hSdm1LbzVsSkwvQ1FEZ1ltYUV5Z0YwNXlVUTBTZHNMWGV3?=
 =?utf-8?B?a01SOGJLY3dJYzNNeno1R1lxcThxczdWMWZLK3hLUkJxYkxsNm51NzhtMmVT?=
 =?utf-8?B?d3lOZlhWR2FSY0NSVTlhbTdJTWNuN2RtS0F2WlFUSjVpVkN4cDZJRjBOVXd5?=
 =?utf-8?B?U1FONjRUeHpGZnU5SklvTkN5T203WXQxT2dWRW5zdUZpcTc0RGZjUnpLM21F?=
 =?utf-8?B?UDBFYmMwQnlCcE5xeDE3V0dBNlJOM0lacW15aGNzWi85OTlDZFZrdXBMazVi?=
 =?utf-8?B?cHQ0Y09wSU9JcVFBc3B4aWdOWnI4eksyODVnVGZxWnhZeUNRWmZBb0dRdXlr?=
 =?utf-8?B?VnJRWXArbFNoZ2NwYkpvNGR6YnI0Y2hLb0hBN0Z1dE0vKzFWRTAvTE5xYTdl?=
 =?utf-8?B?b05zOVRQd3J3YXZqL1FzS1RxTmlvL3lnYmpvTEN0RjhBd3BvSGNQbFp1Kzd3?=
 =?utf-8?B?YUN1UVU5ZGJoRnNsUk9OMjNOL0xFM1FRTkJqeTNVZmwveXZaYXVTTW1vd25v?=
 =?utf-8?B?T1BudEFjZ1o0NzNyYmdiWWFZSkFHeHlzbklCQ2Z0RXhsa1daMGVtTU9RNk5n?=
 =?utf-8?B?SlJKNWozMHpKR2gzc01FdUJHK09UbmhvM0VHK0YvYVF3UFd0WWVYNDJ0VHVm?=
 =?utf-8?B?SnNCUFJmTGZIdGo1UFFWUmh2VXd5MXM5TkhHZmswdjNBRzRnWEVHUG91aVJ5?=
 =?utf-8?B?UXFsOENaOFhzWmJ4dGcwWStOcmk2RVMrNm83dVFJaUsxbVhYRnAzbVlaazJk?=
 =?utf-8?B?R0JsM3FWVWdLelZkZXFKa0tkV0tjMzA5ZTQ4R1Z3WGcxTFU5TkVuMU44U28z?=
 =?utf-8?B?RlV3cTJBeXpCUTQ1V21uT3d2Sm5NaGdxL1NPVjZUOWZIVjlxRlh1NVFpQ2Y5?=
 =?utf-8?B?cmlqWmlPMmJRVVZqU0VZK2F0eHdZeDRhK1p5anNuRHV3Sy9kLzhIU1VsRWpI?=
 =?utf-8?B?S1FBQUJEM3VXTDh4bFR6Q0E1UzJMclZ1YktydE4wSVBTVC82WkdUaDNZcEND?=
 =?utf-8?B?cjEvYmR5ZE1SOFJyZFQvb0NOWmRJeWU1TFFKWmQvVEhTQmQ1d2JWQXR2LzZB?=
 =?utf-8?Q?sWGzerMEl9exwScP9pUF?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a6584fe-e8d5-429c-c6bf-08dc85ed850d
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 05:57:16.9075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB1232


On 2024/4/30 15:48, Emil Renner Berthing wrote:
> Chen Wang wrote:
[......]
>> +#define R_MP14_CONTROL_REG	(0x03F4 - R_SYSGATE_BEGIN)
>> +#define R_MP15_STATUS_REG	(0x03F8 - R_SYSGATE_BEGIN)
>> +#define R_MP15_CONTROL_REG	(0x03FC - R_SYSGATE_BEGIN)
> All these seem pretty regular to me. Couldn't they just be
> #define R_MP_STATUS_REG(x)	(0x380 + 8*(x) - R_SYSGATE_BEGIN)
> #define R_MP_CONTROL_REG(x)	(0x384 + 8*(x) - R_SYSGATE_BEGIN)

I still prefer to keep the original writing method, because using 
immediate values ​​can be consistent with the register description in 
the chip technical manual, which is convenient for comparison and search.

Thanks anyway.

[......]

>> +#define R_CLKDIVREG29		0xB4
>> +#define R_CLKDIVREG30		0xB8
> #define R_CLKDIVREG(x)	(0x40 + 4*(x))

Same reason as above.

[......]

>> +#define PLLCTRL_FBDIV_SHIFT	16
>> +#define PLLCTRL_FBDIV_MASK	(GENMASK(27, 16) >> PLLCTRL_FBDIV_SHIFT)
>> +#define PLLCTRL_POSTDIV2_SHIFT	12
>> +#define PLLCTRL_POSTDIV2_MASK	(GENMASK(14, 12) >> PLLCTRL_POSTDIV2_SHIFT)
>> +#define PLLCTRL_POSTDIV1_SHIFT	8
>> +#define PLLCTRL_POSTDIV1_MASK	(GENMASK(10, 8) >> PLLCTRL_POSTDIV1_SHIFT)
>> +#define PLLCTRL_REFDIV_SHIFT	0
>> +#define PLLCTRL_REFDIV_MASK	(GENMASK(5, 0) >> PLLCTRL_REFDIV_SHIFT)
> You'll only need half of these defines if you use..
Yes, great advice, will change it.
> +
> +static inline u32 sg2042_pll_ctrl_encode(struct sg2042_pll_ctrl *ctrl)
> +{
> +	return ((ctrl->fbdiv & PLLCTRL_FBDIV_MASK) << PLLCTRL_FBDIV_SHIFT) |
> +	       ((ctrl->postdiv2 & PLLCTRL_POSTDIV2_MASK) << PLLCTRL_POSTDIV2_SHIFT) |
> +	       ((ctrl->postdiv1 & PLLCTRL_POSTDIV1_MASK) << PLLCTRL_POSTDIV1_SHIFT) |
> +	       ((ctrl->refdiv & PLLCTRL_REFDIV_MASK) << PLLCTRL_REFDIV_SHIFT);
> ..the FIELD_PREP macro here..
>
>> +}
>> +
>> +static inline void sg2042_pll_ctrl_decode(unsigned int reg_value,
>> +					  struct sg2042_pll_ctrl *ctrl)
>> +{
>> +	ctrl->fbdiv = (reg_value >> PLLCTRL_FBDIV_SHIFT) & PLLCTRL_FBDIV_MASK;
>> +	ctrl->refdiv = (reg_value >> PLLCTRL_REFDIV_SHIFT) & PLLCTRL_REFDIV_MASK;
>> +	ctrl->postdiv1 = (reg_value >> PLLCTRL_POSTDIV1_SHIFT) & PLLCTRL_POSTDIV1_MASK;
>> +	ctrl->postdiv2 = (reg_value >> PLLCTRL_POSTDIV2_SHIFT) & PLLCTRL_POSTDIV2_MASK;
> ..and the FIELD_GET macro here.
[......]
> +
> +#define SG2042_PLL_FW_RO(_id, _name, _parent, _r_stat, _r_enable, _r_ctrl, _shift) \
> +	{								\
> +		.hw.init = CLK_HW_INIT_FW_NAME(				\
> +				_name,					\
> +				_parent,				\
> +				&sg2042_clk_pll_ro_ops,			\
> +				CLK_GET_RATE_NOCACHE | CLK_GET_ACCURACY_NOCACHE),\
> +		.id = _id,						\
> +		.offset_ctrl = _r_ctrl,					\
> +		.offset_status = _r_stat,				\
> +		.offset_enable = _r_enable,				\
> +		.shift_status_lock = 8 + (_shift),			\
> +		.shift_status_updating = _shift,			\
> +		.shift_enable = _shift,					\
> +	}
> These macros are pretty confusing. Please at least try to keep the arguments
> and assignments in close to the same order.
Accept, thanks.
>
>> +
>> +static struct sg2042_pll_clock sg2042_pll_clks[] = {
>> +	SG2042_PLL_FW(MPLL_CLK, "mpll_clock", "cgi_main",
>> +		      R_PLL_STAT, R_PLL_CLKEN_CONTROL, R_MPLL_CONTROL, 0),
>> +	SG2042_PLL_FW_RO(FPLL_CLK, "fpll_clock", "cgi_main",
>> +			 R_PLL_STAT, R_PLL_CLKEN_CONTROL, R_FPLL_CONTROL, 3),
>> +	SG2042_PLL_FW_RO(DPLL0_CLK, "dpll0_clock", "cgi_dpll0",
>> +			 R_PLL_STAT, R_PLL_CLKEN_CONTROL, R_DPLL0_CONTROL, 4),
>> +	SG2042_PLL_FW_RO(DPLL1_CLK, "dpll1_clock", "cgi_dpll1",
>> +			 R_PLL_STAT, R_PLL_CLKEN_CONTROL, R_DPLL1_CONTROL, 5),
> Also the STAT and CLK_GEN_CONTROL registers seem to be the same offset for all
> the PLLs. Why do you need to store them in memory?

Yes, you are right, will correct this.

[......]

>> +static int sg2042_mux_notifier_cb(struct notifier_block *nb,
>> +				  unsigned long event,
>> +				  void *data)
>> +{
>> +	int ret = 0;
>> +	struct clk_notifier_data *ndata = data;
>> +	struct clk_hw *hw = __clk_get_hw(ndata->clk);
>> +	const struct clk_ops *ops = &clk_mux_ops;
>> +	struct sg2042_mux_clock *mux = to_sg2042_mux_nb(nb);
> Please order these by line length where possible. That goes for the whole file.
>
> Eg. look up 'reverse xmas tree' in fx.
> Documentation/process/maintainer-netdev.rst

OK, will improve this.

[......]

>> +static int sg2042_clk_register_muxs(struct device *dev,
>> +				    struct sg2042_clk_data *clk_data,
>> +				    struct sg2042_mux_clock mux_clks[],
>> +				    int num_mux_clks)
>> +{
>> +	struct clk_hw *hw;
>> +	struct sg2042_mux_clock *mux;
>> +	int i, ret = 0;
>> +
>> +	for (i = 0; i < num_mux_clks; i++) {
>> +		mux = &mux_clks[i];
>> +
>> +		hw = __devm_clk_hw_register_mux
>> +			(dev,
>> +			 NULL,
>> +			 mux->hw.init->name,
>> +			 mux->hw.init->num_parents,
>> +			 NULL,
>> +			 mux->hw.init->parent_hws,
>> +			 NULL,
>> +			 mux->hw.init->flags,
>> +			 clk_data->iobase + mux->offset_select,
>> +			 mux->shift,
>> +			 BIT(mux->width) - 1,
>> +			 0,
>> +			 sg2042_mux_table,
>> +			 &sg2042_clk_lock);
> Does checkpatch.pl --strict not warn about this interesting indentation?

No, I always run checkpatch --strict before sending out and don't see 
warn on this.

[......]

>> +static int sg2042_init_clkdata(struct platform_device *pdev,
>> +			       int num_clks,
>> +			       struct sg2042_clk_data **pp_clk_data)
>> +{
>> +	struct sg2042_clk_data *clk_data = NULL;
> No need to initialize this. You're setting it on the line just below. There are
> many other instances of this throughout the file.

Accept，I will double check this.

[......]

>> +static const struct of_device_id sg2042_clkgen_match[] = {
>> +	{ .compatible = "sophgo,sg2042-clkgen" },
>> +	{ /* sentinel */ }
>> +};
>> +
>> +static struct platform_driver sg2042_clkgen_driver = {
>> +	.probe = sg2042_clkgen_probe,
>> +	.driver = {
>> +		.name = "clk-sophgo-sg2042-clkgen",
>> +		.of_match_table = sg2042_clkgen_match,
>> +		.suppress_bind_attrs = true,
>> +	},
>> +};
>> +builtin_platform_driver(sg2042_clkgen_driver);
>> +
>> +static const struct of_device_id sg2042_rpgate_match[] = {
>> +	{ .compatible = "sophgo,sg2042-rpgate" },
>> +	{ /* sentinel */ }
>> +};
>> +
>> +static struct platform_driver sg2042_rpgate_driver = {
>> +	.probe = sg2042_rpgate_probe,
>> +	.driver = {
>> +		.name = "clk-sophgo-sg2042-rpgate",
>> +		.of_match_table = sg2042_rpgate_match,
>> +		.suppress_bind_attrs = true,
>> +	},
>> +};
>> +builtin_platform_driver(sg2042_rpgate_driver);
>> +
>> +static const struct of_device_id sg2042_pll_match[] = {
>> +	{ .compatible = "sophgo,sg2042-pll" },
>> +	{ /* sentinel */ }
>> +};
>> +
>> +static struct platform_driver sg2042_pll_driver = {
>> +	.probe = sg2042_pll_probe,
>> +	.driver = {
>> +		.name = "clk-sophgo-sg2042-pll",
>> +		.of_match_table = sg2042_pll_match,
>> +		.suppress_bind_attrs = true,
>> +	},
>> +};
>> +builtin_platform_driver(sg2042_pll_driver);
> You have 3 different drivers in one file. Could this not be split into 3
> different modules? This file is almost 2k lines long already.
OK, splitting this file into 3 should be better.
>
> Also do they all need to be built in? Eg. could some of them not be loaded as a
> module later in the boot process or are they all critical to get to loading the
> initramfs?

It doesn't seem to be a built-in, I will modify it, thanks for your 
suggestion.

Regards,

Chen

> /Emil
>
>> --
>> 2.25.1
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv

