Return-Path: <linux-kernel+bounces-240350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BC5926C7C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 01:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5069EB23156
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB70194A71;
	Wed,  3 Jul 2024 23:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="cJOGjovb";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="XiPN+zST";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="JAKjJ/LJ"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCAC1C68D;
	Wed,  3 Jul 2024 23:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720049633; cv=fail; b=ejh6jdN4tFdAoO///knfFt3z4obTzTXYHXZjD2knHEjU7MTMyTvYzjEpIvqAhQI64odmVKtxtU/jlMJsJDczT90lrg8sveWh8n9+AvV1X9ZgOkeiPIcahbyuvHOfqQ8XZqeEkxg3V/65PomHtk/DflFVblt/BqhFafByRnJ+DT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720049633; c=relaxed/simple;
	bh=ulmtZohuDDn0xpfaisyAoFYs6iV67I1oUjIpO4JRQ18=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fkt7LyZwcoJTSCgJyzqKhRKvzce7PoRltDcuN5F9qtGx0U7kBZmINv69qxbpIAbHAmC08KiSyFBIOY2ERSu6V/J0mnFj28a/8fiYMw2Gckz1jg15P/R78l/oPsgxmCviN3ilQy68EFCi2s7bf/Yfbozb0jN+rtOYalCjfefNklc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=cJOGjovb; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=XiPN+zST; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=JAKjJ/LJ reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 463GB4b2023539;
	Wed, 3 Jul 2024 16:33:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=ulmtZohuDDn0xpfaisyAoFYs6iV67I1oUjIpO4JRQ18=; b=
	cJOGjovbrJNcnjL83rCBA9PD5IVEPzQD7AC8OF6OUnXZX8TAtof81zc28FJD4EBV
	RHvx9kfpjxtxDPkSV7FcFcoU9jTcAo9wZWxdtaX4IAagc90R54dr39F/ampwwVnJ
	NeBdhXTeE1ICW/S5dJ2IgI1FQ3TYtK6mEBULu0P+CnGrsMY7h6tNxVSJ34DzqHc9
	x/mJboiVCCdZpuOYYh56PIkH8hocdjb+Sbr46D1nAGP+jWH66ATCFzD7q9egrw4/
	e/Rt0dfzdlU7LcJsGG30P3bgZxOoWJus6pvlcuYezKds1ICBLSv7CYFoeP4WSwP4
	CM9/KCoQmVzkmkF3I0loMg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 402h9kjpr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 16:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1720049609; bh=ulmtZohuDDn0xpfaisyAoFYs6iV67I1oUjIpO4JRQ18=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=XiPN+zSTjhmKyeXUeiGcgEhcgC7Jft5tGMiJSGgU/7RGyBTG2cj6JaGM1voRyeX58
	 hRoVXrKNLs/sQWwpl6f/CP2De2WcB1Vg9Qy4F3+MZOymo9cVvTC24X+ZwUzRUC1qWK
	 wDMhe8u4+2kY5S32fCrzcVQdB6WmFpRXFlymc4QgGUJ0DToTgXGOMVU3bNqC7jpT7U
	 cS3797p7aYkQsBITvMyFdWIN7JvTJR1UuYoPKxSC6SyszDDsadCn4d913BkVHfgfM2
	 us3GzM9mS4M4iT5esdnzBXk3msyfh48ToasaoKS/30l/9sk1Swu7e8IXV8BAJT5F2W
	 pSZMi8eW9of9g==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 353C340467;
	Wed,  3 Jul 2024 23:33:29 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id DD787A0081;
	Wed,  3 Jul 2024 23:33:28 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=JAKjJ/LJ;
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 12C81404D4;
	Wed,  3 Jul 2024 23:33:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUuZWt/6f2M9/S1Pne3sxwHDLcLVliGPx2lvx+S7nsBrcTWNiGNK5lJ5sRka9Cui2OWFyg6m5VaSFlAzd9MAxzlS0K4G6U4bWZUDb3inA5+rRZ6CvrM00xmOL0o9De+nEaxD7VpIcOC/VJMi4rvb2LNq/8Cm+vfALeCjE3Av4S3YeQO3M/0DT7G2KBw3zzfGvoYjI4LIYyRjCqvbBPsWKRpV98/gdI5HgURlBgpz6m+l2o649sisqF+1hpdYBgyrQ4bqRWbZ9D6I/4z5KLBGtj2GfqxyDqGlNtpKPJEwpQRCezrHtiYuWJRHf2QtNswhWHs0VGSou+NIRBWlm/Sa5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulmtZohuDDn0xpfaisyAoFYs6iV67I1oUjIpO4JRQ18=;
 b=DCE+RAzQfr6ZcGA40+9Uu5DkKkIbAuY7FzMoF41NKOFryf9sJ8bvpT/T8phrIYXEN8VXBi4Df2gH/ss1O/zAM+7b4XwjMzetzeUFtbWHD25hNPC4PJ6k4T+kLIuCbi1CkBF7dJ/Db3/s1pQ2ieSmfcUFVtVn6XUrYdb3D7fKt072D3y96sPBTqaCZgqQisfjBUSV5o1+x5oOv7STjBlUxMXTS1ow8yMLcoRL2l4D1uadW50gTznmDRbcXuOlYRKu8wFBa3KNkMzd5NQORc1idDNNtK4x8mh+rNS9K8VZJUvsbs3wJD+YXX88e7EOkeyyoCjT34fdYL7ovXNxrG1sZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulmtZohuDDn0xpfaisyAoFYs6iV67I1oUjIpO4JRQ18=;
 b=JAKjJ/LJudzq3LDuLqlt9fo4PTe32St1zGBwMxgEjDm90Jks6+8zPuZGhcigrMEso+N4PQEkh0lH8JCI42YQ+zthrKJNw2KfzBhsqIwBYPWRwEyef9n7akEQbyo76270MP90gak5M5ZVwgBxBhbzs1BpIi1WeK4d09CeySkKkRM=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DS0PR12MB7533.namprd12.prod.outlook.com (2603:10b6:8:132::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Wed, 3 Jul
 2024 23:33:23 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 23:33:23 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Frank Li <Frank.Li@nxp.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        Ran Wang <ran.wang_1@nxp.com>, Jun Li <jun.li@nxp.com>
Subject: Re: [PATCH 0/2] usb: dwc3: Add cache type configuration support for
 freescale layerscape
Thread-Topic: [PATCH 0/2] usb: dwc3: Add cache type configuration support for
 freescale layerscape
Thread-Index: AQHazZ3E7zkePsPd1k6ukL905POfwrHlp38A
Date: Wed, 3 Jul 2024 23:33:23 +0000
Message-ID: <20240703233310.2oxguahed2g2lknm@synopsys.com>
References: <20240703-dwc-v1-0-9cbc93d49180@nxp.com>
In-Reply-To: <20240703-dwc-v1-0-9cbc93d49180@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DS0PR12MB7533:EE_
x-ms-office365-filtering-correlation-id: dd46b1f9-bc97-498b-2eaa-08dc9bb887e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?T3RqVUFTZlN3WUhoTVZoYVo3Y3pyUXQyemY0VmMxUXY1SFdIQmM3Si9NNURr?=
 =?utf-8?B?RmR4Y2pIYm15L2Q5Zzh6RFJJQjFuUy85a25vRU4wSWM3QVlDNVdac3FGRW4v?=
 =?utf-8?B?SnZhQlpzVkQ4cy9rL2g4R29VcHBGME81ZVdVMEszMjBWQWpEZk55TjV0Zy90?=
 =?utf-8?B?bEVJcHd5V00vNmNuK3lxamU3SmVoV1R6OURRVHNRWUlHSThCMXd5Q2duWTVG?=
 =?utf-8?B?Rm9WV1FESFJBMkl1WU1ORE1YYzBQcHh4K1VGU21aZVozWGJYR2JiNmYyOUVq?=
 =?utf-8?B?bEVxWmVhTVVIZHhWd2xsL2ljSWJvL2RFUnJBcEQwcS8xVm1QZFViM01pS2dR?=
 =?utf-8?B?TnVLNVM3QlViT3FmZTZDQTUyZWp3K0dXWVkyRTIwOGR4VVdROGx0N09SVldk?=
 =?utf-8?B?bWZDOUNWZW1MZUwyR0ZIY2hsVG9PbUV2SnVaa1lnUTZsKzhjTWJpNm9aSTVF?=
 =?utf-8?B?ZitHYW56SVp5TVg1Lzc3elFCeE1VTVQ5T3VoVHpCMUQwelZuSFBqZVhTenNJ?=
 =?utf-8?B?Sjd4V3BvNVNCWStjVjZLT3VOaENLTitoWkFVQkY0WVFYTWdWcmM1d0k4MDd5?=
 =?utf-8?B?Y3ZSSU04Yjgxekpqc2o3UGlnTkJ1dll1NDdFNzNpMkZRajcrMVZLbkt6VW5V?=
 =?utf-8?B?c0tFN0NvY0l5bFE4TWdwKzQ3WVNZNjJrT0NPRVVmdE5DY3oyWkc1UkNROWds?=
 =?utf-8?B?WWN3L0dwZ0lZbHA0dlhZRDBrREJpZVljWUo1Q1RxYTRVNDduaEE2ZnZlYzNu?=
 =?utf-8?B?NkdOSkRBWm1odUdPUFg0UmphN3VPbzNRazdhSzNiMmZHUEFCb3NDVUk4aXpG?=
 =?utf-8?B?cFYrb1AyWnFPRXJCQ0FNeFEwZUpTbHliWVFkbjdpVERmRVF1VzBtUVB0V2tE?=
 =?utf-8?B?TkdaeTZva1ltR1pBbVBSUWpSQzZ6OTRweXRaaWhFWU1VUXp6WXFLN05lZ2RI?=
 =?utf-8?B?NjBnQmhmZHp2R2o3Znpmbi9CbXpxcm44OE5Ya0xrYU9ZMFluU3NPN0x3TFFS?=
 =?utf-8?B?Y2IzemlJQ1B5K2N1S2lJRUFkajRtQlhrV1ZHUEVmOVE4U1pFVWFBeXJ0dy81?=
 =?utf-8?B?WCttTkFWUEJCUnJmK1VqZkxWRktuOCtVNFhSWXREYmRITlpyMFBzMlJpV0J5?=
 =?utf-8?B?aGdVWUUzTFhWcmplMUpKUDEvNWw2NUxPaWtETVZDenZOcW9KYXpsdkc5SlJF?=
 =?utf-8?B?dzlST2NkN0kyZXJTZW1CTGFzYjFDdGVoOVJraFhKbGlCeGNxK0t2eTZySDhB?=
 =?utf-8?B?M3pjdU8zUFRsU1IwUk5KQmlaM002UHFpMXNNTGgveDREd2QwbUpSM1JtMU9B?=
 =?utf-8?B?dldJV2MvR2U1NUZoZ1ZGZjFzZVplSzBLZUdBUWtMcGNpSmk0UDJVeVpyMTQ1?=
 =?utf-8?B?V3BFU1ZaVk9hbitKRUF2STV1cDh0MHFEbktIK3dKZjQ1Y1JFUStISHdkMGVw?=
 =?utf-8?B?MjkweWVndHpib0lMZy95bFBTNEs1c1o2WnBLQWw5amNnZkQ5MERGVXRVeVBG?=
 =?utf-8?B?SmlZK3pLWVhXNUZCQUQ2ampDL2loUWNJUmFzTWV6eXVEN3FqNnFMb0VHT3hI?=
 =?utf-8?B?S0lJd1o1dXNjZ2t6ekYvWmpGRXp0ZjYrbVZZbExNMXkxRUtZUndBZ1VZd1M4?=
 =?utf-8?B?WlVuNFNIZFcyVlk2ZHdkUHlZbElGelBCN1BkVmw1SDNpUGppeVljNEh0NmVO?=
 =?utf-8?B?QjZTU0JxZUNyVjFHWXBqSXZCQW41bXU5VlZEditxUkk5M0t5bWdmUjNzMm9I?=
 =?utf-8?B?QVlKOU1MTVB0aGd5UkNPRlR6SjhVUVlZOHdMTjlLY3RNWmdKNmNCNjRjS2xY?=
 =?utf-8?Q?bhP2l+RR2JCd0yXhzWMHEuQxlrveGGll7o5V8=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SFV2RGlIQzAvcmkzVkJVUHpkTUY3cmFjd2t1TGhtbmgrS3hNV2poS2xoNHlj?=
 =?utf-8?B?SEtSeVp6eDVUejRWVStZNWQ5NWRaTCtUaUMwR2o4V3V2bXNWNWQ1N3JuVTQ2?=
 =?utf-8?B?bGdyM1RYcVJtdDRldnAvVmp5eEdWcnlEWCtObUd1T3N6SExGanFBNDBjaWVi?=
 =?utf-8?B?UGVPRFlSK0RxZmJrdkM0SHN0TGZrOGp1TFY0alhuUDREckpBckNkcmFEUEhI?=
 =?utf-8?B?TTFYcVBKUkZBVUdvVWJOblJJK0NGWHhoYlJWWXpuZ2NNQU1TY1MydlBXTXlL?=
 =?utf-8?B?aXdUS0ZUOE55R1duRXl1cUxzSi8wRDYxT2VMTm0wdTRwbmRaUWhEeUJBVkw5?=
 =?utf-8?B?K05KZTNKd1k4QVJGUDRMd1haNlEzNnhWeTBQWmNJVTliVmd2VTN2TE9NMldR?=
 =?utf-8?B?b09NQkdPdW9XVzBNOGxMUWZ4NHJJU0E0TnI2Vi9KSWwxOXFTNVJiS2p4Z21P?=
 =?utf-8?B?TVROZERycVpBMHRiM2pST0xUT2NQSGU0WDI2M2EvNEZSeUw3d2QvU05mN0Yz?=
 =?utf-8?B?a1ZTVjRnSW9BNVRJTjNDRzlOT1RiZnhWaTBCYWdLVytBWUk5c3hJWTJDUWZv?=
 =?utf-8?B?YUVGYmh5c04yYjVQSmxkaGVXSzlCdnRGaEFVY2xKd0p1VlVKbk9xOVBocTZR?=
 =?utf-8?B?MkovRFVHQ0tOcGl1aExGODgzYzZFd1NqQmFRUjYzbElmb3lKbXhaa01OeXFI?=
 =?utf-8?B?V29ZWGJoY3JkT1lmWFJscEZmbi9KY3FqeE1tc0Y5WUJ6Ri81L0lXQS9aS09P?=
 =?utf-8?B?ZGR1Nk1nSDJZSlRjZGdXUlpkUGxiQWFoQ0tJN0ZDSUZzQUErMFM2S0JKWFZ6?=
 =?utf-8?B?N0hDUUNuR0xiUHNMVVhyUVB5Njh3b1VtTmFYdFhHeUJMNEV0bTlIQjUydWVa?=
 =?utf-8?B?b2J3UFR5L3psOCthSWp0ZkNDeHZKTXcyVEVLWis3bVhVYXlGWVhJUG9WRHdZ?=
 =?utf-8?B?bjJ1cGFPak5oNWk5a3Z3aGo4aGRmNTgrVVRRSTV4Z1FURm84NmFwZGpSUjV0?=
 =?utf-8?B?aFZyZ0Q5OWhsUEZIb3pYYjZMcExrSzk1TVR3bDJNNGh3bkRVQTBzcGU1SkVp?=
 =?utf-8?B?YkMwdFJqcHJlRHFSMmQyNXczYlBkWWlRbWNFZmRDeGtwcnNUVnMzSnJqNGRu?=
 =?utf-8?B?aytHU1NadHVQSFBDUlhMT0VBQmtoWFZwaW1LMW9FdEExL01vZU1tdnZwajdK?=
 =?utf-8?B?a3cyUTFlbll0VlIrd2ZTNGYwcTdXaXhLZDVwK3IzRmp5akRKL0tEb0FkUTh3?=
 =?utf-8?B?N3Y3M0JvR3pFQ2lTd1I0anljK2lZMk4wL2hKUnFXWlE3OXNjRVNxSjZKRXE1?=
 =?utf-8?B?U2s3c3VuNkJENjg3M3JGbjQ3Vkt1Mnoya2VIWWc2MGcvUS93VkN2LzRzcjY0?=
 =?utf-8?B?bGk1LzI4ZXo4SXZqbGdUeldzTnFNZ2V2WGpMcnJyS2Y2RmlqeklZREJBYTlu?=
 =?utf-8?B?WnRLMndqQWIzV0JNWEZQbmF1K2Q2ZENWS2t1Nmtyc2RmNlVsMjh4c2poZ1VN?=
 =?utf-8?B?N1RrcEJhbXZZYStNU3M1c1BkR2pQeWlpNVZvQVYxVjNRUStZMll6ZkdSNHhI?=
 =?utf-8?B?TGpZemJwdC8rd090REtXSHFMcUhNeVdDRkdRSXNvaWhtT21YamFwZGpPV1Vo?=
 =?utf-8?B?QzdGVmhGZGpLQndpWlo4djBWWkV5SWtDUFJzVjBwQ0c4QmVDRTZ1Tk5rRnRj?=
 =?utf-8?B?L0dpYi8yWnN5Q3JnVEVFU1puK1VUckN2ajNQN0UxSktlVDgwd0JkZHFlUDRS?=
 =?utf-8?B?aUl5a0E2bFFNekduaVgweXJ2QllreHYrcmVTdFZCSmErMERTQjJNUFpITmhN?=
 =?utf-8?B?UmcwdWdnNGJSaWlycnFrYmxSTEM5bFZtUEhFTDZ5RXZrVG5PQlA1K2QxWlg5?=
 =?utf-8?B?UVFocTZHd2l3dWVrN0VJS1lkUDJ6K2FPR3hveDRWcmZVRGYwbGR2NTRHY29H?=
 =?utf-8?B?bm9qMTBzNyszNFA2V3BNK25EWEFXTjRlV283YkNJSVFqV2JES1FrS0tFeE92?=
 =?utf-8?B?QnR0NG82Q25JWjMwN2NycmdSaEZaUSt2RDBuR0hpMXBnamt5OFNZVENyd2th?=
 =?utf-8?B?RytJWERkZWhHZllYK0Z0UjlucTRzUUR1czU3bTMvcHVsbXJ1WmN6dXF2eGgx?=
 =?utf-8?B?bkF6dnk3NmJxaGJXZzc0L005L0tEUkR1SzAxZEluS1JONHhYMXZGay80RFJP?=
 =?utf-8?B?MkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <965BF0A0A2E78642ACD939FD292E2563@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XX+24fY3kYI7V4rYBZ3CvqHADgUD7IdvN6Db3BpTNSOvUVFCnTQZxmMJmwOblvOUvO3yh/HY2x5lp5A+1ng5ZxLOaQJI6g9gTUopQkvSPIQ4fMj7qUJS1feLz48SrYuFK8nZi+inLVbTNN5cZDD1oehyoBWHtUS6DVX76xp3YhpVB1P3Fl0jeKtKD4aVv52DVmSMznBIHXkPPGk0kfOogzVhnPCIOqTBNOWLFW3+e9viuAB1Os6kxefY6nkjUxsl7kGwvmABq54wPR8dYn8BwFf8KF0tNpFwef4DVr4Y78dgWbrmMiIyNF0oL/B82o5s6yMkemjS2AcUQAr3dve8j5OYK6ydWUQSbgA0V1ihin9TpLC5M9lLmNKDJ/spdSlH8xe7D56alglKDXrkPwc/8MwfzxYctclmf5GW4JBGUAhvvo3nfp8/NTx3sRsGxxXVpXflkowYFi+irx5v7VimZQpPuaTwwGfo+/HVHxeggbJVFfDVl+g00Hizy3NLK+mvvik0+BZEdHD4b3QD09XtgvjfAZ+CiDTLkceQRhYlOJGwHjcm8p1Bmk918lF2/EFxe3QwDIDiULC44BdyTFlAsmsvdQaRkK9gQmeSd3IDQ65WHlGXwz+868KJrUGvk0dw0MHDLwThh7O0+AfOVe6UDQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd46b1f9-bc97-498b-2eaa-08dc9bb887e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 23:33:23.5584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qvK1II04GMuUOQzY5vekgL/ZZubEOBwgxqpDvV5K1dJWd+LjxNMANSg7B9UKy+a6O/X1XeZsHqMkHsG6iSMkDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7533
X-Proofpoint-ORIG-GUID: ZFoFVKxNRbYM4zn49bNteGVGCRt4_5ZY
X-Proofpoint-GUID: ZFoFVKxNRbYM4zn49bNteGVGCRt4_5ZY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_18,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407030176

SGkgRnJhbmssDQoNCk9uIFdlZCwgSnVsIDAzLCAyMDI0LCBGcmFuayBMaSB3cm90ZToNCj4gVGhl
cmUgYXJlIHNldmVyYWwgYXR0ZW1wdCB0byB1cHN0cmVhbSB0aGlzIGNvZGUgaW4gcGFzdCB5ZWFy
Lg0KPiANCj4gVGhlIGZpcnN0IGF0dGVtcHQ6DQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMv
X19odHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC11c2IvMjAxOTExMjEwOTUzNTYuR0I3NTAz
QGIyOTM5Ny1kZXNrdG9wL19fOyEhQTRGMlI5R19wZyFjZE55ZFZaNjRicjlFSEcxM2xnUDNsS1dl
NVZ1WFF2dmZ2QTFDektKcWhYWlpCMUg5dmNKbHdJMXZqMUVGM3luUkZsMnU4dEQzbFlxUnZySkZT
czIkIA0KPiANCj4gY2FjaGUgdHlwZSBpcyBkd2MgY29yZSBzZXR0aW5nLCBub3QgZ2x1ZSBsYXll
ci4gU28gSXQnZCBiZXR0ZXIgY2hhbmdlIGluDQo+IGR3YyBjb3JlIGluc3RlYWQgb2YgZ2x1ZSBs
YXllciBjb2RlLg0KDQpXaHkgbm90IGdsdWUgbGF5ZXI/DQoNCj4gDQo+IFRoZSBzZWNvbmQgYXR0
ZW1wdDoNCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LXVzYi8yMDI0MDEyMzE3MDIwNi4zNzAyNDEzLTEtRnJhbmsuTGlAbnhwLmNvbS8q
dF9fO0l3ISFBNEYyUjlHX3BnIWNkTnlkVlo2NGJyOUVIRzEzbGdQM2xLV2U1VnVYUXZ2ZnZBMUN6
S0pxaFhaWkIxSDl2Y0psd0kxdmoxRUYzeW5SRmwydTh0RDNsWXFSaDdTaUhtTSQgDQo+IA0KPiBE
VCB0ZWFtIHRoaW5rIHRoZXJlIGFyZSBub3QgdmFyaWFibGUgZm9yIHByb3BlcnR5ICdzbnBzLGRh
dC13ci1yZXFpbmZvJy4NCj4gQW5kIHN1Z2dlc3QgdXNlIHZlbmRvciBjb21wYXRpYmxlIHN0cmlu
Zy4NCj4gDQo+IFRoaXMgaXMgdGhpcmQgYXR0ZW1wdDoNCj4gQ29tcGFyZWQgd2l0aCBmaXJzdCBh
dHRlbXB0Og0KPiAtIHJlZHVjZSBjb21wYXRpYmxlIHN0cmluZyB0byBvbmUgJ2ZzbCxscy1kd2Mz
JyBiZWNhdXNlIGFsbCBzZXR0aW5nIGFyZSB0aGUNCj4gc2FtZS4NCj4gLSBtb3ZlIHVwZGF0ZSBi
dXJzdCB0eXBlIGNvZGUgaW50byBkd2MzX3NldF9pbmNyX2J1cnN0X3R5cGUoKS4gYW5kIGNoZWNr
DQo+IGNvbXBhdGlibGUgc3RyaW5nICdmc2wsbHMtZHdjMycuDQo+IC0gVXNpbmcgYml0IGZpZWxk
IGhlbHAgbWFjcm8uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBGcmFuayBMaSA8RnJhbmsuTGlAbnhw
LmNvbT4NCj4gLS0tDQo+IFJhbiBXYW5nICgyKToNCj4gICAgICAgZHQtYmluZGluZ3M6IHVzYjog
QWRkIGNoaXAtc3BlY2lmaWMgY29tcGF0aWJsZSBzdHJpbmcgJ2ZzbCxscy1kd2MzJw0KPiAgICAg
ICB1c2I6IGR3YzM6IFNldCBjYWNoZSB0eXBlIHRvICdzbm9vcCcgZm9yIGZyZWVzY2FsZSBsYXll
cnNjYXBlIGNoaXANCj4gDQo+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNi
L3NucHMsZHdjMy55YW1sIHwgIDEgKw0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8IDEyICsrKysrKysrKysrKw0KPiAgZHJpdmVycy91c2Iv
ZHdjMy9jb3JlLmggICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA0ICsrKysNCj4gIDMg
ZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKQ0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IDBi
NThlMTA4MDQyYjBlZDI4YTcxY2Q3ZWRmNTE3NTk5OTk1NWIyMzMNCj4gY2hhbmdlLWlkOiAyMDI0
MDcwMy1kd2MtNWJlM2UzNzhkZGJlDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IC0tLQ0KPiBGcmFu
ayBMaSA8RnJhbmsuTGlAbnhwLmNvbT4NCj4gDQoNClRoaXMgbWF5IGJsb3cgdXAgdGhlIGR3YzMg
Y29yZSBmcm9tIHZhcmlvdXMgcGxhdGZvcm1zIGFuZCBjb21wYXRpYmxlDQpzdHJpbmdzLiBUaGlz
IGNhbiBiZSBoYW5kbGVkIGluIHRoZSBnbHVlIGRyaXZlciBhbmQgY3JlYXRlIHRoZSBzb2Z0d2Fy
ZQ0KcHJvcGVydHkgaW5zdGVhZC4NCg0KUmFkaGV5IFNoeWFtIGlzIHdvcmtpbmcgb24gdGhpcyBh
bHNvLiBZb3UgY2FuIGNoZWNrIGhpcyB3b3JrIGhlcmU6DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LXVzYi8xNzE3NjU3Mjc5LTI2MzE3NTctMS1naXQtc2VuZC1lbWFpbC1yYWRoZXku
c2h5YW0ucGFuZGV5QGFtZC5jb20vDQoNClRoYW5rcywNClRoaW5o

