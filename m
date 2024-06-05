Return-Path: <linux-kernel+bounces-201751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFDD8FC2CD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 06:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67F75B2106F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 04:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC26673461;
	Wed,  5 Jun 2024 04:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="YgJgXJsb"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70F68C1F;
	Wed,  5 Jun 2024 04:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717562789; cv=fail; b=fVhAaPUmOOMGucwsT9bAqHOFS0GqP9OktS2NEQVqnVq4n2q1B8sA/yQV4G49p4/hyk3AiX0yKL8mnmX22LXeRcMGbpIE/nge70XdrxNwNjxdESP071CqqM5FrfGytYfezu1BCkMV+9Vywu2Bi/RZ23AYh/K3XzwUVLvCgkvGjTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717562789; c=relaxed/simple;
	bh=1k9ThtNnfSkxcKRV9SAAa/zhVoflzIBExV25Jn9vltQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YlF01xyNkgFMBku6gdupXNhMuJz27lv5gfb8RcH2T6JXyLBoOwmgINO0FG/GHgxEurHYywDa6k5TX+Ete88uKqoS+H0uuyQfXm2XC+/Wod/AMpvjcyqnMiY2oLV/OoHCWqL1nn+IjKopFAoSAD99AtWlMGFdLRRb1Y9R1C+LvnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=YgJgXJsb; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 454HgiNH011088;
	Tue, 4 Jun 2024 21:46:16 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yj7jhsyaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 21:46:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IqX46XlaPnoMsc6VQWiwin+m5U8X5GDvm3cDt4RBPhM+u3RUMuq+nrclMg5MviD7NvoxRXK16YT/bhRGzst5wXdQ5Og1Gs2owzd3dgc9WmBuJe+kJgO2UKUjoIQLmXxYUdxKRQoWFneMUyKFhu3Y00YU4cZGSr7mYmG96fISX5HXJAexJy7JG7nJ3QdElt/z7EqHnt7wyMTLzrWmx58sESTUijiga05ApFM/fSH0cz7eC9djq2RtWvaCSgtzJPXIV9zSP1rukM9CPP8JzwgFw4W1r62/sir5uEg5j6rDOmUFmQG15OybSE4lAQfgxMPyCL7CPOfJOFoJf8iBq6gThA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1k9ThtNnfSkxcKRV9SAAa/zhVoflzIBExV25Jn9vltQ=;
 b=WnAxJ/ZSSFtrBL7s+XWGizG1VDTj4QPBj2qHjD6tN10MaE2kW5EaGWMhwShy5OX7N8HhfWvOriouN6vuXSf3mDmWj+GcSVt3CmQFhh7ufllLRfDznKSq2TqZhljpkUXuOU/6eOsgFKs6QnZlgHyPcJSdgrZe08BQd9HIGHW4UTihIMMEOV5Im9YLP1P/8jroLKZgnhGCdRqvTP3VtLHvOWGMnQKT6euUQCLTREktrWzFpTeaXy7Pw4W36W7uJOml6XQj6UYEO2Ju0FutNi8spLSVhoAAiXSXznxPnOuhYFu6YboUeTO7IwoyesGrgn/9CuTUX0aAwV3AD5eIp8Pg9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1k9ThtNnfSkxcKRV9SAAa/zhVoflzIBExV25Jn9vltQ=;
 b=YgJgXJsbjT6HIJ4BKG0wh45Rb/XT8F4qHA3LfvrXruycPGKQQZWs53xZZOvYVCRN3rGGJotM+rgwFYEoJ8+k5mIj6W4nFagm71/cko+oQMExdu/J8zJVA6hnrxfRcGO72KgWryRYM74+taDsyQbncn+bRBTGh057dbC5dFRJLlY=
