Return-Path: <linux-kernel+bounces-548230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 972A9A54206
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 06:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C667E3AF7D3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 05:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B874619D8B7;
	Thu,  6 Mar 2025 05:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="DRoewEa7"
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012053.outbound.protection.outlook.com [40.107.200.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DFCB661;
	Thu,  6 Mar 2025 05:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741238437; cv=fail; b=LHqMLQ4hxeKvM7LzqL4CTbxGLck9psrCCLc5kY5TrnnP7ladbah+dmoLACgt/Pp2Pt/v+4IRaDW1M9pCJa9dCvZHnEyB81ebgP09lgOea95Im54w80UfcLybJkwLhVwaV+7btm2mpmoT85LQcTbXZA3JqDWEOrCzNtY36nMjutA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741238437; c=relaxed/simple;
	bh=NNsr7M2yMucuHtJRHUrhDEqneFJ6uSUKK8/BNRj0Zp8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=avKgPxITg6KXhLsy+VlJ0G41R5bo7aEu3sj6zAZ1UTtt0CtphwfKm0kQMWTNy2HoQHLl3Fyq6pjHE2wNd0dNHalG8xisuwB/L6XygrnWzMtwNovtHm0QIRJ4cjEDoJFWHW5hDxnB2b7PgwhKhj1lkB4EcauaV5r8DoSul4NWxxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=DRoewEa7; arc=fail smtp.client-ip=40.107.200.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ulhQuS//nPHWXJhq5sYY2mRvsKbfCL80VoPO3ZdWgFzjNGpQuP66XnR9jhShpPaKQWRsJBIMYgu+RImn8EqJ712Q633d9CYiZbMvvRknYRy3tCxWZff/WuBDr6yT3H2paPkDrZ+QCDSuqtRgQb7z4BmDSw8w8U1nJnWsmSSdpW+tBXvCM9ZdIdV8zp398j4DnehX9lkl9pMAqGXBJS1Yy2oLiZAlfDVUUYfmqWgWgAbTPGlwyrCdxn9b7tOP8UNtaGrzzyJ0bRhE/45p4RuJ0qYZ7xfq+pqYSMAj5wDb29jLrwYQZ3p1QNePhd0DC8aafufIT6fG013Xeh02laqbkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNsr7M2yMucuHtJRHUrhDEqneFJ6uSUKK8/BNRj0Zp8=;
 b=ILzyyYsgKUyiMNU0Ctr4BAIw1EnpSpCMtLAsv6uwlEnWkx1mCtZh7IkfclPcnWd2nN6Z7ZV+YRLauy5rau07Vp+iBCAXnf6qx7aC7Cnw6WlFnJU0pX3eJrh77FVv0YrNPYlN+J3ezWMSXfT/ESxFHLZuBwahrsSGX/1mhZF0Lp5ePC0NqPiyM/XSpHBfFGc97Qp3H07FF4ff7bEr+vDDaIpNONu/G6/KBVDp8ExWO3M9jMDFlD3+ObRSLLokk4wiV5rqgell2A+zhA7FFpoxotV6nzrdXzuGwarEG2b1Dvup9QoivnuRHrwifpSYxCy5HKo+DOcfaW9i/NKfUSeY9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNsr7M2yMucuHtJRHUrhDEqneFJ6uSUKK8/BNRj0Zp8=;
 b=DRoewEa74IkMuwYjJ1b56gMLLjatH+90XqFHEZo4Kzf+uaKZPFfJjCJtIX13a0C4PVllJBlhgIBwHn913q/zBrA1USb1lfNB0j0uWkWFTH+S6EPi9LZ1c8J5r52JERKKTJKrmfbQFeO1dPxVh8RZ0oEcBiOZn7CyXhoJdmBEoSeDP8K7dnaaNA67vJ2AEXvmmuLdcXQO+3oQy9/S48BYDq6GoQdkTmC6CMhKltNgKngUDbUfwp3ZTrZF7t5yFKIbAlUvqI0NYiTMtNEvAVIujEboi5UgPermBVmqD4ecfO9r7YeYtz/X2YS5ZWsxFo59ArKPXUmK1kJIj/nNJVQ8Iw==
Received: from BN8PR03MB5073.namprd03.prod.outlook.com (2603:10b6:408:dc::21)
 by PH0PR03MB6528.namprd03.prod.outlook.com (2603:10b6:510:be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Thu, 6 Mar
 2025 05:20:32 +0000
Received: from BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a]) by BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 05:20:32 +0000
From: "Ng, Boon Khai" <boon.khai.ng@altera.com>
To: David Laight <david.laight.linux@gmail.com>, Johan Hovold
	<johan@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Ang, Tien
 Sung" <tien.sung.ang@intel.com>, "Ang, Tien Sung" <tien.sung.ang@altera.com>,
	"Ng, Boon Khai" <boon.khai.ng@altera.com>
