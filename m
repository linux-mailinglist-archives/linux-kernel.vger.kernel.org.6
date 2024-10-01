Return-Path: <linux-kernel+bounces-346275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B25E798C224
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CBA41F25B7B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8821CBE96;
	Tue,  1 Oct 2024 16:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CDNwJYbG"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013043.outbound.protection.outlook.com [52.101.67.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5760E1CB527
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 16:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798629; cv=fail; b=OqgELBxMWjp3vKNf3PAUNZIB40y6tD0RNtttW6smljZIVrr3wuWGi4b5oyWdXjoeHu0KM92G4N8rRAu75te0L/oY5KwPb4v/1ZFifFqAHA1G09+zzZog96Jr0cP/q1UMcXuju3nlg6hbzm2Plfd26c98FC6PZyZ/tfc5MHvW0wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798629; c=relaxed/simple;
	bh=5hg7uu3KNVcviCnomxqa4vxVoteMSlT4Rrc8jGI+OEE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=oTpicHKHefmdWO2DBwovyM91o/cIzGcN3dxc6DNw/pnzSxpDKH5jQu7O6zriXi74+ysGi3whKjm+oLvur25bElqsvwgPatUcz3KVoQdBoCOUP1aNAE4kLpkKfV4I4z4mnqD40XRuoGw8geNgJpHkkhDGtezyXP//Eh5lVUIICGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CDNwJYbG; arc=fail smtp.client-ip=52.101.67.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SxvXFreaBpM3G/CMFh19pulmyk3nacLoVdqqKm125YUpGWJYyFwGaqiS6w+Kn3EqeO+MwJgoErzozcFN3zoGQoxBu4twSqEfRcgLfabp6EkJIdMvvl4xc7034tnwJORB5ya7E7a5qHDDrsgdSbudYRZjJNyOim5+w4eymCYEPgOAwKEgpFrdaE1X1NlHkhdqkTceSFEVMPwRqKt9Q1moLdNloz03O+uaj78DjYdl2eY3hVWv7n1vQoD+ZY5juCPCEinpXeLAWRm4fARscc7pd7RYDnC5u5aAQ7xW6AYJq50+EvVOURrveD0yMVm9x1PNgQaecpAO8LUbIoGlV8KKQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9oXAbN36WQRhBVwudaXIG+hmQyEgD5nBYHVHoW4R6ZU=;
 b=zOqb/is/KEKmmuQTK1EY7x9TmOY1xYNtFqoo0TyH6WkovQZPmzIQZNLCSeX69CjNUS0qmKCi+RtNOaI/h8H34Us4ZWz91QISgT1arNJngdc796TXqRkrfEnvI0n9GG78+qYyhDRBZvQRUUhjAyF1RVfiMKGjJuIsagaIsDIQTVScAPJlV/FpfJbHqqr6NYbFvuekaBtDkgjS24i2hp354fUrWWNUpE9u9yaDeaO4+ObxHPq8x8aoJmcWL/M2OcdsGbhnzmUzq3izO28lhPO0vDzQsJpYBAJX+vElzkHhyI2V97X997zE4SOuvOsdWdwuXpA5fMwcIt2kCcVsfwGPMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oXAbN36WQRhBVwudaXIG+hmQyEgD5nBYHVHoW4R6ZU=;
 b=CDNwJYbGk5I301mgOqUigMccxy8XvMlFvvnT+isNigR0KJ4pc22He4WeUcPfwQW3UM6FSXkbTMt9CvuBNhZI7OV8d/qDxmKg/DlcAPX+/0dm6Gzf4KIuJTBZ2OprkW2OQ3wLJ0/QhKoHg2ikU10c+9Q4QmlMmB2egtz744EDQhVwFztnhv26JLfJiF8Rweiiqg5ihUoPxNIoq1HucYl9lSm/tOtHLAgzWZo+GePcimvWkosaLZMT61WUNoDmahTOo5jLIUcTMBR9keyHABchtyZcQl2i69te8qpqbukZiNK3S4ZjRxPSBJsawnB11QSBSNoaflcD5Q4eHcvXFGAgPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7879.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 16:03:42 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Tue, 1 Oct 2024
 16:03:42 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 01 Oct 2024 12:02:52 -0400
