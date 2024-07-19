Return-Path: <linux-kernel+bounces-257224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3569376FB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 13:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F41282B1C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 11:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F4583CD7;
	Fri, 19 Jul 2024 11:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="b/vXZ66u"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001F41B86D2
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 11:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721387185; cv=fail; b=qwiKXK/QZOPJQ4wnWfx6BR4s1CbPpGl5+Q8VZpL7390dLdF2zxNbkb9Wm0VSox0ZmFLm1eNNxYwr7CtpQI1mTS6tUDhDRXev+TBNtL/4Edn53nsQEyNjhS+NuwGAxzBKCxYT7TYyK/u4WciLpI35+eQ/Bl7bFrUr+coozIYJ/j8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721387185; c=relaxed/simple;
	bh=CVORpr9tOA4lMZkIR6X8W+z9Lb5sEm7zW/kLysDBbss=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=hf5jpehnj+7Sw+zAbzZPuEpU9cgItJKoFIJWo5nBiaJ5R7jBptDbFXLgCj92S9utxEjCnn8c3du1hbOavtq6K3ZzoahZHe7rMsq5TAKq2tnF5MPTXyiJqthFf7Ut46KSCqYw1oH24pPtzJGDnVXrexNdCW/8iGSahD2A6nGwOKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=b/vXZ66u reason="signature verification failed"; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46J149Wx026962;
	Fri, 19 Jul 2024 04:05:13 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 40fe5esqe0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jul 2024 04:05:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wRXdWIIR/Hw1xAXO8mGlTCmwOjDsHnC5nec1jP6Mc+LxCGSEx3aMyR03Eyu+IMUx+v/hSX0NGyicvY1dB2icxQODdqxccKtBsvK9kdKtYHLVgItVD5GH6/BoFqAXSswZkbzm3ua0bc178Yn8oKY59RUXvOEBMv0KCnzrlexh2ATT26dpj0HyzmgKwEw9pYdtXkbPdMs9WaouAWf0Y3oQF5kg6zni4NqnGKrjTZvBHVUiiy4zlooMZJJJuj/aPwqP0RWR8ItV3rX/w7QqASKwtMluWzgXl17xHeziqM+Fc9qp0Yv3hQQv4Sln0l2kn83pb/U40aCz51TWQCltNqpe4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aD3HleeM2mAu8j8SM7nCxw7WwcC0wVh8vX5mfYJXXzo=;
 b=y5Ng3piutHz3RULvN/UB12l7sf0BPhkdWxcrA1kLV+7Wag+X5MkzixTf1fMP1RxGxKdil5mA+qtLf/wBLIVNUj/tuSfHvPrMh7rmFa09WCYaVklX4miNAh5liJZOqOcVyV0HAYeyIpBJsNOwIWFtqgsetz4IAZ5vmUYSSsfXgLdNhPhcuTOHMIhk47zizm0688z3uicf2lLfR02OSzeRq8pjjG9J6ovAdenGUSDbQ98lgP6sZxgxcUuLp661CX1TCTBsJcLX+0Xbn9S5tfYeZuIuvN+382UKMWIPcSFx+SvSF+qooAUNSDdAcDfEBl22tUqiJIDX5iNjraiOhUBltw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aD3HleeM2mAu8j8SM7nCxw7WwcC0wVh8vX5mfYJXXzo=;
 b=b/vXZ66uLNTHfVHXenpDfre7sMwl9R9Am6y0EoPbvVnaPsBfsHQd7OCfVJRAhlQC+uTx8/3bxXijH179QaHMIQ2kPxn/QcEDMKEnWa9LZ3qjubMRW6r6jZ5nJCqyKllfpYNb4uyS5yZy8pa9OT7gtVYup4roeS6ytq1uWlK0Z6g=
Received: from MW4PR18MB5244.namprd18.prod.outlook.com (2603:10b6:303:1e0::16)
 by PH8PR18MB5383.namprd18.prod.outlook.com (2603:10b6:510:256::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Fri, 19 Jul
 2024 11:05:08 +0000
Received: from MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::52f3:9792:ee42:90b]) by MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::52f3:9792:ee42:90b%3]) with mapi id 15.20.7784.016; Fri, 19 Jul 2024
 11:05:08 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: Arnd Bergmann <arnd@kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Arnd Bergmann <arnd@arndb.de>, Srujana Challa <schalla@marvell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH] misc: mrvl-cn10k-dpi: add PCI_IOV dependency
