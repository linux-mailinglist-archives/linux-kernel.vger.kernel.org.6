Return-Path: <linux-kernel+bounces-173395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E402C8BFFEC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A192282F1E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B65985C77;
	Wed,  8 May 2024 14:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="OroOmXAJ"
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com [148.163.133.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A9C59165;
	Wed,  8 May 2024 14:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.133.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715178337; cv=fail; b=fyQkYEXGXIn1KatM0PIXu6QBkYBMvhv0oluGyvxx+57sCwACayhvHUnTQdTMReEcFe0H4vFatlxL6fLrTi8GAw/6Kw6ah3sD98HKtkJsiupIEeEi9oFfLrXaW5zYt3PEzFBc4IphsFmSxYUN63h34ZjaXleR62c7qp8b84nV+fQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715178337; c=relaxed/simple;
	bh=Q6wuacRhZjQ6LhsKfvSS1O+ysYztkLIS1zDm/Em/lVo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U/VTv11sZHtbQ5sCjLknS+vD9G45UAZb0wfFy9UpCLWoH25ixqS3+hPewHNM8mjNe55nPNOIwAiOV+W3zs/aVnqDxsNu17OWDuUQhlZmQamDGQgOOxYml1c6/VrTCnseSKC+VjzXyTg0gUfA32xKu627M6J14306q5KnSajWoUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=OroOmXAJ; arc=fail smtp.client-ip=148.163.133.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4488ssp5017301;
	Wed, 8 May 2024 10:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=5GIPxvuX0ti79gZoqMrwmxQ04cK2KI08s2IOAbOOWS4=;
 b=OroOmXAJDchkfmfNydJbXfHOrUoECO4e9So34oSyv/c92sbtGiL8JfTyIYZ4n7vuucHF
 xLvUBANSvvQk1N21iMNU3DS9sb3GTVAt+kFuLa6OcXmZLb/esYD+5q1r0QxMyejIB4kE
 kGS3XX/n9gT7GunWGHYCyFiJanaPJukUbhnSf7x6eC9Ev8njRwvDfiE7uIl7RK09hart
 aGh6QDAfpwaz23xDUF3RPkMT9Plgam+vVxEsLEpZwxLi5FPcfkZY8BNFIiY4VGV5EHdW
 NbO0+DpzlEqCoLXRdhJcwHN0Fvf9Chj3lHRjS3EUEM9ZigwjBJYFDQk3pidqV1HO+kgt vw== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3xyswsca3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 10:25:06 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 448DwXOX021615;
	Wed, 8 May 2024 10:24:58 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 3y09agbgjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 May 2024 10:24:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiRauwPgLWUfZLMGGoMEjQN83GzNMI3GV6ZyhdzQk5hif6wUgrZtRf0zS/4YdKbezebQ5CpgbbszkhK2+x96rBnEbM3qXXldbAfeh7niD3vcxYry6xNiusu05bRJUUv7VMDJDaG7Yn66wIXukHmryM8Vwy6tx/7LPJrSv7W5amR+4tJNkIecBpnQ4KrJmdL/w9Q6IQYvIfv3LakxkP9unBRyfUmy7KUqEi+JkOnS/a2Gpwkj2Sf2foghmFjUCPp7mriB37yG/8Qpc36BO1A7b/+htg1KcuOq8G76d7fQhp8047ghn5NDQjbylMcUby1TGdJB2BmwpSBK+p+Nv0KG0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GIPxvuX0ti79gZoqMrwmxQ04cK2KI08s2IOAbOOWS4=;
 b=F/MbBY9Dhx/jsykI2sB1d6cQZyHklVz6s2QV/b4G/I9FbXLN+OLzmMmM/EcxIdi3dCm1glHIZuecL81EK6t3mK/Mly6MCradih6JER6DN3K5sNxco6Ck4UbKhiBtGlCtPj4K7QlIo9XG2M985Vt6UgiOlU1gN1Rt4sdFHPbKzN1uvCYr1PzNZdENH7V+/ohnWuYyS/zvDpUFEJgFtkxTEZJQ8CCttMF2okcanQlfO1KTsznXa8XuRhbi0uqpnbJNXH7EYvdnFFZn2m171cPA7Q6wsiMYeXTxRKZTpt0wFU+f5jlowSFa+3nNWeYIC4/3CRW/zK29wgUl5BbRlUmdbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from BY5PR19MB3922.namprd19.prod.outlook.com (2603:10b6:a03:228::23)
 by SJ0PR19MB5478.namprd19.prod.outlook.com (2603:10b6:a03:3dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Wed, 8 May
 2024 14:24:46 +0000
Received: from BY5PR19MB3922.namprd19.prod.outlook.com
 ([fe80::afc3:5bb2:37fb:2f9d]) by BY5PR19MB3922.namprd19.prod.outlook.com
 ([fe80::afc3:5bb2:37fb:2f9d%2]) with mapi id 15.20.7544.045; Wed, 8 May 2024
 14:24:46 +0000
From: "Shen, Yijun" <Yijun.Shen@dell.com>
To: Lyndon Sanche <lsanche@lyndeno.ca>
CC: "mario.limonciello@amd.com" <mario.limonciello@amd.com>,
        "pali@kernel.org"
	<pali@kernel.org>,
        "W_Armin@gmx.de" <W_Armin@gmx.de>,
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
Thread-Index: AQHanBLh5VIydjU6UEi/YU1qu3GPk7GNIdqg
Date: Wed, 8 May 2024 14:24:46 +0000
Message-ID: 
 <BY5PR19MB392256C65661E76FC292C0889AE52@BY5PR19MB3922.namprd19.prod.outlook.com>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
 <20240501215829.4991-2-lsanche@lyndeno.ca>
In-Reply-To: <20240501215829.4991-2-lsanche@lyndeno.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=38c09660-b345-49e3-9b4d-a7d5cd025907;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=0;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2024-05-08T09:49:20Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR19MB3922:EE_|SJ0PR19MB5478:EE_
x-ms-office365-filtering-correlation-id: 17ea8614-7917-4d62-e08f-08dc6f6a9cdb
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-7?B?WThCbkFwUUFoNEhmMUMvazczMTA2Z29UeEVPNGQwbVBWZG05dGFjZzUwWkhz?=
 =?utf-7?B?Q1JEc3NteWdlbWd2aU9KQUtGdnQ1cTA3cHFHVzA5clhjeFBqMy9IYWgzcG5n?=
 =?utf-7?B?aTNqYjVBa2Y2S0lBdzNKN2pLU2Vrd05UTmhtTTluZWg5Mk9MSXFDOC93dU1Z?=
 =?utf-7?B?VUJGT0lTZVpicTRiNUVQN052VHBSNmx1WGk3blFRWHFuZllqZFpZN3NpMTNE?=
 =?utf-7?B?NERRbHlieWxSYTQ1MDlJYncvZjNWcU5qeURxcUVxRWZaSnFyMkNOUistNVRW?=
 =?utf-7?B?R3hTQ2RwQVp3aEI1V1g4cU9kbDVRL2FVYlhINnVrckhXVE5ZNzI4Wkc0Rksw?=
 =?utf-7?B?andJWU9ZYVAxOFlzcE5PSjk0NFR3TnFUTSstMDczdFB4S0s3bGJnTTlFaHhF?=
 =?utf-7?B?ZDEwQk5SQ08yS1NBdFk2cHY3cGxmcGJ6d1ZzeWNhM08zaTVWSkw5ZVNxb0ts?=
 =?utf-7?B?WDF3UXJ1OTByaVQrLXU2Mm5EOTkzdUp4WDVrU1NOUEs4eWFmaVNkQUJQMGlX?=
 =?utf-7?B?RDU5bUhBZFFyVC8yZFkyd3EwZFhud2UvajBLblk1dExVVVhHREpiVmt1TEs3?=
 =?utf-7?B?dXBKbVBaaXA0dVlFR2J1SzBxcjl0dzFscVAyQngrLTFWUHhqMUpjcXRnN0tP?=
 =?utf-7?B?TE15S1ViWDFTUlQyNERET3B3enluYWJWSWVYWkZCTEZXKy1mYnd1Y3dPOTJ0?=
 =?utf-7?B?ck1Od1A1VDFjQkJMRGdIR2xUZ1IvYWJjMXg4RXdWRkxtd1pVMTMvdWZhKy1Y?=
 =?utf-7?B?dXNkcG9ycGpCa3JOSHl6eGJCT0RVanVlTWJZSjc0am0zQUFZa3JnMFdSNHJq?=
 =?utf-7?B?T011SFpMdTVaUUdnRHZ2ejlZa2t2Ump0Z3AvR2oxcE1tS0dkZ01DYkFsSWJV?=
 =?utf-7?B?RURPR1JUS0dnbUhWcTZidWhqOXBFVVNHeDVDRFBvbjEzQ1QvS3F2d0kxeldz?=
 =?utf-7?B?NG9peE9LOHp5MUVmMUJpTUJzTmt1N28xcCstMktEOGlBU2dzZVpTdkNBUXRN?=
 =?utf-7?B?cnhia3hVbU9laU9KSVhVMFJXQWxwaS9tYU90Q1dpTUFSVkJnQ05nWi9Ibk5q?=
 =?utf-7?B?R0lKNWtwSE5vc1VZNlRGTXpsYW04VkZPWU8walRmOFUyT0pVMFVBM2h4eFFQ?=
 =?utf-7?B?MHFkZTVaUDBVM2duNWQ4VzdiL1RzaUNNVG1UUVIzVTZ2ZjZDRm83TjhWZ0d6?=
 =?utf-7?B?N3ZveTI2enVvQXZvZ2xvZjFuaXZGSy9LR3Q3NVM1VmNteDJ5Zy9oYUEyclZ5?=
 =?utf-7?B?cEd4Zm1LTEdRbGhXcW1JMDNON05zZ0xXKy1QZng3M3FPUnNacjEwOTBOUzJi?=
 =?utf-7?B?MUNPZkFmWlVBc1NpczZwKy1zWnk2TWRCUE9TaGhIUFp1WlBCcEpGcmpyam5j?=
 =?utf-7?B?Y3Q5VlFLWUhXamk5MWZYTnZrMllac3c1TistbEdGaFdPaUwzYzFtSjFDaFBy?=
 =?utf-7?B?L0RMOExzZjljTS9CVDE2Z1h1dG5BY2ZYb2tacjBsV29GNWsyQ2t5VGEwSVdV?=
 =?utf-7?B?OHh1NUViRmhWWXZGNS8vZTF2aUhEU3I0bDY3NWNETU5lVVBudm1FdU1zQ0oy?=
 =?utf-7?B?YTdGakc2ZFY2LzZQSzU5dDZQbUpSVFJjSG5TSURBcHJVOUp6RHlyTk9oOVhI?=
 =?utf-7?B?RHNKTGJhRTc0ZjdlL2U2OXZvdHpPQ25nQlJDbGxOWk9ERG1NV1J3STJ2ekhU?=
 =?utf-7?B?RXlMenZSNXNuWkZxb3RZUy9yZWNxOFo3cUtRaHdvZUpyQTZuNWZHQTJ1aEJP?=
 =?utf-7?B?c1JKMGNJKy1tRDdZWkM3cmtKNkMwamEwSHl5YTFpNystRW1CRlNtS0dqdVZo?=
 =?utf-7?B?ZmFSVDQvTkNEaThQRy9aUUlicWRqZHpHbkh6ZytBRDBBUFEt?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR19MB3922.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-7?B?bkRKOTlDSUh6S2VUSnlsOWNINzJEMkZpbU1xKy0rLXVXQUd4S3RLRGE0ZVMv?=
 =?utf-7?B?bE1tL3p4M1F4MkhqMldoQ0JLSmU3VCstSHhlaVJZTFo1NHQ1NkxyUlNJWUVv?=
 =?utf-7?B?UDRlb1NablE1c0JxYnRoS2Z3RC9RZGxxR2dVTUxEV200aVgvMGZPN0JsNTVJ?=
 =?utf-7?B?a0xwQm1xKy1heUsvLzdGeHBkY0ZTOFAzKy00TTZXREp3R1BkaVFVdkZxKy0x?=
 =?utf-7?B?aFJHbEh3L1Fyc2x4RnpKYU1seFU2WVExMUppR1U2enc1RzhkaGVzMTFRcTdy?=
 =?utf-7?B?MFZSUjFKVDk0cmE3Vlc5UVBXZTRXVmdyV3RaM3BtUU9YZFdFMzgwZG1CeERO?=
 =?utf-7?B?WmlzemYzTGp6Z0lMV0sxT1RtcVFHUXB1RVN0b1BzMGpJY21hcjFibTM5MFZp?=
 =?utf-7?B?a1QybWNjWFpHemNIV0ZlZGpQSjlRa3ErLXpNNTY4R0pjSE5zRlZrV1VobTg4?=
 =?utf-7?B?YXIwRldkTVJrc2N4bEhtNHRWenBydlIyNkNSOUtLTjhFcnhjRFpROGRQd1lY?=
 =?utf-7?B?Um5ZNE12SngyMVJBaEpENUlqTUlBVTNUMzJCaUhHZEI2MndsRmdBMEZ6ajlT?=
 =?utf-7?B?ai9rWGVMZVRqRmIrLXgwM2xqTSstZU8vRDdweU1KR0tkN2RZRGh1d0lpbmhx?=
 =?utf-7?B?Y0ZpRVdlZmVWRHJBeFhrdkNCWTZTWU1hemptd2pCcktQVzNYYmI1NHVyam9L?=
 =?utf-7?B?anBUYjcwWlBmdUtveVl4Q0x3aFdZUnFiNFdWQnNQM3NJaGd4NVpLZWVrSDRi?=
 =?utf-7?B?RE41SDJQUmh0QUhoU2J2MEpKcDgzc1YxSlNrSWxBT0xpOTF0bHZ5d2xTdGxY?=
 =?utf-7?B?bDUwMVpUTWk4WCstcmU4ZUhCKy1Vb05FTTA2cFIza0RlRUlJcG5US1JHZ1ZU?=
 =?utf-7?B?VU4zaUV2cEpFdHdaTkFKYjhBMTVuajRGYnFzeUR5R1ZQQlIxbzFsYjRPNFR5?=
 =?utf-7?B?MGVPZDdFamt5bjhKenowbVZLRERyWUx6UDBjWXlxVm1QanVFWHY5L296TW8y?=
 =?utf-7?B?UGJYc3JwMXBCbkVpU1JTSlY3MXA2QzZWZS9VVk84c0xmSU1UVFFRNk9tWGpv?=
 =?utf-7?B?TE5Qc3RnV0p0YWZnZmNKc3NWRFQ0dUxTTlh4ZFFXQTFPU2xHeGNodVNhUWhE?=
 =?utf-7?B?MjZ6OEU1Vk1XbmJDaEU4OWR3YXN0YkNIc3YzTjFWRmtLR28yZGx6cU9zbkgz?=
 =?utf-7?B?QnEvSHQvaEE4Q1ZBeXZVN2pOcERtN2pLTlQ2aHNkRUQ1UExRKy1NcnIwUjh5?=
 =?utf-7?B?UHdhaVJ0ZHpOZXdqUGFyTUc2d3N4NXN2MzZxMTI3STR5MTFiRHhYTU1BUHVF?=
 =?utf-7?B?VVdkUDNEYksvM2Z2MkVHbWp1M0ZpRXdTKy1KMkRrcUZxaXBRM3NQeGQ5YXpj?=
 =?utf-7?B?cktIcEhMSkNXMkZoYmc3OWg0QkJLL2g2RHk0d3JaL3pjY1VtOWZ5ZEhEREQv?=
 =?utf-7?B?eHo5b3JJSWVqUm1hdlE0b0pyenM5UHBleU5aZHdJT29LM2N6SGVINkhybFpU?=
 =?utf-7?B?V2dvb3JrS21tR0gzMmZPZTdKcTNwVnJSMlJHdE0ybFFsbnFkL0ZQYTl2UFdP?=
 =?utf-7?B?UEpPWktPaHR4Y3dJeE9kYy9BS2V4VGcxWHRoNklnNDJGSlRaM2t4dkw0YUp2?=
 =?utf-7?B?NUt6R05zOTJGcEdZL0taaUVqd1dNYW1aZEdzZHZHOTBFR2ZVMm9HWXFhZFQ0?=
 =?utf-7?B?VW1paVJiakI4eURoY2YvUks2YkNjR3F1NFZ0dXhJSUFRTXVnZUxMdXdiWnR3?=
 =?utf-7?B?YzZaTHA0blRHWW43MTFkaTJZNWVRYVV1S1l1akdsZmdsekhPYnN6UWcva0w1?=
 =?utf-7?B?WW9zN3p3VHJKaGx4NUNsZEd0VndVbHcydmcrLTVrczlLNGhmS2J2RFlNOGlr?=
 =?utf-7?B?c3VkbzBPVWxibk51RUdLaU5hanZrV1ZmeVptbystclBMV3labWdOcWVrVkd1?=
 =?utf-7?B?bFBrQXNQZ0ZMdmNWTWJ5YnJCblFBVGd3NWI4TUNPcTBXd1BWQm1VOFh5cVAv?=
 =?utf-7?B?ZG9YN0M2UnZJQVJkOVV1S3QyMDZmNGhJNjZ3NUdxd1dqWURMTXJ3em1YSTFC?=
 =?utf-7?B?ZlRpUTdiOUgrLXd3OEJ3aUxkRG9CclM2N01IMGNCNm9XYjJxTHpXeVJ5NE9j?=
 =?utf-7?B?WDNMMHZVdWJUcHlaeEwxZ3hPT0xnVDMrLSstYlZpbWt4OHFTcWo4aFhZYkx1?=
 =?utf-7?B?bG5LdUJRYWdkdmE2T01mTVpldDgzeXJ3VDN5Q2pUNlFWKy1IbSstRlN3aEZo?=
 =?utf-7?B?NzlaV25LRjU4Zk9FR2Y5WVBNMQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ea8614-7917-4d62-e08f-08dc6f6a9cdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 14:24:46.8220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b8VQ6cMgUxrGWo8voE9SqDXYzOGGO46ar3uKDj20fpwwR4Utyl29nZKnl1ttCy5+CWpiJTOEu/fZ6cRTLsIMYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB5478
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 clxscore=1011 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405080102
X-Proofpoint-GUID: FHw3afEkD8Ok2oGuzyHqtMNzrtsrAA9-
X-Proofpoint-ORIG-GUID: FHw3afEkD8Ok2oGuzyHqtMNzrtsrAA9-
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 impostorscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405080102

Hi Lyndon,

 Thanks for working on this patch.


Internal Use - Confidential
+AD4- -----Original Message-----
+AD4- From: Lyndon Sanche +ADw-lsanche+AEA-lyndeno.ca+AD4-
+AD4- Sent: Thursday, May 2, 2024 5:58 AM
+AD4- To: lsanche+AEA-lyndeno.ca
+AD4- Cc: mario.limonciello+AEA-amd.com+ADs- pali+AEA-kernel.org+ADs- W+AF8=
-Armin+AEA-gmx.de+ADs-
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
+AD4- Subject: +AFs-PATCH v5+AF0- platform/x86: dell-laptop: Implement plat=
form+AF8-profile
+AD4-
+AD4-
+AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4-
+AD4- Some Dell laptops support configuration of preset fan modes through s=
mbios
+AD4- tables.
+AD4-
+AD4- If the platform supports these fan modes, set up platform+AF8-profile=
 to change
+AD4- these modes. If not supported, skip enabling platform+AF8-profile.
+AD4-
+AD4- Signed-off-by: Lyndon Sanche +ADw-lsanche+AEA-lyndeno.ca+AD4-
+AD4- ---
+AD4- v5:
+AD4-  - Fix indent in smbios-thermal-ctl comment
+AD4-  - Remove linux/wmi.h include
+AD4-  - Add 'select ACPI+AF8-PLATFORM+AF8-PROFILE' to Dell KConfig
+AD4- v4:
+AD4-  - Make thermal+AF8-init and thermal+AF8-cleanup static
+AD4-  - Rearrange order of added includes, did not edit current includes
+AD4-  - Include bits.h
+AD4-  - Switch comment style
+AD4-  - Return error if platform+AF8-profile registering failed
+AD4-  - Add thermal calls to call+AF8-blacklist
+AD4-  - Align defines with tabs
+AD4-  - Correct separation of function and error handling
+AD4-  - Propagate error codes up
+AD4- v3:
+AD4-  - Convert smbios-thermal-ctl docs to multiline comment and wrap
+AD4-  - Change thermal+AF8-mode+AF8-bits enum to directly be BIT() values
+AD4-       - Convert related code to use this
+AD4-  - Use FIELD+AF8-GET/PREP and GENNMASK for getting/setting thermal mo=
des
+AD4-       - Correct offset for getting current ACC mode, setting offset
+AD4-               unchanged
+AD4-  - Check if thermal+AF8-handler is allocated before freeing and
+AD4-        unregistering platform+AF8-profile
+AD4- v2:
+AD4-  - Wrap smbios-thermal-ctl comment
+AD4-  - Return proper error code when invalid state returned
+AD4-  - Simplify platform+AF8-profile+AF8-get returns
+AD4-  - Propogate ENOMEM error
+AD4- ---

 Dell side has an initial testing with this patch on some laptops, it looks=
 good. While changing the platform profile:
1. The corresponding USTT option in BIOS will be changed.
2. thermald will not be impacted. The related PSVT and ITMT will be loaded.
 Some Dell DTs does not have the USTT, Dell'll have a check if nothing is b=
roken.

  Additional, with this patch, follow behavior is found:
 1. For example, the platform profile is quiet.
 2. Reboot the system and change the USTT to performance.
 3. Boot to desktop, the platform profile is +ACI-quiet+ACI-, the USTT will=
 be changed back to +ACI-quiet+ACI-.
 This looks like not a proper user experience. The platform profile should =
honor the BIOS setting, aka, the platform profile should be switched to +AC=
I-performance+ACI-.

+AD4-  drivers/platform/x86/dell/Kconfig            +AHw-   1 +-
+AD4-  drivers/platform/x86/dell/dell-laptop.c      +AHw- 238 +-+-+-+-+-+-+=
-+-+-+-+-+-+-+-+-+-+-+-+-
+AD4-  drivers/platform/x86/dell/dell-smbios-base.c +AHw-   1 +-
+AD4-  drivers/platform/x86/dell/dell-smbios.h      +AHw-   1 +-
+AD4-  4 files changed, 241 insertions(+-)
+AD4-
+AD4- diff --git a/drivers/platform/x86/dell/Kconfig
+AD4- b/drivers/platform/x86/dell/Kconfig
+AD4- index bd9f445974cc..5195ad59b44d 100644
+AD4- --- a/drivers/platform/x86/dell/Kconfig
+AD4- +-+-+- b/drivers/platform/x86/dell/Kconfig
+AD4- +AEAAQA- -57,6 +-57,7 +AEAAQA- config DELL+AF8-LAPTOP
+AD4-       select POWER+AF8-SUPPLY
+AD4-       select LEDS+AF8-CLASS
+AD4-       select NEW+AF8-LEDS
+AD4- +-     select ACPI+AF8-PLATFORM+AF8-PROFILE
+AD4-       help
+AD4-       This driver adds support for rfkill and backlight control to De=
ll
+AD4-       laptops (except for some models covered by the Compal driver).
+AD4- diff --git a/drivers/platform/x86/dell/dell-laptop.c
+AD4- b/drivers/platform/x86/dell/dell-laptop.c
+AD4- index 42f7de2b4522..dc530a4f5047 100644
+AD4- --- a/drivers/platform/x86/dell/dell-laptop.c
+AD4- +-+-+- b/drivers/platform/x86/dell/dell-laptop.c
+AD4- +AEAAQA- -27,6 +-27,9 +AEAAQA-
+AD4-  +ACM-include +ADw-linux/i8042.h+AD4-
+AD4-  +ACM-include +ADw-linux/debugfs.h+AD4-
+AD4-  +ACM-include +ADw-linux/seq+AF8-file.h+AD4-
+AD4- +-+ACM-include +ADw-linux/bitfield.h+AD4-
+AD4- +-+ACM-include +ADw-linux/bits.h+AD4-
+AD4- +-+ACM-include +ADw-linux/platform+AF8-profile.h+AD4-
+AD4-  +ACM-include +ADw-acpi/video.h+AD4-
+AD4-  +ACM-include +ACI-dell-rbtn.h+ACI-
+AD4-  +ACM-include +ACI-dell-smbios.h+ACI-
+AD4- +AEAAQA- -95,6 +-98,7 +AEAAQA- static struct backlight+AF8-device +AC=
o-dell+AF8-backlight+AF8-device+ADs-
+AD4- static struct rfkill +ACo-wifi+AF8-rfkill+ADs-  static struct rfkill =
+ACo-bluetooth+AF8-rfkill+ADs-  static struct
+AD4- rfkill +ACo-wwan+AF8-rfkill+ADs-
+AD4- +-static struct platform+AF8-profile+AF8-handler +ACo-thermal+AF8-han=
dler+ADs-
+AD4-  static bool force+AF8-rfkill+ADs-
+AD4-  static bool micmute+AF8-led+AF8-registered+ADs-
+AD4-  static bool mute+AF8-led+AF8-registered+ADs-
+AD4- +AEAAQA- -2199,6 +-2203,232 +AEAAQA- static int mute+AF8-led+AF8-set(=
struct led+AF8-classdev
+AD4- +ACo-led+AF8-cdev,
+AD4-       return 0+ADs-
+AD4-  +AH0-
+AD4-
+AD4- +-/+ACo- Derived from smbios-thermal-ctl
+AD4- +- +ACo-
+AD4- +- +ACo- cbClass 17
+AD4- +- +ACo- cbSelect 19
+AD4- +- +ACo- User Selectable Thermal Tables(USTT)
+AD4- +- +ACo- cbArg1 determines the function to be performed
+AD4- +- +ACo- cbArg1 0x0 +AD0- Get Thermal Information
+AD4- +- +ACo-  cbRES1         Standard return codes (0, -1, -2)
+AD4- +- +ACo-  cbRES2, byte 0  Bitmap of supported thermal modes. A mode i=
s
+AD4- supported if
+AD4- +- +ACo-                  its bit is set to 1
+AD4- +- +ACo-     Bit 0 Balanced
+AD4- +- +ACo-     Bit 1 Cool Bottom
+AD4- +- +ACo-     Bit 2 Quiet
+AD4- +- +ACo-     Bit 3 Performance
+AD4- +- +ACo-  cbRES2, byte 1 Bitmap of supported Active Acoustic Controll=
er (AAC)
+AD4- modes.
+AD4- +- +ACo-                 Each mode corresponds to the supported therm=
al modes in
+AD4- +- +ACo-                  byte 0. A mode is supported if its bit is s=
et to 1.
+AD4- +- +ACo-     Bit 0 AAC (Balanced)
+AD4- +- +ACo-     Bit 1 AAC (Cool Bottom
+AD4- +- +ACo-     Bit 2 AAC (Quiet)
+AD4- +- +ACo-     Bit 3 AAC (Performance)
+AD4- +- +ACo-  cbRes3, byte 0 Current Thermal Mode
+AD4- +- +ACo-     Bit 0 Balanced
+AD4- +- +ACo-     Bit 1 Cool Bottom
+AD4- +- +ACo-     Bit 2 Quiet
+AD4- +- +ACo-     Bit 3 Performanc
+AD4- +- +ACo-  cbRes3, byte 1  AAC Configuration type
+AD4- +- +ACo-          0       Global (AAC enable/disable applies to all s=
upported USTT
+AD4- modes)
+AD4- +- +ACo-          1       USTT mode specific
+AD4- +- +ACo-  cbRes3, byte 2  Current Active Acoustic Controller (AAC) Mo=
de
+AD4- +- +ACo-     If AAC Configuration Type is Global,
+AD4- +- +ACo-          0       AAC mode disabled
+AD4- +- +ACo-          1       AAC mode enabled
+AD4- +- +ACo-     If AAC Configuration Type is USTT mode specific (multipl=
e bits may be
+AD4- set),
+AD4- +- +ACo-          Bit 0 AAC (Balanced)
+AD4- +- +ACo-          Bit 1 AAC (Cool Bottom
+AD4- +- +ACo-          Bit 2 AAC (Quiet)
+AD4- +- +ACo-          Bit 3 AAC (Performance)
+AD4- +- +ACo-  cbRes3, byte 3  Current Fan Failure Mode
+AD4- +- +ACo-     Bit 0 Minimal Fan Failure (at least one fan has failed, =
one fan working)
+AD4- +- +ACo-     Bit 1 Catastrophic Fan Failure (all fans have failed)
+AD4- +- +ACo-
+AD4- +- +ACo- cbArg1 0x1   (Set Thermal Information), both desired thermal=
 mode and
+AD4- +- +ACo-               desired AAC mode shall be applied
+AD4- +- +ACo- cbArg2, byte 0  Desired Thermal Mode to set
+AD4- +- +ACo-                  (only one bit may be set for this parameter=
)
+AD4- +- +ACo-     Bit 0 Balanced
+AD4- +- +ACo-     Bit 1 Cool Bottom
+AD4- +- +ACo-     Bit 2 Quiet
+AD4- +- +ACo-     Bit 3 Performance
+AD4- +- +ACo- cbArg2, byte 1  Desired Active Acoustic Controller (AAC) Mod=
e to set
+AD4- +- +ACo-     If AAC Configuration Type is Global,
+AD4- +- +ACo-         0  AAC mode disabled
+AD4- +- +ACo-         1  AAC mode enabled
+AD4- +- +ACo-     If AAC Configuration Type is USTT mode specific
+AD4- +- +ACo-     (multiple bits may be set for this parameter),
+AD4- +- +ACo-         Bit 0 AAC (Balanced)
+AD4- +- +ACo-         Bit 1 AAC (Cool Bottom
+AD4- +- +ACo-         Bit 2 AAC (Quiet)
+AD4- +- +ACo-         Bit 3 AAC (Performance)
+AD4- +- +ACo-/
+AD4- +-
+AD4- +-+ACM-define DELL+AF8-ACC+AF8-GET+AF8-FIELD           GENMASK(19, 16=
)
+AD4- +-+ACM-define DELL+AF8-ACC+AF8-SET+AF8-FIELD           GENMASK(11, 8)
+AD4- +-+ACM-define DELL+AF8-THERMAL+AF8-SUPPORTED       GENMASK(3, 0)
+AD4- +-
+AD4- +-enum thermal+AF8-mode+AF8-bits +AHs-
+AD4- +-     DELL+AF8-BALANCED +AD0- BIT(0),
+AD4- +-     DELL+AF8-COOL+AF8-BOTTOM +AD0- BIT(1),
+AD4- +-     DELL+AF8-QUIET +AD0- BIT(2),
+AD4- +-     DELL+AF8-PERFORMANCE +AD0- BIT(3),
+AD4- +-+AH0AOw-
+AD4- +-
+AD4- +-static int thermal+AF8-get+AF8-mode(void)
+AD4- +-+AHs-
+AD4- +-     struct calling+AF8-interface+AF8-buffer buffer+ADs-
+AD4- +-     int state+ADs-
+AD4- +-     int ret+ADs-
+AD4- +-
+AD4- +-     dell+AF8-fill+AF8-request(+ACY-buffer, 0x0, 0, 0, 0)+ADs-
+AD4- +-     ret +AD0- dell+AF8-send+AF8-request(+ACY-buffer, CLASS+AF8-INF=
O,
+AD4- SELECT+AF8-THERMAL+AF8-MANAGEMENT)+ADs-
+AD4- +-     if (ret)
+AD4- +-             return ret+ADs-
+AD4- +-     state +AD0- buffer.output+AFs-2+AF0AOw-
+AD4- +-     if (state +ACY- DELL+AF8-BALANCED)
+AD4- +-             return DELL+AF8-BALANCED+ADs-
+AD4- +-     else if (state +ACY- DELL+AF8-COOL+AF8-BOTTOM)
+AD4- +-             return DELL+AF8-COOL+AF8-BOTTOM+ADs-
+AD4- +-     else if (state +ACY- DELL+AF8-QUIET)
+AD4- +-             return DELL+AF8-QUIET+ADs-
+AD4- +-     else if (state +ACY- DELL+AF8-PERFORMANCE)
+AD4- +-             return DELL+AF8-PERFORMANCE+ADs-
+AD4- +-     else
+AD4- +-             return -ENXIO+ADs-
+AD4- +-+AH0-
+AD4- +-
+AD4- +-static int thermal+AF8-get+AF8-supported+AF8-modes(int +ACo-support=
ed+AF8-bits) +AHs-
+AD4- +-     struct calling+AF8-interface+AF8-buffer buffer+ADs-
+AD4- +-     int ret+ADs-
+AD4- +-
+AD4- +-     dell+AF8-fill+AF8-request(+ACY-buffer, 0x0, 0, 0, 0)+ADs-
+AD4- +-     ret +AD0- dell+AF8-send+AF8-request(+ACY-buffer, CLASS+AF8-INF=
O,
+AD4- SELECT+AF8-THERMAL+AF8-MANAGEMENT)+ADs-
+AD4- +-     if (ret)
+AD4- +-             return ret+ADs-
+AD4- +-     +ACo-supported+AF8-bits +AD0- FIELD+AF8-GET(DELL+AF8-THERMAL+A=
F8-SUPPORTED,
+AD4- buffer.output+AFs-1+AF0-)+ADs-
+AD4- +-     return 0+ADs-
+AD4- +-+AH0-
+AD4- +-
+AD4- +-static int thermal+AF8-get+AF8-acc+AF8-mode(int +ACo-acc+AF8-mode) =
+AHs-
+AD4- +-     struct calling+AF8-interface+AF8-buffer buffer+ADs-
+AD4- +-     int ret+ADs-
+AD4- +-
+AD4- +-     dell+AF8-fill+AF8-request(+ACY-buffer, 0x0, 0, 0, 0)+ADs-
+AD4- +-     ret +AD0- dell+AF8-send+AF8-request(+ACY-buffer, CLASS+AF8-INF=
O,
+AD4- SELECT+AF8-THERMAL+AF8-MANAGEMENT)+ADs-
+AD4- +-     if (ret)
+AD4- +-             return ret+ADs-
+AD4- +-     +ACo-acc+AF8-mode +AD0- FIELD+AF8-GET(DELL+AF8-ACC+AF8-GET+AF8=
-FIELD, buffer.output+AFs-3+AF0-)+ADs-
+AD4- +-     return 0+ADs-
+AD4- +-+AH0-
+AD4- +-
+AD4- +-static int thermal+AF8-set+AF8-mode(enum thermal+AF8-mode+AF8-bits =
state) +AHs-
+AD4- +-     struct calling+AF8-interface+AF8-buffer buffer+ADs-
+AD4- +-     int ret+ADs-
+AD4- +-     int acc+AF8-mode+ADs-
+AD4- +-
+AD4- +-     ret +AD0- thermal+AF8-get+AF8-acc+AF8-mode(+ACY-acc+AF8-mode)+=
ADs-
+AD4- +-     if (ret)
+AD4- +-             return ret+ADs-
+AD4- +-
+AD4- +-     dell+AF8-fill+AF8-request(+ACY-buffer, 0x1, FIELD+AF8-PREP(DEL=
L+AF8-ACC+AF8-SET+AF8-FIELD,
+AD4- acc+AF8-mode) +AHw- state, 0, 0)+ADs-
+AD4- +-     ret +AD0- dell+AF8-send+AF8-request(+ACY-buffer, CLASS+AF8-INF=
O,
+AD4- SELECT+AF8-THERMAL+AF8-MANAGEMENT)+ADs-
+AD4- +-     return ret+ADs-
+AD4- +-+AH0-
+AD4- +-
+AD4- +-static int thermal+AF8-platform+AF8-profile+AF8-set(struct platform=
+AF8-profile+AF8-handler
+AD4- +ACo-pprof,
+AD4- +-                                     enum platform+AF8-profile+AF8-=
option
+AD4- profile) +AHs-
+AD4- +-     switch (profile) +AHs-
+AD4- +-     case PLATFORM+AF8-PROFILE+AF8-BALANCED:
+AD4- +-             return thermal+AF8-set+AF8-mode(DELL+AF8-BALANCED)+ADs=
-
+AD4- +-     case PLATFORM+AF8-PROFILE+AF8-PERFORMANCE:
+AD4- +-             return thermal+AF8-set+AF8-mode(DELL+AF8-PERFORMANCE)+=
ADs-
+AD4- +-     case PLATFORM+AF8-PROFILE+AF8-QUIET:
+AD4- +-             return thermal+AF8-set+AF8-mode(DELL+AF8-QUIET)+ADs-
+AD4- +-     case PLATFORM+AF8-PROFILE+AF8-COOL:
+AD4- +-             return thermal+AF8-set+AF8-mode(DELL+AF8-COOL+AF8-BOTT=
OM)+ADs-
+AD4- +-     default:
+AD4- +-             return -EOPNOTSUPP+ADs-
+AD4- +-     +AH0-
+AD4- +-+AH0-
+AD4- +-
+AD4- +-static int thermal+AF8-platform+AF8-profile+AF8-get(struct platform=
+AF8-profile+AF8-handler
+AD4- +ACo-pprof,
+AD4- +-                                     enum platform+AF8-profile+AF8-=
option
+AD4- +ACo-profile) +AHs-
+AD4- +-     int ret+ADs-
+AD4- +-
+AD4- +-     ret +AD0- thermal+AF8-get+AF8-mode()+ADs-
+AD4- +-     if (ret +ADw- 0)
+AD4- +-             return ret+ADs-
+AD4- +-
+AD4- +-     switch (ret) +AHs-
+AD4- +-     case DELL+AF8-BALANCED:
+AD4- +-             +ACo-profile +AD0- PLATFORM+AF8-PROFILE+AF8-BALANCED+A=
Ds-
+AD4- +-             break+ADs-
+AD4- +-     case DELL+AF8-PERFORMANCE:
+AD4- +-             +ACo-profile +AD0- PLATFORM+AF8-PROFILE+AF8-PERFORMANC=
E+ADs-
+AD4- +-             break+ADs-
+AD4- +-     case DELL+AF8-COOL+AF8-BOTTOM:
+AD4- +-             +ACo-profile +AD0- PLATFORM+AF8-PROFILE+AF8-COOL+ADs-
+AD4- +-             break+ADs-
+AD4- +-     case DELL+AF8-QUIET:
+AD4- +-             +ACo-profile +AD0- PLATFORM+AF8-PROFILE+AF8-QUIET+ADs-
+AD4- +-             break+ADs-
+AD4- +-     default:
+AD4- +-             return -EINVAL+ADs-
+AD4- +-     +AH0-
+AD4- +-
+AD4- +-     return 0+ADs-
+AD4- +-+AH0-
+AD4- +-
+AD4- +-static int thermal+AF8-init(void)
+AD4- +-+AHs-
+AD4- +-     int ret+ADs-
+AD4- +-     int supported+AF8-modes+ADs-
+AD4- +-
+AD4- +-     /+ACo- If thermal modes not supported, exit without error +ACo=
-/
+AD4- +-     ret +AD0- thermal+AF8-get+AF8-supported+AF8-modes(+ACY-support=
ed+AF8-modes)+ADs-
+AD4- +-     if (ret +ADw- 0)
+AD4- +-             return ret+ADs-
+AD4- +-     if (+ACE-supported+AF8-modes)
+AD4- +-             return 0+ADs-
+AD4- +-
+AD4- +-     thermal+AF8-handler +AD0- kzalloc(sizeof(+ACo-thermal+AF8-hand=
ler), GFP+AF8-KERNEL)+ADs-
+AD4- +-     if (+ACE-thermal+AF8-handler)
+AD4- +-             return -ENOMEM+ADs-
+AD4- +-     thermal+AF8-handler-+AD4-profile+AF8-get +AD0- thermal+AF8-pla=
tform+AF8-profile+AF8-get+ADs-
+AD4- +-     thermal+AF8-handler-+AD4-profile+AF8-set +AD0- thermal+AF8-pla=
tform+AF8-profile+AF8-set+ADs-
+AD4- +-
+AD4- +-     if (supported+AF8-modes +ACY- DELL+AF8-QUIET)
+AD4- +-             set+AF8-bit(PLATFORM+AF8-PROFILE+AF8-QUIET, thermal+AF=
8-handler-
+AD4- +AD4-choices)+ADs-
+AD4- +-     if (supported+AF8-modes +ACY- DELL+AF8-COOL+AF8-BOTTOM)
+AD4- +-             set+AF8-bit(PLATFORM+AF8-PROFILE+AF8-COOL, thermal+AF8=
-handler-
+AD4- +AD4-choices)+ADs-
+AD4- +-     if (supported+AF8-modes +ACY- DELL+AF8-BALANCED)
+AD4- +-             set+AF8-bit(PLATFORM+AF8-PROFILE+AF8-BALANCED, thermal=
+AF8-handler-
+AD4- +AD4-choices)+ADs-
+AD4- +-     if (supported+AF8-modes +ACY- DELL+AF8-PERFORMANCE)
+AD4- +-             set+AF8-bit(PLATFORM+AF8-PROFILE+AF8-PERFORMANCE,
+AD4- thermal+AF8-handler-+AD4-choices)+ADs-
+AD4- +-
+AD4- +-     /+ACo- Clean up if failed +ACo-/
+AD4- +-     ret +AD0- platform+AF8-profile+AF8-register(thermal+AF8-handle=
r)+ADs-
+AD4- +-     if (ret)
+AD4- +-             kfree(thermal+AF8-handler)+ADs-
+AD4- +-
+AD4- +-     return ret+ADs-
+AD4- +-+AH0-
+AD4- +-
+AD4- +-static void thermal+AF8-cleanup(void)
+AD4- +-+AHs-
+AD4- +-     if (thermal+AF8-handler) +AHs-
+AD4- +-             platform+AF8-profile+AF8-remove()+ADs-
+AD4- +-             kfree(thermal+AF8-handler)+ADs-
+AD4- +-     +AH0-
+AD4- +-+AH0-
+AD4- +-
+AD4-  static struct led+AF8-classdev mute+AF8-led+AF8-cdev +AD0- +AHs-
+AD4-       .name +AD0- +ACI-platform::mute+ACI-,
+AD4-       .max+AF8-brightness +AD0- 1,
+AD4- +AEAAQA- -2238,6 +-2468,11 +AEAAQA- static int +AF8AXw-init dell+AF8-=
init(void)
+AD4-               goto fail+AF8-rfkill+ADs-
+AD4-       +AH0-
+AD4-
+AD4- +-     /+ACo- Do not fail module if thermal modes not supported, just=
 skip +ACo-/
+AD4- +-     ret +AD0- thermal+AF8-init()+ADs-
+AD4- +-     if (ret)
+AD4- +-             goto fail+AF8-thermal+ADs-
+AD4- +-
+AD4-       if (quirks +ACYAJg- quirks-+AD4-touchpad+AF8-led)
+AD4-               touchpad+AF8-led+AF8-init(+ACY-platform+AF8-device-+AD4=
-dev)+ADs-
+AD4-
+AD4- +AEAAQA- -2317,6 +-2552,8 +AEAAQA- static int +AF8AXw-init dell+AF8-i=
nit(void)
+AD4-               led+AF8-classdev+AF8-unregister(+ACY-mute+AF8-led+AF8-c=
dev)+ADs-
+AD4-  fail+AF8-led:
+AD4-       dell+AF8-cleanup+AF8-rfkill()+ADs-
+AD4- +-fail+AF8-thermal:
+AD4- +-     thermal+AF8-cleanup()+ADs-
+AD4-  fail+AF8-rfkill:
+AD4-       platform+AF8-device+AF8-del(platform+AF8-device)+ADs-
+AD4-  fail+AF8-platform+AF8-device2:
+AD4- +AEAAQA- -2344,6 +-2581,7 +AEAAQA- static void +AF8AXw-exit dell+AF8-=
exit(void)
+AD4-               platform+AF8-device+AF8-unregister(platform+AF8-device)=
+ADs-
+AD4-               platform+AF8-driver+AF8-unregister(+ACY-platform+AF8-dr=
iver)+ADs-
+AD4-       +AH0-
+AD4- +-     thermal+AF8-cleanup()+ADs-
+AD4-  +AH0-
+AD4-
+AD4-  /+ACo- dell-rbtn.c driver export functions which will not work corre=
ctly (and could
+AD4- diff --git a/drivers/platform/x86/dell/dell-smbios-base.c
+AD4- b/drivers/platform/x86/dell/dell-smbios-base.c
+AD4- index e61bfaf8b5c4..5bc2e394dd1c 100644
+AD4- --- a/drivers/platform/x86/dell/dell-smbios-base.c
+AD4- +-+-+- b/drivers/platform/x86/dell/dell-smbios-base.c
+AD4- +AEAAQA- -71,6 +-71,7 +AEAAQA- static struct smbios+AF8-call call+AF8=
-blacklist+AFsAXQ- +AD0- +AHs-
+AD4-       /+ACo- handled by kernel: dell-laptop +ACo-/
+AD4-       +AHs-0x0000, CLASS+AF8-INFO, SELECT+AF8-RFKILL+AH0-,
+AD4-       +AHs-0x0000, CLASS+AF8-KBD+AF8-BACKLIGHT, SELECT+AF8-KBD+AF8-BA=
CKLIGHT+AH0-,
+AD4- +-     +AHs-0x0000, CLASS+AF8-INFO, SELECT+AF8-THERMAL+AF8-MANAGEMENT=
+AH0-,
+AD4-  +AH0AOw-
+AD4-
+AD4-  struct token+AF8-range +AHs-
+AD4- diff --git a/drivers/platform/x86/dell/dell-smbios.h
+AD4- b/drivers/platform/x86/dell/dell-smbios.h
+AD4- index eb341bf000c6..585d042f1779 100644
+AD4- --- a/drivers/platform/x86/dell/dell-smbios.h
+AD4- +-+-+- b/drivers/platform/x86/dell/dell-smbios.h
+AD4- +AEAAQA- -19,6 +-19,7 +AEAAQA-
+AD4-  /+ACo- Classes and selects used only in kernel drivers +ACo-/  +ACM-=
define
+AD4- CLASS+AF8-KBD+AF8-BACKLIGHT 4  +ACM-define SELECT+AF8-KBD+AF8-BACKLIG=
HT 11
+AD4- +-+ACM-define SELECT+AF8-THERMAL+AF8-MANAGEMENT 19
+AD4-
+AD4-  /+ACo- Tokens used in kernel drivers, any of these
+AD4-   +ACo- should be filtered from userspace access
+AD4- --
+AD4- 2.42.0


