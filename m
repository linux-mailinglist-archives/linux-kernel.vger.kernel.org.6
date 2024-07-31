Return-Path: <linux-kernel+bounces-268368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0646B9423CB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 02:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57830B23CDB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173DF4C7D;
	Wed, 31 Jul 2024 00:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="u/8nXPqT"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2099.outbound.protection.outlook.com [40.92.41.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915D7A41;
	Wed, 31 Jul 2024 00:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722385683; cv=fail; b=Thl0z4VlxlGlJ7XawbwrNJtRAFw0/P8c9/qCmW83H2i01dPxnPuY30u2WaqVSOPcwnohmQkrf2IsIeAHsXAcvZfaKhk2sGLthyjZsvO2kR1Dh1v8MGQtrvN09b6QCEucev0SPtmkrC1kZCnjX/ljgsc+mnRPkw4O6JXDzxAaKkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722385683; c=relaxed/simple;
	bh=GwHUmUsqfcWBshtD2ofV6hevhHefVnOdOnyWFQdcR1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=drTmRrc72QmKUTFc7jdqrDzkOVPySqIfp/jhCf3SewXTY4rduyDwKiItTD6DjdqdgHDyz9eZJQIW+D4B8aJWPlGmJ7kb9vkYPQy6UBx+XnPPBOytKMCZ0EZcCsdaU0OlA8J8rELFcitK1s/aqk1sGJJl04iemWxiHFxhzbrvj4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=u/8nXPqT; arc=fail smtp.client-ip=40.92.41.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+XLTk7rb5/cGmJL9zFt/tyFyKYAZkkS/AXVIuIn6ubVbCdUyXRoemvHlXTVaOB23WXYuAFv/MFSKbxY9/szItNTgswDW8OtHF7XGxgAK8X9zqlJljr8lj1EGGnZ6+nVvRRomsPXfTS5d82DSvmGK64gwbTzC+fARrpVjD2l4y+9wcDPeZKlXQ7mzNUFdgJjAIYz2eQMxPL6vXLwB5QmKAzawS+h2iz4sbOyM2aUI4sgmUPIxvU50syZdT+7oSrCggQIZraqsoN7AgnudVMksB3IMixTqyF+uAWwjGKRXkfQdTwFy8oqvtpeNemDpYpkCMPQuCYXPxK+UqRChfKORA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtA/h3XbPoYo08ss9/NSasrcJTfYdB3ENj+KvArer2U=;
 b=OQ3uRZiX9ZTvlgwKt/uSWcbiAH0qXixGC+3m8MCLlc3Q9sSWOgy9J6O9ZT1jep8kSGttWRn50+L5Y3q9+Qk4b9lDEJlgqWfd7+5MFEJqQzEMYpgYotnnjRVZV5XiXh8pUoqUjeKHWiIDu6122908zt966u08LmHg2tOFwG3h8YBPa2BjA/4feSOOUA+74dgnopf/RPy0HGKvPMtiln2FDrdyE9XjtAwMVnYk9SVOxKc7o3PGNwtM8QkdU9bP16gZgJ+f55h2D/Sl1zHsPGe6/QrPgTdLB3X5QXGCogr8UO2uBnp1l4Kk1cWkK55W8h9sk2IclymuVOy2Y7eLxVDYHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtA/h3XbPoYo08ss9/NSasrcJTfYdB3ENj+KvArer2U=;
 b=u/8nXPqTQF77FkYGt6TPYHxLvrbVl1QUIJMEWrlGdVPgUzciANtsmf94DaLp4288am0okRhHNQQo1411l3gYQFdlMZ8dDyqMYhDkB/c5Dj3Ucr1hCya1CfxLL1w8Gln67G4eV55LvzkAhu4wLeEUf1agPRYzcBTD/roorJKdh4Wmt0KbikjXA854m0vRAwoUI4jD15vVnghNIwgQlCAGG1LZRCRgWxUCuAJIWHnwXVYZgC/49BHD2eoIK4DEpnfu1w2IvubFwSkYpG4DITYiMKVCnc5Q7LWFT0qa6Ki9DRkQIWVdtzl47zjZYPmDoLKEGJv0WmVkzUNBMT26AHF8SA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by IA1PR20MB6431.namprd20.prod.outlook.com (2603:10b6:208:455::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 00:27:59 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 00:27:59 +0000
Date: Wed, 31 Jul 2024 08:27:31 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Chao Wei <chao.wei@sophgo.com>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] riscv: dts: sophgo: Add i2c device support for
 sg2042
Message-ID:
 <IA1PR20MB495370AE147A3FB567203178BBB12@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953DB82FB7D75BF8409FFF4BBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB49530E59974AF0FCA4FAB6DBBBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
 <MA0P287MB2822394D1E14A9EF41B190A2FEB02@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MA0P287MB2822394D1E14A9EF41B190A2FEB02@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
X-TMN: [PiJ72QEteaRPA8rjCWKSnP5vkjw/fCE2dGozprlVpiQ=]
X-ClientProxiedBy: PS2PR02CA0096.apcprd02.prod.outlook.com
 (2603:1096:300:5c::36) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <iuxn5huihubef22s3wkdfbfgicxtug72vlupqe5med6usjmgz3@nykyyul2es2z>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|IA1PR20MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d361e52-f5e5-4f2d-b021-08dcb0f7a137
X-MS-Exchange-SLBlob-MailProps:
	dx7TrgQSB6elLiMRHB5H6rzWn7vhF1VnX/Uv6mOM3cle0NB1uDNkVsYa1wINv43nU+jetP5P8iTORY2BfIvXTrqC+6LnEFHcz7ihUK+fhqCHgTxhsj1Rt8Cmdo9L3gQDmzWHGrIrIS/woUMnGz02Gsou6EKFjd2sW+Le2OPHvsy9a2ilddd52v4N5gWnCn1tv0ycF/ly3Tz7waZYevraX/UL6B4+WzIQXvNhoJ5ZGBOEt0ItZPs/T8Kv8ku5DlXgWByEGkitMiVsQV+fqu2mb1zHmHdsQGl4+oSNBN2ou2LCc/SBGMdcKYcCKA1Z1BBPDfFssXZ2Q+u9E5gCYuKD9lyy97auis9TIywEoQjI4hiItMt/TEyb2+3tnHKl+oht/xsNJcmjk1Y823XpSkHhKVHGbNipfeCdKAkX9DU5AdFRCmfmhKjOnEzstXQ/0VdOvzHQJJ5/ysFnr2mPhLHb+B5U0h/bKCcLo0oINeUcmGTKUiRcvAw/F/tG9j0k7suRuZ+EIOvO+dXBWXzz7+he8apM3CzntrKZpsapImO3p4Ze3Z8I3n0Gob5gXrAc2u3uQmRn1o+VRffy7fMSlezlkvQ6dyvZiIUh925zhO00v3IRGWnBV6SNrtLSLOXxk1OSj3aUudz5nROSIBA6C9Sx9vnbA91lQNrTUEQ7aFKsmyCZQYznZ4ZANOLAZLP6tFkgn1CHrl2IexinoT6BXMSJEE7iVqlxaS4vWozREnL7bh7sBi0twrr0UyawxgOEJIAJ96WJXy3SdoE=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799003|8060799006|461199028|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	7gAXLLZaCJcu5hauuJ+sFEGcbWzhxrQQGkRrCSFxSnFE8ylCKMmCJAN1fZLgUQfiNepKMXowfeJI6DvLZSvbiR0ribY3MNvHL6a1kzGWrglC+dmR5I3YXopQZNhbBO1xYxcxNN/17BJoIN61tpdU6S0QsJZoisM9N7cdH9/APg8Ome3TnK7XNyqvR5eP8zkpGgXhsXce38VBvn1vIh/hnUYiEj1miCZsCkiZK/k2rSwRHA2MFdH9hWt1uWjGcgtcwDivAD8x6Lb2Uma+G/jN0+UmGfagL+iaEIx9SlrgXwkESeJFw7tcL3VUk+ImQSpnslk5awNQ5jvjYylAfr6rge/ss5c80dF3OxY2eV2/vQsqK75jYb2BjRXp3K9n4pOu84WChuwsY/SnZhUYNWVFp91Mkkg+P7A2cP9z8HJBNdkGSs83fhuD5Zz0iRQ/lvJX3ZYozX7jpWOEPYoU8hsrUwwC3Uulvic9XubQFZJnuBQsn1M01kCLpa0udnLofHPvnP9PSq2tUUE8V15GC+M60Dm+ju6a3SB/a36IIipYl/s2ATCJk62TYlBQbTX9UusQxm/3AI5Xaqs3gvtyKWbAb2I89ZU5MynXrdhUDewVdtbgMH7tRW7XplyVSiy79Udch/lAJiWBR7RftQqTnieA63BG0a2x1+8ku86SDpekzcp/YXLD/rfyv74qePfFeBHW4WSR4i/sDZepD1dSXc8QOg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TjQFIuyp3jamwTdJOg2aZYRbqKGUMtUrpK9BulMOfWY1o0sRfIZVcysE2vyc?=
 =?us-ascii?Q?G9TqwJZTEygOxp1sSU4n7IGUXj3DTjK7erZtnMxxXkUW15TkgGO3i5yNbjHR?=
 =?us-ascii?Q?GMBCL8/E4A+OZp0ykI7xxTssXwMjVtiuq3X3aEeM0y/McwmclwIdU4npHI2C?=
 =?us-ascii?Q?o3ehcW0gSErlG+cZKDkvnQ6f0ZzL0DY4JYblTJcg81KF7JZXQedMrN7bpjQT?=
 =?us-ascii?Q?C5/7+n2FIsbm3jgW5qZlj61qCYjzgQWLBwZBYdtxU7IWz6i4GUJzNo/NHHAX?=
 =?us-ascii?Q?KARz9+oOZlQzJn4fqxkl4rDxSJl0O0De9s6x5N7QNUe2Y1QBRcqtSxgR2K3F?=
 =?us-ascii?Q?uwf4pJ92+CXnfnc+XO04arUYR+DoauxMCric3kURiI3fs9FTFdM02OY63op3?=
 =?us-ascii?Q?U8xGa0JOp785W6wDM97vZHGPM58DMAsuFvzt0smzL+rnsnXfFKt2X0azVGNa?=
 =?us-ascii?Q?3j2olhFr3gfORM3oUezaCyTnuzKLuCtyGc3ApU93XfNy4x4IjREyDIDMzF9s?=
 =?us-ascii?Q?ArbBbQIfMZNhIcEHJCVQMx8tLnnXkVmJQXItDjF4PZX1qPNyb7USLB5awM93?=
 =?us-ascii?Q?XyQQNKOp4Sf43dxUq1RJIQvvuhfkGsNEYawaovCy8Ir7EA9cwi6STE0YUiLp?=
 =?us-ascii?Q?EChJYjdbFjdpH79Hi4BBZyuG1F8OC/aHoh3pp7pTr6t/1UbV91klPPzsdiGI?=
 =?us-ascii?Q?5DeIJJ+upkPzKUdVpsdTi6sDiSfoRIFLUeCggrUpYA/84E6hTa7H+rgINo5l?=
 =?us-ascii?Q?o2CrJOYXHAgJnZ2cgcPw87vwa2euCrqo4LI5FCJmjJu09VViaucB/vMN/gHR?=
 =?us-ascii?Q?hEXkTfIEA8mS0vUhomxpS1M0+amu+RyH5H5It8hbDnSeFsbsKDfVbmmmf26V?=
 =?us-ascii?Q?xKSNqI1zydFa5Kn71YFeae8e0Tq4+aIlqTbUyh5voiFoaqHPAYYbM10/2zOW?=
 =?us-ascii?Q?W54mmuRR/fxpR2yZcwB+Nmh5TFaxYXDjgF9VLfflF22sQsp39YDxn95IoCa/?=
 =?us-ascii?Q?J4flq8SMRtGDTx7Zk0TI78EUIVH1IJK+mbW360fqZheBKA3nnyvMkMZupNYi?=
 =?us-ascii?Q?YqtCGn3JnGDKyM5cD/uToRuZSEJGjNEOP22EMrE40ds1YdV+0AQXEQrd3/qM?=
 =?us-ascii?Q?ky30dZ9bKjWcw75i7yqx5uc1VDPm/tjLxhP10vMpbptqj4DDgT4ke28l45A7?=
 =?us-ascii?Q?tL0HYJ1Mx1otKxYrA1E+2qSyZBYGmjqEWXZgjYMbk0IC3aADXHkEUb/44Kdi?=
 =?us-ascii?Q?FLsLqJUP+Et+M2d9JT/C?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d361e52-f5e5-4f2d-b021-08dcb0f7a137
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 00:27:58.9311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR20MB6431

On Tue, Jul 30, 2024 at 03:59:35PM GMT, Chen Wang wrote:
> 
> On 2024/7/29 10:13, Inochi Amaoto wrote:
> > The i2c ip of sg2042 is a standard Synopsys i2c ip, which is already
> > supported by the mainline kernel.
> > 
> > Add i2c device node for sg2042.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
> 
> Tested-by: Chen Wang <unicorn_wang@outlook.com>
> 

You can just reply the cover to apply tags to all patch.

Regards,
Inochi

