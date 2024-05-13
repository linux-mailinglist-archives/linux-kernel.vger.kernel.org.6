Return-Path: <linux-kernel+bounces-177789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77D38C44A5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D1A1288A68
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CFC155346;
	Mon, 13 May 2024 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netapp.com header.i=@netapp.com header.b="BjxeXUmJ"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7971715443D;
	Mon, 13 May 2024 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715615613; cv=fail; b=PQuwKQijxI4lddAj+Na1dzmuoVj88Q/Eef1d/1TJcSn0BOeRxhqBiuglGPWz4jtgwmiyTuGrhrY0JAukvi05pklXYFQK34guNv5VWUbZ+q0rnBpbn8ipeKRr/V9E14SYaB9846AHjEBZ+tQqiBzby6fBGfjPE6q7N/U2YP4ctAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715615613; c=relaxed/simple;
	bh=qQ0YEAZ8MiJPWIFj/Sf2nn4aY8jOFSbAaifsON9jzD0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WuMnKrou63Y9fggoiV03u/5mFnT8RprMceuIKvqc/ytzZ7A/mgz0h9G5bViFT+L8s9ZRTWdnv4HhLqr+dM1VSmq/ehsflHuIfZ4APT+y4YDzipsfZ8UjVrK4cV0HZBSurT7JzX3kqGL5+A8hdqIiKpp7LTu3txoF951ITUOPaWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netapp.com; spf=pass smtp.mailfrom=netapp.com; dkim=pass (2048-bit key) header.d=netapp.com header.i=@netapp.com header.b=BjxeXUmJ; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netapp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netapp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9qhTrM2b7G85jDXU4tDMpTpGzlJkMY9A4p3zicnkOLa8QV+3axFII/DGAtflOEnBRFDx/ATJ6QdAK6lN+crfsjHBvQKJM40h14hnmnszTMqjteY1GdSzYZPVsMzVjwB/rOB/3f7C4edwhIwCFKREWsmlU5ZQ+H5ejz0ypZAqR046KPU1nEBKQLaWK/bogZNd5g90F+a44M10oaCZYqSEj2LiQ5KZDqkKnuX05KRMKkpDjoQXBZ1Yy+Pgw33AJ/Sl1LzrdKcSAH1UH5O3Oc4MiS8iqirSmnSP6U3AUcoIS1Vh1BJpx+66xHr9AOqAYUgim3fE66yzyDVXowwdwb/BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQ0YEAZ8MiJPWIFj/Sf2nn4aY8jOFSbAaifsON9jzD0=;
 b=fCyIshUcan2o4xWINCgXXcQf7WlWgvgNK06EI987droUxC4vWUsd7HpVXpGZ3zHNNgNTBHDZPFLxXk4UYDhGLLIXYbigkl9sUvPeolEmwm0svLKpksoZ/hXZnVDI3DDhk+xhYe2+XOcs1Wy4kCCMczvdpeeBtsR8YvX+alGVmuKLtjXtvdOeV8gJxLhrwokUcOIBwn3b2dF1sNVkSmTSO+qKqXlgYXIU9brCuX0Xy30HAXXS5Zvea4GJj9FEgmuPkFf7xdMs6QbcUuJNuE1OiP9Fjfa4jhcsNkSlGH4WQT4MbAB6PgnuKcLVRvs1Obszp+nIGNjjcytmKkDEA8ESFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQ0YEAZ8MiJPWIFj/Sf2nn4aY8jOFSbAaifsON9jzD0=;
 b=BjxeXUmJBaFexH0nDu0ACfgGIY/2idqM68o8wn4vHeQo40m2dTSgRwPDCFrvbRCqxoLtJpTdAvB7jgXamHfcCq1v0s6y3ss80GZoojGsohkilPSwC9vwZtBh0EI0yh2wrb2iBqA+4doXLsVbsz6Rf3I/PBgP2vvWpL3i3cFByy7zXuzuybR6S9J/ecp7J2QY8h6lmoTMcet/JasNe1bUKQs9GOvcu468+BDHc+5MQd/CXgW2/rb4hd85a0DKmXQ8/IRSHLVO+QZj8qa5Kq2390bTHhQ69NfL9YnJ8v+QbjWJc4VvRAfFpT2oEEFY2tQV3kK9azQqfccs3g4xg0eCmg==
