Return-Path: <linux-kernel+bounces-519451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2640DA39D11
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE89F17571E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7BB2500BF;
	Tue, 18 Feb 2025 13:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mUMUe6n8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XSMjYXE1"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ECD2451EE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 13:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739883858; cv=fail; b=lanJs5W3//zEWji3wBYSnHLs4DlRU5LK1itPb3vD8z+4bRbeG+f3Te2HaVxiOAgO5snzgY6dXXxotwrBy+TiHNQG1meiktiT22xJCAKQ4QtdG45otQ7/3kMjV5SpnryAv8XE0WhhJgOmpE9CWL3g9xWqDqHruV9pvvQT03C01GI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739883858; c=relaxed/simple;
	bh=S5y4LOdLtngoaHdBdaeeJFNRMXYbGVJRcn1T8t/CQJg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version; b=fP6pIXaGwgH7MJO4Ddd4KJOlOGtGdGU94Ehm/RxorrZlX6MHf4sBEhh6LDVCH0Bj3tUftDFSpo6RaYrDuGgCIMmgoI3ADAlcAS86IdAww59MCKE7zNuAt2RNZTMxQumX99m16aTebLQKihQn9g7FhI3op2hWolhXLLkzV9XRWrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mUMUe6n8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XSMjYXE1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IBqCaP003256;
	Tue, 18 Feb 2025 13:04:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=jWyKh6ZASSYzcgOBYETdXLmRXHg80
	UBKXH1dnFpnumU=; b=mUMUe6n8GhX3p1AfB7i+N3jqLnMZexvqnMZQME6S3v8e2
	nF0kLT2ob5ggZlPHeLkAiqLSsRZErKjgn3WP6abEbk91RW5Pi7QyeeaJAHGEkvel
	D/iEdzjueMNFrTXfzr6MISCP7anw+Pua157hMpZN1YYgX+qM41KB8w5Ga95id0mK
	W4T6o7IpoeEC56UfRav1QAq0+AxxW9l0WTr4ovxr/zCFZ3E7oaXMvn67xGFX9Psj
	cWXuFsm2dFXdI6sbT3mgdGRkaSI+BbpD/yzi6gsMl0fBHEbQQEKSdE/g4ObSP1tj
	NADstxD9NtJNoZX0ftoSld8ZyAxnEJkZK/z6nL4LQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44thbcecv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 13:04:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51IC1eHa024955;
	Tue, 18 Feb 2025 13:04:08 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44thc90n4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 13:04:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dd4YxE9wfQuKuItZJAVSjBr9GJh90+Mm2L4LcLeAW+d70sz/QhCmflYKnhqZUpgC1oK5HOOgIYgBudbAayRV/eWvpsX3ch7BZ+N4VEdQHzeopMqNRNrx00uf9cieuU18a4gBLygCvIi30nUjFMzWMCGVRs+2ad8YzUE0XArlFQT+h3zhYa2ophlGLl0tb9PfD2nrf2wt7NBV1CyQ1nuhSKxjdiSCTXalnaZtzhGTB7Dz7K1Ab42UmptR+xf7R7RasPBDQbOS2n3ISqfuGJmeytQAWHD53rKOpHbd++Xk41D/0St4/ScS5mClCsKzd13ZVhOs1U0iRBaouaJ4P7EjhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWyKh6ZASSYzcgOBYETdXLmRXHg80UBKXH1dnFpnumU=;
 b=RBlO5rUWRm916TnLWJMvJBbvpuTDxmKl3g0nJmkVgGOA+qxwITxaahw6Jz2+WpxFxrAd3nVZKFRHLE1SCNFGw1hl7ZVgy0M38LhgwCfbnSAJXEBB75QUvW2Flp7ZI58wWrn8hp7ghekLLJO7ZF8sYeukKTLaXdq3+EItWH5wKESdmSXXTfMTrbQZa9TWJaNVKAqM9BD8uIjWBHOAUyljhAt77NMERRtgnh81tU1TD9mQFyf5TgrRAZ/5XGzynyYTvDgGRtZ1E9fzCwLTlcPDLckpb8ASVWknBvOU6aegpeifDeg5Dah5aGrWGgyHl7G/w2fgMm3onz0GezXZ8GqEUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWyKh6ZASSYzcgOBYETdXLmRXHg80UBKXH1dnFpnumU=;
 b=XSMjYXE15zyD5//ykKHXIwuZ4k9Ievj0bcFBUJPErhwiG4DQitTxO55V/TeFzDvY45fhpPhQSC+Yw6fzTqPik/1YhHNfF2QftTg49jajJES+d9sFeL1RWf+g2RlL3U8bgPIjMN43QAEIoA1eQnb2hwvO/xc7gj/vZGy+SEoVqB8=
