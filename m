Return-Path: <linux-kernel+bounces-385467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FE99B3787
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 615121C208DD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50D21DF737;
	Mon, 28 Oct 2024 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="migZAVwE"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2137.outbound.protection.outlook.com [40.107.21.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9732F1DF724;
	Mon, 28 Oct 2024 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730135999; cv=fail; b=RhAFHqnbYL9aSoHAPQOf29u/U68o27iWaAqj4PeOZouAD9n7o8YeLjM9C4YWhbX9kMwDNCqR7ike/bVe9kThOS9TPPru/nzhSwNYBstycxhU35xFYV+zrs26bzW7PT7s0kHlPlixwA3otMuHrgMq9zg6MQuPqVcTNE94HwOc+UY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730135999; c=relaxed/simple;
	bh=y9lLHnU/UxGSYiLmVA8lEaAAg3ydNxE1hqSpfnYIzYs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mLtQ5GjcURIARPIzKiCsREs6vMIkcwN6sACT+3stt4JCNhImfg1+Ztx7yVH+yfjN3NnLbQYoL/aL1RsOwS+6Aj/U5IsBXha85RPm6XbaUr7vJPqJcud/vaZCNQN/gqghWYXV9TFprsSkdKe/q4jLK0gthdG1jq+CtQ7oUEfC7wE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=migZAVwE; arc=fail smtp.client-ip=40.107.21.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1xTxYcScVx5DSIEPerJDeUpGgMzutS6HKiYzPUUFkIs9NmD+CvaHW7jYm/fo+BzHae6uXDk19N+vd/OkIbaBABRl0IFtsRpP0iB56xVyX/CDrOCW5VKNCiCWfhRXX1vS2xscdpxIh8+4JRqusfjjtFQ7s6mwoGUdCzNyn6tLgFh1oCOotjOELdVbyXGcYtQnESgyBszc12sjtTGMGrwSgM4sIPWbS3s/21UOGg+X4dGP4pcY9yoVVJ6LdJwEPuUQ8B+D3KvJIQosazJQGEO4DrJlmRU2czVRYZsxaccMCTEtQH7zLBPN/n/ZCfa+f2aaBdKADFfV8QUOUFvk0rpLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9lLHnU/UxGSYiLmVA8lEaAAg3ydNxE1hqSpfnYIzYs=;
 b=yjy8TEZmOa6cOMx0VsGhvpzClfgFZJfWsg6Dytw7IS6QV9+PtGzV4Ky2G+mAjPCPD3q78MUYoEPnat+KF1e5ZnyTKOELbDzrYyLbB4vBib6XMWuERxWjVUoz4PAuuC/0W89URYddXyRyxQ/jwwn4JYqpjxdBG3rJXslpAHfecIkDAteOw+SQOz/8FKjUIhyfWiYZZC4bUXAPJ10VA8Rot+i+cgwnyE+zBCO30TrhFJKatlh9Fpn6B0v+bppcQEQyXbtf+qt7fjQExx6I7YyFS1J2GKXWmx+PWKfoYE2QpB+E5eXt83UrBONcdt4ddofIqG7O3/0QEC7tcY6vtw1+XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9lLHnU/UxGSYiLmVA8lEaAAg3ydNxE1hqSpfnYIzYs=;
 b=migZAVwEcI9Vw6qq6Xx3b1CenfiSH57dYPEwJleF69ZdE+jY23riBchWTiMayIw5N69P29cSs3xEFJaF9lHue7qvWevCm4pWiCA2fScUwC5Dgdai7MiT/u8GmUmBWOXgothQ8InlpDBLGu2FDMlXCXOdcc1ogNrBJt+UHEIk2Yg=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by PAXPR04MB9124.eurprd04.prod.outlook.com (2603:10a6:102:22f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 17:19:54 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%4]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 17:19:53 +0000
From: Josua Mayer <josua@solid-run.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Geert Uytterhoeven
	<geert@linux-m68k.org>
CC: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 4/4] arm64: dts: ti: hummingboard-t: add overlays for
 m.2 pci-e and usb-3
Thread-Topic: [PATCH v7 4/4] arm64: dts: ti: hummingboard-t: add overlays for
 m.2 pci-e and usb-3
