Return-Path: <linux-kernel+bounces-552014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0045A57409
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768653B09B6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374EE20B209;
	Fri,  7 Mar 2025 21:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="pf7wNnOJ"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E1A1E1DFA;
	Fri,  7 Mar 2025 21:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741384376; cv=fail; b=Yex5moW9a+ur33LADS7ZL0IC9+4pZHNZzyyY6mRa8CjOZiQgys4lAj1ln6yQ0PeZ8zYf1WrYomPfzYW5BmckzagxxNBdEtcaNqdzSwVFzPJys58zQKkJAftg99NpTTpoXapnm08NjBqZ7YNuTjONPzshOUyKVHymqKnQWoAMowY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741384376; c=relaxed/simple;
	bh=+OxkoNkrojzktzDMaC9zwg24ylwTj8YoJySOCpf43LU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LsKDffSg/XkCyX+8VAKv+orfM/cO0etmQxD//LYWtyyfsgkzeYmVJSgvdQ+DEPcVhDRxYD+tYFRonjGj1D+b/rz5ls5Je3o338p4tsiB59E/6q2Ts1lrO86AjDGVotceE+LM14x3Kl8XT4LX/C4yQX5HvSN7KKLffo7BhsDo8gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=pf7wNnOJ; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527EXZSP008262;
	Fri, 7 Mar 2025 13:52:36 -0800
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4582ns8swj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 13:52:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fKZpoRRobc019f2qK/Db3hFrazBIG1FFGx2v+Y2Y6g1aGtsylC6tf3mOIYHTFPvP5Z95WUtUn5eF1L2+tl939oO0SCIcRdi1lvdRH+tlc8PKaq0EEVc2yUy6Ocj4L0dz4H3NdedU2JBriz8AS0e4xHuu9me/LSRu5owhv1jNLmxpwSomEYNfzYf4uwCMjR7YHxV0L6b/3iM/LsbxqnC/y6JWH2L8BnUXQEsn4JOO2ODfvQM/YRnkBXRkoZ+WfDNmxi7G9GcxGOM7Yd1ugfHEoousdWjTCse5XW2ty6ZEI7Yt8l19tkf5DhD99t5VvUEr3dJdHrjOfVIoZzYbJ0GXaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OxkoNkrojzktzDMaC9zwg24ylwTj8YoJySOCpf43LU=;
 b=nBbspEvIWbDZhdyEnsOqI5eqsuEx578ftoohxbeH5jVgIxwD1dtq7CI637aPu4CAKPXjkFCj7m95MYSTz2murVoZSGFcuuMBkCtYE0iK84qVRORi9b6uALjiVAgdUT5AtzHZAA6IrSbhMIlliAvjNb+IZVa32BmzBzsReHQbOWfdikp3XBOiltyHRSz4KLS7ulYfBqjVopeqXobQC/v6pNUD5tbGwrnjgrtGoG5FdK0nsynSqunxwGSgr2P92H5lugD87vCroP+vH02DBJXQyHqj6d7Q5KqPr30QlwsEm5WmoCOqywtA/JZadzbHMbE6HMV7ilp58hRYaLvRGt46ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OxkoNkrojzktzDMaC9zwg24ylwTj8YoJySOCpf43LU=;
 b=pf7wNnOJNdBPCEIDiRdxwUw4uKnZsEbefOOOdFeG1qpdLnJzJjoPFPOWpO7Kgf442cwaPlu7tkNucOSfJTBZnf+gbqss6PENDpJe1wQIB40dCDa+9KVRlK1ThahzXu+HZ7iE4+EjBQEa5dYn35euNRykU2XYC8ovXDFzv4JXyZI=