Subject: RE: [PATCH v1] USB: serial: ftdi_sio: add support for Altera USB
 Blaster 3
Thread-Topic: [PATCH v1] USB: serial: ftdi_sio: add support for Altera USB
 Blaster 3
Thread-Index: AQHbdhhtxmvE8K0h50mmzVUEKISJs7NkyIeAgABchYCAAJ23QA==
Date: Thu, 6 Mar 2025 05:20:32 +0000
Message-ID:
 <BN8PR03MB507345E3779A3B6CED45D82FB4CA2@BN8PR03MB5073.namprd03.prod.outlook.com>
References: <20250203084822.18356-1-boon.khai.ng@intel.com>
	<Z8hetcRinFXXVAdy@hovoldconsulting.com> <20250305195601.1dc6a1f6@pumpkin>
In-Reply-To: <20250305195601.1dc6a1f6@pumpkin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR03MB5073:EE_|PH0PR03MB6528:EE_
x-ms-office365-filtering-correlation-id: 39f2e322-3fd6-43f3-28d1-08dd5c6e9e1b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?IJhYJTHRA1B9iSbnEw64Jfb42otHQHPvHqPVwhx2CtOYruWEeNe413zBiKqG?=
 =?us-ascii?Q?RxGaOaFbVUuLYoFVAB5ExZ0TY2e3MOy71vVckKuO4DDarIc4Qa8swL5vonj/?=
 =?us-ascii?Q?gKrh/zHnEXmkI6MnFvJrt7QCBA3Q+rDHZ2IkmG0MgHnnei9E9eloVaH1RwhQ?=
 =?us-ascii?Q?QpDkJJY61TAtvTdpaEwu8dil105q9+/frIVeen/+knr5JCHXonbUPpxqD4NO?=
 =?us-ascii?Q?VMcc8za/mxz0amFV8OM/IeT9vpkRmbmrHVy5QE+vts0lHsECbtyi0h3MmZSK?=
 =?us-ascii?Q?fK6ACietUL0B9RrUNi07PPQAyEduv5QOZCsdjEWMcATBDcuGZD6E4YvLVw2a?=
 =?us-ascii?Q?8WDr563g06ZjSm9MaTaofxzLi7FXk7cYEuqQ5VLecblZnXt4+0QlSxU+j/Ea?=
 =?us-ascii?Q?23K3d1KwBPJdbFkds2eRe4Yovx0ltT40DJvyhZSBaktEpeP/gFd7hfEVYOFh?=
 =?us-ascii?Q?UgTqsf1mveSWGq/oCsPvtkeHcHfhoFSzQ+paDsHxcqhX9sYJKWoKL5tQ4yV3?=
 =?us-ascii?Q?Nh2IH4iMEoh8lsqIB+f2CdDh5cO7AmAvh2Bl9lhuEyDW6N2tc7PNmiFtGikX?=
 =?us-ascii?Q?W0nrB9mecYxSmxNXAo0bSeJCW9IqI+JBgxC3atM/JHJW2ZiFiT/qEl+Yuifr?=
 =?us-ascii?Q?rQHFSb8+xgYX9SvxTTH4stFzJa47bkVKk/kRFuLh+PrnUbCxjIOYxTbpg2Qk?=
 =?us-ascii?Q?HS+K0MtYq/bjlN5KruqLIIcJYr3drTX5EJneYzW6joTh1lejyYkuoiJAhV9g?=
 =?us-ascii?Q?46X6onTgqquuf6IZsD+mB9lyGIOWk0ES5I4VJfuF4EbOWFrcCg8BZCkYQ7sW?=
 =?us-ascii?Q?vJsBso0/N1N+/88dbGZSvA8dCELaWbLWcbxw6pPolrfmE1HPsrLJ6QdYjWp7?=
 =?us-ascii?Q?/6P/Pzy4GXzlJRt2nE9ypyF90//EltDvziXrvnt6gpJopqtrE1on5yibNTWE?=
 =?us-ascii?Q?t+Zvk9kexBu2rFqObm4KMrzU0ytIp0radyF5IKHMIHF2CtPCmqNSJZKC93gq?=
 =?us-ascii?Q?kTbXPkoRJoHyknV5j/OjULqsIPkGyn7acHsuIqE3/dslwwHx9xukjCPeTqiY?=
 =?us-ascii?Q?3A83RByWOaDrujP5E26NvKxgI0YAwSRNFUBUBvH5ZY57ms29GUTMmAfTMCAg?=
 =?us-ascii?Q?GpObW/haTVHm0q9ySozYZvjuCjDGAE1SGIUx4s/uIoQ7sKUn44yJvkAWAxvm?=
 =?us-ascii?Q?KXwamq2ZQ+lmwHOdEwzIUlL9nlA/Y3bKU+ro7Y4/vBrVcsso57GBoLMxd2vn?=
 =?us-ascii?Q?o5WG+BekRIlx3NfMtQi6NWUuF2sRV2ewvMnymtaO01SDlIeWztRPrGUdyPnM?=
 =?us-ascii?Q?VwBf5Pj7PrsnpH/bnZfnIFg+SPgN3F1zrY0FcwHLYPj+5o2YNMyWT4BF3jE0?=
 =?us-ascii?Q?8FKOHO3dtf5p2KU3szJdyEm4xLO5K75MICLcLrtwxyQQCewMRqWjVx6WafJI?=
 =?us-ascii?Q?pTU9HNNn72n066ea69ZP2S4vxO3BSZ8X?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR03MB5073.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Tv7fSXOFfPa+VielEk9B0lynzYsPCfdJiTV7cbSSDvAY3ejgLAyvox6ddwNq?=
 =?us-ascii?Q?UTPqefpKOg2xtOjDqG8xISUlgOASKqxOT2AeFiHwqK40Ath97ehFLqwAF9sH?=
 =?us-ascii?Q?tyAFiUworY0uubURrvTG21L9LDMPYCtLcFI1j02h4AkGy5Zh91nTMys3HhrF?=
 =?us-ascii?Q?40JY4V2SP+5TH2E+wOlMjfrPBWX+jz/SWYuxreAE0GDjBsVGNT3Xk7Tm5Eou?=
 =?us-ascii?Q?XbV/a7aBi+NMyzeENiEelTcG3SHmp2wzy3fCzTVkOSeyZbzZGugG99+12xsf?=
 =?us-ascii?Q?z6Qg2kSE+E28obeW44pb246LbNOqFZKHTbFqaGYhArW4n4b2XDmts0jjJsWt?=
 =?us-ascii?Q?JA45NogV3XlV2WPy+1LCfKITf7gkbUOqqvG8ErwL7NLj/FbeE+K3sY11e5xg?=
 =?us-ascii?Q?LOFT8gMidVCQ9Cda9IcRvBH/tYH6vdxGif+T/jzf5UZ6txBVORhNuJCBNEAk?=
 =?us-ascii?Q?lszJ6tsNS3MGQRPcqAKHm2VXAdYUkNk0QDspBqNjZ5mWJgSAQDh0ZWtyki6y?=
 =?us-ascii?Q?x60tAS9ODXLSWOsgpQJnovCGX5Ft/7MF1pkdBpa4TSaWRIZqtZnVOQ+JQD6h?=
 =?us-ascii?Q?7h5yS6I5cvKVfCQujaeKBxCkks87HZ14G5jhW3VWBNpbY+eEqkyK9hrySXBb?=
 =?us-ascii?Q?kBqKzSe+oPDYfsTc5/kfdSbwRN3Zt9/Ph/iyCszVbuZTW2htcL9f/+fAdUnZ?=
 =?us-ascii?Q?UZdW/IttX1SnR2meRLvWNrCUkZf48bJNQhiif6M1PTw8dpKIYPYJ9+v6IBv+?=
 =?us-ascii?Q?VAakBUfeLLO+hRNciC24m2I1VYVZWVCOmDv41YhEfRqVtiBdVcbb/mDP1lfT?=
 =?us-ascii?Q?k2yc0fmJeizfMNWiraS7iLXWdIqfDByZXRuysCNY/4/mHWmXef7jQagGANuZ?=
 =?us-ascii?Q?fJFhVlguU9dhlN7W3KZIlA/YjRN0QGEmiw67KB4G5jx/YM91KIPM/aWHiH9f?=
 =?us-ascii?Q?5H30UnS4gJ/uyqmd0+9xxwO9k1Nu9iuW0gr0LoXuWFra1XJ8SZVL9rmYepid?=
 =?us-ascii?Q?iFPvxBabn2xFl6GbAVjmllv60n4FpxXlJz97dH2CaBDSotc1TH5mGVvs80iX?=
 =?us-ascii?Q?KfhfCywQMYT7QEN9okoWzABs3jeETKtG2fMUsnWmQqb+oC5j2sWYFUaYbj2X?=
 =?us-ascii?Q?lZLqBVw2x58QEth39jDnrdBnf9k6LLbMO5GpMyCc35QjrnEPOC6w4NnU5Ydd?=
 =?us-ascii?Q?8ZEkc3mDmQtS6V4vGhCWLHytNwRDERxK0y+GXozdVOD7szQRsBjLOPCG9nnJ?=
 =?us-ascii?Q?HF7NG4zgsGx3U99xOdjDdyePAr1kabo3HV/B1sLATSRtp/xxikhTI4zzb6dD?=
 =?us-ascii?Q?3Cnpl0f9sNOQWjAM2sJuun/ONNDOTVYOAONNDCSoekr9RcfhjtoNTu1lIngx?=
 =?us-ascii?Q?yHGZiqr8LzN04BCydbvrIOLv/YJb5O/HVKUhTMhs79ci5T3rnecVCg8VKPZu?=
 =?us-ascii?Q?5bUhLSK3pc8Uo3m7it03aVN7wFBEOLtIUCykWpD3DF5aXqCPX64BUzzscoKQ?=
 =?us-ascii?Q?YZcXCPhtZGqe9SZbydNmOXnQqHvVFfbIvll1xERc/uLXpnENQ+FdsWZdcs1N?=
 =?us-ascii?Q?VCD3Mf14hsFUXbGGhNgL/nbLaj3BiH9LBmfvRcJd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR03MB5073.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f2e322-3fd6-43f3-28d1-08dd5c6e9e1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 05:20:32.4800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iS702rrbSw18dbn/oTcvWIeqLwwqS3vahDrwQJeg6/9mOuEzuKxYAFyCqgItD/HJRrtakGJv03opK6qZ3OCBhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6528

