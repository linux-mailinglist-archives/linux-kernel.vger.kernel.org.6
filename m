Return-Path: <linux-kernel+bounces-435518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 292429E78EE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9227283A2C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070CD203D56;
	Fri,  6 Dec 2024 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="IPfENovG";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="O7Vlo4S8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="UBYASZGl"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900341D515D;
	Fri,  6 Dec 2024 19:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733513282; cv=fail; b=PBhi/KsWiJU6EFdW/RlusTeMUjWlzv60M7y9BfLXNo30a7YDONmXx5Bz2YUqzwYpyIDFZyf1PRGKfqBDTivj0GtsY7DXo3zloyAMFap2A5waPZSYZ8vw3MNRcap/xU/NmZycR8+Sf6Rz6wHFqnyDJ0xymNZcxux62p491NS4EhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733513282; c=relaxed/simple;
	bh=+Uf8eV9zCYwhu4+Nlmq1zYBqcdDNJnEwoPw6BqsiHio=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pf6A+KIl8i2xBeSI0IUEjB95LH0PgwiMV751PHKrF6RYoElh3X2UEp8+BHU4ofqmWeLIpJiM/Wp9tMpRR/+Ld+Fq5I0iELUoOVHjxB2gaUVkZHKhNBIwghiYYlg5eUVzzTIQ9M9JPBvtUusQ1dDqLTAITqXmyPew/OKC+Yj+Ssg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=IPfENovG; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=O7Vlo4S8; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=UBYASZGl reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6FfsAF030344;
	Fri, 6 Dec 2024 11:27:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=+Uf8eV9zCYwhu4+Nlmq1zYBqcdDNJnEwoPw6BqsiHio=; b=
	IPfENovGLlT0/HNF89Bhlp3ZZclsUmBQ3gSUF/xc8VdX0R1MDJKdv/0+4MrjZy8b
	UKGowbw04CK0ROs5/IFcBHsUnaS7sOTBmg/92GPaJxNB2WHwQRJPOHNH/QGD8+2J
	7YxOho7sMrk0oa/Yytf/P96U9Z1kdcjPGZukqR7Bk+G3lDZLF88ruEzhbPOKJk7V
	Hg2CGzcbFzQwSZYOsX48xOKiUGdN0AKN2WjRQ9W3GKCapMBLIkLCNZ8xuCT7uf0i
	ccE4zM6rOJ1QAth46tYopzRB1zkaOsDWAwwL76odidAePi23fnNevAYk4l2Zmwas
	PF/fUqtcdqntWa3Q1bIrgw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 43ba8n9tu9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 11:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1733513271; bh=+Uf8eV9zCYwhu4+Nlmq1zYBqcdDNJnEwoPw6BqsiHio=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=O7Vlo4S8hgnOI87/SYOcHyjSJoHp0kt7NcJmpDxDybwToVsNJ336GLMZ8+TDZtXPW
	 ScILiL1OpwsP80ZrgLFfrYuiWuog3amvDLeqrMbMTYC22obx2QpCr4M3CvFnvDYI48
	 5uMFVeef9HxE5T6GTC0u7zj4RBGVJZEX6qXp+glX/bvUofvUbydz3ZS7+AMtku2+pV
	 k5GHluWJ0pLlF6manT5QcoXkqwMmo/0TVBC8cufSyKMHIHwlMa4r+C1J03AArDjGun
	 pjwfZ0uuYntGXBZhOvRXlLGZBxKpwBtzrAiwJZT/zBQXocUTGCl9Z/1SDzqATX/DLp
	 GJgNcY198+h0w==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6E6FA40110;
	Fri,  6 Dec 2024 19:27:51 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 14EEAA005F;
	Fri,  6 Dec 2024 19:27:51 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=UBYASZGl;
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4EBF4401EF;
	Fri,  6 Dec 2024 19:27:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKB1M5iaAFdQLH8/fAET+lvUZPCs1lQWT8RCTV9dCthI64Jb5C03NGDdNyFYyMznjb5zxppZYaqsbQ+6xzAGdcntGo3DcmovApqoLlARxcmNCbQMGt3lUuO5kuBCCsuhbtOiGAIpdfStC4lW1rGKRTaEbFYQrmCk0s79gIGkv9d4EtXQ3kleAwlBS/zMhzZVQK+e1N/9GwI7d23GWt5zFrtoZm1muP9dOJOCHMIEpIgXxcVmo0sTwWIGsh5sr3YQ5r1IkTaIuvELegEbfBPM3Iprhj+LJySrTC9DYX9+U34e14Bq5Q7WmFkTJWZYp79ftfVbo8GxWIwXAVQJ8A0ntw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Uf8eV9zCYwhu4+Nlmq1zYBqcdDNJnEwoPw6BqsiHio=;
 b=Xo1aDq7Q10qAQDsbqVXz+Dgi6IPRkFAg4pIJBpTVqT6RozVs3Pf8X9X+7iha2k9jAMsVXMxvV4zafTUZVDWrkzZ4B87NyEfBA3s5nXpgibXdDtjOAqKa3z2EM1WW58Gq+xGVdC9XSdN7EepXB+2M9EnBnW264tIa7mRZG9z91SmdzuJbuusDs5l31MgzZ5ze+Q1GVhNixUt1laZpx6PXssxrslS642IHz4ipNTT/5BkUMB0PCiYxorau0Y01xwGI48JQs1v9D7k61V5Dc5XVWbAZNfhqReT7nUyKNxTj8rNK5LvaiYpwwkZ2EpfkztCHTy/IfYjv7ZvMLo6jyCozKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Uf8eV9zCYwhu4+Nlmq1zYBqcdDNJnEwoPw6BqsiHio=;
 b=UBYASZGl5XouFLVuGK/3Qy4ebGSyMVxpCaJaC1V0UfQ53ffogOxIAM+I8S6IKmF/i7wnIKPrBgp1AIBWuYUjlnInCWDcc+wR9TDh1BafwpzutdCL9O2mbIa3fiDetZRMz8tmHsuok3FiyquwK/StEAiymvDfDX0EjC+4zNIqPvA=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DS7PR12MB6118.namprd12.prod.outlook.com (2603:10b6:8:9a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.18; Fri, 6 Dec 2024 19:27:46 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%7]) with mapi id 15.20.8207.020; Fri, 6 Dec 2024
 19:27:46 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: =?utf-8?B?QW5kcsOpIERyYXN6aWs=?= <andre.draszik@linaro.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: gadget: fix writing NYET threshold
