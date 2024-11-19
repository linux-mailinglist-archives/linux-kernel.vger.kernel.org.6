Return-Path: <linux-kernel+bounces-413737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 009D69D1E10
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 03:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891011F226D1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 02:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D9C137742;
	Tue, 19 Nov 2024 02:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HwH+yELX";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DnNfdika"
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33E4C2C9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 02:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731982854; cv=fail; b=URzAn2H9qrOrcM1lB5SYVA0tUonhU7K485bnGhXMTOY3SB8Q08wrzNbKo0CeEJS8D5PVr39AL3nvUmV+nhfhMJN16F7UO4HQC6u50GSKhQ8bQfb+UZ/KnL0MDwUKvCmS5aB5qQ3aJms17Aob+wuUHcqjVxQ0QniElQ7p/956ZrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731982854; c=relaxed/simple;
	bh=hj8Q7YbR8gnjx9qInySnp8Ux24k6Lubl4Q2b8k/dUEs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OUQsCLcggOEidqCQCs0w3iscLpgwGHDwupjGf+RrPJbuFg2gwseHqw/TTkwovGRlc3PvGGqA96FLk4be7PZxzPP+wNPrIuQpmqaQ1ZM7f4xuHATeUmHsY/O2wLglP4Ntxv+fHROgPczRdBAkfe5ulgQTyHujM5UARidRNX2TlHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HwH+yELX; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=DnNfdika; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731982852; x=1763518852;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hj8Q7YbR8gnjx9qInySnp8Ux24k6Lubl4Q2b8k/dUEs=;
  b=HwH+yELXZYD73T4BXvXcfugli+3DU3uoX0O0qjtBhlnXId/dRPlrOVfO
   T70XjBTPtS+0fE9HRl15WJbGeWMgYUyUirA9TY7O/Fmzioqwlaf61ce4I
   kNmpjwWl/IojiZjSi/1apr4gzzl6X6LAtu1+iWvFgUUsm1rgudBifBCQv
   O1uWsxwSSEHoKQf+2XBlvp8nFb9qmMCDZbCDRxtqyeI9bouu8edKRo9zV
   1tu3lM/E7odMJ6D3IJ31zlbZAqa3RR6UmQ+rcsw0XVgLaeIcHbDzlhGlH
   R8rr/hLodr23Uh5j6XOdssly1U+vVk9k2fqCbOqlpoGGc1v8f/GRFwgfp
   A==;
X-CSE-ConnectionGUID: OqDR9J2QTWCMs7WNYjxlDQ==
X-CSE-MsgGUID: 70PEeloCQTG/ORKX6Ff0Yg==
X-IronPort-AV: E=Sophos;i="6.12,165,1728921600"; 
   d="scan'208";a="32799029"