Thread-Index: AQHaY0TXqy6m6Bv0g0KsvKUkI3O0eLKZBSkAgATRLQCAAB5UgA==
Date: Mon, 28 Oct 2024 17:19:53 +0000
Message-ID: <299b6b75-beef-46aa-9203-b96009226677@solid-run.com>
References: <20240219-add-am64-som-v7-0-0e6e95b0a05d@solid-run.com>
 <20240219-add-am64-som-v7-4-0e6e95b0a05d@solid-run.com>
 <CAMuHMdXTgpTnJ9U7egC2XjFXXNZ5uiY1O+WxNd6LPJW5Rs5KTw@mail.gmail.com>
 <a65e17e9-0055-4e5a-902f-8ee2807a86df@ti.com>
In-Reply-To: <a65e17e9-0055-4e5a-902f-8ee2807a86df@ti.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|PAXPR04MB9124:EE_
x-ms-office365-filtering-correlation-id: deb10d4f-0d39-4355-3d09-08dcf774bcf8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RitTcTlNUnFZc1pQWUQ2ZFUzcXJZWXVhcUFXbDhKUGRUQ2xIOWtLVE9jaFlS?=
 =?utf-8?B?QjZLSEJlME1xelBsaktJam1CVC9BbU1OVm5Pc1pJS1FUKzRuS0ZvaGNvQlo2?=
 =?utf-8?B?blMwbFBPQ2tiT2p5eDBtOWlqNFNQamxUQ3dqcW8xTWlJU1hidGJkNlhTeFdQ?=
 =?utf-8?B?Zk1Pd084eTRrdnMvYWNXdUNXOHlkUld3R0pabnNpVWQrNTdyUzljb01hUy9k?=
 =?utf-8?B?c1ZPN2kwYXFzb3U2Qmk2aVdCeDFrWSswdlIvQXVkRHRkTVFZYXprZVJKZUdV?=
 =?utf-8?B?OUc3amRmQ1JrVHhvSC9idnRQck9oWG9ETGE4NEdKemk1U2k1d0hnMlBlbndU?=
 =?utf-8?B?d2pQSkU5OHlCNHdxME00WDAzZTU2Zm8yTitiVHhsVTNIdUFSc2tRT0NFS3F3?=
 =?utf-8?B?SjJXbU02cFYyWklyZ0Z3UGlac1Q3L044d1NGRlQ3elVtcTFxL2t1NE41U1VK?=
 =?utf-8?B?V2pORU1nVmlOcGZTZjQxUnd2SFZTN2dKVkhqMk9CUENtS3E3dnJJRVhHQmNH?=
 =?utf-8?B?UWlhckdmWW91djI2TnNrakkvQkFPcThGTFVvTlVyaTFmM0JLaGtSV1NuTTB3?=
 =?utf-8?B?aERZQ1B4b1dOMjJ3L1lMZlVzbkh0UGpua2R4S0VDb0ZDc09QcjgxWUtqUFM1?=
 =?utf-8?B?dTI2YXhsczkrcVplZFh5YnpDVERvenJOVlJWS3h3VzA4TEZEZ1AyaFR1Wi9W?=
 =?utf-8?B?R09jZy9tb3lZT0xQOCtBdDVUU1IzdDYzMS9EQVArMUs4T2FpKzJuSm04VlBV?=
 =?utf-8?B?NEFlMlUxNzdreDVVZktMSEM4WjFZbjByY0F1SHZFWFFEVGFBdGJwQWhGQ2NF?=
 =?utf-8?B?eFR1MUlDUFlnVEdpZzBRTnRlTk1LbHhPVG1ZSElyclc5SFo5MzlNNjZvVm9O?=
 =?utf-8?B?ZnVURVRMZVhhSEozb1RndFg3N2c4TDl4bDJaRThXS3VHdmhXNzV1VllMVXU2?=
 =?utf-8?B?VFJlVUtDdUdiMGFOVzU1VTBFc0IwMkFrdUtRR0IvUWtteDJ6b0ZvWXAxdHFP?=
 =?utf-8?B?em1NRnBWbHZxRTRtU0hiR0d4Yi9tNU9KQjNLdWx3eVk5T2YvVi8xREg2aHE5?=
 =?utf-8?B?K0w1U1F1bzFweHN2VS9mNmMxQ1g4VzY5Ni9CZXVyUU1UMmcxci80ZkxBdGU3?=
 =?utf-8?B?dTFNWkMrSERDaGdadlFVcEpHVURNNGEyaENrNGttWmkrMlJQL0hEdEQ3SHZz?=
 =?utf-8?B?QkpRNi9tZEs4NUxJMk5YRWtNVS9hV1lmVHJpbDJUMFBPT205NjFGUW1VQUVH?=
 =?utf-8?B?Tk9CK01vSnNsd2ljOVB3S2VIYnl2Qml2Y0ZYMElLR2U3a3BkUmNod1dSZ01i?=
 =?utf-8?B?ZEtFVlNlNUUzSlFGUHQyTFJpbFJoVFRDVkNEbExRTGhIcEtZbmwwZlI3NE5U?=
 =?utf-8?B?Wll2dThXZVVzUkFWYWlvUFlMd2RRRVpOL2UvMXBJcklyV0IzdGhRTFJCVFhZ?=
 =?utf-8?B?bGdISTZwc1NKU2hrblJnbHN1N2RGNHZYU1paa0pPTCtRTVMzZjdzWGVZbUZL?=
 =?utf-8?B?amNNZ2dnait4cE9TTW8zVnB1TWlwWDdtMHZqSFNXdjFvb3pkcmY4VUYrZWdl?=
 =?utf-8?B?bGExVkYzbGU5RkZNVGhnbE5qakRnbDF2TEdhekRPKytoL0ZyYUZzQ1NsVlEy?=
 =?utf-8?B?RVE0TndmWUV3TjM2WUpMQmtadVpTRDlvTkRVMEgrMlRneEFZZFZBRXcvMkZV?=
 =?utf-8?B?NS82N0c3THUxS1I0Y3lxOW1qRFZGQWh2cEZhM0JQSXFXY1dXZ05ibjV1SDFt?=
 =?utf-8?B?dXZxdDh3dXZnazhBVkNDbXpKRCtmakR2WFhBcFY5MEFkY0FGMmFYVTdhTDc0?=
 =?utf-8?Q?A0bZwX5QgRM3dHBLS+M/97dRGlnLr/AtmLfog=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aVFXTHBKRGpISFpPcVRPM3pyczlXWG84L0FuOWc4bWdjYWFzMEM3RUFmNWda?=
 =?utf-8?B?SWdRcWljOUQ0aGpNQzczRkxaenJXNFM5ak9TTnNjNGk2NWxBc0dqV2VWY3Z4?=
 =?utf-8?B?bE41ckg4SFF1eU1pYWhvdHlEbTBqWGdPbVpndG1kWVVlRHJIdHovdFlwcTNE?=
 =?utf-8?B?Vzh6ZmlYYWR5Q21jQnQwWjYrMml1SmRWNnFRdnlIa0sxV0ZmaXJzcEFuVkpi?=
 =?utf-8?B?RSthNnIwOUNoNG5RZzJxeEtCaEN3SEJhcHhiM20xbUREaFpYak85Z3JKb2V2?=
 =?utf-8?B?ejRUcVh0QXFyTStGaVBybU5hMXMxU0hwdU9NdlcvTFNDRUpweWJOMmY0SVp0?=
 =?utf-8?B?dUZ5dEpUT1QxaGxiOUMzYTBsc21rYkhEdEtqQkwyeVFoMHhXQm44bDBtaGQv?=
 =?utf-8?B?WjRGTXdGWjFOd2xlU0tYK1lSWU5DQ1FkSzhocVZoTTF2V2hFWlFvaEJjSlNj?=
 =?utf-8?B?RllvSWcwUXVIZ2VYSmJqcXVhRmt0NUY1MHdJVnkvOW1pSkxNTGt0K0JSVnl2?=
 =?utf-8?B?SUVEVmFYTkV5aWxWMGxFQTJ2bFNNb1U4c3JSZ1QwZkZTLy81NnJ4MzZySm96?=
 =?utf-8?B?WkNvai92aWNZM1ZHVU5aMzdlaU1HUzJPU2ozd1J2Kzh0ZCt0NHZrQ2RTdzY1?=
 =?utf-8?B?emx1ZFczcHJvWHQrVXZ3V3A5UVV5M0UwWXVHQ0VpR0ZhdjFabFVndUdJQlNN?=
 =?utf-8?B?eFZjdzJ4TWVVanZLZjFncXI0SnZ2SVllK0NEM0pFanhCNVZ5SW1Lblg4SEU3?=
 =?utf-8?B?YUJFbVFtbHNTWThkWXMyVXU2Z2lTWTBlR1lTQ2F2US9xZGt1dzR3ZzM2a09T?=
 =?utf-8?B?S25OVm11T2g2bWYzUExyRU1hT0g1NDZkZ1FXQXNMayt0K0pzZ0Q3a1FMZGow?=
 =?utf-8?B?Ty9nTXZlKzA2RitlOTJUZzJ5RUQ4TGZXZDJ1Q3dTMUJLYUcwOXNDa3dNQ3Bu?=
 =?utf-8?B?VUpCT0RtZUNMSjE4Q3ptRTdlNVc1YVlUYkNQbFBLR3VYbnpuUWI0cDArK3pK?=
 =?utf-8?B?NS92KzArUHRyRjRBWmJVaFc2Qng2Q1hRNnN4aDd5Q29mSU8wS0Q5OE11M1RB?=
 =?utf-8?B?QytsMUF3cVFnMUFTYjhmd0kyM3Bpbi9oc1BHRXUycW5heEFjR0Z3M3VSYzRx?=
 =?utf-8?B?T0NVSmhsbURpVWd1cnppdXZMcHFhSTdscWUxYU1QTlFSaFhSWWNSbkpqamlL?=
 =?utf-8?B?NGhxRGU3d3RiVDllalc5UlVad0VpK0tKR0RkZjQ4Y3VNSEhrZEJrRW9OLy9K?=
 =?utf-8?B?VWhLKzBISEl3d2xzRCtoSGYreUNaa2liUTlMTXZ2bm1IQUFEZVpjN0ZTOUQ1?=
 =?utf-8?B?aVpSemZWZEZOSytoUmxzREo0Vm1LY0Y5aGhUUnAydkVhZ0IzKzg3dlVKbkJO?=
 =?utf-8?B?M3NhTEF5SU00VDZNUUlGMmtiOHNvYWhXVjNDS2VJZ1BwOUdjUWNOY052RXBU?=
 =?utf-8?B?Tk5yUWRiMWFBYlBTK1FORmxXU1QydmFlSlhkR3BqdmFyM24rN3RXWXNZUkRE?=
 =?utf-8?B?YWMzWHR6a0lPWTMzUkR6UVFiWkloWmJRRTJTWXVnckNUZ2VNelFyWmVLeTN1?=
 =?utf-8?B?UXZUVHVWYzR5aGdzKzRERnZqeC91emZuQnRSVGRaa2ZxUWNSd24yMzM2SU04?=
 =?utf-8?B?ODZTUkNpdTc1ZWorT1lvMlVQYnBjd3Y4aVE0dWxuT0lmRG41UUhSajZFYWZQ?=
 =?utf-8?B?dXdqN0t0NWVFSTlxMGVHQ0k1VVN2eWpsNmlDZWNaRzI5ODJyd3VidEx6Y3dR?=
 =?utf-8?B?U1ArajhqN094bGVFSk9YZlFyT1hDZTZJQjUwdWhXUHpQSkxhY0RqTFJ6dEdi?=
 =?utf-8?B?Vno2N3pJQ2FtWFlnMmV5aFJoZVlBc0VYUXE0ZmlEa0MrZjhGTUt2cllQd1FO?=
 =?utf-8?B?aHUrWkZVUERRYVdBbEZGZGE5N3VIbGhxUWF5ZVg0QjRUV1E4TzN5ZmJiY2F5?=
 =?utf-8?B?dHg0dlVmdnFHVDA0em9aRFdZTzdOZ0hhNkZCTENDRWgvTjRHZE9PQnJTbjhs?=
 =?utf-8?B?NXlBVHU1NUIvU1B3WHhHV0NSc0RzSjcwNjc3TjZvNHppajMwcjh6cVRuVE16?=
 =?utf-8?B?c1NGSzlURithb0FhODcvVkkrc3pBOTVsRm4wbkZGUXUyamQ2Y1VmTk4yNDhQ?=
 =?utf-8?Q?Qe8Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA618FF72AEF864B89972E5FABE7CBB4@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deb10d4f-0d39-4355-3d09-08dcf774bcf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 17:19:53.7854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7yMn/3ib5rfUUO9sNNMCfk7QKe2N07ChP+si59/eGBwCni6fjhND7DPETNhcV5O1H3H/b10QaLGUUGHAbUgmJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9124

