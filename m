Return-Path: <linux-kernel+bounces-176621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDC38C323F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 17:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D30D1F21AC7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 15:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DEB56770;
	Sat, 11 May 2024 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="d4f1WS+q"
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563E738DD3;
	Sat, 11 May 2024 15:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.137.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715443042; cv=fail; b=jc9nwrZn1cMwnomydS4fF+Ag5YpJLdjjNfPyyq4q8D7bXCF8UnjENwp7wkucwT6fHK3LSBeyTHLEXzcu4Hp+6SsOUaEf8fBLi5N0robxumLVm7l8i75tvtP5NQN+T0OJwEkPvYvQH2pqaPAcUcRLFSsGmEEJ5GSZxouIXsAIvtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715443042; c=relaxed/simple;
	bh=dzXsj4sGeRcuaNrOTAXc4H37uF9ASTFL+RxKknf8OSQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cZGvfUNepHZTJe9yH1a4+5xpUOrZ7X0k1LUX/0htZZ0KGs0yDZN78ycL5pV+0wpM/TSNAsOmG6gZGAE0cfY1/ZHjGHVZ0j31rbj14GB2pXoBPtUqwMeh48+DjkCAbTCIglZbrNoLqEc4sC+X/vbM7/Jpmxq8yD2GBgizUGoklK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=d4f1WS+q; arc=fail smtp.client-ip=148.163.137.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44B7g2NH013220;
	Sat, 11 May 2024 11:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=csv30cv2IKKH+KKvoQZQP7f8/9b4mcOGtG+hsPXhrIs=;
 b=d4f1WS+qA7N3HB8c58I4mI9NzdOqAA5+TllfMs8ywxs14dGKSQ8j8yONfamQasLcxTie
 5OQAntcF6GslljGDIxkPyD1sS+MWP6en3vs3rOnNKdT/1ou+EuuwXO+E8h6xH6za+k4P
 hxd0AEXjbk0YoNIpm+ZLqt0IdeAcnmSX5X2Wic9Ke1if9NgCKQ3gIsO7UBM6tgrr2WC2
 6Q9a7CDKERIg6jHfrMTvChjHxSoTyV10IxBuM4HBtr6MEGY3PjHqLpH08dbqTyFca4Mc
 w5XDO23eIgfwyJFWtcD5794aO62AB3h8n+3LtPBdEo7oF6rlhnfIPZaydaQXbm2k1HFF kA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3y24gy8vhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 May 2024 11:57:01 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44BFq26f015627;
	Sat, 11 May 2024 11:57:00 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 3y2bp881gw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 11 May 2024 11:57:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLGSp0p9EkFHN7HpR0xbuNtg549JFxzU8MtulmFCYx8NBrZDlPqeHnLxTwv5MOwJmluR5zynqq33GGwuAHxk+KLRBDqJOD/GqIuEs1ehek+sTyqTEdc7yO+j7RoQ19D5XtTdx1FElgozOOGp1E/hdYgKppX564MHZuIvv6OJhYA8L8p1Jaz8S4RAJ6cpYRJUccuymjAQbiTya9GhfB4OZjdRyKzNlub5XQgzkeqgTT5NIGej15ab7ltDJSGpEX/sUeFcogDSz+7iP5TVmDCUY2hTQJQw9qmPbEZF/GwE5G2reUyNa20yGqrkxBWtiw1VOSpQFUdQX4/3Bn5Fz4LV0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csv30cv2IKKH+KKvoQZQP7f8/9b4mcOGtG+hsPXhrIs=;
 b=LNDm6//DsyqITJYufvbPvN77XaXA6xWZZQQCfcwbGDwXNs0C33kNhNviB+RJKg06hc8PCG0M3h+kxg2hqYNWwjx/7t3u+/oIzf+lO2FE1xLdPhK435QUtoxNMcpWwdq7Fvz+VQv8tFbHcQriiu3lNpNbHDgKAwwZVAqS+XpV1qgYBVfYp48e5sb2uIr5YEfr/HWtK3+NfRxzRmLdD8V33PkqTvmInyUvfktUn4FFmxNPTSxKEdRymAQE3wNojpy0kUy+vooJC2nAQuqAIvLY15n59CZFj6yJcFfO98Yjjp/I5+11jcE4jLicTK9SaGWVjY9eePdGh9rJLv/bNeCedQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from BY5PR19MB3922.namprd19.prod.outlook.com (2603:10b6:a03:228::23)
 by LV3PR19MB8627.namprd19.prod.outlook.com (2603:10b6:408:278::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.54; Sat, 11 May
 2024 15:56:56 +0000
Received: from BY5PR19MB3922.namprd19.prod.outlook.com
 ([fe80::afc3:5bb2:37fb:2f9d]) by BY5PR19MB3922.namprd19.prod.outlook.com
 ([fe80::afc3:5bb2:37fb:2f9d%2]) with mapi id 15.20.7544.052; Sat, 11 May 2024
 15:56:55 +0000
From: "Shen, Yijun" <Yijun.Shen@dell.com>
To: "Limonciello, Mario" <mario.limonciello@amd.com>,
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
Subject: RE: [PATCH v5] platform/x86: dell-laptop: Implement platform_profile
Thread-Topic: [PATCH v5] platform/x86: dell-laptop: Implement platform_profile
Thread-Index: AQHao7W5i0vPMIJzcUm3OnEtK3K4ELGSJuXQ
Date: Sat, 11 May 2024 15:56:55 +0000
Message-ID: 
 <BY5PR19MB3922A117E489A55C3C7FAC789AE02@BY5PR19MB3922.namprd19.prod.outlook.com>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
 <20240501215829.4991-2-lsanche@lyndeno.ca>
 <BY5PR19MB392256C65661E76FC292C0889AE52@BY5PR19MB3922.namprd19.prod.outlook.com>
 <63894ef1-c482-4646-8351-4d6cfc6c528f@amd.com>
 <BY5PR19MB392299916A85FF06387DC9C19AE02@BY5PR19MB3922.namprd19.prod.outlook.com>
 <a1306ffa-c0ea-4ce6-8692-76bf37850e8a@amd.com>
In-Reply-To: <a1306ffa-c0ea-4ce6-8692-76bf37850e8a@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=cd111a22-1569-4d41-9f94-362199c07769;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=0;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2024-05-11T15:23:21Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR19MB3922:EE_|LV3PR19MB8627:EE_
x-ms-office365-filtering-correlation-id: 2fe9002d-37f0-49c0-6945-08dc71d2fb97
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|366007|7416005|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-7?B?Z0g0SXk4SHU2YjRnUmFKTXg2Ky1kVHl1MlgwaWZQMFNKTzAzWE05VGx6cXFB?=
 =?utf-7?B?M3QyZXV5cnNCdVg3cUg3N2FyeDFJWVpxQi9Yb2RqNUZaNm10WFNadlZHZmwx?=
 =?utf-7?B?NXl2Y05qVFJlbW5SaHVuQnFDcUZTR3dXV2FFalJ0NkxPcWZOemRhSEErLTFJ?=
 =?utf-7?B?d21Eb2NVbXFZSm9CUjhZT1FhZmdIbCstVTg0VGhPMnJPKy1FYlFCaGlaWG1F?=
 =?utf-7?B?cWNVa2FERmJ6UGJYRW81VVdTL0hPT0JLbU1EamdzV1JsbnNvZHhOUDB5Tkti?=
 =?utf-7?B?cTZtN2hFY0dNZ2o5Ly9lT2h5aUJHSE50distZGppT25BemFCQUJOeS9OeVFt?=
 =?utf-7?B?RjNYKy1sa29DWFoyRHNNRXJrelNnQ3pmbmVNY1Y2Q0h0bzRjdEIwREdpRmFD?=
 =?utf-7?B?eFdqUm1zTDBOKy1qMCstWWl6VEFyNVp3cGkwKy1udUdCdVBnVEsvdGR4eC9E?=
 =?utf-7?B?eXhoSGtVM3FMVUJ4cHlpQm03NVFNTzlYc1hpdmJXcVJmSm05ZE03elBEQU80?=
 =?utf-7?B?L2tIcUZ0OGY2a0ZNNnFwdistNndGUnpxVDBpV0pkS3pHVXdjY2d4aHV3U3lX?=
 =?utf-7?B?d3paYk1VWGVDdjBxaUx6Nm1vd0lKcFJGNWlYS2lnVWJkai9mSFdZcnYrLUZz?=
 =?utf-7?B?ZTBUVnZ1MDNzMFRxbUp0QWpobldraW9oSFo2eVNPOGlWNG5ISUlmcDF4M1ZV?=
 =?utf-7?B?M0tRY0hvai93c0laRGhYZWxzWVFUZTB4UVlMeGp3QnpabTFncGkzTDNIOGlj?=
 =?utf-7?B?QllhNWRqS3g4b3RNVXhxZSstNGMyQzZ4V1R1c2hGSTAybmh5TEk5NE5YQkxz?=
 =?utf-7?B?eGkvblJjT0kzQ3hsaGIrLTlHSzRqMXRBZFJsVldWOHVkWkZJKy1iWDRzb3Y=?=
 =?utf-7?B?Ky16Vng1c2pXMmJZU0QwU1hza1VlZ251aW5jMjFYdm9zYVNkMXpuUUsvR0U0?=
 =?utf-7?B?UEYxR2gwbFd2L2FOYTBDblZzczBLaWF3enRoWXdIR3ByNzdEdGpIczl0YWJq?=
 =?utf-7?B?UzRFamJMaEZudzVTbjByVGZmR0hKNnhBRUVLYnMvNXUrLUZHaDMwQWFqc1Bn?=
 =?utf-7?B?TWtoRDRobXRYRUk0SFNCdnVMRlovZnpHeFZhcmRRYldBVUtDYk1VVWwyQTRP?=
 =?utf-7?B?NDVSNWhZWXJ2ZFp6aVU0Nkxvd0JzREZKWTc5c3g2L2FvZFI4bG1obVdHV0tT?=
 =?utf-7?B?VWdGSk1QSEJoTlVmQUZoYk5INnVKbFFGakFTaThhYy93Zkpqbkd1cUw5ZmNK?=
 =?utf-7?B?Q1JYSFZvaHNvUHM0a3FieWFndHA5MXRmQ2pSeDdzR2NQcSsteHpCNkhxMzJ4?=
 =?utf-7?B?a2RWSzlBbFV2NFdiRnl6Tk9FWFkzdkhvV3BaYmlVQUJ3TmR2bXloSUl4aDBs?=
 =?utf-7?B?YjJrM0JMZnh0d2FPM3lvM2pZRXd3SndRMzdFaTB5THZQNHJibk9pRzFzKy1N?=
 =?utf-7?B?UTZCdzcxZFdxbjczMEdzZGhuaGk4T0MzeWdiRklZdmYzVHlYcTFqSUVYRU9E?=
 =?utf-7?B?QnhITkZhQnRNWXp6WmtBeHhsMFZHdGs5Z3lHZm9QYmg2Y1NYZk5hZkl1ZGlo?=
 =?utf-7?B?M2JvNXplR1EyeEZJVystN0dsbVlwb3J1TW12cjlJMCstd2RiUFozTVFJL1h4?=
 =?utf-7?B?aDBzMXgwckhVM1FRMU00eURJbXM4N1FNOExWZ0RCNEx2WistTzVKQUU1dXpT?=
 =?utf-7?B?NVU2OUVHeUlQKy1IQVdWZTBWNjhYcVdMb0dZclhRcXE2OTRLejZQZXRpV1Zn?=
 =?utf-7?B?Q0RSUGw0a0tyQnBNQVArLTNXQVZ3K0FEMEFQUS0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR19MB3922.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-7?B?WTYyRzF6dTNranRlaHVtRmFqd2pwYSstQ1pHMW1uL0ZvdzZuc1N4cCstUW54?=
 =?utf-7?B?TE9RNWFNajBVU0RzMWEzVnllcGlGSjRRSW5pazRhbUlDcm94bk1NM2NVclpq?=
 =?utf-7?B?UEpQZmNrb3lXSC8rLVJ6aG9leThJcE91TWpaanFCbFhndzFFeSstaU55eXF6?=
 =?utf-7?B?NkJodndEYlg3TkVtaUxyaXV1NGRsSFl5SjNWY0dmRDhxVURDOTYrLSstR2Jo?=
 =?utf-7?B?VUp0cDBHMDVuUXIzejJQcHUrLVdnc0U4dVhwWTFGb29SMmw3Ky0vODFCaEll?=
 =?utf-7?B?cWZDYUpRSExhVlhBc3VGdWRuaTJJUjBHZXovOGdmWTY5cVFqVVdEbGV0LzVL?=
 =?utf-7?B?VGxyaGc2bVhJMkhjY1RFdEI0dHhEUHRrdTJlZjJUWTFPSS9MKy0waWlDcUxJ?=
 =?utf-7?B?Zm9IMHZnZWpJbnVpaHBIc3B4a3JtT1NzREx0b1IydWxUWlR0MDlHSURBbUtY?=
 =?utf-7?B?ck04Ky1qZjRPdmoxaUFPUmVkSnFTSTlJRG9kY3daeWEyWDliVVBLV2Vlby9P?=
 =?utf-7?B?SkRtM2Y3aGdReUQ1Tk94cVZhcFBEUEMvOUw1YktzRng4b3MzSC9EZml1a3VV?=
 =?utf-7?B?bzJ2SHVOa2F2MkdrTFBVR2hJUVpCV08wdmxEMjRrUzl6dEM2UzhDZWFNTGRs?=
 =?utf-7?B?R3lmM1FBRnNoQk80OWI3ZEltRkM4Wjc3M2NIT2dxbWJnVi9Ub1pRQ2RVZ3VX?=
 =?utf-7?B?RWRCYystNFZOOGZndzZJRFpzZ0k1N3lUdlRweW54ZW1RR3BQanc3VHByUTBE?=
 =?utf-7?B?MlNjWXJDdC8zOWxpMVYydEZqVWR4VXRDSWVGV094M3ZUL2F4MmU4d3BvZ2dP?=
 =?utf-7?B?WmJ3eDhPZkhra002R0ZsZGJGYml1YjR4Y3FDdlhhMXpNSkxVcmR5S0lVanpx?=
 =?utf-7?B?cUEwdi8rLXN6ZlFaWHhDY1NnblVuL0crLW5OQlJXVkoya1dVYlREQXNoOFBk?=
 =?utf-7?B?NnRJY3l0aTJRWXprakpxeHd5cTBzeUdVbWZTdUNSUUpPKy1uQzVyWWVLejNR?=
 =?utf-7?B?VmIxR0tyZkM2MXBYZmxGZk5wOHROc010WEFiVEdNM2xJa2lZVnNVd25pSFBx?=
 =?utf-7?B?S3hDQUZXQ3NuYkc0dE5mZ0F6elNMeDhTQ1gvbWNOMHlPZHIxMXRLRmJweHU3?=
 =?utf-7?B?eSstMm02dENtcGhEbzdvZjJhOXdCSGhmMUdkQVdsc2ZVL20vNnYrLVRCaFdi?=
 =?utf-7?B?WmswS3JtTHE1OC9DTjNLbkZaa05lU1A3U3Jna1lESTFjanRCOGJLNmsySzZS?=
 =?utf-7?B?UVJxWlFyMlJoUGZ2V2txN0V6SnFYWjVMYklxYWI0VnM4QndVOHVaUTBqcVVD?=
 =?utf-7?B?eHdrQ1ZKQTNURHNnSktjV2F1ZWxCWVBONzZMYzJhZ09EQk8rLTVXenZJVHBs?=
 =?utf-7?B?cistUnZCY2t1UnlMeWkwR1VES3lUSDRSaXF2NUw4UFdLUkJGRVIvSkNjRkY5?=
 =?utf-7?B?OUkwOHFCNnJiS2ptNzlHUkN5bTJsdDVUSm9ML1BOU2NObEQwaGV6S21BQjBi?=
 =?utf-7?B?OXB0aUNiMnF1bFlVMXRlc2VvSmJjb2JmNTYvT29kWVkxTVR6N0FFclBsUVU3?=
 =?utf-7?B?Y0hUcm1nejdJOWhVc0ErLWl6Y2ZPcU92Q3pyeGJsV3psa0tKYWI5TzlVSzQ4?=
 =?utf-7?B?WnJkUkFiaEgyRFJHc0hDbTVhdkF4M09FWjJIeFRYYTJPdXhUaGZ4YS9ScGd5?=
 =?utf-7?B?TVJIYmd1NjdQT2xzVFZJSDlia2JNd3BpYkNDUUZaOURIT3BtRU54UWc3SHZz?=
 =?utf-7?B?Sk82eDNGaTJnUXhSalVtMjZmNW5ZN3FFN2QrLVpUeVdQUExxKy1ZZDROMWVr?=
 =?utf-7?B?YWd6a2JDdk1jT0gvaUQyVDJTNjZPaXFpcGM5WGZ1Zk9GeVo3eUhvczlpY2VC?=
 =?utf-7?B?eXg5eUN5cnF0S3diNnpkQUpRRWFBTFV4QlhiNTRjYXlKWHJGZllWNE9sUXQw?=
 =?utf-7?B?VlJFQ3AxcWJDRldhOGVrNERhUFJYcC9tTGRDQ2RUVEpMM2pRSWVlQmZhZUp4?=
 =?utf-7?B?VWY2d3p6M1dRRmtwTlIySUl4MEZOZEtXdGZtTVZndEpiQ2wrLWdlcDAxeWdv?=
 =?utf-7?B?YVYzWGtrdEpSUVpXZ3hQSENlUUxNelVRR1ZEem9OSHVSejdHeFd6ejVyKy1k?=
 =?utf-7?B?YzhRTzRSRGdpUTd3Wm1xUmx6RE1kdHhUOW5VenRPRistMERUN3lHY1VOTWoy?=
 =?utf-7?B?aHdZWVpRWUoxbmNTT1ZQYmE0dm10RVM5UjFrekZGTWFXTmlGdmZSNWRnak9H?=
 =?utf-7?B?L3ZTL1k4R2hKLzk5Q2Y1d256dkx3NG4=?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe9002d-37f0-49c0-6945-08dc71d2fb97
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2024 15:56:55.6906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cfD+v7YBkrEAzYXYQQt6ssoBmObrd5xtJw3+xJin/hGKHpVDbDserAVwWWHGkavKEF798rHNBDZrv7T5q2AfQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR19MB8627
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-11_06,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405110119
X-Proofpoint-GUID: egc3a20P4ahxHSddLMu6vbrutAFtzR11
X-Proofpoint-ORIG-GUID: egc3a20P4ahxHSddLMu6vbrutAFtzR11
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 suspectscore=0
 mlxscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405110119


Internal Use - Confidential
+AD4- -----Original Message-----
+AD4- From: Limonciello, Mario +ADw-mario.limonciello+AEA-amd.com+AD4-
+AD4- Sent: Saturday, May 11, 2024 11:13 PM
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
+AD4- Subject: Re: +AFs-PATCH v5+AF0- platform/x86: dell-laptop: Implement =
platform+AF8-profile
+AD4-
+AD4-
+AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4-
+AD4-
+AD4-
+AD4- On 5/11/2024 10:05 AM, Shen, Yijun wrote:
+AD4- +AD4-
+AD4- +AD4- Internal Use - Confidential
+AD4- +AD4APg- -----Original Message-----
+AD4- +AD4APg- From: Mario Limonciello +ADw-mario.limonciello+AEA-amd.com+A=
D4-
+AD4- +AD4APg- Sent: Wednesday, May 8, 2024 11:53 PM
+AD4- +AD4APg- To: Shen, Yijun +ADw-Yijun+AF8-Shen+AEA-Dell.com+AD4AOw- Lyn=
don Sanche
+AD4- +AD4APg- +ADw-lsanche+AEA-lyndeno.ca+AD4-
+AD4- +AD4APg- Cc: pali+AEA-kernel.org+ADs- W+AF8-Armin+AEA-gmx.de+ADs-
+AD4- +AD4APg- srinivas.pandruvada+AEA-linux.intel.com+ADs- ilpo.jarvinen+A=
EA-linux.intel.com+ADs-
+AD4- +AD4APg- lkp+AEA-intel.com+ADs- Hans de Goede +ADw-hdegoede+AEA-redha=
t.com+AD4AOw- Matthew
+AD4- Garrett
+AD4- +AD4APg- +ADw-mjg59+AEA-srcf.ucam.org+AD4AOw- Jonathan Corbet +ADw-co=
rbet+AEA-lwn.net+AD4AOw- Heiner
+AD4- +AD4APg- Kallweit +ADw-hkallweit1+AEA-gmail.com+AD4AOw- Vegard Nossum
+AD4- +AD4APg- +ADw-vegard.nossum+AEA-oracle.com+AD4AOw- platform-driver-x8=
6+AEA-vger.kernel.org+ADs-
+AD4- +AD4APg- linux-kernel+AEA-vger.kernel.org+ADs- Dell Client Kernel
+AD4- +AD4APg- +ADw-Dell.Client.Kernel+AEA-dell.com+AD4-
+AD4- +AD4APg- Subject: Re: RE: +AFs-PATCH v5+AF0- platform/x86: dell-lapto=
p: Implement
+AD4- +AD4APg- platform+AF8-profile
+AD4- +AD4APg-
+AD4- +AD4APg-
+AD4- +AD4APg- +AFs-EXTERNAL EMAIL+AF0-
+AD4- +AD4APg-
+AD4- +AD4APg- On 5/8/2024 09:24, Shen, Yijun wrote:
+AD4- +AD4APgA+- Hi Lyndon,
+AD4- +AD4APgA+-
+AD4- +AD4APgA+-    Thanks for working on this patch.
+AD4- +AD4APgA+-
+AD4- +AD4APgA+AD4-
+AD4- +AD4APgA+-    Dell side has an initial testing with this patch on som=
e laptops,
+AD4- +AD4APgA+- it looks
+AD4- +AD4APg- good. While changing the platform profile:
+AD4- +AD4APgA+- 1. The corresponding USTT option in BIOS will be changed.
+AD4- +AD4APgA+- 2. thermald will not be impacted. The related PSVT and ITM=
T will be
+AD4- loaded.
+AD4- +AD4APgA+-    Some Dell DTs does not have the USTT, Dell'll have a ch=
eck if
+AD4- +AD4APgA+- nothing is
+AD4- +AD4APg- broken.
+AD4- +AD4APg-
+AD4- +AD4APg- Hi Alex+ACE-
+AD4- +AD4APg-
+AD4- +AD4APg- Have you had a check both on both your AMD laptops and works=
tations
+AD4- +AD4APg- too, or just the Intel ones?  I think it would be good to ma=
ke sure
+AD4- +AD4APg- it's getting the correct experience in both cases.
+AD4- +AD4APg-
+AD4- +AD4- Hi Mario,
+AD4- +AD4-
+AD4- +AD4-   I've a check for this, for both laptop and workstation, the d=
ell+AF8-laptop
+AD4- module will not be loaded. So, AMD platform will not be impacted by t=
his
+AD4- patch series.
+AD4- +AD4- Follow is one example output with workstation.
+AD4- +AD4-   +ACM-lsmod +AHw- grep dell
+AD4- +AD4-     dell+AF8-wmi               28672  0
+AD4- +AD4-     dell+AF8-smbios            32768  1 dell+AF8-wmi
+AD4- +AD4-     dcdbas                 20480  1 dell+AF8-smbios
+AD4- +AD4-     dell+AF8-wmi+AF8-descriptor    20480  2 dell+AF8-wmi,dell+A=
F8-smbios
+AD4- +AD4-     sparse+AF8-keymap          12288  1 dell+AF8-wmi
+AD4- +AD4-     ledtrig+AF8-audio          12288  3 snd+AF8-ctl+AF8-led,snd=
+AF8-hda+AF8-codec+AF8-generic,dell+AF8-wmi
+AD4- +AD4-     video                  73728  2 dell+AF8-wmi,nvidia+AF8-mod=
eset
+AD4- +AD4-     wmi                    40960  5
+AD4- video,dell+AF8-wmi,wmi+AF8-bmof,dell+AF8-smbios,dell+AF8-wmi+AF8-desc=
riptor
+AD4- +AD4-
+AD4-
+AD4- Ah+ADs- right that makes sense.  In that case, is dell-laptop even th=
e right place for
+AD4- this patch series?  I would think the same policies for the platform =
profile
+AD4- should be able to apply to desktop/workstation.
+AD4-
+AD4- The v6 of this series would block smbios-thermal-ctl from working on =
a
+AD4- workstation too.
+AD4-
+AD4- +AD4APgA+-
+AD4- +AD4APgA+-     Additional, with this patch, follow behavior is found:
+AD4- +AD4APgA+-    1. For example, the platform profile is quiet.
+AD4- +AD4APgA+-    2. Reboot the system and change the USTT to performance=
.
+AD4- +AD4APgA+-    3. Boot to desktop, the platform profile is +ACI-quiet+=
ACI-, the USTT
+AD4- +AD4APgA+- will be
+AD4- +AD4APg- changed back to +ACI-quiet+ACI-.
+AD4- +AD4APgA+-    This looks like not a proper user experience. The platf=
orm
+AD4- +AD4APgA+- profile should
+AD4- +AD4APg- honor the BIOS setting, aka, the platform profile should be =
switched
+AD4- +AD4APg- to +ACI-performance+ACI-.
+AD4- +AD4APgA+-
+AD4- +AD4APg-
+AD4- +AD4APg- I agree, this sounds like the initial profile needs to be re=
ad from
+AD4- +AD4APg- the BIOS settings too.
+AD4- +AD4APg-
+AD4- +AD4APg- Furthermore I wanted to ask is there also a WMI setting that
+AD4- +AD4APg- corresponds to this that dell-wmi-sysman offers?
+AD4- +AD4-   Yes, Mario, you're right. This thermal setting could also be =
toggled by dell-
+AD4- wmi-sysman.
+AD4- +AD4- But, for the Dell consumer AMD laptops, like Alienware, the BIO=
S is another
+AD4- variant which is different with the workstation one.
+AD4- +AD4- With this variant BIOS, there is no USTT and also no dell+AF8-w=
mi/dell-wmi-
+AD4- sysman.
+AD4- +AD4-
+AD4- +AD4APg- I'm wondering if both should be probed in case the SMBIOS on=
e goes
+AD4- away one day.
+AD4- +AD4-   Yep, I think this is a good suggestion.
+AD4- +AD4-
+AD4-
+AD4- Great+ACE- Although something I wonder is if the policy when changed =
with dell-
+AD4- wmi-sysman is immediate or requires a reboot.  A lot of the settings =
in there
+AD4- aren't effective until after a reboot.
+AD4-
+AD4- If this is one of them then it might not be a good idea to make it wo=
rk for
+AD4- both.

Hi Mario,

 Just have a check, the check steps are:
1. stop the thermald
2. run the stress test
3. Toggle the thermal setting between UltraPerformance and Quiet via dell-w=
mi-sysman
4. Check the CPU FAN speed
 The system reboot is not needed, the CPU fan speed changes immediately.
 A screen recorder here: https://dell.box.com/s/p2bhd2b6cv8z5buk9eao3bosgrr=
p1lf9

Thanks


