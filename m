Return-Path: <linux-kernel+bounces-409766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBBE9C9119
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEB7A28486D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BEC18BB9F;
	Thu, 14 Nov 2024 17:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HgFRjUaM"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47C2175D5D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 17:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731606529; cv=fail; b=EyJbKHMlcW7dZcuG8xpGNdAXns2ldxtjfqm49wgx2TVJ7W5NI9QB+JYpUWnuf8SuoRk3IeKc3IQzSdmrhiSCPYUULJ+3NNkVwjKrw6R4rsIEuJ2stxMlcHaDEJDMgVLycOpLAmEy8MWUU1l7AvVHikLDqObkMo/qLdh+EBef46w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731606529; c=relaxed/simple;
	bh=gDnJj9Zzy5k2s7OW5HxjUC5NZK+amBgbkYFXQFHWlVI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ILAw0FQ4VyuDvtF7BEC7DgRmo1DpYbEbOyAWVrVhC7jS2v+QKgFu7DGQOS6fK/jQBpeKU7ozBR5BUbw+Qb3zMdoaD91MfUC6+NDgeprJzlKJBZ8TL2e3/bAsk0MP47IB2c1QQ6vwc96MqNZr7+9/K/IPxMFBUCcLeqv1cLKqW4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HgFRjUaM; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AlCcoieS9Xdf5E9gc0NvRkXgG76PY1bI5fKd3bF/PTISlW/MkDy0WL5sTKcTHJvhapszn6UBRuGeXMcAtXa2zk5p2FB3TulhYxzHXQFfOpEanyKWiSA4JpFjQjB7LpWTjL/JnSgs6NA98881Zjh5a1twxupjm1T15R8+DhrMgHIuIpUdq4qgWvkfHH7X8cDmFZSk9JxKysPX9ITa2CgZdmHzoveeXM0oZaemXMaz17RPDQpPOec3O4pG58AbR8VJ8d+7JV5PbU5Hj1UojeqVhnEGfoka2Zikaz95Nwsa6aWxra09ZgpNdjCetpp09Awa+eO2RzcBdxzdPKnEw4Gs7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=po1/yM+OElifQbkOKm+DbtlvZhpqjimHNran6j76QGg=;
 b=fjy7q+1xdizvdRBIDY3EkXtB3UR0VgbISZQeuOtsbvpu+V3OWdemD30wU8Nl1h8IY3iAffRbac+EI3HlQAFx3TXx9JDzuAqz3fgWimAukoTZdA127fphfVAd9sfg/gQ1SBA2Jy93nYpIzL8QRZ55yPm1rejsqb3tFonxgnQsF7zI6fTLowSrEQYi7WISrerz9ppVH9vOxVfA6CvtDiSak+FHT0obeYSHRvkZJTcrcelo6ZhH+p9LIlf0soLs5WwuI821tqw8W2iySsRrKeANBxKeJB7JoboeIrWOKFuaR7XIvEMoI0zfDaJOj9rCNlRAVq5u5qHSicVsQet74TKM0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=po1/yM+OElifQbkOKm+DbtlvZhpqjimHNran6j76QGg=;
 b=HgFRjUaMH4SaeZRHDVJwRaYHyQ7CHs66B9aPdkuAjDr1suYbZ9NWFaMs3MyQ9kYGzAtgK2zAwFtv/3P1VPpsJsiGO0J5OIlFDZKqBEzfervPWHi58qYG+sUqo3uqk7sCgOFLay/nZWVvkdOQ1kyV7jHaCvukyK3o929CUSDsWqs=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by SA3PR12MB9107.namprd12.prod.outlook.com (2603:10b6:806:381::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Thu, 14 Nov
 2024 17:48:40 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%6]) with mapi id 15.20.8158.017; Thu, 14 Nov 2024
 17:48:38 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 11/35] x86/bugs: Restructure spectre_v1 mitigation
Thread-Topic: [PATCH v2 11/35] x86/bugs: Restructure spectre_v1 mitigation
Thread-Index: AQHbNmJz5HBORjzra0GiYVanrEde3LK26EbwgAAjw4CAAACL8A==
Date: Thu, 14 Nov 2024 17:48:37 +0000
Message-ID:
 <LV3PR12MB9265442FE51C215C7AFE7B75945B2@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20241105215455.359471-1-david.kaplan@amd.com>
 <20241105215455.359471-12-david.kaplan@amd.com>
 <20241114064001.v6ogsiaptrh6oixc@desk>
 <LV3PR12MB9265747DB95F1F54E826A971945B2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20241114174115.qucm7lwbfiavodyh@desk>
