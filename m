Return-Path: <linux-kernel+bounces-336489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81135983B6E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 05:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E77381F23584
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 03:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2BF15E96;
	Tue, 24 Sep 2024 03:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="p1SJnMls"
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com [148.163.133.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274F67E9;
	Tue, 24 Sep 2024 03:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.133.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727146865; cv=fail; b=QKJsgMNsMJFgpfQZVCaCn650VRaPeFxhaTf71LJVF0XF6UnhC9vVAA8YgdgOg4/XwX9fCICLzaq+yMn9gpzSX4zl7l9bapZQ9SA8e4zOGkJdPg9XvGzyzj+VgUgNc9UB8gvRF0lXMYUMDse6wcrzxuzb1GFxfFiwumJE1MURUOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727146865; c=relaxed/simple;
	bh=xqCZ25DNLQ60cs1wlZPjklRmUwtE/NN0LF5eaKCkPvk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NwKdCmA41+dv4PtPQZ9Io7BZ+ccpXfAUf3oghyj4ubhtCIe64pCinBU4ituIk80T8M6U0J3bYF+0YK2Z5uDDUKrkoBaTQq8Rq8Ru41ANVHJ6iHJSIAaz/Bsf+Ixjd1rpXBu02RNw0jznwQpFj84e5wht0a6Qh25I6XhvXm5L17U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=p1SJnMls; arc=fail smtp.client-ip=148.163.133.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NKvr1B009853;
	Mon, 23 Sep 2024 20:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	smtpout1; bh=xqCZ25DNLQ60cs1wlZPjklRmUwtE/NN0LF5eaKCkPvk=; b=p1S
	JnMlshWAUIbpiPqZfDfTL6jMwG4Qew80QGwAoR+URqHy2lBE/OmDuNWmrGQgLhRQ
	8HhrzZaEDMWyYtTFcSSMirmeHiZPki2fgVsxlZnVuV3+FIG3BJVuKtVZqOeLQVjx
	LeUAkLGDUu249ABGKZoNPOFPMrz/DPMjsMCNtDYlk4BKpQjbT58GbNlxxIWP0TtA
	nfcXuob9yts/jqFEzTSPN4Qv16lPJM/whL7F/UG5dT+rEkQ+6cj8digcWYmYSyia
	r4SWFfDV5yZwzGze895usXJzqD0mHgBCopnM86QnAOYpQWEbZ3jWmVuRpSBYyUND
	5Kid5yZZkehQ5uA3j2A==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 41ssfj0xmm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 20:45:43 -0400 (EDT)
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48O0OQ5X014718;
	Mon, 23 Sep 2024 20:45:42 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 41ufnna62c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 20:45:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIRfwfzX3FHEhJ3DdLJUf1s1Tnpl4KJZR82Kopyi0INKkqyPOTpOO16MzGUgnKl3Xp/rko1R1qKpFEfz6rTCJdWt1yb1j8RFnCZfwplQ06gsiL6WyfD2b4qN9JzQB5/GkBuEq+1VZ/8Nl4Hjqon6K69c3QSI7vjg72DWcmOEEYEA13YYtd9QcWhuqso/wCjvaCujOiopDE1ewlmCnDSpUokD5bRPZDixWALm6fAnyeRABfvBFFBL20t2ZtGPZx5dyIDOqFsIc+YMnObhafTWt2suGR8+jABig73ZmPtmaGFtP9rGSTqh+U/oPikqCT18xWsTdzrVSN0Adov8EWVKSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqCZ25DNLQ60cs1wlZPjklRmUwtE/NN0LF5eaKCkPvk=;
 b=W1EU37A7ei6HzGS7bgyAkwTMm3p6QmAuXYUB6d55B5XrOrHLn8Kns/dSFl765M4eJo5GHwpVUHlHL8scHgZqta8ADckar7lmrTQBv9mrr32jItOmwUuHWgQzIHAZBK53twEUmDsfttxhz722kBolvMBpLmE/MfQBEPZtexBvtKGxfFh8ZBXK8AiVz7mfQEv6ZhlEmLGTh+GqxpFhQ4DLheRj+QV2DUsHzD5fdsJqQTrACmpgbQtbhRR6AVoK4iZqqpVrX0C/Sg7/SO+PRSObYfPeAuv/lC1dYWPe6fmZD32LNhcFn+lOPSDSBh9i2Cjsm5xYru9WFPqdLAbdXY26BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from PH0PR19MB4988.namprd19.prod.outlook.com (2603:10b6:510:99::17)
 by PH7PR19MB7145.namprd19.prod.outlook.com (2603:10b6:510:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 00:45:38 +0000
Received: from PH0PR19MB4988.namprd19.prod.outlook.com
 ([fe80::1079:e3e4:be37:8589]) by PH0PR19MB4988.namprd19.prod.outlook.com
 ([fe80::1079:e3e4:be37:8589%3]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 00:45:38 +0000
From: "Wang, Crag" <Crag.Wang@dell.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
        Crag Wang
	<crag0715@gmail.com>,
        "Ksr, Prasanth" <Prasanth.Ksr@dell.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        Dell Client Kernel
	<Dell.Client.Kernel@dell.com>
CC: LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org"
	<platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH] platform/x86: dell-sysman: add support for alienware
 products
Thread-Topic: [PATCH] platform/x86: dell-sysman: add support for alienware
 products
Thread-Index: AQHbDYMVxCT+YQtU1UajejFz5eqvTrJlXY0AgAAL0HA=
Date: Tue, 24 Sep 2024 00:45:38 +0000
Message-ID:
 <PH0PR19MB4988833112285DF244DAC99DE3682@PH0PR19MB4988.namprd19.prod.outlook.com>
References: <20240923063658.411071-1-crag_wang@dell.com>
 <7c8b8824-2204-448b-92a4-33b27e3df834@amd.com>
In-Reply-To: <7c8b8824-2204-448b-92a4-33b27e3df834@amd.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=7d5878df-1089-4c4a-9381-dc5953f60329;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=0;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2024-09-23T14:09:24Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR19MB4988:EE_|PH7PR19MB7145:EE_
x-ms-office365-filtering-correlation-id: 6e298638-ef5f-4634-1015-08dcdc3235a8
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UXBJYjlpY3RUbUFJRjVTbzEvM2RyU3Y4dFk0VnNQRG9UZ3FnaWNRUlZJU3Qw?=
 =?utf-8?B?MW9TNVRrb3htbWR2MEU0MDVuNkZRTDgzYnJGRmMzeEZwbU80RnExdUJoNlJZ?=
 =?utf-8?B?dVB3aFhYWFZRM1dHVUQwRzZtWFRMUFRNaFFlYVdDWjk2Vklvc1FUY0xaa2c1?=
 =?utf-8?B?SDBGbjY2N1ZTeDd6TGxOT3NCOUpGbVEyQjZRM05tdlN1dzFVY2xmOXVjTFRj?=
 =?utf-8?B?SURiQ3FhZ3NvSlNITTM0SGZkYlE5ZnkxVlZPc20zOEtZZGFMRGoyak5QUllN?=
 =?utf-8?B?R2ROZEN5dlBjbUdRTFFMWjc2OUpnSWVnaklNaW0rZThDSld1Y3k5VG1qbnQz?=
 =?utf-8?B?QkpNOXkxOUJKcDllbDMvNkpjcFFsZUxiOC92NnFlSTR3M3JJVzBFNWc4Ulhi?=
 =?utf-8?B?dWZ3dEZWS2tLcVdMb0J2TXFoNGhpWUc1RmxpVlRrSU45ME1mSWFWWHo1MGsr?=
 =?utf-8?B?WVNTNTlQSjhIQTRPSWdpTGhNRVAxODFuajNSTjk1TzZDbFlmT08wQ3BRS1da?=
 =?utf-8?B?dllGS2lHSHd2NXZTT0tMSHNHUlZzenY0cVdGZU0yNzkybDdaRmlOZTh0eW1O?=
 =?utf-8?B?N3NHSEdQRVdqc0pRaENEMi9mUFFkV2pqUGZrT0piNnA0T2xzUG80cGdSRlhI?=
 =?utf-8?B?dTNjNjkvTEpDdGw5TW1BSTFjQ3JYVjFsUDJwYisvVWhBeGhpNVFFUC9rR2hK?=
 =?utf-8?B?MSs4c2crYWRMRzlETTlENk8zWXFmb0Y0YkpybzgySWcwemdqVmZCeXJCaVBx?=
 =?utf-8?B?WW8rN0VLK3hWcmZta1l4cUlhYVBDZndLc1ZmcVgyb01GakZZZDVSdU5RWDc5?=
 =?utf-8?B?Qnd6by9FQzl5cEczZ2pDWEdzTmlJejVjdHlWUGZ4eG5ueUNJYXEwazZjaXUv?=
 =?utf-8?B?UUF2UzhqNUJDSmkrK09UdmN1WWtUeSt6cjVVRkZsWHRBaUdMNnBBK245ZGRU?=
 =?utf-8?B?Tzg5RjhISVBBMHFaMG03M01weThqVHk3Ymttb0k1TXRSaVNucjQ4RFJDRTlx?=
 =?utf-8?B?RlZGS0wwVmR6NlZoU2F6WUFtcDAydHNFL2svVUhHSUozcUdhRFdrUEdnY0Vu?=
 =?utf-8?B?a0hiV2JaUTVucUNBbS8zYmNxS2NlMkd4dDJ6QWczNnp3YU9oeGF2eUdLQkFu?=
 =?utf-8?B?bXJ6czVwdmF5cXJka3Brdnd0dDV4dUtTS3ptOHcyT0xJYnJ5M3VjQm10V1Fx?=
 =?utf-8?B?R2xBbVV6OHlYZUkxOVJmV0hySWh3K3JDVGdrWmZWSytwSTBtSnRKU1ErY0l0?=
 =?utf-8?B?YnZpTjBRZC9SM2FsS0pBN0lFVFpIeWFkdXN1cU1ZUGZGVkFORGg2QVZpWXZX?=
 =?utf-8?B?R1Zmb1Zia3hkeTNlU1k5eXBZSUQ4UHdEbzB4bUMwTEhsOElOU3UyQjFQcTN5?=
 =?utf-8?B?VzV4TUo1STlzdU9aaWZmSVBsZVVneTIzQXNzeVllZ3dFOHZ1WVYyQnB6czlZ?=
 =?utf-8?B?cEt1dHViUEZ5T0lZNXFLZXVxNXZub0JBQ1h2WFVveUFXUm00bXdNNEgzcXlH?=
 =?utf-8?B?a2hGbit3MGwzVTB4NlpHMzFyT3RxMmN4MUJDOUUweGx3UTB5T2hWekR1a2cz?=
 =?utf-8?B?ZmdTYUw3NDVOVnJPU01ITkF2ZDBqUVQ3QXo2ZWZqWlN4YXQvTWdyd29xQ3Za?=
 =?utf-8?B?MW9ncXAxQUd3RHBSSVhISzZpb1VENG9VMFVUTG93WHZibU9rOTJ2RWx2bHJk?=
 =?utf-8?B?OXFFZ1NCMk56ZFRPQUUwRlg4WDdtU2FpYVRiQTExbXQ2eENlQ2N1TmQyTTY5?=
 =?utf-8?B?WDF0MXQydmZidUtHRDcvTU5EOGxSWm1yWWhxYlhadURZTVQ0eU5UOW1tQVZv?=
 =?utf-8?B?RElUODU0MENrNTFsTVBXdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR19MB4988.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?blZDQmRROWZpWCtBUUV6alRpcWljZm1qcW12c0tSSjNNWGYwTjFxd1A3S0RS?=
 =?utf-8?B?RWNYa0hwc2cxUEc1Wlh5T2lVdmFtWUpaR0gzRTZMUjlZY0VZRzI4QkVnVnNZ?=
 =?utf-8?B?blVodTY5OVA5L3FPMEhPZjJmd2liMDlPdnZYVVEyMVZzSm9PUWZzK1MxNlhT?=
 =?utf-8?B?a0JJQzVRTmRocnA0cFJvYWM2bXZPQ1FyVWtpWm5Qa1FoL0RYczArb1BmWTRn?=
 =?utf-8?B?clJibFcvSWFuV0xSWTIvY3VzcFllWXM5YldMU1Z0b205YjIxb0FnUkRDKzVM?=
 =?utf-8?B?WHFJYVc3UWJJVVRYZm1hdTBpcjZMUUg5MUdoMXJTWjVrU0JtZUZlTitXMkJa?=
 =?utf-8?B?WFRmS3RBZ1hjNG1SZnFNK3g5M1JneFVCRU9WaWdOZmRMSTRXSTJFSHVRWHRJ?=
 =?utf-8?B?NzhTOTM1L0lGQjhhQXJOTjZqNThVbFZZcnlubER0Y1lQYjJ6OVVOdCtZaitJ?=
 =?utf-8?B?dW5ld3JlL282ejU4Sk9vL1Q3WW84Nm1yR0tOdHBGOGV6Q0lHSEU5Y25RZURX?=
 =?utf-8?B?OGw1bTVNaVJYU2lHOEpFYTdFODc1Z0JBeXJiTnpuTGRLRE05QXR4dWhzWmJh?=
 =?utf-8?B?WXI1ZVNwTjNJQllOYllYZWpuUWNXdVpqRi9pRG05MjJreFFFZEVHRWFqSm9a?=
 =?utf-8?B?YjJJcUZydWJSaDV5cmIvK2p1aXNIaVdKRlBDbERVdmpzclJ0MTQ3cHBKbTVZ?=
 =?utf-8?B?QUhSQjhaMWxmY29KTkVZRTE0eHc0ek8rdnhvUytEZVFMRXFtTm1ML0JmWHgy?=
 =?utf-8?B?RWs3T0U1QW42WklWMkpjKzRUMFBhU1ZLNjdrSFdzaDZHY2FtUzBOZEx6enBZ?=
 =?utf-8?B?U3EwTTI4YUpDZFBlckRGRnIzaXhzT0ZzZlQzS25wK3Jsb2ZFZWM0b0luZXBG?=
 =?utf-8?B?a0IvbVpLanlUSDdBK28ya1BVU1VudnlCQnJsSGxXV00vMU45NVlqQ0NKQkVU?=
 =?utf-8?B?dzlGdnQzc1RNQ1A4cTVtbzgrV1k1eTdRVXR6a3QvZ0dGUXNtZ0lya29XR3Zn?=
 =?utf-8?B?YTBiVG9panhDMDE0V1NEUGpMQ2RIUENRTlNmcjBJMXRzTE9hbDVPZ1NQc0k4?=
 =?utf-8?B?SHA1d3lvMDJsMVgzK0ZlNXBQVERCbnR1bWY5UGpYVjU2ZVRwK0h1d092NEtY?=
 =?utf-8?B?WU9ld3J4OFpaVTl1YlQyTHFlUlE4ZXEwVmhLcS9TT01HV2ZWYjMzcUkvZzQ0?=
 =?utf-8?B?MVVvVEloNlQ0Z0ZlY29QUmtGNDRCUnlSSDZZOG9kRXZqZXFNdzBER0F0Skg2?=
 =?utf-8?B?RkM3RXJvVTZ5OXRpbmRvYVAySEdzSHRTUXpRU2VUaEF2RUcyWkNvMUpwOXZP?=
 =?utf-8?B?R3pheURscWIySWhoNFVWS21EZTk1L2MzUWhFS0tGeFVYZDlhdXFQL2RkdElj?=
 =?utf-8?B?MGN1cTE5OHBhRUllVEEvUzFTNU8xaWtrcERKbzg5azB5aGtONExNSERmaGhS?=
 =?utf-8?B?djVpTHM4UHJNSjByaEVRNXBWcXdIVllSZmZYVUN2K0ZJUm9VSnhCUEx4SHR3?=
 =?utf-8?B?cUhxYUh0Z1BTK2tJUVNhVFlkZlpOQlhEbzM4eXEyejJVb3VWSE9aMlhpcHVz?=
 =?utf-8?B?a2pqT0lXZGgwV1FOaWZtVFZ0YnBsNytuNGNrbU03ZXk4OWVNV21MOWhodjV0?=
 =?utf-8?B?QVlkRDNjZS9tZVdVMWM1VVRkNjNQb0tGd05aMU5IVHdNUTVMVVJlaGwyQm8r?=
 =?utf-8?B?VW5FeTdMOWo1RVlwWG50cVdLYnhNS1lUK2xoaTRFOWVNd3NTOVpzTytId1Ni?=
 =?utf-8?B?REV4ZUxIRVZ2b2xuZ05sUG90VUtDdUNoSnNJNmRQeWszSnQ5WmJJMFRXLzht?=
 =?utf-8?B?SnZoanFXbWFOblZHNjFLZktSV3h1b3ZHbFN0M3BpcldZUTB4dWswblk0UW9l?=
 =?utf-8?B?TWwrNm0wS1RxRjV6d3B4VGpEOC9XVFpEUi8zMklGTG55Q0JTKzZwblBwKy8x?=
 =?utf-8?B?UDRvZzAyRFNQalhPMEFEWGxGVDQzWTVUY1NKbkJWL3NxQWNVYjdDQTRyUWxJ?=
 =?utf-8?B?VGNuTlhHd3FBVGtoWFFVTnJGU3YwRG1FL3lrU0h2Y0xYd3JGK08wWjZnNGly?=
 =?utf-8?B?bHBBRDhaMzIzMURoRENDWTFocG5FRkJHbFJNb3JwcHMyU28rRlNmMHpwK1ln?=
 =?utf-8?Q?yb1U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB4988.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e298638-ef5f-4634-1015-08dcdc3235a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 00:45:38.6380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k4NeQ/vsqzFLh1pOobQB6PEH8D4g1PcdMXFR0y6r25Tr8VUb19yHDqZAXxmgup7OcQqc9tOdD3VJCijgvg6SLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB7145
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_18,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxscore=0 suspectscore=0 clxscore=1011 bulkscore=0 malwarescore=0
 mlxlogscore=555 lowpriorityscore=0 adultscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409240003
X-Proofpoint-ORIG-GUID: nPtaOaPp47AoHsRN0iU_TnyT-vWeQFSr
X-Proofpoint-GUID: nPtaOaPp47AoHsRN0iU_TnyT-vWeQFSr
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1011 mlxlogscore=506 suspectscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409240003

Pg0KPiBXb3VsZCBpdCBwZXJoYXBzIG1ha2Ugc2Vuc2UgdG8gYmUgYW4gJiYgY29uZGl0aW9uIGlu
c3RlYWQgb2YgcmVtb3ZlIHRoZQ0KPiBkbWlfZmluZF9kZXZpY2UoKSBjb25kaXRpb25zPw0KPg0K
PiBJRToNCj4NCj4gaWYgKCFkbWlfZmluZF9kZXZpY2UoKSAmJiAhZG1pX2ZpbmRfZGV2aWNlKCkg
JiYgIWRtaV9jaGVja19zeXN0ZW0oKSkNCj4NCj4gVGhlbiB5b3UgY2FuIGNvbnRpbnVlIHRvIGNv
dmVyIGFueXRoaW5nIHRoYXQgaGFzIGJlZW4gcmVicmFuZGVkIHRvby4NCj4NCg0KSSB3aWxsIGRv
IHYyIHRvIGFkZCB0aGUgbmV3IHN0cmluZyBhbmQgcmVtb3ZlIHRoZSBVUkwgY2hlY2sgdG8gYWNj
b21tb2RhdGUNCnRoZSBPRU0gdXNlIGNhc2UuDQoNCg0KSW50ZXJuYWwgVXNlIC0gQ29uZmlkZW50
aWFsDQo=

