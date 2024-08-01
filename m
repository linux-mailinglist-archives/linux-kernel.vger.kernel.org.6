Return-Path: <linux-kernel+bounces-271126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F27C29449DC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 819221F2194E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE338184546;
	Thu,  1 Aug 2024 10:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ADCpe9V/"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE31183CC8
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 10:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722509897; cv=fail; b=oclrq9OvkKR7Ync0HIcrdRlTFa9NV+/i4ZimJUw0Wn0h99GqJJ9C3fHa7WWZelrpVct7PInUqRL8hDLLEklRaf6e7aKTLuYnNlRXWcD/MGGBX6+BErQLqXwSlDEsg8j1SWaEG9KrmXJcUeNUgkAeT5tjzLew97z0XciZpb93DJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722509897; c=relaxed/simple;
	bh=fJXsEx9s6dDRhdQCrTATOEGOWDf/+T0qUz3PEMtwILE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NAzGEmq9PL2tar7sqYsPL+6f2Q9lXTgRlsUZd1s2JCqsctBMFHMHUKJUBo3zluesKzHu7NgPo11l6tPusLyiESEzG0Nv1dEhShMzFomSN9xhvGyXU4ncQVzh5Pz56W7W/kwIKgYMwOHnrZKMxvIX9pVMTe4pmjBEjugATX+Z1Z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ADCpe9V/; arc=fail smtp.client-ip=40.107.20.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QU2QWvT9367WqGDPGJ0c11i0lPx0+AHuTQ9a8FnuP6xjWp94hdmDD4szcs+v/N2XPo8QYd0g94amxYapcSHtFWQmi4kys4t0tStdJRpmqr5msxyDGmZ1weOgVxydwLpm6ZNGerOsnDbyoILqXDtdiJzAdMekCg7dhee5lw5pVwB8xv9KDR5g9KE/37GzXlWvgrE60sJWIfr69DvfyJuRuSsTs/nYIwXY6dQYx+HdsHRMmYHPm4IxtlFZ5ADeIi2tobc6PtNCDDysDL8qjBwvPtXL1xdCDtEYPsjA04noKSqW9YvrC55IG1angdzR5z3obcOcQX4FsPPxo1Cv3fZ5tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3oEEqDMVotL3pAUvqiRnkbfexTBpqYx7DZry/MCZEB0=;
 b=kcbtq0Z5Gcs1Rr+tplgYLqgBz8zgBX5HQgbnYGYfWJqF/NXS2OWzdc5xrCAfzXcag7uiSISY+ix9lmm79vlfMv/jGmGdbRkmsLGGMEqOKwPmlU9ohkg0wW21yyJhlqP7wYSG2uY+8fn/06oEMmrNffCg1RgwYBUv2WaxMzI86haX8qZ81rAzPCqu/29iMWFM/3+lQYLGh8BE8vvkQX9QHMoATtBznf4a5lSMSjjhWc2mE6uGQ6Tcck7gxzzC4ljGY+kr2431hGgDDnBzplvQYMCAcvdjX9Ky+IaRJoUP9EkZ7LDA2kpRTA28E4cDV5sDv1Xvb7zgSfECGJnXdulr1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oEEqDMVotL3pAUvqiRnkbfexTBpqYx7DZry/MCZEB0=;
 b=ADCpe9V/nr9MDiWjBrtV1F+RObmFC6Bqv/oJEis4gh7uFb00Fe7hrDyq2LD86gJ8CoSS9auVmVsUmZsUnAVYnBb7RzDwJs2FYLW62KQM++pYrWbTtMhhpfC3nju/tg8g6U6852lgm5GV0Vku7nwlVttrvUEuFL2xOpczu9ttkiExjsLZ0jVS2b0HgWdXaGOhFANCvRTcSmth3yGdsF3xqGzSObu90pTNS0vDU5eaRD/LcdkLed5nJdR6yHtRA2rh3AjijEomgXe80fcAm0VMJKEfJcrbwTL+HhtX2lshTyWoRhs1LkgAoPC7hq1nq4WMKDzSBH+FYP+ayp4uKs4eGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17)
 by VI0PR04MB10253.eurprd04.prod.outlook.com (2603:10a6:800:23e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 10:58:12 +0000
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::cdc5:713a:9592:f7ad]) by PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::cdc5:713a:9592:f7ad%3]) with mapi id 15.20.7784.016; Thu, 1 Aug 2024
 10:58:12 +0000
Date: Thu, 1 Aug 2024 18:55:38 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: vkoul@kernel.org, kishon@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	jun.li@nxp.com, linux-phy@lists.infradead.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: fsl-imx8mq-usb: fix tuning parameter name
Message-ID: <20240801105538.aieqm6qliiw6z2su@hippo>
References: <20240801065716.3819399-1-xu.yang_2@nxp.com>
 <5802707.GXAFRqVoOG@steina-w>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5802707.GXAFRqVoOG@steina-w>
