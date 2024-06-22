Return-Path: <linux-kernel+bounces-225479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CC191310D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 02:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40D941F21F6A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 00:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22417F9;
	Sat, 22 Jun 2024 00:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cvg8GTYy"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2015.outbound.protection.outlook.com [40.92.42.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D4E384;
	Sat, 22 Jun 2024 00:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719014741; cv=fail; b=PcZF/CmGKrM4FirKaFt72tjk1c0/Gn75yHNriy853iowJvhikRrmdrQvTpnzqUtmnOOoInlQ20aGYmNK163PLavVdK0oLc7SF8oELMG04IMksicMs56KmIPkr6X13Uh39Qd3VaMdVT0AGlLth/hcE5ccOrlfDTw9K5eMIy1tKvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719014741; c=relaxed/simple;
	bh=5dpizZP48DjXkoS/xUZvv2IeoWKCvmO5xZ2LllkoaTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=avDDebf+/hP+fN8PG4VRWKfIZ9zRJubrGZY9ba3CJJzm+A/ci8uLThZdGrFu/70po0fHXYNyfEP+BWJEXlcSfed5jbFdsTjbYHO5Ali+3jx4cBFoXM8ooVZL6t+tDtruwEphMiODZxs8Qehm4gojJW4V2l5Oyhv+gLu9IHgsNFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cvg8GTYy; arc=fail smtp.client-ip=40.92.42.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ldz1ebcgRQcKOFyUW204yqGXEmlCWLYps4E7rkJ7mfTXPT2MuYB6rMwlgX3VkB6HELEri31Y9PYV6ph7YGqKrBIeqJ+V8lVxANYAh8NuzL2RC7RhFSejzqRHjjZsrMOEm8jYjRp6UHAgwIm+7qZNS8m7u3m7CRGTI9DEmf2ZgIkTcN3kdV7O/tWU3Wg5aakVdfpbEPVCickSnDMTKX3XyDOjlH0rjhpBsP6g2VvaTH1P7piA8AS9N5uSyr2XSMdM+MTXj9oGFu7kTdP4AgN0wL5QubbZPozy3H+aholnva2+9R8ljcls5X5GmjuA0NKW9AagSslwhmHouxMq0iGJJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wsAhskoIskrgJHAWUSq/8gtjkfAAVEOC7NsvfTsU3w=;
 b=Zr1UQODyTgzqkmhGh5u64uYq2nd3ZOqH0A5yWIlCaK8/ZMwhSrnbTq/c8Uel2QcwdQpPn28p0WG8K6M1LaJZbzzA7gq91I6xNuGAOVPFVioG7I2BWUOvuT9E6uz+ZQ1T5x3DWhzgagxmbX8qMPsHqsqIEk1QfyRi/GEimhWfGma1dpaN8kmiC3YnPsUjTypRMfzXPrLW9TzmzUj/7xD38pUW4S2BnGeEPwrM3qInDDI+piVm5woo5rx6a4rpTFD4FcBTeC3+G2LfxqOp6/JSkSeJZsIjkE0FLsMLZ0Fw7xX67FLyhxFDxY4vKuZ/iSKHsQJ/SnWdH8ZpOseW83nLUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wsAhskoIskrgJHAWUSq/8gtjkfAAVEOC7NsvfTsU3w=;
 b=cvg8GTYy8cvolEz9JuerMjZOLAL8iBJ7oF0LhlZFaPeR9CZ9iwtUp/qXR97Y2Tsl/betWY9Rjp7XwQMLR/S9ASy+Qfzl0+UlOTXm0wReg9bHD2mY0OAqb4WEjyyRgQO4VoI60IJDBPHZm3OUCEfm//1MqjZWmtIUuAuDuDCrR0EySQ8srJmc1z6dJOEBVx3fKU/gbOe3z9mx1f9dp+66XmqMMcNe0L8ES+9XOHwhvtlEjX1r3qXbWvSNv9wrh5WhYVuAn2TGmWneDJsRh3mVySykqT8BA5a85ha5C38RkURaUCHkorVLLGI5PI3vVr/v+9xLM4TXfvnB04e4cpTTtA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CY8PR20MB5667.namprd20.prod.outlook.com (2603:10b6:930:9a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Sat, 22 Jun
 2024 00:05:37 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%6]) with mapi id 15.20.7698.017; Sat, 22 Jun 2024
 00:05:37 +0000
