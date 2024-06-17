Return-Path: <linux-kernel+bounces-216839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E9F90A739
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32590286493
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 07:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730391836E1;
	Mon, 17 Jun 2024 07:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pA7zfFfL"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2054.outbound.protection.outlook.com [40.107.21.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757B4181D1F;
	Mon, 17 Jun 2024 07:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718609575; cv=fail; b=KWVOq8vC1VEWqLK+SetgPSGCuiIX91IN6JUK7HJL3gDpiC+gNQrbdt62u/jiXOxoH8fN9VCipakKbfTh5mYSB8lBZDvQhDj5l65A1G9BKMOM8jvO8EyQVrMAOJPgIdsULTHMVVu1SoSPxNzNa09SWrIIhdyM1VvEDo1iGPAvxFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718609575; c=relaxed/simple;
	bh=e8DPdXKiYK20vXagi7Yems9WtvwM/X4mJ0RYdgZMFC8=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=qHnZC+0uPMtsoiBTyYvDA9Grl0lDclp0g2kpQor8aGwih5dR3NbmqmAJ6WiHpxj1ZLmW9L06DPRl4o1fnLsvlz0PPXRszmmQwjfy8GOc1BEZtT6p4GZDJyRQGKPLuol6XZ/EV3dI26aC+EJOBPKrqKAeys+kSLmxr5PY2PPkohE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=pA7zfFfL; arc=fail smtp.client-ip=40.107.21.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U66CqyLC/hqiNN9+UyFhQmiqVHaOpxQACaLXgzaw6uXeU0mpo3WqTbBHwWPFPKHRkJXR/xMzNtEqSKFPHm0rII6/zg316aKsD56dygquy/c4bYFl4LGhZQhKhOrITmKeOHZorxRXIQ0/4QrvBvSlm1CxbxLMmVcK8Cd+CXAq2y+M/tXvwe+kzLeFCwVA4RWZ/IqKh1n3R2wmEFWPvBSlVI4ob/1YmUInTedQqBFyuG0X634a7js+J1zpG0IZkpBJbVTQ39/eglVKXYynDnSE2YMREhVuFgXsOOaexk7yARzumnA/5zUX7MzTeWEUIt8TxzHC8U6puLKDSOuosMxjBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Y6RS8BIQYgU16HVAQi77pSBgQVo9ZsDIWr480ZeY+Y=;
 b=Uux5np81g8joe9Qaotvj1NQtsRnkEQpw3VgQQH4HVeUUECECPsbTlKLh0luUBryGiFfv0bNJAHqPWYsrjCS3t748U8f7qSh4WaJA7/gYfUudP4m+PITsbSJffOMfVZK7MTG1ToJ8nKGkviIzUL2OnDPoTYKxB9OqwFFjIzQL+f4OVWJQJAGSsqYcKavAbIVU73hXgIoHBii46YK+jY99/iS2YtwVPzDoXDcxDnRo7qOQRUW23zYygAIeLpxNRerQn9QUcDiH+XDRYKvvp8jB3YVsJwgwES1T9iOaMiA2RRo21/qE3MWa8aHGXk9a374ySinAFv4KetT6lJ0NqkpZYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Y6RS8BIQYgU16HVAQi77pSBgQVo9ZsDIWr480ZeY+Y=;
 b=pA7zfFfLpWygPm9kVeS0OVb39antTvUA0FKCfrUrvlMZXOLOFPiEm8TdzivQg5ZAnFles3PMT/KSyZ6HwW8K0oniqHcuYRadPR/6ad9XDun+v5JgHP2V9WwE3Qz6nUsAyZi/9Rz+ihmha8OBa6S0M8wPJ3QqjjM9B9GanYhDc/o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 07:32:48 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 07:32:47 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v3 0/5] Communication Interface to NXP secure-enclave HW IP
 like Edgelock Enclave
