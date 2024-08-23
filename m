Return-Path: <linux-kernel+bounces-298600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8C095C946
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3183B213FD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487C814B97B;
	Fri, 23 Aug 2024 09:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="RGm1TUkC"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020090.outbound.protection.outlook.com [52.101.128.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EE720DF4
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724405553; cv=fail; b=Q82MwQ3pGsklSr6wE02q5L9xfsdmHuk9MZTfEHmBHdsoOVnYpnvdLH4S2d5DmpcKODv608596pEYMcFEmeLSjOJkvRGlXt0m0BaMhH/crQs/GQciJ95YrWF0OJBRyW72yM5lTQUWXm+KSMpozVWN4XHutxpmrpigicGUTpkoAfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724405553; c=relaxed/simple;
	bh=XYhT7avAZBFcgWcfeUwkLTcN/9ktXGvP5RC3Rr0WhDs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TXjrVOYCoo6V1tR49U8V7tMpMVaf2R4EeZOJrYErUlQqqUioc+5dWYmdhDuDTvApLj+FWxZQfP5T5Uv+yLbCAHvkGbA9QHo5X2oWVlvLWO6rMOIw5vhCbKUsAvbR+tQXBs0SQSS69Y3ptiAKHaq157Jo6ZnJTC5VvbVf6a06RVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=RGm1TUkC; arc=fail smtp.client-ip=52.101.128.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0bhm6xVofBBwHaXbuMYFU/u7ocKbcdM4Ap/dT8EH6KbXjdAu7QZXoQMj6/+wkIylipyjENLHzXITpoXl/34hiRwOnPkbnvENNxphhQxZFrtOGFQhhkMyxfdh3Zxdm5jBa7Tb/f5G5elnli2Ji/nyOwfejbMMXhWcXsezaj4qmrbWj4XUy/3STthLpbinq3GenopSKqEA5V91stk1dVUabMsksLq+xTXd2hVEhrVW2UtPzMBWdx4xVsqe91FeaLDD2cmcVxFssSOy+rlpUNCapBNtCjeZsV4A4536LcyEz+adBKRToMTAicLJ5q8eFLv24jWaDRIUgUP3GRg+Olpww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TA0ozvkcu/DZcR8XWIjsmy4THjpPecQw+79xSQFzHBs=;
 b=BQhJgEcxFsjCy5RfVkqTsOfnHWdT5Q8nY+hFP52vslBScZpOM5s9br812bnaJGXijWzJVjhqtF8kb8V56+YHO6Y6uVpu1clY5BDZaugi8ypbS1Kh0AXA6u90dI158KCH1cHqpzJ0cmJctHgZiHUkpAwfB8Dl5ChQBGX9PhC1okLHUPMB0hO820VuxoRtTIL7CsQUlyS5VNEn0YNobvjwvkqCTpidW4y8RE4iuYOkhkL/p2MAmUZzqQc3+TbwD7ltar8PU5yBsch3FnidtzVqWdaNnoxI/CVMw9nh9RNI0M7P9wvfoY8AwvuFKYSuiNvm5XQ8K5TEWsi6beEp3/hTJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TA0ozvkcu/DZcR8XWIjsmy4THjpPecQw+79xSQFzHBs=;
 b=RGm1TUkCzJ7nJLfRaFWShrhMJY/2ShBrgMPg4tWgKlNNz5UpNgIiH+IWHeHslpIlZct/F8EgRSLmkHMwVmdHRRNQl+7U+IzpX/S6sw8chdqrgjLOQ8vwADKXNkvab5iVSeIZqQnFmay0PAUPPDabJUcYS42lSrgWyv3BdLkvn58=
Received: from TYZP153MB0796.APCP153.PROD.OUTLOOK.COM (2603:1096:400:28d::11)
 by KL1P153MB1004.APCP153.PROD.OUTLOOK.COM (2603:1096:820:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.9; Fri, 23 Aug
 2024 09:32:27 +0000
Received: from TYZP153MB0796.APCP153.PROD.OUTLOOK.COM
 ([fe80::a481:ba0d:8985:aa6f]) by TYZP153MB0796.APCP153.PROD.OUTLOOK.COM
 ([fe80::a481:ba0d:8985:aa6f%5]) with mapi id 15.20.7918.006; Fri, 23 Aug 2024
 09:32:27 +0000
From: Saurabh Singh Sengar <ssengar@microsoft.com>
To: Saurabh Singh Sengar <ssengar@microsoft.com>, Saurabh Sengar
	<ssengar@linux.microsoft.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "wei.liu@kernel.org" <wei.liu@kernel.org>, "srivatsa@csail.mit.edu"
	<srivatsa@csail.mit.edu>, "mgorman@techsingularity.net"
	<mgorman@techsingularity.net>, "cl@linux.com" <cl@linux.com>
Subject: RE: [PATCH v2] mm/vmstat: Defer the refresh_zone_stat_thresholds
 after all CPUs bringup
Thread-Topic: [PATCH v2] mm/vmstat: Defer the refresh_zone_stat_thresholds
 after all CPUs bringup
Thread-Index: AQHa7H7Nue5A+aHys0+ngkXGeUO6jLI0pOvAgAAAiqA=
Date: Fri, 23 Aug 2024 09:32:26 +0000
Message-ID:
 <TYZP153MB0796B44322EAE4C712883201BE882@TYZP153MB0796.APCP153.PROD.OUTLOOK.COM>
References: <1723443220-20623-1-git-send-email-ssengar@linux.microsoft.com>
 <TYZP153MB07963DDE4B7E01C575B143E2BE882@TYZP153MB0796.APCP153.PROD.OUTLOOK.COM>
In-Reply-To:
 <TYZP153MB07963DDE4B7E01C575B143E2BE882@TYZP153MB0796.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4c9e6c5b-38e6-4311-9e23-3cf5ce942a40;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-08-23T09:29:30Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZP153MB0796:EE_|KL1P153MB1004:EE_
x-ms-office365-filtering-correlation-id: 21604226-3381-46f0-cbd9-08dcc356806e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6q0u5/1UDr+RmbFysvtpECJ2KsHVbbYeEQjVA96CeoMqCwGxMCCb6xvGk1ST?=
 =?us-ascii?Q?j8XsBhP79yA+kjU4CG7Mhl+1pZxdP1xcSgHRD5BvMrl2jnNGVU/qP6h0k409?=
 =?us-ascii?Q?UDt+vj27SEy3VA3bl9LO80rceEJmp7ArJan47kevOhG4xBscFhfqa4fJQI2B?=
 =?us-ascii?Q?LpMmDpRMjs8tcTmwZi7dxHhJPCRTGdKIysderw18vynuNhn6AZOSDGVOGbd2?=
 =?us-ascii?Q?wu3HAclkBYnuvwZHuwpx8O5JJ3W7trzPdWQyhda4p0o2IblVk1RicAxWIncn?=
 =?us-ascii?Q?Nra/rALPe/cW9+gaya39PRfCafefJxv2/nYDwYKMVMssFX5fvHLC3/iZBsFl?=
 =?us-ascii?Q?HRpq1pCai/8E/UBw3UMiNNU8XWDs5EUB9fqATsQxlsp2zp881EHM5syiSYVc?=
 =?us-ascii?Q?vONafWPlcRcWKeuuFy1c3Bj1S4xAM9aQE66c6bD6Vo9sArI6QJa4O6cPNOgx?=
 =?us-ascii?Q?LmRmpJcu3hoR3XH4y9F+E7fUncNcEdtsqmcTbfB33tSeKCVtrpkdxLS11t6H?=
 =?us-ascii?Q?jH3LchuOdWw/AgOepVBKyQ3FO99+Pmx4UqvcjBSYtErHkDkahYF14rO3hvil?=
 =?us-ascii?Q?g0YjsMHQcgiXIuVEpEY2vLiP8gE5QH3XS0VJ2Zft10zSYFQRwFrB4Lve3119?=
 =?us-ascii?Q?YSdhlU5DDlthCmfCbNsPt8ILWPI5JSYUZDXJ223u7YjQ2RWMQRvUSH4Ouzt1?=
 =?us-ascii?Q?4ulzAYhOy/BpMH9JNnjtj5aIDj17jHR5b0T/Wplc7qHTVARsln+uSHeAHr/k?=
 =?us-ascii?Q?dCQQh7tSjIjw+6Bl+FPgk9mWkCUk8Lco6LYvxTpJRarZd5Clww5cUvDy7Tc4?=
 =?us-ascii?Q?z8csj+sApINYpySWGI5vAyBek3bH/sRcanp5b22m5ZL+ku2oFdfnSBy2kTk2?=
 =?us-ascii?Q?TdrNDURJZnsMsq0i/hPOMF0LEzwRcIyJAZTpxwBI2P5JMEl+mekGbuGNto4e?=
 =?us-ascii?Q?eh6DW1Kw/6XXeCSe3LIEwl2TQmsiMw3GI8I9eJdDhsJvwt8h1cTrE6ZkIpGb?=
 =?us-ascii?Q?/dXtpxcuuFIwPqTR0VG6TElvvLZxCjA3ta66+V8Chc+C3lKPmqUvzD8pLORP?=
 =?us-ascii?Q?c7VYkntUV16Fy+wK5uNQQTfUdC3bLtxKUoW1rVJfzLkoWeB2aSvo6OeDnRGZ?=
 =?us-ascii?Q?YydTVT3QWALFn28CPFzpTljvZoTLhYLI+p7dtYhGh7a9DBshHGeIHfdFeNPf?=
 =?us-ascii?Q?2CFAJXuOdwPosHFimWeYfAPkDjhZJ/0hnMGM+QsbAhUdVFO9zTak3mE3WlDF?=
 =?us-ascii?Q?vBauTLbMch2h7xi3ry/oSvrILvSGjOq3fbl68ncIbtQskKQ+LEBtiupZbmUb?=
 =?us-ascii?Q?086DWTP+QF0GOjR3YsEw0v4XPZU7/Czib4a1eiTqrHUIhUUfRgswmm7jRIA2?=
 =?us-ascii?Q?DZHUEceWCiUN5s2+g0f5d8nBCKQqXZSUzT6ieLCpnrKtM+tLmg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZP153MB0796.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?u8Bt243UbbKMb9WUA6NAkZBTq4gzJEms3aYUE7uKtUlTS10s3/jzsgGN/9iS?=
 =?us-ascii?Q?aa5tPIRWVCdYDm3/XGR97zts0yvzHZo9zkDTFYkNv5MTh2AYfhiTWIIjakjF?=
 =?us-ascii?Q?7brUvLh6K++0fglliZc9i9M18laJxEcOWvGmss9I1II7LKOLmi7hDZOZ502B?=
 =?us-ascii?Q?qTq1A6zHtMYeTCrg6wvR/jd8gFaPqv1O7okQyBWloGSDcmxKqCwkQn08sZaG?=
 =?us-ascii?Q?nfd7WpCq8zgqedyuMLnQqz7Wq6XoCzYh9opjMgfsyAUDcY0evCfgKGXYLyO4?=
 =?us-ascii?Q?NSFt4Obm3ZmmyIUp0CzNQcXMU4Gtz27XtSDcRCa53siuxedkI2gucHyN28qr?=
 =?us-ascii?Q?hRK6U4HWipfTxMAWAETTDatAyepPTibA+GCgMt3c5DzGSg9tFIWBxVFT67ri?=
 =?us-ascii?Q?s8hNwyN+Lz85V6eMxSkMKZwR6ItCBsBRZ3QvW8M93hkwBYELw/Zp3wFEu3aS?=
 =?us-ascii?Q?TLFOLx8TS2OafhnCTh+8PoFbVsiS/OoGz9LECSINZngibPQa8nsDbWNp2y21?=
 =?us-ascii?Q?R1L0wsqactMBrUClKFys3XzHhefhw0uTxm6HQF7nJMR2Fh318yq6wl61uxY4?=
 =?us-ascii?Q?5zZhVmlAdKYxq7WVFzYASMEmOYVVQPCVSEUtHoeXMoj8njbCelCNwpOZ+Jl4?=
 =?us-ascii?Q?xdCSiOZYF7v6A+ENaiEZ0yjv6tw27zwcZA7JOpn+iiqqzwdzaJLDJkaQuIHr?=
 =?us-ascii?Q?TmA/R3bkfXFVhvQ+VN7ir833BdMJ97XPOmi7hdW/aukIpbPFVWwHlvi34kuD?=
 =?us-ascii?Q?P8wtPEWBXgufyrTx+mmy02c7Xn812cj9OJDWD91zzWWT2uuALU/xSrCXP/6R?=
 =?us-ascii?Q?SmqQIYg/fsaZyibKrZ1lKN9M2CXntsxYaRNkmsmp5C4phK8oYwHZlW7GUhWM?=
 =?us-ascii?Q?0/MBB6BZhY/KgVgEXtsQ7lwV9r2ihLzvR4YYMfb66iBIl/Axh/ek+WnF1CSh?=
 =?us-ascii?Q?Ub9wPvHOXzNj6QoOSjzGhQ3yK+L+D5ilt9ZkYmXZwvGnyhE76b6q4TJMZHkQ?=
 =?us-ascii?Q?+RcUlYFlRv/0BBzCx4OeLQtTTgEvmFdv0Dj3PU346Switqx1oWEjRv39Eb+T?=
 =?us-ascii?Q?kgjk1p75xA8ORWzYTRp94sqsIYNp1z18+YedbkO++tVbCVGM034rvPZ+TnGd?=
 =?us-ascii?Q?yPR5lqHORKyULKZt6h/5eR9YU93pjOWOOisAyLYSnJ7knMGDJ6x8OQurvFqQ?=
 =?us-ascii?Q?MbVanADxEc8YTTRII/RiXJ8+nKvszgBWkY3zCQpIoy84Mzh6vAmd1l9RMkHX?=
 =?us-ascii?Q?9kFFroFZRB7QIDYix3y/5/0X1hhCaaklhjgCWG4Flq8zt3QY33B+FGVQ60UQ?=
 =?us-ascii?Q?tNS6pjkWA+XjN0KgDV94JPANYi10G/gt2t7MlfIXmqlqy5alVxqfXYX6yne9?=
 =?us-ascii?Q?p4ECPyep1S3gqFsZSRqJymUrT+lnkk+iQlfp7hHBzQIPNLTveBUoxuYnue3I?=
 =?us-ascii?Q?v9X48fTPlFd6TXxAGx7Klf0hpIGwPNz0qbtPkwn9lBM0lPh0C1B3Q9ENnkUA?=
 =?us-ascii?Q?/lgwL1+Auqn+FniNm/P/BnyaV2ddDGu8D77S6mVhB/uxNldoBnWwieQ3K6dt?=
 =?us-ascii?Q?rYM8NdmoBp/95tqZgbKBLqJdfzsWrl0uwODFtPMu?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYZP153MB0796.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 21604226-3381-46f0-cbd9-08dcc356806e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 09:32:26.8611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0SHFmay9xlw+J8ZChOdXQEVrpn7akR5rBqjKo2v/QUUABVR1cUujhAdwGv1Izor2y9MuH71CPqh51mmDlezc+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P153MB1004



> -----Original Message-----
> From: Saurabh Singh Sengar <ssengar@microsoft.com>
> Sent: 23 August 2024 15:00
> To: Saurabh Sengar <ssengar@linux.microsoft.com>; akpm@linux-
> foundation.org; linux-mm@kvack.org; linux-kernel@vger.kernel.org
> Cc: wei.liu@kernel.org; srivatsa@csail.mit.edu; clameter@sgi.com;
> mgorman@techsingularity.net
> Subject: [EXTERNAL] RE: [PATCH v2] mm/vmstat: Defer the
> refresh_zone_stat_thresholds after all CPUs bringup
>=20
>=20
>=20
> > -----Original Message-----
> > From: Saurabh Sengar <ssengar@linux.microsoft.com>
> > Sent: 12 August 2024 11:44
> > To: akpm@linux-foundation.org; linux-mm@kvack.org; linux-
> > kernel@vger.kernel.org
> > Cc: Saurabh Singh Sengar <ssengar@microsoft.com>; wei.liu@kernel.org;
> > srivatsa@csail.mit.edu
> > Subject: [PATCH v2] mm/vmstat: Defer the refresh_zone_stat_thresholds
> > after all CPUs bringup
> >
> > refresh_zone_stat_thresholds function has two loops which is expensive
> > for higher number of CPUs and NUMA nodes.
> >
> > Below is the rough estimation of total iterations done by these loops
> > based on number of NUMA and CPUs.
> >
> > Total number of iterations: nCPU * 2 * Numa * mCPU
> > Where:
> >  nCPU =3D total number of CPUs
> >  Numa =3D total number of NUMA nodes
> >  mCPU =3D mean value of total CPUs (e.g., 512 for 1024 total CPUs)
> >
> > For the system under test with 16 NUMA nodes and 1024 CPUs, this
> > results in a substantial increase in the number of loop iterations
> > during boot-up when NUMA is enabled:
> >
> > No NUMA =3D 1024*2*1*512  =3D   1,048,576 : Here
> refresh_zone_stat_thresholds
> > takes around 224 ms total for all the CPUs in the system under test.
> > 16 NUMA =3D 1024*2*16*512 =3D  16,777,216 : Here
> > refresh_zone_stat_thresholds takes around 4.5 seconds total for all
> > the CPUs in the system under test.
> >
> > Calling this for each CPU is expensive when there are large number of
> > CPUs along with multiple NUMAs. Fix this by deferring
> > refresh_zone_stat_thresholds to be called later at once when all the
> > secondary CPUs are up. Also, register the DYN hooks to keep the
> > existing hotplug functionality intact.
> >
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
>=20
> CC: Mel Gorman and Christoph Lameter


Adding cl@linux.com instead of clameter@sgi.com for Christoph Lameter

- Saurabh

