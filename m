Return-Path: <linux-kernel+bounces-534942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B71A6A46CF9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77F2E7A2143
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC71E2566E1;
	Wed, 26 Feb 2025 21:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZkmPua6j"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2063.outbound.protection.outlook.com [40.107.101.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D131314D2BB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740603842; cv=fail; b=DYtu/+bEjVHvHNF9U4Pawz1r9L+rwXpoL8SAwYB4t5s3TwOev4Za42OcJW5E74V9J/3Xawq78S4D7Sk4xhtReMDIQjX1guPa0QIyFI9fkwmdzxuMgXYe9VdSzctYZNdEA6faK2TyvL0OsiqVNi5YvAPZWxIbg1K0Lynvur6xfV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740603842; c=relaxed/simple;
	bh=ZecndrOvEE6s42Bnz1zbzMUDdC1IElZH3UXaJc8GVBA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JmVlb7+ad2aFAQch9XDKef3yWZ3a+rvx4ZyIqzusmEB0ZKjN36evDPqdzT0R5D4CjFquVc9xj/PgxojXk95BffIvRsvX253e3FHmq6umBUZq9h8k2JsxgQm92q2IeHxJYuNKgZMMQCOwwD6ROwASrLU7bGuHCL5C2H+nCJEicNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZkmPua6j; arc=fail smtp.client-ip=40.107.101.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uIVcmA5ElNzVwiWB/e6rRB3hi2vdjgTIzzDhdruGDCCeuZ1isG/EpWp+/3WIdPIs9AGI3Egpm7DeqRAyMOs+gTe6Q31w6SEnDF6oOJpyJW4C6NDYMwRt7nmULLFBBrKAHMnO6Wi7kbloNcAb5KMBvSWA7/MXHQcjyI5uVH59sTn22TdO7fLAuoaaaBtqu/pz67VEnqOnfpkzrxOz9GapU7G4Ft7N/gY8DuAud0g4ANfRXssSSt99eq3ZgcNj4Oz2VBQWP3iypE/gDwk9md4xXeyU5kQVx17TgLaC6agiYw6NGMXWjfy9Y1sq56cuB4CixaFZGZLT7CceMO1DiBYiHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sR5gMMOVBK+RvaEMvoNE/aYg/24UDmDda8RHQ85LruQ=;
 b=NPmAa2qz4j+kfBy231+7uGj+kTVzdtlU1aph3gRlFdmDuxMhl1TX/NV4Sovq6a2rd5ljpVC1ajcaqfjTQyS/tXw3b7riabmFUp1OybYZqeg7YjuvdReDoQmcp3xV4lZXl13yv5nRYbGOwBQPp628wQlunfoZPgVzEuBOc+/pO+Qnh77vpaiMDI400QYLJ/oI9WKvhxzeHbHkFrLa3l3kF2aqRroyW4Ag8bc7ZVHgAbnqwLqmb+bStR/SnQhnwC+8HnIijBZ1tZR0tjBz7VtySkR7xF/LzyVKrT5np6bti+caQLidqe9f7fNDa5JpfZkhc/Deq4dGkKS2oyjm2moydA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sR5gMMOVBK+RvaEMvoNE/aYg/24UDmDda8RHQ85LruQ=;
 b=ZkmPua6jfWlwxZTTIg99WOjnbhitsF3bjOcw7IaYqkoti7rt+g5gsCEZW3zGIYk2M+QMjLv0fK3iXwHw9hPpGwmo+iVnOK5lz3p/qU5RL0KD9On+tKI7moaUjsFsbGfoNEfg0721XYZlnaAlH83ddHdHRlVVQ4ILgpEUFdc39tI=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by CH3PR12MB7668.namprd12.prod.outlook.com (2603:10b6:610:14d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 21:03:58 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%4]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 21:03:58 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
CC: Josh Poimboeuf <jpoimboe@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 20/35] x86/bugs: Define attack vectors
Thread-Topic: [PATCH v3 20/35] x86/bugs: Define attack vectors
Thread-Index:
 AQHbfK/msIIkfjoqOkyd6FXsW3bSnrND631ggAfdInCAADBpAIAAAIOwgAA3cwCAACLxwIAAWYuAgAAd6ICABAIeAIAJN77AgAAXk4CAAAqGMA==