Date: Mon, 17 Jun 2024 12:59:38 +0530
Message-Id: <20240617-imx-se-if-v3-0-a7d28dea5c4a@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOLlb2YC/02Myw7CIBBFf8XMWswApRVX/odxQYDaWfQRMKSm6
 b87bUzs8tzccxbIMVHMcDstkGKhTOPAoM8n8J0bXlFQYAaFqkKDjaB+FpnXVrgK0Ri0Ovga+D+
 l2NK8tx5P5o7ye0yfPV3ktv4qEg+VIgUK1Xjj6qaysg73YZ4ufuxhaxR18JQ+eoo9ltogr9YZb
 f/euq5flqWK39gAAAA=
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718609402; l=9603;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=e8DPdXKiYK20vXagi7Yems9WtvwM/X4mJ0RYdgZMFC8=;
 b=4pOcVGAYQtq5LEkG2S7KDGVFETHI9h2JOG6gUlV6vPtha5jIOBGxt7deAkC0D8zC+kazPjW5Q
 v6IrsUTVw8kBpUoG5gJz3pmxKxSDlL4PS85BylUNgwxyF/uUHJzyaoE
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|PA4PR04MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: d00b307e-4701-4b38-b13a-08dc8e9fafab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|1800799021|366013|52116011|38350700011|921017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SytINllBSm9SS3BPYmNYL2ZncGw5M0JLUC96UGdSbkF5cjhGWjErT1lRbDdN?=
 =?utf-8?B?bnlaQXlHYWVqdXluaXNKWFZpN3dIWDUxeWxrV1lvTXNCMElJSFJ5dnZSeVBH?=
 =?utf-8?B?SlBhM1Rmb0hTNkE1YmhIV0NwQVpNd3I3cFlibHNuWHgrMUdLK0ZBU1dkVHdt?=
 =?utf-8?B?WnBiUlBqR2JmN0I4Mnh4ekp5U0t1ZHdLZkhZQWpILy9QVmdueTdqUW5XdGsz?=
 =?utf-8?B?Ymc0WkFFMkIvM0loR0tLRURIN0MrdkxtY045a3E1L0JiM1hRV2RJWmRwbWJ5?=
 =?utf-8?B?dmpuS1JQMVNLSG5xNFZWQ0gwdXRTVDZvcStnK29CUGZiandIWThJR3FqN1Bk?=
 =?utf-8?B?OUk3UWs4bGNOUWJTRUxwbkRtdnZWVXhOd0V3VjNmbGNna29RVzFpK0FOczRZ?=
 =?utf-8?B?TC9SUk9MZlllclUxUHQwMHJROEo5YUJQckFOVmpETnhkVlM0VUt1SFZTSzcy?=
 =?utf-8?B?VWM0dXVDL0QrckFKM1hLVjhPK2c0cW9GN0FhUEtVaENETlEvdjhsZG9jbDZ3?=
 =?utf-8?B?OFBKUmowaXZyQmp0UEhXeHRuOUNyUTdqQzFmbzFTNHVWZHdEd3BLaVFCVWxu?=
 =?utf-8?B?SGhkTDdRbTdYR3FJUHZPVjdCVklxOEVUcUpKUTNnNVVrYnBUeFpBcjJQL0w1?=
 =?utf-8?B?aHFteTlvM01CdUk3RlpuRFJhUnRLUTh3V2hzYnp5T0Z5a2JMdWNDQllTQ2JJ?=
 =?utf-8?B?bnoxZUN1NkxVSEd4WXBpOURZQm1tK1ZsQ1JtZXlZOTQvSXlBOXJWS010dGJq?=
 =?utf-8?B?NWQzNlhBTDFRWlJkUlBKd0JBOEVzT1poTktRTnBXazR4SHIwTkFqSG1FcUhO?=
 =?utf-8?B?ZUYrUEhENVpmeW85SGh5L0Jka0ZyTXB0U2pEa1p2M2hKNkVoeFpPUVdwSnRX?=
 =?utf-8?B?RUJWOSt6bEhyWmk3b0FDb0h6K3dzT05pRFNtd1c1UnlPWDQwZThGanlSc1d0?=
 =?utf-8?B?VkMxV0xYTWpJM21VRHptbC81MXUzdWVtb2tPMldVWFY5YzAxZy96Ny92Y1BJ?=
 =?utf-8?B?RFRlYkhwQXJpalFrT3QzTTd1eVBtQ0xSQzJsZk4wb2IrZVUvdFpiUERsT25H?=
 =?utf-8?B?dUI2eFFsdmtyMEl4cDJFd3RndmhzdHNlSlZxQnFmcFB4L3hhMzNsYmZROExJ?=
 =?utf-8?B?bEhIWDdnZnQ5V1FmdjdoeTBjZ24xakhnSzZoY3JEL0trakFaL3g4elhpVEZt?=
 =?utf-8?B?dTg4V3J1d3FmMVBJK1JmWnorM1pjeElOTDBNek8vcEpSVWVnRzFtTjV1bDVi?=
 =?utf-8?B?YjF3a3VSV2IyZzk2S1pQenZHSmptMEM3bHBFbFdOSmI1ZS9xSk5wZmllMnVV?=
 =?utf-8?B?LzBrMXdaQWRGdW9nNTZhaEhJem5vQUdQdVhoSGVkYWQwWXMxY1U5RWFZdkk1?=
 =?utf-8?B?ck1GUnFhTzhCak5POUl1RW9rWFRiVFhNOGtGL3dmWDUva25jWm1ja2w1KzlU?=
 =?utf-8?B?RExvbSt6bWFnSHN4ZjU3eG55eVNCMlh3VlhEcFVHV1FHdkRjQlNHMjBYYkVl?=
 =?utf-8?B?ZzFkZ0VJSFVCb2R6MnhjTHM3UW1jZkNxV0tQZlZWVTJNUldqZFBNQWloQkhZ?=
 =?utf-8?B?bUtOYWV2MXdWTlBKZFF0Z2Z2UlhkNGhieVFYMng0alJLalZ6N2tteEJrSDhn?=
 =?utf-8?B?Mk1EWlFpa2hGbGxKWTlwTTBTZzhwOFNTSmFLQUtnVkd5eE96eWI5WS8yMU1j?=
 =?utf-8?B?dHRlYkVWM05HcXNFR3dnWll2allIZm9KY0psd0E3dUp0NXhmY1FQcysraGxI?=
 =?utf-8?B?ZStzb09Wdkc4VzIzTG5Qb0VTK1d0UkJuWVQzbjB6cDd2YnhJa2JzVGFPcEM2?=
 =?utf-8?B?WC81UHZWZGZ2djJNemc3Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013)(52116011)(38350700011)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUJXczRJOGQvL21tNVUrYnlaRFJWRmp1eVdYRGtMdHpBU1A2WHh2K3kreHBC?=
 =?utf-8?B?ckY5NDVOSm10S3lWZGNoQS9hSlNMVStVQk5tdXM0OEpiTVhEN211QU5jNVlV?=
 =?utf-8?B?TEZlc3pNOFRtU2NFSlBjckZMcEdaanNiMmxMQnUxQUcxM0Z3RTdmMHhkSHR5?=
 =?utf-8?B?cHlKbzNUVitBaUxOUHovUTVvRFBwZjBGeUNhUXd1SXcwcVZiQms1dTd0WGdY?=
 =?utf-8?B?R2pOU3l0VFdaZ0IwL1VaOVEzNXh5NHAzdEtMdDBtRXpKcVh0Mi9mSFNwb1BX?=
 =?utf-8?B?Zm1seDd4SUFtWUNBR0NUellaQ2p3dVpucXREcmhGTlEyYlY2c3BCaUM2bHJX?=
 =?utf-8?B?Q1VXRzhjcGxLS3RWejh6OG4yTTAvUG9sRXovS1hzbWw2WjNPU2h4QlVQTk12?=
 =?utf-8?B?a3k0a3oxOVN4TmlFREU4RkQraVIra0x1QS9TQkZ6YTFBd25vM256dE52Y2Vj?=
 =?utf-8?B?Wk1od2h6cWpHWHBBajVlSzNyN0lJT3k2amNYaU9Kays4bno2Q2YwU0lqZzJW?=
 =?utf-8?B?a0d1dnRiM1JwNnhMRHJORzNMOXlXNWs0WnZzS1M0K3gwVHcyRDRwRUovaUNE?=
 =?utf-8?B?QlVlaDVsWFNhcmJDbGlxaTZubk1Cc3gxNE5PUjEraEx0R3Q1ZzJWbndTY2Fh?=
 =?utf-8?B?cnYwRm1icndTT3FyTWZTRzdLcDJUVm5JNUowQ2Q2akNSbjZjK3dIcmI2dWNL?=
 =?utf-8?B?d1RwYlVKVWRsMkVZUmJGdml1WmRKOGE3cy9oSTEzOFFGeENHRFhKVDN6bTcz?=
 =?utf-8?B?eXkxVE1CQUx2NjBnQjcyd2dQSGhZTGZpS0NpMnNqRUowMmdjbWh0b3JlQWx5?=
 =?utf-8?B?U0FLcyt0Y1JVYkd1bi9ZVFJBU3AxSERSUkN0bmFGQnM5ck1IcFZpc3BqejJU?=
 =?utf-8?B?UXRCd0FWNktueUhGZTR6cHlocXJiZllmM3g0UDI2R2lseUlqVG9yYi9LSzNq?=
 =?utf-8?B?VEFRYXZBS3I1dUZJRHIzbFQ0cEJtMUZLNGNjdDA1TDFjby9VemFYb1k4SmRI?=
 =?utf-8?B?TVZOUC9ubVFqQUtvSisvaUI1Njg3VUNDK2NjT1NGdUtES3ZlQ0RMdWM0TFRy?=
 =?utf-8?B?Tm0vNTZnMVhYTHNYK1VzVE1GaWxWVXh4cS9lV2VUYnFUdkRTb3NCbHFvcFc3?=
 =?utf-8?B?Z2JkUWZDTk4zZCsrUW9HYUN3ODY0WS9SQjlWRzFuemd5dHRmWjcwY1FqRm0y?=
 =?utf-8?B?OVgrZ1IxcjZMYnorYWZBUlRpc1gzY1BUTXRYdE1Da1p4aFdlakpONmJ0SXJY?=
 =?utf-8?B?c0hYanR4QThYUWl0YzhiZUQ5N0VYTlVYeTFaWjJGVU5tNFI3eFBmamNWc0g5?=
 =?utf-8?B?NVZqcGdCK0E4VWIvdTF2dGlCcUNsQ0xvOUVCOERTTDduNDczRHZKUFlZNTlq?=
 =?utf-8?B?c3R1c0o1c1FOdVVLRFNEV1doZmhaMmpuQis4OGxTU3lyUGpSNTVaYVVweWJW?=
 =?utf-8?B?OXFlNlRyYnhKc09aUXBVSnJjWVEyTGZqZDdpS3Q2dEpZK0c2b0J6MmdIa0FF?=
 =?utf-8?B?Sm9EdmpVZ2lXb1BEMXNRNFpncEdpbWFxUVV4WW1zNnc1MjloVkV6ZU5VNXdj?=
 =?utf-8?B?UnFEL0hNR2xWL0NqVHNmMUdGa2FURGpISzdtQ1pnU3hudVY3WFhXZ2xmbE1W?=
 =?utf-8?B?ZGQrQTZUWTA1ZDdxa0x1OEc3QkgyMzNSUlZWdkZhWGtweDlWTXcwd1ZDcWV5?=
 =?utf-8?B?ZFBwTlowNEZZbThqN1N6ekZqZ3FFbEJYd2ZNVU5DSDV0ZFdZaWlKWk9QcXZW?=
 =?utf-8?B?VkpWL0JtUWl6N0JTWkxEMGJQNHE2M0I5ZGt0QWc5NGtiWk1rcVZ5R1o1aGZa?=
 =?utf-8?B?aVBHQVYrcjArQW4zejF5S0lUOElPTWtGWUFoUld4eVNSamR6aldXZE9KRnJQ?=
 =?utf-8?B?bXpya2llU0s4ZUF4WTNRQ2lQYXhDVjkrT0pYd3RpQzd6NzdkKzZVUjBnZ3NU?=
 =?utf-8?B?ZUIzeStKUFhrME5ueUZLb3JYbkV2UG5EUlM5Z0dLcytWc3B4UXUyN2twNzhU?=
 =?utf-8?B?bGt5VHJsWFdTRFgrcWNhWVlRZUFpNzFUWjBQcVg3RktiS0QxWWNJb0RQZ1Rj?=
 =?utf-8?B?MHRDa0Y5NjlCcUtMZXdYMEYzTjQzNGdSTm5zdjZWK1IvQVNqMVNnbHV1Q2dx?=
 =?utf-8?Q?gcdVPn0XUgok4rGU1lgYz52ZE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d00b307e-4701-4b38-b13a-08dc8e9fafab
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 07:32:47.9345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwXsBuAVm5ZKGVTlbMvTOj1pDa977smyxcwd3yITCEXMZvMO39XBgGPpD3VDMPWP8XiVcx/M411c/0CA8LEk7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7982

