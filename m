Return-Path: <linux-kernel+bounces-201750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C03448FC2CB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 06:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 793D0284EC6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 04:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA74012F5A6;
	Wed,  5 Jun 2024 04:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="b5OLDjs1"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB708624;
	Wed,  5 Jun 2024 04:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717562666; cv=fail; b=igx/W9NJho1GngBtQie2tbcV0TiiDnxZjr2ItF2V220zDUmp6MSSQxKFmzacF2rt7faSgy5c4Wl/e7KUcHK1Q/tF3wmPbKnv9dKsG1DIFRMgTbJ+iY6iWigQH2onSgM7EBTnWiyJThqf5oiSE7GTYwaDzY5sUtw3Go/glodcWo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717562666; c=relaxed/simple;
	bh=vn9U0mtb25kX9q2S3gI1nPt6eJRO1mh6g4gvRrVRuLs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iCAryiW06udGwWhLyUa7DE56jx4Xd6NQ3/p8mMNDtenIsdinR1DN/ritxru2luZ/6Br3PuN1QXg74LGNbhxOL4LoieVGQU6bb+4j9gowzVQTijeZOfe/fAR50vkKItvDMTMhZT3UcxRMpMwk2ekdr6Mpm0pxSJb8ixyNRMSSFkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=b5OLDjs1; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 454L558Q004134;
	Tue, 4 Jun 2024 21:44:11 -0700
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yj167bw7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 21:44:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5NyJVKthrrISrCbJYwCS85enWSWLdIIZKFS2+eNUgEGarZ+WEub/fEQtZ/Sc1LSsIQrwxAR0juU3dAC6htxbRDWMDc68vABr8j5nkYig5ezVgx8lhUTasgZjiNGbo2WyskU8Rjr7O/fJfCABXIzjqhVaggEfvzWFrQaNU6cBQHHxXoL94CexbsSOYVdHAMh2zj+h6yVDaF7ueGZJgb3IM+9be790oREM+tZ8t4mPCAd1myiYCt30gFxbBCl/07BbOn1Wb1BuntaD61qQOLRiivKhv1I+IrvSaasvhbThKCexaEAGHZkDLy0ybyaYhwK41qRec8EAQGWmHAZhErAvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vn9U0mtb25kX9q2S3gI1nPt6eJRO1mh6g4gvRrVRuLs=;
 b=SR2g9R4zVb+KFECxyn5W6LZo1fI6uC69h3L7bMkF/mssA3abdgdDYFui12RaUqPZ0sfLeKFSeH840gNL3L+K6zaTkYH8gnvKENRXD8c/CjE4nxmiMFBEsqIDlU0RxQg8wATtIWQ104Y1Vy108SpLF2wOYLUpacVPq2t6MPneBAlyaqYDXndFpN+ztEd0AzgCBC0qoieahL8+n2JsAizDQNzFD9z7BmNqzJkp4qdrbWMxJH4+CCTYKbMtIwOXxFVKg8CRIKga1wqyLqA2dVYGEYHHifd+XAYj2O76ZUMm6+FU/fA4we4hG38euxUx/sqg1PyUQy4A43pReEW3FXp/Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vn9U0mtb25kX9q2S3gI1nPt6eJRO1mh6g4gvRrVRuLs=;
 b=b5OLDjs1+RKbqNbCsWONlFw10F6X2ACRGLB9VhSdKEItfeE09t8NZBM5w37aKd1jpTiKp4ZFMfiUKD3tt4fHRwqQ4CgGp12ZA6jZIpE2KUSIYt9ge8985a5D/9B9q+HFFkyFbJBFNdTwB6+DZvBqzTRqyl9n1S592Pz+1lcrU0c=
