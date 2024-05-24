Return-Path: <linux-kernel+bounces-188666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E55938CE51A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDEAD1C20C15
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2098C8625F;
	Fri, 24 May 2024 12:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="E8Ji1AmS"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2018.outbound.protection.outlook.com [40.92.53.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C45D85929;
	Fri, 24 May 2024 12:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716553010; cv=fail; b=rU717/81frA6Ce0rnEW9JsHqQqqCO+rRxkXFeOZoTTwjrMfe3nPOth/wrAZns3h8Uh8AUZX7ukDFNtu6Orw53ZAumWYAmXwfWBYwiFdC2UlFgxfb9LoYC3Xi1B9HO9nxGMpcEiVoRKmH6bV6JjyDCs5ByD68t3PTH8zxGpEWG58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716553010; c=relaxed/simple;
	bh=mfIOG0D8nCeuC+ZVIDinlPJBDfFekE7u6FNgx/TM4xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z5wq7axls3930zamhPB2CvFHITtA690/mxG+wsBMTrMt7BPwWPxIfHztpk+u1OJ2jqaYUdSawsSE+MBCer6g3Ivl874vs1XApjw2JoVsGm6tqqWb0ah6eTkRThjbuUDqqnP36IxDQncIWbK9u3MA8LlDBtRmJNp9MeQA4Dwfpvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=E8Ji1AmS; arc=fail smtp.client-ip=40.92.53.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0qBta2WiHcURXyjQdky6SPM+VztgWSgcAPXHAMjNjXcExzo7HdADV9Kjis55JNdagoWH4DEYPOp59elVm43jaWiZFMwbUBuccXYfUezm5gj1U3s4wWtrdts0SVu8XQ7FpXBn4aS7/Q1SYBzCKnIv0iLxqC3JuxiKwhwoKMLxwBUMS41+qvLm/7H34ncUr72Fq5FU+a3xSOm3Aar2zDULincTm6Vuin4Slcc9vsZAsB3apS21dlH80esfV1i3D6CdnlD+hghPb0zG+GRvn+5mD3yHfrpzGzkrOkQJcb0h5BNwSSI4iQ1FcjZlYdq/s/01x1c1Y7TpkBjHkPB81eC7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AuGkEzM7zSM0ynqt4IUHkedpoh9XvusZCaiYoKkaXc=;
 b=L+7IwpyxGTOBDvkoNqDA6ranxJhf9nvKDYUGiIqhbgKDDX/ydDUDoJ5xeYltk/q8kH+ix7KZ7tAgEOOIf619vTRonB0HYmWlwnekPlAw2SS4GS1g1v9AgJc9vbcO5yETntidH3Xn11XQnlu4l44QH55TiRUBlfkafqY/4uL5Z0tKPwdYqYsrRDI/frn4e7JUQP26ouCQ/MQJ3ekfazfbTFETBGYey5U3rsI4dOkLPiPxjLHgaBOAD8w/cVinZNVamkSMkcn8pAbPVQjhyZKtN8cClqe4HwXYUJLB01lCyfrnUa2lxDOm22yQE/h1Vq8+8r8DiZQqE6PhkpeipcjWgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AuGkEzM7zSM0ynqt4IUHkedpoh9XvusZCaiYoKkaXc=;
 b=E8Ji1AmSRyRAp2Fa0GIWbOo7naFcnrL1nwmEgGQ0Xnoy4icSAWKHFChaWtDqZ6hwZUo74w+O7Hy44+LS2rzmfgmgyFGkYezBoKZG+e7qPfXU4jIMiwYyTjupU87+5wmWr8RDfZ6TMmyyd/8B11xrzvcnK4AINiEH8GTAx92dghNYKaCk1xzvALUgvC8CrdNvxKMa9JcE4DMf1QqMGaiWa2AJTJAyLef3anxxDtl3yju5op/qqjnxGHKrdwwwrL2rYIsOOqm7AQyI1cGLv6s85YUk84+o4cuM+1s4EItGPDsHLEvDxj52lkb8uUFRrXvHl8mnnVEqfyF0PrNB+OZvgg==
Received: from SEYPR04MB6482.apcprd04.prod.outlook.com (2603:1096:101:be::7)
 by KL1PR04MB7660.apcprd04.prod.outlook.com (2603:1096:820:124::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.27; Fri, 24 May
 2024 12:16:42 +0000
Received: from SEYPR04MB6482.apcprd04.prod.outlook.com
 ([fe80::ca2b:8a48:a7ab:60e5]) by SEYPR04MB6482.apcprd04.prod.outlook.com
 ([fe80::ca2b:8a48:a7ab:60e5%5]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 12:16:42 +0000
From: Noah Wang <noahwang.wang@outlook.com>
To: linux@roeck-us.net
Cc: jdelvare@suse.com,
	robh@kernel.org,
	conor+dt@kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [v2 2/2] hwmon: add MP2891 driver
Date: Fri, 24 May 2024 20:16:31 +0800
Message-ID:
 <SEYPR04MB64824636D580EBF1985ED727FAF52@SEYPR04MB6482.apcprd04.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <6fde589b-5344-4ae9-83f7-aacfab9de4ec@roeck-us.net>
References: <6fde589b-5344-4ae9-83f7-aacfab9de4ec@roeck-us.net>
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-TMN: [gFQqB5ElJr80pEELQZaQoh6kJGZ8guR1]
X-ClientProxiedBy: SG2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:3:17::18) To SEYPR04MB6482.apcprd04.prod.outlook.com
 (2603:1096:101:be::7)
X-Microsoft-Original-Message-ID:
 <20240524121631.29122-1-noahwang.wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR04MB6482:EE_|KL1PR04MB7660:EE_
X-MS-Office365-Filtering-Correlation-Id: faca1fc3-cf5c-4315-d59b-08dc7beb5efe
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1602099003;
X-Microsoft-Antispam-Message-Info:
	8MoPQyzHWaUQUPQ9C+Woaol4X80JT0OQDu41FWoAzYtsnVO4hIntbZnaUPPENOIc+76wxgAQSDRC7ub8EV7dBBKrNG1CQVFzRK8T8493doBs+A1AA+18bWGhQjZWb3ETXgfDP8of4je/ugJvxBzkO74WVCJ1cuTIXsx0/ZS7es0L+RjignUBePuOfqRNhwR1nfkZF7wG5+Q39Q0lLPIn7Vs+vRELuFrWsklmpxjWTedRLumcjwWe5VfGuzo5iU0yUlGVcFGuVQglLCmuCajAxFNmqMrjevBJJ9l4VyDeSYuhJjUEt8ZCq083dfFD70paJc+bWZYo+k5GdUHoPUXp7QYEqGsWbSCP5AeX+7RxkANmy09IUOY6HmKR2/OcZFvJsKKlLodPgq9DSXx+HoetiZJfybMvyz9DxpMHPaeUoua9eWHf3bmbxTnSsXjQDG8vDcw/fPJny94x88UDa5uUpadoefuVvsoOpaCulfSklhHEJIc0EFCJNuX1gLGckunh3Wq1NVKz83jKekxibpeM0bW2Ml89rVqyaYniZGt4vdlu62jwYE6I8PjX5sHn/siz0aqzhNDfc03dFahzV2fygMf9cCMsIJ0zltFiuz7KlI5c4yevZgBaxVdP9vmDnEHkHQCZnoNzYZrtlR0RIJQC6442LhbqUBnqL4RW6jfSkyo=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uPFLR0oIJUCwBoTlcVdrU90Hhu+gxQ7IauJVWC+aiMSigc58XkxNK61XoX32?=
 =?us-ascii?Q?5WEIvx6LDLYIqUCmUUIf0GizwtYXhKifSUgfMgZSH7ZjnINZH0/dRpxbB1h3?=
 =?us-ascii?Q?K6E2YIbEGKRptUyVbTKvqSS5viyz6h45LK7sxS5ruYhw8FxKe9OnUhBqMkFz?=
 =?us-ascii?Q?1m1uLqgrH/DLxlsT8725VfC7qJUiY/lWcLmfQiSr+u7IPXAbcFg+B6kmg60Y?=
 =?us-ascii?Q?2XzBGNWPckY/OZGC8bYtQbIFoCdZAfYQ9MAVHlLN/2v440fXsZ7B7m+OdFQT?=
 =?us-ascii?Q?ICHrnyHNj+GyR33/jPSZjutsCHXRGMOMqZaO1MwWc9OMLC6SoHNdPb2iHzXt?=
 =?us-ascii?Q?6K4lYp9H7FazOtzv747cVbisrjGyiQ6wlC7KQgdqX3qGE3ZLqPzgjhcRiSfM?=
 =?us-ascii?Q?sSn4Tjbgpfzm6lQ5vgz5WhaNDW8w0zVTidGR/q5gmqKHQbJyhedEudJd8Hbt?=
 =?us-ascii?Q?BLdBwwHeEhmRuNlHeNeoNQNff6/QjycRygbWlxmNg5IGxrQg1stdypE9hZ7+?=
 =?us-ascii?Q?A2YTVx4FZhQNi1iqv54g34kGNJooYLqSAxTgFIaVsAVpVIfoFeQSVTiGJXb9?=
 =?us-ascii?Q?zvzOgEvmFIh0aYnOALqAb+ShS0h56rubiK/r4+Xff3kXByWIYfKNZgGHg3ra?=
 =?us-ascii?Q?ZAGzv0Q5sHsAoPM3YMLsFCXIyPDpphq9rx4J5OC7azsxI/40zxm8FeBtBe6Z?=
 =?us-ascii?Q?ViuyU3tGm2WtSChzO/ttoLLnqqfAJe6PCKAprphLvbYmhYQ+SkAheU3DAvDa?=
 =?us-ascii?Q?ErDOqfsTaNyBaALFNScjQABnxXAx91CgRQRL0WDMCcWEbuDkmQX1C2faQftH?=
 =?us-ascii?Q?so8M0b9QDYi0TLi0rYB1h6FHOwS1g0MSjmNkmmKjO2xTOMe38RTjo6DJdoU4?=
 =?us-ascii?Q?TaIT+EqfkLKRt15G0t+RLHYwI/JUyrAkq8OFT6FKKaqCciowKbm8zpKew3cN?=
 =?us-ascii?Q?qe9mWBmDoN3rdZmbV2Cux9MWFTJmqZXTNm/sT9YE2ACeA0bjxbD7msKe+bvm?=
 =?us-ascii?Q?y+KYHeNPjPD+DZtQ5DAhtdUqFFtiIThgYhOUoOSRMbwXfCAS1AtwB3lJ8K1Q?=
 =?us-ascii?Q?W1BUeOKoJDB2g7OuqaPyL0wIeDcrh+kNan1hkxTUeK0rPpDhDoHCIo2otrpf?=
 =?us-ascii?Q?PirISQ9RP0EL3K6Jk2/r8tYR0zTN1x/wsomTrO19Lrb6INcVkNQye8P52enJ?=
 =?us-ascii?Q?CJYUQpJU49nSh7uo2VOTCwOJ+4KnO9kfnT0WZGzcwSFFWEJ5M8XTt3u0g9KB?=
 =?us-ascii?Q?9K02Tbm7STmAMz5ySBL8?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faca1fc3-cf5c-4315-d59b-08dc7beb5efe
X-MS-Exchange-CrossTenant-AuthSource: SEYPR04MB6482.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 12:16:42.4031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7660

> > This driver is designed for MPS VR controller mp2891. This driver
> > exposes telemetry and limit value readings.
> > 
> > Signed-off-by: Noah Wang <noahwang.wang@outlook.com>
> > 
> > V1 -> V2:
> >     1. add limit register readings
> >     2. add status register readings
> >     3. change PSC_CURRENT_OUT format from linear to direct
> >     4. add more detailed explanation for special processing
> >     5. remove useless code
> >     6. move identify vout_scale, iout_scale function to
> >         identify() callback
> >     7. update MP2891 datasheet
> 
> Couple of general comments:
>  
> It looks like the chip isn't really using linear11 format (at least not
> for the most part); while some of the values have an exponent, the scale
> always seems to be the same. I wonder if it would make sense to convert
> all values into direct format and use r/m/b scale, or in other words
> drop the exponent bits where needed.
> 

Thanks for your comment. I think it is a good way. The PMBUS_READ_VIN, 
PMBUS_VIN_UV_FAULT_LIMIT and PMBUS_VIN_UV_WARN_LIMIT have the same 
scale(31.25mV/Lsb), the PMBUS_READ_TEMPERATURE_1, PMBUS_OT_FAULT_LIMIT 
and PMBUS_OT_WARN_LIMIT have the same scale(1°C/Lsb),  so the PSC_VOLTAGE_IN, 
PSC_TEMPERATURE can be changed from linear to direct and use r/m/b scale. But 
the exponent vaue of the PMBUS_READ_IIN, PMBUS_READ_POUT and PMBUS_READ_PIN 
is not constant, it maybe change. But the PMBUS_PIN_OP_WARN_LIMIT scale(2w/Lsb) 
and the PMBUS_IIN_OC_WARN_LIMIT scale (0.5A/Lsb) is constant. So I think the 
PSC_CURRENT_IN and PSC_POWER format should keep linear11. Here is only my view, 
it is pleasure to hear your advice. 

> There are no write functions for limit registers/commands, meaning
> that values would be written directly into registers. I can only
> imagine that this would cause a lot of trouble if anyone ever tries
> to write a limit, especially for those registers where the upper bits
> are not values but configuration (?) bits such as VOUT_UV_FAULT_LIMIT.
> 

Thanks for your comment.For mp2891, the limit register is configed through a
config file(the config file is sent to MP2891 by a GUI that mps provide), not
the pmbus. The reason for this is due to security verification and avoid
malicious attacks. So the limit register should not be configed by the driver.
I think I also need to add below function for write_word_data callback in next
version.
int mp2891_write_word_data(struct i2c_client *client, int page, int reg, u16 word)
{
	return -EINVAL;
}
It is pleasure to hear your advice.

> Checkpatch reports several "CHECK: Alignment should match open
> parenthesis". Please fix.
> 
> Additional comments inline.
> 

I am sorry for this. I will fix this issue in next version.

> > ---
> >  Documentation/hwmon/index.rst  |   1 +
> >  Documentation/hwmon/mp2891.rst | 179 +++++++++++++
> >  drivers/hwmon/pmbus/Kconfig    |   9 +
> >  drivers/hwmon/pmbus/Makefile   |   1 +
> >  drivers/hwmon/pmbus/mp2891.c   | 462 +++++++++++++++++++++++++++++++++
> >  5 files changed, 652 insertions(+)
> >  create mode 100644 Documentation/hwmon/mp2891.rst
> >  create mode 100644 drivers/hwmon/pmbus/mp2891.c
> > 
> > diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> > index 03d313af4..88f70ef60 100644
> > --- a/Documentation/hwmon/index.rst
> > +++ b/Documentation/hwmon/index.rst
> > @@ -168,6 +168,7 @@ Hardware Monitoring Kernel Drivers
> >     mp2975
> >     mp5023
> >     mp5990
> > +   mp2891
> >     mpq8785
> >     nct6683
> >     nct6775
> > diff --git a/Documentation/hwmon/mp2891.rst b/Documentation/hwmon/mp2891.rst
> > new file mode 100644
> > index 000000000..a487d5ee8
> > --- /dev/null
> > +++ b/Documentation/hwmon/mp2891.rst
> > @@ -0,0 +1,179 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +Kernel driver mp2891
> > +====================
> > +
> > +Supported chips:
> > +
> > +  * MPS mp2891
> > +
> > +    Prefix: 'mp2891'
> > +
> > +  * Datasheet
> > +
> > +    Publicly available at the MPS website : https://www.monolithicpower.com/en/mp2891.html
> > +
> The datasheet is not "publically available". It is only available
> if one has an account.
> 

Sorry for this, but mps only update the datasheet on their website. And guests should 
sign up an account for the datasheet.

> > +Author:
> > +
> > +	Noah Wang <noahwang.wang@outlook.com>
> > +
> > +Description
> > +-----------
> > +
> > +This driver implements support for Monolithic Power Systems, Inc. (MPS)
> > +MP2891 Multi-phase Digital VR Controller.
> > +
> > +Device compliant with:
> > +
> > +- PMBus rev 1.3 interface.
> > +
> > +Device supports direct and linear format for reading input voltage,
> > +output voltage, input currect, output current, input power, output
> > +power, and temperature.
> > +
> > +The driver exports the following attributes via the 'sysfs' files
> > +for input voltage:
> > +
> > +**in1_input**
> > +
> > +**in1_label**
> > +
> > +**in1_crit**
> > +
> > +**in1_crit_alarm**
> > +
> > +**in1_lcrit**
> > +
> > +**in1_lcrit_alarm**
> > +
> > +**in1_min**
> > +
> > +**in1_min_alarm**
> > +
> > +The driver provides the following attributes for output voltage:
> > +
> > +**in2_input**
> > +
> > +**in2_label**
> > +
> > +**in2_crit**
> > +
> > +**in2_crit_alarm**
> > +
> > +**in2_lcrit**
> > +
> > +**in2_lcrit_alarm**
> > +
> > +**in2_min**
> > +
> > +**in2_min_alarm**
> > +
> > +**in3_input**
> > +
> > +**in3_label**
> > +
> > +**in3_crit**
> > +
> > +**in3_crit_alarm**
> > +
> > +**in3_lcrit**
> > +
> > +**in3_lcrit_alarm**
> > +
> > +**in3_min**
> > +
> > +**in3_min_alarm**
> > +
> > +The driver provides the following attributes for input current:
> > +
> > +**curr1_input**
> > +
> > +**curr1_label**
> > +
> > +**curr1_max**
> > +
> > +**curr1_max_alarm**
> > +
> > +**curr2_input**
> > +
> > +**curr2_label**
> > +
> > +**curr2_max**
> > +
> > +**curr2_max_alarm**
> > +
> > +The driver provides the following attributes for output current:
> > +
> > +**curr3_input**
> > +
> > +**curr3_label**
> > +
> > +**curr3_crit**
> > +
> > +**curr3_crit_alarm**
> > +
> > +**curr3_max**
> > +
> > +**curr3_max_alarm**
> > +
> > +**curr4_input**
> > +
> > +**curr4_label**
> > +
> > +**curr4_crit**
> > +
> > +**curr4_crit_alarm**
> > +
> > +**curr4_max**
> > +
> > +**curr4_max_alarm**
> > +
> > +The driver provides the following attributes for input power:
> > +
> > +**power1_input**
> > +
> > +**power1_label**
> > +
> > +**power1_max**
> > +
> > +**power1_alarm**
> > +
> > +**power2_input**
> > +
> > +**power2_label**
> > +
> > +**power2_max**
> > +
> > +**power2_alarm**
> > +
> > +The driver provides the following attributes for output power:
> > +
> > +**power3_input**
> > +
> > +**power3_label**
> > +
> > +**power4_input**
> > +
> > +**power4_label**
> > +
> > +The driver provides the following attributes for temperature:
> > +
> > +**temp1_input**
> > +
> > +**temp1_crit**
> > +
> > +**temp1_crit_alarm**
> > +
> > +**temp1_max**
> > +
> > +**temp1_max_alarm**
> > +
> > +**temp2_input**
> > +
> > +**temp2_crit**
> > +
> > +**temp2_crit_alarm**
> > +
> > +**temp2_max**
> > +
> > +**temp2_max_alarm**
> > diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> > index 08e82c457..c0cc673a6 100644
> > --- a/drivers/hwmon/pmbus/Kconfig
> > +++ b/drivers/hwmon/pmbus/Kconfig
> > @@ -371,6 +371,15 @@ config SENSORS_MP5990
> >  	  This driver can also be built as a module. If so, the module will
> >  	  be called mp5990.
> >  
> > +config SENSORS_MP2891
> > +    tristate "MPS MP2891"
> > +    help
> > +      If you say yes here you get hardware monitoring support for MPS
> > +      MP2891 Dual Loop Digital Multi-Phase Controller.
> > +
> > +      This driver can also be built as a module. If so, the module will
> > +      be called mp2891.
> > +
> >  config SENSORS_MPQ7932_REGULATOR
> >  	bool "Regulator support for MPQ7932"
> >  	depends on SENSORS_MPQ7932 && REGULATOR
> > diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> > index 2279b3327..4f680bf06 100644
> > --- a/drivers/hwmon/pmbus/Makefile
> > +++ b/drivers/hwmon/pmbus/Makefile
> > @@ -39,6 +39,7 @@ obj-$(CONFIG_SENSORS_MP2888)	+= mp2888.o
> >  obj-$(CONFIG_SENSORS_MP2975)	+= mp2975.o
> >  obj-$(CONFIG_SENSORS_MP5023)	+= mp5023.o
> >  obj-$(CONFIG_SENSORS_MP5990)	+= mp5990.o
> > +obj-$(CONFIG_SENSORS_MP2891)	+= mp2891.o
> >  obj-$(CONFIG_SENSORS_MPQ7932)	+= mpq7932.o
> >  obj-$(CONFIG_SENSORS_MPQ8785)	+= mpq8785.o
> >  obj-$(CONFIG_SENSORS_PLI1209BC)	+= pli1209bc.o
> > diff --git a/drivers/hwmon/pmbus/mp2891.c b/drivers/hwmon/pmbus/mp2891.c
> > new file mode 100644
> > index 000000000..afe49fcb3
> > --- /dev/null
> > +++ b/drivers/hwmon/pmbus/mp2891.c
> > @@ -0,0 +1,462 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Hardware monitoring driver for MPS Multi-phase Digital VR Controllers(MP2891)
> > + */
> > +
> > +#include <linux/err.h>
> > +#include <linux/i2c.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include "pmbus.h"
> > +
> > +/*
> > + * Vender specific registers, the register MFR_SVI3_IOUT_PRT(0x65),
> > + * MFR_VOUT_LOOP_CTRL(0xBD), READ_PIN_EST(0x94)and READ_IIN_EST(0x95)
> > + * redefine the standard PMBUS register. The MFR_SVI3_IOUT_PRT(0x65)
> > + * is used to identify the iout scale and the MFR_VOUT_LOOP_CTRL(0xBD)
> > + * is used to identify the vout scale. The READ_PIN_EST(0x94) is used
> > + * to read input power of per rail. The MP2891 does not have standard
> > + * READ_IIN register(0x89), the iin telemetry can be obtained through
> > + * the vendor redefined register READ_IIN_EST(0x95).
> > + */
> > +#define MFR_VOUT_LOOP_CTRL      0xBD
> > +#define READ_PIN_EST            0x94
> > +#define READ_IIN_EST            0x95
> > +#define MFR_SVI3_IOUT_PRT	    0x65
> > +
> > +#define MP2891_TEMP_LIMIT_OFFSET	40
> > +#define MP2891_PIN_LIMIT_UINT		2
> > +#define MP2891_IOUT_LIMIT_UINT	    8
> > +#define MP2891_IOUT_SCALE_DIV       32
> > +#define MP2891_VOUT_SCALE_DIV       100
> > +#define MP2891_OVUV_DELTA_SCALE     50
> > +#define MP2891_OV_LIMIT_SCALE       20
> > +#define MP2891_UV_LIMIT_SCALE       5
> > +
> > +#define MP2891_PAGE_NUM			2
> > +
> 
> Please watch out for tab alignment. Defines should be
> 
> #define<space>NAME<tab>value
> 

I am sorry for this. I will fix this issue in next version.

> > +#define MP2891_RAIL1_FUNC	(PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | \
> > +							PMBUS_HAVE_IOUT | PMBUS_HAVE_TEMP | \
> > +							PMBUS_HAVE_POUT | PMBUS_HAVE_PIN | \
> > +							PMBUS_HAVE_IIN | PMBUS_HAVE_STATUS_VOUT | \
> > +							PMBUS_HAVE_STATUS_IOUT | \
> > +							PMBUS_HAVE_STATUS_INPUT | \
> > +							PMBUS_HAVE_STATUS_TEMP)
> > +
> > +#define MP2891_RAIL2_FUNC	(PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT | \
> > +							PMBUS_HAVE_TEMP | PMBUS_HAVE_POUT | \
> > +							PMBUS_HAVE_PIN | PMBUS_HAVE_IIN | \
> > +							PMBUS_HAVE_STATUS_VOUT | \
> > +							PMBUS_HAVE_STATUS_IOUT | \
> > +							PMBUS_HAVE_STATUS_INPUT | \
> > +							PMBUS_HAVE_STATUS_TEMP)
> > +
> > +struct mp2891_data {
> > +	struct pmbus_driver_info info;
> > +	int vout_scale[MP2891_PAGE_NUM];
> > +	int iout_scale[MP2891_PAGE_NUM];
> > +};
> > +
> > +#define to_mp2891_data(x) container_of(x, struct mp2891_data, info)
> > +
> > +#define MAX_LIN_MANTISSA	(1023 * 1000)
> > +#define MIN_LIN_MANTISSA	(511 * 1000)
> > +
> > +/* Converts a milli-unit DIRECT value to LINEAR11 format */
> > +static u16 mp2891_data2reg_linear11(s64 val)
> > +{
> > +	s16 exponent = 0, mantissa;
> > +	bool negative = false;
> > +
> > +	/* simple case */
> > +	if (val == 0)
> > +		return 0;
> > +
> > +	/* Reduce large mantissa until it fits into 10 bit */
> > +	while (val >= MAX_LIN_MANTISSA && exponent < 15) {
> > +		exponent++;
> > +		val >>= 1;
> > +	}
> 
> I don't think any of the data registers provides more than 10 bits
> of range, so most of this complexity is unnecessary.
> 

Thanks for your comment. For example, the PIN_OP_WARN_LIMIT(0x6B)(bit0-bit9)
register of MP2891 contains the limit value. And the scale is 2W/Lsb, so the
max limit value is 2046W, maybe this will not happen, but I think it is better
to keep this process to avoid data read error. Here is only my view, it is
pleasure to hear your advice.

> > +	/* Increase small mantissa to improve precision */
> > +	while (val < MIN_LIN_MANTISSA && exponent > -15) {
> > +		exponent--;
> > +		val <<= 1;
> > +	}
> > +
> > +	/* Convert mantissa from milli-units to units */
> > +	mantissa = clamp_val(DIV_ROUND_CLOSEST_ULL(val, 1000), 0, 0x3ff);
> > +
> > +	/* restore sign */
> > +	if (negative)
> > +		mantissa = -mantissa;
> > +
> > +	/* Convert to 5 bit exponent, 11 bit mantissa */
> > +	return (mantissa & 0x7ff) | ((exponent << 11) & 0xf800);
> > +}
> > +
> > +static int
> > +mp2891_identify_vout_scale(struct i2c_client *client, struct pmbus_driver_info *info,
> > +										int page)
> > +{
> > +	struct mp2891_data *data = to_mp2891_data(info);
> > +	int ret;
> > +
> > +	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, page);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = i2c_smbus_read_word_data(client, MFR_VOUT_LOOP_CTRL);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/*
> > +	 * The output voltage is equal to the READ_VOUT(0x8B) register value multiply
> > +	 * by vout_scale.
> > +	 * Obtain vout scale from the register MFR_VOUT_LOOP_CTRL, bits 15-14,bit 13.
> > +	 * If MFR_VOUT_LOOP_CTRL[13] = 1, the vout scale is below:
> > +	 * 2.5mV/LSB
> > +	 * If MFR_VOUT_LOOP_CTRL[13] = 0, the vout scale is decided by
> > +	 * MFR_VOUT_LOOP_CTRL[15:14]:
> > +	 * 00b - 6.25mV/LSB, 01b - 5mV/LSB, 10b - 2mV/LSB, 11b - 1mV
> > +	 */
> > +	if (ret & GENMASK(13, 13)) {
> > +		data->vout_scale[page] = 250;
> > +	} else {
> > +		ret = FIELD_GET(GENMASK(15, 14), ret);
> > +		if (ret == 0)
> > +			data->vout_scale[page] = 625;
> > +		else if (ret == 1)
> > +			data->vout_scale[page] = 500;
> > +		else if (ret == 2)
> > +			data->vout_scale[page] = 200;
> > +		else
> > +			data->vout_scale[page] = 100;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int
> > +mp2891_identify_iout_scale(struct i2c_client *client, struct pmbus_driver_info *info,
> > +										int page)
> > +{
> > +	struct mp2891_data *data = to_mp2891_data(info);
> > +	int ret;
> > +
> > +	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, page);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = i2c_smbus_read_word_data(client, MFR_SVI3_IOUT_PRT);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/*
> > +	 * The output current is equal to the READ_IOUT(0x8C) register value
> > +	 * multiply by iout_scale.
> > +	 * Obtain iout_scale from the register MFR_SVI3_IOUT_PRT[2:0].
> > +	 * The value is selected as below:
> > +	 * 000b - 1A/LSB, 001b - (1/32)A/LSB, 010b - (1/16)A/LSB,
> > +	 * 011b - (1/8)A/LSB, 100b - (1/4)A/LSB, 101b - (1/2)A/LSB
> > +	 * 110b - 1A/LSB, 111b - 2A/LSB
> > +	 */
> > +	switch (ret & GENMASK(2, 0)) {
> > +	case 0:
> > +	case 6:
> > +		data->iout_scale[page] = 32;
> > +		break;
> > +	case 1:
> > +		data->iout_scale[page] = 1;
> > +		break;
> > +	case 2:
> > +		data->iout_scale[page] = 2;
> > +		break;
> > +	case 3:
> > +		data->iout_scale[page] = 4;
> > +		break;
> > +	case 4:
> > +		data->iout_scale[page] = 8;
> > +		break;
> > +	case 5:
> > +		data->iout_scale[page] = 16;
> > +		break;
> > +	default:
> > +		data->iout_scale[page] = 64;
> > +		break;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int mp2891_identify(struct i2c_client *client, struct pmbus_driver_info *info)
> > +{
> > +	int ret;
> > +
> > +	/* Identify vout scale for rail 1. */
> > +	ret = mp2891_identify_vout_scale(client, info, 0);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* Identify vout scale for rail 2. */
> > +	ret = mp2891_identify_vout_scale(client, info, 1);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* Identify iout scale for rail 1. */
> > +	ret = mp2891_identify_iout_scale(client, info, 0);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* Identify iout scale for rail 2. */
> > +	ret = mp2891_identify_iout_scale(client, info, 1);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return ret;
> > +}
> > +
> > +static int mp2891_read_byte_data(struct i2c_client *client, int page, int reg)
> > +{
> > +	int ret;
> > +
> > +	switch (reg) {
> > +	case PMBUS_VOUT_MODE:
> > +		/*
> > +		 * The MP2891 does not follow standard PMBus protocol completely, the
> > +		 * PMBUS_VOUT_MODE(0x20) in MP2891 is reserved and 0x00 is always be
> > +		 * returned when the register is read. But the calculation of vout in
> > +		 * this driver is based on direct format. As a result, the format of
> > +		 * vout is enforced to direct.
> > +		 */
> > +		ret = PB_VOUT_MODE_DIRECT;
> > +		break;
> > +	default:
> > +		ret = -ENODATA;
> > +		break;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int mp2891_read_word_data(struct i2c_client *client, int page,
> > +				 int phase, int reg)
> > +{
> > +	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> > +	struct mp2891_data *data = to_mp2891_data(info);
> > +	int ret;
> > +
> > +	switch (reg) {
> > +	case PMBUS_READ_IIN:
> > +		/*
> > +		 * The MP2891 does not have standard PMBUS_READ_IIN register(0x89),
> > +		 * the iin telemetry can be obtained through the vender redefined
> > +		 * register READ_IIN_EST(0x95).
> > +		 */
> > +		ret = pmbus_read_word_data(client, page, phase, READ_IIN_EST);
> > +		break;
> > +	case PMBUS_READ_PIN:
> > +		/*
> > +		 * The MP2891 has standard PMBUS_READ_PIN register(0x97), but this
> > +		 * is not used to read the input power of per rail. The input power
> > +		 * of per rail is read through the vender redefined register
> > +		 * READ_PIN_EST(0x94).
> > +		 */
> > +		ret = pmbus_read_word_data(client, page, phase, READ_PIN_EST);
> > +		break;
> > +	case PMBUS_READ_VOUT:
> > +	case PMBUS_VOUT_UV_WARN_LIMIT:
> > +		ret = pmbus_read_word_data(client, page, phase, reg);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		ret = DIV_ROUND_CLOSEST(ret * data->vout_scale[page], MP2891_VOUT_SCALE_DIV);
> > +		break;
> > +	case PMBUS_READ_IOUT:
> > +		ret = pmbus_read_word_data(client, page, phase, reg);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		ret = DIV_ROUND_CLOSEST((ret & GENMASK(10, 0)) * data->iout_scale[page],
> > +								MP2891_IOUT_SCALE_DIV);
> > +		break;
> > +	case PMBUS_OT_FAULT_LIMIT:
> > +	case PMBUS_OT_WARN_LIMIT:
> > +		/*
> > +		 * The MP2891 PMBUS_OT_FAULT_LIMIT and PMBUS_OT_WARN_LIMIT are not
> > +		 * linear11 format, the scale is 1°C/LSB and they have 40°C offset.
> > +		 * As a result, the limit value is calculated to m°C first, then
> > +		 * it is converted to linear11 format.
> > +		 */
> > +		ret = pmbus_read_word_data(client, page, phase, reg);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		ret = mp2891_data2reg_linear11(((ret & GENMASK(7, 0)) -
> > +								MP2891_TEMP_LIMIT_OFFSET) * 1000);
> > +		break;
> > +	case PMBUS_VIN_UV_FAULT_LIMIT:
> > +	case PMBUS_VIN_UV_WARN_LIMIT:
> > +		/*
> > +		 * The MP2891 PMBUS_VIN_UV_FAULT_LIMIT and PMBUS_VIN_UV_WARN_LIMIT
> > +		 * are not linear11 format, the scale is 31.25mV/LSB. As a result,
> > +		 * the limit value is calculated to mV first, then it is converted
> > +		 * to linear11 format.
> > +		 */
> > +		ret = pmbus_read_word_data(client, page, phase, reg);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		ret = mp2891_data2reg_linear11(DIV_ROUND_CLOSEST((ret & GENMASK(9, 0)) * 3125,
> > +										100));
> > +		break;
> > +	case PMBUS_VIN_OV_FAULT_LIMIT:
> > +		/*
> > +		 * The MP2891 PMBUS_VIN_OV_FAULT_LIMIT are not linear11 format,
> > +		 * the scale is 125mV/LSB. As a result, the limit value is
> > +		 * calculated to mV first, then it is converted to linear11
> > +		 * format.
> > +		 */
> > +		ret = pmbus_read_word_data(client, page, phase, reg);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		ret = mp2891_data2reg_linear11((ret & GENMASK(7, 0)) * 125);
> > +		break;
> > +	case PMBUS_VOUT_UV_FAULT_LIMIT:
> > +		ret = pmbus_read_word_data(client, page, phase, reg);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		if (FIELD_GET(GENMASK(11, 8), ret))
> > +			ret = FIELD_GET(GENMASK(7, 0), ret) * MP2891_UV_LIMIT_SCALE -
> > +				(FIELD_GET(GENMASK(11, 8), ret) + 1) * MP2891_OVUV_DELTA_SCALE;
> > +		else
> > +			ret = FIELD_GET(GENMASK(7, 0), ret) * MP2891_UV_LIMIT_SCALE;
> > +
> > +		ret = ret < 0 ? 0 : ret;
> > +		break;
> > +	case PMBUS_VOUT_OV_FAULT_LIMIT:
> > +		ret = pmbus_read_word_data(client, page, phase, reg);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		if (FIELD_GET(GENMASK(11, 8), ret))
> > +			ret = FIELD_GET(GENMASK(7, 0), ret) * MP2891_OV_LIMIT_SCALE +
> > +				(FIELD_GET(GENMASK(11, 8), ret) + 1) * MP2891_OVUV_DELTA_SCALE;
> > +		else
> > +			ret = FIELD_GET(GENMASK(7, 0), ret) * MP2891_OV_LIMIT_SCALE;
> > +		break;
> > +	case PMBUS_IOUT_OC_WARN_LIMIT:
> > +	case PMBUS_IOUT_OC_FAULT_LIMIT:
> > +		ret = pmbus_read_word_data(client, page, phase, reg);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		ret = DIV_ROUND_CLOSEST((ret & GENMASK(7, 0)) * data->iout_scale[page] *
> > +						MP2891_IOUT_LIMIT_UINT, MP2891_IOUT_SCALE_DIV);
> > +		break;
> > +	case PMBUS_IIN_OC_WARN_LIMIT:
> > +		/*
> > +		 * The MP2891 PMBUS_IIN_OC_WARN_LIMIT are not linear11 format, the
> > +		 * scale is 0.5V/LSB. As a result, the limit value is calculated to
> > +		 * mA first, then it is converted to linear11 format.
> > +		 */
> > +		ret = pmbus_read_word_data(client, 0, phase, reg);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		ret = mp2891_data2reg_linear11((ret & GENMASK(9, 0)) * 1000 / 2);
> > +		break;
> > +	case PMBUS_PIN_OP_WARN_LIMIT:
> > +		/*
> > +		 * The MP2891 PMBUS_PIN_OP_WARN_LIMIT are not linear11 format, the
> > +		 * scale is 2W/LSB. As a result, the limit value is calculated to
> > +		 * mW first, then it is converted to linear11 format.
> > +		 */
> > +		ret = pmbus_read_word_data(client, 0, phase, reg);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		ret = mp2891_data2reg_linear11((ret & GENMASK(9, 0)) * MP2891_PIN_LIMIT_UINT *
> > +										1000);
> > +		break;
> > +	case PMBUS_READ_VIN:
> > +	case PMBUS_READ_POUT:
> > +	case PMBUS_READ_TEMPERATURE_1:
> > +		ret = -ENODATA;
> > +		break;
> > +	default:
> > +		ret = -EINVAL;
> > +		break;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static struct pmbus_driver_info mp2891_info = {
> > +	.pages = MP2891_PAGE_NUM,
> > +	.format[PSC_VOLTAGE_IN] = linear,
> > +	.format[PSC_CURRENT_IN] = linear,
> > +	.format[PSC_CURRENT_OUT] = direct,
> > +	.format[PSC_TEMPERATURE] = linear,
> > +	.format[PSC_POWER] = linear,
> > +	.format[PSC_VOLTAGE_OUT] = direct,
> > +
> > +	.m[PSC_VOLTAGE_OUT] = 1,
> > +	.R[PSC_VOLTAGE_OUT] = 3,
> > +	.b[PSC_VOLTAGE_OUT] = 0,
> > +
> > +	.m[PSC_CURRENT_OUT] = 1,
> > +	.R[PSC_CURRENT_OUT] = 0,
> > +	.b[PSC_CURRENT_OUT] = 0,
> > +
> > +	.func[0] = MP2891_RAIL1_FUNC,
> > +	.func[1] = MP2891_RAIL2_FUNC,
> > +	.read_word_data = mp2891_read_word_data,
> > +	.read_byte_data = mp2891_read_byte_data,
> > +	.identify = mp2891_identify,
> > +};
> > +
> > +static int mp2891_probe(struct i2c_client *client)
> > +{
> > +	struct pmbus_driver_info *info;
> > +	struct mp2891_data *data;
> > +
> > +	data = devm_kzalloc(&client->dev, sizeof(struct mp2891_data), GFP_KERNEL);
> > +	if (!data)
> > +		return -ENOMEM;
> > +
> > +	memcpy(&data->info, &mp2891_info, sizeof(*info));
> > +	info = &data->info;
> > +
> > +	return pmbus_do_probe(client, info);
> > +}
> > +
> > +static const struct i2c_device_id mp2891_id[] = {
> > +	{"mp2891", 0},
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(i2c, mp2891_id);
> > +
> > +static const struct of_device_id __maybe_unused mp2891_of_match[] = {
> > +	{.compatible = "mps,mp2891"},
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(of, mp2891_of_match);
> > +
> > +static struct i2c_driver mp2891_driver = {
> > +	.driver = {
> > +		.name = "mp2891",
> > +		.of_match_table = mp2891_of_match,
> > +	},
> > +	.probe = mp2891_probe,
> > +	.id_table = mp2891_id,
> > +};
> > +
> > +module_i2c_driver(mp2891_driver);
> > +
> > +MODULE_AUTHOR("Noah Wang <noahwang.wang@outlook.com>");
> > +MODULE_DESCRIPTION("PMBus driver for MPS MP2891");
> > +MODULE_LICENSE("GPL");
> > +MODULE_IMPORT_NS(PMBUS);
> > -- 
> > 2.25.1
> > 

