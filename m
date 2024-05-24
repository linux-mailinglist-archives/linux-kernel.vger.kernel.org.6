Return-Path: <linux-kernel+bounces-188481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C90C8CE28B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDDBA1F227C2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 08:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1BA128376;
	Fri, 24 May 2024 08:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RmE0NcZo"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2087.outbound.protection.outlook.com [40.107.247.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC351129A7C;
	Fri, 24 May 2024 08:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716540490; cv=fail; b=t9iru8GJLoc2sNAk16RENleqjhnAYWke4addVemSlyjXt87Ro3BuJbHvc2LlOWfUk2HHeNnViGdg+jCS2pTIaWYNUVRv0DpItgUgb0IJjm1JLnSbg88G+LjOwB25u2N7pJCzhFWRWOHnzWy5xX0QkN91i0Nrlq9HwKAfxxBk3+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716540490; c=relaxed/simple;
	bh=Pv6FbF/1tuFsRyFZD5XM1/4ygDzddXPKHOtYRpuQV1E=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Px0P2hZgAZ0WzlDmfRU8Rz61JHmlUhMD9FChshtTbI1/Cvok8BQ5JLAl5gYR5YEqiWDFklPAYt8n6IKm8YoyKGUzSBerEnZaayOwOfJxGY6kTCGOD4IWsQGvrNvUvvrr6MtHlK/0OBto+yqOPMI622BBuHGuz6nfy0t2URAAEtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=RmE0NcZo; arc=fail smtp.client-ip=40.107.247.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhCYoO5GbmglYIBBqcbGjK8VTfyLFmxfjbsLPBJllwaNnOosLe7FngGVMdjLwjJJNhF4C0Koo2528rxmAn8lvpwJmlEulYbAxfHo7fwfFBvDWJe7Pf6jQJLNIW2UvLtciCMnt2+Sv7cLMj08N+MAp+luBMb5v+d3nZHtVTr+q+7jhfFWkrRE2LCBE9VLjv8C7/Sbzk/ru4pM/qwkA3oGdgSqnCj8FOK/2c6Xvb3If1sXPA7v3U0Z1xdRkdJzACfrOsPWv7dBYHi7OqxA3mKLK/lweOsUaxKsLsB0k5kw0JyIPdNIfjVQJkDzynlS/Tjg1vzSFT3U7UVKn0sNvOwifA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2gl1Sp6ayVBbajmw1IMfR+FqAfWlcMNAdiZatq5fI8=;
 b=XTOGqsjUIROBv6+I1i2iMxboJyuAlrChAl9MTZdUzessDw3HLxaNe/+33jN4i0XIVFBkCR7jor7MZibnFeI5pWWV3UAfhNxLt/NHymTL0eHCyPdVVjVQlwl/h2dS0AMbzOFMWyTOuzEPH6fp1NN0O4TqVO//O/bdajOA9ZP4W1AbN6bg8mkXR+gbTU1YqzViytKTU+6GcvdMVmAv9AxudCZnH/vAgy4AqiBrcViytmF/6NfEwxjHJ6YYC1KILtgoPkRBcTtPXo+cNazIIMyKWZHMyIq64UmF3f/i3PrreertKbvUs6Sg/gNa3ui5L9Wrr9luC2Z6JW5G3P2EJONmqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2gl1Sp6ayVBbajmw1IMfR+FqAfWlcMNAdiZatq5fI8=;
 b=RmE0NcZo7GQkppAXwvZXXJPCV7aE/EdXwBEZTx17L5DNuT/Z73J7SnwuPfJycM1v85xDRjqi1dugpgTfK3Ntp0IRANu3hNwGZOsEm+Fb/WEwUDXiExW8kuzFTY59fNwHq0+hj3E83olzpKTHxixffLqCEPWxSvxWUo8bSJH0oc0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB9931.eurprd04.prod.outlook.com (2603:10a6:800:1d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20; Fri, 24 May
 2024 08:48:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c%7]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 08:48:02 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 24 May 2024 16:56:43 +0800
Subject: [PATCH v4 1/6] Documentation: firmware-guide: add NXP i.MX95 SCMI
 documentation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-imx95-bbm-misc-v2-v4-1-dc456995d590@nxp.com>
