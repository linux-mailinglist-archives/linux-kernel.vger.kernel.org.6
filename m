Return-Path: <linux-kernel+bounces-401018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9109C1509
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 05:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 720411C2441C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9284E1C462D;
	Fri,  8 Nov 2024 03:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="lnyqUXcU"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0ABE13AA5D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 03:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731038370; cv=fail; b=YiU/AB4a0+vjeiSmMZoFQSA50N1+BOONjhHuYBdTLGB3aUftrUg2Wg9DCFOML4Uppft7Gx5gEfxfiCCeGrxzguMgaSLirLcvuwOUw8G9SyEoCerrR2Fg/xfO4djDwUEHamxkkanRuILwvr6IYq/eaar6G2c6YIP1FeWv1BnG05o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731038370; c=relaxed/simple;
	bh=xme5NztUmfcTKxwSzCToe7fFW/wc/DH1QWPo3dHAPZ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E+OafhFuEzXzSOAMNJgf44M2GAnLlAgpsOOJb7Xi92M+mf09ib2uw3jcjsZ5M8uF3btWkQZN/ei/o0hVsQQNGAAhqGor4t7y6KCvOhp4HIuZfDUzRqxnYa8GAqw47shlXuusv1E80NMVNSjLqU0/iac1fJbWmN4EKXV634Bxxbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=lnyqUXcU; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7MbXia011800;
	Thu, 7 Nov 2024 19:59:12 -0800
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42s6gq8kb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 19:59:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBJeGD+hw78zTVk0wYeMaAuW5bS9L/+aRa4c/cWYgJxcR4bEzGBUXhYXKYEHVSXMhVrLw2PKaaCSjJDvvA1jEEdpCnxsi0LTxDqdJhuPolL1meMgUYS8Oxc4i8JVPYEKqsAsfc0LLY/bsBkF1mrHRKgv0jN8+wY5hlKzvgvtBRaFTFaGTd2IOiexvN8ofjnxWfq2B/1kgbkiuVyM9O4VLf58l6VHaGcU+q4MeU4R3eXsbkK8rhxCVy1fGUrulcMLEEdmvYhioiZp28b11aKYA2GaDvQ3Wa2gY/UY0oCaSq0dnvgim3+ZyFCduGDliKv25zE1HD1iQcHED6w0Cy1Ceg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xme5NztUmfcTKxwSzCToe7fFW/wc/DH1QWPo3dHAPZ8=;
 b=a8/616zT0hso06bY1RVSkOswwo+a/3103tTCXAG8y5sS6CQuYryb1sM3p8A0ChNCgUehA54NYKLW6qV/lajx4zZEW+/fjBPmfFHFyp++UQbTVNHMdDckz3NEnFiIGN+WD29QIXAoO08MxuhpCNtc8opDG0sUmBymJ/sGAA9Q0rQJE2qOlyaeWnndYmY18duuedu5Yx4YBfwTkW0vdbJNmm6WlC27dlNCVX6Wg86Ff+P6rmsy9wP3IdCurbEtOA60yUW1fiNNEv9lK/I30zmFJKRPENLucJ7hdjG9x/vYKMzSjzAW/AQBqPYPJnr5gbrzqIwNmV1kyfmnwviXyeFWGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xme5NztUmfcTKxwSzCToe7fFW/wc/DH1QWPo3dHAPZ8=;
 b=lnyqUXcUnsp0ULQQ2XqhCsotSzo7+CcFkOdPFvzkac/NErwFDMcKuwtu7PKhNNTtkf7aRUF6WXOnhxNQ5ya+yKOC/C8vP/yU4rYXT/WRYTR2WtqyybusxKDD/ixLysH4x0aGqr90rEdZdygJFYSLrl0KMqow2pVV6/SsB6C8nI0=
