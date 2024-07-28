Return-Path: <linux-kernel+bounces-264819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B90293E8CB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 19:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84DDE1F21A69
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 17:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF3B5F876;
	Sun, 28 Jul 2024 17:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="ZgANLmfU"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazolkn19010007.outbound.protection.outlook.com [52.103.64.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67534502BD
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 17:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.64.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722188331; cv=fail; b=QxSWk3frVOStj+mBdrf/VEC4PQb6Ikfkd3SE5NrM7hv6N1vli++uK+JshEnr3pOH50/ErGkNpGAshYzbJ5hHKtm4QFWC3lvmgA9FjZ4bcx/OI9EOqFzCqCWBlNII5typzYwgWz0Povmypueg1dqfvWht6c/pNwqRoiGiYCaE424=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722188331; c=relaxed/simple;
	bh=JEnqccgAGJ3aLha3CgRfTMuV2nGmKDxQRZXsgkI8ziw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iPdfEbtsQxj5xUW1onjPWE0CF3pgHY7jtsYnw4RyGuBX9NpT1CVqbFknWx2H3CjOBRXTi8mcZ5npVLXC4Wca9dA9++PwQObggqqDNshc3HC2G59zLkkrSRLZ7HC4yvznGttjuFbesdhJWbj82sWPKOfZvCX7dtSzt+F8Wah7Auc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=ZgANLmfU; arc=fail smtp.client-ip=52.103.64.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0jknEgbS6WkttvCy+klyAZAhY4oyqYZDco1M4u4eMRFQR5X+GPbKgqTbPiNrGQBYCsQO4w/gVAQdkxOR7my/WmJqC9FWJLYUXj+8DlCXfBHuDJkVA9XJ6dBq1jyEaRriaore9KI7oiCHv3t7g2+sqfuoUHr3XGWxPryJ2Hyv8Q8sdXG7s3Xhf6V5d/6aNX70DxutH+iT8ojJkNB1BBaRQjOOFBQMo45uw/Nl4KjvyMUAXNXSu5Dt+JJtd+0g4IRpZb7Ge+fnjKqMCL0NtF0fZxRqVqJSWX1CQVv5WnyJDBbdeYlcVa+dso4KUmEk44ErvWsJqnQ2l1QX1g9asswcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4s7I6nlLIdkbGS9FoGGdBG/wv5U2ai8CPvX4zqx2pU=;
 b=tB/kw4e7kiNTpPpY90APNRRAKUgWlq1QvrH6jbRW26PjRGJ3fmmgFPEktkDRmt7JpJtkMJuYLOnCaw6VQGbhImWdFtJfPgQWLGXs90GgoYuQITnMNOPUFn4TSN3LfWBFsYogEGXX8wqjffNlFb1LQSV3xAVksLge4Y06QO8A2HUm824GV4xoYn1Xz9H65LDuG8cR7z6qBqBTJeYlPL1O+ZhoZQPRi14Ish99yPN7+vv/Aaq/qZvg3ShN3AMMlkCo4OboqZoJ5Rej/8BJplfK+ZY83EOWRihDauHqS96Cfmg/dp+if5q6ZATIyMxCOPOblbmRMlCI4z8SfDK4jlqZrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4s7I6nlLIdkbGS9FoGGdBG/wv5U2ai8CPvX4zqx2pU=;
 b=ZgANLmfUy8cAUWZ+rRCJayRV4XdNhCIJEPPWqYEtjjkabBm1/zDnWHpEdswm5QFF1ThEeW/OyX9pH3HeIr9fy5qjzu7vyqykfbikPmRKVEm05lKmx6Jv74IzAoye/D4QD47iYa2IcNcWEiMU4jCBSxMuuujkFMSJkwE8gNp8POgH+yFJ6u+ol36EHKPQN9ksw9fYjTLH3KDf90+TUItL36dsZxgDLavdIe+SnONjSyrgK6s579r6FfehuM7ij1c6hW6UTD3XMo/8McwIQSvBVw6GDVVVPiASZaKKnjSH/TiqgCALcIfhM8kKHY8fxiKScfYImJKqNehJaMR2TOhhEw==
Received: from SEZPR01MB5894.apcprd01.prod.exchangelabs.com
 (2603:1096:101:1eb::14) by PUZPR01MB4881.apcprd01.prod.exchangelabs.com
 (2603:1096:301:fa::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.23; Sun, 28 Jul
 2024 17:38:45 +0000
Received: from SEZPR01MB5894.apcprd01.prod.exchangelabs.com
 ([fe80::962:33f:7247:222f]) by SEZPR01MB5894.apcprd01.prod.exchangelabs.com
 ([fe80::962:33f:7247:222f%7]) with mapi id 15.20.7807.026; Sun, 28 Jul 2024
 17:38:44 +0000
Date: Sun, 28 Jul 2024 23:08:38 +0530
From: Mukesh Kumar Chaurasiya <mchauras@hotmail.com>
To: buckzhang1212@yeah.net
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched:add panic to remind that wake_q_node should be
 WAKE_Q_TAIL when emtpy
Message-ID:
 <SEZPR01MB5894794E69717A19DAA68BAEDDB62@SEZPR01MB5894.apcprd01.prod.exchangelabs.com>
References: <20240717161901.2375-1-buckzhang1212@yeah.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717161901.2375-1-buckzhang1212@yeah.net>
X-TMN: [KxydXYFY2oIaEgnLAQ4upAhjqRflEY+Z]
X-ClientProxiedBy: MA0PR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::20) To SEZPR01MB5894.apcprd01.prod.exchangelabs.com
 (2603:1096:101:1eb::14)
X-Microsoft-Original-Message-ID:
 <ih6wfsts3ylnxfkqxt7ioz6cdfg6kio7be5opi6vomvk6isjqm@ggvdhuz3km2d>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR01MB5894:EE_|PUZPR01MB4881:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ef4b9b7-2ce9-4713-5962-08dcaf2c20a3
X-MS-Exchange-SLBlob-MailProps:
	Vs63Iqe4sQmRZ8qlr/ycpgAEOPKg7MYljM6DxOKDBl03RbiwuTFXlFnq6yIhCXJevXe2VYZoj/yTpn/mKe7q+pngzJS4RDuFSPFxaDJdjUT2cR2zwfWrUuurTEo+0Z9an5vTOC8s8et99JzAbKTF3V3oHsXEqC0WVgzCb7CxehD7qdg/hoih8Cv4gjubSxTrMlQ/o6jhRFwkTuMlezrIPAFmYZWd26qfaae/ZQcGl1G3u2vgPryCp1/0z3aBj6fLx9YGC5CZ3ikCy44yI6AA+MRuFBZzOh/sTz8vh/X2F6fnxPTUZSzVc5CJjvHS73umWH50Xuo5sJSV/A9xQ+suU4C+OhAAf5a4SLM1maw4Xqf24ce0fF1k0b8+bRbSUQN/Uikir3ofhVRCsN2WPOFF4VYBZDmGom9OUmRaFNF66Itt66Pfu6gffXLYpIcmWHVZJ7Lbx3gJfnO8xwvaKMlBMYJ+bggnD15o01BrPENKikrvi1o9HJXDt0vNmFJVVa+H9p69TYpPFLH+7KEWJQ2O1se+UNCsn/r4+tYaVY+ikGJgo8YuoZeYKcxMx/9x6gq3NH+tFNC/DujFtVCUrlXk+BXuGecZm0C+YSqqXRrtZjEco8w1Jc7Wv1GexRKH2CfM414fD4rxNnp0LsPtDBQwEWGj93q5222QcDcigRQ/LTexYmv/JUbBzWTdZez4eDywgm2efPUVhkQZu9MRpifYKeGpTS23uEpIDnMq/+Ufjok=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|5072599006|8060799006|461199028|440099028|3412199025|3430499032;
X-Microsoft-Antispam-Message-Info:
	wyJVHgrhRUlTsypa4xbUaZhn8HtsjGhuNQorP3kNhgwjVPNLgeLnltfRxa9sMKa+OAUFAmYles5tGDGZUja6AnUCu16aM45FCpzQj90xo7yYoFtNyMWiu24Dqy98z1mW641+oHXQxomVwXmstatPbzLmgSoMvvbnj/w6pHBYtE0k1aUU5TFRKzA+bOKiAaSYmoTrPzRxZontuDJzJ9KXxeHITNOUezv4zg2Tx+Q6EwXCL8XcXGYmIb8+wI9wFVIB8XlnKagQ+PyLgxuqFVr4h89G9fupefkKtzToXyH9EbRoAwsWvJH9nK3NTOVLY41pnJfSXnaiXcUuJ8qCGfkNy7a+osOjhdJJ3SlTU6yVDvGKASmzdkysslCwEB71ceSJiOWkgnQe1n8aSc9vp+cBqNSBX/v4WT9ZuIskvdvRXqqxH0gpDLwfHx1wDfzCVsRBADEeF4zeRZ+TSMwC5emYy+eY3SaABNl/9o9ZUgaB3VMRobZexyiHhoO7nStOFeE9ap/hiJu3HzuUrNJptyX7finWFxbbMuR5lkvIe2ZJacAir+se67rTqNCmeJgZVy+LzhxSR2Bw8HbVs1Q2+lZnWTDjeIG7Sf2aBp7Am2fEtOFMFNQJ7IjiB/ZZjpP7m4BLBJhChSWGwLY+0pX9Q/DJA4Tlt15ZgIP679dcitc2Ye8=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FgBkHWvsBpUb2Jt5lOvhvX2qtYxi/ZFWtMRXhtFPIYfucQ3TqWG1kjI/qXv+?=
 =?us-ascii?Q?vCAlZG1heBNEQTKh6JDvdY0ITNFJW+4tbjt0LyYL+rwsfAyt4JfpfQCpCezB?=
 =?us-ascii?Q?oHlj0mNSp+sV1LyoEozjzOgs5N6bd8FZDILqrVkSLSiIW/fM6biDgjX+XT0E?=
 =?us-ascii?Q?u3q3AvWErXpHEMdPNIg2bZRWTCHgk4u2yy5h4YJlbWZyx/It7UABidrGegdQ?=
 =?us-ascii?Q?OGGabbsWwIXA3ToXCdr6MdniDZxyTLpgzcj8IIBVJ4mxYZlcn6YBCA4UwBEr?=
 =?us-ascii?Q?MQ9evI62FFh3EGQ7PLJiYEUaHQJbqJhocnUTPLxekoeFHByTmCYAtItgLjnR?=
 =?us-ascii?Q?JKF00KA3OXjERCVZpiiWqL2CtTUqc5nCM4KyTkMPxnowA8fxAgNBlTDp1NKS?=
 =?us-ascii?Q?CkhMEDwLSsiZSh6EPzT5aLEJMBXsjBH8JnOBeNMSsXpQOd+c6tG4wbrV/bb9?=
 =?us-ascii?Q?nAQU4vM0EmPBio5cyGhdV4vfueQyUPvYq8WZRF9gOYMvi/5ki/O9iNRq4axu?=
 =?us-ascii?Q?/sAMmUgfY9tJsB7AxyhNi5wWpUCWArLXiKJYSipQZRaSOTq3c/ZI2SRoviSc?=
 =?us-ascii?Q?FI30WTFdHAY/HCTKN4wmhlDqkejOS8ZZpdL+jlfPZvoRI1vi90RZOYU4Nh0d?=
 =?us-ascii?Q?6sivumluBuS4uhArLcK691r5tdtY5MJLzkepKaqJUsEicK8uzwFTLyzOYQOE?=
 =?us-ascii?Q?QZjrX3dgeJLYPPwjMIT+1vQLWCgDwr/RfA/B0rivjOdbQbbrNuujgYjxEyIr?=
 =?us-ascii?Q?345neI27WnJ+ccYSte1qnD8AyMTCG9FNi22H1jaoX1lLp+L5020c5xcRkxag?=
 =?us-ascii?Q?HHZM6VBq9GQzc5jrZgCgl6r0Rw2WAEP0tlPn7SnWWkhCq4oEdSEfd9ULKWoZ?=
 =?us-ascii?Q?/pttvGbJR5ogfr92UhNW6KqTUpGCzfXEtdtRyGxqr6XuRKXV+4osQEYFIQ7i?=
 =?us-ascii?Q?x6Ork9m4jm8L3E4mwK+oYAKk7e9CKxGoIm6HAp8c4w4z33Gdor7UnhEFi4gf?=
 =?us-ascii?Q?UBpZ1z8FB6nVl0F+wdeZqBI99kJkvaCoNsoUrPvZ3rGGP+I4aTJwG9tvtHDS?=
 =?us-ascii?Q?H4cS8aayKAiwE5fwOcEuz8evR0vychaykTo/0UCUTHS2Vw7lU2KNwzid6ugQ?=
 =?us-ascii?Q?ig9JRk/IduJZ4Dqq0BMq+qfvCtfnNyhEWh0vk7T6xv4Xv0O6bIMwBUzXxEf2?=
 =?us-ascii?Q?pediJo9OZnjCoP0KMq/xsVI5nEny9sukSt9WP+tNErDsNvuG9H2I3Wu7Hfo?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-b4c57.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef4b9b7-2ce9-4713-5962-08dcaf2c20a3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR01MB5894.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2024 17:38:44.2788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR01MB4881

On Wed, Jul 17, 2024 at 09:19:01AM -0700, buckzhang1212@yeah.net wrote:
> From: "weihui.zhang" <buckzhang1212@yeah.net>
> 
> Here is a kernel exception ,wake_q_node is NULL.
> when wake_q_node empty ,it must be WAKE_Q_TAIL instead of NULL Logically.
> Maybe a hardware bitflip corrupted the node ,add panic to call attention.

Hey,

is there a way to recreate this crash?

Regards,
Mukesh

