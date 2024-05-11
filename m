Return-Path: <linux-kernel+bounces-176638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB19B8C3268
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 18:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FD15282405
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 16:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8266F56B7F;
	Sat, 11 May 2024 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="uLrvUBJ4"
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com [148.163.133.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6B1A937;
	Sat, 11 May 2024 16:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.133.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715444009; cv=fail; b=q3dW/45q/9153YXMdsfVDrXbyWlpdLIOscaXx0iMGn2Ev+e4iOIjZsGZP2Pif8TvlIHomctRVQqCVWjkQqIU8HeaWOhv1EO02ql6JgQSFZY8wYknaGGX8p+v5rIzm4RRSluVtfKG9/uHKl7ZS11yzbFjP9v49+a5rYYmg+g3f7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715444009; c=relaxed/simple;
	bh=XsrOazo3dDe2sNhkF/pYm17TBFM+ZwMLuExHAF2iybc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ByVgCXNq37HPh2z8BOTrqWPd+pcMj3SyDyvQgi9Lb3XqU9mBosE55OlEaPqULhNkh2aqKL6MmKroa7mCdVF3q5sj+Ia3XhC9WqkV5ABoYRQo7v+zOQqfdHAYod8uME5T2S0DFFkA/a0uJOvFWp8NLWYI6Z4vzGn2sE+vHcWz0Ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=uLrvUBJ4; arc=fail smtp.client-ip=148.163.133.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44B6t94a018996;
	Sat, 11 May 2024 12:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=QwVWmWbBeuZV9b6+9HYHZs3DLweGAXYnOi+ZOuO9ytY=;
 b=uLrvUBJ4Ji0z+e4cpY7lVbQfEAJrnV7KknWmjZ//8MGGQnSwBWTjIzA9FZqQbf9FRj+e
 bqhXUEPk5JHpGw2MtUX34PbAfi579Lp5u5iC6VXP2//B1+z66Uamh+Ac+eAEn33ZAy+a
 +tslhNZMIFP9E0TB8Dq5u7nnBealfvA1nlKUqtX31hfsLBlVqp+lprq84Wvq6UOtC7Yp
 bbyryY/5dhsHbBW5kqbBBZ227zUypvv/5M1uEeZ0f3wn1W9eRm/uss6wJVX1OeinZJ69
 E9c7AwIKLzQbx+Eya+8ZV0L4VWhvMNj2Zaki8pDT9EXrKHkta0eCKsrF+3Vx7fl3IYHb eg== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3y23txh0nn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 May 2024 12:13:04 -0400
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44BG1Mwn026837;
	Sat, 11 May 2024 12:13:04 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 3y2btw83t9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 11 May 2024 12:13:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3SyJs3U5TaJLAp/b1NfxRk5dHcmXBa3H4Jnn8h9iRWBiTmkVkzlJb+n+rpX5/Vc0NfrgdrI7zWcqvzHgI6foz8xmTUuwD6FRMtvfq2Z6G6beTLQ2IbpnkThAZieE8aIxaZN61MDK9vyINBfzERDfw2HTJMRQ7+5mXTAH0dKKrDpM71m2z7o4ti9HHPb3YhQYO4glBHL2N5fSXkHUpDImnp7giCvozNNvYOttadLIxNTlfHQDS5oblDQd9C4HSWJ+aK75DmVTCYFTXgCV9p708zgLXVpXQgp9mshX1Wb2IDr/7LscNaZPw61sKHBdAkHUSwAUB7/9zRJYRFybhdILQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwVWmWbBeuZV9b6+9HYHZs3DLweGAXYnOi+ZOuO9ytY=;
 b=S6k9uaRO/O1Ev1OMTmqA6tXmpFFDyS7vj/15dywGWVEdR4Iig8CHuy8TXKt25guYHv9BNqYj0VhcRHcnaPkIYID89cxqPXG0gGOcHyenPNPpiT/gJQ4i0ZcWq6uJt4EtnwenlV4y3r70zqPIE86ZDH+nGpKhmjUqE0R6EpK46hMEas1PwWkuRvndrdcOf43ZGh9oU9Kyrg8bj04ThtQ9z/GIqSd/pWgpPAxrS+f7WpuZtFGAoFrXLUOhJOpM9KKO9KV9aEQk6i6fbcPMcb8u+PLk/ReWjumUYGlWi18x1Ni+buiroFgoTuXFHLYPuNpamPATrPB6WM/4OPWPtas7Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from BY5PR19MB3922.namprd19.prod.outlook.com (2603:10b6:a03:228::23)
 by SA1PR19MB4880.namprd19.prod.outlook.com (2603:10b6:806:1aa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sat, 11 May
 2024 16:13:00 +0000
Received: from BY5PR19MB3922.namprd19.prod.outlook.com
 ([fe80::afc3:5bb2:37fb:2f9d]) by BY5PR19MB3922.namprd19.prod.outlook.com
 ([fe80::afc3:5bb2:37fb:2f9d%2]) with mapi id 15.20.7544.052; Sat, 11 May 2024
 16:13:00 +0000
From: "Shen, Yijun" <Yijun.Shen@dell.com>
To: Lyndon Sanche <lsanche@lyndeno.ca>
CC: Mario Limonciello <mario.limonciello@amd.com>,
        =?utf-7?B?UGFsaSBSb2grQU9FLXI=?= <pali@kernel.org>,
        Armin Wolf
	<W_Armin@gmx.de>,
        "srinivas.pandruvada@linux.intel.com"
	<srinivas.pandruvada@linux.intel.com>,
        =?utf-7?B?SWxwbyBKK0FPUS1ydmluZW4=?=
	<ilpo.jarvinen@linux.intel.com>,
        kernel test robot <lkp@intel.com>,
        Hans de
 Goede <hdegoede@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Jonathan
 Corbet <corbet@lwn.net>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vegard
 Nossum <vegard.nossum@oracle.com>,
        "platform-driver-x86@vger.kernel.org"
	<platform-driver-x86@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dell Client Kernel <Dell.Client.Kernel@dell.com>
Subject: RE: [PATCH v5] platform/x86: dell-laptop: Implement platform_profile
Thread-Topic: [PATCH v5] platform/x86: dell-laptop: Implement platform_profile
Thread-Index: 
 AQHanBLh5VIydjU6UEi/YU1qu3GPk7GNIdqggAHsKICAAkSsgIAA3t+AgAANP4CAAAHoAA==
Date: Sat, 11 May 2024 16:12:59 +0000
Message-ID: 
 <BY5PR19MB3922FD459460DF6D2B9CA2D19AE02@BY5PR19MB3922.namprd19.prod.outlook.com>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
 <20240501215829.4991-2-lsanche@lyndeno.ca>
 <BY5PR19MB392256C65661E76FC292C0889AE52@BY5PR19MB3922.namprd19.prod.outlook.com>
 <aaa1ebb5-3e0a-40ef-b53d-d8adc1589085@app.fastmail.com>
 <X1TADS.8PTII3LXSHHX1@lyndeno.ca>
 <BY5PR19MB39223A0977CE393BA6833DB29AE02@BY5PR19MB3922.namprd19.prod.outlook.com>
 <5D1A41F2-8740-45E5-9A86-396A9B615BDB@lyndeno.ca>
In-Reply-To: <5D1A41F2-8740-45E5-9A86-396A9B615BDB@lyndeno.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=2f4efe2c-f454-4e95-88e5-ab10431c52ea;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=0;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2024-05-11T16:01:04Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR19MB3922:EE_|SA1PR19MB4880:EE_
x-ms-office365-filtering-correlation-id: 092c4946-ffe3-4a26-4a80-08dc71d53a50
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-7?B?MWl5bmRKZ1lWRnBZUGdpczdaUFlaSkgrLUJKREZ3Ky1EdTNrZEZ4T2lPZWQ=?=
 =?utf-7?B?VystTEpNRnJjMGpTbEQ2NGVvTFEwRWYwU0gvdThQcENQRlFxNGtqQlBSMW9l?=
 =?utf-7?B?SWg1Ky1mM2JQYjE4WEJwdzlJRHd2SEovWU1manJCYUVYT1ppbUpqUXluL2Vm?=
 =?utf-7?B?aVZsMVpuei9NWEhzeXJNZHJ1R0RyVystb2dOLzhBZFdzRGVRVkkzZXBZVnVy?=
 =?utf-7?B?b2IvUU53Vk1DSTBGbGhoZm9YV1JyNjBTVENuU3NYbjl4eCstcEtiWXBFb3h1?=
 =?utf-7?B?MlluQ29KRDY5UXk2RnRUVFFwWVFPN3RxZDUrLWtzRlVsM0crLXZLYVppVjUw?=
 =?utf-7?B?ZEI1NjJYRGVwOFc1NGpYWVcrLTdjRzB5NHZJc1Q5MnhHa3JvRERrVDJyNmRw?=
 =?utf-7?B?MzY4SmFkMHkybystOXBkeTRwZkdiei9UYWpRc2NRYnA4TFBNa1d6dFhqN3dX?=
 =?utf-7?B?WUVrbnVSU0JVUzZrbVFqWU0rLXJMczBQcnFSNGJXQWpaRzEwVy9ZKy1Zc3ZE?=
 =?utf-7?B?ek53Ky1SdnNBVHh2YUZPNGZldnk4VjY4dmpWWUdqMHBRUGRiOFZWcW5ybHBz?=
 =?utf-7?B?cERQKy1wMzl4U3J2TEhhcE80S1VxVmNkT2tIWHlZUS9pc1oyeGtTdVhiNkVj?=
 =?utf-7?B?T0JSU3h5YXN5RTRsT0IzQmpvQjNMZVZHRzhjY1NkSFZMMy9LRklWekYyZktN?=
 =?utf-7?B?eVBacTRGSE1ScnM5eUljRjhkYmROMnM3VmpnOFVsSlM5Qk4zU3R0V01oU0tS?=
 =?utf-7?B?WWlBVjJlaDdrYW9qWnA1bWYvTVQ5TjkyakUrLVR4Q0xkOGdyKy1XWkprZnk=?=
 =?utf-7?B?NGErLUxublNNTFY4SHVUSk5lSzlVSHZVQ0ZKSEFyV3JpOFl3ZkhlODVyaEFs?=
 =?utf-7?B?TDRLdmRpSzdLNHdIVTJNUzBvYkRYa3VmWUI2VlhRV0dUbTBhSGR3dmpDN2xQ?=
 =?utf-7?B?T1NLMzArLUF1RVBxdmpoM2NUeFJPM2Y1Z0ptKy1qQ2FKN1ZLWndSVnl6Vnho?=
 =?utf-7?B?c0JqdFo2QlY2UFBMNmpUQXJNWXZUVnJ4RS9OL0ZiU3I3dVBHQjh0bUVvVmZ4?=
 =?utf-7?B?WWpvamU0NzVIZ1ErLTBnSmk0U1NwUmZhcXBJTmYwTHpoVnFYRGFwWEdWVHp5?=
 =?utf-7?B?V1FVRjlYQkgrLVMrLTd5OVRySHFVeTlyYzNzZnhldlRlMjlveWlLRDBUaHZj?=
 =?utf-7?B?U3BGS1VZRDlWSjJCS2NCQXhFbXYrLVZ6aGhGR2FGSHJERGdndFFzMzVZM3Jh?=
 =?utf-7?B?QVljME9RT2FTaTFkVlR3dkZJTVpVOW5zaVoyY3Fib1lCSDVNMnd5dW1ibFp1?=
 =?utf-7?B?anpTMW1jaXZRbXZzL2puMlNKSTBmNXJPMXVmbGZuaUd3Ky1lS0poTklBS09L?=
 =?utf-7?B?UFBOanRWUGZ2ZWJZVkYvbHpQZjE1amVBSWVCS3pmWXpiNm9NQTdNcUxQd3Fu?=
 =?utf-7?B?M1V4VWlMcHZXemthMmdRR3VFQWRRbTVUMGszMVNFQVNNUGVkZk0yZW1Dajdn?=
 =?utf-7?B?MXVPWlJiZERWbGNTNmY4MVUwbnlEblhPV0dWMmxwUWltOFNRQ0FKei9udWRH?=
 =?utf-7?B?QXN4ejJKUVhGQWxUZWdJVFZCTEpBS1N6TkYxbUV6SzdHN29ZeGI0TmlGVmJ3?=
 =?utf-7?B?TUIyanNIeGpJMzhhdnY3a3NzL2RQUWg1QlZhUERLUlptOEw1eVVGaXBXSUtJ?=
 =?utf-7?B?VzBmcW4xaHNveG1FKy1wWW9nVnVxL3dzdlhXNm5RMlp0OUpzNGJNY0krLTZO?=
 =?utf-7?B?b05paSstMDZWZzdLOWpTT1R4TENwQXlwY0ZpSU5yaU1yWWpGUEFtM0NHSTRZ?=
 =?utf-7?B?Q3crQUQwLQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR19MB3922.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-7?B?Smh6dHZNM2Q2RTZmSjRKQXh3RENXV0k5Vk16STFKKy16YVg3ZU5kdFFEMmFF?=
 =?utf-7?B?Y1Ayc0F5MmppNmlkSklRNEdlR0RhQmtJbFVOekFLR2U1UWZVRCstalV5QW9J?=
 =?utf-7?B?WG5vOU1KSjJjMTBzVGpncGdrdGs5akxvYkVZVlhWb2VrL21Rc3IvVG9GdHlp?=
 =?utf-7?B?S2JtNGg1ZEFYanYrLVByNVZKOSstd21UWWFXaXZ3dVZpWDhGaG94RzVlKy1v?=
 =?utf-7?B?Rlc0UUh6V3VyaElPNE9OTWhhRXdqZUFIZktyVHJXKy1QZjNpTzNFNXNDV2o5?=
 =?utf-7?B?NHh6ZGVBaEtONjdua2NJMjVWbVp6OFdaY2xXNystZXlCWTNNMHVENU85SExF?=
 =?utf-7?B?WEtnS2tOZ3dXKy1wSDhuQ2hqRC9oUVh0emJIZmFDbnNTUEdiKy1KS2h6TS95?=
 =?utf-7?B?a2grLUdyMWxLV0RrNzZSNFVOUFlKYjM5ZVJCdXNkU1ZpZ01YQWlFckd1Z2ND?=
 =?utf-7?B?N2VlVkpWMk5wKy1Na3RNT0tOdkQ5dCstS2NuYUV0bUxqVVdvNmp6MHl0aDJT?=
 =?utf-7?B?MGhsakpWN2dhOVJjaFBVN3AvZ0xkRDI0ZlZmc3NhOWRSYzhray9JaWtJV3c4?=
 =?utf-7?B?ZjU5dFFod2ExbEczNkp4RDNHdFVUQzhjZWFjenAxbVlaMlVrenlqcVpxSHZH?=
 =?utf-7?B?OHdCc3dSRDJuZ083OFppT2kvMWlVbHR2SkZBWjZwMUJJNmZRTnVLTnEzV3ZB?=
 =?utf-7?B?bWFEN0txdW9qaUpWamdYOWtUalM3SkVVeSstdW9OOTZ5UnZwVWk3TVpOSmtm?=
 =?utf-7?B?Vi83eWI3YWVqSjdDOG5hL2lldFdma0Y4STl5NzZzZkhMYzVzYVU1QlltSU1x?=
 =?utf-7?B?ZFk0c1hITGwzbU83aFZ5VFRVRW9KRlI0YmlQSzduaUFiaW1yVndwck1IZmJa?=
 =?utf-7?B?b21wRHZVWi9ENzJrTEZob0dHSUZ5eGd6eS94RG5GRkJhREYydDZ3UjhycXdU?=
 =?utf-7?B?YWdtVWJSNFM2S1hVdkh5cGNaMWF0NzFya2x2OVBpVXFWYVg4dks2emdFTUJN?=
 =?utf-7?B?NGVQNDdTek9HYjFSKy14aGZxT1RBdmtRVTcyeFdIZzlkZmhvdDA1WTJudk9t?=
 =?utf-7?B?d1gybFZCNHVrRTRZemJySjJaNXY2N0R4aE1xNHJEYm4rLVIrLVBmOE55T2xZ?=
 =?utf-7?B?MHk5UFRkSkpBdmRVU2xoTk9kaWlkM2hCaXBBYndEdXkzcWc0cDhBWVk2ck12?=
 =?utf-7?B?Ym9xYktFZkp4OWgyelh1ZnJSdll4aGZoQlNwbGJYNzlMNzNSNkpoM0d3cG8=?=
 =?utf-7?B?Ky1wNzFCTGpoV2FDUUdJKy1LZU9Vc0lDVzBUQnJKQUpsZmdUNVZhempGdURm?=
 =?utf-7?B?NUNKN0NoYXppN1VNZ0hnZHJTNWIyM1pWdVdpcXBENFRrRDZHRFh5ZXpsTEpL?=
 =?utf-7?B?UTBkOVFjNG5YZGI1TlNKVHFRWUg5dXAvR2Zab3ZXdm5xcFR0OU9WNzJmb2t5?=
 =?utf-7?B?SEJBTkVpQlNCODlGd1NIZ2FUWHBKNksxQWdHYkVLSExMWERNVXFjb2YrLVhH?=
 =?utf-7?B?TEFaZjZGRDdUR2YzSVVERVAzcW5MQzVEWWd4eSstVVgxWmRvY1VSRUI0VzI=?=
 =?utf-7?B?OSstS1BKYnVqODBYZVFHVlM2MFlKaE1PUHFSRXhVbE5kZmxyN0hyY2RDb0F4?=
 =?utf-7?B?N0tQZ2xmMmx4dWRON2ZoeGlkOCstTXV4dVB3R1FMMmdvdGdTNnNtaS9MN0Qv?=
 =?utf-7?B?UXFucEVORlQ3WWRQNXN4cFU0dy81WmZpcjhZVXVQKy15STNCQmI0OGp1bnJL?=
 =?utf-7?B?TWtWb3VMajhPeE45bzh0R3NRVGp0OHBXY3NJNDZnTkh3M3V1YlM1YXpXMEVX?=
 =?utf-7?B?QU1JYlNkNFYrLWx4SHBFbEdoWExGZUtiNkQyKy1tSTNYNmxwcm9zWUhQOXFs?=
 =?utf-7?B?ejF0cUt5eUtlNWVINGVhcUY2bUNYdGNhOHorLXVweXRNOGJWVmhneTFFOTE2?=
 =?utf-7?B?bGNYY1dTcmV5NnptWm1wb2hDTm5oL1VDeUFBWEwrLUpveW5QcDdhSWwyRUdu?=
 =?utf-7?B?TVNWejAzT1d2UjRyL29kT2xtbFBZRWVOb3NvT1krLWQwSExQaUdZclpUTGxx?=
 =?utf-7?B?Q00xOGFXbUt2N0N4b2VCTTBCMUlaUW5zeXUyVVhVYkdtMEtHVW1UUEVqTXR6?=
 =?utf-7?B?VXFwVVlqWUk0L2F3RXVlMVFmUGxBT255QWtGOHluV3VHQm8rLWJ1SHgyTjc1?=
 =?utf-7?B?M05nYmJQYnRQUFpNaHBJZVl5Y0JjTHErLTQvdk41aGxXU1JIS3p2V2VSNFFI?=
 =?utf-7?B?WnlTalI3WFdFdzd4UzB0bmZCeW1zRi9sa1RjTlcxTA==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 092c4946-ffe3-4a26-4a80-08dc71d53a50
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2024 16:12:59.9805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VY/t4vKeIE2y6M3ZTyPl2ozNXXbLndUbKFXcNkqiAxYEHPn5x9ut4KV+jhfeuZ8xD5uw8Ajyhhch/t1H0hDADw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB4880
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-11_06,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405110121
X-Proofpoint-GUID: PswMvEEZJCwgd3nYh4vqTe1568p4UCxN
X-Proofpoint-ORIG-GUID: PswMvEEZJCwgd3nYh4vqTe1568p4UCxN
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 clxscore=1015 mlxlogscore=999 malwarescore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405110121


Internal Use - Confidential
+AD4- -----Original Message-----
+AD4- From: Lyndon Sanche +ADw-lsanche+AEA-lyndeno.ca+AD4-
+AD4- Sent: Saturday, May 11, 2024 11:54 PM
+AD4- To: Shen, Yijun +ADw-Yijun+AF8-Shen+AEA-Dell.com+AD4-
+AD4- Cc: Mario Limonciello +ADw-mario.limonciello+AEA-amd.com+AD4AOw- Pali=
 Roh+AOE-r
+AD4- +ADw-pali+AEA-kernel.org+AD4AOw- Armin Wolf +ADw-W+AF8-Armin+AEA-gmx.=
de+AD4AOw-
+AD4- srinivas.pandruvada+AEA-linux.intel.com+ADs- Ilpo J+AOQ-rvinen
+AD4- +ADw-ilpo.jarvinen+AEA-linux.intel.com+AD4AOw- kernel test robot +ADw=
-lkp+AEA-intel.com+AD4AOw- Hans de
+AD4- Goede +ADw-hdegoede+AEA-redhat.com+AD4AOw- Matthew Garrett +ADw-mjg59=
+AEA-srcf.ucam.org+AD4AOw-
+AD4- Jonathan Corbet +ADw-corbet+AEA-lwn.net+AD4AOw- Heiner Kallweit
+AD4- +ADw-hkallweit1+AEA-gmail.com+AD4AOw- Vegard Nossum +ADw-vegard.nossu=
m+AEA-oracle.com+AD4AOw-
+AD4- platform-driver-x86+AEA-vger.kernel.org+ADs- LKML +ADw-linux-kernel+A=
EA-vger.kernel.org+AD4AOw-
+AD4- Dell Client Kernel +ADw-Dell.Client.Kernel+AEA-dell.com+AD4-
+AD4- Subject: RE: +AFs-PATCH v5+AF0- platform/x86: dell-laptop: Implement =
platform+AF8-profile
+AD4-
+AD4-
+AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4-
+AD4-
+AD4-
+AD4- On May 11, 2024 9:22:23+IC8-a.m. MDT, +ACI-Shen, Yijun+ACI- +ADw-Yiju=
n.Shen+AEA-dell.com+AD4-
+AD4- wrote:
+AD4- +AD4-
+AD4- +AD4-
+AD4- +AD4-
+AD4- +AD4-Internal Use - Confidential
+AD4- +AD4APg- -----Original Message-----
+AD4- +AD4APg- From: Lyndon Sanche +ADw-lsanche+AEA-lyndeno.ca+AD4-
+AD4- +AD4APg- Sent: Saturday, May 11, 2024 9:49 AM
+AD4- +AD4APg- To: Shen, Yijun +ADw-Yijun+AF8-Shen+AEA-Dell.com+AD4-
+AD4- +AD4APg- Cc: Mario Limonciello +ADw-mario.limonciello+AEA-amd.com+AD4=
AOw- Pali Roh+AOE-r
+AD4- +AD4APg- +ADw-pali+AEA-kernel.org+AD4AOw- Armin Wolf +ADw-W+AF8-Armin=
+AEA-gmx.de+AD4AOw-
+AD4- +AD4APg- srinivas.pandruvada+AEA-linux.intel.com+ADs- Ilpo J+AOQ-rvin=
en
+AD4- +AD4APg- +ADw-ilpo.jarvinen+AEA-linux.intel.com+AD4AOw- kernel test r=
obot +ADw-lkp+AEA-intel.com+AD4AOw-
+AD4- +AD4APg- Hans de Goede +ADw-hdegoede+AEA-redhat.com+AD4AOw- Matthew G=
arrett
+AD4- +AD4APg- +ADw-mjg59+AEA-srcf.ucam.org+AD4AOw- Jonathan Corbet +ADw-co=
rbet+AEA-lwn.net+AD4AOw- Heiner
+AD4- +AD4APg- Kallweit +ADw-hkallweit1+AEA-gmail.com+AD4AOw- Vegard Nossum
+AD4- +AD4APg- +ADw-vegard.nossum+AEA-oracle.com+AD4AOw- platform-driver-x8=
6+AEA-vger.kernel.org+ADs-
+AD4- LKML
+AD4- +AD4APg- +ADw-linux-kernel+AEA-vger.kernel.org+AD4AOw- Dell Client Ke=
rnel
+AD4- +AD4APg- +ADw-Dell.Client.Kernel+AEA-dell.com+AD4-
+AD4- +AD4APg- Subject: Re: +AFs-PATCH v5+AF0- platform/x86: dell-laptop: I=
mplement
+AD4- +AD4APg- platform+AF8-profile
+AD4- +AD4APg-
+AD4- +AD4APg-
+AD4- +AD4APg- +AFs-EXTERNAL EMAIL+AF0-
+AD4- +AD4APg-
+AD4- +AD4APg-
+AD4- +AD4APg-
+AD4- +AD4APg- On Thu, May 9 2024 at 09:10:51 AM -06:00:00, Lyndon Sanche
+AD4- +AD4APg- +ADw-lsanche+AEA-lyndeno.ca+AD4- wrote:
+AD4- +AD4APg- +AD4- On Wed, May 8, 2024, at 8:24 AM, Shen, Yijun wrote:
+AD4- +AD4APg- +AD4APg-  Hi Lyndon,
+AD4- +AD4APg- +AD4APg-
+AD4- +AD4APg- +AD4APg-   Thanks for working on this patch.
+AD4- +AD4APg- +AD4APg-
+AD4- +AD4APg- +AD4APg-
+AD4- +AD4APg- +AD4APg-   Dell side has an initial testing with this patch =
on some
+AD4- +AD4APg- +AD4APg- laptops, it  looks good. While changing the platfor=
m profile:
+AD4- +AD4APg- +AD4APg-  1. The corresponding USTT option in BIOS will be c=
hanged.
+AD4- +AD4APg- +AD4APg-  2. thermald will not be impacted. The related PSVT=
 and ITMT will
+AD4- +AD4APg- +AD4APg- be loaded.
+AD4- +AD4APg- +AD4APg-   Some Dell DTs does not have the USTT, Dell'll hav=
e a check if
+AD4- +AD4APg- +AD4APg- nothing  is broken.
+AD4- +AD4APg- +AD4APg-
+AD4- +AD4APg- +AD4APg-    Additional, with this patch, follow behavior is =
found:
+AD4- +AD4APg- +AD4APg-   1. For example, the platform profile is quiet.
+AD4- +AD4APg- +AD4APg-   2. Reboot the system and change the USTT to perfo=
rmance.
+AD4- +AD4APg- +AD4APg-   3. Boot to desktop, the platform profile is +ACI-=
quiet+ACI-, the USTT
+AD4- +AD4APg- +AD4APg- will be  changed back to +ACI-quiet+ACI-.
+AD4- +AD4APg- +AD4APg-   This looks like not a proper user experience. The=
 platform
+AD4- +AD4APg- +AD4APg- profile should honor the BIOS setting, aka, the pla=
tform profile
+AD4- +AD4APg- +AD4APg- should be switched to +ACI-performance+ACI-.
+AD4- +AD4APg- +AD4-
+AD4- +AD4APg- +AD4- Hello:
+AD4- +AD4APg- +AD4-
+AD4- +AD4APg- +AD4- Thank you for your email. This is definitely undesirab=
le behaviour,
+AD4- +AD4APg- +AD4- I will have a look at the code to see why this is happ=
ening. Does
+AD4- +AD4APg- +AD4- it always revert to quiet on boot, or always the mode =
that you had
+AD4- +AD4APg- +AD4- switched to prior to reboot?
+AD4- +AD4APg- +AD4-
+AD4- +AD4APg- +AD4- Do you happen to have power-profiles-daemon or somethi=
ng similar
+AD4- +AD4APg- +AD4- running? My understanding is it remembers profiles acr=
oss reboots,
+AD4- +AD4APg- +AD4- this could potentially also revert the profile back to=
 what it was.
+AD4- +AD4APg- +AD4- See this release for details:
+AD4- +AD4APg- +AD4- https://urldefense.com/v3/+AF8AXw-https://gitlab.freed=
esktop.org/upower/p
+AD4- +AD4APg- +AD4- owe
+AD4- +AD4APg- +AD4- r-profiles-daemon/-/releases/0.9.0+AF8AXwA7ACEAIQ-LpKI=
+ACE-jUAEHb-9foumkcmPlEKD6tn
+AD4- +AD4APg- +AD4- QrZ sqjB1sXdPDsYvH2fJ-
+AD4- gPV6G35MUtDW4q3xhlJ4IeLcIgmVpb3ztXqaOg8+ACQ-
+AD4- +AD4APg- +AD4- +AFs-gitlab+AFs-.+AF0-freedesktop+AFs-.+AF0-org+AF0-
+AD4- +AD4APg- +AD4-
+AD4- +AD4APg- +AD4- I will assume there is a bug in my code at this point.=
 I will test
+AD4- +AD4APg- +AD4- with and without ppd running on my system to see if it=
 changes
+AD4- +AD4APg- +AD4- across reboots.
+AD4- +AD4APg- +AD4-
+AD4- +AD4APg- +AD4- Are USTT settings exposed in your BIOS configuration m=
enu? On my
+AD4- +AD4APg- +AD4- laptop they are not and I have to use smbios-thermal-c=
tl.
+AD4- +AD4APg- +AD4-
+AD4- +AD4APg- +AD4- Thank you,
+AD4- +AD4APg- +AD4-
+AD4- +AD4APg- +AD4- Lyndon
+AD4- +AD4APg-
+AD4- +AD4APg- Hi Yijun:
+AD4- +AD4APg-
+AD4- +AD4APg- I tested this on my computer (XPS 9560). I do not have acces=
s to the
+AD4- +AD4APg- USTT settings in the BIOS screen so to substitute that, I bo=
oted
+AD4- +AD4APg- without the patch and set the USTT manually using smbios-the=
rmal-ctl.
+AD4- +AD4APg- Here are my findings:
+AD4- +AD4APg-
+AD4- +AD4APg- Scenario +ACM-1: Without power-profiles-daemon (ppd) running
+AD4- +AD4APg-
+AD4- +AD4APg- 1. Boot with patch, set platform+AF8-profile to quiet 2. Boo=
t without
+AD4- +AD4APg- patch applied (no platform+AF8-profile)
+AD4- +AD4APg-  - smbios-thermal-ctl confirms USTT is set to quiet
+AD4- +AD4APg-  - use smbios-thermal-ctl to set USTT to performance
+AD4- +AD4APg-  - confirm set to performance
+AD4- +AD4APg- 3. Boot with patch again
+AD4- +AD4APg-  - platform+AF8-profile is set to performance
+AD4- +AD4APg-
+AD4- +AD4APg- Scenario +ACM-2: With ppd running
+AD4- +AD4APg- 1. Boot with patch, set platform+AF8-profile to performance =
with ppd
+AD4- +AD4APg-  - Confirm platform+AF8-profile is performance 2. Boot witho=
ut patch
+AD4- +AD4APg- applied (no
+AD4- +AD4APg- platform+AF8-profile)
+AD4- +AD4APg-  - smbios-thermal-ctl confirms USTT is set to performance
+AD4- +AD4APg-  - ppd reverts to balanced (only controlling intel+AF8-pstat=
e in this
+AD4- +AD4APg- case)
+AD4- +AD4APg-  - use smbios-thermal-ctl to set USTT to quiet
+AD4- +AD4APg-  - confirm set to quiet
+AD4- +AD4APg- 3. Boot with patch again
+AD4- +AD4APg-  - platform+AF8-profile and ppd is set to performance
+AD4- +AD4APg-
+AD4- +AD4APg- In my case, the setting in the smbios is honored if it was s=
witched
+AD4- +AD4APg- with another method. When using a userspace program that man=
ipulates
+AD4- +AD4APg- the platform+AF8-profile, the program seems to remember the =
previous
+AD4- +AD4APg- state and switch to that.
+AD4- +AD4APg-
+AD4- +AD4APg- So I do not think there is a bug in this patch related to th=
is issue,
+AD4- +AD4APg- at least in my case. Please let me know if you have any ques=
tions.
+AD4- +AD4APg-
+AD4- +AD4APg- Thanks,
+AD4- +AD4APg-
+AD4- +AD4APg- Lyndon
+AD4- +AD4APg-
+AD4- +AD4APg-
+AD4- +AD4APg-
+AD4- +AD4-Hi Lyndon,
+AD4- +AD4-
+AD4- +AD4- I've made a video recorder of the issue:
+AD4- +AD4-
+AD4- https://urldefense.com/v3/+AF8AXw-https://dell.box.com/s/3f3znz1z8c6h=
tbcll9juj6ty
+AD4- yu0zvvut+AF8AXwA7ACEAIQ-LpKI+ACE-nHHxFbxzG-rJX+AF8-KZsebMC7ZcJU0WhNhk=
pXn-pk6nu-sUF38-
+AD4- RXz6x3YkALgzS4jnUP9TIWIu4mX+AF8-6cSDbwQ+ACQ- +AFs-dell+AFs-.+AF0-box+=
AFs-.+AF0-com+AF0- My test
+AD4- environment is that I freshly installed the Fedora 40 and will not do=
 any online
+AD4- updates. Then install the kernel with the v5 patch applied.
+AD4- +AD4-
+AD4- +AD4- XPS 9560 is a pretty old system which is RTS with 2017. No USTT=
 setting in
+AD4- the BIOS is expected.
+AD4- +AD4- I've a check that the Dell system, at least shipped from 2022, =
the USTT
+AD4- setting will be valid in the BIOS. The system used in above link, it =
is Latitude
+AD4- 7350 which is shipped by 2024 April.
+AD4- +AD4-
+AD4- +AD4- I think the key point to duplicate of this issue that, the USTT=
 needs to be
+AD4- changed under BIOS but not under the Linux OS.
+AD4- +AD4-
+AD4- +AD4-Thanks
+AD4- +AD4-
+AD4- +AD4-
+AD4-
+AD4-
+AD4- Thanks for the video.
+AD4-
+AD4- Fedora 40 has power-profiles-daemon enabled by default AFAIK. This wo=
uld
+AD4- be changing the platform profile at load to match the last known stat=
e.
+AD4-
+AD4- Are you able to rerun this test with PPD disabled? Just in case it is=
 a difference
+AD4- between setting it in BIOS and smbios-thermal-ctl.
+AD4-
+AD4- Thanks,
+AD4-
+AD4- Lyndon

 If disable the PPD, the issue is gone.

Thanks


