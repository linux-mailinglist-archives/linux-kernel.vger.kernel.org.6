Return-Path: <linux-kernel+bounces-321549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B473971BE6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C4BB1F236C2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD631BBBCE;
	Mon,  9 Sep 2024 13:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B7TQHJTj"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AE91BB6AE
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725890179; cv=fail; b=tCg1BEX7l5JNOYsUfQeMlZC5PCz+XmqquNSFBgzsVuaSxnvkDCOWzcfrgMWCpIWivZG5xh4AsoUWxB9t1BT/Sn5DvCWBErUMTypGJEx5jw3k7TpmykVHBMoa6aZFpgQppo5vp9Cqk4IGWRGlYVDpxwW7c/1WQPk5NtmDsuSWHtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725890179; c=relaxed/simple;
	bh=ERTrqJpZqQfL0YizFYTsHb02KMKXW3JkgfLMIm+TNRw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ou8NlKevWPxFnvj1sOVYGyLhT+pktcXiPhBUrGnUpyYRoqcRYuqnrpJyXQM4sXi2wRj9TRcycHWxWl1u8l1aXRy6RP0xY0Po/rM6lioRGO+cl6G3lu0xSkDEmCAICZda3WxUAb/fJPT4XzPc6/9qtMjaOq/WzAkaOTwXuxDbue4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B7TQHJTj; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S8qkPkYNXM7YNyS0lNwHZo2t8vPahmqcJEai1IVMGScbP1NrEqcOkAgOG0mD91pDrF9koVCw9LPw+I4lFpWCu4m68xjmDNGXSh+Z/mpcQVxaSu0bQB51xgp+OwFxe5DGUQ3YJxLbgWuL32nzj845wmp9mRovXoEx04Zhehj7lypXeacy9KHs+rmzdQMDW2LKF5vKUjCO2fb7KJ2WjRGOs/hvywWUs+BpTh7gayFseaCYh8YuPpnLXOehQtUVgT5N6u07ZjSi8RWPVzGLTBDZfqVWrHFqzx5tnGPMLiebcIpEs4Dq3wrLfT1lVPC7rMcJxSMuV2lfc8ooZHZTtGGORQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrRe+i1WBKSl7I8zDnPaS/AqmE6LHsQsQmnD+yai1FA=;
 b=XA6R3eMYgjbMEhZvkGHlVe9aQVhwhz/1xB69sWD5Dq7KGAahYb2yCKm4fVVINOOD285Vcjc9MUpVjuZhI+tsm5sXf+nFps/v+UpbOqlQzV1bzf9HFAlpgZMJzCFL3a0w7vALB1ngQblMTGmYnBw5/Mu/qTYitwKVkAS2g30+IbG5/DHifamYhulqPK5fIMI3HJeDSn4jkAMrdwHJaGYcQrlpVBxMfiMMra8haeNsLGWnijhTy8+xX5dQ//oeQsqtv5vT6sGg/8f2bWF6flTNXEHw9IPTB596mptWcIJRX4/nVxY7RZ9I7MwXZbtKbVjrqHEUkyNVNH9Nc92JH0UfOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrRe+i1WBKSl7I8zDnPaS/AqmE6LHsQsQmnD+yai1FA=;
 b=B7TQHJTjDu+EjABSMyWMuj0U3HzD6ZKalfbhMAwkMc/CTsDEddMzhW1nqVzwmM8ElSi9pvJjz3CHTTYU9grrl4djfzDzcHVhA7f6JhtN8hGERJz/LKjXnGW0qzfyOBFeC50AL80HzFKC8EBQgRYKaTKMw0sTTKZBiSU/My1dd90=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by DS7PR12MB5719.namprd12.prod.outlook.com (2603:10b6:8:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Mon, 9 Sep
 2024 13:56:10 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%4]) with mapi id 15.20.7897.021; Mon, 9 Sep 2024
 13:56:10 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Kai Huang <kai.huang@intel.com>, "dave.hansen@intel.com"
	<dave.hansen@intel.com>, "bp@alien8.de" <bp@alien8.de>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "peterz@infradead.org" <peterz@infradead.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"seanjc@google.com" <seanjc@google.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
	"rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
	"isaku.yamahata@intel.com" <isaku.yamahata@intel.com>, "Kalra, Ashish"
	<Ashish.Kalra@amd.com>, "bhe@redhat.com" <bhe@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "sagis@google.com"
	<sagis@google.com>, Dave Young <dyoung@redhat.com>
