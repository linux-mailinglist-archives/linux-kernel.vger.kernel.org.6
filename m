Return-Path: <linux-kernel+bounces-259228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5A19392EE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEEA11C2171E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971AB16EB56;
	Mon, 22 Jul 2024 17:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Gs2Ek7yQ"
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2149.outbound.protection.outlook.com [40.92.62.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBB5C2FD;
	Mon, 22 Jul 2024 17:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.149
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721667744; cv=fail; b=ZUcFiwMF4Dpa/2ECU04UldklxEEldZlvHMY4TCzzFOGdoshiJK1cQCJ57xqfnKtCCSXm0/hkwBzE6RjMgu6hvS7KLzBdmlA0c3z9vWhXsofp9KxR+Oxw3e5RIKrIaT8d+rLK0CS3A5vNDH1LKHC0DinN2EJRwQQce8rWWweoFoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721667744; c=relaxed/simple;
	bh=dR8A4q/RCCQNlUppFHQCn8bEhgepE248TXSo4r/t+a8=;
	h=Date:From:Subject:To:Cc:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AWlFTaRCZiD6tE9f+JlKqGE17gLOUjIMrvzfXiG0QiHspY3h8iXDXLmpr99zTnGgil1rZF5VbcAuPNVQHQtCqLeqYRdYW6Ourxb+HewwIqE91TY7odb1nS+I+kizpMR9HTQw1yRbbSs/VhCkji4X+KdPRSCUciz0ZamvYuM+JPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Gs2Ek7yQ; arc=fail smtp.client-ip=40.92.62.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlPO5DiTqF6Mz1xEAkcanudgd8KJ55gYCZABAVWW+NaEVibogxA80df8Pj9Yt1FqTYlvkyi7DWQqVQvfHoxQKm0FaVh7RR9jVm4lOkC4hLNW6IYSA77LkSjnIEFbHLGUIu63CL01ff0Nq5JQ9C9IX+ExI+1JQQMgRob8xXHS+pN5iv39Zqm/nNDI2XBHjtaUlNUNj/HUQi/IxWV4dZfDFHDKy1FZiluQ4TB4TPX1zhIMVBd+ROpRq5zfHTytJeD4/exWprlRPfXvrtfgAAgJYXzzeGIdYr2PJ3R3bXwfO75lHPcT/Ny9rWnrtdBjXktDo9cdQWQlOG64D7is5FP12Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DfKecSETS/b4wU9X5FKuOCAUxuXCmRfP6fvc/zYkvTw=;
 b=dEyASA1CyiRLh6LgZpqRi6jYVtDs/z/KXRiBWQYRR1ldPBxkgwaCl8EnbIKmJn1WyzwkS8xBv3nrrD2iRVdKJCDVODCk+BC7mAOKiWxcIt6OU7nUCRFVj1e+fWYjOzFqdUG3mdi2oyP71OCYVwE4ESM31+gjK6Yn/Fqr3AB7CahzqKCnvxBGeKZciPxm283TtfyKyqPKklRM4awlGo5eGDmpsk6MnzCw+Qgh7E7WyrXiLbmYV3666dHmF6TMXHa8XW2OaAZAvud038QtTyArU7jUsNrlMgQguAwLTb9pGX9HsomA0LL3MP6r+WVYTut+fqynY7ZD8PdTihFBKslJAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfKecSETS/b4wU9X5FKuOCAUxuXCmRfP6fvc/zYkvTw=;
 b=Gs2Ek7yQ848zkzph9E3mNGMNteJ3iH1rtTe0OcrdFpp7sxf9Dss+sDERSQ2gnAT/Ggx6nxBfJtOa2A0mzJLnqIhZDjkIOfw3KL3QR+pKgbX5dmHM8rt2Agszhtxu2HMQqUsbfPKBWJmiWwtzZShMYQF6YDhYZo5SnLOvjlCFxDNF5FVyJ5ZhmCS9vmdQccekRCI9o7AeeTrEK0ZNjFq3zb71TZwT8LU35UR5TYS8R/kNvQoY5Pw4F4gN1/kOPvITilmNTkQIE97wBD1MI2TYcHTdlXQ81mM+swaXXK/acJFWYaPdOz4UvcUzAncSsRUEmFfS03X4jMPm9uUGZSXx+g==
Received: from SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:9b::8) by
 SY7P282MB5248.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:2a9::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.33; Mon, 22 Jul 2024 17:02:15 +0000
