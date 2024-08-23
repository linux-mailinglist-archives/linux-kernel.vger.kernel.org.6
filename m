Return-Path: <linux-kernel+bounces-298599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 833A495C942
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8B4BB229A0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F6614D719;
	Fri, 23 Aug 2024 09:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BiSEEoow"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2126.outbound.protection.outlook.com [40.107.215.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3603814D431
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724405435; cv=fail; b=mnv9fdYJ3tkl35IeXA4mNgw+qIb0zUOakg/7d3Wcv4brEMLuCThnc0+n5+WNsvjb0JVbUpGQHu/Lg0OBCAuiKFqRSJo0N8U4lXPu73W/Qw2oo0vhbYHMQBImDXArTNVm20hHyi2p+canTY+wfYyhQVGoXXqEJC9Wj043S3NOVyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724405435; c=relaxed/simple;
	bh=LDAMPVEjJyu4+5JkNYd4mqOTTsQx9QZtooCcETfvjdg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I1OWxNTZpZETe6gQCLq0RmCSr8cMgQGa2uoCm4lxtZIiEs3Cdub6uxpGm1vHNRrMxKvTCTFtWP3GWj4tQGMheDJELsTEeMiLlD1DfSpgjHItO86rlCZhuOL9RTXzFpqCgolusTi1Vfv3ipVFSk8Pry8JzLtaHl2HbDnFyCBuhwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=BiSEEoow; arc=fail smtp.client-ip=40.107.215.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSg6hzvJY9p/Y9zVgg10b1u0aCyR179/g8PsLOGzMlOlQCAsosFH5Hn3K4XG51kiwXD2qbARD9PdeNgsKuK5ltrk4aL7nobnewsq3SKPRwZwGwQM2ZwC6rB7uEc7fZdEbdgM48u4nSaLTQD7eLpuCVu5d+hQ2x3Q04Kh2XQBtB/vfJEtFHQaTGc87ULRUlnQeWo7rGEHgD3HDIhlfTuC1InCQW/anPaW6AWuaD7Kds4LU5VoKEyW/wbQgt9985f6Q2DcVaNpeoWzz5NhXe4gvKWshikfRcSF/F/k+Q7sVKNvxLCxtpqATjLzfADFCVdGly1PXCe4N82bNdWlyWzK1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQbssgGgTXNnugrO5GEHdM9mhr7DRNwzqRb38GaOjDY=;
 b=Ms3XLfjNoWaS28QpTi/IwZ0toRFSRlfsGX7IyEQ13mLubKkhTOYj5iChl61KvVOrmnpEonJyudcbUfOkPT/OMjA7TyDRpSm0+eVLBytwmhq/O1Atl+A2ts22dXcD9GN7O5zfsRzw7oLQnpFZn7FQyAztvQUIFneMZCyH/sMVT8O1IL/cQhabAxHRy/PEmCr+HIhM5O+n2T93lPXVvCr7dTs/CB1N7ZVjZmgojlASnx9GVbd0MzHWnbiR65RQzWV+Y06odW9gsL1nHPiDHV5MPb+KKaoeGZILau9QvJ9AvmehQ1zqiuGUFpQZMINweeEt+WnpMbVbkHvJPPI004oL/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQbssgGgTXNnugrO5GEHdM9mhr7DRNwzqRb38GaOjDY=;
 b=BiSEEoowL3sOGgE+tPcxHZaCvN/GwvnYalACGbIpj1DsCUCMPRG/881tQSiQWJ4yw1gmpvqjwVfh3dVohzbqiiEtRipTQ1RZC6VMXwySBQvkLf6+TZ6/MSQvX55+qL7wfsUs9gGArTnQFcaa5Haz+nKkPJMD8LRnuW8iR69fVBA=
