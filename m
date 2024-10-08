Return-Path: <linux-kernel+bounces-354523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C5C993E96
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0941C231DD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 06:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2339D1474D8;
	Tue,  8 Oct 2024 06:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="wWeQmL72"
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4347013B2B8;
	Tue,  8 Oct 2024 06:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.137.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728367523; cv=fail; b=OwGDfRGoOSPLLe2wYUS7YJmEubumHpZyp95qTrxwQdFPGemiZHHNbdbYU/k2GsfKy9Dm6tXhxFUrLnr+P83BRy9uT8hrOUMlkm/IxVjpAKfoWCNCyYf+ueE1SKN8edA9zUI4RDQ1ylh077oHAZbdfFA+2+w/ZbgR1HbYckdaN/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728367523; c=relaxed/simple;
	bh=g9esarYQMEY/MRZ+ac3PKI3MfdJMDee2DWWcmr3m1vo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KhwrjMHpoirtSwg9u9+qr96GEG5JUqUi+KYT7EnqEsj2+/pLXjrk7xOj02r/+I1wTwf3fs9sR5zeolWUStGw7zGRMn1YrMyP1smKeRgqpQobFI7gBItiSQRVXP9dvq4PfHL6J0Dy7i2plMSH3u5lVNHGkzZNLMvcDCuzuu9cVD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=wWeQmL72; arc=fail smtp.client-ip=148.163.137.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4983w5He009312;
	Tue, 8 Oct 2024 00:32:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=smtpout1; bh=I
	Zg1pZ7Uo8z4KvwO+Nmga/42pNGTLYtf7zedxNsRZZ8=; b=wWeQmL720v+d7NQFs
	jDFTa9MAoUlH5gK1m2XSEMP4aFjUcJTGfSLuK0BecgnJGrDH/T8h2sl8jUUy5cuT
	oyHnBSMSkBTACzBd3wKZczfQcDUzkVu9FZ85IKBHsTAZ0dq86Q8ypQnODxsQz9cx
	9RlwgwUtQfmF9xgJPIuIkABLd9N5rJYmWFQ2YiFRr2OiiWzQGC8fvC6RgXeS/5S8
	KWBFMc/nQkT1+PRFGH+rORhb6ltbZjrEV5CtDpY1CIgUwK8UeCWMMwGmtwFIHP/v
	IMNJ8LI57x4mFz8efEVNL/Ps5Io412mqaNNDsBpDPR3eFT9JtVI5UU3wdnmDDIuj
	VQIhw==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 42324ja14m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 00:32:49 -0400 (EDT)