Received: from SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ac24:7d2b:92fe:20c3]) by SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ac24:7d2b:92fe:20c3%4]) with mapi id 15.20.7784.017; Mon, 22 Jul 2024
 17:02:15 +0000
Date: Tue, 23 Jul 2024 01:02:04 +0800
From: Yuntao Dai <d1581209858@live.com>
Subject: Re: [PATCH v2 3/3] mailbox: sophgo: add mailbox driver for cv18x SoCs
To: Samuel Holland <samuel.holland@sifive.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "unicorn_wang@outlook.com"
	<unicorn_wang@outlook.com>, "inochiama@outlook.com" <inochiama@outlook.com>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "palmer@dabbelt.com"
	<palmer@dabbelt.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
Message-ID:
 <SYBP282MB22386A7684FB826F157C67E5C4A82@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <dca205a1-46cc-4712-bdb1-15517e63e824@sifive.com>
References:
 <SYBP282MB223825D5903777B937A8A377C4A02@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
	<SYBP282MB2238F93565D20F0A5F3EEB6BC4A02@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
	<dca205a1-46cc-4712-bdb1-15517e63e824@sifive.com>
X-Mailer: geary/0.12.4
Content-Type: text/plain; charset=us-ascii; format=flowed
X-TMN: [pDOOL9/nnm8H5xyr+FqLwCzp8UzGIcwZ]
X-ClientProxiedBy: OSBPR01CA0115.jpnprd01.prod.outlook.com
 (2603:1096:604:71::31) To SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:9b::8)
