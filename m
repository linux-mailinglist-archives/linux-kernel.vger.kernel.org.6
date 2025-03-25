Return-Path: <linux-kernel+bounces-575645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D23AA7052E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4797718861A7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4473B1A3AB8;
	Tue, 25 Mar 2025 15:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="PLPvrsT2"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011052.outbound.protection.outlook.com [52.101.65.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAB5191484;
	Tue, 25 Mar 2025 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742916924; cv=fail; b=GbA/LCC1rcPLAYQxBP84RAJpLHYad8vNeAdYZ6DwKIJh7Hx+YlFFy7VIudIIJgg6K8nhKdxtWPnl0hO9pquawF2TM/SzJFgA8S91WkZ7xEyr1smv4vPYhGvxH/WNQPSj+slsKk0TkQuBDryU3IH5X0zQxJIU5dh0fVYU3IgubIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742916924; c=relaxed/simple;
	bh=XeRQuVYYIy2fv4nm5gUTsfloWCnGYhVq9jLXjEjULQM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=fDtpJVLzYgHduyvey4F4qYUlel2KTjJLfml0skfritzEidJlgbvCO1xeyyc3Ixv1wTgXRg2u8T4QIwvMTxyc1EAASThuwElvwvdCqmpZ9V2Pp6CNCc0FJoUTeCXvrvBKk5HlcVKB6L3R5L/WOrfV+Bhs/YFsAb6fjHGnL2EJFDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=PLPvrsT2; arc=fail smtp.client-ip=52.101.65.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDIba7vvdI9zol56YdyrgbE+d5ILp/fmsiyJ8JNruh9+PIrwuc3iyisdePCP/UD7mLFztDJWmm2+QaVAtqhRH9T/n9f/AbE95aN4q5/dRA217Mt0qVspBV3HgZKValOnmfSFnxozXzbLM3y/TLE6Rg1ouV816xzcy7J+VLA8tNLVVzuq1+jCCN3T5LnESea5lsdSlJgSW9gmf8tsDHU2XzcHztU+ZzSXBEGJz6zez1QevEAKzlM7gE5IgaXSrzOiX52c7LsSZyqxnMEvrJu3FW/lDIZwoPdrdOg3Hyc7yWyRTwcDALWl6Ly6GL19HwwcT7F8YO7nO63uWMaxTpkb9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+zCMRfP83UoM3pFgY0Xpl3e/iySAaDeBaavbSbvZGg=;
 b=lw92mi0zrYb7qs+8/YMwu9At/rbRlu0F7ggIREDVst/qXxOHsY++TtYwxNEtVHThK1yS7kRFANBzraIjBu8dluNgtN1o1dX6SerVuOzzdBFPpZpu7LXmLcP2Jf9wnmc2ispAFnuMfrWN9q2df6EgKrdHHUip9bAVDoVPc4r5A+8WebDWVNdd3zQX7DWKTKu6LUE7zrejxsFvEMkPwaXqGFRdVIbaQP+3GA87FUgjdEQFsPl7vZZHHEF2wy1FqIrPxpQb3CESJdzOVv+9zph3D5MWnIL/T1CDohRAGREZQz7MnGvXdW7VR/IzHL7TEPZWaz/z1/ZQ7gsL0OqfS9J3mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+zCMRfP83UoM3pFgY0Xpl3e/iySAaDeBaavbSbvZGg=;
 b=PLPvrsT2KoClHQn1hbQJGWTI6BBbUIl6tsUeVHVPdDibJXIE6SCSvMDMpfbCtRgcYAEoZcGQIDqRHJh/E/8quWPe4HZkdMn7W8OxWjwuwJhoJvhp3Sh2ul+3VFkKrRs98Gdj/GwR2VG8z87gaG5roGmohU2p8zfTQ8iRkj6XU44=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by VI1PR10MB3597.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:141::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 15:35:15 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 15:35:15 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Colin Foster <colin.foster@in-advantage.com>
Cc: Lee Jones <lee@kernel.org>,  linux-kernel@vger.kernel.org,
  devicetree@vger.kernel.org,  Felix Blix Everberg <felix.blix@prevas.dk>
Subject: Re: [PATCH 3/8] mfd: ocelot: rework SPI (re-)initialization after
 chip reset
In-Reply-To: <Z9682y2Z_BUUjg2e@colin-ia-desktop> (Colin Foster's message of
	"Sat, 22 Mar 2025 08:36:27 -0500")
References: <20250319123058.452202-1-ravi@prevas.dk>
	<20250319123058.452202-4-ravi@prevas.dk>
	<Z9tASE2-adiEUT-3@colin-ia-desktop> <87v7s4rlwu.fsf@prevas.dk>
	<Z9682y2Z_BUUjg2e@colin-ia-desktop>
Date: Tue, 25 Mar 2025 16:35:12 +0100
Message-ID: <87a599dsy7.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0054.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::24) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|VI1PR10MB3597:EE_
X-MS-Office365-Filtering-Correlation-Id: 27f1dfa3-ab23-4ec5-a776-08dd6bb2a37d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y3+Ka46YF9reZd/eYbz+faIEUpXFHLSCXZ2TkxPIU4pU1IW9L5LiGuwQHRGZ?=
 =?us-ascii?Q?OGEm1n5fYZYWSWLtreYjmUdAN0dGSouoemwPrdbzND6ewO/wroxnx+66ALnc?=
 =?us-ascii?Q?n0i0+T2l67wKRf5TwDWY5JkuqSLNYVxivvw+jFkdeIBDrTSrlZV+sc/5I8rQ?=
 =?us-ascii?Q?J8bk0+S+VG0mmhDo0HS3ZFIFrVyHM0h0vxaDIICYvXXMls50YxGVWG9R9M8I?=
 =?us-ascii?Q?yqnbPlnyWrU0hhNeCH84v9MDOwH36/djS9d9WMf440bh5Qmvz0CsdWWcazt5?=
 =?us-ascii?Q?WGKTpp+M0IaAiRymao/02UOCjUBqiMf63CpfOMW+pUegBKLZt2eVNiqxNa8I?=
 =?us-ascii?Q?iL0QJJfT5ZTOXjAQ1Y50YKDN0PRkfg4bLgPSJbmsiqgXtpJr1mu4G3EVUvls?=
 =?us-ascii?Q?1XheconNXky4asxO1yKaJlNrF//puRAPHvymEWGIhpgAxEy3AR9RPiSeakkV?=
 =?us-ascii?Q?Zngs/iXAmYdJv4SyPGHSNshVCCP60bI6WZFXMGsKbkhXvRGhuGCMDiycWkel?=
 =?us-ascii?Q?j1tThQFtRlZJDZdlAfjzrQ5wSgmMO11T7QsVb5exSHYbicEcDJaz84zsTFOU?=
 =?us-ascii?Q?I//1+457umQY0dZsno233ZRb/v2Y8T4j6y4pkm+yHOCY21bsDHU9ONX336Le?=
 =?us-ascii?Q?rQD283EPYMrWseYN5BK1MD0Drx1QXyonJ34vW1zsQejggb7Xxoql1nIb9lb1?=
 =?us-ascii?Q?wjy3kdivtiHVlE8rbrLwcxjHmNblAh8YGrWD6ZiD2hwl9vxXJQyWCsFhxdgX?=
 =?us-ascii?Q?HKS1uCSjCPdIRpCFlN5lWhNEoXAx9duSeOlusNBHlDjSFW4LBdLwL2H1ygci?=
 =?us-ascii?Q?Ot1mSIM70wh1pvyJV2by3OcRbELyuKpBlaVCWwSyySJV30FsNIhX0Oy0ipgV?=
 =?us-ascii?Q?xDq8RFAVGZF+JEhZ97y7hkwNa8zjA27cS3MZm/TPyKmc9/pgpAvPZr/vfWQP?=
 =?us-ascii?Q?L4lFz4zy2jXlbNceAdOlT3NY4imClalwNcK7FryatsJxLwYKqgz7Q65NyHoB?=
 =?us-ascii?Q?MkqjgNSLM16nqrWFYWFW0zHj7omRE7cBu7Hz3HDhqb+krI+hfuGbX8nie0QN?=
 =?us-ascii?Q?GP6whCgQ6oYprn1kDyVn33y7Z23EiUNmQR9lW5r2J3OT79qykepgQAgRKAJU?=
 =?us-ascii?Q?uezw5I7RWug2BtZ20NWgjN7i4MEm6kLwy6gGtmu8aLGQBoy5BC1R6CYb2cgZ?=
 =?us-ascii?Q?7yEP4iJ4gYdwT0xle3ToRYM+wHiyTkQmOw0+AjDW3Xe2HWRiOP3VseewpWFm?=
 =?us-ascii?Q?Vkx2hOeE6IM2UlpkUsQJjA5a1AdF3zSoU/IkA/pzpJfKht68z+EtDd3qcYwR?=
 =?us-ascii?Q?rkQ1zg8Uqr4PssWo6LVx2MFu8r1qxvADYCKJqDkNn1Hjfw6XMX/lGjYClK4h?=
 =?us-ascii?Q?CivrD1QPZ8yahNsr0K3rYN92niMxm9CgSbbDKy/RZGF45JeM37wJtye1Mxau?=
 =?us-ascii?Q?dmGNlvlQ5W9Ql94KmE/YWroUecqe2EF5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l8FJX60Bc5O0tKmUSQIqmyLXBOzW7FrpOkxItvhotkMY0LbidjVmL21XuzXn?=
 =?us-ascii?Q?LPXu8ZR0JKD8UVAMy9R2dMfKDuie1hPlQN24p0LZPIGEXU+DTCf8WkvUKK61?=
 =?us-ascii?Q?J8554RdkkRhkPHJildTzR5U3t0MhHTP2DixD3oje+yBGwbReoKPKa7cug1za?=
 =?us-ascii?Q?MPbZNsog4FXYe66ppa0i0dlT2UaxeL5KcTJhI9pk4E/isj/TI4FJpJ5YaaM3?=
 =?us-ascii?Q?y0wik/Ps6W9tsUIfUWyZj0zjwwkpdwWpchz/JpiSESVb92v5ZC1i0i8p09Mm?=
 =?us-ascii?Q?n0VWgMnc0Ozak9JZWq7g+EHr4BZadiEV/j+/rLtDH4xXvuZeroHN1yPpf4z0?=
 =?us-ascii?Q?cIzA/jkn0Xy3q10zmVrO9EIlCmtHt7OF6RFiNmozQFqygsDbNYXZw8dmghm1?=
 =?us-ascii?Q?c2g+OnUPwsq/Mrc1MDfTgTDR035CBf6f01b9zLPiSsncSsRmqRiaXFXn9TrO?=
 =?us-ascii?Q?HXnibnZCp/DdgO4fJT4udvo1OOdA7hESbqwKURNMm8FSg15GlMhiuKo0gsUH?=
 =?us-ascii?Q?0J48SZW3/zD461qAcg2fAIP5/OX0t08MGBBXKR2ehfxpcUuTZ+OFOwJPltBy?=
 =?us-ascii?Q?4HQRzqFy+6KUVyv+jNtRPnJqLMDSqVImL+eKDUrUNoary8LBJgtUn8v4CMcN?=
 =?us-ascii?Q?SpsgfokG8uSkq2pO51/LGtvDpNzD0rYYvT32paC4E7wdbKduhrdDhxNMbY3y?=
 =?us-ascii?Q?Txapnf/pi+tYAXO70ERduefhhzQWFngn2At2CxsiTOrnR78eq20nwwtiQ5IN?=
 =?us-ascii?Q?bHxl177jmcRXrssl88cQowgNq/oluN36kOGJpA+0CuLuspTruUwGLeAULTKN?=
 =?us-ascii?Q?I9EepF38ZAxIPfgSfAZ4csoSam3Y1spKlI4RXPClpRK1BdOHEZyPG67GpUCa?=
 =?us-ascii?Q?h0ZkLMbJtvopSJ6V1qqn4XqdzjfG6/jdd+s9is2wD0Qf35f5x3Hi5MpBsbZL?=
 =?us-ascii?Q?A2sirIjUR4TVRzVbmRN4hLFz6fDnYObwf7D+B3E2qrBx/NcL+4e+PvrIi11H?=
 =?us-ascii?Q?ii8+C0Ld9Uz/XaWQsleDzduRmnkMcKibDY/ZnhtqU7bCvmzCDUdtmsN04xNA?=
 =?us-ascii?Q?Jcfh3JgJTdj189Dgwa79BtmUgJtpwTKTpehMjbY7JaNiultIc/dFyZkXxXBK?=
 =?us-ascii?Q?uNVaJZdBw8aHgkjWOr3zuNFzEK7voRET5CsLUIwMK+NBA1JVh4kx37CBEGGf?=
 =?us-ascii?Q?FDB9maGTFu6souJDLWzy4VFFZv0q1E76xoK/mr75bKQRKzr4CUyRfHtlfErP?=
 =?us-ascii?Q?KJuB2B3UQ4ZhYyvk+SYWT2jpxQQaL6s/pdbKsX/1i2tsgPSqKrPkmsMMg8g5?=
 =?us-ascii?Q?WxRzxaIKACZuqtb2nOaKTpZaI04joJcpvGdxnEDNzVJ0tKh2hYQmGpXG1jbW?=
 =?us-ascii?Q?StzNXPm2KYjSlQ0YSCs6X7Y0SQzo7SwaVsw5Zvwn4fQShkZ9VtUtb+KIlthP?=
 =?us-ascii?Q?9Hvf9g9ysz+o8N/ykdraKcOXYHi826qjSACFVEq0GSrz5l4LFU3LEoeW8e6E?=
 =?us-ascii?Q?Pj1GOCkTioiwgzbc3K34o6VvMt5RvGnd+gO4EzZ/xgdI9ZoP5tan1oKHXrZm?=
 =?us-ascii?Q?ruWHjOJUycCcG8VwymPo84NZx2p5l/r9EfJSGBL18Ws7zG/AkBSJl269yZgC?=
 =?us-ascii?Q?Hw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f1dfa3-ab23-4ec5-a776-08dd6bb2a37d
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 15:35:14.9455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Skgw/oxIikL5js4WhKV7caLAW5qHCf6aW1KcEMy1TX2MdTatbGHg8fzkxA3DNu9ueym5n3CqBjgY8qmkMnVK8BPMmJIRI/R3zWbf/j6aA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3597

