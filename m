Return-Path: <linux-kernel+bounces-550102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20884A55B61
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589481889EA7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 00:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48CDD53C;
	Fri,  7 Mar 2025 00:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="IjXntgNy"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D646B8BE5;
	Fri,  7 Mar 2025 00:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741305814; cv=fail; b=XH02D0dnxoyI+3PrBqQo9uzjJ47VTnxBiOtidZyysDweThJHzqr7kEF2p0EhExWhw+eDGL80ukgwUsHPw8RCqiYnFGYQXglAVnw+LbST1OwUogmNxrGQULyDScDZ+5O0APy63UOKhFPMU1t1l2SYDwLdrv3Bc0MniCR5RGHjH0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741305814; c=relaxed/simple;
	bh=r2dU6k7+VUVZQXTTOTvy/+kUZV4+sw1HrFbd9P6emWU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uFuH5SMyhWPO6LMfQp/8H0S51q29icvNWheauH8+6I9ZqutwTSQAahqBg6SfGPePGlGbp1mFgDqr7mq6ob4GlApJQzZ9qWO5uQa6K1QGMIxsRicu4x9pgHgZoZU5W/MpDck2LJSRitnksjrMzoeyKjVfOzjmSvCueMd/ANVHQu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=IjXntgNy; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526LJgYq019011;
	Thu, 6 Mar 2025 16:03:17 -0800
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4571h5afut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 16:03:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylEraJboarxSrjKZOWOiVWKP/H6FMtg8Q7/JYmp0D0Orw51v9fEa6hpwSngK1qTU+Rq9oshc31+xasO1xqu2+PzhLnB0p5pBky5FMre9R2+5avfo4+RDVG5mG4Lb2ZzvzGLyxYTpjyniwPlRf0aACrWRuDlwanFSC9WnkZVKABvamq7nrBgFZ1pRhbWfvoQOegWXx9OHncWQTm427717QCk2IhHGQ/zS5Fgv0nYZNyfviMUL4JTrXFxgolxCK6qMM6Kr3CAPQCaZVlH6s8yrbUiWJBVMhUnVMvSOUUOjDDMys0biHw0dOvIhgPa0ZXJBcoGFjcphCJvW3OxZCztD4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2dU6k7+VUVZQXTTOTvy/+kUZV4+sw1HrFbd9P6emWU=;
 b=I5uZX51pKDbyqki2DVoZfuef9D4MzK/rfpLPv2TqgBuey5mCREFGMiEKXJVHv3ua4mS9zeahNJty+H9cKOxE9YoIXxSguhqXQGuF5kFwHG5rrUHm+oosl5XeAVQ2R0+8arJSKqgEVp652atzU+Gfoi+YETuaBc7WEMWNb5vVKY74rMB1N+pMfOjkNCpFGvf+N3M59LS8FC/hvS6b6FSTBXB2rh5FIFMirKOJzX0z0G/cx97o2iwmhTdVEe1HNIpOgejSJKf/71EASKjlM73RxTmAMTsrTXzR9h14qWgzH16tX8JIWSKTMCmvF/nrkB1351QERPYPcHeG1+HY6wMDvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2dU6k7+VUVZQXTTOTvy/+kUZV4+sw1HrFbd9P6emWU=;
 b=IjXntgNyxatJ7QVJw7dnqqb2RTZBqnp8QzRdA1J86EaPYj1VrZNTrDNh216cHwq4viBtV0GGYgFtdMhkaVegiU7UfwpDMwS2uGu1W7CY2oVYG0M0jbYbg4nzoj8tHxTj3I6ucixVoYTkH3TCjA/0WxLKZr0vV0SJQa1q/3yf3ec=
