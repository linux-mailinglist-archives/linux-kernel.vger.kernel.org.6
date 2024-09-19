Return-Path: <linux-kernel+bounces-333799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B5297CE43
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 21:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86CF4B21C0B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 19:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA3C6CDC8;
	Thu, 19 Sep 2024 19:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="V281DXI9"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020088.outbound.protection.outlook.com [52.101.128.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC166A022
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 19:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726775570; cv=fail; b=BcqYoT+mD/JPuhZYCmFvBJDxWs7QlzVXKAV99s5+6yhXey8eZm0WW2vxX5ez86cycX4I/hU6Eh9gQp3r0oa1/8q79MkpLW5anGwDa70OoPP8RcG5oNhOyCINSEz6SIifuzw7+wdcgZ3C0Vg1Vwt0W8ZB1Y099/zQOFMjDMJCoTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726775570; c=relaxed/simple;
	bh=MPqID3gnSscnqvDX/y+C0ufNjZWcAPAkWwF9PCg9R+8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZBNPc9gRTnbCkmJmieqktphEu8Faj6Q0DqTL+pS4S+mNblNLcX4W3Kdq+ZgDwXkBTWvTzmq9lrHvglqP/2q/sEFvD8iUliWwWL4qyK8fjJQRArsH+fL5sN+la/1VJxEXIMFvGGj7wt3ACS7yCXCVpLf5nz0jYJ8sU1U9gFhBNsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=V281DXI9; arc=fail smtp.client-ip=52.101.128.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHU99qgNEeL9Q2fGL1/jfLANss6OffxBnSaq3Glp03z6B0++lSzH2hKaxMK6mq5jEJpIUEWu5d/2N4OM49qmMNd0W1giU5PEUk20V1dsfXLmvk7Zo+WaVtRXEn5JaOfX/XyG+ElHbuBl6htfMgjes8dFV9nJzIG3v6cRg0QjSd7nNmBM7rCCJoLwFJmqIm5HKbx8IHkU8zA8+pBxg9V6x8BalzLzAGckwhGBym96MMsEWrmlH8vr76H3Qzj0iAkPc+EbKniSPgEBjgFlXkMUEFnmrVAC11Urp7mfpM2Mp7gFM/Eczd5uIM3MFXOHwXi3RPmI1tsn2sGa+1xyy78kNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CY8oTfoFifFBzQAo99UVPgrFCnn5/VG8AJRKdz68VJE=;
 b=FnQiJ+1QxJVk0aBME8Ssfud7vPMYieTOUkAqQYtEuySYnsrbTyGFJXOGjF+iT6JPlMZrmtNQcgy46pnKU1F/6ULd28ebydJeNLnWbKr0i9khxLF6bGuHOstF3FSQz7+6Jb1XrQVD7+fnhIVZwamGZZsKx0a+cAMWI2QZasBzUrdaNlryOGBMUB0syG+9TPNbGhKLhy4ITRlJ/nYM7sxAyVdBaLY5gn4Xl5OMLCyxf2XoXQKLDYwo5Wc62OB50hx3JUmUY37GeH3t+ln60XgChD5p0pWUocUpXERG0eN+e0UHeVtXFANGr+htfFATLMmqXQVX2EuFhS2IdIRE8MvRhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CY8oTfoFifFBzQAo99UVPgrFCnn5/VG8AJRKdz68VJE=;
 b=V281DXI9NYDdQP48Vuiw7fEf+dJpuOle9Kk3wdb1CdEJe+if7tHlH8Yj9Jhle1ZrnZR98WXnJjDeYTunUBGiQLlYVeFogzPWD7+1EmgKwCfBD/F/csnwlaf1dKLuwooGTFzokRPGyLU2Kr1bGHcFsChfIaGnvyRu1lU3J7p3tbw=
Received: from SEZP153MB0791.APCP153.PROD.OUTLOOK.COM (2603:1096:101:a6::13)
 by KL1P153MB1004.APCP153.PROD.OUTLOOK.COM (2603:1096:820:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.1; Thu, 19 Sep
 2024 19:52:45 +0000
Received: from SEZP153MB0791.APCP153.PROD.OUTLOOK.COM
 ([fe80::6ab0:ff84:cb49:ff9d]) by SEZP153MB0791.APCP153.PROD.OUTLOOK.COM
 ([fe80::6ab0:ff84:cb49:ff9d%5]) with mapi id 15.20.8005.001; Thu, 19 Sep 2024
 19:52:45 +0000
From: Saurabh Singh Sengar <ssengar@microsoft.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "wei.liu@kernel.org" <wei.liu@kernel.org>, "srivatsa@csail.mit.edu"
	<srivatsa@csail.mit.edu>, "mgorman@techsingularity.net"
	<mgorman@techsingularity.net>, "cl@linux.com" <cl@linux.com>
Subject: RE: [PATCH v2] mm/vmstat: Defer the refresh_zone_stat_thresholds
 after all CPUs bringup
Thread-Topic: [PATCH v2] mm/vmstat: Defer the refresh_zone_stat_thresholds
 after all CPUs bringup
Thread-Index: AQHa7H7Nue5A+aHys0+ngkXGeUO6jLI0pOvAgAAAiqCAKxv5gA==
Date: Thu, 19 Sep 2024 19:52:45 +0000
Message-ID:
 <SEZP153MB0791CB961FF0D1512DC47164BE632@SEZP153MB0791.APCP153.PROD.OUTLOOK.COM>
References: <1723443220-20623-1-git-send-email-ssengar@linux.microsoft.com>
 <TYZP153MB07963DDE4B7E01C575B143E2BE882@TYZP153MB0796.APCP153.PROD.OUTLOOK.COM>
 <TYZP153MB0796B44322EAE4C712883201BE882@TYZP153MB0796.APCP153.PROD.OUTLOOK.COM>
In-Reply-To:
 <TYZP153MB0796B44322EAE4C712883201BE882@TYZP153MB0796.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4c9e6c5b-38e6-4311-9e23-3cf5ce942a40;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Privileged;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-09-19T19:52:43Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZP153MB0791:EE_|KL1P153MB1004:EE_
x-ms-office365-filtering-correlation-id: 6bf133a5-3446-4511-d05c-08dcd8e4a170
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?INtOsRxkZHLFxhslSGxo3eLLwSYK21IxcgC0DzZcVLhqL13ztgUajoB/DZ8P?=
 =?us-ascii?Q?YkRPddjdpUnb/iOQxKTK0YCwthmyjuZNRNQEbqdlAxnE0baPQfCP2hmf1cIo?=
 =?us-ascii?Q?MaSwEEOqTkUtIXS4zG2ys+sIKKkhg2YBCJFEDDvvry3RV8TuCPVKzePpyyvv?=
 =?us-ascii?Q?zPODhF59z4n8lZByXz6v3f5wxAbNbWfIgQZHoor/6iFgwirRQlC3pOBY9D7y?=
 =?us-ascii?Q?kFhCIUIcR977wx8S6D2wwHPZ9Od+YRSbZMIWyHYHfFjSCgGp6sK9Knj3w+sY?=
 =?us-ascii?Q?XzfmR6aVTW1FynuU1Noljzb+6zq/uYO7mWxMbJapG42LVuYNf5EHPBIybzlz?=
 =?us-ascii?Q?mjmq5nVIK6knsIu2CqOQQh/lD7DCvNzoHAv7J265k/lrmbO/CN0Dw6zEJNSq?=
 =?us-ascii?Q?SXVp22YP2A63N4lDQhrHmcohMlHEiPsbRFFr2ScoBkAyYdf6ajv5IhoGFLiP?=
 =?us-ascii?Q?EjRW7OWthqv48B3WZrNolocUZarzkbjstemB7WyXtjbl5C2ltO01vsKjMFyQ?=
 =?us-ascii?Q?BTVxSbgoO18MApTcOIXTK84uYWDVm2YIOo1ELFGzWvO11c3Qf24nEUc5lgOx?=
 =?us-ascii?Q?phAkce/pTQGOfsZsUO7TN0Jp0IZZCFkSIS4UtmXEX/2WwEl2dI8IdPIhNacj?=
 =?us-ascii?Q?HDA2Ty7OH4S91GwxhvmtsoD0zSVumJTb5oYgvSUDdWBiWQ+gBHH8/41XjSHg?=
 =?us-ascii?Q?fzeA51Z8gGO1RlcE8Zb04kheZwkloa4J+Z+t6vvqboTXoiDzoyboeWwpoMNk?=
 =?us-ascii?Q?o5RjrI9drpalp13sdEdn7EcXEXFK6Uo0L9/qw3NVRaMhc32mfJyGELdiuMgI?=
 =?us-ascii?Q?FW0W4yr++JzsxG2kHoTHn5ZV+f5u/bSdb7GPZzIe9YMCn6HqJIlkUp0O2C7i?=
 =?us-ascii?Q?YaDRI/12zQjq7qfcG6mjWd0xXFQ7AE+01kw7pyBhEXL/gzgv2Tugpsoqbzi5?=
 =?us-ascii?Q?3LF+Fvu7SGXJBY1WP/fIxnE6OsZbdrRh6U8UE6kmsyvhR+c4zSdhSh7WJ5kO?=
 =?us-ascii?Q?9teAucrs8qgcAasrr87QCzx5brRb8FA4jJ3ctpZhWIxfPiSWDAKZIPCyq/3L?=
 =?us-ascii?Q?vKDUtwGx/hxCVTALgOYw6bt/f7QfHAULc/G7H2j3TFxrYqIFXED1chjFcmGO?=
 =?us-ascii?Q?CX8xA0AfBRh1CjHXdAXkdsy2ye6BtvKWvs2C2mkD1wt85R0P9r2Et7eG2Nnd?=
 =?us-ascii?Q?UXheS9+FDeO5cwGJrpcnW3Cl/UBT2O8LSWN9IvYLa9tsqoE36Lz7Q73bVjxa?=
 =?us-ascii?Q?zc7NComNOGoxEdzui8+0K6uPIIbISwdnnjfohvbvqnSL+Gyhe9NzOJKb7ROU?=
 =?us-ascii?Q?cpcTQ/woMk6SB/qc8BRWdW1HF82N2Om5kPXTsc4AvS5WoQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZP153MB0791.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8Exerk8OoHjOLNlOZI89qNH54YVnvIw2djLm9AkfRS+hpsSScVE0y4lABFEg?=
 =?us-ascii?Q?fUEMRoxs46DQJ6sqH6UkuL0xXRhVD8gQ/jrD2+Y43iiJc7DKBeiDlOBBWuPk?=
 =?us-ascii?Q?xJhWK/g2neKkO3T8N7VEUBAlhyD0WVqKCuQ0jXul3hUeK8UVBEEHB4+Yv6Wr?=
 =?us-ascii?Q?cuh7cuzuAQB9hQymr0yGwQEEm49KRcLmtgxIcJqyWVxWm4pClIJ+SY5rB+Yv?=
 =?us-ascii?Q?L2LAou8ibtau5rZWV4hcnE61osOQ0Wd1leH58XGdt36dszDNVh4qV2LRQKHx?=
 =?us-ascii?Q?F2Lpy4RlLylTVB6nfBvVDNc96C04O92RF3HED0fHyEFveV9bzlIJdp/qBQe9?=
 =?us-ascii?Q?r7WuW7p0RGs47+8NvyCgs0ubwWN2DPY9AFd3lAOwiNYrlvfqcOe8l5npxjPi?=
 =?us-ascii?Q?Rs5+fP/euqEf2LsxVdez9coe24l9E/MTemvfb6HrlJCMqj1lbDr5fsmzQ4QI?=
 =?us-ascii?Q?hwXpRRtJH2r3N8GCoayedpCT9POTFZz0+PW62lUUkoGgb2s+nG74Friku9LV?=
 =?us-ascii?Q?P0ZeTVkSJtttsHzaj0iUlrBauQPLoDv+lB8jAxbuQmvpEC2fvnasoYKDl88D?=
 =?us-ascii?Q?Cq/EW4wDVoDNyADlRe+kCWEDnk/aTIpx7dWU3jrpYb8lFRHHEZ+sBxa7Gl4Y?=
 =?us-ascii?Q?of3ARWWCLGoo63/UByfqlWDDWH8yf75q8hCL1Ux31AOujdx62h6CdaN0gKJp?=
 =?us-ascii?Q?OzbKSfhFCcoaRQ/KXQGL5ZGMwwDtsNdKr1OwSfZ6bDd2uHlM068JLK5jIIob?=
 =?us-ascii?Q?MqNKnX9kLnHA39DnNplFisUKkac7e2V3vCBAP2BZL35syygNunBIY5eo0XD2?=
 =?us-ascii?Q?vyx3eNsP87Gp5RfrS/wIpzeb8M9JMrN6Ap01xTvAJIhjVClY6lJvp3bz6XXl?=
 =?us-ascii?Q?jAA98C35nrh0HqH0b40q4OaoXgLjr+C4mb4dcy4hPI+R1cYS50i5XXZAlnD9?=
 =?us-ascii?Q?T9Q+QtGLLanvPY5rL7VJ1qCpQxF6OWG1LIsMoJA/GdLvWI+KtfvFNS//WXNf?=
 =?us-ascii?Q?BUIm21Wc0ZRgI8A1SuV2+QsmxnXF6bbt26LOvULiWl3/BcBZhPNqGQ9RIPM+?=
 =?us-ascii?Q?3fAhWLN2vQos+22eUQ+AMkQ2ggubbcDpZq0kRwIsuH7gj+Rii4g9o/R0r6bP?=
 =?us-ascii?Q?cgh31O/DKbm/u95hVXrMSOJEDErI4GPC34zgw+pt7CZK/Q44+fgNYnhWu2wq?=
 =?us-ascii?Q?/cN2a6CtOXzxP4e1buKy5fbc7BocmwnLZBUjoRfIwUgWXPvD+An/XT2fGI6l?=
 =?us-ascii?Q?tekkhaqDoYFmC921xxa5dNfpMKmsl0mG99H1bzh6EknlSm1wCw4aem0R6DhZ?=
 =?us-ascii?Q?Z93vUtkkYOajhP00VhVp7QS50MXMpkqVFjn4t/xPsQJXTnEPAuFKc8CJ588y?=
 =?us-ascii?Q?rG/CdRdEqV7Jcc6t50X5slfcWGsVVA2ZO/hf9+ZoZmSvfdi/7SmWCtrH/a8u?=
 =?us-ascii?Q?9eMGt775YiZdCaKIv8ALS3i62nfPBcyPiRTrbIhQmwxc0QFuEYdSRcgeKyuT?=
 =?us-ascii?Q?vzJNo81IzOkaH5Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZP153MB0791.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf133a5-3446-4511-d05c-08dcd8e4a170
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 19:52:45.2205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uRxbSaDcmA+01B8tfS8PCHuudOsZjhxk9CQ8XZrc2JUkNuruEcY/WODXsUFEihfmWiNCBeU7LyZOmn8imZJFag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P153MB1004

> > >
> > > refresh_zone_stat_thresholds function has two loops which is
> > > expensive for higher number of CPUs and NUMA nodes.
> > >
> > > Below is the rough estimation of total iterations done by these
> > > loops based on number of NUMA and CPUs.
> > >
> > > Total number of iterations: nCPU * 2 * Numa * mCPU
> > > Where:
> > >  nCPU =3D total number of CPUs
> > >  Numa =3D total number of NUMA nodes
> > >  mCPU =3D mean value of total CPUs (e.g., 512 for 1024 total CPUs)
> > >
> > > For the system under test with 16 NUMA nodes and 1024 CPUs, this
> > > results in a substantial increase in the number of loop iterations
> > > during boot-up when NUMA is enabled:
> > >
> > > No NUMA =3D 1024*2*1*512  =3D   1,048,576 : Here
> > refresh_zone_stat_thresholds
> > > takes around 224 ms total for all the CPUs in the system under test.
> > > 16 NUMA =3D 1024*2*16*512 =3D  16,777,216 : Here
> > > refresh_zone_stat_thresholds takes around 4.5 seconds total for all
> > > the CPUs in the system under test.
> > >
> > > Calling this for each CPU is expensive when there are large number
> > > of CPUs along with multiple NUMAs. Fix this by deferring
> > > refresh_zone_stat_thresholds to be called later at once when all the
> > > secondary CPUs are up. Also, register the DYN hooks to keep the
> > > existing hotplug functionality intact.
> > >
> > > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> >
> > CC: Mel Gorman and Christoph Lameter
>=20
>=20
> Adding cl@linux.com instead of clameter@sgi.com for Christoph Lameter
>=20
> - Saurabh

Hi Andrew,

Can we get this merge in for next kernel release.
Please let me know if there is any concern with this patch.

Regards,
Saurabh

