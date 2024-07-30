Return-Path: <linux-kernel+bounces-267702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1299294148B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834281F2430F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0B41A256C;
	Tue, 30 Jul 2024 14:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QwEicIne"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011021.outbound.protection.outlook.com [52.101.70.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700E11A2551;
	Tue, 30 Jul 2024 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722350258; cv=fail; b=JkCq/EoYJrZmNWzdboRERuMQtWLz9XERVOvI1GwlH2dHrGqIuLqZTrS2Tn2J9613Q9pxCca2ecoZFnVbsLWIvRGoJ51fzzF1zZSJNBBL25mw5Q/vBzi8oYnPdlbkutKvkRAnHtYGK94xZYXb3IpVNFU0OdEuk9AAY5WASike5aU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722350258; c=relaxed/simple;
	bh=FjD6B3l7kDwGAtVkCnn0fqTqKgxRUlYxesAvKilK+68=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dhrmkLWD2RWQe5ePaOvTYmS6n3TO16y0mrxxHruRDrrXSpko6dTixSX8DPQtDn/rVyo+Xox0d1B9uohc91K1MJL20iAzSuuMTYDxZqOCqkOyP7MOcYfkTdOOxcPC/3CJRu+0mBah2n9eRKsY9ED6ZqxpKeUZnoSV9f46Eb1c0jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QwEicIne; arc=fail smtp.client-ip=52.101.70.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y+N7tiYAdyFGlo2m2++p/cllgmCJL0/1IiF+ca1OXxHz2/bFGNCDz+zpgdhF6l7R5iM05cYcluLNa06s/gHufSVSjL2jhBSOgsXpKMGKy0RC+3TcgB91m2N7E5xGPJoW/4zjL7/aiUNPY6A9r2IKj31doeLDMd2Z+oMiguNAssDe2hc/1fuJhJffPauxUbqar3dOzyvC1jp3fy/yrsPKFgKfBNPVepC2/AbS0MkglIGvyX24cy/s6DX7VfI2tXnMMC5IfYj9zYeeT9q/8P0sZKjm93GErjXodHAY2w2vYvKcC12iH46vUnPvCj+guZeQhWSlnk5Z+a0WSb6j1GMsRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjD6B3l7kDwGAtVkCnn0fqTqKgxRUlYxesAvKilK+68=;
 b=VA1cZVHpjXb4Jz2DVcJKYRy9mN00oXsd+rGPFxaTuQlO4UIupUfP2qp/4hJzyiwC9C1zTlExO+R3F9Miw8m1IrGc54G/UzdmJFcEhggkDGaDkhsDfvZm9LDVeYYnU2FwIrW/GVsIfi1tYsbxBvIRsXSG2LFe6b6AqSbRO701El3+l5JpvhEV4acMWsu1ylWWiDjhkdoQN6kUCoUJGeDmOwkIvQJ5Xs/zvx7QyPb1Qt38uzPncTG31OOXeLyZGoBmtF0Mt46kN+ECzBoi4kLVWS/KZMNpSq79Wob/a8XuMYk66d3pPX0FUL6M4FyDtW8egFkjwFJE3MMgTU6UwTPHyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjD6B3l7kDwGAtVkCnn0fqTqKgxRUlYxesAvKilK+68=;
 b=QwEicIne7NNnmu/RlVrIYKgy/GcBngdXibqaxHIOGoNTPgNNeROB2xcgOc+NczFrvy/2obbXvjsQAfuSb4+FQLEqMSBsk3Y+BuB3rT3+XVr3SRF2kreq293SoPCmhTYUVYCWz8EJmiaAw8VX7psclN9Fr2bQKhQuO5yC03tEKvbpO5E0FCNeocw7eliwXDx4iWwTDgz28s2XMi1oHViNAgQS9Zuh3Wwc3T3I7TKN47rHKPnmo6R2NZSe1DcP1A4q3IGW0m3ZJArooj4sh9f8ldbDy58Ykf4QI46y22tmZlATuCqFz9/k/NMehgisdzXIZDwb09ms7FYWEdPbTqoF6Q==
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by AM0PR04MB7028.eurprd04.prod.outlook.com (2603:10a6:208:19a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 14:37:31 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%5]) with mapi id 15.20.7762.020; Tue, 30 Jul 2024
 14:37:31 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>