X-Microsoft-Original-Message-ID: <1721667724.5328.0@smtp-mail.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBP282MB2238:EE_|SY7P282MB5248:EE_
X-MS-Office365-Filtering-Correlation-Id: 787cf440-bd4f-45e7-47d6-08dcaa7009b4
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwV1Kpn5lySAyQJsGKcMyMICraVN9ygnqUoPv91HF28w6S7wvzqARd1rO0Q1Y0a+7Y9wSUatx2qnRPXdkyNTNDQUFbN2nDddvn1kilOHS6IDAn1ZL/GNxNSM/7XjCz5mWD4SqpSJN/yKkOF2i1q4EjISZnlVketfJbISSYf7JXZTDw/ATZz5RPlpQ4Bh5D+Qfh8h+bZeyFiD5yCyB/mcjRJepDm2/R6qfiTanqAUtDpq/jcQV3mEFxOjxmH8P0C6ZtRVdWyZz0omdqgEh6ARKUo2OXmNBEh9wj2OtPvwc2PlHoWA9fLRCbXjNB9DXrjNgPsaN67Xtfj34dmoGx3vOR0aje9YKHHX3vNHk0MC3UTNmwAppQRd+RwTpMvd7d7km4fh6FYZvSGxVTqpqmnAEObtlkDmNQasXaL/DpgRdOBdtluRHtKRGZV8vqelkDcflHS6GiUfgKyJcWRRWqROAmmXs4uWMZ/CdmCOfzJDBrRP3OBtcXsYGMXzSWWdfhe6mzIs/vPuhTfcsQlXdRbrSihMFS6ZLbRsSFdUMB/K4nGdYmUA4i4N3a9mmr+3fJGhucjIKIirqlpA4+VVnOSeOnM705NjdNnjMk89PchCN5cNceCpTkpA/mJdKSa8VQtKghu+Z0eXkfzbhtq6vpAa+WA0EyZ2vfKdq3cSHwOGfW2SONEgFD0mHAQ5wIXgfjxSTU0rPywTzG73psPZsJU8U7vXyhmmiLjG0P672uk5HprazPpy6MaQeIe1rAAQ4WNIEjw=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|461199028|440099028|4302099013|3412199025|1602099012;
X-Microsoft-Antispam-Message-Info:
	dFKgs93EoixoOP0Wm0mUnDF6toSA9CH6hOYYq6PXiDi2fOQSrzoqK+2RfCVo7fOEMVTOxXyXnV3BeFj7PfYA4W3gCwUJDCkhALpUsVy/QFm4q6zOm4Y9NxtbDBFHlM7zX7XmCSbzaHyCeonyVAVNps3RYHvZYdHJEpEM/nf9gUg769rQaGtJsvqg4N5Nb/5gb8zraj3A7B/cpc0ASG3yLN+4kWCgaJY2EbZBvmh7RcaXx1sR4Lss/wILg+Y0aR+q08BJpKnf3Vi9wiaQYs7wx7/AtS3aYbzrGsy1c1vOIDL9CLN+Z8WuNmU4RKvdXiTe6D0TqJFlx+6iWMi8hubc5UNP4cSs3fVxKFLmDodXCnv+EQtQ0xFB117vZnI/oFy4O+7jwwKtmTKWR28yC7opGJlWLX2JMKFi7eCcpW8HX2d0qjZ06aX1sjGpr0MbTA3sTdrYGurrRL2mnU8jQorisu/e5xV3Y+Elfy8MNokr6Ubz/eDP/zKQxr1Qj/fVxQZluhY9DD6y6pdLQ5RSCd+nMv3gDLVxNVUgSDmCO6O6Mw7xFPHXANytZN7BE3tet2YE9y7HcTK9j2XBZOqtbmi1O/kKd9IgIGTlVS/K7Z6jz1O1MkCwoj4s0HNN2tssF1Dxo4g08QB1pYu703btY8Ym65qgQn/MZncET8evdgXGGyP2W14WYRS6nKhXpWk0NfVJpk7YhOGCOLxfCi//hHJYF6KC+7yKtON2U/WftulJMXuYlYzECmG3IqPIF0eL6MF/sqP/aMOPTA3AzG28NEg+SA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sMa+9cQ+ByRjLAFWETCk5sEWNOs8M47lFtqmA2rlMAafvIbfMdMLKYiW5XLk?=
 =?us-ascii?Q?8TUvGVyR2JYGEH4bRjeMe9JELojI4REgH5YsggstDp2nDf38mBCpFN9VgjlD?=
 =?us-ascii?Q?gz0SqLih5M5Rh2t25cEeOT3lBoh7QpV+Jbwpbyw2rqs0/oqIAF4CDN+ZlEaJ?=
 =?us-ascii?Q?5XK36fCYLKqYZhzuAoFi0EZCA+87mU697QkemG0quNt3lXVbDKBSGfCnrsZq?=
 =?us-ascii?Q?7CK7AlHzUO4uzlN6RMaENr+MvPgVzDAo7mzhSOn5C4lojBJPe0qDiUPLPnkG?=
 =?us-ascii?Q?D+J14t1Wp6xpAjvl8LMFSmdKgb/wZvtO4XCt7SNLBwqZG2m0UfJOTkK5AbA3?=
 =?us-ascii?Q?l+wg08IpKQfWxq3td/r1nJk/NB/vRHTfbuk/N8nUt4GjwFviah0eLB0lcvMv?=
 =?us-ascii?Q?dQeTtLSNTUInmERnjHzHh8isftWsisjDU24HQ5vtRRXhLKYvSSIaydiMqCrQ?=
 =?us-ascii?Q?lw7ATZfnrAt1Nq+62BlQg1jkMXmiF+jncvqyqy+UgrLkiAyvjy4ybLrCKMtK?=
 =?us-ascii?Q?gfGn/MNKa5eOPVneguOykUoIF/f+O3aiTNWDGv4IJ3NqX2G7+tX3UHQ3a9dw?=
 =?us-ascii?Q?GCb6BQk4nRagHGjmUgeAwJNS/ibCCUHxoReH9e2FXSu6oNImAvHAsvUOuYq0?=
 =?us-ascii?Q?uhNED0igAo3+VVVq5qISbcxQcAXfbhE1a23zfrlyIMMy/nOFyfDz2hB3NPlv?=
 =?us-ascii?Q?YRBpEeOwrC8ZkFCfXnivxcMb4YFWSo28ZixSsdplOSfGsJi8lujfXGVu+0i4?=
 =?us-ascii?Q?ebGYb57vE9v2TBT/1ivBzqjiVHWVnmjS+hCl23kwSpQ4KrTuZ45OKORLBqQj?=
 =?us-ascii?Q?njrh3S7MLZdwje8kqVSzqK+453AApFtAu9TdxM6Lv1JavWgLGmFf8UHseD14?=
 =?us-ascii?Q?qXktCl1P2bojzwugs4d1GTYFZSAWcWXJyZEqZXHVt+xG1qOllO3vfO9qLY1Q?=
 =?us-ascii?Q?VtIHBgri5W6O4eZxyFFu/PaXvSoOcaqm8ReSxe7XPQiFbsXVWIUjvFdKlYgy?=
 =?us-ascii?Q?emlUGUC9BEeJ5tNEMSaZr5+aBr69NmWKjAHKTync37dqJDymwJfBle5bukAI?=
 =?us-ascii?Q?w8HmNQVpUixDLVOp6GUDeLo4QhGbPyNj8WOFBvNm1wTR28HVRo0gcPMV2JIy?=
 =?us-ascii?Q?HsL5KDS+x6p6E3ZfrhnxPsBlYXIQKfPfFB43S+RbUR4O8xaC9ruiozKUha+h?=
 =?us-ascii?Q?FJZGiH0Lpzl3UTOyEu+X55t6iktZEZjVeZFqOa4Xy/6x+oAiwbO+ER220YE?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-722bc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 787cf440-bd4f-45e7-47d6-08dcaa7009b4