Received: from MW5PR06MB8930.namprd06.prod.outlook.com (2603:10b6:303:1cc::5)
 by CH2PR06MB6726.namprd06.prod.outlook.com (2603:10b6:610:82::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 15:53:27 +0000
Received: from MW5PR06MB8930.namprd06.prod.outlook.com
 ([fe80::f01e:ba25:47a7:6d7f]) by MW5PR06MB8930.namprd06.prod.outlook.com
 ([fe80::f01e:ba25:47a7:6d7f%6]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 15:53:27 +0000
From: "Fradella, Ben" <Ben.Fradella@netapp.com>
To: Hans de Goede <hdegoede@redhat.com>, "bcfradella@proton.me"
	<bcfradella@proton.me>, =?iso-8859-1?Q?Ilpo_J=E4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, "platform-driver-x86@vger.kernel.org"
	<platform-driver-x86@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Ranjan Dutta <ranjan.dutta@intel.com>, Yifan2 Li <yifan2.li@intel.com>,
	Jonathan Yong <jonathan.yong@intel.com>
Subject: Re: [PATCH] p2sb: Don't init until unassigned resources have been
 assigned.
Thread-Topic: [PATCH] p2sb: Don't init until unassigned resources have been
 assigned.
Thread-Index: AQHaojDmTWyh9P8UA0GScbgcToO9wbGVFrUAgAA647g=
Date: Mon, 13 May 2024 15:53:27 +0000
Message-ID:
 <MW5PR06MB893057D6D58E498EBE16A8B0F9E22@MW5PR06MB8930.namprd06.prod.outlook.com>
References: <20240509164905.41016-1-bcfradella@proton.me>
 <7867b308-7cea-4282-82e8-551d88fe70c4@redhat.com>
In-Reply-To: <7867b308-7cea-4282-82e8-551d88fe70c4@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=netapp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR06MB8930:EE_|CH2PR06MB6726:EE_
x-ms-office365-filtering-correlation-id: 491bec59-961b-4c1b-71d8-08dc7364d411
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?7cwa7+fVxP03jJHbm+5zWXZKmuBswxIVYJl1VOJa0eXtohUxnFbBWZBreF?=
 =?iso-8859-1?Q?n+df/7VvVdypM43Gldyqqc7momxGOCo0iIR/cLh/DR8ea23NZ0ElQ3Xtlf?=
 =?iso-8859-1?Q?aOuHdNI7sD+zG12o/AeO/BV2uVAZad6wZ8V4SkZyW5MsGLQO1GrqCBL2ej?=
 =?iso-8859-1?Q?yxp3M5ulmf+pW9XqwKo7Brg9xB2xYIVlTclfyr8e8wHW4Kot48BVIb+0lz?=
 =?iso-8859-1?Q?agppMkNr2LHufiojeIZ1nHdc+i82dTaJfvWSdyPyk0kTrJ9dPNXrm6Ii7s?=
 =?iso-8859-1?Q?lvY8eSZ9ym11Vh8Nc3mH00Eo3fQkn3NaJ5WJV1+XAZ9j0O0oDUfnMp934t?=
 =?iso-8859-1?Q?7W2xG5tj8gyuCslFE2hYXKfwjduXkbk1S/58crzJc9tETSKfmmqMXnQBQk?=
 =?iso-8859-1?Q?JiFU2iveq7W7NFms98D70yBEy60xC7cDziJ+S59qu5Vlr66jT7cw5xzFsi?=
 =?iso-8859-1?Q?A4tuq9f0Y530uin1U6dVnYBPU0uVAhmH0LQKwDGJqa6K90Q8bkQyzbnVfJ?=
 =?iso-8859-1?Q?ex3ag1gcYt2maoBaYHOX0ZwPEjk++SjHBEvJXxEBdTWbozrSxQar2ZAF9m?=
 =?iso-8859-1?Q?I6C6KowXW4f6qyR7d93N0kQcvLR+YWA4S3s7Is/1tryPbf0/XBWDtCkMs2?=
 =?iso-8859-1?Q?wvcH/HUZW68kSMT6r5vAHrNERYnfFamZ3cYHAcOzhSdzV66gKH8crdV9Ww?=
 =?iso-8859-1?Q?Ln+eJCXnOFJQXMjEBDdl+eiKX3U4d5SVfK8rtEEeD2OwTF0a7jHWls/9fy?=
 =?iso-8859-1?Q?hF5owJdHnVsgM/VGBfHD9OPLkDGhtJNjHbVbxIVYcsvpdGma0fiSAvCU35?=
 =?iso-8859-1?Q?82hjlgGtTlgjlsy2KpGv2td8PfEmSEjsPFmn2229+sboiqnPBKdDRtkMlH?=
 =?iso-8859-1?Q?D1lX0yXNlJv+cG2GJQmbUB7/Zuij5SpBV1Fd/MykZ9V/XwOr7eFyaKZ9Td?=
 =?iso-8859-1?Q?bLZykbI+c1ZwI5r8zR8GF/8IM9L2TUttWi2EsFgi6i19bLOLY5CPu7iFO8?=
 =?iso-8859-1?Q?k7N3z7aakCC2aLB5Wtn7ggyZnFo2k/RDPaAAaTCu/ZtYkyPXRZzjBUs2m9?=
 =?iso-8859-1?Q?4XtGTlpX5zJ3LPwpua/fnKmNO/BLMcf4zpzY/D1HtAG4MpfxUvXc6dEzlu?=
 =?iso-8859-1?Q?thzxh+Ofey2OXb2l9SScVJbQuJPNgYLI96mBu9pfgpVx0keSuz4Xftwtah?=
 =?iso-8859-1?Q?2BBVmtsV4vdy11+AxnhQqjULvBZUWC1twx3xplGzzZH+NZZMi6uwMcr7tq?=
 =?iso-8859-1?Q?2CaSSzmOR9aLCbUFWMNOgSmB8lQfpOUjGWL2nMDsONqnc5V9KC0VeFHpae?=
 =?iso-8859-1?Q?aOgcBioDXTYZ2tYW8r7U+ExP+Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR06MB8930.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?y3nQvpHzu5ZcT/C+Ckr0lOPZ443FLyMPdsxwYDH7bmQeK1d/5+1hoCQZer?=
 =?iso-8859-1?Q?gciO0lj4K6PdPn7ONn6S+/uNOfvXHIP0KhmPm7avn8QEwwqRJ0Yf9udFao?=
 =?iso-8859-1?Q?qjN+BzrSjXGNSjoKzQHnwUEDlwNdHfZj+JsCD4xi6nPCJDUiAMRtnXoZyp?=
 =?iso-8859-1?Q?xTqZaHJ0yXwTDDB4UAIHhBriR9jTQ20b+6sC3BVMLLii8zzcy0QpsQV+z1?=
 =?iso-8859-1?Q?KPCqd8FRAr4nDDaznTo6DwNvDpSFtClSsG43axsipQFntBvWZcU57+kJjW?=
 =?iso-8859-1?Q?1gNAMYWXN+A/H5CSCaVS80VAiuKBoDB01P/7/5XPFqb3zsVXSJQK5Jk4P8?=
 =?iso-8859-1?Q?ek3WTaca5VtfP6F3l7oMOOCL94bn60ShWmh9wtuz/ryNuhjQQN1m/9AcG5?=
 =?iso-8859-1?Q?if6MzAJz2o7gC4+HQay6ZxOZJm5/ICiw1FIddxI06RIfQFpQ8EBmUAMMG6?=
 =?iso-8859-1?Q?PcrpBpNAfo+YrEA/3cMT+5N0oK6u/9rmtCWk3eK1APQm8p7LrJE+nX0fRq?=
 =?iso-8859-1?Q?d7PCb0VgrCeWkaJrQ7J9GTFZIPmw1hSN+oZiQOkW/6MyEk1rOud+X1YSCw?=
 =?iso-8859-1?Q?0nco9zDIXo5tLhYJhusoLoJApNlpJJVSoPL4vXVQzJwfOwBDPCOA88PMEG?=
 =?iso-8859-1?Q?ipJ9O2x92gT8MuR1jpbYymEqgOOz4angmLmphnhqbTHTId04mcX7jHlEGW?=
 =?iso-8859-1?Q?mk9pVg/sc29SyL4jdhkR91wyH4PKaKbdAwDAfT1mvABfDA4x25aSDIJNGj?=
 =?iso-8859-1?Q?5wnmFvVLo16Yx0jf2QpFKwHM+oyMyAUpFxd1bpU8mfBNSvCWORuLelaMRR?=
 =?iso-8859-1?Q?meTKpYqcVZtnBlLNLyd35fWZmK5aSTy6XpTuJjdtR6JRbmSzyQp0UaZ7a6?=
 =?iso-8859-1?Q?7h+GaguUP/rM3smGKwfmsAWPagOhdvfUSRB0hfrbtIwwaOi9mTUmdnwXsj?=
 =?iso-8859-1?Q?9D7KGYQ99OH13GIa/u9oEkfXrdoTlvpW1LgiwGrWITtbL9r0NVwxRJByE/?=
 =?iso-8859-1?Q?LuvZH9NQ4uBUaPYay22uMJ3e75QtVBNIyGQWKfabeBTN770adlPrFS3jPV?=
 =?iso-8859-1?Q?BomAfc2m34T0kYM4yQzqfNAEwZoiz7zxwc4A14m2J3554X1LlGEgOkXa3i?=
 =?iso-8859-1?Q?sz1z/DkymHhvTltxmb6BdmDFZlRHA0Zi8uacar9fGBgveU5oySmUtm+0Zw?=
 =?iso-8859-1?Q?NVuLUBYm8iqWyh0QUoRLiQ8gBfLyMjcrja06hqRoShtb4bIcB+NxiIWrR+?=
 =?iso-8859-1?Q?2zNnRAGwimxMM9OVLWhQoYeOyNlazEXUEo7ugcSE1JB2+trOp4YydB+9Vd?=
 =?iso-8859-1?Q?JZejTyVNOWHuOZ67C8ndOlVGBvVZ6tadxefO6aphrx3KaB2snV+ZBHV3U7?=
 =?iso-8859-1?Q?eLxfmmOOitgSW+muqEr+iUjzyvXT6sEV0AU5xHc1lcwJiUI+ApE1ZWCGQ7?=
 =?iso-8859-1?Q?P4iif+5ouaLCsGT5N10n7fNLIHvz6P6PhXGLiVz0BR5mRNTVYIUHjEF7ye?=
 =?iso-8859-1?Q?xHc3WA82AEWL9eSAMrhPbUiD3Wf1pq+NsETZ2c4xavAH8lvAG/GMn4u7cQ?=
 =?iso-8859-1?Q?dhhSCcy0bQuY2UXQI+fsUiufIhufxVlr3KiHvSBuiduW/QBBQvDy5MhYWb?=
 =?iso-8859-1?Q?VckqX44MUf2II=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR06MB8930.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 491bec59-961b-4c1b-71d8-08dc7364d411
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 15:53:27.1019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FAhDpvJ/lDzPS1cfkTYgH46FaXvIp4qiL9mvckiWYoyZET1ibeQvhvqfj53s2dxg7zhR2m7mfErUYy0nrdeDWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR06MB6726

> On 2024-05-13 07:03, hdegoede@redhat.com wrote:
>
> Thank you for your patch, I've applied this patch to my review-hans branc=
h: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x=
86.git/log/?h=3Dreview-hans
>
> Note it will show up in my review-hans branch once I've pushed my local b=
ranch there, which might take a while.
>
> Once I've run some tests on this branch the patches there will be added t=
o the platform-drivers-x86/for-next branch and eventually will be included =
in the pdx86 pull-request to Linus for the next merge-window.
>
>Regards,
>
>Hans

Thank you!

