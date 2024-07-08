Return-Path: <linux-kernel+bounces-244976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8631592AC6B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 01:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 382932825C7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 23:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAE8152780;
	Mon,  8 Jul 2024 23:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="aWVrkekI";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="V81zSTzs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="D2it24BF"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EF614F9D9;
	Mon,  8 Jul 2024 23:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720480210; cv=fail; b=dPk3OQDRjLYOqbmi0R76zXdc3GvoeDQzrDXf7kjnE5UsHU2F6Jn0AcsOQ5Kmyd6aSWnsrZWvT88MCvHJmGMDZGmrDlPQNCrzjjIqx7yNtJnZvDSWqIusw1ZLmrWSV89LHLX0uVL5bmTPKy4xJcGR/jkFEVMHSqPcGD1EeXAkmDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720480210; c=relaxed/simple;
	bh=nkxwtuq2QiP4fbiCTGNiCEpnbVaOnru7NrN1thYurbo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cYZfR1O8+QoiSEioXZckKHCiLeLh5lmrJrv/Dt7m2xdN5uku3R484ObXMuWhTnycxAWtZIGqDyNj2dMiNh98Auu5zCHqwGJs5ADu+moIYm0AUtggL8Df6RlIZnCS+HPsIocKzM0BY8kR4DmftEBIr2/oO7m2WJE8nyr+ugAbLIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=aWVrkekI; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=V81zSTzs; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=D2it24BF reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468L5IDE025449;
	Mon, 8 Jul 2024 16:09:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=nkxwtuq2QiP4fbiCTGNiCEpnbVaOnru7NrN1thYurbo=; b=
	aWVrkekIJRROIX+aUc2j6oMCvWVdUFieCYaZyFAnU3GJykWVK2Kl4sIzTWmiFS5s
	LIj9TBNJBcl60M2Q9O10WLq606ayn5gXBnmr/0iacAp0TJUT6Fl8bF6GjkN9Mfep
	X6aS8RioCC4SHEqhn9g+t2PXZXGy0LatYez/AQZPJUIk8bed/DV5xF1K7+OcJXdt
	k3Gf7gznL8aNNKY3vnBbkWDMXwWXzFbFrHZwAbl1UD/QzvcuP0GlkiZmYwpPEVvx
	LB59jkWpHBLI6Zt1xptTZ0oQOHGZ6apE9Vz4e3pdQFgCTSvJJ8j0HZiUVVpvkUCx
	Dp8pE5YevVj9G7LcTu2+QA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4074us0n7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 16:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1720480190; bh=nkxwtuq2QiP4fbiCTGNiCEpnbVaOnru7NrN1thYurbo=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=V81zSTzsLr+VmRUVZhvl0KfrwZ1k/5lmKj1PmZphrrIHsCSZJrMmNlUfCdT45qtrH
	 PJClezXkxUkeH1qkTfwPmT89q2mvcTLZIQt6QHS2k5gpFIsfW3u+KK2Lwj+RITp1Iw
	 0+V23dcDrbcD1jFaBERfG0ZkdVAFBPVgXDITk1DMFAouiBD0beLbvfatzvFfto6pK6
	 xctZLgcgQ5dvT/1EHqJZBgSsAxaaLqEb3lpKlDcO7xCWIq+WhDM+iI6AcEGx3loeqq
	 HEld9vHR+YSKgV8ySUKfvV1NQw+R9DpncRdG5XqZkvrX2cpK/PEhJzpfJ7DmOVitbM
	 ooM5cvOJt5T0Q==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3AB1E40346;
	Mon,  8 Jul 2024 23:09:49 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 990E4A00B3;
	Mon,  8 Jul 2024 23:09:47 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=D2it24BF;
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6AA83404F3;
	Mon,  8 Jul 2024 23:09:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjnGKQ9INszdsowT8wvD2nfvrlGxzbxocYCPeXZHICVdF/Ieu77J1kWJLQhpbDmSXxLZxg81iu1xji8koMTbXkWDWRktjIndhAMb4QDVoD8xonbT49M05J05U9YwRAeKc1ngEhWioQYy279oiFkPUtzrpEVyVtoUociFK4/hGiGC429vPWi7fKr8nW6vkfiDyMbx63wDn1OSUtf+dKFB8XhuDxXNUkpYVf24mFhbs08DcKDKqmdfoBiuLmIVWvpsqreQrtmKUOWLm3gUUQ7LJ8D2xf0ol8N9jzJPidqqpI8p9KOkRTiqUJKkVvNuUOR4tQesk5PfL1nqTnbfUSDRVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkxwtuq2QiP4fbiCTGNiCEpnbVaOnru7NrN1thYurbo=;
 b=P0LVaOBAg63hr5vlio+ME/CqQdaFbQxueeqYGb/kCwUR0dpyP73ZBZiYshjYr7KZqQL2t0RYFpoBnw7Tm2Jqla5vNkDvUl6SwLaL373yVB80gHfow8ePa3dQ0A3RwzNr4rHh56V6Rh6PvLcfvQNo17xrMCWu6tC3mT7j1c/p0FgRMcddvEilgAG7IU0g1n+cd7jfM489zi7ekaQ18RUbZTa37/6uRvm4tJHcOrB2JhbtCWUgJ4SwbPBi9FBbyTu0zCtTvOdZn020rN+jiMpBRTM6wnUHjxnDBvydBd9QZy2gDWask9dhe+Gw64I0abPqR0Nfd1SIh4Qzu/NlOSRxGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkxwtuq2QiP4fbiCTGNiCEpnbVaOnru7NrN1thYurbo=;
 b=D2it24BFM+//hpaKwiQBZtv68t2rTRpAGsinH2FtG5sUZR+QVahyKNCmoHKuQWN8jDKJYgeXe+3U8jzMW8hXmGyOVNQrSJJlNR8Me3ARtvDD9huCJ8r0wu9uRLLvDczfrrMuJ8JxX5q3E+gAjXr/VLOGMhAz8XDRGsgukYfbSHI=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by IA0PR12MB7697.namprd12.prod.outlook.com (2603:10b6:208:433::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 23:09:36 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 23:09:36 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "michal.simek@amd.com" <michal.simek@amd.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "Frank.li@nxp.com" <Frank.li@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "git@amd.com" <git@amd.com>