Thread-Topic: [PATCH] usb: dwc3: gadget: fix writing NYET threshold
Thread-Index: AQHbR9kqaEVQ7uUyHEyBiXD3eZ7glLLZmA+AgAACGIA=
Date: Fri, 6 Dec 2024 19:27:45 +0000
Message-ID: <20241206192745.hleuzue7kilari4x@synopsys.com>
References: <20241206-dwc3-nyet-fix-v1-1-293bc74f644f@linaro.org>
 <20241206192015.pwecvtssndjfi7qg@synopsys.com>
In-Reply-To: <20241206192015.pwecvtssndjfi7qg@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DS7PR12MB6118:EE_
x-ms-office365-filtering-correlation-id: 665e93d6-839b-49e0-b7c6-08dd162c1012
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MVlHeHBWK3UvMzFmWmkyK3NuWUlIa0s5dEJLVnpKQnN6VDRKK05VNVlhc2hX?=
 =?utf-8?B?NFBiUXhES1JYZjJIK1pnZkkrNDdwMXpHT0NPNVpObFY3MWhJVlZVMFhhV2t5?=
 =?utf-8?B?NGFrcG54ZXlaZVZHMG9iMUoyOW9YMlJ1c0lxWnN5WU93eGo2MmNjSXRaVEJO?=
 =?utf-8?B?MUJtU2dQaEZYN0FQMmo5Y2JFS3dhdllCcWpDRm5nQjlPQW5JaDVZTHZFWXpQ?=
 =?utf-8?B?Q2lCUnRlVi9reEp5Y04vUnRmS0Z4Ukx4ZmpEaWFLNkFMYm95NzNobTRUVytq?=
 =?utf-8?B?Q0pVMUo3ZHIvUUw1NjBqd0NjRDBkb2V4Q2ErWmVvbkovTFkxUFF2SGp4YmJa?=
 =?utf-8?B?cTgxeFVOaTdxL2ZnejVEU3JCbnIwRzZydjhhNFl2ZWtmcFFld01sY05rWlA0?=
 =?utf-8?B?Rko1d291SnIwSWZKMGNJLzJRR0NXby94bzYwdGtJSnR1UXF1c0RubmMxcmps?=
 =?utf-8?B?aGZxK2VMakU3QlVnaVZ2UytxVmFVS3l6MWJCSjlQQ2s3VllhNGpDdVl0QkNR?=
 =?utf-8?B?MlFTalJGZG0wQXBZTHpxZy84eU1wZ2lwZjFUc1Z5bzYzZUxpOTFOTi9hek50?=
 =?utf-8?B?WHoydkpNN01Va0pBVWhDZ2dMTm9jYmR0SldKTytDVXlQbURJMHBFUThPOXpz?=
 =?utf-8?B?cDhBNUhuOXRhWXZCSE5ZcW12dXN5eUoweStwSnFTNjZGbk91YWg2N1BLbnVI?=
 =?utf-8?B?cWdzUmt3Y3d6cmNBVC9JQ3RxWHhjenRBZGJMV1BKcC90Q0w1VDl1ZjU1eW9h?=
 =?utf-8?B?YS9aazBCZnZvWjBvTWs5bEdwUVNNekhVdjZoS2xkcUhyMktmM1dNNy80c1ow?=
 =?utf-8?B?OEc2UGk1QW9DZktvclZkVUt2SGNyTk1jdjNXTGJRWWhJbU01T1RHSDQzNll6?=
 =?utf-8?B?T2lxblhpcWE2NzZEUVBqcXV1RHFBNXprWWkrOWc5QjMvZGRrMyt2NndqSDQ2?=
 =?utf-8?B?RkxNL3dyQnUwRW1uUjhseTJqMjdmaTdNTHE0LzhmNllnRVI0WmpzSHZXUzhH?=
 =?utf-8?B?VEh5VzNuUGdQV29qQzZzOWtIcWJqVHpPWU1hTkxKcnhBUzh5d2c0bktkU1gw?=
 =?utf-8?B?OXp6MHlGeGxua1N0UEl6cERhbUN6a0R2R0NPWG8zWkZWa2RQdXdZaWV4Undh?=
 =?utf-8?B?SW5zQjdWeWNGMlMyK3F6MGpPM0JaVi9ZMGg0VEd6czluTWlkTUtxQTlFMlBD?=
 =?utf-8?B?RUh4Mjh6alpnNWhZbjVvV3MzSWJMU0FXSENCT29VcG9pZXZXQ21uUER2OTR3?=
 =?utf-8?B?NmJOUnhGUjBqUGNIdVNlOUlZNVA0OURuZ29ndkVSWXR2QWRmVWovU0FhcmVi?=
 =?utf-8?B?L1MrR3BNdExwNE1RQ2E5VWp0ZXVNaGNUV2lteExMREJiM2dRQ2lpQndXbUtJ?=
 =?utf-8?B?bkxhNUQxd2wyWGtrV3V2c3ZIbDBURkhDZUQ3T1VPZHA5Z1hrWGJHdjBQQ2h2?=
 =?utf-8?B?NXZmeWpXSDBjQlA0eGJKd1JSTEFrZXp1c2Vkb2pJaWNFV2tQQS96NU8zbmY3?=
 =?utf-8?B?anV0YUoxWW52Z3RGYWNrQWUxR1NPTWJ6NEVVeDd2bFVUYndQc05OUkw4d3RY?=
 =?utf-8?B?T2tDRVkrR0JLdUJxa3NCTXdFZzdWaFBiZzdWUjB3WExNdFlwVDhqSXViUGR2?=
 =?utf-8?B?Nmp2SkxBTEFURW9Pdk1MU2ZON1hzSnlWa1VuQUx6ZGN5QVg0eVROMWpOaUUr?=
 =?utf-8?B?UWVVRXpiOERJZmI4L1loVFBLNzBmWlU3dGhpcjhTRlorZFNZWXhLVFdqeldT?=
 =?utf-8?B?SlB4d0RVN2FiWE4xYlZpMVM3NmhTM2lGRFFqOFgwcWs2NlZ5dEpxSUdiV09K?=
 =?utf-8?B?OWE2VTNzZk5CcktCS2JKRUtISm9yb1FYQXU5eC9vOGw0ZC8xSWlwVHFneUZQ?=
 =?utf-8?B?aDVhbEZMcWIxVm0yUm1IOGxWZ3FwRUxrVTNxbWdoTkFWTVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cHdFc1ppV0lVT0dpN2E4Q3kwOEtiamxmRzgwOEx1TCtFdXFaY1Z0alhxTGlj?=
 =?utf-8?B?aWM4ZXJPZFFPYmlldG96ZklyR05qSkltSWo5Y1JlTSs0U2xYVDRCSWNPMHA0?=
 =?utf-8?B?c2ZubHRISGpvTCt4Q3Azb2FVYkZhWkszcnc4dm9nYWhlWGRJVlF6Q0s3Vmh1?=
 =?utf-8?B?SVBBWnlRS29udmwrUzNiUXg2WldtenlQNXYwVm8vbnB2NEsycHNoVDZ0eDVs?=
 =?utf-8?B?SDBlcXVXQVBUVVdQYzFVWU00RC9haTRNL0pCdFA2eHZHUy96akJ1N09pQXNj?=
 =?utf-8?B?WC9jY3JLWmxZa2R3bVMvUEh4SFlxL0F0RFFXc2tFSEowQTdwY3hkdkNIY3oy?=
 =?utf-8?B?Qk45L0tJTGFsQ3hFRlE0RVVsSkh5NU9hWkIvWmJqRS9ZN2lBY3E0czFtdVp6?=
 =?utf-8?B?eHhWMW1HbUptWjM4UzBQTngrVTNHTHk0cDM4aDRBYVZXanJSaHkrcnUrUmt1?=
 =?utf-8?B?SXNjL0xkWE1LOThPYitGRDNRUy9iVzVvbkxxVjhVY1BFOXZoV1Y4WXlHbVhQ?=
 =?utf-8?B?bmp3RmJXTk11WXFZS2QzK1JvZUhNWnZWSUxYcmFaak9TRVNxbkx0clZTRGM0?=
 =?utf-8?B?cVl6OURtMjBMcTZkZWhVUkVaMjdxUjB3TXZkZCt0WnF2V0lrSC80YUxOdWh2?=
 =?utf-8?B?bXlrYmxoWnEvUEdjamVQVlNBcTVmeUoyZzZnL1VUOWxRT1NEdUFUSEtpRk11?=
 =?utf-8?B?TGN3NHM1T1lmYmc4eFMzUXAwSmpGK1ZoT1ViRU0yYnJ2MU56YlN6N2FiY1R0?=
 =?utf-8?B?aG9saUlUVmU1QVZ5VHl2a0lZWGpTSkd1OTM0ajRVa1FkYUdBSTRaRjk5L0Vl?=
 =?utf-8?B?WHBOUVJWcjBOUHpxQ2hTaHZkQ2dHL2tzVUNRQVdGM095eXpOeWtuWUZqdkJT?=
 =?utf-8?B?cUh4VGhlNGJwank4amxKTmIxcnYzUmxRc0h3R09wZTk0RzBNUytPeUxmN2Jy?=
 =?utf-8?B?TmhRQkxoV1NQU1ZPa1hkQUVUQVVNaitvWjNmdllra2RaWjhnYVNLTDZsVWtO?=
 =?utf-8?B?c29vblVYOEdwR3BPOG1SMW1RWElWR1Z3VHBXVHFrandXbVJuQld1YTdqQ0Jv?=
 =?utf-8?B?clYrZDhZMkFJQ0N6RDhUeG9NREN0UTNZQm1HS2djcmJuNmp4eVFDanNLRk1R?=
 =?utf-8?B?ZysvZWdvVGlrbElDdTIrNk9UcUhwS3lRdGdWbCtmS0ViQ05hMmwwSmM2TGpv?=
 =?utf-8?B?ZmQ4OUNIWU4zUWZpVWUrSUpDU2FRL2wyeGhnUFcxZTRUbmR4THkvdmozSng2?=
 =?utf-8?B?elNoYWNTT1VMVmMzbXMyc3NkeGo1YnNyYjFFZUh5YnVjNXR2c1Z0UzVFTitS?=
 =?utf-8?B?NGVieHF0SWFzdHNXM3pVR0U0RHJWSXVRQ3E5TVE5WmR1dWFYVjgyUEcxcStO?=
 =?utf-8?B?cTlGUCtLdVRwNENCNFNuSEVRQ2Jtak9NMHN6RFkwY0lMazdvUm1QbmJ5U2dT?=
 =?utf-8?B?QlhXNW83KzJsWjJsMXZsaWtZSUIzZzJ6YlZBNW1HS01OQitVTXFBaVpWUUVm?=
 =?utf-8?B?d01RN1JXd2RmZEp6cmU0eDdKYU5SMWhaQUdSTlc3R01VZmxxdlVLZjRwZnJE?=
 =?utf-8?B?akx5QVp5REl1bWZ3M0ZHb2VwRk1NQ3JkbDVIVVR0WXZ6NEFZY3VHd3U3Tm5z?=
 =?utf-8?B?bms0cVM0UGo0Znp4T1VrQzgxanRMMHdGbS9PTlNaQmVpZDd4cVZaUGNFWGZJ?=
 =?utf-8?B?cVM2NFFkYjVmNk8xYUQ1bDBMWWI4Z0tHQjQxRktUaHRrYjdiMi8rWjY3NVN1?=
 =?utf-8?B?YnE2aTZUN2xUZUZtZXVGbjZVU3kzQVV1c0pyNW93TUFzYkVQN3prVUxmc3lh?=
 =?utf-8?B?SVFNMjRCeWJHbU1Ob3QxTFAxaGFaVklobFU4QjVra0o2WjNadVV1TWhQdVVU?=
 =?utf-8?B?ZmVTeTkxQTdHZHpiYU1nazZON21CV2VVNTVROXUyU1pkTmgwdGZSU3BjZlZu?=
 =?utf-8?B?RnRRcnMvNWR5QWdHVWhNUHd1VWt0ZGhrMkRMTDlWQWMwYU5NQWIweFNPK2tn?=
 =?utf-8?B?OFRua0xGemQ5OHVKanI1M3BBWHI0WTJtQ2xyMUVZMWxFVmVsRFhzdE9GUE9D?=
 =?utf-8?B?VHh5V1pxaGQ4dVpLdE4wbG00ZXI4ZnlxSUZWcXdaWmJwb2cxSU4wYTVUTU56?=
 =?utf-8?B?OTJJbzhQYTZsbGpHUmFvYXJnMDgzVlYwLzd1a3RkVVQzWHBXNGc4MDZKSGZQ?=
 =?utf-8?B?NVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7ECDACF2A49E9A43A886DBEFC95D9CAC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vPo7vjuEXlELnWPsDQ8jRQY2XowtdENoBMOKlVyDWR0YVH4k4bEJ1GgeUoWbXjqfibkzCcVExwrnI2KZ9F3TWVCtkos3GaOSiTtz5nLpG8rrezNqc8Ge8wBtqCFnPvVRv+FgElh/ZgYsym7hQggr0lrWlnfKUA+dA/XKfxeibQ9OPasCPYt0GgCs99hn/aPgo7YrHVG7lLq2bHlAsY6malAuqvcn3hip4zYfTzingRI2nMrXX0oqrEzpDdOWO07u52aHWZIeioKTc9zWKE8uFQ0hST96Jcz8LiJqZ5EwJE3j1uYxe9WW0w+zmUP76JFp48Dcv2BZ2OvBXO3M2/eGxkpJwgKajFlVXjbaFz8vWvQn/7L8heDGtlWXgc9TTUQcUYgYGogTcVK/K7JwrtKruZ9KjVQTG4SXaoFyow5lUeVru2VDQe7XAemGE4NY6Re+8SVz5e8w58JzyLrS8hGLIPVPTmIXLn+GsV9sBzCQBN/gQMosQQW/Av2RVHoyKuOnRKozXKWmLQcSgZkZO7l9sb8PVB3V1VXtrYwlkFZDOMRDV9iZXKoVQL8lLI6cPU3cg5K03M9o0hHbsHP2004utb3yjQqZcsbFq+kXxQdQdOJ/DnhbcDbq5oGHP3AWpIRPqZID1A2UqYVyXuG+1wFWAg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 665e93d6-839b-49e0-b7c6-08dd162c1012
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 19:27:45.9903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +toLLv3H7VsznGDD2x1wwLGTysZv5g+Vzcux8whYPxfbI/2sK8nYcCCrKFeM49+xeiXG81Zyxd7065cu38SOTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6118
X-Proofpoint-ORIG-GUID: J3V_rIrMlk6PfgKVkXJDI0_fr_qKIPK4
X-Authority-Analysis: v=2.4 cv=XaJzzJ55 c=1 sm=1 tr=0 ts=67535038 cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RZcAm9yDv7YA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=KKAkSRfTAAAA:8 a=x84T5iMjIhXYteUvMSsA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: J3V_rIrMlk6PfgKVkXJDI0_fr_qKIPK4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 mlxscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412060145