X-ClientProxiedBy: SI2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:4:186::10) To PAXPR04MB8829.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8829:EE_|VI0PR04MB10253:EE_
X-MS-Office365-Filtering-Correlation-Id: d27d4b9f-94df-498d-538d-08dcb218d5f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2tuN0FkOUJnSUpkRnpPUmZlRDhHOC9XZ0QvbVhmb0dSUmxTNGEwQ205Lytk?=
 =?utf-8?B?V2x1YTNPcnlwdUxjNE5vc00wZnFRb09xVVRCcTE5RzFyaVB1OW4rdjNoWVpD?=
 =?utf-8?B?R0plejA1TmIrMU9FbnRPK25mbFlnbDhtOVMzYVBZdmFVZ01LcW9GdWUyV2tY?=
 =?utf-8?B?bWZkekdySmtyWWRGa2FHOEJWeFZReXVzV2dHODNaS1pNZEY4YjVLYllteVla?=
 =?utf-8?B?bmJrL1drbitVeEJRTnQxb1Jkc0FGTm9uMkxSdzFXV3RPTVZGcWdFT2dwMjQ4?=
 =?utf-8?B?Wmp1R0RvblFNTVpISlJkMnhSK0N4MlB5ZWpDbHpLMkdOTjNVS3dqbkdxbjRX?=
 =?utf-8?B?dmZrUVlnTE8vNXF4K3JVeVZUNjhpZEt1UWt6Vk5vNi9IL1ludGNHeWJ4WldI?=
 =?utf-8?B?bGQxRU1jQUE0QUFTam5leWNuOGlGSnY0aUdkN2tEU2NxZnRJNVZURVRjeXZS?=
 =?utf-8?B?YlVJMVppRXB2Z29wZnBjMVplM3g5VFN3cnliVTR3TVNGK0xGUTdKNEhFS0tX?=
 =?utf-8?B?VGV6dk5zcXNaTDU3V3YxcTZOVWwva24zMVZHYlloU3ByaXBVZm54OUdiakMr?=
 =?utf-8?B?eWMwbnpTTE1hRWxhZ0tuRmRRV0d3Um9ReGJPdGlkQ1o4R21vNmwranlOTmtG?=
 =?utf-8?B?OTRMSE5Wa1Y3eGY4Nit2SkYvdFRveHNZelh0Q0hIZDVoVzRCZEdTTCtHY24w?=
 =?utf-8?B?blJoMlZjekhzSDJhWmYxSTc5WWNzbEpSWWFOMXE5Z29JVHczS0FQUE40OWpR?=
 =?utf-8?B?Zms3ZWFYbCszNjU3NDVxcXRGTllJMHVjMU9xQ3EycTc2R1kyZHMrbzQyUnRI?=
 =?utf-8?B?ekdzVXRIVjNLSUJoWHdwK0hudnZYaFAzWWRKeUh5ekt3RlhjTjVIQXNNdC9K?=
 =?utf-8?B?ck1QbkcrbHRpOVNKZENsVWwra3FzOGNzRGx2UHhTRHRKQ3c0eUI0STFBTEpC?=
 =?utf-8?B?WTMyLzI4ZVg3ZmliMlpHZW0xRzBtZDcrN1ZSLzVLSTB0TEdmQWR0bmtKdmJT?=
 =?utf-8?B?UnhaVVVJNjN4TjY2U0c4NjRkS0Z4R2V5OHRGNnFQN3FHWEsweVBjcURzNmYz?=
 =?utf-8?B?aERZRDVxWURKc25pajVCL2dIUldFTWJQQ21xN1hTamp1NlM1UFprS2VRdlNB?=
 =?utf-8?B?d2xHQ3hlZHQ0QnVwWmxMSDd2M1p6TVl2aG1KTUUxV0dOYzI4K24zZXc3SHVC?=
 =?utf-8?B?Sy9WMTI5YUtTeUtYZlFzQ04yRGNJT0M1QzBJRVl1aytpSUJFbE4zTGQ5Qm5N?=
 =?utf-8?B?amZMK2tqSGhwcGwzNEdaZS9QSTZkQW5NM1FUcEhlZVlPbkYrbXhsZ2RiSGFV?=
 =?utf-8?B?YlZUWXlySnhJeVpVS1BKUFpWb3FPdTRpaVhvUmY1VFJXczV3cVN5ZjViSjND?=
 =?utf-8?B?clBDQ25UdC9icWsyOGVLckVvQzRvMVJzNzd5YW9BekREeEFXbkxxY05iRmFS?=
 =?utf-8?B?a2pyNUpXTHlGMlhxOW9kWXdlVlNja00yaFl0bEZkaEczdThZRHZNczFmYXdL?=
 =?utf-8?B?UUdjeDBRWnZuSkRXaEZ3ZlhocUtDUEV1R3hwU0RPVEhtbjdSNWN2am5RY1ly?=
 =?utf-8?B?b29odTNYQ0FaZCtJdFZzK0VTL2tXeXoxS09RU1ZQREZ3MXArLzZsYWRUblRo?=
 =?utf-8?B?ZnM5citDUDdHbDdsQXhrbTYrMTc0N0hqOEJyK216QWh2Y20wVkxpZVRiL2RB?=
 =?utf-8?B?KytYUzRadHdCSGVVeUEyYm9ob2pLNkF4ZStEdHQ1cGpHUUlyalpiRkFKVklB?=
 =?utf-8?B?aTBianQ4TkxDYnlRb1BKYU1JUnE4SWxVZlVhOHJQTlZLbDBPa1UyNjQxUzBl?=
 =?utf-8?B?MzNMS3lXcWdWT0ZwNDZ6dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8829.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzVYRWVEU0JSVlZmUnNlL0ZVaUVlRFBvZURjWVlLa2UrUmVDRXRzVytBWGFo?=
 =?utf-8?B?MG9KOWxnZk5UemZLYTNEc2VWNTFoamxqbFNiVUpCUlF5MmhXM0ptZXROc2xz?=
 =?utf-8?B?VXJMUDRqazhEOU5FRG5hVHB3WVZ1UFFyejBSQnpMOFRVZ0Y5bTFXZGN5V1dW?=
 =?utf-8?B?cDJvZXFaMjRyQW1FeWczNVlLUjVyVEIrY2x6SXRIbHlyLzRaaG5EcjhweFE3?=
 =?utf-8?B?aDVIQWVYQkJxYXpxSENKVFF4Wm05UDh6dEwrNEExL1lWQjZXTkZTQ0krcU5V?=
 =?utf-8?B?ek45cWxtRjNVWFlVZ1g0UFNhS0pMQ2NLMG9pWXp1M1Q5NS8xRzZpdEk5cGdj?=
 =?utf-8?B?S0dvU05CckxWazloait2cDJ0bXVRWS9ZRGdOZU5LcS95YW1XOWxRYUlmRnk5?=
 =?utf-8?B?SjNSNE9GT3FnNmF2ZEZ3NXF2WGpwTTRMMTFDYTJSNGd5MTdwUmNZK3VXVlNX?=
 =?utf-8?B?bGJmWFJjSWdnZFRGKzB3OFJpbHFMaWhLOG0rOGtHTjFnOEdHN1c1MkxBYXdy?=
 =?utf-8?B?cmZsMjE3WEVXL0JsSmdNRmE5Wkg5UTlaMkFGN0IzSEtxU3BOQVBMYlRsYWVj?=
 =?utf-8?B?Y2E3a2YvSWlLVzZvQldUUjhWc0preHY5ZVNJclluZnVUWnlOZWV5RUFwYi80?=
 =?utf-8?B?c2t2VjNVRVpwOWsxc3BtUDNHV1pFdnFIU1Uvd0l4dVpRbnRrZGpCekNpbXN4?=
 =?utf-8?B?Z3p6YUlBQnVHcllYRmtja2RBanBHbFlZdFY1ME5hNXdtbkdsajlmcndHNzhJ?=
 =?utf-8?B?MStYWkxURnJyT2d4eWhQbks1enJlbGpKMW5QUHNyVEZ3cFZZa25ibFAyUmxC?=
 =?utf-8?B?aE9NUitvTGl4Nk5BbEIwUmcrNXE5dXF6Wno4NitGTENneDNOWVpzeVRUazBv?=
 =?utf-8?B?V2IyQllTalRrL0pRbXB1NHhYK2xzTXhxc0ZOcG1pNXphc1hycHVoUkRBM1VW?=
 =?utf-8?B?eHJyUVpRbWFkaW0yVzR6ZnZjVDF5VEZ6MHlvZVdPd3NueDM3MlJFMjFOMXd5?=
 =?utf-8?B?RVpSMTB3M25TakpNSWY2ZGlLNk1oN3JkbGpCU1hmQnNvL2k1TlY3aTlaMWU5?=
 =?utf-8?B?ZUU3cmQwa1hGOVR3VDlDdVhTaFA1eUREbHJqYVJzZTRkeUdFS3BwWTVsN0d5?=
 =?utf-8?B?WGlUSmV2d2RPazBzR3NnMzhiQ3pxNHBhbTBkT2xnd1Y2eUJ2NWtlZTZVeTla?=
 =?utf-8?B?NEJaMjNMcGZ0T3JLanJhYzIvWU9TT3grZXBXZW1JMlVtU1NwbUY2NnVtMExm?=
 =?utf-8?B?RFZXN0ZUMEQ5T3crbVJidll0bVJtUFBMaUtrZXVSVGRNdGpjellzVUdRMVBr?=
 =?utf-8?B?SG9lV0tkV1hXTU14eW9Yc3A4SitQZnloY1Jpa1NVeFVKWVJYeWQ4c3RET0Nv?=
 =?utf-8?B?dTUvd1piTGYyaEQvR1pwUTdnd2lxbVk1c2xKVjd1eW9tUzdZNG43cytBUHJL?=
 =?utf-8?B?MFFFNEN4ZGt4VWYvb2F2NGtrSGI0c0RjVnlxWWltMzJic3d0ejkweE16a3g2?=
 =?utf-8?B?QlgzK2F0clZpSlIzQUtmREhmQTRqUFFLSzNmbjcvZ3JiSFp4STAwdUlEaFlx?=
 =?utf-8?B?U2lDdkpSeDZmbjE0eGF1eGRwVzZPNFlRKzF1M0gvVm0zdmYxM3RIRC9Ud3Yy?=
 =?utf-8?B?TnI1MXdQbjRRV0lIYVZVYk1oLzl6Y0VSd3VBZ0EyM25EL0VhVnN5MmJpUmxa?=
 =?utf-8?B?VW9LUnJwUGhBOGhxRTR4ZDJIT09iU01PMlBIRWhJZTZqR2xvWDNiV3NoaUV2?=
 =?utf-8?B?M2M1TThCQ1crWEJjZDcwMzk5R25GTGg0ZnE1MXlXVEN6T0txZXZlN3BZWDYr?=
 =?utf-8?B?Z0ZqbjNlN3M2V1F4aUdRdXkySktlYmlxaFNyV01zNXkyYXhpVzh6Vk85dkJ6?=
 =?utf-8?B?UlRIWEgzZndYeUlIdk1HeVpNNi9obFZoWXQ4MzJMeCtjOXBZUUlsSnRBc3dE?=
 =?utf-8?B?dFFuU1NpaGZaa2VyM0RWa2lTSG5WUFBGTGlWNXlUd0g2OStVdnhNclZhRURE?=
 =?utf-8?B?ZEJHd3ZSWW16c1lSUTlqQ2ZjQUdEaVNKcXVDcklFL2VESDBuemZsZUpKeWV0?=
 =?utf-8?B?NUxDTEgzeTQwYVZvM2x5MTY4SitTM0lKNTZrUVBySURseXNkVERpWWZTdDRF?=
 =?utf-8?Q?lSEOS2NoxNrjtnzo42dkDBSyQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d27d4b9f-94df-498d-538d-08dcb218d5f6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8829.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 10:58:12.0522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 55XkqjNq6EFtRIUHthw2kSnpAPulzt40ER7cHVLkuh2Cy23KaYTZ9TfSNOq2/NCouXtdFyybt6iS/vStgaVbLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10253

