Return-Path: <linux-kernel+bounces-314348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C23A96B220
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1231E2867D9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 06:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81384145B24;
	Wed,  4 Sep 2024 06:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttcontrol.com header.i=@ttcontrol.com header.b="Ji8FqOuQ"
Received: from mx08-0061a602.pphosted.com (mx08-0061a602.pphosted.com [205.220.185.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502B813AD03
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 06:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.185.213
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725432609; cv=fail; b=cngnaBDyWmGT+jMs0ntwzXefvP+t3pWn9r8dXf2DDzFZXjQ0E+v3hyVDcccwAEiKzR2ysR9lbUgS0vC1UaeYN/7JQ+H1Q1MezaAeXIHEkcj1oOSggcXmGYTunRWGgGVTyoZh/aQgOlU3IMzMQFUCLPQs12b1ahq9RuGbRh1WAcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725432609; c=relaxed/simple;
	bh=tYoOY8Nm+pn7gq2grX5pH4HUp3FsE5zyxaO70siUHB8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RaeZf05TGwbx3JoPYfNcyt5DDIOsHQ696OURDDWpUkTDwEk+HZxruUeY3iNvr1dYSgrlxKWS08BnogFtr9dLzC0lLWXbMaYQb2q44FyExgOO1cF56hp9EmPyYryUjCaTe8tM/35PWmY348U9a4tqIbbPD0dhHN0P9Nor38iab2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttcontrol.com; spf=pass smtp.mailfrom=ttcontrol.com; dkim=pass (2048-bit key) header.d=ttcontrol.com header.i=@ttcontrol.com header.b=Ji8FqOuQ; arc=fail smtp.client-ip=205.220.185.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttcontrol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttcontrol.com
Received: from pps.filterd (m0278994.ppops.net [127.0.0.1])
	by mx07-0061a602.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4843F2ll019146
	for <linux-kernel@vger.kernel.org>; Wed, 4 Sep 2024 06:50:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ttcontrol.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2021; bh=PU0fYCjnhFoxXZw6vVhlgeHHWl9DWiw+7RIiu4lJFSY=; b=Ji8FqO
	uQAzoA32R244cInrU1HmKpJJTf3lh3i4aOmvEs1mx5HAH01JkCe2mq+iagtidmC3
	PU+IkplgyYZMrY8N89eqQLqFm4LNCczNQNmAsbA8vhgb3sX7xwHyEm9HKwZOPdYC
	zd4PCsgEYDC0IPml1hM9OcqBi8gJoh8Z9d90xvQchYCDNaG6dCLJh+VaRXp7TWIv
	FN2BXcaTfimGIckc+JDP1zWxOEABpWfmfykNWqt/p+iLwM4SqlBMAq+9PZSNqyK4
	Fqr+NUB3UYo9+FM6PEUnGOuKG1efrOo43KumZZ7VAGv8C+iy3af6ZdgRfU0CINU7
	F7q1LTd6D2/fFWwQ==
Received: from eur05-am6-obe.outbound.protection.outlook.com (mail-am6eur05lp2110.outbound.protection.outlook.com [104.47.18.110])
	by mx07-0061a602.pphosted.com (PPS) with ESMTPS id 41edy987dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 06:50:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T4SwdN1LH8BNg1VQE8jdoqhg3sKM46CgItnM52L7t+8b+PMz+7Ozri8MVGfpDqOlTK53MueEeRehXx8OpJEM7JTCvbb/xgluf6hggeuWC2CbpPvMJa/rmrMeUITStnL7TVYxjliRLKnJDu51u1suw6Am1GIvLsPbrnEf1EnIW21duhXZ/2TWZp6hOYTuvN00BgaNQOSD7E0YCq4IWgyj3bigcixkRlCwVWJG/pvPW8xT3SciPqeeYwuieqzcmu+s6wrRFjQcrtTw4yHN1t+ZFpnMLLNhAEK4O9rVmES1UJv85lCYwL90PlHJs5nJTdYlOQYLtjtfhKYgIX4vaLz/BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PU0fYCjnhFoxXZw6vVhlgeHHWl9DWiw+7RIiu4lJFSY=;
 b=eNM1OxdF6J9+NtLgvQuMoViascUeltEWfJgP5/Q4cf/3taCxHvnjCt5E26bH3M73min2mYWxfbiTXIxlxJbAhDT5Fei2Nn2M3P0VQXA7G0x+pxnEXgAPCUaslYDgZwpSHIUysDG9jbH6xL8/CgVw1xgD+zW+8/oNsGGMneIGl5IaRn/Wi7hZecttt/UDRyp9a/7cey5jA4GHW5vYRCvYkr1P4SCSS+aEhJQ2l0TLKl9UAqIuihBtDK6tpQETMR59Fdyccd33xgpUVOXsyh4G95UUggEwO7//0X1y7a355hhkIo4x5YF+ShNF/twTyBHO0RBiuCgwQ1exGAMeBRMVHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ttcontrol.com; dmarc=pass action=none
 header.from=ttcontrol.com; dkim=pass header.d=ttcontrol.com; arc=none
Received: from DU0PR01MB9382.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:32d::6) by AM0PR01MB6242.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:168::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 06:50:03 +0000
Received: from DU0PR01MB9382.eurprd01.prod.exchangelabs.com
 ([fe80::c41d:dc9b:3f97:1ae1]) by DU0PR01MB9382.eurprd01.prod.exchangelabs.com
 ([fe80::c41d:dc9b:3f97:1ae1%7]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 06:50:03 +0000
From: Diogo Manuel Pais Silva <diogo.pais@ttcontrol.com>
To: Peng Fan <peng.fan@nxp.com>, Abel Vesa <abel.vesa@linaro.org>
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
Subject: [PATCH v4] clk: imx8qxp: Defer instead of failing probe
Thread-Topic: [PATCH v4] clk: imx8qxp: Defer instead of failing probe
Thread-Index: AQHa/parsKGDNP+Jxk22GRtAewCBaQ==
Date: Wed, 4 Sep 2024 06:50:02 +0000
Message-ID:
 <DU0PR01MB9382A24116486931F28843BA9D9C2@DU0PR01MB9382.eurprd01.prod.exchangelabs.com>
References:
 <DU0PR01MB93828B0E6808E33C608BC0E29DD32@DU0PR01MB9382.eurprd01.prod.exchangelabs.com>
 <AM6PR04MB5941651E3920794104B3D24F88D32@AM6PR04MB5941.eurprd04.prod.outlook.com>
 <DU0PR01MB9382F1AC496F22A20C074BDE9DDC2@DU0PR01MB9382.eurprd01.prod.exchangelabs.com>
 <Zs7gXhohOyQ/abOf@linaro.org>
 <DU0PR01MB9382A2BBCCD8C786121975B89D922@DU0PR01MB9382.eurprd01.prod.exchangelabs.com>
 <PAXPR04MB84591356511162E61E074221889C2@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB84591356511162E61E074221889C2@PAXPR04MB8459.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_6d12e765-bdb3-4a42-8d1e-507ff5c9fe67_Enabled=True;MSIP_Label_6d12e765-bdb3-4a42-8d1e-507ff5c9fe67_SiteId=5638dc0c-ffa2-418f-8078-70f739ff781f;MSIP_Label_6d12e765-bdb3-4a42-8d1e-507ff5c9fe67_SetDate=2024-09-04T06:50:02.569Z;MSIP_Label_6d12e765-bdb3-4a42-8d1e-507ff5c9fe67_Name=TTControl
 -
 Public;MSIP_Label_6d12e765-bdb3-4a42-8d1e-507ff5c9fe67_ContentBits=0;MSIP_Label_6d12e765-bdb3-4a42-8d1e-507ff5c9fe67_Method=Standard;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR01MB9382:EE_|AM0PR01MB6242:EE_
x-ms-office365-filtering-correlation-id: 985d410b-e97a-4899-2ffe-08dcccadcd8c
x-ld-processed: 5638dc0c-ffa2-418f-8078-70f739ff781f,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?rx687ZDm54DOyZqQ/ZmQsTCgCVIsxJEg3rJu/BKnv53PeKYN1d8p6WAcnq?=
 =?iso-8859-1?Q?bJA69BC0dlliwXxJw/Wujn8mjenosPf1q2OR1to7TWETIdZ+VqS2Jr4/F1?=
 =?iso-8859-1?Q?2eG31oRuaCBsA72lzHBITFd1FsCtGiEEanrjkXYvDrv+EfAdiTdRRSoyup?=
 =?iso-8859-1?Q?Lqc2AE1+oDQx1eQlS6AGrOVMN11Mvhl5mWmXxMKvkV3axpLbRD0xEC7b1D?=
 =?iso-8859-1?Q?GKmpb7d4IAOc2wlOrwUWrnX2z/bdoPZj1Jrjk9+l9GBXEy3eENIR/NEyrk?=
 =?iso-8859-1?Q?R07cu14sgLQwabuWrhxQ0en+Ljl+MdvKx68tvjY2clZIDLEnvi7rTWhfbL?=
 =?iso-8859-1?Q?FkdEbPmVv2xkssKnM//0qdftzXgn4bT1ec2FUd3n3IsRvP6CYSh58kw1+D?=
 =?iso-8859-1?Q?gIH5XWlP+hNLmOlmNlmmq5mdZ5XQ36b1+qjmxXaDGuC2Cwx9HFKIocyAxs?=
 =?iso-8859-1?Q?2PJbn//2cGZn/kygSxBl/mOHhP+VE2HMdHnVF2pvJpPlpG40dvoF0UkT9i?=
 =?iso-8859-1?Q?mONPbUCr9JKzwm/nRvlGqVauMOaORDSbQ5ORwW0KncygdtCDrDD1SH/p04?=
 =?iso-8859-1?Q?2QvSNIJNhGSRZQznwUpku9YA5QGtHL5Fvf5lUbfkNxBGs5SpHJD+34N8lJ?=
 =?iso-8859-1?Q?juc3EsvxTNoo/7uv59Q2rQq+wGLk18xtpZicLm//73lTTPgAuORAc0o1XR?=
 =?iso-8859-1?Q?HDTFxjqWMphU9LiHHHdalaFqdLBYtAKRsKmr9WxrxdARh3XSqBiyO1FclQ?=
 =?iso-8859-1?Q?5IUM9JDQG7LB01Q1W6EK3qbYyp/x3pBehTMgIGKp2YU5X6Jawt1dUlYraR?=
 =?iso-8859-1?Q?P8ut1MNRSyL9FgLn2m9EZsOmV3z71Izrd5Pno+j7u07U0LU20tSSIDQaXs?=
 =?iso-8859-1?Q?de1w2HUeALO3Gayi9AJMX3WJtjf5qm4N2OsRdpsBGyDlQcJPoffSDTJh0h?=
 =?iso-8859-1?Q?PTOmLdaHoPI7aroEC1b0UfjlmWYeRp/UZLsoY7z+ApjT3k4EvvFsJDvege?=
 =?iso-8859-1?Q?zR1w6K1xNVc5H7ibHIu+LiWQjDgO3TMDoXbKMVebwxJ58+HUaPOUKN2vjP?=
 =?iso-8859-1?Q?8ElclmJk91h1IZP45t7zAV2oh/MbGvFnjaH+b4jN3mMih46e3du5j0c18p?=
 =?iso-8859-1?Q?G6bNfJsPGz7aIQoq8708q5fwu3/y/tzjE7jKUo4sooBnoS6S6ZRfuu4C10?=
 =?iso-8859-1?Q?ehiheFhRBjsCpcbJJMcwR6cWHebynQK9yFzd5dQSR1AyVum+HTR35w/xtO?=
 =?iso-8859-1?Q?YT/jBoDBIeRDZNqr/U6a/ylj9CtO98K71rlr4d9Kop4hGh+yw+tceFKdn4?=
 =?iso-8859-1?Q?jghmOGTYGvUz4DUq1r/DriA8zNF/YUrDYwammadLBH8fl4EUmIeIH45MMz?=
 =?iso-8859-1?Q?Y8kXBlt+q42fIvUXCLIqpVYt+YlHHqLJhdfwLP+zPkZ49ftxQqv4p3dmWQ?=
 =?iso-8859-1?Q?rarm7BByhT7LDMyegE0t7pOIQaLbT3/x/4nElA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR01MB9382.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ShXQMM26yl3bJs926L7/WQRI5yNEYqsixx/QBS6z77zRVTNWbQBFVKcmdw?=
 =?iso-8859-1?Q?URD8qDtUt6p/opa0t4LW6T4hSRl5D9joSjBCG9d+cm7674taLp2TshYKjs?=
 =?iso-8859-1?Q?/lUIFWuSFqSRgmCp/o98tuYGdPpewE9dqtRQQ00QG51c9rSnWeYwmgFuxD?=
 =?iso-8859-1?Q?5Lb80q+Owwt60PVPzdiQxy8VYNJqC7Xo33x90yKqpXj5Zga5EwO/Z+vAi7?=
 =?iso-8859-1?Q?G+64MpOaZvmJ/jhdUW2diNOWEgIoeeS115am/Zege5h4Fj78GialAm82lW?=
 =?iso-8859-1?Q?Sp1BazuIvQr9YM1VTPLS3aZfKzPZh7+kpY+TftQ7DkSxoPJMBtwXB0CcZP?=
 =?iso-8859-1?Q?JD8htucGlhpUbzfxsNg6rfsUUl2ckXl/GXKdOYyRIPZQuw4PnEd4ygYqVN?=
 =?iso-8859-1?Q?rE2ZuouFx13+Jb9oHfh+yuAajVQMd8LMrhp+AkPmNHuJWsSIMiIFNZxhpz?=
 =?iso-8859-1?Q?m0wYWLMg1NoUBCWQO3Xl7zk9U2RbSs/t4Etaa4UIR7L5IIyXH3nN3ts7qU?=
 =?iso-8859-1?Q?tF4HaTDjWJRaur0ZEPPx1Oe4AQ+sOCp9knkUtcivqKekINASI29Xte5qmL?=
 =?iso-8859-1?Q?Z+QnCdshvBJXUKIUFd+4iD/egiFXWR/KD1CCRxLGEFECpjrT7C3LtuD8Zk?=
 =?iso-8859-1?Q?yZAJVjWx0p8nt+V1dZpL1JBZ910t+4iKLyflqeiCKO6YGeIufkg4OORi7y?=
 =?iso-8859-1?Q?OqskLgN1YzHDTRlZ7EzrDwejipFGtCPRyzsV9cLlvwFbrFF/6b5hXZ0amP?=
 =?iso-8859-1?Q?THb8qzjuO0Yqfsl18ercesbekjlmj4yuQ/qNxftr75QYFaMj93D6ybE82G?=
 =?iso-8859-1?Q?Pf5Eln0tKGx0MKlqsEjLPd1xOJUtnW5wQahZsRVtEkOahLVsQPbUpJwxMu?=
 =?iso-8859-1?Q?gJ8DoVkxLxPP+9J2NVnXdMnqyVj0Rq+XWoitqp9W0b7E6Xv3eOWLjSZCiw?=
 =?iso-8859-1?Q?k4QMJDs2fqCk7do0KBfcVPBHRDjdejoYHlQoXVf/8sKAxb/FGakmGdU05P?=
 =?iso-8859-1?Q?7YF5Mtj1Fnqcv4u9fjG4dK9wrkO22MjG+mBWLg07Cwclzkng5LOD2af/c+?=
 =?iso-8859-1?Q?R1RqHd3N3sYm9hOSvh+5+cvXU4TlOyMWxPqrFeOeKXt7PYc3ZD/S7bbmVK?=
 =?iso-8859-1?Q?SKqx/TXSb3WdLfvCFXYhLrXIUELW91XUzVW/nIHhd4fmC/5+bQkPDcf0dK?=
 =?iso-8859-1?Q?D6Tkea4pFTBTqIpKjFmr/ri2c1FGyPXC8aZCBq10ejmJ2nOfUObEzV6Gkq?=
 =?iso-8859-1?Q?gLXCLJnahLp3kWihbJwQ2CL5BiH4Ow1hlcRouGDW5WyF8yNUnYqnEuUm7z?=
 =?iso-8859-1?Q?2E8f+V7OpQ+BxEqDnn2XKyIYd94o25j5u/yZQivD/IV+XabnWSx52PidAw?=
 =?iso-8859-1?Q?bGuMPZyXhi/yBqYmPK5MrfBguHi6uqQ6iTUPxC1YjHmJbieundN9erOUrQ?=
 =?iso-8859-1?Q?CELhi/+5eX/zvspC1sYWOvGUjP4QHHuiBg+1WtNlps9oinbsyhV6j5u5Ty?=
 =?iso-8859-1?Q?J2u46K8aTbejT7lOnyBvo2pV8+7lwFpSqyojfFlDDjpew9BLEaqpHIvkT5?=
 =?iso-8859-1?Q?rgJ06hjPGFVV53nJIzcSP/TTWfuBuQm7jcxY+AoIiP0hs17iL37lAe/LWG?=
 =?iso-8859-1?Q?t12c/UhTmzyjwTnjufC9xpTourkr2d772N?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 985d410b-e97a-4899-2ffe-08dcccadcd8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 06:50:02.9168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5638dc0c-ffa2-418f-8078-70f739ff781f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JiM3mmU3/l/8p/47SQfK43LEmaBXHLsxd03CFFczQ8Sa8lqyNh9KmJtUx9u3ukWqSXwb/txUGylNat+ea9wM67I1hFmAfLJMOdL6OXHPn90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR01MB6242
X-Proofpoint-GUID: O8inGQbIwwn9lynFbyVdwqbje2D4Mhcx
X-Authority-Analysis: v=2.4 cv=RpCXLzmK c=1 sm=1 tr=0 ts=66d8031d cx=c_pps a=gP2taHnPVrKuxa3Y2Z85qg==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=EaEq8P2WXUwA:10 a=9E89HhfwiosA:10 a=EZQmGfNXMHUA:10 a=nxb4IF0AAAAA:8
 a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=IpJZQVW2AAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=P2wu7-uIK5GfPezDZRsA:9 a=wPNLvfGTeEIA:10 a=muotpCzfy8uUhEcWaHt4:22 a=ST-jHhOKWsTCqRlWije3:22 a=1CNFftbPRP8L7MoqJWF3:22 a=IawgGOuG5U0WyFbmm1f5:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: O8inGQbIwwn9lynFbyVdwqbje2D4Mhcx

When of_clk_parent_fill is ran without all the parent clocks having been=0A=
probed then the probe function will return -EINVAL, making it so that=0A=
the probe isn't attempted again. As fw_devlink is on by default this=0A=
does not usually happen, but if fw_devlink is disabled then it is very=0A=
possible that the parent clock will be probed after the lpcg first=0A=
attempt.=0A=
=0A=
Signed-off-by: Diogo Silva <diogo.pais@ttcontrol.com>=0A=
---=0A=
  v2: change from dev_warn to dev_err_probe=0A=
  v3: refresh patch=0A=
  v4: correctly propagate probe defer error=0A=
---=0A=
 drivers/clk/imx/clk-imx8qxp-lpcg.c | 6 ++++--=0A=
 1 file changed, 4 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-imx8q=
xp-lpcg.c=0A=
index d0ccaa040225..1c3e1a7df8ca 100644=0A=
--- a/drivers/clk/imx/clk-imx8qxp-lpcg.c=0A=
+++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c=0A=
@@ -225,8 +225,8 @@ static int imx_lpcg_parse_clks_from_dt(struct platform_=
device *pdev,=0A=
 =0A=
 	ret =3D of_clk_parent_fill(np, parent_names, count);=0A=
 	if (ret !=3D count) {=0A=
-		dev_err(&pdev->dev, "failed to get clock parent names\n");=0A=
-		return count;=0A=
+		return dev_err_probe(&pdev->dev, -EPROBE_DEFER,=0A=
+				     "failed to get all clock parent names\n");=0A=
 	}=0A=
 =0A=
 	ret =3D of_property_read_string_array(np, "clock-output-names",=0A=
@@ -301,6 +301,8 @@ static int imx8qxp_lpcg_clk_probe(struct platform_devic=
e *pdev)=0A=
 	ret =3D imx_lpcg_parse_clks_from_dt(pdev, np);=0A=
 	if (!ret)=0A=
 		return 0;=0A=
+	if (ret =3D=3D -EPROBE_DEFER)=0A=
+		return ret;=0A=
 =0A=
 	ss_lpcg =3D of_device_get_match_data(dev);=0A=
 	if (!ss_lpcg)=0A=
-- =0A=
2.34.1=0A=
=0A=
________________________________________=0A=
From: Peng Fan <peng.fan@nxp.com>=0A=
Sent: Wednesday, September 4, 2024 4:03 AM=0A=
To: Diogo Manuel Pais Silva; Abel Vesa=0A=
Cc: abelvesa@kernel.org; linux-clk@vger.kernel.org; shawnguo@kernel.org; ke=
rnel@pengutronix.de; s.hauer@pengutronix.de; linux-arm-kernel@lists.infrade=
ad.org; sboyd@kernel.org; mturquette@baylibre.com; festevam@gmail.com; imx@=
lists.linux.dev; EMC: linux-kernel@vger.kernel.org=0A=
Subject: RE: [PATCH v3] clk: imx8qxp: Defer instead of failing probe=0A=
=0A=
Hi Diogo,=0A=
=0A=
> Subject: [PATCH v3] clk: imx8qxp: Defer instead of failing probe=0A=
>=0A=
> When of_clk_parent_fill is ran without all the parent clocks having=0A=
> been probed then the probe function will return -EINVAL, making it so=0A=
> that the probe isn't attempted again. As fw_devlink is on by default=0A=
> this does not usually happen, but if fw_devlink is disabled then it is=0A=
> very possible that the parent clock will be probed after the lpcg first=
=0A=
> attempt.=0A=
=0A=
Did you meet issue with fw_devlink disabled?=0A=
=0A=
>=0A=
> Signed-off-by: Diogo Silva <diogo.pais@ttcontrol.com>=0A=
> ---=0A=
> v2: change from dev_warn to dev_err_probe=0A=
> v3: refresh patch=0A=
> ---=0A=
>  drivers/clk/imx/clk-imx8qxp-lpcg.c | 4 ++--=0A=
>  1 file changed, 2 insertions(+), 2 deletions(-)=0A=
>=0A=
> diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-=0A=
> imx8qxp-lpcg.c=0A=
> index d0ccaa040225..cae8f6060fe8 100644=0A=
> --- a/drivers/clk/imx/clk-imx8qxp-lpcg.c=0A=
> +++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c=0A=
> @@ -225,8 +225,8 @@ static int imx_lpcg_parse_clks_from_dt(struct=0A=
> platform_device *pdev,=0A=
>=0A=
>         ret =3D of_clk_parent_fill(np, parent_names, count);=0A=
>         if (ret !=3D count) {=0A=
> -               dev_err(&pdev->dev, "failed to get clock parent names\n")=
;=0A=
> -               return count;=0A=
> +               return dev_err_probe(&pdev->dev, -EPROBE_DEFER,=0A=
> +                                    "failed to get all clock parent=0A=
> + names\n");=0A=
>         }=0A=
=0A=
The change is not enough, you also need to handle=0A=
        ret =3D imx_lpcg_parse_clks_from_dt(pdev, np);=0A=
        if (!ret)=0A=
                return 0;=0A=
->=0A=
        ret =3D imx_lpcg_parse_clks_from_dt(pdev, np);=0A=
        if (!ret)=0A=
                return 0;=0A=
        if (ret =3D=3D -EPROBE_DEFER)=0A=
                return ret;=0A=
=0A=
Regards,=0A=
Peng.=0A=
=0A=
>=0A=
>         ret =3D of_property_read_string_array(np, "clock-output-names",=
=0A=
> --=0A=
> 2.34.1=0A=
> ________________________________________=0A=
> From: Abel Vesa <abel.vesa@linaro.org>=0A=
> Sent: Wednesday, August 28, 2024 10:31 AM=0A=
> To: Diogo Manuel Pais Silva=0A=
> Cc: Peng Fan; abelvesa@kernel.org; linux-clk@vger.kernel.org;=0A=
> shawnguo@kernel.org; kernel@pengutronix.de;=0A=
> s.hauer@pengutronix.de; linux-arm-kernel@lists.infradead.org;=0A=
> sboyd@kernel.org; mturquette@baylibre.com; festevam@gmail.com;=0A=
> imx@lists.linux.dev; EMC: linux-kernel@vger.kernel.org=0A=
> Subject: Re: [PATCH v2] clk: imx8qxp: Defer instead of failing probe=0A=
>=0A=
> On 24-07-02 08:10:44, Diogo Manuel Pais Silva wrote:=0A=
> > When of_clk_parent_fill is ran without all the parent clocks having=0A=
> been probed then the probe function will return -EINVAL, making it so=0A=
> that the probe isn't attempted again. As fw_devlink is on by default=0A=
> this does not usually happen, but if fw_devlink is disabled then it is=0A=
> very possible that the parent clock will be probed after the lpcg first=
=0A=
> attempt.=0A=
> >=0A=
> > Signed-off-by: Diogo Silva <diogo.pais@ttcontrol.com>=0A=
>=0A=
> This patch doesn't apply cleanly.=0A=
>=0A=
> Please respin.=0A=
>=0A=
> Thanks!=0A=
>=0A=
> > ---=0A=
> > v2: change from dev_warn to dev_err_probe=0A=
> > ---=0A=
> >  drivers/clk/imx/clk-imx8qxp-lpcg.c | 4 ++--=0A=
> >  1 file changed, 2 insertions(+), 2 deletions(-)=0A=
> >=0A=
> > diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c=0A=
> > b/drivers/clk/imx/clk-imx8qxp-lpcg.c=0A=
> > index d0ccaa040225..7bd9b745edbe 100644=0A=
> > --- a/drivers/clk/imx/clk-imx8qxp-lpcg.c=0A=
> > +++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c=0A=
> > @@ -225,8 +225,8 @@ static int=0A=
> imx_lpcg_parse_clks_from_dt(struct=0A=
> > platform_device *pdev,=0A=
> >=0A=
> >       ret =3D of_clk_parent_fill(np, parent_names, count);=0A=
> >       if (ret !=3D count) {=0A=
> > -             dev_err(&pdev->dev, "failed to get clock parent names\n")=
;=0A=
> > -             return count;=0A=
> > +             return dev_err_probe(&pdev->dev, -EPROBE_DEFER,=0A=
> > +                             "failed to get all clock parent=0A=
> > + names\n");=0A=
> >       }=0A=
> >=0A=
> >       ret =3D of_property_read_string_array(np, "clock-output-names",=
=0A=
> > --=0A=
> > 2.34.1=0A=