Hardware interface of the NXP Secure Enclave  HW IP(s) like EdgeLock Enclave,
V2X, SHE etc, is based on the Messaging Unit module that enables processing
elements like ARMv8 core, RISC V core, within the SoC to communicate and
coordinate by passing messages (e.g., data, status and control) through 
these interfaces.

The NXP i.MX secure enclaves hardware interface kernel driver, is specifically
targeted for use between application core and NXP secure-enclave(s) HW. It allows
to send/receive messages to/from the secure-enclave.

Patch-set adds the kernel driver for communication interface to secure-enclave,
for exchanging messages with NXP secure enclave HW IP(s) like EdgeLock Enclave,
both from:
- User-Space Applications via character driver.
- Kernel-space, used by kernel management layers like DM-Crypt.

To: Jonathan Corbet <corbet@lwn.net>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>

Changes in v3:
5/5:
- Initialize tx_msg with NULL.
- memdup_user() returns an error pointer, not NULL. correct it by adding check for err_ptr.
- new IOCTL is added to send & recieve the message.
- replaced the while loop till list is empty, with list_for_each_entry.
- replaced __list_del_entry, with list_del.
- Removed the dev_err message from copy to user.
- Removed the casting of void *.
- corrected the typcasting in copy to user.
- removed un-necessary goto statement.
- Removed dead code for clean-up of memory.
- Removed un-mapping of secured memory
- Passing se_if_priv structure to init_device_context.
- Updated the below check to replace io.length with round_up(io.length).
	if (shared_mem->size < shared_mem->pos|| io.length >= shared_mem->size - shared_mem->pos)