Thread-Topic: [EXTERNAL] [PATCH] misc: mrvl-cn10k-dpi: add PCI_IOV dependency
Thread-Index: AQHa2cfoJFmylqezGEGOpChYQ9I8pbH94iPA
Date: Fri, 19 Jul 2024 11:05:08 +0000
Message-ID:
 <MW4PR18MB52447C6B97263C4790C66E22A6AD2@MW4PR18MB5244.namprd18.prod.outlook.com>
References: <20240719103858.1292094-1-arnd@kernel.org>
In-Reply-To: <20240719103858.1292094-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR18MB5244:EE_|PH8PR18MB5383:EE_
x-ms-office365-filtering-correlation-id: 21e757a5-2848-41aa-4a2c-08dca7e2a6f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dFlITWdiMVUyU3gzYnRmWW1NRmRwZzErMUczQUZreUVKa3B2SUpQRkgrblFl?=
 =?utf-8?B?bHhOa0Z1eDZINlZ5dkx5d3lHVjN1TGY4eFFudGdpSGYxdExYZE9EZnZsWVdn?=
 =?utf-8?B?UUluQ0dCTGxHMCs0UnhuczFSLy9EYzdEM1VCOGVDMFhjU3M4Y1BQWGRMK0xz?=
 =?utf-8?B?UHF6bXhiVjh3S3FiWURLZm5nbDdUYnA3MFliajV5WXlLd3YxYVhQNW5qVkVq?=
 =?utf-8?B?NUpUMSs2ZUY5TFVaWFlYVXhqYmtteFNUUmpTOXAxN3UwZVIvNk54WmVpUExX?=
 =?utf-8?B?RXdxSUtqaXN1ajJCcmJyc29tS3RzZEJCWHY2MFdBQTEzWDdNTm81R20xWUpM?=
 =?utf-8?B?TW5jbi9vSGZLV2NEaEM5V1QrbTJNOXlERm4wTlFFcnhxbC93VjBXS2xBZUFO?=
 =?utf-8?B?K3BWb3hBaEVJYXJncWs0OENwcDEva3NCMzdDTldob3poNHY2ZUpvSjc5Mlpy?=
 =?utf-8?B?U3BwdVhndVp6a2tFdHlDZkhiRlhCU0JNY3NVNU16YjFTTk9OYjNrVGMwZ24r?=
 =?utf-8?B?ck9HVnBpeXVMWFFZektuOWRmSTcyT2RYdmx2cnNVK29WRFZNMWZHWUhKTUJw?=
 =?utf-8?B?R0VnMWhHcW1iT09IMW1aMUpkL005cEc1ZVU0aXViUzl2djJKZGtxRHVUVFY3?=
 =?utf-8?B?NktHV2pSVXkrNTB0Y0F6Rkt0bmUzQWlTL1JFSGQ5LzRKbkNJTlJ6eGZiSkQx?=
 =?utf-8?B?UzRDekpHUXR1R3RmaEUxZ21GMjhWcHI0L25sUVREUWlrcU1TZjRHRk5VK21C?=
 =?utf-8?B?N2w1TVBHTXdKbWNwR3BZdmd5d0NqOE0yNCszT3ZoZktZSEQvZXQ0aTE0Zmwr?=
 =?utf-8?B?Zlc3eGhLQzE4dUpyK3BvRFZUS1FLMXY5aFc2WkNGbitWWXJYUjJuclp0bmM0?=
 =?utf-8?B?MnJXcnZZKy9IMG93TXBGQ3psYlFVamN1WUhYaVJLRHU2SmxBSkxJYnNvTmhr?=
 =?utf-8?B?aTA5cHU1YVlzTGxPQkFKKzhKOEx2eU1LT3d0cThGaEZiaW4wZ2tlUHV3UnNU?=
 =?utf-8?B?UWpUaHR5N3RzaHAxcUpOUFNjWllET3FxZkJ5dTh1MExQYlBsbjdYQWhmUGtq?=
 =?utf-8?B?aDZGbHdXMExxL0tJRXNvaWQyZTh1cGhyaGIrdHZPS0ovbzlRZ3o2ak5nYmIz?=
 =?utf-8?B?c3NSSXd1YTBRWFlnUUZjSnk0dWMxdi84UG5kZHh5N0JneG5lOGtsRmtGRnhv?=
 =?utf-8?B?QjE3cTA0UEdGaWlac0czRHMxL083VkliQUdKcGZ1M3Q1L0xGNWFla3l2V3hO?=
 =?utf-8?B?RHdycFV2VGhocVFaa085MXd4QkZzVFl6MkNUOXp2TFV0TDFkdU1QYllPdXZo?=
 =?utf-8?B?RWluTnQ1QjdnRGRzNlBmTmxQNUc4TUYycjNuRE5HNEtIQ2h1aGJ3akxLdlEw?=
 =?utf-8?B?N0tPSGlLc1FtMGVSUVpyaENneXRML3BsNkpzL2Y4NW1IbDlmdWpwSnQyYjky?=
 =?utf-8?B?cjFBdDMyckRVaHVkRHZQNUdreEJ5N0lpT1hUREFhZ1NKOWxkanVxTFdkY3lE?=
 =?utf-8?B?RW5TU0F0K1REVjkvUnpYczU3S3M1VVRxbEE0RlAvd1lycUU5dGRCdHhKT0Jm?=
 =?utf-8?B?K21xQ1pYam9TTUVEZG9qemtDcTJBUlQ5UDdEOGlETHQwR2tZZ1BWKzU0ejlz?=
 =?utf-8?B?SE40TVVqK2Z5alVYajl4bk5TK1p6Nkw1Q3lFNHdDUjl6OEUxUXBua3duS3ZF?=
 =?utf-8?B?bTAxODFPdGJXVnA4ZHZaS0dqQjF3QThUK3dXR0E2OVYvcEZmcWtpSzJlSmdP?=
 =?utf-8?B?L0VVUkltL3pRUWRpc1VjK1dHSWhKVXRTWjdVaXhid3NWVGJ5WjJQWWFvc3RQ?=
 =?utf-8?B?SFI3UFNDaUZYNStpRktBQXlTajJtVWt0K2dLSUJwUjAxOUtIKzdWYVljS1Vo?=
 =?utf-8?B?QmZ2aUZZanVEMGdlNmRGbDROY2kwSlFkTXZucXhOcVNEV2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5244.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b3VabWFBdlRZUCtHR2JnWGZBT3pHWHpyZFRpYXUxKzEzcXhvNTRBN3NJbjNH?=
 =?utf-8?B?bTgrVkFPZFlnUXo2UVpXZlVuMEpoVGxUU2tZT0JiVXg3Y3dJc0JjajkrQ291?=
 =?utf-8?B?QVBpMTZTd0xLWFI3MlRWUEpKUjlFbSs3RFhNVTVQMXpIbXA4bmMwNENaVmpQ?=
 =?utf-8?B?QUdBNXJYUXhZd05JQm9PKzF2L1E0a28xNTMxUW83R1lFb2lLUXhTRkVlZTEr?=
 =?utf-8?B?a3NZY3VxWVB3bmdLOVhJbUU4eTA2U1d5TmJmRXZUOFh5U2wzVlJsa1h1Wkk5?=
 =?utf-8?B?c2N0RC9abnc5U1ZLY0dWNEpoZDlEcVZQTmY2bXR5UzlHbHBmc0pqdXpiaUVa?=
 =?utf-8?B?SEd5YVl2Q0QzaGpQZmpicm0wdkNtcUdrK2tCL1ZYZk4yK0ZxR29zck5HYjR2?=
 =?utf-8?B?Ny83c3hKekhHRVByOGRCTGRLdE5IRUFXU2h1d3VvYTgzQ1dEaHpRMkRLb1ZZ?=
 =?utf-8?B?RUtEUzQwRFBadWZHNWlzWDdiWE5UUU13WC8wdUxicGY4b3lKemxDQ1JCdnQ5?=
 =?utf-8?B?REtFZVNsSUVsd1RiVUZSUitYQXc1YWh0cXBreGtQVWM3NGRQSkhnb04zb0xK?=
 =?utf-8?B?TEtvWHBLRkdlUkZFS0NEckFVS3hHc080VEZaUWVuVXlOQ0ZiWVdKNERYbGhQ?=
 =?utf-8?B?OXhSNFlVd3BPK3hpdlNFVU1NaGMySmYvOWVXZ3V3TVRtRTNLRkxpYVUxelJh?=
 =?utf-8?B?UUZUQVpzakZxWEt5d0czTG4wSUc5R3ZlUFhLOVkrTW5XZUxVM2RwMW0wSHNJ?=
 =?utf-8?B?eldYSEZDNld2TmNLZjJZcStHWDJ2MDRPYlBkU3B1SlVGVWd5SjdLeXd3TDd0?=
 =?utf-8?B?QUhuQmdNL1Vyb09UZlVBclE2RlFPUlkyVVdnUTFNVUlyai9xM0FhMTRhVnk0?=
 =?utf-8?B?d0xIVFBwdnFYV0YrcDZzdmNpRVk2TU5jbUlXTzFCUVFMek10alc3WlFXclFT?=
 =?utf-8?B?VXpXNGNSTjNNVTlNeEJ2WXovTHpBT0pTbkZwUU1iaDd4d3RXL0ticGFpS0di?=
 =?utf-8?B?empoMWg1TzBRNWFienluOFBGbVJHWWF6d1AwS2svM1ZjbFA3eWFZU2RPSWNK?=
 =?utf-8?B?Vjl6MnBaNFdvd3lrWk0wczRPVWxCRC9Ld3ZXTTMrUE0rdE5sOXRkcXhsK1pJ?=
 =?utf-8?B?WHpXRUpXRmE3aVBaV0k0eXJmdUJrRDFwMEs5cXBuSENxUG9ZWEFwNEt5TkZM?=
 =?utf-8?B?Y25CRHhLRVdFNlk5UFo0Ui9PVmVWR2F4Mnp3WGZSVGRGMXNTNnpvbkF1aUtk?=
 =?utf-8?B?U2t2d1o5SWM4blNwejBuNGZjWXpzS2hBRzVaTitCdHdrcjI2V2hCOUZlM1Zj?=
 =?utf-8?B?bzZoc0xIL0VjaWNRYllwelJOR016QzZNdWg4UFpGQ2tjYWlIMHRUdkREazZ6?=
 =?utf-8?B?NlFrRjBEMGdpR25qZUh1ZlVOdk5SY1ZuejR0Z0oxZzNvNFlLdXpjcVZxT3hq?=
 =?utf-8?B?aDBSZXoxWXhJTGdadXkzcWVNME5WQWVVL3ZBWC9ramNKbU5aOUJobXM4QkVl?=
 =?utf-8?B?Z3A4R3Z3NzRJRy9VSzlGeTBtV09hUDFuc3Vuejh3MmZXQ0p6NU9mWitxSHdo?=
 =?utf-8?B?ZWlrQkZXc3NnS1hocFpLbnkxOU5keDJmdkhJQStJL28xV3hwSmZpL21Rc1Ez?=
 =?utf-8?B?QTAwenJVYnVvMDVHWFU0ZzdBOWlrZG5IUE1ReE1jZytlcUVxYWlYcVFWQWl5?=
 =?utf-8?B?bEJCZGdOYXROeSsyRjM5RVJraHdWR1pFUDZQSFlRZ3VxbXhrVC8wdHlmU2E0?=
 =?utf-8?B?Zk1FTit6bGtsc2lxREJmRjFlN1JBaHYrY2RaaG9YSnBiTVB2aFNRVXNFODYx?=
 =?utf-8?B?ZFpDVzA3Q2srWnNpUllDU3ZSMjJmTndZYzJIcVl4SjE4dVJjUHVweStqOFE0?=
 =?utf-8?B?eVROa1k3ZDI1R0ZYNG9WLzB2K2lOckNOY0toaHBUSWsvQUpyYUhKemRNTjZE?=
 =?utf-8?B?dXdNdy9TckU2UWJZYzRqR3ZYWVJEMkZLdzBYNXRYY3N4TmhjOXRrdWdlZVov?=
 =?utf-8?B?bUU4Z3RjK1k1MWtkRjQ4SDJVNGVMbEt0UWVDc1VDWXJVNEFrSm1PdGRBMUpI?=
 =?utf-8?B?c09hTDZYYS84UmErbUwzTUJva3FaN3liSW81YWFEUFEwY1dKenVHM0cyaG9v?=
 =?utf-8?Q?NYfA1zuTnOhbn8OdgMKX4jO0H?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5244.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e757a5-2848-41aa-4a2c-08dca7e2a6f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 11:05:08.4822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XyNmsNUJ6wH4Pk2MMIe25fvcW266JNve3wdF++J127+293IEuqgg650vtkWaqGkmRmORnBy2Drl9x3iOMnsSKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR18MB5383
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: CnEXPOzvyV8WsocW3JLs-_71KoYyv1N3
X-Proofpoint-ORIG-GUID: CnEXPOzvyV8WsocW3JLs-_71KoYyv1N3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01



