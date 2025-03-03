Return-Path: <linux-kernel+bounces-542897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40223A4CF32
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC98A3ABAD0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 23:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE8C23BCE3;
	Mon,  3 Mar 2025 23:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ZiwuNZ1A";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="F2LZbvuu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ruiNccgs"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA2522FF4F;
	Mon,  3 Mar 2025 23:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741044274; cv=fail; b=cHBGq5OSEyUo7uRZvNXW14hHxw+w9JiI62eA0PiznsZGWgLzKa94C4qfWAWEMOcBdTSNRAghZVQMVj4tT1X3Cj1RUIHC6P87P9ShPFOQCbYnvhd21YofXPOyzRhMJRsdvlvh9SEiMAESCELLbssbrQqYS2uUnVzAdxj+G4WpY/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741044274; c=relaxed/simple;
	bh=l+OaUfmWWmiLZcl0B1o1wr4cuchMnifgjiw4NEjAxI4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JVj5Xubw7C9IFY+OPU3jNEOtJsZVaSP299Jvjmho6gdKT0QrCsSrR1kn8QHPqQf+f0pKiwhclcbin1lWO3itSPaYAB5guyPAquCQ+5nbK7BG5QKPykrNTvtK7J0Bw4eeJPta22DHVUxmHy3CUtLmQgefKPx8w60bGCBnOM2rM10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ZiwuNZ1A; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=F2LZbvuu; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ruiNccgs reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523K9Nnh030754;
	Mon, 3 Mar 2025 15:24:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=l+OaUfmWWmiLZcl0B1o1wr4cuchMnifgjiw4NEjAxI4=; b=
	ZiwuNZ1A5DlnsWv0dMeVbZfQ+s4UStZi1ZAdr5cGQhW0vXxGv9u1C5pzf8CNQbfw
	lyPgOZqQ9rv0R7WEMCcLWG8ApX+jtmFnnW+21JX4NWb3EVEU/DMmHX+xAqRaBsec
	NTRKUhXn9I05nAYVl8ZHnlOd1EtvIB7s5r17Mhr/B4M8L71Cb6o5PhqYBCbW5cNl
	Ud+rdPqsLOGOcqnsCF6rE0w9dZMNzMsO/iGhKKu0vFHQqzm9ZpssOKXldD6UrIls
	NhrYeD6VJjHAbv+GDcXRIyq9xLXJ4oGGtn81lyZGyvBDjTJhn2c/3tY493cgmMGA
	lSdr8Oye3NwHC0R1BefXfQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4542cbb89n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 15:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1741044262; bh=l+OaUfmWWmiLZcl0B1o1wr4cuchMnifgjiw4NEjAxI4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=F2LZbvuu5UPYJQGOFCpmQ7Fb/IfdWVPNnGbt1/Ci4idkSI407XOfJbfdhq9tOBPDE
	 nwa8fFpH083EodqXtXPtiTuoX50yV3NVvaURtcEIy1wiGj28G+rfIdcuKl4pyCk6j9
	 vIdiclQwFDU/Eqta1Hctjh9ByY178+GYfkyGyMnXUw7tYH/iVxhUwSz+Tv0sH+YnkJ
	 7LdK9WL9zvJ2DFsJ5Uv0l1nCEqeN68AYJJGJ7/ovVp6LS5NQsAMVMy/5K5U8QLy8bv
	 lgEXnH1ymWEngXvNilk+logEqwFuaRMEl5r1Voz9JZvEgzBxbaUdWAi1Wk4CbvHyhH
	 rtWdi+/4ZFPmA==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CAC84400A2;
	Mon,  3 Mar 2025 23:24:21 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 4C3BFA00E8;
	Mon,  3 Mar 2025 23:24:20 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ruiNccgs;
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 328F840110;
	Mon,  3 Mar 2025 23:24:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jOV/ebEvn1nrl0G3sAOVdPTazHgW+1XAJVzSe3xWqsQ77+K1HkoIcMntDDcdeoXsfaiU4QF526uWV+64WbigDjChoig4JKbsjXWQX1Q8E7YHUwbRTX2qvalPv+qpBxZgLyyLVg0IaR6q5EXjrfqSWxA/Fo2QHlqQ2xvxsiOfHH5C2ZLtzJaWpM1MEpGMwu2/v81BnVe7qmVGHMe9YfHUqvcp+yRVV4ov0FqQNS7Z1pS5875caE850dPfsnDaLYIJ207BZ60GnvcZzbXtJNaJ92p1TzK5cQiCyJ2ndzRpdiR+ye00Pf6rQlKldyRIdBj3RDTcz67YHtEgZI3E9hIaFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+OaUfmWWmiLZcl0B1o1wr4cuchMnifgjiw4NEjAxI4=;
 b=Lg0P+wqLUPGMW4EELPFEK8T0aC6L8kg3Wwh93nATI6OAUgBhdxfXYUqcnRxQYwjTQk0KANc0IPPP1mDzhY5vFZUtyA6eReneLs5roinK2Lc4QAZsUp2U6iepfYiMLG4qP6pC0ycWy5U7/hBpf9c0l14AMr3fNnecs3ysZJOamEjnI0Gg3gOeiQOYNnJ8GSp/yGRNO86IPvVgu4lww/LiEWIlXkU2RC1ODlIAjvnR7HFYn7iR1GMWeYcQVJ0gtRLSLTnXXm0MWVbiYtDV8de4KvuDUbTjz7L4mP5YzhDrWFAqVKAsYrJSXU+3JEhtu0fnye1NYpb8HeYE4WySwxNBxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+OaUfmWWmiLZcl0B1o1wr4cuchMnifgjiw4NEjAxI4=;
 b=ruiNccgsZAiziSrOMUKujkvcWQ1i1gOCOlUkiwL14Xr/z5b2ggkGYWj9DJeNMYbN90FETRIM+N3I2Bz9BdYMTZmlq8MSIH+im2enXAhAFKcvbfD+J0ap2nCORqZBNxnFBcxXglZk1ewrTdhTJdDAfFspqn8zu6TILp9M/0LkH8o=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MN0PR12MB6198.namprd12.prod.outlook.com (2603:10b6:208:3c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 23:24:17 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 23:24:17 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Wesley Cheng <quic_wcheng@quicinc.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 1/2] Revert "usb: dwc3: gadget: Fix incorrect UDC state
 after manual deconfiguration"