- Created a function to cleanup the list of shared memory buffers.
- Used list_for_each_entry_safe(). created a separate functions: se_dev_ctx_cpy_out_data() & se_dev_ctx_shared_mem_cleanup()

4/5
- Changed the compatible string to replace "-ele", to "-se".
- Declaration of imx_se_node_info, is done as const in the whole file
- Remove the unused macros from ele_base_msg.h
- Remove the function declaration get_phy_buf_mem_pool1, from the header file.
- Replace the use of dmam_alloc_coherent to dma_alloc_coherent
- Check for function pointer, before calling the fucntion pointer in imx_fetch_se_soc_info
- Removed the unused flag for SE_MU_IO_FLAGS_USE_SEC_MEM.
-  Removed the unused macros WORD_SZ
- instead of struct device *dev, struct se_if_priv *priv, is used as argument to the funtions:se_save_imem_state, se_restore_imem_state, imx_fetch_se_soc_info
- Removed ret from validate_rsp_hdr.
- changed the prefix of the funtion: plat_add_msg_crc and plat_fill_cmd_msg_hdr.
- indentation correction for info structures.
- remove the check for priv not null from se_if_probe_cleanup
- Removed the casting of void *.
- se_load_firmware function is corrected for not freeing the buffer when allocation fails.
- Checking if get_imx_se_node_info() can return NULL, in se_if_probe()
- imem.size has type u32. return value from se_save_imem_state() will be assigned to imem.size in case of success only.
- removed the flag un-setting in case of failure. priv->flags &= (~RESERVED_DMA_POOL);
- removed the function call for devm_of_platform_populate(dev);
- Checking for not-NULL,  before calling the funtion pointer se_fetch_soc_info.
- Removed the checking for reserved memory flag, before freeing up the reserved memory, in se_probe_if_cleanup.

