Return-Path: <linux-kernel+bounces-251865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 556CD930ACE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 18:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C1172819BC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 16:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8560136E37;
	Sun, 14 Jul 2024 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="UW4VVSgR"
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2178.outbound.protection.outlook.com [40.92.63.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72E613790F;
	Sun, 14 Jul 2024 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720974747; cv=fail; b=AJTHFjxK/Q0LazRP2SmVa8l4AtPKOAjw7Ocf4tGhQfjxr7ALz7a9+D+2E01fUP6cZaovYdi0/bp4gwHJcp0pS5kyhv4nG9R8EJQPozSg5irwqbGiePspMKCdREOV9OL9vYjOSAr0bKxT5YLUiVtD/Q7EMtS0SbQzTNTRKY3NXxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720974747; c=relaxed/simple;
	bh=vvhT3BLns/HunqRyjvIHECm7WuSpoOPgp0V6C4WI9TI=;
	h=Date:From:Subject:To:Cc:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZYrnnjR+S2z+kl7fCrgY67N+SwBjRrbUsKx0n9DJYRu6V1itqbYAYYv/Chkjy1ZDWJvtB4tntZk7OXhc/61ZkZlj9R3dHEdEo+oA73LMVOxoyZBi3fJVs7E6lMBTharXHz8K8jMUtvh8+bPD8le0b6+C7YgEA+ZHXKoeOy4YH0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=UW4VVSgR; arc=fail smtp.client-ip=40.92.63.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4mGhuJQjJY6ySECbQJb4alUnSvIbK7rJBAGFPWWa7roLkQI+qsLzrOJ+keHzfw/TraYoWtN19TRj9MpsRQR3TxzuXuC403TPi/NcJcyMEAhBK/enNgCTm1e2GTB5qBqNAf96JCXVLB2ksUsnx9PDP/HL95QltgIZ8omvie5h646PyCiFv3RjRyK7uGVXLA7wOzDbhLclRCvTBdeTLfKG4EO+Ih4x0jLpwdAVLUgkyAYgYLZdiGJmdf+AP5Dh4STGcCsk5LWrQpHRvu/4qZro7isF7lXi0dcM8AwM+HUCMKgVcpREbbU6/9XBwrhsFFQJsaGwGmsYyYemEVLaCGEcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sL8oKXM7iYMTUxKrjDwxpxJHHT/Fl1A0lNX+RdGHF7I=;
 b=SsL5HYz5fHKjU6TxWlnuW025cLO93yNVmREuclFpuykRFLcDN/WGQGBDJ662PMykKigREf1bgZSDQpszSvD2U4KjFsJ2JG6GLdcm4viN3+Ew3M+Xr8VCOfWMxic6vax3YlaFyZUOwt/0dMIHlXCDKxF8f7v8ajoU2QEXF+OA8wOXeg94QDzHXtBJDtJ8IO7a1tDrophoZba1RbV6fmbHb/Gng8u1HNPEn8NDEztfu8A0MvvydR/EJngqJAUzf5Okk1RD6gCJ1EZjXsfrGLrUH4MSGNrf+eCEP9za1UgGuEBgkiVNObw/5eLECQs09ZbDFllAkHV9YBTo3ov/TtHurQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sL8oKXM7iYMTUxKrjDwxpxJHHT/Fl1A0lNX+RdGHF7I=;
 b=UW4VVSgRced/jngFf4BowOhYbAZUDrWTihEWWXlpGLmTI1RJO2ZGTPC57JjJEA/JuuRJIR+B3cCXYJ2Rh9U0ildzL3duhqHevLT2kCAkZMpihfo9pYMMWn5oZGIBncjwF3rEE12FmIzfiw+zjCq/VupF7A+AijUtyp4F4FvyT8YwHhDQl/69Y/YpAwOdFcrkDHdtQZ0SdzxeFMgYK/I4TB/XFPZxam2lqU/zN1wqPPYaXW1MPen5SvlDBIX4boD3kfGbZz+/rFQZ0WtfdmzyTz2ISR6aLd74sLaUOOlttxQmLnSJ7lFihM0Vtuq8FKw5vo16alF/QUviIgmqH3wfPg==
Received: from SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:9b::8) by
 MEYP282MB1752.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:bc::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.28; Sun, 14 Jul 2024 16:32:19 +0000
