Return-Path: <linux-kernel+bounces-245081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F4292AE00
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 04:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A2BE1C20B2A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 02:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EC042AA9;
	Tue,  9 Jul 2024 02:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ELrnBWG0"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2050.outbound.protection.outlook.com [40.92.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5C14084D;
	Tue,  9 Jul 2024 02:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720490640; cv=fail; b=V5PYp50IF4+GM+EFv5xxIlQJX3MHuSEgOtaf5RXygebd69G4JCRUTwsB6+mtXJL/dCuq+ZjBQS2GnUV5/jf02APPr3g/n5athZLgBL30LE4d2YpNU1CBEkhCW23GXfbbDgfrSSn1OPFVstmCJ0OqMkQs1cElhuliKfIejEoC6wA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720490640; c=relaxed/simple;
	bh=Sxu1JkmkOMuUHlXcpPYT1ey/0EyVTN8aTKwfX866XZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bwc+FH4+zV3rrVRQBc8aIfR2x88flaejwmoTVb0bCCujEZN5SnQQVlygL7IHYe7C62Q5uqpX6R1kcTAtnyTg3iGq4SVNsH//brE8s6xVA09qaU9NISZSe5WQlAMy1dshRbtlMPrC9o22OIOewfd0LeNsiXKHVSHPCs4PjceKXc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ELrnBWG0; arc=fail smtp.client-ip=40.92.21.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9aHuVP9kcjrkayGsn5Y3vsq91sKcpu6c9TDc0IiDSoXW6+LDVt/MlxjYjmCKCxVksh1zSYeQJvLCqkjEAybEdyFpKmGttz0X2cydilzDPC2I+qjFBiUWQsUe8FVoWePwchgiDeboGVxVY2BQ05pb2NfzZEBa36HoW2Bv6IbJER9UUvA6OzyC3nPnnby61PlUzkDIDevTq/JAYN+Gnb4c0jNRjmPb07aqhQmkpYR2gSVt3QAZ+avh3o7TKLqUX32gmSnTbwlVW8lkVfsCkRuWs1PwXOJvNr5VavbkbXPuXDEOASsaMqaf30MwSQioBRC4ANgM092PCA80sW6iJaGiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnOPAnhDTOE+coMH2dRD1Dc4s5g0uuYjrHBKhEgyosw=;
 b=FHv9MXz1IzkuGHr5gT8AU3MT/IPDbhmOgu7vq9OFAStL92yQ1lLPzXSMRsd84IffA57GGiU6yK7PLZtb2U4O+YxRwLzkZo+ciVBJNHZwJj+enXl4ieyKrIaCEUGso+x6DSzO3Yy/6Em+8xcB2ez2TT3WV7wIQuB2INLPcLHtEtgRFVY9RyjmRZY/+haoeOvQkNwV6fQZyvilveThzUnqvtZdFQtih6ovga+JvbKTe0zpGPC1T8WeACfauzpMYeACNmCs3ipjPI1calHCcbdX2m4c31MPOA7TN49GGo0OCDZd1po4c7jARZpIg/DMlRgpCHTmMt77rawt22RhHy74Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnOPAnhDTOE+coMH2dRD1Dc4s5g0uuYjrHBKhEgyosw=;
 b=ELrnBWG0tMErPQDffabDhm+t4OHZiipMeHhyalfKEsTQDwgz2iBI9Vx8gRUjGhOB1bZvDzbwi2OL3Yy/0EyYohIFIXLlXkcsAMW65AYvA+xIj4voJnvLgVey8pCrvfvzub0xB09qVdxZNhH/ueo7Q4CjO6BHJWpVcOzUBq12A2w0z9ZyYAy82qGU8h3lEF6cy7vljGjWexUK+oJGIZUI6oFi5/wJBmPJ22bab4FZClg3qwJ32310ILjTSs8qStXwcDjyO8WkQ3soFzrltAjueOMPBLG/qhc17FiGNEwZOMf7nUIX/+m/UDzotd++EM2NX6Nw1LNAAqzi3mTHvC2G0A==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CH0PR20MB6708.namprd20.prod.outlook.com (2603:10b6:610:18f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 02:03:56 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%6]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 02:03:56 +0000
Date: Tue, 9 Jul 2024 10:03:18 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Guenter Roeck <linux@roeck-us.net>, 
	Inochi Amaoto <inochiama@outlook.com>, Chen Wang <unicorn_wang@outlook.com>, 
	Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 2/2] drivers: hwmon: sophgo: Add SG2042 external
 hardware monitor support
Message-ID:
 <IA1PR20MB4953092189839BB66599E3EFBBDB2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953967EA6AF3A6EFAE6AB10BBDD2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953EC4C486B8D4B186BB848BBDD2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <MA0P287MB2822935DEA9EE418F3411CFAFEDA2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <IA1PR20MB4953230DCEDD7DF01134A8A9BBDA2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <MA0P287MB2822676C9CF9443B9A3CB657FEDA2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <IA1PR20MB495309AA07F1B77D4DA1EF6BBBDA2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <b12fc4a5-1b12-4d59-bf21-edd583a81b4d@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b12fc4a5-1b12-4d59-bf21-edd583a81b4d@roeck-us.net>
