Return-Path: <linux-kernel+bounces-428982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8529E15D4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ADC1281049
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51AA1D86C6;
	Tue,  3 Dec 2024 08:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="p/e5Qn7q";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="p/e5Qn7q"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012052.outbound.protection.outlook.com [52.101.66.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9513F8F7
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 08:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.52
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733214737; cv=fail; b=CQ4Og5Tf1cMyfCZ+TmEHGcbjNE0IPesgFfHvOd0sCUbXLeog4ud9Qi/EGUh/m8brjhDaYTLMqFfBw4Q0Zk3ca/l7T9qXpvGcXFWzY75GXdByBHy4Kz/QGYaMD2pRHk5qeXs4I1X6aGSLFzy0yAf9NIPHf/Va1W7q/dLjN7SyFV8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733214737; c=relaxed/simple;
	bh=+Ovzw4oVBxKJdsVrMXlBe6NPWdDKNTyRgcuLxZrCYR0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=THOym63m2MriQFEeMmZyKB2qHFCF0TSG5LJTkW3Y7IHJiAlPvksCi433hRQ0KULJpBaneBGOYMNaTcztY1ysk8GYRyHtOIyl1y0omkRNkCMoCZ4Dl56bUeSlZJKxHCb4sHEguPDtA3A7JyZgAlMHGUwEn4qeKFt1A/wJTQxWsK4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=p/e5Qn7q; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=p/e5Qn7q; arc=fail smtp.client-ip=52.101.66.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=kSq8+a6T8enZ6COke5MqlT4Ui7zWcAlztwicl/wnPWlMfczw8Ubsbrf91q4IFpzVMyp5mdthwLv1kjV7lUbTujan6knRAbOCW79ykXbJB0HXGzG8RzMhc5Y/eXaKLT7DJpU+chRiZj+q+HIGkaq+rf3LN6qyNbfaP63zoJ63uO202qEIVnzb4J4rlj/5K3X4T1vE1eT2WcFPDjZfMLZx+62SxN4caTn63XLEjrYRQgbQqfNCv7uLpSTLgXz8W6acdogdMqM3EVqYtqrIB1o9wqvsZPmHJlY38DEuHXDQcUvhEte8lEq2DCNKNKZv5jCg+BJMBJIdfBQH5I/LpRwDIQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Ovzw4oVBxKJdsVrMXlBe6NPWdDKNTyRgcuLxZrCYR0=;
 b=Y9O9NL4/syvOcw1WpkmvykKs42qqM9gq4yLvqHXOMgWUCbN2Y/frgjGWuW3/Cur2yV+CWAxSBE6zF1IuUppfgPRgteojf7f5qbDgj0qGICGdJytukyUVyinzf8BTl2UE8go6U1Up6S9nP7EFcUH1e3e46ePXl2GkwceKZwrmg4CJD8v+QCu0WdAYu0z1PBPrGzyi/QHeM4IcxEeqWVQPuZD3HXWzc1wnRMtQWN6oukZfTHkRnnwrC3yy4xxUB5JiokNzVMsXBzT9AkJX2V2LtY87vZS3Bms6/NianjKzmFymfiqu9Gp15gCCHVAb+JOXMCsowar/9nPJeMDepvXeLQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Ovzw4oVBxKJdsVrMXlBe6NPWdDKNTyRgcuLxZrCYR0=;
 b=p/e5Qn7q8ZDKF9+XngsrqC7fQgGL5KW0GP8qfjN0s9eYqNq6M4bbjJSkuJcf2ER3WcYezZ+zwQq/bd91bEkQIjT6Iw2mfCO4W5mMXltIVc5+UfYh+J8SceaO/4lmezRvNgZXhkowOBoF9szUoh5vFoqfhQQiF+MRu66AC5Q/HPg=
Received: from DB8PR04CA0028.eurprd04.prod.outlook.com (2603:10a6:10:110::38)
 by PAWPR08MB10308.eurprd08.prod.outlook.com (2603:10a6:102:369::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Tue, 3 Dec
 2024 08:32:10 +0000
Received: from DB5PEPF00014B9F.eurprd02.prod.outlook.com
 (2603:10a6:10:110:cafe::de) by DB8PR04CA0028.outlook.office365.com
 (2603:10a6:10:110::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Tue,
 3 Dec 2024 08:32:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5PEPF00014B9F.mail.protection.outlook.com (10.167.8.169) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7
 via Frontend Transport; Tue, 3 Dec 2024 08:32:09 +0000
Received: ("Tessian outbound 206fab1c37e0:v514"); Tue, 03 Dec 2024 08:32:09 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 63d13b2edf158995
X-TessianGatewayMetadata: 6idn/wc1W5aPcQPxdEUmG7UKUYesjo3IgxIozACPB+rSudKWn4JLdzOxLeeQSN1qZgOzHKF83oAZmv+0jUCl6gTnrVre88T47QYzSMquvgkZFTp9Cfe4fIxPLO37KcR/GvD/nP2ZH6sm2HjYHuRz/UULgF+Qao0puW3FpvHmShM/BclFHYH/TANbjsiEngQXsvZrwZgIBPaT2vybvqxvFA==
X-CR-MTA-TID: 64aa7808
Received: from Lf171e610a83f.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 43CEDD84-68D3-4C8D-92C1-4940468DFC96.1;
	Tue, 03 Dec 2024 08:31:57 +0000
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lf171e610a83f.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Tue, 03 Dec 2024 08:31:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=peoCTb3KHXFxbfhLFaaf+0Yamh0tl8nu9DvJPrp8u7X8LwJG9Jk8eWnWMFR+11yMxu0pmnZRLYjoBtgwa1lF47qMRRKqv5TUXzL+80TQb1rEFORLuzHIkodX3z8qYhW1STjhnHSvZc0veVG3DyYi3uNSOQN6A6tNamOKMscZl9Fs7y5a9Ka13ezGr9epcnEZAeRhQX1kcEQnDy1hkMURHwADtSsQetYM/cvXg6SZO9xRtjYTq+MFXV2Lizlwz/lQ2UgMUJn9xJQ2RiL8ERWMEGMH2OTwOopjOUz3hAH1lJzdgZOExloWAAEx8l0eStbjM9kB3fWKBeVWW3UEriJRRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Ovzw4oVBxKJdsVrMXlBe6NPWdDKNTyRgcuLxZrCYR0=;
 b=gV70LC+byJc4XWuLkgKByjnC7sMEJYTQeP/nv92akaYhXK0OB/+ve2lqYVHL4At4iLtycY+BMByZT5fci3LtWhpXNyfz9w/DUfDvIOc6kwVGw/mTPSzKki8sCmubetwGehlO1yPn9N71Ium7KH9Z3wY5DQDKnnjXH7MrXcwejkyNzsOs4X/0mKdIVf6nrQYvqcqJXVBbU4OwIkr/Cfwe5kWAy0TEhx2mZTpPbmc4hUyPOGDZzzYMeJCiwQ76/vmtuMsW8L/aGvaSBBqo8gv+sxPTfXrzgIQ90EZS10jZy4/knCNjvXY9mToSX0A6j6GrdMX1H7Mfh6skwU7dOouA1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Ovzw4oVBxKJdsVrMXlBe6NPWdDKNTyRgcuLxZrCYR0=;
 b=p/e5Qn7q8ZDKF9+XngsrqC7fQgGL5KW0GP8qfjN0s9eYqNq6M4bbjJSkuJcf2ER3WcYezZ+zwQq/bd91bEkQIjT6Iw2mfCO4W5mMXltIVc5+UfYh+J8SceaO/4lmezRvNgZXhkowOBoF9szUoh5vFoqfhQQiF+MRu66AC5Q/HPg=
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DB3PR08MB8795.eurprd08.prod.outlook.com
 (2603:10a6:10:432::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 08:31:55 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 08:31:54 +0000
From: Yeo Reum Yun <YeoReum.Yun@arm.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: Suzuki Poulose <Suzuki.Poulose@arm.com>, "mike.leach@linaro.org"
	<mike.leach@linaro.org>, "james.clark@linaro.org" <james.clark@linaro.org>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>, "clrkwllms@kernel.org"
	<clrkwllms@kernel.org>, "coresight@lists.linaro.org"
	<coresight@lists.linaro.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rt-devel@lists.linux.dev"
	<linux-rt-devel@lists.linux.dev>, nd <nd@arm.com>
Subject: Re: [PATCH 1/9] coresight: change coresight_device lock type to
 raw_spinlock_t
Thread-Topic: [PATCH 1/9] coresight: change coresight_device lock type to
 raw_spinlock_t
Thread-Index: AQHbPx8vuTignQOEcE2iGTau3pde/LLLYBwAgADpbc6ABtjNgIABGYcA
Date: Tue, 3 Dec 2024 08:31:54 +0000
Message-ID:
 <GV1PR08MB105212FEF9251CA2B3AAF7FFFFB362@GV1PR08MB10521.eurprd08.prod.outlook.com>
References: <20241125094816.365472-1-yeoreum.yun@arm.com>
	<20241125094816.365472-2-yeoreum.yun@arm.com>
	<20241127120954.0facd34f@gandalf.local.home>
	<GV1PR08MB10521520ABD7B72D92FD60DE9FB292@GV1PR08MB10521.eurprd08.prod.outlook.com>
 <20241202103853.26db0c13@gandalf.local.home>
In-Reply-To: <20241202103853.26db0c13@gandalf.local.home>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	GV1PR08MB10521:EE_|DB3PR08MB8795:EE_|DB5PEPF00014B9F:EE_|PAWPR08MB10308:EE_
X-MS-Office365-Filtering-Correlation-Id: 5143f114-ba81-449b-890a-08dd1374fa53
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?BMPQdsEu/sZ8SHA8VamLxwJfxC/Dhk8spbMAdE0AuGtONMADs/DjcZFzfk?=
 =?iso-8859-1?Q?xaZ1ZJXgq544uId+Ye4mZoMatEo2IccDSZ6mm66hiexBPaDvqykRHqwkSS?=
 =?iso-8859-1?Q?WLM8HfccNPvWxanYv0c01mbaGgCHzpIGv25bZ2nm37LQPezprI7DHpnIuV?=
 =?iso-8859-1?Q?s3wmUExlOQOkEG3b4ovpSDglziFy0Pm6pd4WGE9uVXbLXDzDIdZxAp0eHA?=
 =?iso-8859-1?Q?nwIoXBukYBnubHszXsUV01FU+WzgH3GIJHzp0RObVaBpuLkWYKu3KafhT6?=
 =?iso-8859-1?Q?74zIAS71Ttz5CR8jafzStrwXP/zat5A5gkKUYNSOCchS2qEIDmxmI+75/1?=
 =?iso-8859-1?Q?W3mIuDU4wxx6vMpwN3OM5D8aFcDF9K18MGgP/hNyBFPhuaAef8NBwgmEX4?=
 =?iso-8859-1?Q?KsCMxT0pwznp/yEDUkkhRGinHN0XqkC0JvOSydZwBnIyzFBqrpoKWud+bd?=
 =?iso-8859-1?Q?FQLDV5fwWV0FPDACYSMsp6Hs0AUUpSEpVDDqCQ1wnVY3+AYDqnl8SIIZDH?=
 =?iso-8859-1?Q?NJOEk/05Adc54/QbDV3hbPydKVKO1B6CHY7N6Ucg5X9z/yXJ6L7ToU7CQb?=
 =?iso-8859-1?Q?c4+ug1QKhWTG/xXbHfQYCGQrTzP4tor04hsRPEF2lX9YuObIbPqX+RKrzx?=
 =?iso-8859-1?Q?J3LGvRABipI/RTMosGMVZQs8BAH4t7k0zoEHiRgmzOHoYJewJYrAlbX79g?=
 =?iso-8859-1?Q?QBi/g9GwobiUAsC8LdHmbcW0BZAVQ1Ly0iqN9ooVHW1we/bB1+7I3FGSGI?=
 =?iso-8859-1?Q?V6VFiH+8lBqDzhGexU7sB1dETGQx2wJv1R9jcFkasHEZi2k5Lo2k8G9C2H?=
 =?iso-8859-1?Q?m1MnDSlR7Qu7+2ZSmCMUE+VBdPrqPmEVJZPu9lJcB3efivvRyROTyP0dcR?=
 =?iso-8859-1?Q?bKZJbZ4UJy8zcFCVUzXtCU3YdI0OGOPQZ3rUTWi3m+GmPR20bSkktk0Fpa?=
 =?iso-8859-1?Q?+A9bTYyQAW81qymNbtJGppQNl2Vf+Gr9oor9WPMqV2GixAf9yGIGP3uhOv?=
 =?iso-8859-1?Q?5DcVnuLSDE+bjkn/UQQICJ8vIOVX4C/l48ddd2CpGy4tpzQMrn0dSYQRJR?=
 =?iso-8859-1?Q?e+Kva36VWo5rJ2gy36VJp2ot4A+V5DuWbn39VuITdoK3uJ9kSRonu8TxPm?=
 =?iso-8859-1?Q?S2fsA2x6R5JHEjkRMdHWg4vaOe55sE5E70vnYIr0Ktio9DywYSYSm5yLgF?=
 =?iso-8859-1?Q?tR66JEo7ibARb/1VDZyKhT2KT4m+vzH+R55AP9fq7NxEuQKBW6or3uY5f0?=
 =?iso-8859-1?Q?6PZkKMDKouGTZDrGLyfLF2T1Kd7wgoJVLDr47AvPZwIJsCtvXEt2qTR7gL?=
 =?iso-8859-1?Q?M0br9lVjS8GPWmnH+2vkXCkafMtO9ZKaWYD1m+TA4vTQCylNu74c6MuUiD?=
 =?iso-8859-1?Q?0+3if/RHQHz6YABhzo0901g2RDTPiCsXuB+CrDQ1Vrr/D9jOkoSXRrrdpX?=
 =?iso-8859-1?Q?QszNhjPbottkhjhyoFUjlaV4jSH61ALUJuXYqw=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB8795
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B9F.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7b1c7170-b885-4190-890d-08dd1374f18a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|1800799024|36860700013|14060799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?tK3/dmf0b7GS56+X+X9P5mW1UgecyxZUSOnOGaJQv650cY9cveiZGjH7cz?=
 =?iso-8859-1?Q?aAzBY9Wb2lJPhGJYTrn0oflHbef2AGtwUQN3mOP4TXJq8wlEGVmsrHwPIp?=
 =?iso-8859-1?Q?BKyGvpuQgP6gQe1zXkHOJWcahkeRW5OIp7uN0JxvXoQRYmss5XKuTi7nun?=
 =?iso-8859-1?Q?g8s+JMdTo4kio/vvq0rP+CxgdOE1IVU4sKoGMxWt+lnXI7yADncNf/Fj+x?=
 =?iso-8859-1?Q?iCrqkE/KUriT/lq/m1elmnBx5ww+3cTfkv1dhLVpk8u7RxpQva0eL/uwWm?=
 =?iso-8859-1?Q?qA0v09o1DcbFWyaPSePH6p/XWgHom/Oz6fwjASu1SdN3Hrh//jVfhxzu2X?=
 =?iso-8859-1?Q?LwMKI7AaMHl936rXAv1Wzyoz7K2mF5Zqc+sVmdpYOybMGmkf/VuFOedYOB?=
 =?iso-8859-1?Q?QJreGNLl5Ajht+YLwFJtWGjW1viS0GifIQ4L9Rmbec/UdXAtgwNdFIl65h?=
 =?iso-8859-1?Q?ZXdkm6FWpVDQoG4eJi3JIHZN5R1crk4DweLy4XgvKiNmfr1uC0QroS1x+2?=
 =?iso-8859-1?Q?Yvp1DyQoYtMmRErDQ9Xw8qVMgJkHWG0opaP75pbKff+7A1FARNXGczZxI+?=
 =?iso-8859-1?Q?0qTzpwAfWEJCXSBP/LdJjj7eLHceC7Bs90ANLoontVAmQtP9M6jwgskvsN?=
 =?iso-8859-1?Q?VJ7Rs9J8ov9nDhGZATfbFik67OkbflBKXtZ0BwR/E9PTO2JuwImXHO/QaO?=
 =?iso-8859-1?Q?JipKrV81OPzOkNEWmzWPed1vcG4GVr39JRZB5xTbgu4dcunp83tT7ibFxF?=
 =?iso-8859-1?Q?y8/A2xZm2nHekQhpjFyA0TRo1MOAW6tCq4Hs98WclBBWWXbgrl2u7Ps2KI?=
 =?iso-8859-1?Q?CleUljyNLTRDP2BgFQIdRWMIwKpM7QNMLbWxoshNX11ibXJIDdS6npGzaH?=
 =?iso-8859-1?Q?9CHRiCLYHDwSTewzHMLpIWqJO0JR7nCMF8A4nPOON9dWtP2q9U87XO83pC?=
 =?iso-8859-1?Q?ze2MFbEQdWnXJwYYrjAsZeoFD7XSoNdU0zPchjliKQKjA+c0LgQA0OUEB2?=
 =?iso-8859-1?Q?bspE1Nur5d65uf1fr5Nwpq0FmM3xAzVLiiVAiqpZmc5WHskLfjV/FnpcgM?=
 =?iso-8859-1?Q?tozhqJfcF65saGwddy/rGB8xlyTRE7mqtLZAF2mm+V8jIGHNqoY1yCwYGn?=
 =?iso-8859-1?Q?HPKb2kxnA79DCAj5s6pAXO6UfR9WBGU/mY0YqwRVYGoTS5a+ARAEMiX9mv?=
 =?iso-8859-1?Q?r57KvFuCYe402KQOlLrh6E4xuwluDu+lin5AF0H62JFrLhXA4J0TjceCOQ?=
 =?iso-8859-1?Q?gjUsEws+4dDp68izCbxaoYMhNzdec1Ox/K2RLJLKtuW+Dm9xBCpmmmHmCH?=
 =?iso-8859-1?Q?QTkTsjr3cBTpQWRb2ASif3t8HPm6Cmr4K2V11Bj42ibTFIRiclQS/mIA1j?=
 =?iso-8859-1?Q?lpSOr0T86u+3eCVKKlrfp3euI5nCdl44qF5XIy1ISl9IgSZYe5w8aE1kS7?=
 =?iso-8859-1?Q?vRdcqUrK/KwNN5Mjt5VqoShImcFHtDrxTVjb6uK+UMbbSr5DirEjFB294J?=
 =?iso-8859-1?Q?nPoPoMoFlKjEIy9ioIX9yF?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(1800799024)(36860700013)(14060799003)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 08:32:09.3078
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5143f114-ba81-449b-890a-08dd1374fa53
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10308

Hi Steve,=0A=
=0A=
> Still should be documented somewhere. It should describe the maximum numb=
er=0A=
> of feats that will ever be loaded. If there's a max, it makes it back to=
=0A=
> O(1). With a 'k' of how long it takes to process the max number of feats.=
=0A=
=0A=
But with other patchset seems better=0A=
since not only this function, but also for other functions too.=0A=
=0A=
BTW, is there any example describing this I can refer? =0A=
=0A=
Thanks=