Received: from mail-westcentralusazlp17011027.outbound.protection.outlook.com (HELO CY4PR02CU008.outbound.protection.outlook.com) ([40.93.6.27])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2024 10:20:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MawFZnjPT5K/m31hhyswqiU5J/ARkoZWOcuE5EGhQxhZ2CtedvTv5r4X63NYDDP8rd/sgoZHcgN7LjxyeUvrRl7+SqKI9JjMeM1e49GooE/dh1LqFeKRz1jih2qiyK+h3i3JR0JUu4PUOy9aX7w7ncJgYHtMFvWvD/d0gBRwdLMvFmYOZg+NRN4dBGAnZfbmI3AfAzjrAKDZImTdPc+YccIEEQQ43I0D8beD+vmNg9KC4YzAyehuUODVI1bzJKKmz5w7tqP6x8YoGohKQvv4076xInnhZB7xJpTP4K1j+qn+R0D+bE4b2rnZOQwZ824NGtnKOiRe2wq/BcIz1RQUiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hj8Q7YbR8gnjx9qInySnp8Ux24k6Lubl4Q2b8k/dUEs=;
 b=dX8V27tgTBtZLr8GP0MlRUDSJpNNvq8Jge7e1Nf3i0WZCwps98FyZPuGFAY78Ib5eysF9Rvp5VFSg2ln390xIJwSe4A3KBnjCWq3XdEYEWQk0kPBvX/u3boz2JXIT0arIfqxFQtY+u1r7p3seBz7d3TDj1NrzB/+WyZIrXozmvCSDUFHd2nWMxHZyJnRKwNXsSxlGuP//qIvoooCEizEq5Sz5MNUcLGELBkmt06Sx85iF9VaV1TjY97eBL2HR+LVfiNahUoAAxY6XI6Loa0pMSK1pSY4zKE3R1mGdYwq0SFjku+x0cWDw1J7QOQKHq+syE8Y/qFow/aTtLADC/pOYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hj8Q7YbR8gnjx9qInySnp8Ux24k6Lubl4Q2b8k/dUEs=;
 b=DnNfdikahLdQmdqscuaX/kxN7vu8ABRFxcSKIAT02SqECAAW7NyxWgbKVXi/KKy6xf+i7VSLnxtwu374NDcMa+Sm1ooagx4COvLygV6LuOOoxWzlWAgmefTK83GbKPZx0M700bUndvLExqmBTm/5TMJUgbbwLGu/55bQu6C/Uuo=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6396.namprd04.prod.outlook.com (2603:10b6:5:1f1::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.24; Tue, 19 Nov 2024 02:20:48 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 02:20:48 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "Daniel Walker (danielwa)" <danielwa@cisco.com>
CC: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, =?utf-8?B?SWxwbyBK77+9cnZpbmVu?=
	<ilpo.jarvinen@linux.intel.com>, Klara Modin <klarasmodin@gmail.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Danil Rybakov
	<danilrybakov249@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "xe-linux-external(mailer list)"
	<xe-linux-external@cisco.com>
Subject: Re: platform/x86: p2sb: Allow p2sb_bar() calls during PCI device
 probe
Thread-Topic: platform/x86: p2sb: Allow p2sb_bar() calls during PCI device
 probe
Thread-Index:
 AQHbNeKxizzLej0qw02u6pHMIY1jfLK1ZTYAgAACnYCAAAitAIAACmiAgAAOz4CAAq+GAIAAOFOAgAR9VwCAABNdAIAADFAAgAACZoCAAASkAIAADOkAgAAWSQCAAAGAAIAAFMqAgACYawA=
Date: Tue, 19 Nov 2024 02:20:48 +0000
Message-ID: <p3lt3psoxenwlvxu6yjpjk4yskrplagj54vk4vxkg6biudghus@go6hpoakvfwh>
References: <ZzdhTsuRNk1YWg8p@goliath>
 <5qjbimedzeertdham2smgktt54gzdc7yg4dwgiz7eezt2tf5a2@szhhpvzo3uhj>
 <Zzs1rw1YcoEEeW7+@goliath> <ZztABO3TyJBekZRs@smile.fi.intel.com>
 <ZztCB5hN2NBnPgiR@goliath> <ZztF7FKaBwZKs5dk@smile.fi.intel.com>
 <ZztQwLpoZDZzbi6O@goliath> <ZztjcntEj5Eo0Rw9@smile.fi.intel.com>
 <df1fa47f-7efb-4b0c-8ef6-100b12ab1523@redhat.com> <Zzt2JNchK9A0pSlZ@goliath>
In-Reply-To: <Zzt2JNchK9A0pSlZ@goliath>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB6396:EE_
x-ms-office365-filtering-correlation-id: f9cc8311-728c-45cd-b9f5-08dd0840c84f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TkxYNmt2V1paNFlhSnNSem1adSs4RmZpQ3dQeVgvQU9pTmtsSWJzaEVuc1RD?=
 =?utf-8?B?ZmQ4K1V0ei96clRpMms2ZmhLZjQrbDFmVmtSVGQrbFlMTjhxM2U3OXczT2Nk?=
 =?utf-8?B?RURGbGtRNEJLV1F0RG1OT3pIK1NsdnI0eUY2Vk1YZ09mYk92S2l4MWJ5TmZj?=
 =?utf-8?B?Ry9KUE9EVWVxSVltZnZKVEZJYzlrck9RVFI0VTRDQ2tIYmprQVZ3Z0s0OVh6?=
 =?utf-8?B?bUtoODdmMW1KYUJ5WVpsRUN1Zlhjd2lqQ1Zkd2J4aVgvVm5kd3BxZ2cwY1Bq?=
 =?utf-8?B?WURyVC9WRlVCbXR1eWpVMVNYTWR6ckl2VTBOaE5NZEZJYmZRUDh5KyttcFJF?=
 =?utf-8?B?bE5ZdlYwYUFpK3lJWkx4eGpjTGtSVUpaQ0IrOVNVR2JkNkNPaUdhSnBySG8y?=
 =?utf-8?B?U25yTG96N3lCejJtSTB4cFA4YUV6SGZRL2dSQzByQlNMYm12UVMwcm9KdnNw?=
 =?utf-8?B?aXo4bnd0dXdKT1pRb2xnT1BMRHZQM3ZlWXl4V0lVdTJoUzFWYlg5OXF4NUlV?=
 =?utf-8?B?bWtuMFhsTGhtK0V1bEs0L3gwYnZWclo1MFAvc0RiWHBWeEgzYkxtUnc2RTQr?=
 =?utf-8?B?cE9oTUNHbXgxd2N1U0ZOSFY2Z3ozMFl0Q2FidG5xTURWQWFHYkhrKzVwdGFG?=
 =?utf-8?B?eTdJSTBVeUo3WWFNb3FCTm9OL3Nod3VpeHk5c3lyVzdmdHdtdmVSc2hBTnhz?=
 =?utf-8?B?d1o0QUwvaEtLZ1c4L0VvR3FGSXVhZ2NXWEh4OUgwUUE3Mldsai92ZVE5NDhl?=
 =?utf-8?B?L1FHSWdERTFlQTlXdW1hZDlOTVRUNjY4MmVDdEFhTTBKY1EwRER6ODQvcUNp?=
 =?utf-8?B?akM0V2tmY1JteE9XalRrYW9oaHEwZUhYTk9kQ1J3WW53UXEra3RhUzE1KzNS?=
 =?utf-8?B?Wk0xV3AyL290M1F5TTQ0cTArVGZOL1VkdCtPU2k0TXBhTFZYQWtPUWlLTGZr?=
 =?utf-8?B?ZUFFNWFmMHJzZE9HU0oydlhWTDB0VmV0dGdlckQ0SFREK1haNjQ5ZDNUU1NY?=
 =?utf-8?B?eE9GZHA3QytYdjMyaW9RbjE1bGt1NzdXSEZVbUlaR2ZJQmFHNzZYN2lBR0JT?=
 =?utf-8?B?NkQ4aGduQ0lKOG0rTDcwTEI5WVp5aVZ2RXlDbWdROU84LzBUajhVZ3MxMmwr?=
 =?utf-8?B?aXRjMDNCb0lZQUhDbFVCQ2J0bjBSQzhoY0IvV3dhUTkwS2JyUWhDdjNZYzBx?=
 =?utf-8?B?dEdQUUM0N25NN0IrT0FHM2o4ZVdweUNQSTc3b1liNHpXcUVsMGRNQjMreDhl?=
 =?utf-8?B?RThwK3VYMkcwb0c3MEREWmFyMXdaRkp6ZEJ5RzZLUHIzZ2ZRR3B2T1A5S3ZU?=
 =?utf-8?B?MGF3SldLNEJrQklXditEY25MbHNFMVVnY2pYSGxFbzRZWFFoNjR2Y2diQmhH?=
 =?utf-8?B?UkV6MHlnSFJTOE0yWDRQTlQwRUN2d3gzWVhJT29sQm4wYWFWMDM5RUhVbjZM?=
 =?utf-8?B?ZTM1YU04QVlUQUdzRmRzbm9xZHFhSVRVOXBPeUptZ1F5ZExoQ3ozL0pReHdJ?=
 =?utf-8?B?cnBzbDNDNmkyN1FFMFA4Z3hnbTJuekhnRUZKMDVRZWdORy9RYUhHSmpFZ3BH?=
 =?utf-8?B?RU5zSmRuMnIyNXdUZDkxRU5YZG11NFJ4aXdSaENVeUticmwzMHBBM3dvUURl?=
 =?utf-8?B?SUNYUGFNRjlkY1NxczA3MXFpdTN1Sk1HWnR6WlE3Uy8xZmsvbE1mVE5sUzdh?=
 =?utf-8?B?aDZRc1k4NUVaQkluWUlzQW9rQytXTXYwWWdpL0x5VmVEWGFnYklqc0R1bmMy?=
 =?utf-8?B?a1RJaUJNa2lLdkVTM2tXY1VybDBHRXVBd1BENWlzV1JFb0VZMW5pMVU5ZlBX?=
 =?utf-8?Q?57W/y6bAI/ISRy1YuhOcLCOCftocg4R5C9KyI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?STBzZEdCUng3WUhNUDl4aE9GWWVaN3c3YjI2SU04UmwyNndLWmMzQnliano5?=
 =?utf-8?B?SFVDQ2ZFdzYxS0FEZ25idmZOaDk0dHJsYTRaQU01dmNHSnVtNUtyekY3VzRQ?=
 =?utf-8?B?UzJsZWhJV1NtSXhhdzdtaEp1OXBNSHQzdVBacVFHaldlRmpzb0xaT3VPajdo?=
 =?utf-8?B?RVhucFNhYm5tQ3BJWkZMaGRrN3BDdlNGdkV5ZFVnREgzQytaNTN4RXU5NW1X?=
 =?utf-8?B?SkFjT2tIZWNkdzMzaTRqS090WGlKb1hNWXBYWnNoMDUzNm1XZlVHaDJFTE1l?=
 =?utf-8?B?cnhueVYxSVovV1hLSVI3ZG0xMWcwdmdGV3lBV21oRVZtYWZJN3lrcUY1QUxO?=
 =?utf-8?B?dlpyYnY0NGRtSVdmV0Urc1FQbzIrRGFHRTh3R1RRSlNIeFNmVTYyd3JsSCt3?=
 =?utf-8?B?U1NnajZ2VEx0QmhMQ3d4WGwvWldNcFZ3YzZPQ0hBcVZCcjFaaGhPczA5U1dr?=
 =?utf-8?B?TUJWMmNHbXRsei9RRDkrTzRKRWFSN1lnMmJERlB2aStjckd6TG1VcnB1UW51?=
 =?utf-8?B?N285N3lXQS9ndjZFTE9NV2I0VTVRN1dwZnFZOVQ2TEN4TThNWTVSSnY5OWUw?=
 =?utf-8?B?am12VmhLVkp2MFFQalFQU0pxKy9Jc3N3K1JKVTFZNklHeGFCUWVWY1NleC9Z?=
 =?utf-8?B?K2lLYlNvUmVkS1phOU4vODZ4TkJ2MWRXYmhrd3Z5NW10dGlhemlFM1Voc1Fh?=
 =?utf-8?B?R3BYL2psMlFXWjcrWVd5UklxN1U0bTdLZE10WjBhSko2bHVyN0k2dG4xM1pU?=
 =?utf-8?B?QjV5NEZTSXUxcU11dGdPRUxnMjlwNEp4Z0h1eEV0TWRnS1Z5RlpLcGxBbGk2?=
 =?utf-8?B?VytZdW1WbmdydnZSMExGdUFKNWQ4aHA0Yy8zaWsvZnVLTFp4b3JuS3pnT3BI?=
 =?utf-8?B?aytrK1RkYlNFdUdxb2pBRXkxQTMyT1Z2QVVyNklMUjdrc1loRlhUazMrOVZX?=
 =?utf-8?B?MmZCZXZPdGhmQzdma2I0TXNoRmFMaFRDc3JnalhYbGN6QUxRak12K1kybjdG?=
 =?utf-8?B?QWl2dzI5V2ZHbVQ3NjdhZFdrQjdWY3hXNExyajJEUzYzOXhBZzZDZFdkOC96?=
 =?utf-8?B?Um5zanN2d1BKaS9XdFY5MGhNSHZyYnMyT2JzSC81NldBOVNsOWVLL1ZQSGNu?=
 =?utf-8?B?cVN5SmluREE1MmZQRmtyZUJuUWRZdGd2VHB5eHBrSDdPdFlmdWJod1VoNFlS?=
 =?utf-8?B?R3VqVmpubG9sRDhGQTF6NFJ3bU5IVCtla0NnWEdxOS9LUTVtQ1NjS3d6Mjd3?=
 =?utf-8?B?K2thWTRqQkZaK0dkay95TjZhQ1ZTcHF3NG01RU11SENqOGFvUnZKWVZ5Ty95?=
 =?utf-8?B?ZVhoY3JWK1l1S2p0YmgrbUJ3UzExNGs1cVpDR1lWSXIzcWhlZlVLakZnYUFz?=
 =?utf-8?B?cmpZWlplbHBOb1dsblFPWXhwWkk5ekkrd1VsRjVTYUdOdVVTREYveG56UDht?=
 =?utf-8?B?NzdQbkZlZWJYRGlKSjJpRFBMZ2EyWkdFcnViditndmFqY2ZqWEppL1JvZWNQ?=
 =?utf-8?B?MlVad3IzMm12Z1BFUjNxTUdsa2EzbGZBY0hmcUpjTXpQTVNYUnBKanUweWtN?=
 =?utf-8?B?WTRqVzc3Z3VKbHdkWHFoaVhsTnZzdWVHZmVpUFd1YjRnRHJVSlVTSlJmYTU1?=
 =?utf-8?B?czRvUC94VEdwdnpXRnZOTEZJSVlnaVRnY0tqalQ5c09rNlRua2t3dmNWUVJm?=
 =?utf-8?B?bTMva2d0WFRlUGJSWjdtTWlkT3YxWUFsMDFlczRpdU1CQjIvSHA3OEtta3Rz?=
 =?utf-8?B?RzQrWHUrSmFXTHlOU3RRbWhEY2d0bTNtNGUzMnVLNXowem1IUGk0TnBNQUJR?=
 =?utf-8?B?Q2NCeXk5RGVBY1JKOW03VGhoeUJBZ1VhazVqOTVpNzJtQURCZWZ1U01oWGVY?=
 =?utf-8?B?ZGl2SVpweFYwYVJtVW9aNTROeUNkMnIyeDF6M3l0bE9xV09wL2JQeW9nQUF1?=
 =?utf-8?B?dVNMcmpuVWVjblg5b1ZteUJialBOaVU4K25PVUhLNTdkM1h2Y0tDRGoxNUxO?=
 =?utf-8?B?cWZWNUM5bGtPRlVPN0NpN3B1eXpjTTJXMjlHUFJkdEVGbFo4NWVoWW5xS1cw?=
 =?utf-8?B?VFp0MmNMakhQRUp0RTJQZmZSU3JhY0hINFdTY1BweWNyQ2pxN09TRGdEdzlS?=
 =?utf-8?B?MDNnVVBlWkYySVZwdStVTXppKzBsNHEvTUZVWlkySmsxUVlEUWxITFFSVjBF?=
 =?utf-8?Q?26y07Gj2vCHZzw2GrjE7rmU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7020D01DCC2E47438252AE2AEBCF34EE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VfSJhFdkAOgTxu4h5X36Ndf+p4pqPnjP4fuKi38M3LE45kGhhq9lXKYBiFkPKiM/dkewoRuOuBRSBwSpmdd3E51VWOpG9JXDIhblIHqHo0jfWX9HLTRJlk3YEg95WNQq7q6VpmosEDTNnnz6D4r7m7YPZ4YLxuWiIZwCAFg3/ZEf/Kice+bxXUtemtHLMhpzftKq7l3bXBJBpsb3bIcQq0EjQGHEqqlEPE/NaNWxIMziqWWnGwfjIr3V4zpIkUll9tUt4We6+jU8AxOFdZGtpZs9HvsdOQD9nKc/c4xYKgfei1WF18WJqJxy5YLlw2eQwOQJ2u5arB8DBA/wf4dSr0Feq7mXGXHfQh0jGM4jQlve4LgZdgWR0diOdRGP5ljYWzExUvInnt8hprE8UH2F8f2oUugu1iUw6mVLtSSfjTt1ZcUymfLIXWLm2WZo3qsjjXVB7/ZR1FvdTTUm5WvM6pvdO67svi1v0RxOr0ZxScDSrgLsspH2zTaN6eI/hp039HVxGjTI/feFfdgSqyiarkKYGCuO8QSo4b+1UlauvXGAaaAtJyD07uKH1MOdbz/wGNj+NVUbyLfR7uaA8crjYumPqKaebE7+IVXpsgEh/tecJsndVxUn5HlvWpwDpNgu
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9cc8311-728c-45cd-b9f5-08dd0840c84f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 02:20:48.7709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dvRRIugllzMgqtDAf31MOFfkv00V7VOPUR/EigGgFMkqcMDJqparVAiNhYCEYJEFFKqK+BTPZlpl8KnR38IbbVbLmVZ5198xasentBQb7KU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6396

T24gTm92IDE4LCAyMDI0IC8gMTc6MTUsIERhbmllbCBXYWxrZXIgKGRhbmllbHdhKSB3cm90ZToN
Cj4gT24gTW9uLCBOb3YgMTgsIDIwMjQgYXQgMDU6MDA6NTJQTSArMDEwMCwgSGFucyBkZSBHb2Vk
ZSB3cm90ZToNCj4gPiBIaSwNCj4gPiANCj4gPiBPbiAxOC1Ob3YtMjQgNDo1NSBQTSwgQW5keSBT
aGV2Y2hlbmtvIHdyb3RlOg0KWy4uLl0NCj4gPiA+IEhhbnMsIHRoZXJlIHdpbGwgYmUgbm8gbmVl
ZCB0byBmaXggYW55dGhpbmcgaWYgdGhleSBpbXBsZW1lbnQgY29ycmVjdCBhY2Nlc3MNCj4gPiA+
IHRvIHRoZSBHUElPLCBpLmUuIHZpYSBkcml2ZXIgYW5kIGJvYXJkIGNvZGUgd2l0aCBHUElPIGxv
b2t1cCB0YWJsZXMuDQo+ID4gDQo+ID4gQWdyZWVkLCBzdGlsbCBJJ20gbm90IHN1cmUgaG93IEkg
ZmVlbCBhYm91dCB1cyBoaWRpbmcgdGhlIHByZXZpb3VzbHkgdW5oaWRkZW4gUDJTQi4NCj4gPiAN
Cj4gPiBPVE9IIEkgZ3Vlc3MgaXQgbWF5IGhhdmUgb25seSBiZWVuIHVuaGlkZGVuIGluIHRoZSBC
SU9TIHRvIG1ha2UgdGhlIGhhY2sgdGhleQ0KPiA+IGFyZSB1c2luZyBwb3NzaWJsZSBpbiB0aGUg
Zmlyc3QgcGxhY2UuDQo+IA0KPiBGcm9tIGEgZmxleGliaWxpdHkgUE9WIEkgd291bGQgc3VnZ2Vz
dCBpZiB5b3UgY2FuIG5vdCBoaWRlIGl0IGlmIGl0J3Mgbm90IGFscmVhZHkNCj4gaGlkZGVuIGJ5
IHRoZSBCSU9TIHRoYXQgd291bGQgYmUgYmV0dGVyIHNpbmNlIHNvbWUgY29tcGFueSBtYXkgaGF2
ZSBhIGdvb2QNCj4gcmVhc29uIHRvIG1ha2UgYSBjdXN0b20gZHJpdmVyIG9yIHRvIGV4cG9ydCB0
aGUgcGNpIGRldmljZSB0byB1c2Vyc3BhY2UgdGhydQ0KPiBVSU8uIFRoZSBjdXJyZW50IHNpdHVh
dGlvbiBpcyB5b3UgY2FuJ3QgbWFrZSBhIGN1c3RvbSBkcml2ZXIgaWYgcDJzYiBpcyBlbmFibGUN
Cj4gd2l0aCB0aGlzIGFkZGl0aW9uYWwgcGF0Y2ggZXZlbiBpZiB5b3UgdW5oaWRlIHRoZSBkZXZp
Y2UgaW5zaWRlIHRoZSBCSU9TLg0KPiANCj4gSW4gb3VyIGNhc2UgaXQgc2VlbXMgbGlrZSB3ZSBj
b3VsZCB1c2UgdGhlIGFscmVhZHkgZXhpc3Rpbmcgc29sdXRpb24gd2l0aA0KPiBwaW5jdHJsLCBi
dXQgb3RoZXJzIG1heSBub3QgYmUgYWJsZSB0byBkbyB0aGF0IG9yIG1heSBub3Qgd2FudCB0byBm
b3IgZGlmZmVyZW50DQo+IHJlYXNvbnMuDQoNCkkgZG9uJ3QgaGF2ZSBzdHJvbmcgb3BpbmlvbiBh
Ym91dCB0aGUgY2hvaWNlLCBidXQgSSB3b25kZXIgaG93IHRoZSBwMnNiIGNvZGUNCndpbGwgYmUg
aWYgd2Uga2VlcCB0aGUgdW5oaWRkZW4gUDJTQi4gSSBjcmVhdGVkIGEgdHJpYWwgcGF0Y2ggYmVs
b3cuIElmIHRoZQ0KZGV2aWNlIGlzIG5vdCBoaWRkZW4sIGl0IGRvZXMgbm90IGNhbGwgcGNpX3Nj
YW5fc2luZ2xlX2RldmljZSgpIGFuZA0KcGNpX3N0b3BfYW5kX3JlbW92ZV9idXNfZGV2aWNlKCku
IEluc3RlYWQsIGl0IGNhbGxzIHBjaV9nZXRfc2xvdCgpIGFuZA0KcGNpX2Rldl9wdXQoKS4gSSBk
b24ndCBoYXZlIHRoZSBlbnZpcm9ubWVudCB3aGljaCB1bmhpZGVzIFAyU0IuIERhbmllbCwgaWYg
eW91DQpoYXZlIHRpbWUgdG8gYWZmb3JkLCBwbGVhc2UgdHJ5IGl0IG91dC4NCg0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L3Ayc2IuYyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L3Ay
c2IuYw0KaW5kZXggMzFmMzgzMDliMzg5Li5kZWMzZDQzY2U5MjkgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL3BsYXRmb3JtL3g4Ni9wMnNiLmMNCisrKyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L3Ayc2Iu
Yw0KQEAgLTc5LDI5ICs3OSw0OSBAQCBzdGF0aWMgdm9pZCBwMnNiX3JlYWRfYmFyMChzdHJ1Y3Qg
cGNpX2RldiAqcGRldiwgc3RydWN0IHJlc291cmNlICptZW0pDQogCW1lbS0+ZGVzYyA9IGJhcjAt
PmRlc2M7DQogfQ0KIA0KLXN0YXRpYyB2b2lkIHAyc2Jfc2Nhbl9hbmRfY2FjaGVfZGV2Zm4oc3Ry
dWN0IHBjaV9idXMgKmJ1cywgdW5zaWduZWQgaW50IGRldmZuKQ0KK3N0YXRpYyB2b2lkIHAyc2Jf
c2Nhbl9hbmRfY2FjaGVfZGV2Zm4oc3RydWN0IHBjaV9idXMgKmJ1cywgdW5zaWduZWQgaW50IGRl
dmZuLA0KKwkJCQkgICAgICBib29sIGhpZGRlbikNCiB7DQogCXN0cnVjdCBwMnNiX3Jlc19jYWNo
ZSAqY2FjaGUgPSAmcDJzYl9yZXNvdXJjZXNbUENJX0ZVTkMoZGV2Zm4pXTsNCi0Jc3RydWN0IHBj
aV9kZXYgKnBkZXY7DQorCXN0cnVjdCBwY2lfZGV2ICpwZGV2ID0gTlVMTDsNCisNCisJaWYgKCFo
aWRkZW4pDQorCQlwZGV2ID0gcGNpX2dldF9zbG90KGJ1cywgZGV2Zm4pOw0KKw0KKwlwcl9pbmZv
KCIlczogaGlkZGVuPSVkIHBjaV9nZXRfc2xvdD0lcHhcbiIsIF9fZnVuY19fLCBoaWRkZW4sIHBk
ZXYpOw0KKw0KKwlpZiAoIXBkZXYpIHsNCisJCWhpZGRlbiA9IHRydWU7DQorCQlwZGV2ID0gcGNp
X3NjYW5fc2luZ2xlX2RldmljZShidXMsIGRldmZuKTsNCisJfQ0KIA0KLQlwZGV2ID0gcGNpX3Nj
YW5fc2luZ2xlX2RldmljZShidXMsIGRldmZuKTsNCiAJaWYgKCFwZGV2KQ0KIAkJcmV0dXJuOw0K
IA0KIAlwMnNiX3JlYWRfYmFyMChwZGV2LCAmY2FjaGUtPnJlcyk7DQorDQorCXByX2luZm8oIiVz
OiBkZXZmbj0leC4leFxuIiwgX19mdW5jX18sDQorCQlQQ0lfU0xPVChkZXZmbiksIFBDSV9GVU5D
KGRldmZuKSk7DQorCXByX2luZm8oIiVzOiAlbGx4LSVsbHg6ICVseFxuIiwgX19mdW5jX18sDQor
CQljYWNoZS0+cmVzLnN0YXJ0LCBjYWNoZS0+cmVzLmVuZCwgY2FjaGUtPnJlcy5mbGFncyk7DQor
DQogCWNhY2hlLT5idXNfZGV2X2lkID0gYnVzLT5kZXYuaWQ7DQogDQotCXBjaV9zdG9wX2FuZF9y
ZW1vdmVfYnVzX2RldmljZShwZGV2KTsNCisJaWYgKGhpZGRlbikNCisJCXBjaV9zdG9wX2FuZF9y
ZW1vdmVfYnVzX2RldmljZShwZGV2KTsNCisJZWxzZQ0KKwkJcGNpX2Rldl9wdXQocGRldik7DQog
fQ0KIA0KLXN0YXRpYyBpbnQgcDJzYl9zY2FuX2FuZF9jYWNoZShzdHJ1Y3QgcGNpX2J1cyAqYnVz
LCB1bnNpZ25lZCBpbnQgZGV2Zm4pDQorc3RhdGljIGludCBwMnNiX3NjYW5fYW5kX2NhY2hlKHN0
cnVjdCBwY2lfYnVzICpidXMsIHVuc2lnbmVkIGludCBkZXZmbiwNCisJCQkgICAgICAgYm9vbCBo
aWRkZW4pDQogew0KIAkvKiBTY2FuIHRoZSBQMlNCIGRldmljZSBhbmQgY2FjaGUgaXRzIEJBUjAg
Ki8NCi0JcDJzYl9zY2FuX2FuZF9jYWNoZV9kZXZmbihidXMsIGRldmZuKTsNCisJcDJzYl9zY2Fu
X2FuZF9jYWNoZV9kZXZmbihidXMsIGRldmZuLCBoaWRkZW4pOw0KIA0KIAkvKiBPbiBHb2xkbW9u
dCBwMnNiX2JhcigpIGFsc28gZ2V0cyBjYWxsZWQgZm9yIHRoZSBTUEkgY29udHJvbGxlciAqLw0K
IAlpZiAoZGV2Zm4gPT0gUDJTQl9ERVZGTl9HT0xETU9OVCkNCi0JCXAyc2Jfc2Nhbl9hbmRfY2Fj
aGVfZGV2Zm4oYnVzLCBTUElfREVWRk5fR09MRE1PTlQpOw0KKwkJcDJzYl9zY2FuX2FuZF9jYWNo
ZV9kZXZmbihidXMsIFNQSV9ERVZGTl9HT0xETU9OVCwgaGlkZGVuKTsNCiANCiAJaWYgKCFwMnNi
X3ZhbGlkX3Jlc291cmNlKCZwMnNiX3Jlc291cmNlc1tQQ0lfRlVOQyhkZXZmbildLnJlcykpDQog
CQlyZXR1cm4gLUVOT0VOVDsNCkBAIC0xMjcsOSArMTQ3LDEyIEBAIHN0YXRpYyBpbnQgcDJzYl9j
YWNoZV9yZXNvdXJjZXModm9pZCkNCiAJdW5zaWduZWQgaW50IGRldmZuX3Ayc2I7DQogCXUzMiB2
YWx1ZSA9IFAyU0JDX0hJREU7DQogCXN0cnVjdCBwY2lfYnVzICpidXM7DQorCWJvb2wgaGlkZGVu
Ow0KIAl1MTYgY2xhc3M7DQogCWludCByZXQ7DQogDQorCXByX2luZm8oIiVzXG4iLCBfX2Z1bmNf
Xyk7DQorDQogCS8qIEdldCBkZXZmbiBmb3IgUDJTQiBkZXZpY2UgaXRzZWxmICovDQogCXAyc2Jf
Z2V0X2RldmZuKCZkZXZmbl9wMnNiKTsNCiANCkBAIC0xNTcsMTMgKzE4MCwxNSBAQCBzdGF0aWMg
aW50IHAyc2JfY2FjaGVfcmVzb3VyY2VzKHZvaWQpDQogCSAqIFVuaGlkZSB0aGUgUDJTQiBkZXZp
Y2UgaGVyZSwgaWYgbmVlZGVkLg0KIAkgKi8NCiAJcGNpX2J1c19yZWFkX2NvbmZpZ19kd29yZChi
dXMsIGRldmZuX3Ayc2IsIFAyU0JDLCAmdmFsdWUpOw0KLQlpZiAodmFsdWUgJiBQMlNCQ19ISURF
KQ0KKwloaWRkZW4gPSB2YWx1ZSAmIFAyU0JDX0hJREU7DQorCXByX2luZm8oIiVzOiBQMlNCQ19I
SURFPSV1XG4iLCBfX2Z1bmNfXywgdmFsdWUgJiBoaWRkZW4pOw0KKwlpZiAoaGlkZGVuKQ0KIAkJ
cGNpX2J1c193cml0ZV9jb25maWdfZHdvcmQoYnVzLCBkZXZmbl9wMnNiLCBQMlNCQywgMCk7DQog
DQotCXJldCA9IHAyc2Jfc2Nhbl9hbmRfY2FjaGUoYnVzLCBkZXZmbl9wMnNiKTsNCisJcmV0ID0g
cDJzYl9zY2FuX2FuZF9jYWNoZShidXMsIGRldmZuX3Ayc2IsIGhpZGRlbik7DQogDQogCS8qIEhp
ZGUgdGhlIFAyU0IgZGV2aWNlLCBpZiBpdCB3YXMgaGlkZGVuICovDQotCWlmICh2YWx1ZSAmIFAy
U0JDX0hJREUpDQorCWlmIChoaWRkZW4pDQogCQlwY2lfYnVzX3dyaXRlX2NvbmZpZ19kd29yZChi
dXMsIGRldmZuX3Ayc2IsIFAyU0JDLCBQMlNCQ19ISURFKTsNCiANCiAJcGNpX3VubG9ja19yZXNj
YW5fcmVtb3ZlKCk7DQpAQCAtMTg5LDYgKzIxNCw4IEBAIGludCBwMnNiX2JhcihzdHJ1Y3QgcGNp
X2J1cyAqYnVzLCB1bnNpZ25lZCBpbnQgZGV2Zm4sIHN0cnVjdCByZXNvdXJjZSAqbWVtKQ0KIHsN
CiAJc3RydWN0IHAyc2JfcmVzX2NhY2hlICpjYWNoZTsNCiANCisJcHJfaW5mbygiJXNcbiIsIF9f
ZnVuY19fKTsNCisNCiAJYnVzID0gcDJzYl9nZXRfYnVzKGJ1cyk7DQogCWlmICghYnVzKQ0KIAkJ
cmV0dXJuIC1FTk9ERVY7DQpAQCAtMjA0LDYgKzIzMSwxMiBAQCBpbnQgcDJzYl9iYXIoc3RydWN0
IHBjaV9idXMgKmJ1cywgdW5zaWduZWQgaW50IGRldmZuLCBzdHJ1Y3QgcmVzb3VyY2UgKm1lbSkN
CiAJCXJldHVybiAtRU5PRU5UOw0KIA0KIAltZW1jcHkobWVtLCAmY2FjaGUtPnJlcywgc2l6ZW9m
KCptZW0pKTsNCisNCisJcHJfaW5mbygiJXM6IGRldmZuPSV4LiV4XG4iLCBfX2Z1bmNfXywNCisJ
CVBDSV9TTE9UKGRldmZuKSwgUENJX0ZVTkMoZGV2Zm4pKTsNCisJcHJfaW5mbygiJXM6ICVsbHgt
JWxseDogJWx4XG4iLCBfX2Z1bmNfXywNCisJCWNhY2hlLT5yZXMuc3RhcnQsIGNhY2hlLT5yZXMu
ZW5kLCBjYWNoZS0+cmVzLmZsYWdzKTsNCisNCiAJcmV0dXJuIDA7DQogfQ0KIEVYUE9SVF9TWU1C
T0xfR1BMKHAyc2JfYmFyKTs=

