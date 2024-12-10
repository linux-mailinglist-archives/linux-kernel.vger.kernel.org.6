Return-Path: <linux-kernel+bounces-438945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D0F9EA88B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 07:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 865812862C5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 06:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA9A22ACF5;
	Tue, 10 Dec 2024 06:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ladE2SGn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VlLLQ7Ld"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A160122617B
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733810940; cv=fail; b=dNOZRabzWtjGc9F9wPiVszarWFYdnToST2EB5Jw2wyHd1tO7daLehYjXUKRF5mHoC+8E95X/uoMf/VjpCyw1zEJNzmudRhuAAgojkcW2BraUftTnF4GGlfriPWnKGCy5cAYHFyrm8Ts8NObUInQrleLhLy0c95xA+MhpOGViUFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733810940; c=relaxed/simple;
	bh=Tb/AOBS8JAPUfGSHXXX+G+G3YlEZhcMWF5ELCUSmDQ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ou8AFh7T0f7pdi7fI5wtK3qaes5CHrJ6koj9sxFQ9rPRPgBcfzSVVrdil4uSEUl0iyekx3/U51jw+Tc+s6DmEg/zvmmr1t3ux7CrMDvk0nIJqkYnR6XfIvPPcZPesxeLx2mBUEuaoWoHC6qjbEGBw0jDbHl0MTQ5GkcL6VHETwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ladE2SGn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VlLLQ7Ld; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA1C7DC024706;
	Tue, 10 Dec 2024 06:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=P2vXDaT/zx4W1F5E9/
	iQ1kX3Pdyng8w9QNUwd25akrU=; b=ladE2SGnK74mGxvudnaXkIzmeceHaWqSbb
	kaVjDb3gvrnc5gVulEMNTrmSSLxjniCY0QoHfiQpVGTo3xHbS+g9KJFEj9/MEVSe
	4ku0tSFrzhRtSTMgfcxKbwAacWuhZe1DCjt/uv7Qpd5NFppZM186hra4ReWSxGu1
	IyFPeLsIA6l58Z2P4tD1M/09tOqoF11L3axbM5oSbOxwbnoaV+z9qEtbqmWnJQPn
	fvO0a1Y1WsPr8JFC0ebkZ3U38sZa2NaehT2cs6FWJqTYcDL25wydYb37vgAMkmIW
	q4YIDwvkNw/Ui3TiigKllrqvNfI6vMxUDfAFqe7kpMNPklPUuu4g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cewt4yr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 06:08:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA549GF035603;
	Tue, 10 Dec 2024 06:08:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cctfcnyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 06:08:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOeiqH2Odom82l8pwwnKxIEqPoFZI/mTZ26A5rDUDnKxnaZtyPCdwQKRPg6Giu6TrmZmXVZvcz9YenPIFUbWm13NLKtuJXq0bIH/jKkfT+bN/Mcn/L8Dxn5ZGDVyb6J0oWJ01qrT2hlZp0iwDsbz0P2yqThCzvph5t9/eECelXD2EUVSEXctWI8QgNseASSqSnis60eicZr/mLPHPJjqmfOxBXamJnRhYwUmP1SIbA4cvvhDcuI7sdgufT9fcrCriY7EN1NZvarl3GuREvLFJp3takXzL4cy/IUw3S4Ej1qD0UZpTunxCbM4ZUimIz8Ej0BZg6hsb2qFjXUrsjSjtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2vXDaT/zx4W1F5E9/iQ1kX3Pdyng8w9QNUwd25akrU=;
 b=aSeDa7Dz3rsXDOWRAqrzpmkWIVZ0378x6UqSX7e2Mqy6e+DTdNYZCkmPHyCE6fdesZKonEesl18su3lKSHiUxJQHcf3oaMe/p/HutYWJT+Hk/+UKYOVXYfjtUvnhylmMyVK4zCE0DU43H3Imd6K2S+gT9nEKZr5NzGguUnpdnwkkPifztcVNzCu2j7n+68qj6V89QbBdx89BjiASS39MDSOgk6msXhm2EizOm9IxvrErAQrVd/2yJYkQLvl9kbj08j/yLqhfzmU2MsuLNGSAQ9lbE0tkztEHCWpFDpxDyiR8/z+oEefjUt/vgw9uGnEuJVC4dLnvd0w5EvhJAXtNGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2vXDaT/zx4W1F5E9/iQ1kX3Pdyng8w9QNUwd25akrU=;
 b=VlLLQ7Ld9ep24LwJkvrxUygKNUlkctQ0zSmOvr1teAJncRLEE+EwfivYMCnCb8HIu8YMiZb9gAfeQ6hhSmqLW0xg4y75qNEJ32c4b+htItOFGJf+lULJu4cJIs81uteszhu8sQwtYIh4a5oeJMnZLx2kgTN1TyKSo38e1p1pFbs=