Received: from SJ0PR18MB3865.namprd18.prod.outlook.com (2603:10b6:a03:2ea::22)
 by CH0PR18MB5505.namprd18.prod.outlook.com (2603:10b6:610:188::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 03:59:07 +0000
Received: from SJ0PR18MB3865.namprd18.prod.outlook.com
 ([fe80::697b:186f:f4bb:a5fc]) by SJ0PR18MB3865.namprd18.prod.outlook.com
 ([fe80::697b:186f:f4bb:a5fc%3]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 03:59:07 +0000
From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
To: Will Deacon <will@kernel.org>
CC: "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        George Cherian <gcherian@marvell.com>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>
Subject: Re: [PATCH v9 3/5] perf/marvell: Odyssey DDR Performance monitor
 support
Thread-Topic: [PATCH v9 3/5] perf/marvell: Odyssey DDR Performance monitor
 support
Thread-Index: AQHbMZKO7qOrdz1cKUuucgisugO7fA==
Date: Fri, 8 Nov 2024 03:59:07 +0000
Message-ID:
 <SJ0PR18MB3865A38A244754EEDE1DDF33DB5D2@SJ0PR18MB3865.namprd18.prod.outlook.com>
References: <20241016080153.3546353-1-gthiagarajan@marvell.com>
 <20241016080153.3546353-4-gthiagarajan@marvell.com>
 <20241024120746.GA30510@willie-the-truck>
In-Reply-To: <20241024120746.GA30510@willie-the-truck>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB3865:EE_|CH0PR18MB5505:EE_
x-ms-office365-filtering-correlation-id: 3cedee05-22dd-4f3a-d35c-08dcffa9b17b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VnpzY0w4NnBBK2tPdFVQZnRiNG05bjZWcXM4aGVXdVhEUFVYQ2MzLzNSUHRw?=
 =?utf-8?B?UllQb1N3NDU4dTcvdXRZOU01SXVzdGszcEE5aW04YVFYMnNFOCsyWmJDSmta?=
 =?utf-8?B?UEVQZG16VFQ2amhjc0ZYc2d1STRxMllUdWhSZmFPYVhMTTlJS291RjRjZUVT?=
 =?utf-8?B?VDlzY2l3NWtXWmFybVE0dktMVzc4eHF0aVJMUW9BSklFS3hzK0tSU1JTaXJy?=
 =?utf-8?B?dytMczZ2WEl1dkV2MmY2Vi9nMTZPYVVCRTRKOWhGYTlzOTBxai9oSjlqYUln?=
 =?utf-8?B?SFFueWhKYktIcCtHNkQ2VVdGbWhDMlMrWFMyVDdjQTJacTNSb1dpRXZ3NGRL?=
 =?utf-8?B?NDZUNVcvSE1Mc2U1TFgxTmV0UlBmcVBpQnNpWDBNbSs3YS9jeVdLMTAycGNP?=
 =?utf-8?B?THFkNmxrMDR1VlFiVUxoazJ0WGlUSTk0YmpCcC8xUTNVQzB0NitSUnZrVVhU?=
 =?utf-8?B?K3VIK3FIZWVYOU5MY1lHWGcwT2IwVUtXSFVxeC8wM1dtdHBOb1kyTkVYN1h6?=
 =?utf-8?B?N2pmNW0xMmxnQXVlR0cvVjdlTlp6cEJuVEV5cStzZDB2d0M0UFM3VCtreSt5?=
 =?utf-8?B?ejJVNkg2eEo5NUlzVCtrbHo5TWg0bGp5UHFReXZaVmRzYld5OFFEUUREK0NZ?=
 =?utf-8?B?VUxUeXR4cDhyeVVJSklnd0FKeEZyRmNwTnJDMnF6WTk2L1JlbVZZT0J2dWcw?=
 =?utf-8?B?T24xUEF2anA4L1RXRjBxTEdSZjlzRmdNMWorNFRocTRJOE1BMGswKzZEYjVr?=
 =?utf-8?B?ZXhzNnU0bUFZUmFZeDBuTGI2QVBGcTRuVExlOE05b3VacWU3bEYxOXZQZ0Iy?=
 =?utf-8?B?RFVkTk8yb2luV2wzQm9LUnY5UHg3cXNpSEsxL0RLVlVuYlFKQnhtelY1dHk3?=
 =?utf-8?B?OHlraDRyUm5ISk1hN1lMNGtzbWgvRXNnZmlpeTRCWTAvMlRSSDRFWXpIV1JF?=
 =?utf-8?B?OWhhVnlVdHg1WnpNMHF1ei95UmRDZk9kZllBc2htM3ZiTU5SblVheVEwWEl0?=
 =?utf-8?B?V1VBK1lncVQrR2FsRjlPTU5zY0RmOTRXSkx6RVRncXBJcStMQ2pScXJ6Z0hG?=
 =?utf-8?B?UDRMY3IweHhXbXh5NUtQekdBOTlyanF4TEUyTVk1N0lxY2RxOUl6bVM2WFFX?=
 =?utf-8?B?a2JhYjdBZUFyd2Nxb1dnQ1JnVk5jRzg1QVE2MlQ0WUxjaUc3SmtGc1AwMDFl?=
 =?utf-8?B?QXBPa2VPTXFjYnFFV1krSWYvYy8rWTR2Q1FXMmVTNW4ybmpmRDFIcmd0LzFE?=
 =?utf-8?B?MW1Rck5neGhMTk1sRWo2RnRWKzg4TXcweEdwajd2NXFxcHk5WUZHQjM2UHda?=
 =?utf-8?B?WjFKa3JGakczdVBDWExyQ1BlMTlyR1F1bVRsMnpXakx3bkE4MkVVbkl2OTRy?=
 =?utf-8?B?NWtWeEwxK0RxQ2hRUWtlYW55aXVUYmwvS1d1cGwvNDFpc0U4M2JES2FCOTl2?=
 =?utf-8?B?dHNwekE3Y3Y5WDV6K0dCZnJDTWpIWWJoUzRSbGZ0blR1bHJGVjJWdEw3ZlZ3?=
 =?utf-8?B?d2FTcEh1eHF1djR3SGswSk14WlRuUVVieExwTUVBNERhR0JvWFMvM0I5ME91?=
 =?utf-8?B?VEhsVVNjWjA3TXA4cTQzem1BZ1JFR05JeFJMellIcG5kNUJxZUNqM0dYVVE3?=
 =?utf-8?B?dTFvT1Fod3B1TjZWRnBRNUtHVHF1bHdsbG5KaGxDc0lHaG9VNS8yZTZSTWhV?=
 =?utf-8?B?cURrZjJTZk5uN3FaV2pSazlzb1ViS2trQXd0Mk9IZUJxR3R0NXlwYkI2Mkdi?=
 =?utf-8?B?NTBWc2UxbHZ2anR5VEhkeTlvZXBDU1pNNU1rNWU5VGs4TE1nS1kxMVJqVkFn?=
 =?utf-8?Q?lDxqJfWhhfeeenmTnkCk+6j/mMsW92v54KDTg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB3865.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YnFKY3JxOVpweGE4ZGdLaUtlcjJiRFRmeWs4djRhMkNHMGtZYXRPTWY1dzJ5?=
 =?utf-8?B?MkN2VXRZcFhpY2NhYXlIaDJ3cldySmVtWTBqamw1YmxFaXUra3FoMGwxTElQ?=
 =?utf-8?B?QVIvaGMxQ2c5ZzBmUlpYYUdJbHdPSXNNb1RQY3pXY2VLdDJLRTFVL1BwWVZu?=
 =?utf-8?B?QTJjaXpzQ3hLU3h5ZUtTdGIvWmc3MWk4NWd4eDBTbVBZNFlpVmcwSjJYZEVz?=
 =?utf-8?B?YjZFMmZnSXM0Q1NVRXVQUU03YSt5WE4wUjVOdTJwL1ZKQk05ZWYxQXJUTzNn?=
 =?utf-8?B?Y2JNQ2t0aVE1SUFlbW8yaGxvbTR0cDJlNnZJMUJMNVY0anlRYmg3blJ0VFlx?=
 =?utf-8?B?bGJ4YnQySjZlYzRTVno2WFVPakdLNEFheWV1Ulhvb1hpM0RuMEtuWXBPRVdn?=
 =?utf-8?B?dFY2NFlaYmZiODc3cjV0YUhwQ1IvdkhHakZDeVo4cnI2YzRwbDhxZWVlSnV4?=
 =?utf-8?B?cHBGL0FPNmpRanZCRFNnM1JvWEUrN3M1QXkyUUpObXp1UndxbUlsdXlaclJM?=
 =?utf-8?B?RElNUlU3VlNRL3Nxc1plVEo3VnM3OGFxREc2KzZwVVVDZ1VlamVJWExSMHB6?=
 =?utf-8?B?dWFQaU1zVEMvZWlFMWh3MGZMZjlwWWtET2R1TjQ3VDdIWDV4SW9wRkJsMjVO?=
 =?utf-8?B?UVhaQ2NuNEMvMUkzT3k1c0M2Rk1UWXNEZjVuWTJIRFpyRFNqT1N4RVpvbjVZ?=
 =?utf-8?B?eWtIQUNJVzhDTTFMY3pNSFVydnBRRWsyL2NWaXhyeDBwUWptT3N2RHkxTnk2?=
 =?utf-8?B?VS9QSjRoWmZ2WmtMSXRKdWdTc2kva05zalVneVJxOWZLYlQ1YStkeFppN05p?=
 =?utf-8?B?NERtZ3QzNnEvdHlrcGtTVlkvZEsvdXNJeU42cTNEaG5pKzRrd3ExTUZveEI5?=
 =?utf-8?B?QVNvSzlNTzR3SDJiZ3FLRm1oRjBYbEJQbEp6aHd3OFU0S0FIbG13ZS9QY1k0?=
 =?utf-8?B?NVRPUHdNT09FNmg5bXRPelNXdnFSM2dLWVdVRUlDV1B1RDBwRkZjMjBuMEdL?=
 =?utf-8?B?VWgwNG1uSkwzNjRFdGFjRTBWeUgrekduRElQQm5aZDI1aTlDaTdLd0pDOExL?=
 =?utf-8?B?cmREM1NIcXM0clBqSFhWeEVqR1o3VzExeUY0YXBTM2toclJEUHJMSDRpZEcy?=
 =?utf-8?B?T1ZRaHoxQXU0S1QzWVd6aHY3UTgwV29UdXVFZkdadXpLVnN1QVJPRk03YlRi?=
 =?utf-8?B?RlBqdWpnQytYUWozKzBWei96UGo4b2szeUlPWUVPVWsxOG5MVmQ4bVFJMWRl?=
 =?utf-8?B?Y1BxQmo1NTBIOXZKWmV6ZFYzSUU2Y2M2TzFvTkFoZGxKNUdrQ3VyRitXZFpE?=
 =?utf-8?B?WHFNR0FobUxhaXZ2RUdydVVKd1RsRDR4VUxuUXEyeHVmaklWbXd0eWZWUzF0?=
 =?utf-8?B?N2p6MXRMQnJYTy9na0FqOS9EaXNNa3Bqdm9WZk1BS1BzbkRSSVExY3RZTExs?=
 =?utf-8?B?MzRuem94VVVHdmJraWZUdEg1ZTVrSlFjVlQ0dEs2UnFjVVMzaFJoblZKYWlV?=
 =?utf-8?B?ejVRZ0FZU1VoeDJzeGE1N2QwckozaU9hT0p5SmZWbm1zRzBOTlhnakRuYm5C?=
 =?utf-8?B?N3hUS0ZPRnRKd3RqYkVWanVaZUFmVlB2MmFOMWFyOUlnTFg3TUFjZzRrdlpi?=
 =?utf-8?B?ODc4Vk93alduaXRDQWdYZWNrcHBva1V1R3k3ZUE4djRCbEU5bm54MUNPRE9G?=
 =?utf-8?B?MWJKT0pFeFV4bGlqckZJVlV4Tmt3SWtwMEg5TzU4RG5IekxWMnFjVWZWbTlo?=
 =?utf-8?B?SUtBZmN5L1NvT0xlNm5CUVJaVEdMekk1NVZiTTZQOUY5U0o4ZEc3WkpXR2Mv?=
 =?utf-8?B?SHBlWUZzeXVxWWV2WkI1Z3NzSnY3Y2tjMGpBNTk0OXhjcmN3Vmlvd3RJWHFq?=
 =?utf-8?B?YmMzSWliUnVVb05JTVlJckEyYjJMVk1QVnhGZTQ2STE2cGx5T3hxeW1lMDhH?=
 =?utf-8?B?R0pKalJMN3VjMDBkZDdHamxtM3VSS1orN0ZlcHFpV09KUzlpVjhKRGVQRnh0?=
 =?utf-8?B?UVBJSTlpSWd0Z3lTZW0rQkduNXVIZ0R4UWhBdENqVHVNV3RMSXRjTXVlU3Vj?=
 =?utf-8?B?WjlHMjcyMkdhb1YwMnN4TUx1Wk1BRUZydkp5MERMSXNIYzd3c1FhQUREa0JJ?=
 =?utf-8?Q?+3UofBjXzJWN26SwpojMQ+Cz0?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB3865.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cedee05-22dd-4f3a-d35c-08dcffa9b17b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 03:59:07.1419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N+rekpUImtnpugGgnZ7mrA9M3VUlx1g7wsiQXr878yi80dOYNDzr/ceqtYHPr/n2KXtONfKK7xpYYK8j2xxpcIUc8qs5kbR1Z2GSpoS4GMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB5505
X-Proofpoint-GUID: bdDc28aQb5NRHqfJRBV7q42JUW5-wkYp
X-Proofpoint-ORIG-GUID: bdDc28aQb5NRHqfJRBV7q42JUW5-wkYp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

DQoNCkZyb206IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+IA0KU2VudDogVGh1cnNkYXks
IE9jdG9iZXIgMjQsIDIwMjQgNTozOCBQTQ0KVG86IEdvd3RoYW1pIFRoaWFnYXJhamFuIDxndGhp
YWdhcmFqYW5AbWFydmVsbC5jb20+DQpDYzogbWFyay5ydXRsYW5kQGFybS5jb207IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgQmhhcmF0IEJodXNoYW4gPGJiaHVzaGFuMkBtYXJ2ZWxsLmNvbT47IEdlb3JnZSBDaGVyaWFu
IDxnY2hlcmlhbkBtYXJ2ZWxsLmNvbT47IFN1bmlsIEtvdnZ1cmkgR291dGhhbSA8c2dvdXRoYW1A
bWFydmVsbC5jb20+OyBqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20NClN1YmplY3Q6IFtFWFRF
Uk5BTF0gUmU6IFtQQVRDSCB2OSAzLzVdIHBlcmYvbWFydmVsbDogT2R5c3NleSBERFIgUGVyZm9y
bWFuY2UgbW9uaXRvciBzdXBwb3J0IFdlZCwgT2N0IDE2LCAyMDI0IGF0IDAxOuKAijMxOuKAijUx
UE0gKzA1MzAsIEdvd3RoYW1pIFRoaWFnYXJhamFuIHdyb3RlOiA+IE9keXNzZXkgRFJBTSBTdWJz
eXN0ZW0gc3VwcG9ydHMgZWlnaHQgY291bnRlcnMgZm9yIG1vbml0b3JpbmcgcGVyZm9ybWFuY2Ug
PiBhbmQgc29mdHdhcmUgY2FuIHByb2dyYW0gdGhvc2UgY291bnRlcnMgdG8gbW9uaXRvciBhbnkg
b2YgdGhlIGRlZmluZWQgPiBwZXJmb3JtYW5jZQ0KDQpPbiBXZWQsIE9jdCAxNiwgMjAyNCBhdCAw
MTozMTo1MVBNICswNTMwLCBHb3d0aGFtaSBUaGlhZ2FyYWphbiB3cm90ZToNCj4gT2R5c3NleSBE
UkFNIFN1YnN5c3RlbSBzdXBwb3J0cyBlaWdodCBjb3VudGVycyBmb3IgbW9uaXRvcmluZyBwZXJm
b3JtYW5jZQ0KPiBhbmQgc29mdHdhcmUgY2FuIHByb2dyYW0gdGhvc2UgY291bnRlcnMgdG8gbW9u
aXRvciBhbnkgb2YgdGhlIGRlZmluZWQNCj4gcGVyZm9ybWFuY2UgZXZlbnRzLiBTdXBwb3J0ZWQg
cGVyZm9ybWFuY2UgZXZlbnRzIGluY2x1ZGUgdGhvc2UgY291bnRlZA0KPiBhdCB0aGUgaW50ZXJm
YWNlIGJldHdlZW4gdGhlIEREUiBjb250cm9sbGVyIGFuZCB0aGUgUEhZLCBpbnRlcmZhY2UgYmV0
d2Vlbg0KPiB0aGUgRERSIENvbnRyb2xsZXIgYW5kIHRoZSBDSEkgaW50ZXJjb25uZWN0LCBvciB3
aXRoaW4gdGhlIEREUiBDb250cm9sbGVyLg0KPiANCj4gQWRkaXRpb25hbGx5IERTUyBhbHNvIHN1
cHBvcnRzIHR3byBmaXhlZCBwZXJmb3JtYW5jZSBldmVudCBjb3VudGVycywgb25lDQo+IGZvciBk
ZHIgcmVhZHMgYW5kIHRoZSBvdGhlciBmb3IgZGRyIHdyaXRlcy4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEdvd3RoYW1pIFRoaWFnYXJhamFuIDxtYWlsdG86Z3RoaWFnYXJhamFuQG1hcnZlbGwuY29t
Pg0KPiAtLS0NCj4gIERvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvcGVyZi9pbmRleC5yc3QgICAg
ICB8ICAgMSArDQo+ICAuLi4vYWRtaW4tZ3VpZGUvcGVyZi9tcnZsLW9keXNzZXktZGRyLXBtdS5y
c3QgfCAgODAgKysrKysrDQo+ICBkcml2ZXJzL3BlcmYvbWFydmVsbF9jbjEwa19kZHJfcG11LmMg
ICAgICAgICAgfCAyNjEgKysrKysrKysrKysrKysrKystDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDMz
OSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERv
Y3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvcGVyZi9tcnZsLW9keXNzZXktZGRyLXBtdS5yc3QNCg0K
Wy4uLl0NCg0KPiBAQCAtMjk3LDIwICs0MDUsMjcgQEAgc3RhdGljIGt0aW1lX3QgY24xMGtfZGRy
X3BtdV90aW1lcl9wZXJpb2Qodm9pZCkNCj4gIAlyZXR1cm4gbXNfdG9fa3RpbWUoKHU2NCljbjEw
a19kZHJfcG11X3BvbGxfcGVyaW9kX3NlYyAqIFVTRUNfUEVSX1NFQyk7DQo+ICB9DQo+ICANCj4g
LXN0YXRpYyBpbnQgZGRyX3BlcmZfZ2V0X2V2ZW50X2JpdG1hcChpbnQgZXZlbnRpZCwgdTY0ICpl
dmVudF9iaXRtYXApDQo+ICtzdGF0aWMgaW50IGRkcl9wZXJmX2dldF9ldmVudF9iaXRtYXAoaW50
IGV2ZW50aWQsIHU2NCAqZXZlbnRfYml0bWFwLA0KPiArCQkJCSAgICAgc3RydWN0IGNuMTBrX2Rk
cl9wbXUgKmRkcl9wbXUpDQo+ICB7DQo+ICAJc3dpdGNoIChldmVudGlkKSB7DQo+ICAJY2FzZSBF
VkVOVF9ISUZfUkRfT1JfV1IgLi4uIEVWRU5UX1dBV19IQVpBUkQ6DQo+ICAJY2FzZSBFVkVOVF9P
UF9JU19SRUZSRVNIIC4uLiBFVkVOVF9PUF9JU19aUUxBVENIOg0KPiAgCQkqZXZlbnRfYml0bWFw
ID0gKDFVTEwgPDwgKGV2ZW50aWQgLSAxKSk7DQo+ICAJCWJyZWFrOw0KPiArCWNhc2UgRVZFTlRf
REZJX1BBUklUWV9QT0lTT04gLi4uRVZFTlRfREZJX0NNRF9JU19SRVRSWToNCj4gKwkJaWYgKGRk
cl9wbXUtPnBfZGF0YS0+aXNfb2R5KQ0KPiArCQkJKmV2ZW50X2JpdG1hcCA9ICgxVUxMIDw8IChl
dmVudGlkIC0gMSkpOw0KPiArCQllbHNlDQo+ICsJCQlnb3RvIGVycjsNCj4gKwkJYnJlYWs7DQoN
CllvdSBjb3VsZCB0aWR5IHRoaXMgdXAgYSBsaXR0bGUgd2l0aCBhIGZhbGx0aHJvdWdoOg0KU3Vy
ZS4gV2lsbCBtYWtlIHRoaXMgY2hhbmdlIGluIHRoZSBuZXh0IHZlcnNpb24uDQoNCglpbnQgZXJy
ID0gMDsNCg0KCXN3aXRjaCAoZXZlbnRpZCkgew0KCWNhc2UgRVZFTlRfREZJX1BBUklUWV9QT0lT
T04gLi4uRVZFTlRfREZJX0NNRF9JU19SRVRSWToNCgkJaWYgKCFkZHJfcG11LT5wX2RhdGEtPmlz
X29keSkgew0KCQkJZXJyID0gLUVJTlZBTDsNCgkJCWJyZWFrOw0KCQl9DQoJCWZhbGx0aHJvdWdo
Ow0KCWNhc2UgRVZFTlRfSElGX1JEX09SX1dSIC4uLiBFVkVOVF9XQVdfSEFaQVJEOg0KCWNhc2Ug
RVZFTlRfT1BfSVNfUkVGUkVTSCAuLi4gRVZFTlRfT1BfSVNfWlFMQVRDSDoNCgkJKmV2ZW50X2Jp
dG1hcCA9ICgxVUxMIDw8IChldmVudGlkIC0gMSkpOw0KCQlicmVhazsNCglkZWZhdWx0Og0KCQll
cnIgPSAtRUlOVkFMOw0KCX0NCg0KCWlmIChlcnIpIHsNCgkJcHJfZXJyKCIlcyBJbnZhbGlkIGV2
ZW50aWQgJWRcbiIsIF9fZnVuY19fLCBldmVudGlkKTsNCgkJcmV0dXJuIGVycjsNCgl9DQoNCj4g
IHN0YXRpYyB2b2lkIGNuMTBrX2Rkcl9wZXJmX2V2ZW50X3N0YXJ0KHN0cnVjdCBwZXJmX2V2ZW50
ICpldmVudCwgaW50IGZsYWdzKQ0KPiAgew0KPiAgCXN0cnVjdCBjbjEwa19kZHJfcG11ICpwbXUg
PSB0b19jbjEwa19kZHJfcG11KGV2ZW50LT5wbXUpOw0KPiArCXU2NCBjdHJsX3JlZyA9IHBtdS0+
cF9kYXRhLT5jbnRfb3BfbW9kZV9jdHJsOw0KPiAgCXN0cnVjdCBod19wZXJmX2V2ZW50ICpod2Mg
PSAmZXZlbnQtPmh3Ow0KPiArCWJvb2wgaXNfb2R5ID0gcG11LT5wX2RhdGEtPmlzX29keTsNCj4g
IAlpbnQgY291bnRlciA9IGh3Yy0+aWR4Ow0KPiAgDQo+ICAJbG9jYWw2NF9zZXQoJmh3Yy0+cHJl
dl9jb3VudCwgMCk7DQo+ICANCj4gIAljbjEwa19kZHJfcGVyZl9jb3VudGVyX2VuYWJsZShwbXUs
IGNvdW50ZXIsIHRydWUpOw0KPiArCWlmIChpc19vZHkpIHsNCj4gKwkvKiBTZXR1cCB0aGUgUE1V
IGNvdW50ZXIgdG8gd29yayBpbiBtYW51YWwgbW9kZSAqLw0KPiArCQl3cml0ZXFfcmVsYXhlZChP
UF9NT0RFX0NUUkxfVkFMX01BTk5VQUwsIHBtdS0+YmFzZSArDQoNCkV4aXN0aW5nIHR5cG86IE9Q
X01PREVfQ1RSTF9WQUxfTUFOTlVBTA0KDQpJIGd1ZXNzIHlvdSBjb3VsZCBmaXggdGhhdCBpbiBv
bmUgb2YgdGhlIGVhcmxpZXIgcmVmYWN0b3JpbmcgcGF0Y2hlcywgaWYNCnlvdSB3YW50ZWQgdG8u
DQogDQpZZXMuIFdpbGwgZml4IHRoZSB0eXBvIGFsb25nIHdpdGggcmVmYWN0b3IuDQoNCj4gKwkJ
CSAgICAgICBERFJDX1BFUkZfUkVHKGN0cmxfcmVnLCBjb3VudGVyKSk7DQo+ICsNCj4gKwkJY24x
MGtfZGRyX3BlcmZfY291bnRlcl9zdGFydChwbXUsIGNvdW50ZXIpOw0KPiArCX0NCg0KV2h5IG5v
dCBwdXQgdGhpcyBpbnNpZGUgY24xMGtfZGRyX3BlcmZfY291bnRlcl9lbmFibGUoKT8NClRoYW5r
cy4gQ2FuIGJlIG1hZGUgaW5zaWRlIHRoZSBjb3VudGVyX2VuYWJsZS4NCg0KPiAgDQo+ICAJaHdj
LT5zdGF0ZSA9IDA7DQo+ICB9DQo+IEBAIC00ODYsNyArNjMwLDcgQEAgc3RhdGljIGludCBjbjEw
a19kZHJfcGVyZl9ldmVudF9hZGQoc3RydWN0IHBlcmZfZXZlbnQgKmV2ZW50LCBpbnQgZmxhZ3Mp
DQo+ICAJaWYgKGNvdW50ZXIgPCBERFJDX1BFUkZfTlVNX0dFTl9DT1VOVEVSUykgew0KPiAgCQkv
KiBHZW5lcmljIGNvdW50ZXJzLCBjb25maWd1cmUgZXZlbnQgaWQgKi8NCj4gIAkJcmVnX29mZnNl
dCA9IEREUkNfUEVSRl9DRkcocF9kYXRhLT5jZmdfYmFzZSwgY291bnRlcik7DQo+IC0JCXJldCA9
IGRkcl9wZXJmX2dldF9ldmVudF9iaXRtYXAoY29uZmlnLCAmdmFsKTsNCj4gKwkJcmV0ID0gZGRy
X3BlcmZfZ2V0X2V2ZW50X2JpdG1hcChjb25maWcsICZ2YWwsIHBtdSk7DQo+ICAJCWlmIChyZXQp
DQo+ICAJCQlyZXR1cm4gcmV0Ow0KPiAgDQo+IEBAIC01MTEsMTAgKzY1NSwxNCBAQCBzdGF0aWMg
dm9pZCBjbjEwa19kZHJfcGVyZl9ldmVudF9zdG9wKHN0cnVjdCBwZXJmX2V2ZW50ICpldmVudCwg
aW50IGZsYWdzKQ0KPiAgew0KPiAgCXN0cnVjdCBjbjEwa19kZHJfcG11ICpwbXUgPSB0b19jbjEw
a19kZHJfcG11KGV2ZW50LT5wbXUpOw0KPiAgCXN0cnVjdCBod19wZXJmX2V2ZW50ICpod2MgPSAm
ZXZlbnQtPmh3Ow0KPiArCWJvb2wgaXNfb2R5ID0gcG11LT5wX2RhdGEtPmlzX29keTsNCj4gIAlp
bnQgY291bnRlciA9IGh3Yy0+aWR4Ow0KPiAgDQo+ICAJY24xMGtfZGRyX3BlcmZfY291bnRlcl9l
bmFibGUocG11LCBjb3VudGVyLCBmYWxzZSk7DQo+ICANCj4gKwlpZiAoaXNfb2R5KQ0KPiArCQlj
bjEwa19kZHJfcGVyZl9jb3VudGVyX3N0b3AocG11LCBjb3VudGVyKTsNCg0KU2FtZSBoZXJlLg0K
V2lsbCBtYWtlIGNuMTBrX2Rkcl9wZXJmX2NvdW50ZXJfc3RvcC9zdGFydCBpbnNpZGUgdGhlIGNu
MTBrX2Rkcl9wZXJmX2NvdW50ZXJfZW5hYmxlLg0KLUdvd3RoYW1pDQoNCldpbGwNCg==