T24gRnJpLCBEZWMgMDYsIDIwMjQsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gT24gRnJpLCBEZWMg
MDYsIDIwMjQsIEFuZHLDqSBEcmFzemlrIHdyb3RlOg0KPiA+IEJlZm9yZSB3cml0aW5nIGEgbmV3
IHZhbHVlIHRvIHRoZSByZWdpc3RlciwgdGhlIG9sZCB2YWx1ZSBuZWVkcyB0byBiZQ0KPiA+IG1h
c2tlZCBvdXQgZm9yIHRoZSBuZXcgdmFsdWUgdG8gYmUgcHJvZ3JhbW1lZCBhcyBpbnRlbmRlZC4N
Cj4gPiANCj4gPiBBdCB0aGUgbW9tZW50LCB0aGUgZHdjMyBjb3JlIGluaXRpYWxpc2VzIHRoZSB0
aHJlc2hvbGQgdG8gdGhlIG1heGltdW0NCj4gPiB2YWx1ZSAoMHhmKSwgd2l0aCB0aGUgb3B0aW9u
IHRvIG92ZXJyaWRlIGl0IHZpYSBhIERULiBObyB1cHN0cmVhbSBEVHMNCj4gPiBzZWVtIHRvIG92
ZXJyaWRlIGl0LCB0aGVyZWZvcmUgdGhpcyBjb21taXQgZG9lc24ndCBjaGFuZ2UgYmVoYXZpb3Vy
IGZvcg0KPiA+IGFueSB1cHN0cmVhbSBwbGF0Zm9ybS4gTmV2ZXJ0aGVsZXNzLCB0aGUgY29kZSBz
aG91bGQgYmUgZml4ZWQgdG8gaGF2ZQ0KPiA+IHRoZSBkZXNpcmVkIG91dGNvbWUuDQo+ID4gDQo+
ID4gRG8gc28uDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQW5kcsOpIERyYXN6aWsgPGFuZHJl
LmRyYXN6aWtAbGluYXJvLm9yZz4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmggICB8IDEgKw0KPiA+ICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIHwgNCArKystDQo+ID4g
IDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oIGIvZHJpdmVycy91c2IvZHdj
My9jb3JlLmgNCj4gPiBpbmRleCBlZTczNzg5MzI2YmMuLjkzMzVmZDA5NTk2OCAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2R3
YzMvY29yZS5oDQo+ID4gQEAgLTQ2NSw2ICs0NjUsNyBAQA0KPiA+ICANCj4gPiAgLyogVGhlc2Ug
YXBwbHkgZm9yIGNvcmUgdmVyc2lvbnMgMS45NGEgYW5kIGxhdGVyICovDQo+ID4gICNkZWZpbmUg
RFdDM19EQ1RMX05ZRVRfVEhSRVMobikJCSgoKG4pICYgMHhmKSA8PCAyMCkNCj4gPiArI2RlZmlu
ZSBEV0MzX0RDVExfTllFVF9USFJFU19NQVNLCURXQzNfRENUTF9OWUVUX1RIUkVTKDB4ZikNCj4g
DQo+IElmIHlvdSdyZSBnb2luZyB0byBkZWZpbmUgYSBtYXNrIG1hY3JvIHRoaXMgd2F5LCBkbyB0
aGlzOg0KPiBEV0MzX0RDVExfTllFVF9USFJFUyh+MCkNCj4gDQoNCkFjdHVhbGx5LCBsZXQncyBr
ZWVwIGl0IGNvbnNpc3RlbnQgYXMgaG93IHRoZSBvdGhlciBtYXNrcyBhcmUgZGVmaW5lZCwNCmRv
bid0IHVzZSBEV0MzX0RDVExfTllFVF9USFJFUyhuKSB0byBkZWZpbmUgdGhlIG1hc2suDQoNClVz
ZSBHRU5NQVNLIG9yIGRvIHNvbWV0aGluZyBsaWtlIHRoaXM6DQojZGVmaW5lIERXQzNfRENUTF9O
WUVUX1RIUkVTX01BU0sJKDB4ZiA8PCAyMCkNCg0KQlIsDQpUaGluaA==