X-TMN: [qXW+/GPufBYUGm8nu28gQnAc8zygkLKtS4TQcoXNujM=]
X-ClientProxiedBy: PU1PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:803:29::28) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <qzo4efgcxs3okmo42zbqldfvku2bei7etul3dqwdvl72fbi6qr@bxa3ex4nqtyb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CH0PR20MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: 253ed462-2358-42b7-0429-08dc9fbb63c4
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|461199028|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	eJ0w805/z/FhvaZ/YWNyB8mAXSmsHD90T/iuPXJs1JNzHNZXtk5Q8ATO7Ui1oNHFjXgzUpmnhz7WK8wpZyUmlMyHQPlE3AuU6ovMxMDEz16GFfBErknHvYYdQSmAgp115DDUrJEKypd/kdc6dwynL50vrdHNX05KhZoSO4qeSQ5Ii0RE/QekYlivOatoU2JzdXF6zUTyjAwM34dXdRjGw797ZtAb5Wj2J6FHH0wWbhPnKnaiEKpJB8sLeVcwC9RhA9UZF0pmvXlGZOVVw+9CTdv3mL8hXmSOWavARVUygC+NaGZWYtSGnisJHHKLR9CtrzaGycoeEdY/mmjPS03xgm7aWMNh+wi6hMOSppwZ5lTeCLVUxYBdCsh+/L9e2ii+Ir9XtXY3O8Sr55vL5qV9/YjmLFVvfV9k7uxtlGfUj5HTjfzGdyA4Vc4w3RXTNYVtusvcjq1ljKCre+44SFejeun8CZpChBs6YThzNwNEJBel4PBmIKk5aYKctrh8RpdIugQhGIOdW6WDOoR3abuiDjen6YfmnkWcWR00xV1DEmRw4prw7TzUek8Gv0EDKf48c0kgtGtdjEnyEeBZzTO/7vzhG0rQL8FBWOGQLzUdNESQbQkPxtJ5Fqtw8Fda6vgmuXqweiZLHc379N0O5XFoJa+j/USN0BYb87Lbum9PWIw=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/0G2oeMhSauLOfxmzel2JBO/L/XYyzJANUOqX2kx/GKSKyj5IyPCgjl5Ssug?=
 =?us-ascii?Q?hMsMEaAxFKF+YttSUV4Z5gqJSg5BOH7h19TIVr6J0N1rsVZlsq/qGgqtq6Yq?=
 =?us-ascii?Q?VPxkk6M8F/kcz/J4zmwpSa93jb99tALOVsLcT53qiTpdJ095R0XztmcqxhKe?=
 =?us-ascii?Q?fN19sZFcWm1Hwau6MhTBzA9rNgAGQQ683b3NGQSPWOCPfj5PJkpiTrLLbYrr?=
 =?us-ascii?Q?7z7KkT5Ym8BZ6qQ2CVmIvUY+q2JOZvHFfSBjAZ3A4CvCxB6ZpSjRUZnDlxTu?=
 =?us-ascii?Q?3fsqBJitg+8W39MVqqNm7wEyMEjY86PZP2x24UIVXTxqzVFgH7FXcAbulLlf?=
 =?us-ascii?Q?JCQzDSLOKizvb8Q/Vd7EJuiDsTUNPaFeztPJkkcGO9J30TjhEzNnXIl+PKg+?=
 =?us-ascii?Q?CpDOcqIaTmfwLFTs8mlggWoDqVlKbz4Ewe31a+3ruDlDI0wmAAF/p8GPRE2D?=
 =?us-ascii?Q?rnKljIGl65Y02FvhtOkipuj/1uKVKdQhiTpUMeQfcAeMNgtW8mo8JrO34j4O?=
 =?us-ascii?Q?zPrSiF62ESvA+Iz6lYrgLkgb+f2fWVhyNUHVVBHV42LuaNKIgZbQWAWIrKWJ?=
 =?us-ascii?Q?qTmdh+H7SiNhbYEldd8oZtBsSy7EU0+QpuwvgsQAkiSEfydXqhUKqhtQHoNh?=
 =?us-ascii?Q?gHioMS4aDIbSBQXifJF1BIkMAUxSNKBm13qKhDf/4kxoJCK5rswe9htFrAVu?=
 =?us-ascii?Q?xK65QPGg+Q84iDWB5XTlDX3X0Xo03DqvF4FibGXYyk7LiJ8W13zWaLMwJ53t?=
 =?us-ascii?Q?JLxo7SLsGEWUPSWNT4CbX5CEmM0wVD4/UgvC0J1k2Y/MlP4C7CdGDKXni9Py?=
 =?us-ascii?Q?Al/LMxTgMAp15ojBufL9QfIKE5Hm/AyS4xhs5gxEq94OSXfIG20celeI4MJ4?=
 =?us-ascii?Q?byQ+bhuJGyJmWPTnfaHxMby/M8B34Vm5eZE1pBjE2B83rHfppIvx0Yb6GmaZ?=
 =?us-ascii?Q?onSGe8bM8mx7T+ZeGjLiu1L3p8rzc2OV2h7vc2C0JmBK5nhdng5MIXNljy7t?=
 =?us-ascii?Q?SZuKDT4IspRxNObDEGcKeiZ07hVyD2YrVDcZ1JnrZFuANIZjq++2R6G9i/OP?=
 =?us-ascii?Q?heb8eeEVnm2nJHnqaAlfWKcV6sX2XvZ9ZldHu0kT7aCN5znH7ZWdP7vp/pAf?=
 =?us-ascii?Q?KH4P3d91tO8iXBz0mZXsPDqSyMUHnMgxZ7J14ehZCdqXru9v7VVCexPkR1hx?=
 =?us-ascii?Q?LMeqUT7YkqKB/nbyPQqDAxDde4LbJBgePw/CApgCQQQiluyfOtnaK73JvySh?=
 =?us-ascii?Q?POoGsfHly/tqqC2mAzi3?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 253ed462-2358-42b7-0429-08dc9fbb63c4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 02:03:56.4379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR20MB6708