Received: from PH0PR10MB5563.namprd10.prod.outlook.com (2603:10b6:510:f2::13)
 by BN0PR10MB4904.namprd10.prod.outlook.com (2603:10b6:408:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 06:08:47 +0000
Received: from PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240]) by PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240%6]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 06:08:46 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "tytso@mit.edu"
	<tytso@mit.edu>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: CVE-2024-49967: ext4: no need to continue when the number of
 entries is 1
Thread-Topic: CVE-2024-49967: ext4: no need to continue when the number of
 entries is 1
Thread-Index: AQHbSsn53c3/1DvaEEaAb5mknNpYrw==
Date: Tue, 10 Dec 2024 06:08:46 +0000
Message-ID: <87a034f185ff5e865bc5d0db8121c39086c4f5c9.camel@oracle.com>
References: <2024102133-CVE-2024-49967-a58a@gregkh>
	 <be6117aa16c1a42d9c192e95334a440ac790de11.camel@oracle.com>
	 <2024120952-decorator-lyricist-1e9a@gregkh>
	 <20241209162623.GA1667758@mit.edu>
In-Reply-To: <20241209162623.GA1667758@mit.edu>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5563:EE_|BN0PR10MB4904:EE_
x-ms-office365-filtering-correlation-id: 67f2adf8-3c9d-48f3-44d9-08dd18e11b8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SFRQdkJsYTNDbjBhV3BzbjhMblVUWGw3dzJiR1ZyclJKeDRjUkREcWRrUFh6?=
 =?utf-8?B?dlhsRVk0Y2dPblY5eVB2UkFCYmNqN0N6N05hYnlDbXMvVXBCU003cHZ4MXNC?=
 =?utf-8?B?Rno0VzJ0N2xNWkZjcGFZank4RWhFY1NhWmZSK1ZvdU4wNVZsSjJBR3ptUGZt?=
 =?utf-8?B?TEp2RHFkTm4vRi9zVmZTZ3NiUDZuWHBQQ0lZdzg2ZXNrVVdQNkJaWmlqSlcv?=
 =?utf-8?B?WHNlNndFam9jYjVObU13bnRwQjRqdEVXM0dpL3pMUU9wUUYvQUVQK2Jvb2xU?=
 =?utf-8?B?bVYwOFdyWG9mU2FFUHE4Vmt1ZE5WQys3K1luSC9NYlFXRlkyQklZTHg0M2xW?=
 =?utf-8?B?MkdhWFpSS1BqMjZWM3pVTmRVaFlEOE5ocXVnRFJSSzNLM21xYVQxQ0FzUmxS?=
 =?utf-8?B?bWlxYVRkT2NRdXZLcEN6MkxhUmw0WE0rSTVPZUpDZFhTWCsrbzE1T2psVGVJ?=
 =?utf-8?B?S0diSGVYZTdhMkpHVXk0SWdhRHo5eVNkdnovMDB1QXZUMU5Cd3dyY3k0dTE5?=
 =?utf-8?B?WERLUWxvUWo1RzdjRTE2Y0toaG1xWkxZaysxeEUyUDRFanpjQ1pCOVhocU5h?=
 =?utf-8?B?cVo2eVlOTHFwendKck5DejVzV1dCMmFOY3Y2ZEkvQTlFRnl3eHUrN0R5ZnpB?=
 =?utf-8?B?c0c1Yy9XbURydUhCU3VVUmNYMWlldnlKZlJpdjVVekc1cTQ0cjA2L0xGRGtO?=
 =?utf-8?B?VThGUDdjM3VpbEpERVd4UWlwelhHS25SdXJiYk1UMXJlREhGYTNMS0tKeFpC?=
 =?utf-8?B?N1dNM2pNczN6dUFCcklqVEtBRU5JdU1lWmNoMVl5anhKb1JnU05HdFcrUGtS?=
 =?utf-8?B?SWFjQyt6bEVsZEJVZUpzQlVNc2lhRGE1RWI4UEZtY0JsQklUSS80aVlkTnd4?=
 =?utf-8?B?UmlMZ2pvcGl6ZmVWeUljcmFmQWFlRktIWmMzelFrVmhKTWNDdU5vMTdrQVJq?=
 =?utf-8?B?Y3RNQzR5K2RMbXJxWHF3dHlHY2tGQ0o0RnZWZFM5eElLVlhMTlBiMWZzMGgz?=
 =?utf-8?B?enRkNVdMMW4zR3ZuWUFDeHNuZ1dSMXJQODRwOVZFcFcvSjdNcnArQmI0NWFa?=
 =?utf-8?B?K0Y4cmhhdzRnWUE1eHdOSjhtVS8wdHJIYnJTdVpaSzFod3F2YjJwOFJKbVVk?=
 =?utf-8?B?NEhSSWlyVXZWUk54bGJyL29vMFJxUlNTZnFscUlpZEZBZjdWblFWZ29IUjJT?=
 =?utf-8?B?ckZYcFFTNnEvdlRYZTF6ZUNlb2dXTFFUTkFVMmxUeXpMOHRHVTMyMlozdWpT?=
 =?utf-8?B?NjdDY0h6VVpqR0RuTjNJV2ZJeTRPejRsUEpBRnE5RTFkTS9hMXZkbFpwMzBi?=
 =?utf-8?B?dWM3Y2I4TCtlc1VteW9UNE9zd1FNaGFoMzhNa2lUdzJaMEJwWU9JN1J3dWlR?=
 =?utf-8?B?M3I0VWQwTnhURzRxRW9SbEcrdTlCcDdGNzNOQVluOFVwVmxtNVNkT2IwcUo4?=
 =?utf-8?B?MVdDbG9BRm1qcU1ORk1RZTl2RlBoRWhxVnA5WFphWVc1bDVwY2FKQ2pMWlZX?=
 =?utf-8?B?dDR3YUMxd0k1NU56OTgzL09XK3I0aWl3dFBpVUhLYWp0TUdMYWpxZkc1WlJW?=
 =?utf-8?B?NHhHZzllWXVxWVJiVVlTTlVXSGJUaTFKUlRvalpiMFlRaTVYM1YrNnNPSHds?=
 =?utf-8?B?ZnRvOGtOb1NmN3pNNk9zY3hxbkl6MFljWlcrNnNwWkJ5YjNSOXJnTXpNdEly?=
 =?utf-8?B?bFZsbFR2L2pXNFRpL0dxNVZiRGMxNEx5UXBJQ0QxaGE1ZlVoUUxoa0YyNnFn?=
 =?utf-8?B?VCtsOVA3V3pjMDFJc1U0ekZ4T2phM1FQQVh1WndEZFZDWDR4ZGpOZ2JESzdi?=
 =?utf-8?B?SG5kWG9IYnQrMjkrcHdjbzl1eTlITXhDN0k3YzFycWtMMVdPeTZPdi96SWpF?=
 =?utf-8?B?eFpLb1JSZXl5SkVKZDQ4RXpFREplbFZXQmdIcmxudWlxc2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5563.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TXJmbXhXeGdYK2RuSTlnSk5hL2hlZWE4V0ppYjBRNE13a0xkSFF5UnFLZmE1?=
 =?utf-8?B?K2FSQlpLZjJhZXVVSFdtQ1ZMNWJzYmt3UUxwQzMzRXp5NGJqZ0k4SnRCVDB4?=
 =?utf-8?B?aEMxd3dzMEJZUFRVNCtQQkpDVElSRG9JL0txN29kRjI3emZZQXQyVlVqTDMv?=
 =?utf-8?B?Zkh1S2o2QmdZQ0srUGxWQTlHeXhaQURpVVkyall6dkVLWFZWdHZOZXdTekJ4?=
 =?utf-8?B?dWd2Ti9wVndNZS91MElxeWF2UzVvRGJEOG1IaUh0ZDFSN1NEcm0vNmtxRThR?=
 =?utf-8?B?MmIrOVlqRGRlNDBrK3Q4UWw3dXhLRzBTYzRpQUtzcmh4UTdvdXh4dFo5SnYr?=
 =?utf-8?B?dHNaY3E1VllWelhpZk5adWxVSWdaV3JvdGk1aTdkcFVrKzd1MG9jUGt5Qm1q?=
 =?utf-8?B?a1E4U3NhOGhEVXZMRk9JVzVRV24yai9idDZ0WklleVJBQXRFSi9FS2djaDdW?=
 =?utf-8?B?aEx6ZlRaVHpoaFNSaHVwU0hWN3J5bkovK1AyMVlicWpYWFF2WUZCLytMSlBZ?=
 =?utf-8?B?NUdQTFRUb05PaHgwMUJlRXI1dXpwVUxKZ1k5SjN2aGsyYlY1NnBqOGx0MExw?=
 =?utf-8?B?NHdtTEQzS3loZUZMVW5TSjVxMVFUMFRPNVpaaS8yYm1aYkFwU1BmeFBZTW9v?=
 =?utf-8?B?QUtobXdLbDJzdlI5SEJ5K0RPR1VlMERRMWcyQ29SeC85QWpFUlR4eDI2dDEy?=
 =?utf-8?B?WFNFNUhRdnMyaFd1Um1QY1RWWWVkVmlqZXJ3d3dmNEpMSFNXaTFETXNtdzNG?=
 =?utf-8?B?LzREK1A1UUowU2dhcExteDZiL2pHZTdNU1VjYnZ5blV2OEFsem9BMlBCNlpG?=
 =?utf-8?B?UGpJZVFrcGpRcGZaRy84NUVKbXR2eTlNT05hQmM4cHltNnpxdDZVa010N0Vq?=
 =?utf-8?B?TzhOdjBMZyt5YzlyMm8zanpBTHpVUTkwUHBFRDA1S0VSMjFvaEoxa1BIdXBT?=
 =?utf-8?B?SjBtaHBGYzk3UzZvZ0RYWTdkSkZxT213Z3lPU3B4Zncyd3cxcWNDS1ArNGdB?=
 =?utf-8?B?VkZjYXhpRVU4bTFna3RmUWdSMW4rMndCdTN6aDExK1RYVlJuWVZHSzF0MlQ4?=
 =?utf-8?B?bXlUMmNUL05mZDBGR3lnRmhCdSsxeXV3bURhcThpOEk2UlZUcWlxVHlmaFBl?=
 =?utf-8?B?VnhpSDRxUFRlVlZKcE1IODIySnplYzc5TG41TFVLcnFwYzhYeUJjQm1oSktQ?=
 =?utf-8?B?U3hGRGQxM3c5dmN4c216K0VFWExQNHJUTGdKTGF0T2U2NHI2QVZCVzk0dXlu?=
 =?utf-8?B?Rkgvd0FNZHZHNTdmTHBULzVMSGRZNkoreUhSTXJRZWt0WXREUDg1TDVveFRX?=
 =?utf-8?B?U3BtZUZ5cG9kckwzWjJoV0JvYjBRZjBjeHlyWDJNTkhhNWYrUkYyejZnRGFt?=
 =?utf-8?B?WXJ6M3ZuNEh2WDFQcFhvTDRldmxPZ3ZPN292b0xiTWJjZm0zUEZUN0JJeVNV?=
 =?utf-8?B?c1Z3ZDYvMGFXNUx2Skxkd2dYZDRQcXlRZVJBZUQrdEYxTUh1TE9KR2I2R2Va?=
 =?utf-8?B?YUNHcjJOTU8rK2drSHZOSUk2RjBGaTdhaWlZNjhYQVRSd051WVVwVHhUVjJ1?=
 =?utf-8?B?c1ptV01yd3pkTWFTRmhDcytweThBNGplWjBkVEJVQndpMnRQQnZqd1dyZVdD?=
 =?utf-8?B?RkljMmNxb0xYTEhaQ0NyYTlmOVNpUllZZnMyTDJhdXlmc0d6ODMrREt4aEhu?=
 =?utf-8?B?Ujhwd1dpQXo5SWhtNXAvUlBGNTJqejlWYjF0anBZSXVyTC8xTmsvOEZKelZz?=
 =?utf-8?B?NVZDRDBma3JvZVBteTc0QmQzZDlLRHkxYnVxV1B2elo3cHkwTEJBRzV4YUo4?=
 =?utf-8?B?U1ZnaCs5NktVUzIraUdCeVp6OENqUVpsTHdWMUtRZ1JlOGpKVk1VWHc1ZklO?=
 =?utf-8?B?RHdHNDdFN0djYUZPNERDRGJUeS9YQ3M1MFMxN1lKYmQrZEZ0SVlVREduWVcy?=
 =?utf-8?B?em1HVWhNSmEvV2F6TEdOOXBjeUNmeENFdFBMOVNPcUx0aXF1bjlINkZwVDFz?=
 =?utf-8?B?MjBUK3Z0RHlmSUJEQXBrMyt4aDYvMldQelQ4K1pvOE1KeTcwdHFBS0VQV3Rh?=
 =?utf-8?B?Q05lS29lUHhUYTBPOVpyejlRcEVWVitLTzR6bVh1dHNjNmNGL0Rkbmhoblo0?=
 =?utf-8?B?R2JlLytMRmQyc09vUHlQbjlyK2EyTUV4eVVMTVFkVitCZnloZEttcDhmOUxw?=
 =?utf-8?Q?VowZiicFnTaDI5LHKc53abE=3D?=
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-qIiE1I4nzRK4UFwJZmLm"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8zwt0ml3haq5hNJNd9F1xawXMI/OGcEYeB5zkRyE28TVosEBM90fAx8ukUyW1ZRC1yrRiaKy05imiI/4gSHNYZPzb4ItbEyDq9O6CG0bEsNBMOu18YZiBbKfyC6nrF+6EOG9LaEEc50UgdtIawTBBjoEwhPBpUjRvOXPuXWM2SaHpTH1aWS/B21SjbUe5OnKPk8KTtKbRsfTRYWH2vkEbeg1UZYyoebqrS8baWfAmiTkPe4RBr298lL6JJq3hbi7kWjGU7wFP/DZElErTYrjWobM11UHQjQY8VKVyRSvyh+tFLOmw47WXD8t01KIG0yX2hzp36HV3vTQc1tTbygduliqKOvUv8q0QQGikV5/VcRSrOlf4fJQg4GmQF/gNHTWFG9BORnkR4sOPlZoq3qVuEyWIgGb8f/HL4sSxmoR8ru43/YUPHyOxu0x4+oBxAbF+4wIlkPDG1MxvJHnL+Lrgphw34kOMq4Hzi4zEJCWPhqAXZVYkiD7fS7YBnFH4XI7gLuUI+W1AwcqBVkJ8PuesFfYUVRfQV5XqDi0gAx0sq/83nHIFhYMpG806B0ddKntdeWQ5whTBpyFO8bBqvuI0hH3z/0yIQMDKGNv8jWM4E0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5563.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f2adf8-3c9d-48f3-44d9-08dd18e11b8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 06:08:46.5287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leyAuRV6ioAixlZ8egvHWbK85x1Kos+CKCVVGIjMFy/7iuspyjDnRDSq/ncJZOH6/5eY//mbtvsZ4Lt1TTOiKU5QgN4F3/CLU0wrKNw7VA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4904
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_02,2024-12-09_05,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412100045
X-Proofpoint-ORIG-GUID: d_sg681GL459V1u7-DUJRNL6m9p5pNZ7
X-Proofpoint-GUID: d_sg681GL459V1u7-DUJRNL6m9p5pNZ7