On Sat, Mar 22 2025, Colin Foster <colin.foster@in-advantage.com> wrote:

> On Thu, Mar 20, 2025 at 12:17:37PM +0100, Rasmus Villemoes wrote:
>> Hi Colin
>> 
>> On Wed, Mar 19 2025, Colin Foster <colin.foster@in-advantage.com> wrote:
>> 
>> > On Wed, Mar 19, 2025 at 01:30:53PM +0100, Rasmus Villemoes wrote:
>> >> As the comments in ocelot-spi.c explain, after a chip reset, the
>> >> CFGSTAT register must be written again setting the appropriate number
>> >> of padding bytes; otherwise reads are not reliable.
>> >> 
>> >> However, the way the code is currently structured violates that: After
>> >> the BIT_SOFT_CHIP_RST is written, ocelot_chip_reset() immediately
>> >> enters a readx_poll_timeout().
>> >
>> > I ran this new version and everything worked - and I've not seen an
>> > issue in previous versions. I'm looking for guidance as to whether this
>> > should include a Fixes tag and be backported.
>> 
>> Thanks a lot for testing and reviewing! As for backporting, IDK, I think
>> we'd at least first have to know that it really fixes a bug for somebody.
>> 
>> > Great find, by the way! Is there any information you would like from my
>> > setup?
>> 
>> Certainly I'd like to know if you do in fact use a SPI clock > 500 kHz?
>
> Yep, looks like 2.5MHz
>
> &spi0 {
>         #address-cells = <1>;
>         #size-cells = <0>;
>         status = "okay";
>
>         soc@0 {
>                 compatible = "mscc,vsc7512";
>                 spi-max-frequency = <2500000>;
>
>> 
>> And if so, could you try inserting a read and printk of e.g. CHIP_REGS.CHIP_ID
>> immediately after the fsleep(), but before the re-initialization, just
>> so we can see if my theory that the values are off-by-8-bits plus 8 bits
>> of MISO "garbage" is correct? Because that register should have a fairly
>> easily recognizable value.
>
> diff --git a/drivers/mfd/ocelot-core.c b/drivers/mfd/ocelot-core.c
> index c00d30dbfca8..5a2762b6ecac 100644
> --- a/drivers/mfd/ocelot-core.c
> +++ b/drivers/mfd/ocelot-core.c
> @@ -115,6 +115,8 @@ static int ocelot_chip_reset(struct device *dev)
>
>         if (ddata->init_bus) {
>                 fsleep(VSC7512_GCB_RST_SLEEP_US);
> +               regmap_read(ddata->gcb_regmap, 0, &val);
> +               printk("7512 Chip ID after sleep: 0x%08x\n", val);
>                 ret = ddata->init_bus(dev);
>                 if (ret)
>                         return dev_err_probe(dev, ret,
>
>
> Prints out this:
>
> [    3.360986] 7512 Chip ID after sleep: 0xf0e94051
>
> That doesn't seem right. I added a print after init and it makes more sense.
>
> [    3.351656] 7512 Chip ID after sleep: 0xf0e94051
> [    3.356828] 7512 Chip ID after init: 0x175140e9

Thanks for testing. I hadn't realized that another thing the spi bus init
does is setting the endianness, but this clearly shows both the
off-by-one-byte and that the bytes are sent in the wrong order.

It's hard to know how you end up with that f0 garbage byte, I'd assume
either all-1s or all-0s when MISO is no longer driven explicitly. A wild
guess could be that it's leftover capacitance (the last actually-driven
bit is 1), which could explain why you haven't had a problem when
reading the reset register and expected all zeroes, because in that case
the device only sends 0s, and thus the garbage byte ends up also being a
0x00.

So yes, it does seem like this warrants a backport. I'll add a Fixes tag
for the next iteration, plus a link to this thread which demonstrates
the problem. I suppose this goes back to f3e89362.

Thanks,
Rasmus