SGkgR2VlcnQsIFZpZ25lc2gsDQoNCkFtIDI4LjEwLjI0IHVtIDE2OjMxIHNjaHJpZWIgVmlnbmVz
aCBSYWdoYXZlbmRyYToNCj4NCj4gT24gMjUvMTAvMjQgMTk6MjcsIEdlZXJ0IFV5dHRlcmhvZXZl
biB3cm90ZToNCj4+IEhpIEpvc3VhLA0KPj4NCj4+IE9uIE1vbiwgRmViIDE5LCAyMDI0IGF0IDQ6
MDXigK9QTSBKb3N1YSBNYXllciA8am9zdWFAc29saWQtcnVuLmNvbT4gd3JvdGU6DQo+Pj4gSHVt
bWluZ0JvYXJkLVQgZmVhdHVyZXMgdHdvIE0uMiBjb25uZWN0b3JzIGxhYmVsZWQgIk0xIiBhbmQg
Ik0yIi4NCj4+PiBUaGUgc2luZ2xlIFNlckRlcyBsYW5lIG9mIHRoZSBTb0MgY2FuIGJlIHJvdXRl
ZCB0byBlaXRoZXIgTTEgcGNpLWUNCj4+PiBzaWduYWxzLCBvciBNMiB1c2ItMyBzaWduYWxzIGJ5
IGEgZ3Bpby1jb250cm9sbGVkIG11eC4NCj4+Pg0KPj4+IEFkZCBvdmVybGF5cyBmb3IgZWFjaCBj
b25maWd1cmF0aW9uLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogSm9zdWEgTWF5ZXIgPGpvc3Vh
QHNvbGlkLXJ1bi5jb20+DQo+PiBUaGFua3MgZm9yIHlvdXIgcGF0Y2gsIHdoaWNoIGlzIG5vdyBj
b21taXQgYmJlZjQyMDg0Y2MxNzBjYiAoImFybTY0Og0KPj4gZHRzOiB0aTogaHVtbWluZ2JvYXJk
LXQ6IGFkZCBvdmVybGF5cyBmb3IgbS4yIHBjaS1lIGFuZCB1c2ItMyIpIGluIHY2LjkuDQo+Pg0K
Pj4+IC0tLSAvZGV2L251bGwNCj4+PiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL3RpL2szLWFt
NjQyLWh1bW1pbmdib2FyZC10LXVzYjMuZHRzbw0KPj4+IEBAIC0wLDAgKzEsNDQgQEANCj4+PiAr
Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjArDQo+Pj4gKy8qDQo+Pj4gKyAqIENv
cHlyaWdodCAoQykgMjAyMyBKb3N1YSBNYXllciA8am9zdWFAc29saWQtcnVuLmNvbT4NCj4+PiAr
ICoNCj4+PiArICogT3ZlcmxheSBmb3IgU29saWRSdW4gQU02NDIgSHVtbWluZ0JvYXJkLVQgdG8g
ZW5hYmxlIFVTQi0zLjEuDQo+Pj4gKyAqLw0KPj4+ICsNCj4+PiArL2R0cy12MS87DQo+Pj4gKy9w
bHVnaW4vOw0KPj4+ICsNCj4+PiArI2luY2x1ZGUgPGR0LWJpbmRpbmdzL3BoeS9waHkuaD4NCj4+
PiArDQo+Pj4gKyNpbmNsdWRlICJrMy1zZXJkZXMuaCINCj4+PiArDQo+Pj4gKyZzZXJkZXMwIHsN
Cj4+PiArICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPj4+ICsgICAgICAgI3NpemUtY2Vs
bHMgPSA8MD47DQo+Pj4gKw0KPj4+ICsgICAgICAgc2VyZGVzMF9saW5rOiBwaHlAMCB7DQo+Pj4g
KyAgICAgICAgICAgICAgIHJlZyA9IDwwPjsNCj4+PiArICAgICAgICAgICAgICAgY2RucyxudW0t
bGFuZXMgPSA8MT47DQo+Pj4gKyAgICAgICAgICAgICAgIGNkbnMscGh5LXR5cGUgPSA8UEhZX1RZ
UEVfVVNCMz47DQo+Pj4gKyAgICAgICAgICAgICAgICNwaHktY2VsbHMgPSA8MD47DQo+Pj4gKyAg
ICAgICAgICAgICAgIHJlc2V0cyA9IDwmc2VyZGVzX3dpejAgMT47DQo+Pj4gKyAgICAgICB9Ow0K
Pj4+ICt9Ow0KPj4+ICsNCj4+PiArJnNlcmRlc19sbl9jdHJsIHsNCj4+PiArICAgICAgIGlkbGUt
c3RhdGVzID0gPEFNNjRfU0VSREVTMF9MQU5FMF9VU0I+Ow0KPj4+ICt9Ow0KPj4+ICsNCj4+PiAr
JnNlcmRlc19tdXggew0KPj4+ICsgICAgICAgaWRsZS1zdGF0ZSA9IDwwPjsNCj4+PiArfTsNCj4+
PiArDQo+Pj4gKyZ1c2JzczAgew0KPj4+ICsgICAgICAgL2RlbGV0ZS1wcm9wZXJ0eS8gdGksdXNi
Mi1vbmx5Ow0KPj4gL2RlbGV0ZS1wcm9wZXJ0eS8gKGFuZCAvZGVsZXRlLW5vZGUvKSB0byBkZWxl
dGUgc29tZXRoaW5nIGluIHRoZSBiYXNlIERUUw0KPj4gZG9lcyBub3Qgd29yay4NCg0KTXkgdW5k
ZXJzdGFuZGluZyBpcyB0aGF0IGZsYWdzIGFyZSBlcXVpdmFsZW50IHRvIGJvb2xlYW4sIGkuZToN
Cg0KdGksdXNiMi1vbmx5ID0gPHRydWU+Ow0KdGksdXNiMi1vbmx5Ow0KDQphcmUgZXF1aXZhbGVu
dC4NCg0KSWYgc28sIGNhbiB3ZSBhc3NpZ24gPGZhbHNlPiB3aXRoaW4gdGhlIG92ZXJsYXk/DQoN
Cj4gR2VlcnQsDQo+DQo+IFRoYW5rcyBmb3IgdGhlIGNhdGNoaW5nDQpFeGNlbGxlbnQgc3BvdHRp
bmcgaW5kZWVkLg0KSSBub3RpY2VkIHRoaXMgaW4gcGFzc2luZyBhYm91dCBhIHdlZWsgYWdvIHdo
ZW4gSSByZXF1ZXN0ZWQNCkRlYmlhbiBlbmFibGUgdGhlIG5lY2Vzc2FyeSBkcml2ZXJzIGluIHRo
ZWlyIGRpc3RybyBrZXJuZWwNCih3aXRob3V0IHVuZGVyc3RhbmRpbmcgdGhlIHJvb3QgY2F1c2Up
Lg0KPg0KPiBKb3NodWEsDQo+DQo+IFRoaXMgb3ZlcmxheSBpcyBwcmV0dHkgdXNlbGVzcyBpbiBs
aWdodCBvZiBhYm92ZSBpc3N1ZS4gIEkgaW50ZW5kIHRvDQo+IGp1c3QgZHJvcCB0aGlzIGZpbGUg
dW5sZXNzIHlvdSBjb252aW5jZSBtZSBvdGhlcndpc2U/DQo+DQpJIHdvdWxkIHJlYWxseSBwcmVm
ZXIgdG8gZml4IGl0LCBvciBzb21laG93IHJlcGxhY2Ugd2l0aCBlcXVpdmFsZW50IGZ1bmN0aW9u
YWxpdHkuDQoNCk15IG9yaWdpbmFsIHByb3Bvc2FsIHdhcyBoYXZpbmcgdGhlIGJvYXJkIGEgZHRz
aSwgYW5kIHRoZSBwY2kgYW5kIHVzYjMNCnZhcmlhbnRzIGFzIHN0YW5kYWxvbmUgZHRzLg0KDQo=

