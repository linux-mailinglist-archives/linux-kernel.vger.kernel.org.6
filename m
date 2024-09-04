Return-Path: <linux-kernel+bounces-315456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2287E96C2EA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD6E8284559
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125CD1DEFF3;
	Wed,  4 Sep 2024 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T7DAbsvy"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D611E1A14;
	Wed,  4 Sep 2024 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725464981; cv=fail; b=C4QBTiZY4JOVXn6c7f2fUpFHLGNOLj2PyFQ8FEihtmBTCxbRN8qxUDli1rNPcE1GcGroTcHnOHPtGjbiRSfE0u4kC2T9+3y3utKADXz0gSc26cUohDuUIJMCmF3gjVZkW14iQ0x7gAw3nl3TjR5gADAdjhhJ8gjRd/KPL7hTCqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725464981; c=relaxed/simple;
	bh=nEj/K1ERPksvYT9CUWSWEh7L//sN6UL3ybiMuxZKiIg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=IkrwFG6OiBQM7KlGECg3Ju41i8/QjjaKLNqtBviUVm349k1qXoDsVBAIZHRzKXDiscj9c2tu959xUjySIVgN0jy83KUjN8MJNgOl+PpdSzcoLvKzXXx6NpE8M9IHvOj6geNM9glRruHgT8B8QPqTUXMRA6uYvMFwoIZDL2NyvQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T7DAbsvy; arc=fail smtp.client-ip=40.107.20.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvhK3ssGnsZMijlsRa4ol250h+GZicJAWObiHIpR96slQuS0GvCOZXjKoVOPM+C4Q6/Y4iORgsx4h5a1D2xx8C1xI2g949MQIuDq/xg/7aG4pspB9Zh7l5hww9yKmrZ4i+n/z34sel0WzK97L9zrFr559PvTrCzXoLst2kEeMA9646Wld/v+e39JgwuwYx4QBPd2YmTLDTiCOoI97myZmjIuiPrU/4BfkFMCwg0dwcL1k+kzJ0tTktN0ftQlrIyFsoZ6NzZlYo6HRydYGCRyJ6mDb7ODo6JAYBaA7D3myGtNqpKRuLKbAm7fQqIXuawFoDdtvRc8ndGvwuds/g1bZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgm4R5uH4tZ7nv2R+bN4sepTZE/cef+kW8N7+irfSno=;
 b=nVdzU9A+CAU6duPfd61IiMrfJBYd7VNYirrUjVvay9bjrd8HfS0YnTbIEm65eOQBom0fOUDdaF6YQt9wRYu4g9l8r4OPWoyTLhEQ9J5tzT9Y5afUlI7xrMG5vXC6YVkz4MGTZoKIGEOrxWJDEPYiKyJRcBuxgqo8crxkBVfNp+fYGvRg05dfz+OGNUIw2axqXTDlQkPvlLth+sGrxljeIURTUJs+GLC/00w5iUMck4jqy8fCDLFDwBAsyfmNAPEoXtPcO6RKMpK3Gmi4mmhNuM8xmE+rk4t2ZTC0ogqwJcCliRfjuatbw5MGO1CKuqSNQTzagTVMzcKE9W/k3q4Q4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgm4R5uH4tZ7nv2R+bN4sepTZE/cef+kW8N7+irfSno=;
 b=T7DAbsvyGsEcAuwpjvuuH0D6Y7OVPQwSY2omZKs04sLbXmU/OUoZcWmaNuyDyRg/ZikpJxYEswXQ4yKzw60zD+0d0knnGJ+m4Vt+eBL320fd6z8u4efNhVEj9Gv9oxVDZMQASVIpFtJOl/y0YkzhW5jirlyYFCQjUTa3MaQ9EXu0nmOfVJmSBJ1GNvec3khJaItILj7snQ1ujmGPGgQhfIYN+5u/qeM93aLzthXfr20gfZa/OoZbGzBdctonOhWMSIC0lQMR1FFGry0WJQRUsTjR3olqXy/LgceNs7c3NUHCZ9+G6PJbZxtAxKgCx7XbLBMV2aQws0z8qISOHQmJnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9859.eurprd04.prod.outlook.com (2603:10a6:800:1d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 15:49:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 15:49:36 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 04 Sep 2024 11:49:04 -0400
Subject: [PATCH v3 3/3] usb: dwc3: imx8mp: disable SS_CON and U3 wakeup for
 system sleep
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-dwc-mp-v3-3-319947736ec0@nxp.com>
References: <20240904-dwc-mp-v3-0-319947736ec0@nxp.com>
In-Reply-To: <20240904-dwc-mp-v3-0-319947736ec0@nxp.com>
To: Mathias Nyman <mathias.nyman@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, jun.li@nxp.com, 
 Frank Li <Frank.Li@nxp.com>, Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725464962; l=2128;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=5+IVkwBerM0rBDtlaz9W/KvOLIbVp8/vpBPWsSyKKOE=;
 b=99aFnmraoka2Wx+kQOgzshmrwvTcSyOaEC51xOBGH78f7+UGsCOoFgI7JKTeLsYUq6D536/DM
 J0w3y/00tzUACoEsb1pjOutjaz1ym7NwX6sXIEA1Y0l9JMNBpPsu/bh
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9859:EE_
X-MS-Office365-Filtering-Correlation-Id: ef20a551-ee3f-4d52-a244-08dcccf92d8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djg1dmhpU1pKWDRnRysxRERDd2x2elMxazI4WlpweUd5WG54MmJ6WVhVLzYz?=
 =?utf-8?B?eHpqM0ZPSzB3Z1IrK0wvZGs2ZTR5ZDhSZGpnbmFrb0lDTWFLZmQvQStUR3VY?=
 =?utf-8?B?bzdyQjJyK1dvREdsWVpIWE1FRFE1cGpCZWJiMldnMHliSTB4Nnl3MmpXaHg1?=
 =?utf-8?B?UDQ0K0lncURYQlQ2elJ1ZHdXQnlQUHBnUHZUMFBhM2ZxTXE1eCtqVVNQSWxo?=
 =?utf-8?B?dHlGMmM4YTR1UWVDUUVLYzBwUkkzQm9JME1JTUNkVGNwWkJmTGcrRkM4M1lK?=
 =?utf-8?B?Q0xNaDFwMEU4UWMzVFNjeVMveFFYa09JUEVaTEVVMFJSRExaQXpRSE9jTEtK?=
 =?utf-8?B?OFA4bW03T1NlQmpXUjBPZFVoMEptV1k2dnBxelRwUjh5amdLOStqZFNjQVJh?=
 =?utf-8?B?YU1CRzJwK29hRTlaWG8wb0hwSU1JMmxhamUrb29HMnJNcWpVWCtMdlhmUWgz?=
 =?utf-8?B?aDhLUWcvNjQ0SDY1dWcwOHFaaGw1MU8wRE9ZdVR1Y3dtY25SZ3dzVXNUMmFW?=
 =?utf-8?B?SFB4WXZkcU11cWlnZ2plUGJ2MzhWQVE3VkFFYXF5SHNIeHE4b2R6VlM1cUpo?=
 =?utf-8?B?VGRhNHRmWHlOWUZ1b0pBYVRYMSs0cFZNMzc2c2FzVDFrYmFBbVdSVXpqSnNz?=
 =?utf-8?B?cTdqZ2tsZXRsZUo5THU0RmNPMmREUzV0QVpsdDM4MnY3dFVFN0RURVVUN2ts?=
 =?utf-8?B?aHRrS3VBa0ZZdXpMZHNBbTFaMmdGRlBON3F0MXYzSjVmVHh0QmoyVTdMMVd1?=
 =?utf-8?B?MUJweG1hZVFPSUZIdGlYczlrTDYwcDJSRElKWnlHUGh6aFBtTmJVMU1EOG9S?=
 =?utf-8?B?elVxaVIyQVVFcXhjelByNnE4YTE0N243eDNKQVVTUkE5NVdpcVNrVDlyZUcv?=
 =?utf-8?B?bTAwendEMFhobCtEMndWZktKdVN5QytVVDlybUp5eU5KQUJpRG9MdG5KaVpK?=
 =?utf-8?B?QUVRVHhWeW1lWWxNMDNmejFrdjFxMFErVkhHV2tPa2p1TFpiNm5GNldVR1NR?=
 =?utf-8?B?UlN0ZkNzNDhrWGJIZkE3ci9mSFEzcmF4WTRpNXdnRXJiY2FqWXI3THpuTi90?=
 =?utf-8?B?elpUYkhHcFBuaWxDaG9xcnU2MzVuckJHUjd3KytSU3VZVWRxajVqQnA0OXNK?=
 =?utf-8?B?SmNrRDRTNHBnbi9lTW11a2wyb3M3bG92M2YwSjNaQVNZbG1WTzNiQ05oUUpI?=
 =?utf-8?B?S3QrNzArdnpxd0hoZGhidHp0YTd3QnlrWDY0TjlXTDhkd3hVVmFBcm04VWpJ?=
 =?utf-8?B?K25MNXhFSnZRZHBXU0dQMnFBL1h0UTlZcGRRai9HSG90YW51MVlCdGtraTN6?=
 =?utf-8?B?eTAvcmlNTXRlN25oYkkvMG12UHdmNUlabFU5YUwyeXpNV0E4MkpaOStwUkFz?=
 =?utf-8?B?aEtNeGlDS1duTG9zUk1US2VsTWlxdHdxZVMwY2pVWldvcTFidndnZFZ0Z0V0?=
 =?utf-8?B?MHowaVFFSTlJbmlmZzlBek8yN2hLSWNiUk5LR0hKUG1SY1BJWDI4Vm1CazU0?=
 =?utf-8?B?eE9WOWRNSmJIemVmc1daWS95Skc1akIrT2g1L0U5aTdXb2ZSdTZ4bWdnZkph?=
 =?utf-8?B?TnpiWnBMb2FmcllhQ3ltV2R6WWg0ZkdtUUJqNTluNzhJeU9DbHZiMjJmNXEw?=
 =?utf-8?B?VkFtaGlpTXpaZElvb0VNd2QyZmZHWHdHdkRlcXhnc0sxeUhGT1ZtdHJKcExP?=
 =?utf-8?B?a1loYlQ2eldCeDRMMVBhODExZWM4VTBlVjdRaDRnZ2tkRDNxYlUzV2ZVOWFy?=
 =?utf-8?B?cmFJSXc5c05ndHlDRVA5eUFDQnZpVXlzdGdEaFgxTWxzRUZnUk5uTlpaMVlC?=
 =?utf-8?B?WVZpOFRWTk9YMVRUL3h6QmdVaWVjVlRCMm1BYUxvOGZJaTZXTVgxaFExVFp1?=
 =?utf-8?B?aXkvU21zWlFqcGtYQ09FTEloM2RGanBOd2xNY3p2NTgrYlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmJobllHekRKNHVXT0RBNEJHaERhTmRFb3NpTmFsWUZzekVQaUxtMDNvYzJo?=
 =?utf-8?B?WHdCeXNkNnhOa0xnTXVkZjNyVm1oL2VHV3Ivc2E5d2NNVm1iQXMzSmZleVFu?=
 =?utf-8?B?Z3JPblRUR096UjVWL21QbzBHN0dJeWpjV0pEbldLbnZKL2RNWDBYc2FocWpp?=
 =?utf-8?B?dldZWGFYUE9VVnJYQkh4cytvdEtOcE50RDJuRHlnb1Y0VG1qdjBHYUFyVVc5?=
 =?utf-8?B?dDVmME9zTjIrSnB2ckVuNWVpVkk2SGJ1all5UkNzNXkrY3FLNWVIRWQzaTJT?=
 =?utf-8?B?ekVjSzFCUFN2QVEwWnZ6a052RHBxK0grSVAwMkVxVW5qV1FuRnNlT01yeWZo?=
 =?utf-8?B?bjVBR2VFdG9FRWhNWHBMckVkM1oycVFBMXRwS2lPOUlXWDNqM3lsSDU2TUF5?=
 =?utf-8?B?R2dFbWNrakQvSXpaM0xpMDMyQ2lscGtWQ2ZNL1dhY0JVSVBCRWo4dElMVGNT?=
 =?utf-8?B?dkpyaThCTzhhanVuc1lGTHlWK3VQT211cEFJa1RoSXNKaGN2N3d0K0E3S3lr?=
 =?utf-8?B?NlNVWFRaOE50UVJ0d0FpbzhHdWxWeGNOVjk2Ry9jZktBbGFDT3AxeEhZYUNa?=
 =?utf-8?B?Y2dRVWcva04rUEtOUmRiRnNsNDZUWDZlQTFSNFlGSTdTS2RWWXFNT2xUanlM?=
 =?utf-8?B?RXF4L1hvMGNnckl3MHpWSUl0S2lMQXZwUmxGTkU3cDZyQzVucWJLS2FqZVl4?=
 =?utf-8?B?U1dReEpEQzA3ZGtsTzFUTjhDRDhYSXR0SndyNmpVNmxaUUIyM3VuQ0ttbWxH?=
 =?utf-8?B?cVFmV0ZSaFBMbVVyQjVHeGNZbjAwOFl6ZXc0MTZ5OWdSNGhDeW9hcGI2WlZz?=
 =?utf-8?B?cUhrQUxZdUhuemYrOUJoY1UxRjBPRHNFc0Z0YVFmbGJKRkYwL2RNaWhlK3A4?=
 =?utf-8?B?Y1VOZmwyaGIwd3V0U1hjWk5HNGMvWExEcnVxWStQUlpYZDFOYVVSZkNZWUZE?=
 =?utf-8?B?Wm5HYXJaaEphQWpPODVPekZkQjl3VURUR3NDWktUemQ5V2RUOWI1NElkTk4v?=
 =?utf-8?B?THgxa3RCK3ZIQUlxTGdvRW1CRk96aU1LWTlyQ1ZOVnNXc3hsb1NXNUtmSDRr?=
 =?utf-8?B?NjQxanYxVndZN0h1Tm5xYXovR04wMkNlSWR3VE55ak84Njh2cWZRVllYakk0?=
 =?utf-8?B?ODE3SVVVRjFGSGJ2TUkwWkcrZE5yNzRhUitQQ0E5dWxmbFNCejlVelZORGgz?=
 =?utf-8?B?YWtmRzlHYzN2SjQ5Zklxam94YWoxTkRzSHNWUDh2anFIdDk2ZmlQSENsZlAz?=
 =?utf-8?B?SjhjcUpsY0Y4T2JCSHV6dzM5WlpkV08xMFZ6TUNzVEthYTYwR2Znd0FGVDVY?=
 =?utf-8?B?TkI5QkcxNGdPZm93TDJHM3d5RUZycUZVcUc0dDVSSEtid2d2b3ZQNGdPUXZM?=
 =?utf-8?B?N3ExbXNJZ0pGY1EzbWV6SkRJZjRHbmc0dGlYZG9zSXZCNW02YTlaU1Vuamhm?=
 =?utf-8?B?ZTlyMWRURWVMYXVoYXc1SkFuUDBJVkpYQ2xMclRtbHVsek9sZ2xrbjE0MWNJ?=
 =?utf-8?B?UnhTL0V0eW8zTUlVMWRPd0lPdExLWlJwb0NBSk9yelN6TTVzczJoZk1yL3JE?=
 =?utf-8?B?SUwybFFEUnNtdXpYTlNYU1pGcHMvdHFtemZDSnVDbkZsdzdMVWpWZ2dhOUhi?=
 =?utf-8?B?VC91Wm84ZFhRRjVGM2JCbW1ieGh1WnpjSHFaUW9uOStLSGJpTWJLU2hXUDh4?=
 =?utf-8?B?Y3NBb3gzWTN1SVEwQ1RvZUFwcCtQWmVQRFBxSTJ4RTZpZ0NTRy9DclI4ZEFj?=
 =?utf-8?B?cVhyZStCQ1d3YXFJUVZqSW05S0tRK1RJM1o1TEwxVFBNajZNTnpuemFmdE05?=
 =?utf-8?B?dWIxbUpWSm91UUJ5Z25Fd2N6VWRPYWdicG5yRFpxMy9Ec1VQSndZbDRtMWNl?=
 =?utf-8?B?R090RXg1Qk83MUdjcFZhVW1QSjcxNTZCMHAyVitibjI5VUR6ZjZlK20yOW94?=
 =?utf-8?B?VGZvdi81TGQwZklWSE0wSWRvL1NlTHdzNW1WblJIblVBbzZLSGlWemdqZEU4?=
 =?utf-8?B?SzlrM1ZWdWE5b2pWeHRIUFM1OUFydFUvVkxxcC8rZ3d5YmxPanNMWllwMGZX?=
 =?utf-8?B?ckhEY1A0aGdpbjFQWWFnbDhhVW9LUC9obC9vUXBFRW1Oa0I4OGx3cXQ4dDZv?=
 =?utf-8?Q?nQuWSmSMqKigeFHJ2hx87OZI8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef20a551-ee3f-4d52-a244-08dcccf92d8c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 15:49:36.3740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yvZBRkWRbeyB6SEgcK3aezGvL7RzRM82pHLfhdAoxI1P9HQ2g3Pn2ovVzUYwI8d6vccoV84v3Tktef3XuQhUhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9859

From: Li Jun <jun.li@nxp.com>

SS_CON and U3 wakeup need 'ref_clk' on. iMX8MP turn off it while system
sleep, So disable these wakeup source and only enable DP/DM wakeup source
for host mode.

Reviewed-by: Xu Yang <xu.yang_2@nxp.com>
Signed-off-by: Li Jun <jun.li@nxp.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/usb/dwc3/dwc3-imx8mp.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-imx8mp.c b/drivers/usb/dwc3/dwc3-imx8mp.c
index bd6953246f42e..02159cd820a10 100644
--- a/drivers/usb/dwc3/dwc3-imx8mp.c
+++ b/drivers/usb/dwc3/dwc3-imx8mp.c
@@ -96,7 +96,8 @@ static void imx8mp_configure_glue(struct dwc3_imx8mp *dwc3_imx)
 	writel(value, dwc3_imx->glue_base + USB_CTRL1);
 }
 