Subject: RE: [PATCH v6 2/5] x86/kexec: do unconditional WBINVD for bare-metal
 in relocate_kernel()
Thread-Topic: [PATCH v6 2/5] x86/kexec: do unconditional WBINVD for bare-metal
 in relocate_kernel()
Thread-Index: AQHbAo9GtMXQ5J+L60GdV3fxNS9w/rJPeZbA
Date: Mon, 9 Sep 2024 13:56:10 +0000
Message-ID:
 <LV3PR12MB9265B4512DE5F2D580DE3CF794992@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <cover.1725868065.git.kai.huang@intel.com>
 <79f0de36a2a4f33e6cea8f0bf6419a6dc09ba94c.1725868065.git.kai.huang@intel.com>
In-Reply-To:
 <79f0de36a2a4f33e6cea8f0bf6419a6dc09ba94c.1725868065.git.kai.huang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=dcc1a0e7-5ec7-4284-a649-71004dce3ce9;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-09T13:51:22Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|DS7PR12MB5719:EE_
x-ms-office365-filtering-correlation-id: d3716270-eeda-46aa-b334-08dcd0d728d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZIu+wW7aesQQW5FnDuDkVOmZ47elyUqIz2ETBc6Jk2JLJ9nPrjSZDrYM7OtS?=
 =?us-ascii?Q?xi4js6T6/MqDotH0IpT2rHdxUfv1E/EZhZ1g0DI3FLupROJYWhhcIHbbSvLl?=
 =?us-ascii?Q?R1cwl8xlUXnGbpaWQBk/KYdbdJJB01+xtAVENC5toB29EBMazcF89LB0+ZYs?=
 =?us-ascii?Q?XwFTvLvhg+4fxKtGSmMjnmTEUNVCCAhaX0NIRdt9+8CoBUEx0O5YKyPbR2jS?=
 =?us-ascii?Q?/y0ux2MBXivsnNAeCOLuwl5ggcB2ro3PZZUyXo1SNtUwTfjLSQFu2Pdlf6J4?=
 =?us-ascii?Q?FY+w2MeGhRzboR1tw3ghYTL2181jhkfe+5l4q6EhW9dBrY9eHXp4z34/J6J/?=
 =?us-ascii?Q?WHBMswVYOCV8NvWAuA0RiyqSAg5fD7NXiOcFdLtIDsa9TX4Wp2hiJ4JL2WdU?=
 =?us-ascii?Q?0YKtAhaD52TyuCSIJcEDyKlDXnI6KABCpkFlHMBBOU/QTwgCMURNEcqX3apE?=
 =?us-ascii?Q?9ms+GwudCdQGCh+baRiGGCBjBGLcwS+iwEL59sTpKHYMUEvM+EANHvc5jVPs?=
 =?us-ascii?Q?9goxRbglLbP+C+WNnbbpBrZXCQXBAv7i5na+h/RaZYS4agAYWoquyDZfRo54?=
 =?us-ascii?Q?h11DlXdFbgsAJ/MtuVH3cc0K4Y4/ATomzxffQLHUlEmBfDUN+dqkK9m3+BGr?=
 =?us-ascii?Q?u6iaO9HzFPYHej2PnQxdAMM74jG/kotlOu14Fu4RTLBilZPMA52c+m3y8z2p?=
 =?us-ascii?Q?4Mbc1oLrVJ9g7UK32ku0ZvldJQ8guVLppBFPkZmlLt/8N2W3NFF/Iesf5kL/?=
 =?us-ascii?Q?jN7Uvx8zJ7DEtFx0q/MG31AXsUeymMciOcQc3et3L2Q6/ODYdO4OVqAn4cwa?=
 =?us-ascii?Q?etPtZ/Xqlm3GebaBKRsbmE2RoHpt3aZDBgjg/uzhtzY3Va+b7H8+Eikp1HHL?=
 =?us-ascii?Q?MdN//ezedlIu2lfVZ00ui/ceLNFldvHApJO9jk9hRPbDCvOpnmyD5sN+AGC9?=
 =?us-ascii?Q?PlMG34+bQj/LLie54ven4AvaPhi4qvDGSb+RPwKtgwI8uVj+soXxcGUQedws?=
 =?us-ascii?Q?xFbY/FFf5uRbTZHoA4Vrjbo4+HxeaO6oWRzg9i2vjdT/bJr92k2oS94OW7yM?=
 =?us-ascii?Q?f98qAIgchSEtEflfMK3TdIacHZuADn9AMU8GrX3EGoRYwYGwFBXXNF9F4g8I?=
 =?us-ascii?Q?4E3t10LO2G/KChv1wvh02mianjmn7E+6sPKzaFFmynMUQAPnA+ug4KtI5PQQ?=
 =?us-ascii?Q?Wi1nrEOc+B/Uw8lX0+Q4DwvezTXBlDj8TAvfTlKqxPWGdcnpMp7QXNwZZDPd?=
 =?us-ascii?Q?gQCn5nWUKNfTvTJ5waGBVhpgKx3yLHY8yweHgueatexoNVi0TiZp9AWpB+Vn?=
 =?us-ascii?Q?yyXjaCcR5UY1p9OkmbpZ7Nfs3zLU3VohFNawuqo4qFEeUySSYdxDuGMTRMKq?=
 =?us-ascii?Q?ezSQhBOP1nA7gIXrfZ7CR2apn/ro0Dkyminh3a11fkqqpMr0LA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+peJjFjtUkkUqS7gEkGE8rVqZM+YT57JR+qzf/8SkS8zBm82fZptn87hvPtM?=
 =?us-ascii?Q?mSoVCmWPTAl58SlDd1wOvie5/K9CZ1q2mpELa1a9X41+ZhqBoVJ3hDY1E7Me?=
 =?us-ascii?Q?SaJqfjJit9JgWE8zLJazSkBmo/EX0audAmHneMe5eudusC5vYmL7HfFUjzFH?=
 =?us-ascii?Q?UG0h52R1xJ1QqJk6AKO4bWw3Rv4iQHbio1sy2jOupcTOU1t48RsU17NhxbQ0?=
 =?us-ascii?Q?jihkz7FGMpb+TdqOwOTwisBi5LWYjXgn1TMJJYBHDSfubP4LQcdfrswSroDY?=
 =?us-ascii?Q?e4NtBL/uNKEIK6HoyZmFbPknpMsah16FfO/5SnKCJkKB4fRDSrgeNeOCdApq?=
 =?us-ascii?Q?CgOl92m0Nm1/2fZrZVkiR7nrg1B0S6UN2YngnqY36q3SGhck2gROvryRExbq?=
 =?us-ascii?Q?i85Rc2RBb9/7WyN/YU6qnXj5sGZhRPfLuAfEYS0u2Y1a5LXnzGNrBFK9xh9U?=
 =?us-ascii?Q?SUbxeLwolX5rTdU70bEQ2S2piKbHPAklbHLVkBV53I8StM6S2I4BUUdy1KVv?=
 =?us-ascii?Q?8x6lsnVETRYLpLF1SJ2RGbzwu8Yxv9ULq/Ug957DJi053dNEVEfvu2fU9xLC?=
 =?us-ascii?Q?enh0Il3ie9Z6qOVRkcEP/C0fE94TdvcKykme8D5yAjnsj+hgp8cWcjwdJ6Ti?=
 =?us-ascii?Q?8FQFXIinS/qdhDRKftpNWOdtEtOalATd6WWm8r53wmk84uErRmiSCNfY3kRu?=
 =?us-ascii?Q?TsOCOvj1An+lXnabhjKY5dmm1lB5+ssvPd4Fnn0kSKsAD6WP0DB6DmbBiWpt?=
 =?us-ascii?Q?X5Er+Sqk3VSCARzPO1tn/7bdO/IlaBBKbBz7N2y+ZYzXxIP9AuvRsDApP4Tj?=
 =?us-ascii?Q?wXBoGUlVfc4PW9vzC1GhDHocnCaAhexpQSFay3oUJQ59yIfnymj3uKOG9++B?=
 =?us-ascii?Q?GGI/UxjRsJ9RDFXQHrW0GPE97vI/pjTpVdevIVgfLGbvTnmCIeyHmchE58bU?=
 =?us-ascii?Q?b+WL4jBRyeKoUqOmSH7V+/6ysJLU44DTelHM6L0hPrKDS+Fp7/jNhHCE0yRD?=
 =?us-ascii?Q?RwQRb4IL3bmBfjTc9MswrED63I0o8wHZAlLoJg9o3nS/nc9OpgEAyglVJASn?=
 =?us-ascii?Q?TjYGbbBnrlvNVc1dcTvL1PAlSzR/pCd3LHyq0uff5Yp8KTVDijYdd86L4ui/?=
 =?us-ascii?Q?DB6NAxDn85ZmFGveKpIwjAksGkEt3CmEsLcY297WvfbNDHx310a+ZzQyh9cC?=
 =?us-ascii?Q?RcCjQ2Gl1VfhY7+i1xlaFbwKnCVoTkYa0IhP9Fh4golO4ExBYlcOpUjEqFY/?=
 =?us-ascii?Q?UE/gIU4v0rz4K2TPmJYGxNMZG5rHqu8BvndhgHzzemM20kExjidyfSRnk6dM?=
 =?us-ascii?Q?ogQQ4CqEy+spW/Nr789WtK93QiV3W7pYrd1nwk8QCQ/uz62Ecf1xbDOgo9Yk?=
 =?us-ascii?Q?Ho9i1xI9biqkJVOvoTF9ZpmncZoNujnfDfsTV9B5aw3PsmqnAL2QCGxKz6Lw?=
 =?us-ascii?Q?IDLX0S4Vm8ZWEFfSP9T64N+rgu2hScWcIZHU1Ggl1vY1wYAMgi+07N6IFQhW?=
 =?us-ascii?Q?TSv3+icJMsLytRvK68lUagBOu/znBGv1lGjNe9/ZCiLYNKH+NkhJ+WhiaDzO?=
 =?us-ascii?Q?S7gwwcsP3vbN3zHd/TQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d3716270-eeda-46aa-b334-08dcd0d728d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2024 13:56:10.0855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JUOyoJ0GbmZV6jSX0GBsWrJU9HxnVPVaLaX1jGGRQEl/9rDu9bayOPpCHVzzHm5F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5719

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Kai Huang <kai.huang@intel.com>
> Sent: Monday, September 9, 2024 3:06 AM
> To: dave.hansen@intel.com; bp@alien8.de; tglx@linutronix.de;
> peterz@infradead.org; mingo@redhat.com; hpa@zytor.com;
> kirill.shutemov@linux.intel.com
> Cc: x86@kernel.org; linux-kernel@vger.kernel.org; pbonzini@redhat.com;
> seanjc@google.com; dan.j.williams@intel.com; Lendacky, Thomas
> <Thomas.Lendacky@amd.com>; rick.p.edgecombe@intel.com;
> isaku.yamahata@intel.com; Kalra, Ashish <Ashish.Kalra@amd.com>;
> bhe@redhat.com; nik.borisov@suse.com; sagis@google.com; Dave Young
> <dyoung@redhat.com>; Kaplan, David <David.Kaplan@amd.com>
> Subject: [PATCH v6 2/5] x86/kexec: do unconditional WBINVD for bare-metal
> in relocate_kernel()
>
>
> Note commit 93c1800b3799 ("x86/kexec: Fix bug with call depth tracking")
> moved calling 'cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)' as an
> argument of relocate_kernel() to an earlier place before load_segments() =
by
> adding a variable 'host_mem_enc_active'.  The reason was the call to
> cc_platform_has() after load_segments() caused a fault and system crash
> when call depth tracking is active because load_segments() resets GS to
> 0 but call depth tracking uses per-CPU variable to operate.
>

>  #define ARCH_HAS_KIMAGE_ARCH
> diff --git a/arch/x86/kernel/machine_kexec_64.c
> b/arch/x86/kernel/machine_kexec_64.c
> index 9c9ac606893e..225242840467 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -322,16 +322,9 @@ void machine_kexec_cleanup(struct kimage *image)
> void machine_kexec(struct kimage *image)  {
>         unsigned long page_list[PAGES_NR];
> -       unsigned int host_mem_enc_active;
>         int save_ftrace_enabled;
>         void *control_page;
>
> -       /*
> -        * This must be done before load_segments() since if call depth t=
racking
> -        * is used then GS must be valid to make any function calls.
> -        */
> -       host_mem_enc_active =3D
> cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT);
> -

Functionally the patch looks fine.  I would suggest keeping some form of th=
is comment though, because the limitation about not being able to make func=
tion calls after load_segments() is arguably non-obvious and this comment s=
erved as a warning for future modifications in this area.

Thanks
--David Kaplan