Received: from SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ac24:7d2b:92fe:20c3]) by SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ac24:7d2b:92fe:20c3%4]) with mapi id 15.20.7762.027; Sun, 14 Jul 2024
 16:32:19 +0000
Date: Mon, 15 Jul 2024 00:09:57 +0800
From: Yuntao Dai <d1581209858@live.com>
Subject: Re: [PATCH 3/3] mailbox: sophgo: add mailbox driver for cv18x SoCs
To: Junhui Liu <liujh2818@gmail.com>
Cc: aou@eecs.berkeley.edu, conor+dt@kernel.org, devicetree@vger.kernel.org,
	inochiama@outlook.com, jassisinghbrar@gmail.com, krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	palmer@dabbelt.com, paul.walmsley@sifive.com, robh@kernel.org,
	unicorn_wang@outlook.com
Message-ID:
 <SYBP282MB2238E9C44A00FE7AED8640B4C4A02@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <cf4a9281-a28b-48f6-a53b-27df01980af6@gmail.com>
References:
 <SYBP282MB2238DE0DA19C6EF411B2356CC4CE2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
	<SYBP282MB2238F93AB57A398E322644C3C4CE2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
	<cf4a9281-a28b-48f6-a53b-27df01980af6@gmail.com>
X-Mailer: geary/0.12.4
Content-Type: text/plain; charset=us-ascii; format=flowed
X-TMN: [5UeceNnS14RAQs0bYMv0lwVWWenkfTprUD0S3+OmVvQ=]
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:9b::8)
X-Microsoft-Original-Message-ID: <1720973397.10748.3@smtp-mail.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBP282MB2238:EE_|MEYP282MB1752:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bacdc19-89e7-4934-6351-08dca42287f1
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|19110799003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	TrRS+QtJMx03vKwLkxXpNM2D9msvENZrRm5814FG/ZGVXwyqfdwY3wwZHUKiCs5rUPIDEScrlzK04xuK709cmcAiAprl0swuP3z4X1160tzeBo+ODxEj46y9bF6G3wrmfloFtNSCU3J8YgimrxJMTyT4Qgz+gcWdQDNx7UgEGgSDrPEeeqv30SPQg7TmdocePdKxNIoUALFsOs7mxTPD7Y5DJz+2ZBwSV/pqICqKVuvSUV5YdUmQGamn/XlO3RrHBsxYivwuHTwEL5P+yZCnvigwDkgf1HUtSGnisnj4eFxVpXyoaNcUO2i758csgjeaaMhpA9z66y74mKeZcQSIRCtOlugb/0L9TDsBP2iDOF9R6cGf6j8W2dT1g2Md0VGQcbUAFdYKDM2rpFA7Exe11eIBCQCZ4Dd1MDnp/EIBpWkZZOQvXmcZAlcdowKPmhlFUd5Y5bkwZawJQxHcefC9qdVDm+/oggcniLsaYx0gRleWEcl5uP/9dpEj1otv8d27raPGgd1qCD3YDCgU4TODYGpv0bt1VjinEvLK3goPDHgpmq0ukzx0wONy4s1M54lOV3hzlE+XoqaiMxu0YnQxzf4UfGC9xU5xSqKygxJt+q+JQOX0MNS1T8cjANOub2lUTITbUZaYWSQUonYtH87AgA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g2r98RIFjIS0YrVUKXroiz3BdYfP3CmQ28S2piwcuk0jNPdEfNceooe44VGZ?=
 =?us-ascii?Q?ZZPdrjHAzRXTte09ORs3YiGAYHtWc210M2LnKFxsgPtdk2pxYWt7VKD4Twy9?=
 =?us-ascii?Q?SHe7Um5ahHygB415mhqbYe1L6F7h62D6axFOoW2H0liPO0qd8P8jw3Gzv4bL?=
 =?us-ascii?Q?6SptMkKoZzbUGfJ+gzAzKmEoAWYfw5sLS3nNIGvuBZVOnaC0YZIWiWuCgZK2?=
 =?us-ascii?Q?oln5axIxWg6nQhkbU/Db/2Fm5Iei2aCYbPTJlBxuKD2DTYuEVvCRrP91wx/5?=
 =?us-ascii?Q?WlZeGVTxJEKmtyxm3YS/KRmikpS49QN5U8dqdkDKC4dnzU5PonIaZ6zAH7d3?=
 =?us-ascii?Q?Zk0HnVPDRowkhnnCjMpqiJAJ2oGHlindAtEW4yfzQSQ8NdTnuj1nOovmnAcW?=
 =?us-ascii?Q?dlzX7+JoFTxq4iafPO4ng03QCWzDx26nQ5l6av5kGmkbAqN7DftRX2wxlURa?=
 =?us-ascii?Q?fh0Ijf1o2tKLDWiz77AobG0nRk9B9PGLqP4ShqUf9V+Cdu4nPgGi3E+0UAef?=
 =?us-ascii?Q?5TBfZ1lAcmuYgnXRgNM/7MFlDgZS2flMCEqHWEKoMWoGyhIn6/lDDSSe5du/?=
 =?us-ascii?Q?eckrjIRT+/M6X3jCvncQ/ia3KpVdWkPrfT4SnhU6qokcn3PbbcFsNaMvrNUe?=
 =?us-ascii?Q?cYb20u9IKi1VAAn310cmA4LdKUAkXhL9HpwAvezZ7LrHzyKncKoJe1PLZoaP?=
 =?us-ascii?Q?HA8ZMKJMSok64LU+K+xzYBEngHbMN/8o+COGnJTRgum0GeHW9wkCtdskxZuC?=
 =?us-ascii?Q?1VPGIfMoO7FwiYYBIEO7yTovN6aYpoC7rOisyC1D0xFozI5k6mkLDyBXykok?=
 =?us-ascii?Q?PP0hNW+eXraroYcP5SGhrQOZ0xjdNzZdado+2B7hhjt7qCcVHeO8tv5LjXq0?=
 =?us-ascii?Q?/JpXvyizCj1AFNCwmUH8swB/5ZNzBbswFAfY9JhiUcdThdKDYhRCEgAvGFzu?=
 =?us-ascii?Q?KBZkr9rSECznjlOv3nfvmf34qJn5aK39Y2facFZKFwdGj7FauAwkMDlKf4Wc?=
 =?us-ascii?Q?j+C1DQAu37kZsEkBaqQkorx/+Qs0CmaXBCLC/tKlpzpisBjkGkQNlukt6RUr?=
 =?us-ascii?Q?PonnZJJNN13qATATFFR3dachCrQFCLcXGheRjXH7LVVFpPEAegBeaZJP2WIe?=
 =?us-ascii?Q?NJANvdM+SAki7qhayXUMtenhpHjML5c+73NxdfdF5szas7xbExzIwpiIjMGW?=
 =?us-ascii?Q?dHtQa5o/MNkIwG5XDDmgFs/CcWhbFdrqVEX0v8ZwXDWJf71hSH7D1kBPuDI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-722bc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bacdc19-89e7-4934-6351-08dca42287f1
