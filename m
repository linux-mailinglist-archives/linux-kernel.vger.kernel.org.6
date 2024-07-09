Return-Path: <linux-kernel+bounces-245221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 623A792AFE2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 08:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A08E281D7C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 06:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E255812F5BF;
	Tue,  9 Jul 2024 06:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="faq9+OjW"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2040.outbound.protection.outlook.com [40.107.105.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6518614A85;
	Tue,  9 Jul 2024 06:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720505804; cv=fail; b=KnoWcaD1OS8odDuU2yuwbgMe80GBfEVIJtgf0jkwFqdnA19O/fLOYxlOzEk/FgsyLOGNHZ9xha3HuFYE0aFpTKwkCHKQS7gWt3DxjHctdrGG128V82yJODHnxR9AwJ/i6wsdy5ghX2UWDKQTljPrvYba+StoFFScCX/n3XbRSYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720505804; c=relaxed/simple;
	bh=DnooNqsPyGLJhzpgThhlDfHZrSKa1PxnI6H6gjx5fc4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j342niLA/9Bd9+B2ubWRZaWs61WmA+/0F4CfOLlWKIrEkKIrxVSIL0e8gYP6gpXSTx853y5CIU4W+T5tIgApvVCfU6yZEZ0X6W1Mj9FDCihQEDXiQFsfilyys4rjHcTFNpTMv9ms9vr34TH9nPEXbywSdC0qlA9et9+ZD43o7is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=faq9+OjW; arc=fail smtp.client-ip=40.107.105.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHva7Xm09pUQvPdfk5KF9azZpl4RNCd2TUQ5BCLemjdhU1uevHNnSVUq6edeaO9EmxCNupnPls31YPrMs/oUkVTCEnfJ9lV0mNCzoaT4Z9GjIWhbSD53fkhqMT8ug9IpCtt+04db2mF9OAXnUFSguiGHAtPe+FW/t3Gn+2a96LGTL45CJnmAQznWlzYgawDG35OXoHTv2w2DmDhj9HHZi9zxfq/JaJ3yhM7VXhiSZ5Gcn0QHWhs2ouMQ/YDqgQ7/8T/hxThZuykRWTIRlXMDTrBaSJun7Ed0z3scMEZToFQoMqFR2mn046cRRe+KZ7f9mTuKFUPdqi6CJGxsf75PKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnooNqsPyGLJhzpgThhlDfHZrSKa1PxnI6H6gjx5fc4=;
 b=ODuiCuVTWuyodP5kLS1sod1t+dJ2DhCg7B8+ZP2XKPQFZRDu5whIZNbDjQbm31mUIB7lDWxto0tjZlv/41MvHMibQgPKSZg0A9WHSlfhK3Hh91xNafIXRjKDuMRuR5i+xmcuf0ASDh23QhGg1h77ImxIHLfcqOVr20dQRf4On0mV4cTSal1XA5khbQ1/XQSQbLKtNSzuoFL2x5LxkXJ/JP8kRuufLzUoTcIT0cN9GOIEc0lNXJJ1Q+55nIHLoM1fZxm0FOSYD0UC8/fzZKVeabsqwEUwvnwet3xgbKAtE20D4EMrFCQ0Owyhcw2O5CYBHTPhY4Yta9XBOw3xC230rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnooNqsPyGLJhzpgThhlDfHZrSKa1PxnI6H6gjx5fc4=;
 b=faq9+OjW79gMhZDi2qCVXTur7Z0wffor7L3iHg0n6zA+qXOVTK8MR3Nlmc7dq9kBHk0nqWQI/Kt6teNzJ56CSRV/RxJOKtydDC/pzPJVAeCmZV1w1bAx9PibzsWxnABur6nGB9yuxbSAiR9bzBcZknerPngyRsZeU3MGv0YqanM=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DB8PR04MB7098.eurprd04.prod.outlook.com (2603:10a6:10:fd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 06:16:38 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 06:16:38 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v4 4/5] firmware: imx: add driver for NXP
 EdgeLock Enclave
Thread-Topic: [EXT] Re: [PATCH v4 4/5] firmware: imx: add driver for NXP
 EdgeLock Enclave
Thread-Index: AQHazuMXk5fiLsrWBE6WkZNs4dui17Homl8AgAVV/4A=
Date: Tue, 9 Jul 2024 06:16:38 +0000
Message-ID:
 <AM9PR04MB86045A7D4612D40950B7DF8395DB2@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240705-imx-se-if-v4-0-52d000e18a1d@nxp.com>
 <20240705-imx-se-if-v4-4-52d000e18a1d@nxp.com>
 <318ebc29-df94-495d-b2bc-b24340c3d82a@infradead.org>
In-Reply-To: <318ebc29-df94-495d-b2bc-b24340c3d82a@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|DB8PR04MB7098:EE_
x-ms-office365-filtering-correlation-id: 68d4e078-2cf3-4d96-139a-08dc9fdeb138
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q3dlNEFLaHd1L1E2WEhaaDlXeS9zczlMZFBaL0w4bnM1blZNMWRUcEZyczdX?=
 =?utf-8?B?TFdMZUJYcFpjVS9WUzUvenBvSm9RSy93L3JQOGI5cXNYNEdiWm9HZkVYdEtk?=
 =?utf-8?B?VTNqL1Y4bWFjSGpXeEdtS2RIUnBZYkx5QmR4NllkenFwdXRoMmQrUysycFJ1?=
 =?utf-8?B?eEk2dTl4UkRKVHVycW9zR3ZLME9ESGZ0Q3BhWCtHZmdmTDdkbHY3Vjl3ZHBZ?=
 =?utf-8?B?elVHQnJRMG5kalNFMWRlT3ZCRVRxWHdDbWhaK3BkTUc0dVBpcG5Nc3gwSmEy?=
 =?utf-8?B?TzU5aG1IVlBNNlA2V0cwVG1WeC81UGNkWk9wRGFZcWhXOW8wKzFlbjY1YnBl?=
 =?utf-8?B?cVd2WXNKZ0lzSDJaNDJWdWcxMUEvbWV4QnJjekhyVkNvOFJ3VGZsY3RhaFlv?=
 =?utf-8?B?VUorSStPaXpIYTl5bTBHK1EzbWdOQUpIWklJQlZQemhjV2RENjNoaEI4N0xL?=
 =?utf-8?B?NjBEZkV2MEMrNE45R20xcW1vZzhNK29McVBveEVDeFNTN0lzMFhPL25weUto?=
 =?utf-8?B?cW9MTTZKVVpMajlNY3FCejNWZ2lSR1VWSmxsN0NZc0g1SmFxMG16ZkpEcEJR?=
 =?utf-8?B?L0NPVGNWRk51MXBFNTRrak1VZ3RqL2RJTXoxcUpXYmJPMmVEZHk3U1RMcjN5?=
 =?utf-8?B?SWVMWmZ1UjFCMUhVYktzNVMrcWs5SjV1N3NOMjFRRFFpek9rK3YvSHFpS1BQ?=
 =?utf-8?B?cityTzBocEU0aSthT0t0bUp3RmxicWc2V0RVZ0ptWXdpTTRhR29WbE1XZzFx?=
 =?utf-8?B?M3dlWHRsOTlSbTRpSEJmeS8vL3lzYkZqY3J0QUFvZTNMYkh1bWwvVUxhNmE4?=
 =?utf-8?B?UTZ0dEhvN3Z4RGNzVk5ZMDJyVDNkeTlXWG9QRlIrNi9WZWsvZ3ZqcFF1VUkv?=
 =?utf-8?B?N3lZOEVKQ3JiN0xlRjN5VXdWYklJYW03eEtNd0NQUUYzN2VIOXJleStOMDQ4?=
 =?utf-8?B?eDlsVjJpY2lNZHlZZ0UrYW9UeUd6S1hEbVhiSmI3TXBVN21hVUUrcHRUekZS?=
 =?utf-8?B?UmxQLzVCK1ZsZ2pYa2dKTXVZS0JKT0pKSE1UcVQwM0IvS0xMWVIyOHVSK3pF?=
 =?utf-8?B?WFlFMXBOd0lTay9sM1R1SjBXTzJCMGpYVm1XUFBreGJBMDRHYjNIOFFwVUlN?=
 =?utf-8?B?MVBoOHJGWndOeXkzK0RpZFNqZzl6c1pkVlpPQk4rcU9BOUpDSkZDdnFqdU1Z?=
 =?utf-8?B?T3ZmazI2ek1vdlVqWkQ0SnJDN0c1NCtPWTdOL0hrUmFGSHorVVpReDZqUTdl?=
 =?utf-8?B?cDBIYVU5Y1ZjZDFnN2FoU0wxK2pYd3FzVzFENG5KODJzRTA3cWlsZkVES1Vo?=
 =?utf-8?B?akpvMjlWNlZ1aE1RbFFoN21yZCtUdy9FL2ZpWXlMdEJNb2J2ZDZaNzRsUnRI?=
 =?utf-8?B?YU52VUJ4N2ZNZ0NSZC9KVWJqTW9oOWd5eVdtdThaNVJLanl5aHNPcjFYdWp2?=
 =?utf-8?B?L082bU5FQ3Zjd0NEcjRIeUxOeU1GRVBLNEtjdDgwdGljVTYvMGwzZ1BSOEVP?=
 =?utf-8?B?cThGeTJDWnBDRGllNEU2MS8xUklCK1ZkbnQxdWpkbldoblBmR254bXhabTdJ?=
 =?utf-8?B?ZGhwTkZLSFByZWVEVTNta1ViN3JPVzEwUnBhdUZQTFdtUUoxT3laaDhLMStX?=
 =?utf-8?B?cUNGV09sUlorUUU2eGF0N2tEYlFVOVBUYUNMSW5PTzlleXZYZDdUQmtpOUQ3?=
 =?utf-8?B?NVJya0VmeVNZN2xKcE1MblZ4dmdQd0pqeTQrcUV2c0xQWWdFa1ZHRjBoSFVC?=
 =?utf-8?B?b0ZielphNDU1WVFYVUt6UElkYmZpY01DaGdRV3YxOW1zWmlpbGVaQUxoOWV6?=
 =?utf-8?B?ZTZobHNZTE9Obm83bWlXS1lpWDYzU2ZQaUh5R01Ob2tWSE9vdDFIK2ZaRE40?=
 =?utf-8?B?cG9oYlpRd0MyRWxRWm5ibTR6bHphMVlQZzhlM3M2Q05WNGplSTMxVnNJaWtV?=
 =?utf-8?Q?UFavd0vEvFY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VWxmTEJ5NlhSZWQ3clpyemt1Tmh6ZlJQWUZ4eEVCeWdRVkhhTTdCd1ZoVEdh?=
 =?utf-8?B?MTBTSElocGNxUHV3a0tuMmM3Mmlsb1E4US9DOTRxaFY2ODkxekZ5MzBCaHZa?=
 =?utf-8?B?OStqc0RCNUs2OGV5QXBqbFBEb0xNclVmTTRnZDlzaWs3cHlGQkNKbis5VkV6?=
 =?utf-8?B?S3J4OU0vbDYrN0pHQXJJV0NNVFdkS2FrVENQaEg3clphcU1GUmE0RWdWZHFx?=
 =?utf-8?B?Uk9GSlIxc1pmOC9aR3N3S3VGeVFSV1pKMWJtV2phSTY4Z0czeFRmS2t0UnNt?=
 =?utf-8?B?MHE4Rm5obGRIcXRCWDdZR25rR2ozcHNpYzlhSE9lck1yUUZNUmNnT0RhQk9C?=
 =?utf-8?B?anB5SkpmNlgwY08zcDU5K3Zkb0h3WHh3alZoYkVZY3g2cXlsem9qZUJXVUVh?=
 =?utf-8?B?aHdsRjJHeWxMTFpoU0l1WWM2RzdXbW5yKzNSVzBlanpiOE5mb25oVHc0OHRW?=
 =?utf-8?B?VFRWRXEzMUcxZ0hWQzhPVzRRM0EwUE95aEFsYytyeXVOcWhQSk9xdWRjNzUv?=
 =?utf-8?B?NmZsdmdWeGdFUlc1OTVqZTV6T2s0dUg1WVBwWGNNWUFFME1GT2R5Rk8rSVZn?=
 =?utf-8?B?aWlvOHRiSkUrK01ZQUtaMlVvaTNHU3lDMTdNVFJ5UUtsNDV4aUxUS01neWxo?=
 =?utf-8?B?ZUxsVjdQYXBucjFya25PbEo0d0FMN3h3ZmZqZjB6K2xrUWtHMGVVdzM3Qnp6?=
 =?utf-8?B?MFowcXFoRUl5ajN6ZWdTMTJjMmpBeXQ4c1BOTGhuV1NWeUI2K0hmWE9uemN3?=
 =?utf-8?B?ZW92OHViS3FmYjZHdVJnc2pWd3d4aUU5OFZsYkxUSXJ1SXlaWHJVaUNFdDhx?=
 =?utf-8?B?L2Vxako2blFDcEJuZG5NVFZtbkJGMHNTWTVYRnpGZ0kwS3FPZURNcnd5UWJv?=
 =?utf-8?B?TTN4c0pYeVk3aVNSNXJYOHdLYzB6QnJrL3ZVUHMxVkluaEEyTy9GUTI3cEY3?=
 =?utf-8?B?a2FCTlQ5RWl5ak43UkJnL2hRcXJXalJtOVdZK0x3UnRQcXlwMkh3cVlybUhk?=
 =?utf-8?B?YksyOFBWdDluSWFkazhhcjN5U25NQ2d1K3plTXRZWUpVR1JuU3lGaERNVmNy?=
 =?utf-8?B?aXduTFU1UTFHWE4rWmsyRlRLUDBSbU83dXdET0tBaWNKdVBtdmgzVDU0YjJu?=
 =?utf-8?B?YVRmcnlZcUdXQmQvdHFaTVNGM3BkNzdFSUxJMjFrRmNCcW9TU3F4MmlZK2U3?=
 =?utf-8?B?azFyRjN3aWFEdTFBbGZDaDI5cVdvR1U0N1RYaEN1MHVjK2FQaXkycThxeEhV?=
 =?utf-8?B?dFljTXA1dmtLVGtncDR6a1VSSS90SVhQckt1VmlVSWgyNzkxWnNuN2w5WGJB?=
 =?utf-8?B?c3pteExqZUQ3N3hCRmZ0Mms5SGZzaWRiOFdmdlJkTEE0OXJJaVdENFBWcE5x?=
 =?utf-8?B?eUNTSVRDeHhySkRybEVGTFFTUGFzRThXNUc2R3JuMEc3c2NPMWFrenNVbjQy?=
 =?utf-8?B?dlRWb3RpSE1qZGdQQUthYjBYbVRXNWN3M1QvWXFUb2l2QnhuL0oxZm5DOGE1?=
 =?utf-8?B?TzV1bjVuUEI5ME80MStBK1NPb2pqbVZteDhYRllWNmsrQ2NuOVZsci95bkFy?=
 =?utf-8?B?M0l4aFlGOWkwYVRkaVBpYWppOGEvOUNwbDBMYXUyYUcxSGF5YVVtR1prMVQ3?=
 =?utf-8?B?YnNrNHI2aG8xeXVNaGcrVXFSQ1JEdllYYXNDWE1aTzNtT1lZSVp6dFJrdGdH?=
 =?utf-8?B?WUFacEh3OUFoR0NhWExFZlVGc2pvYlJXdVZkYWNETXRwSXowd1ZqNmxUbzZn?=
 =?utf-8?B?VWtBYnZiRTAyVVZqdFJBdDdhanpnNTZrUEJ5SEgydUVHY1YxblVUc21SbDFM?=
 =?utf-8?B?eHNjMm9FLyt4TWdORkZpVEgrLzNBazJlUjV2Snp5ejRES09QME03aEo2ckll?=
 =?utf-8?B?SmFVRjN3RDBLR0Jac1RtU0U5YWpYeFBCMGRCa3h0a2xPOHZXOXZrWUU1VS9E?=
 =?utf-8?B?OUUweXpleHZXQ3AvMVY2ZjBTaVExRVZlVGtiS0xuMHlCL0tyZHUzV281N3Y4?=
 =?utf-8?B?Uzc3YldWaVMxWTBzNHN1SVpiblVwcFhBRjd5d2xwS0h2enRGa2YyUEhSeWFU?=
 =?utf-8?B?U2xWc21rc0JhVUFlNjI0UTBXOVRRdTVzSDVkMTJqZVFFTDF1Z1FhSmc2M2F3?=
 =?utf-8?Q?6eOSuDIOaHi95GpOZgcKat0xv?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d4e078-2cf3-4d96-139a-08dc9fdeb138
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 06:16:38.4468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kl8nJ1FRdmPnHNTbGcx6rs4pMgZzQXPjDMjAuG4w5gECBFZyEw4X9+9YJWDQJDxs1sIxoyUgug7Bg3qZuLBqRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7098

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFuZHkgRHVubGFwIDxy
ZHVubGFwQGluZnJhZGVhZC5vcmc+DQo+IFNlbnQ6IFNhdHVyZGF5LCBKdWx5IDYsIDIwMjQgMjox
NCBBTQ0KPiBUbzogUGFua2FqIEd1cHRhIDxwYW5rYWouZ3VwdGFAbnhwLmNvbT47IEpvbmF0aGFu
IENvcmJldA0KPiA8Y29yYmV0QGx3bi5uZXQ+OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3Jn
PjsgS3J6eXN6dG9mIEtvemxvd3NraQ0KPiA8a3J6aytkdEBrZXJuZWwub3JnPjsgQ29ub3IgRG9v
bGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsgU2hhd24gR3VvDQo+IDxzaGF3bmd1b0BrZXJuZWwu
b3JnPjsgU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPjsNCj4gUGVuZ3V0cm9u
aXggS2VybmVsIFRlYW0gPGtlcm5lbEBwZW5ndXRyb25peC5kZT47IEZhYmlvIEVzdGV2YW0NCj4g
PGZlc3RldmFtQGdtYWlsLmNvbT47IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBL
cnp5c3p0b2YNCj4gS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc+
DQo+IENjOiBsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgaW14QGxpc3RzLmxpbnV4LmRl
djsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBb
RVhUXSBSZTogW1BBVENIIHY0IDQvNV0gZmlybXdhcmU6IGlteDogYWRkIGRyaXZlciBmb3IgTlhQ
IEVkZ2VMb2NrDQo+IEVuY2xhdmUNCj4gDQo+IENhdXRpb246IFRoaXMgaXMgYW4gZXh0ZXJuYWwg
ZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZyBsaW5rcyBvcg0KPiBvcGVuaW5n
IGF0dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2UgdXNpbmcgdGhl
ICdSZXBvcnQNCj4gdGhpcyBlbWFpbCcgYnV0dG9uDQo+IA0KPiANCj4gT24gNy81LzI0IDY6NTIg
QU0sIFBhbmthaiBHdXB0YSB3cm90ZToNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9maXJtd2Fy
ZS9pbXgvS2NvbmZpZw0KPiA+IGIvZHJpdmVycy9maXJtd2FyZS9pbXgvS2NvbmZpZyBpbmRleCAx
ODM2MTNmODJhMTEuLjU2YmRjYTliZDkxNw0KPiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Zp
cm13YXJlL2lteC9LY29uZmlnDQo+ID4gKysrIGIvZHJpdmVycy9maXJtd2FyZS9pbXgvS2NvbmZp
Zw0KPiA+IEBAIC0yMiwzICsyMiwxNSBAQCBjb25maWcgSU1YX1NDVQ0KPiA+DQo+ID4gICAgICAg
ICBUaGlzIGRyaXZlciBtYW5hZ2VzIHRoZSBJUEMgaW50ZXJmYWNlIGJldHdlZW4gaG9zdCBDUFUg
YW5kIHRoZQ0KPiA+ICAgICAgICAgU0NVIGZpcm13YXJlIHJ1bm5pbmcgb24gTTQuDQo+ID4gKw0K
PiA+ICtjb25maWcgSU1YX1NFQ19FTkNMQVZFDQo+ID4gKyAgICAgdHJpc3RhdGUgImkuTVggRW1i
ZWRkZWQgU2VjdXJlIEVuY2xhdmUgLSBFZGdlTG9jayBFbmNsYXZlIEZpcm13YXJlDQo+IGRyaXZl
ci4iDQo+ID4gKyAgICAgZGVwZW5kcyBvbiBJTVhfTUJPWCAmJiBBUkNIX01YQyAmJiBBUk02NA0K
PiA+ICsgICAgIGRlZmF1bHQgbSBpZiBBUkNIX01YQw0KPiA+ICsNCj4gPiArICAgICBoZWxwDQo+
ID4gKyAgICAgICBJdCBpcyBwb3NzaWJsZSB0byB1c2UgQVBJcyBleHBvc2VkIGJ5IHRoZSBpTVgg
U2VjdXJlIEVuY2xhdmUgSFcgSVANCj4gY2FsbGVkOg0KPiA+ICsgICAgICAgICAgLSBFZGdlTG9j
ayBFbmNsYXZlIEZpcm13YXJlIChmb3IgaS5NWDhVTFAsIGkuTVg5MyksDQo+ID4gKyAgICAgICAg
ICBsaWtlIGJhc2UsIEhTTSwgVjJYICYgU0hFIHVzaW5nIHRoZSBTQUIgcHJvdG9jb2wgdmlhIHRo
ZSBzaGFyZWQNCj4gTWVzc2FnaW5nDQo+ID4gKyAgICAgICAgICBVbml0LiBUaGlzIGRyaXZlciBl
eHBvc2VzIHRoZXNlIGludGVyZmFjZXMgdmlhIGEgc2V0IG9mIGZpbGUgZGVzY3JpcHRvcnMNCj4g
PiArICAgICAgICAgIGFsbG93aW5nIHRvIGNvbmZpZ3VyZSBzaGFyZWQgbWVtb3J5LCBzZW5kIGFu
ZCByZWNlaXZlIG1lc3NhZ2VzLg0KPiANCj4gVGhlIDQgbGluZXMgYWJvdmUgc2hvdWxkIGJlIGlu
ZGVudGVkIHdpdGggb25lIHRhYiArIDIgc3BhY2VzIGluc3RlYWQgb2YNCj4gX21hbnlfIHNwYWNl
cy4NCkFjY2VwdGVkLg0KDQo+IA0KPiAtLQ0KPiB+UmFuZHkNCg==

