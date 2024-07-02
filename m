Return-Path: <linux-kernel+bounces-237420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C6291F0D5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 10:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E7F01C21BA1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 08:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C45214B950;
	Tue,  2 Jul 2024 08:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttcontrol.com header.i=@ttcontrol.com header.b="czg26UdE"
Received: from mx07-0061a602.pphosted.com (mx07-0061a602.pphosted.com [143.55.144.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC161140E50
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 08:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=143.55.144.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719907853; cv=fail; b=fFsT1sYjmhJuyKsHp5D8slHuU7D6Tle412be8zoFIN4cratbjz2Cn4V/l9sxGpgQUNMbeVjdYX8a+xJKEDzSTEHjXnZRA4es4BK5cNMotuQZdYmLckx8WhW1ZJ5ebdyWDo7QaZChl2v5b27brxOkue5GvvMFcu2sl3GYtl/MRI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719907853; c=relaxed/simple;
	bh=FGjhY8RHl4tRRQxvn8fg9AIJdrRljnHz6AjuOjGrmLA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mfY/UHkuP/07v0TIO403EDOHWx7QyqrK70MnvxgS5EN9arIO45GFTw8CZV5JTdc+HRmykEz7nuDIcuQNextT6LyEuL8TKAIqGjy0eiY6SPfA8HtLsAOMpQyNU8bWVIgX2TjDN3tD+pS3MawvuD1An2Rn13TA2jPWe6WSNtTQFJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttcontrol.com; spf=pass smtp.mailfrom=ttcontrol.com; dkim=pass (2048-bit key) header.d=ttcontrol.com header.i=@ttcontrol.com header.b=czg26UdE; arc=fail smtp.client-ip=143.55.144.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttcontrol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttcontrol.com
Received: from pps.filterd (m0278995.ppops.net [127.0.0.1])
	by mx07-0061a602.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4627sVp7005022
	for <linux-kernel@vger.kernel.org>; Tue, 2 Jul 2024 08:10:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ttcontrol.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2021; bh=DMrR1Ihb9NM+99J5KKBdqHVOXtQnwquNecGLejdgBxE=; b=czg26U
	dE5Rh5DCEZbnO6HsF5bTeJJEK6IYo4IKn/se/95CrjJ93VUkiTTCSFwdcOPcVaCa
	a7K9KuSrHpUmXJbuB0tv8Dum4sHTNRu1pN50RXsrNdOMUxCnHB6qVQcmFiqsO1HT
	mNiRIuf+F/vDNiVCD9YSYwIKTa1rkfsyKfhesr7r4hso2vN4PBxkNm/HJcfQI0am
	+rsm9T/2jTlIMhlmNlKlfN8pdUrxKKg6tQzvqdzGMu8yqh8Wwk0AZCix/8YTciI9
	CGpwmecL7C1+8P9CsVoR8LaXwOiWDv8x2ugAC3fz9hK1L+Gfgs9CRe4w4RLHDrs1
	oierUWbJcVYUjd5g==
Received: from eur05-vi1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2169.outbound.protection.outlook.com [104.47.17.169])
	by mx07-0061a602.pphosted.com (PPS) with ESMTPS id 4027c8badn-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 08:10:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6PnFnmAs8ABaoLSe8um0GQZ3h3XanOeakQ7x4wepTI9i+watEqloqQ+/dWWrYNA3Xuxsf2e3fc8xdzQjH9FTask0H4TJB4XPvb0MwgabZ5uENaU+qP0zpPXd0ew4p92WdPS9PR04HnMhJpqQ8whGhFzbEbPwTqRweDbonW00ygwwzE87X4YYZKfAk7oa03m97L5qS/WrvFSxILxtKwCjiVBC0WUf9AAb/f4UqaA0ppp6K4b64LblbKEOtUwY/veKIeRPc7QXoaeHlEpb1vJdMDdz5Fk4JnANzYQbVgBuB54sgHpPynoWB1N+iELNMtP5qRlOJs0z7DzP4z6IJnOpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMrR1Ihb9NM+99J5KKBdqHVOXtQnwquNecGLejdgBxE=;
 b=W8345dKRdWf/5DW8RsvJ1/ZeRYiOQuMl27j37GrEfWRDannilXjVVWwLxG5jDftqXt5PAzY+8HwhJwQpuOTcs44N1xwlQAFI5jj096vj5T+hiJVeym8kXsJ9XluMvZJ4/acnqkx1SWPFOycIZdWPgx52TW6XUzcLORdKW0b3LnZeX0M9PJZ5vAUfqOjnVmQfRLtWRucCgE0sXCKnFQR6yyRQ1L01T3C2Dg52hCZjY+z1vWOaI/KjJffXZtD4GSj1HgRT1A8M2v9cdjeDGBjmeJvFFBFkz7riz8f9pq0HwceW1p+UvOXjTQJ4Hg3y1Hi9MNzGvzrMgOZzpjIhUugPiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ttcontrol.com; dmarc=pass action=none
 header.from=ttcontrol.com; dkim=pass header.d=ttcontrol.com; arc=none
Received: from DU0PR01MB9382.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:32d::6) by AM0PR01MB6513.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:167::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 08:10:44 +0000
Received: from DU0PR01MB9382.eurprd01.prod.exchangelabs.com
 ([fe80::c41d:dc9b:3f97:1ae1]) by DU0PR01MB9382.eurprd01.prod.exchangelabs.com
 ([fe80::c41d:dc9b:3f97:1ae1%6]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 08:10:44 +0000
From: Diogo Manuel Pais Silva <diogo.pais@ttcontrol.com>
To: Peng Fan <peng.fan@nxp.com>
CC: "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "sboyd@kernel.org"
	<sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "imx@lists.linux.dev"
	<imx@lists.linux.dev>,
        "EMC: linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2] clk: imx8qxp: Defer instead of failing probe
Thread-Topic: [PATCH v2] clk: imx8qxp: Defer instead of failing probe
Thread-Index: AQHazFdWN/m8O/jmP0WAh/I/zksSxQ==
Date: Tue, 2 Jul 2024 08:10:44 +0000
Message-ID: 
 <DU0PR01MB9382F1AC496F22A20C074BDE9DDC2@DU0PR01MB9382.eurprd01.prod.exchangelabs.com>
References: 
 <DU0PR01MB93828B0E6808E33C608BC0E29DD32@DU0PR01MB9382.eurprd01.prod.exchangelabs.com>
 <AM6PR04MB5941651E3920794104B3D24F88D32@AM6PR04MB5941.eurprd04.prod.outlook.com>
In-Reply-To: 
 <AM6PR04MB5941651E3920794104B3D24F88D32@AM6PR04MB5941.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_6d12e765-bdb3-4a42-8d1e-507ff5c9fe67_ActionId=feb09c1b-e3b6-48ef-89cf-48121eb19752;MSIP_Label_6d12e765-bdb3-4a42-8d1e-507ff5c9fe67_ContentBits=0;MSIP_Label_6d12e765-bdb3-4a42-8d1e-507ff5c9fe67_Enabled=true;MSIP_Label_6d12e765-bdb3-4a42-8d1e-507ff5c9fe67_Method=Privileged;MSIP_Label_6d12e765-bdb3-4a42-8d1e-507ff5c9fe67_Name=TTControl-Public;MSIP_Label_6d12e765-bdb3-4a42-8d1e-507ff5c9fe67_SetDate=2024-07-02T08:05:07Z;MSIP_Label_6d12e765-bdb3-4a42-8d1e-507ff5c9fe67_SiteId=5638dc0c-ffa2-418f-8078-70f739ff781f;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR01MB9382:EE_|AM0PR01MB6513:EE_
x-ms-office365-filtering-correlation-id: 056a171a-608d-4345-994a-08dc9a6e78e8
x-ld-processed: 5638dc0c-ffa2-418f-8078-70f739ff781f,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?YWKgahEeyg2QYAcFPxd0p8u0N+QYCf7y7yrSzRMqS6JD11WyaxiGKlegDDTv?=
 =?us-ascii?Q?qnd7UwntzA5v1qN3jbyiYhWvcJwMNxa5M9L9BbJIJmetmSoG3Q1g43cYLrOT?=
 =?us-ascii?Q?TYuVplhuEYs3BCcSW6SNobT+q5J2UDegVT/HmQysPN6m9tJUqCyT3lRI7Voj?=
 =?us-ascii?Q?Ym25sxJ6Y9qD5fu8hoBB2WfR+NQcmSQ9qPmzRqtJ7+YOrkSvPHKWNFUMuQf2?=
 =?us-ascii?Q?7vSoYhPFFvq8FuCSelYga9+vNV2jm48UA4ZJ+mVS1f4ar94rTJ+f8x2GtSrU?=
 =?us-ascii?Q?BKl2aisx4pB7/cF4wJxglXA3odW2ybWUv2NSsMU72Y954UZ0xd0qgH3K65zH?=
 =?us-ascii?Q?r+ckql7ZDyaLPMqM5clSPSS8tyN2nlbOjy5VvFZnknOMnx/OOpkfkjubORcm?=
 =?us-ascii?Q?nLGj0Bp5a8qhrIIsgJHwpB0m1Wa5PaBllr6UiNyFXVgWKFwWrmF4/jBdXB//?=
 =?us-ascii?Q?1Yl2EI7dbsMNI2F9tzjEexwBk/T5bk8bGY0ZR7lqac1l6FalYPF4DireMmSR?=
 =?us-ascii?Q?+WGsX6F1m7EXIvLV/coqXv4pykqwkBaVLRAC6k+1tXQvO6+306RN1I9pfscL?=
 =?us-ascii?Q?bxrYKl/C+nk+b7Ot+/1l9WKRcrPubB4DXtdZljIe99MNKlFsZqrrTAvKwzQf?=
 =?us-ascii?Q?kUyulPU084udqnU95HGwhlhIl+mabUeWlPW0FWi1HyP6tTkTHK8DdEPgt871?=
 =?us-ascii?Q?0SDnM+UZyNiRs8HPLwTmfMbSQu1QP6p+gEsbX6s/OtKxHIPmdGyBm8F8oLxz?=
 =?us-ascii?Q?SzHksRmV3LXDtC6xiDcEcklIrcHvReOUtp7Fm4qJGhffIP1Xjj0zhl1g+4vG?=
 =?us-ascii?Q?Asi3Zevg9oIzakGMjmA08krEkYj3imynCvh/quNVmCLdw2/vNc0EH018TsbB?=
 =?us-ascii?Q?VM8gtRVX3nPqYsEbIMlUxC6AugIGrgtQZeoAegr7Im/0d5vSudz9dryNd0HB?=
 =?us-ascii?Q?WM1wFlGn62//Ok2flnloF/3iwlPqp/eS1qkZFA+lfrOP54VWLcq/8V+PWYTH?=
 =?us-ascii?Q?C0YQfUjycyW8YUJLLHzDWG2EPhV1+mO/WPc5isDQVrnvTdAj+wpVHv0dhiF5?=
 =?us-ascii?Q?jQafM8ZiEZktLPw2jIAOeJE+c5ZAc341npViWhwtrcAied6E2cGGz44qhkL9?=
 =?us-ascii?Q?YRT/eQpszZOUbUYQRvweALoeXix6rx0bHGCqA/j8L1nvwzT9+oA/Tpi8NgJy?=
 =?us-ascii?Q?aU1339mhqkelep6iC1nd/o9idy6f6awCmEchBFWugbijwDOHPhkh9kTAYKW/?=
 =?us-ascii?Q?0wWp0wuW7qwAeX1pqWMwI8QBXsMNylZXvJZgiSq2a2jzziT8rowWaAMN1ZAf?=
 =?us-ascii?Q?H33E3H0xryGHzUXy9jL6bBirmsJTaRBiIPETonudGjlapHtTT9YF4OGNQJV1?=
 =?us-ascii?Q?iAx48zkDRs84yZ8iJg38n5rBivczCjiXNWpoNuDyBnAGaHJOOw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR01MB9382.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?oibpb3H4aI20RtYJ+k8z1gZA5qv3kffWnpCuw/NbjgxtAjS87Yo3WycR+HwP?=
 =?us-ascii?Q?cd/4Wome0a9P9sR5dt1igmtdyGGv2VP2S6WoRy7nBKs7eupTUAtwv347YhVg?=
 =?us-ascii?Q?E+c7YCKT8P7cTNY5Nz4Mf+EdSH6iclr1Tvyub/0UoQjbKAeXDAbVlAo03Rek?=
 =?us-ascii?Q?GcU9PTa5GW+MMWRQqpAE2UEykTYvimpRSL6USBQAboIQxIAuGCmpFOhyy6dO?=
 =?us-ascii?Q?t41UzbVf4YdI27BemHGz0W/yfSB0hmXTJCTqTTR4/ZQxKZ8l4FHktwFs1CZi?=
 =?us-ascii?Q?03eNSYgm29IvvlQUyvU3D8CYsGxHHgULnqzIr9uJrHO6EhFI4pL3ZbStiqqW?=
 =?us-ascii?Q?3y2CLrr1xypbJzKh2JL4LADYiuensgeem6wCnKLVPDfh0NFxET30EJcJRECR?=
 =?us-ascii?Q?hE3gBs4pPLNO014z2bl6juhtRlEngho5wK2fpOsEHINrvnGlXWOsEWhcAERh?=
 =?us-ascii?Q?4kVO390evyv9VQ8fXnRJ4fVWPIjx3IIlDbpIGeGLkr0X8tIdNZO+AfXJP76C?=
 =?us-ascii?Q?fkMZIspZ1rupThBzwCvuv2TJGRKrrGcPP9U9tYtNsSGSqrtpW5ZlpaJbPoka?=
 =?us-ascii?Q?+yFnSxNNMnceRYzRbQwVYfFES7Iyn/mcD6pj2r99fA66Tc9rpazH1MN062YZ?=
 =?us-ascii?Q?C4dBBKlV2Lzw0HhEZ36md8v0+pQCJpw2z8PWMPXtf7iLFdFl1Vo9JiWyzZJY?=
 =?us-ascii?Q?m0xAsKcTFqtydNgHiZ3ERv39n705RBAdFUIAFZtDPYP507KYSbewD0kv+9/m?=
 =?us-ascii?Q?MZi6gKNChaYsMrhZoCPSNzRFlqaoUNgHk9tMeLCEHr7Q5nXDrxUaUz0a+Tn2?=
 =?us-ascii?Q?bdRaF5K43q8YQ7XuGcHuXiXGqql1v5+L2s+7eXnveZf2bx2wawwltQ7mH5TR?=
 =?us-ascii?Q?tDmZUr78ddlBOr8c3hxL6zgo3IxT/y2LRsCIhOUqHIIz+D/TZ1DBTkc6JikW?=
 =?us-ascii?Q?6FRgExCmuSpax9vV8hRkBBDR9BxSBDrMItqv2IF4B/e6l+HqeC8V01m0MALn?=
 =?us-ascii?Q?hp/EEcghSt4dE65STmNU2xckvx11pYIxv2fxDXRmg+7GJxwkZpMygYhjkFHA?=
 =?us-ascii?Q?yyFsc6YuujcAcgniPWwm03pbJHfRC9nhWsKSr3HMQUZ/xIxhQgTGRdmH2sd2?=
 =?us-ascii?Q?l6WXzgV+07jbX9sIDvEFmc7Qwu0Prsfl1XPfee629/tD1eDl4yeNr9+93C8W?=
 =?us-ascii?Q?J/UGBxj8UWWJKEM2nyl1SU1FDhw/qxzQ9smoV1N7ZD4PDlfU5PA96EmEFzaa?=
 =?us-ascii?Q?f8G3bhO63n2jpUy/ITSjzbFi8vlbcpdxQkxVoEE9PnK50/4Pa0q/TUGKa9RO?=
 =?us-ascii?Q?BS46vvMYOHewFc0QfNk6TO8Rx+RaseDoLpF9OwLsDbS3EWU1rgt0DwWp/Vmb?=
 =?us-ascii?Q?Vx8OT/1ZQlCFk3rHW3IRQaNLFaXUxC3d348JRnQBG/plRQgy80QGA3YoL+iD?=
 =?us-ascii?Q?Rm1PnaqArVjnbOGIR9JI/lUy5FR/GaJejL56Hb5lMCrAmolL/Y0L3yZW7x99?=
 =?us-ascii?Q?hdNV7Y8/6GtW64kKZ8OERD/NNpyKngGYM4axFI/L90MSE+oOJcQP6c1ejZ9u?=
 =?us-ascii?Q?Dcp2T+MgIkDYmcdAaX5CuyZNpXlXoH3BZiM5mFjt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ttcontrol.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR01MB9382.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 056a171a-608d-4345-994a-08dc9a6e78e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 08:10:44.5329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5638dc0c-ffa2-418f-8078-70f739ff781f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bOVN6WWGr8fUnp5dLSqV3k0ZtMdL0k0eI++6QiKJZHhFPDo+KSWf0K7zgX05e3gx/dYnOfmLupsY9Ibqgz+8tWOJSPc+guxRry/7nEbDdoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR01MB6513
X-Proofpoint-ORIG-GUID: SxgSbBploYmnCsNu7Gfur-QNG009xDrN
X-Proofpoint-GUID: SxgSbBploYmnCsNu7Gfur-QNG009xDrN

When of_clk_parent_fill is ran without all the parent clocks having been pr=
obed then the probe function will return -EINVAL, making it so that the pro=
be isn't attempted again. As fw_devlink is on by default this does not usua=
lly happen, but if fw_devlink is disabled then it is very possible that the=
 parent clock will be probed after the lpcg first attempt.

Signed-off-by: Diogo Silva <diogo.pais@ttcontrol.com>
---
v2: change from dev_warn to dev_err_probe
---
 drivers/clk/imx/clk-imx8qxp-lpcg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-imx8q=
xp-lpcg.c
index d0ccaa040225..7bd9b745edbe 100644
--- a/drivers/clk/imx/clk-imx8qxp-lpcg.c
+++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c
@@ -225,8 +225,8 @@ static int imx_lpcg_parse_clks_from_dt(struct platform_=
device *pdev,
=20
 	ret =3D of_clk_parent_fill(np, parent_names, count);
 	if (ret !=3D count) {
-		dev_err(&pdev->dev, "failed to get clock parent names\n");
-		return count;
+		return dev_err_probe(&pdev->dev, -EPROBE_DEFER,
+				"failed to get all clock parent names\n");
 	}
=20
 	ret =3D of_property_read_string_array(np, "clock-output-names",
--=20
2.34.1