Received: from pps.filterd (m0393468.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4983Egj3021891;
	Tue, 8 Oct 2024 00:32:49 -0400
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 423hxfkyr8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 00:32:48 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IGU+hpLnhCyFhAfZsoTmwq0qAZ+mmhbbiCpIf5kKOtN8P5GTrJL9LMM/3g8lMud4XdglMnJkhs4P8HJxFA2gcox1XKxkkznv6vtDTSQ6mO4Jqy2XgmkevGyxC7/V57xA2IRsBwqBzjUd3R1nfaS8CyDLUNbasxMJ3WHcUX/sw838D0gricgAUx4/y7H9NJf1Htm4VUZPuzIoxy/DWNgaCVWAQURkH7Cve4y0B4pKZ+PBY/wGbudqFB8/HLHNMRK9PfW6tgE6JZZI95DH/5dF8k69edrsQZEcwgy4pwKT/zn+tXxNdFwRhpUzP60Zh1VdpDg9DDlq/kMtGHsVXtIiuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZg1pZ7Uo8z4KvwO+Nmga/42pNGTLYtf7zedxNsRZZ8=;
 b=lPW+gVjz0MkLr67oB9S+RpuNjvQ2LfTfSjkLvdZV7l77PwG666i/PZFK8XlgXuP8BGVEcv+PjWCbIJMJQ4l4oVQBZQPTPIMQUuK56Ji9DChCkteidA+auFPBG9yI4UGvrKG9u8vbdgrzWHNHkuxze03Zpa1iFT0R2RJK+iWywnhmp4yJ+dK2iw0VV0avW5MtTZxs84UetiMOAMXF4N8JJtWK6vHTCrWfJi3DZl3tXVXxBV4SlQA5s7ySr85TbF4iJytxFTtC27tNkGx7fD/Wck26iB6lFT2W/aeaZjRZH4CHQUk6iUmiDKn7AXI4BmxfMy6TUdS9zlrYYng0aLyl5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CH4PR19MB8731.namprd19.prod.outlook.com (2603:10b6:610:22b::9)
 by BY5PR19MB3779.namprd19.prod.outlook.com (2603:10b6:a03:220::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 04:32:43 +0000
Received: from CH4PR19MB8731.namprd19.prod.outlook.com
 ([fe80::db43:d59d:5051:33d2]) by CH4PR19MB8731.namprd19.prod.outlook.com
 ([fe80::db43:d59d:5051:33d2%6]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 04:32:43 +0000
From: "Ksr, Prasanth" <Prasanth.Ksr@dell.com>
To: =?utf-7?B?SWxwbyBKK0FPUS1ydmluZW4=?= <ilpo.jarvinen@linux.intel.com>,
        Crag
 Wang <crag0715@gmail.com>
CC: "Limonciello, Mario" <mario.limonciello@amd.com>,
        Hans de Goede
	<hdegoede@redhat.com>,
        "Wang, Crag" <Crag.Wang@dell.com>, "Wang, Crag"
	<Crag.Wang@dell.com>,
        Dell Client Kernel <Dell.Client.Kernel@dell.com>,
        "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCHv4 1/1] platform/x86: dell-sysman: add support for
 alienware products
Thread-Topic: [PATCHv4 1/1] platform/x86: dell-sysman: add support for
 alienware products
Thread-Index: AQHbFnIm6kdk5fVtIU6EfeQ/x4J7p7J7Aa6AgAFHWlA=
Date: Tue, 8 Oct 2024 04:32:43 +0000
Message-ID:
 <CH4PR19MB87311D0754EC6DC5891428FB827E2@CH4PR19MB8731.namprd19.prod.outlook.com>
References: <20241004152826.93992-1-crag_wang@dell.com>
 <69e68ff4-da24-d4b0-498a-3be95b557a5a@linux.intel.com>
In-Reply-To: <69e68ff4-da24-d4b0-498a-3be95b557a5a@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=81586157-89ad-428c-8ec1-813e26307945;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=0;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2024-10-08T04:31:37Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH4PR19MB8731:EE_|BY5PR19MB3779:EE_
x-ms-office365-filtering-correlation-id: ef0b931f-c4d1-4be5-6927-08dce752405d
x-ld-processed: 945c199a-83a2-4e80-9f8c-5a91be5752dd,ExtAddr
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-7?B?RWl2NS82eXJ3TElHcHpHU2YySk9LN2ExZEFrNUEwMEZLVU9xTHNacUhGdUpP?=
 =?utf-7?B?M3RJNVMxS0dNWjZYYmFsVy90TUt1L3VJQjEzTFBZQUNXblZmQXpFYUtYWTBk?=
 =?utf-7?B?SkxXSkdNS2lCNHhuYzJXN3p2NlZTL1hic2VxbFZhTng0cDJIS3MrLVAxRnp2?=
 =?utf-7?B?U2FMRjFBZCstQ3ZUS25GeFJyMmpGelNBQXJsb1J3THFEUWdJOWpncUZTYzRw?=
 =?utf-7?B?bzJjek1pMEFtazN1cENJUkpiSllhTXRiZktJRGhuYTZPYXZHQVR0YkQvcGNT?=
 =?utf-7?B?Z0JOWURaQ2FXWG5yMFRsUWZJb1Z1ZmhLNm93U1U3NU5zemhTV2N2WFlHQzFE?=
 =?utf-7?B?MGFickx5bWlyUGh4aGhCdi9QQ3VyTmh4S1FRTkNJdVl5SGZnYTQ5ajlta0xr?=
 =?utf-7?B?N0lienpJalh2aVRzVDBSYUowZXdnQ2llVFdYSlJvYVo5aTYxVHJMYUVPekg3?=
 =?utf-7?B?V1V3WEN1SDdPUFpZVVZCSnVQalFtcXNraXJWeW0rLVdQVDFueFBGZzQwdVpx?=
 =?utf-7?B?VHhYVWhHT2paMTVsRVBSR3FLdDI0eWlUSFVqOCstYjNjNFdKZlJ3OHZNS3py?=
 =?utf-7?B?Z1FZOFFtOWdGTkNSemM0d3pqWFNHbFdXNHFSUGRiQmcxMkZwS0RUVVZlWkkz?=
 =?utf-7?B?Zlk0YVRLYk1nMVBESDZEcHdzTkRtQzhvSVNHcDNQKy1GV2NHOW9kZ2lUSEdH?=
 =?utf-7?B?TTdDNGhPbG1xNTJ2QWE5ME9Vem93YWxVMkNNN3cyeTVrWHV6N3grLUtxMzlQ?=
 =?utf-7?B?RXdVbDFoM3hNRThHbkhiVFcvQ0crLSstR2ZVZTlFdmVRNDAyVXFkMUhveHlL?=
 =?utf-7?B?d3ZFcExFSmcyVi95NXlpRlRoV2xZOTFtRzB0WE5CN1VOVkhjc3dLYUhvelNC?=
 =?utf-7?B?REkvaHBpWlBNWmQ1d2ZwWjlHN21TV2lUZlVGODFqQ0dselEvTEwzalQvZnQ0?=
 =?utf-7?B?c0ZUNFJza3NOS2lPaTMyRGtnS1FjNk10R0RPRDBZa2d2TWpydUlEVE9TUGtr?=
 =?utf-7?B?V2F2L1d5anlxRmxNVGNTMXVOMFZWRistM2hmTm5aT3RlRnlIcXFQQk5ybndF?=
 =?utf-7?B?VnVpY3o5cXhzRXdUMkl4TnNpYWVGY09OOEhya0wyY2tTbzBNdTMyVzJodlRS?=
 =?utf-7?B?OVpjYngwNW9ielNWSU9rQ0VOd1JWMjh0cGhvSHVMVmhxWHJsbnlLSTZqNUhs?=
 =?utf-7?B?d2dhM1hadE5rN01PRmZtZUl4MWJkMWg2MnBFdzlPdERXSTlwNTVGYTFoL3lX?=
 =?utf-7?B?c25JWGxBdExkeVR0eHVQcEgrLUtHb1Uxc1FEOFhURjg4VHNMNjJCdGh3eTRY?=
 =?utf-7?B?R2JOUUQrLVU5UVlXbko5d0F6LzdVL2FlTEtTNHJRZWM4U3F4aFMyRlJHTTJL?=
 =?utf-7?B?NmFnWXBMbEFaSnJVRkhsT2NSMzExZjVQWERCVVp5Q1JLem9OeGVDWUY1cUFq?=
 =?utf-7?B?NW8rLWVMYmlFTExkWWV3MHFrRURFbVppYUh3U0ZyZFNNRVRoajNidEYzZW9a?=
 =?utf-7?B?T3NjcFN6aW5qa1RTWmg0RTdLRUVzeXh4VXRnV1VpUmdnVVhYbFdpbUhaeXhZ?=
 =?utf-7?B?ajdsYi9hZ0l4VXdIT1BFeS9qcTRoWC9lb0VwWTVuL2ZISjJUUGRPeDJoWjJO?=
 =?utf-7?B?VERRQ1A2bWN4U2VZREpKM0VOSTNSV25ENnJMdTlsekhBNTdoSm1uMGRJZk04?=
 =?utf-7?B?OUNHZGV1cmhZeWtvTHNpN3BFNlM4bnk4RTZpM3c2YzBTQ3JleWZ6ZmhIbEww?=
 =?utf-7?B?d2xOdXdDQWVRK0FEMEFQUS0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH4PR19MB8731.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-7?B?QUM0dkRlSkpqYistRTNEdXppTGJPeVZ2bk1kTEtkeWl2V2dwOUdVbkRyRTcx?=
 =?utf-7?B?NjU3Smd0YjhQRGJlZHBROWVReDhhbEtETHFNSGxDWGdsMFJDakpNS3JUZmMx?=
 =?utf-7?B?czJoNkovejlSUHJteFFIQ1d2V2ZScUt2blg5UDBPV0trSGdHeXU4UTFiZ1Ns?=
 =?utf-7?B?V3ZKbUJlMXZLSjNodnZmUjh1Rnp2TzhWUEZ6dGpRamhoVkdRbElJSG5CcHFE?=
 =?utf-7?B?NVBjNVBlS08zbzhneHFUbTZYbHV5RS9kR3NnaDE0ZVYzNjVwSDVuUmVRVzJx?=
 =?utf-7?B?TkxqTXNOOSstdWQrLWNnSHdpVystNkpFMXc4b2xzTG53eU9jNTJtVjhsSEhp?=
 =?utf-7?B?VW5Nb3BMV1R5OVdCSnFnZ0tDQVltRjlTbVF2dkRJTGVLUmI3bzBzZVNpQ2hh?=
 =?utf-7?B?QjlkYTg5Y1pHNlpMaGJUYmk4c0Nva2NMamxtZ2tCQnF4cXJaMjRSZXR2N3NQ?=
 =?utf-7?B?SUpQTHE5SVdpYS9vam1iaVZQVmlZVzFVWXcrLVRHVUJWUG5od0J6YXc0STJs?=
 =?utf-7?B?b0ZvQjZ4STJlQzJ5WUNLUVVBa3RJdWIxVkh2ek1oNzZQa1NOeVozb2I0N2xD?=
 =?utf-7?B?a3lqWkpORzJYNE9hUGo3STdpb2daVi84M016d0I4bEp1TWU5VmhPSTg3WmlS?=
 =?utf-7?B?MUJpazBDMmZ0cGhyY3lkMW1wR2FBcWZsYkZLOGExOXhwQ0ZZRG00bkV5cnhh?=
 =?utf-7?B?OE5ad0lLbkMyNkFWUnpVRTdhajlXbistZGFJZistWGFHajdmNjhGbCsteE9x?=
 =?utf-7?B?c1lRSHVmOHc5MDFkZ3hWdEoyMlVjMjlJWklVc0RmYWRZaFdINkJYYWtjdnZx?=
 =?utf-7?B?OU91NUs4blptTHdPRVlQa1IrLUNyaE1xb2wwU0VWSC9LWjNZZEI5WHJmM3Js?=
 =?utf-7?B?L0Znc1BPWFJOWHlDUEJiSGw4bmtOWEhLWlQxVWhXZEs5eTk3aGVLd0NZNkFp?=
 =?utf-7?B?NFdhVzdpWGlVMFovdFN4c3B2aHZJL2oyVld5YkJDVjhPaWg0dlMzQUowdzBH?=
 =?utf-7?B?MHJZWW9GN2pVTzBUN1o1WmZ0b1FSaXlJeUErLU5KbFN4aWdSQzFOQkIwNkRB?=
 =?utf-7?B?TWRMYjZqSGltSHFpTEVrdkw4M2xSMG9OSmFqUW5rSjZMNXZvTVBna0hBR29V?=
 =?utf-7?B?WUs5eEJRY0d2UHNLb2VaaVFmNWYrLURUWjVXV1ViNWFscUJScXFKczNKWm00?=
 =?utf-7?B?SllrQkFvaXMvV0dXSnZiMU1LMGhjSjZZbmd3Ky1jMjd2WHMwRkZUL2YrLXhk?=
 =?utf-7?B?VklpbVhoVWdaU0hwN1ZvNEhZNTVNcEppNWRBeGlSZ0tTcEY2Yzhza3U2R2lL?=
 =?utf-7?B?RU5GbXR1cFJlWnU3VjM2TTRjL0ptZ1lKQTJPQXB4czlHbzN0TlRVWlZ0UDVG?=
 =?utf-7?B?NUNjZUJCZFd3R1ZtczFpcG5keDU0UmdwUDdNVVVQWUtEVkNQeGZiSkFpMzda?=
 =?utf-7?B?NnZuQXExQWVSa0xrdlRyd3pya1Npcm5rVmhUSGRaWUFlR2tLdExRM1BOSVRM?=
 =?utf-7?B?Ky1wODk4V0k2aldmMnEzWno4RndBYUgvKy11V3FjTVhTeDV6UkVxQmNDWnE=?=
 =?utf-7?B?Ky1TNExHeVdDRWk3Qk92OGNjRWZFYzlTSkRCZE5YdEVsd3NtRURLKy03NSst?=
 =?utf-7?B?ankxajU2bXJRcGxtWnR6Umx1My9vOWRVRUhiSHdrSk5McmZsWHFISzB6c1FM?=
 =?utf-7?B?ampudC9QL3FHbnhjMTVHbTBHby9Pajh0MXV0dThzVjRuZnlFeEhCb3VENk1v?=
 =?utf-7?B?amVYMjhPMFRJdDc5Uy94TmxFM3RpYXJpZTNoaW1PRVBrWVpNcUk2RTgxYzJv?=
 =?utf-7?B?NmdLd0JuUXVlZHQrLWUyUElubzRvY05hOFErLTJDUEkyYTlpMEg1ZUR2aDBP?=
 =?utf-7?B?M0FiS015TmRxZDN2a3NpbnNqZFp0ZEtwRFp5ODNXMHZKeSstSmZncE0wbGo4?=
 =?utf-7?B?cnBXNmtTb2xpNExucmRvRHMwSDhRMy9MKy1tVkF2WmRTWW9oUDQyWUYwbEsx?=
 =?utf-7?B?THU0VVd6YlNwNU9PRjZoZXB6eUdSKy1KTGh5SkVBcjJmSjVkWVkzcEhlNyst?=
 =?utf-7?B?TVJGVE5aUVRaei9nanBSeTE0THJyZ2wvMGk0anVkbFErLUtrektoeVBRWEFY?=
 =?utf-7?B?VkFFN0l2QkJqSkI4bHRkOHA5dUZDTVNtWHIyVkZwS1Y0Skp1aHQ1SVlDSVFi?=
 =?utf-7?B?TkYyMVNVb1N6Q25yNjZzVystaGtzN25uZVZFQWdVd28vaVNXOVhSaDZHcUdw?=
 =?utf-7?B?N09YWS9FKy1ibmo0T1pWU1ZPMlVFalFyVWJy?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH4PR19MB8731.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0b931f-c4d1-4be5-6927-08dce752405d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 04:32:43.2635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aJotsjk29mM635whjqwEgG57TuQVF7oHvB8MCUwv4mHSIumf20G/Tom56yl5MMKhncvS4KUGUxFVPnMN8m6dcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB3779
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_02,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 malwarescore=0
 spamscore=0 impostorscore=0 clxscore=1011 mlxlogscore=999 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080027
X-Proofpoint-GUID: wRJsmxu36mQrEnIGKK2qcs0chtfdHY3m
X-Proofpoint-ORIG-GUID: wRJsmxu36mQrEnIGKK2qcs0chtfdHY3m
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 adultscore=0 priorityscore=1501 clxscore=1011 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080027


+AFs-EXTERNAL EMAIL+AF0-


Internal Use - Confidential
On Fri, 4 Oct 2024, Crag Wang wrote:

+AD4- Alienware supports firmware-attributes and has its own OEM string.
+AD4-
+AD4- Signed-off-by: Crag Wang +ADw-crag+AF8-wang+AEA-dell.com+AD4-

+AD4- Reviewed-by: Ilpo J+AOQ-rvinen +ADw-ilpo.jarvinen+AEA-linux.intel.com=
+AD4-

Reviewed-by: Ksr, Prasanth +ADw-Prasanth+AF8-Ksr+AEA-Dell.com+AD4-

--
 i.

+AD4- ---
+AD4-  drivers/platform/x86/dell/dell-wmi-sysman/sysman.c +AHw- 1 +-
+AD4-  1 file changed, 1 insertion(+-)
+AD4-
+AD4- diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/dri=
vers/platform/x86/dell/dell-wmi-sysman/sysman.c
+AD4- index 9def7983d7d6..40ddc6eb7562 100644
+AD4- --- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
+AD4- +-+-+- b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
+AD4- +AEAAQA- -521,6 +-521,7 +AEAAQA- static int +AF8AXw-init sysman+AF8-i=
nit(void)
+AD4-       int ret +AD0- 0+ADs-
+AD4-
+AD4-       if (+ACE-dmi+AF8-find+AF8-device(DMI+AF8-DEV+AF8-TYPE+AF8-OEM+A=
F8-STRING, +ACI-Dell System+ACI-, NULL) +ACYAJg-
+AD4- +-         +ACE-dmi+AF8-find+AF8-device(DMI+AF8-DEV+AF8-TYPE+AF8-OEM+=
AF8-STRING, +ACI-Alienware+ACI-, NULL) +ACYAJg-
+AD4-           +ACE-dmi+AF8-find+AF8-device(DMI+AF8-DEV+AF8-TYPE+AF8-OEM+A=
F8-STRING, +ACI-www.dell.com+ACI-, NULL)) +AHs-
+AD4-               pr+AF8-err(+ACI-Unable to run on non-Dell system+AFw-n+=
ACI-)+ADs-
+AD4-               return -ENODEV+ADs-
+AD4-