-static void dwc3_imx8mp_wakeup_enable(struct dwc3_imx8mp *dwc3_imx)
+static void dwc3_imx8mp_wakeup_enable(struct dwc3_imx8mp *dwc3_imx,
+				      pm_message_t msg)
 {
 	struct dwc3	*dwc3 = platform_get_drvdata(dwc3_imx->dwc3);
 	u32		val;
@@ -106,12 +107,14 @@ static void dwc3_imx8mp_wakeup_enable(struct dwc3_imx8mp *dwc3_imx)
 
 	val = readl(dwc3_imx->hsio_blk_base + USB_WAKEUP_CTRL);
 
-	if ((dwc3->current_dr_role == DWC3_GCTL_PRTCAP_HOST) && dwc3->xhci)
-		val |= USB_WAKEUP_EN | USB_WAKEUP_SS_CONN |
-		       USB_WAKEUP_U3_EN | USB_WAKEUP_DPDM_EN;
-	else if (dwc3->current_dr_role == DWC3_GCTL_PRTCAP_DEVICE)
+	if ((dwc3->current_dr_role == DWC3_GCTL_PRTCAP_HOST) && dwc3->xhci) {
+		val |= USB_WAKEUP_EN | USB_WAKEUP_DPDM_EN;
+		if (PMSG_IS_AUTO(msg))
+			val |= USB_WAKEUP_SS_CONN | USB_WAKEUP_U3_EN;
+	} else {
 		val |= USB_WAKEUP_EN | USB_WAKEUP_VBUS_EN |
 		       USB_WAKEUP_VBUS_SRC_SESS_VAL;
+	}
 
 	writel(val, dwc3_imx->hsio_blk_base + USB_WAKEUP_CTRL);
 }
@@ -307,7 +310,7 @@ static int dwc3_imx8mp_suspend(struct dwc3_imx8mp *dwc3_imx, pm_message_t msg)
 
 	/* Wakeup enable */
 	if (PMSG_IS_AUTO(msg) || device_may_wakeup(dwc3_imx->dev))
-		dwc3_imx8mp_wakeup_enable(dwc3_imx);
+		dwc3_imx8mp_wakeup_enable(dwc3_imx, msg);
 
 	dwc3_imx->pm_suspended = true;
 

-- 
2.34.1