X-MS-Exchange-CrossTenant-AuthSource: SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 17:02:15.7902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P282MB5248


>  From: Samuel Holland <samuel.holland@sifive.com>
>  Sent: Friday, July 19, 2024 09:35
>  To: Yuntao Dai <d1581209858@live.com>
>  Cc: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; 
> devicetree@vger.kernel.org <devicetree@vger.kernel.org>; 
> linux-riscv@lists.infradead.org <linux-riscv@lists.infradead.org>; 
> jassisinghbrar@gmail.com <jassisinghbrar@gmail.com>; robh@kernel.org 
> <robh@kernel.org>; krzk+dt@kernel.org <krzk+dt@kernel.org>; 
> conor+dt@kernel.org <conor+dt@kernel.org>; unicorn_wang@outlook.com 
> <unicorn_wang@outlook.com>; inochiama@outlook.com 
> <inochiama@outlook.com>; paul.walmsley@sifive.com 
> <paul.walmsley@sifive.com>; palmer@dabbelt.com <palmer@dabbelt.com>; 
> aou@eecs.berkeley.edu <aou@eecs.berkeley.edu>
>  Subject: Re: [PATCH v2 3/3] mailbox: sophgo: add mailbox driver for 
> cv18x SoCs
> 
>  On 2024-07-14 11:36 AM, Yuntao Dai wrote:
>  > Add mailbox controller driver for cv18x SoCs, tested on 
> mailbox-test
>  > client.
>  >
>  > Signed-off-by: Yuntao Dai <d1581209858@live.com>
>  > ---
>  >  drivers/mailbox/Kconfig          |  11 ++
>  >  drivers/mailbox/Makefile         |   2 +
>  >  drivers/mailbox/cv1800-mailbox.c | 203 
> +++++++++++++++++++++++++++++++
>  >  3 files changed, 216 insertions(+)
>  >  create mode 100644 drivers/mailbox/cv1800-mailbox.c
>  >
>  > diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
>  > index 3b8842c4a..db856ec7e 100644
>  > --- a/drivers/mailbox/Kconfig
>  > +++ b/drivers/mailbox/Kconfig
>  > @@ -286,4 +286,15 @@ config QCOM_IPCC
>  >          acts as an interrupt controller for receiving interrupts 
> from clients.
>  >          Say Y here if you want to build this driver.
>  >
>  > +config CV1800_MBOX
>  > +     tristate "cv1800 mailbox"
>  > +     depends on OF
> 
>  This dependency is not necessary once the probe function is fixed 
> (see below).
> 

I will fix it.

