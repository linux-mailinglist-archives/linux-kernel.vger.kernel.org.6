Return-Path: <linux-kernel+bounces-225452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7129913090
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 00:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631191F22414
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 22:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6193416F0C2;
	Fri, 21 Jun 2024 22:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="buTAMIFm"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02olkn2061.outbound.protection.outlook.com [40.92.44.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D656E16B3B9;
	Fri, 21 Jun 2024 22:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.44.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719009928; cv=fail; b=nKkBImA5gD1gm6QXj5MvYgTrWNt5WhpoqHJINQ0ByvNmxIgJpgHtLf6r6MPCEw5U2bdvLG0pDEWUZpunzpEnDOdZbK8xA8xWtsdxhmOH8Bmn9ysvmYe56Q8M7sANT7qmGQ08C8LIOb2PDOMVnhtZisOSnjcro6ATgHKcKfAHEUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719009928; c=relaxed/simple;
	bh=YpbFLBPZLQMiDkPXz7iHAenVTMelID+p2VPDug4jc8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FNm6JV3mX0Q/VgivwGV0JZcFyFOyV2khn3usUoodo5E5tAIuOmNvCn1SW4QyLbC0aKrSAtJy40BE0Ahrm/mUacobiWyqZZwlgV+jzmPILYPUbFpAkdyo/NY5mCtLA00rKsaDDhY9migCwGUatkmga7QEdx1qqh1JLGN/I9qvSFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=buTAMIFm; arc=fail smtp.client-ip=40.92.44.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHwnGvSdD3kljQYGDayp3Vu04E+QWt4xIgLDzZ/CNncEGxQPfptkc8QAkTEmLtWpSUGtqmcDYxHpTRMhP4QhJtglaVYMH+FssBPRcmkc8bDSkM6YqC0QA9hm4x3XDFxEmyW//HFPVX/KUph9eeYtHktzxuC5EBiKxxcsTRQdeScvh0jaUxCFTBDOv593dBKDnWuHd9PM3QjosjoZu4Vy4xBYP9CQRXDj5Gs/9Ok+ukPjd78XPkL8vMvJ98OPMb3pZrSPPG/hrYuZl98zdN5nCh+wc56hZQ7hO0VE9dUpUadIhEPZzY/rpEWId6iaZXNTEc9oDOJwGvoZLRVzpT0dbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBL8FhJ5GVbnFRakRTqVWql2d2e1oavNpCW70bOhwoA=;
 b=Ii5psTzJTEoyaf6k3BOIRE72JpGw5t3k23vwMgrIwQPkvL99Jh9QOqpjFRQPA9eVcvwC+BVJIYZDCACNUUqgsvkKsC/rwlwnqS0gE6KfZKKYKmMQghcc/LU5ADzd5hAcl7+6UXJBGxUnjP058lcnSkKziHI4dfXjnK5UQR2nQBUHdEWPv2rNCvHtNbCTLzV2sNAN4AJwF1y7XDNR/nu2nJm01iOHdtyC9hxLowbg4702cmhshz6nQv7DNj1ct7HVQOWwBWZ5Zgjz5yfAixhHFfOH9EUNCzDjfJRJTr/Chs7+V8HfRp5yPqUG4+LTu0HT1ExRMcUKKnmmB/TJjPMiUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBL8FhJ5GVbnFRakRTqVWql2d2e1oavNpCW70bOhwoA=;
 b=buTAMIFm8HzF0MQ3d3ZwvVCV7pPEf8/09LK0Z3Mthykx4BluLElYxhHN3DFsasV6+xvtQi3rfYKQZYeEF/nyojROu0Kys3qQ9QnGOZudAyCwz1a3o49/IKhL/6pecZB5Mr171RgkKOE0A9LbHepimxSoO44dIys2VHESedEfZufZS6OzDmwHczkqhMMt36O/QpwmpLFqFQ8NYPF0Xvmvma7yFM1jEpdiiLt+SChI113GOJEM2q3alDpCQwyKYsd23FzgD1mHf44FU04ZgxWKmBcNzFodtB3UEBB98PeYCoB6RAG5pjez0S/pwVEWD09glCenrg9g6fs+ydI7VBVvOQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MN0PR20MB7295.namprd20.prod.outlook.com (2603:10b6:208:4c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 22:45:24 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%6]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 22:45:24 +0000
Date: Sat, 22 Jun 2024 06:45:02 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Guenter Roeck <linux@roeck-us.net>, 
	Inochi Amaoto <inochiama@outlook.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, linux-hwmon@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 2/2] drivers: hwmon: sophgo: Add SG2042 external
 hardware monitor support