Subject: Re: [PATCH v4] usb: dwc3: enable CCI support for AMD-xilinx DWC3
 controller
Thread-Topic: [PATCH v4] usb: dwc3: enable CCI support for AMD-xilinx DWC3
 controller
Thread-Index: AQHa0RB/qOnpQ5Vh9UiC7A7MOyngjrHtdaAA
Date: Mon, 8 Jul 2024 23:09:36 +0000
Message-ID: <20240708230926.v323725jamdltnoy@synopsys.com>
References: <1720427152-4052539-1-git-send-email-radhey.shyam.pandey@amd.com>
In-Reply-To: <1720427152-4052539-1-git-send-email-radhey.shyam.pandey@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|IA0PR12MB7697:EE_
x-ms-office365-filtering-correlation-id: f6d7d0af-195e-49d8-e01c-08dc9fa30920
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?VGpNUExaSlBSaThhaENzdGRSR3BaaTNSbFI3NWp0ZGtsSlBGN3k2OHpQbm51?=
 =?utf-8?B?RXBuNW9JTUdtbm1EbEJMV3pxdjRyOXhVQlp5V3o4YTJ1S3U1bjJmaWQvZHgy?=
 =?utf-8?B?T012ZUZhMlh2Q2Zaa3NPc0RoMVA2ZUdpc1BDUE1aMUVHUnFFOG5JT1M2Ylcv?=
 =?utf-8?B?TEtMMm0rUk1TMDhTajhFbVFVV2I5UWpmUXdrV1E2UVd1YlRuYTM3SUdsT3VM?=
 =?utf-8?B?OEgvOXFNY3pybmhOZWZlcm1jYzFWWE5kQW43TzZWM3Q2dGtvUU9Bdk1BdzBY?=
 =?utf-8?B?RFBTMGRMMXQ4bFNtRHJ6cXhpd2RHWXpsU3diOWpXdllncHJpVW5nZWpCM1d3?=
 =?utf-8?B?dHZ3SnEyUGhhT3J3enJNVkcwTHVhb3BOUmdiQkhNdWFWUzY4NlBnUk5Wbkhr?=
 =?utf-8?B?QXR6NXM2b0xHRDg3cFRVQ3BKSmJqSjVrVG5DWHdoWTlaaFdINktsMWlCOVAr?=
 =?utf-8?B?NGhrT2RGdHFDeTgxdmJBNWg1Y3Q0UUJjWExXUktGYUFHclB2ODE2ZmxUQ1Jz?=
 =?utf-8?B?eDcySitESVd5aERrc3FMY1dUQlY4THQvekJOa2FEWjlmclBvVzA0QWhXeDVs?=
 =?utf-8?B?NnBObmd4c2VKZ2FWN2h3VEZyZkRieFJRSWkyMVhwSjcxa09STzJWVjcxMHhO?=
 =?utf-8?B?MlRIWGVmaHhoM1NvTHVNNG5IaTlpNXNpWW44dVZ2Y20wK0xidEJtT0JyMmEx?=
 =?utf-8?B?OTZhVTFGdVdObzZSMjZleS82Ty9SalhxQXN2RmQ5Y2MvN1N3ZGJWdmsxR2lk?=
 =?utf-8?B?SDY4TmkwbzRRV0J2clExWGsrbmpDb3JXQXdBUWZGWTVTRWFObE5YZU9UZXZG?=
 =?utf-8?B?ZFdLbXd1Y3Z4WXRkbjZib1VPdm1VYTJMMWM5UGlDdUVIL293WW5FajZheHdI?=
 =?utf-8?B?QlZheUJPK3o4TnlhUXp1WS9aTmxMRmZZbVRqNmZVaG5uQnVwQWpmb2VJSDBk?=
 =?utf-8?B?NmtaSnM1UTlIcTJDbWxrT3RwZVNTMGxkZWtqQkpVczJ3bERGajdBNHFCTlRP?=
 =?utf-8?B?R3lrYWhKVDliUDluQ1JsN3hkMkNXYkkwY2pzcUppcDJMcUJxUUZ3M3h6RXg4?=
 =?utf-8?B?Uzc5OEVUYTNoZVN4Tlg0QXpJUGtkbWViK3d5REFOM0ZpWE1VRlkvdm10eXRY?=
 =?utf-8?B?OTFyVDdldGo1Mm9aMjFIRU4rc3g3UDhKV3ZSOTMvVEduNjJmRDRiVXk4Tno3?=
 =?utf-8?B?WG1jZ1MrdFpDbWJQL091c2tqUEZ4UlR2eEJnYTFYWldhNXozWTEyTjFTbmtj?=
 =?utf-8?B?aTAvTnVZdWFTVlBYRmthQ1RXU282ZkJBS0M4cDY5YlNtTzZSN1ZXZGdFdUpE?=
 =?utf-8?B?NUFEOStORUlBcFZGTW8wSGRVdmxsV3VueTY1T2laODRUcjQ3ejQxWDNLalpS?=
 =?utf-8?B?R3pUWTZ3eGUvTzdHSlNDYWJJYjNXRy8vZFRhRytidEcvdVpiay8ybHplaWJT?=
 =?utf-8?B?R0ZlQnp1bldzL2c1d1RmSjN1THNQaEF4WHErQkV4Y29yYXdkWnlYUnZ0SUMr?=
 =?utf-8?B?WTF4ZEVIdVk3dnlLTlVod2JYNHBkbVl5eGNKSGRabmFGWlJyZ2hPN2JmUTg2?=
 =?utf-8?B?UEdQYzU2WkcxZXhIeTFxNnQ4WStaTnB4b1lNNmRCV2ZWL1VEY1F5MWdOR3ZO?=
 =?utf-8?B?OHlsdTVFTzZ2SWd1WHFFM2ZyVThvZ0pGU1U0V1UxZ3JBMjhvaDlZaFFYS0J5?=
 =?utf-8?B?dVlMR1YzaHozN0dSazU3anBSdEZNaHJndzVLSGxUNjJSUlN5Rk9VOTZSYVVC?=
 =?utf-8?B?bHNqWDRSdVlmOXR6NytLREpkdEF5T2s0MFdNR2JQMzVZaERoTVI0SWRNaVlm?=
 =?utf-8?Q?o8RXP8k9ubnNjleS29ONwy6o9s6eMYAbOHjNQ=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NFZWTEVmT0FibnBReTNwU004L2s4b1FNc1FISUZsNnlFZmZpVmY2UVgxb3FM?=
 =?utf-8?B?K21yZ0VHdVlkTy9zUHNGNjdRVkNPTzdsWFY4dkluY1BodmJFck1ZemMrc3cx?=
 =?utf-8?B?d0dxUGxxclowQk5ORlQyWjNSQXc1TlRvcWZlL3hlTXE1MWh3d2VJeEdaRkdk?=
 =?utf-8?B?endiM0lBbld4N2p2cXlhMVQzQzhYS1cvQjNZaXgwM1VYanZQd2poTVlDM2g1?=
 =?utf-8?B?Y1pGamtyeXBsTjdEdXlTQjNMV0hDMGc4MGpxV1dnTEpoOHNiMkc1bVlGajg1?=
 =?utf-8?B?cnFZL28wUE5jRnpGVmtMVllpRlhRWkRUdHpQN3hOUzdKSTVJN1FDZUluQmNq?=
 =?utf-8?B?SnFkT3Nwb1NDU1BVUXg1eFVCYXNpVDRtVzdtNlVPY3ptQmRZd0U2dng2dmpV?=
 =?utf-8?B?VmZTOWs5dzJBMTRWOUdDaE9HN0NZSmNkSk1hNU9lUjZLUWtDMHl4NmtCTHNm?=
 =?utf-8?B?Yk1TL082dlI3NTVHZFRoaUZPQnhSS1I0ajc2NlZzYUlNakphTmlqcCtQWnRX?=
 =?utf-8?B?a0xvNVhSbXNHQXA5WUVvd2ZCMjYyU3J0NHA0QVcvbXh1aW9IOVV2OVgvQVUr?=
 =?utf-8?B?T2UxTUloSjl3cE93bDhOSkVtdGQ0bURNQzVFVXQvY1ZrV1VObFhpY3VUSFFn?=
 =?utf-8?B?MWNVY3E1T0tGdVJMdzBBcjRXU0VoUFRxb25JaFdEZVdwMUVwMkorWkdwYnVI?=
 =?utf-8?B?RVVoUXpaNXVKZHU5SDhXOWl1VS9CSUpONUpRQlFER3ZDTWFVS01paEd0YjZI?=
 =?utf-8?B?U00xNVdkWU9kUEtKdjdyTWpGZWs2dnhmZzZGWEhBYS9WSlQxcGNSRzJqdkNE?=
 =?utf-8?B?SnIraFRSNmZoRW5LM1JoeU5SdUlSUEdWRXpqcFoyMndqU205WFVGN3AvVEtR?=
 =?utf-8?B?RFpYUGZJRTc1cGk0VThXa2UzL1R2VkhpVWVqWUZ1SmRGclpJbTJ4YmhZVkpu?=
 =?utf-8?B?c0IrdWdtSEF2dlhkMjNSNGxReGNiSzluTzMyeTIrQWhqclNSUUYzYTFvZDF6?=
 =?utf-8?B?QmVwd3NEQnlFV1BhNnIzbnUwMHRyUjFlUUM1OVBwWXZoMG1URDRldTRFM0x5?=
 =?utf-8?B?MzFSYXBGaG9zdXFJNFFvZ2tiRGV1TDVJWWlzZnJZRWdPNjNleXF6aWFJYnZU?=
 =?utf-8?B?VWRkTm9WdFI3dG0zWFdhN1ZsL01BdWNqa1FaNnhsYkQyQWZZcGhvTktkaU5U?=
 =?utf-8?B?ckk4WkRlQ1h1eFR1bk43T3ZFK21RNXdRVXZzMEgzNlZXMUl5Y1V1RHFDRzlx?=
 =?utf-8?B?SEFNQWhpTVh5OXhRcWhUQk9JeGEyZjI0UUdtVTJGR2dUNmRLU1ZRYllKUGkw?=
 =?utf-8?B?K0ZqaG9zNGh5bU5Oc0RSMzI4cGYrUGlwaGxwMFNMbzY2dHUzVkI1SXFxZ1pn?=
 =?utf-8?B?dUcwRHdCUGxxa1FzM2hMVWNDUkEzMW9Fa29OcXdIampubVJzcHk2Ym5KUGYv?=
 =?utf-8?B?T25YdFpVZ05MeUpua000TWtva3JMenJ1bEc2cDJGNW9kQk9sdkFzS3JNNVJF?=
 =?utf-8?B?QU02aFpEMkpFKzNIU0hlNzM1YTBEaDZKYUxnUWlDWEpFeDF3YjRhRngvTTE0?=
 =?utf-8?B?L2VOMkxzekZxbldQV0NpWHozWm45L1hlSDd0RzhwT2VUOUtJUU5XM0gvTjI3?=
 =?utf-8?B?UUlaTVYrRU5PZXJwY08zaHNqbWVrNTJDYmtGUFZ2WEUyekdWNHZKQ0oyUEhL?=
 =?utf-8?B?citWOHdiU0l0ai83cVc1WWNDRWhCQys0WW5jcXBZdElZOWtSMjVSYWl1VlRF?=
 =?utf-8?B?cjM1RCt3T2N3NGVjakFSMFN0b2J6d2RhaTJueDM0Y1RNMERjVkdYQlFMUEhk?=
 =?utf-8?B?c25hWjdIZkFDWStkQ2pCQzNLYVFjUklvMVRvckUxTWZRQ054OXZpekxFYzNt?=
 =?utf-8?B?Nmtmb2owazhDSksrUG1SeVRacWVuTzU4clc1V1F6V0U2OWVPeWFQYXRxeTRO?=
 =?utf-8?B?TTBJOHhkRnpoZTlLOFArQWpQdVgxc1I1SFZmSHRFam1QR2x3ZFhQenp1WktJ?=
 =?utf-8?B?Tm5rTXJrYjZNQUhkK21KVUtHNnJYeDZMcFdUVytzVllUN20zOTRrZWt0a1RQ?=
 =?utf-8?B?N2FDZ2xUWGVlUVBGeWlXNThDNDJmSXJ5a1FFdzBieVlIcjJLM3pLODBYZGVR?=
 =?utf-8?Q?m8dQvd4r7kAriC8vjBvlkoXri?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2569A4097DAA1D41895FF16822ECF7CA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dG1wtSv4z83v7xlihpQUFd6ciho3CyR278KKZ96FU6ur7z3DYkw8yk9ioHA6f7dPrrEz6MO7l6EOiuV2sLAdcu9ZABcLcN7XRbAImk+TQw5QnVeJRLGlt2r+cXDlLu6Z5eshHWUwwhtIAX3G6IGMC2KPY+QmPZ6Gm7WkYS1NjcdI8bPdzLLWu2rKd+TYP/3Ra1kn+TVhDiaoS8ghg4tQv40+I00ci7MaXfXIVhudtfGwZ/LpBrN9F3OTAVi29kbwQ7VCHiXtmhyb+aylxPUi19REedpq9lCGMW6tDyBkxA5ILGqian4Gy051GnRySWoDoX96FYQn6QEPzN5lc5aYwL5CWTfytx2UbgrF1RvUx4WQiMTl46KaRVBkQfQq2ZcC9uoYMkuWNmHlNpeiEssveDA3xHtQhIXkvHanWJt3cKpkZa5Xu/sUgWBF/My8NV+AZUtU3ZBRHPU6zVLkG7ggAlAKlAeD3Zyo5zaiZbIxPs/bU39Wbq1ujghVR6DRFGKxQoLR4Mqm1KJ0xajeVpTnB1kquAPHflv/2edtiOgd+tXYCFb/9lvavHsaaCneUKopqIxYlw01/3N7ujO5OYP18+CHVxS20HfuhQf2WIe1W8CTMxkXySCysZ74gcElQYeG3hdYPDGi31jo9TgoUrDi8g==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d7d0af-195e-49d8-e01c-08dc9fa30920
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 23:09:36.1189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fLgFtmMz6BZtq91NgWF9AwOX0c+x0oEZRF69AbAdrkCE2sGNFxOIJFj5Z1sMBXn4n+Mx1IUQQ9T7XeJ/EJfk7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7697
X-Proofpoint-ORIG-GUID: KiDXxpNx0aSJATIcn59-IMEKKgKuJDhO
X-Proofpoint-GUID: KiDXxpNx0aSJATIcn59-IMEKKgKuJDhO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_12,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 phishscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0
 adultscore=0 mlxscore=0 spamscore=0 clxscore=1011 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2407080171

