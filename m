Return-Path: <linux-kernel+bounces-345089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C0598B1EB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 03:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 089E9B218C9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78459219E4;
	Tue,  1 Oct 2024 01:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="boAnuCAf"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C085D6FBF
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 01:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727747194; cv=fail; b=cswo+bTnMt7oCRA2dBSy+r9s+n1N0W9m3Rsyw73iVV82HGzFsRmVzjNOd8eGrJXDNDX+eDMQyuhJh7RoWefyZzZqzSChCbuJz1if3KXitIFDouXlYpM3jC+Xa3AN2gGBq2aNySCCbl5iG7fzlxm+gKpSHxIB+NYwyAXxjhA9ecI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727747194; c=relaxed/simple;
	bh=sA1a9Y2T026la8U7TAUwAgCKnKwjhrQJt9ZynO5XRoA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UC1m9CRNpAUrdPjtO5fqEJwtez5/KlX7ai9hSSxSv2lZ/VMJkxXWoGTAN+st9+cH9TDlbODWkA1IvNZWl3W7sRJCNixZMjz9QQE8q0FivVdJAKFGGDj8f+dYMII89C5Ha92debNHexqxAMCJb1o2Zw8Tj54ifmYZpbK4bAB/eS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=boAnuCAf; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=npcnn+SBgmnUHEDbl1WWL62CyFqcattFsJluJcjWPGum1ohpay6QpZT6VHXzW7uFEBsCbxw7x96mmQEzaOHKMtN0NI26KDMXElUf66CwMD6G/X3Kr21o9nC2MLcGSkAkpbKuaKSvyFHEW3scLddwL2P4JQ60OC9bU1AwryoJIMqIGkrjE0160CqoJVr/1J6JMkAiFW25cgqYLgf7hNPL7VM/P4nQjNWrogCljrv9u7k4Bz0C8eQA+yjrdhVaIeMtxYx+6X4DiYn0PRo8fCYmaFKPWB9k6zBqEid151rAdLEbTF4jjTiocoJ3iWxQrT1uc4XG2tO25T/FI+CKSaS+LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sA1a9Y2T026la8U7TAUwAgCKnKwjhrQJt9ZynO5XRoA=;
 b=KS92uGDA8chyQEsNMN8eAQay+qorLk68Bh4o9qLys87IlWfl4l9akc0YU4PLew/8XEKOGVdkfUMK03fofdALti1RX/ZB9iMZz7JLAjr2+5DrZopdWOGcG5Ajhsxnmw0o+tv64P+HNBcMBY3ZnEk9jKTAZOv+cvqGBtpGaC3rRYS+jzuNe4ZiwLdPHJx7lfgWNsXJZYUJVRahWKx2mOJXL35Zs25ZGJ0WiGmkXCkAoytQqIO6tauoyTS2guxBC5prw3O/sT9LDaQvC7GoUqsuB9LKGOnvlTmNh8JMLI1g26tcbCVo7ljE0+nR+phFtxwOctvVqhq6YsvJS6zSxFlUzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sA1a9Y2T026la8U7TAUwAgCKnKwjhrQJt9ZynO5XRoA=;
 b=boAnuCAfsg9NAVLYk8H5MiR7kG/mJ3stR0riHLAjsi5VEcGEXGjsyciz0RjZYRl0HR4Q03xqdFXViKp5RjwycZhxYHRcUouYIt+xXWTlUYNZ5ARHxSkDjt4h+G1rGGGKdzeIw08QtAxJN9pqKDsxnGfDiExIQisl8dSWL9PKJzE=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by SJ2PR12MB8846.namprd12.prod.outlook.com (2603:10b6:a03:549::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 01:46:28 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%4]) with mapi id 15.20.8005.024; Tue, 1 Oct 2024
 01:46:28 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: "Manwaring, Derek" <derekmn@amazon.com>