> Also, is there any actual software that can use them through this driver?
> The Altera 'quartus' software that is usually used to program (etc) the f=
pga is
> pretty proprietary.
> I think some bits have been reverse engineered, but only for a few simple
> actions.

Hi David,=20

The software that mainly connect to this fdti driver are the=20
debug or configuration software, includes Quartus programmer,=20
System Console, SignalTap, Nios debugger etc.

>=20
> I'm not even sure the Altera code even loads a driver - just uses the use=
rspace
> USB library.

No, those software are not loading the driver, it just access it from the f=
tdi_sio.

> I'll have used it on a system with a custom kernel to program (etc) a Cyc=
loneV.
> No hint of needing to recompile a driver.
> (The sheer amount of software you need to command-line program a device i=
s
> stunning! - I had to parcel it all up so we could use a usb to jtag cable=
 to in-situ
> program one of the smaller PLD devices on a small board.)
>=20
> So what is the real 'use case'?

Cyclone V should be an older family device,
But for this use case it is to support mainly 2 use cases on the USB Blaste=
r 3.
1) USB Blaster 3 cable
2) On Board USB Blaster 3.

The hardware designers will decide, what kind of configuration needed on th=
e board.
We have total 8 types of configurations.
1) PID 0x6020, FT2232, 1 JTAG port
2) PID 0x6021, FT2232, 2 JTAG ports
3) PID 0x6022, FT2232, 1 JTAG port + Port B as UART
4) PID 0x6023, FT2232, Cable USB-Blaster 3
5) PID 0x6024, FT4232, 1 JTAG port
6) PID 0x6025, FT4232, 1 JTAG port + Port C as UART
7) PID 0x6026, FT4232, 1 JTAG port + Port C, D as UART
8) PID 0x602e, FT4232, 1 JTAG port + Port B, C, D as UART

Regards
Boon Khai