Date: Sat, 22 Jun 2024 08:05:17 +0800
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
 <IA1PR20MB49531390EF0D8A9EE5C53F24BBCA2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <PH7PR20MB4962C6D8FD6989BC79F9483FBB1D2@PH7PR20MB4962.namprd20.prod.outlook.com>
 <PH7PR20MB49622B0A6E9169B04211C7AFBB1D2@PH7PR20MB4962.namprd20.prod.outlook.com>
 <df0f11cb-3b44-4869-bfd6-6e5d01e6debd@roeck-us.net>
 <IA1PR20MB495341CA5F2148902B198EA2BBC92@IA1PR20MB4953.namprd20.prod.outlook.com>
 <52d97ca1-b9a3-4a50-8a74-6d56984791c8@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52d97ca1-b9a3-4a50-8a74-6d56984791c8@roeck-us.net>
X-TMN: [KEqNXVwmO2XzhOSKdlosibsVfOBVpJVh2CZYGDM025U=]
X-ClientProxiedBy: TYBP286CA0025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::13) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <t25lrekbdmfmyyymlx3leiymwv5obn6we3dw3sblk2yoo36kpm@wzifhyjxbn6g>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CY8PR20MB5667:EE_
X-MS-Office365-Filtering-Correlation-Id: 822b6a07-4b96-44c6-3b07-08dc924f0b2c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199025|3412199022|440099025|1710799023;
X-Microsoft-Antispam-Message-Info:
	J/j16gRHg7+4TR85czbqaNgYUy9M2JGHmK3xoUaMyGfQjChoLKCZdgi4s0IzV9ykdkaa3zcR5lPodYDOMEd3ZQnppnhUTVXdUDKTnV5pMa2973ooUZXeE6Ec9pHw0sl9dFodk0eUAVifMCAQWuq3QkwspmUPP8T1PwUqp2LtFmjKJ9doGJtLcidAUQWP3DcUHxDF2PvP6zQdvtcpiodaXntcznNzXjyWS+2aPawhN/uJQXIN1O1/+jHa9CwGkdvtTOTh2UUBMKmu5ZWz/Y+EA/cd6z/T3++WnDuyikD62e9EndUatS8GaE+3tQkd3TiIGVLv2UJn47FZNwT6tdFZYZ72lnLydRsoOvJMqmooSHGlvfZkFQ6z+PpG7XDNwWnm8i6GcfpWghl9j2eNFp6jxhwcIchdOTioafBISfS4NQZU9HZlwleiYCy0HaH9oo1K7494DcojOZEfoxdq4TtPzVnTXxKpLSJVVaJ1eF6P0wTe16K3lFDLiH9nnBB/vMPqVyPl8FEO+4OHVgGj5rfSBjBgnLoIVbOyUpLe6apvOJONFYunou6fFflIh4RMDJgdl9LcLqPustyIfOa5nx88Mw04f/vqV8eulfsKrAnoyQ6xx4OG9sCys09nAYvaT6ZL
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9LVmWybRsQP8KXpvhHoRTCPOc3LGwSE7Z9BSIrYRAiYjuH1G5MkF2DccbZqw?=
 =?us-ascii?Q?yULMCi8Z/MIkEhr72LBkp4Yc4/b8eWnWo3kTgEErfl71vZhNH5BmAcfbF2oM?=
 =?us-ascii?Q?1BQNXpD23aFNcpokGTCOiZZ4NXjSiorqKO8u3XkJzGTDU0Fzm4qNUwFg/rSK?=
 =?us-ascii?Q?ErkLPuFi86lTq0azF40DN75yzxHbUp/7RwNtA3GYci1WiF6ccOT6TLW41SX1?=
 =?us-ascii?Q?wKLUeedlWYKlz1ECJjtG2sx2GALESiGWIhhku00BVIyWYDpOk95eqhBTWp7I?=
 =?us-ascii?Q?fqQKsc3U9hrB2DzUDw7mb17xdX0LxvFWR64nnJ1p79kAKB003uTCeVVudixX?=
 =?us-ascii?Q?5na5X5C4uZJ3wXvcl5vfnNjPPpI3KHsg2Mwgc8Ceij+DIgDuT8CNenvT9z8t?=
 =?us-ascii?Q?6Syz0xCRFwPYI9ybz4vT0IN+DTfNASgVCoueVujllw3iT3uwBfCKhBcmPO2Q?=
 =?us-ascii?Q?4R3/xudKAPLrbix2h1Jha8tU/BVAj1rqiReHbVZ9dDt3P+O1S0/eWHf0a0fe?=
 =?us-ascii?Q?p275y3NoebWGhTtznK/jfMCV0F1jIbMDf6tSLtcTcx3OTL9m/+n6UUS+8P+7?=
 =?us-ascii?Q?7myxWjQFtX3tdx/kpinyE1JWmVV7pCcbW+B2rTA3rXeq78Vtcik//vWaLJM1?=
 =?us-ascii?Q?mk+q1JVx9ZD5ZxUa1McZkTfNUGF4oEz4ZP7YjJOs2CPd5kNrY7VPvgH7gDMl?=
 =?us-ascii?Q?SZc3EIOIGPpORItNTPJm3lf5rZbP+CY7XKbJd8bNu6VsA0C4Kuiufwtwtsvq?=
 =?us-ascii?Q?3pySFYnXvH/8NEgeQVACE/pfZvQulHvIPfgGxo066sDGeN6GrFbcNXEmUthz?=
 =?us-ascii?Q?RTeIvoui5A5KUxtPawWRqWvhicOhkdH7G8n6g/mjtDNXoXiDOxqVKP7RJ8CD?=
 =?us-ascii?Q?LCx2UqmmESsBAAHYnxMg+dGNNmDzkp6Re2NPGTAI3uLrfMYKs68Z3mP4Oz34?=
 =?us-ascii?Q?njNfW32XFlth4Mtmityrds1LtyldOCpbh72b0EskMLNGl2qFqPd+mN3drYyU?=
 =?us-ascii?Q?OtGUCW2qRGVcs7s+8V4q9ofH13DP56/6u84Hd63o6fpIPDlxouyPHKUfqvb7?=
 =?us-ascii?Q?Gy0duMKbzSyaeyl64b7zg3X1vWOeu95bY8JlVSfa8ENZlPFXC2FIT473igaB?=
 =?us-ascii?Q?D3M+IWpSUbiYCycFK++A06EFhQwLIyWqnlw4IpVGzlC0wbFPAf0cgnDoe73A?=
 =?us-ascii?Q?zI50iBDIkCNjRTEmLNwIXYz/OQmzv5eUPpCAf/Kv7vICsAbzzajYIDlBoav9?=
 =?us-ascii?Q?aYNAlr3lDG8/PNvcwu82?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 822b6a07-4b96-44c6-3b07-08dc924f0b2c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2024 00:05:37.0914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR20MB5667