Received: from BY3PR18MB4673.namprd18.prod.outlook.com (2603:10b6:a03:3c4::20)
 by DS1PR18MB6136.namprd18.prod.outlook.com (2603:10b6:8:1de::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Fri, 7 Mar
 2025 00:03:14 +0000
Received: from BY3PR18MB4673.namprd18.prod.outlook.com
 ([fe80::fbd6:a3a:9635:98b5]) by BY3PR18MB4673.namprd18.prod.outlook.com
 ([fe80::fbd6:a3a:9635:98b5%5]) with mapi id 15.20.8489.025; Fri, 7 Mar 2025
 00:03:14 +0000
From: Wilson Ding <dingwei@marvell.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        "Rob Herring (Arm)"
	<robh@kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        Sanghoon Lee <salee@marvell.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "gregory.clement@bootlin.com"
	<gregory.clement@bootlin.com>,
        "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>,
        Geethasowjanya Akula <gakula@marvell.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "andrew@lunn.ch"
	<andrew@lunn.ch>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: reset: Add Armada8K reset controller
Thread-Topic: [PATCH v3 1/3] dt-bindings: reset: Add Armada8K reset controller
Thread-Index: AQHbjvRSv/56UPnR+Ee1nSVaYM2QWw==
Date: Fri, 7 Mar 2025 00:03:13 +0000
Message-ID:
 <BY3PR18MB46734A2425361D8BE83E4282A7D52@BY3PR18MB4673.namprd18.prod.outlook.com>
References: <20250227192536.2426490-1-dingwei@marvell.com>
 <20250227192536.2426490-2-dingwei@marvell.com>
 <174068786548.161165.4348563654300627455.robh@kernel.org>
 <BY3PR18MB467346EB1FA7CEF0A3300350A7CD2@BY3PR18MB4673.namprd18.prod.outlook.com>
 <d2929546-27de-4893-a611-dd4a3bca1a64@kernel.org>
In-Reply-To: <d2929546-27de-4893-a611-dd4a3bca1a64@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4673:EE_|DS1PR18MB6136:EE_
x-ms-office365-filtering-correlation-id: 40731bdf-1adc-4f2a-d459-08dd5d0b74e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|13003099007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OGVrVGUyci9FdG54UFpTcWI5bHhxTnRQSVUvVFpWcXMybTNiQmFTZGJjdE1F?=
 =?utf-8?B?QWNpSFI0Ylg4RWU3VEFmVDhEejJFWGVmTTllay9GRHZuL01TUnkvT05ZdTdN?=
 =?utf-8?B?WC9VcG01N0llTjFQQnhWcjd6Y1g3VHo4Rlpvc0NNeE8vUVpHQ3JZc29xMks5?=
 =?utf-8?B?Z3NJNUZZbkFSUk0xc1lWNmZESjZLOTFCcUcrYVZBb0Qrc1dpRGVOUE5QYVJt?=
 =?utf-8?B?a1dDWm1MNmR4eVQ4aUEzWWtlOHY1Q1NmaWlnQnNOZVcwK2xNNkZjaXF4WWNl?=
 =?utf-8?B?TDFCQVUrV3BvU08zY1k4OVhMT2twaVUycktSdUgvRTM1ODZWZGx6VmdoVUxM?=
 =?utf-8?B?c2JnMDBzT01yZnY3cG81N2JPd3pmaHozUUFEczNYeFJ3RjdaUHdVYW5BTitO?=
 =?utf-8?B?N0daRzdITGxMeDlLVm40RXNkdFNuYXphQ0dtTktBeDNKTWVUNjg0dGVPZGti?=
 =?utf-8?B?ODA3ODVXODRwKzArY05UYnY5LzZ1TlJmNU5sL3p0SmNTbVhCYlBuWXhzQXMy?=
 =?utf-8?B?a1VBUWdWOVI5eExISDhuVW02M2NONTBtQzM5eU9SejROV0lKd3N0QWE5bU0z?=
 =?utf-8?B?K01WVGdsRnFWZ0hDdTBWdllvaXdmaGI2TFcwM2kvMjRlZ2xZdk8vdVlidHpR?=
 =?utf-8?B?dC9UVGwwSit1QUcyNXpqYmFvRlhRczlhSVZqT1FMWGFSaDJpSXQ5ZVRITldR?=
 =?utf-8?B?aFNhRmt5Q1A0WVpVdktnNlRZaHNzN0I0Ui90YUpYTFFkQTlxUWR2UzJ4Ukt5?=
 =?utf-8?B?SjdTQytRY3ZEeU5yUUxzYnpqZXpIWWpIU21yQUtlRGNIRGx5YkJ2aHIvempO?=
 =?utf-8?B?Z2VvdmlYZnZ3SSttcERCMjIwVCtUVGVDcHhlejlRekFWeTN0bWhoYUxaWGNI?=
 =?utf-8?B?M3RVT1pqZG4zK1VWcytyYVhUNGl2eThwVUIrZzhqdWhJR05VdmxpVGFGaFpH?=
 =?utf-8?B?OXRWK2hSdjJldFlDRVlXbDlwYmVmMWl4YXB0aDQ4US9neWFMRzBaVjhoRmFv?=
 =?utf-8?B?RlhSaUk5ZmxZVnc0ZmFRN1MveEt3SWM0eC85VDdnbWtUYjdWTlhuaFpHUVMx?=
 =?utf-8?B?NWxwV2luVEk2RWRUUFBRMENVeER2REJOMSsxaThXelhKNFp5TDVqK2l4Snpk?=
 =?utf-8?B?WUpOS0Z5TlhJRnV3dlhWV0dGdTFPU1M3NjBwd0xhcnE0a3ZEenpMWXgxcnlJ?=
 =?utf-8?B?N2UzbnptNi9RMVdrdnhuT0trdjgrYk9Wb1dIaHd4OWIzVnpNVTdUd1JRRkpG?=
 =?utf-8?B?R0wzSEpubW9VRUdoR0hBVzR4YURtQTJnejdwbnFIMlg2dWtVNXhwMWNiYmh6?=
 =?utf-8?B?ejJteU5HZmE3SjJqcXpQenlOMHVlNytvcUU5K1hybEFkc1N6OTYrVTdBUDdt?=
 =?utf-8?B?WlBuN2p2Q01XRHU3WUdpSnQ5MUJVcGtSTjNHZTFQM3RsdG9tVWZWMGdsdWc5?=
 =?utf-8?B?Wm9uVXlDd0VYV21HdHdPNTZ6OUlCbWZ3TWRoVW5JVjZIVnhLTmh4dUVNTHBi?=
 =?utf-8?B?M0p4VUw2WW5YakhhZlZHajJoL0pzcmd1TWNFdVVEZmxnNG9jVUJ5NVVIV1RV?=
 =?utf-8?B?M05EZDNFdmtoMTUyN1o1aWJ6UkVlMnBZcC9qdFMzR0RLdk9QUGtKTllCL01Y?=
 =?utf-8?B?STBDM2FLbEVxM1l0UWMrTlJpYUh1MStqOWVSUkJlc2poaE1yck1qV1Bib0FC?=
 =?utf-8?B?QlR1UmhBbnZEd0UvR2I3cDlWV0txRU1ZTTF3U254czRybjJuMXRnQzVTbUNO?=
 =?utf-8?B?OTdrREVRS0p1TjQyQjZROG93WVA1TU5oR1hNOUp4ZXg3RDBBUnZqRVpGVy9o?=
 =?utf-8?B?dXZ1dy8zZjhSSTA2cVdKQlhwdmU4V2F5Tmx4Zkdlcjg3cXpEbzdyelhocmhl?=
 =?utf-8?B?M3VBNWhhWUV0VDM2VHhhMkgwYkpLb2FFWCtkWUJ1M2F3RHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4673.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(13003099007)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K2lFTDJWeGloY01IRUY2UFBYQ3dQdm9jM0c1TVhEYlFiczFRZzUzSmZxN2FQ?=
 =?utf-8?B?dlBkRzEvYVM3TlRaZkJCdUhqci9LSnhMYUFEUE5BMmdvVVMrclpmRHJFVjll?=
 =?utf-8?B?V3lRaVNDU2R6WGxvTkduS3VaditvcnFxdUdMUWdndndINkZWcVp4RVpEdjdr?=
 =?utf-8?B?R2hCUnJIdU9OTVdxZ2psUFd5UTJscmFpYXFsdkJmYzJwTzdMNWZvQ1JZQ3ll?=
 =?utf-8?B?R2xXMnJKRjZuaFZieUU3UUpOWU93N2o0L3Vzb055T3p5U0loV3phNTVySGxQ?=
 =?utf-8?B?VFlDZ3hIcEpDTVVNejJsTkZSZVI1Rm1iWW9RNVlFK3hRNnYyRmhwWjd2WVMv?=
 =?utf-8?B?SWhSU3NLRjZSR1dWdFFUdVBMUEI1eC9XNTVocE1HbElwa056dkszVGREZ0M2?=
 =?utf-8?B?T1AwTEI2aWdQUHJvTVVCUEo5U3NuUHhVSjdjVG1NUmNjN0t0TmYxRGgzK0V1?=
 =?utf-8?B?NXF5WjNuUkNnUDZVTS91RlVibW8yWkFCVVRvZFAvRnR6d0Z2UjdTU3JZOU9m?=
 =?utf-8?B?bjNneTVoZTg0M0dPV2NLZDRFNzBYZUlMK3doTjc2REZuQllRcSs1a2pqd3dC?=
 =?utf-8?B?SFVUSVNZWnpPT3MzWHFwalBrVnZvV1RKRWZYaXhpY1VaWCt3ZGxHcElaNHpl?=
 =?utf-8?B?L1UzUjgydU1BNENqaFk3a0RTR28waXVQWks3U1pBbUh4d2JHcnlQOGREY05r?=
 =?utf-8?B?RC9OR3ZoRE93Qms0WXFFTUpFOHVJejh6YzBFZ0xlT0RCeWljUTBLTHQ5WnhK?=
 =?utf-8?B?aG45V2FPeE9QYW5uOWI3aXFlT3hYMkRNNmEwNi90NTdCNUt0Y1JWQ1RhUGtZ?=
 =?utf-8?B?MFlMMDZGQzhNNFdFYi9SZlZBNzU4cGw0V1NQR3VobktGWHRzOTFPN3ZWM1I4?=
 =?utf-8?B?RlJNQWtEVjR2SGJDM25WeDBIN3BVVmdHbnQ2eXQ3MWxnMHpwR28yWTk1dlV3?=
 =?utf-8?B?TFF3K2dBK0l5SmFUbkZCaTcvZkR2VE1vWWwvN2JGYVFCN29BbFpibkhlaURF?=
 =?utf-8?B?Mk5wQjFQaDBwZHk4Ky9pNVBOWWZGdWNOOFg0L3RxY2paVlhnMTdqenJJQXg3?=
 =?utf-8?B?dmY3dGhzRG1aSURubVZOUGVIeXMwaWREeW15UU94YnNseUx0d2g4d2ZDcDhV?=
 =?utf-8?B?UElVLzBhT3hoVEs0VHg4R0V3aVdlY3FIclV0azM1Z0Ziems2VjU2SEV3V2t6?=
 =?utf-8?B?NGZ5ZEdZcmdlOGltaFovSWM3MnBDWWhDblV5NjJmYmZrQXdCblhIeWVrM1pQ?=
 =?utf-8?B?SFFkTHEwek9mdDJsQ1grckdkRG43N1VMTmFHakV6ejdNTWhvcXJwSll3L1Jw?=
 =?utf-8?B?WjY3aWF3cWVOYmNndHAvZVBreGRCMXdRdG1ZcUpmd093MGUxM2pYWFFlZWhy?=
 =?utf-8?B?WDlVRGhqTWQ0WmZheXdGZjI0Z0lMRTRwNXpBS2pKVHd0b3hOemNQNkJmM05m?=
 =?utf-8?B?M055S0pMZEUxRnpWeXJzVW5haHMzY1Bkbjk5bWFXcVdRenFhTkplYW5oSE56?=
 =?utf-8?B?OFZQT2tXSFBLcW04M0xjYXUrR3d6NFJNdEJKWm95cWlhZDFmR1paMUpMQlR1?=
 =?utf-8?B?WUVKWEVvOGtPNDFmVFNGMFc0VVNQN1JJZmZUeXJlWGVvSU5UQ2I2NnZJREhP?=
 =?utf-8?B?endMbDVwL2tPcVJabGg0SnhLZ0lER2E2TzdoZmZvUjhGOTNoZHpJUUdBK0V3?=
 =?utf-8?B?MWJhTDcycnJkeFdUNTJwMk5md1VlRVU3VjBVb0FsVTFQZTNxOGhQaVJ4ay9z?=
 =?utf-8?B?WFJlenl4MEo0K3FYOGdwTlpibHlWUjhRQmJrZi9zeTJmQmFWUXdBb2xJZW5s?=
 =?utf-8?B?VzBFR3lSblljbFN3S3p0MmdoaHpxVjF6OVFZM282d3B4UVNQaEJFb1FYVGY0?=
 =?utf-8?B?bXFjVDRkN2ZnOGQxWGwyMmlDa1pGSXV2RkIrWlV1U3dtekRLZ25QdTVYaWtr?=
 =?utf-8?B?a0Z6VFJXenR6OCtuNkpqYmVMQjh2YXBZcmMvV3Fxdk91Y0VRdXUydWt3QmhH?=
 =?utf-8?B?N1lHcnRlUG8xMWxUU28zMnFydlFreTZuMlg1STJJRHdGRHM2YzJSL3p0eDNK?=
 =?utf-8?B?Tm80SXJzUmdiQ2lQV1YxdVNGVjJodllRWnF3MGo3TzVMOTRsMmZUN0lzcmNr?=
 =?utf-8?Q?GlIRyjlyOB9jfLKQNETitXABw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4673.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40731bdf-1adc-4f2a-d459-08dd5d0b74e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 00:03:14.3680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2v3eZRgPm6FX54/+5McN0HNI1kdx8IP37djpfhn0beEH3mAXARJXtIvUBtYOGtN9i2CcKfBIbjdWDLWeGyGBNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR18MB6136
X-Authority-Analysis: v=2.4 cv=BMlJrEQG c=1 sm=1 tr=0 ts=67ca37c5 cx=c_pps a=19NZlzvm9lyiwlsJLkNFGw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=-AAbraWEqlQA:10 a=RpNjiQI2AAAA:8 a=VwQbUJbxAAAA:8 a=uP1ucDPQAAAA:8 a=M5GUcnROAAAA:8 a=JfrnYn6hAAAA:8 a=P-IC7800AAAA:8 a=pGLkceISAAAA:8 a=elLWZlKbAAAA:8 a=YjAAACTkfXuBAZgLHZsA:9 a=QEXdDO2ut3YA:10 a=9a9ggB8z3XFZH39hjkD6:22
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=1CNFftbPRP8L7MoqJWF3:22 a=d3PnA9EDa4IxuAV0gXij:22 a=YXs7sxRoaa14xkmg_1jM:22
X-Proofpoint-GUID: dS0gewU-5sRrvsd6e8Ap3t17lLRd4gyu
X-Proofpoint-ORIG-GUID: dS0gewU-5sRrvsd6e8Ap3t17lLRd4gyu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_08,2025-03-06_04,2024-11-22_01

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgRmVicnVhcnkgMjcsIDIw
MjUgMTA6NTMgUE0NCj4gVG86IFdpbHNvbiBEaW5nIDxkaW5nd2VpQG1hcnZlbGwuY29tPjsgUm9i
IEhlcnJpbmcgKEFybSkNCj4gPHJvYmhAa2VybmVsLm9yZz4NCj4gQ2M6IGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgU2FuZ2hvb24gTGVlIDxzYWxlZUBtYXJ2ZWxsLmNvbT47
DQo+IGNvbm9yK2R0QGtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+
IGdyZWdvcnkuY2xlbWVudEBib290bGluLmNvbTsgcC56YWJlbEBwZW5ndXRyb25peC5kZTsgR2Vl
dGhhc293amFueWENCj4gQWt1bGEgPGdha3VsYUBtYXJ2ZWxsLmNvbT47IGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnOyBhbmRyZXdAbHVubi5jaDsNCj4ga3J6aytkdEBrZXJuZWwub3JnOyBzZWJh
c3RpYW4uaGVzc2VsYmFydGhAZ21haWwuY29tDQo+IFN1YmplY3Q6IFJlOiBbRVhURVJOQUxdIFJl
OiBbUEFUQ0ggdjMgMS8zXSBkdC1iaW5kaW5nczogcmVzZXQ6IEFkZA0KPiBBcm1hZGE4SyByZXNl
dCBjb250cm9sbGVyDQo+IA0KPiBPbiAyNy8wMi8yMDI1IDIyOjU4LCBXaWxzb24gRGluZyB3cm90
ZToNCj4gPj4NCj4gPj4gZHRzY2hlbWEvZHRjIHdhcm5pbmdzL2Vycm9yczoNCj4gPj4gL2J1aWxk
cy9yb2JoZXJyaW5nL2R0LXJldmlldy0NCj4gPj4gY2kvbGludXgvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3Jlc2V0L21hcnZlbGwsYXJtYWRhOGstDQo+ID4+IHJlc2V0LmV4YW1w
bGUuZHRiOiBzeXN0ZW0tY29udHJvbGxlckA0NDAwMDA6IGNvbXBhdGlibGU6IFsnc3lzY29uJywN
Cj4gPj4gJ3NpbXBsZS0gbWZkJ10gaXMgdG9vIHNob3J0DQo+ID4+IAlmcm9tIHNjaGVtYSAkaWQ6
IGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwLQ0KPiA+PiA8
aHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHAtICA+Pj4NCj4g
Pj4gM0FfX2RldmljZXRyZWUub3JnX3NjaGVtYXNfbWZkX3N5c2Nvbi0yRGNvbW1vbi55YW1sLQ0K
PiA+Pg0KPiAyMyZkPUR3SURhUSZjPW5LaldlYzJiNlIwbU95UGF6N3h0ZlEmcj1zWERRWnU0R3lx
TlZEbEZVWGFrUw0KPiA+PiBHSmwwRGg4MVpJUGxVMjZZUzRLSEdJQSZtPXh3ME0tLQ0KPiA+Pg0K
PiAydGg5VEN0MDVNMHFfYzhDMGp2ZzF0NHFidVh4OV9kM1dnQ2MwSE9CcGc1X2Y1RTZUalhQX3hk
Y3JVJnM9Mw0KPiA+PiBHZG00QUJWMTBQbllFcEF2SlhyVjl4LVRzZkJBSElwNUtDbjYwb2huZ00m
ZT0NCj4gPj4NCj4gPj4gZG9jIHJlZmVyZW5jZSBlcnJvcnMgKG1ha2UgcmVmY2hlY2tkb2NzKToN
Cj4gPj4NCj4gPj4gU2VlIGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/
dT1odHRwcy0NCj4gPj4gPGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/
dT1odHRwcy0gID4+Pg0KPiA+PiAzQV9fcGF0Y2h3b3JrLm96bGFicy5vcmdfcHJvamVjdF9kZXZp
Y2V0cmVlLQ0KPiA+PiAyRGJpbmRpbmdzX3BhdGNoXzIwMjUwMjI3MTkyNTM2LjI0MjY0OTAtMkQy
LTJEZGluZ3dlaS0NCj4gPj4NCj4gNDBtYXJ2ZWxsLmNvbSZkPUR3SURhUSZjPW5LaldlYzJiNlIw
bU95UGF6N3h0ZlEmcj1zWERRWnU0R3lxTg0KPiA+PiBWRGxGVVhha1NHSmwwRGg4MVpJUGxVMjZZ
UzRLSEdJQSZtPXh3ME0tLQ0KPiA+Pg0KPiAydGg5VEN0MDVNMHFfYzhDMGp2ZzF0NHFidVh4OV9k
M1dnQ2MwSE9CcGc1X2Y1RTZUalhQX3hkY3JVJnM9DQo+ID4+IFdKem5BTEJXaGVqUzlocTg4akN2
WnFldmFOZE5fNS1tZUtmb3dSZmwtYkEmZT0NCj4gPj4NCj4gPj4gVGhlIGJhc2UgZm9yIHRoZSBz
ZXJpZXMgaXMgZ2VuZXJhbGx5IHRoZSBsYXRlc3QgcmMxLiBBIGRpZmZlcmVudA0KPiA+PiBkZXBl
bmRlbmN5IHNob3VsZCBiZSBub3RlZCBpbiAqdGhpcyogcGF0Y2guDQo+ID4+DQo+ID4+IElmIHlv
dSBhbHJlYWR5IHJhbiAnbWFrZSBkdF9iaW5kaW5nX2NoZWNrJyBhbmQgZGlkbid0IHNlZSB0aGUg
YWJvdmUNCj4gPj4gZXJyb3IocyksIHRoZW4gbWFrZSBzdXJlICd5YW1sbGludCcgaXMgaW5zdGFs
bGVkIGFuZCBkdC1zY2hlbWEgaXMgdXANCj4gPj4gdG8NCj4gPj4gZGF0ZToNCj4gPj4NCj4gPj4g
cGlwMyBpbnN0YWxsIGR0c2NoZW1hIC0tdXBncmFkZQ0KPiA+Pg0KPiA+PiBQbGVhc2UgY2hlY2sg
YW5kIHJlLXN1Ym1pdCBhZnRlciBydW5uaW5nIHRoZSBhYm92ZSBjb21tYW5kIHlvdXJzZWxmLg0K
PiA+PiBOb3RlIHRoYXQgRFRfU0NIRU1BX0ZJTEVTIGNhbiBiZSBzZXQgdG8geW91ciBzY2hlbWEg
ZmlsZSB0byBzcGVlZCB1cA0KPiA+PiBjaGVja2luZyB5b3VyIHNjaGVtYS4gSG93ZXZlciwgaXQg
bXVzdCBiZSB1bnNldCB0byB0ZXN0IGFsbCBleGFtcGxlcw0KPiA+PiB3aXRoIHlvdXIgc2NoZW1h
Lg0KPiA+DQo+ID4gSSBjYW5ub3QgcmVwcm9kdWNlIHRoZSBhYm92ZSBlcnJvciB3aXRoIHRoZSBs
YXRlc3QgJ3lhbWxsaW50JyBhbmQgJ2R0LXNjaGVtYScuDQo+ID4NCj4gPiAkIHBpcDMgaW5zdGFs
bCBkdHNjaGVtYSAtLXVwZ3JhZGUNCj4gPiBSZXF1aXJlbWVudCBhbHJlYWR5IHNhdGlzZmllZDog
ZHRzY2hlbWEgaW4NCj4gPiAvaG9tZS93aWxzb24vd29ya3NwYWNlL3JlcG9zL2V4dGVybmFsL3Zl
bnYvbGliL3B5dGhvbjMuMTIvc2l0ZS0NCj4gcGFja2FnZQ0KPiA+IHMgKDIwMjUuMikgUmVxdWly
ZW1lbnQgYWxyZWFkeSBzYXRpc2ZpZWQ6IHJ1YW1lbC55YW1sPjAuMTUuNjkgaW4NCj4gPiAvaG9t
ZS93aWxzb24vd29ya3NwYWNlL3JlcG9zL2V4dGVybmFsL3ZlbnYvbGliL3B5dGhvbjMuMTIvc2l0
ZS0NCj4gcGFja2FnZQ0KPiA+IHMgKGZyb20gZHRzY2hlbWEpICgwLjE4LjEwKSBSZXF1aXJlbWVu
dCBhbHJlYWR5IHNhdGlzZmllZDoNCj4gPiBqc29uc2NoZW1hPDQuMTgsPj00LjEuMiBpbg0KPiA+
IC9ob21lL3dpbHNvbi93b3Jrc3BhY2UvcmVwb3MvZXh0ZXJuYWwvdmVudi9saWIvcHl0aG9uMy4x
Mi9zaXRlLQ0KPiBwYWNrYWdlDQo+ID4gcyAoZnJvbSBkdHNjaGVtYSkgKDQuMTcuMykgUmVxdWly
ZW1lbnQgYWxyZWFkeSBzYXRpc2ZpZWQ6IHJmYzM5ODcgaW4NCj4gPiAvaG9tZS93aWxzb24vd29y
a3NwYWNlL3JlcG9zL2V4dGVybmFsL3ZlbnYvbGliL3B5dGhvbjMuMTIvc2l0ZS0NCj4gcGFja2Fn
ZQ0KPiA+IHMgKGZyb20gZHRzY2hlbWEpICgxLjMuOCkgUmVxdWlyZW1lbnQgYWxyZWFkeSBzYXRp
c2ZpZWQ6IHB5bGliZmR0IGluDQo+ID4gL2hvbWUvd2lsc29uL3dvcmtzcGFjZS9yZXBvcy9leHRl
cm5hbC92ZW52L2xpYi9weXRob24zLjEyL3NpdGUtDQo+IHBhY2thZ2UNCj4gPiBzIChmcm9tIGR0
c2NoZW1hKSAoMS43LjIpIFJlcXVpcmVtZW50IGFscmVhZHkgc2F0aXNmaWVkOiBhdHRycz49MTcu
NC4wDQo+ID4gaW4gL2hvbWUvd2lsc29uL3dvcmtzcGFjZS9yZXBvcy9leHRlcm5hbC92ZW52L2xp
Yi9weXRob24zLjEyL3NpdGUtDQo+IHBhY2thZ2VzIChmcm9tIGpzb25zY2hlbWE8NC4xOCw+PTQu
MS4yLT5kdHNjaGVtYSkgKDI1LjEuMCkgUmVxdWlyZW1lbnQNCj4gYWxyZWFkeSBzYXRpc2ZpZWQ6
IHB5cnNpc3RlbnQhPTAuMTcuMCwhPTAuMTcuMSwhPTAuMTcuMiw+PTAuMTQuMCBpbg0KPiAvaG9t
ZS93aWxzb24vd29ya3NwYWNlL3JlcG9zL2V4dGVybmFsL3ZlbnYvbGliL3B5dGhvbjMuMTIvc2l0
ZS0NCj4gcGFja2FnZXMgKGZyb20ganNvbnNjaGVtYTw0LjE4LD49NC4xLjItPmR0c2NoZW1hKSAo
MC4yMC4wKSBSZXF1aXJlbWVudA0KPiBhbHJlYWR5IHNhdGlzZmllZDogcnVhbWVsLnlhbWwuY2xp
Yj49MC4yLjcgaW4NCj4gL2hvbWUvd2lsc29uL3dvcmtzcGFjZS9yZXBvcy9leHRlcm5hbC92ZW52
L2xpYi9weXRob24zLjEyL3NpdGUtDQo+IHBhY2thZ2VzIChmcm9tIHJ1YW1lbC55YW1sPjAuMTUu
NjktPmR0c2NoZW1hKSAoMC4yLjEyKSAkIHBpcDMgaW5zdGFsbA0KPiB5YW1sbGludCBSZXF1aXJl
bWVudCBhbHJlYWR5IHNhdGlzZmllZDogeWFtbGxpbnQgaW4NCj4gL2hvbWUvd2lsc29uL3dvcmtz
cGFjZS9yZXBvcy9leHRlcm5hbC92ZW52L2xpYi9weXRob24zLjEyL3NpdGUtDQo+IHBhY2thZ2Vz
ICgxLjM1LjEpIFJlcXVpcmVtZW50IGFscmVhZHkgc2F0aXNmaWVkOiBwYXRoc3BlYz49MC41LjMg
aW4NCj4gL2hvbWUvd2lsc29uL3dvcmtzcGFjZS9yZXBvcy9leHRlcm5hbC92ZW52L2xpYi9weXRo
b24zLjEyL3NpdGUtDQo+IHBhY2thZ2VzIChmcm9tIHlhbWxsaW50KSAoMC4xMi4xKSBSZXF1aXJl
bWVudCBhbHJlYWR5IHNhdGlzZmllZDogcHl5YW1sIGluDQo+IC9ob21lL3dpbHNvbi93b3Jrc3Bh
Y2UvcmVwb3MvZXh0ZXJuYWwvdmVudi9saWIvcHl0aG9uMy4xMi9zaXRlLQ0KPiBwYWNrYWdlcyAo
ZnJvbSB5YW1sbGludCkgKDYuMC4yKSAkIG1ha2UgZHRfYmluZGluZ19jaGVjaw0KPiA+ICAgU0NI
RU1BICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHJvY2Vzc2VkLXNjaGVtYS5q
c29uDQo+ID4gICBDSEtEVCAgIC4vRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzDQo+
ID4gICBMSU5UICAgIC4vRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzDQo+ID4gICBE
VEVYICAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZXNldC9tYXJ2ZWxsLGFy
bWFkYThrLQ0KPiByZXNldC5leGFtcGxlLmR0cw0KPiA+ICAgRFRDIFtDXQ0KPiA+IERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZXNldC9tYXJ2ZWxsLGFybWFkYThrLXJlc2V0LmV4
YW1wbGUNCj4gPiAuZHRiDQo+ID4NCj4gDQo+IFRoYXQncyBhIGJpdCBvZGQgYnV0IGFueXdheSB3
YXJuaW5nIGlzIGNvcnJlY3Q6IHlvdSBjYW5ub3QgaGF2ZSBzdWNoDQo+IGNvbXBhdGlibGVzIGFs
b25lLg0KDQpJIHVuZGVyc3RhbmQgSSBuZWVkIHRvIGFkZCBvbmUgY29tcGF0aWJsZSBoZXJlIHRv
IHJlc29sdmUgdGhlDQp3YXJuaW5nLiBIb3dldmVyLCBhcyB3ZSBhZ3JlZWQsIHdlIGtlZXAgdGhl
IHN1ZC1ub2RlcyB3aGlsZQ0KdGhlcmUgd2lsbCBiZSBubyBuZXcgY29tcGF0aWJsZXMgaW4gcGFy
ZW50IG5vZGUuIFNvIGhvdyBzaGFsbA0KSSBhdm9pZCB0aGlzIHdhcm5pbmc/DQoNCklmIHdlIGRv
IHdhbnQgdG8gYWRkIGEgY29tcGF0aWJsZSBpbiBwYXJlbnQgbm9kZSwgd2hhdCBzaG91bGQNCmJl
IHVzZWQgZm9yIHRoZSBjb21wYXRpYmxlIG5hbWU/IEkgdGhpbmsgdGhlIG1vc3Qgc3VpdGFibGUg
bmFtZQ0Kd291bGQgYmUgc29tZXRoaW5nIGxpa2UgIm1hcnZlbGwsY3AxMTAtc3lzdGVtLWNvbnRy
b2xsZXIwIi4NCkhvd2V2ZXIsIGl0IHdhcyBhbHJlYWR5IHRha2VuIGZvciBpbiBBcm1hZGEgY2xv
Y2sgY29udHJvbGxlciB0bw0KYmUgY29tcGF0aWJsZSBmb3IgbGVnYWN5IGR0Lg0KDQpodHRwczov
L2xvcmUua2VybmVsLm9yZy9hbGwvYmIyMWVlOWFjYzU1ZWZhYzg4NDQ1MGZmNzEwMDQ5Yjk5YjI3
ZjhiZi4xNDk2MzI4OTM0LmdpdC1zZXJpZXMuZ3JlZ29yeS5jbGVtZW50QGZyZWUtZWxlY3Ryb25z
LmNvbS8NCg0KVGhpcyBpcyBzb21ldGhpbmcgYWJvdXQgOCB5ZWFycyBhZ28uIEkgd29uZGVyIGlm
IHdlIGRvIG5lZWQgdG8NCmhhdmUgdGhlIGJhY2t3YXJkIGNvbXBhdGliaWxpdHkgZm9yIHRoZSBm
aWVsZCBkZXZpY2VzIGF0IHRoYXQNCnRpbWUuIENhbiB3ZSBkcm9wIGl0IG5vdz8NCg0KICAgIHN5
c2NvbjA6IHN5c3RlbS1jb250cm9sbGVyQDQ0MDAwMCB7DQogICAgICAgIGNvbXBhdGlibGUgPSAi
bWFydmVsbCxjcDExMC1zeXN0ZW0tY29udHJvbGxlcjAiLA0KICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAic3lzY29uIiwgInNpbXBsZS1tZmQiOw0KICAgICAgICByZWcgPSA8MHg0NDAw
MDAgMHgyMDAwPjsNCiAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQogICAgICAgICNzaXpl
LWNlbGxzID0gPDE+Ow0KDQogICAgICAgIHN3cnN0OiByZXNldC1jb250cm9sbGVyQDI2OCB7DQog
ICAgICAgICAgICBjb21wYXRpYmxlID0gIm1hcnZlbGwsYXJtYWRhOGstcmVzZXQiOw0KICAgICAg
ICAgICAgcmVnID0gPDB4MjY4IDB4ND47DQogICAgICAgICAgICAjcmVzZXQtY2VsbHMgPSA8MT47
DQogICAgICAgIH07DQogICAgfTsNCg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YN
Cg==

