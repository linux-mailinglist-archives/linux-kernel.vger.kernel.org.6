Return-Path: <linux-kernel+bounces-180260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 306A88C6C25
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 20:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7FDE1F215F5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C791158DD7;
	Wed, 15 May 2024 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ql+d1CwD"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB42F158DA0;
	Wed, 15 May 2024 18:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715797749; cv=fail; b=jAXh6u9pfPvpIfCQy/ajgXUOIvqXHASQKtVHZuTPkMXZlDzc/VBbb2CEcAy2kIFk20ug+gmPh7yrYycLPTMddzuRb4V2oCqsVokN/vbcx59p9enRTcUPe6/lFuNHdjWd1NCAVIolMRKb7YiZurU+B75MhUXhSfHmqxK5HfNdj3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715797749; c=relaxed/simple;
	bh=h5+3od+vAluPvKY0oWa+4pGOeAQPdwWZG32+uinDJN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iVWamrTTpixgnR3DQ+7jpQfdTjEk7C91S7WYD6azg7qucnDLUno9ZP5VE8wd+g+AcRdoBwSi1TvmJE0rIt5Og4DiusjkQbiAq6dQ4MFDKbYWyamK0/caAKlIJ62tJaw8vyf9iQp41xenc62tDsUhaC8c7iHv+OfWpKZn0QwEdn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ql+d1CwD; arc=fail smtp.client-ip=40.107.22.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbTjg9R5OwVZaCaP0kzrqdnPetDgwACVK0ed2LmYXM5Chprsoq10mX+1E3mcFAZ+9vQOntd5t1xc5Yud+AH+/TW5lN33BodnCiJQKHtk4pFqKdYYlNALqMO3O03MHoZEPc+qaE/C6eUb7cQehul+mn7skmc1v+D9wslKjZhVpmX8WwpR2HGTITHuo3YkujLuXsZSm7yVp5Ry+jkO5cKjOYfM+F3/cEIaJ1Cv6bXz0j8agtMLdY1N12/JSFdh7YCl7evrzKG2WA154ImcAeBdCScErY5jt/ypj+cYvrfQj9kxil29YXP3zXVApQ54i2oKJa+EcQN3Lt6d2CqoUgF5og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzvBdoB7jxVrx4xPni29LI8xQnINbSqX38Fpj8kQldA=;
 b=ax31cwcftFdgVs6Q6JXZNGZ2K9FMhnfX51muOxJdwbY2IfeOKKqk87Lp+eyu27c8hnj/syWTmaikLW63dX9/PrTg67guzUI4qB2uLnfGolr9Pn5B6Sd2UL8YwjVadOCohAJWX40mgtSiZdPvJTVmCSVEAALPyeFyLi6f0rv48JAy0LWlF9x9KQJaRYio1JZP6HH6+KiRORj1YJaRA1Iiu2Q7oZY+Sr/5kvb+x958bCFsZTDUooVRlZWFZiRUd4l345Cufl2JkdSw7p5dSDnJgGdOKdHEhtnrI9PO+c2VThxp18C3sprOS2gtovx0D+C464j66uigwE5wDvUJtY6HQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzvBdoB7jxVrx4xPni29LI8xQnINbSqX38Fpj8kQldA=;
 b=ql+d1CwDdkkYTE8olgj/VU3GYkNjnAFnnVKr3LBP7T+YiucY+sC7eV/rKJj7MvRYl5EUsSzk8HbrsfLelwjghTQeWCpj1epAL+LBagh25ZrI5D4P7ThKPLLJxzeJEz/4/ZEYrYTcbkeC7PJDujEwVsYlqUPuCZXUJlFWKD8+kK4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB6897.eurprd04.prod.outlook.com (2603:10a6:208:184::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 18:29:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7587.026; Wed, 15 May 2024
 18:29:03 +0000
Date: Wed, 15 May 2024 14:28:51 -0400
From: Frank Li <Frank.li@nxp.com>
To: Conor Dooley <conor@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org,
	peng.fan@nxp.com, mturquette@baylibre.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	marex@denx.de, linux-clk@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, p.zabel@pengutronix.de
Subject: Re: [PATCH v3 3/6] dt-bindings: clock: imx8mp: Add reset-controller
 sub-node
Message-ID: <ZkT+4yUgcUdB/i2t@lizhi-Precision-Tower-5810>
References: <1715679210-9588-1-git-send-email-shengjiu.wang@nxp.com>
 <1715679210-9588-4-git-send-email-shengjiu.wang@nxp.com>
 <20240514-campus-sibling-21cdf4c78366@spud>
 <b86c83a520f0c45a60249468fa92b1de.sboyd@kernel.org>
 <CAA+D8ANTdvQJVtniyMtqjnJdT4qX+LDGjVuFO6H0RSO+GDw+ng@mail.gmail.com>
 <20240515-unbundle-bubble-8623b495a4f1@spud>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240515-unbundle-bubble-8623b495a4f1@spud>
X-ClientProxiedBy: BY3PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:a03:255::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB6897:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a6f3fbc-5eb6-468e-2d45-08dc750ce554
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|376005|52116005|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWpKUlVyZkR0Z2JpUmg5VUlxMTFreHZVRkJzZElvSlNRNjRUaXkyZzI0Q1pX?=
 =?utf-8?B?UlRmMFcwNWVTS1g4NFNvd0FtN0xpWVZvT1E1d01oeG5jMTZ1c2hGWTlVUmRD?=
 =?utf-8?B?R0RlSXRhdEFIbHE0UHdGd3BueGN1MFdoOGRrdWdjNU5leDFQWnhEU0hBckJs?=
 =?utf-8?B?cGU2ZjNJZ09sV2NrSnkzL3M3OEhQVXVmVzdsZFFzbHozc1B1ay9LY2wzdDJY?=
 =?utf-8?B?c1I3S0VuUFhRbzdEcHRKRWJoMHNtVlFqR1FjanFXeUxEazlweGxJOG4vVzYx?=
 =?utf-8?B?TTlRdFNrR21PVWxUNGI4eU41Wm9Ic2czM09NSVM0TVBMaGllbm90WnlLK1B2?=
 =?utf-8?B?NXZkU05wWHE2UFpDOVBTanpCbnNDUlluN2NUWE5aS2xFVHNVOGh5VUkrVGIy?=
 =?utf-8?B?VmhSSWhzRjFxRHhnYlAxbHNYbFNDdWlvRnlqMWcrclBoNXQrWjJRemJZS3ZE?=
 =?utf-8?B?OWdOc08zd0Y0SURqWXZ1Smd6UEZsS1lHSUM0THpTeGx2THh1QStqdW9sM1Iv?=
 =?utf-8?B?Ty9pVWxCaHFiU21GM1J3Z3F0aTVSbVM4MVErR0dyZ2N1eW1VTFhUUDVDVkJo?=
 =?utf-8?B?WUZjYTJBTGRQYXFuN3hRQk90S0w0OWMxUStlS3pmSjNoRnIzcFpTdmhLU0d3?=
 =?utf-8?B?MDQvUmhtemcyQ1duWDQ4bDdkYVZseUp3MjdVaWNaT1k5dUZiQUc2SjIwZndR?=
 =?utf-8?B?K1Zqa1QvdllLRVRvK3hQaHgrRVlFWklLMDBqa2ZSb01PdlhNSUh3R2k2K2ts?=
 =?utf-8?B?dGh2aEdTbjZCM3BIQ05rTWg1b2VybEtKWUhqNUNZMmRVZzNXYTNSYUJzSzJ2?=
 =?utf-8?B?cXRQRTVsUEJCVFhCSGk4K2FqcUVXTVQ4ekhkTXhhRlFpemJ6R3dGUFErWGs1?=
 =?utf-8?B?YWZUOU5kamdVQlJaOGFNUzVUc0c2bXFwbHphcFpMaS9yY2hWK2xsbG1tMDhj?=
 =?utf-8?B?VmN0MldwMUlLeUZCeWY2Y3Vad01Ja1lOZzBORVI4Q3pYNlRRSlVLT0M3ZG5m?=
 =?utf-8?B?VFV0dEpUSUdLRGFlTWp4MzdBRjU0M09LZ0NxS2NBODFacE1kdkxzazc5TUZn?=
 =?utf-8?B?TldKTVE5VUtRWGFrKzJ2Z3I3alg1aXB1Z05SbE5mMUwzME1TeDA1QjgxVXRN?=
 =?utf-8?B?bk4rYllZbVNMTXZuTXRxSHoreGltWmhSMVdXNkxzTjZOOW1GOU1xL1J0K2dp?=
 =?utf-8?B?OS9hWlkrdkFoMUhNZ1VVYTFhdDJ0YXhHaUt5Q0ZNd3dVWVBVM2lIZlMwSno5?=
 =?utf-8?B?dHovL2syeXowZktvOW9NeW5SejdpTUpxVmlkQU8rbGlQc2hrd1BBVU9IQ2dI?=
 =?utf-8?B?VjdreXBWUENDc2RVQUYzVVJ0LzFGbjl3QnlRZytaaFZPNktFbHpUdlVRaE9J?=
 =?utf-8?B?UUg0Q3FDREhKZElwN2M2bU15TzdwTmp2NkE5VWFJYlk4WmNTNjdHV3lKOUJh?=
 =?utf-8?B?ZWxtRittWUsrNmM0VXlMbjdUWUFiSmZLc2c1aGRHUHlzRHpWNXVxTmx1WENY?=
 =?utf-8?B?bW9VRUVlN1dNcHo5Zzl5d25IYnY2NEIyRG9ZZVJBMzhQU3RlTHR2aDZrUmRC?=
 =?utf-8?B?by9UeWhKdHNZNnNoMGdHVDhWeTluU3VvMkNOajRTREpOeGdtNEFjQ2poSk1Y?=
 =?utf-8?B?TTU2aVl1QXl5cmt0TWtudVBjRStEWDI3NGNUWjRFVFNMS3Uxd1F3NW5SU2pG?=
 =?utf-8?B?ek5GcEJONUtSa1JiekxuQXVxb2dSQ1l5NlMxV0hPKzRoZmMwTmNXdTZKWU5p?=
 =?utf-8?B?b01LY0VSLzFHLy9mNjFHNXBEUThBUUhLamZYaXl4cThMUjdJcHh4OHJ0Nk1m?=
 =?utf-8?B?dDJ0U1pFUEcxYnFEaWZUUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Unl4OGZrNURhcmY5T0JSQXhId25jNm5NSlFGZ1ZBMzFFV09DK01qMXVCL1VD?=
 =?utf-8?B?Y2h6MFI5aUhlWFBvU1M3MUI3Qzg0ZVJST1dNT1VWem5taDAraWJzSDUrd0xo?=
 =?utf-8?B?UFdSM2tGU2xpR05PdTQ5Q29DRzgvVHgzemRkdVBQZktGT1lkNEdmMUJ1eGtr?=
 =?utf-8?B?dmZkQmFhdCs0Mi9YMitwTFd2NnN1S0RRRSsrelc1dVVFeXlyWGpmR0xlYUZS?=
 =?utf-8?B?QlQ2MkN2Rk9MVXFiaWY1QkMyOEF6TklGL2tnSHRLL0I3RzZDbjdxS2lyVklx?=
 =?utf-8?B?WTVPdFZTRmFZczFKejBLTXRia0JEY1dHNXBJSnQ5SWlzR0R3b2lGZ1NZRkVK?=
 =?utf-8?B?UFV0eTdtaEpEb282VEtVTkV2WHNwQkdpZ0ovTzkxdG05OThEelcvR2xQWm1I?=
 =?utf-8?B?eUQ4RE1jZWwxYi8wR3hBMjd6R3BKSTlBbi9Maysxb3lJTWRFZWlkV2xSSnpa?=
 =?utf-8?B?ZUd6RS9QVFBTN2JRU1FSZDdPc0pVTmV1emVyeVh5ZFF6Yll5aVlyQjJtVlBT?=
 =?utf-8?B?YndrekhGMkN6Q05CbWdPbEpBUG9JMGxpZ3VaN3VDdUF1clhhYkdoVlZoRHBY?=
 =?utf-8?B?cUprZEVIZDVRUlhaeURvVUx6a3g1Ujl4MjVrb1FXc3lxNnovWkxITUtuR3Zl?=
 =?utf-8?B?NE1vQW1Sb25uelJ4WjJSZjUwVXUrM1IwTWhydnQwOEh4MHNZNHM1bGhoOENU?=
 =?utf-8?B?NGFCTnE5MUVSai90bjFwN0l4UG5reElRcnQzTk1XNmJUckRGajAwY1NkTnpG?=
 =?utf-8?B?cDBYK2w1MDRnZHBjZ0lxUitHcVEreXRjWlJPNkgzSURWS0FxeUdtRTlsVlNo?=
 =?utf-8?B?Q0g3NUVsdzkxaTNVMlVXWlFabERFbG83RHlaUW4zaG9VWWliVlFZcXJ0cXpl?=
 =?utf-8?B?c3I5Q2RnOXhlcWxTTElPRGJXRTJWYWxpdEZvZ1k4aVM4aUc4UHV1bGVUOGJ2?=
 =?utf-8?B?UjAyVDZrc2YvaFdMcFUyekxBUWViTXB4VjdIMTBLRkMweEF5eHVUbDBhM0to?=
 =?utf-8?B?UFRFVi9wMmQxaFVVMyszSU5TQ05GQThoVEZ3TFNwUlhHNm1vejN5elhrbHlS?=
 =?utf-8?B?Ri81Sm5aanBFRjNkekQwaENPRzBpVlhadFJURHlwWDFpZDhHK1ZyK0pXV1k3?=
 =?utf-8?B?RHRwRElQN0lMekIwZUN1cW9RY2V5cUdKSy9ITW5SK3FNdHQyNU1valAvL2Vy?=
 =?utf-8?B?OFN6d0o3MDdQeFRBU3NWTzlBaXNzSmRCaUNvSTlNN1RXNVBJSERJeGR4T3pi?=
 =?utf-8?B?ak5HYVFlN2oyTmEzemlHQS9OT0NNUHVaWHJFNEhmQjk5YWI2Nlg4aHJ1NXJF?=
 =?utf-8?B?SVVSYVRNOWZRVExrWG56U0NpMDZRZ3d1dFd4QWcrUWRJVWphblduaHJETG9O?=
 =?utf-8?B?c1NWMk5NVzVtOFJsNjFLMVFOMXUvZUNBcHFKb1hYNW01MWt3TGRZTlZWVnhM?=
 =?utf-8?B?dit1eER1c001Mk05N1pkdG1pTzlBWkg0MVg1ZC9VTGlNQjdybjFXWHdIdlNH?=
 =?utf-8?B?c0RRM05IVFFtYS9lTlhKTXdReXdFZzhMRWdUZkFQcXNzdEZudVZlVkMyL2I5?=
 =?utf-8?B?dHBWMzJjVUJQRFV6WHprVDNxWkRLOHBCeTJNR0VTOVlUVjJ4RDU0MlJjbXp0?=
 =?utf-8?B?ZCtnQ2x0cDg2U01XZldnYVpoOVc4ellPL0tYVUE4ZTdGdnFHRks3azdYVnNQ?=
 =?utf-8?B?MUoxTmFiMFRia052d2dTK2xZYzlYYTQ5alV6aG12SVc0aEhVSVlZRzZXT2ZB?=
 =?utf-8?B?STRGOENhT3RaQVZFTVdxaFpYbHpEVC80emdabHhJVGl2R2RQY0sxRExEc0NI?=
 =?utf-8?B?b0hiU2xwbWNFa0ZaMVdxS3hIM2dkZ0dNRnhBUjZtMlRBZE8xZ3h0RFplM0lL?=
 =?utf-8?B?MitPSVl2N1ZpQlU0c0JzRFZVVE5sQjlxNG1FNVVVUTMwUUZTUTgrdENsZEEv?=
 =?utf-8?B?SGZUYVQ2dXZHOXNjdDMyZWtKT3puOTg4bGN2OW5qdTYvalZqakNwY0Y0N09H?=
 =?utf-8?B?dTJZZ2pZRVBJdDhkQXNLeGo1a0wrVjNEVTJSMk9Fd1B0ditxdEdOZkZKQ0E5?=
 =?utf-8?B?Vi9lQXAzK0thcEQ2TWNjSDBkMGZnRWZ3aW40Vk53anpLU2ZEanJUTjRPWDk4?=
 =?utf-8?Q?W/lf+6YJ6OZDMZw4rAStjeeP4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a6f3fbc-5eb6-468e-2d45-08dc750ce554
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 18:29:02.8958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8PeknegfupEpiqxsKvHwGCTLOqdFxEW9QM3/J2euNUY3rHCwQX69KJaAd3axuhTtGDNZOQ+AMNJKScP0E6mLLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6897

On Wed, May 15, 2024 at 05:04:48PM +0100, Conor Dooley wrote:
> On Wed, May 15, 2024 at 10:47:57AM +0800, Shengjiu Wang wrote:
> > On Wed, May 15, 2024 at 5:09 AM Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > Quoting Conor Dooley (2024-05-14 11:06:14)
> > > > On Tue, May 14, 2024 at 05:33:27PM +0800, Shengjiu Wang wrote:
> > > > > diff --git a/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> > > > > index 0a6dc1a6e122..a403ace4d11f 100644
> > > > > --- a/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> > > > > +++ b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> > > > > @@ -15,7 +15,10 @@ description: |
> > > > >
> > > > >  properties:
> > > > >    compatible:
> > > > > -    const: fsl,imx8mp-audio-blk-ctrl
> > > > > +    items:
> > > > > +      - const: fsl,imx8mp-audio-blk-ctrl
> > > > > +      - const: syscon
> > > > > +      - const: simple-mfd
> > > > >
> > > > >    reg:
> > > > >      maxItems: 1
> > > > > @@ -44,6 +47,11 @@ properties:
> > > > >        ID in its "clocks" phandle cell. See include/dt-bindings/clock/imx8mp-clock.h
> > > > >        for the full list of i.MX8MP IMX8MP_CLK_AUDIOMIX_ clock IDs.
> > > > >
> > > > > +  reset-controller:
> > > > > +    type: object
> > > > > +    $ref: /schemas/reset/fsl,imx8mp-audiomix-reset.yaml#
> > > > > +    description: The child reset devices of AudioMIX Block Control.
> > > >
> > > > Why not just set #reset-cells = <1> in the existing node? IIRC it was
> > > > already suggested to you to do that and use auxdev to set up the reset
> > > > driver.
> > >
> > > Yes, do that.
> > 
> > Can I know why sub nodes can't be used? the relationship of parent and
> > child devices looks better with sub nodes.
> 
> That's pretty subjective. I don't think it looks better to have a clock
> node that is also a syscon with a reset child node as it is rather
> inconsistent.

I think it is multi function device syscon node. it should be like

mfd
{
	clock
	{
		...
	}

	reset
	{
		...
	}
}

clock and reset are difference device node with totally difference's
compatible string.

> > 
> > A further question is can I use the reset-ti-syscon? which is a generic reset
> > device for SoCs.  with it I don't even need to write a new reset device driver.
> > it is more simple.
> 
> That is for a TI SoC. You're working on an imx. I don't think that you
> should be using that...

I think this statement violate the linux basic reuse prinicple. If the
code logic are the same why need duplicate it just because it is difference
company. Of coures, if it is generic enough, it'd better to add a more
generic compatible string.

Frank