Received: from TYZP153MB0796.APCP153.PROD.OUTLOOK.COM (2603:1096:400:28d::11)
 by KL1P153MB1004.APCP153.PROD.OUTLOOK.COM (2603:1096:820:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.9; Fri, 23 Aug
 2024 09:30:30 +0000
Received: from TYZP153MB0796.APCP153.PROD.OUTLOOK.COM
 ([fe80::a481:ba0d:8985:aa6f]) by TYZP153MB0796.APCP153.PROD.OUTLOOK.COM
 ([fe80::a481:ba0d:8985:aa6f%5]) with mapi id 15.20.7918.006; Fri, 23 Aug 2024
 09:30:30 +0000
From: Saurabh Singh Sengar <ssengar@microsoft.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "wei.liu@kernel.org" <wei.liu@kernel.org>, "srivatsa@csail.mit.edu"
	<srivatsa@csail.mit.edu>, "clameter@sgi.com" <clameter@sgi.com>,
	"mgorman@techsingularity.net" <mgorman@techsingularity.net>
Subject: RE: [PATCH v2] mm/vmstat: Defer the refresh_zone_stat_thresholds
 after all CPUs bringup
Thread-Topic: [PATCH v2] mm/vmstat: Defer the refresh_zone_stat_thresholds
 after all CPUs bringup
Thread-Index: AQHa7H7Nue5A+aHys0+ngkXGeUO6jLI0pOvA
Date: Fri, 23 Aug 2024 09:30:29 +0000
Message-ID:
 <TYZP153MB07963DDE4B7E01C575B143E2BE882@TYZP153MB0796.APCP153.PROD.OUTLOOK.COM>
References: <1723443220-20623-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1723443220-20623-1-git-send-email-ssengar@linux.microsoft.com>
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
x-ms-office365-filtering-correlation-id: 4eec2843-5c2c-4d12-c897-08dcc3563ab1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Gt7qGnQRYtFXoROwtnt1t/0FIUqgIoq5llRZMFkPcxdyS0BiYTxTNnuM/KhR?=
 =?us-ascii?Q?j4r9gJM63y6/lt3Tc8lQ85hCMCSCoxJl+6W6MSVuxnTSdk4q0schWfj5aAet?=
 =?us-ascii?Q?4Px1b3fHgcswKWmgNXuCPBhRE+/ToDnnt5e1GOJ/5itlH19K5etCfs+D9Ywy?=
 =?us-ascii?Q?N5jPIukG0ay95EvtZ8E0kwrGu8t+hYR46etH7DVuaJjaZw7d0VTigvWS/d9o?=
 =?us-ascii?Q?wU4fr/ymZti3j7yE0yuvhgKpGpfbOVB6yl0DJtMa1lOxySGdizLXOGLgEsGA?=
 =?us-ascii?Q?4L6CgrcMQ+h5tRLJDS5HLBwGMk9c7ESWgrpXRRi7lTI2+Du/sMDN9WcfSt6i?=
 =?us-ascii?Q?GWcalH22mVw39mkkZNrH5F+XJkInz19rV7PtsDpevzTMwSIrKNcg+GCMQXYG?=
 =?us-ascii?Q?17dQjA0KkJU4ZNkt0DRnksrASj/3hGzQsxuvcLsyFoLH02ixn68JGXAKynIX?=
 =?us-ascii?Q?2OpgrG/4S60ukK0zBceG86aXDsfm/5cZRmFbetsQ1Rba3NiMZq9U5uWXwx5e?=
 =?us-ascii?Q?N89gYtMzFHN8SVdo4460O3GZnOrCGqJOnuf/N9npFc2/q2VtGDVm1e6fCi0L?=
 =?us-ascii?Q?2X21hzz1/QBGCOIi4R9wy1UnT0OEEFya8Cg/nCJe+DV+6eQ9nx5X+SYyMREb?=
 =?us-ascii?Q?t/r7/IovQVom/rWxkrQm5TLRR4+lEGvQ9yabz41tOcc2kPZuteq1A/D6DRlq?=
 =?us-ascii?Q?8OOm5CXfPuvWD08F67jmhioyIH7Ke0qpyGpX0E07pfYNr6VTI712C2ZPew/a?=
 =?us-ascii?Q?92h+LLdvDqH7esKO3HHmjoovb4ebbiBAMzr4iEI7/xmzn7JJhFW1Lk7JKL7b?=
 =?us-ascii?Q?1jygjI9any1oen2jLX7Os7UV9BUu2t9iZeVM1Px2ktG3uI2ORrEiYFgDXMVT?=
 =?us-ascii?Q?rIrrNh/oxgSR7iFLUjHyFKoM/6dSBhn0Ms5UOtQZiyJpaiUG2csti09KIuuL?=
 =?us-ascii?Q?9ZUDAOPO8om+pUE2cEw1BP0yoF8uUU3N2DAxedE9xn9eqO0T8c7MjjFnKXVY?=
 =?us-ascii?Q?niTRw5yc9/YTJv2lxmwOMqD/VnKSA5JtcK7ajA71zXiacAkKfZFyki1G8NNT?=
 =?us-ascii?Q?WbnoEYp6Xh3AJfY2cMJ90aGAzo77FLMmO0XAjl4ldtpRkPmU2EdWhxwZ0ebP?=
 =?us-ascii?Q?/mIgNztfbQJM2NwJvqQunXfH+nOeSZvBQdC8M/48iAdUUheS4LEKzrJ9TGdz?=
 =?us-ascii?Q?64KozfHicrm5sB8jXBMREKBJ4Z39edicwbSnaIZTlmu0lSItjgwMyjIyXJ4F?=
 =?us-ascii?Q?irp4+9AuVu+IITNvOefS64vl3rs/S7tKAK1wVzHh85zBKdFdwrWzvRJ1/zl8?=
 =?us-ascii?Q?DQqf9BtE6IuHhkoJQq97IjvMtsn2eeu95eh0/TwoRVMs2HQj9MSh/bJBp1To?=
 =?us-ascii?Q?v+Z2ZuQDdFAgqdqCOTCQD1GQ+Vwco/A8izw1NYOh5nyuExCgLw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZP153MB0796.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RyZlY5SatynRiW/Ebizb+tZ9/u43aO+HXb3ze/fRb5rgwAJOa3NlIrHMSUqX?=
 =?us-ascii?Q?OXi8DDg4884kHPEwrRVxWGXWdwu3mecukrNbEpzFeLug5QkQwYG/m142QKSJ?=
 =?us-ascii?Q?GKHovIHRgmnqOSZXNlji9b7n3QrOa1iLTh9laueNrbOk1hGOvXfc8MEHZJZL?=
 =?us-ascii?Q?VK+joMwu0uhTRJKeojLd2/8sRz/Q4zsKjKd+z5LW2Lj8htxL0ZDP0kS8/H3d?=
 =?us-ascii?Q?bRorznX1hibwpiqXGTpFmAbXBszIE/kK6NB2RiUpizJfYVc9fuJBe3L1atbK?=
 =?us-ascii?Q?/7ZCvQwQfGFIJVKVabnOaTlyGTNxuYT2jwnQApl1gCDnd7OZSLg9dJv3cwxH?=
 =?us-ascii?Q?8rBc/+vOOjBUKLNoTm2f/fte0TeKaFsxMXVTKbEnsR3ZlxaFM5tpx1tWjW3g?=
 =?us-ascii?Q?CSmMyUv51AoH/lpQ6irdVzlPhxjR1KE+cRY5iofBcJgIJiP1hGPiXwXi7v8k?=
 =?us-ascii?Q?jxkJUIFeXUziAv8z5CkF6VXkQggMrqq459WKT4ZoUe2vRbtHG0725ofUbkvO?=
 =?us-ascii?Q?HHqd2gdwpnJIKep58DgwT10TfmzOrLiiVnanE5Iymyf0UpKMxTzEpo0kte7w?=
 =?us-ascii?Q?ia8LYxUfb/ov2ZZPk7cS6hkAm5Vlt9o0eFYrIDWyyWlCEDzIv78HDmACTSx7?=
 =?us-ascii?Q?sxtsqFHpKCa/tL4r7FuSKkYK6j22FL+48GdHIuiysyZvBffRVcT/2CNuSr1S?=
 =?us-ascii?Q?V4MdNxFn1dEIvZQ6oJXfaTn1tlzhmt6KA+9GPwznTvVQJe+XnXp0ZH2XoDZa?=
 =?us-ascii?Q?xcmNl56VnJPIbNc6JpxalXu160gT1S44ladLS0YTNxTb3z11y7Xp5Hj7bxJf?=
 =?us-ascii?Q?aSSpegIpBDoWUN0o5jbsojGgH4Vu6I8hfUTJ3wzEBxeA5iS1VvyLqFuMea71?=
 =?us-ascii?Q?UcmZysOGu9Tj3Nq7GdKF02hwwMR9FO41IkkH5E5/vEATGbqzo0c86IrpIEJT?=
 =?us-ascii?Q?FFm1XGfwPNGNoSPLgME1xSorqQlOtpWk+af6Pd7+ZI7RJujPFpC9jIFiGx8h?=
 =?us-ascii?Q?rPP5CjWlSMrJ7/Kzv+OB+7IgD+OBFzPmrJ7ve5WYgWcea8F6NOu/KQ8vCPu6?=
 =?us-ascii?Q?Vr93VRxFiam5eWP+yrtYqfNGGp55xXnOhODFimNWzG32UHFSzpVCZXwe0aCd?=
 =?us-ascii?Q?PKn//R9mhWrCv6FtPGc+0dvJhHu2nVY50ll6LEDvDCB8XqVztM+euV6zjSUq?=
 =?us-ascii?Q?OIaL93DSjcScmYNcvvf5oSY/+FSsME56vH75KQUFI0FFO5l1yrKIgXI7q4pc?=
 =?us-ascii?Q?OeWl01rCw0OYOy6KLn8a5L1+WuBzruGtV7ombmn8ytdT3ou4YCCAbSQJLhmg?=
 =?us-ascii?Q?ZoIfEyp1El7uh9HyPoJdpcbKHuPOPwzQHVaLHAjucChsbkJbhfZIEuKgSor+?=
 =?us-ascii?Q?xJ/RDelkvmiszgwhZ0qmpuN/sR9cE1IOVUeiNLqXNCpyTgiTMbastbQbjt19?=
 =?us-ascii?Q?M56EPIYCiEhC56OvDOZBu6L5GK0qyzwLPwJJNWWk0GOVmip28D0xuAAbSD5b?=
 =?us-ascii?Q?sm++YHqWIKNoYGdw769NRTATVuzhI4G9laG4KWBp2pE3yJTtTKwV1OnuKr6T?=
 =?us-ascii?Q?JwX8ODFIxFSR2ya1Z7+AgH8ryHcALwdmZcyaXa86?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eec2843-5c2c-4d12-c897-08dcc3563ab1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 09:30:29.8545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SF0PEoObdhLkcveH0cOyUoZsVJgU2UZbj6l0Yn1T8cvfCJnQnhNN8mBHbphihMVr8x48UDk/olAYnQLzlB1RmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P153MB1004



> -----Original Message-----
> From: Saurabh Sengar <ssengar@linux.microsoft.com>
> Sent: 12 August 2024 11:44
> To: akpm@linux-foundation.org; linux-mm@kvack.org; linux-
> kernel@vger.kernel.org
> Cc: Saurabh Singh Sengar <ssengar@microsoft.com>; wei.liu@kernel.org;
> srivatsa@csail.mit.edu
> Subject: [PATCH v2] mm/vmstat: Defer the refresh_zone_stat_thresholds aft=
er
> all CPUs bringup
>=20
> refresh_zone_stat_thresholds function has two loops which is expensive fo=
r
> higher number of CPUs and NUMA nodes.
>=20
> Below is the rough estimation of total iterations done by these loops bas=
ed on
> number of NUMA and CPUs.
>=20
> Total number of iterations: nCPU * 2 * Numa * mCPU
> Where:
>  nCPU =3D total number of CPUs
>  Numa =3D total number of NUMA nodes
>  mCPU =3D mean value of total CPUs (e.g., 512 for 1024 total CPUs)
>=20
> For the system under test with 16 NUMA nodes and 1024 CPUs, this results =
in
> a substantial increase in the number of loop iterations during boot-up wh=
en
> NUMA is enabled:
>=20
> No NUMA =3D 1024*2*1*512  =3D   1,048,576 : Here refresh_zone_stat_thresh=
olds
> takes around 224 ms total for all the CPUs in the system under test.
> 16 NUMA =3D 1024*2*16*512 =3D  16,777,216 : Here
> refresh_zone_stat_thresholds takes around 4.5 seconds total for all the C=
PUs
> in the system under test.
>=20
> Calling this for each CPU is expensive when there are large number of CPU=
s
> along with multiple NUMAs. Fix this by deferring
> refresh_zone_stat_thresholds to be called later at once when all the
> secondary CPUs are up. Also, register the DYN hooks to keep the existing
> hotplug functionality intact.
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>

CC: Mel Gorman and Christoph Lameter

