Return-Path: <linux-kernel+bounces-289939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E84954D80
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FAD128467C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BB61BDA91;
	Fri, 16 Aug 2024 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="TpPZHELI"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2055.outbound.protection.outlook.com [40.107.255.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0C01BC9F6;
	Fri, 16 Aug 2024 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723821471; cv=fail; b=lWmxD1ZcZlrpnQpWnfpuONajnm+WXiG8YyEsXYGBFfZkRc2+H+pAdOFm//Mh+Ht6OiXVlgzKQAda7XTgn3oJD83wZID4gpcqwAOTLvbmJcQ1ISOmPplDVZS6+K8psbnUoqcBhO8qv7LpvaG1OXL6zOJIXaLaD8+xOdJb6b+NpTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723821471; c=relaxed/simple;
	bh=nfGfy9s832ccDLBtM/YbyBk4Toqlv45eREVrtFQJ7NA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mHmXn31i04RqDinAkuHGTUlXIk0UaSaQH0QvetJ7bt9T515CTszk53EQ23ixyff62F9G4HCxGIF4dtS+yiQufd4uuaSKwNidrvjNIEJEVJe78SMX9lPJ5fO38vBn7DUndiWWhAizxQBpXbklIsfzObFS3fdtRiZkHKnwtwV3b8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=TpPZHELI; arc=fail smtp.client-ip=40.107.255.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+tVRDfeI8h6dCXwHX20oe3XvggUXsC3Or4ERVdoB1kyXJ4Motrs1uwOZolkzl9lKBxgYW1gt60HSMYdhz1n3HqYuguziEt9B7W1tU2SspPk5C0f2l+wq0CizVQLc1HN+x9LsznREZmrbU+WimcT7Rt+coE3tT4sGjmzdEmtucD/RbvKfBiBb5NWiGnttPDoqL4OsMEHPeCxkuE18sNZnF08DSMV6iuRQIDZ4ecfaQO58dDgJ0PmPqx7akG5ksZYJyYEBac2mOrd5L+AtTMRNyZv3EyDKanKxZONoVqckFF1ZPutw+02Q5cGdgKTCARHCnrQP9CTWd+5LLd/pPL8vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfGfy9s832ccDLBtM/YbyBk4Toqlv45eREVrtFQJ7NA=;
 b=A2rkpPAwmBmqaliUfxvQeyAuTQ6NfKLY4AaJL0EcpDO6lNNjILMf3QEnfWDP8iTNzaDOJLDp5nPDDXNKM0iEAMq4GF1kGlIga/SXYcfQDH/e5yJPhUjMd53S/4Q741XlzacfAX1dauHY5je6V8w689KiUhxDmxpNk34koY5kRNULGOlzO2hz3cqWJsPm3shb5mQFdo0FL8lLcJ/AbA7GZNDzsXJZIdThKZ6efeQ3Eckn6mkMSd8yJfKPYN8JcPbgGBV7aCAzw+VV6EBtwiKJF78SaKktg8LjTQSMHc4dqZMrXpQOvBrusH8T91zlDAcR1/RN8BfLkBxMnsBGfjwFew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfGfy9s832ccDLBtM/YbyBk4Toqlv45eREVrtFQJ7NA=;
 b=TpPZHELIa5Cjd+3dXcMA+xIGs1/vMiesqtFmvOOBGmbn3ojEj/19Dd+9HWBSMXj2+ciDNT2RU7UUSvGnpKslb/bVR7gG84FvlJsFSuvGYEacHJhSg/lQj4Vbxo38Ljc1d9ttG3PNw+f0TBqbClVSfCuTJv9oGZQX661b65huUhUdv92LzUa/FvqDszpPLN+n4Zt77ja3s/nieBJm4OQpRhhjreITN8OmaSbbPXMOeyY4XRcJFKPtAOdGlpE6MvIAF8FlbAHLs9s+OWVWCHGBshh16zaqChdtsMXjdPjBS9VDEJTIYbaygI9zecjciMD3VWvkxVmev+g3Go7YRUTnhQ==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by SEZPR06MB5271.apcprd06.prod.outlook.com (2603:1096:101:7a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 16 Aug
 2024 15:17:43 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%4]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 15:17:43 +0000
From: =?gb2312?B?uvrBrMfa?= <hulianqin@vivo.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
	"quic_prashk@quicinc.com" <quic_prashk@quicinc.com>,
	"quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
Subject:
 =?gb2312?B?tPC4tDogtPC4tDogW1BBVENIIHYxXSB1c2I6IGdhZGdldDogdV9zZXJpYWw6?=
 =?gb2312?Q?_check_Null_pointer_in_EP_callback?=
Thread-Topic:
 =?gb2312?B?tPC4tDogW1BBVENIIHYxXSB1c2I6IGdhZGdldDogdV9zZXJpYWw6IGNoZWNr?=
 =?gb2312?Q?_Null_pointer_in_EP_callback?=
Thread-Index:
 AdrvzihtFNSOcxRwTAOIHI6tveAOMAABV00AAACqLAAAAoTOwAAAUcYAAAD4WnAAAUYXgAAAwgzw
Date: Fri, 16 Aug 2024 15:17:43 +0000
Message-ID:
 <TYUPR06MB6217D1798DBC41C7DB2A1DEDD2812@TYUPR06MB6217.apcprd06.prod.outlook.com>
References:
 <TYUPR06MB62177737F0054278B489962BD2812@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <2024081608-punch-coherent-d29e@gregkh>
 <CAOf5uwnsgcJjp1=RLa7qx9ScQY5rZvwX-Zu6BOqxBBhBCz+CFQ@mail.gmail.com>
 <TYUPR06MB62177BCD4AB43C19E38990D3D2812@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <CAOf5uwm65Cw-V+td_=6QAGUF+Uisueqcm0z=1zFaNTisAJnSFQ@mail.gmail.com>
 <TYUPR06MB6217877B31A08356241CAB38D2812@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <2024081652-unify-unlucky-28d2@gregkh>
In-Reply-To: <2024081652-unify-unlucky-28d2@gregkh>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|SEZPR06MB5271:EE_
x-ms-office365-filtering-correlation-id: b3d4f15b-f495-448f-3a6f-08dcbe069388
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?RFR4WGlSQmVkOHdkUGtJdXZXOEhJL1ZaUCt2SFd5SVk4WXNWYmpTNFpqcUhv?=
 =?gb2312?B?TnRXK2UvWVZYOTFDRmlzREtkUWp4NWJVNkY2d1J3cDlpZkdEaVJzdWZDOUpO?=
 =?gb2312?B?aEhQVmM1OXFuTDRsWERLcmZXdjFOclI5Z1hCNmo0WEVxWG5ta0dBWHBobjY3?=
 =?gb2312?B?N0RvTEY1RVVoM25RUVlzNXdZaWxkYnV1VDl5ZHdKWEN5b05MV29SNGUvNHE3?=
 =?gb2312?B?WmlvakJCS29jRlhkU0NNc1h3SG1xWUUzZVFibTBLZEluLzh4cTlHYWpLM0NN?=
 =?gb2312?B?cHlpeHR3NWg5OHNrdHBva0dzc3N4YkorQkNUVko3R0NZZnJQOEhMRXJWM0JU?=
 =?gb2312?B?Y0h2amR2ZURnK3JnK0xBUlkyd0s2WkgvQUJLcGJUbi9RL3NhVUZhODdYaHJX?=
 =?gb2312?B?SnlFT0plNUVxQUhnc0I2ZUJkLzdoWW1kb2FoSXFEQVlLTnZXWEJtUEM5QUVj?=
 =?gb2312?B?OWZhTzJCQkcyNjJoVm5qKzhDTDQ1NlRLK3E0YTNydUNKUkRGeXA0aG1nV1h3?=
 =?gb2312?B?QUd3QlFMY2tJSDVaV2pXWTYzRVNDQkxzZ2x1RjJqNFlFbTBvSVpGcndZb3I2?=
 =?gb2312?B?b1F2OHJkclc0Ry81QzRyREM2K0srVlNGMFlOejBpUDQ1dUc1MXlDcmFKOGJk?=
 =?gb2312?B?ZGtZcGlYL2ZJUHo0K3JaVTg5ZjU0UFdwSTBxV0V1VU1HMHBoMWorYzVVOHhu?=
 =?gb2312?B?blM4TnlPeTFUanNraVBzdVc2RGRKQm4wcjhmVEllRUh1bEpOaDJMZEFzakZj?=
 =?gb2312?B?YmllTFRiSklnSG1nVGhoUzBncmJCSXR5ckZwakpSV3hxeDV3TGhWOU5vUita?=
 =?gb2312?B?allnOW5ONHNEbkp6VlFCcmExc3R3U1J2YmhUczZhUVJnNWRZZEVXbG1SV05r?=
 =?gb2312?B?VVpsd1hvQm5Ic2FPZFNlMmNSWWpaY3NLbVlZNjBWUis2Z3Nub3ZMVFFjR0Iw?=
 =?gb2312?B?V3RUY29vakpRMWdNbmtqbm41Vk1NcDlCa0JxNG0vd05aOEdKMU9FdWpwUXN3?=
 =?gb2312?B?YlJpL2RqaWNjRm8vcm54c0ZyVFpLRTBueXVwdjgvZlVTVS9rNGhBVEoydmVz?=
 =?gb2312?B?Y3Z3ZDc1WHR2RUVJeUNFdkp1V2lTRkJadVVUYm1CT05INGlIbk9JVDdnb2d0?=
 =?gb2312?B?ZnBBRlBDZldvS0dHRDloWWtEeERlNjM5ckg0V0tKZWI1SHR5a3VJVUd4bktQ?=
 =?gb2312?B?emZmRzF1a25WWUJocDFPa0ZWdTFucXFoT0pNSy9qRFhZSEdnWklhb05rVFhL?=
 =?gb2312?B?ZEkwTzdTVXIyZkFwSWJScEZiem1iejV2eHYrcjlyK2FTN0xCaUp0NFBqNklj?=
 =?gb2312?B?VXJKcXMvZHN6ODVpdHJNam92a05ZVHZBNzZkZzNteDdxYW8xWWE2TUFtckV2?=
 =?gb2312?B?WW9NZ3hhbXVXWmduQmFHVjBFQ1cwMnYwM3hKVG1CWXN5U2RlT2dsc1RsR1RS?=
 =?gb2312?B?VllrTTMrMGpPRXVZZng1TzNwVnFtUXJUZ0lWK1IveU5VdDhTOEd2MUVXOVV4?=
 =?gb2312?B?eFcwbm1xWi9jcmVGRXhxRitrZVNkdGdEVmgzQmJ0bUpwYzkwclFhemlIWFVH?=
 =?gb2312?B?bFRPOUNnZmNSRmIveU5YbXBTMDZ1QTFaUjFEMllTU29zYUdyZDZseFVsd3Jj?=
 =?gb2312?B?eFRLck9mdXVnYmN6WURkUXd4SURYMWZSZDFrY1RHODZrWWdDUG91bWw4OW0r?=
 =?gb2312?B?K2xXQi8vY2VPQ2YyV0dINEFJMzI0ZkwzNS9zODlEVWlWZkxPT2tsTTRVZkdB?=
 =?gb2312?B?dE4reFdybW5POW5DNWFVL2Z0OHV4OVg3RmtvMzVaNlNBUVYwS2RsMG9JUS9o?=
 =?gb2312?B?QzA2TkgrSXFwM3M1bHExVE1ocTRQZWhEcnlzakRFWlN4REk2dTJ4akxoano1?=
 =?gb2312?B?dVQ3NFJLMUxraEVrUTdBZll5SVl1NmVXSjJFamZYNFU2c3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?M2t5Y2MreENGQ3FtbjhvV01CKzRXTWhEdDFPR0k0SU5uQkRWalU0R3pwS09Z?=
 =?gb2312?B?T2ZYbHRqNmFxTk5HVFJmbUpoUHNlTzJzMXp4RW5CdHBXOUtqSkVlZkRIK2tY?=
 =?gb2312?B?NE9HTXNmUG02bTVLN28zbkZKYmtqY3VxMDRwT2xiV1g0cW9DWm4zVmh4cEhh?=
 =?gb2312?B?ZmRjVm56MnlJVjlRMmEvbE1obUFVYVl0Tkx0RDFYRzhDbXFzMnpWL3lBVzM3?=
 =?gb2312?B?TGthVWhWMVA4SHlNUi9xdldWUlJwdVg5QTc0Zm84UnVhT1ZMRHNGOERCWU9W?=
 =?gb2312?B?RFE4SUtWcEFDMmpXL1ZXZk85clNXNm13U1JBR0ZRN1o2MUhxTzV6QTF2YmFv?=
 =?gb2312?B?M3NYYzduS0VINnFNT2gwNkZyRjNPM0Y2NWFoaGhnSmdZdGkvZ1JWSlJNZzBY?=
 =?gb2312?B?R0F6V0N4Lzh4cVRjOFlPRWE4V0c0VDVsQ0o5UXBNM1lNTytvczBIYnFmQ1g2?=
 =?gb2312?B?eTc2cjJla25SM0FkMmFSUzdreC9zWDhjQ1crYU9CYzBETzNVVndudGtSem5J?=
 =?gb2312?B?T3RQMDNYVXBGUVRRS3Q3bVNWclpPWWVaTjBpMmxtUHQ2eEc2RXBNdlUrVUF5?=
 =?gb2312?B?OSsxclNNUGNFOVl6UFk3d1o4ZmIzYTJvZ3R4TEtxQ1RsL25tRVVmNGVyYjNZ?=
 =?gb2312?B?bHNCc1F5aUhFc21kTjhRK2dHOVNwdWt0Y09RNTBDaCtyY0t1QW9walA3VzU4?=
 =?gb2312?B?RDVqVEMzQ0l4TlR4Z3hJYTJxb2NLTXlUMUcrSzJnR0dZTTdzWHhhbmZWbzUx?=
 =?gb2312?B?Tkt0Y1Z6K244OHV1SmZkcjYvVkhsMmIwV0NYZndiTGNXVFZ4RmMvNE5FM0Fh?=
 =?gb2312?B?M2NORnk1SkIreHpjZFkrNGEwSHBjQXlVRVFPaTRpN01Zdk9taVVaVGdlU1l2?=
 =?gb2312?B?WXpTemFwYS92UkRTTkdUVkZEYm1OZmFLanRLRHViVkNXaUNEVmFHMEg0MGVW?=
 =?gb2312?B?L1AxWXYwbWI0Y3ZPOHVQQXJCODVBMWUwR0hGUHR4eDhuRFR2RG9HRWM5RDhP?=
 =?gb2312?B?WGpKTE1oUExqaTdEVlkwN2pEZzJJV0NuSmRqaWNpKzgrUGF2YlFyWWxzTlk2?=
 =?gb2312?B?dmxhYThvb3A3cThONmtVVXp1NlRTUFRIelUyRUhDVzR3cVFTZmVONTNUVDI1?=
 =?gb2312?B?NU4vQVYwaW5qWHpKTGY0cmxEa0JyajJLSmRBV1FuTXFiV2NkNm4xZ3lBVHln?=
 =?gb2312?B?S3RuQTc2M0RjYXk4OUJJd1RnOThhSVFndnpjbGY5SndibnNURGwwMEttdzNZ?=
 =?gb2312?B?Sk1QZ0FITGJtUUIrUjJ1TTNhZ2RBU28yd1FXaEU5emhwRFBrWlFKTHZtTWt6?=
 =?gb2312?B?QXdYcldCRUNVM1Q0aWNoaHg4eWZrd0ltbGo1UlIzVWdrWnZrMVJhbXM1SXNP?=
 =?gb2312?B?NE5UYVRBN2dHcnZUZFAybXcrRzM0SEpFRnlMTE5TV3RyOFBjYU1zeko0WnFv?=
 =?gb2312?B?ZVppUmFqN1JsQSs0QUxkZHJtWDJzbi9rTjZYd1NlS3Q0a295cTc2UDZOdzh4?=
 =?gb2312?B?dWcvSCs2YkRqdkJVVU0rblBmZFpKV0lQM0hxTVpsbTNDUEo3MzBGbXRjTENq?=
 =?gb2312?B?TC8vWnNqWFhoTDNOQk4rRUV5dEN0RXJEaHI3c0hEQkErMXJZdmdnTW5ub21L?=
 =?gb2312?B?eXZhQllLK0Vmc1k1OW9zZFcrT2tYR1NoUHJ1QUU3dk5mNnVLSGx3ekFQYXV6?=
 =?gb2312?B?WFFiQkN0dHFCNDFWNWNnclhaU0k4VEJJRlRnVGdDQ1NHbjFpZ0NYWFdMdU1q?=
 =?gb2312?B?S0c4L2QzMndIRXBPZ25aMkFTSDV3bEdCbUZiWmh5aGFWT3VKRmFVUXYzbE5j?=
 =?gb2312?B?c2E1VlpjbkV5TGxtdGpxV2RFN2dWYnNxN3NQejFlalgzUEJTT2FRc3FLU2s0?=
 =?gb2312?B?cW9mbi9hNmlQdE15QmtwZmpGNFdPR09Pa1ZPemlMTFhJMCszTk14b0lEWTZK?=
 =?gb2312?B?dm16NDIrdnJaOU1neDBPZVVUb0hyeWRjZ2RRaFgzUzNyeU5WbmhYZVFSSG1l?=
 =?gb2312?B?d3dqc0d5TFFYdmxrekRZU09zNW9mT0FZMUoxbXdRaWtGYWRNcjFYajlwS0p0?=
 =?gb2312?B?K0ZPM3k2M05ETmRNMDhHdXJtMnlzeGJDVzNuNnZ2QnR4MWw3SFNRbm4xTGJy?=
 =?gb2312?Q?rqiY=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYUPR06MB6217.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d4f15b-f495-448f-3a6f-08dcbe069388
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 15:17:43.3778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c3IqLOIiir/l/euNEYrz3XZNnYRB3gBPcKK0OQxTuguZ8BTMnsAfof3AibKiIDozq/52RA92kO3lzJki1ZgSwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5271

SGVsbG8gbGludXggY29tbXVuaXR5IGV4cGVydDoNCg0KPj4gPiA+IFE6IEFyZSB5b3UgcnVubmlu
ZyBhIG1haW5saW5lIGtlcm5lbD8NCj4+ID4gPiBBOiBZZXMuDQo+PiA+DQo+PiA+IFlvdSBzaG91
bGQgcmVwbHkgd2l0aG91dCB0b3AgcG9zdGluZyAocmVmZXIgdG8gWzFdKS4gSSdtIHRyeWluZyB0
bw0KPj4gPiBiZSBoZWxwZnVsIHRvIHlvdSBidXQgaXQncyBub3QgZWFzeS4gVGhlIHF1ZXN0aW9u
IHdhcyBpZiB5b3VyIG9uDQo+PiA+IHNvbWUgNi4xMC55IG9yIG9sZGVyIHZlcnNpb24gb2YgdGhl
IGtlcm5lbCwgdGhlIHN0ZXAgdG8gcmVwcm9kdWNlDQo+PiA+IGl0LCBhbmQgaWYgeW91IGhhdmUg
YW55IGF1dG9tYXRpb24gdG8gdGVzdCBpdA0KPj4gICBUaGUga2VybmVsIHZlcnNpb24gdGhhdCBo
YXMgdGhlIHByb2JsZW0gaXMgNS4xNS4NCg0KPldoaWNoIHNwZWNpZmljIDUuMTUga2VybmVsPyAg
VGhlIGxhdGVzdCBvbmUgb3Igc29tZSByYW5kb20gQW5kcm9pZC1wcm92aWRlZCA1LjE1IGtlcm5l
bD8NCiBBbmRyb2lkIDEzLTUuMTUuDQogVGhlIHByb2JsZW0gb2NjdXJzIHJhbmRvbWx5IG9uIGtl
cm5lbCA1LjE1Lg0KDQo+RG9lcyB0aGlzIGFsc28gc2hvdyB1cCBvbiA2LjExLXJjMz8NCiBLZXJu
ZWwgNi4xMSBpcyBzdGlsbCB1bmRlciBkZXZlbG9wbWVudCBhbmQgaGFzIG5vdCB5ZXQgYmVlbiB0
ZXN0ZWQgb24gYSBsYXJnZSBzY2FsZSwgc28gdGhpcyBwcm9ibGVtIGhhcyBub3QgeWV0IGJlZW4g
ZW5jb3VudGVyZWQuDQoNCj4+ICAgVG8gcmVwcm9kdWNlLCB0dXJuIG9uIHRoZSBjb21iaW5hdGlv
biBtb2RlIG9mIHRoZSBtb2JpbGUgcGhvbmUgVVNCLCBzdWNoIGFzIGFkYitkaWFnK3NlcmlhbF90
dHkrcm1uZXRfaXBhK3NlcmlhbF9jZGV2IHdoZW4gcnVubmluZyB0aGUgbW9ua2V5IHRlc3QuDQoN
Cj5XaGF0IGlzICJtb25rZXkgdGVzdCI/DQogUnVuIHRoZSBhcGssIGFuZCBhZnRlciBpdCBydW5z
LCBjbGljayByYW5kb21seSBvbiB0aGUgbW9iaWxlIHBob25lIGludGVyZmFjZSB3aXRob3V0IGFu
eSBwYXR0ZXJuLCBkZWZhdWx0IHVzZXIgdXNhZ2Ugc2NlbmFyaW8uDQoNCj5JIHRoaW5rIHRoaXMg
aGFzIGJlZW4gcmVwb3J0ZWQgcHJldmlvdXNseSwgYW5kIGRpZmZlcmVudCBwYXRjaGVzIGhhdmUg
YmVlbiBwcm9wb3NlZCwgaGF2ZSB5b3Ugc2VhcmNoZWQgdGhlIGFyY2hpdmVzPw0KIEkgaGF2ZW4n
dCBzZWVuIHRoZSBwYXRjaCBnaXZlbiBiZWxvdyBiZWZvcmUsIEkgd2lsbCByZWFkIGl0IGNhcmVm
dWxseS4NCiBJIHNlYXJjaGVkIGZvciBMaW51eCBtYWlubGluZSBjb21taXRzIGJlZm9yZSBzdWJt
aXR0aW5nLCBidXQgSSBvbmx5IGNvbXBhcmVkIHRoZW0gYWNjb3JkaW5nIHRvIHRoZSBjcmFzaCBz
dGFjayBpbmZvcm1hdGlvbiBhbmQgZGlkIG5vdCBub3RpY2UgdGhlIGZvbGxvd2luZyBjb21taXQu
DQoNCj5TcGVjaWZpY2FsbHksIHRha2UgYSBsb29rIGF0Og0KPiAgICAgICBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9yLzIwMjQwMTE2MTQxODAxLjM5NjM5OC0xLWtodHNhaUBnb29nbGUuY29tDQoN
ClRoYW5rcw0K