Message-ID:
 <IA1PR20MB495341CA5F2148902B198EA2BBC92@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <PH7PR20MB4962C6D8FD6989BC79F9483FBB1D2@PH7PR20MB4962.namprd20.prod.outlook.com>
 <PH7PR20MB49622B0A6E9169B04211C7AFBB1D2@PH7PR20MB4962.namprd20.prod.outlook.com>
 <df0f11cb-3b44-4869-bfd6-6e5d01e6debd@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df0f11cb-3b44-4869-bfd6-6e5d01e6debd@roeck-us.net>
X-TMN: [beUcQOmVPuKKOglEnnjHI8/cONUg9cLnQMZE3AY1ZE0=]
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <zy5eiphttfnid7k3eioix3tajxavhtzrpewwhxyuubdca22kvy@zmcg4i7xinhh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MN0PR20MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: c02c107c-c947-4b16-c7d0-08dc9243d680
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199025|3412199022|440099025|1710799023;
X-Microsoft-Antispam-Message-Info:
	FaLi0bQFoh0/zAAUrSOnVztA7ZETTH9YGKYm6Ec1LTipiL3rfpUdDtXzwvKMRTJAD/oSJDdKiS5Ev6BB3tXkJLyaGmnY38T8AizbtCbO7SeZTtBV8yHFX60FJU9XXPrH4hbPuLW4ZDEugv2QE5qex2DpuYD9m2d0DMun2MFkfBjCuxQRPe3o9Mm0qmWy0KYUZAQmuTN+Aq31SK3T0cPcNclkpcjDJjbbgcNYahLJ1Nn5sSI42WOH9NITNN01SvrKmXghqymnxRrFyP0oQIFDPerq7XWCe+AjK+Hxe/B7zHbTXOCV+S12DvKyobr+MT0d9aSMX+tFXxOigU3Mmiy5zJCD1FJ/bSFFZB9FX5y9kPSq8x5QooCCDdiyRZwcDaZCqGVYD73+kOjT6rPZEl1sMZEIbGv3shUpJbuhLDKvL1osXKPqzxSL3YM13rLH03yiBPbS/XiCAb10NolH24epppcyyfbPX2rq/Lzyt7QhuokoNnHgzpCiJ7/DHTRlAKPNc2lxNGTpM+afytW0o2QX9dTCrsRlEii1Ub7OP8dzvrk7rhY/I2UrbWYoB1HJ8bvMhVM69V7I0Vqu2ZT9CZM02BC/a8oPsCNdwMlmUoaE38jArxP0Sg52HxDxKFQ63Y0C
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5WkhBjWgcp+qVub3az45dBscYp19CbqV7QEKIbCyCIviYL+hO50TvY0DLbYb?=
 =?us-ascii?Q?Ex/tcnGHaJoioasvaUCfNMBapXhCQ2E2r/gx+LM8KsYD9/A1jsFkeisPqFjW?=
 =?us-ascii?Q?MMcBNKxKg90LOovVWCmbsz7pA1c4VxOkyg2l6EB9GJDmCgyn9vlSMvCluxgr?=
 =?us-ascii?Q?qeZGnqGBziSiAbs22yIWSHJ/P7avJ/E624MnWMKyfegSiiS939PfVg03r0jK?=
 =?us-ascii?Q?cQzfwe8F13FCBCTBLLPD0DzsfxS1oDA3meDBRDfR1uniz++RCEOpFPA+ZAjs?=
 =?us-ascii?Q?ZXaO83kGfOietF8t5oTmbdZfSFX3JRH+0AaNUzifeTeM6Vg4GvFc4k/kGe2S?=
 =?us-ascii?Q?6TVvtEoIx/1QWzj+TIulNYa6+dlRwStAZ3H3Aq4cxbWWKRhELkStYZWk0tcd?=
 =?us-ascii?Q?9OYgyU06irGm0/OZlVNRzyUs34zrtZhrNtEiLf4uNoZchvfAR0zlqSwPdQSw?=
 =?us-ascii?Q?r+h65by3BXdj9ZdmMTbDJuzN/wB2/0wJNv3xcYbpgIr4k9ijPDIO2nTDeUSW?=
 =?us-ascii?Q?Dfpx+78xB3QGg2JzOqb8tcPtilcS8vE851uQylY7f8YNt0npAJ2MlDI4hmqB?=
 =?us-ascii?Q?58r8ia/v8ISi72EH6eYWEGp1ytYGXSEVIMKMH1o1J4vrTLvjduLDWzeQxyWU?=
 =?us-ascii?Q?jrdBNX8fg0ZzZKoBhOqrD0GQ1AE+X2quIjcqDaCC08FlocGOrcW4O0oNl1qq?=
 =?us-ascii?Q?8KZUA28dQb991VFSGrlwu1X7IbcE7mIdGo1g9uka+vTsbnTDGVokt9sTQmkF?=
 =?us-ascii?Q?T2pzJ1m6X3J+1HMhWGD8tbKSExv/ISo5brj9YItnpxqsrc8h7suuzwRwnFeT?=
 =?us-ascii?Q?zmjruVQb7oT9Np1A2hT87hznE9VNDElePqI1DBaOnOl4WfWSQZNHfAr2m79n?=
 =?us-ascii?Q?WCNO/aYju5yd9//g6EAw0UCglO2bYrdPdmhsG/pyrIBzU2dMC3Gp5xja/6cr?=
 =?us-ascii?Q?fy4dWJ3ieaWGOjQZcBxy6w5Wxo47ZWXoMWh/JK9KHGmLBYJ32BVM7TVLtFF6?=
 =?us-ascii?Q?PtCjV7MeDVzEDnf9z/gUhY9YKm0+9h8kDMJDQXSA+5hNKrPJw/GwPsYu3chu?=
 =?us-ascii?Q?e4mqWViFC/St7PYA94B+ygAPWWwhKzxDAdV0WDRzvYlfq1+LyNk5VvwEj4G7?=
 =?us-ascii?Q?zUTMp8f60wREhdG4zaLoZnSrC8eNOOQbnyySUmQ14H7tTH4or/dPnICaJteK?=
 =?us-ascii?Q?NZzk8zfoN+DAce/rrAEVCIgNxb9thlWYOm9GaeXBmAlhpPYxO/DXB0NBjef/?=
 =?us-ascii?Q?Qrku9QYc8khlAZN/68D9?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c02c107c-c947-4b16-c7d0-08dc9243d680
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 22:45:24.3627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR20MB7295