Date: Wed, 26 Feb 2025 21:03:58 +0000
Message-ID:
 <LV3PR12MB9265F875F52317BBCDF953EC94C22@LV3PR12MB9265.namprd12.prod.outlook.com>
References:
 <LV3PR12MB9265804700AB74A446F5220F94FC2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <LV3PR12MB926524EFB64F6FB361046C5E94FB2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250217201910.crsu7xucsa4dz3ub@jpoimboe>
 <LV3PR12MB9265249E8D0FD3920C42A1A994FB2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250217233928.k3oem3bm7w63jzfr@jpoimboe>
 <LV3PR12MB9265041C9D8D4F3E5760F0B694FA2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250218070501.7mwcxqgsuxl3meef@jpoimboe>
 <20250218085203.GDZ7RKM6IyPDQAkZ8A@fat_crate.local>
 <20250220220440.ma5yfebhiovkqojt@jpoimboe>
 <LV3PR12MB9265DE3082FA0A7FDF9B587594C22@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250226201453.jgg6kucaathzmcvs@desk>
In-Reply-To: <20250226201453.jgg6kucaathzmcvs@desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=3d6b0a37-0bc9-4b2b-8580-701a45b04156;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-26T20:52:32Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|CH3PR12MB7668:EE_
x-ms-office365-filtering-correlation-id: b89ea82e-d34f-4a2a-e51c-08dd56a91687
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?pTXsdj3Hj/5wdtY9og3UKyMvsfQ+syiVFvKwc3I0Pj3UeMXMMHyqrngP9qCe?=
 =?us-ascii?Q?5c+JRE3RsWv8uaIikPt7ovs69J2liKLNqm25w0RhW5+LDMIPGwef6Fz3MkYv?=
 =?us-ascii?Q?Ajzwmp/YaIb/CUTundB0cVhsFkg+kk9coMuy4HuhaFJGMPh8UIeVm3WttG1H?=
 =?us-ascii?Q?9QxaLRblJ4xllnUVnRFHZMkWWC3/MM9EHuRWQzvtG1c5KzAAwLUyGFJbB7pE?=
 =?us-ascii?Q?7/0u9YJwUp+GZJ0gRNDyk6wOkLJuqH5CGnvL9eh8Bw26llOBev5WXIOzp16M?=
 =?us-ascii?Q?/aN7+zNsY4XTcVYzrlsXA21+qv3EsYLW1Rt/kZV1kkLIkFGSsEu8K7o+ABqL?=
 =?us-ascii?Q?KZv15ZC2rGvyxMqb6sCo4BufhFI0FsX4SOufGBFgQPfAP4kyX3PPUBB7WCb8?=
 =?us-ascii?Q?4qNZdOYKoxSBLIK+pNPrxNWL7GNVAq+SWdLpCKZ6D2tOzhw8lW7lhriVZ7pM?=
 =?us-ascii?Q?Nic8Mx212K1ZxKkgd3eyLIlq3OXB1wFQlN3psy7AECrIm1cul9RcOiHcPODQ?=
 =?us-ascii?Q?eEpobAu8wS+DMovmWipnXEkJuTOSh0TtOs1jF12pMDxvAtvgr/kI26vUv9Bl?=
 =?us-ascii?Q?7LHKC9+BKtdepls0csfrqtG8DznmXCKyXz7dvl3F/PGVsr8xVV92bn+461Vg?=
 =?us-ascii?Q?ZqXkio7KpZZwrLmoqdmJytJSVZNQFHsfmpgzrc3IFeJYpSwGX9tO2Xc+LifN?=
 =?us-ascii?Q?lfwUEVXDjiCXNJDE8gJc+z8FZuQwP/I7M73LHq90Incrb3ZnCyNTgFQeV+Di?=
 =?us-ascii?Q?mEaLSu/Odo9yQuZ//jwueZUTbC9xFajmaCcBmk5itGLzXMo62XHIE5SAVSZ8?=
 =?us-ascii?Q?b5aIlFt03FrKkCFoA9RlzdynKPPw7dEs24AUXCrSdT3f93rViIeDdzxZ/uSA?=
 =?us-ascii?Q?dcTwYiR0NCbUseNMTZjDPrzRrLmQ1lDP7SbyHVKm6s1oaxih+Mn3pQmP4vZN?=
 =?us-ascii?Q?o5JBNtBDn/+M1d6HnvoLKorGYztBcczr4GmIyWMAEAkMHmKFh0d5+VuvCizp?=
 =?us-ascii?Q?Rj7eZRI0Tt4PscKU9/O4617DY0dACg3Qxtk9S4R7Bs8xWo806EFmJE+dtzoQ?=
 =?us-ascii?Q?UBq2VfKHv2wqgn+Fx04j/yAJLttZoFizG0kwr1kqMgHAQHlfXGH5KWOY/Qqy?=
 =?us-ascii?Q?f1l9UgT4CnGa2ideq3cayRXl/LkHaXPvukL+f281/3xPE/mD/MhcXT5xOgkj?=
 =?us-ascii?Q?WSVat0M8QQjDk8CaeeSIsLHhk2/7HigkRahjOXukXkNxe0cC2NgsXdmJN9GS?=
 =?us-ascii?Q?JZsVN8wjz/Rnn0DdX36kc+Rcoygc17qUVPZbqNTpF7uJZLwUIZ9jdKqotbUp?=
 =?us-ascii?Q?rBJ6RLyLIbqsuv4MeRGNFlyFTgm3wwEmgqt9Hjy8fWeOEkevjNYi47zs88sT?=
 =?us-ascii?Q?aM+dNLFZnLdt5+DUyOw/ysOsogebynJ41lwutAiTGi8SDihkiFBlu9fU5WO2?=
 =?us-ascii?Q?NNPUQuPy03a91/umNCHkvSNugSoTtYgM?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yOiE7MkQqHZxJ5QZso1NN1oJU5o64t9xBTHEcTnhyBrOn/hVv+zt9wJtU974?=
 =?us-ascii?Q?WX4mHYWGHeTdwtfcEfcO97GV0TdrINrQtBrqfgrloNB171OsPBMOBVwmFZQl?=
 =?us-ascii?Q?SRvEwL0U4D2v4ZLDoLaf7HbL6xH/fngbviaZFT3VnWZQDj0Oxv3046ENTa1v?=
 =?us-ascii?Q?Qferw8XhH1xzue7xMXsfraWmFGsleap1x1zdbvq+3RgTXPTtwZWZfUKKDVnP?=
 =?us-ascii?Q?4nOfCNM6eXins14e6eHVZZw9IpClxOF87RZrQkE3lAXvdW4bCVLqdtWI1a5Q?=
 =?us-ascii?Q?luxfA/UeqFswLw9jSvHSkaeXo84vTG1lo7P4kFDy+HVeOpE3cgJFlAC6Z+RY?=
 =?us-ascii?Q?q0SwsCCHKF7J3CwDABLcX+n4mwqZp+8nExwuXUKXMG7VoNTyn+PARdO/ypmI?=
 =?us-ascii?Q?EGMXgDmdBCwsE6nvdiUfPXng5zdYOm1b2pPxep12mWTUl3IhZZAhIPOkavPV?=
 =?us-ascii?Q?9H/mALgNBBEgvBkxXhYE2UFLxVdeIicBYS71YkqkupxZWTPtSbUKuGacPugT?=
 =?us-ascii?Q?ar/gKUGXdb1WJjjZ/AFymlOXYZJ7AgQ0WZAKobxuJSQQDfsSd9TJr71xVekC?=
 =?us-ascii?Q?QiCzItQLSYZ/IYONfn/3l2aygqB2bTqWyvBk+wrMoFheIR65v8U9sSP6NE4P?=
 =?us-ascii?Q?0okO2B+0OocyLA0mmyjti3LgDfPbAF30BtSxTWJJ/LcksVoJNPty7ZRq10If?=
 =?us-ascii?Q?rLbAQerRw3u1eDPWvZqmE20I2fk9TP19vGTd4iBcPghjurLYQDbgOx2vRnHW?=
 =?us-ascii?Q?PWbhZKgxS3uJj2bgoWoYtxIcKa7VUGEEHUCVPYhlBegNNlZ+ErNgBe2t0Zev?=
 =?us-ascii?Q?JUt70wN+vn+LgT9AUNdUn1T1dDbrIEpbTEZhdJO1fuJNQZt++19bGVEMXqj6?=
 =?us-ascii?Q?f+nc7G+NBtc1RgWZ/V0KW5eNnYl2591Hkiof1nQlRFTcIZUoCI6VRnmyUeei?=
 =?us-ascii?Q?FzgOAKz7Sipj4l4K6V0loleb66UpJEn4LD+VAheLaBzxzXhWU5VZZVmP0zZy?=
 =?us-ascii?Q?Au+i+PykS1rwDPBBGpMgJhGEto+0hswpLxv5wU+RacMOpUiwsnvJ1reNKaZV?=
 =?us-ascii?Q?MA3JlkSMvMqj+k15lwhf70RwRlQSdnCeyaBW9fuuaXQmIo8HLzIm8Q2xZ2vz?=
 =?us-ascii?Q?EmW//Y+EMfTSdkNO7jaM/vrpPBtOGaXcgn/ZumRwGmtcuFqUHTXiGWWZQlS/?=
 =?us-ascii?Q?v8py1zxbxB4yGUHlw8r/5SQKXYQf25S7aHRpIUdvBls1js5G2lRByM742qlq?=
 =?us-ascii?Q?uJUEGkFYhA9IOpZ9Y7bmy5dkxiJpTNBCEdDZKlOlTF8Kxgjha/bgao4zhLeL?=
 =?us-ascii?Q?ic2HesvGp+W68mYcxpVVbaXEmdrlQa8iCShmPDIxFj3y/HwCmy7CrklTpn7s?=
 =?us-ascii?Q?uTkupKonHmWnhFH/dQW1xa0ADWlY8TU6TbRzwMNO3FrBnUvQI52g8JD9bXqx?=
 =?us-ascii?Q?KOp8/QjKJPj2cdyyRTuKNk/69zjH+jyHcphNXFVyn+1kgs+a980T/yqHHn1l?=
 =?us-ascii?Q?7ZYNVlOgZNLagaC3lgVE+iwEgFfWkHs/wGokybUfSitiE/DbvghRlDCsOkzk?=
 =?us-ascii?Q?cQB4ye8CZ74OeSFLj0w=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b89ea82e-d34f-4a2a-e51c-08dd56a91687
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 21:03:58.3370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L590Ym8AJqIRFAwmbtUF1eSosIQesScex6q1f+RRK7dXAaaVAOipCqkOJ0vw9BbH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7668

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Sent: Wednesday, February 26, 2025 2:15 PM
> To: Kaplan, David <David.Kaplan@amd.com>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>; Borislav Petkov <bp@alien8.de>;
> Thomas Gleixner <tglx@linutronix.de>; Peter Zijlstra <peterz@infradead.or=
g>; Ingo
> Molnar <mingo@redhat.com>; Dave Hansen <dave.hansen@linux.intel.com>;
> x86@kernel.org; H . Peter Anvin <hpa@zytor.com>; linux-kernel@vger.kernel=
.org
> Subject: Re: [PATCH v3 20/35] x86/bugs: Define attack vectors
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Wed, Feb 26, 2025 at 06:57:05PM +0000, Kaplan, David wrote:
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > > -----Original Message-----
> > > From: Josh Poimboeuf <jpoimboe@kernel.org>
> > > Sent: Thursday, February 20, 2025 4:05 PM
> > > To: Borislav Petkov <bp@alien8.de>
> > > Cc: Kaplan, David <David.Kaplan@amd.com>; Thomas Gleixner
> > > <tglx@linutronix.de>; Peter Zijlstra <peterz@infradead.org>; Pawan
> > > Gupta <pawan.kumar.gupta@linux.intel.com>; Ingo Molnar
> > > <mingo@redhat.com>; Dave Hansen <dave.hansen@linux.intel.com>;
> > > x86@kernel.org; H . Peter Anvin <hpa@zytor.com>;
> > > linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH v3 20/35] x86/bugs: Define attack vectors
> > >
> > > Caution: This message originated from an External Source. Use proper
> > > caution when opening attachments, clicking links, or responding.
> > >
> > >
> > > On Tue, Feb 18, 2025 at 09:52:03AM +0100, Borislav Petkov wrote:
> > > > On Mon, Feb 17, 2025 at 11:05:01PM -0800, Josh Poimboeuf wrote:
> > > > > IMO, make them generic from the start, then there's less churn
> > > > > and it's easy to port the other arches.
> > > > >
> > > > > If we went with putting everything in "mitigations=3D", making
> > > > > them generic would be the obvious way to go anyway.
> > > >
> > > > Just to make sure we're all on the same page: we obviously cannot
> > > > enable and test and support a mitigaion on another arch like, say, =
arm64, or
> so.
> > > >
> > > > This needs to come from the respective arch maintainers themselves
> > > > and they'll have to say, yes, pls, enable it and we'll support it.
> > > > We should not go "oh, this would be a good idea to do on all arches=
"
> > > > without hearing from them first, even if it is a good idea on its f=
ace.
> > > >
> > > > That's why those are x86-only as they should be initially.
> > >
> > > I wasn't suggesting that this patch set should *enable* it on all
> > > arches.  Of course that would need to be reviewed by the respective a=
rch
> maintainers.
> > >
> > > But looking ahead, this *will* be needed for the other arches, for
> > > the same reason we have a generic mitigations=3Doff.  It's a user pro=
blem, not an
> arch-specific one.
> > > Users need a simple interface that works everywhere.  That's why I
> > > suggested integrating it into "mitigations=3D".
> > >
> >
> > Talked with Boris on the side, he is ok with supporting this in mitigat=
ions=3D, with a
> warning message if you try to use these controls on yet-unsupported archi=
tectures.
> >
> > Going back to the command line definition, I think that to help make th=
e selection
> clearer we could consider the following format:
> >
> > mitigations=3D[on/off],[attack vectors]
> >
> > For example:
> >
> > "mitigations=3Don,no_user_kernel" to enable all attack vectors except
> > user->kernel "mitigations=3Doff,guest_host" to disable all vectors
> > except guest->host
>
> This is a bit ambiguous, mitigations=3Doff,guest_host could be interprete=
d as disabling
> guest->host and enabling all others. Using attack vectors with both =3Don=
 and =3Doff