3/5
- Changed the compatible string to replace "-ele", to "-se".

2/5
- to fix the warning error, replaced the "-ele" & "-v2x" in compatible string, to "-se".
- Added an example for ele@0 for compatible string "fsl,imx95-se"

Changes in v2:

4/4
- Split this patch into two: 1. base driver & 2. Miscdev
- Initialize the return variable "err" as 0, before calling 'return err', in the file ele_common.c
- Fix the usage of un-iniitialized pointer variable, by initializing them with NULL, in ele_base_msg.c.
- Fix initializing the ret variable, to return the correct error code in case of issue.
- replaced dmam_alloc_coherent with dma_alloc_coherent.
- Replace the use of ELE_GET_INFO_READ_SZ, with sizeof(soc_info).
- Replaced -1 with -EPERM
- Removed the safety check on func-input param, in ele_get_info().
- fix the assigning data[1] with lower 32 address, rather than zero, for ele_fw_authenticate API.
- Correctly initializing the function's return error code, for file  ele_base_msg.c.
- replaced 'return' with 'goto'.
- Use length in bytes.
- Corrected the structure se_msg_hdr.
- Moved setting of rx_msg  to priv, into the function imx_ele_msg_send_rcv
- Will add lockdep_assert_held, to receive path, in v2.
- corrected the spacing at "ret  = validate_rsp_hdr"
- FIELD_GET() used for RES_STATUS
- Re-write the structure soc_info, matching the information provided in response to this api.
- The "|" goes to the end of the previous line. 
- Moved the locking and unlocking of the command lock to the caller of the function.
- removed the safety check for device private data.
- Structure memory reference, used to read message header.
- In the interrupt call back function, remove assigning waiting_rsp_dev to NULL, in case of response message rcv from FW.
- do while removed.
- replaced BIT(1) for RESERVED_DMA_POOL, to BIT(0)
- The backslash is removed while assigning the file name with absolute path to structure variable.fw_name_in_rfs =.
- Update the 'if' condition by removing "idx < 0".
- mbox_request_channel_byname() uses a "char" for the name not a u8. Corrected.
- devm managed resources, are not cleaned now, in function se_probe_if_cleanup
- Used dev_err_probe().
- Used %pe to print error string.
- remove "__maybe_unused" for "struct platform_device *enum_plat_dev __maybe_unused;"
- used FIELD_GET(), for  RES_STATUS. Removed the use of MSG_TAG, MSG_COMMAND, MSG_SIZE, MSG_VER.
- Depricated the used of member of struct se_if_priv, bool no_dev_ctx_used;
- Moved the text explaing the synchronization logic via mutexes, from patch 1/4 to se_ctrl.h.
- removed the type casting of info_list = (struct imx_se_node_info_list *) device_get_match_data(dev->parent);
- Used static variable priv->soc_rev in the se_ctrl.c, replaced the following condition: if (info_list->soc_rev) to if (priv->soc_rev) for checking if this flow is already executed or not.
- imx_fetch_soc_info will return failure if the get_info function fails.
- Removed devm_free from imx_fetch_soc_info too.

