Return-Path: <linux-kernel+bounces-215110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC4B908E41
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A287C1C22AAC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D343719AD95;
	Fri, 14 Jun 2024 15:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QQMtH/Fb"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2046.outbound.protection.outlook.com [40.107.7.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD1815F406;
	Fri, 14 Jun 2024 15:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377616; cv=fail; b=Cn5AYjfRqI9U7HX8Sg7MhOhbDCEC3qtH86gcNnp8tBQvnXzGVZr19ukqiavnUUO386lhsnafT5zvTyqGjlX/1/WfKGIxH5pfShmK6ue0w6tjWTIoPYlkcbKwB4EcO8rd6vBkc5fsxkNo7uOvVX0G0163NaLnNZgHVGvfpdz8Ui4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377616; c=relaxed/simple;
	bh=6CJPAZ8e8BI6FjuCSEqwivhlEFglrjeb/i0fDBlJHdc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=NCP95Ju4uek6BEces7ji92ycxV0oXGMg5hBriYo3EbCqK9pRDPhvEwPnYNSYSedktog/7vQGqxJNob6R6gp8VR5CF5RtWniwlNCYIn5m/9N4TYMUEQT4NEPj03SK7lr/rN/ZRtG069Ai5j6/6kGi49KFVUuTUafKojPz53Uk5zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=QQMtH/Fb; arc=fail smtp.client-ip=40.107.7.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPp7E8dsJ2IRd2pJ01JITL9kzMx8Y3Sc2OK/inoaFSlHZ97s9dxrU5859vSCbkYv2DAa8IRuNRD1jpSSjSeSovSshdoHulUn3GRNin+SztCx00bwDkasnOMBrlRhFUv9aBlRFWmxF73/Tuxn8rl9E7UHD2+v6UM45NH+/9P69SdDwayhA6kA7cYFEBE9mZKNs1XtzNggaTtoTlnxv9QFzhdXCF91KkTlVMUZqratHdkF1adG+qt0x3oWTqxDhOtV3GANui7dDG+RzUGZkvHzF37jmKn5TBOHI3OK8WzorfJZSJgYSLyH68Unbgf1qv1oU/yHZdvKTMImdGwEvT/o2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6cmgDLhxwvgBjRZI1xtc3M5EhP5vROWvCU9HID4XuQ=;
 b=RdhpiRIRKAYKB7Ji9g6X4FEt7QJYOl1Y7lBL3EI5ZLtVUSgzgVm8AHxsoqPzMz71hsr0POqDFoGUn45k5tB6bNpebyZx+VXTjB46TY5553/EXn+MdNaKt+4RP1RGL74yj0MTbSznYwTjS545aNbEYjXGMZ/3wu63+hHD+pigotGBLPH3Tui+6PLGilxipYAbGmDZ2HXxYdKsh6Oz1Gr/YCWQ0Bp29HcOXuGYFWADE96sRxlZKimslVmZjXquHbooHXFM6rXFHh/EOjk4r8I9ICoh7pba4umh8/H6cbT014xVIVHFRvdS+jrVdzRMY64YOw/s+Z716AAz9IMDO2R+wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6cmgDLhxwvgBjRZI1xtc3M5EhP5vROWvCU9HID4XuQ=;
 b=QQMtH/FbvpiEN0OAZAE+3AuVQGPZTMzhVQVqi7wwLjsUQT83TGhz9IoxB6xcChiyUvLbLb0jvgPY5I/flE+sn0uJDkwOnwLt/86jiuZPD+pdFZIyEqIW2cG4EhKOaq16iiB7yvfOdSu7dj2OyepejWjy18+zaMVstYCE1k9uGNg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10971.eurprd04.prod.outlook.com (2603:10a6:150:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 15:06:51 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 15:06:51 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 14 Jun 2024 11:06:25 -0400
Subject: [PATCH v3 1/9] arm64: dts: imx8: add basic lvds0 and lvds1
 subsystem
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-imx8qm-dts-usb-v3-1-8ecc30678e1c@nxp.com>
References: <20240614-imx8qm-dts-usb-v3-0-8ecc30678e1c@nxp.com>
In-Reply-To: <20240614-imx8qm-dts-usb-v3-0-8ecc30678e1c@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718377604; l=6535;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=6CJPAZ8e8BI6FjuCSEqwivhlEFglrjeb/i0fDBlJHdc=;
 b=uBjb52yo2PLXvtdzVGO38wIVF/nvm898RVj4aocaAcwF0mNk+yBp9KXjMN0CgWznWbecYUt9t
 0HntEzAK3HvDjab/UuT3TYYh7MTs91MxjnRZBIbRa37CJ4BVd+cjgAA
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10971:EE_
X-MS-Office365-Filtering-Correlation-Id: 54290f6f-acdd-40ac-e1f7-08dc8c839eaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|376011|7416011|52116011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTBjOHQydGpLemVNbWdOWG9rcm9GcCttaG1LZXp3U2FrVWZkRWt2Vi9Ndm1L?=
 =?utf-8?B?bTNKNTc0LzgyVWZTUTVjTWhhcWVKcURXWG80VElFNzh6eS92bW14WUxyQnNL?=
 =?utf-8?B?dGRBZTMzb3ZjVTJOazFHR0pzZGJFMUJ5RExJREtYSlFLdFNmUk1HdGpWcXd6?=
 =?utf-8?B?aVN3ZGtUMHZVN1EyNzJNU0d6UFkzNDJlVG10RmFWK3JoMEVIcFJ0YjBPb0Nn?=
 =?utf-8?B?K2N1Q0loWHdPM2Y3dDlyZmlsWWp5U3FpVGlCMVB0Tm9RMzAvcW8rUWN5bU9J?=
 =?utf-8?B?eGpEZUZISEErQmNheFhYczgzZWJMbEhjTjhyd3paTXYzdkh3c0l5VHZhbS8r?=
 =?utf-8?B?bDIrQXFwTGNyMUJsWDlFd09ZVWdFbjdZUVdZeWlobE5pQk0wZ2l0YytFOURW?=
 =?utf-8?B?M3FNbWRrdmVxbjZUZmN6N1lHSjlBL1dLMVNHdGhKTnlhaTlaNlAxT0NiV2Fh?=
 =?utf-8?B?dDRrN1hqQWpFSXEybkUzQit5VnVLVFVXaUpKM0E5a2hoalFROUV1bzFtZUdK?=
 =?utf-8?B?NXpYRlFVcXhIeEtLY1ZGMm5TUFJyNng0alpDaFliSnA4WWQzcENoRFhzTEZ6?=
 =?utf-8?B?bTBjZEpVaCtkK0V0czYzWkhjWEVFZUVpbFh4VE1uWE5HNVAwSTFwNVhrRjZq?=
 =?utf-8?B?aVY1RFBYUW1qSysxMnpOYjBMZ0xuano1V3dDcElxMy9Pd3k4cmpGaXZBdEtV?=
 =?utf-8?B?VXNod1o3VWMrQ1pDVnVINnh5QVNMMG9pRHhPR1NGQTljRkR2aVgwMnQwbFIv?=
 =?utf-8?B?R3JtQ1BRRnFsZU1HdnhVYmRtb0p3eFJkUDkxL2NoNDV1UDAxYnpMRFdJSVpy?=
 =?utf-8?B?anJNM014VmY0Wnd4a0JoZVV1d2tLb0UwL1Ura05LaHJ5QmlaSEdPK08vYXZu?=
 =?utf-8?B?Y29yK01OZ282NWR0dldORnFCSEFSY3N6WlluNFU3cHhFVnF2RDRLaHlhbjUy?=
 =?utf-8?B?Mkx6aDhuQlBIS0NsTStHcEI2L1k2NGR6Wi8zbS9KTm5oUE5SZGFwaUJia3Bx?=
 =?utf-8?B?SDJvcmZXMytXUWl6bnY5Q28yNXhWL0lmZHZrTDY0VS9MeW9mZmpzT3BIYStJ?=
 =?utf-8?B?SU5SK0h0VW1uQkFneDV1N0JNMEhoQnNHOHpYVHVZbUQyVkpEWkEyVWNTVFRF?=
 =?utf-8?B?bDFDclVCRStjdk9UeEFiUlNTcUFwNEozL1ZoRzZLaG81SWdISlFDcVVIbkhY?=
 =?utf-8?B?YzN5M205d1QvZ1RCNkRob3VXZGdvaDVmS3BjUmMxb2xnQkJadEM2RjRzVm5J?=
 =?utf-8?B?RzAxQ1dObDNlaW1xdTBta2k2ZmNlWWlxSlFtWHlmWGpxdEpsTVBNYU9lZm50?=
 =?utf-8?B?VWVyaHc5cU9kazh3ZDczeHpBQ2E3MENkWUVTZkdNQUpOdTdpakNFSmF3dnVv?=
 =?utf-8?B?bmxaZ2pIZW5OQUNkbEQ3Q0FZL3l3M2RxdHhqbURoRTJSU0E4YU5CZVVUWC9x?=
 =?utf-8?B?NC9sd04rcjAvd3g2eCtSTi9KSVI2NmJxMURVOEZFSFJETDNYcGNDMUNzMTlB?=
 =?utf-8?B?N0M3S1FFalVlZGQ1ZVRYSEFVRVZid1BtVHFVdzNFSm5vQ0tXTUZ2dlBJdTkv?=
 =?utf-8?B?dHhveVlYVFhIVWVJbnBYM0dWbDZrOTZSd0VRbWd5MkJvRVNnYlBTVzB4bE9s?=
 =?utf-8?B?c3pOa3F2MklXWmdKTjVpdXhtaEIrSTl4c1gxVkZsZEVzTkg4REpFYWVlUHBs?=
 =?utf-8?B?Zk5TVWl1VFg4UjlNQU0vZ1VCQWkxSGxrdncvNmZ0YUxDcS9ISDUxeHZsNEY3?=
 =?utf-8?B?L2srOUVrMEQ3ZmNzb0tvOFFOZWRwVE1oelMxZDdSOUpxT2FvZlpnZ3lPbEVX?=
 =?utf-8?Q?RPv2bFR/5iseaH3WprPJFuyPSh5aGSQYoJVOE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(52116011)(1800799021)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXNhenMwZ3NueEJyUzFZTHUyZkF1VG14dm9paVFFdjRsb2FidXZrZ0VkVkJ2?=
 =?utf-8?B?bDNRVUJxUE9xaTVWR1ZmSjY2QS9zMGp4WngxL1REdit0bUxxT0U4a1lhRDRD?=
 =?utf-8?B?Ty85RmlJckJyZVZpTEVmTndRNDhmWi81MVRHR3VlTzhZdmx6ZFZTSlp3TEZs?=
 =?utf-8?B?Q0dJdmF3dkxmaFg3dnRYbmtybi9OMTFCTGhRS09DYnR6TkxBT1lCeFlnSXE3?=
 =?utf-8?B?cGxCYm5VRlZoN1I3UU1SWjk4K0JtK3hJN3lRTmw5NEZ4MlQ0SVFkSmxUSFZj?=
 =?utf-8?B?Q0VwYmdxaWNBcS9LL0IyZlRadFNIdC9YVHNkbWNIbWdNNG1MaGdlNUFCZW9J?=
 =?utf-8?B?UEl6eFhjbDhXb1M5VVdUQlhvM1pLdlFnNEdMTXpDZVJBaXlhSUp4QWtsTHBq?=
 =?utf-8?B?TDQzRW1YYzdJSzdSNWZVKzE1M0hadTk4cUpydHFhK1ltWGlVbGJSTWlmclVH?=
 =?utf-8?B?QUI3T0EwczltdzkxZ2NFRkNrNnZQUWVBenlmU2VRUkJXZURCNHVQK3NpK2Mx?=
 =?utf-8?B?ekZTWnJQbU1CSCsreElxaUVVNGdCclhRSkJzcUFSeG5MaDBIZXJQYXVHMmd3?=
 =?utf-8?B?bkMzb01hSTc1dXRrZkh1YkVSWEdrMzZGcVdobzdBQzVVeHJaVzJMTGMvbUNW?=
 =?utf-8?B?azNzQzlKL2JjalFCSWJBUkQyaUxqK3YvUmpHZGdJZ0tDQkpPUXVxUmg0NW9C?=
 =?utf-8?B?WnRmODliREtoTkdoaFl0NEE0QjZLYkFyTDVOMFNCUWlGR1lhQnErelRVQktq?=
 =?utf-8?B?U2ZKWjljWEErNSs2YlFvbXc1cEt1S2VzT2h0aktpRkpuMmZWOVhhZUZQaTBx?=
 =?utf-8?B?NkxXSHo4cFlkTGF4ZFdYUzBNU3NyeG9ZdlJONFFjM0R0RVpFWnNrWGtpOWFx?=
 =?utf-8?B?RFBjWmZZb1oraDJKR1FkV3dMQmQrVWc5YktwRTI1M2p1cVpFRk85alNTZVdZ?=
 =?utf-8?B?b2h2UGEvMGpiWFdNVTdsV1U2TkE4Lzl6aUpwRUJFRjlBRThnT2JmZVk1QldT?=
 =?utf-8?B?eVFYV2tBUnozeG5TL3BTdzhyZWZrMUFUOEtYQWVRclJNbERJVDcwL2JSb09H?=
 =?utf-8?B?MGlJQmc5Z3IyY1l1NU8zTUxmazA3K0VoN0ozWmdvaGpZcm9TQ0pzZ2tyQ2Vj?=
 =?utf-8?B?bE14TGVmWGpxUVZnNUgwU2kxUU1zQ0lIcUxtaUxtVlpyVjhPOVRTakRKVnhu?=
 =?utf-8?B?UFRFVFpQVDk1eFhDWjlTSllpdktVZEJrY0lPUHNXOUVwL2hGK2hMZEFaQTc2?=
 =?utf-8?B?bkd1cExjd1NtNFBZemxYYTdYWVpkSGNzT2tVQVZBYWhRclVCKzAxN2NvRnBK?=
 =?utf-8?B?M3RRNWJNMUs5clhqNXNUMVlYc3ZjR09GNzlISVBuOThpclJtZlR5M3grYi8v?=
 =?utf-8?B?RlUrMkNhclRyeWVZQ1VzTGhGbm1zQUtOMFNINytoVEQ0Zk5KMS8yYWh3QThQ?=
 =?utf-8?B?NmFyR2RmdXRhYWpHVGFhaTF5bmhubWFQSU5oOUV3eWthQ21YUWxZR0lrUmxH?=
 =?utf-8?B?MTlCN2xsdWtzcmUrd1hMVjhNZWNScHhxSkRhcXF3STJIZlRMV0NWWGo5dG92?=
 =?utf-8?B?ZkE0emhGYVZ4YUl5RXVYTmo1UmZmYXJ4cjdHOURPbTlYYU9MYlNLd25lNFF0?=
 =?utf-8?B?T1hLZWVUQ2FmalpWMnJmeHhHc1gyM3hlMUd3QmtKWXZnS2Jnd1Y3MHlRT3pX?=
 =?utf-8?B?NExrcU9ZRGRMcWVhTjVwcW9BMWg3b29YaUNtQXBSRTVtZlVjZk1mOSs1cUdp?=
 =?utf-8?B?SWRpRFJMNjZIWThYZXcxdlhUNzFTYy9DRXEwZW1oWFFWVldXUVV0QTI4eUln?=
 =?utf-8?B?NXlwVjVUaWlONGdtTTBrQW9CVzFsVXNSQ3FmNUxkZCtpQWhGWkhzbEx5ZkNT?=
 =?utf-8?B?enB4RmNLcHFkbTFDenBSekkwNFYvaFozR2FCeW9uRVJPdGhkcmtteVpIRzVT?=
 =?utf-8?B?cTRpNURKZW80WkFXNFAvZnBVa1BJM1hqaUFJUkowVzRrVDNBVzVGb0YrSEdp?=
 =?utf-8?B?VHlNV0kxdndQb3lOU2c1ekRHdnFCUSt3MFM3VHBwNERXVXQwOFBRUzJwUmwz?=
 =?utf-8?B?ejNnbm1ZMFp6YzlVREdWMTJqL3I4ZVVoS0hCVWc1NnQ4a2J2dElyWURDZEo1?=
 =?utf-8?Q?rZLE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54290f6f-acdd-40ac-e1f7-08dc8c839eaf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 15:06:51.1733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KErKZP95hyZYVobBLWvayVRRRqUdB7WEQwzXRrqi6FK7m6XMUjGJjBRFla3At7y12sBsd2PXDNRR/lygHBGKNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10971

Add basic lvds0 and lvds1 subsystem for imx8qm an imx8qxp.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi |  63 +++++++++++++
 arch/arm64/boot/dts/freescale/imx8-ss-lvds1.dtsi | 114 +++++++++++++++++++++++
 2 files changed, 177 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi
new file mode 100644
index 0000000000000..d00036204a8c2
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-only and MIT
+
+/*
+ * Copyright 2024 NXP
+ */
+
+lvds0_subsys: bus@56240000 {
+	compatible = "simple-bus";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0x56240000 0x0 0x56240000 0x10000>;
+
+	qm_lvds0_lis_lpcg: qxp_mipi1_lis_lpcg: clock-controller@56243000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x56243000 0x4>;
+		#clock-cells = <1>;
+		clock-output-names = "mipi1_lis_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_1>;
+	};
+
+	qm_lvds0_pwm_lpcg: qxp_mipi1_pwm_lpcg: clock-controller@5624300c {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5624300c 0x4>;
+		#clock-cells = <1>;
+		clock-output-names = "mipi1_pwm_lpcg_clk",
+				     "mipi1_pwm_lpcg_ipg_clk",
+				     "mipi1_pwm_lpcg_32k_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_1_PWM_0>;
+	};
+
+	qm_lvds0_i2c0_lpcg: qxp_mipi1_i2c0_lpcg: clock-controller@56243010 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x56243010 0x4>;
+		#clock-cells = <1>;
+		clock-output-names = "mipi1_i2c0_lpcg_clk",
+				     "mipi1_i2c0_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_1_I2C_0>;
+	};
+
+	qm_pwm_lvds0: qxp_pwm_mipi_lvds1: pwm@56244000 {
+		compatible = "fsl,imx8qxp-pwm", "fsl,imx27-pwm";
+		reg = <0x56244000 0x1000>;
+		clock-names = "ipg", "per";
+		assigned-clocks = <&clk IMX_SC_R_MIPI_1_PWM_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		#pwm-cells = <3>;
+		power-domains = <&pd IMX_SC_R_MIPI_1_PWM_0>;
+		status = "disabled";
+	};
+
+	qm_i2c0_lvds0: qxp_i2c0_mipi_lvds1: i2c@56246000 {
+		compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
+		reg = <0x56246000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <8>;
+		clock-names = "per", "ipg";
+		assigned-clocks = <&clk IMX_SC_R_MIPI_1_I2C_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_MIPI_1_I2C_0>;
+		status = "disabled";
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-lvds1.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-lvds1.dtsi
new file mode 100644
index 0000000000000..12ae4f48e1e1c
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-lvds1.dtsi
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0-only and MIT
+
+/*
+ * Copyright 2024 NXP
+ */
+
+lvds1_subsys: bus@57240000 {
+	compatible = "simple-bus";
+	interrupt-parent = <&irqsteer_lvds1>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0x57240000 0x0 0x57240000 0x10000>;
+
+	irqsteer_lvds1: interrupt-controller@57240000 {
+		compatible = "fsl,imx8qm-irqsteer", "fsl,imx-irqsteer";
+		reg = <0x57240000 0x1000>;
+		interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		interrupt-parent = <&gic>;
+		#interrupt-cells = <1>;
+		clocks = <&lvds1_lis_lpcg IMX_LPCG_CLK_4>;
+		clock-names = "ipg";
+		power-domains = <&pd IMX_SC_R_LVDS_1>;
+		fsl,channel = <0>;
+		fsl,num-irqs = <32>;
+	};
+
+	lvds1_lis_lpcg: clock-controller@57243000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x57243000 0x4>;
+		#clock-cells = <1>;
+		clocks = <&lvds_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_4>;
+		clock-output-names = "lvds1_lis_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_LVDS_1>;
+	};
+
+	lvds1_pwm_lpcg: clock-controller@5724300c {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5724300c 0x4>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_LVDS_1_PWM_0 IMX_SC_PM_CLK_PER>,
+			 <&lvds_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "lvds1_pwm_lpcg_clk",
+				     "lvds1_pwm_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_LVDS_1_PWM_0>;
+	};
+
+	lvds1_i2c0_lpcg: clock-controller@57243010 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x57243010 0x4>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_LVDS_1_I2C_0 IMX_SC_PM_CLK_PER>,
+			 <&lvds_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "lvds1_i2c0_lpcg_clk",
+				     "lvds1_i2c0_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_LVDS_1_I2C_0>;
+	};
+
+	lvds1_i2c1_lpcg: clock-controller@57243014 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x57243014 0x4>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_LVDS_1_I2C_0 IMX_SC_PM_CLK_PER>,
+			 <&lvds_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "lvds1_i2c1_lpcg_clk",
+				     "lvds1_i2c1_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_LVDS_1_I2C_0>;
+	};
+
+	pwm_lvds1: pwm@57244000 {
+		compatible = "fsl,imx8qxp-pwm", "fsl,imx27-pwm";
+		reg = <0x57244000 0x1000>;
+		clocks = <&lvds1_pwm_lpcg IMX_LPCG_CLK_4>,
+			 <&lvds1_pwm_lpcg IMX_LPCG_CLK_0>;
+		clock-names = "ipg", "per";
+		assigned-clocks = <&clk IMX_SC_R_LVDS_1_PWM_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		#pwm-cells = <3>;
+		power-domains = <&pd IMX_SC_R_LVDS_1_PWM_0>;
+		status = "disabled";
+	};
+
+	i2c0_lvds1: i2c@57246000 {
+		compatible = "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
+		reg = <0x57246000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <8>;
+		clocks = <&lvds1_i2c0_lpcg IMX_LPCG_CLK_0>,
+			 <&lvds1_i2c0_lpcg IMX_LPCG_CLK_4>;
+		clock-names = "per", "ipg";
+		assigned-clocks = <&clk IMX_SC_R_LVDS_1_I2C_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_LVDS_1_I2C_0>;
+		status = "disabled";
+	};
+
+	i2c1_lvds1: i2c@57247000 {
+		compatible = "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
+		reg = <0x57247000 0x1000>;
+		interrupts = <9>;
+		clocks = <&lvds1_i2c1_lpcg IMX_LPCG_CLK_0>,
+			 <&lvds1_i2c1_lpcg IMX_LPCG_CLK_4>;
+		clock-names = "per", "ipg";
+		assigned-clocks = <&clk IMX_SC_R_LVDS_1_I2C_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_LVDS_1_I2C_0>;
+		status = "disabled";
+	};
+};

-- 
2.34.1