>-----Original Message-----
>From: Arnd Bergmann <arnd@kernel.org>
>Sent: Friday, July 19, 2024 4:08 PM
>To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Cc: Arnd Bergmann <arnd@arndb.de>; Vamsi Krishna Attunuru
><vattunuru@marvell.com>; Srujana Challa <schalla@marvell.com>; linux-
>kernel@vger.kernel.org
>Subject: [EXTERNAL] [PATCH] misc: mrvl-cn10k-dpi: add PCI_IOV dependency
>
>From: Arnd Bergmann <arnd@=E2=80=8Aarndb.=E2=80=8Ade> I found one more mis=
sing
>dependency in the new driver: when building without CONFIG_PCI_IOV,
>pci_sriov_configure_simple() cannot be called directly:
>drivers/misc/mrvl_cn10k_dpi.=E2=80=8Ac: In function 'dpi_remove':
>
>From: Arnd Bergmann <arnd@arndb.de>
>
>I found one more missing dependency in the new driver: when building
>without CONFIG_PCI_IOV, pci_sriov_configure_simple() cannot be called
>directly:
>
>drivers/misc/mrvl_cn10k_dpi.c: In function 'dpi_remove':
>include/linux/stddef.h:9:14: error: called object is not a function or fun=
ction
>pointer
>    9 | #define NULL ((void *)0)
>      |              ^
>include/linux/pci.h:2416:41: note: in expansion of macro 'NULL'
> 2416 | #define pci_sriov_configure_simple      NULL
>      |                                         ^~~~
>drivers/misc/mrvl_cn10k_dpi.c:652:9: note: in expansion of macro
>'pci_sriov_configure_simple'
>  652 |         pci_sriov_configure_simple(pdev, 0);
>
>Add this to the Kconfig file as well.
>
>Fixes: 5f67eef6dff3 ("misc: mrvl-cn10k-dpi: add Octeon CN10K DPI
>administrative driver")
>Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>---
> drivers/misc/Kconfig | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig index
>a1ae3f9c0707..b6f5733a6ee2 100644
>--- a/drivers/misc/Kconfig
>+++ b/drivers/misc/Kconfig
>@@ -589,7 +589,7 @@ config NSM
>
> config MARVELL_CN10K_DPI
> 	tristate "Octeon CN10K DPI driver"
>-	depends on PCI
>+	depends on PCI && PCI_IOV
> 	depends on ARCH_THUNDER || (COMPILE_TEST && 64BIT)
> 	help
> 	  Enables Octeon CN10K DMA packet interface (DPI) driver which
>--
>2.39.2

Ohk, my apologies for that. Arnd, thank you for the solution.

Tested-by: Vamsi Attunuru <vattunuru@marvell.com>