In-Reply-To: <20241114174115.qucm7lwbfiavodyh@desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ea558512-ae76-4749-9848-6f1b0738c043;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-14T17:43:11Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|SA3PR12MB9107:EE_
x-ms-office365-filtering-correlation-id: 4bb8ea20-7e52-438c-ed88-08dd04d491a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?SzfeRFQYOmW48Z1kND1OujtNROm4zSw1T3/Lg2B/diW4ZVCR2IL4w6CeYLJc?=
 =?us-ascii?Q?rbDekpQfl02wLWE1t4KR4+AHKHBBINCoOmFtzX6CNYM5xfLY8/EyY+7tC6pK?=
 =?us-ascii?Q?WGGHwdhlEPphbessQGpQvWGTd6pvNXmKiBXlVIdRcygCw2/sFjkxewsjdvON?=
 =?us-ascii?Q?nlWMWtDTFM/STx3He0q1cGvTWIFMg1d88p5b4153JEvXo6vuxHekx+1fzvRg?=
 =?us-ascii?Q?miFDz2zu3AHpMR8+TDTNbnJxB1kLonccA3o9s/00jhY2ukMA8wjmwB5oEwtz?=
 =?us-ascii?Q?SR1NKUr4OuW8s2PYkk1+Gz0I7ZDbxmkidl+jeV9wC56dwoVQNtqwptsnGSBQ?=
 =?us-ascii?Q?ohJMe1/n7qTP49y1Ck3AeFO9oVI+rFwNVYwr3nirpcXPRfjHEa6TowxrnJ19?=
 =?us-ascii?Q?vb+6Euaklng37kTUHZgbpq/+D7cEjvsYC+Ns3+YHDRapLroDxCLVTTfjxIB7?=
 =?us-ascii?Q?meob0mDq2MVzDW8Qdiimd+f2IdEcQeMst/Pvcsq+eWQ8+IZPOf1PyroUGqXt?=
 =?us-ascii?Q?QEL5rBBwHtCpDYQmlMbqxbdWriO7KEMLH/oDFiES4o9nNaiOfe06R+vDr3LO?=
 =?us-ascii?Q?bnPVaoTyCFCVLEZXc5U0n9DE/XQNxlNXBPOHm74T9KBr02y9wZMRQUNwjn/l?=
 =?us-ascii?Q?sq3h483SPiSH/ari1h0i3d7uPqQo+g9QhnEvLYr48IS0d52bJ0gX26+yP399?=
 =?us-ascii?Q?U4czGNsaMOaCTLT/iHJludsQTtwpRVqpH0EJfGRn9L/qn+GM4QGc37FweOpb?=
 =?us-ascii?Q?E9pPqEtWQYZzisGkK2KGRVDGAsToMRVFdonT5zjrVypncc2C6WpV6oKU/7kz?=
 =?us-ascii?Q?+UCkFR40dApl0spP0bPkCUpKXbUvWU3vRXjtqieyS3BWp+YwIFUJ92KQ3LKP?=
 =?us-ascii?Q?Issm9VHTi5QLyK6biEFG+ZLG1lOL3yh9VvK/xn0VZP4J84HAUHb27gXOtw5o?=
 =?us-ascii?Q?DGHJwvv2UbDkalg6nC2DC2+QXoObRs1amkMfvPMdNCjaV9FCz1sekP0hgf3T?=
 =?us-ascii?Q?QyBtMIjNhNPC45s5EEZwJf2kxqkreL+zAemMvuJor2a0Ao3zhMkk/xqBA/Sk?=
 =?us-ascii?Q?9HeUROeeZheTED8c3fSFTNsZ/LAWkNzzq1y8QctUgB2KORBTwUTpNMLbqBSJ?=
 =?us-ascii?Q?Qnr0WeL6lMRtOXYfhEzMQ/f+gy7UUvIGtgoLdHPa4fSVNQuyeB7G2AXRKw8+?=
 =?us-ascii?Q?97V3V1jf9JboD3bZjFKhQFAPhaOE+HXzmWTrh1hvCSkRWfjBlxeAEFy7aNxF?=
 =?us-ascii?Q?aHR4gLU3ULkzBWMmpXKxrMC+1e1/OoROF8NImTFYcRLIo0cBlCrWQl0+n9JS?=
 =?us-ascii?Q?k7XhAwPK4e0ASuJAmMWw5qygmgU8zC7xcyynyNsnHmQYkbt8E/WWdj8JiaHq?=
 =?us-ascii?Q?Nj/fzs4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JAk4xQWuR7VqApANZLN0RK8RzBW9ki7Fr00XjOwJYzNAqhd7z5G5gsNMVl7Q?=
 =?us-ascii?Q?E6KOpsilxevou466y25h7Kfp70MVsX/w7HUsjNIq/4ypghIslgBmN2Mr2IGz?=
 =?us-ascii?Q?/g6dCkEugoL8IqICpdh35IoDmvy/SEnz7xUgg0CvhNbpr3K1BNA48KC3HiK0?=
 =?us-ascii?Q?xXJvpgJNrHhvnTuPTetkcfVmT/+hqurnYwBqwHYw9Si0411MKU0aJEAOfoow?=
 =?us-ascii?Q?O7mkJOU28Hr6fH1dGb0H/5Ou9nqGroGI5P9YGdrdDe+guPPGniJEhVDpfgP7?=
 =?us-ascii?Q?o2w0N+DHfmWQgGc9KyqMx3I6KUgkDHboda2HJUZXFnXmkmiXbaogHy6ejeYl?=
 =?us-ascii?Q?F7d/pFp9vB7d0t4g3TK5Y0v6ACn3cdp+KvpkpE2A9ndnSQpaEFsDqO/dbBrN?=
 =?us-ascii?Q?DLwaTuQ81MeJlc/FYyUbpbyYweIq+dXmDuiKcFre5G8Rzii+UhK90u1QarM7?=
 =?us-ascii?Q?yz+NV35x9NOmDSGJjfE3HMWiEYf7InYGVrrN2kUhJLnNvMNM8Jp8nwSmHHZe?=
 =?us-ascii?Q?4E7WoHQY6342GjquxZdW5K/hZFSGfQXbjVM19yk0Q/3tXAaWccORc3wCXKor?=
 =?us-ascii?Q?ugCqDjIteSK6SwGxcyPmRKdeJAGslTqVt9xFa8k5IVCQoOLyH4EmMzQtyt0E?=
 =?us-ascii?Q?aGeTC9rucZmo1QGwJPzzmZiaUJYbD48Fo+OMX0ppgmz68bwlFKaTaKmxkelU?=
 =?us-ascii?Q?ndr4WE4dOW0baQcwhGwiUmbTFfRwQUFpKUC1Qt99K4Djk6eWPjCfv+GtdWBg?=
 =?us-ascii?Q?Gv+8+vJrMhHNdsTDyTSH66EYc/7co0iTrap8VAfQUx+Dsh0Mvu3I9bZh1g+C?=
 =?us-ascii?Q?Fxgj/PiiTFy8NyRSiBI5WTBcPmUrnQ0ieDrB+Hbg0Ocrz3zFqScjMYk8ptLd?=
 =?us-ascii?Q?QVgII9vM7aDjBmrP1K5rGmo8YstBmZFq3U8B9LPjytnjuUKgqbP+keAyV1j1?=
 =?us-ascii?Q?bDcF1tOn0MillhCvQN2vefBRZplrMqLIR/lyRb5pS2os2S+useF9IA+ldLs8?=
 =?us-ascii?Q?j3PGZZ2bzysjflmP7xlE+UeTLkWRKzeS9/1ADY+4sqz78IpL5J4GvL+16nb2?=
 =?us-ascii?Q?WMFqq1JxaYtazJClJctUBK2r98UghTXhf/FpSMZ+y/u7X8uozYIiFmljXWeF?=
 =?us-ascii?Q?wylRjkL9rD8rd2Vet+oWYe2XfHWjauDd6Vm2dUzhR/DVEuIWaGwhDgVczsjl?=
 =?us-ascii?Q?a8/9BX4VwEF+wMAg6n5tE4/lEFYJl1gnWWjEqEVlEobYdabT1LqOYTWtt8DX?=
 =?us-ascii?Q?AjKKftM0skLYbOywfo2ITD33I6f1GR44A5YkztOUh4Rqmi/ReqjCWv5a+6fw?=
 =?us-ascii?Q?ZkjcSPO0MwFWYdVyQR2lViQucv2lXNZVBDxtT6m2zgERPeFczvqhLThuuraI?=
 =?us-ascii?Q?dIJ/GFUa0jFygeB5fwz10yK2nFGTeM+XIS95qc8QNTX6XLgZ/3AFbMSn4IZ2?=
 =?us-ascii?Q?j07Xqn8W6ZE5UzzyUdw9J7tB/oaojc4H9S4arksepOWI8RIeTUSw9tu72FRf?=
 =?us-ascii?Q?6YabSuHS9qlsRlBe+p2zkzUrzVtuXcBuwmY0Ldp7eI1ROmPXmuEVRVmqOTTn?=
 =?us-ascii?Q?zyd+W8uaNcSlLMIRzIY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb8ea20-7e52-438c-ed88-08dd04d491a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 17:48:37.9095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ffUcbaWiWH07fTWjVPIeALCTrZ3usFTIHLAFK66iEi2KCtiuBm42+ENMMH9aDhN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9107

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Sent: Thursday, November 14, 2024 11:41 AM
> To: Kaplan, David <David.Kaplan@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>; Borislav Petkov <bp@alien8.de>;=
 Peter