On Mon, Jul 08, 2024 at 06:42:14PM GMT, Guenter Roeck wrote:
> On 7/8/24 15:15, Inochi Amaoto wrote:
> > On Mon, Jul 08, 2024 at 03:11:37PM GMT, Chen Wang wrote:
> > > 
> > > On 2024/7/8 8:53, Inochi Amaoto wrote:
> > > > On Mon, Jul 08, 2024 at 08:25:55AM GMT, Chen Wang wrote:
> > > > > On 2024/7/3 10:30, Inochi Amaoto wrote:
> > > > > > SG2042 use an external MCU to provide basic hardware information
> > > > > > and thermal sensors.
> > > > > > 
> > > > > > Add driver support for the onboard MCU of SG2042.
> > > > > > 
> > > > > > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > > > > > ---
> > > > > >     Documentation/hwmon/index.rst |   1 +
> > > > > >     Documentation/hwmon/sgmcu.rst |  44 +++
> > > > > >     drivers/hwmon/Kconfig         |  11 +
> > > > > >     drivers/hwmon/Makefile        |   1 +
> > > > > >     drivers/hwmon/sgmcu.c         | 585 ++++++++++++++++++++++++++++++++++
> > > > > >     5 files changed, 642 insertions(+)
> > > > > >     create mode 100644 Documentation/hwmon/sgmcu.rst
> > > > > >     create mode 100644 drivers/hwmon/sgmcu.c
> > > > > > 
> > > > > > diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> > > > > > index 03d313af469a..189626b3a055 100644
> > > > > > --- a/Documentation/hwmon/index.rst
> > > > > > +++ b/Documentation/hwmon/index.rst
> > > > > > @@ -203,6 +203,7 @@ Hardware Monitoring Kernel Drivers
> > > > > >        sch5636
> > > > > >        scpi-hwmon
> > > > > >        sfctemp
> > > > > > +   sgmcu
> > > > > This driver is for sg2042 only, right? "sgmcu" looks be general for all
> > > > > sophgo products.
> > > > Yes, according to sophgo, it use this mechanism for multiple products,
> > > > so I switch to a general name.
> > > 
> > > But multiple != ALL.
> > > 
> > > [......]
> > > 
> > > 
> > 
> > We can add new driver when there is new mechanism.
> 
> Now you are contradicting yourself. Either sgmcu is the catch-all
> driver, or it isn't. How are you going to call that new driver ? sgmcuv2 ?
> Are we going to have sgmcuv[2-N] over time ?
> 

No, I mean new mechanism that does not use MCU. For example, the chip 
cv1800b and the incoming sg2380, these chip have different mechanism. 
For all chip with the MCU, I want to keep only one driver.

> All we know so far is that the driver and the mcu support sg2042. That is how the
> driver should be named. It is easier to add support a new device with a different
> name to the existing driver than to add a new driver if the name of an existing driver
> is too generic.
> 
> Ultimately this is similar to wildcards in a file name, which are strongly discouraged.
> One of the worst examples is drivers/hwmon/ina2xx.c, which does _not_ support all chips
> from ina200 to ina299. Please don't let us go there.
> 

> An opposite example is the lm90 driver, which has not problem supporting more than 40
> different chips with different names because they are all similar. The driver can be named
> sg2042 and support as many similar variants if that mcu as feasible. It should not be named
> sgmcu because we can not make the assumption that it will support all mcu variants from
> sophgo.

Thanks, this is hole I don't consider. I have made an assumption that 
this driver only serves for sophgo products (especially products with
this MCU mechanism), which is too limited. Now let me restrict it as
sg2042 specific and evolve it in the future.

Regards,
Inochi

> 
> Guenter
> 