Received: from PH0PR10MB5563.namprd10.prod.outlook.com (2603:10b6:510:f2::13)
 by CO1PR10MB4500.namprd10.prod.outlook.com (2603:10b6:303:98::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 13:04:06 +0000
Received: from PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240]) by PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240%5]) with mapi id 15.20.8445.016; Tue, 18 Feb 2025
 13:04:05 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: CVE-2024-56642: tipc: Fix use-after-free of kernel socket in
 cleanup_bearer().
Thread-Topic: CVE-2024-56642: tipc: Fix use-after-free of kernel socket in
 cleanup_bearer().
Thread-Index: AQHbggWWsw/GqqIyp0e6YQzWQdA/vw==
Date: Tue, 18 Feb 2025 13:04:05 +0000
Message-ID: <6ad79bb59b3535c9666ed5873dee4975f0745676.camel@oracle.com>
In-Reply-To: <2024122737-CVE-2024-56642-71ee@gregkh>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5563:EE_|CO1PR10MB4500:EE_
x-ms-office365-filtering-correlation-id: 7a596b5d-7d3a-4fa8-1b96-08dd501cb987
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L09PQnF4bnFPVGwrOXFBQ1p6NlMyNnEyVjZhYmFHQmxxazNKLzNOYWp6MGNL?=
 =?utf-8?B?eHJOcEVvVmdCUExYc1l6My9iQXZwSzZjcWY1ZkZUWlpaMExaYzJ6dnhpcCth?=
 =?utf-8?B?c2U1SjNwNkZqRTZWMmw5ZUpNNkRnMHBia1U0QitPZXk4am5PV2hlalZkSm44?=
 =?utf-8?B?by95ZjRXQ1dDYWcyVCtSV0dHQkRtV2dncVhLSUVKdzJQSU4xSDUwOGJ3MFBI?=
 =?utf-8?B?cm96VnRzdm1HOFoyeWREWGwwTUpBcnBLbVdtamJNMVo3SDk1SkZFc1A0Mldi?=
 =?utf-8?B?S2VsUm1PWGozWWNMSVNoY0F6ZXp3RHRKVWFySGR6c1lDeStWcXNMTkR4OFY1?=
 =?utf-8?B?TFVXOHVrR3I2eGVUczNsaWg1cnQ5dVEzY3EwSm1oeERlbEVRWjZ4TEZZbzFx?=
 =?utf-8?B?RjdTUENBekZ0c1h6SmtkUXhBVVZUL0Z5Ry9DR0pPMHJwN0wvTXFTN1RQMlJj?=
 =?utf-8?B?UFpFcEViNllpbEp1OG43cXBQRE82UVh5bmVmM2lRZjhOMzU2U0ZSN3ZYaEgy?=
 =?utf-8?B?aEVPSVBrQWRkTTZNZWYvdVNjYitFWDFsY1p4ZXJsenRtUHRZTC96WGN0RlZm?=
 =?utf-8?B?Z2FESDBFUFY3d0paRFVDam1SZW1jNWZPZEhUazN6QUpId3pOdEpkTHZNODJz?=
 =?utf-8?B?QzVZNEtVV09ubExTZldyQ245dmFaaXVZMmg3UU5BOWR0eDBBRlFNZDZBWGd4?=
 =?utf-8?B?bVloSTlVcnFQYW5BVGRheTBZbG1UOVRRWGVZZnFFZlZuWUJwTlZsbUpPVGV3?=
 =?utf-8?B?U1VXMWpXdnNqSi9HS2VDVkQvbng4VndwaHZTc2VGSzZ3SjZndkdnRDU4NTBD?=
 =?utf-8?B?eVJzQUhWNmRxUjNVNmFXT3FXQjZpbXF3ZEM2K2V0eXdLbGpWaDVQMk9Yd1p2?=
 =?utf-8?B?dHNGMmYxREt6OHluVnkwODZqV09hUDVld3NTcEYzZXVQS0ErUHZFaTlnc1hG?=
 =?utf-8?B?aTBiMW5xK1dzclk0V1JseGdpNGFkWE82cjJwd0VVbnZIaFUzVkllRGR5U21E?=
 =?utf-8?B?ZVZaNTEwSUpuc2lZeUhCTVo0TWJxbnIyU240K3BSV3I2RUE0dFlaZUZUK0g1?=
 =?utf-8?B?ZWF2eXkwdmc2YTlZa3pUcVlzS2J0aHJ0YzljOXdaWnZLT0g4YmY5QndBeVZ5?=
 =?utf-8?B?K2JIRzlJV3N0blA1VHdTZGoxSERlTUs5alc4ZE00WXVzUkJFa0pqMGlyZ1Fo?=
 =?utf-8?B?UkNVWnRid0tJNmlUa3hpVVRsa25IWW8zLy9lWDdOTUpybUNhYWVCZUF1dFBx?=
 =?utf-8?B?WnZpZzZBUzB4cEoyYVprU1BJSXJUM1pjYnJrbkIycUk1N2EvTkRBblNRWk1T?=
 =?utf-8?B?anhISnh5YVB4OVlGTkc4ZCthbCtTMUtyT1NMT1g4Qzd2bExrem1KVG1HSHNz?=
 =?utf-8?B?dGZKTmhyTWdNdjlvVTlhMGhocmRHMEFOdXh2N1M2bU5FeGJsWWV0Q0ZNeXFM?=
 =?utf-8?B?eVpqU3FJRGQ2bXJlekFqcTM1dGErWC9WWTVrNy9yOTVWTlBiNnVWRUxJWk83?=
 =?utf-8?B?ZWZlT2hZbnlwY2ZPaUNEZ3ZTVmQxV0tXem02aTFacGZlcTAxQkdkVEtaRk1s?=
 =?utf-8?B?VHN4c05zLzkxTGpiSVpFcGZQZzg5UUlsb0s1QWpMVlcwV2V2Z005QTdPa09q?=
 =?utf-8?B?ZmI4ak9ibkpXZXdlclV6bWpPNi8vUW1YbEtKZWk1TlAvZE9RTzk5YkpxYTJL?=
 =?utf-8?B?cndwTDNaYWpiTnk2eGw4TnZ1S0Y0blZsWm02VFZaQ2JEeDR4Qy8vUGR6NXZl?=
 =?utf-8?B?RlJQS3JVSEhibWIwTVdOVjEwMjNLRWtYelA1WDBCazVJZ3ZVRU03dWx0andD?=
 =?utf-8?B?R0w2eW5JVU83UTBpUURZYWw0clhHb3BXSDJkdEVUTElDU2E0OTJ2S1poTEhJ?=
 =?utf-8?B?R3pxVTR5NHArc0hja3gzekU2TkVSVzVPYzMrN2dLZTFPdTIrMmpJTVVTT0sw?=
 =?utf-8?Q?h7w8QhL9plIMqCh6vm3BhPsCOWpuiGRj?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5563.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(4053099003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bnBtUFNqaVEyNWl2SjJPUE5VUjh6dUxQR1JGN2pkdFc1RVVvMm1mV25YNXZG?=
 =?utf-8?B?NGIwdjEyVHBxa0JMMng3eEszdXF3eXhnWHdkZ3pZbDFKVnllTlNnQWx1OHFy?=
 =?utf-8?B?M3ZOa0tWN0J1UEI3QkVna0haTEVvNW04UU5tNDI3YUd3SlBmNDZUTVRzQTdD?=
 =?utf-8?B?K25SdlRaWGlqVVoyblRTWjRnTkt1V2o4UUtsQVNFb3VFUW4raXlKQ21nekRw?=
 =?utf-8?B?RGZiM1pKbStJdHFyUDRUeGp2Vzd1V09nN3ZyNXl2NHFtS1BMOWkvNDIyRjZm?=
 =?utf-8?B?NnNxWjBMRmJ3aS9SNG9wT0dDOVJSUjhFaVR5clRTdzU5MTBkdjBaTEFtOWRR?=
 =?utf-8?B?aVV3Q0tmMmxaQ2srNjRudGh5Q3QrOE5SUXlTV0h2UUFJKzJ4Y0RTUUpFT08v?=
 =?utf-8?B?L0JGT3Jzc2tDUjFvL0h3MGd4OTc3RjVpN1lVL2hiMjV1bWY3RytNSkhWVEY1?=
 =?utf-8?B?N3VKVXB2N25IL2NQakxsZVFucXZOQ0ZTTVcrTDBRdGJmeGVOTWtoUS9tTHox?=
 =?utf-8?B?K2FnZ2E1ZG1sOC9WQnJQTUhKMUtMMFFBRjNuWHJhS3BQSFlSN0FmTW4yZkNP?=
 =?utf-8?B?Y1lPdnZWTklyNFZHd21EYVpuZXowMVRWczBKNVZHVWhzazRacVpiaFlHcFFQ?=
 =?utf-8?B?eHVSQVRxNzdYWkdCUkhTeS8ycFZlYVlmY0VNemlrMlJRTE1GamZjVlpTNSs2?=
 =?utf-8?B?M015Z2pPRWlCS3d5eElzOHhXRzdhRVdDUGZ5KzJNZ0NhdmY2algrazJQUi9T?=
 =?utf-8?B?b29HQXJEU2x3Ynh0dTltQnErYmo1V1ZxQTFOa21FZ0FjQVNXMzdBbFpJeEtV?=
 =?utf-8?B?N243cWFSeXJ4VU83UTBjT09SS3BQTi9VUTZCL1QzaysyNkJYWDkwNkxNVE1D?=
 =?utf-8?B?eW9BVktPbUZYTHU2V3hFN3JsSVNXZFl4WGpDSnFhZjE5aFh4OHhEU1dJdzBM?=
 =?utf-8?B?NGFMTEJVejNqYnVicFlRT2lMclVLeW9nOW9GYW5pZ2Fhd21HWVFWd1RrQWIz?=
 =?utf-8?B?d00zSlBCYjU4cFFBZTgwUTN3Tyt4RW1pSVRjcjM1OWRHbXhKQTgzK2M4M3Ji?=
 =?utf-8?B?WTc3aFFKNFJHUUpyNm1OdHczdWthRXBrRmdtWVBMY1J4cEU4ZEpGekZQUitx?=
 =?utf-8?B?cFhvTWJWOW5RTGcrM1FCZ0JoOWttUjZxSU1jQ0cvZTFrR0JJS1hQbER1QXox?=
 =?utf-8?B?ZFcvK1h3WEIzMUFNeElXaDlaZU1LbFdSaTY1b05yYmJIWm1PWlpjMXBOUFRW?=
 =?utf-8?B?K3Zsd0RpdVQzSTAxVFQ5UmhBekE3djU5cjJzVVpMWkhKMHAzQjduNTJZWGJC?=
 =?utf-8?B?SEErWkVRcHJpZS9Vd1hSaW16U0wvQVdEeTR3eUt3bEFjSEdqRDZZZG9aZmVY?=
 =?utf-8?B?VWVmTVBYYytKRGRZWDFWZkQvd0dJclcyV1JRRmZGQlpSKzh0aC8zUkJYeWFs?=
 =?utf-8?B?dTVTc1QwU0d5eW9mMUE5UmNIa05iaFZyRjBkSFNLWUNxT1dzOU9HWWNoOUJm?=
 =?utf-8?B?ZlJ0OEM4dmdtY2R5cGtPWnVFV3lPSm03bmVmYmQ5SzYxci8veXV4VlFFNkMr?=
 =?utf-8?B?Y3BiSUk5UUhoUW85UEtKYVlLUThJOGt1TlkwSnhHVjhkbmthdW9PUXVxZldx?=
 =?utf-8?B?NXNQMEhTWEdjRHQ0aTgzaXRpT2YvbTNnQytXUUJoUlFmVHFqaVFuL0IrSys3?=
 =?utf-8?B?T0g3bTBkMzF6VVErL3h3aWUydGhOeGs3aU43ODBDV3ovdURFamxnelJHMnlO?=
 =?utf-8?B?ajNrSis4TDRmRTFsSzdyazQvVDVsc21LditMUWtJRGRqdTRPMU5LWW9SZzkz?=
 =?utf-8?B?M0VnMFFpUFBkZlNRcHRyL29maGgrUjJRY2laM05ueThtU241T05GN0hONkcx?=
 =?utf-8?B?S2FUY01jUVd0WXpqcXNRTXlpYkVNRit1N2dTT2JjekQ3SkJPRjJuTTkyMUgy?=
 =?utf-8?B?Ly9ZNzBhVCtWYlV1NGV6aUxGdHpnQXFUdTNNRHNSdGJUUjBwOEFjNEtneUs1?=
 =?utf-8?B?RTFjbmk3Y2w4Qnl4aU9FdE9RY2lWLzZUblZVbkprRkUrSFdNK05nU3hQQkFh?=
 =?utf-8?B?azVMV0tqSTYySHp2WTQ5aXhkNHZtckJOZ1J2bkFJVnpzeHl4b3hNVHZLTERG?=
 =?utf-8?B?cS9jRkJ2RDhVVTZnK1YybVVKbGJYOGYrODRCQk56RytwMDRvU0JybXFRQnJw?=
 =?utf-8?Q?mnWmrfvZvLXiLLyh/tJA7aerSAMbM6ZWCk3JwAlJFnRt?=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-Bv2C72bGLIDRYMSJ6EWw"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QFlLTd9M3/lqOO0it8CORPbMZzF7O4jGbbWrNCGhqcBbjSzhHuI2TaqwaQc7yJUY/i+8Bqvj87fTUObXpFt3zWLIscduBseS1wF7oceJtXh12mHnHU+56D5sAinhxOv1M4AeQLDuLhhPszayd99dbXBzqkvBMrFYk01MUoofxE/+0o4hP8giuDv2VQak8RfIiUjjx7CCNaOE0Xq2fpsdUYuZ9HjoAVsu2frAQc/bu3a8z7gYIa5HVeH0Nw0lBlcyI6ECGPI2mCLet6HiKXRVFkF56qjyZrXRmIih1zb8WRCqlhVi6rB7XpBOXlRdUq13r0k6quSu16Dqh2+l77QESZCCRek4MTwCK1pxhcu91p+DfH/TdyvdhVmO37jbVifq9JeIOk/JanRHckG7gFZIgq28XDPWP2LG9x7F1oy2OHxGOj1xgULoi8FFQqH1sW7lMx4p6OUcPAOvva63vhU1Mq/169UbzpklzQGW8dX3+BUhbm0UozsoepM3X3hhWlrFkJbk8Q9K4qhMSLHsaE7bG+wu3zQ5CNQhC9EJu5aDGjpD9x+tNc4eyNVf2kUaU5krwQNPgD669nAAdffXmKbeJOV5bREH+Fsd47i3DafnQwE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5563.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a596b5d-7d3a-4fa8-1b96-08dd501cb987
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 13:04:05.8389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aZHvboPbH+VFSq6Y2WtXA/6fdmDQv20OmtikRelIi+i7Lf/WvHzV544qIb/If9azN87lkf2R5ZGguMWrBfnSLjnsGlpBX2SPMW56EzV+qps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4500
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_05,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502180100
X-Proofpoint-GUID: AR_fQZGmZYq0IIRSr2Usd0zDecHfxm77
X-Proofpoint-ORIG-GUID: AR_fQZGmZYq0IIRSr2Usd0zDecHfxm77

--=-Bv2C72bGLIDRYMSJ6EWw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The commit message has:
> tipc: Fix use-after-free of kernel socket in cleanup_bearer().
>
> syzkaller reported a use-after-free of UDP kernel socket
> in cleanup_bearer() without repro. [0][1]
>
> When bearer_disable() calls tipc_udp_disable(), cleanup
> of the UDP kernel socket is deferred by work calling
> cleanup_bearer().
>
> tipc_net_stop() waits for such works to finish by checking
> tipc_net(net)->wq_count.  However, the work decrements the
> count too early before releasing the kernel socket,
> unblocking cleanup_net() and resulting in use-after-free.

This is incorrect, the function which waits is tipc_exit_net, which has
the spinning while loop.

That function is an exit function so this can't be triggered without
privileges.

Could it be grounds for rejection? Probably not but I thought I should
ask.

> Fixes: 26abe14379f8 ("net: Modify sk_alloc to not reference count the net=
ns of kernel sockets.")

The fixes tag is incorrect. It should be the commit which adds the
counter, which is:

04c26faa51d1 ("tipc: wait and exit until all work queues are done")

Maybe this needs to be corrected in the JSONs (as the commits are set
in stone).

Thanks,
Siddh

--=-Bv2C72bGLIDRYMSJ6EWw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAme0hTMACgkQBwq/MEwk
8iriBw/+IuPkY8qLsV/Z6xzW7OhanOhzEif0R/HgUiHWZtdGaOov5nZvpRoGq1si
/qLsznv2Fo4N9VuHtG83Jga1goEpupXOQD0Jt2eDtEeS6lobALxpQLlaS7onfGVZ
vJGaXm5ILyX1bwkDNGqMr9r8PCKjqg+ANBrrSgYsapmhABbAug516d3uvLZdrlsZ
gADSjNLgMzKKHufhXUgcL4uTYZqm5Mtia4V0Pvdkard4q9pCqj+z/WG226WEMM8w
3levrM0bPiCnmkbGSxUjkLVOItuFTEP/GD6iaDJPeo8K68DaXggN027Hh/1dpVJZ
AaUrQkfmyzmEQ+ONt97lVrCXUnwAfNjkQXUVnNbrEtEJdYITvTZudICpoXeQT/Fg
Q+meRsje+3WPn6ZQH6d+WsObxscLunkZMMm/cFMUKuBLP3/WMYcHZ7mzw0iHwiGv
i/vjn24cYVxayJfMAoSxzoTCl9T0GsCk0BToOT9QvaNFXhTZ5Y3cBRvaVRYme0Z2
AzgGjjBzOeNrGUsFHmhvu3/FLwz/yg5jsHe8/OoD4tEdvOnqYVoBstisbgkUGyG/
2MCsEOlr3ARbJtJMOMtF0nqZT3nq+knYI+rD48MoNOl+/v6VDsALYiCMj0m7Rlwp
VMYrJB2EPPObX1X81YbFrfUPIuPsm4zXFiUlnzrxA5UD62qVZeY=
=DxD1
-----END PGP SIGNATURE-----

--=-Bv2C72bGLIDRYMSJ6EWw--