> Zijlstra <peterz@infradead.org>; Josh Poimboeuf <jpoimboe@kernel.org>; In=
go
> Molnar <mingo@redhat.com>; Dave Hansen <dave.hansen@linux.intel.com>;
> x86@kernel.org; H . Peter Anvin <hpa@zytor.com>; linux-kernel@vger.kernel=
.org
> Subject: Re: [PATCH v2 11/35] x86/bugs: Restructure spectre_v1 mitigation
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Thu, Nov 14, 2024 at 03:36:44PM +0000, Kaplan, David wrote:
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > > -----Original Message-----
> > > From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > > Sent: Thursday, November 14, 2024 12:57 AM
> > > To: Kaplan, David <David.Kaplan@amd.com>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>; Borislav Petkov
> > > <bp@alien8.de>; Peter Zijlstra <peterz@infradead.org>; Josh
> > > Poimboeuf <jpoimboe@kernel.org>; Ingo Molnar <mingo@redhat.com>;
> > > Dave Hansen <dave.hansen@linux.intel.com>; x86@kernel.org; H . Peter
> > > Anvin <hpa@zytor.com>; linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH v2 11/35] x86/bugs: Restructure spectre_v1
> > > mitigation
> > >
> > > Caution: This message originated from an External Source. Use proper
> > > caution when opening attachments, clicking links, or responding.
> > >
> > >
> > > On Tue, Nov 05, 2024 at 03:54:31PM -0600, David Kaplan wrote:
> > > >  static void __init spectre_v1_select_mitigation(void)
> > > >  {
> > > > -     if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1) ||
> cpu_mitigations_off()) {
> > > > +     if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1) ||
> > > > + cpu_mitigations_off())
> > > >               spectre_v1_mitigation =3D SPECTRE_V1_MITIGATION_NONE;
> > > > +}
> > > > +
> > > > +static void __init spectre_v1_apply_mitigation(void) {
> > > > +     if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1) ||
> > > > +cpu_mitigations_off())
> > >
> > > We probably don't need to repeat this check, is this okay:
> > >
> > >         if (spectre_v1_mitigation =3D=3D SPECTRE_V1_MITIGATION_NONE)
> > > >               return;
> > > > -     }
> > > >
> > > >       if (spectre_v1_mitigation =3D=3D SPECTRE_V1_MITIGATION_AUTO) =
{
> >
> > I don't think so.  That would stop us from printing the message about
> > the system being vulnerable at the end of the function.
>
> Sorry it wasn't clear, my comment was not about the return, but about sim=
plifying
> the check:
>
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c inde=
x
> 22fdaaac2d21..e8c481c7a590 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -1115,7 +1115,7 @@ static void __init spectre_v1_select_mitigation(voi=
d)
>
>  static void __init spectre_v1_apply_mitigation(void)  {
> -       if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1) || cpu_mitigations_off(=
))
> +       if (spectre_v1_mitigation =3D=3D SPECTRE_V1_MITIGATION_NONE)
>                 return;
>
>         if (spectre_v1_mitigation =3D=3D SPECTRE_V1_MITIGATION_AUTO) {
>
> Since we already set spectre_v1_mitigation to
> SPECTRE_V1_MITIGATION_NONE for that exact condition.

Right, but this gets to my point that this changes whether we issue the pri=
nt statement or not.  In the current upstream code, it will print a message=
 saying the CPU is vulnerable if 'nospectre_v1' is passed, but not print th=
e message if mitigations=3Doff is passed.

So in the patch, it was keeping the same behavior.

However as noted in my latest reply, there is a lot of inconsistency in bug=
s.c about behavior here and whether a message is printed when mitigations a=
re disabled in various ways.  I think we need to resolve that, and then I c=
an make it consistent.  If the decision is to not print messages if the bug=
 is explicitly disabled (either via the global or bug-specific option), the=
n I agree with your diff.

--David Kaplan