On Thu, Aug 01, 2024 at 10:35:15AM +0200, Alexander Stein wrote:
> Am Donnerstag, 1. August 2024, 08:57:16 CEST schrieb Xu Yang:
> > According to fsl,imx8mq-usb-phy.yaml, this tuning parameter should be
> > fsl,phy-pcs-tx-deemph-3p5db-attenuation-db.
> 
> Should this include a Fixes tag?

Sure. I forget this tag. Will add it.

Thanks,
Xu Yang

> 
> Best regards,
> Alexander
> 
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> > ---
> >  drivers/phy/freescale/phy-fsl-imx8mq-usb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
> > index 0b9a59d5b8f0..adc6394626ce 100644
> > --- a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
> > +++ b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
> > @@ -176,7 +176,7 @@ static void imx8m_get_phy_tuning_data(struct imx8mq_usb_phy *imx_phy)
> >  		imx_phy->comp_dis_tune =
> >  			phy_comp_dis_tune_from_property(imx_phy->comp_dis_tune);
> >  
> > -	if (device_property_read_u32(dev, "fsl,pcs-tx-deemph-3p5db-attenuation-db",
> > +	if (device_property_read_u32(dev, "fsl,phy-pcs-tx-deemph-3p5db-attenuation-db",
> >  				     &imx_phy->pcs_tx_deemph_3p5db))
> >  		imx_phy->pcs_tx_deemph_3p5db = PHY_TUNE_DEFAULT;
> >  	else
> > 
> 
> 
> -- 
> TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht München, HRB 105018
> Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> http://www.tq-group.com/
> 
> 

