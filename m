Return-Path: <linux-kernel+bounces-352197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44458991BA5
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 02:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95725B21B6B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 00:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8568493;
	Sun,  6 Oct 2024 00:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IM6/7l+D"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012010.outbound.protection.outlook.com [52.101.66.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF98BA920;
	Sun,  6 Oct 2024 00:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728175157; cv=fail; b=Dr5MYGbwQnjqLH0gC+ZQ32YmBH/3GEZEfyNj/VeTWqH5jS8hg/Mil4/5efA9VPyhNrdHDHV6Eg3uO1qq43oCzswbZBgrgdpquIhlHnfIpQ2uQnT39xxwyXPEo3tGT6FkZYSm4SQo9/JQt3SeIah7Q71eRWxCOFuuHfvF3a2yQaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728175157; c=relaxed/simple;
	bh=DBZbsfa2RYAbizY3IAIgaJfW+Q68lZGzaltwC8xa+CU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tKwt4bPTUP4KhQrN/EKuJjX2icH0CbMlfNP/POU7Xv8b8cCv4Oe+jcNvjyMeMzGVAd4jloODla+LdCX8DkGYZ1OKeo7L5oYvu8E/b8rWhuW2NkxxJjlYL8XrdXzkN65JNqUvWcnZWkErsUKWG6S1JyLf1Y9eSYjir2qLI7km7+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IM6/7l+D; arc=fail smtp.client-ip=52.101.66.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lg8FLdt9aNIU4fM+yYSHsSlr0ABCbjXjTumcLof02zno/T0Xb/+5gPK/4JEehmpvepfBEc6x8v52Dg1YIIritlihDfSRBpEJA9lAunmv2AZKxYFALlN5AhX4UTMzx22R7WfqnZvI5FTcOutZ9i6RWBaRFoO+995TxHdYaA1xs5KibiYQ2Adoz+TMm0DQGgWHJO6eg777ACDIwBe2GW+75gVMQn4fcIipmRGpbnva/lohHPRlGKY6+xnewv8ypIJyrUDSrjmJUautJjXQiK9yKj0j9NJyDs9WJRacdTDngC992Nco4nGUF3of5+TFWYQcjGCwy1dygvw6USo9XGFUNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBZbsfa2RYAbizY3IAIgaJfW+Q68lZGzaltwC8xa+CU=;
 b=VyzNgY4s9FY20GxzDIT304ciAxPcnLPlZitZEveGmtHCVd8Kymf/ZsTHBAxIU5+40pFnYz4K6wJdq4ijhLAk3by6zmpYFOI3MUNxUm0NiyKAzjdXEM2hLqU3pxHBeD3Lc9gczx+rjxMncRK+lATMYNcMZpwNexxYgB7wlC1fH1AiO9HHg0AQqdqMTOxHllD2HP4OaDccK8Avl8QShqf8PqduEFNZWtXGzRDtan3U1kOy5qyjjGKhi4yFs9PnItWdrAElUWyPG9HiDOz3uTM2N1/PCzG5eHN/EeACMIKdfJkn8kcCYUjUfE2T0xOQswnvIsQSnVbY5+4AOgCQ4Jdc+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBZbsfa2RYAbizY3IAIgaJfW+Q68lZGzaltwC8xa+CU=;
 b=IM6/7l+DtS5wazWc3kswUpJPFEiQ5TPOnrRYv8hC1Ki6f4J81TFSnbAwGBv/otEdf6Q2iQjg+ldpD2M7zW/wTXhjsds0OH2UkfwW9MfuZ3DFdybG87gvydk650/z1N+ba+RPUEpIyC5MjkrXfjKO+qlNO2HFOEZkpG5+2KGNxzSFszOyk504hXsjET5/YYsMfnlswm+javcNe9HECR4X3NpqGO2EAq4absz0KKXJNU3JPOxZGCqNCnONo5TC9F9+JCysUHHzF5RSErZq5qkYSRoMWefyctqIVvVykc2cjZAqHBtluKwRc3Zk3xl66T5qXz2fGsuEuxYgaoelmHWapQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DUZPR04MB9822.eurprd04.prod.outlook.com (2603:10a6:10:4ad::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Sun, 6 Oct
 2024 00:39:07 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8026.019; Sun, 6 Oct 2024
 00:39:07 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, Tudor Ambarus <tudor.ambarus@linaro.org>
CC: Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav
	<pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, Richard Weinberger
	<richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Marco Felsch <m.felsch@pengutronix.de>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 1/3] dt-bindings: mtd: jedec,spi-nor: add optional
 vcc-supply
