Return-Path: <linux-kernel+bounces-184165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE2C8CA374
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9730A280DDC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 20:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2F5139CE3;
	Mon, 20 May 2024 20:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="epCYUOxC"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2074.outbound.protection.outlook.com [40.107.7.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5019B138486;
	Mon, 20 May 2024 20:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716237712; cv=fail; b=ftQcl4mciH9ZS3wM8WiRNtAiGO0nzzRyh8aTS/orplZkVOpjlrvxf2GTbuBeI8xf8TrKQC7Xa6g/z5HD+oLVmMxCiRRqOjSx52gyTaMduLV8RgiEl/ILm5p+5580Qz05KpOAdC6GMdgWas3qsBpNC3dCLj80bi7MUkh0rSx+t9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716237712; c=relaxed/simple;
	bh=eF4oZGfL7KWCv8R3An36NaJsIcLTkgaU3CzCb9NVdRQ=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=BoOAZXIAjBSjHvLt7FiNCo6/lSWgvSCKKvp7N6pProqUkrZseok0EJb1cJF/XsLN4dgAI7OidOneiXbHxNk6mwmI8OMZsQYYuOnGFuFE+D7xI/iHLz6KpRwg69sZs2ieTAenqbAM6Wv41ZvI3C5ivaBEg19+WvIPm9Ja+iXSxz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=epCYUOxC; arc=fail smtp.client-ip=40.107.7.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQLYmvkh9Is3evB8XvklcxRnwSBROiobOy3t91qawiXFubM+/Z1sbxw1dDM/M/6N/WC/2Bc8fOUzBFhp8mUTHLQGf4r1dYTHwnhr5LOz4GE22UeKrrywx8sQL8xhW0MzP/pj9gwwahXay+nqN2zpiNtCGOuxu5x42GaUHbUg06VWOo74HlCt94+87Y+NeLD3gFLXmH2CftdwxvSdeUW6SwogjwH7c5IyIjZDye2NeKt8dUGl8pZ+yH4WphZtOdirI5ZivkAl+gRF0rFiEBS2WqSG1hWMAKZeNM7Zq2Nx4II/SsUiStntZg4EBKWa8B7KI+n/0fbkm1cahQtHrLykCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nL85ptwPlFToEWKmbpES96bk5PjxHfV8y2Ydlv4Vhd8=;
 b=c4Z5yI9+HF7wGmP6x6+DDjrPa2r4BHBFEAzYIcPFgZul8tdWqiYKnFqiIdMonqtyEbcw53XheslVkSoereFoCzs/4Bgh21zrnLXnMXoIES6aZXdeI433WU8Gl9eFUkpO24pormuthwOc15bfkPme/5/hq9o8i6FZCXlOjwv4TbQgs1RkAk8MBYcbA7v1w375+3K0WfqlX9X4MpLvFS5Iu+pE/9TvslTMNtByWWlmF/0Yv+Lz1kyT3/kPOjxKMHxGkABXtySi7HYH8Ztwv8r+IlmYRfAU1I/4mEhoR66QJEFzE90COSm3KwnAZQxIkjokp8FirHUgp3WaHwTGnOUQAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nL85ptwPlFToEWKmbpES96bk5PjxHfV8y2Ydlv4Vhd8=;
 b=epCYUOxC/wJ4zwd+tIpPtNtEmXs7UlAMP8ptw6SC/7ce2FxeAh6onI1pa8oVTGUtKmOlXTY8IGSmyqrlSwaBzDhwJnkps0IWoQitOnJ0fgcQEPUdCN46PEKKQAW2gW9iV2FOpHj6OHXyCpHgClpWKRc+ipxo9P4h6ZMXeAxYgKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7385.eurprd04.prod.outlook.com (2603:10a6:102:89::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 20:41:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7587.035; Mon, 20 May 2024
 20:41:47 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/2] arm64: dts: freescale: ls1028a: cleanup some DTB_CHECK
 Warning
Date: Mon, 20 May 2024 16:41:30 -0400
Message-Id: <20240520-ls_warning-v1-0-6851155356c6@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHu1S2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUyMD3Zzi+PLEorzMvHTdlEQLM2Nj08RUM1NDJaCGgqLUtMwKsGHRsbW
 1AERdoZpcAAAA
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716237705; l=550;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=eF4oZGfL7KWCv8R3An36NaJsIcLTkgaU3CzCb9NVdRQ=;
 b=oBAwZ2Oq8aWxQkMkiRNFSNiSr1587ujDDPDOoiGd5rli9RhXKl6rl9BehialaPP9c9xqrRH/t
 shHlZUvF+ygAFrZ8d6dr3mwGfa8Y+qWcifmUD0kY5Zec3fngRA5JECq
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0162.namprd03.prod.outlook.com
 (2603:10b6:a03:338::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7385:EE_
X-MS-Office365-Filtering-Correlation-Id: e36c93f8-d167-4d2f-ce20-08dc790d44a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mm52amxFZ0dZNWN0UXRXU0I0YnpnSk1lNkNiSTVpSTcvTnBvMHdDNFFoQWU2?=
 =?utf-8?B?WWs4RjcvOTM0UW9qRThzVEhadXdweGd0anhoNlEvVDNneUd2K3dXQkx5WGJV?=
 =?utf-8?B?VFF0M3RubUUvaGRUMm1BdittMWRoQ0RndDBLem5LUFE5TnlUaUFmdXkxdzkr?=
 =?utf-8?B?bEJvNUpESFM0a0poT25EVFNWUXFnSUo0b1QyZmh4L2c4QS9MQWowNEZ1WGdU?=
 =?utf-8?B?YjgrS3lGMGpmZTBPWllnMWh0M3BmUnlPbTZ6N2YvK25UZEdCUlc2OEx4QUFt?=
 =?utf-8?B?dVNvdCtEZVJyY1V5eUplc3RFemZlVldKck9ITGlRU2VUcTkvSDg1a0tvdnFW?=
 =?utf-8?B?VXJISnIydVhIQzBvSWR2T2w3bUZSS0tFWWxXRnBHRDQvWExiUVhzbnZLbXli?=
 =?utf-8?B?bmRKTWhVN2dBV2hCQWtGWjlvN2JkQW1sbzNsNnVweWNDR3RFY3V1MTh5UGF1?=
 =?utf-8?B?cEVxUWxscGlPbHZqb2RxYnEvWDRTamhGQkRJcithSlc5ZUg3SFlINi9UK1F1?=
 =?utf-8?B?VTRrSVZVZ0pCOWZZNmpkdytIUzFVaDBQTkltTEJlbVBQMHdnVC9XMEo0UnNV?=
 =?utf-8?B?aTRhV0FxSndIRlE5UHRXUHYrK3NqOHpIWkNNSjJabWU3aUpQOTBUSHVOL2JF?=
 =?utf-8?B?cmNrQ1Q5Sy96TGlGSTI5UGlTcUpRaDdqS3BOOWQ0RlRtYXlFV0dWZ0s3Nyt0?=
 =?utf-8?B?bnM4THdQYWJkeTFuaStPUXlsMXR0OCtRVmtxKzFFTDI4ak9qYU9mY3VUeTFy?=
 =?utf-8?B?WXRsRzhYV3RQVFBBd1JRcXJkQ1ZyaURoVEZPdjVHZTVaQ0lPbVhFQ1dQSVZw?=
 =?utf-8?B?eWFDV21CeDlQNFRaRy92ZEpNS2c2Z3VocFRqRzYrVktEbWtmZHNTc0Y5Vlk4?=
 =?utf-8?B?dk43OE9jQmZKMkthbGs5djVjdGo0a3NGRVo0bHFmWEphRWg4UkY5OGpuazlQ?=
 =?utf-8?B?aXJWYVJlcmZWN21SRmhwR1N2M2E0cmw2YmNmWVVrU1lVWm8vRlBXbE1WM2g5?=
 =?utf-8?B?ejVnTCtaWFBmZU8yVEtRcEdTODIwOTY5NlZUNzJUK2l1aGFKaU1GODhsWnRv?=
 =?utf-8?B?VjdnNzM0eFlZNXRFL2Y0Ny9maGlNU0JtamFwaWxGMEJxTzk0bkxGQlkrb1Nq?=
 =?utf-8?B?UXVLWThQSXJjemZibnVSSW1GbUlUYU5WbDV2MDV4djZBNlFXRVNtSG92bHNE?=
 =?utf-8?B?M3hNOGI5VGxBcm1RSWg4TTRPMnB1cUlVV2Y2MFF3TW40blNHd1AxdFFMQzc5?=
 =?utf-8?B?MlgrNG02QW5oVTkrN05yRHk4WGhmd3ZMWkRhZ3pBYTN6NzdZbnJxTDNFNGdU?=
 =?utf-8?B?a1l3eHpjbFZMQTRDMHRRSG5BTWNMOUY1SjdBZDd4bUwvSVpMU3JzdE5WdFRJ?=
 =?utf-8?B?ZldQa2h5bjFVSGk5OVgzMVhKS1NFbWtaOVFtaGhkUWZ3dU5FTWRpZ3RIWDlF?=
 =?utf-8?B?KzhqTDROdkM4a2dxUlV3M2cxY3hBbGxFNVlYZzBrNDJNbXpOR2lLcE9VR1ZQ?=
 =?utf-8?B?UzJxcDBJTXJ6QjI5dmxHU1ZGL2k1SVNhSmljVU9peVN5R2xscmNyZEIySFEy?=
 =?utf-8?B?d0JnSkY4cmFJeEEwcXNSYWZ1MXI2R01HYTA2bjkzMVdmMXFZZWxWaFg4OHJZ?=
 =?utf-8?B?bUEvN2VJQ0RMVWYzS0g0b1E2YmlYNERyYjE4SHlBV0Q5Y2VSTWdHelBzNERq?=
 =?utf-8?B?clZhb0V5YVpmK0xDdTRqaVg3U3ZUTG1vTVlTTnRzZFdUa3pEZ3loUTAxMGdO?=
 =?utf-8?B?RDVscmpiZnVDWndxTHdDL1VMUjhCeHVleTgvaTBVbldyWTh2b08vSXlCcjlo?=
 =?utf-8?B?ZnJqN0t5MjlHQVZ4TFlPZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amEwd0c5MDhrdnBweU5TVXJPUm1WVVRaWjNjV3FVWGZFZWpwbVh1aGpmdXdo?=
 =?utf-8?B?MFVoeUNWR2RtNEsycHNmcTZlMEVXZUhFTTJQUnB4ZVd3aDR3dVE2M3pUQWF2?=
 =?utf-8?B?OHEvZ3lCR1pjeUZlK25hclV6QlFQbUlnQ0I2ZUNibVBJdEkxSHNLWE9CRzkx?=
 =?utf-8?B?UXhVcjJ0KzIzM0FET01SazIvRmEyQmZWUm44TDVTR09rUGJDQURxUXNNajZ4?=
 =?utf-8?B?cnpOWFpxS3lBT3VNaHdRY2VjK3B0UDhSN1hOMjJkL1dXVWlRZXVpMEV0d3dB?=
 =?utf-8?B?MTF5Z2dVTU5VbHZqQkdtN1MzMnJZR3J2ak4wcVZYeDdhclBmNGJPNlBEWFZV?=
 =?utf-8?B?S09GWm5RclNub0o0aG5yMmtUUTk1OFNaUEttMHBpL0RnNVFENHgzWllnNVEw?=
 =?utf-8?B?a1RZWHFLS3hpMHhLUFNBUmhod2xNZVZlbUJibUNxTnB6ZlV1RXc5YnRTdlYz?=
 =?utf-8?B?UzRyRFBBWEdHYXovUEIzQXJ2TWJqZFgvczBaQmE5TVhPN0lJUmFCWERaWkVG?=
 =?utf-8?B?OFdKWktIdkFlTXI0b2w4Y3k1d2o4QkFXRUt0dmRSNHJzQWR6RFFjZ1M2T2dS?=
 =?utf-8?B?enBoMGVKUlNqa0lUOXhSeThxMi9PSXlabzlYYit2dUxpcDZidUk2NmVucERn?=
 =?utf-8?B?dWsvcm1WUTQvQys1RVR1bk54QXp5blRBV2tQWFEyR3lNSUV3ampuRU52dk9O?=
 =?utf-8?B?UW5zVk5BdUVuM0Z0c3JMTnN1eUxJc1I2SGZPQ3NrS1dLZk0rcjhmb054S1F4?=
 =?utf-8?B?dmFaYjk5MTUzSWNONlgxYnZDb1duUk52MCtFczFZNThQTFdNNXNtQ3FCYVZT?=
 =?utf-8?B?T01xT0thczVnZGsyZFRXaWhUYTd0TkxIdDUxQzAyMFJYL1pKRTN1dDJGVy9J?=
 =?utf-8?B?YlQ2SEJvWXBQb01oUDdyd01xN1J0dFlmREsyYUplQTJhY2lpRDBoQTRtNkZZ?=
 =?utf-8?B?Ukg1Rm1pRzJJLzE1c1RJOG1LY2RWbU9ibmRHUGwzRk5iZVMzSHhXVFZ1VE54?=
 =?utf-8?B?UmoxU3pBL2ZTRDg2VUtCT3NEL2t3V0dVb1E1QkJVejR5cVhEckNCclNidkcy?=
 =?utf-8?B?VlRjeHk5bHkyUWdodTFtangvUjJuY3dESG1RTGs4VzZXdVZvRi85eWVCVVdz?=
 =?utf-8?B?d1Q3WExyUGd4Z09OczNCZVRTZElSb0pjNzdtNmt3NU8xVDZKNGhRVE1tcUZH?=
 =?utf-8?B?WU4rUXh6dXZ4ZUppUFBrS0UxWHphUUFhckxvNytxVXZpTG43OVo5alluYUh1?=
 =?utf-8?B?SmxhY0lYKzlFNXc5Z3c4NnRrRDBnVnJSZmZSbHFVbzlUYUx3TWZXMWFxRnJJ?=
 =?utf-8?B?Ly9iajF6azNYdHZsbWlOMVJ2U2M3UWVRRTAzaHQ3NWJUV3Rka0hCSy9mRlh2?=
 =?utf-8?B?ZWxlTjFuQkRIRm5ielFXODROM01wdFQ5VVJaYkNVMWpyem01ZVpDU01IcDJw?=
 =?utf-8?B?eXN5UjhpTEhUVk1YUkpLUHphYm5tMmRBMjd3V1EwZzVBMzZUc2VGcVozSy9z?=
 =?utf-8?B?MUszWnNhdWY3cDRYa2tVTVR1MlBCUTQ5MUErZ1VENU5jL0M0dkJpQjFyQUNt?=
 =?utf-8?B?UnZuVkhQbXZWdVZpYXVDdmd1UXJHRGRNcG96cTJRdU0wODM3Wkd4VWxkZmpZ?=
 =?utf-8?B?VEZ1ZUQ1eUFiS0RlZ1g1K2JjSm9EbjNYa0R2STZpdTB3NlM2Vk9oUVhoZm40?=
 =?utf-8?B?dWtpQWpTZGZLdHBzK1dhSEgrZEgvd0todlc3T3E1aWE1WGlxQ1ljQy92ak1F?=
 =?utf-8?B?TUlnZ0cvQjVRdkpCMHNHTjhpdU52ZUVmbC8rcXptMUFmK0U4ZTV0ZkF6QTBy?=
 =?utf-8?B?OFYxVW1qNDl5cXI0WFZ0aE1SbUVLSy9BS25OSjcyb2NDN1VtektobDVnVktk?=
 =?utf-8?B?dk9KR09Vb0NsdWJjem1LN0F1ZTFZVk9MUndjQmVrWmpSODcrUXZCTVV6REIv?=
 =?utf-8?B?SkFUSzF2VURTT0VSdmJISFFMTkRJcGtDaDM4MGJLY2MvOTVhQWwrRkZONmh4?=
 =?utf-8?B?TUFNU2syUWhmbmJRdHJtQVYvWHV2eGFMZjNZMExZb2c0US9kdS8raXZtRm5J?=
 =?utf-8?B?eHVZR1I0STBRUjhlRmpGY29QQVRuQ3hHRlJ0UUl1aWhtRWRXUnJoSW9TQ2Fm?=
 =?utf-8?Q?ZnC5TKPNejHY9xEPTkX+dr8oZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e36c93f8-d167-4d2f-ce20-08dc790d44a5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 20:41:47.4835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R3Uw9tpOevL+knHT3OfxGfglBR2IfAM2lBO9N3fdWXd/djyZ/BlPW7UQn/Pi+Z7kTTQKEbDB40fc6bCBvZGoag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7385

Clean up some ls1028a dtb check warning

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (2):
      arm64: dts: freescale: ls1028a: Remove undocumented 'fsl,ls-pcie-ep'
      arm64: dts: freescale: ls1028a: Reorder sai dma-names to fix warning

 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 40 +++++++++++++-------------
 1 file changed, 20 insertions(+), 20 deletions(-)
---
base-commit: 50a93f763bb0c07c2093cf8ac89b29f29b464171
change-id: 20240520-ls_warning-da86335ae651

Best regards,
---
Frank Li <Frank.Li@nxp.com>


