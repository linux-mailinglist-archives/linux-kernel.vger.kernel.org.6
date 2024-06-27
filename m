Return-Path: <linux-kernel+bounces-231978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C51891A115
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1E97B20D04
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 08:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D377345D;
	Thu, 27 Jun 2024 08:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qT/8Xw0v"
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01olkn2030.outbound.protection.outlook.com [40.92.113.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61D823BE
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 08:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.113.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719475614; cv=fail; b=nA6wC4e1ruXvL9ujYK5ok0VlBzGJgSWcNAhC/mRzci/KANoe1zmtLVjSoqo8FxQCwLazrVhyMtdkKcdGoLhurgMjbYTzatewA/LJwHe6WVjXbLrXXkkpxf39wVHakdpmOGevRxx2yBLQdQbeprQrEVGhQ7mi9zesWKE/ejVNI2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719475614; c=relaxed/simple;
	bh=MzBEJAPBWfYhP2yl8/RzYTyiHbDm+GWbcW/WeCmZT2E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t9ziUryKYJA+1O+alkm5iDnZr0Irl9zcAmC2H4PYEh0SkhP+FL0YijGI6MWPgJUeb84c4CMwei2XJT4jJP++KoAleE7u/3ch9oFUSYDyfndA4Ae5JaU8pVYwI4+46Olakw2eOI1d34hI9BDysE9vBbH87bxuce1VJMFuXYje7q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qT/8Xw0v; arc=fail smtp.client-ip=40.92.113.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPBIbZNG8BXRmYez0NXn4MKO/VVIuSnv8MW7fQhZQ0RLtjgNM2Tt8gjo2us/pA923C15VqspXgiEZ0G0DFtqObcfMzu/TIg4TQG/eTYJ64LIR+1ncQzciQUA4boLs5kdX/qpY9i+0QnjecHm/tzeR3+8bfGmbxBVW7NsRLDTEoMCEvR63u5v0xjiX6Z14FP+TOjxxfFv+2UkPJFz4Rs8DjQ13lVgpCTnSP5W4JbbwgDP5QnE/aWXXzReEsIsNaieh3HisLVpTCMioAtoxwqYRJ8pB8iyP61bicA6FKwLl5eRLadoD+Lw66YgtC7vb8rrqLk9o8yk3VFVIdME1289Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzBEJAPBWfYhP2yl8/RzYTyiHbDm+GWbcW/WeCmZT2E=;
 b=cKzsB/4g9djzq9luDF3o7oiP7k8zYMEAJxcRsKETJJIMLEgRiM13ewSRG9S4GDq7EBY3jqf+u5uvmMBuZhcwgK2N6/xAMwkK646VSfGDmIMw7/1NYLCC9YDkY1yvtpSn/Z0BbgoFDvHE0cXFOC1JcXXPzIrcxuIEuCfUCmhTR15cRySKvfoHQ2nnMP0OE8eidg6g3V8Xy9EXDT25Gx219/d5ZcLf06zKrvCAiU8z4Vrk5pEXI2VSscp5opOJ0e7PayfGfEowuOz6L1S5CiU420bJZmCzTgIFqN66qZI3OCpPPjNKX58OYZIy2UNHoWr8rA7Ox4d7yuWRPKB6EftDnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzBEJAPBWfYhP2yl8/RzYTyiHbDm+GWbcW/WeCmZT2E=;
 b=qT/8Xw0va49ylCrP2rnQ83d4mQTBC91yv2xX6IJbXc9rN/qo2RWrGgWyhlOfgvkDPE6d6Go/Y/cM0/hpnQrYE148tVtsmQuRjj/zuafjcsQ+TfltfgQYQaPqjqX9Q5b3rz6JSEkvF0xDfrqDIPwfGtrUN/7YyU6MSvW5SATSSl6v5yUYz6VYrnfK/6hBLBo5Sxfypm1LVJq7ioJEGHbxnTcfx9AZFuZUdlmKjn6k+m45UWNYjlsty0cTstgkPc7oquDvloVSRDyyxWk6hmvvd+J5ozLGA9vkeNwNt96Pc+aWc0qhv5hCxdl4nFWx4KAg3jD4UrA7xOEcUzY+Ytbw6w==
Received: from CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1da::7)
 by CWXP265MB3575.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:fa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 08:06:50 +0000
