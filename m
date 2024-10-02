Return-Path: <linux-kernel+bounces-347742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FFB98DDF2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBA121F23580
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D971D1E91;
	Wed,  2 Oct 2024 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dfdl3C36"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB02C1D173C
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880670; cv=fail; b=JZd7sTsfETLIPRAtsVil3NDGOVehqL4koSJXBkAksG/yVAtu0KC1EmIth6c1YFGY2zQfzcv/3f9S3MnqkBgyMsL+CzgtCsYdqRqzucoHSrECX50PY42PjbpmFtnvMhK9if/GG0wfqzYzJDhfvZqm+2aFwJc5VMHYpaEGTzhG76o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880670; c=relaxed/simple;
	bh=AHvZeWDy6/xYEqoA2DrJdTLBov3b0kSpblBok0ICshQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qNkW2MZ8lMatX1MGk59430vrvmEuY2JNDW4V72J7pjK/CYNVEPh/Cv7L1uPPQEhlUsVRTuFDXAEA93pc1oH93Z5JhJxJreA0Pa/5jGtx5aF8SV4s2PVnQDbr9M/CZl19Tn+4yH/iY5rtKTNtZTuww23o796+1R22lxXuA0iohG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dfdl3C36; arc=fail smtp.client-ip=40.107.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXCgQmjw4FqVXa+2pcHmMRHXwJlwNe/owNrJ7VKWnEIJtDc0/NnmTZUPwdIjSzL9qX+fhpmTOVUbbOJA2KGdKbT6qOQufvBovZYr6EGisFcBk6COx9VyXc3x89rC+fHGYwTN1VvsL7d0dVE8aj/dU2/Yvx/0IQimYrlk4NAOdWlBx6Hd/UNxfLXpfUxATddwIooQJ7UPuB87G5wqPoolLosV67g9/qgGLOhx0qZ8ZxxZJW7yBtesijBiRlVOwCAdhQyGqGJE1BY10xpueRbbF9wcUz/8tiJ0bfOXkVTU/TUmZECHlDva1xB1lg+xwKMWqfRFIrihjF4xsh6GITAUzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWw8O34Z1PaA0bIpNMoMDZht14UG39YKCT4LXoVb5rY=;
 b=lUGvaUtRRtHlk66NlAWYcun9d9Knf7vaFByYIoh4YVOMVDXHs9LxD1+N9vozXYvJQBcx6QJeqFU0xb0q5BtxliBuR97KWbJuX2XBi5rNCetxKuRsSTS0p9FTUmS8wU5P2dLGiaXMS6E+Le/juQE+y1s38SB8voipZKUTLGGFxXubIXbErgj2R68mjGXG9YGEGm+AyMdi9t3A3AFt4TludHEUKYOCxUq7sXINuk0PhLmtBmDg5PUz2MkIhCchH5rDqv+DYyyJNZuFKEuxgjTCA954+peu+42Ijl9yHc+FcxtZ8bm7GOsJLcs1ZH5uubLhEG6ECYhO62/Ocb1qGihhKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWw8O34Z1PaA0bIpNMoMDZht14UG39YKCT4LXoVb5rY=;
 b=dfdl3C36PIFZX14Mk4cVwg7Lm1AqK8VELgG+jXqq3Bg0A1eNPyt3ex03n+SKbJ1boWbKAGMu4EAYuQyOHwa2mdrkMf5uD8DcmkkuyYPS1d48Wes+6H4YbFV7hgB5DluKpQFcQEULNEFK+jSdtDnwjjfLszFhUx1Pg6jsKnUoeeQc672x8pvZjYrSt8nnU4Y7IKEB26oz+Wf6+YrjKdVp1KkRat8+w1WrjtBtcUhKbjnka0FgHYEWdL+TiHLwZGgdoXhPYUfEFyfzfrQOtkV2TKg49DLRDYg2xxAFz04D9o5H30ro2TJbG21qc9X73HEvap09nod9fmdw3pFvKzXRSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9699.eurprd04.prod.outlook.com (2603:10a6:20b:482::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Wed, 2 Oct
 2024 14:51:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Wed, 2 Oct 2024
 14:51:01 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 02 Oct 2024 10:50:36 -0400
Subject: [PATCH v6 4/6] i3c: master: svc: use spin_lock_irqsave at
 svc_i3c_master_ibi_work()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-svc-i3c-hj-v6-4-7e6e1d3569ae@nxp.com>
References: <20241002-svc-i3c-hj-v6-0-7e6e1d3569ae@nxp.com>
In-Reply-To: <20241002-svc-i3c-hj-v6-0-7e6e1d3569ae@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727880649; l=2752;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=AHvZeWDy6/xYEqoA2DrJdTLBov3b0kSpblBok0ICshQ=;
 b=E9naYrDh21bcxEeOMa+vTbTy6zWSgauI4eieu801Jp/W05Hufc/Xrb1eTHaMVezNDN0Y1sfVO
 2+1cW0Ih0TRAQOvFQxNuVyKgXv+9vzFnxgm8skshKaoPQkELanThnDT
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0177.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9699:EE_
X-MS-Office365-Filtering-Correlation-Id: 68d26252-9578-4d03-ed30-08dce2f1a1c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UlF2dkxMMlUrR2twR1JML3JXczZMWU94UnZNL092Sno4ejVDQjZacktjR1lh?=
 =?utf-8?B?aDdzN2k0UGpEV1YrWUt4TWpOeW12RmhjelhmcVRUQmFIM1JxZmRZM3hZS1Qy?=
 =?utf-8?B?KzNIZ052dUxidks2dUYvUHVUZnBIS2RhNTZTUDB4MHE2YloyNEpyZDNCV0ZS?=
 =?utf-8?B?MXJTaHZoT3IrQm5BWTl2UHVldTFlZEdCaXVLZ0dLU2V6RkJPZ2pDS3U3MHVH?=
 =?utf-8?B?T3dWVUhkQTI3N2tTUmExTld3bjlielJIcmpUQzRsTXZYL0dhNTRFSmRmeWU5?=
 =?utf-8?B?cDY1aGFVQzlnMTdqbVdPNjhzRmRHQVBvV1JSRDVDQUZwWW1naHBGWEhrOTRL?=
 =?utf-8?B?YmsvYkZzdWJjL3JMYWNPMUk4M3lJeUY4Rjh2MXlrOUNSR1A3dGxEMnpjeXNF?=
 =?utf-8?B?azlId0JEaURuZ0RrZnFHaWVxZTI2NndCMXMzTUdkdHlOSjNkY1pvWHQzQzZX?=
 =?utf-8?B?N0JXUjhoREY4UTZvcklZVmUxRlorcFkwb3RldlRJMEgybnhrRXhDVXUvMGcz?=
 =?utf-8?B?V3RHL1FGY041bjFGNjJ2V2tpckxMa1hFeFhLYlpaVm8yUzdyMmNtVEJnT3lJ?=
 =?utf-8?B?cmZqb1YwaFRIMlF0ZWJCdWNZYmc3U1NjU2Y4N2YxZTgrbTIyS2ZFYnVYbEdl?=
 =?utf-8?B?NWF5UEtUT2Z5MkJhTU5pdjBVOUNaaWVxUVZaNXpsZEZoYURhc0s5czJMRWdH?=
 =?utf-8?B?RjcxcFlVN0NnaWIyODZNZktwQkdDYzFlTGhwKytXc3NXR3R6QS9zby9zdHVL?=
 =?utf-8?B?eWIvRHhyMlpwQUlNYWkrSGx1ZzdzYk1VK0V3SUpyTVBxODI4UWpQVnUvQkNV?=
 =?utf-8?B?dDArZGNrT25zMmRlWGJhVEF0K21NWFBrL0ZFM0tFTVlTQmJhVk92WHh2SVgw?=
 =?utf-8?B?ckpHc3l1dHhmaEdULzQ5Z0pHTnQ5eGxyaHhWVUgxV1dIZGpMSDhMSURlTmxy?=
 =?utf-8?B?MjVZMzVMRW1SbVRYN1ZQM2g3V1ZUT2c4aEk5SnRVTlpEVWNJRStWRlArTVV4?=
 =?utf-8?B?ZldDY3NLV3BSaU5LcFpEYVNxUkgvUFovVG9xUjNTMlZ0ai82OFkyWFo2MWlu?=
 =?utf-8?B?QXAyelA2OGpGSm1ubHJqRUZ0ZXJXeU01Y2lFczNaY3RPbmhzeVRhUC8wVHZW?=
 =?utf-8?B?bG5KZEx1RTlLZ2lpZ0VCUjYyejlzcjRjWlNZRkJJcTdpL0lWWnNxcm45eTBQ?=
 =?utf-8?B?VmJLNW95Umd2M0t3dVRJNGg4Tm5IR2hLV3EyRzdZNFJ3N01xTlpQbElKdHBO?=
 =?utf-8?B?aW4rWjFUMGh0cmMwRTNiMzlJSnVPTkFiUWFkdzNoN1hUMWtPK3FkN2FaaSsr?=
 =?utf-8?B?YzhRRzB0R1NyMmdqajh2cXhqMm9kNDBnK0ZabzBwV28vN2NzS0pxaGsxaEIw?=
 =?utf-8?B?b1V6RnVDRVJobDl3NWtRQ3ZNTUVvT3prelVPUjVJdFg3TWlDek5wcXhTMWU5?=
 =?utf-8?B?eXE1R1did00rbVpVaktpdUdGRlkxbCs1djlvSVBrOThPUi9EMnhaSEErUTk4?=
 =?utf-8?B?SHYzYW0wK3Y1WnljMTFNRzNVRUh0bldBeWlNNEdJWDNEMG9uTnBsYmRYMTF6?=
 =?utf-8?B?UHFvT2tjN0NxdmtTRUNUQm5HZGlJV05kcExLOG4rK0g1Vnhtdml2RWtnV1V4?=
 =?utf-8?B?NHF1bFlpWWdYdTV2TzF6S2VjZXFZRDFLSk1BMmRUOHBTeDFKQldmY1FBLzBZ?=
 =?utf-8?B?UHpwWVZWdkw4a1Fob2ZhelFBRFg4cEVnSTdCRVhzdUNuUTZoYlViNHJDZFBq?=
 =?utf-8?B?cjgvYWxvQmN2YW44MytESUlCT1haQjVsV3BZNzl4RzRpTzBjL05NZDlqMkQy?=
 =?utf-8?B?cldJZzB1Tnd4dTdtamZ4QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFB4SGQxVkIyRjZTOTdmMG0yVElYQWp1NXhQTkRhSzY3MGhscGliNFV1M3Ba?=
 =?utf-8?B?T0lRMm1QeFEvY2pJeEtBWkJJektnL2tPdWRueGN1RDVVRmJqUVByVjl6M0p1?=
 =?utf-8?B?TU5HMkJkdWFRMFVFeDh0bDNmeVhpSHBIRDE0bjRxcXpoQ08yYytMeVJDVlZi?=
 =?utf-8?B?SVhIeEp3TkJSOWJKR3FtMGlxY1krbnRucngwY1dIQkpZLzBjMktKVGM3b01J?=
 =?utf-8?B?ZTBqdXVubitHR0xnamdFdmx5WThDNGtjTU9FeVRjV1Vhei9wNU9Ya3NrNmNP?=
 =?utf-8?B?dUNQMHVvVDRPbk0wZW5aTGtpOVZvNFpqMXVPbXF0OCs1MTJuQ1U3Znc5UHkw?=
 =?utf-8?B?ZDZGM25ZNE9TZndZVkFnajcwdGREekwzejFXdURsR0N4N0NGR2JReENHS3RY?=
 =?utf-8?B?SFBwTmhIYndtcmJQZEcyUDMzUjE2d1U4cmFpK0pLZ1lmaHNMbUYyWXB3SjBs?=
 =?utf-8?B?TkRYbFVaTnpleFljQ2FLUWh5SEZaL0pBVXVrMWtMUDFyQ0Y3TTBtanA3a0lR?=
 =?utf-8?B?NzVBM0lhdkE3STY0eUpka0I0a0ZKbmJmL3NWUDFyYitjaVhiS28rRGFmcDBF?=
 =?utf-8?B?d3FJZGFmM21TN0F6QnJaSlYzOHF2cVdBOE84SkpNM21XbnBjMXVDamdOUWNp?=
 =?utf-8?B?RXRuNm01ZzY1OUlDZFBIMUs0c1dIbldmOVNjVWxmeDlpN3NCWm90WUdVbC9a?=
 =?utf-8?B?WEViSytPcXFEL3NZWmw4MUFCU09kQVJ0RVduTjJyYVFiRGQvUU1hcGh4OHRp?=
 =?utf-8?B?WEdxcFByQnNWamEyMEVhZ2FnV3FvZWROSDNVQm40bmlDcnFZamM0N0hvZ1Rp?=
 =?utf-8?B?VEhvUW5GRjYyd0RxbzhMdU9neTNYVFk2YzJ4MnFzTXhMSnRERWl3ZVRBZ1dq?=
 =?utf-8?B?eVFGNFE5MjMvS2pRaWk2QUZQSTBDWVlGc2t3eXUySWlQTzQ5S1FMYU1xWUk1?=
 =?utf-8?B?TVRydy9GWnlpMkl2UGhPMkx5allidmVNcFNqMjhFY0EzbERVanhQN211M3Qx?=
 =?utf-8?B?ZE52RXJDblpLa0R1MGlYTHFDc1RYY0R1VmY4UXdINlh1VUNHR0JKcGttckJD?=
 =?utf-8?B?ckVreTU1UCtxMWc1TmVJY0Rwcm10V0crb0plYWx3bTdDUExkTURDWlhtd0lH?=
 =?utf-8?B?T3dzWGhmVVJ2bXFrazJhT0c2Q0tPMWk0VXp4MFVpeG9sU2tHbnUySmkrTGNE?=
 =?utf-8?B?VlZnVWlMRWhYS2VKWkdqOTBzdkozOW1CeFhyaXdMOEl1dVhXaWpwd3ZOZVE0?=
 =?utf-8?B?aUl0UkY2Vnc1TDNoYkRodldaRVdkZnIxeDVXNDE5SUh4d2IyYWsvUFZjdkdE?=
 =?utf-8?B?eVFlWEszT3FUSkVEcjZuZjdkeGFlby9zNGdObHZTUjRPWGNCd3k1dW9HaDAy?=
 =?utf-8?B?ZkdOcVExMjJrTjBENzhSaTFSZndxTkpRUE5FSnU5OGJ6cERQNjlJdHVZeGIz?=
 =?utf-8?B?V2kyNmFqSHBEb29vODFPcmJuZnN3c1U1amtxcnAwSTNkb3dYL1BXQTJ6L0lL?=
 =?utf-8?B?RWFod3U1K3pTdlBoZ2tVSlJUTTI4SUQ3VDFoY25NbG95b2gzc0F0RlJQb1Jp?=
 =?utf-8?B?QXN3WnhzQjdDYjJKOWlTZ3g5TllObXk1OU1ITnd4WGhZaG9SaFFpUlk1Y25i?=
 =?utf-8?B?a3dnbXNZYmlNLy84NEx6Ukd3V0llMUJVeUErL0thTE5jSDhQcnZNVXRkZU85?=
 =?utf-8?B?V3BYSUR4bVZ3b0srU3htVnFGdUF0T1VTUFJRMTh0V3JXRzRGeWxsT1JNWjY3?=
 =?utf-8?B?WlhjdE9Zc3FFbG12OVVseGJGcENmNUhSd3ljQ1B2TU90aWt2M0YwQ09iN0RS?=
 =?utf-8?B?OEIwOTcrZjgzNjNsZzBPYk1xN3d1VFBrV1NydW9pVGlKRWNIK2xYVTZoZ0RO?=
 =?utf-8?B?T2hIOE1pU1BaNmxEZXVjMlM5d0pMUmI4SHdCYnFJb1dscmYzSUVwcUhZb3l3?=
 =?utf-8?B?V24xYXFFWjRyWTlXeERzaVhjR0Q4enhoNTA1M0tEUTZzRWVRQlZrWWpSaitM?=
 =?utf-8?B?dnpCR1FRL3p3UzQxam9UY3lHZW9sS1Q3bis0c1RxQjZQRFJsWjBVeWdLdXlC?=
 =?utf-8?B?QnRjaWJkWGRnSnBBQVpNaHZCZHFBN0V2c0NOdktZakJoQk9KMnNPcTRvYlNp?=
 =?utf-8?Q?cfgL0aq+TCwEvud7Pm3lDtgqA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d26252-9578-4d03-ed30-08dce2f1a1c4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 14:51:00.9681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nL0mxQ1QKI3wM3AqqmtH9vozwrF+KuB6h+RSW2i3d7fg3rIHHtSNhfaeeMlanGNsedJJG7LhSBh/I4IPjKu8OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9699

According to I3C spec ver 1.1, 09-Jun-2021, section 5.1.2.5:

The I3C Controller shall hold SCL low while the Bus is in ACK/NACK Phase of
I3C/I2C transfer. But maximum stall time is 100us. The IRQs have to be
disabled to prevent schedule during the whole I3C transaction, otherwise,
the I3C bus timeout may happen if any irq or schedule happen during
transaction.

Replace mutex with spin_lock_irqsave() to avoid stalling SCL more than
100us.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v5 to v6
- reduce timeout to 100us, normal get IBIWIN at 9th SCL. 100us will timeout
by i3c spec.
Change from v3-v4
- improve commit message
- needn't mutex here, other place already use spin_lock_saveirq to protent
i3c transfer.
---
 drivers/i3c/master/svc-i3c-master.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 5df0ec02d73ce..ed3f1bfbea37a 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -436,7 +436,16 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 	u32 status, val;
 	int ret;
 
-	mutex_lock(&master->lock);
+	/*
+	 * According to I3C spec ver 1.1, 09-Jun-2021, section 5.1.2.5:
+	 *
+	 * The I3C Controller shall hold SCL low while the Bus is in ACK/NACK Phase of I3C/I2C
+	 * transfer. But maximum stall time is 100us. The IRQs have to be disabled to prevent
+	 * schedule during the whole I3C transaction, otherwise, the I3C bus timeout may happen if
+	 * any irq or schedule happen during transaction.
+	 */
+	guard(spinlock_irqsave)(&master->xferqueue.lock);
+
 	/*
 	 * IBIWON may be set before SVC_I3C_MCTRL_REQUEST_AUTO_IBI, causing
 	 * readl_relaxed_poll_timeout() to return immediately. Consequently,
@@ -456,8 +465,8 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 	       master->regs + SVC_I3C_MCTRL);
 
 	/* Wait for IBIWON, should take approximately 100us */
-	ret = readl_relaxed_poll_timeout(master->regs + SVC_I3C_MSTATUS, val,
-					 SVC_I3C_MSTATUS_IBIWON(val), 0, 1000);
+	ret = readl_relaxed_poll_timeout_atomic(master->regs + SVC_I3C_MSTATUS, val,
+					 SVC_I3C_MSTATUS_IBIWON(val), 0, 100);
 	if (ret) {
 		dev_err(master->dev, "Timeout when polling for IBIWON\n");
 		svc_i3c_master_emit_stop(master);
@@ -529,7 +538,6 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 
 reenable_ibis:
 	svc_i3c_master_enable_interrupts(master, SVC_I3C_MINT_SLVSTART);
-	mutex_unlock(&master->lock);
 }
 
 static irqreturn_t svc_i3c_master_irq_handler(int irq, void *dev_id)

-- 
2.34.1