On Fri, Jun 21, 2024 at 04:05:46PM GMT, Guenter Roeck wrote:
> On 6/21/24 15:45, Inochi Amaoto wrote:
> > On Fri, Jun 21, 2024 at 08:19:10AM GMT, Guenter Roeck wrote:
> > > On Sun, May 05, 2024 at 09:18:53AM +0800, Inochi Amaoto wrote:
> > > > SG2042 use an external MCU to provide basic hardware information
> > > > and thermal sensors.
> > > > 
> > > > Add driver support for the onboard MCU of SG2042.
> > > > 
> > > > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > > > ---
> > > >   drivers/hwmon/Kconfig            |  11 +
> > > >   drivers/hwmon/Makefile           |   1 +
> > > >   drivers/hwmon/sg2042-hwmon-mcu.c | 531 +++++++++++++++++++++++++++++++
> > > 
> > > Documentation missing.
> > > 
> > > > +config SENSORS_SG2042_HWMON_MCU
> > > 
> > > "SENSORS" and "HWMON" is redundant. Yes, I know, others do it
> > > as well, but that doesn't make it less redundant.
> > > 
> > 
> > OK, I will short it.
> > 
> > > > +static DEVICE_ATTR_RO(board_type);
> > > > +static DEVICE_ATTR_RO(firmware_version);
> > > > +static DEVICE_ATTR_RO(pcb_version);
> > > > +static DEVICE_ATTR_RO(reset_count);
> > > > +static DEVICE_ATTR_RO(uptime);
> > > > +static DEVICE_ATTR_RO(reset_reason);
> > > > +static DEVICE_ATTR_RO(mcu_type);
> > > > +static DEVICE_ATTR_RW(critical_action);
> > > 
> > > None of the above are hardware monitoring attributes. They are not
> > > acceptable as sysfs attributes. Some of them might be acceptable
> > > as debugfs attributes.
> > > 
> > 
> > It are reasonable, I will move the hardware info to debugfs.
> > 
> > > > +static DEVICE_ATTR_RW(repower_temp);
> > > > +
> > > 
> > > For this one, I don't know what it is. If it is a temperature
> > > limit, it should be implemented as one (for example as _emergency
> > > limit).
> > > 
> > > Guenter
> > 
> > "repower_temp" is the highest temperature for SG2042 to perform
> > repower operation. It is not the emergency limit, but a recovery
> > limit when the emergency limit is reached.
> > 
> > For example, when emergency temperature is set to 95 and repower
> > temperature is set to 80. The board is off-power when it reachs
> > 95 degree, and it will power on when the temperature is lower
> > than 80 degree.
> > 
> 
> That would then be the matching _hyst temperature. There is no need
> to invent a non-standard attribute for it.
> 
> Guenter
> 

Thanks for the reminder. I will move to the standard attribute.

Regards,
Inochi