Subject: [PATCH v5 3/6] i3c: master: svc: need check IBIWON for dynamtica
 address assign
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-svc-i3c-hj-v5-3-480ab8aed849@nxp.com>
References: <20241001-svc-i3c-hj-v5-0-480ab8aed849@nxp.com>
In-Reply-To: <20241001-svc-i3c-hj-v5-0-480ab8aed849@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727798616; l=1475;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=5hg7uu3KNVcviCnomxqa4vxVoteMSlT4Rrc8jGI+OEE=;
 b=RaGDDl3paO5Y3iPR8cn2q9wxLJBhgtjwir4nr0D2bSvHrSDguxriS7fWJcYgeM14dp8mFSeAw
 Xpm+72YuUc7CABna6aPBKgJEonTi710+PMi9NdOQdbTN8+mCt+s4Yl2
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1P222CA0045.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: 169f58d9-b9b5-40c7-8ed8-08dce2329f18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3VjVTZTSlg5QU5UbFFaSFJYRUFqRXlUR0twTzJsWERZV2dKQzJNM2djakds?=
 =?utf-8?B?QkRUVFJvak5qcEpkaGNMZUg5cWZmTGxiSzRaUzc0dDRJaTc3bnRnclE1cFIz?=
 =?utf-8?B?RFRYb0VDZlFTcm9hcU9nNHRIbm11MWRBaEl5TkN0L1lFdGlzd2puWmE3Ym0w?=
 =?utf-8?B?SXcrbHgvWm41RThHVTNJdWJsa3ZPU2s2MUhOWVFjNytmTlRESzlPU3ViRktl?=
 =?utf-8?B?Z1ExdllKM29xVXZuandRcHIyY01ibWMyQ1NVU3hXTnFBVDR0ZHVTK3FCYmJR?=
 =?utf-8?B?eVJHYWxKdnVMWmt5Y2xqeEpSS3JybkRsSXNLYVlGZ0VFTXJFM0dhSXU5Rzhv?=
 =?utf-8?B?Uzl5Tm9KWmYyVkN0c3FlNkJnR0hkVXVOTGZSK1FRRm8xaEszOGxqZ1N6dmE2?=
 =?utf-8?B?OVFMaEJXNEt4NFFkME5HbVZEeGJUSHJUVGJMd0orb29QZVp2VjlhZ2x4Qndu?=
 =?utf-8?B?M3grVVZrMk9nUHowMStKZkVrVXBoZWZJcW5teURlZ1hIY0NGNlZUOXpqcDFN?=
 =?utf-8?B?a1pxdnFEYVJ4TGhVclQ1UjlpZ3pvLytCK3Vrdkwvb3VzQ2N3WG1GSXhiUE1B?=
 =?utf-8?B?T2JFMjBLVzZuWFJ3bXA3anRoNHRIWDJMTTFSZi9TNlJqc09SWWdqNjA0VERp?=
 =?utf-8?B?eG1zWjEwQnRQM1JraE05ZDMyd2dmNkdNUXRyayt6N2N6N2FMSldRSUFESFkz?=
 =?utf-8?B?RnZQWE9jWmxmOVQrTVNjTExFcU9OSytjUUkvSVJQTFJKYk9XS3R6RkRqOVpx?=
 =?utf-8?B?c3JWNlFWUTc4M3U4cUVrYngxbXFxVXFFZzJCTnd4ektxdGRmRy9jWWM1TEZR?=
 =?utf-8?B?dXNYQmJVcitUQWFoeFJCdWFIdzZ3RGdaZjN2cUxWeUc3ZHJ0VU5QMWlFNS82?=
 =?utf-8?B?Z0NUaVRTektVRzhkd3UxbUNycVN0UTY2ekxNK0hnQitObWV2bXVQNTVubjRo?=
 =?utf-8?B?VVdXbGh0WS9SeFZMcjQrcGU5NWlWdzlleDR0MzBuclRoNUZsQlorSzE3SVhB?=
 =?utf-8?B?dXcxUWJwVkdhRitVQXQ5M3VMQ3ZzQkF1NXY1REZtNzhySmhqQ0JNK0pJWklY?=
 =?utf-8?B?OXhmUXhDMlo5S2lza2xLSXVjK3lzbVpvekNpaU1IU2ZwWnRKTndPdTFCc3pw?=
 =?utf-8?B?UXlDUWZyUUxpZXY1bmUyYUdEcEpRd21rdHZqU09sQXhpZVd2UG9Va2Fqb0Yr?=
 =?utf-8?B?RjFvUmpJdTFTaGtDWjE1MEdtMjlZZ1RSZDZRTWMwenpWc2JUOVdOZ3dONkUy?=
 =?utf-8?B?L3ZaR1BuSE5Zb3dLcGxsUW1xeGw1MmViQTk5Y0NVZGJ0VnhjQnU4RlhHaW14?=
 =?utf-8?B?VFNQWE5Hb2hVeVFmR1NDV1BWUUZDMElCd1VrclZiMHpsUnpHUFJSbHBwUmtv?=
 =?utf-8?B?RXRnNVF6KzlFazhaOC9zaXNZQy9iMWhjMGM0UzJwN20xUVJMd280bE93RWVw?=
 =?utf-8?B?MzQ2eFhmZmkvRCt6VUZDL2tyc3ZJRk5tbmNuTldjYmd2dXMxaVRjM3lHc2dL?=
 =?utf-8?B?RGg0RGQ3ejhyN3dCNGsvTjZFMkxoNHcvcG1RNUVFVEhZWkdHQU5WcHFCR3Zn?=
 =?utf-8?B?VksrNWtEQkpCQk54SjFzc3JXTEVqbGwxYS9kcFVBUUJ4a1FJN0RxMzdkVERK?=
 =?utf-8?B?c3FvNDVtcm5WOVRaZmtldG5USDRhM0pzd3FRNnRDZ0NSZE4rY1AxVGxJTzFG?=
 =?utf-8?B?L201R2ZzOE8zbXBya0Rjb2NJRUhwMVNUNEtEOVpyUU9xU2RWNk8xeUQ2T2JL?=
 =?utf-8?B?R1hUUTNEMVRtYzc1RGQ1b1NVR0hQdTJvVlZrZlNPRThqbEU2UGZWUUkzU2NQ?=
 =?utf-8?B?dzQvYWZjdW5zeERiWjlWZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1JMU2lQWTM1YU42Y3ZZbkt1T2NhMFNqWCsrcnpBTjAzbmRtaWtVZXF5eTZn?=
 =?utf-8?B?TnAzQzllRmM0RjJETWU4b1ZjUlZzNFJ2YS9JbDNIamw3NUVJbjVCN3BvSWMv?=
 =?utf-8?B?QkVLM1lyckZSUloyTVVORUlncFpySFhKUCtVMmw0cm0xak1HUEFsUGY4d3c3?=
 =?utf-8?B?bjRHM3FaN2xGbnR4K1JJR3NmVDE2M2t4WlkvbVJPWGFLLzVNWXVNbWdTWEFa?=
 =?utf-8?B?L3N5Uk1tUDYxSmRhRXpkNmdRcU5yL0I5RnFuNm4wdlN6YmRZbE1xQ1NBeXFo?=
 =?utf-8?B?SkYvR2orVEdESXlHZ25hVTRiUlBaZmtZZWIxcm1XUk53TGhGUzZBOWVyeGR5?=
 =?utf-8?B?enIwUmRiVk1Yc21EKzFnclAxL053cjAwZkZucVh6WjdPcytxQ09jMmcyWlNP?=
 =?utf-8?B?OHdBb0xWNUNTa3pnQjNYODR1VmJpdXkvRVphb3RTUFJQOEZCUndiZ2cvYVVY?=
 =?utf-8?B?a3ZKVE5XbER0b01EUjdUR1Y4OVJUaG5oMzEvSGZSQkFIY0s5c3JHbEx6MVI1?=
 =?utf-8?B?V25qQWtqcUtZak8rTUZvMklUa2EwdU4zMXNsZmtDOWZvcnZrM3luYmk2SXR2?=
 =?utf-8?B?REwySCtpckczM2R1dE9hUnlwSzZXYSs0RDhSOFNqM0ZCRHV5bC9LNVJFejRY?=
 =?utf-8?B?RlJHdUNmQWk1NXdxQ0M1dlFiQkZjRC9IbDRmSnVkWTRnTzgycUlhWll6YnFu?=
 =?utf-8?B?bllQQnlVV1VFdFN3Sk5ReWRIRDM4d2w4YzJVenluY2ViWFBqYUpnOWZ2OWU0?=
 =?utf-8?B?WGVFSUlIL3VGMmJ2OVBGaHpWY3hhT242dG1UZmQxeEllNXlBUlFuUXI2ZFQv?=
 =?utf-8?B?K0FEcnpYNUdreGZVem5VMDRnbnZGeW5kaUhFME9qYnBXK3pjeHRXNGpLa3Rj?=
 =?utf-8?B?ZHZwamZDQVgvUHBhdEhEUXNCTk84bGdhNHE0enFTcTdlSURMcTY4blo4QmNB?=
 =?utf-8?B?VUN2K0Y2VzJURXIveHJrZTRacURFbXJ0VndtRm5HT1hEWWhtM25VaTA1ZEFw?=
 =?utf-8?B?ZlJkdUtTb1pPaENDMEZxMmg0blV4eFhEakpCd3hPUnZoVkZaUDliWWRzSlEz?=
 =?utf-8?B?Z0tmbitucm8ydWRTN3hNb0ZKclZucElPbHppN2Q1bjZOM2Y5dC9hMlFBRWJZ?=
 =?utf-8?B?U2xnZ0ZURVhLR0pYbXJrREJRMjFwN1hSaW5GZkUvUFFiYWpRREVmSFFmd0Ro?=
 =?utf-8?B?OGxoQmFvUU1MR3p3RHRxNE5GTEx4Q2pKMHkvamsrbS9OVzcxejFoYWZlSXZn?=
 =?utf-8?B?WHZObmVUNXkrRVk1TXJaQnVQT1E3dE9NTW9tSm5oalRORzE1K3pYdkdLaGdx?=
 =?utf-8?B?cW1JaDJXeGNSTkdhQk9YWG1SUmtyQ2RETTA4ZXZVTGlzUWRpUExXNVNxWWNX?=
 =?utf-8?B?NU4wMThBNzVVVU4wYlQ4THBTY2U0WmJadjRoY3NOWEM2c3pyTnMveFI1T1Bw?=
 =?utf-8?B?SThwY0lXNTRoUGlocWU4VFpzaVJvaldBZ1BhNFF5SHprWEFBaWhlQW91RHN3?=
 =?utf-8?B?dW8xQjhXQzF1Z1o0QUtRNnFDeUswT1IrMFd4d1ZVLy8vM2lkTTJTTWRmaG1D?=
 =?utf-8?B?NWExSXhWaTI2UkRtLzRyQzlnYjRQVkFhNTVoV09mcWVLY043K3pXaUpWUEpY?=
 =?utf-8?B?YkgvbWlPRUk3TFVsTGx0ekR5UWNQVTBVTmFBdHYwb0tqZENLTklYVGErN0dw?=
 =?utf-8?B?cjRQV3IySUt5OEVkdnhuVC9sQXdNamN3ZDlVVWo3SXhJK1NJZ0VwTiswbVdW?=
 =?utf-8?B?R0ZwSWUzVmtvTkdXNGkrVktDUjdNSExxMEtvcWhVbVdDS213WmFFeE53a1dz?=
 =?utf-8?B?OHhzSXZLSzZBQ2ZVS1prbU1lOEFDRXYvYXFKaGVuUWt3YjcxNWw5UU5VS1g3?=
 =?utf-8?B?NUVBNFlEUjdTSElQWno1Z1V6aTY5RHZIV3JMRDkyOEwwQXFsRGExQUVZa1lB?=
 =?utf-8?B?WHg0VS9JYzNDd2IwQXVSRDFya1ordmRlS0l2L2ZtZXdNOURVMVBsS1NmM1FM?=
 =?utf-8?B?ZmdpemVURmpzcFVYVjN1N1VDZHExaXkrWllQTEpZQUsya3Vhd0Rpalk5OUI1?=
 =?utf-8?B?ZUo4aVdZaXoyZWNnNGppZStDUkJEdll1SFJDMklkeFg3L1Rya0hqT3NneENM?=
 =?utf-8?Q?KP5A=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 169f58d9-b9b5-40c7-8ed8-08dce2329f18
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 16:03:42.6151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RXb26tUBbJMkf3/v4WYjv5UPJATZbsSAaiUOFv+WD0oglBzG4vulw50lUTm7B88JzKTxdwpRSY92dX0ZDgJK3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7879

