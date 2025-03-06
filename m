Return-Path: <linux-kernel+bounces-548042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C4DA53F22
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D15B91885DFC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBD116426;
	Thu,  6 Mar 2025 00:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="dlmDUp2E"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD7633DB
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 00:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741221057; cv=fail; b=G1XrToh88aZdhepDGSgUGGT7KBZuAzw+ptnkIf59u/G9CrDu9fQYcjH2lfs3nkMfJdbw581hre8R+Mw4Mxi8YNCDMVP04pKCGw+0uy+S3Fa90H5UMeB9YirCpGQImvwYGyYT9CqEeekBnSpkxrrPVaR2w7QcRMNgJzMrOkCPMY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741221057; c=relaxed/simple;
	bh=8/bb267lEVvErr97VYXkAiyUIGBftiGKUjvtkOpfPww=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uBxDwfNyaKkRdEx9KjNohUr/53ms0sWvJolpRl1FdYoPs91kbPZo8MSqEvU4GLnlR8zKZxmdOXCxaisZhI5n2mtfUcHR4WTKiLu1fHlQQ2RJprqt2SZKFSEE6rr+LLHQpsQa91vu54rjPv1k6ta5XSHUGzDmoBKUPfcUijKibeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (1024-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=dlmDUp2E; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMspdkDvXZOuxmbMsU1UUI20NxN7OfbsH7ZefWiAk0ge31o87kEF9KXLuKd8Abf1SqI5rPgxkCzJYjjyZ3rdfjujFErHZ8kUtfNvBWC6un9g4Ax+qG3zbjWuMqQvKNn5KIMeKem17JKDU+wAu7uTz+A5qAw8XYiHQuT7XBfLcVaC9eaEC4EK+lggef6m51p64YQmTGbOAI1t1RjikuhrF7uJG1CHU8GOutOMkqVgBZiKeFfJ/WCBVMQ+1zTmkvxeEcN7O8Co6xDfXtutsJlOB0fsRb8ORN8YikMW/OTe2EIC0zFmJcjBOZ2Nzg2HpKAtCCSkD++tdo5ogi1mfecftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqZDsKA0REF9MD0LpoJL8yGyg+RicR1gQJzkGtYiWgo=;
 b=sOc2WgtlxQ0NhHWPR+CrxCd8imA0cGttAOjB2iPuYXNKIjtm9Fsu0oWt8yUahQBORBS2SReiJKDUJwz2XMh+NASusqnUAVYPXT4TFv9ueNAaHbnRfzx2IGGfNRUOa9e9MXPx0Eh+0ZlyrIQtcnx7CxxJKJtrkNlyPD5LNLbWBm6RPI6G+k+gZpb5MyKp9BZnws7fhmzCeyqABVEySK4cgu4iBG4prN+6naHIWXojGl+S0cBMAJnGSazBt7UwGZN54lFrShzDJhCrJ+651k4fDM/96ekQ0BtB9mdlqeYhqFh0XSj81xnxJoXZZR77Xe1yvSmimFz2RmaKnN3sEMl3FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maxlinear.com; dmarc=pass action=none
 header.from=maxlinear.com; dkim=pass header.d=maxlinear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqZDsKA0REF9MD0LpoJL8yGyg+RicR1gQJzkGtYiWgo=;
 b=dlmDUp2EnFzzxZc9W03afeypBsbWmUgEX81WeTEfmVv/j6tK6AwHbQOfQJl1W36KXbUJFkpwBAZ0oYs5nedNN7aFoW9WCsmV9lxnOGTcARIhi0F9MS6ZcN6ViUdBwpbLgJqgj+7/KhCr8hqIUzCZ4nccqfUdvueNTyJeduVy6yo=
Received: from SJ2PR19MB8094.namprd19.prod.outlook.com (2603:10b6:a03:536::15)
 by DM6PR19MB3948.namprd19.prod.outlook.com (2603:10b6:5:1::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.16; Thu, 6 Mar 2025 00:30:49 +0000
Received: from SJ2PR19MB8094.namprd19.prod.outlook.com
 ([fe80::179d:230e:aab9:ec3a]) by SJ2PR19MB8094.namprd19.prod.outlook.com
 ([fe80::179d:230e:aab9:ec3a%5]) with mapi id 15.20.8489.025; Thu, 6 Mar 2025
 00:30:48 +0000
From: Kit Chow <kchow@maxlinear.com>
To: Christoph Hellwig <hch@infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: pci_p2pdma_add_resource of bar memory rejected by memory hotplug
 as out of range
Thread-Topic: pci_p2pdma_add_resource of bar memory rejected by memory hotplug
 as out of range
Thread-Index: AQHbjghVdFcw5+9Z1U6qqHaQNfy9r7NlPimAgAACxXU=
Date: Thu, 6 Mar 2025 00:30:48 +0000
Message-ID:
 <SJ2PR19MB80942BB17ED2D5B34AF2C230A4CA2@SJ2PR19MB8094.namprd19.prod.outlook.com>
References:
 <SJ2PR19MB8094482894628FF87E806CC8A4CB2@SJ2PR19MB8094.namprd19.prod.outlook.com>
 <Z8jpi5nf63APb8aN@infradead.org>
In-Reply-To: <Z8jpi5nf63APb8aN@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=maxlinear.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR19MB8094:EE_|DM6PR19MB3948:EE_
x-ms-office365-filtering-correlation-id: a194da3c-d125-42e1-32c1-08dd5c46246f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?rNG9ibyy9awP0SiSfAEULsjFZfdtJj61K+u+/6tcyuH5fefvd0Oy4QU1XG?=
 =?iso-8859-1?Q?2BbLWZh67OwVCkbZLLCuipg2e0WYyVONpJs6iBJzMJygfgVAFInKQO45Bq?=
 =?iso-8859-1?Q?C17F8mNUKHi/OSNHGeXzX9QRCHKzVp7zxVsmR0UWd3kLtxNn6v80OVPljM?=
 =?iso-8859-1?Q?Rheo0Q1OnpsddKhgGT4hr+s+f+GAhzflPvtvzz52QvBGrVi8WT1GC1g7Ve?=
 =?iso-8859-1?Q?mr+RUvSSB+1aKjizV7hvSMlou7qSG41/oYu1x5lL1cUNTGUNnhz17Wa57/?=
 =?iso-8859-1?Q?Znnjcf8cesnlNwKlzaNhCckyFz4ZNTn+LC5TLwBlyOxQjQ8h1rK7vqmkUy?=
 =?iso-8859-1?Q?3EatNc4dFtFI0fp2/12p2u2LG3ffqbuWwBNXNrH40Is6OabcjA8qthN+13?=
 =?iso-8859-1?Q?C3J2x5OQkKAmE0mShXpxBJZneHjDXuFnJZJOeG016i/9wlEb+/y3nc5hUU?=
 =?iso-8859-1?Q?pbvxDdYhDLdtzfCznCfOxFnNlS6h7gObPHySUp7vlz2Ukr8YZkJFk4P2HI?=
 =?iso-8859-1?Q?oqd5a+gJ5pRjVcVOrGiMEBTCN0oLW7m6z91qcjaB3DE29uufzFvhkG2oG/?=
 =?iso-8859-1?Q?bYxli+BN73qae/EhumDlC1rWUd6+isvKvxi1ck9MVrswtZHT/jPwF6LgYm?=
 =?iso-8859-1?Q?6AdOX0ipzuUfn0G+1HYZWOogGHtJk4GY+IT/VhY/7InTxM5xlSmQVN2j4l?=
 =?iso-8859-1?Q?A/NPS5kaz67tkO5fpxNujNqWsHoBdQWG94zNLqKAoeZXDysTHx7NPjDDTI?=
 =?iso-8859-1?Q?b2/q3wGZBXvSQjM2U7bICZoC6nlc0TLYLOsFP0fnQMHspY83ug/Owq1MJp?=
 =?iso-8859-1?Q?d8xkfAvlDxrK/9PnN8TLdcec2u0InrwF4d/rVfqvLCksustIWNuvO7lqEx?=
 =?iso-8859-1?Q?IjENDcN3ys2CpK004AK04ujAE5RTObO6oCVt5g5agRTZiRJk1SM8HzL/8G?=
 =?iso-8859-1?Q?TFxRI3VocAHwqpEFlELSMtWx26SuzG4vTjMcpjwllp2kzi4MJPsba4YgeL?=
 =?iso-8859-1?Q?aywLvoYEVWN0aGlfAyDFPcSMUs7CNbz8MZEeq09CfHAp9GgmWWfk3MXOrn?=
 =?iso-8859-1?Q?YpwFCUTpbQoP2wthIHbVmFBudS8yAQNwGrCotru5eUQGmo9ILljuy/9IIQ?=
 =?iso-8859-1?Q?IA+6135k6pWrAQFsBIGkHfYn69g6Q1iU51UA3w0L9JQEdHlcjHYQm1UUGP?=
 =?iso-8859-1?Q?mJuPw5JsK9/22uCkWuOHELH4XBnUWt15Tyj4ZIcyxRqLuJsFMz0tmgSGpu?=
 =?iso-8859-1?Q?Py05eAyckt5IfjVJvZhLY03wSyKhDNCabJTFiJbWDiU3QPM3Dd4h2IpRr8?=
 =?iso-8859-1?Q?FoxqFrIxfVRTDNtStBeWKquCpx0daE/60fRDDSIh5NQnn1UieCTkOV8n1U?=
 =?iso-8859-1?Q?QHnnw2yY3Q5yPWukGCftulbYlx+GmoMNI4k0gO/GJJoZI1QfYECyZNlF95?=
 =?iso-8859-1?Q?VuXV0FfDkxv0EEHYBKCq7W+hcXD8Q8j6Kf3fXb5V6sVIm+blvwdPn3KeZ4?=
 =?iso-8859-1?Q?4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR19MB8094.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?svOIu8pDaC0cwnH79sxn2znSkGjpvIcmr3bCe6zcBmUwcDno0lMR5uKX+Y?=
 =?iso-8859-1?Q?qQBlEaiABtXd5RlAXjMSLqkfYWQ6D7LH0U0QO46jz9MPLfAkOvG+oqkvVT?=
 =?iso-8859-1?Q?bdx0UrDv8cQzZFJxT+RkwpYWPzd6835iwLtxPFasuWTR9/zo+SbEnwSBX1?=
 =?iso-8859-1?Q?q482kYvgTIIbMb9Bx1J7zoSv0s1uZ35SWZe++fHHTZY1Ihf0O0McVQvxvr?=
 =?iso-8859-1?Q?4kLWsbtX/1wFTI1k98zAe9vpi1iQ49N8QgQBr8aOqtmPf4spt384GfdVUn?=
 =?iso-8859-1?Q?/AshCMk76vk6uI0Ymf0Bnu9ZwMLQgXeRLk5FRDWM7xDKp0p1GI+4N/UPau?=
 =?iso-8859-1?Q?dFB3kqexjDQ1F47D7M8ENT51IoRLjfx+wlEvBBNFX0yhNSBA9fPM2eqvnf?=
 =?iso-8859-1?Q?lvZdb++WAhF8rqE6/00i+2yYl15/FwD0rD/qfEnOJs+E9gyweiYSGu9xVQ?=
 =?iso-8859-1?Q?jACtFGdCdetxMAuu+R4zkIMSK5ViQStTiNRtj+vP2vKeRqqhMaK5VDRGPY?=
 =?iso-8859-1?Q?jl72X1REW6brb7TxVM7lIP78Bxgon51n3qMp+AHr72/oGJ0hhbX9e5400U?=
 =?iso-8859-1?Q?daG6/iHg8toB4MNAq7g139jzbNm+H7WFojXlyBnUx2tB8rk0CML/nx9UhO?=
 =?iso-8859-1?Q?nFYVikA3j9JOH2/vTOu6z7bujH2XZ5ul6cQSPYEBiH9pYhPtVURwPd6N0R?=
 =?iso-8859-1?Q?Lst9cMt+tjFHjMho3o7oQeMHmMlEfI5suhiGql/rgKm/J0PSDWgIfEd1MS?=
 =?iso-8859-1?Q?58mDXi4QYOykL3Kv8eEHDItY/8hMOtwiPaOEUt80KTCrNE2d2qOt1LJybp?=
 =?iso-8859-1?Q?gVU1ePEBCxkpyacBE/icSqRP/10jNpnF2sq+zLuIPVRKfph92kLj8zDzpS?=
 =?iso-8859-1?Q?1L1h2P0WmmJpDSr/EApO8w9f460ggEFXUv8q89cwrSJcPpDjJH2k0atR+M?=
 =?iso-8859-1?Q?6i/GkYk5EPfuSLU8EVHonxtcqugdtNnuFOiBRuQ+/rJfbSl+KGauseBQI/?=
 =?iso-8859-1?Q?NC8S1SNUNBL97d6HjuENko4pweZTjt+JE0BlMfHcYU94F0P1u4w3wXZwhz?=
 =?iso-8859-1?Q?apWSSKMLL+sIAVLNFRQoOoI0E6U+jXhlQO23pUGqhfITQ82DwvkjYjb+LF?=
 =?iso-8859-1?Q?3jKSSwBBs7aNXHcDum85+bxIZyksXeWaCPGTH08Ll9frxZKgbaG9AuPOhN?=
 =?iso-8859-1?Q?ME6Oy+LWFXkGHJWO3ocyXntlOFQwKXFViqoRC1eEVlLTJx8YuIA1UA1ilu?=
 =?iso-8859-1?Q?Ihzm4yJ5ge+/2XCtexnlFdr366N9vvlxG3ooshLBwAhtpwMhw5xw6I7FFl?=
 =?iso-8859-1?Q?4IDnNwisObZhLFnnknnF5Q7mpwx3IwWij89Y8lMOLOxKElThHQRX5yH8bF?=
 =?iso-8859-1?Q?fiVpWSlWeFS/t09lIsUmkh+T4RAixcD3AzHGCjkW6oGMmpS0CWv0GxD9Em?=
 =?iso-8859-1?Q?clwQTmg9kueiHQA7ASuE9tvIKMuOlkxWSa7gKnFqRwDXeM/Mij/RXRsQ/Q?=
 =?iso-8859-1?Q?QPspCVHTqQsuPsi3Yfqd6JxDSgWq52yfXtADXa9HTrfKQrmcE3EXV0AcT/?=
 =?iso-8859-1?Q?jNydcEo9JOSQVY7DZfE1ZDhYyFDC3U8Y78RYeP1jehBt8qAfdSRhuS1t4U?=
 =?iso-8859-1?Q?VPsjJW7Veg8QFMQcJNlNJCXW02U55tzqYX?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR19MB8094.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a194da3c-d125-42e1-32c1-08dd5c46246f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 00:30:48.4865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6lQWVmK5EIOniavPAwKpKcJxJrl7RbOHjA7JfjbTO0/HpbM6too65hZeMgV2S1R18JYA5kQZf3Wve5NzS+ZDRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3948

Hi Christoph,=0A=
=0A=
Is the kernel licensing issue causing the shrinkage in hotplug memory range=
? Can you please provide some more info on how MaxLinear is violating kerne=
l licensing and I can take it up with management? =0A=
=0A=
Thanks=0A=
Kit

________________________________________
From: Christoph Hellwig <hch@infradead.org>
Sent: Wednesday, March 5, 2025 4:17 PM
To: Kit Chow
Cc: linux-kernel@vger.kernel.org
Subject: Re: pci_p2pdma_add_resource of bar memory rejected by memory hotpl=
ug as out of range

This email was sent from outside of MaxLinear.


The kernel detects your company violating the kernel licensing and to
go away.  This is only half kidding, but the kernel mailing list is
not a place to ask question when your company treats kernel licensing
like this.  You're on your own.