On Fri, Jun 21, 2024 at 08:19:10AM GMT, Guenter Roeck wrote:
> On Sun, May 05, 2024 at 09:18:53AM +0800, Inochi Amaoto wrote:
> > SG2042 use an external MCU to provide basic hardware information
> > and thermal sensors.
> > 
> > Add driver support for the onboard MCU of SG2042.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > ---
> >  drivers/hwmon/Kconfig            |  11 +
> >  drivers/hwmon/Makefile           |   1 +
> >  drivers/hwmon/sg2042-hwmon-mcu.c | 531 +++++++++++++++++++++++++++++++
> 
> Documentation missing.
> 
> > +config SENSORS_SG2042_HWMON_MCU
> 
> "SENSORS" and "HWMON" is redundant. Yes, I know, others do it
> as well, but that doesn't make it less redundant.
> 

OK, I will short it.

> > +static DEVICE_ATTR_RO(board_type);
> > +static DEVICE_ATTR_RO(firmware_version);
> > +static DEVICE_ATTR_RO(pcb_version);
> > +static DEVICE_ATTR_RO(reset_count);
> > +static DEVICE_ATTR_RO(uptime);
> > +static DEVICE_ATTR_RO(reset_reason);
> > +static DEVICE_ATTR_RO(mcu_type);
> > +static DEVICE_ATTR_RW(critical_action);
> 
> None of the above are hardware monitoring attributes. They are not
> acceptable as sysfs attributes. Some of them might be acceptable
> as debugfs attributes.
> 

It are reasonable, I will move the hardware info to debugfs.

> > +static DEVICE_ATTR_RW(repower_temp);
> > +
> 
> For this one, I don't know what it is. If it is a temperature
> limit, it should be implemented as one (for example as _emergency
> limit).
> 
> Guenter

"repower_temp" is the highest temperature for SG2042 to perform 
repower operation. It is not the emergency limit, but a recovery
limit when the emergency limit is reached. 

For example, when emergency temperature is set to 95 and repower
temperature is set to 80. The board is off-power when it reachs
95 degree, and it will power on when the temperature is lower
than 80 degree.

Regards,
Inochi

