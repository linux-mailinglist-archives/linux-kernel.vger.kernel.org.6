Return-Path: <linux-kernel+bounces-399246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D26AB9BFC7D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 03:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68D7E2815C3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA9117C60;
	Thu,  7 Nov 2024 02:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VzoS/Lsu"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC788C2C6
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 02:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730945877; cv=fail; b=ltPj6pacmI8Q8RrxxghguCpjc3M3lORgac0jM/HTkRxaTNltyHIh2fFi/km4F/tEgIek+aJhqlbOqbuBBg0MKpbhEhl8Z0DxJ5BbgyQhiIeAWbhi6zaYpzLcyMTumDUuIShr8WGR8erjmIHoKDGnWxnPNtRn+IeG/PkijUwOY/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730945877; c=relaxed/simple;
	bh=QpKbjYJt77Ura8CE3bu+7aqEEptun8BiPbTQKNd9/RY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EZScX9cSn2mlxbG+jfIDD1sm7IE8CvE6nhi/0G+NXyGfUCtWZ90aUrg0SSVNytuL2hh/+mCiosea/GxqUvjwrqJtgJiLNtM7+o6x7hdtBLo64aZYjo+8fXK7E9gyXMUPCTeft2NNtubR7Cf35Yyl26fqfLHbP630hH0ZR8KUdAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VzoS/Lsu; arc=fail smtp.client-ip=40.107.94.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lR80FXSflrSWa03nI4st8fffBI9MP53v6NRX9W1xvCt4dMPBYp3fLuXahDbSNhSU0RntMk19ccoNLSrvixpnH2gBU90eYoHLiQrDP3nuJ6tmfp47VJ6UALw5N3Fykc8ETCyZ5cHcozS1BpFX+9i4q/Sc0nh4A7QkolhNNV7+iwO/mZBTva+XRH0khmdEPPvRhgPHKFOJCrXa+D1L0wCQd8rbItUXKy2zHTtvNUi/uNWfznMUoinKwJ2g73K0vLTbiSafzeX5V1+d9DUiVs5T3CMDetSe7GET3WiY3kz6zF++hflAJieFzegn+3GCz2jg8YXVrfAFZklVIvcK00usBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpKbjYJt77Ura8CE3bu+7aqEEptun8BiPbTQKNd9/RY=;
 b=W/1xqUWssfG2ACIkOOLT/3oOgj8szUNZy5hTWFV5e1LcZZMKULo+xjXurB0PZblF5uvKrAdvRH5LFSathVZhvL8E4//lh9Fe0UEZTEE34F2SXJ9X1o0H6LJPu625xa2kT6wy7WBGRxjtC+mF8EfGqtqlM3qExVVwh1dpVKTsG3fefmxLzMUgdtQFBl30LM8wzHM+f3ZUUtwHFPFl1I+gvRGLfoB2FVWWdCUsMmmj7AK/h87X+LoMqa+QCcoT9RiOcUONS91BFbIUPPCC7FL6zHpk0c0YQNLIqTQURr4AwbVetFZ1UbSwWXkqf+o3IugDsXi111KivEtWtZtDPF2iig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpKbjYJt77Ura8CE3bu+7aqEEptun8BiPbTQKNd9/RY=;
 b=VzoS/LsuifOwZZFgFERpPqfOhCWD2gdX9QoBJTb6Kol2uIQL2p7A5n6SIXLBv/9XINge/YfAw2uInqW/f7vnr8V7o57kSTYvOZkeEnXoe1Ax7TzeWgTvrNNVoqH13xslbQUBptnLimGgIq9ehThZPqtvWcm/V5FaS052UNoNdog=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by DM3PR12MB9288.namprd12.prod.outlook.com (2603:10b6:0:4a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 02:17:51 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285%3]) with mapi id 15.20.8114.031; Thu, 7 Nov 2024
 02:17:50 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>
CC: "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Deucher, Alexander"
	<Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Pelloux-Prayer, Pierre-Eric"
	<Pierre-eric.Pelloux-prayer@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
	"Chen, Jiqian" <Jiqian.Chen@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Bypass resizing bars for PVH dom0
