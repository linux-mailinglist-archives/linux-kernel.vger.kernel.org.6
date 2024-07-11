Return-Path: <linux-kernel+bounces-249215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C869C92E893
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 14:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C23AB23B25
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60A815E5B5;
	Thu, 11 Jul 2024 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bYaH1P0h"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013004.outbound.protection.outlook.com [52.101.67.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05010155C95;
	Thu, 11 Jul 2024 12:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720702497; cv=fail; b=p6gGWRP5fjxz9SmHh4uRvuYnso4B0/f95gaAu/9b6HsouJuflZohJUnjbeonj9EfGI7ac7YiLNc9j5wW/xlLLJP90gv93zP3VfLXG8iOervv+7MkiNcSaRweQCwTi5SqYlmY1ge8g2XJSlHJklgIvD6cMmJaID0eLHXei3IXL9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720702497; c=relaxed/simple;
	bh=zsyQ5KSOj5zjD8GM4WctXejEtni0jrCSO5aSPiuMXNw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eZXcxuFPG2zTZpOAeoUvt3uUUUpeGvEhoM1Wb/NbHaDXnLpR1QK0dG2U959ZBE5TSw56J+T0MuihaVPNcMZzF4AwfsAmWX1x8qB1fW3E0oeFKN+ZfIYOUMOsEtbkp4Z/LFB8dph5NKQG9iz5lIgx1DbE0Jqj33exR8q02tR3uvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=bYaH1P0h; arc=fail smtp.client-ip=52.101.67.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=boSZFndToDH2AuTwHA1CGJPCZJFEFnVDUa9XRnaqGqk78I2ReC1Bs/5wV0hzo9wd83B4+SZXE55MMrxUlPDFVD9QBX4Pn35N6d1AVdpg08UgwGBbceurqn8vXCr0cu/5uCIroiwHSjrupaJbhCoZSWS1UnlS8WXKMnReGotDlCtri1goTho9OWGCEAplXlwF7fO0azSvm99zz17/Uk0Uhry/auEJZ0UuqXPqrePWiWHPFDl5RbBJB0ma7MobYYUIEboD4sPbIU6p0Y7T+kSssL2kKZ57aCjkutd7GriajLc/n/KiBrmYe5nU5byGtR9853AmDcTwxqQavJnMeAdW1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8OKxH3Yf2Z//g4PgonOjAQ2oOBeQ2G/xKXLzWdR2As=;
 b=aTSmBZwwUy9+k2Gfrl8dK9mncuSbrqwKhmkd7Pc+gxoZvFs70NS5OXVOMDTH7EWFINYpHvUnLECIM3aPw5OEF45lfTWHaTOrjMBizlhivaBhxXfz3lnqvDpgUoJLzku82xxAbhXyxR3Mm8/R8vUhnXRpJa2Q3RXu5ppDhF1shuUVrc3qmuiT94SeMUxM+zAopvYR0GAgrSGUftiDTz1jbnX03oMwIoqQfTKOcCAuwpFEujkDMw1fOBSSMqebZwBSe8gGa+Ow5+BpV2F4tYl/WWav98bEKM//DjWXTpaTeOcG1ObjgXscb+zgA0QvLuH2PdubhK1BB4fzx5lkjoxCcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8OKxH3Yf2Z//g4PgonOjAQ2oOBeQ2G/xKXLzWdR2As=;
 b=bYaH1P0hAaJInew5McZHswQhBSLv04qUNcjAuSbYwYtdhRJkMK7IBTHZmjVqru9fYhMePBZrbZERW0h34ufYDtTStywlYxQnhxjBTMaQR7Iae9VPNU2KbzPicz8mbUIaANE6P2v122tLBwEKhtTtSPZhA07kv45ZVO9yZlNmkfc=
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9837.eurprd04.prod.outlook.com (2603:10a6:102:385::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 12:54:51 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7762.016; Thu, 11 Jul 2024
 12:54:51 +0000
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
Subject: RE: [PATCH v2 3/8] firmware: arm_scmi: Add support for standalone
 transport drivers
Thread-Topic: [PATCH v2 3/8] firmware: arm_scmi: Add support for standalone
 transport drivers
Thread-Index: AQHa0u8l4QDgqFKLyUOdvAUQzZlKIbHxfH9w
Date: Thu, 11 Jul 2024 12:54:51 +0000
Message-ID:
 <PAXPR04MB845936D3FE063B7009B3F45088A52@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240710173153.4060457-1-cristian.marussi@arm.com>
 <20240710173153.4060457-4-cristian.marussi@arm.com>
In-Reply-To: <20240710173153.4060457-4-cristian.marussi@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAWPR04MB9837:EE_
x-ms-office365-filtering-correlation-id: 74550f07-44a7-46ea-4fa6-08dca1a8a795
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?VN3kMWNiFNxV6sxa9jX6dwxIU8S7rqGIAy0iiHc85aoR8Opv1+d7TlRgNyJu?=
 =?us-ascii?Q?fbSrDMkaJde/U/r9VPnM2IZU97BRLKGx8U+Hjv0ak2oeXYkJgxX+p90y0HwU?=
 =?us-ascii?Q?GEuz7pCgnxnnNxw6xbiEKoIeDlln7PuRnfeBhhAjCqihU/R9uhaO6NJZVT/u?=
 =?us-ascii?Q?ITpMh1GbB3qpW2+96DdwpgbEydy07AKKbvKKEyCKF+07IOrhirkqfuG9sMTD?=
 =?us-ascii?Q?W3nzOORFbEh6CLNNad6etXHHsxmLkulKz4MnZaygzpoZ7P8cDRamz2PU7o3J?=
 =?us-ascii?Q?YlR8ippjKEpxtb6YLoaGf5ByvoxJDUFCwzE4hAKoiOfm9TpbFVN0SEBRF1nz?=
 =?us-ascii?Q?kNXFbkqDIWF79pYrOZhl7j28rEYg4L+vafjupsmXwxByOKePpPXom6cwwXRQ?=
 =?us-ascii?Q?pnuBXT3DzNPPPMOwnSGn9vecdeSEJbwed2I2mIxDPmW17PQBb3Wx+ZGlP7eq?=
 =?us-ascii?Q?8Io7AdylgoShPkMvXOgkHdO9vVBySKBjdyUSNDQL+cNGtn/9P1tvMIYCoIzv?=
 =?us-ascii?Q?09m3dpFRKyRsTU3U9Qk9SIR4akkYbrVc4Y1rIiyd8r5HSEuMrxGi00Jnk3gu?=
 =?us-ascii?Q?f4qIXP8porhGR948uOpt6pmp49SoLGzHjCb4I1RdQ6R3/442BgS4ypm7HScW?=
 =?us-ascii?Q?kMoAy2XRzRjM9+vle6e53bnjt/3+wE5EjFfsh3Y9EojS/iCPTUEmlXJIBIji?=
 =?us-ascii?Q?MhC0j+ZEQG7h1auO+1xM5ov18pEoyUGAYFECIUJPNt9GSevZXOTXRVUH0eAi?=
 =?us-ascii?Q?IRN3Pdp2YEP/EEuTv0v23G7uXM9ZnQlI8Msr6eV+1xxvs3PWUGIWuId9VjJm?=
 =?us-ascii?Q?ueGOEwMUgleoW57cSyTFhV+MO7GkZTpM7wT5k2ay7cmiy0wpUWjJxWKsaAB4?=
 =?us-ascii?Q?kmKDEhIeXX5eOPcQ9zgWf2Ib9vLLZS+97eavvG0x6Y50xwAmrSIfxG53gZS0?=
 =?us-ascii?Q?t8wE30J0UaApVOLXRYP08nf6T0lywfcJmp7XzLZs03XSwfp6XlPq6nOfRMvD?=
 =?us-ascii?Q?M27ZwwgENkHJ5kL2ZhfxjnXkl9OQg9Y9KJ9748H0+Wl8hX8OljqzWqFB9m3B?=
 =?us-ascii?Q?Lo0VpaLfqnL9R7wQSNObkYNHjJ4UpoHl7yiLMV/pL8qERdz1POl5sEb4uGmH?=
 =?us-ascii?Q?ChZhnegnVC6F3GPcnjW3AjqNpY95SDo72n7bZrYjCB9zZBwWSdtrNxL5FO7o?=
 =?us-ascii?Q?YOuNeb4gaHuQ6S2K8ZQu4+GHgmaxlibfSTXAJk5+IiSWTEzgpOZ5vamQZRwK?=
 =?us-ascii?Q?7rhD0tVuDrtUCfvbiyk4G7PgxWdtd8m4xGZgZUvIcg562zX8VwidHGfGa+nD?=
 =?us-ascii?Q?uIghQpkoe6ZAsI+tgrYOnU3bBvaQDmfGUJ8Aq9TO/81M9hqVsujdGP80+GcJ?=
 =?us-ascii?Q?B9AT89uHe6BP6R5BAYzlfvc3Yi2f8QKOEesARJ9ti3MgIU3diQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YoOkYOec3P2ivOWMIAVTZ+0qddcR6ukBpvrOBxnDqMKxbKVqvjBSpUzADN7P?=
 =?us-ascii?Q?6xX4HPIbwuF4BkWGW+2fwfgF65ia2Za8uYdWioNE44gzM3nhHd76ubZfcauJ?=
 =?us-ascii?Q?Mbje33omUbJ7a0/v0sOYNlxP9S9PAMmqCJiVpjoYIr8ZZwshbEQZEHdehtQX?=
 =?us-ascii?Q?/vo2UrC8QD6OuQTyw0HPZQz6rbAUPwu/lliAK5EF+wBHvKyHUA+lO+vqxzyA?=
 =?us-ascii?Q?SlX7mBINCv+3gZq5zPj79D9XtYI/c0vd7Kz5p2tovKUyCW3eIxgu/j49QsSg?=
 =?us-ascii?Q?T8ertfMKUmQRKltzLlN3TN73jhOL0p65qNUpGH0XNmuCd4gzgq+x+LhQsRXx?=
 =?us-ascii?Q?4KsN/kKWfcaAsZVY/m4vERjkqOwDGYEOPCLFM5j8Uryz2cWdmn2Kx8EHnGo3?=
 =?us-ascii?Q?vb73EgHHW2FBLj3W38COTActwMsUJGcLFC+C/Wep51rWYrn9MTbw1djyiw7L?=
 =?us-ascii?Q?RKBT+L8DhC8Qyc1Rrclax2NrYMV5mTQMP+mnWcMavpKj0SNz86OlS2DJar64?=
 =?us-ascii?Q?brRSfODAyhuYuX+mYQN7F3RfyUmDbIpBRHYmbW/tKUITx6J6K/jF9Lpi2aE6?=
 =?us-ascii?Q?iGqao3iLMm6Ba8W6oABvLPyMV5FwKacrIbXGdHrtynFAvluo6huUBAug9dj4?=
 =?us-ascii?Q?fIiqcR20dVNmK03LfoJehOJpPA/YJ7Pxik/GBaiB1Am+tNxChMwWAIzEMxwC?=
 =?us-ascii?Q?5T+9PiA0szojQ9L71EJ8eTSTLTEXvLcXG99FlKLq09kyfpO8fEJOlceSFeN8?=
 =?us-ascii?Q?/ENymlDWfXuNDgrRJ9hOAIn//Ww5qWNHwgVXTtr2t3pLK5m+vnbgNw8Yznon?=
 =?us-ascii?Q?viS4Pq3xz49dc1QTYozxO4FVB40OTu7IWxdXOL7ml0JVcISuM0REl1N3tepp?=
 =?us-ascii?Q?LuN4MQe1JHh8jRvXhrOi21GFmP7DAR4Ht/l1V85lwPD2cC0iAXDsqc+sHQv6?=
 =?us-ascii?Q?Hs1K2yFnENwc0XhBnk9xw6sdzD/fZGDGftbmmPFS+a2x6gM+HtW4cHvsnymX?=
 =?us-ascii?Q?XOB2h9RqZT2Fu037Nl247182CKpDlueBCm9ym3G07X2aa/UenNFZLRT4XGwk?=
 =?us-ascii?Q?SNIrDOf7oVhgCos8t1F7LQbvzBSpw13eQmsaYdJiS8lSuhtad5y9Hq+BeA0K?=
 =?us-ascii?Q?lcZV2dD9dt0VYFPPoCACYABw/KQwV+l3r93bLFhNAxbsuCrM4u5DwDiKaBSQ?=
 =?us-ascii?Q?J24FbuCU4F2JwqlHshA/RBO+fDHMueuTYC/THHs257rEUQ1+E44C1MWNjFJe?=
 =?us-ascii?Q?sQiC7QaRFF0ZL63qCK+QpixYVyF9j4hsXIaZ7MM17PDaJwepgQ7HO3r7znQJ?=
 =?us-ascii?Q?TMa8xAdPmcfUPYyaaSBRMmfjU1ZUjb2EtqTDLsXQ98z765oCn7mb/YWK74uu?=
 =?us-ascii?Q?AgtmBsW0ibwB13xaSdHyX6E6KpzWRCgKKnis100PksoW1ldQL2eW7XYP8aG0?=
 =?us-ascii?Q?EkyCisCignOydwELeAEgh3kjBMkm+sMy/9jodOz1KgGULT6av2J2JEy6SNpr?=
 =?us-ascii?Q?NDaHKD/ElnklkjpM0lScuxwXPl+7iVpPeTNb0VfR+Z36tT2WYOKrR4mYdBvN?=
 =?us-ascii?Q?/HGSB/xQokR61P/Z+bc=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74550f07-44a7-46ea-4fa6-08dca1a8a795
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2024 12:54:51.7413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +6K6b311x7QloTDn5VhYh5WEd5HOVj64djDhS2hfS3r1EkxAvqUqELq/rvLo1UddutHivDQ3wX253X0ujPTZbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9837

> Subject: [PATCH v2 3/8] firmware: arm_scmi: Add support for
> standalone transport drivers
>=20
> Extend the core SCMI stack with structures and methods to allow for
> transports to be split out as standalone drivers, while still supporting
> old style transports, defined as built into the SCMI core stack.
>=20
> No functional change.
>=20
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> NOTE: old style transport support will be removed later in this series.
>=20
> v1 --> v2
> - fixed comit message
> ---
>  drivers/firmware/arm_scmi/common.h | 84
> ++++++++++++++++++++++++++++++
> drivers/firmware/arm_scmi/driver.c | 44 +++++++++++++++-
>  drivers/firmware/arm_scmi/msg.c    |  5 ++
>  drivers/firmware/arm_scmi/shmem.c  |  5 ++
>  4 files changed, 136 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/firmware/arm_scmi/common.h
> b/drivers/firmware/arm_scmi/common.h
> index 8e5751aaa600..4af06810eb39 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -349,6 +349,8 @@ struct scmi_shared_mem_operations {
>  				     bool tx, struct resource *res);  };
>=20
> +const struct scmi_shared_mem_operations
> +*scmi_shared_mem_operations_get(void);
> +
>  /* declarations for message passing transports */  struct
> scmi_msg_payld;
>=20
> @@ -376,6 +378,88 @@ struct scmi_message_operations {
>  				   size_t max_len, struct scmi_xfer
> *xfer);  };
>=20
> +const struct scmi_message_operations
> +*scmi_message_operations_get(void);
> +
> +/**
> + * struct scmi_transport_core_operations  - Transpoert core
> operations
> + *
> + * @bad_message_trace: An helper to report a
> malformed/unexpected
> +message
> + * @rx_callback: Callback to report received messages
> + * @shmem: Datagram operations for shared memory based
> transports
> + * @msg: Datagram operations for message based transports  */
> struct
> +scmi_transport_core_operations {
> +	void (*bad_message_trace)(struct scmi_chan_info *cinfo,
> +				  u32 msg_hdr, enum scmi_bad_msg
> err);
> +	void (*rx_callback)(struct scmi_chan_info *cinfo, u32 msg_hdr,
> +			    void *priv);
> +	const struct scmi_shared_mem_operations *shmem;
> +	const struct scmi_message_operations *msg; };
> +
> +/**
> + * struct scmi_transport  - A structure representing a configured
> +transport
> + *
> + * @supplier: Device representimng the transport and acting as a
> supplier for
> + *	      the core SCMI stack
> + * @desc: Transport descriptor
> + * @core_ops: A pointer to a pointer used by the core SCMI stack to
> make the
> + *	      core transport operations accessible to the transports.
> + */
> +struct scmi_transport {
> +	struct device *supplier;
> +	const struct scmi_desc *desc;
> +	struct scmi_transport_core_operations **core_ops; };
> +
> +#define DEFINE_SCMI_TRANSPORT_DRIVER(__trans, __match_table,
> __core_ptr)\
> +static int __trans##_probe(struct platform_device *pdev)		\
> +{
> 	\
> +	struct scmi_transport *scmi_trans;
> 	\
> +	struct platform_device *scmi_pdev;
> 	\
> +	struct device *dev =3D &pdev->dev;				\
> +
> 	\
> +	scmi_trans =3D devm_kzalloc(dev, sizeof(*scmi_trans),
> GFP_KERNEL);\
> +	if (!scmi_trans)						\
> +		return -ENOMEM;
> 		\
> +
> 	\
> +	scmi_pdev =3D devm_kzalloc(dev, sizeof(*scmi_pdev),
> GFP_KERNEL);	\
> +	if (!scmi_pdev)
> 	\
> +		return -ENOMEM;
> 		\
> +
> 	\
> +	scmi_trans->supplier =3D dev;
> 	\
> +	scmi_trans->desc =3D &__trans##_desc;
> 	\
> +	scmi_trans->core_ops =3D __core_ptr;
> 	\
> +
> 	\
> +	scmi_pdev->name =3D "arm-scmi";
> 	\
> +	scmi_pdev->id =3D PLATFORM_DEVID_AUTO;
> 		\
> +	scmi_pdev->dev.platform_data =3D scmi_trans;
> 	\
> +
> 	\
> +	device_set_of_node_from_dev(&scmi_pdev->dev, dev);
> 	\
> +
> 	\
> +	dev_set_drvdata(dev, scmi_pdev);
> 	\
> +
> 	\
> +	return platform_device_register(scmi_pdev);
> 	\
> +}
> 	\
> +
> 	\
> +static void __trans##_remove(struct platform_device *pdev)
> 	\
> +{
> 	\
> +	struct platform_device *scmi_pdev;
> 	\
> +
> 	\
> +	scmi_pdev =3D dev_get_drvdata(&pdev->dev);
> 	\
> +
> 	\
> +	platform_device_unregister(scmi_pdev);
> 	\
> +}
> 	\
> +
> 	\
> +static struct platform_driver __trans##_driver =3D {			\
> +	.driver =3D {
> 	\
> +		   .name =3D #__trans "_transport",			\
> +		   .of_match_table =3D __match_table,
> 	\
> +		   },
> 	\
> +	.probe =3D __trans##_probe,
> 	\
> +	.remove_new =3D __trans##_remove,
> 		\
> +}
> +
>  extern const struct scmi_shared_mem_operations scmi_shmem_ops;
> extern const struct scmi_message_operations scmi_msg_ops;
>=20
> diff --git a/drivers/firmware/arm_scmi/driver.c
> b/drivers/firmware/arm_scmi/driver.c
> index 6b6957f4743f..a1892d4d8c69 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -194,6 +194,11 @@ struct scmi_info {
>  #define bus_nb_to_scmi_info(nb)	container_of(nb, struct
> scmi_info, bus_nb)
>  #define req_nb_to_scmi_info(nb)	container_of(nb, struct
> scmi_info, dev_req_nb)
>=20
> +static struct scmi_transport_core_operations scmi_trans_core_ops =3D {
> +	.bad_message_trace =3D scmi_bad_message_trace,
> +	.rx_callback =3D scmi_rx_callback,
> +};
> +
>  static unsigned long
>  scmi_vendor_protocol_signature(unsigned int protocol_id, char
> *vendor_id,
>  			       char *sub_vendor_id, u32 impl_ver) @@
> -2950,6 +2955,28 @@ static int scmi_debugfs_raw_mode_setup(struct
> scmi_info *info)
>  	return ret;
>  }
>=20
> +static const struct scmi_desc *scmi_transport_lookup(struct device
> +*dev) {
> +	struct scmi_transport *trans;
> +
> +	trans =3D dev_get_platdata(dev);
> +	if (!trans || !trans->desc || !trans->supplier || !trans-
> >core_ops)
> +		return NULL;
> +
> +	if (!device_link_add(dev, trans->supplier,
> DL_FLAG_AUTOREMOVE_CONSUMER)) {

Just wonder why this is needed?

> +		dev_err(dev,
> +			"Adding link to supplier transport device
> failed\n");
> +		return NULL;
> +	}
> +
> +	/* Provide core transport ops */
> +	*trans->core_ops =3D &scmi_trans_core_ops;
> +
> +	dev_info(dev, "Using %s\n", dev_driver_string(trans->supplier));
> +
> +	return trans->desc;
> +}
> +
>  static int scmi_probe(struct platform_device *pdev)  {
>  	int ret;
> @@ -2962,8 +2989,14 @@ static int scmi_probe(struct
> platform_device *pdev)
>  	struct device_node *child, *np =3D dev->of_node;
>=20
>  	desc =3D of_device_get_match_data(dev);
> -	if (!desc)
> -		return -EINVAL;
> +	if (!desc) {
> +		desc =3D scmi_transport_lookup(dev);

from the code, It is not actually a lookup operation.
How about scmi_transport_setup?

Regards,
Peng.