3/3
- Made changes to move all the properties to parent node, without any child node.

2/4
- Use Hex pattern string.
- Move the properties to parent node, with no child node.
- Add i.MX95-ele to compatible nodes to fix the warning "/example-2/v2x: failed to match any schema with compatible: ['fsl,imx95-v2x']"

1/1
- Corrected the spelling from creats to creates.
- drop the braces around the plural 's' for interfaces
- written se in upper case SE.
- Replace "multiple message(s)" with messages.
- Removed too much details about locks.

Testing
- make CHECK_DTBS=y freescale/imx8ulp-evk.dtb;
- make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,imx-se.yaml
- make C=1 CHECK=scripts/coccicheck drivers/firmware/imx/*.* W=1 > r.txt
- ./scripts/checkpatch.pl --git <>..HEAD
- Tested the Image and .dtb, on the i.MX8ULP.

Reference
- Link to v1: https://lore.kernel.org/r/20240510-imx-se-if-v1-0-27c5a674916d@nxp.com
- Link to v2: https://lore.kernel.org/r/20240523-imx-se-if-v2-0-5a6fd189a539@nxp.com

---
Pankaj Gupta (5):
      Documentation/firmware: add imx/se to other_interfaces
      dt-bindings: arm: fsl: add imx-se-fw binding doc
      arm64: dts: imx8ulp-evk: add nxp secure enclave firmware
      firmware: imx: add driver for NXP EdgeLock Enclave
      firmware: imx: adds miscdev

 Documentation/ABI/testing/se-cdev                  |   42 +
 .../devicetree/bindings/firmware/fsl,imx-se.yaml   |  160 +++
 .../driver-api/firmware/other_interfaces.rst       |  119 ++
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts      |   17 +-
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi         |   14 +-
 drivers/firmware/imx/Kconfig                       |   12 +
 drivers/firmware/imx/Makefile                      |    2 +
 drivers/firmware/imx/ele_base_msg.c                |  284 +++++
 drivers/firmware/imx/ele_base_msg.h                |   90 ++
 drivers/firmware/imx/ele_common.c                  |  382 ++++++
 drivers/firmware/imx/ele_common.h                  |   49 +
 drivers/firmware/imx/se_ctrl.c                     | 1230 ++++++++++++++++++++
 drivers/firmware/imx/se_ctrl.h                     |  148 +++
 include/linux/firmware/imx/se_api.h                |   14 +
 include/uapi/linux/se_ioctl.h                      |   94 ++
 15 files changed, 2654 insertions(+), 3 deletions(-)
---
base-commit: b63ff26648537a5600cf79bd62f916792c53e015
change-id: 20240507-imx-se-if-a40055093dc6

Best regards,
-- 
Pankaj Gupta <pankaj.gupta@nxp.com>