CC: "bp@alien8.de" <bp@alien8.de>, "dave.hansen@intel.com"
	<dave.hansen@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>
Subject: RE: [RFC PATCH 27/34] x86/bugs: Add attack vector controls for
 spectre_v1
Thread-Topic: [RFC PATCH 27/34] x86/bugs: Add attack vector controls for
 spectre_v1
Thread-Index: AQHbBUtAYS9nEfikDEWFe8hVs68IMrJUjQ3AgAAJsgCAAA3esIAchauAgAARLvA=
Date: Tue, 1 Oct 2024 01:46:27 +0000
Message-ID:
 <LV3PR12MB926589C779479C836DA4E51D94772@LV3PR12MB9265.namprd12.prod.outlook.com>
References:
 <LV3PR12MB926575E4BB94AE51EA662A3694642@LV3PR12MB9265.namprd12.prod.outlook.com>
 <9de4f491-eb64-4a1e-a375-7bc2d382fe5e@amazon.com>
In-Reply-To: <9de4f491-eb64-4a1e-a375-7bc2d382fe5e@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f713012a-2e6b-47e8-98d9-02d64bcf58d2;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-01T01:41:24Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|SJ2PR12MB8846:EE_
x-ms-office365-filtering-correlation-id: bed5f2a0-2a65-48b3-bd29-08dce1baddba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WWk4SWljT05BOWY4c25rSTlqZGNMdEQ3aTBiUm5xeERJeWQ3OUNPWFk5RUI2?=
 =?utf-8?B?azB2MnI2d2thc1BoSnUrRHJZeTJ3U3BwZzM1bk5LemFFcDhIMk5ZV3RrNVNi?=
 =?utf-8?B?enBoSGVlQW9NeTErZHBGWVR6WFBxd09HYkNTZUlVN0owQStnWHhlRlVqMkZ3?=
 =?utf-8?B?NHFYZ1RkaFlNSUJ4T1IvN0dLUXRGT3FtWHZpZ0pRYTkvQndQSkw4VlNGMG9k?=
 =?utf-8?B?SENtZW1ZbVNkcUIwYkwwZlRLUkM3NnJPTTcxODdOMjRncnhEYzgwVGxYVFlL?=
 =?utf-8?B?ZnIrYkcyamZrYjl1QXZLV2xIUUx5OVI1djdaUlp3TEM3WDkzWHhXR2hhb3Z0?=
 =?utf-8?B?VzRTNUptdTFid0M4WDV1Y0x2RDB0eEVLNXFVNm5ZMnpMT3lvNTFqTm5QYUNF?=
 =?utf-8?B?M2puMDFLUEtYc2kwWE5nUDhXczRVWmcwa2s1V2QwK3lQVjBYdHZKS3hRV1kz?=
 =?utf-8?B?N2h6SXZoQURQajcrdnVEWGJDZ3B3VEhwSElTcVpYUmRBRVl4Rk9qNGtxZzBw?=
 =?utf-8?B?ZjlvNnIyTEl3VUVvcnRnLzZNUS9Uck5PYkJLeTNuR2dKUm42UmlOaCtmSk9Q?=
 =?utf-8?B?cjhRb2YwNHU5eUI1M045TW9FTk0rRFFuUU1SZjVhNjdSTzZOZDJtVG5pK2c3?=
 =?utf-8?B?V1RrN2p2R1B2NlF3cTd4UGQxVkQ5REJzYkE2KzVqancyOXJzU0ZENWlvK0xC?=
 =?utf-8?B?TU83eFJiR1hHWGJHd1BMZVBmaXpoZHhUYkxORi9tbmpvVDcyang3V0FMWXA2?=
 =?utf-8?B?cHFzL3RKeitIaXdoUFI5SUtKNUFUdEdNUFoydktDSzREMCtRbWFyTU05by9E?=
 =?utf-8?B?bkpEUUduOHdDUFZOUTdOK3hpNjZyWDYvNHJieHpxbkNUNU0xWVhPMU9pcjBQ?=
 =?utf-8?B?Ykp5bjVuK051ZEpWdE1kUG5jeDQ3TjdDQUZNcjJyR2Y1R2hPVEM1N0VSYmZS?=
 =?utf-8?B?eW9lWG1oQisvOVlMc3FYVXVlSWF5bE5xR1Vhb3ZiczJkMm9PWWd2M2k2MEZW?=
 =?utf-8?B?czNQRGcrMkpNUzEwczBBMjlmd3pvZnM0emcyQUhTN1h1UU1OeDFEWnQwSUJl?=
 =?utf-8?B?U2tZMDE0dEg4Uk42cEN1bStWVVRsVWVjamFQaHlTc213a1UzUUY4YVRUL1B1?=
 =?utf-8?B?VnRLV3lEY0lOdVVvUkhRbkdWc2ttWisxZ1hHUzNIQUpuNXE3SFI2d1Z0eW9l?=
 =?utf-8?B?ZkI1UkNYU0g2dTJsdFhhdVJ4T1grOUFqb1VaTEd4M3pDcHlRZUFkVUR2RWNN?=
 =?utf-8?B?U1UweitOUFVBNjZyY2FGeUo1MlJlWGc0WUhYVldydkwwWDhES2ZDL1RvdWF4?=
 =?utf-8?B?LzRqY3JEajdRVU4rOUJPTkFmcHliQnJ4SzNkL1ZCaVByNU5SN2NHelZTSUFW?=
 =?utf-8?B?enBUNGtwTzhJTnhGZ2NsUWVhSjFjVjlUZjgrVGR3ZVlYWEU4UGxGZytrWkVG?=
 =?utf-8?B?enhUMENyaVowYVRtN25wTUErMVRIRDhQQ2ZuR044M3lzUG50SGt4dnRObXR2?=
 =?utf-8?B?a1VraGhNZ25pVWhnTlU4d1oxeFFnNmhmYW91YUFHbEtiUjRGNVN2T0hKdUsw?=
 =?utf-8?B?eE5UZ2JWWlQ1UCtDSmhyOGRYZFlYZWVjM2ozK2RkaTdiSC9EMk94ZXVLNVdW?=
 =?utf-8?B?NDBFaW5RY283ZnFSaGpCL2lhb2M3R3YxZCtXemswUkd0Y2xXQXlkV3EwaEVn?=
 =?utf-8?B?UElIenJja2trOFpsVzBZa3VSY1BVYUNYUDVGNTBvYmRVaytVMzIxK1IwQVVr?=
 =?utf-8?B?aHE4SFlraVpueG5YdDZZSG00UCtGM0xYVkJtbDFEVWNOK09PMmVPa3pDSzQy?=
 =?utf-8?B?Qi9IUFRmZERBejRoOWJZdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MnkxVHBhMXJrZTU0eEpRUlhGUWRiWmdVKzJIeVI5NVVraGQzNlptZ2NIMGpq?=
 =?utf-8?B?ckJ0SHErNWpsekhpWTFQbjdiSWFJTHZCVGpuS0FmWkJiek52OXpBbGN1K0RH?=
 =?utf-8?B?SlgwcWJBcEdRc3gzN2lPaDR5cFJuZHl6V0RaNjJKNm9idUNHTWdpWVJFT0Qw?=
 =?utf-8?B?dDlzVkpMYlZMUFpRaGtvcFN3SFZEcWVrazhjQS9NUE0zRnVueTdSekZ4a0Z3?=
 =?utf-8?B?WGlVMHZ6bW1IZzFkb25LbDFGbysrK1NMaWoxZnUrdkVZWUppcGdpMnlKVU5q?=
 =?utf-8?B?SlEvRzlieERJTmQ2OUtiTjRIOUtVM3RvS05pYmZjU0JvcVp4ZGNjQmMzQTBt?=
 =?utf-8?B?ZlNPQXlwVlhXTVFxYllkNWo3YXhsVVdNeFZsaDZ5WDVEVW5KcGdvcUNHOGVN?=
 =?utf-8?B?TW0yYW05WXRDV1hvcGZsTXU4UmRid0JsSld6OGV2RFhyQXlxa3g1SEV6WlJs?=
 =?utf-8?B?M0EvMlF2Ly9CaUtOVDZQZXhDYVhra3F6cWNKNER0ZG04TVdhRWc3eFBWVExG?=
 =?utf-8?B?VGdmRXF6N1JRNVhrd3dlRUVxNVUyWldYclNJb1NWcEZOS24rR1A0aS9DQ0ZO?=
 =?utf-8?B?RE51NHJQSld5VFh3cU1NVEhTSE9hSitKR0ZBQWJTNHcvdFQ5U2pwak55bERI?=
 =?utf-8?B?Z0xjTG9NKzM1eEhUUnJ5VXhJeW1Wa1plenRlNE9OZlppMjNDMTFHTlFWN1Bx?=
 =?utf-8?B?NXJlL0VVNFNoTG96VVUzNkJSZTVTUHZCTWJTVWVvaUhxZVovc3RLNDJDSFhH?=
 =?utf-8?B?M1RjNGRnenRWQ21reVJ5cGd6c2s4NkprZWxtK291Z2FqZ1doZU4yWTlGYmF4?=
 =?utf-8?B?ZXpVMGYwenVIdHJxbktDUzNQMWFhdkljbmt2d2hacFV3ZG44WGsvVU1wdUsw?=
 =?utf-8?B?MUQ2WEZiK3l2K2ZPZjFFeUFHVmljdlg5elNPcDRFaEJCeHErNFlrRkJhMTNr?=
 =?utf-8?B?cnRkeHZLMm5XTm1ZR1M1TFpjM0IrTnI5T2F0RmR6dlhoWWdlZHJjejQ0eGll?=
 =?utf-8?B?ZHY0ZzhndjlsbVVma3h6OFV3WUplbmVzamlyTkRjQjNJOU9IMFlxdkVZV2FR?=
 =?utf-8?B?ZmwySXZHU0pEbGhicFVJd2prTExnQnVjZ1lNQytlOXVtb015SzN1S2xkTkhy?=
 =?utf-8?B?d0hYbUozVDAwUHJGdzFVcm4rUTBhVlVrTTIrbm55MG9xa2lPL3E1ZTI4VTBk?=
 =?utf-8?B?Y3ZhNlZna0E4U0VxWExOZ0NxeFV2U0hHa2lrQTM3TWNGWnpBYSt1b1hxdTVM?=
 =?utf-8?B?WUdSMFJEVUNOMDZIVStjanVaVGVON05zSEZwTTdQMUR5NXFBcjQrTGZqbEFp?=
 =?utf-8?B?WG0yeTIrSnpPdyt6K1FqWkVJMDgrVi9sU2I2ckxDaWMraDFvZkNXdWQyenBa?=
 =?utf-8?B?eTZBZ3RtWjdUQ0MydFA4TXd2aEQ1cXh4a2d3Zk1qNWpBalFNS0xVWWZ3TG5Z?=
 =?utf-8?B?TUg1WkFaLzRzNzZtUkdvYkV0T3NUK2hOVU9ZY004RHNzUGVFaDRIVkpJRDA1?=
 =?utf-8?B?bUJlRnduK2VTWlcveTNFWFMyWnZ4YitScllSc1F1S3pLMzZuNlduaUhRd2VM?=
 =?utf-8?B?MUhDQmFOeDd6S2tINjc4VG1XL0ZWRlV1bVJZUDhrcS9ZaUJwaGJ6cFBLdW5F?=
 =?utf-8?B?OE4yUjFldzFvc2QvNFlLTzNubjVuZGwydnNZNVZKUm14ZEUyWGJ5R0VUc0wz?=
 =?utf-8?B?emRVQ08rSmVrMU0wSkZ4bndHUmVRQWRRcnIzSHV3SXk3RC9GaXNPQ1NzbmhL?=
 =?utf-8?B?RHBkSFNTZTF6VUlUMEZkZlVpTlovZnZlMytUMzNJcEdscWVyY2RUN29Kc3JO?=
 =?utf-8?B?aWM5RGRRZHFCd0J0ak9JVUlSUmFON2hzakJRa05tUXhBODAyTkVRRHY3UENw?=
 =?utf-8?B?UVEvTytFbm41amZTWjlhalNmMThId2ZNVmE2SU1Uanl5TTdtRHoya0l1MGhX?=
 =?utf-8?B?SlI0dERvUVRqT0NpM0JrWDIxM09kcWtpRi96VWMrelhXWTJyY1ZIdU9GRmVX?=
 =?utf-8?B?dzJHQ2ZyNHB4Q3ZsSUF0TzBzc29kNkpTMFFncnRCUXFJd1dxb0hWOVFVUnBD?=
 =?utf-8?B?NHI4UXNDSHMyNEwxd20za0c5RVJvY0NoUFYrV29ZeFEvWnA2ZHBJT3BGemlP?=
 =?utf-8?Q?2Dr4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bed5f2a0-2a65-48b3-bd29-08dce1baddba
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 01:46:27.9789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eKNY2FOu73S+JvfdUd8B+0RYDkBm4SXUQN8a8igbqR0gpACXH50B55VXxJUX1ym+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8846

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW53YXJpbmcsIERlcmVr
IDxkZXJla21uQGFtYXpvbi5jb20+DQo+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDMwLCAyMDI0
IDc6NDAgUE0NCj4gVG86IEthcGxhbiwgRGF2aWQgPERhdmlkLkthcGxhbkBhbWQuY29tPg0KPiBD
YzogYnBAYWxpZW44LmRlOyBkYXZlLmhhbnNlbkBpbnRlbC5jb207IGRhdmUuaGFuc2VuQGxpbnV4
LmludGVsLmNvbTsNCj4gaHBhQHp5dG9yLmNvbTsganBvaW1ib2VAa2VybmVsLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbWluZ29AcmVkaGF0LmNvbTsgcGF3YW4ua3VtYXIu
Z3VwdGFAbGludXguaW50ZWwuY29tOw0KPiBwZXRlcnpAaW5mcmFkZWFkLm9yZzsgdGdseEBsaW51
dHJvbml4LmRlOyB4ODZAa2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSRTogW1JGQyBQQVRDSCAyNy8z
NF0geDg2L2J1Z3M6IEFkZCBhdHRhY2sgdmVjdG9yIGNvbnRyb2xzIGZvcg0KPiBzcGVjdHJlX3Yx
DQo+DQo+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwg
U291cmNlLiBVc2UgcHJvcGVyDQo+IGNhdXRpb24gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBj
bGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4NCj4NCj4gT24gMjAyNC0wOS0xMiAyMTox
NSswMDAwIERhdmlkIEthcGxhbiB3cm90ZToNCj4gPiBPbiAyMDI0LTA5LTEyIDEzOjE2LTA3MDAg
RGF2ZSBIYW5zZW4gd3JvdGU6DQo+ID4gPiBPbiA5LzEyLzI0IDEyOjU3LCBLYXBsYW4sIERhdmlk
IHdyb3RlOg0KPiA+ID4gPiBBbmQgdG8gYmUgY2xlYXIsIEkgd2FzIHRyeWluZyB0byBjb250aW51
ZSB0byBzdXBwb3J0IGJvdGguICBCdXQNCj4gPiA+ID4gdGhlIGF0dGFjay12ZWN0b3Igc3R5bGUg
aXMgYWxzbyBtb3JlIGZ1dHVyZS1wcm9vZiBiZWNhdXNlIHdoZW4gbmV3DQo+ID4gPiA+IGlzc3Vl
cyBhcmlzZSwgdGhleSB3b3VsZCBnZXQgYWRkZWQgdG8gdGhlIGFwcHJvcHJpYXRlIHZlY3RvcnMg
YW5kDQo+ID4gPiA+IHVzZXJzIHdvdWxkbid0IGhhdmUgdG8gZG8gYW55dGhpbmcgaWRlYWxseS4N
Cj4gPiA+DQo+ID4gPiBUaGF0J3MgYSBnb29kIHBvaW50LiAgRG8geW91IGhhdmUgYW55IGlua2xp
bmcgYWJvdXQgaG93IHN0YXRpYyBmb2xrcycNCj4gPiA+IHZlY3RvciBzZWxlY3Rpb24gd291bGQg
aGF2ZSBiZWVuIG92ZXIgdGltZT8NCj4gPiA+DQo+ID4gPiBGb3IgaW5zdGFuY2UsIGlmIHNvbWVv
bmUgY2FyZWQgYWJvdXQgQ1BVX01JVElHQVRFX0dVRVNUX0hPU1QgYXQgdGhlDQo+ID4gPiBvcmln
aW5hbCBzcGVjdHJlX3YyIHRpbWUsIGRpZCB0aGF0IGNhcnJ5IGZvcndhcmQgdG8gTDFURiBhbmQg
YWxsIHRoZQ0KPiA+ID4gd2F5IGludG8gMjAyND8NCj4gPiA+DQo+ID4gPiBPciB3b3VsZCB0aGV5
IGhhdmUgaGFkIHRvIHNoaWZ0IHRoZWlyIHZlY3RvciBzZWxlY3Rpb24gb3ZlciB0aW1lPw0KPiA+
DQo+ID4gSW4gbXkgdmlldywgdGhlIGF0dGFjayB2ZWN0b3Igc2VsZWN0aW9uIGlzIGEgZnVuY3Rp
b24gb2YgaG93IHRoZQ0KPiA+IHN5c3RlbSBpcyBiZWluZyB1c2VkLiAgQSBzeXN0ZW0gdGhhdCBy
dW5zIHVudHJ1c3RlZCBndWVzdHMgYW5kIGNhcmVkDQo+ID4gYWJvdXQNCj4gPiBzcGVjdHJlX3Yy
IEkgd291bGQgdGhpbmsgYWxzbyBjYXJlcyBhYm91dCBMMVRGLCBSZXRibGVlZCwgZXRjLiBUaGV5
J3JlDQo+ID4gYWxsIGF0dGFja3MgdGhhdCBjYW4gbGVhayB0aGUgc2FtZSBraW5kIG9mIGRhdGEs
IGFsdGhvdWdoIHRoZQ0KPiA+IG1lY2hhbmlzbXMgb2YgZXhwbG9pdCBhcmUgZGlmZmVyZW50LiAg
SW4gd2hhdCBJJ3ZlIHBlcnNvbmFsbHkgc2VlbiwgaWYNCj4gPiB5b3UgY2FyZSBhYm91dCBvbmUg
YXR0YWNrIGFsb25nIGEgY2VydGFpbiBhdHRhY2sgdmVjdG9yLCB5b3UgdGVuZCB0bw0KPiA+IGNh
cmUgYWJvdXQgYWxsIG9mIHRoZW0uDQo+DQo+IFRoaXMgbWFrZXMgc2Vuc2UsIGJ1dCBJJ20gbm90
IHN1cmUgaXQgaXMgYSBtZWFuaW5nZnVsIHNpbXBsaWZpY2F0aW9uIGZvciB1c2Vycy4gSQ0KPiB0
aGluayBpdCdkIGJlIGhlbHBmdWwgaWYgd2UgaGFkIGEgZmV3IHNhbXBsZXMgb2YgaG93IHVzZXJz
IG5vcm1hbGx5IGNvbmZpZ3VyZQ0KPiB0aGVpciBzeXN0ZW1zLiBNeSBodW5jaCB3b3VsZCBiZSB0
aGVyZSBhcmUgdGhyZWUgbWFpbg0KPiBjYW1wczoNCj4gICAxKSBkZWZhdWx0IGZvciBldmVyeXRo
aW5nDQo+ICAgMikgbWl0aWdhdGlvbnM9b2ZmDQo+ICAgMykgc3BlY2lmeSBhdCBsZWFzdCBvbmUg
bWl0aWdhdGlvbiBpbmRpdmlkdWFsbHkuDQo+DQo+IEkgdGhpbmsgeW91J3JlIHNheWluZyBncm91
cCAoMykgaXMgaGVscGVkIG1vc3QgYmVjYXVzZSBub3cgdGhleSBkb24ndCBoYXZlIHRvDQo+IHVu
ZGVyc3RhbmQgZWFjaCBpbmRpdmlkdWFsIG1pdGlnYXRpb24uIEJ1dCAoMykgaXMgcGVyaGFwcyBh
bHJlYWR5IGEgdmVyeSBzbWFsbA0KPiBncm91cCBvZiB1c2Vycz8gTWF5YmUgaXQgd291bGQgaGVs
cCAoMSkgYXMgd2VsbCBiZWNhdXNlIHRoZXkgd291bGQgZ2V0DQo+IHBlcmZvcm1hbmNlIGdhaW5z
LCBidXQgSSdtIHNrZXB0aWNhbCBvZiBob3cgbWFueSB3b3VsZCBmZWVsIHNhZmUgc3dpdGNoaW5n
DQo+IGZyb20gZGVmYXVsdHMgdG8gYSB2ZWN0b3Igc3BlY2lmaWNhdGlvbi4gSWYgdGhleSBkbyBm
ZWVsIGNvbWZvcnRhYmxlIGRvaW5nIHRoYXQsDQo+IHRoZXkncmUgcHJvYmFibHkgY2xvc2VyIHRv
ICgzKS4gSXMgdGhhdCBmYWlyPw0KPg0KDQpJIHRoaW5rIHRoZXNlIGF0dGFjayB2ZWN0b3IgY29u
dHJvbHMgbWFrZSBpdCBlYXNpZXIgdG8gY29uZmlndXJlIHNheSBhIHN5c3RlbSB3aGVyZSB1c2Vy
c3BhY2UgaXMgdHJ1c3RlZCBieSBWTXMgYXJlIG5vdCAoc3VjaCBhcyB3aXRoIGEgY2xvdWQgbm9k
ZSkuICBPciBhIHNoYXJlZCBzeXN0ZW0gd2hlcmUgdXNlcnNwYWNlIGlzIHVudHJ1c3RlZCBidXQg
b25seSB0cnVzdGVkIHVzZXJzIGFyZSBhbGxvd2VkIHRvIHJ1biBWTXMsIHNvIHRoZSBWTXMgYXJl
IHRydXN0ZWQuICBJIHNlZSB0aG9zZSBhcyBwb3RlbnRpYWxseSBiZWluZyBtb3JlIGxpa2VseSB2
cyBzcGVjaWZ5aW5nIG1pdGlnYXRpb25zIGluZGl2aWR1YWxseSAod2hpY2ggSSBzdXNwZWN0IHZl
cnkgZmV3IHBlb3BsZSBkbykuDQoNCklmIGl0IHdhcyBoZWxwZnVsLCBJIGNvdWxkIHBlcmhhcHMg
aW5jbHVkZSB0aGVzZSBhcyBleGFtcGxlcyBpbiB0aGUgZG9jdW1lbnRhdGlvbiBmaWxlLg0KDQot
LURhdmlkIEthcGxhbg0K

