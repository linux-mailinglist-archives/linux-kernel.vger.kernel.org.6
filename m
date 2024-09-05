Return-Path: <linux-kernel+bounces-317964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC7196E629
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 01:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4418C28455D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 23:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECBC1B5313;
	Thu,  5 Sep 2024 23:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gPosRaKQ";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="IB4Y92tS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="rtncR4bC"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B81018EFF8;
	Thu,  5 Sep 2024 23:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725578630; cv=fail; b=eAkD6F/5+rJ+Dex8KD0H+rlCioi3tDESaXJ6zYyN3LpqRX+WZlqDSsoPIeQcuzTZ6vznCtPHFIH0SSXaVssDRS64AeUbJhxx88eHMW0bIeiBSmJsEV4zx282BKS2PqRctp4+ZXCIMYlhPeqLNP5UpH0w33/XCZch4LjX8aGZ1D0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725578630; c=relaxed/simple;
	bh=ueURUhhcGPsFKTsFA+lL+vPVhYjEtbLL0e5IAFwU9nw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PlR/nxuJ0obqrPgndqt9pwpQ69kwrQkOFwkeBf9vasJlGbLNSrETh1bjQXk6h7/zZQlaGc4wjuEzcyqrDm7R77ANrV7o33FNsr9vO828amGYKhudHw5187WzJ0j1C+fhQ/2bTaj0PgPAaFlYk0BerTZQIybnOYZha00THWUTaJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=gPosRaKQ; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=IB4Y92tS; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=rtncR4bC reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485KqCuN014871;
	Thu, 5 Sep 2024 16:18:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=ueURUhhcGPsFKTsFA+lL+vPVhYjEtbLL0e5IAFwU9nw=; b=
	gPosRaKQ504FU0l2DIl0aLtfHpnp+i7pJdYpBHB7s3dO37y4YKifM/zqe5/Ki3O6
	WBuzJNRR13RsP+alwdgOnDLGwyNyz54i9XYa4m6IRfEAzd7/vG+F0fBPTdtTNyDk
	/uZCizITLyIn5TlXhGh0MPzeq3xk8+pH45rbaZA+5WYf5/pTF5NrSA+lpdEUmmyx
	T8r8KiHp7ZT3Ay2wnVs9RcyBbKAcu/iL9fgQw47qdeuMh7L7/u5WWOMna+LY848R
	UJE1bUHcFawgC7D9hcZqTEfFSycygXpDF1wBA4w56vdLBFBonIvo3ouwJv4VJxyD
	fxMFuKNKWnnPnCD+o0y+Zg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 41fhxm14cf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 16:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1725578314; bh=ueURUhhcGPsFKTsFA+lL+vPVhYjEtbLL0e5IAFwU9nw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=IB4Y92tSrdNbKktVAfriciqqfgqG4Z0BTNB6Qy4pelrUcofLPrS56qmuAHuTKdDtz
	 uyl84UOG3ZpWDe2WnZxefBTufUlgJMEbB8Qp4EiG0bhiXFGM2LEt4ToCaFNPcJUc/Q
	 FwGZR8MfB5iFP+rMMy5vDVTwT9dYeq2VnyOGPXbTqe5Vxez2m0s6JaY6oQ+iUnkpfo
	 Iicy7jnyHigYJGKVCFEizC0qxu9lcumabjf2l2w7LdWSzCF/l0Wb0EURsrMELr587b
	 t6vr7gf9jeTPMOAYauI6+Z5MAIWDeVI2vSlCcZWIMw3IdJaQR9ObQgHZmt1cLKVL3j
	 xcMnAmzX9nuHQ==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E63BE40346;
	Thu,  5 Sep 2024 23:18:33 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id A3E45A006D;
	Thu,  5 Sep 2024 23:18:33 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=rtncR4bC;
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6419B404D0;
	Thu,  5 Sep 2024 23:18:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFaR365JYnAl8aOWZvqxYOnH9nQzz1FFq79/pTiPhqQbApD7DJ5w9vjrG3cU23DDNlQvTErxpzpTzUcF918gX/00wfXdq9O/0zUNgnu4i69w4lbUlcGLJ/7ehmib3sLoyhBx53NYT3oM8zHoUmdPFlVJxKHZZ87XOa/7U3NTpMeSSCRmGH4Cp2Ch/hfKz/BQZy9KLfAQQDXGW/Jm1KMQdTbyG/PYuQTQpDepScLKyjMaJ8/lxUKt9JQfMugMtNTpItAU4S93lXpd3kHzG3cJu67xCWfu/LcHpPfMuqniUdDC339ddnOLgvHCrrU2hBrDjl3wJEhxWBuPjSMToftxuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ueURUhhcGPsFKTsFA+lL+vPVhYjEtbLL0e5IAFwU9nw=;
 b=zMzMHlk56ZQ4oYhaIianuQAd45dhAmowvY3Xjb1MnjrVvPqiIDaZ1fKabkCuvvat9PMiMroTKxieWRERfh4PLWZH4FnplxfAWuo4aeMlLL7CG2dWu9N0V7nKZrSGFYg7vc5Y6Z7cfooJ7MJI6AP6Hi1t6lXpjreJlaGe9lbqX8i0HWOX1yEuJ5ZR+JPFamdWKP4PIovwglLgycwgsLCb/HnbGVxrKKhg5+vDcacD2fS0Mu87dyJA74lswPKNb/ekcO4wq8Kdppk4YZRWcRszdXhvl+KPAYGD+zRKTkU57RDQZl+zsMgJUb6sENOPt0NeFVWbv6kMPbYkltAGSBOq1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueURUhhcGPsFKTsFA+lL+vPVhYjEtbLL0e5IAFwU9nw=;
 b=rtncR4bCUKF1J06BZclvrVIaszF/XxmnOHChGgWZC/QQuAkGIVO9nYeECRb6flBJpOuKJsZi58GEuO2nKijv6izI3INrjWyvic3MMEhauPg1ug3d79W2SlIdFkO1NSSojyVKC6Rx5YG8v8ztwV37XbpUGuVvxVFIxdtBtggrxsw=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH7PR12MB9202.namprd12.prod.outlook.com (2603:10b6:510:2ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 23:18:28 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 23:18:27 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jh0801.jung@samsung.com" <jh0801.jung@samsung.com>,
        "dh10.jung@samsung.com" <dh10.jung@samsung.com>,
        "naushad@samsung.com" <naushad@samsung.com>,
        "akash.m5@samsung.com" <akash.m5@samsung.com>,
        "rc93.raju@samsung.com" <rc93.raju@samsung.com>,
        "taehyun.cho@samsung.com" <taehyun.cho@samsung.com>,
        "hongpooh.kim@samsung.com" <hongpooh.kim@samsung.com>,
        "eomji.oh@samsung.com" <eomji.oh@samsung.com>,
        "shijie.cai@samsung.com" <shijie.cai@samsung.com>
Subject: Re: [PATCH] usb: dwc3: Potential fix of possible dwc3 interrupt storm
Thread-Topic: [PATCH] usb: dwc3: Potential fix of possible dwc3 interrupt
 storm
Thread-Index:
 AQHa2cstTT8AcV9+kEe9fm+4hVNVnLIbEIwAgABflQCAAT06AIAAVgGAgAK0ooCAIEFKAIAA0sIAgAPWhwCAAnZSAIAA99mAgACQGICAANfzAIAAhJUAgAAfSwCAAAOTgA==
Date: Thu, 5 Sep 2024 23:18:27 +0000
Message-ID: <20240905231825.6r2sp2bapxidur7a@synopsys.com>
References: <b273201d-c589-4c57-9d57-ad2affaeade0@samsung.com>
 <20240831005046.5lndwdr7cfm3k3to@synopsys.com>
 <2e678109-8399-48d5-9567-033eab910bca@samsung.com>
 <20240904010322.leqt3pap6lguivg4@synopsys.com>
 <11535d95-c972-4dbe-afb5-de3a44bc4a21@samsung.com>
 <CGME20240905002630epcas5p4532c1e66864e39990376b696aa1f53d7@epcas5p4.samsung.com>
 <20240905002611.rxlv66zsker2h5w2@synopsys.com>
 <d5552437-119c-4a0f-9d71-6959727b6364@samsung.com>
 <20240905211338.omst6jr3okbxkqdh@synopsys.com>
 <f9561f03-5f83-4270-b7f3-17b880cfabfe@samsung.com>
In-Reply-To: <f9561f03-5f83-4270-b7f3-17b880cfabfe@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH7PR12MB9202:EE_
x-ms-office365-filtering-correlation-id: 4f623cd1-60c2-42f9-9b13-08dcce010c1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NlhoMmJuVmhZM3orbkNGUXAzZ0cwZXpwYzA0UXpBdzgrM1RCRCtjZHpTMW9I?=
 =?utf-8?B?WnFsT2t1SVVZZExKZXJ3L0hNbjBzdDNYMjNYMVFlc0s5ODRhY0grOXZZUFJv?=
 =?utf-8?B?OC80K2lsOEtiTGRoYkNYakpaR29CNzZzTnNod3B3U2hLQnBsZG9iYTdvMnFh?=
 =?utf-8?B?c3pzQldGK1BuVS9QNTVSR0tIY0tGUEtmVmlUcm4yYWZNTXBLell2S0QwNmpx?=
 =?utf-8?B?SjhSTW0xMXk3L1FWVjRDVEVjSXlORWI0cStaUWJCczN5bmdhTTZSNkZXZ0NB?=
 =?utf-8?B?dUhaZW9zMmRCelhUWVRENFJ1cTFXR0hrWTVBWmZNekpGVEdRU3ZvaVdRcUZC?=
 =?utf-8?B?VEUzTUJjOHEraFZDTGllSGpQcVZocG9rbHVlNWs5VWtCeTVrRURDelNnVkgy?=
 =?utf-8?B?eVNqTkl5a0VuWkJCM0xxQytUQnlDZzlYQzdnV0dJM0xNbW4rVlBZZlF2ZjIy?=
 =?utf-8?B?djRPTG9YQXljRkFvNm5Ka21oY1ZsendWVTBHYVZBN0I3YWlUZWpBSDJrbWtn?=
 =?utf-8?B?NGxhK2paMjFWRHdKdzh0Q292UUJESFc0MUR3blI2aEdxR0kwQW9wbUZPSmtr?=
 =?utf-8?B?b2o0Q05QckYxdHBxSTlDN013UlhacjlHK1Y3UzRwM2x3ZWw3V2RHTzBsOERB?=
 =?utf-8?B?eWVOaVlVOU5Tclp0eFluam80RXVDZHdnQSt3THVxbDVYU0NWVS81bzJKQ2l4?=
 =?utf-8?B?NmkrTVJnc2VxVVczSitLSWZaa2F1VU9mYzc5M01BNHBSQittTWNsZkxUVGVF?=
 =?utf-8?B?anFFUFpuY3VFUm94M0pLYnB2ek1UVjNUM0VmUHNMbUhxWTJmWm1QSEJWR2Fk?=
 =?utf-8?B?NlBHNGFESWRFVG9sZDEvTS9qYXF5WjFka3YwUXFaeVk0RUFpbG81Wlh3SUdS?=
 =?utf-8?B?SXoxQitJbit4RkY1WXJFeDliS3k5NlZ0UzJ0c1hMdHByM2hwZ2h5UHYzdW0r?=
 =?utf-8?B?OTk3V1F5enFLNzdvMjVYL3ExWEt0N21uc2tsSG5OTDRRWGhkYjJJeFNNTG55?=
 =?utf-8?B?cjdMUDB0NlhmWG5NOVRjcEk0d3Z5QTEyYjhRSkR4UmJiZXlWMDB4UTJhQUFI?=
 =?utf-8?B?cUpvZDg2WTBQbnZGcDZ1UDRQWVp4WTlhM3FqK3ZIYjREMGVMY0U0dWNiZFdC?=
 =?utf-8?B?Y1A3cU1MaGFONk9FV0llZTAyQUxqV3NPL09pNjhZZlJaYnJERG9EeDVNYkRk?=
 =?utf-8?B?VDVmNzRtVjNTOWpxOXpQVHVobnNQLzVrQVpYNDhrZzNzTW1nSllGYWdWcWox?=
 =?utf-8?B?TmhtekJ6V3lqbk51eHlub2EzcHVCNlphdTFxakdsUlk3cmFabURJSHZUc2hH?=
 =?utf-8?B?VFdVc3ZpQzF3RG9VOGp6bXdTTkRTQmEzQ2d2d0hhT05JUlE1UHhyNFlJTW5V?=
 =?utf-8?B?TmhHUTJPQXZ0SlA2Uy9WMjhudEUycTdMbyt0UTgwN1JFWWtGT0h6T1dlakRw?=
 =?utf-8?B?Y2tXd2x3eG1hOEVhbWlTOUI0Qm1YRVA5ZEpteG1ad0I3Z3V0QkIzLzkzNUR6?=
 =?utf-8?B?NG84ZmprSmdZaW0xZ1hYQ3Q0bDVWb1Yxc1BkZzBqZlhnME9uMnc3eVVKdnpJ?=
 =?utf-8?B?anRjbWhzUzRJcm4yUWI0ZzFDY2thRUdDMUJaN0FiNjdqRkVyOVUrZFRMTnVa?=
 =?utf-8?B?NU5rSUxvZUJWbnV4NGZjMXlMUDM0UllPM0tROGxaUmRHc3Z2c2N5dWY5S1R1?=
 =?utf-8?B?cHRpNmhOUmkrWElVUWNQSHYzYVM3eEZ3QXNMdGNDZmVuVEU3cm1Dc0ZTRGhx?=
 =?utf-8?B?Mk1GV0djNkdRYUpyZmxEZXJzRk1NZ2I5MzcrbGI4NlJ0d3RONVZRdnFJbWF4?=
 =?utf-8?B?dFJqdURFR0dYRHdwbGcvb202TjZCYmlNbU9PaWZ1czlFeWsyaGpwbUdTLzl4?=
 =?utf-8?B?SWphdUVjWjFNWUVsMUsvZkszM25TSHdGRUtCNTFmZ1VzNkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MEtvYlBtVHJEWjBjNi9VNXBJWlVnVE5GdGJZWVBOQ2NBMm8zQzNiSnprbTVO?=
 =?utf-8?B?T2xiQytUUVBCRHR1b1oyVnBIelpaK3VkdWlxL0FUcDJpYXFEVTZqUXI1WXAr?=
 =?utf-8?B?Mzg4V2R0ajA5NURudWFMUE4xekk1RURWN2VLS1pWRXdPZXZENlFHMisvVXgr?=
 =?utf-8?B?YmpzT1hqRjBmUFdYRmxDUFdLOEtUMVBpcHhhOTZYTkhsVGZBVFdFZ0tBZUtX?=
 =?utf-8?B?TURYWDl1VXBMV1l3RmpUU2d2aVUwZEs1RGJTL2dlK0pnVStDYnVyQzQ3QjVh?=
 =?utf-8?B?NUJSVjBSUlhscXhGS1JsNktBL05VOHNhbHdBTlBIUCs1dHBMN2ltR1FGWkdo?=
 =?utf-8?B?WjRKVUFidGFwUGpPQnd0YUdoWU1KZ09XeGQzNFBQamlaWkdncnViOEhoK3JD?=
 =?utf-8?B?bG4xNEhiZlpVZ3RYYjhXWjVoYTJBTzBNV05CaG5GMjA0dXB4bC82Z0k0Ty9Q?=
 =?utf-8?B?c0k3dVdlbTY0R016MXhwM2ZkdkJvL01YTCtpYkdMQkhnY2sweCttUlhPRWV2?=
 =?utf-8?B?K2xxQkh6bU9IaFBpV1MrR1A5bjVWcUd2QkJ0SUVJendKbnkrbVc1MGUwalVo?=
 =?utf-8?B?bndPL1VqSTFuNDBuSktRdUozYjhBeUgxNnRzeHdnN0s3V1JtSjBETFVVUXpa?=
 =?utf-8?B?clJSRllDdTF3d00zSGo4YUt1b1g3K3dWUk9zMXVSU3VhdVExSlVaYW1xSGV1?=
 =?utf-8?B?RUJZZFgrdHIvUmVESVRtTjN4L2h1VllnTVFRVUNwNlRiNnVIOFhvSzU0bmZ4?=
 =?utf-8?B?VFBWbE45ZGVXZDBGRGtUalkyOTRMSG9CcHlZTUVEbFZPc2ZDSFFrblEwSFZI?=
 =?utf-8?B?cjhacFNIYjF5ck5GclNQVkhSdHdPbzE5djZmK2R5clg2T0JUa1NzTUFpUGNN?=
 =?utf-8?B?cVlkajBwdnJxT3NCc2R4ZjNXWlFKVy9BVFkvVyt3bVlhMmpRajBac3doMngr?=
 =?utf-8?B?Q2gvdlJhODlaMk5MM2llVE53ak5PUWk2b0Z4QjVBc280Z1Z4YlFtL2VlMU52?=
 =?utf-8?B?V3pJVUViZWFGOVdJYmJwMFpIellUNEVpbUlEb2NKTVUyWnlDRVQ1MEpHc0RL?=
 =?utf-8?B?OS96T0FzYVRZMUZYVk1NR2pPSG0yWVRuaE1xenZ3Y05tRzdqQmplRGJWU3Fp?=
 =?utf-8?B?NCtJQW5YYzBOWEk1RVp1ZFBWRGtPeVZzYlZUc0pGUHk5aVk0cmhSQit1UmJp?=
 =?utf-8?B?V0lCUXZLeiswZEJCSWMrSHFQRTBNdzY0YzBhUFgrUUE5VWllT0p4eHgyMXhN?=
 =?utf-8?B?cWhLcGRVV25rV2lodEo2VnZSN2dCWkNaRDZ6NTlPaHpRS0NIamYzNDF1VUNp?=
 =?utf-8?B?VDZxbjZnSXM0WHQ4NldyRjIwNWJYWDY5d0g5VGtCeDBUNjhSa29JQXJWTVg4?=
 =?utf-8?B?TXFBOC92eFE4UlZDcWlTVkdSM3NBYlYxMXJjVW9KZlNIVTFsNXgzYUptU0tJ?=
 =?utf-8?B?elF4TFdhZkhNVTZNendkS0l3MFdWaHZ3S0VUQkROYkpLRkNQQnpYeDBRNVdx?=
 =?utf-8?B?SjkydTFzZFhPYkU2N0FNdFdkanEyNWdDbXJYWDU3ZHRLV1Rka2FkL1A5OGpN?=
 =?utf-8?B?SElwT0JiOURwa3p3MFVKTHdZTVhMY0VtZ2dKZEYrYmpIVVFBVHMrSTEzNUcz?=
 =?utf-8?B?eG9USkF2K014dzFLbVFYOUpuSytEZ1FLRzF3andvVGFOcG1XTmNVRmc5VlJ2?=
 =?utf-8?B?bGpHa0FVdXpsSVZZQUx4eDNNaEYyWjdPUlhCcnBablkwb1dnSDA1dFF4VVNa?=
 =?utf-8?B?VHZYRFU1VHdUVkhkYlBWelF0Y3pxdEl3R2o5T2dOYzlDOFU2dnFHSkZ1bDdD?=
 =?utf-8?B?YjVCeFlWRFRGT0Z6dzZlMlRVNDRRSXBWSUszclVISjNBckFPOEFkTEt3UVly?=
 =?utf-8?B?eksyMWFGb3JIeUZza2lVRVkxSGNhUy9hTkE4WE5YWVhLeE9RS1E4UURtU0tR?=
 =?utf-8?B?d3hOcnZhWTc2d1lQMys0YlA2YzUyREhLQUVjM0pUQWNaV1FEQS8zdk1UelZX?=
 =?utf-8?B?TU8vVTRPblUxQVBROEtYVWd6RThzQ2pHZWw2YWhHTytDL0pFTWw4SEoyUy91?=
 =?utf-8?B?ZHlhaTBTeTV1K052NDBsdjF6ekhIMmlRamVRL1VQSEVJRHZBR0tqNWU3dEgv?=
 =?utf-8?Q?U4AleW5sMvfExsuFPgF4hGkHr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DE9912E8CEE40479D39992F1ACB9127@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vESgkescG7PwcDh9s7G4bBSyE2Z0OjGSGSp/6sLRgPpaQUXX6HEYcuHjm70N4lOV0DvY8cx+/mB3jqOMvSDYtDO58wtI60EnAhRQGBEYgIumfIicdHkX6KrevMqaC95N1b46GitJMFxxLanFlaSUJWW9S4/ahV4iGnTHZtfqapXbie9oRT4kIEM0bdtPnva5QT/caKv3f6S7yw7T2HKnqdxAEPt2y9i88Z9cKfgzTqHBMqXJhW/SkaPcRsOk0rhRIbEw/sdZSeT1vsumcbgdC1lSXmaGPQ4eiCUA7l2dyjGekm4uW/tKOmCA/Hzqj5rtx0TVlqomi4hdKR4tKs+7m/kJ4U29f5alZM/wm71+BoskGhEtEB2lP9CoE9I8S5epiLsfcbnIsD3nYQEaGS54dQT9NjmdIgvpL5WG7/HOyBgV0hDVCe6KqVc1bU5DIxVVEMpllWYnRLX1piLb45j+HKXFtHrvd2F0TNUD18oq+fig2jFF3q6k/7iMCMGu138gYRu2LiyiXHeEYvKiEOtqydOYkGD1E9TubcieNFDHdBtkKf71wCnrhGcWma/GdWNhDvHPEkrNhnRhL6NPE/M+yIsgMFj2yD0pzTBILzrrsde03RipU7Xy0enQKOC4W4vARh7t224CQWlPlJvHF/mdIg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f623cd1-60c2-42f9-9b13-08dcce010c1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 23:18:27.2600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TDSaJXGo3WBzs+7JUcMhJKxE7rZSRPapP29r4nUYWRh+wk25XO62uQ1c6t+dClDAtfcXY8EiJuDAMXSV4Ka3SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9202
X-Authority-Analysis: v=2.4 cv=YNLNygGx c=1 sm=1 tr=0 ts=66da3c4a cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=jIQo8A4GAAAA:8 a=-XlUPvmpwwli6aVWCZMA:9 a=QEXdDO2ut3YA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-GUID: 1ZsyAbugTRBBnW6_nSX-CsaFTDz6b5wj
X-Proofpoint-ORIG-GUID: 1ZsyAbugTRBBnW6_nSX-CsaFTDz6b5wj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_17,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 impostorscore=0 mlxscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 malwarescore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409050175

T24gRnJpLCBTZXAgMDYsIDIwMjQsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiANCj4gT24g
OS82LzIwMjQgMjo0MyBBTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9uIFRodSwgU2VwIDA1
LCAyMDI0LCBTZWx2YXJhc3UgR2FuZXNhbiB3cm90ZToNCj4gPj4gT24gOS81LzIwMjQgNTo1NiBB
TSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+Pj4gT24gV2VkLCBTZXAgMDQsIDIwMjQsIFNlbHZh
cmFzdSBHYW5lc2FuIHdyb3RlOg0KPiA+Pj4+IE9uIDkvNC8yMDI0IDY6MzMgQU0sIFRoaW5oIE5n
dXllbiB3cm90ZToNCj4gPj4+Pj4gT24gTW9uLCBTZXAgMDIsIDIwMjQsIFNlbHZhcmFzdSBHYW5l
c2FuIHdyb3RlOg0KPiA+Pj4+Pj4gSSB3b3VsZCBsaWtlIHRvIHJlY29uZmlybSBmcm9tIG91ciBl
bmQgdGhhdCBpbiBvdXIgZmFpbHVyZSBzY2VuYXJpbywgd2UNCj4gPj4+Pj4+IG9ic2VydmUgdGhh
dCBEV0MzX0VWRU5UX1BFTkRJTkcgaXMgc2V0IGluIGV2dC0+ZmxhZ3Mgd2hlbiB0aGUgZHdjMw0K
PiA+Pj4+Pj4gcmVzdW1lIHNlcXVlbmNlIGlzIGV4ZWN1dGVkLCBhbmQgdGhlIGR3Yy0+cGVuZGlu
Z19ldmVudHMgZmxhZyBpcyBub3QNCj4gPj4+Pj4+IGJlaW5nIHNldC4NCj4gPj4+Pj4+DQo+ID4+
Pj4+IElmIHRoZSBjb250cm9sbGVyIGlzIHN0b3BwZWQsIG5vIGV2ZW50IGlzIGdlbmVyYXRlZCB1
bnRpbCBpdCdzIHJlc3RhcnRlZA0KPiA+Pj4+PiBhZ2Fpbi4gKGllLCB5b3Ugc2hvdWxkIG5vdCBz
ZWUgR0VWTlRDT1VOVCB1cGRhdGVkIGFmdGVyIGNsZWFyaW5nDQo+ID4+Pj4+IERDVEwucnVuX3N0
b3ApLiBJZiB0aGVyZSdzIG5vIGV2ZW50LCBubyBpbnRlcnJ1cHQgYXNzZXJ0aW9uIHNob3VsZCBj
b21lDQo+ID4+Pj4+IGZyb20gdGhlIGNvbnRyb2xsZXIuDQo+ID4+Pj4+DQo+ID4+Pj4+IElmIHRo
ZSBwZW5kaW5nX2V2ZW50cyBpcyBub3Qgc2V0IGFuZCB5b3Ugc3RpbGwgc2VlIHRoaXMgZmFpbHVy
ZSwgdGhlbg0KPiA+Pj4+PiBsaWtlbHkgdGhhdCB0aGUgY29udHJvbGxlciBoYWQgc3RhcnRlZCwg
YW5kIHRoZSBpbnRlcnJ1cHQgaXMgZ2VuZXJhdGVkDQo+ID4+Pj4+IGZyb20gdGhlIGNvbnRyb2xs
ZXIgZXZlbnQuIFRoaXMgb2NjdXJzIGFsb25nIHdpdGggdGhlIGludGVycnVwdA0KPiA+Pj4+PiBn
ZW5lcmF0ZWQgZnJvbSB5b3VyIGNvbm5lY3Rpb24gbm90aWZpY2F0aW9uIGZyb20geW91ciBzZXR1
cC4NCj4gPj4+PiBJIGNvbXBsZXRlbHkgYWdyZWUuIE15IGRpc2N1c3Npb24gcmV2b2x2ZXMgYXJv
dW5kIHRoZSBoYW5kbGluZyBvZiB0aGUNCj4gPj4+PiBEV0MzX0VWRU5UX1BFTkRJTkcgZmxhZyBp
biBhbGwgc2l0dWF0aW9ucy4gVGhlIHB1cnBvc2Ugb2YgdXNpbmcgdGhpcw0KPiA+Pj4+IGZsYWcg
aXMgdG8gcHJldmVudCB0aGUgcHJvY2Vzc2luZyBvZiBuZXcgZXZlbnRzIGlmIGFuIGV4aXN0aW5n
IGV2ZW50IGlzDQo+ID4+Pj4gc3RpbGwgYmVpbmcgcHJvY2Vzc2VkLiBUaGlzIGZsYWcgaXMgc2V0
IGluIHRoZSB0b3AtaGFsZiBpbnRlcnJ1cHQNCj4gPj4+PiBoYW5kbGVyIGFuZCBjbGVhcmVkIGF0
IHRoZSBlbmQgb2YgdGhlIGJvdHRvbS1oYWxmIGhhbmRsZXIuDQo+ID4+Pj4NCj4gPj4+PiBOb3cs
IGxldCdzIGNvbnNpZGVyIHNjZW5hcmlvcyB3aGVyZSB0aGUgYm90dG9tIGhhbGYgaXMgbm90IHNj
aGVkdWxlZCwNCj4gPj4+PiBhbmQgYSBVU0IgcmVjb25uZWN0IG9jY3Vycy4gSW4gdGhpcyBjYXNl
LCB0aGVyZSBpcyBhIHBvc3NpYmlsaXR5IHRoYXQNCj4gPj4+PiB0aGUgaW50ZXJydXB0IGxpbmUg
aXMgdW5tYXNrZWQgaW4gZHdjM19ldmVudF9idWZmZXJzX3NldHVwLCBhbmQgdGhlIFVTQg0KPiA+
Pj4+IGNvbnRyb2xsZXIgYmVnaW5zIHBvc3RpbmcgbmV3IGV2ZW50cy4gVGhlIHRvcC1oYWxmIGlu
dGVycnVwdCBoYW5kbGVyDQo+ID4+Pj4gY2hlY2tzIGZvciB0aGUgRFdDM19FVkVOVF9QRU5ESU5H
IGZsYWcgYW5kIHJldHVybnMgSVJRX0hBTkRMRUQgd2l0aG91dA0KPiA+Pj4+IHByb2Nlc3Npbmcg
YW55IG5ldyBldmVudHMuIEhvd2V2ZXIsIHRoZSBVU0IgY29udHJvbGxlciBjb250aW51ZXMgdG8g
cG9zdA0KPiA+Pj4+IGludGVycnVwdHMgdW50aWwgdGhleSBhcmUgYWNrbm93bGVkZ2VkLg0KPiA+
Pj4+DQo+ID4+Pj4gUGxlYXNlIHJldmlldyB0aGUgY29tcGxldGUgc2VxdWVuY2Ugb25jZSB3aXRo
IERXQzNfRVZFTlRfUEVORElORyBmbGFnLg0KPiA+Pj4+DQo+ID4+Pj4gTXkgcHJvcG9zYWwgaXMg
dG8gY2xlYXIgb3IgcmVzZXQgdGhlIERXQzNfRVZFTlRfUEVORElORyBmbGFnIHdoZW4NCj4gPj4+
PiB1bm1hc2tpbmcgdGhlIGludGVycnVwdCBsaW5lIGR3YzNfZXZlbnRfYnVmZmVyc19zZXR1cCwg
YXBhcnQgZnJvbQ0KPiA+Pj4+IGJvdHRvbS1oYWxmIGhhbmRsZXIuIENsZWFyaW5nIHRoZSBEV0Mz
X0VWRU5UX1BFTkRJTkcgZmxhZyBpbg0KPiA+Pj4+IGR3YzNfZXZlbnRfYnVmZmVyc19zZXR1cCBk
b2VzIG5vdCBjYXVzZSBhbnkgaGFybSwgYXMgd2UgaGF2ZSBpbXBsZW1lbnRlZA0KPiA+Pj4+IGEg
dGVtcG9yYXJ5IHdvcmthcm91bmQgaW4gb3VyIHRlc3Qgc2V0dXAgdG8gcHJldmVudCBJUlEgc3Rv
cm1zLg0KPiA+Pj4+DQo+ID4+Pj4NCj4gPj4+Pg0KPiA+Pj4+IFdvcmtpbmcgc2NlbmFyaW9zOg0K
PiA+Pj4+ID09PT09PT09PT09PT09PT09PQ0KPiA+Pj4+IDEuIFRvcC1oYWxmIGhhbmRsZXI6DQo+
ID4+Pj4gICAgwqDCoMKgIGEuIGlmIChldnQtPmZsYWdzICYgRFdDM19FVkVOVF9QRU5ESU5HKQ0K
PiA+Pj4+ICAgIMKgwqDCoMKgwqDCoMKgIHJldHVybiBJUlFfSEFORExFRDsNCj4gPj4+PiAgICDC
oMKgwqAgYi4gU2V0IERXQzNfRVZFTlRfUEVORElORyBmbGFnDQo+ID4+Pj4gICAgwqDCoMKgIGMu
IE1hc2tpbmcgaW50ZXJydXB0IGxpbmUNCj4gPj4+Pg0KPiA+Pj4+IDIuIEJvdHRvbS1oYWxmIGhh
bmRsZXI6DQo+ID4+Pj4gICAgwqDCoMKgIGEuIFVuLW1hc2tpbmcgaW50ZXJydXB0IGxpbmUNCj4g
Pj4+PiAgICDCoMKgwqAgYi4gQ2xlYXIgRFdDM19FVkVOVF9QRU5ESU5HIGZsYWcNCj4gPj4+Pg0K
PiA+Pj4+IEZhaWx1cmUgc2NlbmFyaW9zOg0KPiA+Pj4+ID09PT09PT09PT09PT09PT09PQ0KPiA+
Pj4+IDEuIFRvcC1oYWxmIGhhbmRsZXI6DQo+ID4+Pj4gICAgwqDCoMKgIGEuIGlmIChldnQtPmZs
YWdzICYgRFdDM19FVkVOVF9QRU5ESU5HKQ0KPiA+Pj4+ICAgIMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCByZXR1cm4gSVJRX0hBTkRMRUQ7DQo+ID4+Pj4gICAgwqDCoMKgIGIuIFNldCBE
V0MzX0VWRU5UX1BFTkRJTkcgZmxhZw0KPiA+Pj4+ICAgIMKgwqDCoCBjLiBNYXNraW5nIGludGVy
cnVwdCBsaW5lDQo+ID4+PiBGb3IgRFdDM19FVkVOVF9QRU5ESU5HIGZsYWcgdG8gYmUgc2V0IGF0
IHRoaXMgcG9pbnQgKGJlZm9yZSB3ZSBzdGFydCB0aGUNCj4gPj4+IGNvbnRyb2xsZXIpLCB0aGF0
IG1lYW5zIHRoYXQgdGhlIEdFVk5UQ09VTlQgd2FzIG5vdCAwIGFmdGVyDQo+ID4+PiBzb2Z0LWRp
c2Nvbm5lY3QgYW5kIHRoYXQgdGhlIHBtX3J1bnRpbWVfc3VzcGVuZGVkKCkgbXVzdCBiZSBmYWxz
ZS4NCj4gPj4gSW4gdGhlIHRvcC1oYWxmIGNvZGUgd2hlcmUgd2Ugc2V0IHRoZSBEV0MzX0VWRU5U
X1BFTkRJTkcgZmxhZywgd2UNCj4gPj4gYWNrbm93bGVkZ2UgR0VWTlRDT1VOVC4gVGhlcmVmb3Jl
LCBJIHRoaW5rIGl0IGlzIG5vdCBuZWNlc3NhcnkgZm9yDQo+ID4+IEdFVk5UQ09VTlQgdG8gaGF2
ZSBhIG5vbi16ZXJvIHZhbHVlIHVudGlsIGEgbmV3IGV2ZW50IG9jY3Vycy4gSW4gZmFjdCwNCj4g
Pj4gd2hlbiB3ZSB0cmllZCB0byBwcmludCBHRVZOVENPVU5UIGluIGEgbm9uLWludGVycnVwdCBj
b250ZXh0LCB3ZSBmb3VuZA0KPiA+PiB0aGF0IGl0IHdhcyB6ZXJvLCB3aGVyZSB3ZSByZWNlaXZl
ZCBEV0MzX0VWRU5UX1BFTkRJTkcgYmVpbmcgc2V0IGluDQo+ID4+IG5vbi1pbnRlcnJ1cHQgY29u
dGV4dC4NCj4gPiBGb3IgRFdDM19FVkVOVF9QRU5ESU5HIHRvIGJlIHNldCwgR0VWTlRDT1VOVCBt
dXN0IGJlIG5vbi16ZXJvLiBJZiB5b3UNCj4gPiBzZWUgaXQncyB6ZXJvLCB0aGF0IG1lYW5zIHRo
YXQgaXQgd2FzIGFscmVhZHkgZGVjcmVtZW50ZWQgYnkgdGhlIGRyaXZlci4NCj4gPg0KPiA+IElm
IHRoZSBkcml2ZXIgYWNrbm93bGVkZ2VzIHRoZSBHRVZOVENPVU5ULCB0aGVuIHRoYXQgbWVhbnMg
dGhhdCB0aGUNCj4gPiBldmVudHMgYXJlIGNvcGllZCBhbmQgcHJlcGFyZWQgdG8gYmUgcHJvY2Vz
c2VkLiBUaGUgYm90dG9tLWhhbGYgdGhyZWFkDQo+ID4gaXMgc2NoZWR1bGVkLiBJZiBpdCdzIGZv
ciBzdGFsZSBldmVudCwgSSBkb24ndCB3YW50IGl0IHRvIGJlIHByb2Nlc3NlZC4NCj4gPg0KPiA+
Pj4+IDIuIE5vIEJvdHRvbS1oYWxmIHNjaGVkdWxlZDoNCj4gPj4+IFdoeSBpcyB0aGUgYm90dG9t
LWhhbGYgbm90IHNjaGVkdWxlZD8gT3IgZG8geW91IG1lYW4gaXQgaGFzbid0IHdva2VuIHVwDQo+
ID4+PiB5ZXQgYmVmb3JlIHRoZSBuZXh0IHRvcC1oYWxmIGNvbWluZz8NCj4gPj4gSW7CoHZlcnkg
cmFyZSBjYXNlcywgaXQgaXMgcG9zc2libGUgaW4gb3VyIHBsYXRmb3JtIHRoYXQgdGhlIENQVSBt
YXkgbm90DQo+ID4+IGJlIGFibGUgdG8gc2NoZWR1bGUgdGhlIGJvdHRvbSBoYWxmIG9mIHRoZSBk
d2MzIGludGVycnVwdCBiZWNhdXNlIGEgd29yaw0KPiA+PiBxdWV1ZSBsb2NrdXAgaGFzIG9jY3Vy
cmVkIG9uIHRoZSBzYW1lIENQVSB0aGF0IGlzIGF0dGVtcHRpbmcgdG8gc2NoZWR1bGUNCj4gPj4g
dGhlIGR3YzMgdGhyZWFkIGludGVycnVwdC4gSW4gdGhpcyBjYXNlIFllcywgdGhlIGJvdHRvbS1o
YWxmIGhhbmRsZXINCj4gPj4gaGFzbid0IHdva2VuIHVwLCB0aGVuIGluaXRpYXRlIGFuIElSUSBz
dG9ybSBmb3IgbmV3IGV2ZW50cyBhZnRlciB0aGUNCj4gPj4gY29udHJvbGxlciByZXN0YXJ0cywg
cmVzdWx0aW5nIGluIG5vIG1vcmUgYm90dG9tLWhhbGYgc2NoZWR1bGluZyBkdWUgdG8NCj4gPj4g
dGhlIENQVSBiZWluZyBzdHVjayBpbiBwcm9jZXNzaW5nIGNvbnRpbnVvdXMgaW50ZXJydXB0cyBh
bmQgcmV0dXJuDQo+ID4+IElSUV9IQU5ETEVEIGJ5IGNoZWNraW5nIGlmIChldnQtPmZsYWdzICYg
RFdDM19FVkVOVF9QRU5ESU5HKS4NCj4gPj4NCj4gPj4+PiAzLiBVU0IgcmVjb25uZWN0OiBkd2Mz
X2V2ZW50X2J1ZmZlcnNfc2V0dXANCj4gPj4+PiAgICDCoMKgwqAgYS4gVW4tbWFza2luZyBpbnRl
cnJ1cHQgbGluZQ0KPiA+Pj4gRG8gd2Uga25vdyB0aGF0IHRoZSBHRVZOVENPVU5UIGlzIG5vbi16
ZXJvIGJlZm9yZSBzdGFydGluZyB0aGUNCj4gPj4+IGNvbnRyb2xsZXIgYWdhaW4/DQo+ID4+IFRo
ZSBHRVZOVENPVU5UIHZhbHVlIHNob3dpbmcgYXMgemVybyB0aGF0IHdlIGNvbmZpcm1lZCBieSBh
ZGRpbmcgZGVidWcNCj4gPj4gbWVzc2FnZSBoZXJlLg0KPiA+Pj4+IDQuIENvbnRpbnVvdXMgaW50
ZXJydXB0cyA6IFRvcC1oYWxmIGhhbmRsZXI6DQo+ID4+Pj4gICAgwqDCoMKgIGEuIGlmIChldnQt
PmZsYWdzICYgRFdDM19FVkVOVF9QRU5ESU5HKQ0KPiA+Pj4+ICAgIMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm4gSVJRX0hBTkRMRUQ7DQo+ID4+Pj4NCj4gPj4+PiAgICDCoMKg
wqAgYS4gaWYgKGV2dC0+ZmxhZ3MgJiBEV0MzX0VWRU5UX1BFTkRJTkcpDQo+ID4+Pj4gICAgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBJUlFfSEFORExFRDsNCj4gPj4+Pg0K
PiA+Pj4+ICAgIMKgwqDCoCBhLiBpZiAoZXZ0LT5mbGFncyAmIERXQzNfRVZFTlRfUEVORElORykN
Cj4gPj4+PiAgICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIElSUV9IQU5E
TEVEOw0KPiA+Pj4+IC4uLi4uDQo+ID4+Pj4NCj4gPj4+PiAuLi4uLg0KPiA+Pj4+DQo+ID4+Pj4g
Li4uLi4NCj4gPj4+Pg0KPiA+PiBTdXJlLCBJIGNhbiB0cnkgaW1wbGVtZW50aW5nIHRoZSBwcm9w
b3NlZCBjb2RlIG1vZGlmaWNhdGlvbnMgaW4gb3VyDQo+ID4+IHRlc3RpbmcgZW52aXJvbm1lbnQu
DQo+ID4+DQo+ID4+IEJ1dCwgSSBhbSB1bmNlcnRhaW4gYWJvdXQgaG93IHRoZXNlIGNoYW5nZXMg
d2lsbCBlZmZlY3RpdmVseSBwcmV2ZW50IGFuDQo+ID4+IElSUSBzdG9ybSB3aGVuIHRoZSBVU0Ig
Y29udHJvbGxlciBzZXF1ZW5jZSByZXN0YXJ0cyB3aXRoIHRoZQ0KPiA+PiBEV0MzX0VWRU5UX1BF
TkRJTkcuIFRoZSBmb2xsb3dpbmcgY29kZSB3aWxsIG9ubHkgZXhlY3V0ZSB1bnRpbCB0aGUNCj4g
Pj4gRFdDM19FVkVOVF9QRU5ESU5HIGlzIGNsZWFyZWQsIGF0IHdoaWNoIHBvaW50IHRoZSBwcmV2
aW91cyBib3R0b20taGFsZg0KPiA+PiB3aWxsIG5vdCBiZSBzY2hlZHVsZWQuDQo+ID4+DQo+ID4+
IFBsZWFzZSBjb3JyZWN0IG1lIGlmIGkgYW0gd3JvbmcgaW4gbXkgYWJvdmUgdW5kZXJzdGFuZGlu
Zy4NCj4gPiBBcyBJIG1lbnRpb25lZCwgSSBkb24ndCB3YW50IERXQzNfRVZFTlRfUEVORElORyBm
bGFnIHRvIGJlIHNldCBkdWUgdG8NCj4gPiB0aGUgc3RhbGUgZXZlbnQuIEkgd2FudCB0byBpZ25v
cmUgYW5kIHNraXAgcHJvY2Vzc2luZyBhbnkgc3RhbGUgZXZlbnQuDQo+ID4NCj4gPiBUaGUgRFdD
M19FVkVOVF9QRU5ESU5HIHNob3VsZCBub3QgYmUgc2V0IGJ5IHRoZSB0aW1lDQo+ID4gZHdjM19l
dmVudF9idWZmZXJzX3NldHVwKCkgaXMgY2FsbGVkLg0KPiA+DQo+ID4gU3BlY2lmaWNhbGx5IHJl
dmlldyB0aGlzIGNvbmRpdGlvbiBpbiBteSB0ZXN0aW5nIHBhdGNoOg0KPiA+DQo+ID4gCS8qDQo+
ID4gCSAqIElmIHRoZSBjb250cm9sbGVyIGlzIGhhbHRlZCwgdGhlIGV2ZW50IGNvdW50IGlzIHN0
YWxlL2ludmFsaWQuIElnbm9yZQ0KPiA+IAkgKiB0aGVtLiBUaGlzIGhhcHBlbnMgaWYgdGhlIGlu
dGVycnVwdCBhc3NlcnRpb24gaXMgZnJvbSBhbiBvdXQtb2YtYmFuZA0KPiA+IAkgKiByZXN1bWUg
bm90aWZpY2F0aW9uLg0KPiA+IAkgKi8NCj4gPiAJaWYgKCFkd2MtPnB1bGx1cHNfY29ubmVjdGVk
ICYmIGNvdW50KSB7DQo+ID4gCQlkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfR0VWTlRDT1VO
VCgwKSwgY291bnQpOw0KPiA+IAkJcmV0dXJuIElSUV9IQU5ETEVEOw0KPiA+IAl9DQo+ID4NCj4g
PiBMZXQgbWUga25vdyBpZiB0aGUgY29uZGl0aW9uIG1hdGNoZXMgd2l0aCB3aGF0J3MgaGFwcGVu
aW5nIGZvciB5b3VyDQo+ID4gY2FzZS4NCj4gSGkgVGhpbmgsDQo+IA0KPiBUaGFua3MgZm9yIHlv
dXIgY29udGludW91cyByZXZpZXdzIGFuZCBzdWdnZXN0aW9ucy4NCj4gDQo+IFRoZSBnaXZlbiBj
b25kaXRpb24gYWxzbyB3aWxsIG5vdCBtYXRjaGVzIGluIG91ciBjYXNlLg0KPiBBcyBpIG1lbnRp
b25lZCBpbiBzdGFydGluZyBvZiB0aGlzIHRocmVhZCBwbGVhc2UgcmVmZXIgb25jZSB0aGUgYmVs
b3cgDQo+IGxpbmsgb2Ygb2xkZXIgZGlzY3Vzc2lvbiBmb3Igc2ltaWxhciBpc3N1ZSBmcm9tIFNh
bXN1bmcuLg0KPiANCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xpbnV4LXVzYi8yMDIzMDEwMjA1MDgzMS4xMDU0OTktMS1qaDA4MDEuanVuZ0Bz
YW1zdW5nLmNvbS9fXzshIUE0RjJSOUdfcGchYTNWcFBIdk1yOWVuazBZUGpTb1dKMTJLcjVIdzJL
YTQzUV93aTgwbHc2dHkydEpUNGhLUktzQ25RTmRxYlZTM0pPUksyVndxZG9YRFd6MXE4eW5wZTdF
eDZjVSQgDQo+IA0KPiANCj4gRFdDM19FVkVOVF9QRU5ESU5HIGZsYWdzIHNldCB3aGVuIGNvdW50
IGlzIDAuDQo+IEl0IG1lYW5zICJUaGVyZSBhcmUgbm8gaW50ZXJydXB0cyB0byBoYW5kbGUuIi4N
Cj4gDQo+IChzdHJ1Y3QgZHdjM19ldmVudF9idWZmZXIgKikgZXZfYnVmID0gMHhGRkZGRkY4ODNE
QkYxMTgwICgNCj4gCSh2b2lkICopIGJ1ZiA9IDB4RkZGRkZGQzAwREJERDAwMCA9IGVuZCsweDMz
N0QwMDAsDQo+IAkodm9pZCAqKSBjYWNoZSA9IDB4RkZGRkZGODgzOUY1NDA4MCwNCj4gCSh1bnNp
Z25lZCBpbnQpIGxlbmd0aCA9IDB4MTAwMCwNCj4gCSh1bnNpZ25lZCBpbnQpIGxwb3MgPSAweDAs
DQo+ICoodW5zaWduZWQgaW50KSBjb3VudCA9IDB4MCwgKHVuc2lnbmVkIGludCkgZmxhZ3MgPSAw
eDAwMDAwMDAxLCoNCj4gCShkbWFfYWRkcl90KSBkbWEgPSAweDAwMDAwMDA4QkQ3RDcwMDAsDQo+
IAkoc3RydWN0IGR3YzMgKikgZHdjID0gMHhGRkZGRkY4ODM5Q0JDODgwLA0KPiAJKHU2NCkgYW5k
cm9pZF9rYWJpX3Jlc2VydmVkMSA9IDB4MCksDQoNCg0KVGhpcyBpcyB0aGUgaW5mbyBvZiB0aGUg
ZXZlbnQgYnVmZmVyIHRoYXQgd2FzIHJlc2V0IGFmdGVyIHRoZQ0KZHdjM19ldmVudF9idWZmZXJz
X3NldHVwKCkuIEknbSB0YWxraW5nIGFib3V0IHRoZSBmaXJzdCB0aW1lDQpEV0MzX0VWRU5UX1BF
TkRJTkcgZmxhZyB3YXMgc2V0Lg0KDQpCeSB0aGUgdGltZSB0aGUgaW50ZXJydXB0IHN0b3JtIGJl
bG93IG9jY3VyLCB0aGUgY291bnQgaW4gdGhlIGJ1ZmZlciBpcw0KYWxyZWFkeSB6ZXJvJ2VkIG91
dC4NCg0KPiANCj4gSVJRIFN0b3JtOg0KPiAodGltZSA9IDQ3NTU3NjI4OTMwOTk5LCBpcnEgPSAx
NjUsIGZuID0gZHdjM19pbnRlcnJ1cHQsIGxhdGVuY3kgPSAwLCBlbiA9IDEpLA0KPiAodGltZSA9
IDQ3NTU3NjI4OTMxMjY4LCBpcnEgPSAxNjUsIGZuID0gZHdjM19pbnRlcnJ1cHQsIGxhdGVuY3kg
PSAwLCBlbiA9IDMpLA0KPiAodGltZSA9IDQ3NTU3NjI4OTMyMzgzLCBpcnEgPSAxNjUsIGZuID0g
ZHdjM19pbnRlcnJ1cHQsIGxhdGVuY3kgPSAwLCBlbiA9IDEpLA0KPiAodGltZSA9IDQ3NTU3NjI4
OTMyNjUyLCBpcnEgPSAxNjUsIGZuID0gZHdjM19pbnRlcnJ1cHQsIGxhdGVuY3kgPSAwLCBlbiA9
IDMpLA0KPiAodGltZSA9IDQ3NTU3NjI4OTMzNzY4LCBpcnEgPSAxNjUsIGZuID0gZHdjM19pbnRl
cnJ1cHQsIGxhdGVuY3kgPSAwLCBlbiA9IDEpLA0KPiAodGltZSA9IDQ3NTU3NjI4OTM0MDM3LCBp
cnEgPSAxNjUsIGZuID0gZHdjM19pbnRlcnJ1cHQsIGxhdGVuY3kgPSAwLCBlbiA9IDMpLA0KPiAu
Li4NCj4gLi4uDQo+IC4uLg0KPiANCj4gDQo+IFdlIGFyZSBhbHNvIGZpbmUgd2l0aCBiZWxvdyBj
b2RlIGNoYW5nZXMgYXMgeW91IHN1Z2dlc3RlZCBlYXJsaWVyLg0KPiBodHRwczovL3VybGRlZmVu
c2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtdXNiLzIwMjMwMTA5MTkw
OTE0LjNibGloamZqZGNzemF6ZGRAc3lub3BzeXMuY29tL19fOyEhQTRGMlI5R19wZyFhM1ZwUEh2
TXI5ZW5rMFlQalNvV0oxMktyNUh3MkthNDNRX3dpODBsdzZ0eTJ0SlQ0aEtSS3NDblFOZHFiVlMz
Sk9SSzJWd3Fkb1hEV3oxcTh5bnAzNjd6dkV3JCANCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBpbmRleCA2
NTUwMDI0NjMyM2IuLjNjMzZkZmRiODhmMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdj
My9nYWRnZXQuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IEBAIC01NTE1
LDggKzU1MTUsMTUgQEAgc3RhdGljIGlycXJldHVybl90IGR3YzNfY2hlY2tfZXZlbnRfYnVmKHN0
cnVjdCANCj4gZHdjM19ldmVudF9idWZmZXIgKmV2dCkNCj4gIMKgwqDCoMKgwqDCoMKgwqAgKiBp
cnEgZXZlbnQgaGFuZGxlciBjb21wbGV0ZXMgYmVmb3JlIGNhY2hpbmcgbmV3IGV2ZW50IHRvIHBy
ZXZlbnQNCj4gIMKgwqDCoMKgwqDCoMKgwqAgKiBsb3NpbmcgZXZlbnRzLg0KPiAgwqDCoMKgwqDC
oMKgwqDCoCAqLw0KPiAtwqDCoMKgwqDCoMKgIGlmIChldnQtPmZsYWdzICYgRFdDM19FVkVOVF9Q
RU5ESU5HKQ0KPiArwqDCoMKgwqDCoMKgIGlmIChldnQtPmZsYWdzICYgRFdDM19FVkVOVF9QRU5E
SU5HKSB7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICghZXZ0LT5jb3VudCkg
ew0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdTMyIHJl
ZyA9IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0dFVk5UU0laKDApKTsNCj4gKw0KPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCEocmVnICYgRFdD
M19HRVZOVFNJWl9JTlRNQVNLKSkNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBldnQtPmZsYWdzICY9IH5EV0MzX0VWRU5UX1BF
TkRJTkc7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4gIMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gSVJRX0hBTkRMRUQ7DQo+ICvCoMKgwqDCoMKgwqAg
fQ0KPiANCj4gDQoNCkkgZG9uJ3Qgd2FudCB0aGUgYm90dG9tLWhhbGYgdG8gYmUgc2NoZWR1bGVk
IGluIHRoZSBiZWdpbm5pbmcgYXMgaXQgbWF5DQpjb21lIGJlZm9yZSB0aGUgY2xlYW51cCBpbiBk
d2MzX2V2ZW50X2J1ZmZlcnNfc2V0dXAoKS4NCg0KQlIsDQpUaGluaA==

