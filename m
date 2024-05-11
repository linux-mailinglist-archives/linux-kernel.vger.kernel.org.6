Return-Path: <linux-kernel+bounces-176601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F458C3219
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 17:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FD43281F8E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 15:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C26A5646D;
	Sat, 11 May 2024 15:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="kQQgq5EP"
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA225336F;
	Sat, 11 May 2024 15:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.137.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715440989; cv=fail; b=DcKjRu0bktAItt9ewlVrhhuI2T8X6H/R3yHRioja8T77a/nL0Oa3zykVYsohGkTekChXeecad7L6c+VeVOzBBWays2kYfTABypLKbjf+v5AyWZ0q5+zeBFq/x8psxIlbBdfy5FFJOZjZk5FRJXI/pTGFvGIQaOz6L48MdGgGYso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715440989; c=relaxed/simple;
	bh=rMOcstgZAh4LyALhigRqJkSOEmqjhdaWqY1vxHDbyuM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fbkoO472YlvQKIjkGpkNCFwX6fBiEbIeUrf6yBsYNFF+w1HoGx6UgVXQhM0gaMPCSLejotor8NRDk9yy3FSKcmFN1EY3nsk7k3q94IvkYccqWbHLWtADx0+l+SRgrCnzX5JpMjoeom9/phst3futAz2FG6k2ud7wd96gGG+FQ3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=kQQgq5EP; arc=fail smtp.client-ip=148.163.137.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44B7g8jj014028;
	Sat, 11 May 2024 11:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=Zu+FFrKMxRBF/FLsiSkVSgdQA7C04s0EdVota/JOGn0=;
 b=kQQgq5EPvLX1Pu8tdt0ojR5GbdLQgDIA5uofq8h9v00K3T37e+XvdgpJg+6XcFQn5MMd
 9k2F1ZTuiAdKRrWoIKAn6DgUWCs1J+8oFopcOO4hC4Ad37ztWsus81ZcpaVJ/ggmGqgz
 pFyKUkDQOYtwzuB5wXVVzKOMOg9YIaySmsJwxGnWFwvM4VQNLFbO6BAuz5mFaovxYnzb
 BZjihf/SnqVlZdcW2pmgsGwZO8zg7DntR2/20C8Hej3CtDqE935isBqGFmpWkU0fgy/h
 +WwkildEWteAqVUg0tlYJXPhDicR3LHPu2Yj1F8w3f3ZTzudUXaLCoOMdRbWg4ds4gNX mg== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3y24gy8tcu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 May 2024 11:22:29 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44BEXKBI036528;
	Sat, 11 May 2024 11:22:28 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 3y2ahjgcw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 11 May 2024 11:22:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nmb3d67aBDnC50/+b05cAnEDLVom3xl19HmTJXI+eWpNI0xvQW7qGg/BUpMSIvb9ulwrzeNJKoMh0T1t+lOfq25I/ziR7rhcJ8p87cNuAlmQ8PPPmQuKBdTJu3sCsb6Wkknihaxn4SM/eQxmzV85Yf/ySXz3F+Lt9oB9h7m6y+KQzCAk7lwIsbd107ujHHQqVgB8Deyz0P/LjMxfNC0353H4MCh9v8tmgU/g8kOJlo3teww6i/NvoLPx54E8uWLNV+yaJ+4nR/L2pACYXNK7T9ADrU641MS5jA+bPFp/KaCA5oTNrgCfOFQGq8udznS5G2Bt57qeZb7dvEizmF9cRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zu+FFrKMxRBF/FLsiSkVSgdQA7C04s0EdVota/JOGn0=;
 b=k+ywI/oTYejM7xUj+Fug0aqgwye1vNUyZ6RlZ5dYZt22TMiEATJuI6pgGuo4JuX+7SQBZBZNDHaaaU3XFe9uBc4GGGr/ln7ldOQY5IZfph5uNW3bup5QxXVw8F651aTbLtJdGaVrtmLihEavTA1yCmn3Xq9vJSNTnsoQbuiLvozwIGMZt0cD5kYe2c6jC64hrZAHhjflGtgDnbTIKN3iIrUr+zm9ogrsOq//GWOin2lhmeb4HNi9A93bWkjUxq6QfarJw4/OfmzOvcZ/o03Y7P6dGeS7+Lb8NqLvEep6BMvftaDMpC1q0Ytt0SPQ0zdQ1ZnTPU3UGmyF8LlyAHwKgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from BY5PR19MB3922.namprd19.prod.outlook.com (2603:10b6:a03:228::23)
 by MN0PR19MB5754.namprd19.prod.outlook.com (2603:10b6:208:375::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sat, 11 May
 2024 15:22:24 +0000
Received: from BY5PR19MB3922.namprd19.prod.outlook.com
 ([fe80::afc3:5bb2:37fb:2f9d]) by BY5PR19MB3922.namprd19.prod.outlook.com
 ([fe80::afc3:5bb2:37fb:2f9d%2]) with mapi id 15.20.7544.052; Sat, 11 May 2024
 15:22:23 +0000
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
Thread-Index: AQHanBLh5VIydjU6UEi/YU1qu3GPk7GNIdqggAHsKICAAkSsgIAA3t+A
Date: Sat, 11 May 2024 15:22:23 +0000
Message-ID: 
 <BY5PR19MB39223A0977CE393BA6833DB29AE02@BY5PR19MB3922.namprd19.prod.outlook.com>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
	<20240501215829.4991-2-lsanche@lyndeno.ca>
	<BY5PR19MB392256C65661E76FC292C0889AE52@BY5PR19MB3922.namprd19.prod.outlook.com>
	<aaa1ebb5-3e0a-40ef-b53d-d8adc1589085@app.fastmail.com>
 <X1TADS.8PTII3LXSHHX1@lyndeno.ca>
In-Reply-To: <X1TADS.8PTII3LXSHHX1@lyndeno.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=a1a3c732-02e8-4bab-9e0a-526dfbf6b6dd;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=0;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2024-05-11T15:06:50Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR19MB3922:EE_|MN0PR19MB5754:EE_
x-ms-office365-filtering-correlation-id: 51152483-7636-4e24-aad1-08dc71ce289c
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|366007|1800799015|7416005|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-7?B?eUJyNUZXVlZxVzVqeVh4cCstOENELzNHRUNvTEtDT3NMQXMvRnYvL2xXOWgv?=
 =?utf-7?B?MG0vdFlrVDdNbi8zaWNXVWhxcUE5d0R6cUl3eHlLU05HTkx0NHhDbmlLZDZQ?=
 =?utf-7?B?emtBS0J4c1B1WTF6L2tzclppVWR5b1RQRlB2ejVrNkZoWWtBeW1ucjNGSGh1?=
 =?utf-7?B?cnZxeFlGd3FEamh6ODB1Ky1ZUCstRi9ocTJUZHBXeHBrMjk5ek5lenEwdVBk?=
 =?utf-7?B?d2FvVm9LTERHdXIzaHJGUnpVWXhPL2hmYWFNMHVta3d6d05CdXhibm42Vk40?=
 =?utf-7?B?WHVNVnNUZzF5VER4VGI1cHBkRWNWU3AvbGFaWk9xVEtuQUpHMXFCUGkzSEI1?=
 =?utf-7?B?VTRkWTJCMnppSElQYVpKYm8rLSstVVBCVk5sZ09XemRjd1cvRmFRVzQ4Mms5?=
 =?utf-7?B?ZmNSRCsteko4dWpxVktINVVMa01tS0tkMVZkNllmdGZCRk8zdGlnUVVIalVO?=
 =?utf-7?B?STdLeFZkZ1o5Sm1vSEgrLW1iTDltSGVmZ2kvMDJHcDFPWk5LNW9rOW1HYzZs?=
 =?utf-7?B?eVFJN1hkUDZHR3YzSlhQMDZaMWhPSHZTNWZkNEdaaHQzeHNXQVRqZXl5a1ls?=
 =?utf-7?B?eVFHdU5zY3EzaDJrVXVqTFF6UGErLVBhVjZEUXdEaW01TERTUUpXeTJReGNa?=
 =?utf-7?B?ZnhoM0xnNUJDMzNZT1VtU2tJMzVmNDdZKy15cElMT3hJRjh3T3M4eWxYbmZT?=
 =?utf-7?B?cEd2VnYrLVozbjJ3bHg5MVV2Z1ArLUdjdWExWEQ0L3BTWVdENEsyYkwzamlK?=
 =?utf-7?B?MTR4eEdXWFFqdG10ZlhhUGhWNjlvWFRUNmtUUVRuWW5ycG1VVHh5L0h3eFVI?=
 =?utf-7?B?NnZpdWtkamd6WXVjOXB6SXJGUGEyVk1ZY25Jd3VwQ0tNN1o5RW5hM1BGYVZ1?=
 =?utf-7?B?eEJBR3dDNmY3OGNSL2RWVlZMVystSUJBdnRIYnhHbURSNHZjNFZ2NHYwVlg0?=
 =?utf-7?B?czlvVm8vVHNnSjhBbVJleFp3RmdNU0JDZ1JGQWxsbldXVXZSeDZ0T09wY3Ew?=
 =?utf-7?B?a0ZGcFNSaXFNRjhUWlVGS0k3Ky05VXExMGNkUE5ZYmlLUmtKUVV1VVY5NkVP?=
 =?utf-7?B?ZUFaaVl2dVNiYmNZNURtSDlDSXZEMGg0SGV3Mk9HTEJuTU8rLU0xb0hpdFIz?=
 =?utf-7?B?T0VpQlJ5NVVkbUwveUR0YW9kcm4vdXJPVFluOWZaei8vRkp5MWFkai9jWGp0?=
 =?utf-7?B?TmpaN1RpbmxuOXN3VEZlTEg0dzVFclAzL21mKy01S2ZHQ2c2dXpGTTg5RS9L?=
 =?utf-7?B?Z1lEUExjNFJILzhUMWdUSHNTOTJLb1VFa294ajJSNE1PbkFGelpnYktUeDBI?=
 =?utf-7?B?MW5jRVRpZEVzT0xMbUhycENFQnhEUnFnU1QyckE4Ky1YQnVud09oakt2OExz?=
 =?utf-7?B?R01GWXRoa29mZ3FrdzJxcXZXb0I0YzhNcnBnKy1OaFpuYjQ4T2U1Ky1NWG5o?=
 =?utf-7?B?dEREcFg3U2dWblR2T1lUV0FjWVl1ek5JTW5SaHdDRkFaZUxadm5IZjQ3V1U5?=
 =?utf-7?B?TXF2amEyU3l3cW11RUk0Rnl0N2xDRDNxY0llKy0zQWp6VmJWbEFLYWlGdTJx?=
 =?utf-7?B?cmZyaTk4MTk1TVV5V1pkUVh6b0NYQ1k3TlNkcElTVWxYT3ZBVzU2NEVsNUdR?=
 =?utf-7?B?alVrYnUxVnI0ekV3czFqNXlEQjVycEdFeVF2c2RvcFpPTkpDaU10a3RyT3kw?=
 =?utf-7?B?Q2hPWDJRNmhYYWtZaGJTZlNpa0VEZS9oZHE5NVdQdldVeEMyaDd5bjBVWWJj?=
 =?utf-7?B?bGtMNDd2Z1Z1UVRLS3RPUStBRDBBUFEt?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR19MB3922.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-7?B?VFFSOG5zQ0lQVVpOYkllRjF2RE5DRFozV044M1dRYWZ0Q3UrLTJCRU5IVE9j?=
 =?utf-7?B?UHViMVEvVUs5bUd2d0k0NjdLRzNSL1NMYjJjQnU1Zm5wNXdvaFRsd0tITllp?=
 =?utf-7?B?dWpkOVBXYWcxQXZzUVRNTi9RNWVHdUxza0xRODNzdkhySFRvOW1INU1pdVps?=
 =?utf-7?B?MGVoVWVGS0w1U3czWXVVZ0I3cGZqcFhhQ2lodjB0NDBMUistZU80UVo4bWxK?=
 =?utf-7?B?ZHRYT0JWZjErLU5BZXZWU2xpUWZhSHdVOXZkNTVkWTZpNHBLbC9yOTlmYUtU?=
 =?utf-7?B?TU5OZ05kN1R0bnBqa1F4aTNVQ2RKeSstWTVxZ2IwZUJFZUk3OHNwWW1ERExm?=
 =?utf-7?B?cXlMZVY1VmNIeXJnUTNjMjhrL3dBbmZhZFdrWlFxeEVpbUYwWjZVU2o3ek02?=
 =?utf-7?B?Y2pyb0VsTHlLbGZudlN3SFVoUEtuOEt4d2lBSW93OXgwQmJERTQ2VzhTSG5J?=
 =?utf-7?B?V0lXNUxZRG5oanB2VEFvZHdXNEoxTjIwQUdkN25zNUN0eTRuU01PaGFjdFda?=
 =?utf-7?B?aGhuMDV6VjZVTUhzT0JMNlI4eGFmSEdaWFNheXNvOTZBNC9KRnJGdXdtVU93?=
 =?utf-7?B?eFVqUHN4eHZ2dEs5RG5YYXYzN2RtWnhhaVpjZEMrLXl3Wk83eWkwSS93MmNJ?=
 =?utf-7?B?VzNabDJnaHNreWVnbnlkM0VVSjFHeVZVKy1hQWpNMXUxaDh1c0JLY2pHU0lY?=
 =?utf-7?B?YS9iQjBTN05mNGQrLWd5NWVid3FaRVpWQ1FZbUtEZFRLTmFrSjF2aVZaM04=?=
 =?utf-7?B?RCstKy1iS0U3YlI5dmRycnh1VVB4TFBZNS9lU0xUeTA4VUp6MC80UVVvVFpt?=
 =?utf-7?B?U3lSbUhIRGxQSUhwRWNpVzArLVZiOWU3TWZvRFpRN0lwdzlMejdXbUVoUThM?=
 =?utf-7?B?MGZJU01VZWhNV2J5VnRNckxOV3ViWW9RYklWdzZhSUpHZkRCbVBoS2JXOTQz?=
 =?utf-7?B?ZnJMM0p6VFlVWi9SYWFYdGUvL0VPbHRkL2RrTmk0WlVINS9EandkTmVaVTFW?=
 =?utf-7?B?dFdtUzZmZk85Y3NiTGtQanJUSjA4d2VHQ0RZRjNhaWJCRmJTNTl1UzRXcVV0?=
 =?utf-7?B?NjFWWHBra1hWZlMzWlZ5d0I1dWxxTUNTZldUaTk4VzZ1azk5eUFvWHhwVEIz?=
 =?utf-7?B?Z2VVOHhMakt5QzJDY0hJSkFaY3IySmJOMS91M0p5ZjY0NTArLVhjdTFETkpx?=
 =?utf-7?B?OFNBSE5RR3dRQ3gxUnNSRGRGOGR3ZjBTUXFSY0l0cUVBMmlQYThWSXRMU2sv?=
 =?utf-7?B?MlBXTTk0T20xZnY1WnpkNFJjeFJLZHdaRDR3TzF5S1NPVDF4cy9sa1BuaTBj?=
 =?utf-7?B?ZDFPSk8xalpNUUpLKy16ZTlCYzMvT1NXeFdFdGxGdExsamFXOW1lZHp5YUZM?=
 =?utf-7?B?WVkrLUNoYzRtTHRpY1pPOFhBRTQvVktqUkk3Ky1tRjFSRistKy1OdWNQZHVl?=
 =?utf-7?B?TEJaWHBZRFRwUjFBd2t3RkxUNTN5Um1SV2oyQXhLdnkwT2J4aUpxWjY4MU9B?=
 =?utf-7?B?WnNEKy1ybTZsMDlEOXlEWVVzdGFUN2ZKQ01EWGFKVHlWTmVhcWR4blE1TTdz?=
 =?utf-7?B?Qy93Z1ZqMkl0V0JVV2xkTkRPc3hraFBIVzh6YTM2VXhsUFpJbUNmMW5td29R?=
 =?utf-7?B?cGNscGZleG01RWhYeHFWbVpweHdXYWs3ZWUzeTZoQ29Vd2I2N2dxMUlkcFQ3?=
 =?utf-7?B?TTJGaFU1cGthKy10Z1JnUnZBcG5mQUs0aGNsQmRHTWowNTVZSDcxSXJaNDA=?=
 =?utf-7?B?Ky1ZbWVCTSstdEI1b2NuME9hM1lDMUxDVG1WKy0vVVhOeU8vQW9wb1JRYmto?=
 =?utf-7?B?SXRaZ0s0cWVoWGVHbHhYMU95YmNJVk9pUUNZakR5Y0dtdWFFQkFIU29ORlp3?=
 =?utf-7?B?R0hPb1A4elJKSTdRNG1uZTdOQ2dOUVE2WnhzMXUwTVpxME0rLUt6a3hKME9R?=
 =?utf-7?B?N2VrdUQwWEZSQWhKZENGSFIyMmJGYUd0SWdlUExPNEtUMistNUU5Q1MvN1lW?=
 =?utf-7?B?d1p2WWFHVjFVL0J3ZThLWjNqbHE4ZlpKYkF6WWFCWWFzVVVrRnhqKy1aZzJO?=
 =?utf-7?B?dGFQQUNtM2c4ZzNjY0tKMFZUdFZZNm5WU2hUc2ZVQ2haZ0hIOVVYdnljS1dC?=
 =?utf-7?B?TEU0dk5iN0JzbnBtdnh1UFEycDAyTDlWTTRwcTZzWlI5VDZ2aGJZUGZuSENw?=
 =?utf-7?B?ZHdQN00vSEtmaistL09taXdiZGZ3QmU1UVpTRHU0VHQwMTlrMUI5UkljMDJ1?=
 =?utf-7?B?OHpYV2hmODhONGVNUWhtWjJjMTE3ajkwTnU=?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 51152483-7636-4e24-aad1-08dc71ce289c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2024 15:22:23.8131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nGPTRnEJ9OY9FHSbI+dJpeCuvpMZLmOhD0iGBALb+04KqtJUGez7wDOg6f89V0bF4WdIdZgEgz/KjFVDLPimpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR19MB5754
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-11_06,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 mlxscore=0
 spamscore=0 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405110114
X-Proofpoint-GUID: yKIMY_qrG9S0rptQn585tnlDT3Yfmzm6
X-Proofpoint-ORIG-GUID: yKIMY_qrG9S0rptQn585tnlDT3Yfmzm6
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 suspectscore=0
 mlxscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405110115




Internal Use - Confidential
+AD4- -----Original Message-----
+AD4- From: Lyndon Sanche +ADw-lsanche+AEA-lyndeno.ca+AD4-
+AD4- Sent: Saturday, May 11, 2024 9:49 AM
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
+AD4- Subject: Re: +AFs-PATCH v5+AF0- platform/x86: dell-laptop: Implement =
platform+AF8-profile
+AD4-
+AD4-
+AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4-
+AD4-
+AD4-
+AD4- On Thu, May 9 2024 at 09:10:51 AM -06:00:00, Lyndon Sanche
+AD4- +ADw-lsanche+AEA-lyndeno.ca+AD4- wrote:
+AD4- +AD4- On Wed, May 8, 2024, at 8:24 AM, Shen, Yijun wrote:
+AD4- +AD4APg-  Hi Lyndon,
+AD4- +AD4APg-
+AD4- +AD4APg-   Thanks for working on this patch.
+AD4- +AD4APg-
+AD4- +AD4APg-
+AD4- +AD4APg-   Dell side has an initial testing with this patch on some l=
aptops,
+AD4- +AD4APg- it  looks good. While changing the platform profile:
+AD4- +AD4APg-  1. The corresponding USTT option in BIOS will be changed.
+AD4- +AD4APg-  2. thermald will not be impacted. The related PSVT and ITMT=
 will be
+AD4- +AD4APg- loaded.
+AD4- +AD4APg-   Some Dell DTs does not have the USTT, Dell'll have a check=
 if
+AD4- +AD4APg- nothing  is broken.
+AD4- +AD4APg-
+AD4- +AD4APg-    Additional, with this patch, follow behavior is found:
+AD4- +AD4APg-   1. For example, the platform profile is quiet.
+AD4- +AD4APg-   2. Reboot the system and change the USTT to performance.
+AD4- +AD4APg-   3. Boot to desktop, the platform profile is +ACI-quiet+ACI=
-, the USTT will
+AD4- +AD4APg- be  changed back to +ACI-quiet+ACI-.
+AD4- +AD4APg-   This looks like not a proper user experience. The platform=
 profile
+AD4- +AD4APg- should honor the BIOS setting, aka, the platform profile sho=
uld be
+AD4- +AD4APg- switched to +ACI-performance+ACI-.
+AD4- +AD4-
+AD4- +AD4- Hello:
+AD4- +AD4-
+AD4- +AD4- Thank you for your email. This is definitely undesirable behavi=
our, I
+AD4- +AD4- will have a look at the code to see why this is happening. Does=
 it
+AD4- +AD4- always revert to quiet on boot, or always the mode that you had
+AD4- +AD4- switched to prior to reboot?
+AD4- +AD4-
+AD4- +AD4- Do you happen to have power-profiles-daemon or something simila=
r
+AD4- +AD4- running? My understanding is it remembers profiles across reboo=
ts,
+AD4- +AD4- this could potentially also revert the profile back to what it =
was.
+AD4- +AD4- See this release for details:
+AD4- +AD4- https://urldefense.com/v3/+AF8AXw-https://gitlab.freedesktop.or=
g/upower/powe
+AD4- +AD4- r-profiles-daemon/-/releases/0.9.0+AF8AXwA7ACEAIQ-LpKI+ACE-jUAE=
Hb-9foumkcmPlEKD6tnQrZ
+AD4- +AD4- sqjB1sXdPDsYvH2fJ-gPV6G35MUtDW4q3xhlJ4IeLcIgmVpb3ztXqaOg8+ACQ-
+AD4- +AD4- +AFs-gitlab+AFs-.+AF0-freedesktop+AFs-.+AF0-org+AF0-
+AD4- +AD4-
+AD4- +AD4- I will assume there is a bug in my code at this point. I will t=
est
+AD4- +AD4- with and without ppd running on my system to see if it changes =
across
+AD4- +AD4- reboots.
+AD4- +AD4-
+AD4- +AD4- Are USTT settings exposed in your BIOS configuration menu? On m=
y
+AD4- +AD4- laptop they are not and I have to use smbios-thermal-ctl.
+AD4- +AD4-
+AD4- +AD4- Thank you,
+AD4- +AD4-
+AD4- +AD4- Lyndon
+AD4-
+AD4- Hi Yijun:
+AD4-
+AD4- I tested this on my computer (XPS 9560). I do not have access to the =
USTT
+AD4- settings in the BIOS screen so to substitute that, I booted without t=
he patch
+AD4- and set the USTT manually using smbios-thermal-ctl.
+AD4- Here are my findings:
+AD4-
+AD4- Scenario +ACM-1: Without power-profiles-daemon (ppd) running
+AD4-
+AD4- 1. Boot with patch, set platform+AF8-profile to quiet 2. Boot without=
 patch applied
+AD4- (no platform+AF8-profile)
+AD4-  - smbios-thermal-ctl confirms USTT is set to quiet
+AD4-  - use smbios-thermal-ctl to set USTT to performance
+AD4-  - confirm set to performance
+AD4- 3. Boot with patch again
+AD4-  - platform+AF8-profile is set to performance
+AD4-
+AD4- Scenario +ACM-2: With ppd running
+AD4- 1. Boot with patch, set platform+AF8-profile to performance with ppd
+AD4-  - Confirm platform+AF8-profile is performance 2. Boot without patch =
applied (no
+AD4- platform+AF8-profile)
+AD4-  - smbios-thermal-ctl confirms USTT is set to performance
+AD4-  - ppd reverts to balanced (only controlling intel+AF8-pstate in this=
 case)
+AD4-  - use smbios-thermal-ctl to set USTT to quiet
+AD4-  - confirm set to quiet
+AD4- 3. Boot with patch again
+AD4-  - platform+AF8-profile and ppd is set to performance
+AD4-
+AD4- In my case, the setting in the smbios is honored if it was switched w=
ith
+AD4- another method. When using a userspace program that manipulates the
+AD4- platform+AF8-profile, the program seems to remember the previous stat=
e and
+AD4- switch to that.
+AD4-
+AD4- So I do not think there is a bug in this patch related to this issue,=
 at least in my
+AD4- case. Please let me know if you have any questions.
+AD4-
+AD4- Thanks,
+AD4-
+AD4- Lyndon
+AD4-
+AD4-
+AD4-
Hi Lyndon,

 I've made a video recorder of the issue: https://dell.box.com/s/3f3znz1z8c=
6htbcll9juj6tyyu0zvvut
 My test environment is that I freshly installed the Fedora 40 and will not=
 do any online updates. Then install the kernel with the v5 patch applied.

 XPS 9560 is a pretty old system which is RTS with 2017. No USTT setting in=
 the BIOS is expected.
 I've a check that the Dell system, at least shipped from 2022, the USTT se=
tting will be valid in the BIOS. The system used in above link, it is Latit=
ude 7350 which is shipped by 2024 April.

 I think the key point to duplicate of this issue that, the USTT needs to b=
e changed under BIOS but not under the Linux OS.

Thanks