>  > +     depends on ARCH_SOPHGO || COMPILE_TEST
>  > +     help
>  > +       Mailbox driver implementation for Sophgo cv180x SoCs. This 
> driver
>  > +       can be used to send message between different processors 
> in SoC. Any
>  > +       processer can write data in a channel, and set 
> co-responding register
>  > +       to raise interrupt to notice another processor, and it is 
> allowed to
>  > +       send data to itself.
>  > +
>  >  endif
>  > diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
>  > index 5cf2f54de..2c6db8c5c 100644
>  > --- a/drivers/mailbox/Makefile
>  > +++ b/drivers/mailbox/Makefile
>  > @@ -62,3 +62,5 @@ obj-$(CONFIG_SUN6I_MSGBOX)  += sun6i-msgbox.o
>  >  obj-$(CONFIG_SPRD_MBOX)              += sprd-mailbox.o
>  >
>  >  obj-$(CONFIG_QCOM_IPCC)              += qcom-ipcc.o
>  > +
>  > +obj-$(CONFIG_CV1800_MBOX)    += cv1800-mailbox.o
>  > \ No newline at end of file
> 
>  Please add the missing newline.
> 
> 

I will fix it

>  > diff --git a/drivers/mailbox/cv1800-mailbox.c 
> b/drivers/mailbox/cv1800-mailbox.c
>  > new file mode 100644
>  > index 000000000..a3b214b4d
>  > --- /dev/null
>  > +++ b/drivers/mailbox/cv1800-mailbox.c
>  > @@ -0,0 +1,203 @@
>  > +// SPDX-License-Identifier: GPL-2.0-or-later
>  > +
>  > +#include <linux/device.h>
>  > +#include <linux/err.h>
>  > +#include <linux/interrupt.h>
>  > +#include <linux/io.h>
>  > +#include <linux/kfifo.h>
>  > +#include <linux/mailbox_controller.h>
>  > +#include <linux/mailbox_client.h>
>  > +#include <linux/module.h>
>  > +#include <linux/platform_device.h>
>  > +#include <linux/slab.h>
>  > +
>  > +#define RECV_CPU 2
>  > +
>  > +#define MAILBOX_MAX_CHAN 0x0008
>  > +#define MAILBOX_DONE_OFFSET 0x0002
>  > +#define MAILBOX_CONTEXT_SIZE 0x0040
>  > +#define MAILBOX_CONTEXT_OFFSET 0x0400
>  > +
>  > +#define MBOX_EN_REG(cpu) (cpu << 2)
>  > +#define MBOX_DONE_REG(cpu) ((cpu << 2) + MAILBOX_DONE_OFFSET)
>  > +
>  > +#define MBOX_SET_CLR_REG(cpu) (0x10 + (cpu << 4))
>  > +#define MBOX_SET_INT_REG(cpu) (0x18 + (cpu << 4))
>  > +
>  > +#define MBOX_SET_REG 0x60
>  > +
>  > +/**
>  > + * cv1800 mailbox channel private data
>  > + * @idx: index of channel
>  > + * @cpu: send to which processor
>  > + */
>  > +struct cv1800_mbox_chan_priv {
>  > +     int idx;
>  > +     int cpu;
>  > +};
>  > +
>  > +struct cv1800_mbox {
>  > +     struct mbox_controller mbox;
>  > +     struct cv1800_mbox_chan_priv priv[MAILBOX_MAX_CHAN];
>  > +     struct mbox_chan chans[MAILBOX_MAX_CHAN];
>  > +     u64 __iomem *content[MAILBOX_MAX_CHAN];
>  > +     void __iomem *mbox_base;
>  > +     int recvid;
>  > +};
>  > +
>  > +static irqreturn_t cv1800_mbox_isr(int irq, void *dev_id)
>  > +{
>  > +     struct cv1800_mbox *mbox = (struct cv1800_mbox *)dev_id;
>  > +     size_t i;
>  > +
>  > +     for (i = 0; i < MAILBOX_MAX_CHAN; i++) {
>  > +             if (mbox->content[i] && mbox->chans[i].cl) {
>  > +                     mbox_chan_received_data(&mbox->chans[i],
>  > +                                             mbox->content[i]);
>  > +                     mbox->content[i] = NULL;
>  > +                     return IRQ_HANDLED;
> 
>  Are you sure you only want to handle one channel per interrupt? 
> Should this be
>  "ret = IRQ_HANDLED;" or similar instead of early return? The same 
> applies to
>  cv1800_mbox_irq().
> 
> 

I believe this approach can simplify the implementation. I utilize 
IRQ_ONESHOT to
prevent interrupt racing, thereby avoiding the need for locking 
mbox->content in
this scenario. And I see rockchip mailbox did the same thing.


>  > +             }
>  > +     }
>  > +     return IRQ_NONE;
>  > +}
>  > +
>  > +static irqreturn_t cv1800_mbox_irq(int irq, void *dev_id)
>  > +{
>  > +     struct cv1800_mbox *mbox = (struct cv1800_mbox *)dev_id;
>  > +     u64 __iomem *addr;
>  > +     u8 set, valid;
>  > +     size_t i;
>  > +
>  > +     set = readb(mbox->mbox_base + MBOX_SET_INT_REG(RECV_CPU));
>  > +
>  > +     if (!set)
>  > +             return IRQ_NONE;
>  > +
>  > +     for (i = 0; i < MAILBOX_MAX_CHAN; i++) {
>  > +             valid = set & (1 << i);
>  > +             addr = (u64 *)(mbox->mbox_base + 
> MAILBOX_CONTEXT_OFFSET) + i;
>  > +             if (valid) {
>  > +                     mbox->content[i] = addr;
>  > +                     writeb(valid,
>  > +                            mbox->mbox_base + 
> MBOX_SET_CLR_REG(RECV_CPU));
>  > +                     writeb(~valid, mbox->mbox_base + 
> MBOX_EN_REG(RECV_CPU));
>  > +                     return IRQ_WAKE_THREAD;
>  > +             }
>  > +     }
>  > +
>  > +     return IRQ_NONE;
>  > +}
>  > +
>  > +static int cv1800_mbox_send_data(struct mbox_chan *chan, void 
> *data)
>  > +{
>  > +     struct cv1800_mbox_chan_priv *priv =
>  > +             (struct cv1800_mbox_chan_priv *)chan->con_priv;
>  > +     struct cv1800_mbox *mbox = dev_get_drvdata(chan->mbox->dev);
>  > +     u64 __iomem *addr;
>  > +     u8 en, valid;
>  > +
>  > +     int idx = priv->idx;
>  > +     int cpu = priv->cpu;
>  > +
>  > +     addr = (u64 *)(mbox->mbox_base + MAILBOX_CONTEXT_OFFSET) + 
> idx;
>  > +     memcpy_toio(addr, data, 8);
>  > +
>  > +     valid = 1 << idx;
>  > +     writeb(valid, mbox->mbox_base + MBOX_SET_CLR_REG(cpu));
>  > +     en = readb(mbox->mbox_base + MBOX_EN_REG(cpu));
>  > +     writeb(en | valid, mbox->mbox_base + MBOX_EN_REG(cpu));
>  > +     writeb(valid, mbox->mbox_base + MBOX_SET_REG);
>  > +
>  > +     return 0;
>  > +}
>  > +
>  > +static bool cv1800_last_tx_done(struct mbox_chan *chan)
>  > +{
>  > +     return true;
> 
>  Shouldn't this check MBOX_EN_REG(priv->cpu) or similar to check that 
> the
>  receiver has read the message?
> 

Yes, I think check MBOX_EN_REG(priv->cpu) is a good way to ensure 
content
has been writen into hardware. And I think driver should only send the
message and upper layer is responsible for ack and things like that.

There is a vendor implementation of linux mailbox and RTOS mailbox:
https://github.com/milkv-duo/duo-buildroot-sdk/blob/develop/linux_5.10/drivers/soc/cvitek/rtos_cmdqu/rtos_cmdqu.c
https://github.com/milkv-duo/duo-buildroot-sdk/blob/develop/freertos/cvitek/task/comm/src/riscv64/comm_main.c

These implementations define a protocol structure for communication 
between
linux and RTOS, the linux mailbox controller just need to provide API 
for
client and do not consider the content of msg.


>  > +}
>  > +
>  > +static const struct mbox_chan_ops cv1800_mbox_chan_ops = {
>  > +     .send_data = cv1800_mbox_send_data,
>  > +     .last_tx_done = cv1800_last_tx_done,
>  > +};
>  > +
>  > +static struct mbox_chan *cv1800_mbox_xlate(struct mbox_controller 
> *mbox,
>  > +                                        const struct 
> of_phandle_args *spec)
>  > +{
>  > +     struct cv1800_mbox_chan_priv *priv;
>  > +
>  > +     int idx = spec->args[0];
>  > +     int cpu = spec->args[1];
>  > +
>  > +     if (idx >= mbox->num_chans)
>  > +             return ERR_PTR(-EINVAL);
>  > +
>  > +     priv = mbox->chans[idx].con_priv;
>  > +     priv->cpu = cpu;
>  > +
>  > +     return &mbox->chans[idx];
>  > +}
>  > +
>  > +static const struct of_device_id cv1800_mbox_of_match[] = {
>  > +     { .compatible = "sophgo,cv1800-mailbox", },
>  > +     {},
>  > +};
>  > +MODULE_DEVICE_TABLE(of, cv1800_mbox_of_match);
>  > +
>  > +static int cv1800_mbox_probe(struct platform_device *pdev)
>  > +{
>  > +     struct device *dev = &pdev->dev;
>  > +     struct cv1800_mbox *mb;
>  > +     int irq, idx, err;
>  > +
>  > +     if (!dev->of_node)
>  > +             return -ENODEV;
> 
>  No need for this check.

I will fix it

> 
>  > +
>  > +     mb = devm_kzalloc(dev, sizeof(*mb), GFP_KERNEL);
>  > +     if (!mb)
>  > +             return -ENOMEM;
>  > +
>  > +     mb->mbox_base = devm_of_iomap(dev, dev->of_node, 0, NULL);
> 
>  Please use devm_platform_ioremap_resource() here, which abstracts 
> away the OF node.

I will fix it

> 
>  > +     if (IS_ERR(mb->mbox_base))
>  > +             return dev_err_probe(dev, PTR_ERR(mb->mbox_base),
>  > +                                  "Failed to map resource\n");
>  > +
>  > +     mb->mbox.dev = dev;
>  > +     mb->mbox.chans = mb->chans;
>  > +     mb->mbox.txdone_poll = true;
>  > +     mb->mbox.ops = &cv1800_mbox_chan_ops;
>  > +     mb->mbox.num_chans = MAILBOX_MAX_CHAN;
>  > +     mb->mbox.of_xlate = cv1800_mbox_xlate;
>  > +
>  > +     irq = platform_get_irq_byname(pdev, "mailbox");
>  > +     err = devm_request_threaded_irq(dev, irq, cv1800_mbox_irq,
>  > +                                     cv1800_mbox_isr, 
> IRQF_ONESHOT,
>  > +                                     dev_name(&pdev->dev), mb);
>  > +     if (err < 0)
>  > +             return dev_err_probe(dev, err, "Failed to register 
> irq\n");
>  > +
>  > +     for (idx = 0; idx < MAILBOX_MAX_CHAN; idx++) {
>  > +             mb->priv[idx].idx = idx;
>  > +             mb->mbox.chans[idx].con_priv = &mb->priv[idx];
>  > +     }
>  > +
>  > +     err = devm_mbox_controller_register(dev, &mb->mbox);
>  > +     if (err)
>  > +             return dev_err_probe(dev, err, "Failed to register 
> mailbox\n");
>  > +
>  > +     platform_set_drvdata(pdev, mb);
> 
>  cv1800_mbox_send_data() could be called even inside
>  devm_mbox_controller_register(), so this needs to be moved up.

I will fix it

> 
>  > +     return 0;
>  > +}
>  > +
>  > +static struct platform_driver cv1800_mbox_driver = {
>  > +     .driver = {
>  > +             .name = "cv1800-mbox",
>  > +             .of_match_table = cv1800_mbox_of_match,
>  > +     },
>  > +     .probe  = cv1800_mbox_probe,
>  > +};
>  > +
>  > +module_platform_driver(cv1800_mbox_driver);
>  > +
>  > +MODULE_DESCRIPTION("cv1800 mailbox driver");
>  > +MODULE_LICENSE("GPL");
> 