References: <20240524-imx95-bbm-misc-v2-v4-0-dc456995d590@nxp.com>
In-Reply-To: <20240524-imx95-bbm-misc-v2-v4-0-dc456995d590@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716541024; l=55803;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=fyjiPW7i3Esi/kVBE11tRQYjEUzJGakaE7Z+lYybjKY=;
 b=C8DEQaW9NtZMyOpCIaJeCieOu2aMJK9l333kusoGQ4OHfmkJWBQoD+aPO2WQ5Tbt+R8X8YjDo
 lcc6meUC1WSB2GDByIlU+ng0HOIqAxgfyxRZ+XK+yp33AfqwjILr8Jt
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VI1PR04MB9931:EE_
X-MS-Office365-Filtering-Correlation-Id: a969e505-e86b-4c4c-c4f4-08dc7bce3889
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|376005|7416005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVlSVzFOUFUrU21kRVdtTHNoYUhBM1c0RHg5K1cwTERTUUhoeEkrcEZMVkt0?=
 =?utf-8?B?SEJtSGd2c2V5ZEJkeXlmbERnbzBEcENaZlFNeGljS2ZNNUY2cWYrV2ZPS2Vv?=
 =?utf-8?B?aDlRVjdEb1Jnc3hZUy9PeHQ0WVkwL2V0ZFVmT0ZUQ1FwWlBDMjZCdDZCQS9G?=
 =?utf-8?B?aGpIaE8vK1NwNmVZcVM0YzlteFhhbmR2TWRabmJTQjUxcmtkMlhWSnJ6b1dl?=
 =?utf-8?B?NUhINytrN2NITW9xdkV2KzBCTFR2R2tuM2UvRHR6VUo3MkgwekgzVFlQbkJ6?=
 =?utf-8?B?YlV1TU9YOTVsOTNXeFBuQU5rNXNvSkROVXluMjZNNlR0cFpqeCtEZHBGam16?=
 =?utf-8?B?VmFHSHo0UEE3bHBZdjlTdENwYzh4UUNJakNlcWhST2diR1pSTFVEN3owQzZN?=
 =?utf-8?B?UDFmbTdpZXFDSDVQaDBsbjFaWklIeVdUSGgrbWI1YnpUYmRaVE5VTXlnYWgx?=
 =?utf-8?B?alVMMmJwbW9sYlJCemtNU2ZDMlJ4MCtoUjYyek0zZWJPT1h5ZUVlWmlIc0l5?=
 =?utf-8?B?MDEvbVVQc0FwdE5wUXR0SllWWkZmOTJqeHFYcmswRzZiZ2J4dlYxRmowcmJI?=
 =?utf-8?B?YktrN0hKOElkNGN6MmtETkh5ajRKNnQ2dXd0UW5PV1VDVWx1ZGJDL3V0QWNs?=
 =?utf-8?B?K2djTWFnd0Q2bUR3TFBDWVFMOUpOazZ6WDVTd3g4Qm40Nnlid1pRdjFtM3Js?=
 =?utf-8?B?cStoREpRQkljQ21SOGNMTHBjdTYwaE5nb1NBS29aSVZvZEgza29tQTRHTWZ6?=
 =?utf-8?B?UW5NUUZRbjNuWEQ5YzBLeDF5dSsvRk92TC9hWCtsdFgyTXBZVjlQVnNvcVRV?=
 =?utf-8?B?QjB0bzYwandZdUh2M3lLckhEUTUyY2gzSElVQ0FvY2tBY0JRTWJIclFabWRP?=
 =?utf-8?B?YTNOeGJuV3lWallDMDdwYkxaSEtGZTBKeEVBYTFGUnh3S3BnVFBnc3Nkd0Rv?=
 =?utf-8?B?REVVMHRSYXFUdDBoSGdaUTA2OTR4Rm9mSXZJbDlvdHN0bnAzbnhmdDN1ajJx?=
 =?utf-8?B?MzFra0JiUU1HeXFmRnpUWnpqSm1oSTZGRjBVSWNZK1FKbW5MOU9jVzMrU3J4?=
 =?utf-8?B?ZHBLS0taSkY4OHBWcFU0alJYV280NnRCaCs2UXJkTit6NmROT0pTS3E5TlEz?=
 =?utf-8?B?dkx3N3hlOUVRRkpXaTdRVC9wZHRUSGJUV1ZKSUF2dUdyZ1lEd01GcFpnT3FB?=
 =?utf-8?B?U1MxR09PckhYWEhwYmRBU3c0NW5Ia0pXdGVlKzVHdVdxaUM5UU1MVExRRCtr?=
 =?utf-8?B?djhwdUVld1czdlVpZE1meXRqQlp2WkZjVCtzK0xYTlI3YlNteFEvc2VBVVZo?=
 =?utf-8?B?RHdYamFVT0RQNE92aVJIOWQ2M0VmUFJqMUZxRTNxakluSHdZY3l5UHlnZUI5?=
 =?utf-8?B?TzJETWZqVjNJLzE3d1RtT29DODh1RnFudEFLTUJ4SmRYdU5MalFjd3NZOGQ5?=
 =?utf-8?B?aGNlSEZYVFpGT28xRjlJamFoT1NSQitVUVhEcTRkTWlaMjN0blRlcTh1WjFR?=
 =?utf-8?B?dGY1TGZCZWFxUnU1SzBORFYzRHlXM3l6TW55d0IxYVppT3ZuSUowTUJsdmR3?=
 =?utf-8?B?bWZHTyt4YnZ5NXZoWUdzK09abklpd3pXaWdMVjV1WEZ4d1hQZHpTR0FFTGFF?=
 =?utf-8?B?YmlnSkliaXN3REZMMUk5STZITFE0ODdvYm9OZ201R0xzYWRXcmJFMTJ3STJv?=
 =?utf-8?B?TFZtMmZRQ2hlNXluYlBZczVMVGdzZitVS3huYzdPT05mRDZsQVpab1owWjBv?=
 =?utf-8?B?d2ZEMkNLZVlWc2NhS3dGOU5mSDNIdnZtYWJrOVRoZVlWZ2JTY3FUcDN0V21Y?=
 =?utf-8?Q?S3qFshTisJ42Ef7KnOkZOOjyTgG/TI5Dw/+LI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(7416005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWhxVGFhQy9lL2lDdExoRkFSaXlxL0FobVBhdFVKRE1lZ2dxR25ERVo0Qks2?=
 =?utf-8?B?ZThXanBPNmVtR2JMektVV3lSRWxZNUtHMG9zdkRHeEVBM3FlT1pMMHNPSmoz?=
 =?utf-8?B?U3RVSlh6amJwclNYWDRSTEJva2MxUm0xQkFhSmxTTTg0dUwzL0ZPWFBYMlVO?=
 =?utf-8?B?WEdWVlJzTFI3c3RZT3BJczRHRGJYZytYRFB1K09pNk1sZldWQ01LQkcwRGx3?=
 =?utf-8?B?K1p3SUhUNXZqbVJ0a1FaOG9NSDNJcVNrVVBzUXZIbjRDUmsvV2duc3REYTdD?=
 =?utf-8?B?Z1dXSTBpMlkvNVFqVGpCWFpzZ0NXRW40Q00xbktKTVRNaExmVWV0d1VlaTl5?=
 =?utf-8?B?dFRzTVZSUzJpeUU5a05CTUp3OHFZS3pWaDB0Mm9MUnMvYWxMNE9yQ1owSU0w?=
 =?utf-8?B?MUVGWEU2WGZjcXhkTTJnRlRMamN3c01FYzhmVzNhVGU5OXcrQ3BubGpzY05H?=
 =?utf-8?B?L1RuaXdsSkNJYkg1c01LUkMxZTFRVFBwQWxPb21ScmUrUUExMUg4U2YxRTFi?=
 =?utf-8?B?eDBPclIzYTljcHRPNjV4M1NqVjZ0bFplaFVWZTlPUjZ0ejJFK09LcENwZERT?=
 =?utf-8?B?UnNMMVhnUklLVHhIN2ZoUTVQSkxXYTJXV2pxNUk4WlJMRm5HR2pZVFhteFlU?=
 =?utf-8?B?Qkd4UkpGTzJLN2l0WnV5UHJJQ1piVlVrcjlrZWdNYUdOWFhMc1hhTjJORkVF?=
 =?utf-8?B?TytHYWZyS3dxcWcxczF4UEVtTU5qb2E0M3FSRDRybWZEZEdHUXhrNkltdGtv?=
 =?utf-8?B?cUpZTEZ0Ly9kV2lUN0NodTJ0b3lKdUZsalFsKzdnM0lKOEREUFdYM081bmFY?=
 =?utf-8?B?NllXemVTSlB4ZitCY2hRMlhKUG91d0EwSGhBbnBDNXdDbGJpNjg1am5UaGto?=
 =?utf-8?B?cVJsWUMxYWgydFBjMHQ2VUxYc21wOUpGM2ZzSUlxb2dGTXNEbEhFdG1IY21i?=
 =?utf-8?B?MkIveEtBMllUU09Gb29qTzFKV1ZlNXZWOWNtYytZZ1lkTkpNNmNpKzlOSEJ0?=
 =?utf-8?B?ZlI4TnFERUFaeFpWKzdqSHdwOGlVS3hteUh1TXF6azhPc1NtM0ZKYzBUZE13?=
 =?utf-8?B?eFhiWUg0eVhuMFdmcDJNMlIzY1JoOVQ0cUFMYjFtRlhNQ2M0NllPd014RDlC?=
 =?utf-8?B?Sm5ZV2ZFT2Zsc2pib2x4dHMvUEhHaGFjVVBlZDRjQkRyRmFkUWU5QVJvbzdn?=
 =?utf-8?B?bFRIaTJQcDJYemtFSXcwbWZwamhIWWFMM2RDanduNFhDNHpVUDFQQ29NQVF4?=
 =?utf-8?B?Mkw0d3ZJaURibC9MQWVLc1J5TnAycmxkUXRrSVdFSWIrb3FieE50bzBBTHRQ?=
 =?utf-8?B?ZHJLWFRNZ0NpVnl6YXBWTW9pTEdTSWhaWEsrV0ZqUXRrTjJMQ3pSMDlLWHBz?=
 =?utf-8?B?bVM5Wmg0VE1DdFpJUE1leHhGNjJxRGJTSVQrNzhMRmJOakJNeVRScWpSZWo5?=
 =?utf-8?B?Rkt0RWlyTUFBYnlqa1N6SUh0RnZsR3pPV0wyKzdXR2gvR3QzYmRITXJ4OU9z?=
 =?utf-8?B?YVNNQ1lFOXVISkNhOWxXQWFWYXllc3VuVEltZnN3VExWdlRkMldpWW9taitV?=
 =?utf-8?B?S3VTdWVLVVdSOWhpSmZwQ2F3WTRlNWRvcDB2OEZuL09sUWpIS1U0ZkZlUU9J?=
 =?utf-8?B?SG1wSHptZCtXa3lsYXJQaFJMbnhjQklNYUV3VmRZTDdFNVBCRzZKNmJqSWdT?=
 =?utf-8?B?M3NLYS8rOVI2OGo0a2lqcllTOVBDUWwySWcvK0h1TVNkNXJFUkREN20wTTZD?=
 =?utf-8?B?QzBiNG12RFI5TWdCZkZ5R1BNZjQ0RUVENFJ0SmFQZjVuQUFoSVM0U2g4M0dh?=
 =?utf-8?B?dWhFMHAxYVkxY2JneVhNbDh2Zi8xM3l0OXRSck9mTEZ2QUF2RjVvRTVnckRj?=
 =?utf-8?B?V0xnK2ZCbmhJdjRKN3FxdFI5MUNkWlNQMDIySnk2TDZrUnlSQ0thQVNkb2NU?=
 =?utf-8?B?cE1EaDJMRmhlUzJwWktPaDY4Mmk3c2d6azFZV0MzWWM4RUE2NjF1enA0bWZw?=
 =?utf-8?B?QVQwWEVpdTEvcmRoWWpiVWFXV1JhQjJTVUJIdXlHcS84emRRNDgzQXJXc04y?=
 =?utf-8?B?eXF4bWY0eE5pUXdGZVBpREx3RVZjS0VBRWoxd29EaDJCUURTcU5qT2RjOFh6?=
 =?utf-8?Q?Yv/ola809Fm4VU8J+w3xjK7/X?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a969e505-e86b-4c4c-c4f4-08dc7bce3889
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 08:48:02.5001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2RF5vRBYTO6JKg+YMgEX/8CC3Ll4Nc6BbYBzZxtXecIJIus1EI9ZYo87XEA0MeQmMs4kjIWU41qyip3HX8O+Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9931

From: Peng Fan <peng.fan@nxp.com>

Add NXP i.MX95 System Control Management Interface(SCMI) vendor
extensions protocol documentation.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/firmware-guide/index.rst          |  10 +
 Documentation/firmware-guide/nxp/imx95-scmi.rst | 877 ++++++++++++++++++++++++
 Documentation/firmware-guide/nxp/index.rst      |  10 +
 3 files changed, 897 insertions(+)

diff --git a/Documentation/firmware-guide/index.rst b/Documentation/firmware-guide/index.rst
index 5355784ca0a2..8f66ae31337e 100644
--- a/Documentation/firmware-guide/index.rst
+++ b/Documentation/firmware-guide/index.rst
@@ -4,6 +4,9 @@
 The Linux kernel firmware guide
 ===============================
 
+ACPI subsystem
+==============
+
 This section describes the ACPI subsystem in Linux from firmware perspective.
 
 .. toctree::
@@ -11,3 +14,10 @@ This section describes the ACPI subsystem in Linux from firmware perspective.
 
    acpi/index
 
+NXP firmware
+============
+
+.. toctree::
+   :maxdepth: 1
+
+   nxp/index
diff --git a/Documentation/firmware-guide/nxp/imx95-scmi.rst b/Documentation/firmware-guide/nxp/imx95-scmi.rst
new file mode 100644
index 000000000000..bd87a961e4a5
--- /dev/null
+++ b/Documentation/firmware-guide/nxp/imx95-scmi.rst
@@ -0,0 +1,877 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+===============================================================================
+i.MX95 System Control and Management Interface(SCMI) Vendor Protocols Extension
+===============================================================================
+
+:Copyright: |copy| 2024 NXP
+
+:Author: Peng Fan <peng.fan@nxp.com>
+
+The System Manager (SM) is a low-level system function which runs on a System
+Control Processor (SCP) to support isolation and management of power domains,
+clocks, resets, sensors, pins, etc. on complex application processors. It often
+runs on a Cortex-M processor and provides an abstraction to many of the
+underlying features of the hardware. The primary purpose of the SM is to allow
+isolation between software running on different cores in the SoC. It does this
+by having exclusive access to critical resources such as those controlling
+power, clocks, reset, PMIC, etc. and then providing an RPC interface to those
+clients. This allows the SM to provide access control, arbitration, and
+aggregation policies for those shared critical resources.
+
+This document covers all the information necessary to understand, maintain,
+port, and deploy the SM on supported processors.
+
+The SM implements an interface compliant with the Arm SCMI 3.2 Specification
+with vendor specific extensions.
+
+SCMI_BBM: System Control and Management Interface Driver (BBM)
+==============================================================
+
+This protocol is intended provide access to the battery-backed module. This
+contains persistent storage (GPR), an RTC, and the ON/OFF button. The protocol
+can also provide access to similar functions implemented via external board
+components. The BBM protocol provides functions to:
+
+- Describe the protocol version.
+- Discover implementation attributes.
+- Read/write GPR
+- Discover the RTCs available in the system.
+- Read/write the RTC time in seconds and ticks
+- Set an alarm (per LM) in seconds
+- Get notifications on RTC update, alarm, or rollover.
+- Get notification on ON/OFF button activity.
+
+For most SoC, there is one on-chip RTC (e.g. in BBNSM) and this is RTC ID 0.
+Board code can add additional GPR and RTC.
+
+GPR are not aggregated. The RTC time is also not aggregated. Setting these
+sets for all so normally exclusive access would be granted to one agent for
+each. However, RTC alarms are maintained for each LM and the hardware is
+programmed with the next nearest alarm time. So only one agent in an LM should
+be given access rights to set an RTC alarm.
+
+Commands:
+_________
+
+PROTOCOL_VERSION
+~~~~~~~~~~~~~~~~
+
+message_id: 0x0
+protocol_id: 0x81
+
++---------------+--------------------------------------------------------------+
+|Return values                                                                 |
++---------------+--------------------------------------------------------------+
+|Name           |Description                                                   |
++---------------+--------------------------------------------------------------+
+|int32 status   | See ARM SCMI Specification v3.2 section 4.1.4 for status     |
+|               | code definitions.                                            |
++---------------+--------------------------------------------------------------+
+|uint32 version | For this revision of the specification, this value must be   |
+|               | 0x10000.                                                     |
++---------------+--------------------------------------------------------------+
+
+PROTOCOL_ATTRIBUTES
+~~~~~~~~~~~~~~~~~~~
+
+message_id: 0x1
+protocol_id: 0x81
+
++---------------+--------------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      | See ARM SCMI Specification v3.2 section 4.1.4 for status  |
+|                  | code definitions.                                         |
++------------------+-----------------------------------------------------------+
+|uint32 attributes | Bits[31:8] Number of RTCs.                                |
+|                  | Bits[15:0] Number of persistent storage (GPR) words.      |
++------------------+-----------------------------------------------------------+
+
+PROTOCOL_MESSAGE_ATTRIBUTES
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+message_id: 0x2
+protocol_id: 0x81
+
++---------------+--------------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: in case the message is implemented and available  |
+|                  |to use.                                                    |
+|                  |NOT_FOUND: if the message identified by message_id is      |
+|                  |invalid or not implemented                                 |
++------------------+-----------------------------------------------------------+
+|uint32 attributes |Flags that are associated with a specific function in the  |
+|                  |protocol. For all functions in this protocol, this         |
+|                  |parameter has a value of 0                                 |
++------------------+-----------------------------------------------------------+
+
+BBM_GPR_SET
+~~~~~~~~~~~
+
+message_id: 0x3
+protocol_id: 0x81
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 index      |Index of GPR to write                                      |
++------------------+-----------------------------------------------------------+
+|uint32 value      |32-bit value to write to the GPR                           |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if the GPR was successfully written.              |
+|                  |NOT_FOUND: if the index is not valid.                      |
+|                  |DENIED: if the agent does not have permission to write     |
+|                  |the specified GPR                                          |
++------------------+-----------------------------------------------------------+
+
+BBM_GPR_GET
+~~~~~~~~~~~
+
+message_id: 0x4
+protocol_id: 0x81
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 index      |Index of GPR to read                                       |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if the GPR was successfully written.              |
+|                  |NOT_FOUND: if the index is not valid.                      |
+|                  |DENIED: if the agent does not have permission to write     |
+|                  |the specified GPR.                                         |
++------------------+-----------------------------------------------------------+
+|uint32 value      |32-bit value read from the GPR                             |
++------------------+-----------------------------------------------------------+
+
+BBM_RTC_ATTRIBUTES
+~~~~~~~~~~~~~~~~~~
+
+message_id: 0x5
+protocol_id: 0x81
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 index      |Index of RTC                                               |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: returned the attributes.                          |
+|                  |NOT_FOUND: Index is invalid.                               |
++------------------+-----------------------------------------------------------+
+|uint32 attributes |Bit[31:24] Bit width of RTC seconds.                       |
+|                  |Bit[23:16] Bit width of RTC ticks.                         |
+|                  |Bits[15:0] RTC ticks per second                            |
++------------------+-----------------------------------------------------------+
+|uint8 name[16]    |Null-terminated ASCII string of up to 16 bytes in length   |
+|                  |describing the RTC name                                    |
++------------------+-----------------------------------------------------------+
+
+BBM_RTC_TIME_SET
+~~~~~~~~~~~~~~~~
+
+message_id: 0x6
+protocol_id: 0x81
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 index      |Index of RTC                                               |
++------------------+-----------------------------------------------------------+
+|uint32 flags      |Bits[31:1] Reserved, must be zero.                         |
+|                  |Bit[0] RTC time format:                                    |
+|                  |Set to 1 if the time is in ticks.                          |
+|                  |Set to 0 if the time is in seconds                         |
++------------------+-----------------------------------------------------------+
+|uint32 time[2]    |Lower word: Lower 32 bits of the time in seconds/ticks.    |
+|                  |Upper word: Upper 32 bits of the time in seconds/ticks.    |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: RTC time was successfully set.                    |
+|                  |NOT_FOUND: rtcId pertains to a non-existent RTC.           |
+|                  |INVALID_PARAMETERS: time is not valid                      |
+|                  |(beyond the range of the RTC).                             |
+|                  |DENIED: the agent does not have permission to set the RTC. |
++------------------+-----------------------------------------------------------+
+
+BBM_RTC_TIME_GET
+~~~~~~~~~~~~~~~~
+
+message_id: 0x7
+protocol_id: 0x81
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 index      |Index of RTC                                               |
++------------------+-----------------------------------------------------------+
+|uint32 flags      |Bits[31:1] Reserved, must be zero.                         |
+|                  |Bit[0] RTC time format:                                    |
+|                  |Set to 1 if the time is in ticks.                          |
+|                  |Set to 0 if the time is in seconds                         |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: RTC time was successfully set.                    |
+|                  |NOT_FOUND: rtcId pertains to a non-existent RTC.           |
++------------------+-----------------------------------------------------------+
+|uint32 time[2]    |Lower word: Lower 32 bits of the time in seconds/ticks.    |
+|                  |Upper word: Upper 32 bits of the time in seconds/ticks.    |
++------------------+-----------------------------------------------------------+
+
+BBM_RTC_ALARM_SET
+~~~~~~~~~~~~~~~~~
+
+message_id: 0x8
+protocol_id: 0x81
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 index      |Index of RTC                                               |
++------------------+-----------------------------------------------------------+
+|uint32 flags      |Bits[31:1] Reserved, must be zero.                         |
+|                  |Bit[0] RTC enable flag:                                    |
+|                  |Set to 1 if the RTC alarm should be enabled.               |
+|                  |Set to 0 if the RTC alarm should be disabled               |
++------------------+-----------------------------------------------------------+
+|uint32 time[2]    |Lower word: Lower 32 bits of the time in seconds.          |
+|                  |Upper word: Upper 32 bits of the time in seconds.          |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: RTC time was successfully set.                    |
+|                  |NOT_FOUND: rtcId pertains to a non-existent RTC.           |
+|                  |INVALID_PARAMETERS: time is not valid                      |
+|                  |(beyond the range of the RTC).                             |
+|                  |DENIED: the agent does not have permission to set the RTC  |
+|                  |alarm                                                      |
++------------------+-----------------------------------------------------------+
+
+BBM_BUTTON_GET
+~~~~~~~~~~~~~~
+
+message_id: 0x9
+protocol_id: 0x81
+
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if the button status was read.                    |
+|                  |Other value: ARM SCMI Specification v3.2 section 4.1.4.    |
++------------------+-----------------------------------------------------------+
+|uint32 state      |State of the ON/OFF button                                 |
++------------------+-----------------------------------------------------------+
+
+BBM_RTC_NOTIFY
+~~~~~~~~~~~~~~
+
+message_id: 0xA
+protocol_id: 0x81
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 index      |Index of RTC                                               |
++------------------+-----------------------------------------------------------+
+|uint32 flags      |Notification flags                                         |
+|                  |Bits[31:3] Reserved, must be zero.                         |
+|                  |Bit[2] Update enable:                                      |
+|                  |Set to 1 to send notification.                             |
+|                  |Set to 0 if no notification.                               |
+|                  |Bit[1] Rollover enable:                                    |
+|                  |Set to 1 to send notification.                             |
+|                  |Set to 0 if no notification.                               |
+|                  |Bit[0] Alarm enable:                                       |
+|                  |Set to 1 to send notification.                             |
+|                  |Set to 0 if no notification                                |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: notification configuration was successfully       |
+|                  |updated.                                                   |
+|                  |NOT_FOUND: rtcId pertains to a non-existent RTC.           |
+|                  |DENIED: the agent does not have permission to request RTC  |
+|                  |notifications.                                             |
++------------------+-----------------------------------------------------------+
+
+BBM_BUTTON_NOTIFY
+~~~~~~~~~~~~~~~~~
+
+message_id: 0xB
+protocol_id: 0x81
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 flags      |Notification flags                                         |
+|                  |Bits[31:1] Reserved, must be zero.                         |
+|                  |Bit[0] Enable button:                                      |
+|                  |Set to 1 to send notification.                             |
+|                  |Set to 0 if no notification                                |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: notification configuration was successfully       |
+|                  |updated.                                                   |
+|                  |DENIED: the agent does not have permission to request      |
+|                  |button notifications.                                      |
++------------------+-----------------------------------------------------------+
+
+NEGOTIATE_PROTOCOL_VERSION
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+message_id: 0x10
+protocol_id: 0x81
+
++--------------------+---------------------------------------------------------+
+|Parameters                                                                    |
++--------------------+---------------------------------------------------------+
+|Name                |Description                                              |
++--------------------+---------------------------------------------------------+
+|uint32 version      |The negotiated protocol version the agent intends to use |
++--------------------+---------------------------------------------------------+
+|Return values                                                                 |
++--------------------+---------------------------------------------------------+
+|Name                |Description                                              |
++--------------------+---------------------------------------------------------+
+|int32 status        |SUCCESS: if the negotiated protocol version is supported |
+|                    |by the platform. All commands, responses, and            |
+|                    |notifications post successful return of this command must|
+|                    |comply with the negotiated version.                      |
+|                    |NOT_SUPPORTED: if the protocol version is not supported. |
++--------------------+---------------------------------------------------------+
+
+Notifications
+_____________
+
+BBM_RTC_EVENT
+~~~~~~~~~~~~~
+
+message_id: 0x0
+protocol_id: 0x81
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 flags      |RTC events:                                                |
+|                  |Bits[31:2] Reserved, must be zero.                         |
+|                  |Bit[1] RTC rollover notification:                          |
+|                  |1 RTC rollover detected.                                   |
+|                  |0 no RTC rollover detected.                                |
+|                  |Bit[0] RTC alarm notification:                             |
+|                  |1 RTC alarm generated.                                     |
+|                  |0 no RTC alarm generated.                                  |
++------------------+-----------------------------------------------------------+
+
+BBM_BUTTON_EVENT
+~~~~~~~~~~~~~~~~
+
+message_id: 0x1
+protocol_id: 0x81
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 flags      |RTC events:                                                |
++------------------+-----------------------------------------------------------+
+|                  |Button events:                                             |
+|                  |Bits[31:1] Reserved, must be zero.                         |
+|                  |Bit[0] Button notification:                                |
+|                  |1 button change detected.                                  |
+|                  |0 no button change detected.                               |
++------------------+-----------------------------------------------------------+
+
+SCMI_MISC: System Control and Management Interface Driver (MISC)
+================================================================
+
+Provides misc. functions. This includes controls that are misc. settings/actions
+that must be exposed from the SM to agents. They are device specific and are
+usually define to access bit fields in various mix block control modules,
+IOMUX_GPR, and other GPR/CSR owned by the SM. This protocol supports the
+following functions:
+
+- Describe the protocol version.
+- Discover implementation attributes.
+- Set/Get a control.
+- Initiate an action on a control.
+- Obtain platform (i.e. SM) build information.
+- Obtain ROM passover data.
+- Read boot/shutdown/reset information for the LM or the system.
+
+Commands:
+_________
+
+PROTOCOL_VERSION
+~~~~~~~~~~~~~~~~
+
+message_id: 0x0
+protocol_id: 0x84
+
++---------------+--------------------------------------------------------------+
+|Return values                                                                 |
++---------------+--------------------------------------------------------------+
+|Name           |Description                                                   |
++---------------+--------------------------------------------------------------+
+|int32 status   | See ARM SCMI Specification v3.2 section 4.1.4 for status     |
+|               | code definitions.                                            |
++---------------+--------------------------------------------------------------+
+|uint32 version | For this revision of the specification, this value must be   |
+|               | 0x10000.                                                     |
++---------------+--------------------------------------------------------------+
+
+PROTOCOL_ATTRIBUTES
+~~~~~~~~~~~~~~~~~~~
+
+message_id: 0x1
+protocol_id: 0x84
+
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |See ARM SCMI Specification v3.2 section 4.1.4 for status   |
+|                  |code definitions.                                          |
++------------------+-----------------------------------------------------------+
+|uint32 attributes |Protocol attributes:                                       |
+|                  |Bits[31:24] Reserved, must be zero.                        |
+|                  |Bits[23:16] Number of reasons.                             |
+|                  |Bits[15:0] Number of controls                              |
++------------------+-----------------------------------------------------------+
+
+PROTOCOL_MESSAGE_ATTRIBUTES
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+message_id: 0x2
+protocol_id: 0x84
+
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: in case the message is implemented and available  |
+|                  |to use.                                                    |
+|                  |NOT_FOUND: if the message identified by message_id is      |
+|                  |invalid or not implemented                                 |
++------------------+-----------------------------------------------------------+
+|uint32 attributes |Flags that are associated with a specific function in the  |
+|                  |protocol. For all functions in this protocol, this         |
+|                  |parameter has a value of 0                                 |
++------------------+-----------------------------------------------------------+
+
+MISC_CONTROL_SET
+~~~~~~~~~~~~~~~~
+
+message_id: 0x3
+protocol_id: 0x84
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 index      |Index of the control                                       |
++------------------+-----------------------------------------------------------+
+|uint32 num        |Size of the value data in words                            |
++------------------+-----------------------------------------------------------+
+|uint32 val[8]     |value data array                                           |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if the control was set successfully.              |
+|                  |NOT_FOUND: if the index is not valid.                      |
+|                  |DENIED: if the agent does not have permission to set the   |
+|                  |control                                                    |
++------------------+-----------------------------------------------------------+
+
+MISC_CONTROL_GET
+~~~~~~~~~~~~~~~~
+
+message_id: 0x4
+protocol_id: 0x84
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 index      |Index of the control                                       |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if the control was set successfully.              |
+|                  |NOT_FOUND: if the index is not valid.                      |
+|                  |DENIED: if the agent does not have permission to get the   |
+|                  |control                                                    |
++------------------+-----------------------------------------------------------+
+|uint32 num        |Size of the return data in words                           |
++------------------+-----------------------------------------------------------+
+|uint32 val[8]     |value data array                                           |
++------------------+-----------------------------------------------------------+
+
+MISC_CONTROL_ACTION
+~~~~~~~~~~~~~~~~~~~
+
+message_id: 0x5
+protocol_id: 0x84
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 index      |Index of the control                                       |
++------------------+-----------------------------------------------------------+
+|uint32 action	   |Action for the control                                     |
++------------------+-----------------------------------------------------------+
+|uint32 numarg	   |Size of the argument data                                  |
++------------------+-----------------------------------------------------------+
+|uint32 arg[8]	   |Argument data array                                        |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if the action was set successfully.               |
+|                  |NOT_FOUND: if the index is not valid.                      |
+|                  |DENIED: if the agent does not have permission to get the   |
+|                  |control                                                    |
++------------------+-----------------------------------------------------------+
+|uint32 num        |Size of the return data in words                           |
++------------------+-----------------------------------------------------------+
+|uint32 val[8]     |value data array                                           |
++------------------+-----------------------------------------------------------+
+
+MISC_DISCOVER_BUILD_INFO
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+message_id: 0x6
+protocol_id: 0x84
+
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if the build info was got successfully.           |
+|                  |NOT_SUPPORTED: if the data is not available.               |
++------------------+-----------------------------------------------------------+
+|uint32 buildnum   |Build number                                               |
++------------------+-----------------------------------------------------------+
+|uint32 buildcommit|Most significant 32 bits of the git commit hash            |
++------------------+-----------------------------------------------------------+
+|uint8 date[16]    |Date of build. Null terminated ASCII string of up to 16    |
+|                  |bytes in length                                            |
++------------------+-----------------------------------------------------------+
+|uint8 time[16]    |Time of build. Null terminated ASCII string of up to 16    |
+|                  |bytes in length                                            |
++------------------+-----------------------------------------------------------+
+
+MISC_ROM_PASSOVER_GET
+~~~~~~~~~~~~~~~~~~~~~
+
+This function is used to obtain the ROM passover data. The returned block of
+words is structured as defined in the ROM passover section in the SoC RM.
+
+message_id: 0x7
+protocol_id: 0x84
+
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if the data was got successfully.                 |
+|                  |NOT_SUPPORTED: if the data is not available.               |
++------------------+-----------------------------------------------------------+
+|uint32 num        |Size of the passover data in words                         |
++------------------+-----------------------------------------------------------+
+|uint32_t data[8]  |Passover data array                                        |
++------------------+-----------------------------------------------------------+
+
+MISC_CONTROL_NOTIFY
+~~~~~~~~~~~~~~~~~~~
+
+message_id: 0x8
+protocol_id: 0x84
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 index      |Index of control                                           |
++------------------+-----------------------------------------------------------+
+|uint32 flags      |Notification flags, varies by control                      |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: notification configuration was successfully       |
+|                  |updated.                                                   |
+|                  |NOT_FOUND: control id not exists.                          |
+|                  |INVALID_PARAMETERS: if the input attributes flag specifies |
+|                  |unsupported or invalid configurations..                    |
+|                  |DENIED: if the calling agent is not permitted to request   |
+|                  |the notification.                                          |
++------------------+-----------------------------------------------------------+
+
+MISC_REASON_ATTRIBUTES
+~~~~~~~~~~~~~~~~~~~~~~
+
+message_id: 0x9
+protocol_id: 0x84
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 reasonid   |Identifier for the reason                                  |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if valid reason attributes are returned           |
+|                  |NOT_FOUND: if reasonId pertains to a non-existent reason.  |
++------------------+-----------------------------------------------------------+
+|uint32 attributes |Reason attributes. This parameter has the following        |
+|                  |format: Bits[31:0] Reserved, must be zero                  |
+|                  |Bits[15:0] Number of persistent storage (GPR) words.       |
++------------------+-----------------------------------------------------------+
+|uint8 name[16]    |Null-terminated ASCII string of up to 16 bytes in length   |
+|                  |describing the reason                                      |
++------------------+-----------------------------------------------------------+
+
+MISC_RESET_REASON
+~~~~~~~~~~~~~~~~~
+
+message_id: 0xA
+protocol_id: 0x84
+
++--------------------+---------------------------------------------------------+
+|Parameters                                                                    |
++--------------------+---------------------------------------------------------+
+|Name                |Description                                              |
++--------------------+---------------------------------------------------------+
+|uint32 flags        |Reason flags. This parameter has the following format:   |
+|                    |Bits[31:1] Reserved, must be zero.                       |
+|                    |Bit[0] System:                                           |
+|                    |Set to 1 to return the system reason.                    |
+|                    |Set to 0 to return the LM reason                         |
++--------------------+---------------------------------------------------------+
+|Return values                                                                 |
++--------------------+---------------------------------------------------------+
+|Name                |Description                                              |
++--------------------+---------------------------------------------------------+
+|int32 status        |SUCCESS: reset reason return                             |
++--------------------+---------------------------------------------------------+
+|uint32 bootflags    |Boot reason flags. This parameter has the format:        |
+|                    |Bits[31] Valid.                                          |
+|                    |Set to 1 if the entire reason is valid.                  |
+|                    |Set to 0 if the entire reason is not valid.              |
+|                    |Bits[30:29] Reserved, must be zero.                      |
+|                    |Bit[28] Valid origin:                                    |
+|                    |Set to 1 if the origin field is valid.                   |
+|                    |Set to 0 if the origin field is not valid.               |
+|                    |Bits[27:24] Origin.                                      |
+|                    |Bit[23] Valid err ID:                                    |
+|                    |Set to 1 if the error ID field is valid.                 |
+|                    |Set to 0 if the error ID field is not valid.             |
+|                    |Bits[22:8] Error ID.                                     |
+|                    |Bit[7:0] Reason                                          |
++--------------------+---------------------------------------------------------+
+|uint32 shutdownflags|Shutdown reason flags. This parameter has the format:    |
+|                    |Bits[31] Valid.                                          |
+|                    |Set to 1 if the entire reason is valid.                  |
+|                    |Set to 0 if the entire reason is not valid.              |
+|                    |Bits[30:29] Number of valid extended info words.         |
+|                    |Bit[28] Valid origin:                                    |
+|                    |Set to 1 if the origin field is valid.                   |
+|                    |Set to 0 if the origin field is not valid.               |
+|                    |Bits[27:24] Origin.                                      |
+|                    |Bit[23] Valid err ID:                                    |
+|                    |Set to 1 if the error ID field is valid.                 |
+|                    |Set to 0 if the error ID field is not valid.             |
+|                    |Bits[22:8] Error ID.                                     |
+|                    |Bit[7:0] Reason                                          |
++--------------------+---------------------------------------------------------+
+|uint32 extinfo[8]   |Array of extended info words                             |
++--------------------+---------------------------------------------------------+
+
+MISC_SI_INFO
+~~~~~~~~~~~~
+
+message_id: 0xB
+protocol_id: 0x84
+
++--------------------+---------------------------------------------------------+
+|Return values                                                                 |
++--------------------+---------------------------------------------------------+
+|Name                |Description                                              |
++--------------------+---------------------------------------------------------+
+|int32 status        |SUCCESS: silicon info return                             |
++--------------------+---------------------------------------------------------+
+|uint32 deviceid     |Silicon specific device ID                               |
++--------------------+---------------------------------------------------------+
+|uint32 sirev        |Silicon specific revision                                |
++--------------------+---------------------------------------------------------+
+|uint32 partnum      |Silicon specific part number                             |
++--------------------+---------------------------------------------------------+
+|uint8 siname[16]    |Silicon name/revision. Null terminated ASCII string of up|
+|                    |to 16 bytes in length                                    |
++--------------------+---------------------------------------------------------+
+
+MISC_CFG_INFO
+~~~~~~~~~~~~~
+
+message_id: 0xC
+protocol_id: 0x84
+
++--------------------+---------------------------------------------------------+
+|Return values                                                                 |
++--------------------+---------------------------------------------------------+
+|Name                |Description                                              |
++--------------------+---------------------------------------------------------+
+|int32 status        |SUCCESS: config name return                              |
+|                    |NOT_SUPPORTED: name not available                        |
++--------------------+---------------------------------------------------------+
+|uint32 msel         |Mode selector value                                      |
++--------------------+---------------------------------------------------------+
+|uint8 cfgname[16]   |config file basename. Null terminated ASCII string of up |
+|                    |to 16 bytes in length                                    |
++--------------------+---------------------------------------------------------+
+
+MISC_SYSLOG
+~~~~~~~~~~~
+
+message_id: 0xD
+protocol_id: 0x84
+
++--------------------+---------------------------------------------------------+
+|Parameters                                                                    |
++--------------------+---------------------------------------------------------+
+|Name                |Description                                              |
++--------------------+---------------------------------------------------------+
+|uint32 flags        |Device specific flags that might impact the data returned|
+|                    |or clearing of the data                                  |
++--------------------+---------------------------------------------------------+
+|uint32 logindex     |Index to the first log word. Will be the first element in|
+|                    |the return array                                         |
++--------------------+---------------------------------------------------------+
+|Return values                                                                 |
++--------------------+---------------------------------------------------------+
+|Name                |Description                                              |
++--------------------+---------------------------------------------------------+
+|int32 status        |SUCCESS: reset reason return                             |
++--------------------+---------------------------------------------------------+
+|uint32 numLogflags  |Descriptor for the log data returned by this call.       |
+|                    |Bits[31:20] Number of remaining log words.               |
+|                    |Bits[15:12] Reserved, must be zero.                      |
+|                    |Bits[11:0] Number of log words that are returned by this |
+|                    |call                                                     |
++--------------------+---------------------------------------------------------+
+|uint32 syslog[16]   |Log data array                                           |
++--------------------+---------------------------------------------------------+
+
+NEGOTIATE_PROTOCOL_VERSION
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+message_id: 0x10
+protocol_id: 0x84
+
++--------------------+---------------------------------------------------------+
+|Parameters                                                                    |
++--------------------+---------------------------------------------------------+
+|Name                |Description                                              |
++--------------------+---------------------------------------------------------+
+|uint32 version      |The negotiated protocol version the agent intends to use |
++--------------------+---------------------------------------------------------+
+|Return values                                                                 |
++--------------------+---------------------------------------------------------+
+|Name                |Description                                              |
++--------------------+---------------------------------------------------------+
+|int32 status        |SUCCESS: if the negotiated protocol version is supported |
+|                    |by the platform. All commands, responses, and            |
+|                    |notifications post successful return of this command must|
+|                    |comply with the negotiated version.                      |
+|                    |NOT_SUPPORTED: if the protocol version is not supported. |
++--------------------+---------------------------------------------------------+
+
+Notifications
+_____________
+
+MISC_CONTROL_EVENT
+~~~~~~~~~~~~~~~~~~
+
+message_id: 0x0
+protocol_id: 0x81
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 ctrlid     |Identifier for the control that caused the event.          |
++------------------+-----------------------------------------------------------+
+|uint32 flags      |Event flags, varies by control.                            |
++------------------+-----------------------------------------------------------+
+
diff --git a/Documentation/firmware-guide/nxp/index.rst b/Documentation/firmware-guide/nxp/index.rst
new file mode 100644
index 000000000000..b38c980a50c6
--- /dev/null
+++ b/Documentation/firmware-guide/nxp/index.rst
@@ -0,0 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================
+NXP Firmware Support
+====================
+
+.. toctree::
+   :maxdepth: 1
+
+   imx95-scmi

-- 
2.37.1