Thread-Topic: [PATCH v2 1/3] dt-bindings: mtd: jedec,spi-nor: add optional
 vcc-supply
Thread-Index: AQHbExkPStgmT2vAPke7viS8UCdlyrJwDVUAgAjbx8A=
Date: Sun, 6 Oct 2024 00:39:07 +0000
Message-ID:
 <PAXPR04MB8459585E8FBA28A47EDF3797887C2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240930-spi-v2-0-ed7f6bcbe0df@nxp.com>
	<20240930-spi-v2-1-ed7f6bcbe0df@nxp.com> <20240930111852.0fcb731f@xps-13>
In-Reply-To: <20240930111852.0fcb731f@xps-13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DUZPR04MB9822:EE_
x-ms-office365-filtering-correlation-id: f308ac5d-a316-40b3-472e-08dce59f4959
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NmE4elZ5VVRBVG5LRkdFK1ZCWlBBN3Z6RzVXU2hWQTBxNFJtblJlQjZoYjNw?=
 =?utf-8?B?c1N1aGg2RDQxT1ZUWFVnd2dCUlhhSXZnUXBLMXNVNzl4dXZFYmY4T1hkMEU3?=
 =?utf-8?B?bktISlR4bUhLY3oxMnJ1R1QwaHRHQ2pFZ1NyMTNiSFo0c2EzNm91bHhZaVUy?=
 =?utf-8?B?aWJSbUZsTnF0c1NuL2RHNDM0ZWo4djBPa25vNmIvcjBJRmNGelJiL1Jqd0xR?=
 =?utf-8?B?YjBVTDRMQUpmWTdCVWN6SjNtRDJnbFg4OXFuRW9sUUlmQmsvQWxjdm5iRENL?=
 =?utf-8?B?MWFpNVZlNG4rb3BUOWFLemdhVk1RdmJMUjZ3ZGgzTmlvZy9aR1BhR1JyakQ0?=
 =?utf-8?B?dXdLR3NGd3ljNmp2NHpTWTlvamFHQ08wQzJhYkozdm5KaUJzWk9nMEVWVG5u?=
 =?utf-8?B?cVdYazEwRjBGK3JrL041Z1YyNXJDKzZ1QUVEa1JOUVZJS1FWUHl5cjIxS1dH?=
 =?utf-8?B?OHFLWHVyTHArSVNkYjAvQ25oZDh4VFVsY0xseCtLVzY3Q052aElnQjh0M2d2?=
 =?utf-8?B?ektyVStCcTZ0aStkajlyUVpKc0lQa0VlQzhUWXZrS3JDOGVkb3lXNUJDK0gz?=
 =?utf-8?B?ZHJycHNFLytBVWtiUW1TVHhCWDBuV2J0TzBGcytiSFhJYWlyL1BFNlhTa2da?=
 =?utf-8?B?bWNyY3RabXEySWJsWkQrdkVqSzQ3VVZJdW41R3d6c1B5QlRBNTJKRnlLL2Iy?=
 =?utf-8?B?VjJTaDJNR3U4aktRc2ZqSEVLb2tVLzdqUi9jTU4wWWI5a2xVeFdwT2RzVkpC?=
 =?utf-8?B?dXE3dHNkVUg3MUJXTm5zVWJOSVdiUldUSU9ZaDVjNzJnVjREWVl3bjZxNjN1?=
 =?utf-8?B?b0IvOWRzcW1CUXArSkRMd0dXOUVZWm4vQ0RjNlR5KzhYZ1hORFJVY3h2SzVK?=
 =?utf-8?B?RzNJNlg0Wk5TeFd3KzFkYWIycFl6aTFaVXUrNGpoUzdCWk9FQm54aVkyYVFm?=
 =?utf-8?B?VVhDOXNMZE1XNU5rMWZSZk5wUHA5TUU5OEhWb3lULzd5UFIxMDZGOEt2dTJD?=
 =?utf-8?B?d0t1VGVRYWR4T0ltSytsKzNIRUhhbitNTHZ3ZjFIdnVXb0Q3OXZWTUhVNjg3?=
 =?utf-8?B?UDZQYlB1SVcrOUpEMUZKeXl3NnNsOFFTcDRSWXVQcExiL201cUdjdHpxR0p4?=
 =?utf-8?B?MEdKZ0Z0eGZnMjViT05mMDlmYy93YTVrUG9aUVJUTmRIQ1lZTzNpWC9QK2lv?=
 =?utf-8?B?L0lCV1F3cXdKRUFKcGpJTUJjTnNSMm1EQnhEVlJzcDArckRkRk5qZk1lbS9y?=
 =?utf-8?B?N1pVMFFGYk5uMnB4UGFxUjc5L0NLWEc4Wk5zZUV6WThwamRGdEZDYllkRmV4?=
 =?utf-8?B?ZkJrQTlwM1JRUkRta21MYjNoL3RhOXJ4VGh2OEQ0VFQ0cU9wRVE5bElGenN1?=
 =?utf-8?B?d0c3TDcybzI3U2Fya29XeTBWNUZadzF5S2I2bFcydFdweDQvdDR4SnQ3alJv?=
 =?utf-8?B?MkxOelZRYW5PTFhpSTBESFBLTExscnZLYy9YYlNXUndmM2VSaDlWVHhtNTBW?=
 =?utf-8?B?VzFCRHFGZ1FLQXlsS2NZUzJ3NVJ2Q3dmUTdBaEpMTG1vaUtFUkpWZThwUHFG?=
 =?utf-8?B?N3RjRy9JWENkSm12M1RPVlF4bnRnNmlNaFlJK1FZL1BNZkZCQWZIOE5yQ01F?=
 =?utf-8?B?VTBiSmE0dDEzSGlTMmFFRmNkNnQ4WGhhTlEyT0Z5T1UvV2J1cTJ3ZlZQbkNm?=
 =?utf-8?B?VjJpRXVoNCs1d3QzdjFSTGtLTDJlUzF3RkFEWUFrenN4cnlrajFxbGprcFZP?=
 =?utf-8?B?bEhTZHRoWEdYTVpTd2hHanBmUytFekJvbTE2blV2NGQ0cmZSdzRxUXBQODdN?=
 =?utf-8?B?SjlVVU40Vmw1U0VaRDUvZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MWtObmJKUUpsdFhVSHhmenRISW1QMjl0TUVGcUlMUXF2NDZLQWJNK3UrRmFl?=
 =?utf-8?B?V2NHNE96NVNzQmJSRW5JMjlEL0hibyt3eENaNkc3dVdkNzRMY1oxMGtVNzZu?=
 =?utf-8?B?eU41NDlUaGZtYXVJR203RHhnK0ZPMmc5dHg1N01YSkRVRU1OSHV2ZWI4c1BU?=
 =?utf-8?B?alJ4NTg5V1hudUhJMXUrMUQ5ZzgyVlUrM1kxcm5EMk05R0ZXZFVuTE56MzhU?=
 =?utf-8?B?UmhmS3IvUEJsNzZMeUF5NURSUllxcjQ1SSt4ay93TzVteVltbnB4dDQwTW1w?=
 =?utf-8?B?bGI4R2Y5RStodTk2UWJqSFVEZU9md011bSttVlB6RHNDQkQvc3BJSlU0WlZH?=
 =?utf-8?B?RDdpVG40WER4SGgrOE5lbEg2VGdrdzdpQkxsN3ZNalBOY3BxbUdQUjErUFNy?=
 =?utf-8?B?N3MrUHZJdW80TjZKMjNVL0Raak5scnVvNk9HTlVaS2NhYjgxRGJvVVFrQjZX?=
 =?utf-8?B?TERUSTB6clRNbjc1VSt5SHVmZzNZZUNhOTVVNGQyUW0vUGxWaUx5YkVTMHZy?=
 =?utf-8?B?ZC9mL05sNTNxWGc1WEZCMGRxS203d0VWaWgrK2l5L2ljSVFOSkRIUG5wcVpv?=
 =?utf-8?B?ejRWK3NtemhyREVPMjFmaFh1clNpalVyN0t2a0NKamExSThzOGxpQWVFV2lI?=
 =?utf-8?B?dFpveHoyVGZ4a3dOK1Q2UkNvUW15ci9TR3RWdEp3TmwyRU1iNi9LNlIrOFV0?=
 =?utf-8?B?L1RvNCtpTHE1ZWtBaDlYUzdXZWpOdTQvcmtMMm5MMFZyNmF4OWFKUi82UVVD?=
 =?utf-8?B?eW1FNk0yUGxZcnBNSEpNNWpmMmdSdFNxWWIzSk1JVjNSN1VEU1lrSWFsV0hQ?=
 =?utf-8?B?Z0xBWHI1aDlGak40K2ZHb3UwTi9sNEFLRk4wRWwwcEoxY1V1alN4MS9IUFdW?=
 =?utf-8?B?TTUwWmVEbnkxblpyNHI4b1Q5OVhYWTBET2JBRmFVQ2FmSVJmWHJzbzlCZTBX?=
 =?utf-8?B?L0NKSUsyamtpSGlEM0xWTEFXMU9vdmg1T3A4RGFFTmE2Q2V5TE1LNktmcm0x?=
 =?utf-8?B?ZmdGckUyelBiY2NJU013ZnFpS2tSS3ZZWmYwdTdDRmFmaEYwRUdOUFBWUUVt?=
 =?utf-8?B?V20zazVQNHUxc3hDMWdCL1VHQkl5Q3N3M2JySjNLQjJrMGRGZ3gvVkkwdjkr?=
 =?utf-8?B?MXdlUDhyZ2czZFYwZHpQTEhXUlRWOWFWNGxBZFBtWU1WMTd1QnFKNjlQSktL?=
 =?utf-8?B?Zjd5Wks1QWFZck9Ud3N1ZjBudVNUMlBZZmFDVXJ0T3dIQlNvOWZLVStOL1Uw?=
 =?utf-8?B?eEdHM2dFWHh2cUs5QlQ2UWdJMzBmRnpFU2FKc1JiUXdhUzBwVVdjMThMV1Nm?=
 =?utf-8?B?eGpNN1plRVdhQVFQR2FUNm1RbU4zSFUva0FmYnR5aUc1MURQVkhReVl3SVJV?=
 =?utf-8?B?SzJRZjhlUURzZmtrQkZTckFsQkxQdXZKdzlSNWZWMG1tcG1veUlpZW8zTU9W?=
 =?utf-8?B?UXI5cmZwUk0wWkZuKzRXcUtnSTVxVHJvK1JwWlB5QVpvOVVOcGtXZ3A5UFNh?=
 =?utf-8?B?Q3lOa0tjRGdhOTN3YTZ0NWdBMTVtS2J4QUhNa3BCSWJHZHBNYjhtZFdBKzlG?=
 =?utf-8?B?dVBDWFBsOFQzTVp0TDNyRmxiZXhNQ28wamtHajFvbVRTN1c2cGlxSmdJWWdj?=
 =?utf-8?B?alNQQ1JVaTZBSWRRNk81aC9ZSll3QUlPVUEvVUs5MklNUG41WnRFdjZzd1JR?=
 =?utf-8?B?QjdyMjcxN0lOejNkdnNNLzh3cGU1QVZ1emF4Zm0yS2JMREEyYmtocmNCUytG?=
 =?utf-8?B?a1RxNWdvQXphWXphWWdNbkVXYXRwaFBvcmZNL2pJZUZvZVVpTklCU2ZlWFBX?=
 =?utf-8?B?QmUwMDV6ZmR4VWF6YXZSZmFHVmxCS3RQS1lJTFNWejNRK1JtdGlwVzNYRm82?=
 =?utf-8?B?Y2xUckR6UE52cGwwQXZTMmxWZFZibFY1eU5Gd0lub3llb3VCZGQvdlJIODMr?=
 =?utf-8?B?eG1INURpZEdLOGZQbzJ5QWJJdmZqU1V5aGxQV0NUMEorbGphNFdIVVJZS1BJ?=
 =?utf-8?B?M3pra05URzhiT0V4QllHejFTaHIrdGFESWhLYzVtUkxxck1wckRiSFhRb0Zj?=
 =?utf-8?B?NDNpQVdmKy9Tdi8rL2FwL3hvRmh6QWJzUzBhUkhwYitickRhelJTN1lPWVk5?=
 =?utf-8?Q?Lwng=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f308ac5d-a316-40b3-472e-08dce59f4959
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2024 00:39:07.2496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VXcwTj2hV7iRU6KVNgwDydYS2rAHoNXc9irjcQOX2pDlD9QGaj1sdKzny4H42N/r0N5PhU0Xg2tsIl96SP/tVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9822