Thread-Topic: [PATCH 1/2] Revert "usb: dwc3: gadget: Fix incorrect UDC state
 after manual deconfiguration"
Thread-Index: AQHbikHKWrGPeZu1g0qLO8oQEwQ58bNdhzCAgAAI+QCABIIQgA==
Date: Mon, 3 Mar 2025 23:24:17 +0000
Message-ID: <20250303232411.2sq47ohcygmwd2bo@synopsys.com>
References: <20250301003452.2675360-1-quic_wcheng@quicinc.com>
 <20250301003452.2675360-2-quic_wcheng@quicinc.com>
 <20250301020131.z7osit3xcqhwrl3n@synopsys.com>
 <109547e4-fc2a-42b6-9f16-6e0979b9a49b@quicinc.com>
In-Reply-To: <109547e4-fc2a-42b6-9f16-6e0979b9a49b@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MN0PR12MB6198:EE_
x-ms-office365-filtering-correlation-id: d1a44350-f1e7-4eaa-8c93-08dd5aaa84a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ODBjbmFBR0VIZUN4VUdreUtGdUt0NHhCUXdsRXRqSFBsRUU4TW5GRXpaNEpi?=
 =?utf-8?B?U2x5cUJDY09ZMHk1cnpSK3NVaE4wRGtiWHFGeE5hb2h2UXNuK3VPTW92T3dF?=
 =?utf-8?B?MjJScTFyb0d1aE1ZRWZtbTVvV2JIVmFHTGt5YTM1RG1wUldLais2T0ZaaWVr?=
 =?utf-8?B?SnRUQU9Rb1hsMkJWSjRJRFNFcEZxTWVoWWVhSmwyVndQVURhRGJpNWRrRE1E?=
 =?utf-8?B?MXdnU0dpZlRYNHoxajhGNEp0ekNrWE4wb293Qk8vS2Q0ZDNGVVo0NkxwOTM4?=
 =?utf-8?B?bFZEeXNNV2JYZDlPMDJjYkpZMkNneVptWks4VGhRZVNMN1BsdkhHSXlTRCtK?=
 =?utf-8?B?SzcyaGJyL2ZXRklOMHBaaG9NWHR4UHVxSVgzSmpnR3lrTlZwQjg4SlJaRVdO?=
 =?utf-8?B?dnUvcXVkaDB3d3JGVHhpNGtSY0xGSU1CQlo4N0NhVWJlOEloN2lmQXYxcmRL?=
 =?utf-8?B?cEhjViszK0xqeThoQW9ReHd0YW9TL1dLbGtneGYzZHZ1MG5USkR0VzdyaVlX?=
 =?utf-8?B?R1E0NUF2ZGROYk1Ja0VsOCtpUTJCejkwdFBaK05kWXlKdXJiZytjNmZFV245?=
 =?utf-8?B?a1ZTYVBGaFpGMFM3M2ZwZUl0YVFvMnNRdnkyVnh6MG5iMjJmR0diU2ZQbUVz?=
 =?utf-8?B?dkMrMzJyZjRmbXN5NjhFZ3F2cWVPbGtkYXNSWEZ6clNOTzJNR3FkQiszWnR3?=
 =?utf-8?B?SDMvM05rTjJuWVJPVk1zQjh6d201WWx0NG1HUFN4cXZ4djJEY0h3RkxhOUFv?=
 =?utf-8?B?dlgzQlNWSnR3ajhQNE1vM1ZpZXNYM2N1VFA4ZUJ6WHg0WW0vaVMxWFJSNkky?=
 =?utf-8?B?U0lmS2FEcVFnNE9IL3NuYzBOOUdEdG9VK3FHTkZpU3k2ckNsb0tqdFFiRi9k?=
 =?utf-8?B?Yy83Sk1NK2s1K29laG9qcWgzV3BPT2dMNU5UUldsV3A0NkluZ1dlUkxZQm1K?=
 =?utf-8?B?eURFOWpxL2Vhb3I5cy9tenduMHFlck1CZWJhaWxwTmpiYlQycDJTZ2JWS0pi?=
 =?utf-8?B?Q2lSalVhbU9yQWlLRldxVUJlS1JydmQzRzArYXUyWUc0emc4NkczVDhORVVa?=
 =?utf-8?B?UmpkeElmRW50ZzB0dGNTb1hwNmNGQlM3Nk13ZncxQ2pzdkl6TjNrejIyZG5S?=
 =?utf-8?B?YXpWUkJBc2pRbTluRWIyeThlbDE5TkFnMVZ0a2xEMGNsVFFLWHJ1aTlYYlVS?=
 =?utf-8?B?TTFwTVlsdHlpSTZkV05oYzV0Z3NLQW8rajNteHB2UmtORG0wQUNadmViU1hF?=
 =?utf-8?B?czVqUlBNVTRPaTZvUUU2dVRiTnFab0pROVpqaVdtaUR3ZFNzYXVmSnB2VEw2?=
 =?utf-8?B?bUU0NXFoNVNJZ2VOWlpUazV0V0xoL2xQV0xuZzBhdi9BaTJyTUF1MVdGVllo?=
 =?utf-8?B?M0dESWNBencxSURzek4zTmZSa1B3eWpCbzlQNWNlMXVMMUcvSEhsNmNSMEJK?=
 =?utf-8?B?aEcvN0RhK0x4akZzNFFUUlhMcytWNDU0QUJDekkyUzhPUnAwMWhiVi9RTTBh?=
 =?utf-8?B?Y0I0cDFzbVFBbU9CR1VRV0svV01oaWFJRkdock0rSWNvSWlmanA3Zy9qVk13?=
 =?utf-8?B?M0oxR1BsbGJ5ajhWS05KeHdDUkx0QyszdmVPTjZZM1QvcDNkWklhU2dmdlpj?=
 =?utf-8?B?NllwMjBUdzRtWVQ0OWY3dk5ac2JZTnR0VTlNK3dneGVJcHFaczIvcXJUUkNu?=
 =?utf-8?B?QXRJR3Z4MDRKRlV5bmxPTlBpeVZXUk1lOUlnZTlCUlUySm0rTWFrR3A2MWtl?=
 =?utf-8?B?aGgrRE05L3lNVktKemptS282a0hRRkVFdGxqYzNCbHdJdTlJQzcwSjNHWkZI?=
 =?utf-8?B?VHRwcUE1MVlkRUg3QmNleWIyTnNlT1BadURYWXg5OGhmNmplVVZyYml6aVNC?=
 =?utf-8?B?MUNYV1hxa3gvcGd6bzVyM2JBaEhES2MzUDlNQXlZWGNEWk1ObXpITUl0MUI0?=
 =?utf-8?Q?Ivs5AmLLr/UX1dYOuyatCWn/AClsPRx+?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bjRwR1BSMFdDb0Y5N0VJb2p4T2VGNFYwK0NiUnhBSDhjcnJJNVM0Y2hpUHZz?=
 =?utf-8?B?T0pWLzJlQVlFRWlnYVB0ZnZ5WTdvdnZEeXlUTjljclBSUlJ3VTBHVkRCVDls?=
 =?utf-8?B?V3dxZGo5L1pjSWNmcG5mbUxlcTdzc1RMcFFKckZGNWNDV2RQd3IxekNvNHo4?=
 =?utf-8?B?b0RaWkJnRnAvK0FITCswWVQxRmxkVHp6MHpXUEszUW1OdTZ4OXQvUDdqNjlu?=
 =?utf-8?B?elZzWVZURW9RY2FFVEpQeXRncW02QmFVZ2Y3WndZdUVIV05nbDkrNitoVGM4?=
 =?utf-8?B?cmxwQjdnS0g2T1Qzank0eDZZd2VOWVNqQ1ZrZTkvSzlUWThDMklMd0JqWTJj?=
 =?utf-8?B?WUxaM3FhMmt2ZHoxdTMyT0QyV0srVkEyK3JwNjdZV1pIOTZTVFNrdDVjNnBo?=
 =?utf-8?B?eVEyYlRlV0wxeHVaZ0pNS3FWQVhzck9mTjkyVVZiMEY0bGZHNXV2dWdDS0F5?=
 =?utf-8?B?Y0x1cy92ZTlGOXBRR1ZGdzBqL0ozcE5Nc3F1anNLa3RFWjVLNW1XcWFIUGg5?=
 =?utf-8?B?WlhnczMwRHdQVXlSb090Y3UyMS9YRWtXRGtBaEc5UTYyRGJJUUR3Ymwxa0hY?=
 =?utf-8?B?ay9ueVUzMkx5MHpyVVRjVUlQVzRmNW9ROC9iaW9ZK1lBM1FtYW5CTUpKbzZa?=
 =?utf-8?B?YnZUc2RXNmQ2ZTdUS3BpWkZ5RXVmN2VoQkcwQkc0NGJTOEJyUnRQby9aOTNz?=
 =?utf-8?B?R2crU2dRQStNbGtNQzRSS0JxSk82bitpd25pUm1tWGdpcEdjYkZGS1BMWFM1?=
 =?utf-8?B?Q215RVpZaXh3SDV2RFhzVzFNbnZod0hyQmYxOUltNkxBQk81ZHRPaTNBRlpt?=
 =?utf-8?B?SlBFWUxtRFdxOW4zZWs1YnRRV3o5QUhxbkw0TS9wdnVsQXJ6KzhkeUxKRndw?=
 =?utf-8?B?SENjR1dvVklFOEtJMFc4eU0xM1pxK2Z2MzNScEhkckNKYUx2c1JzaXpSUlhU?=
 =?utf-8?B?azJ6b0xzNEhTdVkzUGtyZVhhMEduak5Dekw0Yms0ZktYcVFzUnhVNXp3ZERM?=
 =?utf-8?B?cXpPeWNiWkhRS2NqUzdKVHdFaE1HdHNkVVh6d1lZVjJRYThKRW1PQU84aVZu?=
 =?utf-8?B?Sk53dFZJTGhnUjQzL3pzQkRBall2WGtCNUN4RzltWTVsaGtvOTJ2UEgwckZv?=
 =?utf-8?B?VlN6NXBFczBWNHRTdDlvR2xPVjd0MkR5akJkU3JFWHFMMDNLVHJHS2ZxdnBC?=
 =?utf-8?B?cUs2dFFkVXM2S0lzc2xqNys5NkVxMllTYjRTT2RKMExMMHZvWmliRytWSWZz?=
 =?utf-8?B?TFpKVDUyaGcvelRxZVp5OUgwNVhITTRRNHQ2VEI3MTlyMEdqSk1qQmR3cFVV?=
 =?utf-8?B?MHlmSjFDcTh0TzdGUUVVckdBNjlkendMUktJK0tyQ0JkcXFlYWZjVFl5YVZ1?=
 =?utf-8?B?MXNYVXByN2pLaEh5eGVGcUtUM3BwU1pienRIYlJvbk1NRXJBcjhDM3lia2hT?=
 =?utf-8?B?ZWFsVStTNjRabEt4Um9sZW4rMXJDTEszN1RiWWhiSStjMUt2aVBnSUVpdUZz?=
 =?utf-8?B?SmlkcHJ4eFJ0cVM4cU1zZ1U4TFRvVmw3Wi96QWlyVm1DSU5IT2JBWktrbjJz?=
 =?utf-8?B?R3JieGZtc1VNWllTTVlrYU1zY3lmN1RzWDJJT2w0bitpQ2RKbm94V3d4RS9a?=
 =?utf-8?B?cVJBRnZqNG8vUDEvZlQvWlRVOFBQYUkwVzR2dnVjVWFZMEx0L21Fdk5aMENU?=
 =?utf-8?B?dDNXVjhrck9vUXAyUGF4N09SM2NSamtpQmJhZUQwR0E5OWtYejJEeU5nRGtX?=
 =?utf-8?B?aVJ5VVpwQWhZd3lZRC9PSkI5U01JTzI2SXFvVlZnS3pNeG5RUTVMd2kzakR5?=
 =?utf-8?B?aTFObHNneTdQbjAva3ZhVm9sZTh1aXR2ZEUzMEY4dVZ4YmhLZ21MMnlpQzJT?=
 =?utf-8?B?MmtHRk01MmNnbWdqemdzdzYwOFNtc3BralcrbFgrNW5rR3JTbDcxMG90cjdS?=
 =?utf-8?B?ZTV5UVdPcm52SXdyck8xSmRWNGdzNVA0SnU4ajEzc0h6MERtOHgzQnB0ZmVw?=
 =?utf-8?B?RWlNc3JXWm9LWnBqckZMY3B1UnVoZm1pbVp1VGJRZDJ1Njk2Z0JWalgrY1FT?=
 =?utf-8?B?NjhNUnprT1BXeUZld3dMOVQ2MEpPb2hndk5IcDU0cmVudHJHMjdIZFQ2WTVi?=
 =?utf-8?Q?PQ8tjMstoTcE3XblrAWxxMQOq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0F93AC00F75484C849E72DE7C2C85B2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GeQVfGcjm40cfKdddOKhUZefcz7l16RjTvnmqXw+syoqIY0kPMpLh7Q6J4WN1+PnE7cm+W1pH5WHjlmpf8s8jnGkdFXeh29XzalgN9yBYomQD2lBPJqHLOT668MMEG9yBWunMHdLYp4AnlEBPN2T95zGrwEALzrk6D1hjpr0ejVJQvMsaagDSR9Yh5h8zYmIDvsrTR3mINULkAMBq7SmjX/90prHJrga0ADnkesTl6zoclf0wNBe1uHhHIywHxfQBmy1IzLs/lsrRg61gK5jpduKWDQdpt0wG1u3i0wJeCKGyKO9uf4w6FYdQp5EjojP7+wu5CH5yu78CByuQvH5zsGjtED8u7mHU/T7+y44FeXTe5YRG0dwKwyDyvWYNskUcSn1+7Tx/CE6evgNEHCjK+vJoBUzO4mOucxP9cuKknwt5XBC0FNfhQOkIBxub0pgrfpCEphzyeErCBpinlwIoPdPwek25OLEdSjkESaBRv04easf/9J32+2/paJqSaPCOcGe/uzDP+QJfW/0bgObhJgkHMxdT7ErXznZQYg76QP4HlLRLbA9pBBwO6kov6s3d1noki4JC3AkBZCTkREowqixyZlTbzzYBZpHXu230e1xTo50KquQ8S4KhzmZUpnrZYMjLlJU98XD1VGcR/n1Ng==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a44350-f1e7-4eaa-8c93-08dd5aaa84a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 23:24:17.1990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HvXIIBunsJ/CNBjAYIHy51SYHI39bXzoMBGHTnVfDNbIdy8p56nYIQIK0kFT24PMx5Ot0dZBcccoD1Vq43dXxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6198