X-MS-Exchange-CrossTenant-AuthSource: SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2024 16:32:19.9236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEYP282MB1752

Hi Junhui,

On Tue, Jul 2, 2024 at 11:08 PM, Junhui Liu <liujh2818@gmail.com> wrote:
> Hi Yuntao,
> 
> On 2024/6/18 23:12, Yuntao Dai wrote:
>> Add mailbox controller driver for cv18x SoCs, tested on mailbox-test
>> client.
>> 
>> Signed-off-by: Yuntao Dai <d1581209858@live.com>
>> ---
>>   drivers/mailbox/Kconfig           |  11 ++
>>   drivers/mailbox/Makefile          |   2 +
>>   drivers/mailbox/cv1800b-mailbox.c | 181 
>> ++++++++++++++++++++++++++++++
>>   3 files changed, 194 insertions(+)
>>   create mode 100644 drivers/mailbox/cv1800b-mailbox.c
>> 
>> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
>> index 3b8842c4a..4e5593861 100644
>> --- a/drivers/mailbox/Kconfig
>> +++ b/drivers/mailbox/Kconfig
>> @@ -286,4 +286,15 @@ config QCOM_IPCC
>>   	  acts as an interrupt controller for receiving interrupts from 
>> clients.
>>   	  Say Y here if you want to build this driver.
>>   +config CV1800B_MBOX
>> +	tristate "cv1800b mailbox"
>> +	depends on OF
>> +	depends on ARCH_SOPHGO || COMPILE_TEST
>> +	help
>> +	  Mailbox driver implementation for Sophgo cv180x SoCs. This driver
>> +	  can be used to send message between different processors in SoC. 
>> Any
>> +	  processer can write data in a channel, and set co-responding 
>> register
>> +	  to raise interrupt to notice another processor, and it is 
>> allowed to
>> +	  send data to itself.
>> +
>>   endif
>> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
>> index 5cf2f54de..71f0f746e 100644
>> --- a/drivers/mailbox/Makefile
>> +++ b/drivers/mailbox/Makefile
>> @@ -62,3 +62,5 @@ obj-$(CONFIG_SUN6I_MSGBOX)	+= sun6i-msgbox.o
>>   obj-$(CONFIG_SPRD_MBOX)		+= sprd-mailbox.o
>>   better
>>   obj-$(CONFIG_QCOM_IPCC)		+= qcom-ipcc.o
>> +
>> +obj-$(CONFIG_CV1800B_MBOX)	+= cv1800b-mailbox.o
>> \ No newline at end of file
>> diff --git a/drivers/mailbox/cv1800b-mailbox.c 
>> b/drivers/mailbox/cv1800b-mailbox.c
>> new file mode 100644
>> index 000000000..8ef2a5492
>> --- /dev/null
>> +++ b/drivers/mailbox/cv1800b-mailbox.c
>> @@ -0,0 +1,181 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/kfifo.h>
>> +#include <linux/mailbox_controller.h>
>> +#include <linux/mailbox_client.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +
>> +#define MAILBOX_MAX_CHAN 0x0008
>> +#define MAILBOX_DONE_OFFSET 0x0002
>> +#define MAILBOX_CONTEXT_SIZE 0x0040
>> +#define MAILBOX_CONTEXT_OFFSET 0x0400
>> +
>> +#define MBOX_EN_REG(cpu) (cpu << 2)
>> +#define MBOX_DONE_REG(cpu) ((cpu << 2) + MAILBOX_DONE_OFFSET)
>> +
>> +#define MBOX_SET_CLR_REG(cpu) (0x10 + (cpu << 4))
>> +#define MBOX_SET_INT_REG(cpu) (0x18 + (cpu << 4))
>> +
>> +#define MBOX_SET_REG 0x60
>> +
>> +struct cv1800b_mbox {
>> +	struct mbox_controller mbox;
>> +	struct mbox_chan chans[MAILBOX_MAX_CHAN];
>> +	u64 *content[MAILBOX_MAX_CHAN];
>> +	void __iomem *mbox_base;
>> +	int sendto;
>> +	int recvid;
>> +};
>> +
>> +static irqreturn_t cv1800b_mbox_isr(int irq, void *dev_id)
>> +{
>> +	struct cv1800b_mbox *mbox = (struct cv1800b_mbox *)dev_id;
>> +	size_t i;
>> +
>> +	for (i = 0; i < MAILBOX_MAX_CHAN; i++) {
>> +		if (mbox->content[i]) {
>> +			mbox_chan_received_data(&mbox->chans[i],
>> +						mbox->content[i]);
> I tested this driver but met "NULL pointer dereference" Oops here
> when I sent message from the c906l core without binding clients.
> 
> I think maybe it's better to add a check here, like:
> 
> struct mbox_chan *chan = &mbox->chans[i];
> if (chan->cl) {
>     mbox_chan_received_data(chan, mbox->content[i]);
> }
> 
> Best,
> Junhui Liu

Thanks for your addvice, I will take it. On the other side, I am not 
sure weather mailbox driver can work without register mailbox client 
correctly?

Best regards,
Yuntao