Received: from LV8PR18MB5914.namprd18.prod.outlook.com (2603:10b6:408:226::21)
 by BY5PR18MB3764.namprd18.prod.outlook.com (2603:10b6:a03:24e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 04:44:07 +0000
Received: from LV8PR18MB5914.namprd18.prod.outlook.com
 ([fe80::30f2:fc3d:f58e:8305]) by LV8PR18MB5914.namprd18.prod.outlook.com
 ([fe80::30f2:fc3d:f58e:8305%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 04:44:07 +0000
From: Linu Cherian <lcherian@marvell.com>
To: James Clark <james.clark@arm.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "coresight@lists.linaro.org"
	<coresight@lists.linaro.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        George Cherian <gcherian@marvell.com>,
        "suzuki.poulose@arm.com"
	<suzuki.poulose@arm.com>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>
Subject: RE: [EXTERNAL] Re: [PATCH v8 6/7] coresight: tmc: Stop trace capture
 on FlIn
Thread-Topic: [EXTERNAL] Re: [PATCH v8 6/7] coresight: tmc: Stop trace capture
 on FlIn
Thread-Index: AQHasxL7d6JCRb24DEOQhJ4zl12J67GxIR0AgAd+jaA=
Date: Wed, 5 Jun 2024 04:44:07 +0000
Message-ID: 
 <LV8PR18MB5914E758322FBAC07867CB07CEF92@LV8PR18MB5914.namprd18.prod.outlook.com>
References: <20240531042745.494222-1-lcherian@marvell.com>
 <20240531042745.494222-7-lcherian@marvell.com>
 <1a093631-ded2-4ef3-b72c-3aaffd1b0739@arm.com>
In-Reply-To: <1a093631-ded2-4ef3-b72c-3aaffd1b0739@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR18MB5914:EE_|BY5PR18MB3764:EE_
x-ms-office365-filtering-correlation-id: 69b1f046-ea16-4ea6-6f98-08dc851a2252
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|366007|376005|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?c1gydW8vVG1DMlQrWHNxWkgyRjdWSmEyS3M0dzFQa0ZDeWxCSUZ6dHkzaTJa?=
 =?utf-8?B?emtZWnBNd2JURlIxTHljazRGVEVKRllwTU9RN0ZOYTBpVmRneVhnWm56bU1n?=
 =?utf-8?B?Tit2ZW13RG00ZFc0WmczRFc4RzVlaUltRzhZR1FzUkc4UTVPU1ZMTkpJTnlP?=
 =?utf-8?B?cjJTZUh5QTBVM3lNWkZrUTBaai9xb2hsdHdqZkViWVF0ZVpLTTVXUy9uaUUr?=
 =?utf-8?B?RXJoK3MzcG84aGlXM1lIeDZPMjY0M1hpcmhHMkRmclB6YXVjT1hocjZHZ1Er?=
 =?utf-8?B?MGY4ZVhzVXJqc09weVh0QWRFZDQ0RVEwNVZUeFpITVRaRVEvdThhWkljYTV2?=
 =?utf-8?B?NWF6OElqSTNNZzFiczZrV2xvWm1PVnVxb3J1d2NJdG4zc21mR1dONmhLbVAy?=
 =?utf-8?B?UDlUUE4rL2NzbGhSaXFvdVU5Y2MvT1BaUDVWRzZVZi9iVGhjejJ1L3RGNTRq?=
 =?utf-8?B?ajMveFk1aUFYOUkzYUo4K000M0xSZE5EMDY3UStyRjFqU3pMbkhUME92TWY1?=
 =?utf-8?B?azNRTXFpM0hKZG1EOTlYR2dOcmN4WWt4MjdBNDc0QzF5aWlTNGxUZUhsR2w5?=
 =?utf-8?B?c0RvbnZRanNmbXV5MnJySHIvUjBnQnNwMk1JZ2F1UHN2ekNxNzdxSnJGbFpj?=
 =?utf-8?B?eUJMU1YzbkxJSWxpQVFvOGVjbjFtUE9QYlBaenRnczFLTUVNNXlFR1Z6bnBn?=
 =?utf-8?B?dDF5QUViOTFobHU4eGw3MlFqYk01U2V1Y3hoSWgrMjUxTEYyeUdyeDZseVdy?=
 =?utf-8?B?TjBPZWhqOEZQUnlibCtXcGpSZjlCdG5RNHZhV1dJZVVpTmNtTkFGZHlIVUxI?=
 =?utf-8?B?TkFlVlJLRnlETEIxbGNqOUx0NGRWZENBQ0t0VzlHVFlxRDlLYytFaWNDc0xF?=
 =?utf-8?B?c0RzVnB3YW1kYUNRMVN5Y1pYMmhMT3dhL1FodGJwOUkyNmFCN3I5QlFnQzBy?=
 =?utf-8?B?STBEWFMwb2c1VTllRjJubG1aNkRweEFqOTV3dmg3MmtldElpbFpPeEFrU3VV?=
 =?utf-8?B?MEdmRXVhemh1Y3NqOWc4bmZpcmRPQUJlOVBMb2hsQ0ZtbTdRYUdndEpVbVNT?=
 =?utf-8?B?NlhpK0EvVlR0TVpFbWlkWUgweGJuUVJNbHRGTVg1bHZ0RGZNa044TzI0MUZ6?=
 =?utf-8?B?STRsalF4VjhWZVAwakpYNmJrY041OC9qUUZMTXdId0VzTk9pTzNKcW40VmlN?=
 =?utf-8?B?SnJRU0w5bEhvSVhibVR2WWxYQzVWYXVYM2lIeEhqQWFHY09wVVVQTVpzbGUw?=
 =?utf-8?B?Zk5ocFd5Q3RUMC95c2RDVjMyMmVhL2ZxL2lMczNwUXF1L1d4VHM0dEorM01l?=
 =?utf-8?B?RlVPOStlTW5pR3ZWRDY2NHNEcGZ6cWNrZXhkTDhuYnN3UUs2TzV1anArczMz?=
 =?utf-8?B?eExzbXFCQWR3aDAwaFk5d0xpdnlaL3ZRYVBWbE5Xa0F1R0pHMzZkaDRESFI1?=
 =?utf-8?B?VEp5disvVVliSWxLVkkvWjBENHl0UjU5Ry9VMTlHaHFOei9JeE9WWGVBRTB4?=
 =?utf-8?B?UWtWWEpnMnd6OC9pZS9zMllJK0hlMXlta1htZHVMbWlsNG5NTUltT1U0dVE1?=
 =?utf-8?B?WHhFRzlUVk9TcWRFL2xEOEJUVk1CRWxwbmFnQmhhUXZGdS8xVC9jeU91aVc0?=
 =?utf-8?B?TlZUd1I0OExEdGNoRm1GVjhxcGE2d0ZmSUNWRGs3SDFpT05EZis1WjY4OCtL?=
 =?utf-8?B?ZjZXUEtjSTJhZWdyRkxnNnk2VkU3REVuNnNRY3ZHbTZUcFhvK0tzVDVSUTk5?=
 =?utf-8?B?NWxLQnVHZ0ZDejc2MkVDaDlsZTNRRldmNktZdmJHVEVnTXYyM1BnbXJPaHpu?=
 =?utf-8?B?aGpQUkxCdFV4NDBoOEhndz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR18MB5914.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TDFKZUxkUG5yeFRYYUFXbEN1UnQwVzlML2t2ZVFwN2R0UDRCYTFyN0pqL0Vn?=
 =?utf-8?B?OHVwWTROdzAyUGw1RzQ0cENlRU5PMHY1VmxxZUtMY0w0RkI1NTR5M1dwd0Vn?=
 =?utf-8?B?OFUwWC9KZ0NpS1ZYZnpFYXJPSUZTYjFIN2FRY2lYeWh6Y1ExMFBqdnM1azR6?=
 =?utf-8?B?MjBUNE9nay91U3VIR0p2ZFZWZkd4UDd5RU0yenRKTWJFNFNteDdGbWxkNWtD?=
 =?utf-8?B?N2l5MmE2OW9FNEdEdG03a0dzZm5wdlo0akovVGlUT0NQeDFXOFB3NFhZdXFk?=
 =?utf-8?B?VEZnSmlUYUJIQkY0ZFVoNW9hWFlDQi96Tnc5bWw4TEU4dlVwWGNTU01lTG5m?=
 =?utf-8?B?WDE3QjhjWHZ1eHBUWEI3ck5NUnFpaEF5WVFOWkJ5WjhuVUxJSmpYTXMzQkxx?=
 =?utf-8?B?ck1VV3BtVlJHeC8xMkZOeHZPVm1udmpPVktyWk52aHdWYVRoQ0F1UTlDRGl4?=
 =?utf-8?B?V0ZmTXJ0UnN3d3k2WHo5Q1FWNlNoNk5aUU5WRzdLZEpmdHY2MVpXbU10cnJD?=
 =?utf-8?B?YUpqUjE0TGdTVzNudGdUd0pNTFl3eW9tVzM1QTFrTmV5clJWMnI0dE5weTY3?=
 =?utf-8?B?dER1SUM1NDRnL3FoRjN0L1dId3ZBV21QdVpJM3lyK1VpSVJBN2lLbUNBUEVE?=
 =?utf-8?B?NzhtTnNrc2dkSVUyVmFtN2FjL0ZOQ0xTMGdBQ09wQ1F0cnhaam5vVmF0VE5K?=
 =?utf-8?B?NXgwRmRmNDYwaVRZUlo3NklJNWxKdzZxUFhOcHJsMnhHMkIzZmMrVFk2cFRp?=
 =?utf-8?B?UlNRRmR4Y3R2cStEM082S3NvVTYwTlVBbWFhSDc1VTQwK1JEc3hZaksxZDlL?=
 =?utf-8?B?SEtVTWxINzJvVm5TVTN6YkwxSnRDMEZnQ1ljd1h6NDJTTmFNQ2lvRk5PeHlr?=
 =?utf-8?B?bHZKbG40cVAxUUtQYUZQdVBhb0h4UjJGaUtiS3dvNGpzaWRpTmdCcU4yY1l4?=
 =?utf-8?B?ZXNoQ0FiYW16bVJIY0JpU21BS3BYTmtPQ2QvZnQ2MUF1aUhqazBRRlgyaDJJ?=
 =?utf-8?B?QWRFNEtoWXVnM20yN2NHZVlaNWdnMmhqVjM5bFptb2J0bC8xZ2hHdmZXSlBk?=
 =?utf-8?B?V1JGSTNSdW9ZdmJ0QnZBVWNQdE5CZ3RqVTFFaXBZcTdjVXhSNTdOc0tpNHo1?=
 =?utf-8?B?SStQcWRBSTBCQ3FENXBna1J2SXlyZFQvbFNIa3lsckJ5Q2FpV1dpNGZ6TGJY?=
 =?utf-8?B?WGUyMGp5R0RTS3NLNm1iZmZuTysrSHg2R2wyT2VETnM5SHNST3NuWEZkaExN?=
 =?utf-8?B?cHRMY011bEFJMy9QVmovVkYvYVJMRmsxVUloM2dGTXc2czMxSHNMeEluZWVq?=
 =?utf-8?B?elhhOVk2alFsTy9RMmNLTDljbndJQ05oVExvMS9KdzlrdEkyanNoRkpNQVBr?=
 =?utf-8?B?QlFvT3FqMGF2S1diRFloU3JuYm5GTlRXL2JJVXZtVlhlVVhxS2tXTHVORExN?=
 =?utf-8?B?RTdjNXhLcjEyZHJ6c0FWUDRSWllLODhxT1hRa2pyVm9WSUtSY3FjL1MrS1dL?=
 =?utf-8?B?ZzlONFBIRTQxN0JUbjVaaEVUL2tCWnd0dkpDWms3aWV3TWcrT0JtUXU1V2tK?=
 =?utf-8?B?dkxTbWttUjlaYnVCYXZkN0hPVVlIWWlpN1QwdzcxbHltdG0rNlFKS1RrWExa?=
 =?utf-8?B?bXZ1Q2RHZis2ek1xNXp0OUxNV1h2V3RqbS8xUmhEM1BGK1NQLzk3Y3dUbGNN?=
 =?utf-8?B?a0YrTExSNDd1V3cvdGRYalYzblBtYnVhTmk1bzZjYnNzZ1dib1hsMkh5eUM2?=
 =?utf-8?B?K3FYVFFKODZ5Q0ZITzVOdStaM3BuQmJBbnpZV3Q2eURWSVNUMWFwZnZ4WXJR?=
 =?utf-8?B?UUlCVWhuRUV5WXBLK3dSWjQycUVkNXZOS0JkM2FENWZKVTZBRjY3bVVob25D?=
 =?utf-8?B?RjkxajhDYmFjcGh5ZncrczVVRHlZbUdIRnBBZWs0RVU4ZFk0Q2J3d1BlQ1pj?=
 =?utf-8?B?aTV4N3FLVHM2TU0yNURzOWdMNUZ4eDA3RFd2MFp0RkZPaXAyY3p1VUVrL3Ry?=
 =?utf-8?B?Wkt4RnJiek5IQU1IbDhBYkRmcW5OdG5KOXhXajg5N0k5MUVRYyt2YndXdW1M?=
 =?utf-8?B?ZnVoWW5nQllRcFNzczBKL1Nuc1JWOTJYdjVFUmxoUUlEcjArcHFaWitXdDVt?=
 =?utf-8?Q?PPaGcXFwbVkGNGIVrlwoCX1XC?=
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
X-MS-Exchange-CrossTenant-AuthSource: LV8PR18MB5914.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b1f046-ea16-4ea6-6f98-08dc851a2252
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 04:44:07.1217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1EJiPKeXQew9wuVYunjOAvBZKKn2zG/JcEq0sTiYCsRtphQXVpQJ/L0zFHybrcaF25jOo3qkrs6V5Uc2hCx7gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3764
X-Proofpoint-ORIG-GUID: giNihqPvRHBJrbdqA6yYOudWGaiJHCWZ
X-Proofpoint-GUID: giNihqPvRHBJrbdqA6yYOudWGaiJHCWZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-04_02,2024-05-17_01

SGkgSmFtZXMsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFtZXMg
Q2xhcmsgPGphbWVzLmNsYXJrQGFybS5jb20+DQo+IFNlbnQ6IEZyaWRheSwgTWF5IDMxLCAyMDI0
IDM6NDcgUE0NCj4gVG86IExpbnUgQ2hlcmlhbiA8bGNoZXJpYW5AbWFydmVsbC5jb20+DQo+IENj
OiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGNvcmVzaWdodEBsaXN0cy5s
aW5hcm8ub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgcm9iaCtkdEBrZXJu
ZWwub3JnOw0KPiBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7IGNvbm9yK2R0QGtl
cm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBTdW5pbCBLb3Z2dXJpIEdv
dXRoYW0NCj4gPHNnb3V0aGFtQG1hcnZlbGwuY29tPjsgR2VvcmdlIENoZXJpYW4gPGdjaGVyaWFu
QG1hcnZlbGwuY29tPjsNCj4gc3V6dWtpLnBvdWxvc2VAYXJtLmNvbTsgbWlrZS5sZWFjaEBsaW5h
cm8ub3JnDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCB2OCA2LzddIGNvcmVzaWdo
dDogdG1jOiBTdG9wIHRyYWNlIGNhcHR1cmUgb24NCj4gRmxJbg0KPiANCj4gUHJpb3JpdGl6ZSBz
ZWN1cml0eSBmb3IgZXh0ZXJuYWwgZW1haWxzOiBDb25maXJtIHNlbmRlciBhbmQgY29udGVudCBz
YWZldHkNCj4gYmVmb3JlIGNsaWNraW5nIGxpbmtzIG9yIG9wZW5pbmcgYXR0YWNobWVudHMNCj4g
DQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCj4gDQo+IA0KPiBPbiAzMS8wNS8yMDI0IDA1OjI3LCBMaW51IENo
ZXJpYW4gd3JvdGU6DQo+ID4gQ29uZmlndXJlIFRNQyBFVFIgYW5kIEVURiB0byBmbHVzaCBhbmQg
c3RvcCB0cmFjZSBjYXB0dXJlIG9uIEZsSW4NCj4gPiBldmVudCBiYXNlZCBvbiBzeXNmcyBhdHRy
aWJ1dGUsDQo+ID4gL3N5cy9idXMvY29yZXNpZ2h0L2RldmljZXMvdG1jX2V0WG4vc3RvcF9vbl9m
bHVzaC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IExpbnUgQ2hlcmlhbiA8bGNoZXJpYW5AbWFy
dmVsbC5jb20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlbG9nIGZyb20gdjc6DQo+ID4gKiBIb25vdXIg
c3RvcF9vbl9mbHVzaCBzeXNmcyBhdHRyaWJ1dGUgZm9yIHBlcmYgc2Vzc2lvbnMgYXMgd2VsbC4N
Cj4gPiAgIFRoaXMgYWxsb3dzIHVzZXIgdG8gc3RhcnQgdHJhY2Ugc2Vzc2lvbnMgdXNpbmcgcGVy
ZiBtZXRob2QgYXMNCj4gPiAgIHdlbGwgdG8gdXNlIHRoZSBDb3Jlc2lnaHQga2VybmVsIHBhbmlj
IHN1cHBvcnQuDQo+ID4NCj4gPiAgLi4uL2h3dHJhY2luZy9jb3Jlc2lnaHQvY29yZXNpZ2h0LXRt
Yy1jb3JlLmMgIHwgMzENCj4gKysrKysrKysrKysrKysrKysrKw0KPiA+ICAuLi4vaHd0cmFjaW5n
L2NvcmVzaWdodC9jb3Jlc2lnaHQtdG1jLWV0Zi5jICAgfCAxOCArKysrKysrKy0tLQ0KPiA+ICAu
Li4vaHd0cmFjaW5nL2NvcmVzaWdodC9jb3Jlc2lnaHQtdG1jLWV0ci5jICAgfCAxOCArKysrKysr
Ky0tLQ0KPiA+ICBkcml2ZXJzL2h3dHJhY2luZy9jb3Jlc2lnaHQvY29yZXNpZ2h0LXRtYy5oICAg
fCAgNCArKysNCj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCA2MSBpbnNlcnRpb25zKCspLCAxMCBkZWxl
dGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2h3dHJhY2luZy9jb3Jlc2ln
aHQvY29yZXNpZ2h0LXRtYy1jb3JlLmMNCj4gPiBiL2RyaXZlcnMvaHd0cmFjaW5nL2NvcmVzaWdo
dC9jb3Jlc2lnaHQtdG1jLWNvcmUuYw0KPiA+IGluZGV4IGFhYTlkZTlmNGNkMi4uMjRlZGQ5ZDc1
MGMzIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaHd0cmFjaW5nL2NvcmVzaWdodC9jb3Jlc2ln
aHQtdG1jLWNvcmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvaHd0cmFjaW5nL2NvcmVzaWdodC9jb3Jl
c2lnaHQtdG1jLWNvcmUuYw0KPiA+IEBAIC00NTIsOSArNDUyLDQwIEBAIHN0YXRpYyBzc2l6ZV90
IGJ1ZmZlcl9zaXplX3N0b3JlKHN0cnVjdCBkZXZpY2UNCj4gPiAqZGV2LA0KPiA+DQo+ID4gIHN0
YXRpYyBERVZJQ0VfQVRUUl9SVyhidWZmZXJfc2l6ZSk7DQo+ID4NCj4gPiArc3RhdGljIHNzaXpl
X3Qgc3RvcF9vbl9mbHVzaF9zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPiArCQkJCXN0cnVj
dCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBjaGFyICpidWYpIHsNCj4gPiArCXN0cnVjdCB0bWNf
ZHJ2ZGF0YSAqZHJ2ZGF0YSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYtPnBhcmVudCk7DQo+ID4gKw0K
PiA+ICsJcmV0dXJuIHNwcmludGYoYnVmLCAiJSN4XG4iLCBkcnZkYXRhLT5zdG9wX29uX2ZsdXNo
KTsgfQ0KPiA+ICsNCj4gPiArc3RhdGljIHNzaXplX3Qgc3RvcF9vbl9mbHVzaF9zdG9yZShzdHJ1
Y3QgZGV2aWNlICpkZXYsDQo+ID4gKwkJCQkgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIs
DQo+ID4gKwkJCQkgY29uc3QgY2hhciAqYnVmLCBzaXplX3Qgc2l6ZSkNCj4gPiArew0KPiA+ICsJ
aW50IHJldDsNCj4gPiArCXU4IHZhbDsNCj4gPiArCXN0cnVjdCB0bWNfZHJ2ZGF0YSAqZHJ2ZGF0
YSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYtPnBhcmVudCk7DQo+ID4gKw0KPiA+ICsJcmV0ID0ga3N0
cnRvdTgoYnVmLCAwLCAmdmFsKTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJcmV0dXJuIHJldDsN
Cj4gPiArCWlmICh2YWwpDQo+ID4gKwkJZHJ2ZGF0YS0+c3RvcF9vbl9mbHVzaCA9IHRydWU7DQo+
ID4gKwllbHNlDQo+ID4gKwkJZHJ2ZGF0YS0+c3RvcF9vbl9mbHVzaCA9IGZhbHNlOw0KPiA+ICsN
Cj4gPiArCXJldHVybiBzaXplOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgREVWSUNFX0FU
VFJfUlcoc3RvcF9vbl9mbHVzaCk7DQo+ID4gKw0KPiA+ICsNCj4gPiAgc3RhdGljIHN0cnVjdCBh
dHRyaWJ1dGUgKmNvcmVzaWdodF90bWNfYXR0cnNbXSA9IHsNCj4gPiAgCSZkZXZfYXR0cl90cmln
Z2VyX2NudHIuYXR0ciwNCj4gPiAgCSZkZXZfYXR0cl9idWZmZXJfc2l6ZS5hdHRyLA0KPiA+ICsJ
JmRldl9hdHRyX3N0b3Bfb25fZmx1c2guYXR0ciwNCj4gPiAgCU5VTEwsDQo+ID4gIH07DQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9od3RyYWNpbmcvY29yZXNpZ2h0L2NvcmVzaWdodC10
bWMtZXRmLmMNCj4gPiBiL2RyaXZlcnMvaHd0cmFjaW5nL2NvcmVzaWdodC9jb3Jlc2lnaHQtdG1j
LWV0Zi5jDQo+ID4gaW5kZXggNjU1YzBjMGJhNTRiLi4xNTI5YjljYzIxMGEgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9od3RyYWNpbmcvY29yZXNpZ2h0L2NvcmVzaWdodC10bWMtZXRmLmMNCj4g
PiArKysgYi9kcml2ZXJzL2h3dHJhY2luZy9jb3Jlc2lnaHQvY29yZXNpZ2h0LXRtYy1ldGYuYw0K
PiA+IEBAIC0xOSw2ICsxOSw3IEBAIHN0YXRpYyBpbnQgdG1jX3NldF9ldGZfYnVmZmVyKHN0cnVj
dA0KPiA+IGNvcmVzaWdodF9kZXZpY2UgKmNzZGV2LCAgc3RhdGljIGludCBfX3RtY19ldGJfZW5h
YmxlX2h3KHN0cnVjdA0KPiA+IHRtY19kcnZkYXRhICpkcnZkYXRhKSAgew0KPiA+ICAJaW50IHJj
ID0gMDsNCj4gPiArCXUzMiBmZmNyOw0KPiA+DQo+ID4gIAlDU19VTkxPQ0soZHJ2ZGF0YS0+YmFz
ZSk7DQo+ID4NCj4gPiBAQCAtMzIsMTAgKzMzLDEyIEBAIHN0YXRpYyBpbnQgX190bWNfZXRiX2Vu
YWJsZV9odyhzdHJ1Y3QNCj4gdG1jX2RydmRhdGEgKmRydmRhdGEpDQo+ID4gIAl9DQo+ID4NCj4g
PiAgCXdyaXRlbF9yZWxheGVkKFRNQ19NT0RFX0NJUkNVTEFSX0JVRkZFUiwgZHJ2ZGF0YS0+YmFz
ZSArDQo+IFRNQ19NT0RFKTsNCj4gPiAtCXdyaXRlbF9yZWxheGVkKFRNQ19GRkNSX0VOX0ZNVCB8
IFRNQ19GRkNSX0VOX1RJIHwNCj4gPiAtCQkgICAgICAgVE1DX0ZGQ1JfRk9OX0ZMSU4gfCBUTUNf
RkZDUl9GT05fVFJJR19FVlQgfA0KPiA+IC0JCSAgICAgICBUTUNfRkZDUl9UUklHT05fVFJJR0lO
LA0KPiA+IC0JCSAgICAgICBkcnZkYXRhLT5iYXNlICsgVE1DX0ZGQ1IpOw0KPiA+ICsNCj4gPiAr
CWZmY3IgPSBUTUNfRkZDUl9FTl9GTVQgfCBUTUNfRkZDUl9FTl9USSB8DQo+IFRNQ19GRkNSX0ZP
Tl9GTElOIHwNCj4gPiArCQlUTUNfRkZDUl9GT05fVFJJR19FVlQgfCBUTUNfRkZDUl9UUklHT05f
VFJJR0lOOw0KPiA+ICsJaWYgKGRydmRhdGEtPnN0b3Bfb25fZmx1c2hfZW4pDQo+ID4gKwkJZmZj
ciB8PSBUTUNfRkZDUl9TVE9QX09OX0ZMVVNIOw0KPiA+ICsJd3JpdGVsX3JlbGF4ZWQoZmZjciwg
ZHJ2ZGF0YS0+YmFzZSArIFRNQ19GRkNSKTsNCj4gPg0KPiA+ICAJd3JpdGVsX3JlbGF4ZWQoZHJ2
ZGF0YS0+dHJpZ2dlcl9jbnRyLCBkcnZkYXRhLT5iYXNlICsgVE1DX1RSRyk7DQo+ID4gIAl0bWNf
ZW5hYmxlX2h3KGRydmRhdGEpOw0KPiA+IEBAIC0yMjUsNyArMjI4LDggQEAgc3RhdGljIGludCB0
bWNfZW5hYmxlX2V0Zl9zaW5rX3N5c2ZzKHN0cnVjdA0KPiBjb3Jlc2lnaHRfZGV2aWNlICpjc2Rl
dikNCj4gPiAgCQl1c2VkID0gdHJ1ZTsNCj4gPiAgCQlkcnZkYXRhLT5idWYgPSBidWY7DQo+ID4g
IAl9DQo+ID4gLQ0KPiA+ICsJaWYgKGRydmRhdGEtPnN0b3Bfb25fZmx1c2gpDQo+ID4gKwkJZHJ2
ZGF0YS0+c3RvcF9vbl9mbHVzaF9lbiA9IHRydWU7DQo+IA0KPiBEb2VzIHRoaXMgZG8gYW55dGhp
bmcgZGlmZmVyZW50IHRoYW4gb25seSB1c2luZyBzdG9wX29uX2ZsdXNoIGluDQo+IF9fdG1jX2V0
cl9lbmFibGVfaHcoKT8NCj4gDQo+IFNlZW1zIGxpa2Ugc3RvcF9vbl9mbHVzaF9lbiA9PSBzdG9w
X29uX2ZsdXNoIHdoZW5ldmVyDQo+IHN0b3Bfb25fZmx1c2hfZW4gaXMgcmVhZCwgc28geW91IG1p
Z2h0IGFzIHdlbGwganVzdCByZWFkIHN0b3Bfb25fZmx1c2ggYW5kDQo+IGdldCByaWQgb2YgdGhl
IF9lbiBjb3B5Pw0KPiANCg0KQWNrLg0KDQoNCg==