Received: from BY3PR18MB4673.namprd18.prod.outlook.com (2603:10b6:a03:3c4::20)
 by DM4PR18MB4254.namprd18.prod.outlook.com (2603:10b6:5:395::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 21:52:33 +0000
Received: from BY3PR18MB4673.namprd18.prod.outlook.com
 ([fe80::fbd6:a3a:9635:98b5]) by BY3PR18MB4673.namprd18.prod.outlook.com
 ([fe80::fbd6:a3a:9635:98b5%5]) with mapi id 15.20.8489.025; Fri, 7 Mar 2025
 21:52:33 +0000
From: Wilson Ding <dingwei@marvell.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "robh@kernel.org" <robh@kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com"
	<gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com"
	<sebastian.hesselbarth@gmail.com>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>,
        Sanghoon Lee <salee@marvell.com>,
        Geethasowjanya
 Akula <gakula@marvell.com>
Subject: Re: [PATCH v3 3/3] arm64: dts: marvell: cp11x: Add reset controller
 node
Thread-Topic: [PATCH v3 3/3] arm64: dts: marvell: cp11x: Add reset controller
 node
Thread-Index: AQHbj6s6dLuQqPFswEOi3rx+3g9DwA==
Date: Fri, 7 Mar 2025 21:52:32 +0000
Message-ID:
 <BY3PR18MB4673E368B0A8D83755ACBDBCA7D52@BY3PR18MB4673.namprd18.prod.outlook.com>
References: <20250227192536.2426490-1-dingwei@marvell.com>
 <20250227192536.2426490-4-dingwei@marvell.com>
 <d085c34a-fdbf-4950-a2e3-b3d25a1c0145@kernel.org>
 <BY3PR18MB46730C150D4CB9619B3B05FBA7CC2@BY3PR18MB4673.namprd18.prod.outlook.com>
 <050ae833-10b5-4d80-9856-8bc2f434a74f@kernel.org>
 <BY3PR18MB46739700B533630D65C60808A7C82@BY3PR18MB4673.namprd18.prod.outlook.com>
 <87b9e9c3-87db-4ebe-96b0-4f04705ef6f8@kernel.org>
 <BY3PR18MB4673B4CEB60D3D21AB17B01DA7C82@BY3PR18MB4673.namprd18.prod.outlook.com>
 <03b14353-5d47-48de-99fd-9cc48bad5651@kernel.org>
 <BY3PR18MB4673BD07048F8AF7EA55282CA7CA2@BY3PR18MB4673.namprd18.prod.outlook.com>
 <2f39acd2-e378-47cf-b852-bee1a38108c5@kernel.org>
In-Reply-To: <2f39acd2-e378-47cf-b852-bee1a38108c5@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4673:EE_|DM4PR18MB4254:EE_
x-ms-office365-filtering-correlation-id: a59d1e24-befe-4da5-72a5-08dd5dc25d86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZHcrNEhEdVkyS3lWbExIMkpaUTdralFWMjROMmxPNDdCbklDOWlINmtYM3o4?=
 =?utf-8?B?ZFM0VkhvbElzY3Q2bkdISHpSckVkclJVUkZvQnJ5a0QrLzFveDJCTmtHSHZK?=
 =?utf-8?B?QkU3dHROZzdXci9ldzZKQzFaUnVwWFdVSWpoby9xdlExeDVEMkIxdzV6aTFk?=
 =?utf-8?B?Z09FUVpnVis0V0JoZEFES0xETWl4N0xtdzU3bFBQb09TUFk2eEFtUHBCTWVL?=
 =?utf-8?B?dWZTQkx3TVA2MTA5S0E3NHhVUXU3VmtGdnVYUEllQ0hiQjliNHhxV2QvVTBx?=
 =?utf-8?B?NWJSSllnOGhCcXlSMUNTNGRDYUh5NGlCZkVqd3hDWkRMd3R5QkdXQjEwTVZp?=
 =?utf-8?B?UlV0VEcxL3E2OFZHYVJwSE9yeElpYUduSHFVdE9aTkFVTDBjMEF0eUZ6SGo0?=
 =?utf-8?B?SjRQTUlaSVoycHVnN3RRdmUyby8rdE40YjNvSjRNVjVVcmp2cDZ4bXlvdUhT?=
 =?utf-8?B?ZU1oSy9tMEN1cGU5ZEloU2o2TFBoTUNTNGVlbi93aFdySnFXMTJLS1ZEc2Fv?=
 =?utf-8?B?ekhlbk9XUzBHZEJoOERPY0ZtVCtxUW1qQzlGWlNXMkVaNUd2T2krdC80dG5E?=
 =?utf-8?B?VjM4MVloOG5YTmxSNkZnM25FdFMzREMxTHhBWEhLYTJ0MWx1dk5yYzZTUTFs?=
 =?utf-8?B?cVlXd09XTVNZN0RicE9uODN1aEdyaXhwMEdsRHNGZ2hZbTVYU0xIZWpGTVl1?=
 =?utf-8?B?MWNwZC9qUTZGRkdjNXo4SFRHc1dsODNYUitnMWc5OGZJaVBRREtRL094NXd2?=
 =?utf-8?B?b1REVW15NldQNkFteWhFTkJUN0xXRTZicVVLSnZ3OHcrRzI5OG5zajkvbDZY?=
 =?utf-8?B?VCt3L2hMUzF0WEtKRjhJb0JEQ0JnUjlPRzVmelBlTmhTcVp2RFY4VFVlV1J5?=
 =?utf-8?B?LzUyakRRMnlWU1Y3MWFGamtrUEZyeXlHb1RpWUloekw5VVBXSENacDZyMXdz?=
 =?utf-8?B?dXA1ZWxXVmFyUU05TEsvWFBITVNkRTg1SVFucWpPOFFqdHhkSnBZdy81ZHRI?=
 =?utf-8?B?aEhCNjY3S2ozTHVMYXByOFBzNFBsNjFTNEc0eFRaOGFhbjFLQWtSZ3VhM2h1?=
 =?utf-8?B?MldTK0l2Qkd0SWk5b29XdjRmTnd5ODdCVWttVFk0YkJOV05FWWlCU1VwWThE?=
 =?utf-8?B?VEF2WGJmOFlBTHBrZ05ZL1k0bytTVldOUTlQTWRCRDhqUUV0NXlWczZpL2F1?=
 =?utf-8?B?S2c2WEt1S3ZxQXhWSHJiTDdsVVVIeHMzYmlYYjBmZ1F5WW9ObWVicjh1c01D?=
 =?utf-8?B?OFNsN1BZbmJNb21rSTlnVzAwck9vd0czU0U2dWhTSGJnQWs0bkJRTUVRMkNn?=
 =?utf-8?B?QUtBSVE1MzVBbUFZVlFtdW5nOWNVbm1udmhXUzhTLzdvM0l3cXd6UmdRZmY2?=
 =?utf-8?B?YzFoVXNzNXBKTXcwMUQydnlMUHIzeklvblFVN05naXpTYTFOMzM0MzdnS1g4?=
 =?utf-8?B?L0RMdlNWTC85cU9tcVRNdmFxbk1NeW1YZnQ1NjE5enhTSG1lZjR6K1VONmU2?=
 =?utf-8?B?eG1YS0pGM3dPNUdPcmpmdGlwNzVpcFhMRDl0VTc0ZTdlSDQzQThrRGhkM0t1?=
 =?utf-8?B?VkFHY1FqNDdxTHAzcVl4V1RvOXB0UE1iVkNrY1NacFJoZVVtYklwZng4Rnht?=
 =?utf-8?B?RGNrZzdUZUgxcXhoL0Y0Qk4zOGVuc0hXdXU5N3BWdVpWQ2pEOHpFTDJJRGNi?=
 =?utf-8?B?c2k4bWhpcTltVXNUNVlCN2V2ckR5WXZEU2JBRWVDSlc3S0J0TmxRTEFtcWc5?=
 =?utf-8?B?RXdJcjNBWTBmUmJBOThaVFJWUmpHRVBNRjZKNSs1dWRmWUx2MlBXTlRoS0JF?=
 =?utf-8?B?OERBQjVtRVZkQVNnZGtHOVVHZUMzVTMrOHYyanNIbU5YUXJJdUpvWjRJK0VJ?=
 =?utf-8?Q?dWCxKEIOmYS8g?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4673.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MitZd1NiWmhFTXRqN3RLQy9UN1ByTGt1RHpsZFVGb1E0bW94MVZOV1hCT3pW?=
 =?utf-8?B?Tm5oY0c1M3piOElpRC91aTRVZnFXb2lWbkh1cERXR2p6R0FmWnYxbnF6WVl1?=
 =?utf-8?B?THJLaFNKNzZ6TCtTSlRCTlRiU2tNRjFzOFV6YjhXazlMemdvT1hLcHZhQ29J?=
 =?utf-8?B?VFJybTNxL2hYbWVYc1ZFNkI2SkJGOUlhNGpjVWN4N1ZVcTB2bFNpc3lnMDc0?=
 =?utf-8?B?RDJJT21NMjExRVM4RTdUQUY4eW5Yd1ltUTdIVDNzaWpENmpPeXVOYlQ1VFRX?=
 =?utf-8?B?YWh6ZDgyZFdZb21VN2RlWGtkNUx3U1Y5TGFTMGRUV2VmTDRWd01JdVZLTTkw?=
 =?utf-8?B?QkFHbGpYdG0wMERCOW4yN3lTTmJlTjRpcnVVL25tUmZqeXBPbGxjZ0tBZmRG?=
 =?utf-8?B?bGc0L1NSYlBoNWJOdTNmQ1FlMmNjenBoZE1CQk5NeVVOOVBFOXJFbmJqVEZq?=
 =?utf-8?B?dFdodmVuLzZhaXprTmpma1QrbGJUM2NKQ0pkeTVZVGRXZ3VZd2VYd3Z6ei9O?=
 =?utf-8?B?UktlSXlkR0hyOTA1VEJIcWpxZFVhUklyeGJSYXdZcjhsVGpHSVBqMzBFYmlx?=
 =?utf-8?B?U2R1YlVZaWVEekIxNjZUZDZqbS9pUWFSOFlrL1VKcWJoVktVbWY3ZnNNdm9F?=
 =?utf-8?B?YmZQQmt4dVF4eHRhcDR4OWlTeUxFOTUxRStsd01ZSTlMUWhJWHVKMGdrcGs1?=
 =?utf-8?B?VVNCQ0VVNFV0MHVjanVseTRIK2hQMnFBUWxUVVowRzVmUUJ0eFhjWGhSOFhK?=
 =?utf-8?B?ZjlVM1dKTlAySittNHhFc0d4ZG13M00vWFNZUjVJbVM3djQ4VEJUZzRQWlJF?=
 =?utf-8?B?MUw0Uk9aZWhXaHVyeVE4WW42NitFRUEvMzVtRUt4eGxsVFcvZ3BuL0pXV3pk?=
 =?utf-8?B?WW56NmpYTDR1Wm44SUZKamU2alQwR1hudlF2elprempGMVYvWTVhQ1o5ZU5I?=
 =?utf-8?B?Sms0MkxKVU42SlZ2ajFqRmFaWGZzanpXRU5ra3gzdU92bWpPK05JVEc4VFdu?=
 =?utf-8?B?bVhzUEJmUFhHdkpIOU1uaTNDUFJ3NzBFa1VYQmhkQndQUEM4UXU4WHNZaHM5?=
 =?utf-8?B?QWorcGgzd3JmY1JuYTlESGhBRWhESmNvSDZoaXFYZnkzUzBzSmp3dktsS3Rp?=
 =?utf-8?B?Q0VkVEQ5emFEWWlYa2QyVndhWGNpaG9iL09VL2tvWVNjMlh3U3Y3QjBlODBD?=
 =?utf-8?B?Mm44UU1xRlJKMU52LzVKN2h5MUhhSWltL1AzL3A0ZWI5MzUvUk5vVFA5ZTF5?=
 =?utf-8?B?cTM2NmJyNTlxZUhNUS9DRUh2MndTUGdPWEQyMWU3U0tHa1l1WE93bWZIV2Vi?=
 =?utf-8?B?QitLS0xndzhBRWVMZmx4Z0xCRkV6TjZEVVFLbVdSdFhmSHBodmxyNXNNNzcr?=
 =?utf-8?B?UjRKcXhQSDd3TVVyZ0xnV0NnUVBpRVhRSkNLSENyekdGTTZEZUJ6K2t6Y3Bh?=
 =?utf-8?B?Z0ZGT1dDdUFDZlpUYXVTY3dZb0xrQ0VrMjVyckJUM2hTNGxHUHk4R29NSXV2?=
 =?utf-8?B?SUJxVnYxQ28zNFIrazBCZ2xoSU1xb09wK0I0TittcmxPZUk1a3B4R1pRdHlE?=
 =?utf-8?B?TFJjQ1pvUUlkRWxQSWFCMDNyVVViY2VKeDEwUm5LbGtXS2dLS25CNTR3WFJB?=
 =?utf-8?B?Q1dkY0JLL0JqTVIvN3IzaGoyOXU4aUFlQytQR2tYNWtFNXplOElPcWt5SnNo?=
 =?utf-8?B?dkdhWHdhZTF4SjZDRVBMMWdvQ2Z0RXpUS3NXVUhSS0pJbi9LS1cySVZGQUNP?=
 =?utf-8?B?VFJaTW5tRnRQNDA3bS9oSmNWclhWUG1hUUJrMjNyc1pXYVlZOUxQQVRWREtW?=
 =?utf-8?B?Y1ZLNTlUWWJmUHNLUlZwNURPaWY3Um9Ldlk5VmQ3TnpqNWNrUkxCeVRjZjIx?=
 =?utf-8?B?Tm93bnZaSVNjMDc1RFFTTko1K3Axa1N6aXo1TjYvUG5naE9pT3NzRmhmQnd2?=
 =?utf-8?B?emhkenpDYnY0ek9aN2ZHQlF6VUJIM3ErZkJ5V0VIa250VGM1b0lQbGRwQUdp?=
 =?utf-8?B?NU5zUWpwSFpHZDBaZFREQ256elQ5UVJHYUlQeWpaTUlKQmc3UU5WVUtmSktN?=
 =?utf-8?B?Y3U3VTZLU09UWlI3dWxMOU5CR05RQXRPYmZQeU1HbWt6MkVUaitYaTZTMERs?=
 =?utf-8?B?SFVLMzlmVlhaZmwxV051Y0tHdHJ5YkhuekwxdXhJaWd2K1ZNSnBxbmdSL3pw?=
 =?utf-8?Q?JxKwyMZ1aQ29s7q1T6QoKtAfUbIXyc+LDYNzV+iEwVNA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4673.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a59d1e24-befe-4da5-72a5-08dd5dc25d86
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 21:52:33.0115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uSNgKvMWtDLFOVX5Vyc4oWZ0f8lr53fzznvmye9MXARD3V7mMNm2he/1vK0OhTrlU8R2uhrmvdZJL+xv2+rPeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4254
X-Proofpoint-ORIG-GUID: 0egkWq-L_HtAbsq-Yf0Bo7QWEhMv46kx
X-Proofpoint-GUID: 0egkWq-L_HtAbsq-Yf0Bo7QWEhMv46kx
X-Authority-Analysis: v=2.4 cv=DO514zNb c=1 sm=1 tr=0 ts=67cb6aa4 cx=c_pps a=6eDru+6t2m7UgPRwoW7UVQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=-AAbraWEqlQA:10 a=RpNjiQI2AAAA:8 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=JfrnYn6hAAAA:8 a=P-IC7800AAAA:8 a=pGLkceISAAAA:8 a=M0C95MGl2GTylGUtBX4A:9 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_08,2025-03-07_01,2024-11-22_01

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiBGcmlkYXksIE1hcmNoIDcsIDIwMjUgMTow
MCBBTQ0KPiBUbzogV2lsc29uIERpbmcgPGRpbmd3ZWlAbWFydmVsbC5jb20+OyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiByb2JoQGtlcm5lbC5vcmcNCj4gQ2M6
IGFuZHJld0BsdW5uLmNoOyBncmVnb3J5LmNsZW1lbnRAYm9vdGxpbi5jb207DQo+IHNlYmFzdGlh
bi5oZXNzZWxiYXJ0aEBnbWFpbC5jb207IGtyemsrZHRAa2VybmVsLm9yZzsgY29ub3IrZHRAa2Vy
bmVsLm9yZzsNCj4gcC56YWJlbEBwZW5ndXRyb25peC5kZTsgU2FuZ2hvb24gTGVlIDxzYWxlZUBt
YXJ2ZWxsLmNvbT47DQo+IEdlZXRoYXNvd2phbnlhIEFrdWxhIDxnYWt1bGFAbWFydmVsbC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggdjMgMy8zXSBhcm02NDogZHRz
OiBtYXJ2ZWxsOiBjcDExeDogQWRkDQo+IHJlc2V0IGNvbnRyb2xsZXIgbm9kZQ0KPiANCj4gT24g
MDYvMDMvMjAyNSAxODo0MiwgV2lsc29uIERpbmcgd3JvdGU6DQo+ID4NCj4gPg0KPiA+PiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxr
cnprQGtlcm5lbC5vcmc+DQo+ID4+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggNSwgMjAyNSAxMToy
OSBQTQ0KPiA+PiBUbzogV2lsc29uIERpbmcgPGRpbmd3ZWlAbWFydmVsbC5jb20+OyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+PiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsg
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+PiByb2JoQGtlcm5lbC5v
cmcNCj4gPj4gQ2M6IGFuZHJld0BsdW5uLmNoOyBncmVnb3J5LmNsZW1lbnRAYm9vdGxpbi5jb207
DQo+ID4+IHNlYmFzdGlhbi5oZXNzZWxiYXJ0aEBnbWFpbC5jb207IGtyemsrZHRAa2VybmVsLm9y
ZzsNCj4gPj4gY29ub3IrZHRAa2VybmVsLm9yZzsgcC56YWJlbEBwZW5ndXRyb25peC5kZTsgU2Fu
Z2hvb24gTGVlDQo+ID4+IDxzYWxlZUBtYXJ2ZWxsLmNvbT47IEdlZXRoYXNvd2phbnlhIEFrdWxh
IDxnYWt1bGFAbWFydmVsbC5jb20+DQo+ID4+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRD
SCB2MyAzLzNdIGFybTY0OiBkdHM6IG1hcnZlbGw6IGNwMTF4Og0KPiA+PiBBZGQgcmVzZXQgY29u
dHJvbGxlciBub2RlDQo+ID4+DQo+ID4+IE9uIDA0LzAzLzIwMjUgMjA6MDgsIFdpbHNvbiBEaW5n
IHdyb3RlOg0KPiA+Pj4NCj4gPj4+IEkgZGlkIGNvbnNpZGVyIHNocmlua2luZyB0aGUgc3lzY29u
J3MgcmVnaXN0ZXIgYWRkcmVzcyByYW5nZSB0byBtYWtlDQo+ID4+PiB0aGUgcmVzZXQtY29udHJv
bGxlciBub2RlIHRvIGJlIGluZGVwZW5kZW50IGZyb20gdGhlIHN5c2NvbiBub2RlLg0KPiA+Pj4g
SG93ZXZlciwgSSBmb3VuZCB0aGUgc3lzY29uIG5vZGUgaXMgYWxzbyByZWZlcnJlZCBieSBzb21l
IGRldmljZXMNCj4gPj4+IGZvciBtaXNjZWxsYW5lb3VzIGNvbmZpZ3VyYXRpb25zIC4gVGhlIHJl
c2V0IGNvbmZpZ3VyYXRpb24gcmVnaXN0ZXINCj4gPj4+IGhhcHBlbnMgdG8gYmUgbG9jYXRlZCBp
biBiZXR3ZWVuIHRoZXNlIHJlZ2lzdGVycyBhbmQgY2xvY2svR1BJTw0KPiA+Pj4gcmVnaXN0ZXJz
Lg0KPiA+Pj4NCj4gPj4+PiBkcm9wIG9mZnNldCBpbiB5b3VyIHBhdGNoIG9yIHVuaWZ5IGV2ZXJ5
dGhpbmcgaW50byAncmVnJy4NCj4gPj4+Pg0KPiA+Pj4NCj4gPj4+IFRoaXMgaXMgZXhhY3RseSB3
aGF0IEkgcHJvcG9zZWQgaW4gdjMgcGF0Y2guIERvIEkgbWlzdW5kZXJzdGFuZCB5b3U/DQo+ID4+
Pg0KPiA+Pj4gQ1AxMVhfTEFCRUwoc3dyc3QpOiByZXNldC1jb250cm9sbGVyQDI2OCB7DQo+ID4+
PiAJY29tcGF0aWJsZSA9ICJtYXJ2ZWxsLGFybWFkYThrLXJlc2V0IjsNCj4gPj4+IAlyZWcgPSA8
MHgyNjggMHg0PjsNCj4gPj4+IAkjcmVzZXQtY2VsbHMgPSA8MT47DQo+ID4+PiB9Ow0KPiA+Pg0K
PiA+PiBJIGRvbid0IHNlZSB0aGUgb3RoZXIgZGV2aWNlIGJlaW5nIGZpeGVkIGhlcmUuIEhvdyBk
aWQgeW91IHVuaWZ5IHRoZW0/DQo+ID4NCj4gPiBUaGlzIHBhdGNoIHNlcmllcyBpcyBhYm91dCB0
aGUgcHJvcG9zYWwgb2YgQXJtYWRhOEsncyByZXNldCBjb250cm9sbGVyDQo+ID4gZHQtYmluZGlu
Zy4gVGhlIGR0LWJpbmRpbmdzIGlzc3VlcyBvZiBjbG9jay9HUElPIGNvbnRyb2xsZXJzIGhhdmUg
YmVlbg0KPiA+IHRoZXJlIGZvciB5ZWFycy4gSGF2aW5nIHRvIHNheSwgaXQgaXMgbm90IGp1c3Qg
YSBzaW1wbGUgcGF0Y2ggdG8gZml4DQo+ID4gaXQuIEl0DQo+IA0KPiANCj4gSSB1bmRlcnN0YW5k
LCB5b3UganVzdCB3YW50IHRvIHRocm93IHlvdXIgcGF0Y2ggaGVyZSBvdmVyIHRoZSB3YWxsLiBJ
dCdzDQo+IHJlYXNvbmFibGUsIEkgZmVlbCBpdC4gSnVzdCBsaWtlIHByZXZpb3VzIGNhc2VzIGZv
ciB0aGlzIGJpbmRpbmcgLSBldmVyeW9uZSB3YW50ZWQNCj4gb25lIHN1Ym5vZGUgYXQgYSB0aW1l
LCBpZ25vcmluZyBiaWdnZXIgcGljdHVyZSwgZWFjaCB0aW1lIG1ha2luZyBpdCBmcmFua2VuLQ0K
PiBub2RlIG9yIGZyYW5rZW4tYmluZGluZy4NCj4gDQo+IFBsZWFzZSBsaXN0ZW4gdG8gR3JlZydz
IHRhbGsgZnJvbSB5ZWFycyBhZ28gYWJvdXQgdXBzdHJlYW1pbmcuICJJIGRvbid0IHdhbnQNCj4g
eW91ciBjb2RlIjoNCj4gaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91
PWh0dHBzLQ0KPiAzQV9fd3d3LnlvdXR1YmUuY29tX3dhdGNoLTNGdi0NCj4gM0RmTWVIN3dxT3dY
QSZkPUR3SUNhUSZjPW5LaldlYzJiNlIwbU95UGF6N3h0ZlEmcj1zWERRWnU0Rw0KPiB5cU5WRGxG
VVhha1NHSmwwRGg4MVpJUGxVMjZZUzRLSEdJQSZtPUpscW93UDNLU19kQXVQQVJkZkhOVUUNCj4g
bWRmaUJyMWtWZDJpYTFhdG5ETnhCTU1CNWNjcU5VdVUxcXROaEpNaHpFJnM9V3B3ckd4ZHFTN0ww
QnotDQo+IGZLcl9BZFR1TEJEMnYtME9FS1NSQk9HMDV3S3MmZT0NCj4gDQoNClNvcnJ5LCBJIHdp
bGwgZml4IHRoZW0gaW4gbmV4dCB2ZXJzaW9uLg0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEty
enlzenRvZg0K