--=-qIiE1I4nzRK4UFwJZmLm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09 2024 at 21:56:23 +0530, Theodore Ts'o wrote:
> On Mon, Dec 09, 2024 at 02:08:02PM +0100, gregkh@linuxfoundation.org wrot=
e:
> > Ok, so should it be revoked?

Yes, as this was an incorrect attempt at fixing CVE-2024-42305.

> We're not aware of a way of triggering the OOB error, so in that sense
> the CVE is not valid.  There might be a way that someone might be able
> to trigger it in the future; in that hypothetical future, there might
> be some other fix that would address the root cause, but this would be
> a belt and suspenders thing that might prevent that (hypothetical)
> future.  So in that sense, it is highly commended that enterprise
> distros and people who are not following the LTS kernels take this
> patch.  But is it actually fixing a known vulnerability today?  Not
> that we know of.
>=20
> Cheers,
>=20
> 						- Ted
>=20
> P.S.  If some security researcher wants to find such a way, to educate
> people on why using LTS kernels is superior, they should feel free to
> consider this a challenge.  :-P

I agree.

Thanks,
Siddh

--=-qIiE1I4nzRK4UFwJZmLm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmdX2tQACgkQBwq/MEwk
8irZ/xAAiPoyGjpsPWy1/c8Ba6UDt7S0dl9B6HrCSj0Uc4BniPXULesDL2wrug5s
EKTDTQAxCJNU7KA63PBMSgutZ4x3sTc+JzvWBWkmP2OxIpnuoXU38btg29tFiUGd
fzhXWbG7DJanZ15m3ei7AJj/gGlVof0z9CxFki7DZPPX0QkR10BqZED0TPbsV94+
g5aPhPwuyfUeQ3B8IwCcE3nG2+BEN5YcW1UM71x8+7fk6y31w2Jmd2uKFPdPUGGk
oAwn8jrcvo0tbrIUbXHmN6sAom4Zl1vSeNaT41xkLej7SDrShE/st9JV+wufE4/8
klpNNcl7etRjZamb4ElZa0nCo/TzUJ7eQbOdHH1RchJ0npSjJazby9U/8UUcjKTo
9h3cNs1Jnr5nSGTKBWjHTfhkICVFcEwsjQGDbLGSIPVFl03D7EOQPpPn5y5NpJm1
AXqoCeGEXsduZ2r3hnW9Yx0B7SukPnr1LeAUSGpEa7q0aikmHeduTewXISdJX/Wp
POGFjtphiSRm1Mjk+O2ak9Ux9Wc7TlirlOgcwf6F+XL7gWn1YFExO67C3oDd4yex
byrw4+Z8r/SewvWiteToUldCG75N1bkDeIFB/4h14ekAQuvTzTNqDGLNv6h+gWqp
g6kMBT9kzIQ84JCCtTuOW19huHxpExRXM8pdAbwhFEB3MQg2HIs=
=IN03
-----END PGP SIGNATURE-----

--=-qIiE1I4nzRK4UFwJZmLm--