Thread-Topic: [PATCH 2/2] drm/amdgpu: Bypass resizing bars for PVH dom0
Thread-Index: AQHbL0jnzeSblsyF4UKh6ng0gKqwi7KosqCAgAFmCQCAAE/ugIABNK4A
Date: Thu, 7 Nov 2024 02:17:50 +0000
Message-ID:
 <BL1PR12MB5849A898BE10FBE4AC6C4FD3E75C2@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20241105060531.3503788-1-Jiqian.Chen@amd.com>
 <20241105060531.3503788-3-Jiqian.Chen@amd.com>
 <e6dd8f17-2322-4fd7-bdcd-861e77fcfc8a@gmail.com>
 <BL1PR12MB584921467E47ABAA580D95F7E7532@BL1PR12MB5849.namprd12.prod.outlook.com>
 <228fa4cd-1e2d-40f6-8c63-15a9d6f90a04@amd.com>
In-Reply-To: <228fa4cd-1e2d-40f6-8c63-15a9d6f90a04@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: BL1PR12MB5849.namprd12.prod.outlook.com
 (15.20.8114.031)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|DM3PR12MB9288:EE_
x-ms-office365-filtering-correlation-id: c2a4bafa-0f22-4306-6ce6-08dcfed26152
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MVIzcXNGQWgrc3lFbjFuQzRabFpkODdpNENSdjdNY0phdUZXNnhQMHpKT2ho?=
 =?utf-8?B?Ty9LZVoyNzQ5SCtlRlFOelppUXZ3UHYrT2JDb3ZhdWhHSzFqbG9YbVpHWGl1?=
 =?utf-8?B?TEwxcm53dU1WUk45dkpmV21VTTlMYlZ4RUt0V3M3dVNwbUlEQ2U5aTFTNDJU?=
 =?utf-8?B?SFhSMmUvUUtlSmNEb0cyeGtjT0xPUU1hbU1Jck5XZDFHalJWNmdsdjRINmd6?=
 =?utf-8?B?Nis3dUtyeHlQSTN1d3RZTHZYcnkzb2JwVjBtRFZUK3E3V05DUEpISWJydGpm?=
 =?utf-8?B?ZU1CYU5LWnU4UW9PTVlsYVl0TUIrK2EvS25kdElScmpzVlViaTRhYU1iM2FS?=
 =?utf-8?B?Ym5tdmRNNy8yb0tQbjdlOFBvbERBZEU5Skw1d3NuZTVjSnVyT0FKUVFSVlZz?=
 =?utf-8?B?UUpxdVBLTHdTbitOMEFuTE9rVVVseWVCSWJnVkRTZms4SU5SaVljVmt0SFJZ?=
 =?utf-8?B?cXpwRFZpRG5HV2s1bVBad2had0M2OVFTc2RORGRncFdQcEd1K0pvbjYrZWxL?=
 =?utf-8?B?VHlvQ1V3M295ZitlMVlFTkQwaW1qbW1PTEcweGJpNyt3bHkzYjgrVUpmcXkw?=
 =?utf-8?B?SlUzSFh4WWhOOGFLc3FxQnZWTjhRbzRzOEZhKzhLZElqeXlSVkRZVmV5aXZ2?=
 =?utf-8?B?MkxKRUU1VDdNdEtxMjlMUFRkenVhbnFNS0lBOEFwUVRtZVlLMlRibXMvS3Bw?=
 =?utf-8?B?V0dia3laUlBzUVVlaE9LOTFYMFpXL21jYWxERVVXV0hxcXNVazBSTHJtbDBC?=
 =?utf-8?B?anNhZTgrRjUwZjhRbXR3c2ZoOTZoRURveDgyZ0xRWW9yQm1COVZJdmpZdHJP?=
 =?utf-8?B?aFhkS2VTSnFTRTZhYm53RlJ0a24zRTJDZ3loQm1xeXkvZytIWTRMY2FqcFl5?=
 =?utf-8?B?RDVwZ1BSNWtUb0lqSmVrMnArUzJNOWloWXZGckZoTE9ET0NnbHcxQ0hsSld1?=
 =?utf-8?B?Z0ttS3ltb1p6aEVkcWx1cGN5ZGJWNGpBR2cvcVNQTzIySWZJRTM1NFNDbU5h?=
 =?utf-8?B?am11VXVkV3hSeUsrRENTeXBvQi84ODNEeGJLMjdmbmM5NjNWTlFVWFBweUI0?=
 =?utf-8?B?Rmg1Z3FyUUhEOHFtL3FsYm9TY2xFV3RLM1kxaHVkSFhhMVZNRkk2SVBXdjJC?=
 =?utf-8?B?Y0ZoanU4azlURUpSTHBQMmgzQVVQelJOT2FwNWRpbkI1eGo0TDZpWnBuWlV1?=
 =?utf-8?B?QnVjbEkyaTFaUTFjTzl1ZGhwMCtNY2R4NFkrRlJPRVM3bU9RNUhqMENKbmh1?=
 =?utf-8?B?Ri9mMmg4WXpyVyttczl0T2NwYjVDNCtIYXhoUmVRelYxR1RaemNRUWlUbGp3?=
 =?utf-8?B?bFdNb1h2M0tLdEZmRFRwVC9DNDBvUG9PWk5NTkRMOWNnQmQ4R1VVQnE4QzZj?=
 =?utf-8?B?RkxQZURtRkFTT2poL2hTNnVJZThuTXdhdGJidlZ0dWJNVHVTMEU0V1hrZFhs?=
 =?utf-8?B?Ymdva2pWOUpsZldKQzg3SkZtaWJUWEJDMDVCaGg0MmozU0p6Uzd0eUdhOG1J?=
 =?utf-8?B?WU1ocGZzUFY3RUMzNC93czR5dEdlZmNyQlJLUUpoVkw1SGhqVEdwRklxeEpM?=
 =?utf-8?B?NEhKd0JaVEwzbWVKQmVCQWZiNkM1L2dtY2JUOFVjRlRvTDdxYS84VUpYN2ZJ?=
 =?utf-8?B?VzhpeXp1ZE1nR0VyU2Ewd0F1WHo2aXAycThtcWNpWGlCVlQySEVMdjFDT1dC?=
 =?utf-8?B?WE8yUXZYc3NjUTIrbmw0VytONUZxSDFuUkd6N1FqeFdSTmUrSktrbFEzY0d4?=
 =?utf-8?B?VkRDM2VKN2NmcEpmUVdlWUtqd3lKTTJkSnhCS25ReElheUl4UGk2MFArVnFK?=
 =?utf-8?Q?X1eTQIfbNJrEFTdlmFBRtElUYuyewyVdFXm1I=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NmpTc3lDMGFiR2hyelNWaFJMaTVQWlBlQ084WFZZT29iN2c1T0xkN3RYRWw3?=
 =?utf-8?B?WTJ6OGR4Y3pHUWNDMFpGY3o5Y21qWFo1VkVSVmVRNnZvK0xLVTNkT2k3T3BJ?=
 =?utf-8?B?Wk1zZjI4ek5vaWtVR1IydkRxN0NDTldxMG1RTnZ0cUFVWENienBxV1NmOFBI?=
 =?utf-8?B?YkJwMDcrK2JxVHpVcEovN0ZwcytKMllwb0NlcEpDdlp2Uk9BSGlKdVgvWUJl?=
 =?utf-8?B?SkRwN2lia2NIM1lsTnRkMFVpakhycU1nUmYydEVrbzZ2Mzk4Q2c5UkVlcHpx?=
 =?utf-8?B?Z0s2M1B3bEtHb1A0d25zeTAzb2xDT2pVREtZb2tVUWROTTNFRFl4MlA4R2du?=
 =?utf-8?B?bnVSUjc1dnRmSEJNb2s5VEU2Ym1Sam1Yc0kvTkhEUm5ES1RYTnBhbUU4b0Ft?=
 =?utf-8?B?ZHg1RFY4SGlwbkpTbC9Bd1F3cXViVnQ2MFZvOGRPSHdiQUloSjFVMEE4SDZM?=
 =?utf-8?B?Y1IrMGoxLzdwT1NqY1hMa0RRNUtRdFhhaXU1SHQvRG44eERWOTQ3Z0F4U2JY?=
 =?utf-8?B?VkdzbDJxMHA2YXdQTkZtODVIKzZyWTBSRnRuNERnaFFGRllJMkxtWUJWd2tQ?=
 =?utf-8?B?RnJKYlA3VHZKZ1NMdWJWVUkxbDlkeEVrR3psTGY4YUR6TFMwakxJc3VHTWpK?=
 =?utf-8?B?THFaaVJmYUxxZkpwN2JaVXVJSFl2WFNDc0krbHVCeGgyYWdLTHdtT3E0a2xm?=
 =?utf-8?B?Rm53bGhXZWZlNlZyNjV2a0hpQWt4YTRhaUhkNnROQUJnRW5iQ25Gc3h1dkVF?=
 =?utf-8?B?dXcrRmwyUS9NaU5EVHZYNk4xT3Nqd0RVclE2Z1M2RzlueC9zQzVjV3hSK1Ar?=
 =?utf-8?B?T3dYMGErTTMweWNMRzIwZzdEZHdDSmZkUDJocDRMYTZ0TDR5bkkzZVB1ZnNE?=
 =?utf-8?B?Wkkza2NnUXNBcTZSYVdTNm5wNmxBM1R0Vlg1N1pPZVJFMUxxNkJkV3lVaExN?=
 =?utf-8?B?S3FRR3NQZXYvOHllbDhsMFR0MGV1cXgzYW5QbWc0NU1JdEthRVRrWEZPbm40?=
 =?utf-8?B?VDFOanBhMU9YbWxBYzJWd3RjRGxHWWcrbGdSQ05BdnpjVFBGdGt5dExvSGVQ?=
 =?utf-8?B?bk1mYmVOZEdlV1hKcFdLeHd2b280Rk5iUjd2YzNDTkMwWHYwUnZBbnNyRnFN?=
 =?utf-8?B?REtobjRKc0pLY28rdUlrM09KZ1pPRWZGbk95bSswUmdGdTk3UG52VEtXNzIv?=
 =?utf-8?B?WXVwWUZ3akNKRGovWmRQc2RYVEdJaUpHbEtROWdzZlFtOHlVMGhIYVRRTnEv?=
 =?utf-8?B?Mkg5UlNNUVVjMU4wOEliWU13OVRSSk1HVlB4RENkR2lJbHlkU0RKa1k4d2I4?=
 =?utf-8?B?RWNIeno2M1ZYK2VSNXMrU09zaGNJRFZIUU5UT3dQc0hTN2d6bVN4NEdCT3Ro?=
 =?utf-8?B?SjVFL2ZGU1ppKy9XOEd2Zys3ODc1VGpIT2hJZyt5dkh4cFM0eUwybUlaeDlJ?=
 =?utf-8?B?cXUvczlJbGdOSEVjQUpNV1hsUm54YVVmQVFjUGg3ckpQcDJmajFXQXhXWWVn?=
 =?utf-8?B?cDVwcVkzOS9BcXlwRHFjRkQxQXVNbmtBNGJibjB1d0laQWVYK3JLVFVCTGpN?=
 =?utf-8?B?NEV1amZLKzFNeXh0T3BzZ2xpb1MrbG9VTW5NSEljY2VrZVZTU2V1K1FsTDkz?=
 =?utf-8?B?L1JtSjhyL2NkSkVKYlFSMGhxeGhiTXdTZmVZci9ZQWpMdUoxVVFiR1VlYTJV?=
 =?utf-8?B?Yncxcm9mYTVMb3pZUWNsYW5YS2Q2YnQ3dWZURkFrZlhxZEpza2xHWkE1MlJh?=
 =?utf-8?B?QnVocndNYTY0Zk5XenZiNXRtWDY1R2ZhK3gxY0xVMU9wRk82ajN6Y2l2NGVv?=
 =?utf-8?B?N0JYMDdCNjlHMEtscU5pT1krVVI1SFMyMWVTTUJoRVFjaHAxbWVwT0M1ZkFx?=
 =?utf-8?B?Ykx4Umc2bnU5Zm40ZmJyUzU1TFljRTZDUHZEYTRDN1NwNTdkVWFjeWZRdXdw?=
 =?utf-8?B?OXR3MGErZSt1Q0JaRGZWZS9HWFpTMHNyNGZyZVUyNkxnbUx4K3JmZ08vY05D?=
 =?utf-8?B?ZUdiNmlXUWF5MlgzSXBYdWV1TTgyOFBISGdtcjYvczZmOUc2bkc1b2RYeGF4?=
 =?utf-8?B?UmRFN1lqRmp5UFJXank4cUtETWd3eGUzSEdIeG84YkxVVWdnTE9IVU5KcVZN?=
 =?utf-8?Q?+MSg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0562BDC494E58B4E9FCD5572BB1A6D8A@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a4bafa-0f22-4306-6ce6-08dcfed26152
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 02:17:50.9029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SQrRF0CUsrySGv2Ms4bMTDzTK3bdwdW4CfRlqxBfFZGinZrZy8E13MfABBVTaVzUrfZz6X6hC6IehB+/y55x1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9288