X-Proofpoint-ORIG-GUID: ztz9GQvVSglZTYvykv-wtbmSgqqlJ8-j
X-Proofpoint-GUID: ztz9GQvVSglZTYvykv-wtbmSgqqlJ8-j
X-Authority-Analysis: v=2.4 cv=YeJH5xRf c=1 sm=1 tr=0 ts=67c63a26 cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=ax2VklKM5LG0LXg6rIQA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_11,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 mlxlogscore=999 impostorscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 phishscore=0
 priorityscore=1501 adultscore=0 spamscore=0 suspectscore=0 classifier=spam
 authscore=0 authtc=n/a authcc= route=outbound adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2503030182

T24gRnJpLCBGZWIgMjgsIDIwMjUsIFdlc2xleSBDaGVuZyB3cm90ZToNCj4gSGkgVGhpbmgsDQo+
IA0KPiBPbiAyLzI4LzIwMjUgNjowMSBQTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IEhpLA0K
PiA+IA0KPiA+IE9uIEZyaSwgRmViIDI4LCAyMDI1LCBXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+ID4+
IFRoaXMgcmV2ZXJ0cyBjb21taXQgMWZmMjRkNDBiM2MzYzY3M2Q4MzNjNTQ2Zjg5ODEzM2I4MGRm
ZmMzOS4NCj4gPj4NCj4gPj4gVGhlIGZvbGxvd2luZyBjaGFuZ2UgY3JlYXRlcyBhIHBvdGVudGlh
bCB1c2UgYWZ0ZXIgZnJlZWQgc2NlbmFyaW8gd2l0aGluDQo+ID4+IHRoZSBVREMgY29yZSBsZXZl
bC4gIFdoZW4gdHJhbnNpdGlvbmluZyBmcm9tIHBlcmlwaGVyYWwgdG8gaG9zdCBtb2RlLCB0aGUN
Cj4gPj4gRFdDMyBEUkQgd2lsbCByZW1vdmUgdGhlIFVTQiBVREMgdXNpbmcgdXNiX2RlbF9nYWRn
ZXQoKS4gIEFzIHBhcnQgb2YgdGhlDQo+ID4+IFVEQyByZW1vdmFsIHJvdXRpbmUsIHRoZSBVREMg
Y29yZSB3aWxsIGlzc3VlIGEgcHVsbHVwIGRpc2FibGUgY2FsbCBiYWNrIHRvDQo+ID4+IHRoZSBE
V0MzIGdhZGdldCBkcml2ZXIsIHdoaWNoIHdpbGwgbm93IGNhbGwgdXNiX2dhZGdldF9zZXRfc3Rh
dGUoKSwgYW5kDQo+ID4+IHF1ZXVlcyBnYWRnZXQtPndvcmsuICBJZiBnYWRnZXQtPndvcmsgaXMg
dW5hYmxlIHRvIGNvbXBsZXRlIGJlZm9yZSB0aGUgVVNCDQo+ID4+IGdhZGdldCBpcyBmcmVlZCwg
dGhlbiB3ZSB3aWxsIHJ1biBpbnRvIHRoZSB1c2UgYWZ0ZXIgZnJlZWQgc2l0dWF0aW9uLg0KPiA+
Pg0KPiA+PiBCZWxvdyBpcyB0aGUgY2FsbHN0YWNrIGluIHF1ZXN0aW9uOg0KPiA+Pg0KPiA+PiBk
d2MzX2dhZGdldF9leGl0KCkNCj4gPj4gIC0tPiB1c2JfZGVsX2dhZGdldCgpDQo+ID4+ICAtLT4g
Z2FkZ2V0X3VuYmluZF9kcml2ZXIoKQ0KPiA+PiAgIC0tPiBkZXZpY2VfZGVsKCkNCj4gPj4gICAg
LS0+IGdhZGdldF91bmJpbmRfZHJpdmVyKCkNCj4gPj4gICAgIC0tPiB1c2JfZ2FkZ2V0X2Rpc2Nv
bm5lY3RfbG9ja2VkKCkNCj4gPj4gICAgICAtLT4gcHVsbHVwKDApDQo+ID4+ICAgICAgIC0tPiBk
d2MzX2dhZGdldF9zb2Z0X2Rpc2Nvbm5lY3QoKQ0KPiA+PiAgICAgICAgLS0+IHVzYl9nYWRnZXRf
c2V0X3N0YXRlKFVOQVRUQUNIRUQpDQo+ID4+ICAgICAgICAgLS0+IHF1ZXVlX3dvcmsoZ2FkZ2V0
LT53b3JrKSAtLT4gYXN5bmMNCj4gPj4gICAtLT4gZGV2aWNlX3VucmVnaXN0ZXIoKQ0KPiA+Pg0K
PiA+PiBVbmZvcnR1bmF0ZWx5LCB0aGUgZmx1c2hfd29yaygpIGNhbGwgd2l0aGluIHVzYl9kZWxf
Z2FkZ2V0KCkgZG9lc24ndCB3b3JrDQo+ID4+IGluIHRoaXMgc2l0dWF0aW9uLCBhcyBpdCBoYXBw
ZW5zIGJlZm9yZSB0aGUgZGV2aWNlX2RlbCgpIGFuZCBzb2Z0DQo+ID4+IGRpc2Nvbm5lY3Qgc2Vx
dWVuY2UuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IFdlc2xleSBDaGVuZyA8cXVpY193Y2hl
bmdAcXVpY2luYy5jb20+DQo+ID4+IC0tLQ0KPiA+PiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQu
YyB8IDIgLS0NCj4gPj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQ0KPiA+Pg0KPiA+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3
YzMvZ2FkZ2V0LmMNCj4gPj4gaW5kZXggNTE1NmZhZmJkYTZjLi45MjFmNzI5OTVkYmYgMTAwNjQ0
DQo+ID4+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gPj4gKysrIGIvZHJpdmVy
cy91c2IvZHdjMy9nYWRnZXQuYw0KPiA+PiBAQCAtMjc4MSw4ICsyNzgxLDYgQEAgc3RhdGljIGlu
dCBkd2MzX2dhZGdldF9zb2Z0X2Rpc2Nvbm5lY3Qoc3RydWN0IGR3YzMgKmR3YykNCj4gPj4gIAlf
X2R3YzNfZ2FkZ2V0X3N0b3AoZHdjKTsNCj4gPj4gIAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZk
d2MtPmxvY2ssIGZsYWdzKTsNCj4gPj4gIA0KPiA+PiAtCXVzYl9nYWRnZXRfc2V0X3N0YXRlKGR3
Yy0+Z2FkZ2V0LCBVU0JfU1RBVEVfTk9UQVRUQUNIRUQpOw0KPiA+PiAtDQo+ID4+ICAJcmV0dXJu
IHJldDsNCj4gPj4gIH0NCj4gPj4gIA0KPiA+IA0KPiA+IEhhdmUgeW91IHRyaWVkIHdpdGggdGhp
cyBmaXg/DQo+ID4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vd2ViLmdpdC5r
ZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvY29t
bWl0Lz9pZD0zOTlhNDVlNTIzN2NhMTQwMzcxMjBiMWI4OTViZDM4YTNiNDQ5MmVhX187ISFBNEYy
UjlHX3BnIWMwLVhKT1FTVDhHX2pNUFJhVTBOeHNQNHpSUGt5Z0lkOG1RRXNVR3d4elFFc3oyWHVY
NEpzbmVzTVR1YUd1eVZnTjdoTm1ZSjNnZy1jVWVvd1ZaYUdfbTdEUDQkIA0KPiA+IA0KPiANCj4g
VGhhbmtzIGZvciBwb2ludGluZyB0aGF0IG91dC4gIExvb2tzIGxpa2UgaXRzIHdvcmtpbmcgZmlu
ZSBmb3IgbWUuICBCaXQgb2RkDQo+IHRoYXQgd2UncmUgc3RpbGwgcG90ZW50aWFsbHkgdXRpbGl6
aW5nIHRoZSB1c2IgZ2FkZ2V0IGFmdGVyIGNhbGxpbmcNCj4gZGV2aWNlX2RlbCgpLCBidXQgSSBn
dWVzcyB0aGF0IHNob3VsZCBiZSBmaW5lLg0KPiANCg0KWWVhaCwgYnV0IGRldmljZV9kZWwoKSBp
c24ndCB1c2JfZGVsX2dhZGdldCgpLiBXZSBqdXN0IG5lZWQgdG8gbWFrZSBzdXJlDQp0aGUgdXNi
IGdhZGdldCBpc24ndCB1c2VkIGFmdGVyIHVzYl9kZWxfZ2FkZ2V0KCkuDQoNCkJSLA0KVGhpbmg=