Received: from CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a912:f233:4847:e806]) by CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a912:f233:4847:e806%5]) with mapi id 15.20.7698.033; Thu, 27 Jun 2024
 08:06:50 +0000
Message-ID:
 <CWLP265MB651633F722342DFB3F923799FDD72@CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM>
Subject: Re: [PATCH v3] Staging: rtl8192e: rtllib_rx: fix alignment
From: Yusef Aslam <yuzi54780@outlook.com>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Thu, 27 Jun 2024 09:06:48 +0100
In-Reply-To: <4b489362-7714-4d96-b6a1-50d627b15319@gmail.com>
References:
 <CWLP265MB65165E806F938F87CB67BF87FDD62@CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM>
	 <4b489362-7714-4d96-b6a1-50d627b15319@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
X-TMN: [5xU/7fFN1Vn0cYZ2RhRB6wV+0lL1wXXl]
X-ClientProxiedBy: LO4P123CA0029.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::16) To CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1da::7)
X-Microsoft-Original-Message-ID:
 <2bff39cea56a28f3a3828f10089c592029943857.camel@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6516:EE_|CWXP265MB3575:EE_
X-MS-Office365-Filtering-Correlation-Id: 2145e3bb-1e33-46ff-47d7-08dc96801901
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	MQDHosNqwvi1yMe0hJX8d65oicm5ww4W9i/aQHS8CsNl/fiEb4O1ZDNfO3EtYBh25ieevbGyH3jzC7AIS6S3U1Ckt7ffxndmIQgV9GbqQw5MaP996m6gB2GbH89cJeZ9KPyCxjgxOungjeFqcoZfDEs+Yv3AkKiwk7g+/PmhHfQcLEjXRMgktPs9DPAe5ISw+PuQkQRbxDedJvPUVj1YKlTUSSgdrAOv6aNAKtks8ZvJo63fMFu+e+ah4WBjtLXMGoSd3hPa1xaMiEahh1o5vJqwrxRyq5aFLehov81QuokP+ZXmGHacqh6ba/AGRFAJ6JYZqAFQzWRWNJqLRjNuAVJHaN7cXNFGXIetBsUTseTJdvd8Rq8e2MDrXyCWv97AQ8lz+taOEduhZWmL1b0Ggy4CVupON//o/jEY0YE82vtLEz3YGQR7fTrDPdNfZanPwpyMt4FhhJMeu0xu2q+LyJ4svpnRELojnsjMCUzo+Fq1HmH2jw9x4VmabMyAuQduSE/pMdNivNRMBDtmNLKFtYFLxzBqYC1epmwYp6gSvaRK1hzLy34x2k79pxPkcMNf
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTlnWXVkc2hNWXNuUlB4Q2NmMmVlRDJ5WjVFOTBkV3I3OXk0RENmeVk0VkVE?=
 =?utf-8?B?a3RraFBROXBEeVJpOXZZZWpadGhZNUU2YXc5NVF6SHppOWdWSENmVGE3dFJD?=
 =?utf-8?B?NlZKNThUbGt1enV3cGovRWlYRTEvdk9hcys3SzJ3aVpkZDM3RnFyT0Z2Vzc2?=
 =?utf-8?B?cGhldGt3VUVaS2dBQ0tZRk1PQVlUcWJOM2tjcE5NYVlzNCtpRlRZQ2xzYWZK?=
 =?utf-8?B?QVUzOC9pekVUZXVKdDcrS2RLQ24wOTUxUEU3TTlKYzRZbG1QOWhRYzgrR0dB?=
 =?utf-8?B?UnFhcWZBQ2sra3VFNzgrYjY3YVM0dWdmTnBWYUVET1RhRlE0aU9NQ3YraGhp?=
 =?utf-8?B?M0U1ZXFuTy9XdEE1Y0k3dmh4VU5Ja3B1dGlhRkNtUGhlRkgwU3R3R2FpcFFw?=
 =?utf-8?B?RTVIakhLdTFUK2srUTRXT2NjR1lTZXk0MXBOc3BPR3doQndjVGZYTWg5TWNu?=
 =?utf-8?B?bEFUcGJDd01MVktnSC9hL1NmUUFoTmJKZHY2MlN3ZTVnTm9LdDFlV3pmeWJH?=
 =?utf-8?B?THUxMjJwL3dCTzdoQ1NxUGtENXVJWVRwUVV4VTNxaHNYeWV0WldZLzdocy9D?=
 =?utf-8?B?bDVEN1h3L0p5VURrNXRQL0REYWw2YnhxOVM3Y1dzY3hrOXl2bDFTdXp1YkdW?=
 =?utf-8?B?NXdkRVE1VHhIZklNVjl4VU93VWJGQng1WkQvWUxGV05mTHhHR0xGZzByU3ZD?=
 =?utf-8?B?V0htWEdXNjh1Vkp2NDErdzZqcnVDSnZ0V281QkNpYUF0WUNPQlRxanNyVlFS?=
 =?utf-8?B?VnRSaTFuRnVzQlQ2OFp2b0RKVmZobmtzOWFGejFTR25QeEhJWWNYbWNtcEVE?=
 =?utf-8?B?eTRhdlVMMHdvM3I5ejRyUisxL0V4TjZYZG10dFZwTU4zK3A1Qm0xbVc0ZXJG?=
 =?utf-8?B?d2Fpd2h5YXVkazh4OU5EKy90QUNRVkc5MHBGaWJ2ZnlJVnoxdmlBT1dTVm1S?=
 =?utf-8?B?aVF0cFMvUzZ1cmV1YktsdUIxNjlNUHF6UERnRTRwVjFRdVVITmhMQ3BYT2Nl?=
 =?utf-8?B?emEwTVVnSGE2cWR2VHpWNG5NS0lMY1VSUUtuWHlhc3EreDdubEdHVHpHUlVX?=
 =?utf-8?B?eVdjNTBET2tXbnZHcnVWQnlYejNLRU5DN3RtNjYwS0I3NklaY1k5SzZlMlNH?=
 =?utf-8?B?eDVIOUFBRUwvaW9SdEg4MmkvSlBrQjVNdGxRUzc3eXVwMXZXNE9Fb0ZXTmdn?=
 =?utf-8?B?c2c3dGRIaVBMUFdyVit1UDFrNnRvbmNYSGllRWFXM3Y4VHNST3ZZRmhLL2NP?=
 =?utf-8?B?bllvK1MwVHNIbVI1L09UaVRUSzBnbmQ4K01BZWVGS0kwZDYwNll3U0xsbTJo?=
 =?utf-8?B?Y0RtSWtVdG1aZk5peWJ3K09YUWc5RmcxQ2lrTk1Vb3g3elFEbzdwL1dwbG5K?=
 =?utf-8?B?NHBETVA2ZkFYMlFOT2d6NUE3Y3Z0Q3p0bXZyZ2ltSVoyckFVWFpaNzZIMHJi?=
 =?utf-8?B?SUoyWFhXUUEzeU9lbC9GRXloaU1neHZBOVlUcWNTZWI3aWtPV2RHTGVQMjBO?=
 =?utf-8?B?L2h3Ry81VjFUYXROcXhWZDNPc1JTVGZHSFRvTEJPdndUd3ZnL0NHZ3ZPQ015?=
 =?utf-8?B?Si9kYlBVcEhCTE5UNzRpbnEzQXpNL2g2aGpBT3AzdnlFUVh6QUlQNU50TVNG?=
 =?utf-8?Q?fOjyDqOrvGm7pQvqSukHPKquQXbVLHdO4cVBDoEQdyzo=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2145e3bb-1e33-46ff-47d7-08dc96801901
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 08:06:50.1735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB3575

On Wed, 2024-06-26 at 19:32 +0200, Philipp Hortmann wrote:
> On 6/26/24 14:56, Yusef Aslam wrote:
> Hi Yusef,

Hi Philipp.

> The patch can be applied. Thanks for the change history.
>=20
> But your patch description is not answering the why.
>=20
> It could be: Fix alignment to increase readabiltiy.
>=20
> For the first patch this is way to long and the indentations are
> really=20
> a mess. Issue is that lines then get to long which leads again to=20
> checkpatch issues. Please find some of my comments below.

Thank you for your comments and advice. They help me alot.