When sending REQUEST_PROC_DAA, emit START and address 7E. Address
arbitration may occur at this time if other devices trigger HJ, IBI, or
CR events.

When IBIWON happen during a REQUEST_PROC_DAA, NACK the IBI request then
send a repeated start to continue current dynamtica address assign.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v3 to v4
- rework commit message
---
 drivers/i3c/master/svc-i3c-master.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index c35a228f0c2f4..5df0ec02d73ce 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -872,6 +872,9 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 	int ret, i;
 
 	while (true) {
+		/* clean SVC_I3C_MINT_IBIWON w1c bits */
+		writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
+
 		/* SVC_I3C_MCTRL_REQUEST_PROC_DAA have two mode, ENTER DAA or PROCESS DAA.
 		 *
 		 * ENTER DAA:
@@ -923,6 +926,9 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 			ret = svc_i3c_master_readb(master, data, 2);
 			if (ret)
 				break;
+		} else if (SVC_I3C_MSTATUS_IBIWON(reg)) {
+			svc_i3c_master_handle_ibi_won(master, reg);
+			continue;
 		} else if (SVC_I3C_MSTATUS_MCTRLDONE(reg)) {
 			if (SVC_I3C_MSTATUS_STATE_IDLE(reg) &&
 			    SVC_I3C_MSTATUS_COMPLETE(reg)) {

-- 
2.34.1