Received: from LV8PR18MB5914.namprd18.prod.outlook.com (2603:10b6:408:226::21)
 by SJ0PR18MB5110.namprd18.prod.outlook.com (2603:10b6:a03:439::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Wed, 5 Jun
 2024 04:46:12 +0000
Received: from LV8PR18MB5914.namprd18.prod.outlook.com
 ([fe80::30f2:fc3d:f58e:8305]) by LV8PR18MB5914.namprd18.prod.outlook.com
 ([fe80::30f2:fc3d:f58e:8305%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 04:46:05 +0000
From: Linu Cherian <lcherian@marvell.com>
To: James Clark <james.clark@arm.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "coresight@lists.linaro.org"
	<coresight@lists.linaro.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        George Cherian <gcherian@marvell.com>,
        Anil Kumar Reddy H
	<areddy3@marvell.com>,
        Tanmay Jagdale <tanmay@marvell.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "mike.leach@linaro.org"
	<mike.leach@linaro.org>
Subject: RE: [EXTERNAL] Re: [PATCH v8 5/7] coresight: tmc: Add support for
 reading crash data
Thread-Topic: [EXTERNAL] Re: [PATCH v8 5/7] coresight: tmc: Add support for
 reading crash data
Thread-Index: AQHasxL6HSSYgqZmpkmyMvqwmiHp9bGxHWeAgAeCewA=
Date: Wed, 5 Jun 2024 04:46:05 +0000
Message-ID: 
 <LV8PR18MB591464D32C0E48F42071EBEBCEF92@LV8PR18MB5914.namprd18.prod.outlook.com>
References: <20240531042745.494222-1-lcherian@marvell.com>
 <20240531042745.494222-6-lcherian@marvell.com>
 <5fbb37f4-031b-4b8a-be7e-676cab82b180@arm.com>
In-Reply-To: <5fbb37f4-031b-4b8a-be7e-676cab82b180@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR18MB5914:EE_|SJ0PR18MB5110:EE_
x-ms-office365-filtering-correlation-id: 35acbda0-5ff3-40e7-fbdf-08dc851a68f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|1800799015|7416005|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?eEtrSHpvTlpyTmkzRW9YeUh5S0FiNjRObUJpelZVTk80ZDRXOXRoQTF1TmxW?=
 =?utf-8?B?K3hydkh3WHR3RGtaeXBsZzJYd3crMlJYMXJ3czVaMTRqWVVxZUVRRGpzVk9o?=
 =?utf-8?B?Zml3R2cyYkR1aEc4MitWT0RYSnNNZndVd3NDU0xxM09sazlQbFZlL21GZGVo?=
 =?utf-8?B?K2F0TXpLY3lzd0ZxREdreHhMakpaWkRsVXdvQU4xN3N4TUt5clZ3TktXWVNw?=
 =?utf-8?B?a1Q0bUNON21oTmRDWXBHaTI3b0d1RXlabFNnVGZIRmJKaFFza3BFbExpSFEw?=
 =?utf-8?B?b1poTERmaTJvR0htWkx5NFNDemtjV1N0QzB4SXlEaE04TkRPbENjM0ZXMVNh?=
 =?utf-8?B?UFFmbGh0eVdheTVENHhRUkdRa012R3EvdDFRSXErazR3YWI2bEx0U2pxeFoz?=
 =?utf-8?B?WHY5ditpbFlJTkxaZlNPNTlMa3pnU3I3bGlLSElXajYwN3hXRnVOWWxBd3RW?=
 =?utf-8?B?S0tPc2NXRi9VL1B3MGpVOGpla3BLN3dRZGpCSlhhNExTaWhwOWEzNWJnVnRW?=
 =?utf-8?B?bnlTVHJRdlVhbVpMZ0FkcGd3S0lvQm9pZEJVWmJEL2NTdG9FQXp3SlIrcVVS?=
 =?utf-8?B?QmRMWnRVcDJBaHVESE5rYXFYOXhWUFByN2RKT3FtZUN4cy94OUd0SVJVTW9q?=
 =?utf-8?B?WXB1QmhINFRDTTQ3ZWwrTVFRVk1IbmFCWnRTbStxelcydFZLUkxZT0RYdU43?=
 =?utf-8?B?QUxSVWxnYlFMbzlqS0oyM1A1R1ZBUzZWcE5DdWZrMzVPQ2NKRG00MG4xbTgw?=
 =?utf-8?B?d0tuTWRTbGNTYTFNN1Q1Ly9KMkY5KzRibmJMUkJsd1dDQ3RvcVVUaTR3SHBU?=
 =?utf-8?B?U1gvMjAxNGdUZk5TM3hUMGdBb0NKSjBMNXRweWkrRFVCOUZmUjNubkVMU01z?=
 =?utf-8?B?dzc5MSs4V3I0VHN2b2pqUzFBSEdrZk9PTkRzYUR0SDd4eFZuWkNlb3JYZDBk?=
 =?utf-8?B?dE01aFpsRHJrc3Y4NjRVTU5KSVFMUUxzcytaQXNsUkxtTE9ZZTRDWGo2VjBW?=
 =?utf-8?B?bmJUbk1WQzRwWitoWUplUnJ4V3FnaGNwWjlOVkRqWGxIMmN6dzkyL0RUVksv?=
 =?utf-8?B?dk8zMCs5QzM4dU5JUWJmWU04NVh4WUlEREY1UGovenp5Y0RXcmVCMGU0VzM0?=
 =?utf-8?B?cE5KK2w0NHN1Q0hxeHBkYUNQMmZNNWJSUDhzYkNQZktsdnpibjkrVzBrem9H?=
 =?utf-8?B?ZStyRFFERnZCd2hESzZ2SjUyaUx4NW5DV2NCaHEvZi9qNi94aVdPZFI5V2xT?=
 =?utf-8?B?bUhwSkRqZlFlbFVvQ1lNR0dQTDdHUEFuRThlbFovczVuaHloSXlOTndVWnoz?=
 =?utf-8?B?KzIxMXE3MmxrcW56OENyYkpDUUUybmlpeERVNkh6djhzOVZNWlM4Z25RUlZw?=
 =?utf-8?B?TWVyVlBpWm9lNEVCRk5WNHZaZmFQYmhHbWh0bzUxV1J6UUcweUkvd2hVWVBE?=
 =?utf-8?B?a2dBNG1tT2MvYlh5Z0JFNzR4WTQ4ZWFPNFVFVzkzYWYzTjlRWm0xTE9xZGdE?=
 =?utf-8?B?L3MyUjc3VkRtUTlnTnloeW42QWlZRyszdDRJYjEybmRCSDIzbzNrRExBSG9p?=
 =?utf-8?B?Qi96cUlKb0pMY21Qb2V6ZDFzN3JBcHpRUEpRYXlmOHJCQ1ErYVYxeSsvNUY5?=
 =?utf-8?B?Nis0Vmk3bTNGU1R1MVI5RWc3Rld2VldyRmQrSkRKa3ZycXhMVENPK1RkTk1G?=
 =?utf-8?B?bW1wdWE1cTJwVjU2dUQ3UW1jS0lqZXFyanN4SGdFRzk4bmQvTTVnZ25RajZm?=
 =?utf-8?B?MWNRRDd5dCszRExheXlVOUY1dzFjZE1hVDk4R2R2SC84TEUxSU9IWGVuZ2Rh?=
 =?utf-8?Q?af0VcfCGhh2atPMnkFB+RkPH89uWxdCmgMfVg=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR18MB5914.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bjl3QW1rU3AvSW9TTkhMa1RJUTR6WjFIZ2VuSzB3MzZQczBEb1Z0R1ltZ3dz?=
 =?utf-8?B?ZTd3dHIxenFNcVVTYjUrZDRzQzV3dWlEWmo2TXplTVJBemd3ZFF5bU0zdm9B?=
 =?utf-8?B?WGFjUzJDZXR3bW5KSHF6TEYweHdXd08xZ1ZNVTc0NEc3RmpvSDZyb1lYbzg1?=
 =?utf-8?B?cHpGRy9kaHVqdC9TS0p2SEhiTnhXeDl2bnkvWVNWUEplWFo4SWgxbzVHZjdH?=
 =?utf-8?B?cVlYRTVUa0x5cUluNGpsVmhLK0lWWm5SbmhXazJZZnBXVTdPY01OOU1MNnBX?=
 =?utf-8?B?RysxTHYrd0p1NGtVMDRVK3pWbDRCcHYvWXlId0VMU05yQ1NEOHM3aHhmaWho?=
 =?utf-8?B?WXI0UC9HQ3NGTmxRVmh3L3JITFBsaE8yMEJ5R2d4ZG9tZGJWTVNsRWxUVFND?=
 =?utf-8?B?TmVhK1RXd2dJY1kzenlzVHdreXc5ajM0K2NrbUFscGZUVnZLeUJGcjRrWmhO?=
 =?utf-8?B?WS9YUjZRbmZCL2tDNWNSRGZmalVoVW1DU3F3akczZUdCN0JDdFRPSFluVmd0?=
 =?utf-8?B?SWJ0SjI1Njg0QmgzWnhLdWJ2anI0TlJXVnp3aisvcldXb013MGhiQVhrVTEw?=
 =?utf-8?B?bG9QL2VpR0MxaGltTmZFdk9YZU5zV3Z5Smk5WklxSUxXWVVPek9JanRWYW52?=
 =?utf-8?B?WjE2bnJMaGZKWDZRK2lyMXdXODRuekZ1WHV4YzROdE1aa09DZXh3WlEzZXIx?=
 =?utf-8?B?Sk5KMksvbG5SUDQzRkJCd0ZRcE5CSS90aERtc1lYcVAwU0FxT3NFQTgxa3hZ?=
 =?utf-8?B?TU1penlDQzRWbjl4TmtVRUxnekJERWZrVG96Q1VQNG9ldVROTVRlRG1nNzlE?=
 =?utf-8?B?MEhhZ2VBTVhrdy94QVZqQjh4bG4xZXFYMUxqQkNOWW4yQkpQM1BLY0owQ3d3?=
 =?utf-8?B?RjczU3VaMFB0d3ovSzNkTVNzcTZ4em9nZGUweXRuWG14cXRHdW9BQ2FkVG00?=
 =?utf-8?B?Ums2WGJoeERuY1JGQmVKdVRxdkRlejdVN3VzT1dJSHlTckFqT2hVZlEySmpK?=
 =?utf-8?B?SG05WHVlUC9mM0Q1QkZhRWVmMWlncEZSZFQ0SzZYRDRZd3BhWlQveXNqa3p6?=
 =?utf-8?B?SmkvWndnVk5jZ0h5RDYrSGQ2Q1FqblRmQmg5a241RW5nNHZ1MGMwNnliSW01?=
 =?utf-8?B?N0ZpMEdrZU9wSzhqSTRJRHNubFhpNkJaNGFDdzFlVllFTVVqZ1BjU0ZZYTdp?=
 =?utf-8?B?SHZWbzhMaFpZeW9YdVdYN29RZmNtUlhyNWYxMDIzUUcvakM2aUY5UWRqWVcv?=
 =?utf-8?B?T0RBSHpmbFJuTlFFZW1VNDNTaFU4S2RCYkFqenhManl5QVJMelI1UUYxcjFM?=
 =?utf-8?B?R3d4WlpqUHVrWEVmMUp2VGY2UStwS3JaRUd6N1VCenJ0eERQRzdIQ3E4ckR1?=
 =?utf-8?B?NmJ1T1JaMU9MTzAxaEFkeFNyVFpQYWErbHVVNkJUbzVlWEFKYThNWXVTVVg2?=
 =?utf-8?B?cjRPbCtFTTRLS09xVStjMkNvRWJ6dFc2dE9nUmhZek1mbWFvQ2phNHZaNGI0?=
 =?utf-8?B?WXRrSFBrUitReEhMWGMwM3VFcHJtNFhmT2RXU3VGR0gvYmhYeTl2dUgzc1Az?=
 =?utf-8?B?WVQzOHBBRjloWHdtZnJycHRUQlpBdkw1elB6WFo4dG1SNE9xZzR5TW9TS2di?=
 =?utf-8?B?S08xSXV5MC8vMkkyanIyV2J5Mm1oc1luWHlKMkM0RldycVR2SEUxeXJGc3My?=
 =?utf-8?B?WHZBRnlPOWx0bU1OTTE3K3hHTG9oaUowdlBhUmFtelYwUDJ4dURmQnFvMXMz?=
 =?utf-8?B?U1h2c2tpOGFjMXhrL0h6dVh0SzhrYkRPQml6bC9Qb3h5blNQVXNJbUFLcU9X?=
 =?utf-8?B?eUFEREFmQjdCR3Q1bXZ1SHJjd2h2L1pxQ280aytDK2pYR2g2SHdvbVFPTlpo?=
 =?utf-8?B?cnlLYlFZYXRNMEh6ZkFNTVVyVkJzM2JwQ1dMRFhXMEZpc1FCcmhGUVVkQ2Jl?=
 =?utf-8?B?VEF4U0NPSjA2K2pPT1J3bjM0ZDZhTlExek9QVFlGTDF4OUROcGVxRXV0cnZ5?=
 =?utf-8?B?UUhmUVk1cUk1aURpajVHL1ZBMko3L01mcmhnaG5wM1ZhTFVhSTR6YVp4S1M3?=
 =?utf-8?B?N2pCb2pzMDBNcEZDbEI0OFp1b01yNGNiNmZKVkVFQWQ0bVpFbHJySFpqZFJl?=
 =?utf-8?Q?D8otA3xqwr0OX04XmF5BSYOcJ?=
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
X-MS-Exchange-CrossTenant-AuthSource: LV8PR18MB5914.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35acbda0-5ff3-40e7-fbdf-08dc851a68f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 04:46:05.5588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tnu/I+srmT7S3oR9+lJjtZEuIV4bhfAneHjD/P3yEWjNqwdwoR0Lf49mkZDw4yd8TQxkn4cmiGK3V5ue5QQOmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB5110
X-Proofpoint-GUID: ri3Q9oA0x_WqASBADk73_1U1OLpd4fxZ
X-Proofpoint-ORIG-GUID: ri3Q9oA0x_WqASBADk73_1U1OLpd4fxZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-04_02,2024-05-17_01

SGkgSmFtZXMsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFtZXMg
Q2xhcmsgPGphbWVzLmNsYXJrQGFybS5jb20+DQo+IFNlbnQ6IEZyaWRheSwgTWF5IDMxLCAyMDI0
IDM6MzMgUE0NCj4gVG86IExpbnUgQ2hlcmlhbiA8bGNoZXJpYW5AbWFydmVsbC5jb20+DQo+IENj
OiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGNvcmVzaWdodEBsaXN0cy5s
aW5hcm8ub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgcm9iaCtkdEBrZXJu
ZWwub3JnOw0KPiBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7IGNvbm9yK2R0QGtl
cm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBTdW5pbCBLb3Z2dXJpIEdv
dXRoYW0NCj4gPHNnb3V0aGFtQG1hcnZlbGwuY29tPjsgR2VvcmdlIENoZXJpYW4gPGdjaGVyaWFu
QG1hcnZlbGwuY29tPjsgQW5pbA0KPiBLdW1hciBSZWRkeSBIIDxhcmVkZHkzQG1hcnZlbGwuY29t
PjsgVGFubWF5IEphZ2RhbGUNCj4gPHRhbm1heUBtYXJ2ZWxsLmNvbT47IHN1enVraS5wb3Vsb3Nl
QGFybS5jb207IG1pa2UubGVhY2hAbGluYXJvLm9yZw0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFJl
OiBbUEFUQ0ggdjggNS83XSBjb3Jlc2lnaHQ6IHRtYzogQWRkIHN1cHBvcnQgZm9yDQo+IHJlYWRp
bmcgY3Jhc2ggZGF0YQ0KPiANCj4gUHJpb3JpdGl6ZSBzZWN1cml0eSBmb3IgZXh0ZXJuYWwgZW1h
aWxzOiBDb25maXJtIHNlbmRlciBhbmQgY29udGVudCBzYWZldHkNCj4gYmVmb3JlIGNsaWNraW5n
IGxpbmtzIG9yIG9wZW5pbmcgYXR0YWNobWVudHMNCj4gDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gDQo+
IA0KPiBPbiAzMS8wNS8yMDI0IDA1OjI3LCBMaW51IENoZXJpYW4gd3JvdGU6DQo+ID4gKiBJbnRy
b2R1Y2UgYSBuZXcgbW9kZSBDU19NT0RFX1JFQURfQ1JBU0hEQVRBIGZvciByZWFkaW5nIHRyYWNl
DQo+ID4gICBjYXB0dXJlZCBpbiBwcmV2aW91cyBjcmFzaC93YXRjaGRvZyByZXNldC4NCj4gPg0K
PiA+ICogQWRkIHNwZWNpYWwgZGV2aWNlIGZpbGVzIGZvciByZWFkaW5nIEVUUi9FVEYgY3Jhc2gg
ZGF0YS4NCj4gPg0KPiA+ICogVXNlciBjYW4gcmVhZCB0aGUgY3Jhc2ggZGF0YSBhcyBiZWxvdw0K
PiA+DQo+ID4gICBGb3IgZXhhbXBsZSwgZm9yIHJlYWRpbmcgY3Jhc2ggZGF0YSBmcm9tIHRtY19l
dGYgc2luaw0KPiA+DQo+ID4gICAjZGQgaWY9L2Rldi9jcmFzaF90bWNfZXRmWFggb2Y9fi9jc3Ry
YWNlLmJpbg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5pbCBLdW1hciBSZWRkeSA8YXJlZGR5
M0BtYXJ2ZWxsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBUYW5tYXkgSmFnZGFsZSA8dGFubWF5
QG1hcnZlbGwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IExpbnUgQ2hlcmlhbiA8bGNoZXJpYW5A
bWFydmVsbC5jb20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlbG9nIGZyb20gdjc6DQo+ID4gKiBNb3Zl
ZCBjcmFzaCBkZXYgcmVnaXN0cmF0aW9uIGludG8gbmV3IGZ1bmN0aW9uLA0KPiA+ICAgcmVnaXN0
ZXJfY3Jhc2hfZGV2X2ludGVyZmFjZQ0KPiA+ICogUmVtb3ZlZCByZWR1bmRhbnQgdmFyaWFibGUg
dHJhY2VfYWRkciBpbg0KPiA+ICAgdG1jX2V0cl9zZXR1cF9jcmFzaGRhdGFfYnVmDQo+ID4NCj4g
PiAgLi4uL2NvcmVzaWdodC9jb3Jlc2lnaHQtZXRtNHgtY29yZS5jICAgICAgICAgIHwgICAxICsN
Cj4gPiAgLi4uL2h3dHJhY2luZy9jb3Jlc2lnaHQvY29yZXNpZ2h0LXRtYy1jb3JlLmMgIHwgMTQ4
ICsrKysrKysrKysrKysrKystDQo+ID4gIC4uLi9od3RyYWNpbmcvY29yZXNpZ2h0L2NvcmVzaWdo
dC10bWMtZXRmLmMgICB8ICA3MyArKysrKysrKysNCj4gPiAgLi4uL2h3dHJhY2luZy9jb3Jlc2ln
aHQvY29yZXNpZ2h0LXRtYy1ldHIuYyAgIHwgMTUyICsrKysrKysrKysrKysrKysrLQ0KPiA+ICBk
cml2ZXJzL2h3dHJhY2luZy9jb3Jlc2lnaHQvY29yZXNpZ2h0LXRtYy5oICAgfCAgMTEgKy0NCj4g
PiAgaW5jbHVkZS9saW51eC9jb3Jlc2lnaHQuaCAgICAgICAgICAgICAgICAgICAgIHwgIDEzICsr
DQo+ID4gIDYgZmlsZXMgY2hhbmdlZCwgMzkxIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0p
DQo+ID4NCj4gDQo+IFsuLi5dDQo+IA0KPiA+ICtzdGF0aWMgdm9pZCByZWdpc3Rlcl9jcmFzaF9k
ZXZfaW50ZXJmYWNlKHN0cnVjdCB0bWNfZHJ2ZGF0YSAqIGRydmRhdGEsDQo+ID4gKwkJCQkJIGNv
bnN0IGNoYXIgKm5hbWUpDQo+ID4gK3sNCj4gPiArCWRydmRhdGEtPmNyYXNoZGV2Lm5hbWUgPQ0K
PiA+ICsJCWRldm1fa2FzcHJpbnRmKCZkcnZkYXRhLT5jc2Rldi0+ZGV2LCBHRlBfS0VSTkVMLA0K
PiAiJXNfJXMiLCAiY3Jhc2giLCBuYW1lKTsNCj4gPiArCWRydmRhdGEtPmNyYXNoZGV2Lm1pbm9y
ID0gTUlTQ19EWU5BTUlDX01JTk9SOw0KPiA+ICsJZHJ2ZGF0YS0+Y3Jhc2hkZXYuZm9wcyA9ICZ0
bWNfY3Jhc2hkYXRhX2ZvcHM7DQo+ID4gKwlpZiAobWlzY19yZWdpc3RlcigmZHJ2ZGF0YS0+Y3Jh
c2hkZXYpKQ0KPiA+ICsJCWRldl9kYmcoJmRydmRhdGEtPmNzZGV2LT5kZXYsDQo+ID4gKwkJCSJG
YWlsZWQgdG8gc2V0dXAgdXNlciBpbnRlcmZhY2UgZm9yIGNyYXNoZGF0YVxuIik7IH0NCj4gPiAr
DQo+ID4gIHN0YXRpYyBpbnQgdG1jX3Byb2JlKHN0cnVjdCBhbWJhX2RldmljZSAqYWRldiwgY29u
c3Qgc3RydWN0IGFtYmFfaWQNCj4gPiAqaWQpICB7DQo+ID4gIAlpbnQgcmV0ID0gMDsNCj4gPiBA
QCAtNjE5LDYgKzc1MiwxMCBAQCBzdGF0aWMgaW50IHRtY19wcm9iZShzdHJ1Y3QgYW1iYV9kZXZp
Y2UgKmFkZXYsDQo+IGNvbnN0IHN0cnVjdCBhbWJhX2lkICppZCkNCj4gPiAgCQljb3Jlc2lnaHRf
dW5yZWdpc3RlcihkcnZkYXRhLT5jc2Rldik7DQo+ID4gIAllbHNlDQo+ID4gIAkJcG1fcnVudGlt
ZV9wdXQoJmFkZXYtPmRldik7DQo+ID4gKw0KPiA+ICsJaWYgKGlzX3RtY19yZXNlcnZlZF9yZWdp
b25fdmFsaWQoZGV2KSkNCj4gPiArCQlyZWdpc3Rlcl9jcmFzaF9kZXZfaW50ZXJmYWNlKGRydmRh
dGEsIGRlc2MubmFtZSk7DQo+ID4gKw0KPiANCj4gTm93IHRoYXQgeW91J3ZlIGFkZGVkIGFuIGV4
dHJhIHN0ZXAgdG8gdGhlIHByb2JlIHlvdSBuZWVkIHRvIGFkZCBhICJnb3RvDQo+IG91dCIgd2hl
biB0aGUgcHJldmlvdXMgc3RlcCBmYWlsczoNCj4gDQo+ICAgaWYgKHJldCkgew0KPiAJY29yZXNp
Z2h0X3VucmVnaXN0ZXIoZHJ2ZGF0YS0+Y3NkZXYpOw0KPiArCWdvdG8gb3V0Ow0KPiAgIH0NCj4g
DQo+IFRoYXQgc2VlbXMgdG8gYmUgdGhlIHBhdHRlcm4gaW4gdGhlIHJlc3Qgb2YgdGhlIGZ1bmN0
aW9uLiBPdGhlcndpc2UgeW91DQo+IG1pZ2h0IHJlZ2lzdGVyIHRoZSBpbnRlcmZhY2Ugb24gbm8g
ZGV2aWNlLg0KPiANCj4gVGhlcmUncyBhbHNvIGEgY29uZmxpY3QgaGVyZSBhbmQgaW4gc29tZSBv
dGhlciBwbGFjZXMuIFNpbmNlIHRoaXMgaGFzIHRvIGdvDQo+IHRocm91Z2ggdGhlIGNvcmVzaWdo
dCBicmFuY2ggeW91IHNob3VsZCBiYXNlIGl0IG9mZiBvZiBjb3Jlc2lnaHQtbmV4dC4NCj4gDQoN
Cg0KQWNrLg0KDQo+ID4gIG91dDoNCj4gPiAgCXJldHVybiByZXQ7DQo+ID4gIH0NCj4gPiBAQCAt
NjMwLDcgKzc2Nyw4IEBAIHN0YXRpYyB2b2lkIHRtY19zaHV0ZG93bihzdHJ1Y3QgYW1iYV9kZXZp
Y2UNCj4gKmFkZXYpDQo+ID4NCj4gPiAgCXNwaW5fbG9ja19pcnFzYXZlKCZkcnZkYXRhLT5zcGlu
bG9jaywgZmxhZ3MpOw0KPiA+DQo+ID4gLQlpZiAoY29yZXNpZ2h0X2dldF9tb2RlKGRydmRhdGEt
PmNzZGV2KSA9PSBDU19NT0RFX0RJU0FCTEVEKQ0KPiA+ICsJaWYgKChjb3Jlc2lnaHRfZ2V0X21v
ZGUoZHJ2ZGF0YS0+Y3NkZXYpID09IENTX01PREVfRElTQUJMRUQpDQo+IHx8DQo+ID4gKwkgICAg
KGNvcmVzaWdodF9nZXRfbW9kZShkcnZkYXRhLT5jc2RldikgPT0NCj4gQ1NfTU9ERV9SRUFEX0NS
QVNIREFUQSkpDQo+ID4gIAkJZ290byBvdXQ7DQo+ID4NCj4gPiAgCWlmIChkcnZkYXRhLT5jb25m
aWdfdHlwZSA9PSBUTUNfQ09ORklHX1RZUEVfRVRSKSBkaWZmIC0tZ2l0DQo+ID4gYS9kcml2ZXJz
L2h3dHJhY2luZy9jb3Jlc2lnaHQvY29yZXNpZ2h0LXRtYy1ldGYuYw0KPiA+IGIvZHJpdmVycy9o
d3RyYWNpbmcvY29yZXNpZ2h0L2NvcmVzaWdodC10bWMtZXRmLmMNCj4gPiBpbmRleCBmOTU2OTU4
NWU5ZjguLjY1NWMwYzBiYTU0YiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2h3dHJhY2luZy9j
b3Jlc2lnaHQvY29yZXNpZ2h0LXRtYy1ldGYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvaHd0cmFjaW5n
L2NvcmVzaWdodC9jb3Jlc2lnaHQtdG1jLWV0Zi5jDQo+ID4gQEAgLTY1Nyw2ICs2NTcsNTYgQEAg
c3RhdGljIGludCB0bWNfcGFuaWNfc3luY19ldGYoc3RydWN0DQo+IGNvcmVzaWdodF9kZXZpY2Ug
KmNzZGV2KQ0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiANCj4gWy4uLl0NCj4gDQo+
ID4gQEAgLTcyNSw2ICs3ODksNyBAQCBpbnQgdG1jX3JlYWRfcHJlcGFyZV9ldGIoc3RydWN0IHRt
Y19kcnZkYXRhDQo+ICpkcnZkYXRhKQ0KPiA+ICAJCV9fdG1jX2V0Yl9kaXNhYmxlX2h3KGRydmRh
dGEpOw0KPiA+ICAJfQ0KPiA+DQo+ID4gK21vZGVfdmFsaWQ6DQo+ID4gIAlkcnZkYXRhLT5yZWFk
aW5nID0gdHJ1ZTsNCj4gPiAgb3V0Og0KPiA+ICAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZHJ2
ZGF0YS0+c3BpbmxvY2ssIGZsYWdzKTsgQEAgLTc0NCw4DQo+ICs4MDksMTYNCj4gPiBAQCBpbnQg
dG1jX3JlYWRfdW5wcmVwYXJlX2V0YihzdHJ1Y3QgdG1jX2RydmRhdGEgKmRydmRhdGEpDQo+ID4g
IAkJCSBkcnZkYXRhLT5jb25maWdfdHlwZSAhPSBUTUNfQ09ORklHX1RZUEVfRVRGKSkNCj4gPiAg
CQlyZXR1cm4gLUVJTlZBTDsNCj4gPg0KPiA+ICsNCj4gDQo+IFdoaXRlc3BhY2UgY2hhbmdlLiBU
aGVyZSBhcmUgYSBjb3VwbGUgb2Ygb3RoZXIgbWlub3IgY2hlY2twYXRjaCBzdHlsZQ0KPiB3YXJu
aW5ncy4NCg0KDQpBY2suDQoNCj4gDQo+IFRoZSByZXN0IGxvb2tzIGdvb2QgdG8gbWUuIEFsbCB0
aGUgdGVzdHMgYXJlIHBhc3NpbmcuIEkgc3RpbGwgdGhpbmsgd2Ugc2hvdWxkIGFsbA0KPiB0aGUg
a3NlbGYgdGVzdCBmb3IgdGhpcyBtb2RlLCBidXQgdGhhdCBjYW4gYmUgZG9uZSBsYXRlci4NCg0K
DQpTdXJlLiBXaWxsIGFkZCBrc2VsZiB0ZXN0cyBmb3Igc3lzZnMgbW9kZSBhbmQgc2VuZCBpdCBh
cyBzZXBhcmF0ZSBwYXRjaGVzLg0K