SGkgVHVkb3IsIE1pcXVlbA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMS8zXSBkdC1iaW5k
aW5nczogbXRkOiBqZWRlYyxzcGktbm9yOiBhZGQNCj4gb3B0aW9uYWwgdmNjLXN1cHBseQ0KPiAN
Cj4gSGksDQo+IA0KPiBwZW5nLmZhbkBvc3MubnhwLmNvbSB3cm90ZSBvbiBNb24sIDMwIFNlcCAy
MDI0IDE3OjIyOjI0ICswODAwOg0KPiANCj4gPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5Abnhw
LmNvbT4NCj4gPg0KPiA+IEludHJvZHVjZSBvcHRpb25hbCB2Y2Mtc3VwcGx5IHByb3BlcnR5LCBT
UEkgTk9SIGZsYXNoZXMgbmVlZHMgcG93ZXINCj4gPiBzdXBwbHkgdG8gd29yayBwcm9wZXJseS4g
VGhlIHBvd2VyIHN1cHBseSBtYXliZSBzb2Z0d2FyZQ0KPiBjb250cm9sYWJsZQ0KPiA+IHBlciBi
b2FyZCBkZXNpZ24uDQo+ID4NCj4gPiBBY2tlZC1ieTogUm9iIEhlcnJpbmcgKEFybSkgPHJvYmhA
a2VybmVsLm9yZz4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNv
bT4NCj4gPiAtLS0NCj4gPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL210ZC9q
ZWRlYyxzcGktbm9yLnlhbWwgfCA0DQo+ICsrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5z
ZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9tdGQvamVkZWMsc3BpLQ0KPiBub3IueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL210ZC9qZWRlYyxzcGktbm9yLnlhbWwNCj4gPiBpbmRleCA2
ZTNhZmI0MjkyNmUuLmJhYjA2MTdhNTFkNSAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbXRkL2plZGVjLHNwaS1ub3IueWFtbA0KPiA+ICsrKyBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQvamVkZWMsc3BpLW5vci55YW1sDQo+
ID4gQEAgLTk2LDYgKzk2LDEwIEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICAgIElmICJicm9rZW4t
Zmxhc2gtcmVzZXQiIGlzIHByZXNlbnQgdGhlbiBoYXZpbmcgdGhpcyBwcm9wZXJ0eSBkb2VzDQo+
IG5vdA0KPiA+ICAgICAgICBtYWtlIGFueSBkaWZmZXJlbmNlLg0KPiA+DQo+ID4gKyAgdmNjLXN1
cHBseToNCj4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsgICAgICBTdXBwbHkgZm9yIHRoZSBz
cGkgbm9yIHBvd2VyLg0KPiANCj4gCQkJU1BJIE5PUj8NCg0KU2luY2UgdGhpcyBpcyBhIG1pbm9y
IHR5cG8sIGRvIHlvdSBleHBlY3QgbWUgdG8gc2VuZCB2MyBvciB5b3UgY291bGQNCmhlbHAgdXBk
YXRlIHdoZW4gYXBwbHlpbmcgdGhlIHBhdGNoPw0KDQpUaGFua3MsDQpQZW5nLg0KDQo+IA0KPiBU
aGFua3MsDQo+IE1pcXXDqGwNCg==