T24gMjAyNC8xMS82IDIzOjUwLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOg0KPiBBbSAwNi4xMS4y
NCB1bSAwNDoyMCBzY2hyaWViIENoZW4sIEppcWlhbjoNCj4+IE9uIDIwMjQvMTEvNSAyMTo0Miwg
Q2hyaXN0aWFuIEvDtm5pZyB3cm90ZToNCj4+PiBBbSAwNS4xMS4yNCB1bSAwNzowNSBzY2hyaWVi
IEppcWlhbiBDaGVuOg0KPj4+PiBWUENJIG9mIFhlbiBkb2Vzbid0IHN1cHBvcnQgcmVzaXphYmxl
IGJhci4gV2hlbiBkaXNjcmV0ZSBHUFUgaXMgdXNlZCBvbg0KPj4+PiBQVkggZG9tMCB3aGljaCB1
c2luZyB0aGUgVlBDSSwgYW1kZ3B1IGZhaWxzIHRvIHByb2JlLCBzbyB3ZSBuZWVkIHRvDQo+Pj4+
IGRpc2FibGUgdGhpcyBjYXBhYmlsaXR5IGZvciBQVkggZG9tMC4NCj4+PiBXaGF0IGRvIHlvdSBt
ZWFuIFZQQ0kgZG9lc24ndCBzdXBwb3J0IHJlc2l6ZWFibGUgQkFSPw0KPj4gVlBDSSBpcyBhIHZp
cnR1YWwgcGNpIG9mIFhlbiBoeXBlcnZpc29yIHVzZWQgZm9yIFBWSCBkb20wLCBpdCBpcyB3b3Jr
ZWQgdG8gZW11bGF0ZSBhbmQgcHJvY2VzcyBwY2kgZGV2aWNlcyBjb25maWd1cmF0aW9uIHNwYWNl
IGFjY2VzcywgYWxsIHRoYXQgYWNjZXNzIHdpbGwgdHJhcCBpbnRvIFhlbiBhbmQgaGFuZGxlZCBi
eSBWUENJLg0KPj4gQnV0IHRoZSBSZXNpemFibGUgQmFycyBjYXBhYmlsaXR5IGlzIG5vdCBlbXVs
YXRlZCBub3cuDQo+IA0KPiBUaGF0IG11c3QgYmUgY2hhbmdlZCBvciBvdGhlcndpc2UgeW91IHdp
bGwgcnVuIGludG8gbW9yZSBwcm9ibGVtcyBvbiBob3RwbHVnIGZvciBleGFtcGxlLg0KPiANCj4+
PiBUaGlzIGlzIG1hbmRhdG9yeSB0byBiZSBzdXBwb3J0ZWQgb3Igb3RoZXJ3aXNlIGdlbmVyYWwg
UENJIHJlc291cmNlIGFzc2lnbm1lbnQgd29uJ3Qgd29yayBlaXRoZXIuDQo+Pj4NCj4+PiBJbiBv
dGhlciB3b3JkcyB5b3UgY2FuJ3QgaG90cGx1ZyBzb21ldGhpbmcgaWYgdGhhdCBoZXJlIGRvZXNu
J3Qgd29yayBlaXRoZXIuDQo+PiBZZXMsIG9uY2UgSSBhZGRlZCBkR1BVIHRvIFhlbiBQVkggZG9t
MCwgaXQgZGlkbid0IHdvcmsgdW5sZXNzIEkgYWRkZWQgdGhpcyBwYXRjaCB0byByZXR1cm4gc3Vj
Y2VzcyBmb3IgUmViYXIuDQo+IA0KPiBUaGF0J3Mgb25seSB0aGUgdGlwIG9mIHRoZSBpY2ViZXJn
LiBZb3UgYXJlIHRyeWluZyB0byBtaXRpZ2F0ZSBzeW1wdG9tcyBpbnN0ZWFkIG9mIGZpeGluZyB0
aGUgdW5kZXJseWluZyBwcm9ibGVtLg0KPiANCj4gU28gY2xlYXIgTkFLIGZyb20gbXkgc2lkZSBm
b3IgdGhpcyBhcHByb2FjaC4NCg0KT0ssIEkgd2lsbCB0cnkgdG8gZmluZCBhIHNvbHV0aW9uIG9u
IHRoZSBYZW4gc2lkZSBhbmQgcmVtb3ZlIHRoaXMgcGF0Y2ggZnJvbSBteSBzZXJpZXMuDQpUaGFu
a3MuDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IENocmlzdGlhbi4NCj4gDQo+Pj4gUmVnYXJkcywNCj4+
PiBDaHJpc3RpYW4uDQo+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogSmlxaWFuIENoZW4gPEppcWlh
bi5DaGVuQGFtZC5jb20+DQo+Pj4+IFJldmlld2VkLWJ5OiBIdWFuZyBSdWkgPFJheS5IdWFuZ0Bh
bWQuY29tPg0KPj4+PiAtLS0NCj4+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RldmljZS5jIHwgNCArKysrDQo+Pj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKykNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZp
Y2UuYw0KPj4+PiBpbmRleCBiM2ZiOTJiYmQ5ZTIuLjAxMmZlYjM3OTBkZCAxMDA2NDQNCj4+Pj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+Pj4+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPj4+PiBAQCAt
MTYxOSw2ICsxNjE5LDEwIEBAIGludCBhbWRncHVfZGV2aWNlX3Jlc2l6ZV9mYl9iYXIoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+Pj4+IMKgwqDCoMKgwqAgaWYgKCFJU19FTkFCTEVEKENP
TkZJR19QSFlTX0FERFJfVF82NEJJVCkpDQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4g
MDsNCj4+Pj4gwqAgK8KgwqDCoCAvKiBCeXBhc3MgZm9yIFBWSCBkb20wIHdoaWNoIGRvZXNuJ3Qg
c3VwcG9ydCByZXNpemFibGUgYmFyICovDQo+Pj4+ICvCoMKgwqAgaWYgKHhlbl9pbml0aWFsX2Rv
bWFpbigpICYmIHhlbl9wdmhfZG9tYWluKCkpDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4g
MDsNCj4+Pj4gKw0KPj4+PiDCoMKgwqDCoMKgIC8qIEJ5cGFzcyBmb3IgVkYgKi8NCj4+Pj4gwqDC
oMKgwqDCoCBpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQ0KPj4+PiDCoMKgwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIDA7DQo+IA0KDQotLSANCkJlc3QgcmVnYXJkcywNCkppcWlhbiBDaGVuLg0K