SGksDQoNCk9uIE1vbiwgSnVsIDA4LCAyMDI0LCBSYWRoZXkgU2h5YW0gUGFuZGV5IHdyb3RlOg0K
PiBUaGUgR1NCVVNDRkcwIHJlZ2lzdGVyIGJpdHMgWzMxOjE2XSBhcmUgdXNlZCB0byBjb25maWd1
cmUgdGhlIGNhY2hlIHR5cGUNCj4gc2V0dGluZ3Mgb2YgdGhlIGRlc2NyaXB0b3IgYW5kIGRhdGEg
d3JpdGUvcmVhZCB0cmFuc2ZlcnMgKENhY2hlYWJsZSwNCj4gQnVmZmVyYWJsZS9Qb3N0ZWQpLiBX
aGVuIENDSSBpcyBlbmFibGVkIGluIHRoZSBkZXNpZ24sIERXQzMgY29yZSBHU0JVU0NGRzANCj4g
Y2FjaGUgYml0cyBtdXN0IGJlIHVwZGF0ZWQgdG8gc3VwcG9ydCBDQ0kgZW5hYmxlZCB0cmFuc2Zl
cnMgaW4gVVNCLg0KPiANCj4gVG8gcHJvZ3JhbSBHU0JVU0NGRzAgY2FjaGUgYml0cyBjcmVhdGUg
YSBzb2Z0d2FyZSBub2RlIHByb3BlcnR5DQo+IGluIEFNRC14aWxpbnggZHdjMyBnbHVlIGRyaXZl
ciBhbmQgcGFzcyBpdCB0byBkd2MzIGNvcmUuIFRoZSBjb3JlDQo+IHRoZW4gcmVhZHMgdGhpcyBw
cm9wZXJ0eSB2YWx1ZSBhbmQgY29uZmlndXJlcyBpdCBpbiBkd2MzX2NvcmVfaW5pdCgpDQo+IHNl
cXVlbmNlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmFkaGV5IFNoeWFtIFBhbmRleSA8cmFkaGV5
LnNoeWFtLnBhbmRleUBhbWQuY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBmb3IgdjQ6DQo+IA0KPiAg
LSBQYXNzIHN3bm9kZSBHU0JVU0NGRzAgY2FjaGUgcHJvcGVydHkgZnJvbSBnbHVlIGRyaXZlciBi
YXNlZCBvbg0KPiAgICBkbWEtY29oZXJlbnQgZmxhZy4NCj4gIC0gSW50cm9kdWNlIGZ1bmN0aW9u
IGR3YzNfZ2V0X3NvZnR3YXJlX3Byb3BlcnRpZXMoKS4NCj4gIC0gUmVuYW1lIERXQzNfR1NCVVND
RkcwX1JFUUlORk9fTUFTSy4NCj4gIC0gVXNlIERXQzNfR1NCVVNDRkcwX1JFUUlORk8obikgYW5k
IGdldCByaWQgb2YgbWFzayBzaGlmdCBkZWZpbmUuDQo+ICAtIFJlbmFtZSBkd2MzIG1lbWJlciBn
c2J1c2NmZzBfcmVxaW5mbyBhbmQgY2hhbmdlIGl0IHR5cGUgdG8gdTMyDQo+ICAgIGFuZCBkZWZp
bmUgMHhmZmZmZmZmZiBhcyB1bnNwZWNpZmllZC4NCj4gIC0gSW4gY29tbWVudCBkd2MzX2dldF9z
b2Z0d2FyZV9wcm9wZXJ0aWVzKCkgZGVzY3JpcHRpb24gYWxzbyBtZW50aW9uDQo+ICAgICJub24t
RFQgKG5vbi1BQkkpIHByb3BlcnRpZXMiLg0KPiANCj4gQ2hhbmdlcyBmb3IgdjM6DQo+ICAtIElu
IHYyIHJldmlldyBhcyBzdWdnZXN0ZWQgYnkgVGhpbmggTmd1eWVuLCBzd2l0Y2ggdG8gc3dub2Rl
DQo+ICAgIGltcGxlbWVudGF0aW9uIGZvciBwYXNzaW5nIEdTQlVTQ0ZHMCBjYWNoZSBiaXRzIGZy
b20gQU1ELXhpbGlueA0KPiAgICBkd2MzIGdsdWUgZHJpdmVyIHRvIGNvcmUgZHJpdmVyLg0KPiAN
Cj4gQ2hhbmdlcyBmb3IgdjI6DQo+ICAtIE1ha2UgR1NCVVNDRkcwIGNvbmZpZ3VyYXRpb24gc3Bl
Y2lmaWMgdG8gQU1ELXhpbGlueCBwbGF0Zm9ybS4NCj4gICAgVGFrZW4gcmVmZXJlbmNlIGZyb20g
ZXhpc3RpbmcgY29tbWl0IGVjNWViNDM4MTNhNCAoInVzYjogZHdjMzogY29yZToNCj4gICAgYWRk
IHN1cHBvcnQgZm9yIHJlYWx0ZWsgU29DcyBjdXN0b20ncyBnbG9iYWwgcmVnaXN0ZXIgc3RhcnQg
YWRkcmVzcyIpDQo+IA0KPiB2MSBsaW5rOg0KPiAgaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9f
X2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMTAxMzA1MzQ0OC4xMTA1Ni0xLXBpeXVz
aC5tZWh0YUBhbWQuY29tX187ISFBNEYyUjlHX3BnIWFtMUQ5aFJyU0dlREtJTF9na0NNaWF3NHFL
R1luaV9qMl9HempHdmRrVHVKQ3FVY1gyT1F0Skt0cnZaS2RRNkRMdlQ2dXU3RkVJZjFPaUI4LXZq
b3pmN0UtU2xyS1EkIA0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jICAgICAgICB8
IDM4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIGRyaXZlcnMvdXNiL2R3
YzMvY29yZS5oICAgICAgICB8ICA4ICsrKysrKysNCj4gIGRyaXZlcnMvdXNiL2R3YzMvZHdjMy14
aWxpbnguYyB8IDI5ICsrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAzIGZpbGVzIGNoYW5n
ZWQsIDc1IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2Mz
L2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IGluZGV4IGNiODI1NTc2NzhkZC4u
ZmUyMTZhNmZmNjUyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiAr
KysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBAQCAtMjMsNiArMjMsNyBAQA0KPiAgI2lu
Y2x1ZGUgPGxpbnV4L2RlbGF5Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgvZG1hLW1hcHBpbmcuaD4N
Cj4gICNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L29mX2FkZHJlc3Mu
aD4NCg0KV2Ugbm8gbG9uZyBuZWVkIHRvIGluY2x1ZGUgdGhpcyBpbiBjb3JlLmMgcmlnaHQ/DQoN
Cj4gICNpbmNsdWRlIDxsaW51eC9vZl9ncmFwaC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2FjcGku
aD4NCj4gICNpbmNsdWRlIDxsaW51eC9waW5jdHJsL2NvbnN1bWVyLmg+DQo+IEBAIC01OTksNiAr
NjAwLDE4IEBAIHN0YXRpYyB2b2lkIGR3YzNfY2FjaGVfaHdwYXJhbXMoc3RydWN0IGR3YzMgKmR3
YykNCj4gIAkJcGFybXMtPmh3cGFyYW1zOSA9IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0dI
V1BBUkFNUzkpOw0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgdm9pZCBkd2MzX2NvbmZpZ19zb2NfYnVz
KHN0cnVjdCBkd2MzICpkd2MpDQo+ICt7DQo+ICsJaWYgKGR3Yy0+Z3NidXNjZmcwX3JlcWluZm8g
IT0gRFdDM19HU0JVU0NGRzBfUkVRSU5GT19ERUYpIHsNCj4gKwkJdTMyIHJlZzsNCj4gKw0KPiAr
CQlyZWcgPSBkd2MzX3JlYWRsKGR3Yy0+cmVncywgRFdDM19HU0JVU0NGRzApOw0KPiArCQlyZWcg
Jj0gfkRXQzNfR1NCVVNDRkcwX1JFUUlORk8ofjApOw0KPiArCQlyZWcgfD0gRFdDM19HU0JVU0NG
RzBfUkVRSU5GTyhkd2MtPmdzYnVzY2ZnMF9yZXFpbmZvKTsNCj4gKwkJZHdjM193cml0ZWwoZHdj
LT5yZWdzLCBEV0MzX0dTQlVTQ0ZHMCwgcmVnKTsNCj4gKwl9DQo+ICt9DQo+ICsNCj4gIHN0YXRp
YyBpbnQgZHdjM19jb3JlX3VscGlfaW5pdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgew0KPiAgCWlu
dCBpbnRmOw0KPiBAQCAtMTMzOCw2ICsxMzUxLDggQEAgc3RhdGljIGludCBkd2MzX2NvcmVfaW5p
dChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgDQo+ICAJZHdjM19zZXRfaW5jcl9idXJzdF90eXBlKGR3
Yyk7DQo+ICANCj4gKwlkd2MzX2NvbmZpZ19zb2NfYnVzKGR3Yyk7DQo+ICsNCj4gIAlyZXQgPSBk
d2MzX3BoeV9wb3dlcl9vbihkd2MpOw0KPiAgCWlmIChyZXQpDQo+ICAJCWdvdG8gZXJyX2V4aXRf
cGh5Ow0KPiBAQCAtMTc1Niw2ICsxNzcxLDI3IEBAIHN0YXRpYyB2b2lkIGR3YzNfZ2V0X3Byb3Bl
cnRpZXMoc3RydWN0IGR3YzMgKmR3YykNCj4gIAlkd2MtPnR4X2ZpZm9fcmVzaXplX21heF9udW0g
PSB0eF9maWZvX3Jlc2l6ZV9tYXhfbnVtOw0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgdm9pZCBkd2Mz
X2dldF9zb2Z0d2FyZV9wcm9wZXJ0aWVzKHN0cnVjdCBkd2MzICpkd2MpDQoNCkNhbiB3ZSBtb3Zl
IHRoaXMgYWJvdmUgZHdjM19nZXRfcHJvcGVydGllcygpLiBJJ2QgY2FsbCB0aGlzIHdpdGhpbg0K
ZHdjM19nZXRfcHJvcGVydGllcygpLCBidXQgaXQncyBmaW5lIGV2ZW4gaWYgeW91IGxlYXZlIGl0
IHNlcGFyYXRlIGZvcg0Kbm93LiBUaGF0J2xsIGhlbHAgcmVkdWNlIHRoZSBjb2RlIGZvb3Rwcmlu
dCB3aGVuIHdlIHJlZmFjdG9yIGFuZCBtb3ZlDQp0aGUgb3RoZXIgc29mdHdhcmUgcHJvcGVydGll
cyBpbiBoZXJlLg0KDQo+ICt7DQo+ICsJc3RydWN0IGRldmljZSAqdG1wZGV2Ow0KPiArCXUxNiBn
c2J1c2NmZzBfcmVxaW5mbzsNCj4gKwlpbnQgcmV0Ow0KPiArDQo+ICsJZHdjLT5nc2J1c2NmZzBf
cmVxaW5mbyA9IERXQzNfR1NCVVNDRkcwX1JFUUlORk9fREVGOw0KPiArDQo+ICsJLyoNCj4gKwkg
KiBJdGVyYXRlIG92ZXIgYWxsIHBhcmVudCBub2RlcyBmb3IgZmluZGluZyBzd25vZGUgcHJvcGVy
dGllcw0KPiArCSAqIGFuZCBub24tRFQgKG5vbi1BQkkpIHByb3BlcnRpZXMuDQo+ICsJICovDQo+
ICsJZm9yICh0bXBkZXYgPSBkd2MtPmRldjsgdG1wZGV2OyB0bXBkZXYgPSB0bXBkZXYtPnBhcmVu
dCkgew0KPiArCQlyZXQgPSBkZXZpY2VfcHJvcGVydHlfcmVhZF91MTYodG1wZGV2LA0KPiArCQkJ
CQkgICAgICAgInNucHMsZ3NidXNjZmcwLXJlcWluZm8iLA0KPiArCQkJCQkgICAgICAgJmdzYnVz
Y2ZnMF9yZXFpbmZvKTsNCj4gKwkJaWYgKCFyZXQpDQo+ICsJCQlkd2MtPmdzYnVzY2ZnMF9yZXFp
bmZvID0gZ3NidXNjZmcwX3JlcWluZm87DQo+ICsJfQ0KPiArfQ0KPiArDQo+ICAvKiBjaGVjayB3
aGV0aGVyIHRoZSBjb3JlIHN1cHBvcnRzIElNT0QgKi8NCj4gIGJvb2wgZHdjM19oYXNfaW1vZChz
dHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgew0KPiBAQCAtMjA5MCw2ICsyMTI2LDggQEAgc3RhdGljIGlu
dCBkd2MzX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICANCj4gIAlkd2Mz
X2dldF9wcm9wZXJ0aWVzKGR3Yyk7DQo+ICANCj4gKwlkd2MzX2dldF9zb2Z0d2FyZV9wcm9wZXJ0
aWVzKGR3Yyk7DQo+ICsNCj4gIAlkd2MtPnJlc2V0ID0gZGV2bV9yZXNldF9jb250cm9sX2FycmF5
X2dldF9vcHRpb25hbF9zaGFyZWQoZGV2KTsNCj4gIAlpZiAoSVNfRVJSKGR3Yy0+cmVzZXQpKSB7
DQo+ICAJCXJldCA9IFBUUl9FUlIoZHdjLT5yZXNldCk7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3VzYi9kd2MzL2NvcmUuaCBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+IGluZGV4IDM3ODFj
NzM2YzFhMS4uZTA0NjQwNjYyZDM2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2Nv
cmUuaA0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBAQCAtMTk0LDYgKzE5NCwx
MCBAQA0KPiAgI2RlZmluZSBEV0MzX0dTQlVTQ0ZHMF9JTkNSQlJTVEVOQQkoMSA8PCAwKSAvKiB1
bmRlZmluZWQgbGVuZ3RoIGVuYWJsZSAqLw0KPiAgI2RlZmluZSBEV0MzX0dTQlVTQ0ZHMF9JTkNS
QlJTVF9NQVNLCTB4ZmYNCj4gIA0KPiArLyogR2xvYmFsIFNvQyBCdXMgQ29uZmlndXJhdGlvbiBS
ZWdpc3RlcjogQUhCLXByb3QvQVhJLWNhY2hlL09DUC1SZXFJbmZvICovDQo+ICsjZGVmaW5lIERX
QzNfR1NCVVNDRkcwX1JFUUlORk8obikJKCgobikgJiAweGZmZmYpIDw8IDE2KQ0KPiArI2RlZmlu
ZSBEV0MzX0dTQlVTQ0ZHMF9SRVFJTkZPX0RFRgkweGZmZmZmZmZmDQoNCkNhbiB3ZSByZW5hbWUg
dGhpcyB0byBEV0MzX0dTQlVTQ0ZHMF9SRVFJTkZPX1VOU1BFQ0lGSUVELiAiREVGIiBpbXBsaWVz
DQphIHZhbGlkIGRlZmF1bHQgdmFsdWUuDQoNCj4gKw0KPiAgLyogR2xvYmFsIERlYnVnIExTUCBN
VVggU2VsZWN0ICovDQo+ICAjZGVmaW5lIERXQzNfR0RCR0xTUE1VWF9FTkRCQwkJQklUKDE1KQkv
KiBIb3N0IG9ubHkgKi8NCj4gICNkZWZpbmUgRFdDM19HREJHTFNQTVVYX0hPU1RTRUxFQ1QobikJ
KChuKSAmIDB4M2ZmZikNCj4gQEAgLTExNTMsNiArMTE1Nyw5IEBAIHN0cnVjdCBkd2MzX3NjcmF0
Y2hwYWRfYXJyYXkgew0KPiAgICogQG51bV9lcF9yZXNpemVkOiBjYXJyaWVzIHRoZSBjdXJyZW50
IG51bWJlciBlbmRwb2ludHMgd2hpY2ggaGF2ZSBoYWQgaXRzIHR4DQo+ICAgKgkJICAgIGZpZm8g
cmVzaXplZC4NCj4gICAqIEBkZWJ1Z19yb290OiByb290IGRlYnVnZnMgZGlyZWN0b3J5IGZvciB0
aGlzIGRldmljZSB0byBwdXQgaXRzIGZpbGVzIGluLg0KPiArICogQGdzYnVzY2ZnMF9yZXFpbmZv
OiBzdG9yZSBHU0JVU0NGRzAuREFUUkRSRVFJTkZPLCBERVNSRFJFUUlORk8sDQo+ICsgKgkJICAg
ICAgIERBVFdSUkVRSU5GTywgYW5kIERFU1dSUkVRSU5GTyB2YWx1ZSBwYXNzZWQgZnJvbQ0KPiAr
ICoJCSAgICAgICBnbHVlIGRyaXZlci4NCj4gICAqLw0KPiAgc3RydWN0IGR3YzMgew0KPiAgCXN0
cnVjdCB3b3JrX3N0cnVjdAlkcmRfd29yazsNCj4gQEAgLTEzODAsNiArMTM4Nyw3IEBAIHN0cnVj
dCBkd2MzIHsNCj4gIAlpbnQJCQlsYXN0X2ZpZm9fZGVwdGg7DQo+ICAJaW50CQkJbnVtX2VwX3Jl
c2l6ZWQ7DQo+ICAJc3RydWN0IGRlbnRyeQkJKmRlYnVnX3Jvb3Q7DQo+ICsJdTMyCQkJZ3NidXNj
ZmcwX3JlcWluZm87DQo+ICB9Ow0KPiAgDQo+ICAjZGVmaW5lIElOQ1JYX0JVUlNUX01PREUgMA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLXhpbGlueC5jIGIvZHJpdmVycy91
c2IvZHdjMy9kd2MzLXhpbGlueC5jDQo+IGluZGV4IDYwOTVmNGRlZTZjZS4uYmI0ZDg5NGMxNmU5
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2R3YzMteGlsaW54LmMNCj4gKysrIGIv
ZHJpdmVycy91c2IvZHdjMy9kd2MzLXhpbGlueC5jDQo+IEBAIC0yNDYsNiArMjQ2LDMxIEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGR3YzNfeGxueF9vZl9tYXRjaFtdID0gew0K
PiAgfTsNCj4gIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIGR3YzNfeGxueF9vZl9tYXRjaCk7DQo+
ICANCj4gK3N0YXRpYyBpbnQgZHdjM19zZXRfc3dub2RlKHN0cnVjdCBkZXZpY2UgKmRldikNCj4g
K3sNCj4gKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gZGV2LT5vZl9ub2RlLCAqZHdjM19ucDsN
Cj4gKwlzdHJ1Y3QgcHJvcGVydHlfZW50cnkgcHJvcHNbMl07DQo+ICsJaW50IHByb3BfaWR4ID0g
MCwgcmV0ID0gMDsNCj4gKw0KPiArCWR3YzNfbnAgPSBvZl9nZXRfY29tcGF0aWJsZV9jaGlsZChu
cCwgInNucHMsZHdjMyIpOw0KPiArCWlmICghZHdjM19ucCkgew0KPiArCQlyZXQgPSAtRU5PREVW
Ow0KPiArCQlkZXZfZXJyKGRldiwgImZhaWxlZCB0byBmaW5kIGR3YzMgY29yZSBjaGlsZFxuIik7
DQo+ICsJCXJldHVybiByZXQ7DQo+ICsJfQ0KPiArDQo+ICsJbWVtc2V0KHByb3BzLCAwLCBzaXpl
b2Yoc3RydWN0IHByb3BlcnR5X2VudHJ5KSAqIEFSUkFZX1NJWkUocHJvcHMpKTsNCj4gKwlpZiAo
b2ZfZG1hX2lzX2NvaGVyZW50KGR3YzNfbnApKQ0KPiArCQlwcm9wc1twcm9wX2lkeCsrXSA9IFBS
T1BFUlRZX0VOVFJZX1UxNigic25wcyxnc2J1c2NmZzAtcmVxaW5mbyIsDQo+ICsJCQkJCQkgICAg
ICAgMHhmZmZmKTsNCj4gKwlvZl9ub2RlX3B1dChkd2MzX25wKTsNCj4gKw0KPiArCWlmIChwcm9w
X2lkeCkNCj4gKwkJcmV0ID0gZGV2aWNlX2NyZWF0ZV9tYW5hZ2VkX3NvZnR3YXJlX25vZGUoZGV2
LCBwcm9wcywgTlVMTCk7DQo+ICsNCj4gKwlyZXR1cm4gcmV0Ow0KPiArfQ0KPiArDQo+ICBzdGF0
aWMgaW50IGR3YzNfeGxueF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAg
ew0KPiAgCXN0cnVjdCBkd2MzX3hsbngJCSpwcml2X2RhdGE7DQo+IEBAIC0yODgsNiArMzEzLDEw
IEBAIHN0YXRpYyBpbnQgZHdjM194bG54X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpDQo+ICAJaWYgKHJldCkNCj4gIAkJZ290byBlcnJfY2xrX3B1dDsNCj4gIA0KPiArCXJldCA9
IGR3YzNfc2V0X3N3bm9kZShkZXYpOw0KPiArCWlmIChyZXQpDQo+ICsJCWdvdG8gZXJyX2Nsa19w
dXQ7DQo+ICsNCj4gIAlyZXQgPSBvZl9wbGF0Zm9ybV9wb3B1bGF0ZShucCwgTlVMTCwgTlVMTCwg
ZGV2KTsNCj4gIAlpZiAocmV0KQ0KPiAgCQlnb3RvIGVycl9jbGtfcHV0Ow0KPiANCj4gYmFzZS1j
b21taXQ6IDBiNThlMTA4MDQyYjBlZDI4YTcxY2Q3ZWRmNTE3NTk5OTk1NWIyMzMNCj4gLS0gDQo+
IDIuMzQuMQ0KPiANCg0KQmVzaWRlIGEgY291cGxlIHZlcnkgbWlub3IgY29tbWVudHMsIHRoaXMg
bG9va3MgZ3JlYXQgdG8gbWUhDQoNCkknbGwgYmUgb24gdmFjYXRpb24gaW4gYSBjb3VwbGUgb2Yg
ZGF5cywgY2FuIHlvdSBzZW5kIHY1IHNvb24/DQoNClRoYW5rcyENClRoaW5o

