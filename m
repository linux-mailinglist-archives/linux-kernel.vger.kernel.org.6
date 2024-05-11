Return-Path: <linux-kernel+bounces-176594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 000838C3205
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 17:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9757281F5A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 15:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54BD56444;
	Sat, 11 May 2024 15:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="m/u2SsJE"
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com [148.163.133.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9556848CF2;
	Sat, 11 May 2024 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.133.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715440027; cv=fail; b=lx7kG3Su2SM+Yxv9CqDYVdtZBrM0U9M+yn1Gt3ygR9D8rocSxq01lZWqtONlqz9dzPQywsBZG6YnsblvoF+Nm1AEdPNlJDuqnWzkFp7z+lEaFXbNCruAQH0SsULQImkKURQvPeOM2uCFuuMpbiR8Lzjz29J1NobKVRqlFGagTjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715440027; c=relaxed/simple;
	bh=x9L+daUYqwKBmPCRuiA6a9wy2xhXgMZLtNOO2TrH0o8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KJF67dVewGUspKlRbsO2T+uhH47BbqeX0nG7DwKjQ32dbTp1uKHnoXx+MWkqlhNph6mALbM86qf2B1jm6pvUx7sKTrm+KzqbRURIH4QfTafd54nmoBqED0LbQVs5d1ItELPyiNZj2hm0Y/sv2skwXwwfLUn4RK94yfZ34Gd9QOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=m/u2SsJE; arc=fail smtp.client-ip=148.163.133.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44B6muFL006993;
	Sat, 11 May 2024 11:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=Fkv/NU0osxnr8ILAD4KfElua0Cgw5tLNbo+AtShUNZw=;
 b=m/u2SsJE26R7B75JT80ztN7FaAqnXfYzpT8OeCuBuxjUF+YcWGb9r002rnq593hpvY6V
 DgJ17j26o+PCv7LgLw4joXzzv37snXSZ3CeN3siTrqG9iq10SH1Q+aQ8xBWy6Jj8ikcq
 Rl+tn+S6A1Uibe05BxP0O9GIEM85qJmV/NJqsz4wtLAJenA/mR6pGgtvKq2G2pjVdFog
 GasUiPF5sdvwdZlw/69qRFdYP+nCmNs2bPVwoaHqCJkKLQytiGKWgAOgkzNWYSZ0+6ns
 eCG5XKqVf5u5p/9BpmomGMYSN9MmeqsK1Y+ohrOquHYo7KU4bPm88H/5JjCBmM4QheKf eA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3y23r40vmm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 May 2024 11:06:12 -0400
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44BF5e5G005134;
	Sat, 11 May 2024 11:06:12 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 3y2b0wr018-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 11 May 2024 11:06:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrN9Nujzjs0Q9A+Cn+MEPXvN0NGSp7xH96P0YPofKonTH0KnLK4y904eaYMXSuKie3dFPxZcITEYcbP4TLBijjL12d3GgVzBbBqTP5zZluYq7U8MucBZ5rhOyYEPMVosai0fvC5vP6Wc/94943yGr041e249c1AJ+u6CAoymbeFKrUx2mqs88bCiymkFIHrPdb4SpNJ6dDW6HOghu3ys94H1x/H4OHJ1iay/3a4/yLwbgIVBdhNIzKlO5xBTB3akW/X4MGJsL6eTu24CRlZFnPfrqoSop1ojLT/wl45R1PKfJp5Y2eKu82xaYEvxBftpQaylDhSyHj+7HXQGI7h/og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fkv/NU0osxnr8ILAD4KfElua0Cgw5tLNbo+AtShUNZw=;
 b=dDYsuC53iVGzdwjl3hQkPNqZc5inZXfZc7fQXgfMw4QZ+kLPYyY61jlyq+xOLa1RVjn9yKV1Wk0B7z0WQ2hitCLUk2+VL5w6VGo+SDuZomEKuFMjKq0f2UONNKqi8k+pQsELDI7e6jDnHdydr+QYCMUoVNT7bIxGVC198Hd1raKuzep/aF4cXafDny1Rq93fNMO6Y1LWkapVxDYQIjVmf/rMTfIlzxmmNwOG6Tn2LuuHdKamYcc4jbHUVjqLmqZuOiJmK1hFsRpm752gH60zjEG113TF+2/duuWHub/Moqr0tv7C1jYpKs2fsiOPrgMWPidAt9riEHJv7syErjziGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from BY5PR19MB3922.namprd19.prod.outlook.com (2603:10b6:a03:228::23)
 by PH0PR19MB7389.namprd19.prod.outlook.com (2603:10b6:510:284::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Sat, 11 May
 2024 15:05:16 +0000
Received: from BY5PR19MB3922.namprd19.prod.outlook.com
 ([fe80::afc3:5bb2:37fb:2f9d]) by BY5PR19MB3922.namprd19.prod.outlook.com
 ([fe80::afc3:5bb2:37fb:2f9d%2]) with mapi id 15.20.7544.052; Sat, 11 May 2024
 15:05:16 +0000
From: "Shen, Yijun" <Yijun.Shen@dell.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
        Lyndon Sanche
	<lsanche@lyndeno.ca>
CC: "pali@kernel.org" <pali@kernel.org>, "W_Armin@gmx.de" <W_Armin@gmx.de>,
        "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "lkp@intel.com" <lkp@intel.com>, Hans de Goede <hdegoede@redhat.com>,
        Matthew
 Garrett <mjg59@srcf.ucam.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Heiner
 Kallweit <hkallweit1@gmail.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dell Client
 Kernel <Dell.Client.Kernel@dell.com>
Subject: RE: RE: [PATCH v5] platform/x86: dell-laptop: Implement
 platform_profile
Thread-Topic: RE: [PATCH v5] platform/x86: dell-laptop: Implement
 platform_profile
Thread-Index: AQHanBLh5VIydjU6UEi/YU1qu3GPk7GNIdqggABltQCABKWpUA==
Date: Sat, 11 May 2024 15:05:15 +0000
Message-ID: 
 <BY5PR19MB392299916A85FF06387DC9C19AE02@BY5PR19MB3922.namprd19.prod.outlook.com>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
 <20240501215829.4991-2-lsanche@lyndeno.ca>
 <BY5PR19MB392256C65661E76FC292C0889AE52@BY5PR19MB3922.namprd19.prod.outlook.com>
 <63894ef1-c482-4646-8351-4d6cfc6c528f@amd.com>
In-Reply-To: <63894ef1-c482-4646-8351-4d6cfc6c528f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=15a2a190-d069-49e8-b9d3-ad589111997d;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=0;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2024-05-11T14:51:20Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR19MB3922:EE_|PH0PR19MB7389:EE_
x-ms-office365-filtering-correlation-id: 3ffdb32e-5489-4172-572c-08dc71cbc3fd
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|376005|1800799015|7416005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-7?B?UTd5YTFQL3lCTWsrLTdQSzR3N2ZXM2tGbkFreTBHTlNmNElNYUVzODkwdTBz?=
 =?utf-7?B?RTAxeVhDbzhKcTZqTSstMlFoRll5aDBHMmVseU4rLWRmZjlUWmtpcHV0bkd0?=
 =?utf-7?B?NnBSMlhkNHE1N2FvS3NVTTQ0c1FKQUwyVVd4NHlZYjRtVGN0VVdjUkJPOGNQ?=
 =?utf-7?B?MWVFQnNQWXgxTVVLU055MjB2bS92SVZIdjI2Ky1keHpMT054c1dwMkhVdE1M?=
 =?utf-7?B?S1dhRTBranBKRDZuU2pQemhVS1ZibFVyd2I5TDdMTlY2OUExUVRyKy1jb3dq?=
 =?utf-7?B?N24zcVprZmhVelkyaCstNEc3YVkyRlVsVWoySGVNRVJDSjNhUEREcmtYWDVj?=
 =?utf-7?B?N2M0ZjFiL1JJVHEvNWVwTGJxZGI1RHErLUdML29TOXNPaklWRE8rLTZkQm96?=
 =?utf-7?B?Wi9kNkNaV29XdldsKy1Bczc3Ky1HajNhaUNHdnN0ODZnckJhOG9BeDJsUnZS?=
 =?utf-7?B?T0VzeDh6T0ZnVlpwZGM1UG9JczhiUnRsY05oMDdpdHVlVy9waEducDNQOWl4?=
 =?utf-7?B?YUZDUU9lL0k3OUVGSFlZV3pYa1hST3JIRmhsbzNrTzN0Qzk0cjdKQWhCRTRR?=
 =?utf-7?B?S0FwU2NzU2s3TmdlSG5YRVNXTk5qcUFOTmk0aDBiNC9SaVVKTEhyblZranBL?=
 =?utf-7?B?NXpuejJZQjJxYzVnTEJ2WlAxMHdEb3QzUWFrYllVRzNoSEF1MzA4b1hHVUtU?=
 =?utf-7?B?YmUxWTVRVzIvTUlUeGFQbDFRem9jTWlrQWdnNy9aR1VlZFhSWGFqc3IwaEVH?=
 =?utf-7?B?NFZLZ3Q4SWJobXM0S3phRkpOZzI3MWxVaEkvRE1iNXFYMldvRWRmN3JjTWJP?=
 =?utf-7?B?ZEIvMFNrZUY1cy9BalpaSC8vRGt0M0lRNzNySHNpdDk4M3dhSXlXMXVYSUN5?=
 =?utf-7?B?MllMR01xcmlPRmErLW1pbklKamJKa20vdXRRdlgxeTdQL0hvRjM3VExrVkxM?=
 =?utf-7?B?WDFxRWZ2VUtKa2Jjb3ovVHIzSWxqYystalBPQ2VwU05CYnp4SEgybDI0aGE=?=
 =?utf-7?B?ZCstS05IUUxndVgxQkJoQU8xVHozdGFiMkJ2ekxiMUxpSWV6a3BPdmpHUEJJ?=
 =?utf-7?B?ZnlpZU0rLVM1NGxDVE00MEJ4VG5vVFgzN2hsMDRtbFY5RXNEcHVBOUZrVm1G?=
 =?utf-7?B?anJ3dk9ZZ0YrLTBQOW1yZTdIbnVadFJGZUpvMFdRUHRTRUJha000R3ZvWU4y?=
 =?utf-7?B?VWNTbHZuT2cyRXlxVjdpNDRyanpxSistbGxIaVh4Ky1iT0RLeHBmdEpDT25V?=
 =?utf-7?B?aDNaRWV1QUhIQ1M1SXl3WlRXL1lVbFZaSjBBQmtDbWZYTElyaTM5bFdqbkpm?=
 =?utf-7?B?QjZ4cDR1VDZwelVjc3NrT01XMFBuWVA0U20rLWRtdHNsUkFaRystRlNETXM1?=
 =?utf-7?B?bFFCRnM1Ky16ZHdjNjkzckdUOGdPcUZiYmZOKy1vdWxMY3E5ZjVDU05iS0E5?=
 =?utf-7?B?eUxia0pBbDNmaWRZTGR2NmxHeDNnRllTOWVrU3JML0NsRzFoM3lITDlzTG84?=
 =?utf-7?B?TVZ1dXRQbVBmUjNRNW8yb1FYM1psZTlPQXBoMlUvRENURWNaYVZVYVVCWDJD?=
 =?utf-7?B?a2FoODdVVHo2QjJqSndBUEJGYTc2N0drKy1NdExTdE41VVR0bThQOXZBancz?=
 =?utf-7?B?N3RUcHFkcVFaYm10WHlIc25HVFk4YkowR0lGRFRHVDFadWR3Q3lBWUczQjh1?=
 =?utf-7?B?ckNQUlVKbEZwM1hlRUZlVmJ1V0dyelNneHhXSW9KUUdyamtLeEJjV1dEMDBr?=
 =?utf-7?B?ZlRUcFFOM2M5azdWampoc3dWWVErQUQwQVBRLQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR19MB3922.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-7?B?YlkxVkZZNTNDVGxVdTdyc0ZvKy1VbE1UMFhJMWRSckNFQmFDMnJuSVJYaTZN?=
 =?utf-7?B?TDdYWk1qMWNaam82UHdOaGltNFJHcXZMNUlydUFhVVM3WWpzVWUxczNZVmI0?=
 =?utf-7?B?Rnc0STFiREwzUEx0TE9sUlo0anBuVkZILzVCNWQ1SGlIN3JBbDFLY0JaTzVw?=
 =?utf-7?B?ZWtCMGoveDEyTFVnelpTTVpnVnpacXhWbU50UmZMbFh1ZHFpNi9aN2pLdkhP?=
 =?utf-7?B?RWUxWGtHby9GbkJGM2M4QWNYVVBiUU5VRjhTcU5BU2I0WWIvTGt6S2E4OFM5?=
 =?utf-7?B?bkFPYWpaaEl6Uk9kYmRDWGhhTHN6TDA5TistRVUyZHhCajJaaE9mM3djM09x?=
 =?utf-7?B?c0J0MlNrbnZhZkhKeUIrLXdnTTJVRHRqL3Vqc1g2ZTVSSVRLR2hTd0tPUXRK?=
 =?utf-7?B?Y1ZjbHo2QWNlRFVWVXB2L2R5eUxFU3FpM0dvOXdMVm5JbmU3c3pmUTJFRmt5?=
 =?utf-7?B?UlQzaTBtclJJTzdvN0NCVWtGZWtISkhkN1FkTVVhVjdjSGgrLThTYktrdFYv?=
 =?utf-7?B?VEIyVlYxVnRpdkJRMDFibGJYMXZxN0Y3ODN0NmY5NjZsdlMrLXhCcFZORndt?=
 =?utf-7?B?NzMvZkx5aUpCQUZJY09QR0tBc1pvb3FDM1F3SjJUUnRHZENpclVTVEg2SDVF?=
 =?utf-7?B?SUcwUDhvRnN0WHVBcUJLcXEyTjFtcVlLaystMnBhdk04Ly9xUTlHUDY2dDQ4?=
 =?utf-7?B?cnByS0tNdUFXeE1HUzdNV255ejVRb0h4d3RxcmlFKy10QmVlMzhsNlpweWUx?=
 =?utf-7?B?RjhTMkd6aGNvaXd1Ky1mN0kvTldISUVRRXRsZmVJZDBIZERTRWFxY1EvcFlP?=
 =?utf-7?B?T0pkazdVa3VkNkRhOC85bTE2aystME50VXlxUklKNWdYUE1UTlpnQUdzdnBz?=
 =?utf-7?B?M1NqNDhkS05jaDBKQ2VrVDY2R3lGSjVpU2xJWU5XRlhZNzRxVTlwbVZyNFdY?=
 =?utf-7?B?MmYyZlJOQUxNNVRVQUUwNHZpSGYvNkM3WUdjRUY4RGgrLU8rLXlITDVNTERL?=
 =?utf-7?B?SzRXL3hjNDdFVE5kbTY4WnBocDBEVTJsNnZNYW15aWFYWWM2UmpxL3d1UE1s?=
 =?utf-7?B?Qk9vTldiQnN0OVpNSmkrLVhxM0VpRWpOYk9lU040dXczTnZZU0U0b0p1RjNB?=
 =?utf-7?B?QXhtUks3WHdrbnArLVNIa1FmRWhIUzhmKy1hT0c0Z0Nxb282L0xpdEswL2Ry?=
 =?utf-7?B?bjFlcXgzTVRVU2taZlhJRXlRbG9SSUwwSjF0NGRsZ1lWUmJWOWpCKy1HcW0=?=
 =?utf-7?B?Ky01cGxQNk9uYnVaTUo1QWhmMHNVKy1WYUpqOXRmY3EzRmNPaE9LUEhDckZt?=
 =?utf-7?B?RC96UkFPNnpmUmlVUnFRUC82UVhEcXd0U1o5QS95eEpwL2tQWWg1bzN3Y1gx?=
 =?utf-7?B?blcxOHprSTJUSi92blNlcElxejdqdVpJUHkwbThia0Y4eFV4bXczb293UHM2?=
 =?utf-7?B?ZTczNistSG1wWVdOb00wMEVjb3JDMkNFNDBYQTFBVzFyYTRubDhyaXI1YXZE?=
 =?utf-7?B?SVEzN2dCNVB3SEhyRllPTEQ0eXpGaW1CT1JsUDhCRXp0d1FJQk5KR0VyajB4?=
 =?utf-7?B?ai9EY0xMN216aXFBMEZ4QVJYNGxZbWNzMTNGRjVoSE44QXNKaWJMQkVPYWdk?=
 =?utf-7?B?TGtYOUFDUWovNlBJZ2RYNzVmZzJPeDBPRzdmU1NrR0dLblFRdHRZeW9ndExC?=
 =?utf-7?B?clFxbUVKNTN5eE1WMFhOQjUxTFVWZnZ1VlJ6c3pkSjJCazFoUEZhWFJSaWZ3?=
 =?utf-7?B?WXRuWnljWjh0dWthLzJrd3ZpNTlTekVGQXRFRmNjb0NkVjQxWUpuYldXQkh6?=
 =?utf-7?B?Zlpqd0Jsa0FOc2ZDT0tBVk5uUW90OWVSOHhRandGM25ISkpXc0kybTlkeUFo?=
 =?utf-7?B?eEIrLWNNNnBmSmtkbUlrWG9RMGYzWTdLMlkyR2dFYU4wSGlQUFROMEgyUXdC?=
 =?utf-7?B?SUE0SUlRdFl6dHVlU2RMdk9Jdmg0T1Rsb3ZVM095emsrLTZ1MSstM0N3WWs2?=
 =?utf-7?B?SW5xSistUHUwZ2dEYTM1VVZGY2RVeDJPb2k0NjBoamhIRmo0ME9KRHFscnNk?=
 =?utf-7?B?VHNxWFFkeVFOM1BwMUZkKy1GWm95RFFXS0dIL1lGbkRHeERWKy1JM1ZSRnFB?=
 =?utf-7?B?LzMrLWh5OGRuQVJWKy1heU9oTU1jZy95MExHR2g4SUFtbWZYeEdLT3d5am9s?=
 =?utf-7?B?L255a2loZDliSlhWY0VwOTlqVEI0R3NGSlJzeGtEbXNlQWk4eXhSekxna1NT?=
 =?utf-7?B?d3dyNDlxdklhOUx0aEQ4d1pQdXRBQXkzYkc=?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR19MB3922.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ffdb32e-5489-4172-572c-08dc71cbc3fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2024 15:05:15.9742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C2FBhma8YBaPiYKw1Y5wMrsn+Dq/U7906ji2W6xcomBv13QS/KqjBhNsC+znbGS+1VuZJDrfgjBmdFkZUkxTAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB7389
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-11_06,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405110113
X-Proofpoint-GUID: 06hVqXfjXr73vXejilmXgf47AjLUXFZc
X-Proofpoint-ORIG-GUID: 06hVqXfjXr73vXejilmXgf47AjLUXFZc
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405110113


Internal Use - Confidential
+AD4- -----Original Message-----
+AD4- From: Mario Limonciello +ADw-mario.limonciello+AEA-amd.com+AD4-
+AD4- Sent: Wednesday, May 8, 2024 11:53 PM
+AD4- To: Shen, Yijun +ADw-Yijun+AF8-Shen+AEA-Dell.com+AD4AOw- Lyndon Sanch=
e
+AD4- +ADw-lsanche+AEA-lyndeno.ca+AD4-
+AD4- Cc: pali+AEA-kernel.org+ADs- W+AF8-Armin+AEA-gmx.de+ADs-
+AD4- srinivas.pandruvada+AEA-linux.intel.com+ADs- ilpo.jarvinen+AEA-linux.=
intel.com+ADs-
+AD4- lkp+AEA-intel.com+ADs- Hans de Goede +ADw-hdegoede+AEA-redhat.com+AD4=
AOw- Matthew Garrett
+AD4- +ADw-mjg59+AEA-srcf.ucam.org+AD4AOw- Jonathan Corbet +ADw-corbet+AEA-=
lwn.net+AD4AOw- Heiner Kallweit
+AD4- +ADw-hkallweit1+AEA-gmail.com+AD4AOw- Vegard Nossum +ADw-vegard.nossu=
m+AEA-oracle.com+AD4AOw-
+AD4- platform-driver-x86+AEA-vger.kernel.org+ADs- linux-kernel+AEA-vger.ke=
rnel.org+ADs- Dell Client
+AD4- Kernel +ADw-Dell.Client.Kernel+AEA-dell.com+AD4-
+AD4- Subject: Re: RE: +AFs-PATCH v5+AF0- platform/x86: dell-laptop: Implem=
ent
+AD4- platform+AF8-profile
+AD4-
+AD4-
+AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4-
+AD4- On 5/8/2024 09:24, Shen, Yijun wrote:
+AD4- +AD4- Hi Lyndon,
+AD4- +AD4-
+AD4- +AD4-   Thanks for working on this patch.
+AD4- +AD4-
+AD4- +AD4APg-
+AD4- +AD4-   Dell side has an initial testing with this patch on some lapt=
ops, it looks
+AD4- good. While changing the platform profile:
+AD4- +AD4- 1. The corresponding USTT option in BIOS will be changed.
+AD4- +AD4- 2. thermald will not be impacted. The related PSVT and ITMT wil=
l be loaded.
+AD4- +AD4-   Some Dell DTs does not have the USTT, Dell'll have a check if=
 nothing is
+AD4- broken.
+AD4-
+AD4- Hi Alex+ACE-
+AD4-
+AD4- Have you had a check both on both your AMD laptops and workstations t=
oo,
+AD4- or just the Intel ones?  I think it would be good to make sure it's g=
etting the
+AD4- correct experience in both cases.
+AD4-
Hi Mario,

 I've a check for this, for both laptop and workstation, the dell+AF8-lapto=
p module will not be loaded. So, AMD platform will not be impacted by this =
patch series.
Follow is one example output with workstation.
 +ACM-lsmod +AHw- grep dell
   dell+AF8-wmi               28672  0
   dell+AF8-smbios            32768  1 dell+AF8-wmi
   dcdbas                 20480  1 dell+AF8-smbios
   dell+AF8-wmi+AF8-descriptor    20480  2 dell+AF8-wmi,dell+AF8-smbios
   sparse+AF8-keymap          12288  1 dell+AF8-wmi
   ledtrig+AF8-audio          12288  3 snd+AF8-ctl+AF8-led,snd+AF8-hda+AF8-=
codec+AF8-generic,dell+AF8-wmi
   video                  73728  2 dell+AF8-wmi,nvidia+AF8-modeset
   wmi                    40960  5 video,dell+AF8-wmi,wmi+AF8-bmof,dell+AF8=
-smbios,dell+AF8-wmi+AF8-descriptor

+AD4- +AD4-
+AD4- +AD4-    Additional, with this patch, follow behavior is found:
+AD4- +AD4-   1. For example, the platform profile is quiet.
+AD4- +AD4-   2. Reboot the system and change the USTT to performance.
+AD4- +AD4-   3. Boot to desktop, the platform profile is +ACI-quiet+ACI-, =
the USTT will be
+AD4- changed back to +ACI-quiet+ACI-.
+AD4- +AD4-   This looks like not a proper user experience. The platform pr=
ofile should
+AD4- honor the BIOS setting, aka, the platform profile should be switched =
to
+AD4- +ACI-performance+ACI-.
+AD4- +AD4-
+AD4-
+AD4- I agree, this sounds like the initial profile needs to be read from t=
he BIOS
+AD4- settings too.
+AD4-
+AD4- Furthermore I wanted to ask is there also a WMI setting that correspo=
nds to
+AD4- this that dell-wmi-sysman offers?
 Yes, Mario, you're right. This thermal setting could also be toggled by de=
ll-wmi-sysman.
But, for the Dell consumer AMD laptops, like Alienware, the BIOS is another=
 variant which is different with the workstation one.
With this variant BIOS, there is no USTT and also no dell+AF8-wmi/dell-wmi-=
sysman.

+AD4- I'm wondering if both should be probed in case the SMBIOS one goes aw=
ay one day.
 Yep, I think this is a good suggestion.

+AD4-
+AD4- It seems like maybe ThermalManagement corresponds.  There was some te=
st
+AD4- data in fwupd for it:
+AD4-
+AD4- https://urldefense.com/v3/+AF8AXw-https://github.com/fwupd/fwupd/tree=
/main/lib
+AD4- fwupdplugin/tests/bios-attrs/dell-xps13-9310/dell-wmi-
+AD4- sysman/attributes/ThermalManagement+AF8AXwA7ACEAIQ-LpKI+ACE-iyfGSyfnG=
xLymc-
+AD4- cEg93dfcnBIOtTJbfmCckZlj46eGqvJ+AF8-pHJ7WqFZ7-
+AD4- zrklKWKkZifqNgJ13LFm6wuz2UlzYqMPXciVw+ACQ- +AFs-github+AFs-.+AF0-com+=
AF0-