CC: "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"james.quinlan@broadcom.com" <james.quinlan@broadcom.com>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>, "etienne.carriere@st.com"
	<etienne.carriere@st.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"michal.simek@amd.com" <michal.simek@amd.com>, "quic_sibis@quicinc.com"
	<quic_sibis@quicinc.com>, "quic_nkela@quicinc.com" <quic_nkela@quicinc.com>,
	"ptosi@google.com" <ptosi@google.com>, "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>, "souvik.chakravarty@arm.com"
	<souvik.chakravarty@arm.com>
Subject: RE: [PATCH v3 1/9] firmware: arm_scmi: Fix double free in OPTEE
 transport
Thread-Topic: [PATCH v3 1/9] firmware: arm_scmi: Fix double free in OPTEE
 transport
Thread-Index: AQHa4oUfM9Ze7Tu2I02vwpe5zdqGt7IPVtpQ
Date: Tue, 30 Jul 2024 14:37:31 +0000
Message-ID:
 <DB9PR04MB84618323ABDAEBB78B3A8D9A88B02@DB9PR04MB8461.eurprd04.prod.outlook.com>
References: <20240730133318.1573765-1-cristian.marussi@arm.com>
 <20240730133318.1573765-2-cristian.marussi@arm.com>
In-Reply-To: <20240730133318.1573765-2-cristian.marussi@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8461:EE_|AM0PR04MB7028:EE_
x-ms-office365-filtering-correlation-id: 15ef964a-acb7-4b7a-8987-08dcb0a524ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?TfVjhrq8iJe5aZ5I7StEjLfkExv7aeRettPYdiU0BzSfSElIKsRC0/fNE0kb?=
 =?us-ascii?Q?SLml26ei8R9OCfx46hTIYf4VN/bSALV4lhZKI3Tle6Drw+1a8lswEDDHG+m8?=
 =?us-ascii?Q?ZPDJ0oCxdC5dWpay+B0AT+w1cjmtd2I5Bh68Y/KGrAcBYGzY76Ac0u0M6orz?=
 =?us-ascii?Q?2qMJf/kxbQha2Wo7nLvL4EuSZ7EdjAOIWrNxh0XjdaflGB8qI8dj2kA0DggF?=
 =?us-ascii?Q?84cbVBQszOvpD/g+P/ayk+Gjuv75Xe4WPb5mydavJEPsX1rlT+3vxNu0m/Mm?=
 =?us-ascii?Q?4A01z/aGCzBhJNCjW8q/aMNG8bNRNuCWnCe41zo+aX+tPMaDeyBrVdW3NZKk?=
 =?us-ascii?Q?Xj6nuC5GP0v6BjpBno2Z33yWp5SstbTQXLmUNGyXxgIGZfs2J4eggJ+04I1k?=
 =?us-ascii?Q?XzV71SNCm44cFTaRg2Jl2nm88Im+TEhLUJTVQOwUGkhiFfAFqCwS7piOerZJ?=
 =?us-ascii?Q?DkEi1tXPeYTOgS7VBXnY1baMKzXZ/mXJJ6v7BReqTgJYEfZLc8vKTGQAItzX?=
 =?us-ascii?Q?8uU3Oh5GF2jzzPx+B4K9mZTUksSWRxU5YQCae2uOqcw1druYK5sdMtlqt5qP?=
 =?us-ascii?Q?qNijb6WtkeSWvzYfIYW6M3XD4cBQdKF/RrAKVUQhu+ALpsH7XymFMCv0QwLq?=
 =?us-ascii?Q?XY1XSjoLFfE1tnsvDrgGDN7eVcNPMpTm4WmEaTBhD9LU5kbLJcZJndz8FT8n?=
 =?us-ascii?Q?6D/LknZIPlIRxiW+vXH4vpg6kfQFZ+dzLqPtigybRoHSTwpC6mhgtu8uUnMS?=
 =?us-ascii?Q?LDnVDj60E1eQFXfbnsPq62wlSBHy/ZW0St0YZF90+VivVCSoEQui7ErS9X5m?=
 =?us-ascii?Q?exCT9BNopvk/oqVtkHfJZr/4pOd8I8IqgYKa2vb6Cds7dZl+5f5YqIIqnPbs?=
 =?us-ascii?Q?fuhw2PvUwG2xyRLLOlsGTX70mOhV6c0k/6WZSOz4QtNwb+vCXte8/Y4sUojR?=
 =?us-ascii?Q?BVqjZE72Va8iRvOyWqcImMsUp9aG0ORps3TF2ra7hFXKdrKeS4jM8NIrh0pW?=
 =?us-ascii?Q?CcmLP7t1KiuyoxJzkgolxRfBwKOozZrvmEd/DFHn0wtl6yF6vgIfmIhHkcKY?=
 =?us-ascii?Q?SJfgR5S0fOuxfUoYVW4vwTO1PK0qDkgSlIs3411sM13GaUiP75PhHZcgjCdW?=
 =?us-ascii?Q?ujKO5YvUVkyj6DmugrJTgNjWGCZZtO/fOkdn4hDb8+PP5Bg0Pyp60YRqFus/?=
 =?us-ascii?Q?7pArjEz2yAM/W44pBxyKOaFThKNoQFEKmdsVU4d0RJ7LAf5zUoVTYwhSNgr2?=
 =?us-ascii?Q?r8qtKbdAdILGS9VF5wyW4h33C7CJ698rfmO/9wFNOboV7UE/A9B6OydIMV4K?=
 =?us-ascii?Q?NXx8HA+bGr+uVrhBv5BS+7jGVmxW29HvJ+dWSuNR2e1BpHj1hrBajs3PaU4y?=
 =?us-ascii?Q?7Y1e5RrWYzkd3JtP3ZFtmPGBGQ1HrouEFHM9sccCTGXo4r7dEQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8461.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?M7XEGm6gMRJf6kjC5svI08fpzjzVOWdO9aaezgeVs9GXdtfzn5cEqDpK6JGK?=
 =?us-ascii?Q?MGM6h05Gy5cyA7nyIHCqsXnfGbMobBIeZ9fnwksNMVfxWoDHcX0Igo9nOJ9F?=
 =?us-ascii?Q?5dr2yvFneywFg0xEtbimde/Yj9sH26f8Cbhlr67QkQDpqOipWXmhmRjMTk0E?=
 =?us-ascii?Q?TLmAl4fTuB+WioLwEihtTXx1o0wOUyv/L3O04kwuA0TOBUNQQYc47iPNDSH1?=
 =?us-ascii?Q?WtjcRaavKExbazABCFFlw1hvAvb8xQzY7sgCtt+y151mpk9jc+KWCSBxXGv9?=
 =?us-ascii?Q?79fpMMtA1qxf5YkXER2iUM6kd5LGzE+JU8Y58+MoOW0KFpo11tILqh8dhcCH?=
 =?us-ascii?Q?Zwr5mMrdfR4IQ5xj11gkcYAwtcYNab0Pbwmd2tdfjMfByVOYTJIaD2RCE43A?=
 =?us-ascii?Q?auBmM7KxTN+YqX/Ps19nagj+nkC5ALj5brCb7ii3Js+l7c8UFPPaPNa2BdNF?=
 =?us-ascii?Q?+N8+ufoL2+zZji7glmxad04xVkbrkIx1EcG4HjoohVUXEEchxbb7Agn0DhiL?=
 =?us-ascii?Q?UjddYmFKQRPMiWgH+ytuyXp8XyOlLN9rbNnbrh2myYQUApSKQ/E+/eLmPh06?=
 =?us-ascii?Q?iS94GcALtCuKCrF1tTP8xuWvhqDdjV6RwyNaLZgHU1YpMG53IWtrpSjt9r+D?=
 =?us-ascii?Q?fxiY069hsjbAze5nN21RYMoxctVDu3DuQmvfbqeozm9CXeXY51QR2wF42gav?=
 =?us-ascii?Q?at/Ywuaryw+6ZTMEsZhbKavQxCGjqKjdkK40Hrfx3q6hyvTtCqNel6xf0g1w?=
 =?us-ascii?Q?TdB2O+pW1PpSLIyIAQ4SpZ9YG+fhNW1HV9ka8Q0Dgl9qJdjKI7/FItGXDPtP?=
 =?us-ascii?Q?/I+76FUMUE97htNP8uU7u7ac3018Uy3Tdwfs65W7c7CoVrSeMaHNDYGHfJqz?=
 =?us-ascii?Q?B2gx8ELtqOlEdOYpVvVhQMrIEf5sLY+4USPKCF2uM4XB0OQZYGjQo4mHJAjL?=
 =?us-ascii?Q?0SZuHFMooQ+E41VfmwtATm3RuQkNFNotoz5IYaumdfaMSVkD4KIQWPM6fjDI?=
 =?us-ascii?Q?4uxU/6MUTEa9aKyM6n7JsQu2pz65ENttkPjHMzsxOSRtizLegw5JbYhZROQm?=
 =?us-ascii?Q?yFBfjtbI/J1UJOimG3BkB4UWijXJffztnYKfJmrM/g8UOuewzni1+ivU2InV?=
 =?us-ascii?Q?TLAmJGw3j51Og50lvbFuDhkwV6BFrpKtHPSYB27fL54Qx0zUkTGBBNXYpogu?=
 =?us-ascii?Q?A/uyexAId5JT6RnUbJ40BqYBLMHBFcGWXLSg3Bs5folvGSJDQ0myxt1EKEIQ?=
 =?us-ascii?Q?pNqDIXr6B5OaQdCT1RIHYViVPTv20pMJ3WwSFdZaRALlA8uRioReu87MhQ45?=
 =?us-ascii?Q?s1Y5NAUblJwdNkpumDhgOXQN1zqq00jv7olphFT/7QdnCnyZygX96X6fHICf?=
 =?us-ascii?Q?JifVIU5Qg08WEJGs3BnTDl9b8cJtn/Zn/+ZrBjJkWc9DXUJYB3nMu6iizMx1?=
 =?us-ascii?Q?TDwOaNR0FE/yqDn0FiZwvZfCHDXaqfF2IwtBl23pcdqLUOLyAx5si7/JyRXX?=
 =?us-ascii?Q?IE+5W7fP+3xnjFSeC8xE2wl6Ii7Uef8cG11Xda6TsL6CC+yovzpUOCh140cN?=
 =?us-ascii?Q?41V0zS5IxLqjBggm9ac=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ef964a-acb7-4b7a-8987-08dcb0a524ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2024 14:37:31.5000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0CyTs7STEixVnsfOJSTKGN964n8CnZzMklwQDf86MicMm8AR1f3NJiS+Y+y896p2qZY75Xll8SQebItYvQvJ3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7028

> Subject: [PATCH v3 1/9] firmware: arm_scmi: Fix double free in OPTEE
> transport
>=20
> Channels can be shared between protocols, avoid freeing the same
> channel descriptors twice when unloading the stack.
>=20
> Fixes: 5f90f189a052 ("firmware: arm_scmi: Add optee transport")
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

