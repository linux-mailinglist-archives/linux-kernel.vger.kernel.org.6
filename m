Return-Path: <linux-kernel+bounces-368416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6606F9A0F8F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7F1F1F27BBF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CB645008;
	Wed, 16 Oct 2024 16:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pe8z+T36"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2049.outbound.protection.outlook.com [40.107.103.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98900210C38;
	Wed, 16 Oct 2024 16:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729095812; cv=fail; b=WH7xSIck9O+zqNnMA3yHgy9kAWbWXGdKWe/Md4H398ez66umCzP/veEvFpugy1jYqGYK02rptcpib8LcMk85Ddr9yNAPNgD8jKJh7hThu7HBlqSQAsnUeVt5GCb+sMsuR9S/X2hNmyTBiSELiyRQEomrE3RaPjaYOaLAQqMGQX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729095812; c=relaxed/simple;
	bh=FwHu8HOgjdeesS4jBLvkey7Y+WnnBYkcgUp1hGR75ZU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=kAUnpKCC6Sq2QASR6gVvW72d160+Git3N1xL45/jZonil2y+DFltL0X8rty/zVuIK3ZEfYNr/lHhhXJXwzFfx75VAtav8xlLFrDWASB0I6UHVJsuN3CAl7gAWAAXB7K841MmcxzWcTQo1OiEu7gFM5ePe8DtjIMhaQDFPrhcvqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Pe8z+T36; arc=fail smtp.client-ip=40.107.103.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YdEO+JmG7TAB8vWALFxbECfV533RWOOqLRloIG307xU4BgezG3SIwFFYBdQWsKgraqVWewDldPxVmSgdTLwy/1sOFtUucPQyZ+hw5Qje6xUBAcdtfTXKx7Jop+5uxXT9SN30u1w7V37PlJ21/1W93EE84xNT/3KD59GIEONrpfRTgWOTPB8hpfIzMPd2jKtuSgBnPu3QhFyusN9dvF6LEBqsIMB/Kzzhd7iSS9pdNts/8dfTQmHYo+U58de1IcFrRXWTGCLAalL8993cTADzwvWrWKaYz9MfvLwMjgWoI8PmUnlFuCWJzA4X8oF7sz2QeF1v8eYIo1cL65gA6WaI8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rydjPSyjFpE1b+KVUJhSPw9jPLhoKfIzwxtGoWGJhg4=;
 b=SpIq4F1iyUdX7VGB9donFcTJNXa1Bo83q2N3vKzdbKl2E+nJiOQuICULcAJ8ZCgwlmC3+WmWaxJaiEMpbge8h2YotUUX796ai4vYFZJ5MWSzAI3Ru/vtAirEJXHxyMpkvdUbSJKa/KMAphRAblHkyukcXHOLaso0MWcQISjLZ836kK12us+pxXK2+CiVVUq+aqAt+RnXUFWs4H9JIFuR5XCA7awxaJlGGqv+1D+4EC4XnyXi1GUdRe5mly40+woDbFmtFlW3Xs1HXv7b/vxtnIlNnUxOne1mjlwpLQEkGGiEl86uKyIM1ZvioZOjr1cjknjWtYzODNSoBwSe3ZO3Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rydjPSyjFpE1b+KVUJhSPw9jPLhoKfIzwxtGoWGJhg4=;
 b=Pe8z+T36LLLGox2Q/X8kq2Y5BU9NireGzPpxYWQYhWrQxwCFBDOabR5WrTG7CcssqqPkmi8PeHP8xKrsucEnxNGEblPhFES+qztK2Upq2f/nCIoE9iY87DdTpqzKxFSd4LPutGhrAWoS6Cx3PofI6SAwniUXgyn88SG4+SyA6rAE+5T7QVtXf85J8r8d5/x0yLpQ4tHrZ1tiw9uPMfbGkNX1zEjkbw3OxnWbmddq5mhUxTmxd+U0I4CAwO2YGIrJO9fKm/p2q7QyXgJuAUpUaQSxU4aT8KYzp6lqs2PBDXEYX0HlNZ6QDofxEdUMIAcWxx2C8l9bkmiCXo4CWioUiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8599.eurprd04.prod.outlook.com (2603:10a6:10:2da::7)
 by AM0PR04MB6884.eurprd04.prod.outlook.com (2603:10a6:208:183::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 16:23:27 +0000
Received: from DU2PR04MB8599.eurprd04.prod.outlook.com
 ([fe80::763:eb3b:6607:1e72]) by DU2PR04MB8599.eurprd04.prod.outlook.com
 ([fe80::763:eb3b:6607:1e72%5]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 16:23:27 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Wed, 16 Oct 2024 21:48:58 +0530
Subject: [PATCH v9 1/5] Documentation/firmware: add imx/se to
 other_interfaces
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-imx-se-if-v9-1-fd8fa0c04eab@nxp.com>
References: <20241016-imx-se-if-v9-0-fd8fa0c04eab@nxp.com>
In-Reply-To: <20241016-imx-se-if-v9-0-fd8fa0c04eab@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729095547; l=6679;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=FwHu8HOgjdeesS4jBLvkey7Y+WnnBYkcgUp1hGR75ZU=;
 b=ET9o4TYtEmE2iOu2H5udFFqOsZeGIGrT9EzdjnNf/UG9wp53DmDKoEM+gECNvxxvVTkTQU+yt
 kjauYXvTUxVAJVwej7oUNiulDy7o+y3MoIzorR6T0I5mbATbXkKIxtC
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SG2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:3:18::25) To DU2PR04MB8599.eurprd04.prod.outlook.com
 (2603:10a6:10:2da::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8599:EE_|AM0PR04MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: a7dac2b9-7a42-444b-ede3-08dcedfedd64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aG1vQUNoNHlvWGVNRStMNHRBSWpFNUg5VDJSVjd0QWFTTEdNU1hYNEwrdjV6?=
 =?utf-8?B?V1d5a3A1QzdVaDAxRHhYS3o0MGozUW5XUUQ2bWVLNlVNOGJsemE0SW56WDhn?=
 =?utf-8?B?Q01sMWgvVGxPU0FFcVBPSFhCYitkbkhveS9OK3h6N2tHZGZhejdtY3NxcE1t?=
 =?utf-8?B?YlRYM29IYWcrRGc2Y3N3ajRzUXNRdk9QcFN1bWVVcStoVm9yRUcxMEZCcERq?=
 =?utf-8?B?cmd0bmdJVWdkdWZBNGJ5a3JZeEhhN1RlRER1RElhc3FzRVdCSitYWXNyZW05?=
 =?utf-8?B?YWdrTzFwQ0NqV1RQU0IvTDNnWmY5VlQ3Qk1kOTRudXRaYzRDN2RZVGpsVFNl?=
 =?utf-8?B?d0N1OWRaSVZsYUlPMkFFdklqRjhySVFqMmxIQ0lETEQ2S1owaVQxT3EzVHpZ?=
 =?utf-8?B?TVBiaXlSWW16MzZVeHFCK2Vyb0N4VHk2UmE2dG1oYVhCY3NyeG03dUVrTGVn?=
 =?utf-8?B?c3R0ZlJLOWNOUWhxaXd6cjhVU2VxL1ZkdTAzYXJvRHExTHpFTWtaVTljcUpo?=
 =?utf-8?B?ak5wbWJsa21SZ2ZVc1crd3NXQjZkZnVjQkdKL1ZvMlA3MFlrclQ0endmbkJj?=
 =?utf-8?B?emN3by9ReER0SXVTUUxYSjQra2JtM2ppcmZEZVZKamVrbDFHWmQ3YlNHR2Nv?=
 =?utf-8?B?NWltOWF5WTdPYUlPMmpSVkRIMnRRSklYdVR0YXE3eFlNNTIvRWdmZzNaTS9N?=
 =?utf-8?B?Y3BDaGc1ZXI0MnYrSVFaNDRBdjl6b2VwL1l5YXpFaG1tVVIreC9lRkJ5VS9E?=
 =?utf-8?B?NzVWNlFCL0pZVGdpNzBSeHRMS1hOYVpTNktvVXFOL0Y0QUxjODJFTWRKekV4?=
 =?utf-8?B?cklBM0ZEK2NxTnJNYWREbk0zK1dGVmN2dVZVRXhDUXJnanVyT2JXNDR1dCsr?=
 =?utf-8?B?aVZtcldTRmMxeXhsLzF2STBGclVhUDg1L2VzSW5YVkRPai9VQUUxemdOREw1?=
 =?utf-8?B?OFZ3c1RwRU4zVUFuMUNTajNudmdRN2NMa2M3R0txVThIaFpNQXJsNHYwZUVv?=
 =?utf-8?B?RGZ6YVBDaDRUbVU4TWNTbW1aMmMyZUtlQ09Kbk1IUVpEL0xtQmxuaG96Rkt6?=
 =?utf-8?B?V3NwMWwwTWNIVDloNW1aOTVBNWN1UlhPZURPVWIwTGpEM1dheFpHU3BVQmFP?=
 =?utf-8?B?bVF6ODBQQjU1K2RMMGJXa1Z3RUw5OVJpUUlEcDhWUTEvYkU5VFJBWEUydldq?=
 =?utf-8?B?TEhxeWEwaHVrMkM3bUZMdzVJVXhCNlkyOW5mb0UxYjZqWXRVR1RIbElOMUZu?=
 =?utf-8?B?d001Wm5zVTJrcEJzU0pLSXIzYTNGZjUrZmNkSjRSajVBSW5wSmVpVURWQk83?=
 =?utf-8?B?UEo5WWFVdlR0VEdoRmJkd3k1Y2VPdVFMcERTL3loQ3ZFenlGODRzT3EwWlFL?=
 =?utf-8?B?cjlsNTRHTTVzNTRiVW5yWkxUbTllVUEvSXJENFNSeVhxdEZSMndRazA2aGFp?=
 =?utf-8?B?Z0ZYNExDODJidmNDejNoT2xwUDA3THdBY21tdFdYNHlMMTRLRDlEL2FySXNW?=
 =?utf-8?B?M2JpSmF1dE9iNTNwR21LWGtKR0Uza3pKWDRyTDVxTm1SK3ZNbjVPUjh2TWFn?=
 =?utf-8?B?QVdveUVKQThrMWNoL3ROSEo5ejRJZHBJYlNkTkFIRktNLzNXYnp5SWI5TnZu?=
 =?utf-8?B?SjJyZ0RzOWRyVXIrQ0JIU0IrdWQyNWt6dHNGSG9nT1ZDbGYzV1E2L1IzR1lV?=
 =?utf-8?B?R1Z5MTJJWHhESG5NQnA1Yks0NWdyaU1oanQ4TzBZd1hHSnFETXM5WFY2ZXFP?=
 =?utf-8?B?SUpFRnA2SEl6V3BXWVlOYTMzYUdwN3BMckdVRHpQQ1JrRXNSRHpuTkxpQkxm?=
 =?utf-8?B?azdxak95U3V5cW5QZU5BQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8599.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEsxTTJjOHRWM1FrNGpqVTk3UzdJWFRwa0JYYkZDR0lFRklQY3hCSmdHenhB?=
 =?utf-8?B?dFVkMG1mM0Q3Tkt3Y1lmME00SWRycmVNWXlydmpJZ1gvcWtFdEIxK3EzTmZV?=
 =?utf-8?B?NE5oa3JuMUdrNE5QdjlyUGQydmFxdGJhNFozK2pMWEZPM1MrM2ZERzN1cjNN?=
 =?utf-8?B?Y1hjRGlUeVY4cjlXLzlHOVdDMjFOY3RhM0dHV1k5aW5qMzdYUFRubDdxSjk0?=
 =?utf-8?B?S2pGUDlTL3Faa205TGYvM1paeVJkNCtiNTdSZVZCMjloTHdaQjJwalllUlpH?=
 =?utf-8?B?MXhrVUl1SVRwQmJQS2E5VENXMnVBVWlhSHVGUGJ4YWpJQit1SnpyK0RkeGZV?=
 =?utf-8?B?VWU4VUQzOXNZMXQxMjJ3WEg5Q0hPT1JDRlZxUzZyS0t2VHNVQlArQ0lPZXFw?=
 =?utf-8?B?dWhabjN3RmFMUjRDTjZlb08wdFZOcmoxN2t1S2RENXNGV0ZSYlh0TGdlb05N?=
 =?utf-8?B?Tk8xaVIvTlN6SVpuemR0K0YzdjkxNU90bG90UW4vQXZUNTAvdnlkUWtOTEd5?=
 =?utf-8?B?a0pRUkd5T1JjaWxUZHNtNytzblRabWd1SHg1eDB2cU9VWHRGVlRPS0MwdmRY?=
 =?utf-8?B?eE1rQ2k3U0dMSFFLc2JzbEVNamo5L1d6TlpSSTZsbUppMWtsMmQ4cSs1R0Zq?=
 =?utf-8?B?UE14cnNLL2YwMW01Q1h3eTFVa25mcWV5UjlURG93RlFXNjlidEx4RDZJTzVl?=
 =?utf-8?B?MEhkT2ROVGFHMTM0YmF0Z0FYN3R4cXBDRStvalV3U09uT0t2dnlSNTdlMXg3?=
 =?utf-8?B?eHRmNnZIUktmeHU5WjZROXhvbGJZV2IreElIK2lGclpkMlcva0JTNHluSXZi?=
 =?utf-8?B?WlEzYjM2UnIwT0luMnhzSXNBYjU1MkUvbGdHL1NaRC9QVnNVSW5rbVdabmM2?=
 =?utf-8?B?VWFXYjQvNWZvcVlOT2Z0R1hhVllaODhjTm8xLy9ESWk2cWdrT2pYU1MwaHRx?=
 =?utf-8?B?dk5oeTB2R0xGVHdvSDF6YnBuMzlxL2hEc2FyTDljbndVZzhJSi9NbkdEejI5?=
 =?utf-8?B?YnJWNDErdzRtZTJ0TnRKeWFuL0VHcGFGQTlkMTl1MGRuN1YzMDZzSWh0all3?=
 =?utf-8?B?MFhRbmRvMG5yS01pb3F3amtHKzQ5VDRLVUZ2M0ZRREhYVXQydU5STlBJempu?=
 =?utf-8?B?Tk9LNlA5OXNNSWR2OHo0NjBSMHAycHVKQm1iZWQ0VTBVbCtIbVlFYTBFY1ZN?=
 =?utf-8?B?WklaOVg4bWl2WkhacEdtd01HNXVLU0dvaDE0bjkzYmVDK2c5RGFkUjlTYStY?=
 =?utf-8?B?ekZ3aW5CRCsvUHE5dTc1U09wSFl0eVRkN25lWEQ0V1VEUW5VYjc2QXVOMlB1?=
 =?utf-8?B?b3czdHVUVE0zaThxcnMvTStmM1pkaHFUM0lQaWQ1YWgwWmM2VTd6cFdjdzdU?=
 =?utf-8?B?V1IwUlRUTHRWdzdjL3c0YlpDVEphMDUyKzFVSmVvWUpVTlBhQVFSUFpVQ1VV?=
 =?utf-8?B?ei9NcHkyamVsbS9peWJCR1F4N1JGMXR4b2dVRmp6MnB0bVMxTDAweHFiTGF5?=
 =?utf-8?B?d1FLanh2QnFtVjV6N3BIemgzUElHMHJMRlQySkRpb1UwZENBNkViZGpzWjQr?=
 =?utf-8?B?eFVjV21LYld4NWJVMWZHbFBQR3NsQWZuTW1NbzZEbUpDSTlVL3l0M0NKUGov?=
 =?utf-8?B?MUpEUTZuM0lGcnZrRmxhb0pIV1I3OGpNWUphYk5HTW9vWmJ5ME1BRXladWFz?=
 =?utf-8?B?b2w1VFpwNjFNbStLNFhJNWtiaTliT2lYV1B1QjliNTVWNFZJMC91V0FLS1lk?=
 =?utf-8?B?YmJPd0ZReW4yMEJxV254cFVxTmtmaEJPd0FaakxMaFdENkhPRG55bFpYT25O?=
 =?utf-8?B?dUM4K0FoUm4rbGNyS2EydWtFZ3F0Q0hVMVorN05jQUNRdjBFYVZrdjlzVEd5?=
 =?utf-8?B?QUd5Z1U1SFhrS0wwbTYybCtzNWxDbU5kWTgweldmaTVZNE9iMkMrcllQMm1v?=
 =?utf-8?B?QXhTYVdoeGRtdG1sTlg0Z0J1MXRiUUZJaWdlam5mWGJOUW5lc0g5a0p0ejFv?=
 =?utf-8?B?WWx6VG9Oa2V1ZjdmQUhtZDF4Lzh1WnlENUhBdDJ5WEZ4aHF5YmlpZGV5dXZq?=
 =?utf-8?B?UGNPMVAydVorM1lkV0JWeXBXSUxBelZkeDNhSnhvQlZ2SjF3aGRPUGlUNFRO?=
 =?utf-8?Q?4UMstwaJuPbezig1V02XWyMj8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7dac2b9-7a42-444b-ede3-08dcedfedd64
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8599.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 16:23:27.2783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /IlQPbIAXW/EkobGLpxU2RTMQGhtpxKaJWW+6bB2Q3IKnMnOvqzzwrDPx/J4yLcofyl8o9fzKVBpRvWp2KDmuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6884

Documents i.MX SoC's Service layer and C_DEV driver for selected SoC(s)
that contains the NXP hardware IP(s) for Secure Enclaves(se) like:
- NXP EdgeLock Enclave on i.MX93 & i.MX8ULP

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 .../driver-api/firmware/other_interfaces.rst       | 121 +++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/Documentation/driver-api/firmware/other_interfaces.rst b/Documentation/driver-api/firmware/other_interfaces.rst
index 06ac89adaafb..a3a95b54a174 100644
--- a/Documentation/driver-api/firmware/other_interfaces.rst
+++ b/Documentation/driver-api/firmware/other_interfaces.rst
@@ -49,3 +49,124 @@ of the requests on to a secure monitor (EL3).
 
 .. kernel-doc:: drivers/firmware/stratix10-svc.c
    :export:
+
+NXP Secure Enclave Firmware Interface
+=====================================
+
+Introduction
+------------
+The NXP's i.MX HW IP like EdgeLock Enclave, V2X etc., creates an embedded secure
+enclave within the SoC boundary to enable features like
+ - Hardware Security Module (HSM)
+ - Security Hardware Extension (SHE)
+ - Vehicular to Anything (V2X)
+
+Each of the above feature is enabled through dedicated NXP H/W IP on the SoC.
+On a single SoC, multiple hardware IP (or can say more than one secure enclave)
+can exist.
+
+NXP SoCs enabled with the such secure enclaves(SEs) IPs are:
+i.MX93, i.MX8ULP
+
+To communicate with one or more co-existing SE(s) on SoC, there is/are dedicated
+messaging units(MU) per SE. Each co-existing SE can have one or multiple exclusive
+MUs, dedicated to itself. None of the MU is shared between two SEs.
+Communication of the MU is realized using the Linux mailbox driver.
+
+NXP Secure Enclave(SE) Interface
+--------------------------------
+Although MU(s) is/are not shared between SE(s). But for SoC like i.MX95 which has
+multiple SE(s) like HSM, V2X-HSM, V2X-SHE; all the SE(s) and their interfaces 'se-if'
+that is/are dedicated to a particular SE will be enumerated and provisioned using the
+single compatible node("fsl,imx95-se").
+
+Each 'se-if' comprise of twp layers:
+- (C_DEV Layer) User-Space software-access interface.
+- (Service Layer) OS-level software-access interface.
+
+   +--------------------------------------------+
+   |            Character Device(C_DEV)         |
+   |                                            |
+   |   +---------+ +---------+     +---------+  |
+   |   | misc #1 | | misc #2 | ... | misc #n |  |
+   |   |  dev    | |  dev    |     | dev     |  |
+   |   +---------+ +---------+     +---------+  |
+   |        +-------------------------+         |
+   |        | Misc. Dev Synchr. Logic |         |
+   |        +-------------------------+         |
+   |                                            |
+   +--------------------------------------------+
+
+   +--------------------------------------------+
+   |               Service Layer                |
+   |                                            |
+   |      +-----------------------------+       |
+   |      | Message Serialization Logic |       |
+   |      +-----------------------------+       |
+   |          +---------------+                 |
+   |          |  imx-mailbox  |                 |
+   |          |   mailbox.c   |                 |
+   |          +---------------+                 |
+   |                                            |
+   +--------------------------------------------+
+
+- service layer:
+  This layer is responsible for ensuring the communication protocol that is defined
+  for communication with firmware.
+
+  FW Communication protocol ensures two things:
+  - Serializing the messages to be sent over an MU.
+
+  - FW can handle one command message at a time.
+
+- c_dev:
+  This layer offers character device contexts, created as '/dev/<se>_mux_chx'.
+  Using these multiple device contexts that are getting multiplexed over a single MU,
+  userspace application(s) can call fops like write/read to send the command message,
+  and read back the command response message to/from Firmware.
+  fops like read & write use the above defined service layer API(s) to communicate with
+  Firmware.
+
+  Misc-device(/dev/<se>_mux_chn) synchronization protocol:
+
+                                Non-Secure               +   Secure
+                                                         |
+                                                         |
+                  +---------+      +-------------+       |
+                  | se_fw.c +<---->+imx-mailbox.c|       |
+                  |         |      |  mailbox.c  +<-->+------+    +------+
+                  +---+-----+      +-------------+    | MU X +<-->+ ELE |
+                      |                               +------+    +------+
+                      +----------------+                 |
+                      |                |                 |
+                      v                v                 |
+                  logical           logical              |
+                  receiver          waiter               |
+                     +                 +                 |
+                     |                 |                 |
+                     |                 |                 |
+                     |            +----+------+          |
+                     |            |           |          |
+                     |            |           |          |
+              device_ctx     device_ctx     device_ctx   |
+                                                         |
+                User 0        User 1       User Y        |
+                +------+      +------+     +------+      |
+                |misc.c|      |misc.c|     |misc.c|      |
+ kernel space   +------+      +------+     +------+      |
+                                                         |
+ +------------------------------------------------------ |
+                    |             |           |          |
+ userspace     /dev/ele_muXch0    |           |          |
+                          /dev/ele_muXch1     |          |
+                                        /dev/ele_muXchY  |
+                                                         |
+
+When a user sends a command to the firmware, it registers its device_ctx
+as waiter of a response from firmware.
+
+Enclave's Firmware owns the storage management, over Linux filesystem.
+For this c_dev provisions a dedicated slave device called "receiver".
+
+.. kernel-doc:: drivers/firmware/imx/se_fw.c
+   :export:

-- 
2.34.1