> seems unnecessary.
>
> Also, we currently don't have mitigations=3Don option, it's equivalent is=
 =3Dauto.
>
> static int __init mitigations_parse_cmdline(char *arg) {
>         if (!strcmp(arg, "off"))
>                 cpu_mitigations =3D CPU_MITIGATIONS_OFF;
>         else if (!strcmp(arg, "auto"))
>                 cpu_mitigations =3D CPU_MITIGATIONS_AUTO;
>         else if (!strcmp(arg, "auto,nosmt"))
>                 cpu_mitigations =3D CPU_MITIGATIONS_AUTO_NOSMT;
>         else
>                 pr_crit("Unsupported mitigations=3D%s, system may still b=
e vulnerable\n",
>                         arg);
>
>         return 0;
> }
>
> Extending =3Dauto to take attack vectors is going to be tricky, because i=
t already
> takes ",nosmt" which would conflict with ",no_cross_thread".
>
> How about we keep =3Doff, and =3Dauto as is, and add:
>
>   mitigations=3Dselective,no_user_kernel,no_cross_thread,...
>
> Requiring the user to explicitly select attack vectors to disable (rather=
 than to
> enable). This would be more verbose, but it would be clear that the user =
is explicitly
> selecting attack vectors to disable. Also, if a new attack vector gets ad=
ded in future,
> it would be mitigated by default, without requiring the world to change t=
heir cmdline.

I kind of like that.

Note that for the SMT stuff, my new plan had been to use a separate option =
'mitigate_smt' which will be on/off/auto.

But we could also combine that with mitigations=3Dselective perhaps with to=
kens like 'mitigate_smt' (enable all relevant SMT mitigations including dis=
abling SMT if needed) or 'no_mitigate_smt' (do not enable any SMT mitigatio=
n).  If no token is specified, then we'd default to the behavior today wher=
e SMT won't be disabled but other mitigations get applied.  Then everything=
 is in one option.

If we like that, then a related question then, do we agree that 'mitigation=
s=3Doff' should be equivalent to 'mitigations=3Dselective,no_user_kernel,no=
_user_user,no_guest_host,no_guest_guest,no_mitigate_smt'?

If so, and we're ok with individual bug cmdlines overriding this, then I th=
ink we can get rid of cpu_mitigations_off() and just rely on the attack vec=
tors as Josh was suggesting.

--David Kaplan

